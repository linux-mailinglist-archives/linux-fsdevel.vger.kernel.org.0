Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 087A273C425
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jun 2023 00:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbjFWWfU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Jun 2023 18:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjFWWfS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Jun 2023 18:35:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB5822693
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Jun 2023 15:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687559673;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=OXHK801MHw6sMHY68DL31vt5Z/u/q42/rUnJs7PRou0=;
        b=ilwjNt+wfxaGco340WpG4e1XPHVgxt5gMXY551xerQXq4XnavUWx6emjU4ZmAqV0yFRrCm
        gdFMxxoo59/y2YLg/ZPZsYg2I+3nbihhsz8A7btOBEjyupMDUxFBDPPwz6Q0hyOW0FDWKw
        PTJqFJIQOlsRrxaTsylzlQUpXU2ae/A=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-399-qKtsGPptMGm18tLLs81clg-1; Fri, 23 Jun 2023 18:34:30 -0400
X-MC-Unique: qKtsGPptMGm18tLLs81clg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A39BC1C03D8A;
        Fri, 23 Jun 2023 22:34:29 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AE10140C2063;
        Fri, 23 Jun 2023 22:34:28 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     dhowells@redhat.com, Franck Grosjean <fgrosjea@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] pipe: Make a partially-satisfied blocking read wait for more
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2730510.1687559668.1@warthog.procyon.org.uk>
Date:   Fri, 23 Jun 2023 23:34:28 +0100
Message-ID: <2730511.1687559668@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Can you consider merging something like the attached patch?  Unfortunately,
there are applications out there that depend on a read from pipe() waiting
until the buffer is full under some circumstances.  Patch a28c8b9db8a1
removed the conditionality on there being an attached writer.

I'm not sure this is the best solution though as it goes over the other way
and will now block reads for which there isn't an active writer - and I'm
sure that, somewhere, there's an app that will break on tht.

Thanks,
David
---
pipe: Make a partially-satisfied blocking read wait for more data

A read on a pipe may return short after reading some data from a pipe, even
though the pipe isn't non-blocking.  This is stated in the read(2) manual
page:

    ... It is not an error if this number is smaller than the number of
    bytes requested; this may happen for example because fewer bytes are
    actually available right now (maybe because we were close to
    end-of-file, or because we are reading from a pipe, or from a
    terminal)...

However, some applications depend on a blocking read on a pipe not
returning until it fills the buffer unless it hits EOF or a signal occurs -
at least as long as there's an active writer on the other end.

Fix the pipe reader to restore this behaviour by only breaking out with a
short read in the non-block (and signal) cases.

Here's a reproducer for it:

    #include <fcntl.h>
    #include <stdio.h>
    #include <unistd.h>
    #include <stdlib.h>
    #include <sys/uio.h>

    #define F_GETPIPE_SZ 1032

    int main(int argc, char *argv[])
    {
       int fildes[2];
       if (pipe(fildes) == -1) {
	       perror("in pipe");
	       return -1;
       }
       printf("%d %d\n",
              fcntl(fildes[0], F_GETPIPE_SZ),
              fcntl(fildes[1], F_GETPIPE_SZ));
       if (fork() != 0) {
	       void *tata = malloc(100000);
	       int res = read(fildes[0], tata, 100000);
	       printf("could read %d bytes\n", res);
	       return -1;
       }
       void *toto = malloc(100000);
       struct iovec iov;
       iov.iov_base = toto;
       iov.iov_len = 100000;
       int d = writev(fildes[1], &iov, 1);
       if (d == -1) {
	       perror("in writev");
	       return -1;
       }
       printf("could write %d bytes\n", d);
       sleep(1);
       return 0;
    }

It should show the same amount read as written, but shows a short read because
the pipe capacity isn't sufficient.

Fixes: a28c8b9db8a1 ("pipe: remove 'waiting_writers' merging logic")
Reported-by: Franck Grosjean <fgrosjea@redhat.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Tested-by: Phil Auld <pauld@redhat.com>
cc: Linus Torvalds <torvalds@linux-foundation.org>
cc: Alexander Viro <viro@zeniv.linux.org.uk>
cc: Christian Brauner <brauner@kernel.org>
cc: linux-fsdevel@vger.kernel.org
---
 fs/pipe.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index 2d88f73f585a..c5c992f19d28 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -340,11 +340,10 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)

 		if (!pipe->writers)
 			break;
-		if (ret)
-			break;
 		if ((filp->f_flags & O_NONBLOCK) ||
 		    (iocb->ki_flags & IOCB_NOWAIT)) {
-			ret = -EAGAIN;
+			if (!ret)
+				ret = -EAGAIN;
 			break;
 		}
 		__pipe_unlock(pipe);

