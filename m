Return-Path: <linux-fsdevel+bounces-63894-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 89087BD14DB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 05:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 60E184EB28C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 03:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1090327F4CA;
	Mon, 13 Oct 2025 03:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SeTGEPux"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B4721323C
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Oct 2025 03:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760324477; cv=none; b=aNUcpQ6dkDP0YRbbBITqy6D4fxfm/JaPd9psCi8TuC4DAgrL2av1ZrSXCrST6WociQcH/CIEX4SCDMPepMT12XvU1L6bw93jhiAT9fW3OdvHwTQDcZ4YN7gdXmkti6gpUZViMur3W4Lr5+dCmEgx8p6SrpF6WsDDTHS0o9/kp9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760324477; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zbptx0sb7jYjwo3zl0prZoIv6QhN4rqILtzzJZpNeZ4kFUSA7lFQbUJMINhPV/rJHlxz72B1kTMuaTY1rRcClwuZ/ycij68Cwj15E0omGiiIDa97C41ZLO3cX5JY+ngNw5cOpERzKnL57aBRhYPTT0J6ifugmBeOBrxlsZZ4ep0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SeTGEPux; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=SeTGEPuxKObb20BXF+P4D5F90M
	lLUC1MD3HsYtntjLvxqrRPPVRH/OsXhJwT5jY8Ou++ffLxfjKqFi+1kfx/nfD1dkoN8etLHGTGWuD
	/ylheU99u/l2oU/PtrrgXE1JR04XZWvSdnviA2gazKeZmIPQHmJs28i3fb4Gc2X+zAvm+kcXyNVQE
	gwdW5i1dAxq/ymy68JOtWrN9AGxmox49OJDQ4nRo0o3pugDhmLnNvaCeG7iA1waA6gW0NC9HlecVO
	5HdIlUFPO/tbqQzGiti2Gm2t8EbndC7yS6JWLWqzPUTbD+WaKFzREguL9l664xxrg4YFrYUK9/cqj
	JBzdPzWw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v88oE-0000000C8w0-4AVw;
	Mon, 13 Oct 2025 03:01:15 +0000
Date: Sun, 12 Oct 2025 20:01:14 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, djwong@kernel.org, hch@infradead.org,
	bfoster@redhat.com, linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH v1 2/9] docs: document iomap writeback's
 iomap_finish_folio_write() requirement
Message-ID: <aOxreoOl1LcwT-l1@infradead.org>
References: <20251009225611.3744728-1-joannelkoong@gmail.com>
 <20251009225611.3744728-3-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009225611.3744728-3-joannelkoong@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


