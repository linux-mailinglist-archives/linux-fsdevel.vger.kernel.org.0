Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD976C6491
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Mar 2023 11:15:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbjCWKP2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Mar 2023 06:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbjCWKP0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Mar 2023 06:15:26 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC771ADDA;
        Thu, 23 Mar 2023 03:15:25 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id r19-20020a05600c459300b003eb3e2a5e7bso735512wmo.0;
        Thu, 23 Mar 2023 03:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679566524;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cY5q38znnygXEk7MQGfhMNT6fWhXSJdRMwyHM9vnLSQ=;
        b=qX0NvMt0CqzoY0Lr7UQkxPq2uVe4Zy3EMu6s5/qeG3l29H6nnTeBqXkDfUGl+sMJDi
         To1Uc1nPNJQYHElIFq5iO8fS+lk/SakYHnFC0dSfIt0VpQY8sLqg09eimJ/7YEqbP1XR
         VT8JBPbHX06JTtbWOk93ztG/5KD1q6ob99V4FihMHwv2MByqX1Ai3Z6znLATtnv+ksm2
         c5FSk9J5/L8z0Co66rkYe1lq/fW2DO7o+YDkp/zAgdPysPTuJd1SALva7Z+nuzGuib3o
         K2iz/+LuOqaihmm/nmaxKKkG3rhp33yiI0LpXtvNIi6guzXD+7ckLO8ucQMHb28Rp07t
         X6fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679566524;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cY5q38znnygXEk7MQGfhMNT6fWhXSJdRMwyHM9vnLSQ=;
        b=tEJTuiJH2WuqJiIx41eTiX7uzloho0o7X0QzxbP3eIXwARTnTgi0Zrqo1qVjE2OGiF
         uKE2TrrypVN9tBTICEZ0lYlKiSRQQBAyatfMY3UKHyRG3GsuIj1AnLlxyvgWWPKFaZlq
         7b4f8HMdd29kgoHlg6LVq2IGV7PVRpADPaGcMgFxv9k58pKBPTu4kHwzDtKNdeqktSGS
         72XKycHVUSuCNPZ4SAsxQboyUFCRoA6012adSwtY+g1BpMpcJMVJ7Eq4PabBBmogo+XL
         K7s42sWCHICF6/QEs46nDJeMuPBwA7IhYZn3ISkczJvAJFgFkEveO7QO0V4zl8L6LSjn
         dC4Q==
X-Gm-Message-State: AO0yUKWgZbgrBI4wUlxRbmafKTvf69xc1vH0ocSusGyos9Yf/jmpxt/V
        KgoMREo07wNMAVfchMRaERY=
X-Google-Smtp-Source: AK7set8l2mw02Hi+yEM7NEqPCCxbfo5h/cpPyKk3/TXqnMetKEQVjkCEfcASensglEf7x+j3LK9Iiw==
X-Received: by 2002:a05:600c:b43:b0:3ed:2eb5:c2e8 with SMTP id k3-20020a05600c0b4300b003ed2eb5c2e8mr1890205wmr.10.1679566523681;
        Thu, 23 Mar 2023 03:15:23 -0700 (PDT)
Received: from lucifer.home (host86-156-84-164.range86-156.btcentralplus.com. [86.156.84.164])
        by smtp.googlemail.com with ESMTPSA id f18-20020a05600c155200b003ede2c59a54sm1416952wmg.37.2023.03.23.03.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 03:15:22 -0700 (PDT)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Baoquan He <bhe@redhat.com>, Uladzislau Rezki <urezki@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Jiri Olsa <jolsa@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH v8 1/4] fs/proc/kcore: avoid bounce buffer for ktext data
Date:   Thu, 23 Mar 2023 10:15:16 +0000
Message-Id: <fd39b0bfa7edc76d360def7d034baaee71d90158.1679566220.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1679566220.git.lstoakes@gmail.com>
References: <cover.1679566220.git.lstoakes@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Commit df04abfd181a ("fs/proc/kcore.c: Add bounce buffer for ktext data")
introduced the use of a bounce buffer to retrieve kernel text data for
/proc/kcore in order to avoid failures arising from hardened user copies
enabled by CONFIG_HARDENED_USERCOPY in check_kernel_text_object().

We can avoid doing this if instead of copy_to_user() we use _copy_to_user()
which bypasses the hardening check. This is more efficient than using a
bounce buffer and simplifies the code.

We do so as part an overall effort to eliminate bounce buffer usage in the
function with an eye to converting it an iterator read.

Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 fs/proc/kcore.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
index 71157ee35c1a..556f310d6aa4 100644
--- a/fs/proc/kcore.c
+++ b/fs/proc/kcore.c
@@ -541,19 +541,12 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
 		case KCORE_VMEMMAP:
 		case KCORE_TEXT:
 			/*
-			 * Using bounce buffer to bypass the
-			 * hardened user copy kernel text checks.
+			 * We use _copy_to_user() to bypass usermode hardening
+			 * which would otherwise prevent this operation.
 			 */
-			if (copy_from_kernel_nofault(buf, (void *)start, tsz)) {
-				if (clear_user(buffer, tsz)) {
-					ret = -EFAULT;
-					goto out;
-				}
-			} else {
-				if (copy_to_user(buffer, buf, tsz)) {
-					ret = -EFAULT;
-					goto out;
-				}
+			if (_copy_to_user(buffer, (char *)start, tsz)) {
+				ret = -EFAULT;
+				goto out;
 			}
 			break;
 		default:
-- 
2.39.2

