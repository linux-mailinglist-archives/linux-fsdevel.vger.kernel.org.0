Return-Path: <linux-fsdevel+bounces-43866-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D37A5ECE3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 08:23:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC9B13A742E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 07:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC021FCFCE;
	Thu, 13 Mar 2025 07:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="d4XWC24e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79961FCF72
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Mar 2025 07:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741850495; cv=none; b=hCcFutJJnwmOEP51WHIqken3XDAfj+u/5h2bC4n0mu7n+kqj7QqV7qjMNUISV045LeQNsjDg0E8DLA4+8gH1S6XU+OWHS56ut16MfN7jOKfRaBzyAL7FZoSTk9sPDub5D/ULSRH1uZwL46gGCs1ZiNn/B6vQv8etj+nUeWZ3xaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741850495; c=relaxed/simple;
	bh=fubdDPNtjd16g9f8WnsxZv+fL2VwT4oyIziapKYzHwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hn8HDUABcuVNn4YRR36QNfTYYLy+RaPh+IsVg/JzgZ0dvKMrvDi1OEPntsub4Mi+4og30QeEWRXcB93z3+06vRLK5aGJSTYdX3/re8GxB0dsloaXk19FV51o+Zei/kxf1SimGmO7YtlEYybi8bp2Fulpvdwg58lbzJFSjtS00Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=d4XWC24e; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22401f4d35aso11718045ad.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Mar 2025 00:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1741850493; x=1742455293; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Jk0LIgS/3SxMrP4L8WiUiKlVeO7G2UKoXRUIJ8IOHSc=;
        b=d4XWC24eGkM3IJY+OBI5afSd9tF7Qf/oxhPr3lD9LfY2Hf7TXEnNUgkB0qf/yAO0aV
         tC76wsU48HgtQB97E4IDO8ZegRstNM9fi2tSMGmi5KwfjS0jVz1AQfo8YIVRks1HoeeB
         MgIY2cowhN+McArwwrP5GH1Su1dCcHN6y176VSMxIh1ZAQ9REK4xIehPLw48kplZ4Cgq
         kB4q5WqsU//F9pk6zDGv7THWGkfVY4ajTWTJv/SOz45hfTZdNxfyIcouZuNy0kT62XMp
         7tR/ZK7Z8tgs/PEBnfHyf1UWthoGOx//IYFLOMhJsnaNhqxkeurdjg1uYxuvrg306ZJS
         n6oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741850493; x=1742455293;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jk0LIgS/3SxMrP4L8WiUiKlVeO7G2UKoXRUIJ8IOHSc=;
        b=nr4aaScd5pqOkgzsIL5uJs26JqDi3UxwCxQJ30rgDP6c6eOjPyFu+6e9dJRwe09wxg
         O+ee9npbvf8QweyHIji/ejYDZx5uMNRG1jCO2xZXw9XjSYbeZbIz6ESVyC99HwbHSYQ/
         j+lIkCNprUzWwkU8EjqprLWoODc+fql0QTi42gT0m01AET2bO4KTECZai6+XT9qO/e0Y
         UtIS7sKyd/PzSXsnfXGEYE7ksosuTayAbR8VBDpsR150uRIv366xMl8RqMSDOuk1c2BS
         r9H9zeqaFWoDheY6wbAPRCdP2E6XbDdJZhzHaS0yAZ7pECsr0nKjItJnUFHRxTbm91Qk
         w5Sw==
X-Forwarded-Encrypted: i=1; AJvYcCWV09ABKJ7m3aZ+mzpUam+LGlRPzS4+wrCiJ6g8frtGUK/BZtUnCUyYUyiNuEkuK50oF8bF9TprTZv8Tdj1@vger.kernel.org
X-Gm-Message-State: AOJu0YyFHU0ILhalJVRAySt/yve0ZuSQYaevC7vdXhXVT5nVYHNXWopa
	plyb09bdJ7FTPshS55ITP9H1W527j24igurYySyU+lwG0fDSuJBdHl7jK+Dl5/M=
