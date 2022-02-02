Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 403FF4A7618
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Feb 2022 17:40:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345971AbiBBQks (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Feb 2022 11:40:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43132 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345983AbiBBQkk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Feb 2022 11:40:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643820039;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RkPWSrbUhue/IGuXAsyfEqPciSlbxQ314sYBlz/Oexs=;
        b=MUg7dR2n1twJTHEtcDo6DFWIK8oI64oBBsKlCh+jQbf+qvtVaWdp9BJYgSxGVSxTT6Ggt1
        NuxRnzBll4BAV97IvXkuEaMWVp96F0AAV7wBZU/l2ExjxzkekKSBOd2EQZiM9dBwpMNhPu
        WQrAmv/dYBm9B5rSx3BnN+42IXOhaK4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-224-35Gc2b91Oea_SG3sjsQYzA-1; Wed, 02 Feb 2022 11:40:38 -0500
X-MC-Unique: 35Gc2b91Oea_SG3sjsQYzA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1C1F21853022;
        Wed,  2 Feb 2022 16:40:33 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 914772B4C9;
        Wed,  2 Feb 2022 16:40:32 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 212GeW3G000735;
        Wed, 2 Feb 2022 11:40:32 -0500
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 212GeUkY000731;
        Wed, 2 Feb 2022 11:40:30 -0500
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Wed, 2 Feb 2022 11:40:30 -0500 (EST)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Keith Busch <kbusch@kernel.org>
cc:     =?ISO-8859-15?Q?Javier_Gonz=E1lez?= <javier@javigon.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "msnitzer@redhat.com >> msnitzer@redhat.com" <msnitzer@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "martin.petersen@oracle.com >> Martin K. Petersen" 
        <martin.petersen@oracle.com>,
        "roland@purestorage.com" <roland@purestorage.com>,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
        "Frederick.Knight@netapp.com" <Frederick.Knight@netapp.com>,
        "zach.brown@ni.com" <zach.brown@ni.com>,
        "osandov@fb.com" <osandov@fb.com>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "clm@fb.com" <clm@fb.com>, "dsterba@suse.com" <dsterba@suse.com>,
        "tytso@mit.edu" <tytso@mit.edu>, "jack@suse.com" <jack@suse.com>,
        Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [RFC PATCH 1/3] block: add copy offload support
In-Reply-To: <20220202162147.GC3077632@dhcp-10-100-145-180.wdc.com>
Message-ID: <alpine.LRH.2.02.2202021134400.31294@file01.intranet.prod.int.rdu2.redhat.com>
References: <f0e19ae4-b37a-e9a3-2be7-a5afb334a5c3@nvidia.com> <20220201102122.4okwj2gipjbvuyux@mpHalley-2> <alpine.LRH.2.02.2202011327350.22481@file01.intranet.prod.int.rdu2.redhat.com> <alpine.LRH.2.02.2202011331570.22481@file01.intranet.prod.int.rdu2.redhat.com>
 <20220202162147.GC3077632@dhcp-10-100-145-180.wdc.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On Wed, 2 Feb 2022, Keith Busch wrote:

> On Tue, Feb 01, 2022 at 01:32:29PM -0500, Mikulas Patocka wrote:
> > +int blkdev_issue_copy(struct block_device *bdev1, sector_t sector1,
> > +		      struct block_device *bdev2, sector_t sector2,
> > +		      sector_t nr_sects, sector_t *copied, gfp_t gfp_mask)
> > +{
> > +	struct page *token;
> > +	sector_t m;
> > +	int r = 0;
> > +	struct completion comp;
> > +
> > +	*copied = 0;
> > +
> > +	m = min(bdev_max_copy_sectors(bdev1), bdev_max_copy_sectors(bdev2));
> > +	if (!m)
> > +		return -EOPNOTSUPP;
> > +	m = min(m, (sector_t)round_down(UINT_MAX, PAGE_SIZE) >> 9);
> > +
> > +	if (unlikely(bdev_read_only(bdev2)))
> > +		return -EPERM;
> > +
> > +	token = alloc_page(gfp_mask);
> > +	if (unlikely(!token))
> > +		return -ENOMEM;
> > +
> > +	while (nr_sects) {
> > +		struct bio *read_bio, *write_bio;
> > +		sector_t this_step = min(nr_sects, m);
> > +
> > +		read_bio = bio_alloc(gfp_mask, 1);
> > +		if (unlikely(!read_bio)) {
> > +			r = -ENOMEM;
> > +			break;
> > +		}
> > +		bio_set_op_attrs(read_bio, REQ_OP_COPY_READ_TOKEN, REQ_NOMERGE);
> > +		bio_set_dev(read_bio, bdev1);
> > +		__bio_add_page(read_bio, token, PAGE_SIZE, 0);
> 
> You have this "token" payload as driver specific data, but there's no
> check that bdev1 and bdev2 subscribe to the same driver specific format.
> 
> I thought we discussed defining something like a "copy domain" that
> establishes which block devices can offload copy operations to/from each
> other, and that should be checked before proceeding with the copy
> operation.

There is nvme_setup_read_token that fills in the token:
	memcpy(token->subsys, "nvme", 4);
	token->ns = ns;
	token->src_sector = bio->bi_iter.bi_sector;
	token->sectors = bio->bi_iter.bi_size >> 9;

There is nvme_setup_write_token that checks these values:
	if (unlikely(memcmp(token->subsys, "nvme", 4)))
		return BLK_STS_NOTSUPP;
	if (unlikely(token->ns != ns))
		return BLK_STS_NOTSUPP;

So, if we attempt to copy data between the nvme subsystem and the scsi 
subsystem, the "subsys" check will fail. If we attempt to copy data 
between different nvme namespaces, the "ns" check will fail.

If the nvme standard gets extended with cross-namespace copies, we can 
check in nvme_setup_write_token if we can copy between the source and 
destination namespace.

Mikulas

