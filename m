Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E627B4ED27F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Mar 2022 06:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbiCaEMk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Mar 2022 00:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbiCaEMa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Mar 2022 00:12:30 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08810109A7A;
        Wed, 30 Mar 2022 20:53:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8AF441F869;
        Thu, 31 Mar 2022 03:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1648698792; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=fe9jQftNyc0Y0493gOi7jED/OpJJXfPYMRr0C3GL7WE=;
        b=0PkbxnrxFxuw3JNzcIlJcD7t4od8Ks3ZF8nWz67UZvC52D5zVOgf2qDKNsQhJRgvUZMyCU
        s8YLkOOOXi6/hSHMX/JAsx5YeSYl/J5wAgSA3xG0wSQuAccZrBnqthu1dIspIO6RM4/Bno
        nHb2PhJXFFHLbcOaVDRqKk5bs3WgXj0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1648698792;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=fe9jQftNyc0Y0493gOi7jED/OpJJXfPYMRr0C3GL7WE=;
        b=koIpOhp7jJmNlY0vxYmpQNyRG+OkDMyQdv9RUNBp6+9UtZvzfnyMotitKOThlTCaO61hm2
        Za6TFqpVXIIujzAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 96DBA133B6;
        Thu, 31 Mar 2022 03:53:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qE5HFKYlRWJJBgAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 31 Mar 2022 03:53:10 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        David Disseldorp <ddiss@suse.de>
Subject: [PATCH v2] VFS: filename_create(): fix incorrect intent.
Date:   Thu, 31 Mar 2022 14:53:04 +1100
Message-id: <164869878475.25542.14478885718949986319@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


When asked to create a path ending '/', but which is not to be a
directory (LOOKUP_DIRECTORY not set), filename_create() will never try
to create the file.  If it doesn't exist, -ENOENT is reported.

However, it still passes LOOKUP_CREATE|LOOKUP_EXCL to the filesystems
->lookup() function, even though there is no intent to create.  This is
misleading and can cause incorrect behaviour.

If you try
   ln -s foo /path/dir/

where 'dir' is a directory on an NFS filesystem which is not currently
known in the dcache, this will fail with ENOENT.
As the name is not in the dcache, nfs_lookup gets called with
LOOKUP_CREATE|LOOKUP_EXCL and so it returns NULL without performing any
lookup, with the expectation that as subsequent call to create the
target will be made, and the lookup can be combined with the creation.
In the case with a trailing '/' and no LOOKUP_DIRECTORY, that call is never
made.  Instead filename_create() sees that the dentry is not (yet)
positive and returns -ENOENT - even though the directory actually
exists.

So only set LOOKUP_CREATE|LOOKUP_EXCL if there really is an intent
to create, and use the absence of these flags to decide if -ENOENT
should be returned.

Note that we now leave LOOKUP_DIRECTORY in lookup_flags as passed to
->lookup etc.  This seems more consistent with the comment which says
that only LOOKUP_REVAL and LOOKUP_DIRECTORY are relevant, and makes the
code a little cleaner.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/namei.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 3f1829b3ab5b..6d337d951dd2 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3676,13 +3676,12 @@ static struct dentry *filename_create(int dfd, struct=
 filename *name,
 	int type;
 	int err2;
 	int error;
-	bool is_dir =3D (lookup_flags & LOOKUP_DIRECTORY);
=20
 	/*
 	 * Note that only LOOKUP_REVAL and LOOKUP_DIRECTORY matter here. Any
 	 * other flags passed in are ignored!
 	 */
-	lookup_flags &=3D LOOKUP_REVAL;
+	lookup_flags &=3D LOOKUP_REVAL | LOOKUP_DIRECTORY;
=20
 	error =3D filename_parentat(dfd, name, lookup_flags, path, &last, &type);
 	if (error)
@@ -3698,9 +3697,11 @@ static struct dentry *filename_create(int dfd, struct =
filename *name,
 	/* don't fail immediately if it's r/o, at least try to report other errors =
*/
 	err2 =3D mnt_want_write(path->mnt);
 	/*
-	 * Do the final lookup.
+	 * Do the final lookup.  Request 'create' only if there is no trailing
+	 * '/', or if directory is requested.
 	 */
-	lookup_flags |=3D LOOKUP_CREATE | LOOKUP_EXCL;
+	if (!last.name[last.len] || (lookup_flags & LOOKUP_DIRECTORY))
+		lookup_flags |=3D LOOKUP_CREATE | LOOKUP_EXCL;
 	inode_lock_nested(path->dentry->d_inode, I_MUTEX_PARENT);
 	dentry =3D __lookup_hash(&last, path->dentry, lookup_flags);
 	if (IS_ERR(dentry))
@@ -3716,7 +3717,7 @@ static struct dentry *filename_create(int dfd, struct f=
ilename *name,
 	 * all is fine. Let's be bastards - you had / on the end, you've
 	 * been asking for (non-existent) directory. -ENOENT for you.
 	 */
-	if (unlikely(!is_dir && last.name[last.len])) {
+	if (!likely(lookup_flags & LOOKUP_CREATE)) {
 		error =3D -ENOENT;
 		goto fail;
 	}
--=20
2.35.1

