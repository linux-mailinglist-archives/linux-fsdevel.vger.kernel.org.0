Return-Path: <linux-fsdevel+bounces-51224-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 700C8AD49D2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 05:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78D3C3A6018
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 03:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBAAE21ABB2;
	Wed, 11 Jun 2025 03:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="knOq8RMj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1377015574E;
	Wed, 11 Jun 2025 03:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749614178; cv=none; b=aKR6RkTvn+2q0pJN/u4s1mYS+BIOYndvKyoqNcjBctfZgnv/Ph0X96Np2ANqSaUZJYVkNDnqQgXhQJLnfIMZU/e/QOjLm+vdASj9AoKadaek4FRltU8zIzszouvnT4toqq+IY2DnrXqpa35Gm4Os7/u7yqS5XcTokUUdY20V6DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749614178; c=relaxed/simple;
	bh=TakiCn0iYNqL3fkV1d2F71GcOBf04x3FbIWGAYn29hs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N4kmuI9P1kXPl+kMUi7Q+kVRanFamBmP/WcM9Icu19m36LdkKDIrNkoBMfV6dygUpj+X5LiA//weRF7IOTgXcWM7hXZZEX2ExfnIMeHUKjdO/dkjApMCN6hYLmIdcH6/VznZXsB4b7K2YqrJvObQdxah3Z+igAJlqB2BWqduqpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=knOq8RMj; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=TakiCn0iYNqL3fkV1d2F71GcOBf04x3FbIWGAYn29hs=; b=knOq8RMjTg+6Id0sgu7EuFUvMK
	N+Pyr3NljPO9UBZrkzipnR4M+lB/BcrD0srOWMmceM1knkbQphZxAXooM/8chqVmnEJKjt2+w8pyH
	eq+lL4F15w2x5xfUesCYzC8Kj79oyUUMOTNQgE/zjroFtJ2XveJZ0/0jg+a/ssSlKmYdsU+kVaxfA
	gPNGWNuwxsMViZoKGNebkmRksd9mMccIU5ApsMKEoZYnoDUlAGomS7PdE+kxaErlWYa8FUt8B3jFT
	UqjHKnDZb+04v9UrDJQwa2efvq/eaqv/FbjjLRTjl4zdXi7/Gca/ZkKrmVWhRIb9mXDCZWpAbPZNM
	ipf87vCw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPCZU-00000008n8f-30mT;
	Wed, 11 Jun 2025 03:56:16 +0000
Date: Tue, 10 Jun 2025 20:56:16 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Brian Foster <bfoster@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH RFC 7/7] xfs: error tag to force zeroing on debug kernels
Message-ID: <aEj-YMAcEXC0hIjH@infradead.org>
References: <20250605173357.579720-1-bfoster@redhat.com>
 <20250605173357.579720-8-bfoster@redhat.com>
 <aEe1oR3qRXz-QB67@infradead.org>
 <aEgkhYne8EenhJfI@bfoster>
 <aEgzdZKtL2Sp5RRa@infradead.org>
 <aEg_LH2BelAnY7It@bfoster>
 <aEiDn1WDcv8wQmLS@bfoster>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEiDn1WDcv8wQmLS@bfoster>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jun 10, 2025 at 03:12:31PM -0400, Brian Foster wrote:
> Here's a prototype for 1. an errtag quiet mode and 2. on-by-default
> tags.

That looks fine to me, but it's not really my area of expertise.


