Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8AE5116F76
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2019 15:47:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbfLIOrB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Dec 2019 09:47:01 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:48050 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727307AbfLIOrB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Dec 2019 09:47:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575902820;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=CM25+hyAaztYLzFeE0wSz+qlYJ2FDBVMOHfW8aWsNVQ=;
        b=cWZEH3yxoQtG1azQmlf5dMyiVRsqvdhauk9qzMPIUxWIJ80OSdoGqZ1YRm0CpYM6sCHuil
        jG1EaDacwZdMjQdUvhV0pZ3XTx6edN0Rk4pJ59YyJ/oyPPYmu0vkpmYj9XhXTTNnmLOpr9
        HeVC+jfLM4XdNrzyrNjPk70zFOj9Ha0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-345-Zw69kApWMU6Gv-6k_TxtlQ-1; Mon, 09 Dec 2019 09:46:59 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ADFC7801E53;
        Mon,  9 Dec 2019 14:46:57 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-250.rdu2.redhat.com [10.10.120.250])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 33C48100EBAC;
        Mon,  9 Dec 2019 14:46:56 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     lsf-pc@lists.linux-foundation.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>
cc:     dhowells@redhat.com, jlayton@redhat.com,
        linux-fsdevel@vger.kernel.org
Subject: [LSF/MM/BPF TOPIC] How to make disconnected operation work?
MIME-Version: 1.0
Content-ID: <14195.1575902815.1@warthog.procyon.org.uk>
Date:   Mon, 09 Dec 2019 14:46:55 +0000
Message-ID: <14196.1575902815@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: Zw69kApWMU6Gv-6k_TxtlQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I've been rewriting fscache and cachefiles to massively simplify it and mak=
e
use of the kiocb interface to do direct-I/O to/from the netfs's pages which
didn't exist when I first did this.

=09https://lore.kernel.org/lkml/24942.1573667720@warthog.procyon.org.uk/
=09https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/lo=
g/?h=3Dfscache-iter

I'm getting towards the point where it's working and able to do basic cachi=
ng
once again.  So now I've been thinking about what it'd take to support
disconnected operation.  Here's a list of things that I think need to be
considered or dealt with:

 (1) Making sure the working set is present in the cache.

     - Userspace (find/cat/tar)
     - Splice netfs -> cache
     - Metadata storage (e.g. directories)
     - Permissions caching

 (2) Making sure the working set doesn't get culled.

     - Pinning API (cachectl() syscall?)
     - Allow culling to be disabled entirely on a cache
     - Per-fs/per-dir config

 (3) Switching into/out of disconnected mode.

     - Manual, automatic
     - On what granularity?
       - Entirety of fs (eg. all nfs)
       - By logical unit (server, volume, cell, share)

 (4) Local changes in disconnected mode.

     - Journal
     - File identifier allocation
     - statx flag to indicate provisional nature of info
     - New error codes
=09- EDISCONNECTED - Op not available in disconnected mode
=09- EDISCONDATA - Data not available in disconnected mode
=09- EDISCONPERM - Permission cannot be checked in disconnected mode
=09- EDISCONFULL - Disconnected mode cache full
     - SIGIO support?

 (5) Reconnection.

     - Proactive or JIT synchronisation
       - Authentication
     - Conflict detection and resolution
=09 - ECONFLICTED - Disconnected mode resolution failed
     - Journal replay
     - Directory 'diffing' to find remote deletions
     - Symlink and other non-regular file comparison

 (6) Conflict resolution.

     - Automatic where possible
       - Just create/remove new non-regular files if possible
       - How to handle permission differences?
     - How to let userspace access conflicts?
       - Move local copy to 'lost+found'-like directory
       =09 - Might not have been completely downloaded
       - New open() flags?
       =09 - O_SERVER_VARIANT, O_CLIENT_VARIANT, O_RESOLVED_VARIANT
       - fcntl() to switch variants?

 (7) GUI integration.

     - Entering/exiting disconnected mode notification/switches.
     - Resolution required notification.
     - Cache getting full notification.

Can anyone think of any more considerations?  What do you think of the
proposed error codes and open flags?  Is that the best way to do this?

David

