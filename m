Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44CC97272F3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jun 2023 01:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233153AbjFGX2Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jun 2023 19:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjFGX2O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jun 2023 19:28:14 -0400
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 335E72129
        for <linux-fsdevel@vger.kernel.org>; Wed,  7 Jun 2023 16:27:27 -0700 (PDT)
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-3f7a546efb1so7611cf.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Jun 2023 16:27:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686180446; x=1688772446;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=voj5Mda8Zfoqf83eL6TpEP6bEfS34qzT4ho4GEckRy8=;
        b=OrBcr9Wtko8Tl4DoIL1i73yGgf0ACQEw425hK0Q58ukYdoqMhFNddiCtZehqDFA0Te
         58i+P2KO9RTM+B8WHyoai3v8gOqR/beKOg54GHpyoOn8PgacgOEnbEorARZTF4tVjur/
         a4Aqb3V6dD9kesiGMYIioX5PBuG+Do3JHajo/dz+RYkJPnTf6tulpIOTKLZl0s3mAALo
         GJIPk9UeZ7rhMgCggW6qgI6/RN2dvUOv6cw2t3H49JPQWSktjVGphTr1gRZl/zMjolNn
         bUOzOQt/Va6v7uWkrlAHK1yPmaGgi0hIby/z6y4F62z72jRV0dJUxsiHB5OsrANA6iLp
         q8sA==
X-Gm-Message-State: AC+VfDxbNZT0fnKVK0ZMsDfWxZiFtIE5UekDAL9rUM4uzLXdE7m62tK9
        IhBs+epPn8/7XAsICyBYDNaK
X-Google-Smtp-Source: ACHHUZ6bssYu3BmODSfk7D3JoJ9AovgnvY3uNrvFLLvCnNUVf2dqD8Ue69PPoyqRe4HMmDod3/Cmnw==
X-Received: by 2002:ac8:5c16:0:b0:3d8:2352:a661 with SMTP id i22-20020ac85c16000000b003d82352a661mr6003241qti.3.1686180446161;
        Wed, 07 Jun 2023 16:27:26 -0700 (PDT)
Received: from localhost (pool-68-160-166-30.bstnma.fios.verizon.net. [68.160.166.30])
        by smtp.gmail.com with ESMTPSA id i9-20020ac84f49000000b003f018e18c35sm286121qtw.27.2023.06.07.16.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 16:27:25 -0700 (PDT)
Date:   Wed, 7 Jun 2023 19:27:24 -0400
From:   Mike Snitzer <snitzer@kernel.org>
To:     Sarthak Kukreti <sarthakkukreti@chromium.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Joe Thornber <thornber@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Jason Wang <jasowang@redhat.com>,
        Bart Van Assche <bvanassche@google.com>,
        Dave Chinner <david@fromorbit.com>,
        linux-kernel@vger.kernel.org, Joe Thornber <ejt@redhat.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        linux-fsdevel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        linux-ext4@vger.kernel.org, Brian Foster <bfoster@redhat.com>,
        Alasdair Kergon <agk@redhat.com>
Subject: Re: [PATCH v7 0/5] Introduce provisioning primitives
Message-ID: <ZIESXNF5anyvJEjm@redhat.com>
References: <CAJ0trDbspRaDKzTzTjFdPHdB9n0Q9unfu1cEk8giTWoNu3jP8g@mail.gmail.com>
 <ZHFEfngPyUOqlthr@dread.disaster.area>
 <CAJ0trDZJQwvAzngZLBJ1hB0XkQ1HRHQOdNQNTw9nK-U5i-0bLA@mail.gmail.com>
 <ZHYB/6l5Wi+xwkbQ@redhat.com>
 <CAJ0trDaUOevfiEpXasOESrLHTCcr=oz28ywJU+s+YOiuh7iWow@mail.gmail.com>
 <ZHYWAGmKhwwmTjW/@redhat.com>
 <CAG9=OMMnDfN++-bJP3jLmUD6O=Q_ApV5Dr392_5GqsPAi_dDkg@mail.gmail.com>
 <ZHqOvq3ORETQB31m@dread.disaster.area>
 <ZHti/MLnX5xGw9b7@redhat.com>
 <CAG9=OMNv80fOyVixEY01XESnOFzYyfj9j8etHMq_Ap52z4UWNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG9=OMNv80fOyVixEY01XESnOFzYyfj9j8etHMq_Ap52z4UWNQ@mail.gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 05 2023 at  5:14P -0400,
Sarthak Kukreti <sarthakkukreti@chromium.org> wrote:

> On Sat, Jun 3, 2023 at 8:57 AM Mike Snitzer <snitzer@kernel.org> wrote:
> >
> > We all just need to focus on your proposal and Joe's dm-thin
> > reservation design...
> >
> > [Sarthak: FYI, this implies that it doesn't really make sense to add
> > dm-thinp support before Joe's design is implemented.  Otherwise we'll
> > have 2 different responses to REQ_OP_PROVISION.  The one that is
> > captured in your patchset isn't adequate to properly handle ensuring
> > upper layer (like XFS) can depend on the space being available across
> > snapshot boundaries.]
> >
> Ack. Would it be premature for the rest of the series to go through
> (REQ_OP_PROVISION + support for loop and non-dm-thinp device-mapper
> targets)? I'd like to start using this as a reference to suggest
> additions to the virtio-spec for virtio-blk support and start looking
> at what an ext4 implementation would look like.

Please drop the dm-thin.c and dm-snap.c changes.  dm-snap.c would need
more work to provide the type of guarantee XFS requires across
snapshot boundaries. I'm inclined to _not_ add dm-snap.c support
because it is best to just use dm-thin.

And FYI even your dm-thin patch will be the starting point for the
dm-thin support (we'll keep attribution to you for all the code in a
separate patch).

> Fair points, I certainly don't want to derail this conversation; I'd
> be happy to see this work merged sooner rather than later.

Once those dm target changes are dropped I think the rest of the
series is fine to go upstream now.  Feel free to post a v8.

> For posterity, I'll distill what I said above into the following: I'd like
> a capability for userspace to create thin snapshots that ignore the
> thin volume's provisioned areas. IOW, an opt-in flag which makes
> snapshots fallback to what they do today to provide flexibility to
> userspace to decide the space requirements for the above mentioned
> scenarios, and at the same time, not adding separate corner case
> handling for filesystems. But to reiterate, my intent isn't to pile
> this onto the work you, Mike and Joe have planned; just some insight
> into why I'm in favor of ideas that reduce the snapshot size.

I think it'd be useful to ignore a thin device's reservation for
read-only snapshots.  Adding the ability to create read-only thin
snapshots could make sense (later activations don't necessarily need
to impose read-only, doing so would require some additional work).

Mike
