Return-Path: <linux-fsdevel+bounces-16046-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D40897534
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 18:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3B781F2B0B1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 16:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71AA15098D;
	Wed,  3 Apr 2024 16:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pp8YHJR4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="K5rgSLPa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9D9150990;
	Wed,  3 Apr 2024 16:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712161640; cv=none; b=PwsXb0jvGqHBgNrnwRHoEqUO2I4JJbVrSdzKk3syQTyLHtub0ZXYL82evQhLFwvg9ZKbMnOq1CdD3GC8vewBcaHScGHa9PYq6RMm1qIq6XEhW++E80UTmnAoNg2fMy0UF1bqZ2MLwWti8MwRNkBsV6e9d2rY7QQg5EeR8+SmNDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712161640; c=relaxed/simple;
	bh=N283gQOcSt2JQpsVAyXiyv+tS3Qj6fbPQwINwOd8nM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PlmnO42q3m2Rhi7ZIHGFhFsBL7rDth9UnvTmGt4Hn6XKsAjsTkEEeaVi47vQ9nX1Jdp/1fw9aN8pHiXJjpMAPqe0xzJBb/qnhDxn+vr1H6tTQNj5yTabAe9woXHEUlkfS+TNM0UDd7Le2487VISZ6rCFvR1CStJTHsPXc/kUcV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pp8YHJR4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=K5rgSLPa; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7EF8120BFC;
	Wed,  3 Apr 2024 16:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712161636; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XdI1yWISzkbEZXlSrjJuMRoad1P879v+C1CTXZuc5rg=;
	b=pp8YHJR4fTJm2T1lBCUoAkPPEIPZ8lz/knJwXua2Qa1l+9jaqb1hZq0vFzoChcozfd4JeV
	EOfwxvbuFehmSHhk+SNvvUxrdLOtcR5at9GkZllfdvyE7DKta4fAyzHamFa1LtT3aRvYPY
	qYnFJyWxGYi10DJtb0n6k+jEDxFQqRQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712161636;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XdI1yWISzkbEZXlSrjJuMRoad1P879v+C1CTXZuc5rg=;
	b=K5rgSLPaMctwGDfFzMRnnrpUnjA0W/u0tyoQeJo5xCuhtTEOcD1Q5Y2BDc6jXid4hSMkHY
	D04X3mM2Ls3mT5AA==
Authentication-Results: smtp-out2.suse.de;
	dkim=none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 706421331E;
	Wed,  3 Apr 2024 16:27:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id CzkpG2SDDWaVCAAAn2gu4w
	(envelope-from <jack@suse.cz>); Wed, 03 Apr 2024 16:27:16 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 125EFA0816; Wed,  3 Apr 2024 18:27:16 +0200 (CEST)
Date: Wed, 3 Apr 2024 18:27:16 +0200
From: Jan Kara <jack@suse.cz>
To: Tejun Heo <tj@kernel.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Kemeng Shi <shikemeng@huaweicloud.com>, akpm@linux-foundation.org,
	willy@infradead.org, jack@suse.cz, bfoster@redhat.com,
	dsterba@suse.com, mjguzik@gmail.com, dhowells@redhat.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] Improve visibility of writeback
Message-ID: <20240403162716.icjbicvtbleiymjy@quack3>
References: <20240327155751.3536-1-shikemeng@huaweicloud.com>
 <qyzaompqkxwdquqtofmqghvpi4m3twkrawn26rxs56aw4n2j3o@kt32f47dkjtu>
 <ZgXFrabAqunDctVp@slm.duckdns.org>
 <n2znv2ioy62rrrzz4nl2x7x5uighuxf2fgozhpfdkj6ialdiqe@a3mnfez7mitl>
 <ZgXJH9XQNqda7fpz@slm.duckdns.org>
 <wgec7wbhdn7ilvwddcalkbgxzjutp6h7dgfrijzffb64pwpksz@e6tqcybzfu2f>
 <ZgXPZ1uJSUCF79Ef@slm.duckdns.org>
 <qv3vv6355aw5fkzw5yvuwlnyceypcsfl5kkcrvlipxwfl3nuyg@7cqwaqpxn64t>
 <ZgXXKaZlmOWC-3mn@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZgXXKaZlmOWC-3mn@slm.duckdns.org>
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.36 / 50.00];
	BAYES_HAM(-0.55)[80.84%];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,huaweicloud.com,linux-foundation.org,infradead.org,suse.cz,redhat.com,suse.com,gmail.com,vger.kernel.org,kvack.org];
	R_DKIM_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:98:from];
	RCVD_TLS_LAST(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap2.dmz-prg2.suse.org:rdns,imap2.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Spam-Score: -0.36
X-Spamd-Bar: /
X-Rspamd-Queue-Id: 7EF8120BFC

On Thu 28-03-24 10:46:33, Tejun Heo wrote:
> Hello, Kent.
> 
> On Thu, Mar 28, 2024 at 04:22:13PM -0400, Kent Overstreet wrote:
> > Most users are never going to touch tracing, let alone BPF; that's too
> > much setup. But I can and do regularly tell users "check this, this and
> > this" and debug things on that basis without ever touching their
> > machine.
> 
> I think this is where the disconnect is. It's not difficult to set up at
> all. Nowadays, in most distros, it comes down to something like run "pacman
> -S bcc" and then run "/usr/share/bcc/tools/biolatpcts" with these params or
> run this script I'm attaching. It is a signficant boost when debugging many
> different kernel issues. I strongly suggest giving it a try and getting used
> to it rather than resisting it.

Yeah, BPF is great and I use it but to fill in some cases from practice,
there are sysadmins refusing to install bcc or run your BPF scripts on
their systems due to company regulations, their personal fear, or whatever.
So debugging with what you can achieve from a shell is still the thing
quite often.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

