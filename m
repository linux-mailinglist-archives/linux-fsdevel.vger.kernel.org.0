Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32D7E25AFD7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Sep 2020 17:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728424AbgIBPqP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Sep 2020 11:46:15 -0400
Received: from smtp.infotech.no ([82.134.31.41]:51387 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727860AbgIBPqI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Sep 2020 11:46:08 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id 93E6A20418E;
        Wed,  2 Sep 2020 17:38:52 +0200 (CEST)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id PCCwPRfO6cmJ; Wed,  2 Sep 2020 17:38:50 +0200 (CEST)
Received: from [192.168.48.23] (host-45-78-251-166.dyn.295.ca [45.78.251.166])
        by smtp.infotech.no (Postfix) with ESMTPA id 04A34204158;
        Wed,  2 Sep 2020 17:38:47 +0200 (CEST)
Reply-To: dgilbert@interlog.com
Subject: Re: rework check_disk_change()
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
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
From:   Douglas Gilbert <dgilbert@interlog.com>
Message-ID: <730eced4-c804-a78f-3d52-2a448dbd1b84@interlog.com>
Date:   Wed, 2 Sep 2020 11:38:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200902141218.212614-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020-09-02 10:11 a.m., Christoph Hellwig wrote:
> Hi Jens,
> 
> this series replaced the not very nice check_disk_change() function with
> a new bdev_media_changed that avoids having the ->revalidate_disk call
> at its end.  As a result ->revalidate_disk can be removed from a lot of
> drivers.
> 

For over 20 years the sg driver has been carrying this snippet that hangs
off the completion callback:

        if (driver_stat & DRIVER_SENSE) {
                 struct scsi_sense_hdr ssh;

                 if (scsi_normalize_sense(sbp, sense_len, &ssh)) {
                         if (!scsi_sense_is_deferred(&ssh)) {
                                 if (ssh.sense_key == UNIT_ATTENTION) {
                                         if (sdp->device->removable)
                                                 sdp->device->changed = 1;
                                 }
                         }
                 }
         }

Is it needed? The unit attention (UA) may not be associated with the
device changing. Shouldn't the SCSI mid-level monitor UAs if they
impact the state of a scsi_device object?

Doug Gilbert

