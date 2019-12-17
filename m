Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E24D1233E1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2019 18:49:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbfLQRtQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Dec 2019 12:49:16 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56206 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726764AbfLQRtQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Dec 2019 12:49:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576604955;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wO1qMflxlmElp6VWAUkeNwtiS3C7c/h9/cKUd83moYw=;
        b=ZTil9rVhI/bmZUgqD3uK7Ib+obgH2KVotzl0umeyW/HnWFzhhSUUOHuI6KzA9onqrZ5br8
        0MX0fe3d9ZbP+K30cWSHGnNLXq/dlBsaCz8jfsYe3N4D3FzugDkbc3UenRRqyiaMBV/+zd
        o+YrxRCHhT1XZ8iaqzHW+KfKy9onAto=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-S3v4bJ6rObCwVamgrwtXhQ-1; Tue, 17 Dec 2019 12:49:11 -0500
X-MC-Unique: S3v4bJ6rObCwVamgrwtXhQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3FB79DC11;
        Tue, 17 Dec 2019 17:49:10 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-52.rdu2.redhat.com [10.10.120.52])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2453F2656B;
        Tue, 17 Dec 2019 17:49:07 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAJfpegv_zY6w6=pOL0x=sjuQmGae0ymOafZXjyAdNEHj+EKyNA@mail.gmail.com>
References: <CAJfpegv_zY6w6=pOL0x=sjuQmGae0ymOafZXjyAdNEHj+EKyNA@mail.gmail.com> <20191212145042.12694-1-labbott@redhat.com> <CAOi1vP9E2yLeFptg7o99usEi=x3kf=NnHYdURXPhX4vTXKCTCQ@mail.gmail.com> <fbe90a0b-cf24-8c0c-48eb-6183852dfbf1@redhat.com> <CAHk-=wh7Wuk9QCP6oH5Qc1a89_X6H1CHRK_OyB4NLmX7nRYJeA@mail.gmail.com> <cf4c9634-1503-d182-cb12-810fb969bc96@redhat.com> <20191212213609.GK4203@ZenIV.linux.org.uk>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     dhowells@redhat.com, Al Viro <viro@zeniv.linux.org.uk>,
        Laura Abbott <labbott@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeremi Piotrowski <jeremi.piotrowski@gmail.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vfs: Don't reject unknown parameters
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <32252.1576604947.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 17 Dec 2019 17:49:07 +0000
Message-ID: <32253.1576604947@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Miklos Szeredi <miklos@szeredi.hu> wrote:

> > So you could bloody well just leave recognition (and handling) of "sou=
rce"
> > to the caller, leaving you with just this:
> >
> >         if (strcmp(param->key, "source") =3D=3D 0)
> >                 return -ENOPARAM;
> >         /* Just log an error for backwards compatibility */
> >         errorf(fc, "%s: Unknown parameter '%s'", fc->fs_type->name, pa=
ram->key);
> >         return 0;
> =

> Which is fine for the old mount(2) interface.
> =

> But we have a brand new API as well; do we really need to carry these
> backward compatibility issues forward?  I mean checking if a
> param/flag is supported or not *is* useful and lacking that check is
> the source of numerous headaches in legacy interfaces (just take the
> open(2) example and the introduction of O_TMPFILE).

The problem with what you're suggesting is that you can't then make
/sbin/mount to use the new syscalls because that would change userspace
behaviour - unless you either teach /sbin/mount which filesystems discard
which errors from unrecognised options or pass a flag to the kernel to shi=
ft
into or out of 'strict' mode.

David


