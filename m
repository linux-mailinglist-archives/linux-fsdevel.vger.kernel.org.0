Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2EEC3B193F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jun 2021 13:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbhFWLvZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Jun 2021 07:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbhFWLvY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Jun 2021 07:51:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5FAC061574;
        Wed, 23 Jun 2021 04:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=b1RayldO4nvcoESER3Xz5ONjlHOB5LDTTaLrHfeN1ho=; b=nCvfZawva1HhJxn/bnxl4VCvvK
        WYnkbSoarlik1hjX9RXd2wMGNc8gXB7GxeqaLVmQvnw2C10eu6c9hT/kNqQGOM7tMVaJXi4A3aGMt
        ytMH9Ve53R6Ikq3a8i85+pDj0vGughLhQT4w8a2/iEtCOuWi0vMPq6YYIgXdfRn9H04f3TQ91tCQn
        /9AWAPyk/JnZ4zyaKJqDl6GfngNvhAh7TvHaqTGOx2jMcMrBgESLnAwaTiEBnq51fffv0w2OZXWs+
        naSPswyYmh5+SmabtODLlgEZ8G/u6N/FM5+8khKaPP4my5Gh4J+iYePB/5h+/P2rTRF/h+MJ6P1Jx
        YvAJPI9A==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lw1Ma-00FNZe-V3; Wed, 23 Jun 2021 11:48:18 +0000
Date:   Wed, 23 Jun 2021 12:48:12 +0100
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
Subject: Re: [PATCH v3 1/6] block: add disk sequence number
Message-ID: <YNMffBWvs/Fz2ptK@infradead.org>
References: <20210623105858.6978-1-mcroce@linux.microsoft.com>
 <20210623105858.6978-2-mcroce@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210623105858.6978-2-mcroce@linux.microsoft.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 23, 2021 at 12:58:53PM +0200, Matteo Croce wrote:
> +void inc_diskseq(struct gendisk *disk)
> +{
> +	static atomic64_t diskseq;

Please don't hide file scope variables in functions.

Can you explain a little more why we need a global sequence count vs
a per-disk one here?
