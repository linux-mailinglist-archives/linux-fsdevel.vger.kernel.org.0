Return-Path: <linux-fsdevel+bounces-77268-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CB6PNhTtkmml0AEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77268-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 11:10:28 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D8C1423F0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 11:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE7C2301C155
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 10:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BED92FCBE5;
	Mon, 16 Feb 2026 10:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="C3qQwCQ5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VOYla/Ri";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gfX3t3sX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tFI/63PV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D872F744A
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Feb 2026 10:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771236605; cv=none; b=pdbBwWs3EcCqIF6DJ+MEfmEvyw2ujX7waPZvlPRntWa9J5AvlY9ofCIN31M84NM0+8qwKg0hEWQc/T19dcNdLzxQ35P59UONEUDWOj7r16iiYrrIJN/o8T0cPXhvtxbeDiPzWizUPajgPIowXyG/AgKz+CFjXJbB1qQX9MdwOtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771236605; c=relaxed/simple;
	bh=wRAFwqbAt0UjKRNKy36uPRYgKoaVVQSeBUt7EvD6UOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XsorwhEODl6SA7oNtkoGfdVDtsS77vgWuuN72BaBunxD1+T+Q627XNM7QTFW5HqUzPzlbOiBXYAlfiaesmEGuPxc5u8Djo+dblonS/z9XLjZMqg7e2R/XHwip+Bxnd+pgDXs4PAFjim1ZIgTLmQIAWEE6DrzX3YiX6JyE26ertI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=C3qQwCQ5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VOYla/Ri; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gfX3t3sX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tFI/63PV; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 747505BCC4;
	Mon, 16 Feb 2026 10:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1771236602; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7lSSTT9W7EnOu03evGDVlDH3HtveihAlEwuA9eL1wP8=;
	b=C3qQwCQ5u+joy0//SJgWoiA5UmhQvqmN3ygD3rkf1Qm+n5R0NrGyZQxj9+n/xyhUaeGc5E
	VnegKvag+zPf76dV8rrujqFSdAgOdDx0bIjAfM8MAX9IWQrwO+aZcNXJby/Sacazf3vUqH
	NCrma+YUOj79unXBZ0AnouCSzPWgtf4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1771236602;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7lSSTT9W7EnOu03evGDVlDH3HtveihAlEwuA9eL1wP8=;
	b=VOYla/RiDuKouHeETuTeP4M1zZBb5ON1B1GaTTzafz6wEuGDs/D9zF+cBJ9NjEvVtzVbb0
	1JSpfQhbo2DJhNDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=gfX3t3sX;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="tFI/63PV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1771236601; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7lSSTT9W7EnOu03evGDVlDH3HtveihAlEwuA9eL1wP8=;
	b=gfX3t3sXuXX1C1BLSkWE2ATOUI9umOCgD6O/lpF6rnPNXdSq3TpDvISm23waq5139KqzqI
	c4DGBwIsq2MaHXWEBEJzXOjqkLlFsOanG8wyzmsD2d38m02RnNylVoHgvzasIcjlhiVDZm
	35Y0ekp9NAsJTzDfJ9fCvnzSa5ZKsHo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1771236601;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7lSSTT9W7EnOu03evGDVlDH3HtveihAlEwuA9eL1wP8=;
	b=tFI/63PVd044AznU39aacdwLGhJiPZgAe2poZcoBjSb1fmLd3QzAt4Jzn3VnmHJJyXB2t1
	xqiUqk6Uj2Bv27DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 59DCA3EA62;
	Mon, 16 Feb 2026 10:10:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Q4HoFfnskmkrJAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 16 Feb 2026 10:10:01 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 01608A0AA5; Mon, 16 Feb 2026 11:10:00 +0100 (CET)
Date: Mon, 16 Feb 2026 11:10:00 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Josef Bacik <josef@toxicpanda.com>, 
	Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, Hans Holmberg <Hans.Holmberg@wdc.com>, 
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	Damien Le Moal <Damien.LeMoal@wdc.com>, hch <hch@lst.de>, Naohiro Aota <Naohiro.Aota@wdc.com>, 
	"jack@suse.com" <jack@suse.com>, Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] A common project for file system
 performance testing
Message-ID: <5lk2kolr3ntrbma3dw4qtq7lmxlu2ghdf2mavt5fu4cuuo3f2h@fztn6lesv6qb>
References: <b9f6cd20-8f0f-48d6-9819-e0c915206a3f@wdc.com>
 <bcedbc03-c307-4de5-9973-94237f05cd85@wdc.com>
 <CAEzrpqd_-V691dQzVF1WmrvLNXnDR0THuxGCieDMZcWdRN5WEQ@mail.gmail.com>
 <CAOQ4uxia_BDVOLLnuN=OzhpUYBdFkd10T+079h7+PjHXkt208w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxia_BDVOLLnuN=OzhpUYBdFkd10T+079h7+PjHXkt208w@mail.gmail.com>
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.cz:dkim,suse.com:email,wdc.com:email];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-77268-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 45D8C1423F0
X-Rspamd-Action: no action

