Return-Path: <linux-fsdevel+bounces-77373-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ACCTM6KTlGl3FgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77373-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 17:13:22 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A0214DF0B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 17:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5002E302F70B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 16:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28BB836E468;
	Tue, 17 Feb 2026 16:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=anarazel.de header.i=@anarazel.de header.b="VwKBeGvw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gbej3kK+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68E9359FB0;
	Tue, 17 Feb 2026 16:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771344792; cv=none; b=U3sFqA3qWiVS70a/OVn3vIAWPZCOMvoY8XInedpOvK8KjCmAdgR/KWlPrG9TLKoyQ7LGhqgUzTyCn+AqUMHZYPeGUpUiAU+x9tjYzf6f78xzSnolNmoYSWs+UX1KlD+UgHOauicM/u7lF83H+w+qY5uxuX9rJwq5/WlVl/se9UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771344792; c=relaxed/simple;
	bh=XzKEnsK93RtbthhKeSvUEsnsgywGNVZscqmxAX8cEM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sb8vYCde0RQ30lRkuf0M2/z6MMWOu1qBOV4VojdQ+RZCDaOmJkJ4h8YmDaOojFADLUiOkjZtI45IWBJwKVu99OT0VjIpVN40YHboPHGkD7/CXN6c5I1aRzmuiVvOeC+uBylTXUzbsuTp0PEkCQ2D3+ccJ0eFEVu+vi0gtspOu5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anarazel.de; spf=pass smtp.mailfrom=anarazel.de; dkim=pass (2048-bit key) header.d=anarazel.de header.i=@anarazel.de header.b=VwKBeGvw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gbej3kK+; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anarazel.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anarazel.de
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 61F311D003E3;
	Tue, 17 Feb 2026 11:13:09 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 17 Feb 2026 11:13:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1771344789; x=1771431189; bh=m85nxpM60M
	hQS/QITwd1hHeXdBL8OWiwGVCZ0ecbrpo=; b=VwKBeGvwQ3zDU0ibAFyO0/1cVw
	HFZe9mheim8Mv8ZI9ZOUbMM9FieNgJ4RUERoQu10Q7QM3iiYpROGu4Z8SEdmWo/c
	VuJYFDSn7QOjleDXAxrPwHn0jttbvS+XBclsb3bReFaLtQwKpfx5dmXPmV3DPoxI
	B3LtKhK7DOr36nyadFu/s4l3kTq0vS+r683i8YqhzDT23uX1UNFOkrVgOVmOhICJ
	XubtoZGX2Y37vgC+I3d7LungGCYPED3FatswxLNQ8n5pipaJI2StCiGcBty86r2d
	SRd/G4Hq+wkW0efCojbH72SxJnoaBwZPxou7Hwr66SjCVw6GWnGr6dL3wemg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771344789; x=1771431189; bh=m85nxpM60MhQS/QITwd1hHeXdBL8OWiwGVC
	Z0ecbrpo=; b=gbej3kK+pS+/gY1RSixWXdD8sBg2pz/RNdJcMbwAL3n2wFBQ37o
	ocQcq2L2sA/ltEUfH3WUXHiQmbcqI4B6W64WqyoVlhfNj0KjdJnPtFIuSTKTSnru
	7ITiNRABCOsw1scccvelmIYUakBLvoSgYo/cmGjeRX8SHdimtdPyv7SOhE2GADVI
	l3VUIh9Y2uBueeFJEwrIkw4Lk8ecM2tnJo+wMmCuMLrHLTnJApUwJEbbvkfl5ue/
	ebYKpOqJrAF7LgbZZgSLwHT+q8PszmIDLWu2B5R0nkBBEulpz4cjJggAUtsuiGEs
	2NiXF9VdqXL9NAcEdnmouqxFOpRqn+4Q9Tg==
X-ME-Sender: <xms:lJOUaf1OyopObblOQKBQKTId9x19m80HnGdbqwam4_t7u3QDny_wog>
    <xme:lJOUaVBNOidFA4M3-2R4vd3gEL4DfkhcVaVg6ebqsPxC8sgugdSA7LMf5TEliXns5
    AtPrb-M237IXwq494TSq2kl_oZMrPoLAv5vA3ND82ZDdmfqgb-dfA>
