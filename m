Return-Path: <linux-fsdevel+bounces-77494-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4KLeOb47lWk7NgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77494-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 05:10:38 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A952F152EE5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 05:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1AE79303608B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 04:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4212F363C;
	Wed, 18 Feb 2026 04:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=anarazel.de header.i=@anarazel.de header.b="NyFKBjU9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F442jkCw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB99B2E229F;
	Wed, 18 Feb 2026 04:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771387830; cv=none; b=ruSaSdDEjTvzn5bghQK+NxsYGOzmKouWnV0/trU/GGBM3WI/885rh6/TaMiI2q8xhHjX6DrAWywKsn6STvIdbK5TwMljmhUCIeHA2SIdPDsJ2NN+S/ge0OJZZWGGqS6lnS2kR8zZBqNU2SR886SpHGdINbRttZz4QpwNBs7CvgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771387830; c=relaxed/simple;
	bh=jWoL5T2E1rMM9kwrV5gK8tos/uIg+IUL9xNI39T1/E0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aNpAiI2Zlcl7eDYzKPF0+QyatN1ttsOHBRs69mNidYHkx1O52sN5TAlmQATru+IkSk83EKCAiGtf0Xu1lCUTgfGE7zuPHprDfQgcarsiMiWOnHsX51o3igqe6l4aWV3skA+KLvwnoaL5Aoiyu4vxmQvTguBvnrKWwUj/eqnrcLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anarazel.de; spf=pass smtp.mailfrom=anarazel.de; dkim=pass (2048-bit key) header.d=anarazel.de header.i=@anarazel.de header.b=NyFKBjU9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F442jkCw; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anarazel.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anarazel.de
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id D75BC1D00141;
	Tue, 17 Feb 2026 23:10:25 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 17 Feb 2026 23:10:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1771387825; x=1771474225; bh=MDesmuvOoq
	m7KYIcrl+m4jnd+l0mTOjnNT7rySenVmw=; b=NyFKBjU94uhXFhnzD+chKOJfL3
	yU1YSkNcnof42XOEjsSEpCWAZVkUu+HmranGCIoAcsgVDnUtzaRHjfjQ20naydJ5
	vR7edehRvutjHe5B7641tY4oVgmpNOL+02yyVzYgZC4tTNzYWbt048wWlEvhsuoX
	I01uXwJPPZEe2MsXIhDec/gUFbRmS0Toq8p0v6E2PbFBHdPDQ46V75fDhTSREOJj
	ZEf1yuDq2tpncRzE8DDWoXPXvIpCa0uPPSiEROObySFZykMsKd/xY3Gtu4NDWQP8
	rgqFA0fNzlH3BR5eoeNAR8jvcn9TKRGjWyNqLoxWcbGWvK8c+KW1Djpq99Iw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771387825; x=1771474225; bh=MDesmuvOoqm7KYIcrl+m4jnd+l0mTOjnNT7
	rySenVmw=; b=F442jkCwr4HV0qmZORjuygDkjt04rSy/Efaz7Q8BD1v1NnaVw2L
	7XYqsESZQ54YPbUQuw9OZu4teO/Gnf4MLmUnbJgzEo1C/SRKJc5aEcMbJ+JJpYVY
	GjMpbJquw3OJfFzN6/VILMeBSD6DVJkSSJKbkxu54W7HbkYrQwOYTBgCaGhYC+Zo
	eWXQNqN84Q1oKYRoLE4vXKTNkX9xxdY1vZmOPJ8GmnsZXXiB2KLdXBo3YQUVA6OZ
	W+z0PF4ZY+IdVcZvwkcuF8uLlY8QuUu93CDAbHXKShbGL/DVJdfd7rj6irghdeN7
	ELXlPOquGiniH489rn2yt5RVtOKqGT4rBag==
X-ME-Sender: <xms:sDuVabWuDpIUFyfmsSKYXdkbRMK_Q0wHAHKfW3_-nQPg7TJxoh0XNg>
    <xme:sDuVaT-1ITBl6tXG9k0ueaOFuTkTQoboQ73F-yH40ExN7SHy3GrNik58BWJ3LHUKa
    3iMdIALaFpi_o7l1NVgWn2qOMt2Q4gPYGHgzBmoBrH3jHMpx4_c344>
