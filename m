Return-Path: <linux-fsdevel+bounces-71614-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C9BA3CCA50A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 06:24:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AFA9A301F5E6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 05:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA94530AABE;
	Thu, 18 Dec 2025 05:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rDdoNQez"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CA43093A8;
	Thu, 18 Dec 2025 05:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766035435; cv=none; b=k5oZXCw7hQN42bTsk9d0cIEIOeWFe7x9w/k0G9bafpmJDCGT1rXPwVavKQ61rkA26m2yevBf7R/5UIgkmOwkoUUnp9JjOurorB4UPBqG+k6dNcSeNkys0gspVgffmM1SMkKmLbYp9HclsnjWZWjpmjsS2ERvB0SzHf98zR43xbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766035435; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UvHHjcW8DhmI/+DJHDYhfGfTp8wanvqtJcUwyqUszOuSn/3WDzCSdb0M7Cvdou7Myl7GLFYpmdIBQ4eVpWczhFKUQUubnMOTX4VGdC34QM053p+sdAeNzQpZ//EHG3zhKA8h0noR/qBWaebajEqZGVGa/gyksV9RjgZ87kc6Qxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rDdoNQez; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=rDdoNQezRmH4za08qbNCJhpEWt
	ISDQ01/z8zLaw1iGQEq8XyDDj3mVrYN0jKytOa9boe6s42iy8xWWVpqB+s4lwrpa+mFpyeZ6jiF3R
	IDby17kmCPewI0S5tN/L0FC6v7PWUMPSy5IpaRe8eyL1kXRZuZYKp4aYaEGB47XP+hwTZoZOSIQij
	d0aClqiiWC0uXEh/dgBg+YTX1ygg8a+t4JnaplSB6lngdIAqsHtJ4+HYRcSMfqzwRdYjTO1pwK7eV
	UV8I3m5nnLtgZ7lsGuOCDgIsgHWdV8V4WtP7zlUXau6mMByyciaIsSMwy5P66tOUZDoeR0djO1u4V
	TcblTUsQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vW6UT-00000007q7D-2TCB;
	Thu, 18 Dec 2025 05:23:53 +0000
Date: Wed, 17 Dec 2025 21:23:53 -0800
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: brauner@kernel.org, linux-ext4@vger.kernel.org, jack@suse.cz,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	gabriel@krisman.be, amir73il@gmail.com
Subject: Re: [PATCH 6/6] ext4: convert to new fserror helpers
Message-ID: <aUOP6Rtu98laaOFL@infradead.org>
References: <176602332085.686273.7564676516217176769.stgit@frogsfrogsfrogs>
 <176602332256.686273.6918131598618211052.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176602332256.686273.6918131598618211052.stgit@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


