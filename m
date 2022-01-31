Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 588D04A49E7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jan 2022 16:12:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359178AbiAaPM5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jan 2022 10:12:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:31976 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345257AbiAaPMz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jan 2022 10:12:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643641974;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=UBuMZR3GQdzPiBlUuQs6kPeXjEyft4S1kfNh1v0fTuU=;
        b=ekhQ565rb4gXzqVDswzvhL5aOi8UhrQePeVJrUf8f65tDwyDD3TQI85QTYeeJuwGArTs/X
        S2KWYaHiedJQDGXFm6yN8Y5WP0E0MiZk5k5MdNPbYPpesShDDUsCIVz3gXhDUxD7hVS+fx
        F1Rpe4gGgr3cA3hOHB1UGqWLDgx1ILE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-265-7rr8uPTHOFyxwdsp32amkA-1; Mon, 31 Jan 2022 10:12:52 -0500
X-MC-Unique: 7rr8uPTHOFyxwdsp32amkA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 350578519E0;
        Mon, 31 Jan 2022 15:12:51 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 12BF47DE26;
        Mon, 31 Jan 2022 15:12:44 +0000 (UTC)
Subject: [RFC][PATCH 0/5] vfs, overlayfs,
 cachefiles: Combine I_OVL_INUSE and S_KERNEL_FILE and split out no-remove
From:   David Howells <dhowells@redhat.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     linux-unionfs@vger.kernel.org, linux-cachefs@redhat.com,
        Miklos Szeredi <miklos@szeredi.hu>, dhowells@redhat.com,
        Christoph Hellwig <hch@infradead.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Jeff Layton <jlayton@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        torvalds@linux-foundation.org, linux-unionfs@vger.kernel.org,
        linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 31 Jan 2022 15:12:44 +0000
Message-ID: <164364196407.1476539.8450117784231043601.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Hi Amir,

How about this as a set of patches to do what you suggest[1] and hoist the
handler functions for I_OVL_INUSE into common code and rename the flag to
I_EXCL_INUSE.  This can then be shared with cachefiles - allowing me to get
rid of S_KERNEL_FILE.

I did split out the functionality for preventing file/dir removal to a
separate flag, I_NO_REMOVE, so that it's not tied to I_EXCL_INUSE in case
overlayfs doesn't want to use it.  The downside to that, though is that it
requires a separate locking of i_lock to set/clear it.

I also added four general tracepoints to log successful lock/unlock,
failure to lock and a bad unlock.  The lock tracepoints log which driver
asked for the lock and all tracepoints allow the driver to log an arbitrary
reference number (in cachefiles's case this is the object debug ID).

Questions:

 (1) Should it be using a flag in i_state or a flag in i_flags?  I'm not
     sure what the difference is really.

 (2) Do we really need to take i_lock when testing I_EXCL_INUSE?  Would
     READ_ONCE() suffice?


The patches are on a branch here:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=fscache-fixes

David

Link: https://lore.kernel.org/r/CAOQ4uxhRS3MGEnCUDcsB1RL0d1Oy0g0Rzm75hVFAJw2dJ7uKSA@mail.gmail.com/ [1]

---
David Howells (5):
      vfs, overlayfs, cachefiles: Turn I_OVL_INUSE into something generic
      vfs: Add tracepoints for inode_excl_inuse_trylock/unlock
      cachefiles: Split removal-prevention from S_KERNEL_FILE and extend effects
      cachefiles: Use I_EXCL_INUSE instead of S_KERNEL_FILE
      cachefiles: Remove the now-unused mark-inode-in-use tracepoints


 fs/cachefiles/namei.c             | 54 +++++++++++++-------------
 fs/inode.c                        | 56 +++++++++++++++++++++++++++
 fs/namei.c                        |  8 ++--
 fs/overlayfs/overlayfs.h          |  3 --
 fs/overlayfs/super.c              | 14 ++++---
 fs/overlayfs/util.c               | 43 ---------------------
 include/linux/fs.h                | 33 ++++++++++++++--
 include/trace/events/cachefiles.h | 63 -------------------------------
 8 files changed, 126 insertions(+), 148 deletions(-)


