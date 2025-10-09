Return-Path: <linux-fsdevel+bounces-63645-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 393F9BC8130
	for <lists+linux-fsdevel@lfdr.de>; Thu, 09 Oct 2025 10:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71B033BE301
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Oct 2025 08:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707AF2D063C;
	Thu,  9 Oct 2025 08:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LPpzFfMn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lrMgh0IH";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vZGttwaT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="enFzO5An"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3002857F2
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Oct 2025 08:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759999138; cv=none; b=gJRsDQRMxH3PfRVnrF0f+Nty+b9aonZUYYuPxh7pQjxvqSROYz5cWeQweR8mh8pXEMERGC2BGlOHLGvKJ0RuWyb0DQG72BY81DdU5kc0YQGhOCb31PfhJmJeCA6UyZvQAwb3k+089CiNNtH66nJXKPlCLpUfb0TmxziJT1Mmp80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759999138; c=relaxed/simple;
	bh=P/49DWQvaRKreHMlwC13bf/kIQMSa9M93SImmymHGSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n3ddPB/oGWScwMwABlmZwDzrbCEWg86HjvZIpGFMgVV8V+2IdU7Fi+Le1aczE3AwN0IicQdf/NAZuc/BKYdj600N2O6JSTV3lFyO3bIeyn/+U3jG4vCoMtNJEo2dvz97bKjuweyWbtUbj9qM4FYo1mzfKHrlnc/9WivpzIhWAO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LPpzFfMn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lrMgh0IH; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vZGttwaT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=enFzO5An; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DCD661F83F;
	Thu,  9 Oct 2025 08:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759999135; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3vO/c3Nr9/ShdfTU0FdyXLRof5Q362KAvhqM2kcVybQ=;
	b=LPpzFfMn2Xc71sBNf7SHexb1rKX0SVND+Q7PZQeo2IX+0BPQMjLDBri25PD1hGXJvpQVRF
	kgWBMnlJF6rOoGtt2vcjPVx+DgJUAC1N2pvkrYM3367uBoh3RCPs2X2EBg1M27qqoSDke0
	4m50eZ8aoL/h6/QgBMjEW63ON1d8Q0Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759999135;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3vO/c3Nr9/ShdfTU0FdyXLRof5Q362KAvhqM2kcVybQ=;
	b=lrMgh0IHrMQO2D7tnVV5rWkYXCzXd4D5juj1ccLQrfCjRtHjP74J8zRcedThxGGlHyGvex
	ImalzjldK6elkhAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=vZGttwaT;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=enFzO5An
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759999133; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3vO/c3Nr9/ShdfTU0FdyXLRof5Q362KAvhqM2kcVybQ=;
	b=vZGttwaTa//klyZ7MbT0oDXWp1XVPaQbWw3RWYxBhQtq/mT0p3183aWIZxPQB9OmeYWdGM
	GmO54daV2M7UHn2g/5oD7Jz5mrm2QE+/rzbqZOiXRH7MV+i45yEQ4AtHgl5mS+KV99udbu
	ryptJE0bLS8aEaPjtSpbD9turPVobBQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759999133;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3vO/c3Nr9/ShdfTU0FdyXLRof5Q362KAvhqM2kcVybQ=;
	b=enFzO5AnfFeyCw2dgPggX6k6B7lky/cHhoVPVq1whs5XDCVALJbRn0cAEijZxY9GGivRWM
	1TUzIetlNiJ/wNAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C676B13AAC;
	Thu,  9 Oct 2025 08:38:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id d8dvMJ1052gEGwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 09 Oct 2025 08:38:53 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 50ADAA0A71; Thu,  9 Oct 2025 10:38:53 +0200 (CEST)
Date: Thu, 9 Oct 2025 10:38:53 +0200
From: Jan Kara <jack@suse.cz>
To: Joshua Watt <jpewhacker@gmail.com>
Cc: Jan Kara <jack@suse.cz>, jimzhao.ai@gmail.com, 
	akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, willy@infradead.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] mm/page-writeback: Consolidate wb_thresh bumping logic
 into __wb_calc_thresh
