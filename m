Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E70AA4287C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2019 16:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407342AbfFLOM3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jun 2019 10:12:29 -0400
Received: from mail180-16.suw31.mandrillapp.com ([198.2.180.16]:45802 "EHLO
        mail180-16.suw31.mandrillapp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729455AbfFLOM3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jun 2019 10:12:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=mandrill; d=nexedi.com;
 h=From:Subject:To:Cc:Message-Id:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding; i=kirr@nexedi.com;
 bh=CjNAq5zk83vG6ZLEovRMcdvyAIrKbCVDFfqUl9xCWCg=;
 b=FziY4W+YP89SkqefJQT7Ywsih9Y+CkTucoZkCgT8aMmB2UlpIz9bocA72LlrvttwU6RLPEjVZqGi
   TWPSRTiaJlpsN9XfcAr5A81Fv/9/Yj8KDc9pFYfizSNTInwwd3bX3Dp3msdXCSCdzpOlp8WFMtHK
   XNN+CbbQzZ7MKAPHQM0=
Received: from pmta03.mandrill.prod.suw01.rsglab.com (127.0.0.1) by mail180-16.suw31.mandrillapp.com id h0444o22sc0t for <linux-fsdevel@vger.kernel.org>; Wed, 12 Jun 2019 14:12:27 +0000 (envelope-from <bounce-md_31050260.5d01084b.v1-408142de23d144b0a4fca9f4262d124e@mandrillapp.com>)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com; 
 i=@mandrillapp.com; q=dns/txt; s=mandrill; t=1560348747; h=From : 
 Subject : To : Cc : Message-Id : References : In-Reply-To : Date : 
 MIME-Version : Content-Type : Content-Transfer-Encoding : From : 
 Subject : Date : X-Mandrill-User : List-Unsubscribe; 
 bh=CjNAq5zk83vG6ZLEovRMcdvyAIrKbCVDFfqUl9xCWCg=; 
 b=GNeJ8UcvkYLnolN14cVeeRXPweAaNyLeFmuimlh58slgybiZ5wZZK90Ms6xqWPB3iZow9O
 jb67EGtCvGfTWetT+PfRkXnxHhKoPKRFoZ6olzyxGV5eaV5mJJyV12WOLd0GdKpnMhzF1hsa
 8rmDwD550hAba0jTkAbKWxBN8MVUY=
From:   Kirill Smelkov <kirr@nexedi.com>
Subject: Re: [PATCH] fuse: require /dev/fuse reads to have enough buffer capacity (take 2)
Received: from [87.98.221.171] by mandrillapp.com id 408142de23d144b0a4fca9f4262d124e; Wed, 12 Jun 2019 14:12:27 +0000
To:     Sander Eikelenboom <linux@eikelenboom.it>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        <gluster-devel@gluster.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Message-Id: <20190612141220.GA25389@deco.navytux.spb.ru>
References: <876aefd0-808a-bb4b-0897-191f0a8d9e12@eikelenboom.it> <CAJfpegvRBm3M8fUJ1Le1dPd0QSJgAWAYJGLCQKa6YLTE+4oucw@mail.gmail.com> <20190611202738.GA22556@deco.navytux.spb.ru> <CAOssrKfj-MDujX0_t_fgobL_KwpuG2fxFmT=4nURuJA=sUvYYg@mail.gmail.com> <20190612112544.GA21465@deco.navytux.spb.ru> <f31ca7b5-0c9b-5fde-6a75-967265de67c6@eikelenboom.it>
In-Reply-To: <f31ca7b5-0c9b-5fde-6a75-967265de67c6@eikelenboom.it>
X-Report-Abuse: Please forward a copy of this message, including all headers, to abuse@mandrill.com
X-Report-Abuse: You can also report abuse here: http://mandrillapp.com/contact/abuse?id=31050260.408142de23d144b0a4fca9f4262d124e
X-Mandrill-User: md_31050260
Date:   Wed, 12 Jun 2019 14:12:27 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 12, 2019 at 03:03:49PM +0200, Sander Eikelenboom wrote:
> On 12/06/2019 13:25, Kirill Smelkov wrote:
> > On Wed, Jun 12, 2019 at 09:44:49AM +0200, Miklos Szeredi wrote:
> >> On Tue, Jun 11, 2019 at 10:28 PM Kirill Smelkov <kirr@nexedi.com> wrot=
e:
> >>
> >>> Miklos, would 4K -> `sizeof(fuse_in_header) + sizeof(fuse_write_in)` =
for
> >>> header room change be accepted?
> >>
> >> Yes, next cycle.   For 4.2 I'll just push the revert.
> > 
> > Thanks Miklos. Please consider queuing the following patch for 5.3.
> > Sander, could you please confirm that glusterfs is not broken with this
> > version of the check?
> > 
> > Thanks beforehand,
> > Kirill
> 
> 
> Hmm unfortunately it doesn't build, see below.
> [...]
> fs/fuse/dev.c:1336:14: error: =E2=80=98fuse_in_header=E2=80=99 undeclared=
 (first use in this function)
>        sizeof(fuse_in_header) + sizeof(fuse_write_in) + fc->max_write))

Sorry, my bad, it was missing "struct" before fuse_in_header. I
originally compile-tested the patch with `make -j4`, was distracted onto
other topic and did not see the error after returning due to long tail
of successful CC lines. Apologize for the inconvenience. Below is a
fixed patch that was both compile-tested and runtime-tested with my FUSE
workloads (non-glusterfs).

