Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 611C2165C5E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2020 12:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbgBTLEF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Feb 2020 06:04:05 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:52472 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726825AbgBTLEF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Feb 2020 06:04:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582196643;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HMa4koWyLSARu7hw4Wcnh7n2N//Bgrplr2DvnwxKML0=;
        b=GAOxrJoB7D27RTrlwA+hvHrDp2oqzGXEDSlqAPnZpZRF5pAqBV6shkH2RLSq+XV8mt/cWn
        cHkd/QaUl540VkAQYeOtYu5RAQZZ+07hk5lntzcS+kWeeXGa7+FzLdJ312FvKVW0Y7DSBR
        EXUeD80o5Q9bYy2TI+tgVAXq4B9oIzI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-141-CG_I3geeMzGOISkcw0L_kg-1; Thu, 20 Feb 2020 06:04:01 -0500
X-MC-Unique: CG_I3geeMzGOISkcw0L_kg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B27C8800D48;
        Thu, 20 Feb 2020 11:03:59 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-122-163.rdu2.redhat.com [10.10.122.163])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B12AF5DA60;
        Thu, 20 Feb 2020 11:03:57 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAG48ez0o3iHjQJNvh8V2Ao77g0CqfqGsv6caMCOFDy7w-VdtkQ@mail.gmail.com>
References: <CAG48ez0o3iHjQJNvh8V2Ao77g0CqfqGsv6caMCOFDy7w-VdtkQ@mail.gmail.com> <158204549488.3299825.3783690177353088425.stgit@warthog.procyon.org.uk> <158204550281.3299825.6344518327575765653.stgit@warthog.procyon.org.uk>
To:     Jann Horn <jannh@google.com>
Cc:     dhowells@redhat.com, Al Viro <viro@zeniv.linux.org.uk>,
        raven@themaw.net, Miklos Szeredi <mszeredi@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/19] vfs: syscall: Add fsinfo() to query filesystem information [ver #16]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <584178.1582196636.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Thu, 20 Feb 2020 11:03:56 +0000
Message-ID: <584179.1582196636@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jann Horn <jannh@google.com> wrote:

> > +int fsinfo_string(const char *s, struct fsinfo_context *ctx)
> ...
> Please add a check here to ensure that "ret" actually fits into the
> buffer (and use WARN_ON() if you think the check should never fire).
> Otherwise I think this is too fragile.

How about:

	int fsinfo_string(const char *s, struct fsinfo_context *ctx)
	{
		unsigned int len;
		char *p =3D ctx->buffer;
		int ret =3D 0;
		if (s) {
			len =3D strlen(s);
			if (len > ctx->buf_size - 1)
				len =3D ctx->buf_size;
			if (!ctx->want_size_only) {
				memcpy(p, s, len);
				p[len] =3D 0;
			}
			ret =3D len;
		}
		return ret;
	}

I've also added a check to eliminate the copy if userspace didn't actually
supply a buffer.

> > +       ret =3D vfs_statfs(path, &buf);
> > +       if (ret < 0 && ret !=3D -ENOSYS)
> > +               return ret;
> ...
> > +       memcpy(&p->f_fsid, &buf.f_fsid, sizeof(p->f_fsid));
> =

> What's going on here? If vfs_statfs() returns -ENOSYS, we just use the
> (AFAICS uninitialized) buf.f_fsid anyway in the memcpy() below and
> return it to userspace?

Good point.  I've made the access to the buffer contingent on ret=3D=3D0. =
 If I
don't set it, it will just be left pre-cleared.

> > +       return sizeof(*attr);
> =

> I think you meant sizeof(*info).

Yes.  I've renamed the buffer point to "p" in all cases so that it's more
obvious.

> > +       return ctx->usage;
> =

> It is kind of weird that you have to return the ctx->usage everywhere
> even though the caller already has ctx...

At this point, it's only used and returned by fsinfo_attributes() and real=
ly
is only for the use of the attribute getter function.

I could, I suppose, return the amount of data in ctx->usage and then prese=
t it
for VSTRUCT-type objects.  Unfortunately, I can't make the getter return v=
oid
since it might have to return an error.

> > +               ctx->buffer =3D kvmalloc(ctx->buf_size, GFP_KERNEL);
> =

> ctx->buffer is _almost_ always pre-zeroed (see vfs_do_fsinfo() below),
> except if we have FSINFO_TYPE_OPAQUE or FSINFO_TYPE_LIST with a size
> bigger than what the attribute's ->size field said? Is that
> intentional?

Fixed.

> > +struct fsinfo_attribute {
> > +       unsigned int            attr_id;        /* The ID of the attri=
bute */
> > +       enum fsinfo_value_type  type:8;         /* The type of the att=
ribute's value(s) */
> > +       unsigned int            flags:8;
> > +       unsigned int            size:16;        /* - Value size (FSINF=
O_STRUCT) */
> > +       unsigned int            element_size:16; /* - Element size (FS=
INFO_LIST) */
> > +       int (*get)(struct path *path, struct fsinfo_context *params);
> > +};
> =

> Why the bitfields? It doesn't look like that's going to help you much,
> you'll just end up with 6 bytes of holes on x86-64:

Expanding them to non-bitfields will require an extra 10 bytes, making the
struct 8 bytes bigger with 4 bytes of padding.  I can do that if you'd rat=
her.

David

