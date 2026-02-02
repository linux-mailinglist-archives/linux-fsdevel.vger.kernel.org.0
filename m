Return-Path: <linux-fsdevel+bounces-76028-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KN1/OZJGgGkE5gIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76028-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 07:39:14 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 617B1C8DED
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 07:39:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CC76E308036C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Feb 2026 06:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A85E30149E;
	Mon,  2 Feb 2026 06:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1GahBN3U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967322FFF8D;
	Mon,  2 Feb 2026 06:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770013751; cv=none; b=Ek483nTNeHRmKoje7hoCkIzxtVqt0qoiG3PR3Nx7rYPLGzc50eOR2EkTXtyaAkuiN2HlYHlAMddHF7W7WiSNJJD3Z3K6T+ea50LEu/aIiOjIIK+lZ3tf8A0EJ1Mc1JWvoWgSO3j+lDHs6gL3SyNf7w1lccIcAH82zOAxhBWyrp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770013751; c=relaxed/simple;
	bh=USoIlGY2W29ToM4EFnIWwqqfgO2VY0cok7WrY2g5CbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JAUBTyd+TezWEWr5uGrTvUb+fPi8KqnrIdKZ6WVaxYw//2biC6of0ocTuG8Wu/GJfqxb1WvJiXEr+sfngm9YaW5jrJS5wcDhIuYdOkJiAu90mxC2xv9KG5+aH0zpYE2TEZ+BEXV1CaJIuQ/hVVTQOr0XMCqnvEMmYTLMw30V8/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=1GahBN3U; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/oKjHTVG6CyAT8j6qbVMz//QsWPZewlOwFkp4rGlQEw=; b=1GahBN3U6+mmZ2qIYiduF81d7K
	BbzNQaOvzG5FIn30dmH6YUt8Y6tGO4GWXdDgQu7K5672XX25tRGn1so1rMa8AsoZCwH9sahAcWJ9E
	bJEUhjGue+By5C5bDbQG4uzH9LNmISuQc2tz1XtbiUEIGF0vO7X2EcMvkYR/nJuuAkjkA130rZOFN
	dgSkA//FaHq+f8V4TxSoA14HCAhA2n5zE7F2rZZ8q0xesw7DDK1t7ce6BYdZjpApX4XijCqOrOo+c
	GBmlXd42iMbm+FegR4CqplBf6gCnWu3547YbGIn4GRV5YUCWmZ1ekEMwdQ56go/juMLmVkLSDwe3/
	H2fc04uQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vmnQr-00000004Vwn-36uL;
	Mon, 02 Feb 2026 06:29:09 +0000
Date: Sun, 1 Feb 2026 22:29:09 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	Cong Wang <cwang@multikernel.io>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH] dma-buf: add SB_I_NOEXEC flag to dmabuf pseudo-filesystem
Message-ID: <aYBENSqGtp0XUZBw@infradead.org>
References: <20260201170953.19800-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260201170953.19800-1-xiyou.wangcong@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76028-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@infradead.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:mid,infradead.org:dkim,multikernel.io:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 617B1C8DED
X-Rspamd-Action: no action

On Sun, Feb 01, 2026 at 09:09:52AM -0800, Cong Wang wrote:
> From: Cong Wang <cwang@multikernel.io>
> 
> The dmabuf filesystem uses alloc_anon_inode() to create anonymous inodes
> but does not set the SB_I_NOEXEC flag on its superblock. This triggers a
> VFS warning in path_noexec() when userspace mmaps a dma-buf:

As last time, I think it would be much preferable to set SB_I_NOEXEC and
SB_I_NODEV by default in init_pseudo and just clear it if needed.

I can't think of anything would need to clear them from a quick look.


