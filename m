Return-Path: <linux-fsdevel+bounces-77654-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iDO/AkNalmm9eAIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77654-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 01:33:07 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B1F15B2B9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 01:33:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7B6163021599
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 00:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D897F1DF985;
	Thu, 19 Feb 2026 00:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HhaUOlMr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DF4199EAD;
	Thu, 19 Feb 2026 00:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771461179; cv=none; b=PrXYgjxqYJ/m2FHXJpeWazkqaWFtH+CfaC78EKCpfFZOussfu64SSKlYmH/ZS+rAZoPz8u/V+AmZaK3d+4DjUiQf9SOs4aMp0d2SvYAeW+dFvGL/9RcGZJkZwq6/I8Ik/BK+aB2y04DjkZ0iN9pVbBtscY0AWiGaVRI1ZeyHGug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771461179; c=relaxed/simple;
	bh=LshIPA616HGHej/yvGjLaNlyNI+47/IjLdNm/ls8NuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FZLKnLpGh/jfQBs5Fqb9Fnd5GWGYJQzQKYtjEAPqd6S+qc9ZkdBfoNadKB3PS+9gGPkg4coZi6e3DDt9Vf82pi6EfvloHPx7lAqF1i2wbdW0l3Dlqg+40WFtizC5Svzmr1Ns2nx2p95bo3ZpiVmR81o1orrLGEFr7DdhJkpCiJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HhaUOlMr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7114CC116D0;
	Thu, 19 Feb 2026 00:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771461179;
	bh=LshIPA616HGHej/yvGjLaNlyNI+47/IjLdNm/ls8NuI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HhaUOlMrPRQgvtMPpSxM20MBDr64vVJpbAY1pu+O8090E8NnRndqiM0WyCDxTDvLF
	 d03ezHeQ58t0QrKTr18pVUK/FibjSIgMck6c/JbiDQjybjfhZ0xq2KsCstIMZGTgyE
	 0rDBVSbsynuHFLHM8lmDQjXBYn7jo7bbecSYg+dF02lEADQBXk1eBzY4+QIwgchpwT
	 Xs1R7mywrf6yHWHuq2NndhnsC6GlYO5ZwP9+M2HZeYdKGBdjAElFUfVS8BiRN64g49
	 8Q8XfvYMHv8zeSpwe1Y19HMYXvQuTMa8j4rywwdACD9RQr+/a0oCW/x2WP1xMgv+Ua
	 sxoI0MirSmuDw==
Date: Thu, 19 Feb 2026 11:32:45 +1100
From: Dave Chinner <dgc@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Andres Freund <andres@anarazel.de>,
	Pankaj Raghav <pankaj.raghav@linux.dev>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>, linux-xfs@vger.kernel.org,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	lsf-pc@lists.linux-foundation.org, djwong@kernel.org,
	john.g.garry@oracle.com, willy@infradead.org, hch@lst.de,
	ritesh.list@gmail.com, Luis Chamberlain <mcgrof@kernel.org>,
	dchinner@redhat.com, Javier Gonzalez <javier.gonz@samsung.com>,
	gost.dev@samsung.com, tytso@mit.edu, p.raghav@samsung.com,
	vi.shah@samsung.com
