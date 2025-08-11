Return-Path: <linux-fsdevel+bounces-57401-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5444EB2131A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 19:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6149016D32B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 17:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68DC92D3A7E;
	Mon, 11 Aug 2025 17:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="aw8+geIu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5ECD1DFDAB
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Aug 2025 17:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754933158; cv=none; b=EzoCsxIiOUS/Ld2fQfo+KxBHD/HJKwXOVSxu3aRycjLgXEOLdLQyN9YvwpZlVJg+Qr9/tC/n+9piZuhJ43wZPinbOli/i54a05uSjnLnFYES5YJtONF15JgEvG3cERu3gJU9PxbfCeSp8CmmYX3nQuug4FnkzXpMz/s6jyZ9s9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754933158; c=relaxed/simple;
	bh=+5j1WtmSbCepc85Uu28avyybqNkrTW+D1C3yTy4KP54=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ql3BdyD6UXSARxC+9NxZRMLAO0AVxGI0CfxhOz0VFaV+Kblvh7Q6E0jZBRMshUjJBdzxutdm5cRl2csN1h08yt9bPCRuwQSlAniWpRHKsrZKrZyIQNz0LVoWSscyYHFZtAgjjGU1Gn45oCPdDsOltB9vX1/OwfmJaCMfr77YC00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=aw8+geIu; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-88182bb2336so123694039f.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Aug 2025 10:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1754933155; x=1755537955; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ylgbjSchVuRq/wSTb5b7E9IeSolYCqXoPwG3niv5Ku4=;
        b=aw8+geIuDQio/RhEbFBoWASmRsPzOq76wW1wyStHna4Mk4UKcS9Ju92clxcDzSnb9e
         gr1dSi9pyjAbUZ34+K7DJPyQp4RpfRe9SaiTVblicHO4Azjg6oMgm5dmHQaCsSpCyU0b
         4OzV5Ue079zKOdn9F6uCGyjx5EYAQAv9U1n1DAMO3B2b0dnM7MzZBqNfyq4o5TUa5Nnz
         UASFJSBJ26Az0JldHqWoagVfT/gO1Ho7I4Wa7cFWv8Fb8XAuv+TBjluQQK2HBMpo9J2V
         yGn9vaPzoLuV+hN7fj9a8VryenLw8JKJ4lwCQ8N9whV8hQEPT7zziZ3FXw458rkJ1r87
         evhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754933155; x=1755537955;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ylgbjSchVuRq/wSTb5b7E9IeSolYCqXoPwG3niv5Ku4=;
        b=OS4jN/TmEj2lXOyYPoUDJcWDfQpWei+tynNJGsFaBjVOMFH2kDyN6IwMQ9pao4C25V
         rAaFKKBfsWgaMmweo+OuWs96f57s1EpPLijePCHLnY92OuNRKk64TNAo5x1IwNx3KKLp
         h8suOba81C2rSwcz2foPMkJNp9OrbMmX4WDYbef9L9SNk38h9R+sQcgKmid+VDaGZ+My
         BqDXHC+vVkwzc8wecpV7dn+xdxequtelaseur6MdDEl+ROpf34UP1LQTI4HfuxVrcffM
         dU4XhBOQQ6w0M34J/Vc5ir5J1FaytNak85FM7NuG5g/n4Fe8AqEDow9SE71nPvdK2rXp
         /DUg==
X-Forwarded-Encrypted: i=1; AJvYcCUgFGPbAdLNaxjtOI35YQwRfCkLp7bZ3izk4wNWVLSDDyl2p83NnsIx0ePLOynf/KZUNNT+kG5vJdA4QWpW@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6n81l+FIwyhHL3r7mObfMh8DimM5+wKGWuP7J3+VimxtvkOBs
	E1niVW/nMeiRLBwD3iWx5TfQYl9z1z65jDxVdjvf+ro6RrBO4ItMqeMP4aPvGqZ0+JA=
X-Gm-Gg: ASbGnctVN+1Up9rPPdUxobzHm5RopwxJ/G1h8DbIt3YESEL2JuWeGwELMjxlqSr2jq2
	9VEMGFtTO5fDNpWjPQxM74V6HHqV9+cPCdTIBWQkbAKtgPQwWik2b5aBAguw3CiBVO0FcKGTh6M
	oASyi2fsJ4JkKZp1VWBVLootirY7VAsaOJunQ8cCa61wplalgXVFDdy9K+xmschQ3Qq30588bMI
	OINGcvQXpsc4lwOQUM5QWSYI1LYqLrhAj9FHZkHqk7Xsv6XPi3oVdTbFjx7TxdZiIo1Yh3xX8BQ
	JnnRsFh05aA6d2Emsp/BJckPOW3UALJ6gkUjPksO8H+edWbynWbR3WhafqjQm9fW5NN5jtBf//k
	t672esjy9cYgoxigvV7M=
X-Google-Smtp-Source: AGHT+IFOd4aKFBw64+HMgB8vYZQBUaJ7NA64vOBdxsiT5qogCsWs/AJDdMJXCdpsm7CLbyX2FcloKQ==
X-Received: by 2002:a05:6602:1584:b0:87c:30c6:a7cf with SMTP id ca18e2360f4ac-883f10de3e3mr2457533539f.0.1754933154647;
        Mon, 11 Aug 2025 10:25:54 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-883f19d013dsm294433839f.31.2025.08.11.10.25.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 10:25:53 -0700 (PDT)
