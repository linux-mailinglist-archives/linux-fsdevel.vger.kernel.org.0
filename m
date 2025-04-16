Return-Path: <linux-fsdevel+bounces-46540-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1492A8AFF9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 08:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D44FC44179D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 06:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F342288F7;
	Wed, 16 Apr 2025 06:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="38hJ3SNi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE72188733;
	Wed, 16 Apr 2025 06:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744783560; cv=none; b=GjCPzfTg5DjrDS4hzPInQBkza5Ahd+pQi0Xk3UdiEhmL4Eqkg/eVy6kK18L9csxGpIz8A3t5cLXBSuY5A+dXCF7RJvq17LpdPtQF0EBlbhdvLMR08THV47rOIUWaC3H7aUhcewT5YvHkP5tB4X9Wbl+mr/3jjOoQ3MfbWlyzteQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744783560; c=relaxed/simple;
	bh=ZjL7xzi4YVzA4foMv63r9G/O6nOTffKm/FFTvOAx66s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ktkJFq/v99bEPfTX41zt5gzKwSlPNZG+hZtU3a33dnsSz/qAprqCeXwpRJEVVAeUclEZKQwsQ/IRJK+67KvbfNdAbg+KBrg1jCEpLee74WzGDVhHtz7wEQ5lW4/p422mNdsjOeSmNs5IZWq+MO+jH5fHfkhOkrHN0K3UMkBHgc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=38hJ3SNi; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YNpWj8WW9NCYcWfBH05KWruIw4Nq6vPqEJTEnXmlJw8=; b=38hJ3SNi58dWCXxDLbu782T49z
	ZOs7xsOXzkm7NmVeC1Zsx/7XAIlxMkN6Eteh32El+J3faxOiCmAo+AW557HBCX6CkYx36ZOp+7KM/
	BaC0q9VU9FKeRRORDSz0hygO9A1AkynplXqBgdW9cIjGytEruJGaxaWWsffbekT/pSPC/sG/lLygn
	pepikrJIDgp2ZKRkHsAX0ha7aNkYoFnbiP0mX8g1+2X333Y+tRgdicG7oIadol0Th8Kl3kheNmm33
	JbcWKgYifdg+vGIPhfO0wumJ3+Kkm5aPpvIej0Qf3XrC6YGj5volol7+qihnQFMSr+UVn/GOY7CW/
	DbTpbIQA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4vuG-00000008MNp-0wE0;
	Wed, 16 Apr 2025 06:05:56 +0000
Date: Tue, 15 Apr 2025 23:05:56 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Lizhi Xu <lizhi.xu@windriver.com>
Cc: hch@infradead.org, almaz.alexandrovich@paragon-software.com,
	brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, ntfs3@lists.linux.dev,
	syzbot+e36cc3297bd3afd25e19@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: [PATCH V2] fs/ntfs3: Add missing direct_IO in ntfs_aops_cmpr
Message-ID: <Z_9IxOypdO5Ks44N@infradead.org>
References: <Z_9Bou858C-pJnmd@infradead.org>
 <20250416060351.2971835-1-lizhi.xu@windriver.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416060351.2971835-1-lizhi.xu@windriver.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Apr 16, 2025 at 02:03:51PM +0800, Lizhi Xu wrote:
> In the reproducer, the second file passed in by the system call sendfile()
> sets the file flag O_DIRECT when opening the file, which bypasses the page
> cache and accesses the direct io interface of the ntfs3 file system.
> However, ntfs3 does not set direct_IO for compressed files in ntfs_aops_cmpr.

Not allowing direct I/O is perfectly fine.  If you think you need to
support direct I/O for this case it is also fine.  But none of this
has anything to do with 'can use the page cache' and there are also
plenty of ways to support direct I/O without ->direct_IO.

