Return-Path: <linux-fsdevel+bounces-42723-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C7AA46CBD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 21:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F28E18895A9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 20:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769882459C6;
	Wed, 26 Feb 2025 20:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="KIE3u/fN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD952459C7
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Feb 2025 20:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740602946; cv=none; b=AdioTyKFd4L4gtlVP4YLQAxiTRXtJTBxoAq/svVO2bRVXcjj4/ekaxLXNGdEvNtHHWkEi1EGaMxYWq50izLeTFMVWiwE9s4W5XZVUYadauV8Ys7F/iHwU3mtH/m4Ekd0vQgNKsLMeE12fuiA2Ql7eZTMv6DpvTpT+cct8OvxUk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740602946; c=relaxed/simple;
	bh=qclk0b4WczLTgOcgrRGcu+KMX+qE0RL3BNOM6NOjS+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TnSCKz/uFlavlN2TLnruztjWFlbFpIx+ZVTf41bedOFnLMujfWHjLqkqT0N1Y+enXzohphrR6Jf53eZ12rUJo0pxnVtVTApxpxJx1q9xNFw8QjSUZGPNdwOb8JdP/SifsDW6bmZa0xdRrji/orKMfHacqtRi+s5c6iGU73GfYwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=KIE3u/fN; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-223378e2b0dso3111265ad.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Feb 2025 12:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1740602944; x=1741207744; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Mjphc0mHAAvrQK0ML5Y+/zaRiBObs03G3AToZgygKhw=;
        b=KIE3u/fNWXK3Z1tfTrwGg6vJw/7qcyw3Rns42ACn9dezoSEB7B3Z9lB6hWir253cDi
         6vYsqm8iKLkn/KYlN0MSUTppmeYIuv1x78anivBWO3SHDHScjtvWNlWmTChrcW7cgxiJ
         /w80RbUmqAVARnEd6TmczdAu7MoD10tb43MZLwYvd3I3psx1kczQQ1pwOI4/WYINheVR
         yeFgwrdQ5/3AS0ABbqqKKS4h0bpRQHgR9pdNRvMd24hnmPk9rlQ9PGpJCdSGl+bJRM81
         LSAnA7V8MZN7+azFADMn5A92qoFI12gWPRcx7Bzva8/JFUdKnja3U9IrQ2Zbf/Es7d0p
         RdOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740602944; x=1741207744;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mjphc0mHAAvrQK0ML5Y+/zaRiBObs03G3AToZgygKhw=;
        b=JCM4Em65kPNDr08+ECliG1VSZG8HdQDUS3Wa3zrBQ5V7LMmHmUYvQJRPuKzvzi6LaO
         54yz1QBjUY77rFneVkXHtis5/dSUgx0EdTLpoktgM82h581b8PHSpiTlcg17/X1TkNp+
         eqSSeEzwRz+wd5fgKgk0cvohzZP5PozKyCOJkedS/eosxtBDEVsEEAT3jKbXp+HMi02S
         KqrlJlVArrg2Zcrd0Uy3hY/xBxkGuWrAT4+0teowFOvOcY2lvnHBVpzpGlGXqtNaMgMz
         qZgh0vruFEBUa7PFRVRT1mhkk28l4Qy1P9ljeOQFHWvHPpIotePVVjxvN/59a7jDvSwJ
         4nDA==
X-Forwarded-Encrypted: i=1; AJvYcCXrGkhYgZ/06AOeabBWMytaShCnPGl/Yeo6yKsU0b4X0CWPd0LH/hlq0nTcA1BVbq09gQ9v3Q/EzMBOKwwK@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw/MXxffZZEtE6TiSkjCFsZsG44i7PnCKe0sb42MtjMGw1oQqH
	tbdb2y3Ze87eobTsJjNjxYyaKrVkV4wgtGdocdR5roEZmnDo6JuqtcRiu0GKdGc=
