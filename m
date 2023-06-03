Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCE7A720CAE
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Jun 2023 02:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236936AbjFCAwY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Jun 2023 20:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjFCAwX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Jun 2023 20:52:23 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68F3E50
        for <linux-fsdevel@vger.kernel.org>; Fri,  2 Jun 2023 17:52:20 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-33d22754450so10007185ab.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Jun 2023 17:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1685753540; x=1688345540;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=47yKag1HPVe1tlg/ueV2EmabxwqalA0eGEjj+7JE1uc=;
        b=UWIvN/qvXfrWqOcG4gb6e/SydmD4XyYL0b/3cLXe1b9WDm329KgaO9cKycjRwD473K
         5TCOPQ/yMBhVqGwhNuU7qPsLBldyyFhIutUweZTyGlDXuPLfeV4ghxFgVoVMaznaJQqL
         lso2N/YgqQcS9WlXHd0+ykyR+ZNQ4k4Tnd4MLYPidVNLRQPJoOkakl0onc1j45sA3wL4
         OtVhA8x2Mh5PRgihy8gl+v/XxfHMWX0aOgW/R1aK1HFXbY4CqVcJFxRSMQxSzI0rGq+P
         xomIjZ7uHiOrIMIyetSUiwCh+tuhcZGtJwu5tFtMYT0gq/oKTpAfK3FSlbqpzuV0E7P7
         oLkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685753540; x=1688345540;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=47yKag1HPVe1tlg/ueV2EmabxwqalA0eGEjj+7JE1uc=;
        b=TDJxKJn6COfBV9X0g4cypQFsTFZD2zJl/fSVkG8B0xAdGAu7Xg863F/BWR0zVVbnIV
         m6CLbeYUqpas6rl+XB2iJCPK8kJVC0w28G94r6ahcjvRhVFSohMFQifVqb/Jr0Mx+f74
         NtdPQyqHu60o19SJ4vo9hqgL6C0JeSBRXx+hCnJJozEcNBrHc/C5rBthySRT3QA7tpa2
         zvjEgyHOiW/iMLPe5aY8o9nXBV8+CsbvXtk8B7KNSzFw/2+0sDcQAx8ISNBZkGG7SFV3
         0c+X7D73PD5+UAQsYv1cDNF6R1RDrbNEjUw/oUegVC6YLr+76w0gGudU6R96rwfUq3MJ
         nMvQ==
X-Gm-Message-State: AC+VfDxXAk5pX+bJ2K8HuAZmR4UwSZgLQlEY5JSjPGRAuxii9f0WQIWK
        wNaoDxbGyPRGvnZ2dBzFSKXsPA==
X-Google-Smtp-Source: ACHHUZ7rYnVeBADFLLMphNs56bdK1ktmP0TPdfjl/WkThM+AmFAZAPwTara48yQiFHumZBSIA05t5w==
X-Received: by 2002:a05:6e02:810:b0:338:c685:83d1 with SMTP id u16-20020a056e02081000b00338c68583d1mr10978918ilm.10.1685753539952;
        Fri, 02 Jun 2023 17:52:19 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-0-188.pa.nsw.optusnet.com.au. [49.179.0.188])
        by smtp.gmail.com with ESMTPSA id u6-20020a634706000000b0053b8a4f9465sm1788619pga.45.2023.06.02.17.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 17:52:18 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1q5FV8-0076kT-2D;
        Sat, 03 Jun 2023 10:52:14 +1000
Date:   Sat, 3 Jun 2023 10:52:14 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Sarthak Kukreti <sarthakkukreti@chromium.org>
Cc:     Mike Snitzer <snitzer@kernel.org>,
        Joe Thornber <thornber@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>, dm-devel@redhat.com,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Brian Foster <bfoster@redhat.com>,
        Bart Van Assche <bvanassche@google.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Joe Thornber <ejt@redhat.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Jason Wang <jasowang@redhat.com>,
        Alasdair Kergon <agk@redhat.com>
