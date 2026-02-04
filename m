Return-Path: <linux-fsdevel+bounces-76323-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CBD3LF5ag2mJlQMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76323-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 15:40:30 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 12DCDE73B2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 15:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1EF6E300DE1E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Feb 2026 14:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5339241B34A;
	Wed,  4 Feb 2026 14:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HSJbgDTj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66B741324E;
	Wed,  4 Feb 2026 14:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770215997; cv=none; b=Ro/+izl6yj7ZZdIXM+Nq5olT4HUTMl610jiNWgS/KQHsUOljOKRmeWPH+y8rsmgogoioo7JAPAi+NjfWUhn3v0FFPXNVrg/99I+IaczNodNOypWMJkj35agW+dQnvIhksXgzjquDzfn9XwTNGkOPj7fSVMEpO2tE9BFihQhWiUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770215997; c=relaxed/simple;
	bh=FWl5fl8gapsvrBQQo7kmVJXbhs2eesvEehtBqwf++/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hH4OG9nqpx9ASZERxxqvHffuRRjZwahNpl3/G+oz1xVXKi1JU6Je9hoIXhFuyHHN1P6gLoZIyLFDgmfjWO55uacI/C8jURxBL204nBVjlYM1Illf1Asy6y70i2hb6XSiytKwrLg0gyY16UHl4OWzlEgHr4M8sOcqcdxY8wBvX28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HSJbgDTj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8901CC4CEF7;
	Wed,  4 Feb 2026 14:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770215997;
	bh=FWl5fl8gapsvrBQQo7kmVJXbhs2eesvEehtBqwf++/I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HSJbgDTjK9Sg7u9Ol5394rdcdJ23sIZBO7PfPbLz9FVMwOFUYMzLsrkBvl0xPINwz
	 6RHakcOqFMrE2uO1c04i/xJJ1m4otx1BzbBcKnJod2CQ6fclm5I3Z4aIMfN4iE8MTD
	 94I0uM8Ry7DHfdx/aDc2+VikCpyVkcbeO5lsQRzlRdlJ+aZ+VP3SD3RWeSwB1npDEZ
	 VsPAGhn042Dh6hRwXUcuBPeVZRXHSgq8k3fw0Bo/kwr0cQHG1cNey4IlXGJGUHkrZL
	 4hDpCuBBgZxNdd/1BHTU0RfaUltANO3U5UJ9B6kd1Siz+W7tO8l6MXZcbRmVPp4lzQ
	 c9s8BxPFip3Zg==
Date: Wed, 4 Feb 2026 15:39:53 +0100
From: Christian Brauner <brauner@kernel.org>
To: Alexey Gladkov <legion@kernel.org>
Cc: Dan Klishch <danilklishch@gmail.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, "Eric W . Biederman" <ebiederm@xmission.com>, 
	Kees Cook <keescook@chromium.org>, containers@lists.linux-foundation.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/5] proc: subset=pid: Show /proc/self/net only for
 CAP_NET_ADMIN
Message-ID: <20260204-bergung-abhilfe-073d732bc51f@brauner>
References: <20251213050639.735940-1-danilklishch@gmail.com>
 <cover.1768295900.git.legion@kernel.org>
 <e14856f2c5f4635ddf72de61ecc59851c131489c.1768295900.git.legion@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e14856f2c5f4635ddf72de61ecc59851c131489c.1768295900.git.legion@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76323-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,zeniv.linux.org.uk,xmission.com,chromium.org,lists.linux-foundation.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 12DCDE73B2
X-Rspamd-Action: no action

On Tue, Jan 13, 2026 at 10:20:34AM +0100, Alexey Gladkov wrote:
> Cache the mounters credentials and allow access to the net directories
> contingent of the permissions of the mounter of proc.
> 
> Do not show /proc/self/net when proc is mounted with subset=pid option
> and the mounter does not have CAP_NET_ADMIN.
> 
> Signed-off-by: Alexey Gladkov <legion@kernel.org>
> ---
>  fs/proc/proc_net.c      | 8 ++++++++
>  fs/proc/root.c          | 5 +++++
>  include/linux/proc_fs.h | 1 +
>  3 files changed, 14 insertions(+)
> 
> diff --git a/fs/proc/proc_net.c b/fs/proc/proc_net.c
> index 52f0b75cbce2..6e0ccef0169f 100644
> --- a/fs/proc/proc_net.c
> +++ b/fs/proc/proc_net.c
> @@ -23,6 +23,7 @@
>  #include <linux/uidgid.h>
>  #include <net/net_namespace.h>
>  #include <linux/seq_file.h>
> +#include <linux/security.h>
>  
>  #include "internal.h"
>  
> @@ -270,6 +271,7 @@ static struct net *get_proc_task_net(struct inode *dir)
>  	struct task_struct *task;
>  	struct nsproxy *ns;
>  	struct net *net = NULL;
> +	struct proc_fs_info *fs_info = proc_sb_info(dir->i_sb);
>  
>  	rcu_read_lock();
>  	task = pid_task(proc_pid(dir), PIDTYPE_PID);
> @@ -282,6 +284,12 @@ static struct net *get_proc_task_net(struct inode *dir)
>  	}
>  	rcu_read_unlock();
>  
> +	if (net && (fs_info->pidonly == PROC_PIDONLY_ON) &&
> +	    security_capable(fs_info->mounter_cred, net->user_ns, CAP_NET_ADMIN, CAP_OPT_NONE) < 0) {
> +		put_net(net);
> +		net = NULL;
> +	}
> +
>  	return net;
>  }
>  
> diff --git a/fs/proc/root.c b/fs/proc/root.c
> index d8ca41d823e4..ed8a101d09d3 100644
> --- a/fs/proc/root.c
> +++ b/fs/proc/root.c
> @@ -254,6 +254,7 @@ static int proc_fill_super(struct super_block *s, struct fs_context *fc)
>  		return -ENOMEM;
>  
>  	fs_info->pid_ns = get_pid_ns(ctx->pid_ns);
> +	fs_info->mounter_cred = get_cred(fc->cred);
>  	proc_apply_options(fs_info, fc, current_user_ns());
>  
>  	/* User space would break if executables or devices appear on proc */
> @@ -303,6 +304,9 @@ static int proc_reconfigure(struct fs_context *fc)
>  
>  	sync_filesystem(sb);
>  
> +	put_cred(fs_info->mounter_cred);
> +	fs_info->mounter_cred = get_cred(fc->cred);