Message-ID: <47nzppimqdsltrtjb2qz4ztgtxq73rpugagronbeiod5v6ygzp@nl4lwvjk44lp>
References: <20241121100539.605818-1-jimzhao.ai@gmail.com>
 <20251007161711.468149-1-JPEWhacker@gmail.com>
 <ywwhwyc4el6vikghnd5yoejteld6dudemta7lsrtacvecshst5@avvpac27felp>
 <CAJdd5GY1mmi83V8DyiUJSZoLRVhUz_hY=qR-SjZ8Ss9bxQ002w@mail.gmail.com>
 <CAJdd5GaQ1LdS=n52AWQwZ=Q9woSjFYiVD9E_1SkEeDPoT=bmjw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJdd5GaQ1LdS=n52AWQwZ=Q9woSjFYiVD9E_1SkEeDPoT=bmjw@mail.gmail.com>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: DCD661F83F
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[9];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,linux-foundation.org,vger.kernel.org,kvack.org,infradead.org];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Score: -2.51

On Wed 08-10-25 17:14:31, Joshua Watt wrote:
> On Wed, Oct 8, 2025 at 8:49 AM Joshua Watt <jpewhacker@gmail.com> wrote:
> > On Wed, Oct 8, 2025 at 5:14 AM Jan Kara <jack@suse.cz> wrote:
> > > Hello!
> > >
> > > On Tue 07-10-25 10:17:11, Joshua Watt wrote:
> > > > From: Joshua Watt <jpewhacker@gmail.com>
> > > >
> > > > This patch strangely breaks NFS 4 clients for me. The behavior is that a
> > > > client will start getting an I/O error which in turn is caused by the client
> > > > getting a NFS3ERR_BADSESSION when attempting to write data to the server. I
> > > > bisected the kernel from the latest master
> > > > (9029dc666353504ea7c1ebfdf09bc1aab40f6147) to this commit (log below). Also,
> > > > when I revert this commit on master the bug disappears.
> > > >
> > > > The server is running kernel 5.4.161, and the client that exhibits the
> > > > behavior is running in qemux86, and has mounted the server with the options
> > > > rw,relatime,vers=4.1,rsize=1048576,wsize=1048576,namlen=255,soft,proto=tcp,port=52049,timeo=600,retrans=2,sec=null,clientaddr=172.16.6.90,local_lock=none,addr=172.16.6.0
> > > >
> > > > The program that I wrote to reproduce this is pretty simple; it does a file
> > > > lock over NFS, then writes data to the file once per second. After about 32
> > > > seconds, it receives the I/O error, and this reproduced every time. I can
> > > > provide the sample program if necessary.
> > >
> > > This is indeed rather curious.
> > >
> > > > I also captured the NFS traffic both in the passing case and the failure case,
> > > > and can provide them if useful.
> > > >
> > > > I did look at the two dumps and I'm not exactly sure what the difference is,
> > > > other than with this patch the client tries to write every 30 seconds (and
> > > > fails), where as without it attempts to write back every 5 seconds. I have no
> > > > idea why this patch would cause this problem.
> > >
> > > So the change in writeback behavior is not surprising. The commit does
> > > modify the logic computing dirty limits in some corner cases and your
> > > description matches the fact that previously the computed limits were lower
> > > so we've started writeback after 5s (dirty_writeback_interval) while with
> > > the patch we didn't cross the threshold and thus started writeback only
> > > once the dirty data was old enough, which is 30s (dirty_expire_interval).
> > >
> > > But that's all, you should be able to observe exactly the same writeback
> > > behavior if you write less even without this patch. So I suspect that the
> > > different writeback behavior is just triggering some bug in the NFS (either
> > > on the client or the server side). The NFS3ERR_BADSESSION error you're
> > > getting back sounds like something times out somewhere, falls out of cache
> > > and reports this error (which doesn't happen if we writeback after 5s
> > > instead of 30s). NFS guys maybe have better idea what's going on here.
> > >
> > > You could possibly workaround this problem (and verify my theory) by tuning
> > > /proc/sys/vm/dirty_expire_centisecs to a lower value (say 500). This will
> > > make inode writeback start earlier and thus should effectively mask the
> > > problem again.
> >
> > Changing /proc/sys/vm/dirty_expire_centisecs did indeed prevent the
> > issue from occurring. As an experiment, I tried to see what the lowest
> > value I could use that worked, and it was also 500. Even setting it to
> > 600 would cause it to error out eventually. This would indicate to me
> > a server problem (which is unfortunate because that's much harder for
> > me to debug), but perhaps the NFS folks could weigh in.
> 
> I figured out the problem. There was a bug in the NFS client where it
> would not send state renewals within the first 5 minutes after
> booting; prior to this change, that was masked in my test case because
> the 5 second dirty writeback interval would keep the connection alive
> without needing the state renewals (and my test always did a reboot).
> I've submitted a patch to fix the NFS client to the mailing list [1].

Cool that you've nailed it down :).

> Sorry for the noise, and thanks for your help.

You're welcome.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

