Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D058572BED
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jul 2019 12:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbfGXKBG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Jul 2019 06:01:06 -0400
Received: from mail134-15.atl141.mandrillapp.com ([198.2.134.15]:13413 "EHLO
        mail134-15.atl141.mandrillapp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726300AbfGXKBG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Jul 2019 06:01:06 -0400
X-Greylist: delayed 900 seconds by postgrey-1.27 at vger.kernel.org; Wed, 24 Jul 2019 06:01:04 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=mandrill; d=nexedi.com;
 h=From:Subject:To:Cc:Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding; i=kirr@nexedi.com;
 bh=wSTQf2dBxrCf6rtywumr/ODjq4xB0I2umV1t8dtD2Fg=;
 b=UajI+5GBbQ6huJSri0F1zYm9FXBAhKMXsfu0KvvTmYM9NBXOrRxnaMRYYt20YovM7D57y4VSq7PH
   +Apj7D0AP46PpQqlkZ93iveEHC/SJbjYeigyOCGjdazrjANtTYx4RbAXTafJIFbMeO2vR5fgDj3g
   Mq9Y+2KHXtK1Sfr54yk=
Received: from pmta03.mandrill.prod.atl01.rsglab.com (127.0.0.1) by mail134-15.atl141.mandrillapp.com id h70m601sau87 for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jul 2019 09:46:03 +0000 (envelope-from <bounce-md_31050260.5d3828db.v1-c8c7e2b5ec674c2bbfcd8312a66dcb0a@mandrillapp.com>)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com; 
 i=@mandrillapp.com; q=dns/txt; s=mandrill; t=1563961563; h=From : 
 Subject : To : Cc : Message-Id : Date : MIME-Version : Content-Type : 
 Content-Transfer-Encoding : From : Subject : Date : X-Mandrill-User : 
 List-Unsubscribe; bh=wSTQf2dBxrCf6rtywumr/ODjq4xB0I2umV1t8dtD2Fg=; 
 b=aZrrTzWDxZMFEnB91KfBtF9S/0lxAffsWD0KEMVQKy0GsDlpcNvqjOLgNYbAQWp0dNODcK
 jK73APNQ2u4nfv74ocWcl7N5X8N0SBG8KhrDbqDc/tiNicC3JBix9wCh8Oy6D7/obS22g+fK
 FCCeC12u1/EPKSW6/zTlS3DmXxLlw=
From:   Kirill Smelkov <kirr@nexedi.com>
Subject: [PATCH, RESEND3] fuse: require /dev/fuse reads to have enough buffer capacity (take 2)
Received: from [87.98.221.171] by mandrillapp.com id c8c7e2b5ec674c2bbfcd8312a66dcb0a; Wed, 24 Jul 2019 09:46:03 +0000
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Miklos Szeredi <mszeredi@redhat.com>
Cc:     Kirill Smelkov <kirr@nexedi.com>, <gluster-devel@gluster.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sander Eikelenboom <linux@eikelenboom.it>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Jakob Unterwurzacher <jakobunt@gmail.com>
Message-Id: <20190724094556.GA19383@deco.navytux.spb.ru>
X-Report-Abuse: Please forward a copy of this message, including all headers, to abuse@mandrill.com
X-Report-Abuse: You can also report abuse here: http://mandrillapp.com/contact/abuse?id=31050260.c8c7e2b5ec674c2bbfcd8312a66dcb0a
X-Mandrill-User: md_31050260
Date:   Wed, 24 Jul 2019 09:46:03 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Miklos,

I was sending this patch for ~1.5 month without any feedback from you[1,2,3].
The patch was tested by Sander Eikelenboom (original GlusterFS problem
reporter)[4], and you said that it will be ok to retry for next
cycle[5]. I was hoping for this patch to be picked up for 5.3 and queued
to Linus's tree, but in despite several resends from me (the same patch;
just reminders) nothing is happening. v5.3-rc1 came out on last Sunday,
which, in my understanding, denotes the close of 5.3 merge window. What
is going on? Could you please pick up the patch and handle it?

Thanks beforehand (again),
Kirill

[1] https://lore.kernel.org/linux-fsdevel/20190612141220.GA25389@deco.navytux.spb.ru/
[2] https://lore.kernel.org/linux-fsdevel/20190623072619.31037-1-kirr@nexedi.com/
[3] https://lore.kernel.org/linux-fsdevel/20190708170314.27982-1-kirr@nexedi.com/
[4] https://lore.kernel.org/linux-fsdevel/f79ff13f-701b-89d8-149c-e53bb880bb77@eikelenboom.it/
[5] https://lore.kernel.org/linux-fsdevel/CAOssrKfj-MDujX0_t_fgobL_KwpuG2fxFmT=4nURuJA=sUvYYg@mail.gmail.com/

---- 8< ----

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
Tested-by: Sander Eikelenboom <linux@eikelenboom.it>
Cc: Han-Wen Nienhuys <hanwen@google.com>
Cc: Jakob Unterwurzacher <jakobunt@gmail.com>
---
 fs/fuse/dev.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index ea8237513dfa..b2b2344eadcf 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1317,6 +1317,26 @@ static ssize_t fuse_dev_do_read(struct fuse_dev *fud, struct file *file,
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
+			   sizeof(struct fuse_in_header) + sizeof(struct fuse_write_in) +
+				fc->max_write))
+		return -EINVAL;
+
  restart:
 	spin_lock(&fiq->waitq.lock);
 	err = -EAGAIN;
-- 
2.20.1
