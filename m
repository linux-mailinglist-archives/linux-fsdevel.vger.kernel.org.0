Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5A29140F59
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2020 17:53:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgAQQxy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jan 2020 11:53:54 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52326 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726559AbgAQQxy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jan 2020 11:53:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579280032;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=+D+2i5u8m+6VdqENi+Zlil9tmBeW+a+J8CirwEbN+O0=;
        b=QfVrvNR887ItjCdiQ3pkxdn0cW5b1wfCA5g/2Dk+hnAUzXhfdDwPfYCgOc1NZicilAs3k5
        x58tfuQ+ORNNenMHqhOpvgugZWbTWj404MJCNgiD4vn2gzXyczta0Hu0hWzxRoJG7Zzd/A
        cej8DV/53J4brqR3wB03O3WXGyxpr9w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-153-ketbYkMvMuyd-WQZaOp4qw-1; Fri, 17 Jan 2020 11:53:51 -0500
X-MC-Unique: ketbYkMvMuyd-WQZaOp4qw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F2233190B2CD;
        Fri, 17 Jan 2020 16:53:48 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7055B81201;
        Fri, 17 Jan 2020 16:53:48 +0000 (UTC)
To:     David Howells <dhowells@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
From:   Waiman Long <longman@redhat.com>
Subject: Performance regression introduced by commit b667b8673443 ("pipe:
 Advance tail pointer inside of wait spinlock in pipe_read()")
Organization: Red Hat
Message-ID: <c6ed1ca0-3e39-714c-9590-54e13695b9b9@redhat.com>
Date:   Fri, 17 Jan 2020 11:53:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

David,

I had found that parallel kernel build became much slower when a
5.5-based kernel is used. On a 2-socket 96-thread x86-64 system, the
"make -j88" time increased from less than 3 minutes with the 5.4 kernel
to more than double with the 5.5 kernel.

So I used bisection to try to find the culprit:

b667b867344301e24f21d4a4c844675ff61d89e1 is the first bad commit
commit b667b867344301e24f21d4a4c844675ff61d89e1
Author: David Howells <dhowells@redhat.com>
Date:=C2=A0=C2=A0 Tue Sep 24 16:09:04 2019 +0100

=C2=A0=C2=A0=C2=A0 pipe: Advance tail pointer inside of wait spinlock in =
pipe_read()
=C2=A0=C2=A0=C2=A0
=C2=A0=C2=A0=C2=A0 Advance the pipe ring tail pointer inside of wait spin=
lock in
pipe_read()
=C2=A0=C2=A0=C2=A0 so that the pipe can be written into with kernel notif=
ications from
=C2=A0=C2=A0=C2=A0 contexts where pipe->mutex cannot be taken.
=C2=A0=C2=A0=C2=A0
=C2=A0=C2=A0=C2=A0 Signed-off-by: David Howells <dhowells@redhat.com>

diff --git a/fs/pipe.c b/fs/pipe.c
index 69afeab8a73a..ea134f69a292 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -325,9 +325,14 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
=C2=A0
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!buf-=
>len) {
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pipe_buf_release(pipe, buf);
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_lock_irq(&pipe->wait.lock);
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tail++;
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pipe->tail =3D tail;
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 do_wakeup =3D 1;
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 do_wakeup =3D 0;
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wake_up_interruptible_sync_poll_locked(
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 &pipe->wait, EPOLLOUT |
EPOLLWRNORM);
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_unlock_irq(&pipe->wait.lock);
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kill_fasync(&pipe->fasync_writers,
SIGIO, POLL_O
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }

I guess the make command may make heavy use of pipe. The adding of
spinlock code in your patch may probably over-serialize the pipe
operation. Could you achieve the same functionality without adding a lock=
?

Cheers,
Longman

