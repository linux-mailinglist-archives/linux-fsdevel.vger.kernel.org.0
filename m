Return-Path: <linux-fsdevel+bounces-34667-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6B59C7906
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 17:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 965E8B2A6A3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 15:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77EF1FAC4F;
	Wed, 13 Nov 2024 15:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="02FWd1yI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="anBLJ6jv";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="02FWd1yI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="anBLJ6jv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B6B7E792
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Nov 2024 15:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731512174; cv=none; b=R322LV2qEbP3ky/5Mcdr7Ex3T57rhZa16jYCZ+iTciFGpfvsklH+lQ9t3lmeRSdTR8Wqq0QStFrL5J8SgWAeLBAz8UsS0orZLrmkQG97IvTnumEO38ALUadyKzuVxq/GdiJM5/msDDwOPSS7C2EyuSubawC92fHoYR5g0ZlHH2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731512174; c=relaxed/simple;
	bh=AsX3BC+IFoDf+Vl/pUAw5kJ9MkB3FEveBt158C1/X00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DopWYSQQ10GV6IucaG1c7uC+E6+KKAZQcebe0Mxhv8WhN3R2LWD5Sc8gxKfMVsD50xy3DRR+uYNctu+xYFtL13dW/4ffHXHYkA4jnNaoOUVmu3ttY/9dXkSDDbjJDF2ay21sjI1+zeb9uKdCYF56V/UQrcvTYg+aaooeIqCVTUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=02FWd1yI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=anBLJ6jv; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=02FWd1yI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=anBLJ6jv; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4BE0821137;
	Wed, 13 Nov 2024 15:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731512170; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wTPZODtGYYpPJuZVJhWfDlH00sCXEImJ7zTbJBT68Ps=;
	b=02FWd1yI6r8zxBvrabt7sl5GAhHVxJrPGVFrPhFC0Y9jNmLBZma+FTd1sWGek/Xb/bAoo7
	gVs4OAC+g9mpfiMYSfSKs1EaD8yCo2jA0MBjOfA3oaG/ks/R9ICncDvsIUw8bgZtpYQQGO
	40/+zybeJ20AaOZCaxlGIkhP4lWgSZI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731512170;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wTPZODtGYYpPJuZVJhWfDlH00sCXEImJ7zTbJBT68Ps=;
	b=anBLJ6jvOW3CHGNa5sWuoDa2frzjDsSOmQJfKuVWQiw64W3z8KI3OOVjOfPpYtxtj3UZY/
	s57C65pEy3VeCfDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731512170; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wTPZODtGYYpPJuZVJhWfDlH00sCXEImJ7zTbJBT68Ps=;
	b=02FWd1yI6r8zxBvrabt7sl5GAhHVxJrPGVFrPhFC0Y9jNmLBZma+FTd1sWGek/Xb/bAoo7
	gVs4OAC+g9mpfiMYSfSKs1EaD8yCo2jA0MBjOfA3oaG/ks/R9ICncDvsIUw8bgZtpYQQGO
	40/+zybeJ20AaOZCaxlGIkhP4lWgSZI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731512170;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wTPZODtGYYpPJuZVJhWfDlH00sCXEImJ7zTbJBT68Ps=;
	b=anBLJ6jvOW3CHGNa5sWuoDa2frzjDsSOmQJfKuVWQiw64W3z8KI3OOVjOfPpYtxtj3UZY/
	s57C65pEy3VeCfDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 41B3813301;
	Wed, 13 Nov 2024 15:36:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9s8EEGrHNGcsGQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 13 Nov 2024 15:36:10 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id EE54CA08D0; Wed, 13 Nov 2024 16:36:05 +0100 (CET)
Date: Wed, 13 Nov 2024 16:36:05 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Miklos Szeredi <miklos@szeredi.hu>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fsnotify: fix sending inotify event with unexpected
 filename
