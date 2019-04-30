Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A19C9FDFC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2019 18:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbfD3QdZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Apr 2019 12:33:25 -0400
Received: from mail-io1-f46.google.com ([209.85.166.46]:46389 "EHLO
        mail-io1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfD3QdY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Apr 2019 12:33:24 -0400
Received: by mail-io1-f46.google.com with SMTP id m14so1836807ion.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Apr 2019 09:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=av5VSNqJe7ZdTw4nzRuXBSgojWB4gnNiSMsj6Rn7YDc=;
        b=uqHv+v7HqQD21A02DUEi0TR9EDNnqSAh+65SBAPqzIAwTrsXlla7pqKSpini2DuqBH
         MZ5wnArL0hWFtEw6QvwH1+wal5Puz2vhMQ6jAdKCw+1QU83TWeTRMJX+jTlvKqBBAGa2
         VesFY/GgBYduoB2sNrCPdO1kIrVl5O4+BiUeTHlxxvYwZAF/YPltSMdb60i7WZzDejMD
         tu+NpOFTYvLCce4TnnEJLSs02L4nketpCF51AGmRsmbpx3P2gUIucB8YJY5cxr+UetWE
         6p6/BYexB/U7z6Ik8iXqktx95i39UNFE9jIfF+5DCoIEqCAknFXgry44Hr0MwGGLL8Ox
         dpMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=av5VSNqJe7ZdTw4nzRuXBSgojWB4gnNiSMsj6Rn7YDc=;
        b=VwtUsBf3PhEsqrVXLMU7hdA3T6ZtVNmiAT0cwgTMBIHVttwrnY4B/tgZ4cfrz467pD
         Gw3Zo6v/S8d0SmKV4iDKxuWSpwrn6zs7SwpVv+kkuhmp1gMj+a4otaTtwit1CnKhnJ5T
         3qBUxPKcwiXKxj3F2V4wnVs3cwhbWYFN2ksP3e5QUrKBwvGk2ehBlDOmjT+3uIfrYtDX
         Wxq7i0Wofqnbh5Kn/st3RfRkeNxhnOu9i0fH9cgo5ML2DA2bR5JF1UTeh7u32t3mE9V1
         UeBHuE4+c3+4RxIGj0ExRRNaZheJmv3w529ZPsLNq1lz3KAC0YDZZfZKTXDpBj/nHlJN
         Z9dw==
X-Gm-Message-State: APjAAAUI3uK0gUiQvHDSQJNYvHt9l9dxqPZcGBfQGuNY1BiwjP05a1uX
        kHe9WvriuV6NQu6XLrR1g+eK9Q9m7Um5+g==
X-Google-Smtp-Source: APXvYqy114OccaZET0DAxPq1oVIV3uf8pOzkEUP8Ovs6BXAvr+d7OrRPRhaSDVAJ6t12mnKQFzqa9g==
X-Received: by 2002:a5d:89c1:: with SMTP id a1mr15751044iot.214.1556642003525;
        Tue, 30 Apr 2019 09:33:23 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id h8sm14286582iof.36.2019.04.30.09.33.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 09:33:22 -0700 (PDT)
Subject: Re: [PATCHv2] io_uring: free allocated io_memory once
To:     Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20190430163021.54711-1-mark.rutland@arm.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b31d4f2e-8756-02ef-9c0b-55c7e755c097@kernel.dk>
Date:   Tue, 30 Apr 2019 10:33:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190430163021.54711-1-mark.rutland@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/30/19 10:30 AM, Mark Rutland wrote:
> If io_allocate_scq_urings() fails to allocate an sq_* region, it will
> call io_mem_free() for any previously allocated regions, but leave
> dangling pointers to these regions in the ctx. Any regions which have
> not yet been allocated are left NULL. Note that when returning
> -EOVERFLOW, the previously allocated sq_ring is not freed, which appears
> to be an unintentional leak.
> 
> When io_allocate_scq_urings() fails, io_uring_create() will call
> io_ring_ctx_wait_and_kill(), which calls io_mem_free() on all the sq_*
> regions, assuming the pointers are valid and not NULL.
> 
> This can result in pages being freed multiple times, which has been
> observed to corrupt the page state, leading to subsequent fun. This can
> also result in virt_to_page() on NULL, resulting in the use of bogus
> page addresses, and yet more subsequent fun. The latter can be detected
> with CONFIG_DEBUG_VIRTUAL on arm64.
> 
> Adding a cleanup path to io_allocate_scq_urings() complicates the logic,
> so let's leave it to io_ring_ctx_free() to consistently free these
> pointers, and simplify the io_allocate_scq_urings() error paths.

Looks good - applied, thanks.

-- 
Jens Axboe

