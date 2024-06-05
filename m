Return-Path: <linux-fsdevel+bounces-21030-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D738FC91A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 12:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE2561C2316F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 10:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE003190490;
	Wed,  5 Jun 2024 10:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wdfmlyTi";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/Z1lMx7T";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wdfmlyTi";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/Z1lMx7T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CB1191462
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Jun 2024 10:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717583403; cv=none; b=kCyZo0PBKIREs8aAEOuYYF8DHFdRyHeY2QtBwT/UHYKi+2JMPg9m14Pc9ZUwK5UxtsZakDayHMnIYItjZwvmMylZaOU8gQXlV+hWpNz/tpwVGB9Qcfxwb1zaSwHS4wN/CINIdnCy5mclIJ1k68cbiIuZfJM7xzJYtqnTmuehY/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717583403; c=relaxed/simple;
	bh=zzb6OmOWlt1taQlfyF/Dq5fuH8AnsvAUxx7pwD9sGHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T/CJbjsiBakzIBHx5FuRLZZTjl8Y6LGGeUBTQqBVI8BZTB7VnuYXjUQOTA+zw4OcnvTmp+HMFLpk8EjEnbt9HLPUk0Q4jmw9H7QI/eCgp93819Bnf+UPR2LE5h+58kLtojHUHlu4usdzPIshPrd5VDopaNlk+xHbpD944/kT93w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wdfmlyTi; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/Z1lMx7T; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wdfmlyTi; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/Z1lMx7T; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BD2B31F7F1;
	Wed,  5 Jun 2024 10:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717583393; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qgZNcMTbDfwwm15YVZM6w00F1NgKKvTYctj/eWphzq8=;
	b=wdfmlyTiUFE/R0MUIiNBeR4memkfOuGKcA1AhjDnfNoYU9cDMmsxLcm0bgJyamXcezmQsu
	bjR+PJlMAICiG0LPvg9Lw55sjgx08twPO6GmVIHKh867M+PblSgTJcuX7zx1HAW/ueDjLI
	KwqwgRtgzvF13ZakRNDrbGsQwcpGIjY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717583393;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qgZNcMTbDfwwm15YVZM6w00F1NgKKvTYctj/eWphzq8=;
	b=/Z1lMx7Td5uEjoGONK85MNdoQo69Ct3VWiDXfkheB1L11f5DnhcKGvHSq8nz6Ru/NIMAcO
	FxuJQ22K7fm4r2Cw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=wdfmlyTi;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="/Z1lMx7T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717583393; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qgZNcMTbDfwwm15YVZM6w00F1NgKKvTYctj/eWphzq8=;
	b=wdfmlyTiUFE/R0MUIiNBeR4memkfOuGKcA1AhjDnfNoYU9cDMmsxLcm0bgJyamXcezmQsu
	bjR+PJlMAICiG0LPvg9Lw55sjgx08twPO6GmVIHKh867M+PblSgTJcuX7zx1HAW/ueDjLI
	KwqwgRtgzvF13ZakRNDrbGsQwcpGIjY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717583393;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qgZNcMTbDfwwm15YVZM6w00F1NgKKvTYctj/eWphzq8=;
	b=/Z1lMx7Td5uEjoGONK85MNdoQo69Ct3VWiDXfkheB1L11f5DnhcKGvHSq8nz6Ru/NIMAcO
	FxuJQ22K7fm4r2Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B176813AA1;
	Wed,  5 Jun 2024 10:29:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6RVOKyE+YGaDYAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 05 Jun 2024 10:29:53 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 671F6A0870; Wed,  5 Jun 2024 12:29:45 +0200 (CEST)
Date: Wed, 5 Jun 2024 12:29:45 +0200
From: Jan Kara <jack@suse.cz>
To: JunChao Sun <sunjunchao2870@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Miklos Szeredi <miklos@szeredi.hu>,
	linux-fsdevel@vger.kernel.org
