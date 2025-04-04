Return-Path: <linux-fsdevel+bounces-45753-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97AECA7BBAD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 13:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05537189974A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 11:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D234E1DDC37;
	Fri,  4 Apr 2025 11:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zFo8I+AH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4GxM0sO8";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zFo8I+AH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4GxM0sO8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFD6146588
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Apr 2025 11:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743766684; cv=none; b=k2sGtjReauEoqMeudYRv/K+tBGgZAW21ZJbb8p3Ye+bvxvwbLI5d8C4hbs4nMiQht13hnDVU6qSCL7tMLqCTNOvWnk48gwPK/6xLzji6SvsPH4p33pVic+fjfiCrKLkvQNXqVIKDOhhT0NfZ7FE1iry1FSGAhbx3pcEZfvovL0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743766684; c=relaxed/simple;
	bh=LVOJX536eBnpguyozyxRWxuhZQtgkiowjIid+09BobQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WyS3/toNImnFQGf841lhp3mkAkbWJr3pEQWvo3hT4Qe1jzURoq136bu1bQxfo7QntukhQ1eFIaGhu3aPNs2n9PskAO7BfuABtp93cVjnFrTdnb2UFJwdSrK1oRd96zR3vOBl125a5FA/VhLkQXK2npuQPV6Mo13+cJl5S+VgTAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zFo8I+AH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4GxM0sO8; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zFo8I+AH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4GxM0sO8; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0AB2F21170;
	Fri,  4 Apr 2025 11:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743766680; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=btK2YWUBWBjl50jSLs6f7l3/yojCjcY/V5Q5+8oI2Gw=;
	b=zFo8I+AHO5NGc0p/trsSt/4UjFcA+SqVBlivJNbX2c52R2SKfMRBC6iv00D3DxM4QnmWHb
	cRFphq2GcRIswNVrCMaquWMqtSfofKjA7lGCqsdgzsJq0+Lb+E2/pA/+jZ8Lsd/2KGF1r4
	86b/ra4AhldUtEArKQxsneiPHMb2+08=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743766680;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=btK2YWUBWBjl50jSLs6f7l3/yojCjcY/V5Q5+8oI2Gw=;
	b=4GxM0sO8U5mW2W2AkbQyOVn4BowKzc5GoC8ZurkOxpNRWx2au14z8vpR8CikGpFJ6q/GVP
	0sYMvQE/RbunV5CQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=zFo8I+AH;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=4GxM0sO8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743766680; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=btK2YWUBWBjl50jSLs6f7l3/yojCjcY/V5Q5+8oI2Gw=;
	b=zFo8I+AHO5NGc0p/trsSt/4UjFcA+SqVBlivJNbX2c52R2SKfMRBC6iv00D3DxM4QnmWHb
	cRFphq2GcRIswNVrCMaquWMqtSfofKjA7lGCqsdgzsJq0+Lb+E2/pA/+jZ8Lsd/2KGF1r4
	86b/ra4AhldUtEArKQxsneiPHMb2+08=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743766680;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=btK2YWUBWBjl50jSLs6f7l3/yojCjcY/V5Q5+8oI2Gw=;
	b=4GxM0sO8U5mW2W2AkbQyOVn4BowKzc5GoC8ZurkOxpNRWx2au14z8vpR8CikGpFJ6q/GVP
	0sYMvQE/RbunV5CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E54F613691;
	Fri,  4 Apr 2025 11:37:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TuuyN5fE72ffNwAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 04 Apr 2025 11:37:59 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 91C87A07E6; Fri,  4 Apr 2025 13:37:55 +0200 (CEST)
Date: Fri, 4 Apr 2025 13:37:55 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Josef Bacik <josef@toxicpanda.com>, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fanotify: allow creating FAN_PRE_ACCESS events on
 directories
Message-ID: <lxxf2muwgycjm2lerk6cfyumumwhszi7dgpj65nvwkxojutkkg@y7bxelrb54ge>
References: <20250402062707.1637811-1-amir73il@gmail.com>
 <u3myluuaylejsfidkkajxni33w2ezwcfztlhjmavdmpcoir45o@ew32e4yra6xb>
 <CAOQ4uxh7JhGMjoMpFWvHyEZ0j2kJUgLf9PjyvLeNbSAzVbDyQA@mail.gmail.com>
 <ba4cmwymyiived2xrxxlo5mi2hnnljkiy5mvlbzws2w2vpwwdm@pkekpc5d2apu>
 <CAOQ4uxgcv+1zaRKFgWQJYkEUt0pKs9Uuw8Pw0CvEoYHm2OQ7nw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxgcv+1zaRKFgWQJYkEUt0pKs9Uuw8Pw0CvEoYHm2OQ7nw@mail.gmail.com>
