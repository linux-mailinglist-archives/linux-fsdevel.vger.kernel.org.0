Return-Path: <linux-fsdevel+bounces-45733-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B12A7B8F6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 10:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAD1C3B3FFF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 08:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D84199FAF;
	Fri,  4 Apr 2025 08:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gCNN7D+G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4896A2E62B4;
	Fri,  4 Apr 2025 08:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743755640; cv=none; b=jfRo4KRAUvPKZNIxem/aH+tUC8X9DlBSsuR2MX1hiYcTtVButnk/k/4yY4Fw6cFRglf2tx+gdw24SlTD9q3sdx5JDuxghqmfqSbOJ7ln2YSgEUged7RvQktNNUf1qhreKtjaoICgwqL2zbkjiCFmITicK+asE8NaY1uvGAcKdcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743755640; c=relaxed/simple;
	bh=UbqfnnkJ2RFypDS2Iog8rU6ytZMzuPUyz+6AiTrt8Q4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PDKWmBDgd1tAhFVis0vBYD2JLny6ZlXxILD6gEdzpR8qu+w9Wg4bwgyTNWFaIUKB57NsjPEP38d0+vEiSBh4Uuj4XjM5kaYQCIAiVRPeBGWHVpNmqVdy9PPqYYtqVLiq18dvvxBISlLYElfvHmu28WOQC2oimwXz9l/KgEfisk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gCNN7D+G; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ljHeP2QjLQYjOwUf2t9iT8m27ihNQpRMtfPnzhtYbSU=; b=gCNN7D+GlDbsCNVp8qmn6rs4ip
	oxELllm96uq2C1wKLIDMcsLhsPWrwUf1+cPgdLVvEpV074nF4ZulKrUt/E/D5iDIeojhgKPeXC+FS
	WAgBhZvKsrggu0SUAiAJZ3Fd1Cz+FlWB4tbb4OpDQjdVQVGZFc775rxgc4m73Ce5Gy5KQavzm+YTn
	KA4Md1H8zsSzYsk8Br8Zpa9uHj+xOPq2dFigO3gvv61u6ausjtjkYioayiqDcvMX6MWvtrgW6QmH2
	q1/MRO6oMr6Y0Z7uIcJZqpVIdjJNvKRMrSF+9whdJrlLIcZLmNU3ul/z8+OX5GjVvu5Aky90iYugb
	sNjLprgQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0cUw-0000000BA95-0zWJ;
	Fri, 04 Apr 2025 08:33:58 +0000
Date: Fri, 4 Apr 2025 01:33:58 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] fs: make generic_fillattr() tail-callable and utilize
 it in ext2/ext4
Message-ID: <Z--ZdiXwzCBskXQK@infradead.org>
References: <20250401165252.1124215-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401165252.1124215-1-mjguzik@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Apr 01, 2025 at 06:52:52PM +0200, Mateusz Guzik wrote:
> Unfortunately the other filesystems I checked make adjustments after
> their own call to generic_fillattr() and consequently can't benefit.

This is in no way a useful commit message.

Why do you even do this change?  What's the point of it?  And why do you
think making a function tail callable for two callers, one of which is
basically irrelevant warrants adding a pointless return that now needs
to be generated and checked by all other callers (which this patch fails
to do)?


