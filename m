Return-Path: <linux-fsdevel+bounces-75035-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPaCGM8tcmmadwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75035-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 15:01:51 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D3767A4F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 15:01:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B3CD8745873
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 13:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A5630C624;
	Thu, 22 Jan 2026 13:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SxSZXgmP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LEqeTs3G";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SxSZXgmP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LEqeTs3G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A372E2DDD
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jan 2026 13:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769088088; cv=none; b=awSh9UUPtci4ZXm/qTifsFUlQH0HGdBiAHsRiy3GlXREdOWGiJxNRvPLxZbhjetZ633PiJ8+YaRQVy/AMU7K6SsF/axKjQlxXGrltzPl/H3KxJGsIZGD8aUE0e4KmUfhAcz0bsvCgwa6RH69SANJ5JGWTvywMzWPfpiFUmGaGbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769088088; c=relaxed/simple;
	bh=ggl1ZLAJfeIC8TCdWgaAloY+kGyhkOzqZQW28aG6DYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NvPK/ccriAr1m/2zfejo6JliV6uFKetZvgHG1O/PzZQXzi+wOll00bP5MYsEY6Aro6IK9I390KYCXpGdveCtR3YdCymj6oPbuCPQnHw/FwLdj+sAxwWmznoGZyuCHM81UIh6QIeRgjbp9Tmi11mcM9hWVQP+E57vnGH2WoudMYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SxSZXgmP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LEqeTs3G; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SxSZXgmP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LEqeTs3G; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 93383336D7;
	Thu, 22 Jan 2026 13:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769088084; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HUh/HyGRQjNjfeknhBlLAbWZutXuL5sIG8BgXau6jyg=;
	b=SxSZXgmPr9uQdRQUSt3YxyOSFTuKw9Zqr+vaGCqJpxL35nIgHkiLbil+jE84VytdoIpgku
	vN9KSFhgq91bjlIXbntbVCn9buIoxJu1FsPXrd3yojXL61VSoxlvmhp9WLcCR+2flSmTCY
	NF/5i3mMlrpGBSXamNAh0zT+J7CTTJ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769088084;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HUh/HyGRQjNjfeknhBlLAbWZutXuL5sIG8BgXau6jyg=;
	b=LEqeTs3GBwIvuhlrKI3ThK4WGvXkH8hC+Lvn9xXfqe0KqFPnVVg/p8xE34ZoywIQUKFyjK
	HseFzmXrQPlLv6BQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=SxSZXgmP;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=LEqeTs3G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769088084; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HUh/HyGRQjNjfeknhBlLAbWZutXuL5sIG8BgXau6jyg=;
	b=SxSZXgmPr9uQdRQUSt3YxyOSFTuKw9Zqr+vaGCqJpxL35nIgHkiLbil+jE84VytdoIpgku
	vN9KSFhgq91bjlIXbntbVCn9buIoxJu1FsPXrd3yojXL61VSoxlvmhp9WLcCR+2flSmTCY
	NF/5i3mMlrpGBSXamNAh0zT+J7CTTJ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769088084;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HUh/HyGRQjNjfeknhBlLAbWZutXuL5sIG8BgXau6jyg=;
	b=LEqeTs3GBwIvuhlrKI3ThK4WGvXkH8hC+Lvn9xXfqe0KqFPnVVg/p8xE34ZoywIQUKFyjK
	HseFzmXrQPlLv6BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7B0E013533;
	Thu, 22 Jan 2026 13:21:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4WgEHlQkcmkAOwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 22 Jan 2026 13:21:24 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3B16EA0A4F; Thu, 22 Jan 2026 14:21:20 +0100 (CET)
Date: Thu, 22 Jan 2026 14:21:20 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Mateusz Guzik <mjguzik@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC v2] pidfs: convert rb-tree to rhashtable
Message-ID: <mz3327rwi2mgtjhdrjkf6kb7lvfzi3ddqjbj6zfhpdr7gzp5li@qp27h7ec55wl>
References: <20260120-work-pidfs-rhashtable-v2-1-d593c4d0f576@kernel.org>
 <6yefrqagwzxnyauuidtvzsaejowzrkh5u2cjrjwmn5ulbt27by@fy5fezgl4tsq>
 <20260122-allrad-zirkel-9d519a7f12f3@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122-allrad-zirkel-9d519a7f12f3@brauner>
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75035-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,zeniv.linux.org.uk,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.cz:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 07D3767A4F
X-Rspamd-Action: no action

On Thu 22-01-26 11:18:10, Christian Brauner wrote:
> On Wed, Jan 21, 2026 at 11:59:11AM +0100, Jan Kara wrote:
> > On Tue 20-01-26 15:52:35, Christian Brauner wrote:
> > > Mateusz reported performance penalties [1] during task creation because
> > > pidfs uses pidmap_lock to add elements into the rbtree. Switch to an
> > > rhashtable to have separate fine-grained locking and to decouple from
> > > pidmap_lock moving all heavy manipulations outside of it.
> > > 
> > > Convert the pidfs inode-to-pid mapping from an rb-tree with seqcount
> > > protection to an rhashtable. This removes the global pidmap_lock
> > > contention from pidfs_ino_get_pid() lookups and allows the hashtable
> > > insert to happen outside the pidmap_lock.
> > > 
> > > pidfs_add_pid() is split. pidfs_prepare_pid() allocates inode number and
> > > initializes pid fields and is called inside pidmap_lock. pidfs_add_pid()
> > > inserts pid into rhashtable and is called outside pidmap_lock. Insertion
> > > into the rhashtable can fail and memory allocation may happen so we need
> > > to drop the spinlock.
> > > 
> > > To guard against accidently opening an already reaped task
> > > pidfs_ino_get_pid() uses additional checks beyond pid_vnr(). If
> > > pid->attr is PIDFS_PID_DEAD or NULL the pid either never had a pidfd or
> > > it already went through pidfs_exit() aka the process as already reaped.
> > > If pid->attr is valid check PIDFS_ATTR_BIT_EXIT to figure out whether
> > > the task has exited.
> > > 
> > > This slightly changes visibility semantics: pidfd creation is denied
> > > after pidfs_exit() runs, which is just before the pid number is removed
> > > from the via free_pid(). That should not be an issue though.
> > > 
> > > Link: https://lore.kernel.org/20251206131955.780557-1-mjguzik@gmail.com [1]
> > > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > 
> > Looks very nice! Feel free to add:
> > 
> > Reviewed-by: Jan Kara <jack@suse.cz>
> > 
> > I have just one question about the new PIDFS_ATTR_BIT_EXIT check.  AFAIU it
> > protects from grabbing struct pid references for pids that are dying. But
> > we can also call free_pid() from places like ksys_setsid() where
> > PIDFS_ATTR_BIT_EXIT is not set. So this check only seems as a convenience
> > rather than some hard guarantee, am I right?
> 
> Excellent question!
> 
> So the way this whole freeing works is weird. So when a task becomes a
> session leader or process group leader __change_pid() detaches the task
> from its old session/process group leader.
> 
> The old session leader/process group leader pid only ends up with
> free_pid() called on it if it has already been reaped, i.e.,
> pid_has_task() returns NULL.

Aha, I have missed this subtlety in __change_pid(). Thanks for
clarification!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

