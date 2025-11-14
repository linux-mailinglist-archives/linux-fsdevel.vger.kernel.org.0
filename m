Return-Path: <linux-fsdevel+bounces-68420-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 057D5C5B668
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 06:40:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8B2A14E80E9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 05:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB2A2D739B;
	Fri, 14 Nov 2025 05:39:51 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F199E2AE78;
	Fri, 14 Nov 2025 05:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763098791; cv=none; b=Fk7ks4SZ3nivKXaePUTfQfEpFbfESwNBPVeaBa8BIYf/r/lobY40SnUCcjgix5m0xRVtwWwhMo/tV/4NLY04heojWbTRHDVhFcedgOcbIazRDU2ibB/Z2b7yHTiw46TfgYx1aAu6Il7szzzsK9jYklEvwDROj07d1VESxAd8NDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763098791; c=relaxed/simple;
	bh=aK9HMZclS2fCdg2UHFuYwo2ykgvLXX2JdlVgVu5Qjmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fEDzapZvV+zV7N5OZZ9jCOojFezZNKmpKZloxgApKfOdIPyH9P96XxxA5pGX+uG9OnfYbLAzD274iLeuFmXcAH68DS7gQwC464VK7SCihESVFh4ZrBxgal4U8KPepysK6lq+ONX78WeSLAHBfOIhS0/zHmzq+7LCZQmjohM01e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 17DFB227A88; Fri, 14 Nov 2025 06:39:44 +0100 (CET)
Date: Fri, 14 Nov 2025 06:39:43 +0100
From: Christoph Hellwig <hch@lst.de>
To: Kevin Wolf <kwolf@redhat.com>
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
Message-ID: <20251114053943.GA26898@lst.de>
References: <20251029071537.1127397-1-hch@lst.de> <aQNJ4iQ8vOiBQEW2@dread.disaster.area> <20251030143324.GA31550@lst.de> <aQPyVtkvTg4W1nyz@dread.disaster.area> <20251031130050.GA15719@lst.de> <aQTcb-0VtWLx6ghD@kbusch-mbp> <20251031164701.GA27481@lst.de> <kpk2od2fuqofdoneqse2l3gvn7wbqx3y4vckmnvl6gc2jcaw4m@hsxqmxshckpj> <20251103122111.GA17600@lst.de> <aRYXuwtSQUz6buBs@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRYXuwtSQUz6buBs@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Nov 13, 2025 at 06:39:07PM +0100, Kevin Wolf wrote:
> > A complication is that PI could relax that requirement if we support
> > PI passthrough from userspace (currently only for block device, but I
> > plan to add file system support), where the device checks it, but we
> > can't do that for parity RAID.
> 
> Not sure I understand the problem here. If it's passed through from
> userspace, isn't its validity the problem of userspace, too? I'd expect
> that you only need a bounce buffer in the kernel if the kernel itself
> does something like a checksum calculation?

Yes, the PI validity is a userspace problem.  But if you then also use
software RAID (right now mdraid RAID5/6 does not support PI, so that's a
theoretical case), a (potentially malicious) modification of in-flight
data could still corrupt data in another stripe.  So we'd still have to
bounce buffer for user passed PI when using parity RAID below, but not
when just sending on the PI to a device (which also checks the validity
and rejects the I/O).


