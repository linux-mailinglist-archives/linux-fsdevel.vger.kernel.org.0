Return-Path: <linux-fsdevel+bounces-63862-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 141F9BD064A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Oct 2025 17:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BA13F4EB723
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Oct 2025 15:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C92A2D836D;
	Sun, 12 Oct 2025 15:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=geoffthorpe.net header.i=@geoffthorpe.net header.b="ePOV7vEj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D0F1F03C5
	for <linux-fsdevel@vger.kernel.org>; Sun, 12 Oct 2025 15:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760283694; cv=none; b=en2CSzjXSbnNcaOYXMu9ZNghtB8MyxnkkPAmTRdYn0Bd+7h+ca3IAmD8PrE4pL8+hsAQ+p/ez+DviKtSUwwZN8Cxa4efS1LKqZClLwTFVUgVQ8VasgwB50Ll+hVKG33WOn8yhr7/BrEs31jf6ABO7zXY1B7Duwry4h5VhRXB+eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760283694; c=relaxed/simple;
	bh=HzNEdpGl4X6p1v5iaDX3eVdxcX8g13Ctr0W+w2O1qHg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ho3LmJa72bZEQLPr41wwEY84mZcfBGUbwEnB1ssdJk0WDMZiu46Y33rHizIwPJxke7Mtq3qkMsuovSkVb3gUWVyvZoV0oaDA3JuNjtabfUPRw0ugJ2aXr02tWawf0qozyLjvefr4lzfQO6TYfzvIJ3Jf2DyIAeBv2QmyE4qzT9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=geoffthorpe.net; spf=pass smtp.mailfrom=qclibre.com; dkim=pass (1024-bit key) header.d=geoffthorpe.net header.i=@geoffthorpe.net header.b=ePOV7vEj; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=geoffthorpe.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qclibre.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7c0e8367d4eso1362457a34.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 12 Oct 2025 08:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=geoffthorpe.net; s=myprefix; t=1760283689; x=1760888489; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AsZBCHDpjPnDyG10nk7FYMuNUry3QIymQfwNVLRl4UE=;
        b=ePOV7vEj2Zgp73H8CUFYk3E3qcvTmv17VwKkInbi/TGrGzMuFZK+tq3r4+lIUwbSza
         gpzbxjve0TM+k24wEr7S3bKdwUqyQFMCcHNt80V/oiaByOjp85RvAv0hrFqWvpm8LAfC
         WCOd8Tu1VojAOumgZjY4qYM76kT31wO8FgDlk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760283689; x=1760888489;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AsZBCHDpjPnDyG10nk7FYMuNUry3QIymQfwNVLRl4UE=;
        b=s/mpknOUz7+fqBQeTaloxnNmrmGHuBGqd3XmRP/+27eH0Sdq6AUoTxNMXrIhiZBfpZ
         UdXke3EBWIhChtWExFBvuGMkBqt6D6rM8f6Q5qPgpmJvR6PV5UXpCXh15dDJ2cJks1A2
         mfa/WreiezDZjXXYAEeumuYI3zPaI8J457RWYr3GIzEkqm33pNfjdcugjvrUZQeiGQEq
         Re7qCGvlU0Vu4IrSVfluBznYFH+PzHTthg1T5+W0DKRSvZ6lEY/liPYfF9YwXH8aobQY
         bhtirFtYguc7Oqj5bd0BjhfztDaflZ7q85e9+ivHLTKnmfAKyjv29r7VlkLYB5TpQRpl
         BLpg==
X-Forwarded-Encrypted: i=1; AJvYcCW8Hji3all04JsJ7YOKFqGXdTI9epHzrVEWN5s83dWt6dTY47fjHEUnwUOYuRBC5HKtB4uLDfCrUD25JHGc@vger.kernel.org
X-Gm-Message-State: AOJu0YygkwJrVHw96uvt4cbPnNrdYOdNwD+LEbRFa9YuN4cXRBDn4tof
	jWAhfjavhIxFdP9KarCEMi1PyWPaE7Ud9kxhGSCKp291VzD9iIb2ssUezKh6lPqQWdA=
X-Gm-Gg: ASbGncsczivd6RYmBNyZjqtS5wiWMv/q493YiUqbJGZS0VSvzKHhncaFnPZY//KJMW7
	u4qyILBrRGylBCnc9dNj7CNkwrdnCrS0TG7As05zsbkpvjOwkmHEvWsKE8zetSQxKP3+LAo4huz
	iOLEeoVEIzfuN2PuuY1n6HkkSeNslTfLJrV+AC8WITqnnIrV8HUflML8ctRvfjlohgmFJuHgBSj
	AGflkip9Ay3qWoEPC2uS0GeiwTeGKe2aVF4emLPbKkJdVrVRkXj0vfKU6ODwi8i5hBIOuXooCcC
	c7+m21GVlAN2I+QhAW03jsNCMcvVoe1MIa5J/Ny/9ltZIEU0jX038S1LWuiTugdZuvfQ7jOnK+d
	2EJbGQtr4Kt0D+ZryrReHyXjfD5INo3B5K+WuVSpfQ2EL9kikiXWVKBQevnFp4rXWhZZirN0=
