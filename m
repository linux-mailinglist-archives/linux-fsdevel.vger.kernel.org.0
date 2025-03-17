Return-Path: <linux-fsdevel+bounces-44162-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D03A64094
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 07:04:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 676E37A5591
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 06:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0726321506D;
	Mon, 17 Mar 2025 06:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FD0lf5a5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4734F7E0E4;
	Mon, 17 Mar 2025 06:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742191449; cv=none; b=FEgTWEVFk1i6cOJ7dSCJsBDj9SeNLinjM4HtepfGrZ2Y3C8KocjesX8D1/8apY/Xu6Zanp8qTcHgklUkwgLwp8AKdb3gyKo/I/V5Yrhk7BhEn6P3tZlzoLfMJEJB9Cc0+PJR01HiOkp0v4KsCwbzTYqes5iQaaMAvuubL4qbjC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742191449; c=relaxed/simple;
	bh=1xwnLfVr5+IuExQCH0eZ1zK9ZRYT1pGEyP1OuSDAUEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R0WB18729Mco0PUtggAUqvO+kNb4VOmXgxkE/3+OnMOaUOK9LtHWOGNtYc/JMEP3MgS21jkyw+pzPYEbo6KDfGwiAgoF+HVvuBzoiUDe/EHGR4zfQHvgoQTBWNRQLoVwLrziM6OAmyQhwNl8li4QsUa9BDPA/0WTB+d6togX+ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FD0lf5a5; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4mOVcPNqSXq65abLzwSLzBk8TdFBZgWIQiDwJRb6c+E=; b=FD0lf5a5jAyzEe/XSl+/AbS3dx
	HRT+TqF9nOotcPYrlV8knPKe2jBLG57OKke1kGs8iPv+brMWhbEBFKhVh9ZVaLFc+gNVlmX6ZQmqa
	mffUl5J13aqihUGe31DYUGV6sI1+xsv1tC/S7/AeZo5YgzYDkFNsCgMeDiK2D9ox42FuMlIQvc+p8
	YJxISa08Gi5k4jBeqGcCiz3Lg6e9Yrv9Hf5+IkLwNb+hMOarVmTyhdjO2W78omVvsf1KwxhOhsjhk
	5EABw4QCnINpbZX96HC1dP3eCNWz+MFr1/Plo6nVP/dMxaBbba/zIbeCVDDQKjg/NFp9s8uclvZIU
	QAXu82iQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tu3a3-00000001KpS-32vr;
	Mon, 17 Mar 2025 06:04:07 +0000
Date: Sun, 16 Mar 2025 23:04:07 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Alistair Popple <apopple@nvidia.com>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 0/6] Allow file-backed or shared device private pages
Message-ID: <Z9e7Vye7OHSbEEx_@infradead.org>
References: <cover.24b48fced909fe1414e83b58aa468d4393dd06de.1742099301.git-series.apopple@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.24b48fced909fe1414e83b58aa468d4393dd06de.1742099301.git-series.apopple@nvidia.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sun, Mar 16, 2025 at 03:29:23PM +1100, Alistair Popple wrote:
> This series lifts that restriction by allowing ZONE_DEVICE private pages to
> exist in the pagecache.

You'd better provide a really good argument for why we'd even want
to do that.  So far this cover letter fails to do that.


