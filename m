Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 993752C2B51
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 16:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388502AbgKXPa3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 10:30:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728426AbgKXPa2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 10:30:28 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD256C0613D6
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2020 07:30:28 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id s21so64636pfu.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2020 07:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eMDUIiphwgQu/Rl/7QXTUEvd8hL5aoXhajraaKwKCps=;
        b=08jMZAO19NC9YGv7ez1yKZVfbZHhH83VeOXbl5BSm1jpFljRj8AfKYBbquA1RFDkPd
         VlraeOIrzu9B5B6/lgakO3mOkna3BHnN3ELg+Z6NC9l5pqZ9HFTP5TPyAEILiEZW9Ucd
         fftOP2GSFWUomHxVtCLr//vdPyaFZafYwCwkvKrjXwT/VeVcTEahuhW7V6ppBKxUDPUI
         PlNZSAZ6RMMC6ayPh9uaYs4fF7QgyMrGLbf80wTTczF/nZjKeQ3ePt0cJeg7IFzSmeim
         6doUr62NdtL/CXelB9IFsVHFom1ra/hsQoRcja0CZdnKBUDdb03bP3h3dRCfvJAqh1bi
         ibSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eMDUIiphwgQu/Rl/7QXTUEvd8hL5aoXhajraaKwKCps=;
        b=pw1u1wDdakXO2e8surUStJX0D38AH5DhoZxg8PjLYYbQjxj5cyXCBXBfI/gQSOsEyg
         yFxlvWXB4sgrUBSq95Lwkbq6zGazZf65t/fa7kuJ8BOB+wz1rmX4M3eFrJ6mpY5v2n/w
         JVuB/CX3Gy1+hseIvr/4+Tq55OV2YTaz3ZZST9jiwctYmr1UTE2d1PJzp307lNjYcv1f
         Un9XGAmRJMjryigA+cHsUWw5DyNoS/8MDKayvdcYfmxOJi1RcyhOWYe3NiZBn1aa9C5X
         HuYcgp9NvcpqUK6WSsFrVwHAp5xR4GtukKVnWR0Gz80bxegd10ht8EB+hcFdxfUFiTNd
         9Z2g==
X-Gm-Message-State: AOAM53245tnCZjRFojluds2uKveRgrvfKj/rJzqGao3QKlOUCcrSGI2N
        Sh0fMp/jOatm47N+kZqIqrK88g==
X-Google-Smtp-Source: ABdhPJzgTdOGgxS19PCgtmRGESJ4KGJeMYsFILdAGpKHr15AmdL2UFHLUgRjeSs+TeBNwaQM8zLKLQ==
X-Received: by 2002:a17:90a:4601:: with SMTP id w1mr5612148pjg.109.1606231828348;
        Tue, 24 Nov 2020 07:30:28 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id ne22sm3574644pjb.45.2020.11.24.07.30.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2020 07:30:27 -0800 (PST)
Subject: Re: [PATCH 01/29] iov_iter: Switch to using a table of operations
To:     David Howells <dhowells@redhat.com>,
        Pavel Begunkov <asml.silence@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <74f6fb34-c4c2-6a7e-3614-78c34246c6bd@gmail.com>
 <20201123080506.GA30578@infradead.org>
 <160596800145.154728.7192318545120181269.stgit@warthog.procyon.org.uk>
 <160596801020.154728.15935034745159191564.stgit@warthog.procyon.org.uk>
 <516984.1606127474@warthog.procyon.org.uk>
 <1155891.1606222222@warthog.procyon.org.uk>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5b8ce555-7451-d977-22e7-e5d080ef2e1a@kernel.dk>
Date:   Tue, 24 Nov 2020 08:30:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1155891.1606222222@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/24/20 5:50 AM, David Howells wrote:
> Pavel Begunkov <asml.silence@gmail.com> wrote:
> 
>> fio is relatively heavy, I'd suggest to try fio/t/io_uring with nullblk
> 
> no patches:

Here's what I get. nullb0 using blk-mq, and submit_queues==NPROC.
iostats and merging disabled, using 8k bs for t/io_uring to ensure we
have > 1 segment. Everything pinned to the same CPU to ensure
reproducibility and stability. Kernel has CONFIG_RETPOLINE enabled.

5.10-rc5:
IOPS=2453184, IOS/call=32/31, inflight=128 (128)
IOPS=2435648, IOS/call=32/32, inflight=64 (64)
IOPS=2448544, IOS/call=32/31, inflight=96 (96)
IOPS=2439584, IOS/call=32/31, inflight=128 (128)
IOPS=2454176, IOS/call=32/32, inflight=32 (32)

5.10-rc5+all patches
IOPS=2304224, IOS/call=32/32, inflight=64 (64)
IOPS=2309216, IOS/call=32/32, inflight=32 (32)
IOPS=2305376, IOS/call=32/31, inflight=128 (128)
IOPS=2300544, IOS/call=32/32, inflight=128 (128)
IOPS=2301728, IOS/call=32/32, inflight=32 (32)

which looks to be around a 6% drop.

Using actual hardware instead of just null_blk:

5.10-rc5:
IOPS=854163, IOS/call=31/31, inflight=101 (101)
IOPS=855495, IOS/call=31/31, inflight=117 (117)
IOPS=856118, IOS/call=31/31, inflight=100 (100)
IOPS=855863, IOS/call=31/31, inflight=113 (113)
IOPS=856282, IOS/call=31/31, inflight=116 (116)

5.10-rc5+all patches
IOPS=833391, IOS/call=31/31, inflight=100 (100)
IOPS=838342, IOS/call=31/31, inflight=100 (100)
IOPS=839921, IOS/call=31/31, inflight=105 (105)
IOPS=841607, IOS/call=31/31, inflight=123 (123)
IOPS=843625, IOS/call=31/31, inflight=107 (107)

which looks to be around 2-3%, but we're also running at a much
slower rate (830K vs ~2.3M).

-- 
Jens Axboe

