Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1EA823C103
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Aug 2020 22:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728168AbgHDUto (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Aug 2020 16:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727969AbgHDUtn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Aug 2020 16:49:43 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4C6C061756
        for <linux-fsdevel@vger.kernel.org>; Tue,  4 Aug 2020 13:49:42 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id l1so43670413ioh.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Aug 2020 13:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hdbBe3yRhb8UVEdZu437BXB7eaBvTiKuwEkcBB5Ach8=;
        b=lFjcXr9F4a+6cunETjp4ZXM/I9v82oAd3si1GWvBuQeX12mzbQTmu0WziwTImnxUZX
         D5FYlTosNhLxTjnxBTuvFt9IreQCsWSGZW/ZuU0o7Am1OZzI6OC+SuLZF7YUaZ60OnzX
         JIcxq5mu09QLmMwHGcBZrtkA7xMR7O8FTwnhdyNHCFWK2nuqZwothaNVoJwk1Gqknzuz
         iH8QY2MHTTsGmp+za5ED2Cp//msh+V/NPXqq9bs8NkcimZxEj7NgYNUXqZoUtTJHVmCt
         5SLr2qVrm7X3f4UWMMJF99H4Mdbk9SkX+eHzDma1G0+g8hygOADVDxbGdLvBD1hprHoo
         qskQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hdbBe3yRhb8UVEdZu437BXB7eaBvTiKuwEkcBB5Ach8=;
        b=mjWut03AzOqFIvPOFMnTAokhCH3hpjQdQ/mkWI0BUZfh1Fljbl1Fsh2zV/Sj9SGp+N
         XsdFmY8xrnzeOx6pImfWfFNRJZmfjP20SCYhp6FmeGMKJVadwNsRbeTMbY0CjxlSRaTK
         PIbbc/DOmX77KPW6kyhvgeoCS9gIdpbsYOXPvyO3NjGKlLBx7qJ0Vf4K2/+2jMbAF9B0
         Fw6rUwZEbzZoyVoPr3U3nnwsl3ZIH2HTVMEBEaXlqm5i2rYnhmjoCBGhaGiU/hDq9rEB
         StVzlQ16G4EiKsQqiW8TDOKm85XxIGl0QMvgJ01dVV2esV6I3xfhmb9CSNTPZHFbQuBk
         siMA==
X-Gm-Message-State: AOAM531BlslwdGXqxLTL/9KE5Iirds/yxlXEi2tU0TA4Vd7N3AmmPlCV
        woZcnqUhEFZSgm/NwQ1e84B5Fk8oMpkZa3CzsyKUfA==
X-Google-Smtp-Source: ABdhPJwXTcDhzEgVIXrgRbyS+9+17BR8iod+JrmrTu87b8AChpYWoX5iyFIWwgc6RiAq4vxYYbCqbVHuqt4FuPKbV1M=
X-Received: by 2002:a02:3843:: with SMTP id v3mr32714jae.23.1596574181355;
 Tue, 04 Aug 2020 13:49:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200804203155.2181099-1-lokeshgidra@google.com> <20200804204543.GA1992048@gmail.com>
In-Reply-To: <20200804204543.GA1992048@gmail.com>
From:   Lokesh Gidra <lokeshgidra@google.com>
Date:   Tue, 4 Aug 2020 13:49:30 -0700
Message-ID: <CA+EESO6XGpiTLnxPraZqBigY7mh6G2jkHa2PKXaHXpzdrZd4wA@mail.gmail.com>
Subject: Re: [PATCH] Userfaultfd: Avoid double free of userfault_ctx and
 remove O_CLOEXEC
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        casey@schaufler-ca.com, James Morris <jmorris@namei.org>,
        Kalesh Singh <kaleshsingh@google.com>,
        Daniel Colascione <dancol@dancol.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Nick Kralevich <nnk@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Calin Juravle <calin@google.com>, kernel-team@android.com,
        yanfei.xu@windriver.com,
        syzbot+75867c44841cb6373570@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 4, 2020 at 1:45 PM Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Tue, Aug 04, 2020 at 01:31:55PM -0700, Lokesh Gidra wrote:
> > when get_unused_fd_flags returns error, ctx will be freed by
> > userfaultfd's release function, which is indirectly called by fput().
> > Also, if anon_inode_getfile_secure() returns an error, then
> > userfaultfd_ctx_put() is called, which calls mmdrop() and frees ctx.
> >
> > Also, the O_CLOEXEC was inadvertently added to the call to
> > get_unused_fd_flags() [1].
> >
> > Adding Al Viro's suggested-by, based on [2].
> >
> > [1] https://lore.kernel.org/lkml/1f69c0ab-5791-974f-8bc0-3997ab1d61ea@dancol.org/
> > [2] https://lore.kernel.org/lkml/20200719165746.GJ2786714@ZenIV.linux.org.uk/
> >
> > Fixes: d08ac70b1e0d (Wire UFFD up to SELinux)
> > Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
> > Reported-by: syzbot+75867c44841cb6373570@syzkaller.appspotmail.com
> > Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
>
> What branch does this patch apply to?  Neither mainline nor linux-next works.
>
On James Morris' tree (secure_uffd_v5.9 branch).

> - Eric
