Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92E5D1C1C3B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 May 2020 19:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729807AbgEARtL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 May 2020 13:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729572AbgEARtK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 May 2020 13:49:10 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D232C061A0C
        for <linux-fsdevel@vger.kernel.org>; Fri,  1 May 2020 10:49:10 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id b18so5155800ilf.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 May 2020 10:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FAkF2yaKZTirBIt4k8vbrMCWa7L6IDgN4q10kaek3iU=;
        b=Nu25g7pInQqg92NCuHrYmayuvi3zj47l19mKYK+v6nZ4geQuwZmiJFA0Ii0QRLaf2k
         xhcszlyfj33HWh3Xi5E56xHj2YdoWvAna+nzO5duPolVZHd5AwqU1VwJvEYWiKV5tNrZ
         VVgz6Z8ZDZ1dlDXalq4Xzu5DlrcSogG11QqcmPgyBYcPsqY6QlxwCN7+yTLiZ4xKCo7Z
         5wN4N3ChX/WfdltfWQ01AVZeB/vbq6zulX6fFL5caZZSbqoWdenu5DmZNr0JSsR6zNnz
         7S4JvLkRqEBK1s7dysopowoExTk3x8svJXpsW2HZgqPm4pLLRFkJUqVbqHncgDwv96sp
         7gbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FAkF2yaKZTirBIt4k8vbrMCWa7L6IDgN4q10kaek3iU=;
        b=VJpO6ijeQpeJx1fVwZdPiq5msrHXvUfKp6SL5iMhUjTHBEjl/K1JDBkwNsbJLqx2Xo
         B0x2/SxaX/pHw5B7XB9ZrUgz0Cqiuwjmgwjmtp/qhanoLbzzhH4vLPQ6ie0xjS0IZsFZ
         ru1IXyxm3djWmyhlNK+9bOnZ7gZPAEkcipDidL0zvT/w0EKHV9JcKVUtdIomna2fkdTa
         cmD2WHHwnHi+faVseQswW6RUTbGDrzXZq0iNUbqzZb2oP9vJ0CMJA5Wq1Iu1UQlhsy8R
         CVcAOY5T6gfViwrdhqCvi06mSkA+yi2MwRq+PM06jYIOEuNK2C37lx76F7nnwtPoKM7x
         8xzQ==
X-Gm-Message-State: AGi0PuZZ63IQCPihiayI1K5Mb0PSxyEYdgShAiluyXQ5aWScOrbIm+re
        rjA/TE++pVrz8j7hUiYLaZFh0Q==
X-Google-Smtp-Source: APiQypIjzlOj0z/RyQ2dh1il3B4WXx3fOLCltjGmV8lOFrB8LH4cwP0bYXdcjZVDSR+f+bbE+SWviQ==
X-Received: by 2002:a92:4952:: with SMTP id w79mr4374379ila.15.1588355349738;
        Fri, 01 May 2020 10:49:09 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id d23sm1130687ioc.48.2020.05.01.10.49.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2020 10:49:08 -0700 (PDT)
Subject: Re: [PATCH v2] eventfd: convert to f_op->read_iter()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <c71b2091-a86e-cc81-056d-de2f1e839f50@kernel.dk>
 <20200501174306.GM23230@ZenIV.linux.org.uk>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2fa3e8dc-172e-2ac6-bc5e-a8fea5491e22@kernel.dk>
Date:   Fri, 1 May 2020 11:49:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200501174306.GM23230@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/1/20 11:43 AM, Al Viro wrote:
> On Fri, May 01, 2020 at 11:18:05AM -0600, Jens Axboe wrote:
> 
>> -	if (res > 0 && put_user(ucnt, (__u64 __user *)buf))
>> +	if (res > 0 && copy_to_iter(&ucnt, res, iov) < res)
> 
> *whoa*
> 
> It is correct, but only because here res > 0 <=> res == 8.
> And that's not trivial at the first glance.
> 
> Please, turn that into something like

Looks good to me, just one minor edit:

> 	if (iov_iter_count(to) < sizeof(ucnt))
> 		return -EINVAL;
> 	spin_lock_irq(&ctx->wqh.lock);
> 	if (!ctx->count) {
> 		if (unlikely(file->f_flags & O_NONBLOCK) {
> 			spin_unlock_irq(&ctx->wqh.lock)
> 			return -EAGAIN;
> 		}
> 		__add_wait_queue(&ctx->wqh, &wait);
> 		for (;;) {
> 			set_current_state(TASK_INTERRUPTIBLE);
> 			if (ctx->count)
> 				break;
> 			if (signal_pending(current)) {
> 				spin_unlock_irq(&ctx->wqh.lock)
> 				return -ERESTARTSYS;
> 			}

We need to remove waitq and re-set task state here. I'll run a sanity
check on that and send out a v3.

-- 
Jens Axboe

