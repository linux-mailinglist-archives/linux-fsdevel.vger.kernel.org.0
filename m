Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9244F8C0F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Apr 2022 05:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233664AbiDHCN6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Apr 2022 22:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiDHCN6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Apr 2022 22:13:58 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC9823AFBB;
        Thu,  7 Apr 2022 19:11:55 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id a38so3770811qkp.5;
        Thu, 07 Apr 2022 19:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dKIfSJ4IWaVGr7yR5YeTRm1BmHoNWFn5MvTethYbLJo=;
        b=PW2DohTzlmEc+B4EAVzk1YxlUb9ydH12TSb0s/pvgiDv5Wn1QGpIpIOXHc7c/+rBSr
         YeePfWWdP6CSTGUU3DA76tCvjKgBS7CxxJmsgV9VV0fUXHSdh6B7VzYWFf5zWcMM349g
         Ro5rKl0Gscl1TsPJNzkYemNRgJp+vjH7Mjs+8M4oFhEqGjQcI5WQGyBlT6esEwGKFrJ5
         Q4rDh6IAkLTipngg4E1HOF6pZe9X2u5E7r9xWYuQd75PVI+SHt21Z4keV7DpWGwAu8/p
         k6RD1v3tClaOUxc0fUgGKRls+u/slpQkJEMKmwUwmxuMPnR6XN2qshmZ1PYjrnR8QgDS
         EMbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dKIfSJ4IWaVGr7yR5YeTRm1BmHoNWFn5MvTethYbLJo=;
        b=pVnxkhjWk8f/FoYe41blpnT0kuh87H8YtSv0tqS/9ROws95j3LRdYnC+o+3kK7sj0C
         PM6VFSSJEKoeCO0PKLAg1Y7n9YCrdav5ew+IzVNfNV1pQRU9PnCCDmjZrZcAtEkLIvfY
         EqsY6UMHgIb0p1yVtFMtbMnWrf3o09qTG/jBKmf1D29z5ftTo6EELuP1K1WKgS2cNVHV
         35V60eFsZ/jBDMKx9oi10Ee8lfxO0d0B1i4fX0atgiIrQkN6CyOLb3ethx5xg22JuGMR
         YaLanevIsYR8q/G75kv+VVIzBIE6DbgLtEYE1E3MYuSeIcA820CBPvNi12yekDFZgHV7
         Juog==
X-Gm-Message-State: AOAM5305KjEaaoqSy9m1iPh10aCRGxl0aNTM+d9+V15Dvm/Q7QPUzk5Y
        nOOoEghL6pYxDUC1CsaV9/w=
X-Google-Smtp-Source: ABdhPJyOwjkr/l7RR4KlPoSKT7cWkib7NEVhOobuqOTGZ4Y3Nn4TovO2hNKoV+uH2XyAZKipJP3Z+w==
X-Received: by 2002:a37:e307:0:b0:67d:374c:aba1 with SMTP id y7-20020a37e307000000b0067d374caba1mr11179686qki.752.1649383915140;
        Thu, 07 Apr 2022 19:11:55 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id d2-20020ac85ac2000000b002e1cc2d363asm17551038qtd.24.2022.04.07.19.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 19:11:54 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: lv.ruyi@zte.com.cn
To:     dsterba@suse.com, tytso@mit.edu
Cc:     clm@fb.com, josef@toxicpanda.com, sfrench@samba.org,
        matthew.garrett@nebula.com, jk@ozlabs.org, ardb@kernel.org,
        adilger.kernel@dilger.ca, rpeterso@redhat.com, agruenba@redhat.com,
        viro@zeniv.linux.org.uk, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-efi@vger.kernel.org,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com,
        linux-fsdevel@vger.kernel.org, Lv Ruyi <lv.ruyi@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH v2] fs: remove unnecessary conditional
Date:   Fri,  8 Apr 2022 02:11:36 +0000
Message-Id: <20220408021136.2493147-1-lv.ruyi@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Lv Ruyi <lv.ruyi@zte.com.cn>

iput() has already handled null and non-null parameter, so it is no
need to use if().

