Return-Path: <linux-fsdevel+bounces-20108-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B313C8CE51E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2024 14:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52D431F22BC9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2024 12:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349718626A;
	Fri, 24 May 2024 12:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hcwxujAK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D071782D83;
	Fri, 24 May 2024 12:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716553081; cv=none; b=TB1H+qzxKdIF/jEsZbV+I2rdq1TzgIHAXlUULR3TUrb22zbhh0pSlviRUCs7Nllc79kobc6CS7XSrQSK5BbE4CZMutqHuE5ASKgGtBiQ6lI3Bbq7aeVdBTyUj+Hm1JPaphY2n4HnR1jVrdFuQ4XyqEibYeloNb4WM1seNifCcfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716553081; c=relaxed/simple;
	bh=2wUrVKpqrPQNFYGYsvWORrKBBq8cYUK3jhRhDaf1KEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KxKUGS6BQ8fQp6+XSHA+SLXUO99H5mUwEvwevXPQWOznPQEjAa4OfOYbABl9QfLF707+XWjQUWZYYQh7QotOrpqc63RIiqew7ELZMl45qobrUavUATWC0zuZDuuNQ3fmth0r9fzklToRGZNhqXiwsGki0qEFH1dnY0fo8jTQibE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hcwxujAK; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wfOWPooHuO5W3ojmJffZ4S6c6nJ1eMqCJk0beuxH1Ew=; b=hcwxujAKXuWgOHxYziaHfsW38H
	6huMU4o/AmpQhKw68kBlESMGW0eeFl3eZCMQIPuWMI2b3vOj0Na0LAUQXbWv7YoCWvImQdGTVswaO
	nOIzJN0kL86ufmzS/JpXzSCB2J/RLirhpfXPbP1EFZD5l4ETWDrfPgsMw6HkTjOrmmywbxGhwF0hW
	vVGr7/TxsadmsPRlQ0JRB83JMd8hevjTKBzq/WAYihdOzpsH78dht2EkhSDi5DN2Ja++onSGaBBEB
	tIyZHgVVITcn9uTuDx0ZIA+GKWVDlsjdW7TZR+5kjFbYzJOKaEAExsCYVJIWhOHRU1+WrJg+dAF6+
	dxu6C3EA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sATrs-00000002eoU-1d5e;
	Fri, 24 May 2024 12:17:52 +0000
Date: Fri, 24 May 2024 13:17:52 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Xu Yang <xu.yang_2@nxp.com>
Cc: brauner@kernel.org, djwong@kernel.org, akpm@linux-foundation.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, jun.li@nxp.com
Subject: Re: [PATCH v5 1/2] filemap: add helper mapping_max_folio_size()
Message-ID: <ZlCFcGkbUZy_anrw@casper.infradead.org>
References: <20240521114939.2541461-1-xu.yang_2@nxp.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240521114939.2541461-1-xu.yang_2@nxp.com>

On Tue, May 21, 2024 at 07:49:38PM +0800, Xu Yang wrote:
> Add mapping_max_folio_size() to get the maximum folio size for this
> pagecache mapping.
> 
> Fixes: 5d8edfb900d5 ("iomap: Copy larger chunks from userspace")
> Cc: stable@vger.kernel.org
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

