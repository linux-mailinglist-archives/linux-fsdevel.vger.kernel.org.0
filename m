Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 266B18A071
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2019 16:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727764AbfHLOL4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Aug 2019 10:11:56 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39728 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727206AbfHLOLz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Aug 2019 10:11:55 -0400
Received: by mail-qk1-f193.google.com with SMTP id 125so3974702qkl.6;
        Mon, 12 Aug 2019 07:11:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HckXkSELBT5jyRopE2pzV3JrBcZaAIu4qF7LSK+P/Zk=;
        b=Le6/ABehm9ETT3puLLGQvgwqe8JavRVTGi/pbQF7plDOxMcDXm16SYrE6mLxav5ZBO
         dMvA8Vdd5jBWf2FyP+ttnWFWtHZ84WDUP4gW6R8Fvg6ee2VWueZG5Jiqv/FEHeypiMzW
         bcDWHxIQGEgrYCp2ZG4oJUBNQe5jF331dQO+c9qj8gMnUgOm7YgF6t6mDbM6UjmnECc/
         S7xBP6aud+w4DBN2DTYBotlDbOPNHMTVF62bnI7M7TB4kSVvyKgjraTDT7QPBT4Np8H/
         HWK/Hxwj4T46cvmXeOzLxNOIPrN+ED9B3mV8FpyDZpDv27y6ILvL0GSu3UZrtCYcVGJT
         18TA==
X-Gm-Message-State: APjAAAWJ4P2+Zx2olBZ4OuAmDBhjbXOXANAnHSBw5zjV0bJFZ4JToosX
        G+IESdP4CTuQFjzrMiW4A86Y42uzKNebkl6e5wM=
X-Google-Smtp-Source: APXvYqxtt7OhOLMOBKJ7ckgLW8+yi7AHTbnlSXtQb5z7c1RrTlQlkHiOx9q+BjSXgB4EEwuNQuPQFcogoxaDzLeahwc=
X-Received: by 2002:a05:620a:b:: with SMTP id j11mr30315011qki.352.1565619114553;
 Mon, 12 Aug 2019 07:11:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190730014924.2193-1-deepa.kernel@gmail.com> <20190730014924.2193-5-deepa.kernel@gmail.com>
 <c508fe0116b77ff0496ebb17a69f756c47be62b7.camel@codethink.co.uk>
 <CABeXuvruROn7j1DiCDbP6MLBt9SB4Pp3HoKqcQbUNPDJgGWLgw@mail.gmail.com> <53df9d81bfb4ee7ec64fabf1089f91d80dceb491.camel@codethink.co.uk>
In-Reply-To: <53df9d81bfb4ee7ec64fabf1089f91d80dceb491.camel@codethink.co.uk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 12 Aug 2019 16:11:38 +0200
Message-ID: <CAK8P3a0CADLUeXvsBHNAC8ekLoo0o0uYz2arBqZ=1N+Xp8HNvA@mail.gmail.com>
Subject: Re: [Y2038] [PATCH 04/20] mount: Add mount warning for impending
 timestamp expiry
To:     Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc:     Deepa Dinamani <deepa.kernel@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 12, 2019 at 3:25 PM Ben Hutchings
<ben.hutchings@codethink.co.uk> wrote:
> On Sat, 2019-08-10 at 13:44 -0700, Deepa Dinamani wrote:
> > On Mon, Aug 5, 2019 at 7:14 AM Ben Hutchings
> > <ben.hutchings@codethink.co.uk> wrote:
> > > On Mon, 2019-07-29 at 18:49 -0700, Deepa Dinamani wrote:
> > > > The warning reuses the uptime max of 30 years used by the
> > > > setitimeofday().
> > > >
> > > > Note that the warning is only added for new filesystem mounts
> > > > through the mount syscall. Automounts do not have the same warning.
> > > [...]
> > >
> > > Another thing - perhaps this warning should be suppressed for read-only
> > > mounts?
> >
> > Many filesystems support read only mounts only. We do fill in right
> > granularities and limits for these filesystems as well. In keeping
> > with the trend, I have added the warning accordingly. I don't think I
> > have a preference either way. But, not warning for the red only mounts
> > adds another if case. If you have a strong preference, I could add it
> > in.
>
> It seems to me that the warning is needed if there is a possibility of
> data loss (incorrect timestamps, potentially leading to incorrect
> decisions about which files are newer).  This can happen only when a
> filesystem is mounted read-write, or when a filesystem image is
> created.
>
> I think that warning for read-only mounts would be an annoyance to
> users retrieving files from old filesystems.

I agree, the warning is not helpful for read-only mounts. An earlier
plan was to completely disallow writable mounts that might risk an
overflow (in some configurations at least). The warning replaces that
now, and I think it should also just warn for the cases that would
otherwise have been dangerous.

       Arnd
