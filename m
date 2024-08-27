Return-Path: <linux-fsdevel+bounces-27452-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A12096192B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 23:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F68E1C22F63
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 21:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0A71A01AB;
	Tue, 27 Aug 2024 21:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="l9b8+Izb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="aNlKTXbb";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="l9b8+Izb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="aNlKTXbb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7DC1F943;
	Tue, 27 Aug 2024 21:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724793936; cv=none; b=i46jPeux+XKYj2gNgXXG/aoQM9/j482Evr7WXdvF/ekA75+288M+FY+sXUmWKetwqhC+KRqjoqH4jFWUEwxRpvZJVl0DPMav+4uH9p2BLmney01kMhf5a4tAJw4Vm+leHpjdj1n2Hp4/cn1a3WkQ52X0bKFmD6BqxMic4ewL+kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724793936; c=relaxed/simple;
	bh=zjV9lot91D+xjz0oxrezTnRbCXMofe5vC4xSPCsAXWs=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=rz0d2uInQbjlAcA3bbY52D0BquKsavoV4g3UPdPH8Kh/+BVEZbZZyvBTUb8g890NYoicXTlcg62X4K11F3EuoHkYCzddbkHlCsWZRPcfNFUzrc8U8fmY7mHx2gL3TVA8MDRlmRaQscu2GEA4ttPYgE7060wdqru6EaPPqf9a6bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=l9b8+Izb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=aNlKTXbb; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=l9b8+Izb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=aNlKTXbb; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6D9B821B1D;
	Tue, 27 Aug 2024 21:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724793932; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Klq0t8yopkMfR77zgf9TNOg9J793UNgbEgY51TBedRo=;
	b=l9b8+Izb9SSvEXvpVrgPRqVLIX0UjywLCBiRGrkAKKJDL09V3gOvzuLKyzIbjmWZM1/y/Y
	h29VTmdKokY4TgWAkKzbjm6F0pl1yv7QEtPUyuFcEqHYjEESFrKPTb6jBUUhiWnhiR182m
	nGJEbKdd0Jw71X+SO7Nyw1rmq6YALjs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724793932;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Klq0t8yopkMfR77zgf9TNOg9J793UNgbEgY51TBedRo=;
	b=aNlKTXbb3ObEJQc6gD45mpEBSy+Yrs+MVWJTRfQVcmM53ZMbxEECw615z2+uyjfLQfR8Fc
	Lcya6XRFnD4uYNAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724793932; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Klq0t8yopkMfR77zgf9TNOg9J793UNgbEgY51TBedRo=;
	b=l9b8+Izb9SSvEXvpVrgPRqVLIX0UjywLCBiRGrkAKKJDL09V3gOvzuLKyzIbjmWZM1/y/Y
	h29VTmdKokY4TgWAkKzbjm6F0pl1yv7QEtPUyuFcEqHYjEESFrKPTb6jBUUhiWnhiR182m
	nGJEbKdd0Jw71X+SO7Nyw1rmq6YALjs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724793932;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Klq0t8yopkMfR77zgf9TNOg9J793UNgbEgY51TBedRo=;
	b=aNlKTXbb3ObEJQc6gD45mpEBSy+Yrs+MVWJTRfQVcmM53ZMbxEECw615z2+uyjfLQfR8Fc
	Lcya6XRFnD4uYNAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0C92313724;
	Tue, 27 Aug 2024 21:25:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AWiDLElEzmZ3EgAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 27 Aug 2024 21:25:29 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Mike Snitzer" <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org, "Jeff Layton" <jlayton@kernel.org>,
 "Chuck Lever" <chuck.lever@oracle.com>, "Anna Schumaker" <anna@kernel.org>,
 "Trond Myklebust" <trondmy@hammerspace.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v13 09/19] nfs_common: add NFS LOCALIO auxiliary protocol
 enablement
In-reply-to: <Zs4Q0FqoHEKUjrDj@kernel.org>
References: <>, <Zs4Q0FqoHEKUjrDj@kernel.org>
Date: Wed, 28 Aug 2024 07:25:27 +1000
Message-id: <172479392709.11014.6126931297010209759@noble.neil.brown.name>
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, 28 Aug 2024, Mike Snitzer wrote:
> On Mon, Aug 26, 2024 at 10:32:30AM +1000, NeilBrown wrote:
> > On Sat, 24 Aug 2024, Mike Snitzer wrote:
> > > 
> > > Also, expose localio's required nfsd symbols to NFS client:
> > > - Cache nfsd_open_local_fh symbol (defined in next commit) and other
> > >   required nfsd symbols in a globally accessible 'nfs_to'
> > >   nfs_to_nfsd_t struct.
> > 
> > I'm not thrilled with the mechanism for getting these symbols.
> > 
> > I'd rather nfsd passed the symbols to nfs_uuid_is_local(), and it stored
> > them somewhere that nfs can see them.  No need for reference counting
> > etc.  If nfs/localio holds an auth_domain, then it implicitly holds a
> > reference to the nfsd module and the functions cannot disappear.
> >
> > I would created an 'nfs_localio_operations' structure which is defined
> > in nfsd as a constant.
> > The address of this is passed to nfs_uud_is_local() and that address
> > is stored in nfs_to if it doesn't already have the correct value.
> > 
> > So no need for symbol_request() or symbol_put().
> 
> I'm not seeing why we'd want to actively engineer some even more
> bespoke way to access nfsd symbols.  The symbol refcounting is only
> done when the client first connects as part of the LOCALIO handshake
> (or when client is destroyed and LOCALIO enabled), so it isn't getting
> in the way.
> 
> Happy to revisit this but I'd really prefer to use standard convention
> (symbol_request and symbol_put) to establish nfs's dependency on
> nfsd's symbols.

symbol_request is used about 21 times in the whole kernel.  Given how
much interaction there is between modules, that seems like a niche, not
a standard :-)

From my perspective the "standard" way for code to call into other
modules is for the module to provide an "operations" structure which it
registers with the caller somehow.  There are 48 instances of 
   struct .*_operations {
in include/.  There are 494 with just _ops.  21 < 48+494

The sense in which refcounting gets in the way is not at runtime as I
think you defend.  It is at review time.  Declaring an operations
structure is trivial to review and doesn't require any clever macros
(clever macros certainly have their place, but I don't think it is
here).

There would be less code with an operations structure, so less review.

Thanks,
NeilBrown

