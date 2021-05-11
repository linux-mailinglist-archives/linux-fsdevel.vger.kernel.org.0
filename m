Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67C5637AD62
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 May 2021 19:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbhEKRxJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 May 2021 13:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbhEKRxI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 May 2021 13:53:08 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E469C06175F
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 May 2021 10:52:01 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id j26so20243918edf.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 May 2021 10:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vvtm8n5cG3jzsceNHvZusZOhtfG69GGyP0C0zXimiGg=;
        b=H0AsqdZCMhypi9/Qd7/1eUPAVczkGpwzNdPrEzyRmHk3+xGYRUzHdDlO2l4ucRTL8I
         6IkWY+o747IONKRbHjInbulgo0QHOF+Aog+9sCymBmOTGkGLMG+u9jruv/UZbKRmL6Hs
         djJGJfy02eav+9cJ/e8taZvmfCdpWKwopL9l1L00vGTndNfe8I1Ba0qFSrrwJA5o7Fa2
         kypHmxkIMZ4AZTUMiSVLWlzzQG450CuwCzyuG27tqQfsnYHhRA1T87hFThJfEPtkcb4Y
         ue4D2yBkATCGXbxXcVfdq4bXxs/UCpwDO9F00VAa9ugcnvVl8Xt3EZbMRGFEais4Tdh5
         EGMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vvtm8n5cG3jzsceNHvZusZOhtfG69GGyP0C0zXimiGg=;
        b=IdGC+Fv0JXwHqKNvOyYYEGvUfknafRyxjHwiFDeqgvDe1QCTwiekH/f/fX+bN1MSoz
         Efy7RAM2u9js6JWExjk3k8bBvcBQnAyrzKhQ6VvH5nK8gyCfxsU0uFu9SszFOfnS6dWq
         WPxNlW5ZbEd9rKZYJklwtD463x8AISqv7otmkzL+u9udQaXDdsgA9FfkrWOQ/LZk3hOE
         5C4zRWQi1ablkpvPfj3QxuqS+PUekYOI5wsIhqEK3FiIEacVCL6AU4uB/SI4SpkTkwrE
         2DofadY8AqX7PrRnUEpJ3+IuHdLFuu91hyEXNbStvq5NxdBe4b96dMupcg7og0ce2jQU
         6mVQ==
X-Gm-Message-State: AOAM531HLIGlfwyP3lwRWQUZevpcIApbeX865fAM02LmViJtkmHMHZ75
        wRmn2iK0PWiMyVL791iQncr8OSFUjRR8Q8upFqCSHpw+wXQ5
X-Google-Smtp-Source: ABdhPJwdWMqdXYacKcJJowhKXF8ZQ0FIAVm666XBBWORfGjqUYLRbHiBohY3kurt7w0lB0ANXSdmCBIBLwgMolCf7vo=
X-Received: by 2002:a50:ed0c:: with SMTP id j12mr37675663eds.12.1620755519859;
 Tue, 11 May 2021 10:51:59 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1619811762.git.rgb@redhat.com> <bda073f2a8b11000ef40cf8b965305409ee88f44.1619811762.git.rgb@redhat.com>
 <CAHC9VhShi4u26h5OsahveQDNxO_uZ+KgzGOYEp5W7w6foA-uKg@mail.gmail.com> <20210511171356.GN3141668@madcap2.tricolour.ca>
In-Reply-To: <20210511171356.GN3141668@madcap2.tricolour.ca>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 11 May 2021 13:51:48 -0400
Message-ID: <CAHC9VhQ9DgiMKScTt5xfyK25WM-KPUrFksFS7dH51u0+PemPLA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] audit: replace magic audit syscall class numbers
 with macros
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Eric Paris <eparis@parisplace.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Paris <eparis@redhat.com>, x86@kernel.org,
        linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        Aleksa Sarai <cyphar@cyphar.com>,
        Arnd Bergmann <arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 11, 2021 at 1:14 PM Richard Guy Briggs <rgb@redhat.com> wrote:
>
> On 2021-05-10 21:23, Paul Moore wrote:
> > On Fri, Apr 30, 2021 at 4:36 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > >
> > > Replace audit syscall class magic numbers with macros.
> > >
> > > This required putting the macros into new header file
> > > include/linux/auditscm.h since the syscall macros were included for both 64
> > > bit and 32 bit in any compat code, causing redefinition warnings.
> >
> > The ifndef/define didn't protect against redeclaration?  Huh.  Maybe
> > I'm not thinking about this correctly, or the arch specific code is
> > doing something wonky ...
> >
> > Regardless, assuming that it is necessary, I would prefer if we called
> > it auditsc.h instead of auditscm.h; the latter makes me think of
> > sockets and not syscalls.
>
> The "m" was for "macros", since there are auditsc bits in audit.h as
> well, but I have no significant objection.

Yes, I figured as much, but my comment about it looking like a socket
"thing" still stands.  I'm open to other ideas if you don't like
auditsc.h, I just don't like auditscm.h.

-- 
paul moore
www.paul-moore.com
