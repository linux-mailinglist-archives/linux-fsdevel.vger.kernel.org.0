Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5F6770FE6
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Aug 2023 15:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjHENUq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 5 Aug 2023 09:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjHENUp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 5 Aug 2023 09:20:45 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF8810DC;
        Sat,  5 Aug 2023 06:20:44 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-687087d8ddaso2834044b3a.1;
        Sat, 05 Aug 2023 06:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691241644; x=1691846444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7KV92l3VXPcz++LN5c2ebdhb5o5BZtos4ufCZ4CtDds=;
        b=WzzZvM9gTNfDEIujV/M/qP23gW84ZJ2QwT3vGcElbafal6B4GJAWzGfq65IuYQspFd
         gB/lcTu47O6lvi9g0BWOSx/FY4tV+cUrrStbyc9VWja/K7OPaz/vKSPiFYpX8tv71em2
         ZS4pm+lTsHMveKT9TIgENcQ2wGyN3rONNR69dkHYE0cZx1G4soMxUQvwgFDfu13B2wft
         il08WTfFQKpjUoUI5+qGJuaa+cpH8Nt1DwEP48SfsRWHtiFsWR0L/ZkCLMU+itBLdOsx
         9w7VGk2JXE4TIJ0Bqn0sLDwsukKsPtiXjH87i3+s+f5qg2vk1NgnG/PgOpgtUQa1npQM
         uMqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691241644; x=1691846444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7KV92l3VXPcz++LN5c2ebdhb5o5BZtos4ufCZ4CtDds=;
        b=EJTiI00mt+EqwLVcLV74oG4Rb4MGRKVAMIO/E61CAE6CUg+/GGBG/ZkuxGZaethKUD
         PHqyzb91NOz7ce8UkjMu9lpw6hzAn/eBcgw5QcpMRPtnXzlyqkXVbYaRa8teI0ck8SD4
         uUCH4WLMJ14Ddbp/Yscg9fbgPb9Nq5q0KD7uqkKxoB8jQw80+BwecJcl4hf6iadYfVgI
         DQaxe/as+Pa2sZ2OJ2TrZdBaQbzwndMTNZcW4vasznACvIZqzljcyFbrSo29s5v6SnV8
         JmBKcV8A4RKv8ztMVv1VMJ6LOATX3SjqhIhMgVCP29sy21EE0mr852wQOsxio+rvkccU
         qe0g==
X-Gm-Message-State: AOJu0YxH/91WHEc5M6eb1XnOiKZej7qQfiM7An4GQb87xZeX2S6GJv24
        dIwh63es6kbzujLxHtaBEvmM0rN9BOk=
X-Google-Smtp-Source: AGHT+IE+ZWnyUHwvDnWEAGxCE26FCu7oRJ5qmrLUehsrXDKwj3D8WdeAhfokpYuhH+xWhRRtA+51Ww==
X-Received: by 2002:a05:6a00:1583:b0:687:40d8:8869 with SMTP id u3-20020a056a00158300b0068740d88869mr6407940pfk.8.1691241643722;
        Sat, 05 Aug 2023 06:20:43 -0700 (PDT)
Received: from carrot.. (i60-34-120-249.s42.a014.ap.plala.or.jp. [60.34.120.249])
        by smtp.gmail.com with ESMTPSA id d17-20020aa78151000000b0068675835e10sm3166507pfn.44.2023.08.05.06.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Aug 2023 06:20:42 -0700 (PDT)
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-nilfs@vger.kernel.org,
        syzbot <syzbot+0ad741797f4565e7e2d2@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH] nilfs2: fix general protection fault in nilfs_lookup_dirty_data_buffers()
Date:   Sat,  5 Aug 2023 22:20:38 +0900
Message-Id: <20230805132038.6435-1-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <0000000000002930a705fc32b231@google.com>
References: <0000000000002930a705fc32b231@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A syzbot stress test reported that create_empty_buffers() called from
nilfs_lookup_dirty_data_buffers() can cause a general protection fault.

Analysis using its reproducer revealed that the back reference "mapping"
from a page/folio has been changed to NULL after dirty page/folio gang
lookup in nilfs_lookup_dirty_data_buffers().

Fix this issue by excluding pages/folios from being collected if, after
acquiring a lock on each page/folio, its back reference "mapping"
differs from the pointer to the address space struct that held the
page/folio.

Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Reported-by: syzbot+0ad741797f4565e7e2d2@syzkaller.appspotmail.com
Closes: https://lkml.kernel.org/r/0000000000002930a705fc32b231@google.com
Tested-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: <stable@vger.kernel.org>
---
 fs/nilfs2/segment.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index 581691e4be49..7ec16879756e 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -725,6 +725,11 @@ static size_t nilfs_lookup_dirty_data_buffers(struct inode *inode,
 		struct folio *folio = fbatch.folios[i];
 
 		folio_lock(folio);
+		if (unlikely(folio->mapping != mapping)) {
+			/* Exclude folios removed from the address space */
+			folio_unlock(folio);
+			continue;
+		}
 		head = folio_buffers(folio);
 		if (!head) {
 			create_empty_buffers(&folio->page, i_blocksize(inode), 0);
-- 
2.34.1

