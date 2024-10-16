Return-Path: <linux-fsdevel+bounces-32127-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DAC29A0F03
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 17:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CA7928208E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 15:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A102144B7;
	Wed, 16 Oct 2024 15:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="s0vbyJlT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RdgoZ7c8";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cr8kz+HZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VYQ14aTs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A88212F0B
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Oct 2024 15:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729093739; cv=none; b=GLaXOMfkhlmzrRYikw09e0pVhHoceYuUsLNp7S3etcKQvUDZNxz9Snf1kDHianrXPZVxqCVKLpr2vBoHUZgOQkl0Qwa2fpiavspdkMTFBUs6QnJO0oMjYO2n/Y/d1ERDnLR9104p8U9bd0dDpURJRr9b9xB8mEIApHRldaKdERc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729093739; c=relaxed/simple;
	bh=CLIqKG8skOoSCfJsWz4gMjOjmsG4mYLcEI4PQlSpmrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AZ5XjzzTqZGCaG29yRauKqp42RWISZ+YHzEZL0ZLqAm+GghdSKlp4DwwlE1r/s4Vim1p8dDMow+DqzHo+TjU/A2F/k7DAOaVSrLsWHV9AVsWYHQlZPsmnlvaK0KgkH6uX3ubvHWt+LXSr1Pi8tws5/rBcO7sxZGRPM9lryqKiAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=s0vbyJlT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RdgoZ7c8; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cr8kz+HZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VYQ14aTs; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CCAFB1F897;
	Wed, 16 Oct 2024 15:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729093734; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jThc0USLAIQiVOUPgKtrpQG9qtGd8dJ9FkpTbOlBW4Y=;
	b=s0vbyJlTSfPVbqDJHEHnQbG+Y++WiCLvVqydKmyYfqRWBGnv7IJEYKxJaKVzk69nF3xSrB
	JvQopeAbto+rEY0Lw1uWeKP9Bspp8rBlO9Gq/IIHc9XOxzn3+b6PWBlgTftv9JmqaOpxw+
	5TnDDKobEsMGM5bfXrI6clexh0VJ8Tc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729093734;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jThc0USLAIQiVOUPgKtrpQG9qtGd8dJ9FkpTbOlBW4Y=;
	b=RdgoZ7c8CObvH9cMpFn6NiuTGFgTxo0M/hbqtdOxAnbLZ9Ov1VAu7VQqB49Ik+6N5rHIgj
	UcS2VdHUxOottEDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=cr8kz+HZ;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=VYQ14aTs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729093733; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jThc0USLAIQiVOUPgKtrpQG9qtGd8dJ9FkpTbOlBW4Y=;
	b=cr8kz+HZVFxp0lhouuBR0Rc390B/Bz1kNwCmxXBOslnBHmMOs+abykvyxXuwO53K2UE35g
	yshpiArDsp6vmJsxSZzt4yjKXDVLsgP155RLWYoH/yLh1fl9WaprxNAh5hdrvRggioIOAD
	2KdQNdE/FQgDD26CWIzXdKZzSwhssF4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729093733;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jThc0USLAIQiVOUPgKtrpQG9qtGd8dJ9FkpTbOlBW4Y=;
	b=VYQ14aTsmkKlAUHzR+fYKRxeRG1qOTMYw54eAb3aqGeHbnip+gQmQH3vXA4NBQf7hNQONX
	R1UNfyUBhRgq8XCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BB5EB1376C;
	Wed, 16 Oct 2024 15:48:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3vFnLWXgD2eANwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 16 Oct 2024 15:48:53 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 50B56A083E; Wed, 16 Oct 2024 17:48:53 +0200 (CEST)
