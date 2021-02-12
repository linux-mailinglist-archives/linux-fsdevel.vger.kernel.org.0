Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64B7B319B1D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Feb 2021 09:22:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbhBLIVO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Feb 2021 03:21:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbhBLIVK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Feb 2021 03:21:10 -0500
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0298C061574
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Feb 2021 00:20:29 -0800 (PST)
Received: by mail-vs1-xe36.google.com with SMTP id k9so4404511vsr.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Feb 2021 00:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9eYlj6hQUpTjmYWO1lf/Yhxzwmx2Hj9092MghEwCPMY=;
        b=K5xk8xd16HqUbigXN8BlwaPLjCOqShVd9lxD0yujPtmZqP9Oaku0mPFAZEtFgUeWwN
         NV1d/6le+5zDnw4HY8TbN2qNaylzKUE5b66s86Jw85ugyYMTFQKEa9+HKcOZFxgbLjth
         UwwVVRkxJ6Fg5FGUeKSrvdvA9uz2QqY/QdEFo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9eYlj6hQUpTjmYWO1lf/Yhxzwmx2Hj9092MghEwCPMY=;
        b=Z+3KnEZNM93Nb4T4ZwmXUGE0KrEtmHwirh9+2eBDlQYsRop5K5CYgXOtrimR36+8Ba
         kFFDN68NwqTEno1KwuE++kIT+ZcTu3W3QWEYPCsnRQjILYdzKlEhDj9P6mRsWsxeaCu1
         2U1mrQJ8yyDb9OCcfLzOnvlInQtkZG0cZMwHJVSxl7zBMpphaoTPEzXwItjZXTyZUoHy
         HMdIdVR6flwFeO/5awF62elxjJ4o5bWTElkn7ndKMS6Ib/BnOyTnL0uKQuosqdNK2B0/
         bSGkfZEVoHxSqilyPb5dqkSwkLVqNnuMfk8OVH9PYED3r/iZqeq+JKQskRMeb5Ko/4Xk
         k4Gw==
X-Gm-Message-State: AOAM533qhEN6F4X2g15Bev4bcOy9bUMe6u9PrVu9tOhDRTPATVH8vxQv
        OrIsbwGCwzJipPAeJBNzGWhLsblsC1LySiz3uug4Aw==
X-Google-Smtp-Source: ABdhPJy8GtLDrHlH0v3PR/949do7x9zOWryAYOiJbgogM3Cjnalj5B4JdLINRgvBhedGwy0yOkpXK2Ta8I3Lp10s/Xk=
X-Received: by 2002:a05:6102:2327:: with SMTP id b7mr849901vsa.47.1613118028682;
 Fri, 12 Feb 2021 00:20:28 -0800 (PST)
MIME-Version: 1.0
References: <20210212044405.4120619-1-drinkcat@chromium.org>
 <20210212124354.1.I7084a6235fbcc522b674a6b1db64e4aff8170485@changeid> <YCYybUg4d3+Oij4N@kroah.com>
In-Reply-To: <YCYybUg4d3+Oij4N@kroah.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Fri, 12 Feb 2021 16:20:17 +0800
Message-ID: <CANMq1KBuPaU5UtRR8qTgdf+J3pt-xAQq69kCVBdaYGx8F+WmFA@mail.gmail.com>
Subject: Re: [PATCH 1/6] fs: Add flag to file_system_type to indicate content
 is generated
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "Darrick J . Wong" <djwong@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Ian Lance Taylor <iant@google.com>,
        Luis Lozano <llozano@chromium.org>,
        Dave Chinner <david@fromorbit.com>,
        linux-fsdevel@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 12, 2021 at 3:46 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Fri, Feb 12, 2021 at 12:44:00PM +0800, Nicolas Boichat wrote:
> > Filesystems such as procfs and sysfs generate their content at
> > runtime. This implies the file sizes do not usually match the
> > amount of data that can be read from the file, and that seeking
> > may not work as intended.
> >
> > This will be useful to disallow copy_file_range with input files
> > from such filesystems.
> >
> > Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> > ---
> > I first thought of adding a new field to struct file_operations,
> > but that doesn't quite scale as every single file creation
> > operation would need to be modified.
>
> Even so, you missed a load of filesystems in the kernel with this patch
> series, what makes the ones you did mark here different from the
> "internal" filesystems that you did not?

Which ones did I miss? (apart from configfs, see the conversation on
patch 6/6). Anyway, hopefully auditing all filesystems is an order of
magnitude easier task, and easier to maintain in the longer run ,-)

> This feels wrong, why is userspace suddenly breaking?  What changed in
> the kernel that caused this?  Procfs has been around for a _very_ long
> time :)

Some of this is covered in the cover letter 0/6. To expand a bit:
copy_file_range has only supported cross-filesystem copies since 5.3
[1], before that the kernel would return EXDEV and userspace
application would fall back to a read/write based copy. After 5.3,
copy_file_range copies no data as it thinks the input file is empty.

[1] I think it makes little sense to try to use copy_file_range
between 2 files in /proc, but technically, I think that has been
broken since copy_file_range fallback to do_splice_direct was
introduced (eac70053a141 ("vfs: Add vfs_copy_file_range() support for
pagecache copies", ~4.4).

>
> thanks,
>
> greg k-h