Afaict, this races with get_proc_task_net(). You need a synchronization
mechanism here so that get_proc_task_net() doesn't risk accessing
invalid mounter creds while someone concurrently updates the creds.
Proposal how to fix that below.

But I'm kinda torn here anyway whether we want that credential change on
remount. The problem is that someone might inadvertently allow access to
/proc/<pid>/net as a side-effect simply because they remounted procfs.
But they never had a chance to prevent this.

I think it's best if mounter_creds stays fixed just as they do for
overlayfs. So we don't allow them to change on reconfigure. That also
makes all of the code I hinted at below pointless.

If we ever want to change the credentials it's easier to add a mount
option to procfs like I did for overlayfs.

_Untested_ patches:

First, the preparatory patch diff (no functional changes intended):

diff --git a/fs/proc/proc_net.c b/fs/proc/proc_net.c
index 52f0b75cbce2..81825e5819b8 100644
--- a/fs/proc/proc_net.c
+++ b/fs/proc/proc_net.c
@@ -268,19 +268,19 @@ EXPORT_SYMBOL_GPL(proc_create_net_single_write);
 static struct net *get_proc_task_net(struct inode *dir)
 {
        struct task_struct *task;
-       struct nsproxy *ns;
-       struct net *net = NULL;
+       struct net *net;

-       rcu_read_lock();
+       guard(rcu)();
        task = pid_task(proc_pid(dir), PIDTYPE_PID);
-       if (task != NULL) {
-               task_lock(task);
-               ns = task->nsproxy;
-               if (ns != NULL)
-                       net = get_net(ns->net_ns);
-               task_unlock(task);
+       if (!task)
+               return NULL;
+
+       scoped_guard(task_lock, task) {
+               struct nsproxy *ns = task->nsproxy;
+               if (!ns)
+                       return NULL;
+               net = get_net(ns->net_ns);
        }
-       rcu_read_unlock();

        return net;
 }

And then on top of it something like:

diff --git a/fs/proc/proc_net.c b/fs/proc/proc_net.c
index 81825e5819b8..47dc9806395c 100644
--- a/fs/proc/proc_net.c
+++ b/fs/proc/proc_net.c
@@ -269,6 +269,8 @@ static struct net *get_proc_task_net(struct inode *dir)
 {
        struct task_struct *task;
        struct net *net;
+       struct proc_fs_info *fs_info;
+       const struct cred *cred;

        guard(rcu)();
        task = pid_task(proc_pid(dir), PIDTYPE_PID);
@@ -282,6 +284,15 @@ static struct net *get_proc_task_net(struct inode *dir)
                net = get_net(ns->net_ns);
        }

+       fs_info = proc_sb_info(dir->i_sb);
+       if (fs_info->pidonly != PROC_PIDONLY_ON)
+               return net;
+
+       cred = rcu_dereference(fs_info->mounter_cred);
+       if (security_capable(cred, net->user_ns, CAP_NET_ADMIN, CAP_OPT_NONE) != 0) {
+               put_net(net);
+               return NULL;
+       }
        return net;
 }

diff --git a/fs/proc/root.c b/fs/proc/root.c
index d8ca41d823e4..68397900dab7 100644
--- a/fs/proc/root.c
+++ b/fs/proc/root.c
@@ -300,11 +300,15 @@ static int proc_reconfigure(struct fs_context *fc)
 {
        struct super_block *sb = fc->root->d_sb;
        struct proc_fs_info *fs_info = proc_sb_info(sb);
+       const struct cred *cred;

        sync_filesystem(sb);

-       proc_apply_options(fs_info, fc, current_user_ns());
-       return 0;
+       cred = rcu_replace_pointer(fs_info->mounter_cred, get_cred(fc->cred),
+                                  lockdep_is_held(&sb->s_umount));
+       put_cred(cred);
+
+       return proc_apply_options(sb, fc, current_user_ns());
 }

 static int proc_get_tree(struct fs_context *fc)

