Return-Path: <linux-fsdevel+bounces-17750-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B5F8B218B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 14:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 928B01F22279
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 12:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A1C12C460;
	Thu, 25 Apr 2024 12:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="4TbXn6nB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BFA12AAC5;
	Thu, 25 Apr 2024 12:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714047757; cv=none; b=fOKL2HLt/30kLbUZ5oAsqu2O8GT0OnV3bF+1UsqVtwyUzf5NXkBbYMUves9SxkFpj6ICJW0rjbdhkXVYtZud2icLc4CXxNomAkxHbnSljOi5QoDf9Vq5RjNwdDkpJHXTgVfeT4UCqPS8smfxen5omz3Z/kpH0Ou4sKtNMLCyA8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714047757; c=relaxed/simple;
	bh=ac90Xptu+LlZdA2H1bGYh9aUekchXQrWaju28h5LvBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MSuDLOgUpcTysxOxNN5ViLTe8nsCEFtRcHv0m1yW0zUlOl2Sq24c4N0AC0vdbeuyir2iZXhyGX3Z3EcpUkon5RYOscM17mjZX8FcZ+/C9q0dQP7VQ0oS0QIvwwk4kTjxDjyGtbRwEGawNP5szfyMhnAKpOw/b9oMCzFDZKH88Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=4TbXn6nB; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5kmdkkgmxltKWTQk4TRnBXqD+WYMw+Ii9wmT2IhgF+M=; b=4TbXn6nBSXtbGSFyjPidJ1dkTq
	kz/vOUst+cMP+R+woJCvf0tZuMWXcuOX0colAum5jIVBfBm/SXHNXBeeceqHvotdSH/HILVeE6koe
	cX9y+AEKR1R2rJaUaQ3oHb1hnnteqOY0OehYypL2iAbMc+DXeL7fQMDSYtD8WInPgX3Dw7QNR7sD7
	odBbDcjEWk5tVXeTaaj/0WXRP5Th7DYNboCY4dgxJ093XmvKw/c12GYHXui/ikYmMTr65HG28mqvr
	VsPCzIHWpTW2W1cKeCAlGmQONjP4Jp0T1sDxHWDRAzdxKdjxxUWQwdkGZ48Wfkv8iZZKxHHNiCap7
	iFlZDxNg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzy7W-00000008CMg-2JzU;
	Thu, 25 Apr 2024 12:22:34 +0000
Date: Thu, 25 Apr 2024 05:22:34 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, djwong@kernel.org, hch@infradead.org,
	brauner@kernel.org, david@fromorbit.com, chandanbabu@kernel.org,
	tytso@mit.edu, jack@suse.cz, yi.zhang@huawei.com,
	chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v5 4/9] xfs: convert delayed extents to unwritten when
 zeroing post eof blocks
Message-ID: <ZipLCm2N-fYKCuGv@infradead.org>
References: <20240320110548.2200662-5-yi.zhang@huaweicloud.com>
 <20240423111735.1298851-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240423111735.1298851-1-yi.zhang@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Apr 23, 2024 at 07:17:35PM +0800, Zhang Yi wrote:
> +	if ((flags & IOMAP_ZERO) && imap.br_startoff <= offset_fsb &&
> +	    isnullstartblock(imap.br_startblock)) {
> +		xfs_fileoff_t eof_fsb = XFS_B_TO_FSB(mp, XFS_ISIZE(ip));
> +
> +		if (offset_fsb >= eof_fsb)
> +			goto convert_delay;
> +		if (end_fsb > eof_fsb) {
> +			end_fsb = eof_fsb;
> +			xfs_trim_extent(&imap, offset_fsb, end_fsb - offset_fsb);

Nit: overly long line here.

I've also tried to to a more comprehensive review, but this depends on
the rest of the series, which isn't in my linux-xfs folder for April.

I've your're not doing and instant revision it's usually much easier to
just review the whole series.

