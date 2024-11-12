Return-Path: <linux-fsdevel+bounces-34466-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2DF9C5A67
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 15:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F00DB450C9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 14:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28113200120;
	Tue, 12 Nov 2024 14:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PxhF9k8I";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ci1Vbl6T";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="a2DBeAcV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6y0PPdox"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F091FCC42;
	Tue, 12 Nov 2024 14:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731421697; cv=none; b=LSYmoDLb4+1jK0YzXu7Iut9S4YhY3TbnuIYGVOiXjFHK5NOsh62FTN+WSzV2ZUZrnDzR0qSoCk1Hq7cUQp3tzV1sRxVmDLCjwa72zw6/coZkZ9BmJ4/n0nydZo8CPcWoUrxOH2ZQIOxCD5n3N7Q9gRdV64xBj7AImdKmp4oV7h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731421697; c=relaxed/simple;
	bh=b2thYqmsbuJTYOCIo+Qi5hzIAEoojswSxtz+p4LvJ/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OTf/G3IMJ7KyXOe31C+O2JCQutGY5D77VUM6HmSJXTSsKw/QnMPkQzplCpoG69idWVtnow1hXDpaNOCIFJSJvjouh1JVHFnFOwlEarpljpNs9aqgulG2Jfqr0QrzPZnVZs4hOK1NCfabptFAJ994GSYOlCWKuZk2/b5ArjeyVDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PxhF9k8I; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ci1Vbl6T; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=a2DBeAcV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6y0PPdox; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 71DFE21275;
	Tue, 12 Nov 2024 14:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731421693; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ClyVBEltyYujlDz24jO9ypnOQpbboViAYoIODTZM/lw=;
	b=PxhF9k8IkeMhUwKvndc/9URZlbD0AYtO4ZjKFDU1nr2CCKah9R96iGDFRg6LUlXx6YKC9Z
	V2+xWYZV7Gg4uUXjwRHr/RvIlPyuxLzWrP4A/6647U9iTJEry7fS5Y3VVs6W9ayo0SZm99
	woDtwu44zNI3HAtHSLn2ngHU2bLFeO0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731421693;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ClyVBEltyYujlDz24jO9ypnOQpbboViAYoIODTZM/lw=;
	b=Ci1Vbl6TgfKD9ClavZ7Q7QuGsHIJj/bYlZoXcKvhLsd254xsstCfqkoph4by+CfU/Ek/Ec
	IWWOXLp/SV5TfpCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731421692; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ClyVBEltyYujlDz24jO9ypnOQpbboViAYoIODTZM/lw=;
	b=a2DBeAcVrN9MAM1HhLmGD0W8BnqzSiQmc9yAKEJcQ83IeHu8gWgqWVbca72yn8VILMK4jW
	zd31FhmV8ZECi+l/aIw3MRWHSFczSEW35FaStLSgM80WSNg0rUm6cEA2JXRaeIAkmKZXRF
	0oPJ3Z1xnykCfRZRbonBGylyW4LPQkA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731421692;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ClyVBEltyYujlDz24jO9ypnOQpbboViAYoIODTZM/lw=;
	b=6y0PPdoxrn1WdBgQzkDGOUh21uXthXUHmM6s5ILlLv9bgMYHSprTwMAfZVFmgNDxb7F95W
	x/ijrAkQmYOUemCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 65A0813301;
	Tue, 12 Nov 2024 14:28:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CQnLGPxlM2cXfAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 12 Nov 2024 14:28:12 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 15AC9A08D0; Tue, 12 Nov 2024 15:28:12 +0100 (CET)
Date: Tue, 12 Nov 2024 15:28:12 +0100
From: Jan Kara <jack@suse.cz>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Amir Goldstein <amir73il@gmail.com>, Josef Bacik <josef@toxicpanda.com>,
	kernel-team@fb.com, linux-fsdevel@vger.kernel.org, jack@suse.cz,
	brauner@kernel.org, linux-xfs@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-mm@kvack.org,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH v6 06/17] fsnotify: generate pre-content permission event
 on open
