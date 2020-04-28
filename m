Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F299C1BB613
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Apr 2020 07:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbgD1Fwu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Apr 2020 01:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726042AbgD1Fwt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Apr 2020 01:52:49 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C89DC03C1AA
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2020 22:52:49 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id l11so15844389lfc.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2020 22:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3FFyhFGwSR5hCCAOzKWLB8ijhIIWqMIumwJnODZevkI=;
        b=iPpk6l/jcA1BeDumj4n6myfu973lYILM4XQEUj2U9UO9NMB5cveMhC0qpE7+ppX0Bl
         NwwXr3ZGwsusuav6BpzkvqFgO+dDUQglvmVXTDQ34IUs8a2xp5D4asH6xNcUEEJimtrk
         4mtm5HgQpZnnJB3kKT+YlVYWlQz4UCEN0OFbe/rh+0C7PyKRYbDsrVajTzK6hSclaXf9
         o1Q7WzNZJ0dH3MybAy06ZSF5gjc5YwjwPRYVGKunKe3DPdG91fHg0qpIwDWdOtTqhqnc
         iqMeT2xCdTZTQFZQroCmrRgQNoR1D0MlyHpyegg+Vs7bRSY3iiysohCImS46eC/xpdrW
         JKcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3FFyhFGwSR5hCCAOzKWLB8ijhIIWqMIumwJnODZevkI=;
        b=pYqjlU3C5uKuXapeGtYug4+p7tlFOVHzPWNKj8nzrS5v8NVGdYL1iya7Ah8aVyFJGT
         peYjfGifRe5n5lNvoJwBRBje6+Ip1+PL4IuwEj1Ssbh99sYtVJTOhaADCOU8kUEPPspG
         ZKQuwmCa0IYc9d2rl/ALhZnqAAB9UNFxVUcqXxMHqpz57ZtapUBEYNhdtA0/XcTLgdWP
         aFVp2fvSh4c5PgkQ8ABS6fnLDShlah/NSyBVmaYdZxArYOZ0gO0NZVfzw5wuMMiJcmku
         30jFnqsI+hy/9dsUahEWTkI4Z0khXoqYZ6/Z2CQeYhUysqlB7QnlFO+uTnzoJzWAjj0x
         rIUA==
X-Gm-Message-State: AGi0PubSPufJP9Ki0GbMC9ZD33FVmCWOcrgMl1w0yo7gGFja5UISBs8i
        SeZ5ibL4rjGeoGZ2nyU79LjJW+l6Yhr6xgB5RcJwqg==
X-Google-Smtp-Source: APiQypLsGvxVV4G5Cnrl0vPMdgLPCcQHgc3r4oAY763aqzMS5nENJMiQ8OSQP6fW4gw42184cs8u8oZQg2fi/pBykaA=
X-Received: by 2002:ac2:5dc6:: with SMTP id x6mr17919772lfq.108.1588053167164;
 Mon, 27 Apr 2020 22:52:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200428032745.133556-1-jannh@google.com> <20200428032745.133556-3-jannh@google.com>
 <CAHk-=wjSYTpTH0X8EcGGJD84tsJS62BN3tC6NfzmjvXdSkFVxg@mail.gmail.com>
In-Reply-To: <CAHk-=wjSYTpTH0X8EcGGJD84tsJS62BN3tC6NfzmjvXdSkFVxg@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 28 Apr 2020 07:52:20 +0200
Message-ID: <CAG48ez0Nz8Bnty2aKdsUeMoXkjc_Bcxr+EcStZ7LBTOgRt1mrQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] coredump: Fix handling of partial writes in dump_emit()
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Mark Salter <msalter@redhat.com>,
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
        linux-c6x-dev@linux-c6x.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 28, 2020 at 5:36 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Mon, Apr 27, 2020 at 8:28 PM Jann Horn <jannh@google.com> wrote:
> >
> > After a partial write, we have to update the input buffer pointer.
>
> Interesting. It seems this partial write case never triggers (except
> for actually killing the core-dump).
>
> Or did you find a case where it actually matters?
>
> Your fix is obviously correct, but it also makes me go "that function
> clearly never actually worked for partial writes, maybe we shouldn't
> even bother?"

Hmm, yeah... I can't really think of cases where write handlers can
spuriously return early without having a pending signal, and a second
write is likely to succeed... I just know that there are some things
that are notorious for returning short *reads* (e.g. pipes, sockets,
/proc/$pid/maps).

Al's commit message refers to pipes specifically; but even at commit
2507a4fbd48a, I don't actually see where pipe_write() could return a
short write without a page allocation failure or something like that.

So maybe you're right and we should just get rid of it...
