Return-Path: <linux-fsdevel+bounces-45730-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6486A7B8DA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 10:28:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B139189C2BC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 08:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964E919994F;
	Fri,  4 Apr 2025 08:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xgmIPoCW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BEF18B463;
	Fri,  4 Apr 2025 08:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743755283; cv=none; b=gT8RtSg2HxPyLzzMZcsTroYTBKsw8RawWfkULHZ9HBU7v8Y1ov01X4N065Ar7Mk8KUvK7WEh7JCLOzrnHu6VAbIB3sp73WkCkbtRmPSMjHb29afwmtFb0BxXt58S+Q87RRDtV0ZLBb1oCgZd3xAl8cTOhGmLYekGI0y4oWpqyiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743755283; c=relaxed/simple;
	bh=eqBR2cQvQ1gZc/EFFNOenK4SPj0Z5ShX6xIJMJ0SHyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HfY3zaF4jYNOUUwRTVadskBPqdJkr50RvARIOdz2GY8nw67/+5w+YgKWIE3sSVtzIaZTfCTBkWRf5a+m098qYQC4YODIMH2eCiUmmuwQWVhDy91IdircjTTpBhmIBOrF3vtHU4hRneb3gEQVry8EnRkdIGDbNUQkMmrNPoqw9yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=xgmIPoCW; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=n8M3b+2Qz/s2h1trDKTTJQ/5na50BJMXmD4MAhynqAk=; b=xgmIPoCWkKYPEWj7quZzxhDc0f
	1zUTY8hrK6UdAODfBkqjJUdYWGQaPqECpoj72PIDpyRAXA3sJYdxR3SFlS6Vj5Z9vMecrGyXYEhlQ
	swmjuQ45p6MsvnDWhqbX9KiNNLkafsQGMnhdIQCGfByvDM7nbxlgm1/qxpqfYRDsy58iv8iaWy6dw
	GKJL5k9mGwbfWy7Y0AKw5Ya+HWCfcfBSAvLmrkAZo3t2DwImObAtOx53Klt4hhmV8EBfUjST6ryie
	frCSRHz6orTIWWJ2BMyO9Vu6tEdoRs0uK5b2YVbkyXGXlMhAx2qS1LL7d7BlyHrI+TOZX0FHPdsgc
	+QvXRjRg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0cPA-0000000B8Tj-2EiO;
	Fri, 04 Apr 2025 08:28:00 +0000
Date: Fri, 4 Apr 2025 01:28:00 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mateusz Guzik <mjguzik@gmail.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Christian Brauner <brauner@kernel.org>,
	Leon Romanovsky <leon@kernel.org>, pr-tracker-bot@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] vfs mount
Message-ID: <Z--YEKTkaojFNUQN@infradead.org>
References: <20250322-vfs-mount-b08c842965f4@brauner>
 <174285005920.4171303.15547772549481189907.pr-tracker-bot@kernel.org>
 <20250401170715.GA112019@unreal>
 <20250403-bankintern-unsympathisch-03272ab45229@brauner>
 <20250403-quartal-kaltstart-eb56df61e784@brauner>
 <196c53c26e8f3862567d72ed610da6323e3dba83.camel@HansenPartnership.com>
 <6pfbsqikuizxezhevr2ltp6lk6vqbbmgomwbgqfz256osjwky5@irmbenbudp2s>
 <CAHk-=wjksLMWq8At_atu6uqHEY9MnPRu2EuRpQtAC8ANGg82zw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjksLMWq8At_atu6uqHEY9MnPRu2EuRpQtAC8ANGg82zw@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Apr 03, 2025 at 11:09:41AM -0700, Linus Torvalds wrote:
> On Thu, 3 Apr 2025 at 10:21, Mateusz Guzik <mjguzik@gmail.com> wrote:
> >
> > I would argue it would be best if a language wizard came up with a way
> > to *demand* explicit use of { } and fail compilation if not present.
> 
> I tried to think of some sane model for it, but there isn't any good syntax.
> 
> The only way to enforce it would be to also have a "end" marker, ie do
> something like

Or just kill the non-scoped guard because it simply is an insane API.


