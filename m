Return-Path: <linux-fsdevel+bounces-23820-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD06D933C5C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 13:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 398851F22DFC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 11:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F359D17F50F;
	Wed, 17 Jul 2024 11:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hMsptBmj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tq3u9ahV";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gaNocMnS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kKm7CLs7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA69B1CA9F;
	Wed, 17 Jul 2024 11:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721215986; cv=none; b=JxbkEsqyDGFC2YhoCCUqFcWPaiQv2Mf6VzBo2CFmB3ntyZDmiAhVdznUtJeFQiuidTspoGMyiGIoXN/SjmL916vLFXRIQ80RBPHvO/oRLwqapvXXyTDb81NeJpLpAozuChOtlrayZaFcUCksJf7PKX+ypj/dHmiG0FWutk265z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721215986; c=relaxed/simple;
	bh=aqNtXKxK785M528fgM40ar9Zybxd6EOMrqFWSPgj6d4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uc6q8aOCl2Ve1+nM3d4McJE2JQfp8FG+xMRvTCR0xEKCaZfRenkwfjPYUTgpnMmZXu+ggrLA5fs4pR+OziIvd9YGww/p/yEougKBS/7ONYpLRTnkiXTEZKns3kZ5O8JeNvf8QHSX6Nuq+f6b3Wworvb6P8Pbyi+SfmMxCr002ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hMsptBmj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tq3u9ahV; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gaNocMnS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kKm7CLs7; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D370721AA5;
	Wed, 17 Jul 2024 11:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721215983; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GDWXncWUPfRdiXS4Mf0WhNRYE+bpXbuIBFaPu+Mnb8M=;
	b=hMsptBmjNU6rqyIbeaU0d8oEGFKY0kJZSYd1H82L1btAT4NZJeeX7O6DtPDjKwe1RdEtGN
	kuL/edSLPdLI7UqkCK/iqOAXpEVP8VdjHX08hvzY1ntyMInBT9hIzC7E5ot473OCdVvtZT
	19v1iwk38lAPRsKM2Okzv3cS6LelyXA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721215983;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GDWXncWUPfRdiXS4Mf0WhNRYE+bpXbuIBFaPu+Mnb8M=;
	b=tq3u9ahVvypk4IIzTiz7d3p5367WC4QsQ3UC/ero+aDb87v/meTbgkVXAYTv0/Ytu+UCzu
	Mx2YAQGQ4qWIa/AQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=gaNocMnS;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=kKm7CLs7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721215982; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GDWXncWUPfRdiXS4Mf0WhNRYE+bpXbuIBFaPu+Mnb8M=;
	b=gaNocMnSgqxFpDhUTYHX86oOpSRl2YwuWzfWq/F3wFq0uHTLY7toMcsxVIaHD7UrWI5w3u
	oXyuFPyUxCVTlweug8NXhjudmXpKzR32KAVF1K/7BW6nU+GWJzvFpRfQphbUswfzLDxtAC
	o8OJBsfIBdoGYWk8Wr/x79KwKqVv/Sw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721215982;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GDWXncWUPfRdiXS4Mf0WhNRYE+bpXbuIBFaPu+Mnb8M=;
	b=kKm7CLs71ZBkvKG9H9zYZ959pvqlwWLAwKrP5XNx/vMlVd4c73gVswVHt/fatpIK0lXVgq
	r+ZkGVAjrXgSCZAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C341C136E5;
	Wed, 17 Jul 2024 11:33:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id A52mL+6rl2Z5TAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 17 Jul 2024 11:33:02 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 7CEB5A0987; Wed, 17 Jul 2024 13:32:47 +0200 (CEST)
Date: Wed, 17 Jul 2024 13:32:47 +0200
From: Jan Kara <jack@suse.cz>
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Chandan Babu R <chandan.babu@oracle.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	Hugh Dickins <hughd@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Dave Chinner <david@fromorbit.com>, Andi Kleen <ak@linux.intel.com>,
	Christoph Hellwig <hch@infradead.org>,
	Uros Bizjak <ubizjak@gmail.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Arnd Bergmann <arnd@arndb.de>, Randy Dunlap <rdunlap@infradead.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org, linux-nfs@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v6 7/9] ext4: switch to multigrain timestamps
Message-ID: <20240717113247.hih4trvudsdbrwts@quack3>
References: <20240715-mgtime-v6-0-48e5d34bd2ba@kernel.org>
 <20240715-mgtime-v6-7-48e5d34bd2ba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240715-mgtime-v6-7-48e5d34bd2ba@kernel.org>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[33];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLm8ftxcjxomczyd9jc9seq4h9)];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,goodmis.org,efficios.com,oracle.com,mit.edu,dilger.ca,fb.com,toxicpanda.com,suse.com,google.com,linux-foundation.org,lwn.net,fromorbit.com,linux.intel.com,infradead.org,gmail.com,linux.dev,arndb.de,vger.kernel.org,kvack.org];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,toxicpanda.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:email,suse.cz:dkim]
X-Spam-Flag: NO
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Level: 
X-Rspamd-Queue-Id: D370721AA5

On Mon 15-07-24 08:48:58, Jeff Layton wrote:
> Enable multigrain timestamps, which should ensure that there is an
> apparent change to the timestamp whenever it has been written after
> being actively observed via getattr.
> 
> For ext4, we only need to enable the FS_MGTIME flag.
> 
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

You, I don't think anything else is needed. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/super.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index eb899628e121..95d4d7c0957a 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -7294,7 +7294,7 @@ static struct file_system_type ext4_fs_type = {
>  	.init_fs_context	= ext4_init_fs_context,
>  	.parameters		= ext4_param_specs,
>  	.kill_sb		= ext4_kill_sb,
> -	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP,
> +	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP | FS_MGTIME,
>  };
>  MODULE_ALIAS_FS("ext4");
>  
> 
> -- 
> 2.45.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

