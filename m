Return-Path: <linux-fsdevel+bounces-35574-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB739D5EF4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 13:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4333281F5E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 12:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0193F1DEFC8;
	Fri, 22 Nov 2024 12:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wg83j0e3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="EhtrLo1t";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wg83j0e3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="EhtrLo1t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE5A22075;
	Fri, 22 Nov 2024 12:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732279340; cv=none; b=uPS+sOUityXW3Ca0gbT+ySQeMCbYDNA6eceMZGg/pSn+LCnP10pUvzVo7C+zz/8QNOq7fxC29zjuJkyUhofQIXnEV8eqjZRpenelJ9DqHpHiEvZWZBaQlN+oH/jVEW5GTbFO+Z+Xd5jUkbcs6zJCVRFboMvlIqR/aSmEKbnIr/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732279340; c=relaxed/simple;
	bh=hKUIYAxLv3+uDas2GbrjOk2la6uS7w7IOF4e/sI/cro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YZl7KueKHCOvFjlBnFVmqBQ06k2ioobcdxTmaYd//UPzrK/wa+5QTu25DENMOXX6fVfR2HSlRURZQOLlevJq3i4kCk+L1/WN8CDG05mAfRuXdGTueb4/4u8YS0qpa6j030QxkZboBz97Kpcuqjvv8W3sQgy+pBtIEW04p87MJY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wg83j0e3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=EhtrLo1t; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wg83j0e3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=EhtrLo1t; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 617291F37E;
	Fri, 22 Nov 2024 12:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732279336; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m1y1r4sHVpVio90pxvAPQyjpbXtCbYSZFBXxevcolao=;
	b=wg83j0e3hSLltgYOUYSZN0jS+angV9uQghS0LenqzGPk3qbp86odk05SMKk4+Mhf7hpfyf
	ZGXYH/3G/sfodnI38ZtqnQgEILuFBVGJ2Jn7orHyVjxfX72HC9xs791LbYgebWr2bl8+GC
	Kl50ZHoiD2FMC5bHwsPy4ZPIL706+ug=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732279336;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m1y1r4sHVpVio90pxvAPQyjpbXtCbYSZFBXxevcolao=;
	b=EhtrLo1t6LF9G4YWEqQr33i346haGUJHbJcFmU1TT4kt9Aw5LnX1axDrQOr5+bwEGLVchz
	qVZB81zTxia51PBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=wg83j0e3;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=EhtrLo1t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732279336; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m1y1r4sHVpVio90pxvAPQyjpbXtCbYSZFBXxevcolao=;
	b=wg83j0e3hSLltgYOUYSZN0jS+angV9uQghS0LenqzGPk3qbp86odk05SMKk4+Mhf7hpfyf
	ZGXYH/3G/sfodnI38ZtqnQgEILuFBVGJ2Jn7orHyVjxfX72HC9xs791LbYgebWr2bl8+GC
	Kl50ZHoiD2FMC5bHwsPy4ZPIL706+ug=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732279336;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m1y1r4sHVpVio90pxvAPQyjpbXtCbYSZFBXxevcolao=;
	b=EhtrLo1t6LF9G4YWEqQr33i346haGUJHbJcFmU1TT4kt9Aw5LnX1axDrQOr5+bwEGLVchz
	qVZB81zTxia51PBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5134A138A7;
	Fri, 22 Nov 2024 12:42:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wOrMEyh8QGdOSQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 22 Nov 2024 12:42:16 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 00DB1A08B5; Fri, 22 Nov 2024 13:42:15 +0100 (CET)
Date: Fri, 22 Nov 2024 13:42:15 +0100
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
Message-ID: <20241122124215.3k3udv5o6eys6ffy@quack3>
References: <cover.1731684329.git.josef@toxicpanda.com>
 <b80986f8d5b860acea2c9a73c0acd93587be5fe4.1731684329.git.josef@toxicpanda.com>
 <20241121104428.wtlrfhadcvipkjia@quack3>
 <CAOQ4uxhTiR8eHaf4q0_gLC62CWi9KdaQ05GSeqFkKFkXCH++PA@mail.gmail.com>
 <20241121163618.ubz7zplrnh66aajw@quack3>
 <CAOQ4uxhsEA2zj-a6H+==S+6G8nv+BQEJDoGjJeimX0yRhHso2w@mail.gmail.com>
 <CAOQ4uxgsjKwX7eoYcjU8SRWjRw39MNv=CMjjO1mQGr9Cd4iafQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxgsjKwX7eoYcjU8SRWjRw39MNv=CMjjO1mQGr9Cd4iafQ@mail.gmail.com>
X-Rspamd-Queue-Id: 617291F37E
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
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Thu 21-11-24 19:37:43, Amir Goldstein wrote:
> On Thu, Nov 21, 2024 at 7:31 PM Amir Goldstein <amir73il@gmail.com> wrote:
> > On Thu, Nov 21, 2024 at 5:36 PM Jan Kara <jack@suse.cz> wrote:
> > > On Thu 21-11-24 15:18:36, Amir Goldstein wrote:
> > > > On Thu, Nov 21, 2024 at 11:44 AM Jan Kara <jack@suse.cz> wrote:
> > > > and also always emitted ACCESS_PERM.
> > >
> > > I know that and it's one of those mostly useless events AFAICT.
> > >
> > > > my POC is using that PRE_ACCESS to populate
> > > > directories on-demand, although the functionality is incomplete without the
> > > > "populate on lookup" event.
> > >
> > > Exactly. Without "populate on lookup" doing "populate on readdir" is ok for
> > > a demo but not really usable in practice because you can get spurious
> > > ENOENT from a lookup.
> > >
> > > > > avoid the mistake of original fanotify which had some events available on
> > > > > directories but they did nothing and then you have to ponder hard whether
> > > > > you're going to break userspace if you actually start emitting them...
> > > >
> > > > But in any case, the FAN_ONDIR built-in filter is applicable to PRE_ACCESS.
> > >
> > > Well, I'm not so concerned about filtering out uninteresting events. I'm
> > > more concerned about emitting the event now and figuring out later that we
> > > need to emit it in different places or with some other info when actual
> > > production users appear.
> > >
> > > But I've realized we must allow pre-content marks to be placed on dirs so
> > > that such marks can be placed on parents watching children. What we'd need
> > > to forbid is a combination of FAN_ONDIR and FAN_PRE_ACCESS, wouldn't we?
> >
> > Yes, I think that can work well for now.
> >
> 
> Only it does not require only check at API time that both flags are not
> set, because FAN_ONDIR can be set earlier and then FAN_PRE_ACCESS
> can be added later and vice versa, so need to do this in
> fanotify_may_update_existing_mark() AFAICT.

I have now something like:

@@ -1356,7 +1356,7 @@ static int fanotify_group_init_error_pool(struct fsnotify_group *group)
 }
 
 static int fanotify_may_update_existing_mark(struct fsnotify_mark *fsn_mark,
-                                             unsigned int fan_flags)
+                                            __u32 mask, unsigned int fan_flags)
 {
        /*
         * Non evictable mark cannot be downgraded to evictable mark.
@@ -1383,6 +1383,11 @@ static int fanotify_may_update_existing_mark(struct fsnotify_mark *fsn_mark,
            fsn_mark->flags & FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY)
                return -EEXIST;
 
+       /* For now pre-content events are not generated for directories */
+       mask |= fsn_mark->mask;
+       if (mask & FANOTIFY_PRE_CONTENT_EVENTS && mask & FAN_ONDIR)
+               return -EEXIST;
+
        return 0;
 }
 
So far only compile tested...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

