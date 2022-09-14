Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C11005B86AB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Sep 2022 12:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbiINKvf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Sep 2022 06:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbiINKvT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Sep 2022 06:51:19 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E187B7A7
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Sep 2022 03:51:02 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id o23so12888280pji.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Sep 2022 03:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=q3TsfZkeKJw5XNsDWUMmFDs6Gnk1XCvOAhXnXaSVyI4=;
        b=05u3YH9R0psRe49MO2FNU8/5dfjtU6+uA3PESMKlS7YdPzozmMNv6CugV4OxDP/9qa
         7XoEXoB3qcWpKYfZnhvS7qMIKQ6O29eYjYHE2HTXR6BhgbzG6FQpmmwIJzcKbE1d7pvx
         3DGyqwP+3s5UBMrH0K5OXRRcb0SBYu+G1eMuJXb9/ybkkUH41iO6yqo26f7Zz5GC42Pi
         8dzPXef/azuIbsGrG6WIxcrSlwv/r2YMGF2ViVMNyn1ehUXLHrXo0HS9mZSX/2HFioBJ
         fnHgiAMK/irWYa+C5+YiEhjlvG6iI9yoVNpw6dqtXSdpfps0lWx/L/3ePy1N+gMmPQep
         c6pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=q3TsfZkeKJw5XNsDWUMmFDs6Gnk1XCvOAhXnXaSVyI4=;
        b=Tcq5fhBCKvan/NbMHS7PtEVCWrXwWNQPauF4AhnQ3YViTetIMmhZSXxmt4P7Fi/+eU
         vKzssCy0Am/6Qx4nK2O/aqM2rpAyHjt82lxqOlzDEwc18tTB3xwAw3chEAanGQK4OZaj
         4G1rxVYXjxOIyIXRrgOgNOoIdL0QVfeJhPTGhlRDKUyFNeJbgTyh5HFLdkMmdGjy9wAT
         g570oxzjuAFTOdExiLQEcrrb4V2nNTQCGy8/H1WSPvQRXDWBPR8KAnms+yIOtEH9MDkL
         20ap1ZkLBJtk17QIwaBlPhPBXK9mqbCV+RG5F0kjPei1ndNtygUXkfXvQJKrbDEFwAcK
         VFeA==
X-Gm-Message-State: ACrzQf0AdKxYMVvv+eB4/Jvjlebxx/gDulsz7jSoR4peJm4U9FQFk7Jw
        mmBhlY1jGzxelLwGc78NSfTIIA==
X-Google-Smtp-Source: AA6agR7NDk5OHRM9Rd6OftgJi3/gHYY1TyxgEHCKEeThw53Wb1mA8mROSozj5Sh4+p9vi/4BBbPuig==
X-Received: by 2002:a17:90b:3808:b0:202:c5ba:d71b with SMTP id mq8-20020a17090b380800b00202c5bad71bmr4102692pjb.18.1663152661702;
        Wed, 14 Sep 2022 03:51:01 -0700 (PDT)
Received: from C02G705SMD6V.bytedance.net ([2400:8800:1f02:83:4000:0:1:2])
        by smtp.gmail.com with ESMTPSA id x13-20020a170902ec8d00b0016dc2366722sm10537042plg.77.2022.09.14.03.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 03:51:01 -0700 (PDT)
From:   Jia Zhu <zhujia.zj@bytedance.com>
To:     linux-erofs@lists.ozlabs.org, xiang@kernel.org, chao@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yinxin.x@bytedance.com, jefflexu@linux.alibaba.com,
        huyue2@coolpad.com, Jia Zhu <zhujia.zj@bytedance.com>
