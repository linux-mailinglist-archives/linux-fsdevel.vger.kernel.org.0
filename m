Return-Path: <linux-fsdevel+bounces-69905-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEEB4C8B63E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 19:10:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72D723A3932
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 18:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C8830EF67;
	Wed, 26 Nov 2025 18:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="UwduLDd2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F02D279DAB;
	Wed, 26 Nov 2025 18:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764180639; cv=none; b=KkYzY7RrRJwUfFoL1Jl92NIA/T3nbwaVk71beHI2cq66KeNMzSxgEPRN5ozCDI6QkHCKuCQu/lTQHYT/B7ukpnhIUvC2dJwr8GNHCAmE3lb+BPduI/12z8ao5C+YWxXSWROumP03K2gHzCPZ+qR+PgNxbrZUR340a1J2ovaEOtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764180639; c=relaxed/simple;
	bh=13OJotMS9uxD2wgIVDkGSwJx750XMvizYmyzY4oLYb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EPo84TFuRvvVT4x9U0lI5k9UYYgEkHsxwVriwy6gBim4lb1APFkQuqqJPCyokK0V3qQuEHMaLStsNbCdzL+QVviiNfbt30j4Q4M+sMk3EYOzGJVEu0y6JNHuA3VdjSPCWvZisV3Aqxvrj2OIg3Ax6xOelZU1+QLjphOaVR4i0Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=UwduLDd2; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=DXnZBmMMcBqaL+DvhiYDDvgc0bvBDpQl+0qRcxV/rMI=; b=UwduLDd2QSBZYnTFsQNeZ7gUhb
	ugR7BEq1Awwb0Sl1pJANgCHa9RbW5fJogb979YgNPHGV9moAmTbrJ6s+dLcDAnnFOkdE4tVuubBSH
	1VmQFY5MTGbuZQOjMR/K5XUeGRnPdTc96EEZU292HRpDwwwP/7Qp6fj3DKKvaETaf3TfjYtpFLcZh
	2WxqQkz0AeUZ06OWl+kipIg5QxxFnOtma8Aeti10N6RW81xfDSQB5RODA2zZdiOKlBpbAYz0kgd0d
	w5QRtNcGq0hOCNpK0/DWciUgfLnpEdCNlBBC2JezPucP0NYoOXK57GRna2MFXOhCuGmbsTWXDf04q
	5dglf4Yw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99 #2 (Red Hat Linux))
	id 1vOJyJ-0000000Gm9v-1MMj;
	Wed, 26 Nov 2025 18:10:31 +0000
Date: Wed, 26 Nov 2025 18:10:31 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Xie Yuanbin <xieyuanbin1@huawei.com>
Cc: brauner@kernel.org, jack@suse.cz, linux@armlinux.org.uk,
	will@kernel.org, nico@fluxnic.net, akpm@linux-foundation.org,
	hch@lst.de, jack@suse.com, wozizhi@huaweicloud.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
	lilinjie8@huawei.com, liaohua4@huawei.com,
	wangkefeng.wang@huawei.com, pangliyuan1@huawei.com
Subject: Re: [RFC PATCH] vfs: Fix might sleep in load_unaligned_zeropad()
 with rcu read lock held
Message-ID: <20251126181031.GA3538@ZenIV>
References: <20251126090505.3057219-1-wozizhi@huaweicloud.com>
 <20251126101952.174467-1-xieyuanbin1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251126101952.174467-1-xieyuanbin1@huawei.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Nov 26, 2025 at 06:19:52PM +0800, Xie Yuanbin wrote:
> When the path is initialized with LOOKUP_RCU flag in path_init(), the
> rcu read lock will be acquired. Inside the rcu critical section,
> load_unaligned_zeropad() may be called. According to the comments of
> load_unaligned_zeropad(), when loading the memory, a page fault may be
> triggered in the very unlikely case.

> Add pagefault_disable() to handle this situation.

Way too costly, IMO.  That needs to be dealt with in page fault handler
and IIRC arm used to do that; did that get broken at some point?

