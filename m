Return-Path: <linux-fsdevel+bounces-39550-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C7E2A157C3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 20:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B66C97A2EF6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 19:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6EBC1A840F;
	Fri, 17 Jan 2025 19:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PSjNg41I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0641A83EB;
	Fri, 17 Jan 2025 19:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737140671; cv=none; b=IR8qAcN9dMg7qsY1W0Jsj5ZVNOE5OAB7G+lkKEQ8dLXPQqd04mFNNhSSVKpULZ5ofdBG8LoUgftvn9qSGhZg+NiDrp7NU02Nqp+q9QSICIh51saH0JpHO2WlYr8Yw6agDnZd2OCXrtS9cF8FVfAt8izpwOlHvhUdX/sVQl87y/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737140671; c=relaxed/simple;
	bh=KtTCxLDeRCbZf9qLeAF37jfhIY4xbjAak4GGl8vICwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KMmx2UJqbdaMaU21cZd8SnwN4VnfePtIqlSvTwYaZMvfxcK7FL//bA8Qfk44l80zeOk+UU3AdlKMDnbFdrIlGt0E32MAiJ6iQFFeyl0DRx5NG3vSol53RTcCCfaigWEmKs2nSzgRNfU0ETNChzDK5SvtFBQR5cAMFG4uZoLsMeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PSjNg41I; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1oEuGqAuh5y6McX/JRE5DpfIQdB/lYrzgC5S1T6HyeI=; b=PSjNg41IoSDdtKxuGIlNZkpgft
	qq1u4qSUKf0a7QOEYJ43Z68BEoSfHVA2IQQnO7+vKngCF6BKpf89lBOnuM2OOWkY9LTe1eWG0Q3PE
	XtIOUTMCpTKEqAATzjnPAcU9GJ5fOZHxeNjpK/G7AuqeK4+XyPGg05wIWFP88Omf5ERnywt7lcuGo
	3vjOOKgYO/9Vs4SdWHX0UTmo5S7TbZU+0wpy5grRWrttglNmoqcycQRmArC0rd9gqYe0VUOQmEtJP
	YVoUvtt19z05XjiDYnZW2yt13BgnxcueNUW0GBbYv1n1TZFjAK2iacdUz7AuzTfBfMxh01LQ1DxW5
	+RHCgeyg==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tYrdq-00000001jzm-3Ntm;
	Fri, 17 Jan 2025 19:04:26 +0000
Date: Fri, 17 Jan 2025 19:04:26 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/2 v6] add ioctl/sysfs to donate file-backed pages
Message-ID: <Z4qpurL9YeCHk5v2@casper.infradead.org>
References: <20250117164350.2419840-1-jaegeuk@kernel.org>
 <Z4qb9Pv-mEQZrrXc@casper.infradead.org>
 <Z4qmF2n2pzuHqad_@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4qmF2n2pzuHqad_@google.com>

On Fri, Jan 17, 2025 at 06:48:55PM +0000, Jaegeuk Kim wrote:
> > I don't understand how this is different from MADV_COLD.  Please
> > explain.
> 
> MADV_COLD is a vma range, while this is a file range. So, it's more close to
> fadvise(POSIX_FADV_DONTNEED) which tries to reclaim the file-backed pages
> at the time when it's called. The idea is to keep the hints only, and try to
> reclaim all later when admin expects system memory pressure soon.

So you're saying you want POSIX_FADV_COLD?

