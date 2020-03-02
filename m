Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53A77175798
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2020 10:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbgCBJrk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Mar 2020 04:47:40 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:34465 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726956AbgCBJrk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Mar 2020 04:47:40 -0500
Received: by mail-il1-f195.google.com with SMTP id n11so3734341ild.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Mar 2020 01:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Z95wMvnasax5Jw3pk7t4Bey6HFtuXVCo+Ex6Fq0tizk=;
        b=kAncW+S1a/yDnhBhsf3Nk2MVGPJgPmNNESItSJhaZZXBaVgwVFSya8+iKM8dL2LSKk
         sEGdhSUZh6voQT4Rdci+ePh7RvoNwj/PKlZnfd0FeLEk9wtdUiCpvt0Pvm7CprC9TscJ
         NrVGVO2FLeY5EjMy/MzXILiRYzUwMAhs325Ps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=Z95wMvnasax5Jw3pk7t4Bey6HFtuXVCo+Ex6Fq0tizk=;
        b=LO0VTleJHcK15he5H08V0xtdiD2c8op04XoFrRnXXgkFgyrg674TlNtlhrBOQ5RHMk
         Air3IS8Hv/x4QaiVpT9BR5Rlc3Bx5A3K/CMXj1Yd5tQGJIZLZnTffsYgbycF7ZKzXOu3
         l9t//AqijuHrfym3+m7zFomNlVP0PhtDsyeQf2QBVGZQHFUD38tfBKYYvOy17dm49Qdl
         rAlzb3Vs3g+VEiMgJOMb8tbrYZLUl+f0PQh3UzVbBEkXsIN3qWuke/q00ZpiGm7uPVKD
         4Io+RBY1IS2oXxCOPXGgL3O5T8d2TgM8KhGagtvEg5FB+viYuTTCtGWyojOkOXa4z9WM
         sJcA==
X-Gm-Message-State: APjAAAWIu0b8HoQEbb75i4WEbjdG66j2YXrR/WSTUJXGWxbItLv1D4F/
        J9B7Ze5C43W8z208AhnqlLfRNcd7IadTTEfNrY+iv5XT
X-Google-Smtp-Source: APXvYqyWuCyORSRaeYjGcMyBsQo8VJzWdI3l7SBQL6Aq2zT7PqDO0iZI+/Rya2UA97uMcQQi0cHHVsNdM30hfmeNVas=
X-Received: by 2002:a92:8847:: with SMTP id h68mr15329876ild.212.1583142459718;
 Mon, 02 Mar 2020 01:47:39 -0800 (PST)
MIME-Version: 1.0
References: <8736as2ovb.fsf@vostro.rath.org>
In-Reply-To: <8736as2ovb.fsf@vostro.rath.org>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 2 Mar 2020 10:47:28 +0100
Message-ID: <CAJfpegupesjdOe=+rrjPNmsCg_6n-67HrS4w2Pm=w4ZrQOdj1Q@mail.gmail.com>
Subject: Re: [fuse] Effects of opening with O_DIRECT
To:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Mar 1, 2020 at 2:20 PM Nikolaus Rath <Nikolaus@rath.org> wrote:
>
> Hi,
>
> What happens if a file (on a FUSE mountpoint) is opened without
> O_DIRECT, has some data in the page cache, and is then opened a second
> with O_DIRECT?
>
> Will reads with O_DIRECT come from the page cache (if there's a hit), or
> be passed through to the fuse daemon?

O_DIRECT read will try first directly, and fall back to the cache on
short or zero return count.

>
> What happens to writes (with and without O_DIRECT, and assuming that
> writeback caching is active)? It seems to me that in order to keep
> consistent, either caching has to be disabled for both file descriptors
> or enabled for both...

This is not a fuse specific problem.   The kernel will try to keep
things consistent by flushing dirty data before an O_DIRECT read.
However this mode of operation is not recommended.  See open(2)
manpage:

       Applications should avoid mixing O_DIRECT and normal I/O  to  the  s=
ame
       file,  and  especially  to  overlapping  byte regions in the same fi=
le.
       Even when the filesystem correctly handles the coherency issues in t=
his
       situation,  overall  I/O  throughput  is likely to be slower than us=
ing
       either mode alone.  Likewise, applications should avoid mixing  mmap=
(2)
       of files with direct I/O to the same files.

[...]
       In summary, O_DIRECT is a potentially powerful tool that should be u=
sed
       with  caution.   It  is  recommended  that  applications  treat  use=
 of
       O_DIRECT as a performance option which is disabled by default.

              "The thing that has always disturbed me about O_DIRECT  is  t=
hat
              the whole interface is just stupid, and was probably designed=
 by
              a  deranged  monkey  on  some  serious   mind-controlling   s=
ub=E2=80=90
              stances."=E2=80=94Linus

Thanks,
Miklos
