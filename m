Return-Path: <linux-fsdevel+bounces-70290-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 854CDC95F94
	for <lists+linux-fsdevel@lfdr.de>; Mon, 01 Dec 2025 08:14:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1FDB2341CE2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Dec 2025 07:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C15628A3EF;
	Mon,  1 Dec 2025 07:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GMcx24Uo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4DD27AC48;
	Mon,  1 Dec 2025 07:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764573275; cv=none; b=Mnuy0j5LjeP5dTb1UZhCLjT2e7r6mIilm2BpmpyqQgCzwUYzHfWDneCFZi3XPEXK07w6GAL7OY8UgProvN8GWOvwRci+eSv862LediEGN8M5xa0gqMtRrdKsw9cioaEAeYRgERXzYLj0ltWCAbPfghN7QMcSnVyAtmqpi5/pc3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764573275; c=relaxed/simple;
	bh=DCUQZr2JCVjhPR+jcbbd/6T4PqpQTkUzFJUoXY/1INM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dMHxaf3H/QFIqP/9Y8hrFCFKnDzfWLedWX/4y5BA+n+2FxOfkqUm3Tbch0f2/shv+MpqW92q/TgskujKUu3rzVsGGtUEm/svt0yTDg/sK6Gd2W/Qy5mS1CcnXiu5iymVnJN88segCK076JZ0E+7UuUCdSzTGJnhlXddsTjPEcQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GMcx24Uo; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=w76TgO2gc4NToIJI+HRr6lKiCP6H7bHq0pu1xOKR2Xw=; b=GMcx24UooOXrMyPkCX/+ySDTTV
	Tmcz/zUhPvwIG5EwrR/ddJ5+3BgkU8QI2jGINIS/SFqTwDPOL2g01dX1v6U89BVPkt7Ij06bV/MAR
	Ph0t5DZsX3sCL2Xd9fX2cchmnCHT5Z/yC3nHSRbQq2KAKYcvjg6LHd8n7A8xX0lIOFdaFm/vmDETV
	gweHo6FEL8iU+mNAEVeJEPqEQ9IjSijd867UHNmBWLsWAz88/X3CEHcUvCe75j9IBYzdPahcn7+Ma
	+Pn/GXcr7lILd8DBm25s/9ElKLVw12uCMK4159sTZcPI65669a2qTiUrwkFShhqG4fyd+94QSJ0lK
	Nvr9inRg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vPy76-000000032dv-0pEW;
	Mon, 01 Dec 2025 07:14:24 +0000
Date: Sun, 30 Nov 2025 23:14:24 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, hch@infradead.org,
	hch@lst.de, tytso@mit.edu, willy@infradead.org, jack@suse.cz,
	djwong@kernel.org, josef@toxicpanda.com, sandeen@sandeen.net,
	rgoldwyn@suse.com, xiang@kernel.org, dsterba@suse.com,
	pali@kernel.org, ebiggers@kernel.org, neil@brown.name,
	amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, iamjoonsoo.kim@lge.com,
	cheol.lee@lge.com, jay.sim@lge.com, gunho.lee@lge.com
Subject: Re: [PATCH v2 01/11] ntfsplus: in-memory, on-disk structures and
 headers
Message-ID: <aS1AUP_KpsJsJJ1q@infradead.org>
References: <20251127045944.26009-1-linkinjeon@kernel.org>
 <20251127045944.26009-2-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251127045944.26009-2-linkinjeon@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Nov 27, 2025 at 01:59:34PM +0900, Namjae Jeon wrote:
> This adds in-memory, on-disk structures, headers and documentation.

So a lot of this looks very similar to the old prematurely removed
ntfs driver.  I think reviewing would be a lot simpler if we'd
find some way to bring that back, allowing to focus on the new
code.  I'm not sure how easy that would be as the old version
probably won't build, but a modified revert that doesn't wire it
up to Kconfig would still significantly reduce the diff.  Especially
with the rename back to ntfs as suggested.

I can see that you don't want to do the rest as small incremental
patches, but even a very small number of larger patches ontop of that
base would help a lot.

> +iocharset=name		Deprecated option.  Still supported but please use
> +			nls=name in the future.  See description for nls=name.

Is there much of a point in bringin this back?

> + * ntfs_read_mapping_folio - map a folio into accessible memory, reading it if necessary

The very long comment for something that is just a trivial wrapper
around read_mapping_folio is odd.  Also why does ntrfs need the special
EINTR handling that other file systems don't?

> +/* sizeof()= 40 (0x28) bytes */

You might want to add static_assert() calls instead of the comments
to enforce this.


