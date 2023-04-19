Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02EF76E7F66
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Apr 2023 18:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbjDSQSU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Apr 2023 12:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232218AbjDSQST (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Apr 2023 12:18:19 -0400
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C04E273B
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Apr 2023 09:17:37 -0700 (PDT)
Received: by mail-qv1-f48.google.com with SMTP id o7so248078qvs.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Apr 2023 09:17:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681921056; x=1684513056;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z+h5fwYkvTPr/F+On2Hs94r2JzzOUgRtGOCFJcgB1Q4=;
        b=Ux1ZGKTOyAc/SdLLLimvVbSEOZjrRbfnf2hLkv8zbSoToZ0II537g75IVPVBFWsUix
         nADz2XSC+nNnsxuXj9cWKETITuy8SdzRzmR5LfH7BIidfs+w5F7zXhq8pvMYUVK73CPn
         BIM6/6AXdjIwDEwsG5A3NEw/rrZplpY02yGi6UxC5FrGvLYHTa5tJ5OCbEoO6gR8K5Ni
         50G9QsyUQao2P1lS+tISQWv5iHxl3L2LgYi1j0K3aww1pveNGezEonxciF7qgPrapJSs
         WDbfCpe1uxoO8+pdV2yZfbvOZKWdGM03Guo2p2lLNFHe9STegOXg/ob1uk9nx/oRvhuN
         fV/A==
X-Gm-Message-State: AAQBX9dhdtyxFbVU1mv2CGBpVf9NvR+x9FP979PrlYuWrlLkX1FxlZQM
        6+cbyDWAIZFq/okP8fseriZ9
X-Google-Smtp-Source: AKy350ZIve4mrPgTdbna5Cjf8hcJps/K5ObL3J7QcbMVD+OWL/kHf3+Ovv9X5lr5nNp8ov9iF7wtcw==
X-Received: by 2002:a05:6214:252a:b0:5ef:8004:e0b4 with SMTP id gg10-20020a056214252a00b005ef8004e0b4mr17326482qvb.48.1681921056440;
        Wed, 19 Apr 2023 09:17:36 -0700 (PDT)
Received: from localhost (pool-68-160-166-30.bstnma.fios.verizon.net. [68.160.166.30])
        by smtp.gmail.com with ESMTPSA id b1-20020ac86bc1000000b003e65228ef54sm4902201qtt.86.2023.04.19.09.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 09:17:36 -0700 (PDT)
Date:   Wed, 19 Apr 2023 12:17:34 -0400
From:   Mike Snitzer <snitzer@kernel.org>
To:     "Darrick J. Wong" <djwong@kernel.org>,
        Sarthak Kukreti <sarthakkukreti@chromium.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Theodore Ts'o <tytso@mit.edu>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Bart Van Assche <bvanassche@google.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Daniil Lunev <dlunev@google.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Brian Foster <bfoster@redhat.com>,
        Alasdair Kergon <agk@redhat.com>
Subject: Re: [PATCH v4 1/4] block: Introduce provisioning primitives
Message-ID: <ZEAUHnWqt9cIiJRb@redhat.com>
References: <20230414000219.92640-1-sarthakkukreti@chromium.org>
 <20230418221207.244685-1-sarthakkukreti@chromium.org>
 <20230418221207.244685-2-sarthakkukreti@chromium.org>
 <20230419153611.GE360885@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230419153611.GE360885@frogsfrogsfrogs>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 19 2023 at 11:36P -0400,
Darrick J. Wong <djwong@kernel.org> wrote:

> On Tue, Apr 18, 2023 at 03:12:04PM -0700, Sarthak Kukreti wrote:
> > Introduce block request REQ_OP_PROVISION. The intent of this request
> > is to request underlying storage to preallocate disk space for the given
> > block range. Block devices that support this capability will export
> > a provision limit within their request queues.
> > 
> > This patch also adds the capability to call fallocate() in mode 0
> > on block devices, which will send REQ_OP_PROVISION to the block
> > device for the specified range,
> > 
> > Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
> > ---
> >  block/blk-core.c          |  5 ++++
> >  block/blk-lib.c           | 53 +++++++++++++++++++++++++++++++++++++++
> >  block/blk-merge.c         | 18 +++++++++++++
> >  block/blk-settings.c      | 19 ++++++++++++++
> >  block/blk-sysfs.c         |  8 ++++++
> >  block/bounce.c            |  1 +
> >  block/fops.c              | 25 +++++++++++++-----
> >  include/linux/bio.h       |  6 +++--
> >  include/linux/blk_types.h |  5 +++-
> >  include/linux/blkdev.h    | 16 ++++++++++++
> >  10 files changed, 147 insertions(+), 9 deletions(-)
> > 
> 
> <cut to the fallocate part; the block/ changes look fine to /me/ at
> first glance, but what do I know... ;)>
> 
> > diff --git a/block/fops.c b/block/fops.c
> > index d2e6be4e3d1c..e1775269654a 100644
> > --- a/block/fops.c
> > +++ b/block/fops.c
> > @@ -611,9 +611,13 @@ static ssize_t blkdev_read_iter(struct kiocb *iocb, struct iov_iter *to)
> >  	return ret;
> >  }
> >  
> > +#define	BLKDEV_FALLOC_FL_TRUNCATE				\
> 
> At first I thought from this name that you were defining a new truncate
> mode for fallocate, then I realized that this is mask for deciding if we
> /want/ to truncate the pagecache.
> 
> #define		BLKDEV_FALLOC_TRUNCATE_MASK ?
> 
> > +		(FALLOC_FL_PUNCH_HOLE |	FALLOC_FL_ZERO_RANGE |	\
> 
> Ok, so discarding and writing zeroes truncates the page cache, makes
> sense since we're "writing" directly to the block device.
> 
> > +		 FALLOC_FL_NO_HIDE_STALE)
> 
> Here things get tricky -- some of the FALLOC_FL mode bits are really an
> opcode and cannot be specified together, whereas others select optional
> behavior for certain opcodes.
> 
> IIRC, the mutually exclusive opcodes are:
> 
> 	PUNCH_HOLE
> 	ZERO_RANGE
> 	COLLAPSE_RANGE
> 	INSERT_RANGE
> 	(none of the above, for allocation)
> 
> and the "variants on a theme are":
> 
> 	KEEP_SIZE
> 	NO_HIDE_STALE
> 	UNSHARE_RANGE
> 
> not all of which are supported by all the opcodes.
> 
> Does it make sense to truncate the page cache if userspace passes in
> mode == NO_HIDE_STALE?  There's currently no defined meaning for this
> combination, but I think this means we'll truncate the pagecache before
> deciding if we're actually going to issue any commands.
> 
> I think that's just a bug in the existing code -- it should be
> validating that @mode is any of the supported combinations *before*
> truncating the pagecache.
> 
> Otherwise you could have a mkfs program that starts writing new fs
> metadata, decides to provision the storage (say for a logging region),
> doesn't realize it's running on an old kernel, and then oops the
> provision attempt fails but have we now shredded the pagecache and lost
> all the writes?

