Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E663AAB18
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2019 20:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391293AbfIESdo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Sep 2019 14:33:44 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:46386 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390203AbfIESdo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Sep 2019 14:33:44 -0400
Received: by mail-qk1-f195.google.com with SMTP id 201so3061916qkd.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Sep 2019 11:33:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+VnbSQuE0yoBMYOHF4YIMES1veGnzodjKxQsdopPaBs=;
        b=pD6Z9UWsvH0vt9DuCiyww8FUejqmiUK9gif+LRBPm2LyoEEnvKvir156TMudejJFL+
         L4jxCgxnp5iD3aZyEve8qbjkoQgs+X/0oWM/RxPDb6fREveM4s/fLsVFWivEZbOo9AM8
         saIKmMW/sd+orXumhanHrUCS7OEbcTu96PbqpozlTnbzFg79jq6mk6RWuWlZxTfIHtSG
         0vFT/BAJFxSx04sCueL8mlXoR4SU/YZ0kQZ/mdOxhOyopATpqCuCxoGmochgYdGMCPZE
         H1+pfe3LLJa+k/Gw6eoSeAo2OqbjwV9wac3Ppr6uD9X917yodVx61SefWcHHEc7OGgVY
         ao0w==
X-Gm-Message-State: APjAAAU/UGpNFe7U2J9LrZCMHDH5HuQZIzOTqSpVenR8fQJbXYpGve5h
        Ei8w5VbULjeQMaM0mHGwfjG9f4sLQ5ZywMb2kB8=
X-Google-Smtp-Source: APXvYqx5iyPnvmbWOid6y12XmPSS67lfP43M+r/wbQDv1VtdSNqMvsrV73yZLLceWV7b8BSHEEnaERw4CScSnLTSPiY=
X-Received: by 2002:a05:620a:145a:: with SMTP id i26mr4548203qkl.352.1567708423407;
 Thu, 05 Sep 2019 11:33:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190829041132.26677-1-deepa.kernel@gmail.com>
 <CABeXuvoKD83B7iUqE33Y9E2OVtf61DKv-swZr-N=ozz-cMmGOA@mail.gmail.com>
 <CAOg9mSR25eAH7e1KhDZt_uscJSzyuSmELbCxgyh=-KWRxjZtcw@mail.gmail.com>
 <CABeXuvpe9vADLZUr4zHrH0izt=1BaLQvBMxAu=T1A2CV3AN4vA@mail.gmail.com>
 <CAK8P3a0NMUv2xOw=fCxJXo_2wbmBMG24Fst3U1LT-m7C8uxz0w@mail.gmail.com>
 <CABeXuvrm76iKnFrd7Wo=z4d0v7i7xT+Ta37D-mwVwy7-P3YyUg@mail.gmail.com> <CAOg9mSS=V7cQqPMCj90LtudxhN7_owoEBKxkvsXjzdtu+R69hA@mail.gmail.com>
In-Reply-To: <CAOg9mSS=V7cQqPMCj90LtudxhN7_owoEBKxkvsXjzdtu+R69hA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 5 Sep 2019 20:33:27 +0200
Message-ID: <CAK8P3a22QBPO_+H3XV+u+Hue6ThVYg+Lfk0NPuiFYS_mTYw1eQ@mail.gmail.com>
Subject: Re: [GIT PULL] vfs: Add support for timestamp limits
To:     Mike Marshall <hubcap@omnibond.com>
Cc:     Deepa Dinamani <deepa.kernel@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 5, 2019 at 6:58 PM Mike Marshall <hubcap@omnibond.com> wrote:
>
> I spoke to Walt Ligon about the versioning code, and also shared
> this thread with him. He isn't a fan of the versioning code.
> and we think it should go. As I read through the commit messages
> from when the versioning code was added, it relates to mtime
> on directories. If a directory is read, and it has enough entries,
> it might take several operations to collect all the entries. During
> this time the directory might change. The versioning is a way to
> tell that something changed between one of the operations...
>
>    commit: 7878027e9c2 (Oct 2004)
>      - added a directory version that is passed back from the server to
>        the client on each successful readdir call (happens to be the
>        directory's mtime encoded as an opaque uint64_t)
>
> We will work to see if we can figure out what we need to do to Orangefs
> on both the userspace side and the kernel module side to have all 64 bit
> time values.

Ok, sounds good. For the time being, I have applied the patch
that limits the kernel to timestamps in the 1970 to 2106 range, which
is compatible with the existing user space and will be good enough for
a while.

If you can ignore the old pre-versioning interfaces, you can decide to
encode the epoch number in the remaining 12 bits of the on-disk
representation, like

    time64 = (u32)(timeversion >> 32) + ((s64)(timeversion & 0xffc00000) << 12);

to extend it into the far-enough future (136 years times 2^12), or possibly
using

    time64 = (s32)(timeversion >> 32) + ((s64)(timeversion & 0xffc00000) << 12);

to interpret existing timestamps with the msb set as dates between 1902
and 1970, which would fix the test case that broke, but disallow dates past
2038 with unmodified kernels.

     Arnd
