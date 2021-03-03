Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F170D32C54C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Mar 2021 01:59:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1450698AbhCDAT7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Mar 2021 19:19:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351380AbhCCPhZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Mar 2021 10:37:25 -0500
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86C6DC06175F
        for <linux-fsdevel@vger.kernel.org>; Wed,  3 Mar 2021 07:36:36 -0800 (PST)
Received: by mail-vs1-xe29.google.com with SMTP id p24so3724366vsj.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Mar 2021 07:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Yr1qOumuS8TXWEOrqim0XuS33cj0E8thnCAJCT0r9GY=;
        b=ZhRS1Ok6vhL7zeDZkgmGxaMYhwI3zcCvbfNUajVPoWdIK7sa0Qg3QadGgEpwbgZPwI
         WYG5/mB6f3ljby+rTF1atb4Fzjq7V2Bh9gxg8DPAC83591G7R1A7ABhYpVpBv88FjR6G
         jlGtz+N88vdwfHPiocq9EWVTpEgpzPl6hyFUQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yr1qOumuS8TXWEOrqim0XuS33cj0E8thnCAJCT0r9GY=;
        b=RCa5yceNyHbMjjg7D6d51TZr3bjTdiI5WxFv6zhJ56/m1bIhRBit+OiJ23E/xuOC4o
         OUClauKtukfTbZMR0HuljlIEBXsqrjCb7JP2oAPCMoncrsjy5J/pSsF+JAJ1D0MGJxsg
         Xj2aQuW1sNFxvGWxTz59vdGmMzWVx1Go1T8ry+02XcO/KdqpSeM4kgVMWgjlNIFGC0he
         ZyEaqR9wdRTPiEi51rVVzpgQO6lAnJ9X9X5ws65Z7+wAxThVLH1Eev/jZalHIeR7J819
         mCkLQ2sLn6KZPSfF3XACXqQ8VCJd6KTQmg5u4DY51OY4fcLE042efkHfBmIAgGWb1pfg
         IQqw==
X-Gm-Message-State: AOAM532frcY6/BgXZg47jJ79sh3rP3CZJ5SFOBjTgZjUFHzwf2baBPYh
        AhpyzPk0aPvXPg6d9yUdYMkjLVftd0q8LFhhQTpy/g==
X-Google-Smtp-Source: ABdhPJwdR6lr6rfem6g68OGV+xNgCuKFByuMYSgHWe9UZYcANiOzASdFonlabHuTZd4ATGAeavQUJ7X12XHr51EjVJU=
X-Received: by 2002:a67:c992:: with SMTP id y18mr6718750vsk.7.1614785795666;
 Wed, 03 Mar 2021 07:36:35 -0800 (PST)
MIME-Version: 1.0
References: <20210226183357.28467-1-lhenriques@suse.de> <20210301163324.GC186178@redhat.com>
 <YD0wbmulcBVZ7VZy@suse.de> <20210302160033.GD220334@redhat.com> <20210302162554.GE220334@redhat.com>
In-Reply-To: <20210302162554.GE220334@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 3 Mar 2021 16:36:24 +0100
Message-ID: <CAJfpegt7U_-gv0QKFF8D9P6DmsHbQ=fNUOBrC17X6Z+O7WzrzQ@mail.gmail.com>
Subject: Re: [RFC PATCH] fuse: Clear SGID bit when setting mode in setacl
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Luis Henriques <lhenriques@suse.de>, linux-fsdevel@vger.kernel.org,
        virtio-fs-list <virtio-fs@redhat.com>,
        linux-kernel@vger.kernel.org,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 2, 2021 at 5:26 PM Vivek Goyal <vgoyal@redhat.com> wrote:

> > I still feel that it should probably be fixed in virtiofsd, given fuse client
> > is expecting file server to take care of any change of mode (file
> > permission bits).
>
> Havid said that, there is one disadvantage of relying on server to
> do this. Now idmapped mount patches have been merged. If virtiofs
> were to ever support idmapped mounts, this will become an issue.
> Server does not know about idmapped mounts, and it does not have
> information on how to shift inode gid to determine if SGID should
> be cleared or not.
>
> So if we were to keep possible future support of idmapped mounts in mind,
> then solving it in client makes more sense.  (/me is afraid that there
> might be other dependencies like this elsewhere).
>
> Miklos, WDYT.

Hmm sounds like two different modes of operation.

1) shared, non-idmapped: need to take care of races, so do the sgid
clearing in the server
2) non-shared, idmapped: can only do it in client

The same applies to all the other FUSE_*_KILL* stuff, so I guess the
decision about the mode just needs to be tied to a flag in some way.
Not sure if an existing one could be used.

Thanks,
Miklos
