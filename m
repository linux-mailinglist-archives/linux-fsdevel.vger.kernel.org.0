Return-Path: <linux-fsdevel+bounces-77013-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2IhBIaCzjWlz6AAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77013-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 12:04:00 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D80B412CCFE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 12:03:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B460C30B679B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 11:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3620B344D8D;
	Thu, 12 Feb 2026 11:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CKZBWm8g";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QPqh6P6Z";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tl2aKaf0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fM9MzJ96"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8C5319614
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Feb 2026 11:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770894165; cv=none; b=cFAdwtGgFxuC/pcz4e4MDXP2aQikJk/Ds1TMNmqm19vddD0nvU8J/usGfPIUAoDLe7PgZ1ZJ472bINf8HxGemy4Et8EsTrz9KZ+hssYdv6QqMgPi+Y6K8hpd2SbtT0+MvHcOELbO+ITNqAyiQI6mLrDklTPYEoWjs45T+M8U8M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770894165; c=relaxed/simple;
	bh=i77wWooCujq5tieK+1tRLqSV0Wr3OTPz2Eji3J5gXpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r4oQ98vW0hjRynuPgl/xo5C+ovRdv/vCnazFkWyd56fuF145z60y1DqkDi2pAILfN3axKTw7STwNAzrcq66hmNKFzfmyYT/YAkkakaFlzsWh+9HAiyQQwRhIZ8RT8aI4YrzGcGdMJjZ4gDh0eu8g41tNyc7eg08DsUl3dXH/HtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CKZBWm8g; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QPqh6P6Z; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tl2aKaf0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fM9MzJ96; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 392305BCDB;
	Thu, 12 Feb 2026 11:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770894162; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V5ki3VpM/PV+cZ6RG3yRe/SDubTdcojLAG3quUdyYrU=;
	b=CKZBWm8grgTT8N58oF5u5o6t7OaHAJU6cvkFDNluJVI87Kw38qMZSR5iojR9OCznm5vkCY
	QoLyiFAdTcaTHdpmZ7k76kLiVlNr9+by7gnUeuu2o6paFuBo6K+e2yX/Bj1UAN9dR78caL
	3lF2/q7LA4tD3BIjBJhbilqTHbdRGQo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770894162;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V5ki3VpM/PV+cZ6RG3yRe/SDubTdcojLAG3quUdyYrU=;
	b=QPqh6P6ZxdHTfecuo1UIEEy5hHgfwES1TQli6CFXE0l0gbIaT7DRWhkG4BLp59NvlsDUtR
	0+A9104rGBvOoUDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770894158; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V5ki3VpM/PV+cZ6RG3yRe/SDubTdcojLAG3quUdyYrU=;
	b=tl2aKaf0IveSXSACjraG8IuYD8S2kEGmSxP10LmVvmFp8YdZNkmQ/+6hwu3ZH3If5jb8qq
	MoMnYHNcX7ONlxVlX202K6tCkp1LefxBioBX4zrth+mSKOJ7g65ZMEQMJp72vAs4nGoMLD
	2WkmVnww9efxJKR0fZe73hx/UnzYRLo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770894158;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V5ki3VpM/PV+cZ6RG3yRe/SDubTdcojLAG3quUdyYrU=;
	b=fM9MzJ96QdAhm/OqdPhaI8ciMiKpj2qbp/94Do/qu+q3u/iMBuzYh5m4iR6gDnn0L/u43Z
	9fEonAWatfTm2uDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 20BB13EA62;
	Thu, 12 Feb 2026 11:02:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ms34B06zjWmRRwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 12 Feb 2026 11:02:38 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D8AD7A0A4C; Thu, 12 Feb 2026 12:02:29 +0100 (CET)
Date: Thu, 12 Feb 2026 12:02:29 +0100
From: Jan Kara <jack@suse.cz>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "jack@suse.cz" <jack@suse.cz>, 
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>, "chrisl@kernel.org" <chrisl@kernel.org>, 
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "clm@meta.com" <clm@meta.com>, 
	Pavan Rallabhandi <Pavan.Rallabhandi@ibm.com>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Machine Learning (ML) library in
 Linux kernel
