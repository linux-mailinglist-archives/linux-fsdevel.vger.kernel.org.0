Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30385212D7D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jul 2020 21:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbgGBT6h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jul 2020 15:58:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57043 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726003AbgGBT6g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jul 2020 15:58:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593719915;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BCLQe5LsYyu8+abDQmSCBVAAF5BIKekyAy1XEbhzlKo=;
        b=WrzfthOdnJ4VxUNRACDL7jlfh6YhN4WgiCnafs6oQkLRHu5gI/AImRgXQmdP3W/tqldTFd
        R4wnNxYT7TnA5b5SvvpMUICjcfraH7kQnKVudGgwkoKCHsKI3RQsm+cBS+DRQcdXz9n/Mi
        4BGUuNidSBeU9WTh/B1fYW8qeiv4BAA=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-1IwYrZ-MPsuN34CDYyOpwA-1; Thu, 02 Jul 2020 15:58:33 -0400
X-MC-Unique: 1IwYrZ-MPsuN34CDYyOpwA-1
Received: by mail-oo1-f71.google.com with SMTP id a24so5192180oos.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Jul 2020 12:58:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BCLQe5LsYyu8+abDQmSCBVAAF5BIKekyAy1XEbhzlKo=;
        b=JPEv8vG+LETpziajr1yj8/BJ2qElAijzb1w9G2RGMHCo6Mj8bS0gT67MXkb3cG4xx8
         BAO9BSoRqwUxMOFAane92UxOHPtzxzSnxrK0Fwk/F/J9vFiIjvdEEXgVIDguQb4Qqi/B
         Mbc4ciC6dUmnmKTlY4mEoLkYM8pYdPBO5sdiRdvluMd3BbpxD3s2brVh6T5W2EWu1AwD
         zb2Xa875H2B3XFhaF+wN4QR8vgPLt5NYc+nNHgZKQzJcqvih4dap27M1XW0gj5eUAevC
         gQ6dReieM+Kz1g4TGeBdOZs+j30VLxjCfPZSy/3zzxq8ktl8564T7yXaZ+zTct4eJCU7
         iVSw==
X-Gm-Message-State: AOAM532wRyL/dd7AcHldhVAxLCuG/jboLbkU62R788rJEvEQ5EoLTlVG
        7NrMESWOFCaND7ruUcD2G+VACyhF0KmFOWAR9PKnrlxgU8bdaeG/WSyzdEfmNV/A23qfiotR4Qd
        4AuH6Y9IwetscP34Go0zmBRhNaF5SKfz8KPnvL14ltw==
X-Received: by 2002:aca:494d:: with SMTP id w74mr7056886oia.72.1593719912199;
        Thu, 02 Jul 2020 12:58:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw1L6FpDy+eyJr4Pj9GcmJ4apoM6n8berudx0byqdTDebDSJ2HNON1jP0UpltmJ0Pff2egMjbmK6hUutlfdI4E=
X-Received: by 2002:aca:494d:: with SMTP id w74mr7056871oia.72.1593719911999;
 Thu, 02 Jul 2020 12:58:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200702165120.1469875-1-agruenba@redhat.com> <20200702165120.1469875-3-agruenba@redhat.com>
 <CAHk-=wgpsuC6ejzr3pn5ej5Yn5z4xthNUUOvmA7KXHHGynL15Q@mail.gmail.com>
In-Reply-To: <CAHk-=wgpsuC6ejzr3pn5ej5Yn5z4xthNUUOvmA7KXHHGynL15Q@mail.gmail.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Thu, 2 Jul 2020 21:58:20 +0200
Message-ID: <CAHc6FU5_JnK=LHtLL9or6E2+XMwNgmftdM_V71hDqk8apawC4A@mail.gmail.com>
Subject: Re: [RFC 2/4] fs: Add IOCB_NOIO flag for generic_file_read_iter
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 2, 2020 at 8:06 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Thu, Jul 2, 2020 at 9:51 AM Andreas Gruenbacher <agruenba@redhat.com> wrote:
> > Add an IOCB_NOIO flag that indicates to generic_file_read_iter that it
> > shouldn't trigger any filesystem I/O for the actual request or for
> > readahead.  This allows to do tentative reads out of the page cache as
> > some filesystems allow, and to take the appropriate locks and retry the
> > reads only if the requested pages are not cached.
>
> This looks sane to me, except for this part:
> >                 if (!PageUptodate(page)) {
> > -                       if (iocb->ki_flags & IOCB_NOWAIT) {
> > +                       if (iocb->ki_flags & (IOCB_NOWAIT | IOCB_NOIO)) {
> >                                 put_page(page);
> >                                 goto would_block;
> >                         }
>
> This path doesn't actually initiate reads at all - it waits for
> existing reads to finish.
>
> So I think it should only check for IOCB_NOWAIT.
>
> Of course, if you want to avoid both new reads to be submitted _and_
> avoid waiting for existing pending reads, you should just set both
> flags, and you get the semantics you want. So for your case, this may
> not make any difference.

Indeed, in the gfs2 case, waiting for existing pending reads should be
fine. I'll send an update after some testing.

Thanks,
Andreas

