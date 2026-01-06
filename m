Return-Path: <linux-fsdevel+bounces-72466-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF1CCF7962
	for <lists+linux-fsdevel@lfdr.de>; Tue, 06 Jan 2026 10:44:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36597314B23E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jan 2026 09:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8463C318138;
	Tue,  6 Jan 2026 09:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fNOttcDz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="w/op0Fur";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fNOttcDz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="w/op0Fur"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B87731A068
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Jan 2026 09:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767692242; cv=none; b=KHdQ2tLq4aZlkOw99JvWkuozu5h23wHmmYTvXuYU3jueN/dQItFTcNBhOORdEuTbQgL3qeIl6fRFuQoabPBihc00f+VbUMdZL1F3cMNxw0HuMH6pUo8eN/0yjhy/NlSbgzy0sFKc/XE44rNkH2S6BqX8pXk4nVsED+Xy2Ha2J4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767692242; c=relaxed/simple;
	bh=ZaIFvQOFNQYXhuMgMELgmqgnnv024dQ1ZNJhj/NqTow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LtM7RjJsKsR9LylYkfq6DnsZeKuuQQmRMcsfziqbsMFlsZOmh2mGs+X5p7NmWXyiC9mfLHqN81S3nMLgTZD1tYALRQG49He8D3pWVdolPoqHvuV0guLvOZhETaGzqmp+BUUspzNbn9avXBqXAfE3vglweUq/3ZxBjNaRwLnCiDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fNOttcDz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=w/op0Fur; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fNOttcDz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=w/op0Fur; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0E7BF339CF;
	Tue,  6 Jan 2026 09:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767692234; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AOCIXAcTuRRdZ8S4tLuvVNZtxAfk844SW2nOMBZZgqM=;
	b=fNOttcDzZRh5Py6YV89ZFtZCMCYBF427GkiDl0i0+4ogSeRU5QFb5faCk2/hMXMankmwVD
	acIRaYQODeQPDZko2P7s7be7ipYmhVm87IJ4G+VcWy7KxhQlTE2kzSstrtNeYMoanjp19K
	jlCmF/k9IuqNLy+Y9Js9MvfdNtgY3/c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767692234;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AOCIXAcTuRRdZ8S4tLuvVNZtxAfk844SW2nOMBZZgqM=;
	b=w/op0Fur/Xg4UIquZbZBR49f8hT/UDWBuBgWhicD8k1PK3AQMdrhavjDxKUiLKvzv1J11l
	TTmRRchPQ3HXkGCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=fNOttcDz;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="w/op0Fur"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767692234; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AOCIXAcTuRRdZ8S4tLuvVNZtxAfk844SW2nOMBZZgqM=;
	b=fNOttcDzZRh5Py6YV89ZFtZCMCYBF427GkiDl0i0+4ogSeRU5QFb5faCk2/hMXMankmwVD
	acIRaYQODeQPDZko2P7s7be7ipYmhVm87IJ4G+VcWy7KxhQlTE2kzSstrtNeYMoanjp19K
	jlCmF/k9IuqNLy+Y9Js9MvfdNtgY3/c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767692234;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AOCIXAcTuRRdZ8S4tLuvVNZtxAfk844SW2nOMBZZgqM=;
	b=w/op0Fur/Xg4UIquZbZBR49f8hT/UDWBuBgWhicD8k1PK3AQMdrhavjDxKUiLKvzv1J11l
	TTmRRchPQ3HXkGCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0644F3EA63;
	Tue,  6 Jan 2026 09:37:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AmaGAcrXXGnScAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 06 Jan 2026 09:37:14 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id BB4E5A08E3; Tue,  6 Jan 2026 10:37:09 +0100 (CET)
Date: Tue, 6 Jan 2026 10:37:09 +0100
From: Jan Kara <jack@suse.cz>
To: Laveesh Bansal <laveeshb@laveeshbansal.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	tytso@mit.edu, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] docs: clarify that dirtytime_expire_seconds=0
 disables writeback
Message-ID: <lzbix55ms6mxta5xf4yvkr66qhxnomqc34diinzqrfluvr2xd7@vnzhyi5r44qe>
References: <20260102201657.305094-1-laveeshb@laveeshbansal.com>
 <20260102201657.305094-3-laveeshb@laveeshbansal.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260102201657.305094-3-laveeshb@laveeshbansal.com>
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Rspamd-Queue-Id: 0E7BF339CF
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,suse.cz:email];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Level: 

On Fri 02-01-26 20:16:57, Laveesh Bansal wrote:
> Document that setting vm.dirtytime_expire_seconds to zero disables
> periodic dirtytime writeback, matching the behavior of the related
> dirty_writeback_centisecs sysctl which already documents this.
> 
> Signed-off-by: Laveesh Bansal <laveeshb@laveeshbansal.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  Documentation/admin-guide/sysctl/vm.rst | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
> index 4d71211fdad8..e2fdbc521033 100644
> --- a/Documentation/admin-guide/sysctl/vm.rst
> +++ b/Documentation/admin-guide/sysctl/vm.rst
> @@ -231,6 +231,8 @@ eventually gets pushed out to disk.  This tunable is used to define when dirty
>  inode is old enough to be eligible for writeback by the kernel flusher threads.
>  And, it is also used as the interval to wakeup dirtytime_writeback thread.
>  
> +Setting this to zero disables periodic dirtytime writeback.
> +
>  
>  dirty_writeback_centisecs
>  =========================
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

