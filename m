Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A34F66C3C47
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Mar 2023 21:55:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjCUUys (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Mar 2023 16:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbjCUUym (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Mar 2023 16:54:42 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0818E53D9C;
        Tue, 21 Mar 2023 13:54:41 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id l27so6733579wrb.2;
        Tue, 21 Mar 2023 13:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679432079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cY5q38znnygXEk7MQGfhMNT6fWhXSJdRMwyHM9vnLSQ=;
        b=WXv44Su+m8P4kXKAgctFKpHknepkQ3/lIhDf1dfJsDViOOre129Y7j4Ck5+3x/5pBr
         jwFY+17jeebTUBg5beyTQI2XmhJvQ9Lb/RmWt+lLNoLw452/VnjezC9HUTAmrKNIHSkt
         zmTlY/i5G76kkuraE93tLzBXqrKmvaZH5v3blsuow9zYdrEJqT1j8BcpstGTVd2SN9WX
         DKtYV7pDHdu/3Q9W61A8o5izTsKHNJLCFSvFn2Wfj1fiEBqfApZ2aXKNHl0JSHvH+ENz
         YpVn5gFll/rCOaUyZF0/TyPtZz2fF3YgDxkSdLKqRmt4RlKE2dRB9uT0EOH/MK7WKOdj
         2qTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679432079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cY5q38znnygXEk7MQGfhMNT6fWhXSJdRMwyHM9vnLSQ=;
        b=JqCKgfsQbqxUiHQq/7tzM2z86xO1QgIDke/eH7JRdZflk1UmaYvApQUL+Tf4GNe0b4
         OHlOBTDrBdw0NmY4ceTvkX/4pUg1m1fgzh+fVXaEoV0lG6j4Kw4lG54LOtkIAh16/7Kh
         GuChqSj1W+Pm6Y2zjdbW9+4hEki9N47pCUAmSNcAnP14x/+lFn01eeltPI9onlgTrQmW
         EnX3iVXFaBgFxcZjhP4hXeDotE7ENwRIQwkq4f9j783B5sbcxVogD9Aq1DBMhOxyfDXF
         BerKMcEi2zTWQSOsT5Vcy8vjb1KDHiSkOOa5n3Ym24w9ARDY0szSO27MAE3wNSIOPiP1
         cUrg==
X-Gm-Message-State: AO0yUKXPVkA1gjsjxgCzPkbAlj0Ux5gbnhGz76T4WtELyLUw1V6yB/ug
        s3Asb7Ef/mxAcWdtUUdCagamcq1CXsY=
X-Google-Smtp-Source: AK7set/ERpVemd/vLRdCwAkIy45+Hl+RuG9U/wayryoIiE+n2Qpze3L+1Sf3hOQVwJz0prOr7IANIA==
X-Received: by 2002:adf:e481:0:b0:2d1:f705:a602 with SMTP id i1-20020adfe481000000b002d1f705a602mr3193312wrm.22.1679432079310;
        Tue, 21 Mar 2023 13:54:39 -0700 (PDT)
Received: from lucifer.home (host86-146-209-214.range86-146.btcentralplus.com. [86.146.209.214])
        by smtp.googlemail.com with ESMTPSA id a8-20020a056000100800b002d8566128e5sm3744575wrx.25.2023.03.21.13.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 13:54:38 -0700 (PDT)
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
Subject: [PATCH v4 1/4] fs/proc/kcore: avoid bounce buffer for ktext data
Date:   Tue, 21 Mar 2023 20:54:30 +0000
Message-Id: <08f9787b1fd0d552b65c62547f5382d5a5c7dbe4.1679431886.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1679431886.git.lstoakes@gmail.com>
References: <cover.1679431886.git.lstoakes@gmail.com>
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

