Return-Path: <linux-fsdevel+bounces-27610-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA480962D50
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 18:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 293DBB22B3C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 16:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73CA31A3BB3;
	Wed, 28 Aug 2024 16:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YDMdtMJP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50CF13775E;
	Wed, 28 Aug 2024 16:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724861405; cv=none; b=BWjBEMHiNX35tNzzFZGKe4BQhhIqMWhRNOeD3mbdC6n971nqwWUfMD1jcZp+RmTBS5jgA72NEINM4bC/nh/xRnkoSAM4C6APz8us9XwJYEbhuMDCsC+OwEQcEmo1zM2/P9Bd6Ihq931E23+VnZvnnvp4U2892RsY1pvmDT9qfZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724861405; c=relaxed/simple;
	bh=5gCyXX8Bq2vU6a/ioVEkb49fxdLAIegxKwjcc6pXyT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e5TXbEK7Lcafg/C45JJj7/1iLnkpTVqcX1+IqMEgFIuTBULc8fHjDc111Ro+vID8aj+iWQeC/BbDfesVEjIotBZGJ2L9f3NpGVQNt5lGZpVHXtMan4AR8gnLMXSEk9pduEs4A95BLl0PruWsk/sNtBJrMt1U8iHEVFKZnXG1Kb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YDMdtMJP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 513F1C4CED8;
	Wed, 28 Aug 2024 16:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724861405;
	bh=5gCyXX8Bq2vU6a/ioVEkb49fxdLAIegxKwjcc6pXyT0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YDMdtMJPVO8SYN2blFJyFvekwizxL0U/Bt8OQiBLIO59Ajl9kWY4a5U1/RfrKXhLE
	 br3+epEu0CLZDR7haYWCtaEkBvWkb+9IZJK1VQkSiYPURrduls9OKOBV163JpAsJRF
	 V9LQyldInlcY5WE5/8JgHvm6hZ9BS1Fs3iQYkZYJ9Q0GGzo3F4wwXUObSyJsrYx1Ia
	 XcwDFhMkwBX8eHqZAJ99Kny74k9F3lFQxflcbNbU0kqqDGeB21w4O1J0f90EFJuXqb
	 6Hmyh/kibnx3qKRSXieNYpa3Cooo+Iz4QH1KeRbY+7yj3vZyEOl5sgPo4KaJu4JEdi
	 UC9jPssea/vJw==
Date: Wed, 28 Aug 2024 09:10:04 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/5] xfs: move the tagged perag lookup helpers to
 xfs_icache.c
Message-ID: <20240828161004.GG1977952@frogsfrogsfrogs>
References: <20240821063901.650776-1-hch@lst.de>
 <20240821063901.650776-3-hch@lst.de>
 <20240821163407.GH865349@frogsfrogsfrogs>
 <Zs7DoMzcyh7QbfUb@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zs7DoMzcyh7QbfUb@infradead.org>

On Tue, Aug 27, 2024 at 11:28:48PM -0700, Christoph Hellwig wrote:
> On Wed, Aug 21, 2024 at 09:34:07AM -0700, Darrick J. Wong wrote:
> > I don't particularly like moving these functions to another file, but I
> > suppose the icache is the only user of these tags.  How hard is it to
> > make userspace stubs that assert if anyone ever tries to use it?
> 
> I looked into not moving them, but the annoying thing is that we then
> need to make the ici_tag_to_mark helper added later and the marks
> global.  Unless this is a blocker for you I'd much prefer to just
> keep all the tag/mark logic contained in icache.c for now.  Things
> might change a bit if/when we do the generic xfs_group and also use
> tags for garbage collection of zoned rtgs, but I'd rather build the
> right abstraction when we get to that.  That will probably also
> include sorting out the current mess with the ICI vs IWALK flags.

Or converting pag_ici_root to an xarray, and then we can make all of
them use the same mark symbols. <shrug>

--D

