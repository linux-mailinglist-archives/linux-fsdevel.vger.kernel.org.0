Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FBB841A40
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2019 04:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408328AbfFLCIB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jun 2019 22:08:01 -0400
Received: from mail-lf1-f41.google.com ([209.85.167.41]:45682 "EHLO
        mail-lf1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406597AbfFLCIB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jun 2019 22:08:01 -0400
Received: by mail-lf1-f41.google.com with SMTP id u10so10759555lfm.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Jun 2019 19:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zvcuGBw+4LQao88YFmzPADNOaa+2pmIz1aMFK+ndk6M=;
        b=XcZ9B2oIjVRXTLHyuEPsLajuh6i76LN69nh3G8uioz1IkqIoBNiJmqBx/YkM+zyHPY
         2G4ifYC/e/x616EYdSNIo03kIta8UGvL7gEmyY9zsCOwuEh0KIGgPW6cVGtYZOxKD6oY
         Cr+IJ89IjBKKmulpfediz94KCA9DcxQ3obwPo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zvcuGBw+4LQao88YFmzPADNOaa+2pmIz1aMFK+ndk6M=;
        b=Xo/zbofglN7Si3psjxJqwnsIgn1WxY8mPEyQ2dzNFCjDx9VsYBkjqExy5ywbc5d2Mn
         ftTwOrqHfD56+c3B2ovMekY6n0Z47vfLCXjiGiMlvzrSy7CGmVSUydoMvhI2pm3fm19T
         VGM9SVTp5igi8sW7SMhiQmOjEHZr3tASCQyILWvcnjDe8iEet6ngEsE2gHZhgxDEb3t4
         xi9dfh4oK/eOzV3cdq1lEpmj6gFVajPLz8pKcJ3N0xC20Ob/hAOm8z9JOp+NyAF6ge9o
         ItG9hYnPHuS+x32SQZAu68+1ddoOEEVimTOMVulwUNMgM2Xun6H3B6EBsL8mikJ3jWIT
         bxeQ==
X-Gm-Message-State: APjAAAU/8Wc80TPYazR7LNUtpfgub+zGZ399va+h3pnmo6XriMkAJpI5
        7y6krzFXTleh9Pr9zrVN+0MtvRarEC8=
X-Google-Smtp-Source: APXvYqyQ0uMqFJ0t3CdNLI8UElBpE9FZcCGt95rx21V9/gugzsR2LENv5wnxqLc25QK5LBxf5Nj63Q==
X-Received: by 2002:ac2:5095:: with SMTP id f21mr39552250lfm.155.1560305277827;
        Tue, 11 Jun 2019 19:07:57 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id k4sm1158162ljj.41.2019.06.11.19.07.56
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 19:07:56 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id v24so9254682ljg.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Jun 2019 19:07:56 -0700 (PDT)
X-Received: by 2002:a2e:9c03:: with SMTP id s3mr26468187lji.209.1560305276220;
 Tue, 11 Jun 2019 19:07:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190610191420.27007-1-kent.overstreet@gmail.com>
 <CAHk-=wi0iMHcO5nsYug06fV3-8s8fz7GDQWCuanefEGq6mHH1Q@mail.gmail.com>
 <20190611041045.GA14363@dread.disaster.area> <CAHk-=whDmeozRHUO0qM+2OeGw+=dkcjwGdsvms-x5Dz4y7Tzcw@mail.gmail.com>
 <20190611071038.GC14363@dread.disaster.area>
In-Reply-To: <20190611071038.GC14363@dread.disaster.area>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 11 Jun 2019 16:07:40 -1000
X-Gmail-Original-Message-ID: <CAHk-=wgBdTUvjYXKPr_wAAe_Z-hFgM2KMHcsK+b=3w5yMSJ9zw@mail.gmail.com>
Message-ID: <CAHk-=wgBdTUvjYXKPr_wAAe_Z-hFgM2KMHcsK+b=3w5yMSJ9zw@mail.gmail.com>
Subject: Re: bcachefs status update (it's done cooking; let's get this sucker merged)
To:     Dave Chinner <david@fromorbit.com>
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-bcache@vger.kernel.org, Dave Chinner <dchinner@redhat.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Zach Brown <zach.brown@ni.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Josef Bacik <josef@toxicpanda.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 10, 2019 at 9:11 PM Dave Chinner <david@fromorbit.com> wrote:
>
> The same rwsem issues were seen on the mmap_sem, the shrinker rwsem,
> in a couple of device drivers, and so on. i.e. This isn't an XFS
> issue I'm raising here - I'm raising a concern about the lack of
> validation of core infrastructure and it's suitability for
> functionality extensions.

I haven't actually seen the reports.

That said, I do think this should be improving. The random
architecture-specific code is largely going away, and we'll have a
unified rwsem.

It might obviously cause some pain initially, but I think long-term we
should be much better off, at least avoiding the "on particular
configurations" issue..

              Linus
