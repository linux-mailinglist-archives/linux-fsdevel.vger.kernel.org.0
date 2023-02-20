Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9C969D110
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Feb 2023 17:06:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbjBTQGX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Feb 2023 11:06:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231918AbjBTQGV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Feb 2023 11:06:21 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E681C7F7;
        Mon, 20 Feb 2023 08:06:20 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id s17so928989pgv.4;
        Mon, 20 Feb 2023 08:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bk7vaE/atjJO4Fqu2qGdVLjQ50MCmbikjDKBd/vaAg8=;
        b=GEi5wubyOXRiLewDvnQqPoR/hmDN6Ft464QGxWVh0Vu9Bi0ObftUAC5bmVhJGHmrbP
         m7UXsBgftBcPDt1zEkgU8wttqfrnyA3TPQtVOHfU9DtAOlaIX6w886NjvyPuCFmqw5tp
         B2ptBpqRYTGoDCK6eBOt00d26oln3e4BnwfMcjF/TM3gi5I+/HBprY0hDxT4IkAVZxry
         WRkCDQmIv9qaPZ4n6ZiAk00DM8MPPaqk5Xa3O+goNvjrSD8neRjjpgDYKd9n1kM+O8jB
         IX5C6HOJGFqXEJ/V8zBxK7n5XYwolR/gXh0HRRyT0vkSAvVRPbrJE6jqNtujYXVWg5CA
         4shw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bk7vaE/atjJO4Fqu2qGdVLjQ50MCmbikjDKBd/vaAg8=;
        b=d/bQdk8tdN51ZXjOEcgBAwxovhY/D0VmVndFaOu4LK3ns6dbB4ZaBsC5ZhgPvUe00K
         Qa+l/ySMl0RKQ/2ZqZG6EZs+Ldhln/LpTGwc07H18EVpH+grjQK3ZiKKylXaVc6sDYrc
         Y76SCLfWn0YFje+LsstXW0MYsLzJaBzQI+NsDNCjt30VpgKQDvQPyGXXL183gCYVdDS5
         rqqna45qP2iCf2PcaMUpBp3YPRSSPLBhhMCKbe4SKndNUPUE4/nXrFbZqx0qnCKojBYv
         I2lvS45ATWGzwfWz8pGGkxPOM8Gk5j+Nta+gaANVGGSBh29zf0WNNph6BhWxpOFdNy2+
         3rjw==
X-Gm-Message-State: AO0yUKUZ12lh0MwEIaWvpZG8xWmyqCY2SAblxZtbnPuMNJzviMtvpHg9
        KtC/foJtdlqEMvRBEz8SNtAxaV6F4BDl4S7j5qA=
X-Google-Smtp-Source: AK7set+7e9q3zUHK5ld4gUKuHY7folcfIERHgVR1fUGHvhtvPFMGMlb+WTahKW+oMlyt3Y3DSG2+/Q==
X-Received: by 2002:aa7:9985:0:b0:593:2289:f01c with SMTP id k5-20020aa79985000000b005932289f01cmr3086487pfh.25.1676909179633;
        Mon, 20 Feb 2023 08:06:19 -0800 (PST)
Received: from localhost.localdomain ([117.176.249.147])
        by smtp.gmail.com with ESMTPSA id x17-20020a62fb11000000b005893f281d43sm7830958pfm.27.2023.02.20.08.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 08:06:19 -0800 (PST)
From:   Moonlinh <jinhaochen.cloud@gmail.com>
X-Google-Original-From: Moonlinh <moonlinh@MoonLinhdeMacBook-Air.local>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        brauner@kernel.org
Cc:     Moonlinh <moonlinh@MoonLinhdeMacBook-Air.local>
Subject: [PATCH 1/1] *** fix potential NULL dereference in real_cred ***
Date:   Tue, 21 Feb 2023 00:04:28 +0800
Message-Id: <20230220160429.2950-1-moonlinh@MoonLinhdeMacBook-Air.local>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
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

*** BLURB HERE ***

ChenJinhao (1):
    fix NULL dereference in real_cred

    When PAUSE-Loop-Exiting is triggered, it is possible that task->real_cred
    will be set to NULL. In this case, directly parsing euid and egid of real_cred in
    task_dump_owner will lead to NULL dereference and cause kernel panic like below.

     #1 [ffff97eb73757938] __crash_kexec at ffffffff8655bbdd
     #2 [ffff97eb73757a00] crash_kexec at ffffffff8655cabd
     #3 [ffff97eb73757a18] oops_end at ffffffff86421edd
     #4 [ffff97eb73757a38] no_context at ffffffff8646978e
     #5 [ffff97eb73757a90] do_page_fault at ffffffff8646a2c2
     #6 [ffff97eb73757ac0] page_fault at ffffffff86e0120e
        [exception RIP: task_dump_owner+47]
        RIP: ffffffff867496cf  RSP: ffff97eb73757b78  RFLAGS: 00010246
        RAX: 0000000000000000  RBX: ffff89fbb63dbd80  RCX: ffff89bb687677c0
        RDX: ffff89bb687677bc  RSI: 000000000000416d  RDI: ffff89fbb63dbd80
        RBP: 0000000000000000   R8: ffff89f51e1f5980   R9: 732f373839323734
        R10: 0000000000000006  R11: 0000000000000000  R12: ffff89bb687677c0
        R13: ffff97eb73757c50  R14: ffff89f53b19c7a0  R15: ffff8a75170e2cc0

    euid and egid are temporarily set here, and for certain modes, they will
    be updated to GLOBAL_ROOT_UID/GID by default when make_uid/make_gid
    returns invalid values.

    So, whether the NULL real_cred can also be considered as invalid value, and
    treat the same?

 fs/proc/base.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.24.3 (Apple Git-128)

