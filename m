Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD4E371745
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 May 2021 16:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbhECO6k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 May 2021 10:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbhECO6j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 May 2021 10:58:39 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B375DC06174A
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 May 2021 07:57:46 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id n10so1930226ion.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 May 2021 07:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=yjuCHoWi9NQN2JVk/lXHAiPpWbADy6aEqtHpjVnEBPk=;
        b=sjJtnetJvY/M6qNRaBqxHidEC74a7C6LZAJGspCJhSTA0r8yXXdy3ynvz2uNX6qj+O
         YPLy7fFemV82zKrEHTunFa85kwk8rH/seK6OL3Nv+F52Y8rM6tRK1M6u7JGcJznKSWph
         zRrywf4ylBIJFyhYTfXicZKptxnr7mxQuXhRU6JoBsVzkkhtg4tsGP8ldr2F6b6LpYel
         O2wz9eaFbG0OoVr2GTJOzh3OwrpcEuwpoVtyIQq92QmmfM0c61tMbLfH6EWymH5iaMfx
         EmjXjX6yOB60/ZCiPb0sfY0pLli9DQfbF7jr/FUFssB2kI4mVBvn3Zpf9dRkDNieVGC2
         R+Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=yjuCHoWi9NQN2JVk/lXHAiPpWbADy6aEqtHpjVnEBPk=;
        b=ZVLwGw9OHcVk4ZqZv/ce9mKp6zCBNtgt6N0R7/KvKt/1Q0Y6Idho+XBnHotw9/eRDq
         cBiKE8wIHg+BqxUKAJofGlR3gl3nY0OhBj0LnJVfPccxv8250ZNpyoIeUtG2+vgD2K/I
         /u2W1d8ly/RAmk9LwFscEBvLEEYCfroLbueLP6Ym0kxE2tHlYD1i8WhMX62QR6T7eV26
         gZkbttCHhGAy5Is3y889b+B4Rj9koNCX8OWNrkJrFdFDkkyzCH1rmXbIYUuJ8zf76aBi
         EpcHKRxvV8oE20iu1rCza7z2ruWtcuaWT3wYoEZmaNAi0yn89/inm3lDnQtwBM63cIVo
         X5/w==
X-Gm-Message-State: AOAM530dqgkwlrMuomqWc7i/vx1g1S9WQBBjJukrTAhP1Da05CM7CDiN
        D5+hKcAPGlYxGdi2IREGMkqVH08iv1blqA==
X-Google-Smtp-Source: ABdhPJzIZBAEhvhAP5ObOH40HKGK3XVZwJyr8z7rAcGxQDdgxhf2HkI/dLpIAoFVWJWyL0qOQ9hA5Q==
X-Received: by 2002:a02:8308:: with SMTP id v8mr19390470jag.143.1620053866052;
        Mon, 03 May 2021 07:57:46 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id h14sm683783ils.13.2021.05.03.07.57.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 May 2021 07:57:45 -0700 (PDT)
To:     "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] eventfd: convert to using ->write_iter()
Message-ID: <7b98e3c2-2d9f-002b-1da1-815d8522b594@kernel.dk>
Date:   Mon, 3 May 2021 08:57:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Had a report on writing to eventfd with io_uring is slower than it
should be, and it's the usual case of if a file type doesn't support
->write_iter(), then io_uring cannot rely on IOCB_NOWAIT being honored
alongside O_NONBLOCK for whether or not this is a non-blocking write
attempt. That means io_uring will punt the operation to an io thread,
which will slow us down unnecessarily.

Convert eventfd to using fops->write_iter() instead of fops->write().

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/fs/eventfd.c b/fs/eventfd.c
index e265b6dd4f34..02c55e5e1a3e 100644
--- a/fs/eventfd.c
+++ b/fs/eventfd.c
@@ -264,17 +264,18 @@ static ssize_t eventfd_read(struct kiocb *iocb, struct iov_iter *to)
 	return sizeof(ucnt);
 }
 
-static ssize_t eventfd_write(struct file *file, const char __user *buf, size_t count,
-			     loff_t *ppos)
+static ssize_t eventfd_write(struct kiocb *kiocb, struct iov_iter *from)
 {
+	struct file *file = kiocb->ki_filp;
 	struct eventfd_ctx *ctx = file->private_data;
+	size_t count = iov_iter_count(from);
 	ssize_t res;
 	__u64 ucnt;
 	DECLARE_WAITQUEUE(wait, current);
 
 	if (count < sizeof(ucnt))
 		return -EINVAL;
-	if (copy_from_user(&ucnt, buf, sizeof(ucnt)))
+	if (copy_from_iter(&ucnt, count, from) != count)
 		return -EFAULT;
 	if (ucnt == ULLONG_MAX)
 		return -EINVAL;
@@ -282,7 +283,8 @@ static ssize_t eventfd_write(struct file *file, const char __user *buf, size_t c
 	res = -EAGAIN;
 	if (ULLONG_MAX - ctx->count > ucnt)
 		res = sizeof(ucnt);
-	else if (!(file->f_flags & O_NONBLOCK)) {
+	else if (!(file->f_flags & O_NONBLOCK) &&
+		 !(kiocb->ki_flags & IOCB_NOWAIT)) {
 		__add_wait_queue(&ctx->wqh, &wait);
 		for (res = 0;;) {
 			set_current_state(TASK_INTERRUPTIBLE);
@@ -331,7 +333,7 @@ static const struct file_operations eventfd_fops = {
 	.release	= eventfd_release,
 	.poll		= eventfd_poll,
 	.read_iter	= eventfd_read,
-	.write		= eventfd_write,
+	.write_iter	= eventfd_write,
 	.llseek		= noop_llseek,
 };
 

-- 
Jens Axboe

