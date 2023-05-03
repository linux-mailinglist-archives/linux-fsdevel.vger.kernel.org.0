Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1DD96F6121
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 May 2023 00:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjECWR5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 May 2023 18:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjECWRz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 May 2023 18:17:55 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4800583DD
        for <linux-fsdevel@vger.kernel.org>; Wed,  3 May 2023 15:17:53 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-52c759b7d45so811563a12.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 May 2023 15:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1683152273; x=1685744273;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SZlTdG04TqTF7+/hzp5sSJRuB5EmsmvAFGgc3K+3F0Y=;
        b=39WVkULqHXRDJ4WUYe73OzFA/R2wak2Byvue6BmOkCk/OUZ7TIFexiujMgqDtXjhoJ
         vY8UhclcPr7rl4Zv2wbm/zdzS0ni41dpAUltS0ZIuTMSWKNEFldMe8omTChgh7JjGHw9
         rVsx1Yw28FjKmAmsO5frsdqvSKA4ZJrGU5Gp+Q9w3fCsWnJVySoTDQBrKpXRB+VVwMsd
         2mP535YsEeeVtqm0f04weAqu0Ix/cKqOgjAhn6wHaEI53Xkx+scS9ruET4oev/lz/RR9
         HuYeHautziBafZRfpxfmTZFWObUFN65QoOJpAc8Hd0Mv9bIad3zclXTZRNBKp80hSzAf
         fzBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683152273; x=1685744273;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SZlTdG04TqTF7+/hzp5sSJRuB5EmsmvAFGgc3K+3F0Y=;
        b=Mki6iROCksNmbrDkHhg8SduM8kVIDr62lKjzRFx+WOyHf2fi/P6eT5rPNckS2z7qtG
         YE3yZ6v8PVbNhmiCiuNxyagtvffGrNm1wVDApI63Qt1mqAYx2QD/c7UQkXn/GsTGwcJb
         R5A+nOudHwdXz/dqi4/rOnRq7hp3IOfrnDYvlNykteH+h8elKLjPiAViCTz1oC8oEWww
         jNGmsD/QhL0M/OyAFt7vLBAlajFTXnmLbftulepuoGz0vHzpR3BFlSV2uzhGt8Otsqdg
         HKrX/jKB3n05+UExBDzPavCDv+RvAg5e4ewwuYFAyqoNCjs3L/FeP0rIwftCGXFvBfcB
         5hxg==
X-Gm-Message-State: AC+VfDxH62WBVVHer+69aYf0O1iJm2drO8ONVZ/DxdqEO21cV8Sh4SKU
        W0JP0urQqrSYi6ZEs+oz2s3TBA==
X-Google-Smtp-Source: ACHHUZ6w6FNkuZBKWIHG+izk4/mp1lXBQ8ap+jb9gyt4ryTRiawSHwELQjohp4JJfay700Tr/2IfyQ==
X-Received: by 2002:a17:902:be08:b0:1a6:d8a3:3346 with SMTP id r8-20020a170902be0800b001a6d8a33346mr1422648pls.31.1683152272764;
        Wed, 03 May 2023 15:17:52 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-88-204.pa.nsw.optusnet.com.au. [49.181.88.204])
        by smtp.gmail.com with ESMTPSA id q7-20020a170902bd8700b001a6ff7bd4d9sm22112696pls.15.2023.05.03.15.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 15:17:51 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1puKnF-00B0ur-4U; Thu, 04 May 2023 08:17:49 +1000
Date:   Thu, 4 May 2023 08:17:49 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     John Garry <john.g.garry@oracle.com>
Cc:     axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
        jejb@linux.ibm.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com
Subject: Re: [PATCH RFC 03/16] xfs: Support atomic write for statx
Message-ID: <20230503221749.GF3223426@dread.disaster.area>
References: <20230503183821.1473305-1-john.g.garry@oracle.com>
 <20230503183821.1473305-4-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230503183821.1473305-4-john.g.garry@oracle.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 03, 2023 at 06:38:08PM +0000, John Garry wrote:
> Support providing info on atomic write unit min and max.
> 
> Darrick Wong originally authored this change.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  fs/xfs/xfs_iops.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> index 24718adb3c16..e542077704aa 100644
> --- a/fs/xfs/xfs_iops.c
> +++ b/fs/xfs/xfs_iops.c
> @@ -614,6 +614,16 @@ xfs_vn_getattr(
>  			stat->dio_mem_align = bdev_dma_alignment(bdev) + 1;
>  			stat->dio_offset_align = bdev_logical_block_size(bdev);
>  		}
> +		if (request_mask & STATX_WRITE_ATOMIC) {
> +			struct xfs_buftarg	*target = xfs_inode_buftarg(ip);
> +			struct block_device	*bdev = target->bt_bdev;
> +
> +			stat->atomic_write_unit_min = queue_atomic_write_unit_min(bdev->bd_queue);
> +			stat->atomic_write_unit_max = queue_atomic_write_unit_max(bdev->bd_queue);

I'm not sure this is right.

Given that we may have a 4kB physical sector device, XFS will not
allow IOs smaller than physical sector size. The initial values of
queue_atomic_write_unit_min/max() will be (1 << SECTOR_SIZE) which
is 512 bytes. IOs done with 4kB sector size devices will fail in
this case.

Further, XFS has a software sector size - it can define the sector
size for the filesystem to be 4KB on a 512 byte sector device. And
in that case, the filesystem will reject 512 byte sized/aligned IOs
as they are smaller than the filesystem sector size (i.e. a config
that prevents sub-physical sector IO for 512 logical/4kB physical
devices).

There may other filesystem constraints - realtime devices have fixed
minimum allocation sizes which may be larger than atomic write
limits, which means that IO completion needs to split extents into
multiple unwritten/written extents, extent size hints might be in
use meaning we have different allocation alignment constraints to
atomic write constraints, stripe alignment of extent allocation may
through out atomic write alignment, etc.

These are all solvable, but we need to make sure here that the
filesystem constraints are taken into account here, not just the
block device limits.

As such, it is probably better to query these limits at filesystem
mount time and add them to the xfs buftarg (same as we do for
logical and physical sector sizes) and then use the xfs buftarg
values rather than having to go all the way to the device queue
here. That way we can ensure at mount time that atomic write limits
don't conflict with logical/physical IO limits, and we can further
constrain atomic limits during mount without always having to
recalculate those limits from first principles on every stat()
call...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
