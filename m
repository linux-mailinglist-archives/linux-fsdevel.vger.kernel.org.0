Return-Path: <linux-fsdevel+bounces-48032-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A67AA8EC3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 11:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD2C9174A0D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 09:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EAC717A314;
	Mon,  5 May 2025 09:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tc6nh99w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B0EBA50;
	Mon,  5 May 2025 09:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746435695; cv=none; b=k6AHm1VqDhSOcu1rYLYUIg8k4OOvm2ZOcEUH+qkDVgKHzyoXO/37vyR51AdcQfhnX8WE6J/IocVKwzKC1wnZgRe1vTo1QflaaKCb4BqD9akJW5ijgtsNsKu9Ut4g7TX55Bs8N1Ld2p63uA+Nkmw1V/iR7x22vpYliqz/Tg9+D2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746435695; c=relaxed/simple;
	bh=Dk9FbhVMVmmMmGk3T+bxr6YtYSMCfxyUQfOf8IY1has=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FRUhoV0p0jHBbf7FxloGHhX0z0uMnt7XjZErQlCdDL7YMqewwpEJBQ4Tkwzi/LVIHbCSB3Ocv8oB7thX8rr/R7OxSefSAtmpGhfrvxQuu7uRcWB4ZZUt+oj1cfCs5886pYGuV8bPduDMdGWiP/Pn9/GuwO3oN4dkF86bWjefvjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tc6nh99w; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Dk9FbhVMVmmMmGk3T+bxr6YtYSMCfxyUQfOf8IY1has=; b=tc6nh99werrqceL1JxVepiACv+
	lCSwaA+uFRWGvtbWGkWWB96CKvrh5j6b6LDSWyKuiTDwV11zYOeSSZUBrJz+ktkUx16UZnbNg6LYe
	Vn96IjaYlvbAB17Npm/VvDlMrjom5rwF6AiIF9/H3JdE7xY15wMIQIBAZqv0qBcZszMdIRq0q9MtZ
	qHni9Nr+8APhILF0Vt8B0DuCsKNvg2SmMMKdDJFadMeSQC2rygCe9UCexZwYcj/Q26geK/IZnBMgS
	LXIl8B+xb02lAK+GU3i+6vT5jlKTiK+ikOed9LQo6vqRcxyO+eE+0f30yH1O/fAEBbK7lwQcvFsBb
	ZcashazQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uBrhd-00000006r3d-3yuD;
	Mon, 05 May 2025 09:01:33 +0000
Date: Mon, 5 May 2025 02:01:33 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 3/6] iomap: drop pos param from __iomap_[get|put]_folio()
Message-ID: <aBh-bTBpJMZiOqaI@infradead.org>
References: <20250430190112.690800-1-bfoster@redhat.com>
 <20250430190112.690800-4-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250430190112.690800-4-bfoster@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Apr 30, 2025 at 03:01:09PM -0400, Brian Foster wrote:
> Both helpers take the iter and pos as parameters. All callers
> effectively pass iter->pos, so drop the unnecessary pos parameter.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


