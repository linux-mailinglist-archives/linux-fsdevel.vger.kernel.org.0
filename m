Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3DD41ACAC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Sep 2021 12:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240140AbhI1KNg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Sep 2021 06:13:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:38712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240139AbhI1KNe (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Sep 2021 06:13:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A2580611CE;
        Tue, 28 Sep 2021 10:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632823915;
        bh=Y7wSC7xrhvCDGxkQBLr8UtzzFVjfJNotICIdTFFi8Ok=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QPA9Ru63h3uBzj/aj83aKCrlH2Ho8nnjT4vdhNQFbKk6Co+Hn3FZjekL20EX1KpLI
         FL50GDzBdXWbriiurg+DrVuvmonDBe+jhJPB9bTyL/d4bY6OWoPPP5YRIMnBp6zzTw
         4n6A0yz8bTyAoop4B6nU7eiw7K8JyZLtCey1qr+Zb8wm4DVWjA55dTV6XKU1d3hS5V
         ir2Y3SKmHjwXJxijmKqLnENDPWKtHFTMKYpsYZTuFbx5KaEp4r5gYEtI1TbD5/tjPI
         owKYzZULoX5Q1ynW2wOZjGKXLrR2XIotIoIGmlVJriTxfHr33WKSUXvpwrW4d4sGeP
         Xh83CeYtUYlgw==
Received: by mail-wr1-f46.google.com with SMTP id d6so56891135wrc.11;
        Tue, 28 Sep 2021 03:11:55 -0700 (PDT)
X-Gm-Message-State: AOAM532IOQtmih9UULB6XIIlS/KdGQV8bf+USQ1BdIa0YGxWt0UDBou7
        davltlxNc2rvtBA0w+pkg4rhsoIKK6ZuU/Z6TBA=
X-Google-Smtp-Source: ABdhPJzl6fwe7LMgMXeAMdLDt7NX7OTZg0SUJ6tJy/beE2gt+W2VZjPnxuFCXVxpHsdh8A8pu2A/KyaXdaX8tg+YXgM=
X-Received: by 2002:adf:f481:: with SMTP id l1mr5373570wro.411.1632823914100;
 Tue, 28 Sep 2021 03:11:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210927094123.576521-1-arnd@kernel.org> <40217483-1b8d-28ec-bbfc-8f979773b166@redhat.com>
 <20210927130253.GH2083@kadam> <CAK8P3a3YFh4QTC6dk6onsaKcqCM3Nmb2JhMXK5QdZpHtffjyLg@mail.gmail.com>
 <CAHk-=wheEHQxdSJgTkt7y4yFjzhWxMxE-p7dKLtQSBs4ceHLmw@mail.gmail.com> <70a77e44-c43a-f5ce-58d5-297ca2cfe5d9@redhat.com>
In-Reply-To: <70a77e44-c43a-f5ce-58d5-297ca2cfe5d9@redhat.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 28 Sep 2021 12:11:38 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3sEy7NAhMHcV7XPpZxo5tHnQz1oCP43YTe_ZQuzOHgPA@mail.gmail.com>
Message-ID: <CAK8P3a3sEy7NAhMHcV7XPpZxo5tHnQz1oCP43YTe_ZQuzOHgPA@mail.gmail.com>
Subject: Re: [PATCH] vboxsf: fix old signature detection
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Sparse Mailing-list <linux-sparse@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 28, 2021 at 11:40 AM Hans de Goede <hdegoede@redhat.com> wrote:
> On 9/27/21 8:33 PM, Linus Torvalds wrote:
> > On Mon, Sep 27, 2021 at 6:22 AM Arnd Bergmann <arnd@kernel.org> wrote:
> >>
> >> More specifically, ' think '\377' may be either -1 or 255 depending on
> >> the architecture.
> >> On most architectures, 'char' is implicitly signed, but on some others
> >> it is not.
> >
> > Yeah. That code is just broken.
> >
> > And Arnd, your patch may be "conceptually minimal", in that it keeps
> > thed broken code and makes it work. But it just dials up the oddity to
> > 11.

Thank you for addressing it. I usually try to avoid overthinking changes
to "unusual" code like this, but your solution is clearly an improvement.

What really threw me off this time is that my first attempt to address
the warning was an exact revert of 9d682ea6bcc7 ("vboxsf: Fix the
check for the old binary mount-arguments struct"), which in turn
came from a tool that is usually correct and and that both Dan
and Al thought the original patch was correct when it looked like
it turned a working (though unusual) implementation  into a broken
one.

> I agree that your suggestion is to be the best solution,
> so how do we move forward with this, do I turn this into a
> proper patch with you as the author and Arnd as Reported-by and
> if yes may I add your Signed-off-by to the patch ?

It's already upstream, see d5f6545934c4 ("qnx4: work around gcc
false positive warning bug").

      Arnd
