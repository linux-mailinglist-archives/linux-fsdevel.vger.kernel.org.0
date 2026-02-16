Return-Path: <linux-fsdevel+bounces-77305-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KQETC687k2kg2wEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77305-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 16:45:51 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EC89E145BDB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 16:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D316C30158BD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 15:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3AF2D7DF3;
	Mon, 16 Feb 2026 15:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=anarazel.de header.i=@anarazel.de header.b="fLcbJWSQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TEBdSCZw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242B219CC28;
	Mon, 16 Feb 2026 15:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771256747; cv=none; b=MyUZnj+MUzE9UJFJWNWMELmsIJ46bsK+uZGIWq3rhMW9tKKirLS7lwUxWfrxiwKsh+qMra7+yW9ElYNQCEelbRs/P6LAigqIADEn0n0TYJ5+6YeM1YMHLonoJ5Fcl//FaNAVpIYu8o5B/oyF8yum2VdGXGjcBWhq2mN7K40EmN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771256747; c=relaxed/simple;
	bh=Evpzvkw81S0CRbwE/HHEyEmxFarwL+mFUgQPB6wLPq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A+5QUvJdqNaOfF+ibl6RVd1Slq4SQ8eM/XIlAT6cmB5usDgNPllGmpLmmwaA3sLpK7D128+ZK5u838bm+1t5MTnWUOYrO5b57aaVP1xXn76kL6hdSmYY15Gw0vBhoU0VgEHnsTyc+jsZ9or1Q2bxtdqMWEvRcEvCE3VASj2goJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anarazel.de; spf=pass smtp.mailfrom=anarazel.de; dkim=pass (2048-bit key) header.d=anarazel.de header.i=@anarazel.de header.b=fLcbJWSQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TEBdSCZw; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anarazel.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anarazel.de
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8FB777A0132;
	Mon, 16 Feb 2026 10:45:43 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Mon, 16 Feb 2026 10:45:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1771256743; x=1771343143; bh=byd/v2Kyqy
	Dmof5svJZ7UzEBF0pNwQx35fX6HwsRSGs=; b=fLcbJWSQjsRhBbOBtM2EW8Z+7J
	MqQnRDhJLYSMACQ3EJqa4WizGze79ppT7QggWvX0dP2MEMHguctxA7EZdn5v5g22
	78F3huI8LgHKdVH3dzS0fqJ1EtOvsaYOFqSiADeXt34dhqaItUNbRME+xKU/gJFq
	esAWi4t+c7F5UvMeUSZhKZ5aq1J1mphwvYYqSBXU1sHA67jmbOv4KzSOzxGsTd6Q
	oPXzwDneb/A6o/QMslyJO/0mhLwXg5tyCT3jRx/K16d4sn435isg8kXvu9nzZOTt
	QcrZLq/6YgWjUiersqTNFhBFStjMxT0Objk2aa+xdbUxFjYLV/I2NY0wf8tw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771256743; x=1771343143; bh=byd/v2KyqyDmof5svJZ7UzEBF0pNwQx35fX
	6HwsRSGs=; b=TEBdSCZwiOP63qvlCuIBpa6qUvBOh5Z+T7jXUo+gKDBrBiIk3RC
	wp7MY5EY94uq3MlfAdpBZgPQ6iAJzB7PxWTcVc3JaUheJlizdT7O6w2Fzj4jCz36
	dP6nCJr/YHi8uPf4EU0l+IeqW4YiNGT7yi78bx1DpYgM6wCbtobMhFezzz32MtIL
	7zJ39G1E0Cl9MmMo6wHs+PRKgWoNPXiMUQ8HPhDgQ+wUMwpEcImYOjmNWheMwH+e
	uhmiT3094iGrZWpACEWO9Bj/ASy7+VWJ3PHHzb0+kdPKd7Qbf+LfrZqbwlXC1D2u
	Xw/dJZwCyTWihCGbUd0JfxldtjXdqgzKifw==
