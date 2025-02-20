Return-Path: <linux-fsdevel+bounces-42170-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5EFA3DD1D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2025 15:41:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 523993B8AB0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2025 14:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1911F03CB;
	Thu, 20 Feb 2025 14:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="frdCSBft"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A582F1E32BD
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Feb 2025 14:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740062134; cv=none; b=IiW2HeyZgE4nC9NE/yyGs/oEWu9vxcugs32cwskORl+5eUS3jvFmzQ5a4ZnnT5dqdsvcWTdXCoc1T/wt0YXu6OTsgszCIVUbQUtVBsbV099idy1uIKgzCQsHEzoK7AdZc28Swef0R6cUz9z6wX9H/wSFrU839z8mZ2331/sLO88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740062134; c=relaxed/simple;
	bh=J3PA2JFOhsFihquLg4Vi33wiPGCfm2MC9/jS+dZvRx0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=JkO2BWULiZMm8GiL0Di1C69YG2bPxV05RirBAkmF2KSPV8arxManqEYt1FMig0W/zY6CJXhrxfVc+eo+oy4IWiuvGJ1Dbl/wCKNRDzHF+djEo06qnFdIPWJGEwMc420RJhOQqVI86e+hzxMhjPdFZs1D0QgEvM4FZZWndHADGZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=frdCSBft; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250220143524epoutp04d05adc770d323a21034bc826fed055ca~l8UhWX2Ds0053200532epoutp04k
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Feb 2025 14:35:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250220143524epoutp04d05adc770d323a21034bc826fed055ca~l8UhWX2Ds0053200532epoutp04k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1740062124;
	bh=vZFcOrTJQBYPqHaoWH+lzUchbPssFFmySJGZ2uok/7c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=frdCSBftPMyKnuFvb0MDTSMI3atsws8as2365FZs/KKakeZ2TX9o8E6SNyjVXE80a
	 ykTdp8p+UyRaMN5fln0r4yUUp1jgEJJoVY8m9I4e1bRKKZiunBzhGZxU0+nkXMo0gF
	 mAseJowvy2Wcqf5v+fgvIfkyUQw/6FE55zbgbf5Y=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20250220143523epcas5p3bb6ec74b8ad18bb13630996b2e253dfa~l8Ug2vrXr2143721437epcas5p3O;
	Thu, 20 Feb 2025 14:35:23 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.183]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4YzG555QHjz4x9Pw; Thu, 20 Feb
	2025 14:35:21 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	4D.96.19956.8AD37B76; Thu, 20 Feb 2025 23:35:20 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250220142739epcas5p1e4e5ca7ad73427895066fe7c6dd482c8~l8Nw23MfQ2084820848epcas5p1O;
	Thu, 20 Feb 2025 14:27:39 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250220142739epsmtrp19acbbc2e34b7e033997da2a6e15a9ff6~l8Nw19uhJ0482304823epsmtrp1h;
	Thu, 20 Feb 2025 14:27:39 +0000 (GMT)
