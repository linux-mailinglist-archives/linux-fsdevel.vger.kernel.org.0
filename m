Return-Path: <linux-fsdevel+bounces-45766-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33470A7BE24
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 15:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD161189A053
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 13:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2AA1B423D;
	Fri,  4 Apr 2025 13:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nxc/J2CW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306CF12D1F1
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Apr 2025 13:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743774149; cv=none; b=FMtLJyEuiY8muoFRQ/7UVAjlsb4k06tsEcEGniC1CEI2eWtSbmo+MU5tNwKifWdvN25xA8JW9aKquAIgwh7iiZosbJWMLNXQ+fMCwNHmjhzy9PKG998yrPo8NzKO6i5v79fIV6msLHEY5jKpugbJQtuNnMtHJbAPAMrrqr5tcxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743774149; c=relaxed/simple;
	bh=TovXvaLFr5Rkj5O3t5Q+otepISJkuBVP1MiuZJiuYMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uDCt9O83jIMySKpDm7zmkci5zLe9YZXLI6AOaG3Id8H/08nPormJKQ1ZEt5k7cZQqN0K1rtnHIbQwYNC0dzK4/XItgIfaVH+Q27X/ZFZsvQcVNDZ/tbh3oPBJyaCwGM93O+7dV052ihcOQW3PdxxUiIV2I1Ar76oiEq9VVv5Ejk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nxc/J2CW; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=F04fAoiUU6AjLlzWFdt7ysNoBBuqOxgrM+jhIAy/Flo=; b=nxc/J2CWif+kzH+Mi9v2mm+JFq
	KbI/r2Su7ao+9XaSdnb0ZNJctCDdQO3WjQIh4eVQv57WFP4O4x159u6LSwFMWlcVOXY71H66xTTBa
	L5Vu2vjfjrPc8uMOk+FKDcLtSv6tZon4G7p/cHTOq3H9HSGHS9bPoTZE9oIlmTFsDnWDad/9tw5hn
	fj20+hr1HGcqU1XpwQ30oEInfjbzuZphm2rvHpHWg6YTukao+/z4JhLO89CMF+0AF5vZZfzFxr3da
	TGtvhPTkWWaNXWDkS57nKdmLlGFipRbhLjEByROQ9ppM6H59X7gMF3qjI12TqQzMRRTCRKVnllZcd
	OKy3CsVw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0hJS-0000000FaNj-26N9;
	Fri, 04 Apr 2025 13:42:26 +0000
Date: Fri, 4 Apr 2025 14:42:26 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
	linux-mm@kvack.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 0/9] Remove aops->writepage
Message-ID: <Z-_hwrdVVYCbOA-0@casper.infradead.org>
References: <20250402150005.2309458-1-willy@infradead.org>
 <Z--YzzLSj7B7ltYE@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z--YzzLSj7B7ltYE@infradead.org>

On Fri, Apr 04, 2025 at 01:31:11AM -0700, Christoph Hellwig wrote:
> The whole series looks good to me:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thanks!  And thanks for removing writepage from some filesystems.

