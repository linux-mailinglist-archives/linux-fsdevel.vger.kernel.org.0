Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A17786F4867
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 May 2023 18:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233669AbjEBQh1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 May 2023 12:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233645AbjEBQhN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 May 2023 12:37:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9231D4481
        for <linux-fsdevel@vger.kernel.org>; Tue,  2 May 2023 09:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683045337;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=1VegwhAhzGvPahb0A/LosE8qZpmtBgm9WYeZluYuAXE=;
        b=ihYb/MxboMuznUSspU9EswfZWofe06rj1adzo6WMfuV+RtGDpdyLnH9x2NQWSMjxvOxxZY
        rRMYEDWwdAiP2IY0wzlnFC4bAf7N56+SCmDTxrpzDkOPjL+rSKVqNqd80fhrcEmRUIIsl0
        vq1ionHKnKZvZ91fBMs+T+zRhNB0oCY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-130-bbzCkDxrOqK36xh9V7qDNw-1; Tue, 02 May 2023 12:35:34 -0400
X-MC-Unique: bbzCkDxrOqK36xh9V7qDNw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E5B933C025A1;
        Tue,  2 May 2023 16:35:33 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 070A163F4A;
        Tue,  2 May 2023 16:35:32 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Howells <dhowells@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] afs: Fix directory size handling
Date:   Tue,  2 May 2023 17:35:25 +0100
Message-Id: <20230502163528.1564398-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

 (3) Prevent afs_read_dir() from getting into an endless loop if the server
     indicates that the directory file size is larger than expected.

The patches can be found here:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=afs-fixes

Thanks,
David

---
%(shortlog)s
%(diffstat)s

David Howells (1):
  afs: Fix getattr to report server i_size on dirs, not local size

Marc Dionne (2):
  afs: Fix updating of i_size with dv jump from server
  afs: Avoid endless loop if file is larger than expected

 fs/afs/dir.c   |  4 ++++
 fs/afs/inode.c | 10 +++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

