Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D902B727355
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jun 2023 01:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233367AbjFGXvV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jun 2023 19:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233061AbjFGXvT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jun 2023 19:51:19 -0400
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 648712694
        for <linux-fsdevel@vger.kernel.org>; Wed,  7 Jun 2023 16:50:28 -0700 (PDT)
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-75ec7e8e826so15185a.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Jun 2023 16:50:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686181827; x=1688773827;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mhikzEBmpROllrpUkG6N5rn5swH/R/MkyomEPj+0LRU=;
        b=hsMEZEZzS7jtcTaXqwSrjgmukYXHgmtUQjKJKRKx1sWIGqtMXglOGZTveapQwikD8/
         auKIjAkIUxgFEdwB++ar0+T7IH9+g2EAn0Y+UCWAffjy0Ed3qI9ej6IX5W0eRVFCD/hq
         TXE2KOzD7/7bKuI/AgvxAjkfPimfYQbETfT+glGWomduevfHYcKKh5hDnR0CwAe9dCea
         UvQvY3FQMHgIr/jZQhOo3BxKkSiZjdGR/VtI9Fy+fdIQUgtB2jATtSDTCntvldaBTmUy
         4ceZYGMaRRmMBNogafS0w/vj8lq8EfTbiztfm1kCm2Ta6QHqsRpOB8ZO5+IbJQB8Wa1X
         jYDQ==
X-Gm-Message-State: AC+VfDyieL5gNzr3M/agl1egdh9/FTH/o5rLTKnGQq2zChIwl//EEnWM
        D9XkpmhZfq/y67UzOTICjLWy
X-Google-Smtp-Source: ACHHUZ6y+cOL+ZxgisiLenJjAOucQc9Wtuow/WkgwMRhUI55SkTWbqnmzTclMfUHnNVFzRSWwX/5Nw==
X-Received: by 2002:a05:620a:2b4b:b0:75b:23a1:3651 with SMTP id dp11-20020a05620a2b4b00b0075b23a13651mr4139465qkb.18.1686181827499;
        Wed, 07 Jun 2023 16:50:27 -0700 (PDT)
Received: from localhost (pool-68-160-166-30.bstnma.fios.verizon.net. [68.160.166.30])
        by smtp.gmail.com with ESMTPSA id x12-20020ae9f80c000000b0075ca4cd03d4sm245229qkh.64.2023.06.07.16.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 16:50:27 -0700 (PDT)
Date:   Wed, 7 Jun 2023 19:50:25 -0400
From:   Mike Snitzer <snitzer@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Joe Thornber <thornber@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Jason Wang <jasowang@redhat.com>,
        Bart Van Assche <bvanassche@google.com>,
        linux-kernel@vger.kernel.org, Joe Thornber <ejt@redhat.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Sarthak Kukreti <sarthakkukreti@chromium.org>,
        linux-fsdevel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        linux-ext4@vger.kernel.org, Brian Foster <bfoster@redhat.com>,
        Alasdair Kergon <agk@redhat.com>
Subject: Re: [PATCH v7 0/5] Introduce provisioning primitives
Message-ID: <ZIEXwTd17z0iYW4s@redhat.com>
References: <CAJ0trDbspRaDKzTzTjFdPHdB9n0Q9unfu1cEk8giTWoNu3jP8g@mail.gmail.com>
 <ZHFEfngPyUOqlthr@dread.disaster.area>
 <CAJ0trDZJQwvAzngZLBJ1hB0XkQ1HRHQOdNQNTw9nK-U5i-0bLA@mail.gmail.com>
 <ZHYB/6l5Wi+xwkbQ@redhat.com>
 <CAJ0trDaUOevfiEpXasOESrLHTCcr=oz28ywJU+s+YOiuh7iWow@mail.gmail.com>
 <ZHYWAGmKhwwmTjW/@redhat.com>
 <CAG9=OMMnDfN++-bJP3jLmUD6O=Q_ApV5Dr392_5GqsPAi_dDkg@mail.gmail.com>
 <ZHqOvq3ORETQB31m@dread.disaster.area>
 <ZHti/MLnX5xGw9b7@redhat.com>
 <ZH/k9ss2Cg9HYrEV@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZH/k9ss2Cg9HYrEV@dread.disaster.area>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 06 2023 at 10:01P -0400,
Dave Chinner <david@fromorbit.com> wrote:

