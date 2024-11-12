Return-Path: <linux-fsdevel+bounces-34456-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F159C59A8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 14:56:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4764F1F234FD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 13:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42FC71FC7E6;
	Tue, 12 Nov 2024 13:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ap/VuOj/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="X7ZlUU4O";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cpMNzLWX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BhEUIMbj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34141FBF7D;
	Tue, 12 Nov 2024 13:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731419705; cv=none; b=SyXw7fp1FyUrqHJm42FsvUUUucVipRXV05+MzPmx1WMtC0k9UE1BEIcYlew0+uXpYJfFQ9vQR5QOEbeJYOopjPIozkmlawGsaYu32tylqpQ5W+tTF5W2194V6d2XfuO1eXHOl7PsDDibRChHLwnP+ZX7RKO5HdzJITbiQeDYru8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731419705; c=relaxed/simple;
	bh=Xj8Q5LkHc5oaTyfRByOo/XwoC4md8gp+NrGybKyzbMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KuvJZaJXvRknRabDk3ytgJ+xckTC/p1wL/cDotsnDYBA7fB1flt0lPg8knDDw8KdvTGkfBngqergjAymJEdeygtQUxM46LuOCgoLvr31QhahkwPEGWGpINF0qr5JXE7BNgDtGSJ5FLfFEAbNb6WSp1zd8MtpnVZa8LOh/vAWN6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ap/VuOj/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=X7ZlUU4O; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cpMNzLWX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BhEUIMbj; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D38172128F;
	Tue, 12 Nov 2024 13:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731419702; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GggHjq6mlfXdpXhy6vku+7SxFDasBwrmkZtO3QYAPpA=;
	b=Ap/VuOj/uPqqu0YJCo/upxhvpT1gL65rnquNlS9fK9Oxw+ekiHvA5S7YFlk17/ISyH8r28
	BmzB+RIY2r87L4UT6C8MCAdT1/IXUrqwdVf8UBdzMwHojzxmwNwaK7qpxGJ90/9ZIIU5qI
	MDukUePOxM78VoAt7M7u43Fx82eobo0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731419702;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GggHjq6mlfXdpXhy6vku+7SxFDasBwrmkZtO3QYAPpA=;
	b=X7ZlUU4O8aIis5H8gO1MMPYtKX4e99qPEvZZhgO0TbP+b3NnUo5tMjqNHySYa3O5SJFtFF
	jB50zv3wLh8V6cAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731419701; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GggHjq6mlfXdpXhy6vku+7SxFDasBwrmkZtO3QYAPpA=;
	b=cpMNzLWX7mSb5R3J+LFyZ7KuTODAbuhad69ifHlpyyzMrEe/aM+ayo7u/842jYPPtSSWi8
	DGavQWBKqhvPHWc5V7rnDC1BvFQpfEeKbim10wrf4uzTLAX+m6g9lAuBvBugRG/JbW8Eef
	+Lep4cyhpZlV3LsFRPkgRb4BADH7EXk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731419701;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GggHjq6mlfXdpXhy6vku+7SxFDasBwrmkZtO3QYAPpA=;
	b=BhEUIMbjOckf909sxr4ypQWrcGmWwOTExK8ce3kk5E9zGpOa3SC4kc1T0ZBylBYcheq2um
	Jl7OpQjrBZza5vDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C77BC13721;
	Tue, 12 Nov 2024 13:55:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Jgi6MDVeM2dpcgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 12 Nov 2024 13:55:01 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 72D0DA08D0; Tue, 12 Nov 2024 14:54:57 +0100 (CET)
Date: Tue, 12 Nov 2024 14:54:57 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org, jack@suse.cz, brauner@kernel.org,
	linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v6 06/17] fsnotify: generate pre-content permission event
 on open
Message-ID: <20241112135457.zxzhtoe537gapkmu@quack3>
References: <cover.1731355931.git.josef@toxicpanda.com>
 <b509ec78c045d67d4d7e31976eba4b708b238b66.1731355931.git.josef@toxicpanda.com>
 <CAHk-=wh4BEjbfaO93hiZs3YXoNmV=YkWT4=OOhuxM3vD2S-1iA@mail.gmail.com>
 <CAEzrpqdtSAoS+p4i0EzWFr0Nrpw1Q2hphatV7Sk4VM49=L3kGw@mail.gmail.com>
 <CAHk-=wj8L=mtcRTi=NECHMGfZQgXOp_uix1YVh04fEmrKaMnXA@mail.gmail.com>
 <CAOQ4uxgxtQhe_3mj5SwH9568xEFsxtNqexLfw9Wx_53LPmyD=Q@mail.gmail.com>
 <CAHk-=wgUV27XF8g23=aWNJecRbn8fCDDW2=10y9yJ122+d8JrA@mail.gmail.com>
 <CAOQ4uxh7aT+EvWYMa9v=SyRjfdh4Je_FmS0+TNqonHE5Z+_TPw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxh7aT+EvWYMa9v=SyRjfdh4Je_FmS0+TNqonHE5Z+_TPw@mail.gmail.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-0.998];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Tue 12-11-24 09:11:32, Amir Goldstein wrote:
> On Tue, Nov 12, 2024 at 1:37 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> > On Mon, 11 Nov 2024 at 16:00, Amir Goldstein <amir73il@gmail.com> wrote:
> > >
> > > I think that's a good idea for pre-content events, because it's fine
> > > to say that if the sb/mount was not watched by a pre-content event listener
> > > at the time of file open, then we do not care.
> >
> > Right.
> >
> > > The problem is that legacy inotify/fanotify watches can be added after
> > > file is open, so that is allegedly why this optimization was not done for
> > > fsnotify hooks in the past.
> >
> > So honestly, even if the legacy fsnotify hooks can't look at the file
> > flag, they could damn well look at an inode flag.
> 
> Legacy fanotify has a mount watch (FAN_MARK_MOUNT),
> which is the common way for Anti-malware to set watches on
> filesystems, so I am not sure what you are saying.
> 
> > And I'm not even convinced that we couldn't fix them to just look at a
> > file flag, and say "tough luck, somebody opened that file before you
> > started watching, you don't get to see what they did".
> 
> That would specifically break tail -f (for inotify) and probably many other
> tools, but as long as we also look at the inode flags (i_fsnotify_mask)
> and the dentry flags (DCACHE_FSNOTIFY_PARENT_WATCHED),
> then I think we may be able to get away with changing the semantics
> for open files on a fanotify mount watch.

Yes, I agree we cannot afford to generate FS_MODIFY event only if the mark
was placed after file open. There's too much stuff in userspace depending
on this since this behavior dates back to inotify interface sometime in
2010 or so.

> Specifically, I would really like to eliminate completely the cost of
> FAN_ACCESS_PERM event, which could be gated on file flag, because
> this is only for security/Anti-malware and I don't think this event is
> practically
> useful and it sure does not need to guarantee permission events to mount
> watchers on already open files.

For traditional fanotify permission events I agree generating them only if
the mark was placed before open is likely fine but we'll have to try and
see whether something breaks. For the new pre-content events I like the
per-file flag as Linus suggested. That should indeed save us some cache
misses in some fast paths.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

