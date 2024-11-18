Return-Path: <linux-fsdevel+bounces-35071-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 298D19D0B65
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 10:07:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B82FB21FDC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 09:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4D518871A;
	Mon, 18 Nov 2024 09:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NDvXShjx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nttq89+1";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NDvXShjx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nttq89+1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4959A13D50C;
	Mon, 18 Nov 2024 09:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731920855; cv=none; b=Sl6P5sNdZwqdWZSB2Jy077v7fn3/Gh4sSlR9rwAx2BOlRyPzUqOEmMYuYYQ4xxYqsbLXAfeQpdduYASaHtsMu23d7qo51BN0bnXvh/UTlZB+4Yv1UCUlEUxvI1b7z6lL4ANM0ySxn70Ld4X2PapU/byeaRSlrzfjNBcHGYMp5X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731920855; c=relaxed/simple;
	bh=DzBYUC0UrFi9KtHRjEyCiD3Muvs1kqsnAluX+bMd81k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R0+sMBnxRlDfj8waSkPFEERYB9EQRWFf9lHsWvDr6cOiEVBnBIZl1bkVlk/qUWIPnkhlL5DzwFG3ga/DM+hOWkk7iGTknz63KlAIqgLdDPGl45OTp3e05aTGUWb+UmMhsYVssjHOAWbBjXWGPVPu65kxHr49UBlEBJU6DiqFmUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NDvXShjx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nttq89+1; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NDvXShjx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nttq89+1; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6FF7D1F381;
	Mon, 18 Nov 2024 09:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731920851; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DUPyznSG52QE728V5aAFh/3Vl0FMXdjdGWDzUT0VeZQ=;
	b=NDvXShjxjYvN1o/6YAkwLIumrFiWs3G92RqR8LdNxEdcV+9p5vRqORKhZr2Rnkmynt7xLs
	MsenKh4V15gn7pMJrdFeI9z1NXOrEUHsVJ9PvGJlKXbJigG2SO81FcvLuoDqsbcLELrpTY
	WcVmk5IsiOiycT5cvDZbznxLW35xnQ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731920851;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DUPyznSG52QE728V5aAFh/3Vl0FMXdjdGWDzUT0VeZQ=;
	b=nttq89+1fyp/JxL9Cz4Pt5RZFTegGvoxaFrwZTvnzdynsFHqhCf3eAI0xUe7e49vlrLLnb
	8jjY99jY6e/Xa7Cw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731920851; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DUPyznSG52QE728V5aAFh/3Vl0FMXdjdGWDzUT0VeZQ=;
	b=NDvXShjxjYvN1o/6YAkwLIumrFiWs3G92RqR8LdNxEdcV+9p5vRqORKhZr2Rnkmynt7xLs
	MsenKh4V15gn7pMJrdFeI9z1NXOrEUHsVJ9PvGJlKXbJigG2SO81FcvLuoDqsbcLELrpTY
	WcVmk5IsiOiycT5cvDZbznxLW35xnQ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731920851;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DUPyznSG52QE728V5aAFh/3Vl0FMXdjdGWDzUT0VeZQ=;
	b=nttq89+1fyp/JxL9Cz4Pt5RZFTegGvoxaFrwZTvnzdynsFHqhCf3eAI0xUe7e49vlrLLnb
	8jjY99jY6e/Xa7Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5F12B1376E;
	Mon, 18 Nov 2024 09:07:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iH3dFtMDO2faFAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 18 Nov 2024 09:07:31 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id EF7CDA098A; Mon, 18 Nov 2024 10:07:26 +0100 (CET)
Date: Mon, 18 Nov 2024 10:07:26 +0100
From: Jan Kara <jack@suse.cz>
To: Ian Kent <raven@themaw.net>
Cc: Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>,
	Karel Zak <kzak@redhat.com>, Christian Brauner <brauner@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v4 0/3] fs: allow statmount to fetch the fs_subtype and
 sb_source
Message-ID: <20241118090726.kj7o3lg7hkihfpfv@quack3>
References: <20241111-statmount-v4-0-2eaf35d07a80@kernel.org>
 <20241112-antiseptisch-kinowelt-6634948a413e@brauner>
 <hss5w5in3wj3af3o2x3v3zfaj47gx6w7faeeuvnxwx2uieu3xu@zqqllubl6m4i>
 <63f3aa4b3d69b33f1193f4740f655ce6dae06870.camel@kernel.org>
 <20241113151848.hta3zax57z7lprxg@quack3>
 <83b4c065-8cb4-4851-a557-aa47b7d03b6f@themaw.net>
 <20241114115652.so2dkvhaahl2ygvl@quack3>
 <fe9f3161-b9e5-4943-9d55-dfec08e7594e@themaw.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe9f3161-b9e5-4943-9d55-dfec08e7594e@themaw.net>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Mon 18-11-24 07:29:42, Ian Kent wrote:
> On 14/11/24 19:56, Jan Kara wrote:
> > On Thu 14-11-24 09:45:23, Ian Kent wrote:
> > > On 13/11/24 23:18, Jan Kara wrote:
> > > > On Wed 13-11-24 08:45:06, Jeff Layton wrote:
> > > > > On Wed, 2024-11-13 at 12:27 +0100, Karel Zak wrote:
> > > > > > On Tue, Nov 12, 2024 at 02:39:21PM GMT, Christian Brauner wrote:
> > > > > > Next on the wish list is a notification (a file descriptor that can be
> > > > > > used in epoll) that returns a 64-bit ID when there is a change in the
> > > > > > mount node. This will enable us to enhance systemd so that it does not
> > > > > > have to read the entire mount table after every change.
> > > > > > 
> > > > > New fanotify events for mount table changes, perhaps?
> > > > Now that I'm looking at it I'm not sure fanotify is a great fit for this
> > > > usecase. A lot of fanotify functionality does not really work for virtual
> > > > filesystems such as proc and hence we generally try to discourage use of
> > > > fanotify for them. So just supporting one type of event (like FAN_MODIFY)
> > > > on one file inside proc looks as rather inconsistent interface. But I
> > > > vaguely remember we were discussing some kind of mount event, weren't we?
> > > > Or was that for something else?
> > > I still need to have a look at the existing notifications sub-systems but,
> > > tbh, I also don't think they offer the needed functionality.
> > > 
> > > The thing that was most useful with David's notifications when I was trying
> > > to improve the mounts handling was the queuing interface. It allowed me to
> > > batch notifications up to around a couple of hundred and grab them in one go
> > > for processing. This significantly lowered the overhead of rapid fire event
> > > processing. The ability to go directly to an individual mount and get it's
> > > information only got about half the improvement I saw, the rest come from
> > > the notifications improvement.
> > Well, if we implemented the mount notification events in fanotify, then the
> > mount events get queued in the notification group queue and you can process
> > the whole batch of events in one go if you want. So I don't see batching as
> > an issue. What I'm more worried about is that watching the whole system
> > for new mounts is going to be somewhat cumbersome when all you can do is to
> > watch new mounts attached under an existing mount / filesystem.
> 
> But, for mounts/unounts for example, isn't it the act of performing the
> mount/unmount that triggers the notification if the path in within a file
> system that's marked to report such events?

Obviously it is the act of mounting / unmounting that will trigger the
generation of the event. But I guess I don't understand what are you
getting at...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

