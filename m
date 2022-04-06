Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F31604F6E2C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Apr 2022 01:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237487AbiDFXFA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Apr 2022 19:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237485AbiDFXE7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Apr 2022 19:04:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 416C9F3A63
        for <linux-fsdevel@vger.kernel.org>; Wed,  6 Apr 2022 16:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649286181;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=TVUTDEn4ajQnJg0xbfI7sdT5Px6RGo8oRV8kyeHSPWk=;
        b=aEX+ukw0/od0NU0JlLOMYyNK8v8/OfRD7UMa+4AjsEj2FpqqQcxor0Ry3SevIJOhHjkIbc
        TjwS/jtQB33aRsdGGdXXjDZREuHrqqUUXE2ZTbDnERtnCf5gMKMIRODXtpZ0kkO60Kkuys
        xGGIZvkdhg3n4KFSCoC/FFIt5lRTI0I=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-554-kFMLqPKjMCOt5JMsgkA9fg-1; Wed, 06 Apr 2022 19:02:58 -0400
X-MC-Unique: kFMLqPKjMCOt5JMsgkA9fg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DAA103C00135;
        Wed,  6 Apr 2022 23:02:41 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.37.45])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9EFCC2024CBB;
        Wed,  6 Apr 2022 23:02:31 +0000 (UTC)
Subject: [PATCH 00/14] cifs: Iterators, netfslib and folios
From:   David Howells <dhowells@redhat.com>
To:     linux-cachefs@redhat.com
Cc:     Matthew Wilcox <willy@infradead.org>, linux-cifs@vger.kernel.org,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Steve French <sfrench@samba.org>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        dhowells@redhat.com, Steve French <sfrench@samba.org>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Jeff Layton <jlayton@redhat.com>, linux-cifs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Date:   Thu, 07 Apr 2022 00:02:30 +0100
Message-ID: <164928615045.457102.10607899252434268982.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Here's a set of patches to make the following changes to the cifs
filesystem driver:

 (1) Convert cifs to use I/O iterators to pass data/buffers from the the VM
     interface layer down to the socket rather than passing page lists
     about.

 (2) Convert cifs to use netfslib for buffered and direct read operations.

 (3) A partial conversion to folios.

This branch is built on top of my netfs-lib branch[1].

The patches can be found here also:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=cifs-experimental


David

Link: https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=netfs-lib [1]
---
David Howells (14):
      cifs: Add some helper functions
      cifs: Add a function to read into an iter from a socket
      cifs: Check the IOCB_DIRECT flag, not O_DIRECT
      cifs: Change the I/O paths to use an iterator rather than a page list
      cifs: Remove unused code
      cifs: Use netfslib to handle reads
      cifs: Share server EOF pos with netfslib
      netfs: Allow the netfs to make the io (sub)request alloc larger
      cifs: Put credits into cifs_io_subrequest, not on the stack
      cifs: Hold the open file on netfs_io_request, not netfs_io_subrequest
      cifs: Clamp length according to credits and rsize
      cifs: Expose netfs subrequest debug ID and index in read tracepoints
      cifs: Split the smb3_add_credits tracepoint
      mm, netfs, fscache: Stop read optimisation when folio removed from pagecache


 fs/afs/file.c           |    1 +
 fs/afs/inode.c          |    1 +
 fs/afs/internal.h       |    2 +
 fs/cifs/Kconfig         |    1 +
 fs/cifs/cifsencrypt.c   |   40 +-
 fs/cifs/cifsfs.c        |   11 +-
 fs/cifs/cifsfs.h        |    6 +-
 fs/cifs/cifsglob.h      |   53 +-
 fs/cifs/cifsproto.h     |   13 +-
 fs/cifs/cifssmb.c       |  252 +++--
 fs/cifs/connect.c       |   18 +-
 fs/cifs/file.c          | 2096 ++++++++++-----------------------------
 fs/cifs/fscache.c       |  120 +--
 fs/cifs/fscache.h       |   70 --
 fs/cifs/inode.c         |   22 +-
 fs/cifs/misc.c          |  109 --
 fs/cifs/smb2ops.c       |  387 ++++----
 fs/cifs/smb2pdu.c       |   85 +-
 fs/cifs/smb2proto.h     |    2 +-
 fs/cifs/trace.h         |  151 ++-
 fs/cifs/transport.c     |   41 +-
 fs/netfs/internal.h     |    1 +
 fs/netfs/io.c           |    7 +-
 fs/netfs/misc.c         |   13 +-
 fs/netfs/stats.c        |    9 +-
 include/linux/fs.h      |    2 +
 include/linux/netfs.h   |    1 +
 include/linux/pagemap.h |    1 +
 mm/filemap.c            |   15 +
 29 files changed, 1203 insertions(+), 2327 deletions(-)