X-ME-Sender: <xms:pTuTaa_UHB7SBUzARRWugCYU1fi6tg1hE4XJS-reok_qw6Msi5ykiA>
    <xme:pTuTaRomk6HNgnr-JwZDaToS0XjX02Xv38_eHpsbstwupjNS9i8iiQalS76v7Mtqo
    h9rzioOL-Rh6wn9AA2vvevLSOly203B8YUeLObfdLo7iS7d6-Izyg>
X-ME-Received: <xmr:pTuTaVHnyV0scUE-Yl1IbhBsGRO5nxCm5pj5dO4LEIy18KkLUzAaHUF1IND_FXBO-LDIiw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvudejvdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtsfdttddtvdenucfhrhhomheptehnughrvghs
    ucfhrhgvuhhnugcuoegrnhgurhgvshesrghnrghrrgiivghlrdguvgeqnecuggftrfgrth
    htvghrnhepheeiudduuedvleetjedujeffgeeiueevgeehjedtgeehueekledthfelhefh
    geelnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhgurhgvshesrghnrghrrgiivghlrdgu
    vgdpnhgspghrtghpthhtohepudelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hrihhtvghshhdrlhhishhtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepfihilhhlhies
    ihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopegujhifohhngheskhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepmhgtghhrohhfsehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehlihhnuhigqdhmmheskhhvrggtkhdrohhrghdprhgtphhtthhopehprghnkhgrjhdrrh
    grghhhrghvsehlihhnuhigrdguvghvpdhrtghpthhtohepohhjrghsfihinheslhhinhhu
    gidrihgsmhdrtghomhdprhgtphhtthhopehlshhfqdhptgeslhhishhtshdrlhhinhhugi
    dqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohephhgthheslhhsthdruggv
X-ME-Proxy: <xmx:pTuTaZl7LPYcsR3rciVtoJqfCZEOB0JQbGcoz0-ic0KULz8k1mwQAg>
    <xmx:pTuTaZ8KZ4GEjbzHp0LCzKCqshn9ctf2Dn-xgEqWJjKR4M-qcJlGKw>
    <xmx:pTuTaSk30NVwN2D8fPSMsDU74Buf2DDpFgtKwP5EK8n_mhC5E9Fq4A>
    <xmx:pTuTafmaTrZODoYe5KF8w9RVTJWLs_dmhfkOxz02Sp2egRBkDarhgQ>
    <xmx:pzuTaTlhh_ePKldq6rQo1A5lMYc_mOlA_DBFEWV_-jnEBGri5pawnUv9>
Feedback-ID: id4a34324:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Feb 2026 10:45:41 -0500 (EST)
Date: Mon, 16 Feb 2026 10:45:40 -0500
From: Andres Freund <andres@anarazel.de>
To: Pankaj Raghav <pankaj.raghav@linux.dev>
Cc: Ojaswin Mujoo <ojaswin@linux.ibm.com>, linux-xfs@vger.kernel.org, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, lsf-pc@lists.linux-foundation.org, 
	djwong@kernel.org, john.g.garry@oracle.com, willy@infradead.org, hch@lst.de, 
	ritesh.list@gmail.com, jack@suse.cz, Luis Chamberlain <mcgrof@kernel.org>, 
	dchinner@redhat.com, Javier Gonzalez <javier.gonz@samsung.com>, gost.dev@samsung.com, 
	tytso@mit.edu, p.raghav@samsung.com, vi.shah@samsung.com
Subject: Re: [LSF/MM/BPF TOPIC] Buffered atomic writes
Message-ID: <zzvybbfy6bcxnkt4cfzruhdyy6jsvnuvtjkebdeqwkm6nfpgij@dlps7ucza22s>
References: <d0c4d95b-8064-4a7e-996d-7ad40eb4976b@linux.dev>
 <aY8n97G_hXzA5MMn@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <7cf3f249-453d-423a-91d1-dfb45c474b78@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7cf3f249-453d-423a-91d1-dfb45c474b78@linux.dev>
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
	TAGGED_FROM(0.00)[bounces-77305-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux.ibm.com,vger.kernel.org,kvack.org,lists.linux-foundation.org,kernel.org,oracle.com,infradead.org,lst.de,gmail.com,suse.cz,redhat.com,samsung.com,mit.edu];
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
X-Rspamd-Queue-Id: EC89E145BDB
X-Rspamd-Action: no action

