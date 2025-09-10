Return-Path: <linux-fsdevel+bounces-60813-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86CABB51BDE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 17:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F29431C24DBA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 15:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF44245031;
	Wed, 10 Sep 2025 15:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lsbbvFXB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="KosGf2fV";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lsbbvFXB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="KosGf2fV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3956326560D
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Sep 2025 15:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757518679; cv=none; b=UuRGAMXlrrTkTYYkVIrQkWcr+/uBBTnwvfm4nkPEr0i6Y5Af+ZLIhCDiuM0gVADPwuZUEdby+L2odmbBQUMLv6+bUdqaJMTzsP4IVGd0ykhckiFGhsoik575XoPME9Uin8+nJI5ql4iKGQnQ9RhsiYh9t4rWoWAHSITD8MkJEkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757518679; c=relaxed/simple;
	bh=J9b9WiXFSRPdfF5JGeZWMBrJ6lEaAe0Rrw2zRiIM1kk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O03PVEWygIEj/pHRIyrkZMLDHioYpkrTgGYq6EWbBqlcuSWwhmPcJvTFNw0belFpZvkjWHhAQaXIInrxp1jOdlOXn37cdQjFgq9gsRGp5sDmbHstK5wopWAYSjzvFdI9EDGmgnJq1io5Ifl6iV2CZoLEq1/T5DKZJkluE57tMuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lsbbvFXB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=KosGf2fV; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lsbbvFXB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=KosGf2fV; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 651FC33CD6;
	Wed, 10 Sep 2025 15:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757518674; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=15sE0Z3wXXaolJoSlUAytH9AqR+61628Et+pbioJ8TU=;
	b=lsbbvFXBasQP0zkHtD8xWmbIWNY91G0uA7t90BqiqfgY4B2VndRrIAB83SFL3qAkVrf4VP
	Y67nCdHC+/gau4WawfksWn7U3T7EFL+mTYNEaC1eLYXAThAISKsmd7Gto66QRuwe+vuwZX
	mt6cgLOCvMekjywjiNqAJuTlxwCRTTU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757518674;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=15sE0Z3wXXaolJoSlUAytH9AqR+61628Et+pbioJ8TU=;
	b=KosGf2fVrUc/d3X8mvYtIDplzNqNMGu8KFNhtUmwqymCLJ4SFOCp2xj1gUMF+fnfsxxy1J
	/ztvSeY2qDx8veCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757518674; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=15sE0Z3wXXaolJoSlUAytH9AqR+61628Et+pbioJ8TU=;
	b=lsbbvFXBasQP0zkHtD8xWmbIWNY91G0uA7t90BqiqfgY4B2VndRrIAB83SFL3qAkVrf4VP
	Y67nCdHC+/gau4WawfksWn7U3T7EFL+mTYNEaC1eLYXAThAISKsmd7Gto66QRuwe+vuwZX
	mt6cgLOCvMekjywjiNqAJuTlxwCRTTU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757518674;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=15sE0Z3wXXaolJoSlUAytH9AqR+61628Et+pbioJ8TU=;
	b=KosGf2fVrUc/d3X8mvYtIDplzNqNMGu8KFNhtUmwqymCLJ4SFOCp2xj1gUMF+fnfsxxy1J
	/ztvSeY2qDx8veCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 53B5913301;
	Wed, 10 Sep 2025 15:37:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QUFuFFKbwWhCOgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 10 Sep 2025 15:37:54 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 06BE1A0A2D; Wed, 10 Sep 2025 17:37:46 +0200 (CEST)
