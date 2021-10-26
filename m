Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B745943B15B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Oct 2021 13:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235088AbhJZLnO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Oct 2021 07:43:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37068 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235006AbhJZLnN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Oct 2021 07:43:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635248449;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YG+7bmqj0bdTJvSnuX0NifvcRk14pWUa3tcBlnMdyQ0=;
        b=hG41Li3NmyQqgAaGh7g+L7xxUkTqqE0OLIPgHql2u0ouEZaseJtCqlHXcawO0B62u30Qcw
        7opNraQxxoUfAUMIBXBi6A8SDZXLFhw/wX83QKiIxKK6lLYbUHL+Wmy6aSwVxVdvwHMR3o
        0RRGdiN0KVnO/19cSC+8Q2dEQuziivY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-529-4Q7M6vCXPLqkYTJ1Oaq6uw-1; Tue, 26 Oct 2021 07:40:47 -0400
X-MC-Unique: 4Q7M6vCXPLqkYTJ1Oaq6uw-1
Received: by mail-wm1-f69.google.com with SMTP id k5-20020a7bc3050000b02901e081f69d80so5001695wmj.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Oct 2021 04:40:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=YG+7bmqj0bdTJvSnuX0NifvcRk14pWUa3tcBlnMdyQ0=;
        b=1Fxr3PZsE+Z+ejJBhAhtffMKc6rkOOW3hwPingAWv+YpOOAsVj2uAjnKGTACt037nt
         +mIecczbp4rU2yPQqXyjPB8MjZk3EJDUSkLDLWOp8LYAftBMoFYhC5CkmJZJdxcczu5n
         oUkodpuCBWo39OmAfQwsViQ6P97d6VuLU19RMqJRq/X/fP1ecroU6NaRLGqpBJWENjB8
         5tY+4jupoM5b+k6wN9vARs6fpYfE7x4xv7Os3tfzFZOUrat9EXe1MNEXEJ9Kg12KYhUM
         pS8RnPluB70kFvphvQNiJry+4cIB31r5RlrvbfkF+FXHUH6Rj+8gk38vTgWpUQNNydRj
         ACpA==
X-Gm-Message-State: AOAM533GJUvwzwrnQlnjK9Zbi0ICwwR3g0EV7OzUq3NF1rhs/1Crua3u
        s32Lcw/RYboie2pKyX65XDwTJNU4jUPqi7K6PZhQT3nYe66LpRNS9lovs5LAgsbPhETdooMi1CH
        zVR2gUsrtYslbOBf0AoPAXJKBHA==
X-Received: by 2002:adf:9b84:: with SMTP id d4mr29282368wrc.393.1635248446092;
        Tue, 26 Oct 2021 04:40:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyh5NH2Zl8AfAUu3h/0LfZdXWteeXUxePDe9u1E82gy5U6kvIUJRNrcrKQgLDScWOLDgmJJGA==
X-Received: by 2002:adf:9b84:: with SMTP id d4mr29282339wrc.393.1635248445901;
        Tue, 26 Oct 2021 04:40:45 -0700 (PDT)
Received: from andromeda.lan (ip4-46-39-172-19.cust.nbox.cz. [46.39.172.19])
        by smtp.gmail.com with ESMTPSA id n17sm417940wms.33.2021.10.26.04.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 04:40:45 -0700 (PDT)
Date:   Tue, 26 Oct 2021 13:40:43 +0200
From:   Carlos Maiolino <cmaiolino@redhat.com>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 11/13] ext4: change token2str() to use ext4_param_specs
Message-ID: <20211026114043.q5kwobv7vlnv2uej@andromeda.lan>
Mail-Followup-To: Lukas Czerner <lczerner@redhat.com>,
        linux-ext4@vger.kernel.org, tytso@mit.edu,
        linux-fsdevel@vger.kernel.org
References: <20211021114508.21407-1-lczerner@redhat.com>
 <20211021114508.21407-12-lczerner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211021114508.21407-12-lczerner@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 21, 2021 at 01:45:06PM +0200, Lukas Czerner wrote:
> Chage token2str() to use ext4_param_specs instead of tokens so that we

^ Change.

> can get rid of tokens entirely.

If you're removing tokens entirely, maybe the name token2str() doesn't make
sense anymore?

> 
> Signed-off-by: Lukas Czerner <lczerner@redhat.com>
> ---
>  fs/ext4/super.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index bdcaa158eab8..0ccd47f3fa91 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -3037,12 +3037,12 @@ static inline void ext4_show_quota_options(struct seq_file *seq,
>  
>  static const char *token2str(int token)
>  {
> -	const struct match_token *t;
> +	const struct fs_parameter_spec *spec;
>  
> -	for (t = tokens; t->token != Opt_err; t++)
> -		if (t->token == token && !strchr(t->pattern, '='))
> +	for (spec = ext4_param_specs; spec->name != NULL; spec++)
> +		if (spec->opt == token && !spec->type)
>  			break;
> -	return t->pattern;
> +	return spec->name;
>  }
>  
>  /*
> -- 
> 2.31.1
> 

-- 
Carlos

