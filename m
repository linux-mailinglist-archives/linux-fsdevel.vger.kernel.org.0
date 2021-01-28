Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB3F307BA5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 18:02:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232848AbhA1RBS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 12:01:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:47062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232683AbhA1RA2 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 12:00:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0EEE564E0E;
        Thu, 28 Jan 2021 16:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611853187;
        bh=f6FDYR+2fbZ3ZjuVDKmJrkeFHlqyA4P3vGdmoyOPa1M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rzag2xxRHgFBGSJ365/QUldWd9CTCZVGt3cs71rJutBhKs94QB4O0wVHJ78U0xIF9
         n96V7cXtAmPsB9hu9gUYvKXwcH1SXtYNdkFw15Hr/lW1MQ6ApKzq4voIl5psE+u1SS
         oIYlBt3CEfmzYKr/W9GKeV1ES9XtHwmC1KiXTL4cmN2/9EoY9kXCbDD71u9sIp+Nfr
         FbyyfdHM+E5ZA+F8801PzzCElIq3kyLXwweF8LRAnfmH79wwG+57YuSijr3uE7kbk9
         /DpcS6Ckt3f1RwDjmwI1QhKt/MkNHods9aX+BJj1ComGJOXJH3o25qnvlVltgShwCo
         r/bA/dJbtb2Sw==
Date:   Thu, 28 Jan 2021 08:59:46 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com,
        xen-devel@lists.xenproject.org, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net, linux-nilfs@vger.kernel.org,
        ocfs2-devel@oss.oracle.com, linux-pm@vger.kernel.org,
        linux-mm@kvack.org, axboe@kernel.dk, philipp.reisner@linbit.com,
        lars.ellenberg@linbit.com, konrad.wilk@oracle.com,
        roger.pau@citrix.com, minchan@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, agk@redhat.com,
        snitzer@redhat.com, hch@lst.de, sagi@grimberg.me,
        martin.petersen@oracle.com, viro@zeniv.linux.org.uk, tytso@mit.edu,
        jaegeuk@kernel.org, ebiggers@kernel.org, shaggy@kernel.org,
        konishi.ryusuke@gmail.com, mark@fasheh.com, jlbec@evilplan.org,
        joseph.qi@linux.alibaba.com, damien.lemoal@wdc.com,
        naohiro.aota@wdc.com, jth@kernel.org, rjw@rjwysocki.net,
        len.brown@intel.com, pavel@ucw.cz, akpm@linux-foundation.org,
        hare@suse.de, gustavoars@kernel.org, tiwai@suse.de,
        alex.shi@linux.alibaba.com, asml.silence@gmail.com,
        ming.lei@redhat.com, tj@kernel.org, osandov@fb.com,
        bvanassche@acm.org, jefflexu@linux.alibaba.com
Subject: Re: [RFC PATCH 17/34] iomap: use bio_new in iomap_dio_zero
Message-ID: <20210128165946.GL7698@magnolia>
References: <20210128071133.60335-1-chaitanya.kulkarni@wdc.com>
 <20210128071133.60335-18-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210128071133.60335-18-chaitanya.kulkarni@wdc.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 27, 2021 at 11:11:16PM -0800, Chaitanya Kulkarni wrote:
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

Looks ok to me,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/iomap/direct-io.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index ea1e8f696076..f6c557a1bd25 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -189,15 +189,13 @@ iomap_dio_zero(struct iomap_dio *dio, struct iomap *iomap, loff_t pos,
>  	int flags = REQ_SYNC | REQ_IDLE;
>  	struct bio *bio;
>  
> -	bio = bio_alloc(GFP_KERNEL, 1);
> -	bio_set_dev(bio, iomap->bdev);
> -	bio->bi_iter.bi_sector = iomap_sector(iomap, pos);
> +	bio = bio_new(iomap->bdev, iomap_sector(iomap, pos), REQ_OP_WRITE,
> +		      flags, 1, GFP_KERNEL);
>  	bio->bi_private = dio;
>  	bio->bi_end_io = iomap_dio_bio_end_io;
>  
>  	get_page(page);
>  	__bio_add_page(bio, page, len, 0);
> -	bio_set_op_attrs(bio, REQ_OP_WRITE, flags);
>  	iomap_dio_submit_bio(dio, iomap, bio, pos);
>  }
>  
> -- 
> 2.22.1
> 
