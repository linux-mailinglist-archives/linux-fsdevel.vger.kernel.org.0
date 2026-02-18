Return-Path: <linux-fsdevel+bounces-77653-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0FWXOGtOlmmbdgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77653-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 00:42:35 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EDA215AFC6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 00:42:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CE1D93009818
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 23:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CEB133B6E8;
	Wed, 18 Feb 2026 23:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V482Ob1R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5132E6CB6;
	Wed, 18 Feb 2026 23:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771458135; cv=none; b=iOix/vAIaC1dwU9pz4LS9T+s6jOD+vjlK5LKR1xdV1hILBTUjXwghuGZ3Cjk43I2ke4dTdVtXgYas1TrobOJYdGwmBsxYQHnH+kmmyUbqk/5mXycpJwvMu00bZ555U5nYY9npqYb4YOGXcbL0wkJ2cjl7qjs1tYB/ECxjmfH6FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771458135; c=relaxed/simple;
	bh=wCbI6wj7oxCUGmf8RRxMZeFQ8W8q98rrl9MHtnRP6jI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E8CxbyBevQXwl79+W1fLObxPnRJfQxBexg/C+nZbZwMC5ijvo7kVXE03hDQY74WTN9xlZ5Ehn5+i/zYUZc5neX7u0h3rqa7I2PRad5Zcy1l+obf5NxNifY0ztkBZCINInvRYvIQW715xRy2HB++eqVIE/ojepz82ztrsP4APTpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V482Ob1R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7BAFC116D0;
	Wed, 18 Feb 2026 23:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771458134;
	bh=wCbI6wj7oxCUGmf8RRxMZeFQ8W8q98rrl9MHtnRP6jI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V482Ob1RXXUzn81PwKknfj7zFSM//p1O8HjqzzfwWdYy1c36IW7SYGt4KfeDAHGtG
	 iKZ+UaU1YzcsbouN6WtYesHztcMAxrjzxHH8+Ld7a0l9Qvq9M1JaXFzmR/Aem9NJfB
	 fNMli9L16D8GygPMO77W3Un9Kd93UzFoP7I2e+4B7r1JGCNuE/7CFpIASwzB0Y7TqF
	 dUEvqViPc39jgHBIDtaxVVXXSCZRcbXp6L82sRgzRfMjSwycsGRFj8p1QPEhY0J2aA
	 TKoPoxozyRhyjSityUtYqM8fbMy9QyobU01DTGOh61T5J4JbgQEtQKjpssD2kaMAOX
	 4dY6Jl5xEvcNw==
Date: Thu, 19 Feb 2026 10:42:00 +1100
From: Dave Chinner <dgc@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Andres Freund <andres@anarazel.de>,
	Pankaj Raghav <pankaj.raghav@linux.dev>, Jan Kara <jack@suse.cz>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>, linux-xfs@vger.kernel.org,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	lsf-pc@lists.linux-foundation.org, djwong@kernel.org,
	john.g.garry@oracle.com, willy@infradead.org, ritesh.list@gmail.com,
	Luis Chamberlain <mcgrof@kernel.org>, dchinner@redhat.com,
	Javier Gonzalez <javier.gonz@samsung.com>, gost.dev@samsung.com,
	tytso@mit.edu, p.raghav@samsung.com, vi.shah@samsung.com
Subject: Re: [LSF/MM/BPF TOPIC] Buffered atomic writes
Message-ID: <aZZOSFdL_L_EoU34@dread>
References: <d0c4d95b-8064-4a7e-996d-7ad40eb4976b@linux.dev>
 <aY8n97G_hXzA5MMn@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <7cf3f249-453d-423a-91d1-dfb45c474b78@linux.dev>
 <zzvybbfy6bcxnkt4cfzruhdyy6jsvnuvtjkebdeqwkm6nfpgij@dlps7ucza22s>
 <wkczfczlmstoywbmgfrxzm6ko4frjsu65kvpwquzu7obrjcd3f@6gs5nsfivc6v>
 <4627056f-2ab9-4ff1-bca0-5d80f8f0bbab@linux.dev>
 <ignmsoluhway2yllepl2djcjjaukjijq3ejrlf4uuvh57ru7ur@njkzymuvzfqf>
 <aZUQKx_C3-qyU4PJ@dread>
 <20260218064739.GA8881@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260218064739.GA8881@lst.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-77653-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[anarazel.de,linux.dev,suse.cz,linux.ibm.com,vger.kernel.org,kvack.org,lists.linux-foundation.org,kernel.org,oracle.com,infradead.org,gmail.com,redhat.com,samsung.com,mit.edu];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dgc@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 2EDA215AFC6
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 07:47:39AM +0100, Christoph Hellwig wrote:
> On Wed, Feb 18, 2026 at 12:04:43PM +1100, Dave Chinner wrote:
> > > > > I'd call it RWF_WRITETHROUGH but otherwise it makes sense.
> > > > > 
> > > > 
> > > > One naive question: semantically what will be the difference between
> > > > RWF_DSYNC and RWF_WRITETHROUGH?
> > 
> > None, except that RWF_DSYNC provides data integrity guarantees.
> 
> Which boils down to RWF_DSYNC still writing out the inode and flushing
> the cache.
> 
> > > Which
> > > wouldn't be needed for RWF_WRITETHROUGH, right?
> > 
> > Correct, there shouldn't be any data integrity guarantees associated
> > with plain RWF_WRITETHROUGH.
> 
> Which makes me curious if the plain RWF_WRITETHROUGH would be all
> that useful.

For modern SSDs, I think the answer is yes.

e.g. when you are doing lots of small writes to many files from many
threads, it bottlenecks on single threaded writeback. All of the IO
is submitted by background writeback which runs out of CPU fairly
quickly. We end up dirty throttling and topping out at ~100k random
4kB buffered writes IOPS regardless of how much submitter
concurrency we have.

If we switch that to RWF_WRITETHROUGH, we now have N submitting
threads that can all work in parallel, we get pretty much zero dirty
folio backlog (so no dirty throttling and more consistent IO
latency) and throughput can scales much higher because we have IO
submitter concurrency to spread the CPU load around.

I did a fsmark test of a write-though hack a couple of years back,
creating and writing 4kB data files concurrently in a directory per
thread.  With vanilla writeback, it topped out at about 80k 4kB file
creates/s from 4 threads and only wnet slower the more I increased
the userspace create concurrency.

Using writethrough submission, it topped out at about 400k 4kB file
creates/s from 32 threads and was largely limited in the fsmark
tasks by the CPU overhead for file creation, user data copying and
data extent space allocation.

I also did a multi-file, multi-process random 4kB write test with
fio, using files much larger than memory and long runtimes. Once the
normal background write path started dirty throttling, it ran at
about 100k 4kB write IOPS, again limited by the single threaded writeback
flusher using all it's CPU time for allocating blocks during
writeback.

Using writethrough, I saw about 900k IOPS being sustained right from
the start, largely limited by a combination of CPU usage and IO
latency in the fio task context. In comparison, the same workload
with DIO ran to the storage capability of 1.6M IOPS because it had
significantly lower CPU usage and IO latency.

I also did some kernel compile tests with writethrough for all
buffered write IO. On fast storage there was neglible
difference in performance between vanilla buffered writes and
submitter driver blocking write-through. This result made me
question the need for caching on modern SSDs at all :)

-Dave.
-- 
Dave Chinner
dgc@kernel.org

