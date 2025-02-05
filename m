Return-Path: <linux-fsdevel+bounces-40945-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6729A29717
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 18:18:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E75143A672E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 17:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71AC1E1C2B;
	Wed,  5 Feb 2025 17:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dm1wONyR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qe0u9+mz";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dm1wONyR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qe0u9+mz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBB14A28;
	Wed,  5 Feb 2025 17:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738775898; cv=none; b=HEmwJJyQKpsC6ImPucOsJRfbDPW81hN64GPKquTUbsMUg84Y9An0bt4mL+2/LBxjZbZ7nDz2D/VGqTdaTA7R6spUbP+lN4ruYUXFkTNolNWWj8YmSGEvhDop5zP7jRb9m50yQ1AxpD56BJGIJWs4f2zDS3ua38LHWzcEYCNhitg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738775898; c=relaxed/simple;
	bh=ONGqUG+q+iAhcaE+kEQU8rVHmKl/sHumSQKbml29d3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ejBDon4PNcIxjuac8FKAK1sNIAdM6NKYZ2jxTQviuMB5SOH/SnviI8a9cdi9v0XQU18DT7Mb0yi3Q8D6FHIdzl69ZDe51Chyh+vr6C/9Q0T9RFzYft3Ru4LH8dF9qI97OOEstqVhB1QG1Ve8f4/eionZxkQs9q3gO9zVLJnGc/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dm1wONyR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qe0u9+mz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dm1wONyR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qe0u9+mz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4A7CC210FE;
	Wed,  5 Feb 2025 17:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1738775892; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jo14i3mbFWnpu54jM3LqG6e6R4TGD7KmRtaY3I7jXs8=;
	b=dm1wONyR+iP1q77v/HJHFPAwm+Dqp/ihbCCT6pIwMjyPkPiVVyCqR3L7i5ys+HaCknKHt+
	5YFmJueFz9jpLSCryzYmeBwM68M5e+25VvC1s7qADfWbJkRzdBF333Sah9Hmr+t47pmh8q
	VzgikRke2dm97d84SFviS5Szb90bGi8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1738775892;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jo14i3mbFWnpu54jM3LqG6e6R4TGD7KmRtaY3I7jXs8=;
	b=qe0u9+mzjr/y/H66dK63o9T34yHmCE0eSbAAHakUFPh5PLsSGqSWpd61dXLIddZkvMz/Lv
	i9yFvQXZG68lNoDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1738775892; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jo14i3mbFWnpu54jM3LqG6e6R4TGD7KmRtaY3I7jXs8=;
	b=dm1wONyR+iP1q77v/HJHFPAwm+Dqp/ihbCCT6pIwMjyPkPiVVyCqR3L7i5ys+HaCknKHt+
	5YFmJueFz9jpLSCryzYmeBwM68M5e+25VvC1s7qADfWbJkRzdBF333Sah9Hmr+t47pmh8q
	VzgikRke2dm97d84SFviS5Szb90bGi8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1738775892;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jo14i3mbFWnpu54jM3LqG6e6R4TGD7KmRtaY3I7jXs8=;
	b=qe0u9+mzjr/y/H66dK63o9T34yHmCE0eSbAAHakUFPh5PLsSGqSWpd61dXLIddZkvMz/Lv
	i9yFvQXZG68lNoDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3242D139D8;
	Wed,  5 Feb 2025 17:18:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RY1ADFSdo2cyRgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 05 Feb 2025 17:18:12 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 9C4D0A28E9; Wed,  5 Feb 2025 18:18:11 +0100 (CET)
Date: Wed, 5 Feb 2025 18:18:11 +0100
From: Jan Kara <jack@suse.cz>
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] statmount: add a new supported_mask field
Message-ID: <zktqtjenvyte5mr24pr2bt56jekqpwzmmz2qpdwplvxumolsad@mze4l37nqorr>
References: <20250203-statmount-v1-1-871fa7e61f69@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250203-statmount-v1-1-871fa7e61f69@kernel.org>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Spam-Flag: NO
X-Spam-Level: 

