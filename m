Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 285804CE5B9
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Mar 2022 17:04:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbiCEQFg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 5 Mar 2022 11:05:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231979AbiCEQFf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 5 Mar 2022 11:05:35 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1CC838BE0;
        Sat,  5 Mar 2022 08:04:43 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id j17so16974789wrc.0;
        Sat, 05 Mar 2022 08:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tgBNhkJaZjE8Z4MFNsIEqcgJ3jiEcmyqWbotT8QMd+4=;
        b=mGJbLdouKEPU4AOSgNOot+8Hywzrzt2aXQJs6qGlZUj8165Q3y1isJsqXIRwsaOJRl
         pXdnLrA36k0oNw427Gkzo9OPOyLuq3fspsJFpaTZdN/WcMHVp+9br1/ORnVGDo6kQQSJ
         w9XuUSF2cwooVzCz37zyFkkWxHnZ/ULkeW/bN90FPDmW44/qdxFqf8WaMf5w7cxkiVim
         Bq+1LhD6z4lPk960SdSQLDEcu13MFcqUXrmXTWM+T+ROs1vitdbxf+mQ7SvzBsTsu8zs
         ych67M1Ulu/Dk/2XoJUgpaN+VYF5qWb8j3TOigVVuMuPd82cVyGD5QxxjtHcKZjI3S2J
         LB2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tgBNhkJaZjE8Z4MFNsIEqcgJ3jiEcmyqWbotT8QMd+4=;
        b=gMlFvfWBXHjlYbxo92WEitxksTzSWX+V4ReudrVc6ZpjYWiTrRgY0eWs8GDEjf7Zxf
         xNIYrdvM3fVrAj0CWg37BFwFNjAZc+bAqau9DzBZ+sMgtjHRPBGITVNz/ayDwDOitpqd
         8cKkO3JZCe6G15psSyIOeeugFJKUMBVrTICfrh0KlGA15E1wupcpBCTDDSMX5sfkDVKZ
         YZaZXJF1wfsYfBnjAapOPW+GtLAM1M8oh3TW3YxGvR6FfmWYMfHzf/I1bWpT08MYxrWW
         vYWDZhGVEw4ERJb5aR3wHehTCNSa3whl06Ic58iRaX+9L8sAaKhNs2VdoTE+ShQgvqAb
         QCsA==
X-Gm-Message-State: AOAM5332TVzq9ktOHnK9q8x4WwrL8fwkLIwqYU0O/HgQvvmfNikI/oQk
        dwqARt+nz3ENnD3j0lY8szo=
X-Google-Smtp-Source: ABdhPJyIRxblTmebE85ok1adXQZpwkViUl3XwG8ayOHerHSJYLaq6owo5lDTSz5h0v6LvtV8PeMHUg==
X-Received: by 2002:adf:a341:0:b0:1f0:1a12:8920 with SMTP id d1-20020adfa341000000b001f01a128920mr2957850wrb.100.1646496282339;
        Sat, 05 Mar 2022 08:04:42 -0800 (PST)
Received: from localhost.localdomain ([77.137.71.203])
        by smtp.gmail.com with ESMTPSA id n5-20020a5d5985000000b001f0122f63e1sm1650717wri.85.2022.03.05.08.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Mar 2022 08:04:41 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Dave Chinner <david@fromorbit.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 1/9] lib/percpu_counter: add helpers for "relaxed" counters
Date:   Sat,  5 Mar 2022 18:04:16 +0200
Message-Id: <20220305160424.1040102-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220305160424.1040102-1-amir73il@gmail.com>
References: <20220305160424.1040102-1-amir73il@gmail.com>
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

Counter that are only read with percpu_counter_sum() can use an
arbitrary large batch size.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 include/linux/percpu_counter.h | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/include/linux/percpu_counter.h b/include/linux/percpu_counter.h
index 01861eebed79..7f01f2e41304 100644
--- a/include/linux/percpu_counter.h
+++ b/include/linux/percpu_counter.h
@@ -193,4 +193,33 @@ static inline void percpu_counter_sub(struct percpu_counter *fbc, s64 amount)
 	percpu_counter_add(fbc, -amount);
 }
 
+/*
+ * Helpers for percpu counters for which per-cpu drift doesn't matter.
+ * This is typically the case for statistics counters that are read with
+ * percpu_counter_sum{,_positive}().
+ */
+#define PERCPU_COUNTER_LARGE_BATCH	(INT_MAX / 2)
+
+static inline void percpu_counter_add_relaxed(struct percpu_counter *fbc,
+					      s64 amount)
+{
+	percpu_counter_add_batch(fbc, amount, PERCPU_COUNTER_LARGE_BATCH);
+}
+
+static inline void percpu_counter_sub_relaxed(struct percpu_counter *fbc,
+					      s64 amount)
+{
+	percpu_counter_add_relaxed(fbc, amount);
+}
+
+static inline void percpu_counter_inc_relaxed(struct percpu_counter *fbc)
+{
+	percpu_counter_add_relaxed(fbc, 1);
+}
+
+static inline void percpu_counter_dec_relaxed(struct percpu_counter *fbc)
+{
+	percpu_counter_add_relaxed(fbc, -1);
+}
+
 #endif /* _LINUX_PERCPU_COUNTER_H */
-- 
2.25.1

