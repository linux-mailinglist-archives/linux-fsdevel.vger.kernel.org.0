Return-Path: <linux-fsdevel+bounces-46163-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD019A838B5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 07:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C98B8A6718
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 05:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A1B202960;
	Thu, 10 Apr 2025 05:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qDmR1F0s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA061C3BEB;
	Thu, 10 Apr 2025 05:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744264444; cv=none; b=uhqODlL1FKlElFmUg+pjkAM3QATJGnklBpEzVSmDWepZZPtXG78bCYWa7DK4CeWFTB52VFlKB/s8sLyn2ciaxWWwddzyqgHS6UD/FKd809SC1+/dwm8G2pV47zx2n/rXBNFMN0ZVRSen0U3K72dxaStX94UKcah+mx5I1dgKuBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744264444; c=relaxed/simple;
	bh=PYB+8+fnm6cmA4lHoEcozH2lyckWEcrcsqXiUXyApFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nLSnRfdTGRff44urtW2wrR6fwI6De+okzUYulkDvNtiWn4+DXOIhjygi+98pU5lVqP/jS3e3W7ErfKik9uZQ84uXsiZPOPrIBowEA7go4Ak8vNatlv5byTAoK4IorjKGGdccV4RR7aUduwLaQ+GsWWuPuiXT5G4VO8k5ym5GBFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qDmR1F0s; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1GqN6CWMLtyKWZmAbAgDJaq97Nojq9X3sYXuPtmxkcU=; b=qDmR1F0sTiDEClQRlXsmzeEzsu
	uoaedrulUSVJcEPLeWdeM9xBmrryAXmPHio3kvfL4eHT8msf/H3PHeltk9nlE1peSRD0mLAZlxtFX
	A0zVC0jTlUwwOeaImy8qFyygsK423Zi6chHu7Q9faCyFB+PrdT7oX3OIuKUlX4ZfNe/MRTJTGcrHC
	jU0Xq4OXLYoXMYWeDGEvAK5hYqTcQsWhOS8QYe4rrxs7n/cBMGKmjpVxXGOCReQOWHMeWYMBMsoe4
	X0m9QefwsVVoG1bl/l7+LZmVWknrCic1oMvA22tKBBBFnHbLaZGvxNUecsZUzXPgOvK+d74Od2dW9
	MdLaXuPQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2krR-00000009JLR-3xkI;
	Thu, 10 Apr 2025 05:54:01 +0000
Date: Wed, 9 Apr 2025 22:54:01 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Gou Hao <gouhao@uniontech.com>
Cc: brauner@kernel.org, djwong@kernel.org, gouhaojake@163.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, wangyuli@uniontech.com
Subject: Re: [PATCH V2] iomap: skip unnecessary ifs_block_is_uptodate check
Message-ID: <Z_dc-UmJs0F1UWTN@infradead.org>
References: <20250408172924.9349-1-gouhao@uniontech.com>
 <20250410054223.3325-1-gouhao@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410054223.3325-1-gouhao@uniontech.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Apr 10, 2025 at 01:42:23PM +0800, Gou Hao wrote:
> prior to the loop, $i is either the first !uptodate block, or
> it's past $last.  Assuming there's no overflow (there's no combination
> of huge folios and tiny blksize) then yeah, there's no point in
> retesting that the same block $i is uptodate since we hold the folio
> lock so nobody else could have set uptodate.

Capitalize the first word in the sentence and use up the 73 characters
available for the commit log:

In iomap_adjust_read_range, i is either the first !uptodate block, or it
is past last for the second loop looking for trailing uptodate blocks.
Assuming there's no overflow (there's no combination of huge folios and
tiny blksize) then yeah, there is no point in retesting that the same
block pointed to by i is uptodate since we hold the folio lock so nobody
else could have set it uptodate.

>  		/* truncate len if we find any trailing uptodate block(s) */
> -		for ( ; i <= last; i++) {
> +		for (i++; i <= last; i++) {

A bit nitpicky, but I find a i++ in the initialization condition of a
for loop a bit odd.

What about turning this into a:

		while (++i <= last) {

?


