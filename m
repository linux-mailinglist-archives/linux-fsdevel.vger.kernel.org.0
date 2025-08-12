Return-Path: <linux-fsdevel+bounces-57471-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 451AEB21FC5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 09:44:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED00D1AA6CEC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 07:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1512DECC2;
	Tue, 12 Aug 2025 07:43:57 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416BB2D97AB;
	Tue, 12 Aug 2025 07:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754984636; cv=none; b=hiMEVcUW2CWzqJd+/T+nWiUipINQ9FtzAn2f57bJ5oYnSJxwZrJYhIG9qXonbJ9zZVmKe43XY9t4ML5QqUh2Y0umrrI/CG3fgHLm3N5LEGufEd1jt8Da2zA99rw8028a7UZF9chZUFsM/BiZPkbsAsIgoLoQqtBnTeKLQu/HFL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754984636; c=relaxed/simple;
	bh=bqM/4wRwEzoxQlCRe3b94XAem80UH0+YgjAbaGhuyCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kAX7Gx0x/vUMY13EAZu9agKhrDD2Tx/cIvfXV5bB+Rzs+CSMeZSwc1d2KihFVMTQtt1X0wIJT+2yijixSMTKw1UdtvxQiT3LPiST7AJc6JlOLhaJasM4z79o5/K6cCB/agKXOP0tygpj+BB7CnftixSSTcCW8vfxTwZrjPFcLsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 043A4227A87; Tue, 12 Aug 2025 09:43:51 +0200 (CEST)
Date: Tue, 12 Aug 2025 09:43:50 +0200
From: Christoph Hellwig <hch@lst.de>
To: Tejun Heo <tj@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Andrey Albershteyn <aalbersh@redhat.com>, fsverity@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	david@fromorbit.com, djwong@kernel.org, ebiggers@kernel.org,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 04/29] fsverity: add per-sb workqueue for post read
 processing
Message-ID: <20250812074350.GC18413@lst.de>
References: <20250728-fsverity-v1-0-9e5443af0e34@kernel.org> <20250728-fsverity-v1-4-9e5443af0e34@kernel.org> <20250811114519.GA8969@lst.de> <aJotnxPj_OXkrc42@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJotnxPj_OXkrc42@slm.duckdns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

> On Mon, Aug 11, 2025 at 01:45:19PM +0200, Christoph Hellwig wrote:
> > On Mon, Jul 28, 2025 at 10:30:08PM +0200, Andrey Albershteyn wrote:
> > > From: Andrey Albershteyn <aalbersh@redhat.com>
> > > 
> > > For XFS, fsverity's global workqueue is not really suitable due to:
> > > 
> > > 1. High priority workqueues are used within XFS to ensure that data
> > >    IO completion cannot stall processing of journal IO completions.
> > >    Hence using a WQ_HIGHPRI workqueue directly in the user data IO
> > >    path is a potential filesystem livelock/deadlock vector.
> > 
> > Do they?  I though the whole point of WQ_HIGHPRI was that they'd
> > have separate rescue workers to avoid any global pool effects.
> 
> HIGHPRI and MEM_RECLAIM are orthogonal. HIGHPRI makes the workqueue use
> worker pools with high priority, so all work items would execute at MIN_NICE
> (-20). Hmm... actually, rescuer doesn't set priority according to the
> workqueue's, which seems buggy.

Andrey (or others involved with previous versions):  is interference
with the log completion workqueue what you ran into?

Tejun, are you going to prepare a patch to fix the rescuer priority?


