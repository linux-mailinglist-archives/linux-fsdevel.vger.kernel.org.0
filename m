Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80A243EEE25
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Aug 2021 16:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237722AbhHQOJG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Aug 2021 10:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231786AbhHQOJF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Aug 2021 10:09:05 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B96AFC061764
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Aug 2021 07:08:32 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id g1so13204879vsq.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Aug 2021 07:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OhvGWYbd6i+9LyJq3j7yIZkL8jqg1hxfCOejeLbe8Qw=;
        b=Cq2HqxAgAZyEpm1Yuuk/cS9cDd/pWPIc5OfuCq5A4W9rryPdCFdng78Uym3lmRr5Mb
         9oYrzweOyKHsWDPd3GdAH++YjYpAMeQEy6J/U0jyOBfOkk90qhmZ9NxmUndAWBKo1xuj
         iu64CHvaqxqRt7Ir3g0/QldlTHx5qnGvK3ZU8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OhvGWYbd6i+9LyJq3j7yIZkL8jqg1hxfCOejeLbe8Qw=;
        b=V+JUYuCp3xsiYAu8K+eUpnEu6qUOduWjdexo18gJHflOw2o7o2Y4rmg3kDu0+Esgpg
         ICvPV49mjKN6WDPcI1WQChQsIHuEf9vxGC8ZUJYMteTPR5b8W5EAt9oCECnhxh4BeVrR
         o0ctIgQJ6+ryBF/Emz+bx0yVWp5A8ZSqNtWOpQg1ZP6TV27X5O4GrWbAsaDuZH+bthKm
         6erOjJAEYN3x4XcCSbrIqJ8k9Tqfrkv/WqJgtqZixRGd51e9cLGwLMyS1+refRT+YaNB
         I1zUp8Kkd29HRn5KNT5P2Y5qV0IkTzEABsff7vCfUZDy6xjIVO12kwnQHT9tGSZI5KQ/
         l+5A==
X-Gm-Message-State: AOAM5320pzRO6uQhYHb5eJ6mSNLbG/iwDSN76yqJ6Ao+t/JdUIAkwdOf
        ZtCUKhdB1gBVA38Vx7RfniDmrkETx2vcoI1+g8LGog==
X-Google-Smtp-Source: ABdhPJx/F+lwVW6usP16d3M297qMNKPWSqZj4scWmsKlmL9gttfpbk7Fy5UeizuRx35WhDtSPRwsEKwuWC+0JXH5QRo=
X-Received: by 2002:a67:5c41:: with SMTP id q62mr2995771vsb.7.1629209311917;
 Tue, 17 Aug 2021 07:08:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210817022220.17574-1-jefflexu@linux.alibaba.com>
 <CAJfpeguw1hMOaxpDmjmijhf=-JEW95aEjxfVo_=D_LyWx8LDgw@mail.gmail.com>
 <YRut5sioYfc2M1p7@redhat.com> <6043c0b8-0ff1-2e11-0dd0-e23f9ff6b952@linux.alibaba.com>
In-Reply-To: <6043c0b8-0ff1-2e11-0dd0-e23f9ff6b952@linux.alibaba.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 17 Aug 2021 16:08:21 +0200
Message-ID: <CAJfpegv01k5hEyJ3LPDWJoqB+vL8hwTan9dLu1pkkD0xoRuFzw@mail.gmail.com>
Subject: Re: [PATCH v4 0/8] fuse,virtiofs: support per-file DAX
To:     JeffleXu <jefflexu@linux.alibaba.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        virtio-fs-list <virtio-fs@redhat.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Liu Bo <bo.liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 17 Aug 2021 at 15:22, JeffleXu <jefflexu@linux.alibaba.com> wrote:
>
>
>
> On 8/17/21 8:39 PM, Vivek Goyal wrote:
> > On Tue, Aug 17, 2021 at 10:06:53AM +0200, Miklos Szeredi wrote:
> >> On Tue, 17 Aug 2021 at 04:22, Jeffle Xu <jefflexu@linux.alibaba.com> wrote:
> >>>
> >>> This patchset adds support of per-file DAX for virtiofs, which is
> >>> inspired by Ira Weiny's work on ext4[1] and xfs[2].
> >>
> >> Can you please explain the background of this change in detail?
> >>
> >> Why would an admin want to enable DAX for a particular virtiofs file
> >> and not for others?
> >
> > Initially I thought that they needed it because they are downloading
> > files on the fly from server. So they don't want to enable dax on the file
> > till file is completely downloaded.
>
> Right, it's our initial requirement.
>
>
> > But later I realized that they should
> > be able to block in FUSE_SETUPMAPPING call and make sure associated
> > file section has been downloaded before returning and solve the problem.
> > So that can't be the primary reason.
>
> Saying we want to access 4KB of one file inside guest, if it goes
> through FUSE request routine, then the fuse daemon only need to download
> this 4KB from remote server. But if it goes through DAX, then the fuse
> daemon need to download the whole DAX window (e.g., 2MB) from remote
> server, so called amplification. Maybe we could decrease the DAX window
> size, but it's a trade off.

That could be achieved with a plain fuse filesystem on the host (which
will get 4k READ requests for accesses to mapped area inside guest).
Since this can be done selectively for files which are not yet
downloaded, the extra layer wouldn't be a performance problem.

Is there a reason why that wouldn't work?

Thanks,
Miklos
