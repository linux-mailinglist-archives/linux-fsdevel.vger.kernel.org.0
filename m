Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7E02C327A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 22:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730834AbgKXVTP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 16:19:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730537AbgKXVTO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 16:19:14 -0500
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87980C0613D6;
        Tue, 24 Nov 2020 13:19:14 -0800 (PST)
Received: by mail-qv1-xf44.google.com with SMTP id x13so11347052qvk.8;
        Tue, 24 Nov 2020 13:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sg9SO3UStMfqHkCvNI1YBGGkjTmKJ7UaheqYby9uxnM=;
        b=OzhyL5qOUmNMCmaqmA0AJ7YTZnOa5s8lOvdGSd5gsRFwIjVjcK9RMkEdmOZVvPKHkC
         HEfwzTPFGhRpcwv4Zdi1eKZAQCSJDqL9242nm6t+004qxnjr2Wo1RG+dvaQzjYpDTlFJ
         y4MEeMckfEdVhdL9TeWxoL3uJseLhfNpPNLJKI+4lWddjQrQSYtmPS6DbLtZKSCyuI0M
         VPOnBALIPZDz9HaljCXz/QtzQMoFkORQ/oSOcQG0yJ5cuTGS83XWqbo7FaIck74bBkz3
         zSrrMusanZp5T2dH6BfcuYD799YU+BVDp+VbnKu/pAzjL4fvbG44Apq0OxYfntbUtAy3
         IgsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=sg9SO3UStMfqHkCvNI1YBGGkjTmKJ7UaheqYby9uxnM=;
        b=n1g0JJ/RP4SqAk6Mdjy3JiroCAh092BbKP4Eja5VZuIY35pQMygfzj/LJ9aq7Ku0gW
         qKjJZRIJ+bxGeonBTfcdjCfZmk5BXzfblqDqpSp/59EzixJMNHfaTaopzyHQesBaEE6z
         vk30+zdRANglw/sfmUOgMOZ4hjtgY3POPGRta9bSQQd2cLyI4k5y+r4X0VR0iHgMm8bi
         AEfKHo6li6zxq63NxPk2PenHHjvc0tpeCelzId80ze8T7rCh5hU02JvF6w1wrqbnxkFu
         qaDDWBoV7YpD0Rgw00kLn9OE7S/9zQJFtkMHqq48iZr6n5X8X3ySPnzpY/w49q9u6yCh
         IOuQ==
X-Gm-Message-State: AOAM532NXsdJBNG+KTnvZF/WK4ktYltxuDwbcdFCMKmiNuHSlY2jmeb2
        1AQF5ZjcRbJDe5WfHdR5adg=
X-Google-Smtp-Source: ABdhPJymsM7t3QC8HGlAx0p+5Wt4X/uLuUZsX3zmVjKyK1/8swtwKOE7/+uzSFJWv6qwdRjGjoCR5w==
X-Received: by 2002:a0c:fa08:: with SMTP id q8mr548456qvn.25.1606252753574;
        Tue, 24 Nov 2020 13:19:13 -0800 (PST)
Received: from localhost (dhcp-6c-ae-f6-dc-d8-61.cpe.echoes.net. [72.28.8.195])
        by smtp.gmail.com with ESMTPSA id c27sm387614qkk.57.2020.11.24.13.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 13:19:12 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 24 Nov 2020 16:18:49 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jan Kara <jack@suse.cz>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        dm-devel@redhat.com, Richard Weinberger <richard@nod.at>,
        Jan Kara <jack@suse.com>, linux-block@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 25/45] block: reference struct block_device from struct
 hd_struct
Message-ID: <X714udEyPuGarVYp@mtj.duckdns.org>
References: <20201124132751.3747337-1-hch@lst.de>
 <20201124132751.3747337-26-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124132751.3747337-26-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

Please see lkml.kernel.org/r/X708BTJ5njtbC2z1@mtj.duckdns.org for a few nits
on the previous version.

On Tue, Nov 24, 2020 at 02:27:31PM +0100, Christoph Hellwig wrote:
> To simplify block device lookup and a few other upcoming areas, make sure
> that we always have a struct block_device available for each disk and
> each partition.  The only downside of this is that each device and
> partition uses a little more memory.  The upside will be that a lot of
> code can be simplified.
> 
> With that all we need to look up the block device is to lookup the inode
> and do a few sanity checks on the gendisk, instead of the separate lookup
> for the gendisk.  These checks are in a new RCU critical section and
> the disk is now freed using kfree_rcu().

I might be confused but am wondering whether RCU is needed. It's currently
used to ensure that gendisk is accessible in the blkdev_get path but
wouldn't it be possible to simply pin gendisk from block_devices? The
gendisk and hd_structs hold the base refs of the block_devices and in turn
the block_devices pin the gendisk. When the gendisk gets deleted, it puts
the base refs of the block devices but stays around while the block devices
are being accessed.

Also, would it make sense to separate out lookup_sem removal? I *think* it's
there to ensure that the same bdev doesn't get associated with old and new
gendisks at the same time but can't wrap my head around how it works
exactly. I can see that this may not be needed once the lifetimes of gendisk
and block_devices are tied together but that may warrant a bit more
explanation.

Thanks.

-- 
tejun
