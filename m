Return-Path: <linux-fsdevel+bounces-32071-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 983DA9A0300
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 09:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CF0EB230FE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 07:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACCBA1C7612;
	Wed, 16 Oct 2024 07:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iHws6EyK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E1218B478;
	Wed, 16 Oct 2024 07:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729064958; cv=none; b=mxr94FqRHJdYt/ZWWzAlA3glTFQdQCXfqqcsztRS1mnNErvu5IShq2lPpLyI5RQevZUUReod3djtDV2xPEZAmn5Ch3taJG56voIwUN7Y2UjPLsWm0rkIS8K16uh5kQgNE4QsYDcscNQuIOKNaSF/OdyVbxt1eTe0TGRIItG27sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729064958; c=relaxed/simple;
	bh=IzsmLlwfaIis3r+L2uUV7WwIF00DA6OD0N/c6Ri8B10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uQKzGhCAB/II+JcJcZJbONCj4P3XkujpaTuib3a2ScQvNL2OXj+hl2BY5HsHMiJ3510fNO6Rf38gZITl1A/EpeGYgL4MXJpqO1UH9Fj0AKurwB8PeDlsZCimQ3pb6x6FpxmacOzAByOHmimyMnw/HxhxJIM9bjIKrmvuWLl39Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=iHws6EyK; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0qKRBfEVzhI+Kl9eHwDgM61+8JkG6X9yHvoS3jAAp8g=; b=iHws6EyKinBxOTGlnFWXDU5CL3
	9Xzhiou9RhnLaazWwPcBQLhi2w6li+wxHGRw3C+fjXCPnYV0QLJuznToG2/BH4tkg1/wNgWpj2kcw
	RUdRY9DuIKvtvmmnM8Tkc4xDyQxzwB/+BgCSg8pT1vu5ookOCOC7UMMM/Ri2oeVHUeGn4+mXnBo5E
	P6zXA9QPF/qTFHZNcVwzb3p++BCHnjlehEUvPOfg6Dcubf9W2o+3whAVhTBTsTTkSA+ooQ7jUfox4
	cq9Er8+Bcg/wRiGgduoOM1c+obHzlSsRUZ8g7azCkSjbtBJoUL6zwPvCSPNP1Xi5rnbxRIewmnpfd
	5dMsVWTA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t0ymR-0000000At2v-22pc;
	Wed, 16 Oct 2024 07:49:15 +0000
Date: Wed, 16 Oct 2024 00:49:15 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Song Liu <songliubraving@meta.com>
Cc: Christoph Hellwig <hch@infradead.org>, Song Liu <song@kernel.org>,
	bpf <bpf@vger.kernel.org>,
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Kernel Team <kernel-team@meta.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	KP Singh <kpsingh@kernel.org>,
	Matt Bobrowski <mattbobrowski@google.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Extend test fs_kfuncs to
 cover security.bpf xattr names
Message-ID: <Zw9v-7B0e4fyEXxF@infradead.org>
References: <20241002214637.3625277-1-song@kernel.org>
 <20241002214637.3625277-3-song@kernel.org>
 <Zw34dAaqA5tR6mHN@infradead.org>
 <0DB83868-0049-40E3-8E62-0D8D913CB9CB@fb.com>
 <Zw384bed3yVgZpoc@infradead.org>
 <BF0CD913-B067-4105-88C2-B068431EE9E5@fb.com>
 <Zw4O3cqC6tlr5Kty@infradead.org>
 <D6F9A273-1D5A-4E4E-89E4-9A44F1AD06E8@fb.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D6F9A273-1D5A-4E4E-89E4-9A44F1AD06E8@fb.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Oct 15, 2024 at 01:54:08PM +0000, Song Liu wrote:
> Agreed that using security.bpf xattrs are better for this use case. 
> In fact, this patchset adds the support for security.bpf xattrs. 
> Support for user.* xattrs were added last year. 

I think we'll need to revert it ASAP before it hits distros.


