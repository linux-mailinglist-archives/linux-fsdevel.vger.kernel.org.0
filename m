Return-Path: <linux-fsdevel+bounces-52576-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F3000AE45C1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 16:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39E747AD516
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 13:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C79145346;
	Mon, 23 Jun 2025 14:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rWrTkQhV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB10C3594F;
	Mon, 23 Jun 2025 14:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750687250; cv=none; b=nvXYzAYmV0FgUpq9xmRGBnBZjOQS5D5QdlitY1xvTf4xWdSf53RTFPLcvengnItuYSkcSktWhYMPpUbYW7vX1nzLZE3X9u+CfXE1Ev15S1nKvgs7hOUc/SMv+rxRAoSrsacqGy2UgZP3nRb3Q7XtZH8mSyZzjLUVnw87+ya8BRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750687250; c=relaxed/simple;
	bh=WE7HYo0rp0Y7tGvNC3/QuQmPw4M7jfrWtaQ6YaX97sw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NaCVsl7C23L3tUGzBFK2rl97VfQ5hCablRUd64KN9WQHfEN69ZU068C/LZKy+VaKK7aEVJL+4KqLv8a8+Cp/K0llP0bFdHVnLVumxbWPBG2bpzm/lRdX5B3ptWvsNqB3QRTt/jvm2qbmzre5JOOOQq7cFmsVQI51jDob7BLeGJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rWrTkQhV; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=CVVKJvWug9C6Po7124caU+eIxZcOL4L/VyLsEo25XYs=; b=rWrTkQhVehHTGoLhZo0zXoUGYY
	BEJbnShfobP4LVoW8Cs/7VoNjinPJ8u7WiKmVR4g50htoK4t6POXo1pgrFPbz0SjfZr5L+55DGtr0
	OkZkVv+RiSnXYuGibOvildSr4s6VqMudpKnhS12z0mneCyLH8m2ly242dqpsoPh/PFn2TFU7biiTO
	otIUEOc9pNVvAKCqxTR7Zhqwz0qNIrqrinUjnX2LrbuDJTrPSQJ1WVgXG/qU/68BzL+564c6Tw1gN
	8cx0wqnDRma1QBIefifvFyIKltJ3jMYq5R8DfCEfoltoDDhn+6Yz939OofxH99MvN6+XFU/atl/dC
	FjMFLrrQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uThix-00000002xfr-30vK;
	Mon, 23 Jun 2025 14:00:39 +0000
Date: Mon, 23 Jun 2025 07:00:39 -0700
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
Message-ID: <aFleB1PztbWy3GZM@infradead.org>
References: <20250619073136.506022-2-shivankg@amd.com>
 <da5316a7-eee3-4c96-83dd-78ae9f3e0117@suse.cz>
 <20250619-fixpunkt-querfeldein-53eb22d0135f@brauner>
 <aFPuAi8tPcmsbTF4@kernel.org>
 <20250619-ablichten-korpulent-0efe2ddd0ee6@brauner>
 <aFQATWEX2h4LaQZb@kernel.org>
 <aFV3-sYCxyVIkdy6@google.com>
 <20250623-warmwasser-giftig-ff656fce89ad@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623-warmwasser-giftig-ff656fce89ad@brauner>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Jun 23, 2025 at 12:16:27PM +0200, Christian Brauner wrote:
> I'm more than happy to switch a bunch of our exports so that we only
> allow them for specific modules. But for that we also need
> EXPOR_SYMBOL_FOR_MODULES() so we can switch our non-gpl versions.

Huh?  Any export for a specific in-tree module (or set thereof) is
by definition internals and an _GPL export if perfectly fine and
expected.

