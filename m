Return-Path: <linux-fsdevel+bounces-51706-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE475ADA7AD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 07:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 550F93A4955
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 05:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25AF01DE3B5;
	Mon, 16 Jun 2025 05:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pQ77EsXD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF441C5F14;
	Mon, 16 Jun 2025 05:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750051462; cv=none; b=pEJqOFYjJKG5WC1fxw9No6mfyJZhs0ePGF2Cz756Jb0AWu5HRlDm/Ir6Fmypk9CgkcI9hyjaqkYhTa3TU6n+NwDVJKLF53edRlhmz6BqwN7daEvIbKIeteRB3y/cNG6N+7EFnigGBrh6Dfh0mPrLtZmoWvoyn42rNyp+O4t2Vns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750051462; c=relaxed/simple;
	bh=vjnuRZwyrWXoziF3PZ3jGavEdFO9Ts8C3nKy4TtQQSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ImiMyT+7OhuPCDX9ceVypf/owbMZkgt5Eo96Qf4OH5KcPbcRjbGmiKhV1gdnGXadi6MSC6r7HFbSTMA+WUq2lRaqPgVxw2UumZdbnP5qPLxaCMrPZsonw9YM0phMDBS9AqDMI1OJgP7RTI3vaotjqhSeblMjoUl3qkmag5POvOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pQ77EsXD; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=J+qg7kSmf2TF3wMSin7ImGQUTOPpXGE9k8KtVX9AqP8=; b=pQ77EsXDWlBVfOokOtyvM2AqZk
	/5sJyBbv18xN5qvJqYCVZ2zez0MNX+UfQ/zigrpsIgk0ZxNgyUqst5VWe4DLy8JebcgG7NjoCG733
	+BE9KWtygS4KcEeGSVEotzZcYhpfRWwhCC5TPI0VS57ROHbI3Pst2EgwFVmDJz9hy3vlyK15q5uAd
	/pd+wwiGcnKcUdCQxFt8fqwgBBDy4oveuCamlEgcldv+89g96N96tHTTiUT3gzLkkYCZnboNMW32g
	Rk+CvNEP02gA7+EQtZh3864PDFDCUhbv6z2d8qvz+fLUSlmleCQnT+q/D2nQtAGs4rmiw7cmex1lr
	PIMQSFjA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uR2KG-00000003QI9-45k3;
	Mon, 16 Jun 2025 05:24:09 +0000
Date: Sun, 15 Jun 2025 22:24:08 -0700
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
Message-ID: <aE-qeCaW_1lDxEBa@infradead.org>
References: <aD7x_b0hVyvZDUsl@infradead.org>
 <09c8fb7c-a337-4813-9f44-3a538c4ee8b1@amd.com>
 <aD72alIxu718uri4@infradead.org>
 <5d36abace6bf492aadd847f0fabc38be@honor.com>
 <a766fbf4-6cda-43a5-a1c7-61a3838f93f9@amd.com>
 <aEZkjA1L-dP_Qt3U@infradead.org>
 <761986ec0f404856b6f21c3feca67012@honor.com>
 <d86a677b-e8a7-4611-9494-06907c661f05@amd.com>
 <aEg1BZj-HzbgWKsx@infradead.org>
 <80ce3ec9104c4f0abbcb589b03a5f3c7@honor.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80ce3ec9104c4f0abbcb589b03a5f3c7@honor.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Jun 13, 2025 at 09:43:08AM +0000, wangtao wrote:
> Here's my analysis on Linux 6.6 with F2FS/iomap.

Linux 6.6 is almost two years old and completely irrelevant.  Please
provide numbers on 6.16 or current Linus' tree.


