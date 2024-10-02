Return-Path: <linux-fsdevel+bounces-30710-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E24A298DD94
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 16:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98FBF283D2B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 14:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C4501D042F;
	Wed,  2 Oct 2024 14:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BatF9FdX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jTG6NEYG";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BatF9FdX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jTG6NEYG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D391CEEAF
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Oct 2024 14:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727880476; cv=none; b=ZejnpGVCqgXaeP0Wy7OZD2RUe0FZqeo1Gd0nm7Gadqg1ke3cnxfZacHDhK6xLHYZ7aesCS22x5yBJme6f25J3Ph88Djnel1eJxrMRvY+ym2MweXosieb0Nyo1aCLZoUQO+TW1UNHdekhHQVh8RqJm4ZWj5tyZjTt1YJDlCsI4xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727880476; c=relaxed/simple;
	bh=7a+KKAd9tSYA1CgnUCeIa+kFXUkAeEDwDPM7KGba1xw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R42pIlmUiliWo2TIG3g/cU8abcilZLxdup+MYqErUKpuJhKSsuIYOiKwmr7ZI8RcUViJjy5M8Sbz/07TuGdIETHGolm3995xDrotzqfMyC2gEQAMGDOzMXiDqq+R+bXxvHwCoObOxrk1/KbVNFiOxI88h8bfXfXr+qY86Vl/YOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BatF9FdX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jTG6NEYG; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BatF9FdX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jTG6NEYG; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3A3901FB70;
	Wed,  2 Oct 2024 14:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727880470; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l8c+S5YYIX2Uu7ihx3Z17uep4iw5zk5DGA/zhqqWU7A=;
	b=BatF9FdXi7PHW6bYcyiyofUi+VnsXXPMiAz7euIcT7OqG5g6wg0pJO9chexzi1+nssaaTr
	eNBDxcQCm1Obye99r3GGcAjG0hTx95hWqDkxNxnfxsWT1Kcxjos9AZGuTTHtWwndHx5yYc
	MHSuUvDuWp7ir/XmQtxO+l1HQ6qv6X4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727880470;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l8c+S5YYIX2Uu7ihx3Z17uep4iw5zk5DGA/zhqqWU7A=;
	b=jTG6NEYGdyM2eGdegmCQqQgigJa8qGCYd1mTnNU/l0loGaU8zTJcoUyegChvMXx+E7JBRr
	NENXnqmEFp8LBaDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=BatF9FdX;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=jTG6NEYG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727880470; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l8c+S5YYIX2Uu7ihx3Z17uep4iw5zk5DGA/zhqqWU7A=;
	b=BatF9FdXi7PHW6bYcyiyofUi+VnsXXPMiAz7euIcT7OqG5g6wg0pJO9chexzi1+nssaaTr
	eNBDxcQCm1Obye99r3GGcAjG0hTx95hWqDkxNxnfxsWT1Kcxjos9AZGuTTHtWwndHx5yYc
	MHSuUvDuWp7ir/XmQtxO+l1HQ6qv6X4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727880470;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l8c+S5YYIX2Uu7ihx3Z17uep4iw5zk5DGA/zhqqWU7A=;
	b=jTG6NEYGdyM2eGdegmCQqQgigJa8qGCYd1mTnNU/l0loGaU8zTJcoUyegChvMXx+E7JBRr
	NENXnqmEFp8LBaDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 29F7613A6E;
	Wed,  2 Oct 2024 14:47:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rjo6ChZd/WZCOAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 02 Oct 2024 14:47:50 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D42FBA0877; Wed,  2 Oct 2024 16:47:49 +0200 (CEST)
Date: Wed, 2 Oct 2024 16:47:49 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Krishna Vivek Vitta <kvitta@microsoft.com>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fanotify: allow reporting errors on failure to open fd
Message-ID: <20241002144749.zi7d56ndvvj3ieol@quack3>
References: <20240927125624.2198202-1-amir73il@gmail.com>
 <20240930154249.4oqs5cg4n6wzftzs@quack3>
 <CAOQ4uxg-peR_1iy8SL64LD919BGP3TK5nde_4ZiAjJg5F_qOjQ@mail.gmail.com>
 <20241002130103.ofnborpit3tcm7iw@quack3>
 <CAOQ4uxgo=0ignH-2gSyWYmcCoAvQJA=o8ABS+u2_=iiBDvsLgQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxgo=0ignH-2gSyWYmcCoAvQJA=o8ABS+u2_=iiBDvsLgQ@mail.gmail.com>
