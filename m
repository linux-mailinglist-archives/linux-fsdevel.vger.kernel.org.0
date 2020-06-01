Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 505B51E9EFE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jun 2020 09:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbgFAHWO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Jun 2020 03:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbgFAHWN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Jun 2020 03:22:13 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A38A0C061A0E;
        Mon,  1 Jun 2020 00:22:13 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id o2so2163836vsr.0;
        Mon, 01 Jun 2020 00:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LIgRN0QDBu4gnSn3TisqfMx5xMC/fpgZPP0eL7TYZo4=;
        b=Qy+GRsFwP59gROSPpwcSk+d4BmBdCEdjxVcnG89ETwVbaChC3CZGqNCjYA5q3zZEXV
         ftJjSX22++JyxqShjPrcs60ExBRV9rkg0po2DVvCYUGUQ+/Lln9ssEhgcKVqibq5h1QD
         3GcB+VR5pmjymE7fc4kCi6UuBXGedcxGeKYY0JahfpNnaRtzua+jlXVyuPKz5eq95nyx
         FH5rsmTOlXiADyitE7Yo9XplyqzAHQ1AspJB0cypzPPGDXANPkzbpULgcPelQMQlpYkn
         q2rtZDeeH2pm1YHT1QiK+n+u+A7jM83OUkEtSD+uInIdVHUsPiVFys6kxdjnMNKzkX37
         ++ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LIgRN0QDBu4gnSn3TisqfMx5xMC/fpgZPP0eL7TYZo4=;
        b=ek40dg9u6PY9p5yDFRjTOxpa6vDqCZFAN+FfzvCrm0BqPTd8VLD5yuw0tshuQgRzXL
         Z9Zws+lkEhm7OSHbOH1YyDg5gyzfmRRPOQ2d7Ijqb1fVekg6cdgo49j2aic5hGA+62zV
         YQOyIBm/HEPfJnbvnjCptoCEkZovXN7hWirJ9cwG5kJGOXeafaIhXuJy7dttDnThPQIJ
         OroiIQta9PqAexB/3Tsu1215a63tRdEdyInhO8GikbPLxN7hONQkHtTqXWOgkk9Ww1KW
         BCvvayr0MDm8B0lQpy20gRC7IDoUYEh6nFEqhvPxkH1aUcBOqaimPE2XStSxibQ3r2Y1
         Dekw==
X-Gm-Message-State: AOAM532eokaXmWqinM7c1K+1NwdseA2DRieP8YIj9LuyocXpOsMz8XyP
        Bmsx0ia+CepbDFkTqEKhKPn0mz5O04BjZnP1gxc=
X-Google-Smtp-Source: ABdhPJzIA1FGKrVz+9UgvnCvE4qHbM8WwKnt0yzT0Ej9MwEf3XXL3bZ9GG5bYf4/kar44nR6s2ZBVVKbKsVOWbpBIWw=
X-Received: by 2002:a05:6102:a17:: with SMTP id t23mr9115865vsa.62.1590996132886;
 Mon, 01 Jun 2020 00:22:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200529141100.37519-1-pilgrimtao@gmail.com> <c8412d98-0328-0976-e5f9-5beddc148a35@kernel.dk>
In-Reply-To: <c8412d98-0328-0976-e5f9-5beddc148a35@kernel.dk>
From:   Tao pilgrim <pilgrimtao@gmail.com>
Date:   Mon, 1 Jun 2020 15:22:01 +0800
Message-ID: <CAAWJmAZOQQQeNiTr48OSRRdO2pG+q4c=6gjT55CkWC5FN=HXmA@mail.gmail.com>
Subject: Re: [PATCH v2] blkdev: Replace blksize_bits() with ilog2()
To:     Jens Axboe <axboe@kernel.dk>
Cc:     hch@lst.de, sth@linux.ibm.com, viro@zeniv.linux.org.uk, clm@fb.com,
        jaegeuk@kernel.org, hch@infradead.org,
        Mark Fasheh <mark@fasheh.com>, dhowells@redhat.com,
        balbi@kernel.org, damien.lemoal@wdc.com, bvanassche@acm.org,
        ming.lei@redhat.com, martin.petersen@oracle.com, satyat@google.com,
        chaitanya.kulkarni@wdc.com, houtao1@huawei.com,
        asml.silence@gmail.com, ajay.joshi@wdc.com,
        linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>, hoeppner@linux.ibm.com,
        heiko.carstens@de.ibm.com, gor@linux.ibm.com,
        borntraeger@de.ibm.com, linux-s390@vger.kernel.org,
        sagi@grimberg.me, linux-nvme@lists.infradead.org,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        Josef Bacik <josef@toxicpanda.com>, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, chao@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, darrick.wong@oracle.com,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
        ocfs2-devel@oss.oracle.com, deepa.kernel@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 29, 2020 at 10:13 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 5/29/20 8:11 AM, Kaitao Cheng wrote:
> > There is a function named ilog2() exist which can replace blksize.
> > The generated code will be shorter and more efficient on some
> > architecture, such as arm64. And ilog2() can be optimized according
> > to different architecture.
>
> When you posted this last time, I said:
>
> "I like the simplification, but do you have any results to back up
>  that claim? Is the generated code shorter? Runs faster?"
>

Hi  Jens Axboe:

I did a test on ARM64.
unsigned int ckt_blksize(int size)
{
   return blksize_bits(size);
}
unsigned int ckt_ilog2(int size)
{
    return ilog2(size);
}

When I compiled it into assembly code, I got the following result,

0000000000000088 <ckt_blksize>:
      88: 2a0003e8 mov w8, w0
      8c: 321d03e0 orr w0, wzr, #0x8
      90: 11000400 add w0, w0, #0x1
      94: 7108051f cmp w8, #0x201
      98: 53017d08 lsr w8, w8, #1
      9c: 54ffffa8 b.hi 90 <ckt_blksize+0x8>
      a0: d65f03c0 ret
      a4: d503201f nop

00000000000000a8 <ckt_ilog2>:
      a8: 320013e8 orr w8, wzr, #0x1f
      ac: 5ac01009 clz w9, w0
      b0: 4b090108 sub w8, w8, w9
      b4: 7100001f cmp w0, #0x0
      b8: 5a9f1100 csinv w0, w8, wzr, ne
      bc: d65f03c0 ret

The generated code of ilog2  is shorter , and  runs faster


> which you handily ignored, yet sending out a new version. I'm not
> going to apply this without justification, your commit message is
> handwavy at best.
>

Do I need to write the test content into commit message?



-- 
Yours,
Kaitao Cheng
