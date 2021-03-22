Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 932243444B4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Mar 2021 14:05:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232642AbhCVNEt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Mar 2021 09:04:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:56488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233406AbhCVNDM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Mar 2021 09:03:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AFBBE60238;
        Mon, 22 Mar 2021 13:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616418191;
        bh=FlXXjoEDVcyQ5x6OCJ5zCQMEdy6VKfBQ7cry3HNMhW8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RdlKB1bCw62yHLdCKBwsz4bRs9BI44ldN+kY4HItrqSySM0JjRuIHFk65QkdftpTL
         EhnWh2XuViKPZpMcUXtwXTkLq15UKzvK/sdMp+J7tpZf2mp1AQGlz5qSAe3s8Cohm6
         jCilRmKk3/Stzy8pqz3jGlG7gkxgxbqTWJhw74+/iL/hi/vrUFvfuTjU3WGfspFmAg
         /Pw2RFjh4I/qfUEWOSZjTr9BpncQJhIjyHlCcTFDyOukejL2Qdb0sAVcmIXDGvW9zV
         Q6139NsoE+1AcFssVke4nIYY7VCRVM44fWqyntqg1s6/jaU9fTbB02GENY7K3/RY47
         3rJsQyQGxtjgQ==
Received: by mail-oi1-f171.google.com with SMTP id k25so12909534oic.4;
        Mon, 22 Mar 2021 06:03:11 -0700 (PDT)
X-Gm-Message-State: AOAM533BVMvKZ+HGFBEAe38qxseWC/h+PQseon00DVn9Z+mE9VSIS3Jq
        cG4SS9sdkcRr6hnJEc0Yj6yOfXAnwqc8zIgzqwE=
X-Google-Smtp-Source: ABdhPJw2y9AwQUsZ+YoAXBGHsI/NEpc9BMWLAKxpCWcENCYr5K3h5UtwVnm2hO3nmUInqXTNzRxEChUPO4XERmOpzm4=
X-Received: by 2002:a05:6808:313:: with SMTP id i19mr9440187oie.67.1616418190622;
 Mon, 22 Mar 2021 06:03:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210322113829.3239999-1-arnd@kernel.org> <20210322121506.r4yx6n6652nvrz6m@wittgenstein>
In-Reply-To: <20210322121506.r4yx6n6652nvrz6m@wittgenstein>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 22 Mar 2021 14:02:54 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0HgsKzez13cSWZ-HVGM86UXB5a58MozY+BupfpMuB2gw@mail.gmail.com>
Message-ID: <CAK8P3a0HgsKzez13cSWZ-HVGM86UXB5a58MozY+BupfpMuB2gw@mail.gmail.com>
Subject: Re: [PATCH] posix-acl: avoid -Wempty-body warning
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        James Morris <jamorris@linux.microsoft.com>,
        Serge Hallyn <serge@hallyn.com>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 22, 2021 at 1:15 PM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
> On Mon, Mar 22, 2021 at 12:38:24PM +0100, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > The fallthrough comment for an ignored cmpxchg() return value
> > produces a harmless warning with 'make W=1':
> >
> > fs/posix_acl.c: In function 'get_acl':
> > fs/posix_acl.c:127:36: error: suggest braces around empty body in an 'if' statement [-Werror=empty-body]
> >   127 |                 /* fall through */ ;
> >       |                                    ^
> >
> > Rewrite it as gcc suggests as a step towards a clean W=1 build.
> > On most architectures, we could just drop the if() entirely, but
> > in some cases this causes a different warning.
>
> And you don't see the warning for the second unconditional
> cmpxchg(p, sentinel, ACL_NOT_CACHED);
> below?

I would have expected both to show that warning, didn't notice the other
one.  I now see that all architectures use statement expressions for cmpxchg()
and xchg() these days, after we fixed m68k, alpha and ia64, so the
changelog text here no longer makes sense.

Should I just remove the if() then?

        Arnd