Date: Wed, 16 Oct 2024 17:48:53 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Krishna Vivek Vitta <kvitta@microsoft.com>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] fanotify: allow reporting errors on failure to open fd
Message-ID: <20241016154853.ndrdn6ldivww33px@quack3>
References: <20241003142922.111539-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="dvcmkqjy5ng5yqqr"
Content-Disposition: inline
In-Reply-To: <20241003142922.111539-1-amir73il@gmail.com>
X-Rspamd-Queue-Id: CCAFB1F897
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-patch];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCPT_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	HAS_ATTACHMENT(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO


--dvcmkqjy5ng5yqqr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Amir!

On Thu 03-10-24 16:29:22, Amir Goldstein wrote:
> When working in "fd mode", fanotify_read() needs to open an fd
> from a dentry to report event->fd to userspace.
> 
> Opening an fd from dentry can fail for several reasons.
> For example, when tasks are gone and we try to open their
> /proc files or we try to open a WRONLY file like in sysfs
> or when trying to open a file that was deleted on the
> remote network server.
> 
> Add a new flag FAN_REPORT_FD_ERROR for fanotify_init().
> For a group with FAN_REPORT_FD_ERROR, we will send the
> event with the error instead of the open fd, otherwise
> userspace may not get the error at all.
> 
> The FAN_REPORT_FD_ERROR flag is not allowed for groups in "fid mode"
> which do not use open fd's as the object identifier.
> 
> For ean overflow event, we report -EBADF to avoid confusing FAN_NOFD
> with -EPERM.  Similarly for pidfd open errors we report either -ESRCH
> or the open error instead of FAN_NOPIDFD and FAN_EPIDFD.
> 
> In any case, userspace will not know which file failed to
> open, so add a debug print for further investigation.
> 
> Reported-by: Krishna Vivek Vitta <kvitta@microsoft.com>
> Closes: https://lore.kernel.org/linux-fsdevel/SI2P153MB07182F3424619EDDD1F393EED46D2@SI2P153MB0718.APCP153.PROD.OUTLOOK.COM/
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

I was mulling over this becase I wasn't quite happy with the result but I
could not clearly formulate my problems with the patch. So I've just sat
down and played with the code. Attached is what I've ended up with - please
have a look if it looks OK to you as well, it passes the LTP test you've
created. Functionally, I've just removed the check that FAN_REPORT_FD_ERROR
cannot be used in "fid mode" because when we decided to use the flag for
pidfd, it makes sense to combine it with "fid mode". I've also moved
EOPENSTALE special handling to a more logical place now.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

--dvcmkqjy5ng5yqqr
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-fanotify-allow-reporting-errors-on-failure-to-open-f.patch"

From 960eaeb25284913e808fe2271a989553b726d4aa Mon Sep 17 00:00:00 2001
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 3 Oct 2024 16:29:22 +0200
Subject: [PATCH] fanotify: allow reporting errors on failure to open fd

When working in "fd mode", fanotify_read() needs to open an fd
from a dentry to report event->fd to userspace.

Opening an fd from dentry can fail for several reasons.
For example, when tasks are gone and we try to open their
/proc files or we try to open a WRONLY file like in sysfs
or when trying to open a file that was deleted on the
remote network server.

Add a new flag FAN_REPORT_FD_ERROR for fanotify_init().
For a group with FAN_REPORT_FD_ERROR, we will send the
event with the error instead of the open fd, otherwise
userspace may not get the error at all.

For an overflow event, we report -EBADF to avoid confusing FAN_NOFD
with -EPERM.  Similarly for pidfd open errors we report either -ESRCH
or the open error instead of FAN_NOPIDFD and FAN_EPIDFD.

In any case, userspace will not know which file failed to
open, so add a debug print for further investigation.

Reported-by: Krishna Vivek Vitta <kvitta@microsoft.com>
Closes: https://lore.kernel.org/linux-fsdevel/SI2P153MB07182F3424619EDDD1F393EED46D2@SI2P153MB0718.APCP153.PROD.OUTLOOK.COM/
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Link: https://patch.msgid.link/20241003142922.111539-1-amir73il@gmail.com
---
 fs/notify/fanotify/fanotify_user.c | 85 +++++++++++++++++-------------
 include/linux/fanotify.h           |  1 +
 include/uapi/linux/fanotify.h      |  1 +
 3 files changed, 50 insertions(+), 37 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 9644bc72e457..8e2d43fc6f7c 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -266,13 +266,6 @@ static int create_fd(struct fsnotify_group *group, const struct path *path,
 			       group->fanotify_data.f_flags | __FMODE_NONOTIFY,
 			       current_cred());
 	if (IS_ERR(new_file)) {
-		/*
-		 * we still send an event even if we can't open the file.  this
-		 * can happen when say tasks are gone and we try to open their
-		 * /proc files or we try to open a WRONLY file like in sysfs
-		 * we just send the errno to userspace since there isn't much
-		 * else we can do.
-		 */
 		put_unused_fd(client_fd);
 		client_fd = PTR_ERR(new_file);
 	} else {
@@ -663,7 +656,7 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
 	unsigned int info_mode = FAN_GROUP_FLAG(group, FANOTIFY_INFO_MODES);
 	unsigned int pidfd_mode = info_mode & FAN_REPORT_PIDFD;
 	struct file *f = NULL, *pidfd_file = NULL;
-	int ret, pidfd = FAN_NOPIDFD, fd = FAN_NOFD;
+	int ret, pidfd = -ESRCH, fd = -EBADF;
 
 	pr_debug("%s: group=%p event=%p\n", __func__, group, event);
 
@@ -691,10 +684,39 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
 	if (!FAN_GROUP_FLAG(group, FANOTIFY_UNPRIV) &&
 	    path && path->mnt && path->dentry) {
 		fd = create_fd(group, path, &f);
-		if (fd < 0)
-			return fd;
+		/*
+		 * Opening an fd from dentry can fail for several reasons.
+		 * For example, when tasks are gone and we try to open their
+		 * /proc files or we try to open a WRONLY file like in sysfs
+		 * or when trying to open a file that was deleted on the
+		 * remote network server.
+		 *
+		 * For a group with FAN_REPORT_FD_ERROR, we will send the
+		 * event with the error instead of the open fd, otherwise
+		 * Userspace may not get the error at all.
+		 * In any case, userspace will not know which file failed to
+		 * open, so add a debug print for further investigation.
+		 */
+		if (fd < 0) {
+			pr_debug("fanotify: create_fd(%pd2) failed err=%d\n",
+				 path->dentry, fd);
+			if (!FAN_GROUP_FLAG(group, FAN_REPORT_FD_ERROR)) {
+				/*
+				 * Historically, we've handled EOPENSTALE in a
+				 * special way and silently dropped such
+				 * events. Now we have to keep it to maintain
+				 * backward compatibility...
+				 */
+				if (fd == -EOPENSTALE)
+					fd = 0;
+				return fd;
+			}
+		}
 	}
-	metadata.fd = fd;
+	if (FAN_GROUP_FLAG(group, FAN_REPORT_FD_ERROR))
+		metadata.fd = fd;
+	else
+		metadata.fd = fd >= 0 ? fd : FAN_NOFD;
 
 	if (pidfd_mode) {
 		/*
@@ -709,18 +731,16 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
 		 * The PIDTYPE_TGID check for an event->pid is performed
 		 * preemptively in an attempt to catch out cases where the event
 		 * listener reads events after the event generating process has
-		 * already terminated. Report FAN_NOPIDFD to the event listener
-		 * in those cases, with all other pidfd creation errors being
-		 * reported as FAN_EPIDFD.
+		 * already terminated.  Depending on flag FAN_REPORT_FD_ERROR,
+		 * report either -ESRCH or FAN_NOPIDFD to the event listener in
+		 * those cases with all other pidfd creation errors reported as
+		 * the error code itself or as FAN_EPIDFD.
 		 */
-		if (metadata.pid == 0 ||
-		    !pid_has_task(event->pid, PIDTYPE_TGID)) {
-			pidfd = FAN_NOPIDFD;
-		} else {
+		if (metadata.pid && pid_has_task(event->pid, PIDTYPE_TGID))
 			pidfd = pidfd_prepare(event->pid, 0, &pidfd_file);
-			if (pidfd < 0)
-				pidfd = FAN_EPIDFD;
-		}
+
+		if (!FAN_GROUP_FLAG(group, FAN_REPORT_FD_ERROR) && pidfd < 0)
+			pidfd = pidfd == -ESRCH ? FAN_NOPIDFD : FAN_EPIDFD;
 	}
 
 	ret = -EFAULT;
@@ -737,9 +757,6 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
 	buf += FAN_EVENT_METADATA_LEN;
 	count -= FAN_EVENT_METADATA_LEN;
 
-	if (fanotify_is_perm_event(event->mask))
-		FANOTIFY_PERM(event)->fd = fd;
-
 	if (info_mode) {
 		ret = copy_info_records_to_user(event, info, info_mode, pidfd,
 						buf, count);
@@ -753,15 +770,18 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
 	if (pidfd_file)
 		fd_install(pidfd, pidfd_file);
 
+	if (fanotify_is_perm_event(event->mask))
+		FANOTIFY_PERM(event)->fd = fd;
+
 	return metadata.event_len;
 
 out_close_fd:
-	if (fd != FAN_NOFD) {
+	if (f) {
 		put_unused_fd(fd);
 		fput(f);
 	}
 
-	if (pidfd >= 0) {
+	if (pidfd_file) {
 		put_unused_fd(pidfd);
 		fput(pidfd_file);
 	}
@@ -828,15 +848,6 @@ static ssize_t fanotify_read(struct file *file, char __user *buf,
 		}
 
 		ret = copy_event_to_user(group, event, buf, count);
-		if (unlikely(ret == -EOPENSTALE)) {
-			/*
-			 * We cannot report events with stale fd so drop it.
-			 * Setting ret to 0 will continue the event loop and
-			 * do the right thing if there are no more events to
-			 * read (i.e. return bytes read, -EAGAIN or wait).
-			 */
-			ret = 0;
-		}
 
 		/*
 		 * Permission events get queued to wait for response.  Other
@@ -845,7 +856,7 @@ static ssize_t fanotify_read(struct file *file, char __user *buf,
 		if (!fanotify_is_perm_event(event->mask)) {
 			fsnotify_destroy_event(group, &event->fse);
 		} else {
-			if (ret <= 0) {
+			if (ret <= 0 || FANOTIFY_PERM(event)->fd < 0) {
 				spin_lock(&group->notification_lock);
 				finish_permission_event(group,
 					FANOTIFY_PERM(event), FAN_DENY, NULL);
@@ -1954,7 +1965,7 @@ static int __init fanotify_user_setup(void)
 				     FANOTIFY_DEFAULT_MAX_USER_MARKS);
 
 	BUILD_BUG_ON(FANOTIFY_INIT_FLAGS & FANOTIFY_INTERNAL_GROUP_FLAGS);
-	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_INIT_FLAGS) != 12);
+	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_INIT_FLAGS) != 13);
 	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_MARK_FLAGS) != 11);
 
 	fanotify_mark_cache = KMEM_CACHE(fanotify_mark,
diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
index 4f1c4f603118..89ff45bd6f01 100644
--- a/include/linux/fanotify.h
+++ b/include/linux/fanotify.h
@@ -36,6 +36,7 @@
 #define FANOTIFY_ADMIN_INIT_FLAGS	(FANOTIFY_PERM_CLASSES | \
 					 FAN_REPORT_TID | \
 					 FAN_REPORT_PIDFD | \
+					 FAN_REPORT_FD_ERROR | \
 					 FAN_UNLIMITED_QUEUE | \
 					 FAN_UNLIMITED_MARKS)
 
diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
index a37de58ca571..34f221d3a1b9 100644
--- a/include/uapi/linux/fanotify.h
+++ b/include/uapi/linux/fanotify.h
@@ -60,6 +60,7 @@
 #define FAN_REPORT_DIR_FID	0x00000400	/* Report unique directory id */
 #define FAN_REPORT_NAME		0x00000800	/* Report events with name */
 #define FAN_REPORT_TARGET_FID	0x00001000	/* Report dirent target id  */
+#define FAN_REPORT_FD_ERROR	0x00002000	/* event->fd can report error */
 
 /* Convenience macro - FAN_REPORT_NAME requires FAN_REPORT_DIR_FID */
 #define FAN_REPORT_DFID_NAME	(FAN_REPORT_DIR_FID | FAN_REPORT_NAME)
-- 
2.35.3


--dvcmkqjy5ng5yqqr--

