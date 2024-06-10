Return-Path: <linux-fsdevel+bounces-21360-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81905902A40
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2024 22:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E908284141
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2024 20:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5AA152F7A;
	Mon, 10 Jun 2024 20:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="a4LQgX9G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3111817545;
	Mon, 10 Jun 2024 20:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718052793; cv=none; b=SzQ3LzVBfG8foE9vmWpFHR1EYMn2WaUtAjJvVIm/CoZp9oR+wyJM3Boz3LOrLAbf874yUwTC5urs1bzfhZu9AN3R8X8/KvLc3QYcdnuke3hSJdm4EkJ/yPw0ED0S0BBc0eJhLAivLuhEPcC1AW/+WtojLb6cjtgXKbK2s5EwMho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718052793; c=relaxed/simple;
	bh=sNpcmrfnWQc/F1GSzxVjiwBBEBp0OPLEaDpw2jyBQMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sa3uTDHJh2oNIst5xDdCtb+gMAiBm+QFl5wKFrASI/vprWycld40yWK1jFTyVOVTkVFKPx5PVZ//ga10ZdjkJYNdd7jYhvBDScz8u1J2gkv+s9A+qq5ViKSBBgY0X+5VDZlHdM1okeFYjEYmIUoccIu/2IRQgOuCLzpmM4gf9oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=a4LQgX9G; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xo4XDTh0mky6dka0tEADrxdJAWw9AmLCcLSxh29GfM4=; b=a4LQgX9G3dr4O2SnvBI/qfxzbh
	couYtCPCEkbzzoh0+tJCvSS5JQPhWQE3MCUHJa2Jw2S/25j/sQBXFOTOXTsol6FOWciAnkWyEXUZb
	BG4/9Y3VKUvCYBooQ5V/vj81ATMv3X2lvWYaoKzmOqaOZeuX3tqRf1nKGYcTQISl+skipycixzf9u
	iWLhUZY0OOOyc5xPoKDpHzu9DcNYVA2OmtgW5ioGRjAU1KxuoiGl4ytgTSBTcCCLAGkoPvyCE1ZUU
	do4CG7bVhlh7ec8xGjLOeND0qJSSRSJ4xPOG6dmFP05x2Fn6HYvV5n0fSnE9TCSPzsNyvNWRf0SjH
	+iUnLvvw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1sGm0n-009V38-2p;
	Mon, 10 Jun 2024 20:53:05 +0000
Date: Mon, 10 Jun 2024 21:53:05 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Fei Li <fei1.li@intel.com>, kvm@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] UAF in acrn_irqfd_assign() and vfio_virqfd_enable()
Message-ID: <20240610205305.GE1629371@ZenIV>
References: <20240607015656.GX1629371@ZenIV>
 <20240607015957.2372428-1-viro@zeniv.linux.org.uk>
 <20240607015957.2372428-11-viro@zeniv.linux.org.uk>
 <20240607-gelacht-enkel-06a7c9b31d4e@brauner>
 <20240607161043.GZ1629371@ZenIV>
 <20240607210814.GC1629371@ZenIV>
 <20240610051206.GD1629371@ZenIV>
 <20240610140906.2876b6f6.alex.williamson@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610140906.2876b6f6.alex.williamson@redhat.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Jun 10, 2024 at 02:09:06PM -0600, Alex Williamson wrote:
> > 
> > We could move vfs_poll() under vm->irqfds_lock, but that smells
> > like asking for deadlocks ;-/
> > 
> > vfio_virqfd_enable() has the same problem, except that there we
> > definitely can't move vfs_poll() under the lock - it's a spinlock.
> 
> vfio_virqfd_enable() and vfio_virqfd_disable() are serialized by their
> callers, I don't see that they have a UAF problem.  Thanks,
> 
> Alex

Umm...  I agree that there's no UAF on vfio side; acrn and xen/privcmd
counterparts, OTOH, look like they do have that...

OK, so the memory safety in there depends upon
	* external exclusion wrt vfio_virqfd_disable() on caller-specific
locks (vfio_pci_core_device::ioeventfds_lock for vfio_pci_rdwr.c,
vfio_pci_core_device::igate for the rest?  What about the path via
vfio_pci_core_disable()?)
	* no EPOLLHUP on eventfd while the file is pinned.  That's what
        /*
         * Do not drop the file until the irqfd is fully initialized,
         * otherwise we might race against the EPOLLHUP.
         */
in there (that "irqfd" is a typo for "kirqfd", right?) refers to.

