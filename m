Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A61B58D984
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Aug 2022 15:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243920AbiHINlM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Aug 2022 09:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243890AbiHINlH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Aug 2022 09:41:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 04C9B16597
        for <linux-fsdevel@vger.kernel.org>; Tue,  9 Aug 2022 06:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660052465;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=6JVEXsrvyIxtqd+XMjC/aUVcu6/6RgSK4DxmHm7rQqM=;
        b=JPVIIGfKJ3Ae65EyXp3iPeiPTrtTLyaFsVoCO1uK2R1iCFbipYpIFSVfX5FjlbOHgqnSaW
        94i62lOttZtM0yHny9ZmlMSpEhJX7wLBZI3CM1ZzZI5/2WiQD1P3Hr/Bor1fSmzbP13+kr
        dNh9uLe99DbiiBbOFln/54cijQowe04=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-594-lga5l104PYmOVZA0YUR4ug-1; Tue, 09 Aug 2022 09:41:04 -0400
X-MC-Unique: lga5l104PYmOVZA0YUR4ug-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 457EE185A7B2;
        Tue,  9 Aug 2022 13:41:04 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.14])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7ECB4492C3B;
        Tue,  9 Aug 2022 13:41:03 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
cc:     dhowells@redhat.com, marc.dionne@auristor.com,
        linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] afs: Fix refcount handling
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <432489.1660052462.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 09 Aug 2022 14:41:02 +0100
Message-ID: <432490.1660052462@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Could you pull this pair of patches?  The first patch converts afs to use
refcount_t for its refcounts and the second patch fixes afs_put_call() and
afs_put_server() to save the values they're going to log in the tracepoint
before decrementing the refcount.

Thanks,
David

Reviewed-by: Marc Dionne <marc.dionne@auristor.com>
Tested-by: Marc Dionne <marc.dionne@auristor.com>
---
The following changes since commit 6e7765cb477a9753670d4351d14de93f1e9dbbd=
4:

  Merge tag 'asm-generic-fixes-5.19-2' of git://git.kernel.org/pub/scm/lin=
ux/kernel/git/arnd/asm-generic (2022-07-27 09:50:18 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags=
/afs-fixes-20220802

for you to fetch changes up to 2757a4dc184997c66ef1de32636f73b9f21aac14:

  afs: Fix access after dec in put functions (2022-08-02 18:21:29 +0100)

----------------------------------------------------------------
AFS fixes

----------------------------------------------------------------
David Howells (2):
      afs: Use refcount_t rather than atomic_t
      afs: Fix access after dec in put functions

 fs/afs/cell.c              | 61 ++++++++++++++++++++++-------------------=
-----
 fs/afs/cmservice.c         |  4 +--
 fs/afs/internal.h          | 16 ++++++------
 fs/afs/proc.c              |  6 ++---
 fs/afs/rxrpc.c             | 31 ++++++++++++-----------
 fs/afs/server.c            | 46 ++++++++++++++++++++--------------
 fs/afs/vl_list.c           | 19 +++++----------
 fs/afs/volume.c            | 21 ++++++++++------
 include/trace/events/afs.h | 36 +++++++++++++--------------
 9 files changed, 124 insertions(+), 116 deletions(-)