X-AuditID: b6c32a4b-fe9f470000004df4-2b-67b73da8ecbd
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	F1.1F.23488.BDB37B76; Thu, 20 Feb 2025 23:27:39 +0900 (KST)
Received: from green245 (unknown [107.99.41.245]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20250220142737epsmtip160482affd8bb9c17e47b71a842262cbe~l8NvKEaAR1303113031epsmtip1K;
	Thu, 20 Feb 2025 14:27:37 +0000 (GMT)
Date: Thu, 20 Feb 2025 19:49:22 +0530
From: Kundan Kumar <kundan.kumar@samsung.com>
To: Dave Chinner <david@fromorbit.com>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
	lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
	anuj20.g@samsung.com, mcgrof@kernel.org, joshi.k@samsung.com,
	axboe@kernel.dk, clm@meta.com, willy@infradead.org, gost.dev@samsung.com
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Parallelizing filesystem writeback
Message-ID: <20250220141824.ju5va75s3xp472cd@green245>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Z6qkLjSj1K047yPt@dread.disaster.area>
User-Agent: NeoMutt/20171215
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMJsWRmVeSWpSXmKPExsWy7bCmhu4K2+3pBq0rrSyaJvxltlh9t5/N
	Yssle4stx+4xWtw8sJPJYuXqo0wWs6c3M1kc/f+WzWLP3pMsFvte72W2uDHhKaPF7x9z2Bx4
	PE4tkvDYvELL4/LZUo9NqzrZPCbfWM7osftmA5vHuYsVHn1bVjF6nFlwhN3j8ya5AK6obJuM
	1MSU1CKF1Lzk/JTMvHRbJe/geOd4UzMDQ11DSwtzJYW8xNxUWyUXnwBdt8wcoJuVFMoSc0qB
	QgGJxcVK+nY2RfmlJakKGfnFJbZKqQUpOQUmBXrFibnFpXnpenmpJVaGBgZGpkCFCdkZp28Y
	F1wSqth26QZbA+Nj/i5GTg4JAROJniubWboYuTiEBHYzSiz8N4cdwvnEKPF7/iYo5xujxLTt
	V4HKOMBaltzih4jvZZRYe+k4C8goIYFnjBI3m6tBbBYBVYkns66zgtSzCehK/GgKBQmLCKhJ
	TJq0gxmkl1mgm0ni+vdPbCAJYQFviYbXm1lBbF4BM4nWme9YIGxBiZMzn4DZnALGEr3TfoDZ
	ogIyEjOWfgUbJCFwhUPiwd6tLBD/uEi0TD7BCmELS7w6voUdwpaSeNnfBmVnSxxq3MAEYZdI
	7DzSABW3l2g91c8MYjMLZEh8WT0Xao6sxNRT65gg4nwSvb+fQPXySuyYB2OrScx5NxXqBhmJ
	hZdmQMU9JC6sOMUMCa15zBKfGpezTGCUn4XkuVlI9kHYVhKdH5qgbHmJ5q2zmWcBA5JZQFpi
	+T8OCFNTYv0u/QWMbKsYJVMLinPTU4tNC4zzUsvhcZ+cn7uJEZy6tbx3MD568EHvECMTB+Mh
	RgkOZiUR3rb6LelCvCmJlVWpRfnxRaU5qcWHGE2BETeRWUo0OR+YPfJK4g1NLA1MzMzMTCyN
	zQyVxHmbd7akCwmkJ5akZqemFqQWwfQxcXBKNTAt/5d7c43WEoX/OZ9n3mp93Fcpdeh50r0G
	twTvisgTH1qt1ksZdgdbP+phuKvXMfPcUo4tvJyOiukfTy1fuuCTeHv9zuWzKj34zhfLrPO8
	xv1r5t+41kefprXW/XHNeSN49P8U9h/hS2ZyTO64pRC7smDGvLkzo38ohoep2vEGnTcQVqnr
	u7ouUifO5465+UYFz10mNc89He0exk/nvyR1tiGlf/oHtS8T9rZvZXpob6ARtCrigNjNzPnd
	k+I4BcX3CczWW9sfJfT9o80jBucWruw1C1/K5sh98niw4WEox3J2Uf1N+z/Zq/8VZFl6TWQl
	86oJa06Vr/rpaFC0Mvi1hJ3cxy05fU86199Ru71ciaU4I9FQi7moOBEAxCFwtWYEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEIsWRmVeSWpSXmKPExsWy7bCSnO5t6+3pBq0H5S2aJvxltlh9t5/N
	Yssle4stx+4xWtw8sJPJYuXqo0wWs6c3M1kc/f+WzWLP3pMsFvte72W2uDHhKaPF7x9z2Bx4
	PE4tkvDYvELL4/LZUo9NqzrZPCbfWM7osftmA5vHuYsVHn1bVjF6nFlwhN3j8ya5AK4oLpuU
	1JzMstQifbsErox/q7pYCx7zV+xZPp2lgXEibxcjB4eEgInEklv8XYxcHEICuxklJvX8Z+pi
	5ASKy0jsvruTFcIWllj57zk7RNETRonTLY8YQRIsAqoST2ZdZwUZxCagK/GjKRQkLCKgJjFp
	0g5mkHpmgV4mie/Pe9hBEsIC3hINrzeDDeUVMJNonfmOBWLoAmaJrs45zBAJQYmTM5+wgNjM
	QEXzNj9kBlnALCAtsfwfB0RYXqJ562ywck4BY4neaT/AykWBjp6x9CvzBEahWUgmzUIyaRbC
	pFlIJi1gZFnFKJlaUJybnptsWGCYl1quV5yYW1yal66XnJ+7iREcjVoaOxjffWvSP8TIxMF4
	iFGCg1lJhLetfku6EG9KYmVValF+fFFpTmrxIUZpDhYlcd6VhhHpQgLpiSWp2ampBalFMFkm
	Dk6pBqb8RzvWGq+vTJFKD2NvWSQzpTzOy65FdnuqdxBTClvshVkfLk8W4my+s3bNtrWx51/b
	iFxlnZkmHt8ewGTxIGK6UmHDVJOejUx7H/OH7mW5sWGx099T4l51O7cplhqKO2q3bDCLY0lb
	XLNLZflWjrulfWuFTp94u8xb2ENCWV5+7xGms30Nk6daXXxz/Ue7kNn7Lx26Sq83JfNu3fTM
	YTOX/QezuTkuvtujbz6fIdj/V3iVXarLU53XinKfSvrOSf3251TVv1TPlDuz1V9l0na+FD6B
	LLO+kpIJs87+EzWuvrx90faFXvc15j8osP1wbv7sI3t0o1dc3FXweJug5+ep1vuYJj/e4/Y5
	t++64T4lluKMREMt5qLiRAARtGb6NQMAAA==
X-CMS-MailID: 20250220142739epcas5p1e4e5ca7ad73427895066fe7c6dd482c8
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----1GV8lHLOSK0gSELhPVmHEZDOy31rvEewj8HEPrsGasX24HjT=_6fd76_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250129103448epcas5p1f7d71506e4443429a0b0002eb842e749
References: <CGME20250129103448epcas5p1f7d71506e4443429a0b0002eb842e749@epcas5p1.samsung.com>
	<20250129102627.161448-1-kundan.kumar@samsung.com>
	<Z5qw_1BOqiFum5Dn@dread.disaster.area>
	<20250131093209.6luwm4ny5kj34jqc@green245>
	<Z6GAYFN3foyBlUxK@dread.disaster.area> <20250204050642.GF28103@lst.de>
	<s43qlmnbtjbpc5vn75gokti3au7qhvgx6qj7qrecmkd2dgrdfv@no2i7qifnvvk>
	<Z6qkLjSj1K047yPt@dread.disaster.area>

------1GV8lHLOSK0gSELhPVmHEZDOy31rvEewj8HEPrsGasX24HjT=_6fd76_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

>Well, that's currently selected by __inode_attach_wb() based on
>whether there is a memcg attached to the folio/task being dirtied or
>not. If there isn't a cgroup based writeback task, then it uses the
>bdi->wb as the wb context.

We have created a proof of concept for per-AG context-based writeback, as
described in [1]. The AG is mapped to a writeback context (wb_ctx). Using
the filesystem handler, __mark_inode_dirty() selects writeback context
corresponding to the inode.

We attempted to handle memcg and bdi based writeback in a similar manner.
This approach aims to maintain the original writeback semantics while
providing parallelism. This helps in pushing more data early to the
device, trying to ease the write pressure faster.
[1] https://lore.kernel.org/all/20250212103634.448437-1-kundan.kumar@samsung.com/

>Then selecting inodes for writeback becomes a list_lru_walk()
>variant depending on what needs to be written back (e.g. physical
>node, memcg, both, everything that is dirty everywhere, etc).

We considered using list_lru to track inodes within a writeback context.
This can be implemented as:
struct bdi_writeback {
  struct list_lru b_dirty_inodes_lru; // instead of a single b_dirty list
  struct list_lru b_io_dirty_inodes_lru;
  ...
  ...
 };
By doing this, we would obtain a sharded list of inodes per NUMA node.
However, we would also need per-NUMA writeback contexts. Otherwise,
even if inodes are NUMA-sharded, a single writeback context would stil
process them sequentially, limiting parallelism. But there’s a concern:
NUMA-based writeback contexts are not aligned with filesystem geometry,
which could negatively impact delayed allocation and writeback efficiency,
as you pointed out in your previous reply [2].

Would it be better to let the filesystem dictate the number of writeback
threads, rather than enforcing a per-NUMA model?

Do you see it differently?

[2] https://lore.kernel.org/all/Z5qw_1BOqiFum5Dn@dread.disaster.area/


------1GV8lHLOSK0gSELhPVmHEZDOy31rvEewj8HEPrsGasX24HjT=_6fd76_
Content-Type: text/plain; charset="utf-8"


------1GV8lHLOSK0gSELhPVmHEZDOy31rvEewj8HEPrsGasX24HjT=_6fd76_--

