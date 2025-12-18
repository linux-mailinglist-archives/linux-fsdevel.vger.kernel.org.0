Return-Path: <linux-fsdevel+bounces-71618-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E3635CCA542
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 06:27:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3F2EB302EE74
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 05:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D610330BB97;
	Thu, 18 Dec 2025 05:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="28KBAo7H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1909A309EFA;
	Thu, 18 Dec 2025 05:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766035665; cv=none; b=gGPdhs23JY4d0K8KhMLLm+2JlyyqYeJT8eT5itS7hTT7I2bmh5JqA3JdRseOJqFynByLFipI0O9c9qz2iPsmuk9UcVdXtFek0x4kpzhMJpMo+EfD8KTM/RVBDPljbiyrDUrXdftAY3bTRujwnycoOSgJGWLIywOf+JF79G0NouM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766035665; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eMR6LMpV8Jz//uXOsvXwRPWax6GPbdwf+69xl31WjiqWs8qmMjIWl8JBJkuA4mOaIaiKzA1Di+Rr8C8zfdTFTuy4sPKD7GHgqKkGQeEjLUmNCV9nSP57ylL57bDfLUzSzQVgO2PCZFaVYTxqdv9pHbNC6XUmK9BWLBdQdSb62SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=28KBAo7H; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=28KBAo7HjnbWTuL3xfxsPubFMH
	qR+Zk76X4m+bjyA2KAn42hNsd7ppN+9KKZtijFhiLrsSOnAeullz7c6e9Fl2NEb6v0IAEKTQOEGXZ
	WwsT/fjIkzvlk1B/JdSe+nORW1SodVt8szzS5Fraqn4uRmfPEqA7Tlby4B3BcC291JEvfZeDzg0/Z
	BMKlC23TruU8bcJv6UHb+pyHNE6Ypbbd6YI1m4M6abcd7+9UgeSD6tBdACNHKL6VMJMXWXNVKMTq1
	so1bXtxrEO6VoLaq5gg4LSnTwwvuzEcahgJ8UdFSTXhozLRBgauzbfSm0wjZ1TuJrXe8hFF58G3Vm
	mFxfW0yQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vW6YB-00000007qSx-2Utb;
	Thu, 18 Dec 2025 05:27:43 +0000
Date: Wed, 17 Dec 2025 21:27:43 -0800
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: brauner@kernel.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 4/4] ext4: send uevents when major filesystem events
 happen
Message-ID: <aUOQz41_6_D7PF3Y@infradead.org>
References: <176602332484.688213.11232314346072982565.stgit@frogsfrogsfrogs>
 <176602332590.688213.9240067999700074165.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176602332590.688213.9240067999700074165.stgit@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


