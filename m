Return-Path: <linux-fsdevel+bounces-25114-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94147949405
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 16:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40C9D286EE3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 14:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FFCA201264;
	Tue,  6 Aug 2024 14:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kJ8+MWlc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA161D54FB
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Aug 2024 14:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722956278; cv=none; b=BzyTlsl2zT/s8VsvyXxALDkAGUlFT++9j8MolHNMU+lWOj/Tr3YQsBoWwCurodxubECGXuCfcveu7fbixT/M79frvCyJ4PAKsHmxEsRm9s8M9TtEDKCwN/cpmW2m40G4X7FcKKapbgDuPNtWTxfq+JaQ3i/X30hwW1ROc7QZ5SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722956278; c=relaxed/simple;
	bh=LfpzShAyeNELlhl6sJGsGOaiZWVoZj0XRaDh5NkoP+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A4jN3na+TuZP28XkTNX6Vg/Us0ijecO5BpD9i9khQbl3JGG/lFYcyNhM2MPqrE0MJuNFDtPQEBEUcCWBkm7mwXGzMiesRLbzDLSH4KCE1MTu8Bo13NECDW5F46h26YsKtEGtwDJJ42rI9q9d3WPT/ERLlkWA86cQF8V2ZhFZmM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kJ8+MWlc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9080EC4AF09;
	Tue,  6 Aug 2024 14:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722956278;
	bh=LfpzShAyeNELlhl6sJGsGOaiZWVoZj0XRaDh5NkoP+Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kJ8+MWlclDDcYMbrkMWbVHlm4b171xZrjW3TsN31c9tYW7sIn3cBNHKKJ0DaGRzqG
	 3XoPf6bPcBPhnvFM2mGy0mAPIVKtnNldfKd3w+rBFXzkuhEVTQtiWWSCN4pY8moOJt
	 o49YOcmhJbOsDeEiCykgYPlLNtkzzoikjqjHrvgoTqfs0F8Pmv6Vk2BtqhrLPFZRBi
	 vUb9LK0LNUD7Oq3uQeUnRMloG5jw6D75ijTwpxZ9tp266rwjmi50M5ljHahqZ2b7OU
	 iMpWR1bTibykxC4/JLIU1Y5mjj+654RgASlZOG1JoG/cRZNluO4hK+Rz4iLzdRQKnI
	 yClnThdwdhYkg==
Date: Tue, 6 Aug 2024 16:57:54 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Yafang Shao <laoar.shao@gmail.com>, viro@zeniv.linux.org.uk, 
	linux-fsdevel@vger.kernel.org, Dave Chinner <david@fromorbit.com>, 
	Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH] fs: Add a new flag RWF_IOWAIT for preadv2(2)
Message-ID: <20240806-aufmerksam-unwichtig-bae658728387@brauner>
References: <20240804080251.21239-1-laoar.shao@gmail.com>
 <20240805134034.mf3ljesorgupe6e7@quack3>
 <CALOAHbCor0VoCNLACydSytV7sB8NK-TU2tkfJAej+sAvVsVDwA@mail.gmail.com>
 <20240806132432.jtdlv5trklgxwez4@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240806132432.jtdlv5trklgxwez4@quack3>

