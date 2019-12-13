Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A02C011E06C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2019 10:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbfLMJPP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Dec 2019 04:15:15 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:36090 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbfLMJPP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Dec 2019 04:15:15 -0500
Received: by mail-il1-f193.google.com with SMTP id b15so1501581iln.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2019 01:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lhhQ4tcwmeQStYaNHbNoHSE/s07Lkdx+vy7ZqDxz9/I=;
        b=bqf2gMqMPcj2CdLdx4/7z4SGPeOe16t3NFwPGyEqAuIo3bArzFCAnXojgo9vOKILnZ
         X2SbwaIsIiPqYIwIin/JpANpYMRTtnqS8wQpGLp6fm5GFyV21XYAouJ3KIFZDZIJAPCK
         5Z5iqD+pbjGRfNLbDhwMl2nHCWEw66RArAP2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lhhQ4tcwmeQStYaNHbNoHSE/s07Lkdx+vy7ZqDxz9/I=;
        b=IjDP3RRi+08tKSphoh+iPp/+xyTkUluFdl74MfmttFLZGMVrEIhUuHiidGkZBqLZ+s
         m89Qm/M0dELWQ13p81tgokc38dIbV3bkMT5UtWVVqqgdHuDp0TcADJ6xyXBKcrB+8K5S
         S9PqhTqBkvRvDqRjO+0wADKYCh3EGyBI9eWMQ7+EAscrTZnNIm3RJXMTbIvnaGh9PPdU
         q5Uvx6hZczoo1DU8vno25rfCt7MXHCPcF7m4Gv5e9eiH1uk164SbPbZvrjy/008MCk7r
         GxSflY1Y1TSVzo+I018fBYy7HlgBTyHDOlXKvCYHnPX+fWQKT1Tm4+8qvCqP4ygiSpl8
         JP+Q==
X-Gm-Message-State: APjAAAX8yb+1mpiQkeaz6DyYY448Y+tPcNO+E4ix2AeIi1SyQtyRL1oh
        zuHRSRak1nEhX8PIliAg2E89cfKT/KozIX5zoqAjNA==
X-Google-Smtp-Source: APXvYqwWPwRORxqG4jy2Iy3LqhdqK/zZxkzDePZJrGA2tnSIAnlzo3+Euo5zMkZtXDIoAuSp7VdGG5IShMEUKkrcE/c=
X-Received: by 2002:a92:89c2:: with SMTP id w63mr12345010ilk.252.1576228514214;
 Fri, 13 Dec 2019 01:15:14 -0800 (PST)
MIME-Version: 1.0
References: <20191212145042.12694-1-labbott@redhat.com> <CAOi1vP9E2yLeFptg7o99usEi=x3kf=NnHYdURXPhX4vTXKCTCQ@mail.gmail.com>
 <fbe90a0b-cf24-8c0c-48eb-6183852dfbf1@redhat.com> <CAHk-=wh7Wuk9QCP6oH5Qc1a89_X6H1CHRK_OyB4NLmX7nRYJeA@mail.gmail.com>
 <cf4c9634-1503-d182-cb12-810fb969bc96@redhat.com> <20191212213609.GK4203@ZenIV.linux.org.uk>
In-Reply-To: <20191212213609.GK4203@ZenIV.linux.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 13 Dec 2019 10:15:03 +0100
Message-ID: <CAJfpegv_zY6w6=pOL0x=sjuQmGae0ymOafZXjyAdNEHj+EKyNA@mail.gmail.com>
Subject: Re: [PATCH] vfs: Don't reject unknown parameters
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Laura Abbott <labbott@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jeremi Piotrowski <jeremi.piotrowski@gmail.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 12, 2019 at 10:36 PM Al Viro <viro@zeniv.linux.org.uk> wrote:

> So you could bloody well just leave recognition (and handling) of "source"
> to the caller, leaving you with just this:
>
>         if (strcmp(param->key, "source") == 0)
>                 return -ENOPARAM;
>         /* Just log an error for backwards compatibility */
>         errorf(fc, "%s: Unknown parameter '%s'", fc->fs_type->name, param->key);
>         return 0;

Which is fine for the old mount(2) interface.

But we have a brand new API as well; do we really need to carry these
backward compatibility issues forward?  I mean checking if a
param/flag is supported or not *is* useful and lacking that check is
the source of numerous headaches in legacy interfaces (just take the
open(2) example and the introduction of O_TMPFILE).

Just need a flag in fc indicating if this option comes from the old interface:

         if (strcmp(param->key, "source") == 0)
                 return -ENOPARAM;
         /* Just log an error for backwards compatibility */
         errorf(fc, "%s: Unknown parameter '%s'", fc->fs_type->name,
param->key);
         return fc->legacy ? 0 : -ENOPARAM;

And TBH, I think that logic applies to the common flags as well.  Some
of these simply make no sense on the new interface ("silent",
"posixacl") and some are ignored for lots of filesystems ("sync",
"dirsync", "mand", "lazytime").  It would also be nice to reject "rw"
for read-only filesystems.

I have sent patches for the above numerous times, all been ignored by
DavidH and Al.  While this seems minor now, I think getting this
interface into a better shape as early as possible may save lots more
headaches later...

Thanks,
Miklos
