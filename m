Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 459424C820B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Mar 2022 05:14:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbiCAEPW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Feb 2022 23:15:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbiCAEPV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Feb 2022 23:15:21 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB725FF3
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Feb 2022 20:14:40 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id z16so13048684pfh.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Feb 2022 20:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2WOOrNgu/4waRHpgeE8ItroxnZ75K4bN3bPZXcqdM/s=;
        b=iVR62Ph82p6yttDHLy4q7W5PMHWMVksi0PfdvMEAOQdHUr/7nWJCQr5JmgmcSbbDZW
         1bOM1HC4UX8lmiokRNIWmOmUIitpD+tWBzM47tqTt+lfwTkxbl0w9n71I8BM2dWSObh/
         AlQzORAsWprj+9Dr2vBi1Sb1p7p4bG8UtvBH8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2WOOrNgu/4waRHpgeE8ItroxnZ75K4bN3bPZXcqdM/s=;
        b=bcGo751WpxNf6lUWzXgcOn8OIDYdAnSVqI/IDI2HIM55oLTZk3QssgBP8LTtPSCFxa
         Cf6QHiXIygTd33Au6eQKhcwFQ9CFMFrzyMs99UMiaPtHdXdYpMrgGZhz+QExWxQ1t0BY
         Mvj+WVQt1w0BDm4Gj4MDsU8GM4m+VfSlMZoUTvRiaPI7ESYBzFle69GnPX661OBGaAsu
         4F3XRuNmSC42G9XVj5rU6LFqxE8uojLkpF29pXjH/mgswfKcqWWnTjE7OGBAiVxO7+uL
         Xgs3/Tr7jUXB5iLCdPFLmjKJzWYHNafDxp9XvojUYgHiERfIryyh+fuD4x8mt4Jh5xlv
         LFRw==
X-Gm-Message-State: AOAM530y9N0seykZ2MgPkuRuv56H9g90aMkTM6ANirGht8HFVNeWAwWQ
        1nUx/5Sq4DY5PwW7PHjbmlWAqg==
X-Google-Smtp-Source: ABdhPJyBnuFWEJilTVDO/nWyocXEsLWJ+qGQkYdVDAVLHnhru2I7QfSXzKFRf7Hg1HUWGc/fM6wB8A==
X-Received: by 2002:a63:724b:0:b0:378:7967:e45c with SMTP id c11-20020a63724b000000b003787967e45cmr10652509pgn.602.1646108080185;
        Mon, 28 Feb 2022 20:14:40 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:95ec:e94d:ec6b:6068])
        by smtp.gmail.com with ESMTPSA id bo10-20020a17090b090a00b001bc8405bd55sm738300pjb.30.2022.02.28.20.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 20:14:39 -0800 (PST)
Date:   Tue, 1 Mar 2022 13:14:34 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Namjae Jeon <linkinjeon@kernel.org>
Cc:     linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        smfrench@gmail.com, hyc.lee@gmail.com, senozhatsky@chromium.org,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 2/4] ksmbd: remove filename in ksmbd_file
Message-ID: <Yh2dqrb6SrOlWL9t@google.com>
References: <20220228234833.10434-1-linkinjeon@kernel.org>
 <20220228234833.10434-2-linkinjeon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228234833.10434-2-linkinjeon@kernel.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On (22/03/01 08:48), Namjae Jeon wrote:
> -char *convert_to_nt_pathname(char *filename)
> +char *convert_to_nt_pathname(struct ksmbd_share_config *share,
> +			     struct path *path)
>  {
> -	char *ab_pathname;
> +	char *pathname, *ab_pathname, *nt_pathname = NULL;
> +	int share_path_len = strlen(share->path);
>  
> -	if (strlen(filename) == 0)
> -		filename = "\\";
> +	pathname = kmalloc(PATH_MAX, GFP_KERNEL);
> +	if (!pathname)
> +		return ERR_PTR(-EACCES);
>  
> -	ab_pathname = kstrdup(filename, GFP_KERNEL);
> -	if (!ab_pathname)
> -		return NULL;
> +	ab_pathname = d_path(path, pathname, PATH_MAX);
> +	if (IS_ERR(ab_pathname)) {
> +		nt_pathname = ERR_PTR(-EACCES);
> +		goto free_pathname;
> +	}
> +
> +	if (strncmp(ab_pathname, share->path, share_path_len)) {
> +		nt_pathname = ERR_PTR(-EACCES);
> +		goto free_pathname;
> +	}
> +
> +	nt_pathname = kzalloc(strlen(&ab_pathname[share_path_len]) + 1, GFP_KERNEL);
> +	if (!nt_pathname) {
> +		nt_pathname = ERR_PTR(-ENOMEM);
> +		goto free_pathname;
> +	}
> +	if (ab_pathname[share_path_len] == '\0')
> +		strcpy(nt_pathname, "/");
> +	strcat(nt_pathname, &ab_pathname[share_path_len]);
> +
> +	ksmbd_conv_path_to_windows(nt_pathname);
>  
> -	ksmbd_conv_path_to_windows(ab_pathname);
> -	return ab_pathname;
> +free_pathname:
> +	kfree(pathname);
> +	return nt_pathname;
>  }

convert_to_nt_pathname() can return NULL

> +	filename = convert_to_nt_pathname(work->tcon->share_conf, &fp->filp->f_path);
> +	if (IS_ERR(filename))
> +		return PTR_ERR(filename);

I don't think this will catch NULL nt_pathname return.
