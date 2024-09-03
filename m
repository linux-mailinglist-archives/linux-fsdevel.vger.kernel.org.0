Return-Path: <linux-fsdevel+bounces-28443-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D640796A4CE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 18:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54BE91F24CF0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 16:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10BCB18BC1C;
	Tue,  3 Sep 2024 16:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BG+1/z6O";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8/QRhtk1";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Ee4CIHif";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DdPV61m2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BA21E492;
	Tue,  3 Sep 2024 16:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725382117; cv=none; b=AqBaothsq6fDbKRgfGeP7nZMmfFNFSV11DBNE3iStQVLwwKMtyDkHLvqh0fGQ3ewuZ9LoM3JlnGr+h49iN50OytwI8g7N9U6EpRFnNQB108w9bHezd+VMCZ81EOJxzgCNCuPkgCQHaDm87DaHgksY3VjZTcH5iwvnL7PdMWfyuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725382117; c=relaxed/simple;
	bh=UTJ0ezJAMpnXVXNLZXHJ9VAh/V9K3qjhuxBliOP2V8Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CMSc0hgLk0v2Nou4cOJtGMpc+S0YFMMwU176hO4Dm+HdTgC5ZkQqZ2NYqOnnkE2SYgsS0mH7K097ChNd8oLk1kUmzxz3I2HR76aCabBTvRZ9KO57A3Q+QIRlhuU/8Bana5k3224PMWiPVXr3nT4hh6dFkPYHaEvTz11rv6qwFXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BG+1/z6O; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8/QRhtk1; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Ee4CIHif; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DdPV61m2; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CD298219CC;
	Tue,  3 Sep 2024 16:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725382114; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uUkAGhQlI+yN4lwMNeG2MzsSwkm6SHFc/Agy8/FGBY0=;
	b=BG+1/z6Oa4xCqXijpfqb0qkQBjTa3ynwZsFzvpvG+fGzfN9MvMZqnmEsMo/W9QgW8lJlrS
	HucTlRhaI+dBuBCPPiIVqIoNcLptKQObHWGXef4C4uLqq/yzUP7ru4oKux1uutPSFxkNhe
	2w5+bDoziaPaKZUlQLPtMRTkwGxrKow=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725382114;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uUkAGhQlI+yN4lwMNeG2MzsSwkm6SHFc/Agy8/FGBY0=;
	b=8/QRhtk1SwDUgJST482Y1CEEGNq33oYAjAFQDn6a4kK398LpGBGugp3OiAD3c7E2gnojfk
	yhtl9U6EeyKMZ0Ag==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Ee4CIHif;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=DdPV61m2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725382113; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uUkAGhQlI+yN4lwMNeG2MzsSwkm6SHFc/Agy8/FGBY0=;
	b=Ee4CIHifY0caKzGXsIXem59s6we1GUHo4DNd+2KTISAufj7iHtOyusrcEfgB0i/OYVInKW
	BMlVPfo/TvkddoLNBj91rx9yK4DHG8eX6BSjdvAJqDlrbiOOLVRkX2PNYMI1tX7cubDLpA
	/C3Pw098Ei86IUtzRICpcgdVpPlYNj0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725382113;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uUkAGhQlI+yN4lwMNeG2MzsSwkm6SHFc/Agy8/FGBY0=;
	b=DdPV61m2rAocFS6QNwErVt281xUR6BhGj7CkkQpmS0SUhf/Kl+ak2EAd9FXWJbbeybwiAx
	cF9gmvC2KJjcWuBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8C48213A80;
	Tue,  3 Sep 2024 16:48:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MuVOHOE912arCAAAD6G6ig
	(envelope-from <krisman@suse.de>); Tue, 03 Sep 2024 16:48:33 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@igalia.com>
Cc: Hugh Dickins <hughd@google.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  Alexander Viro <viro@zeniv.linux.org.uk>,
  Christian Brauner <brauner@kernel.org>,  Jan Kara <jack@suse.cz>,
  krisman@kernel.org,  linux-mm@kvack.org,  linux-kernel@vger.kernel.org,
  linux-fsdevel@vger.kernel.org,  kernel-dev@igalia.com,  Daniel Rosenberg
 <drosen@google.com>,  smcv@collabora.com,  Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 1/8] unicode: Fix utf8_load() error path
In-Reply-To: <20240902225511.757831-2-andrealmeid@igalia.com>
 (=?utf-8?Q?=22Andr=C3=A9?=
	Almeida"'s message of "Mon, 2 Sep 2024 19:55:03 -0300")
References: <20240902225511.757831-1-andrealmeid@igalia.com>
	<20240902225511.757831-2-andrealmeid@igalia.com>
Date: Tue, 03 Sep 2024 12:48:28 -0400
Message-ID: <87wmjsfztv.fsf@mailhost.krisman.be>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: CD298219CC
X-Spam-Level: 
X-Spamd-Result: default: False [-6.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -6.51
X-Spam-Flag: NO

Andr=C3=A9 Almeida <andrealmeid@igalia.com> writes:

> utf8_load() requests the symbol "utf8_data_table" and then checks if the
> requested UTF-8 version is supported. If it's unsupported, it tries to
> put the data table using symbol_put(). If an unsupported version is
> requested, symbol_put() fails like this:
>
>  kernel BUG at kernel/module/main.c:786!
>  RIP: 0010:__symbol_put+0x93/0xb0
>  Call Trace:
>   <TASK>
>   ? __die_body.cold+0x19/0x27
>   ? die+0x2e/0x50
>   ? do_trap+0xca/0x110
>   ? do_error_trap+0x65/0x80
>   ? __symbol_put+0x93/0xb0
>   ? exc_invalid_op+0x51/0x70
>   ? __symbol_put+0x93/0xb0
>   ? asm_exc_invalid_op+0x1a/0x20
>   ? __pfx_cmp_name+0x10/0x10
>   ? __symbol_put+0x93/0xb0
>   ? __symbol_put+0x62/0xb0
>   utf8_load+0xf8/0x150
>
> That happens because symbol_put() expects the unique string that
> identify the symbol, instead of a pointer to the loaded symbol. Fix that
> by using such string.
>

Thanks!

I picked only this one via the for-next branch of the unicode tree.  No nee=
d to resubmit
this one with the rest of the series.

--=20
Gabriel Krisman Bertazi

