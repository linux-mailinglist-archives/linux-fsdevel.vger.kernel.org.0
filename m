Return-Path: <linux-fsdevel+bounces-53677-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47327AF5E4E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 18:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65E531C43E78
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 16:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A832DFF28;
	Wed,  2 Jul 2025 16:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mpi57Mph";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="96uoT3Jw";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mpi57Mph";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="96uoT3Jw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4A73196C6
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Jul 2025 16:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751472961; cv=none; b=ub+ISIY1uw5aXmOXuantGxgnGa5t9cMPBkPEWPgHiiUyySw+H5Idnvt/TKXxwJ2Mbjfd0+YS+5vsGZkPt7CLH2Sc5PQ8XDFC4hahIhaGUNqAd3xDqK1IWMLMwFA8rkidpJu9d73Wzq/okb5x661ljkdynF4wXTsH3vL9Ak1/lmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751472961; c=relaxed/simple;
	bh=5hJKEcePJJ9SjDW0ol5MwB0YT6MIzbMjVecSBCiYr6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tmHP3yG45J2KSjGUrWyG0LCV+2ttyQEgyi9xZoc2C4DXDeNNoHh3mXXj1KtAdaSLGmtsn7Y2jfTn1ehu6hPA4tQA3gLhcgH8bkBfcrpFKhSjY40YwyKsrZY147zMPWX/GXUxsTBQ93NGiuAOKhfXpbc+NTHYbTKJmA5/c4BbvMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mpi57Mph; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=96uoT3Jw; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mpi57Mph; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=96uoT3Jw; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 93ABE21193;
	Wed,  2 Jul 2025 16:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751472956; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BkrIx2X9xhRPOYb3GYmyN65ECyDuO0Iw9QJ0WfI1zKg=;
	b=mpi57Mphz03klW5khJ1cTMQUTDElrjupJ/5wdl1JHG8GuMXwWUAAfwyeM0ZQY3x5OA5wUK
	G79p40MMWrJe4n4B66Cr9bKz9CL+C4p21Hrh2tffc83nFn4daK3zlmJCTU6W6/WmbBYeMN
	oud63wl5DdQuDY5hgGBhxn4CeA57Q+0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751472956;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BkrIx2X9xhRPOYb3GYmyN65ECyDuO0Iw9QJ0WfI1zKg=;
	b=96uoT3Jwd7If/seV5buSEOpD/t3nfA1niRYOCf86Vqx/2qvX4jb9nAibJwDKNdzcW02EQH
	yRPEIM6mjYwADQCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=mpi57Mph;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=96uoT3Jw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751472956; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BkrIx2X9xhRPOYb3GYmyN65ECyDuO0Iw9QJ0WfI1zKg=;
	b=mpi57Mphz03klW5khJ1cTMQUTDElrjupJ/5wdl1JHG8GuMXwWUAAfwyeM0ZQY3x5OA5wUK
	G79p40MMWrJe4n4B66Cr9bKz9CL+C4p21Hrh2tffc83nFn4daK3zlmJCTU6W6/WmbBYeMN
	oud63wl5DdQuDY5hgGBhxn4CeA57Q+0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751472956;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BkrIx2X9xhRPOYb3GYmyN65ECyDuO0Iw9QJ0WfI1zKg=;
	b=96uoT3Jwd7If/seV5buSEOpD/t3nfA1niRYOCf86Vqx/2qvX4jb9nAibJwDKNdzcW02EQH
	yRPEIM6mjYwADQCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B58EF13A24;
	Wed,  2 Jul 2025 16:15:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0gdMLDtbZWjLZwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 02 Jul 2025 16:15:55 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 49F3AA0A55; Wed,  2 Jul 2025 18:15:49 +0200 (CEST)
Date: Wed, 2 Jul 2025 18:15:49 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Ibrahim Jirdeh <ibrahimjirdeh@meta.com>, 
	josef@toxicpanda.com, lesha@meta.com, linux-fsdevel@vger.kernel.org, sargun@meta.com