X-Rspamd-Queue-Id: 0AB2F21170
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Fri 04-04-25 12:44:11, Amir Goldstein wrote:
> On Fri, Apr 4, 2025 at 11:53 AM Jan Kara <jack@suse.cz> wrote:
> >
> > On Thu 03-04-25 19:24:57, Amir Goldstein wrote:
> > > On Thu, Apr 3, 2025 at 7:10 PM Jan Kara <jack@suse.cz> wrote:
> > > >
> > > > On Wed 02-04-25 08:27:07, Amir Goldstein wrote:
> > > > > Like files, a FAN_PRE_ACCESS event will be generated before every
> > > > > read access to directory, that is on readdir(3).
> > > > >
> > > > > Unlike files, there will be no range info record following a
> > > > > FAN_PRE_ACCESS event, because the range of access on a directory
> > > > > is not well defined.
> > > > >
> > > > > FAN_PRE_ACCESS events on readdir are only generated when user opts-in
> > > > > with FAN_ONDIR request in event mask and the FAN_PRE_ACCESS events on
> > > > > readdir report the FAN_ONDIR flag, so user can differentiate them from
> > > > > event on read.
> > > > >
> > > > > An HSM service is expected to use those events to populate directories
> > > > > from slower tier on first readdir access. Having to range info means
> > > > > that the entire directory will need to be populated on the first
> > > > > readdir() call.
> > > > >
> > > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > > > ---
> > > > >
> > > > > Jan,
> > > > >
> > > > > IIRC, the reason we did not allow FAN_ONDIR with FAN_PRE_ACCESS event
> > > > > in initial API version was due to uncertainty around reporting range info.
> > > > >
> > > > > Circling back to this, I do not see any better options other than not
> > > > > reporting range info and reporting the FAN_ONDIR flag.
> > > > >
> > > > > HSM only option is to populate the entire directory on first access.
> > > > > Doing a partial range populate for directories does not seem practical
> > > > > with exising POSIX semantics.
> > > >
> > > > I agree that range info for directory events doesn't make sense (or better
> > > > there's no way to have a generic implementation since everything is pretty
> > > > fs specific). If I remember our past discussion, filling in directory
> > > > content on open has unnecessarily high overhead because the user may then
> > > > just do e.g. lookup in the opened directory and not full readdir. That's
> > > > why you want to generate it on readdir. Correct?
> > > >
> > >
> > > Right.
> > >
> > > > > If you accept this claim, please consider fast tracking this change into
> > > > > 6.14.y.
> > > >
> > > > Hum, why the rush? It is just additional feature to allow more efficient
> > > > filling in of directory entries...
> > > >
> > >
> > > Well, no rush really.
> > >
> > > My incentive is not having to confuse users with documentation that
> > > version X supports FAN_PRE_ACCESS but only version Y supports
> > > it with FAN_ONDIR.
> > >
> > > It's not a big deal, but if we have no reason to delay this, I'd just
> > > treat it as a fix to the new api (removing unneeded limitations).
> >
> > The patch is easy enough so I guess we may push it for rc2. When testing
> > it, I've noticed a lot of LTP test cases fail (e.g. fanotify02) because they
> > get unexpected event. So likely the patch actually breaks something in
> > reporting of other events. I don't have time to analyze it right now so I'm
> > just reporting it in case you have time to have a look...
> >
> 
> Damn I should have tested that.
> Patch seemed so irrelevant for non pre-content events that it eluded me.
> 
> It took me a good amount of staring time until I realized that both
> FANOTIFY_OUTGOING_EVENTS and FANOTIFY_EVENT_FLAGS
> include the FAN_ONDIR flag.
> 
> This diff fixes the failing tests:
> 
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index 531c038eed7c..f90598044ec9 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -373,6 +373,8 @@ static u32 fanotify_group_event_mask(struct
> fsnotify_group *group,
>                 user_mask |= FANOTIFY_EVENT_FLAGS;
>         } else if (test_mask & FANOTIFY_PRE_CONTENT_EVENTS) {
>                 user_mask |= FAN_ONDIR;
> +       } else {
> +               user_mask &= ~FANOTIFY_EVENT_FLAGS;
>         }
> 
>         return test_mask & user_mask;

Thanks. What I actually ended up with is below. It passes all the tests and
I think that returning FANOTIFY_EVENT_ON_CHILD in the mask is actually more
consistent? Definitely less cases to consider... But please holler if you
see any problem with that.

								Honza

