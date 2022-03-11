Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC2F24D60FA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Mar 2022 12:48:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235279AbiCKLtD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Mar 2022 06:49:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbiCKLtC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Mar 2022 06:49:02 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC1A75883C;
        Fri, 11 Mar 2022 03:47:57 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D821C21122;
        Fri, 11 Mar 2022 11:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1646999275; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=PXw5xkYVIyyybMC0OVEI/4rr/BItd3ICga11fgiA2A8=;
        b=v/8WY0f3Vn+AOZHqQ2nqD32vNMLI1XuzfRz/X3S0IWeRlXMf8RxS6rQVtyt3g3Vvu5jbFY
        OqGvucFfVIKEzgkxcg5xLD9sEBbap5u5FKj6CG4hh/Ttgqr9A/qa7p29w0y796veoNlwdU
        d5DKu453/j1rrPtJh6ZFpU9q7tEnr2c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1646999275;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=PXw5xkYVIyyybMC0OVEI/4rr/BItd3ICga11fgiA2A8=;
        b=ob5OmvP9RccCgCqEAWe7bsGIEjNAyH1/D6sKvs1DtwXSK7lXanE2rQ/amkrZ5lSUZT+KA0
        a0YSVXGP8NZsaDBQ==
Received: from vasant-suse.fritz.box (unknown [10.163.24.178])
        by relay2.suse.de (Postfix) with ESMTP id 4881BA3B81;
        Fri, 11 Mar 2022 11:47:55 +0000 (UTC)
From:   Vasant Karasulli <vkarasulli@suse.de>
To:     Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ddiss@suse.de
Cc:     Vasant Karasulli <vkarasulli@suse.de>
Subject: [PATCH v3 0/2] exfat: allow access to paths with trailing dots
Date:   Fri, 11 Mar 2022 12:47:44 +0100
Message-Id: <20220311114746.7643-1-vkarasulli@suse.de>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is the version 3 of the patch that introduces
a new exfat mount option 'keep_last_dots'. In this
version I have reworked the commit messages according
to the feedback received on version 2 of the patch.

Vasant Karasulli (2):
  The "keep_last_dots" mount option will, in a subsequent commit,
    control whether or not trailing periods '.' are stripped from path
    components during file lookup or file creation.
  exfat currently unconditionally strips trailing periods '.' when
    performing path lookup, but allows them in the filenames during file
    creation. This is done intentionally, loosely following Windows
    behaviour and specifications which state:

 fs/exfat/exfat_fs.h |  3 ++-
 fs/exfat/namei.c    | 50 ++++++++++++++++++++++++++++++++-------------
 fs/exfat/super.c    |  7 +++++++
 3 files changed, 45 insertions(+), 15 deletions(-)


