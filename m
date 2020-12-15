Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C58A02DB3F3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Dec 2020 19:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731341AbgLOSsQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Dec 2020 13:48:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729716AbgLOSsQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Dec 2020 13:48:16 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83361C06179C
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Dec 2020 10:47:35 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id l11so42090456lfg.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Dec 2020 10:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rLLdi6SbGwiTC8CrKXOLyvFDABsz4NBmEvYBuGd7sOM=;
        b=c0UHZckSqT4BmDvkKwB4LQ1ic83LRU1k2v1BmoW68t0LDPr5hs0CoRGsUzEJ6RPmKd
         KmAqMRIVnMlZE2S84yIwuIUjRIiBYKa3RkBeeBOaVPsCEd6188vGhUrWKovCvsuKSCGh
         frJL9U3kwWqdLwQVdZ07ynm33WQ7xSeJxqImg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rLLdi6SbGwiTC8CrKXOLyvFDABsz4NBmEvYBuGd7sOM=;
        b=k42pE8AKDhWfkUEFjk4GIHOOXtk2pza4LRQwSruQNOIcB5Tsmmyf6MEKFp6+VVkCpt
         wuVcGPk3V9DzxD5amUD0yPG8NHDkYJ/C5DZg5UsVuJmQ4lGgRqyKA6ZpVIJNWKt0AOsl
         SUCqteSg57x3n4/OXm1vQmzDa32jDCUk5SO9u8Ptwp4a7jvtJzEcARj7JhdFIPX6yULm
         4q4YlHgiGw19xwLmE7ZMuSC0blpTn8Lo8ECtB3HhX3xBpvopANDBAMHLeyhcwjjNQwfV
         MOolyPL6P45m7Ooqmq7ujzZPI/OaSoH/DJqe8Ij0vh2TX+KA31yAY+6ID0ATFQnOokCL
         cmlw==
X-Gm-Message-State: AOAM53007ErDV+fFgcGRphKc9L3fcSUvsUglWUG4y7Rk4wZCYvvX4mVr
        Ae28q23Z2DcglgTT5fDRcc0HCjWIPydrpA==
X-Google-Smtp-Source: ABdhPJxixu8W9jYVwtLVfe/2C8xNHWg+TEzPMlxQ+TH64YS3q71ZCJb6n6xuSN7UGE1wy8w3P0nVCQ==
X-Received: by 2002:a19:804c:: with SMTP id b73mr13214622lfd.231.1608058053687;
        Tue, 15 Dec 2020 10:47:33 -0800 (PST)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id e25sm305228lfc.40.2020.12.15.10.47.32
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Dec 2020 10:47:32 -0800 (PST)
Received: by mail-lf1-f44.google.com with SMTP id m25so42015241lfc.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Dec 2020 10:47:32 -0800 (PST)
X-Received: by 2002:a2e:6f17:: with SMTP id k23mr13371970ljc.411.1608058052256;
 Tue, 15 Dec 2020 10:47:32 -0800 (PST)
MIME-Version: 1.0
References: <20201214191323.173773-1-axboe@kernel.dk> <20201214191323.173773-3-axboe@kernel.dk>
 <20201215122447.GQ2443@casper.infradead.org> <75e7d845-2bd0-5916-ad45-fb84d9649546@kernel.dk>
 <20201215153319.GU2443@casper.infradead.org> <7c2ff4dd-848d-7d9f-c1c5-8f6dfc0be7b4@kernel.dk>
 <4ddec582-3e07-5d3d-8fd0-4df95c02abfb@kernel.dk> <CAHk-=wgsdrdep8uT7DiWftUzW5E5tb_b6CRkMk0cb06q3yE_WQ@mail.gmail.com>
 <01be1442-a4d1-6347-f955-3a28a8d253e7@kernel.dk>
In-Reply-To: <01be1442-a4d1-6347-f955-3a28a8d253e7@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 15 Dec 2020 10:47:16 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgyKDvLhiKfQ1xvBxFkD_+v_SCmMeJvzNJ_maibWH6QRQ@mail.gmail.com>
Message-ID: <CAHk-=wgyKDvLhiKfQ1xvBxFkD_+v_SCmMeJvzNJ_maibWH6QRQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] fs: add support for LOOKUP_NONBLOCK
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 15, 2020 at 10:44 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> In usecs again, same test, this time just using io_uring:
>
> Cached          5.10-git        5.10-git+LOOKUP_NONBLOCK
> --------------------------------------------------------
> 33%             1,014,975       900,474
> 100%            435,636         151,475

Ok, that's quite convincing. Thanks,

            Linus
