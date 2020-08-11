Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50CAA24216E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Aug 2020 22:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbgHKU4b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Aug 2020 16:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbgHKU4a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Aug 2020 16:56:30 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBCACC06174A
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Aug 2020 13:56:29 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id q4so10095109edv.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Aug 2020 13:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mIwwgXuVYR9J8FN3Q7OBMSeO2MRyPkPN2N5o9h2ay8w=;
        b=eKcrw8bQXY0ON3Tby3NTqixV/DjoLpozBmhQ9Wxh8CrzQKneLuoqFBgMjT6gAHEG5x
         zYyv+zLUzEwpSrr4OU+QfyjH1a/L/3382mM+GuZnpa9mC47RvCYGIpTbFcfYEHdSy8L3
         lYq0C+Xov6wYQlMCdmDB+OTEIdrvHwkv9okCI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mIwwgXuVYR9J8FN3Q7OBMSeO2MRyPkPN2N5o9h2ay8w=;
        b=ZzdBvyMF4PnwnQpYw5k+aEa/sg6+sosJe3bTmgdSVWAAIV9SsaoIIm7vM8zr6bCr7w
         x0Qvx3cMNS86J9tuh2yEKyTxRlnRcYVq01L2cTxm8gEGR48517LY3RENGjMxM8IVBwWX
         yLn5ZQaavliAk1awfEzoRuvjybV7Wn6yGvdKULdcY0dN6qWyo1uD5mrYl8vExQRhYmq/
         xvQYPduylU4ZZ4SI3Ut9Je8FZq/ODL/IMEVf+uU9h90JasGQ1f6iEgiiV+c9pFMgHres
         7aNSaBlb+JCJi3jFUUyfT5DxkDP4LR+mu4ZCtVWKeP6de64+2acwrx/1q90bgb21X0IY
         a8GQ==
X-Gm-Message-State: AOAM5303WnLq7+BMdhAj1JMOA5BcetDC4A72ZUl9q3eYSKPhKQPfR+W+
        /GY4r622jJD59qfiYxYCDYmuNWG+qmMG7tw3qtjzaQ==
X-Google-Smtp-Source: ABdhPJy0K+Fs+OPN9rfm6Efrlr92XTN+ignCX68MAQVFzGb3drIK9V+44cU7wIUR+/6aonnP7KkpSeyJKYyxyPce3Ms=
X-Received: by 2002:a05:6402:12c4:: with SMTP id k4mr27523537edx.358.1597179388290;
 Tue, 11 Aug 2020 13:56:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjzLmMRf=QG-n+1HnxWCx4KTQn9+OhVvUSJ=ZCQd6Y1WA@mail.gmail.com>
 <5C8E0FA8-274E-4B56-9B5A-88E768D01F3A@amacapital.net> <a6cd01ed-918a-0ed7-aa87-0585db7b6852@schaufler-ca.com>
 <CAJfpegvUBpb+C2Ab=CLAwWffOaeCedr-b7ZZKZnKvF4ph1nJrw@mail.gmail.com> <CAG48ez3Li+HjJ6-wJwN-A84WT2MFE131Dt+6YiU96s+7NO5wkQ@mail.gmail.com>
In-Reply-To: <CAG48ez3Li+HjJ6-wJwN-A84WT2MFE131Dt+6YiU96s+7NO5wkQ@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 11 Aug 2020 22:56:17 +0200
Message-ID: <CAJfpeguh5VaDBdVkV3FJtRsMAvXHWUcBfEpQrYPEuX9wYzg9dA@mail.gmail.com>
Subject: Re: file metadata via fs API (was: [GIT PULL] Filesystem Information)
To:     Jann Horn <jannh@google.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Karel Zak <kzak@redhat.com>,
        Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Christian Brauner <christian@brauner.io>,
        Lennart Poettering <lennart@poettering.net>,
        Linux API <linux-api@vger.kernel.org>,
        Ian Kent <raven@themaw.net>,
        LSM <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 11, 2020 at 10:37 PM Jann Horn <jannh@google.com> wrote:
> If you change the semantics of path strings, you'd have to be
> confident that the new semantics fit nicely with all the path
> validation routines that exist scattered across userspace, and don't
> expose new interfaces through file server software and setuid binaries
> and so on.

So that's where O_ALT comes in.   If the application is consenting,
then that should prevent exploits.   Or?

Thanks,
Miklos
