Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93F1C73166C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jun 2023 13:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343825AbjFOLWt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jun 2023 07:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241642AbjFOLWq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jun 2023 07:22:46 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3152C271F;
        Thu, 15 Jun 2023 04:22:45 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f004cc54f4so10362096e87.3;
        Thu, 15 Jun 2023 04:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686828163; x=1689420163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mfefqjxSvVD9BbTwo3NdrX31TFDTJBfhj1IHGiXoDY0=;
        b=Upc5czpKDXUGKdN3oikOFIHOBiwwLSJzA5sDYtyo+BJ36xnqRlqpmMCQ6iFwOKTZ5+
         vuWeCDnNOak0VNr1xIGG3eHGb3ICOXloM+j6NE8UPfaA7aYOpttHUh+7wWqKckKN0Dus
         Go58eTY9Ac6a9gbj7aHd6Bn9/Mce/oZ1unk6/MGje2Gr6d1eX8hunBrnAnEcn3Hm6zPE
         OY0titqSL4M6gptMfUadcSea95iZkJOIDvOFSHD5MHjeCvJokrJEVdiJHcDc9cRmMJAU
         buqC/0luA6S0b94Rnay9PdKJyHSxoYGBA2fAD0HIweBS6W7I/Kdar2FY4KAY6HnfVCYz
         2OhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686828163; x=1689420163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mfefqjxSvVD9BbTwo3NdrX31TFDTJBfhj1IHGiXoDY0=;
        b=EpEcWLQpmloPHCQp7GYBH1QmbUzJNOcinvr4NxLzTOcFo4Lz/Zuyi6W6J0AojRwwld
         Y+X8a9BTZpK7Furx3Cfn7Gl/lmiCHPNIPsdUtb681CLctJhVyYW0agAOtqvSdh+szVXb
         dbbpsBxq4KAQ+LJ6JOOjiwcYtneDmrGQa6m8NFOQ0A+hnxpLw+/8ux5XyelK2xrti1yZ
         teiaQJ6GTgXXNJdln4MUDSgruJoFwDa/gDi8Frk57PiNP9zLngugdjoaVXis07e/LSRs
         V+FbMKlu8tjmjM2Nx4vcYAMlsYrn9ZKmVZuBoOOszwFTc36vtG/+aqLWSx6X9mImE7uf
         +T9Q==
X-Gm-Message-State: AC+VfDw/Jg0rcqTc4Hd5uyC2ov98IR6mwmyBWCmuxrE/vf74LC9xIvv+
        P1ZlOznBcSqHzub/bJlEFR8=
X-Google-Smtp-Source: ACHHUZ4GfJ5lyvQZqxuxHwc9n9+5EUb1K3sEqtKfwUZu3VLPEBd8wBHCbaVZWSaZkcNeJA+yl26EDQ==
X-Received: by 2002:a19:d619:0:b0:4f6:6037:128e with SMTP id n25-20020a19d619000000b004f66037128emr10286530lfg.57.1686828163334;
        Thu, 15 Jun 2023 04:22:43 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id h25-20020a197019000000b004f80f03d990sm355089lfc.259.2023.06.15.04.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 04:22:42 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Miklos Szeredi <miklos@szeredi.hu>,
        Christoph Hellwig <hch@lst.de>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: [PATCH v5 3/5] fs: move kmem_cache_zalloc() into alloc_empty_file*() helpers
Date:   Thu, 15 Jun 2023 14:22:27 +0300
Message-Id: <20230615112229.2143178-4-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230615112229.2143178-1-amir73il@gmail.com>
References: <20230615112229.2143178-1-amir73il@gmail.com>
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

Use a common helper init_file() instead of __alloc_file() for
alloc_empty_file*() helpers and improrve the documentation.

This is needed for a follow up patch that allocates a backing_file
container.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/file_table.c | 41 ++++++++++++++++++++++++++---------------
 1 file changed, 26 insertions(+), 15 deletions(-)

diff --git a/fs/file_table.c b/fs/file_table.c
index 372653b92617..4bc713865212 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -131,20 +131,15 @@ static int __init init_fs_stat_sysctls(void)
 fs_initcall(init_fs_stat_sysctls);
 #endif
 
-static struct file *__alloc_file(int flags, const struct cred *cred)
+static int init_file(struct file *f, int flags, const struct cred *cred)
 {
-	struct file *f;
 	int error;
 
-	f = kmem_cache_zalloc(filp_cachep, GFP_KERNEL);
-	if (unlikely(!f))
-		return ERR_PTR(-ENOMEM);
-
 	f->f_cred = get_cred(cred);
 	error = security_file_alloc(f);
 	if (unlikely(error)) {
 		file_free_rcu(&f->f_rcuhead);
-		return ERR_PTR(error);
+		return error;
 	}
 
 	atomic_long_set(&f->f_count, 1);
@@ -155,7 +150,7 @@ static struct file *__alloc_file(int flags, const struct cred *cred)
 	f->f_mode = OPEN_FMODE(flags);
 	/* f->f_version: 0 */
 
-	return f;
+	return 0;
 }
 
 /* Find an unused file structure and return a pointer to it.
@@ -172,6 +167,7 @@ struct file *alloc_empty_file(int flags, const struct cred *cred)
 {
 	static long old_max;
 	struct file *f;
+	int error;
 
 	/*
 	 * Privileged users can go above max_files
@@ -185,9 +181,15 @@ struct file *alloc_empty_file(int flags, const struct cred *cred)
 			goto over;
 	}
 
-	f = __alloc_file(flags, cred);
-	if (!IS_ERR(f))
-		percpu_counter_inc(&nr_files);
+	f = kmem_cache_zalloc(filp_cachep, GFP_KERNEL);
+	if (unlikely(!f))
+		return ERR_PTR(-ENOMEM);
+
+	error = init_file(f, flags, cred);
+	if (unlikely(error))
+		return ERR_PTR(error);
+
+	percpu_counter_inc(&nr_files);
 
 	return f;
 
@@ -203,14 +205,23 @@ struct file *alloc_empty_file(int flags, const struct cred *cred)
 /*
  * Variant of alloc_empty_file() that doesn't check and modify nr_files.
  *
- * Should not be used unless there's a very good reason to do so.
+ * This is only for kernel internal use, and the allocate file must not be
+ * installed into file tables or such.
  */
 struct file *alloc_empty_file_noaccount(int flags, const struct cred *cred)
 {
-	struct file *f = __alloc_file(flags, cred);
+	struct file *f;
+	int error;
+
+	f = kmem_cache_zalloc(filp_cachep, GFP_KERNEL);
+	if (unlikely(!f))
+		return ERR_PTR(-ENOMEM);
+
+	error = init_file(f, flags, cred);
+	if (unlikely(error))
+		return ERR_PTR(error);
 
-	if (!IS_ERR(f))
-		f->f_mode |= FMODE_NOACCOUNT;
+	f->f_mode |= FMODE_NOACCOUNT;
 
 	return f;
 }
-- 
2.34.1

