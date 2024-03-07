Return-Path: <linux-fsdevel+bounces-13896-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EFD3875345
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 16:38:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B921B1F247C5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 15:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D2112F36E;
	Thu,  7 Mar 2024 15:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="o+Ib6oVX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD1C125D5
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Mar 2024 15:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709825890; cv=none; b=pC00QyL+Qa/mF+D8s0U+5KaTJKdRZ7sC+k4gEk2KtinhhV0BRDJShM7/hubIzitLXQ2/H78TddtbJa2pUquyhROO7Ce3E97LmiIn30rrtK/IO5Kg59idOV+dvFgy4HL9xcqmKtK5n6qRAYqC7F26UMwb9CL5tIqs671sEMMJQyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709825890; c=relaxed/simple;
	bh=Adr0FGv1v+m493hNL7KDB4IB1kzugTKE1tcoyKwg9aE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mWM5O6YI6buob06zZk/jisocXqrVFh1OxV3a9qqrQUGvd81rOrD63ME8OZmRAkpG5O/m1M7YNXrOR6yGW7MdC5yV6CK9iUr9t9zgyWI+wERh1wQMv5563p0OyBEQlLluNspnRYRfK5Z+gMaICvLepGXu9mqwpyd1ccCHvCIYOWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=o+Ib6oVX; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-102-198.bstnma.fios.verizon.net [173.48.102.198])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 427FbuDE011172
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 7 Mar 2024 10:37:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1709825878; bh=CRtQBHIuXFe3xAx7BaoQJhCRbvelq6dpudFNfh2aH40=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=o+Ib6oVXe1HuE8IovIZOpcsfLeNCrCWDPR1WsaPm/JtEUuekfI3F3vxH3Jqp9zqwL
	 gsHjNoObXidHn/f4ExMioJ3uTgg9SvktYQBf4Hp9SkS1OUh/90WPoYyLUja5yV22Oq
	 tEhD/LNQIp03549NRexKTAt1W/zheJuecTCHO8EjPd1KVSg0kLLrC8qMHt2YndcBKM
	 X4paTx0KRwV3w73RR+GrqjswX4dvau6HT3NZFNYWCN4N7v6uUj8AGe3p596gOP528Z
	 FofQTD8b3Ws3rBhOzBsMdXyXunK1tU1K3xmabAaLrBS83Q/6gsi6sCYVmcJa3xOW/B
	 7kcVp6iGjXkQQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id BCE9815C027D; Thu,  7 Mar 2024 10:37:56 -0500 (EST)
Date: Thu, 7 Mar 2024 10:37:56 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Phillip Susi <phill@thesusis.net>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: Uneccesary flushes waking up suspended disks
Message-ID: <20240307153756.GB26301@mit.edu>
References: <877cieqhaw.fsf@vps.thesusis.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877cieqhaw.fsf@vps.thesusis.net>

On Thu, Mar 07, 2024 at 08:53:43AM -0500, Phillip Susi wrote:
> I have noticed that whenever you suspend to ram or shutdown the system,
> runtime pm suspended disks are woken up only to be spun right back down
> again.  This is because the kernel syncs all filesystems, and they issue
> a cache flush.  Since the disk is suspended however, there is nothing in
> the cache to flush, so this is wasteful.
> 
> Should this be solved in the filesystems, or the block layer?
> 
> I first started trying to fix this in ext4, but now I am thinking this
> is more of a generic issue that should be solved in the block layer.  I
> am thinking that the block layer could keep a dirty flag that is set by
> any write request, and cleared by a flush, or when the disk is
> suspended.  As long as the dirty flag is not set, any flush requests can
> just be discarded.

Another fix would be making sure that the kernel isues the file system
syncs, and waits for them to be completed, *before* we freeze the
disk.  That way, if there are any dirty pages, they can be flushed to
stable store so that if the battery runs down while the laptop is
suspended, the user won't see data loss.

						- Ted

