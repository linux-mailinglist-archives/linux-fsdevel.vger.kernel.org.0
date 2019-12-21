Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3547F128665
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Dec 2019 02:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbfLUBqO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Dec 2019 20:46:14 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44999 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbfLUBqN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Dec 2019 20:46:13 -0500
Received: by mail-ed1-f68.google.com with SMTP id bx28so10274843edb.11
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Dec 2019 17:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e12Mnu5DiWBdZFxNKin4JTRmUKOLU+wR6ztAL37zhAQ=;
        b=LTNBj34a/5X3efwYU6hSdfbjHgGkwrDz3BppIDQzVdomaBcPJYPjji/5CWcuX5eiuK
         nRtByNprFnPdf5vqKaOTpOXOo0r1yi89jhIVZ5tvRlCRIqmSzPUAoDg7I7HGa239Azzh
         yAiO/3eRLlEmi90xDuUgTzfU6okfFdGuZxqqs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e12Mnu5DiWBdZFxNKin4JTRmUKOLU+wR6ztAL37zhAQ=;
        b=hHyHhUIHuVF9yM+JtJuNWq9faalzehC4WOeclLSRW0oqpSPtc2G2zxvUbgsoWZ7hmW
         0rND/v0sWgUGElFNoNI8jLS0v99pi9twagdqeX6Wl5Rk4zSlICWslV/1A8nBpkpzOVdb
         K0hMPRfEn9rd7+E4prIe9ZXFtbvPR8XxpTu0rooKQnbzSsBX2jl2rn1bX1XUI0b4JsdU
         +wW2hKW0ayY89OF3E7yNh4Vy6ww58rnBIPWp3lud1v+hY88LgxTlRrKV610Lh4fdDDLA
         3gfV2Leqvzhjwf6QhqW0g3eWYSvfq4Wu9dIHnnW/foGa8G7MKgK5bvGjBqaLmSGSwQfO
         SMSg==
X-Gm-Message-State: APjAAAVDm4N0ZYR3ULjVm2AistyyWpRI1KrejSwkPInYmdWh18ZQn0S3
        UyGuuaPhAvO2dLl9jy4k6sk5x5iPTyI4WXBFDWKgIQ==
X-Google-Smtp-Source: APXvYqxb8UQLCVS8ZHvwXwLPP+w/fQZABPHqVecdCzSZ6Hw7QsjoOp76JDhiyTTOimtqSFsSY7HEMzdgklJ+w9vCSHM=
X-Received: by 2002:a50:cc08:: with SMTP id m8mr19431615edi.263.1576892770667;
 Fri, 20 Dec 2019 17:46:10 -0800 (PST)
MIME-Version: 1.0
References: <20191220232810.GA20233@ircssh-2.c.rugged-nimbus-611.internal> <20191221002734.7rz6lcdrshrrlnqf@yavin.dot.cyphar.com>
In-Reply-To: <20191221002734.7rz6lcdrshrrlnqf@yavin.dot.cyphar.com>
From:   Sargun Dhillon <sargun@sargun.me>
Date:   Fri, 20 Dec 2019 17:45:34 -0800
Message-ID: <CAMp4zn9ivYPP1Sfu48EX897M4JAVXvK+NQB4NZ5=XPM_saJu+g@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] pid: Introduce pidfd_getfd syscall
To:     Aleksa Sarai <asarai@suse.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        =?UTF-8?Q?Emilio_Cobos_=C3=81lvarez?= <ealvarez@mozilla.com>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Gian-Carlo Pascutto <gpascutto@mozilla.com>,
        Jed Davis <jld@mozilla.com>, Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian.brauner@ubuntu.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 20, 2019 at 4:27 PM Aleksa Sarai <asarai@suse.de> wrote:
>
> On 2019-12-20, Sargun Dhillon <sargun@sargun.me> wrote:
> > diff --git a/include/uapi/linux/pidfd.h b/include/uapi/linux/pidfd.h
> > new file mode 100644
> > index 000000000000..0a3fc922661d
> > --- /dev/null
> > +++ b/include/uapi/linux/pidfd.h
> > @@ -0,0 +1,10 @@
> > +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> > +#ifndef _UAPI_LINUX_PIDFD_H
> > +#define _UAPI_LINUX_PIDFD_H
> > +
> > +struct pidfd_getfd_options {};
>
> Are empty structs well-defined in C (from memory, some compilers make
> them non-zero in size)? Since we probably plan to add a flags field in
> the future anyway, why not just have a __u64 flags which must be zeroed?
>
It's allowed in GCC:
https://gcc.gnu.org/onlinedocs/gcc-8.1.0/gcc/Empty-Structures.html

I can add an __aligned_u64 flags for now, and just say something like
"reserved". This will also solve the latter issue, and I'll just use
copy_struct_from_user,
as long as Christian is okay with having an unused (reserved) flag member.


> > +     f = fdget(pidfd);
> > +     if (!f.file)
> > +             return -EBADF;
> > +
> > +     pid = pidfd_pid(f.file);
> > +     if (IS_ERR(pid)) {
> > +             ret = PTR_ERR(pid);
> > +             goto out;
> > +     }
> > +
> > +     ret = pidfd_getfd(pid, fd);
> > +
> > +out:
> > +     fdput(f);
> > +     return ret;
> > +}
> > --
> > 2.20.1
>
> --
> Aleksa Sarai
> Senior Software Engineer (Containers)
> SUSE Linux GmbH
> <https://www.cyphar.com/>
