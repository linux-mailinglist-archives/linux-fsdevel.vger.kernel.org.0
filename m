Return-Path: <linux-fsdevel+bounces-57479-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C41EB22064
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 10:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F37D3B20E0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 08:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92972E1C4C;
	Tue, 12 Aug 2025 08:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fHn8xZcb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE652E174A
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Aug 2025 08:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754986019; cv=none; b=Rvxoi2eEHVvuBOT/znVnWBsIot0DuNPDXtCVKtVob0AFyfnbENVGGfsAg8gaVFSh0eBIe5KbZ+wDfG1k55DnOnePSEQ8jQgOVxcB2GPHBS1eLh0TObrOSTZAwut9D5TrLXmpJsOBJTSH7Q8qVzop//pT1vyTqhrjA86LSo4mCXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754986019; c=relaxed/simple;
	bh=MVuBea6VpC1PMtmAq9faKJNX7R/TAo4v/B6y33Q4vAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tM8M8x+cg6H1AGBh0Twj61HCf7tfiDf2U0SfxYcPYgVw5P4j/l3QBnwvYupQ9q6girtr3asVqAqvl0n31CfXEhWBGKD3ym+5QijPVm3//3KJIaifwFHUYPTZmEjjGpammn/bvV+uGgmL5sTakQrWnhx7I0pcRnbn8p72KAJig80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fHn8xZcb; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MVuBea6VpC1PMtmAq9faKJNX7R/TAo4v/B6y33Q4vAU=; b=fHn8xZcbSHg1Xl1P1bPlqfUGPi
	T0pvdLqx44yA2a7vGi0h5Em2B7BUIkKu2hjLQ6I8OM/0PqL9MfTryXHeSfOKfLz3GgdxHfa9ccZSO
	zG9Rcg1mbqWSLo4u+FSb6IdQ/M+ylTJtFcyqRrJvi387wZ/mUo3C7wQRynA2JKKzrVrAI7f7SP2GT
	H0YV32SIOPttO08YKAElC9m4EpgPxK/8M/izBJFPvk+WFfYGeD9SEb9owdB9PzEbGwi7wrUmzNdQt
	CZLdPEbVcIC0Dr11iLvweIa/x5fgY/IIfiqMOq9TfuzozcXLmJccUPByet9E/vW33lTk5L0rldj3a
	nCyki3eg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulk24-0000000ACPJ-2P45;
	Tue, 12 Aug 2025 08:06:56 +0000
Date: Tue, 12 Aug 2025 01:06:56 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: linux-mm@kvack.org, brauner@kernel.org, willy@infradead.org,
	jack@suse.cz, hch@infradead.org, djwong@kernel.org,
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [RFC PATCH v1 07/10] mm: add no_stats_accounting bitfield to wbc
Message-ID: <aJr2IMd7uqhLJ9qb@infradead.org>
References: <20250801002131.255068-1-joannelkoong@gmail.com>
 <20250801002131.255068-8-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250801002131.255068-8-joannelkoong@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Jul 31, 2025 at 05:21:28PM -0700, Joanne Koong wrote:
> Add a no_stats_accounting bitfield to wbc that callers can set. Hook
> this up to __folio_clear_dirty_for_io() when preparing writeback.

Please explain the use case for this a bit more in the commit log,
and maybe also the comments.