> On Sat, Jun 03, 2023 at 11:57:48AM -0400, Mike Snitzer wrote:
> > On Fri, Jun 02 2023 at  8:52P -0400,
> > Dave Chinner <david@fromorbit.com> wrote:
> > 
> > > Mike, I think you might have misunderstood what I have been proposing.
> > > Possibly unintentionally, I didn't call it REQ_OP_PROVISION but
> > > that's what I intended - the operation does not contain data at all.
> > > It's an operation like REQ_OP_DISCARD or REQ_OP_WRITE_ZEROS - it
> > > contains a range of sectors that need to be provisioned (or
> > > discarded), and nothing else.
> > 
> > No, I understood that.
> > 
> > > The write IOs themselves are not tagged with anything special at all.
> > 
> > I know, but I've been looking at how to also handle the delalloc
> > usecase (and yes I know you feel it doesn't need handling, the issue
> > is XFS does deal nicely with ensuring it has space when it tracks its
> > allocations on "thick" storage
> 
> Oh, no it doesn't. It -works for most cases-, but that does not mean
> it provides any guarantees at all. We can still get ENOSPC for user
> data when delayed allocation reservations "run out".
> 
> This may be news to you, but the ephemeral XFS delayed allocation
> space reservation is not accurate. It contains a "fudge factor"
> called "indirect length". This is a "wet finger in the wind"
> estimation of how much new metadata will need to be allocated to
> index the physical allocations when they are made. It assumes large
> data extents are allocated, which is good enough for most cases, but
> it is no guarantee when there are no large data extents available to
> allocate (e.g. near ENOSPC!).
> 
> And therein lies the fundamental problem with ephemeral range
> reservations: at the time of reservation, we don't know how many
> individual physical LBA ranges the reserved data range is actually
> going to span.
> 
> As a result, XFS delalloc reservations are a "close-but-not-quite"
> reservation backed by a global reserve pool that can be dipped into
> if we run out of delalloc reservation. If the reserve pool is then
> fully depleted before all delalloc conversion completes, we'll still
> give ENOSPC. The pool is sized such that the vast majority of
> workloads will complete delalloc conversion successfully before the
> pool is depleted.
> 
> Hence XFS gives everyone the -appearance- that it deals nicely with
> ENOSPC conditions, but it never provides a -guarantee- that any
> accepted write will always succeed without ENOSPC.
> 
> IMO, using this "close-but-not-quite" reservation as the basis of
> space requirements for other layers to provide "won't ENOSPC"
> guarantees is fraught with problems. We already know that it is
> insufficient in important corner cases at the filesystem level, and
> we also know that lower layers trying to do ephemeral space
> reservations will have exactly the same problems providing a
> guarantee. And these are problems we've been unable to engineer
> around in the past, so the likelihood we can engineer around them
> now or in the future is also very unlikely.

Thanks for clarifying. Wasn't aware of XFS delalloc's "wet finger in
the air" ;)

So do you think it reasonable to require applications to fallocate
their data files? Unaware if users are aware to take that extra step.

> > -- so adding coordination between XFS
> > and dm-thin layers provides comparable safety.. that safety is an
> > expected norm).
> >
> > But rather than discuss in terms of data vs metadata, the distinction
> > is:
> > 1) LBA range reservation (normal case, your proposal)
> > 2) non-LBA reservation (absolute value, LBA range is known at later stage)
> > 
> > But I'm clearly going off script for dwelling on wanting to handle
> > both.
> 
> Right, because if we do 1) then we don't need 2). :)

Sure.

> > My looking at (ab)using REQ_META being set (use 1) vs not (use 2) was
> > a crude simplification for branching between the 2 approaches.
> > 
> > And I understand I made you nervous by expanding the scope to a much
> > more muddled/shitty interface. ;)
> 
> Nervous? No, I'm simply trying to make sure that everyone is on the
> same page. i.e. that if we water down the guarantee that 1) relies
> on, then it's not actually useful to filesystems at all.

Yeah, makes sense.
 
> > > Put simply: if we restrict REQ_OP_PROVISION guarantees to just
> > > REQ_META writes (or any other specific type of write operation) then
> > > it's simply not worth persuing at the filesystem level because the
> > > guarantees we actually need just aren't there and the complexity of
> > > discovering and handling those corner cases just isn't worth the
> > > effort.
> > 
> > Here is where I get to say: I think you misunderstood me (but it was
> > my fault for not being absolutely clear: I'm very much on the same
> > page as you and Joe; and your visions need to just be implemented
> > ASAP).
> 
> OK, good that we've clarified the misunderstandings on both sides
> quickly :)

Do you think you're OK to scope out, and/or implement, the XFS changes
if you use v7 of this patchset as the starting point? (v8 should just
be v7 minus the dm-thin.c and dm-snap.c changes).  The thinp
support in v7 will work enough to allow XFS to issue REQ_OP_PROVISION
and/or fallocate (via mkfs.xfs) to dm-thin devices.

And Joe and I can make independent progress on the dm-thin.c changes
needed to ensure the REQ_OP_PROVISION gaurantee you need.

Thanks,
Mike
