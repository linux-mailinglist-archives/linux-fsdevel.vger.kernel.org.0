Return-Path: <linux-fsdevel+bounces-60809-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D11C7B51BBA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 17:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7315C48160A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 15:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B652877DC;
	Wed, 10 Sep 2025 15:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KRHc1bx9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qEsMitKb";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KRHc1bx9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qEsMitKb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912C325EFB6
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Sep 2025 15:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757518416; cv=none; b=PIytglEU5y882j3cAHEV1jKBQWJd5ZEEeB7yIdvHFpxDXT00+hQkwvdUT2WiR7CD3afhoJc9DTbHvry9O2JF8+H7rF2cL6wfkwScV+bDfWvFyr7/iQ02tAMZt4lwj/xJ7rYhlOMKPqSC7sDL02Km0BRcKCicQgnd/mSfZ7wFXuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757518416; c=relaxed/simple;
	bh=lE6jA7p7IHcGMhIIhCmy/1BlcN99Vgk0Rz/tO0YufPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cUwmAZ2gs5tZS3P53V/vPN8XHzWebPn2vSo4V94JZGE6RJs5xcFzvEXV6T+TlXTGTYu7XArfM+TUQvEiwwtTdViUPNjIIpHhSGG8+/c4eKxIWr7m3gHL+aIFxMzsnqDako7QnPDTNoEQsFddhj/jItd+dfobUe4NYo9ZOGLR2Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KRHc1bx9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qEsMitKb; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KRHc1bx9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qEsMitKb; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9382D38689;
	Wed, 10 Sep 2025 15:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757518412; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N+vVaYJZe/SeETDd76D8KQfnhKlDAMSjPgTY3xHnUJA=;
	b=KRHc1bx9mBUGexHdDhHiY9svNhz7m5dWa5rtOmbk9lRRezDW/qSK6IFhT8Pu/KbIykAbAY
	L45B6aph0QIXXzl8jpGSfnNzIfxfL73k35CmJ1vbNH076UxlCawwc7nyZUQ8dOHhahnssZ
	/+yHZXY+phttyPipVnmlelJMmKLwVls=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757518412;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N+vVaYJZe/SeETDd76D8KQfnhKlDAMSjPgTY3xHnUJA=;
	b=qEsMitKbtLYp2C0/5PO528EyE8Ie+NzeUkZPBDX9fWRwhk24vSp4qGLXYQIWb8JQKoQLm5
	zf0wICfqlQuCfMAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757518412; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N+vVaYJZe/SeETDd76D8KQfnhKlDAMSjPgTY3xHnUJA=;
	b=KRHc1bx9mBUGexHdDhHiY9svNhz7m5dWa5rtOmbk9lRRezDW/qSK6IFhT8Pu/KbIykAbAY
	L45B6aph0QIXXzl8jpGSfnNzIfxfL73k35CmJ1vbNH076UxlCawwc7nyZUQ8dOHhahnssZ
	/+yHZXY+phttyPipVnmlelJMmKLwVls=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757518412;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N+vVaYJZe/SeETDd76D8KQfnhKlDAMSjPgTY3xHnUJA=;
	b=qEsMitKbtLYp2C0/5PO528EyE8Ie+NzeUkZPBDX9fWRwhk24vSp4qGLXYQIWb8JQKoQLm5
	zf0wICfqlQuCfMAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4F8EC13301;
	Wed, 10 Sep 2025 15:33:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ISZqE0yawWjuOAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 10 Sep 2025 15:33:32 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id AAC4FA0A2D; Wed, 10 Sep 2025 17:33:27 +0200 (CEST)
Date: Wed, 10 Sep 2025 17:33:27 +0200
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
Subject: Re: [PATCH 01/32] pidfs: validate extensible ioctls
Message-ID: <myq5fyn7mlxqxxy4bw4sujz6k6otw5x4b2u3dhsb2lgohrjqtr@bxziyyawq3jk>
References: <20250910-work-namespace-v1-0-4dd56e7359d8@kernel.org>
 <20250910-work-namespace-v1-1-4dd56e7359d8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910-work-namespace-v1-1-4dd56e7359d8@kernel.org>
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

On Wed 10-09-25 16:36:46, Christian Brauner wrote:
> Validate extensible ioctls stricter than we do now.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/pidfs.c         |  2 +-
>  include/linux/fs.h | 14 ++++++++++++++
>  2 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/pidfs.c b/fs/pidfs.c
> index edc35522d75c..0a5083b9cce5 100644
> --- a/fs/pidfs.c
> +++ b/fs/pidfs.c
> @@ -440,7 +440,7 @@ static bool pidfs_ioctl_valid(unsigned int cmd)
>  		 * erronously mistook the file descriptor for a pidfd.
>  		 * This is not perfect but will catch most cases.
>  		 */
> -		return (_IOC_TYPE(cmd) == _IOC_TYPE(PIDFD_GET_INFO));
> +		return extensible_ioctl_valid(cmd, PIDFD_GET_INFO, PIDFD_INFO_SIZE_VER0);
>  	}
>  
>  	return false;
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index d7ab4f96d705..2f2edc53bf3c 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -4023,4 +4023,18 @@ static inline bool vfs_empty_path(int dfd, const char __user *path)
>  
>  int generic_atomic_write_valid(struct kiocb *iocb, struct iov_iter *iter);
>  
> +static inline bool extensible_ioctl_valid(unsigned int cmd_a,
> +					  unsigned int cmd_b, size_t min_size)
> +{
> +	if (_IOC_DIR(cmd_a) != _IOC_DIR(cmd_b))
> +		return false;
> +	if (_IOC_TYPE(cmd_a) != _IOC_TYPE(cmd_b))
> +		return false;
> +	if (_IOC_NR(cmd_a) != _IOC_NR(cmd_b))
> +		return false;
> +	if (_IOC_SIZE(cmd_a) < min_size)
> +		return false;
> +	return true;
> +}
> +
>  #endif /* _LINUX_FS_H */
> 
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

