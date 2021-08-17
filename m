Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE3D13EEE31
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Aug 2021 16:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239844AbhHQOL7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Aug 2021 10:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239137AbhHQOL7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Aug 2021 10:11:59 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29EFDC0613C1
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Aug 2021 07:11:26 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id m39so9033424uad.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Aug 2021 07:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mVJjtMrNCMh7zbljwOObjkhRwtgTHC3GfaBo0w1N3S8=;
        b=CIIZl0eW+J8lcwiAUBoLKWsiwvWYdqZ5Ncpg+tuJN+CG3IBYgT+cGD9cO8k3lt8a7h
         QYg2hni19Xj0g4xWT1R9pmhMNF5GZ6eP/B+1tP1InbN/3q5EdD2Eqk2Ap5f/+xLwmZ/r
         qrvnkPinSg3SWlgoKiUlbS0tJCHSYH8PralXU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mVJjtMrNCMh7zbljwOObjkhRwtgTHC3GfaBo0w1N3S8=;
        b=M//1xnVTJCUBoW6t50aFba+rCxnD0dJmoahmJECzIiO5+si3AtyaopTZs9JKX6ZG+o
         mOPnWs17zQ8SqdJj9rvuGH4sItSqgjiXbP59yAcPA5vbpteEWnGgQltp35LkQ/ifp7eE
         Ts0IMtmuusEJQ2OWE58y60LMU2bGiuXnowh5WIIHt7jwQ6FFMWS9TSQ/DgrTgtN+R+fc
         PHjxpTOGcIFwK0LlbwkLy7armCevZPGlj1IseRfmkxNzUCSTqQU/Dx4n4yHfOF/xs/4X
         P7XePtL8Pz6kPt+5cycaWSg9EZcbH5fAc6QUOnBDS9F9V2Rw6OiAaiUvJ38fwdSfPd3V
         MxGg==
X-Gm-Message-State: AOAM5328ZyoB/IStoXfjGzPljjf+ZXOwlza6sEPPLw8iUmLnBPiozrAq
        EjqAKqj1oysFACJW+bdQoD1FowIxrzCeN3cwpTFM9w==
X-Google-Smtp-Source: ABdhPJwfwYDKWaeijYN5B57Urcmntl+Mor7j6az2ngqZrcxCDEgcjMa0Sgjb7+PH0ycf4rBtHpQLu3K163F8mC758XA=
X-Received: by 2002:ab0:7014:: with SMTP id k20mr2523413ual.9.1629209485233;
 Tue, 17 Aug 2021 07:11:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210817022220.17574-1-jefflexu@linux.alibaba.com>
 <CAJfpeguw1hMOaxpDmjmijhf=-JEW95aEjxfVo_=D_LyWx8LDgw@mail.gmail.com>
 <YRuCHvhICtTzMK04@work-vm> <CAJfpegvM+S5Xru3Yfc88C64mecvco=f99y-TajQBDfkLD-S8zQ@mail.gmail.com>
 <0896b1f6-c8c4-6071-c05b-a333c6cccacd@linux.alibaba.com>
In-Reply-To: <0896b1f6-c8c4-6071-c05b-a333c6cccacd@linux.alibaba.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 17 Aug 2021 16:11:14 +0200
Message-ID: <CAJfpeguA3zeJq-HJUVZHv4nNybqFezkzPNhcWmj0n5+i7YpW4Q@mail.gmail.com>
Subject: Re: [Virtio-fs] [PATCH v4 0/8] fuse,virtiofs: support per-file DAX
To:     JeffleXu <jefflexu@linux.alibaba.com>
Cc:     "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        virtualization@lists.linux-foundation.org,
        virtio-fs-list <virtio-fs@redhat.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        linux-fsdevel@vger.kernel.org, Vivek Goyal <vgoyal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 17 Aug 2021 at 15:08, JeffleXu <jefflexu@linux.alibaba.com> wrote:
>
>
>
> On 8/17/21 6:09 PM, Miklos Szeredi wrote:
> > On Tue, 17 Aug 2021 at 11:32, Dr. David Alan Gilbert
> > <dgilbert@redhat.com> wrote:
> >>
> >> * Miklos Szeredi (miklos@szeredi.hu) wrote:
> >>> On Tue, 17 Aug 2021 at 04:22, Jeffle Xu <jefflexu@linux.alibaba.com> wrote:
> >>>>
> >>>> This patchset adds support of per-file DAX for virtiofs, which is
> >>>> inspired by Ira Weiny's work on ext4[1] and xfs[2].
> >>>
> >>> Can you please explain the background of this change in detail?
> >>>
> >>> Why would an admin want to enable DAX for a particular virtiofs file
> >>> and not for others?
> >>
> >> Where we're contending on virtiofs dax cache size it makes a lot of
> >> sense; it's quite expensive for us to map something into the cache
> >> (especially if we push something else out), so selectively DAXing files
> >> that are expected to be hot could help reduce cache churn.
> >
> > If this is a performance issue, it should be fixed in a way that
> > doesn't require hand tuning like you suggest, I think.
> >
> > I'm not sure what the  ext4/xfs case for per-file DAX is.  Maybe that
> > can help understand the virtiofs case as well.
> >
>
> Some hints why ext4/xfs support per-file DAX can be found [1] and [2].
>
> "Boaz Harrosh wondered why someone might want to turn DAX off for a
> persistent memory device. Hellwig said that the performance "could
> suck"; Williams noted that the page cache could be useful for some
> applications as well. Jan Kara pointed out that reads from persistent
> memory are close to DRAM speed, but that writes are not; the page cache
> could be helpful for frequent writes. Applications need to change to
> fully take advantage of DAX, Williams said; part of the promise of
> adding a flag is that users can do DAX on smaller granularities than a
> full filesystem."
>
> In summary, page cache is preferable in some cases, and thus more fine
> grained way of DAX control is needed.

Hmm, okay, very frequent overwrites could be problematic for directly
mapped nvram.

>
> As for virtiofs, Dr. David Alan Gilbert has mentioned that various files
> may compete for limited DAX window resource.
>
> Besides, supporting DAX for small files can be expensive. Small files
> can consume DAX window resource rapidly, and if small files are accessed
> only once, the cost of mmap/munmap on host can not be ignored.

That's a good point.   Maybe we should disable DAX for file sizes much
smaller than the chunk size?

Thanks,
Miklos
