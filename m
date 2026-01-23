Return-Path: <linux-fsdevel+bounces-75286-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qEFYDi13c2kEwAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75286-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 14:27:09 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A517A763C7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 14:27:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA11130210F9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 13:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8396C311C10;
	Fri, 23 Jan 2026 13:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yt81YjJc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E0A3101B1
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Jan 2026 13:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769174818; cv=none; b=cQ7tEuoXfzVMFREAnDBQyidV0k6oILjQOcX32eg/x1TAOdqbZnpKrsRinkTMswyl5to5auy8h+c0unUC7cqvIkNJ/Tx8byrAPoyFF9x13Wz/cOgz7LTqvjyP46L4xvHk4aNnvrOTfq5SeT/+/NX0txwqy76q4A3XTKJR0NLsuNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769174818; c=relaxed/simple;
	bh=ERk6xrizMP9L2T84twdliv7uyYZrdKjWluW+6FiATPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iUCvT6UdMV15hZ5yZfwLknBg2x4aWilJZe3iMUie+mt/q0OGL4I9IqfIQWNMW9GJxSyMPvpS/QnwEtRBlW8W/1JSHzekOmMW0BGKA+svmK0jsfNK6P4EcvX0GPqHO8rYha76w4Lj26TbGcOoYBybs5OACFYpqu5gcZX7kyHbhKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yt81YjJc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769174814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HoRBTfV4VyA/DV78xxIgYB6gXw6o5kSGqGJb4RS28XE=;
	b=Yt81YjJcPf/HzXtgw00LRaCn/CYn84JZo5n0VCWDTo0cn3qkBqnBElLJps/bdDWyJJd+Lt
	xa9gyijIFfoHuVjxfjGaj5t3nUIPDgu1XK0/tEdzsthwoZxGA0dzdoFnyHZH5AmJSDyznv
	vUeWU0YghZRZDmqviJeifKViYiEWfWI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-36-IhTs_L3LP-aqA_2xWCvr_w-1; Fri,
 23 Jan 2026 08:26:52 -0500
X-MC-Unique: IhTs_L3LP-aqA_2xWCvr_w-1
X-Mimecast-MFC-AGG-ID: IhTs_L3LP-aqA_2xWCvr_w_1769174809
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 94C2F1955D80;
	Fri, 23 Jan 2026 13:26:48 +0000 (UTC)
Received: from bfoster (unknown [10.22.64.128])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 59D1F1958DC1;
	Fri, 23 Jan 2026 13:26:44 +0000 (UTC)
Date: Fri, 23 Jan 2026 08:26:42 -0500
From: Brian Foster <bfoster@redhat.com>
To: Kundan Kumar <kundan.kumar@samsung.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	willy@infradead.org, mcgrof@kernel.org, clm@meta.com,
	david@fromorbit.com, amir73il@gmail.com, axboe@kernel.dk,
	hch@lst.de, ritesh.list@gmail.com, djwong@kernel.org,
	dave@stgolabs.net, cem@kernel.org, wangyufei@vivo.com,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-xfs@vger.kernel.org, gost.dev@samsung.com,
	anuj20.g@samsung.com, vishak.g@samsung.com, joshi.k@samsung.com
