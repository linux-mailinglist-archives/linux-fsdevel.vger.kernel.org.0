Return-Path: <linux-fsdevel+bounces-76932-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yICvNC1SjGmukgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76932-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 10:55:57 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E6D1230BA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 10:55:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E075302614F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 09:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4CD36681E;
	Wed, 11 Feb 2026 09:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WlVAYeH2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1u7Y5xHk";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WlVAYeH2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1u7Y5xHk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDE5352958
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Feb 2026 09:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770803741; cv=none; b=XqRT3Rds48CIAXl2woimSfPS7Sk4PzWf5SR7AyJ+GHcq5zbDfO/77JLASABlEQjsOyNLpPhF1wiMXkgCnxCl2E87oas7whG0LFsGct1Ya2R5X+4EvQW9vvRJt8hvvA1FYoFjI9c7WrlHCmRbBolnTGdtrzHjt02m0Qymonr/b+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770803741; c=relaxed/simple;
	bh=M+3eS+0CQ57uJJp31goIB867jpOJ3JZSrh6Hq6ODEDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E3B8GKL6YTD+TygptueVAZGMDcQpYzcfkivFglW+5WqcTfwdm9Mb7YcYHqpw65QpbblTveRXqWPjMOFEG3JUq88KIQLc+ujJc7VrU1nftTlrOlVAHpNLCYhWb2NL2E91KRSI/PdIdBMvqUdozPboU7G6EOyLdsarAajOtVgX7Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WlVAYeH2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1u7Y5xHk; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WlVAYeH2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1u7Y5xHk; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D368C5BD8B;
	Wed, 11 Feb 2026 09:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770803738; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=898l2kNBLwLT/cEDuaztbrg3Plv0whiKcCcpSo3dc/w=;
	b=WlVAYeH2n9GNpytFw++ml+lbeok4zNXE8LFwu3OZl7GVYpNeh1Q4aRlcsywCnQ+t4/5o9Z
	IUuGM0Pe8ZSYqleqs6Qo6qBKrP56HF2RU9QodbBleLbte0oKAbJ43+nv6e+e1tajGJEd6L
	N4Iwp/B4I8RYOV6LO5lFsg7LK4o6CFo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770803738;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=898l2kNBLwLT/cEDuaztbrg3Plv0whiKcCcpSo3dc/w=;
	b=1u7Y5xHkk9EDIq/NEaJ4p17IB/GM2Jnh2PLYPPfWqoGoSw/FnUDiyem+MjccT9n81AKp2p
	CARDiOHPaEGfm1Bw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770803738; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=898l2kNBLwLT/cEDuaztbrg3Plv0whiKcCcpSo3dc/w=;
	b=WlVAYeH2n9GNpytFw++ml+lbeok4zNXE8LFwu3OZl7GVYpNeh1Q4aRlcsywCnQ+t4/5o9Z
	IUuGM0Pe8ZSYqleqs6Qo6qBKrP56HF2RU9QodbBleLbte0oKAbJ43+nv6e+e1tajGJEd6L
	N4Iwp/B4I8RYOV6LO5lFsg7LK4o6CFo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770803738;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=898l2kNBLwLT/cEDuaztbrg3Plv0whiKcCcpSo3dc/w=;
	b=1u7Y5xHkk9EDIq/NEaJ4p17IB/GM2Jnh2PLYPPfWqoGoSw/FnUDiyem+MjccT9n81AKp2p
	CARDiOHPaEGfm1Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BBA223EA64;
	Wed, 11 Feb 2026 09:55:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id S3/KLRpSjGmdbQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 11 Feb 2026 09:55:38 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 755E0A0A4E; Wed, 11 Feb 2026 10:55:34 +0100 (CET)
Date: Wed, 11 Feb 2026 10:55:34 +0100
From: Jan Kara <jack@suse.cz>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "jack@suse.cz" <jack@suse.cz>, 
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>, "chrisl@kernel.org" <chrisl@kernel.org>, 
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, Pavan Rallabhandi <Pavan.Rallabhandi@ibm.com>, 
	"clm@meta.com" <clm@meta.com>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Machine Learning (ML) library in
 Linux kernel
Message-ID: <kw4qco6aq4bq55nmb4c5ibicmj7ga77vtgzlj65jtdhzowks5m@buhefb6m4eqx>
References: <47d21a6821c4b2d085f7b97bcdaa205bfcb0e0ad.camel@ibm.com>
 <CACePvbVH0ovOcBqCN7kJ3n0QFmvuf+_5tMeRXs-JAQ+m5fdoCg@mail.gmail.com>
 <a994bdedca7d966168076044249a58e52754c6ac.camel@ibm.com>
 <6ek3nhulz72niscw2iz2n5xhczz4ta6a6hvyrlneuyk2d36ngx@4ymlemzifugr>
 <11f659fd88f887b9fe4c88a386f1a5c2157968a6.camel@ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11f659fd88f887b9fe4c88a386f1a5c2157968a6.camel@ibm.com>
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email];
	DMARC_NA(0.00)[suse.cz];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-76932-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.cz:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
