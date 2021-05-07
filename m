Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 166723769EC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 May 2021 20:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbhEGSWz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 May 2021 14:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbhEGSWx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 May 2021 14:22:53 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1793C061761
        for <linux-fsdevel@vger.kernel.org>; Fri,  7 May 2021 11:21:53 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id q15so3510135pgg.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 May 2021 11:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7fCSrm1y7Xq97IAHremOIKdD7kw68d58fJ8MoM3puqQ=;
        b=j3BSf8NuC3uBjJ1o6h9PeYHzU0Ac0zV2hjFUujVGeXxs7IdzCgRj3eZMnuviX4e6SH
         pKsTMZGFJTIleEe5s/wqWDiikh6hYIYLO6w2BzH4AOj8QiXmGyvojQzI9egq9xfviAr6
         i9+E82IavVQ0v3J5OH+S8IsmL5bCgsRjIRoos=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7fCSrm1y7Xq97IAHremOIKdD7kw68d58fJ8MoM3puqQ=;
        b=o9rvN/ItaZJv2s2d6JPw9euIfujUpSeKuw1iSc0FWoW88JNV4rHpMc5ocBoRiMDAm8
         /qkT+qpe2dpyuubAu71tVG588Ro589ieLJm19HzeTCBrYxwb0SEGH0KuJLaL6mpmIgvO
         T5JJUXiCOAvyrciucSPimO4aL86aSvegIjNiS1z8n9Ff7nvlZ+sjs8q4afHrkwf9tQL5
         Do8Gm+C4BvAN/0HEn2zfVNLmaz182yx9GzVsD8H6n7YOHcoBsOoZbn3DKAzD1owH+5mP
         YzPt9Q+Cy988TsGSLdI0sODdGqOYBeXkJDiRBrslA/LzpurXmb07foQRc7epZMpvZ2kS
         YCHA==
X-Gm-Message-State: AOAM5328pDQ2AlRiJGSpdmIThZ6KKIeMjt8xgZs3NReSNoEpf+gPMQhJ
        uKcA9dvooKI3I9NMEwLA38K+DA==
X-Google-Smtp-Source: ABdhPJz8CS9q5rXfcY7LgQqI3sId5Vc+1v36/U105G55ZeUyALY7FzVeZq5EUZ0VqjgHvHLbq78jtA==
X-Received: by 2002:a63:f258:: with SMTP id d24mr11148640pgk.174.1620411713164;
        Fri, 07 May 2021 11:21:53 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x22sm3863506pfp.138.2021.05.07.11.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 11:21:52 -0700 (PDT)
Date:   Fri, 7 May 2021 11:21:51 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Colin Ian King <colin.king@canonical.com>
Cc:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: splice() from /dev/zero to a pipe does not work (5.9+)
Message-ID: <202105071116.638258236E@keescook>
References: <2add1129-d42e-176d-353d-3aca21280ead@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2add1129-d42e-176d-353d-3aca21280ead@canonical.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 07, 2021 at 07:05:51PM +0100, Colin Ian King wrote:
> Hi,
> 
> While doing some micro benchmarking with stress-ng I discovered that
> since linux 5.9 the splicing from /dev/zero to a pipe now fails with
> -EINVAL.
> 
> I bisected this down to the following commit:
> 
> 36e2c7421f02a22f71c9283e55fdb672a9eb58e7 is the first bad commit
> commit 36e2c7421f02a22f71c9283e55fdb672a9eb58e7
> Author: Christoph Hellwig <hch@lst.de>
> Date:   Thu Sep 3 16:22:34 2020 +0200
> 
>     fs: don't allow splice read/write without explicit ops
> 
> I'm not sure if this has been reported before, or if it's intentional
> behavior or not. As it stands, it's a regression in the stress-ng splice
> test case.

The general loss of generic splice read/write is known. Here's some
early conversations I was involved in:

https://lore.kernel.org/lkml/20200818200725.GA1081@lst.de/
https://lore.kernel.org/lkml/202009181443.C2179FB@keescook/
https://lore.kernel.org/lkml/20201005204517.2652730-1-keescook@chromium.org/

And it's been getting re-implemented in individual places:

$ git log --oneline --no-merges --grep 36e2c742
42984af09afc jffs2: Hook up splice_write callback
a35d8f016e0b nilfs2: make splice write available again
f8ad8187c3b5 fs/pipe: allow sendfile() to pipe again
f2d6c2708bd8 kernfs: wire up ->splice_read and ->splice_write
9bb48c82aced tty: implement write_iter
dd78b0c483e3 tty: implement read_iter
14e3e989f6a5 proc mountinfo: make splice available again
c1048828c3db orangefs: add splice file operations
960f4f8a4e60 fs: 9p: add generic splice_write file operation
cf03f316ad20 fs: 9p: add generic splice_read file operations
06a17bbe1d47 afs: Fix copy_file_range()

So the question is likely, "do we want this for /dev/zero?"

-- 
Kees Cook