Kirill

---- 8< ----
From 98fd29bb6789d5f6c346274b99d47008ad856607 Mon Sep 17 00:00:00 2001
From: Kirill Smelkov <kirr@nexedi.com>
Date: Wed, 12 Jun 2019 17:06:18 +0300
Subject: [PATCH v2] fuse: require /dev/fuse reads to have enough buffer cap=
acity (take 2)

[ This retries commit d4b13963f217 which was reverted in 766741fcaa1f.

  In this version we require only `sizeof(fuse_in_header) + sizeof(fuse_wri=
te_in)`
  instead of 4K for FUSE request header room, because, contrary to
  libfuse and kernel client behaviour, GlusterFS actually provides only
  so much room for request header. ]

A FUSE filesystem server queues /dev/fuse sys_read calls to get
filesystem requests to handle. It does not know in advance what would be
that request as it can be anything that client issues - LOOKUP, READ,
WRITE, ... Many requests are short and retrieve data from the
filesystem. However WRITE and NOTIFY_REPLY write data into filesystem.

Before getting into operation phase, FUSE filesystem server and kernel
client negotiate what should be the maximum write size the client will
ever issue. After negotiation the contract in between server/client is
that the filesystem server then should queue /dev/fuse sys_read calls with
enough buffer capacity to receive any client request - WRITE in
particular, while FUSE client should not, in particular, send WRITE
requests with > negotiated max_write payload. FUSE client in kernel and
libfuse historically reserve 4K for request header. However an existing
filesystem server - GlusterFS - was found which reserves only 80 bytes
for header room (=3D `sizeof(fuse_in_header) + sizeof(fuse_write_in)`).

https://lore.kernel.org/linux-fsdevel/20190611202738.GA22556@deco.navytux.s=
pb.ru/
https://github.com/gluster/glusterfs/blob/v3.8.15-0-gd174f021a/xlators/moun=
t/fuse/src/fuse-bridge.c#L4894

Since

=09`sizeof(fuse_in_header) + sizeof(fuse_write_in)` =3D=3D
=09`sizeof(fuse_in_header) + sizeof(fuse_read_in)`  =3D=3D
=09`sizeof(fuse_in_header) + sizeof(fuse_notify_retrieve_in)`

is the absolute minimum any sane filesystem should be using for header
room, the contract is that filesystem server should queue sys_reads with
`sizeof(fuse_in_header) + sizeof(fuse_write_in)` + max_write buffer.

If the filesystem server does not follow this contract, what can happen
is that fuse_dev_do_read will see that request size is > buffer size,
and then it will return EIO to client who issued the request but won't
indicate in any way that there is a problem to filesystem server.
This can be hard to diagnose because for some requests, e.g. for
NOTIFY_REPLY which mimics WRITE, there is no client thread that is
waiting for request completion and that EIO goes nowhere, while on
filesystem server side things look like the kernel is not replying back
after successful NOTIFY_RETRIEVE request made by the server.

We can make the problem easy to diagnose if we indicate via error return to
filesystem server when it is violating the contract.  This should not
practically cause problems because if a filesystem server is using shorter
buffer, writes to it were already very likely to cause EIO, and if the
filesystem is read-only it should be too following FUSE_MIN_READ_BUFFER
minimum buffer size.

Please see [1] for context where the problem of stuck filesystem was hit
for real (because kernel client was incorrectly sending more than
max_write data with NOTIFY_REPLY; see also previous patch), how the
situation was traced and for more involving patch that did not make it
into the tree.

[1] https://marc.info/?l=3Dlinux-fsdevel&m=3D155057023600853&w=3D2

Signed-off-by: Kirill Smelkov <kirr@nexedi.com>
Cc: Han-Wen Nienhuys <hanwen@google.com>
Cc: Jakob Unterwurzacher <jakobunt@gmail.com>
---
 fs/fuse/dev.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index ea8237513dfa..b2b2344eadcf 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1317,6 +1317,26 @@ static ssize_t fuse_dev_do_read(struct fuse_dev *fud=
, struct file *file,
 =09unsigned reqsize;
 =09unsigned int hash;
 
+=09/*
+=09 * Require sane minimum read buffer - that has capacity for fixed part
+=09 * of any request header + negotiated max_write room for data. If the
+=09 * requirement is not satisfied return EINVAL to the filesystem server
+=09 * to indicate that it is not following FUSE server/client contract.
+=09 * Don't dequeue / abort any request.
+=09 *
+=09 * Historically libfuse reserves 4K for fixed header room, but e.g.
+=09 * GlusterFS reserves only 80 bytes
+=09 *
+=09 *=09=3D `sizeof(fuse_in_header) + sizeof(fuse_write_in)`
+=09 *
+=09 * which is the absolute minimum any sane filesystem should be using
+=09 * for header room.
+=09 */
+=09if (nbytes < max_t(size_t, FUSE_MIN_READ_BUFFER,
+=09=09=09   sizeof(struct fuse_in_header) + sizeof(struct fuse_write_in) +
+=09=09=09=09fc->max_write))
+=09=09return -EINVAL;
+
  restart:
 =09spin_lock(&fiq->waitq.lock);
 =09err =3D -EAGAIN;
-- 
2.20.1

