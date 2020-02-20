Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA65B16550A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2020 03:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbgBTC1e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Feb 2020 21:27:34 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43566 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727637AbgBTC1c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Feb 2020 21:27:32 -0500
Received: by mail-lf1-f65.google.com with SMTP id 9so1751952lfq.10
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Feb 2020 18:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6R9oDs43e49OHId2T3Say1GnAm1Sa9Cij9vjtGqns0w=;
        b=HuesXzqrMwl5FNOeLlSDpflwNsgmCskzweQrWPKSAAxSCw7lHW66AFscJTMdsIwTfM
         jGiq6RpnOPaB5Oyh2lOyEHyuTv6NINI8z9tC0O74kkXNN/1S0DYEYEQUa8h2V/dm0VDo
         keHC2RRk+b6r2swD/RwtYXIMxjyjo6GlOu9gB+dUg2p6qefC+T1P4UZIm91Uo85LA+Rv
         8G03jtGxUTJfvgq8RG9MYFoubld2O9BsSsn+sfVhyCNC5XE59suWdHa3oI9hlsR9Dp3B
         GPuDBZymMhE77jVkDqjzwPoCAdP4mi7yBzI9bHOB2pq77Qnr4eN2rvsvew1j0jZvfkPA
         bB7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6R9oDs43e49OHId2T3Say1GnAm1Sa9Cij9vjtGqns0w=;
        b=i8yWQlb+jTuT0YcM6IWAnKOOTi0VsEr8xn1CnUsXc8o42B7VvzORiG9PSsfHphMw3b
         JsQ4HVgNem7So+0aYIB/GpYS63a3vveL22sslqgWht/ZnLZvL0lS9I10VPtW/YUt9zDe
         NZorNUvzxe07zNJ2buxt1kFxNYXOs75VLKC69zfufsiGQWeym4d2VM1puW+zHoXcAWlV
         PNW9qqahIkLfNcGuRO2RC6HwdCerFeEu5yfW0fXR2qlB1ofcOl6pmN2R0MGhzWUnq9Yl
         aFyxiC8vZpMCJSMiqQBzhOdJ8Ydb/fT1+PbVC+IB/RdPblfQfL/DYK+HnTFboQSoMk+O
         ZERQ==
X-Gm-Message-State: APjAAAWf8qQfD8qYEOAXDNNiK3jPAin89KAERB90kkJSEQq+Rpu8wcGg
        Q9pJ+oU1BHRCBZFSbGbuoWjRPzlcLDPcxfNGZHZF5g==
X-Google-Smtp-Source: APXvYqxXpLX+dEvOT5j7tpgmTqUeHQ8fFVlo3960ntu34jaP3dDFM5jPLMUuGTmSmVlcfqf9AGyYlOtPMi7izdaPUmg=
X-Received: by 2002:ac2:5979:: with SMTP id h25mr15671398lfp.203.1582165648799;
 Wed, 19 Feb 2020 18:27:28 -0800 (PST)
MIME-Version: 1.0
References: <20200208013552.241832-1-drosen@google.com> <20200208013552.241832-3-drosen@google.com>
 <20200208021216.GE23230@ZenIV.linux.org.uk> <CA+PiJmTYbEA-hgrKwtp0jZXqsfYrzgogOZ0Pt=gTCtqhBfnqFA@mail.gmail.com>
 <20200210234207.GJ23230@ZenIV.linux.org.uk> <20200212063440.GL870@sol.localdomain>
 <20200212065734.GA157327@sol.localdomain>
In-Reply-To: <20200212065734.GA157327@sol.localdomain>
From:   Daniel Rosenberg <drosen@google.com>
Date:   Wed, 19 Feb 2020 18:27:17 -0800
Message-ID: <CA+PiJmRX1tBVqdAgHwk62rGqEQg28B3j5mEsaDBm3UV9_fzDEQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/8] fs: Add standard casefolding support
To:     Eric Biggers <ebiggers@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fscrypt@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 11, 2020 at 10:57 PM Eric Biggers <ebiggers@kernel.org> wrote:
>
> Or (just throwing another idea out there) the dentry's name could be copied to a
> temporary buffer in ->d_compare().  The simplest version would be:
>
>         u8 _name[NAME_MAX];
>
>         memcpy(_name, name, len);
>         name = _name;
>
> Though, 255 bytes is a bit large for a stack buffer (so for long names it may
> need kmalloc with GFP_ATOMIC), and technically it would need a special version
> of memcpy() to be guaranteed safe from compiler optimizations (though I expect
> this would work in practice).
>
> Alternatively, take_dentry_name_snapshot() kind of does this already, except
> that it takes a dentry and not a (name, len) pair.
>
> - Eric

If we want to use take_dentry_name_snapshot, we'd need to do it before
calling the dentry op, since we get the dentry as a const. It would do
exactly what we want, in that it either takes a reference on the long
name, or copies the short name, although it does so under a spinlock.
I'm guessing we don't want to add that overhead for all
d_compare/d_hash's. I suppose it could just take a snapshot if it
falls under needs_casefold, but that feels a bit silly to me.

i don't think utf8cursor/utf8byte could be modified to be RCU safe
apart from a copy. As part of normalization there's some sorting that
goes on to ensure that different encodings of the same characters can
be matched, and I think those can technically be arbitrarily long, so
we'd possibly end up needing the copy anyways.

So, I see two possible fixes.
1. Use take_dentry_name_snapshot along the RCU paths to calling d_hash
and d_compare, at least when needs_casefold is true.
2. Within d_hash/d_compare, create a copy of the name if it is a short name.

For 1, it adds some overhead in general, which I'm sure we'd want to avoid.
For 2, I don't think we know we're in RCU mode, so we'd need to always
copy short filenames. I'm also unsure if it's valid to assume that
name given is stable if it is not the same as dentry->d_iname. If it
is, we only need to worry about copying DNAME_INLINE_LEN bytes at max
there. For memcpy, is there a different version that we'd want to use
for option 2?

-Daniel
