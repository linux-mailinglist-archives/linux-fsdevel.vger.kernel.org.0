Return-Path: <linux-fsdevel+bounces-16105-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C3188983DE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Apr 2024 11:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C9041C23C58
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Apr 2024 09:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B94F745D6;
	Thu,  4 Apr 2024 09:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rhNiLeBW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GdXeHOPa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDBB5E07E;
	Thu,  4 Apr 2024 09:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712222349; cv=none; b=X9A9NTNjbLo6ng/e97pmzRXgJdLqiJ8UEUt8z5susZihAcXaTkxcW5g7SIgeYlyw9D15/Bq+66PUT4sKUQkbayJSx73uqcF+AKPBYP8PXAFkhtS0FEoo/3qSZOWC6QvUJhzjZ2ANj5SNYWCSZ28HqP9cDbF0ud2jPG3haQQDEWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712222349; c=relaxed/simple;
	bh=QYcy8FlXFMLr0LYgckTAxPjA/WLT+e3mJ8K4S1U3/j4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ISdFPeQOaVgU9Q3A9AjRFpqbYGHXNJCQIqVPsWBQYHzU6U2YOOypEt4fHK4dM3wYZERJjAG0gh9Kw8lMspWDCcK9hmtNWKOVvvRDR34XyQ+oQKby9+i6HK78yQ2669PQWgopq4Gug1Bjca4FhhEkadgU9ajBFQ+yJafiT8xuM4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rhNiLeBW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GdXeHOPa; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 324F55D7AC;
	Thu,  4 Apr 2024 09:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712222345; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bWJK0SE/XFBDZ4vQTfHP0Qc1oDLZBXxgZ4+fPFvJof8=;
	b=rhNiLeBWFxwwhRPZ9RLpw08LzRgszGVajbvbiNzKyBw8Oj5jNuKgIa0LPQ20EJgOIv99Kk
	QM91F1Ezy2Qqnz5ce+DacsycImRyHZjiEA2kl9MWZSzKLqkNowhN3ooDq0yMHe8tq+MGjX
	OG71jYJLIeL2q3wojo8bZa11jw9AaHY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712222345;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bWJK0SE/XFBDZ4vQTfHP0Qc1oDLZBXxgZ4+fPFvJof8=;
	b=GdXeHOPasNjcnARsL2Ip5kUceDl6ZOBIJm00lBgQM19NbBmdWMAA3YHpmv1cYvfu1ug3aK
	nNlRY85YI4+CJICQ==
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 249F4139E8;
	Thu,  4 Apr 2024 09:19:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id wg7sCIlwDmZLIQAAn2gu4w
	(envelope-from <jack@suse.cz>); Thu, 04 Apr 2024 09:19:05 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C6AE2A0816; Thu,  4 Apr 2024 11:19:00 +0200 (CEST)
Date: Thu, 4 Apr 2024 11:19:00 +0200
From: Jan Kara <jack@suse.cz>
To: Kees Cook <keescook@chromium.org>
Cc: Christian Brauner <brauner@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: Set file_handle::handle_bytes before referencing
 file_handle::f_handle
Message-ID: <20240404091900.woh6y2a52o7uo5vx@quack3>
References: <20240403215358.work.365-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403215358.work.365-kees@kernel.org>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.998];
	 RCPT_COUNT_TWELVE(0.00)[12];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,suse.com:email,chromium.org:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[kernel.org,zeniv.linux.org.uk,suse.cz,oracle.com,gmail.com,vger.kernel.org];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: 
X-Spam-Flag: NO

On Wed 03-04-24 14:54:03, Kees Cook wrote:
> With adding __counted_by(handle_bytes) to struct file_handle, we need
> to explicitly set it in the one place it wasn't yet happening prior to
> accessing the flex array "f_handle".
> 
> Fixes: 1b43c4629756 ("fs: Annotate struct file_handle with __counted_by() and use struct_size()")
> Signed-off-by: Kees Cook <keescook@chromium.org>

OK, so this isn't really a functional bug AFAIU but the compiler will
wrongly complain we are accessing handle->f_handle beyond claimed array
size (because handle->handle_bytes == 0 at that point). Am I right? If
that's the case, please add a short comment explaining this (because it
looks odd we set handle->handle_bytes and then reset it a few lines later).
With the comment feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Chuck Lever <chuck.lever@oracle.com>
> Cc: Jeff Layton <jlayton@kernel.org>
> Cc: Amir Goldstein <amir73il@gmail.com>
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-nfs@vger.kernel.org
> Cc: linux-hardening@vger.kernel.org
> ---
>  fs/fhandle.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/fhandle.c b/fs/fhandle.c
> index 53ed54711cd2..08ec2340dd22 100644
> --- a/fs/fhandle.c
> +++ b/fs/fhandle.c
> @@ -40,6 +40,7 @@ static long do_sys_name_to_handle(const struct path *path,
>  			 GFP_KERNEL);
>  	if (!handle)
>  		return -ENOMEM;
> +	handle->handle_bytes = f_handle.handle_bytes;
>  
>  	/* convert handle size to multiple of sizeof(u32) */
>  	handle_dwords = f_handle.handle_bytes >> 2;
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

