Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE3D3EF55F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Aug 2021 00:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235474AbhHQWDJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Aug 2021 18:03:09 -0400
Received: from mail-1.ca.inter.net ([208.85.220.69]:37403 "EHLO
        mail-1.ca.inter.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbhHQWDI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Aug 2021 18:03:08 -0400
X-Greylist: delayed 519 seconds by postgrey-1.27 at vger.kernel.org; Tue, 17 Aug 2021 18:03:08 EDT
Received: from mp-mx11.ca.inter.net (mp-mx11.ca.inter.net [208.85.217.19])
        by mail-1.ca.inter.net (Postfix) with ESMTP id 005612EA31E;
        Tue, 17 Aug 2021 17:53:49 -0400 (EDT)
Received: from mail-1.ca.inter.net ([208.85.220.69])
        by mp-mx11.ca.inter.net (mp-mx11.ca.inter.net [208.85.217.19]) (amavisd-new, port 10024)
        with ESMTP id HJZLiWIjEmCF; Tue, 17 Aug 2021 17:53:49 -0400 (EDT)
Received: from [192.168.48.23] (host-45-78-207-107.dyn.295.ca [45.78.207.107])
        (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: dgilbert@interlog.com)
        by mail-1.ca.inter.net (Postfix) with ESMTPSA id DC7C52EA1C8;
        Tue, 17 Aug 2021 17:53:45 -0400 (EDT)
Reply-To: dgilbert@interlog.com
Subject: Re: [PATCH 3/7] block: copy offload support infrastructure
To:     Mikulas Patocka <mpatocka@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     SelvaKumar S <selvakuma.s1@samsung.com>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, dm-devel@redhat.com,
        kbusch@kernel.org, axboe@kernel.dk, damien.lemoal@wdc.com,
        asml.silence@gmail.com, johannes.thumshirn@wdc.com, hch@lst.de,
        willy@infradead.org, kch@kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        djwong@kernel.org, Mike Snitzer <snitzer@redhat.com>,
        agk@redhat.com, selvajove@gmail.com, joshiiitr@gmail.com,
        nj.shetty@samsung.com, nitheshshetty@gmail.com,
        joshi.k@samsung.com, javier.gonz@samsung.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20210817101423.12367-1-selvakuma.s1@samsung.com>
 <CGME20210817101758epcas5p1ec353b3838d64654e69488229256d9eb@epcas5p1.samsung.com>
 <20210817101423.12367-4-selvakuma.s1@samsung.com>
 <ad3561b9-775d-dd4d-0d92-6343440b1f8f@acm.org>
 <alpine.LRH.2.02.2108171630120.30363@file01.intranet.prod.int.rdu2.redhat.com>
From:   Douglas Gilbert <dgilbert@interlog.com>
Message-ID: <bbecc7e7-8bf5-3fe3-6c24-883c79fb7517@interlog.com>
Date:   Tue, 17 Aug 2021 17:53:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.02.2108171630120.30363@file01.intranet.prod.int.rdu2.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021-08-17 4:41 p.m., Mikulas Patocka wrote:
> 
> 
> On Tue, 17 Aug 2021, Bart Van Assche wrote:
> 
>> On 8/17/21 3:14 AM, SelvaKumar S wrote:
>>> Introduce REQ_OP_COPY, a no-merge copy offload operation. Create
>>> bio with control information as payload and submit to the device.
>>> Larger copy operation may be divided if necessary by looking at device
>>> limits. REQ_OP_COPY(19) is a write op and takes zone_write_lock when
>>> submitted to zoned device.
>>> Native copy offload is not supported for stacked devices.
>>
>> Using a single operation for copy-offloading instead of separate operations
>> for reading and writing is fundamentally incompatible with the device mapper.
>> I think we need a copy-offloading implementation that is compatible with the
>> device mapper.
> 
> I once wrote a copy offload implementation that is compatible with device
> mapper. The copy operation creates two bios (one for reading and one for
> writing), passes them independently through device mapper and pairs them
> at the physical device driver.
> 
> It's here: http://people.redhat.com/~mpatocka/patches/kernel/xcopy/current

In my copy solution the read-side and write-side bio pairs share the same 
storage (i.e. ram) This gets around the need to copy data between the bio_s.
See:
    https://sg.danny.cz/sg/sg_v40.html
in Section 8 on Request sharing. This technique can be efficiently extend to
source --> destination1,destination2,...      copies.

Doug Gilbert

> I verified that it works with iSCSI. Would you be interested in continuing
> this work?
> 
> Mikulas
> 
>> Storing the parameters of the copy operation in the bio payload is
>> incompatible with the current implementation of bio_split().
>>
>> In other words, I think there are fundamental problems with this patch series.
>>
>> Bart.
>>
> 

