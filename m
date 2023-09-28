Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 436757B1ED5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 15:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbjI1Npj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 09:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231871AbjI1Npi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 09:45:38 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7FA2194;
        Thu, 28 Sep 2023 06:45:36 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-3247d69ed2cso2436639f8f.0;
        Thu, 28 Sep 2023 06:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695908735; x=1696513535; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=s3ivXPHPFKDuDR/2N/73eTsr7zstsBXJOHHUFK4hFGk=;
        b=Rk7egRWFgzDY49cueU9wBVgP0mkayb5esMI+6EnDunAt34VQzX31GMKIZM0OhZMcE/
         9V7jAYyR4cTpSLQdGvPuIyLuEd3nSkFtrQwKbfJmHZOoKorApFuprNEpuaTu7180cXWi
         87374VURU91rl4vshzp0pSirOIsO9ETydxHi/QEbV0Ok6qBtksxidIGQRueHGfWrpahM
         nNpTDVP6lTMfl8x3g7mEhnVtpoZLatIn804/Mnl0XS6Ror4KpqQ9Bo9oe0Dcm+deYzRy
         pRwGgrZ7qNmEyN9pXTXqsY0LouAOnky2Kyo36prbNisjjstts3AMi+TOshsNfZQrGFVi
         McHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695908735; x=1696513535;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s3ivXPHPFKDuDR/2N/73eTsr7zstsBXJOHHUFK4hFGk=;
        b=Syl1JMdk+pUYmixFa3tT6FWKiOjil5kAV19AYhZ7AWAHoAZwBr7iCE/bm+ST4DIdtb
         Peqg/vG1wsHp1N+jsIdqcoezJTqBonlsQjmJeRi4+NGwSi70d83VAlXPIWjMlsciyyAP
         R9NTcbb6koJS325SibesdQNhbZJ6IL1N8k8U4EgCaFY8PXRNjdCKG8SpoQsJ5N9MrAGF
         KDEGeUV7ql7e0WILJa+t9KveaG884YZuyybJ+X9mjLbuQb3g2jLA0fTQ5fpxcYV3/L93
         r2EV93FM7OJ1epBIdPCPN7HyO2v+i8aGj8fGIrtwq2Fky4msbgqtvnsLvZYYqOMdgPGg
         u59g==
X-Gm-Message-State: AOJu0YxSEyhhlNbjcrLE0NfDTF0a6M8WxX5w8lUa8mWFA1RMdruiFSbP
        qF6iXCSKfehoZ17Sy0rPaAk=
X-Google-Smtp-Source: AGHT+IEgA2VU/otTO2kSxabbhjSlEY4LnLZ0S7VtZGLp64cdLeyg/mgibPFPOe61ybTxNmZdk8Rr1g==
X-Received: by 2002:a5d:414e:0:b0:320:1d1:71c4 with SMTP id c14-20020a5d414e000000b0032001d171c4mr1205634wrq.23.1695908734828;
        Thu, 28 Sep 2023 06:45:34 -0700 (PDT)
Received: from f (cst-prg-67-191.cust.vodafone.cz. [46.135.67.191])
        by smtp.gmail.com with ESMTPSA id c25-20020adfa319000000b00324853fc8adsm1458270wrb.104.2023.09.28.06.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 06:45:33 -0700 (PDT)
Date:   Thu, 28 Sep 2023 15:45:13 +0200
From:   Mateusz Guzik <mjguzik@gmail.com>
To:     =?utf-8?B?THXDrXM=?= Henriques <lhenriques@suse.de>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: fix possible extra iput() in do_unlinkat()
Message-ID: <20230928134513.l2y3eknt2hfq3qgx@f>
References: <20230928131129.14961-1-lhenriques@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230928131129.14961-1-lhenriques@suse.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 28, 2023 at 02:11:29PM +0100, Luís Henriques wrote:
> Because inode is being initialised before checking if dentry is negative,
> and the ihold() is only done if the dentry is *not* negative, the cleanup
> code may end-up doing an extra iput() on that inode.
> 
> Fixes: b18825a7c8e3 ("VFS: Put a small type field into struct dentry::d_flags")
> Signed-off-by: Luís Henriques <lhenriques@suse.de>
> ---
> Hi!
> 
> I was going to also remove the 'if (inode)' before the 'iput(inode)',
> because 'iput()' already checks for NULL anyway.  But since I probably
> wouldn't have caught this bug if it wasn't for that 'if', I decided to
> keep it there.  But I can send v2 with that change too if you prefer.
> 
> Cheers,
> --
> Luís
> 
>  fs/namei.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index 567ee547492b..156a570d7831 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -4386,11 +4386,9 @@ int do_unlinkat(int dfd, struct filename *name)
>  	if (!IS_ERR(dentry)) {
>  
>  		/* Why not before? Because we want correct error value */
> -		if (last.name[last.len])
> +		if (last.name[last.len] || d_is_negative(dentry))
>  			goto slashes;
>  		inode = dentry->d_inode;
> -		if (d_is_negative(dentry))
> -			goto slashes;
>  		ihold(inode);
>  		error = security_path_unlink(&path, dentry);
>  		if (error)

I ran into this myself, but I'm pretty sure there is no bug here. The
code is just incredibly misleading and it became this way from the
sweeping change introducing d_is_negative. I could not be bothered to
argue about patching it so I did not do anything. ;)

AFAICS it is an invariant that d_is_negative passes iff d_inode is NULL.

Personally I support the patch, but commit message needs to stop
claiming a bug.
