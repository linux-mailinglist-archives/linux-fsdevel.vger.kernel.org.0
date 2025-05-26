Return-Path: <linux-fsdevel+bounces-49842-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD0DAC3FB7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 May 2025 14:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 389973B2904
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 May 2025 12:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83292202C4E;
	Mon, 26 May 2025 12:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gh6iEAGI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CHDDPm8y";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gh6iEAGI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CHDDPm8y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AB91FC7F1
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 May 2025 12:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748263978; cv=none; b=m25hP6eEEQMWx+S1K65YeTlChRnbItfG/Qz/F7aLOm24UeTT4znRH8PVroQBX0wzlOhyRz/L+8MCXAlNVIGzIAd2fvfwXNQhcNCzqYIqwt9YtYSEpJGYuT6f61lPg0+8tPyzssscn9NicXK3hSDvOUzK/tlEizhnt2H+MNNjivI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748263978; c=relaxed/simple;
	bh=nT0m7GfcKAnpdpvmDRC3OSDZMmEe+DX+2LbEm7ym4iE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gb1s26dAPdWF77alFKycIaQonttDxd02aa++sT/7rAIe8YB+Uh9zr/tIqTAcYlrUfTXQMDmbMoArv+ztagqVeAd9BlnuFH3aTn7UKkthVQPUFHCGckg400raO1etZGeWN4XWUZFe9ukH4d9+okGhUIynNNtK9p5DfeVzrIVatSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gh6iEAGI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CHDDPm8y; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gh6iEAGI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CHDDPm8y; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 44D271F797;
	Mon, 26 May 2025 12:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748263975; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B/NJGHMIbSu2rWIzGT+9H1Iz52GI7/dBbjqe7HujUuI=;
	b=gh6iEAGI2CLSfrGgj/SJsZvrUto9KKwIoRHACohFn1wx4ZUcA23R0MaxtV+ZaNjs4o3ol0
	wn07QaxEdOdPbjbOyrbrFM67VgCekEpATKETARMJkSnYnN4n/9VN1ll+/w18gz/jH0PDMV
	7blMW0IPXzLRW5XdrMTmXLalC/E9xRU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748263975;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B/NJGHMIbSu2rWIzGT+9H1Iz52GI7/dBbjqe7HujUuI=;
	b=CHDDPm8yMDZIyYdlxTCVkNIQTukEAlfT4x0dav3DIhnBJWkYA8xdZbFEw8DsG1JtMxBK/I
	mvi1KCRAO8/Xg+Dw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=gh6iEAGI;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=CHDDPm8y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748263975; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B/NJGHMIbSu2rWIzGT+9H1Iz52GI7/dBbjqe7HujUuI=;
	b=gh6iEAGI2CLSfrGgj/SJsZvrUto9KKwIoRHACohFn1wx4ZUcA23R0MaxtV+ZaNjs4o3ol0
	wn07QaxEdOdPbjbOyrbrFM67VgCekEpATKETARMJkSnYnN4n/9VN1ll+/w18gz/jH0PDMV
	7blMW0IPXzLRW5XdrMTmXLalC/E9xRU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748263975;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B/NJGHMIbSu2rWIzGT+9H1Iz52GI7/dBbjqe7HujUuI=;
	b=CHDDPm8yMDZIyYdlxTCVkNIQTukEAlfT4x0dav3DIhnBJWkYA8xdZbFEw8DsG1JtMxBK/I
	mvi1KCRAO8/Xg+Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3525113964;
	Mon, 26 May 2025 12:52:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ok/yDCdkNGiRLAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 26 May 2025 12:52:55 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 7CB53A09CC; Mon, 26 May 2025 14:52:50 +0200 (CEST)
Date: Mon, 26 May 2025 14:52:50 +0200
From: Jan Kara <jack@suse.cz>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
	Matthew Bobrowski <repnop@google.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] fanotify: wake-up all waiters on release
Message-ID: <xlbmnncnw6swdtf74nlbqkn57sxpt5f3bylpvhezdwgavx5h2r@boz7f5kg3x2q>
References: <3p5hvygkgdhrpbhphtjm55vnvprrgguk46gic547jlwdhjonw3@nz54h4fjnjkm>
 <20250520123544.4087208-1-senozhatsky@chromium.org>
 <bsji6w5ytunjt5vlgj6t53rrksqc7lp5fukwi2sbettzuzvnmg@fna73sxftrak>
 <ccdghhd5ldpqc3nps5dur5ceqa2dgbteux2y6qddvlfuq3ar4g@m42fp4q5ne7n>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ccdghhd5ldpqc3nps5dur5ceqa2dgbteux2y6qddvlfuq3ar4g@m42fp4q5ne7n>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,google.com,vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -4.01
X-Rspamd-Queue-Id: 44D271F797
X-Spam-Level: 
X-Spam-Flag: NO

On Fri 23-05-25 16:18:19, Sergey Senozhatsky wrote:
> On (25/05/21 12:18), Jan Kara wrote:
> > On Tue 20-05-25 21:35:12, Sergey Senozhatsky wrote:
> > > Once reply response is set for all outstanding requests
> > > wake_up_all() of the ->access_waitq waiters so that they
> > > can finish user-wait.  Otherwise fsnotify_destroy_group()
> > > can wait forever for ->user_waits to reach 0 (which it
> > > never will.)
> > > 
> > > Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> > 
> > We don't use exclusive waits with access_waitq so wake_up() and
> > wake_up_all() should do the same thing?
> 
> Oh, non-exclusive waiters, I see.  I totally missed that, thanks.
> 
> So... the problem is somewhere else then.  I'm currently looking
> at some crashes (across all LTS kernels) where group owner just
> gets stuck and then hung-task watchdog kicks in and panics the
> system.  Basically just a single backtrace in the kernel logs:
> 
>  schedule+0x534/0x2540
>  fsnotify_destroy_group+0xa7/0x150
>  fanotify_release+0x147/0x160
>  ____fput+0xe4/0x2a0
>  task_work_run+0x71/0xb0
>  do_exit+0x1ea/0x800
>  do_group_exit+0x81/0x90
>  get_signal+0x32d/0x4e0
> 
> My assumption was that it's this wait:
> 	wait_event(group->notification_waitq, !atomic_read(&group->user_waits));

Well, you're likely correct we are sleeping in this wait. But likely
there's some process that's indeed waiting for response to fanotify event
from userspace. Do you have a reproducer? Can you dump all blocked tasks
when this happens?

									Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

