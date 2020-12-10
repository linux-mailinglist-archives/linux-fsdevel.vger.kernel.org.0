Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9A132D6BEF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Dec 2020 00:39:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392581AbgLJXac (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Dec 2020 18:30:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbgLJXaX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Dec 2020 18:30:23 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E70C0613CF
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Dec 2020 15:29:42 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id a1so8754472ljq.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Dec 2020 15:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L1hnItWupdMEPpWlMWRUILHJUCCtx6lsmAslWK2gfcQ=;
        b=QZIetyw+/rnNjZ1lmNrvivPuhLXlu9u2TyoobyGdFgd9eWs7jnBEcdgCEIGJSWJs22
         B092weZTAxOdTAHuelc0AmzruV7p0WsnPMYUQn+6H+qKuly+G+l36eBvWY39era+v7Xu
         K/09ki9H9dkFhvIIjiBpQ2YJ71nhcc3SsV/9k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L1hnItWupdMEPpWlMWRUILHJUCCtx6lsmAslWK2gfcQ=;
        b=oIkAdaiKMXx+u6iijoNyjeFXByCNqhrE1U2iPAsSQ1S0ww22b7SSotgTbta5ZZolSy
         OQdIitwnnEZuxMocScv+cgAmM3FeQE6KI0MtjtpsWhYE2E2tWO3J5I8eTaVxCUCNE/hi
         0t6xZXp38DlCxSWeegQeVjMPK5SWencFClMLHgq7eZzTcOvYcTmGqqZ/d73vyYJkUTiN
         ugOKKF2dn494JyFw4UZfw7OEoFcaSjROde+UvWXZG4n2G0GC964irUr7bnTiI7uez0lA
         3OHz4t0NRZ4du/fwqyX6bWDNwlgahqdLWTqack+U+NxwJMWYdAM0NUsUwh6785uSceOi
         Kvzg==
X-Gm-Message-State: AOAM532379Ctkj9YwOGXu7D3qlQ6lGsj48APqPVz1lUQuI/lOgYdDW69
        r0sa2w4x9QWu16sNd7ntM9AACSvb7L0wXQ==
X-Google-Smtp-Source: ABdhPJwzqkwMwI89lRbyyj7QHOkfiY7e2n3T35xlbY4M0bhSEJX5jpHd7EiiRWrS75PZaXDw0JLSXg==
X-Received: by 2002:a2e:7119:: with SMTP id m25mr3774426ljc.229.1607642980845;
        Thu, 10 Dec 2020 15:29:40 -0800 (PST)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id y81sm697110lfc.100.2020.12.10.15.29.39
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Dec 2020 15:29:40 -0800 (PST)
Received: by mail-lf1-f52.google.com with SMTP id 23so10751195lfg.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Dec 2020 15:29:39 -0800 (PST)
X-Received: by 2002:a19:8557:: with SMTP id h84mr3356140lfd.201.1607642979222;
 Thu, 10 Dec 2020 15:29:39 -0800 (PST)
MIME-Version: 1.0
References: <20201210200114.525026-1-axboe@kernel.dk> <20201210200114.525026-3-axboe@kernel.dk>
 <20201210222934.GI4170059@dread.disaster.area>
In-Reply-To: <20201210222934.GI4170059@dread.disaster.area>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 10 Dec 2020 15:29:23 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiee7xKitbX74NvjcKDHLiE21=SbO9_urWBnvm=nSZAFQ@mail.gmail.com>
Message-ID: <CAHk-=wiee7xKitbX74NvjcKDHLiE21=SbO9_urWBnvm=nSZAFQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] fs: expose LOOKUP_NONBLOCK through openat2() RESOLVE_NONBLOCK
To:     Dave Chinner <david@fromorbit.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 10, 2020 at 2:29 PM Dave Chinner <david@fromorbit.com> wrote:
>
> So, really, this isn't avoiding IO at all - it's avoiding the
> possibility of running a lookup path that might blocking on
> something.

For pathname lookup, the only case that matters is the RCU lockless lookup.

That cache hits basically 100% of the time except for the first
lookup, or under memory pressure.

And honestly, from a performance perspective, it's the lockless path
lookup that matters most. By the time you have to go to the
filesystem, take the directory locks etc, you've already lost.

So we're never going to bother with some kind of "lockless lookup for
actual filesystems", because it's only extra work for no actual gain.

End result: LOOKUP_NONBLOCK is about not just avoiding IO, but about
avoiding the filesystem and the inevitable locking that causes.

              Linus