X-Gm-Gg: ASbGnctmP9hEGVmPdkz4pbO+64p0tA94043ncqGmJzu6RZKj5j4xv/GBKHKezoPwu4Y
	24/cu7ViIHYFvZ73acUSnJPbYN3YOA5oYKQibrws0xgjZBod2LAXIKD3UBzXcbT3oPFBGHb8NOi
	Sc3KGw+SSzj8LWO4eajWq/ACSEOu41aMyTeQNdKqciB7uSkEmV9EmNQ6ec5NVqk8n92btWvCAfa
	WFLAGuXjfYkk6R1iOsIEWIcwA8eZEPCMBMQsqXOV0DLoiRoEjFWb0ytNSeBtZiy+N73F/MuXsTV
	6A1GuVGS3kAgpwuofaN/A2ZAcnBcuzM9bU2z1DguiifnqcKI1n51rhV37uQDxtV2PBwl7KCJyAc
	oZg==
X-Google-Smtp-Source: AGHT+IHjkKZNnGS0pG/zXxkdwmPvjCRFvZfP7g0ivgkDJxNmLHl3RTeBqcQpvhrw778IYD8k4cqvDA==
X-Received: by 2002:a17:902:eccf:b0:21f:6fb9:9299 with SMTP id d9443c01a7336-22307b69880mr126851065ad.27.1740602944396;
        Wed, 26 Feb 2025 12:49:04 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223504e19f6sm396175ad.183.2025.02.26.12.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 12:49:03 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tnOKy-00000006LNk-45VO;
	Thu, 27 Feb 2025 07:49:00 +1100
Date: Thu, 27 Feb 2025 07:49:00 +1100
From: Dave Chinner <david@fromorbit.com>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: io-uring@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	"Darrick J . Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
	wu lei <uwydoc@gmail.com>
Subject: Re: [PATCH 1/1] iomap: propagate nowait to block layer
Message-ID: <Z79-PEZ2YQybCjmi@dread.disaster.area>
References: <ca8f7e4efb902ee6500ab5b1fafd67acb3224c45.1740533564.git.asml.silence@gmail.com>
 <Z76eEu4vxwFIWKj7@dread.disaster.area>
 <7b440d54-b519-4995-9f5f-f3e636c6d477@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b440d54-b519-4995-9f5f-f3e636c6d477@gmail.com>

On Wed, Feb 26, 2025 at 12:33:21PM +0000, Pavel Begunkov wrote:
> On 2/26/25 04:52, Dave Chinner wrote:
> > On Wed, Feb 26, 2025 at 01:33:58AM +0000, Pavel Begunkov wrote:
> > > There are reports of high io_uring submission latency for ext4 and xfs,
> > > which is due to iomap not propagating nowait flag to the block layer
> > > resulting in waiting for IO during tag allocation.
> > > 
> > > Cc: stable@vger.kernel.org
> > > Link: https://github.com/axboe/liburing/issues/826#issuecomment-2674131870
> > > Reported-by: wu lei <uwydoc@gmail.com>
> > > Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> > > ---
> > >   fs/iomap/direct-io.c | 3 +++
> > >   1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> > > index b521eb15759e..25c5e87dbd94 100644
> > > --- a/fs/iomap/direct-io.c
> > > +++ b/fs/iomap/direct-io.c
> > > @@ -81,6 +81,9 @@ static void iomap_dio_submit_bio(const struct iomap_iter *iter,
> > >   		WRITE_ONCE(iocb->private, bio);
> > >   	}
> > > +	if (iocb->ki_flags & IOCB_NOWAIT)
> > > +		bio->bi_opf |= REQ_NOWAIT;
> > 
> > ISTR that this was omitted on purpose because REQ_NOWAIT doesn't
> > work in the way iomap filesystems expect IO to behave.
> > 
> > I think it has to do with large direct IOs that require multiple
> > calls to submit_bio(). Each bio that is allocated and submitted
> > takes a reference to the iomap_dio object, and the iomap_dio is not
> > completed until that reference count goes to zero.
> > 
> > hence if we have submitted a series of bios in a IOCB_NOWAIT DIO
> > and then the next bio submission in the DIO triggers a REQ_NOWAIT
> > condition, that bio is marked with a BLK_STS_AGAIN and completed.
> > This error is then caught by the iomap dio bio completion function,
> > recorded in the iomap_dio structure, but because there is still
> > bios in flight, the iomap_dio ref count does not fall to zero and so
> > the DIO itself is not completed.
> > 
> > Then submission loops again, sees dio->error is set and aborts
> > submission. Because this is AIO, and the iomap_dio refcount is
> > non-zero at this point, __iomap_dio_rw() returns -EIOCBQUEUED.
> > It does not return the -EAGAIN state that was reported to bio
> > completion because the overall DIO has not yet been completed
> > and all the IO completion status gathered.
> > 
> > Hence when the in flight async bios actually complete, they drop the
> > iomap dio reference count to zero, iomap_dio_complete() is called,
> > and the BLK_STS_AGAIN error is gathered from the previous submission
> > failure. This then calls AIO completion, and reports a -EAGAIN error
> > to the AIO/io_uring completion code.
> > 
> > IOWs, -EAGAIN is *not reported to the IO submitter* that needs
> > this information to defer and resubmit the IO - it is reported to IO
> > completion where it is completely useless and, most likely, not in a
> > context that can resubmit the IO.
> > 
> > Put simply: any code that submits multiple bios (either individually
> > or as a bio chain) for a single high level IO can not use REQ_NOWAIT
> > reliably for async IO submission.
> 
> I know the issue, but admittedly forgot about it here, thanks for
> reminding! Considering that attempts to change the situation failed
> some years ago and I haven't heard about it after, I don't think
> it'll going to change any time soon.
> 
> So how about to follow what the block layer does and disable multi
> bio nowait submissions for async IO?
> 
> if (!iocb_is_sync(iocb)) {
> 	if (multi_bio)
> 		return -EAGAIN;
> 	bio_opf |= REQ_NOWAIT;
> }

