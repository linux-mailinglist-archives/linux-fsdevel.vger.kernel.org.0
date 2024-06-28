Return-Path: <linux-fsdevel+bounces-22736-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A2D91B73F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 08:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57A501F26430
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 06:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA8D7E785;
	Fri, 28 Jun 2024 06:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CS3cNvgU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0026F6F307
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Jun 2024 06:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719557020; cv=none; b=ZdKtD6cVoGfnfU1kRw0QC9aMavPh7yJYAOeGAAHGlPbuIAHZwjMmC2c13i7wrY2H222NSAqy1ZJeqO2e3pw/4jQrb1zxTJinjIAgYwFVQ9iW3q/pETPDdkhuASGGdgE4/uFnYE/Jf0qzeCifmxODqDrHx6OqvBAG6Q4wXz3pnRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719557020; c=relaxed/simple;
	bh=Ce7CEVoaehQ/bp37iTo1AOM+BXLc6RwH8ytdYJoG+NM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fKCqbZJ2vUaWua77XHQuuLqvkBjfaLRC2RPJbYPD1k1u0UyxxgNAEqu4d+gGhj5NCGfArbjX5EUhDPiyoWkeiAwAP7wiSu5S/7CwL5i5dycwsPDz0tzdbJTTftBpKsDPVDFNWmsVpH6sgvq5m2AiiFr9NXL5yNZS6BRr/wjLSIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CS3cNvgU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719557017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JA92iDTxg7ZGdgqnexZQs3R0PhWS/AujUlpBCBf22ds=;
	b=CS3cNvgUr9+5aw2zwNPrjLGCGGOLj2oMa5S4CCnX0VKvgvqhN7f0pFvUYSkqY84qmfh4Yi
	I0VXclZ9j7mJenoCmRpfoPTeAb3KIrLJIEHoBlTeYgjVqFYjFW1E1CL+f1UMlVXXxStlYn
	b1OlG2jg9a3lMroU735M3YprF6kXFpY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-iJDFINEUOAKnph8L-nGUIg-1; Fri, 28 Jun 2024 02:43:32 -0400
X-MC-Unique: iJDFINEUOAKnph8L-nGUIg-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a7293303843so18033166b.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jun 2024 23:43:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719557012; x=1720161812;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JA92iDTxg7ZGdgqnexZQs3R0PhWS/AujUlpBCBf22ds=;
        b=jOqUk5WR8uSB1jZbbg6ElrpT6jFC/6o62gTrFRDsSrdZH2A6ONZ6gucMkgFrDT82qG
         FJrfI90yKChccwpAu5Csi40MfceLe8gzOq3/D6T5cWZx/armTSEc9Ebn7nEHafudg8P3
         AtNkrL/kwP5pO99FJEMcSgDMv1RZ2UiXIw372Z4zX7R8KwxNq+nqCNWg6gZDG6uccgOe
         YO8oecz7Sg21wIkPDGhH3MnHa98U9F8OIaKXvFil2lTp/SHvYxAAgqYqNoaQUckgn9na
         OphYwjghO4uW+S5WMzXKi6koaOp+0mM6igtu+/JIbcYqDYj5L+O5oeQodzGQgMVZpx9M
         ynVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVm6ULA1+YfIDShrHrPrtGUgcKO5Xyp3AJ8xuNkq+IxRrSyHu9Hirfjx4ecHEMANdC3KLxMarUJRd05GuRivfmfTayBNWCq5R6X5yx9NQ==
X-Gm-Message-State: AOJu0YzfLCOTrxHRV4zL7Db73iDQ8fVV8KDk0L9xEe/qJOLcRLVy6RfF
	KQ5vGXDXtwL887bkiNmnoxis4dnMWktEz/Yu+PJuH78ZrtAuRJLHFT6/RAWSWYj8M26DLiPyJyF
	kVRSJ3/BqOtNhqFiS06CVEuL0iz+xMNTXDRP4NRiZSo9B3lioOl6+xriNazB/4bg=
