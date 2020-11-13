Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2A32B1555
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Nov 2020 06:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbgKMFTU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Nov 2020 00:19:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbgKMFTT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Nov 2020 00:19:19 -0500
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D37C0613D1
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2020 21:19:19 -0800 (PST)
Received: by mail-yb1-xb44.google.com with SMTP id l14so3504722ybq.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2020 21:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gQx1O4i3ZrL+8FHNvLnh8t1v5SRwdDb4uqSCMA77DHk=;
        b=H6YyBttpxPK6Aw+eczVUy4cY3MYNYqutY9Dyv4mkVPaHdywuzy3Z/s6VDeCN3zaD59
         Y+ntoRKTdhzJpKx5csPGlPP+kZxhSHesxrmyGUBuQbcmc+Vui0udtu+fFn/WjiJc49G9
         yLMzbT1glrwC9LoZAp4qJCWbCm1BS6pRJwg2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gQx1O4i3ZrL+8FHNvLnh8t1v5SRwdDb4uqSCMA77DHk=;
        b=Vim2gwYE2y1HVjo4Xq1UCfqkB08ldmD5gfDKuY46MSK/B7T8Qe1VArbTw63SIwYqRj
         3biy2Y8adxbYP2o70tW2vfZ6S+9hqkWVsLSt68LPQqBAzNysn5Ug9bj00GYLRejGkVrE
         geUmHH/0z5BrhtVL5h0+D7UE79Vo9ajIicm05Te0ZcQkXk6R88oP5anokULFkGsQ2Vc4
         von5H2qvr/Vb4aR5eMDCaXc8y7FW3bm5oG2jQa/W++AQ/KtxtXqgJhkG1LgwKJL4kH57
         Rr3AKyv5myJhmlSI+ii6HdaULWpgNIywKajcUoY15y6S6iz9/TFzGs/UE/f3bDm+MTr9
         BrIA==
X-Gm-Message-State: AOAM532KJlT1FS+z/spngm/R7mKNiBvGhRUkTgOGBI20v8et47ap9NXF
        j/tIYupKMgHRXIompKiZI1YfQqQ/Mt2lN2hxIVvUzQ==
X-Google-Smtp-Source: ABdhPJxRGeaGCIdaZOcIzHbyPamkV8U5sivH6x49gcThVhqMWybJaVhHfbTDFyR226o479KxmPZKAnPvwibfvC6Fwmg=
X-Received: by 2002:a25:3792:: with SMTP id e140mr681258yba.277.1605244758745;
 Thu, 12 Nov 2020 21:19:18 -0800 (PST)
MIME-Version: 1.0
References: <20201109100343.3958378-1-chirantan@chromium.org>
 <20201109100343.3958378-3-chirantan@chromium.org> <CAJfpegv5DdgCqdtSzUS43P9JQeUg9fSyuRXETLNy47=cZyLtuQ@mail.gmail.com>
 <CAJFHJrqZMg6A_QnoOL3e5gNZtYquUPSr4B0ZLZMSKQH6o7sxag@mail.gmail.com> <CAJfpegsjeRSeabJK5xLr4g7mDkwT88u+iOnhwCj_78-HT+HVqA@mail.gmail.com>
In-Reply-To: <CAJfpegsjeRSeabJK5xLr4g7mDkwT88u+iOnhwCj_78-HT+HVqA@mail.gmail.com>
From:   Chirantan Ekbote <chirantan@chromium.org>
Date:   Fri, 13 Nov 2020 14:19:07 +0900
Message-ID: <CAJFHJroPwxB3EW+wFg=NgYsKiQAswd7MNm6Ha3jUAPdp6PMMsg@mail.gmail.com>
Subject: Re: [PATCH 2/2] fuse: Implement O_TMPFILE support
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Dylan Reid <dgreid@chromium.org>,
        Suleiman Souhlal <suleiman@chromium.org>,
        fuse-devel <fuse-devel@lists.sourceforge.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 10, 2020 at 4:52 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Tue, Nov 10, 2020 at 4:33 AM Chirantan Ekbote <chirantan@chromium.org> wrote:
>
> > That's not the behavior I observed.  Without this, the O_TMPFILE flag
> > gets passed through to the server.  The call stack is:
> >
> > - do_filp_open
> >     - path_openat
> >         - do_tmpfile
> >             - vfs_tmpfile
> >                 - dir->i_op->tmpfile
> >             - finish_open
> >                 - do_dentry_open
> >                     - f->f_op->open
> >
> > and I didn't see O_TMPFILE being removed anywhere in there.
>
> Ah, indeed.
>
> The reason I missed this is because IMO the way it *should* work is
> that FUSE_TMPFILE creates and opens the file in one go.  We shouldn't
> need two separate request.
>
> Not sure how we should go about this... The ->atomic_open() API is
> sufficient, but maybe we want a new ->atomic_tmpfile().
>

I think I agree with you that it should probably be a single request
but at this point is it worth adding an ->atomic_tmpfile() that's only
used by fuse?  Unlike regular file creation, it's not like the tmpfile
entry is accessible via any other mechanism so other than latency I
don't think there's any real harm with having it be 2 separate
requests.