X-Rspamd-Queue-Id: 77E6D1230BA
X-Rspamd-Action: no action

On Tue 10-02-26 21:02:12, Viacheslav Dubeyko wrote:
> On Tue, 2026-02-10 at 14:47 +0100, Jan Kara wrote:
> > On Mon 09-02-26 22:28:59, Viacheslav Dubeyko via Lsf-pc wrote:
> > > The idea is to have ML model running in user-space and kernel subsystem can
> > > interact with ML model in user-space. As the next step, I am considering two
> > > real-life use-cases: (1) GC subsystem of LFS file system, (2) ML-based DAMON
> > > approach. So, for example, GC can be represented by ML model in user-space. GC
> > > can request data (segments state) from kernel-space and ML model in user-space
> > > can do training or/and inference. As a result, ML model in user-space can select
> > > victim segments and instruct kernel-space logic of moving valid data from victim
> > > segment(s) into clean/current one(s). 
> > 
> > To be honest I'm skeptical about how generic this can be. Essentially
> > you're describing a generic interface to offload arbitrary kernel decision
> > to userspace. ML is a userspace bussiness here and not really relevant for
> > the concept AFAICT. And we already have several ways of kernel asking
> > userspace to do something for it and unless it is very restricted and well
> > defined it is rather painful, prone to deadlocks, security issues etc.
> 
> Scepticism is normal reaction. :) So, nothing wrong is to be sceptical.
> 
> I believe it can be pretty generic from the data flow point of view. Probably,
> different kernel subsystems could require different ways of interaction with
> user-space. However, if we are talking about data flow but NOT execution flow,
> then it could be generic enough. And if it can be generic, then we can suggest
> generic way of extending any kernel subsystem by ML support.
> 
> I don't think that we need to consider the ML library appraoch like "kernel
> asking userspace to do something". Rather it needs to consider the model like
> "kernel share data with user-space and user-space recommends something to
> kernel". So, user-space agent (ML model) can request data from kernel space or
> kernel subsystem can notify the user-space agent that data is available. And
> it's up to kernel subsystem implementation which data could be shared with user-
> space. So, ML model can be trained in user-space and, then, share
> recommendations (or eBPF code, for example) with kernel space. Finally, it's up
> to kernel subsystem how and when to apply these recommendations on kernel side.

I guess I have to see some examples. Because so far it sounds so generic
that I'm failing to see a value in this :)

> > So by all means if you want to do GC decisions for your filesystem in
> > userspace by ML, be my guest, it does make some sense although I'd be wary
> > of issues where we need to writeback dirty pages to free memory which may
> > now depend on your userspace helper to make a decision which may need the
> > memory to do the decision... But I don't see why you need all the ML fluff
> > around it when it seems like just another way to call userspace helper and
> > why some of the existing methods would not suffice.
> > 
> 
> OK. I see. :) You understood GC like a subsystem that helps to kernel
> memory subsystem to manage the writeback dirty memory pages. :) It's
> potential direction and I like your suggestion. :) But I meant something
> different because I consider of LFS file system's GC subsystem. So, if we
> are using Copy-On-Write (COW) policy, then we have segments or erase
> blocks with a mixture of valid and invalid logical blocks after update
> operations. And we need GC subsystem to clean old segments by means of
> moving valid logical blocks from exhausted segments into clean/current
> ones. The problem here is to find an efficient algorithm of selecting
> victim segments with smallest amount of valid blocks with the goal of
> decreasing write amplification. So, file system needs to share the
> metadata details (segments state, for example), ML model can share the
> recommendations, and kernel code of file system can finally move valid
> blocks in the background.

No, I actually meant the LFS file system GC as you talk about it. But I was
just too terse about my concerns: As you said an LFS with COW needs to
select a new position to write each block. When there is no free block
available, it has to select partially used erase block (some logical blocks
in it became invalid) to reuse. And for this selection you want to use ML
AFAIU. Hence we have a dependency folio writeback -> COW block allocation ->
GC to make some block free -> ML decision. And now you have to be really
careful so that "ML decision" doesn't even indirectly depend on folio
writeback to complete. And bear in mind that e.g. if the code doing "ML
decision" dirties some mmaped file pages it *will* block waiting for page
writeback to complete to get the system below the limit of dirty pages.
This is the kind of deadlock I'm talking about that is hard to avoid when
offloading kernel decisions to userspace (and yes, I've seen these kind of
deadlocks in practice in various shapes and forms with various methods when
kernel depended on userspace to make forward progress).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

