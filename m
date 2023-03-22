Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D53C66C4D4A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Mar 2023 15:17:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjCVORo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Mar 2023 10:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjCVORn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Mar 2023 10:17:43 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01FF9474FF;
        Wed, 22 Mar 2023 07:17:41 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id j18-20020a05600c1c1200b003ee5157346cso1805155wms.1;
        Wed, 22 Mar 2023 07:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679494660;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cY5q38znnygXEk7MQGfhMNT6fWhXSJdRMwyHM9vnLSQ=;
        b=dIwol5PJw0bli8FE/ZdtKot7+ZBxkF2CumwPnWIKpYhM02k1csFlwUqD9UGL9WmVLn
         3kH6HAxlp3zElAHVcqZypb6dzIguKMqxaZdPSUkRnzfNpZ+N4ajFYn8D3b+VhenoWaBp
         +nnPFx0qewJW0Z9sGBiil1IqIbwimdDzq+2ZHg5jFcHk4R9l9QrA1w7YDnAlgfbxCbiC
         L2Vc4UCY2jyTccq0OukQszIqjXzgfCupsM/z8pFZQ9QHNq2a5ZvtpPIZc0orj1WSiBoB
         rc1D+fk/Dfij3pJZZPenfpqa0GCgLTSnTQgL81J54JFfeZPxhebLOK+xsOuXEpHNlC59
         2l8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679494660;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cY5q38znnygXEk7MQGfhMNT6fWhXSJdRMwyHM9vnLSQ=;
        b=3SNGDlVgpcXeSyC9d8rYW24Vuiu2YMIewgIebSZjUeknQPlnxMtFRvpap630jkYjc4
         QmZipirXJQHqz2de14i3Ndfmku2Ai+u8COeSCjieEY9huCEcbjJ13OwiqjdoIdd1Muiy
         ol5+13aJKP3Yv8+koVZZIbf1DWNnrUSzMLyaTuKTkeRiRFH30ZlWcH3KeXc64OUZ6uwS
         HKUv4mq5VjktNoJfILVqhgp5e8w+CCl3J6lCs38f4yaa8aeBIFWrnV/5/xuP7PcziMYk
         0R/KkVVPpAb2SUsBGGCefA0gkkkw3VIxDidrgh1vkcuRqee1JAeWUZSzkNTGEm4pDFeb
         bhWQ==
X-Gm-Message-State: AO0yUKUkqJk3QXngQZSVz2b9Tsg5GvQ7wYxha/4gF8i6tMY7wJcAFdxh
        Wa/F0fFq52B4aQZayZ4X/szymaDoD7Y=
X-Google-Smtp-Source: AK7set/t+90cniOBUsMZ86ATkrJz4GVX1skOO3/GxVxqGNazKFn1JFfEJ5wqrdwgjLijJkQ5YI4B9g==
X-Received: by 2002:a7b:c00b:0:b0:3ed:2b27:5bcc with SMTP id c11-20020a7bc00b000000b003ed2b275bccmr5684047wmb.38.1679494660074;
        Wed, 22 Mar 2023 07:17:40 -0700 (PDT)
Received: from lucifer.home ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.googlemail.com with ESMTPSA id h20-20020a1ccc14000000b003dc522dd25esm16824893wmb.30.2023.03.22.07.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 07:17:39 -0700 (PDT)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Baoquan He <bhe@redhat.com>, Uladzislau Rezki <urezki@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Jiri Olsa <jolsa@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH v5 1/4] fs/proc/kcore: avoid bounce buffer for ktext data
Date:   Wed, 22 Mar 2023 14:17:32 +0000
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

