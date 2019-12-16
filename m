Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 835FC1219E4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2019 20:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbfLPT1f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Dec 2019 14:27:35 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:33842 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbfLPT1f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Dec 2019 14:27:35 -0500
Received: by mail-oi1-f194.google.com with SMTP id l136so4257300oig.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Dec 2019 11:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0+G9OIzIPCPm1JV6NSLldblOL7vU1hFAd0fconVteSc=;
        b=Ys4Khj8K29YV1vXqYHp0UjjI6Gv7ahLPIwc+IlMeeZLi1fWv3Sh9JSkGHDijyOBZjO
         YZUZ+DVFHUuhj+Hc84OxOpzTQRnFynExXZDiYaKrs/YiS90XD3NPBycZU6npjD7se0eh
         hC1KJGCsZKT6kkkUZgxzUircHYgX6tyznjrS4lfJJlRSUPYS5x4JSjz45AVaB+LmQE6X
         1Bs17tlGfIWNgWm7DG5teWJoKRgezhAv7I5Oi+aK0wDzmZdA2GAknSpF1vkD7oTTg09+
         UFb1rHyaw+4Nwx+4uKIyp2sGChbx6Io2YnWAEqNIei/8qgrw2c/YJL82+rXxK1Kdykr3
         zghw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0+G9OIzIPCPm1JV6NSLldblOL7vU1hFAd0fconVteSc=;
        b=HDJReOISs8kB+Or1h51GyMJr76rOBNOwu5t5GQg74iIV5twuTRSG6Tlrcc01rNOE8y
         afY7O4JBcJZw84qCXRopzxHovOpqEE6XIecNrO/oNN/9KGHkJqjC6vlzh2Njn+xay6ok
         OcEIcUemD4PNpFudMRrvEL2cocpu5AUbEvasHimPJTweNFKyiIKtyPAICVMKKY0Lz3SF
         cO0YUkxgUMQUzuFzzV8Mq0mzHYmNe4oeVnDDlX7zyEicXNXftDhM6EOVTvqpYlt5rs9s
         1XavStypMqDyjnTr8RIU2QHQnLKVU9ptVb5m3mqlvDOfqZbV54njFZJgOXjbJvqxOoj6
         uNkA==
X-Gm-Message-State: APjAAAUOOBEgaDixkZJqT8LNe4jorWJyQN3geik0f1kBiYKVqsGr8afU
        NxiZJVkDY37855UfHv9oI56dXHuTI0XubCqZsz60nA==
X-Google-Smtp-Source: APXvYqyRXHFfszrlmxa4RfBXv+BHx2XxRPac+Y2KuI9sOac77h1orp76XujK/GZ738T6cirXBzNlqEzsJtjD2qgUuzU=
X-Received: by 2002:aca:bb08:: with SMTP id l8mr373285oif.47.1576524454243;
 Mon, 16 Dec 2019 11:27:34 -0800 (PST)
MIME-Version: 1.0
References: <20191213183632.19441-1-axboe@kernel.dk> <20191213183632.19441-7-axboe@kernel.dk>
In-Reply-To: <20191213183632.19441-7-axboe@kernel.dk>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 16 Dec 2019 20:27:07 +0100
Message-ID: <CAG48ez26wpE_K_KGsE8jfjGp3uPc_ioYhTuLv0gSmcVPPxRA3Q@mail.gmail.com>
Subject: Re: [PATCH 06/10] fs: move filp_close() outside of __close_fd_get_file()
To:     Jens Axboe <axboe@kernel.dk>
Cc:     io-uring <io-uring@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 13, 2019 at 7:36 PM Jens Axboe <axboe@kernel.dk> wrote:
> Just one caller of this, and just use filp_close() there manually.
> This is important to allow async close/removal of the fd.
[...]
> index 3da91a112bab..a250d291c71b 100644
> --- a/fs/file.c
> +++ b/fs/file.c
> @@ -662,7 +662,7 @@ int __close_fd_get_file(unsigned int fd, struct file **res)
>         spin_unlock(&files->file_lock);
>         get_file(file);
>         *res = file;
> -       return filp_close(file, files);
> +       return 0;

Above this function is a comment saying "variant of __close_fd that
gets a ref on the file for later fput"; that should probably be
changed to point out that you also still need to filp_close().
