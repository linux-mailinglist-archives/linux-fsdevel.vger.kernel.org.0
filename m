Return-Path: <linux-fsdevel+bounces-65049-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2FFBFA051
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 07:05:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A73EC460CF4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 05:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD882DF701;
	Wed, 22 Oct 2025 05:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Hi06oMy7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7CE2D838C;
	Wed, 22 Oct 2025 05:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761109489; cv=none; b=CPDiENiUkxfLDDJDP7xCR6AtLM9elgsYiZp0pXJDUqgG9o25XPnXs2whOJQdkaPHcBJa2XM+FBuzyjoZVFT7l3+7o4NBSzRsqZTERY5oqH8REKd4ypXa465aSQsdsESOF6rZ5hQA/l1UyGieXxANsPMgqPNr7rvxvW9QdxGCgJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761109489; c=relaxed/simple;
	bh=jYV680jltiwzlWLpFXo6pbyAxsLr/Lqu0zWDBWyWXII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AY8CrOkRKPtiB/SGGx6TsqRxveNbGubZV0woTP3hL4dmi8G8V3AnbCmcLWQx4UuVdk8uy0nILBm/ZTL9uBCRHpdr/NgG3G2KjVVmprWNOyFkpKCocKj7Jp6EZ1+Ly1XZ9d+nAIYmralaoYXuWpnzOfutikwZGVkhlu3z2kNZ73A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Hi06oMy7; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5Smdjdq98m6eRqqjdmVHSHPPEy9QVATBpcC35WOmW1E=; b=Hi06oMy7rNYVyki85MGbBgUyFf
	GVNYzky2kcF5e4idbC8qUqD8qT85YSNOL2o4ywQM2lXTXlUSQssCcgO1bH2GyYFBcjT/AkVZq0E0l
	o2A84UhxOMbekDuN0BLkPnwb8xNZ2k+O7Id+Hsc7DXbznc6UraT7kmyQYBJELJhK4Fh8ASlaSHUKy
	oy6dSItstNbocE6ziqx1wWHL8AV0tU8LHyuyNzmI9yJamEugX04+Zrx4dKHLi7a6DKtW+G8Kr29nR
	T2Pc6nEE9MYoAyvY2Rf0xs9N5WabpMRZX8b4bGCHmmB/1s0YxyQ2xxA0WzSE5gEXBSnZQvqZn/Ud4
	33BxRXRA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBR1j-00000001UyY-0yaJ;
	Wed, 22 Oct 2025 05:04:47 +0000
Date: Tue, 21 Oct 2025 22:04:47 -0700
From: "hch@infradead.org" <hch@infradead.org>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	WenRuo Qu <wqu@suse.com>, "hch@infradead.org" <hch@infradead.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"djwong@kernel.org" <djwong@kernel.org>,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>,
	"jack@suse.com" <jack@suse.com>
Subject: Re: O_DIRECT vs BLK_FEAT_STABLE_WRITES, was Re: [PATCH] btrfs: never
 trust the bio from direct IO
Message-ID: <aPhl7wvyZ8b7cnLw@infradead.org>
References: <aPYIS5rDfXhNNDHP@infradead.org>
 <b91eb17a-71ce-422c-99a1-c2970a015666@gmx.com>
 <aPc6uLKJkavZ_SkM@infradead.org>
 <4f4c468a-ac87-4f54-bc5a-d35058e42dd2@suse.com>
 <25742d91-f82e-482e-8978-6ab2288569da@wdc.com>
 <f13c9393-1733-4f52-a879-94cdc7a724f2@gmx.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f13c9393-1733-4f52-a879-94cdc7a724f2@gmx.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Oct 22, 2025 at 12:57:51PM +1030, Qu Wenruo wrote:
> My VM is using kvm64 CPU type, which blocks quite a lot of CPU features,
> thus the CRC32 performance is pretty poor.

Yes, unaccelerated CRC32 is a bad idea.

> 
> I just tried a short hack to always make direct IO to fallback to buffered
> IO, the nodatasum performance is the same as the bouncing page solution, so
> the slow down is not page cache itself but really the checksum.
> 
> With CPU features all passed to the VM, the falling-back-to-buffered direct
> IO performance is only slightly worse (10~20%) than nodatasum cases.

I'm a bit lost, what are the exact cases you are comparing here?


