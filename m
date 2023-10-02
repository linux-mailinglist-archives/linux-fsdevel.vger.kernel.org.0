Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 884767B5213
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Oct 2023 14:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236870AbjJBME1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Oct 2023 08:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236710AbjJBME0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Oct 2023 08:04:26 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9011BD7;
        Mon,  2 Oct 2023 05:04:22 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2bffa8578feso262154441fa.2;
        Mon, 02 Oct 2023 05:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696248261; x=1696853061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IGACCsg3UM6EsxzbZiA0PNBwClTCH2lKbZ4vIrPYp88=;
        b=jsQFfozjoKrdLnNo+X4itPRvuTaNI/Ox56+aMbqjkUeC0ziQTVcy/6xP6IRMfdVhTY
         ICIDF+bvAoXBpyYxZtfOFGzMhUOYQ0BXA/oJVXmsVIeE3NeIAQYU/HVWj57yfclWskm4
         amU6i12RkcuvxQFOe7bJak6wIg2SDcz5L+WJ1NmdSRzfQcH4a0paqChKRtsD6xFzTeA7
         7WZwLaGdYZENqd9Qb6AdnxY/uf/ZF1fDtcrcXjEgheGqwJ0URNjnOimYvhSV8b8wss+E
         5stGMRpev5lGahzlOlKG5ONZTIyrG+rU7+ZNjBvY5y7cJInkFqOLmET4XI5X16kz14+X
         UTUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696248261; x=1696853061;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IGACCsg3UM6EsxzbZiA0PNBwClTCH2lKbZ4vIrPYp88=;
        b=dFr0BbXo3rnZiAI++cmGDQSFp0uRm8mFY35fPkod7/RVNO0fTvnOEFGuXZpmB0FOLV
         nvybmXkey65HZpCP8VJpr2bhcULSwPDEmMIp4fNPNTKIg/+u09SIHlr3nufiOIfQtU9s
         U02f2LuavYmWBtiEOG7VuIT8yez6sclKcoMmH0yHKMIqddWkgsr+IxkStYkQEiEZLyBO
         X93y0NcC+G4XsmgN9XecE5ItytiFM8dIzXUCSI5Lw0mg1zay629zEdTvFFRDcajc5GGh
         EBqEiaka1t97+8pCKCBErXYWyS+6cfvH0Sdy0U8exp/8nCKWif7v2YhPALmhphVU5GPC
         sjWw==
X-Gm-Message-State: AOJu0YyKIt5vw3Og5v2jPOca3RD0nVLWpzveqDarGXmbjoODEXHHwVC3
        I2ZLWsQYxkcfgi9NB2aj6F1n/WluMGI=
X-Google-Smtp-Source: AGHT+IF4GKbJCjbjprr5a4ktq1UCOHZx0uqtEAkkHmlFgrt2Qo0YBObwWc+00rsEFUmLsCShow18SA==
X-Received: by 2002:a2e:9e01:0:b0:2bb:9847:d96e with SMTP id e1-20020a2e9e01000000b002bb9847d96emr9221930ljk.9.1696248260433;
        Mon, 02 Oct 2023 05:04:20 -0700 (PDT)
Received: from amir-ThinkPad-T480.ctera.local (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
        by smtp.gmail.com with ESMTPSA id m7-20020a2e9107000000b002b9b9fd0f92sm5084037ljg.105.2023.10.02.05.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 05:04:20 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH] overlayfs: make use of ->layers safe in rcu pathwalk
Date:   Mon,  2 Oct 2023 15:04:13 +0300
Message-Id: <20231002120413.880734-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

ovl_permission() accesses ->layers[...].mnt; we can't have ->layers
freed without an RCU delay on fs shutdown.

Fortunately, kern_unmount_array() that is used to drop those mounts
does include an RCU delay, so freeing is delayed; unfortunately, the
array passed to kern_unmount_array() is formed by mangling ->layers
contents and that happens without any delays.

The ->layers[...].name string entries are used to store the strings to
display in "lowerdir=..." by ovl_show_options().  Those entries are not
accessed in RCU walk.

Move the name strings into a separate array ofs->config.lowerdirs and
reuse the ofs->config.lowerdirs array as the temporary mount array to
pass to kern_unmount_array().

Reported-by: Al Viro <viro@zeniv.linux.org.uk>
Link: https://lore.kernel.org/r/20231002023711.GP3389589@ZenIV/
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Miklos,

Please review my proposal to fix the RCU walk race pointed out by Al.
I have already tested it with xfstests and I will queue it in ovl-fixes
to get more exposure in linux-next.

Thanks,
Amir.

 fs/overlayfs/ovl_entry.h | 10 +---------
 fs/overlayfs/params.c    | 17 +++++++++--------
 fs/overlayfs/super.c     | 18 +++++++++++-------
 3 files changed, 21 insertions(+), 24 deletions(-)

