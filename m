Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F34E97BDC2A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Oct 2023 14:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346567AbjJIMek (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Oct 2023 08:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346653AbjJIMeb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Oct 2023 08:34:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F8B94;
        Mon,  9 Oct 2023 05:33:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF703C433C8;
        Mon,  9 Oct 2023 12:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696854833;
        bh=+SRAskbzj+WuL5QfXRR/Rcg3XnDfBhy4j0r6EkkPZfc=;
        h=From:Subject:Date:To:Cc:From;
        b=fsCcN47Lm9Lc2q6WMgDyuDZCLlj4uOU3LcvT3bin1ZdHHIUM97DAmXCJt5yhWIYcs
         uzSBjMYnroJU3djz8fVy4cvCvHmZ/dz7qvQRywLIEpJ1u8YYC3FoQUX/mrm88smYNP
         IBVpiSARw8X28srB5deu3uja7LochyCPV0oXTCCQKeeCU+2yfwa3B1D7FioZyj0UgT
         qLLAPVWDEvcq6EHCAJ+AJTA5xabvPLgRqbQJjx53/LNGa1lgYJ++pJNkDqUg6qkFjj
         aa7IAToKkGe7QjoK6TvLUydK6gFYnN3yNQsQk+V6etPYe5Qhg13jBIevRQH12Zwho9
         f2gU8AlkDlUfA==
From:   Christian Brauner <brauner@kernel.org>
Subject: [PATCH 0/4] reiserfs: fixes
Date:   Mon, 09 Oct 2023 14:33:37 +0200
Message-Id: <20231009-vfs-fixes-reiserfs-v1-0-723a2f1132ce@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACHzI2UC/yWMQQqDQBAEvyJzzoR1FYL5Sshh1/TGuawyAxIQ/
 +5Ej0V31UYGFRg9m40Uq5jM1aG9NTROqX7B8nGmGGLXhjDwWoyL/GCsEJcduz7EgkfKeejJxUV
 xPtx7vZ1zMnDWVMfpn/LC/dr3/QCjVU+jgAAAAA==
To:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>
Cc:     reiserfs-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        syzbot+062317ea1d0a6d5e29e7@syzkaller.appspotmail.com
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=434; i=brauner@kernel.org;
 h=from:subject:message-id; bh=+SRAskbzj+WuL5QfXRR/Rcg3XnDfBhy4j0r6EkkPZfc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQqf9aX3zX5uqZ89PGPzufvL1jssfiVu2LKFKuA/2ejmBnX
 2yS2dJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzkXibDf+/CA9tuMc5MunLjss90xR
 THZezR8ueaxV77nOeofXaFZz0jQ/+5Xfe+84vdZ7qUy97o/MnFZzNjgoZlo5HPPtHaY9eVuQE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hey Christoph & Jan,

A series of smaller fixes for reiserfs including one deadlock reported
by syzbot (albeit with a bogus bisection). Plan would be to get this
merged within -rc6.

I've actually tested all this with xfstests. With and without this
patch series the same 18 tests fail.

Thanks!
Christian


---
base-commit: 94f6f0550c625fab1f373bb86a6669b45e9748b3
change-id: 20231009-vfs-fixes-reiserfs-3402fe7abb94

