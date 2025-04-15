Return-Path: <linux-fsdevel+bounces-46489-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE016A8A367
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 17:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08BB01886933
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 15:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC931F4622;
	Tue, 15 Apr 2025 15:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gSAwQXZ2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jOS+fz4W";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gSAwQXZ2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jOS+fz4W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42010158858
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Apr 2025 15:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744732323; cv=none; b=kFJEG+p/bhkG3BEfckC68LdDSUfvxACkPl8aJ2VqkSmYdt1wVRyVknuKDdZO7Ayee7ZPB7Ee1Gs0+d75B0fC/zJWxmZvViTBvyOnvFfvlBWE1kFcl+FqGpyXQjzqfodhXuKOdq8Qpjs7kJKhDV9JCqlwFwt8HhM1FwJVrVrjVeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744732323; c=relaxed/simple;
	bh=VUxZIe9s2AnwXFE6h3k8JWfhwAQUc3Rbm7/sw6co4Bk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fCDhD2PPijI/R7kjSQ1TIPc6vJRwGwl4KaVIgM/y5AILraOrCVBCqeYH2ShgkpFufczlI0x7jKdA4ttHAHgk8x1dTkhzpzKhELe4y1qNer9yeAltr0hcJrEX7/IfuN4BNyAxBTRJmC/rW0B05Cd1hnYOfQVzBrmHs4kZYbWLuVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gSAwQXZ2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jOS+fz4W; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gSAwQXZ2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jOS+fz4W; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0625721180;
	Tue, 15 Apr 2025 15:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744732319; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hayCFIEuBmZpYQNhCrlZDtyF2BkZEY6kH2FudB+mTts=;
	b=gSAwQXZ2itZKdk6ccZe1S6ssg188I7rbvwkUlV5XyTfrUg8MNYqMFTPE42LALgBUBwAEOQ
	6PwGg95M2ZMpjqDk7xX2vnbKujwk8a49NBLWEEnQFVs0UyqBFDzm4h3L17xsrRdYVOnJvw
	uxhJ340Ke2mQ54BgTSF6fF7BE305ElE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744732319;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hayCFIEuBmZpYQNhCrlZDtyF2BkZEY6kH2FudB+mTts=;
	b=jOS+fz4WnOkJ9UnpmA1+nsULd/CvwKfhzMIoAY1yEvBVEslstcUF3cSitOi5mJg4QkfukR
	U+QL+3dX+lHoP9BQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=gSAwQXZ2;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=jOS+fz4W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744732319; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hayCFIEuBmZpYQNhCrlZDtyF2BkZEY6kH2FudB+mTts=;
	b=gSAwQXZ2itZKdk6ccZe1S6ssg188I7rbvwkUlV5XyTfrUg8MNYqMFTPE42LALgBUBwAEOQ
	6PwGg95M2ZMpjqDk7xX2vnbKujwk8a49NBLWEEnQFVs0UyqBFDzm4h3L17xsrRdYVOnJvw
	uxhJ340Ke2mQ54BgTSF6fF7BE305ElE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744732319;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hayCFIEuBmZpYQNhCrlZDtyF2BkZEY6kH2FudB+mTts=;
	b=jOS+fz4WnOkJ9UnpmA1+nsULd/CvwKfhzMIoAY1yEvBVEslstcUF3cSitOi5mJg4QkfukR
	U+QL+3dX+lHoP9BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ECA4E139A1;
	Tue, 15 Apr 2025 15:51:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WUvBOZ6A/mdAVwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 15 Apr 2025 15:51:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 7C86AA0947; Tue, 15 Apr 2025 17:51:58 +0200 (CEST)
Date: Tue, 15 Apr 2025 17:51:58 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>, jack@suse.cz, 
	josef@toxicpanda.com, lesha@meta.com, linux-fsdevel@vger.kernel.org, sargun@meta.com
