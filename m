Return-Path: <linux-fsdevel+bounces-31935-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC3099DD60
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 07:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9CCD1F23FDF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 05:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A98175D47;
	Tue, 15 Oct 2024 05:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gYPBXpC7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838534409;
	Tue, 15 Oct 2024 05:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728968823; cv=none; b=Bp12kjbr0NeQ3lzdvFW9t0q0u3nX3/EuHPiNmUHUoNdtufLn5GSpUtini4Xm/e7K3sv4ae9DWrpQPaZxqB1DJ+FGUn5e9Wunki/4OIW1EdpEmTZ5mX/uLB8zw649Fv4NZFEQvKWTCLZCauzgl4aYq+wWNlCY93joTlLKXvdaNQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728968823; c=relaxed/simple;
	bh=y1bijim7KlOGaI1ex/rUIONGaO9ypMdpazMW81g0y44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qvCsWcuPuSA9ia6IYZwYAN4bK0UfujuThrrQBUIdMnS3Xc2PgV2VOECs/w0BMqc/89/tREry1F2R97hd+v9xLhUljJgqEE6daLvCEnp8wyATR0lfhX/2ZMRFjUWYuGqQ3fTYXBq0Zn5c8QUtVBw1AeG3GahkCBZU95/w8aJ6YjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gYPBXpC7; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Vdd/N/H/gZ9ZTAqpv8rIHR89YOMK7NFLE+bbZiJgO5o=; b=gYPBXpC74S7yn+Lv+QzdsLA+ZD
	3h19h8fDUL9+Lcs+vCjx6xYXMJAn2VJspa2T/hJG090BSdliwC8ICv027sHkc00kZ5rWPwyYzrNP9
	SNCuvUpPZKFS6bRlR9O8wlUlFn+5hojksdCd18P84IX2nkfpj/YkojDSjBJjMlt8QeODjOEsYdMJb
	ZucREtXgwMl8BQjzGH+ALLS6X3/72Yu97PM1zL+R4JHoc7nm4JHI/QASyShv1BOfep8xbd/n9MoMl
	x5Zo7o7K4bDZPLhrjjnGQKm9YLmwN8QVvuTi0W1BQj64lOa5tC97Jk/qeU9yd6xzb7gtUH2ImlsDy
	MdfjnOVQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t0Zls-000000075Dr-2wOl;
	Tue, 15 Oct 2024 05:07:00 +0000
Date: Mon, 14 Oct 2024 22:07:00 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
	daniel@iogearbox.net, martin.lau@linux.dev, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, kpsingh@kernel.org,
	mattbobrowski@google.com
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Extend test fs_kfuncs to
 cover security.bpf xattr names
Message-ID: <Zw34dAaqA5tR6mHN@infradead.org>
References: <20241002214637.3625277-1-song@kernel.org>
 <20241002214637.3625277-3-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002214637.3625277-3-song@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Oct 02, 2024 at 02:46:37PM -0700, Song Liu wrote:
> Extend test_progs fs_kfuncs to cover different xattr names. Specifically:
> xattr name "user.kfuncs", "security.bpf", and "security.bpf.xxx" can be
> read from BPF program with kfuncs bpf_get_[file|dentry]_xattr(); while
> "security.bpfxxx" and "security.selinux" cannot be read.

So you read code from untrusted user.* xattrs?  How can you carve out
that space and not known any pre-existing userspace cod uses kfuncs
for it's own purpose?


