Return-Path: <linux-fsdevel+bounces-60810-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF921B51BC7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 17:35:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 027F148688B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 15:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F448322DD4;
	Wed, 10 Sep 2025 15:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="T/ob8NHg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="KVqkvC+S";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="T/ob8NHg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="KVqkvC+S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF56E264F9F
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Sep 2025 15:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757518475; cv=none; b=VFYWLFRrGXzd3kmPCGttSZOks5u+x8QdLcDGkzsGTBLP6P1KMFCCHi1JDtgc8s3zten6ZQD7UnPLxxb2aYMJSqggdQf2KC5hMaU9ey+v33/JXjvZCPc9DMk2T0nqNufIRc5761BjAcbF4O9tCUMGDw/w+VSfoUT9ifePubzRjhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757518475; c=relaxed/simple;
	bh=zsudZX1rcqzdDf+Z1yMqTtbi0uKktCchlmZhoYCksVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=flUzTN3GsV+c4DTk96v2PJiGE2hVQOmFE3k0MEduC9uNzHPUH4gbpAAQN1nPFKrbCUjvfI5Z8RX9ZvjoGMDNa4sO3IjmomtQ5UjtnFh/S9Hi8Rj7HMs3bQxYC3s+eGh5+hXvlp8PgZrUObkEfKsdm710Has2nhC+9V3Edv6utlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=T/ob8NHg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=KVqkvC+S; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=T/ob8NHg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=KVqkvC+S; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 20E5D386CF;
	Wed, 10 Sep 2025 15:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757518469; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7S/8MyJLpHl5N2AfEVqXRTh30cdQF1TRTjGChS8UqOA=;
	b=T/ob8NHgZ8oXnbohdL0ZV76vWvjyKwfdKS6y//YPc4n83Vn+pYjlAXmp/6ymjkMH/sTIPz
	iREqOj6sh5ocie5QMZ7HdKmeosxLDibnEKYhJUrGcsQE9JDXpF9QX59yzukF14E2guoSfL
	eyimi0LMzxXu0CPw6VW2GDj1W2IbFWM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757518469;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7S/8MyJLpHl5N2AfEVqXRTh30cdQF1TRTjGChS8UqOA=;
	b=KVqkvC+SFOSKJqD1HBJ0GbUr4O5DEeEASWuAZEJwvBcmtvyXa29cZvaUqsD2BS5jtluA9h
	0bndzD6zcy0NIJCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="T/ob8NHg";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=KVqkvC+S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757518469; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7S/8MyJLpHl5N2AfEVqXRTh30cdQF1TRTjGChS8UqOA=;
	b=T/ob8NHgZ8oXnbohdL0ZV76vWvjyKwfdKS6y//YPc4n83Vn+pYjlAXmp/6ymjkMH/sTIPz
	iREqOj6sh5ocie5QMZ7HdKmeosxLDibnEKYhJUrGcsQE9JDXpF9QX59yzukF14E2guoSfL
	eyimi0LMzxXu0CPw6VW2GDj1W2IbFWM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757518469;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7S/8MyJLpHl5N2AfEVqXRTh30cdQF1TRTjGChS8UqOA=;
	b=KVqkvC+SFOSKJqD1HBJ0GbUr4O5DEeEASWuAZEJwvBcmtvyXa29cZvaUqsD2BS5jtluA9h
	0bndzD6zcy0NIJCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F0E4613301;
	Wed, 10 Sep 2025 15:34:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mPPMOoSawWg8OQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 10 Sep 2025 15:34:28 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 743CEA0A2D; Wed, 10 Sep 2025 17:34:23 +0200 (CEST)
Date: Wed, 10 Sep 2025 17:34:23 +0200
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
Subject: Re: [PATCH 02/32] nsfs: validate extensible ioctls
Message-ID: <i5e5qd2vgeuyq2bm44kqe7gwkctjztw2zhmd75glhvlctpbc63@re3m6iblmkrx>
References: <20250910-work-namespace-v1-0-4dd56e7359d8@kernel.org>
 <20250910-work-namespace-v1-2-4dd56e7359d8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910-work-namespace-v1-2-4dd56e7359d8@kernel.org>
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RL9r1cnt7e4118fjryeg1c95sa)];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,vger.kernel.org,toxicpanda.com,kernel.org,yhndnzj.com,in.waw.pl,0pointer.de,cyphar.com,zeniv.linux.org.uk,kernel.dk,cmpxchg.org,suse.com,google.com,redhat.com,oracle.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 20E5D386CF
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.51

On Wed 10-09-25 16:36:47, Christian Brauner wrote:
> Validate extensible ioctls stricter than we do now.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

							Honza
> ---
>  fs/nsfs.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/nsfs.c b/fs/nsfs.c
> index 59aa801347a7..34f0b35d3ead 100644
> --- a/fs/nsfs.c
> +++ b/fs/nsfs.c
> @@ -169,9 +169,11 @@ static bool nsfs_ioctl_valid(unsigned int cmd)
>  	/* Extensible ioctls require some extra handling. */
>  	switch (_IOC_NR(cmd)) {
>  	case _IOC_NR(NS_MNT_GET_INFO):
> +		return extensible_ioctl_valid(cmd, NS_MNT_GET_INFO, MNT_NS_INFO_SIZE_VER0);
>  	case _IOC_NR(NS_MNT_GET_NEXT):
> +		return extensible_ioctl_valid(cmd, NS_MNT_GET_NEXT, MNT_NS_INFO_SIZE_VER0);
>  	case _IOC_NR(NS_MNT_GET_PREV):
> -		return (_IOC_TYPE(cmd) == _IOC_TYPE(cmd));
> +		return extensible_ioctl_valid(cmd, NS_MNT_GET_PREV, MNT_NS_INFO_SIZE_VER0);
>  	}
>  
>  	return false;
> 
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