X-Gm-Gg: ASbGncvFva96z220ZjcWWw+r1gNlePm73Q/V194w64sq+ybsfGyT+AXPGD7mY/bFr5Z
	7hA7g8/zdmRkZOw65jTB0yrda8jMiYhfMEajdg2Bip1yOG9ryFiDvGZuE8zdDlCstaB+E4GWFj8
	faHNC/3LoNrmrbvygz31d2UcGzlWNZZHsUwS15cCaTXp4jiwgjfme4Dd6sXjGa/z+HP5ZKGKh56
	L2AUyXi0p/ayOcO6RAY6A+3KdXs+cTszyYrCoWTry83w7xi6I5sU1iL9XXuN3l2eBnJ5M2DblBb
	QFTx3wnziaHTr5N3XQtaAv12g0h1WzyO7cf9xSsiH33qd0qxeMTNu/6FCAsa5vw5R7/SWB0FAGc
	8jKAFkbdQCqUgafW53GwP
X-Google-Smtp-Source: AGHT+IGmIGI/JFXTYYX6f4SlsL6WHOgA3BDQ86vTgOi7TwmcIlxDuyTd2476PvQNC1bZhxlfr2XV8A==
X-Received: by 2002:a17:902:c949:b0:224:78e:4ebe with SMTP id d9443c01a7336-22593183ec4mr143037515ad.33.1741850492997;
        Thu, 13 Mar 2025 00:21:32 -0700 (PDT)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c688e15fsm6962195ad.18.2025.03.13.00.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 00:21:32 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tscsj-0000000CU6d-0U1G;
	Thu, 13 Mar 2025 18:21:29 +1100
Date: Thu, 13 Mar 2025 18:21:29 +1100
From: Dave Chinner <david@fromorbit.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	John Garry <john.g.garry@oracle.com>, brauner@kernel.org,
	cem@kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	martin.petersen@oracle.com
Subject: Re: [PATCH v5 03/10] xfs: Refactor xfs_reflink_end_cow_extent()
Message-ID: <Z9KHeVmH1SyPVb5j@dread.disaster.area>
References: <20250310183946.932054-1-john.g.garry@oracle.com>
 <20250310183946.932054-4-john.g.garry@oracle.com>
 <Z9E2kSQs-wL2a074@infradead.org>
 <589f2ce0-2fd8-47f6-bbd3-28705e306b68@oracle.com>
 <Z9FHSyZ7miJL7ZQM@infradead.org>
 <20250312154636.GX2803749@frogsfrogsfrogs>
 <Z9I0Ab5TyBEdkC32@dread.disaster.area>
 <20250313045121.GE2803730@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313045121.GE2803730@frogsfrogsfrogs>

