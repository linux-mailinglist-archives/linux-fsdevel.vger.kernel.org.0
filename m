Return-Path: <linux-fsdevel+bounces-65275-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B71C0BFFB13
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 09:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C92B03ADA2B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 07:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65EB22DC78C;
	Thu, 23 Oct 2025 07:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="ZpnZ7v0N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA792DC323
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Oct 2025 07:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761205852; cv=none; b=mG9AApz4hkq29FqBbQEaEB0lZd+cQKol3X2nglQb2RZlWkTd7E5H8GzL6Dqn2cs+kMWTEeDcO4rP2snx3IeLWCf0X35p434W/fUGWlvdg6aKdhXtzDMOwuhtDTXx48RQmwGv+z6yNOCHEBjiRa7H3GTASz61+ZBoBMIK+5r7xVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761205852; c=relaxed/simple;
	bh=JoNlY+AuFugfQuHxQnkdADc58KsqVo0K0cXElarhy8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lX0l8w4OYmgiy87wO6oY+6V/DPNpDigJZYcWnlm3Ab4DH294ilCQIh2RBKmpvoC3vVzZv0NvpUDOx0Lzvmgrd7lNvqdUeC9c3NOH4EL8aeHV9rkz2jCqaObAC2NtLmFd3mHTb2vmCegbIAvAkDi4BQg104vTsHOHyE9QyZDnGhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=ZpnZ7v0N; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3304dd2f119so438586a91.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Oct 2025 00:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1761205850; x=1761810650; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uwByf+n4jp5MlDetSCexzrKrLtoHg0zmHHS2wZ49+as=;
        b=ZpnZ7v0Nicfui5IF/kI/bjaYpUNyiFkprFgJ3GJTyO73U7vSZqyxFhHSxhjKHc1GlT
         RtCagEeR2uH4GKQN3MtadR6/vx7TJl/QhHjBR4pEU4YcQqFyxFwcuXLa2TfEB7xeFFYE
         P7z7jmlEos3e1HHfVgZ+cSKYrAlYceQzwakKYT/FZVZ2A5v17zvdCCWZhyuVsrCQyS2b
         h6cT4y/1aZwxttrGbuv1sl7B1g6/vhJJpbFm0RoixUTLABNPVLjIj5tg9moJZGNoRUA9
         ICeygRF4sL2mSTArUi/Z9+di6mb5iYb+Pm8uXWJYLBPJn0D2TzCRuHu4Cnu9j56J3IuD
         71sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761205850; x=1761810650;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uwByf+n4jp5MlDetSCexzrKrLtoHg0zmHHS2wZ49+as=;
        b=NndK4OsYLpaG9gvC0JI9qigF+5b/RJkHzZvN1jIlo3vLa1FeoWRueIdOGecnw0Lm0U
         oRXEbLn1U/T7rOBm2bfCxHYgvnLdrlky26NgbGpiuYeZ5V/y1Z3y2+iYkM2T8oD0n8oj
         mB1HOgjDhrkIMUzjXSsdYZ2cNwi6p8gj6boQmGF5oMf6C50hyEGzjTs6BO/mYxNhUKKC
         YR+Jk/LR0ntZfxGpuONHIJbOjdQxekZRfGNm5+ulKysjtjN78YmFrd4TaekD6KW/iOSB
         BwNcGzV2owt7g/yw6SUua/PDakIj0neMrVsyYaQvWPeNKJc9G9oHiDndtxK7FT2bB0BF
         hl8A==
X-Forwarded-Encrypted: i=1; AJvYcCW5v5skUefwo5e4LeHxGcpWgfTyErkQf6R2kj2sJsyryPIyqOaI6VVPfoQOL2Qei0nClmAOrerDgg1iD1Tm@vger.kernel.org
X-Gm-Message-State: AOJu0YwZIKK2Kv8r2+iaPuim74Zo/KRr+r5hBn44L7YVxrHRrZg0eE1x
	lYEblwxX85DF0eKJCex/wUjTON90nRTg8lDV7djP75TZr9Q4IlWCiNwf4zs0hiUnPtw=
X-Gm-Gg: ASbGncvg1RrZrIr8uDAygCd7lKbta9LqA+xs56+TC8sR8aF/4DPf1vXp8kJzq7wEWOb
	K/HnpHIxCP09G64Ebl6tCom4XnTFe2N8BWpjjMGrNLqsfndzMpah3Fg0EVigpf7m/jPAbEaqlEH
	4+k2ix47QyWyKgbBVZw5QyRv3+0hVpNeCrxnG9GlpuJdAiitEGes4yU4qizrAc0Zc9F2tDHfu2B
	ytGBvrW5w+o8XB7MLW/W4gyKq44xVdJJEF3+Gb2tjj0SXouwOTAkVBNDLQpn3sCDE6OPp2D+ioo
	77Il+QfbjEgLtemWy/4DO5WX9fGbKq44/tKy13/cKLa3xUczuL7YI/T6/w/fiyEwZiKdZvZC3N9
	ZHq0uHv3JcEEIMn07pfUX23+Nwb4zUA60cPs6767USqDdgRR2tRs45b7YH7ebBbveBOts9R68aw
	MaoEhEn+ts8/ZzU7ayfKBhvOs5C4qYujqC0xH+pXUVG6hLaHVTgFaaDalm7RqKfQ==
