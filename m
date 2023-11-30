Return-Path: <linux-fsdevel+bounces-4449-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 649937FF9B5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 19:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03B83B20B67
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 18:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8075B5A0ED
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 18:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LWKxhgcW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Dfztg6bv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64BF2D50
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 08:42:43 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E83EF21B5D;
	Thu, 30 Nov 2023 16:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1701362560; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tXMsr60jhNjzCeq99HE2uiHGGatxSLfCK3ZL7kOKMO4=;
	b=LWKxhgcWWTY8X4eY+Qqbkfz+w/Z/1Pdbksh8UW+4i9GntxViX/bMH6LHVEASTapJ2WJrDh
	BvTvKQjLKC8U3mVWm1CF6v06RydS9WzQeE/e+oRBDGWbF4uZtrgqlPu/haLI0CWamQtMpP
	rd/6D+q9kSsWry7qi8NbzC6ICxOgFYo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1701362560;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tXMsr60jhNjzCeq99HE2uiHGGatxSLfCK3ZL7kOKMO4=;
	b=Dfztg6bvrnvupG+JRBojh7u73s5x4e/xxB+/Pmx9dhj0rKPYoAbc89v8dQwu2aPN6wNOzU
	XWnfUUyafuH5ccAw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id DAD5013A5C;
	Thu, 30 Nov 2023 16:42:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 8fRqNYC7aGXQFgAAn2gu4w
	(envelope-from <jack@suse.cz>); Thu, 30 Nov 2023 16:42:40 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 77E4FA06F9; Thu, 30 Nov 2023 17:42:40 +0100 (CET)
Date: Thu, 30 Nov 2023 17:42:40 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.com>,
	Jens Axboe <axboe@kernel.dk>, Carlos Llamas <cmllamas@google.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH RFC 3/5] fs: replace f_rcuhead with f_tw
Message-ID: <20231130164240.qh23jxnnc2lbz4s4@quack3>
References: <20231130-vfs-files-fixes-v1-0-e73ca6f4ea83@kernel.org>
 <20231130-vfs-files-fixes-v1-3-e73ca6f4ea83@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130-vfs-files-fixes-v1-3-e73ca6f4ea83@kernel.org>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spamd-Result: default: False [-1.12 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 NEURAL_HAM_SHORT(-0.20)[-0.997];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.34)[76.06%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-0.98)[-0.985];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -1.12

On Thu 30-11-23 13:49:09, Christian Brauner wrote:
> The naming is actively misleading since we switched to
> SLAB_TYPESAFE_BY_RCU. rcu_head is #define callback_head. Use
> callback_head directly and rename f_rcuhead to f_tw.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Nice. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/file_table.c    | 6 +++---
>  include/linux/fs.h | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/file_table.c b/fs/file_table.c
> index 6deac386486d..78614204ef2c 100644
> --- a/fs/file_table.c
> +++ b/fs/file_table.c
> @@ -407,7 +407,7 @@ static void delayed_fput(struct work_struct *unused)
>  
>  static void ____fput(struct callback_head *work)
>  {
> -	__fput(container_of(work, struct file, f_rcuhead));
> +	__fput(container_of(work, struct file, f_tw));
>  }
>  
>  /*
> @@ -438,8 +438,8 @@ void fput(struct file *file)
>  			return;
>  		}
>  		if (likely(!in_interrupt() && !(task->flags & PF_KTHREAD))) {
> -			init_task_work(&file->f_rcuhead, ____fput);
> -			if (!task_work_add(task, &file->f_rcuhead, TWA_RESUME))
> +			init_task_work(&file->f_tw, ____fput);
> +			if (!task_work_add(task, &file->f_tw, TWA_RESUME))
>  				return;
>  			/*
>  			 * After this task has run exit_task_work(),
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index f171505940ff..d23a886df8fa 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -992,7 +992,7 @@ static inline int ra_has_index(struct file_ra_state *ra, pgoff_t index)
>  struct file {
>  	union {
>  		struct llist_node	f_llist;
> -		struct rcu_head 	f_rcuhead;
> +		struct callback_head 	f_tw;
>  		unsigned int 		f_iocb_flags;
>  	};
>  
> 
> -- 
> 2.42.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

