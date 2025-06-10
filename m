Return-Path: <linux-fsdevel+bounces-51167-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B78DAD3978
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 15:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04FF116E93F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 13:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE4A25B30D;
	Tue, 10 Jun 2025 13:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="U0Ep+1JR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B521F17736;
	Tue, 10 Jun 2025 13:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749562486; cv=none; b=s1M5sGTU9MR/kX5QsndZmKWQm5XSLKnKtcwRfR2iNty6t+vzkqOpXi639pBt3/dMf03+iTh5uRuwY9FVjFbO62NMsNsPPbj5AUY3Fz33A/j6d8fYE3pJbOZT8lLxNsG9F4g+BIMPO/g3r3vJ4vdtBN0rBtWGQrGqmWzcyCNQABs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749562486; c=relaxed/simple;
	bh=MOOfKRpPRTUUZtP6G8zk3QqaFEwZW/S6yRgDsEYfs+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S52Qbgi6/kndbH1gvV/XcVQkogsyG+qY5yqn97vE1/sUc+SqlWLVP9Yz+sLsro5ia4fgXT33oWDye4BRTFXaekH8Knm/Bj+gWJyECxlTeAyqsK10aNyH9qalmU4FShATP0huY493KJ+FytSYHQZg9W4zPNEruPGPj8nVjbEn0h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=U0Ep+1JR; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MOOfKRpPRTUUZtP6G8zk3QqaFEwZW/S6yRgDsEYfs+4=; b=U0Ep+1JRg1+M/75WhPBAUZs+Oq
	6iycChpWzpXMnUGEmJqdZUSdpqoh+g0REuJ+Cdw9o8cwoOJpvNq6bVioy9erzYPsIDc/DrnOyFe6D
	OsC5q1oDTpmwc/MGSHXjpRwE2v/OE2ItG875dknYWDEbrhGMoWBUOQQzwd1OwC7cBJRzLjntGfpaB
	/WdPZq3JIQeuEu4wyUU5qkF28R411HgORdmfPIWeeewAJX0UQ+BYCp7z2WX47v/WL0aFYpwiK95J9
	FfPxD28BlKafN77peVqWJxzKhm2z8ZoDzvBq3CnLvVGBMSBN+6rUbzM7HrSTgmjiJ/HlD3nxJOVPf
	FryPjXQg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOz7Z-00000006zNd-2xsx;
	Tue, 10 Jun 2025 13:34:33 +0000
Date: Tue, 10 Jun 2025 06:34:33 -0700
From: Christoph Hellwig <hch@infradead.org>
To: wangtao <tao.wangtao@honor.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	"sumit.semwal@linaro.org" <sumit.semwal@linaro.org>,
	"kraxel@redhat.com" <kraxel@redhat.com>,
	"vivek.kasireddy@intel.com" <vivek.kasireddy@intel.com>,
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
	"brauner@kernel.org" <brauner@kernel.org>,
	"hughd@google.com" <hughd@google.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"amir73il@gmail.com" <amir73il@gmail.com>,
	"benjamin.gaignard@collabora.com" <benjamin.gaignard@collabora.com>,
	"Brian.Starkey@arm.com" <Brian.Starkey@arm.com>,
	"jstultz@google.com" <jstultz@google.com>,
	"tjmercier@google.com" <tjmercier@google.com>,
	"jack@suse.cz" <jack@suse.cz>,
	"baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"wangbintian(BintianWang)" <bintian.wang@honor.com>,
	yipengxiang <yipengxiang@honor.com>,
	liulu 00013167 <liulu.liu@honor.com>,
	hanfeng 00012985 <feng.han@honor.com>
Subject: Re: [PATCH v4 0/4] Implement dmabuf direct I/O via copy_file_range
Message-ID: <aEg0aYQJ9h_tyum9@infradead.org>
References: <20250603095245.17478-1-tao.wangtao@honor.com>
 <aD7x_b0hVyvZDUsl@infradead.org>
 <09c8fb7c-a337-4813-9f44-3a538c4ee8b1@amd.com>
 <aD72alIxu718uri4@infradead.org>
 <5d36abace6bf492aadd847f0fabc38be@honor.com>
 <a766fbf4-6cda-43a5-a1c7-61a3838f93f9@amd.com>
 <aEZkjA1L-dP_Qt3U@infradead.org>
 <761986ec0f404856b6f21c3feca67012@honor.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <761986ec0f404856b6f21c3feca67012@honor.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Jun 09, 2025 at 09:32:20AM +0000, wangtao wrote:
> Are you suggesting adding an ITER_DMABUF type to iov_iter,

Yes.


