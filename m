Return-Path: <linux-fsdevel+bounces-54919-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA59FB0517A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 08:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F7287A33CE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 06:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E7D2D3A8D;
	Tue, 15 Jul 2025 06:05:18 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769CB288CBF;
	Tue, 15 Jul 2025 06:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752559518; cv=none; b=Efq4hQxxeVTp+7uo4P+35pkf29WypcvMeWE0OeikEgm6C56ohvpzIdoZidFZha+OlZFhOklkRiB+L3Tr3vZ6xx/dh3XD1Jh59fe0L/sAYnH3CuC/JVc9rkcrSaEu/E5xA5fjtJgz4GRbXHwBFPgBQdL5y462/5uz0lJhqfahAew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752559518; c=relaxed/simple;
	bh=Zl8clbLEp2vhJBVjc/hrJfu+lYlDsB7AEiBQWe7V6xY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NoKVh5TlPKfxAb2Up1gUqaZwe83SQET7YstAOkhzvBJGLeoh+DBuAfhx/cTRI8TkwGZ3A+wz9uo9al6bhMb3iL/EHzM66Uq8SMvXLC2+R/j7CxIcy38MXNzTQGQspD6o95oTmkIHff6M9dqFq1wt+DC/4ZYhNwnpmb8LALN/LF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 324B6227AAF; Tue, 15 Jul 2025 08:05:10 +0200 (CEST)
Date: Tue, 15 Jul 2025 08:05:09 +0200
From: Christoph Hellwig <hch@lst.de>
To: Dave Chinner <david@fromorbit.com>
Cc: Christoph Hellwig <hch@lst.de>, John Garry <john.g.garry@oracle.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: Do we need an opt-in for file systems use of hw atomic writes?
Message-ID: <20250715060509.GD18349@lst.de>
References: <20250714131713.GA8742@lst.de> <aHVuSU3TB4eNRq8V@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHVuSU3TB4eNRq8V@dread.disaster.area>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jul 15, 2025 at 06:53:29AM +1000, Dave Chinner wrote:
> This isn't a filesystem question - this is a question about what
> features the block device should expose by default to the
> user/filesystem by default.

It's both.  As I said before we've spent a lot of time making the file
systems less reliant on hardware getting everything right by adding
checksums (for metadata everywhere, and non-XFS file systems for data),
lsn verifications, etc.  And now we go all in to trust a new (in case
of nvme very much misdesigned) feature.

I'm perfectly fine offering that use, but I'm a lot less excited by
automatically using using it due to my deep mistrust of hardware.


