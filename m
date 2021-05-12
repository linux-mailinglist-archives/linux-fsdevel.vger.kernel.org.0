Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF73437B8AD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 May 2021 10:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbhELIzc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 May 2021 04:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbhELIzc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 May 2021 04:55:32 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4092C061574;
        Wed, 12 May 2021 01:54:22 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id x2so32595537lff.10;
        Wed, 12 May 2021 01:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D9JdGULdbtUgDnObe3xdIqfl7fZ3OmRo5qKT1ikKmgg=;
        b=tju9u6XKbpkjmKetjX6NCf0If+B/JClJNluX2MMjZzAZ72cqFi9Bbssx4pYjN8En9h
         7MgBIhQNXX71jyUR5ggbR8DxCKLQePlP8Z8N1wE/MjpJUJPDPkbDJm139Yx+tU+3AGkB
         VkA+6N+4kz2zeF0WOpEAOBMKQeTUECniVfBh6vE+A3NoAqikKGQFD+88rLS4iGOn6/78
         l00SEVA6lXB8FDsj4JXOhugydgIPwBTeC5u1hINBD3y2re7Fju0BzrAgLdjOqfFjsVJM
         qlJlnKBPtZvkwPU7gP3YcUbBvpi/Flk5oVMAQw6s6LJiKdZYfDl4WK+T1Hk7IC+G3bVu
         cZ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D9JdGULdbtUgDnObe3xdIqfl7fZ3OmRo5qKT1ikKmgg=;
        b=RYLA6x3kruV2OiB7C76tY1ksO2cmsD9YniShTJGS4j9ABEkSXBTa02n3kmMhWNvIkd
         jIqYaBdCDyI4n2CpTzFuQX9+HQXmU8UN9Wpsn7qeba1Y5lmBqD2oxFRHAHE4S/1+tBy1
         k53wVUNN2oG+RJmLQJ9dq1YHUPqsSRcYwwsJ8ZpZMlVgSOX6YB1LKmI2pWXWYiR3UCzk
         7qsMksLs5HgwMno4K9sGyC4BsfcML+3r2be9jRIu4Ts7YyGn6Y5gjLtP4HRwY1AmIjH1
         ZoBPqNwCuPeh2qOYMw9mKZw2iMHD1jmxNMCBnjffi3OSNMvNixTOoV/1clha3RSh+sg7
         UhSA==
X-Gm-Message-State: AOAM531AfXqfo5Juw67bmDaI1PYjXBS621GKZ3SsXlvSzhINdv3nVp0g
        mRDZunTxvavwkmcS8JVxX56FK1wbRopQqlf18/A=
X-Google-Smtp-Source: ABdhPJyhl/L76ssfFM9z3stujaS23tmJvJXgG7KUeVeTjTXXw6HAQx4fUZChmaajLcFG/fPMvv50D182DxsgdnwAsCA=
X-Received: by 2002:a05:6512:3481:: with SMTP id v1mr9701751lfr.376.1620809661318;
 Wed, 12 May 2021 01:54:21 -0700 (PDT)
MIME-Version: 1.0
References: <162077975380.14498.11347675368470436331.stgit@web.messagingengine.com>
 <YJtz6mmgPIwEQNgD@kroah.com> <CAC2o3D+28g67vbNOaVxuF0OfE0RjFGHVwAcA_3t1AAS_b_EnPg@mail.gmail.com>
 <CAC2o3DJm0ugq60c8mBafjd81nPmhpBKBT5cCKWvc4rYT0dDgGg@mail.gmail.com>
In-Reply-To: <CAC2o3DJm0ugq60c8mBafjd81nPmhpBKBT5cCKWvc4rYT0dDgGg@mail.gmail.com>
From:   Fox Chen <foxhlchen@gmail.com>
Date:   Wed, 12 May 2021 16:54:07 +0800
Message-ID: <CAC2o3DJdwr0aqT6LwhuRj8kyXt6NAPex2nG5ToadUTJ3Jqr_4w@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] kernfs: proposed locking and concurrency improvement
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ian Kent <raven@themaw.net>
Cc:     Tejun Heo <tj@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
        Eric Sandeen <sandeen@sandeen.net>,
        Brice Goglin <brice.goglin@gmail.com>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 12, 2021 at 4:47 PM Fox Chen <foxhlchen@gmail.com> wrote:
>
> Hi,
>
> I ran it on my benchmark (https://github.com/foxhlchen/sysfs_benchmark).
>
> machine: aws c5 (Intel Xeon with 96 logical cores)
> kernel: v5.12
> benchmark: create 96 threads and bind them to each core then run
> open+read+close on a sysfs file simultaneously for 1000 times.
> result:
> Without the patchset, an open+read+close operation takes 550-570 us,
> perf shows significant time(>40%) spending on mutex_lock.
> After applying it, it takes 410-440 us for that operation and perf
> shows only ~4% time on mutex_lock.
>
> It's weird, I don't see a huge performance boost compared to v2, even

I meant I don't see a huge performance boost here and it's way worse than v2.
IIRC, for v2 fastest one only takes 40us


> though there is no mutex problem from the perf report.
> I've put console outputs and perf reports on the attachment for your reference.
>
>
> thanks,
> fox

fox