Hi,

On 2026-02-16 10:52:35 +0100, Pankaj Raghav wrote:
> On 2/13/26 14:32, Ojaswin Mujoo wrote:
> > On Fri, Feb 13, 2026 at 11:20:36AM +0100, Pankaj Raghav wrote:
> >> We currently have RFCs posted by John Garry and Ojaswin Mujoo, and there
> >> was a previous LSFMM proposal about untorn buffered writes from Ted Tso.
> >> Based on the conversation/blockers we had before, the discussion at LSFMM
> >> should focus on the following blocking issues:
> >>
> >> - Handling Short Writes under Memory Pressure[6]: A buffered atomic
> >>   write might span page boundaries. If memory pressure causes a page
> >>   fault or reclaim mid-copy, the write could be torn inside the page
> >>   cache before it even reaches the filesystem.
> >>     - The current RFC uses a "pinning" approach: pinning user pages and
> >>       creating a BVEC to ensure the full copy can proceed atomically.
> >>       This adds complexity to the write path.
> >>     - Discussion: Is this acceptable? Should we consider alternatives,
> >>       such as requiring userspace to mlock the I/O buffers before
> >>       issuing the write to guarantee atomic copy in the page cache?
> >
> > Right, I chose this approach because we only get to know about the short
> > copy after it has actually happened in copy_folio_from_iter_atomic()
> > and it seemed simpler to just not let the short copy happen. This is
> > inspired from how dio pins the pages for DMA, just that we do it
> > for a shorter time.
> >
> > It does add slight complexity to the path but I'm not sure if it's complex
> > enough to justify adding a hard requirement of having pages mlock'd.
> >
>
> As databases like postgres have a buffer cache that they manage in userspace,
> which is eventually used to do IO, I am wondering if they already do a mlock
> or some other way to guarantee the buffer cache does not get reclaimed. That is
> why I was thinking if we could make it a requirement. Of course, that also requires
> checking if the range is mlocked in the iomap_write_iter path.

We don't generally mlock our buffer pool - but we strongly recommend to use
explicit huge pages (due to TLB pressure, faster fork() and less memory wasted
on page tables), which afaict has basically the same effect. However, that
doesn't make the page cache pages locked...


> >> - Page Cache Model vs. Filesystem CoW: The current RFC introduces a
> >>   PG_atomic page flag to track dirty pages requiring atomic writeback.
> >>   This faced pushback due to page flags being a scarce resource[7].
> >>   Furthermore, it was argued that atomic model does not fit the buffered
> >>   I/O model because data sitting in the page cache is vulnerable to
> >>   modification before writeback occurs, and writeback does not preserve
> >>   application ordering[8].
> >>     -  Dave Chinner has proposed leveraging the filesystem's CoW path
> >>        where we always allocate new blocks for the atomic write (forced
> >>        CoW). If the hardware supports it (e.g., NVMe atomic limits), the
> >>        filesystem can optimize the writeback to use REQ_ATOMIC in place,
> >>        avoiding the CoW overhead while maintaining the architectural
> >>        separation.
> >
> > Right, this is what I'm doing in the new RFC where we maintain the
> > mappings for atomic write in COW fork. This way we are able to utilize a
> > lot of existing infrastructure, however it does add some complexity to
> > ->iomap_begin() and ->writeback_range() callbacks of the FS. I believe
> > it is a tradeoff since the general consesus was mostly to avoid adding
> > too much complexity to iomap layer.
> >
> > Another thing that came up is to consider using write through semantics
> > for buffered atomic writes, where we are able to transition page to
> > writeback state immediately after the write and avoid any other users to
> > modify the data till writeback completes. This might affect performance
> > since we won't be able to batch similar atomic IOs but maybe
> > applications like postgres would not mind this too much. If we go with
> > this approach, we will be able to avoid worrying too much about other
> > users changing atomic data underneath us.
> >
>
> Hmm, IIUC, postgres will write their dirty buffer cache by combining
> multiple DB pages based on `io_combine_limit` (typically 128kb).