This patch remove all unnecessary conditional in fs subsystem.
No functional changes.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
---
chang log: v1 -> v2
change subject from "remove redundant judgment" to
"remove unnecessary conditional", and combine into a patch.
---
 fs/btrfs/relocation.c | 3 +--
 fs/btrfs/tree-log.c   | 3 +--
 fs/cifs/dir.c         | 3 +--
 fs/efivarfs/inode.c   | 3 +--
 fs/ext4/fast_commit.c | 3 +--
 fs/ext4/namei.c       | 3 +--
 fs/gfs2/super.c       | 3 +--
 fs/namei.c            | 3 +--
 8 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 50bdd82682fa..edddd93d2118 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3846,8 +3846,7 @@ struct inode *create_reloc_inode(struct btrfs_fs_info *fs_info,
 	btrfs_end_transaction(trans);
 	btrfs_btree_balance_dirty(fs_info);
 	if (err) {
-		if (inode)
-			iput(inode);
+		iput(inode);
 		inode = ERR_PTR(err);
 	}
 	return inode;
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 273998153fcc..c46696896f03 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -894,8 +894,7 @@ static noinline int replay_one_extent(struct btrfs_trans_handle *trans,
 	btrfs_update_inode_bytes(BTRFS_I(inode), nbytes, drop_args.bytes_found);
 	ret = btrfs_update_inode(trans, root, BTRFS_I(inode));
 out:
-	if (inode)
-		iput(inode);
+	iput(inode);
 	return ret;
 }
 
diff --git a/fs/cifs/dir.c b/fs/cifs/dir.c
index ce9b22aecfba..f952b50590e2 100644
--- a/fs/cifs/dir.c
+++ b/fs/cifs/dir.c
@@ -401,8 +401,7 @@ cifs_do_create(struct inode *inode, struct dentry *direntry, unsigned int xid,
 out_err:
 	if (server->ops->close)
 		server->ops->close(xid, tcon, fid);
-	if (newinode)
-		iput(newinode);
+	iput(newinode);
 	goto out;
 }
 
diff --git a/fs/efivarfs/inode.c b/fs/efivarfs/inode.c
index 939e5e242b98..ad2e5c63062a 100644
--- a/fs/efivarfs/inode.c
+++ b/fs/efivarfs/inode.c
@@ -119,8 +119,7 @@ static int efivarfs_create(struct user_namespace *mnt_userns, struct inode *dir,
 out:
 	if (err) {
 		kfree(var);
-		if (inode)
-			iput(inode);
+		iput(inode);
 	}
 	return err;
 }
diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 3d72565ec6e8..e85d351a1a31 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -1659,8 +1659,7 @@ static int ext4_fc_replay_create(struct super_block *sb, struct ext4_fc_tl *tl,
 	set_nlink(inode, 1);
 	ext4_mark_inode_dirty(NULL, inode);
 out:
-	if (inode)
-		iput(inode);
+	iput(inode);
 	return ret;
 }
 
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index e37da8d5cd0c..2fd3b24a21cd 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -3363,8 +3363,7 @@ static int ext4_symlink(struct user_namespace *mnt_userns, struct inode *dir,
 	err = ext4_add_nondir(handle, dentry, &inode);
 	if (handle)
 		ext4_journal_stop(handle);
-	if (inode)
-		iput(inode);
+	iput(inode);
 	goto out_free_encrypted_link;
 
 err_drop_inode:
diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index 90db4a289269..a1d94013b96d 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -1451,8 +1451,7 @@ extern void free_local_statfs_inodes(struct gfs2_sbd *sdp)
 	list_for_each_entry_safe(lsi, safe, &sdp->sd_sc_inodes_list, si_list) {
 		if (lsi->si_jid == sdp->sd_jdesc->jd_jid)
 			sdp->sd_sc_inode = NULL; /* belongs to this node */
-		if (lsi->si_sc_inode)
-			iput(lsi->si_sc_inode);
+		iput(lsi->si_sc_inode);
 		list_del(&lsi->si_list);
 		kfree(lsi);
 	}
diff --git a/fs/namei.c b/fs/namei.c
index 29414d1867fb..b1d93b2fc3b0 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4214,8 +4214,7 @@ int do_unlinkat(int dfd, struct filename *name)
 		dput(dentry);
 	}
 	inode_unlock(path.dentry->d_inode);
-	if (inode)
-		iput(inode);	/* truncate the inode here */
+	iput(inode);	/* truncate the inode here */
 	inode = NULL;
 	if (delegated_inode) {
 		error = break_deleg_wait(&delegated_inode);
-- 
2.25.1


