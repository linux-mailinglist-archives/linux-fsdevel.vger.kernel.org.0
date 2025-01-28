Return-Path: <linux-fsdevel+bounces-40203-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A17E0A2043B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 07:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1A481662B7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 06:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B8418F2FB;
	Tue, 28 Jan 2025 06:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KrJL8bKI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A65C768FC
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jan 2025 06:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738044520; cv=none; b=TVSo/8CB7ndGT6+8lsYw1M15/0aTw7ezjPLK8kZWj3HX1zrFCxQ7WpMWeBcM4U+Wr+NyxAFmzsrQch4YuQf9nrxYLqznAzB2eHBUcCyKcmCgoMnBSron8hY3voW2NJaPB1JhtaIU6TVAcj8niMyxR48T4RrgpbrwWx5vnYhZtOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738044520; c=relaxed/simple;
	bh=wGqbzLb7H8hKFZmr+079GrVU6xTkQupZY6OwcIlg39k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mGOFb2wOV9A/hGV5QCAcqYPuSuk7GlXMsYt8aA1kat9i6Pyz5PcCRR4epsjhnzdhcvOLTpZqQMypstVgTjeCmnZVpJ28iPTtcW0giX+/UsalFbYOdz1dI7DNmirWzUnqpTUqs91dw34lJ1PP9yvysUPfEbUMCFxnoc60yCXRPSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KrJL8bKI; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=m7J43WE7MA4MxiFRjzLzeWSXV1Nn+G0C/UZkHBVtdmw=; b=KrJL8bKIxjzh9oEZjwgRP7vGXk
	vqxIwCAY3Nv5frKx++WAPmd0ZQBHdepdThovaN1YNZG/rT4shs/n8sfOVuWn9neI0u/GlqePH8DVZ
	o4Z0o//jd6rTpqYQd2C0/2HYYMZTy2RYuDAHq/lak/OfHZwWL+Af5zPTjY9Qw7CJGSqrz4Xw0ONyP
	HWp/GNLeHZJFWujkZLha2C5+8D31XWiy/NZzJ4kNqqZin3HdaKES7SKOvWKXRtsZZDoY1qeQySYJs
	ZeI/ak/BJPQSbGEpk6jAuGGyczUIgGOc+r3bYUHT0yImoFJhB7SNxki7wM6MvsLOJg9olKxHPRsfq
	fY2rGrJw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tcelx-00000004BwN-1No7;
	Tue, 28 Jan 2025 06:08:29 +0000
Date: Mon, 27 Jan 2025 22:08:29 -0800
From: Christoph Hellwig <hch@infradead.org>
To: David Reaver <me@davidreaver.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tejun Heo <tj@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>, Jonathan Corbet <corbet@lwn.net>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Krister Johansen <kjlx@templeofstupid.com>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/5] samples/kernfs: Add a pseudo-filesystem to
 demonstrate kernfs usage
Message-ID: <Z5h0Xf-6s_7AH8tf@infradead.org>
References: <20250121153646.37895-1-me@davidreaver.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250121153646.37895-1-me@davidreaver.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jan 21, 2025 at 07:36:34AM -0800, David Reaver wrote:
> This patch series creates a toy pseudo-filesystem built on top of kernfs in
> samples/kernfs/.

Is that a good idea?  kernfs and the interactions with the users of it
is a pretty convoluted mess.  I'd much prefer people writing their
pseudo file systems to the VFS APIs over spreading kernfs usage further.


