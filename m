Return-Path: <linux-fsdevel+bounces-34665-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A79969C7638
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 16:21:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67E0B28445E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 15:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D011FE0F8;
	Wed, 13 Nov 2024 15:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="e2ZTpVen";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="q8O77oRt";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="e2ZTpVen";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="q8O77oRt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FAC1EF956;
	Wed, 13 Nov 2024 15:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731511141; cv=none; b=Q1ZpVd3c7HhvlRTaPOYAuKYXIbsnMfUXjiNm9dgyolFcim3zunj+NAIdFTCBIlMraMS1M354cjjKDxuxVWScuVZeakdCt88emOY6swx0nwzXHLG9O3F57pyqrpPWUCswREGh1NL7S/R6mrr7z3sNGdLFORcmaDzqTL5FaIhnqDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731511141; c=relaxed/simple;
	bh=VDGfeosPxmsUF8s+PaZ7y1gFygCo8rbKz8EfjbeDpLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cT/0wXaA7qxW2WQUSD4MMvDcGf+PHyDwgrVUD+8Wphns51a52KE+3o+pIuK7HhbQTZs3zlE7mXkoBrtDHfxZbUV1bsCGsg00trzHArq6tWTdiKDqasLRkmsR5Jv0c0wqR/kpDuX2HQGZbF4r6MpuRD2CJE3fEqCTSCVBpN735oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=e2ZTpVen; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=q8O77oRt; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=e2ZTpVen; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=q8O77oRt; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 156E31F38C;
	Wed, 13 Nov 2024 15:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731511137; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NCmHLcLimgfzlkucZcMUBHztySLUDXwYRdBb6AD+bD0=;
	b=e2ZTpVenkv05u0B6NbrJEaoiEbMOwjIfQVB65Xw8ul4Hxc0QilnTclfrKXuO/T0M5gzwvt
	+G6D7rtCvcrTxXgR6ktptOPNO9YGPOtETHZ2WLixewQ3dSoLSEUTi8Rl0QPjriPG3CwboR
	DlFOJtVQs/fz/SKppltWVMLqp0C1AxY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731511137;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NCmHLcLimgfzlkucZcMUBHztySLUDXwYRdBb6AD+bD0=;
	b=q8O77oRt8cc9LmRqVPriJF6DnpXKivfGeBB84bPNpP7914d84i5vNe6aP75M9wWddswJsG
	G6dOrndkx44HANAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731511137; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NCmHLcLimgfzlkucZcMUBHztySLUDXwYRdBb6AD+bD0=;
	b=e2ZTpVenkv05u0B6NbrJEaoiEbMOwjIfQVB65Xw8ul4Hxc0QilnTclfrKXuO/T0M5gzwvt
	+G6D7rtCvcrTxXgR6ktptOPNO9YGPOtETHZ2WLixewQ3dSoLSEUTi8Rl0QPjriPG3CwboR
	DlFOJtVQs/fz/SKppltWVMLqp0C1AxY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731511137;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NCmHLcLimgfzlkucZcMUBHztySLUDXwYRdBb6AD+bD0=;
	b=q8O77oRt8cc9LmRqVPriJF6DnpXKivfGeBB84bPNpP7914d84i5vNe6aP75M9wWddswJsG
	G6dOrndkx44HANAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 07BA913301;
	Wed, 13 Nov 2024 15:18:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fzjhAWHDNGeTDgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 13 Nov 2024 15:18:57 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B4354A08D0; Wed, 13 Nov 2024 16:18:48 +0100 (CET)
Date: Wed, 13 Nov 2024 16:18:48 +0100
From: Jan Kara <jack@suse.cz>
To: Jeff Layton <jlayton@kernel.org>
Cc: Karel Zak <kzak@redhat.com>, Christian Brauner <brauner@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>, Ian Kent <raven@themaw.net>,
	Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v4 0/3] fs: allow statmount to fetch the fs_subtype and
 sb_source
Message-ID: <20241113151848.hta3zax57z7lprxg@quack3>
References: <20241111-statmount-v4-0-2eaf35d07a80@kernel.org>
 <20241112-antiseptisch-kinowelt-6634948a413e@brauner>
 <hss5w5in3wj3af3o2x3v3zfaj47gx6w7faeeuvnxwx2uieu3xu@zqqllubl6m4i>
 <63f3aa4b3d69b33f1193f4740f655ce6dae06870.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63f3aa4b3d69b33f1193f4740f655ce6dae06870.camel@kernel.org>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed 13-11-24 08:45:06, Jeff Layton wrote:
> On Wed, 2024-11-13 at 12:27 +0100, Karel Zak wrote:
> > On Tue, Nov 12, 2024 at 02:39:21PM GMT, Christian Brauner wrote:
> > Next on the wish list is a notification (a file descriptor that can be
> > used in epoll) that returns a 64-bit ID when there is a change in the
> > mount node. This will enable us to enhance systemd so that it does not
> > have to read the entire mount table after every change.
> > 
> 
> New fanotify events for mount table changes, perhaps?

Now that I'm looking at it I'm not sure fanotify is a great fit for this
usecase. A lot of fanotify functionality does not really work for virtual
filesystems such as proc and hence we generally try to discourage use of
fanotify for them. So just supporting one type of event (like FAN_MODIFY)
on one file inside proc looks as rather inconsistent interface. But I
vaguely remember we were discussing some kind of mount event, weren't we?
Or was that for something else?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

