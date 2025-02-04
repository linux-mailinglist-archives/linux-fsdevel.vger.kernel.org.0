Return-Path: <linux-fsdevel+bounces-40701-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5146A26B86
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 06:49:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47D341650AB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 05:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7BE1FDA76;
	Tue,  4 Feb 2025 05:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2teENuLy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71796158558;
	Tue,  4 Feb 2025 05:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738648173; cv=none; b=Y5gpd4/+LbUzL75iTSj8BpUVhGWu5B474pb79NpLFi9TlybujjOitqTYxegww1uzyKK5OC1dWJxuQAVErFEWvg+5w5CAeYDEzetMkIEy/c6XRegrqIiHQKUA74ronVqBdbLq5Ms5Rn7q9o0rj/CUwOhVltidH1fzzVJNrXT5ExI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738648173; c=relaxed/simple;
	bh=VfrDKszgCGQNMPThCU1m1LdrTkJwwAUTR6fauYVQjEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NCSy/ZmGLjLiouJP5SS2HHpHYcUORSbYho3VNZBBRl8OScUW40ar1VDHGY+5b8RbhxixVUXg50on4LbkCm/tseXQ3ld+WHGSt4d5LYe9IaAoyqYFoTlJB1dWKdm93RG8ZTKxKrOjtYUFRAoBzapK8lDsvdmGJuNQXjoHQZp9xFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=2teENuLy; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=s5Zhk5Xv/to3IdCo2qfEM3Rd+KIEFauoYnzDJ0mZZUM=; b=2teENuLyXvCrs6O7KUZeOOB4IB
	Bn2GJi+MbkopSRPect/FNTGL5iDJOzvTmAoo0YT3ykWhkSffKRAZdI2SL9SPX3PfcKh9fCpWcmN4d
	W+K9CnK+Qb7vzSYoz9fB4ZyA2+6QnfieF+7nheA1bWJ1Wid2Cs/PU5NqTptK7SYqS2w+5X4xBc/fS
	mnfThaeA2Xm3zjtcU25OnvMxrhrsD4F1kBYMXY3lLX2X1NEcdfMqZnWbqS883n5GeNzNlasdXmudK
	8uUsWqpbESK+d8HEyHAPmiPoaTqjf7d5mgO/eQ52PqS2rmEZvpziJMquLjq0xEfLeiT61Nnx7ULit
	yCIzlXZg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tfBoS-0000000HIzb-0ClL;
	Tue, 04 Feb 2025 05:49:32 +0000
Date: Mon, 3 Feb 2025 21:49:32 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-mm@kvack.org, linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/2 v8] add ioctl/sysfs to donate file-backed pages
Message-ID: <Z6GqbJxJAsRPQ4uQ@infradead.org>
References: <20250131222914.1634961-1-jaegeuk@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250131222914.1634961-1-jaegeuk@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Jan 31, 2025 at 10:27:55PM +0000, Jaegeuk Kim wrote:
> Note, let me keep improving this patch set, while trying to get some feedbacks
> from MM and API folks from [1].

Please actually drive it instead of only interacting once after
I told you to.  The feedback is clearly that it is a MM thing, so please
drive it forward instead of going back to the hacky file system version.

> 
> If users clearly know which file-backed pages to reclaim in system view, they
> can use this ioctl() to register in advance and reclaim all at once later.
> 
> I'd like to propose this API in F2FS only, since
> 1) the use-case is quite limited in Android at the moment. Once it's generall
> accepted with more use-cases, happy to propose a generic API such as fadvise.
> Please chime in, if there's any needs.
> 
> 2) it's file-backed pages which requires to maintain the list of inode objects.
> I'm not sure this fits in MM tho, also happy to listen to any feedback.
> 
> [1] https://lore.kernel.org/lkml/Z4qmF2n2pzuHqad_@google.com/
> 
> Change log from v7:
>  - change the sysfs entry to reclaim pages in all f2fs mounts
> 
> Change log from v6:
>  - change sysfs entry name to reclaim_caches_kb
> 
> Jaegeuk Kim (2):
>   f2fs: register inodes which is able to donate pages
>   f2fs: add a sysfs entry to request donate file-backed pages
> 
> Jaegeuk Kim (2):
>   f2fs: register inodes which is able to donate pages
>   f2fs: add a sysfs entry to request donate file-backed pages
> 
>  Documentation/ABI/testing/sysfs-fs-f2fs |  7 ++
>  fs/f2fs/debug.c                         |  3 +
>  fs/f2fs/f2fs.h                          | 14 +++-
>  fs/f2fs/file.c                          | 60 +++++++++++++++++
>  fs/f2fs/inode.c                         | 14 ++++
>  fs/f2fs/shrinker.c                      | 90 +++++++++++++++++++++++++
>  fs/f2fs/super.c                         |  1 +
>  fs/f2fs/sysfs.c                         | 63 +++++++++++++++++
>  include/uapi/linux/f2fs.h               |  7 ++
>  9 files changed, 258 insertions(+), 1 deletion(-)
> 
> -- 
> 2.48.1.362.g079036d154-goog
> 
> 
---end quoted text---

