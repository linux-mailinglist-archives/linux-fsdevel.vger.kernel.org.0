Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6FA370A328
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 May 2023 01:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbjESXHy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 May 2023 19:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjESXHx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 May 2023 19:07:53 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B56191B3
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 May 2023 16:07:50 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-64d2467d640so2572833b3a.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 May 2023 16:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1684537670; x=1687129670;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vej0HUXiqshmcvqs7VBZTGkCXU+JddJuVreKpbmYuhw=;
        b=M7M+fUzZKYFhCed62ckEM75i49Kzi0Sy+mNCDiHsZpcNM/HQImrznTrkS4Wi9NL1Qt
         OpBue7B/lTyS4Ky8m0UYNNuyU32olEvqU9kMDgIsurTQS74yymOzmc8h+RSkAmjSqxOP
         woaJGiEwnE03YgfMS1q3jv3TV55P4eda89l5rEF9YibVhRMXrAoasmZaFgYrpCbUd+oE
         XkNqBx9FFYqUpTZUSUyJJeWE0IiZORfli0QtnpbJ5rpT7PGgf7LZiQ+NCEMRM7WFfN1T
         vkwBHodfbKEBqQNapAiloS/SU1gESn6ZDbM8KRw093WyP1wcSNUWGyK7A0I+ybuXSTVQ
         2JuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684537670; x=1687129670;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vej0HUXiqshmcvqs7VBZTGkCXU+JddJuVreKpbmYuhw=;
        b=JLCIkrxOgcmYbdJB+q2GJCmQWFW18gtc+aryuB14mRGuTne/mA40reVjIhEnKrT44T
         vVAE4sCxSkJJ+dXfB4L5BmLVe7rZrD/pw7I2R/ad+5Gx0yPBsV4yw3dxeiHisi2o8BGO
         J9ZA1advV58D5o999FsM9c4RygH+j64xCHUafgUSZRsESTzstKqHrUK2V5oGTbzkvqDS
         MjtSB+45pDas6++ZFfp5ag1cUrCnZG18O8vNs+HPtTzTpfTgDBf0h97DFdSzSCG4kPJg
         lD8SKUm67PtEZuMBoSvCRIWSaD0bY/GiHMB1IpPHHR9XXS4Dmm/qi5q/ery9ROpAmMeI
         SeZw==
X-Gm-Message-State: AC+VfDxPtKjLagU8sq2zfhq6IAgeal7As+GMYkRR+h1mPWsTByNnqVAE
        /65TvCWhtva6MjiRKdZa0q+rhQ==
X-Google-Smtp-Source: ACHHUZ44Ml1ojpiPU8i/+mCvFac8UKDWss2kgW+R+G0QKFHgCdmutJq5p5DRKhkFYnyqqBTN1Dtx1w==
X-Received: by 2002:a05:6a00:1896:b0:63b:854c:e0f6 with SMTP id x22-20020a056a00189600b0063b854ce0f6mr5344668pfh.21.1684537670148;
        Fri, 19 May 2023 16:07:50 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-0-188.pa.nsw.optusnet.com.au. [49.179.0.188])
        by smtp.gmail.com with ESMTPSA id i6-20020aa78d86000000b006414289ab69sm204704pfr.52.2023.05.19.16.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 16:07:49 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1q09CM-001WVR-2G;
        Sat, 20 May 2023 09:07:46 +1000
Date:   Sat, 20 May 2023 09:07:46 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Mike Snitzer <snitzer@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Sarthak Kukreti <sarthakkukreti@chromium.org>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Alasdair Kergon <agk@redhat.com>,
        Brian Foster <bfoster@redhat.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Bart Van Assche <bvanassche@google.com>,
        "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH v7 0/5] Introduce provisioning primitives
Message-ID: <ZGgBQhsbU9b0RiT1@dread.disaster.area>
References: <20230518223326.18744-1-sarthakkukreti@chromium.org>
 <ZGb2Xi6O3i2pLam8@infradead.org>
 <ZGeKm+jcBxzkMXQs@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGeKm+jcBxzkMXQs@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 19, 2023 at 10:41:31AM -0400, Mike Snitzer wrote:
> On Fri, May 19 2023 at 12:09P -0400,
> Christoph Hellwig <hch@infradead.org> wrote:
> 
> > FYI, I really don't think this primitive is a good idea.  In the
> > concept of non-overwritable storage (NAND, SMR drives) the entire
> > concept of a one-shoot 'provisioning' that will guarantee later writes
> > are always possible is simply bogus.
> 
> Valid point for sure, such storage shouldn't advertise support (and
> will return -EOPNOTSUPP).
> 
> But the primitive still has utility for other classes of storage.

Yet the thing people are wanting to us filesystem developers to use
this with is thinly provisioned storage that has snapshot
capability. That, by definition, is non-overwritable storage. These
are the use cases people are asking filesystes to gracefully handle
and report errors when the sparse backing store runs out of space.

e.g. journal writes after a snapshot is taken on a busy filesystem
are always an overwrite and this requires more space in the storage
device for the write to succeed. ENOSPC from the backing device for
journal IO is a -fatal error-. Hence if REQ_PROVISION doesn't
guarantee space for overwrites after snapshots, then it's not
actually useful for solving the real world use cases we actually
need device-level provisioning to solve.

It is not viable for filesystems to have to reprovision space for
in-place metadata overwrites after every snapshot - the filesystem
may not even know a snapshot has been taken! And it's not feasible
for filesystems to provision on demand before they modify metadata
because we don't know what metadata is going to need to be modified
before we start modifying metadata in transactions. If we get ENOSPC
from provisioning in the middle of a dirty transcation, it's all
over just the same as if we get ENOSPC during metadata writeback...

Hence what filesystems actually need is device provisioned space to
be -always over-writable- without ENOSPC occurring.  Ideally, if we
provision a range of the block device, the block device *must*
guarantee all future writes to that LBA range succeeds. That
guarantee needs to stand until we discard or unmap the LBA range,
and for however many writes we do to that LBA range.

e.g. If the device takes a snapshot, it needs to reprovision the
potential COW ranges that overlap with the provisioned LBA range at
snapshot time. e.g. by re-reserving the space from the backing pool
for the provisioned space so if a COW occurs there is space
guaranteed for it to succeed.  If there isn't space in the backing
pool for the reprovisioning, then whatever operation that triggers
the COW behaviour should fail with ENOSPC before doing anything
else....

Software devices like dm-thin/snapshot should really only need to
keep a persistent map of the provisioned space and refresh space
reservations for used space within that map whenever something that
triggers COW behaviour occurs. i.e. a snapshot needs to reset the
provisioned ranges back to "all ranges are freshly provisioned"
before the snapshot is started. If that space is not available in
the backing pool, then the snapshot attempt gets ENOSPC....

That means filesystems only need to provision space for journals and
fixed metadata at mkfs time, and they only need issue a
REQ_PROVISION bio when they first allocate over-write in place
metadata. We already have online discard and/or fstrim for releasing
provisioned space via discards.

This will require some mods to filesystems like ext4 and XFS to
issue REQ_PROVISION and fail gracefully during metadata allocation.
However, doing so means that we can actually harden filesystems
against sparse block device ENOSPC errors by ensuring they will
never occur in critical filesystem structures....

-Dave.
-- 
Dave Chinner
david@fromorbit.com
