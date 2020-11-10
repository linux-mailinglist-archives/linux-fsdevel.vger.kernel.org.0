Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0593C2ADCBF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Nov 2020 18:20:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbgKJRU1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Nov 2020 12:20:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbgKJRU1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Nov 2020 12:20:27 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3653C0613CF;
        Tue, 10 Nov 2020 09:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WtLvsd+PYLZ22ThXIUu3CAFmse0F4aW6/fbAcYoCw14=; b=FTUqYVwLnXUVDbRTL9D23EwKzL
        nbr36rcEvhZXC/NWQTMlw0o1GdJwiczY3v6/zsoSJ0jdqUQBcngMIDDLJTCcGnHtgwb+3TKkhhavK
        bDeB0n+obsqGwOs3lCcYmrMqS1HWzKP6o6vObJUo2cF+xnqLB48DWk4Vj9CurBd3aFSGQBc+sCV0o
        k2UBaTZfrbtp3hNVINynswQf5LlpVtken9f6t1eHmD9wW8dHDcdjeFZHLElAtJ1TP9HorDSjucikO
        vZN+l3F/rsenhjMkjquI3/Kym6OTMxbNMkfIQGGcVE37UrgtgCjBIdOyHYd3rsO0S1hbtMA+8MNCt
        I4aEbBvA==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kcXJf-000622-RZ; Tue, 10 Nov 2020 17:20:23 +0000
Date:   Tue, 10 Nov 2020 17:20:23 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com, hare@suse.com,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH v10 01/41] block: add bio_add_zone_append_page
Message-ID: <20201110172023.GA22758@infradead.org>
References: <cover.1605007036.git.naohiro.aota@wdc.com>
 <01fbaba7b2f2404489b5779e1719ebf3d062aadc.1605007036.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01fbaba7b2f2404489b5779e1719ebf3d062aadc.1605007036.git.naohiro.aota@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> +int bio_add_zone_append_page(struct bio *bio, struct page *page,
> +			     unsigned int len, unsigned int offset)
> +{
> +	struct request_queue *q;
> +	bool same_page = false;
> +
> +	if (WARN_ON_ONCE(bio_op(bio) != REQ_OP_ZONE_APPEND))
> +		return 0;
> +
> +	if (WARN_ON_ONCE(!bio->bi_disk))
> +		return 0;

Do we need this check?  I'd rather just initialize q at declaration time
and let the NULL pointer deref be the obvious sign for a grave
programming error..

Except for that the patch looks good to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>
