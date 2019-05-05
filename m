Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4062513F9D
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 May 2019 15:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbfEENTP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 May 2019 09:19:15 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:42528 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbfEENTO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 May 2019 09:19:14 -0400
Received: by mail-yw1-f66.google.com with SMTP id s5so1768804ywd.9
        for <linux-fsdevel@vger.kernel.org>; Sun, 05 May 2019 06:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=00RF/tCSnQjjddatVhgfYYWIdDqb7quzWghi0f0Ylh0=;
        b=NvTzrTd41pdkFiv+Yaxcke6En5ig0ArSpAElZSS1d2hFxIsClEqyAZyO+bZk6n4iPr
         mbkmJH9b5jVK/kEZlANocxCUq8fJ4vsjAdTLqlWULp8NyKSzq5p25awLtR84+ldFVIPt
         6B54f3ADqBg2SeuoIFmGZEbZWSNi2pYNZncj82EzMpyDaTYWLC4UjQvl5xWwu9AbSitU
         zTLOnZNFhPoBV1meg+fNcOMt5DBhUUXGayuGWnH6itKmmAtuPYLSz9oE6EZrCtVIL+2X
         f+jCnBnn2rCav/JEiAQGaq6+Y5ToRk54p/gTgx16JJsVWJaW/N142asY8FvszwDDCsM2
         VZKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=00RF/tCSnQjjddatVhgfYYWIdDqb7quzWghi0f0Ylh0=;
        b=Ne+Jv0NI7bpDs4kp9ZM9filSkmpuobofDBw7oNuu21GHZFUlPRb9XGSeeYz2TxbSWg
         SXrPYe05jA6v1MKOQQeOqQ5K3qxZpAk17T6pcSnL3G0h6YGxjzMVAoQ2sJoNrVW67+hF
         80AJiFgtHvR26AI2B6FMaxTo16nolFqLoH+CrQnERCtC2blIKKn5gnX7nLTMlfiRUgt1
         ygqSsIMBxSffe3xM0IC2ezxizumUrGDlzChOyClscMvDRa1fhKMNGMiw5mwI70NB8wQG
         F93pO4HZAjt+IcQcrQiu52FT3czhHt/vWsMRnseZ0GarMq48YPs6Ga7qa8WvQfZJYQu3
         lQDA==
X-Gm-Message-State: APjAAAVxODiLEnuHZMsbnHCf8mOh0SE9w1O1QWLKV1dy1CdHQkxklvyY
        6o/UbG7NpUmEOt1cSJdTg3wzCS75G7w/xG1BHtg=
X-Google-Smtp-Source: APXvYqxs/ddZ1yTvw9W1EX8m7TmUC2QUEDyJ1Isz0+8LqVUf6FyAmLW6HqY+wfq/YqFCysMdxMlVUWoldYwRZV4gOyE=
X-Received: by 2002:a81:5fc4:: with SMTP id t187mr13489343ywb.34.1557062353959;
 Sun, 05 May 2019 06:19:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190505091549.1934-1-amir73il@gmail.com> <20190505130528.GA23075@ZenIV.linux.org.uk>
In-Reply-To: <20190505130528.GA23075@ZenIV.linux.org.uk>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sun, 5 May 2019 16:19:02 +0300
Message-ID: <CAOQ4uxhEWLXQ+cb4UQcworPQoJpXvf59HJYi2dv5pumvbxpA9w@mail.gmail.com>
Subject: Re: [PATCH] fsnotify: fix unlink performance regression
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Jan Kara <jack@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>, LKP <lkp@01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 5, 2019 at 4:05 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Sun, May 05, 2019 at 12:15:49PM +0300, Amir Goldstein wrote:
> > __fsnotify_parent() has an optimization in place to avoid unneeded
> > take_dentry_name_snapshot().  When fsnotify_nameremove() was changed
> > not to call __fsnotify_parent(), we left out the optimization.
> > Kernel test robot reported a 5% performance regression in concurrent
> > unlink() workload.
> >
> > Reported-by: kernel test robot <rong.a.chen@intel.com>
> > Link: https://lore.kernel.org/lkml/20190505062153.GG29809@shao2-debian/
> > Link: https://lore.kernel.org/linux-fsdevel/20190104090357.GD22409@quack2.suse.cz/
> > Fixes: 5f02a8776384 ("fsnotify: annotate directory entry modification events")
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >
> > Jan,
> >
> > The linked 5.1-rc1 performance regression report came with bad timing.
> > Not sure if Linus is planning an rc8. If not, you will probably not
> > see this before the 5.1 release and we shall have to queue it for 5.2
> > and backport to stable 5.1.
> >
> > I crafted the patch so it applies cleanly both to master and Al's
> > for-next branch (there are some fsnotify changes in work.dcache).
>
> Charming...  What about rename() and matching regressions there?

rename() and create() do not take_dentry_name_snapshot(), because
they are called with parent inode lock held.
I have made an analysis of callers to d_delete() and found that all callers
either hold parent inode lock or name is stable for another reason:
https://lore.kernel.org/linux-fsdevel/20190104090357.GD22409@quack2.suse.cz/

But Jan preferred to keep take_dentry_name_snapshot() to be safe.
I think the right thing to do is assert that parent inode is locked or
no rename op in d_delete() and take the lock in ceph/ocfs2 to conform
to the standard.

If that sounds good to you, I will follow up with a patch for next and then
remove take_dentry_name_snapshot() from fsnotify_nameremove() hook.

Thanks,
Amir.