X-ME-Received: <xmr:sDuVaYjT_v2zR0haW9lDyk8_gtKbwtLQ075sX99mfMx8zCA9Qx02mfK_wtjP_8EAnHFN6Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdduieegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtsfdttddtvdenucfhrhhomheptehnughrvghs
    ucfhrhgvuhhnugcuoegrnhgurhgvshesrghnrghrrgiivghlrdguvgeqnecuggftrfgrth
    htvghrnhepfeffgfelvdffgedtveelgfdtgefghfdvkefggeetieevjeekteduleevjefh
    ueegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hnughrvghssegrnhgrrhgriigvlhdruggvpdhnsggprhgtphhtthhopedvuddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtoheprghmihhrjeefihhlsehgmhgrihhlrdgtohhmpd
    hrtghpthhtoheprhhithgvshhhrdhlihhsthesghhmrghilhdrtghomhdprhgtphhtthho
    peifihhllhihsehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepughgtgeskhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepughjfihonhhgsehkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehmtghgrhhofheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugi
    dqmhhmsehkvhgrtghkrdhorhhgpdhrtghpthhtohepphgrnhhkrghjrdhrrghghhgrvhes
    lhhinhhugidruggvvhdprhgtphhtthhopehojhgrshifihhnsehlihhnuhigrdhisghmrd
    gtohhm
X-ME-Proxy: <xmx:sDuVaSXyvaYr9G4JcHtLiJjGHv7BkLv4m2EGOHI7rzSv2FMRP3QKuw>
    <xmx:sDuVaUtcuJFdwaVpc3lLxwjAe7gl-FjKWnMS_BZNUVMb2ZIaxpwybA>
    <xmx:sDuVab9VSnjlwm6OapAtW3WseZda5kdwfXj4KS58SKNKX1SXeKle4A>
    <xmx:sDuVacu56fRX3vkTE63zvlRcP-Kcb9o6SbXhaumJnNcOZqQqgQDCkQ>
    <xmx:sTuVaYc0aw3wgiVrivwaFwPcMA5_rqDqvtprmBaVh9KjhQZ7Q4xOt3dg>
Feedback-ID: id4a34324:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Feb 2026 23:10:24 -0500 (EST)
Date: Tue, 17 Feb 2026 23:10:23 -0500
From: Andres Freund <andres@anarazel.de>
To: Dave Chinner <dgc@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>, Christoph Hellwig <hch@lst.de>, 
	Pankaj Raghav <pankaj.raghav@linux.dev>, linux-xfs@vger.kernel.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, lsf-pc@lists.linux-foundation.org, djwong@kernel.org, 
	john.g.garry@oracle.com, willy@infradead.org, ritesh.list@gmail.com, jack@suse.cz, 
	ojaswin@linux.ibm.com, Luis Chamberlain <mcgrof@kernel.org>, dchinner@redhat.com, 
	Javier Gonzalez <javier.gonz@samsung.com>, gost.dev@samsung.com, tytso@mit.edu, p.raghav@samsung.com, 
	vi.shah@samsung.com
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Buffered atomic writes
Message-ID: <is77m5lxg22z2lfhpj3zh7hse5wmft5i2mae72of7iffmtjktu@euxitej5vwxp>
References: <d0c4d95b-8064-4a7e-996d-7ad40eb4976b@linux.dev>
 <20260217055103.GA6174@lst.de>
 <CAOQ4uxgdWvJPAi6QMWQjWJ2TnjO=JP84WCgQ+ShM3GiikF=bSw@mail.gmail.com>
 <ndwqem2mzymo6j3zw3mmxk2vh4mnun2fb2s5vrh4nthatlze3u@qjemcazy4agv>
 <aZTvmpOL7NC4_kDq@dread>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZTvmpOL7NC4_kDq@dread>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[anarazel.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[anarazel.de:s=fm3,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77494-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,lst.de,linux.dev,vger.kernel.org,kvack.org,lists.linux-foundation.org,kernel.org,oracle.com,infradead.org,suse.cz,linux.ibm.com,redhat.com,samsung.com,mit.edu];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andres@anarazel.de,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[anarazel.de:+,messagingengine.com:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,messagingengine.com:dkim]
X-Rspamd-Queue-Id: A952F152EE5
X-Rspamd-Action: no action

Hi,

On 2026-02-18 09:45:46 +1100, Dave Chinner wrote:
> On Tue, Feb 17, 2026 at 10:47:07AM -0500, Andres Freund wrote:
> > There are some kernel issues that make it harder than necessary to use DIO,
> > btw:
> >
> > Most prominently: With DIO concurrently extending multiple files leads to
> > quite terrible fragmentation, at least with XFS. Forcing us to
> > over-aggressively use fallocate(), truncating later if it turns out we need
> > less space.
>
> <ahem>
>
> seriously, fallocate() is considered harmful for exactly these sorts
> of reasons. XFS has vastly better mechanisms built into it that
> mitigate worst case fragmentation without needing to change
> applications or increase runtime overhead.

There's probably a misunderstanding here: We don't do fallocate to avoid
fragmentation.


We want to guarantee that there's space for data that is in our buffer pool,
as otherwise it's very easy to get into a pickle:

If there is dirty data in the buffer pool that can't be written out due to
ENOSPC, the subsequent checkpoint can't complete. So the system may be stuck
because you're not be able to create more space for WAL / journaling, you
can't free up old WAL due to the checkpoint not being able to complete, and if
you react to that with a crash-recovery cycle you're likely to be unable to
complete crash recovery because you'll just hit ENOSPC again.

And yes, CoW filesystems make that less reliable, it turns out to still save
people often enough that I doubt we can get rid of it.


To ensure there's space for the write out of our buffer pool we have two
choices:

1) write out zeroes
2) use fallocate

