Return-Path: <linux-fsdevel+bounces-11070-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65458850C90
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 02:20:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9589282178
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 01:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06772186A;
	Mon, 12 Feb 2024 01:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="SbCx1apg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD12010E5
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 01:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707700839; cv=none; b=IOPH92Z9An88ye3+ZBSTOoQcW4dm5JTJfzMSm6HT210BCszy5ZDh2H3dVmOwk/lCOLa94nXN2wO6O2iI5IykfesVFL0ThpGZsMLb0d4ZowaYjl8k/Iruuamc7bnAZpU1ijXzVLFkQ7ZCFLqSbhWjGEpwMAvSKp8U/TLu1sQabCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707700839; c=relaxed/simple;
	bh=wDcUhjrTQZPu8z/JAkGDMsJt9THVLpZug+lY5NDZnKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j+wVThCI5a9GQxnSQmVXLmXRg2K1GAErAKmPleZtHZ3sPVeyonB/GVddLUBcKc/S3dWm8fP7cg+XA/3C1ap6pv8ePd2Pjddbm3091Bc1hmOgvoP+hlyAb0k3hRGXqNDs/Avsljn0SDTECkydLnLzeDnRxpUfkVuVfK47NpZj3fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=SbCx1apg; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2184133da88so1709497fac.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 11 Feb 2024 17:20:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1707700836; x=1708305636; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zGpbWcfwQU4LVqL/ANKrblaGXAW8mRNF+7w5voOO+QQ=;
        b=SbCx1apg9qsZjUf/CV7Bfd2WWPF/6gi/JqWMVEip/dwtU1HP+kWANMmXFLAIjSLBdm
         /5F/D6ZFpMF40LN7nyp1VynNvF4Rn17G0CtGynTrtkRYUO88uLNZwPdkhQfLvWzKVgSt
         uM/rqQSY7ITu7YC1gzVwrNGp90cFeSekXrtR2A7BRNNgeEW9J3Ln30dH/tA5UdnubK6M
         Kq7fqn5oYzpVrM+4QcMhTugFn8tpGJRy0ksLZw2/QAERF6rwxMjOQI/K9fHSi66EqGTb
         XjfJDG76S2/mi5lh763YNmVU5AIbyspZWHEu55T7Q2FsSMdsmMKmsdVVJml+Z2dlKMa+
         QCYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707700836; x=1708305636;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zGpbWcfwQU4LVqL/ANKrblaGXAW8mRNF+7w5voOO+QQ=;
        b=lbHg+zE9Y/mIB7NQlOs5isBp6V7/Uidg6Mu/T2oUw1pIlrvML9vfqKx67SDaZvFfNX
         h9gGXaR99uSag+vZo16lWmqnybTw/8G6jEIsZMsnbE/mDFdGAfAGyM24w4ARbkjzLsy7
         0Rxv+kEukLhKAVTRRiLP//4XQndjqXOkIBJDgXHdVgIjVl+jdnCx3zMN70bJRO/pd31O
         O9luR4VnevpNDjrGM7f2hnBpPv4LIzDTXhAWsabWGa0NJH0eeVkrqyBnk1V+IpuHRwRP
         YLaCcFBSCiV5TMzeaxeWRQ7uae0R6e/fSNQpy8YG8UYER1m+6yUChCuRpISYtfqtr25r
         hg0A==
X-Gm-Message-State: AOJu0Yw8xIFD7AyIoqtGJTSVoD1Z4Y1cCzs2A9bJI/sOH341hL767tnr
	GCxfO8HvoNvAqVZrl29LMpe1rHMZ35UCN6ulQ+Mh0PYYKlLZG5vrTrpZmn4qmoU=
X-Google-Smtp-Source: AGHT+IGgzZfJ5MrlRBimvLaq2eWIMRYS7eIl1L8FsxbVpNRlgcJNKvUgAVQugoKnaLI/DUbFaYMsZQ==
X-Received: by 2002:a05:6870:fba4:b0:219:d60e:92c2 with SMTP id kv36-20020a056870fba400b00219d60e92c2mr7064846oab.34.1707700836697;
        Sun, 11 Feb 2024 17:20:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXZDYUZSbhur42pGyKP46OTNJeg9O4vyN0rt5q6Db4n5o1xjnjmewhgy5pjV8Yka3kQcDvepjkHZ2eUjCzj7I3RwflAA2aA1GqWmpBsTqeQnZY1o7PP8fyNYN0e2tiPlEza3YG2aGjFQs8R+hQWspLhBEtJhRVvjuBw3q08pTUtxMBArQxIYC2gIIH579/1f4YYP3wGpIjGBileEZz2C2Ua2g7XUbnplD7CodPEopniMvSmtGoCnO6Mimpp362/ccVIJBT/u7Zc0nIndQ8kpzwyzbKzmqZYDqnqClLqXU0+/Hexp8cbhuZfHzL0aN+G70o7OdvEAEKw+3iIYBB5jLVfKnecAka+v6fXgzEGxHq4/P09A1UCkIouwY1E+25n139b4SRX4MkLZg==
Received: from dread.disaster.area (pa49-181-38-249.pa.nsw.optusnet.com.au. [49.181.38.249])
        by smtp.gmail.com with ESMTPSA id j17-20020a635951000000b005d8b2f04eb7sm5604643pgm.62.2024.02.11.17.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 17:20:35 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rZKzo-005HoK-1j;
	Mon, 12 Feb 2024 12:20:32 +1100