Subject: Re: [PATCH] fanotify: support custom default close response
Message-ID: <2ogjwnem7o3jwukzoq2ywnxha5ljiqnjnr4o4b5xvdvwpbyeac@v4i7jygvk7fj>
References: <20250623192503.2673076-1-ibrahimjirdeh@meta.com>
 <CAOQ4uxguBgMuUZqs0bT_cDyEX6465YkQkUHFPFE4tndys-y2Wg@mail.gmail.com>
 <tq6g6bkzojggcwu3bxkj57ongbvyynykylrtmlphqa7g7wb6f2@7gid5uogbfc4>
 <CAOQ4uxirFm8_U7z4ke5Z4iNbatSbXoz1YK_2eGL=1JQQOtt75Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="h4lryuyboajgja5h"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxirFm8_U7z4ke5Z4iNbatSbXoz1YK_2eGL=1JQQOtt75Q@mail.gmail.com>
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 93ABE21193
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-patch];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,meta.com:email,suse.cz:dkim,suse.cz:email,suse.com:email]
X-Spam-Score: -4.01
X-Spam-Level: 


--h4lryuyboajgja5h
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon 30-06-25 17:56:00, Amir Goldstein wrote:
> On Mon, Jun 30, 2025 at 5:36 PM Jan Kara <jack@suse.cz> wrote:
> > On Tue 24-06-25 08:30:03, Amir Goldstein wrote:
> > > On Mon, Jun 23, 2025 at 9:26 PM Ibrahim Jirdeh <ibrahimjirdeh@meta.com> wrote:
> > > >
> > > > Currently the default response for pending events is FAN_ALLOW.
> > > > This makes default close response configurable. The main goal
> > > > of these changes would be to provide better handling for pending
> > > > events for lazy file loading use cases which may back fanotify
> > > > events by a long-lived daemon. For earlier discussion see:
> > > > https://lore.kernel.org/linux-fsdevel/6za2mngeqslmqjg3icoubz37hbbxi6bi44canfsg2aajgkialt@c3ujlrjzkppr/
> > >
> > > These lore links are typically placed at the commit message tail block
> > > if related to a suggestion you would typically use:
> > >
> > > Suggested-by: Amir Goldstein <amir73il@gmail.com>
> > > Link: https://lore.kernel.org/linux-fsdevel/CAOQ4uxi6PvAcT1vL0d0e+7YjvkfU-kwFVVMAN-tc-FKXe1wtSg@mail.gmail.com/
> > > Signed-off-by: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>
> > >
> > > This way reviewers whose response is "what a terrible idea!" can
> > > point their arrows at me instead of you ;)
> > >
> > > Note that this is a more accurate link to the message where the default
> > > response API was proposed, so readers won't need to sift through
> > > this long thread to find the reference.
> >
> > I've reread that thread to remember how this is supposed to be used. After
> > thinking about it now maybe we could just modify how pending fanotify
> > events behave in case of group destruction? Instead of setting FAN_ALLOW in
> > fanotify_release() we'd set a special event state that will make fanotify
> > group iteration code bubble up back to fsnotify() and restart the event
> > generation loop there?
> >
> > In the usual case this would behave the same way as setting FAN_ALLOW (just
> > in case of multiple permission event watchers some will get the event two
> > times which shouldn't matter). In case of careful design with fd store
> > etc., the daemon can setup the new notification group as needed and then
> > close the fd from the old notification group at which point it would
> > receive all the pending events in the new group. I can even see us adding
> > ioctl to the fanotify group which when called will result in the same
> > behavior (i.e., all pending permission events will get the "retry"
> > response). That way the new daemon could just take the old fd from the fd
> > store and call this ioctl to receive all the pending events again.
> >
> > No need for the new default response. We probably need to provide a group
> > feature flag for this so that userspace can safely query kernel support for
> > this behavior but otherwise even that wouldn't be really needed.
> >
> > What do you guys think?
> 
> With proper handover I am not sure why this is needed, because:
> - new group gets fd from store and signals old group
> - old group does not take any new event, completes in-flight events,
>   signals back new group and exists
> - new group starts processing events
> - so why do we need a complex mechanism in kernel to do what can easily
>   be done in usersapce?

This works for clean handover (say service update) - no need for any
mechanism (neither retry nor default response there). We are in agreement
here. If retry is supported, it will make the handover somewhat simpler for
userspace but that's not really substantial.

> Also, regardless I think that we need the default response, because:
> - groups starts, set default response to DENY and handsover fd to store
> - if group crashes unexpectedly, access to all files is denied, which is
>   exactly what we needed to do with the "moderated" mount
> - it is similar to access to FUSE mount when server is down

Yes, crashes are what I had in mind. With crashes you have nobody to
cleanly handle events still pending for the old group and you have to solve
it. Reporting FAN_DENY (through default response) is one way, what I
suggest with retry has the advantage that userspace doesn't have to deal
with spurious FAN_DENY errors in case of daemon crash. It is not a huge
benefit (crashes should better be rare ;)) but it is IMO a benefit.

