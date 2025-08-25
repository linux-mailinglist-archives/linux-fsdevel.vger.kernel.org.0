Return-Path: <linux-fsdevel+bounces-59099-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F840B346E8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 18:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDB0E2A4D5A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 16:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A512FFDDA;
	Mon, 25 Aug 2025 16:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="A7UYSQwO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25E7299924
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 16:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756138182; cv=none; b=hCXJIdwUxsNpf3F9u2dmfKr2R4mlMjYPnaHlpeA+xbUGnr+bAIRc+sYh895zcQgFXBPTZ8wQlWI3Y9ioRZMKqHHaPutGo1GDERcB3TyI0RJSIGFete7167Ef0PRvoeHXQYY8A9hSvofJrMe02uwj4J9cstwDHJC23U4KKy8cM38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756138182; c=relaxed/simple;
	bh=XiiPQ2+k+v8CQM+29a6dsGeyuAzNvAgA+h9RzyDP1vk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FKwJer23USHHQjeDGt9FlDUgy6KjwBDjpq4GpjxNMrFnd/PNK+cbVdEfjvTQLkgvdtHeqW1cbjbrXNOuypnmp5/z0wlbEE24laYmeco4Wz3tqrTouJ0yVcgcCFnKq+nJDFgPcqSVjeVG0AEm6FemaYbpcAi+6lR0KKq+2QyxQM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=A7UYSQwO; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=WZP6MQMnVkMv4hlw++++E6J1a5pSjIcQDDGXTYm7v+c=; b=A7UYSQwOuzfrCC2EHAdJ/Jq9jC
	oGpYs9N5NIBwvDT0ykQWhu+wAAYwddz1Zu5t6C5RdwiOXHQI2lHCL2vMTT6K+9b8L3aHDAIhkKfvm
	dizceULZlSvqCoo2/O91NMi1UOf56JLMDXqZYGHGZ8QgaEK7GRbcAehA4PEMAVz970TQBvmuG0ywX
	wvF0VvWglQII+XZDxz916W83vm4v1DqR5Z+ccxUR+8z/c7jpc44XmPPIfNf9KS4sTFqTNB7uU/YV+
	XWvzZ6fQYultxKUmi5AKuswfNT15zUv91UZG/pVZfm3K77mE/Hn2eXGCYVEO8Yk0gckl/BRPaFfJn
	Di78ndHQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqZlL-0000000G9OE-1CjI;
	Mon, 25 Aug 2025 16:09:39 +0000
Date: Mon, 25 Aug 2025 17:09:39 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz,
	torvalds@linux-foundation.org
Subject: Re: [PATCH 25/52] do_new_mount_rc(): use __free() to deal with
 dropping mnt on failure
Message-ID: <20250825160939.GL39973@ZenIV>
References: <20250825044046.GI39973@ZenIV>
 <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
 <20250825044355.1541941-25-viro@zeniv.linux.org.uk>
 <20250825-zugute-verkohlen-945073b3851f@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825-zugute-verkohlen-945073b3851f@brauner>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Aug 25, 2025 at 03:29:33PM +0200, Christian Brauner wrote:
> > -	mnt = vfs_create_mount(fc);
> > +	struct vfsmount *mnt __free(mntput) = vfs_create_mount(fc);
> 
> Ugh, can we please not start declaring variables in the middle of a
> scope.

Seeing that it *is* the beginning of its scope, what do you suggest?
Declaring it above, initializing with NULL and reassigning here?
That's actually just as wrong, if not more so - any assignment added
to it at earlier point and you've got a silent leak, so verifying
correctness would be harder that way.

