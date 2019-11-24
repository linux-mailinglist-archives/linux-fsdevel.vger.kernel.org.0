Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3F41084F8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2019 21:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfKXUuh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 24 Nov 2019 15:50:37 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:37194 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbfKXUuh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 24 Nov 2019 15:50:37 -0500
Received: by mail-yw1-f67.google.com with SMTP id 4so4289856ywx.4;
        Sun, 24 Nov 2019 12:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M4Jt5yrKDU8F2fIaLcOguP/vgGp0gQsaGqz7ufIEi6I=;
        b=B92UTXX4Hw1rzeudiYXCoNOuQZgp3UVkc9TtbiHLeSGlLVCFuslndr3L21sCWJNUZR
         g/QWNw5pmDRxoK4VUeNsGmwJEZchiOrkVuCCC/gJM3vtUqhCHwUls5oknpZeqTh0uatw
         UAlaSgHkiA8JHnP5zraksKljDfcwWsJG8lBHfN4OxyTfZTbDVhh49GPA5mPthgn3ByNu
         kqlh+6zT+qlz8vVTCc9O4geXC/XcxGZpKKrpHBfixBJCGr38/XE+/fqDDCH0OjNitW3n
         O3s86E4xilXD1gqif+ybEUbaxyXbKmfaw5dzD7k69l72soqSmq+t6K/lEyYyc7C9dAmp
         81Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M4Jt5yrKDU8F2fIaLcOguP/vgGp0gQsaGqz7ufIEi6I=;
        b=sFbw2WQKkQj4oWXnoUEiWojCxz3ffpA/+Iy2wU9iSUwaBqCqX7P1XxwDY2+YaOQO3e
         38bMe7hPkdmnwQftDVXqaXJUT72pJzq7Ujr0ofyun0+DBZKCGazOmFHI6Pk/DN/rts5D
         uEDWDfengJpTM3cNGfB2VxQju2jRxnLdeXKZaFuBge8INyMJFaFRPLYEbonyGhEDA6d/
         NqTHpIBgXEv2uLF3U9KPlvdS8JmH+o9LVFALwh05g8lmbASBv1Ml8xBSmZIq40/s9Xfa
         h5u1rPUbkUvfrtfRbe+FRycP6OF3trjtnxDMbeJsLozFle17y5sdaqbikjo3bHHinAXy
         UM8A==
X-Gm-Message-State: APjAAAWCuoUAHKoNHmXhlGmyroWPw9Y7mYZBB56JfAZQzuFOdpkpqzDp
        iEmCAjREQmrP4Ilcwlfn7rKymnD/HLNc6WxEYZTOBQ==
X-Google-Smtp-Source: APXvYqzLJipFAx0UYrDJ6Rm3/eyR3F9HzM7XHto0QkxHwcBc+WR9GbJhyiKDY7qRGKmt3yc+OD2/6mcxoCOWXLYsnzU=
X-Received: by 2002:a81:58c6:: with SMTP id m189mr17689201ywb.25.1574628634187;
 Sun, 24 Nov 2019 12:50:34 -0800 (PST)
MIME-Version: 1.0
References: <20191124193145.22945-1-amir73il@gmail.com> <20191124194934.GB4203@ZenIV.linux.org.uk>
In-Reply-To: <20191124194934.GB4203@ZenIV.linux.org.uk>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sun, 24 Nov 2019 22:50:23 +0200
Message-ID: <CAOQ4uxjsOM+th1f4=wss4SCrwueUYuVT0FKX0GxtmHBG2juw+A@mail.gmail.com>
Subject: Re: [PATCH] utimes: Clamp the timestamps in notify_change()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        y2038@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Nov 24, 2019 at 9:49 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Sun, Nov 24, 2019 at 09:31:45PM +0200, Amir Goldstein wrote:
> > Push clamping timestamps down the call stack into notify_change(), so
> > in-kernel callers like nfsd and overlayfs will get similar timestamp
> > set behavior as utimes.
>
> Makes sense; said that, shouldn't we go through ->setattr() instances and
> get rid of that there, now that notify_change() is made to do it?
>

Sounds reasonable. But I'd rather leave this cleanup to Deepa,
who did all this work.

Thanks,
Amir.
