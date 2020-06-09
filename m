Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3AD1F3F86
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jun 2020 17:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730870AbgFIPhT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Jun 2020 11:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728162AbgFIPhS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Jun 2020 11:37:18 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B9F7C05BD1E;
        Tue,  9 Jun 2020 08:37:17 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id 18so20708803iln.9;
        Tue, 09 Jun 2020 08:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9VUTuEo+U6AjQfgdqE+kag2R4dJmyY/gX0I9on+4qYQ=;
        b=XMzHXf6UF1rT8rlEr/+kWEMnMoxVA3NmD9Kp4d9gRO/ml7/I5JBP2eyEnGso/PCpsS
         0JQdF5qEc+bWWBgm2TeJXwu86fGPV2ALPsG+u5rumiwiG9/I6uYIBeA8a7Z16J2kbwV2
         xgKQAV7zQGT3mU+R28MGjdNGgqnhJa4VgA/wEcVDg3Azk/bSsKBjyManNh3CJC8aDGSO
         xfmx2jrA6BL7RXF5sCdWHFxXQcGY0b8wMxi/w8JKMuLiEocsMqcH8wg4CJrPrvTCiYeD
         9sKkN9crqjpVphJSPhTvq48S57Q+P6kHsy/lrH22lEbYr+vrxDt/sjY6X7qVsjm1korI
         fu/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9VUTuEo+U6AjQfgdqE+kag2R4dJmyY/gX0I9on+4qYQ=;
        b=gCvTdbZV9/Yui3wlZXhIDURBdMs0PppS2GLMr5CAwxEgCYs8m1Jka6TidYHRO7QRqR
         XU+y2ez/2sP7UDEBBQ9ayPk+zn5rJgBnwc0H2phbrOHGHU5FNMMSYIvLoVIcYbtbnYAh
         cGSjtCMsCXPb1Mur32jpuyC7ZELf5TQK6HtLei1tf9Zzh0ry64b+624z8q7DF0mxJp3T
         Wmf89+1TApgtWwEE8UUhvpUoNrqdYS0rH/4RKmIakczgkRC2emowIOS4/9WUXkWgvfOS
         Sj7LDqFUX+l4pbOtyiTwiw0cPc6zAfMhM1uVW3XLEbCaRwLZZPi9eA4yBbyqCggLT+G5
         JVvw==
X-Gm-Message-State: AOAM532sHcgzcwh+luV/ZjYZIBtbAdzSjjYTj5yQr9e3uPzaMeYd7Laa
        kX9bXLryg8SUEYS6zN3JGcsdxGOsIPeePQ7ALcE=
X-Google-Smtp-Source: ABdhPJwCD4q8IzTdVyGuBGb4l8OE121opqXhW4x8c9rSDbQ89q5a7oQdr68/IHH7SRmXTHMo+OpWZaLUoBU4XDmq0Ik=
X-Received: by 2002:a92:4899:: with SMTP id j25mr28737084ilg.168.1591717036418;
 Tue, 09 Jun 2020 08:37:16 -0700 (PDT)
MIME-Version: 1.0
References: <1591254347-15912-1-git-send-email-laoar.shao@gmail.com>
 <20200609140304.GA11626@infradead.org> <CALOAHbCeFFPCVS-toSC32qtLqQsEF1KG6p0OBXkQb=T2g6YpYw@mail.gmail.com>
 <20200609143211.GA22303@infradead.org>
In-Reply-To: <20200609143211.GA22303@infradead.org>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Tue, 9 Jun 2020 23:36:40 +0800
Message-ID: <CALOAHbDvMwZikzpyh6hzm38pcksJGF+achb+C1SLUA2ovip8mA@mail.gmail.com>
Subject: Re: [PATCH v2] iomap: avoid deadlock if memory reclaim is triggered
 in writepage path
To:     Christoph Hellwig <hch@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 9, 2020 at 10:32 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Tue, Jun 09, 2020 at 10:28:06PM +0800, Yafang Shao wrote:
> > On Tue, Jun 9, 2020 at 10:03 PM Christoph Hellwig <hch@infradead.org> wrote:
> > >
> > > On Thu, Jun 04, 2020 at 03:05:47AM -0400, Yafang Shao wrote:
> > > > Recently there is a XFS deadlock on our server with an old kernel.
> > > > This deadlock is caused by allocating memory in xfs_map_blocks() while
> > > > doing writeback on behalf of memroy reclaim. Although this deadlock happens
> > > > on an old kernel, I think it could happen on the upstream as well. This
> > > > issue only happens once and can't be reproduced, so I haven't tried to
> > > > reproduce it on upsteam kernel.
> > >
> > > The report looks sensible, but I don't think the iomap code is the
> > > right place for this.  Until/unless the VM people agree that
> > > ->writepages(s) generally should not recurse into the fs I think the
> > > low-level file system allocating is the right place, so xfs_map_blocks
> > > would seem like the correct place.
> >
> > Thanks for your comment.
> > That is what I did in the previous version [1].
> > So should I resend the v1 ?
>
> Well, v1 won't apply.  But I do prefer the approach there.

All right. Let's include MM maintainers and see the opinion from them.

Hi Michal, Andrew,

What's your opinion on this XFS deadlock ?
Should ->writepages(s) generally not recurse into the fs ?


-- 
Thanks
Yafang
