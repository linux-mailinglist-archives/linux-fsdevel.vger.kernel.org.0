Return-Path: <linux-fsdevel+bounces-11187-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF27851EAF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 21:31:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FE6C1F22FBA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 20:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FAC61EB3D;
	Mon, 12 Feb 2024 20:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K37EeqSz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1268A1EA78
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 20:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707769879; cv=none; b=C+HpXOBLOgERvKyuglBSpmHT7bijyzvh33s3do7o5ZBx7TCi6TkxvEQ3xIKVR1eL7ilO7+T/VekZpAWWh65FO+DbejnW52yAGfANKgex5rtHRbjj36/2JrBzWzzm4CZHClsjfUXgBwE521zTNO+3Lh54vSQe9VnyP2QmJF+Bnus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707769879; c=relaxed/simple;
	bh=qOp4mJSDugxvSyT3atCGWs2GDYtIKZTeCj2zEcb71Y4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=IKPHBvw8etNuhva+iMYJPwxZR9mVmIW05Abch6nXL3N50VigvL41Ic1xDISybUsCWrCSaig2lfeN5q3bDWtyorILdhQUDlG1MhtBAukD16cltFWD0oyaefcY0tS7UABI5inAlYwrOXvmYbpGDN2ivRDeASTVRn0mh4UDOv2e7FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K37EeqSz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707769875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D3H0vrP2FTidiK65VLlIw70duaMJhS1BeFRsB+zgkXk=;
	b=K37EeqSz3VznLTUz2cc4csxmsjYgI3hZ8cjIyZyP5uVNZX3gWWwMhsTdKnYnYeoM/oIx1s
	ucPfvp9yNxbsI+mKwMPw/ewu4uqhBgTGKgFI2qEn9iM7AlEnv+D1c86NUe0bd1yK1wLpqn
	c/ziH3fNLW8xxGyd2dvFP+rjks0J98o=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-GDArDQidOcyQs8jqdpu79w-1; Mon, 12 Feb 2024 15:31:14 -0500
X-MC-Unique: GDArDQidOcyQs8jqdpu79w-1
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-363b68b9af3so30637325ab.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 12:31:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707769872; x=1708374672;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D3H0vrP2FTidiK65VLlIw70duaMJhS1BeFRsB+zgkXk=;
        b=QYZdDxD/hlQOnxzCr5ETVO1iGkvANeC+rLfmgT/HIDNhQ5lZxZtt53LZk02XWywqON
         gzKgMzglEqHuVtCMBHVZwzA+I9mbmzT7zlJmkSUfEDI2wt6hAglaSgrZ5afYPDVvVliD
         tWcr+h6SiacG9FEa5OhoiqJ6x2edq5ggPGw+KF2hfVdgFCWdNC/bg4DD7Hv796AU/jsF
         4+I3PHY1Y/uD/avlih9uBJCouQRWrgTgMi7U1gKr0f8xMlvp71gOInwMnRdY46YRWILs
         0D0d4TAdWtqYrYnjbR/ymEfM9gYu3yTo2sPjdcUHCgyZ30IN8jASdgxOKq+qD85oa29Q
         Xgiw==
X-Gm-Message-State: AOJu0Yy/0fi6YO1RydBKAR6lLo9WLdWc4Mnzz9SUY5hDWsIUpyOTXGvB
	5jG/Q9xG2hICkyO5spmKX1AfYUS00Wj95nmdTKisQFJNYBhAuQv/YMY8IzfX1R82fixesuQRNwK
	peRiIOPxCo02cemca+U177oFkY25RA0ti+KDZjmIQE8VqRd0TFgFdGHdXsX/fmvtO50kU93xKaQ
	wKZD5t/yjmrpgbYJqIlZc5/oc6r6K+mzeY7JTxVE1I441Pqw==
X-Received: by 2002:a92:c90d:0:b0:363:c919:2713 with SMTP id t13-20020a92c90d000000b00363c9192713mr10184992ilp.22.1707769872628;
        Mon, 12 Feb 2024 12:31:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE/n4ShZIaaZuCJiPlgYLEbN0u8oWOKNdubqsQrtVHzPsb1E3BC29lfp7FOZD2TpsKJGnUHVQ==
