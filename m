Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49ED652028B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 May 2022 18:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239129AbiEIQkJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 May 2022 12:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239096AbiEIQkI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 May 2022 12:40:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BEBDF29807
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 May 2022 09:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652114172;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Eyh+GkUIjInk6dzNgMJ6R+vYntN/YZ9qITuyfspnKDk=;
        b=IpNp/HoqOAd8XoVBl8bp9M/U6WIMOT8/wHC24O1/X4xE/RUdufk7GOfFPdoeqJWNCeblnh
        XTUNF1vIWdrj7ZKjcba0g8kKqc99sKLUX46in3jxs34/r8CDMe6Oe/RTrt9TMoD9vdSHXa
        +rWQQxp0i485Lil7W+9xeaWwuS7ZtVw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-96-kfTNfK7UN0ae-0bA17BIZg-1; Mon, 09 May 2022 12:36:09 -0400
X-MC-Unique: kfTNfK7UN0ae-0bA17BIZg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0E498803D45;
        Mon,  9 May 2022 16:36:09 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.37.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9D118415F5F;
        Mon,  9 May 2022 16:36:07 +0000 (UTC)
Subject: [PATCH 0/6] cifs: Use iov_iters down to the network transport
From:   David Howells <dhowells@redhat.com>
To:     Steve French <smfrench@gmail.com>
Cc:     Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        dhowells@redhat.com, Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-cifs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 09 May 2022 17:36:06 +0100
Message-ID: <165211416682.3154751.17287804906832979514.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Hi Steve,

Here's a subset of my cifs-experimental branch.  It alters the cifs driver
to pass iov_iters down to the lowest layers where they can be passed to the
network transport.

I've fixed a couple of bugs in it also, including the RCU warning you were
seeing.  I'm seeing some slow calls, however, but I'm not sure how to debug
them.  RDMA also needs looking at, but I'm not sure how the RDMA API works.

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


 fs/cifs/cifsencrypt.c |   40 +-
 fs/cifs/cifsfs.h      |    3 +
 fs/cifs/cifsglob.h    |   28 +-
 fs/cifs/cifsproto.h   |   11 +-
 fs/cifs/cifssmb.c     |  225 +++++---
 fs/cifs/connect.c     |   16 +
 fs/cifs/file.c        | 1263 ++++++++++++++---------------------------
 fs/cifs/misc.c        |  109 ----
 fs/cifs/smb2ops.c     |  366 ++++++------
 fs/cifs/smb2pdu.c     |   12 +-
 fs/cifs/transport.c   |   37 +-
 include/linux/uio.h   |    8 +
 lib/iov_iter.c        |  133 +++++
 13 files changed, 935 insertions(+), 1316 deletions(-)


