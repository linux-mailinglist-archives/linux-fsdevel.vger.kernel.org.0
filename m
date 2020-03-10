Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E18F21807AA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Mar 2020 20:09:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbgCJTJE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Mar 2020 15:09:04 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:41215 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbgCJTJD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Mar 2020 15:09:03 -0400
Received: by mail-io1-f68.google.com with SMTP id m25so13910240ioo.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Mar 2020 12:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=REgvRIGaQFX0rJ2F2E0SSglQVamoeuGWdGmoF/N5lus=;
        b=HJVoZ3BVHYzJMf4JMkMnAD/QpaYgATC2WqGx7eeKdOmuRZictZ/zGUEUJt4b1gMiXu
         0hawPVlcNtzk8ul9yZ6a3Y6I2WQaEeTlcyn5Z3vQTvShCy89CqDr1vcYG5JRvKrTEs+s
         nGCJPvFnL9RJmti4Z6r3S8VHzjAQ5mxioY1DQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=REgvRIGaQFX0rJ2F2E0SSglQVamoeuGWdGmoF/N5lus=;
        b=KjeEw/ujDz+rec3dfz6xQkCCYv1ym6s2XPBDtGKr0zOJDdNbzkvOpFLo/H9+k4aolU
         EgkL6YntSzaaeMNy1JQFnc1oEh9Uj+IypI1n+4KPAz3eIbMC+vld5xfnSNGYyCN0L4lt
         Z4WaRmr1Yv4LX288BhyHqk90EjE3WEdbm+WHP13GGrI5egEKc2nXQ/VSWoGq4KfXpThQ
         pfZd9P6LdloP03my/1MaMQZM5QyKZU4o/T2KjEv1mpmRPOyMKP2j+Hx9BT4cErBZqOr9
         2VAoDHB/bqlAQ7bhfwcjKb9B7E8DhdkepkgQPUetpDOGRALbeLsXnrRu0MLLYjEFhKcw
         N8Rw==
X-Gm-Message-State: ANhLgQ31HWgkv8AHrRiyAzZfjz+LnlBnxrM0w9uJ4f6GOv34D13yST78
        O4kTxyESmIZ0Y+Drr+DVzRpYsX3UlMi2wHzmYn6dSBE8
X-Google-Smtp-Source: ADFU+vuG+d8Im8838zI+qtuRmWvZmmjvYtfKPkg2IQY7hI/u2Ov9hDcEWzOo40BkQfw9QtWyzDu6ag/5o11778wjtro=
X-Received: by 2002:a5d:934d:: with SMTP id i13mr19073480ioo.154.1583867340913;
 Tue, 10 Mar 2020 12:09:00 -0700 (PDT)
MIME-Version: 1.0
References: <1583270111-76859-1-git-send-email-bo.liu@linux.alibaba.com>
 <CAJfpegtFWqEAV-Jb_KoHihJ5-UpU=JkdxEg_stz6JM5OP_LXMQ@mail.gmail.com> <20200310184640.5djxclzt6gqkq4v3@rsjd01523.et2sqa>
In-Reply-To: <20200310184640.5djxclzt6gqkq4v3@rsjd01523.et2sqa>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 10 Mar 2020 20:08:49 +0100
Message-ID: <CAJfpegtUkfwZXZ977HeC7pJ+2rFVwyr0pk-ru4J7z1-TVafcSQ@mail.gmail.com>
Subject: Re: [PATCH] fuse: make written data persistent after writing
To:     Liu Bo <bo.liu@linux.alibaba.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Miklos Szeredi <mszeredi@redhat.com>, virtio-fs@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 10, 2020 at 7:46 PM Liu Bo <bo.liu@linux.alibaba.com> wrote:
>
> On Tue, Mar 10, 2020 at 11:14:17AM +0100, Miklos Szeredi wrote:
> > On Tue, Mar 3, 2020 at 10:15 PM Liu Bo <bo.liu@linux.alibaba.com> wrote:
> > >
> > > If this is a DSYNC write, make sure we push it to stable storage now
> > > that we've written data.
> >
> > If this is direct I/O then why do we need an fysnc() call?
> >
> > The only thing needed should be correct setting O_DSYNC in the flags
> > field of the WRITE request, and it appears to me that that is already
> > being done.
>
> Given direct IO itself doesn't guarantee FUA or FLUSH, I think we
> still need such a fsync() call to make sure a FUA/FLUSH is sent after
> direct IO.

What I mean is that the server itself can call fsync(2) from the WRITE
request if it finds that fi->flags contains O_DSYNC.

Thanks,
Miklos
