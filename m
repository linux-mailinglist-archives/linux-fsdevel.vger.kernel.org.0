Return-Path: <linux-fsdevel+bounces-38855-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB01CA08D5F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 11:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E541D3A48A4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 10:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451EE20897E;
	Fri, 10 Jan 2025 10:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WWFDSes6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="x8QXDFDo";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WWFDSes6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="x8QXDFDo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23852209F44;
	Fri, 10 Jan 2025 10:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736503732; cv=none; b=OBrrKXiOFg//TV4dDnfSU5TMipIeTMc+D9hUxmdn4AfSA4oW4jPfroOzFoE3AT2qsOANDVZDy5ogmVI7w0tAiMChU2SykGvetMIA20G9m0ITHikg4O14XREYPk90CwJAwHQWeXMIRRsOxTEY4xFonZ0gQx4+eT/rfWzXJaCG7Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736503732; c=relaxed/simple;
	bh=BbdA6Rs32dSgoDSpSVYWGtIi1Yfxotjv9Yb2zBsFRK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D2Rh0VpKN+30yJ5XX+YvFXAsJaxekD73+snNiw11rpnJm/v4MUw0F/KEmqsZAYvlwyBRF0ivJwjHXzqWE8j+ylS4wN1qHGh7CWVFJvj+uNBeueoge/YTCL0RRxVybwNLp8qiovwVuLYsyIUhvgnXOARsh/grusFD7D3cKONxMd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WWFDSes6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=x8QXDFDo; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WWFDSes6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=x8QXDFDo; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1BF3621108;
	Fri, 10 Jan 2025 10:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736503729; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vh2D+ySYcJZ0AAJfm70WEUrZVDZRz1jiQXr0mbdgWD8=;
	b=WWFDSes6izt0Yxv4h//52EP9cr3kpi3RUP2WXW4Aswy1cJhGNrbd/WvoYPVxXIsK9+mhSs
	NC5rvqsG8sg1Xl7aV4ABgC+mqn5lb2458G7X7fHCzbQBdU3s6dyhgr01umVhjY+HjF6yc8
	uZ1PrPyaOp5bbrb6wIEYlSjGlWtPr1I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736503729;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vh2D+ySYcJZ0AAJfm70WEUrZVDZRz1jiQXr0mbdgWD8=;
	b=x8QXDFDoGvHs0bGm4Xpve8eXiXgqSxcmNruocH/LYwOFNyLFlge/CeN3KoyhNWBb/yXQ2M
	49qN+2G6XOeUf4BQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=WWFDSes6;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=x8QXDFDo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736503729; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vh2D+ySYcJZ0AAJfm70WEUrZVDZRz1jiQXr0mbdgWD8=;
	b=WWFDSes6izt0Yxv4h//52EP9cr3kpi3RUP2WXW4Aswy1cJhGNrbd/WvoYPVxXIsK9+mhSs
	NC5rvqsG8sg1Xl7aV4ABgC+mqn5lb2458G7X7fHCzbQBdU3s6dyhgr01umVhjY+HjF6yc8
	uZ1PrPyaOp5bbrb6wIEYlSjGlWtPr1I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736503729;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vh2D+ySYcJZ0AAJfm70WEUrZVDZRz1jiQXr0mbdgWD8=;
	b=x8QXDFDoGvHs0bGm4Xpve8eXiXgqSxcmNruocH/LYwOFNyLFlge/CeN3KoyhNWBb/yXQ2M
	49qN+2G6XOeUf4BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 10D8D13A86;
	Fri, 10 Jan 2025 10:08:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ar0WBLHxgGcSIAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 10 Jan 2025 10:08:49 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B7C3DA0889; Fri, 10 Jan 2025 11:08:40 +0100 (CET)
Date: Fri, 10 Jan 2025 11:08:40 +0100
From: Jan Kara <jack@suse.cz>
To: Kun Hu <huk23@m.fudan.edu.cn>
Cc: Jan Kara <jack@suse.cz>, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"jjtan24@m.fudan.edu.cn" <jjtan24@m.fudan.edu.cn>, Andreas Gruenbacher <agruenba@redhat.com>, gfs2@lists.linux.dev
Subject: Re: Bug: slab-out-of-bounds Write in __bh_read
Message-ID: <xqx6qkwti3ouotgkq5teay3adsja37ypjinrhur4m3wzagf5ia@ippcgcsvem5b>
References: <F0E0E5DD-572E-4F05-8016-46D36682C8BB@m.fudan.edu.cn>
 <brheoinx2gsmonf6uxobqicuxnqpxnsum26c3hcuroztmccl3m@lnmielvfe4v7>
 <5757218E-52F8-49C7-95F1-9051EB51A2F3@m.fudan.edu.cn>
 <6yd5s7fxnr7wtmluqa667lok54sphgtg4eppubntulelwidvca@ffyohkeovnyn>
 <31A10938-C36E-40A2-8A1D-180BD95528DD@m.fudan.edu.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <31A10938-C36E-40A2-8A1D-180BD95528DD@m.fudan.edu.cn>
X-Rspamd-Queue-Id: 1BF3621108
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Fri 10-01-25 17:21:19, Kun Hu wrote:
> > 
> > OK. Checking the syzlang reproducer the same comment as for other
> > filesystem bugs applies - please run with CONFIG_BLK_DEV_WRITE_MOUNTED
> > disabled to rule out corruption of a filesystem while it is mounted.
> > 
> > 
> 
> Hi Jan,
> 
> We have reproduced the crash with CONFIG_BLK_DEV_WRITE_MOUNTED disabled
> to obtain the same crash log. The new crash log, along with C and Syzlang
> reproducers are provided below:
> 
> Crash log: https://drive.google.com/file/d/1FiCgo05oPheAt4sDQzRYTQwl0-CY6rvi/view?usp=sharing
> C reproducer: https://drive.google.com/file/d/1TTR9cquaJcMYER6vtYUGh3gOn_mROME4/view?usp=sharing
> Syzlang reproducer: https://drive.google.com/file/d/1R9QDUP2r7MI4kYMiT_yn-tzm6NqmcEW-/view?usp=sharing
> 
> I’m not sure if this is sufficient to help locate the bug? If you need
> additional information, please let me know.

Thanks. Based on the crash report and the reproducer it indeed looks like
some mixing of iomap_folio_state and buffer heads attached to a folio
(iomap_folio_state is attached there but we end up calling
__block_write_begin_int() which expects buffer heads there) in GFS2. GFS2
guys, care to have a look?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

