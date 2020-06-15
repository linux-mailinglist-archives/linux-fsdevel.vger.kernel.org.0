Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 029701F992F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jun 2020 15:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729973AbgFONnM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Jun 2020 09:43:12 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:37341 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729766AbgFONnL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Jun 2020 09:43:11 -0400
Received: from mail-qt1-f169.google.com ([209.85.160.169]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1Mw8cU-1it0HY3zKG-00s7EG; Mon, 15 Jun 2020 15:43:09 +0200
Received: by mail-qt1-f169.google.com with SMTP id g62so12548439qtd.5;
        Mon, 15 Jun 2020 06:43:08 -0700 (PDT)
X-Gm-Message-State: AOAM533oOJiu6Mi5dcw5HQ5xZhmN5vYIJvIt+KPwy/rdqjmINu9VL4qr
        Onj8rDU1VJRZ0P7mLV/W0xkU38n0ihIzsHj8PUI=
X-Google-Smtp-Source: ABdhPJx0OrXbUjQwUsWKBodkMGMMvkpFLaAJzfOc49aX/puOn3OjGDjHT6HOJmLaKzQk1we2dir5thvL/kN4mVexpfQ=
X-Received: by 2002:ac8:7417:: with SMTP id p23mr15803567qtq.204.1592228587251;
 Mon, 15 Jun 2020 06:43:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200615130032.931285-1-hch@lst.de>
In-Reply-To: <20200615130032.931285-1-hch@lst.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 15 Jun 2020 15:42:51 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3CWhrfyR4taGip8xE3U6HcRMtKBY5A69_cqzJwU1N+Cw@mail.gmail.com>
Message-ID: <CAK8P3a3CWhrfyR4taGip8xE3U6HcRMtKBY5A69_cqzJwU1N+Cw@mail.gmail.com>
Subject: Re: properly support exec and wait with kernel pointers
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:rusj1mesNG8PiZzUVe5/rN2bwLYhg+ZprrFcw5Whf1VekE7WI/R
 efU6HaemjvIlwO2ZocfNFVc8NVj/hUyFhyPDK5eH9MsCCg9S2Rk4RrlwclH/V6oz2MasksG
 X1KmosfGRdj2OMrOzWlMOSUDvjkX8YWGvkjH5Hwpa6lJzWdPVWiiBmSxuEKqyRJ+K/6GZnc
 mttaIBpytdyyq/QlJxf1Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:cSHZrhOSM4w=:ZFLH4rWdmx4Ny3qvYVPLt/
 E5QCmylrF9/f+xxmTZN58R4WkytL4+t4Y5WqL12OrMSFOIo3OpND9ibxwmlhU1yLuEn+tHVPO
 9IAmq6F1+r4qJVOOx7HFZ+WcCVmJ5TlBQPBf5nfX4tZon6azNayZWi+mE5DY3XKdEHiXRyfia
 sbPBIFFPP5mXZEjIBIWM7DGlOZEE784lGHb9V6jAiteT32s/SJRhN9duf+CtSj5+1kXKybFQj
 wk8DyErE1n9IC5I7jeiLMUaXpJlvAaAz+O5uBCZxQpHH9WO2YbsVU8h+GvIDm5prRGe22U7Rz
 kS9H/XpYSM3qkkcX0nainDv+6UecbfgzGSKPgZeO/nM5MWvfYJVQdpRpy7vuonniMp4nu/yhU
 bUx5je8QxDa2KoY2G+8J1fF/cuSeEdR/YfpvJcQk55DNWDVuoPrm+qpSwKnNXEDZjFCpeUZyn
 XaXqoG8sco3+BNZDJ/B7lIwB/5Wm5yIUgf32wDEOAAB6RS+HnE/XWkXottZ+PgGLqAbcwjnp1
 LiUhW0IJ9Kv7zXvcPbX/1ydE2xm8iQ+jYvorl4waJIfHLuXQOZqyMFYvnllLee/5225K5PdGw
 E2kA4dkI/Oum+dJYoQE7U6/m1bv4NjgCQeSNpfvrI55vZ6XPvKl/fcBnrSfS4blL2f3xuGH9h
 0lP1XefYK5SG7WsCPjwO5TXXdCwxP1BKWDVue0UM+ilbr3GBfJW+S+OPhWLmVsZ/jZiw6Gj1Q
 QHjHjTJSuxnFcpPXGOJNlSgGtilm19Cd83YSMoqRcd1THhSnrzg+HslOsR/JiHoy8lnu+0HUk
 j5xur1fjMASRqR61EWcHx8b9yZTzohCnH9puhiqDX1ItkTqk/0=
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 15, 2020 at 3:00 PM Christoph Hellwig <hch@lst.de> wrote:
>
> Hi all,
>
> this series first cleans up the exec code and then adds proper
> kernel_execveat and kernel_wait callers instead of relying on the fact
> that the early init code and kernel threads implicitly run with
> the address limit set to KERNEL_DS.
>
> Note that the cleanup removes the compat execve(at) handlers (almost)
> entirely, as we can handle the compat difference very nicely in a
> unified codebase.  The only exception is x86 where this would list the
> handlers twice in the same syscall table due to the messed up x32
> design.  I had to add an extra compat handler just for that case, but
> maybe someone has a better idea.

I looked at all the patches and I like it a lot. I replied with some suggestions
for x32, but maybe I misunderstood what its problem is, as I don't see
anything preventing us from having two entries in the x32 table pointing
to the same function.

       Arnd
