Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8067328D618
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Oct 2020 23:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727637AbgJMVE0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Oct 2020 17:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbgJMVEZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Oct 2020 17:04:25 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FEC8C061755
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Oct 2020 14:04:24 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id p13so911781edi.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Oct 2020 14:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Dpznq1bVtHuTvkgZ0V3uOe64d8urDDLe1UJMO63b1Hs=;
        b=B7TVlQ2cGFtisTvY81goMmv1p7zhU8tVopK6OyjfNs0BEU7T2p+ZQfOnQmGLPH176X
         Ddx44SpYCO2gquP5hbMHKic8xHREKYmC0yPabTFE1gplCRX/1peJ9ZrQtrX6RdXv81VN
         K4JPq9b14w6YErYoiaxnLTBoSOxjd8Vw7AzCY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Dpznq1bVtHuTvkgZ0V3uOe64d8urDDLe1UJMO63b1Hs=;
        b=JxbyLxFHNgNNpaODLiA9FtZgnv/JMz+NzEB6TD3FgyvRk6YOgOcp03a5Sd5BdPzFWA
         pMLO12xCUsYoV+1K/guIwIf2u1ui9+D9/rIPS7AFu+WSQ5eX3SSHWU7w8q1NXsuROGt9
         Vu4g2WjOf5tI3FHuccYYo5tbNCWND8S5MZSMYIIPYoAM2xjBqih4tRP+CD7mcTQfaou3
         5K9J5COk2j6xucKz961vBDyv3XNSQY936J7W2ZsApnWSgMrAqtbjRtGGPZP1SXg3sjNc
         cBY3qEpzp3bMGf4XeyUmSIBXdQvqq0cHQWSuI1ww5h7tBXnriOhW0Ey/fgAGXW25uslv
         A+lw==
X-Gm-Message-State: AOAM53231tzA56Cx6St366ZfIZuRvqssbApEaox+bBqr+HHy4Yuh+PQq
        ckRoLsRZ1bx/yYwoeY8iMHjOZQ==
X-Google-Smtp-Source: ABdhPJw5D4eRrsPzQP92gAP9vfi6hiIqR+4GaLJTcdF3tCuPnywuQSebLETL8Z2Ciy7q0rfo+5zGxQ==
X-Received: by 2002:aa7:d143:: with SMTP id r3mr1636703edo.103.1602623062929;
        Tue, 13 Oct 2020 14:04:22 -0700 (PDT)
Received: from [192.168.1.149] (5.186.115.188.cgn.fibianet.dk. [5.186.115.188])
        by smtp.gmail.com with ESMTPSA id f23sm543444ejd.5.2020.10.13.14.04.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2020 14:04:22 -0700 (PDT)
Subject: Re: [PATCH 1/2] fs, close_range: add flag CLOSE_RANGE_CLOEXEC
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>
Cc:     linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org,
        containers@lists.linux-foundation.org
References: <20201013140609.2269319-1-gscrivan@redhat.com>
 <20201013140609.2269319-2-gscrivan@redhat.com>
 <20201013205427.clvqno24ctwxbuyv@wittgenstein>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <22ff41f8-c009-84f4-849b-a807b7382253@rasmusvillemoes.dk>
Date:   Tue, 13 Oct 2020 23:04:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201013205427.clvqno24ctwxbuyv@wittgenstein>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 13/10/2020 22.54, Christian Brauner wrote:
> On Tue, Oct 13, 2020 at 04:06:08PM +0200, Giuseppe Scrivano wrote:
> 
> Hey Guiseppe,
> 
> Thanks for the patch!
> 
>> When the flag CLOSE_RANGE_CLOEXEC is set, close_range doesn't
>> immediately close the files but it sets the close-on-exec bit.
> 
> Hm, please expand on the use-cases a little here so people know where
> and how this is useful. Keeping the rationale for a change in the commit
> log is really important.
> 

> I think I don't have quarrels with this patch in principle but I wonder
> if something like the following wouldn't be easier to follow:
> 
> diff --git a/fs/file.c b/fs/file.c
> index 21c0893f2f1d..872a4098c3be 100644
> --- a/fs/file.c
> +++ b/fs/file.c
> @@ -672,6 +672,32 @@ int __close_fd(struct files_struct *files, unsigned fd)
>  }
>  EXPORT_SYMBOL(__close_fd); /* for ksys_close() */
>  
> +static inline void __range_cloexec(struct files_struct *cur_fds,
> +				   unsigned int fd, unsigned max_fd)
> +{
> +	struct fdtable *fdt;
> +	spin_lock(&cur_fds->file_lock);
> +	fdt = files_fdtable(cur_fds);
> +	while (fd <= max_fd)
> +		__set_close_on_exec(fd++, fdt);

Doesn't that want to be

  bitmap_set(fdt->close_on_exec, fd, max_fd - fd + 1)

to do word-at-a-time? I assume this would mostly be called with (3, ~0U)
as arguments or something like that.

Rasmus
