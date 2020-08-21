Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 788CD24D7A3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Aug 2020 16:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgHUOrA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Aug 2020 10:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbgHUOq5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Aug 2020 10:46:57 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6572FC061573
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2020 07:46:57 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id di22so1616625edb.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2020 07:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9GdKxeOACY7uALRLtrv9oRSnF/gGqv6TA6L3Hiy25go=;
        b=hpiahwg9EH78MVjDWcW2rVaybIwoFsRbpdb0j63ncz9A2OgxnMI6zATzZRAYMsp1Nc
         x2OugxjWwVfSOPOhbrEQz35nU9ExDSz1+WGWhYI6hahz5uBrkN8c0RhYO6Zw3eYd/Hia
         bu9mRNzG9ehDQ0B2ekOU+jdtUAAf1KNc37fXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9GdKxeOACY7uALRLtrv9oRSnF/gGqv6TA6L3Hiy25go=;
        b=YzFx64rP++x5/tciwrIyzjUsDiwDMuikxPTv7Zl3i21f+7WrUMgI5bUj6yd72ayi5G
         1Gp9Jp7ENOuIWPDSTQxxoUcs7MlGhZJmLP407OsX9mrfbRFTY3pbMAAvLLLfQm2UkkrB
         PwwM+CD3TMk/a5r6MGj6yKmibfmgHJgMNDU5rRK6VU0O6govkxM1ZBocjO4UK6AX62LH
         XiSZG5lCeN0kDFE4lmjdI4rhSFFZc8m8xqpnwb8bXvOQk4n5r6WqRRwbJueGWrwZs+1g
         nHrC48t1YYT4MfvxJm/JGsQUa4AX9ybm/DBIFszleGlejOSYSrTM3OIZRqEPrPCQergl
         S39w==
X-Gm-Message-State: AOAM531NK+Li8jROE6ZWRCJJekFPrCzkjnqdbTY98QS3AVIwumF3qAzh
        3Z6pdh0RmCk1NjEPvO3Q7MLAl73bqn/XHiTnVtzoLA==
X-Google-Smtp-Source: ABdhPJzqm77LyknxHijF41Xfz/AAFhv5zhsEO6ZnZ4Q+smZhb6C2z3AjsF0qcBQfRCapN+qc89LrrauSuRh6vHtl40c=
X-Received: by 2002:a05:6402:1bc5:: with SMTP id ch5mr3062650edb.364.1598021215870;
 Fri, 21 Aug 2020 07:46:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200724183812.19573-1-vgoyal@redhat.com>
In-Reply-To: <20200724183812.19573-1-vgoyal@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 21 Aug 2020 16:46:44 +0200
Message-ID: <CAJfpeguzG3tfjHkToikA+v4Pu7iEa7Y=RxaO+SnycZHxFHRLGg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] fuse: Implement FUSE_HANDLE_KILLPRIV_V2 and
 enable SB_NOSEC
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org,
        virtio-fs-list <virtio-fs@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 24, 2020 at 8:38 PM Vivek Goyal <vgoyal@redhat.com> wrote:

> If you are concerned about regression w.r.t clear of caps, then we
> can think of enabling SB_NOSEC conditionally. Say user chooses it
> as mount option. But given caps is just an outlier and currently
> we clear suid/sgid based on cache (and not based on state on server),
> I feel it might not be a huge issue.
>
> What do you think?

I think enabling xattr caching should be a separate feature, and yes,
SB_NOSEC would effectively enable xattr caching.

We could add the FUSE_CACHE_XATTR feature flag without actually adding
real caching, just SB_NOSEC...

Does that sound sane?

Thanks,
Miklos
