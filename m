Return-Path: <linux-fsdevel+bounces-24739-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FEE1944566
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 09:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A91928383A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 07:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75717166313;
	Thu,  1 Aug 2024 07:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="qBsdv7G/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08DE45014;
	Thu,  1 Aug 2024 07:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722497099; cv=none; b=tIOysdvAr66FwDIaRbvifdvydOarmDCRxwZiOEuZr42C6jywpprgrwMUIhGz0fGmmqMdy5hDnlLU4Dk4cdVCgqXlMugfZuFxhSwx76z2MVI6Q+ZY2nsxBQlWYY6crg1d3blp7GH7/nco7AHgDv2gfekDP1P6T5DmVAhpusRiKSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722497099; c=relaxed/simple;
	bh=2HNoRexbz5ZcFsC1CtZFUw1wgKE76RZOM7uGszyRPCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AD2pPMCb41L25VYW+UWQmf0x/ev6A/Y2woheHI8Yv6LReWBLpD8q+62oF7qF6t+OtZrjaSDxndQrQvdwEuQyTFC0VnTnEiPaHKq+eGEIfzukwWUg08WFgeKhsMym+mdcUZIYH+L61wfOwMEUwE7H+MaEnXsyLaNdm6+cS2uHjZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=qBsdv7G/; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5gEw2jBq+pJZyxL14pOnd54uIBriCAkLD3oM19s7V3M=; b=qBsdv7G/in+L7XCMrw476taL0Z
	9epABP9KZFbkaknuE+wnyXqdFcb8HMKwqAdgl4UhFkfQpwcKbkSZrHHhq1avVhhFGTDbsxLtOq6v/
	qkWf/DzOYdo8Rzs+q7FpZtlWk4M1pcP4KcfgOmoJTzXcU0qUbMR9miYrpiDHbd4oEe3e48HzDUNVR
	txJnFlJK9HAGfzBmyoeX0okDcHRaWpOdw7fKa9VYmpGvKz+z6nwjIjeAeXPKeYH5NEUB56yAaoG0I
	c7C57IhIFzEUteKOFuUWYMn/cM34UvpqwYFR+BwmuceCF6uwg8FXrg9TQ2ujSOUypB+RikARdJ3Wf
	qQ9XhQvg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sZQBC-00000000fJT-3J2W;
	Thu, 01 Aug 2024 07:24:54 +0000
Date: Thu, 1 Aug 2024 08:24:54 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Lizhi Xu <lizhi.xu@windriver.com>
Cc: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, phillip@squashfs.org.uk,
	squashfs-devel@lists.sourceforge.net,
	syzbot+24ac24ff58dc5b0d26b9@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: Re: [PATCH] filemap: Init the newly allocated folio memory to 0
 for the filemap
Message-ID: <20240801072454.GO5334@ZenIV>
References: <20240801025842.GM5334@ZenIV>
 <20240801052837.3388478-1-lizhi.xu@windriver.com>
 <20240801071016.GN5334@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801071016.GN5334@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Aug 01, 2024 at 08:10:16AM +0100, Al Viro wrote:

> Your patch is basically "fill the page with zeroes before reading anything
> into it".  It makes KMSAM warning STFU, but it does not fix anything
> in any of those cases.

Incidentally, it does that before it goes ahead and calls filemap_read_folio(),
with ->read_folio() as callback.  So if it does make it STFU, the case 1 (->read_folio()
not called at all) is out of running.  Would be interesting to see if that particular
->read_folio() is returning errors and if so - what errors are actually returned.

