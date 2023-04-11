Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD356DD181
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Apr 2023 07:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjDKFWS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Apr 2023 01:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjDKFWO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Apr 2023 01:22:14 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49844E7C;
        Mon, 10 Apr 2023 22:22:14 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id px4so4703468pjb.3;
        Mon, 10 Apr 2023 22:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681190533; x=1683782533;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OL81fOb/bghP+KZDYyDUZj7Mds0Dml+eVfKAg+fWsIE=;
        b=QaRnQs/Bg3Ezx63GwrfdxzmhHh68Ea5XVD5c17J0Rfo0C6YMuicLZpeNQxFx8Jzt4r
         WMg4IPFU69EK37SFlm4gdaH6P4T0/KdpIHVV0j93KXTGRCYikBKyNCzhky6Xpsc0pOzT
         1TRzf+8iGjZBnQjpDJ5ISTP4b6u89Kjj/30kp7S91PM8WyOIZ5NdPIlk41X0iIt4Pe8a
         H5TLK8RiRvC4n7a9hC7RdoWU4o8b1byfu2Ad648ypi+Xt9wC+lhjHjJXEn52op6v8bjH
         /1zuxyXik9yfc6DjdB8QTtZIz4FwKjE4xG0bAb/DVyIZZVt3EZAGTaTqA/QOaqbcDJGI
         bnfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681190533; x=1683782533;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OL81fOb/bghP+KZDYyDUZj7Mds0Dml+eVfKAg+fWsIE=;
        b=P09EuNIi+JQh3SDkz6jj0HnTVL97QolW+PpBAoyDHp2zF2IWdYa5HK7LFhu7Z0f/8s
         LstSyWFittyEh49EoL1i7YIBvnIsVjzfgdt5FmFa/lPg163uE31seEjXi/ICMTWsyChw
         r5JcLY+YnAQNwYqr+FCZQtkwdBrE6p3zRwL8E4JI7XMVXreZxVOf9eWZcbbsppfjmbaa
         BFhtoFSrUCrPjjx5qJ9RHo0tAP/ohXyF8ghmVlLqOidXeP7tScf0q7jTVWllwqVc4WEr
         Fp56lvOvJoQwW0coniHP970tLM3aOJx3tKZwyTWEIjvFZ2iOVndSKuBD+/btJg7Iqf+v
         E71Q==
X-Gm-Message-State: AAQBX9eD07rwf8G6V3DT7ir+1hgZWddrx+OQj1JydVfzQy62Og13gQfV
        0K83ApapU518ZR+mpaeaNL95J6wQhvs=
X-Google-Smtp-Source: AKy350atJBErmdMpdhpSIiNUncNs8hiibGPc2Efo3Sxq0jhq3xVfvIhCPqK6DXm5RrrDbIWLFdC1UA==
X-Received: by 2002:a17:90b:33c3:b0:236:73d5:82cf with SMTP id lk3-20020a17090b33c300b0023673d582cfmr13080391pjb.9.1681190533476;
        Mon, 10 Apr 2023 22:22:13 -0700 (PDT)
Received: from rh-tp.ibmuc.com ([2406:7400:63:7035:9095:349e:5f0b:ded0])
        by smtp.gmail.com with ESMTPSA id v19-20020a17090abb9300b00246d7cd7327sm646154pjr.51.2023.04.10.22.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 22:22:13 -0700 (PDT)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFCv2 1/8] ext2/dax: Fix ext2_setsize when len is page aligned
Date:   Tue, 11 Apr 2023 10:51:49 +0530
Message-Id: <131a7e4a0e020a94c719994867484ba248316d13.1681188927.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1681188927.git.ritesh.list@gmail.com>
References: <cover.1681188927.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

PAGE_ALIGN(x) macro gives the next highest value which is multiple of
pagesize. But if x is already page aligned then it simply returns x.
So, if x passed is 0 in dax_zero_range() function, that means the
length gets passed as 0 to ->iomap_begin().

In ext2 it then calls ext2_get_blocks -> max_blocks as 0 and hits bug_on
here in ext2_get_blocks().
	BUG_ON(maxblocks == 0);

Instead we should be calling dax_truncate_page() here which takes
care of it. i.e. it only calls dax_zero_range if the offset is not
page/block aligned.

This can be easily triggered with following on fsdax mounted pmem
device.

dd if=/dev/zero of=file count=1 bs=512
truncate -s 0 file

[79.525838] EXT2-fs (pmem0): DAX enabled. Warning: EXPERIMENTAL, use at your own risk
[79.529376] ext2 filesystem being mounted at /mnt1/test supports timestamps until 2038 (0x7fffffff)
[93.793207] ------------[ cut here ]------------
[93.795102] kernel BUG at fs/ext2/inode.c:637!
[93.796904] invalid opcode: 0000 [#1] PREEMPT SMP PTI
[93.798659] CPU: 0 PID: 1192 Comm: truncate Not tainted 6.3.0-rc2-xfstests-00056-g131086faa369 #139
[93.806459] RIP: 0010:ext2_get_blocks.constprop.0+0x524/0x610
<...>
[93.835298] Call Trace:
[93.836253]  <TASK>
[93.837103]  ? lock_acquire+0xf8/0x110
[93.838479]  ? d_lookup+0x69/0xd0
[93.839779]  ext2_iomap_begin+0xa7/0x1c0
[93.841154]  iomap_iter+0xc7/0x150
[93.842425]  dax_zero_range+0x6e/0xa0
[93.843813]  ext2_setsize+0x176/0x1b0
[93.845164]  ext2_setattr+0x151/0x200
[93.846467]  notify_change+0x341/0x4e0
[93.847805]  ? lock_acquire+0xf8/0x110
[93.849143]  ? do_truncate+0x74/0xe0
[93.850452]  ? do_truncate+0x84/0xe0
[93.851739]  do_truncate+0x84/0xe0
[93.852974]  do_sys_ftruncate+0x2b4/0x2f0
[93.854404]  do_syscall_64+0x3f/0x90
[93.855789]  entry_SYSCALL_64_after_hwframe+0x72/0xdc

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/ext2/inode.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index 26f135e7ffce..dc76147e7b07 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -1259,9 +1259,8 @@ static int ext2_setsize(struct inode *inode, loff_t newsize)
 	inode_dio_wait(inode);
 
 	if (IS_DAX(inode))
-		error = dax_zero_range(inode, newsize,
-				       PAGE_ALIGN(newsize) - newsize, NULL,
-				       &ext2_iomap_ops);
+		error = dax_truncate_page(inode, newsize, NULL,
+					  &ext2_iomap_ops);
 	else
 		error = block_truncate_page(inode->i_mapping,
 				newsize, ext2_get_block);
-- 
2.39.2

