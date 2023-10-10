Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F23D47BF61F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Oct 2023 10:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346705AbjJJIhF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Oct 2023 04:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443048AbjJJIga (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Oct 2023 04:36:30 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F473B0;
        Tue, 10 Oct 2023 01:35:53 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-53829312d12so13926112a12.0;
        Tue, 10 Oct 2023 01:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696926951; x=1697531751; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BMi8wdVxApb25LjYsbqQ7Zs0KqzUPo1pOmHWaAx78bA=;
        b=FD7U6M8XqN+Yj1c9oZwfBz+QO7QV/lKsyM6Z0PZLD9bQGR6Wuz3feG/ZK4G86sBDzQ
         Fr+PRwuF3zFqxaOY/o58hzfxRVnTG+L9WEs4/S5/IFalX6Bjm8mffprvRp6wT8C5wUvU
         7N9nQRlFqYXx6fkI4fQ99/ARSONVieFevAN4y1uEy9VccRmaTh+JOnfLWbeLr4NwFmfL
         FqHqwvAbH6/LWRUL/N/3b/IpZjTPmER4O0/ZTeA/YvMvYTt5KNtQB7v/m4JNnLCLbi78
         IxC99pr6WLFyBgTCI7KfffWmW/fVRlXjqZcK20UaqJS3n8dk1uEA/OF10i0KRUbpOsD4
         rseQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696926951; x=1697531751;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BMi8wdVxApb25LjYsbqQ7Zs0KqzUPo1pOmHWaAx78bA=;
        b=Pe2TqSsvN0on/FjHSIIZSWf2IJeRbnwUXPFYfVbPCsdPgQti/Vt+M36hITaPTMduLn
         NF010Nj6CnmwC24wibRWhz6Hm9yYKuYEOtQ6ARayP3lX1iCu6kX+lXArlHPKQ6Q3CzId
         AK/4j7ifYtpK91ZHa9SCdgpC/c9Nm0J8QPF51Rj6rpHHYgZ9gBeyQ2aZlhRb66fn0L3i
         GxcR03EMUQ88TUHdktxyupU4BB+86+rzli+rBjeU0osVLd7YueFhr2zDrjs6y+Hk093E
         nY6sYt/gLRKBSU2/4ATNUvsp3E+n3eQIbc0uAJV3qZK6kA3esgQlS+n7NBeqZWVnI0tY
         WsWw==
X-Gm-Message-State: AOJu0YyAxHpxqyvHzvP3kgWOkMlyLvseIu8tNHw2CZbJw7tU+6P2Fq5q
        yn7v1m5MT7ZoOzIfb8zWi9EUmDp4S6Q=
X-Google-Smtp-Source: AGHT+IErGjDETTfbLZBe+IUptE2vO9PBQ0X0ZvVP3jvwOnlcuV4fFhG+shtCF2fNB/No8v3wNNpRIw==
X-Received: by 2002:a05:6402:1a33:b0:522:582c:f427 with SMTP id be19-20020a0564021a3300b00522582cf427mr13675180edb.14.1696926951033;
        Tue, 10 Oct 2023 01:35:51 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id u1-20020a05640207c100b005311e934765sm7279443edy.27.2023.10.10.01.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 01:35:49 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Tue, 10 Oct 2023 10:35:48 +0200
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, keescook@chromium.org,
        brauner@kernel.org, lennart@poettering.net, kernel-team@meta.com,
        sargun@sargun.me
Subject: Re: [PATCH v6 bpf-next 04/13] bpf: add BPF token support to
 BPF_MAP_CREATE command
Message-ID: <ZSUM5A+dJHptbRSx@krava>
References: <20230927225809.2049655-1-andrii@kernel.org>
 <20230927225809.2049655-5-andrii@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927225809.2049655-5-andrii@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 27, 2023 at 03:58:00PM -0700, Andrii Nakryiko wrote:

SNIP

> -#define BPF_MAP_CREATE_LAST_FIELD map_extra
> +#define BPF_MAP_CREATE_LAST_FIELD map_token_fd
>  /* called via syscall */
>  static int map_create(union bpf_attr *attr)
>  {
>  	const struct bpf_map_ops *ops;
> +	struct bpf_token *token = NULL;
>  	int numa_node = bpf_map_attr_numa_node(attr);
>  	u32 map_type = attr->map_type;
>  	struct bpf_map *map;
> @@ -1157,14 +1158,32 @@ static int map_create(union bpf_attr *attr)
>  	if (!ops->map_mem_usage)
>  		return -EINVAL;
>  
> +	if (attr->map_token_fd) {
> +		token = bpf_token_get_from_fd(attr->map_token_fd);
> +		if (IS_ERR(token))
> +			return PTR_ERR(token);
> +
> +		/* if current token doesn't grant map creation permissions,
> +		 * then we can't use this token, so ignore it and rely on
> +		 * system-wide capabilities checks
> +		 */
> +		if (!bpf_token_allow_cmd(token, BPF_MAP_CREATE) ||
> +		    !bpf_token_allow_map_type(token, attr->map_type)) {
> +			bpf_token_put(token);
> +			token = NULL;
> +		}
> +	}
> +
> +	err = -EPERM;
> +
>  	/* Intent here is for unprivileged_bpf_disabled to block BPF map
>  	 * creation for unprivileged users; other actions depend
>  	 * on fd availability and access to bpffs, so are dependent on
>  	 * object creation success. Even with unprivileged BPF disabled,
>  	 * capability checks are still carried out.
>  	 */
> -	if (sysctl_unprivileged_bpf_disabled && !bpf_capable())
> -		return -EPERM;
> +	if (sysctl_unprivileged_bpf_disabled && !bpf_token_capable(token, CAP_BPF))
> +		goto put_token;
>  
>  	/* check privileged map type permissions */
>  	switch (map_type) {
> @@ -1197,25 +1216,27 @@ static int map_create(union bpf_attr *attr)
>  	case BPF_MAP_TYPE_LRU_PERCPU_HASH:
>  	case BPF_MAP_TYPE_STRUCT_OPS:
>  	case BPF_MAP_TYPE_CPUMAP:
> -		if (!bpf_capable())
> -			return -EPERM;
> +		if (!bpf_token_capable(token, CAP_BPF))
> +			goto put_token;
>  		break;
>  	case BPF_MAP_TYPE_SOCKMAP:
>  	case BPF_MAP_TYPE_SOCKHASH:
>  	case BPF_MAP_TYPE_DEVMAP:
>  	case BPF_MAP_TYPE_DEVMAP_HASH:
>  	case BPF_MAP_TYPE_XSKMAP:
> -		if (!bpf_net_capable())
> -			return -EPERM;
> +		if (!bpf_token_capable(token, CAP_NET_ADMIN))
> +			goto put_token;
>  		break;
>  	default:
>  		WARN(1, "unsupported map type %d", map_type);
> -		return -EPERM;
> +		goto put_token;
>  	}
>  
>  	map = ops->map_alloc(attr);
> -	if (IS_ERR(map))
> -		return PTR_ERR(map);
> +	if (IS_ERR(map)) {
> +		err = PTR_ERR(map);
> +		goto put_token;
> +	}
>  	map->ops = ops;
>  	map->map_type = map_type;
>  
> @@ -1252,7 +1273,7 @@ static int map_create(union bpf_attr *attr)
>  		map->btf = btf;
>  
>  		if (attr->btf_value_type_id) {
> -			err = map_check_btf(map, btf, attr->btf_key_type_id,
> +			err = map_check_btf(map, token, btf, attr->btf_key_type_id,
>  					    attr->btf_value_type_id);
>  			if (err)
>  				goto free_map;

I might be missing something, but should we call bpf_token_put(token)
on non-error path as well? probably after bpf_map_save_memcg call

jirka

> @@ -1293,6 +1314,8 @@ static int map_create(union bpf_attr *attr)
>  free_map:
>  	btf_put(map->btf);
>  	map->ops->map_free(map);
> +put_token:
> +	bpf_token_put(token);
>  	return err;
>  }
>  

SNIP
