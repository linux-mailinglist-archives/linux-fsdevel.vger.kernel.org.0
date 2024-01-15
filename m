Return-Path: <linux-fsdevel+bounces-8015-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAD0482E332
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 00:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6201283BBD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 23:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B781B7E1;
	Mon, 15 Jan 2024 23:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="s4vHPQl2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JFwX5M6e";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rgO4U4hZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QN+8jt43"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB46E19475
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jan 2024 23:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CC76A22110;
	Mon, 15 Jan 2024 23:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705360601;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8UmmicqoEmpUyFuJDyNRPP7ykoBICBOXYVrWdHwNTQs=;
	b=s4vHPQl2VZlCfBahtr1BC72ClhLSYEwsz1AFdTq8PzQjzxkvvH0b7KaC8aQbZj3P7DMHwZ
	ijsdgExxSs2T39PfKJZ+weaQi9hHy3beKuiS0cDxQyw3d2FYx8UoR1w72yihYxYLfX3b5M
	KzXvcyI9d1ZI0w8kM9ozoEarEkJTbck=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705360601;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8UmmicqoEmpUyFuJDyNRPP7ykoBICBOXYVrWdHwNTQs=;
	b=JFwX5M6ezCROe0q5az+yn+rnblFW2SRNyevuFXu58qV3QSky1jFeJtLXKfEMmW84c1izJP
	MGCjS93LVsWUB7CA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705360600;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8UmmicqoEmpUyFuJDyNRPP7ykoBICBOXYVrWdHwNTQs=;
	b=rgO4U4hZT//jF2/fIe7wASaK3z1u2D7Cbs+LzYpAxw8L5DbyBO9mMZPbee9djyBnKdRvA2
	em34iXVTMYhsAPqBb4m518VkFnWARD86EFJu+V/wdWwnOGMhzULis+2ho02/tVgcRFeLsi
	TBcr6FH5w61/gDjHpZBAhw1znhcpDn8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705360600;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8UmmicqoEmpUyFuJDyNRPP7ykoBICBOXYVrWdHwNTQs=;
	b=QN+8jt43fFTIMIB2ynDmciqCR+C/oziIosyZFC47RVknyAPjtxEriypV9h9mptwQX1GtBw
	AsW/YsZA0xuB5zBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 66F88132FA;
	Mon, 15 Jan 2024 23:16:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8lbLF9i8pWVTAgAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Mon, 15 Jan 2024 23:16:40 +0000
Date: Tue, 16 Jan 2024 00:16:38 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Cc: ltp@lists.linux.it, mszeredi@redhat.com, brauner@kernel.org,
	Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
	viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
	Richard Palethorpe <rpalethorpe@suse.com>
Subject: Re: [LTP] [PATCH v3 2/4] syscalls: readahead01: Make use of tst_fd
Message-ID: <20240115231638.GB2535088@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20240115125351.7266-1-chrubis@suse.cz>
 <20240115125351.7266-3-chrubis@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240115125351.7266-3-chrubis@suse.cz>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -6.98
X-Spamd-Result: default: False [-6.98 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[pvorel@suse.cz];
	 REPLYTO_EQ_FROM(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.48)[97.62%]
X-Spam-Flag: NO

Hi Cyril,

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Nice!

Kind regards,
Petr

