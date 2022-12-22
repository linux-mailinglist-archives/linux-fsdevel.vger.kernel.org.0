Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9896540AD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Dec 2022 13:05:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235576AbiLVMFY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Dec 2022 07:05:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235788AbiLVMFB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Dec 2022 07:05:01 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A1D389D4
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Dec 2022 03:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671710171;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=mRKidmqSKLNtQGQfAKwhWxh0PYTmuJUINjlyOCWghFA=;
        b=i3EvwZ6UZOpaI2V5jSQwAeLgWIaIpgBbVe1CM9FUMrb5VmWYREGjbgSpFTtm17XzabOPFq
        zgwvgSXt595y9rpm5LlZfu2bsOPD1Cx777cPMhQyYOyInD+WLvpcxBk2BlE8X6OI46kwJg
        SUTREB9jhRoVNJEjEvctowa3TUakqK8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-494-eNQ5OV07MFODFRfd2A4wtw-1; Thu, 22 Dec 2022 06:56:08 -0500
X-MC-Unique: eNQ5OV07MFODFRfd2A4wtw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 936FA381A733;
        Thu, 22 Dec 2022 11:56:07 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.96])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 472372026D4B;
        Thu, 22 Dec 2022 11:56:06 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
cc:     dhowells@redhat.com, Marc Dionne <marc.dionne@auristor.com>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        Colin Ian King <colin.i.king@gmail.com>,
        linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] afs: A fix, two cleanups and writepage removal
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2219504.1671710165.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Thu, 22 Dec 2022 11:56:05 +0000
Message-ID: <2219505.1671710165@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Could you pull this please?  There's a fix for a couple of missing resourc=
e
counter decrements, two small cleanups of now-unused bits of code and a
patch to remove writepage support from afs.

Thanks,
David
---
The following changes since commit b6bb9676f2165d518b35ba3bea5f1fcfc0d969b=
f:

  Merge tag 'm68knommu-for-v6.2' of git://git.kernel.org/pub/scm/linux/ker=
nel/git/gerg/m68knommu (2022-12-20 08:56:35 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags=
/afs-next-20221222

for you to fetch changes up to a9eb558a5bea66cc43950632f5fffec6b5795233:

  afs: Stop implementing ->writepage() (2022-12-22 11:40:35 +0000)

----------------------------------------------------------------
afs next

----------------------------------------------------------------
Colin Ian King (1):
      afs: remove variable nr_servers

David Howells (2):
      afs: Fix lost servers_outstanding count
      afs: Stop implementing ->writepage()

Gaosheng Cui (1):
      afs: remove afs_cache_netfs and afs_zap_permits() declarations

 fs/afs/dir.c      |  1 +
 fs/afs/file.c     |  3 +-
 fs/afs/fs_probe.c |  5 +++-
 fs/afs/internal.h |  8 ------
 fs/afs/volume.c   |  6 +---
 fs/afs/write.c    | 83 +++++++++++++++++++++++++++++++-------------------=
-----
 6 files changed, 55 insertions(+), 51 deletions(-)

