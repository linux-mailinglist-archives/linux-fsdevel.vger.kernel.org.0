Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD356FBEB1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2019 05:49:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbfKNEtm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Nov 2019 23:49:42 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34796 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbfKNEtl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Nov 2019 23:49:41 -0500
Received: by mail-pg1-f193.google.com with SMTP id z188so2904532pgb.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Nov 2019 20:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sfkuMUsk/SV9FHy+miwKwO0qh9BP5ORMbQaGtLeZyoc=;
        b=metflymBEPmiF5pgfQ0LZSX1Dz4TrQiQ6/kwX6D+oqJ0xSd4vW61ubqLpojLIy7p4A
         g/J+3d2S/+P9UE3Zx9Ubtq4AV0Xe15d4MBxAnFtwIIlp6J2tPAhn2CxMl9Vb+RsneYV2
         HcuSm+PNV4nN8PkG61QCRPDH9ZCTsI27mgl8qezxImz0PiHkruotmzh+0CykSK14EA/b
         voFBSGomDxNqgJvb5RJB9ZS4T+IQu2PCFxOFwy1TzkaxjkLOIwJ/9mpdeHqv3UJ6VkzB
         uyr5MRS7Xj095vdxuqE0sPf70xlHEmX0lz4Px0/ZLiJF3eDVWueETtAPGPetZUtd6216
         za9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sfkuMUsk/SV9FHy+miwKwO0qh9BP5ORMbQaGtLeZyoc=;
        b=fNxSQbgAJraBiqWkAOXjwQTkyxc6WffVd2UvrU5NcbfjqtlC3YUfPKG+lUET08JdDo
         P9Lvh+rWE3soc4CLqdKaBQR0t9y8NdymuEm+XJup1xlWb4AHzkO1kUcHtak1/aQ0VAOL
         yUD2RmuYRHODTNx0G9TOptcDFUWcbf+Nx5OFNpQL5BszLJyIq/PoJUA3KROAbmwsqarb
         QF7DlVkMDLHb2IrWE57uUkebSpBBY5JhPPRNc/ZF8o6Oc038Qs5faS+DpeGomxLvKWQx
         dZlwWPT6O4fDZ3wR7tk4C/LdBEqStJV3ROdY1eQMMlLDGZ/YIr0kpgfMo5L+xlfICh5u
         UCkA==
X-Gm-Message-State: APjAAAVjCkSF+ufsznpzkauoU2nnOHPWCdx3zm4WLwKNxSDkHSxv2MO1
        /IGEz4fiTK6H0KjXfdrN69kdRFwhvXE=
X-Google-Smtp-Source: APXvYqz3czEKj7TamiP4er9SMcbQHENT3JWGo1hXUXF6T1DpiFs41gDFFA8oePRaUtC/r23jp2WEIg==
X-Received: by 2002:a17:90a:c56:: with SMTP id u22mr9683616pje.24.1573706980964;
        Wed, 13 Nov 2019 20:49:40 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id d25sm4828349pfq.70.2019.11.13.20.49.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Nov 2019 20:49:40 -0800 (PST)
Subject: Re: [PATCH RFC] io_uring: make signalfd work with io_uring (and aio)
 POLL
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
References: <58059c9c-adf9-1683-99f5-7e45280aea87@kernel.dk>
Message-ID: <58246851-fa45-a72d-2c42-7e56461ec04e@kernel.dk>
Date:   Wed, 13 Nov 2019 21:49:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <58059c9c-adf9-1683-99f5-7e45280aea87@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/13/19 9:31 PM, Jens Axboe wrote:
> This is a case of "I don't really know what I'm doing, but this works
> for me". Caveat emptor, but I'd love some input on this.
> 
> I got a bug report that using the poll command with signalfd doesn't
> work for io_uring. The reporter also noted that it doesn't work with the
> aio poll implementation either. So I took a look at it.
> 
> What happens is that the original task issues the poll request, we call
> ->poll() (which ends up with signalfd for this fd), and find that
> nothing is pending. Then we wait, and the poll is passed to async
> context. When the requested signal comes in, that worker is woken up,
> and proceeds to call ->poll() again, and signalfd unsurprisingly finds
> no signals pending, since it's the async worker calling it.
> 
> That's obviously no good. The below allows you to pass in the task in
> the poll_table, and it does the right thing for me, signal is delivered
> and the correct mask is checked in signalfd_poll().
> 
> Similar patch for aio would be trivial, of course.

From the probably-less-nasty category, Jann Horn helpfully pointed out
that it'd be easier if signalfd just looked at the task that originally
created the fd instead. That looks like the below, and works equally
well for the test case at hand.

diff --git a/fs/signalfd.c b/fs/signalfd.c
index 44b6845b071c..cc72b5b08946 100644
--- a/fs/signalfd.c
+++ b/fs/signalfd.c
@@ -50,6 +50,7 @@ void signalfd_cleanup(struct sighand_struct *sighand)
 
 struct signalfd_ctx {
 	sigset_t sigmask;
+	struct task_struct *task;
 };
 
 static int signalfd_release(struct inode *inode, struct file *file)
@@ -63,14 +64,14 @@ static __poll_t signalfd_poll(struct file *file, poll_table *wait)
 	struct signalfd_ctx *ctx = file->private_data;
 	__poll_t events = 0;
 
-	poll_wait(file, &current->sighand->signalfd_wqh, wait);
+	poll_wait(file, &ctx->task->sighand->signalfd_wqh, wait);
 
-	spin_lock_irq(&current->sighand->siglock);
-	if (next_signal(&current->pending, &ctx->sigmask) ||
-	    next_signal(&current->signal->shared_pending,
+	spin_lock_irq(&ctx->task->sighand->siglock);
+	if (next_signal(&ctx->task->pending, &ctx->sigmask) ||
+	    next_signal(&ctx->task->signal->shared_pending,
 			&ctx->sigmask))
 		events |= EPOLLIN;
-	spin_unlock_irq(&current->sighand->siglock);
+	spin_unlock_irq(&ctx->task->sighand->siglock);
 
 	return events;
 }
@@ -280,6 +281,7 @@ static int do_signalfd4(int ufd, sigset_t *mask, int flags)
 			return -ENOMEM;
 
 		ctx->sigmask = *mask;
+		ctx->task = current;
 
 		/*
 		 * When we call this, the initialization must be complete, since

-- 
Jens Axboe

