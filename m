Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0510D4A4BB5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jan 2022 17:20:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380116AbiAaQU2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jan 2022 11:20:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232764AbiAaQU1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jan 2022 11:20:27 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD4C6C061714;
        Mon, 31 Jan 2022 08:20:25 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id y17so11861025ilm.1;
        Mon, 31 Jan 2022 08:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UbFm592rz0IKfu+VnJFNxz1Msppocc460xkpKheRmIo=;
        b=Yxn7d+6bC1PpKoxj3bEfo/bKYHYGd/coL4bL/5DRdCZnqKeOEWBSLDWXaqTuyV6MaI
         VAq8BE8FbR6wJAoRY2DoD1HTZtpChDHnMxdQdflAntYc3ameSzQ3a2UuJgtqqVNHX+iO
         82SDHSTqJftpRpK0T1kmeFOGDJMlCXJ7XLIASs6AzAB2bWrGWc261DsD3rI9UOT8kj2N
         9UpIWI+qEFaaU8v2BNdLbjiKderpfJW6irGth+NlniaP/v/J6mVqlWe9drCJmmxMoHkc
         AzxlFuXr7ZCXp3ieVLYyrH4DN1e4/wHkDwGVv3X2Se8jxNELDEEX8LYIMQxauKhVQU8A
         tn0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UbFm592rz0IKfu+VnJFNxz1Msppocc460xkpKheRmIo=;
        b=JXOFjMPQB6uKJlZh7stgmiIrNPCFEYfKBqI51QqWhxFiWxf9PGNtx2vMq6i/0I8Fbq
         8Bea91JcqBAYb2a3IcKjpRax26MR/wdMv7A93xBs/YivETqlGoCBKGn0/g0fWj/G62op
         avzrJR9BROlrAS6ihcGdAI7FF3CqU0YjYXHfzGcB0pTHJ5ieCg3s5lAD1iRo9BHgVa2n
         FYUoxwPFYF1ZOR9lGxZk6FYAb5bOO0X61m92vCq51B0r5VKAhjxKGzz+hVe+jgcXM+rZ
         4xrG/lUzGYj91IT0eEyiubq85eoOW0zXI+ofa2fKWwZuaeO+GnfcKfNUegue/q2f27KS
         f3jA==
X-Gm-Message-State: AOAM533sdkoV7FPhjEjSRpzxToCzZMX/YkCz/GWmClmAgSDEOuwQPIZB
        vLSCC0TZy/Mwq7bBoBI6kxyuwCLy+m5u2M5dYUI=
X-Google-Smtp-Source: ABdhPJyRorRaMlWkkgIN9K2SnqW/g5GLCJG6D2tuEyorWa6Y39EQqCnR0aSGdXlSeCoGJkW+S6ipBxaQeGvq99bLJmk=
X-Received: by 2002:a05:6e02:1708:: with SMTP id u8mr5000825ill.319.1643646025247;
 Mon, 31 Jan 2022 08:20:25 -0800 (PST)
MIME-Version: 1.0
References: <164364196407.1476539.8450117784231043601.stgit@warthog.procyon.org.uk>
 <164364197646.1476539.3635698398603811895.stgit@warthog.procyon.org.uk>
 <CAOQ4uxiorvXhhJbCsGo-B7aBX0BbSYp7wUHmYS1e1xxJ4dpF3w@mail.gmail.com> <1531209.1643643128@warthog.procyon.org.uk>
In-Reply-To: <1531209.1643643128@warthog.procyon.org.uk>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 31 Jan 2022 18:20:14 +0200
Message-ID: <CAOQ4uxhc6FW-io5mC=FN=vFawEAwjXZO7kCcGt5gzqq3ON1Y7w@mail.gmail.com>
Subject: Re: [PATCH 1/5] vfs, overlayfs, cachefiles: Turn I_OVL_INUSE into
 something generic
To:     David Howells <dhowells@redhat.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-cachefs@redhat.com, Christoph Hellwig <hch@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 31, 2022 at 5:32 PM David Howells <dhowells@redhat.com> wrote:
>
> Amir Goldstein <amir73il@gmail.com> wrote:
>
> > Please leave ovl_* as wrappers instead of changing super.c.
>
> Do you want them turning into inline functions?
>

inline would be fine.

But I just noticed something that may wreck this party.

The assumption, when I proposed this merger, was that an inode for
upper/work and is exclusively owned by ovl driver, so there should be no
conflicts with other drivers setting inuse flag.

However, in ovl_check_layer(), we walk back to root to verify that an ovl
layer of a new instance is not a descendant of another ovl upper/work inuse.
So the meaning of I_OVL_INUSE is somewhat stronger than an exclusive inode lock.
It implies ownership on the entire subtree.

I guess there is no conflict with cachefiles since ovl upper/work should not be
intersecting with any cachefiles storage, but that complicates the
semantics when
it comes to a generic flag.

OTOH, I am not sure if this check on ovl mount is so smart to begin with.
This check was added (after the exclusive ownership meaning) to silence syzbot
that kept mutating to weird overlapping ovl setups.
I think that a better approach would be to fail a lookup in the upper layer
that results with a d_mountpoint() - those are not expected inside the overlay
upper layer AFAICT.

Anyway, I can make those changes if Miklos agrees with them, but I don't
want to complicate your work on this, so maybe for now, create the I_EXCL_INUSE
generic flag without changing overlayfs and I can make the cleanup to get rid of
I_OVL_INUSE later.

Thanks,
Amir.
