Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8C8664811
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jan 2023 19:04:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235357AbjAJSEs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Jan 2023 13:04:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238746AbjAJSE3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Jan 2023 13:04:29 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 630E961306;
        Tue, 10 Jan 2023 10:01:43 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id u19so30714625ejm.8;
        Tue, 10 Jan 2023 10:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qG8hDJODvYil8hNrgIzOAxG9f3bsiBsalnyM2EStJCI=;
        b=CiXWC9pIm6jKfBDvwwJgT/TNgnfFQlIHc4784m45ZIGbBpUSMYcOqiwBdLn/IbDaLB
         IX9R4rK1fiGvCxJ25sGrS4Hpu12JRBAu19a5KVwoMRVECICZgVuM+XajchqKYu0SZdLJ
         A+yRN2cdgaiccikssLQ+bWqyfQ0I7L+XonUmR+tO3QsSZEq9sDi0Kpszo2wqAXlSVY7f
         4mlNggpnPFEkYT0CrZECbsk5eBcyJRV9SxNSEJPxS/jSrvqzdPan6OeO6FC7UZ3wRp5H
         dySSEgKgUy2xZqyJ14A3+kSaYPIiQLB6zChKNJomt0jqfHkbGkIGR83B8YIi3Si6pADF
         HlMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qG8hDJODvYil8hNrgIzOAxG9f3bsiBsalnyM2EStJCI=;
        b=JL81/sd5gq9rdJoZz7/OB/f4mfdcbazBow4uLjLxx/pK573UJyQxQkdCARczlkcP5Q
         n7adrTahThwQaKHzV1jMII/yYsZ58Qz4clVhQyYFzJCdPrtMlKuez2Xo5SL/fYbk57y8
         yk4Aq/OsAWj1H7YVdfGjsb44uZTH3fCg1cYtBK8vR5EepX650+rFxUxOz0HCb5dLZk6b
         UJi5kymTQj53CvmKqziWGlOIW5wtXcznlW7ge/WVBBcDs8p+1Seh+ojQiJRm856zfbuL
         vhpfgtaaReBV4hV9gXdTWc65SOuDawnx9U00FioKMrgUbN+vEhwihRTOmyVQO3vTVIon
         2NRw==
X-Gm-Message-State: AFqh2koZiYfR/H6Aerh4LPUUWhF9+oSJ3yHA/BHNvWpAS2HNMcT6QokO
        Ut/6UOdLvPPcwP+9YVjTQg==
X-Google-Smtp-Source: AMrXdXu/XLwlE1T+PDMyStrwovvKSR9BITo9LUM/AE22Y5LT7QeVKxJbwLGV8dhFuqGLwrkcRALPUA==
X-Received: by 2002:a17:907:8b85:b0:7c4:f4b8:f1c6 with SMTP id tb5-20020a1709078b8500b007c4f4b8f1c6mr64515291ejc.4.1673373702437;
        Tue, 10 Jan 2023 10:01:42 -0800 (PST)
Received: from p183 ([46.53.249.174])
        by smtp.gmail.com with ESMTPSA id w22-20020a1709061f1600b0081bfc79beaesm5199065ejj.75.2023.01.10.10.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 10:01:42 -0800 (PST)
Date:   Tue, 10 Jan 2023 21:01:40 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Chao Yu <chao@kernel.org>
Cc:     akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] proc: fix to check name length in proc_lookup_de()
Message-ID: <Y72oBFXX6DiEh2/p@p183>
References: <20230110152112.1119517-1-chao@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230110152112.1119517-1-chao@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 10, 2023 at 11:21:12PM +0800, Chao Yu wrote:
> __proc_create() has limited dirent's max name length with 255, let's
> add this limitation in proc_lookup_de(), so that it can return
> -ENAMETOOLONG correctly instead of -ENOENT when stating a file which
> has out-of-range name length.

Both returns are correct and this is trading one errno for another.

> --- a/fs/proc/generic.c
> +++ b/fs/proc/generic.c
> @@ -246,6 +246,9 @@ struct dentry *proc_lookup_de(struct inode *dir, struct dentry *dentry,
>  {
>  	struct inode *inode;
>  
> +	if (dentry->d_name.len > PROC_NAME_LEN)
> +		return ERR_PTR(-ENAMETOOLONG);
