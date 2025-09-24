Return-Path: <linux-fsdevel+bounces-62554-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A745CB995DA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 12:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F28172E3469
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 10:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1352DBF4B;
	Wed, 24 Sep 2025 10:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gOPdSeqi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B09A2DC772
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Sep 2025 10:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758708469; cv=none; b=YstiCjeHBnUE6xVaQuaCQWZwJ9lacPekHlUKa+tfCBStSIdceDXpiJtrDXNG+YIdoPfnZyBLRJdRtF0N+ITSY6O5A7Yd9irVBi4yMtctF2wzVa8gLKpMQdHVD4ZKcQtzfyJNSauJvmXdKYUamgt/OVDGUYPUO94htpjQePUcJDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758708469; c=relaxed/simple;
	bh=sYKyi1GljDPwyYCKK9pNWe4UDLItnRQH0F7TSJIA4GQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z9Fy7bsZzIzRBz1/L/h3l7CQE0f8MKCx1i3Q0wZjOpdbL6Tr7Kf9bIFC6v78PdAkK4f3n/vKz7CJ4jeNp9Yy+tyvv5mozmlR3XGVbuiCj5BzijiKkj/y4wU7u2fGjLc6+NByENn1XRAKQdFPiYmBC0VLwE7hueHDMABue7PGTmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gOPdSeqi; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6xexGhEpQJpQHFxvgBZMOZzRQSZThCqrEbn8o11z0IA=; b=gOPdSeqimbiDMkkIcktabh1LxM
	CP0voVusSFWVskOFNzK8Jl8SyUzDQ5/aAe1davbwZVc/r7HLk0FN1sWbjGyLiB7alKTbhpAh+ec+J
	zbYjP1+T+L58LaLVoPCp4DR1DxC8sL6qJk5WcbWIPUMKf+xKbWyfMHDIcpJ0tIAAWa8U/S76bGroy
	cySev/+6FCDUfEFQNzwYWI6BaZxU9m0oyDUcgIfeibNig7z25KtpKCZh+MoNd3fkn92zuhlhEAGTi
	uHMa2tfIxXoUSwoBWuCdfv+KIUq8oKrM5HESWDUr+m5QVM5StI2ewQFLp1GWbwbptGCRfJKlkXMrR
	rofUuQPg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1MMP-0000000DFZo-3khG;
	Wed, 24 Sep 2025 10:04:29 +0000
Date: Wed, 24 Sep 2025 11:04:29 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, Dave Chinner <david@fromorbit.com>
Subject: Re: [RFC PATCH 2/2] fs: Defer evicting inodes to a workqueue
Message-ID: <aNPCLcx6lbZWKrYz@casper.infradead.org>
References: <20250924091000.2987157-1-willy@infradead.org>
 <20250924091000.2987157-3-willy@infradead.org>
 <lofh4re5cnuc4byeude7idmf6m27l22tizpd4uqdmhsyochdm2@pdhq6y5plyya>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lofh4re5cnuc4byeude7idmf6m27l22tizpd4uqdmhsyochdm2@pdhq6y5plyya>

On Wed, Sep 24, 2025 at 10:28:09AM +0100, Kiryl Shutsemau wrote:
> > +	printk("deferring some inodes\n");
> 
> Debug leftovers?

$ grep defer kern.out

I have low confidence in the correctness of this patch as I don't have a
reliable reproducer.  I haven't seen the printk trigger yet.  Maybe I
should force it to trigger sometimes.

