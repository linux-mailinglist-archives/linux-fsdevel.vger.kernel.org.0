Return-Path: <linux-fsdevel+bounces-44260-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F7AA66B60
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 08:16:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F407189BA9D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 07:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF0E1DDA3B;
	Tue, 18 Mar 2025 07:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="rsOFMtvW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41461991CA
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Mar 2025 07:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742282192; cv=none; b=Gew4QC+xYE+NzBQhPJki1QTPnGBM8l6xoAZToH+iGW4W9pXgS5o1PEBlchGB5CEQX8lXq4u2Jqb5hXAfamswRbG+8U3WWdQbJR2WqNG4Kb5828r97VQr3lyqapBecftxwcNyXcSbJN6NuYo1suSa/0H4XFZU5nQ1SNmna96Z3l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742282192; c=relaxed/simple;
	bh=qF2N/NsSW/vYxFq63A0suX8KbUBT2qWBUMLcITpblhM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=FWz7EblRvwSiOKulIWIalprigZdGj6T9il5VF5gfmTNuxSyvwxoVgDXaFzXAfm9WkjvMxcXaVpkyXTUncTgZAaDjz008X7+ea9KlR+KY35rNR5LdXfSiHGWiXdOBOz5J+ZUaa6ij8TqGataPglkwmUzaK5Oai/0u38pykh53NTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=rsOFMtvW; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250318071622epoutp02a6b0c575032ea39eb4a9162cf48f78f5~t1GnjW4562773027730epoutp02e
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Mar 2025 07:16:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250318071622epoutp02a6b0c575032ea39eb4a9162cf48f78f5~t1GnjW4562773027730epoutp02e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1742282182;
	bh=P+U8KeQVZedOlNTir0zIlGTTT6DDID6YQsAP2yc78Zc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rsOFMtvWttUxTGZPsFcw0ZYBy+r8egZLuvgjj9mq508/EGQiurQMEfTD3BvLzcpVU
	 SFrZqD17Yw44cDtg4aug6DJe1q7twb6XZ/9ie6pBBSE/CuIwIwpeF8+vgPF+SqowHy
	 fG7aNf+GEQIm80oOyOvIgIi3UgMrB6RvFJG6X8mE=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20250318071621epcas5p47578fc4507c81dbdd2173917e0796a03~t1Gm3int82682526825epcas5p4L;
	Tue, 18 Mar 2025 07:16:21 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.182]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4ZH36W3RP1z4x9QY; Tue, 18 Mar
	2025 07:16:19 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	81.27.19710.3CD19D76; Tue, 18 Mar 2025 16:16:19 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250318064955epcas5p17f56990ac27b59e721a1a15272349cee~t0viGE63u1466714667epcas5p1i;
	Tue, 18 Mar 2025 06:49:55 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250318064955epsmtrp29a06e80d74bde32c453637caf087ba77~t0viFUwYv1914319143epsmtrp2Z;
	Tue, 18 Mar 2025 06:49:55 +0000 (GMT)