Subject: Re: [LSF/MM/BPF TOPIC] Buffered atomic writes
Message-ID: <aZZaLQhC-nFmJBTq@dread>
References: <d0c4d95b-8064-4a7e-996d-7ad40eb4976b@linux.dev>
 <aY8n97G_hXzA5MMn@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <7cf3f249-453d-423a-91d1-dfb45c474b78@linux.dev>
 <zzvybbfy6bcxnkt4cfzruhdyy6jsvnuvtjkebdeqwkm6nfpgij@dlps7ucza22s>
 <wkczfczlmstoywbmgfrxzm6ko4frjsu65kvpwquzu7obrjcd3f@6gs5nsfivc6v>
 <2planlrvjqicgpparsdhxipfdoawtzq3tedql72hoff4pdet6t@btxbx6cpoyc6>
 <umq2nlgxqp4xbrp23zjiajwd6ombed4dfwbajuh35xd4vphyee@26g2y6a4rdnu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <umq2nlgxqp4xbrp23zjiajwd6ombed4dfwbajuh35xd4vphyee@26g2y6a4rdnu>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77654-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[anarazel.de,linux.dev,linux.ibm.com,vger.kernel.org,kvack.org,lists.linux-foundation.org,kernel.org,oracle.com,infradead.org,lst.de,gmail.com,redhat.com,samsung.com,mit.edu];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dgc@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A3B1F15B2B9
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 06:37:45PM +0100, Jan Kara wrote:
> On Tue 17-02-26 11:13:07, Andres Freund wrote:
> > > > P1: pwritev(fd, [blocks 1-10], RWF_ATOMIC) start & completes
> > > > Kernel: starts writeback but doesn't complete it
> > > > P1: pwrite(fd, [any block in 1-10]), non-atomically
> > > > Kernel: completes writeback
> > > >
> > > > The former is not at all an issue for postgres' use case, the pages in
> > > > our buffer pool that are undergoing IO are locked, preventing additional
> > > > IO (be it reads or writes) to those blocks.
> > > >
> > > > The latter would be a problem, since userspace wouldn't even know that
> > > > here is still "atomic writeback" going on, afaict the only way we could
> > > > avoid it would be to issue an f[data]sync(), which likely would be
> > > > prohibitively expensive.
> > >
> > > It somewhat depends on what outcome you expect in terms of crash safety :)
> > > Unless we are careful, the RWF_ATOMIC write in your latter example can end
> > > up writing some bits of the data from the second write because the second
> > > write may be copying data to the pages as we issue DMA from them to the
> > > device.
> > 
> > Hm. It's somewhat painful to not know when we can write in what mode again -
> > with DIO that's not an issue. I guess we could use
> > sync_file_range(SYNC_FILE_RANGE_WAIT_BEFORE) if we really needed to know?
> > Although the semantics of the SFR flags aren't particularly clear, so maybe
> > not?
> 
> If you used RWF_WRITETHROUGH for your writes (so you are sure IO has
> already started) then sync_file_range(SYNC_FILE_RANGE_WAIT_BEFORE) would
> indeed be a safe way of waiting for that IO to complete (or just wait for
> the write(2) syscall itself to complete if we make RWF_WRITETHROUGH wait
> for IO completion as Dave suggests - but I guess writes may happen from
> multiple threads so that may be not very convenient and sync_file_range(2)
> might be actually easier).

I would much prefer we don't have to rely on crappy interfaces like
sync_file_range() to handle RWF_WRITETHROUGH IO completion
processing. All it does is add complexity to error
handling/propagation to both the kernel code and the userspace code.
It takes something that is easy to get right (i.e. synchronous
completion) and replaces it with something that is easy to get
wrong. That's not good API design.

As for handling multiple writes to the same range, stable pages do
that for us. RWF_WRITETHROUGH will need to set folios in the
writeback state before submission and clear it after completion so
that stable pages work correctly. Hence we may as well use that
functionality to serialise overlapping RWF_WRITETHROUGH IOs and
against concurrent background and data integrity driven writeback

We should be trying hard to keep this simple and consistent with
existing write-through IO models that people already know how to use
(i.e. DIO).

> > > I expect this isn't really acceptable because if you crash before
> > > the second write fully makes it to the disk, you will have inconsistent
> > > data.
> > 
> > The scenarios that I can think that would lead us to doing something like
> > this, are when we are overwriting data without regard for the prior contents,
> > e.g:
> > 
> > An already partially filled page is filled with more rows, we write that page
> > out, then all the rows are deleted, and we re-fill the page with new content
> > from scratch. Write it out again.  With our existing logic we treat the second
> > write differently, because the entire contents of the page will be in the
> > journal, as there is no prior content that we care about.
> > 
> > A second scenario in which we might not use RWF_ATOMIC, if we carry today's
> > logic forward, is if a newly created relation is bulk loaded in the same
> > transaction that created the relation. If a crash were to happen while that
> > bulk load is ongoing, we don't care about the contents of the file(s), as it
> > will never be visible to anyone after crash recovery.  In this case we won't
> > have prio RWF_ATOMIC writes - but we could have the opposite, i.e. an
> > RWF_ATOMIC write while there already is non-RWF_ATOMIC dirty data in the page
> > cache. Would that be an issue?
> 
> No, this should be fine. But as I'm thinking about it what seems the most
> natural is that RWF_WRITETHROUGH writes will wait on any pages under
> writeback in the target range before proceeding with the write.

I think that is required behaviour, even though it is natural. IMO,
concurrent overlapping physical IOs from the page cache via
RWF_WRITETHROUGH is a data corruption vector just waiting for
someone to trip over it...

i.e. we need to keep in mind that one of the guarantees that the
page cache provides is that it will never overlap multiple
concurrent physical IOs to the same physical range. Overlapping IOs
are handled and serialised at the folio level, they should never end
up with overlapping physical IO being issued.

> That will
> give user proper serialization with other RWF_WRITETHROUGH writes to the
> overlapping range as well as writeback from previous normal writes. So the
> only case that needs handling - either by userspace or kernel forcing
> stable writes - would be RWF_WRITETHROUGH write followed by a normal write.

*nod*. I think forcing stable writes for RWF_WRITETHROUGH is the
right way to go. We are going to need stable write semantic for
RWF_ATOMIC support, and we probably should have them for RWF_DSYNC
as well because the data integrity guarantees cover the data in that
specific user IO, not any other previous, concurrent or future user
IO.

-Dave.

-- 
Dave Chinner
dgc@kernel.org

