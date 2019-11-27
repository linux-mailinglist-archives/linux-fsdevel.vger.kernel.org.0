Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEB9B10B155
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2019 15:30:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbfK0Oao (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Nov 2019 09:30:44 -0500
Received: from mail-il1-f172.google.com ([209.85.166.172]:46117 "EHLO
        mail-il1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbfK0Oan (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Nov 2019 09:30:43 -0500
Received: by mail-il1-f172.google.com with SMTP id q1so21168624ile.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Nov 2019 06:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=ptLCc+chD9/5P/FEB5njrZbzbaHkLbrZ72eiHctEqeY=;
        b=BB4oevXQKJdDx26LTGjgjDIkECjoVwaxIFr1KV0ozsynRU8PFe7mfT0bGbd3qnaUDT
         tiYj72B9F2CyFln8dS204fQJaGuMMkGgKeZUV51AiWQvuChWvqxO9DF2Aa/fjqarkihS
         Vpj+EeL2rwrCPKT/J+sJ9ddPjfhJ+YZ6haiSk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=ptLCc+chD9/5P/FEB5njrZbzbaHkLbrZ72eiHctEqeY=;
        b=ePIcXW+iXmbbPOh6HvyXDkPJyQkkL7ng2l8iu3w+Vdj9r6uTPeQ69DzkHunG5YOJDF
         QqNZEb6REQxgkmrpIL1kTuA5eG/msrqevZoNte0+fLCjIva7/bKKRa1eXbAY61KZBzTz
         +i3a4JJvgb41wo6L5xIUNKK2zR81AG8gspg20e8lp5YNHcZ4Vb4U1K4Br7E4///6z98n
         e/uPwxrtBxYOPqwbko6C/zWmPBfiTo7RSuXzqxy7jxY+Qbg19Yk9E0cMb4ZlPuNF7YxP
         ig7h3q6BMIdmVYqlKfO0WVc2eszJgpqN+EtTt1dhDjljpl7mRW4+WHXNf/pVNHVH7kbL
         cU/Q==
X-Gm-Message-State: APjAAAVVDq2DQI10TshUDA4qE6ZSVtbyPkcEPDbyh+P8Itq9xhnHOQi4
        Xcbx2cPRKPW0EEL4JSIrOFY9P6NiZB1qBxWJuyMvkGMq0uk=
X-Google-Smtp-Source: APXvYqz9eMuPaxENYXIrALdoEZFupj2xTUPuJbhAntsntbEVfw1JpUVXg1AibOhhfC09RH77j0RC1MJA4wVtkQ0eE1E=
X-Received: by 2002:a92:320f:: with SMTP id z15mr26149499ile.252.1574865041356;
 Wed, 27 Nov 2019 06:30:41 -0800 (PST)
MIME-Version: 1.0
References: <8736e9d5p4.fsf@vostro.rath.org>
In-Reply-To: <8736e9d5p4.fsf@vostro.rath.org>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 27 Nov 2019 15:30:30 +0100
Message-ID: <CAJfpegtOf6mV4m3W1v2N8eOD-ep=tFOhKDCFk+-M3=tzc7wVig@mail.gmail.com>
Subject: Re: Handling of 32/64 bit off_t by getdents64()
To:     fuse-devel <fuse-devel@lists.sourceforge.net>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 27, 2019 at 10:33 AM Nikolaus Rath <Nikolaus@rath.org> wrote:
>
> Hello,
>
> For filesystems like ext4, the d_off values returned by getdents64()
> seem to depend on the kind of process that issues the syscall.
>
> For example, if I compile test program with -m32 I get:
>
> $ ./readdir32
> --------------- nread=616 ---------------
> inode#    file type  d_reclen  d_off   d_name
> 32253478  ???          40  770981411  test_readlog.py
> 32260181  ???          24  776189020  ..
> [...]
>
> If I compile for 64 bit, I get:
>
> $ ./readdir64
> --------------- nread=616 ---------------
> inode#    file type  d_reclen  d_off   d_name
> 32253478  ???          40 3311339950278905338  test_readlog.py
> 32260181  ???          24 3333706456980390508  ..
> [...]
>
> This is despite d_off being declared as ino64_t in the linux_dirent64
> struct.
>
>
> This is presumably intentional, because (again as far as I can tell), if
> getdents64 returns a full 64 bit value for a 32 bit system, libc's
> readdir() will return an error because it cannot fit the value into
> struct dirent.
>
>
> As far as I know, there is no way for a FUSE filesystem to tell if the
> client process is 64 bit or 32 bit. So effectively, a FUSE filesystem is
> limited to using only the lower 32 bits for readdir offsets. Is that
> correct?
>
> This would be quite annoying because it means that passthrough
> filesystems cannot re-use the underlying filesystems d_off values
> (since they will be full 64 bit for a 64 bit FUSE process).
>
>
> Is there a way for a 64 bit process (in this case the FUSE daemon) to
> ask for 32 bit d_off values from getdents64()?

Looking at ext4 d_off encoding, it looks like the simple workaround is
to use the *high* 32 bits of the offset.

Just tried, and this works.  The lower bits are the "minor" number of
the offset, and no issue with zeroing those bits out, other than
increasing the chance of hash collision from practically zero to very
close to zero.

> Would it be feasible to extend the FUSE protocol to include information
> about the available bits in d_off?

Yes.

The relevant bits from ext4 are:

static inline int is_32bit_api(void)
{
#ifdef CONFIG_COMPAT
    return in_compat_syscall();
#else
    return (BITS_PER_LONG == 32);
#endif
}

and:

    if ((filp->f_mode & FMODE_32BITHASH) ||
        (!(filp->f_mode & FMODE_64BITHASH) && is_32bit_api()))
        /* 32bits offset */;
    else
        /* 64bits offset */;

Thanks,
Miklos
