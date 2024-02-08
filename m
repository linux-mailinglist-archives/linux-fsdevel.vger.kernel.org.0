Return-Path: <linux-fsdevel+bounces-10805-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D03284E7AF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 19:31:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42893B26F25
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 18:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1101CF91;
	Thu,  8 Feb 2024 18:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eLfEYRnL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="34YfXfvU";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eLfEYRnL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="34YfXfvU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E7F8C1A
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Feb 2024 18:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707417095; cv=none; b=aH6WTi1itnuzuErl0aWUf7UQIFn93CvL39M4qj+wHv5OFhb8+NIlzqDlPiVVawvT8e2zmMWa7M2KIc/KTK5KckcMTdptnRq3DUjGJUCa//ImPATt+xG1RGUIWMqo5UCAXydPJrIycTIr980ImzK0jXUW5Yoto4ZRDJrxdez78SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707417095; c=relaxed/simple;
	bh=WCJyoraQPcRNFDLc0opd0fU6xZD87icm1GtAkpoSl/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MfXJEU23tuVmyzGsG2gwc5oYSMNz0kkDipQMPqJ8MARYt6oo0Zzf+1CSsnuHEpHfGo5D4qgSIqKYCixTSTwJkVesKsB7AoSrdQiitGyuA1BcX0euIn1vLlXjvMMXVrN9zV+hasZTr0MrgP/h6zWr0OeWWjwni+uvnzUfG1LcuWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eLfEYRnL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=34YfXfvU; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eLfEYRnL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=34YfXfvU; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0767422042;
	Thu,  8 Feb 2024 18:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707417092; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I5hoa84OFwJmti128kep2ul/ebHsGTDITxL+9R/Pudg=;
	b=eLfEYRnL8hg4KxPLtH8auw+wxTyuNdK+m845EyzqzI5htgEPBJOR+8ZYsIwlQq/4aGjHsb
	o055idJtLVdumUwobrQPlRvZm/rkjmTAzcJ5misRYwBv+HhvY8k/dbpsKgUFvsLVMaWy4C
	Wo0pGBubJGrSOCmjrmWOiU/2+6ssNus=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707417092;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I5hoa84OFwJmti128kep2ul/ebHsGTDITxL+9R/Pudg=;
	b=34YfXfvUkZ2iAHmKor8KcvcwF+DrlzWFytCfrLY/tdVgLay46ZOTmUUV2ahYpTDEKGfGVN
	D1VURhxBRPzf9nAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707417092; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I5hoa84OFwJmti128kep2ul/ebHsGTDITxL+9R/Pudg=;
	b=eLfEYRnL8hg4KxPLtH8auw+wxTyuNdK+m845EyzqzI5htgEPBJOR+8ZYsIwlQq/4aGjHsb
	o055idJtLVdumUwobrQPlRvZm/rkjmTAzcJ5misRYwBv+HhvY8k/dbpsKgUFvsLVMaWy4C
	Wo0pGBubJGrSOCmjrmWOiU/2+6ssNus=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707417092;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I5hoa84OFwJmti128kep2ul/ebHsGTDITxL+9R/Pudg=;
	b=34YfXfvUkZ2iAHmKor8KcvcwF+DrlzWFytCfrLY/tdVgLay46ZOTmUUV2ahYpTDEKGfGVN
	D1VURhxBRPzf9nAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EAD7A1326D;
	Thu,  8 Feb 2024 18:31:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3gjOOAMexWV0LwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 08 Feb 2024 18:31:31 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 72E15A0809; Thu,  8 Feb 2024 19:31:27 +0100 (CET)
Date: Thu, 8 Feb 2024 19:31:27 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Josef Bacik <josef@toxicpanda.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, Sargun Dhillon <sargun@sargun.me>,
	Sweet Tea Dorminy <thesweettea@meta.com>
Subject: Re: [RFC][PATCH] fanotify: allow to set errno in FAN_DENY permission
 response