Subject: Re: [PATCH v3 0/6] AG aware parallel writeback for XFS
Message-ID: <aXN3EtxKFXX8DEbl@bfoster>
References: <CGME20260116101236epcas5p12ba3de776976f4ea6666e16a33ab6ec4@epcas5p1.samsung.com>
 <20260116100818.7576-1-kundan.kumar@samsung.com>
 <aXEvAD5Rf5QLp4Ma@bfoster>
 <ca048ecf-5aec-4a0d-8faf-ad9fcd310e21@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ca048ecf-5aec-4a0d-8faf-ad9fcd310e21@samsung.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75286-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,infradead.org,meta.com,fromorbit.com,gmail.com,kernel.dk,lst.de,stgolabs.net,vivo.com,vger.kernel.org,kvack.org,samsung.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bfoster@redhat.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A517A763C7
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 09:45:05PM +0530, Kundan Kumar wrote:
> > 
> > Could you provide more detail on how you're testing here? I threw this
> > at some beefier storage I have around out of curiosity and I'm not
> > seeing much of a difference. It could be I'm missing some details or
> > maybe the storage outweighs the processing benefit. But for example, is
> > this a fio test command being used? Is there preallocation? What type of
> > storage? Is a particular fs geometry being targeted for this
> > optimization (i.e. smaller AGs), etc.?
> 
> Thanks Brian for the detailed review and for taking the time to
> look through the code.
> 
> The numbers quoted were from fio buffered write workloads on NVMe
> (Optane devices), using multiple files placed in different
> directories mapping to different AGs. Jobs were buffered
> randwrite with multiple jobs. This can be tested with both
> fallocate=none or otherwise.
> 
> Sample script for 12 jobs to 12 directories(AGs) :
> 
> mkfs.xfs -f -d agcount=12 /dev/nvme0n1
> mount /dev/nvme0n1 /mnt
> sync
> echo 3 > /proc/sys/vm/drop_caches
> 
> for i in {1..12}; do
>    mkdir -p /mnt/dir$i
> done
> 
> fio job.fio
> 
> umount /mnt
> echo 3 > /proc/sys/vm/drop_caches
> 
> The job file :
> 
> [global]
> bs=4k
> iodepth=32
> rw=randwrite
> ioengine=io_uring
> fallocate=none
> nrfiles=12
> numjobs=1
> size=6G
> direct=0
> group_reporting=1
> create_on_open=1
> name=test
> 
> [job1]
> directory=/mnt/dir1
> 
> [job2]
> directory=/mnt/dir2
> ...
> ...
> [job12]
> directory=/mnt/dir12
> 

Thanks..

> > 
> > FWIW, I skimmed through the code a bit and the main thing that kind of
> > stands out to me is the write time per-folio hinting. Writeback handling
> > for the overwrite (i.e. non-delalloc) case is basically a single lookup
> > per mapping under shared inode lock. The question that comes to mind
> > there is what is the value of per-ag batching as opposed to just adding
> > generic concurrency? It seems unnecessary to me to take care to shuffle
> > overwrites into per-ag based workers when the underlying locking is
> > already shared.
> > 
> 
> That’s a fair point. For the overwrite (non-delalloc) case, the
> per-folio AG hinting is not meant to change allocation behavior, and
> I agree the underlying inode locking remains shared. The primary value
> I’m seeing there is the ability to partition writeback iteration and
> submission when dirty data spans multiple AGs.
> I will try routing overwrite writeback to workers irrespective of AG
> (e.g. hash/inode based), to compare between generic concurrency vs AG
> batching.
> 
> > WRT delalloc, it looks like we're basically taking the inode AG as the
> > starting point and guessing based on the on-disk AGF free blocks counter
> > at the time of the write. The delalloc accounting doesn't count against
> > the AGF, however, so ISTM that in many cases this would just effectively
> > land on the inode AG for larger delalloc writes. Is that not the case?
> > 
> > Once we get to delalloc writeback, we're under exclusive inode lock and
> > fall into the block allocator. The latter trylock iterates the AGs
> > looking for a good candidate. So what's the advantage of per-ag
> > splitting delalloc at writeback time if we're sending the same inode to
> > per-ag workers that all 1. require exclusive inode lock and 2. call into
> > an allocator that is designed to be scalable (i.e. if one AG is locked
> > it will just move to the next)?
> > 
> 
> The intent of per-AG splitting is not to parallelize allocation
> within a single inode or override allocator behavior, but to
> partition writeback scheduling so that inodes associated with
> different AGs are routed to different workers. This implicitly
> distributes inodes across AG workers, even though each inode’s
> delalloc conversion remains serialized.
> 
> > Yet another consideration is how delalloc conversion works at the
> > xfs_bmapi_convert_delalloc() -> xfs_bmapi_convert_one_delalloc() level.
> > If you take a look at the latter, we look up the entire delalloc extent
> > backing the folio under writeback and attempt to allocate it all at once
> > (not just the blocks backing the folio). So in theory if we were to end
> > up tagging a sequence of contiguous delalloc backed folios at buffered
> > write time with different AGs, we're still going to try to allocate all
> > of that in one AG at writeback time. So the per-ag hinting also sort of
> > competes with this by shuffling writeback of the same potential extent
> > into different workers, making it a little hard to try and reason about.
> > 
> 
> Agreed — delalloc conversion happens at extent granularity, so
> per-folio AG hints are not meant to steer final allocation. In this
> series the hints are used purely as writeback scheduling tokens;
> allocation still occurs once per extent under XFS_ILOCK_EXCL using
> existing allocator logic. The goal is to partition writeback work and
> avoid funneling multiple inodes through a single writeback path, not
> to influence extent placement.
> 

