Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0B0B2CC934
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Dec 2020 22:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbgLBVxv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Dec 2020 16:53:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbgLBVxu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Dec 2020 16:53:50 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81519C0617A7;
        Wed,  2 Dec 2020 13:53:10 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id k4so2251534qtj.10;
        Wed, 02 Dec 2020 13:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xaDA1tsZ1ItmC2prDcKEEQmNvQ5Pv10Cm/ao+ODU+y4=;
        b=iAPcnaL9YKd6C5p0FcenDd90I6RD+gVpzxd/eSeZ0xQt9GcZVQdiA4aFbSTs/OntKF
         p7Y2acKBQhXDYXWo0LiuqI/KD6vQlMJO13z+pLDB2QuNybKg1m/pVWVmKu0Igw6P/jia
         /DXVPfsqMlkEQtec7ecguK4XUNFOblt/c39xOX5fpFoMtLxgr8H1KlOio7aMcMZhKk2K
         P0y21tBmx5BAH6T0bfQyGSYF9ycee7/0ZbSmpi3ECjeU3GhFpb8FbcBQeN9K3Q/JN89z
         5N5RnxqSLo8pVptxcNMrUYIZQQHWaNj5ZvRv+jvsPEmFnDurH/G5gMjlBmyWiKGkF/qC
         5eGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=xaDA1tsZ1ItmC2prDcKEEQmNvQ5Pv10Cm/ao+ODU+y4=;
        b=W3wwQsq4aB+9bTY7+v0x7CMmPz5AaSTV0S8I5Xyl3M7+IaLE8Q5dqwrPx+1fXejiPG
         4S9YPX6aPMQ5unVLqkoboTmQufdi9Rrd5GeY8UanHl94EcB9UAFCnrtGlIe5346+oQkM
         Oz9y9yl43EG/qUtiYm+k7HMfQB2v71Q3aGyw6SFj8mrVYl7yV290/QmYhSeqIpvkr9Cu
         zKYkEb+eAS5EEV14Xi5/r1ue0M2qOx69msU3U1M66egpyuLP0/RBYhWlPPw4AjvGCo9N
         2cKcSje+qFB/pdxmvyvXfbgAKreAX8JE11bg6Jj9JzoXUU8CKc5mdp65JtAMDN1pgDGX
         VpEA==
X-Gm-Message-State: AOAM532jrzcsR4HItulaLlPDe1K0CQeuCHC0HzMZw2n4OClNRE0fzKUJ
        g2Yz/NEPtNhlmqHHpRf1cII=
X-Google-Smtp-Source: ABdhPJx+RZ46UqXMazYzX5t9mfQ+j0OHEii8+THVYT62PhwFjG1kvFR63pEZgW/b3qE/vRtSjzPEFg==
X-Received: by 2002:ac8:5b82:: with SMTP id a2mr245806qta.178.1606945989605;
        Wed, 02 Dec 2020 13:53:09 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:ec0f])
        by smtp.gmail.com with ESMTPSA id n41sm223753qtb.18.2020.12.02.13.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 13:53:08 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 2 Dec 2020 16:52:40 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
        Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jan Kara <jack@suse.cz>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        dm-devel@redhat.com, Jan Kara <jack@suse.com>,
        linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 25/45] block: simplify bdev/disk lookup in blkdev_get
Message-ID: <X8gMqKKmG2WE2wqk@mtj.duckdns.org>
References: <20201128161510.347752-1-hch@lst.de>
 <20201128161510.347752-26-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201128161510.347752-26-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Nov 28, 2020 at 05:14:50PM +0100, Christoph Hellwig wrote:
> To simplify block device lookup and a few other upcoming areas, make sure
> that we always have a struct block_device available for each disk and
> each partition, and only find existing block devices in bdget.  The only
> downside of this is that each device and partition uses a little more
> memory.  The upside will be that a lot of code can be simplified.
> 
> With that all we need to look up the block device is to lookup the inode
> and do a few sanity checks on the gendisk, instead of the separate lookup
> for the gendisk.  For blk-cgroup which wants to access a gendisk without
> opening it, a new blkdev_{get,put}_no_open low-level interface is added
> to replace the previous get_gendisk use.
> 
> Note that the change to look up block device directly instead of the two
> step lookup using struct gendisk causes a subtile change in behavior:
> accessing a non-existing partition on an existing block device can now
> cause a call to request_module.  That call is harmless, and in practice
> no recent system will access these nodes as they aren't created by udev
> and static /dev/ setups are unusual.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

It's already merged but FWIW looks great to me.

Thank you.

-- 
tejun