base-commit: ffb217a13a2eaf6d5bd974fc83036a53ca69f1e2
prerequisite-patch-id: aa89fed0f25e0593bd930cb1925a61318970af3b
prerequisite-patch-id: b82d57cf11a808fd91ebce196ad90742f266ae39
prerequisite-patch-id: 8fb922007d8da42e7d8915ad4192c3a881384720
prerequisite-patch-id: 80a740f0cc838892abca091667fa5b407611ea39
prerequisite-patch-id: 70a6044affdfcfba97c7651fb2150fa42cf01805
prerequisite-patch-id: a017bdbdcc66df4dd3a66ba03a37714b8e68d253
prerequisite-patch-id: 52771ab4aa8cbdafed3594d7d9a0c75b8a53f6e4
prerequisite-patch-id: fe388ead9e78b2e67bfb1ddfd5cd60a496c12d1c
prerequisite-patch-id: fb7ef4d34a652d20b3c6edefaf72ca6298d1e8f4
prerequisite-patch-id: 4194bee4bb9ee6eaeb6ee1ddd82cb84cdcab8d38
prerequisite-patch-id: e178f0c524a65e855ffb7861f1b9a9b2d56a2428
prerequisite-patch-id: e35925ec691c2fa8c167c19844cb40ef090845aa
prerequisite-patch-id: 6f54f7183bb0c519f9f76d8645da5a881ca71458
prerequisite-patch-id: b2d2dc9c206fbfc0c80f1be3d9ab031ba2dfd279
prerequisite-patch-id: 47a6c9093808e07f6ff561d011566a4ee4e7465a
prerequisite-patch-id: 70b5f29b3208d4e0b8bd27900618aeaba901d19a
prerequisite-patch-id: 56b6ad48cc9999893d34e7378ad1bbad293ca52b
prerequisite-patch-id: 3318f5c0bb1dac4c932e892329c52c1a118633b4
prerequisite-patch-id: e6aa617911d8647d1b7764c6916e3a01ffed1371
prerequisite-patch-id: 60f8292acf6a200ce4b8f0080a4e7e6429f0f78f
prerequisite-patch-id: e2f2b35b6e7c1aaa6a9b22e563c0f753df5fbe88
prerequisite-patch-id: 70880c12ac3be19b196165cf4a06baf3b6074072
prerequisite-patch-id: 55d302be95eccc06e20360e5b392f72e7249ea76
prerequisite-patch-id: 0fc645d44f0354b6217c3a713d1ac144de7c786f
prerequisite-patch-id: ebf526d3226975950e8997ed5f83f9b11d631aa5
prerequisite-patch-id: ddb73fe6ea6d1e72b379f480b47ec60162352eb7
prerequisite-patch-id: 091d1b77db64fcd1832dbe1db820fd4685f5651b
prerequisite-patch-id: 30006d3af6ae601664ddee4c468520dc800b27bf
prerequisite-patch-id: fcfb1b6ee7b1c7ab5cdd02d71113551c710a21ca
prerequisite-patch-id: 8f225e2d574ffabb6ed842e92543fd0aab52fa19
prerequisite-patch-id: cf3c7778997c4ca97ab08b195cfe861c565f504c
prerequisite-patch-id: 0757c9df4b98726a778f260c4c8ac12f764a2a66
prerequisite-patch-id: 60d1cbbfad4650cce75ffea3253629e8bd9a512c
prerequisite-patch-id: 6657313f73334d9d56215ce286cb0d96674a9c9d
prerequisite-patch-id: 352c99d07523c55e000b9df37a938da22bfedb9f
prerequisite-patch-id: 27176966d0b2d1b98804f3de159a39fcbff0dc9a
prerequisite-patch-id: 6d0311021d93c54e5a306af2d40f43b482a7ee66
prerequisite-patch-id: b5d02eeea8fd63acf76bf7ad5235c20e68858d16
prerequisite-patch-id: f169a13a30c2b09839055a91dd8853c476e8c3f7
prerequisite-patch-id: 14df2ff4090dc2b7518be5a48feec7711628e0d4
prerequisite-patch-id: f4d3503460646e4accd4c54f44f9593816fc62a0
prerequisite-patch-id: 9205bc688a48d7ab778b6bd8454890e1fb7cc039
prerequisite-patch-id: 48513af66ec62d400de1d559f7e75327610b5686
prerequisite-patch-id: 2169938ae51c00399f010f88027bf70b05a1d90f
prerequisite-patch-id: 2b9450e957e69b30414bbf0e1cc3caebd334f654
prerequisite-patch-id: 0c7d6e599af288ca298bbc59a08246715982a7ab
prerequisite-patch-id: a2c1416d88c502ef5b7d621325e2f6712e56a3f4
prerequisite-patch-id: bb6d17d263aa6dab21e87887c98b535595e25c1f
prerequisite-patch-id: f7fa011b9e279104d8c8e2bf09fb5d3ab3f34b67
prerequisite-patch-id: 8358ac66a9d65695fb2bc02637cfddf4695ddeaa
prerequisite-patch-id: 665d9352bf8e6ffc4b7c0ff25659468b5262d4e7
prerequisite-patch-id: 307e544949317538681dc124fdf2b33df538d897
prerequisite-patch-id: 31616804feb9f7b6d5e010d5306b0304005d5efe
prerequisite-patch-id: f8065fb1765262737c2222ad80d2f3d60454e955
prerequisite-patch-id: d99c3d909e24f1ca3269c1e08034f7936f3a5622
prerequisite-patch-id: 0e1efe816412e68314ec226f80b2ded7d2fb33a0
prerequisite-patch-id: 1cf9b69fe0847e9961756cbd69858aecbdab9d1e
--
2.32.0