Yeah.. I realize none of this is really intended to drive allocation
behavior. The observation that all this per-folio tracking ultimately
boils down to either sharding based on information we have at writeback
time (i.e. overwrites) or effectively batching based on on-disk AG state
at the time of the write is kind of what suggests that the folio
granular hinting is potentially overkill.

> > So stepping back it kind of feels to me like the write time hinting has
> > so much potential for inaccuracy and unpredictability of writeback time
> > behavior (for the delalloc case), that it makes me wonder if we're
> > effectively just enabling arbitrary concurrency at writeback time and
> > perhaps seeing benefit from that. If so, that makes me wonder if the
> > associated value can be gained by somehow simplifying this to not
> > require write time hinting at all.
> > 
> > Have you run any experiments that perhaps rotors inodes to the
> > individual wb workers based on the inode AG (i.e. basically ignoring all
> > the write time stuff) by chance? Or anything that otherwise helps
> > quantify the value of per-ag batching over just basic concurrency? I'd
> > be interested to see if/how behavior changes with something like that.
> 
> Yes, inode-AG based routing has been explored as part of earlier
> higher-level writeback work (link below), where inodes are affined to
> writeback contexts based on inode AG. That effectively provides
> generic concurrency and serves as a useful baseline.
> https://lore.kernel.org/all/20251014120845.2361-1-kundan.kumar@samsung.com/
> 

Ah, I recall seeing that. A couple questions..

That link states the following:

"For XFS, affining inodes to writeback threads resulted in a decline
in IOPS for certain devices. The issue was caused by AG lock contention
in xfs_end_io, where multiple writeback threads competed for the same
AG lock."

Can you quantify that? It seems like xfs_end_io() mostly cares about
things like unwritten conversion, COW remapping, etc., so block
allocation shouldn't be prominent. Is this producing something where
frequent unwritten conversion results in a lot of bmapbt splits or
something?

Also, how safe is it is to break off writeback tasks at the XFS layer
like this? For example, is it safe to spread around the wbc to a bunch
of tasks like this? What about serialization for things like bandwidth
accounting and whatnot in the core/calling code?  Should the code that
splits off wq tasks in XFS be responsible to wait for parallel
submission completion before returning (I didn't see anything doing that
on a scan, but could have missed it)..?

> The motivation for this series is the complementary case where a
> single inode’s dirty data spans multiple AGs on aged/fragmented
> filesystems, where inode-AG affinity breaks down. The folio-level AG
> hinting here is intended to explore whether finer-grained partitioning
> provides additional benefit beyond inode-based routing.
> 

But also I'm not sure I follow the high level goal here. I have the same
question as Pankaj in that regard.. is this series intended to replace
the previous bdi level approach, or go along with it somehow? Doing
something at the bdi level seems like a more natural approach in
general, so I'm curious why the change in direction.

Brian