On Tue, Aug 06, 2024 at 03:24:32PM GMT, Jan Kara wrote:
> On Tue 06-08-24 19:54:58, Yafang Shao wrote:
> > On Mon, Aug 5, 2024 at 9:40 PM Jan Kara <jack@suse.cz> wrote:
> > > On Sun 04-08-24 16:02:51, Yafang Shao wrote:
> > > > Background
> > > > ==========
> > > >
> > > > Our big data workloads are deployed on XFS-based disks, and we frequently
> > > > encounter hung tasks caused by xfs_ilock. These hung tasks arise because
> > > > different applications may access the same files concurrently. For example,
> > > > while a datanode task is writing to a file, a filebeat[0] task might be
> > > > reading the same file concurrently. If the task writing to the file takes a
> > > > long time, the task reading the file will hang due to contention on the XFS
> > > > inode lock.
> > > >
> > > > This inode lock contention between writing and reading files only occurs on
> > > > XFS, but not on other file systems such as EXT4. Dave provided a clear
> > > > explanation for why this occurs only on XFS[1]:
> > > >
> > > >   : I/O is intended to be atomic to ordinary files and pipes and FIFOs.
> > > >   : Atomic means that all the bytes from a single operation that started
> > > >   : out together end up together, without interleaving from other I/O
> > > >   : operations. [2]
> > > >   : XFS is the only linux filesystem that provides this behaviour.
> > > >
> > > > As we have been running big data on XFS for years, we don't want to switch
> > > > to other file systems like EXT4. Therefore, we plan to resolve these issues
> > > > within XFS.
> > > >
> > > > Proposal
> > > > ========
> > > >
> > > > One solution we're currently exploring is leveraging the preadv2(2)
> > > > syscall. By using the RWF_NOWAIT flag, preadv2(2) can avoid the XFS inode
> > > > lock hung task. This can be illustrated as follows:
> > > >
> > > >   retry:
> > > >       if (preadv2(fd, iovec, cnt, offset, RWF_NOWAIT) < 0) {
> > > >           sleep(n)
> > > >           goto retry;
> > > >       }
> > > >
> > > > Since the tasks reading the same files are not critical tasks, a delay in
> > > > reading is acceptable. However, RWF_NOWAIT not only enables IOCB_NOWAIT but
> > > > also enables IOCB_NOIO. Therefore, if the file is not in the page cache, it
> > > > will loop indefinitely until someone else reads it from disk, which is not
> > > > acceptable.
> > > >
> > > > So we're planning to introduce a new flag, IOCB_IOWAIT, to preadv2(2). This
> > > > flag will allow reading from the disk if the file is not in the page cache
> > > > but will not allow waiting for the lock if it is held by others. With this
> > > > new flag, we can resolve our issues effectively.
> > > >
> > > > Link: https://lore.kernel.org/linux-xfs/20190325001044.GA23020@dastard/ [0]
> > > > Link: https://github.com/elastic/beats/tree/master/filebeat [1]
> > > > Link: https://pubs.opengroup.org/onlinepubs/009695399/functions/read.html [2]
> > > > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > > > Cc: Dave Chinner <david@fromorbit.com>
> > >
> > > Thanks for the detailed explanation! I understand your problem but I have to
> > > say I find this flag like a hack to workaround particular XFS behavior and
> > > the guarantees the new RWF_IOWAIT flag should provide are not very clear to
> > > me.
> > 
> > Its guarantee is clear:
> > 
> >   : I/O is intended to be atomic to ordinary files and pipes and FIFOs.
> >   : Atomic means that all the bytes from a single operation that started
> >   : out together end up together, without interleaving from other I/O
> >   : operations.
> 
> Oh, I understand why XFS does locking this way and I'm well aware this is
> a requirement in POSIX. However, as you have experienced, it has a
> significant performance cost for certain workloads (at least with simple
> locking protocol we have now) and history shows users rather want the extra
> performance at the cost of being a bit more careful in userspace. So I
> don't see any filesystem switching to XFS behavior until we have a
> performant range locking primitive.
> 
> > What this flag does is avoid waiting for this type of lock if it
> > exists. Maybe we should consider a more descriptive name like
> > RWF_NOATOMICWAIT, RWF_NOFSLOCK, or RWF_NOPOSIXWAIT? Naming is always
> > challenging.
> 
> Aha, OK. So you want the flag to mean "I don't care about POSIX read-write
> exclusion". I'm still not convinced the flag is a great idea but
> RWF_NOWRITEEXCLUSION could perhaps better describe the intent of the flag.

I have to say that I find this extremely hard to swallow because it so
clearly specific to an individual filesystem. If we're doing this hack I
would like an Ack from at least both Jan and Dave.