Subject: [PATCH V3 3/6] erofs: introduce 'domain_id' mount option
Date:   Wed, 14 Sep 2022 18:50:38 +0800
Message-Id: <20220914105041.42970-4-zhujia.zj@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20220914105041.42970-1-zhujia.zj@bytedance.com>
References: <20220914105041.42970-1-zhujia.zj@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Introduce 'domain_id' mount option to enable shared domain sementics.
In which case, the related cookie is shared if two mountpoints in the
same domain have the same data blob. Users could specify the name of
domain by this mount option.

Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
---
 fs/erofs/internal.h |  1 +
 fs/erofs/super.c    | 17 +++++++++++++++++
 fs/erofs/sysfs.c    | 19 +++++++++++++++++--
 3 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index aa71eb65e965..2d129c6b3027 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -76,6 +76,7 @@ struct erofs_mount_opts {
 #endif
 	unsigned int mount_opt;
 	char *fsid;
+	char *domain_id;
 };
 
 struct erofs_dev_context {
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 7aa57dcebf31..856758ee4869 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -440,6 +440,7 @@ enum {
 	Opt_dax_enum,
 	Opt_device,
 	Opt_fsid,
+	Opt_domain_id,
 	Opt_err
 };
 
@@ -465,6 +466,7 @@ static const struct fs_parameter_spec erofs_fs_parameters[] = {
 	fsparam_enum("dax",		Opt_dax_enum, erofs_dax_param_enums),
 	fsparam_string("device",	Opt_device),
 	fsparam_string("fsid",		Opt_fsid),
+	fsparam_string("domain_id",	Opt_domain_id),
 	{}
 };
 
@@ -568,6 +570,16 @@ static int erofs_fc_parse_param(struct fs_context *fc,
 			return -ENOMEM;
 #else
 		errorfc(fc, "fsid option not supported");
+#endif
+		break;
+	case Opt_domain_id:
+#ifdef CONFIG_EROFS_FS_ONDEMAND
+		kfree(ctx->opt.domain_id);
+		ctx->opt.domain_id = kstrdup(param->string, GFP_KERNEL);
+		if (!ctx->opt.domain_id)
+			return -ENOMEM;
+#else
+		errorfc(fc, "domain_id option not supported");
 #endif
 		break;
 	default:
@@ -695,6 +707,7 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 	sb->s_fs_info = sbi;
 	sbi->opt = ctx->opt;
 	ctx->opt.fsid = NULL;
+	ctx->opt.domain_id = NULL;
 	sbi->devs = ctx->devs;
 	ctx->devs = NULL;
 
@@ -834,6 +847,7 @@ static void erofs_fc_free(struct fs_context *fc)
 
 	erofs_free_dev_context(ctx->devs);
 	kfree(ctx->opt.fsid);
+	kfree(ctx->opt.domain_id);
 	kfree(ctx);
 }
 
@@ -887,6 +901,7 @@ static void erofs_kill_sb(struct super_block *sb)
 	fs_put_dax(sbi->dax_dev, NULL);
 	erofs_fscache_unregister_fs(sb);
 	kfree(sbi->opt.fsid);
+	kfree(sbi->opt.domain_id);
 	kfree(sbi);
 	sb->s_fs_info = NULL;
 }
@@ -1040,6 +1055,8 @@ static int erofs_show_options(struct seq_file *seq, struct dentry *root)
 #ifdef CONFIG_EROFS_FS_ONDEMAND
 	if (opt->fsid)
 		seq_printf(seq, ",fsid=%s", opt->fsid);
+	if (opt->domain_id)
+		seq_printf(seq, ",domain_id=%s", opt->domain_id);
 #endif
 	return 0;
 }
diff --git a/fs/erofs/sysfs.c b/fs/erofs/sysfs.c
index c1383e508bbe..341fb43ad587 100644
--- a/fs/erofs/sysfs.c
+++ b/fs/erofs/sysfs.c
@@ -201,12 +201,27 @@ static struct kobject erofs_feat = {
 int erofs_register_sysfs(struct super_block *sb)
 {
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
+	char *name;
+	char *str = NULL;
 	int err;
 
+	if (erofs_is_fscache_mode(sb)) {
+		if (sbi->opt.domain_id) {
+			str = kasprintf(GFP_KERNEL, "%s,%s", sbi->opt.domain_id,
+					sbi->opt.fsid);
+			if (!str)
+				return -ENOMEM;
+			name = str;
+		} else {
+			name = sbi->opt.fsid;
+		}
+	} else {
+		name = sb->s_id;
+	}
 	sbi->s_kobj.kset = &erofs_root;
 	init_completion(&sbi->s_kobj_unregister);
-	err = kobject_init_and_add(&sbi->s_kobj, &erofs_sb_ktype, NULL, "%s",
-			erofs_is_fscache_mode(sb) ? sbi->opt.fsid : sb->s_id);
+	err = kobject_init_and_add(&sbi->s_kobj, &erofs_sb_ktype, NULL, "%s", name);
+	kfree(str);
 	if (err)
 		goto put_sb_kobj;
 	return 0;
-- 
2.20.1

