Return-Path: <linux-fsdevel+bounces-23250-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B6A928F05
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 23:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B23CC1F2369B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 21:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC921482F4;
	Fri,  5 Jul 2024 21:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="00TMuRlC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5Zpnp462";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="00TMuRlC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5Zpnp462"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EA91C693;
	Fri,  5 Jul 2024 21:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720216635; cv=none; b=Q57rZ0wuVF5axYN93uYlEWHrSaOqw+V87qbrhFQdlSxUbHqB9xoZ2xtLYy2g04OchIqXjrM2l5YcSRiNuIuM2iYU73KHHBhfsGT7SqTjxj9YEI9lxYyOfm+ja01rHaX4bpKoEstP9P2XuulIQiwDexa3vKdmLmQPmEPMG2sp0nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720216635; c=relaxed/simple;
	bh=qWctCeykHXVGevyTX3yh3kWx21Nr5C0VmCbjlDmOuiE=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=kgpvW00pfCpAhKsinpQKNOX28BSMjfTxBMIWcZeoUjuzp4Wn3CpT8tIu4QE+K4EZs414tux7AMmbobelTIjnrMMw7gZYzdG0HqX2LiPpVIc7+QYuimmunJViCQiU1DD7lDD1ZpWPWagUf40js1ZQeD++kWq6aSvtLQRD6GFx85o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=00TMuRlC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5Zpnp462; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=00TMuRlC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5Zpnp462; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 75BCB21AFB;
	Fri,  5 Jul 2024 21:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720216632; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RSGOIb2Wl+HBdUqrgvUr+NI1oLOGcZ/3rSbXdn1D168=;
	b=00TMuRlCon0h0UU44PZtmugrfr+ezc99LQlM4NZYpQVymxwo2kuvd9u/MBZllPA1Uak3kv
	zepKuH+CnZSnMg6VNOxVJuwABBbW02Pb2QnXJLGHVnuYpsvKpFZ+APuEJAxBKXSGhFE5AG
	mKMZwKI2bna5hESGYa+SBDPd/dNCS1s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720216632;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RSGOIb2Wl+HBdUqrgvUr+NI1oLOGcZ/3rSbXdn1D168=;
	b=5Zpnp4629TahN6qcVI2xLLQA0YAnMFxA365wrJZ+CPMIi84s3errQwRBybIqm6mQV8rYxu
	A7mFtg8TzJrIkbAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720216632; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RSGOIb2Wl+HBdUqrgvUr+NI1oLOGcZ/3rSbXdn1D168=;
	b=00TMuRlCon0h0UU44PZtmugrfr+ezc99LQlM4NZYpQVymxwo2kuvd9u/MBZllPA1Uak3kv
	zepKuH+CnZSnMg6VNOxVJuwABBbW02Pb2QnXJLGHVnuYpsvKpFZ+APuEJAxBKXSGhFE5AG
	mKMZwKI2bna5hESGYa+SBDPd/dNCS1s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720216632;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RSGOIb2Wl+HBdUqrgvUr+NI1oLOGcZ/3rSbXdn1D168=;
	b=5Zpnp4629TahN6qcVI2xLLQA0YAnMFxA365wrJZ+CPMIi84s3errQwRBybIqm6mQV8rYxu
	A7mFtg8TzJrIkbAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 239F113889;
	Fri,  5 Jul 2024 21:57:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1cvKLTRsiGbPDgAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 05 Jul 2024 21:57:08 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Chuck Lever III" <chuck.lever@oracle.com>
Cc: "Christoph Hellwig" <hch@infradead.org>,
 "Mike Snitzer" <snitzer@kernel.org>, "Jeff Layton" <jlayton@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>,
 "Trond Myklebust" <trondmy@hammerspace.com>,
 "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>,
 "Linux FS Devel" <linux-fsdevel@vger.kernel.org>
Subject: Re: Security issue in NFS localio
In-reply-to: <297447D0-AEFF-44EB-A17B-1B66931C5AFE@oracle.com>
References: <>, <297447D0-AEFF-44EB-A17B-1B66931C5AFE@oracle.com>
Date: Sat, 06 Jul 2024 07:56:57 +1000
Message-id: <172021661746.11489.14244273828509105229@noble.neil.brown.name>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 

On Fri, 05 Jul 2024, Chuck Lever III wrote:
> 
> 
> > On Jul 5, 2024, at 9:45 AM, Christoph Hellwig <hch@infradead.org> wrote:
> > 
> > On Thu, Jul 04, 2024 at 07:00:23PM +0000, Chuck Lever III wrote:
> >>> 3/ The current code uses the 'struct cred' of the application to look up
> >>>  the file in the server code.  When a request goes over the wire the
> >>>  credential is translated to uid/gid (or krb identity) and this is
> >>>  mapped back to a credential on the server which might be in a
> >>>  different uid name space (might it?  Does that even work for nfsd?)
> >>> 
> >>>  I think that if rootsquash or allsquash is in effect the correct
> >>>  server-side credential is used but otherwise the client-side
> >>>  credential is used.  That is likely correct in many cases but I'd
> >>>  like to be convinced that it is correct in all case.  Maybe it is
> >>>  time to get a deeper understanding of uid name spaces.
> >> 
> >> I've wondered about the idmapping issues, actually. Thanks
> >> for bringing that up. I think Christian and linux-fsdevel
> >> need to be involved in this conversation; added.
> > 
> > There is a lot more issues than just idmapping.  That's why I don't
> > think the current approach where the open is executed in the client
> > can work.  The right way is to ensure the open always happens in and
> > nfsd thread context which just pases the open file to client for doing
> > I/O.
> 
> I have considered that approach, but I don't yet have a clear
> enough understanding of the idmapping issues to say whether
> it is going to be necessary.

I can't see that nfsd pays any attention to uid namespaces.  I think it
always uses the init_ns.  So we would need to ensure the client
credential was interpreted against the init namespace.  I still have
made time to understand what this means in practice.

> 
> Just in terms of primitives, the server has svc_wake_up() which
> can enqueue non-transport work on an nfsd thread. Question then
> is what is the form of the response -- how does it get back
> to the "client" side.

I think it would be quite easy to establish a new work-queue (lwq?) that
clients can attach a request structure too before calling svc_wake_up(),
and which the nfsd thread would examine after svc_recv() returns.

This request structure would include the filehandle, credential,
possible other context, place to store the result, and a completion.
The server thread would complete the completion and the client, after
queuing the request, would wait for the completion.

So: easy enough to do if it turns out to be necessary.

NeilBrown


> 
> 
> --
> Chuck Lever
> 
> 
> 


