Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 682FE76A35F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jul 2023 23:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbjGaVu7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jul 2023 17:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231504AbjGaVu4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jul 2023 17:50:56 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80589E7;
        Mon, 31 Jul 2023 14:50:33 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fbc5d5742eso54961405e9.3;
        Mon, 31 Jul 2023 14:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690840232; x=1691445032;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LzzSGKWkmVAwS6+5gn2kW/zuOpGQRDh54S2FzorJoyA=;
        b=Gh6QtEjOYwj9odnsjh1f9DapsMkYw7zBcT5m9Kd1gaN0YupuuaRA1tt+K3+L1M0cAN
         +iRFN3msBWUF/UKb2JDD+6GJI2Gv1MpevVryLb9Bdoci+QBKe5pT1Wnv8UJK1ofVufOb
         xeETko2BcN4dMLmlLu7ea6ABxmGItWChPuqDD1x9cUqb5NUk/8kVlI50gFWAC4FIgthg
         WykjFjx6566tCwyrYocar6zjVxbZ7lNyX5ar+4lNWJQ7d9yEO/PAgOrNAibQMW6T2vPX
         2q5ZT1t0X6cQnwloXqZRTBwwiJ4F+bpq6IzkWzbzTq3MGZKXR6b1Dil1dLPiW+t7xm03
         L/Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690840232; x=1691445032;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LzzSGKWkmVAwS6+5gn2kW/zuOpGQRDh54S2FzorJoyA=;
        b=E957p7m1n4ECUvhYapME1VVCeave8eJhoB0ZmhLlngqp/d5fX4WbMjwi4DinVxWuZv
         LSa5LhRrJFgx0rdcbmPYNDAUw6GJCccOUAXQRpc1IOwircYR/pBwvNzAWPLUUp0/anHf
         iZxmHMCgk/MjOp2+3gHyQ5CCMOcZC86ckIJhtCN1NK915JvqdQRwsFciOn4fldL2mh19
         moRqyQAuBwUc3rTW6jGtrfq6Wzd9vWBt9tIufi8BHt2Rvxi4qp+jsauLGaTqEEJYaFKj
         qH6ehPMepF4U2+ff2jGvCWc75RmZId4z+4y+khJcZXKN2tAFd1SKRu7Dnwg2Qj3UMwPE
         mn2g==
X-Gm-Message-State: ABy/qLaO/GaqZypvHCNgazW7dDBf9AVm2ow/U4iQwVlcRQZr2UiiWONO
        vde3TKXKqLfyGM9qpb1X/ywBuAeQ+Ds=
X-Google-Smtp-Source: APBJJlGkZeJD/ErBNLIHuV84FQDDzVLXS/9Ndpi2HOQ7+mZlSHPebNAIlPGdzhNi1ilsx784crY0JQ==
X-Received: by 2002:a7b:cd1a:0:b0:3fc:92:73d6 with SMTP id f26-20020a7bcd1a000000b003fc009273d6mr854436wmj.11.1690840231335;
        Mon, 31 Jul 2023 14:50:31 -0700 (PDT)
Received: from lucifer.home ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.googlemail.com with ESMTPSA id d12-20020a1c730c000000b003fa999cefc0sm12123626wmb.36.2023.07.31.14.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 14:50:30 -0700 (PDT)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Baoquan He <bhe@redhat.com>, Uladzislau Rezki <urezki@gmail.com>,
        linux-fsdevel@vger.kernel.org, Jiri Olsa <olsajiri@gmail.com>,
        Will Deacon <will@kernel.org>, Mike Galbraith <efault@gmx.de>,
        Mark Rutland <mark.rutland@arm.com>,
        wangkefeng.wang@huawei.com, catalin.marinas@arm.com,
        ardb@kernel.org, David Hildenbrand <david@redhat.com>,
        Linux regression tracking <regressions@leemhuis.info>,
        regressions@lists.linux.dev, Matthew Wilcox <willy@infradead.org>,
        Liu Shixin <liushixin2@huawei.com>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Lorenzo Stoakes <lstoakes@gmail.com>, stable@vger.kernel.org