We will try to do that, but it's obviously far from always possible, in some
workloads [parts of ]the data in the buffer pool rarely will be dirtied in
consecutive blocks.

FWIW, postgres already tries to force some just-written pages into
writeback. For sources of writes that can be plentiful and are done in the
background, we default to issuing sync_file_range(SYNC_FILE_RANGE_WRITE),
after 256kB-512kB of writes, as otherwise foreground latency can be
significantly impacted by the kernel deciding to suddenly write back (due to
dirty_writeback_centisecs, dirty_background_bytes, ...) and because otherwise
the fsyncs at the end of a checkpoint can be unpredictably slow.  For
foreground writes we do not default to that, as there are users that won't
(because they don't know, because they overcommit hardware, ...) size
postgres' buffer pool to be big enough and thus will often re-dirty pages that
have already recently been written out to the operating systems.  But for many
workloads it's recommened that users turn on
sync_file_range(SYNC_FILE_RANGE_WRITE) for foreground writes as well (*).

So for many workloads it'd be fine to just always start writeback for atomic
writes immediately. It's possible, but I am not at all sure, that for most of
the other workloads, the gains from atomic writes will outstrip the cost of
more frequently writing data back.


(*) As it turns out, it often seems to improves write throughput as well, if
writeback is triggered by memory pressure instead of SYNC_FILE_RANGE_WRITE,
linux seems to often trigger a lot more small random IO.


> So immediately writing them might be ok as long as we don't remove those
> pages from the page cache like we do in RWF_UNCACHED.

Yes, it might.  I actually often have wished for something like a
RWF_WRITEBACK flag...


> > An argument against this however is that it is user's responsibility to
> > not do non atomic IO over an atomic range and this shall be considered a
> > userspace usage error. This is similar to how there are ways users can
> > tear a dio if they perform overlapping writes. [1].

Hm, the scope of the prohibition here is not clear to me. Would it just
be forbidden to do:

P1: start pwritev(fd, [blocks 1-10], RWF_ATOMIC)
P2: pwrite(fd, [any block in 1-10]), non-atomically
P1: complete pwritev(fd, ...)

or is it also forbidden to do:

P1: pwritev(fd, [blocks 1-10], RWF_ATOMIC) start & completes
Kernel: starts writeback but doesn't complete it
P1: pwrite(fd, [any block in 1-10]), non-atomically
Kernel: completes writeback

The former is not at all an issue for postgres' use case, the pages in our
buffer pool that are undergoing IO are locked, preventing additional IO (be it
reads or writes) to those blocks.

The latter would be a problem, since userspace wouldn't even know that here is
still "atomic writeback" going on, afaict the only way we could avoid it would
be to issue an f[data]sync(), which likely would be prohibitively expensive.



> > That being said, I think these points are worth discussing and it would
> > be helpful to have people from postgres around while discussing these
> > semantics with the FS community members.
> >
> > As for ordering of writes, I'm not sure if that is something that
> > we should guarantee via the RWF_ATOMIC api. Ensuring ordering has mostly
> > been the task of userspace via fsync() and friends.
> >
>
> Agreed.

From postgres' side that's fine. In the cases we care about ordering we use
fsync() already.


> > [1] https://lore.kernel.org/fstests/0af205d9-6093-4931-abe9-f236acae8d44@oracle.com/
> >
> >>     - Discussion: While the CoW approach fits XFS and other CoW
> >>       filesystems well, it presents challenges for filesystems like ext4
> >>       which lack CoW capabilities for data. Should this be a filesystem
> >>       specific feature?
> >
> > I believe your question is if we should have a hard dependency on COW
> > mappings for atomic writes. Currently, COW in atomic write context in
> > XFS, is used for these 2 things:
> >
> > 1. COW fork holds atomic write ranges.
> >
> > This is not strictly a COW feature, just that we are repurposing the COW
> > fork to hold our atomic ranges. Basically a way for writeback path to
> > know that atomic write was done here.

Does that mean buffered atomic writes would cause fragmentation?  Some common
database workloads, e.g. anything running on cheaper cloud storage, are pretty
sensitive to that due to the increase in use of the metered IOPS.

Greetings,

Andres Freund

