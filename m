Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFEE7607CB6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Oct 2022 18:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbiJUQvR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Oct 2022 12:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbiJUQvB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Oct 2022 12:51:01 -0400
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F7F285B5D;
        Fri, 21 Oct 2022 09:50:52 -0700 (PDT)
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 295122200;
        Fri, 21 Oct 2022 16:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1666370897;
        bh=WeVn35Qu93dW5uoNZOx7Po56GHqBOQvSph/fAxdOSGc=;
        h=Date:To:CC:From:Subject;
        b=F11S1+Mz0IWKy13Nd+V1DMdcYBHUfWd0xQmbvSLcyQjBfuLrGwKgDV7Rx09CK9noS
         ZuZbA4nMfxE5zjLpXqWhM9CqySjMGG9H66Rlu5HX7OzS3dY1HyivuLHPeCeIz3ChLK
         N7ljr6veaL6eBaId8AlkjmwawXhyQVxtS/Y77x/o=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 380352138;
        Fri, 21 Oct 2022 16:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1666371050;
        bh=WeVn35Qu93dW5uoNZOx7Po56GHqBOQvSph/fAxdOSGc=;
        h=Date:To:CC:From:Subject;
        b=fmKhGWbGQr0hrVd9sPzUmHoEhVlDLVWNajkBBtUD7POB233EVCMy2pTbxrFp6M2i1
         yXls9NBuXkFPV7OJW9MkFu2kS5mQNv4AxAHHcY0xv5XXqg2+GcRr/S9p0vuI8+TmAE
         B0ynbPm1cQq9hOEiWzZb25LmfiuzvfTetJcjuWNQ=
Received: from [172.30.8.65] (172.30.8.65) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 21 Oct 2022 19:50:49 +0300
Message-ID: <9a7d08c2-e503-ac1d-1621-20369c073530@paragon-software.com>
Date:   Fri, 21 Oct 2022 19:50:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     <ntfs3@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH 0/4] fs/ntfs3: Bugfix and refactoring
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.30.8.65]
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[PATCH 0/4] fs/ntfs3: Bugfix and refactoring

First part of fixes and refactoring for ntfs3.
These patches must be applied after series
"fs/ntfs3: Fixes for big endian systems", that was missed by me.

Konstantin Komarov (4):
   fs/ntfs3: Add ntfs_bitmap_weight_le function and refactoring
   fs/ntfs3: Fix sparse problems
   fs/ntfs3: Remove unused functions
   fs/ntfs3: Simplify ntfs_update_mftmirr function

  fs/ntfs3/attrib.c  |  34 ++-------------
  fs/ntfs3/bitfunc.c |   4 +-
  fs/ntfs3/bitmap.c  | 100 +++++++++++++++++++++++++--------------------
  fs/ntfs3/dir.c     |   4 +-
  fs/ntfs3/frecord.c |   3 +-
  fs/ntfs3/fsntfs.c  |  33 +--------------
  fs/ntfs3/namei.c   |  13 +++---
  fs/ntfs3/ntfs_fs.h |  13 +++---
  8 files changed, 77 insertions(+), 127 deletions(-)

-- 
2.37.0

