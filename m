Return-Path: <linux-fsdevel+bounces-13209-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C41C486D334
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 20:31:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6AB81C20F3C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 19:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4BB613C9D5;
	Thu, 29 Feb 2024 19:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T0QK7iMm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203D2405F9
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Feb 2024 19:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709235088; cv=none; b=dtxkl45yrXCMOEZBQ8yQxECTJ5odHX5vuaiJESNDSWqYYa9brdGeaqbPMU3tCYY52gF11LNWSCxFd5k9HiVHCvymk/1XuVo3xJCRnEpeK4OJTPP6/gqDP2O+vphLZJEHJ38quv5qoH7QDwBTPXM2WUFZrH8mCEqQRJuNyAXhyRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709235088; c=relaxed/simple;
	bh=vWkgBUl9V8zzq+Ocdi7IrYcPtFJi2zw+v1JOHzEqo48=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S5zUFeCKgFEMXGckWskHSW/+KMaKQUhJotyUF9FkqLV89O5eHjFWtodd3/+hA0P8m3kuR5nBJT7rZFj+eou+bJXBPyvN+DRbkTLoo2KxPgz9EXRFwagGC+ESvNgRLlxHfqA4n7QddDy+SFXw0VlJFBALGIRdTZP5Za9HUmtTWEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T0QK7iMm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA51EC433F1
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Feb 2024 19:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709235087;
	bh=vWkgBUl9V8zzq+Ocdi7IrYcPtFJi2zw+v1JOHzEqo48=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=T0QK7iMmnIMQAAzwQQYUdE6gKmyi6z+bzapH7Rl4ZjO6AdOAkSzrDIjtDqDueVEUe
	 FgiPdNifjWHFscJTf6mjxVn7B0n9XTNkU2ZpC5bfunTMN7sl/pnvhyY6NNX8dMozuO
	 rZfhptBM6IAdk/3tj++AM3ZgarLM9eupUSoGzQBUYp5EPVgnlL9iSVwD1EPTDc3tNs
	 X7EsXXZna1CuAXGyQ5bmmVhkqZNkef2/AfXOPMzz4HxS2F7ky0mVXyUGpzPsPEW7xm
	 /pXEzWAuSxApAPBNUa88UrHb0vnFpwoIgxPVVquDLFrgp43braaCsi+JSup7KUMML1
	 ZMjlq0FIbrSuA==
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3651edae0a1so5047735ab.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Feb 2024 11:31:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXNoC219kYKqy+C+hiWqof0PbY+TN04XZPAZXiUh6/0FWC9lBYcYQEjjkuO10KtA7VKe1TXdzB98wGjhj5tYicR12SxQKTl2N1zX75pkw==
X-Gm-Message-State: AOJu0YwEjYQ/YBeFrELJVmyKKabDuFREZZ7CJZscxBvvJJz0sayx6al3
	SbeW54Ffai/KvBSU+jbuoxdMQBq0XNWnBF4p839/vwAvQfQYsAOX6tEV12b1m5RKE+qwrn2EZU2
	uHauP8eNk+8ei0+e/ef2AHoDSwYVwqWoKwnX/
X-Google-Smtp-Source: AGHT+IH6o1VRdbbDzmd2S/3gNApCVNErtkJIbssEMM6NS3pyBNfgv/MJuH86kMdZTJwgpBlSB1Gkw+XY38lp47zNsTc=
X-Received: by 2002:a92:c245:0:b0:365:1b7c:670 with SMTP id
 k5-20020a92c245000000b003651b7c0670mr11943ilo.8.1709235086020; Thu, 29 Feb
 2024 11:31:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2701740.1706864989@warthog.procyon.org.uk> <Zbz8VAKcO56rBh6b@casper.infradead.org>
In-Reply-To: <Zbz8VAKcO56rBh6b@casper.infradead.org>
From: Chris Li <chrisl@kernel.org>
Date: Thu, 29 Feb 2024 11:31:12 -0800
X-Gmail-Original-Message-ID: <CAF8kJuNtbE3qEf=of1KQj=tNobWCz4A48FpVRUU6osvtt88jPw@mail.gmail.com>
Message-ID: <CAF8kJuNtbE3qEf=of1KQj=tNobWCz4A48FpVRUU6osvtt88jPw@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Large folios, swap and fscache
To: Matthew Wilcox <willy@infradead.org>
Cc: David Howells <dhowells@redhat.com>, lsf-pc@lists.linux-foundation.org, 
	netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matthew,

On Fri, Feb 2, 2024 at 6:29=E2=80=AFAM Matthew Wilcox <willy@infradead.org>=
 wrote:
>
> On Fri, Feb 02, 2024 at 09:09:49AM +0000, David Howells wrote:
> > The topic came up in a recent discussion about how to deal with large f=
olios
> > when it comes to swap as a swap device is normally considered a simple =
array
> > of PAGE_SIZE-sized elements that can be indexed by a single integer.
> >
> > With the advent of large folios, however, we might need to change this =
in
> > order to be better able to swap out a compound page efficiently.  Swap
> > fragmentation raises its head, as does the need to potentially save mul=
tiple
> > indices per folio.  Does swap need to grow more filesystem features?
>
> I didn't mention this during the meeting, but there are more reasons
> to do something like this.  For example, even with large folios, it
> doesn't make sense to drive writing to swap on a per-folio basis.  We
> should be writing out large chunks of virtual address space in a single
> write to the swap device, just like we do large chunks of files in
> ->writepages.

I have thought about your proposal after the THP meeting. One
observation is that the swap write and swap read has some asymmetries.
For swap read, you always know which vma you are reading into.
However, the swap write that is based on the LRU list,
(shrink_folio_list) does not have the vma information in hand.
Actually the same folio might map by two different processes. It would
need to do the rmap walk to find out the VMA. So organizing the swap
write around VMA mapping is not convenient for the LRU reclaim write
back case.

Chris


> Another reason to do something different is that we're starting to see
> block devices with bs>PS.  That means we'll _have_ to write out larger
> chunks than a single page.  For reads, we can discard the extra data,
> but it'd be better to swap back in the entire block rather than
> individual pages.
>
> So my modest proposal is that we completely rearchitect how we handle
> swap.  Instead of putting swp entries in the page tables (and in shmem's
> case in the page cache), we turn swap into an (object, offset) lookup
> (just like a filesystem).  That means that each anon_vma becomes its
> own swap object and each shmem inode becomes its own swap object.
> The swap system can then borrow techniques from whichever filesystem
> it likes to do (object, offset, length) -> n x (device, block) mappings.
>
> > Further to this, we have at least two ways to cache data on disk/flash/=
etc. -
> > swap and fscache - and both want to set aside disk space for their oper=
ation.
> > Might it be possible to combine the two?
> >
> > One thing I want to look at for fscache is the possibility of switching=
 from a
> > file-per-object-based approach to a tagged cache more akin to the way O=
penAFS
> > does things.  In OpenAFS, you have a whole bunch of small files, each
> > containing a single block (e.g. 256K) of data, and an index that maps a
> > particular {volume,file,version,block} to one of these files in the cac=
he.
>
> I think my proposal above works for you?  For each file you want to cache=
,
> create a swap object, and then tell swap when you want to read/write to
> the local swap object.  What you do need is to persist the objects over
> a power cycle.  That shouldn't be too hard ... after all, filesystems
> manage to do it.  All we need to do is figure out how to name the
> lookup (I don't think we need to use strings to name the swap object,
> but obviously we could).  Maybe it's just a stream of bytes.
>

