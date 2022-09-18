Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 578385BBBB5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Sep 2022 06:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiIREgE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 18 Sep 2022 00:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiIREfe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 18 Sep 2022 00:35:34 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A395193D8
        for <linux-fsdevel@vger.kernel.org>; Sat, 17 Sep 2022 21:35:18 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id c24so23913355pgg.11
        for <linux-fsdevel@vger.kernel.org>; Sat, 17 Sep 2022 21:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=iEzb9HK8KHfeOzls8+GISrwCsRaN3ytpe+kCbEKskwk=;
        b=CWJqlJ7gEsYsOLsiP2WWpkb9s1kZy/bxZQeXnu0GIf/Ue+HKSTw/EySPUPRrGSqueo
         Db81JZXT8VzLThJYZJn402lsGgr1YSitD9jRhfQ1xyhCc3HKDVtU1rqs+VnyaPOpRUWR
         79UrfF7O1SwxgnN1BW/vB4M92xa0bnVsYlYepfGGhlW4eZjU9FctRqTXisnN+lj6xOVF
         tAS8rQHNtAHcYbqXXHus4DyASfZITaOtJEcGC+ys73yWl4rnXexhrxRx/N3LI4IWeSZg
         9pmKCKPVHGnemrAjdUqNsfgQbZknUafmERT965ixXwFChNgHS2Grj8tzubMUCAKLYIzI
         +fqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=iEzb9HK8KHfeOzls8+GISrwCsRaN3ytpe+kCbEKskwk=;
        b=VTYWEfbFeQCMrwS4xGkfzfaDE8BqIKE3CGhkWriR6PrSr/nVWDxBZvmD5xlyevcw4R
         Tyht+OPBluhEXnLvIsO7lcwMAXBrFzdYHnitStdi/aemZqbRbgbx7WfvAztIjNYmUzmh
         B57ZNyYKa+w9FO6z7Ut1xy2NaPcRATASnXe4lvqrTgmRe2XDAmantpU+gHGDIpSpqhmm
         HHoyx3I8lCTxkcQyvXRN+MN+RRdx7Pe12jRzKX+r3BNR3jx6MqwkAud1n9PdOGuc/RzA
         dJEGkN54vc95y/E89Tu6++TwRf9sQxUfBO879yb0PUuXK2vND+RPMjGQS6MIWQ9Gc70r
         GdMA==
X-Gm-Message-State: ACrzQf18YIK/Rbl54AWc6tvW2QTV8rVt8p/yR31vMkubMaM3BzVyJOTq
        Hf6hT5PNp/zBUImK7O8pRmR0Qg==
X-Google-Smtp-Source: AMsMyM5OM+GSIDMjPS563NZpmFIkiTSy1EbecWmdfgbwd9JhhEpDWYcdgksBu5UjAh5wepil2sXjLg==
X-Received: by 2002:a05:6a00:230d:b0:53d:c198:6ad7 with SMTP id h13-20020a056a00230d00b0053dc1986ad7mr12953655pfh.67.1663475717343;
        Sat, 17 Sep 2022 21:35:17 -0700 (PDT)
Received: from localhost.localdomain ([111.201.134.95])
        by smtp.gmail.com with ESMTPSA id l63-20020a622542000000b0054b5239f7fesm3955248pfl.210.2022.09.17.21.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Sep 2022 21:35:17 -0700 (PDT)
From:   Jia Zhu <zhujia.zj@bytedance.com>
To:     linux-erofs@lists.ozlabs.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yinxin.x@bytedance.com, jefflexu@linux.alibaba.com,
        Jia Zhu <zhujia.zj@bytedance.com>
Subject: [PATCH V6 6/6] erofs: introduce 'domain_id' mount option
Date:   Sun, 18 Sep 2022 12:34:56 +0800
Message-Id: <20220918043456.147-7-zhujia.zj@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20220918043456.147-1-zhujia.zj@bytedance.com>
References: <20220918043456.147-1-zhujia.zj@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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