Message-ID: <409ec862-de32-4ea0-aae3-73ac6a59cc25@kernel.dk>
Date: Mon, 11 Aug 2025 11:25:52 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jens Axboe <axboe@kernel.dk>
Subject: Re: RWF_DONTCACHE documentation
To: Alejandro Colomar <alx@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org,
 linux-man@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>
References: <aD28onWyzS-HgNcB@infradead.org>
 <cb062be5-04e4-4131-94cc-6a8d90a809ac@kernel.dk>
 <a8a96487-99d9-442d-bf05-2df856458b39@kernel.dk>
 <sxmgk5dskiuq6wdfmdffsk4qtd42dgiyzwjmxv22xchj5gbuls@sln3lw6x2fkh>
Content-Language: en-US
In-Reply-To: <sxmgk5dskiuq6wdfmdffsk4qtd42dgiyzwjmxv22xchj5gbuls@sln3lw6x2fkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

>
> Hi Jens,
>
> On Mon, Jun 02, 2025 at 02:54:01PM -0600, Jens Axboe wrote:
> > On 6/2/25 9:49 AM, Jens Axboe wrote:
> > > On 6/2/25 9:00 AM, Christoph Hellwig wrote:
> > >> Hi Jens,
> > >>
> > >> I just tried to reference RWF_DONTCACHE semantics in a standards
> > >> discussion, but it doesn't seem to be documented in the man pages
> > >> or in fact anywhere else I could easily find.  Could you please write
> > >> up the semantics for the preadv2/pwritev2 man page?
> > >
> > > Sure, I can write up something for the man page.
> >
> > Adding Darrick as well, as a) he helped review the patches, and b) his
> > phrasing is usually much better than mine.
> >
> > Anyway, here's my first attempt:
> >
> > diff --git a/man/man2/readv.2 b/man/man2/readv.2
> > index c3b0a7091619..2e23e2f15cf4 100644
> > --- a/man/man2/readv.2
> > +++ b/man/man2/readv.2
> > @@ -301,6 +301,28 @@ or their equivalent flags and system calls are used
> >  .B RWF_SYNC
> >  is specified for
> >  .BR pwritev2 ()).
> > +.TP
> > +.BR RWF_DONTCACHE " (since Linux 6.14)"
> > +Reads or writes to a regular file will prune instantiated page cache content
> > +when the operation completes. This is different than normal buffered I/O,
>
> Please use semantic newlines, even for drafts; it makes editing later
> much easier.  See man-pages(7):
>
> $ MANWIDTH=72 man man-pages | sed -n '/Use semantic newlines/,/^$/p'
>    Use semantic newlines
>      In the source of a manual page, new sentences should be started on
>      new lines, long sentences should be split  into  lines  at  clause
>      breaks  (commas,  semicolons, colons, and so on), and long clauses
>      should be split at phrase boundaries.  This convention,  sometimes
>      known as "semantic newlines", makes it easier to see the effect of
>      patches, which often operate at the level of individual sentences,
>      clauses, or phrases.
>
> And a quote from Brian W. Kernighan about preparing documents:
>
>     Brian W. Kernighan, 1974 [UNIX For Beginners]:
>
>     [
>     Hints for Preparing Documents
>
>     Most documents go through several versions
>     (always more than you expected)
>     before they are finally finished.
>     Accordingly,
>     you should do whatever possible
>     to make the job of changing them easy.
>
>     First,
>     when you do the purely mechanical operations of typing,
>     type so subsequent editing will be easy.
>     Start each sentence on a new line.
>     Make lines short,
>     and break lines at natural places,
>     such as after commas and semicolons,
>     rather than randomly.
>     Since most people change documents
>     by rewriting phrases and
>     adding, deleting and rearranging sentences,
>     these precautions simplify any editing you have to do later.
>     ]
>
> > +where the data usually remains in cache until such time that it gets reclaimed
> > +due to memory pressure. If ranges of the read or written I/O was already in
>
> s/was/were/
>
> > +cache before this read or write, then those range will not be pruned at I/O
>
> s/range/&s/
>
> > +completion time. Additionally, any range dirtied by a write operation with
> > +.B RWF_DONTCACHE
> > +set will get kicked off for writeback. This is similar to calling
> > +.BR sync_file_range (2)
> > +with
> > +.IR SYNC_FILE_RANGE_WRITE
> > +to start writeback on the given range.
> > +.B RWF_DONTCACHE
> > +is a hint, or best effort, where no hard guarantees are given on the state of
> > +the page cache once the operation completes.
>
>
> > +Note: file systems must support
> > +this feature as well.
>
> I'd remove the sentence above.  It's redundant with the following one.
> Also, to give it more visibility, and because it's not connected with
> the preceding text, I'd move it to a new paragraph with '.IP'.
>
> Other than this comments, the text looks good to me.  Thanks!

I kind of walked away from this one as I didn't have time or motivation
to push it forward. FWIW, if you want to massage it into submission
that'd be greatly appreciated. I'm not a regular man page contributor
nor do I aim to be, but I do feel like we should this feature
documented.

-- 
Jens Axboe


