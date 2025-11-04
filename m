Return-Path: <linux-fsdevel+bounces-66925-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AEBAC30AEF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 12:13:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C8A918C062E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 11:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C76B2E5439;
	Tue,  4 Nov 2025 11:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="S7kwAiMd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612CA36B;
	Tue,  4 Nov 2025 11:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762254776; cv=none; b=nPImI0Zf+KKYP6XkQuFr5g1BtpwVN6FxmZ7kE+oZpbWv2OyQr1zGF/dVzbiPPxVP1wuz56todMwLpXUUKdrSBmA7pMyyLlKKSgZBmv3atEzSCaF8OavrU3NVGxPJK4BZugbBKAGS1EBeUok8lAS68ObaF3Muj86p0qMZk0+PCd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762254776; c=relaxed/simple;
	bh=OpWX+foqfnfVodeUlM+nUC+uja1ui9cphTvBtdVgRYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=chYIOWjkDrv+wCfT4+raVvfuqbw7HSCQ5aFnAo9aZnzG2PItdD8BiDUcnTOxztOUp7MZt025nCnoW3MkadRIUNHcMB5z6FOmgV26BESP16Uephdl38iFpchx9dm0B2nzadmJlgcw9qK3hzYa63f1HNW64DHOp8yVWPf95dhLamY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=S7kwAiMd; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7yAVNSF70WBsCfrSGA26Vb3Q9fP/h5EBb7E4JOR7jYw=; b=S7kwAiMdOrx5kAQ/5Vtrqz4wW6
	5DDtb2TN3VGzHyxpRYhD2RpYWxf4HB6CkciKdOCQuiT5U+y2moi54TEUfrRzXnVrUZBA7IgA7OZ/N
	tnSTBGQEV5Se08omYb/eNzVFTSdTubrBXoWe8U5FwhQblsbVYrliwpcWo1vmImu0FAho+K2yEDf4o
	GsHk/NHtJScCOSR5aw5cTLK29mWCUwoFpvBsMH3GPUs2UXQTxEj+9JS8VYV6ksdoavhw9943M2tWc
	ujbAOzk41nS+cxBAwIKPwOX0X4H5M7upirOYkY3CyqrDrYyYVaERpmg+EZ4yStZ5eOfn4GNmbLnFE
	I/Kqjl0Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGEy5-0000000BhAt-1dn6;
	Tue, 04 Nov 2025 11:12:53 +0000
Date: Tue, 4 Nov 2025 03:12:53 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Yongpeng Yang <yangyongpeng.storage@gmail.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
	linux-fscrypt@vger.kernel.org,
	Yongpeng Yang <yangyongpeng@xiaomi.com>,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH v2] fscrypt: fix left shift underflow when
 inode->i_blkbits > PAGE_SHIFT
Message-ID: <aQnftXAg93-4FbaO@infradead.org>
References: <20251030072956.454679-1-yangyongpeng.storage@gmail.com>
 <20251103164829.GC1735@sol>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103164829.GC1735@sol>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Nov 03, 2025 at 08:48:29AM -0800, Eric Biggers wrote:
> >  	*inode_ret = inode;
> > -	*lblk_num_ret = ((u64)folio->index << (PAGE_SHIFT - inode->i_blkbits)) +
> > +	*lblk_num_ret = (((u64)folio->index << PAGE_SHIFT) >> inode->i_blkbits) +

This should be using folio_pos() instead of open coding the arithmetics.


