Return-Path: <linux-fsdevel+bounces-66675-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7186AC281FD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 01 Nov 2025 17:03:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 882F03A5319
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Nov 2025 16:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E6B1DB15F;
	Sat,  1 Nov 2025 16:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="L01lCcPm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A122634D3AD;
	Sat,  1 Nov 2025 16:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762012927; cv=none; b=semnW/vDdMqwVzKaY7mF/MArSogXqDuD0BlDgzOxHtxszHy8hpKvo5+PiU5MJoT3a8JbMmhlOsxJ6aagqL1hfQ1GGHntFDwiIGLEBlZ0yP+oWHW5eJccrJFdFIODgirr+padePmayAvG77Z2Jgy/YSoKc55i42K+UQKJj94sbGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762012927; c=relaxed/simple;
	bh=GbVR6kceTtyQtx+nPaggJRF0YkqFBaVBZbZLgE7tuGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KjgoJw5Z7ggHs1T5ghgN+hwcctu78e5Q6q2OGeVw8nJpGmf3r85v2s+DVLw92uyNou1T3ibfTjBaFWYCLVrg2aqmHUQJeGKC05CwV4pjex2h81Gbvmug0My+nAcwjkFFAZm9Oxpf6qaNbhvthgeBjHsncNGrZtyFgfVkmZXwUHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=L01lCcPm; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=achCPvh2j2Wq4WWIsZcSuVU5hHoyHWQc1iOhRa3GSPU=; b=L01lCcPm1a4ZGT3UvVExKFxoCu
	PB9/AXca28BEjqgYcLQTcrWQ8ANs1Kw+cuSQQC370hT8AZmFw0sunOYCpTk2z0i2R8GylMHsRCvkT
	JtAvbKMR0i2HYxY7J1y5PFPWmasH0Gh+R6gaP2332+h++6RN5e6gnK8L01DQWefCobTCSgCqx4dLC
	jY8UT5x2A68M0aRmVzg5a64KOJDM9HmZP5e8CWi/16WiS/yOLsGoZv5PTe+FWXFswBDT5wQ+s//d+
	WyqCezW5kAbqtGbxw6nO8+SHBkOf18ryGMa4viEewBrwokmpEnKa1vHozdXFWA0YDlmAYw+dr2HHF
	BS9BZhHw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFE3D-0000000GVZH-0qy8;
	Sat, 01 Nov 2025 16:01:59 +0000
Date: Sat, 1 Nov 2025 16:01:58 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC] fs/ntfs3: disable readahead for compressed files
Message-ID: <aQYu9jktrEAsx2y0@casper.infradead.org>
References: <20251028165131.9187-1-almaz.alexandrovich@paragon-software.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251028165131.9187-1-almaz.alexandrovich@paragon-software.com>

On Tue, Oct 28, 2025 at 05:51:31PM +0100, Konstantin Komarov wrote:
> Reading large compressed files is extremely slow when readahead is enabled.
> For example, reading a 4 GB XPRESS-4K compressed file (compression ratio
> ≈ 4:1) takes about 230 minutes with readahead enabled, but only around 3
> minutes when readahead is disabled.
> 
> The issue was first observed in January 2025 and is reproducible with large
> compressed NTFS files. Disabling readahead for compressed files avoids this
> performance regression, although this may not be the ideal long-term fix.
> 
> This patch is submitted as an RFC to gather feedback on whether disabling
> readahead is an acceptable solution or if a more targeted fix should be
> implemented.

I suspect your real problem is that readahead is synchronous in ntfs3
and the VFS is not expecting this.  Your get_block (ntfs_get_block_vbo)
calls bh_read() which waits for the I/O to complete.  That means we get
no pipelining which will significantly reduce bandwidth.

