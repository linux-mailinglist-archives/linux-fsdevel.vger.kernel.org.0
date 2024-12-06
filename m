Return-Path: <linux-fsdevel+bounces-36644-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5599E741D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 16:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA7E518854BA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 15:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5B1207641;
	Fri,  6 Dec 2024 15:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FxfJ9K3K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BC91EC01B
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Dec 2024 15:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733499086; cv=none; b=HFI8Iw1EszkDlpiREpjTA+y234nLM/LmssDV1DIwG+uGHgxoc8w9Tsfborz4UHTJTx53o8KTKGPMZHaGw7KGl20quzdgVKnbM5s1c/PpSumjGu+dnibN0+Z/spSMq65LMTpLpQuCRSMBxYRTsI6IpiYp/u8ZyDfYjPrTsizLXEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733499086; c=relaxed/simple;
	bh=6PuycSo5ZRWX3Uv1RektvYH+6ammy/u9tKxKZy3S/Ec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=smOmh+fDLYAjmMGzY+6WSMWgeci1wxQtAAL2cKZun6kDqExrIZJV3WOetR6gQbapOkhqsz3uoHJGM6+vcoRCPX+9xv4e5HRn/bmWrIkdw/EgsiL4YajpXLqvIy6K1NKPNrL6r/fDL+vcVb1bP0+4KtYNzJ5ryJiYS1oOtpg7ME0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FxfJ9K3K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D58EC4CEDC;
	Fri,  6 Dec 2024 15:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733499085;
	bh=6PuycSo5ZRWX3Uv1RektvYH+6ammy/u9tKxKZy3S/Ec=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FxfJ9K3KtSlly5zKddI9gmRBjiKt80FhFhXlJkpb+WjrM7OV5znE7KUw5+iQodfE4
	 /GSTFSV8hPnO9EuIEFAZ32PwfsgnA9yH8Qr5TgKl0bJgvMjifSufdmwuYTacsDk/Kv
	 3B/orNr/eHeal/YWBcBtuYqog7Ti6H/s6GLKibVh+jGIVSawwZ9B4Xwgs5Qryx6aMZ
	 38rN9jp523AxicCzHf3GRa0yExLhZIYplZH7hiR0DmJS+fxRmXtriTVzMIOQik8q0d
	 7UDmy2irM18AqR8pnYyPCYs8GHI/3E2tzeBHQ+3ACT7QdZEYpOPUxyU/7oZqsbEujU
	 JzgK84rrnDXDg==
Date: Fri, 6 Dec 2024 16:31:21 +0100
From: Christian Brauner <brauner@kernel.org>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org, 
	maple-tree@lists.infradead.org
Subject: Re: [PATCH RFC] pidfs: use maple tree
Message-ID: <20241206-kernlos-kopfhaar-2e260b637925@brauner>
References: <20241206-work-pidfs-maple_tree-v1-1-1cca6731b67f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241206-work-pidfs-maple_tree-v1-1-1cca6731b67f@kernel.org>

On Fri, Dec 06, 2024 at 04:25:13PM +0100, Christian Brauner wrote:
> So far we've been using an idr to track pidfs inodes. For some time now
> each struct pid has a unique 64bit value that is used as the inode
> number on 64 bit. That unique inode couldn't be used for looking up a
> specific struct pid though.
> 
> Now that we support file handles we need this ability while avoiding to
> leak actual pid identifiers into userspace which can be problematic in
> containers.
> 
> So far I had used an idr-based mechanism where the idr is used to
> generate a 32 bit number and each time it wraps we increment an upper
> bit value and generate a unique 64 bit value. The lower 32 bits are used
> to lookup the pid.
> 
> I've been looking at the maple tree because it now has
> mas_alloc_cyclic(). Since it uses unsigned long it would simplify the
> 64bit implementation and its dense node mode supposedly also helps to
> mitigate fragmentation.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
> Hey Liam,
> 
> Could you look this over and tell me whether my port makes any sense and
> is safe? This is the first time I've been playing with the maple tree.
> 
> I've also considerd preallocating the node during pid allocation outside
> of the spinlock using mas_preallocate() similar to how idr_preload()
> works but I'm unclear how the mas_preallocate() api is supposed to
> work in this case.
> 
> For the pidfs inode maple tree we use an external lock for add and
> remove. While looking at the maple_tree code I saw that mas_nomem()
> is called in mas_alloc_cyclic(). And mas_nomem() has a
> __must_hold(mas->tree->ma_lock) annotation. But then the code checks
> mt_external_lock() which is placed in a union with ma_lock iirc. So that
> annotation seems wrong?
> 
> bool mas_nomem(struct ma_state *mas, gfp_t gfp)
>         __must_hold(mas->tree->ma_lock)
> {
>         if (likely(mas->node != MA_ERROR(-ENOMEM)))
>                 return false;
> 
>         if (gfpflags_allow_blocking(gfp) && !mt_external_lock(mas->tree)) {
>                 mtree_unlock(mas->tree);
>                 mas_alloc_nodes(mas, gfp);
>                 mtree_lock(mas->tree);
>         } else {
>                 mas_alloc_nodes(mas, gfp);
>         }
> 
>         if (!mas_allocated(mas))
>                 return false;
> 
>         mas->status = ma_start;
>         return true;
> }
> 
> If you want to look at this in context I would please ask you to pull:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs-6.14.pidfs

Sorry, I meant work.pidfs.maple_tree.

