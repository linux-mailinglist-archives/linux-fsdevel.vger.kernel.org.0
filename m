Return-Path: <linux-fsdevel+bounces-33776-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 309309BEAFE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 13:54:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 529C41C23BF5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 12:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67DBE2036F5;
	Wed,  6 Nov 2024 12:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vqhCgkyp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VbMxvtmi";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KKpogcNS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="L1WJ1IRV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCF01E1049;
	Wed,  6 Nov 2024 12:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730896810; cv=none; b=mVb531cxfT1R4wMqMivUGiqmja7OJF75Wevhd2LpNNLR+JVOM95kI9aOe7WSI/GrBSDfVr/wQiPTscFtE+ReJxGOE9U5OpcGJx42AbbLd+xfP0IEsUXl2mtJUat+LAsTJ9PJ7r5mJb48QBXPMkPwfgF3xHT2FC8Hb2Lk74PVmaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730896810; c=relaxed/simple;
	bh=RNuTLGqC+bLXTtNPaVpjRNEjHj4wu2QtxANcNPKNJYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Phv25Ug67ye10mocsHnA8fGnWUB5covoeTYziUl8diKfqKZhWfFr+JfxCSb5YUnGLzdozjjtDyb1/GXJWQZCiK9rQupkOmg6W0ihefBnZMRItkNtsP8bzvmnaQjVjrnMPc5rNAbtQ/ksLYVL1LY09TSau1ox1KNSnIxWRz3eQbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vqhCgkyp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VbMxvtmi; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KKpogcNS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=L1WJ1IRV; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7C37D1FF3E;
	Wed,  6 Nov 2024 12:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730896806; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JzNZyCZ+EZSIT2sghTEuwBerYxmZUtNlOdMuhYFO3uw=;
	b=vqhCgkypUz0QgFah9t67g6EZIBjs97ql9cTlo+4ZvXiobElZKGyjo8ktcdCxiKtZXHWqXw
	FoTmj+EiDMCGWqoAavoXTo5ym+knkkGSsSuZfsiu+Vl0F+4yQNJ/uU6uEnS82SWUl7Y8iY
	Daq7OLAOi4VButOUhKMBz9cdKQ4GO2o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730896806;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JzNZyCZ+EZSIT2sghTEuwBerYxmZUtNlOdMuhYFO3uw=;
	b=VbMxvtmit7wva7R1Jp02YBdazc32k/DF4cSci0eiqnF9vHNRe1647w3m55wYQ1SEsnAmv8
	Z4A7IVrN1Xhme3BQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=KKpogcNS;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=L1WJ1IRV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730896804; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JzNZyCZ+EZSIT2sghTEuwBerYxmZUtNlOdMuhYFO3uw=;
	b=KKpogcNSgaA4mWFCjJHtgTXe/e5O/21h+QlWasEl1Ifsx9QGBOobgENn0f827Pw8dtdUm3
	Zz04JcVIOyvpvOub7XJ3JG/hSqxZzFGy/tMPaKTpEmnRka3/ARtdoLTy3L/rCAFc31Wlps
	QPD4ssNdnDQfq7bEX7qCkVJ1Tyyds4E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730896804;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JzNZyCZ+EZSIT2sghTEuwBerYxmZUtNlOdMuhYFO3uw=;
	b=L1WJ1IRViRWfaUYX9kUW3bc4wx8a+Xba3+2NxlQw7d1Vf0cUBJjTkpxFDusRhJVCcFoKWr
	anlkkf48PMCnnACQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7257613736;
	Wed,  6 Nov 2024 12:40:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xLzkG6RjK2ehEwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 06 Nov 2024 12:40:04 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 26022A0AF6; Wed,  6 Nov 2024 13:40:00 +0100 (CET)
Date: Wed, 6 Nov 2024 13:40:00 +0100
From: Jan Kara <jack@suse.cz>
To: Hao Ge <hao.ge@linux.dev>
Cc: jack@suse.cz, sandeen@redhat.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, Hao Ge <gehao@kylinos.cn>
Subject: Re: [PATCH] isofs: avoid memory leak in iocharset
Message-ID: <20241106124000.kcrscsv5nrtporjs@quack3>
References: <20241106082841.51773-1-hao.ge@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106082841.51773-1-hao.ge@linux.dev>
X-Rspamd-Queue-Id: 7C37D1FF3E
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
	ARC_NA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Wed 06-11-24 16:28:41, Hao Ge wrote:
> From: Hao Ge <gehao@kylinos.cn>
> 
> A memleak was found as below:
> 
> unreferenced object 0xffff0000d10164d8 (size 8):
>   comm "pool-udisksd", pid 108217, jiffies 4295408555
>   hex dump (first 8 bytes):
>     75 74 66 38 00 cc cc cc                          utf8....
>   backtrace (crc de430d31):
>     [<ffff800081046e6c>] kmemleak_alloc+0xb8/0xc8
>     [<ffff8000803e6c3c>] __kmalloc_node_track_caller_noprof+0x380/0x474
>     [<ffff800080363b74>] kstrdup+0x70/0xfc
>     [<ffff80007bb3c6a4>] isofs_parse_param+0x228/0x2c0 [isofs]
>     [<ffff8000804d7f68>] vfs_parse_fs_param+0xf4/0x164
>     [<ffff8000804d8064>] vfs_parse_fs_string+0x8c/0xd4
>     [<ffff8000804d815c>] vfs_parse_monolithic_sep+0xb0/0xfc
>     [<ffff8000804d81d8>] generic_parse_monolithic+0x30/0x3c
>     [<ffff8000804d8bfc>] parse_monolithic_mount_data+0x40/0x4c
>     [<ffff8000804b6a64>] path_mount+0x6c4/0x9ec
>     [<ffff8000804b6e38>] do_mount+0xac/0xc4
>     [<ffff8000804b7494>] __arm64_sys_mount+0x16c/0x2b0
>     [<ffff80008002b8dc>] invoke_syscall+0x7c/0x104
>     [<ffff80008002ba44>] el0_svc_common.constprop.1+0xe0/0x104
>     [<ffff80008002ba94>] do_el0_svc+0x2c/0x38
>     [<ffff800081041108>] el0_svc+0x3c/0x1b8
> 
> The opt->iocharset is freed inside the isofs_fill_super function,
> But there may be situations where it's not possible to
> enter this function.
> 
> For example, in the get_tree_bdev_flags function,when
> encountering the situation where "Can't mount, would change RO state,"
> In such a case, isofs_fill_super will not have the opportunity
> to be called,which means that opt->iocharset will not have the chance
> to be freed,ultimately leading to a memory leak.
> 
> Let's move the memory freeing of opt->iocharset into
> isofs_free_fc function.
> 
> Fixes: 1b17a46c9243 ("isofs: convert isofs to use the new mount API")
> Signed-off-by: Hao Ge <gehao@kylinos.cn>

Thanks. I've added the patch to my tree.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

