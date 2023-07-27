Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B47D764A82
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jul 2023 10:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbjG0IKS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jul 2023 04:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233764AbjG0IKE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jul 2023 04:10:04 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C0E91FF3
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jul 2023 01:07:03 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-682eef7d752so203230b3a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jul 2023 01:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690445160; x=1691049960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CmSKD1W4o1llBpukOwDAPdWOg+LYzWoL67ya0UPwqvg=;
        b=bWsdCjXI/QTCbfrXnl1D1RHs1UzV532bO1xy0F2QKWdmxdeZNg1bc8fwYppoEa2Sii
         fv3Dw05OLiEoJFGdDqA0cK2BR0yissZW0QGh0p8G2jYOCo1VM3qmhhRKOuDu3Ld44+HC
         IlU/6E6PL7OGmulpkRgvQIFGvR7K7vSKmFATJlzNsM5VU0kfb+Q9ux9XLDln9HSGLjNa
         erFo50JbYYva+gdlhuASAFmcGCxJk1UklUElA3OcQq/NsulVXFSALP8x8A3jEL8k5O2s
         pAuqLDXkBW250K5e8xHlcez81V5k+DmAOms7sfdEUrryxL8JhS9LUOK5EJtF0pDaEYI9
         8JWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690445160; x=1691049960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CmSKD1W4o1llBpukOwDAPdWOg+LYzWoL67ya0UPwqvg=;
        b=MdAMqWCDbkQ6X8gWraZf+Bqd1HrSgQaMTaT78lZRkWZ71yF+XdSOh8FV8m3k2hk/8g
         sVqbpu6rCr9YY4X00favox5NxalOtMKCta/hKJT7OtZL24eV0cNJHqwEYezp/FEnhLEA
         p+LGxtFMBYcoFVNt+dqGGbkdvRUJ13Mej80TNpnYy7hQy6lQaZxJsOTIgT0XcqHNiTs2
         mN8LFr7FyroB0HWXT0GoDqW+idMUfKWLWTMDsnAaUgelXpTeJ0s6qjqxD08kkqDAdLqR
         P1ofouXjjhgZQAxoZE3PEvqq8RtGPINLi4FGpjj+R7aOYSKS+/nIOQS6XZ0wCRqzyU56
         jvQQ==
X-Gm-Message-State: ABy/qLa5VsI1+cfPR4PGb8llCLMgZg9iDLWmrikGbtTdrXMCa1RKP4Kp
        fy0L/KL3fr7OJTg/r77eR+NCiA==
X-Google-Smtp-Source: APBJJlGsBl3klUilUFzaktHEHOMbkNlcOB/1K8g6HjcIbYlgfdxi92AgDTolw1HjCRkDLU6/tzA6hQ==
X-Received: by 2002:a05:6a21:78a8:b0:137:3eba:b81f with SMTP id bf40-20020a056a2178a800b001373ebab81fmr6002609pzc.3.1690445159927;
        Thu, 27 Jul 2023 01:05:59 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id j8-20020aa78d08000000b006828e49c04csm885872pfe.75.2023.07.27.01.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 01:05:59 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
        vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
        brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu,
        steven.price@arm.com, cel@kernel.org, senozhatsky@chromium.org,
        yujie.liu@intel.com, gregkh@linuxfoundation.org,
        muchun.song@linux.dev
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        kvm@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-erofs@lists.ozlabs.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nfs@vger.kernel.org, linux-mtd@lists.infradead.org,
        rcu@vger.kernel.org, netdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        dm-devel@redhat.com, linux-raid@vger.kernel.org,
        linux-bcache@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Carlos Llamas <cmllamas@google.com>
Subject: [PATCH v3 01/49] binder: fix memory leak in binder_init()
Date:   Thu, 27 Jul 2023 16:04:14 +0800
Message-Id: <20230727080502.77895-2-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230727080502.77895-1-zhengqi.arch@bytedance.com>
References: <20230727080502.77895-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In binder_init(), the destruction of binder_alloc_shrinker_init() is not
performed in the wrong path, which will cause memory leaks. So this commit
introduces binder_alloc_shrinker_exit() and calls it in the wrong path to
fix that.

Fixes: f2517eb76f1f ("android: binder: Add global lru shrinker to binder")
Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Acked-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder.c       | 1 +
 drivers/android/binder_alloc.c | 6 ++++++
 drivers/android/binder_alloc.h | 1 +
 3 files changed, 8 insertions(+)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 486c8271cab7..d720f93d8b19 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -6617,6 +6617,7 @@ static int __init binder_init(void)
 
 err_alloc_device_names_failed:
 	debugfs_remove_recursive(binder_debugfs_dir_entry_root);
+	binder_alloc_shrinker_exit();
 
 	return ret;
 }
diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index 662a2a2e2e84..e3db8297095a 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -1087,6 +1087,12 @@ int binder_alloc_shrinker_init(void)
 	return ret;
 }
 
+void binder_alloc_shrinker_exit(void)
+{
+	unregister_shrinker(&binder_shrinker);
+	list_lru_destroy(&binder_alloc_lru);
+}
+
 /**
  * check_buffer() - verify that buffer/offset is safe to access
  * @alloc: binder_alloc for this proc
diff --git a/drivers/android/binder_alloc.h b/drivers/android/binder_alloc.h
index 138d1d5af9ce..dc1e2b01dd64 100644
--- a/drivers/android/binder_alloc.h
+++ b/drivers/android/binder_alloc.h
@@ -129,6 +129,7 @@ extern struct binder_buffer *binder_alloc_new_buf(struct binder_alloc *alloc,
 						  int pid);
 extern void binder_alloc_init(struct binder_alloc *alloc);
 extern int binder_alloc_shrinker_init(void);
+extern void binder_alloc_shrinker_exit(void);
 extern void binder_alloc_vma_close(struct binder_alloc *alloc);
 extern struct binder_buffer *
 binder_alloc_prepare_to_free(struct binder_alloc *alloc,
-- 
2.30.2

