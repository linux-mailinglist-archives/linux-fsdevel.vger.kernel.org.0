Return-Path: <linux-fsdevel+bounces-41128-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D5EA2B446
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 22:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A0DC166625
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 21:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09EB1223310;
	Thu,  6 Feb 2025 21:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e5CS08eF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AAC22257E;
	Thu,  6 Feb 2025 21:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738878024; cv=none; b=sMjxOO7evJPsLCymIHl6GLw195L5Vdd+njiIitzCiDBw0/KjRlAN0xx6NjIROOTRWqGSsUztIcZcHV+EldLBB25wUbvuOJFOZ33SvchhTYlt8Derqn0yCJuy6uxmpPEQb2QLiiXZaJabfTkuvAX6fA+8/rKgfGMsLh85VoRlQnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738878024; c=relaxed/simple;
	bh=+dxtXQ6sBVRuyMKiNM+jVz/sx0/ekJ5smXKV4qpc/5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LNECK8K/M7IsDVg1aXReJbDUjTzb/8XYn2zAYAt8flOg1L30stvwv9GPnFg1o7xcmaU1j+MPmniA3A+QY+GS5gr/o3UsDLr7CiOEDF31ulkD4WO40lEqSdjGvWXvpKrKSS4QFik2JIcPCENWjQX6GjkKRm/kq1XJzZDNQHkOhdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e5CS08eF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0F1AC4CEDD;
	Thu,  6 Feb 2025 21:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738878023;
	bh=+dxtXQ6sBVRuyMKiNM+jVz/sx0/ekJ5smXKV4qpc/5Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e5CS08eFTJa0RMVocXfoxlEbbjwPmNMnMGMvn35xrpjYpzGGoTCQWlvW1y0/AberK
	 AF2+ajCCBt77PDiwmREfCE6o2bnUeKvsBzyQGaikECrt/jawFo7vIVaK4NnX07kE4b
	 4Y0MxMqPuxabCNlECTa8N0hVsPa9+LtWogxMgFkufTKw8ZnlR5PyI3JHWNrugliUr/
	 aYHz23ALSM7CaVn1kPEELwK4J7fofDurJdB+wL+7U0Efkkk1hChAZB8BwmcLTwS4WR
	 gmAHGVyyhOLMf/DfBKqc+u+DEMwtj+PgImBUzx3OePpzixKaQdYQWv2L0et1PUsM7u
	 dwwEE+ZNlG99A==
Date: Thu, 6 Feb 2025 13:40:23 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: brauner@kernel.org, cem@kernel.org, dchinner@redhat.com, hch@lst.de,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
	ritesh.list@gmail.com, martin.petersen@oracle.com
Subject: Re: [PATCH RFC 03/10] iomap: Support CoW-based atomic writes
Message-ID: <20250206214023.GV21808@frogsfrogsfrogs>
References: <20250204120127.2396727-1-john.g.garry@oracle.com>
 <20250204120127.2396727-4-john.g.garry@oracle.com>
 <20250205201107.GA21808@frogsfrogsfrogs>
 <6ad6f42a-e3e0-4c13-859c-07f5e7bd5ec8@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ad6f42a-e3e0-4c13-859c-07f5e7bd5ec8@oracle.com>

On Thu, Feb 06, 2025 at 11:21:13AM +0000, John Garry wrote:
> 
> > >   			if (iomi.pos >= dio->i_size ||
> > > diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> > > index 75bf54e76f3b..0a0b6798f517 100644
> > > --- a/include/linux/iomap.h
> > > +++ b/include/linux/iomap.h
> > > @@ -56,6 +56,8 @@ struct vm_fault;
> > >    *
> > >    * IOMAP_F_BOUNDARY indicates that I/O and I/O completions for this iomap must
> > >    * never be merged with the mapping before it.
> > > + *
> > > + * IOMAP_F_ATOMIC_COW indicates that we require atomic CoW end IO handling.
> > 
> > It more indicates that the filesystem is using copy on write to handle
> > an untorn write, and will provide the ioend support necessary to commit
> > the remapping atomically, right?
> 
> yes, correct
> 
> > 
> > >    */
> > >   #define IOMAP_F_NEW		(1U << 0)
> > >   #define IOMAP_F_DIRTY		(1U << 1)
> > > @@ -68,6 +70,7 @@ struct vm_fault;
> > >   #endif /* CONFIG_BUFFER_HEAD */
> > >   #define IOMAP_F_XATTR		(1U << 5)
> > >   #define IOMAP_F_BOUNDARY	(1U << 6)
> > > +#define IOMAP_F_ATOMIC_COW	(1U << 7)
> > >   /*
> > >    * Flags set by the core iomap code during operations:
> > > @@ -183,6 +186,7 @@ struct iomap_folio_ops {
> > >   #define IOMAP_DAX		0
> > >   #endif /* CONFIG_FS_DAX */
> > >   #define IOMAP_ATOMIC		(1 << 9)
> > > +#define IOMAP_ATOMIC_COW	(1 << 10)
> > 
> > What does IOMAP_ATOMIC_COW do?  There's no description for it (or for
> > IOMAP_ATOMIC).
> 
> I'll add a description for both.
> 
> > Can you have IOMAP_ATOMIC and IOMAP_ATOMIC_COW both set?
> 
> Yes
> 
> > Or are they mutually exclusive?
> 
> I am not thinking that it might be neater to have a distinct flag for

"not"?

> IOMAP_ATOMIC when we want to try an atomic bio - maybe IOMAP_ATOMIC_HW or
> IOMAP_ATOMIC_BIO? And then also IOMAP_DIO_ATOMIC_BIO (in addition to
> IOMAP_DIO_ATOMIC_COW).

Yeah, ATOMIC_BIO/ATOMIC_COW is probably clearer both for IOMAP_ and
IOMAP_DIO_ .

--D

> > 
> > I'm guessing from the code that ATOMIC_COW requires ATOMIC to be set,
> > but I wonder why because there's no documentation update in the header
> > files or in Documentation/filesystems/iomap/.
> 
> Will do.
> 
> Thanks,
> John
> 

