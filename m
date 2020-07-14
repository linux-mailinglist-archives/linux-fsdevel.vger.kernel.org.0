Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C64921EFDB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jul 2020 13:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbgGNL4I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jul 2020 07:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727839AbgGNL4D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jul 2020 07:56:03 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24396C08C5DD
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2020 04:56:03 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id dg28so16747935edb.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2020 04:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+sjMIjM2/JFepdRAXpOHb7ghC5LhQeVZQ0Kayo5azeY=;
        b=BWruN3AFlA46ZLoJRaXr2SIqdS24ok0rzjPKi9syKMhMKh0JxzioNs8EdhKj+fmaW8
         LtFlAX3lpklg05W9WQ2EZYCE821vzWc7x2++w2jVILwn2boWbSBMsrC6/5ApTmFgISg3
         lazdTrnPmPdLzow7yla7Nzl2D4pVlMvE8cJJk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+sjMIjM2/JFepdRAXpOHb7ghC5LhQeVZQ0Kayo5azeY=;
        b=qDfC3bqZIIUMua7sw4uQ4NjV+vObUkkYNdkyO8oNzXeUjSWMIBDesBzRkZ8HB7vA/n
         bWkBXVTMup0UE+hMa1kNds9FxZv7EVzNctwmQ4egf3vYRoukMsspcGiYZ4BkbrVsjurk
         AG+cZ7s9jtcJI6+0vgnXHQJ0tINRuKd6I5J4RqPNiyc49+gntqm85QRHZL5Rupv3Syyl
         9nFq76aICTs4JDEcKf/Rcz44fqeDzG1gLL/aLoVS6bQaUpA35NY2uD6ILqrt5kekvebc
         aEnIy+aajyHT+3Y2B5NjEuzKnqni/9V+d1PtH6kVsyln3fIRFHCa/8NMFmS/Sl2Gw8QS
         YbUQ==
X-Gm-Message-State: AOAM531XGqUflPComxXYwuB1LS/Z5zRXas+9EdrAOd6kJViifseZuHmj
        fe/6ntg/LRZ+2CxW7KZ0Uxz1NhR0KQsMGjUK6wYNZA==
X-Google-Smtp-Source: ABdhPJx7T4CbUMQ5B2n8Maq8US8S/XJNlgydPVNLLLOLr6IH9mheDQ+RV1Tk59Uievz5SqNyI1kTrxdL9hey9Cb11rE=
X-Received: by 2002:a05:6402:1d0b:: with SMTP id dg11mr3988736edb.212.1594727761659;
 Tue, 14 Jul 2020 04:56:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAODFU0q6CrUB_LkSdrbp5TQ4Jm6Sw=ZepZwD-B7-aFudsOvsig@mail.gmail.com>
 <20200705115021.GA1227929@kroah.com> <20200714065110.GA8047@amd>
 <CAJfpegu8AXZWQh3W39PriqxVna+t3D2pz23t_4xEVxGcNf1AUA@mail.gmail.com> <4e92b851-ce9a-e2f6-3f9a-a4d47219d320@gmail.com>
In-Reply-To: <4e92b851-ce9a-e2f6-3f9a-a4d47219d320@gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 14 Jul 2020 13:55:50 +0200
Message-ID: <CAJfpegvroouw5ndHv+395w5PP1c+pUyp=-T8qhhvSnFbhbRehg@mail.gmail.com>
Subject: Re: [PATCH 0/3] readfile(2): a new syscall to make open/read/close faster
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     Pavel Machek <pavel@denx.de>, Greg KH <gregkh@linuxfoundation.org>,
        Jan Ziak <0xe2.0x9a.0x9b@gmail.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-man <linux-man@vger.kernel.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>, shuah@kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>, io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 14, 2020 at 1:36 PM Pavel Begunkov <asml.silence@gmail.com> wrote:
>
> On 14/07/2020 11:07, Miklos Szeredi wrote:
> > On Tue, Jul 14, 2020 at 8:51 AM Pavel Machek <pavel@denx.de> wrote:
> >>
> >> Hi!
> >>
> >>>> At first, I thought that the proposed system call is capable of
> >>>> reading *multiple* small files using a single system call - which
> >>>> would help increase HDD/SSD queue utilization and increase IOPS (I/O
> >>>> operations per second) - but that isn't the case and the proposed
> >>>> system call can read just a single file.
> >>>
> >>> If you want to do this for multple files, use io_ring, that's what it
> >>> was designed for.  I think Jens was going to be adding support for the
> >>> open/read/close pattern to it as well, after some other more pressing
> >>> features/fixes were finished.
> >>
> >> What about... just using io_uring for single file, too? I'm pretty
> >> sure it can be wrapped in a library that is simple to use, avoiding
> >> need for new syscall.
> >
> > Just wondering:  is there a plan to add strace support to io_uring?
> > And I don't just mean the syscalls associated with io_uring, but
> > tracing the ring itself.
>
> What kind of support do you mean? io_uring is asynchronous in nature
> with all intrinsic tracing/debugging/etc. problems of such APIs.
> And there are a lot of handy trace points, are those not enough?
>
> Though, this can be an interesting project to rethink how async
> APIs are worked with.

Yeah, it's an interesting problem.  The uring has the same events, as
far as I understand, that are recorded in a multithreaded strace
output (syscall entry, syscall exit); nothing more is needed.

I do think this needs to be integrated into strace(1), otherwise the
usefulness of that tool (which I think is *very* high) would go down
drastically as io_uring usage goes up.

Thanks,
Miklos
