Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D43AF70C52B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 May 2023 20:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233608AbjEVS2r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 May 2023 14:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233535AbjEVS2q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 May 2023 14:28:46 -0400
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D09E95
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 May 2023 11:28:00 -0700 (PDT)
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-75788255892so311196785a.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 May 2023 11:28:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684780080; x=1687372080;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p7GzxNEPB5RrqIL7H106LwNVqNBV2sg10P6y5N7WaSk=;
        b=ESA9mM+334mmkJeJe238af1sLkoxERxIgq1m++Bp8vYgSfNP64ITeRtG9QsaihEEyd
         hzFqi7N2kibzKcg/VTXIMT6oNgEfWbXO52uQwPxE46v9+bwNCKIVmWhheivbwZmrXSXd
         wTWSdgYr0qXdwDxHqWHr6+Of/I12Kj5VSxPMcu7sgsGLRLXXhd4FpZtEJMHm8T7ixGTJ
         UkqCMxBckjqax2Ggvc82BV1iy85nvAR7a4bDOP+UcYAi+/Om7SHIaxQyrVqMqxhoX4xh
         zj2UIpulUbht9GRVuxZfyten4Qfh1ir6L6RTGeBq8/DjEJo4uCZaNJ5FxZxYVj/CAlAg
         vMSw==
X-Gm-Message-State: AC+VfDzKstNY6vaIiwK4JtVUfNr4sZ1SXXOxeYbvcIx5oBsFHlcvmg+u
        0Du5RTsSfKO2p6SG49K7htCy
X-Google-Smtp-Source: ACHHUZ5cNHDfNJtYuuNT8G4J5JsInsTlSg1wDbr/+6XLCC/c6hq9pMKzuHMG58VXqxmVmQvtSAcUtw==
X-Received: by 2002:a05:6214:f22:b0:625:833e:8825 with SMTP id iw2-20020a0562140f2200b00625833e8825mr5440304qvb.4.1684780079641;
        Mon, 22 May 2023 11:27:59 -0700 (PDT)
Received: from localhost (pool-68-160-166-30.bstnma.fios.verizon.net. [68.160.166.30])
        by smtp.gmail.com with ESMTPSA id u12-20020a0ced2c000000b0061b5c45f970sm2137700qvq.74.2023.05.22.11.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 11:27:59 -0700 (PDT)
Date:   Mon, 22 May 2023 14:27:57 -0400
From:   Mike Snitzer <snitzer@kernel.org>
To:     Dave Chinner <david@fromorbit.com>, Joe Thornber <ejt@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Jason Wang <jasowang@redhat.com>,
        Bart Van Assche <bvanassche@google.com>,
        linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>, dm-devel@redhat.com,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Sarthak Kukreti <sarthakkukreti@chromium.org>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Brian Foster <bfoster@redhat.com>,
        Alasdair Kergon <agk@redhat.com>
Subject: Re: [PATCH v7 0/5] Introduce provisioning primitives
Message-ID: <ZGu0LaQfREvOQO4h@redhat.com>
References: <20230518223326.18744-1-sarthakkukreti@chromium.org>
 <ZGb2Xi6O3i2pLam8@infradead.org>
 <ZGeKm+jcBxzkMXQs@redhat.com>
 <ZGgBQhsbU9b0RiT1@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGgBQhsbU9b0RiT1@dread.disaster.area>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 19 2023 at  7:07P -0400,
Dave Chinner <david@fromorbit.com> wrote:

