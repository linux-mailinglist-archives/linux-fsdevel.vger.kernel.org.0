Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 929E16EFF4F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Apr 2023 04:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242876AbjD0CVj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Apr 2023 22:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242557AbjD0CVi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Apr 2023 22:21:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38BF03A87
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Apr 2023 19:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682562042;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=GCPcaFdJ9SvoZ93cdbG0lFwwi9Thl1ubA5vESylOj3g=;
        b=AZ0A3vaUSsHAiYC/hS1pNni0HQ/kEMZXoWg027oDxcjYye4xBa5FdzBNDL1YW2V2C9MEyU
        S5gI86ZsuGKAXgIoDv/kpI7sDYmK189q1hGrVGEucMPxwVE+PZZ81DCdsaN6vaUyMH+CZ+
        qQ8yOu2fr3Uqaf9WLnAsMZiAm93Raw4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-605-aRep1uVGPCu1PlVejb15nA-1; Wed, 26 Apr 2023 22:20:40 -0400
X-MC-Unique: aRep1uVGPCu1PlVejb15nA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5842B29A9D28;
        Thu, 27 Apr 2023 02:20:40 +0000 (UTC)
Received: from ovpn-8-24.pek2.redhat.com (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C35681121314;
        Thu, 27 Apr 2023 02:20:33 +0000 (UTC)
Date:   Thu, 27 Apr 2023 10:20:28 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org
Cc:     ming.lei@redhat.com, Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-block@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Dave Chinner <dchinner@redhat.com>,
        Eric Sandeen <sandeen@redhat.com>,
        Christoph Hellwig <hch@lst.de>, Zhang Yi <yi.zhang@redhat.com>
Subject: [ext4 io hang] buffered write io hang in balance_dirty_pages
Message-ID: <ZEnb7KuOWmu5P+V9@ovpn-8-24.pek2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Guys,

I got one report in which buffered write IO hangs in balance_dirty_pages,
after one nvme block device is unplugged physically, then umount can't
succeed.

Turns out it is one long-term issue, and it can be triggered at least
since v5.14 until the latest v6.3.

And the issue can be reproduced reliably in KVM guest:

1) run the following script inside guest:

mkfs.ext4 -F /dev/nvme0n1
mount /dev/nvme0n1 /mnt
dd if=/dev/zero of=/mnt/z.img&
sleep 10
echo 1 > /sys/block/nvme0n1/device/device/remove

2) dd hang is observed and /dev/nvme0n1 is gone actually

[root@ktest-09 ~]# ps -ax | grep dd
   1348 pts/0    D      0:33 dd if=/dev/zero of=/mnt/z.img
   1365 pts/0    S+     0:00 grep --color=auto dd

[root@ktest-09 ~]# cat /proc/1348/stack
[<0>] balance_dirty_pages+0x649/0x2500
[<0>] balance_dirty_pages_ratelimited_flags+0x4c6/0x5d0
[<0>] generic_perform_write+0x310/0x4c0
[<0>] ext4_buffered_write_iter+0x130/0x2c0 [ext4]
[<0>] new_sync_write+0x28e/0x4a0
[<0>] vfs_write+0x62a/0x920
[<0>] ksys_write+0xf9/0x1d0
[<0>] do_syscall_64+0x59/0x90
[<0>] entry_SYSCALL_64_after_hwframe+0x63/0xcd


[root@ktest-09 ~]# lsblk | grep nvme
[root@ktest-09 ~]#

BTW, my VM sets 2G ram, and the nvme disk size is 40GB.

So far only observed on ext4 FS, not see it on XFS. I guess it isn't
related with disk type, and not tried such test on other type of disks yet,
but will do.

Seems like dirty pages aren't cleaned after ext4 bio is failed in this
situation?


Thanks,
Ming

