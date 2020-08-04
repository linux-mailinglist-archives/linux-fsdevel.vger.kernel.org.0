Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5888723B1B1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Aug 2020 02:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729313AbgHDAbO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Aug 2020 20:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728329AbgHDAbO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Aug 2020 20:31:14 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04776C06174A
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 Aug 2020 17:31:13 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id t6so13338256qvw.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Aug 2020 17:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Keb4Jl8eGTMNDh85x/MoXRXdhRswB8awzn31D2vbMj0=;
        b=XSTwLSZ1mADWjStO1ZNWRlwInkzdfEkyVSUc8QZ7UMJD2/JREd2lztc/i9omVInOj6
         3gK1qEvMEiseqAKq/F384o3Yp/u51Vrx+lJWgkgq+uqyUlsqbTOPCV4Sg43QaJhFvr+Z
         c7Okotqw3+F9HP7Eh5oNxhVKmZCce3oOW6E5SzaUDtdWQl+Lkt2tnu9kmHllfPWwkoId
         9eaNI28lQOQ738moL42u723ahUZXoYVNrr/aTxt/QKjkG1idXCYYTCyoO3Wk3f4gxFls
         0Zkn7AL88C5G8qpmrudx7OXgchljK+Tb6n1IliP0Mz6AP/ahxAJIogxWdgdfRFsGEfQv
         ulFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Keb4Jl8eGTMNDh85x/MoXRXdhRswB8awzn31D2vbMj0=;
        b=ZKic9+WvtUAlMgtH8Uh8+nHXNgQybHrN8v9etujoWywsYLlmTdyE6J07kU4sHj0TR7
         JhTntz5zABvAlsP0oXatmeyPpmnb5ePlu77XE/wuJhwgy/RYf/I+WBnd1Aymf8nFsGR5
         S9/w4d7wcyMpjP0fQTzZOpbWe0DVaJ1taBPrRe3aw+UtTDW0AXk5mI1W5/t7ZJ4yMey3
         gqDTng6yELlMZ00B+yCweyqHm5XDx+0GfNT3RZ9YLQchWFCunyucBFiLRpZoyZo6U5/l
         kapnd9e9NPpl+zV8/6ThyZ1K2oreKDpBCvc3/znnGEfKlDPSCCtINaBLKZs0ucHYuLdN
         EEmg==
X-Gm-Message-State: AOAM530lTH02IMpKEav1q1aqAhaje68+tjQKq6n1/Xm4Gisf/Z16tvsp
        FZrkLhfGDOYferZjYN1SSPrJhX2Ied5Sjsc0WsSBzg==
X-Google-Smtp-Source: ABdhPJwzMvPWvyBxmyaZCvmqJjM3a+Az+ZwSYEPaUKkscBswzjvkcy7RYCd4ipv9IlL5fWfBRoT2auKF3Vsb/KH734w=
X-Received: by 2002:a0c:9b96:: with SMTP id o22mr10770174qve.213.1596501071827;
 Mon, 03 Aug 2020 17:31:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200803144719.3184138-1-kaleshsingh@google.com> <20200803144719.3184138-2-kaleshsingh@google.com>
In-Reply-To: <20200803144719.3184138-2-kaleshsingh@google.com>
From:   Joel Fernandes <joelaf@google.com>
Date:   Mon, 3 Aug 2020 20:30:59 -0400
Message-ID: <CAJWu+orzhpO5hPfUWd0EJp-ViWMifeQ_Ng+R4fHf7xabL+Bggw@mail.gmail.com>
Subject: Re: [PATCH 1/2] fs: Add fd_install file operation
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-fsdevel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        Ioannis Ilkos <ilkos@google.com>,
        John Stultz <john.stultz@linaro.org>,
        "Cc: Android Kernel" <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 3, 2020 at 10:47 AM 'Kalesh Singh' via kernel-team
<kernel-team@android.com> wrote:
>
> Provides a per process hook for the acquisition of file descriptors,
> despite the method used to obtain the descriptor.
>

Hi,
So apart from all of the comments received, I think it is hard to
understand what the problem is, what the front-end looks like etc.
Your commit message is 1 line only.

I do remember some of the challenges discussed before, but it would
describe the problem in the commit message in detail and then discuss
why this solution is fit.  Please read submitting-patches.rst
especially "2) Describe your changes".

thanks,

 - Joel


> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> ---
>  Documentation/filesystems/vfs.rst | 5 +++++
>  fs/file.c                         | 3 +++
>  include/linux/fs.h                | 1 +
>  3 files changed, 9 insertions(+)
>
> diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
> index ed17771c212b..95b30142c8d9 100644
> --- a/Documentation/filesystems/vfs.rst
> +++ b/Documentation/filesystems/vfs.rst
> @@ -1123,6 +1123,11 @@ otherwise noted.
>  ``fadvise``
>         possibly called by the fadvise64() system call.
>
> +``fd_install``
> +       called by the VFS when a file descriptor is installed in the
> +       process's file descriptor table, regardless how the file descriptor
> +       was acquired -- be it via the open syscall, received over IPC, etc.
> +
>  Note that the file operations are implemented by the specific
>  filesystem in which the inode resides.  When opening a device node
>  (character or block special) most filesystems will call special
> diff --git a/fs/file.c b/fs/file.c
> index abb8b7081d7a..f5db8622b851 100644
> --- a/fs/file.c
> +++ b/fs/file.c
> @@ -616,6 +616,9 @@ void __fd_install(struct files_struct *files, unsigned int fd,
>  void fd_install(unsigned int fd, struct file *file)
>  {
>         __fd_install(current->files, fd, file);
> +
> +       if (file->f_op->fd_install)
> +               file->f_op->fd_install(fd, file);
>  }
>
>  EXPORT_SYMBOL(fd_install);
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index f5abba86107d..b976fbe8c902 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1864,6 +1864,7 @@ struct file_operations {
>                                    struct file *file_out, loff_t pos_out,
>                                    loff_t len, unsigned int remap_flags);
>         int (*fadvise)(struct file *, loff_t, loff_t, int);
> +       void (*fd_install)(int, struct file *);
>  } __randomize_layout;
>
>  struct inode_operations {
> --
> 2.28.0.163.g6104cc2f0b6-goog
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
