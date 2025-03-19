Return-Path: <linux-fsdevel+bounces-44423-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E80A686D8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 09:32:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BCE219C2CDC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 08:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6C1250C17;
	Wed, 19 Mar 2025 08:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="POpyccOU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6698211484
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Mar 2025 08:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742373124; cv=none; b=Op/uESCKbMKd7TndrXTcCvjBbExMsKck2BYlm3NkvO63TBFPhtLBTWjGFwczj08lGlwE0yRSVJaPpJwT+Mr/FrZ3Mi1kRsoqRmBDLo/tRn9/ipaeyUdzfYGJDsNTXXgLwcARop9EqQodMhgQrBegtElF57xxEdRlwJy0RT8+Cpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742373124; c=relaxed/simple;
	bh=a+qu+NxVe4aWMHFoiD0wQOkLA0qP/1UfE7AcOZ3W+Y8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=aRwGSNUH98MfiE69hhho3Rmrb1X1aggoHVf64g1y5Styz9R/4vLDV1a8dpQJ/DOxM99ajmZLrnFDEGacDmvThTYn7T40k9K/sQEU+dEr+m7yWr2jjWtDBgbOjKlSAxBVJLYwLZR+h5B7y962E9DdVhVpUHb7S+s4yxaqtR1v/yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=POpyccOU; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250319083152epoutp0135c7120e8eacefa9bbe37164df856dfe~uJx1XGIy01377613776epoutp01y
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Mar 2025 08:31:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250319083152epoutp0135c7120e8eacefa9bbe37164df856dfe~uJx1XGIy01377613776epoutp01y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1742373112;
	bh=K/I42gEhF8+GC7ZqtPeH+/HmpzRaenw4vGJUQrBfNOA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=POpyccOUuuACxUZPoD3tdUJw/OU6aBuHJBNLtqA4UYZAvN79F6HtScfFlSJN6P0SH
	 Z/UEmrByutMdiZmyR7n+96/W6YVeoGkE2IcM+TKvyQKsxA7qXdM3Cha95OKrwceY/A
	 ihxn0MMYnCUHMtz47FgDUOKWOZk5IMIEty6OHa1s=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20250319083152epcas5p3278eee3032e3dfc3ae9aeaacf2dcfa44~uJx0z9y8j0483704837epcas5p3q;
	Wed, 19 Mar 2025 08:31:52 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.179]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4ZHhlB2Sy7z4x9Pw; Wed, 19 Mar
	2025 08:31:50 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	9E.33.19956.6F08AD76; Wed, 19 Mar 2025 17:31:50 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250319081521epcas5p39ab71751aef70c73ba0f664db852ad69~uJjZrBSsY1841618416epcas5p3T;
	Wed, 19 Mar 2025 08:15:21 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250319081520epsmtrp19306fcf3b4d02de732feee6075cefb06~uJjZqKnkl2224222242epsmtrp1k;
	Wed, 19 Mar 2025 08:15:20 +0000 (GMT)
