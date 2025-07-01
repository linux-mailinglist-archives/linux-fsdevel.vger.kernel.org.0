Return-Path: <linux-fsdevel+bounces-53422-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69314AEEEFA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 08:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A68A13E0B13
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 06:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF9525BF0E;
	Tue,  1 Jul 2025 06:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YNeOKmjn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A861F0E4B;
	Tue,  1 Jul 2025 06:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751352058; cv=none; b=WkGC5uZnH+LZPRLLFEfztGF2NjCzZjPvGSBWcc58jkdPMNIaug4cF/QMaQCWxacGkkuFgd51MApbyyt5ABVXuF/mKeoId+19nLFlfeg5Dj3WwswC/qYv02AaiQqfBOk4xPXmuDoxSLACdDe9DaeRjiNmUFc4y7Vkr55kj2fdwdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751352058; c=relaxed/simple;
	bh=C91yiRE3pNiudXaVaICBB4lK2vlENY4MbXf7zyk3yyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z8BpxszbOD+KkednoJ/UDHIpeZqKhYh1ELZKdectQEO55efYq+vKmZTFunGMDeWzD3UpUuQgt8NknYWEKEdVEtSF5zLDmWhZCPl6EY9jab8MwVBScWRxO8KXYjrnCXmr1nQ4WF7SvwFzVfUmQt/VgVplvbZtiiumxHSL8tL8Un4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YNeOKmjn; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=s7BH5zj57vnanAybMvNIxyBpSO2aU1zJgsPSuv/cMDE=; b=YNeOKmjnjEfN/fWh1S5zkt11g7
	9Gkx7EM4suqQHjDXcrNZpvMqxmSU3a2BoSuYCYWIZ3WaPCd1pfActnh/DEStGLABV7qK50F7bB2fC
	bPGlM/pJvdMDCX3zGxyjQ7JqFw/3+e69aqOV38BFOV4fP4BfDJCeRhQXeSwjBHiSnLzTEf5H2HJwS
	DDCrPN8diRetpfoQKXWMlzkzGHBraI4Qdpr1as1TTpb2vLZpxFiSBledpbOI11rYmw2gN/CYBPQR1
	Z2qONkH9M5FEwiqYXAEqMaf8K4nue5+8xTXM/hY/RhUOi77KTpdZQc3lZOg7qOPHWXHAZGVuJEffU
	KDAVGIuw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWUfn-00000004Az3-3gF4;
	Tue, 01 Jul 2025 06:40:55 +0000
Date: Mon, 30 Jun 2025 23:40:55 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>,
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2 1/6] fs: enhance and rename shutdown() callback to
 remove_bdev()
Message-ID: <aGOC94DxPTx_vljt@infradead.org>
References: <cover.1751347436.git.wqu@suse.com>
 <6164b8c708b6606c640c066fbc42f8ca9838c24b.1751347436.git.wqu@suse.com>
 <aGN8zsyYEArKr0DV@infradead.org>
 <baec02a0-e2fb-4801-b2ad-f602fc4d1cfc@gmx.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <baec02a0-e2fb-4801-b2ad-f602fc4d1cfc@gmx.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jul 01, 2025 at 04:05:03PM +0930, Qu Wenruo wrote:
> > Please also rename the function so that they match the method name.
> 
> I prefer not, and it is intentionally left as is.
> 
> This give us a very clear view what a fs is expected to do.

No.  Mismatching method are an insane pest that makes refactoring
or even just reading the code painful as hell.

Nacked-by: Christoph Hellwig <hch@lst.de>

without that.


