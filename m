Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F06748F04C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2019 18:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730586AbfHOQSe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Aug 2019 12:18:34 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39995 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728979AbfHOQSd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Aug 2019 12:18:33 -0400
Received: by mail-lf1-f67.google.com with SMTP id b17so2014240lff.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Aug 2019 09:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9Io8f1bPaeNDioMtOu6b9FaHz1PaQCP05A6nz5CudSE=;
        b=GdUTEFZxtX4Lqzwngdfr2kBTyvwT41GJPNn6kb81iJMXzazObo52enBgWkwrOOq3lr
         fcNdZi8U6UPgNqNDEBWhKZKeMiP71ad8QufdLOLqaXmVo1Qm1ZJcKLGCfWYtcR0rwDEt
         373s5sBtHdFaBBHWllHqZ5/T8eYXJ/Nx4+edw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9Io8f1bPaeNDioMtOu6b9FaHz1PaQCP05A6nz5CudSE=;
        b=t85+CxJflideaN6K7Z70X7JHmGJpRWKVn6bFfDdLlPsoAC1gtg7559grlsLNTZhvh4
         PJuIi/zUFwgqlI7Oa10AiASmEUFx8gKPtxRMilQ6BpufZpSsrEAdcBibmA2cfv6AYP8e
         dw+cLnjyG8+U8wZMttF7fXm2g6gDybnhd34ZlVwcPxINxp+GBgVrFhC1pyB2xUEZlgGQ
         3goIlt5GGFEtYvgS579PATpnEffwmvVwAOUbEo3K1dHoNIvcgRUuMMYWV6IFQ8t2xdDS
         +3w4iQ87GgqoVMXYaKg09HiZLD/cNLE9wGp4y3i/4gwTtFHQNjSLQD48pon0/aJ9ZuCs
         6GTQ==
X-Gm-Message-State: APjAAAXisS2kR0jVIPPP5K75W95ygo/V759mFXgnYThMbvCvX7j9JbZO
        i+SV8xi6WR6ZNY+5/1/H4sbQtvYRBDI=
X-Google-Smtp-Source: APXvYqyc0Q5XSEOCQnL2cw7uUcMBE9YxJ8bl5wezGs2mns2ZqsqfNY45EYpvrB7nlPTqZjTWjpP0yA==
X-Received: by 2002:ac2:59dd:: with SMTP id x29mr2793978lfn.140.1565885911066;
        Thu, 15 Aug 2019 09:18:31 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id r8sm509045lfc.39.2019.08.15.09.18.28
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Aug 2019 09:18:29 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id h15so2705763ljg.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Aug 2019 09:18:28 -0700 (PDT)
X-Received: by 2002:a2e:9192:: with SMTP id f18mr3104005ljg.52.1565885908392;
 Thu, 15 Aug 2019 09:18:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190815044155.88483-1-gaoxiang25@huawei.com> <20190815090603.GD4938@kroah.com>
In-Reply-To: <20190815090603.GD4938@kroah.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 15 Aug 2019 09:18:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjKz7JLd=mj0w2LUiWC2_VOeNWhTTrw1j-i-KyEHH5g5w@mail.gmail.com>
Message-ID: <CAHk-=wjKz7JLd=mj0w2LUiWC2_VOeNWhTTrw1j-i-KyEHH5g5w@mail.gmail.com>
Subject: Re: [PATCH v8 00/24] erofs: promote erofs from staging v8
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Gao Xiang <gaoxiang25@huawei.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        devel@driverdev.osuosl.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-erofs@lists.ozlabs.org, Chao Yu <yuchao0@huawei.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Pavel Machek <pavel@denx.de>, Jan Kara <jack@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>,
        Dave Chinner <david@fromorbit.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Li Guifu <bluce.liguifu@huawei.com>,
        David Sterba <dsterba@suse.cz>,
        Christoph Hellwig <hch@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Miao Xie <miaoxie@huawei.com>, Fang Wei <fangwei1@huawei.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 15, 2019 at 2:06 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> I know everyone is busy, but given the length this has been in staging,
> and the constant good progress toward cleaning it all up that has been
> happening, I want to get this moved out of staging soon.

Since it doesn't touch anything outside of its own filesystem, I have
no real objections. We've never had huge problems with odd
filesystems.

I read through the patches to look for syntactic stuff (ie very much
*not* looking at actual code working or not), and had only one
comment. It's not critical, but it would be nice to do as part of (or
before) the "get it out of staging".

                 Linus