Writing out zeroes that we will just overwrite later is obviously not a
particularly good use of IO bandwidth, particularly on metered cloud
"storage". But using fallocate() has fragmentation and unwritten-extent
issues.  Our compromise is that we use fallocate iff we enlarge the relation
by a decent number of pages at once and write zeroes otherwise.


Is that perfect? Hell no.  But it's also not obvious what a better answer is
with today's interfaces.

If there were a "guarantee that N additional blocks are reserved, but not
concretely allocated" interface, we'd gladly use it.



> So, let's set the extent size hint on a file to 1MB. Now whenever a
> data extent allocation on that file is attempted, the extent size
> that is allocated will be rounded up to the nearest 1MB.  i.e. XFS
> will try to allocate unwritten extents in aligned multiples of the
> extent size hint regardless of the actual IO size being performed.
>
> Hence if you are doing concurrent extending 8kB writes, instead of
> allocating 8kB at a time, the extent size hint will force a 1MB
> unwritten extent to be allocated out beyond EOF. The subsequent
> extending 8kB writes to that file now hit that unwritten extent, and
> only need to convert it to written. The same will happen for all
> other concurrent extending writes - they will allocate in 1MB
> chunks, not 8KB.

We could probably benefit from that.


> One of the most important properties of extent size hints is that
> they can be dynamically tuned *without changing the application.*
> The extent size hint is a property of the inode, and it can be set
> by the admin through various XFS tools (e.g. mkfs.xfs for a
> filesystem wide default, xfs_io to set it on a directory so all new
> files/dirs created in that directory inherit the value, set it on
> individual files, etc). It can be changed even whilst the file is in
> active use by the application.

