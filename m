Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EABE2588CE8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Aug 2022 15:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235935AbiHCNZL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Aug 2022 09:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232747AbiHCNZJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Aug 2022 09:25:09 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 734C063E6
        for <linux-fsdevel@vger.kernel.org>; Wed,  3 Aug 2022 06:25:07 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id w3so5788979edc.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Aug 2022 06:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jYzl4q2ic/TrRCX7PyYhlSmLogyfWazL/VS52kuy5FE=;
        b=nb7XLLFTGAz0oeutrp7Xh9gF4057iIudmWItTrHmFX7bXaP+XKOR2XXmHh7SQinfsR
         Qs1FW6V2kjv5gwPNgWu6ksHUAlXniK0OCq+RyQKa+Uv/EbrQFeFBz+5GuyymGQkk+HMm
         YGjrF8dt+/EtF93Hck1Y6Kx48e5A2Vr1AkLa0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jYzl4q2ic/TrRCX7PyYhlSmLogyfWazL/VS52kuy5FE=;
        b=XwZ54nRN0YU8eNkiVuF+VPXh1ZwQsW4tPaAq+VFGtfGkLLWPUlozFuTDcV0pq9ha7Y
         tpr3YAIWaOLUZ+60V+inV1zM+U1LZLiutzkZvSYrHtc8kqpK/puRGMY1C/f4whoQkNu9
         yzFD7D1bL5h1KBx+YUdmvuu9NUo6V47LtoQk8gr4jX17Epmiaqn/EjFx0dIvS7ZUSAPA
         QHLsKde2yvGWRZ3nmOl8NC88NB2N/dV0Ak1/3vT3BMyMqPD6wlufWEn5iYPCeZWRTScS
         ebdNgC/+EMRcUUPPoxeq7Wd8510vNTrINLdpHvjea9Oe6dp6g4PI4bocpazrrRWe4M9X
         Kieg==
X-Gm-Message-State: AJIora97rrc7VbJTX6yalX01QOWNLUJ8coH6i4U0nKQFyuBuhRylcwZK
        mj5xhaYCrUbLQhDQSx6Ty68KOlEVG+IsWPinafWgAJW1EMu3Vw==
X-Google-Smtp-Source: AGRyM1vKu8oSwOjR3UkScxurfICGWlfs+QlMN8fI0xrWfAwM2V/dWPNXwFXFqi4NKFO+d0LH0e4kqr1Ip4eEKeB64AU=
X-Received: by 2002:a17:907:8a14:b0:72b:76d0:520 with SMTP id
 sc20-20020a1709078a1400b0072b76d00520mr19827250ejc.468.1659533094983; Wed, 03
 Aug 2022 06:24:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220802144236.1481779-1-mszeredi@redhat.com> <Yuk+32FgLeu6koHV@ZenIV>
 <YulCxLl76A/vsu4/@ZenIV>
In-Reply-To: <YulCxLl76A/vsu4/@ZenIV>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 3 Aug 2022 15:24:43 +0200
Message-ID: <CAJfpegvn=z_5FBAVQbdqQXU7eXAyCH=AMx-Ova+h=rNfYQXALA@mail.gmail.com>
Subject: Re: [PATCH] vfs_getxattr_alloc(): don't allocate buf on failure
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org,
        syzbot+942d5390db2d9624ced8@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2 Aug 2022 at 17:29, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Tue, Aug 02, 2022 at 04:12:31PM +0100, Al Viro wrote:
> > On Tue, Aug 02, 2022 at 04:42:36PM +0200, Miklos Szeredi wrote:
> > > Some callers of vfs_getxattr_alloc() assume that on failure the allocated
> > > buffer does not need to be freed.
> > >
> > > Callers could be fixed, but fixing the semantics of vfs_getxattr_alloc() is
> > > simpler and makes sure that this class of bugs does not occur again.
> > >
> > > Reported-and-tested-by: syzbot+942d5390db2d9624ced8@syzkaller.appspotmail.com
> > > Fixes: 1601fbad2b14 ("xattr: define vfs_getxattr_alloc and vfs_xattr_cmp")
> > > Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> > > ---
> > >  fs/xattr.c | 5 ++++-
> > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/fs/xattr.c b/fs/xattr.c
> > > index e8dd03e4561e..1800cfa97411 100644
> > > --- a/fs/xattr.c
> > > +++ b/fs/xattr.c
> > > @@ -383,7 +383,10 @@ vfs_getxattr_alloc(struct user_namespace *mnt_userns, struct dentry *dentry,
> > >     }
> > >
> > >     error = handler->get(handler, dentry, inode, name, value, error);
> > > -   *xattr_value = value;
> > > +   if (error < 0 && value != *xattr_value)
> > > +           kfree(value);
> > > +   else
> > > +           *xattr_value = value;
> > >     return error;
> > >  }
> >
> > Think what happens if it had been called with non-NULL *xattr_value,
> > found that it needed realloc, had krealloc() succeed (and free the
> > original), only to fail in ->get().
> >
> > Your variant will leave *xattr_value pointing to already freed
> > object, with no way for the caller to tell that from failure before
> > it got to krealloc().
> >
> > IOW, that's unusable for callers with preallocated buffer - in
> > particular, ones that call that thing in a loop.
>
> FWIW, if we change calling conventions so that in some cases caller
> need not kfree() whatever's in *xattr_value, about the only variant
> I see is to have the damn thing freed and replaced with NULL on
> *all* failure exits.  Might or might not make sense, not sure...

The minimal semantic change that would fix all buggy callers is to
change the non-loop case (i.e. when called only once with a
xattr_value pointing to NULL.

In the looping case callers correctly handle the error, since an
explicit kfree in the helper is unexpected.

Posted v2.

Thanks,
Miklos
