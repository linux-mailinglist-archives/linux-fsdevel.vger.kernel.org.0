Return-Path: <linux-fsdevel+bounces-39129-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE38A103CD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 11:16:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 517C1167AA5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 10:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B35C28EC79;
	Tue, 14 Jan 2025 10:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qQdoEncC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VXzJ/XJk";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ETeLus2Q";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2fA8J3MZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF6828EC65
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jan 2025 10:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736849751; cv=none; b=Zl3Kru3JxSfpOOI9a2lDns7kgUm6zseV3lwrLT2GpSEBMrX4aQR5CugO5+MfmYfH3X0YBCVYxT8iz8B3C67TMJQE8gLnFf2vmS46j2mLDGU6cMmZLyXAyO8Q3QLAC/pLEZ8F3KPXM+dGvyxPzwqZqpZswMBYY29ut1CD1fWYJLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736849751; c=relaxed/simple;
	bh=cn6oemrUmO1tWyTBIPMc2qqi9exUCXTIhWlrcexLbJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oG5i/sBh8yv8c2mNUWvDGR9CighCr6+8TLkt9VZYMoia4zitVzZQ6zgSFulWgtDDO44phTNSMtf+3Ryhz1g1f5CB7+GFOAe7TR2kDrmMTOTC07WmJwJ1Fc9JFO2p6xMcg7A3/z8aM2M1xoblMLC7tYCGaGd0pzQJ2E4//eMFWHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qQdoEncC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VXzJ/XJk; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ETeLus2Q; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2fA8J3MZ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 66F341F38E;
	Tue, 14 Jan 2025 10:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736849747; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ANc6pGs30TKvEMUj47HfMRpq5GK/MwoAqpX9lNOcZkg=;
	b=qQdoEncCm+g016P6RHsPPh0eKS5su/BN2wBPxpRGshQaLGq6uu0CIV/grqZNbNZyg8szyS
	5rPVts/L/LKOB3y50VmRyiBRBcwo776lEUj9k9gB7fxz7YNvNi1uYoyvSQSXzmtMetdzrE
	RXbKvvSRDfPk6v7E4C0O/n20kWHjvXg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736849747;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ANc6pGs30TKvEMUj47HfMRpq5GK/MwoAqpX9lNOcZkg=;
	b=VXzJ/XJkmNHYhg85JAMktfA1qGpREiPvrSf/GdIYgmOtUoXRUPjm1BVDEKWUINHY3kO9r2
	kZ8wbKXOPfBktuDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736849746; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ANc6pGs30TKvEMUj47HfMRpq5GK/MwoAqpX9lNOcZkg=;
	b=ETeLus2Q5b+XmmXIJsmIXGftBXiLwNc93k10DEWHaXd01TmgrLVN34htBm9mjSy2fzRZq5
	CIw1Bb2PhI4/jcDFBi/dOZGg020B8pXlvWRPm02sM+6VyvU8rRNrPQZODZ4XHoAkuqWdVX
	NtXrI/Tssy9AMSwIe0FDbq35Yl2YgoU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736849746;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ANc6pGs30TKvEMUj47HfMRpq5GK/MwoAqpX9lNOcZkg=;
	b=2fA8J3MZzBQg8Zf4bZrZlHVxnNxqVnD0CzNAbhRAdWF1nD7j9ccKSVXgTUuVMDZo7xx0f7
	EWmvloKClASiDJCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5D2CF1384C;
	Tue, 14 Jan 2025 10:15:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mOy6FlI5hmfyCAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 14 Jan 2025 10:15:46 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 20686A08CD; Tue, 14 Jan 2025 11:15:46 +0100 (CET)
Date: Tue, 14 Jan 2025 11:15:46 +0100
From: Jan Kara <jack@suse.cz>
To: Sentaro Onizuka <sentaro@amazon.com>
Cc: linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: Re: [PATCH] fs: Fix return type of do_mount() from long to int
Message-ID: <y7ghtllzkliduhi746fr7vjrvhebmr6z656fvpvibo2u3ttd65@wu2jeyeffge2>
References: <20250113151400.55512-1-sentaro@amazon.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250113151400.55512-1-sentaro@amazon.com>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Tue 14-01-25 00:14:00, Sentaro Onizuka wrote:
> Fix the return type of do_mount() function from long to int to match its ac
> tual behavior. The function only returns int values, and all callers, inclu
> ding those in fs/namespace.c and arch/alpha/kernel/osf_sys.c, already treat
>  the return value as int. This change improves type consistency across the
> filesystem code and aligns the function signature with its existing impleme
> ntation and usage.
> 
> Signed-off-by: Sentaro Onizuka <sentaro@amazon.com>

Makes sense. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/namespace.c        | 2 +-
>  include/linux/mount.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 23e81c2a1e3f..5d808778a3ae 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -3835,7 +3835,7 @@ int path_mount(const char *dev_name, struct path *path,
>  			    data_page);
>  }
>  
> -long do_mount(const char *dev_name, const char __user *dir_name,
> +int do_mount(const char *dev_name, const char __user *dir_name,
>  		const char *type_page, unsigned long flags, void *data_page)
>  {
>  	struct path path;
> diff --git a/include/linux/mount.h b/include/linux/mount.h
> index 33f17b6e8732..a7b472faec2c 100644
> --- a/include/linux/mount.h
> +++ b/include/linux/mount.h
> @@ -114,7 +114,7 @@ extern struct vfsmount *kern_mount(struct file_system_type *);
>  extern void kern_unmount(struct vfsmount *mnt);
>  extern int may_umount_tree(struct vfsmount *);
>  extern int may_umount(struct vfsmount *);
> -extern long do_mount(const char *, const char __user *,
> +int do_mount(const char *, const char __user *,
>  		     const char *, unsigned long, void *);
>  extern struct vfsmount *collect_mounts(const struct path *);
>  extern void drop_collected_mounts(struct vfsmount *);
> -- 
> 2.39.5 (Apple Git-154)
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

