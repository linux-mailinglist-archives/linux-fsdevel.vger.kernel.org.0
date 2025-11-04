Return-Path: <linux-fsdevel+bounces-66964-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB75C31EE7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 16:51:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 69C064F340A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 15:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A5E27056D;
	Tue,  4 Nov 2025 15:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="U87h29E3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0244212542;
	Tue,  4 Nov 2025 15:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762271339; cv=none; b=UHX97MBnYr+NkdLiIXxzTfE4W9WUDmtF0iKFTIdjvLLdSubm7ICJc6VNt3rCEIls8v3U7ZKOcT8NyFBFhv03C42qD/DgTqIMPbBi/8mhv6+wuCUFV0eeP7LYQq6i+n/yeKFYL7Alf3nX3xXpBCgQxnZD/EtaSbeRJ+x+4jpI0Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762271339; c=relaxed/simple;
	bh=hY8Ln2pdGeKvcfoS37aVfLz+SXvrv5SLVpJJOfhRaZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qpgPAriAP1rOZnM0le+YnG5UIHaktxeLAmtkjBiigDWyceeL5CaLV5JWrifik63EIIV23mf6taX5mEQj/LNWPPWUokf+3B/m4bhACg+QQVvV1PfDaNesqxO1AEH+UhWE1EkkE4ya6s5kKHu5xvGaDok8+vOO3vfIJbuK1qY9Qv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=U87h29E3; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=dZQ2HCceRJLZizFuCH6251L/mPW0nJ2MWcAlfjcOzYE=; b=U87h29E331Qjlh2PVdi31LPhZq
	55UOWlNzHnULwVDA4fwO7/YTLr/+4P2zx6uls++EROIS6ej13VjaIFIBceskeZzGVxFXVyAGxMfeS
	e9WTjHQrfZpGJ8G1sAeieV1EueCSEqhXMULUgq0wPT3E89HWoERDJfypTbJrdm+DKHCgGyzYkIthT
	YiwPsIboZCtVB+h5MOW8TJD95N6i+ZOTV1hm4jp2dC0Ck7Kejx42YrNuyE7dG3c4K00bjp1IjMrWM
	v2DXbNzuTj5NNOd8BIbqiD+H3gwqhkEFtQySVZrcWxlD09pLdHAMEOmmQ2zOmAXdozXRxid29GF4b
	dtSVtPyQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGJHC-0000000C88p-2g5H;
	Tue, 04 Nov 2025 15:48:54 +0000
Date: Tue, 4 Nov 2025 07:48:54 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: Qu Wenruo <wqu@suse.com>, Christoph Hellwig <hch@infradead.org>,
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org,
	Askar Safin <safinaskar@gmail.com>
Subject: Re: [PATCH RFC 2/2] fs: fully sync all fses even for an emergency
 sync
Message-ID: <aQogZrYju4RB6djn@infradead.org>
References: <cover.1762142636.git.wqu@suse.com>
 <7b7fd40c5fe440b633b6c0c741d96ce93eb5a89a.1762142636.git.wqu@suse.com>
 <aQiYZqX5aGn-FW56@infradead.org>
 <cbf7af56-c39a-4f42-b76d-0d1b3fecba9f@suse.com>
 <urm6i5idr36jcs7oby33mngrqaa6eu6jky3kubkr3fyhlt6lnd@wqrerkdn3vma>
 <414a076b-174d-414a-b629-9f396bce5538@suse.com>
 <ewespqy3nwdpdrwn46bsqapx4hzbliru2ieq2wggghqgwssepo@ucz67koqt23w>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ewespqy3nwdpdrwn46bsqapx4hzbliru2ieq2wggghqgwssepo@ucz67koqt23w>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Nov 04, 2025 at 01:42:14PM +0100, Jan Kara wrote:
> No it is not. For ext4 if the transaction grows large we'll commit it. Also
> if it gets too old (5s by default), we'll commit it. XFS will likely have
> similar constraints. So data loss is limited but definitely not completely
> avoided. But that never was the point of emergency sync.

Yes, XFS will eventually clear the log as well.  But the important part
is that writeback of any kind will actually log the metadata changes.


