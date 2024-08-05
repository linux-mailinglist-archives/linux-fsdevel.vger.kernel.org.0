Return-Path: <linux-fsdevel+bounces-25006-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E3E4947A53
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 13:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 815731C21111
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 11:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB75F1547E0;
	Mon,  5 Aug 2024 11:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1Q56sYZG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Uowe7+Jx";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1Q56sYZG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Uowe7+Jx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4CF1311AC
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 Aug 2024 11:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722856836; cv=none; b=A6tGM6OOWUl7nRr2I2fJ9NfjO1gaaMX28z0gVke5q40WVNjO8h/Qgtg0ZbE6+fRXKOf67ghbZgm0Ja9kKED5cZk56oazjt10t9eFxB+KRybd8LKpw+PmL4l1geLyVSNdBWmvvElahssP0BbOepfPxC+eQ5UqFAWE8toQiQvDO/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722856836; c=relaxed/simple;
	bh=QW9SIeqqZnhtDQp2d93tpDhOS6GUqHLb3f4RWJolzeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tbMRB14DjKHCEW8EMRS4B8eUi39qDlRFPB5hOMxAfA5Gesq5wGlb+NkEIvN9v2n4jUSWuur0XwKTr1w5cqpe+837Srt1I//Ezbp811RjAwvdEt0fbpHNZwAYc4RQplVKlMW+eEODRqdolvAMWKE/p8lboPOvjln+N3LWALdD6IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1Q56sYZG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Uowe7+Jx; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1Q56sYZG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Uowe7+Jx; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 862861FD13;
	Mon,  5 Aug 2024 11:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722856832; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1XJnStiY1dQSP4/EMU1ZItnfIH2Aiwj4mbTHvWQnkn0=;
	b=1Q56sYZGe9aodXqp/j5EKpUE+nrxFLUVSd821huE2C4sPQvSeHyCjwql1WXyGeaq8JNt5r
	70nQ1jeOA5IRrWOXVxKuCy5yIzYj0Ac0yJZpgU6xdDWrl9Nf6AK+SG1La9Jl48khkMFYCK
	mDrrGVEVKShpNqOIMxPhAglq6r0IuPw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722856832;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1XJnStiY1dQSP4/EMU1ZItnfIH2Aiwj4mbTHvWQnkn0=;
	b=Uowe7+JxgAubIETE3EbawAmu6NFoEfEkYJDa67m1kd7P6Nz8CY7MuOFqJxwnnd04IJwEri
	NRV8gOWU38ny//DA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=1Q56sYZG;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Uowe7+Jx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722856832; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1XJnStiY1dQSP4/EMU1ZItnfIH2Aiwj4mbTHvWQnkn0=;
	b=1Q56sYZGe9aodXqp/j5EKpUE+nrxFLUVSd821huE2C4sPQvSeHyCjwql1WXyGeaq8JNt5r
	70nQ1jeOA5IRrWOXVxKuCy5yIzYj0Ac0yJZpgU6xdDWrl9Nf6AK+SG1La9Jl48khkMFYCK
	mDrrGVEVKShpNqOIMxPhAglq6r0IuPw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722856832;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1XJnStiY1dQSP4/EMU1ZItnfIH2Aiwj4mbTHvWQnkn0=;
	b=Uowe7+JxgAubIETE3EbawAmu6NFoEfEkYJDa67m1kd7P6Nz8CY7MuOFqJxwnnd04IJwEri
	NRV8gOWU38ny//DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7D6E513ACF;
	Mon,  5 Aug 2024 11:20:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id S7idHoC1sGbUEQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 05 Aug 2024 11:20:32 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 2D837A0897; Mon,  5 Aug 2024 13:20:28 +0200 (CEST)
Date: Mon, 5 Aug 2024 13:20:28 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Josef Bacik <josef@toxicpanda.com>,
	kernel-team@fb.com, linux-fsdevel@vger.kernel.org,
	brauner@kernel.org
Subject: Re: [PATCH 06/10] fanotify: pass optional file access range in
 pre-content event
Message-ID: <20240805112028.bmruweu6dx7bfe7r@quack3>
References: <cover.1721931241.git.josef@toxicpanda.com>
 <bd00d41050b3982ba96c2c3ed8677c136f8019e0.1721931241.git.josef@toxicpanda.com>
 <20240801171631.pxxeyiosbdhjzfvx@quack3>
 <CAOQ4uxj+N5wQMOVXEUwWOgQPYipAtZNjxEL_Mu1G3V8us0TKRQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxj+N5wQMOVXEUwWOgQPYipAtZNjxEL_Mu1G3V8us0TKRQ@mail.gmail.com>
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 862861FD13
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
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Sat 03-08-24 19:00:22, Amir Goldstein wrote:
> On Thu, Aug 1, 2024 at 7:16 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Thu 25-07-24 14:19:43, Josef Bacik wrote:
> > > From: Amir Goldstein <amir73il@gmail.com>
> > >
> > > We would like to add file range information to pre-content events.
> > >
> > > Pass a struct file_range with optional offset and length to event handler
> > > along with pre-content permission event.
> > >
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> >
> > ...
> >
> > > @@ -565,6 +569,10 @@ static struct fanotify_event *fanotify_alloc_perm_event(const struct path *path,
> > >       pevent->hdr.len = 0;
> > >       pevent->state = FAN_EVENT_INIT;
> > >       pevent->path = *path;
> > > +     if (range) {
> > > +             pevent->ppos = range->ppos;
> > > +             pevent->count = range->count;
> > > +     }
> >
> > Shouldn't we initialze ppos & count in case range info isn't passed?
> 
> Currently, range info is always passed in case of
> fanotify_event_has_access_range(), but for robustness I guess we should.

Yeah, I agree there's no bug currently. This is mostly for future-proofing
and peace of mind :)

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

