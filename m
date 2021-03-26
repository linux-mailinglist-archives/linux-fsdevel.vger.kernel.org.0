Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4586D34AAD7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Mar 2021 16:03:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbhCZPCw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Mar 2021 11:02:52 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:55111 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbhCZPCW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Mar 2021 11:02:22 -0400
Received: from mail-ot1-f53.google.com ([209.85.210.53]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MPGNn-1l09HL1BHR-00PevL; Fri, 26 Mar 2021 16:02:18 +0100
Received: by mail-ot1-f53.google.com with SMTP id g8-20020a9d6c480000b02901b65ca2432cso5476039otq.3;
        Fri, 26 Mar 2021 08:02:17 -0700 (PDT)
X-Gm-Message-State: AOAM532CQVmd9TuI59b9vrE4WGnCe48R4sGs9Sp/9sYVSGAjrZ6lLItQ
        8yn2TjG1Ky3qmbvqOrBGUWSxhYBH86cG60VSJ6s=
X-Google-Smtp-Source: ABdhPJxqEYgkhmmR9tlr6VhSmLMh2wsAkrBQ0kntrx/MKqJmvuyr6KcW6emNL2sDgGiWuPrMoCfra7yk0h2aPozesEg=
X-Received: by 2002:a05:6830:14c1:: with SMTP id t1mr12169406otq.305.1616770936271;
 Fri, 26 Mar 2021 08:02:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210326143831.1550030-1-hch@lst.de> <20210326143831.1550030-4-hch@lst.de>
In-Reply-To: <20210326143831.1550030-4-hch@lst.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 26 Mar 2021 16:02:01 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3PeMbrC3v4tGPJb+OpZYXHabe4UcF+TiBWF_JCtnwHkw@mail.gmail.com>
Message-ID: <CAK8P3a3PeMbrC3v4tGPJb+OpZYXHabe4UcF+TiBWF_JCtnwHkw@mail.gmail.com>
Subject: Re: [PATCH 3/4] exec: simplify the compat syscall handling
To:     Christoph Hellwig <hch@lst.de>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Brian Gerst <brgerst@gmail.com>,
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
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:jyQHki7n/wvddX74HI8JS5gCd4LvzSQU1iWYxgWNryfuwl4wTbW
 aHpQT/dE4Zjga7ncOBWENHuT0Cr9Md0yrm/lKs+Qzz5yFwZTu8L1r7RMqi9i3SWjr/0ZsTY
 yzqmkXG44o/GNtdrnYqDW70tAy6SaUNIJ6se7WXrJbyzYXdaGjEjaHXBkVqdld97J5I8jW3
 DJnHMNkfD/1N2Jn/bkbsg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:3TnXTXJmdUc=:CUrZ3P/W6Xh8mAHM0COfIq
 PNwI/hNXrU+cQS401PqUIGDjy8OS8ukJ0M8h50HimfzXnVHB2OsRp+q4AIpSwXkqijDVxqZ36
 deYgFz7srcgTi0wSRvyGqaMBRyl84vl0SXGq1IvDV5CYZ4XoOOiWMoqWqptiiY8v3yCHk4OqS
 izh1mcDZ3mYjkLr6lnJzdejh7askGBQT7PEtm2fiGf7BPNcBIm1o12Vs4vs4f9bWi5AuUcDNA
 o9YX0k4J63N3TdZZch32iWUB/4dfLdInNNIlsNi+4cTvoO/m9zOPBQ7/cL5LPlNBc3oWQuw6N
 sIOGikYVKt9crBUQRJb+tfvq9LPvO3DSeLtDwYIRpSD+lD01IVzpSuuMTSfSWRGoAXDw4cQwh
 dz9FWe0boJImKzR/O9x0z4fKbvuNl2a2Qm1D7VCkCEsC96wWZQsakSGaTkInm7GVzhwEhc8GO
 x445pArNoKVrVdYpQu5gI27tECACPLfPXssk5SVAy0Xj4zN22kjrozqBHE6x5Dlv7/Hb+rsXA
 4AF8N1AhH68MD0xQdknGZVlSzvmSg5UvyH2h5xvocib50VNPCcc6/XYtGcSOR6QxoZv1qsbBq
 BsX3iLpdyRIBAbA8bHxdprfLZ8IP4n3LEp
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 26, 2021 at 3:38 PM Christoph Hellwig <hch@lst.de> wrote:
>
> The only differenence betweeen the compat exec* syscalls and their
> native versions is the compat_ptr sign extension, and the fact that
> the pointer arithmetics for the two dimensional arrays needs to use
> the compat pointer size.  Instead of the compat wrappers and the
> struct user_arg_ptr machinery just use in_compat_syscall() to do the
> right thing for the compat case deep inside get_user_arg_ptr().
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Nice cleanup!

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
