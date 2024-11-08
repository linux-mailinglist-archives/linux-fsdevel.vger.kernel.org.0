Return-Path: <linux-fsdevel+bounces-34010-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC16E9C1CCF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 13:19:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 055A1B23EF0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 12:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB8A1E765D;
	Fri,  8 Nov 2024 12:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1vbpz20R";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rqXaYKXq";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1vbpz20R";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rqXaYKXq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103DA1E47CC;
	Fri,  8 Nov 2024 12:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731068377; cv=none; b=bkaK4ZrGJf1iuWFrfdhe/Y3O5bTZTCzOfBzV3VYcUbTTkkw2i5eTgNfhY9aEo5sXjDwPLYSXhZcu+OMYCN/gm7gpzCH1uAOUWYakHtM8nIglRBtsOx2DJJwxBYVNBidlathi7FS69xmp6Dw0oX/Rx4IWrRFK8SC1lrWjr4moWNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731068377; c=relaxed/simple;
	bh=gHx4tR0MwDHCyzkkwKN9uNUatqqrwQXZXAQfjOsWzrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qYki7wQuRaVEmsdwejdGBkNQDIbNGTkdBTJm0qK33m24jbq/inZTEPsVDYMabpGO5BcJwKDmrgJMm2eQEPfyv+OarKHcspPmKKMz4apwPPfGI1uDf6vtiuPTw2z8aSoAIQLYWwt0+a2Uk+hl1SFCy9uaKmV33DklJAIDC6me9fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1vbpz20R; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rqXaYKXq; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1vbpz20R; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rqXaYKXq; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 171171F7C0;
	Fri,  8 Nov 2024 12:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731068373; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=amlv9P1NqNSBXdYqjoETOD88IPj0Jmi+jmRTQKmjb94=;
	b=1vbpz20RiTMnkrUttWhIaa0BFR11gEFrrUWUvd7H4Tyw8OBmtuEiyjUbBtYEaAYLp6OuBq
	JAQ8udWgLtWp2DwyANZ/rgwAgzlya/JLvHlpFYd+SjYVQHdO20CTDZuGPmfUIHe5QiGA1O
	NbNNpU/H0+C/HkxGQFItbmsjW1rX1jc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731068373;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=amlv9P1NqNSBXdYqjoETOD88IPj0Jmi+jmRTQKmjb94=;
	b=rqXaYKXqN4PseocRsK8OSuQyCuFe7dFvff93rCfo2YQBpDhrOWzZCT1obdGtnoGuCTgO2T
	OWJ/RL/OzBs4xVAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=1vbpz20R;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=rqXaYKXq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731068373; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=amlv9P1NqNSBXdYqjoETOD88IPj0Jmi+jmRTQKmjb94=;
	b=1vbpz20RiTMnkrUttWhIaa0BFR11gEFrrUWUvd7H4Tyw8OBmtuEiyjUbBtYEaAYLp6OuBq
	JAQ8udWgLtWp2DwyANZ/rgwAgzlya/JLvHlpFYd+SjYVQHdO20CTDZuGPmfUIHe5QiGA1O
	NbNNpU/H0+C/HkxGQFItbmsjW1rX1jc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731068373;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=amlv9P1NqNSBXdYqjoETOD88IPj0Jmi+jmRTQKmjb94=;
	b=rqXaYKXqN4PseocRsK8OSuQyCuFe7dFvff93rCfo2YQBpDhrOWzZCT1obdGtnoGuCTgO2T
	OWJ/RL/OzBs4xVAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0143613967;
	Fri,  8 Nov 2024 12:19:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rHpIANUBLmccWgAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 08 Nov 2024 12:19:33 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B201FA0AF4; Fri,  8 Nov 2024 13:19:32 +0100 (CET)
Date: Fri, 8 Nov 2024 13:19:32 +0100
From: Jan Kara <jack@suse.cz>
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Miklos Szeredi <miklos@szeredi.hu>, Ian Kent <raven@themaw.net>,
	Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] fs: add the ability for statmount() to report the
 mnt_devname
Message-ID: <20241108121932.mbtyofqtkbxao7vc@quack3>
References: <20241107-statmount-v3-0-da5b9744c121@kernel.org>
 <20241107-statmount-v3-2-da5b9744c121@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107-statmount-v3-2-da5b9744c121@kernel.org>
