Return-Path: <linux-fsdevel+bounces-65058-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58522BFA499
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 08:45:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA0624043EC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 06:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7232F0C7C;
	Wed, 22 Oct 2025 06:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OiRdl3zf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F77258CD7;
	Wed, 22 Oct 2025 06:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761115482; cv=none; b=VOTT/2n4PP2w7Kkqg/l8adZBSZs8Z0vR/4pqWgCBSEd+p5trO3YaXGyrD0ROtL8XUqH3KstBRCqK7OFVWM/pswXIkVfofCSCr84ac42wRiVEf9dhli7tAloq/wWYu1SqcQzG+0h8Di0v6qSN62PnXiMslrj5muQQCpRZQfmncUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761115482; c=relaxed/simple;
	bh=Z5AWUZgXIxpUHQV1fNHHxpTVV6Oicr9t+TxDvGlw+6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G4Bu901eQTK4W0Z92tB3bK/hjksBjCg8UmW01+pTCrng4RxM+d7KkIe4N9Zke8bp3WXUGdTQiHXF9szL1T+lVXu31CuBKOpms2UInMgYfkiXdLuC95pUVoNpMfVwQG910s1Tv/kDnag0rt18pzsN4859BOQcTcercYpCHecSdNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OiRdl3zf; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kyOfDxXn3l+NgMiyysxqYTdckOUTzb689OEE6eFFTKI=; b=OiRdl3zfcabVHV+WVH9hzNGVFQ
	0i+ZfByOM4atbb8kHfDy6gQeI7Re38es6JsN5tmh13zxnW9jwICCGbJgvDp18LQsqgV32ieYElvCm
	mSBTJnTW/OXvoFYW4TatNGmCSiNh9RgVzKHW5wJuRqq/IUeM92y0x5jyeqeqIr6GTr/6dghygJRPh
	d4VYJqGqBgAKkkR+e7xS8F2Toh0nVymoE0a0kKaDeDrYb06k8cKRISjNVtrAj4JSHGkkdX6fFhWtl
	C6HlapxNk6t418RIa0UnOCJVeSaJffeaYQkk5jOWvHH2QPTwsfV/zORvRd8vM0nGGyOvOlgVNd4qI
	Uu3E0uGg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBSaF-00000001hpk-2d9E;
	Wed, 22 Oct 2025 06:44:31 +0000
Date: Tue, 21 Oct 2025 23:44:31 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Askar Safin <safinaskar@gmail.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Jens Axboe <axboe@kernel.dk>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	Julian Stecklina <julian.stecklina@cyberus-technology.de>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Art Nikpal <email2tema@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Graf <graf@amazon.com>, Rob Landley <rob@landley.net>,
	Lennart Poettering <mzxreary@0pointer.de>,
	linux-arch@vger.kernel.org, linux-block@vger.kernel.org,
	initramfs@vger.kernel.org, linux-api@vger.kernel.org,
	linux-doc@vger.kernel.org, Michal Simek <monstr@monstr.eu>,
	Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <kees@kernel.org>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Heiko Carstens <hca@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
	Dave Young <dyoung@redhat.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Borislav Petkov <bp@alien8.de>, Jessica Clarke <jrtc27@jrtc27.com>,
	Nicolas Schichan <nschichan@freebox.fr>,
	David Disseldorp <ddiss@suse.de>, patches@lists.linux.dev
Subject: Re: [PATCH v3 0/3] initrd: remove half of classic initrd support
Message-ID: <aPh9Tx95Yhm_EkLN@infradead.org>
References: <20251017060956.1151347-1-safinaskar@gmail.com>
 <20251021-bannmeile-arkaden-ae2ea9264b85@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021-bannmeile-arkaden-ae2ea9264b85@brauner>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Oct 21, 2025 at 03:05:35PM +0200, Christian Brauner wrote:
> Without Acks or buy-in from other maintainers this is not a change we
> can just do given that a few people already piped up and expressed
> reservations that this would be doable for them.
> 
> @Christoph, you marked this as deprecated years ago.
> What's your take on this?

I'd love to see it go obviously.  But IIRC we had various users show
up, which speaks against removing it.  Maybe the first step would be
a separate config option just for block-based initrd?