From 276b25c6726efc0d2aaef208f905d185e58412d8 Mon Sep 17 00:00:00 2001
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 2 Apr 2025 08:27:07 +0200
Subject: [PATCH] fanotify: allow creating FAN_PRE_ACCESS events on directories

Like files, a FAN_PRE_ACCESS event will be generated before every
read access to directory, that is on readdir(3).

Unlike files, there will be no range info record following a
FAN_PRE_ACCESS event, because the range of access on a directory
is not well defined.

FAN_PRE_ACCESS events on readdir are only generated when user opts-in
with FAN_ONDIR request in event mask and the FAN_PRE_ACCESS events on
readdir report the FAN_ONDIR flag, so user can differentiate them from
event on read.

An HSM service is expected to use those events to populate directories
from slower tier on first readdir access. Having to range info means
that the entire directory will need to be populated on the first
readdir() call.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Link: https://patch.msgid.link/20250402062707.1637811-1-amir73il@gmail.com
---
 fs/notify/fanotify/fanotify.c      | 8 +++++---
 fs/notify/fanotify/fanotify_user.c | 9 ---------
 2 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 6d386080faf2..98d6955f9fde 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -303,8 +303,7 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
 				     struct inode *dir)
 {
 	__u32 marks_mask = 0, marks_ignore_mask = 0;
-	__u32 test_mask, user_mask = FANOTIFY_OUTGOING_EVENTS |
-				     FANOTIFY_EVENT_FLAGS;
+	__u32 test_mask, user_mask = FANOTIFY_OUTGOING_EVENTS;
 	const struct path *path = fsnotify_data_path(data, data_type);
 	unsigned int fid_mode = FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS);
 	struct fsnotify_mark *mark;
@@ -356,6 +355,9 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
 	 * the child entry name information, we report FAN_ONDIR for mkdir/rmdir
 	 * so user can differentiate them from creat/unlink.
 	 *
+	 * For pre-content events we report FAN_ONDIR for readdir, so user can
+	 * differentiate them from read.
+	 *
 	 * For backward compatibility and consistency, do not report FAN_ONDIR
 	 * to user in legacy fanotify mode (reporting fd) and report FAN_ONDIR
 	 * to user in fid mode for all event types.
@@ -364,7 +366,7 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
 	 * fanotify_alloc_event() when group is reporting fid as indication
 	 * that event happened on child.
 	 */
-	if (fid_mode) {
+	if (fid_mode || test_mask & FANOTIFY_PRE_CONTENT_EVENTS) {
 		/* Do not report event flags without any event */
 		if (!(test_mask & ~FANOTIFY_EVENT_FLAGS))
 			return 0;
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index f2d840ae4ded..38cb9ba54842 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1410,11 +1410,6 @@ static int fanotify_may_update_existing_mark(struct fsnotify_mark *fsn_mark,
 	    fsn_mark->flags & FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY)
 		return -EEXIST;
 
-	/* For now pre-content events are not generated for directories */
-	mask |= fsn_mark->mask;
-	if (mask & FANOTIFY_PRE_CONTENT_EVENTS && mask & FAN_ONDIR)
-		return -EEXIST;
-
 	return 0;
 }
 
@@ -1956,10 +1951,6 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 	if (mask & FAN_RENAME && !(fid_mode & FAN_REPORT_NAME))
 		return -EINVAL;
 
-	/* Pre-content events are not currently generated for directories. */
-	if (mask & FANOTIFY_PRE_CONTENT_EVENTS && mask & FAN_ONDIR)
-		return -EINVAL;
-
 	if (mark_cmd == FAN_MARK_FLUSH) {
 		if (mark_type == FAN_MARK_MOUNT)
 			fsnotify_clear_vfsmount_marks_by_group(group);
-- 
2.43.0


> --
> 
> I don't know if this needs to be further clarified to avoid confusion
> when reading this code in the future?
> 
> > > I would point out that FAN_ACCESS_PERM already works
> > > for directories and in effect provides (almost) the exact same
> > > functionality as FAN_PRE_ACCESS without range info.
> > >
> > > But in order to get the FAN_ACCESS_PERM events on directories
> > > listener would also be forced to get FAN_ACCESS_PERM on
> > > special files and regular files
> > > and assuming that this user is an HSM, it cannot request
> > > FAN_ACCESS_PERM|FAN_ONDIR in the same mask as
> > > FAN_PRE_ACCESS (which it needs for files) so it will need to
> > > open another group for populating directories.
> > >
> > > So that's why I would maybe consider this a last minute fix to the new API.
> >
> > Yeah, this would be really a desperate way to get the functionality :)
> 
> Indeed :)
> 
> Thanks,
> Amir.
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

