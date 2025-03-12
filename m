Return-Path: <linux-fsdevel+bounces-43766-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A29E4A5D73F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 08:24:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FE73189D1B1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 07:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473031EA7D7;
	Wed, 12 Mar 2025 07:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VDaTM/QZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA3D1E9B07;
	Wed, 12 Mar 2025 07:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741764242; cv=none; b=oCBoMIXuRU+FTJCu7y/FJxSXr6ctv8wAKz8xYt9+hLTX0BwEQDD0WeTxqUnILKJqnDz/PCkBDJCF4zLD0aHtZP/i91NkD1WjX19vgwPYxCPSVugmsA8+e11ac85EHZvL/fpVVu8qJxkpOJ6nKGjgbGU1+4cNu3NNvriLb5fydXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741764242; c=relaxed/simple;
	bh=AJNGKMUYdkDKQJYNTNfZpN6r4y4CvwR+lnsI6mq05x8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NHAvbBjgeVq02vjTsWIO624dbjNrFpYQ2RqsM4DiG44aX6LYIC4uzyUxwxMbI4wwGHHvTweUAdvfbWpG4MeVLjIW1WsP5cyRs2KUN7RNRDJn0AMz74Qd4XXBlhHQ1meP21hyDVO6F+POOqFn/u3LBAdciya34Qs1Bt8oflYqGqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VDaTM/QZ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+jDHe8GiMC72tdyv506IKhWnJAN4V5D48aavkbObk+I=; b=VDaTM/QZvChCk38bb1ZfhfzIjo
	ikKpUDWn3KVgA5U/OmNhIQ6zfztIWd7s92PkgTWFT2QTAH2X/0HCt1TtF90pwYsIBZcx585h1nqjo
	jkK7CANBRd29CivPqDP6HJAeU6iQXNKXD4CUelfzHSR4LlSIQ0p/QwDI+vVTRmvhnteKtH2gzopzO
	A43tEIpOZbE5hffBo/OxmrKyJLtmgq7j5mD/ebOY1u5L5cQGdf1UfMkavx31lk6Nod7d8Pa4jxIZw
	tHHvoA6o8q8DRW967IrZapxcquyMM/qdMuuuXH8iVWiCN+p6noiJOCCYRPNm4P0KHUJGHe4O4+JzN
	sC/MjHKg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tsGRd-00000007h7S-0SkS;
	Wed, 12 Mar 2025 07:24:01 +0000
Date: Wed, 12 Mar 2025 00:24:01 -0700
From: Christoph Hellwig <hch@infradead.org>
To: John Garry <john.g.garry@oracle.com>
Cc: brauner@kernel.org, djwong@kernel.org, cem@kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
	ritesh.list@gmail.com, martin.petersen@oracle.com
Subject: Re: [PATCH v5 03/10] xfs: Refactor xfs_reflink_end_cow_extent()
Message-ID: <Z9E2kSQs-wL2a074@infradead.org>
References: <20250310183946.932054-1-john.g.garry@oracle.com>
 <20250310183946.932054-4-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310183946.932054-4-john.g.garry@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Mar 10, 2025 at 06:39:39PM +0000, John Garry wrote:
> Refactor xfs_reflink_end_cow_extent() into separate parts which process
> the CoW range and commit the transaction.
> 
> This refactoring will be used in future for when it is required to commit
> a range of extents as a single transaction, similar to how it was done
> pre-commit d6f215f359637.

Darrick pointed out that if you do more than just a tiny number
of extents per transactions you run out of log reservations very
quickly here:

https://lore.kernel.org/all/20240329162936.GI6390@frogsfrogsfrogs/

how does your scheme deal with that?


