Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4B1A7358EF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jun 2023 15:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbjFSNtl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jun 2023 09:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232070AbjFSNtk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jun 2023 09:49:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA2F6E59
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Jun 2023 06:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687182533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=rbkpbKU4zNImW8Ox6PAE6hc6BtGlcpoEWuzNxPHb0d0=;
        b=K0sprwQajuQTdgdU35KEMphiA3Zo6KKu//vetITinRSqdAnbVbiVlqc/0DrB7ZfL9Ej6lx
        an4IDeAc0O3r/e2+gidR09aoniNqBl0GDBozrCXFU5f/JKH8xIp1s0RzhIJOcPFW5Pqfmf
        /U60sKhVROfSBqAkScoitrwJGK/lkFw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-49-PWi8h3-WO46KN9wJmfBPug-1; Mon, 19 Jun 2023 09:48:50 -0400
X-MC-Unique: PWi8h3-WO46KN9wJmfBPug-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3B1BD2A5956D;
        Mon, 19 Jun 2023 13:48:50 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8850A1415102;
        Mon, 19 Jun 2023 13:48:49 +0000 (UTC)
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
Subject: [GIT PULL] afs: Fix writeback
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <923155.1687182529.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Mon, 19 Jun 2023 14:48:49 +0100
Message-ID: <923156.1687182529@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Could you apply these fixes to AFS writeback code from Vishal?

 (1) Release the acquired batch before returning if we got >=3D5 skips.

 (2) Retry a page we had to wait for rather than skipping over it after th=
e
     wait.

Thanks,
David
---
The following changes since commit 45a3e24f65e90a047bef86f927ebdc4c710edaa=
1:

  Linux 6.4-rc7 (2023-06-18 14:06:27 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags=
/afs-fixes-20230719

for you to fetch changes up to 819da022dd007398d0c42ebcd8dbb1b681acea53:

  afs: Fix waiting for writeback then skipping folio (2023-06-19 14:30:58 =
+0100)

----------------------------------------------------------------
AFS fixes

----------------------------------------------------------------
Vishal Moola (Oracle) (2):
      afs: Fix dangling folio ref counts in writeback
      afs: Fix waiting for writeback then skipping folio

 fs/afs/write.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

