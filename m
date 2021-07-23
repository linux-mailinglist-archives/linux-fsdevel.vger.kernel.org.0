Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA1293D436D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jul 2021 01:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232550AbhGWXAL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Jul 2021 19:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233145AbhGWXAK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Jul 2021 19:00:10 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E446CC061575
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Jul 2021 16:40:41 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id z2so4695902lft.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Jul 2021 16:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7xkMQPx7Z/4PMvWsEiJNAXvxh1Yr4z8dYX5ZnaiIDS4=;
        b=XXoy1TPU1apSD7knzLgEhQnUUASvLsESNRi3ne6s4RCN746cE5c/oLewHe1ah7OJWX
         zX+tmIau5y44orzHmGjm9NcWL+vLn4r2ubesRM6O+2Iy+N+vnUOQl9FVjsbt1NtSVWKo
         b0f0DH3eFHCHJGwwrCVmMzWiBYZqlieI0j0Fs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7xkMQPx7Z/4PMvWsEiJNAXvxh1Yr4z8dYX5ZnaiIDS4=;
        b=YCvoZaKBftivkLt+RKvVfAZpSwLiZWCtJC6Z1x6eKZdFhut0nuG6wVD7eNnrc3JJav
         bUKEC3JRlaL0sQSvgT0lpEumnaakPRbd04tCNApAY4Z3Iy5odWXpzRiIBRuFCZclNR2o
         90Zv4+fu5nCvjIdX1+nr3whVaWlPDzhFGFyZZC5R9nXM4bDHrf8o099ZXthwakjU30xh
         cgHJRpIHAucXV27rGQyjDvngafSFBILbeeWWzFXGDnctG1B/WvgHmw12TgNlNCKvGWnI
         rcCtY6nosjTUwqGOtaPs+Xss10DqU++LJHmOtEqHPXiJiLAW7iC/7G0hD4ZWRai5CbtC
         ttug==
X-Gm-Message-State: AOAM531N1Fi/0akbnkYiekeef9lEKMydryyfkPS7AURXxaeUkEOOEnES
        8Jb7nLZ2zJ0LhPNzc6ntlkS67yZkhgcLsPcm
X-Google-Smtp-Source: ABdhPJwpJAIHZLbDw7yO7VPAYgpiZ3A3PJaV8PpNCZrO1o+RO8T2d/2EDf5lH5SlUpN8gQ4Py0UcWw==
X-Received: by 2002:a05:6512:169e:: with SMTP id bu30mr4449127lfb.291.1627083639946;
        Fri, 23 Jul 2021 16:40:39 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id p3sm274180lfa.228.2021.07.23.16.40.38
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jul 2021 16:40:39 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id e5so3598106ljp.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Jul 2021 16:40:38 -0700 (PDT)
X-Received: by 2002:a2e:90cd:: with SMTP id o13mr4693434ljg.465.1627083638619;
 Fri, 23 Jul 2021 16:40:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210723205840.299280-1-agruenba@redhat.com> <20210723205840.299280-2-agruenba@redhat.com>
In-Reply-To: <20210723205840.299280-2-agruenba@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 23 Jul 2021 16:40:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg1n8yVeKABgfx7itM5o1jXVx6WXRF5PxHx+uqeFBmsmQ@mail.gmail.com>
Message-ID: <CAHk-=wg1n8yVeKABgfx7itM5o1jXVx6WXRF5PxHx+uqeFBmsmQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] iov_iter: Introduce fault_in_iov_iter helper
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ocfs2-devel@oss.oracle.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 23, 2021 at 1:58 PM Andreas Gruenbacher <agruenba@redhat.com> wrote:
>
> Introduce a new fault_in_iov_iter helper for manually faulting in an iterator.
> Other than fault_in_pages_writeable(), this function is non-destructive.

Again, as I pointed out in the previous version, "Other than" is not
sensible language.

You mean "Unlike".

Same issue in the comment:

> + * Other than fault_in_pages_writeable(), this function is non-destructive even
> + * when faulting in pages for writing.

It really should be

  "Unlike fault_in_pages_writeable(), this function .."

to parse correctly.

I understand what you mean, but only because I know what
fault_in_pages_writeable() does and what the issue was.

And in a year or two, I might have forgotten, and wonder what you meant.

             Linus
