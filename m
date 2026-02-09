Return-Path: <linux-fsdevel+bounces-76707-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2GeoMD7piWlnEAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76707-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 15:03:42 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2883C110010
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 15:03:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ABEA93028EEF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Feb 2026 14:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 924CD378D74;
	Mon,  9 Feb 2026 14:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p5JHx7Pg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A4C22B8BD;
	Mon,  9 Feb 2026 14:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770645686; cv=none; b=rHeud/xV2aq0FVx8npXqUKx0wXPWzN3gKOlHbkXHiFiwfEcRxoBGbiv8S81Hp5QFsxuxTbnIS2Xs54okjDO4RiHYd2Lsy+ppFg8MS50K4mlwZkpGxskAOZCZBcS9J8pZXzjdvYxBDwLh5lWbITH1GHR99HvgQznupzycPsR1E0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770645686; c=relaxed/simple;
	bh=okR+EAtZhjqHaf6qo/7UrQbLty7TTHO1yWpP4wFCTMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ektc+xEXwultlHhwdBvfUzxsZNIYmMJlOPRBOc7uiqlAr+ghXJyIpBVIYd1Gdc37xuGx/ywKcFt835TIdDDrkw2scWC9rOeehKdM/pVLkDdBNpIZ5B5BtfBw/Y2yO6l4X75iD7eVbWo29zmlYR4SQceEf7XJW3l/hVDvYxgwErs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p5JHx7Pg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AEC7C116C6;
	Mon,  9 Feb 2026 14:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770645685;
	bh=okR+EAtZhjqHaf6qo/7UrQbLty7TTHO1yWpP4wFCTMU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p5JHx7Pglta9XrUEaylUygInEiRiWXmfPPLfeI2KtvQbPYTnk4Ro1akxcHmoMu4xu
	 a3rPUUA06pM1HLn+V8WQmnrtQB3P/O/mPbO7svaVwr5hwKY91nd8iaoeZcKL0PSYvB
	 ut9T4TmWe70bsxgxDMg1lC3+qiXmrWOT8+pcw35qxrX2NW3EMRbCFe3XN0iH833rRv
	 xDj19Jt4Du8LUu5kMl2q2uMOa7u+B42cNl0palnEv8OpSkyp8BO3Bqg7TfHnVeK8Xf
	 ZCY4/xPIoJbBLVieSTAXEiUcphSRlerLDo70TWnv+PIZ+a8heIljkD/SQF3Dx85r+v
	 uJaMv5Xr/qy/A==
Date: Mon, 9 Feb 2026 15:01:20 +0100
From: Christian Brauner <brauner@kernel.org>
To: danieldurning.work@gmail.com
Cc: linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, paul@paul-moore.com, 
	stephen.smalley.work@gmail.com, omosnace@redhat.com, Oleg Nesterov <oleg@redhat.com>
Subject: Re: [RFC PATCH] fs/pidfs: Add permission check to pidfd_info()
Message-ID: <20260209-spanplatten-zerrt-73851db30f18@brauner>
References: <20260206180248.12418-1-danieldurning.work@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260206180248.12418-1-danieldurning.work@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76707-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,zeniv.linux.org.uk,suse.cz,paul-moore.com,gmail.com,redhat.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2883C110010
X-Rspamd-Action: no action

On Fri, Feb 06, 2026 at 06:02:48PM +0000, danieldurning.work@gmail.com wrote:
> From: Daniel Durning <danieldurning.work@gmail.com>
> 
> Added a permission check to pidfd_info(). Originally, process info
> could be retrieved with a pidfd even if proc was mounted with hidepid
> enabled, allowing pidfds to be used to bypass those protections. We
> now call ptrace_may_access() to perform some DAC checking as well
> as call the appropriate LSM hook.
> 
> The downside to this approach is that there are now more restrictions
> on accessing this info from a pidfd than when just using proc (without
> hidepid). I am open to suggestions if anyone can think of a better way
> to handle this.

This isn't really workable since this would regress userspace quite a
bit. I think we need a different approach. I've given it some thought
and everything's kinda ugly but this might work.

In struct pid_namespace record whether anyone ever mounted a procfs
with hidepid turned on for this pidns. In pidfd_info() we check whether
hidepid was ever turned on. If it wasn't we're done and can just return
the info. This will be the common case. If hidepid was ever turned on
use kern_path("/proc") to lookup procfs. If not found check
ptrace_may_access() to decide whether to return the info or not. If
/proc is found check it's hidepid settings and make a decision based on
that.

You can probably reorder this to call ptrace_may_access() first and then
do the procfs lookup dance. Thoughts?

> I have also noticed that it is possible to use pidfds to poll on any
> process regardless of whether the process is a child of the caller,
> has a different UID, or has a different security context. Is this
> also worth addressing? If so, what exactly should the DAC checks be?

Oleg and I had discusses this and decided that such polling isn't
sensitive information so by default this should just work and it's
relied upon in Android and in a bunch of other workloads. An LSM can of
course restrict access via security_file_ioctl().

Fwiw, pidfds now support persistent trusted extended attributes so if
the LSM folks wanted we can add security.* extended attribute support
and they can mark pidfds with persistent security labels - persistent as
in for the lifetime of the task.

> Signed-off-by: Daniel Durning <danieldurning.work@gmail.com>
> ---
>  fs/pidfs.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/fs/pidfs.c b/fs/pidfs.c
> index dba703d4ce4a..058a7d798bca 100644
> --- a/fs/pidfs.c
> +++ b/fs/pidfs.c
> @@ -365,6 +365,13 @@ static long pidfd_info(struct file *file, unsigned int cmd, unsigned long arg)
>  		goto copy_out;
>  	}
>  
> +	/*
> +	 * Do a filesystem cred ptrace check to verify access
> +	 * to the task's info.
> +	 */
> +	if (!ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS))
> +		return -EACCES;
> +
>  	c = get_task_cred(task);
>  	if (!c)
>  		return -ESRCH;
> -- 
> 2.52.0
> 

