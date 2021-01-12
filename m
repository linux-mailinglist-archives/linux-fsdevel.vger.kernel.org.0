Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A10E2F299E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jan 2021 09:02:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730305AbhALICU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jan 2021 03:02:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729208AbhALICU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jan 2021 03:02:20 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A110C061575
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Jan 2021 00:01:39 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id r7so1419572wrc.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Jan 2021 00:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=scylladb-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=PFKDtPo1a0FSfTRkDcyQMlgZTLN7NgoxHkQCz7hEfCA=;
        b=GESr4r8n0hvRkUoSIrlidgelHHjZnaVoSA8VcIUX1g6MPjLaCoWkNBk138OchoNgz3
         rHmZ3fpEfXzLtvLuB2hJDRZF2U6AMEAbF5RQLlonvOh5BQzWDLMebDFLEFy6FGaMN34U
         9haYz1Za50Dx/7BDZzRgUIwHLBnN0jaT9J7k2Ie4QcgQ0LdNV371TUDe3bBfN1bUYQm7
         eirEmoYgZpfXTg9VH6qNa77N7giE9G9R4BbpV3LOn/Amxa5NPURbiIcIcw4wdawlKDdd
         r6PI9Fgdpi0HAcK/Km+kbUhP6vA7imLjzadFEVCjrMzHXuexj0My48/DauJQ//zP9fH9
         shGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=PFKDtPo1a0FSfTRkDcyQMlgZTLN7NgoxHkQCz7hEfCA=;
        b=oLJ++hDdNBHTfKZEGmlYrT6N4+Mt2R5e04GOLRJs3DDHbfjg0+3NFLT0PuCmCChyDK
         S9tVkp4Ix/LWRav0uuAb66lhqyncPNcP9cGX0TPd53NuIkXcFwEyPg+DaDz29cSqChzV
         9IxJAJHOTEOwJ/FAUGjGisQvno6Xe4VudhDFe8CIVvaZXIgM7soyD5A/0ySEaYpAcGzF
         Zxn67yVwmL+9aBNpkNZn5NAyr/b5IeldaiI5kYdla78oqIPlwGXVCkuKZSp9DmqzGMsx
         SiJv2h7jjz3ld1FCJpCg5M7Agq7AChttcRGh7z05o1T7JvSMNJBEqSjYylX97fud/HlO
         AG4g==
X-Gm-Message-State: AOAM530N202QNoJ7lEtbXMJxksxpqGvdu8xJ07VMNN8y7pj/6VuSj/N3
        FS8rG014OhG5PknIJ3oc1OJRoKL74PXumg==
X-Google-Smtp-Source: ABdhPJxN3fb/tsJE+RL8P1VlM1dktkxRYvrs4nrV6ook5U7bcQx1dhKDwLo0Fs/7+/mEl8PzKrVpew==
X-Received: by 2002:adf:fccb:: with SMTP id f11mr2877260wrs.3.1610438498101;
        Tue, 12 Jan 2021 00:01:38 -0800 (PST)
Received: from tmp.scylladb.com (bzq-79-182-3-66.red.bezeqint.net. [79.182.3.66])
        by smtp.googlemail.com with ESMTPSA id g14sm3108482wrd.32.2021.01.12.00.01.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jan 2021 00:01:37 -0800 (PST)
Subject: Re: [RFC] xfs: reduce sub-block DIO serialisation
To:     Dave Chinner <david@fromorbit.com>, linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, andres@anarazel.de
References: <20210112010746.1154363-1-david@fromorbit.com>
From:   Avi Kivity <avi@scylladb.com>
Message-ID: <32f99253-fe56-9198-e47c-7eb0e24fdf73@scylladb.com>
Date:   Tue, 12 Jan 2021 10:01:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210112010746.1154363-1-david@fromorbit.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/12/21 3:07 AM, Dave Chinner wrote:
> Hi folks,
>
> This is the XFS implementation on the sub-block DIO optimisations
> for written extents that I've mentioned on #xfs and a couple of
> times now on the XFS mailing list.
>
> It takes the approach of using the IOMAP_NOWAIT non-blocking
> IO submission infrastructure to optimistically dispatch sub-block
> DIO without exclusive locking. If the extent mapping callback
> decides that it can't do the unaligned IO without extent
> manipulation, sub-block zeroing, blocking or splitting the IO into
> multiple parts, it aborts the IO with -EAGAIN. This allows the high
> level filesystem code to then take exclusive locks and resubmit the
> IO once it has guaranteed no other IO is in progress on the inode
> (the current implementation).


Can you expand on the no-splitting requirement? Does it involve only 
splitting by XFS (IO spans >1 extents) or lower layers (RAID)?


The reason I'm concerned is that it's the constraint that the 
application has least control over. I guess I could use RWF_NOWAIT to 
avoid blocking my main thread (but last time I tried I'd get occasional 
EIOs that frightened me off that). It also seems to me to be the one 
easiest to resolve - perhaps do two passes, with the first verifying the 
other constraints are achieved, or one pass that copies the results in a 
temporary structure that is discarded if the other constraints fail.


> This requires moving the IOMAP_NOWAIT setup decisions up into the
> filesystem, adding yet another parameter to iomap_dio_rw(). So first
> I convert iomap_dio_rw() to take an args structure so that we don't
> have to modify the API every time we want to add another setup
> parameter to the DIO submission code.
>
> I then include Christophs IOCB_NOWAIT fxies and cleanups to the XFS
> code, because they needed to be done regardless of the unaligned DIO
> issues and they make the changes simpler. Then I split the unaligned
> DIO path out from the aligned path, because all the extra complexity
> to support better unaligned DIO submission concurrency is not
> necessary for the block aligned path. Finally, I modify the
> unaligned IO path to first submit the unaligned IO using
> non-blocking semantics and provide a fallback to run the IO
> exclusively if that fails.
>
> This means that we consider sub-block dio into written a fast path
> that should almost always succeed with minimal overhead and we put
> all the overhead of failure into the slow path where exclusive
> locking is required. Unlike Christoph's proposed patch, this means
> we don't require an extra ILOCK cycle in the sub-block DIO setup
> fast path, so it should perform almost identically to the block
> aligned fast path.
>
> Tested using fio with AIO+DIO randrw to a written file. Performance
> increases from about 20k IOPS to 150k IOPS, which is the limit of
> the setup I was using for testing. Also passed fstests auto group
> on a both v4 and v5 XFS filesystems.
>
> Thoughts, comments?
>
> -Dave.
>
>