Date: Wed, 10 Sep 2025 17:37:45 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
	linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
	Jeff Layton <jlayton@kernel.org>, Mike Yuan <me@yhndnzj.com>, 
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, Lennart Poettering <mzxreary@0pointer.de>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH 05/32] nsfs: add nsfs.h header
Message-ID: <biw5wpc4kmp4gdb3imoi65txbd6dsovahrlrd7njvzpuvni4ak@5ytepsd3tp3z>
References: <20250910-work-namespace-v1-0-4dd56e7359d8@kernel.org>
 <20250910-work-namespace-v1-5-4dd56e7359d8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910-work-namespace-v1-5-4dd56e7359d8@kernel.org>
X-Spam-Level: 
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	R_RATELIMIT(0.00)[to_ip_from(RLbyy5b47ky7xssyr143sji8pp)];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,vger.kernel.org,toxicpanda.com,kernel.org,yhndnzj.com,in.waw.pl,0pointer.de,cyphar.com,zeniv.linux.org.uk,kernel.dk,cmpxchg.org,suse.com,google.com,redhat.com,oracle.com];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -2.30

On Wed 10-09-25 16:36:50, Christian Brauner wrote:
> And move the stuff out from proc_ns.h where it really doesn't belong.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks sensible. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/nsfs.h    | 26 ++++++++++++++++++++++++++
>  include/linux/proc_ns.h | 13 +------------
>  2 files changed, 27 insertions(+), 12 deletions(-)
> 
> diff --git a/include/linux/nsfs.h b/include/linux/nsfs.h
> new file mode 100644
> index 000000000000..fb84aa538091
> --- /dev/null
> +++ b/include/linux/nsfs.h
> @@ -0,0 +1,26 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (c) 2025 Christian Brauner <brauner@kernel.org> */
> +
> +#ifndef _LINUX_NSFS_H
> +#define _LINUX_NSFS_H
> +
> +#include <linux/ns_common.h>
> +
> +struct path;
> +struct task_struct;
> +struct proc_ns_operations;
> +
> +int ns_get_path(struct path *path, struct task_struct *task,
> +		const struct proc_ns_operations *ns_ops);
> +typedef struct ns_common *ns_get_path_helper_t(void *);
> +int ns_get_path_cb(struct path *path, ns_get_path_helper_t ns_get_cb,
> +		   void *private_data);
> +
> +bool ns_match(const struct ns_common *ns, dev_t dev, ino_t ino);
> +
> +int ns_get_name(char *buf, size_t size, struct task_struct *task,
> +			const struct proc_ns_operations *ns_ops);
> +void nsfs_init(void);
> +
> +#endif /* _LINUX_NSFS_H */
> +
> diff --git a/include/linux/proc_ns.h b/include/linux/proc_ns.h
> index 4b20375f3783..5e1a4b378b79 100644
> --- a/include/linux/proc_ns.h
> +++ b/include/linux/proc_ns.h
> @@ -5,7 +5,7 @@
>  #ifndef _LINUX_PROC_NS_H
>  #define _LINUX_PROC_NS_H
>  
> -#include <linux/ns_common.h>
> +#include <linux/nsfs.h>
>  #include <uapi/linux/nsfs.h>
>  
>  struct pid_namespace;
> @@ -75,16 +75,5 @@ static inline int ns_alloc_inum(struct ns_common *ns)
>  #define ns_free_inum(ns) proc_free_inum((ns)->inum)
>  
>  #define get_proc_ns(inode) ((struct ns_common *)(inode)->i_private)
> -extern int ns_get_path(struct path *path, struct task_struct *task,
> -			const struct proc_ns_operations *ns_ops);
> -typedef struct ns_common *ns_get_path_helper_t(void *);
> -extern int ns_get_path_cb(struct path *path, ns_get_path_helper_t ns_get_cb,
> -			    void *private_data);
> -
> -extern bool ns_match(const struct ns_common *ns, dev_t dev, ino_t ino);
> -
> -extern int ns_get_name(char *buf, size_t size, struct task_struct *task,
> -			const struct proc_ns_operations *ns_ops);
> -extern void nsfs_init(void);
>  
>  #endif /* _LINUX_PROC_NS_H */
> 
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

