Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7380A6C545A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Mar 2023 19:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbjCVS6T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Mar 2023 14:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjCVS5z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Mar 2023 14:57:55 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D90C6A1EE;
        Wed, 22 Mar 2023 11:57:11 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id m6-20020a05600c3b0600b003ee6e324b19so1358596wms.1;
        Wed, 22 Mar 2023 11:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679511429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cY5q38znnygXEk7MQGfhMNT6fWhXSJdRMwyHM9vnLSQ=;
        b=ho2V3lttQPWKpNn1MVOgStORguEs5OpC2tppzl/fSZvF6W5pTZXio+dUuP7F1W4a6D
         sKEH+eMbIcquzMYWjjP0z3IjWCBP2jIRxpHCsMhegkih+iPMHBOXo7n8K/2qfyEnDvAC
         JPKiK/DSS1ftRoumfSpF4SUKecVee1IRwiH/4rCGR7BHc8k3FR4aQJKTok+UIx/iek1C
         WXLKh4iIg7C1usL/OIC5pYTljmUOz1LN5763tzZTMRCcCB+cucePiCUrHF3fiHcf1xAU
         6D/EAmT10BMgVi/bAFanQ65AVy1S8kR4/dWaYVsYcuuw8Lbrn9NUnVa08eiz/jF+Fovd
         iAcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679511429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cY5q38znnygXEk7MQGfhMNT6fWhXSJdRMwyHM9vnLSQ=;
        b=6rEf6Hl6dYXE1jjvY1Svzq0f2SaGYMUQcRCzhjT+NbQaq0ZytVuDdX6WVGaNjJhXNs
         07u6Pduoz6Lazotaeu0FDLJAqTdwmX65lfoyjqF1uXmegnfnlCvxstJcNfjXqYwSGUM4
         n3ugsYcoiUA/GACS3fJT1jm/pWi9+DW3wSUXNvvFW1AZKp8/oFH5HmFgmXdpwy7M5Gi3
         CKVoCzXrJptjlGhuLESNixDdhjVoLbweIh41zZjL96k0+ps5qZTt3NSGXBtxRNN4s6oR
         aC5CO+ixceVCmtpRxn8HLw8vNTLAPALciMjRwMcLibg5WAs953xdtjNfoiUxvclGh5pL
         AaiA==
X-Gm-Message-State: AO0yUKU3jN4zMYJW3DGlzZ9+H7vi7NCK5QyHz6aJY29LvWTJR8iHLOqQ
        zoTIiNsJmTKqITTdjDwWPxE=
X-Google-Smtp-Source: AK7set+NDh+6LxctfsXoapnmQjHw2okp+JlAaeegvPt6NqD+wsZu0NW2dEtLagF4TCt/9Xz/Ab+v+w==
X-Received: by 2002:a7b:c388:0:b0:3ed:c468:ab11 with SMTP id s8-20020a7bc388000000b003edc468ab11mr417479wmj.28.1679511429076;
        Wed, 22 Mar 2023 11:57:09 -0700 (PDT)
Received: from lucifer.home ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.googlemail.com with ESMTPSA id j21-20020a05600c42d500b003ee581f37a9sm3181241wme.10.2023.03.22.11.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 11:57:08 -0700 (PDT)
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
Subject: [PATCH v7 1/4] fs/proc/kcore: avoid bounce buffer for ktext data
Date:   Wed, 22 Mar 2023 18:57:01 +0000
Message-Id: <fd39b0bfa7edc76d360def7d034baaee71d90158.1679511146.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1679511146.git.lstoakes@gmail.com>
References: <cover.1679511146.git.lstoakes@gmail.com>
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

