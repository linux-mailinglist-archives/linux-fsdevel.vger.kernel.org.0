Return-Path: <linux-fsdevel+bounces-72506-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D5BCCF8A99
	for <lists+linux-fsdevel@lfdr.de>; Tue, 06 Jan 2026 15:04:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD071305967D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jan 2026 13:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC51B346FAA;
	Tue,  6 Jan 2026 13:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tcyMBuWX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3c8YBN/6";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tcyMBuWX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3c8YBN/6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFFE346FAE
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Jan 2026 13:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767707719; cv=none; b=b17ct/4TZuXl88xAcChhcRMS9b3R9N8FaM+HCooG910eiMtehQihpmE0Ty7XMEiLUEf/TM4SJpZ2WTZkguIjAulWThqrFVNxTJZFpDH52nbiq/IdCU9Sq8e5AWFtqa+rTxClg7FcAbnYdWFdPLwOGvDRJM4gINK2lJ+B9ZA75t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767707719; c=relaxed/simple;
	bh=Gs89l7RKY9R/Q5ytEjKEGCSvbSwCGMqmqRbb2X8pgCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fk460DU9Qz1KG64BDFNE8AaAQ3c7os1PmMR3SnlkAa5hL01nZIZbAPWY6ARuy9fGMXVZenxuUghUbZOxNFnf2Vp9Ud2NZLSYlY9EdFA0f1BOd+h1LqGx3k6tdsl88KoSRyBMkJVigulnDtC2IH0Q5Ef3dW87wTOdg9RMMzNmPio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tcyMBuWX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3c8YBN/6; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tcyMBuWX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3c8YBN/6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8BE025BCC5;
	Tue,  6 Jan 2026 13:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767707715; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cIw/7iDeeJQUH5x9q+0fNCZ0Q/TnxQ1hJVUlKln0ZLo=;
	b=tcyMBuWX8hWQv13z3LUyYQsD86Ilvc4Aao09HiB970jJvieceja9F88yvaCWrCOdIjAdSa
	bnCf/ODiRyGzInZmO/Fb9x/Qig6pgqV8IdYMYN6OQ73K5tdLq6t66HDa6Cmd7gKRHgTIfQ
	EctBigC6IgsXHIBrg0BC3T7zMLTp+eI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767707715;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cIw/7iDeeJQUH5x9q+0fNCZ0Q/TnxQ1hJVUlKln0ZLo=;
	b=3c8YBN/6rkpH9JqdIaUJbAaz+qzM51ymmHCezSjUOCSCBnPivoV2qkyXTuCdqSg6Sod22l
	Sr6H8uVOBR64EbDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=tcyMBuWX;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="3c8YBN/6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767707715; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cIw/7iDeeJQUH5x9q+0fNCZ0Q/TnxQ1hJVUlKln0ZLo=;
	b=tcyMBuWX8hWQv13z3LUyYQsD86Ilvc4Aao09HiB970jJvieceja9F88yvaCWrCOdIjAdSa
	bnCf/ODiRyGzInZmO/Fb9x/Qig6pgqV8IdYMYN6OQ73K5tdLq6t66HDa6Cmd7gKRHgTIfQ
	EctBigC6IgsXHIBrg0BC3T7zMLTp+eI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767707715;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cIw/7iDeeJQUH5x9q+0fNCZ0Q/TnxQ1hJVUlKln0ZLo=;
	b=3c8YBN/6rkpH9JqdIaUJbAaz+qzM51ymmHCezSjUOCSCBnPivoV2qkyXTuCdqSg6Sod22l
	Sr6H8uVOBR64EbDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 818C33EA63;
	Tue,  6 Jan 2026 13:55:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6XibH0MUXWnCVQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 06 Jan 2026 13:55:15 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 2B8BEA0A4F; Tue,  6 Jan 2026 14:55:15 +0100 (CET)
Date: Tue, 6 Jan 2026 14:55:15 +0100
From: Jan Kara <jack@suse.cz>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: "David Hildenbrand (Red Hat)" <david@kernel.org>, 
	Jan Kara <jack@suse.cz>, Joanne Koong <joannelkoong@gmail.com>, akpm@linux-foundation.org, 
	linux-mm@kvack.org, athul.krishna.kr@protonmail.com, j.neuschaefer@gmx.net, 
	carnil@debian.org, linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/1] fs/writeback: skip AS_NO_DATA_INTEGRITY mappings
 in wait_sb_inodes()
Message-ID: <pwq7yurznml7m73zge7zwp7sphdz4h54ulzwqrvvad2dl63wjx@y6xfnb7uzmoj>
References: <20251215030043.1431306-1-joannelkoong@gmail.com>
 <20251215030043.1431306-2-joannelkoong@gmail.com>
 <ypyumqgv5p7dnxmq34q33keb6kzqnp66r33gtbm4pglgdmhma6@3oleltql2qgp>
 <616c2e51-ff69-4ef9-9637-41f3ff8691dd@kernel.org>
 <CAJfpeguBuHBGUq45bOFvypsyd8XXekLKycRBGO1eeqLxz3L0eA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpeguBuHBGUq45bOFvypsyd8XXekLKycRBGO1eeqLxz3L0eA@mail.gmail.com>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.net,protonmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,suse.cz,gmail.com,linux-foundation.org,kvack.org,protonmail.com,gmx.net,debian.org,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Queue-Id: 8BE025BCC5
X-Spam-Flag: NO
X-Spam-Score: -4.01

On Tue 06-01-26 14:13:55, Miklos Szeredi wrote:
> On Tue, 6 Jan 2026 at 11:05, David Hildenbrand (Red Hat)
> <david@kernel.org> wrote:
> 
> > > So I understand your patch fixes the regression with suspend blocking but I
> > > don't have a high confidence we are not just starting a whack-a-mole game
> 
> Joanne did a thorough analysis, so I still have hope.  Missing a case
> in such a complex thing is not unexpected.
> 
> > Yes, I think so, and I think it is [1] not even only limited to
> > writeback [2].
> 
> You are referring to DoS against compaction?
> 
> It is a much more benign issue, since compaction will just skip locked
> pages, AFAIU (wasn't always so:
> https://lore.kernel.org/all/1288817005.4235.11393.camel@nimitz/).
> 
> Not saying it shouldn't be fixed, but it should be a separate discussion.
> 
> > To handle the bigger picture (I raised another problematic instance in
> > [4]): I don't know how to handle that without properly fixing fuse. Fuse
> > folks should really invest some time to solve this problem for good.
> 
> Fixing it generically in fuse would necessarily involve bringing back
> some sort of temp buffer.  The performance penalty could be minimized,
> but complexity is what really hurts.
> 
> Maybe doing whack-a-mole results in less mess overall :-/

OK, I was wondering about the bigger picture and now I see there's none :)
I can live with this workaround for now as its blast radius is relatively
small and we can see if some other practical issues appear in the future
(in which case I'll probably push for a more systemic solution).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