X-AuditID: b6c32a4b-fe9f470000004df4-b1-67da80f64934
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	7C.2E.33707.81D7AD76; Wed, 19 Mar 2025 17:15:20 +0900 (KST)
Received: from green245 (unknown [107.99.41.245]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20250319081519epsmtip2346857b8cbc697390ed7c7c663482382~uJjX9BelR2272622726epsmtip2r;
	Wed, 19 Mar 2025 08:15:19 +0000 (GMT)
Date: Wed, 19 Mar 2025 13:37:00 +0530
From: Anuj Gupta <anuj20.g@samsung.com>
To: Dave Chinner <david@fromorbit.com>
Cc: Jan Kara <jack@suse.cz>, Kundan Kumar <kundan.kumar@samsung.com>,
	Christoph Hellwig <hch@lst.de>, lsf-pc@lists.linux-foundation.org,
	linux-fsdevel@vger.kernel.org, mcgrof@kernel.org, joshi.k@samsung.com,
	axboe@kernel.dk, clm@meta.com, willy@infradead.org, gost.dev@samsung.com
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Parallelizing filesystem writeback
Message-ID: <20250319080700.GA16509@green245>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Z9jrmu9dXMUaNYba@dread.disaster.area>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBJsWRmVeSWpSXmKPExsWy7bCmuu63hlvpBh3fuS1W3+1ns9hyyd5i
	y7F7jBY3D+xksli5+iiTxezpzUwWR/+/ZbPY+uUrq8WevSdZLPa93stscWPCU0aL3z/msDnw
	eJxaJOGxeYWWx+WzpR6bVnWyeUy+sZzRY/fNBjaPcxcrPPq2rGL0OLPgCLvH501yAVxR2TYZ
	qYkpqUUKqXnJ+SmZeem2St7B8c7xpmYGhrqGlhbmSgp5ibmptkouPgG6bpk5QDcrKZQl5pQC
	hQISi4uV9O1sivJLS1IVMvKLS2yVUgtScgpMCvSKE3OLS/PS9fJSS6wMDQyMTIEKE7Izzi46
	xF7QJ1+x5PIO5gbG7xJdjJwcEgImErc+3GYCsYUEdjNK7N9o2cXIBWR/YpRYveAmE5zz6uZs
	ti5GDrCOA78yIOI7GSV2bvzJAuE8AyqaPY0dpIhFQFXi6AFGkKlsAuoSR563gtkiAmoSkybt
	YAapZxaYxyTR+mkCC0hCWMBbouH1ZlYQm1dAV+LN0n0sELagxMmZT8BsTgFjiTdnnoPViAoo
	SxzYdhzsOgmBIxwSTYuuskD84yLRu+AyG4QtLPHq+BZ2CFtK4mV/G5SdLvHj8lMmCLtAovnY
	PkYI216i9VQ/M4jNLJAhMe/GZqg5shJTT61jgojzSfT+fgLVyyuxYx6MrSTRvnIOlC0hsfdc
	A5TtIXG2eSMbJIR2sEj0bO5kmsAoPwvJc7OQ7IOwdSQW7P4EZHMA2dISy/9xQJiaEut36S9g
	ZF3FKJlaUJybnlpsWmCcl1oOj/Dk/NxNjOAkreW9g/HRgw96hxiZOBgPMUpwMCuJ8Lo/uZ4u
	xJuSWFmVWpQfX1Sak1p8iNEUGFkTmaVEk/OBeSKvJN7QxNLAxMzMzMTS2MxQSZy3eWdLupBA
	emJJanZqakFqEUwfEwenVAPTQtHlmitKzrJFv7j0+Onz+O35F/dt/d9gXL34ncSbaYJ91nWX
	2Beltvy/eHLRlYPSsUtP1Nwyavwe9COqfup86Xhb5QmBJlWCDbYcm61uev1vmBEZVKslfS03
	fo9uMYPM1Oe7FTcyTlb8fnbelOq4BZMNywXePt91cnOEptzKzO5OVs+OvWmHUzZwflNVUbsw
	92JQxY7fx16vP9RY0GzLszyxYvMx+YhX3Z4eOnX+89K2h9+e+fWp8uW7SuceSVj+dsx12nXF
	atL72zf95v6TOrp9+xQ3pucNCbPPH351pKmgz1N6Z8GMlZMORlm+XXH3dKJc6nJG95m3z6sW
	iyinb+Ovl9yc4rHh17s8m2qfBiWW4oxEQy3mouJEABvZSylbBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphkeLIzCtJLcpLzFFi42LZdlhJXlei9la6wb7nphar7/azWWy5ZG+x
	5dg9RoubB3YyWaxcfZTJYvb0ZiaLo//fslls/fKV1WLP3pMsFvte72W2uDHhKaPF7x9z2Bx4
	PE4tkvDYvELL4/LZUo9NqzrZPCbfWM7osftmA5vHuYsVHn1bVjF6nFlwhN3j8ya5AK4oLpuU
	1JzMstQifbsErowTX+4wFpyTqbj9ZBdjA+MFsS5GDg4JAROJA78yuhg5OYQEtjNKfOwOArEl
	BCQkTr1cxghhC0us/PecHaLmCaPEjp4UkFYWAVWJowfAStgE1CWOPG8Fs0UE1CQmTdrB3MXI
	xcEssIBJ4ujkaUwgCWEBb4mG15tZQWxeAV2JN0v3sYAUCQk8Y5ZY8O4kI0RCUOLkzCcsIDaz
	gJbEjX8vmUCWMQtISyz/xwES5hQwlnhz5jnYHFEBZYkD244zTWAUnIWkexaS7lkI3QsYmVcx
	iqYWFOem5yYXGOoVJ+YWl+al6yXn525iBEeUVtAOxmXr/+odYmTiYDzEKMHBrCTC6/7keroQ
	b0piZVVqUX58UWlOavEhRmkOFiVxXuWczhQhgfTEktTs1NSC1CKYLBMHp1QDk2z7E/MHX9/4
	XUvrfV0091j/q18F20skWXYxqZxb9yVx5rcjDkZXFmhyvFqbu/aKWr6Q2JNVkVE3bT/wLFv4
	unqfrbj/sU9LXtbdOSI8W7RhUoFFf2lhpdp8W4ZtItM2ZBh+kYpI3/t9n356xCyT5wYZFVq/
	0x5tKPX9zMIfvfS45/1uN5/OOrfDoq0lAZlGxxlPdDEo6b5YKj+RxVfhpdi/Jdc6Tf4GcVcs
	+PJ627xVcrwXNM+1fGkwc9X47Tp5yaaLqt/jivfEHd3ANzeUebMI89fkz/78qrePFZ2c43Hj
	dsifBfNSORVlEpPvb522yWSdZOyfB7MOzlTLaTw2nfegkRzT6ZLZinOXaXez6SqxFGckGmox
	FxUnAgD9LAioFwMAAA==
X-CMS-MailID: 20250319081521epcas5p39ab71751aef70c73ba0f664db852ad69
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="-----n9Uixv_.-ZhL2v3ig-snSfcYkP.kLEj6PbqjIokIlCsp6vK=_1765d_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250319081521epcas5p39ab71751aef70c73ba0f664db852ad69
References: <20250129102627.161448-1-kundan.kumar@samsung.com>
	<Z5qw_1BOqiFum5Dn@dread.disaster.area>
	<20250131093209.6luwm4ny5kj34jqc@green245>
	<Z6GAYFN3foyBlUxK@dread.disaster.area> <20250204050642.GF28103@lst.de>
	<s43qlmnbtjbpc5vn75gokti3au7qhvgx6qj7qrecmkd2dgrdfv@no2i7qifnvvk>
	<Z6qkLjSj1K047yPt@dread.disaster.area>
	<20250220141824.ju5va75s3xp472cd@green245>
	<qdgoyhi5qjnlfk6zmlizp2lcrmg43rwmy3tl4yz6zkgavgfav5@nsfculj7aoxe>
	<Z9jrmu9dXMUaNYba@dread.disaster.area>
	<CGME20250319081521epcas5p39ab71751aef70c73ba0f664db852ad69@epcas5p3.samsung.com>

-------n9Uixv_.-ZhL2v3ig-snSfcYkP.kLEj6PbqjIokIlCsp6vK=_1765d_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Tue, Mar 18, 2025 at 02:42:18PM +1100, Dave Chinner wrote:
> On Thu, Mar 13, 2025 at 09:22:00PM +0100, Jan Kara wrote:
> > On Thu 20-02-25 19:49:22, Kundan Kumar wrote:
> > > > Well, that's currently selected by __inode_attach_wb() based on
> > > > whether there is a memcg attached to the folio/task being dirtied or
> > > > not. If there isn't a cgroup based writeback task, then it uses the
> > > > bdi->wb as the wb context.
> > > 
> > > We have created a proof of concept for per-AG context-based writeback, as
> > > described in [1]. The AG is mapped to a writeback context (wb_ctx). Using
> > > the filesystem handler, __mark_inode_dirty() selects writeback context
> > > corresponding to the inode.
> > > 
> > > We attempted to handle memcg and bdi based writeback in a similar manner.
> > > This approach aims to maintain the original writeback semantics while
> > > providing parallelism. This helps in pushing more data early to the
> > > device, trying to ease the write pressure faster.
> > > [1] https://lore.kernel.org/all/20250212103634.448437-1-kundan.kumar@samsung.com/
> > 
> > Yeah, I've seen the patches. Sorry for not getting to you earlier.
> >  
> > > > Then selecting inodes for writeback becomes a list_lru_walk()
> > > > variant depending on what needs to be written back (e.g. physical
> > > > node, memcg, both, everything that is dirty everywhere, etc).
> > > 
> > > We considered using list_lru to track inodes within a writeback context.
> > > This can be implemented as:
> > > struct bdi_writeback {
> > >  struct list_lru b_dirty_inodes_lru; // instead of a single b_dirty list
> > >  struct list_lru b_io_dirty_inodes_lru;
> > >  ...
> > >  ...
> > > };
> > > By doing this, we would obtain a sharded list of inodes per NUMA node.
> > 
> > I think you've misunderstood Dave's suggestion here. list_lru was given as
> > an example of a structure for inspiration. We cannot take it directly as is
> > for writeback purposes because we don't want to be sharding based on NUMA
> > nodes but rather based on some other (likely FS driven) criteria.
> 
> Well, you might say that, but.....
> 
> ... I was actually thinking of taking the list_lru and abstracting
> it's N-way parallelism away from the numa infrastructure.
> 
> The NUMA awareness of the list_lru is largely in external APIs. Th
> eonly implicit NUMA awareness is in the list_lru_add() function
> where it converts the object being added to the list to a node ID
> based on where it is physically located in memory.
> 
> The only other thing that is NUMA specific is that the list is set
> up with N-way concurrency when N = the number of NUMA nodes in the
> machine.
> 
> So, really, it is just thin veneer of NUMA wrapped around the
> inherent concurrency built into the structure.
> 
> IOWs, when we create a list_lru for a numa aware shrinker, we simply
> use the number of nodes as the N-way parallelism for the list,
> and the existing per-node infrastructure simply feeds the right
> numa node ID as the "list index" for it to function as is.
> 
> In the case of writeback parallelism, we could create a list_lru
> with the number of AGs as the N-way parallism for the list, and then
> have the concurrent BDI writeback context (1 per AG) simply provide
> the AG number as the "list index" for writeback....
> 

If we go ahead with Jan's suggestion, each AG will have a separate
bdi_writeback_context. Each bdi_writeback_context has its own b_dirty
inode list. This naturally partitions inodes per AG. Given that, do we
still need AG based sharded list_lru? Am I missing something here?

-------n9Uixv_.-ZhL2v3ig-snSfcYkP.kLEj6PbqjIokIlCsp6vK=_1765d_
Content-Type: text/plain; charset="utf-8"


-------n9Uixv_.-ZhL2v3ig-snSfcYkP.kLEj6PbqjIokIlCsp6vK=_1765d_--

