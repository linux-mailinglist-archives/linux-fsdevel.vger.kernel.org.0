Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52C093D4004
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jul 2021 19:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbhGWRQA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Jul 2021 13:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbhGWRP6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Jul 2021 13:15:58 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC3DC061757
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Jul 2021 10:56:30 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id j21so3545693ioo.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Jul 2021 10:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=34Pe8bE5xOlRF7EDsbVPuwXSX7BdV/HHwwshey5X0LI=;
        b=dipRY5xyLdP1f8LknS9Od4DmvOwbQa07ypsTB9w65eaCSLiCnYa+haJ2mog+hfH3GA
         FseGzkUW3BUmqVu+2Rc8IBueaQgpTTZUHbQcSXD79ig6vy82tPQyFCmXNxtAZPUMXhZY
         A3C4+yq42KxL6/0PPsScsQ2+wmqe8LKr9yb3CqBliSzbEDjJXGSeww7rK41XbHdJThlI
         awgAK5fllqbNJ7nSxKPMQG1UZLYWNpokz3f1/90vo7uNrygJP7HJaUBuYYlmVtgxlp3m
         Cs61fwc2aik/eMbMYZFjo9b0nZ3B8aLsk/aYS1izgS3JNhOcUGJirSNQDNHAAkJBqW35
         tSrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=34Pe8bE5xOlRF7EDsbVPuwXSX7BdV/HHwwshey5X0LI=;
        b=GZyK0LqoE9EV/0s38+0YRVkXfgoW8bKcfiYM5RwlInMZYP3XZpANYlz8ah8dk3YsPS
         eoVR1Ah4Jg185P+iutqm77AJIgFQLEuaLYkoXP4oFQb7j33y8yCgRREN8US5piyOjCei
         s3gBTDYNAQpypxGXGs73FLXgUpazVMuh26rKVDm5EHaWwOJ/kKhKbF3YkaQHrWaQXzRi
         VAFcKhQnq+EmAtnVGmmZuGsQvhLcz8sBswWbcCNryLOficxkSTYWP6dE3qpgcvvmhVcX
         AfPLvFtz/lWT56yv+W8mq+Wd5eoflIRFYjt1G6zhn7BhtneHCU0vN4RXShHfMkHruejq
         7lqA==
X-Gm-Message-State: AOAM532Dp/7rPKJLpieulc5McfGSr7XbPqFP1Kgvjz/o7ciY0q3ewSv8
        q2QPfNy4vkEAy3L8zLnKjp6VPe86WZKXU6VQ
X-Google-Smtp-Source: ABdhPJyZy16aCwI60W9wTLWaKjkJKsgJKGBbmJE8eTV6oTc0hCA5+KuW9Mfvl1ISD2b/2cLZsqgKAg==
X-Received: by 2002:a05:6602:2099:: with SMTP id a25mr4829293ioa.143.1627062990069;
        Fri, 23 Jul 2021 10:56:30 -0700 (PDT)
Received: from [192.168.1.10] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id k21sm18819166ios.0.2021.07.23.10.56.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jul 2021 10:56:29 -0700 (PDT)
Subject: Re: [PATCH 3/3] io_uring: refactor io_sq_offload_create()
From:   Jens Axboe <axboe@kernel.dk>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <cover.1618916549.git.asml.silence@gmail.com>
 <939776f90de8d2cdd0414e1baa29c8ec0926b561.1618916549.git.asml.silence@gmail.com>
 <YPnqM0fY3nM5RdRI@zeniv-ca.linux.org.uk>
 <57758edf-d064-d37e-e544-e0c72299823d@kernel.dk>
 <YPn/m56w86xAlbIm@zeniv-ca.linux.org.uk>
 <a85df247-137f-721c-6056-a5c340eed90e@kernel.dk>
 <YPoI+GYrgZgWN/dW@zeniv-ca.linux.org.uk>
 <8fb39022-ba21-2c1f-3df5-29be002014d8@kernel.dk>
 <YPr4OaHv0iv0KTOc@zeniv-ca.linux.org.uk>
 <c09589ed-4ae9-c3c5-ec91-ba28b8f01424@kernel.dk>
 <591b4a1e-606a-898c-7470-b5a1be621047@kernel.dk>
Message-ID: <640bdb4e-f4d9-a5b8-5b7f-5265b39c8044@kernel.dk>
Date:   Fri, 23 Jul 2021 11:56:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <591b4a1e-606a-898c-7470-b5a1be621047@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/23/21 11:36 AM, Jens Axboe wrote:
> On 7/23/21 11:32 AM, Jens Axboe wrote:
>> Outside of that, we're not submitting off release, only killing anything
>> pending. The only odd case there is iopoll, but that doesn't resubmit
>> here.
> 
> OK perhaps I'm wrong on this one - if we have a pending iopoll request,
> and we run into the rare case of needing resubmit, we are doing that off
> the release path and that should not happen. Hence it could potentially
> happen for iosched and/or low queue depth devices, if you are using a
> ring for pure polling. I'll patch that up.

Will send out two patches for this. Note that I don't see this being a
real issue, as we explicitly gave the ring fd to another task, and being
that this is purely for read/write, it would result in -EFAULT anyway.

-- 
Jens Axboe

