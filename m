Return-Path: <linux-fsdevel+bounces-73783-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B2FD2046B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 17:44:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4DF303016677
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 16:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AFA43A4F43;
	Wed, 14 Jan 2026 16:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JYHgkKzY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9C43A7844;
	Wed, 14 Jan 2026 16:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768409022; cv=none; b=NRprvKsmofHSuCR9d9ORTaufnH8jpLlUWzgY9Mf+KtSLtCOtIvVR+UOsLeTRbOk0K+wBVKXkVt40uhU9nmT5YWwiVR+nRnXXSA0siSCuVMofmKLFWPst/szWgXybS7G0QooCB/JTMjgdNcUz/8EEqvPhYzG+Pv8SIixqbYrWqVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768409022; c=relaxed/simple;
	bh=FZ7TMX4k/rIXT+fD6SLYFmrYR5x6uHI19kj0xHyNyIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Js9m+9IRUlzl3X8+SJwgW5B0aSz/XpK5BMsFwPaZ4YO3nPpzXHfZsE+FTMx50Z/03LBATmS1Zra1QqFAlNF1xwFm8j4g4C04+ujftvvbmmTWSvZhJA8m6CaYPsFYsgI7P2XCYtDdMkLNtSv+IjOFeaRefvK5AUys5qblT++HHNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JYHgkKzY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A609EC4CEF7;
	Wed, 14 Jan 2026 16:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768409021;
	bh=FZ7TMX4k/rIXT+fD6SLYFmrYR5x6uHI19kj0xHyNyIU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JYHgkKzYjns804M0XoxMj9pNcNV2y7zfVZjZPUq+RDnImQOhbEVgdY/9vx5l83iN2
	 6Nj6xnaWMD+dIAV6KPdFaeFsC3o+Mi/LXjClmppgpVDJtKXOCE/HuOqdBHFRKtdCri
	 nDYabBXafyUn2fk4+byaufU+hUgK/Ih0dPwChOtF7Yj3jFt4+oHC2JO6PP4T70NDro
	 uROLsWbEoh3HwEcWCKtuhsF3cmDGvCPOU7wiod1mrqmuRCK3c5CSlsOQJP4sVh9uwE
	 w5VkvX+2NfnnYTfmRcWVVncF1jQehWSfy/5qWeWifw/fTjxWQx8FVI1kmLhuITRWHX
	 uiaINJhyUjCPA==
Date: Wed, 14 Jan 2026 08:43:41 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Matthew Wilcox <willy@infradead.org>,
	Andrey Albershteyn <aalbersh@redhat.com>, fsverity@lists.linux.dev,
	linux-xfs@vger.kernel.org, ebiggers@kernel.org,
	linux-fsdevel@vger.kernel.org, aalbersh@kernel.org,
	david@fromorbit.com
Subject: Re: [PATCH v2 4/22] iomap: allow iomap_file_buffered_write() take
 iocb without file
Message-ID: <20260114164341.GP15583@frogsfrogsfrogs>
References: <cover.1768229271.patch-series@thinky>
 <kibhid6bipmrndfn774tlbm6wcitya5qydhjws3n6tnjvbd4a3@bui63p535b3q>
 <20260112222215.GJ15551@frogsfrogsfrogs>
 <20260113081535.GC30809@lst.de>
 <aWZ2RL3oBQGUmLvF@casper.infradead.org>
 <20260114064130.GB10876@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114064130.GB10876@lst.de>

On Wed, Jan 14, 2026 at 07:41:30AM +0100, Christoph Hellwig wrote:
> On Tue, Jan 13, 2026 at 04:43:48PM +0000, Matthew Wilcox wrote:
> > > It's not passed down, but I think it could easily.
> > 
> > willy@deadly:~/kernel/linux$ git grep ki_filp |grep file_inode | wc
> >     109     575    7766
> > willy@deadly:~/kernel/linux$ git grep ki_filp |wc
> >     367    1920   23371
> > 
> > I think there's a pretty strong argument for adding ki_inode to
> > struct kiocb.  What do you think?
> 
> That assumes the reduced pointer dereference is worth bloating the
> structure.  Feel free to give it a try.
> 
> Note that we'd still require the file to be set, otherwise we're
> going to have calling conventions from hell.

I think it makes more sense to make fsverity take the file and pass it
around to the filesystems.  After all, fsverity metadata is just more
file IO, right? :D

--D

