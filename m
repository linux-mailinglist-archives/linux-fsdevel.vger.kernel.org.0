Return-Path: <linux-fsdevel+bounces-33783-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E4B9BEF30
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 14:37:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BC8F284712
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 13:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772351F9EAC;
	Wed,  6 Nov 2024 13:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PKBrFlha";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bUBEoRY3";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PKBrFlha";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bUBEoRY3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C1F191461;
	Wed,  6 Nov 2024 13:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730900243; cv=none; b=HOII5B6qfl4i3BRULwI/DVff89K01adU/AtAQLabibCqwLdqaIrMgCiIAUGwzvB4s5x5YqAKwpPRI0+x7eheFDbrgIS1xZqYeutLEiDO46u8K4tvP1ZlZUVdLPOgv+AFlMkFWONWGfg/p+soMKELJufZuL6/9BzT1Zx0Awp6fzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730900243; c=relaxed/simple;
	bh=9P4Ht0z4Mn0o9+NWZd896rbeSCtbO6r7+kwdhHA3BuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NOR25W3oftGo2hjI6sOZDswmgjKTS7FKeKJgm3C7mxA4YIDIzPKlt2OPseo2XQtK/a2kC5ze3xfFUGyCqYtfQNUKF399sRh+vESbw2eNqbRpVOI687W4yxRwk3CNVYt2GG+mdCVPN1qjPkfHw3HptYlOE2GNYcp4zGQfMBGD1lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PKBrFlha; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bUBEoRY3; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PKBrFlha; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bUBEoRY3; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F2EBE21D32;
	Wed,  6 Nov 2024 13:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730900240; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g58jj5g36ijnF7hh32dzprjYDPypYPMjByIDbTAl0jE=;
	b=PKBrFlhaST79s/4PB9a0CEiA03AHKMX2vAnBIZWw2fRMmqz5A0HqFKRnYWJ8w2Ko/0cJwu
	UkFthUE988QPTRN1JZ3ubJrQYdFja3YsOBuBmMLraMg3YkaEXETE4ET+aiNN61YpskWXhe
	pIIGvuUVU/GhXef1PDzyWaRnVq8Rzmc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730900240;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g58jj5g36ijnF7hh32dzprjYDPypYPMjByIDbTAl0jE=;
	b=bUBEoRY38V5WI8T9wIaIRoaHGy3BJG/+vmgbEVvlEPLcnQwrDjOmSVPvgWOktdHezqnBz0
	e5OoNa3DDHkT9hAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730900240; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g58jj5g36ijnF7hh32dzprjYDPypYPMjByIDbTAl0jE=;
	b=PKBrFlhaST79s/4PB9a0CEiA03AHKMX2vAnBIZWw2fRMmqz5A0HqFKRnYWJ8w2Ko/0cJwu
	UkFthUE988QPTRN1JZ3ubJrQYdFja3YsOBuBmMLraMg3YkaEXETE4ET+aiNN61YpskWXhe
	pIIGvuUVU/GhXef1PDzyWaRnVq8Rzmc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730900240;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g58jj5g36ijnF7hh32dzprjYDPypYPMjByIDbTAl0jE=;
	b=bUBEoRY38V5WI8T9wIaIRoaHGy3BJG/+vmgbEVvlEPLcnQwrDjOmSVPvgWOktdHezqnBz0
	e5OoNa3DDHkT9hAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E2601137C4;
	Wed,  6 Nov 2024 13:37:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Z8I+Nw9xK2e+JgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 06 Nov 2024 13:37:19 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 8E478A0AFB; Wed,  6 Nov 2024 14:37:15 +0100 (CET)
Date: Wed, 6 Nov 2024 14:37:15 +0100
From: Jan Kara <jack@suse.cz>
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: add the ability for statmount() to report the
 fs_subtype
Message-ID: <20241106133715.ellv3pf7ekz34fmi@quack3>
References: <20241106-statmount-v1-1-b93bafd97621@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106-statmount-v1-1-b93bafd97621@kernel.org>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed 06-11-24 08:29:19, Jeff Layton wrote:
> /proc/self/mountinfo prints out the sb->s_subtype after the type. In
> particular, FUSE makes use of this to display the fstype as
> fuse.<subtype>.
> 
> Add STATMOUNT_FS_SUBTYPE and claim one of the __spare2 fields to point
> to the offset into the str[] array. The STATMOUNT_FS_SUBTYPE will only
> be set in the return mask if there is a subtype associated with the
> mount.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good to me. I'm just curious: Do you have any particular user that is
interested in getting subtype from statmount(2)?

								Honza

