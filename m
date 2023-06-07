Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5E897251E4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jun 2023 04:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240611AbjFGCBk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jun 2023 22:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240551AbjFGCBf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jun 2023 22:01:35 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25ED410F2
        for <linux-fsdevel@vger.kernel.org>; Tue,  6 Jun 2023 19:01:33 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6b2993c9652so754226a34.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Jun 2023 19:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1686103291; x=1688695291;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=j5Cy8tBCL9F/0/npHcEhwYUjt7WcWHdplqXcZoUtV+0=;
        b=S38JhUY0rjGS8/ejnAM445GcScFR7303fsI7enooXy8aNW0507nQpNQhvO3u3E3lif
         e60ZRwPp5ITPRpOhi6O7xOnkHrs3vMFzOOaqIzEvAs2Hxy3fCcjCl5yPImkw1L/tuZO3
         rsgcvEWpJuoUxcbOGL9O4zkuhdrGp/WHrISPsZzNhhNFWYmFj9dsztrtXUgxqcFtpE8I
         uWGXHvcab1fBbvJZWotAME4Z6VIN2YnnSEjsxv5DF0P3PcXeicy02gd3DQWsYBdR4Y/A
         FroVS5zqewrJgH81ZL3YfdrvOWUJ98tTmrk04tCNxDyIpeJD1JKKXQvG1IPKG+PqFQPc
         8PpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686103291; x=1688695291;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j5Cy8tBCL9F/0/npHcEhwYUjt7WcWHdplqXcZoUtV+0=;
        b=PaecjVoACT7t206ENBVf6Dy58wbJqz6nCP6yNqJ8ulyDzh7VfLTNeuiJyroNwY4HN8
         STojvEk8VQ4eKhN+y/aLpr7/H4ADwQgo0l1ay/BYZnZqT0nubQkpLJFeGaTrgrHoCQYl
         n483ZYG3XZLga1BeqIqAXU/VStHqNxM3G+ojSW65kZ6+zFWa0KVgXDXFAS4m2LLXDCLt
         qHeqL8wPoM04fE7Lrot2N0RdAp+qLnJLVGGCkzKIsBPjTbP+OkebaaxwZgwg7kf2EK/J
         ZWjpOXk547Zt+QKPq46xNQoYxqeD1yO5IRTlygAhU0Ud3KJULAoumFQLpAZvYMAOtCXs
         weHg==
X-Gm-Message-State: AC+VfDxN9n//6aWW+Fjb5jjJ1CFN3/TvXakU6dTgKWITET19A5gOMHmn
        Yu8cBvFvl85xR2oIEF3AjCSJ+A==
X-Google-Smtp-Source: ACHHUZ5VYVq+3IAbaiVsgoydY4WCLUW/jBSbIonSM1lHWrf78Rur1YGuoiyya2F8GsBWigs9zYnexA==
X-Received: by 2002:a05:6358:c525:b0:123:4444:e5f8 with SMTP id fb37-20020a056358c52500b001234444e5f8mr141321rwb.18.1686103290958;
        Tue, 06 Jun 2023 19:01:30 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-79-151.pa.nsw.optusnet.com.au. [49.179.79.151])
        by smtp.gmail.com with ESMTPSA id q66-20020a17090a1b4800b002533ce5b261sm220132pjq.10.2023.06.06.19.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 19:01:29 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1q6iUI-008iUT-2e;
        Wed, 07 Jun 2023 12:01:26 +1000
Date:   Wed, 7 Jun 2023 12:01:26 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Mike Snitzer <snitzer@kernel.org>
Cc:     Sarthak Kukreti <sarthakkukreti@chromium.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Joe Thornber <thornber@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Brian Foster <bfoster@redhat.com>,
        Bart Van Assche <bvanassche@google.com>,
        linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>, dm-devel@redhat.com,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        linux-fsdevel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        linux-ext4@vger.kernel.org, Joe Thornber <ejt@redhat.com>,
        Alasdair Kergon <agk@redhat.com>