X-Google-Smtp-Source: AGHT+IFRfms9e7PzLk9IgH6Ep9yL2WAFmAvRcEuwokRQNbyJf14nzx4x2RDzrKdFQpOW6sShCgNZrQ==
X-Received: by 2002:a17:90b:4b51:b0:32e:7c34:70cf with SMTP id 98e67ed59e1d1-33bcf9237b8mr26054426a91.36.1761205849913;
        Thu, 23 Oct 2025 00:50:49 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-91-142.pa.nsw.optusnet.com.au. [49.180.91.142])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6cf4bb8eacsm1292834a12.3.2025.10.23.00.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 00:50:49 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1vBq5u-00000000xQf-0C9X;
	Thu, 23 Oct 2025 18:50:46 +1100
Date: Thu, 23 Oct 2025 18:50:46 +1100
From: Dave Chinner <david@fromorbit.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kiryl Shutsemau <kirill@shutemov.name>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH] mm/filemap: Implement fast short reads
Message-ID: <aPneVmBuuTHGQBgl@dread.disaster.area>
References: <20251017141536.577466-1-kirill@shutemov.name>
 <20251019215328.3b529dc78222787226bd4ffe@linux-foundation.org>
 <44ubh4cybuwsb4b6na3m4h3yrjbweiso5pafzgf57a4wgzd235@pgl54elpqgxa>
 <aPgZthYaP7Flda0z@dread.disaster.area>
 <CAHk-=wjaR_v5Gc_SUGkiz39_hiRHb-AEChknoAu9BUrQRSznAw@mail.gmail.com>
 <aPiPG1-VDV7ZV2_F@dread.disaster.area>
 <CAHk-=wjVOhYTtT9pjzAqXoXdinrV9+uiYfUyoQ5RFmTEvua-Jg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjVOhYTtT9pjzAqXoXdinrV9+uiYfUyoQ5RFmTEvua-Jg@mail.gmail.com>

On Wed, Oct 22, 2025 at 05:31:12AM -1000, Linus Torvalds wrote:
> On Tue, 21 Oct 2025 at 22:00, Dave Chinner <david@fromorbit.com> wrote:
> >
> > On Tue, Oct 21, 2025 at 06:25:30PM -1000, Linus Torvalds wrote:
> > >
> > > The sequence number check should take care of anything like that. Do
> > > you have any reason to believe it doesn't?
> >
> > Invalidation doing partial folio zeroing isn't covered by the page
> > cache delete sequence number.
> 
> Correct - but neither is it covered by anything else in the *regular* read path.
> 
> So the sequence number protects against the same case that the
> reference count protects against: hole punching removing the whole
> page.
> 
> Partial page hole-punching will fundamentally show half-way things.

Only when you have a busted implementation of the spec.

Think about it: if I said "partial page truncation will
fundamentally show half-way things", you would shout at me that
truncate must -never- expose half-way things to buffered reads.
This is how truncate is specified to behave, and we don't violate
the spec just because it is hard to implement it.

We've broken truncate repeatedly over the past 20+ years in ways
that have exposed stale data to users. This is always considered a
critical bug that needs to be fixed ASAP.

Hole punching is documented to require the same behaviour as
truncate and, like truncate, any breakage of that is a potential
stale kernel or physical data exposure event.

Why will we not tolerate data corruption bugs in truncate due to
page cache races, yet being told that we are supposed to just ignore
those same data corruption races during fallocate operations?

This seems like a double standard to me. 

Also, keep in mind that XFS isn't exposed to these bugs, so I have
no real skin in the game here. People need to be made aware of of a
data integrity issue that are noticed, not have them swept under the
rug with dubious reasoning.

> > > Yes, you can get the "before or after or between" behavior, but you
> > > can get that with perfectly regular reads that take the refcount on
> > > the page.
> >
> > Yes, and it is the "in between" behaviour that is the problem here.
> >
> > Hole punching (and all the other fallocate() operations) are
> > supposed to be atomic w.r.t. user IO. i.e. you should see either the
> > non-punched data or the punched data, never a mix of the two. A mix
> > of the two is a transient data corruption event....
> 
> That "supposed" comes from documentation that has never been true and
> as such is just a bedtime story.

