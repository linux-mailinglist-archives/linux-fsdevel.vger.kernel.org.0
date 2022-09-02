Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7975AA691
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Sep 2022 05:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235086AbiIBDsY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Sep 2022 23:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235364AbiIBDsQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Sep 2022 23:48:16 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 540C1B442E
        for <linux-fsdevel@vger.kernel.org>; Thu,  1 Sep 2022 20:48:10 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id r69so893879pgr.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Sep 2022 20:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=WSGy8JuZtB1pyuGGOt6vRdCmNn8tUcEetPk/ksDWFKg=;
        b=uoOW6bcl6RtfcvUNGAzF3eBXUSnhzNeqa2/5IKqnYGuPXVG8r8nlL4wxGRe+sk3M4Z
         IAdtYQ99fwooUd3zbaqWKtPFMGu2L4bOH74p8eK+3u/ueKoYT6GjvaPShbc7hrNparsf
         Bx5rllYY4/mskWSF8BAgp2zsWJxV31F8E8/EqJ0VERaxF8qcN/ykemcRfWEd3G1t0AeS
         DytOCSWfSsmj3STRD59JDeFG8L94o3TW/2LBy8+gOW3pXQXIi9HBLKzCf4XM0JT2VpXB
         eXSIURVZvQ/Fk8O4Lakcn0UZ+Ui7amN4YMzPUgioUHTLubgjACQM0psnzql6AQXQbIDm
         zRfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=WSGy8JuZtB1pyuGGOt6vRdCmNn8tUcEetPk/ksDWFKg=;
        b=wRxAqbzUbLUncMdblRn0wTuTarH7ZLUhlfvLDRwwNxJOYbzIkGH6UX8Sd6f/Hpw957
         CZM+WaxzUWbeql6pyPPfBnpozB1YsOwXBl+dqXZ/7/3qQJjtRRlIF4dxumT34sIH9WfX
         gih2Us7n41+GinGmq/FPfBVa1TxvbBv0AOhngzO4e7Sh2Vv2j6dS14IU/HSYt/lxnBya
         lfHPo7WoEXMPxx9iYLl6E338Ii0K/bEEmAiWCWvYDm5XHo7SynoFUdf1hbLC6eCeYBsq
         XFnzsfXgo8jl+Lwo2887ZCRZzRzfvxdzVXX6dJj6yAfA0YxvWDEgjYSQMD9AkJ5AmsOv
         SK7A==
X-Gm-Message-State: ACgBeo0pA5NQtuS4D/1qgU5zw8E56xHili8oKU01UQxnhKvMkZR3Crpb
        kM8HkWrZhLJQ4Qrn6B8mnIu4eA==
X-Google-Smtp-Source: AA6agR719fHTfgbHSij3HF/dWARZZDG0+3rBj8Dvp42dtKJaHuVEh8AKkoiefZfPBZysg23ZR7hUtw==
X-Received: by 2002:a05:6a00:1353:b0:53a:80d6:6f72 with SMTP id k19-20020a056a00135300b0053a80d66f72mr14721169pfu.32.1662090489857;
        Thu, 01 Sep 2022 20:48:09 -0700 (PDT)
Received: from C02G705SMD6V.bytedance.net ([61.120.150.76])
        by smtp.gmail.com with ESMTPSA id w8-20020a170902e88800b0016c4546fbf9sm376152plg.128.2022.09.01.20.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 20:48:09 -0700 (PDT)
From:   Jia Zhu <zhujia.zj@bytedance.com>
To:     linux-erofs@lists.ozlabs.org, xiang@kernel.org, chao@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yinxin.x@bytedance.com, jefflexu@linux.alibaba.com,
        huyue2@coolpad.com, Jia Zhu <zhujia.zj@bytedance.com>
Subject: [PATCH V1 1/5] erofs: add 'domain_id' mount option for on-demand read sementics
Date:   Fri,  2 Sep 2022 11:47:44 +0800
Message-Id: <20220902034748.60868-2-zhujia.zj@bytedance.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
In-Reply-To: <20220902034748.60868-1-zhujia.zj@bytedance.com>
References: <20220902034748.60868-1-zhujia.zj@bytedance.com>
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
 2 files changed, 18 insertions(+)

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index cfee49d33b95..fe435d077f1a 100644
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
index 3173debeaa5a..d01109069c6b 100644
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
 
@@ -838,6 +851,7 @@ static void erofs_fc_free(struct fs_context *fc)
 
 	erofs_free_dev_context(ctx->devs);
 	kfree(ctx->opt.fsid);
+	kfree(ctx->opt.domain_id);
 	kfree(ctx);
 }
 
@@ -892,6 +906,7 @@ static void erofs_kill_sb(struct super_block *sb)
 	erofs_fscache_unregister_cookie(&sbi->s_fscache);
 	erofs_fscache_unregister_fs(sb);
 	kfree(sbi->opt.fsid);
+	kfree(sbi->opt.domain_id);
 	kfree(sbi);
 	sb->s_fs_info = NULL;
 }
@@ -1044,6 +1059,8 @@ static int erofs_show_options(struct seq_file *seq, struct dentry *root)
 #ifdef CONFIG_EROFS_FS_ONDEMAND
 	if (opt->fsid)
 		seq_printf(seq, ",fsid=%s", opt->fsid);
+	if (opt->domain_id)
+		seq_printf(seq, ",domain_id=%s", opt->domain_id);
 #endif
 	return 0;
 }
-- 
2.20.1