X-Received: by 2002:a92:c90d:0:b0:363:c919:2713 with SMTP id t13-20020a92c90d000000b00363c9192713mr10184973ilp.22.1707769872284;
        Mon, 12 Feb 2024 12:31:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVk7m4RRXnHMNq8SyQtXDx1VXxqm9RQNK0vvDTIZZQseuoYFOy9IK/8LWWhF/6BDyMgrekrHEBJQUut1NAfpZk7CfqDNKY7IVPWW5NlTkj9GyJckmOLslA=
Received: from [10.0.0.71] (sandeen.net. [63.231.237.45])
        by smtp.gmail.com with ESMTPSA id bm17-20020a056e02331100b00363c5391adbsm2089035ilb.77.2024.02.12.12.31.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 12:31:11 -0800 (PST)
Message-ID: <1adcfcc9-5ac8-4a53-a6a5-e8b9b41a9a83@redhat.com>
Date: Mon, 12 Feb 2024 14:31:10 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] udf: convert to new mount API
Content-Language: en-US
From: Eric Sandeen <sandeen@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>, Bill O'Donnell <billodo@redhat.com>,
 David Howells <dhowells@redhat.com>
References: <739fe39a-0401-4f5d-aef7-759ef82b36bd@redhat.com>
In-Reply-To: <739fe39a-0401-4f5d-aef7-759ef82b36bd@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/9/24 1:43 PM, Eric Sandeen wrote:
> Convert the UDF filesystem to the new mount API.
> 
> UDF is slightly unique in that it always preserves prior mount
> options across a remount, so that's handled by udf_init_options().
> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> ---
> 
> Tested by running through xfstests, as well as some targeted testing of
> remount behavior.
> 
> NB: I did not convert i.e any udf_err() to errorf(fc, ) because the former
> does some nice formatting, not sure how or if you'd like to handle that, Jan?
> 
>  fs/udf/super.c | 495 +++++++++++++++++++++++++------------------------
>  1 file changed, 255 insertions(+), 240 deletions(-)
> 
> diff --git a/fs/udf/super.c b/fs/udf/super.c
> index 928a04d9d9e0..03fa98fe4e1c 100644
> --- a/fs/udf/super.c
> +++ b/fs/udf/super.c

...

> +	case Opt_gid:
> +		if (0 == kstrtoint(param->string, 10, &uv)) {
>  			uopt->gid = make_kgid(current_user_ns(), uv);
>  			if (!gid_valid(uopt->gid))
> -				return 0;
> +				return -EINVAL;
>  			uopt->flags |= (1 <<  );
> -			break;
> -		case Opt_uid:
> -			if (match_uint(args, &uv))
> -				return 0;
> +		} else if (!strcmp(param->string, "forget")) {
> +			uopt->flags |= (1 << UDF_FLAG_GID_FORGET);
> +		} else if (!strcmp(param->string, "ignore")) {
> +			/* this option is superseded by gid=<number> */
> +			;
> +		} else {
> +			return -EINVAL;
> +		}
> +		break;

I wonder if I need to redo this and not directly set the make_kgid option
into uopt->gid. We do test that uopt->gid is valid, and return an error, and
skip setting UDF_FLAG_GID_SET, but ...

...

> -static int udf_fill_super(struct super_block *sb, void *options, int silent)
> +static int udf_fill_super(struct super_block *sb, struct fs_context *fc)
>  {
>  	int ret = -EINVAL;
>  	struct inode *inode = NULL;
> -	struct udf_options uopt;
> +	struct udf_options *uopt = fc->fs_private;
>  	struct kernel_lb_addr rootdir, fileset;
>  	struct udf_sb_info *sbi;
>  	bool lvid_open = false;
> -
> -	uopt.flags = (1 << UDF_FLAG_USE_AD_IN_ICB) | (1 << UDF_FLAG_STRICT);
> -	/* By default we'll use overflow[ug]id when UDF inode [ug]id == -1 */
> -	uopt.uid = make_kuid(current_user_ns(), overflowuid);
> -	uopt.gid = make_kgid(current_user_ns(), overflowgid);

this initialization (now moved to udf_init_options) gets overwritten
even if the [gu]id was invalid during parsing ...

> +	sbi->s_flags = uopt->flags;
> +	sbi->s_uid = uopt->uid;
> +	sbi->s_gid = uopt->gid;

... and gets set into sbi here.

In the past (I think) the whole mount would fail with an invalid UID/GID but w/
fsconfig, we could just fail that one config and continue with the rest.

It looks like sbi->s_[gu]id is not accessed unless UDF_FLAG_[GU]ID_SET is
set, but maybe it's best to never set something invalid into the uopt.

-Eric


