Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AEE349B588
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jan 2022 15:01:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240191AbiAYOBD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jan 2022 09:01:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:45674 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1386772AbiAYN6T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jan 2022 08:58:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643119066;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ow5nEIIpxxsm8kbS7mSXJOPAG/qpnBjx5RaUIpFZ4VQ=;
        b=TdcJZTMyv6WO/ahgARulgJFbKyFA6L71cWZeoM3ek2ropvnD8FT03KzBpEDdTmXbHGYEVH
        5i8PJj+8oaZMnB4hIcyogvb2dVHafp++cFg12ec5grGVIzujqhyFooxY2R69pIIIyw0pu5
        YXLCtQ4u/5sUXgpIO043mLRTsaRTBsw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-157-Q64prpWINnyJ0BEZ04TElA-1; Tue, 25 Jan 2022 08:57:40 -0500
X-MC-Unique: Q64prpWINnyJ0BEZ04TElA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7834A1018722;
        Tue, 25 Jan 2022 13:57:39 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.5])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C4EA27D3D6;
        Tue, 25 Jan 2022 13:57:05 +0000 (UTC)
Subject: [RFC][RFC PATCH 0/7] cifs: In-progress conversion to use iov_iters
 and netfslib
From:   David Howells <dhowells@redhat.com>
To:     smfrench@gmail.com, nspmangalore@gmail.com
Cc:     Matthew Wilcox <willy@infradead.org>, linux-cachefs@redhat.com,
        Jeff Layton <jlayton@kernel.org>, linux-cifs@vger.kernel.org,
        dhowells@redhat.com, jlayton@kernel.org,
        linux-cifs@vger.kernel.org, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org
Date:   Tue, 25 Jan 2022 13:57:04 +0000
Message-ID: <164311902471.2806745.10187041199819525677.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Hi Steve,

Okay, I've has a go at crudely splitting up my conversion of cifs to use
netfslib into separate patches and I thought I'd post it for you and Shyam
to have a look over:

 (1) The conversion from ->readpages() to ->readahead().

 (2) A patch that does some random miscellaneous bits.

 (3) Change the I/O paths to use an iterator all the way to the socket
     instead of a page list.  Note that cifs won't compile from this patch
     until patch 6.

 (4) Replace cifs's writepages implementation with the one from afs and
     make it deal with variable rsize and stuff like that.  This sets up
     iterators rather than page lists.

     This also makes direct/unbuffered write use an iterator.  This
     probably requires more massaging to make it handle credits.

 (5) Modify cifs_readahead() to hand an iterator down.

 (6) Make direct and unbuffered reads hand an iterator down.  Note that the
     iterator refers to the original buffers and bounce pages aren't used.

 (7) Make cifs use netfslib for reading.

As stated, patches 3, 4 and 5 don't compile because the pagelist struct
members disappeared to make way for the iterators.  This avoids duplicating
various functions in the transport and transport security code.  I'm not
sure how best to deal with this - maybe by setting up bvecs instead of
pagelists at the top level and then I can hand a bvec-class iter down.

The patches can also be found here.  Note that this requires some of the
patches from my netfs-lib branch.

https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=cifs-experimental

David
---
David Howells (7):
      cifs: Transition from ->readpages() to ->readahead()
      cifs: Miscellaneous bits
      cifs: Change the I/O paths to use an iterator rather than a page list
      cifs: Make cifs_writepages() hand an iterator down
      cifs: Make cifs_readahead() pass an iterator down
      cifs: Get direct I/O and unbuffered I/O working with iterators
      cifs: Use netfslib to handle reads


 fs/cifs/Kconfig        |    1 +
 fs/cifs/cifsencrypt.c  |   40 +-
 fs/cifs/cifsfs.c       |    8 +-
 fs/cifs/cifsfs.h       |    6 +-
 fs/cifs/cifsglob.h     |   34 +-
 fs/cifs/cifsproto.h    |   11 +-
 fs/cifs/cifssmb.c      |  233 +++--
 fs/cifs/connect.c      |   18 +-
 fs/cifs/file.c         | 1930 ++++++++++------------------------------
 fs/cifs/fscache.c      |   31 -
 fs/cifs/fscache.h      |   52 --
 fs/cifs/inode.c        |   17 +-
 fs/cifs/misc.c         |  109 ---
 fs/cifs/smb2ops.c      |  365 ++++----
 fs/cifs/smb2pdu.c      |   27 +-
 fs/cifs/transport.c    |   37 +-
 fs/netfs/read_helper.c |    7 +-
 17 files changed, 888 insertions(+), 2038 deletions(-)


