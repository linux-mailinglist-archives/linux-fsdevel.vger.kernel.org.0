Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F36A55E9C0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 18:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235385AbiF1QaU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jun 2022 12:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347405AbiF1Q3I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jun 2022 12:29:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE8039BB3;
        Tue, 28 Jun 2022 09:19:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 00863B81EF1;
        Tue, 28 Jun 2022 16:19:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19A99C3411D;
        Tue, 28 Jun 2022 16:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656433193;
        bh=JnZxK29TZFtBUB3F8eFgOPUsnt7bfR/oP32+1ifjhYs=;
        h=From:To:Cc:Subject:Date:From;
        b=YVblZxM+kOybPKMpOrrARV5BC+6/TJ8tb2lQcQT9fY64fPs8+UF5bclIryRfcUk5K
         QsQRJz4EQ/rI9dsW9TsYtzDHr21viCp3Uwc69+WlidkZcdgIpHY6Hj4ettQlZ+4LPa
         fL6VNGBO2wb9yTa2nFqEdzLZnbPePecikNrIKzA69deV7PVNGY4BqMjpeT4r6BhGxk
         1bDezDZX90eYq5hwFfC7i6lCjV31Wbrlrj/c+Igu+mamaI6vP5rpLyQ0lvqYZBzMbQ
         4eMHAy/JMm6GkEzqruUdFiVcnY88F+enBtgwStmotlRLMZsHzRR1rwtk9M6ISrbZm9
         SFDP1nAYwGl0g==
From:   KP Singh <kpsingh@kernel.org>
To:     bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Yosry Ahmed <yosryahmed@google.com>
Subject: [PATCH v5 bpf-next 0/5] Add bpf_getxattr
Date:   Tue, 28 Jun 2022 16:19:43 +0000
Message-Id: <20220628161948.475097-1-kpsingh@kernel.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

v4 -> v5

- Fixes suggested by Andrii

v3 -> v4

- Fixed issue incorrect increment of arg counter
- Removed __weak and noinline from kfunc definiton
- Some other minor fixes.

v2 -> v3

- Fixed missing prototype error
- Fixes suggested by other Joanne and Kumar.

v1 -> v2

- Used kfuncs as suggested by Alexei
- Used Benjamin Tissoires' patch from the HID v4 series to add a
  sleepable kfunc set (I sent the patch as a part of this series as it
  seems to have been dropped from v5) and acked it. Hope this is okay.
- Added support for verifying string constants to kfuncs



Benjamin Tissoires (1):
  btf: Add a new kfunc set which allows to mark a function to be
    sleepable

KP Singh (4):
  bpf: kfunc support for ARG_PTR_TO_CONST_STR
  bpf: Allow kfuncs to be used in LSM programs
  bpf: Add a bpf_getxattr kfunc
  bpf/selftests: Add a selftest for bpf_getxattr

 include/linux/bpf_verifier.h                  |  2 +
 include/linux/btf.h                           |  2 +
 kernel/bpf/btf.c                              | 43 ++++++++-
 kernel/bpf/verifier.c                         | 89 +++++++++++--------
 kernel/trace/bpf_trace.c                      | 42 +++++++++
 .../testing/selftests/bpf/prog_tests/xattr.c  | 54 +++++++++++
 tools/testing/selftests/bpf/progs/xattr.c     | 37 ++++++++
 7 files changed, 229 insertions(+), 40 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/xattr.c
 create mode 100644 tools/testing/selftests/bpf/progs/xattr.c

-- 
2.37.0.rc0.161.g10f37bed90-goog

