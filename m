Return-Path: <linux-fsdevel+bounces-52732-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D00AE60DD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 11:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFBFA3A12D5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 09:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5222777F1;
	Tue, 24 Jun 2025 09:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OQLeP7qo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="q8sSwCM7";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bmgHoj33";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="d0PlgVFr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C4E17A31C
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jun 2025 09:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750757474; cv=none; b=qyB5ORbBJjFsyc4YP8HGXX8umzNQI4uHvH0bU3R7cWP0PreXCZN1yBZ5WBcgPfMxKs3zCgH2/ACTOFHyg09cicQUuag9XamTs4hh7QH92CH/d7o0ifxMICi/PKqJlOG3j92NMbj4UAytvWhGMGk/aB7PdBjn9sBsFvImnhh3hpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750757474; c=relaxed/simple;
	bh=7HC86k0Rt7V5TO/XL0XE6YKnz8F6cwMcS50t2aRJNHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CnN9cshWvzE8fR3Yah/ceu9XBKw4nglpACkJ+I1+8l5wgOGy09UJKXnZZNY/uhT9UrOBBjckIvcTB64iWx55Na5ut1IwlY4KBz7XOSXMdRZHdyIohswCLYE9q2KN7lwkulWDnfJbcdEQh3CfQAnsLq+BfYqaMFrhwVDKKNMXLJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OQLeP7qo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=q8sSwCM7; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bmgHoj33; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=d0PlgVFr; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AA7C421188;
	Tue, 24 Jun 2025 09:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750757471; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eqh7sqE8HdWNwJAQv7YdHjSqArGwEfJdO8WqMLDhP/o=;
	b=OQLeP7qo1y45IkAplhkKIafKxteoQUVBeVZ4BAIXWbnr1TIZ/TmDi1xYqf3Bdum697ZARq
	vYkiiVmlZXIgAO30FcNjvdDP9+JNOKrO72L1sHLD1kd5CSQ1tnMgizT+cKkwoKwb3O7fcN
	HrLnsEEVoXyeR8imgT/d9K+Aw6R6djI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750757471;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eqh7sqE8HdWNwJAQv7YdHjSqArGwEfJdO8WqMLDhP/o=;
	b=q8sSwCM777SDEmY2o/tUqBGN0Db/8Q/cA1o8CLWmKISkwR/tjj6hnmE8lEuhXIqnZaiovj
	XLUM++xMNeoKb2DA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=bmgHoj33;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=d0PlgVFr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750757470; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eqh7sqE8HdWNwJAQv7YdHjSqArGwEfJdO8WqMLDhP/o=;
	b=bmgHoj33efZZYY12zj5jSqLwvI+c3fpABi5mGu1rn99H89+BPA604vWRQbf0jUHrOxXQmk
	/eD7b7Ipzqc9Q+L5jqvY7gIIgpgBE3cX8tBdm5OCuOliKs2tFT1c/fOEf+4XJhtNe0mdXT
	+U/JjJ5a/qMYxDrveqtU4CYfXvx/fV0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750757470;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eqh7sqE8HdWNwJAQv7YdHjSqArGwEfJdO8WqMLDhP/o=;
	b=d0PlgVFryDI0Js+Dlhis7VMYRLspexdEsdAMqEFZQ907dvoGyDRITkKVE99L3aWzqucIB7
	BebG001VxT9cHYAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9E41013751;
	Tue, 24 Jun 2025 09:31:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id R/ufJl5wWmj2HgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 24 Jun 2025 09:31:10 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3E431A0A03; Tue, 24 Jun 2025 11:31:10 +0200 (CEST)
Date: Tue, 24 Jun 2025 11:31:10 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	stable@kernel.org
Subject: Re: [PATCH v2 01/11] fhandle: raise FILEID_IS_DIR in handle_type
Message-ID: <fwbturfsndxipxgyr2azhqzpwxhkaad74layedyr5i6a7naupk@rrxosjec7pbf>
References: <20250624-work-pidfs-fhandle-v2-0-d02a04858fe3@kernel.org>
 <20250624-work-pidfs-fhandle-v2-1-d02a04858fe3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624-work-pidfs-fhandle-v2-1-d02a04858fe3@kernel.org>
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: AA7C421188
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,oracle.com,suse.cz,gmail.com,ffwll.ch,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.01
X-Spam-Level: 

On Tue 24-06-25 10:29:04, Christian Brauner wrote:
> Currently FILEID_IS_DIR is raised in fh_flags which is wrong.
> Raise it in handle->handle_type were it's supposed to be.
> 
> Fixes: c374196b2b9f ("fs: name_to_handle_at() support for "explicit connectable" file handles")
> Cc: <stable@kernel.org>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Still looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/fhandle.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/fhandle.c b/fs/fhandle.c
> index 3e092ae6d142..66ff60591d17 100644
> --- a/fs/fhandle.c
> +++ b/fs/fhandle.c
> @@ -88,7 +88,7 @@ static long do_sys_name_to_handle(const struct path *path,
>  		if (fh_flags & EXPORT_FH_CONNECTABLE) {
>  			handle->handle_type |= FILEID_IS_CONNECTABLE;
>  			if (d_is_dir(path->dentry))
> -				fh_flags |= FILEID_IS_DIR;
> +				handle->handle_type |= FILEID_IS_DIR;
>  		}
>  		retval = 0;
>  	}
> 
> -- 
> 2.47.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