How do we know it's going to be multi-bio before we actually start
packing the data into the bios? More below, because I kinda pointed
out how this might be solved...

> Is there anything else but io_uring and AIO that can issue async
> IO though this path?

We can't assume anything about the callers in the lower layers.
Anything that can call the VFS read/write paths could be using async
IO.

> > We have similar limitations on IO polling (IOCB_HIPRI) in iomap, but
> > I'm not sure if REQ_NOWAIT can be handled the same way. i.e. only
> > setting REQ_NOWAIT on the first bio means that the second+ bio can
> > still block and cause latency issues.

Please have a look at how IOCB_HIPRI is handled by iomap for
multi-bio IOs. I -think- the same can be done with IOMAP_NOWAIT
bios, because the bio IO completion for the EAGAIN error will be
present on the iomap_dio by the time submit_bio returns. i.e.
REQ_NOWAIT can be set on the first bio in the submission chain,
but only on the first bio.

i.e. if REQ_NOWAIT causes the first bio submission to fail with
-EAGAIN being reported to completion, we abort the submission or
more bios because dio->error is now set. As there are no actual bios
in flight at this point in time, the only reference to the iomap_dio
is held by the iomap submission code.  Hence as we finalise the
aborted DIO submission, __iomap_dio_rw() drops the last reference
and iomap_dio_rw() calls iomap_dio_complete() on the iomap_dio. This
then gathers the -EAGAIN error that was stashed in the iomap_dio
and returns it to the caller.

i.e. I *think* this "REQ_NOWAIT only for the first bio" method will
solve most of the issues that cause submission latency (especially
for apps doing small IOs), but still behave correctly when large,
multi-bio DIOs are submitted.

Confirming that the logic is sound and writing fstests that exercise
the functionality to demonstrate your eventual kernel change works
correctly (and that we don't break it in future) is your problem,
though.

> > So, yeah, fixing this source of latency is not as simple as just
> > setting REQ_NOWAIT. I don't know if there is a better solution that
> > what we currently have, but causing large AIO DIOs to
> > randomly fail with EAGAIN reported at IO completion (with the likely
> > result of unexpected data corruption) is far worse behaviour that
> > occasionally having to deal with a long IO submission latency.
> 
> By the end of the day, it's waiting for IO, the first and very thing
> the user don't want to see for async IO, and that's pretty much what
> makes AIO borderline unusable.  We just can't have it for an asynchronous
> interface.

Tough cookies. Random load related IO errors that can result in
unexpected user data corruption is a far worse outcome than an
application suffering from a bit of unexpected latency. You are not
going to win that argument, so don't bother wasting time on it.

> If we can't fix it up here, the only other option I see
> is to push all such io_uring requests to a slow path where we can
> block, and that'd be quite a large regression.

Don't be so melodramatic. Async IO has always been, and will always
be, -best effort- within the constraints of filesystem
implementation, data integrity and behavioural correctness.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

