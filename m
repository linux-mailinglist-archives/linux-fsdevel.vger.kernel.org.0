Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 338263B195F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jun 2021 13:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbhFWL4N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Jun 2021 07:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbhFWL4N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Jun 2021 07:56:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6118C061574;
        Wed, 23 Jun 2021 04:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=C76xuKc0/I/xOs/y/pdbSsixKGVcKLl7S3Wq7XHoPp8=; b=qONu4UaOXnSjh+9vZhiINjShGz
        FvBdZHJ0lvQRldfL6CjUhxmofCzkMQQr2iCvn1SpLxI1HJauuEhANX1ALoaWfuxypO4JDw9PpR+7E
        kSkCWU5/73MRD3NyaQwLqN7aRWY4DvMFd6c6TuAt1qRlInpDO9MUQn/qM86sK97NApbKEKpsKKaNY
        mJL9jYmk8kJxTOL9BxIQXrZRF5WaQf6EgDOOU9tzv92t5OTKAwLTpVSVDNhhxZBtYnCuypmdcxt1N
        G1oyvvNmsRvX406yjTgW3Y1pFc2kmJbgNFhPexxbRihTD5c8ouUUoh/yh1/W7Eslxs4ncVnpXtx9f
        tZThuytg==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lw1RA-00FNss-2e; Wed, 23 Jun 2021 11:53:01 +0000
Date:   Wed, 23 Jun 2021 12:52:56 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Matteo Croce <mcroce@linux.microsoft.com>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        Lennart Poettering <lennart@poettering.net>,
        Luca Boccassi <bluca@debian.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Tejun Heo <tj@kernel.org>,
        Javier Gonz??lez <javier@javigon.com>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        JeffleXu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH v3 3/6] block: refactor sysfs code
Message-ID: <YNMgmK2vqQPL7PWb@infradead.org>
References: <20210623105858.6978-1-mcroce@linux.microsoft.com>
 <20210623105858.6978-4-mcroce@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210623105858.6978-4-mcroce@linux.microsoft.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> -static void disk_add_events(struct gendisk *disk)
> +static void disk_add_sysfs(struct gendisk *disk)
>  {
>  	/* FIXME: error handling */
> -	if (sysfs_create_files(&disk_to_dev(disk)->kobj, disk_events_attrs) < 0)
> +	if (sysfs_create_files(&disk_to_dev(disk)->kobj, disk_sysfs_attrs) < 0)
>  		pr_warn("%s: failed to create sysfs files for events\n",
>  			disk->disk_name);
> +}

Actually, what we need here is a way how we can setup the ->groups
field of the device to include all attribute groups instead of having
to call sysfs_create_files at all.
