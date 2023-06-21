Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6017737E47
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jun 2023 11:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbjFUJAw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jun 2023 05:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231937AbjFUJA1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jun 2023 05:00:27 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8599019A3;
        Wed, 21 Jun 2023 02:00:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 457A721A3C;
        Wed, 21 Jun 2023 09:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1687338025; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T+jHi1Lt6ynG+EKyXMNo7RTx9IOLB9+vmVyWYAdt8KU=;
        b=XXVzELN4l2gD389M2F6JOyeBrFBFWPB6FKdhLjYl+B/UU6wA4Bq3zfimZnqTL92LXFOxgs
        GQnLsLyeqQYXWYXzntZKOL4eW3ExwHsTAptMMDWBUL7yL+1YjoQ8TlOTF6fKIKTrcpvfjH
        CLXSooTJY+y8wiNJ1ZrBwRPgxFGWGio=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1687338025;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T+jHi1Lt6ynG+EKyXMNo7RTx9IOLB9+vmVyWYAdt8KU=;
        b=f4tQoT0PDYtmO4buUHc1tLO7+oe3YdqbD1YLY9UoBhc5rTByEbHVXbws++2CjZhMgABkS/
        7YnNMbyOP/oc6tBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2DE5E134B1;
        Wed, 21 Jun 2023 09:00:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VTPBCim8kmQYYwAAMHmgww
        (envelope-from <hare@suse.de>); Wed, 21 Jun 2023 09:00:25 +0000
Message-ID: <b311ae01-cec9-8e06-02a6-f139e37d5863@suse.de>
Date:   Wed, 21 Jun 2023 11:00:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC 0/4] minimum folio order support in filemap
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>, willy@infradead.org,
        david@fromorbit.com
Cc:     gost.dev@samsung.com, mcgrof@kernel.org, hch@lst.de,
        jwong@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <CGME20230621083825eucas1p1b05a6d7e0bf90e7a3d8e621f6578ff0a@eucas1p1.samsung.com>
 <20230621083823.1724337-1-p.raghav@samsung.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230621083823.1724337-1-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/21/23 10:38, Pankaj Raghav wrote:
> There has been a lot of discussion recently to support devices and fs for
> bs > ps. One of the main plumbing to support buffered IO is to have a minimum
> order while allocating folios in the page cache.
> 
> Hannes sent recently a series[1] where he deduces the minimum folio
> order based on the i_blkbits in struct inode. This takes a different
> approach based on the discussion in that thread where the minimum and
> maximum folio order can be set individually per inode.
> 
> This series is based on top of Christoph's patches to have iomap aops
> for the block cache[2]. I rebased his remaining patches to
> next-20230621. The whole tree can be found here[3].
> 
> Compiling the tree with CONFIG_BUFFER_HEAD=n, I am able to do a buffered
> IO on a nvme drive with bs>ps in QEMU without any issues:
> 
> [root@archlinux ~]# cat /sys/block/nvme0n2/queue/logical_block_size
> 16384
> [root@archlinux ~]# fio -bs=16k -iodepth=8 -rw=write -ioengine=io_uring -size=500M
> 		    -name=io_uring_1 -filename=/dev/nvme0n2 -verify=md5
> io_uring_1: (g=0): rw=write, bs=(R) 16.0KiB-16.0KiB, (W) 16.0KiB-16.0KiB, (T) 16.0KiB-16.0KiB, ioengine=io_uring, iodepth=8
> fio-3.34
> Starting 1 process
> Jobs: 1 (f=1): [V(1)][100.0%][r=336MiB/s][r=21.5k IOPS][eta 00m:00s]
> io_uring_1: (groupid=0, jobs=1): err= 0: pid=285: Wed Jun 21 07:58:29 2023
>    read: IOPS=27.3k, BW=426MiB/s (447MB/s)(500MiB/1174msec)
>    <snip>
> Run status group 0 (all jobs):
>     READ: bw=426MiB/s (447MB/s), 426MiB/s-426MiB/s (447MB/s-447MB/s), io=500MiB (524MB), run=1174-1174msec
>    WRITE: bw=198MiB/s (207MB/s), 198MiB/s-198MiB/s (207MB/s-207MB/s), io=500MiB (524MB), run=2527-2527msec
> 
> Disk stats (read/write):
>    nvme0n2: ios=35614/4297, merge=0/0, ticks=11283/1441, in_queue=12725, util=96.27%
> 
> One of the main dependency to work on a block device with bs>ps is
> Christoph's work on converting block device aops to use iomap.
> 
> [1] https://lwn.net/Articles/934651/
> [2] https://lwn.net/ml/linux-kernel/20230424054926.26927-1-hch@lst.de/
> [3] https://github.com/Panky-codes/linux/tree/next-20230523-filemap-order-generic-v1
> 
> Luis Chamberlain (1):
>    block: set mapping order for the block cache in set_init_blocksize
> 
> Matthew Wilcox (Oracle) (1):
>    fs: Allow fine-grained control of folio sizes
> 
> Pankaj Raghav (2):
>    filemap: use minimum order while allocating folios
>    nvme: enable logical block size > PAGE_SIZE
> 
>   block/bdev.c             |  9 ++++++++
>   drivers/nvme/host/core.c |  2 +-
>   include/linux/pagemap.h  | 46 ++++++++++++++++++++++++++++++++++++----
>   mm/filemap.c             |  9 +++++---
>   mm/readahead.c           | 34 ++++++++++++++++++++---------
>   5 files changed, 82 insertions(+), 18 deletions(-)
> 

Hmm. Most unfortunate; I've just finished my own patchset (duplicating 
much of this work) to get 'brd' running with large folios.
And it even works this time, 'fsx' from the xfstest suite runs happily 
on that.

Guess we'll need to reconcile our patches.

Cheers,

Hannes