X-AuditID: b6c32a44-363dc70000004cfe-30-67d91dc39c45
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	20.52.18949.39719D76; Tue, 18 Mar 2025 15:49:55 +0900 (KST)
Received: from green245 (unknown [107.99.41.245]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20250318064953epsmtip17c609251fde611117f81c4829903b14a~t0vgTqmv62367223672epsmtip1V;
	Tue, 18 Mar 2025 06:49:53 +0000 (GMT)
Date: Tue, 18 Mar 2025 12:11:34 +0530
From: Kundan Kumar <kundan.kumar@samsung.com>
To: Jan Kara <jack@suse.cz>
Cc: Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>,
	lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
	anuj20.g@samsung.com, mcgrof@kernel.org, joshi.k@samsung.com,
	axboe@kernel.dk, clm@meta.com, willy@infradead.org, gost.dev@samsung.com
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Parallelizing filesystem writeback
Message-ID: <20250318064134.xzjx2bviq2x4db52@green245>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <qdgoyhi5qjnlfk6zmlizp2lcrmg43rwmy3tl4yz6zkgavgfav5@nsfculj7aoxe>
User-Agent: NeoMutt/20171215
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJJsWRmVeSWpSXmKPExsWy7bCmlu5h2ZvpBmsWils0TfjLbLH6bj+b
	xZZL9hZbjt1jtLh5YCeTxcrVR5ksZk9vZrI4+v8tm8WevSdZLPa93stscWPCU0aL3z/msDnw
	eJxaJOGxeYWWx+WzpR6bVnWyeUy+sZzRY/fNBjaPcxcrPPq2rGL0OLPgCLvH501yAVxR2TYZ
	qYkpqUUKqXnJ+SmZeem2St7B8c7xpmYGhrqGlhbmSgp5ibmptkouPgG6bpk5QDcrKZQl5pQC
	hQISi4uV9O1sivJLS1IVMvKLS2yVUgtScgpMCvSKE3OLS/PS9fJSS6wMDQyMTIEKE7Iz9u9o
	ZSv4JVmxr2UFWwPjctEuRk4OCQETicXtM1m6GLk4hAR2M0pcX9zNBOF8YpTYdnM2VOYbo8SM
	53eBHA6wll9vwyDiexkldh5uZYNwnjFKXFjXwwIyl0VAVWJry2t2kAY2AV2JH02hIGERAWmJ
	WcdWgg1lFpjGJPHoYTcbSEJYwFui4fVmVhCbV8BM4vihj1C2oMTJmU/AZnIK+Em8bH4AZosK
	yEjMWPqVGWSQhMARDomll/awQzzkIjH9+ytWCFtY4tXxLVBxKYnP7/ayQdjZEocaNzBB2CUS
	O480QNXYS7Se6mcGsZkFMiSWbD8ENUdWYuqpdUwQcT6J3t9PoHp5JXbMg7HVJOa8m8oCYctI
	LLw0AyruIXFhxSlmSAj1s0iseDiBeQKj/Cwkz81Csg/CtpLo/NAEZHMA2dISy/9xQJiaEut3
	6S9gZF3FKJlaUJybnppsWmCYl1oOj/Hk/NxNjOA0reWyg/HG/H96hxiZOBgPMUpwMCuJ8Lo/
	uZ4uxJuSWFmVWpQfX1Sak1p8iNEUGFkTmaVEk/OBmSKvJN7QxNLAxMzMzMTS2MxQSZy3eWdL
	upBAemJJanZqakFqEUwfEwenVANT2E2pBnmdhxs2qnJv3/btbDPD5jci5yv1t2qd8RWaa3u8
	sft4ssyBp7Pvps2uNmWu1Sk44vZWu++SToDr2Vwhi58L/uXfjNpqUezIlGh9Ysb7LqV9T7Rn
	3KoTe3CnyfqwvuCqP9HVOyZmPdJ4dZKLScprur3bi3ypF0ofq5f3dcVe2eikIh82bfW5W+FT
	g75E5NtJ6Wjnb2PwFN33NHDv1pqsb4t9PRyezTvv9PGz/toHX5Z/+D7H7dCuH+veX59kK/H7
	W/mauQzP92bxy/Gb3v24MpH/56o52xJV/MItH3XaL8zde84tI+vu+kcPp4iK+e1q8z9r/mW/
	fzR/9PP10bMbM3IVmhV5TiQuOrxLXomlOCPRUIu5qDgRAF9VB7lcBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkkeLIzCtJLcpLzFFi42LZdlhJTney+M10g/ZVahZNE/4yW6y+289m
	seWSvcWWY/cYLW4e2MlksXL1USaL2dObmSyO/n/LZrFn70kWi32v9zJb3JjwlNHi9485bA48
	HqcWSXhsXqHlcflsqcemVZ1sHpNvLGf02H2zgc3j3MUKj74tqxg9ziw4wu7xeZNcAFcUl01K
	ak5mWWqRvl0CV8bDJ61MBWvEK3qv7GNtYPws1MXIwSEhYCLx621YFyMXh5DAbkaJbTs6GLsY
	OYHiMhK77+5khbCFJVb+e84OUfSEUWLGvbnsIAkWAVWJrS2v2UEGsQnoSvxoCgUJiwhIS8w6
	tpIFpJ5ZYAaTxMXNa5hBEsIC3hINrzeDDeUVMJM4fugjmC0kMJFFYvYNR4i4oMTJmU9YQGxm
	oJp5mx8yg8xnBhq6/B8HSJhTwE/iZfMDsBJRoDtnLP3KPIFRcBaS7llIumchdC9gZF7FKJla
	UJybnltsWGCUl1quV5yYW1yal66XnJ+7iREcW1paOxj3rPqgd4iRiYPxEKMEB7OSCK/7k+vp
	QrwpiZVVqUX58UWlOanFhxilOViUxHm/ve5NERJITyxJzU5NLUgtgskycXBKNTDt//Tl4pkb
	l6Q27ve45+jpnl5hsODakpQVSUsjNs2IWNMo/lLS4OGu8xOr9JdP3Tg5cVLpW57zFybY3V3x
	Qi7l13H1y66+Z69oO4rYGe22/ij7+3qJbGaa4irF8C21rkX/zzd36sp+2Wj24+ZlzwhBs4z1
	ZoYCS6ynhTLuCf4vGxnef0A8pJ1z+olPJhnHVdX86nw/Pbu7YMmLs6zMd6L3cesvLlWyeryv
	tqn3fuT54HWTUg4+jHmoVtH3wv1RZ+WbnDZ1afX9601v8zJs/MZs0O5Uqy/e+6z82+TO6+lm
	9pZpXeKcR2+vmr5c8kBeuqvcJO1Jcb5zehUm/NpjGl7xtH16+oTD+wz5LHIkFhxQYinOSDTU
	Yi4qTgQATVtVKhwDAAA=
X-CMS-MailID: 20250318064955epcas5p17f56990ac27b59e721a1a15272349cee
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="-----n9Uixv_.-ZhL2v3ig-snSfcYkP.kLEj6PbqjIokIlCsp6vK=_118b4_"
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
	<20250220141824.ju5va75s3xp472cd@green245>
	<qdgoyhi5qjnlfk6zmlizp2lcrmg43rwmy3tl4yz6zkgavgfav5@nsfculj7aoxe>

-------n9Uixv_.-ZhL2v3ig-snSfcYkP.kLEj6PbqjIokIlCsp6vK=_118b4_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

>> > Then selecting inodes for writeback becomes a list_lru_walk()
>> > variant depending on what needs to be written back (e.g. physical
>> > node, memcg, both, everything that is dirty everywhere, etc).
>>
>> We considered using list_lru to track inodes within a writeback context.
>> This can be implemented as:
>> struct bdi_writeback {
>>  struct list_lru b_dirty_inodes_lru; // instead of a single b_dirty list
>>  struct list_lru b_io_dirty_inodes_lru;
>>  ...
>>  ...
>> };
>> By doing this, we would obtain a sharded list of inodes per NUMA node.
>
>I think you've misunderstood Dave's suggestion here. list_lru was given as
>an example of a structure for inspiration. We cannot take it directly as is
>for writeback purposes because we don't want to be sharding based on NUMA
>nodes but rather based on some other (likely FS driven) criteria.

Makes sense. Thanks for the clarification.

>I was thinking about how to best parallelize the writeback and I think
>there are two quite different demands for which we probably want two
>different levels of parallelism.
>
>One case is the situation when the filesystem for example has multiple
>underlying devices (like btrfs or bcachefs) or for other reasons writeback
>to different parts is fairly independent (like for different XFS AGs). Here
>we want parallelism at rather high level I think including separate
>dirty throttling, tracking of writeback bandwidth etc.. It is *almost* like
>separate bdis (struct backing_dev_info) but I think it would be technically
>and also conceptually somewhat easier to do the multiplexing by factoring
>out:
>
>        struct bdi_writeback wb;  /* the root writeback info for this bdi */
>        struct list_head wb_list; /* list of all wbs */
>#ifdef CONFIG_CGROUP_WRITEBACK
>        struct radix_tree_root cgwb_tree; /* radix tree of active cgroup wbs */
>        struct rw_semaphore wb_switch_rwsem; /* no cgwb switch while syncing */
>#endif
>        wait_queue_head_t wb_waitq;
>
>into a new structure (looking for a good name - bdi_writeback_context???)
>that can get multiplied (filesystem can create its own bdi on mount and
>configure there number of bdi_writeback_contexts it wants). We also need to
>add a hook sb->s_ops->get_inode_wb_context() called from __inode_attach_wb()
>which will return appropriate bdi_writeback_context (or perhaps just it's
>index?) for an inode. This will be used by the filesystem to direct
>writeback code where the inode should go. This is kind of what Kundan did
>in the last revision of his patches but I hope this approach should
>somewhat limit the changes necessary to writeback infrastructure - the

This looks much better than the data structures we had in previous
version. I will prepare a new version based on this feedback.

>patch 2 in his series is really unreviewably large...

I agree. Sorry, will try to streamline the patches in a better fashion
in the next iteration.


-------n9Uixv_.-ZhL2v3ig-snSfcYkP.kLEj6PbqjIokIlCsp6vK=_118b4_
Content-Type: text/plain; charset="utf-8"


-------n9Uixv_.-ZhL2v3ig-snSfcYkP.kLEj6PbqjIokIlCsp6vK=_118b4_--

