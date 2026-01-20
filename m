Return-Path: <linux-fsdevel+bounces-74602-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJYmL4d4cGktYAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74602-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 07:56:07 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E66152701
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 07:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E3D9072A927
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 10:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1020E3DA7FD;
	Tue, 20 Jan 2026 10:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qFx2ktvy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E253A641C
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 10:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768904054; cv=none; b=VYaaHttsWhVlPvf6iFM06ZKoSCwpVvKOBy2RtqHmrsgSMWAS0wYQEbcPUodYPNzXtjHmR50F6nwFIj0bvoQwuUqe4b3sBSE5lF1d46rdvLRLLK2nyfOempEA7T5vjJFt5GsjyUhh/BEJsvmINxG2kjdgB7aoJfwwiZbgr5sQJwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768904054; c=relaxed/simple;
	bh=qWZ7S/LqqzQrILRSGe7jvYeRnlVWzQ1TQGZpVtDsKi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XeRK6fbRTeSlmBSQBkSt1itWNJyGCVZ8VARwzj++E8lKHv5NCrJLuWsbCe/Ok1GskrD/uZPzQgWGbh2zBMb7cX06hF8XQ4wLC+yp+ouxAqdKou+kMcjC6FJxSRocoON4DvuOZgW4ff36ol5hw9QQtCLgv6/xyLCXmhAWNoG+VKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qFx2ktvy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17338C19423;
	Tue, 20 Jan 2026 10:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768904054;
	bh=qWZ7S/LqqzQrILRSGe7jvYeRnlVWzQ1TQGZpVtDsKi4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qFx2ktvy47fvTNZH9EFc1t0kzsHdEP5trsC1ah4YpZrc8XmsmIORraP386Aw2oFFn
	 64uB7DcjLNJL7CaNS7J49QOzXGBqoov1Yz7Bjo80QdzUk57mJ5O2nC+7JRuBlcignV
	 T6lE8LEtaYWTalpccs6gdmTIF/UmIqWFCiLrne45oUIv9SmS3LTLa2PHP/WqX9iyha
	 PMCAjCW8UZ//YeWIIRQgCaTDTLCtox0HxqfU6NUf+crBY+Ey94SEI5+Q8rl1rTrQNQ
	 9iV1Sr4UNi6Lz4G0eWA42vefPgOMODf/T1SBK5uotQ21Xq6TSPbeRUdPUxxyfg688V
	 gGvoitbLCiyTg==
Date: Tue, 20 Jan 2026 11:14:09 +0100
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC] pidfs: convert rb-tree to rhashtable
Message-ID: <20260120-abladen-batterie-40fe1a4652be@brauner>
References: <20260119-work-pidfs-rhashtable-v1-1-159c7700300a@kernel.org>
 <CAGudoHEej7_Q-nkJqBU8Md15ESVtyxZ9Wbq9zwyUEcfT034=xg@mail.gmail.com>
 <20260120-teilhaben-kruste-b947256ed6ab@brauner>
 <CAGudoHEGUDaToxwhsFHT1vB7Q66-H2UMNpX8KTj-dcEZy4Hz3g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHEGUDaToxwhsFHT1vB7Q66-H2UMNpX8KTj-dcEZy4Hz3g@mail.gmail.com>
X-Spamd-Result: default: False [2.54 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-74602-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 5E66152701
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 10:56:40AM +0100, Mateusz Guzik wrote:
> On Tue, Jan 20, 2026 at 9:17 AM Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Mon, Jan 19, 2026 at 09:51:30PM +0100, Mateusz Guzik wrote:
> > > Longer term someone(tm) will need to implement lockless alloc_pid (in
> > > the fast path anyway).
> > >
> > > In order to facilitate that the pidfs thing needs to get its own
> > > synchronisation. To my understanding rhashtable covers its own locking
> > > just fine, so the thing left to handle is ino allocation.
> >
> > I'm very confused why inode allocation would matter. Inode allocation
> > for pidfs is literally just a plain increment. IOW, it's not using any
> > atomic at all. So that can happen under pidmap_lock without any issue
> > and I don't see the need to change to any complex per-cpu allocation
> > mechanism for this.
> 
> I am not saying this bit poses a problem as is. I am saying down the
> road pid allocation will need to be reworked to operate locklessly (or
> worst case with fine-grained locking) in which case the the pid ino
> thing wont be able to rely on the pidmap lock.
> 
> It is easy to sort out as is, so I think it should be sorted out while
> pidfs support is being patched.

I don't have time for that but I will move pidfs out of pidmap_lock
completely.

> The nice practical thing about unique 64 bit ids is that you can
> afford to not free them when no longer used as it is considered
> unrealistic for the counter to overflow in the lifetime of the box.

I'm still confused what this has to do with pidfd inodes.

> 
> Making it scalable is a well known problem with simple approaches and
> the kernel is already doing something of the sort for 32-bit inos in
> get_next_ino(). If anything I'm surprised the kernel does not provide

include/linux/cookie.h

is what you want.

> a generic mechanism for 64 bits (at least I failed to find out and
> when I asked around people could not point me at one either). Getting
> this done for 64 bit is a matter of implementing a nearly identical
> routine, except with 64-bit types and with overflow check removed.
> 
> However, the real compliant about this patch is the re-introduced
> double acquire of pidmap_lock.

That's easy to sort out:

 fs/pidfs.c   |  4 +++-
 kernel/pid.c | 13 ++++++-------
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index e97931249ba2..ccfab23451b1 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -138,6 +138,7 @@ void pidfs_prepare_pid(struct pid *pid)
 		pidfs_ino_nr += 2;
 
 	pid->ino = pidfs_ino_nr;
+	pid->pidfs_hash.next = NULL;
 	pid->stashed = NULL;
 	pid->attr = NULL;
 	pidfs_ino_nr++;
@@ -145,7 +146,8 @@ void pidfs_prepare_pid(struct pid *pid)
 
 /*
  * Insert pid into the pidfs hashtable.
+ * @pid: pid to add
+ *
  * Returns 0 on success, negative error on failure.
  */
 int pidfs_add_pid(struct pid *pid)
diff --git a/kernel/pid.c b/kernel/pid.c
index 7da2c3e8f79c..e68700de3339 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -313,14 +313,9 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t *arg_set_tid,
 	retval = -ENOMEM;
 	if (unlikely(!(ns->pid_allocated & PIDNS_ADDING)))
 		goto out_free;
-	pidfs_prepare_pid(pid);
-	spin_unlock(&pidmap_lock);
 
-	retval = pidfs_add_pid(pid);
-	if (retval)
-		goto out_free_idr;
+	pidfs_prepare_pid(pid);
 
-	spin_lock(&pidmap_lock);
 	for (upid = pid->numbers + ns->level; upid >= pid->numbers; --upid) {
 		/* Make the PID visible to find_pid_ns. */
 		idr_replace(&upid->ns->idr, pid, upid->nr);
@@ -330,11 +325,15 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t *arg_set_tid,
 	idr_preload_end();
 	ns_ref_active_get(ns);
 
+	if (pidfs_add_pid(pid)) {
+		free_pid(pid);
+		pid = ERR_PTR(-ENOMEM);
+	}
+
 	return pid;
 
 out_free:
 	spin_unlock(&pidmap_lock);
-out_free_idr:
 	idr_preload_end();
 
 	spin_lock(&pidmap_lock);

