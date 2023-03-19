Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 034406BFE9B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Mar 2023 01:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjCSAZh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Mar 2023 20:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbjCSAYW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Mar 2023 20:24:22 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F2E22A6E8;
        Sat, 18 Mar 2023 17:21:38 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id y14so7381832wrq.4;
        Sat, 18 Mar 2023 17:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679185217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=csP2U+h4A4N+JyUsV24C6SnnqlSeb33JonwK9o1duFk=;
        b=nC6RYf6jBdzIKQ4o3vm7PvlkCYMlOb1FdP26eTaA7XVeOCh6KBdfA7t8A9kV0DJyUu
         Zla8U4rG4p3JsUlcTbj1hALd7X+zuQQyHPo31R1hXSlO6RI1L+zQQ6nLiJl+1/Xd7U7U
         apPCOgsxAoHSLFM0qPvVpo7u61XC0kmIRa5pxuaYfocJcUN0AOST09bBvQuEcJGH8esh
         Ib/zsOkFPFJkM6s012r+iEmCzFsVMHBLJiz8a/qppPITwzE0psbE/fxPchSR/bE9d1mw
         OfIHu0q2z+2gyGNfQdqreV8GYmkXjgOOuUaUsHA43nqXVPlwr56UszPzKQAefMoPfCHJ
         5Cqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679185217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=csP2U+h4A4N+JyUsV24C6SnnqlSeb33JonwK9o1duFk=;
        b=vmsTJjT1h1n0x8CuDFUASxp1SZXpyChGvQvj4UemXTxwc05NpHU+h0XM70NNuOe77q
         mzZSsaOYaRaNQEgIj1udTHyA6XPibJHNKjCbiVG+sda/dni62mBdy94HWJ0wlcyD2tFi
         dIzO6G2SsLVCbR4pvPLU3PKgNg8N4VxflmXuRofdHsO7GLmKgcdBPqikGv6uv99CmKpP
         YqEztcmAFh4g2QKFnYMyYTlQjAbCvUNumelo+Q7iT+b5bwDFDcjaEVNDmMrjFKOot2xf
         sz1RUYAhU+pfspUyecmtr/ce/0u909DEV7i++h4dnoR/CQmtsFMAUIRhjkvk4cQabP7i
         z74w==
X-Gm-Message-State: AO0yUKUirSlZLywteyOnfhJdifQIT18hIzns1/GfuB05V6vyxcxbNXqD
        Zgiqyz+nFqAwYgK5QGyIfR8=
X-Google-Smtp-Source: AK7set+dDEGx+X3Pskgz3ooddARr7XyBMTyRwnPZALsSabKkf9CNmLvTCoIx1rhzU9tGuRxE4a3syA==
X-Received: by 2002:a5d:54c1:0:b0:2d3:fba4:e61d with SMTP id x1-20020a5d54c1000000b002d3fba4e61dmr4877179wrv.12.1679185217216;
        Sat, 18 Mar 2023 17:20:17 -0700 (PDT)
Received: from lucifer.home (host86-146-209-214.range86-146.btcentralplus.com. [86.146.209.214])
        by smtp.googlemail.com with ESMTPSA id x14-20020adfdd8e000000b002cff0c57b98sm5399639wrl.18.2023.03.18.17.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Mar 2023 17:20:16 -0700 (PDT)
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
Subject: [PATCH 1/4] fs/proc/kcore: Avoid bounce buffer for ktext data
Date:   Sun, 19 Mar 2023 00:20:09 +0000
Message-Id: <2ed992d6604965fd9eea05fed4473ddf54540989.1679183626.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1679183626.git.lstoakes@gmail.com>
References: <cover.1679183626.git.lstoakes@gmail.com>
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

