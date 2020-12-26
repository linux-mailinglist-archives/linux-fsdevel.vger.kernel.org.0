Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD2B02E2EC2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Dec 2020 18:36:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbgLZReL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 26 Dec 2020 12:34:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbgLZReL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 26 Dec 2020 12:34:11 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5E0C061757
        for <linux-fsdevel@vger.kernel.org>; Sat, 26 Dec 2020 09:33:24 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id t8so6026015iov.8
        for <linux-fsdevel@vger.kernel.org>; Sat, 26 Dec 2020 09:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BRRvEHBtMmOBDBtjdzFWGrZQEv1CCLLwU6vmZYMHbCo=;
        b=cgAmTgm2g5GLXXE6dsP3zivbLQiOlKCN+B12MQaEqkJzqJbwG0foRoyeu+oU/m6T+4
         Fz44nDO9m4lrDI3o+8OPpfXFmt4PykMO2PkDD6XkZ6KatJcooy5cqHgBRMxeq9XkxHtC
         a5qeRK7LJast7GSHxCqh8+vZ7sciryI7gnJNZ7ZCKFCWCy1TpYcZSq0dEQNZZcmxWX5I
         rkAbHy2dQLH8ZHq9oxTRyUZnebwpLg9upS340nMTz86XJxPW+6Uel7oHTmbY5NsF1Idq
         oh0Y8HlJlLvbf8ZJmOuARW/P9GG2x9lDGM+dBlixqCnDO8Csz4qZSmlYS85ewFLyiyMy
         FaCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BRRvEHBtMmOBDBtjdzFWGrZQEv1CCLLwU6vmZYMHbCo=;
        b=GF/QiWboOCRP/a8QuAQGAX4BWX6OtVkRID4yviW1FhTi8Y8SL9JRw27qA78NIurd5Q
         6Dlvc7vejJV5IsoEJDO7clMROCn3IO1vEeivpQy6DoIEwJdIdwcKLU1i5CZho9g71QbT
         PV93TfzuqEUdwwaRXKqNzMXDLt2VXqj5FCIL9zWMc4YAJTejisivSAa5gOfmpNo3XMu3
         chJHww6lcG6knhuPj4HnnQiGmVQFrg7OrHWtUvou0zFiRU0AojgwsKXqpJdAuBwtc5TD
         HHsV6TzJrtTE00mMU6cgUipY0j3BcnAkzj/CTUyYw8FONbHqNvyN2jGsmWjklsDfTSKb
         9Prg==
X-Gm-Message-State: AOAM53254xUJ2uNxILV7lxc+dKdH9DB2FXNYNbY77z0UwT+n0cAA9N2u
        7G1KWPljGni+oPrGfJceH0nCy8JTrCT3GA==
X-Google-Smtp-Source: ABdhPJwqqmwCdlsD5FfCek+UJcoi0ll+4BgCFXMcvpowYuq4V16D/RZUFneEbVnYzievsxWzVjRytw==
X-Received: by 2002:a5d:9a8e:: with SMTP id c14mr31683251iom.178.1609004003912;
        Sat, 26 Dec 2020 09:33:23 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id v10sm23459324ilu.58.2020.12.26.09.33.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Dec 2020 09:33:23 -0800 (PST)
Subject: Re: [PATCH 1/4] fs: make unlazy_walk() error handling consistent
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org
References: <20201217161911.743222-1-axboe@kernel.dk>
 <20201217161911.743222-2-axboe@kernel.dk>
 <66d1d322-42d4-5a46-05fb-caab31d0d834@kernel.dk>
 <20201226045043.GA3579531@ZenIV.linux.org.uk>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9ce193e7-8609-7d96-4719-f1b316c927e6@kernel.dk>
Date:   Sat, 26 Dec 2020 10:33:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201226045043.GA3579531@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/25/20 9:50 PM, Al Viro wrote:
> On Fri, Dec 25, 2020 at 07:41:17PM -0700, Jens Axboe wrote:
>> On 12/17/20 9:19 AM, Jens Axboe wrote:
>>> Most callers check for non-zero return, and assume it's -ECHILD (which
>>> it always will be). One caller uses the actual error return. Clean this
>>> up and make it fully consistent, by having unlazy_walk() return a bool
>>> instead. Rename it to try_to_unlazy() and return true on success, and
>>> failure on error. That's easier to read.
>>
>> Al, were you planning on queuing this one up for 5.11 still? I'm fine
>> with holding for 5.12 as well, would just like to know what your plans
>> are. Latter goes for the whole series too, fwiw.
> 
> Seeing that it has not sat in -next at all, what I'm going to do is
> to put it into 5.11-rc1-based branch.  It's really been too late for
> something like that for this cycle and IME a topic branch started
> before the merges for previous cycle are over is too likely to require
> backmerges, if not outright rebases.  So let's branch it at -rc1 and
> it'll go into #for-next from the very beginning.

That sounds fine, thanks Al. Will you queue up 1-3 in a stable branch?
Then I can just pull that into mine for the io_uring bits. I'll also
then post the stat part of this too, for separate review.

BTW, I wrote a man page addition for openat2(2) for RESOLVE_CACHED:

commit 3b381a6bc50da79eee6a3a1da330480d0cb46302
Author: Jens Axboe <axboe@kernel.dk>
Date:   Thu Dec 17 14:15:15 2020 -0700

    man2/openat2.2: add RESOLVE_CACHED
    
    RESOLVE_CACHED allows an application to attempt a cache-only open
    of a file. If this isn't possible, the request will fail with
    -1/EAGAIN and the caller should retry without RESOLVE_CACHED set.
    This will generally happen from a different context, where a slower
    open operation can be performed.
    
    Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/man2/openat2.2 b/man2/openat2.2
index 3bda20620574..f5af3eee2cda 100644
--- a/man2/openat2.2
+++ b/man2/openat2.2
@@ -385,6 +385,17 @@ This may occur if, for example,
 a system pathname that is used by an application is modified
 (e.g., in a new distribution release)
 so that a pathname component (now) contains a bind mount.
+.TP
+.B RESOLVE_CACHED
+Make the open operation fail unless all path components are already present
+in the kernels lookup cache.
+If any kind of revalidation or IO is needed to satisfy the lookup,
+.BR openat2 ()
+fails with the error
+.B EAGAIN.
+This is useful in providing a fast path open that can be performed without
+resorting to thread offload, or other mechanism that an application might
+use to offload slower operations.
 .RE
 .IP
 If any bits other than those listed above are set in
@@ -421,6 +432,14 @@ The caller may choose to retry the
 .BR openat2 ()
 call.
 .TP
+.B EAGAIN
+.BR RESOLVE_CACHED
+was set, and the open operation cannot be performed cached.
+The caller should retry without
+.B RESOLVE_CACHED
+set in
+.I how.resolve
+.TP
 .B EINVAL
 An unknown flag or invalid value was specified in
 .IR how .

-- 
Jens Axboe

