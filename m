Return-Path: <linux-fsdevel+bounces-76913-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CKpsMbzQi2lnbgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76913-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 01:43:40 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4761205C0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 01:43:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8DECF305F22D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 00:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054BB21C16A;
	Wed, 11 Feb 2026 00:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="AOLKUp3X";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9vLzqElT";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="AOLKUp3X";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9vLzqElT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C07720298D
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Feb 2026 00:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770770606; cv=none; b=iSwM/OS+I08ctXuoRUJz4JSfSYqcLjLeTlBZHuBBsNr4r5arT7jNSakzu2q9Vo45VO33qfwnCXrz4kJ/gT5uy051ktUIl1sR0OOb369uIzE0mZe1dJRfEjpvk26rNl1S7truqb/3cS4tAR0YSlpfkYmqxDdvvVcI9KfGc69e1T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770770606; c=relaxed/simple;
	bh=mG4MoawlAE0bX5AP81/HLw4cDoVMpAoVv+CRl7usypM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t34W627coClpbqSwSsudZPDv5unCvXWYp9y6SVOL8VBIHqJ3j1obu4UEnev3a09sK62e/cTSkvrDPmwSoBAbXw72Z4M8M5OlEo+j1SwVRVI+eeD6w6miMexa0coWutApYfPPYu4gBJdiA0qSMf1zvdgFFlKAQ5tN4AFjg1g4b68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=AOLKUp3X; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9vLzqElT; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=AOLKUp3X; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9vLzqElT; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 607455BD8A;
	Wed, 11 Feb 2026 00:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770770602; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wMpSLOQn6ull4eZMjpV1MgQ9RMuI6ZyLiVkt0V9KnJ0=;
	b=AOLKUp3XThCg5htMZkn5KbEl8jeUMPp6qZ+/xl/sbxbRdF8FVIID4QfyiGja5FzfiIvGwT
	Q2rROrPQ51xuxPkMoQ2AjOJupmowTNf8CKiW2tIYvrTUBpOvt6KdoFdezZp+TMMznlguvF
	P6AYINHGd4sdaIebpK7/aYJEs3/QvsM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770770602;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wMpSLOQn6ull4eZMjpV1MgQ9RMuI6ZyLiVkt0V9KnJ0=;
	b=9vLzqElTYIaGAnbPW/b1+UJibwnW8T2gevvzDvB80gtHewPIt8zJB3xb+YN8prEtmBTyDQ
	IZkkQCP0N4IzqSAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=AOLKUp3X;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=9vLzqElT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770770602; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wMpSLOQn6ull4eZMjpV1MgQ9RMuI6ZyLiVkt0V9KnJ0=;
	b=AOLKUp3XThCg5htMZkn5KbEl8jeUMPp6qZ+/xl/sbxbRdF8FVIID4QfyiGja5FzfiIvGwT
	Q2rROrPQ51xuxPkMoQ2AjOJupmowTNf8CKiW2tIYvrTUBpOvt6KdoFdezZp+TMMznlguvF
	P6AYINHGd4sdaIebpK7/aYJEs3/QvsM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770770602;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wMpSLOQn6ull4eZMjpV1MgQ9RMuI6ZyLiVkt0V9KnJ0=;
	b=9vLzqElTYIaGAnbPW/b1+UJibwnW8T2gevvzDvB80gtHewPIt8zJB3xb+YN8prEtmBTyDQ
	IZkkQCP0N4IzqSAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A69993EA62;
	Wed, 11 Feb 2026 00:43:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HqgVF6fQi2kcKAAAD6G6ig
	(envelope-from <ddiss@suse.de>); Wed, 11 Feb 2026 00:43:19 +0000
Date: Wed, 11 Feb 2026 11:43:10 +1100
From: David Disseldorp <ddiss@suse.de>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>,
 Dmitry Safonov <0x7f454c46@gmail.com>, linux-kbuild@vger.kernel.org,
 linux-kernel@vger.kernel.org, "linux-fsdevel@vger.kernel.org"
 <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC PATCH] initramfs: correctly handle space in path on cpio
 list generation
Message-ID: <20260211113308.4c5b0b82.ddiss@suse.de>
In-Reply-To: <698b6ced.050a0220.9e34a.3e08@mx.google.com>
References: <20260209153800.28228-1-ansuelsmth@gmail.com>
	<20260210223431.6bf63673.ddiss@suse.de>
	<698b6ced.050a0220.9e34a.3e08@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -3.51
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76913-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ddiss@suse.de,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.de:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7E4761205C0
X-Rspamd-Action: no action

On Tue, 10 Feb 2026 18:37:44 +0100, Christian Marangi wrote:
...
> > > diff --git a/usr/gen_init_cpio.c b/usr/gen_init_cpio.c
> > > index b7296edc6626..ca5950998841 100644
> > > --- a/usr/gen_init_cpio.c
> > > +++ b/usr/gen_init_cpio.c
> > > @@ -166,7 +166,7 @@ static int cpio_mkslink_line(const char *line)
> > >  	int gid;
> > >  	int rc = -1;
> > >  
> > > -	if (5 != sscanf(line, "%" str(PATH_MAX) "s %" str(PATH_MAX) "s %o %d %d", name, target, &mode, &uid, &gid)) {
> > > +	if (5 != sscanf(line, "\"%" str(PATH_MAX) "[^\"]\" \"%" str(PATH_MAX) "[^\"]\" %o %d %d", name, target, &mode, &uid, &gid)) {  
> > 
> > This breaks parsing of existing manifest files, so is unacceptable
> > IMO. If we really want to go down the route of having gen_init_cpio
> > support space-separated paths, then perhaps a new --field-separator
> > parameter might make sense. For your specific workload it seems that
> > simply using an external cpio archiver with space support (e.g. GNU
> > cpio --null) would make sense. Did you consider going down that
> > path?
> >   
> 
> This is mostly why this is posted as RFC. I honestly wants to fix this in the
> linux tool instead of using external tools.
> 
> So is there an actual use of manually passing the cpio list instead of
> generating one with the script? (just asking not saying that there isn't one)

Absolutely. As a simple example, consider an unprivileged user wishing
to add a device node to their initramfs image. A manifest entry (as
opposed to staging area mknod=EPERM) is ideal for this.

> One case I have (the scenario here is OpenWrt) is when a base cpio_list is
> provided and then stuff is appended to it.
> 
> In such case yes there is a problem since the format changed.
> 
> My solution to this would be introduce new type that will have the new pattern.
> This way we can keep support for the old list and still handle whitespace files.
> 
> An idea might be to have the file type with capital letter to differenciate with
> the old one.
> 
> Something like 
> 
> FILE "path" "location" ...
> SLINK "name" "target" ...
> NODE ...
> 
> What do you think?

Introducing a new type to handle space-containing filenames isn't a bad
idea, but using capital letters to signify the API change is confusing.

> The option of --field-separator might also work but it might complicate stuff in
> the .c tool as a more ""manual"" tokenizer will be needed than the simple
> implementation currently present.

What happens when someone wants support for filenames containing spaces
and quotes?

> I'm open to both solution. Lets just agree on one of the 2.

I don't think any of the options will be particularly simple, but
nul-byte delimited field support might be the most straightforward.

Thanks, David

