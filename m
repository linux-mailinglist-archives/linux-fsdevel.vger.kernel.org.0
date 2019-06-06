Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6359437AE3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2019 19:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730018AbfFFRVc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jun 2019 13:21:32 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37960 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbfFFRVc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jun 2019 13:21:32 -0400
Received: by mail-lf1-f65.google.com with SMTP id b11so744979lfa.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Jun 2019 10:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fSh9JeAYZqEFU07GFlcm4g2RwNfVCw5VkJKLPgvFgpM=;
        b=GXSY8IkFrWa7J8B6PJEPqJ0gkrWF9aF2wuVJ0wQ40ziAUSXofomBUgMg2tSIClx+89
         +trdK2/MhDj4EjpP2yv3Xn8pX3rA48qk6bQhrjbIVV9fY3W5uHsxoW6S3hiV1u6bue1h
         +WQ8hOkagCs/4IfWuZtcPZAZi6BK/PN2CpG1Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fSh9JeAYZqEFU07GFlcm4g2RwNfVCw5VkJKLPgvFgpM=;
        b=ani9nSqQ8H56kE4mNz/WAFTv6ct2kd3/0tvUAT0PUzes44+NhSGRTBUUHRU5lrF+GA
         Od+v3RgmPFpa6uVo+loGBzg8JMcZC8RiwCtqY2IG71Sps65YTZd05IBcYQewpu4a4FvM
         IOqXDFij1UD7mKnMfWXxAt2In5RH2fqFA3pAw7CZkMTKKPaO/2hHdJp0tIg2c6hF2FMe
         oJ8jAoJErCtiPRa68lFxpeuMIBPWeuv2TaDbNB6133MwEyHqUvULJ29tS/j06QVLRHxE
         j52i4FClH1tJOe4poMBiUYkmWCwIJaVfsdTNbqWMBm8jf81AzM0TQvhFYkRQBzjuiS2g
         1F5g==
X-Gm-Message-State: APjAAAUGGlxyHlz66n3XU248/g1NuUEZeVW0d3A8ukZcJt6RqSHR6iGh
        O1iK8375C/y4o2FqfNH/6yRFelzL9YY=
X-Google-Smtp-Source: APXvYqybjCM5OHLHdXaaUzQgiVN/NG3D2Lkqc0b0VCTI8HoG9+kncLEjmNGT2j7EyDOJEwTBMfRq2A==
X-Received: by 2002:a19:5007:: with SMTP id e7mr25970921lfb.76.1559841689487;
        Thu, 06 Jun 2019 10:21:29 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id z83sm448362ljb.73.2019.06.06.10.21.28
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 10:21:28 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id k18so1374190ljc.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Jun 2019 10:21:28 -0700 (PDT)
X-Received: by 2002:a2e:9ad1:: with SMTP id p17mr26100221ljj.147.1559841687851;
 Thu, 06 Jun 2019 10:21:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190606155205.2872-1-ebiggers@kernel.org>
In-Reply-To: <20190606155205.2872-1-ebiggers@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 6 Jun 2019 10:21:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgSzRzoro8ATO5xb6OFxN1A0fjUCQSAHfGuEPbEu+zWvA@mail.gmail.com>
Message-ID: <CAHk-=wgSzRzoro8ATO5xb6OFxN1A0fjUCQSAHfGuEPbEu+zWvA@mail.gmail.com>
Subject: Re: [PATCH v4 00/16] fs-verity: read-only file-based authenticity protection
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-integrity@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Victor Hsieh <victorhsieh@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <darrick.wong@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 6, 2019 at 8:54 AM Eric Biggers <ebiggers@kernel.org> wrote:
>
> This is a redesigned version of the fs-verity patchset, implementing
> Ted's suggestion to build the Merkle tree in the kernel
> (https://lore.kernel.org/linux-fsdevel/20190207031101.GA7387@mit.edu/).
> This greatly simplifies the UAPI, since the verity metadata no longer
> needs to be transferred to the kernel.

Interfaces look sane to me. My only real concern is whether it would
make sense to make the FS_IOC_ENABLE_VERITY ioctl be something that
could be done incrementally, since the way it is done now it looks
like any random user could create a big file and then do the
FS_IOC_ENABLE_VERITY to make the kernel do a _very_ expensive
operation.

Yes, I see the

+               if (fatal_signal_pending(current))
+                       return -EINTR;
+               cond_resched();

in there, so it's not like it's some entirely unkillable thing, and
maybe we don't care as a result. But maybe the ioctl interface could
be fundamentally restartable?

If that was already considered and people just went "too complex", never mind.

               Linus
