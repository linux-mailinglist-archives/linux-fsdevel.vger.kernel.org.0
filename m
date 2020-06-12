Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E56FD1F763C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jun 2020 11:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbgFLJwm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Jun 2020 05:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgFLJwk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Jun 2020 05:52:40 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A48C03E96F;
        Fri, 12 Jun 2020 02:52:40 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id u13so9558085iol.10;
        Fri, 12 Jun 2020 02:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mxe6urm4JpELbEMID9elsI5xqLhyciO2vnmpyvkengk=;
        b=hhq4SXwhAVKB/lCD7KaDTf14Oef1aVomwhec7lqZiSfrctzwqnQrHOzffofQJawnHw
         0ivf/vQe274ra9FzlILekFVAL75GbXxUhEarIPMblzy2xZkbNSmZXiFZOFQZDh/erfiq
         DvkriXBVglUmumUcJJ8vZ7SlUJg2nUa5WoQZxFRsKTkEcpNLkpGfEEyIL4STtUtJF5Mp
         O9pqzvOX7JjFa5L56UJ8aBw7IRUYHcylp+8nhwfx+QtBPdxB/BK++8e8LnbOr2iwzSvY
         c9VkFQsaU1XA39gPrVZsQZPCSeJM3PnGCKBkL3hXcpC8OWjhhBKnejW71r1I7ABJjdVk
         DU/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mxe6urm4JpELbEMID9elsI5xqLhyciO2vnmpyvkengk=;
        b=NT+bHiNBpWofMUkRLycEJV1JsT5XycBkCfgHK/HvitwTCbmefJCPQr5Gtx8rfBXSUs
         IhsMx25y8y8NtcGtKYGgJaiHKnJZfxil0xjqkqLR5BE3k5M6TTSGuEC3B6B5RAiCAWei
         opRql5wvbwlgwEnwwwQMhrQJlsB4oR5sha8CL06oxept//MOHRBk89C4jv1p48g/p5gJ
         HAI362eInkKoCeKKG5MsoNSwrO9lp7j7nL7b5L4WYmnv1DJcPW8zaeXju1btHl/YeoaP
         ViSf26KllEbaswYHBehIBFme2vp/9XVYNx1UR1AUkeeN12dv2KEWyNPja9EMwnd+Q3lp
         ewNQ==
X-Gm-Message-State: AOAM532ntmbrJfCFiI0cvYcBit9B0c5XWxFlKiPZo4WhNjhlRhIbWpwF
        +iXDyRIBtK5bG2iEC+kZ4BFUETn7Oq/ZKzf0emQD/cxp
X-Google-Smtp-Source: ABdhPJxpaRzuAM7APz0uQTEjAbythRWAVkqQmECFh5g/VzHILx0wAUzBcREQ2edrLaSgVYS49gv6VI9ktc1aPFibQmk=
X-Received: by 2002:a02:85a5:: with SMTP id d34mr7139348jai.123.1591955559406;
 Fri, 12 Jun 2020 02:52:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200612092603.GB3183@techsingularity.net>
In-Reply-To: <20200612092603.GB3183@techsingularity.net>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 12 Jun 2020 12:52:28 +0300
Message-ID: <CAOQ4uxikbJ19npQFWzGm6xnqXm0W8pV3NOWE0ZxS9p_G2A39Aw@mail.gmail.com>
Subject: Re: [PATCH] fs: Do not check if there is a fsnotify watcher on pseudo inodes
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 12, 2020 at 12:26 PM Mel Gorman <mgorman@techsingularity.net> wrote:
>
> The kernel uses internal mounts for a number of purposes including pipes.
> On every vfs_write regardless of filesystem, fsnotify_modify() is called
> to notify of any changes which incurs a small amount of overhead in fsnotify
> even when there are no watchers.
>
> A patch is pending that reduces, but does not eliminte, the overhead
> of fsnotify but for the internal mounts, even the small overhead is
> unnecessary. The user API is based on the pathname and a dirfd and proc
> is the only visible path for inodes on an internal mount. Proc does not
> have the same pathname as the internal entry so even if fatrace is used
> on /proc, no events trigger for the /proc/X/fd/ files.
>

This looks like a good direction and I was going to suggest that as well.
However, I am confused by the use of terminology "internal mount".
The patch does not do anything dealing with "internal mount".
If alloc_file_pseudo() is only called for filesystems mounted as
internal mounts,
please include this analysis in commit message.
In any case, not every file of internal mount is allocated with
alloc_file_pseudo(),
right? So maybe it would be better to list all users of alloc_file_pseudo()
and say that they all should be opted out of fsnotify, without mentioning
"internal mount"?

Thanks,
Amir.
