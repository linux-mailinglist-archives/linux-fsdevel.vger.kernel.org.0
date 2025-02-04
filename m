Return-Path: <linux-fsdevel+bounces-40716-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0919DA26FDA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 12:07:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 858733A3709
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 11:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6B920C039;
	Tue,  4 Feb 2025 11:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JNFPsGc4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B349D20C023;
	Tue,  4 Feb 2025 11:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738667231; cv=none; b=nroRHPVbF0MymKJLA9G7pMy3KaAfgHr2jAgJU8sTLiFIr+Hk4Xo4H0KJyg9ZLIvXoQPDSlZtR14/4OarVeuXxASwf8H0BWsSaj8npnAPQyK8KGBeJq8SLJiEhy0VV+bPzjwW9Hv6OFEr2UbAOydoROnIvUeMdokgoMW5US+FslI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738667231; c=relaxed/simple;
	bh=/a1vjRug4eEHgIbViy+e0gswtpaybLO0+wjnrNzUGOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ca9WPUskQekZFFR1Q0f7sV+DRTGOB1SiNFMw3aeF7eRE/OyEXQKQc3U7aT+RSuPpO2mz3q3MdQIx8XXWQKPmJz3EEP7ROeiF+/l7p1niicLYMgcdIZWhRovrMFFakqSYufBkCblk3vHUV3r3jPZwUMzovQKkyio7ezzKya/IHF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JNFPsGc4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FB7BC4CEE2;
	Tue,  4 Feb 2025 11:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738667231;
	bh=/a1vjRug4eEHgIbViy+e0gswtpaybLO0+wjnrNzUGOw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JNFPsGc4T5WYW28ec3MGV60N3cWIXDmTJnBlnWFzMRvMtBsDtACnvKKopfS8h9E39
	 fpmuegneaILXhMYzo3KYOFiesOIsYfCe3QM/znFoGOPuwV0/eoR6qbVP265WPQbr3Y
	 dM0Umjc/l4MewOoVw4tarQk1xipjSooSsdbgTvT5LltOKNllHSWaikMtHfFPhNheeb
	 h5N6Pf7+F6k+AdEs7nOmeABrLl+gS2rYHhgDWYkAv3JqyrsjvE9EBbqxdbP+5o29do
	 /sbGhWGk+4CFbw+fJalRNGJhDGJoUTDXcKR3kwWRf/9rDk/AqI9PRPPjlGK82kSn+D
	 u521ku/EEJFcg==
Date: Tue, 4 Feb 2025 12:07:06 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] statmount: add a new supported_mask field
Message-ID: <20250204-stengel-lodern-8e6ce624cf77@brauner>
References: <20250203-statmount-v1-1-871fa7e61f69@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250203-statmount-v1-1-871fa7e61f69@kernel.org>

On Mon, Feb 03, 2025 at 12:09:48PM -0500, Jeff Layton wrote:
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

Hm, do we need a separate bit for STATMOUNT_SUPPORTED_MASK? Afaiu, this
is more of a convenience thing but then maybe we just do:

#define STATMOUNT_SUPPORTED_MASK STATMOUNT_MNT_BASIC

and be done with it?

Otherwise I think it is worth having support for this.

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

