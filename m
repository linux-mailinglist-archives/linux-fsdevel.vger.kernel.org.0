Return-Path: <linux-fsdevel+bounces-54234-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 150F4AFC73D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 11:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F8BE3B6F90
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 09:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F862652AE;
	Tue,  8 Jul 2025 09:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZYCGyHCI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEB6263C91;
	Tue,  8 Jul 2025 09:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751967635; cv=none; b=Pajm5xyt79+2orvbH+bWkPFoqw6HwO1ZIwfN4MkXZ55TF6QwDYO2qF7EWokGJ4uRzbBli2pg2heQVuHctktoaCXHB9XpNmNpoLotf5uTWaXJRVl02y/SkrUGKhpHekCpJKZQCRGxVOfgboPqWwFKdKwUIGDZjS9otZEbrkL/hSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751967635; c=relaxed/simple;
	bh=nS1QhT41V0UiYsiN3Oegm8d4aaeLmesR6K/FAQd78h4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oL4jOlEo+czpi6oA5TB0LP8GwyaIlw9T7oD9k8ES88PtjB36iUV8OBqvCgA5qXxzlQj4kZxpHHHpLbmTNSmgCvQdG2VQtMq6C/R47TV3TJEc8jXWSqjmE0lb/M87OHnY52Y2vXo/0FLlyH+O6QDRXd4ktvca12nDTfbpsKsJqKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZYCGyHCI; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xMDHjiDJIJmRWu2K0DH66X5hKEZSubxzRhPtX7/C4pc=; b=ZYCGyHCI9fwC/sVJqiGVwq1LTW
	OqBYDnEuere2uF0W0JI9EuCgjjhn9A8xAFUfoYuht2xQ/OJ12uddmmwEBvb8pcSeGt/oFLGRv3Uwm
	cyyuk+D9ZZj+53BghS72x9Fvs3iCWRxZX5ABMK3WF50ojQpPLMdJeK3/Lc115vnGijEmfelq0PrIE
	jwaRLvPn4xK6EWkVmqUh24RBMXywhbYLe3XMPWpSCNZ9w/BZLCyIrbulv0F0269EkYmGfaeHeU49A
	jdfxi5t4XQoE3V+Er//QbuwevasZVUUA5SuS05nJeY0Nfb9FMnRB9CmJeWSPFLmB13CkbDM0rD5zr
	RTLgbhag==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZ4oQ-00000004urP-3mvo;
	Tue, 08 Jul 2025 09:40:30 +0000
Date: Tue, 8 Jul 2025 02:40:30 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "ywen.chen" <ywen.chen@foxmail.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Eric Biggers <ebiggers@kernel.org>, brauner <brauner@kernel.org>,
	tytso <tytso@mit.edu>, linux-kernel <linux-kernel@vger.kernel.org>,
	linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>,
	"adilger.kernel" <adilger.kernel@dilger.ca>,
	viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	jaegeuk <jaegeuk@kernel.org>,
	linux-ext4 <linux-ext4@vger.kernel.org>
Subject: Re: =?utf-8?B?5Zue5aSN77yaIFtQQVRDSCB2MyAx?=
 =?utf-8?B?LzJdIGxpYmZz?= =?utf-8?Q?=3A?= reduce the number of memory
 allocations in generic_ci_match
Message-ID: <aGznjhBVCkifc6BD@infradead.org>
References: <aGZFtmIxHDLKL6mc@infradead.org>
 <tencent_82716EB4F15F579C738C3CC3AFE62E822207@qq.com>
 <20250704060259.GB4199@sol>
 <aGtatW8g2fV6bFkm@infradead.org>
 <tencent_3B7E5FEB5DB445A5DC50E3F3AE4DE72A7908@qq.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_3B7E5FEB5DB445A5DC50E3F3AE4DE72A7908@qq.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jul 08, 2025 at 10:36:07AM +0800, ywen.chen wrote:
> 1. Use the latest version of the fsck.f2fs tool to correct
> the file system.
> 2. Use a relatively new version of the kernel. (For example,
> linear search cannot be turned off in v6.6)
> 
> 
> The performance gain of this commit is very obvious in scenarios
> where linear search is not turned off. In scenarios where linear
> search is turned off, no performance problems will be introduced
> either.

Turning off hashed lookups was a stupid idea and should not last.  Hashed
directory lookups are the one file system improvement that significantly
improved lookup performance.  So don't work around it, because otherwise
you will be creating more optimizations to work around the lack of
hashed lookups.


