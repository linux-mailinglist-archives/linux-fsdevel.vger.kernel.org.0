Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B36ED43E481
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Oct 2021 17:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbhJ1PDE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Oct 2021 11:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbhJ1PDD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Oct 2021 11:03:03 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E34CCC061570
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Oct 2021 08:00:36 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id f9so8375094ioo.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Oct 2021 08:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OvysEMLpCWgv7nMDrXo9isdyt1MuhyUfY0l+6gwvOII=;
        b=1hyPM7a1nffa0V/4nJ7UZKypI9Q+LD282OvBS/Ci5fBw7QB9eOsuvGYxmkG7Vv+w2X
         9UTmlxRi+JxjrAWKuUASOIgMzo2iHpJA+o71gy96KVSFOVlvDQlk1jVceNvO+2h9IeaA
         jLmjVKCO5d6bib5KqqNHcYvVtiK1V1BIbQVIZcH3t8/MuNs4U+NbRq3AIr0Inkoc3gRc
         dW9W0tQpcL0g94QtTTZfrfmhZ8mdPIvDEh9CqFRmrQyfQ/IaD6Qk7OHZhpEnVhcTwjxF
         HtxZDoKoZOB5A1FuVjbuyOVtQcac0+e7AIW8YwaGL/Z8+TLgeiiaUip/z5JQTTQy+HJX
         2pbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OvysEMLpCWgv7nMDrXo9isdyt1MuhyUfY0l+6gwvOII=;
        b=KwurXGI0+yyWE2B5lU0+iYUyQLO7Yo+rkWpIJGss+OknnKmxm+4zUSZEngwVXGS6lX
         06M/6c3G+fiQMyaUSQODEAbNLajkGNuoSLKzURKtXEn9iL+kzljo47z4nplPUszucKAF
         6cWc0ZoTXahcNfloFqYvTHq88ZwNfCbbTvOd7bDcEGyQvgjCGeZMw1h9GsCeqe1Kz2el
         DhCtqV2xUAmn/2yq93MzUYiBnSWfULypUGCuWvJ2UbTlo9wubVcAth7QAZwcPbYBRmk9
         c+7bQ7cMb+mqwgm1u65G+A3OURIAE972IebC82rJyBGGSKSme5Vjrcb7WQnAO0F0mxI6
         iaOw==
X-Gm-Message-State: AOAM533913XVoUH9q2OBwzP23stfpegUnAdOAAUV9W7moBxzKCKZoOEo
        7orT8WlQfXoU175JbvJgBJV2pA==
X-Google-Smtp-Source: ABdhPJyGyQFJfrbjCwShQcQGgYq3VDwz5I/myxpK3tu5MmJm0lqGmO7XNRsNaQKLwj1wSfd3bQ9Aww==
X-Received: by 2002:a6b:f816:: with SMTP id o22mr3605990ioh.106.1635433236229;
        Thu, 28 Oct 2021 08:00:36 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id x9sm1806103ill.83.2021.10.28.08.00.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Oct 2021 08:00:34 -0700 (PDT)
Subject: Re: mm: don't read i_size of inode unless we need it
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Chris Mason <clm@fb.com>,
        Pavel Begunkov <asml.silence@gmail.com>
References: <6b67981f-57d4-c80e-bc07-6020aa601381@kernel.dk>
 <YXqxXXDYtKetgZY0@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d8118299-6576-fae6-e02c-8ae1e25c5d68@kernel.dk>
Date:   Thu, 28 Oct 2021 09:00:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YXqxXXDYtKetgZY0@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/28/21 8:19 AM, Christoph Hellwig wrote:
> Btw, given that you're micro-optimizing in this area:
> 
> block devices still use ->direct_IO in the I/O path.  It might make
> sense to switch to the model of the file systems that use iomap where
> we avoid that indirect call and can optimize the code for the direct
> I/O fast path.  With that you woudn't even end up using this i_size_read
> at all

It's not a bad idea, we do kind of jump through some hoops here by
calling generic_file_iter_read(), we should just check for dio upfront
and handle that, falling back to filemap_read() if needed.

-- 
Jens Axboe