X-Google-Smtp-Source: AGHT+IF9NDY+8m6VpMu3v6jH/T/LAqqWGozqjs1br7mm7E9KlJ1VI3+VPNzQbbC2rM2RglpwUwSs4g==
X-Received: by 2002:a05:6870:3647:b0:365:6984:3d6 with SMTP id 586e51a60fabf-3c0f771946dmr7588916fac.34.1760283689032;
        Sun, 12 Oct 2025 08:41:29 -0700 (PDT)
Received: from [192.168.0.120] ([201.103.139.132])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3c8c8e80a38sm2722404fac.15.2025.10.12.08.41.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Oct 2025 08:41:28 -0700 (PDT)
Message-ID: <100e0c55-a016-491a-ac41-89e640851771@geoffthorpe.net>
Date: Sun, 12 Oct 2025 11:41:29 -0400
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hostfs: Fix only passing host root in boot stage with new
 mount
To: Hongbo Li <lihongbo22@huawei.com>, richard@nod.at,
 anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 brauner@kernel.org
References: <20251011092235.29880-1-lihongbo22@huawei.com>
Content-Language: en-US
From: Geoffrey Thorpe <geoff@geoffthorpe.net>
In-Reply-To: <20251011092235.29880-1-lihongbo22@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

(This time, responding in plain text so the list-server doesn't reject. 
oops.)

Yes, I've tested your patch and it has fixed the problem for me. Thanks


On 2025-10-11 05:22, Hongbo Li wrote:
> In the old mount proceedure, hostfs could only pass root directory during
> boot. This is because it constructed the root directory using the @root_ino
> event without any mount options. However, when using it with the new mount
> API, this step is no longer triggered. As a result, if users mounts without
> specifying any mount options, the @host_root_path remains uninitialized. To
> prevent this issue, the @host_root_path should be initialized at the time
> of allocation.
>
> Reported-by: Geoffrey Thorpe <geoff@geoffthorpe.net>
> Closes: https://lore.kernel.org/all/643333a0-f434-42fb-82ac-d25a0b56f3b7@geoffthorpe.net/
> Fixes: cd140ce9f611 ("hostfs: convert hostfs to use the new mount API")
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> ---
>   fs/hostfs/hostfs_kern.c | 29 ++++++++++++++++++-----------
>   1 file changed, 18 insertions(+), 11 deletions(-)
>
> diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
> index 1e1acf5775ab..86455eebbf6c 100644
> --- a/fs/hostfs/hostfs_kern.c
> +++ b/fs/hostfs/hostfs_kern.c
> @@ -979,7 +979,7 @@ static int hostfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
>   {
>   	struct hostfs_fs_info *fsi = fc->s_fs_info;
>   	struct fs_parse_result result;
> -	char *host_root;
> +	char *host_root, *tmp_root;
>   	int opt;
>   
>   	opt = fs_parse(fc, hostfs_param_specs, param, &result);
> @@ -990,11 +990,13 @@ static int hostfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
>   	case Opt_hostfs:
>   		host_root = param->string;
>   		if (!*host_root)
> -			host_root = "";
> -		fsi->host_root_path =
> -			kasprintf(GFP_KERNEL, "%s/%s", root_ino, host_root);
> -		if (fsi->host_root_path == NULL)
> +			break;
> +		tmp_root = kasprintf(GFP_KERNEL, "%s%s",
> +				     fsi->host_root_path, host_root);
> +		if (!tmp_root)
>   			return -ENOMEM;
> +		kfree(fsi->host_root_path);
> +		fsi->host_root_path = tmp_root;
>   		break;
>   	}
>   
> @@ -1004,17 +1006,17 @@ static int hostfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
>   static int hostfs_parse_monolithic(struct fs_context *fc, void *data)
>   {
>   	struct hostfs_fs_info *fsi = fc->s_fs_info;
> -	char *host_root = (char *)data;
> +	char *tmp_root, *host_root = (char *)data;
>   
>   	/* NULL is printed as '(null)' by printf(): avoid that. */
>   	if (host_root == NULL)
> -		host_root = "";
> +		return 0;
>   
> -	fsi->host_root_path =
> -		kasprintf(GFP_KERNEL, "%s/%s", root_ino, host_root);
> -	if (fsi->host_root_path == NULL)
> +	tmp_root = kasprintf(GFP_KERNEL, "%s%s", fsi->host_root_path, host_root);
> +	if (!tmp_root)
>   		return -ENOMEM;
> -
> +	kfree(fsi->host_root_path);
> +	fsi->host_root_path = tmp_root;
>   	return 0;
>   }
>   
> @@ -1049,6 +1051,11 @@ static int hostfs_init_fs_context(struct fs_context *fc)
>   	if (!fsi)
>   		return -ENOMEM;
>   
> +	fsi->host_root_path = kasprintf(GFP_KERNEL, "%s/", root_ino);
> +	if (!fsi->host_root_path) {
> +		kfree(fsi);
> +		return -ENOMEM;
> +	}
>   	fc->s_fs_info = fsi;
>   	fc->ops = &hostfs_context_ops;
>   	return 0;

