Return-Path: <linux-fsdevel+bounces-26112-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC5629547D8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2024 13:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FBEE1F22481
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2024 11:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747531BDA82;
	Fri, 16 Aug 2024 11:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="rR5yShxF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038EB1BD03B
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Aug 2024 11:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723806917; cv=none; b=EOaZOHPiIYf93zctSmwN1k8v9x8sH6Rb9CenUiMJhkxF+y2zt8UwhlTtxHJtRwPTd+XE1KkoK7m6ppGPYcDeKpYpAwpRG+Xmx6VzwvS+r8KAGULhITPcT2y1Di1rnUdeKwxqThlZe8JUB2MawNsTNhx6xrwiHW7ckpnJcE+gBV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723806917; c=relaxed/simple;
	bh=kGUMistRo7S/bqHre4dAtrnlgi3zOpxfon6Ye62nhxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NMRibaTpJuGvWUo0WK5uijLakftTc465Jg7T6Z12LlfIzLj2FV9F35apoOURY6OtQ/TXMy1Eogs+1wTf2T9d/LUfSBoXouMqSiP7BYRAbNhjnCBZ2pWdPCxNzVETc9g3iA4sJjHysgDtnEDsgDByvo7J18N5pZWvwURkkUzxIxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=rR5yShxF; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=++pk2gTlrARKaKhbCo5NmtMuRExtjJwcAU+Iwbv/15o=; b=rR5yShxFqhkPwPk22Vy33K0G7+
	Lh+RIPp0PiNOhDY6uZs+m0dVvT7Dp65PXv7GEksFZt4awRWidfDbpArLtvRkCEj6c3dAqwZVgUwlS
	qKnnRNfPMs9DjdRk46fSBH/E4UqopFoBl1yN+5U3NSedRybjI02O+X76tXorIx1BSKGmk2t6lWEZC
	xbLRCi+1bbaO7r6d6oIg9AN2WMtDsoat2vXBs39DRoGO6Mp3Bngk9bBI0HZHTFDNmEvtH2XuNvUDR
	BFqagF74GMGPpaCx5LqAJzZvX1bQ8o3eZV36ctPSy4QwDQ4Ep9v4Vyx+bzapzbND6RI1Iar9TsMF6
	9v+T/tJQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1seuvI-00000002B33-2I7t;
	Fri, 16 Aug 2024 11:15:12 +0000
Date: Fri, 16 Aug 2024 12:15:12 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC] more close_range() fun
Message-ID: <20240816111512.GA504335@ZenIV>
References: <20240816030341.GW13701@ZenIV>
 <20240816-hanfanbau-hausgemacht-b9d1c845dee4@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240816-hanfanbau-hausgemacht-b9d1c845dee4@brauner>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Aug 16, 2024 at 10:25:52AM +0200, Christian Brauner wrote:

> I don't think so. It is clear that the file descriptor table is unshared
> and that fds are closed afterwards and that this can race with file
> descriptors being inserted into the currently shared fdtable. Imho,
> there's nothing to fix here.
> 
> I also question whether any userspace out there has any such ordering
> expectations between the two dup2()s and the close_range() call and
> specifically whether we should even bother giving any such guarantees.

Huh?

It's not those dup2() vs unsharing; it's relative order of those dup2().

Hell, make that

	dup2(0, 1023);
	dup2(1023, 10);

Do you agree that asynchronous code observing 10 already open, but 1023
still not open would be unexpected?

