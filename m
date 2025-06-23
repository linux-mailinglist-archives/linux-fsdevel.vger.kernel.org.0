Return-Path: <linux-fsdevel+bounces-52577-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B1BDBAE45CE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 16:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DAFD7ADCB0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 14:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D87D2550B3;
	Mon, 23 Jun 2025 14:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sd1gUbVN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D30253F12;
	Mon, 23 Jun 2025 14:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750687275; cv=none; b=XF5mioSW/hPml0xnvFRvVU5uYM1rf+RV5IOQpheEK62smQvKQQglqiUWUA8TBZgPsjaF8soiBjDVPDIhxGMT9XwNv8MooEeM+oBsYxTYqab7xt+8993uIAMIOxY1CJ1qixsKKXet8Ibk3bDgstByr/DGAetM+6I4jS4aC5qgIig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750687275; c=relaxed/simple;
	bh=8tAe+A72NPC0t11fqKX0Tq5ZNoJLrKQNS54t9kfjHag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nfw3o4qA27FxnaYCyVM6umI/YI7tkdwrWj15M2qhqKndu/oCzzGwaejvpNByum0p5rH3kOEpo3HA0dPUVj5FwpPq3THtcgPAL0dm9pyT0R6ZrMD8ogHFRxsCmPspTQp6YrzCJtBckXPfmh0PTzdOFRthpKdTmq6UtJvB2Vnvwa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=sd1gUbVN; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=UmzzfFRbv8AKrXWg42xJyMquVYU8RD5shIkkp8OhLAc=; b=sd1gUbVN/g9qIotYXNTwJKCyVk
	SSbd0kMv7BFDgdf81y8OdtMOMKwn1Q8FDsk1r1rQFHacQWpt/4CwJtTJ7uCEYxhMGhBIcwS6FsX5z
	12kU6mYOROvl27Cd4ofQexIAodZKnxq5dP267SKr0s/s3743St9DRn3fB3SHB8a71LJ5SckyPUND7
	1POQs//daeeIu1mbmz739T1Yfk16+5zjsCnZKH2DzY8ajow6ppUpCHQJWr5y+QpLNh6B/yM8eJ15l
	oIBuh2m6g6ttTRyetbUxahs1b6+a5W2aYzliksWa6SX30DMg1HMNwH9ZDkZmOKKZ5sRqNe0T+y2hC
	WuVm7hMA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uThjQ-00000002xl2-1IxF;
	Mon, 23 Jun 2025 14:01:08 +0000
Date: Mon, 23 Jun 2025 07:01:08 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>,
	Mike Rapoport <rppt@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
	Shivank Garg <shivankg@amd.com>, david@redhat.com,
	akpm@linux-foundation.org, paul@paul-moore.com,
	viro@zeniv.linux.org.uk, willy@infradead.org, pbonzini@redhat.com,
	tabba@google.com, afranji@google.com, ackerleytng@google.com,
	jack@suse.cz, hch@infradead.org, cgzones@googlemail.com,
	ira.weiny@intel.com, roypat@amazon.co.uk,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH] fs: export anon_inode_make_secure_inode() and fix
 secretmem LSM bypass
Message-ID: <aFleJN_fE-RbSoFD@infradead.org>
References: <20250619073136.506022-2-shivankg@amd.com>
 <da5316a7-eee3-4c96-83dd-78ae9f3e0117@suse.cz>
 <20250619-fixpunkt-querfeldein-53eb22d0135f@brauner>
 <aFPuAi8tPcmsbTF4@kernel.org>
 <20250619-ablichten-korpulent-0efe2ddd0ee6@brauner>
 <aFQATWEX2h4LaQZb@kernel.org>
 <aFV3-sYCxyVIkdy6@google.com>
 <20250623-warmwasser-giftig-ff656fce89ad@brauner>
 <aFleB1PztbWy3GZM@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFleB1PztbWy3GZM@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Jun 23, 2025 at 07:00:39AM -0700, Christoph Hellwig wrote:
> On Mon, Jun 23, 2025 at 12:16:27PM +0200, Christian Brauner wrote:
> > I'm more than happy to switch a bunch of our exports so that we only
> > allow them for specific modules. But for that we also need
> > EXPOR_SYMBOL_FOR_MODULES() so we can switch our non-gpl versions.
> 
> Huh?  Any export for a specific in-tree module (or set thereof) is
> by definition internals and an _GPL export if perfectly fine and
> expected.

.. the only thing we should do is to drop the pointless _GPL in the
name entirely.

