Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2610F2C0380
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Nov 2020 11:41:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728667AbgKWKkP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Nov 2020 05:40:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728158AbgKWKkP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Nov 2020 05:40:15 -0500
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1505DC0613CF
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2020 02:40:15 -0800 (PST)
Received: by mail-vs1-xe43.google.com with SMTP id r5so8857668vsp.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2020 02:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jamAVoUCU+8fqygXmQmsc1NChi/+hIkgctg7KmhQF/Y=;
        b=Yz0XxP/vbZZ2Bp1U1fJz8+K0B0BJdjNSuCile3vvm7Sr5yeNQh6UKhmv2RB3huq+XD
         IKU4DOq9USspblp0z/SciYGA+bNvLR+puvuQaymzMcjq1kPG1GXeSIQcEwx30f1D7Nvg
         IWRwwgGsvwr1ZqFpqKlv3KybYHOlEvSmGL4Dw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jamAVoUCU+8fqygXmQmsc1NChi/+hIkgctg7KmhQF/Y=;
        b=Q+7qOOfjVNPHd29oe0dT8VNKw04+8WGPoCWgVkJiKaUXc1Sk9YuycLr6zQgFxWQKCe
         LYbIb9fnDy/HRk5mt+BbMTOPzfWXOgGh4a60KGJL2PPVka+IDRq922VKaLNV1FJkvWNM
         gfCxgVAT1g5Q9yysxYI7qV6wUKGWwj3Jbu2ixISOemAgA/Hj+E6hGB5udhVoJCotz+wx
         W+CWz6go/x0U0jO44zDvIg30EHA/yARZmGo9NRHWFfUH9spo4lYZeL68DgdKbsFvLrhD
         rSHmRfiSzT9DDfwLkn4ibNKU/490Fp2x5ynyaPmMYEkQaPOE/c+rroYI2+2cxsp5kPYx
         goEg==
X-Gm-Message-State: AOAM532Tzrh+amztO/j5/MUgxZhuazOh0jAGHtnleVA4Fr9u5vhnE0ee
        VGGci847Q1y2lS1qWxOpBMyDU2mtyO+7BM90X3ag7w==
X-Google-Smtp-Source: ABdhPJz6ZlgtfJVhkbeRGNZvAGKv7R937MF6nw1Pdfo9mXsGCoidasg7HSGhNPtZWqIyzUt8yKp25DQnfaM7T6IFAa8=
X-Received: by 2002:a05:6102:3203:: with SMTP id r3mr17953733vsf.21.1606128014273;
 Mon, 23 Nov 2020 02:40:14 -0800 (PST)
MIME-Version: 1.0
References: <DM6PR12MB3385BD749DF7B07275AAD703DDFF0@DM6PR12MB3385.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB3385BD749DF7B07275AAD703DDFF0@DM6PR12MB3385.namprd12.prod.outlook.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 23 Nov 2020 11:40:03 +0100
Message-ID: <CAJfpegu57WwNfO7N1qJUMuFk_5pOUY-1DihYPySKc0LNHTm8JA@mail.gmail.com>
Subject: Re: [RESEND PATCH] fuse : Improve file open behavior for recently
 created/unlinked files
To:     Ken Schalk <kschalk@nvidia.com>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "fuse-devel@lists.sourceforge.net" <fuse-devel@lists.sourceforge.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 20, 2020 at 11:35 PM Ken Schalk <kschalk@nvidia.com> wrote:
>
> When a dentry exists for the path argument to an open with O_CREAT or
> a negative dentry exists for the path argument to any open, make a
> lookup request to the user-space daemon to verify the
> existence/non-existence of the path.
>
> This improves file open behavior for a FUSE filesystem where changes
> may be made without going through the mount point, such as a
> distributed filesystem accessed concurrently from multiple hosts.
> Specifically:
>
> - For an open with O_CREAT of a path with a cached dentry, the
>   user-space daemon is able to report a recent unlink of a file
>   allowing it to be re-created rather than either the open failing
>   with EEXIST (when O_EXCL is used) or a FUSE open request causing the
>   open to fail with ENOENT (when O_EXCL is not used).
>
> - For an open of a path with a cached negative dentry, the user-space
>   daemon is able to report the recent creation of a file allowing it
>   to be opened rather than the open failing with ENOENT.
>
> This is intended to be functionally equivalent to behavior in the NFS
> client which re-validates a cached dentry on file open.

You haven't replied to this:

https://lore.kernel.org/linux-fsdevel/CAJfpegv5EckmJ_PCqHc2N3_jHaXfinMwvDNSttYNXcan1wr1fQ@mail.gmail.com/

Thanks,
Miklos