While that just caused me to have an "oh shit, that's crazy" (in a
scary way) belly laugh...
(And obviously needs fixing independent of this patchset)

Shouldn't mkfs first check that the underlying storage supports
REQ_OP_PROVISION by verifying
/sys/block/<dev>/queue/provision_max_bytes exists and is not 0?
(Just saying, we need to add new features more defensively.. you just
made the case based on this scenario's implications alone)

Sarthak, please note I said "provision_max_bytes": all other ops
(e.g. DISCARD, WRITE_ZEROES, etc) have <op>_max_bytes exported through
sysfs, not <op>_max_sectors.  Please export provision_max_bytes, e.g.:

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 202aa78f933e..2e5ac7b1ffbd 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -605,12 +605,12 @@ QUEUE_RO_ENTRY(queue_io_min, "minimum_io_size");
 QUEUE_RO_ENTRY(queue_io_opt, "optimal_io_size");
 
 QUEUE_RO_ENTRY(queue_max_discard_segments, "max_discard_segments");
-QUEUE_RO_ENTRY(queue_max_provision_sectors, "max_provision_sectors");
 QUEUE_RO_ENTRY(queue_discard_granularity, "discard_granularity");
 QUEUE_RO_ENTRY(queue_discard_max_hw, "discard_max_hw_bytes");
 QUEUE_RW_ENTRY(queue_discard_max, "discard_max_bytes");
 QUEUE_RO_ENTRY(queue_discard_zeroes_data, "discard_zeroes_data");
 
+QUEUE_RO_ENTRY(queue_provision_max, "provision_max_bytes");
 QUEUE_RO_ENTRY(queue_write_same_max, "write_same_max_bytes");
 QUEUE_RO_ENTRY(queue_write_zeroes_max, "write_zeroes_max_bytes");
 QUEUE_RO_ENTRY(queue_zone_append_max, "zone_append_max_bytes");