X-Rspamd-Queue-Id: 171171F7C0
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Thu 07-11-24 16:00:07, Jeff Layton wrote:
> /proc/self/mountinfo displays the devicename for the mount, but
> statmount() doesn't yet have a way to return it. Add a new
> STATMOUNT_MNT_DEVNAME flag, claim the 32-bit __spare1 field to hold the
> offset into the str[] array. STATMOUNT_MNT_DEVNAME will only be set in
> the return mask if there is a device string.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/namespace.c             | 36 +++++++++++++++++++++++++++++++++++-
>  include/uapi/linux/mount.h |  3 ++-
>  2 files changed, 37 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index fc4f81891d544305caf863904c0a6e16562fab49..56750fcc890271e22b3b722dc0b4af445686bb86 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -5014,6 +5014,32 @@ static void statmount_fs_subtype(struct kstatmount *s, struct seq_file *seq)
>  		seq_puts(seq, sb->s_subtype);
>  }
>  
> +static int statmount_mnt_devname(struct kstatmount *s, struct seq_file *seq)
> +{
> +	struct super_block *sb = s->mnt->mnt_sb;
> +	struct mount *r = real_mount(s->mnt);
> +
> +	if (sb->s_op->show_devname) {
> +		size_t start = seq->count;
> +		int ret;
> +
> +		ret = sb->s_op->show_devname(seq, s->mnt->mnt_root);
> +		if (ret)
> +			return ret;
> +
> +		if (unlikely(seq_has_overflowed(seq)))
> +			return -EAGAIN;
> +
> +		/* Unescape the result */
> +		seq->buf[seq->count] = '\0';
> +		seq->count = start;
> +		seq_commit(seq, string_unescape_inplace(seq->buf + start, UNESCAPE_OCTAL));
> +	} else if (r->mnt_devname) {
> +		seq_puts(seq, r->mnt_devname);
> +	}
> +	return 0;
> +}
> +
>  static void statmount_mnt_ns_id(struct kstatmount *s, struct mnt_namespace *ns)
>  {
>  	s->sm.mask |= STATMOUNT_MNT_NS_ID;
> @@ -5077,6 +5103,10 @@ static int statmount_string(struct kstatmount *s, u64 flag)
>  		sm->fs_subtype = start;
>  		statmount_fs_subtype(s, seq);
>  		break;
> +	case STATMOUNT_MNT_DEVNAME:
> +		sm->mnt_devname = seq->count;
> +		ret = statmount_mnt_devname(s, seq);
> +		break;
>  	default:
>  		WARN_ON_ONCE(true);
>  		return -EINVAL;
> @@ -5225,6 +5255,9 @@ static int do_statmount(struct kstatmount *s, u64 mnt_id, u64 mnt_ns_id,
>  	if (!err && s->mask & STATMOUNT_FS_SUBTYPE)
>  		err = statmount_string(s, STATMOUNT_FS_SUBTYPE);
>  
> +	if (!err && s->mask & STATMOUNT_MNT_DEVNAME)
> +		err = statmount_string(s, STATMOUNT_MNT_DEVNAME);
> +
>  	if (!err && s->mask & STATMOUNT_MNT_NS_ID)
>  		statmount_mnt_ns_id(s, ns);
>  
> @@ -5246,7 +5279,8 @@ static inline bool retry_statmount(const long ret, size_t *seq_size)
>  }
>  
>  #define STATMOUNT_STRING_REQ (STATMOUNT_MNT_ROOT | STATMOUNT_MNT_POINT | \
> -			      STATMOUNT_FS_TYPE | STATMOUNT_MNT_OPTS | STATMOUNT_FS_SUBTYPE)
> +			      STATMOUNT_FS_TYPE | STATMOUNT_MNT_OPTS | \
> +			      STATMOUNT_FS_SUBTYPE | STATMOUNT_MNT_DEVNAME)
>  
>  static int prepare_kstatmount(struct kstatmount *ks, struct mnt_id_req *kreq,
>  			      struct statmount __user *buf, size_t bufsize,
> diff --git a/include/uapi/linux/mount.h b/include/uapi/linux/mount.h
> index 2e939dddf9cbabe574dafdb6cff9ad4cf9298a74..3de1b0231b639fb8ed739d65b5b5406021f74196 100644
> --- a/include/uapi/linux/mount.h
> +++ b/include/uapi/linux/mount.h
> @@ -174,7 +174,7 @@ struct statmount {
>  	__u32 mnt_point;	/* [str] Mountpoint relative to current root */
>  	__u64 mnt_ns_id;	/* ID of the mount namespace */
>  	__u32 fs_subtype;	/* [str] Subtype of fs_type (if any) */
> -	__u32 __spare1[1];
> +	__u32 mnt_devname;	/* [str] Device string for the mount */
>  	__u64 __spare2[48];
>  	char str[];		/* Variable size part containing strings */
>  };
> @@ -210,6 +210,7 @@ struct mnt_id_req {
>  #define STATMOUNT_MNT_NS_ID		0x00000040U	/* Want/got mnt_ns_id */
>  #define STATMOUNT_MNT_OPTS		0x00000080U	/* Want/got mnt_opts */
>  #define STATMOUNT_FS_SUBTYPE		0x00000100U	/* Want/got fs_subtype */
> +#define STATMOUNT_MNT_DEVNAME		0x00000200U	/* Want/got mnt_devname */
>  
>  /*
>   * Special @mnt_id values that can be passed to listmount
> 
> -- 
> 2.47.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

