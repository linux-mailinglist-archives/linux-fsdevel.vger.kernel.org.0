Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF8C10958F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2019 23:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfKYWkC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Nov 2019 17:40:02 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57612 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725940AbfKYWkB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Nov 2019 17:40:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574721599;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=5sKIYkJNyPnvls7YymGjYgeRReOTkIWJFCCY/KNJN4E=;
        b=EjuYjEx5/34jJmXXXgzxWlzOf6AGaCWqQ+45PcraM3dV28GUr6y94qzfB8NZ/j2sTREux2
        cp+X6plr+xEi7gBrEGwxw9OAfX2Bzoyij/3JMvSk2iHkshzVl/Id06JY7iDKfgugRIFGVN
        9ikpa0GIRgAjgt7p9FEzr+3qffVcrRY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-52-YNICEyQ8MOCH5iLhyx9JEQ-1; Mon, 25 Nov 2019 17:39:56 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A9750DB20;
        Mon, 25 Nov 2019 22:39:53 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-161.rdu2.redhat.com [10.10.120.161])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C15825D9CA;
        Mon, 25 Nov 2019 22:39:50 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
cc:     dhowells@redhat.com, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>, raven@themaw.net,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] pipe: Notification queue preparation
MIME-Version: 1.0
Content-ID: <31451.1574721589.1@warthog.procyon.org.uk>
Date:   Mon, 25 Nov 2019 22:39:49 +0000
Message-ID: <31452.1574721589@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: YNICEyQ8MOCH5iLhyx9JEQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Can you pull this please?  This is my set of preparatory patches for
building a general notification queue on top of pipes.  It makes a number
of significant changes:

 (1) It removes the nr_exclusive argument from __wake_up_sync_key() as this
     is always 1.  This prepares for step 2.

 (2) Adds wake_up_interruptible_sync_poll_locked() so that poll can be
     woken up from a function that's holding the poll waitqueue spinlock.

     [btw, I realise that I haven't un-sync'd the
      wake_up_interruptible_sync_poll() calls as you tentatively suggested.
      I can send a follow up patch to fix that if you still want it]

 (3) Change the pipe buffer ring to be managed in terms of unbounded head
     and tail indices rather than bounded index and length.  This means
     that reading the pipe only needs to modify one index, not two.

 (4) A selection of helper functions are provided to query the state of the
     pipe buffer, plus a couple to apply updates to the pipe indices.

 (5) The pipe ring is allowed to have kernel-reserved slots.  This allows
     many notification messages to be spliced in by the kernel without
     allowing userspace to pin too many pages if it writes to the same
     pipe.

 (6) Advance the head and tail indices inside the pipe waitqueue lock and
     use step 2 to poke poll without having to take the lock twice.

 (7) Rearrange pipe_write() to preallocate the buffer it is going to write
     into and then drop the spinlock.  This allows kernel notifications to
     then be added the ring whilst it is filling the buffer it allocated.
     The read side is stalled because the pipe mutex is still held.

 (8) Don't wake up readers on a pipe if there was already data in it when
     we added more.

 (9) Don't wake up writers on a pipe if the ring wasn't full before we
     removed a buffer.

PATCHES=09BENCHMARK=09BEST=09=09TOTAL BYTES=09AVG BYTES=09STDDEV
=3D=3D=3D=3D=3D=3D=3D=09=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=09=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=09=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=09=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=09=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-=09pipe=09=09      307457969=09    36348556755=09      302904639=09       =
10622403
-=09splice=09=09      287117614=09    26933658717=09      224447155=09     =
 160777958
-=09vmsplice=09      435180375=09    51302964090=09      427524700=09      =
 19083037

rm-nrx=09pipe=09=09      311091179=09    37093181356=09      309109844=09  =
      7221622
rm-nrx=09splice=09=09      285628049=09    27916298942=09      232635824=09=
      158296431
rm-nrx=09vmsplice=09      417703153=09    47570362546=09      396419687=09 =
      33960822

wakesl=09pipe=09=09      310698731=09    36772541631=09      306437846=09  =
      8249347
wakesl=09splice=09=09      286193726=09    28600435451=09      238336962=09=
      141169318
wakesl=09vmsplice=09      436175803=09    50723895824=09      422699131=09 =
      40724240

ht=09pipe=09=09      305534565=09    36426079543=09      303550662=09      =
  5673885
ht=09splice=09=09      243632025=09    23319439010=09      194328658=09    =
  150479853
ht=09vmsplice=09      432825176=09    49101781001=09      409181508=09     =
  44102509

k-rsv=09pipe=09=09      308691523=09    36652267561=09      305435563=09   =
    12972559
k-rsv=09splice=09=09      244793528=09    23625172865=09      196876440=09 =
     125319143
k-rsv=09vmsplice=09      436119082=09    49460808579=09      412173404=09  =
     55547525

r-adv-t=09pipe=09=09      310094218=09    36860182219=09      307168185=09 =
       8081101
r-adv-t=09splice=09=09      285527382=09    27085052687=09      225708772=
=09      206918887
r-adv-t=09vmsplice=09      336885948=09    40128756927=09      334406307=09=
        5895935

