Return-Path: <linux-fsdevel+bounces-46383-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D1FEA884E3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 16:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA3FE1904445
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 14:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913302BE0F1;
	Mon, 14 Apr 2025 13:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2pZWZYIE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2yiLDnu2";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2pZWZYIE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2yiLDnu2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940862BE0E8
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Apr 2025 13:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744639125; cv=none; b=rbmshhmHXYMnSvtb5SknCONQNDIkuH4uEv8p1lJdw9FexNgenwvai6KjfPYr70hAec02CdIb1nBLpSMmlYA8+fU1LMTx+gkXW3O91tWwx5OU9ve/rB/lfFL83G9H3YITnJIYB1Fj1miNHWdrg62aRTBlke3QFYml/UyKBjhKXdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744639125; c=relaxed/simple;
	bh=NIEIyJ1JEaWmPpJ7kXB8XPRQi1m0L0ILCZe2mPzVmUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SZETAjQLZ+6XZ5c9kMOzTDhhQwZxsV42D8pXm/4RNpSyxsYfUprR2l64huMyrxQjm9VsnXklR8RlmHV2e+T7Jv2nFJablAbXJlaA2xouCdWevCatD7tmoRRw8kJpKAS29KKGT3boOLEOn020bsAT3Z2R/3tdrrfMqJd3eW7qXAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2pZWZYIE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2yiLDnu2; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2pZWZYIE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2yiLDnu2; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 921EB218E6;
	Mon, 14 Apr 2025 13:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744639121; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S554XvRIlWkgLTpvedrrQNLZ/frGNoctW5TsSBt6TJQ=;
	b=2pZWZYIEjCofs/R29J+7qTVlmdikpwP/8b+aZ88TFhs6hO70XvZbg0T/M//wvG2GOwk7yk
	K1p0JJ4McJTbToK1YSJzM0IiudHATAR5+rm2aQUh+ELms91s0FaEu+kAP8p/2pd3/yyvcG
	ZEmlqN75jL/1StG2VlP+CFaAcNpFz8E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744639121;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S554XvRIlWkgLTpvedrrQNLZ/frGNoctW5TsSBt6TJQ=;
	b=2yiLDnu2Gw02ttvu1SoIsu9bir8hR4awMZ8B0p/Ms9hKMSViNNqxURfzrhafk6EXEoNv8e
	tLn550NIg3P42mDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=2pZWZYIE;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=2yiLDnu2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744639121; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S554XvRIlWkgLTpvedrrQNLZ/frGNoctW5TsSBt6TJQ=;
	b=2pZWZYIEjCofs/R29J+7qTVlmdikpwP/8b+aZ88TFhs6hO70XvZbg0T/M//wvG2GOwk7yk
	K1p0JJ4McJTbToK1YSJzM0IiudHATAR5+rm2aQUh+ELms91s0FaEu+kAP8p/2pd3/yyvcG
	ZEmlqN75jL/1StG2VlP+CFaAcNpFz8E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744639121;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S554XvRIlWkgLTpvedrrQNLZ/frGNoctW5TsSBt6TJQ=;
	b=2yiLDnu2Gw02ttvu1SoIsu9bir8hR4awMZ8B0p/Ms9hKMSViNNqxURfzrhafk6EXEoNv8e
	tLn550NIg3P42mDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 82FDA136A7;
	Mon, 14 Apr 2025 13:58:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IP75H5EU/Wf+BwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 14 Apr 2025 13:58:41 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 338BAA094B; Mon, 14 Apr 2025 15:58:37 +0200 (CEST)
Date: Mon, 14 Apr 2025 15:58:37 +0200
From: Jan Kara <jack@suse.cz>
To: Cabbaken Q <Cabbaken@outlook.com>
Cc: Kees Cook <kees@kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] Fix comment style of `do_execveat_common()`
Message-ID: <hsnabzbrvgpng7rsxpgcjaggiwaenrgwsi2u7spfbypbfraymu@7h5dxvkq64hz>
References: <OS7PR01MB116815D7D0BCF55F3FE216293DFB32@OS7PR01MB11681.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <OS7PR01MB116815D7D0BCF55F3FE216293DFB32@OS7PR01MB11681.jpnprd01.prod.outlook.com>
X-Rspamd-Queue-Id: 921EB218E6
X-Spam-Score: -4.01
X-Rspamd-Action: no action
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
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[outlook.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[outlook.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:email,suse.com:email,suse.cz:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Mon 14-04-25 07:07:57, Cabbaken Q wrote:
> From 46fab5ecc860f26f790bec2a902a54bae58dfca7 Mon Sep 17 00:00:00 2001
> From: Ruoyu Qiu <cabbaken@outlook.com>
> Date: Mon, 14 Apr 2025 14:56:28 +0800
> Subject: [PATCH] Fix comment style of `do_execveat_common()`
> 
> Signed-off-by: Ruoyu Qiu <cabbaken@outlook.com>

Thanks for the patch but I think fixing one extra space in a comment isn't
really worth the effort of all the people involved in handling a patch.

								Honza

> ---
>  fs/exec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/exec.c b/fs/exec.c
> index 8e4ea5f1e64c..51dad7af5083 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1903,7 +1903,7 @@ static int do_execveat_common(int fd, struct filename *filename,
>       /*
>        * We move the actual failure in case of RLIMIT_NPROC excess from
>        * set*uid() to execve() because too many poorly written programs
> -      * don't check setuid() return code.  Here we additionally recheck
> +      * don't check setuid() return code. Here we additionally recheck
>        * whether NPROC limit is still exceeded.
>        */
>       if ((current->flags & PF_NPROC_EXCEEDED) &&
> --
> 2.49.0
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

