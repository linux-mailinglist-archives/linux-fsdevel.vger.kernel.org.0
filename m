Return-Path: <linux-fsdevel+bounces-35982-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB3E9DA7A3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 13:18:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 993CD162FA9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 12:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA2C1FBE9E;
	Wed, 27 Nov 2024 12:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mCi2BhMv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wCI1ikWb";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mCi2BhMv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wCI1ikWb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6AE1F7572;
	Wed, 27 Nov 2024 12:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732709925; cv=none; b=jhJKdAonWjsgUynWSBPeARAIIoG46CO5qbliWVc+zKUTzYkV7DYopU+ckQirFQ/tXf1AB0Kr4rPoNjGbc4DAWCH0wwGGw8Sy7vkn6USwraOEwn9lwDeMFcykW8wTSo0+DhBApVpPBESiFN9wb2U5lg2BgrCfEoJmOI2HP2Gc+uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732709925; c=relaxed/simple;
	bh=gozbWYdaj9nQ/UoSf374/nqTw4ql+KrHcMRvkHpj9AE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vr7WgnP4wDvY5vok9wWJbDP72lmQC+ID9zeyMa9AqdzRZKD3Hvi2g3bF6IU8pKwugrzrw7lx+xZtB5+oCPA7juNlQTlQNTOHQrhNevCPPL5tC6oaccwbPWHm9tDWCw02eicVRTln4CZ5jEVcORu5FcoHC0REHhndbro0K6akayo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mCi2BhMv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wCI1ikWb; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mCi2BhMv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wCI1ikWb; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7E61B2117E;
	Wed, 27 Nov 2024 12:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732709918; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=voCgKDDA1xuyfqTQdPx+hNfd7T9ftf5pcBbgUJ2Qs28=;
	b=mCi2BhMvAJAzz8O8+uS7sent3QV4AAsp+vgRWyJGES+nu6OsmV73Equpoz+1Zd+/Np/0wR
	FmjKoEvxVjx7N6p7jlhRgJ0otSzalRCXPllKzKmg3tmpM4puZoL4SsH+zCD7D3xQpYmqax
	4rhEqeyl0JteJEJOyUI5GKE98do9Noc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732709918;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=voCgKDDA1xuyfqTQdPx+hNfd7T9ftf5pcBbgUJ2Qs28=;
	b=wCI1ikWb2w5i4KSIF5Wl4Y08yAWtFR7KmIDSbsN7CWfUgUwGnVLmfOSnebqnr6c98r6dET
	l8xsXiRZri66RKBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=mCi2BhMv;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=wCI1ikWb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732709918; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=voCgKDDA1xuyfqTQdPx+hNfd7T9ftf5pcBbgUJ2Qs28=;
	b=mCi2BhMvAJAzz8O8+uS7sent3QV4AAsp+vgRWyJGES+nu6OsmV73Equpoz+1Zd+/Np/0wR
	FmjKoEvxVjx7N6p7jlhRgJ0otSzalRCXPllKzKmg3tmpM4puZoL4SsH+zCD7D3xQpYmqax
	4rhEqeyl0JteJEJOyUI5GKE98do9Noc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732709918;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=voCgKDDA1xuyfqTQdPx+hNfd7T9ftf5pcBbgUJ2Qs28=;
	b=wCI1ikWb2w5i4KSIF5Wl4Y08yAWtFR7KmIDSbsN7CWfUgUwGnVLmfOSnebqnr6c98r6dET
	l8xsXiRZri66RKBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6123C139AA;
	Wed, 27 Nov 2024 12:18:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZUiwFx4OR2fRbgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 27 Nov 2024 12:18:38 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1249FA08D6; Wed, 27 Nov 2024 13:18:38 +0100 (CET)
Date: Wed, 27 Nov 2024 13:18:38 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Josef Bacik <josef@toxicpanda.com>,
	kernel-team@fb.com, linux-fsdevel@vger.kernel.org,
	brauner@kernel.org, torvalds@linux-foundation.org,
	viro@zeniv.linux.org.uk, linux-xfs@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-mm@kvack.org,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH v8 10/19] fanotify: introduce FAN_PRE_ACCESS permission
 event
Message-ID: <20241127121838.3fmhjx26cfxcegro@quack3>
References: <cover.1731684329.git.josef@toxicpanda.com>
 <b80986f8d5b860acea2c9a73c0acd93587be5fe4.1731684329.git.josef@toxicpanda.com>
 <20241121104428.wtlrfhadcvipkjia@quack3>
 <CAOQ4uxhTiR8eHaf4q0_gLC62CWi9KdaQ05GSeqFkKFkXCH++PA@mail.gmail.com>
 <20241121163618.ubz7zplrnh66aajw@quack3>
 <CAOQ4uxhsEA2zj-a6H+==S+6G8nv+BQEJDoGjJeimX0yRhHso2w@mail.gmail.com>
 <CAOQ4uxgsjKwX7eoYcjU8SRWjRw39MNv=CMjjO1mQGr9Cd4iafQ@mail.gmail.com>
 <20241122124215.3k3udv5o6eys6ffy@quack3>
 <CAOQ4uxgCU6fETZTMdyzQmfyE4oBF_xgqpBdVjP20K1Yp1BSDxQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxgCU6fETZTMdyzQmfyE4oBF_xgqpBdVjP20K1Yp1BSDxQ@mail.gmail.com>
