Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD5F82149CE
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Jul 2020 05:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728168AbgGEDTg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Jul 2020 23:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728046AbgGEDTf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Jul 2020 23:19:35 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA8BCC061794;
        Sat,  4 Jul 2020 20:19:35 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id 95so18632323otw.10;
        Sat, 04 Jul 2020 20:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JRRSHfu57VEQenFeKG/wrPteBjz2y9p7KDeC5c1WDzQ=;
        b=ghG4x+PsHuG6FxB2wSjlf07QQVm2VF8WwmAwiy+xC0ILn57oQGueHvzDKQWxqp9o5l
         XLv/LzBMvZSu5F/72+bQzvyhIr0+A91UEoxIwK15g8YG44dqCo8ObdtO+1YMpb8/SHzn
         P1U4L9xRpociy7ixR5doGnPZzGYlLr3jpafCpUCSodx7thlqJ2hZQxZgti8iElt932t+
         FR8POhSFjW0mMxj2nZFUrqi/i8wz3x+0RLCiXMRkDbSgpEOeZCKYjQziSnD51XMiEz+h
         LCjE0K9x9Q6njLj4sn4rJzaNtLQpmqzVFjIEpMzpLOzuCmdWp/hAD/7heuTSLy8aDjhk
         RCLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JRRSHfu57VEQenFeKG/wrPteBjz2y9p7KDeC5c1WDzQ=;
        b=ukt5WP/XmfYxS+wS/UtC5DdWKQzm+UfHlLdTpMWrMr0JgoR8tgLQSKoWGba9zNvjaW
         hRZXJEw1NgDitQwRsU77P2IEg8tCJ0gsDeJqrHqxPOx190dPE4sD5OyBEQnsoNiBch8u
         VOPOMNI6dbVX/tXhGxab4relGTheixE1ai+czFiZT3lTWCZfVUMnXGkeInDkiaQWkLip
         6zayNgA4HYkvHDDypeeJkw3wNX99yQimSwYi3d3RIPiTsy/aokpHQ9bRCxSD4J+tl9Sb
         MyOKWjWwrLTMvnD0SqIEy4RuSpoY1n5GH0rDzegRKHFk6N5I6+6pCMVMn9fS7N+TKkgp
         PsQw==
X-Gm-Message-State: AOAM533yusTREv11dDeUHmt3u4TSx/O9SyKQBd9ZgKq6r5+YDEs+bQQh
        rV9VU5WyyXe7XHgXByzqVegkNWA2YY76CF0eRJxw1F8u
X-Google-Smtp-Source: ABdhPJyHh/eJzqTdcyNtEepbtnfCox+oQpfptDdlche4iFJhv9rMZaSQXa7ZT0I/+hjvBhxiS6czBMP4GHI4TEHc5xQ=
X-Received: by 2002:a9d:4d1a:: with SMTP id n26mr27054781otf.54.1593919175006;
 Sat, 04 Jul 2020 20:19:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAODFU0q6CrUB_LkSdrbp5TQ4Jm6Sw=ZepZwD-B7-aFudsOvsig@mail.gmail.com>
 <20200705021631.GR25523@casper.infradead.org> <CAODFU0qwtPTaBRbA3_ufA6N7fajhi61Sp5iE75Shdk25NSOTLA@mail.gmail.com>
 <20200705031208.GS25523@casper.infradead.org>
In-Reply-To: <20200705031208.GS25523@casper.infradead.org>
From:   Jan Ziak <0xe2.0x9a.0x9b@gmail.com>
Date:   Sun, 5 Jul 2020 05:18:58 +0200
Message-ID: <CAODFU0q=nDdx7D1NUxTQshBjqgTCYPpKzog78XZLjoPqnZqXvw@mail.gmail.com>
Subject: Re: [PATCH 0/3] readfile(2): a new syscall to make open/read/close faster
To:     Matthew Wilcox <willy@infradead.org>
Cc:     gregkh@linuxfoundation.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-man@vger.kernel.org,
        mtk.manpages@gmail.com, shuah@kernel.org, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jul 5, 2020 at 5:12 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> You should probably take a look at io_uring.  That has the level of
> complexity of this proposal and supports open/read/close along with many
> other opcodes.

Then glibc can implement readfile using io_uring and there is no need
for a new single-file readfile syscall.