X-ME-Received: <xmr:lJOUaU8d-GxjEU_eSqep762oF0AhKRd79NlMQPnJi_0QnIQnVnneL5gy8wGW35IPPyhLVw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvddtvdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtsfdttddtvdenucfhrhhomheptehnughrvghs
    ucfhrhgvuhhnugcuoegrnhgurhgvshesrghnrghrrgiivghlrdguvgeqnecuggftrfgrth
    htvghrnhepfeffgfelvdffgedtveelgfdtgefghfdvkefggeetieevjeekteduleevjefh
    ueegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hnughrvghssegrnhgrrhgriigvlhdruggvpdhnsggprhgtphhtthhopeduledpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtoheprhhithgvshhhrdhlihhsthesghhmrghilhdrtg
    homhdprhgtphhtthhopeifihhllhihsehinhhfrhgruggvrggurdhorhhgpdhrtghpthht
    ohepughjfihonhhgsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmtghgrhhofheskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqmhhmsehkvhgrtghkrdhorhhg
    pdhrtghpthhtohepphgrnhhkrghjrdhrrghghhgrvheslhhinhhugidruggvvhdprhgtph
    htthhopehojhgrshifihhnsehlihhnuhigrdhisghmrdgtohhmpdhrtghpthhtoheplhhs
    fhdqphgtsehlihhsthhsrdhlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtph
    htthhopehhtghhsehlshhtrdguvg
X-ME-Proxy: <xmx:lJOUab-sg_v_9Nwe-Hj7FocWNEnVkceFy4ptsFWcNKhvxSpmpfyb8w>
    <xmx:lJOUac0bt2Cgs4FmxNFKdYE1vN3KpUbluYCbYu5EpjYDO67Bo5ovVg>
    <xmx:lJOUab_bvpQs7FYgPKyECcCh-p3X0YgndY4nGJSM0o5tFCGKCwkX4A>
    <xmx:lJOUaddyETi61lDR0KY7lrcR58ho5aM3CpT3Zagy7fV_hrA9nPN8IA>
    <xmx:lZOUaWySsAvELHojLCN5Yj4ha_-StpXVUfGtGFMXkLCzbgSCQgg-klvq>
Feedback-ID: id4a34324:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Feb 2026 11:13:08 -0500 (EST)
Date: Tue, 17 Feb 2026 11:13:07 -0500
From: Andres Freund <andres@anarazel.de>
To: Jan Kara <jack@suse.cz>
Cc: Pankaj Raghav <pankaj.raghav@linux.dev>, 
	Ojaswin Mujoo <ojaswin@linux.ibm.com>, linux-xfs@vger.kernel.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, lsf-pc@lists.linux-foundation.org, djwong@kernel.org, 
	john.g.garry@oracle.com, willy@infradead.org, hch@lst.de, ritesh.list@gmail.com, 
	Luis Chamberlain <mcgrof@kernel.org>, dchinner@redhat.com, Javier Gonzalez <javier.gonz@samsung.com>, 
	gost.dev@samsung.com, tytso@mit.edu, p.raghav@samsung.com, vi.shah@samsung.com