r-cond=09pipe=09=09      308727804=09    36635828180=09      305298568=09  =
      9976806
r-cond=09splice=09=09      284467568=09    28445793054=09      237048275=09=
      200284329
r-cond=09vmsplice=09      449679489=09    51134833848=09      426123615=09 =
      66790875

w-preal=09pipe=09=09      307416578=09    36662086426=09      305517386=09 =
       6216663
w-preal=09splice=09=09      282655051=09    28455249109=09      237127075=
=09      194154549
w-preal=09vmsplice=09      437002601=09    47832160621=09      398601338=09=
       96513019

w-redun=09pipe=09=09      307279630=09    36329750422=09      302747920=09 =
       8913567
w-redun=09splice=09=09      284324488=09    27327152734=09      227726272=
=09      219735663
w-redun=09vmsplice=09      451141971=09    51485257719=09      429043814=09=
       51388217

w-ckful=09pipe=09=09      305055247=09    36374947350=09      303124561=09 =
       5400728
w-ckful=09splice=09=09      281575308=09    26841554544=09      223679621=
=09      215942886
w-ckful=09vmsplice=09      436653588=09    47564907110=09      396374225=09=
       82255342

The patches column indicates the point in the patchset at which the benchma=
rks
were taken:

=090=09No patches
=09rm-nrx=09"Remove the nr_exclusive argument from __wake_up_sync_key()"
=09wakesl=09"Add wake_up_interruptible_sync_poll_locked()"
=09ht=09"pipe: Use head and tail pointers for the ring, not cursor and leng=
th"
=09k-rsv=09"pipe: Allow pipes to have kernel-reserved slots"
=09r-adv-t=09"pipe: Advance tail pointer inside of wait spinlock in pipe_re=
ad()"
=09r-cond=09"pipe: Conditionalise wakeup in pipe_read()"
=09w-preal=09"pipe: Rearrange sequence in pipe_write() to preallocate slot"
=09w-redun=09"pipe: Remove redundant wakeup from pipe_write()"
=09w-ckful=09"pipe: Check for ring full inside of the spinlock in pipe_writ=
e()"

Changes:

 (*) Fix some bugs spotted by kbuild.

 ver #3:

 (*) Get rid of pipe_commit_{read,write}.

 (*) Port the virtio_console driver.

 (*) Fix pipe_zero().

 (*) Amend some comments.

 (*) Added an additional patch that changes the threshold at which readers
     wake writers for Konstantin Khlebnikov.

 ver #2:

 (*) Split the notification patches out into a separate branch.

 (*) Removed the nr_exclusive parameter from __wake_up_sync_key().

 (*) Renamed the locked wakeup function.

 (*) Add helpers for empty, full, occupancy.

 (*) Split the addition of ->max_usage out into its own patch.

 (*) Fixed some bits pointed out by Rasmus Villemoes.

 ver #1:

 (*) Build on top of standard pipes instead of having a driver.

David
---
The following changes since commit da0c9ea146cbe92b832f1b0f694840ea8eb33cce=
:

  Linux 5.4-rc2 (2019-10-06 14:27:30 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/=
notifications-pipe-prep-20191115

for you to fetch changes up to 3c0edea9b29f9be6c093f236f762202b30ac9431:

  pipe: Remove sync on wake_ups (2019-11-15 16:22:54 +0000)

----------------------------------------------------------------
Pipework for general notification queue

----------------------------------------------------------------
David Howells (12):
      pipe: Reduce #inclusion of pipe_fs_i.h
      Remove the nr_exclusive argument from __wake_up_sync_key()
      Add wake_up_interruptible_sync_poll_locked()
      pipe: Use head and tail pointers for the ring, not cursor and length
      pipe: Allow pipes to have kernel-reserved slots
      pipe: Advance tail pointer inside of wait spinlock in pipe_read()
      pipe: Conditionalise wakeup in pipe_read()
      pipe: Rearrange sequence in pipe_write() to preallocate slot
      pipe: Remove redundant wakeup from pipe_write()
      pipe: Check for ring full inside of the spinlock in pipe_write()
      pipe: Increase the writer-wakeup threshold to reduce context-switch c=
ount
      pipe: Remove sync on wake_ups

 drivers/char/virtio_console.c |  16 ++-
 fs/exec.c                     |   1 -
 fs/fuse/dev.c                 |  31 +++--
 fs/ocfs2/aops.c               |   1 -
 fs/pipe.c                     | 232 +++++++++++++++++++++---------------
 fs/splice.c                   | 190 +++++++++++++++++------------
 include/linux/pipe_fs_i.h     |  64 +++++++++-
 include/linux/uio.h           |   4 +-
 include/linux/wait.h          |  11 +-
 kernel/exit.c                 |   2 +-
 kernel/sched/wait.c           |  37 ++++--
 lib/iov_iter.c                | 269 ++++++++++++++++++++++++--------------=
----
 security/smack/smack_lsm.c    |   1 -
 13 files changed, 529 insertions(+), 330 deletions(-)

