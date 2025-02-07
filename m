Return-Path: <linux-fsdevel+bounces-41194-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1430AA2C359
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 14:15:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 110D53AA09D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 13:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAEFF1EEA47;
	Fri,  7 Feb 2025 13:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YOq4YYUS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="KTXi4u2G";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YOq4YYUS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="KTXi4u2G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662741D6DBF;
	Fri,  7 Feb 2025 13:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738934121; cv=none; b=bh1tHY5DQSudzp0iEycf54JakiXO+/M/FO5NXaKpMlS2jKiUJ8lJZmDdoVTHEYzHbwbC+sTKN3BNCSFQbtTHvAiKOwervwAYY/+lR02Pc/ml6CyGkWw5kYUghc3gU8OqnVHr9tCXxiivn0QDrLvdgr5dO3S9hDas4vazMDCRUbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738934121; c=relaxed/simple;
	bh=T6xnxMo+3E7IYT9I23sOjqoyFjnzkGTfohW3PKg5IJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oT3MvI+kLPHqyisw6ynmsa6PtSxgXE57BFiIds51tIjIof4VcCAooe7VAvL91E8GnmlD1trTADc9O8hVuBIgu/Mw9DJyvFnfNb9qEFBmMVo0XJ8y6uyErzdsn/K6x/AIfUr+HIUO4F+aD3YaVKmnbEU8vradOWVNTSv5uC9loNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YOq4YYUS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=KTXi4u2G; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YOq4YYUS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=KTXi4u2G; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 791DE1F443;
	Fri,  7 Feb 2025 13:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1738934117; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jzYpOfmS3fb9ohYmxjlyO8G3DqMjZBqdmpu1R8Sh72c=;
	b=YOq4YYUS1cITWiZDN1ynTctOgYoBYL3f+khHUZit0NCU+vDhLJ8jwpINxVtMB0cwdAJC90
	8YljGf/Z4S/dB/KafsFV0tYRGVv6yjf6hrdMHNeVUoU+g1ji9Q+WNtQ9/xVdvfv0Z3WM9z
	CtPMaFiuXyTcgC5gRgdsUzlh7at3ezA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1738934117;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jzYpOfmS3fb9ohYmxjlyO8G3DqMjZBqdmpu1R8Sh72c=;
	b=KTXi4u2GP1nDB0u5l2wVtq/xBi8bCbcUdxfwtiPwZUu0my6oVaHIy5AZKIdkFW8dpY8FGa
	XL25fmE0rhbn4OCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=YOq4YYUS;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=KTXi4u2G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1738934117; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jzYpOfmS3fb9ohYmxjlyO8G3DqMjZBqdmpu1R8Sh72c=;
	b=YOq4YYUS1cITWiZDN1ynTctOgYoBYL3f+khHUZit0NCU+vDhLJ8jwpINxVtMB0cwdAJC90
	8YljGf/Z4S/dB/KafsFV0tYRGVv6yjf6hrdMHNeVUoU+g1ji9Q+WNtQ9/xVdvfv0Z3WM9z
	CtPMaFiuXyTcgC5gRgdsUzlh7at3ezA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1738934117;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jzYpOfmS3fb9ohYmxjlyO8G3DqMjZBqdmpu1R8Sh72c=;
	b=KTXi4u2GP1nDB0u5l2wVtq/xBi8bCbcUdxfwtiPwZUu0my6oVaHIy5AZKIdkFW8dpY8FGa
	XL25fmE0rhbn4OCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 635BA13694;
	Fri,  7 Feb 2025 13:15:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6Gg9GGUHpmdkJQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 07 Feb 2025 13:15:17 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id CA30FA28E7; Fri,  7 Feb 2025 14:15:01 +0100 (CET)
Date: Fri, 7 Feb 2025 14:15:01 +0100
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] vfs: add initial support for CONFIG_VFS_DEBUG
Message-ID: <k5js2kdu3yufjjbypiwoy5abvmbnmr6ffkkybjs7sdvw4nwipf@za2flx7oe35i>
References: <20250206170307.451403-1-mjguzik@gmail.com>
 <20250206170307.451403-2-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206170307.451403-2-mjguzik@gmail.com>
X-Rspamd-Queue-Id: 791DE1F443
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Thu 06-02-25 18:03:05, Mateusz Guzik wrote:
> Small collection of macros taken from mmdebug.h
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

For start this looks good! Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

BTW:

> +/*
> + * TODO: add a proper inode dumping routine, this is a stub to get debug off the ground
> + */
> +static inline void dump_inode(struct inode *inode, const char *reason) {
> +	pr_crit("%s failed for inode %px", reason, inode);
> +}

fs/inode.c:dump_mapping() already has quite a bit of what you'd want here
so just refactoring dump_mapping() so it can be used in the new asserts
would get you 90% there I'd think.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