Now regarding your comment about moderated mount: You are somewhat terse on
details so let me try to fill in. First let's differentiate between service
(daemon) and the notification group because they may have a different
lifetime. So the service starts, creates a notification group, places mark
on the sb with pre-content events. You didn't mention a mark in your
description but until the mark is set, the group receives no events so
there's nothing to respond to. Now if the service crashes there are two
options:

1) You didn't save your group fd anywhere. In that case the group and mark
is gone with the crash of the service, all accesses happening after this
moment are allowed => not good. Whether we have default response or not
doesn't really matter in this case for those few events that were possibly
pending. Agreed so far?

2) You've saved group fd to fd store. In this case the group is (from
kernel POV) fully alive even after the service crash and the default
response does not activate. The events will be queued to the group and
waiting for reply. No access to the fs is allowed to happen which is good.
Eventually the new service starts and we are in the situation I describe 3
paragraphs above about handling pending events.

So if we'd implement resending of pending events after group closure, I
don't see how default response (at least in its current form) would be
useful for anything.

Why I like the proposal of resending pending events:
a) No spurious FAN_DENY errors in case of service crash
b) No need for new concept (and API) for default response, just a feature
   flag.
c) With additional ioctl to trigger resending pending events without group
   closure, the newly started service can simply reuse the
   same notification group (even in case of old service crash) thus
   inheriting all placed marks (which is something Ibrahim would like to
   have).

Regarding complexity of the approach I propose the attached (untested)
patch should implement it and I don't think it is very complex logic...
So what do you think now? :)

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

--h4lryuyboajgja5h
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-fanotify-Add-support-for-resending-unanswered-permis.patch"

From 5cc27dfbe7be415299d21ac56d38f55014a36a1f Mon Sep 17 00:00:00 2001
From: Jan Kara <jack@suse.cz>
Date: Wed, 2 Jul 2025 18:06:13 +0200
Subject: [PATCH] fanotify: Add support for resending unanswered permission
 events

