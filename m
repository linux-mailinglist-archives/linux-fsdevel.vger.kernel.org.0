Return-Path: <linux-fsdevel+bounces-36382-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C58D89E2D96
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 21:52:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB199B322FC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 19:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE519204081;
	Tue,  3 Dec 2024 19:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ErvReudg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39E913DDAA;
	Tue,  3 Dec 2024 19:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733255488; cv=none; b=MEfwRJ44ZWpi/YznfpGX1fQdCeBnpNkA+hR/ZnBvrVEZR0YlE7X26TssZcQgiQo5PK6t8Tzxv7s+FxQ2iBTGvY4mXrULb9Rn35KBc/ih/4cxokhCbHAQgKSgucCPnpybMszX7gviqdewrO4wsTmhM6X+FjOc4Yj1fxQT0LkwBdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733255488; c=relaxed/simple;
	bh=jhDHHtOwTo80jIZU+Onb0RlkAEK7W9fBks6zoN161z4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=l07DpX6pXPIloIDDHAslCnFWaJ3McQi8HsXkQ+mMu0SpO2SXmkv18lck1KRDuhzY71nNFoxqzbhZDZe+zqjVHVETraDsQFe38aoccTXa3JiTepAd6pVWDk8bwSzZq0quwmcvIjXQPMoeibqoPZQpHyIeGBfaG+qe95F91bvP6Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ErvReudg; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=jH4yBcVS3NQ7YkkW1qJk55K1usaBZKjmOXquBiHvrjw=; b=ErvReudgtvG3n8VmPJznERacAO
	gk4Pf7scNBorVKH+1cqmdv4JTXWzGWn6Z7UR3F+AKQQdw5sW9CvvuH/qyFrioEEHA9EXYAkTIpFlQ
	4WwWrH5W42VQ9qww9hisV7KI/8I3kNMbEaIQ12EtZV1tXER59AzgH9QeQfKzG1jPWWvSGwNHrkhy+
	jqL9McfbrBzW114zT7FxBIpz7GluKjAaN93e/oqUNJKo71VCXXzMQiSsU3aNx/CW9v8HgxwgesSiP
	NGnPSE6o75ToxpjENiORz5dboTDi0j4hnCTHJ0gawMr82M86Twip69sZ+Wpt2o10YUCyVFDXRsfdc
	dil90xNw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tIYvb-0000000A9oE-25ro;
	Tue, 03 Dec 2024 19:51:23 +0000
Date: Tue, 3 Dec 2024 19:51:23 +0000
From: Matthew Wilcox <willy@infradead.org>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-s390@vger.kernel.org
Subject: Removing page->index
Message-ID: <Z09hOy-UY9KC8WMb@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I've pushed out a new tree to
git://git.infradead.org/users/willy/pagecache.git shrunk-page
aka
http://git.infradead.org/?p=users/willy/pagecache.git;a=shortlog;h=refs/heads/shrunk-page

The observant will notice that it doesn't actually shrink struct page
yet.  However, we're getting close.  What it does do is rename
page->index to page->__folio_index to prevent new users of page->index
from showing up.

There are (I believe) three build failures in that tree:

 - fb_defio
 - fbtft
 - s390's gmap (and vsie?  is that the same thing?)

Other than that, allmodconfig builds on x86 and I'm convinced the build
bots will tell me about anything else I missed.

Lorenzo is working on fb_defio and fbtft will come along for the ride
(it's a debug printk, so could just be deleted).

s390 is complicated.  I'd really appreciate some help.

The next step is to feed most of the patches through the appropriate
subsystems.  Some have already gone into various maintainer trees
(thanks!)


There are still many more steps to go after this; eliminating memcg_data
is closest to complete, and after that will come (in some order)
eliminating ->lru, ->mapping, ->refcount and ->mapcount.  We also need
to move page_pool out into its own structure.

