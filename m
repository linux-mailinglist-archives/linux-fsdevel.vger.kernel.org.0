Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9BEB5004E0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Apr 2022 05:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235289AbiDNEAJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Apr 2022 00:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiDNEAI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Apr 2022 00:00:08 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A961EAD6;
        Wed, 13 Apr 2022 20:57:44 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BC4D121607;
        Thu, 14 Apr 2022 03:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1649908662; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=2H9CaxklyDAJLGL4FtyBvmjheljZo4+V4Lxk2wsGl1E=;
        b=s379EHVwfEPC+UxmS6ZdE5iX4K5azANvXaJg9Xi5znQZocDobrVbNRmc+ux5xY43WEM5XO
        4wyU+Lgzn5PUnj9O0Pbfdvv9HkB+w4qbmXWVUBG/A7YpRPop5FgoL6B24lIVZG926QTYfx
        yt+AQ/aDU+mHweZ08yv+AG8qvLPFx1E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1649908662;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=2H9CaxklyDAJLGL4FtyBvmjheljZo4+V4Lxk2wsGl1E=;
        b=fJ7wGxdqhIvDNH5xr3UZuNeHSG4o0NOyfanWK3KQCtkwq+IT6uyMi8615jemR5AL6qH8OZ
        D6rknhH08Le4mCCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 91CCB134D9;
        Thu, 14 Apr 2022 03:57:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xJaTE7SbV2K0FwAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 14 Apr 2022 03:57:40 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     Linus Torvalds <linus@torvalds.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     David Disseldorp <ddiss@suse.de>, Jeff Layton <jlayton@redhat.com>,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH resend] VFS: filename_create(): fix incorrect intent.
Date:   Thu, 14 Apr 2022 13:57:35 +1000
Message-id: <164990865594.11576.14265561452573398586@noble.neil.brown.name>
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
lookup, with the expectation that a subsequent call to create the
target will be made, and the lookup can be combined with the creation.
In the case with a trailing '/' and no LOOKUP_DIRECTORY, that call is never
made.  Instead filename_create() sees that the dentry is not (yet)
positive and returns -ENOENT - even though the directory actually
exists.

So only set LOOKUP_CREATE|LOOKUP_EXCL if there really is an intent
to create, and use the absence of these flags to decide if -ENOENT
should be returned.

Note that filename_parentat() is only interested in LOOKUP_REVAL, so we
split that out and store it in 'reval_flag'.
__lookup_hash() then gets reval_flag combined with whatever create flags
were determined to be needed.

Reviewed-by: David Disseldorp <ddiss@suse.de>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/namei.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 3f1829b3ab5b..509657fdf4f5 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3673,18 +3673,14 @@ static struct dentry *filename_create(int dfd, struct=
 filename *name,
 {
 	struct dentry *dentry =3D ERR_PTR(-EEXIST);
 	struct qstr last;
+	bool want_dir =3D lookup_flags & LOOKUP_DIRECTORY;
+	unsigned int reval_flag =3D lookup_flags & LOOKUP_REVAL;
+	unsigned int create_flags =3D LOOKUP_CREATE | LOOKUP_EXCL;
 	int type;
 	int err2;
 	int error;
-	bool is_dir =3D (lookup_flags & LOOKUP_DIRECTORY);
=20
-	/*
-	 * Note that only LOOKUP_REVAL and LOOKUP_DIRECTORY matter here. Any
-	 * other flags passed in are ignored!
-	 */
-	lookup_flags &=3D LOOKUP_REVAL;
-
-	error =3D filename_parentat(dfd, name, lookup_flags, path, &last, &type);
+	error =3D filename_parentat(dfd, name, reval_flag, path, &last, &type);
 	if (error)
 		return ERR_PTR(error);
=20
@@ -3698,11 +3694,13 @@ static struct dentry *filename_create(int dfd, struct=
 filename *name,
 	/* don't fail immediately if it's r/o, at least try to report other errors =
*/
 	err2 =3D mnt_want_write(path->mnt);
 	/*
-	 * Do the final lookup.
+	 * Do the final lookup.  Suppress 'create' if there is a trailing
+	 * '/', and a directory wasn't requested.
 	 */
-	lookup_flags |=3D LOOKUP_CREATE | LOOKUP_EXCL;
+	if (last.name[last.len] && !want_dir)
+		create_flags =3D 0;
 	inode_lock_nested(path->dentry->d_inode, I_MUTEX_PARENT);
-	dentry =3D __lookup_hash(&last, path->dentry, lookup_flags);
+	dentry =3D __lookup_hash(&last, path->dentry, reval_flag | create_flags);
 	if (IS_ERR(dentry))
 		goto unlock;
=20
@@ -3716,7 +3714,7 @@ static struct dentry *filename_create(int dfd, struct f=
ilename *name,
 	 * all is fine. Let's be bastards - you had / on the end, you've
 	 * been asking for (non-existent) directory. -ENOENT for you.
 	 */
-	if (unlikely(!is_dir && last.name[last.len])) {
+	if (unlikely(!create_flags)) {
 		error =3D -ENOENT;
 		goto fail;
 	}
--=20
2.35.2

