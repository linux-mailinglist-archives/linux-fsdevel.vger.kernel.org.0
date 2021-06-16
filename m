Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBE123A90EB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jun 2021 07:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbhFPFCH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Jun 2021 01:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbhFPFCG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Jun 2021 01:02:06 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409E6C061574;
        Tue, 15 Jun 2021 22:00:01 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id x22-20020a4a62160000b0290245cf6b7feeso360100ooc.13;
        Tue, 15 Jun 2021 22:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=kxG0wff3pxHDvDEpl2rYGsFcElm3KSrIiYBGYygsjJ4=;
        b=rriQ6zwslKWerUuIgInYVIN1VCiCmYFXWgbBwnLWCCcUQcQh2/CJRUfuxvJiUeF7e4
         Ny9NCTq9G1KhxFFyFK3LiLWmQyPp5qKtSgT1uAZrUx7eblFmwRorByV7+O8h2NmhRV8H
         /GbhsQ3PC+aIWyPy7HO76zVoJ+uQlpiD26W/jDwaNCQwssqPLJgZZX89jCv6XZ9CisRt
         //nPxULrFlAnGy+vUT9hEc/98ZW4ivT0oE6poVeNO1lWJxGNNQsKoTPk2VJTBXUc0+vq
         umNJ8fMEkTazUvEYQI4oa2TM3AdHtC/Ra0LTeZ5o6ZwCR+Kn3e9hcuXo6x+zyLXutcue
         GCwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=kxG0wff3pxHDvDEpl2rYGsFcElm3KSrIiYBGYygsjJ4=;
        b=lH7Ujwcgx0VSHr1cJeOoOeToTENgH/q4IEJfQXclXThS7SlUBOzZSpYLcjp9HJPcSB
         3MB3nbvVT0SjqG+fMDVHAaKiCQPLZqwyJjT3q8kZ1T1vcX423ZkIhBuaU5hnBHkAyE/n
         mkViLG12HGey0Re7zs45leTkFavxs4Z7WrAXAgOnIBVBIRbwGgb3u4XCmWsC/o7RpTQs
         KAMzUjV5jkWH6+TDIxw/l9/LHBE5OXig1UBuuFOGjt2i8qg3nzSuy7ZvTguGC5sT4hL7
         CATMM0gAXS/ZJWbZOEEJtDEkmeRfJ9PNgbhT8b3zS52ciijIKQApjcVeHC4e1bgStkFy
         JdAA==
X-Gm-Message-State: AOAM530Ucdb+FUYx74ETVYP/jBRS1hnAtW3T3mggICR5CxoZ2MrOGmPa
        vAYoTen92tTsDZnbyQ34nsJX6i02U1yD5B2HwJROU+8zIut+Qw==
X-Google-Smtp-Source: ABdhPJzplQZ6R5qV+zXXntRt8v1aYX7BZxu3dBR/fiQh//oFnWsT7SaTNv6Y6zw8IoqUCINleNmpIOcbnssmJ6qwsJg=
X-Received: by 2002:a4a:8802:: with SMTP id d2mr2251248ooi.28.1623819600282;
 Tue, 15 Jun 2021 22:00:00 -0700 (PDT)
MIME-Version: 1.0
From:   Gregory Szorc <gregory.szorc@gmail.com>
Date:   Tue, 15 Jun 2021 21:59:49 -0700
Message-ID: <CAKQoGa=6OZnqRNDsGpyY47S4SgrFCnGRTXAMgZ61axM58AWrEA@mail.gmail.com>
Subject: Observability of filesystem syncing and device flushing
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

One thing I've learned from optimizing I/O performance of userland
applications is that a surprising number of applications are
effectively "fsync() benchmarks." What I mean by that is many
applications call fsync() - and similar functionality incurring a
flush to non-volatile storage - surprisingly often and that overall
I/O performance is effectively bottlenecked by how quickly the
underlying storage device can process repeated flushes.

You can easily confirm the validity of this statement by running
sync/flush heavy software (like pretty much any database software)
with eatmydata [1], an LD_PRELOAD library / utility that effectively
short-circuits libc functions like fsync(), fdatasync(), and msync()
so they no-op instead of triggering a sync/flush [via a syscall].

The kernel exposes various statistics about block devices,
filesystems, the page cache, etc via procfs. However, as far as I can
tell there are no direct or very limited statistics on sync/flush
operations. I've often wanted to capture/view system/kernel-level
activity for these sync/flush operations because they are often strong
contributors to I/O bottlenecks and it can be extremely useful to
correlate these operations against other metrics.

I've long considered sending kernel patches to add procfs
observability for sync/flushing activity so common system monitoring
tools can easily consume those metrics. I'm emailing linux-block@ and
linux-fsdevel@ to a) try to assess whether these patches would be
well-received b) gain feedback on the appropriate activity to track
(I'm not a kernel expert).

I think a reasonable response is "you can already observe this
activity via syscall tracing and using tools like systemtap, so no
additional procfs counters are needed." I'd counter by saying, yes,
you can get some valuable information this way. But I believe there
are some large holes, such as limited visibility into block layer
activity outside of debugfs and when kernel subsystems (such as
background flusher threads) incur work independently of an observable
syscall.

Do others feel there is an observability gap in the kernel around
filesystem syncing and storage flushing? If so, how would you
recommend improving matters?

Gregory

[1] https://www.flamingspork.com/projects/libeatmydata/
