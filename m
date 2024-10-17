Return-Path: <linux-fsdevel+bounces-32207-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB6D9A25FB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 17:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A73B1C212C5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 15:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807DC1DE8AE;
	Thu, 17 Oct 2024 15:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vqgslW9o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9ECE1BFE18;
	Thu, 17 Oct 2024 15:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729177434; cv=none; b=tfkIPnoM/2FBto/xiln1Xh3rkE4flZ7RXC224vl1grcddwzFzWTF9XmTZp84ucOsBmcP8PeAUvQYrIMjN6P2O+UzSrdupb4jJB5pnZ9eLUVM4Fkm/lrBxX1pOBPSpMQDWgR/tmzCx8nPWS8gddcFMT9IJPDRfp7xgtFeNSnH7bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729177434; c=relaxed/simple;
	bh=3qm6NgTuW0lhFS3vYXsnXw1oGCETRzI/WvgBa19K3Bw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PmMbEkZzACebrOyPc46kYJkYW1y8pO6Xrn6cwW6DGsLArvrbP+lb3dONsHWT87+dLzwJQfrF5+ler2WgFIlKsBy7Gk7v4NwTcJHDoD056gzimzlE+57IRDrE/Dsc91MuJpU/rKaRQfTcBmE6cmBnU7gFbQkU8KJxpT3H9q+9bHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vqgslW9o; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8Zhh1z8tPQXl42tBRgf6ZXx4A5UIJKDHWuGsL+vtBrE=; b=vqgslW9orPMeEGcvw7++3CiiPA
	dG5qQ9F5j5z5AFJXoDPq16Kc1pG5IG7una9NkPSOMVFOXMopPgT+QJ8uO8BRg+nW4zmtQR+Q+3RI5
	Q6u278QsPAxxh/ZwLkQC8jtaRSm11s30vWFeXCa5mAmL0AgsOZtx7gmguLPf9lgsjDL28xEcJOFfK
	xRAYcxO3NJUPePX/V49DPZwek7tldT14qMAZCiERJ7ztjjgttgl3FJkAJx7JED02Q8dWYEFFtQs06
	J5AegZjvnJ6/J14ldmHre/HR9TOox2NoYvav9hby09PXL6xmI/9KDD7YhATsvq2EY1oCkKbNIy+l4
	rroFRR0g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t1S2Z-0000000FD9J-2KGM;
	Thu, 17 Oct 2024 15:03:51 +0000
Date: Thu, 17 Oct 2024 08:03:51 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Song Liu <songliubraving@meta.com>,
	Christoph Hellwig <hch@infradead.org>, Song Liu <song@kernel.org>,
	bpf <bpf@vger.kernel.org>,
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Kernel Team <kernel-team@meta.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Al Viro <viro@zeniv.linux.org.uk>, KP Singh <kpsingh@kernel.org>,
	Matt Bobrowski <mattbobrowski@google.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Extend test fs_kfuncs to
 cover security.bpf xattr names
Message-ID: <ZxEnV353YshfkmXe@infradead.org>
References: <20241002214637.3625277-1-song@kernel.org>
 <20241002214637.3625277-3-song@kernel.org>
 <Zw34dAaqA5tR6mHN@infradead.org>
 <0DB83868-0049-40E3-8E62-0D8D913CB9CB@fb.com>
 <Zw384bed3yVgZpoc@infradead.org>
 <BF0CD913-B067-4105-88C2-B068431EE9E5@fb.com>
 <20241016135155.otibqwcyqczxt26f@quack3>
 <20241016-luxus-winkt-4676cfdf25ff@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016-luxus-winkt-4676cfdf25ff@brauner>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Oct 16, 2024 at 04:51:37PM +0200, Christian Brauner wrote:
> > 
> > I think that getting user.* xattrs from bpf hooks can still be useful for
> > introspection and other tasks so I'm not convinced we should revert that
> > functionality but maybe it is too easy to misuse? I'm not really decided.
> 
> Reading user.* xattr is fine. If an LSM decides to built a security
> model around it then imho that's their business and since that happens
> in out-of-tree LSM programs: shrug.

By that argument user.kfuncs is even more useless as just being able
to read all xattrs should be just as fine.

