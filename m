Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD9BB3427F9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Mar 2021 22:48:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbhCSVri (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Mar 2021 17:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbhCSVrX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Mar 2021 17:47:23 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21ABEC06175F
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Mar 2021 14:47:23 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id g8so5050993lfv.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Mar 2021 14:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N6aTi9USXUTEe6463tZeUFfEF6sydMc4F3aHzBvCJTg=;
        b=EVtmZajDtoqqVNxo4gyn0Tekfg+N2EalnddFD5XT8VNUvhcJONV0/s2Heiwtgg/XEu
         Jo9KfgMdjGMAoM5ySFRHJGYq+wD1juQy4450shqWKbaECyQ2+tHotorC/Fh3vCah1/gh
         VNS8lE91M6kD7wqZS20wJD/pq9hJ4BfB/aGbs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N6aTi9USXUTEe6463tZeUFfEF6sydMc4F3aHzBvCJTg=;
        b=mJZgdnBEuw/mO7lEiyrirUz8Wi0tLbK/6YZbjQD5Tgza8TzAgeHrCbOpL06AgWhK7f
         w3TNcSQm5eJM/EtQEovvCBGHL5yaBJ4Wz5OpAaKF9/PHITa8BjbXl9dvVK+EKIYvd8dk
         RFSiKBvvJ0vVr3PkXYRkQggL0LQORt2r0yqm0jil+dVl7u3ze6P8nLxGbrZI3ELW8dTn
         Bl3doXSNr21dlxcbiMagwtosdkBv++laR2ylNtqHAAkLUJPs0jIYXg48I32omu5DVEcd
         Ix4frCPuMdp+r1Oz/yO/AC9FXBcYUmvSoAr+ZZNo71W5HOrQ0sGcIFl6S3CH8ATNpfEa
         qW9A==
X-Gm-Message-State: AOAM532OCuOXca348EgIJ8oPYlmI28/EpzPcxicPOf7AZSnIr55oeljf
        exS5950m2j6gRHcykaeSz4qKFVk35rOK8Q==
X-Google-Smtp-Source: ABdhPJze9vzSQcJkqVRtmaQQ4MgdAzUx+VAYdCUza5ftdAl7qzm5yMeyDn+xd0hm2+vWWvbOC4zzSA==
X-Received: by 2002:a05:6512:3e20:: with SMTP id i32mr1985903lfv.257.1616190441214;
        Fri, 19 Mar 2021 14:47:21 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id i22sm911021ljg.37.2021.03.19.14.47.20
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Mar 2021 14:47:20 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id q29so12068443lfb.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Mar 2021 14:47:20 -0700 (PDT)
X-Received: by 2002:ac2:4250:: with SMTP id m16mr1890000lfl.40.1616190439785;
 Fri, 19 Mar 2021 14:47:19 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1615922644.git.osandov@fb.com> <8f741746-fd7f-c81a-3cdf-fb81aeea34b5@toxicpanda.com>
 <CAHk-=wj6MjPt+V7VrQ=muspc0DZ-7bg5bvmE2ZF-1Ea_AQh8Xg@mail.gmail.com>
 <YFUJLUnXnsv9X/vN@relinquished.localdomain> <CAHk-=whGEM0YX4eavgGuoOqhGU1g=bhdOK=vUiP1Qeb5ZxK56Q@mail.gmail.com>
 <YFUTnDaCdjWHHht5@relinquished.localdomain>
In-Reply-To: <YFUTnDaCdjWHHht5@relinquished.localdomain>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 19 Mar 2021 14:47:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjhSP88EcBnqVZQhGa4M6Tp5Zii4GCBoNBBdcAc3PUYbg@mail.gmail.com>
Message-ID: <CAHk-=wjhSP88EcBnqVZQhGa4M6Tp5Zii4GCBoNBBdcAc3PUYbg@mail.gmail.com>
Subject: Re: [PATCH v8 00/10] fs: interface for directly reading/writing
 compressed data
To:     Omar Sandoval <osandov@osandov.com>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Linux API <linux-api@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 19, 2021 at 2:12 PM Omar Sandoval <osandov@osandov.com> wrote:
>
> After spending a few minutes trying to simplify copy_struct_from_iter(),
> it's honestly easier to just use the iterate_all_kinds() craziness than
> open coding it to only operate on iov[0]. But that's an implementation
> detail, and we can trivially make the interface stricter:

This is an improvement, but talking about the iterate_all_kinds()
craziness, I think your existing code is broken.

That third case (kernel pointer source):

+    copy = min(ksize - copied, v.iov_len);
+    memcpy(dst + copied, v.iov_base, copy);
+    if (memchr_inv(v.iov_base, 0, v.iov_len))
+        return -E2BIG;

can't be right. Aren't you checking that it's *all* zero, even the
part you copied?

Our iov_iter stuff is really complicated already, this is part of why
I'm not a huge fan of using it.

I still suspect you'd be better off not using the iterate_all_kinds()
thing at all, and just explicitly checking ITER_BVEC/ITER_KVEC
manually.

Because you can play games like fooling your "copy_struct_from_iter()"
to not copy anything at all with ITER_DISCARD, can't you?

Which then sounds like it might end up being useful as a kernel data
leak, because it will use some random uninitialized kernel memory for
the structure.

Now, I don't think you can actually get that ITER_DISCARD case, so
this is not *really* a problem, but it's another example of how that
iterate_all_kinds() thing has these subtle cases embedded into it.

The whole point of copy_struct_from_iter() is presumably to be the
same kind of "obviously safe" interface as copy_struct_from_user() is
meant to be, so these subtle cases just then make me go "Hmm".

I think just open-coding this when  you know there is no actual
looping going on, and the data has to be at the *beginning*, should be
fairly simple. What makes iterate_all_kinds() complicated is that
iteration, the fact that there can be empty entries in there, but it's
also that "iov_offset" thing etc.

For the case where you just (a) require that iov_offset is zero, and
(b) everything has to fit into the very first iov entry (regardless of
what type that iov entry is), I think you actually end up with a much
simpler model.

I do realize that I am perhaps concentrating a bit too much on this
one part of the patch series, but the iov_iter thing has bitten us
before. And it has bitten really core developers and then Al has had
to fix up mistakes.

In fact, it wasn't that long ago that I asked Al to verify code I
wrote, because I was worried about having missed something subtle. So
now when I see these iov_iter users, it just makes me go all nervous.

          Linus
