Return-Path: <linux-fsdevel+bounces-75479-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJrgLASSd2m9hgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75479-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 17:10:44 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B1D8A837
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 17:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8995E3007A59
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 16:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7ED02D7814;
	Mon, 26 Jan 2026 16:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RN8VkIHY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ojcynTYS";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RN8VkIHY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ojcynTYS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB582D5957
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jan 2026 16:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769443832; cv=none; b=BpMUYUxobmFyi0alVk1LaVKNppahvRXg/Z9sZj6rHZJhcyoqtVxQ981gVRT+HzkIeWbyNbMAy4LMPBZYR75L5mGrKhNnUcD+BPs471SMS+XoE61F/0R4w+4wCvRskMRKyU/jzBsIxTojgZg4fa9Ph1ZW2krub6lr3R/TbmJn6gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769443832; c=relaxed/simple;
	bh=0N29Pr+/B2DTF6BzS0Dp6fjp92yCuMliUu9rimnIl+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EN7x+XXoHMpZEUP5JXSyUjZzn5TO5ZCcKYRnIeo3wCjj31UJRuRfbAwyvnb2doZ/okLSPgFJoa4uBhPpGHwySAuEPeXX36uOiqM5dYC0VVeM8v3C0Y0WlJiP433ni1bDiQUWbFFTORvWq+u9+SIEmOLEVeL75gSUzAyKqCnr6sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RN8VkIHY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ojcynTYS; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RN8VkIHY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ojcynTYS; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6B2673376A;
	Mon, 26 Jan 2026 16:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769443829; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jJeVDRrhlcmWdM2XUf7QKzG84yv6IYsaaRkWCI4tEpg=;
	b=RN8VkIHYSQ3TyLHJ0uRxOn76tysfos1DoxnNjJiP5uRAcnb/CYFJGTESlGcSBUays/D+/7
	RSZu4d0Nn2Jlq27LJyWbvCqjyCvO6Ijbj5pUecI0SYKADtVgPJzLlv0BIoHo3Uj+oyPPI9
	9l9/7I5u0WKaZuplGZyuZNgFjK/DpuU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769443829;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jJeVDRrhlcmWdM2XUf7QKzG84yv6IYsaaRkWCI4tEpg=;
	b=ojcynTYSUdDI84pzWF/ggYgPdB5qzy544Cin+GBlJX75aHxnKuMJjQRhgGvHL/MHLRBV4S
	i90o1/839QynW5CA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=RN8VkIHY;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ojcynTYS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769443829; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jJeVDRrhlcmWdM2XUf7QKzG84yv6IYsaaRkWCI4tEpg=;
	b=RN8VkIHYSQ3TyLHJ0uRxOn76tysfos1DoxnNjJiP5uRAcnb/CYFJGTESlGcSBUays/D+/7
	RSZu4d0Nn2Jlq27LJyWbvCqjyCvO6Ijbj5pUecI0SYKADtVgPJzLlv0BIoHo3Uj+oyPPI9
	9l9/7I5u0WKaZuplGZyuZNgFjK/DpuU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769443829;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jJeVDRrhlcmWdM2XUf7QKzG84yv6IYsaaRkWCI4tEpg=;
	b=ojcynTYSUdDI84pzWF/ggYgPdB5qzy544Cin+GBlJX75aHxnKuMJjQRhgGvHL/MHLRBV4S
	i90o1/839QynW5CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5225B139F0;
	Mon, 26 Jan 2026 16:10:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id t4YJFPWRd2lnBwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 26 Jan 2026 16:10:29 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 08BEFA0A4F; Mon, 26 Jan 2026 17:10:29 +0100 (CET)
Date: Mon, 26 Jan 2026 17:10:28 +0100
From: Jan Kara <jack@suse.cz>
To: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, jlayton@kernel.org, 
	chuck.lever@oracle.com, alex.aring@gmail.com, arnd@arndb.de
Subject: Re: [PATCH v2 1/2] open: new O_REGULAR flag support
Message-ID: <7vfuydqp3hrlnld2mf6j5u4bmcecpaxz4pbkbrp2cnsk5lddsu@mvnaqal25dty>
References: <20260126154156.55723-1-dorjoychy111@gmail.com>
 <20260126154156.55723-2-dorjoychy111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126154156.55723-2-dorjoychy111@gmail.com>
X-Spam-Flag: NO
X-Spam-Score: -2.51
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75479-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	DMARC_NA(0.00)[suse.cz];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,gmail.com,arndb.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D6B1D8A837
X-Rspamd-Action: no action

On Mon 26-01-26 21:39:21, Dorjoy Chowdhury wrote:
> This flag indicates the path should be opened if it's a regular file.
> A relevant error code ENOTREGULAR(35) has been introduced. For example,
> if open is called on path /dev/null with O_REGULAR in the flag param,
> it will return -ENOTREGULAR.
> 
> When used in combination with O_CREAT, either the regular file is
> created, or if the path already exists, it is opened if it's a regular
> file. Otherwise, -ENOTREGULAR is returned.
> 
> -EINVAL is returned when O_REGULAR is combined with O_DIRECTORY (not
> part of O_TMPFILE) because it doesn't make sense to open a path that
> is both a directory and a regular file.
> 
> Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>

The feature looks useful to me (but the justification with the danger of
being tricked into opening some device nodes would be nice to have here in
the changelog).

> diff --git a/arch/parisc/include/uapi/asm/fcntl.h b/arch/parisc/include/uapi/asm/fcntl.h
> index 03dee816cb13..efd763335ff7 100644
> --- a/arch/parisc/include/uapi/asm/fcntl.h
> +++ b/arch/parisc/include/uapi/asm/fcntl.h
> @@ -19,6 +19,7 @@
>  
>  #define O_PATH	020000000
>  #define __O_TMPFILE	040000000
> +#define O_REGULAR	060000000

This looks wrong? O_REGULAR is overlapping with O_PATH and __O_TMPFILE???

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

