Return-Path: <linux-fsdevel+bounces-72415-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7854ECF6E3C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 06 Jan 2026 07:28:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 743E4301994F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jan 2026 06:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A883002B9;
	Tue,  6 Jan 2026 06:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OF3mhqDw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2C32AD2C;
	Tue,  6 Jan 2026 06:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767680910; cv=none; b=KlFX5Dgq7B/Vyw6iJF1KnhiW038dAJPwiE1s+c9yDZN5kcTR75ZxejeVaM51S71mXXnhKSIcnQw5/KO5xP7tlwGK5Ytd7muWTGGQudBuRX5vtzZ+Z/Y4EHmEmhgeDJ6jGOENFlWy9bBLZZS4Xth5JXEBXEIVWywr9Ok/ps6BW6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767680910; c=relaxed/simple;
	bh=Wbt0CGMDjBab4AKSGoS6mk7CQiXgYjVWoYdRaJmkWEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ahEAigM2ZCORcHwqoRCnIxpvkP76+yFVDsZQd+xYverUstyA1et+TcvwEI1/kvrwfJnF2Et4RjFvunYmWQUWowfDNkYoXwa1ssgC1WKY6FMLikhjNiPYRy3gTBPqnOKA5owsuBhk3lCyPQARnm2G4pUAher90as+G3JbHX3kOL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OF3mhqDw; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=RG8w/6Xs7Sf15VlarcLQ/TEqh2m4w0QguVKt5QSb32Y=; b=OF3mhqDwqJ4m84K16vkoDniIbN
	f/of+HXufUjJmDxJ3WVpnT4RJtRUhBPyiVQ+11YKiQlGn2iFEaTCU3DGjAjhq4Q6zWFFr0s5o3zH4
	QXsV+0QahfG2V/puTFQJ2qHI6h7yTWWYT876/DnyHMZ5bEuSsmL48J9NWflm1Qv9RIxLdgoQzycJv
	U0fWXNd9ambeC+qbTsbdG0WWHmtgQJRCB2NEXUa2WT9Y1frDKfgEVjzW0scauSoJYOSf+NImaNOs+
	g3rovWUq6dwMCbIVxmZMXoVnpXTytR4rh2Mbjwt+QPN/0FOEe1YoPOrACGX8qsA2SL+j66bYuwl/C
	Sg3TXaTw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vd0YN-0000000CTBG-1sF4;
	Tue, 06 Jan 2026 06:28:27 +0000
Date: Mon, 5 Jan 2026 22:28:27 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Zorro Lang <zlang@redhat.com>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH fstests v3 3/3] generic: add tests for file delegations
Message-ID: <aVyriyPD8x8oJUo-@infradead.org>
References: <20251203-dir-deleg-v3-0-be55fbf2ad53@kernel.org>
 <20251203-dir-deleg-v3-3-be55fbf2ad53@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251203-dir-deleg-v3-3-be55fbf2ad53@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Dec 03, 2025 at 10:43:09AM -0500, Jeff Layton wrote:
> Mostly the same ones as leases, but some additional tests to validate
> that they are broken on metadata changes.

Under what conditions is this test supposed to actually work?  It seems
to consistently fail for me even with latest mainline, which is a bit
annoying.


