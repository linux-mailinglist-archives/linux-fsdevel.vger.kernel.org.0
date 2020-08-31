Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05E4E257F2D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Aug 2020 19:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728907AbgHaRAR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Aug 2020 13:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728696AbgHaRAQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Aug 2020 13:00:16 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5619FC061575
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Aug 2020 10:00:16 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id w20so6757596iom.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Aug 2020 10:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CbLQBk0R133e+MDPFjATDQhfT0igK9JozJHO4u3nHJo=;
        b=d6yPCmXwt5FGLBwV/ZES7tOSYRtK+dFvQ84oneE8FbPOudw/F9obCuKcExCTBv2xU8
         Yg996gv/t6gB840GiJnWYqFvOlQbbhiPaC9QyN1rSntI/TR1342W1ahmMs1v0GDB5AN8
         VclqhtTHnuoIn9qbMRJ0nLn2oA6IH5tQA1Yh6ll6g+1HTTL0Xdc1137nJ+EEriUp1og1
         P+ZhkDyU4cHTgR8MZrBIBpwOYSaDR2Aa2FrPxVpBRB+PKdsjMFKmcN2G2Uwvup82KqmL
         P8yT1CrB0r1MCMPwiIMBF5Q263Wju3zsIYIRK+ypfXpdc2eDd+FHJx8Xi+L5g2YJmBs4
         AEsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CbLQBk0R133e+MDPFjATDQhfT0igK9JozJHO4u3nHJo=;
        b=ttXye3Olrtb+0W591bX1P6Wdknx2htWND/seLlU56abxA+7DzMnZ2joSagypuGqoLP
         rsivQ9MEGzIfroGcoj0Z47P0ejUNhpBG/ZiEWzWVqAlDeiLPCpewlkDKrsMweBdc+Esr
         Hb598KlQAYrCsuw9Cr4VKLhK3g26tjLKpz8EVmCGEZV3qu+bcBA/axZSPprlPwwM2IZC
         U5xtan4lEEQ1PEfyqpVZD1LyJp9CT+cDazUUhW/eXMKYAa52KWIMt+D5exh4iZ136LXN
         l2O9XAvUjC1wMaHfFzIGaGblSQDSOPbI6y7sDzcCiJ2RQ/r7aGvghR+6N1J2AR9ZWky8
         y0dw==
X-Gm-Message-State: AOAM532igs/zIUkSfVZ/iRQOeU7BIF8fIqZFrl8BQNxWY3nNIFrBfZCo
        rGuYpcIis0QHB0lT+3QAJUhyDeve6/5eicYh
X-Google-Smtp-Source: ABdhPJxzb5DTSBTQVD3ikr0ZEmGMgtzC7QQMSyiCzXtsEvB/wqKU4g2wBcNM+8CrB276HcibCBhgYQ==
X-Received: by 2002:a05:6638:d95:: with SMTP id l21mr2024838jaj.98.1598893215413;
        Mon, 31 Aug 2020 10:00:15 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id c12sm1144003ilm.17.2020.08.31.10.00.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2020 10:00:14 -0700 (PDT)
Subject: Re: [PATCH] fat: Avoid oops when bdi->io_pages==0
To:     Matthew Wilcox <willy@infradead.org>
Cc:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        fsdevel <linux-fsdevel@vger.kernel.org>
References: <87ft85osn6.fsf@mail.parknet.co.jp>
 <b4e1f741-989c-6c9d-b559-4c1ada88c499@kernel.dk>
 <87o8mq6aao.fsf@mail.parknet.co.jp>
 <4010690f-20ad-f7ba-b595-2e07b0fa2d94@kernel.dk>
 <20200831165659.GH14765@casper.infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <33eb2820-894e-a42f-61a5-c25bc52345d5@kernel.dk>
Date:   Mon, 31 Aug 2020 11:00:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200831165659.GH14765@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/31/20 10:56 AM, Matthew Wilcox wrote:
> On Mon, Aug 31, 2020 at 10:39:26AM -0600, Jens Axboe wrote:
>> We really should ensure that ->io_pages is always set, imho, instead of
>> having to work-around it in other spots.
> 
> Interestingly, there are only three places in the entire kernel which
> _use_ bdi->io_pages.  FAT, Verity and the pagecache readahead code.
> 
> Verity:
>                         unsigned long num_ra_pages =
>                                 min_t(unsigned long, num_blocks_to_hash - i,
>                                       inode->i_sb->s_bdi->io_pages);
> 
> FAT:
>         if (ra_pages > sb->s_bdi->io_pages)
>                 ra_pages = rounddown(ra_pages, sb->s_bdi->io_pages);
> 
> Pagecache:
>         max_pages = max_t(unsigned long, bdi->io_pages, ra->ra_pages);
> and
>         if (req_size > max_pages && bdi->io_pages > max_pages)
>                 max_pages = min(req_size, bdi->io_pages);
> 
> The funny thing is that all three are using it differently.  Verity is
> taking io_pages to be the maximum amount to readahead.  FAT is using
> it as the unit of readahead (round down to the previous multiple) and
> the pagecache uses it to limit reads that exceed the current per-file
> readahead limit (but allows per-file readahead to exceed io_pages,
> in which case it has no effect).
> 
> So how should it be used?  My inclination is to say that the pagecache
> is right, by virtue of being the most-used.

When I added ->io_pages, it was for the page cache use case. The others
grew after that...

-- 
Jens Axboe

