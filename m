Return-Path: <linux-fsdevel+bounces-25881-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8BD39513F8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 07:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CC45284013
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 05:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E20A6BFB5;
	Wed, 14 Aug 2024 05:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ejNjyJkC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3485B20B0F;
	Wed, 14 Aug 2024 05:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723613966; cv=none; b=U+dTvBLcMAq+uSdTTl/3AJKKlXl4AYsyUDWasYnltN10LyU3PqVGcx9KqGML/gyfUaed1MKWbV1tkviYUUDd7DLaZsFOThlsy8UeV3pkjLRutXymB9JW+QDVftoYL6mp50O8AnUhW0aZWQPtvRRIWwcfrL0wkBcOA/VG+fBUu7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723613966; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bPSAMcmua03Uu3+WFcEBgUvO2B+i+luiNaWzhPRgBwZX0SXKRdVw8MefkNUKeMGMJHx3NT3KCJcBvK29XJczvQ0j9f3J5882VaHGYVoKshB4VJkGeIolVjIuR7JOoj85c/5qE8C5Oadx2mJ8h53z2rPSFCEjn0gug3LRz5O45oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ejNjyJkC; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=ejNjyJkCkAqGYHiC03ZUd8x3OD
	nrVS5Yg2aWk+AbS7b87YSPB2SrcPrrWNEoMjhBCeoHJmYC+C24UDVb3fbQiy67SAleaC4UlILFo5N
	pXB4TmPra45RwStqRJSACXKASYtGeODOfaOUlwIA1TemlNJMRgBc2ZW6eRccTXHe4dwB05sn3ifLx
	+QIfkaIkqX0Imarxn4Yp4e9O1e5sQqGE/fNhU7g3wW8P6rhxixStXpUZgW7XC3i3AhR0KWsAGBMOJ
	JjF+BtJEz22/gTczbovW4UBseZCMgw+nvLPZ+q7t1q3r0oyY/8LcGffZDvc4Pst0gCOUXiU+YFRSb
	UC3IgeXQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1se6jD-00000005pLG-1Aib;
	Wed, 14 Aug 2024 05:39:23 +0000
Date: Tue, 13 Aug 2024 22:39:23 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, djwong@kernel.org, hch@infradead.org,
	brauner@kernel.org, david@fromorbit.com, jack@suse.cz,
	willy@infradead.org, yi.zhang@huawei.com, chengzhihao1@huawei.com,
	yukuai3@huawei.com
Subject: Re: [PATCH v2 5/6] iomap: don't mark blocks uptodate after partial
 zeroing
Message-ID: <ZrxDC35HyXCgwfEo@infradead.org>
References: <20240812121159.3775074-1-yi.zhang@huaweicloud.com>
 <20240812121159.3775074-6-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812121159.3775074-6-yi.zhang@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