On Mon 03-02-25 12:09:48, Jeff Layton wrote:
> Some of the fields in the statmount() reply can be optional. If the
> kernel has nothing to emit in that field, then it doesn't set the flag
> in the reply. This presents a problem: There is currently no way to
> know what mask flags the kernel supports since you can't always count on
> them being in the reply.
> 
> Add a new STATMOUNT_SUPPORTED_MASK flag and field that the kernel can
> set in the reply. Userland can use this to determine if the fields it
> requires from the kernel are supported. This also gives us a way to
> deprecate fields in the future, if that should become necessary.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> I ran into this problem recently. We have a variety of kernels running
> that have varying levels of support of statmount(), and I need to be
> able to fall back to /proc scraping if support for everything isn't
> present. This is difficult currently since statmount() doesn't set the
> flag in the return mask if the field is empty.
> ---
>  fs/namespace.c             | 18 ++++++++++++++++++
>  include/uapi/linux/mount.h |  4 +++-
>  2 files changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index a3ed3f2980cbae6238cda09874e2dac146080eb6..7ec5fc436c4ff300507c4ed71a757f5d75a4d520 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -5317,6 +5317,21 @@ static int grab_requested_root(struct mnt_namespace *ns, struct path *root)
>  	return 0;
>  }
>  
> +/* This must be updated whenever a new flag is added */
> +#define STATMOUNT_SUPPORTED (STATMOUNT_SB_BASIC | \
> +			     STATMOUNT_MNT_BASIC | \
> +			     STATMOUNT_PROPAGATE_FROM | \
> +			     STATMOUNT_MNT_ROOT | \
> +			     STATMOUNT_MNT_POINT | \
> +			     STATMOUNT_FS_TYPE | \
> +			     STATMOUNT_MNT_NS_ID | \
> +			     STATMOUNT_MNT_OPTS | \
> +			     STATMOUNT_FS_SUBTYPE | \
> +			     STATMOUNT_SB_SOURCE | \
> +			     STATMOUNT_OPT_ARRAY | \
> +			     STATMOUNT_OPT_SEC_ARRAY | \
> +			     STATMOUNT_SUPPORTED_MASK)
> +
>  static int do_statmount(struct kstatmount *s, u64 mnt_id, u64 mnt_ns_id,
>  			struct mnt_namespace *ns)
>  {
> @@ -5386,6 +5401,9 @@ static int do_statmount(struct kstatmount *s, u64 mnt_id, u64 mnt_ns_id,
>  	if (!err && s->mask & STATMOUNT_MNT_NS_ID)
>  		statmount_mnt_ns_id(s, ns);
>  
> +	if (!err && s->mask & STATMOUNT_SUPPORTED_MASK)
> +		s->sm.supported_mask = STATMOUNT_SUPPORTED_MASK;
					^^^^ STATMOUNT_SUPPORTED here?

Otherwise the patch looks good to me so with this fixed feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

We could possibly also add:
	WARN_ON_ONCE(~s->sm.supported_mask & s->sm.mask);

to catch when we return feature that's not in supported mask. But maybe
that's a paranoia :).


								Honza


> +
>  	if (err)
>  		return err;
>  
> diff --git a/include/uapi/linux/mount.h b/include/uapi/linux/mount.h
> index c07008816acae89cbea3087caf50d537d4e78298..c553dc4ba68407ee38c27238e9bdec2ebf5e2457 100644
> --- a/include/uapi/linux/mount.h
> +++ b/include/uapi/linux/mount.h
> @@ -179,7 +179,8 @@ struct statmount {
>  	__u32 opt_array;	/* [str] Array of nul terminated fs options */
>  	__u32 opt_sec_num;	/* Number of security options */
>  	__u32 opt_sec_array;	/* [str] Array of nul terminated security options */
> -	__u64 __spare2[46];
> +	__u64 supported_mask;	/* Mask flags that this kernel supports */
> +	__u64 __spare2[45];
>  	char str[];		/* Variable size part containing strings */
>  };
>  
> @@ -217,6 +218,7 @@ struct mnt_id_req {
>  #define STATMOUNT_SB_SOURCE		0x00000200U	/* Want/got sb_source */
>  #define STATMOUNT_OPT_ARRAY		0x00000400U	/* Want/got opt_... */
>  #define STATMOUNT_OPT_SEC_ARRAY		0x00000800U	/* Want/got opt_sec... */
> +#define STATMOUNT_SUPPORTED_MASK	0x00001000U	/* Want/got supported mask flags */
>  
>  /*
>   * Special @mnt_id values that can be passed to listmount
> 
> ---
> base-commit: 57c64cb6ddfb6c79a6c3fc2e434303c40f700964
> change-id: 20250203-statmount-f7da9bec0f23
> 
> Best regards,
> -- 
> Jeff Layton <jlayton@kernel.org>
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

