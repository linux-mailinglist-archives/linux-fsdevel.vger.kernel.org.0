Return-Path: <linux-fsdevel+bounces-58828-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB69AB31C3A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 16:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D264B27DBC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 14:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4247E3074B0;
	Fri, 22 Aug 2025 14:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HHoQ7xt9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tJZzUELy";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HHoQ7xt9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tJZzUELy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160932FDC59
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Aug 2025 14:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755873406; cv=none; b=HSMwwcwRvx2ixdvJpXeVko7kZSox1bsy5fsPwSw9MYyVEzFQ2J+LhROjRAjBKQR9Kpi8822tXCkCiWLh4il5eeSJj79gTAortijuhwGqpcEGvX86CW40CEByNQv9afiLYnJEoLuni77rIpx2IHgzBMAOrCVDHvw9A3HHKh/uFCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755873406; c=relaxed/simple;
	bh=7oxvdhim/c9I6QlXho3s3/in/jQastEzhsBmUipvo40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZxwChNORcqlfPTcE3QLkR5hUmVBO5gIIUQxWEbkca8grZyHZ2ScSgZOEtC1366HbU/o1KKKnH6OzEH1Tcaai30Um8ZM090LJiEA1ap0Hvh+22THHQbsV91yWdEuo+tbZF/bt3O65XExihw1OPc1Iupb0CNTaMhrA7m5ot/lGKB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HHoQ7xt9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tJZzUELy; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HHoQ7xt9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tJZzUELy; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 514D5218F8;
	Fri, 22 Aug 2025 14:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1755873403;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QhDluULNtxBc6G4/WOfw0KgPIwSPIoDZiu6tki5OZHw=;
	b=HHoQ7xt9OntMCJsuXdPdBxXaZmiBo5E6RXhcAk9PCsovY3hluzkte2kDVmN90NqcrazBbH
	ufp/zhJePIh0+cCxTMxpffVDOho1AO9UVQ1sWNmu9RTW31sDNrjuO+zhEEQ8b52m/B+7KK
	4gB0HFk8FbRrIpO3W4BBfVL47k7qopU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1755873403;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QhDluULNtxBc6G4/WOfw0KgPIwSPIoDZiu6tki5OZHw=;
	b=tJZzUELyF+9ee9JrSm+aj6blFHGh/Ely25UYLdaitzaZEpfCcKLu59oUksbxtGyFelpGJz
	Jo3izNm+iQ0NF8DQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1755873403;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QhDluULNtxBc6G4/WOfw0KgPIwSPIoDZiu6tki5OZHw=;
	b=HHoQ7xt9OntMCJsuXdPdBxXaZmiBo5E6RXhcAk9PCsovY3hluzkte2kDVmN90NqcrazBbH
	ufp/zhJePIh0+cCxTMxpffVDOho1AO9UVQ1sWNmu9RTW31sDNrjuO+zhEEQ8b52m/B+7KK
	4gB0HFk8FbRrIpO3W4BBfVL47k7qopU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1755873403;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QhDluULNtxBc6G4/WOfw0KgPIwSPIoDZiu6tki5OZHw=;
	b=tJZzUELyF+9ee9JrSm+aj6blFHGh/Ely25UYLdaitzaZEpfCcKLu59oUksbxtGyFelpGJz
	Jo3izNm+iQ0NF8DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 34B5C13931;
	Fri, 22 Aug 2025 14:36:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7s9cDHuAqGhDDQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 22 Aug 2025 14:36:43 +0000
Date: Fri, 22 Aug 2025 16:36:41 +0200
From: David Sterba <dsterba@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org, kernel-team@fb.com,
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH 02/50] fs: make the i_state flags an enum
Message-ID: <20250822143641.GW22430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1755806649.git.josef@toxicpanda.com>
 <02211105388c53dc68b7f4332f9b5649d5b66b71.1755806649.git.josef@toxicpanda.com>
 <20250822-orcas-bemannten-728c9946b160@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822-orcas-bemannten-728c9946b160@brauner>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00

On Fri, Aug 22, 2025 at 01:08:07PM +0200, Christian Brauner wrote:
> On Thu, Aug 21, 2025 at 04:18:13PM -0400, Josef Bacik wrote:
> > +/*
> > + * As simple macro to define the inode state bits, __NAME will be the bit value
> > + * (0, 1, 2, ...), and NAME will be the bit mask (1U << __NAME). The __NAME_SEQ
> > + * is used to reset the sequence number so the next name gets the next bit value
> > + * in the sequence.
> > + */
> > +#define INODE_BIT(name)			\
> > +	__ ## name,			\
> > +	name = (1U << __ ## name),	\
> > +	__ ## name ## _SEQ = __ ## name
> 
> I'm not sure if this is the future we want :D
> I think it's harder to parse than what we have now.

If it would be a generic sounding name like ENUM_BIT

https://elixir.bootlin.com/linux/v6.16.2/source/fs/btrfs/misc.h#L16

one does not have to parse anything and the meaning is understandable in
the context of enum. We've converted everything to that in btrfs and
it's convenient to change just one line when adding or removing entries,
not caring about the exact values.

