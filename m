Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8C6293EFB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Oct 2020 16:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408391AbgJTOrn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Oct 2020 10:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730581AbgJTOrm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Oct 2020 10:47:42 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE79C0613CE
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Oct 2020 07:47:41 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id p15so3752947ioh.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Oct 2020 07:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eTDTO76croA6fWZRrh4GlbI2rKBSNz7UAk22k08uTPM=;
        b=Frxve8HjbssplEMsSfSy/dOZpZIB1gr94ZuFWIrz5FDpLLApxH4IYkCnzdRKiy6NeO
         GpdZmUZHjCKV8RqvDqPJ7tAdKHHKKIUUT2FBXMlR7/qpOP4wK1WlpEYeeNYb0d+WSlZs
         syNDv0WdiYtc4ddqYt91wWPui2shlcOoiHoajdbFRqlp0XGHtHE6/JhklRmj4qWSZDoQ
         G71GBUHu8pU3hb24Pgoa/esQeqBlVl2kiK3/A2NRlO1GmIo/3PeTCAMG/9ryqfHxTRv4
         PjmvG5MFBFrl3uHglfBlEwYXzluwTaIMXoVref53NIGVNi4VMbLjypPZv360ABQG6rfO
         libQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eTDTO76croA6fWZRrh4GlbI2rKBSNz7UAk22k08uTPM=;
        b=tc5UCBQ/+7WG0WdDFVRVe5RiInrQQ9zyHSnnLnYeWZRl+nXNgwN1OJlf9vruNhr4Zg
         f6P+VezvBLj2kVWTmEVyLzUMOPQgTHAyv9Xh8YOwZwBkY1UnmeadrJzQ+3qezrv9D3/i
         a8sGKloKO0OdBdN6wkW9fQdSm9NVKpPSDfcS5IvWjWC9aUd5wX0fZGCo3yzTVx1dtSmE
         Dijx1BNTXSzogW6D2dIgxXDwXVOdei8j9i3azPWoHFjdZZHWjbGul4v+sMsBA/EdM57u
         yVuulIRRt8H4mRpr1uoO+twucT5domWl3VT1WGkrIPpOZ8J4gU3CjRX964PA6OmSkBOl
         u7oA==
X-Gm-Message-State: AOAM531W3cOIbeL/77NdbKgzq1epu1Zyz6qZR4oJWxkhkYX/RjdnryB6
        lHCncHK/Y2iPhRzUTb9cQWvmXBQlum8NUw==
X-Google-Smtp-Source: ABdhPJzugJUapJqFqhm/L0H5rAz1cZgRoq9Ez3koxFh5KEjr3YMJlow0oKYLaAF2dBQ/9Ji4kSSCBw==
X-Received: by 2002:a6b:3c14:: with SMTP id k20mr2449719iob.12.1603205261027;
        Tue, 20 Oct 2020 07:47:41 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id r3sm1827026iog.55.2020.10.20.07.47.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2020 07:47:40 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 2/2] fs: generic_file_buffered_read() now uses
 find_get_pages_contig
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        fsdevel <linux-fsdevel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Matthew Wilcox <willy@infradead.org>
References: <20201017201055.2216969-1-kent.overstreet@gmail.com>
 <20201017201055.2216969-3-kent.overstreet@gmail.com>
Message-ID: <0da8d117-04ca-c236-dd3f-a6abbaf4097e@kernel.dk>
Date:   Tue, 20 Oct 2020 08:47:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201017201055.2216969-3-kent.overstreet@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Oct 17, 2020 at 2:11 PM Kent Overstreet <kent.overstreet@gmail.com> wrote:
>
> Convert generic_file_buffered_read() to get pages to read from in
> batches, and then copy data to userspace from many pages at once - in
> particular, we now don't touch any cachelines that might be contended
> while we're in the loop to copy data to userspace.
>
> This is is a performance improvement on workloads that do buffered reads
> with large blocksizes, and a very large performance improvement if that
> file is also being accessed concurrently by different threads.
>
> On smaller reads (512 bytes), there's a very small performance
> improvement (1%, within the margin of error).

I ran this through my buffered testing, and no ill effects observed. It
also provides a nice boost on the read side for a mixed read/write
verification workload I have.

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

