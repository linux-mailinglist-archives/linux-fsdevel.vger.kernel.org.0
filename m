Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2862112059D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2019 13:30:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727512AbfLPM2l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Dec 2019 07:28:41 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:39489 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727241AbfLPM2l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Dec 2019 07:28:41 -0500
Received: by mail-il1-f196.google.com with SMTP id x5so2306188ila.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Dec 2019 04:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yA9N5FQVJYEeL+u0+bDKbIT1ODRp3J/S00fH7mGzMNM=;
        b=kkxCn4Z7k2oM/eJzTh3iGnB5DR7rCnlSAJ1u38oyW1uGoyF/g1FRq+EWj64SVgeVOL
         2YgXJK7CQGpdJO3oSPN9f3+iz97RclGdS7Yl8NXeKeu/5zsMmd2mwgRIjp29XhUNbhqQ
         C5lpQUjSyjQu5Y45OwvzeU426K3mNN0k8xexNx6u1hFln8t6QbDP1S9JeQP7OWgkmZ94
         DbZ4A1bz54pBNGjWAOztbCUiyIvRYThdTm3LyFzmu4YRjMQsty5onw5LPCNfPksUEyWk
         ngatZj+OQxepVZvCxnZjoWk3mdTYa5D3ZpsUHLz+pcqgcQtDI4gr7enJotLdlEZnk6rq
         OEfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yA9N5FQVJYEeL+u0+bDKbIT1ODRp3J/S00fH7mGzMNM=;
        b=RojZTzdGyZUHftcQ8jmDv9/mJyiN1QqMvGFjvhi0DAlwZSsEtixHMPsKsbjfeG1930
         YZbpWdbATcDXdf30MpZ73vmbxXP+sfLzTuly+A+MqgSKB7uaSoDj9njHA9WDT+5/nixe
         qj0m5RC4D3nIu4C+zqs/8t6lkUe5T5hBgnWlfdGip5FMxP9Ks1yzRZUlGShpZ/GVlqrH
         dn8vLIjC8hSbx0dilI08/dubWUzgNcw6ChQugQfSMg+7JCXNu6H3ldfL19EcEuV/8xP/
         Er8cgG9QVFkNFRP+kR/wVwKdFHm+me171Pje9TFf3xypaTntznoWzWfBuD06Pyw2jpz5
         u/IQ==
X-Gm-Message-State: APjAAAUUD7OwKebhiqJ2JSXb1o5WhpvhUPWxFI+QE6Us8ApndiIxi3z7
        o9xuSC+AHGxRRCpsTK+ne1vvOLzJQ/l6h169kwQ=
X-Google-Smtp-Source: APXvYqw2AjwgqslfFW8eWW7ik3IUThpMPg8pAqfYGz67y40D8uWAyddPZW42hLZJ2/XXDEReU+j9aGSH5vgBYRDohoY=
X-Received: by 2002:a92:81cb:: with SMTP id q72mr11889936ilk.275.1576499320404;
 Mon, 16 Dec 2019 04:28:40 -0800 (PST)
MIME-Version: 1.0
References: <2759fc54-9576-aaa0-926a-cad9d09d388c@cea.fr>
In-Reply-To: <2759fc54-9576-aaa0-926a-cad9d09d388c@cea.fr>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 16 Dec 2019 14:28:29 +0200
Message-ID: <CAOQ4uxh6pMeNGXDCU2c1v9yRnCjbyr50mFF4y1FphjFM8+yYKQ@mail.gmail.com>
Subject: Re: open_by_handle_at: mount_fd opened with O_PATH
To:     quentin.bouget@cea.fr
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        MARTINET Dominique 606316 <dominique.martinet@cea.fr>,
        Andreas Dilger <adilger@whamcloud.com>,
        NeilBrown <neilb@suse.com>, Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 16, 2019 at 11:39 AM <quentin.bouget@cea.fr> wrote:
>
> Hello,
>
> I recently noticed that the syscall open_by_handle_at() automatically
> fails if
> its first argument is a file descriptor opened with O_PATH. I looked at
> the code
> and saw no reason this could not be allowed. Attached to this mail are a
> a reproducer and the patch I came up with.
>
> I am not quite familiar with the kernel's way of processing patches. Any
> pointer
> or advice on this matter is very welcome.
>

See similar patch by Miklos to do the same for f*xattr() syscalls that
looks simpler:
https://lore.kernel.org/linux-fsdevel/20191128155940.17530-8-mszeredi@redhat.com/

Al, any objections to making this change?

Thanks,
Amir.