On Thu 12-02-26 18:37:22, Amir Goldstein wrote:
> On Thu, Feb 12, 2026 at 7:32 PM Josef Bacik <josef@toxicpanda.com> wrote:
> > On Thu, Feb 12, 2026 at 11:42 AM Johannes Thumshirn
> > <Johannes.Thumshirn@wdc.com> wrote:
> > >
> > > On 2/12/26 2:42 PM, Hans Holmberg wrote:
> > > > Hi all,
> > > >
> > > > I'd like to propose a topic on file system benchmarking:
> > > >
> > > > Can we establish a common project(like xfstests, blktests) for
> > > > measuring file system performance? The idea is to share a common base
> > > > containing peer-reviewed workloads and scripts to run these, collect and
> > > > store results.
> > > >
> > > > Benchmarking is hard hard hard, let's share the burden!
> > >
> > > Definitely I'm all in!
> > >
> > > > A shared project would remove the need for everyone to cook up their
> > > > own frameworks and help define a set of workloads that the community
> > > > cares about.
> > > >
> > > > Myself, I want to ensure that any optimizations I work on:
> > > >
> > > > 1) Do not introduce regressions in performance elsewhere before I
> > > >     submit patches
> > > > 2) Can be reliably reproduced, verified, and regression‑tested by the
> > > >     community
> > > >
> > > > The focus, I think, would first be on synthetic workloads (e.g. fio)
> > > > but it could expanded to running application and database workloads
> > > > (e.g. RocksDB).
> > > >
> > > > The fsperf[1] project is a python-based implementation for file system
> > > > benchmarking that we can use as a base for the discussion.
> > > > There are probably others out there as well.
> > > >
> > > > [1] https://github.com/josefbacik/fsperf
> > >
> > > I was about to mention Josef's fsperf project. We also used to have some
> > > sort of a dashboard for fsperf results for BTRFS, but that vanished
> > > together with Josef.
> > >
> > > A common dashboard with per workload statistics for different
> > > filesystems would be a great thing to have, but for that to work, we'd
> > > need different hardware and probably the vendors of said hardware to buy
> > > in into it.
> > >
> > > For developers it would be a benefit to see eventual regressions and
> > > overall weak points, for users it would be a nice tool to see what FS to
> > > pick for what workload.
> > >
> > > BUT someone has to do the job setting everything up and maintaining it.
> > >
> >
> > I'm still here, the dashboard disappeared because the drives died, and
> > although the history is interesting it didn't seem like we were using
> > it much. The A/B testing part of fsperf still is being used regularly
> > as far as I can tell.
> >
> > But yeah maintaining a dashboard is always the hardest part, because
> > it means setting up a website somewhere and a way to sync the pages.
> > What I had for fsperf was quite janky, basically I'd run it every
> > night, generate the new report pages, and scp them to the VPS I had.
> > With Claude we could probably come up with a better way to do this
> > quickly, since I'm clearly not a web developer. That being said we
> > still have to have someplace to put it, and have some sort of hardware
> > that runs stuff consistently.
> >
> 
> That's the main point IMO.
> 
> Perf regression tests must rely on consistent hardware setups.
> If we do not have organizations to fund/donate this hardware and put in
> the engineering effort to drive it, talking about WHAT to run in LSFMM
> is useless IMO.

My dayjob is watching kernel performance for our distro so I feel a bit
obliged to share my view :) I agree the problem here isn't the lack of
tools. We use mmtests as a suite for benchmarking - since that is rather
generic suite for running benchmarks with quite some benchmark integrated
the learning curve is relatively steep but once you get a hunch of it it
isn't difficult to use. Fsperf is IMO also fine to use if you are fine with
the limited benchmarking it can do. This isn't the hard part - anyone can
download these suites and run them.

The hard part on benchmarking is having sensible hardware to run the test
on, selecting a benchmark and setup that's actually exercising the code
you're interested in, and getting statistically significant results (i.e.,
discerning random noise from real differences). And these are things that
are difficult to share or solve by discussion.

As others wrote one solution to this is if someone dedicates the hardware
and engineers with know-how for this. But realistically I don't see that
happening in the nearterm. There might be other solutions how to share more
- like sharing a VM with preconfigured set of benchmarks covering the
basics (similarly to some people sharing VM images with preconfigured
fstests runs). But I don't have a clear picture how much such thing would
help.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