Subject: [PATCH] fs/proc/kcore: reinstate bounce buffer for KCORE_TEXT regions
Date:   Mon, 31 Jul 2023 22:50:21 +0100
Message-ID: <20230731215021.70911-1-lstoakes@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Some architectures do not populate the entire range categorised by
KCORE_TEXT, so we must ensure that the kernel address we read from is
valid.

Unfortunately there is no solution currently available to do so with a
purely iterator solution so reinstate the bounce buffer in this instance so
we can use copy_from_kernel_nofault() in order to avoid page faults when
regions are unmapped.

This change partly reverts commit 2e1c0170771e ("fs/proc/kcore: avoid
bounce buffer for ktext data"), reinstating the bounce buffer, but adapts
the code to continue to use an iterator.

Fixes: 2e1c0170771e ("fs/proc/kcore: avoid bounce buffer for ktext data")
Reported-by: Jiri Olsa <olsajiri@gmail.com>
Closes: https://lore.kernel.org/all/ZHc2fm+9daF6cgCE@krava
Cc: stable@vger.kernel.org
Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 fs/proc/kcore.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
index 9cb32e1a78a0..3bc689038232 100644
--- a/fs/proc/kcore.c
+++ b/fs/proc/kcore.c
@@ -309,6 +309,8 @@ static void append_kcore_note(char *notes, size_t *i, const char *name,
 
 static ssize_t read_kcore_iter(struct kiocb *iocb, struct iov_iter *iter)
 {
+	struct file *file = iocb->ki_filp;
+	char *buf = file->private_data;
 	loff_t *fpos = &iocb->ki_pos;
 	size_t phdrs_offset, notes_offset, data_offset;
 	size_t page_offline_frozen = 1;
@@ -554,11 +556,22 @@ static ssize_t read_kcore_iter(struct kiocb *iocb, struct iov_iter *iter)
 			fallthrough;
 		case KCORE_VMEMMAP:
 		case KCORE_TEXT:
+			/*
+			 * Sadly we must use a bounce buffer here to be able to
+			 * make use of copy_from_kernel_nofault(), as these
+			 * memory regions might not always be mapped on all
+			 * architectures.
+			 */
+			if (copy_from_kernel_nofault(buf, (void *)start, tsz)) {
+				if (iov_iter_zero(tsz, iter) != tsz) {
+					ret = -EFAULT;
+					goto out;
+				}
 			/*
 			 * We use _copy_to_iter() to bypass usermode hardening
 			 * which would otherwise prevent this operation.
 			 */
-			if (_copy_to_iter((char *)start, tsz, iter) != tsz) {
+			} else if (_copy_to_iter(buf, tsz, iter) != tsz) {
 				ret = -EFAULT;
 				goto out;
 			}
@@ -595,6 +608,10 @@ static int open_kcore(struct inode *inode, struct file *filp)
 	if (ret)
 		return ret;
 
+	filp->private_data = kmalloc(PAGE_SIZE, GFP_KERNEL);
+	if (!filp->private_data)
+		return -ENOMEM;
+
 	if (kcore_need_update)
 		kcore_update_ram();
 	if (i_size_read(inode) != proc_root_kcore->size) {
@@ -605,9 +622,16 @@ static int open_kcore(struct inode *inode, struct file *filp)
 	return 0;
 }
 
+static int release_kcore(struct inode *inode, struct file *file)
+{
+	kfree(file->private_data);
+	return 0;
+}
+
 static const struct proc_ops kcore_proc_ops = {
 	.proc_read_iter	= read_kcore_iter,
 	.proc_open	= open_kcore,
+	.proc_release	= release_kcore,
 	.proc_lseek	= default_llseek,
 };
 
-- 
2.41.0

