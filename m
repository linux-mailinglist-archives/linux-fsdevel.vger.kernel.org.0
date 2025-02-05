Return-Path: <linux-fsdevel+bounces-40944-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A244CA296E5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 17:59:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 030F03A79AA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 16:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602231DD526;
	Wed,  5 Feb 2025 16:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="O1tgVE6x";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0utQJUmW";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="O1tgVE6x";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0utQJUmW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E651DAC92
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Feb 2025 16:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738774745; cv=none; b=J7+zg2s4Bl84cfR4tL+RmjdeAce2ZMmH690zfNrlztRODQGv2UiVwlo8oodyotaQvGXr3NW+NQpMwsTEWyQsPYWtJDt+XxzkOJpZ6/vZGzckmHPRj3Kx9sQcTnK6IKuNf/dHcJme5pvqtn7ctKXNDEjexiXKbgcdo2coCrJWNEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738774745; c=relaxed/simple;
	bh=1tXTJPwiNItgNNW0u9ylwwXrx7F+wY8mOY0mZuw+oUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jtiKqYasoZrbFy39lDwvkTXbG4X0+FaYVIh5QJuYrd5sCN6OI2OAER3h64MtK6edQ3J5PJZCM/mONusf+QMl54iouwQg6yqjpK2BfRXsnp6WmZ0g6XCOtRbMq3MzRDw0yZKUrbVAZ3UhyZJN6P5N9AReBH+tbkN2mi20mp+znW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=O1tgVE6x; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0utQJUmW; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=O1tgVE6x; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0utQJUmW; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 26E7B1F7E0;
	Wed,  5 Feb 2025 16:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1738774742; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6aKUA+vtc6/UwCle6yCfjM1WzWjXkpRq0N8ifKxdRZI=;
	b=O1tgVE6xadWgC+qa2kQ4W0w/apMnTcp8av7xm9qfD0QOGBgotj8Pe4iwHZMlSrUctN3ax2
	rvDsZDSFxchmcmH5RguwUggwlbwp8dfKO1bLvtP6rErHlW9r536cqkoUQnS4TrUSz2Z6xJ
	GPEjQyZaqnhgMtU2JuoAFYqhZuho2Qs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1738774742;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6aKUA+vtc6/UwCle6yCfjM1WzWjXkpRq0N8ifKxdRZI=;
	b=0utQJUmWWwa9PwTN5E3RPL6/0NcLnc8W4wib+YSgfPKA+os+5i5IeimpxXfEorShF8lIOk
	840FSkqxn0Pt2fDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=O1tgVE6x;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=0utQJUmW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1738774742; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6aKUA+vtc6/UwCle6yCfjM1WzWjXkpRq0N8ifKxdRZI=;
	b=O1tgVE6xadWgC+qa2kQ4W0w/apMnTcp8av7xm9qfD0QOGBgotj8Pe4iwHZMlSrUctN3ax2
	rvDsZDSFxchmcmH5RguwUggwlbwp8dfKO1bLvtP6rErHlW9r536cqkoUQnS4TrUSz2Z6xJ
	GPEjQyZaqnhgMtU2JuoAFYqhZuho2Qs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1738774742;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6aKUA+vtc6/UwCle6yCfjM1WzWjXkpRq0N8ifKxdRZI=;
	b=0utQJUmWWwa9PwTN5E3RPL6/0NcLnc8W4wib+YSgfPKA+os+5i5IeimpxXfEorShF8lIOk
	840FSkqxn0Pt2fDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F404F139D8;
	Wed,  5 Feb 2025 16:59:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id r0VBO9WYo2f1PwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 05 Feb 2025 16:59:01 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id F1880A28E9; Wed,  5 Feb 2025 17:59:00 +0100 (CET)
Date: Wed, 5 Feb 2025 17:59:00 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Alex Williamson <alex.williamson@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/3] fsnotify: disable pre-content and permission events
 by default
Message-ID: <qenzc7wi2ojknvcch7d4xac7p7fh7p47bws22fpuuiqtwpsbs5@wfk6rnyxiece>
References: <20250203223205.861346-1-amir73il@gmail.com>
 <20250203223205.861346-4-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250203223205.861346-4-amir73il@gmail.com>
X-Rspamd-Queue-Id: 26E7B1F7E0
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Mon 03-02-25 23:32:05, Amir Goldstein wrote:
> After introducing pre-content events, we had a regression related to
> disabling huge faults on files that should never have pre-content events
> enabled.
> 
> This happened because the default f_mode of allocated files (0) does
> not disable pre-content events.
> 
> Pre-content events are disabled in file_set_fsnotify_mode_by_watchers()
> but internal files may not get to call this helper.
> 
> Initialize f_mode to disable permission and pre-content events for all
> files and if needed they will be enabled for the callers of
> file_set_fsnotify_mode_by_watchers().
> 
> Fixes: 20bf82a898b6 ("mm: don't allow huge faults for files with pre content watches")
> Reported-by: Alex Williamson <alex.williamson@redhat.com>
> Closes: https://lore.kernel.org/linux-fsdevel/20250131121703.1e4d00a7.alex.williamson@redhat.com/
> Tested-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

What makes me somewhat uneasy is that this relies on the fact that
file_set_fsnotify_mode_from_watchers() will override the
FMODE_NONOTIFY_PERM (but it does not override FMODE_NONOTIFY). This seems a
bit subtle and I was looking into if we could somehow simplify the fsnotify
fmode initialization. But I didn't find anything that would be really
simpler so let's keep what we have for now.

								Honza

> ---
>  fs/file_table.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/fs/file_table.c b/fs/file_table.c
> index 35b93da6c5cb1..5c00dc38558da 100644
> --- a/fs/file_table.c
> +++ b/fs/file_table.c
> @@ -194,6 +194,11 @@ static int init_file(struct file *f, int flags, const struct cred *cred)
>  	 * refcount bumps we should reinitialize the reused file first.
>  	 */
>  	file_ref_init(&f->f_ref, 1);
> +	/*
> +	 * Disable permission and pre-content events for all files by default.
> +	 * They may be enabled later by file_set_fsnotify_mode_from_watchers().
> +	 */
> +	file_set_fsnotify_mode(f, FMODE_NONOTIFY_PERM);
>  	return 0;
>  }
>  
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

