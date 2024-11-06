Return-Path: <linux-fsdevel+bounces-33839-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BED7A9BF9CF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 00:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 293A2283F76
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 23:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E9E20D502;
	Wed,  6 Nov 2024 23:15:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp01.aussiebb.com.au (smtp01.aussiebb.com.au [121.200.0.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4885120CCFA;
	Wed,  6 Nov 2024 23:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.200.0.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730934907; cv=none; b=p4ZvTrhjQNESZi5xLjiWJ9voE9sqWTDnGM4BMwipBOiaqdJ63QQYKwYZINCZEhU12hXT05KtItshwyJPVb49wszMdZVvINwhj3f91Huvr2zzk68PgAmA4GVNlXeioWZPzW3T1+8WYsOImAqeeB+FmCVSYqpmd6mMxuRjP6jwOic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730934907; c=relaxed/simple;
	bh=7x8W7zDJDfLW0wpw3iU1qYypD7Pzz3qtxmL1PtCAevE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mljnx9hebcnwBF6xtRtAcNK1xTvtqpH48itEHopStr+zbnxDAPRwcdhizzN58U65tFtDLqLiWNpj/z+iiM8BsR/L0OhHc//B16SWCwcNkeOOWs9gRHBKLBdtsdsuLjwkXNVGJ/39jkRCfHcLwvWAOh1NGNDk/5wYYnBJKEO/yKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=themaw.net; spf=fail smtp.mailfrom=themaw.net; arc=none smtp.client-ip=121.200.0.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=themaw.net
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp01.aussiebb.com.au (Postfix) with ESMTP id 922CB1005B8;
	Thu,  7 Nov 2024 10:07:27 +1100 (AEDT)
X-Virus-Scanned: Debian amavisd-new at smtp01.aussiebb.com.au
Received: from smtp01.aussiebb.com.au ([127.0.0.1])
	by localhost (smtp01.aussiebb.com.au [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id j-tMYkQY1GcY; Thu,  7 Nov 2024 10:07:27 +1100 (AEDT)
Received: by smtp01.aussiebb.com.au (Postfix, from userid 116)
	id 7E6931003C2; Thu,  7 Nov 2024 10:07:27 +1100 (AEDT)
X-Spam-Level: 
Received: from [192.168.1.229] (159-196-82-144.9fc452.per.static.aussiebb.net [159.196.82.144])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: ian146@aussiebb.com.au)
	by smtp01.aussiebb.com.au (Postfix) with ESMTPSA id 1A99610039F;
	Thu,  7 Nov 2024 10:07:25 +1100 (AEDT)
Message-ID: <782d2777-267e-4669-9e03-fd664a4a7022@themaw.net>
Date: Thu, 7 Nov 2024 07:07:24 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: add the ability for statmount() to report the
 fs_subtype
To: Jeff Layton <jlayton@kernel.org>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241106-statmount-v1-1-b93bafd97621@kernel.org>
Content-Language: en-US
From: Ian Kent <raven@themaw.net>
Autocrypt: addr=raven@themaw.net; keydata=
 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
In-Reply-To: <20241106-statmount-v1-1-b93bafd97621@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/11/24 21:29, Jeff Layton wrote:
> /proc/self/mountinfo prints out the sb->s_subtype after the type. In
> particular, FUSE makes use of this to display the fstype as
> fuse.<subtype>.
>
> Add STATMOUNT_FS_SUBTYPE and claim one of the __spare2 fields to point
> to the offset into the str[] array. The STATMOUNT_FS_SUBTYPE will only
> be set in the return mask if there is a subtype associated with the

Looks ok to me too.

Reviewed-by: Ian Kent <raven@themaw.net>


Ian

> mount.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>   fs/namespace.c             | 20 +++++++++++++++++++-
>   include/uapi/linux/mount.h |  5 ++++-
>   2 files changed, 23 insertions(+), 2 deletions(-)
>
> diff --git a/fs/namespace.c b/fs/namespace.c
> index ba77ce1c6788dfe461814b5826fcbb3aab68fad4..5f2fb692449a9c0a15b60549fb9f7bedd10f1f3d 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -5006,6 +5006,14 @@ static int statmount_fs_type(struct kstatmount *s, struct seq_file *seq)
>   	return 0;
>   }
>   
> +static int statmount_fs_subtype(struct kstatmount *s, struct seq_file *seq)
> +{
> +	struct super_block *sb = s->mnt->mnt_sb;
> +
> +	seq_puts(seq, sb->s_subtype);
> +	return 0;
> +}
> +
>   static void statmount_mnt_ns_id(struct kstatmount *s, struct mnt_namespace *ns)
>   {
>   	s->sm.mask |= STATMOUNT_MNT_NS_ID;
> @@ -5064,6 +5072,13 @@ static int statmount_string(struct kstatmount *s, u64 flag)
>   		sm->mnt_opts = seq->count;
>   		ret = statmount_mnt_opts(s, seq);
>   		break;
> +	case STATMOUNT_FS_SUBTYPE:
> +		/* ignore if no s_subtype */
> +		if (!s->mnt->mnt_sb->s_subtype)
> +			return 0;
> +		sm->fs_subtype = seq->count;
> +		ret = statmount_fs_subtype(s, seq);
> +		break;
>   	default:
>   		WARN_ON_ONCE(true);
>   		return -EINVAL;
> @@ -5203,6 +5218,9 @@ static int do_statmount(struct kstatmount *s, u64 mnt_id, u64 mnt_ns_id,
>   	if (!err && s->mask & STATMOUNT_MNT_OPTS)
>   		err = statmount_string(s, STATMOUNT_MNT_OPTS);
>   
> +	if (!err && s->mask & STATMOUNT_FS_SUBTYPE)
> +		err = statmount_string(s, STATMOUNT_FS_SUBTYPE);
> +
>   	if (!err && s->mask & STATMOUNT_MNT_NS_ID)
>   		statmount_mnt_ns_id(s, ns);
>   
> @@ -5224,7 +5242,7 @@ static inline bool retry_statmount(const long ret, size_t *seq_size)
>   }
>   
>   #define STATMOUNT_STRING_REQ (STATMOUNT_MNT_ROOT | STATMOUNT_MNT_POINT | \
> -			      STATMOUNT_FS_TYPE | STATMOUNT_MNT_OPTS)
> +			      STATMOUNT_FS_TYPE | STATMOUNT_MNT_OPTS | STATMOUNT_FS_SUBTYPE)
>   
>   static int prepare_kstatmount(struct kstatmount *ks, struct mnt_id_req *kreq,
>   			      struct statmount __user *buf, size_t bufsize,
> diff --git a/include/uapi/linux/mount.h b/include/uapi/linux/mount.h
> index 225bc366ffcbf0319929e2f55f1fbea88e4d7b81..fa206fb56b3b25cf80f7d430e1b6bab19c3220e4 100644
> --- a/include/uapi/linux/mount.h
> +++ b/include/uapi/linux/mount.h
> @@ -173,7 +173,9 @@ struct statmount {
>   	__u32 mnt_root;		/* [str] Root of mount relative to root of fs */
>   	__u32 mnt_point;	/* [str] Mountpoint relative to current root */
>   	__u64 mnt_ns_id;	/* ID of the mount namespace */
> -	__u64 __spare2[49];
> +	__u32 fs_subtype;	/* [str] Subtype of fs_type (if any) */
> +	__u32 __spare1[1];
> +	__u64 __spare2[48];
>   	char str[];		/* Variable size part containing strings */
>   };
>   
> @@ -207,6 +209,7 @@ struct mnt_id_req {
>   #define STATMOUNT_FS_TYPE		0x00000020U	/* Want/got fs_type */
>   #define STATMOUNT_MNT_NS_ID		0x00000040U	/* Want/got mnt_ns_id */
>   #define STATMOUNT_MNT_OPTS		0x00000080U	/* Want/got mnt_opts */
> +#define STATMOUNT_FS_SUBTYPE		0x00000100U	/* Want/got subtype */
>   
>   /*
>    * Special @mnt_id values that can be passed to listmount
>
> ---
> base-commit: 26213e1a6caa5a7f508b919059b0122b451f4dfe
> change-id: 20241106-statmount-3f91a7ed75fa
>
> Best regards,

