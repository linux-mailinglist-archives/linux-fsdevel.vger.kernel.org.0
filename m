Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7D952403F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 May 2022 00:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348740AbiEKW3X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 May 2022 18:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344678AbiEKW3V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 May 2022 18:29:21 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7858F1E6559
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 May 2022 15:29:20 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id gj17-20020a17090b109100b001d8b390f77bso6176110pjb.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 May 2022 15:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l6f+5/Vo3mAG8snELd3XOc4siztvcKt8YBtUwfsLbWg=;
        b=AA45CPUU8Us9kxvujSWmr6tEHvJb6GK11i1UJq35Iseq5lx9WY4GrIa0ohM8K8cCl/
         6MF6YKAVFjaIyjreqdXMN7X/rxAwMTBSLWMyMPxNxKRXduUKjNlDZsTRdP02Q2SqDYP9
         PZawNqkHJFcystLRDFqhcySqH54xbhpPJta/Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l6f+5/Vo3mAG8snELd3XOc4siztvcKt8YBtUwfsLbWg=;
        b=ZFmBYomQAZxobffUgjjNUWke2JGqBuy0YhzHeUTlO4GcJ48r7GSi3QpMeP34J3mgby
         wEIFX4kv91aYVq/GoK7qdzr/h2WmmXXqXU5diOsvwMa4UKwdhUgGivlrn9DuqLaodc0a
         ZOAZs4JTFJ/G7Zi58onInnBaMr+fLWJNThGs2BOP9Kug+9rxVOpbLosfNTkWoFG/yYpt
         SOHNCZuQ4Ury+kmac2ipKdcxiQ39ty0PxgM7JgWGYFAQTJP5L9QK157Wpbm14Mdt2oBB
         HZ3KJ7AaVI/0MiH2Nye1guX1FAKT2dOPpUAaKi8p+fDlCJvMeCk9tCRsvaDfsSHZHJWI
         zYag==
X-Gm-Message-State: AOAM531miWPgGRh74uwhnsiRe8f9Ixnt2gEiSdeUk+Z2YLS0nxgaJHD5
        WFecPshEJ6KrVpvjx5tKXHMz+lnCeRDAjg==
X-Google-Smtp-Source: ABdhPJyqGOkE0Z2w19eFOj6PDks6DXQolwftIdTdi5nVA63NtM0rxhADPB3QqHBGnJBhCDlZZ4zt7A==
X-Received: by 2002:a17:90a:ec16:b0:1da:3249:685b with SMTP id l22-20020a17090aec1600b001da3249685bmr7549912pjy.101.1652308159944;
        Wed, 11 May 2022 15:29:19 -0700 (PDT)
Received: from dlunevwfh.roam.corp.google.com (n122-107-196-14.sbr2.nsw.optusnet.com.au. [122.107.196.14])
        by smtp.gmail.com with ESMTPSA id d5-20020a170902c18500b0015e8d4eb1d2sm2391855pld.28.2022.05.11.15.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 15:29:19 -0700 (PDT)
From:   Daniil Lunev <dlunev@chromium.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     hch@infradead.org, fuse-devel@lists.sourceforge.net, tytso@mit.edu,
        miklos@szeredi.hu, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, Daniil Lunev <dlunev@chromium.org>
Subject: [PATCH v2 0/2] Prevent re-use of FUSE superblock after force unmount
Date:   Thu, 12 May 2022 08:29:08 +1000
Message-Id: <20220511222910.635307-1-dlunev@chromium.org>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

userspace counterpart. However, open file handles will prevent the
superblock from being reclaimed. An attempt to remount the filesystem at
the same endpoint will try re-using the superblock, if still present.
Since the superblock re-use path doesn't go through the fs-specific
superblock setup code, its state in FUSE case is already disfunctional,
and that will prevent the mount from succeeding.

Changes in v2:
- Remove super from list of superblocks instead of using a flag

Daniil Lunev (2):
  fs/super: function to prevent super re-use
  FUSE: Retire superblock on force unmount

 fs/fuse/inode.c    |  7 +++++--
 fs/super.c         | 51 ++++++++++++++++++++++++++++++++++++----------
 include/linux/fs.h |  1 +
 3 files changed, 46 insertions(+), 13 deletions(-)

-- 
2.31.0