Message-ID: <20241113153605.bezoibnq236gliyo@quack3>
References: <20241111201101.177412-1-amir73il@gmail.com>
 <20241113134258.524nduvn3piqqkco@quack3>
 <CAOQ4uxhswHmgJ0fxVp2PKvkYuVO0uX9rzoGs8HZt2mVBDcfQTA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxhswHmgJ0fxVp2PKvkYuVO0uX9rzoGs8HZt2mVBDcfQTA@mail.gmail.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-0.998];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
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
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Wed 13-11-24 15:22:50, Amir Goldstein wrote:
> On Wed, Nov 13, 2024 at 2:43 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Mon 11-11-24 21:11:01, Amir Goldstein wrote:
> > > We got a report that adding a fanotify filsystem watch prevents tail -f
> > > from receiving events.
> > >
> > > Reproducer:
> > >
> > > 1. Create 3 windows / login sessions. Become root in each session.
> > > 2. Choose a mounted filesystem that is pretty quiet; I picked /boot.
> > > 3. In the first window, run: fsnotifywait -S -m /boot
> > > 4. In the second window, run: echo data >> /boot/foo
> > > 5. In the third window, run: tail -f /boot/foo
> > > 6. Go back to the second window and run: echo more data >> /boot/foo
> > > 7. Observe that the tail command doesn't show the new data.
> > > 8. In the first window, hit control-C to interrupt fsnotifywait.
> > > 9. In the second window, run: echo still more data >> /boot/foo
> > > 10. Observe that the tail command in the third window has now printed
> > > the missing data.
> > >
> > > When stracing tail, we observed that when fanotify filesystem mark is
> > > set, tail does get the inotify event, but the event is receieved with
> > > the filename:
> > >
> > > read(4, "\1\0\0\0\2\0\0\0\0\0\0\0\20\0\0\0foo\0\0\0\0\0\0\0\0\0\0\0\0\0",
> > > 50) = 32
> > >
> > > This is unexpected, because tail is watching the file itself and not its
> > > parent and is inconsistent with the inotify event received by tail when
> > > fanotify filesystem mark is not set:
> > >
> > > read(4, "\1\0\0\0\2\0\0\0\0\0\0\0\0\0\0\0", 50) = 16
> > >
> > > The inteference between different fsnotify groups was caused by the fact
> > > that the mark on the sb requires the filename, so the filename is passed
> > > to fsnotify().  Later on, fsnotify_handle_event() tries to take care of
> > > not passing the filename to groups (such as inotify) that are interested
> > > in the filename only when the parent is watching.
> > >
> > > But the logic was incorrect for the case that no group is watching the
> > > parent, some groups are watching the sb and some watching the inode.
> > >
> > > Reported-by: Miklos Szeredi <miklos@szeredi.hu>
> > > Fixes: 7372e79c9eb9 ("fanotify: fix logic of reporting name info with watched parent")
> > > Cc: stable@vger.kernel.org # 5.10+
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> >
> > Thanks for analysis, Amir!
> >
> > > @@ -333,12 +333,14 @@ static int fsnotify_handle_event(struct fsnotify_group *group, __u32 mask,
> > >       if (!inode_mark)
> > >               return 0;
> > >
> > > -     if (mask & FS_EVENT_ON_CHILD) {
> > > +     if (mask & FS_EVENTS_POSS_ON_CHILD) {
> >
> > So this is going to work but as far as I'm reading the code in
> > fsnotify_handle_event() I would be maybe calmer if we instead wrote the
> > condition as:
> >
> >         if (!(mask & ALL_FSNOTIFY_DIRENT_EVENTS))
> 
> The problem is that the comment below
> "Some events can be sent on both parent dir and child marks..."
> is relevant in the context of FS_EVENTS_POSS_ON_CHILD
> and FS_EVENT_ON_CHILD, meaning those are exactly the set of
> events that could be sent to parent with FS_EVENT_ON_CHILD
> and to child without it.
> 
> The comment makes no sense in the context of the
> ALL_FSNOTIFY_DIRENT_EVENTS check,
> Unless we add a comment saying the dirent events set has
> zero intersection with events possible on child.

Good point and what I *actually* wanted to do is:

        /*
         * Some events can be sent on both parent dir and child marks (e.g.
         * FS_ATTRIB).  If both parent dir and child are watching, report the
         * event once to parent dir with name (if interested) and once to child
         * without name (if interested).
         *
         * In any case regardless whether the parent is watching or not, the
         * child watcher is expecting an event without the FS_EVENT_ON_CHILD
         * flag. The file name is expected if and only if this is a directory
         * event.
         */
        mask &= ~FS_EVENT_ON_CHILD;
        if (!(mask & ALL_FSNOTIFY_DIRENT_EVENTS)) {
                dir = NULL;
                name = NULL;
        }

Hmm?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

