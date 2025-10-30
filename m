Return-Path: <linux-fsdevel+bounces-66466-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C530BC201B8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 13:55:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4A60C34ECBF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 12:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B85F354716;
	Thu, 30 Oct 2025 12:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sIZioqoc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+ExO06wt";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sIZioqoc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+ExO06wt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A5E308F1B
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Oct 2025 12:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761828901; cv=none; b=PJsHbRuhyzOGdRAZC89qESj0crox5K0ye8vh80pTaDLWIRgPMUsBB86zxVoR2t4x+S7t6BO4mA1l2zgy88XsCxgCmh/uPjbaBfCGwoVnXsTooz/8Se8GNliajlb9/TYmpUoEIGJ9yEclGua4vRAJ2SdYsZK9Q+drZQA7OQo9+NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761828901; c=relaxed/simple;
	bh=u8ECFwUUGjFmeNZKOnUzuZtrLuBRbwwB0bHvHqCIcTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k/CkdDYZJpgDWQoClSly+b8rZGDtuxH9PNpwnddip1OAlsTX+PvRr/cZ4//EWdIzkaQq/A9k8+pbDd2KKV2+SkLW9vMWVwNcjRxsu0ic/QQCuqViarQXDRt1aq3afE1/8yw3YNQ2sKrAX7WvlIv6BgqTm9B9lnpFpveswtUprLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sIZioqoc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+ExO06wt; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sIZioqoc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+ExO06wt; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 010C43376F;
	Thu, 30 Oct 2025 12:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761828898; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=glh4d7jIrhmVwvs6juX9j4qY4JWhtfTVX1rq7n//aXQ=;
	b=sIZioqocldhdLfSE0ikv+66H/BwUY1NnHjSF7IkZPrewOV4TIjR0L0ZxenI+DikegLIzIL
	q7TGtuRlP/dz9trVR6lXjg4bgm+P+Vgt0oLTZgYpLQIbOCxIcWgM8fARoMzb6wx9YSwHmi
	gZOBC5sxRFhubytS62sUCb3vwjknjIc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761828898;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=glh4d7jIrhmVwvs6juX9j4qY4JWhtfTVX1rq7n//aXQ=;
	b=+ExO06wt0o23jz7/OfkhXfVdkxV4JSZuH5faMNkEuAKNViZoZKVGXn/ter5hKQCBHqkwVw
	n9vk2f4aK68PMdBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=sIZioqoc;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=+ExO06wt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761828898; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=glh4d7jIrhmVwvs6juX9j4qY4JWhtfTVX1rq7n//aXQ=;
	b=sIZioqocldhdLfSE0ikv+66H/BwUY1NnHjSF7IkZPrewOV4TIjR0L0ZxenI+DikegLIzIL
	q7TGtuRlP/dz9trVR6lXjg4bgm+P+Vgt0oLTZgYpLQIbOCxIcWgM8fARoMzb6wx9YSwHmi
	gZOBC5sxRFhubytS62sUCb3vwjknjIc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761828898;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=glh4d7jIrhmVwvs6juX9j4qY4JWhtfTVX1rq7n//aXQ=;
	b=+ExO06wt0o23jz7/OfkhXfVdkxV4JSZuH5faMNkEuAKNViZoZKVGXn/ter5hKQCBHqkwVw
	n9vk2f4aK68PMdBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E83F813393;
	Thu, 30 Oct 2025 12:54:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eFaoOCFgA2liQgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 30 Oct 2025 12:54:57 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A27E9A0AD6; Thu, 30 Oct 2025 13:54:53 +0100 (CET)
Date: Thu, 30 Oct 2025 13:54:53 +0100
From: Jan Kara <jack@suse.cz>
To: Geoff Back <geoff@demonlair.co.uk>
Cc: Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>, 
	Carlos Maiolino <cem@kernel.org>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-raid@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: fall back from direct to buffered I/O when stable writes are
 required
Message-ID: <zqnjwqiqjhtr74ixaaqwm3vxyfyhzln3a7vbol3z4qmyebryar@v42uqt4lnmxh>
References: <20251029071537.1127397-1-hch@lst.de>
 <aQNJ4iQ8vOiBQEW2@dread.disaster.area>
 <5ac7fb86-07a2-4fc6-959e-524ff54afebf@demonlair.co.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5ac7fb86-07a2-4fc6-959e-524ff54afebf@demonlair.co.uk>
X-Rspamd-Queue-Id: 010C43376F
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[12];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 

On Thu 30-10-25 12:00:26, Geoff Back wrote:
> On 30/10/2025 11:20, Dave Chinner wrote:
> > On Wed, Oct 29, 2025 at 08:15:01AM +0100, Christoph Hellwig wrote:
> >> Hi all,
> >>
> >> we've had a long standing issue that direct I/O to and from devices that
> >> require stable writes can corrupt data because the user memory can be
> >> modified while in flight.  This series tries to address this by falling
> >> back to uncached buffered I/O.  Given that this requires an extra copy it
> >> is usually going to be a slow down, especially for very high bandwith
> >> use cases, so I'm not exactly happy about.
> > How many applications actually have this problem? I've not heard of
> > anyone encoutnering such RAID corruption problems on production
> > XFS filesystems -ever-, so it cannot be a common thing.
> >
> > So, what applications are actually tripping over this, and why can't
> > these rare instances be fixed instead of penalising the vast
> > majority of users who -don't have a problem to begin with-?
> I don't claim to have deep knowledge of what's going on here, but if I
> understand correctly the problem occurs only if the process submitting
> the direct I/O is breaking the semantic "contract" by modifying the page
> after submitting the I/O but before it completes.  Since the page
> referenced by the I/O is supposed to be immutable until the I/O
> completes, what about marking the page read only at time of submission
> and restoring the original page permissions after the I/O completes? 
> Then if the process writes to the page (triggering a fault) make a copy
> of the page that can be mapped back as writeable for the process - i.e.
> normal copy-on-write behaviour - and write a once-per-process dmesg
> warning that the process broke the direct I/O "contract".  And maybe tag
> the process with a flag that forces all future "direct I/O" requests
> made by that process to be automatically made buffered?
> 
> That way, processes that behave correctly still get direct I/O, and
> those that do break the rules get degraded to buffered I/O.
> 
> Unfortunately I don't know enough to know what the performance impact of
> changing the page permissions for every direct I/O would be.

That is a fine idea and we've considered that. The trouble is this gets
quite complex because buffers may be modified not only through the
application directly writing to the buffer while the IO is in flight but
also by setting up another IO to the same buffer. As soon as you let the
first IO use the buffer, the kernel would need to block all the other IOs
to the same buffer and doing all this without providing malicious apps with
a way to deadlock the kernel by cleverly chaining IOs & buffers.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

