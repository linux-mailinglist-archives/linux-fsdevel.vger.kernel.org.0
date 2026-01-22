Return-Path: <linux-fsdevel+bounces-75104-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GIn1MedZcmkpiwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75104-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 18:09:59 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 50FBE6ADB7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 18:09:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B0463006B53
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 16:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B003DEDDA;
	Thu, 22 Jan 2026 16:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="q1HlIrWN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8423E10A9
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jan 2026 16:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769098526; cv=none; b=rYzzBzavIDeCa7GnVai9ymuPDNVhncC7X8Vc8JXAEmLHvr8BpoYX34DeZvs6rrRGblODL9zljGXmR1VC2p6LrKjhprYXbOxp1uyQ3z7KQ7soyHTrdo4JtQXnRA4j93PsJ9tvSuNIayUGGCkup88miZJ3wKZi4D1jkUlk5pn0/M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769098526; c=relaxed/simple;
	bh=GKqPPT1msj5aAzjfbXldBG3vJfA7dAUWRD1h/TRG8x4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=ZYWBrmLR6Ok0nIKYEwMSs7MdaC0llovgX3qXP/0E5NOUuL1HgYJ4Lboba/wdBLHgkW/yHMg6QSKS6sEMOwHh+7dR/4RrNmFB+qJtKK7O3y1lrhV8uDoQDh9CpIqbRe/PKMIMyncvlcj79RNFljYNZ6MFkKtI4UrLrs9qrsmzJRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=q1HlIrWN; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20260122161515epoutp03fe96981813a17fbdf5233a0e83fa6e66~NGboMLtG01422614226epoutp03A
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jan 2026 16:15:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20260122161515epoutp03fe96981813a17fbdf5233a0e83fa6e66~NGboMLtG01422614226epoutp03A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1769098515;
	bh=Ut0PvNTFkBDARJX4qSO9056XGy5KdZ5rJS/cjW/7pRk=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=q1HlIrWNyqXlXJ8s7fdr+6FILnBgREtqtbL6tKRVnDJQDqNFP2+0kWYEsWdCFbTpY
	 +Q/VOdgW4Pmp1Z0/7nsG/3bIUEvgFb8cmslFKPWLb5SKPakzqL1B2ApoYpixV7P4E1
	 1lh6S8ZF86UVTN01KMmAKMW8lo42qiOHn4lGHGTE=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20260122161514epcas5p2ece65e143be4209661a3f0354ecff169~NGbnfPXfZ2058720587epcas5p2o;
	Thu, 22 Jan 2026 16:15:14 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.86]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4dxmPF5YJ7z2SSKY; Thu, 22 Jan
	2026 16:15:13 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20260122161513epcas5p2f245aaca490aadd994074f3fd52031e2~NGbmJDHS62060020600epcas5p2d;
	Thu, 22 Jan 2026 16:15:13 +0000 (GMT)
Received: from [107.111.86.57] (unknown [107.111.86.57]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260122161506epsmtip1e1a44b279ac7ac7ad390e8ab6dcb5c97~NGbgAiEqi0033200332epsmtip1T;
	Thu, 22 Jan 2026 16:15:06 +0000 (GMT)
Message-ID: <ca048ecf-5aec-4a0d-8faf-ad9fcd310e21@samsung.com>
Date: Thu, 22 Jan 2026 21:45:05 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] AG aware parallel writeback for XFS
Content-Language: en-US
To: Brian Foster <bfoster@redhat.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	willy@infradead.org, mcgrof@kernel.org, clm@meta.com, david@fromorbit.com,
	amir73il@gmail.com, axboe@kernel.dk, hch@lst.de, ritesh.list@gmail.com,
	djwong@kernel.org, dave@stgolabs.net, cem@kernel.org, wangyufei@vivo.com,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-xfs@vger.kernel.org, gost.dev@samsung.com, anuj20.g@samsung.com,
	vishak.g@samsung.com, joshi.k@samsung.com