Subject: Re: [LSF/MM/BPF TOPIC] Buffered atomic writes
Message-ID: <2planlrvjqicgpparsdhxipfdoawtzq3tedql72hoff4pdet6t@btxbx6cpoyc6>
References: <d0c4d95b-8064-4a7e-996d-7ad40eb4976b@linux.dev>
 <aY8n97G_hXzA5MMn@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <7cf3f249-453d-423a-91d1-dfb45c474b78@linux.dev>
 <zzvybbfy6bcxnkt4cfzruhdyy6jsvnuvtjkebdeqwkm6nfpgij@dlps7ucza22s>
 <wkczfczlmstoywbmgfrxzm6ko4frjsu65kvpwquzu7obrjcd3f@6gs5nsfivc6v>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wkczfczlmstoywbmgfrxzm6ko4frjsu65kvpwquzu7obrjcd3f@6gs5nsfivc6v>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[anarazel.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[anarazel.de:s=fm3,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77373-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux.dev,linux.ibm.com,vger.kernel.org,kvack.org,lists.linux-foundation.org,kernel.org,oracle.com,infradead.org,lst.de,gmail.com,redhat.com,samsung.com,mit.edu];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andres@anarazel.de,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[anarazel.de:+,messagingengine.com:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[anarazel.de:dkim,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 72A0214DF0B
X-Rspamd-Action: no action

Hi,

On 2026-02-17 13:06:04 +0100, Jan Kara wrote:
> On Mon 16-02-26 10:45:40, Andres Freund wrote:
> > (*) As it turns out, it often seems to improves write throughput as well, if
> > writeback is triggered by memory pressure instead of SYNC_FILE_RANGE_WRITE,
> > linux seems to often trigger a lot more small random IO.
> >
> > > So immediately writing them might be ok as long as we don't remove those
> > > pages from the page cache like we do in RWF_UNCACHED.
> >
> > Yes, it might.  I actually often have wished for something like a
> > RWF_WRITEBACK flag...
>
> I'd call it RWF_WRITETHROUGH but otherwise it makes sense.

Heh, that makes sense. I think that's what I actually was thinking of.


> > > > An argument against this however is that it is user's responsibility to
> > > > not do non atomic IO over an atomic range and this shall be considered a
> > > > userspace usage error. This is similar to how there are ways users can
> > > > tear a dio if they perform overlapping writes. [1].
> >
> > Hm, the scope of the prohibition here is not clear to me. Would it just
> > be forbidden to do:
> >
> > P1: start pwritev(fd, [blocks 1-10], RWF_ATOMIC)
> > P2: pwrite(fd, [any block in 1-10]), non-atomically
> > P1: complete pwritev(fd, ...)
> >
> > or is it also forbidden to do:
> >
> > P1: pwritev(fd, [blocks 1-10], RWF_ATOMIC) start & completes
> > Kernel: starts writeback but doesn't complete it
> > P1: pwrite(fd, [any block in 1-10]), non-atomically
> > Kernel: completes writeback
> >
> > The former is not at all an issue for postgres' use case, the pages in
> > our buffer pool that are undergoing IO are locked, preventing additional
> > IO (be it reads or writes) to those blocks.
> >
> > The latter would be a problem, since userspace wouldn't even know that
> > here is still "atomic writeback" going on, afaict the only way we could
> > avoid it would be to issue an f[data]sync(), which likely would be
> > prohibitively expensive.
>
> It somewhat depends on what outcome you expect in terms of crash safety :)
> Unless we are careful, the RWF_ATOMIC write in your latter example can end
> up writing some bits of the data from the second write because the second
> write may be copying data to the pages as we issue DMA from them to the
> device.

Hm. It's somewhat painful to not know when we can write in what mode again -
with DIO that's not an issue. I guess we could use
sync_file_range(SYNC_FILE_RANGE_WAIT_BEFORE) if we really needed to know?
Although the semantics of the SFR flags aren't particularly clear, so maybe
not?


> I expect this isn't really acceptable because if you crash before
> the second write fully makes it to the disk, you will have inconsistent
> data.

The scenarios that I can think that would lead us to doing something like
this, are when we are overwriting data without regard for the prior contents,
e.g:

An already partially filled page is filled with more rows, we write that page
out, then all the rows are deleted, and we re-fill the page with new content
from scratch. Write it out again.  With our existing logic we treat the second
write differently, because the entire contents of the page will be in the
journal, as there is no prior content that we care about.

A second scenario in which we might not use RWF_ATOMIC, if we carry today's
logic forward, is if a newly created relation is bulk loaded in the same
transaction that created the relation. If a crash were to happen while that
bulk load is ongoing, we don't care about the contents of the file(s), as it
will never be visible to anyone after crash recovery.  In this case we won't
have prio RWF_ATOMIC writes - but we could have the opposite, i.e. an
RWF_ATOMIC write while there already is non-RWF_ATOMIC dirty data in the page
cache. Would that be an issue?


It's possible we should just always use RWF_ATOMIC, even in the cases where
it's not needed from our side, to avoid potential performance penalties and
"undefined behaviour".  I guess that will really depend on the performance
penalty that RWF_ATOMIC will carry and whether multiple-atomicity-mode will
eventually be supported (as doing small writes during bulk loading is quite
expensive).


Greetings,

Andres Freund

