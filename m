Return-Path: <linux-fsdevel+bounces-23821-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A7E933C64
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 13:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9752F1F21212
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 11:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5C617F50F;
	Wed, 17 Jul 2024 11:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YhsCRW6Z";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Zj6IerRz";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="d72abmdr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ALb3YT/i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF79B12E48;
	Wed, 17 Jul 2024 11:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721216088; cv=none; b=VicF57RxkjcftUjnhYZzH7zHHfrRWZROeCHsQ7mjBwWSkeRvTBU7Z+NZSiG9bbuF3zQBDS2CTA3dhgsBucfHJOYIunexjBjYTYgSMhcqLvrrB87GUvP8OviyOjgTyc7fTXJWMz4m0wm+geS42tL9AhjO2N9s0ZF1UgEpGOUBVck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721216088; c=relaxed/simple;
	bh=gcrMxKi/lpjsHgKBrcn3GEAbxhYJH8eFP6iRo/DtgBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bAOurYGCjYW95UIvtV0chNXDxLA0vA6G3eveV4xxFZhZb1D+CXN8q9j2b0gUjdEeHFXdvsDNUVUy91PgTnFe6iJkTanbsor2WzMYn29O9e5O+RlrpIkXGL2DFWu6y/R8CtmMN1rkO0n7BGu6pxjDh/J4qSqzI+2w60UJ6moPRNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YhsCRW6Z; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Zj6IerRz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=d72abmdr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ALb3YT/i; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D734F21AA2;
	Wed, 17 Jul 2024 11:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721216085; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F4CWV/sF7x1WiYDVW9W02BKIWQSYqQruBo2Yq7ZKPbA=;
	b=YhsCRW6ZxkN6p9W0vuSvNmlZ3E9YL7XMLvS+/D4ncqTFIG7jYHVDhAzaRnX7VB/I0eZUy4
	HWQQ3i+/bfvoxViHKG6jSj74A4smED3ZEXyralXeXc7Jeen5+3QfsG+7vuw9Bw+XSlbCxb
	eVeNZC4WVwIBqVuQCjf2aK0lwrlYLNQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721216085;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F4CWV/sF7x1WiYDVW9W02BKIWQSYqQruBo2Yq7ZKPbA=;
	b=Zj6IerRzPp4LCY871cyDBCxeE2n2QICTjI14FtRBETbfBY/8zjZzwZWYJY0QfZVw9hYyx0
	XJP4uCgEE3el06Cw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=d72abmdr;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="ALb3YT/i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721216084; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F4CWV/sF7x1WiYDVW9W02BKIWQSYqQruBo2Yq7ZKPbA=;
	b=d72abmdrO78XCt+6wamD0te92HjEklMKI3bQ6x+I18OQiXkaSgdw/4MEX5EzNLRrRlMWda
	MRPh809gx5r9rV6KUmMlG+eiOcoysPF8ceme+2dy3TSpmvP4U3eIzaT5pTYv0kIZrti7ha
	E2fJLlrLOBx7wzxb+3mfi+nvKzuy74w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721216084;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F4CWV/sF7x1WiYDVW9W02BKIWQSYqQruBo2Yq7ZKPbA=;
	b=ALb3YT/iNrhcoAS9WAJbUBenaiPxqkHzsykltMlOOcIeWWYDvAu8CaKiVy8sdv8I77ifo8
	L6PKcqEGWRgcBABg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C6C51136E5;
	Wed, 17 Jul 2024 11:34:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Y0OFMFSsl2YBTQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 17 Jul 2024 11:34:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 77750A0987; Wed, 17 Jul 2024 13:34:44 +0200 (CEST)
Date: Wed, 17 Jul 2024 13:34:44 +0200
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
Subject: Re: [PATCH v6 9/9] tmpfs: add support for multigrain timestamps
Message-ID: <20240717113444.imq5hru3sh5cyw2s@quack3>
References: <20240715-mgtime-v6-0-48e5d34bd2ba@kernel.org>
 <20240715-mgtime-v6-9-48e5d34bd2ba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240715-mgtime-v6-9-48e5d34bd2ba@kernel.org>
X-Rspamd-Queue-Id: D734F21AA2
X-Spam-Flag: NO
X-Spam-Score: -0.01
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.01 / 50.00];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,goodmis.org,efficios.com,oracle.com,mit.edu,dilger.ca,fb.com,toxicpanda.com,suse.com,google.com,linux-foundation.org,lwn.net,fromorbit.com,linux.intel.com,infradead.org,gmail.com,linux.dev,arndb.de,vger.kernel.org,kvack.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,toxicpanda.com:email,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Level: 
X-Spamd-Bar: /

On Mon 15-07-24 08:49:00, Jeff Layton wrote:
> Enable multigrain timestamps, which should ensure that there is an
> apparent change to the timestamp whenever it has been written after
> being actively observed via getattr.
> 
> tmpfs only requires the FS_MGTIME flag.
> 
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  mm/shmem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 7f2b609945a5..75a9a73a769f 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -4660,7 +4660,7 @@ static struct file_system_type shmem_fs_type = {
>  	.parameters	= shmem_fs_parameters,
>  #endif
>  	.kill_sb	= kill_litter_super,
> -	.fs_flags	= FS_USERNS_MOUNT | FS_ALLOW_IDMAP,
> +	.fs_flags	= FS_USERNS_MOUNT | FS_ALLOW_IDMAP | FS_MGTIME,
>  };
>  
>  void __init shmem_init(void)
> 
> -- 
> 2.45.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

