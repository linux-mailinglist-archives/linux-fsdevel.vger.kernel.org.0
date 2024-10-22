Return-Path: <linux-fsdevel+bounces-32575-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD979A98E0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 07:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1ECD2849C9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 05:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14CE913AA4C;
	Tue, 22 Oct 2024 05:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Q95/yiVp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986D91E529;
	Tue, 22 Oct 2024 05:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729576052; cv=none; b=uxNPQfcfw4OxK9+NWV8qbwGHcrL1ksiFVMRZ37HqeQ/I+wztwRts4f9EwoNjE5pjYLNPnuNC6861h7KNDSNNkOqxFEU3c8akSx7Srz20DjDOQ/0h+1ypbgCkkOjHq1uelOkNOBX7iNrS/FEh8ruehLf9rm7299PmZhECyHw4tQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729576052; c=relaxed/simple;
	bh=LPuixlA46B4UAAi2n/d5wOwtUkJPAHXBRr5naLlXK/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VlvbN7LBtpIyOfDSx1F0fC2jeYQ8RwEZ7YWk8bZq4fLuwUpMqOcBupdrTabt2tUY6zlNFhx2PvOGetYTAFtvrTjKKubRuX7BX+J99Jo1s383+l1cxjonXGIGl/JkmIvkk8+xB8BMe7pZeWQXenV41LY7q9RddI5Pu8OB3PE1kSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Q95/yiVp; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=GV0HOySxp39Kq8vKvXCDAfddUtjmlYH3wufNENw9DY4=; b=Q95/yiVpXZwfE8aKoOBD7q0GN5
	XvWgKLST+1HBiNDrvOJ3Ma10nDNXEIzpA0zT0ehcpxqwC85n4UFfTnxkDiPbRc6uH1nZV1Ish3xtJ
	QMPn3MvJwJ4thKRrzYYEkh1KIvoAiUcXLP6C4UMPb1/WrFKPsJ89VgvLKVQrepX9i66lkSDl5wh8V
	Idj1spgmTZ/p2LbPdsow8WZje89sh+6LbNS9hndDnmYcDYHcZH4SJ95Vosw4A0/sFd0SlkSZvbO3d
	fCsOhObX1D4H8/5AtDdaTNys8CFdTDm4g6pBY40/oRvSZH8bjnXuXTChQYXHKp6tJglsEZXnxMJuN
	xkDCbGVA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t37jn-00000009i5U-0Ell;
	Tue, 22 Oct 2024 05:47:23 +0000
Date: Mon, 21 Oct 2024 22:47:23 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	gfs2@lists.linux.dev, linux-block@vger.kernel.org
Subject: Re: [PATCH] iomap: writeback_control pointer part of
 iomap_writepage_ctx
Message-ID: <Zxc8awN_MHkuNhQZ@infradead.org>
References: <326b2b66114c97b892dbcf83f3d41b86c64e93d6.1729266269.git.rgoldwyn@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <326b2b66114c97b892dbcf83f3d41b86c64e93d6.1729266269.git.rgoldwyn@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Oct 18, 2024 at 11:55:50AM -0400, Goldwyn Rodrigues wrote:
> Reduces the number of arguments to functions iomap_writepages() and
> all functions in the writeback path which require both wpc and wbc.
> The filesystems need to initialize wpc with wbc before calling
> iomap_writepages().

While this looks obviously correct, I'm not sure what the point of
it is as it adds slightly more lines of code.  Does it generate
better binary code?  Do you have future changes that depend on it?


