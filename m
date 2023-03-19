Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF4F26BFFAF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Mar 2023 08:09:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbjCSHJo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Mar 2023 03:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbjCSHJm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Mar 2023 03:09:42 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD3C26B7;
        Sun, 19 Mar 2023 00:09:41 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id cy23so35354911edb.12;
        Sun, 19 Mar 2023 00:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679209779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=csP2U+h4A4N+JyUsV24C6SnnqlSeb33JonwK9o1duFk=;
        b=E7BbUYx2VyQn5O1pHGy3AFX0ymfBCLHPKP5Y3xZwRpm/H/ORpIqsSyumlzF6fxFTMN
         SY1a+7FlryqU0IeYC7yS4qjOhenHYnANyIqz2mKvafPCfKBU2PnV33pqBXOs2JOCZIIL
         +KD1JgRFeZhX8S0bSCi1NovBHbT/CTaf2CcMG2IL1dgmBzSHi8Oe8r29QIyjxDH4DEip
         rbMrF2R8NWa5WZHFzuhkQhRmOu8CnVhC9Gs61cOqvXaFBehc1LqJzAofSWFI+eSCjmF0
         xIHOYl+VudPK5mSG4x7D1PTE/K931ydfuzIGMidUKyKYP9nmi0qrAlxd0Mlo3UBh7+95
         CcfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679209779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=csP2U+h4A4N+JyUsV24C6SnnqlSeb33JonwK9o1duFk=;
        b=m+Acu4itpffUoA+fMJ/KXWpeqYU6cM7R1O34brAFzOaJuDdLs7mz4knfiAycRz4cc1
         vjYkMmaAnF3XiSq4DmbxcqtTal74h8jwdQkCd7RUjK1qoSwcgKUlCH5UqsJGmlohB9V1
         ST8X+T8C6bb1cPERTjnDwMeGzVqkkITCY4O2HIMccY4AVbKjMOKZaM3owgN2Wab5qd8M
         3aHis2u816QxIj0liT6T8/S6tX16wgqWrhniPeGNq1YYJB5XiAqFUw61ZvJrNlfgEEKR
         q22SLwh5QZP7sz4Icf1+nGZX0MfhKRTC3Y8VWR+3pKOsm3yWAomD7LfLLADzZPNzFApC
         W6gQ==
X-Gm-Message-State: AO0yUKXSPzL7r/+WSpbFl21jRTVZUTijQ4sglP2whDJw3JAuQqhIX9cT
        4MAsmki53uJJ5tZF2pifJyQ=
X-Google-Smtp-Source: AK7set+W4lasYomB07kPXcM5wE+qUni1s4ui3d4L4qeGtG0Gv+O2Px0+D0Q0CSaktIqhgOZmF0Xktw==
X-Received: by 2002:aa7:d744:0:b0:4fd:2b05:aa2 with SMTP id a4-20020aa7d744000000b004fd2b050aa2mr9076089eds.42.1679209779674;
        Sun, 19 Mar 2023 00:09:39 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23ee:1938:1bcd:c6e1:42ba:ae87:772e])
        by smtp.googlemail.com with ESMTPSA id u8-20020a170906b10800b008c9b44b7851sm2943920ejy.182.2023.03.19.00.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Mar 2023 00:09:38 -0700 (PDT)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Baoquan He <bhe@redhat.com>, Uladzislau Rezki <urezki@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH v2 1/4] fs/proc/kcore: Avoid bounce buffer for ktext data
Date:   Sun, 19 Mar 2023 07:09:30 +0000
Message-Id: <2ed992d6604965fd9eea05fed4473ddf54540989.1679209395.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1679209395.git.lstoakes@gmail.com>
References: <cover.1679209395.git.lstoakes@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