> ---
>  fs/namespace.c             | 20 +++++++++++++++++++-
>  include/uapi/linux/mount.h |  5 ++++-
>  2 files changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index ba77ce1c6788dfe461814b5826fcbb3aab68fad4..5f2fb692449a9c0a15b60549fb9f7bedd10f1f3d 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -5006,6 +5006,14 @@ static int statmount_fs_type(struct kstatmount *s, struct seq_file *seq)
>  	return 0;
>  }
>  
> +static int statmount_fs_subtype(struct kstatmount *s, struct seq_file *seq)
> +{
> +	struct super_block *sb = s->mnt->mnt_sb;
> +
> +	seq_puts(seq, sb->s_subtype);
> +	return 0;
> +}
> +
>  static void statmount_mnt_ns_id(struct kstatmount *s, struct mnt_namespace *ns)
>  {
>  	s->sm.mask |= STATMOUNT_MNT_NS_ID;
> @@ -5064,6 +5072,13 @@ static int statmount_string(struct kstatmount *s, u64 flag)
>  		sm->mnt_opts = seq->count;
>  		ret = statmount_mnt_opts(s, seq);
>  		break;
> +	case STATMOUNT_FS_SUBTYPE:
> +		/* ignore if no s_subtype */
> +		if (!s->mnt->mnt_sb->s_subtype)
> +			return 0;
> +		sm->fs_subtype = seq->count;
> +		ret = statmount_fs_subtype(s, seq);
> +		break;
>  	default:
>  		WARN_ON_ONCE(true);
>  		return -EINVAL;
> @@ -5203,6 +5218,9 @@ static int do_statmount(struct kstatmount *s, u64 mnt_id, u64 mnt_ns_id,
>  	if (!err && s->mask & STATMOUNT_MNT_OPTS)
>  		err = statmount_string(s, STATMOUNT_MNT_OPTS);
>  
> +	if (!err && s->mask & STATMOUNT_FS_SUBTYPE)
> +		err = statmount_string(s, STATMOUNT_FS_SUBTYPE);
> +
>  	if (!err && s->mask & STATMOUNT_MNT_NS_ID)
>  		statmount_mnt_ns_id(s, ns);
>  
> @@ -5224,7 +5242,7 @@ static inline bool retry_statmount(const long ret, size_t *seq_size)
>  }
>  
>  #define STATMOUNT_STRING_REQ (STATMOUNT_MNT_ROOT | STATMOUNT_MNT_POINT | \
> -			      STATMOUNT_FS_TYPE | STATMOUNT_MNT_OPTS)
> +			      STATMOUNT_FS_TYPE | STATMOUNT_MNT_OPTS | STATMOUNT_FS_SUBTYPE)
>  
>  static int prepare_kstatmount(struct kstatmount *ks, struct mnt_id_req *kreq,
>  			      struct statmount __user *buf, size_t bufsize,
> diff --git a/include/uapi/linux/mount.h b/include/uapi/linux/mount.h
> index 225bc366ffcbf0319929e2f55f1fbea88e4d7b81..fa206fb56b3b25cf80f7d430e1b6bab19c3220e4 100644
> --- a/include/uapi/linux/mount.h
> +++ b/include/uapi/linux/mount.h
> @@ -173,7 +173,9 @@ struct statmount {
>  	__u32 mnt_root;		/* [str] Root of mount relative to root of fs */
>  	__u32 mnt_point;	/* [str] Mountpoint relative to current root */
>  	__u64 mnt_ns_id;	/* ID of the mount namespace */
> -	__u64 __spare2[49];
> +	__u32 fs_subtype;	/* [str] Subtype of fs_type (if any) */
> +	__u32 __spare1[1];
> +	__u64 __spare2[48];
>  	char str[];		/* Variable size part containing strings */
>  };
>  
> @@ -207,6 +209,7 @@ struct mnt_id_req {
>  #define STATMOUNT_FS_TYPE		0x00000020U	/* Want/got fs_type */
>  #define STATMOUNT_MNT_NS_ID		0x00000040U	/* Want/got mnt_ns_id */
>  #define STATMOUNT_MNT_OPTS		0x00000080U	/* Want/got mnt_opts */
> +#define STATMOUNT_FS_SUBTYPE		0x00000100U	/* Want/got subtype */
>  
>  /*
>   * Special @mnt_id values that can be passed to listmount
> 
> ---
> base-commit: 26213e1a6caa5a7f508b919059b0122b451f4dfe
> change-id: 20241106-statmount-3f91a7ed75fa
> 
> Best regards,
> -- 
> Jeff Layton <jlayton@kernel.org>
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

