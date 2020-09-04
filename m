Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70A4725D4AF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Sep 2020 11:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730011AbgIDJXK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Sep 2020 05:23:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:39698 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728588AbgIDJXK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Sep 2020 05:23:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 899CAB165;
        Fri,  4 Sep 2020 09:23:08 +0000 (UTC)
Subject: Re: rework check_disk_change()
To:     dgilbert@interlog.com, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Denis Efremov <efremov@linux.com>, Tim Waugh <tim@cyberelk.net>,
        Michal Simek <michal.simek@xilinx.com>,
        Borislav Petkov <bp@alien8.de>,
        "David S. Miller" <davem@davemloft.net>,
        Song Liu <song@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Finn Thain <fthain@telegraphics.com.au>,
        Michael Schmitz <schmitzmic@gmail.com>,
        linux-m68k@lists.linux-m68k.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20200902141218.212614-1-hch@lst.de>
 <730eced4-c804-a78f-3d52-2a448dbd1b84@interlog.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <29ec4708-3a8d-a4f2-5eea-a08908a8d093@suse.de>
Date:   Fri, 4 Sep 2020 11:23:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <730eced4-c804-a78f-3d52-2a448dbd1b84@interlog.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/2/20 5:38 PM, Douglas Gilbert wrote:
> On 2020-09-02 10:11 a.m., Christoph Hellwig wrote:
>> Hi Jens,
>>
>> this series replaced the not very nice check_disk_change() function with
>> a new bdev_media_changed that avoids having the ->revalidate_disk call
>> at its end.  As a result ->revalidate_disk can be removed from a lot of
>> drivers.
>>
> 
> For over 20 years the sg driver has been carrying this snippet that hangs
> off the completion callback:
> 
>         if (driver_stat & DRIVER_SENSE) {
>                  struct scsi_sense_hdr ssh;
> 
>                  if (scsi_normalize_sense(sbp, sense_len, &ssh)) {
>                          if (!scsi_sense_is_deferred(&ssh)) {
>                                  if (ssh.sense_key == UNIT_ATTENTION) {
>                                          if (sdp->device->removable)
>                                                  sdp->device->changed = 1;
>                                  }
>                          }
>                  }
>          }
> 
> Is it needed? The unit attention (UA) may not be associated with the
> device changing. Shouldn't the SCSI mid-level monitor UAs if they
> impact the state of a scsi_device object?
> 
We do; check scsi_io_completion_action() in drivers/scsi/scsi_lib.c
So I don't think you'd need to keep it in sg.c.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
