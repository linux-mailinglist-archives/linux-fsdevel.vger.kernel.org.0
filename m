Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53B6959E88A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Aug 2022 19:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245609AbiHWRBl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Aug 2022 13:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343879AbiHWRAa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Aug 2022 13:00:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 685D19E0C4
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Aug 2022 07:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661263931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=kYvU0b08zm/V0xwR5oEjOP2aPgvABHjHuDzOrfSOpNM=;
        b=SNhGjETS3Z4+/9rf3h/DpUu/VQMwhASzBJQT6/iFa08J0vT0yYQc6QDmQgN50b3JzoV5Cc
        D7AbTJR7kiu4c3ZQBhGxANpE9RHImsGIPwtdCueArkp/ZEE20ehQkCbiX12fX54p8F7hLL
        nbvs50GnsTQxX7Ho7guv5/6D2L/91sw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-453-IILv1f45PVWyhyOEee0mzQ-1; Tue, 23 Aug 2022 10:12:10 -0400
X-MC-Unique: IILv1f45PVWyhyOEee0mzQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E47CC3C0D85A;
        Tue, 23 Aug 2022 14:12:08 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C00AC40CF8E7;
        Tue, 23 Aug 2022 14:12:07 +0000 (UTC)
Subject: [PATCH 0/7] smb3: Add iter helpers and use iov_iters down to the
 network transport
From:   David Howells <dhowells@redhat.com>
To:     Steve French <smfrench@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-cifs@vger.kernel.org, Steve French <sfrench@samba.org>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Shyam Prasad N <nspmangalore@gmail.com>, dhowells@redhat.com,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, linux-cifs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 23 Aug 2022 15:12:07 +0100
Message-ID: <166126392703.708021.14465850073772688008.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Hi Steve, Al,

Here's an updated version of a subset of my branch to make the cifs/smb3
driver pass iov_iters down to the lowest layers where they can be passed to
the network transport.

Al: Could you look at the first two patches, that add extract_iter_to_iter()
to see about decanting iterators of various types (but that might have to be
lost) into iterators that can be held on to (pinning pages in the process),
and iov_iter_scan() which passes each partial page of an iterator to a scanner
function to do something with (such as create an sglist element for).

Possibly I should add an extract_iter_to_sglist() - I'm doing that in a number
of places.

Steve: assuming Al is okay with the iov_iter patches, can you look at taking
this into your tree (or should it go through mine?)?

I've pushed the patches here also:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=cifs-for-viro

David
---
David Howells (7):
      iov_iter: Add a function to extract an iter's buffers to a bvec iter
      iov_iter: Add a general purpose iteration function
      cifs: Add some helper functions
      cifs: Add a function to read into an iter from a socket
      cifs: Change the I/O paths to use an iterator rather than a page list
      cifs: Remove unused code
      cifs: Add some RDMA send tracepoints


 fs/cifs/cifsencrypt.c |   40 +-
 fs/cifs/cifsfs.h      |    3 +
 fs/cifs/cifsglob.h    |   28 +-
 fs/cifs/cifsproto.h   |   11 +-
 fs/cifs/cifssmb.c     |   13 +-
 fs/cifs/connect.c     |   16 +
 fs/cifs/file.c        | 1653 ++++++++++++++++++-----------------------
 fs/cifs/fscache.c     |   22 +-
 fs/cifs/fscache.h     |   10 +-
 fs/cifs/misc.c        |  108 ---
 fs/cifs/smb2ops.c     |  369 +++++----
 fs/cifs/smb2pdu.c     |   44 +-
 fs/cifs/smbdirect.c   |  335 ++++-----
 fs/cifs/smbdirect.h   |    4 +-
 fs/cifs/trace.h       |   95 +++
 fs/cifs/transport.c   |   54 +-
 include/linux/uio.h   |    8 +
 lib/iov_iter.c        |  159 +++-
 18 files changed, 1391 insertions(+), 1581 deletions(-)


