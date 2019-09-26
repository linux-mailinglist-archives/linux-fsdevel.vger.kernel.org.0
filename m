Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6221BEC5C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2019 09:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727925AbfIZHLh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Sep 2019 03:11:37 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:40088 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727480AbfIZHLh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Sep 2019 03:11:37 -0400
Received: by mail-io1-f68.google.com with SMTP id h144so3775510iof.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Sep 2019 00:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wrW78ZSW28i5FPT31mVcLqD3R9DCnDawZGQVuCnl/Ko=;
        b=ozUpDbnLDxrpRdx1CmggMSml/rOipDfaa3BFcrI9NU6ExMSmasJrL6UYxMRPrQGQIC
         PrCSpbNko1c/hhGh+XID8hcglgCx91Q3mVGPXFRs598TfEFLv7SzFz9Fl2CrgqRluND5
         n9C2gEvV5Ctv196vXR7OHbfOYIOS/5PJE+j5Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wrW78ZSW28i5FPT31mVcLqD3R9DCnDawZGQVuCnl/Ko=;
        b=b15XpdnndXdDxUbIqKu/tTzChs/gD6l4pseIt6k3d1HBrsUxaJWRHFeytStzq7To9A
         IepDxYj+mbHFxzrJLkuplUUds6H2D+8vDbnOKgI+9iZSFBq2887b7ywny0PmpxAyILWg
         V1AvKykqi9ZkBvtLo5dplma6HqFuNVVmgUiflbkrk/eltSDQjUle9gy+Zuai9Zo7lP+R
         pnFpUT6Ng00ATsAEbluOdI0qlefWHbSjUCJfK42J8pzHkjohVfWJmdbBOdnW7LnfkiGD
         8IjR5eGGNPkpbE2IKNFvzqhmIrI0/4Dyl5Cv1r5U0mDWS3v92Mofv+c9/jEhFdUsZK3J
         ZMwA==
X-Gm-Message-State: APjAAAVI1XZjDwdeTfXgySOQAJcSdNpQLID7zxATehJ/nfTXx7wlqiAl
        J8vte7jjRbadJSkY137CTjBpHcJG891SHBknE6eE2Q==
X-Google-Smtp-Source: APXvYqwyL//slPElyNLoTyf6Crf0jlD9xtNgNM6rPhjhQeBHM6MYYMENZD5jmVPOupogJ5U7HOqe5diLqbOltTDxMbc=
X-Received: by 2002:a02:6a22:: with SMTP id l34mr2434122jac.33.1569481896411;
 Thu, 26 Sep 2019 00:11:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190926020725.19601-1-boazh@netapp.com>
In-Reply-To: <20190926020725.19601-1-boazh@netapp.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 26 Sep 2019 09:11:25 +0200
Message-ID: <CAJfpeguWh5HYcYsgjZ0J2UWUnw88jCURWSpxEjCT2ayubB9Z3A@mail.gmail.com>
Subject: Re: [PATCHSET v02 00/16] zuf: ZUFS Zero-copy User-mode FileSystem
To:     Boaz Harrosh <boaz@plexistor.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matt Benjamin <mbenjami@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Sagi Manole <sagim@netapp.com>,
        Matthew Wilcox <willy@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 26, 2019 at 4:08 AM Boaz Harrosh <boaz@plexistor.com> wrote:

> Performance:
> A simple fio direct 4k random write test with incrementing number
> of threads.
>
> [fuse]
> threads wr_iops wr_bw   wr_lat
> 1       33606   134424  26.53226
> 2       57056   228224  30.38476
> 4       88667   354668  40.12783
> 7       116561  466245  53.98572
> 8       129134  516539  55.6134
>
> [fuse-splice]
> threads wr_iops wr_bw   wr_lat
> 1       39670   158682  21.8399
> 2       51100   204400  34.63294
> 4       75220   300882  47.42344
> 7       97706   390825  63.04435
> 8       98034   392137  73.24263
>
> [xfs-dax]
> threads wr_iops wr_bw           wr_lat

Data missing.

> [Maxdata-1.5-zufs]
> threads wr_iops wr_bw           wr_lat
> 1       1041802 260,450         3.623
> 2       1983997 495,999         3.808
> 4       3829456 957,364         3.959
> 7       4501154 1,125,288       5.895330
> 8       4400698 1,100,174       6.922174

Just a heads up, that I have achieved similar results with a prototype
using the unmodified fuse protocol.  This prototype was built with
ideas taken from zufs (percpu/lockless, mmaped dev, single syscall per
op).  I found a big scheduler scalability bottleneck that is caused by
update of mm->cpu_bitmap at context switch.   This can be worked
around by using shared memory instead of shared page tables, which is
a bit of a pain, but it does prove the point.  Thought about fixing
the cpu_bitmap cacheline pingpong, but didn't really get anywhere.

Are you interested in comparing zufs with the scalable fuse prototype?
 If so, I'll push the code into a public repo with some instructions,

Thanks,
Miklos
