Return-Path: <linux-fsdevel+bounces-35105-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 794D49D12BC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 15:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26BA71F23344
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 14:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3CD41A0706;
	Mon, 18 Nov 2024 14:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="n4sC80YO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C6019AD7E;
	Mon, 18 Nov 2024 14:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731939271; cv=none; b=GSjDDGCp7mUF7/INco72aWnIAJ+zjaVvNfUgnQOd/h0PSJ8566issX+MFuY28QgOIqKU3yRBqbVdpVpOYNY22vFauaO9fpJhPqEpR9CEAquas796iIpnP+CoTGa8tgc8Tesee6yOGuGN3VkQQKKsrA46xRiqW6FY3HRyz26sIpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731939271; c=relaxed/simple;
	bh=Iq4KCZXx57qcNeVJC9BAFCclI6aVAFK4IGWquYM+SAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I6tnbEkmS5evyUpuIl38LVu3L2gb7cohJUFmSqcpGbBFiZ3nSQKoKrSarMOOB2QOTcqzm6nIn4bjR5YWsLIF3HR6FPvbqt47pHFp1J6KtadLBKKzv6DZ3kEDpSHH9t6KeK9Au+vuTVs6KWUSpJPhIqGPi2poGNRPU3Unui0oWaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=n4sC80YO; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=IqVWXojb9n2L8fyUpFXSPsgqhzGXl83CytZq7+3ZL6c=; b=n4sC80YOxuD/KIdVXJFIU3pxPH
	FFFJ5h+2xw6lGI9PD4QU83vObbsY3nwV131S+BTQvfAQblHJgHLY65yW3Gotyt4LeIhfh5YAfg43c
	NNOAvzw/UfjZ56DMMUX/o4pGI9OwB7g+/mTzhK+VOMdZvMrV+QqE8hGppb9gv01jqvEyTeahvaYW6
	OAM8UPQ+u2P9hA8BTD9zGM9K+GMX+XlZvK6BccUXUjWMAvHXZJAkBFkyhqlZiZ+FYzNOZN8ORavv5
	3DA0Eyfzy4EObk+JzztkQG0jo4KDft5dlObMsU2CYhsWyduEO7tpQwETESskRpkQJLYwfl56Yq8v8
	J2cakrDQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tD2WI-00000009ijm-2Ief;
	Mon, 18 Nov 2024 14:14:26 +0000
Date: Mon, 18 Nov 2024 06:14:26 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Brian Foster <bfoster@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, djwong@kernel.org
Subject: Re: [PATCH v4 2/3] iomap: lift zeroed mapping handling into
 iomap_zero_range()
Message-ID: <ZztLwrkl4Qlbm5Ku@infradead.org>
References: <20241115200155.593665-1-bfoster@redhat.com>
 <20241115200155.593665-3-bfoster@redhat.com>
 <Zzre3i7UZARRpVgC@infradead.org>
 <ZztHK7WTZLu2V8bD@bfoster>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZztHK7WTZLu2V8bD@bfoster>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Nov 18, 2024 at 08:54:51AM -0500, Brian Foster wrote:
> I actually think it's easier for you to just fix it up according to your
> needs rather than spin around on the list on it, since I'm not totally
> clear on what the goal is here anyways.
> 
> Not sure if you saw my comment here [1], but my goal is to eventually
> remove this code anyways in favor of something that supports more of a
> sparse folio iteration. Whether it gets removed first or reworked in the
> meantime as part of broader cleanups isn't such a big deal. I just want
> to point that out so it's clear it's not worth trying too hard to
> beautify it.

Sounds good, thanks!