IME our users run enough postgres instances, across a lot of differing
workloads, that manual tuning like that will rarely if ever happen :(. I miss
well educated DBAs :(.  A large portion of users doesn't even have direct
access to the server, only via the postgres protocol...

If we were to use these hints, it'd have to happen automatically from within
postgres.  But that does seem viable, but certainly is also not exactly
filesystem independent...



> > The fallocate in turn triggers slowness in the write paths, as
> > writing to uninitialized extents is a metadata operation.
>
> That is not the problem you think it is. XFS is using unwritten
> extents for all buffered IO writes that use delayed allocation, too,
> and I don't see you complaining about that....

It's a problem for buffered IO as well, just a bit harder to hit on many
drives, because buffered O_DSYNC writes don't use FUA.

If you need any durable writes into a file with unwritten extents, things get
painful very fast.

See a few paragraphs below for the most crucial case where we need to make
sure writes are durable.


testdir=/srv/fio && for buffered in 0 1; do for overwrite in 0 1; do echo buffered: $buffered overwrite: $overwrite; rm -f $testdir/pg-extend* && fio --directory=$testdir --ioengine=psync --buffered=$buffered --bs=4kB --fallocate=none --overwrite=0 --rw=write --size=64MB --sync=dsync --name pg-extend --overwrite=$overwrite |grep IOPS;done;done

buffered: 0 overwrite: 0
  write: IOPS=1427, BW=5709KiB/s (5846kB/s)(64.0MiB/11479msec); 0 zone resets
buffered: 0 overwrite: 1
  write: IOPS=4025, BW=15.7MiB/s (16.5MB/s)(64.0MiB/4070msec); 0 zone resets
buffered: 1 overwrite: 0
  write: IOPS=1638, BW=6554KiB/s (6712kB/s)(64.0MiB/9999msec); 0 zone resets
buffered: 1 overwrite: 1
  write: IOPS=3663, BW=14.3MiB/s (15.0MB/s)(64.0MiB/4472msec); 0 zone resets


That's a > 2x throughput difference. And the results would be similar with
--fdatasync=1.


If you add AIO to the mix, the difference gets way bigger, particularly on
drives with FUA support and DIO:


testdir=/srv/fio && for buffered in 0 1; do for overwrite in 0 1; do echo buffered: $buffered overwrite: $overwrite; rm -f $testdir/pg-extend* && fio --directory=$testdir --ioengine=io_uring --buffered=$buffered --bs=4kB --fallocate=none --overwrite=0 --rw=write --size=64MB --sync=dsync --name pg-extend --overwrite=$overwrite --iodepth 32 |grep IOPS;done;done

buffered: 0 overwrite: 0
  write: IOPS=6143, BW=24.0MiB/s (25.2MB/s)(64.0MiB/2667msec); 0 zone resets
buffered: 0 overwrite: 1
  write: IOPS=76.6k, BW=299MiB/s (314MB/s)(64.0MiB/214msec); 0 zone resets
buffered: 1 overwrite: 0
  write: IOPS=1835, BW=7341KiB/s (7517kB/s)(64.0MiB/8928msec); 0 zone resets
buffered: 1 overwrite: 1
  write: IOPS=4096, BW=16.0MiB/s (16.8MB/s)(64.0MiB/4000msec); 0 zone resets


It's less bad, but still quite a noticeable difference, on drives without
volatile caches.  And it's often worse on networked storage, whether it has a
volatile cache or not.




> > It'd be great if
> > the allocation behaviour with concurrent file extension could be improved and
> > if we could have a fallocate mode that forces extents to be initialized.
>
> <sigh>
>
> You mean like FALLOC_FL_WRITE_ZEROES?

I hadn't seen that it was merged, that's great!  It doesn't yet seem to be
documented in the fallocate(2) man page, which I had checked...

Hm, also doesn't seem to work on xfs yet :(, EOPNOTSUPP.


> That won't fix your fragmentation problem, and it has all the same pipeline
> stall problems as allocating unwritten extents in fallocate().

The primary case where FALLOC_FL_WRITE_ZEROES would be useful is for WAL file
creation, which are always of the same fixed size (therefore no fragmentation
risk).

To avoid having metadata operation during our commit path, we today default to
forcing them to be allocated by overwriting them with zeros and fsyncing
them. To avoid having to do that all the time, we reuse them once they're not
needed anymore.

Not ensuring that the extents are already written, would have a very large
perf penalty (as in ~2-3x for OLTP workloads, on XFS). That's true for both
when using DIO and when not.

To avoid having to do that over and over, we recycle WAL files.

Unfortunately this means that when all those WAL files are not yet
preallocated (or when we release them during low activity), the performance is
rather noticeably worsened by the additional IO for pre-zeroing the WAL files.

In theory FALLOC_FL_WRITE_ZEROES should be faster than issuing writes for the
whole range.


> Only much worse now, because the IO pipeline is stalled for the
> entire time it takes to write the zeroes to persistent storage. i.e.
> long tail file access latencies will increase massively if you do
> this regularly to extend files.

In the WAL path we fsync at the point we could use FALLOC_FL_WRITE_ZEROES, as
otherwise the WAL segment might not exist after a crash, which would be
... bad.

Greetings,

Andres Freund

