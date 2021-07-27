Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4D983D8337
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jul 2021 00:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233003AbhG0Wm5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jul 2021 18:42:57 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:53912 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232464AbhG0Wm4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jul 2021 18:42:56 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 538B21FF40;
        Tue, 27 Jul 2021 22:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1627425775; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BdWc5KqmXjzy1xBY7ficQJMIpIg+XlTLtZTRBW7cd2M=;
        b=HABFOC4ZUavNpgxB2HVyXBMgaS6Q0CxRT601I6yALwsJ3RFmpKH+40SVn6iVfkZf1j4yxM
        BLihlT307OKP6/2DXCcW7LJzm60YQefxFR0lZoyIYFqG+PcEW8yrxS2T32HjRXGH3PP/Et
        /jINM8iA6J1ebllkcAysubXJOvJEdT4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1627425775;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BdWc5KqmXjzy1xBY7ficQJMIpIg+XlTLtZTRBW7cd2M=;
        b=Kh8V08OHt4aWrNeeRMdcdZ6KDLpUOgOCYz8tY0tv+Z9uvMwSrpgqwuLpTEfdbbj7Tkb3BR
        dMdbzhGJeN7G7mCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5E88413A5D;
        Tue, 27 Jul 2021 22:42:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ksqPB+yLAGGlVQAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 27 Jul 2021 22:42:52 +0000
Subject: [PATCH 03/11] VFS: pass lookup_flags into follow_down()
From:   NeilBrown <neilb@suse.de>
To:     Christoph Hellwig <hch@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Date:   Wed, 28 Jul 2021 08:37:45 +1000
Message-ID: <162742546550.32498.10582545131617192944.stgit@noble.brown>
In-Reply-To: <162742539595.32498.13687924366155737575.stgit@noble.brown>
References: <162742539595.32498.13687924366155737575.stgit@noble.brown>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A future patch will want to trigger automount (LOOKUP_AUTOMOUNT) on some
follow_down calls, so allow a flag to be passed.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/namei.c            |    6 +++---
 fs/nfsd/vfs.c         |    2 +-
 include/linux/namei.h |    2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index bf6d8a738c59..cea0e9b2f162 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1395,11 +1395,11 @@ EXPORT_SYMBOL(follow_down_one);
  * point, the filesystem owning that dentry may be queried as to whether the
  * caller is permitted to proceed or not.
  */
-int follow_down(struct path *path)
+int follow_down(struct path *path, unsigned int lookup_flags)
 {
 	struct vfsmount *mnt = path->mnt;
 	bool jumped;
-	int ret = traverse_mounts(path, &jumped, NULL, 0);
+	int ret = traverse_mounts(path, &jumped, NULL, lookup_flags);
 
 	if (path->mnt != mnt)
 		mntput(mnt);
@@ -2736,7 +2736,7 @@ int path_pts(struct path *path)
 
 	path->dentry = child;
 	dput(parent);
-	follow_down(path);
+	follow_down(path, 0);
 	return 0;
 }
 #endif
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index a224a5e23cc1..7c32edcfd2e9 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -65,7 +65,7 @@ nfsd_cross_mnt(struct svc_rqst *rqstp, struct dentry **dpp,
 			    .dentry = dget(dentry)};
 	int err = 0;
 
-	err = follow_down(&path);
+	err = follow_down(&path, 0);
 	if (err < 0)
 		goto out;
 	if (path.mnt == exp->ex_path.mnt && path.dentry == dentry &&
diff --git a/include/linux/namei.h b/include/linux/namei.h
index be9a2b349ca7..8d47433def3c 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -70,7 +70,7 @@ extern struct dentry *lookup_one_len_unlocked(const char *, struct dentry *, int
 extern struct dentry *lookup_positive_unlocked(const char *, struct dentry *, int);
 
 extern int follow_down_one(struct path *);
-extern int follow_down(struct path *);
+extern int follow_down(struct path *, unsigned int);
 extern int follow_up(struct path *);
 
 extern struct dentry *lock_rename(struct dentry *, struct dentry *);


