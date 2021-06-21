Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC803AEC2F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jun 2021 17:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbhFUPXl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Jun 2021 11:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbhFUPXj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Jun 2021 11:23:39 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D16C061574
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Jun 2021 08:21:25 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id h2so4491023iob.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Jun 2021 08:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FoYVPU+/81/kxRVo//CsqnsQ39sxiglhfi6WXfWMPPw=;
        b=TczxbmsZ0TBuxNenkEcIPigIGzGo8RDEtowYkwvwjJ/PDoqFY3SHvCtzagmydJPVbf
         RRxtgIGKUCL7u6VK2l851rMUa5pYWg1jwspH4ne+XY8bhXaHtoJfwUZduPQr+MIjKz9h
         274UYTlXqM3qamZBUTE4pqKCMFXk8TXj5dVJXxVj+5AhYeH6DNdP0LNjOa1WIhCXKXEN
         3E3mFyrvJbi3hgvcyy7RxFnlMc1spYh5Xz89xO4xuhg4hSgcMtqpMUPzFuhITNECY5ts
         GJv9oAExKPPwI0lq0p8arwolZFkdNpll6ESbfC5230lIMVSfyGbSkqm7ngixmb/fRP4h
         HQNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FoYVPU+/81/kxRVo//CsqnsQ39sxiglhfi6WXfWMPPw=;
        b=PseoHfDt+sDygImsf7Soi1XqvrD9mUqSMe0ePlOZhzpf0+EF7SLYPJoYHYMtYIntiy
         yA1j5F0wm+byxp5x2YVBH2oTBueiAKl+CteMRVLDmgVGhqqXmLfyoLEB2n+Yx1HkAX4f
         jZdU0aGQeCVUh7uRsHnjN9qpxxrYb46LjevhE2EXQJ7SpxLgsbq5lyDDgdt2Tf/yh8wy
         GtgATMkQkgtPhKMziLIA05EDnA+FIhzjCclvxI8Yq1Lp3YUHAxFSZhcX0DxNJwxpVxHS
         C524jSSxrXONnpCZp6SC1nLS4Umlp1SL6b4xsoulBMvcPsStphOgY1521mkfLqVzZWQ9
         QpyA==
X-Gm-Message-State: AOAM530czslFD9cDDEi0RqIo/1hqMGEAoHa7n5xYGlr5+3eacKzJT2ul
        kovA9RdvgzVSJI/whXS4S1VIag==
X-Google-Smtp-Source: ABdhPJyaw4Qwe0FnWYX/+0psK8VaRkjTETHQgSVaDbPZi/8+myH87JO985ENplKf1huFFb8XBhXwmQ==
X-Received: by 2002:a02:2a07:: with SMTP id w7mr15259305jaw.96.1624288884799;
        Mon, 21 Jun 2021 08:21:24 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id j4sm9920658iom.28.2021.06.21.08.21.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jun 2021 08:21:24 -0700 (PDT)
Subject: Re: [PATCH v5 00/10] io_uring: add mkdir, [sym]linkat and mknodat
 support
From:   Jens Axboe <axboe@kernel.dk>
To:     Dmitry Kadashev <dkadashev@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Pavel Begunkov <asml.silence@gmail.com>,
        linux-fsdevel@vger.kernel.org, io-uring <io-uring@vger.kernel.org>
References: <20210603051836.2614535-1-dkadashev@gmail.com>
 <CAOKbgA69B=nnNOaHH239vegj5_dRd=9Y-AcQBCD3viLxcH=LiQ@mail.gmail.com>
 <2c4d5933-965e-29b5-0c76-3f2e5f518fe8@kernel.dk>
Message-ID: <a459abe3-b051-ea60-d8d9-412562a255d5@kernel.dk>
Date:   Mon, 21 Jun 2021 09:21:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <2c4d5933-965e-29b5-0c76-3f2e5f518fe8@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/18/21 10:10 AM, Jens Axboe wrote:
> On 6/18/21 12:24 AM, Dmitry Kadashev wrote:
>> On Thu, Jun 3, 2021 at 12:18 PM Dmitry Kadashev <dkadashev@gmail.com> wrote:
>>>
>>> This started out as an attempt to add mkdirat support to io_uring which
>>> is heavily based on renameat() / unlinkat() support.
>>>
>>> During the review process more operations were added (linkat, symlinkat,
>>> mknodat) mainly to keep things uniform internally (in namei.c), and
>>> with things changed in namei.c adding support for these operations to
>>> io_uring is trivial, so that was done too. See
>>> https://lore.kernel.org/io-uring/20210514145259.wtl4xcsp52woi6ab@wittgenstein/
>>
>> Ping. Jens, are we waiting for the audit change to be merged before this
>> can go in?
> 
> Not necessarily, as that should go in for 5.14 anyway.
> 
> Al, are you OK with the generic changes?

I have tentatively queued this up.

-- 
Jens Axboe