Subject: Re: [PATCH v7 0/5] Introduce provisioning primitives
Message-ID: <ZHqOvq3ORETQB31m@dread.disaster.area>
References: <ZG1dAtHmbQ53aOhA@dread.disaster.area>
 <ZG+KoxDMeyogq4J0@bfoster>
 <ZHB954zGG1ag0E/t@dread.disaster.area>
 <CAJ0trDbspRaDKzTzTjFdPHdB9n0Q9unfu1cEk8giTWoNu3jP8g@mail.gmail.com>
 <ZHFEfngPyUOqlthr@dread.disaster.area>
 <CAJ0trDZJQwvAzngZLBJ1hB0XkQ1HRHQOdNQNTw9nK-U5i-0bLA@mail.gmail.com>
 <ZHYB/6l5Wi+xwkbQ@redhat.com>
 <CAJ0trDaUOevfiEpXasOESrLHTCcr=oz28ywJU+s+YOiuh7iWow@mail.gmail.com>
 <ZHYWAGmKhwwmTjW/@redhat.com>
 <CAG9=OMMnDfN++-bJP3jLmUD6O=Q_ApV5Dr392_5GqsPAi_dDkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG9=OMMnDfN++-bJP3jLmUD6O=Q_ApV5Dr392_5GqsPAi_dDkg@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 02, 2023 at 11:44:27AM -0700, Sarthak Kukreti wrote:
> On Tue, May 30, 2023 at 8:28 AM Mike Snitzer <snitzer@kernel.org> wrote:
> >
> > On Tue, May 30 2023 at 10:55P -0400,
> > Joe Thornber <thornber@redhat.com> wrote:
> >
> > > On Tue, May 30, 2023 at 3:02 PM Mike Snitzer <snitzer@kernel.org> wrote:
> > >
> > > >
> > > > Also Joe, for you proposed dm-thinp design where you distinquish
> > > > between "provision" and "reserve": Would it make sense for REQ_META
> > > > (e.g. all XFS metadata) with REQ_PROVISION to be treated as an
> > > > LBA-specific hard request?  Whereas REQ_PROVISION on its own provides
> > > > more freedom to just reserve the length of blocks? (e.g. for XFS
> > > > delalloc where LBA range is unknown, but dm-thinp can be asked to
> > > > reserve space to accomodate it).
> > > >
> > >
> > > My proposal only involves 'reserve'.  Provisioning will be done as part of
> > > the usual io path.
> >
> > OK, I think we'd do well to pin down the top-level block interfaces in
> > question. Because this patchset's block interface patch (2/5) header
> > says:
> >
> > "This patch also adds the capability to call fallocate() in mode 0
> > on block devices, which will send REQ_OP_PROVISION to the block
> > device for the specified range,"
> >
> > So it wires up blkdev_fallocate() to call blkdev_issue_provision(). A
> > user of XFS could then use fallocate() for user data -- which would
> > cause thinp's reserve to _not_ be used for critical metadata.

Mike, I think you might have misunderstood what I have been proposing.
Possibly unintentionally, I didn't call it REQ_OP_PROVISION but
that's what I intended - the operation does not contain data at all.
It's an operation like REQ_OP_DISCARD or REQ_OP_WRITE_ZEROS - it
contains a range of sectors that need to be provisioned (or
discarded), and nothing else. The write IOs themselves are not
tagged with anything special at all.

i.e. The proposal I made does not use REQ_PROVISION anywhere in the
metadata/data IO path; provisioned regions are created by separate
operations and must be tracked by the underlying block device, then
treat any write IO to those regions as "must not fail w/ ENOSPC"
IOs.

There seems to be a lot of fear about user data requiring
provisioning. This is unfounded - provisioning is only needed for
explicitly provisioned space via fallocate(), not every byte of
user data written to the filesystem (the model Brian is proposing).

Excessive use of fallocate() is self correcting - if users and/or
their applications provision too much, they are going to get ENOSPC
or have to pay more to expand the backing pool reserves they need.
But that's not a problem the block device should be trying to solve;
that's a problem for the sysadmin and/or bean counters to address.

> >
> > The only way to distinquish the caller (between on-behalf of user data
> > vs XFS metadata) would be REQ_META?
> >
> > So should dm-thinp have a REQ_META-based distinction? Or just treat
> > all REQ_OP_PROVISION the same?
> >
> I'm in favor of a REQ_META-based distinction.

