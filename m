Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB17149D4C9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jan 2022 23:03:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232435AbiAZWDt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jan 2022 17:03:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiAZWDt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jan 2022 17:03:49 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A42AEC06161C
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jan 2022 14:03:48 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id p15so1486309ejc.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jan 2022 14:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mariadb.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IRD+niqrZ3xVTX78uCR4o5Ijk5/k662RHKPUdS9ua30=;
        b=qQg9FLjGnghn1JltU0Y2WjzXTg3qu0L9l0qR9IpZHKXUdJ4Vx1on+QC+uhk3t9nXTa
         An3mfWWFzq/TVBBDrReXgk7742sYTkG4VhTVDv/Ogtl3noUxOxcI0d/nu0v5JpNwhuHo
         VGO5MKcqo4J1HlD3mxurrKYFoRI+RSFSNsX8NlJVaNREGQ0GYvT8hJANsXcal6P/Gnql
         uZaM5vT/wSdOlDlc3HhgY0Zo3UGJT2wty2ILibvdsowcoT50sbq3sbqgmvkwCK+O2Jgz
         iDsmvfZJfdRPDkPJb9QKY7ibF1xHo/Sl2trTHwjHEFXWbV1cWfusrhd3YhKa+TdHvtp4
         dJtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IRD+niqrZ3xVTX78uCR4o5Ijk5/k662RHKPUdS9ua30=;
        b=yLlJParz+IN8pZMpmaVhGTdvILbsDHDKm1Q3mAXt8+sQMvXSN+TTyp++sLbmksM2gk
         KotqWaeHJA4wsSJMIymsGh4il5UzqfIhljkfQn5ZtS1Nt3nMW7oYa9VBR6d8WxlK/+Y1
         dU6dy8K2rqn1Ejemgp66f7W5a3Zh3n8oFY2UywegmDZ6GIzGEEH9ja1EXt1pNRNjM+P6
         g/4tPzyJmmqmYfm8mFvBsNp3UXbpE/FERjh3SoZXZ2tClZdv8SOE5PM9TwuADA7H+UHr
         vHP5dt+9VEFXa+xYPh0LoBIAxb76KWdi6onEnZYd3LWr8fq7aR4khjjymvMVaGFKXMy0
         sTZA==
X-Gm-Message-State: AOAM530QHEILl+cD7inn+qjoZEAhReYkQvHm9FG1/fHfGfuffZ+tXlX1
        sw5F9oaGDzgDDjYgiHj9trQQdepT1qGtXIxwhk9s/nQWYkWjag==
X-Google-Smtp-Source: ABdhPJyTyliirNhQ1P4NbwZKwhkzq28jUv9ohMebP71pN4pdwUOOjHBctIT+GHBGiwwUGDKOvDRMLO9uIVMmgUwgxlA=
X-Received: by 2002:a17:906:4dd7:: with SMTP id f23mr571552ejw.385.1643234627098;
 Wed, 26 Jan 2022 14:03:47 -0800 (PST)
MIME-Version: 1.0
References: <CABVffEPxKp4o_-Bz=JzvEvQNSuOBaUmjcSU4wPB3gSzqmApLOw@mail.gmail.com>
 <YfC5vuwQyxoMfWLP@casper.infradead.org>
In-Reply-To: <YfC5vuwQyxoMfWLP@casper.infradead.org>
From:   Daniel Black <daniel@mariadb.org>
Date:   Thu, 27 Jan 2022 09:03:36 +1100
Message-ID: <CABVffEPReS0d1dN2eKCry_k6K0LCGNNjGf04O3c7-h6P1Q_9zg@mail.gmail.com>
Subject: Re: fcntl(fd, F_SETFL, O_DIRECT) succeeds followed by EINVAL in write
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 26, 2022 at 2:02 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Wed, Jan 26, 2022 at 09:05:48AM +1100, Daniel Black wrote:
>
> O_RDONLY is defined to be 0, so don't worry about it.

Thanks.

> > The kernel code in setfl seems to want to return EINVAL for
> > filesystems without a direct_IO structure member assigned,
> >
> > A noop_direct_IO seems to be used frequently to just return EINVAL
> > (like cifs_direct_io).
>
> Sorry for the confusion.  You've caught us mid-transition.  Eventually,
> ->direct_IO will be deleted, but for now it signifies whether or not the
> filesystem supports O_DIRECT, even though it's not used (except in some
> scenarios you don't care about).

Is it going to be reasonable to expect fcntl(fd, F_SETFL, O_DIRECT) to
return EINVAL if O_DIRECT isn't supported?

> > Lastly on the list of peculiar behaviors here, is tmpfs will return
> > EINVAL from the fcntl call however it works fine with O_DIRECT
> > (https://bugs.mysql.com/bug.php?id=26662). MySQL (and MariaDB still
> > has the same code) that currently ignores EINVAL, but I'm willing to
> > make that code better.
>
> Out of interest, what behaviour do you _want_ from doing O_DIRECT
> to tmpfs?  O_DIRECT is defined to bypass the page cache, but tmpfs
> only stores data in the page cache.  So what do you intend to happen?

It occurs to me because EINVAL is returned, it's just operating in
non-O_DIRECT mode.

It occurs to me that someone probably added this because (too much)
MySQL/MariaDB
testing is done on tmpfs and someone didn't want to adjust the test
suite to handle
failures everywhere on O_DIRECT. I don't think there was any kernel
expectation there.

My problem it seems, I'll see what I can do to get back to using real
filesystems more.

> > Does a userspace have to fully try to write to an O_DIRECT file, note
> > the failure, reopen or clear O_DIRECT, and resubmit to use O_DIRECT?
> >
> > While I see that the success/failure of a O_DIRECT read/write can be
> > related to the capabilities of the underlying block device depending
> > on offset/length of the read/write, are there other traps?
>
> It also must be aligned in memory,

yep, knew this one.

> but I'm not quite sure what
> limitations cifs imposes.
