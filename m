Return-Path: <linux-fsdevel+bounces-8316-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33EB2832D10
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jan 2024 17:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7FBBB22EB1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jan 2024 16:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A84254FBD;
	Fri, 19 Jan 2024 16:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="t6WunDiY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0253754BDC;
	Fri, 19 Jan 2024 16:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705681478; cv=none; b=mfbvu6667FtmbZFK4+ZUMRZNxR5EXqzYZPSxybAJz20CeBu2p0u1E3bQ4ppsmMHTYZkjWRyApSwJJZHzTBFmQIVmyY+cheirxuJj2bzUyvY6ImHYa9CWYC8DGiK0Ch4eMJU0NmaouPo57Q57bDQ71+HQGfpbmW/BmJDEYRH8Q0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705681478; c=relaxed/simple;
	bh=vQWoUhgPau5YPZz1BA9mRf101/hGQxKHWcr01PQu3Kk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jB2EITzzLVgInfErLBaKIJ7c7t7vRQeS+dXYDpkPzAxUN5HN6mAHoo+75Lx/BU7ywTktVgceHFvWXuhAKibp/CIXRVJEIUZE8drRDurznFqhk+1F6YkmBNwL5725wMi/XaPAQDc2pl8GuVBidN2ts1S6zD3CSOWoPw9NNwTfov4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=t6WunDiY; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=6SmJw14/0T3QFq2lCb7AOALWjjzOgKZ9hRbndy0R7AI=; b=t6WunDiYYjv6iOpAEiG0tTCiOE
	9KraFRh/TQwUXy3kvYdi+ZqCTKgneFa0x6a5u6ViyfwU7KPPN7aG6+TZilHG/ijMF0asm+qQTB9M3
	uIZHwojOT6FFml7KCO6UCwhQGLZ2Ii9LXk4Xum3qdI74l+cd0VTendMVH/PZVhTAJcKUSm5ck7BVr
	U87GBkNPCjisje8+dDjlvDBBrZssy8R0jbEF4yvZxflR5RU/lfoiZKTT+m2bG4AXy3hXtrgvyG+M2
	E66gK3u5hPu6ZG1k2LJy15VP7WmpeOnqj48FT9WAmXUjTw12zJ8DSwo5DOHmNKNyo9vdzMlhoNB8E
	v+Qe6Zmw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rQrfR-00000005fBk-346O;
	Fri, 19 Jan 2024 16:24:29 +0000
Date: Fri, 19 Jan 2024 16:24:29 +0000
From: Matthew Wilcox <willy@infradead.org>
To: lsf-pc@lists.linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org,
	bpf@vger.kernel.org
Subject: [LSF/MM/BPF TOPIC] State Of The Page
Message-ID: <ZaqiPSj1wMrTMdHa@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

It's probably worth doing another roundup of where we are on our journey
to separating folios, slabs, pages, etc.  Something suitable for people
who aren't MM experts, and don't care about the details of how page
allocation works.  I can talk for hours about whatever people want to
hear about but some ideas from me:

 - Overview of how the conversion is going
 - Convenience functions for filesystem writers
 - What's next?
 - What's the difference between &folio->page and page_folio(folio, 0)?
 - What are we going to do about bio_vecs?
 - How does all of this work with kmap()?

I'm sure people would like to suggest other questions they have that
aren't adequately answered already and might be of interest to a wider
audience.

