Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2305FFC9E5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2019 16:27:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfKNP1G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Nov 2019 10:27:06 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:39385 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbfKNP1G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Nov 2019 10:27:06 -0500
Received: by mail-io1-f67.google.com with SMTP id k1so7222765ioj.6
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Nov 2019 07:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Pb54/52KiePo49EfwninY5VWqB/XGPD0qnr9bLS7S8k=;
        b=rDovllybZqP1ZDWSHLZO6REyTT9oYLVsCxmcdg0WVk1ON7+4YYdxZU+I7l/0XAUoJF
         tmcEP6qLPv2dEzCfH04xvQpTf5Sbw85Kpn3OnVNT5YgESlrv20DxTucx6+EeAT8w3r9z
         lNMBxbUVDl4tQZx6P/rmmzppXh/cBEWrh/zOuc68bss/MPoI1B9xRWUiLM6wJUiXe9uo
         TpjdAI0/OSvNka5ShdqM5Wkzc6gRP60UGMC3IfA6llkqWpnRZRZKukjE/ohBrdK6qTrI
         e4gfzoFBUvL3r2A7PyfoAjpCphwcunR48nIaKrIJIKE+ml7Bnf1orU/t4tvyjQNVNbK1
         sjPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Pb54/52KiePo49EfwninY5VWqB/XGPD0qnr9bLS7S8k=;
        b=pjDDD2ZYPXfUglEkIbungJ4pHOUxbVho//V1v74aQR7aP29LWbW2XzOSqySQWw09/8
         Ivs1q7JeGRmnPse7fTqNwLIj1Uf4koNq5gk49B3KBejWaxvSLQ1VoKiS/L9IzQhWk2Ye
         pH9Q1sHIP4whIvNDwtG/Y1Gfk0M5xLV3m3f+smvzi0KY8zQa+o513FFk6xXZvBnNBQ0N
         YCgrRAqsZpKkIAgcI2g+/ENspwwukQyul49/oJO17rZHmRZXw4dwS0qm1YL7VQaOh1yG
         vOAdZ7XK+SJHdhMr9mbylFFZ1l4YAZIBlIw1iwqX0vuKzELEHh6KXTE0e/ljIIw/O0aN
         runQ==
X-Gm-Message-State: APjAAAU62YdSahCfIj43Vq0LYPfe7H34lA8l/nqGKAE0wl8KaaQaAvJy
        nMTbqD5idMAXGEglHJZPGWu3tg==
X-Google-Smtp-Source: APXvYqx1+iuEaN6EUrTxHKiCZEEYpCjAm3a95rr/NdSaR3TjFHN0j33g5FebNu1FhXcgleCf8DQBxQ==
X-Received: by 2002:a02:a086:: with SMTP id g6mr8065764jah.56.1573745223480;
        Thu, 14 Nov 2019 07:27:03 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id l63sm505052ioa.19.2019.11.14.07.27.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Nov 2019 07:27:02 -0800 (PST)
Subject: Re: [PATCH RFC] io_uring: make signalfd work with io_uring (and aio)
 POLL
From:   Jens Axboe <axboe@kernel.dk>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jann Horn <jannh@google.com>
Cc:     io-uring@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
References: <58059c9c-adf9-1683-99f5-7e45280aea87@kernel.dk>
 <58246851-fa45-a72d-2c42-7e56461ec04e@kernel.dk>
 <ec3526fb-948a-70c0-4a7b-866d6cd6a788@rasmusvillemoes.dk>
 <CAG48ez3dpphoQGy8G1-QgZpkMBA2oDjNcttQKJtw5pD62QYwhw@mail.gmail.com>
 <ea7a428d-a5bd-b48e-9680-82a26710ec83@rasmusvillemoes.dk>
 <e568a403-3712-4612-341a-a6f22af877ae@kernel.dk>
 <0f74341f-76fa-93ee-c03e-554d02707053@rasmusvillemoes.dk>
 <6243eb59-3340-deb5-d4b8-08501be01f34@kernel.dk>
