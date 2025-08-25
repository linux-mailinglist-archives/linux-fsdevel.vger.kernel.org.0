Return-Path: <linux-fsdevel+bounces-59098-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D6CB346B1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 18:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84896178868
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 16:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935B92FF654;
	Mon, 25 Aug 2025 16:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="jYu9zQUh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC882FF16B
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 16:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756137917; cv=none; b=DY/NAl/ud57X+aEmSiqmwFsxgAAZd43DEhvtpDCaqRIeMdM7PXMS8OcwxBAGE2AI0plzf7+6oioFEjecg61zP/goA5mL5ScaagXYfvlmNdiXQguePaViK4OD2NXIZA+tlNv03SPeMdHpJYxhVXTz1Bgn0nPCJcWvMAJBEfuP7T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756137917; c=relaxed/simple;
	bh=prS0MLBJzmiWMq8l7tYXO2w/8PUGyjbPHzDVNqijiE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gb0h12PhMMXR1ZNHRhaa4MWSGZ1uc0xrO5hnNBmqbETzEoNrWSZ2mqGN7wIq1PjWWrDDbX2drpCGudJVYVrYuPV4OTpTaWV3y8oMkVyEwqVBejUnbm7WgbDzCz5fD0QwTKpccSFSAsSvQm4RWYxczgyJ4cTG7GXfrWJTdvISZvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=jYu9zQUh; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rKUySVj68C39XcgIJ9ajfwzP4kvgdPD06654vNdSGec=; b=jYu9zQUhqNjK7/firiFmIn4hro
	2M9o4lmBO2PWPJHJReGgpROfjlsAPvIl9ggbyUJqjgZJ/6a96pUg42uat1IuDXK9Q852M66mo2PRX
	VDDzzDcCPtvJVVyw+XGsRt/nfFCoBjs8jn2K/R7wKy+S8TXM8Daf5gs2RvW9uUYYU9s/wv0Mzso2Y
	yA4dQ/PYHCkAfLlOVfrlGY6u+sx/moMK2rW0WNKwA79kuyn+F8n1SXsZZAQ1jxEQEUkegSW5QRwwp
	XeDsJTGIfKcUZgUNCeI09bBA1Qf6B3W3tSR9ZTAAdaUviB9TphVin7uDD6U/8jcCyVnfBt0pWv59l
	k7V6YNLw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqZh2-0000000G5M4-1UKE;
	Mon, 25 Aug 2025 16:05:12 +0000
Date: Mon, 25 Aug 2025 17:05:12 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz,
	torvalds@linux-foundation.org
Subject: Re: [PATCH 20/52] move_mount(2): take sanity checks in 'beneath'
 case into do_lock_mount()
Message-ID: <20250825160512.GK39973@ZenIV>
References: <20250825044046.GI39973@ZenIV>
 <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
 <20250825044355.1541941-20-viro@zeniv.linux.org.uk>
 <20250825-wahnwitzig-komponente-3b4b7d36900a@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825-wahnwitzig-komponente-3b4b7d36900a@brauner>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Aug 25, 2025 at 03:02:09PM +0200, Christian Brauner wrote:
> On Mon, Aug 25, 2025 at 05:43:23AM +0100, Al Viro wrote:
> > We want to mount beneath the given location.  For that operation to
> > make sense, location must be the root of some mount that has something
> > under it.  Currently we let it proceed if those requirements are not met,
> > with rather meaningless results, and have that bogosity caught further
> > down the road; let's fail early instead - do_lock_mount() doesn't make
> > sense unless those conditions hold, and checking them there makes
> > things simpler.
> > 
> > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> > ---
> 
> Well, do_lock_mount() was already convoluted enough that didn't want
> that in there as well. But I don't care,

It helps when it comes to cleaning it up - look at the condition it's in
after 34/52...

