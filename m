Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B25A616601E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2020 15:55:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728419AbgBTOyy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Feb 2020 09:54:54 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38927 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728409AbgBTOyx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Feb 2020 09:54:53 -0500
Received: by mail-ot1-f66.google.com with SMTP id 77so3882016oty.6
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Feb 2020 06:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UmzmFkPjCuGBaCDC2J5E9Q9j03PnI6HdFcXUuBD5/TU=;
        b=wJAOkl5DhW5ltYAytZ3UeR8ZVsjpxC5WJLYJXFPCOSwgAQtg3OX7P4ojn1gKMvFkAf
         A1P9Nl3SgGwCSOqwsStyfCXicx4iRruvmDpDxMpaEFRFTIXPMwyq2ppqzH29EY+Atz7n
         VZ4SRCYZnms43dn5PGkBmkuGPupGO2e2ERVuer6o7oQsVoAozhe0Nq61jCPL+eWuS/mA
         ckAuP6Z0hXuTSKZoZ191U0xjCMO4Kok63NzBJx0z932uf+yjw94fPg2QUYFdjyjPvU9z
         DQC/+tuFsHPl3AzcPC27Q9cI49rDFxbtOpHHDog9x7pKFgS4g/68KPAAvs0KDOdXqvck
         X/mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UmzmFkPjCuGBaCDC2J5E9Q9j03PnI6HdFcXUuBD5/TU=;
        b=FAfi2/gZJJYQxQ3I5XsHBfEQs70cXiUDsObc3XvZTkEkIpDXkRCIqHIgAaPbWOXPyA
         8Ljymm0di+KqGDBnmvbKVu26HzwpnNC5bQ1Zw24uNgkFCoS5tNQRd1jkS6CKsBrq1p7C
         pb8c46FtMQe398u9Ca8x/u95FiUa/BGcpKROsG8Q6QU6ew8kvqKmiyVnK07GsrnYR0sU
         NMqtXPa1A7JwkKSorWp6rsnj4XDtcZGsG2bCDZa159ch9yjb9Km6kbgraEqFzbtT5AM9
         xi1qxiiJWkmLwO4jf4UgIxbNj235MpPwzcTerDUo8i2GDPW+BzuUsM5pDci0tLY/+wd8
         mHlA==
X-Gm-Message-State: APjAAAUSZ8wY8u0SR7T03GlR0wQawT7F0xA27DJIU/F8QiEBb8idGkMz
        zm3Om8gf4+KTcpNe4Gwj4+PGtgtslnJlCPrBQ+PGAw==
X-Google-Smtp-Source: APXvYqyUVQt81DtB/0rrPhX/8feTQLhMBsEKNm27cSmXNSmmbP94300Qc1MMAygvmZVsVX8XoNGexNlRTiv2fuuBJs4=
X-Received: by 2002:a05:6830:1d6e:: with SMTP id l14mr23301953oti.32.1582210491228;
 Thu, 20 Feb 2020 06:54:51 -0800 (PST)
MIME-Version: 1.0
References: <158204549488.3299825.3783690177353088425.stgit@warthog.procyon.org.uk>
 <158204550281.3299825.6344518327575765653.stgit@warthog.procyon.org.uk>
 <CAG48ez0o3iHjQJNvh8V2Ao77g0CqfqGsv6caMCOFDy7w-VdtkQ@mail.gmail.com> <584179.1582196636@warthog.procyon.org.uk>
In-Reply-To: <584179.1582196636@warthog.procyon.org.uk>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 20 Feb 2020 15:54:25 +0100
Message-ID: <CAG48ez00KA3tjeccDCeqmgHyppTLEr+UkrB=QaQ-FX-cTY3aCA@mail.gmail.com>
Subject: Re: [PATCH 01/19] vfs: syscall: Add fsinfo() to query filesystem
 information [ver #16]
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, raven@themaw.net,
        Miklos Szeredi <mszeredi@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 20, 2020 at 12:04 PM David Howells <dhowells@redhat.com> wrote:
> Jann Horn <jannh@google.com> wrote:
>
> > > +int fsinfo_string(const char *s, struct fsinfo_context *ctx)
> > ...
> > Please add a check here to ensure that "ret" actually fits into the
> > buffer (and use WARN_ON() if you think the check should never fire).
> > Otherwise I think this is too fragile.
>
> How about:
>
>         int fsinfo_string(const char *s, struct fsinfo_context *ctx)
>         {
>                 unsigned int len;
>                 char *p = ctx->buffer;
>                 int ret = 0;
>                 if (s) {
>                         len = strlen(s);
>                         if (len > ctx->buf_size - 1)
>                                 len = ctx->buf_size;
>                         if (!ctx->want_size_only) {
>                                 memcpy(p, s, len);
>                                 p[len] = 0;

I think this is off-by-one? If len was too big, it is set to
ctx->buf_size, so in that case this effectively becomes
`ctx->buffer[ctx->buf_size] = 0`, which is one byte out of bounds,
right?

Maybe use something like `len = min_t(size_t, strlen(s), ctx->buf_size-1)` ?

Looks good apart from that, I think.

>                         }
>                         ret = len;
>                 }
>                 return ret;
>         }
[...]
> > > +       return ctx->usage;
> >
> > It is kind of weird that you have to return the ctx->usage everywhere
> > even though the caller already has ctx...
>
> At this point, it's only used and returned by fsinfo_attributes() and really
> is only for the use of the attribute getter function.
>
> I could, I suppose, return the amount of data in ctx->usage and then preset it
> for VSTRUCT-type objects.  Unfortunately, I can't make the getter return void
> since it might have to return an error.

Yeah, then you'd be passing around the error separately from the
length... I don't know whether that'd make things better or worse.

[...]
> > > +struct fsinfo_attribute {
> > > +       unsigned int            attr_id;        /* The ID of the attribute */
> > > +       enum fsinfo_value_type  type:8;         /* The type of the attribute's value(s) */
> > > +       unsigned int            flags:8;
> > > +       unsigned int            size:16;        /* - Value size (FSINFO_STRUCT) */
> > > +       unsigned int            element_size:16; /* - Element size (FSINFO_LIST) */
> > > +       int (*get)(struct path *path, struct fsinfo_context *params);
> > > +};
> >
> > Why the bitfields? It doesn't look like that's going to help you much,
> > you'll just end up with 6 bytes of holes on x86-64:
>
> Expanding them to non-bitfields will require an extra 10 bytes, making the
> struct 8 bytes bigger with 4 bytes of padding.  I can do that if you'd rather.

Wouldn't this still have the same total size?

struct fsinfo_attribute {
  unsigned int attr_id;        /* 0x0-0x3 */
  enum fsinfo_value_type type; /* 0x4-0x7 */
  u8 flags;                    /* 0x8-0x8 */
  /* 1-byte hole */
  u16 size;                    /* 0xa-0xb */
  u16 element_size;            /* 0xc-0xd */
  /* 2-byte hole */
  int (*get)(...);             /* 0x10-0x18 */
};

But it's not like I really care about this detail all that much, feel
free to leave it as-is.
