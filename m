Return-Path: <linux-fsdevel+bounces-9668-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84482844345
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 16:42:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F86C1F211D8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 15:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38EFD12AAED;
	Wed, 31 Jan 2024 15:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eAYRS6JE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JEcCUXZl";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eAYRS6JE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JEcCUXZl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8013D1292FA;
	Wed, 31 Jan 2024 15:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706715718; cv=none; b=pZju3J0nx0puZSIkBCggZbQJUm+109hAI0j9Jw6Yid3RiwshLOIhsmXrFxxNoZHHN8tKcFbXwnygkaQejmOpbnSH7wx5+lEiDn+zXYsxflruIoqMr1tUiR96K2eMVYVGno1Rl+YR0GwtJXmZVTrqBcse1UIF7D0FY1B/YFMwPWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706715718; c=relaxed/simple;
	bh=k975rr5SOQJ0akKpIS6Xf8RVc6oORwcCOak8L3VOgN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qEVhLmtMhFruNXNH2kXnf3NWNJQPKTLGMINfAbfdYQt1TWP5cZ7J6aBgdeFNftKB/pzlHzMzIsu5gAGgNlkhQHd3eYKFDRevlyWRanlrKP3MigFiaIF5kQ8EiHXuwbgNKp4w9ZRvXkDP8/dc9NJvYsqqtelR1y3Wkz6+6lQIDDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eAYRS6JE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=JEcCUXZl; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eAYRS6JE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=JEcCUXZl; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 99A931F747;
	Wed, 31 Jan 2024 15:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706715714; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DfCZX+hFUBlbWs8+8jojtXLtoVcojjb6ykWSphE2z1g=;
	b=eAYRS6JERcuIGWvi6Ek08YG+lfpfdU+UAgjzoDk7TwEInNVsdBf4o7EZXbfN0Y0JfD3dBs
	aobWKJqCIB0rO7brfn9fUSiZT/mn2cZ04fww5vWpgTp2gVtXvpjhASo+fdLTjVTrAEp7aI
	8zP5d9B3ea8I12U+4GCjKO9R6SMA6zc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706715714;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DfCZX+hFUBlbWs8+8jojtXLtoVcojjb6ykWSphE2z1g=;
	b=JEcCUXZltSMg4I4IO5xpTfXnvD8ZUTPWFRkM79oWnUGyAKuqqAs88AeT8qyKn9A19NT6zo
	zDhz8aK3F+mAXmCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706715714; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DfCZX+hFUBlbWs8+8jojtXLtoVcojjb6ykWSphE2z1g=;
	b=eAYRS6JERcuIGWvi6Ek08YG+lfpfdU+UAgjzoDk7TwEInNVsdBf4o7EZXbfN0Y0JfD3dBs
	aobWKJqCIB0rO7brfn9fUSiZT/mn2cZ04fww5vWpgTp2gVtXvpjhASo+fdLTjVTrAEp7aI
	8zP5d9B3ea8I12U+4GCjKO9R6SMA6zc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706715714;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DfCZX+hFUBlbWs8+8jojtXLtoVcojjb6ykWSphE2z1g=;
	b=JEcCUXZltSMg4I4IO5xpTfXnvD8ZUTPWFRkM79oWnUGyAKuqqAs88AeT8qyKn9A19NT6zo
	zDhz8aK3F+mAXmCA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 7DCC2132FA;
	Wed, 31 Jan 2024 15:41:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id cPeuHkJqumWyfwAAn2gu4w
	(envelope-from <jack@suse.cz>); Wed, 31 Jan 2024 15:41:54 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0ADF9A0809; Wed, 31 Jan 2024 16:41:54 +0100 (CET)
Date: Wed, 31 Jan 2024 16:41:53 +0100
From: Jan Kara <jack@suse.cz>
To: Edward Adam Davis <eadavis@qq.com>
Cc: syzbot+cdee56dbcdf0096ef605@syzkaller.appspotmail.com,
	adilger.kernel@dilger.ca, chandan.babu@oracle.com, jack@suse.com,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	syzkaller-bugs@googlegroups.com, tytso@mit.edu
Subject: Re: [PATCH] jbd2: user-memory-access in jbd2__journal_start
Message-ID: <20240131154153.domdzkkbqgpkplp2@quack3>
References: <000000000000d6e06d06102ae80b@google.com>
 <tencent_7F29369E974036964A3E742F778567CC3C09@qq.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_7F29369E974036964A3E742F778567CC3C09@qq.com>
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=eAYRS6JE;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=JEcCUXZl
X-Spamd-Result: default: False [1.69 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 FREEMAIL_TO(0.00)[qq.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[qq.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[cdee56dbcdf0096ef605];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 1.69
X-Rspamd-Queue-Id: 99A931F747
X-Spam-Level: *
X-Spam-Flag: NO
X-Spamd-Bar: +

On Wed 31-01-24 20:04:27, Edward Adam Davis wrote:
> Before reusing the handle, it is necessary to confirm that the transaction is 
> ready.
> 
> Reported-and-tested-by: syzbot+cdee56dbcdf0096ef605@syzkaller.appspotmail.com
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>

Sorry but no. Dave found a way to fix this particular problem in XFS and
your patch would not really improve anything because we'd just crash
when dereferencing handle->saved_alloc_context.

								Honza


> diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
> index cb0b8d6fc0c6..702312cd5392 100644
> --- a/fs/jbd2/transaction.c
> +++ b/fs/jbd2/transaction.c
> @@ -493,6 +493,9 @@ handle_t *jbd2__journal_start(journal_t *journal, int nblocks, int rsv_blocks,
>  		return ERR_PTR(-EROFS);
>  
>  	if (handle) {
> +		if (handle->saved_alloc_context & ~PF_MEMALLOC_NOFS)
> +			return ERR_PTR(-EBUSY);
> +
>  		J_ASSERT(handle->h_transaction->t_journal == journal);
>  		handle->h_ref++;
>  		return handle;
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

