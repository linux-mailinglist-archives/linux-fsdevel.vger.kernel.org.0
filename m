Return-Path: <linux-fsdevel+bounces-12524-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D865F8605D4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 23:45:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69196284540
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 22:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C6717C74;
	Thu, 22 Feb 2024 22:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZvjLeczf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87483FBF4
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Feb 2024 22:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708641944; cv=none; b=ghbQIkan9chiMsk1dyfg8TJM4+meP2XqsoY6MJuL7bRRnTlEnwQR93T0GzHPxPLqtcfhzCWykVCLIPfYvK5OTDsnLga1/yJioftMPKlqcso5mpf8OknBFTzaCIXXC7xvHGUUhVH1ieaWGUZGDh1+xxk+neW+2rU/vhs/EII0XGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708641944; c=relaxed/simple;
	bh=kmJAjR+7ZTgtiQN/s7z+cBHgMau140oHAN6WUoLV83A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eaMXMDSbsqVpf7aolTMPjWA4eU+mxwZsflE5AFwaDr63WQSJrWb0nofk4AV73aLDof1u7WskD3A/WcWjQ/v3A1T7M6hzSVStDDkkUfsqEhO4fiUSKxLSgCSvabABMuQBIyjB2ZUIZu24wDLMuDnKI43OPRa0M3+Z0Cr0TyVy1g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZvjLeczf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D5D8C433A6
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Feb 2024 22:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708641944;
	bh=kmJAjR+7ZTgtiQN/s7z+cBHgMau140oHAN6WUoLV83A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZvjLeczfaD+ARQ8sOt/1pzJbwDndoezg6YvfHkTFYpPvzhp3J3p/+OBfPmACWy7ws
	 EumZY9U8710GY16/4CUlxfZh2WA4Lg2dFqAwkiCDDzYBpYBfI/h27AcLUGGaofO1rz
	 oIxoKJXiSBW+thtGEtw8NG8zz1nrWMKDeCyXhqQJAf4GA3Bef6szc6TCFBpZDaOB1+
	 YTcZ4HCqGU+cWFQhi9ykBUYJU6XWpFEKqTp/TLiITg4A9zy6dzrBnvD9H46Ltocj/x
	 IKIj3evzw7Ik9bbBMS5kuPBaDnoW7/8HOUNJfQnDfSIXFnt7aO6Rj8BWMi3epgpvsO
	 iysiTER08D7Ig==
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7bc32b0fdadso9202839f.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Feb 2024 14:45:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUpQWJ2kz8ox3OSG4wjHv1E9LI/h4AZ6vVZE94Jibsc8R/rCyUpeZBW1DUBxTdIwY3CdT8UykjlnCA25ckUhYZN+LlOk+TFbjYWAM8XyA==
X-Gm-Message-State: AOJu0YzH3B7E/NtHIaB0ncAdGyDnalU7Y+SVvCRrm4TUJciVkFVczN8o
	iwnQZ7zVhVzO6OBSkYRQ4/oiDnVZlEx9Km87D2aug6NW7OP5BJ25dEqxRxmEw9VIR2LI23/WkiL
	tijC6I4uL+GP9OETNEUTE6IdqlJFZLqn7QevL
X-Google-Smtp-Source: AGHT+IH/pp2pGlKmyFGqyB7/Jec48p2xPhDOGpbe89kkOgM/DKmGX79GlR+z+BxAPG4u9xYopEFeJcXMcXT0vtDqSEQ=
X-Received: by 2002:a92:d58d:0:b0:365:41b5:b3c4 with SMTP id
 a13-20020a92d58d000000b0036541b5b3c4mr376244iln.18.1708641943304; Thu, 22 Feb
 2024 14:45:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2701740.1706864989@warthog.procyon.org.uk>
In-Reply-To: <2701740.1706864989@warthog.procyon.org.uk>
From: Chris Li <chrisl@kernel.org>
Date: Thu, 22 Feb 2024 14:45:30 -0800
X-Gmail-Original-Message-ID: <CAF8kJuNt2Vqk0yGkuz7qHAui7tb9B1W6U+SLyTmc6N2ngCU53A@mail.gmail.com>
Message-ID: <CAF8kJuNt2Vqk0yGkuz7qHAui7tb9B1W6U+SLyTmc6N2ngCU53A@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Large folios, swap and fscache
To: David Howells <dhowells@redhat.com>
Cc: lsf-pc@lists.linux-foundation.org, Matthew Wilcox <willy@infradead.org>, 
	netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi David,

On Fri, Feb 2, 2024 at 1:10=E2=80=AFAM David Howells <dhowells@redhat.com> =
wrote:
>
> Hi,
>
> The topic came up in a recent discussion about how to deal with large fol=
ios
> when it comes to swap as a swap device is normally considered a simple ar=
ray
> of PAGE_SIZE-sized elements that can be indexed by a single integer.

Sorry for being late for the party. I think I was the one that brought
this topic up in the online discussion with Will and You. Let me know
if you are referring to a different discussion.

>
> With the advent of large folios, however, we might need to change this in
> order to be better able to swap out a compound page efficiently.  Swap
> fragmentation raises its head, as does the need to potentially save multi=
ple
> indices per folio.  Does swap need to grow more filesystem features?

Yes, with a large folio, it is harder to allocate continuous swap
entries where 4K swap entries are allocated and free all the time. The
fragmentation will likely make the swap file have very little
continuous swap entries.

We can change that assumption, allow large folio reading and writing
of discontinued blocks on the block device level. We will likely need
a file system like kind of the indirection layer to store the location
of those blocks. In other words, the folio needs to read/write a list
of io vectors, not just one block.

>
> Further to this, we have at least two ways to cache data on disk/flash/et=
c. -
> swap and fscache - and both want to set aside disk space for their operat=
ion.
> Might it be possible to combine the two?
>
> One thing I want to look at for fscache is the possibility of switching f=
rom a
> file-per-object-based approach to a tagged cache more akin to the way Ope=
nAFS
> does things.  In OpenAFS, you have a whole bunch of small files, each
> containing a single block (e.g. 256K) of data, and an index that maps a
> particular {volume,file,version,block} to one of these files in the cache=
.
>
> Now, I could also consider holding all the data blocks in a single file (=
or
> blockdev) - and this might work for swap.  For fscache, I do, however, ne=
ed to
> have some sort of integrity across reboots that swap does not require.

The main trade off is the memory usage for the meta data and latency
of reading and writing.
The file system has typically a different IO pattern than swap, e.g.
file reads can be batched and have good locality.
Where swap is a lot of random location read/write.

Current swap using array like swap entry, one of the pros of that is
just one IO required for one folio.
The performance gets worse when swap needs to read the metadata first
to locate the block, then read the block of data in.
Page fault latency will get longer. That is one of the trade-offs we
need to consider.

Chris

