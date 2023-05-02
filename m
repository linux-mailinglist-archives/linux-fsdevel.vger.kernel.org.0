Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0766F49A4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 May 2023 20:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233955AbjEBSXA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 May 2023 14:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjEBSW5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 May 2023 14:22:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B930C197
        for <linux-fsdevel@vger.kernel.org>; Tue,  2 May 2023 11:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683051727;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=mUsCC6BRu1wAgmjm+W7fv+mnroL8pCHvi0QoCItydVY=;
        b=aeVeKqzhB905GX+10rjoIVSXrb31KLapjBWlRY2r/oiZPHG/WHuVebeISiwMTdBXw5pimw
        pR50N1DVpkS3IjYrn/PyvG0R+nnNzvqExoD/QvgfEg/DBUwmlsONTRqUp75ixx5eL92pbU
        vG4ezXNCm8SnyJaFVtJrczjOgDK1e+I=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-198-VPhYOgCoNHyawjnCFdSdWQ-1; Tue, 02 May 2023 14:22:01 -0400
X-MC-Unique: VPhYOgCoNHyawjnCFdSdWQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5C79B3825BA7;
        Tue,  2 May 2023 18:22:01 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.12])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AA0A61410F24;
        Tue,  2 May 2023 18:22:00 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Howells <dhowells@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] afs: Fix directory size handling
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1647978.1683051720.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 02 May 2023 19:22:00 +0100
Message-ID: <1647979.1683051720@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Could you apply these three fixes to AFS directory handling?

 (1) Make sure that afs_read_dir() sees any increase in file size if the
     file unexpectedly changed on the server (e.g. due to another client
     making a change).

 (2) Make afs_getattr() always return the server's dir file size, not the
     locally edited one, so that pagecache eviction doesn't cause the dir
     file size to change unexpectedly.

 (3) Prevent afs_read_dir() from getting into an endless loop if the serve=
r
     indicates that the directory file size is larger than expected.

Thanks,
David
---
The following changes since commit 865fdb08197e657c59e74a35fa32362b12397f5=
8:

  Merge tag 'input-for-v6.4-rc0' of git://git.kernel.org/pub/scm/linux/ker=
nel/git/dtor/input (2023-05-01 17:18:56 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags=
/afs-fixes-20230502

for you to fetch changes up to 9ea4eff4b6f4f36546d537a74da44fd3f30903ab:

  afs: Avoid endless loop if file is larger than expected (2023-05-02 17:2=
3:50 +0100)

----------------------------------------------------------------
AFS fixes

----------------------------------------------------------------
David Howells (1):
      afs: Fix getattr to report server i_size on dirs, not local size

Marc Dionne (2):
      afs: Fix updating of i_size with dv jump from server
      afs: Avoid endless loop if file is larger than expected

 fs/afs/dir.c   |  4 ++++
 fs/afs/inode.c | 10 +++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

