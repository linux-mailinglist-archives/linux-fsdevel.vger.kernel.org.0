Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87DD627FE5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2019 16:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730865AbfEWOhn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 May 2019 10:37:43 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:50773 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730790AbfEWOhi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 May 2019 10:37:38 -0400
Received: by mail-it1-f195.google.com with SMTP id a186so198621itg.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 May 2019 07:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DahHECUK2AF1J12XBLs2bKF9FH9rjTuzkU7KMfzCZKg=;
        b=YbCZESmbvCwAQCtgJ5vNBW4fzZ0rmez/RQRMkvQ2gBf8m2vQZ7pZbh6Bnf/yhxyKVI
         53LigfqSgxhhyV3cJwQAxeBYmchcYj4+L6sb6hM6ANhJ3YzqD5nVaV8VUWyXmRfwM0Js
         s0qbXNd2fPwKrwA6FMsqrbW+O3oe4jc4dfMVogKbtgea8qKxT3IcnEz6YQoGlNR0pY3m
         WBeNhDCmn5OB53HQT4TWeQ+Gay0cWaoJ8RQtor16rRwite01Brwb3BNAlCJ/+wg1v28J
         HJ9HsyrSvI8gu0Uy/czVhZ9L/NkkHH+hj2hN0LXZm7YA7qWQlzwpnrEcctNdcL7rOP5V
         pe4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DahHECUK2AF1J12XBLs2bKF9FH9rjTuzkU7KMfzCZKg=;
        b=sv3IbN8/ZlVRIR4KoSFfbvaC++P8GIWBDRD25lVF4H1feidPOQ+nQxk7Yhzy8zbfNg
         oEhQg66zDqp2nydpf3H5wcZm5bKEzvAA4eJvApFffmTAV3yHd93dqgSAM9YopfqIsdIO
         Gqy3i/vdVN2dhDkqZJcWNXul7HX6iLp2a+wMMof7AbfXxXjmlA/yM4sQdNRlJjB79RWe
         ZanZ/9v9rBABWHkVX2oDe9EgjfzNEtm/YNUitgFJ1cLI3Qj9PdxA6DwzICYRNUH6i4iA
         gU8qJ2u1sSVfaiOAAkDvrzefXkKdZCgYyvnvr+S32MLW0NwadjYUj0IUfvvJb324jHfS
         PEkA==
X-Gm-Message-State: APjAAAX1fOv9Hmx+RYp7ofx+vDg56Zb0Sj22o7SGeSBcKH8o4cg8LrTa
        KNaSfm1AEdTkxYC3N+xBRNtcfQ==
X-Google-Smtp-Source: APXvYqxCsu1nKhbS62harFEpfvgZRg7+s7a4b8LII1alkH5yuzE7xzETotobVwglIakCJJls3jgHwg==
X-Received: by 2002:a02:9381:: with SMTP id z1mr24471487jah.130.1558622256966;
        Thu, 23 May 2019 07:37:36 -0700 (PDT)
Received: from brauner.io ([172.56.12.187])
        by smtp.gmail.com with ESMTPSA id l186sm4603784itb.5.2019.05.23.07.37.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 23 May 2019 07:37:36 -0700 (PDT)
Date:   Thu, 23 May 2019 16:37:26 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Jann Horn <jannh@google.com>
Cc:     Oleg Nesterov <oleg@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Florian Weimer <fweimer@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Todd Kjos <tkjos@android.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [PATCH v1 1/2] open: add close_range()
Message-ID: <20190523143725.y67czx4jxsy6yqrj@brauner.io>
References: <20190522155259.11174-1-christian@brauner.io>
 <20190522165737.GC4915@redhat.com>
 <20190523115118.pmscbd6kaqy37dym@brauner.io>
 <CAG48ez0Uq2GQnQsuPkNrDdJVku_6GPeZ_5F_-5J3iy2CULr0_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAG48ez0Uq2GQnQsuPkNrDdJVku_6GPeZ_5F_-5J3iy2CULr0_Q@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 23, 2019 at 04:32:14PM +0200, Jann Horn wrote:
> On Thu, May 23, 2019 at 1:51 PM Christian Brauner <christian@brauner.io> wrote:
> [...]
> > I kept it dumb and was about to reply that your solution introduces more
> > code when it seemed we wanted to keep this very simple for now.
> > But then I saw that find_next_opened_fd() already exists as
> > find_next_fd(). So it's actually not bad compared to what I sent in v1.
> > So - with some small tweaks (need to test it and all now) - how do we
> > feel about?:
> [...]
> > static int __close_next_open_fd(struct files_struct *files, unsigned *curfd, unsigned maxfd)
> > {
> >         struct file *file = NULL;
> >         unsigned fd;
> >         struct fdtable *fdt;
> >
> >         spin_lock(&files->file_lock);
> >         fdt = files_fdtable(files);
> >         fd = find_next_fd(fdt, *curfd);
> 
> find_next_fd() finds free fds, not used ones.
> 
> >         if (fd >= fdt->max_fds || fd > maxfd)
> >                 goto out_unlock;
> >
> >         file = fdt->fd[fd];
> >         rcu_assign_pointer(fdt->fd[fd], NULL);
> >         __put_unused_fd(files, fd);
> 
> You can't do __put_unused_fd() if the old pointer in fdt->fd[fd] was
> NULL - because that means that the fd has been reserved by another
> thread that is about to put a file pointer in there, and if you
> release the fd here, that messes up the refcounting (or hits the
> BUG_ON() in __fd_install()).
> 
> > out_unlock:
> >         spin_unlock(&files->file_lock);
> >
> >         if (!file)
> >                 return -EBADF;
> >
> >         *curfd = fd;
> >         filp_close(file, files);
> >         return 0;
> > }
> >
> > int __close_range(struct files_struct *files, unsigned fd, unsigned max_fd)
> > {
> >         if (fd > max_fd)
> >                 return -EINVAL;
> >
> >         while (fd <= max_fd) {
> 
> Note that with a pattern like this, you have to be careful about what
> happens if someone gives you max_fd==0xffffffff - then this condition
> is always true and the loop can not terminate this way.
> 
> >                 if (__close_next_fd(files, &fd, maxfd))
> >                         break;
> 
> (obviously it can still terminate this way)

Yup, this was only a quick draft.
I think the dumb simple thing that I did before was the best way to do
it for now.
I first thought that the find_next_open_fd() function already exists but
when I went to write a POC for testing realized it doesn't anyway.
