Return-Path: <linux-fsdevel+bounces-67137-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2EBC35FD3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 15:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8C4844F0052
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 14:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF83329C4E;
	Wed,  5 Nov 2025 14:11:37 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B018329369;
	Wed,  5 Nov 2025 14:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762351897; cv=none; b=k1sQevRdzm+W5oGyxCwQMcfTPf6H4hEYMRTFc51/Z2wyur8/w8knzKrVA7LFivCFktmc/AxBcGu3nyg4ov6GQlALl4wwp/DYglwmcd+rgn1vXE8cn2F4lcOM2f+5p20BMhOCglVTymEyh2SFvfFRYpm0/sBnHhBibQUI6Bz6EzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762351897; c=relaxed/simple;
	bh=uiA5m7Ium7VHj+0mKhDhLqajooERklsdrrFGAFx2nVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kg/Gv9kkvDJuBSy6DX5k1y+fZbU+ETh5Hqao223vCTJcu577OkpMeKN0s2RUg4+KfSpWLKPfGDadSaC1QtEY7oT382xHvxVbv/knBQd/6yD1wBcmyA5ZMHPcb9f+yx9XYgw05hvM3fDgrCr/Zg7eAyF56aXmS/kpwDizBHc6CKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 01598227AAA; Wed,  5 Nov 2025 15:11:30 +0100 (CET)
Date: Wed, 5 Nov 2025 15:11:30 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
	Keith Busch <kbusch@kernel.org>, Dave Chinner <david@fromorbit.com>,
	Carlos Maiolino <cem@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-raid@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: Re: fall back from direct to buffered I/O when stable writes are
 required
Message-ID: <20251105141130.GB22325@lst.de>
References: <20251029071537.1127397-1-hch@lst.de> <aQNJ4iQ8vOiBQEW2@dread.disaster.area> <20251030143324.GA31550@lst.de> <aQPyVtkvTg4W1nyz@dread.disaster.area> <20251031130050.GA15719@lst.de> <aQTcb-0VtWLx6ghD@kbusch-mbp> <20251031164701.GA27481@lst.de> <kpk2od2fuqofdoneqse2l3gvn7wbqx3y4vckmnvl6gc2jcaw4m@hsxqmxshckpj> <20251103122111.GA17600@lst.de> <20251104233824.GO196370@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104233824.GO196370@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Nov 04, 2025 at 03:38:24PM -0800, Darrick J. Wong wrote:
> IIRC, a PI disk is supposed to check the supplied CRC against the
> supplied data, and fail the write if there's a discrepancy, right?

Yes.

> In
> that case, an application can't actually corrupt its own data because
> hardware will catch it.

Yes.

> A. We can allow mutant directio to non-PI devices because buggy programs
>    can only screw themselves over.  Not great but we've allowed this
>    forever.
>
> B. We can also allow it to PI devices because those buggy programs will
>    get hit with EIOs immediately.

Well, those "buggy programs" include qemu and probably others.  Which
immediately limits the usefulness of operating with PI.

This also does not help with non-PI checksums - one thing my RFC series
did is to allow storing checksums in non-PI metadata, which is useful
for devices that are too cheap for PI, but still provide metadata.  These
do exist, although are not very wide spread, and this will require an
on-disk flag in XFS, so it's not right there.  But compared to all the
others methods to provide checksums, block metdata is by far the best,
so I'll keep it on the agenda in the hope that such devices become
more prelevant.

> I wonder if that means we really need a way to convey the potential
> damage of a mutant write through the block layer / address space so that
> the filesystem can do the right thing?  IOWs, instead of a single
> stable-pages flag, something along the lines of:

Maybe, I actually suggested this earlier.  But breaking the biggest user
of direct I/O (qemu) by default once we have checksums still feels like a
losing proposition.


