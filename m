Return-Path: <linux-fsdevel+bounces-22224-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42313914462
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2024 10:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1A3B1F23326
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2024 08:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58964C618;
	Mon, 24 Jun 2024 08:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="B5me4nUK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JZIJtLCC";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cVmwrQKd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="je/tCZH0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E673D49654
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jun 2024 08:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719216965; cv=none; b=VSdJ1DWxcSs8Tye005aOCyJiylhG1a9SZrBEtevaX5g8HYj+OQQ5hubAOaeE9Gg+cHGqJ4zsH+N0FcmQr9GVVbp3EVJP7fBuVtTBkx/8HAK/AkcFRXzUJfdlY+1SU2uo0KJten+2Re8bVw3oUIvmFmM3Ngi/yAFSq2iMC9QmPas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719216965; c=relaxed/simple;
	bh=59JZ0rz6SEG03LoYgq82LB78n60BnBHG/bI9mytc7Zc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oM+DkpzzUeo0T+QNofeRgjun3Rx9/bSbj6BvIuLLgUJGy64mpCfTvdzkFarB0Ip6D+uFPDs6WoTWj0DbIZ6MJbCvRW+HBvvNw3fE/iBIErsACDcE73coYZGwg8HwRKuuEgFjJ+/CAYwmTjECGA69Qx39LMw0jGNFlilh9F43Qbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=B5me4nUK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=JZIJtLCC; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cVmwrQKd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=je/tCZH0; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CFB831F7C3;
	Mon, 24 Jun 2024 08:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719216961; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YvvuuunsOGiITtV9+q1x6XDH8c5eKr7OWFZy+5Gt+m4=;
	b=B5me4nUK82I4k0fTNSvY/wsN/yfLVXIiDrI8Kvt3WI1t5l4BPnQFiWu1XYbH6g3ByGIDB7
	mI5MMFGqJB6XlPobEs9pAUxBaNsmfyj0GUlzH2DOJ+FNVSWoNaJTakB7NiBpI0shDgNY4a
	tIpnJtebQ+KLlkIr++jRS9dH8z/blAI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719216961;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YvvuuunsOGiITtV9+q1x6XDH8c5eKr7OWFZy+5Gt+m4=;
	b=JZIJtLCCA0k7GWWO28dI6MBiC6ukPyZkhJQon+8ltXXiIwrcNGtHrrBqDyHaX1RcEC2BXo
	tDUbSMol5d7MpUAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=cVmwrQKd;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="je/tCZH0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719216960; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YvvuuunsOGiITtV9+q1x6XDH8c5eKr7OWFZy+5Gt+m4=;
	b=cVmwrQKd8MZJz3srlK5Vi/Av+upaKP00cIDAuVFo48lYDQ77/CoW0m+/WvboTh4CS8NsMi
	wVDcjQo0oBG9SooeqEx/by/F7R6C6KJzRpa6QF+YoZJYrH+aqmTMGkw7Qt6WprR3fd1UHS
	JdBxyjeI6hk9vCDjXTnKIbRfN4DQFAE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719216960;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YvvuuunsOGiITtV9+q1x6XDH8c5eKr7OWFZy+5Gt+m4=;
	b=je/tCZH08cyOhQTdCd5c1HGQUuvjh6lq1c9FrlEv25pV5OZYzQ322yReYNQ0LogngCObF/
	WLfLYCoLOH/MY7CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BEC3B13AA4;
	Mon, 24 Jun 2024 08:16:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gPxPLkAreWbGDQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 24 Jun 2024 08:16:00 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 5CC5DA08A4; Mon, 24 Jun 2024 10:16:00 +0200 (CEST)
Date: Mon, 24 Jun 2024 10:16:00 +0200
From: Jan Kara <jack@suse.cz>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jan Kara <jack@suse.cz>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, Zach O'Keefe <zokeefe@google.com>
Subject: Re: [PATCH 2/2] mm: Avoid overflows in dirty throttling logic
Message-ID: <20240624081600.fi4om7huw3w5oxy4@quack3>
References: <20240621144017.30993-1-jack@suse.cz>
 <20240621144246.11148-2-jack@suse.cz>
 <20240621101058.afff9eb37e99fd48452599b7@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621101058.afff9eb37e99fd48452599b7@linux-foundation.org>
X-Rspamd-Queue-Id: CFB831F7C3
X-Spam-Score: -4.01
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:email,suse.cz:dkim,suse.com:email];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Fri 21-06-24 10:10:58, Andrew Morton wrote:
> On Fri, 21 Jun 2024 16:42:38 +0200 Jan Kara <jack@suse.cz> wrote:
> 
> > The dirty throttling logic is interspersed with assumptions that dirty
> > limits in PAGE_SIZE units fit into 32-bit (so that various
> > multiplications fit into 64-bits). If limits end up being larger, we
> > will hit overflows, possible divisions by 0 etc. Fix these problems by
> > never allowing so large dirty limits as they have dubious practical
> > value anyway. For dirty_bytes / dirty_background_bytes interfaces we can
> > just refuse to set so large limits. For dirty_ratio /
> > dirty_background_ratio it isn't so simple as the dirty limit is computed
> > from the amount of available memory which can change due to memory
> > hotplug etc. So when converting dirty limits from ratios to numbers of
> > pages, we just don't allow the result to exceed UINT_MAX.
> 
> Shouldn't this also be cc:stable?

So this is root-only triggerable problem and kind of "don't do it when it
hurts" issue (who really wants to set dirty limits to > 16 TB?). So I'm not
sure CC stable is warranted but I won't object.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

