Return-Path: <linux-fsdevel+bounces-35383-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1089D4758
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 06:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDC291F21293
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 05:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3461A3031;
	Thu, 21 Nov 2024 05:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pp7kSXHu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17902309B6;
	Thu, 21 Nov 2024 05:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732168233; cv=none; b=mgXvfxi6F6u4lKkAd8w8Tod0MqCJWi875QKyGJBkrl2JBnaveRwE8f+0wOMR6vUi9D7XMkE7fDIzPN8AI/9QzTUPTDYSd4E+3lq4FAnp2lHTFoNeUqWjkvTdhE1rVaefZwbPX9Qn95fIKR/FU+Abtq/f3Ksp0nACW5Bv2z6Ge94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732168233; c=relaxed/simple;
	bh=nvXfyViqS8LCLM00OqtDJk/QnbYHncc30lID0GCtAu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l3s0HPuwgNEvbSj2FcPo1JDCMN0lWIklQEexY+OgbXELu78OZ8r3OnGjDVOgmBEPu94YKLMsVd5q5rz/lGKQ60zfnqhhBZMgXiL44YuYX3FTqHGCzzyedZvK7vve4DktNT8i8e+iS3vzp6kTT6SszpY475HDOCP7eSiFuFIVbJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pp7kSXHu; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cJDKVtehceYdWBkDKuNTF/7o+fpaX41PEifjB2anWfc=; b=pp7kSXHujb2fm3981IiuEa5pDB
	fFfaf+3OO2FBTtuIhsQkeO72uwM3Erj/9zBtPG9hcRGAHhj84LVMkRxR91yoOhU8invWHbvAMdqBK
	gD01mw4PqZAiWy5WANaaVzMmndyoAdNvp7lNPSwhPIQPIpi+ylCd05kPmXqCpKKy2D/Ps1L9VaUM7
	cvkNmfMkVJTsmasmQAlWY9VBi+rfUcCRu6nj4qNihjPKaxe6bcSHRMxhOD8DnNJNrTlqB8WUUl+CR
	wW1THFJsrrdf6wQwUfj3QHUPYxdvaH8M10nOi+5F/twIP1rTnd7lbFcIj8NYhFWTiZdkte3XR6OdP
	gE8a4s9Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tE05H-0000000GsnL-1UHz;
	Thu, 21 Nov 2024 05:50:31 +0000
Date: Wed, 20 Nov 2024 21:50:31 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Brian Foster <bfoster@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH RFC 0/4] iomap: zero range folio batch processing
 prototype
Message-ID: <Zz7KJyLEUSHkoO6_@infradead.org>
References: <20241119154656.774395-1-bfoster@redhat.com>
 <Zz2f1c4mjR9blfTg@infradead.org>
 <Zz3yPdRxSguEU2qc@bfoster>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zz3yPdRxSguEU2qc@bfoster>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Nov 20, 2024 at 09:29:17AM -0500, Brian Foster wrote:
> helper, I just wasn't aware that some things were already doing that to
> poke at the iter. Thanks.
> 
> I'm assuming we'd want this to be a dynamic allocation as well, since
> folio_batch is fairly large in comparison (256b compared to 208b
> iomap_iter).

Or at least only add a pointer to it in the iter and then point to a
separate stack allocation for it.


