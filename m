Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2DD12231A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2019 05:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbfLQEWb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Dec 2019 23:22:31 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:44620 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbfLQEWb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Dec 2019 23:22:31 -0500
Received: by mail-io1-f67.google.com with SMTP id b10so9474162iof.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Dec 2019 20:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=keSgIbSHJC75F2tcCTcdvMMClu3dUDODUJgUvRgq/Q4=;
        b=nfWq8THxKflsuQnA3Xr6tSm1cQ+bf2FbIlVmRYJ70h0dRDqxvS6Wd9V9l+9w7bfVgh
         knvfkPlbAsgA2EMV0tqPNVQRf6Z8/cx4RlXP/dgEDC4DTSRn8IFNAAGZH83S+LZgq4y3
         pOCDa1ev49hHwFbIWIsd27FuDVwkiOFv3yI/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=keSgIbSHJC75F2tcCTcdvMMClu3dUDODUJgUvRgq/Q4=;
        b=MU/QEU8quL/ACUUuMhSmcXrU2sRniVsrSyisyx3pISXdWwzx3ccsiMxaCTZk0SBQQS
         xqgKlZBmr8bftkOOHECjCuHSI/Z5NLnYM9UtEmeXQFrWCYhhdhtixZRzk3svtcM1Wmu7
         bFJTlbGiC6obwIIDZE5o/bnthIgGaQuJX9eCEXBPqAGH04tYnYT/1glMZ7bN6AXn58xJ
         hOODCQZmlD/1AWJ8dd8VZBf6In9Y013jZDxOxzx9sasU58bqonBRGKaUf3NaULeiudzC
         YmI7V/Al+49OU5nqwvmqIoFGKnJwftmXeX9JE7xTq9DF3heq1/s4R0rKj1N7vYRaYnfU
         PByw==
X-Gm-Message-State: APjAAAVd6Bqo89606LL8ZXhhO8C1MTPtH2ZFaboLwpeAbnWWctUdWewZ
        2RGLH0Vi4i7g2KcqLxnYZaa4cFvlABJs49OjQV/Lfw==
X-Google-Smtp-Source: APXvYqy4NjiwAH//btd3CRVvOmWfV/UyzeyDT2aKGrfCpGjD2ZTP/coIOrKvfnCUOgFR0cLA0ZuVpdDe0uBeyumlEbo=
X-Received: by 2002:a5d:9b04:: with SMTP id y4mr2168997ion.212.1576556550745;
 Mon, 16 Dec 2019 20:22:30 -0800 (PST)
MIME-Version: 1.0
References: <20191128155940.17530-1-mszeredi@redhat.com> <20191128155940.17530-9-mszeredi@redhat.com>
 <20191217035144.GU4203@ZenIV.linux.org.uk>
In-Reply-To: <20191217035144.GU4203@ZenIV.linux.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 17 Dec 2019 05:22:20 +0100
Message-ID: <CAJfpegtY9Lg4=OSQqYhqDe9kC=5CrvdV22E924qgMWTHVwAWMQ@mail.gmail.com>
Subject: Re: [PATCH 08/12] vfs: allow unprivileged whiteout creation
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 17, 2019 at 4:51 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Thu, Nov 28, 2019 at 04:59:36PM +0100, Miklos Szeredi wrote:
> > Whiteouts are special, but unlike real device nodes they should not require
> > privileges to create.
>
> More detailed analysis, please.  Maybe I'm missing something obvious,
> but I don't see off-hand why it's safe.

The general concern with device nodes is that opening them can have
side effects.  The kernel already avoids zero major, so opening will
result in ENODEV, but the patch also makes sure that registering a
device with 0/0 number is forbidden (fs/char_dev.c).

Thanks,
Miklos