I'll give you the benefit of the doubt here, because you are not
an expert in the field.

That is, I think you are conflating POSIX buffered read/write
syscall atomicity with fallocate() requirements. They are not the
same thing.  The fallocate() atomicity requirements come from the
low level data coherency/integrity requirements of the operations
being performed, not from some POSIX spec.

e.g. FALLOC_FL_ZERO_RANGE turns a range of a file to zeros. The
implementation of this can vary. The filesystem can:
	- write zeros through the page cache. Users have asked us
	  not to do this but return -EOPNOTSUPP so they can choose
	  the fallback mechanism themselves.
	- use block device offloads like WRITE_SAME(0) to have the
	  device physically zero the range.
	- use DISCARD blockdev operations if the device guarantees
	  discarded regiond return zeros.
	- punch out all the extents, leaving a hole.
	- punch out all the extents, then preallocate new unwritten
	  extents thereby defragmenting the range at the same time.
	- preallocate new unwritten extents over holes and convert
	  existing written extents to unwritten.

All of these are valid implementations, and they are all multi-step
operations that could expose partial completion to userspace if
there is no IO serialisation against the ZERO_RANGE operation.

Hence there is really only one behaviour that is required: whilst
the low level operation is taking place, no external IO (read,
write, discard, etc) can be performed over that range of the file
being zeroed because the data andor metadata is not stable until the
whole operation is completed by the filesystem.

Now, this doesn't obviously read on the initial invalidation races
that are the issue being discussed here because zero's written by
invalidation could be considered "valid" for hole punch, zero range,
etc.

However, consider COLLAPSE_RANGE.  Page cache invalidation
writing zeros and reads racing with that is a problem, because
the old data at a given offset is non-zero, whilst the new data at
the same offset is alos non-zero.

Hence if we allow the initial page cache invalidation to race with
buffered reads, there is the possibility of random zeros appearing
in the data being read. Because this is not old or new data, it is
-corrupt- data.

Put simply, these fallocate operations should *never* see partial
invalidation data, and so the "old or new data" rule *must* apply to
the initial page cache invalidation these fallocate() operations do.

Hence various fallocate() operations need to act as a full IO
barrier. Buffered IO, page faults and direct IO all must be blocked
and drained before the invalidation of the range begins, and must
not be allowed to start again until after the whole operation
completes.

IOWs, IO exclusion is a data integrity requirement for fallocate()
operations to prevent users from being exposed to transient data
corruption races whilst the fallocate() operation is being
performed. It has nothing to do with POSIX in any way...

Also, keep in mind that fallocate() is only one vector to this race
condition.  Multiple filesystems have multiple invalidation vectors
to this race condition.  There are similar issues with custom extent
swap ioctls (e.g. for online defragmentation), ensuring
->remap_file_range() and ->copy_file_range() implementations have
exclusive access to the file data and/or metadata they are
manipulating (e.g. offload to hardware copy engines), and so on.

fallocate() is just a convenient example to use because multiple
filesystems implement it, lots of userspace applications use it and
lots of people know about it. It is not niche functionality anymore,
so people should be paying close attention when potential data
corruption vectors are identified in these operations...

> And no, iI'd argue that it's not even documenting desirable behavior,
> because that bedtime story has never been true because it's
> prohibitively expensive.

I disagree, and so do the numbers - IO path exclusion is pretty
cheap for the most part, and not a performance limiting requirement.

e.g. over a range of different benchmarks on 6.15:

https://www.phoronix.com/review/linux-615-filesystems/6

i.e. XFS is 27% faster overall than ext4 and btrfs on a modern NVMe
SSDs.  Numbers don't lie, and these numbers indicate that the IO
path exclusion that XFS implementations for avoiding invalidation
races doesn't have any impact on typical production workloads...

That said, I am most definitely not suggesting that the XFS IO path
exclusion is the solution for the specific buffered read vs cache
invalidation race I pointed out. It's just one example of how it can
be solved with little in the way of runtime overhead.

I suspect the invalidation race could be detected at the page cache
layer with a mark-and-sweep invalidation algorithm using xarray tags
kinda like writeback already does. Those tags could be detected in
the read path at little extra cost (the xarray node is already hot
in cache) which can then punt the folio to a slow path that does the
right thing.  If there's no invalidation tag present, then the fast
path can safely keep doing it's fast path things...

> I think it would be much better to fix the documentation, but that's
> generally out of our hands.

We control the fallocate() specification and documentation
ourselves. But that's not the problem here; the problem is that the
cached data invalidation mechanism used by fallocate operations does
not prevent buffered reads from racing against invalidation and
exposing invalid transient data to users...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

