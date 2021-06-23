Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B31F33B204C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jun 2021 20:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbhFWSaz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Jun 2021 14:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhFWSay (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Jun 2021 14:30:54 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EFDDC06175F
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Jun 2021 11:28:35 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id i13so5702277lfc.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Jun 2021 11:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2DBn5HdXOpZgVQ8KPUgd2aBGCJUyOO7ECPAqS5weW4A=;
        b=Kj+hLndwyvc/mfTqQ6gKaOe6XVkmJqARj1L3LmTcx5H0lkR0ZC7hX4g0gC2QfMPVn9
         D4D/yLKvZnz/aelRjyesIMmF51k8cXui0ngD+v19HjzhNMsQONFyAdiwF/45B9XgDiZx
         vzajP4ufzUbCCXkw+tw5Z+CU5KumH2tXntIIk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2DBn5HdXOpZgVQ8KPUgd2aBGCJUyOO7ECPAqS5weW4A=;
        b=skshGQGDeKr3nOegJ37g5R5isgnbIC8GfoJ0p3fCTtGan+stxDt4vhoLZu4q3sqOTF
         4+UgPig4/kycNzORjDAuKfN52PrcPICs8z6I1EaNFuNe4PKTjM/s6we8ES3t2DHHKNAx
         xWwGIQCi8nSEteoCHMQLIuSsFQ/sUOxvOH7l0CiBipetCo77JtxuxauHYOK1fcrVRt7u
         fK3GAv/UHoW7lfATpUZy5CMUScyFBEpyyHWXUC09wmqgjnu5AtHCSCD36SSxyfmJFPHN
         MrK8WUzebSIDP2+oWnypQF1JHcqxSSmHLm4RJC6EPreMj1LeazBsHU5wTcf1l1Z7HtP6
         SOYQ==
X-Gm-Message-State: AOAM531Zc5O+rJzI7OMXPumfK3XHkDO7BYLGx+xhFMn3ccwtFo2CStgx
        qP9Wa68efmof3+MMNqnxxNFU1j2gkbB06YZ5a/4=
X-Google-Smtp-Source: ABdhPJxwnVxR7w1FcOaUsDWkkxJ+k065RQZzEW9Pk7tj729PWr+XqWsRzzyzOpRp/k7J5HbZTlEkuQ==
X-Received: by 2002:a05:6512:1292:: with SMTP id u18mr716549lfs.638.1624472913125;
        Wed, 23 Jun 2021 11:28:33 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id j19sm76842lfb.150.2021.06.23.11.28.31
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jun 2021 11:28:32 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id d16so5716775lfn.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Jun 2021 11:28:31 -0700 (PDT)
X-Received: by 2002:a19:7d04:: with SMTP id y4mr678705lfc.201.1624472911513;
 Wed, 23 Jun 2021 11:28:31 -0700 (PDT)
MIME-Version: 1.0
References: <YM0Q5/unrL6MFNCb@zeniv-ca.linux.org.uk> <CAHk-=wjDhxnRaO8FU-fOEAF6WeTUsvaoz0+fr1tnJvRCfAaSCQ@mail.gmail.com>
 <YM0Zu3XopJTGMIO5@relinquished.localdomain> <YM0fFnMFSFpUb63U@zeniv-ca.linux.org.uk>
 <YM09qaP3qATwoLTJ@relinquished.localdomain> <YNDem7R6Yh4Wy9po@relinquished.localdomain>
 <CAHk-=wh+-otnW30V7BUuBLF7Dg0mYaBTpdkH90Ov=zwLQorkQw@mail.gmail.com>
 <YND6jOrku2JDgqjt@relinquished.localdomain> <YND8p7ioQRfoWTOU@relinquished.localdomain>
 <20210622220639.GH2419729@dread.disaster.area> <YNN0P4KWH+Uj7dTE@relinquished.localdomain>
In-Reply-To: <YNN0P4KWH+Uj7dTE@relinquished.localdomain>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 23 Jun 2021 11:28:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjptRD=dzst-=O0D_X2q0kU2ijdTEjrg0=vvtqdjJ_x8g@mail.gmail.com>
Message-ID: <CAHk-=wjptRD=dzst-=O0D_X2q0kU2ijdTEjrg0=vvtqdjJ_x8g@mail.gmail.com>
Subject: Re: [PATCH RESEND x3 v9 1/9] iov_iter: add copy_struct_from_iter()
To:     Omar Sandoval <osandov@osandov.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Dave Chinner <david@fromorbit.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Dave Chinner <dchinner@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 23, 2021 at 10:49 AM Omar Sandoval <osandov@osandov.com> wrote:
>
> Al, Linus, what do you think? Is there a path forward for this series as
> is?

So the "read from user space in order to write" is a no-go for me. It
completely violates what a "read()" system call should do. It also
entirely violates what an iovec can and should do.

And honestly, if Al hates the "first iov entry" model, I'm not sure I
want to merge that version - I personally find it fine, but Al is
effectively the iov-iter maintainer.

I do worry a bit about the "first iov entry" simply because it might
work for "writev2()" when given virtual user space addresses - but I
think it's conceptually broken for things like direct-IO which might
do things by physical address, and what is a contiguous user space
virtual address is not necessarily a contiguous physical address.

Yes, the filesystem can - and does - hide that path by basically not
doing direct-IO on the first entry at all, and just treat is very
specially in the front end of the IO access, but that only reinforces
the whole "this is not at all like read/write".

Similar issues might crop up in other situations, ie splice etc, where
it's not at all obvious that the iov_iter boundaries would be
maintained as it moves through the system.

So while I personally find the "first iov entry" model fairly
reasonable, I think Dave is being disingenuous when he says that it
looks like a normal read/write. It very much does not. The above is
quite fundamental.

>  I'd be happy to have this functionality merged in any form, but I do
> think that this approach with preadv2/pwritev2 using iov_len is decent
> relative to the alternatives.

As mentioned, I find it acceptable. I'm completely unimpressed with
Dave's argument, but ioctl's aren't perfect either, so weak or not,
that argument being bogus doesn't necessarily mean that the iovec
entry model is wrong.

That said, thinking about exactly the fact that I don't think a
translation from iovec to anything else can be truly valid, I find the
iter_is_iovec() case to be the only obviously valid one.

Which gets me back to: how can any of the non-iovec alternatives ever
be valid? You did mention having missed ITER_XARRAY, but my question
is more fundamental than that. How could a non-iter_is_iovec ever be
valid? There are no possible interfaces that can generate such a thing
sanely.

                Linus
