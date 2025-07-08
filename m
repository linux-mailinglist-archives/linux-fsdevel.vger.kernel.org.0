Return-Path: <linux-fsdevel+bounces-54204-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D665BAFBF82
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 02:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EF283B31F3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 00:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48EA81EE02F;
	Tue,  8 Jul 2025 00:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OHm2Xg3Z";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="j8lNt6Rt";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OHm2Xg3Z";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="j8lNt6Rt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309D115C15F
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Jul 2025 00:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751936027; cv=none; b=RaOlbTPbbj9cCCmdD0o5Pt+ijBjvqgbSiPF9M1CoQZTXvV17GzOrs03zFFTd1r0a+coyRIxuxI7tMjRKb4zHz/DzBSL+B4hbqR+Kc4kotMYlHcohHBEE6IPZrlNroA030ETBElM7NprOdIWhIHZvE4ai0/As4M4h5NTeWaCWuv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751936027; c=relaxed/simple;
	bh=+r4x+H65EF9BHZgY2ZsE5BK8mVxGQo34+Gxyt34CMO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TD7G7qf8H5UgnIh3z0gYllXmmrHBof/4HeWszLPcqvvc5M1/tJi10XTTY+KQ8h2miJ2jddAXWe6KbfIH4MIQEOY/kd1FctsOQ41rs2vIni8HhmgL9oeYxhh/ICHebLetW7eUO1ht6w1U+wGX2w6Zf5o8L8++BHv5ZE4L31jPznE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OHm2Xg3Z; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=j8lNt6Rt; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OHm2Xg3Z; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=j8lNt6Rt; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 139711F390;
	Tue,  8 Jul 2025 00:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751936024;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A81n3KozyX4tTMOofmBuiojfPEGqU4oQYfL7AGTA1O8=;
	b=OHm2Xg3Zsc+77gt/+DbTtinpaBBqSdleAbyUzRuqoPO2sy1ZWCcNNDcZXZMsbURhVZ+WyP
	7RLDDEKjujRYywWDCn12AfqyhWfjvaRPOnL6gKyGWBGKWdBPRcvAYUFrOcWoWTthOl+cQV
	AoBokLwdiemYeTHwpjuBMo32S9oHKXU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751936024;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A81n3KozyX4tTMOofmBuiojfPEGqU4oQYfL7AGTA1O8=;
	b=j8lNt6Rt6BuqIGyR1R/z8HzcQsY5Jx2N8LtSvaVTj9/wUIPlPxZBCgd1UhhtbICntCTrj7
	ZQxKE24RXc/0yDCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=OHm2Xg3Z;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=j8lNt6Rt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751936024;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A81n3KozyX4tTMOofmBuiojfPEGqU4oQYfL7AGTA1O8=;
	b=OHm2Xg3Zsc+77gt/+DbTtinpaBBqSdleAbyUzRuqoPO2sy1ZWCcNNDcZXZMsbURhVZ+WyP
	7RLDDEKjujRYywWDCn12AfqyhWfjvaRPOnL6gKyGWBGKWdBPRcvAYUFrOcWoWTthOl+cQV
	AoBokLwdiemYeTHwpjuBMo32S9oHKXU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751936024;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A81n3KozyX4tTMOofmBuiojfPEGqU4oQYfL7AGTA1O8=;
	b=j8lNt6Rt6BuqIGyR1R/z8HzcQsY5Jx2N8LtSvaVTj9/wUIPlPxZBCgd1UhhtbICntCTrj7
	ZQxKE24RXc/0yDCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DD1D613A68;
	Tue,  8 Jul 2025 00:53:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pOeINRdsbGjKXgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 08 Jul 2025 00:53:43 +0000
Date: Tue, 8 Jul 2025 02:53:42 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: dsterba@suse.cz, linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz
Subject: Re: [PATCH v4 5/6] btrfs: implement shutdown ioctl
Message-ID: <20250708005342.GJ4453@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1751589725.git.wqu@suse.com>
 <5ff44de2d9d7f8c2e59fa3a5fe68d5bb4c71a111.1751589725.git.wqu@suse.com>
 <20250705142230.GC4453@twin.jikos.cz>
 <6642f8b5-d357-4fb6-a295-906178a633f9@suse.com>
 <20250707205125.GI4453@twin.jikos.cz>
 <eac924e4-fb2e-42fd-979a-4a0829f67377@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eac924e4-fb2e-42fd-979a-4a0829f67377@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 139711F390
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.21

On Tue, Jul 08, 2025 at 08:34:09AM +0930, Qu Wenruo wrote:
> > I have working prototype for pausing scrub that does not need to exit,
> > so far I've tested it with fsfreeze in a VM, I still need to test actual
> > freezing for suspend purposes.
> 
> Not sure how would you test with running scrub and freeze, but please 
> enable lockdep for the potential reversed lock sequence related to btrfs 
> specific locks and s_umount/s_writers.rw_sem.

I used debug_show_held_locks(current) in the task and it showed only the
writers rwsem, once dropped there were no other locks held.

The test is a started scrub with a low bw limit so it takes long enough,
then either from script or manually I do fsfreeze.