X-Received: by 2002:a17:906:7d0:b0:a6f:5fc2:fe8b with SMTP id a640c23a62f3a-a7245ccf2damr916356866b.32.1719557011755;
        Thu, 27 Jun 2024 23:43:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkNdycJe7oJDUxCEW5Fzn+UjDhgmPyCEOfxDG5CE4A7GlaNhRXUWCvC3pdyzKvMO/2xH/IeQ==
X-Received: by 2002:a17:906:7d0:b0:a6f:5fc2:fe8b with SMTP id a640c23a62f3a-a7245ccf2damr916356166b.32.1719557011438;
        Thu, 27 Jun 2024 23:43:31 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72aaf18515sm46636966b.16.2024.06.27.23.43.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jun 2024 23:43:30 -0700 (PDT)
Message-ID: <96824bd3-b827-429e-ac6a-2b30bb903cd0@redhat.com>
Date: Fri, 28 Jun 2024 08:43:30 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/14] vboxsf: Convert to new uid/gid option parsing
 helpers
To: Eric Sandeen <sandeen@redhat.com>, linux-fsdevel@vger.kernel.org,
 Christian Brauner <brauner@kernel.org>
References: <8dca3c11-99f4-446d-a291-35c50ed2dc14@redhat.com>
 <58862d35-a026-4866-ab7f-fa09dda8ac1f@redhat.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <58862d35-a026-4866-ab7f-fa09dda8ac1f@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 6/28/24 2:42 AM, Eric Sandeen wrote:
> Convert to new uid/gid option parsing helpers
> 
> From: Eric Sandeen <sandeen@redhat.com>
> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Please feel free to take this upstream through whatever
tree/branch is convenient.

Regards,

Hans

> ---
>  fs/vboxsf/super.c | 16 ++++------------
>  1 file changed, 4 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/vboxsf/super.c b/fs/vboxsf/super.c
> index ffb1d565da39..e95b8a48d8a0 100644
> --- a/fs/vboxsf/super.c
> +++ b/fs/vboxsf/super.c
> @@ -41,8 +41,8 @@ enum  { opt_nls, opt_uid, opt_gid, opt_ttl, opt_dmode, opt_fmode,
>  
>  static const struct fs_parameter_spec vboxsf_fs_parameters[] = {
>  	fsparam_string	("nls",		opt_nls),
> -	fsparam_u32	("uid",		opt_uid),
> -	fsparam_u32	("gid",		opt_gid),
> +	fsparam_uid	("uid",		opt_uid),
> +	fsparam_gid	("gid",		opt_gid),
>  	fsparam_u32	("ttl",		opt_ttl),
>  	fsparam_u32oct	("dmode",	opt_dmode),
>  	fsparam_u32oct	("fmode",	opt_fmode),
> @@ -55,8 +55,6 @@ static int vboxsf_parse_param(struct fs_context *fc, struct fs_parameter *param)
>  {
>  	struct vboxsf_fs_context *ctx = fc->fs_private;
>  	struct fs_parse_result result;
> -	kuid_t uid;
> -	kgid_t gid;
>  	int opt;
>  
>  	opt = fs_parse(fc, vboxsf_fs_parameters, param, &result);
> @@ -73,16 +71,10 @@ static int vboxsf_parse_param(struct fs_context *fc, struct fs_parameter *param)
>  		param->string = NULL;
>  		break;
>  	case opt_uid:
> -		uid = make_kuid(current_user_ns(), result.uint_32);
> -		if (!uid_valid(uid))
> -			return -EINVAL;
> -		ctx->o.uid = uid;
> +		ctx->o.uid = result.uid;
>  		break;
>  	case opt_gid:
> -		gid = make_kgid(current_user_ns(), result.uint_32);
> -		if (!gid_valid(gid))
> -			return -EINVAL;
> -		ctx->o.gid = gid;
> +		ctx->o.gid = result.gid;
>  		break;
>  	case opt_ttl:
>  		ctx->o.ttl = msecs_to_jiffies(result.uint_32);


