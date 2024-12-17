Return-Path: <linux-fsdevel+bounces-37611-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCCA49F44CF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 08:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EE6A16103B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 07:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396C9653;
	Tue, 17 Dec 2024 07:08:54 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2841814F9FF;
	Tue, 17 Dec 2024 07:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734419333; cv=none; b=XNQeWn+a5YfJmAXzFt058fEVDbl/YC3wzMOBs4uUw2IuyHvcAEqD70rcDJQ1sAGneQP8m5F6kQjxpflEtxAItdAeVqkj5S6n9H/J5oiJwKNEosICWp22WMc/zCXsjmgtdVmp+/197R/v/WmKcweh28ekCQehct7VkSf6DN/hckc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734419333; c=relaxed/simple;
	bh=cTGL2MgAvjT/VcTus4jDUkzAYGM7RM1d1PRC/IA0Tl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NWWucAaLujC3rdiRJb53WNgY898O5BH0+RXTgekFiv9t5+opsrZAydewaRtZqhqm+g+rckniMc09fTy5O9yJRti9U76/wbjPWlB3aOKGnmmI9zc13wobGPhZN3J2YLIk30v6DJKIssvY3OIHK/JvA3ZUoIJF6GuNaefMeMO27ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id A62BE68B05; Tue, 17 Dec 2024 08:08:45 +0100 (CET)
Date: Tue, 17 Dec 2024 08:08:45 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, John Garry <john.g.garry@oracle.com>,
	brauner@kernel.org, cem@kernel.org, dchinner@redhat.com,
	ritesh.list@gmail.com, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	martin.petersen@oracle.com
Subject: Re: [PATCH v2 2/7] iomap: Add zero unwritten mappings dio support
Message-ID: <20241217070845.GA19358@lst.de>
References: <20241210125737.786928-1-john.g.garry@oracle.com> <20241210125737.786928-3-john.g.garry@oracle.com> <20241211234748.GB6678@frogsfrogsfrogs> <4d34e14f-6596-483b-86e8-d4b7e44acd9a@oracle.com> <20241212204007.GL6678@frogsfrogsfrogs> <20241213144740.GA17593@lst.de> <20241214005638.GJ6678@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241214005638.GJ6678@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Dec 13, 2024 at 04:56:38PM -0800, Darrick J. Wong wrote:
> > > "If you receive -EBADMAP, then call fallocate(FALLOC_FL_MAKE_OVERWRITE)
> > > to force all the mappings to pure overwrites."
> > 
> > Ewwwwwwwwwwwwwwwwwwwww.
> > 
> > That's not a sane API in any way.
> 
> Oh I know, I'd much rather stick to the view that block untorn writes
> are a means for programs that only ever do IO in large(ish) blocks to
> take advantage of a hardware feature that also wants those large
> blocks.

I (vaguely) agree ith that.

> And only if the file mapping is in the correct state, and the
> program is willing to *maintain* them in the correct state to get the
> better performance.

I kinda agree with that, but the maintain is a bit hard as general
rule of thumb as file mappings can change behind the applications
back.  So building interfaces around the concept that there are
entirely stable mappings seems like a bad idea.

> I don't want xfs to grow code to write zeroes to
> mapped blocks just so it can then write-untorn to the same blocks.

Agreed.