Subject: Re: [PATCH v7 0/5] Introduce provisioning primitives
Message-ID: <ZH/k9ss2Cg9HYrEV@dread.disaster.area>
References: <ZHB954zGG1ag0E/t@dread.disaster.area>
 <CAJ0trDbspRaDKzTzTjFdPHdB9n0Q9unfu1cEk8giTWoNu3jP8g@mail.gmail.com>
 <ZHFEfngPyUOqlthr@dread.disaster.area>
 <CAJ0trDZJQwvAzngZLBJ1hB0XkQ1HRHQOdNQNTw9nK-U5i-0bLA@mail.gmail.com>
 <ZHYB/6l5Wi+xwkbQ@redhat.com>
 <CAJ0trDaUOevfiEpXasOESrLHTCcr=oz28ywJU+s+YOiuh7iWow@mail.gmail.com>
 <ZHYWAGmKhwwmTjW/@redhat.com>
 <CAG9=OMMnDfN++-bJP3jLmUD6O=Q_ApV5Dr392_5GqsPAi_dDkg@mail.gmail.com>
 <ZHqOvq3ORETQB31m@dread.disaster.area>
 <ZHti/MLnX5xGw9b7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZHti/MLnX5xGw9b7@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 03, 2023 at 11:57:48AM -0400, Mike Snitzer wrote:
> On Fri, Jun 02 2023 at  8:52P -0400,
> Dave Chinner <david@fromorbit.com> wrote:
> 
> > On Fri, Jun 02, 2023 at 11:44:27AM -0700, Sarthak Kukreti wrote:
> > > On Tue, May 30, 2023 at 8:28 AM Mike Snitzer <snitzer@kernel.org> wrote:
> > > >
> > > > On Tue, May 30 2023 at 10:55P -0400,
> > > > Joe Thornber <thornber@redhat.com> wrote:
> > > >
> > > > > On Tue, May 30, 2023 at 3:02 PM Mike Snitzer <snitzer@kernel.org> wrote:
> > > > >
> > > > > >
> > > > > > Also Joe, for you proposed dm-thinp design where you distinquish
> > > > > > between "provision" and "reserve": Would it make sense for REQ_META
> > > > > > (e.g. all XFS metadata) with REQ_PROVISION to be treated as an
> > > > > > LBA-specific hard request?  Whereas REQ_PROVISION on its own provides
> > > > > > more freedom to just reserve the length of blocks? (e.g. for XFS
> > > > > > delalloc where LBA range is unknown, but dm-thinp can be asked to
> > > > > > reserve space to accomodate it).
> > > > > >
> > > > >
> > > > > My proposal only involves 'reserve'.  Provisioning will be done as part of
> > > > > the usual io path.
> > > >
> > > > OK, I think we'd do well to pin down the top-level block interfaces in
> > > > question. Because this patchset's block interface patch (2/5) header
> > > > says:
> > > >
> > > > "This patch also adds the capability to call fallocate() in mode 0
> > > > on block devices, which will send REQ_OP_PROVISION to the block
> > > > device for the specified range,"
> > > >
> > > > So it wires up blkdev_fallocate() to call blkdev_issue_provision(). A
> > > > user of XFS could then use fallocate() for user data -- which would
> > > > cause thinp's reserve to _not_ be used for critical metadata.
> > 
> > Mike, I think you might have misunderstood what I have been proposing.
> > Possibly unintentionally, I didn't call it REQ_OP_PROVISION but
> > that's what I intended - the operation does not contain data at all.
> > It's an operation like REQ_OP_DISCARD or REQ_OP_WRITE_ZEROS - it
> > contains a range of sectors that need to be provisioned (or
> > discarded), and nothing else.
> 
> No, I understood that.
> 
> > The write IOs themselves are not tagged with anything special at all.
> 
> I know, but I've been looking at how to also handle the delalloc
> usecase (and yes I know you feel it doesn't need handling, the issue
> is XFS does deal nicely with ensuring it has space when it tracks its
> allocations on "thick" storage

Oh, no it doesn't. It -works for most cases-, but that does not mean
it provides any guarantees at all. We can still get ENOSPC for user
data when delayed allocation reservations "run out".

This may be news to you, but the ephemeral XFS delayed allocation
space reservation is not accurate. It contains a "fudge factor"
called "indirect length". This is a "wet finger in the wind"
estimation of how much new metadata will need to be allocated to
index the physical allocations when they are made. It assumes large
data extents are allocated, which is good enough for most cases, but
it is no guarantee when there are no large data extents available to
allocate (e.g. near ENOSPC!).

And therein lies the fundamental problem with ephemeral range
reservations: at the time of reservation, we don't know how many
individual physical LBA ranges the reserved data range is actually
going to span.

As a result, XFS delalloc reservations are a "close-but-not-quite"
reservation backed by a global reserve pool that can be dipped into
if we run out of delalloc reservation. If the reserve pool is then
fully depleted before all delalloc conversion completes, we'll still
give ENOSPC. The pool is sized such that the vast majority of
workloads will complete delalloc conversion successfully before the
pool is depleted.

Hence XFS gives everyone the -appearance- that it deals nicely with
ENOSPC conditions, but it never provides a -guarantee- that any
accepted write will always succeed without ENOSPC.

IMO, using this "close-but-not-quite" reservation as the basis of
space requirements for other layers to provide "won't ENOSPC"
guarantees is fraught with problems. We already know that it is
insufficient in important corner cases at the filesystem level, and
we also know that lower layers trying to do ephemeral space
reservations will have exactly the same problems providing a
guarantee. And these are problems we've been unable to engineer
around in the past, so the likelihood we can engineer around them
now or in the future is also very unlikely.

> -- so adding coordination between XFS
> and dm-thin layers provides comparable safety.. that safety is an
> expected norm).
>
> But rather than discuss in terms of data vs metadata, the distinction
> is:
> 1) LBA range reservation (normal case, your proposal)
> 2) non-LBA reservation (absolute value, LBA range is known at later stage)
> 
> But I'm clearly going off script for dwelling on wanting to handle
> both.

