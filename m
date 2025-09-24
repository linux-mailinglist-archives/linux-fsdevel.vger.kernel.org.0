Return-Path: <linux-fsdevel+bounces-62553-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74EC6B992C3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 11:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C3772E5027
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 09:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 554DE2D6E69;
	Wed, 24 Sep 2025 09:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kI57BJlw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A1928B7D7
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Sep 2025 09:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758706505; cv=none; b=YXq1pKRUMeHxNTyzbKS6Q5ajKPwQDQontZ9ag+rgz+nS2Z5GYoyOkaRYkzE+LGrfLPYCXYKWzAVQ/q6OuO2CiJH0ut6VRdPmiNuWuHu0TF8wjRa/3vMFadG4cfTXOEfo7eOYHnLh/obMSKAFGvTs22UT2OhUxJRdYMAKQSKPFo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758706505; c=relaxed/simple;
	bh=EdSj7XyjXNLxblWCPzkm4+X0r8bfo8yjVByZdAGJVks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NDlk6T94eM6zok8EbRrEtGsukf5fr6xyH417DshQWcBvaDGT92a7aZgb4rYXGWXWHKWv+7fCd9dqvrhG8Sele3xtUGNk67RFeFOpuF288mvE1e/VFfq00jRABNYq5OU1m8CgzD+vGa1wc5aLjYSkOZYbYD/zR01Hg1YIUOBTcqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kI57BJlw; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ZAi7lXvEgORvZhBvHXD3X3G+zXby6uKr4YgM6Zs0hmA=; b=kI57BJlwwkJXejCp1ft3l/DMap
	jBBDotBFHrzd5ZatAbSLz/9L5dnZA/vdgITa/GHUxktW9IYaQcfjIsq+fHEEyyhjrPFMmImqDn/sj
	t9+qcyD2KK387bagEij72BCsTN+VUtaNO/uWLVefpvY/pLBwR3e64dtHYyVLPE2pXLxSTgoCMp4B6
	DciXgx8ZirhKQr4gym//FmFOIYGMcuSsl5SdgHgTjCx60c7A1KGPPVPVy9AlFyc8ys0/IUcu0pnBc
	6i1F2G7IJhDSJmM/J9A7FA1IGOjNUv4ZMHQZaoa4vm4ZBLH1hDTYEOkJgGoEiNrSFCl7grLfgZqtC
	fv8FeXdw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1LqP-0000000Cq2O-1vjO;
	Wed, 24 Sep 2025 09:31:25 +0000
Date: Wed, 24 Sep 2025 10:31:25 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, Dave Chinner <david@fromorbit.com>
Subject: Re: [RFC PATCH 2/2] fs: Defer evicting inodes to a workqueue
Message-ID: <aNO6baMim2tFMh-C@casper.infradead.org>
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
> > +static void deferred_dispose_inodes(struct list_head *inodes)
> > +{
> > +	unsigned long flags;
> > +
> > +	spin_lock_irqsave(&deferred_inode_lock, flags);
> 
> Why _irqsave? I don't see any interactions with interrupts.

Can't we enter reclaim from paths which have interrupts disabled?
I could easily be wrong about that.

> > +	list_splice_tail(inodes, &deferred_inode_list);
> > +	spin_unlock_irqrestore(&deferred_inode_lock, flags);
> > +
> > +	printk("deferring some inodes\n");
> 
> Debug leftovers?

Oops.  Thanks.

