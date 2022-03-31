Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0D84ED9E6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Mar 2022 14:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236364AbiCaM4Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Mar 2022 08:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232332AbiCaM4X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Mar 2022 08:56:23 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5715516BF95;
        Thu, 31 Mar 2022 05:54:36 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id f3so20708865pfe.2;
        Thu, 31 Mar 2022 05:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aoMV8SVyn+aPeWyMiwW1EjR7hxG7FkQIb96AQXZmcwk=;
        b=EbdT1yJOJEpA1JUFN3k8oObzwmnqHNgkDj1NDl1aApXJPwbUsWD6CS8E8fR2K/NwwT
         /x5I/DU3/kF2wxoHxWHbbwsfQlRez7zZ3dtccvYZU8I4yJeDe5GmS4LlWO8WJNnPDHxG
         keS4Nf6q7G2R5YiFe6fmq2RnTfxDPcCyT92jwd5/1Io5kaBFcvoMOzME2AhV+4Dlb2gb
         wX5Kv1haKSHSRbdsEojQuIPwwwxFtTk+sKgmoBtxgOiYnfcnOWI87WxfTE3Y5zFtxI5t
         sZcpmGT/NU1Sio00Jer3JJWA8WLvD5o55/zcq6Uki6+qu3K7UjYJuOvpCVLbxOSzqGlm
         lLcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aoMV8SVyn+aPeWyMiwW1EjR7hxG7FkQIb96AQXZmcwk=;
        b=wmMdtDa4UsLHWG+GyAsn3GKBII318k7kvknUrv1TaDrus9njpVLeNYp5/8fbIVuqoM
         UhSrmIyyIdpiffBFqBXT6lbMZMDbZb9iJSzOFCbjqQw1kXLjgLlEbtzjsE1TbVmNpfZB
         bQSV2tTGnO40j0gCltyIJOrnO8FWRoZ3jxhDCrIhefmwG3yc7ENrop23ioIHHNpVHdTb
         rfK7NXLD/vCATOGt4vDfXBfrtgYJGk9G5QcDoORNLXm9c8f+95Y3T79LMmu6Ws4B/6oe
         dHQCz9u9YKDqOlSGO2yqyqFzM97Uxm1eYzz5GJg9c/zrZhGRI7yXX03lhWbj4vRxrYc/
         k4Mg==
X-Gm-Message-State: AOAM532UqWgVI7+etrtPk+/+D7qCF0bDqVk4Z41wPR3Snn5F1CQRjRwo
        8Gd/5wwfV+ngr5KYqW0FxqwekwN6Okw=
X-Google-Smtp-Source: ABdhPJwNuA4rsY6Up/Ixoi+nsdK/+7DxTpDFj4WAdBh6rHEIkEdvGfjw/t8KSVg7aoGWMXMLFeUEnw==
X-Received: by 2002:a63:4d15:0:b0:37f:f622:fe0f with SMTP id a21-20020a634d15000000b0037ff622fe0fmr10624993pgb.68.1648731275708;
        Thu, 31 Mar 2022 05:54:35 -0700 (PDT)
Received: from localhost ([2406:7400:63:7e03:b065:1995:217b:6619])
        by smtp.gmail.com with ESMTPSA id 22-20020a17090a019600b001c6457e1760sm9780194pjc.21.2022.03.31.05.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 05:54:35 -0700 (PDT)
From:   Ritesh Harjani <ritesh.list@gmail.com>
To:     fstests <fstests@vger.kernel.org>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: [PATCHv3 0/4] generic: Add some tests around journal replay/recoveryloop
Date:   Thu, 31 Mar 2022 18:24:19 +0530
Message-Id: <cover.1648730443.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

The ext4 fast_commit kernel fix has landed into mainline tree [1].
In this v3, I have addressed review comments from Darrick.
Does this looks good to be picked up?

I have tested ext4 1k, 4k (w & w/o fast_commit). Also tested other FS with
default configs (like xfs, btrfs, f2fs). No surprises were seen.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=bfdc502a4a4c058bf4cbb1df0c297761d528f54d

-ritesh

Changelogs:
===========

v2 => v3
=========
1. Addressed review comments from Darrick.
2. Rebased to latest master.

v1 => v2
=========
Sending v2 with tests/ext4/ converted to tests/generic/
(although I had not received any review comments on v1).
It seems all of the tests which I had sent in v1 are not ext4 specific anyways.
So in v2, I have made those into tests/generic/.

Summary
=========
These are some of the tests which when tested with ext4 fast_commit feature
w/o kernel fixes, could cause tests failures and/or KASAN bug (generic/486).

I gave these tests a run with default xfs, btrfs and f2fs configs (along with
ext4). No surprises observed.

[v2]: https://lore.kernel.org/all/cover.1647342932.git.riteshh@linux.ibm.com/
[v1]: https://lore.kernel.org/all/cover.1644070604.git.riteshh@linux.ibm.com/


Ritesh Harjani (4):
  generic/468: Add another falloc test entry
  common/punch: Add block_size argument to _filter_fiemap_**
  generic/678: Add a new shutdown recovery test
  generic/679: Add a test to check unwritten extents tracking

 common/punch          |  9 +++---
 tests/generic/468     |  8 +++++
 tests/generic/468.out |  2 ++
 tests/generic/678     | 72 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/678.out |  7 +++++
 tests/generic/679     | 65 ++++++++++++++++++++++++++++++++++++++
 tests/generic/679.out |  6 ++++
 7 files changed, 165 insertions(+), 4 deletions(-)
 create mode 100755 tests/generic/678
 create mode 100644 tests/generic/678.out
 create mode 100755 tests/generic/679
 create mode 100644 tests/generic/679.out

--
2.31.1

