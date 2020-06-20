Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0AF2021DE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Jun 2020 08:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbgFTGTu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Jun 2020 02:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgFTGTt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Jun 2020 02:19:49 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9B3C06174E;
        Fri, 19 Jun 2020 23:19:49 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id c4so245401iot.4;
        Fri, 19 Jun 2020 23:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xvus+uh9WtZzjywf3OG4NHlFv1zadVBBIjlELpwGoZY=;
        b=Iapl7XUscEsaSTUl7f4/1OFJ2gZcOnLD1M6RsHnplm3V4QO36r2/+0vhAePpDmKYz6
         x4V5NHUup+AYiK1YsVz/FgtsciOlgFx5JKjIC6NgDs5czS9sGXVA8m62LdxgLAY6l5tp
         RSAXQpiyW68VCtYe5D6nVr5WFV6xcWVEKZFTDkVKGeK2f025YSmP9H8m+tF0am77xszf
         dEVEsfJ8juTkFzrppCFBoPR50llCo2oO2ix2dGeos56a3n5Qiudhqm4XHCMtz4/xJXhf
         X0Q/bLnEacpsWfceTHkLIZvliLCkiFxJ/XrrU4Jm7rFKyu8oqRqxmnSH2K6nD2P+ybww
         hBKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xvus+uh9WtZzjywf3OG4NHlFv1zadVBBIjlELpwGoZY=;
        b=ilp3VuDQU0yTDA+Vtx9q6aoq974xeLSyYZD9AK8cm8bp9wRbfRPdlaJPLJuiX+JMup
         G14rMBpL+SlAPp13vVaK906Jq6fH9nrHDA4PHcuHcxYv40PdXmK1ijoHHarRe53w4TQL
         Hsjg6RCgxtMQV+lFSpOf5f84qg3SHO2LZrsV50HqcIynqQ+JPG5/mYuQ8I9HLb4zh/Ly
         QosUsuTlW2TAt/G4fC41lgXYFqi9M31FMa0Y7OH6rJJlRwFWjLBaZjgx8MTHH+ZFdX8Q
         9p1MdXnJB8Y6/XAkYevEByPZSBnpPJO/0YNPvLPmUumr3x9vUKKjZNKAIih1Noeporku
         sqIA==
X-Gm-Message-State: AOAM531Hhkk0FtoljC2L1VAH6Hoo4BtmxLlnEFr6ExuRpIIrPKzrJcQc
        f+kQjyGcI3toLnsTd29apuifW5RrdTLM9Gqzhdc/f2I0
X-Google-Smtp-Source: ABdhPJynW9021Zq8kkCg/MRVnSzqwZL2Wlfmu9uSNwSvVVmbW0swoGrsK/Fg+wXBa628RcVuvO1Dgho5rBEpv/UnuoM=
X-Received: by 2002:a05:6602:5c8:: with SMTP id w8mr8051340iox.64.1592633988637;
 Fri, 19 Jun 2020 23:19:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200619155036.GZ8681@bombadil.infradead.org>
In-Reply-To: <20200619155036.GZ8681@bombadil.infradead.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 20 Jun 2020 09:19:37 +0300
Message-ID: <CAOQ4uxjy6JTAQqvK9pc+xNDfzGQ3ACefTrySXtKb_OcAYQrdzw@mail.gmail.com>
Subject: Re: [RFC] Bypass filesystems for reading cached pages
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 19, 2020 at 6:52 PM Matthew Wilcox <willy@infradead.org> wrote:
>
>
> This patch lifts the IOCB_CACHED idea expressed by Andreas to the VFS.
> The advantage of this patch is that we can avoid taking any filesystem
> lock, as long as the pages being accessed are in the cache (and we don't
> need to readahead any pages into the cache).  We also avoid an indirect
> function call in these cases.
>
> I'm sure reusing the name call_read_iter() is the wrong way to go about
> this, but renaming all the callers would make this a larger patch.
> I'm happy to do it if something like this stands a chance of being
> accepted.
>
> Compared to Andreas' patch, I removed the -ECANCELED return value.
> We can happily return 0 from generic_file_buffered_read() and it's less
> code to handle that.  I bypass the attempt to read from the page cache
> for O_DIRECT reads, and for inodes which have no cached pages.  Hopefully
> this will avoid calling generic_file_buffered_read() for drivers which
> implement read_iter() (although I haven't audited them all to check that
>
> This could go horribly wrong if filesystems rely on doing work in their
> ->read_iter implementation (eg checking i_size after acquiring their
> lock) instead of keeping the page cache uptodate.  On the other hand,
> the ->map_pages() method is already called without locks, so filesystems
> should already be prepared for this.
>

XFS is taking i_rwsem lock in read_iter() for a surprising reason:
https://lore.kernel.org/linux-xfs/CAOQ4uxjpqDQP2AKA8Hrt4jDC65cTo4QdYDOKFE-C3cLxBBa6pQ@mail.gmail.com/
In that post I claim that ocfs2 and cifs also do some work in read_iter().
I didn't go back to check what, but it sounds like cache coherence among
nodes.

So filesystems will need to opt-in to this behavior.

I wonder if we should make this behavior also opt-in by userspace,
for example, RWF_OPPORTUNISTIC_CACHED.

Because if I am not mistaken, even though this change has a potential
to improve many workloads, it may also degrade some workloads in cases
where case readahead is not properly tuned. Imagine reading a large file
and getting only a few pages worth of data read on every syscall.
Or did I misunderstand your patch's behavior in that case?

Another up side of user opt-in flag - it can be used to mitigate the objection
of XFS developers against changing the "atomic write vs. read" behavior.
New flag - no commitment to an XFS specific behavior that nobody knows
if any application out there relies on.

Thanks,
Amir.
