Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46384EB4CF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2019 17:38:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728598AbfJaQiQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Oct 2019 12:38:16 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:50417 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727856AbfJaQiQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Oct 2019 12:38:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572539894;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mxgLr4gqIZKHqSVNNAtea7HdJZYdiBMzARcL7j6XY2g=;
        b=CF2hlQA8etUWX3SO7hGGqhd6fyRHTFCj/P3PpJH7AcCa8ad7e3giVNi8Aq/TYokeRHzC/i
        Q3SzGnV0D5cxgMbF5fw9T93fPMiWX+AG4kg3OU+rkeznI04dj96wzsdlQKJGGA5kDqDQwd
        bkrjqLI8Ac50PdU/ArudXekH2hbChhs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-120-OBNcKO5IPbCsAav66unpNg-1; Thu, 31 Oct 2019 12:38:11 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D80461800D55;
        Thu, 31 Oct 2019 16:38:08 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-40.rdu2.redhat.com [10.10.121.40])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A573219C5B;
        Thu, 31 Oct 2019 16:38:05 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <fe167a90-1503-7ca2-4150-eeffd5cb1378@yandex-team.ru>
References: <fe167a90-1503-7ca2-4150-eeffd5cb1378@yandex-team.ru> <157186182463.3995.13922458878706311997.stgit@warthog.procyon.org.uk> <157186189069.3995.10292601951655075484.stgit@warthog.procyon.org.uk>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     dhowells@redhat.com, torvalds@linux-foundation.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        nicolas.dichtel@6wind.com, raven@themaw.net,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 07/10] pipe: Conditionalise wakeup in pipe_read() [ver #2]
MIME-Version: 1.0
Content-ID: <3164.1572539884.1@warthog.procyon.org.uk>
Date:   Thu, 31 Oct 2019 16:38:04 +0000
Message-ID: <3165.1572539884@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: OBNcKO5IPbCsAav66unpNg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Okay, attached is a change that might give you what you want.  I tried my
pipe-bench program (see cover note) with perf.  The output of the program w=
ith
the patch applied was:

-       pipe                  305127298     36262221772       302185181    =
     7887690

The output of perf with the patch applied:

        239,943.92 msec task-clock                #    1.997 CPUs utilized
            17,728      context-switches          #   73.884 M/sec
               124      cpu-migrations            #    0.517 M/sec
             9,330      page-faults               #   38.884 M/sec
   885,107,207,365      cycles                    # 3688822.793 GHz
 1,386,873,499,490      instructions              #    1.57  insn per cycle
   311,037,372,339      branches                  # 1296296921.931 M/sec
        33,467,827      branch-misses             #    0.01% of all branche=
s

And without:

        239,891.87 msec task-clock                #    1.997 CPUs utilized
            22,187      context-switches          #   92.488 M/sec
               133      cpu-migrations            #    0.554 M/sec
             9,334      page-faults               #   38.909 M/sec
   884,906,976,128      cycles                    # 3688787.725 GHz
 1,391,986,932,265      instructions              #    1.57  insn per cycle
   311,394,686,857      branches                  # 1298067400.849 M/sec
        30,242,823      branch-misses             #    0.01% of all branche=
s

So it did make something like a 20% reduction in context switches.

David
---
diff --git a/fs/pipe.c b/fs/pipe.c
index e3d5f7a39123..5167921edd73 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -276,7 +276,7 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
 =09size_t total_len =3D iov_iter_count(to);
 =09struct file *filp =3D iocb->ki_filp;
 =09struct pipe_inode_info *pipe =3D filp->private_data;
-=09int do_wakeup;
+=09int do_wakeup, wake;
 =09ssize_t ret;

 =09/* Null read succeeds. */
@@ -329,11 +329,12 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
 =09=09=09=09tail++;
 =09=09=09=09pipe->tail =3D tail;
 =09=09=09=09do_wakeup =3D 1;
-=09=09=09=09if (head - (tail - 1) =3D=3D pipe->max_usage)
+=09=09=09=09wake =3D head - (tail - 1) =3D=3D pipe->max_usage / 2;
+=09=09=09=09if (wake)
 =09=09=09=09=09wake_up_interruptible_sync_poll_locked(
 =09=09=09=09=09=09&pipe->wait, EPOLLOUT | EPOLLWRNORM);
 =09=09=09=09spin_unlock_irq(&pipe->wait.lock);
-=09=09=09=09if (head - (tail - 1) =3D=3D pipe->max_usage)
+=09=09=09=09if (wake)
 =09=09=09=09=09kill_fasync(&pipe->fasync_writers, SIGIO, POLL_OUT);
 =09=09=09}
 =09=09=09total_len -=3D chars;

