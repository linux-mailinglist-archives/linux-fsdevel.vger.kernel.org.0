Return-Path: <linux-fsdevel+bounces-38235-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4659FDE0B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Dec 2024 09:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B8641882676
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Dec 2024 08:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C67746434;
	Sun, 29 Dec 2024 08:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IAABd9Ft";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4/PKIxKi";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IAABd9Ft";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4/PKIxKi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882AB2770B;
	Sun, 29 Dec 2024 08:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735461318; cv=none; b=QKeFwnPmmn4JPo47mJPertopT6IW3xK0HQ66ELmLFl0iIxLRKgeJ/x4THaAEKLw11Xo01jS/JuRZTbADsCjOECeA+c/X9eB4dYxIUwJemob17hzKK39jB//UeiBMS4j3Anj6wEla6suWy4cohTX9nPVBczTgL0/VqAdMokAoACI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735461318; c=relaxed/simple;
	bh=c2RUqAV6dWhkmQsJOS0OsCqahWVBVUYtXxYIkeHgYFA=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YGvSl1Q7FOkcGVL3wbDjJN5jGpWB5nuAVhMHPQtkC/rO6qUgNz7OQ2++9KLooLG6q92pXvuSTlMS2rM4j540RReBe3URtRgDIpy63/SKiMWo3ydNa7JVz11JTLaQg9ylvnAq6YdHNaOT+VHe88lQaGJbTvk4PGB4LSKuHI1oBD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IAABd9Ft; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4/PKIxKi; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IAABd9Ft; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4/PKIxKi; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 875A05C835;
	Sun, 29 Dec 2024 08:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1735461314; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o/n+UkSlvqWi0bMuXJ8U8sr28nWtC7cQ67a5sH+btok=;
	b=IAABd9FtPmpSgnthTYSGUO2QWyhWoBow04h3OTlRCkA4YxadA5J554m7drjLtlPwZZXgmA
	WZy+KVGW8OnoxKTsEwqmrN1D8eqUTsItcYK7+fyj78j+0wL0Hk8rv0EjNTzMz+v9gKGjET
	BO7aT/x27uGbx+47+AawhI0iq/T4eSQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1735461314;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o/n+UkSlvqWi0bMuXJ8U8sr28nWtC7cQ67a5sH+btok=;
	b=4/PKIxKiWncXWKj9Sv9Qiq4PH2bsxbfD6ShpPvEeoVaqmrKykMtte01toLH8n/grg4Po+j
	dnRpqqkXeJhGvPCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1735461314; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o/n+UkSlvqWi0bMuXJ8U8sr28nWtC7cQ67a5sH+btok=;
	b=IAABd9FtPmpSgnthTYSGUO2QWyhWoBow04h3OTlRCkA4YxadA5J554m7drjLtlPwZZXgmA
	WZy+KVGW8OnoxKTsEwqmrN1D8eqUTsItcYK7+fyj78j+0wL0Hk8rv0EjNTzMz+v9gKGjET
	BO7aT/x27uGbx+47+AawhI0iq/T4eSQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1735461314;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o/n+UkSlvqWi0bMuXJ8U8sr28nWtC7cQ67a5sH+btok=;
	b=4/PKIxKiWncXWKj9Sv9Qiq4PH2bsxbfD6ShpPvEeoVaqmrKykMtte01toLH8n/grg4Po+j
	dnRpqqkXeJhGvPCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4CEA6139D0;
	Sun, 29 Dec 2024 08:35:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 52wdEcIJcWehQgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sun, 29 Dec 2024 08:35:14 +0000
Date: Sun, 29 Dec 2024 09:35:13 +0100
Message-ID: <87o70udgzi.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Jaroslav Kysela <perex@perex.cz>,	linux-fsdevel@vger.kernel.org,
	Amadeusz =?ISO-8859-2?Q?S=B3awi=F1ski?=
 <amadeuszx.slawinski@linux.intel.com>,	Takashi Iwai <tiwai@suse.de>,
	linux-sound@vger.kernel.org,	Vinod Koul <vkoul@kernel.org>
Subject: Re: [CFT][PATCH] fix descriptor uses in sound/core/compress_offload.c
In-Reply-To: <20241226221726.GW1977892@ZenIV>
References: <20241226182959.GU1977892@ZenIV>
	<d01e06bf-9cbc-4c0e-bcce-2b10b1d04971@perex.cz>
	<20241226213122.GV1977892@ZenIV>
	<20241226221726.GW1977892@ZenIV>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.org.uk:email]
X-Spam-Score: -3.30
X-Spam-Flag: NO

On Thu, 26 Dec 2024 23:17:26 +0100,
Al Viro wrote:
> 
> On Thu, Dec 26, 2024 at 09:31:22PM +0000, Al Viro wrote:
> > On Thu, Dec 26, 2024 at 08:00:18PM +0100, Jaroslav Kysela wrote:
> > 
> > >   I already made almost similar patch:
> > > 
> > > https://lore.kernel.org/linux-sound/20241217100726.732863-1-perex@perex.cz/
> > 
> > Umm...  The only problem with your variant is that dma_buf_get()
> > is wrong here - it should be get_dma_buf() on actual objects,
> > and it should be done before fd_install().
> 
> Incremental on top of what just got merged into mainline:
> 
> Grab the references to dmabuf before moving them into descriptor
> table - trying to do that by descriptor afterwards might end up getting
> a different object, with a dangling reference left in task->{input,output}
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Could you resubmit this one as a formal patch to be merged?
Thanks!


Takashi

