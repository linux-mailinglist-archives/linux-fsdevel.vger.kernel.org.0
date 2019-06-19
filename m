Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5524B947
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jun 2019 15:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbfFSNEQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jun 2019 09:04:16 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:38095 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727076AbfFSNEQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jun 2019 09:04:16 -0400
Received: by mail-yw1-f68.google.com with SMTP id k125so8255394ywe.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Jun 2019 06:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wOv7PVMBicvEw0F0bRcFZwOVzP5KqfTt5w2HsKbMclU=;
        b=rbomdq1c5/srtHT/Cl4WzktKGM23X9NMtSShTXbskgk9bPNwDEyjoZMH1N32JqZHys
         tOz4PmF2pX0PjgTBhK5g49EBz7nN0ZDZ3122J4VZGkFL+qUYqrRNhLhnvtfTx2x4R13h
         ucNetUBUqN11+CNKNEj71PBJ6eaMZIXkRaum5SNjH3a8Jcugvr+CyAR7is9AkfHk6cSc
         3z9dIp1bAcO8xoyQ2rU844J2cXhATlk/nmt60r1XE0ZcPlhne9KYqXPMkT06tYdnKnyp
         MHk8myMVc++nP+h+jzriynZVL1hwx/rXAQu6EsLomc+yddvCHSCZoiuCy9Ge5ViNMNzh
         +Ohw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wOv7PVMBicvEw0F0bRcFZwOVzP5KqfTt5w2HsKbMclU=;
        b=M3EzwEQHTkjdAJKGM0v3avk3fZ3Vf+1YDjBCW5igUK4uW23aZ0wNdnczoIJAo/vNUg
         jEF08BEBGZz36+0jj/2RJeC4//liBELdLFfmJC3H1Xj89q6Ypi+L7RNnOBV984oI3P8B
         c2K41gSjcOM48eT/O0HzBVvGOGeTdqcq81CWC15bQU+lm5qhrdxcRSYe5Ab7snx+G82A
         4hYFAy1vzcVIPqPpvyOTJX0qrMPA/4HUFtIX73dFOD4/QH65NN5MQNPrWiJIvK3wKslv
         PaiwWCaHe/3Y4kMBhDcydROnwV9I5ioAEVKI6tN9YTh83MgK93uglMDc17bMW1DhZq+9
         lggw==
X-Gm-Message-State: APjAAAVXqO5cgMByDStORpYG0RWn5SxihrTCvVZdeuw7ESwhaDUSs/Al
        vDdq0h+qdkzLZuCujcnrf6H7lzZm1z9tpU//sKDgh2cq
X-Google-Smtp-Source: APXvYqxEglqxgkolVpYnwnuW1yMv/49MIwM+peuqQO0Wtvk4yPWTx1bLT1CMg0jkjQ+YEiDFIm5CoQ+EMhANHLfxMyA=
X-Received: by 2002:a81:3956:: with SMTP id g83mr68014232ywa.183.1560949455363;
 Wed, 19 Jun 2019 06:04:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190619103444.26899-1-amir73il@gmail.com> <20190619125345.GG27954@quack2.suse.cz>
In-Reply-To: <20190619125345.GG27954@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 19 Jun 2019 16:04:04 +0300
Message-ID: <CAOQ4uxgYpB0ei4cTwD0C_XVi=fM1_eOO=taNBvgFgLiks1+7SQ@mail.gmail.com>
Subject: Re: [PATCH] fanotify: update connector fsid cache on add mark
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 19, 2019 at 3:53 PM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 19-06-19 13:34:44, Amir Goldstein wrote:
> > When implementing connector fsid cache, we only initialized the cache
> > when the first mark added to object was added by FAN_REPORT_FID group.
> > We forgot to update conn->fsid when the second mark is added by
> > FAN_REPORT_FID group to an already attached connector without fsid
> > cache.
> >
> > Reported-and-tested-by: syzbot+c277e8e2f46414645508@syzkaller.appspotmail.com
> > Fixes: 77115225acc6 ("fanotify: cache fsid in fsnotify_mark_connector")
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >
> > Jan,
> >
> > This fix has been confirmed by syzbot to fix the issue as well as
> > by my modification to Matthew's LTP test:
> > https://github.com/amir73il/ltp/commits/fanotify_dirent
>
> Thanks for the fix Amir. I somewhat don't like the additional flags field
> (which ends up growing fsnotify_mark_connector by one long) for just that
> one special flag. If nothing else, can't we just store the flag inside
> 'type'? There's plenty of space there...

I didn't think it mattered in the grand scheme of things, but
I did consider:
-        unsigned int type;      /* Type of object [lock] */
+        unsigned short type;      /* Type of object [lock] */
+#define FSNOTIFY_CONN_FLAG_HAS_FSID    0x01
+       unsigned short flags;     /* flags [lock] */

I think it makes sense.
Let me know if you want me to resend of if you can fix on commit.

Thanks,
Amir.