For handling of a crash of HSM service daemon, we need to somehow handle
permission events which were already reported but not yet answered. We
cannot just allow them as that will let the application access
unpopulated content. Add support for resending these events on group
shutdown. The intended use is that the HSM service will store fd
pointing to its notification group info fd store so the notification
group survives service crash. The newly started service can setup
necessary watches and then destroy the old notification group at which
point it will receive all the events pending against the old group.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/notify/fanotify/fanotify.c      |  8 +++++++-
 fs/notify/fanotify/fanotify.h      |  1 +
 fs/notify/fanotify/fanotify_user.c | 13 ++++++++++---
 fs/notify/fsnotify.c               |  7 +++++++
 include/uapi/linux/fanotify.h      |  1 +
 5 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 3083643b864b..3e2a09946603 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -230,7 +230,8 @@ static int fanotify_get_response(struct fsnotify_group *group,
 	pr_debug("%s: group=%p event=%p\n", __func__, group, event);
 
 	ret = wait_event_state(group->fanotify_data.access_waitq,
-				  event->state == FAN_EVENT_ANSWERED,
+				  event->state == FAN_EVENT_ANSWERED ||
+				    event->state == FAN_EVENT_RETRY,
 				  (TASK_KILLABLE|TASK_FREEZABLE));
 
 	/* Signal pending? */
@@ -258,6 +259,11 @@ static int fanotify_get_response(struct fsnotify_group *group,
 		goto out;
 	}
 
+	if (event->state == FAN_EVENT_RETRY) {
+		ret = -ERESTART;
+		goto out;
+	}
+
 	/* userspace responded, convert to something usable */
 	switch (event->response & FANOTIFY_RESPONSE_ACCESS) {
 	case FAN_ALLOW:
diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
index b78308975082..ff96a5feae92 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -17,6 +17,7 @@ enum {
 	FAN_EVENT_REPORTED,
 	FAN_EVENT_ANSWERED,
 	FAN_EVENT_CANCELED,
+	FAN_EVENT_RETRY,
 };
 
 /*
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index b192ee068a7a..40922c4c7049 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -318,7 +318,10 @@ static void finish_permission_event(struct fsnotify_group *group,
 	if (event->state == FAN_EVENT_CANCELED)
 		destroy = true;
 	else
-		event->state = FAN_EVENT_ANSWERED;
+		if (response)
+			event->state = FAN_EVENT_ANSWERED;
+		else
+			event->state = FAN_EVENT_RETRY;
 	spin_unlock(&group->notification_lock);
 	if (destroy)
 		fsnotify_destroy_event(group, &event->fae.fse);
@@ -1004,6 +1007,10 @@ static int fanotify_release(struct inode *ignored, struct file *file)
 {
 	struct fsnotify_group *group = file->private_data;
 	struct fsnotify_event *fsn_event;
+	u32 default_response = FAN_ALLOW;
+
+	if (FAN_GROUP_FLAG(group, FAN_RETRY_UNANSWERED))
+		default_response = 0;
 
 	/*
 	 * Stop new events from arriving in the notification queue. since
@@ -1023,7 +1030,7 @@ static int fanotify_release(struct inode *ignored, struct file *file)
 		event = list_first_entry(&group->fanotify_data.access_list,
 				struct fanotify_perm_event, fae.fse.list);
 		list_del_init(&event->fae.fse.list);
-		finish_permission_event(group, event, FAN_ALLOW, NULL);
+		finish_permission_event(group, event, default_response, NULL);
 		spin_lock(&group->notification_lock);
 	}
 
@@ -1040,7 +1047,7 @@ static int fanotify_release(struct inode *ignored, struct file *file)
 			fsnotify_destroy_event(group, fsn_event);
 		} else {
 			finish_permission_event(group, FANOTIFY_PERM(event),
-						FAN_ALLOW, NULL);
+						default_response, NULL);
 		}
 		spin_lock(&group->notification_lock);
 	}
diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index e2b4f17a48bb..b0eb86124e32 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -588,6 +588,7 @@ int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
 	    (!mnt_data || !mnt_data->ns->n_fsnotify_marks))
 		return 0;
 
+resend:
 	if (sb)
 		marks_mask |= READ_ONCE(sb->s_fsnotify_mask);
 	if (mnt)
@@ -649,6 +650,12 @@ int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
 	ret = 0;
 out:
 	srcu_read_unlock(&fsnotify_mark_srcu, iter_info.srcu_idx);
+	/*
+	 * Resend permission event in case some group got shutdown before it
+	 * could answer
+	 */
+	if (ret == -ERESTART)
+		goto resend;
 
 	return ret;
 }
diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
index e710967c7c26..4eb2313dbcf0 100644
--- a/include/uapi/linux/fanotify.h
+++ b/include/uapi/linux/fanotify.h
@@ -57,6 +57,7 @@
 #define FAN_UNLIMITED_QUEUE	0x00000010
 #define FAN_UNLIMITED_MARKS	0x00000020
 #define FAN_ENABLE_AUDIT	0x00000040
+#define FAN_RETRY_UNANSWERED	0x00008000
 
 /* Flags to determine fanotify event format */
 #define FAN_REPORT_PIDFD	0x00000080	/* Report pidfd for event->pid */
-- 
2.43.0


--h4lryuyboajgja5h--

