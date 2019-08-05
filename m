Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DFF58256C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2019 21:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730155AbfHETQv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Aug 2019 15:16:51 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40896 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727802AbfHETQv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Aug 2019 15:16:51 -0400
Received: by mail-wm1-f67.google.com with SMTP id v19so74091866wmj.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Aug 2019 12:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=plexistor-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=i8MUAFs9xWo3DeulQdVmEqj8r8vwJULZDf6MNUFq2ww=;
        b=UrVz3TL4y2Wd+2usgnHy3ExsuaOYfeNXBdmadp57B6j14Ve7GM/RifZdIa0BVHr1mR
         7EkSWqmNTRYWs8nNOfXbwW3zYaSffpmhx5FrOADWtrlzKsbxRmJQ56JPTmj4odOuuhcf
         GtyYiWudoTtgCmBg9n/4fgOB2kFttMVVvMsGFsI26QLy91SItBSIbfzaDnAQv3BwLj6U
         gWkJ8YpDvcU1ASeinejR8VSX6IjC07krSj47vZQWeEbbAqR2hO9cQfZwOzMLsqQo7ClK
         y/i3avrc0nF4z4Hp82ZrkJ56foE4TgFoWLOynsKwpfZFZ4E1XiAqKSR08yPeMsCWU6dU
         LM5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=i8MUAFs9xWo3DeulQdVmEqj8r8vwJULZDf6MNUFq2ww=;
        b=ZpCmnX2R2ePoeE4/XXpC8nlFsYKZSYS/0AzuPHAv2BRDl4PTE5oWHUoij3yDjIapJm
         W6veqjpne6Xfrko2LbRdKFdDWTHqKfg+tHMu4vlIb5rRc82ojdzrdY8wmNrdJ2cT1aBK
         CKTq6PH4LoNmPwlh6AQ13wQ1jE+y2h8KSwjexdXGO0qe9VOCG/LPXtjSpW48z/dOhkgo
         vjqym0v156PkyW4eASMp381eeBtGkF+kZ9rVuUmUVcYAaLccr7PPK+jbSi4ss/VMLfvy
         fzMLFCWD2d5Z/S1LDvdrqFSwdn0m0y37C4oJjFzr3FJcr7LCYmk5TTDpPKnw7MOODz7F
         Idzw==
X-Gm-Message-State: APjAAAXhpS/D9al9u42E0a1IgqW4w5M6PYcv7L7lH339zqVY7HymY6cU
        R3XDiCc3v3JB+QYfCM7XJH8=
X-Google-Smtp-Source: APXvYqyg2z6e5NAOZET2e8ipXtjRjnPZ9wpiF9eF9YkoNugyrx+Do8m6yVMVw8QMotm5Qi7zqcbHQg==
X-Received: by 2002:a7b:c4d0:: with SMTP id g16mr20340165wmk.88.1565032609390;
        Mon, 05 Aug 2019 12:16:49 -0700 (PDT)
Received: from [10.68.217.182] ([217.70.211.18])
        by smtp.googlemail.com with ESMTPSA id b186sm66079447wmb.3.2019.08.05.12.16.47
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Aug 2019 12:16:48 -0700 (PDT)
Subject: Re: [PATCH] dax: dax_layout_busy_page() should not unmap cow pages
To:     Vivek Goyal <vgoyal@redhat.com>, Boaz Harrosh <boaz@plexistor.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        virtio-fs@redhat.com
References: <20190802192956.GA3032@redhat.com>
 <CAPcyv4jxknEGq9FzGpsMJ6E7jC51d1W9KbNg4HX6Cj6vqt7dqg@mail.gmail.com>
 <9678e812-08c1-fab7-f358-eaf123af14e5@plexistor.com>
 <20190805184951.GC13994@redhat.com>
From:   Boaz Harrosh <boaz@plexistor.com>
Message-ID: <9c0ec951-01e7-7ae0-2d69-1b26f3450d65@plexistor.com>
Date:   Mon, 5 Aug 2019 22:16:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190805184951.GC13994@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 05/08/2019 21:49, Vivek Goyal wrote:
> On Mon, Aug 05, 2019 at 02:53:06PM +0300, Boaz Harrosh wrote:
<>
>> So as I understand the man page:
>> fallocate(FL_PUNCH_HOLE); means user is asking to get rid also of COW pages.
>> On the other way fallocate(FL_ZERO_RANGE) only the pmem portion is zeroed and COW (private pages) stays
> 
> I tested fallocate(FL_PUNCH_HOLE) on xfs (non-dax) and it does not seem to
> get rid of COW pages and my test case still can read the data it wrote
> in private pages.
> 

It seems you are right and I am wrong. This is what the Kernel code has to say about it:

	/*
	 * Unlike in truncate_pagecache, unmap_mapping_range is called only
	 * once (before truncating pagecache), and without "even_cows" flag:
	 * hole-punching should not remove private COWed pages from the hole.
	 */

For me this is confusing but that is what it is. So remove private COWed pages
is only done when we do an setattr(ATTR_SIZE).

>>
>> Just saying I have not followed the above code path
>> (We should have an xfstest for this?)
> 
> I don't know either. It indeed is interesting to figure out what's the
> expected behavior with fallocate() and truncate() for COW pages and cover
> that using xfstest (if not already done).
> 

I could not find any test for the COW positive FL_PUNCH_HOLE (I have that bug)
could be nice to make one, and let FSs like mine fail.
Any way very nice catch.

> 
> Thanks
> Vivek
> 

Thanks
Boaz
