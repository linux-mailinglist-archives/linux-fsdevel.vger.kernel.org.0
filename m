Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30B275B7DD3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Sep 2022 02:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbiINAOx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Sep 2022 20:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiINAOv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Sep 2022 20:14:51 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B681B799
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Sep 2022 17:14:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5314A5C88C;
        Wed, 14 Sep 2022 00:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1663114489; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vs1O1TlBzIcc9ThZ8NVXNLBcG/Pj1qxyXSiSaBGcYR0=;
        b=PqkMPVB+OTZY5ft7VjY2axGaiCN8Y8AWTe3rJf6sIPzNjjkIaomedRxtw0/mk/V2M/GlvQ
        OYs46/kd/Ow96BjScZUBDs0A2DvBk/Z4JaxaGinMm3+mpO5oN/uFzNtjtP+GwcSWVI66zi
        Conmnj9MVRU7ODUcDv67gxba9owKs7g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1663114489;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vs1O1TlBzIcc9ThZ8NVXNLBcG/Pj1qxyXSiSaBGcYR0=;
        b=93ima9O/Ly/1GVfI9ZahFNLdWVbKRj6W73dJfaiQJUy5/REz2wiZ+TB9AuIai+m4tFe59e
        9AdqXc5bqwMzQYCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DF2D0139B3;
        Wed, 14 Sep 2022 00:14:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2xK2JfccIWM1dAAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 14 Sep 2022 00:14:47 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Al Viro" <viro@zeniv.linux.org.uk>
Cc:     "Miklos Szeredi" <mszeredi@redhat.com>,
        "Xavier Roche" <xavier.roche@algolia.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] vfs: fix link vs. rename race
In-reply-to: <YyAX2adCGec95qXn@ZenIV>
References: <20220221082002.508392-1-mszeredi@redhat.com>,
 <166304411168.30452.12018495245762529070@noble.neil.brown.name>,
 <YyATCgxi9Ovi8mYv@ZenIV>, <YyAX2adCGec95qXn@ZenIV>
Date:   Wed, 14 Sep 2022 10:14:44 +1000
Message-id: <166311448437.20483.2299581036245030695@noble.neil.brown.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 13 Sep 2022, Al Viro wrote:
> On Tue, Sep 13, 2022 at 06:20:10AM +0100, Al Viro wrote:
>=20
> > > Alternately, lock the "from" directory as well as the "to" directory.
> > > That would mean using lock_rename() and generally copying the structure
> > > of do_renameat2() into do_linkat()
> >=20
> > Ever done cp -al?  Cross-directory renames are relatively rare; cross-dir=
ectory
> > links can be fairly heavy on some payloads, and you'll get ->s_vfs_rename=
_mutex
> > held a _lot_.
> >=20
> > > I wonder if you could get a similar race trying to create a file in
> > > (empty directory) /tmp/foo while /tmp/bar was being renamed over it.
> >=20
> > 	Neil, no offense, but... if you have plans regarding changes in
> > directory locking, you might consider reading through the file called
> > Documentation/filesystems/directory-locking.rst
> >=20
> > 	Occasionally documentation is where one could expect to find it...
>=20
> ... and that "..." above should've been ";-)" - it was not intended as
> a dig, especially since locking in that area has subtle and badly
> underdocumented parts (in particular, anything related to fh_to_dentry(),
> rules regarding the stability of ->d_name and ->d_parent, mount vs. dentry
> invalidation and too many other things), but the basic stuff like that
> is actually covered.
>=20
> FWIW, the answer to your question is that the victim of overwriting
> rename is held locked by caller of ->rename(); combined with the lock
> held on directory by anyone who modifies it that prevents the race
> you are asking about.
>=20
> See
>         if (!is_dir || (flags & RENAME_EXCHANGE))
>                 lock_two_nondirectories(source, target);
>         else if (target)
>                 inode_lock(target);
> in vfs_rename().
>=20

I don't think those locks address the race I was thinking of.

Suppose a /tmp/shared-dir is an empty directory and one thread runs
  rename("/tmp/tmp-dir", "/tmp/shared-dir")
while another thread runs
  open("/tmp/shared-dir/Afile", O_CREAT | O_WRONLY)

If the first wins the file is created in what was tmp-dir.
If the second wins, the rename fails because shared-dir isn't empty.

But they can race.  The open completes the lookup of /tmp/share-dir and
holds the dentry, but the rename succeeds with inode_lock(target) in the
code fragment you provided above before the open() can get the lock.
By the time open() does get the lock, the dentry it holds will be marked
S_DEAD and the __lookup_hash() will fail.
So the open() returns -ENOENT - unexpected.

Test code below, based on the test code for the link race.

I wonder if S_DEAD should result in -ESTALE rather than -ENOENT.
That would cause the various retry_estale() loops to retry the whole
operation.  I suspect we'd actually need more subtlety than just that
simple change, but it might be worth exploring.

NeilBrown


/* Linux rename vs. create race condition.
 * Rationale: both (1) moving a directory to an empty target and
 *   (2) creating a file in the target can race.
 * The create should always succeed, but there should always be
 * directory there, either old or new.
 * The rename might fail if the target isn't empty.
 * Sample file courtesy of Xavier Grand at Algolia
 * g++ -pthread createbug.c -o createbug
 */

#include <thread>
#include <unistd.h>
#include <assert.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <iostream>
#include <string.h>

static const char* producedDir =3D "/tmp/shared-dir";
static const char* producedTmpDir =3D "/tmp/new-dir";
static const char* producedThreadFile =3D "/tmp/shared-dir/Afile";

bool createFile(const char* path)
{
	const int fdOut =3D open(path,
			       O_WRONLY | O_CREAT | O_TRUNC | O_EXCL | O_CLOEXEC,
			       S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP | S_IROTH | S_IWOTH);
	if (fdOut < 0)
		return false;
	assert(write(fdOut, "Foo", 4) =3D=3D 4);
	assert(close(fdOut) =3D=3D 0);
	return true;
}

void func()
{
	int nbSuccess =3D 0;
	// Loop producedThread create file in dir
	while (true) {
		if (createFile(producedThreadFile) !=3D true) {
		std::cout << "Failed after " << nbSuccess << " with " << strerror(errno) <<=
 std::endl;
			exit(EXIT_FAILURE);
		} else {
			nbSuccess++;
		}
		unlink(producedThreadFile);
	}
}

int main()
{
	// Setup env
	rmdir(producedTmpDir);
	unlink(producedThreadFile);
	rmdir(producedDir);
	mkdir(producedDir, 0777);

	// Async thread doing a hardlink and moving it
	std::thread t(func);
	// Loop creating a .tmp and moving it
	while (true) {
		assert(mkdir(producedTmpDir, 0777) =3D=3D 0);
		while (rename(producedTmpDir, producedDir) !=3D 0)
			unlink(producedThreadFile);
	}
	return 0;
}
