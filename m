Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B20085BA8D6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Sep 2022 11:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbiIPJBE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Sep 2022 05:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbiIPJAl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Sep 2022 05:00:41 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B449A2873C
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Sep 2022 02:00:13 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id a80so12043372pfa.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Sep 2022 02:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=iEzb9HK8KHfeOzls8+GISrwCsRaN3ytpe+kCbEKskwk=;
        b=DVO8CqAbRZ+yuYZTJ7CS7HeeYkIq8qDtVlU+qfvFfkG/QE8i659DpmUZcGP7gBCc10
         viUUvhMTkzUHbf49O8rmr4kglc1kPxeSIOzmtQtnhgqrhMw2nOqtG4AJh2CjygJu7Yny
         QOr52J//uCAkeH+3uPUL5/0aL+u5zFFARzUT8JkVYOrVWZueRFYlLi3Ba1SvZt+Uk2Vx
         nMoF2go4xAlEEpzs9S4ifJI1Es35oPFPC5YFXMCw5HWPyFtwL4nCwNQ1fvceA221mdx4
         CW6VghI+Pe/IN0NWBsKsSxns99XOMT2QulB0LNtStQGRJBRNWxWX2qC0I4vphw09fvXo
         2fAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=iEzb9HK8KHfeOzls8+GISrwCsRaN3ytpe+kCbEKskwk=;
        b=SEbohoILwdVatYWs1NZXyRPLYSDFQfEN/aCV0tV+idq3E+P5nPYFPelRqNRpB2sLSG
         RqPNbv7kp3KTSJ6XbBA6ZCqjAbJGeES4UeF5VahWTpRRYzWbYOwdbXCmFCW+qWk+P05w
         HzXoUebHmZzDjAHJmYqBaBZeWe/l/6FC2/MNclOP45/t5+2wLHGall+6S1lDiKQQdypP
         WHlvsHsTu26bpdbJ0vfAlHvxgCX82Gf8iD8IOoSNzzZJNxAqNyhu2tNR5tmJoFpvvTgH
         R/QTG4LGXI2K06OsHSsyyDYrtASSqxOBNzoR72qYHLOJoS1QT6smmRnj11VmDNdfUY0V
         wmlQ==
X-Gm-Message-State: ACrzQf3LDlFRCVpU6EAw9CeM7h1ifg4OM2b0Pen+7Pihd8zwJESvpqly
        KIKtmh2g4m8mfh8ntKCH/W7WPw==
X-Google-Smtp-Source: AMsMyM7bKl1Vfe4YAQVoqlwzgw1wGBqaMakUqUIVjaFKI/HT98YObmSlD5XT54ZCIDeCV3T/n+z4tA==
X-Received: by 2002:a05:6a00:1145:b0:52b:78c:fa26 with SMTP id b5-20020a056a00114500b0052b078cfa26mr3780465pfm.27.1663318812997;
        Fri, 16 Sep 2022 02:00:12 -0700 (PDT)
Received: from C02G705SMD6V.bytedance.net ([61.120.150.76])
        by smtp.gmail.com with ESMTPSA id u11-20020a17090a450b00b001fd7fe7d369sm970578pjg.54.2022.09.16.02.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 02:00:12 -0700 (PDT)
From:   Jia Zhu <zhujia.zj@bytedance.com>
To:     linux-erofs@lists.ozlabs.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yinxin.x@bytedance.com, jefflexu@linux.alibaba.com,
        Jia Zhu <zhujia.zj@bytedance.com>
Subject: [PATCH V5 6/6] erofs: introduce 'domain_id' mount option
Date:   Fri, 16 Sep 2022 16:59:40 +0800
Message-Id: <20220916085940.89392-7-zhujia.zj@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20220916085940.89392-1-zhujia.zj@bytedance.com>
References: <20220916085940.89392-1-zhujia.zj@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/super.c | 17 +++++++++++++++++
 fs/erofs/sysfs.c | 19 +++++++++++++++++--
 2 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index ab746181ae08..9f7fe6c04e65 100644
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
@@ -702,6 +714,7 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 	sb->s_fs_info = sbi;
 	sbi->opt = ctx->opt;
 	ctx->opt.fsid = NULL;
+	ctx->opt.domain_id = NULL;
 	sbi->devs = ctx->devs;
 	ctx->devs = NULL;
 
@@ -846,6 +859,7 @@ static void erofs_fc_free(struct fs_context *fc)
 
 	erofs_free_dev_context(ctx->devs);
 	kfree(ctx->opt.fsid);
+	kfree(ctx->opt.domain_id);
 	kfree(ctx);
 }
 
@@ -916,6 +930,7 @@ static void erofs_kill_sb(struct super_block *sb)
 	fs_put_dax(sbi->dax_dev, NULL);
 	erofs_fscache_unregister_fs(sb);
 	kfree(sbi->opt.fsid);
+	kfree(sbi->opt.domain_id);
 	kfree(sbi);
 	sb->s_fs_info = NULL;
 }
@@ -1068,6 +1083,8 @@ static int erofs_show_options(struct seq_file *seq, struct dentry *root)
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

