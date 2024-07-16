Return-Path: <linux-fsdevel+bounces-23793-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A1D933456
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 00:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D6F71F22D6D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jul 2024 22:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC97B13E3EA;
	Tue, 16 Jul 2024 22:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="LHMRvTwn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A24657CAC
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jul 2024 22:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721169973; cv=none; b=qhGsRsMzrlYPW+SE1BqcH9XhbNqNz8TPGZYJ3SYZfCALIYjRNlakLClm9hevIlMW/hQJ3TzO0OW5o+SkBp4nR0im6GMjz4zuEolcmXENHvi+cX5kRmcSmypD68N1j6BkKDsIkaMGIckUUIdlMkBSi02eajC/JTqfzrLcgWxuEjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721169973; c=relaxed/simple;
	bh=XwS1s0O6aYNrxQnV6mpcjfNn+lNNaaF+VID6dBXQssc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ro7lHzcZ2y43GhtuPnL8FLe+p8cW//EctqTn7d9L3KdLChN/hOXjkX40YbZqiPREr9TPXvrSXrat5IQOllu2bjKCKPpNtr4wEXTvWVdAu4zdjjd0DmrnARP4jNMNIX9DYzY1C0ZHmOIQhXJc/8QjeQCu4FTufuOomDb3ok3vgHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=LHMRvTwn; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jiQUaHb2adMZERwirQnxr+aahG/7S5uKt60S/vcVpC4=; b=LHMRvTwn/sVUWzbo0nVvTs9/1T
	NFOJ5OmTUSFn1oq3WaPSb47rUO2kJsXHIybTIsxbGzQH2E7zmnIPmo6EKK3EZHrOtNFYKN5hqVES5
	AvcSDRWHPW2zvbKhue0cQQIMUSMeMELV2mdH9fXKTTr/DsvbXshreq4EpjbFHSa93jLMu96bwjT34
	GKHaCigjCmYp7ghcrkwaPWT5OgdOyi9pCnaHpDtc3XWH2IJ1VNXwUZ2xlOys2MKD4UzfetAhcxXLb
	3lRiPxgX8pPEqon50RO2FF5/Du4SNKDIxe6E88Oe2uyPYesd9Yyk7ZyT9Jv7Rk9VtxT/w6a/8Xsp2
	gTY8dyKw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTqvw-00000000K48-3Geg;
	Tue, 16 Jul 2024 22:46:08 +0000
Date: Tue, 16 Jul 2024 23:46:08 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 00/10] Convert UFS directory handling to folios
Message-ID: <20240716224608.GB76604@ZenIV>
References: <20240709033029.1769992-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709033029.1769992-1-willy@infradead.org>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Jul 09, 2024 at 04:30:17AM +0100, Matthew Wilcox (Oracle) wrote:
> This patch series mirrors the changes to ext2 directory handling.
> It combines three distinct series of ext2 patches -- using kmap_local,
> Al's refactoring of the xxx_get_page() interfaces and the folio patches,
> and it does them in an order which is slightly more logical when you
> know that you're going to be doing all three of those conversions.
> 
> Compile tested only.  I can't find a mkfs.ufs / mkfs.ffs.  I found a
> Debian package called makefs, but couldn't figure out how to drive it
> the way that fstests wants to.

I can do testing; give me a day or two...