Message-ID: <20241112142812.37e3hyar3zqoqo5a@quack3>
References: <cover.1731355931.git.josef@toxicpanda.com>
 <b509ec78c045d67d4d7e31976eba4b708b238b66.1731355931.git.josef@toxicpanda.com>
 <CAHk-=wh4BEjbfaO93hiZs3YXoNmV=YkWT4=OOhuxM3vD2S-1iA@mail.gmail.com>
 <CAEzrpqdtSAoS+p4i0EzWFr0Nrpw1Q2hphatV7Sk4VM49=L3kGw@mail.gmail.com>
 <CAHk-=wj8L=mtcRTi=NECHMGfZQgXOp_uix1YVh04fEmrKaMnXA@mail.gmail.com>
 <CAOQ4uxgxtQhe_3mj5SwH9568xEFsxtNqexLfw9Wx_53LPmyD=Q@mail.gmail.com>
 <CAHk-=wgUV27XF8g23=aWNJecRbn8fCDDW2=10y9yJ122+d8JrA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgUV27XF8g23=aWNJecRbn8fCDDW2=10y9yJ122+d8JrA@mail.gmail.com>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,toxicpanda.com,fb.com,vger.kernel.org,suse.cz,kernel.org,kvack.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Mon 11-11-24 16:37:30, Linus Torvalds wrote:
> On Mon, 11 Nov 2024 at 16:00, Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > I think that's a good idea for pre-content events, because it's fine
> > to say that if the sb/mount was not watched by a pre-content event listener
> > at the time of file open, then we do not care.
> 
> Right.
> 
> > The problem is that legacy inotify/fanotify watches can be added after
> > file is open, so that is allegedly why this optimization was not done for
> > fsnotify hooks in the past.
> 
> So honestly, even if the legacy fsnotify hooks can't look at the file
> flag, they could damn well look at an inode flag.
> 
> And I'm not even convinced that we couldn't fix them to just look at a
> file flag, and say "tough luck, somebody opened that file before you
> started watching, you don't get to see what they did".
> 
> So even if we don't look at a file->f_mode flag, the lergacy cases
> should look at i_fsnotify_mask, and do that *first*.
> 
> IOW, not do it like fsnotify_object_watched() does now, which is just
> broken. Again, it looks at inode->i_sb->s_fsnotify_mask completely
> pointlessly, but it also does it much too late - it gets called after
> we've already called into the fsnotify() code and have messed up the
> I$ etc.
> 
> The "linode->i_sb->s_fsnotify_mask" is not only an extra indirection,
> it should be very *literally* pointless. If some bit isn't set in
> i_sb->s_fsnotify_mask, then there should be no way to set that bit in
> inode->i_fsnotify_mask. So the only time we should access
> i_sb->s_fsnotify_mask is when i_notify_mask gets *modified*, not when
> it gets tested.

Thanks for explanation but what you write here and below seems to me as if
you are not aware of some features fanotify API provides (for many years).
With fanotify you can place a mark not only on a file / directory but you
can place it also on a mount point or a superblock. In that case any
operation of appropriate type happening through that mount point or on that
superblock should deliver the event to the notification group that placed
the mark. So for example we check inode->i_sb->s_fsnotify_mask on open to
be able to decide whether somebody asked to get notifications about *all*
opens on that superblock and generate appropriate events. These features
are there since day 1 of fanotify (at least for mountpoints, superblocks
were added later) and quite some userspace depends on them for doing
filesystem-wide event monitoring.

We could somehow cache the fact that someone placed a mark on the
superblock in the inode / struct file but I don't see how to keep such
cache consistent with marks that are attached to the superblock without
incurring the very same cache misses we are trying to avoid.

I do like your idea of caching whether somebody wants the notification in
struct file as that way we can avoid the cache misses for the
new pre-content hooks and possibly in hooks for the traditional fanotify
permission events. But I don't see how we could possibly avoid these cache
misses for the classical notification events like FAN_OPEN, FAN_ACCESS,
FAN_MODIFY, ...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

