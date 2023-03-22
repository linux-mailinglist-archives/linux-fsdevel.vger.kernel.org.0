Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC7436C4EA7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Mar 2023 15:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbjCVO4T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Mar 2023 10:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbjCVOzz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Mar 2023 10:55:55 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B504893C7;
        Wed, 22 Mar 2023 07:55:35 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id bg16-20020a05600c3c9000b003eb34e21bdfso13222830wmb.0;
        Wed, 22 Mar 2023 07:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679496934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cY5q38znnygXEk7MQGfhMNT6fWhXSJdRMwyHM9vnLSQ=;
        b=drmJ+Pcc43djxhqw1awHq4b4iQO8E/ZwMtBLjhoA9tEcRTNpBURrY7yjE4EI7NfsLu
         bH3jeZUqc0xK/6NMBWgWrSeDbRjejfhNzr5foiLQ/NYIPw6Qk9ipxFvUAf+rBNCJXxKL
         DZDavvEriG1veZTICIFZ21cr9a3TGaOoNEcgGDlGxe6Vb6S+HeS/Z4ZPMAzRxj/BbRdQ
         9wKjOBjAb5yFflBKrWZDvkM6NwY8f1qb7jp+9mLtlVVqPPc1LSAupk2DA4IENC63MLwv
         JOghCnZwhCHXUlXJS+AR69tek9h98hfH91Lcyc7Jd3Vnms55NNgcb9QM9c5JrOaK/cTc
         mx8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679496934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cY5q38znnygXEk7MQGfhMNT6fWhXSJdRMwyHM9vnLSQ=;
        b=LQwha4pO+4LahwuDIbWnPsp05W3y2DBNxJpXb2Qpmif3LMn/MgNQ33v/l3IiWupAhc
         MnJa7bBlKXx7rGgdPRZnaJnURFH6+0Ll2tMvgWDThoo7oDWqEjRHJdqLLkUIg8XJRxrX
         t563Aj+aBi2uPjeyshwYYHyXw9z1UFF02silektJqFne5RSkI0268NAJSk66nhPbvfHt
         ZX3y13vk/yslIgfe/LfsFm5Wh28A7L5lNfjXSClLiYhFiWaPFqc1Obf/Gqkmuh4M9Qt8
         /qZTCJWjx9rEC1HX0hw0wJfZL/H6/ZNCzXtcbdDYmCgOhnfuBGaHdhja4Z26Drs026G4
         A29g==
X-Gm-Message-State: AO0yUKWcoUKRoJMzJdVQowBfXGpsph9NEjgb9EEHGo+9E62z4+u1lW/6
        rUp0pQaAUoLWNSPTT8zmtAk=
X-Google-Smtp-Source: AK7set88fsQQmZyZMzeZtdfsDW2RbQpffAgjPKAjeYkaYhWBIWV8+41//AbQV/UVY9dYplSCkPMIMw==
X-Received: by 2002:a7b:c3d0:0:b0:3ea:e834:d0d1 with SMTP id t16-20020a7bc3d0000000b003eae834d0d1mr6230620wmj.36.1679496934151;
        Wed, 22 Mar 2023 07:55:34 -0700 (PDT)
Received: from lucifer.home ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.googlemail.com with ESMTPSA id n23-20020a7bcbd7000000b003ed243222adsm16812246wmi.42.2023.03.22.07.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 07:55:33 -0700 (PDT)
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
Subject: [PATCH v6 1/4] fs/proc/kcore: avoid bounce buffer for ktext data
Date:   Wed, 22 Mar 2023 14:55:25 +0000
Message-Id: <fd39b0bfa7edc76d360def7d034baaee71d90158.1679496827.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1679496827.git.lstoakes@gmail.com>
References: <cover.1679496827.git.lstoakes@gmail.com>
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

