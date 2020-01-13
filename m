Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADD38139C0A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2020 23:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728864AbgAMWAm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jan 2020 17:00:42 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:38028 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728733AbgAMWAm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jan 2020 17:00:42 -0500
Received: by mail-io1-f65.google.com with SMTP id i7so3131023ioo.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jan 2020 14:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6OXWt9fjGuGkgSEMyujLuP1/3L7zMMRQcPORZ/BCTp0=;
        b=JZLwjnJIiB2VPgbJJXYgO9P/bSWC64Fqjw8s87im1FHRvfGbqIj5bilaokUAku05tt
         vzP0IiUEAhN5jJx+IUpw0hZfbcYVqzyZ3ke3oEI45RzXbml4M8IAnhRJviVFYcOd60R0
         dSKAYXkM1K1OKNjjDWrxQ7c02cpXgA68nIvqzxQFFlIuN+TyXWADfwD9FUnXBZNiTEBN
         iTyaJYdVvLOspJbJ9eVqXXl+xJfwuYEbeNH8q4ISGSnfuz3rUzmAMrPPVUAP2t2FD1bm
         h/C1Ez9i5Ks4ZA0I5Vm9z/tqgTOm71h3pD7wHCnkvJlxdHCZ9ksWa9DzY6bmfzCZSf1D
         wJrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6OXWt9fjGuGkgSEMyujLuP1/3L7zMMRQcPORZ/BCTp0=;
        b=QxIxODHSJlBpuKxPXX61ceowjfNzpp2zwg7sA8T6ydlWAHk4WEEiRa2o7nPkQwX/PK
         9lrplkee12HVNiwzvYKwiPPWlWGAOc6G9bAoPVi1DyAtubK3Vr1i4AzQAHvv000YHt+4
         suHQksUaBuS455WyjI7ElOsZP4D94hbXl4XGZ326q2R3YrOH5EuTRG2jYeFg0K/XpSP/
         n3PwTBKVY+D7+zbaZ/8T3T01+e0DsUA5+N0kBP167S9pKBd8a1c6EqqIuZ1lYGoysYa+
         YxgUe2XY2w79Vp/mzyyXPIYcWdn6tHJXcWToiIBY2U3SPX2vR92cVlSq2JJ3oC1+Q2SS
         bejg==
X-Gm-Message-State: APjAAAUCBkfLf4pLoSR1SXplr6XHI9N+lA7XpweMQvxcbXznVk6hWWrS
        uy7goLImgerSCUiFsesultSKpA==
X-Google-Smtp-Source: APXvYqws4PS4QzRyH3Eku9Bg95x93B8Hl2L5b3Nvi8PKwZH2Qq2Xq40gYSPOkkfYrvVpZNq5veC1ww==
X-Received: by 2002:a02:3312:: with SMTP id c18mr15775836jae.24.1578952841579;
        Mon, 13 Jan 2020 14:00:41 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id e13sm3046286iol.16.2020.01.13.14.00.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2020 14:00:41 -0800 (PST)
Subject: Re: [RFC 0/8] Replacing the readpages a_op
To:     Matthew Wilcox <willy@infradead.org>, Chris Mason <clm@fb.com>
Cc:     "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "hch@infradead.org" <hch@infradead.org>
References: <20200113153746.26654-1-willy@infradead.org>
 <6CA4CD96-0812-4261-8FF9-CD28AA2EC38A@fb.com>
 <20200113174008.GB332@bombadil.infradead.org>
 <15C84CC9-3196-441D-94DE-F3FD7AC364F0@fb.com>
 <20200113215811.GA18216@bombadil.infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <910af281-4e2b-3e5d-5533-b5ceafd59665@kernel.dk>
Date:   Mon, 13 Jan 2020 15:00:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200113215811.GA18216@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/13/20 2:58 PM, Matthew Wilcox wrote:
> On Mon, Jan 13, 2020 at 06:00:52PM +0000, Chris Mason wrote:
>> This is true, I didn't explain that part well ;)  Depending on 
>> compression etc we might end up poking the xarray inside the actual IO 
>> functions, but the main difference is that btrfs is building a single 
>> bio.  You're moving the plug so you'll merge into single bio, but I'd 
>> rather build 2MB bios than merge them.
> 
> Why don't we store a bio pointer inside the plug?  You're opencoding that,
> iomap is opencoding that, and I bet there's a dozen other places where
> we pass a bio around.  Then blk_finish_plug can submit the bio.

Plugs aren't necessarily a bio, they can be callbacks too.

-- 
Jens Axboe

