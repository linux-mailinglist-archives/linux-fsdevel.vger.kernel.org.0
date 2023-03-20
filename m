Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3F036C25EC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Mar 2023 00:44:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbjCTXof (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Mar 2023 19:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjCTXo2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Mar 2023 19:44:28 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BDBCEFAF;
        Mon, 20 Mar 2023 16:43:54 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id j24so3098584wrd.0;
        Mon, 20 Mar 2023 16:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679355777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cY5q38znnygXEk7MQGfhMNT6fWhXSJdRMwyHM9vnLSQ=;
        b=T4eKFt/8PJCLdp758DXxE3Vk0DRGyaMCroLjSUQXTEzRpD4/0CYOWkP8UPy0HH9xTK
         D2YT5geOUrLotf3OYl1OMdAkwMC7w0ZMId2Bg6p6yiqc5/B9ougzR4bmhUqUvKWVMN58
         QPsTXHg0EIN5kHbUjtcLcLDCCYBEeLtUHM6JMjHcUDmmaP65jYPnfNvNn4hIQJ6shUsX
         n3Bc5flv9tNucl6q4s6EewhDEjgwqxzm8Yb/25h0KnuX8YkkPvaD/ua4FPoiF2K4vUYH
         eiCEn3r0gGSY4uDZhG8EJMHEKVQrNQcLvoQCNi/Yx9T/7okh+2a+rwBioaaXzE8dAaQK
         0F5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679355777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cY5q38znnygXEk7MQGfhMNT6fWhXSJdRMwyHM9vnLSQ=;
        b=Eqsi0yRV3BpDEA5EeTtn9SzI90AC/364onchcEb8fhoxJDKvs/foluTeOme0NPRfgx
         PZG3Z/teXFr5vI9ZbThLs+cGpUXf4V2F8yFX0vQQaWx59Rt7fycgQIJI14r9tdPZv0sR
         N/ICv6SONgvsjzGZwDU2vC7cordRuM32AsdtBriNX7wmLzbkzV25UH8MyUoGqjeiRvAu
         K3S8+2glRmHi9UiZ2V8JCDdS4hxxvXR7wHTLA2Ylkb/B8AWtu0mUHO9OYWCZ7dfEWbtC
         KNcx7upi7Q6J2lO4ebQyOjWlkx6gK8TOYFrjuv7aW/Zrbvr2dz6q4Je7ryh6xFRAvMDJ
         Uq6w==
X-Gm-Message-State: AO0yUKX6cmOT8Z8XcPP4vuF2P+e1nfml9Uz62UWKD4PttVUq6pck3oAL
        droJI1YsW4DisYYQwy4UTV52Inucjrk=
X-Google-Smtp-Source: AK7set/4SLRYEk0+UkeFk1Oiw2Lls+y3KoTMgnJhrqI/l2imylwBOsmTmUlFNVHmyS+Z4+blKnja8A==
X-Received: by 2002:a5d:61c9:0:b0:2d4:3f3b:cdb7 with SMTP id q9-20020a5d61c9000000b002d43f3bcdb7mr725746wrv.67.1679355777214;
        Mon, 20 Mar 2023 16:42:57 -0700 (PDT)
Received: from lucifer.home (host86-146-209-214.range86-146.btcentralplus.com. [86.146.209.214])
        by smtp.googlemail.com with ESMTPSA id u1-20020a05600c440100b003e209186c07sm17504541wmn.19.2023.03.20.16.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 16:42:55 -0700 (PDT)
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
Subject: [PATCH v3 1/4] fs/proc/kcore: avoid bounce buffer for ktext data
Date:   Mon, 20 Mar 2023 23:42:42 +0000
Message-Id: <08f9787b1fd0d552b65c62547f5382d5a5c7dbe4.1679355227.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1679355227.git.lstoakes@gmail.com>
References: <cover.1679355227.git.lstoakes@gmail.com>
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