> On Fri, May 19, 2023 at 10:41:31AM -0400, Mike Snitzer wrote:
> > On Fri, May 19 2023 at 12:09P -0400,
> > Christoph Hellwig <hch@infradead.org> wrote:
> > 
> > > FYI, I really don't think this primitive is a good idea.  In the
> > > concept of non-overwritable storage (NAND, SMR drives) the entire
> > > concept of a one-shoot 'provisioning' that will guarantee later writes
> > > are always possible is simply bogus.
> > 
> > Valid point for sure, such storage shouldn't advertise support (and
> > will return -EOPNOTSUPP).
> > 
> > But the primitive still has utility for other classes of storage.
> 
> Yet the thing people are wanting to us filesystem developers to use
> this with is thinly provisioned storage that has snapshot
> capability. That, by definition, is non-overwritable storage. These
> are the use cases people are asking filesystes to gracefully handle
> and report errors when the sparse backing store runs out of space.

DM thinp falls into this category but as you detailed it can be made
to work reliably. To carry that forward we need to first establish
the REQ_PROVISION primitive (with this series).

Follow-on associated dm-thinp enhancements can then serve as reference
for how to take advantage of XFS's ability to operate reliably of
thinly provisioned storage.
 
> e.g. journal writes after a snapshot is taken on a busy filesystem
> are always an overwrite and this requires more space in the storage
> device for the write to succeed. ENOSPC from the backing device for
> journal IO is a -fatal error-. Hence if REQ_PROVISION doesn't
> guarantee space for overwrites after snapshots, then it's not
> actually useful for solving the real world use cases we actually
> need device-level provisioning to solve.
> 
> It is not viable for filesystems to have to reprovision space for
> in-place metadata overwrites after every snapshot - the filesystem
> may not even know a snapshot has been taken! And it's not feasible
> for filesystems to provision on demand before they modify metadata
> because we don't know what metadata is going to need to be modified
> before we start modifying metadata in transactions. If we get ENOSPC
> from provisioning in the middle of a dirty transcation, it's all
> over just the same as if we get ENOSPC during metadata writeback...
> 
> Hence what filesystems actually need is device provisioned space to
> be -always over-writable- without ENOSPC occurring.  Ideally, if we
> provision a range of the block device, the block device *must*
> guarantee all future writes to that LBA range succeeds. That
> guarantee needs to stand until we discard or unmap the LBA range,
> and for however many writes we do to that LBA range.
> 
> e.g. If the device takes a snapshot, it needs to reprovision the
> potential COW ranges that overlap with the provisioned LBA range at
> snapshot time. e.g. by re-reserving the space from the backing pool
> for the provisioned space so if a COW occurs there is space
> guaranteed for it to succeed.  If there isn't space in the backing
> pool for the reprovisioning, then whatever operation that triggers
> the COW behaviour should fail with ENOSPC before doing anything
> else....

Happy to implement this in dm-thinp.  Each thin block will need a bit
to say if the block must be REQ_PROVISION'd at time of snapshot (and
the resulting block will need the same bit set).

Walking all blocks of a thin device and triggering REQ_PROVISION for
each will obviously make thin snapshot creation take more time.

I think this approach is better than having a dedicated bitmap hooked
off each thin device's metadata (with bitmap being copied and walked
at the time of snapshot). But we'll see... I'll get with Joe to
discuss further.

> Software devices like dm-thin/snapshot should really only need to
> keep a persistent map of the provisioned space and refresh space
> reservations for used space within that map whenever something that
> triggers COW behaviour occurs. i.e. a snapshot needs to reset the
> provisioned ranges back to "all ranges are freshly provisioned"
> before the snapshot is started. If that space is not available in
> the backing pool, then the snapshot attempt gets ENOSPC....
> 
> That means filesystems only need to provision space for journals and
> fixed metadata at mkfs time, and they only need issue a
> REQ_PROVISION bio when they first allocate over-write in place
> metadata. We already have online discard and/or fstrim for releasing
> provisioned space via discards.
> 
> This will require some mods to filesystems like ext4 and XFS to
> issue REQ_PROVISION and fail gracefully during metadata allocation.
> However, doing so means that we can actually harden filesystems
> against sparse block device ENOSPC errors by ensuring they will
> never occur in critical filesystem structures....

Yes, let's finally _do_ this! ;)

Mike
