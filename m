Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26E7E4E8B57
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Mar 2022 02:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232506AbiC1A6h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 27 Mar 2022 20:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233105AbiC1A6f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 27 Mar 2022 20:58:35 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 270F01E3DB;
        Sun, 27 Mar 2022 17:56:55 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3B5C6210DC;
        Mon, 28 Mar 2022 00:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1648429014; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=oey14VnM0lqn7DuaY04BOcOUPaGD3+e90gcYRjgmGd4=;
        b=2Cp5uTfL8j0hN/FhrpXLFFgATThyr7pue7+bPKJLMywuTEACXT0BIpmCz/aS2vnMh1IzAE
        O2fK8MEqfMBVHWG2y2yOlzZxA0qIQdeYGpOYXGfcqFPe6O80IbS+LyRBRUy01QIgbrTg1t
        T05p+2IdgnAwAYthugG4tLWNnq7oELA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1648429014;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=oey14VnM0lqn7DuaY04BOcOUPaGD3+e90gcYRjgmGd4=;
        b=mBBHQUvkEWVrCVr6/i5W0bEkotsmUXIRk0dcmiWsBqIsbsXt6r0crFHehThwIfj3DYBlGY
        ht5FL6lljkj4xsBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C9C5513A72;
        Mon, 28 Mar 2022 00:56:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id abkyIdQHQWJKKAAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 28 Mar 2022 00:56:52 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] VFS: filename_create(): fix incorrect intent.
Date:   Mon, 28 Mar 2022 11:56:48 +1100
Message-id: <164842900895.6096.10753358086437966517@noble.neil.brown.name>
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

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/namei.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 3f1829b3ab5b..3ffb42e56a8e 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3676,7 +3676,6 @@ static struct dentry *filename_create(int dfd, struct f=
ilename *name,
 	int type;
 	int err2;
 	int error;
-	bool is_dir =3D (lookup_flags & LOOKUP_DIRECTORY);
=20
 	/*
 	 * Note that only LOOKUP_REVAL and LOOKUP_DIRECTORY matter here. Any
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

