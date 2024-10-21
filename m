Return-Path: <linux-fsdevel+bounces-32488-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E72E9A6A06
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 15:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DACC1C227A7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 13:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43791F6661;
	Mon, 21 Oct 2024 13:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gWsxTbPG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B01A194C62;
	Mon, 21 Oct 2024 13:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729517076; cv=none; b=El91wnxpULrpbqXUY6S6CSExt/k2I9jbDMA8pdVxKrdYpuIXUVYWZs2V7Jd2Y64NthKqdQmCR7QKgOGn4YJnK5H7BARq93eX+YHedpAJ39sHkw7nj41XPvenr9hVBxs/VbXDRUg7xV/rO9VwRd50sX22zX5PY/LhlsQ/nsVwMAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729517076; c=relaxed/simple;
	bh=r+zKiREXrZk5D3hxSgQ1MLCydswkdcdo/IqSPLFxAWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nuIqulCbtFsa/+dX0hoK+pPDh5yg/Z+CVXtDzCV4/sSCpZ6+BpRmQuu+0iF7+gnO2nli9AiDYiZf7JCBejIIV18anB5B9opfaRRB49Ow8g9nIkGbYhI40nDATAcamp6r0xWGkkI0HWh61MjxIzYUH55rPkHg6zzivtuA/L5Azuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gWsxTbPG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AB81C4CEC3;
	Mon, 21 Oct 2024 13:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729517075;
	bh=r+zKiREXrZk5D3hxSgQ1MLCydswkdcdo/IqSPLFxAWc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gWsxTbPGKx0cuJ9J/kh30dMOTlRZR+9/CWo5V2FcZTzrNBRYRKRm+ujHIVxqunvU4
	 ZZlkSSHGQQIDNPanNODaIgSwNEDDliuHmbuPzci+SjsajdMSRAoj82GX0b9L/IJRL2
	 G8bd8i13vlEEekzqaIg20o0xYgVC+TpUsPO0jstYxJFwv3OD38Vul1AMM7AjHVA8x9
	 wuWeeAS/Zf3rp9kXhHLpWl2pWbsZSx+b1fiH8rERPJBOkcv7RxwMEKgKRdxzrYlsFr
	 4XIgjymK3cmA8NGyGn1lJqRS80CvIQReuXwGQwfb1IQ3EuF1eA8B8lxodIAnWl52g/
	 GqObBs9XY/2bQ==
Date: Mon, 21 Oct 2024 15:24:30 +0200
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jan Kara <jack@suse.cz>, Song Liu <songliubraving@meta.com>, 
	Song Liu <song@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Kernel Team <kernel-team@meta.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Al Viro <viro@zeniv.linux.org.uk>, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Extend test fs_kfuncs to
 cover security.bpf xattr names
Message-ID: <20241021-ausgleichen-wesen-3d3ae116f742@brauner>
References: <20241002214637.3625277-1-song@kernel.org>
 <20241002214637.3625277-3-song@kernel.org>
 <Zw34dAaqA5tR6mHN@infradead.org>
 <0DB83868-0049-40E3-8E62-0D8D913CB9CB@fb.com>
 <Zw384bed3yVgZpoc@infradead.org>
 <BF0CD913-B067-4105-88C2-B068431EE9E5@fb.com>
 <20241016135155.otibqwcyqczxt26f@quack3>
 <20241016-luxus-winkt-4676cfdf25ff@brauner>
 <ZxEnV353YshfkmXe@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZxEnV353YshfkmXe@infradead.org>

On Thu, Oct 17, 2024 at 08:03:51AM -0700, Christoph Hellwig wrote:
> On Wed, Oct 16, 2024 at 04:51:37PM +0200, Christian Brauner wrote:
> > > 
> > > I think that getting user.* xattrs from bpf hooks can still be useful for
> > > introspection and other tasks so I'm not convinced we should revert that
> > > functionality but maybe it is too easy to misuse? I'm not really decided.
> > 
> > Reading user.* xattr is fine. If an LSM decides to built a security
> > model around it then imho that's their business and since that happens
> > in out-of-tree LSM programs: shrug.
> 
> By that argument user.kfuncs is even more useless as just being able
> to read all xattrs should be just as fine.

bpf shouldn't read security.* of another LSM or a host of other examples...