On Wed, Mar 12, 2025 at 09:51:21PM -0700, Darrick J. Wong wrote:
> On Thu, Mar 13, 2025 at 12:25:21PM +1100, Dave Chinner wrote:
> > On Wed, Mar 12, 2025 at 08:46:36AM -0700, Darrick J. Wong wrote:
> > > > > > On Mon, Mar 10, 2025 at 06:39:39PM +0000, John Garry wrote:
> > > > > > > Refactor xfs_reflink_end_cow_extent() into separate parts which process
> > > > > > > the CoW range and commit the transaction.
> > > > > > > 
> > > > > > > This refactoring will be used in future for when it is required to commit
> > > > > > > a range of extents as a single transaction, similar to how it was done
> > > > > > > pre-commit d6f215f359637.
> > > > > > 
> > > > > > Darrick pointed out that if you do more than just a tiny number
> > > > > > of extents per transactions you run out of log reservations very
> > > > > > quickly here:
> > > > > > 
> > > > > > https://urldefense.com/v3/__https://lore.kernel.org/all/20240329162936.GI6390@frogsfrogsfrogs/__;!!ACWV5N9M2RV99hQ!PWLcBof1tKimKUObvCj4vOhljWjFmjtzVHLx9apcU5Rah1xZnmp_3PIq6eSwx6TdEXzMLYYyBfmZLgvj$
> > > > > > 
> > > > > > how does your scheme deal with that?
> > > > > > 
> > > > > The resblks calculation in xfs_reflink_end_atomic_cow() takes care of this,
> > > > > right? Or does the log reservation have a hard size limit, regardless of
> > > > > that calculation?
> > > > 
> > > > The resblks calculated there are the reserved disk blocks
> > 
> > Used for btree block allocations that might be needed during the
> > processing of the transaction.
> > 
> > > > and have
> > > > nothing to do with the log reservations, which comes from the
> > > > tr_write field passed in.  There is some kind of upper limited to it
> > > > obviously by the log size, although I'm not sure if we've formalized
> > > > that somewhere.  Dave might be the right person to ask about that.
> > > 
> > > The (very very rough) upper limit for how many intent items you can
> > > attach to a tr_write transaction is:
> > > 
> > > per_extent_cost = (cui_size + rui_size + bui_size + efi_size + ili_size)
> > > max_blocks = tr_write::tr_logres / per_extent_cost
> > > 
> > > (ili_size is the inode log item size)
> > 
> > That doesn't sound right. The number of intents we can log is not
> > dependent on the aggregated size of all intent types. We do not log
> > all those intent types in a single transaction, nor do we process
> > more than one type of intent in a given transaction. Also, we only
> > log the inode once per transaction, so that is not a per-extent
> > overhead.
> > 
> > Realistically, the tr_write transaction is goign to be at least a
> > 100kB because it has to be big enough to log full splits of multiple
> > btrees (e.g. BMBT + both free space trees). Yeah, a small 4kB
> > filesystem spits out:
> > 
> > xfs_trans_resv_calc:  dev 7:0 type 0 logres 193528 logcount 5 flags 0x4
> > 
> > About 190kB.
> > 
> > However, intents are typically very small - around 32 bytes in size
> > plus another 12 bytes for the log region ophdr.
> > 
> > This implies that we can fit thousands of individual intents in a
> > single tr_write log reservation on any given filesystem, and the
> > number of loop iterations in a transaction is therefore dependent
> > largely on how many intents are logged per iteration.
> > 
> > Hence if we are walking a range of extents in the BMBT to unmap
> > them, then we should only be generating 2 intents per loop - a BUI
> > for the BMBT removal and a CUI for the shared refcount decrease.
> > That means we should be able to run at least a thousand iterations
> > of that loop per transaction without getting anywhere near the
> > transaction reservation limits.
> > 
> > *However!*
> > 
> > We have to relog every intent we haven't processed in the deferred
> > batch every-so-often to prevent the outstanding intents from pinning
> > the tail of the log. Hence the larger the number of intents in the
> > initial batch, the more work we have to do later on (and the more
> > overall log space and bandwidth they will consume) to relog them
> > them over and over again until they pop to the head of the
> > processing queue.
> > 
> > Hence there is no real perforamce advantage to creating massive intent
> > batches because we end up doing more work later on to relog those
> > intents to prevent journal space deadlocks. It also doesn't speed up
> > processing, because we still process the intent chains one at a time
> > from start to completion before moving on to the next high level
> > intent chain that needs to be processed.
> > 
> > Further, after the first couple of intent chains have been
> > processed, the initial log space reservation will have run out, and
> > we are now asking for a new resrevation on every transaction roll we
> > do. i.e. we now are now doing a log space reservation on every
> > transaction roll in the processing chain instead of only doing it
> > once per high level intent chain.
> > 
> > Hence from a log space accounting perspective (the hottest code path
> > in the journal), it is far more efficient to perform a single high
> > level transaction per extent unmap operation than it is to batch
> > intents into a single high level transaction.
> > 
> > My advice is this: we should never batch high level iterative
> > intent-based operations into a single transaction because it's a
> > false optimisation.  It might look like it is an efficiency
> > improvement from the high level, but it ends up hammering the hot,
> > performance critical paths in the transaction subsystem much, much
> > harder and so will end up being slower than the single transaction
> > per intent-based operation algorithm when it matters most....
> 
> How specifically do you propose remapping all the extents in a file
> range after an untorn write?

