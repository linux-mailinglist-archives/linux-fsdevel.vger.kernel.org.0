Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E35B35F257
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Apr 2021 13:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349072AbhDNL0M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Apr 2021 07:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348974AbhDNLZv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Apr 2021 07:25:51 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E98C06175F
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Apr 2021 04:25:26 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id s19so5109410uaq.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Apr 2021 04:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+IPm+NVwwklgzGdr0p96zVhLm/FyxrNAAUyP4ry1+WM=;
        b=BFsvtCwmjlnYspd0KU0kqzGIBobdnVtRlgLpZK/MzXz7F/7e3WcFekwmbG+ufA2GMH
         HKmGGsPG6OkvpR0ir5DdtlGcQmZp6nVtJUnBec33SWTIoh0O+EoO4QZNQeFAZ5/DGlBE
         qTHvnlpihkx8RLtuoVZhXIuu5uPRaiFXlvSL8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+IPm+NVwwklgzGdr0p96zVhLm/FyxrNAAUyP4ry1+WM=;
        b=b7uyPfxCl2ZzYd6zrZbrIxFMTQPHBcbHBovu8wsQsXYOu1NrfKOlm4xpsvdZd9HmB3
         SJ3zjitj48PYDPcYdqVLi09mYBGoNbmgG1yJnlFZYw3dnS2xRbONP8Rp8Vgii7gtgC36
         Q4kImBQLGHb2LZjXjX7uXqGXwExHQLo4J3Jzw1mpoH9rbtHiCPAO6crvP85a2bwq5eqW
         52NlNAXwQf/P1nw21M8jhlIPCtweGTSeZkEozUdMkR07M02Fg+xrU6i7iu5HYDRur9Ex
         QkE3Jy/6Is7uQ0gBJXEJS9Is1c2qlqOq0DUL1bQhc8Wp2WX9bSqKchd60InSgvr7apbO
         m3kg==
X-Gm-Message-State: AOAM530+647QojHlh8ND7kgVvxx+tBj0HLyFW7tR2Islw5ry+cv7sYME
        aBbvFwJmHq9/qfbxTo6x3w2QEi8RnsiUtjDa5Rg48A==
X-Google-Smtp-Source: ABdhPJyBJfPTktPU43LQ4QlOiRHlrK4gGV4XC90cg747ZjpIzlv0F3ngRdXaXu1NwSxfqT4Jr19yN6uPuEvTfV/ei0E=
X-Received: by 2002:ab0:356b:: with SMTP id e11mr4519887uaa.11.1618399525528;
 Wed, 14 Apr 2021 04:25:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210406140706.GB934253@redhat.com>
In-Reply-To: <20210406140706.GB934253@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 14 Apr 2021 13:25:14 +0200
Message-ID: <CAJfpegvY_xDe0th5L0uSViPauOk7z31eSZzR0+Li9Jh5tBqYRA@mail.gmail.com>
Subject: Re: [PATCH] fuse: Invalidate attrs when page writeback completes
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org,
        virtio-fs-list <virtio-fs@redhat.com>, eric.auger@redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 6, 2021 at 4:07 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> In fuse when a direct/write-through write happens we invalidate attrs because
> that might have updated mtime/ctime on server and cached mtime/ctime
> will be stale.
>
> What about page writeback path. Looks like we don't invalidate attrs there.
> To be consistent, invalidate attrs in writeback path as well. Only exception
> is when writeback_cache is enabled. In that case we strust local mtime/ctime
> and there is no need to invalidate attrs.
>
> Recently users started experiencing failure of xfstests generic/080,
> geneirc/215 and generic/614 on virtiofs. This happened only newer
> "stat" utility and not older one. This patch fixes the issue.
>
> So what's the root cause of the issue. Here is detailed explanation.
>
> generic/080 test does mmap write to a file, closes the file and then
> checks if mtime has been updated or not. When file is closed, it
> leads to flushing of dirty pages (and that should update mtime/ctime
> on server). But we did not explicitly invalidate attrs after writeback
> finished. Still generic/080 passed so far and reason being that we
> invalidated atime in fuse_readpages_end(). This is called in fuse_readahead()
> path and always seems to trigger before mmaped write.
>
> So after mmaped write when lstat() is called, it sees that atleast one
> of the fields being asked for is invalid (atime) and that results in
> generating GETATTR to server and mtime/ctime also get updated and test
> passes.
>
> But newer /usr/bin/stat seems to have moved to using statx() syscall now
> (instead of using lstat()). And statx() allows it to query only ctime
> or mtime (and not rest of the basic stat fields). That means when
> querying for mtime, fuse_update_get_attr() sees that mtime is not
> invalid (only atime is invalid). So it does not generate a new GETATTR
> and fill stat with cached mtime/ctime. And that means updated mtime
> is not seen by xfstest and tests start failing.
>
> Invalidating attrs after writeback completion should solve this problem
> in a generic manner.
>
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>

Thanks, applied.

Miklos
