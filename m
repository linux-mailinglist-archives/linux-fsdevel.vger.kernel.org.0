Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B075144A9C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2020 04:54:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbgAVDyZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jan 2020 22:54:25 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:40614 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbgAVDyZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jan 2020 22:54:25 -0500
Received: by mail-pj1-f65.google.com with SMTP id bg7so2738122pjb.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jan 2020 19:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tPnmRjn8rUepJ/m/lTDYE4fiV9urBFYj8TZ2cwtsXFs=;
        b=KSpesqrGU/sSuhK+zAQJLJsqmx89sl5iclvzT2IK65oe+ZjRjveqivkcgyc6xXLAE0
         Gf/qWWnkdcchnpxRbyL75OocYw0M7lcckQxf0maZKU0/nVyJTaGR3dsuM2qKMczjsBIc
         ULFRb4+eU4SNt+Hyjc2lGP3MDgAoye2RMno+KvcyR9ygPi3L6NHNyVViIA7Rr5CN2gH7
         7WzbyZQdd0N3CJUUVKxSDmiXVf442Lw5fChMDtGFBYpEU0Q4y3vjqoeWy3N3VoMaKdoN
         b6NhczU6yMwj7hwllwt2/UhOi8Tt8ETnDMO86eqKSj8YVaDvIdAl7RI6Z+jo6Joz3iMe
         eOoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tPnmRjn8rUepJ/m/lTDYE4fiV9urBFYj8TZ2cwtsXFs=;
        b=Tk4dve3eILJjkP5qXW6D5hFEyAhWR4m6aFa6wSwPhxJS5tS6E3OED7wMBQ0XSElXrA
         0cH5a7msFKXEXw5bU3vxbXzVKgUWXo1PnuRtdacpMU2sytwhmBuXLp59xj+ewvphf0Zs
         GEiV3w5HI8QABXUlsx/h2Gz3M4IxseMPalfIl+mM5nbK18gatn5QYxghI1au0dCam45y
         7aLXc9/vDicZk9MQL1MTj+a9xxWzxZDQBAROMzb1mrIjJflSir9Njle9OyPUvA5ubZ8B
         R1bECVl6nAj05dRVyqgcfxizIMzDfdNPHhen75MHFWK3d7Q3deCcZNwH4iapioIkdQcT
         N3VA==
X-Gm-Message-State: APjAAAWgFnH8dGt9DhvPpGgg7egjbPBhy2dYm1OdSTRwLyEnCqrMwGeB
        8JQee1e1sGkCTV4g3+kxisTSwA==
X-Google-Smtp-Source: APXvYqz1ej/0UETLM0i3GpTnbpg6jU/Jhvxq4kyaua6Pk55bLtlskFqoOIKje0M5VplsB7SIZWO/vg==
X-Received: by 2002:a17:902:302:: with SMTP id 2mr9076370pld.58.1579665264275;
        Tue, 21 Jan 2020 19:54:24 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id d3sm43468307pfn.113.2020.01.21.19.54.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2020 19:54:23 -0800 (PST)
Subject: Re: [LSF/MM/BPF TOPIC] Do not pin pages for various direct-io scheme
To:     jglisse@redhat.com, lsf-pc@lists.linux-foundation.org
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Benjamin LaHaise <bcrl@kvack.org>
References: <20200122023100.75226-1-jglisse@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ba250f19-cc51-f1dc-3236-58be1f291db3@kernel.dk>
Date:   Tue, 21 Jan 2020 20:54:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200122023100.75226-1-jglisse@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/21/20 7:31 PM, jglisse@redhat.com wrote:
> From: Jérôme Glisse <jglisse@redhat.com>
> 
> Direct I/O does pin memory through GUP (get user page) this does
> block several mm activities like:
>     - compaction
>     - numa
>     - migration
>     ...
> 
> It is also troublesome if the pinned pages are actualy file back
> pages that migth go under writeback. In which case the page can
> not be write protected from direct-io point of view (see various
> discussion about recent work on GUP [1]). This does happens for
> instance if the virtual memory address use as buffer for read
> operation is the outcome of an mmap of a regular file.
> 
> 
> With direct-io or aio (asynchronous io) pages are pinned until
> syscall completion (which depends on many factors: io size,
> block device speed, ...). For io-uring pages can be pinned an
> indifinite amount of time.
> 
> 
> So i would like to convert direct io code (direct-io, aio and
> io-uring) to obey mmu notifier and thus allow memory management
> and writeback to work and behave like any other process memory.
> 
> For direct-io and aio this mostly gives a way to wait on syscall
> completion. For io-uring this means that buffer might need to be
> re-validated (ie looking up pages again to get the new set of
> pages for the buffer). Impact for io-uring is the delay needed
> to lookup new pages or wait on writeback (if necessary). This
> would only happens _if_ an invalidation event happens, which it-
> self should only happen under memory preissure or for NUMA
> activities.
> 
> They are ways to minimize the impact (for instance by using the
> mmu notifier type to ignore some invalidation cases).
> 
> 
> So i would like to discuss all this during LSF, it is mostly a
> filesystem discussion with strong tie to mm.

I'd be interested in this topic, as it pertains to io_uring. The whole
point of registered buffers is to avoid mapping overhead, and page
references. If we add extra overhead per operation for that, well... I'm
assuming the above is strictly for file mapped pages? Or also page
migration?

-- 
Jens Axboe

