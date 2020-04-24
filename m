Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5F51B7953
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Apr 2020 17:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbgDXPTx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Apr 2020 11:19:53 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:46367 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726900AbgDXPTw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Apr 2020 11:19:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587741591;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Hup8zMplhzCtriOS6DgGXays5t9vNVweQrUya2JH8v4=;
        b=ex7Yp2MGjsfz/1Z8cSmtbuuWDRQHRmrMGGuFjlTkPsJ4GCZ3zMBHIPee/OUwZKDjifesCn
        2fDHa+tKnRs9AXjvZ0Pg6ywuvaSuC2+/HKYfhehPAV5hQwrYPtRGy6JtVPLg/Qso2UvOC5
        M+xrN/Y0LvxkGlC85jloecE4QOn0uaM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-3lctEr2_M3277HjaZZgtFw-1; Fri, 24 Apr 2020 11:19:49 -0400
X-MC-Unique: 3lctEr2_M3277HjaZZgtFw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5CED71009633;
        Fri, 24 Apr 2020 15:19:48 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-113-129.rdu2.redhat.com [10.10.113.129])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3C3925D9D5;
        Fri, 24 Apr 2020 15:19:47 +0000 (UTC)
Subject: [PATCH 0/8] afs: NAT-mitigation and other bits
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
Cc:     Dave Botsch <botsch@cnf.cornell.edu>,
        Jeffrey Altman <jaltman@auristor.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        dhowells@redhat.com
Date:   Fri, 24 Apr 2020 16:19:46 +0100
Message-ID: <158774158625.3619859.10579201535876583842.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


The primary part of this patchset, is intended to help deal with the
effects of using an AFS client that is communicating with a server through
some sort of NAT or firewall, whereby if the just right amount of time
lapses before a third party change is made, the client thinks it still has
a valid callback, but the server's attempt to notify the client of the
change bounces because the NAT/firewall window has closed.  The problem is
that kafs does insufficient probing to maintain the firewall window.

The effect is mitigated in the following ways:

 (1) When an FS.InlineBulkStatus op is sent to the server during a file
     lookup, the FID of the directory being looked up in will now get
     included in the list of vnodes to query.  This will find out more
     quickly if the dir has changed.

 (2) The fileserver is now polled regularly by an independent, timed
     manager rather than only being polled by the rotation algorithm when
     someone does a VFS operation that performs an RPC call.

I have included some other bits in the patchset also:

 (1) Apply uninterruptibility a bit more thoroughly.  There are more places
     that need it yet, but they're harder to fix.

 (2) Use the serverUnique field from the VLDB record to trigger a recheck
     of a fileserver's endpoints rather than doing it on a timed basis
     separately for each fileserver.  This reduces the number of VL RPCs
     performed, albeit it's a minor reduction.

 (3) Note when we have detected the epoch from the fileserver so that the
     code that checks it actually does its stuff.

 (4) Remove some unused bits in the code.

Note that I've spotted some bugs in the fileserver rotation algorithm, but
that's going to need its own rewrite as the structure of it is wrong.

David
---
David Howells (8):
      afs: Always include dir in bulk status fetch from afs_do_lookup()
      afs: Make record checking use TASK_UNINTERRUPTIBLE when appropriate
      afs: Use the serverUnique field in the UVLDB record to reduce rpc ops
      afs: Fix to actually set AFS_SERVER_FL_HAVE_EPOCH
      afs: Remove some unused bits
      afs: Split the usage count on struct afs_server
      afs: Actively poll fileservers to maintain NAT or firewall openings
      afs: Show more information in /proc/net/afs/servers


 fs/afs/cmservice.c         |    8 +
 fs/afs/dir.c               |    9 +
 fs/afs/fs_probe.c          |  280 +++++++++++++++++++++++++++++++++-----------
 fs/afs/fsclient.c          |   24 ++--
 fs/afs/internal.h          |   58 ++++++---
 fs/afs/main.c              |    5 +
 fs/afs/proc.c              |   18 ++-
 fs/afs/rotate.c            |   13 +-
 fs/afs/rxrpc.c             |    2 
 fs/afs/server.c            |  201 +++++++++++++++++++-------------
 fs/afs/server_list.c       |    7 +
 fs/afs/vl_rotate.c         |    4 -
 fs/afs/vlclient.c          |    1 
 fs/afs/volume.c            |   32 +++--
 include/trace/events/afs.h |   22 +++
 15 files changed, 455 insertions(+), 229 deletions(-)


