Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA3103EEAA6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Aug 2021 12:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236297AbhHQKKZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Aug 2021 06:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236472AbhHQKKY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Aug 2021 06:10:24 -0400
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4BA6C0613CF
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Aug 2021 03:09:51 -0700 (PDT)
Received: by mail-vk1-xa30.google.com with SMTP id j196so3306373vkj.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Aug 2021 03:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L5HiMY324/mbIiHBmv8ouk9uhF1dk69cnwR9QB4zoKM=;
        b=KpRR7+8nUUVsoxbdOgYQucb4dRqGY/Ztix1ugMqRzceQBu4muJt6dC7z66GwPBj84e
         V3Am9kEWnBv01osYvcdUtdn2dTZ36LI/wWYbIjsYs7ZuZcoNzyGaIN6chtnCdAjldYFY
         wINqi1LA8R72QTsmD5zTtwaSWYMXBjNt8IDBM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L5HiMY324/mbIiHBmv8ouk9uhF1dk69cnwR9QB4zoKM=;
        b=cSjzmReVOQCLFfI6I+0Azg5JcE5ob69tNBX+Vg4/dfiWnD/UUxbu3+0zwpYzwfebc4
         PLA+nomTeNo6GX7snASMmLrWHfod6vIGkV6j+cRyR7xV0b0G1kAfrKJgxtWMwPNAgHk8
         JzAIqfhhen2KXbf19NVmF5BoZ+IvR3G6fDt0qCxHDeIYVZvRy7r6TBAEKD0WkxwfpLs4
         sGfSy3ykwp86DScM+laWGWHXKBst5yKbyg6/A0BWBRkbKG/TVn/Yl8N7W5IAUP/HwgiC
         j9ePmivGYJ7E5o6uRRfFesVkIKLn7pzWb/AFoi8WWm3LbwS4h1QfdtMLBCUaQIluIdE5
         ZdLQ==
X-Gm-Message-State: AOAM5321bo0A8zlT1ddPHblCC7z5SnDnyGZ/vwCOXuEsEuhC6jMgg/RC
        8V16prtBTSxI2mJWxSgm00lEHHrfXrFbedM5+1kX5Q==
X-Google-Smtp-Source: ABdhPJx8pk1uqplN3trcA8W23P3kKfETTVV14540Sqzr1MmA7GLiXmHKTRoBH4e7h1pdUu4Y+EYLENTS3MQcKJKUrR4=
X-Received: by 2002:a1f:d442:: with SMTP id l63mr1936973vkg.3.1629194990938;
 Tue, 17 Aug 2021 03:09:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210817022220.17574-1-jefflexu@linux.alibaba.com>
 <CAJfpeguw1hMOaxpDmjmijhf=-JEW95aEjxfVo_=D_LyWx8LDgw@mail.gmail.com> <YRuCHvhICtTzMK04@work-vm>
In-Reply-To: <YRuCHvhICtTzMK04@work-vm>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 17 Aug 2021 12:09:40 +0200
Message-ID: <CAJfpegvM+S5Xru3Yfc88C64mecvco=f99y-TajQBDfkLD-S8zQ@mail.gmail.com>
Subject: Re: [Virtio-fs] [PATCH v4 0/8] fuse,virtiofs: support per-file DAX
To:     "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc:     Jeffle Xu <jefflexu@linux.alibaba.com>,
        virtualization@lists.linux-foundation.org,
        virtio-fs-list <virtio-fs@redhat.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        linux-fsdevel@vger.kernel.org, Vivek Goyal <vgoyal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 17 Aug 2021 at 11:32, Dr. David Alan Gilbert
<dgilbert@redhat.com> wrote:
>
> * Miklos Szeredi (miklos@szeredi.hu) wrote:
> > On Tue, 17 Aug 2021 at 04:22, Jeffle Xu <jefflexu@linux.alibaba.com> wrote:
> > >
> > > This patchset adds support of per-file DAX for virtiofs, which is
> > > inspired by Ira Weiny's work on ext4[1] and xfs[2].
> >
> > Can you please explain the background of this change in detail?
> >
> > Why would an admin want to enable DAX for a particular virtiofs file
> > and not for others?
>
> Where we're contending on virtiofs dax cache size it makes a lot of
> sense; it's quite expensive for us to map something into the cache
> (especially if we push something else out), so selectively DAXing files
> that are expected to be hot could help reduce cache churn.

If this is a performance issue, it should be fixed in a way that
doesn't require hand tuning like you suggest, I think.

I'm not sure what the  ext4/xfs case for per-file DAX is.  Maybe that
can help understand the virtiofs case as well.

Thanks,
Miklos
