Return-Path: <linux-fsdevel+bounces-35877-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5CFE9D9387
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 09:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 867E02844E3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 08:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 135DF1AF0CA;
	Tue, 26 Nov 2024 08:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YUfPyeqU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WI9DSH9W";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YUfPyeqU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WI9DSH9W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9D917BA0;
	Tue, 26 Nov 2024 08:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732610869; cv=none; b=LiAuGmwbRPT02Qp+guVRcOjHvDDRRAEaXjaGAblHsS05k6y9Epb18UXPXsa4T0uOGfAXuQq5nOm45dZNJu2lQGf8CAfQdr1Oi7xQJQlu5rPehZR2EwerJHFcguceWvP9DOu/vb9URT1Y8fTkMJgHywgkHAug4jJpEgATx0Bf3cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732610869; c=relaxed/simple;
	bh=bM7I5pk4wqPLNuFim9xANyoe5nNSDxH6zY2FUULVkRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tU6vpzskHHeKB7YKKvt2wclKKmt3dQmbo6Q2hSATyAi4mFdPuL3+kBX+NTrooSXsksS0j/2MR7+oVGNXXSWdy6l2Xvk2JFh8YUD96xNtAciJSCPiHbJrZQmOossgqqLzJSpGN6+ySkHhxLxT56athXRJyO9oNnSksoao0rF6nM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YUfPyeqU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WI9DSH9W; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YUfPyeqU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WI9DSH9W; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 50EB52115E;
	Tue, 26 Nov 2024 08:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732610865; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S6l7f0A6K6sgvMnsO7s3WGbKUw6qzbSJBXBYGeybt1M=;
	b=YUfPyeqUPB0xkCkB/eRR2TXB9+TQmwSL+HfmTMDLYlQ0RaBQvTWTkGs4vbtqIQesHrA+xS
	L8nNzo7V8gbYvCjm574nVFZJXnKBjQ+YzmeUEsQ4gy+/VoYwwZX22/7JFXCqL9HQbouRJq
	pPUJjbJSVOiOSh9yYyZ8vF0xoueZAWw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732610865;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S6l7f0A6K6sgvMnsO7s3WGbKUw6qzbSJBXBYGeybt1M=;
	b=WI9DSH9WJOUdIyRvLuIVVy21zix30ELZ5Zpi1kiwu5IjEJn72x/jj7vtyYxQSUo/YrntT0
	n2aPwwFjJJUFt2CA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=YUfPyeqU;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=WI9DSH9W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732610865; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S6l7f0A6K6sgvMnsO7s3WGbKUw6qzbSJBXBYGeybt1M=;
	b=YUfPyeqUPB0xkCkB/eRR2TXB9+TQmwSL+HfmTMDLYlQ0RaBQvTWTkGs4vbtqIQesHrA+xS
	L8nNzo7V8gbYvCjm574nVFZJXnKBjQ+YzmeUEsQ4gy+/VoYwwZX22/7JFXCqL9HQbouRJq
	pPUJjbJSVOiOSh9yYyZ8vF0xoueZAWw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732610865;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S6l7f0A6K6sgvMnsO7s3WGbKUw6qzbSJBXBYGeybt1M=;
	b=WI9DSH9WJOUdIyRvLuIVVy21zix30ELZ5Zpi1kiwu5IjEJn72x/jj7vtyYxQSUo/YrntT0
	n2aPwwFjJJUFt2CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 45FFC139AA;
	Tue, 26 Nov 2024 08:47:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id e2oTETGLRWeEeAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 26 Nov 2024 08:47:45 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E0897A08CA; Tue, 26 Nov 2024 09:47:44 +0100 (CET)
Date: Tue, 26 Nov 2024 09:47:44 +0100
From: Jan Kara <jack@suse.cz>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: linux-ext4@vger.kernel.org, Jan Kara <jack@suse.com>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Baokun Li <libaokun1@huawei.com>,
	Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [PATCH v2 1/2] quota: flush quota_release_work upon quota
 writeback
Message-ID: <20241126084744.fjnl3mmgme2mqhh2@quack3>
References: <20241121123855.645335-1-ojaswin@linux.ibm.com>
 <20241121123855.645335-2-ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241121123855.645335-2-ojaswin@linux.ibm.com>
X-Rspamd-Queue-Id: 50EB52115E
X-Spam-Score: -2.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[8];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,suse.com,gmail.com,huawei.com,linux.ibm.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Thu 21-11-24 18:08:54, Ojaswin Mujoo wrote:
> One of the paths quota writeback is called from is:
> 
> freeze_super()
>   sync_filesystem()
>     ext4_sync_fs()
>       dquot_writeback_dquots()
> 
> Since we currently don't always flush the quota_release_work queue in
> this path, we can end up with the following race:
> 
>  1. dquot are added to releasing_dquots list during regular operations.
>  2. FS Freeze starts, however, this does not flush the quota_release_work queue.
>  3. Freeze completes.
>  4. Kernel eventually tries to flush the workqueue while FS is frozen which
>     hits a WARN_ON since transaction gets started during frozen state:
> 
>   ext4_journal_check_start+0x28/0x110 [ext4] (unreliable)
>   __ext4_journal_start_sb+0x64/0x1c0 [ext4]
>   ext4_release_dquot+0x90/0x1d0 [ext4]
>   quota_release_workfn+0x43c/0x4d0
> 
> Which is the following line:
> 
>   WARN_ON(sb->s_writers.frozen == SB_FREEZE_COMPLETE);
> 
> Which ultimately results in generic/390 failing due to dmesg
> noise. This was detected on powerpc machine 15 cores.
> 
> To avoid this, make sure to flush the workqueue during
> dquot_writeback_dquots() so we dont have any pending workitems after
> freeze.
> 
> Reported-by: Disha Goel <disgoel@linux.ibm.com>
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Thanks. Since this patch is independent, I've picked it up into my tree
(will push it to Linus for rc2).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

