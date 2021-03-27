Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE0E34B935
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Mar 2021 20:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbhC0T5T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Mar 2021 15:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbhC0T4e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Mar 2021 15:56:34 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D7A6C0613B1;
        Sat, 27 Mar 2021 12:56:33 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id u10so11313654lju.7;
        Sat, 27 Mar 2021 12:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bQsYw1ulUIO0dY5gSmv/3K4yj4XoeNoUj5DbKPEh9Qw=;
        b=oTcDvUNVUKy9l34jnk2Y6fGNlsSkpob0U6AudT8Jb4AZQ8OeHPq+nUwasmV8okfR2M
         sR+8behyvuMSz9G1EzjXiQj6LC23cs5XP3Vtcv+ivzmEp+gJdLhO3WJ40Yu3TtD1au7A
         T2jV+Uq24Bl7S6ZHZM5oSMX9h9l/f1+MOn3mPiOLuzagBTUVMcux0Bnq5Xe4bP3kjH5q
         cOfrKoS7RFKuRrrys834C8IvbAfjTmLd3SoJ3gcxp2e3UMkXWjaDO2oyj+t/e0vR3RWH
         GnqgmytnivfuzoKSm30v5UZFTROIHD61oXNxfqGvB1wgJHok2AYNnD/KhZd0qbUWpVgO
         h/5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bQsYw1ulUIO0dY5gSmv/3K4yj4XoeNoUj5DbKPEh9Qw=;
        b=Kw6rXYjV/XEpTfvKNVr5+DJ0w+jgjiclU0+lOX3hGxQZXsljBfGc3Mzi0QE7IhTwKh
         lEaEro8EF/rzP9F/sxGEy45eoHN4Zb/Z2oOLHax5RDk6rhYdaKwSUOOL4cAmyCr/al0i
         pmW2yL34CFFvOyqBYqwW9UdHa41kK7JnAZCnCZFhsawA0XskiZ/gD1TiZ3EyFkIt06SG
         2Tdno6LASVje7WPgUUarjHHN+xiCZJnB0KZVSNTBscRd8ElB8QudRgVgT/iGZz9Od69V
         tK6YLD15LH0FFl782xFPkQD3zKtp5qMYuharyIbdWztpPkDEz4d3TTzX/jeiuCZiUwET
         3/zw==
X-Gm-Message-State: AOAM532ucvH+nH28Ybm/wLgEZ++eoggA+myx6vWwBoV+rbszF7iuMOvV
        GdUzXi1KMd9yXMA7qO8ldPR55WWTTco=
X-Google-Smtp-Source: ABdhPJxLBeDCGTGncf7vPJx9segmdfmBAwHxFr43PJcjHagfyVIArjRrzp4osMA8qrzDEZfwYnOCVQ==
X-Received: by 2002:a2e:981a:: with SMTP id a26mr12854352ljj.204.1616874991681;
        Sat, 27 Mar 2021 12:56:31 -0700 (PDT)
Received: from [192.168.1.101] ([31.173.82.142])
        by smtp.gmail.com with ESMTPSA id u14sm1345822lfl.40.2021.03.27.12.56.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Mar 2021 12:56:31 -0700 (PDT)
Subject: Re: [PATCH 2/4] exec: remove compat_do_execve
To:     Christoph Hellwig <hch@lst.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>, Brian Gerst <brgerst@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210326143831.1550030-1-hch@lst.de>
 <20210326143831.1550030-3-hch@lst.de>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <596ca191-0176-e991-7318-f9a0f3361cb3@gmail.com>
Date:   Sat, 27 Mar 2021 22:56:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210326143831.1550030-3-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/26/21 5:38 PM, Christoph Hellwig wrote:

> Just call compat_do_execve instead.

   compat_do_execveat(), maybe?

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/exec.c | 17 +----------------
>  1 file changed, 1 insertion(+), 16 deletions(-)
> 
> diff --git a/fs/exec.c b/fs/exec.c
> index b63fb020909075..06e07278b456fa 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
[...]
> @@ -2072,7 +2057,7 @@ COMPAT_SYSCALL_DEFINE3(execve, const char __user *, filename,
>  	const compat_uptr_t __user *, argv,
>  	const compat_uptr_t __user *, envp)
>  {
> -	return compat_do_execve(getname(filename), argv, envp);
> +	return compat_do_execveat(AT_FDCWD, getname(filename), argv, envp, 0);
>  }
>  
>  COMPAT_SYSCALL_DEFINE5(execveat, int, fd,

MBR, Sergei
