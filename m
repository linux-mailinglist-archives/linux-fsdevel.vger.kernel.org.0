Return-Path: <linux-fsdevel+bounces-64211-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 095ECBDD28F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 09:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1C5044FE922
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 07:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90FA6314B7F;
	Wed, 15 Oct 2025 07:28:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF210314B79;
	Wed, 15 Oct 2025 07:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760513287; cv=none; b=o/BjW1nYvl9xX2QyiHGE7W3CW9Oiv00499RY2V2NQmqQ1VamtsYBjmWSgbJWU2Q4P2hwIFutkp/uKSkZrA7SO/iQmXgXCgqmGEpSr6uwVrp43AA4v06Q6S+ZqZHucOadmYe9Cq+4KbVPuYNIIndnt6+6mAFGS6bihgfk/AkwA68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760513287; c=relaxed/simple;
	bh=hccsorJh9VrCcg3u5Ec8lYyp8crSG/qLdkP/hzDSzjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hH9RTrI568sT36FFfnF0naYRHMthDNKEqySb9R0so1v6yVr1wbmUWwLZW+A2ff8CQFD1OfXuCGqVR24/of1q7WzxtUn++1Y2djaSYNjWPx+wDd0TM+KKoGjCxlIu3I3uTPvWMMQffJ/D3jcKNaMuZ/wDFzwaTYSNAzWNciSCOes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id D75E5227A88; Wed, 15 Oct 2025 09:27:58 +0200 (CEST)
Date: Wed, 15 Oct 2025 09:27:58 +0200
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>, Carlos Maiolino <cem@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, willy@infradead.org,
	hans.holmberg@wdc.com, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 2/3] writeback: allow the file system to override
 MIN_WRITEBACK_PAGES
Message-ID: <20251015072758.GA11224@lst.de>
References: <20251015062728.60104-1-hch@lst.de> <20251015062728.60104-3-hch@lst.de> <a1671515-4aec-46a0-aff0-75ea8540394c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1671515-4aec-46a0-aff0-75ea8540394c@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Oct 15, 2025 at 04:09:13PM +0900, Damien Le Moal wrote:
> > +	unsigned int		s_min_writeback_pages;
> 
> Given that writeback_chunk_size() returns a long type, maybe this should be a long ?

Not that it currently matters much, but yes for consistency this should
be a long.


