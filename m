Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFE04700DE9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 May 2023 19:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237845AbjELRdb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 May 2023 13:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237231AbjELRda (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 May 2023 13:33:30 -0400
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5681FC6
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 May 2023 10:32:43 -0700 (PDT)
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-61a62fc8b5bso80703276d6.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 May 2023 10:32:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683912762; x=1686504762;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6V0M3WHsM/CbP7GPo2jgrowLKKxSm62sS3psQx8zXQg=;
        b=RbIhACnbukZpt5TsHOinhzT/dWdZaNET/6ZKSerHIJL9k+VFb5+lUKLUlsETzSHLhS
         kgX0jaswHCrgVLgvdyXhZSfrYdLIC25TsbCtsThHhEATxXsYEzdfEf+BI/zJ4aPezOtT
         1D2qOqm2B5hn+1rRt8BIXlSf+p9LPlgiEiUqu70B4QFF3zEyPjV/EnOHQslDu3753noL
         b/WL7JWts0Ev9yLQ9qKR4I/YY/+ByGw1nlQIB9fMEQKKefemdyFN3SeHNuqAGBmaC0sv
         Og8tYeUR59cvB2matWMIfzphxB2LmRZ0RoG77RHrRrqFhu8+i+/tCufjyWdm+GjduGOY
         +Nkg==
X-Gm-Message-State: AC+VfDyyEQLqNqOJc9grEu/xV6l794nOYpOoPwQuMgYGzkddpeyXuxhc
        cWmuR2HUp59Yks8ijXE+pK5m
X-Google-Smtp-Source: ACHHUZ5jRqBe5V3qEMe4Dw+z/UN5rDNtGltRsfG7pSdt3oaD03wHbynKxPl194sOY+kaYveH3Enm2A==
X-Received: by 2002:ad4:5ae5:0:b0:621:1b1d:7dde with SMTP id c5-20020ad45ae5000000b006211b1d7ddemr38554895qvh.8.1683912762375;
        Fri, 12 May 2023 10:32:42 -0700 (PDT)
Received: from localhost (pool-68-160-166-30.bstnma.fios.verizon.net. [68.160.166.30])
        by smtp.gmail.com with ESMTPSA id h10-20020a0cf20a000000b0061b5c45f970sm3137246qvk.74.2023.05.12.10.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 10:32:41 -0700 (PDT)
Date:   Fri, 12 May 2023 13:32:40 -0400
From:   Mike Snitzer <snitzer@kernel.org>
To:     Sarthak Kukreti <sarthakkukreti@chromium.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Theodore Ts'o <tytso@mit.edu>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Jason Wang <jasowang@redhat.com>,
        Bart Van Assche <bvanassche@google.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Brian Foster <bfoster@redhat.com>,
        Alasdair Kergon <agk@redhat.com>
Subject: Re: [PATCH v6 4/5] dm-thin: Add REQ_OP_PROVISION support
Message-ID: <ZF54OH8hZTTko4c3@redhat.com>
References: <20230420004850.297045-1-sarthakkukreti@chromium.org>
 <20230506062909.74601-1-sarthakkukreti@chromium.org>
 <20230506062909.74601-5-sarthakkukreti@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230506062909.74601-5-sarthakkukreti@chromium.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 06 2023 at  2:29P -0400,
Sarthak Kukreti <sarthakkukreti@chromium.org> wrote:

> dm-thinpool uses the provision request to provision
> blocks for a dm-thin device. dm-thinpool currently does not
> pass through REQ_OP_PROVISION to underlying devices.
> 
> For shared blocks, provision requests will break sharing and copy the
> contents of the entire block. Additionally, if 'skip_block_zeroing'
> is not set, dm-thin will opt to zero out the entire range as a part
> of provisioning.
> 
> Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
> ---
>  drivers/md/dm-thin.c | 70 +++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 66 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/md/dm-thin.c b/drivers/md/dm-thin.c
> index 2b13c949bd72..3f94f53ac956 100644
> --- a/drivers/md/dm-thin.c
> +++ b/drivers/md/dm-thin.c
...
> @@ -4114,6 +4171,8 @@ static void pool_io_hints(struct dm_target *ti, struct queue_limits *limits)
>  	 * The pool uses the same discard limits as the underlying data
>  	 * device.  DM core has already set this up.
>  	 */
> +
> +	limits->max_provision_sectors = pool->sectors_per_block;

Just noticed that setting limits->max_provision_sectors needs to move
above pool_io_hints code that sets up discards -- otherwise the early
return from if (!pt->adjusted_pf.discard_enabled) will cause setting
max_provision_sectors to be skipped.

Here is a roll up of the fixes that need to be folded into this patch:

diff --git a/drivers/md/dm-thin.c b/drivers/md/dm-thin.c
index 3f94f53ac956..90c8e36cb327 100644
--- a/drivers/md/dm-thin.c
+++ b/drivers/md/dm-thin.c
@@ -4151,6 +4151,8 @@ static void pool_io_hints(struct dm_target *ti, struct queue_limits *limits)
 		blk_limits_io_opt(limits, pool->sectors_per_block << SECTOR_SHIFT);
 	}
 
+	limits->max_provision_sectors = pool->sectors_per_block;
+
 	/*
 	 * pt->adjusted_pf is a staging area for the actual features to use.
 	 * They get transferred to the live pool in bind_control_target()
@@ -4171,8 +4173,6 @@ static void pool_io_hints(struct dm_target *ti, struct queue_limits *limits)
 	 * The pool uses the same discard limits as the underlying data
 	 * device.  DM core has already set this up.
 	 */
-
-	limits->max_provision_sectors = pool->sectors_per_block;
 }
 
 static struct target_type pool_target = {
@@ -4349,6 +4349,7 @@ static int thin_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 
 	ti->num_provision_bios = 1;
 	ti->provision_supported = true;
+	ti->max_provision_granularity = true;
 
 	mutex_unlock(&dm_thin_pool_table.mutex);
 