Message-ID: <ie7tiefeq4x4u445vois6bgkhfmynuf3z5no24h4o4b3lirrmf@s5yxc6z4jvpy>
References: <47d21a6821c4b2d085f7b97bcdaa205bfcb0e0ad.camel@ibm.com>
 <CACePvbVH0ovOcBqCN7kJ3n0QFmvuf+_5tMeRXs-JAQ+m5fdoCg@mail.gmail.com>
 <a994bdedca7d966168076044249a58e52754c6ac.camel@ibm.com>
 <6ek3nhulz72niscw2iz2n5xhczz4ta6a6hvyrlneuyk2d36ngx@4ymlemzifugr>
 <11f659fd88f887b9fe4c88a386f1a5c2157968a6.camel@ibm.com>
 <kw4qco6aq4bq55nmb4c5ibicmj7ga77vtgzlj65jtdhzowks5m@buhefb6m4eqx>
 <224ceff96f02288f9cd660348b722335b0e9eaf3.camel@ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <224ceff96f02288f9cd660348b722335b0e9eaf3.camel@ibm.com>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email,suse.cz:dkim];
	DMARC_NA(0.00)[suse.cz];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-77013-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.cz:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D80B412CCFE
X-Rspamd-Action: no action

On Thu 12-02-26 00:53:37, Viacheslav Dubeyko wrote:
> On Wed, 2026-02-11 at 10:55 +0100, Jan Kara wrote:
> > On Tue 10-02-26 21:02:12, Viacheslav Dubeyko wrote:
> > > On Tue, 2026-02-10 at 14:47 +0100, Jan Kara wrote:
> > > > On Mon 09-02-26 22:28:59, Viacheslav Dubeyko via Lsf-pc wrote:
> > > > > The idea is to have ML model running in user-space and kernel subsystem can
> > > > > interact with ML model in user-space. As the next step, I am considering two
> > > > > real-life use-cases: (1) GC subsystem of LFS file system, (2) ML-based DAMON
> > > > > approach. So, for example, GC can be represented by ML model in user-space. GC
> > > > > can request data (segments state) from kernel-space and ML model in user-space
> > > > > can do training or/and inference. As a result, ML model in user-space can select
> > > > > victim segments and instruct kernel-space logic of moving valid data from victim
> > > > > segment(s) into clean/current one(s). 
> > > > 
> > > > To be honest I'm skeptical about how generic this can be. Essentially
> > > > you're describing a generic interface to offload arbitrary kernel decision
> > > > to userspace. ML is a userspace bussiness here and not really relevant for
> > > > the concept AFAICT. And we already have several ways of kernel asking
> > > > userspace to do something for it and unless it is very restricted and well
> > > > defined it is rather painful, prone to deadlocks, security issues etc.
> > > 
> > > Scepticism is normal reaction. :) So, nothing wrong is to be sceptical.
> > > 
> > > I believe it can be pretty generic from the data flow point of view. Probably,
> > > different kernel subsystems could require different ways of interaction with
> > > user-space. However, if we are talking about data flow but NOT execution flow,
> > > then it could be generic enough. And if it can be generic, then we can suggest
> > > generic way of extending any kernel subsystem by ML support.
> > > 
> > > I don't think that we need to consider the ML library appraoch like "kernel
> > > asking userspace to do something". Rather it needs to consider the model like
> > > "kernel share data with user-space and user-space recommends something to
> > > kernel". So, user-space agent (ML model) can request data from kernel space or
> > > kernel subsystem can notify the user-space agent that data is available. And
> > > it's up to kernel subsystem implementation which data could be shared with user-
> > > space. So, ML model can be trained in user-space and, then, share
> > > recommendations (or eBPF code, for example) with kernel space. Finally, it's up
> > > to kernel subsystem how and when to apply these recommendations on kernel side.
> > 
> > I guess I have to see some examples. Because so far it sounds so generic
> > that I'm failing to see a value in this :)
> 
> I completely see your point. And I am not going to push anything abstract
> one. I am going to implement ML-based approach for several real-life
> use-cases. So, I will have something real or I will fail. :)

