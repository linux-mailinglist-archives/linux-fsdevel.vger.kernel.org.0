Return-Path: <linux-fsdevel+bounces-31941-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4394599DEA0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 08:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1F87B21955
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 06:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06AFD18A6D9;
	Tue, 15 Oct 2024 06:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aHOMS+zf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7C7189BBF;
	Tue, 15 Oct 2024 06:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728974560; cv=none; b=Sw5C9sRdFPZO7cMnYFPrULHv4hqQJ7l33BYmqC+eCPtvYpPX3M5w5D+4b81ssFakovaGzHTwBdfwswW2A2hNDaQzqhqV562mELlEBVgMhNynEySqJH/LTOrumqPKyG/2mcBBulmRzoAsjTkOpX8RjpFENtNqD4Zo0n2XZbeMIDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728974560; c=relaxed/simple;
	bh=aiXNLSRhQN0z1MRO9ms2eURg5IDM20JVzKogOwDL9+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e5qdMDidjKt5KARuGeEnp7vyIFhomQDnQ16RplqZpI+j/I3BVbOHR0LNHzBfslXIdwftNXk8Sc7zcE1x2lmpaZoW3aQrrFYuh3VAvOU1FQ6jyYDOfbS/wNaSqjeGwuoZNc563zK9Jb0PM/O8sYCtypS8LN9P1U/xMK/p216TOSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aHOMS+zf; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MQf6eU49nzCPx7wGCmxXqAfm87s3A8uKXv6OumyhoYM=; b=aHOMS+zf8Iz6zGFDFvEkw7RZrK
	h3McXlcOlpgV4Ay57ILIK+BqQtcwyVMydca+eLBCkcjPFB4O2WzKik2NKswWrtmRvwKc/zPNq3Xep
	VKutjVCFSUW1UPvtPtm2VkuMZgHNQs1ne8fvyI8+HCuzW/xBeP10XYyAxHsSGA86a21HyfG6EEZlV
	387WcH3NCDww/fA0OTZt6+TW+RbDRzxhsBpUzX4hu/yIzndNUYTjSFsj6X5y21G7Cgn6VdRTuTVf4
	vLV2h5ZDCscac2BbJIlAToVGeqL/Ffmk7Xv2KuuGiRSsflDYlR69TVWCY2ES5u4vr5b4BboZ/JWoE
	Wy33STMg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t0bGP-00000007F6f-3YZB;
	Tue, 15 Oct 2024 06:42:37 +0000
Date: Mon, 14 Oct 2024 23:42:37 -0700
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
Message-ID: <Zw4O3cqC6tlr5Kty@infradead.org>
References: <20241002214637.3625277-1-song@kernel.org>
 <20241002214637.3625277-3-song@kernel.org>
 <Zw34dAaqA5tR6mHN@infradead.org>
 <0DB83868-0049-40E3-8E62-0D8D913CB9CB@fb.com>
 <Zw384bed3yVgZpoc@infradead.org>
 <BF0CD913-B067-4105-88C2-B068431EE9E5@fb.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BF0CD913-B067-4105-88C2-B068431EE9E5@fb.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Oct 15, 2024 at 05:52:02AM +0000, Song Liu wrote:
> >> Do you mean user.* xattrs are untrusted (any user can set it), so we 
> >> should not allow BPF programs to read them? Or do you mean xattr 
> >> name "user.kfuncs" might be taken by some use space?
> > 
> > All of the above.
> 
> This is a selftest, "user.kfunc" is picked for this test. The kfuncs
> (bpf_get_[file|dentry]_xattr) can read any user.* xattrs. 
> 
> Reading untrusted xattrs from trust BPF LSM program can be useful. 
> For example, we can sign a binary with private key, and save the
> signature in the xattr. Then the kernel can verify the signature
> and the binary matches the public key.

I would expect that to be done through an actual privileged interface.
Taking an arbitrary name that was available for use by user space
programs for 20 years and now giving it a new meaning is not a good
idea.


