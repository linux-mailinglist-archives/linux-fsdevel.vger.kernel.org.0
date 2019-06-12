Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1C18423F3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2019 13:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409002AbfFLLZy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jun 2019 07:25:54 -0400
Received: from mail177-30.suw61.mandrillapp.com ([198.2.177.30]:48153 "EHLO
        mail177-30.suw61.mandrillapp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2406101AbfFLLZy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jun 2019 07:25:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=mandrill; d=nexedi.com;
 h=From:Subject:To:Cc:Message-Id:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding; i=kirr@nexedi.com;
 bh=cA3R4pJB9551xrjuB8IzZ/Uxj/3WlOh0i4J4iLjSJrM=;
 b=Y3Sy90pb1uO0Yn9uQG63fUB/ZAaEuC6rKByF1SCvOoN1YIl5Q4iNwKDKi8IsOESxdYjW4RXXw/TY
   DbqlSCJKD7vI+YoR3oJBIshsfhF5sXNtck7RvMNSdsWxEudv5xqzisKb7UEa97/AcdfFuomENrf2
   uOwtBVAQe+WOvrywVBE=
Received: from pmta06.mandrill.prod.suw01.rsglab.com (127.0.0.1) by mail177-30.suw61.mandrillapp.com id h03gk022rtk4 for <linux-fsdevel@vger.kernel.org>; Wed, 12 Jun 2019 11:25:52 +0000 (envelope-from <bounce-md_31050260.5d00e140.v1-57b49a64cca4495783e17ad3be2e3430@mandrillapp.com>)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com; 
 i=@mandrillapp.com; q=dns/txt; s=mandrill; t=1560338752; h=From : 
 Subject : To : Cc : Message-Id : References : In-Reply-To : Date : 
 MIME-Version : Content-Type : Content-Transfer-Encoding : From : 
 Subject : Date : X-Mandrill-User : List-Unsubscribe; 
 bh=cA3R4pJB9551xrjuB8IzZ/Uxj/3WlOh0i4J4iLjSJrM=; 
 b=pq/KdzLUtAYK2PeY9Qo5jY0mZCKnkJ5Qq28pQCj+uSWfKNKPRo2GPWmdoaQwUSZyWMxt+J
 sNGzMCeIy4kZK/v8ixZ4sPy74n+e2WbmYnzoAWkx+Aw6xa6vHmDFc5K4wH040FRFVB6u/oVG
 /IXQQezWSJYiwxgZ4mbC3twqkfXeI=
From:   Kirill Smelkov <kirr@nexedi.com>
Subject: [PATCH] fuse: require /dev/fuse reads to have enough buffer capacity (take 2)
Received: from [87.98.221.171] by mandrillapp.com id 57b49a64cca4495783e17ad3be2e3430; Wed, 12 Jun 2019 11:25:52 +0000
To:     Miklos Szeredi <mszeredi@redhat.com>,
        Sander Eikelenboom <linux@eikelenboom.it>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, <gluster-devel@gluster.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Message-Id: <20190612112544.GA21465@deco.navytux.spb.ru>
References: <876aefd0-808a-bb4b-0897-191f0a8d9e12@eikelenboom.it> <CAJfpegvRBm3M8fUJ1Le1dPd0QSJgAWAYJGLCQKa6YLTE+4oucw@mail.gmail.com> <20190611202738.GA22556@deco.navytux.spb.ru> <CAOssrKfj-MDujX0_t_fgobL_KwpuG2fxFmT=4nURuJA=sUvYYg@mail.gmail.com>
In-Reply-To: <CAOssrKfj-MDujX0_t_fgobL_KwpuG2fxFmT=4nURuJA=sUvYYg@mail.gmail.com>
X-Report-Abuse: Please forward a copy of this message, including all headers, to abuse@mandrill.com
X-Report-Abuse: You can also report abuse here: http://mandrillapp.com/contact/abuse?id=31050260.57b49a64cca4495783e17ad3be2e3430
X-Mandrill-User: md_31050260
Date:   Wed, 12 Jun 2019 11:25:52 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 12, 2019 at 09:44:49AM +0200, Miklos Szeredi wrote:
> On Tue, Jun 11, 2019 at 10:28 PM Kirill Smelkov <kirr@nexedi.com> wrote:
> 
> > Miklos, would 4K -> `sizeof(fuse_in_header) + sizeof(fuse_write_in)` for
> > header room change be accepted?
> 
> Yes, next cycle.   For 4.2 I'll just push the revert.

Thanks Miklos. Please consider queuing the following patch for 5.3.
Sander, could you please confirm that glusterfs is not broken with this
version of the check?

Thanks beforehand,
Kirill

---- 8< ----
From 24a04e8be9bbf6e67de9e1908dcbe95d426d2521 Mon Sep 17 00:00:00 2001
From: Kirill Smelkov <kirr@nexedi.com>
Date: Wed, 27 Mar 2019 10:15:15 +0000
Subject: [PATCH] fuse: require /dev/fuse reads to have enough buffer capacity (take 2)

[ This retries commit d4b13963f217 which was reverted in 766741fcaa1f.

  In this version we require only `sizeof(fuse_in_header) + sizeof(fuse_write_in)`
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
for header room (= `sizeof(fuse_in_header) + sizeof(fuse_write_in)`).

https://lore.kernel.org/linux-fsdevel/20190611202738.GA22556@deco.navytux.spb.ru/
https://github.com/gluster/glusterfs/blob/v3.8.15-0-gd174f021a/xlators/mount/fuse/src/fuse-bridge.c#L4894

Since

	`sizeof(fuse_in_header) + sizeof(fuse_write_in)` ==
	`sizeof(fuse_in_header) + sizeof(fuse_read_in)`  ==
	`sizeof(fuse_in_header) + sizeof(fuse_notify_retrieve_in)`

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

[1] https://marc.info/?l=linux-fsdevel&m=155057023600853&w=2

Signed-off-by: Kirill Smelkov <kirr@nexedi.com>
Cc: Han-Wen Nienhuys <hanwen@google.com>
Cc: Jakob Unterwurzacher <jakobunt@gmail.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/dev.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index ea8237513dfa..15531ba560b5 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1317,6 +1317,25 @@ static ssize_t fuse_dev_do_read(struct fuse_dev *fud, struct file *file,
 	unsigned reqsize;
 	unsigned int hash;
 
+	/*
+	 * Require sane minimum read buffer - that has capacity for fixed part
+	 * of any request header + negotiated max_write room for data. If the
+	 * requirement is not satisfied return EINVAL to the filesystem server
+	 * to indicate that it is not following FUSE server/client contract.
+	 * Don't dequeue / abort any request.
+	 *
+	 * Historically libfuse reserves 4K for fixed header room, but e.g.
+	 * GlusterFS reserves only 80 bytes
+	 *
+	 *	= `sizeof(fuse_in_header) + sizeof(fuse_write_in)`
+	 *
+	 * which is the absolute minimum any sane filesystem should be using
+	 * for header room.
+	 */
+	if (nbytes < max_t(size_t, FUSE_MIN_READ_BUFFER,
+			   sizeof(fuse_in_header) + sizeof(fuse_write_in) + fc->max_write))
+		return -EINVAL;
+
  restart:
 	spin_lock(&fiq->waitq.lock);
 	err = -EAGAIN;
-- 
2.20.1
