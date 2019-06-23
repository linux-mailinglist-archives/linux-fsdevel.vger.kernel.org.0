Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3ED74FAA4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Jun 2019 09:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbfFWHlk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 23 Jun 2019 03:41:40 -0400
Received: from mail10.wdc04.mandrillapp.com ([205.201.139.10]:1361 "EHLO
        mail10.wdc04.mandrillapp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726050AbfFWHlk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 23 Jun 2019 03:41:40 -0400
X-Greylist: delayed 900 seconds by postgrey-1.27 at vger.kernel.org; Sun, 23 Jun 2019 03:41:39 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=mandrill; d=nexedi.com;
 h=From:Subject:To:Cc:Message-Id:In-Reply-To:References:Date:MIME-Version:Content-Type:Content-Transfer-Encoding; i=kirr@nexedi.com;
 bh=dSY8NMzAi0uW7gbo3MkKCEB6rvCWIFKhM/6k9k6ce5E=;
 b=qdl30SBWmhx9DIxJm4gPr9bhAmF1Fj9mBA+xccPr0GTjFyRGf6e8Vvv6btalLaeLv2xYAlECzakQ
   TBBHPj86GaTL/HePtxMB9EbFDsLD6l998s7hbsA4E0kjNnIExsGXLmeSLSOeZi78WkdKQrgsVXVF
   YhOX5xUAxy/5/uiI7kM=
Received: from pmta08.mandrill.prod.suw01.rsglab.com (127.0.0.1) by mail10.wdc04.mandrillapp.com id h1smj61jvmg4 for <linux-fsdevel@vger.kernel.org>; Sun, 23 Jun 2019 07:26:38 +0000 (envelope-from <bounce-md_31050260.5d0f29ae.v1-3fb521aee3ef4b178e96905eb5e09249@mandrillapp.com>)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com; 
 i=@mandrillapp.com; q=dns/txt; s=mandrill; t=1561274798; h=From : 
 Subject : To : Cc : Message-Id : In-Reply-To : References : Date : 
 MIME-Version : Content-Type : Content-Transfer-Encoding : From : 
 Subject : Date : X-Mandrill-User : List-Unsubscribe; 
 bh=dSY8NMzAi0uW7gbo3MkKCEB6rvCWIFKhM/6k9k6ce5E=; 
 b=NAKfNnZiQPSwteksG3ggLqasc3SZ2dfa8MEBGjnA1SKN4GrsysJ4fGLT1l57yY9FJKTk74
 qgU1cbraenhPCzJ7jK0u+5jCkAs7jcU0K6vXWYhVD/lhfUZ3WL22kdmVov02zlTG+eFY2Rrm
 ijFaR6bh4WYlNbC76JrHjQN5s0bs8=
From:   Kirill Smelkov <kirr@nexedi.com>
Subject: [PATCH, RESEND] fuse: require /dev/fuse reads to have enough buffer capacity (take 2)
Received: from [87.98.221.171] by mandrillapp.com id 3fb521aee3ef4b178e96905eb5e09249; Sun, 23 Jun 2019 07:26:38 +0000
X-Mailer: git-send-email 2.20.1
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Kirill Smelkov <kirr@nexedi.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        <gluster-devel@gluster.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Sander Eikelenboom <linux@eikelenboom.it>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Jakob Unterwurzacher <jakobunt@gmail.com>
Message-Id: <20190623072619.31037-1-kirr@nexedi.com>
In-Reply-To: <f79ff13f-701b-89d8-149c-e53bb880bb77@eikelenboom.it>
References: 
X-Report-Abuse: Please forward a copy of this message, including all headers, to abuse@mandrill.com
X-Report-Abuse: You can also report abuse here: http://mandrillapp.com/contact/abuse?id=31050260.3fb521aee3ef4b178e96905eb5e09249
X-Mandrill-User: md_31050260
Date:   Sun, 23 Jun 2019 07:26:38 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

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
