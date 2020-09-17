Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF1BD26D851
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Sep 2020 12:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbgIQKFE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Sep 2020 06:05:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:36996 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726217AbgIQKFC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Sep 2020 06:05:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DEFB0AD03;
        Thu, 17 Sep 2020 10:05:33 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id ADFA01E12E1; Thu, 17 Sep 2020 12:04:59 +0200 (CEST)
Date:   Thu, 17 Sep 2020 12:04:59 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Song Liu <song@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Richard Weinberger <richard@nod.at>,
        Minchan Kim <minchan@kernel.org>,
        linux-mtd@lists.infradead.org, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        drbd-dev@lists.linbit.com, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org, David Sterba <dsterba@suse.com>
Subject: Re: [PATCH 04/12] bdi: initialize ->ra_pages and ->io_pages in
 bdi_init
Message-ID: <20200917100459.GK7347@quack2.suse.cz>
References: <20200910144833.742260-1-hch@lst.de>
 <20200910144833.742260-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910144833.742260-5-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 10-09-20 16:48:24, Christoph Hellwig wrote:
> Set up a readahead size by default, as very few users have a good
> reason to change it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: David Sterba <dsterba@suse.com> [btrfs]
> Acked-by: Richard Weinberger <richard@nod.at> [ubifs, mtd]

Looks good but what about coda, ecryptfs, and orangefs? Currenly they have
readahead disabled and this patch would seem to enable it?

> diff --git a/mm/backing-dev.c b/mm/backing-dev.c
> index 8e8b00627bb2d8..2dac3be6127127 100644
> --- a/mm/backing-dev.c
> +++ b/mm/backing-dev.c
> @@ -746,6 +746,8 @@ struct backing_dev_info *bdi_alloc(int node_id)
>  		kfree(bdi);
>  		return NULL;
>  	}
> +	bdi->ra_pages = VM_READAHEAD_PAGES;
> +	bdi->io_pages = VM_READAHEAD_PAGES;

Won't this be more logical in bdi_init() than in bdi_alloc()?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
