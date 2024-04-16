Return-Path: <linux-fsdevel+bounces-17008-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A860B8A605F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 03:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 447D11F21A3A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 01:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815EA6FC7;
	Tue, 16 Apr 2024 01:34:48 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125487464;
	Tue, 16 Apr 2024 01:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713231288; cv=none; b=DH1w5mCBmGVlWiY7qkCS5ogKLAxfVvSFAz/OvOs7piJNI5o1oTULkuIBLKJqU/QUS5Omj4v9KGUVhT0aFbkNgJkshIkSna1mArin4FTO1kXd5LILLN6QnJh3MlqCrlFeZdlj+/GlM7ZO+tXb1w5fnXD3sq7IyF/lruS7hWyIr8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713231288; c=relaxed/simple;
	bh=mJem2Ufbl9Ew2/f7xgNNLsKEvT9e4WkGZGTdtTMWaTk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XODnLMxgmGM7K6ZPj838D+DoSbZjK66zHagpPxmZwwcj3Hh+BaGaKORCr5jcO4wkP/r7y9yQEdV29qC77+lr3qLCCh2ysSqtqKXxPiJln1zL/r/jXXgLbgFVPfUkP7zA65Ms87NVdIQaeS8eyJ14D5xXOlqm8xpkdMmViYGOuaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4VJRQJ1YQ9z1ws14;
	Tue, 16 Apr 2024 09:33:44 +0800 (CST)
Received: from kwepemi500009.china.huawei.com (unknown [7.221.188.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 2049E1400D5;
	Tue, 16 Apr 2024 09:34:42 +0800 (CST)
Received: from localhost (10.175.127.227) by kwepemi500009.china.huawei.com
 (7.221.188.199) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 16 Apr
 2024 09:34:41 +0800
Date: Tue, 16 Apr 2024 09:35:20 +0800
From: Long Li <leo.lilong@huawei.com>
To: Andrew Morton <akpm@linux-foundation.org>
CC: <willy@infradead.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>, <houtao1@huawei.com>,
	<yangerkun@huawei.com>
Subject: Re: [PATCH] xarray: inline xas_descend to improve performance
Message-ID: <20240416013520.GA506789@ceph-admin>
References: <20240415012136.3636671-1-leo.lilong@huawei.com>
 <20240415131053.051e60135eacf281df6921f6@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20240415131053.051e60135eacf281df6921f6@linux-foundation.org>
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500009.china.huawei.com (7.221.188.199)

On Mon, Apr 15, 2024 at 01:10:53PM -0700, Andrew Morton wrote:
> On Mon, 15 Apr 2024 09:21:36 +0800 Long Li <leo.lilong@huawei.com> wrote:
> 
> > The commit 63b1898fffcd ("XArray: Disallow sibling entries of nodes")
> > modified the xas_descend function in such a way that it was no longer
> > being compiled as an inline function, because it increased the size of
> > xas_descend(), and the compiler no longer optimizes it as inline. This
> > had a negative impact on performance, xas_descend is called frequently
> > to traverse downwards in the xarray tree, making it a hot function.
> > 
> > Inlining xas_descend has been shown to significantly improve performance
> > by approximately 4.95% in the iozone write test.
> > 
> >   Machine: Intel(R) Xeon(R) Gold 6240 CPU @ 2.60GHz
> >   #iozone i 0 -i 1 -s 64g -r 16m -f /test/tmptest
> > 
> > Before this patch:
> > 
> >        kB    reclen    write   rewrite     read    reread
> >  67108864     16384  2230080   3637689 6 315197   5496027
> > 
> > After this patch:
> > 
> >        kB    reclen    write   rewrite     read    reread
> >  67108864     16384  2340360   3666175  6272401   5460782
> > 
> > Percentage change:
> >                        4.95%     0.78%   -0.68%    -0.64%
> > 
> > This patch introduces inlining to the xas_descend function. While this
> > change increases the size of lib/xarray.o, the performance gains in
> > critical workloads make this an acceptable trade-off.
> > 
> > Size comparison before and after patch:
> > .text		.data		.bss		file
> > 0x3502		    0		   0		lib/xarray.o.before
> > 0x3602		    0		   0		lib/xarray.o.after
> > 
> > ...
> >
> > --- a/lib/xarray.c
> > +++ b/lib/xarray.c
> > @@ -200,7 +200,7 @@ static void *xas_start(struct xa_state *xas)
> >  	return entry;
> >  }
> >  
> > -static void *xas_descend(struct xa_state *xas, struct xa_node *node)
> > +static inline void *xas_descend(struct xa_state *xas, struct xa_node *node)
> >  {
> >  	unsigned int offset = get_offset(xas->xa_index, node);
> >  	void *entry = xa_entry(xas->xa, node, offset);
> 
> I thought gcc nowadays treats `inline' as avisory and still makes up
> its own mind?
> 
> Perhaps we should use __always_inline here?

Yes, I agree with you, I will send a new version. thanks!