X-Rspamd-Queue-Id: 7E61B2117E
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
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:dkim,suse.com:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Fri 22-11-24 14:51:23, Amir Goldstein wrote:
> On Fri, Nov 22, 2024 at 1:42 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Thu 21-11-24 19:37:43, Amir Goldstein wrote:
> > > On Thu, Nov 21, 2024 at 7:31 PM Amir Goldstein <amir73il@gmail.com> wrote:
> > > > On Thu, Nov 21, 2024 at 5:36 PM Jan Kara <jack@suse.cz> wrote:
> > > > > On Thu 21-11-24 15:18:36, Amir Goldstein wrote:
> > > > > > On Thu, Nov 21, 2024 at 11:44 AM Jan Kara <jack@suse.cz> wrote:
> > > > > > and also always emitted ACCESS_PERM.
> > > > >
> > > > > I know that and it's one of those mostly useless events AFAICT.
> > > > >
> > > > > > my POC is using that PRE_ACCESS to populate
> > > > > > directories on-demand, although the functionality is incomplete without the
> > > > > > "populate on lookup" event.
> > > > >
> > > > > Exactly. Without "populate on lookup" doing "populate on readdir" is ok for
> > > > > a demo but not really usable in practice because you can get spurious
> > > > > ENOENT from a lookup.
> > > > >
> > > > > > > avoid the mistake of original fanotify which had some events available on
> > > > > > > directories but they did nothing and then you have to ponder hard whether
> > > > > > > you're going to break userspace if you actually start emitting them...
> > > > > >
> > > > > > But in any case, the FAN_ONDIR built-in filter is applicable to PRE_ACCESS.
> > > > >
> > > > > Well, I'm not so concerned about filtering out uninteresting events. I'm
> > > > > more concerned about emitting the event now and figuring out later that we
> > > > > need to emit it in different places or with some other info when actual
> > > > > production users appear.
> > > > >
> > > > > But I've realized we must allow pre-content marks to be placed on dirs so
> > > > > that such marks can be placed on parents watching children. What we'd need
> > > > > to forbid is a combination of FAN_ONDIR and FAN_PRE_ACCESS, wouldn't we?
> > > >
> > > > Yes, I think that can work well for now.
> > > >
> > >
> > > Only it does not require only check at API time that both flags are not
> > > set, because FAN_ONDIR can be set earlier and then FAN_PRE_ACCESS
> > > can be added later and vice versa, so need to do this in
> > > fanotify_may_update_existing_mark() AFAICT.
> >
> > I have now something like:
> >
> > @@ -1356,7 +1356,7 @@ static int fanotify_group_init_error_pool(struct fsnotify_group *group)
> >  }
> >
> >  static int fanotify_may_update_existing_mark(struct fsnotify_mark *fsn_mark,
> > -                                             unsigned int fan_flags)
> > +                                            __u32 mask, unsigned int fan_flags)
> >  {
> >         /*
> >          * Non evictable mark cannot be downgraded to evictable mark.
> > @@ -1383,6 +1383,11 @@ static int fanotify_may_update_existing_mark(struct fsnotify_mark *fsn_mark,
> >             fsn_mark->flags & FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY)
> >                 return -EEXIST;
> >
> > +       /* For now pre-content events are not generated for directories */
> > +       mask |= fsn_mark->mask;
> > +       if (mask & FANOTIFY_PRE_CONTENT_EVENTS && mask & FAN_ONDIR)
> > +               return -EEXIST;
> > +
> 
> EEXIST is going to be confusing if there was never any mark.
> Either return -EINVAL here or also check this condition on the added mask
> itself before calling fanotify_add_mark() and return -EINVAL there.
> 
> I prefer two distinct errors, but probably one is also good enough.

That's actually a good point. My previous change allowed setting
FAN_PRE_ACCESS | FAN_ONDIR on a new mark because that doesn't get to
fanotify_may_update_existing_mark(). So I now have:

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 0919ea735f4a..38a46865408e 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1356,7 +1356,7 @@ static int fanotify_group_init_error_pool(struct fsnotify_group *group)
 }
 
 static int fanotify_may_update_existing_mark(struct fsnotify_mark *fsn_mark,
-					      unsigned int fan_flags)
+					     __u32 mask, unsigned int fan_flags)
 {
 	/*
 	 * Non evictable mark cannot be downgraded to evictable mark.
@@ -1383,6 +1383,11 @@ static int fanotify_may_update_existing_mark(struct fsnotify_mark *fsn_mark,
 	    fsn_mark->flags & FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY)
 		return -EEXIST;
 
+	/* For now pre-content events are not generated for directories */
+	mask |= fsn_mark->mask;
+	if (mask & FANOTIFY_PRE_CONTENT_EVENTS && mask & FAN_ONDIR)
+		return -EEXIST;
+
 	return 0;
 }
 
@@ -1409,7 +1414,7 @@ static int fanotify_add_mark(struct fsnotify_group *group,
 	/*
 	 * Check if requested mark flags conflict with an existing mark flags.
 	 */
-	ret = fanotify_may_update_existing_mark(fsn_mark, fan_flags);
+	ret = fanotify_may_update_existing_mark(fsn_mark, mask, fan_flags);
 	if (ret)
 		goto out;
 
@@ -1905,6 +1910,10 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 	if (mask & FAN_RENAME && !(fid_mode & FAN_REPORT_NAME))
 		goto fput_and_out;
 
+	/* Pre-content events are not currently generated for directories. */
+	if (mask & FANOTIFY_PRE_CONTENT_EVENTS && mask & FAN_ONDIR)
+		goto fput_and_out;
+
 	if (mark_cmd == FAN_MARK_FLUSH) {
 		ret = 0;
 		if (mark_type == FAN_MARK_MOUNT)
-- 
2.35.3

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

