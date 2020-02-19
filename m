Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3BC216402C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2020 10:21:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbgBSJV6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Feb 2020 04:21:58 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39885 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbgBSJV6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Feb 2020 04:21:58 -0500
Received: by mail-ot1-f65.google.com with SMTP id 77so22446246oty.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Feb 2020 01:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jnk001kHHnMJZPh5284on/H7ZVuekrqsnplVhw3qKG4=;
        b=skzdvmlkEwjc+AAGfz8cHX6+KV0Ear7q/T2X/aLZyVNB8hYHhuw7952mIi9a+oHsp2
         a1qaqaJ4LCcNqSSVeOrMDRc8eCDQ3PQxS8dNBJdz6Jn23OH1JxI0uxCYBe6DfX+c3Wsv
         BMvlxvoP7fNcpGpjkNUEGOMVNRsOdBPAlrgy+eyisWwxiYxQbtZhI/qyU3ILtNbxWj30
         XJ7Y5/V1GTnfsI37Rl1wHgxVw8Ow3geprTuNTc9F7LzKNG4Bq3L0gtcPzyJIV6b75eUg
         jFoCUoEaq29fBnOKzUjWJKft6VdearndY50Bh6pcEV5S8fsxKTzBy/FpQ9saBVoUf2eO
         DNNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jnk001kHHnMJZPh5284on/H7ZVuekrqsnplVhw3qKG4=;
        b=jnYzze5jwdSjwNSr3MquQsab11JwcrUiaoANviLV+moW1cGsrBiZULwiD79qNIIK7O
         TsyQZfp/+F73mowNExCFcNIVacdusg2SY1UnpylG44UFxXDY9h1fBFp9wdqo4Jvzc2Gz
         aHpZbfc7LGZeCcjsZ1VnP/mYjxmfgwqDQVH4hiTarhA8y3onRWaxnp/LGpjJUAeipg4g
         ymuuvrQpaDpy3fEuUVeCt9X4/N3gR3ZZXR9y9vDiQvYsTP3nhYVZ9rWTm7THL3zGNK+0
         R1skUzPI19V68XeDPULdmRQqs8YyiEnoU6mllRbLsEw+6C3fJzukdMmsNgpYa+2ybfse
         B2UA==
X-Gm-Message-State: APjAAAX9wLquxTYHqZsjcIGipprb45rCWvpRtlb2JLywJV4kDybPWzOC
        YyURDjiwtoyogFq/97IP4pul9+Ywq5mFoae9rp1esA==
X-Google-Smtp-Source: APXvYqyJ4nt9+Cb3VvmCUmEkmEWPRJPd34khUiRmOXNDD0rpIaPsxx6hd3bW+kSqhqA60hbPtZDo3MahZ+o5NuJLHog=
X-Received: by 2002:a9d:7410:: with SMTP id n16mr19494651otk.23.1582104117580;
 Wed, 19 Feb 2020 01:21:57 -0800 (PST)
MIME-Version: 1.0
References: <20200219045228.GO23230@ZenIV.linux.org.uk> <EDCBB5B9-DEE4-4D4B-B2F4-F63179977D6C@lca.pw>
 <20200219052329.GP23230@ZenIV.linux.org.uk>
In-Reply-To: <20200219052329.GP23230@ZenIV.linux.org.uk>
From:   Marco Elver <elver@google.com>
Date:   Wed, 19 Feb 2020 10:21:46 +0100
Message-ID: <CANpmjNM=+y-OwKjtsjsEkwPjpHXpt7ywaE48JyiND6dKt=Vf1Q@mail.gmail.com>
Subject: Re: [PATCH] fs: fix a data race in i_size_write/i_size_read
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Qian Cai <cai@lca.pw>, Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 19 Feb 2020 at 06:23, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Wed, Feb 19, 2020 at 12:08:40AM -0500, Qian Cai wrote:
> >
> >
> > > On Feb 18, 2020, at 11:52 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
> > >
> > > If aligned 64bit stores on 64bit host (note the BITS_PER_LONG ifdefs) end up
> > > being split, the kernel is FUBAR anyway.  Details, please - how could that
> > > end up happening?
> >
> > My understanding is the compiler might decide to split the load into saying two 4-byte loads. Then, we might have,
> >
> > Load1
> > Store
> > Load2
> >
> > where the load value could be a garbage. Also, Marco (the KCSAN maintainer) who knew more of compiler than me mentioned that there is no guarantee that the store will not be split either. Thus, the WRITE_ONCE().
> >

In theory, yes. But by now we're aware of the current convention of
assuming plain aligned writes up to word-size are atomic (which KCSAN
respects with default Kconfig).

>         I would suggest
> * if some compiler does that, ask the persons responsible for that
> "optimization" which flags should be used to disable it.
> * if they fail to provide such, educate them regarding the
> usefulness of their idea
> * if that does not help, don't use the bloody piece of garbage.
>
>         Again, is that pure theory (because I can't come up with
> any reason why splitting a 32bit load would be any less legitimate
> than doing the same to a 64bit one on a 64bit architecture),
> or is there anything that really would pull that off?

Right. In reality, for mainstream architectures, it appears quite unlikely.

There may be other valid reasons, such as documenting the fact the
write can happen concurrently with loads.

Let's assume the WRITE_ONCE can be dropped.

The load is a different story. While load tearing may not be an issue,
it's more likely that other optimizations can break the code. For
example load fusing can break code that expects repeated loads in a
loop. E.g. I found these uses of i_size_read in loops:

git grep -E '(for|while) \(.*i_size_read'
fs/ocfs2/dir.c: while (ctx->pos < i_size_read(inode)) {
fs/ocfs2/dir.c:                 for (i = 0; i < i_size_read(inode) &&
i < offset; ) {
fs/ocfs2/dir.c: while (ctx->pos < i_size_read(inode)) {
fs/ocfs2/dir.c:         while (ctx->pos < i_size_read(inode)
fs/squashfs/dir.c:      while (length < i_size_read(inode)) {
fs/squashfs/namei.c:    while (length < i_size_read(dir)) {

Can i_size writes happen concurrently, and if so will these break if
the compiler decides to just do i_size_read's load once, and keep the
result in a register?

Thanks,
-- Marco
