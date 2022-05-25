Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83747533F15
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 May 2022 16:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242606AbiEYO0Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 May 2022 10:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232660AbiEYO0P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 May 2022 10:26:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B2D49DFC1
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 May 2022 07:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653488773;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=DviXGUPuVXl1YVhpu7BiGSF4HSycXcqvMbHaLdNKhAE=;
        b=LCPvpKFGNyRkseFoRapeSfZ6dsCTk4Q24/Io8m/bCfC5ufEDRsU3GeWEndUpfY66pycutO
        PJWzv/UTplhh2VuPkgvUc387B6SBeBoV0d27nnrM8NpCOPWCRZhDREsQT1CqmGdSaFbdPp
        BFIUiEFuCPp6+xqZjYuzrExdANCpuTE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-584-Izt4Z1b5NHikLOAQDHya0w-1; Wed, 25 May 2022 10:26:10 -0400
X-MC-Unique: Izt4Z1b5NHikLOAQDHya0w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 19F5D811E80;
        Wed, 25 May 2022 14:26:10 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AFFE31410DD5;
        Wed, 25 May 2022 14:26:08 +0000 (UTC)
Subject: [PATCH 0/7] cifs: Use iov_iters down to the network transport
From:   David Howells <dhowells@redhat.com>
To:     Steve French <smfrench@gmail.com>
Cc:     linux-cifs@vger.kernel.org,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Steve French <sfrench@samba.org>, dhowells@redhat.com,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-cifs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 25 May 2022 15:26:08 +0100
Message-ID: <165348876794.2106726.9240233279581920208.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Hi Steve,

Here's a second version of a subset of my cifs-experimental branch.  It alters
the cifs driver to pass iov_iters down to the lowest layers where they can be
passed to the network transport.

I've fixed the RDMA code to work, fixed a few more bugs and addressed most of
checkpatch moans.  Note that there's a bunch of stuff #if'd out in patch 5
that get removed in patch 6 - otherwise diff produces an awful mess.

There's also a couple of changes in patch 7 from Namjae Jeon to make
soft-iWarp work.  Feel free to discard that patch if you get a better version
from him.

I've pushed the patches here also:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=cifs-for-sfrench

David
---
David Howells (6):
      iov_iter: Add a function to extract an iter's buffers to a bvec iter
      iov_iter: Add a general purpose iteration function
      cifs: Add some helper functions
      cifs: Add a function to read into an iter from a socket
      cifs: Change the I/O paths to use an iterator rather than a page list
      cifs: Remove unused code

Namjae Jeon (1):
      cifs, ksmbd: Fix MAX_SGE count for softiwarp


 fs/cifs/cifsencrypt.c     |   40 +-
 fs/cifs/cifsfs.h          |    3 +
 fs/cifs/cifsglob.h        |   29 +-
 fs/cifs/cifsproto.h       |   11 +-
 fs/cifs/cifssmb.c         |  253 +++++---
 fs/cifs/connect.c         |   16 +
 fs/cifs/file.c            | 1269 ++++++++++++-------------------------
 fs/cifs/fscache.c         |   22 +-
 fs/cifs/fscache.h         |   10 +-
 fs/cifs/misc.c            |  109 ----
 fs/cifs/smb2ops.c         |  367 ++++++-----
 fs/cifs/smb2pdu.c         |   35 +-
 fs/cifs/smbdirect.c       |  317 ++++-----
 fs/cifs/smbdirect.h       |    6 +-
 fs/cifs/transport.c       |   37 +-
 fs/ksmbd/transport_rdma.c |    2 +-
 include/linux/uio.h       |    8 +
 lib/iov_iter.c            |  133 ++++
 18 files changed, 1124 insertions(+), 1543 deletions(-)