Sorry, I didn't realise that was the context of the question that
was asked - there was not enough context in the email I replied to
to indicate this important detail. hence it just looked like a
question about "how many intents can we batch into a single write
transaction reservation".

I gave that answer (thousands) and then recommended against doing
batching like this as an optimisation. Batching operations into a
single context is normally done as an optimisation, so that is what
I assumed was being talked about here....

> The regular cow ioend does a single
> transaction per extent across the entire ioend range and cannot deliver
> untorn writes.  This latest proposal does, but now you've torn that idea
> down too.
>
> At this point I have run out of ideas and conclude that can only submit
> to your superior intellect.

I think you're jumping to incorrect conclusions, and then making
needless personal attacks. This is unacceptable behaviour, Darrick,
and if you keep it up you are going to end up having to explain
yourself to the CoC committee....

Anyway....

Now I understand the assumed context was batching for atomicity and
not optimisation, I'll address that aspect of the suggested
approach: overloading the existing write reservation with a special
case like this is the wrong way to define a new atomic operation.

That is: trying to infer limits of special case behaviour by adding
a heuristic based calculation based on the write log reservation
is poor design.

The write reservation varies according to the current filesystem's
geometry (filesystem block size, AG size, capacity, etc) and kernel
version. Hence the batch size supported for atomic writes would then
vary unpredictably from filesystem to filesystem and even within the
same filesystem over time.

Given that we have to abort atomic writes up front if the mapping
covering the atomic write range is more fragmented than this
calculated value, this unpredicable limit will be directly exposed
to userspace via the errors it generates.

We do not want anything even vaguely related to transaction
reservation sizes exposed to userspace. They are, and should always
be, entirely internal filesystem implementation details.

A much better way to define an atomic unmap operation is to set a
fixed maximum number of extents that a batched atomic unmap
operation needs to support. With a fixed extent count, we can then
base the transaction reservation size required for the operation on
this number.

We know that the write length is never going to be larger than 2GB
due to MAX_RW_COUNT bounding of user IO. Hence there is a maximum
number of extents that a single write can map to. Whether that's the
size we try to support is separate discussion, but I point it out as
a hard upper maximum.

Regardless of what we define as the maximum number of extents for
the atomic unmap, we can now calculate the exact log space
reservation the an unmap intents will require. We can then max()
that with the log space reservation that any of those specific
intents will require to process. Now we have an exact log
reservation to an atomic unmap of a known, fixed number of extents.

Then we can look at what the common unmap behaviour is (e.g. through
tracing various test cases) are, and determine how many extents we
are typically going to convert in a single atomic unmap operation.
That then guides us to an optimal log count for the atomic unmap
reservation.

This gives us a single log space reservation that can handle a known,
fixed number of extents on any filesystem. 

It gives us an optimised log count to minimise the number of log
space reservations the common case code is going to need.

It gives us a reservation size that will contribute to defining the
minimum supported log size for the features enabled in the
filesystem.

It gives us a consistent behaviour that we can directly exercise
from userspace with relatively simple test code based on constant
values.

It means the high level unmap code doesn't rely on heuristics to
prevent transaction reservation overflows.

It means the high level code can use bound loops and compile time
constants without having to worry that they will ever overrun the
capability of the underlying filesystem or kernel.

Simple, huh?

-Dave.
-- 
Dave Chinner
david@fromorbit.com

