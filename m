Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E045A3E9329
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Aug 2021 16:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbhHKOAg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Aug 2021 10:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbhHKOAf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Aug 2021 10:00:35 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA630C061765
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Aug 2021 07:00:11 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id k3so2950048ilu.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Aug 2021 07:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tB6IE1IliBlySkPnyFA3a/2aWGZiYvIwLeOU8UEwXy0=;
        b=PD9KdzJnjWcepDouCMyTFacBrDXdi82KREvX1G4TcymVhldlFYeOJBVGnblaE2uAf9
         URwNc31M6ESJ7slSP4ujaNIeEcKbQknuwj7EZvjdjMBGhAxdU+l9MnnNJ7E8OEaEbUXF
         ggg5lwiQGZA4Jljv6k+0Tfsq+SSTSYTHQMykgpPHqeEQPFzTRLyPkZrgVt3kA2EXLNID
         B330TzkMTSDDwgBVXXB2zHvBASrGx80kB5mZ0qocKZX4p6CUkiai0jXNDI1g6WyOnCyK
         wtsXetUgMWmoXsMYrVTruEIC2USP8dOASd0AvxeuhNE20PcMQEdUcz6CobRZacbaw4L8
         /kyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tB6IE1IliBlySkPnyFA3a/2aWGZiYvIwLeOU8UEwXy0=;
        b=ERMXsRm99cMwDpGczT6ZLp0NTlptwPZEpumRdXNOUCSnPmlAJoxIjMA1FsCYYiyRHi
         ZRluaNdTq/7TB694HMO5lOaxlXITJHipSo10MyxtYpm1BzSzLzfr8ab0HcKEfHUVEWls
         tEXh8nkQpPKI/hciWXiynQXVvfByAGzJ9vDqTW/P5lcrjaUo6J8UVvzrFN5Bmg94fGwO
         2nCjnGnsIFSfR5bryv4obRQIirxlmNutOwSbek3uUkYOLFNHvK9py6K+LpAl6Y90nvJz
         wZQn0LMEu6Kx5CZUnLzc9MTFrqeOAuqy9ykGxXbno68sbHFki1rUQBeUJjjQxgbxtx79
         KXJQ==
X-Gm-Message-State: AOAM530dqF5n46JiaaCxPLWd7SHwa+YrXJElI7UKJUc6N05tew3FGJ4y
        CQ7ECsEwoOrSbhZZDpeuZWonlG3BTSIWDtEZ4+k=
X-Google-Smtp-Source: ABdhPJyB66UyapBSVcgV1ztIKZa5cXLzSPxZB63EO3e/IUDgFK4CLIBcF7JS/m3ivt8WEnnB2Zv47jR9pjsZjEM7ZFA=
X-Received: by 2002:a05:6e02:1c02:: with SMTP id l2mr948188ilh.9.1628690411136;
 Wed, 11 Aug 2021 07:00:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210810151220.285179-1-amir73il@gmail.com> <20210810151220.285179-4-amir73il@gmail.com>
 <20210811113741.GD14725@quack2.suse.cz>
In-Reply-To: <20210811113741.GD14725@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 11 Aug 2021 16:59:59 +0300
Message-ID: <CAOQ4uxgDa8zDm2u3kvmW1DkSQTrKTyvGO=9oj-XTK0ZVwU77Yw@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] fsnotify: count all objects with attached connectors
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 11, 2021 at 2:37 PM Jan Kara <jack@suse.cz> wrote:
>
> On Tue 10-08-21 18:12:19, Amir Goldstein wrote:
> > Rename s_fsnotify_inode_refs to s_fsnotify_connectors and count all
> > objects with attached connectors, not only inodes with attached
> > connectors.
> >
> > This will be used to optimize fsnotify() calls on sb without any
> > type of marks.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>
> ... just a minor nit below ...
>
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index 640574294216..d48d2018dfa4 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -1507,8 +1507,8 @@ struct super_block {
> >       /* Number of inodes with nlink == 0 but still referenced */
> >       atomic_long_t s_remove_count;
> >
> > -     /* Pending fsnotify inode refs */
> > -     atomic_long_t s_fsnotify_inode_refs;
> > +     /* Number of inode/mount/sb objects that are being watched */
> > +     atomic_long_t s_fsnotify_connectors;
>
> I've realized inode watches will be double-accounted because we increment
> s_fsnotify_connectors both when attaching a connector and when grabbing
> inode reference. It doesn't really matter and avoiding this would require
> special treatment of inode connectors (we need to decrement
> s_fsnotify_connectors only after dropping inode reference). So I'll just
> reflect this in the comment here so that we don't forget.

Great!
I actually have a patch to make the inode reference optional
per backend/mark [1], so keeping double account makes things
a lot easier for that code as well.

Thanks,
Amir.

[1] https://github.com/amir73il/linux/commits/fsnotify-volatile