OK, good then :)

> > > > So by all means if you want to do GC decisions for your filesystem in
> > > > userspace by ML, be my guest, it does make some sense although I'd be wary
> > > > of issues where we need to writeback dirty pages to free memory which may
> > > > now depend on your userspace helper to make a decision which may need the
> > > > memory to do the decision... But I don't see why you need all the ML fluff
> > > > around it when it seems like just another way to call userspace helper and
> > > > why some of the existing methods would not suffice.
> > > > 
> > > 
> > > OK. I see. :) You understood GC like a subsystem that helps to kernel
> > > memory subsystem to manage the writeback dirty memory pages. :) It's
> > > potential direction and I like your suggestion. :) But I meant something
> > > different because I consider of LFS file system's GC subsystem. So, if we
> > > are using Copy-On-Write (COW) policy, then we have segments or erase
> > > blocks with a mixture of valid and invalid logical blocks after update
> > > operations. And we need GC subsystem to clean old segments by means of
> > > moving valid logical blocks from exhausted segments into clean/current
> > > ones. The problem here is to find an efficient algorithm of selecting
> > > victim segments with smallest amount of valid blocks with the goal of
> > > decreasing write amplification. So, file system needs to share the
> > > metadata details (segments state, for example), ML model can share the
> > > recommendations, and kernel code of file system can finally move valid
> > > blocks in the background.
> > 
> > No, I actually meant the LFS file system GC as you talk about it. But I was
> > just too terse about my concerns: As you said an LFS with COW needs to
> > select a new position to write each block. When there is no free block
> > available, it has to select partially used erase block (some logical blocks
> > in it became invalid) to reuse.
> > 
> 
> I assume that you imply F2FS here. Because, I cannot imagine how LFS file system
> (like NILFS2) can do something like this. If it's LFS file system, then you add
> logs into the current segment(s). Even if some logical blocks have been
> invalidated into this segment, then you add another log into the head/tail of
> current segment until complete exhaustion of it. And it needs to allocate the
> completely clean/free segment to be current and receive the logs. So, you need
> to take completely exhausted segment for cleaning by GC. If you have pure COW
> file system, then you cannot write anything in likewise segment until complete
> invalidation + "erase"/clean. So, GC moves valid blocks from completely
> exhausted segment into the current one(s). It's responsibility of GC to
> guarantee that file system is not running out of free physical space if file
> system still has free logical blocks. And if we are running out free physical
> space, then operation stops because of GC failure to keep enough clean segments.

Well, details of different filesystem designs are different but they all
have the common feature that on an aged filesystem you need GC to do work
to be able to write as much as you are supposed to be able to write.

> >  And for this selection you want to use ML
> > AFAIU. Hence we have a dependency folio writeback -> COW block allocation ->
> > GC to make some block free -> ML decision.
> 
> Usually, GC works in the background. So, ML model in user-space get
> segments state metadata from file system. Then, it selects one or several
> segments and recommends to file system of moving valid blocks for the
> selected segment(s) ID + maximal amount of valid blocks for single
> operation. Background process of file system checks that these logical
> blocks of exhausted segment are still valid and initiates operation of
> moving into the current segment by adding another log.

Sure, background operation is the easy case. I'm speaking about the
situation where the filesystem is under such write pressure that GC cannot
keep up and all the write activity is basically blocked waiting for GC to
make forward progress. And again details for different filesystems differ
but all have this property that the speed of GC is one of the limiting
factors for writes when the filesystem is aged enough and the write
pressure is large enough. And the point I'm trying to get across is that
under such pressure consulting userspace for GC decisions is likely to
cause deadlocks. So you will have to have some in-kernel fallbacks to avoid
such deadlocks and logic for triggering these fallbacks to guarantee
forward progress of GC which all gets kind of hairy.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