X-Rspamd-Queue-Id: 3A3901FB70
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
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
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.com:email];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Wed 02-10-24 15:54:02, Amir Goldstein wrote:
> On Wed, Oct 2, 2024 at 3:01 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Mon 30-09-24 18:14:33, Amir Goldstein wrote:
> > > On Mon, Sep 30, 2024 at 5:42 PM Jan Kara <jack@suse.cz> wrote:
> > > >
> > > > On Fri 27-09-24 14:56:24, Amir Goldstein wrote:
> > > > > When working in "fd mode", fanotify_read() needs to open an fd
> > > > > from a dentry to report event->fd to userspace.
> > > > >
> > > > > Opening an fd from dentry can fail for several reasons.
> > > > > For example, when tasks are gone and we try to open their
> > > > > /proc files or we try to open a WRONLY file like in sysfs
> > > > > or when trying to open a file that was deleted on the
> > > > > remote network server.
> > > > >
> > > > > Add a new flag FAN_REPORT_FD_ERROR for fanotify_init().
> > > > > For a group with FAN_REPORT_FD_ERROR, we will send the
> > > > > event with the error instead of the open fd, otherwise
> > > > > userspace may not get the error at all.
> > > > >
> > > > > In any case, userspace will not know which file failed to
> > > > > open, so leave a warning in ksmg for further investigation.
> > > > >
> > > > > Reported-by: Krishna Vivek Vitta <kvitta@microsoft.com>
> > > > > Closes: https://lore.kernel.org/linux-fsdevel/SI2P153MB07182F3424619EDDD1F393EED46D2@SI2P153MB0718.APCP153.PROD.OUTLOOK.COM/
> > > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > > > ---
> > > > >
> > > > > Jan,
> > > > >
> > > > > This is my proposal for a slightly better UAPI for error reporting.
> > > > > I have a vague memory that we discussed this before and that you preferred
> > > > > to report errno in an extra info field (?), but I have a strong repulsion
> > > > > from this altenative, which seems like way over design for the case.
> > > >
> > > > Hum, I don't remember a proposal for extra info field to hold errno. What I
> > > > rather think we talked about was that we would return only the successfully
> > > > formatted events, push back the problematic one and on next read from
> > > > fanotify group the first event will be the one with error so that will get
> > > > returned to userspace. Now this would work but I agree that from userspace
> > > > it is kind of difficult to know what went wrong when the read failed (were
> > > > the arguments somehow wrong, is this temporary or permanent problem, is it
> > > > the fd or something else in the event, etc.) so reporting the error in
> > > > place of fd looks like a more convenient option.
> > > >
> > > > But I wonder: Do we really need to report the error code? We already have
> > > > FAN_NOFD with -1 value (which corresponds to EPERM), with pidfd we are
> > > > reporting FAN_EPIDFD when its open fails so here we could have FAN_EFD ==
> > > > -2 in case opening of fd fails for whatever reason?
> > > >
> > >
> > > Well it is hard as it is to understand that went wrong, so the error
> > > codes provide some clues for the bug report.
> > > ENOENT, ENXIO, EROFS kind of point to the likely reason of
> > > failures, so it does not make sense for me to hide this information,
> > > which is available.
> >
> > OK, fair enough. I was kind of hoping we could avoid the feature flag but
> > probably we cannot even if we added just FAN_EFD. But I still have a bit of
> > problem with FAN_NOFD overlapping with -EPERM. I guess it kind of makes
> > sense to return -EPERM in that field for unpriviledged groups but we return
> > FAN_NOFD also for events without path attached and there it gets
> > somewhat confusing... Perhaps we should refuse FAN_REPORT_FD_ERROR for
> > groups in fid mode?
> 
> Makes sense.
> 
> > That would still leave overflow events so instead of
> > setting fd to FAN_NOFD, we could set it to -EINVAL to preserve the property
> > that fd is either -errno or fd number?
> >
> 
> EOVERFLOW? nah, witty but irrelevant.
> I think EBADF would be a good substitute for FAN_NOFD,
> but I can live with EINVAL as well.

EBADF is fine with me, probably even better.

> > And then I have a second question about pidfd. Should FAN_REPORT_FD_ERROR
> > influence it in the same way? Something like -ESRCH if the process already
> > exited and otherwise pass back the errno?
> 
> Yeh that sounds useful.

OK, I guess we have an agreement :) Will you send an updated patch please?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