Subject: Re: Is is reasonable to support quota in fuse?
Message-ID: <20240605102945.q4nu67xpdwfziiqd@quack3>
References: <CAHB1NaicRULmaq8ks4JCtc3ay3AQ9mG77jc5t_bNdn3wMwMrMg@mail.gmail.com>
 <CAJfpegsELV80nfYUP0CvbE=c45re184T4_WtUEhhfRGVmpmpcQ@mail.gmail.com>
 <CAHB1NaiddGRxh7UjaXejWsYnJY52dYDvaB2oZpqQXqVocxTm+w@mail.gmail.com>
 <20240604092757.k5kkc67j3ssnc6um@quack3>
 <CAHB1NahP14FAMj04D-T-bWs7JAn_mXfmXSeKUEkRbALZrLeqAA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHB1NahP14FAMj04D-T-bWs7JAn_mXfmXSeKUEkRbALZrLeqAA@mail.gmail.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUBJECT_ENDS_QUESTION(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: BD2B31F7F1
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -3.01

On Tue 04-06-24 21:49:20, JunChao Sun wrote:
> Jan Kara <jack@suse.cz> 于2024年6月4日周二 17:27写道：
> > On Tue 04-06-24 14:54:01, JunChao Sun wrote:
> > > Miklos Szeredi <miklos@szeredi.hu> 于2024年6月4日周二 14:40写道：
> > > >
> > > > On Mon, 3 Jun 2024 at 13:37, JunChao Sun <sunjunchao2870@gmail.com> wrote:
> > > >
> > > > > Given these challenges, I would like to inquire about the community's
> > > > > perspective on implementing quota functionality at the FUSE kernel
> > > > > part. Is it feasible to implement quota functionality in the FUSE
> > > > > kernel module, allowing users to set quotas for FUSE just as they
> > > > > would for ext4 (e.g., using commands like quotaon /mnt/fusefs or
> > > > > quotaset /mnt/fusefs)?  Would the community consider accepting patches
> > > > > for this feature?
> > > >
> > > >
> > > > > I would say yes, but I have no experience with quota in any way, so
> > > > > cannot help with the details.
> > >
> > > Thanks for your reply. I'd like try to implement this feature.
> >
> > Nice idea! But before you go and spend a lot of time trying to implement
> > something, I suggest that you write down a design how you imagine all this
> > to work and we can talk about it. Questions like: Do you have particular
> > usecases in mind? Where do you plan to perform the accounting /
> > enforcement? Where do you want to store quota information? How do you want
> > to recover from unclean shutdowns? Etc...
> 
> Thanks a lot for your suggestions.
> 
> I am reviewing the quota code of ext4 and the fuse code to determine
> if the implementation method used in ext4 can be ported to fuse. Based
> on my current understanding, the key issue is that ext4 reserves
> several inodes for quotas and can manage the disk itself, allowing it
> to directly flush quota data to the disk blocks corresponding to the
> quota inodes within the kernel.

Yes.

> However, fuse does not seem to manage
> the disk itself; it sends all read and write requests to user space
> for completion. Therefore, it may not be possible to directly flush
> the data in the quota inode to the disk in fuse.

Yes, ext4 uses journalling to keep filesystem state consistent with quota
information. Doing this within FUSE would be rather difficult (essentially
you would have to implement journal within FUSE with will have rather high
performace overhead).

But that's why I'm asking for usecases. For some usecases it may be fine
that in case of unclean shutdown you run quotacheck program to update quota
information based on current usage - non-journalling filesystems use this
method. So where do you want to use quotas on a FUSE filesystem?

> I am considering whether it would be feasible to implement the quota
> inode in user space in a similar manner. For example, users could
> reserve a few regular files that are invisible to actual file system
> users to store the contents of quota. When updating the quota, the
> user would be notified to flush the quota data to the disk. The
> benefit of this approach is that it can directly reuse the quota
> metadata format from the kernel, users do not need to redesign
> metadata. However, performance might be an issue with this approach.

Yes, storing quota data in some files inside the filesystem is probably the
easiest way to go. I'd just not bother with flushing because as you say
the performance would suck in that case.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

