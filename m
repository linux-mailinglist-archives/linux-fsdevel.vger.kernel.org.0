Return-Path: <linux-fsdevel+bounces-57478-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D749B22035
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 10:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C34D9165647
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 08:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53582DECD8;
	Tue, 12 Aug 2025 08:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ibtjAMV0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3331A9FBC
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Aug 2025 08:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754985940; cv=none; b=DKZ6hMLQ75sCCH1UZIgYr5B+nfhtIbaTpgHtVwCRUWrEaIdrY0ksKy8vT3AVGOrLYNIAqvEtb4zm1TqcnYj2hh6ezISvkVZByGy/9pCjQYRpGL7WCfUUnYXf3mI3lIigkbCUf6cZGwyOUa3l77IaQno/PYl5oMYFYrxEaZqhyUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754985940; c=relaxed/simple;
	bh=inAhG/8yB52lhwnGIDuX/L4IdvqqeZI5yNaD+8NBwf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ImkirruKXrhX8FOox7fs0R4FjY2uCYtO8Ru56KOf4I73rhSf387LWNvdKZlez+FsqZ3M+KSoU8qYW9Gl4LXKlZDLpnvoBpH6T6axoVFgtoZQUD49sbUDjSk0shazhl0H05rl/AWKPod+sUkvB4jjDtDBa8SKK7DkSgwyGXDpb0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ibtjAMV0; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Bb46KS+TCS0ezJy71FRo1CCvXlfnyYDGVOhJSPif96o=; b=ibtjAMV00BUwFRWGsozllDrCO7
	ARCPqpi13cYElLf01yQYbPBSKSmX6dFZeKlHEAFHe4/MA1QkJcny0KAUcf2RCrYcPsRjDyk9RPibn
	i8moItG7C8vwjMHxOhmt315h+tduYteBH1xyw0I0ZJr47S2iK/JQBdzsyK1L7DnN2RYxc1o9jB/qO
	Xna4PFsamXE744T7QpPZK+VYLdeckVjtwpK9W7G2KioaCoPu1QUTCTWOq665cY5gT/mKltmFSPQAY
	d/iWIwA7tEhYJ5WqlvxQevRDutKe2/j5jev723BpykOywzlOVdGYOWiZAgCbSl8eSy0yQGcms+xKh
	d0StQarQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulk0m-0000000ACHU-1NTm;
	Tue, 12 Aug 2025 08:05:36 +0000
Date: Tue, 12 Aug 2025 01:05:36 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: linux-mm@kvack.org, brauner@kernel.org, willy@infradead.org,
	jack@suse.cz, hch@infradead.org, djwong@kernel.org,
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [RFC PATCH v1 05/10] mm: add filemap_dirty_folio_pages() helper
Message-ID: <aJr10JoIyxc4A0dw@infradead.org>
References: <20250801002131.255068-1-joannelkoong@gmail.com>
 <20250801002131.255068-6-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250801002131.255068-6-joannelkoong@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

> +bool filemap_dirty_folio_pages(struct address_space *mapping, struct folio *folio,

Overly long line here.  Also this function would benefit from a
kerneldoc comment.


