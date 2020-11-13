Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4F182B1CBC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Nov 2020 14:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbgKMNy7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Nov 2020 08:54:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbgKMNy6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Nov 2020 08:54:58 -0500
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 058B6C0613D1
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2020 05:54:58 -0800 (PST)
Received: by mail-vs1-xe44.google.com with SMTP id z123so5240753vsb.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2020 05:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MzyuFGFAEl0SqGEx5Ds16+rNu416H174NpUD7uDreDo=;
        b=E6MhJsb2kYnAwltuHkXGBWkBMzhBXhlNnxVFnih4UkdIEmv1Ah5877MUxARzPPpA8b
         it7q4/L/krMvIDaToXGIA8cIUTZxezAO0bwIa+nWvS60vlUbmk/KkDJTiHdPL61VMiCM
         3F+kkRXHrvaH8MNLNI3aaKycGIgIFBtZEiFPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MzyuFGFAEl0SqGEx5Ds16+rNu416H174NpUD7uDreDo=;
        b=phxUazeLqv9OTjvqIE9kEvWTcee6z/Zt7tpZzO03T5oWixdsJC6Tc5ZZZwZhFCzaOq
         T6cLctiTz0oOq2MWNZvQ0KH8v/EADHlEpTmRFVoDxu2XwOjD5aEA8Tp4XX6owuk4KN79
         q85jT9li0WPjIS07P7b4Ql3mEaKi5ub20ULqQKT2Qbm12nyYOzNWht07Rtp62kQzupak
         2zLY3fD44bKvxTCCsHOSDdX3K/8qw0T2VuvDqOs1CECzh6dGJpg+Yp9eqKibsca3XHwy
         lVCWH9zofhOWoShRdY81vmH/RSxMTGne+YEToX7JFFDJYF3JcHEKsUryB6pCpEVlFN+3
         gVtg==
X-Gm-Message-State: AOAM532WCLV8t6TY84BcBE4l1eo2ZoXbC6dkncSutuczOqM4UpFr27XQ
        y9yFWsRB+18vBCho56vNj8Cpi8uESzVE+cyTQwWZxg==
X-Google-Smtp-Source: ABdhPJy4ZWNqIru0TtUBfQK9+6Bzpu/3dIgRwPD6KMT6JmZEMQ001BiY5MlGbny81V7iD8c/+24ESVj0fK3A/nqYLX0=
X-Received: by 2002:a05:6102:3203:: with SMTP id r3mr1047638vsf.21.1605275697236;
 Fri, 13 Nov 2020 05:54:57 -0800 (PST)
MIME-Version: 1.0
References: <20201109100343.3958378-1-chirantan@chromium.org>
 <20201109100343.3958378-3-chirantan@chromium.org> <CAJfpegv5DdgCqdtSzUS43P9JQeUg9fSyuRXETLNy47=cZyLtuQ@mail.gmail.com>
 <CAJFHJrqZMg6A_QnoOL3e5gNZtYquUPSr4B0ZLZMSKQH6o7sxag@mail.gmail.com>
 <CAJfpegsjeRSeabJK5xLr4g7mDkwT88u+iOnhwCj_78-HT+HVqA@mail.gmail.com>
 <CAJFHJroPwxB3EW+wFg=NgYsKiQAswd7MNm6Ha3jUAPdp6PMMsg@mail.gmail.com>
 <CAJfpegv4X2m=-N69iB+Q_6fneeX_0uMNyzkVqfU+qQXdqXSUNw@mail.gmail.com> <20201113122845.GG3576660@ZenIV.linux.org.uk>
In-Reply-To: <20201113122845.GG3576660@ZenIV.linux.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 13 Nov 2020 14:54:46 +0100
Message-ID: <CAJfpegvsCQ+rJv2rSk3mUMsX_N26ardW=MYbHxifO5DU7uSYqA@mail.gmail.com>
Subject: Re: [PATCH 2/2] fuse: Implement O_TMPFILE support
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Chirantan Ekbote <chirantan@chromium.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Dylan Reid <dgreid@chromium.org>,
        Suleiman Souhlal <suleiman@chromium.org>,
        fuse-devel <fuse-devel@lists.sourceforge.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 13, 2020 at 1:28 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Fri, Nov 13, 2020 at 11:52:09AM +0100, Miklos Szeredi wrote:
>
> > It's the wrong interface, and we'll have to live with it forever if we
> > go this route.
> >
> > Better get the interface right and *then* think about the
> > implementation.  I don't think adding ->atomic_tmpfile() would be that
> > of a big deal, and likely other distributed fs would start using it in
> > the future.
>
> Let me think about it; I'm very unhappy with the amount of surgery it has
> taken to somewhat sanitize the results of ->atomic_open() introduction, so
> I'd prefer to do it reasonably clean or not at all.

The minimal VFS change for fuse to be able to do tmpfile with one
request would be to pass open_flags to ->tmpfile().  That way the
private data for the open file would need to be temporarily stored in
the inode and ->open() would just pick it up from there without
sending another request.  Not the cleanest, but I really don't care as
long as the public interface is the right one.

Thanks,
Miklos
