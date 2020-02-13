Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9233615BC0F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2020 10:50:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729728AbgBMJut (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Feb 2020 04:50:49 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:45287 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729653AbgBMJut (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Feb 2020 04:50:49 -0500
Received: by mail-il1-f194.google.com with SMTP id p8so4406355iln.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Feb 2020 01:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IvHiB786hyXMz9+mRm3V1jaQi9rh7eAtkp5fjK9oQpc=;
        b=dro2BDY8dm9jeWkM6tJLCUicRS2wiaxHeuHw/Jo8PypTHwNBMstEpIyo6m825x6J1/
         W7qATYCETJ8nOzLulY5tNGWI2aJCwHKd0Y6MaP8kddDYmcvcAuhqqGNprAdOzXaJWQLy
         pIWUQw0vnTlBRYQ6UIPNBdEr2Gj4bzsDZCARQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IvHiB786hyXMz9+mRm3V1jaQi9rh7eAtkp5fjK9oQpc=;
        b=bpqjxSqOzAHeuTwg27EqzwZsocOR4ktQ9DYBhk1WQYdVjE9dur28ybUZP0nZWq/9GM
         jSI7uXYaSuSmyhq4JXQArKM7J5k40HvVVqoCy0VtbIApSIEm1GdIOdqBrddHsiUIey5/
         s2Z8jJd5oRWeCVQK9/2U1Z8rdyppDvsvV27UU3CQXH/rPLKROV1qW8UcK/dZDb02ClIg
         U/DAfe/NB/7yB94yMrAB4gN+RsEWih8+KfyFVQUORksDBKogwFs8Q/e0ZjlesXtUf0gj
         f7o51kARgaWg/pMZIJNkrt4IxBT1dZdehCJVhm/UwH5bJkiNVClPqPKckpEvd2xYmtKd
         FFww==
X-Gm-Message-State: APjAAAUrr15Vn5BnJ5ZzsTWMUVGKt2wMqIWL6v98ix9gV59m8RbUlWSx
        TGoq9qgMt24/hKygAxPPJ2wzg9p6G0xDKF9IjQg6LQ==
X-Google-Smtp-Source: APXvYqzPLyJuiUk2YFOhc26hrDS3dr/fVN/SUfieTZuZUy05TLW5Qd5IdMYr7oO8bYEjT0St9vYd2sTrYMX3nsEWWRA=
X-Received: by 2002:a92:8847:: with SMTP id h68mr14775650ild.212.1581587447525;
 Thu, 13 Feb 2020 01:50:47 -0800 (PST)
MIME-Version: 1.0
References: <1580536171-27838-1-git-send-email-qiwuchen55@gmail.com>
 <668fc86f-4214-f315-9b41-40368ba91022@fastmail.fm> <20200202020817.GA14887@cqw-OptiPlex-7050>
 <aafd8abf-832b-6348-7b74-4d65451a1eb6@fastmail.fm>
In-Reply-To: <aafd8abf-832b-6348-7b74-4d65451a1eb6@fastmail.fm>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 13 Feb 2020 10:50:36 +0100
Message-ID: <CAJfpegvmeQf=AiO3PXph=Ghj0Hf5f93xfn6ovmWmunf9=FZiYw@mail.gmail.com>
Subject: Re: [PATCH] fuse: fix inode rwsem regression
To:     Bernd Schubert <bernd.schubert@fastmail.fm>
Cc:     chenqiwu <qiwuchen55@gmail.com>, linux-fsdevel@vger.kernel.org,
        chenqiwu <chenqiwu@xiaomi.com>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Feb 2, 2020 at 10:18 PM Bernd Schubert
<bernd.schubert@fastmail.fm> wrote:
> For network file systems it also common to globally enforce fuse
> direct-io to reduce/avoid cache coherency issues - the application
> typically doesn't ask for that on its own. And that is where this lock
> is badly hurting.  Hmm, maybe we should differentiate between
> fuse-internal direct-io and application direct-io requests here?

I'm not against optionally removing the locking for direct write.
Theoretically that should be doable.  But we need to be very careful
about not breaking any assumptions in the kernel and libfuse code.
Obviously this would need to be enabled with a flag (e.g.
FOPEN_PARALLEL_WRITES).

Thanks,
Miklos