Right, because if we do 1) then we don't need 2). :)

> My looking at (ab)using REQ_META being set (use 1) vs not (use 2) was
> a crude simplification for branching between the 2 approaches.
> 
> And I understand I made you nervous by expanding the scope to a much
> more muddled/shitty interface. ;)

Nervous? No, I'm simply trying to make sure that everyone is on the
same page. i.e. that if we water down the guarantee that 1) relies
on, then it's not actually useful to filesystems at all.

> > It's just not practical for the block device to add arbitrary
> > constraints based on the type of IO because we then have to add
> > mechanisms to userspace APIs to allow them to control the IO context
> > so the block device will do the right thing. Especially considering
> > we really only need one type of guarantee regardless of where the IO
> > originates from or what type of data the IO contains....
> 
> If anything my disposition on the conditional to require a REQ_META
> (or some fallocate generated REQ_UNSHARE ditto to reflect the same) to
> perform your approach to REQ_OP_PROVISION and honor fallocate()
> requirements is a big problem.  Would be much better to have a flag to
> express "this reservation does not have an LBA range _yet_,
> nevertheless try to be mindful of this expected near-term block
> allocation".

And that's where all the complexity starts ;)

> > Put simply: if we restrict REQ_OP_PROVISION guarantees to just
> > REQ_META writes (or any other specific type of write operation) then
> > it's simply not worth persuing at the filesystem level because the
> > guarantees we actually need just aren't there and the complexity of
> > discovering and handling those corner cases just isn't worth the
> > effort.
> 
> Here is where I get to say: I think you misunderstood me (but it was
> my fault for not being absolutely clear: I'm very much on the same
> page as you and Joe; and your visions need to just be implemented
> ASAP).

OK, good that we've clarified the misunderstandings on both sides
quickly :)

> I was taking your designs as a given, but looking further at: how do
> we also handle the non-LBA (delalloc) usecase _before_ we include
> REQ_OP_PROVISION in kernel.
> 
> But I'm happy to let the delalloc case go (we can revisit addressing
> it if/when needed).

Again, I really don't think filesystem delalloc ranges ever need to
be covered by block device provisioning guarantees because the
filesystem itself provides no guarantees for unprovisioned writes.

I suspect that if, in future, we want to manage unprovisioned space
in different ways, we're better off taking this sort of approach:

https://lore.kernel.org/linux-xfs/20171026083322.20428-1-david@fromorbit.com/

because using grow/shrink to manage the filesystem's unprovisioned
space if far, far simpler than trying to use dynamic, cross layer
ephemeral reservations.  Indeed, with the block device filesystem
shutdown path Christoph recently posted, we have a model for adding
in-kernel filesystem control interfaces for block devices...

There's something to be said for turning everything upside down
occasionally. :)

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
