Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 128673F35F5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Aug 2021 23:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240600AbhHTVTL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Aug 2021 17:19:11 -0400
Received: from mail-pj1-f42.google.com ([209.85.216.42]:43868 "EHLO
        mail-pj1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbhHTVTK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Aug 2021 17:19:10 -0400
Received: by mail-pj1-f42.google.com with SMTP id qe12-20020a17090b4f8c00b00179321cbae7so8182281pjb.2;
        Fri, 20 Aug 2021 14:18:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ghNGDEZc2SSWn9VvNAd7fmG9UBe/rSvbMP1W9zaThGE=;
        b=SEnLEQUxIVibXs6otREF5t6EJrIKF+27lrW0UalWPjSXnywwKpVoTrsxaDyS8ckJNe
         rnxHDUBsRsI7ha1rP9hY4iWZBwH52FldONkaaEvXRzyWoxjQfYhTjh2g/Mo+At/sbTZW
         piy2N7X8a9COYSMgqDahU45TKSd62k8se4jiZqqmOr+4kKdp0xUEY2cGvUvgmlkbuTO9
         k8he07q9U+3M4ERnB5kG1saWA1FAHDqaDs29skX2u0+x44dEnalCXWXBkG70oF2tMH7v
         B4MElaILZjlAF9ZqQ+71gp3FxBnBi4oHJYvHqY9Qw8C4N5FhJPfFN6L+qGJ5CnAj6N0N
         T7fg==
X-Gm-Message-State: AOAM532zunrGXnJrobEelonoVeZiSfvkxb2i0/IWiBHFtxIqURQW8+pm
        9+E5OO5FI65Nwo4op/dkDYo=
X-Google-Smtp-Source: ABdhPJzuE+NZzfM/vev5NRgk1CFObdVgW7MtwdoY7ko+PcKgdRS+PzinaHKAfWWwgZcHMP+PbGE5lA==
X-Received: by 2002:a17:90a:4a95:: with SMTP id f21mr6714960pjh.122.1629494311917;
        Fri, 20 Aug 2021 14:18:31 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:ddfe:8579:6783:9ed8])
        by smtp.gmail.com with ESMTPSA id 8sm8164521pfo.153.2021.08.20.14.18.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Aug 2021 14:18:31 -0700 (PDT)
Subject: Re: [PATCH 3/7] block: copy offload support infrastructure
To:     Kanchan Joshi <joshiiitr@gmail.com>
Cc:     SelvaKumar S <selvakuma.s1@samsung.com>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, dm-devel@redhat.com,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>, kch@kernel.org,
        mpatocka@redhat.com, djwong@kernel.org, agk@redhat.com,
        Selva Jove <selvajove@gmail.com>,
        Nitesh Shetty <nj.shetty@samsung.com>, nitheshshetty@gmail.com,
        KANCHAN JOSHI <joshi.k@samsung.com>,
        Javier Gonzalez <javier.gonz@samsung.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20210817101423.12367-1-selvakuma.s1@samsung.com>
 <CGME20210817101758epcas5p1ec353b3838d64654e69488229256d9eb@epcas5p1.samsung.com>
 <20210817101423.12367-4-selvakuma.s1@samsung.com>
 <ad3561b9-775d-dd4d-0d92-6343440b1f8f@acm.org>
 <CA+1E3rK2ULVajQRkNTZJdwKoqBeGvkfoVYNF=WyK6Net85YkhA@mail.gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <fb9931ae-de27-820a-1333-f24e020913ff@acm.org>
Date:   Fri, 20 Aug 2021 14:18:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CA+1E3rK2ULVajQRkNTZJdwKoqBeGvkfoVYNF=WyK6Net85YkhA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/20/21 3:39 AM, Kanchan Joshi wrote:
> Bart, Mikulas
> 
> On Tue, Aug 17, 2021 at 10:44 PM Bart Van Assche <bvanassche@acm.org> wrote:
>>
>> On 8/17/21 3:14 AM, SelvaKumar S wrote:
>>> Introduce REQ_OP_COPY, a no-merge copy offload operation. Create
>>> bio with control information as payload and submit to the device.
>>> Larger copy operation may be divided if necessary by looking at device
>>> limits. REQ_OP_COPY(19) is a write op and takes zone_write_lock when
>>> submitted to zoned device.
>>> Native copy offload is not supported for stacked devices.
>>
>> Using a single operation for copy-offloading instead of separate
>> operations for reading and writing is fundamentally incompatible with
>> the device mapper. I think we need a copy-offloading implementation that
>> is compatible with the device mapper.
>>
> 
> While each read/write command is for a single contiguous range of
> device, with simple-copy we get to operate on multiple discontiguous
> ranges, with a single command.
> That seemed like a good opportunity to reduce control-plane traffic
> (compared to read/write operations) as well.
> 
> With a separate read-and-write bio approach, each source-range will
> spawn at least one read, one write and eventually one SCC command. And
> it only gets worse as there could be many such discontiguous ranges (for
> GC use-case at least) coming from user-space in a single payload.
> Overall sequence will be
> - Receive a payload from user-space
> - Disassemble into many read-write pair bios at block-layer
> - Assemble those (somehow) in NVMe to reduce simple-copy commands
> - Send commands to device
> 
> We thought payload could be a good way to reduce the
> disassembly/assembly work and traffic between block-layer to nvme.
> How do you see this tradeoff?  What seems necessary for device-mapper
> usecase, appears to be a cost when device-mapper isn't used.
> Especially for SCC (since copy is within single ns), device-mappers
> may not be too compelling anyway.
> 
> Must device-mapper support be a requirement for the initial support atop SCC?
> Or do you think it will still be a progress if we finalize the
> user-space interface to cover all that is foreseeable.And for
> device-mapper compatible transport between block-layer and NVMe - we
> do it in the later stage when NVMe too comes up with better copy
> capabilities?

Hi Kanchan,

These days there might be more systems that run the device mapper on top 
of the NVMe driver or a SCSI driver than systems that do use the device 
mapper. It is common practice these days to use dm-crypt on personal 
workstations and laptops. LVM (dm-linear) is popular because it is more 
flexible than a traditional partition table. Android phones use 
dm-verity on top of hardware encryption. In other words, not supporting 
the device mapper means that a very large number of use cases is 
excluded. So I think supporting the device mapper from the start is 
important, even if that means combining individual bios at the bottom of 
the storage stack into simple copy commands.

Thanks,

Bart.