Message-ID: <20240208183127.5onh65vyho4ds7o7@quack3>
References: <20231213172844.ygjbkyl6i4gj52lt@quack3>
 <CAOQ4uxjMv_3g1XSp41M7eV+Tr+6R2QK0kCY=+AuaMCaGj0nuJA@mail.gmail.com>
 <20231215153108.GC683314@perftesting>
 <CAOQ4uxjVuhznNZitsjzDCanqtNrHvFN7Rx4dhUEPeFxsM+S22A@mail.gmail.com>
 <20231218143504.abj3h6vxtwlwsozx@quack3>
 <CAOQ4uxjNzSf6p9G79vcg3cxFdKSEip=kXQs=MwWjNUkPzTZqPg@mail.gmail.com>
 <CAOQ4uxgxCRoqwCs7mr+7YP4mmW7JXxRB20r-fsrFe2y5d3wDqQ@mail.gmail.com>
 <20240205182718.lvtgfsxcd6htbqyy@quack3>
 <CAOQ4uxgMKjEMjPP5HBk0kiZTfkqGU-ezkVpeS22wxL=JmUqhuQ@mail.gmail.com>
 <CAOQ4uxhvCbhvdP4BiLmOw5UR2xjk19LdvXZox1kTk-xzrU_Sfw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxhvCbhvdP4BiLmOw5UR2xjk19LdvXZox1kTk-xzrU_Sfw@mail.gmail.com>
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=eLfEYRnL;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=34YfXfvU
X-Spamd-Result: default: False [-2.81 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 0767422042
X-Spam-Level: 
X-Spam-Score: -2.81
X-Spam-Flag: NO

On Thu 08-02-24 16:04:29, Amir Goldstein wrote:
> > > On Mon 29-01-24 20:30:34, Amir Goldstein wrote:
> > > > On Mon, Dec 18, 2023 at 5:53 PM Amir Goldstein <amir73il@gmail.com> wrote:
> > > > > In the HttpDirFS HSM demo, I used FAN_OPEN_PERM on a mount mark
> > > > > to deny open of file during the short time that it's content is being
> > > > > punched out.
> > > > > It is quite complicated to explain, but I only used it for denying access,
> > > > > not to fill content and not to write anything to filesystem.
> > > > > It's worth noting that returning EBUSY in that case would be more meaningful
> > > > > to users.
> > > > >
> > > > > That's one case in favor of allowing FAN_DENY_ERRNO for FAN_OPEN_PERM,
> > > > > but mainly I do not have a proof that people will not need it.
> > > > >
> > > > > OTOH, I am a bit concerned that this will encourage developer to use
> > > > > FAN_OPEN_PERM as a trigger to filling file content and then we are back to
> > > > > deadlock risk zone.
> > > > >
> > > > > Not sure which way to go.
> > > > >
> > > > > Anyway, I think we agree that there is no reason to merge FAN_DENY_ERRNO
> > > > > before FAN_PRE_* events, so we can continue this discussion later when
> > > > > I post FAN_PRE_* patches - not for this cycle.
> > > >
> > > > I started to prepare the pre-content events patches for posting and got back
> > > > to this one as well.
> > > >
> > > > Since we had this discussion I have learned of another use case that
> > > > requires filling file content in FAN_OPEN_PERM hook, FAN_OPEN_EXEC_PERM
> > > > to be exact.
> > > >
> > > > The reason is that unless an executable content is filled at execve() time,
> > > > there is no other opportunity to fill its content without getting -ETXTBSY.
> > >
> > > Yes, I've been scratching my head over this usecase for a few days. I was
> > > thinking whether we could somehow fill in executable (and executed) files on
> > > access but it all seemed too hacky so I agree that we probably have to fill
> > > them in on open.
> > >
> >
> > Normally, I think there will not be a really huge executable(?)
> > If there were huge executables, they would have likely been broken down
> > into smaller loadable libraries which should allow more granular
> > content filling,
> > but I guess there will always be worst case exceptions.
> >
> > > > So to keep things more flexible, I decided to add -ETXTBSY to the
> > > > allowed errors with FAN_DENY_ERRNO() and to decided to allow
> > > > FAN_DENY_ERRNO() with all permission events.
> > > >
> > > > To keep FAN_DENY_ERRNO() a bit more focused on HSM, I have
> > > > added a limitation that FAN_DENY_ERRNO() is allowed only for
> > > > FAN_CLASS_PRE_CONTENT groups.
> > >
> > > I have no problem with adding -ETXTBSY to the set of allowed errors. That
> > > makes sense. Adding FAN_DENY_ERRNO() to all permission events in
> > > FAN_CLASS_PRE_CONTENT groups - OK,
> >
> > done that.
> >
> > I am still not very happy about FAN_OPEN_PERM being part of HSM
> > event family when I know that O_TRUCT and O_CREAT call this hook
> > with sb writers held.
> >
> > The irony, is that there is no chance that O_TRUNC will require filling
> > content, same if the file is actually being created by O_CREAT, so the
> > cases where sb writers is actually needed and the case where content
> > filling is needed do not overlap, but I cannot figure out how to get those
> > cases out of the HSM risk zone. Ideas?
> >
> 
> Jan,
> 
> I wanted to run an idea by you.
> 
> I like your idea to start a clean slate with
> FAN_CLASS_PRE_CONTENT | FAN_REPORT_FID
> and it would be nice if we could restrict this HSM to use
> pre-content events, which is why I was not happy about allowing
> FAN_DENY_ERRNO() for the legacy FAN_OPEN*_PERM events,
> especially with the known deadlocks.
> 
> Since we already know that we need to generate
> FAN_PRE_ACCESS(offset,length) for read-only mmap() and
> FAN_PRE_MODIFY(offset,length) for writable mmap(),
> we could treat uselib() and execve() the same way and generate
> FAN_PRE_ACCESS(0,i_size) as if the file was mmaped.

BTW uselib() is deprecated and there is a patch queued to not generate
OPEN_EXEC events for it because it was causing problems (not the generation
of events itself but the FMODE_EXEC bit being set in uselib). So I don't
think we need to instrument uselib().

> My idea is to generate an event FAN_PRE_MODIFY(0,0)
> for an open for write *after* file was truncated and
> FAN_PRE_ACCESS(0,0) for open O_RDONLY.

What I find somewhat strange about this is that if we return error from the
fsnotify_file_perm() hook, open(2) will fail with error but the file is
already truncated. But I guess it should be rare and it's bearable.

> Possibly also FAN_PRE_*(offset,0) events for llseek().

That seem overdoing it a bit IMO :)

> I've already pushed a POC to fan_pre_content branch [1].
> Only sanity tested that nothing else is broken.
> I still need to add the mmap hooks and test the new events.
> 
> With this, HSM will have appropriate hooks to fill executable
> and library on first access and also fill arbitrary files on open
> including the knowledge if the file was opened for write.
> 
> Thoughts?

Yeah, I guess this looks sensible.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