Why? What *requirement* is driving the need for this distinction?

As the person who proposed this new REQ_OP_PROVISION architecture,
I'm dead set against it.  Allowing the block device provide a set of
poorly defined "conditional guarantees" policies instead of a
mechanism with a single ironclad guarantee defeats the entire
purpose of the proposal. 

We have a requirement from the *kernel ABI* that *user data writes*
must not fail with ENOSPC after an fallocate() operation.  That's
one of the high level policies we need to implement. The filesystem
is already capable of guaranteeing it won't give the user ENOSPC
after fallocate, we now need a guarantee from the filesystem's
backing store that it won't give ENOSPC, too.

The _other thing_ we need to implement is a method of guaranteeing
the filesystem won't shut down when the backing device goes ENOSPC
unexpected during metadata writeback.  So we also need the backing
device to guarantee the regions we write metadata to won't give
ENOSPC.

That's the whole point of REQ_OP_PROVISION: from the layers above
the block device, there is -zero- difference between the guarantee
we need for user data writes to avoid ENOSPC and for metadata writes
to avoid ENOSPC. They are one and the same.

Hence if the block device is going to say "I support provisioning"
but then give different conditional guarantees according to the
*type of data* in the IO request, then it does not provide the
functionality the higher layers actually require from it.

Indeed, what type of data the IO contains is *context dependent*.
For example, sometimes we write metadata with user data IO and but
we still need provisioning guarantees as if it was issued as
metadata IO. This is the case for mkfs initialising the file system
by writing directly to the block device.

IOWs, filesystem metadata IO issued from kernel context would be
considered metadata IO, but from userspace it would be considered
normal user data IO and hence treated differently. But the reality
is that they both need the same provisioning guarantees to be
provided by the block device.

So how do userspace tools deal with this if the block device
requires REQ_META on user data IOs to do the right thing here? And
if we provide a mechanism to allow this, how do we prevent userspace
for always using it on writes to fallocate() provisioned space?

It's just not practical for the block device to add arbitrary
constraints based on the type of IO because we then have to add
mechanisms to userspace APIs to allow them to control the IO context
so the block device will do the right thing. Especially considering
we really only need one type of guarantee regardless of where the IO
originates from or what type of data the IO contains....

> Does that imply that
> REQ_META also needs to be passed through the block/filesystem stack
> (eg. REQ_OP_PROVION + REQ_META on a loop device translates to a
> fallocate(<insert meta flag name>) to the underlying file)?

This is exactly the same case as above: the loopback device does
user data IO to the backing file. Hence we have another situation
where metadata IO is issued to fallocate()d user data ranges as user
data ranges and so would be given a lesser guarantee that would lead
to upper filesystem failure. BOth upper and lower filesystem data
and metadata need to be provided the same ENOSPC guarantees by their
backing stores....

The whole point of the REQ_OP_PROVISION proposal I made is that it
doesn't require any special handling in corner cases like this.
There are no cross-layer interactions needed to make everything work
correctly because the provisioning guarantee is not -data type
dependent*. The entire user IO path code remains untouched and
blissfully unaware of provisioned regions.

And, realistically, if we have to start handling complex corner
cases in the filesystem and IO path layers to make REQ_OP_PROVISION
work correctly because of arbitary constraints imposed by the block
layer implementations, then we've failed miserably at the design and
architecture stage.

Keep in mind that every attempt made so far to address the problems
with block device ENOSPC errors has failed because of the complexity
of the corner cases that have arisen during design and/or
implementation. It's pretty ironic that now we have a proposal that
is remarkably simple, free of corner cases and has virtually no
cross-layer coupling at all, the first thing that people want to do
is add arbitrary implementation constraints that result in complex
cross-layer corner cases that now need to be handled....

Put simply: if we restrict REQ_OP_PROVISION guarantees to just
REQ_META writes (or any other specific type of write operation) then
it's simply not worth persuing at the filesystem level because the
guarantees we actually need just aren't there and the complexity of
discovering and handling those corner cases just isn't worth the
effort.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
