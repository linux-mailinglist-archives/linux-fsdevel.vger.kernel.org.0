Return-Path: <linux-fsdevel+bounces-44617-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 083D0A6AB0D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 17:30:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF7543B1E8D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 16:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4AF21EB1A8;
	Thu, 20 Mar 2025 16:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uyvierVq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90901EF394;
	Thu, 20 Mar 2025 16:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742488053; cv=none; b=lHM+CMyW14mi/zRTrfr2HY6+/np/D42bI9TsMPRJ2zuzkyBroEBRzvyPPsmT5HTUQSm+DLSYoUf06+ZclRdzHrA9Oq5bwzAy949O9N83vy+788vKKRWiNxvMof93M616dKHSt6UeYAq4CrbptDBi3XcZ0IR3x4L0E7KIsbicI4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742488053; c=relaxed/simple;
	bh=yCNhYWqwBXng6k9ixlUc5IgLNQvqwCR8M0wZzTRYmms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EyB4aVpfwrwUNd3hcVNgMAazl+bnf/BaYGdG45R1qPSsjivU0t31+vk5kf0vCupV1nmkUTtTv9nkID8DDpXV/FeCROgFnbxo/XqCZ2uabZRdWQA9gf38ysqfuxEUJ7u4Zp5BT+W26DDipPbQFeFHPXUyZ6kpCTUMUrRxhCArPJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=uyvierVq; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+XGyK17VNfHnVYETWffBN7SGjSJqT62GP+tR5Jc+Ncw=; b=uyvierVqVh+ez4Jl8iribAOwM+
	fjwQ3mRizK/R6sD6olsiGv0i6WAZ2X7UMWbPbRWi5kfJ33XKKkcYDBuNitLy7/M0iUBRqivkC4l1F
	C3mCLd21MoBQ+2SawSVR/vJ1hF5RV9+3p7OmRqzmFp3tGRwQoG9nXIYYx8Zr3GWgw+7fBK9mHV9Rt
	4DCDG8TYb/ncpwDP1ixgam6Q55mNc7cNmzWeCMcNOrPoSdkqENUU9P6qRR+R1Narw22WhDwJGQKXI
	e87m1zBx+HCHupHvTBTzQ2J9RuwqVN8curp/y/JJzk1cuCtxE28LvInjpQWOBAnKmuNn6jDHV7TSX
	m37soGgw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tvIji-0000000EDcS-2StW;
	Thu, 20 Mar 2025 16:27:14 +0000
Date: Thu, 20 Mar 2025 16:27:14 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, leon@kernel.org, hch@lst.de,
	kbusch@kernel.org, sagi@grimberg.me, axboe@kernel.dk,
	joro@8bytes.org, brauner@kernel.org, hare@suse.de,
	david@fromorbit.com, djwong@kernel.org, john.g.garry@oracle.com,
	ritesh.list@gmail.com, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-mm@kvack.org,
	gost.dev@samsung.com, p.raghav@samsung.com, da.gomez@samsung.com,
	kernel@pankajraghav.com
Subject: Re: [RFC 2/4] blkdev: lift BLK_MAX_BLOCK_SIZE to page cache limit
Message-ID: <Z9xB4kZiZfSdFJfV@casper.infradead.org>
References: <20250320111328.2841690-1-mcgrof@kernel.org>
 <20250320111328.2841690-3-mcgrof@kernel.org>
 <5459e3e0-656c-4d94-82c7-3880608f9ac8@acm.org>
 <Z9w9FWG2hKCe7mhR@casper.infradead.org>
 <c33c1dab-a0f6-4c36-8732-182f640eff52@acm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c33c1dab-a0f6-4c36-8732-182f640eff52@acm.org>

On Thu, Mar 20, 2025 at 09:15:23AM -0700, Bart Van Assche wrote:
> The patch description mentions what has been changed but does not
> mention why. Shouldn't the description of this patch explain why this
> change has been made? Shouldn't the description of this patch explain
> for which applications this change is useful?

The manufacturer chooses the block size.  If they've made a bad decision,
their device will presumably not sell well.  We don't need to justify
their decision in the commit message.

