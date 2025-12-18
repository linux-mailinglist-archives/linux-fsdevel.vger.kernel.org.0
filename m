Return-Path: <linux-fsdevel+bounces-71613-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB92CCA4FC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 06:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 99393303AC8D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 05:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55DC63093CA;
	Thu, 18 Dec 2025 05:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tIJWfgBW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A12A3081D2;
	Thu, 18 Dec 2025 05:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766035407; cv=none; b=Ad3o5OEpenU06ArENYmMXvcBWzf5dTaUer4AWteFhCGt2I/Ap5/+ITNDOJPdsdmMnuu+FML8J80Bklsp+CSmieGrovXf3tbz3aaXhRRPeh1vJ2+ETjv6PM5bM0OMtXD9iCAxfNufHmP5i8UN3nYghouZnewuTz8yLmw4ELkq6sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766035407; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LFUahVRcbmPAnwb4v/HmIoL+0XPe4qRh0Xi4C78gGlBqdsigLOnGoP8sV03VWcqilha61MWR5tqdf9tWvQroKukSEQNAS87tiMthUrr21CKKiA2xkXgOjixanALO2CfuY+foCoPwKBShBoIe2iZSY1jx+G25MU+gZS2/TzEhecA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tIJWfgBW; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=tIJWfgBWqlM1uubAemWh0rJqMC
	PEy5R86mfXiO9ptvpSVMfe8LEfd3/tY68mlNdtgKbWzYLu7/mx0otJ+strhCJyCyUwvYCcbU0jYR/
	kyGUlLLIlWnxnGDqhZZS8ms/I8OtoEFeQc2NRv1IEC3T65noMdvo0UMpl65mvUGGIJF1iUpoqI/1y
	U4myZKNakHdJ+8gg22ZmQ/xm/ieMi0CEdajolVgTTNq3TmXp8opzEFOpj5Iew/S+vmeLHTYEJRY0n
	IyXG0IHEeVgN8ery3schMw/qRIjKF9fOGHwjtnk5Eb6l1/+5dwJozQYJq3swRfNlJsU91nXljI/sg
	pKjggiSw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vW6U1-00000007q3p-2bsB;
	Thu, 18 Dec 2025 05:23:25 +0000
Date: Wed, 17 Dec 2025 21:23:25 -0800
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: brauner@kernel.org, linux-ext4@vger.kernel.org, jack@suse.cz,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	gabriel@krisman.be, amir73il@gmail.com
Subject: Re: [PATCH 5/6] xfs: translate fsdax media errors into file "data
 lost" errors when convenient
Message-ID: <aUOPzQ7sX9kK04n2@infradead.org>
References: <176602332085.686273.7564676516217176769.stgit@frogsfrogsfrogs>
 <176602332235.686273.16829192636161125674.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176602332235.686273.16829192636161125674.stgit@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

