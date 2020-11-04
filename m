Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9952A6C3D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Nov 2020 18:54:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731260AbgKDRyQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Nov 2020 12:54:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730865AbgKDRyP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Nov 2020 12:54:15 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BFE2C0613D3
        for <linux-fsdevel@vger.kernel.org>; Wed,  4 Nov 2020 09:54:15 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id i6so28343667lfd.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Nov 2020 09:54:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KDF/IVt/yM5vKvfY6fRo0fNzEAF8Z0Cn2GtQDil02vc=;
        b=hXhtTtO+S8d2VZNihnap8ENkU4okxgo2j5jRC3/VfbThfzLKjoY9rFtASjZkhfK3s3
         qhVE8hIVQgRDoaRjKV+sJOgqdoZDAN9jHBYe4N0IyHtI1g8IALfcuzpLWg2QZ6LIm8LB
         c/aLMvqxGizeQKNfljmxCLZHLcPpM+v9Z3VkM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KDF/IVt/yM5vKvfY6fRo0fNzEAF8Z0Cn2GtQDil02vc=;
        b=njfWolKWROqwIPJqUvCDiGFs8u+WWNwj/vwOvZmqQLcssBiO6SqKThHWv//pc91yy9
         s2+rDATfZxQMZM62r4UitVqb5K40e8qcCbsorAfLXW70irj955RRgkPmqsVhetsCUMx9
         0ohpxMCYeO+u1Znhq7ey7WEGoFpw3OBMMPfMS4R+pnRkrBvjdsZ6ZhbsrsFcaneokOsu
         mUYYR2EwzjOijLHnV8qvCvCMD0x5tkENKyogjHg8qNDJozyXkn4QucAMJCvu/4Q6olSW
         GEKycm9E2fLgvqxxQPrFJRqdVi22+jhuKzQrecMrVX71y2JIE1dxVKJRsTxn2O6s7joZ
         XCVQ==
X-Gm-Message-State: AOAM531hYH4vLzX3v344lol1LJfA3iUvwfiMETDhVaHQ7JxLbH4uCcCR
        m4uuUsgwgRpG221Z2BYZYxJhH1kRwOgSwQ==
X-Google-Smtp-Source: ABdhPJz6xku7z81PUE2WhcAiRmqFXCwcSJRKb4TBcera6zrimDZABL+Jtm+P8BT3gHzuTk290Cpn4Q==
X-Received: by 2002:a05:6512:312d:: with SMTP id p13mr60454lfd.539.1604512453618;
        Wed, 04 Nov 2020 09:54:13 -0800 (PST)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id a9sm88273ljb.63.2020.11.04.09.54.12
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2020 09:54:12 -0800 (PST)
Received: by mail-lj1-f182.google.com with SMTP id 11so4366382ljf.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Nov 2020 09:54:12 -0800 (PST)
X-Received: by 2002:a2e:3e1a:: with SMTP id l26mr11736406lja.285.1604512452220;
 Wed, 04 Nov 2020 09:54:12 -0800 (PST)
MIME-Version: 1.0
References: <20201104082738.1054792-1-hch@lst.de>
In-Reply-To: <20201104082738.1054792-1-hch@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 4 Nov 2020 09:53:56 -0800
X-Gmail-Original-Message-ID: <CAHk-=whzWXASyyzs3veAUZznCT2+EeeBaX3o8w8NsKNL+woarQ@mail.gmail.com>
Message-ID: <CAHk-=whzWXASyyzs3veAUZznCT2+EeeBaX3o8w8NsKNL+woarQ@mail.gmail.com>
Subject: Re: support splice reads on seq_file based procfs files v2
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Greg KH <gregkh@linuxfoundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 4, 2020 at 12:29 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Greg reported a problem due to the fact that Android tests use procfs
> files to test splice, which stopped working with 5.10-rc1.  This series
> adds read_iter support for seq_file, and uses those for various seq_files
> in procfs to restore splice read support.

Ack.

Al, do you want me to take these directly - we'll need this to avoid
the regression in 5.10?  Or do you have other things pending and I'll
see them in a pull request.

             Linus
