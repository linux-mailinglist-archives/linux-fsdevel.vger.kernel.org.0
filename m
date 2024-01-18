Return-Path: <linux-fsdevel+bounces-8216-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA8A8310FB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 02:39:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDE001C21569
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 01:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB710211C;
	Thu, 18 Jan 2024 01:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="oEsrkKcs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB5E184C;
	Thu, 18 Jan 2024 01:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705541959; cv=none; b=rp86psSrye/WIG64iYIghBX2RvQh5aYgEGUUxZyHKtoe83C8tKbgcYe8hs8dwZqs6WsWfH2KetbXTRgA8n0NgUcQVikkhs8ObkFr0AQ2mtZYxvCpiHf/h/GGF9rMy6rBncwYbB9wz/pTaIPKvs0yW/6oyMZB6eE9c2eI2ygDYRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705541959; c=relaxed/simple;
	bh=fhsIDzla0e62/HjWeLJvNtsOnBaIafn/n/Ktvt7/xwg=;
	h=DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:Sender; b=DBnlhZ3iwteXQhVbXlcTRtX5V58Bw09O87Yapkpfebk/LghWxt0gkHxt77C5DImbH1JuKiPMB8Usaq7OS5Qx4DYhSsDEK6ffcXGup9tpkqlgedEDhj59/TtQzx9tDShdM6o59szwkoWipms8Yq3V4kzZLeCuWIjV8TR2QxTRyDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=oEsrkKcs; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=w13llrR137QJAbt1+mR8vqmqXqRNx+wxIFH7k4GCagI=; b=oEsrkKcsfc9527LZXvFsOgbVc+
	qgbY5hmf3S19u2tybAPsbbS8x9aZ1O/G2cYeBtMkZnH7NwD3qHNVfdOBVZwQQQ7bQkoEW6/pBJ5/x
	x02BhWXyjamDfUZe9u7tAfcM+2dAjqkPVcDflmm4LRShv41d94aLq3BUxbuEg0MByGmp/a5gG0SiE
	oIrdKJdMzTOubP1Ikd5ltd89GqFB/JdQMzOfm7Dn7ZtxHZbvxxXplWyJ6oJ6oqr4S2pYU513Vlr+P
	FntGEluXLPNaomz0N+DMs9OvPsAA1e+XulU0pQZl+K33D1E75vNzUDEzeswRbgRDArKwQcRi69t3H
	13Fs2i5Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rQHMv-006xCv-19;
	Thu, 18 Jan 2024 01:38:57 +0000
Date: Thu, 18 Jan 2024 01:38:57 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, brauner@kernel.org,
	jack@suse.cz, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: improve dump_mapping() robustness
Message-ID: <20240118013857.GO1674809@ZenIV>
References: <937ab1f87328516821d39be672b6bc18861d9d3e.1705391420.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <937ab1f87328516821d39be672b6bc18861d9d3e.1705391420.git.baolin.wang@linux.alibaba.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Jan 16, 2024 at 03:53:35PM +0800, Baolin Wang wrote:

> With checking the 'dentry.parent' and 'dentry.d_name.name' used by
> dentry_name(), I can see dump_mapping() will output the invalid dentry
> instead of crashing the system when this issue is reproduced again.

>  	dentry_ptr = container_of(dentry_first, struct dentry, d_u.d_alias);
> -	if (get_kernel_nofault(dentry, dentry_ptr)) {
> +	if (get_kernel_nofault(dentry, dentry_ptr) ||
> +	    !dentry.d_parent || !dentry.d_name.name) {
>  		pr_warn("aops:%ps ino:%lx invalid dentry:%px\n",
>  				a_ops, ino, dentry_ptr);
>  		return;

That's nowhere near enough.  Your ->d_name.name can bloody well be pointing
to an external name that gets freed right under you.  Legitimately so.

Think what happens if dentry has a long name (longer than would fit into
the embedded array) and gets renamed name just after you copy it into
a local variable.  Old name will get freed.  Yes, freeing is RCU-delayed,
but I don't see anything that would prevent your thread losing CPU
and not getting it back until after the sucker's been freed.