Date: Mon, 12 Feb 2024 12:20:32 +1100
From: Dave Chinner <david@fromorbit.com>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>, Matthew Wilcox <willy@infradead.org>,
	lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-block@vger.kernel.org,
	linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Kent Overstreet <kent.overstreet@gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Removing GFP_NOFS
Message-ID: <ZclyYBO0vcQHZ5dV@dread.disaster.area>
References: <ZZcgXI46AinlcBDP@casper.infradead.org>
 <ZZzP6731XwZQnz0o@dread.disaster.area>
 <3ba0dffa-beea-478f-bb6e-777b6304fb69@kernel.org>
 <ZcUQfzfQ9R8X0s47@tiehlicka>
 <3aa399bb-5007-4d12-88ae-ed244e9a653f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3aa399bb-5007-4d12-88ae-ed244e9a653f@kernel.org>

On Thu, Feb 08, 2024 at 08:55:05PM +0100, Vlastimil Babka (SUSE) wrote:
> On 2/8/24 18:33, Michal Hocko wrote:
> > On Thu 08-02-24 17:02:07, Vlastimil Babka (SUSE) wrote:
> >> On 1/9/24 05:47, Dave Chinner wrote:
> >> > On Thu, Jan 04, 2024 at 09:17:16PM +0000, Matthew Wilcox wrote:
> >> 
> >> Your points and Kent's proposal of scoped GFP_NOWAIT [1] suggests to me this
> >> is no longer FS-only topic as this isn't just about converting to the scoped
> >> apis, but also how they should be improved.
> > 
> > Scoped GFP_NOFAIL context is slightly easier from the semantic POV than
> > scoped GFP_NOWAIT as it doesn't add a potentially unexpected failure
> > mode. It is still tricky to deal with GFP_NOWAIT requests inside the
> > NOFAIL scope because that makes it a non failing busy wait for an
> > allocation if we need to insist on scope NOFAIL semantic. 
> > 
> > On the other hand we can define the behavior similar to what you
> > propose with RETRY_MAYFAIL resp. NORETRY. Existing NOWAIT users should
> > better handle allocation failures regardless of the external allocation
> > scope.
> > 
> > Overriding that scoped NOFAIL semantic with RETRY_MAYFAIL or NORETRY
> > resembles the existing PF_MEMALLOC and GFP_NOMEMALLOC semantic and I do
> > not see an immediate problem with that.
> > 
> > Having more NOFAIL allocations is not great but if you need to
> > emulate those by implementing the nofail semantic outside of the
> > allocator then it is better to have those retries inside the allocator
> > IMO.
> 
> I see potential issues in scoping both the NOWAIT and NOFAIL
> 
> - NOFAIL - I'm assuming Dave is adding __GFP_NOFAIL to xfs allocations or
> adjacent layers where he knows they must not fail for his transaction. But
> could the scope affect also something else underneath that could fail
> without the failure propagating in a way that it affects xfs?

Memory allocaiton failures below the filesystem (i.e. in the IO
path) will fail the IO, and if that happens for a read IO within
a transaction then it will have the same effect as XFS failing a
memory allocation. i.e. it will shut down the filesystem.

The key point here is the moment we go below the filesystem we enter
into a new scoped allocation context with a guaranteed method of
returning errors: NOIO and bio errors.

Once we cross an allocation scope boundary, NOFAIL is no
longer relevant to the code that is being run because there are
other errors that can occur that the filesysetm must handle
that. Hence memory allocation errors just don't matter at this
point, and the NOFAIL constraint is no longer relevant.

Hence we really need to conside NOFAIL differently to NOFS/NOIO.
NOFS/NOIO are about avoiding reclaim recursion deadlocks, so are
relevant all the way down the stack. NOFAIL is only relevant to a
specific subsystem to prevent subsystem allocations from failing,
but as soon as we cross into another subsystem that can (and does)
return errors for memory allocation failures, the NOFAIL context is
no longer relevant.

i.e NOFAIL scopes are not relevant outside the subsystem that sets
it.  Hence we likely need helpers to clear and restore NOFAIL when
we cross an allocation context boundaries. e.g. as we cross from
filesystem to block layer in the IO stack via submit_bio(). Maybe
they should be doing something like:

	nofail_flags = memalloc_nofail_clear();
	noio_flags = memalloc_noio_save();

	....

	memalloc_noio_restore(noio_flags);
	memalloc_nofail_reinstate(nofail_flags);

> Maybe it's a
> high-order allocation with a low-order fallback that really should not be
> __GFP_NOFAIL? We would need to hope it has something like RETRY_MAYFAIL or
> NORETRY already. But maybe it just relies on >costly order being more likely
> to fail implicitly, and those costly orders should be kept excluded from the
> scoped NOFAIL? Maybe __GFP_NOWARN should also override the scoped nofail?

We definitely need NORETRY/RETRY_MAYFAIL to override scoped NOFAIL
at the filesystem layer (e.g. for readahead buffer allocations,
xlog_kvmalloc(), etc to correctly fail fast within XFS
transactions), but I don't think we should force every subsystem to
have to do this just in case a higher level subsystem had a scoped
NOFAIL set for it to work correctly.

> - NOWAIT - as said already, we need to make sure we're not turning an
> allocation that relied on too-small-to-fail into a null pointer exception or
> BUG_ON(!page).

Agreed. NOWAIT is removing allocation failure constraints and I
don't think that can be made to work reliably. Error injection
cannot prove the absence of errors  and so we can never be certain
the code will always operate correctly and not crash when an
unexepected allocation failure occurs.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