From: Kundan Kumar <kundan.kumar@samsung.com>
In-Reply-To: <aXEvAD5Rf5QLp4Ma@bfoster>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260122161513epcas5p2f245aaca490aadd994074f3fd52031e2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260116101236epcas5p12ba3de776976f4ea6666e16a33ab6ec4
References: <CGME20260116101236epcas5p12ba3de776976f4ea6666e16a33ab6ec4@epcas5p1.samsung.com>
	<20260116100818.7576-1-kundan.kumar@samsung.com> <aXEvAD5Rf5QLp4Ma@bfoster>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[samsung.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[samsung.com:s=mail20170921];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[23];
	TAGGED_FROM(0.00)[bounces-75104-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,infradead.org,meta.com,fromorbit.com,gmail.com,kernel.dk,lst.de,stgolabs.net,vivo.com,vger.kernel.org,kvack.org,samsung.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,samsung.com:mid,samsung.com:dkim];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kundan.kumar@samsung.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[samsung.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 50FBE6ADB7
X-Rspamd-Action: no action

> 
> Could you provide more detail on how you're testing here? I threw this
> at some beefier storage I have around out of curiosity and I'm not
> seeing much of a difference. It could be I'm missing some details or
> maybe the storage outweighs the processing benefit. But for example, is
> this a fio test command being used? Is there preallocation? What type of
> storage? Is a particular fs geometry being targeted for this
> optimization (i.e. smaller AGs), etc.?

Thanks Brian for the detailed review and for taking the time to
look through the code.

The numbers quoted were from fio buffered write workloads on NVMe
(Optane devices), using multiple files placed in different
directories mapping to different AGs. Jobs were buffered
randwrite with multiple jobs. This can be tested with both
fallocate=none or otherwise.

Sample script for 12 jobs to 12 directories(AGs) :

mkfs.xfs -f -d agcount=12 /dev/nvme0n1
mount /dev/nvme0n1 /mnt
sync
echo 3 > /proc/sys/vm/drop_caches

for i in {1..12}; do
   mkdir -p /mnt/dir$i
done

fio job.fio

umount /mnt
echo 3 > /proc/sys/vm/drop_caches

The job file :

[global]
bs=4k
iodepth=32
rw=randwrite
ioengine=io_uring
fallocate=none
nrfiles=12
numjobs=1
size=6G
direct=0
group_reporting=1
create_on_open=1
name=test

[job1]
directory=/mnt/dir1

[job2]
directory=/mnt/dir2
...
...
[job12]
directory=/mnt/dir12

> 
> FWIW, I skimmed through the code a bit and the main thing that kind of
> stands out to me is the write time per-folio hinting. Writeback handling
> for the overwrite (i.e. non-delalloc) case is basically a single lookup
> per mapping under shared inode lock. The question that comes to mind
> there is what is the value of per-ag batching as opposed to just adding
> generic concurrency? It seems unnecessary to me to take care to shuffle
> overwrites into per-ag based workers when the underlying locking is
> already shared.
> 

That’s a fair point. For the overwrite (non-delalloc) case, the
per-folio AG hinting is not meant to change allocation behavior, and
I agree the underlying inode locking remains shared. The primary value
I’m seeing there is the ability to partition writeback iteration and
submission when dirty data spans multiple AGs.
I will try routing overwrite writeback to workers irrespective of AG
(e.g. hash/inode based), to compare between generic concurrency vs AG
batching.

> WRT delalloc, it looks like we're basically taking the inode AG as the
> starting point and guessing based on the on-disk AGF free blocks counter
> at the time of the write. The delalloc accounting doesn't count against
> the AGF, however, so ISTM that in many cases this would just effectively
> land on the inode AG for larger delalloc writes. Is that not the case?
> 
> Once we get to delalloc writeback, we're under exclusive inode lock and
> fall into the block allocator. The latter trylock iterates the AGs
> looking for a good candidate. So what's the advantage of per-ag
> splitting delalloc at writeback time if we're sending the same inode to
> per-ag workers that all 1. require exclusive inode lock and 2. call into
> an allocator that is designed to be scalable (i.e. if one AG is locked
> it will just move to the next)?
> 

The intent of per-AG splitting is not to parallelize allocation
within a single inode or override allocator behavior, but to
partition writeback scheduling so that inodes associated with
different AGs are routed to different workers. This implicitly
distributes inodes across AG workers, even though each inode’s
delalloc conversion remains serialized.

> Yet another consideration is how delalloc conversion works at the
> xfs_bmapi_convert_delalloc() -> xfs_bmapi_convert_one_delalloc() level.
> If you take a look at the latter, we look up the entire delalloc extent
> backing the folio under writeback and attempt to allocate it all at once
> (not just the blocks backing the folio). So in theory if we were to end
> up tagging a sequence of contiguous delalloc backed folios at buffered
> write time with different AGs, we're still going to try to allocate all
> of that in one AG at writeback time. So the per-ag hinting also sort of
> competes with this by shuffling writeback of the same potential extent
> into different workers, making it a little hard to try and reason about.
> 

Agreed — delalloc conversion happens at extent granularity, so
per-folio AG hints are not meant to steer final allocation. In this
series the hints are used purely as writeback scheduling tokens;
allocation still occurs once per extent under XFS_ILOCK_EXCL using
existing allocator logic. The goal is to partition writeback work and
avoid funneling multiple inodes through a single writeback path, not
to influence extent placement.

> So stepping back it kind of feels to me like the write time hinting has
> so much potential for inaccuracy and unpredictability of writeback time
> behavior (for the delalloc case), that it makes me wonder if we're
> effectively just enabling arbitrary concurrency at writeback time and
> perhaps seeing benefit from that. If so, that makes me wonder if the
> associated value can be gained by somehow simplifying this to not
> require write time hinting at all.
> 
> Have you run any experiments that perhaps rotors inodes to the
> individual wb workers based on the inode AG (i.e. basically ignoring all
> the write time stuff) by chance? Or anything that otherwise helps
> quantify the value of per-ag batching over just basic concurrency? I'd
> be interested to see if/how behavior changes with something like that.

Yes, inode-AG based routing has been explored as part of earlier
higher-level writeback work (link below), where inodes are affined to
writeback contexts based on inode AG. That effectively provides
generic concurrency and serves as a useful baseline.
https://lore.kernel.org/all/20251014120845.2361-1-kundan.kumar@samsung.com/

The motivation for this series is the complementary case where a
single inode’s dirty data spans multiple AGs on aged/fragmented
filesystems, where inode-AG affinity breaks down. The folio-level AG
hinting here is intended to explore whether finer-grained partitioning
provides additional benefit beyond inode-based routing.


