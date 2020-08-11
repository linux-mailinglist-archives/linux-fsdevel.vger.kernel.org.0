Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AFDD2421CB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Aug 2020 23:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbgHKVSC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Aug 2020 17:18:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:49402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726164AbgHKVSB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Aug 2020 17:18:01 -0400
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB019207DE
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Aug 2020 21:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597180680;
        bh=H697I+zAaTrCDiFR/QxpngC4s+tbXs3+JE4nJBDzzfA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IT1RF1YTWtDvefJCO9mfuCZ/I5IZnMecZ+md9PsXrV5wGW3duq6XWTgVUVnvpqY0I
         xxAWofUmDA6s9vdCg5tFImdWw/s3ChAXactoAxcXvaZbSU6botkJoRWeKHw2ZM7Kat
         LDs7Rs9M+2oWS1Tex0Vsa3HW5s+y05fGU4gw6IPc=
Received: by mail-wm1-f54.google.com with SMTP id k8so36904wma.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Aug 2020 14:18:00 -0700 (PDT)
X-Gm-Message-State: AOAM532GTvFa+gHRboQE/b/TrhfeBPQhraove2Ou4tG/DTM2WANYHKyF
        JEaqWYxxX1QMCEpyZxf2HQjeASomYwEiKX3v68sKyA==
X-Google-Smtp-Source: ABdhPJws+21t6FOJ6sK8kO00+QCrfmrTy0qT7N99L+sWIie61bUyPjWf7GBWU+7WzuyTe6ork3V+hpcBZbDKW738l/Y=
X-Received: by 2002:a1c:7e02:: with SMTP id z2mr5576013wmc.138.1597180679149;
 Tue, 11 Aug 2020 14:17:59 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjzLmMRf=QG-n+1HnxWCx4KTQn9+OhVvUSJ=ZCQd6Y1WA@mail.gmail.com>
 <5C8E0FA8-274E-4B56-9B5A-88E768D01F3A@amacapital.net> <a6cd01ed-918a-0ed7-aa87-0585db7b6852@schaufler-ca.com>
 <CAJfpegvUBpb+C2Ab=CLAwWffOaeCedr-b7ZZKZnKvF4ph1nJrw@mail.gmail.com>
 <CAG48ez3Li+HjJ6-wJwN-A84WT2MFE131Dt+6YiU96s+7NO5wkQ@mail.gmail.com> <CAJfpeguh5VaDBdVkV3FJtRsMAvXHWUcBfEpQrYPEuX9wYzg9dA@mail.gmail.com>
In-Reply-To: <CAJfpeguh5VaDBdVkV3FJtRsMAvXHWUcBfEpQrYPEuX9wYzg9dA@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 11 Aug 2020 14:17:46 -0700
X-Gmail-Original-Message-ID: <CALCETrXRrMdbzcQPHQQgH3cKKhf87Piy7=gs3wVUX4z20bLyUw@mail.gmail.com>
Message-ID: <CALCETrXRrMdbzcQPHQQgH3cKKhf87Piy7=gs3wVUX4z20bLyUw@mail.gmail.com>
Subject: Re: file metadata via fs API (was: [GIT PULL] Filesystem Information)
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Jann Horn <jannh@google.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
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

On Tue, Aug 11, 2020 at 1:56 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Tue, Aug 11, 2020 at 10:37 PM Jann Horn <jannh@google.com> wrote:
> > If you change the semantics of path strings, you'd have to be
> > confident that the new semantics fit nicely with all the path
> > validation routines that exist scattered across userspace, and don't
> > expose new interfaces through file server software and setuid binaries
> > and so on.
>
> So that's where O_ALT comes in.   If the application is consenting,
> then that should prevent exploits.   Or?

We're going to be at risk from libraries that want to use the new
O_ALT mechanism but are invoked by old code that passes traditional
Linux paths.  Each library will have to sanitize paths, and some will
screw it up.

I much prefer Linus' variant where the final part of the extended path
is passed as a separate parameter.
