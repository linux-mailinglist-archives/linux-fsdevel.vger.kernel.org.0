Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40D472E2EF2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Dec 2020 19:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbgLZSYr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 26 Dec 2020 13:24:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbgLZSYr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 26 Dec 2020 13:24:47 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 312D5C061757
        for <linux-fsdevel@vger.kernel.org>; Sat, 26 Dec 2020 10:24:07 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id e2so4892317pgi.5
        for <linux-fsdevel@vger.kernel.org>; Sat, 26 Dec 2020 10:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jSrK72G+LTRB59CVRGVZLVEHqQGskT1SJE3WCaELUco=;
        b=OXJWmMsj95kAmFcKp7NT4K7wAVvL+pAN1HgGTEYLIy2iSK82XZ6K/GSTZbQ8ZntpgT
         WIi9dK05eUXwkJLN67V+PbEtWUOFGYGdWgxJ1iL83cyPRwHq9Rh9k2P5J0mEyztQhibo
         M+Svr6V82pCw+LR0rw1hea5i4V4qzej9vkZFp5IVHNVZnquaJwkOrCiiUZinDLo6uokq
         BEoQdFr4WrHsehGtXBLA4FlncYqGLqtXju8gDkYaH2pUigL8JW/tIq9JnbpiAI0aw9Fu
         l0baCJUlckLTfihejxSC9gKEurgLiE6AkMQGFIi64znPQ/sO0cC7LROGuvENWHgxNEe/
         BWLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jSrK72G+LTRB59CVRGVZLVEHqQGskT1SJE3WCaELUco=;
        b=shvQd+81ND5Wf3FTqgqOy/Vk3uEWFCoJzsWjvUpJ8/LI8RswIG9I0m96L4Ro9K52pL
         tDxldPwemc/rIEegc+7DFPoGRSUQV+hWZebN1r6racnrUo/oJv0GmqXhY0f+LydFHIPG
         cz1JS5inh9TQNQ9IYXzWrQh5EJ7N88F7XZuGL2hJb55XVT/YcvQ0K31YmlWz92o5gMYe
         +eF8hS3HU7TVnQBUVmctC104sBRTXTYz/QgwA4g+1xjbICXBJEZX7oDpYxg6gJOY5xh8
         kxqoR5IXe9bbLP+v7obbm1cIAa3KzUNloAplnq6cFFpMoZUcPKn63jdpzjL1xsTOPZVR
         5S9g==
X-Gm-Message-State: AOAM5335em6Pk9HS+LSD9g+iV/lAX7YF4c71W6wx//m9ZyUO+PbYZ33j
        eXJqh3WBSq+3XowbB4WeB1JymeMzeu2B6A==
X-Google-Smtp-Source: ABdhPJxKx6+5oviqTK+nRSQdnRnQDra+NldCNilUAtR/NzuL22dTQURfsMVI1wHhcr8j8GnKIOEoAA==
X-Received: by 2002:a63:4563:: with SMTP id u35mr36252074pgk.162.1609007046689;
        Sat, 26 Dec 2020 10:24:06 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id j3sm8486099pjs.50.2020.12.26.10.24.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Dec 2020 10:24:06 -0800 (PST)
Subject: Re: [PATCH 1/4] fs: make unlazy_walk() error handling consistent
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        torvalds@linux-foundation.org
References: <20201217161911.743222-1-axboe@kernel.dk>
 <20201217161911.743222-2-axboe@kernel.dk>
 <66d1d322-42d4-5a46-05fb-caab31d0d834@kernel.dk>
 <20201226045043.GA3579531@ZenIV.linux.org.uk>
 <9ce193e7-8609-7d96-4719-f1b316c927e6@kernel.dk>
 <20201226175801.GV874@casper.infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7f1cbbd7-a6ee-e1d3-e24e-02cb107ac86d@kernel.dk>
Date:   Sat, 26 Dec 2020 11:24:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201226175801.GV874@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/26/20 10:58 AM, Matthew Wilcox wrote:
> On Sat, Dec 26, 2020 at 10:33:25AM -0700, Jens Axboe wrote:
>> +.TP
>> +.B RESOLVE_CACHED
>> +Make the open operation fail unless all path components are already present
>> +in the kernels lookup cache.
>> +If any kind of revalidation or IO is needed to satisfy the lookup,
> 
> Usually spelled I/O in manpages.

Changed, thanks!

>> +.BR openat2 ()
>> +fails with the error
>> +.B EAGAIN.
>> +This is useful in providing a fast path open that can be performed without
>> +resorting to thread offload, or other mechanism that an application might
>> +use to offload slower operations.
> 
> That almost reads backwards ... how about this?
> 
> This provides a fast path open that can be used when an application does
> not wish to block.  It allows the application to hand off the lookup to
> a separate thread which can block.

I deliberately did not want to include anything about blocking, would
prefer to just keep it about having the necessary data/state cached.

-- 
Jens Axboe

