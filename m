Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50DB85DA99
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2019 03:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbfGCBSU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Jul 2019 21:18:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:59104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726635AbfGCBSF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Jul 2019 21:18:05 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE40F21913;
        Tue,  2 Jul 2019 22:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562107775;
        bh=0Mw+7Os5OKZyelS8FwvvKV3593VIkrJ7dJcpLx70TbI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=yeymeREMbbnHkItA2QFK0OsQwOJ4S2KY6zwb3yiexMQPK3mYRJ3g1rL4PR773LzRh
         IoGc92x3+hV6v24eAdWhbNI/hjjLDzKgQ9/f702ro94m4Kiu1LHS57xX0bliPFr6w9
         c3NhEaSIHmjhkHfQR6smVApNp9irmjk3EPhcjc6k=
Date:   Tue, 2 Jul 2019 15:49:35 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2] fat: Add nobarrier to workaround the strange
 behavior of device
Message-Id: <20190702154935.56f611ce988bf595412faa00@linux-foundation.org>
In-Reply-To: <87woh5pyqh.fsf@mail.parknet.co.jp>
References: <87woh5pyqh.fsf@mail.parknet.co.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 28 Jun 2019 23:32:06 +0900 OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> wrote:

> 
> v2:
> Just cleanup, changed the place of options under comment of fat.
> 
> ---

Please be careful with the "^---$" - it denotes "end of changelog", so
I ended up without a changelog!


> There was the report of strange behavior of device with recent
> blkdev_issue_flush() position change.

A Reported-by: would be nice, but not necessary.

> The following is simplified usbmon trace.
> 
>  4203   9.160230         host -> 1.25.1       USBMS 95 SCSI: Synchronize Cache(10) LUN: 0x00 (LBA: 0x00000000, Len: 0)
>  4206   9.164911       1.25.1 -> host         USBMS 77 SCSI: Response LUN: 0x00 (Synchronize Cache(10)) (Good)
>  4207   9.323927         host -> 1.25.1       USBMS 95 SCSI: Read(10) LUN: 0x00 (LBA: 0x00279950, Len: 240)
>  4212   9.327138       1.25.1 -> host         USBMS 77 SCSI: Response LUN: 0x00 (Read(10)) (Good)
> 
> [...]
> 
>  7323  10.202167         host -> 1.25.1       USBMS 95 SCSI: Synchronize Cache(10) LUN: 0x00 (LBA: 0x00000000, Len: 0)
>  7326  10.432266       1.25.1 -> host         USBMS 77 SCSI: Response LUN: 0x00 (Synchronize Cache(10)) (Good)
>  7327  10.769092         host -> 1.25.1       USBMS 95 SCSI: Test Unit Ready LUN: 0x00 
>  7330  10.769192       1.25.1 -> host         USBMS 77 SCSI: Response LUN: 0x00 (Test Unit Ready) (Good)
>  7335  12.849093         host -> 1.25.1       USBMS 95 SCSI: Test Unit Ready LUN: 0x00 
>  7338  12.849206       1.25.1 -> host         USBMS 77 SCSI: Response LUN: 0x00 (Test Unit Ready) (Check Condition)
>  7339  12.849209         host -> 1.25.1       USBMS 95 SCSI: Request Sense LUN: 0x00
>  
> If "Synchronize Cache" command issued then there is idle time, the
> device stop to process further commands, and behave as like no media.
> (it returns NOT_READY [MEDIUM NOT PRESENT] for SENSE command, and this
> happened on Kindle) [just a guess, the device is trying to detect the
> "safe-unplug" operation of Windows or such?]
> 
> To workaround those devices and provide flexibility, this adds
> "barrier"/"nobarrier" mount options to fat driver.

I think it would be helpful if the changelog were to at least describe
the longer-term plan which hch described.

> --- linux/fs/fat/fat.h~fat-nobarrier	2019-06-28 21:22:18.146191739 +0900
> +++ linux-hirofumi/fs/fat/fat.h	2019-06-28 23:26:04.881215721 +0900
> @@ -51,6 +51,7 @@ struct fat_mount_options {
>  		 tz_set:1,	   /* Filesystem timestamps' offset set */
>  		 rodir:1,	   /* allow ATTR_RO for directory */
>  		 discard:1,	   /* Issue discard requests on deletions */
> +		 barrier:1,	   /* Issue FLUSH command */
>  		 dos1xfloppy:1;	   /* Assume default BPB for DOS 1.x floppies */

Documentation/filesystems/vfat.txt should be updated to describe this
new option please.  And perhaps to mention that a device-level quirk should be
used in preference, if it is available.


