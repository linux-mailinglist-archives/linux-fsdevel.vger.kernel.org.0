Return-Path: <linux-fsdevel+bounces-21381-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB6D903233
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 08:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D64F4B22D77
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 06:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE48171644;
	Tue, 11 Jun 2024 06:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Yy2GDgHO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BF517108D;
	Tue, 11 Jun 2024 06:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718085946; cv=none; b=jpzp6DL/MFKpOGLS84If8dv1ZD7Y2YJKNt3oW2SHu5Yw7Z8BYUBK27HnHBxRtXISIHfQXbvfFNi1TePaPeTVV2YMq2YblmuGlv3vt9SvadPiK4A+bHuhG0ovaMXyDPrKZeU81BmlrS9Aec53exrzp3k7k+iMi2CSeSIDpna5uTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718085946; c=relaxed/simple;
	bh=fzwbb4rgS+TOgZOXbyzeVCgDtutYzL0zX8ev4fFjZcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cvSKbTJI2oP4CB8s8AVoPXV1S905DiEaGzRXRQpUnPBp46KOzaYbq+lz6F0l6VBY3SEDHZXwESOipZeH94XZfwMwT4Ykj+vFcGEtwzB4i1dLmUTVDB3dLJ25lEc0Ql56ZX0AqYb1tFVURmMCWRyl4spa5BBjSh58VX4OZ4PZIv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Yy2GDgHO; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fzwbb4rgS+TOgZOXbyzeVCgDtutYzL0zX8ev4fFjZcg=; b=Yy2GDgHOIm16MpZUBcVWFHHUCi
	ZnJalcsiVNQRViDl/VUgf2H8F6gYHlXuWr98JfS3Nv8HRtMQLv4kOp8z1jlVIIaidH4ZIgTWUP00O
	CxQEM2arFch1mMt0wFgO9GpJHXkjHTt80hNYB+UKglzMpcxmIdBIbd/FkYgFzuoc1q5PxSWfsnMlo
	KQhUlm25HDUP3WNbK1MDWsuXfnkkXxt46kghOdWqnHyTkH/ldriAguKkNjCZc9zKZ5QpOaHD/cRi3
	aMBAafgaGfhXm040fnEiw3qTKuFgGL83MzLXYTAv1kqDsQ3zMdfHmueWPw9xDs/64Zcfus9vczKdm
	lGwYsZPA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGudb-00000007cwV-23gN;
	Tue, 11 Jun 2024 06:05:43 +0000
Date: Mon, 10 Jun 2024 23:05:43 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, brauner@kernel.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
	josef@toxicpanda.com
Subject: Re: [PATCH v2 1/2] vfs: add rcu-based find_inode variants for iget
 ops
Message-ID: <ZmfpN2-3pck1zSRx@infradead.org>
References: <20240610195828.474370-1-mjguzik@gmail.com>
 <20240610195828.474370-2-mjguzik@gmail.com>
 <ZmfZukP3a2atzQma@infradead.org>
 <CAGudoHE12-7c0kmVpKz8HyBeHt8jX8hOQ7zQxZNJ0Re7FF8r6g@mail.gmail.com>
 <ZmfemrY9ZPnvmocu@infradead.org>
 <CAGudoHH_Cx1F5Fdiv7EQaz_pWmZUyuieMdx+_XsUXa6AY829Yw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGudoHH_Cx1F5Fdiv7EQaz_pWmZUyuieMdx+_XsUXa6AY829Yw@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jun 11, 2024 at 07:36:46AM +0200, Mateusz Guzik wrote:
> I am explaining why the addition looks the way it does: I am keeping
> it consistent with the surroundings, which I assumed is the preferred
> way.

It is not, and it's clearly documented that it isn't.


