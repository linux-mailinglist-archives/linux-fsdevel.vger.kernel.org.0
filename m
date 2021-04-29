Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC0F36E68A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Apr 2021 10:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239778AbhD2IFp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Apr 2021 04:05:45 -0400
Received: from mail-vs1-f52.google.com ([209.85.217.52]:42943 "EHLO
        mail-vs1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239520AbhD2IFo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Apr 2021 04:05:44 -0400
Received: by mail-vs1-f52.google.com with SMTP id 66so33248308vsk.9;
        Thu, 29 Apr 2021 01:04:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cEaWsqveglqKutwIfCWg/c1k8Pjc9F7AASjTBk3kAB0=;
        b=qRxS7DrgjtfP6uNKjGJyeysH31OCYcAOJHbFS000i/hrznxEAdXpWvtEOseiZJLjUw
         p5QF60hahfKSUW6eQSTmv9LOZeEaprPtoBEU0Uaz5xcMsQMwnolI36j5Bjl2dEjQCTib
         IqzGn9kVzSMAo1vkBdBHfMxQQnL75EyOETJLDwkDrequvJ+r/LUTMJlnw2l6xLTxHIw8
         ZuTa0T5SLJ1Grfr+3bBigKcekZFZd9dOq1rVOPzpiuuQ/QbQ4VkcMjsRgBz/6d9I4R3o
         6EVPfxDyUKYNaAluWyz3GQW2pFvGb3brqxk+49yJKTppqpJGtlPs+0QlgJD/hsdl/6eE
         QdJg==
X-Gm-Message-State: AOAM532dpOwsliZ3fm645/WBICC65toI0bKKrKXCBfYSYZR6GQfqVZSn
        V9mCK7DEnfaGX/gzTI3uLx6ywul2G9I+RwsOqqY=
X-Google-Smtp-Source: ABdhPJyOQfCSFL6ivPQSvopdsprRnA2n+Ja7fwwMwXAF5cOL+2KKLY+oOwM93GwYMJWOqvFowThQ0q/7iQPRdk2pFdw=
X-Received: by 2002:a67:fc57:: with SMTP id p23mr29422049vsq.40.1619683497839;
 Thu, 29 Apr 2021 01:04:57 -0700 (PDT)
MIME-Version: 1.0
References: <161918446704.3145707.14418606303992174310.stgit@warthog.procyon.org.uk>
 <161918455721.3145707.4063925145568978308.stgit@warthog.procyon.org.uk>
In-Reply-To: <161918455721.3145707.4063925145568978308.stgit@warthog.procyon.org.uk>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 29 Apr 2021 10:04:46 +0200
Message-ID: <CAMuHMdXJZ7iNQE964CdBOU=vRKVMFzo=YF_eiwsGgqzuvZ+TuA@mail.gmail.com>
Subject: Re: [PATCH v7 07/31] netfs: Make a netfs helper module
To:     David Howells <dhowells@redhat.com>
Cc:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Marc Dionne <marc.dionne@auristor.com>,
        Linux MM <linux-mm@kvack.org>, linux-cachefs@redhat.com,
        linux-afs@lists.infradead.org,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        linux-cifs@vger.kernel.org,
        ceph-devel <ceph-devel@vger.kernel.org>,
        V9FS Developers <v9fs-developer@lists.sourceforge.net>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi David,

On Fri, Apr 23, 2021 at 3:31 PM David Howells <dhowells@redhat.com> wrote:
> Make a netfs helper module to manage read request segmentation, caching
> support and transparent huge page support on behalf of a network
> filesystem.
>
> Signed-off-by: David Howells <dhowells@redhat.com>

Thanks for your patch, which is now commit 3ca236440126f75c ("mm:
Implement readahead_control pageset expansion") upstream.

> --- /dev/null
> +++ b/fs/netfs/Kconfig
> @@ -0,0 +1,8 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +config NETFS_SUPPORT
> +       tristate "Support for network filesystem high-level I/O"
> +       help
> +         This option enables support for network filesystems, including
> +         helpers for high-level buffered I/O, abstracting out read
> +         segmentation, local caching and transparent huge page support.

TBH, this help text didn't give me any clue on whether I want to enable
this config option or not.  Do I need it for e.g. NFS, which is a
network filesystem?

I see later patches make AFS and FSCACHE select NETFS_SUPPORT.  If this
is just a library of functions, to be selected by its users, then please
make the symbol invisible.

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
