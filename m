Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7995D6C4D57
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Mar 2023 15:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbjCVOTU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Mar 2023 10:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231448AbjCVOTG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Mar 2023 10:19:06 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C061A64A88;
        Wed, 22 Mar 2023 07:19:04 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id l15-20020a05600c4f0f00b003ed58a9a15eso11602377wmq.5;
        Wed, 22 Mar 2023 07:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679494743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cY5q38znnygXEk7MQGfhMNT6fWhXSJdRMwyHM9vnLSQ=;
        b=HtWBEQdpIyt5NClQs0GdEyVX0BQhYMynOh3L+SPvjL7xgirih/3eFJWoVgV996pp2F
         VcWMq3wYNnf2qhxaZ3BRs9EjbhpXfgwyMfxbbnhqyQNU/FRy9P9md93Rk3qN2UsRE+0G
         c0XyTpZPfGgcVz5nd3+agIrx68G/wVqBh0h7ac744sMSO+20LJn0uGdcSuhBMro0qe1+
         VlMqfbspX9JwjjZvXUtw0gOEHFnFTBBrkOEGkfIfZ34qN16vlOQuIl5oXrWHQDr3MtJA
         UOEm3zuTtt7Z8SX1B/KlpSEfE4v9c7GzzDWiJFWGTHgG1CyxPEqUmLrPTq4x1i+z7Q3z
         YURg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679494743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cY5q38znnygXEk7MQGfhMNT6fWhXSJdRMwyHM9vnLSQ=;
        b=hBSeLcS+A3Txb0lVmM4XLRBR1JpKtpTZYwf+5PdSh0S73ats51EsIKhq7vBIvlcMIP
         lhFTT7Stq/67uoDrQwajKNM7ehT2YOq/cneTcXEKQCAciw4E0FMCYIR4pAO/J4mOZmFH
         kqsk2lsCe1S2N7rrRSZ4/z6d92otiWWq7WGoOv1UbWZT0D8paAZKCbxrncvBcOXRkp0e
         Z+h1fJ90bzgXfyzZD32AiVLkhXU7gzQKyBRc8nLbjeFBGgN40HDpn8AMC7fyUyv6YULF
         6SwgaB8Jzmgdm7dayXE8giRjWbx5Y4DdeqS6/eLSaXcSYxQkhp64VsrRMVlT+Cp6prjs
         gPGA==
X-Gm-Message-State: AO0yUKXAnu6EIaynJqkdt6NmjPjO4X1HEBMgyUDOLS7lLd1bDtd2MhWL
        +ggGU99Sur/o2SWfwG+SLi4=
X-Google-Smtp-Source: AK7set8J49qBttZoi9GR8uqyqgWfN+x1MDD5GFiNt/4HwOkw6Rfvxx4y7uoZSw2RZCb/Jhtr8mW7dA==
X-Received: by 2002:a7b:ca57:0:b0:3ee:c06:e942 with SMTP id m23-20020a7bca57000000b003ee0c06e942mr5420804wml.25.1679494742951;
        Wed, 22 Mar 2023 07:19:02 -0700 (PDT)
Received: from lucifer.home ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.googlemail.com with ESMTPSA id f20-20020a7bcd14000000b003e203681b26sm16872855wmj.29.2023.03.22.07.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 07:19:02 -0700 (PDT)
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
Subject: [PATCH v5 1/4] fs/proc/kcore: avoid bounce buffer for ktext data
Date:   Wed, 22 Mar 2023 14:18:48 +0000
Message-Id: <fd39b0bfa7edc76d360def7d034baaee71d90158.1679494218.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1679494218.git.lstoakes@gmail.com>
References: <cover.1679494218.git.lstoakes@gmail.com>
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

