Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 837D45A7D5A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Aug 2022 14:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbiHaMcK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Aug 2022 08:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbiHaMcE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Aug 2022 08:32:04 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F7BD1E14
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 Aug 2022 05:32:03 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id x1-20020a17090ab00100b001fda21bbc90so10519255pjq.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 Aug 2022 05:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=/63KM3wyfELIawz0klhvCCYXeq+xfEs4T43zEY9eKME=;
        b=M8H8JUbIYde0xqj3oQuttD73l6sjhdY9fhJcRMSEilPziu1+x5YARpHDcsixAvcUJr
         /IiCcMRdOM3pXrAcUM/e6IglwRHWSjWnzBrV6P0pmgPMe5sNveuq4yJiNHTEu9PRfG6j
         oEfTZYzYcKJXV2/XqsFSBq/TsqcYl5AyMWUpijwHDumSEZUDfMTK3i0WknLnZ58eH7Au
         moAPwCyCSwq6WwS+8mQsw+zbnv34gT4lg7bPkvk05TK6xVEwJpSglJcP8zQo8W+plYBM
         tW8IQwejRhDBj3hxqrykkMTd6/mwAwfCE7BK4Pgdjv4EAEP7RiTfa3HKRxrQRpczzMmd
         Vq8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=/63KM3wyfELIawz0klhvCCYXeq+xfEs4T43zEY9eKME=;
        b=dg1O9984k3hactWWUDtNcwilvyZB1RMlzGn52xVBsh0rH25OiBMXs0vy6vlEJ4WQy0
         e1DGBCGGODpPu6sSyYU2thqdGzsapvIFWHtV+Y929ryj4bUJGIQny4eByYzHu+w+ZYCR
         Nrn2/0NpqQrzmZVyqJnvxQL2J8Ryebd49mEBWa7g+EVQiMscy4tYbpfOKDsRZw28xeyv
         +JmwJ+ShFHH6umLKJds1YuC5irJJYxyAW+JKI7uChtO+ivRHt4zcxuVuvnXmRC5AvFQg
         +3z6GIvNhQJtiuE8IapxNBsx9nxLcNjHdE0zKogqyo4FPxI/+xk6Hr2506Qmdq/qR5gy
         0XPg==
X-Gm-Message-State: ACgBeo17QM9UhBaHC7B5wx7KKCCnj/OAS584T0VXfvsWfVuHJVsg5gJm
        eudExP2Lfyy11DCUzzn3yygoLA==
X-Google-Smtp-Source: AA6agR6CqYAH3QKHOoDBvhQmp9uHrrQPT7DpAE9K6gg0dUHeqmZsA49Uke/52XvPDFXyv1fqwGwFtA==
X-Received: by 2002:a17:902:f64a:b0:172:7576:2124 with SMTP id m10-20020a170902f64a00b0017275762124mr25020406plg.155.1661949122637;
        Wed, 31 Aug 2022 05:32:02 -0700 (PDT)
Received: from C02G705SMD6V.bytedance.net ([61.120.150.76])
        by smtp.gmail.com with ESMTPSA id n12-20020a170902e54c00b0016efad0a63csm11769896plf.100.2022.08.31.05.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 05:32:02 -0700 (PDT)
From:   Jia Zhu <zhujia.zj@bytedance.com>
To:     linux-erofs@lists.ozlabs.org, xiang@kernel.org, chao@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yinxin.x@bytedance.com, jefflexu@linux.alibaba.com,
        huyue2@coolpad.com, Jia Zhu <zhujia.zj@bytedance.com>
Subject: [RFC PATCH 1/5] erofs: add 'domain_id' mount option for on-demand read sementics
Date:   Wed, 31 Aug 2022 20:31:21 +0800
Message-Id: <20220831123125.68693-2-zhujia.zj@bytedance.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
In-Reply-To: <20220831123125.68693-1-zhujia.zj@bytedance.com>
References: <20220831123125.68693-1-zhujia.zj@bytedance.com>
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
index 3173debeaa5a..fb5a84a07bd5 100644
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
+		kfree(ctx->opt.domain_id);
+		ctx->opt.domain_id = kstrdup(param->string, GFP_KERNEL);
+		if (!ctx->opt.domain_id)
+			return -ENOMEM;
+#ifdef CONFIG_EROFS_FS_ONDEMAND
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