Message-ID: <85e8e954-d09c-f0b4-0944-598208098c8c@kernel.dk>
Date:   Thu, 14 Nov 2019 08:27:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <6243eb59-3340-deb5-d4b8-08501be01f34@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/14/19 8:20 AM, Jens Axboe wrote:
> On 11/14/19 8:19 AM, Rasmus Villemoes wrote:
>> On 14/11/2019 16.09, Jens Axboe wrote:
>>> On 11/14/19 7:12 AM, Rasmus Villemoes wrote:
>>
>>>> So, I can't really think of anybody that might be relying on inheriting
>>>> a signalfd instead of just setting it up in the child, but changing the
>>>> semantics of it now seems rather dangerous. Also, I _can_ imagine
>>>> threads in a process sharing a signalfd (initial thread sets it up and
>>>> blocks the signals, all threads subsequently use that same fd), and for
>>>> that case it would be wrong for one thread to dequeue signals directed
>>>> at the initial thread. Plus the lifetime problems.
>>>
>>> What if we just made it specific SFD_CLOEXEC?
>>
>> O_CLOEXEC can be set and removed afterwards. Sure, we're far into
>> "nobody does that" land, but having signalfd() have wildly different
>> semantics based on whether it was initially created with O_CLOEXEC seems
>> rather dubious.
>>
>>    I don't want to break
>>> existing applications, even if the use case is nonsensical, but it is
>>> important to allow signalfd to be properly used with use cases that are
>>> already in the kernel (aio with IOCB_CMD_POLL, io_uring with
>>> IORING_OP_POLL_ADD). Alternatively, if need be, we could add a specific
>>> SFD_ flag for this.
>>
>> Yeah, if you want another signalfd flavour, adding it via a new SFD_
>> flag seems the way to go. Though I can't imagine the resulting code
>> would be very pretty.
> 
> Well, it's currently _broken_ for the listed in-kernel use cases, so
> I think making it work is the first priority here.

How about something like this, then? Not tested.

diff --git a/fs/signalfd.c b/fs/signalfd.c
index 44b6845b071c..d8b183ec1d4e 100644
--- a/fs/signalfd.c
+++ b/fs/signalfd.c
@@ -50,6 +50,8 @@ void signalfd_cleanup(struct sighand_struct *sighand)
 
 struct signalfd_ctx {
 	sigset_t sigmask;
+	struct task_struct *task;
+	u32 task_exec_id;
 };
 
 static int signalfd_release(struct inode *inode, struct file *file)
@@ -61,16 +63,22 @@ static int signalfd_release(struct inode *inode, struct file *file)
 static __poll_t signalfd_poll(struct file *file, poll_table *wait)
 {
 	struct signalfd_ctx *ctx = file->private_data;
+	struct task_struct *tsk = ctx->task ?: current;
 	__poll_t events = 0;
 
-	poll_wait(file, &current->sighand->signalfd_wqh, wait);
+	if (ctx->task && ctx->task->self_exec_id == ctx->task_exec_id)
+		tsk = ctx->task;
+	else
+		tsk = current;
 
-	spin_lock_irq(&current->sighand->siglock);
-	if (next_signal(&current->pending, &ctx->sigmask) ||
-	    next_signal(&current->signal->shared_pending,
+	poll_wait(file, &tsk->sighand->signalfd_wqh, wait);
+
+	spin_lock_irq(&tsk->sighand->siglock);
+	if (next_signal(&tsk->pending, &ctx->sigmask) ||
+	    next_signal(&tsk->signal->shared_pending,
 			&ctx->sigmask))
 		events |= EPOLLIN;
-	spin_unlock_irq(&current->sighand->siglock);
+	spin_unlock_irq(&tsk->sighand->siglock);
 
 	return events;
 }
@@ -267,19 +275,26 @@ static int do_signalfd4(int ufd, sigset_t *mask, int flags)
 	/* Check the SFD_* constants for consistency.  */
 	BUILD_BUG_ON(SFD_CLOEXEC != O_CLOEXEC);
 	BUILD_BUG_ON(SFD_NONBLOCK != O_NONBLOCK);
+	BUILD_BUG_ON(SFD_TASK & (SFD_CLOEXEC | SFD_NONBLOCK));
 
-	if (flags & ~(SFD_CLOEXEC | SFD_NONBLOCK))
+	if (flags & ~(SFD_CLOEXEC | SFD_NONBLOCK | SFD_TASK))
+		return -EINVAL;
+	if ((flags & (SFD_CLOEXEC | SFD_TASK)) == SFD_TASK)
 		return -EINVAL;
 
 	sigdelsetmask(mask, sigmask(SIGKILL) | sigmask(SIGSTOP));
 	signotset(mask);
 
 	if (ufd == -1) {
-		ctx = kmalloc(sizeof(*ctx), GFP_KERNEL);
+		ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
 		if (!ctx)
 			return -ENOMEM;
 
 		ctx->sigmask = *mask;
+		if (flags & SFD_TASK) {
+			ctx->task = current;
+			ctx->task_exec_id = current->self_exec_id;
+		}
 
 		/*
 		 * When we call this, the initialization must be complete, since
diff --git a/include/uapi/linux/signalfd.h b/include/uapi/linux/signalfd.h
index 83429a05b698..064c5dc3eb99 100644
--- a/include/uapi/linux/signalfd.h
+++ b/include/uapi/linux/signalfd.h
@@ -16,6 +16,7 @@
 /* Flags for signalfd4.  */
 #define SFD_CLOEXEC O_CLOEXEC
 #define SFD_NONBLOCK O_NONBLOCK
+#define SFD_TASK 00000001
 
 struct signalfd_siginfo {
 	__u32 ssi_signo;

-- 
Jens Axboe

