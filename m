Return-Path: <linux-fsdevel+bounces-50284-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F7B4ACA8E2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 07:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B89D189C5DF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 05:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 275F3156F4A;
	Mon,  2 Jun 2025 05:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BtxYfW6O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E292C2C3255;
	Mon,  2 Jun 2025 05:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748842273; cv=none; b=fFl3vO2qaKr3Y7oetCtVJaYGNiZ1cvE8O2uDzU31YcRqrEtiSOQgB/ZolCAGrZgb5IuXrglR4w4xlvXi+qglYKzHNKmovDyteQk4zQ6hHt/Ov8rZmwrLGa72ttSlt9p3A2HswhZ1QGVlYukOKW9JPZkTgY//H91+8aB0sMEsGDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748842273; c=relaxed/simple;
	bh=r78Zk96UcLR+Ms0OlaIp/nN1u0mubhUhbbUCJdU0Nsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XwZI5jpTPWxqzQJnBWp4NMBM/DRuKsV+NDMNAhOP5u1klQrhR1Gcq1oFHfJQYreo3PABVxy94dZPRHyOpRUyqQKpVqJy2d41uhGfAdWtnX3tKdbDO0PILJHF2Yqkrb+xXhJKAbSevFBXd1YQ0cbeib9NqntqnPxDWNcZ3P3lCsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BtxYfW6O; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3B/N9yD+Mx9YSN9gtyxtZ0sxVuRC0yDOdXVS7TaPJlM=; b=BtxYfW6OY6I3YR+JmMC1tWvQFK
	AdgB1DXvj9XbgsbxTh+n/ZjhpLeL4/pAHsyTE34yBkUA38ZAonIXAY8WNVTh2+iAB9udaDH5KDWKe
	Uo2cLEIp+0tDizT2A5izSRjVpCQGf7hC6qNTPgbvxaEi8qHy4S/puQBLyTa1V1C7SMrgmlu8vLofy
	mr9/BdgFw5FDG8A3wT6oUeYfVOSS6aVadCgjIuA2wJ6rRphUNjExwPcKgYyMHygqmqV6L5YFsXZzE
	WSMtWtkCPO8/TgvmBNPZilKCnQjqHi7E0aSCyUPvdxmfRkf6ewvrG0mTjtyq/OXu5fE4WJok1BvJz
	nIdK/CSg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uLxlN-00000006kY0-1Z7s;
	Mon, 02 Jun 2025 05:31:09 +0000
Date: Sun, 1 Jun 2025 22:31:09 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, djwong@kernel.org,
	cem@kernel.org, linux-xfs@vger.kernel.org,
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [QUESTION] xfs, iomap: Handle writeback errors to prevent silent
 data corruption
Message-ID: <aD03HeZWLJihqikU@infradead.org>
References: <CALOAHbDm7-byF8DCg1JH5rb4Yi8FBtrsicojrPvYq8AND=e6hQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALOAHbDm7-byF8DCg1JH5rb4Yi8FBtrsicojrPvYq8AND=e6hQ@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, May 29, 2025 at 10:50:01AM +0800, Yafang Shao wrote:
> Instead, we propose introducing configurable options to notify users
> of writeback errors immediately and prevent further operations on
> affected files or disks. Possible solutions include:
> 
> - Option A: Immediately shut down the filesystem upon writeback errors.
> - Option B: Mark the affected file as inaccessible if a writeback error occurs.
> 
> These options could be controlled via mount options or sysfs
> configurations. Both solutions would be preferable to silently
> returning corrupted data, as they ensure users are aware of disk
> issues and can take corrective action.

I think option A is the only sane one as there is no way to
actually get this data to disk.  Do you have a use case for option B?


