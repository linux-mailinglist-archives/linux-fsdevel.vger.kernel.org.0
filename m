Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2778263CB90
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Nov 2022 00:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236904AbiK2XIk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Nov 2022 18:08:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236189AbiK2XIj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Nov 2022 18:08:39 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F4D1A068
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Nov 2022 15:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669763262;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=oMa2uu1VnW1WU7rjJdYCJMMwxO+OfF80d7djnZeZTgM=;
        b=FeOWm73JVaSpubeRHQsgCdzA8uYF0GXTkcdqvbXXaUNS+1+GuYL0bdla1gC99q0PTK/Zun
        2s+sS+1SNiCiac1cLSMclk3W6g3QSY+dIDwRJZD2+oF56h040mJSMNqP9Yg0MDu6/zXaSC
        Uo9jiKD8o8K9/LtJtcjCIU0TuGx59WY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-274-hyrVS8IsP96DRaqZfcC__w-1; Tue, 29 Nov 2022 18:07:39 -0500
X-MC-Unique: hyrVS8IsP96DRaqZfcC__w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B5BF33C0257D;
        Tue, 29 Nov 2022 23:07:38 +0000 (UTC)
Received: from pasta.redhat.com (ovpn-192-2.brq.redhat.com [10.40.192.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EFD8340C6EC4;
        Tue, 29 Nov 2022 23:07:36 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Josef Bacik <josef@redhat.com>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org
Subject: [RFC 0/3] Shut down frozen filesystems on last unmount
Date:   Wed, 30 Nov 2022 00:07:32 +0100
Message-Id: <20221129230736.3462830-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

currently, when a frozen filesystem is unmouted, it turns into a zombie
rather than being shut down; it can only be shut down after remounting
and thawing it.  That's silly for local filesystems, but it's worse for
filesystems like gfs2 which freeze the filesystem on all nodes when
fsfreeze is called on any of the nodes: there, the nodes that didn't
initiate the freeze cannot shut down the filesystem at all.

This is a non-working, first shot at allowing filesystems to shut down
on the last unmount.  Could you please have a look to let me know if
something like this makes sense?

The three patches in this series can be found at the tail of this tree:

https://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git/log/?h=freeze%2bumount

The vfs patches apply directly on top of v6.1-rc5 -ish kernels.

The gfs2 patch depends on previous patches in the above tree, so please
grab that if you want the full context.

Thanks a lot,
Andreas

Andreas Gruenbacher (3):
  fs: Add activate_super function
  fs: Introduce { freeze, thaw }_active_super functions
  gfs2: Shut down frozen filesystem on last unmount

 fs/gfs2/glops.c    | 17 ++-------
 fs/gfs2/super.c    | 27 ++++++++++----
 fs/super.c         | 89 +++++++++++++++++++++++++++++++++++++++++-----
 include/linux/fs.h |  3 ++
 4 files changed, 108 insertions(+), 28 deletions(-)

-- 
2.38.1