diff --git a/fs/overlayfs/ovl_entry.h b/fs/overlayfs/ovl_entry.h
index e9539f98e86a..d82d2a043da2 100644
--- a/fs/overlayfs/ovl_entry.h
+++ b/fs/overlayfs/ovl_entry.h
@@ -8,6 +8,7 @@
 struct ovl_config {
 	char *upperdir;
 	char *workdir;
+	char **lowerdirs;
 	bool default_permissions;
 	int redirect_mode;
 	int verity_mode;
@@ -39,17 +40,8 @@ struct ovl_layer {
 	int idx;
 	/* One fsid per unique underlying sb (upper fsid == 0) */
 	int fsid;
-	char *name;
 };
 
-/*
- * ovl_free_fs() relies on @mnt being the first member when unmounting
- * the private mounts created for each layer. Let's check both the
- * offset and type.
- */
-static_assert(offsetof(struct ovl_layer, mnt) == 0);
-static_assert(__same_type(typeof_member(struct ovl_layer, mnt), struct vfsmount *));
-
 struct ovl_path {
 	const struct ovl_layer *layer;
 	struct dentry *dentry;
diff --git a/fs/overlayfs/params.c b/fs/overlayfs/params.c
index b9355bb6d75a..95b751507ac8 100644
--- a/fs/overlayfs/params.c
+++ b/fs/overlayfs/params.c
@@ -752,12 +752,12 @@ void ovl_free_fs(struct ovl_fs *ofs)
 	if (ofs->upperdir_locked)
 		ovl_inuse_unlock(ovl_upper_mnt(ofs)->mnt_root);
 
-	/* Hack!  Reuse ofs->layers as a vfsmount array before freeing it */
-	mounts = (struct vfsmount **) ofs->layers;
+	/* Reuse ofs->config.lowerdirs as a vfsmount array before freeing it */
+	mounts = (struct vfsmount **) ofs->config.lowerdirs;
 	for (i = 0; i < ofs->numlayer; i++) {
 		iput(ofs->layers[i].trap);
+		kfree(ofs->config.lowerdirs[i]);
 		mounts[i] = ofs->layers[i].mnt;
-		kfree(ofs->layers[i].name);
 	}
 	kern_unmount_array(mounts, ofs->numlayer);
 	kfree(ofs->layers);
@@ -765,6 +765,7 @@ void ovl_free_fs(struct ovl_fs *ofs)
 		free_anon_bdev(ofs->fs[i].pseudo_dev);
 	kfree(ofs->fs);
 
+	kfree(ofs->config.lowerdirs);
 	kfree(ofs->config.upperdir);
 	kfree(ofs->config.workdir);
 	if (ofs->creator_cred)
@@ -949,16 +950,16 @@ int ovl_show_options(struct seq_file *m, struct dentry *dentry)
 	struct super_block *sb = dentry->d_sb;
 	struct ovl_fs *ofs = OVL_FS(sb);
 	size_t nr, nr_merged_lower = ofs->numlayer - ofs->numdatalayer;
-	const struct ovl_layer *data_layers = &ofs->layers[nr_merged_lower];
+	char **lowerdatadirs = &ofs->config.lowerdirs[nr_merged_lower];
 
-	/* ofs->layers[0] is the upper layer */
-	seq_printf(m, ",lowerdir=%s", ofs->layers[1].name);
+	/* lowerdirs[] starts from offset 1 */
+	seq_printf(m, ",lowerdir=%s", ofs->config.lowerdirs[1]);
 	/* dump regular lower layers */
 	for (nr = 2; nr < nr_merged_lower; nr++)
-		seq_printf(m, ":%s", ofs->layers[nr].name);
+		seq_printf(m, ":%s", ofs->config.lowerdirs[nr]);
 	/* dump data lower layers */
 	for (nr = 0; nr < ofs->numdatalayer; nr++)
-		seq_printf(m, "::%s", data_layers[nr].name);
+		seq_printf(m, "::%s", lowerdatadirs[nr]);
 	if (ofs->config.upperdir) {
 		seq_show_option(m, "upperdir", ofs->config.upperdir);
 		seq_show_option(m, "workdir", ofs->config.workdir);
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 905d3aaf4e55..3fa2416264a4 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -572,11 +572,6 @@ static int ovl_get_upper(struct super_block *sb, struct ovl_fs *ofs,
 	upper_layer->idx = 0;
 	upper_layer->fsid = 0;
 
-	err = -ENOMEM;
-	upper_layer->name = kstrdup(ofs->config.upperdir, GFP_KERNEL);
-	if (!upper_layer->name)
-		goto out;
-
 	/*
 	 * Inherit SB_NOSEC flag from upperdir.
 	 *
@@ -1125,7 +1120,8 @@ static int ovl_get_layers(struct super_block *sb, struct ovl_fs *ofs,
 		layers[ofs->numlayer].idx = ofs->numlayer;
 		layers[ofs->numlayer].fsid = fsid;
 		layers[ofs->numlayer].fs = &ofs->fs[fsid];
-		layers[ofs->numlayer].name = l->name;
+		/* Store for printing lowerdir=... in ovl_show_options() */
+		ofs->config.lowerdirs[ofs->numlayer] = l->name;
 		l->name = NULL;
 		ofs->numlayer++;
 		ofs->fs[fsid].is_lower = true;
@@ -1370,8 +1366,16 @@ int ovl_fill_super(struct super_block *sb, struct fs_context *fc)
 	if (!layers)
 		goto out_err;
 
+	ofs->config.lowerdirs = kcalloc(ctx->nr + 1, sizeof(char *), GFP_KERNEL);
+	if (!ofs->config.lowerdirs) {
+		kfree(layers);
+		goto out_err;
+	}
 	ofs->layers = layers;
-	/* Layer 0 is reserved for upper even if there's no upper */
+	/*
+	 * Layer 0 is reserved for upper even if there's no upper.
+	 * For consistency, config.lowerdirs[0] is NULL.
+	 */
 	ofs->numlayer = 1;
 
 	sb->s_stack_depth = 0;
-- 
2.34.1

