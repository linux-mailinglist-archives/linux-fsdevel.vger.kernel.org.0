Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22442402B11
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Sep 2021 16:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236373AbhIGOw0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Sep 2021 10:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbhIGOwZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Sep 2021 10:52:25 -0400
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 510CEC061575
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Sep 2021 07:51:19 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id z3so1838646uav.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Sep 2021 07:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zOc8feQK3rpyOFx/qVU1OaRHVboeJHglZGHZH01zit4=;
        b=pa6WvdVTw0CWZA3iqWodJt9w6Nzl3iAoUmZrUChVnVRDNTmiwbCP8BX1VLcx63E3Ly
         KLTRcueFAc7JPNUi0Qq47jxf3w3terrhI/R/A9uNLHYYaynOsfaxtAPrF7BuCERCyUmf
         acITq84sNSoZJ9eL8UN3jj6RFOlekEpTqW7/E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zOc8feQK3rpyOFx/qVU1OaRHVboeJHglZGHZH01zit4=;
        b=ZjnvhwFz3ArCC2gGcIcsj7xfyE0n/Sx34lJp6stk3juSF9xrzVIa4Dcf5Goc4i5bva
         aXqAy1jpOxt3lKTOdxtaJSdDFPqL+uzzBAuasr5y2Xokr1DUAnevZWni2eSs0FGeoe/z
         Kshu7NnSa+mTen/z8ldLGSXH7AMnGUQYtYbYDn5BDES7h23ssPTAJFf+Qi4uS/W7r/fh
         lsZDt9lrh/F42vOWACFQ99BNvqxKOeban1crvISbNEm0HZSF4TWXg9/BEL/lpso5xDFd
         4ke4MYq26vTEN9l4JQbmH4LijqBdgqyrCy6OwgoTLklbBfjgxqRaeOAQ0H8CVmgWDlwM
         habA==
X-Gm-Message-State: AOAM532ICan/59iOd2xWlEVGiv7ISI4EjhAV+wOC22YJFljt0x0cdQQO
        HL5p3YFfXmEYSW6bqQP6f9VADDM0WbLP9SRt07FzgQ==
X-Google-Smtp-Source: ABdhPJwQi8ohxjO3fS9RrtRvPnRWBFYVSUW3nYZ6aDQSeWIdqgy4qlzGmvP3olskoNKAAiDr2SvpiMH8DsBLn4GhC9I=
X-Received: by 2002:a05:6130:30a:: with SMTP id ay10mr9115895uab.8.1631026278466;
 Tue, 07 Sep 2021 07:51:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210817022220.17574-1-jefflexu@linux.alibaba.com>
 <CAJfpeguw1hMOaxpDmjmijhf=-JEW95aEjxfVo_=D_LyWx8LDgw@mail.gmail.com>
 <YRut5sioYfc2M1p7@redhat.com> <6043c0b8-0ff1-2e11-0dd0-e23f9ff6b952@linux.alibaba.com>
 <CAJfpegv01k5hEyJ3LPDWJoqB+vL8hwTan9dLu1pkkD0xoRuFzw@mail.gmail.com> <a1d891b5-f8ef-b5fe-c20c-e3e01203b368@linux.alibaba.com>
In-Reply-To: <a1d891b5-f8ef-b5fe-c20c-e3e01203b368@linux.alibaba.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 7 Sep 2021 16:51:06 +0200
Message-ID: <CAJfpegsZpj98Duo6AsO-bsJi0BqAbCkBNhi_K=7Jv4a+Y8TCuw@mail.gmail.com>
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

On Fri, 3 Sept 2021 at 07:31, JeffleXu <jefflexu@linux.alibaba.com> wrote:
>
>
>
> On 8/17/21 10:08 PM, Miklos Szeredi wrote:
> > On Tue, 17 Aug 2021 at 15:22, JeffleXu <jefflexu@linux.alibaba.com> wrote:
> >>
> >>
> >>
> >> On 8/17/21 8:39 PM, Vivek Goyal wrote:
> >>> On Tue, Aug 17, 2021 at 10:06:53AM +0200, Miklos Szeredi wrote:
> >>>> On Tue, 17 Aug 2021 at 04:22, Jeffle Xu <jefflexu@linux.alibaba.com> wrote:
> >>>>>
> >>>>> This patchset adds support of per-file DAX for virtiofs, which is
> >>>>> inspired by Ira Weiny's work on ext4[1] and xfs[2].
> >>>>
> >>>> Can you please explain the background of this change in detail?
> >>>>
> >>>> Why would an admin want to enable DAX for a particular virtiofs file
> >>>> and not for others?
> >>>
> >>> Initially I thought that they needed it because they are downloading
> >>> files on the fly from server. So they don't want to enable dax on the file
> >>> till file is completely downloaded.
> >>
> >> Right, it's our initial requirement.
> >>
> >>
> >>> But later I realized that they should
> >>> be able to block in FUSE_SETUPMAPPING call and make sure associated
> >>> file section has been downloaded before returning and solve the problem.
> >>> So that can't be the primary reason.
> >>
> >> Saying we want to access 4KB of one file inside guest, if it goes
> >> through FUSE request routine, then the fuse daemon only need to download
> >> this 4KB from remote server. But if it goes through DAX, then the fuse
> >> daemon need to download the whole DAX window (e.g., 2MB) from remote
> >> server, so called amplification. Maybe we could decrease the DAX window
> >> size, but it's a trade off.
> >
> > That could be achieved with a plain fuse filesystem on the host (which
> > will get 4k READ requests for accesses to mapped area inside guest).
> > Since this can be done selectively for files which are not yet
> > downloaded, the extra layer wouldn't be a performance problem.
> >
> > Is there a reason why that wouldn't work?
>
> I didn't realize this mechanism (working around from user space) before
> sending this patch set.
>
> After learning the virtualization and KVM stuffs, I find that, as Vivek
> Goyal replied in [1], virtiofsd/qemu need to somehow hook the user page
> fault and then download the remained part.
>
> IMHO, this mechanism (as you proposed by implementing a plain fuse
> filesystem on the host) seems a little bit sophisticated so far.


Agree.  Let's start with the simplest variant, which is the server
selectively enabling dax.

Thanks,
Miklos