Subject: Re: Reseting pending fanotify events
Message-ID: <d2n57euuuy2gd63gweovkyvcya3igjttdabgpz4txxtf4v2pou@3eb7slijnhcl>
References: <CAOQ4uxgXO0XJzYmijXu=3yDF_hq3E1yPUxHqhwka19-_jeaNFA@mail.gmail.com>
 <20250408185506.3692124-1-ibrahimjirdeh@meta.com>
 <CAOQ4uxjnjSeDpzk9j6QBQzhiSwwmOAejefxNL3Ar49BuCzBsKg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxjnjSeDpzk9j6QBQzhiSwwmOAejefxNL3Ar49BuCzBsKg@mail.gmail.com>
X-Rspamd-Queue-Id: 0625721180
X-Spam-Level: 
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
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[7];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Wed 09-04-25 14:36:16, Amir Goldstein wrote:
> On Tue, Apr 8, 2025 at 8:55 PM Ibrahim Jirdeh <ibrahimjirdeh@meta.com> wrote:
> >
> > > 1. Start a new server instance
> > > 2. Set default response in case of new instance crash
> > > 3. Hand over a ref of the existing group fd to the new instance if the
> > > old instance is running
> > > 4. Start handling events in new instance (*)
> > > 5. Stop handling new events in old instance, but complete pending events
> > > 6. Shutdown old instance
> >
> > I think this should work for our case, we will only need to reconstruct
> > the group/interested mask in case of crash. I can help add the feature for
> > setting different default responses.
> >
> 
> Please go ahead.
> 
> We did not yet get any feedback from Jan on this idea,
> but ain't nothing like a patch to solicit feedback.

I'm sorry for the delay but I wanted to find time to give a deeper thought
to this.

> > > I might have had some patches similar to this floating around.
> > > If you are interested in this feature, I could write and test a proper patch.
> >
> > That would be appreciated if its not too much trouble, the approach outlined
> > in sketch should be enough for our use-case (pending the sb vs mount monitoring
> > point you've raised).
> >
> 
> Well, the only problem is when I can get to it, which does not appear to be
> anytime soon. If this is an urgent issue for you I could give you more pointers
> to  try and do it yourself.
> 
> There is one design decision that we would need to make before
> getting to the implementation.
> Assuming that this API is acceptable:
> 
> fanotify_mark(fd, FAN_MARK_ADD | FAN_MARK_FILESYSTEM | FAN_MARK_DEFAULT, ...
> 
> What happens when fd is closed?
> Can the sbinfo->default_mask out live the group fd?

So I think there are two options how to consistently handle this and we
need to decide which one to pick. Do we want to:

a) tie the concept to a particular notification group - i.e., if a particular
notification group is not existing anymore, we want events on particular
object(s) auto-rejected.

or

b) tie the concept to the object itself - i.e., if there's no notification
group handling events for the object, auto-reject the events.

Both has its advantages and disadvantages. With a) we can easily have
multiple handlers cooperate on one filesystem (e.g. an HSM and antivirus
solution), the notification group can just register itself as mandatory for
all events on the superblock object and we don't have to care about details
how the notification group watches for events or so. But what gets complex
with this variant is how to hand over control from the old to the new
version of the service or even worse how to recover from crashed service -
you need to register the new group as mandatory and somehow "unregister"
the crashed one.

For b) hand-over or crash recovery is simple. As soon as someone places a
mark over given object, it is implicitly the new handler for the object and
auto-reject does not trigger. But if you set that e.g. all events on the
superblock need to be handled, then you really have to setup watches so
that notification system understands each event really got handled (which
potentially conflicts with the effort to avoid handling uninteresting
events). Also any coexistence of two services using this facility is going
to be "interesting".

> I think that closing this group should remove the default mask
> and then the default mask is at least visible at fdinfo of this fd.

Once we decide the above dilema, we can decide on what's the best way to
set these and also about visibility (I agree that is very important as
well). 

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

