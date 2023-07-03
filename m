Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F40A674561B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jul 2023 09:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbjGCHcn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jul 2023 03:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjGCHcl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jul 2023 03:32:41 -0400
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8E293;
        Mon,  3 Jul 2023 00:32:40 -0700 (PDT)
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 647091D2D;
        Mon,  3 Jul 2023 07:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1688368719;
        bh=HHUtUvM6SCtPbZbJJ4cYknHmlAly3H+bxbxkIjZVMeU=;
        h=Date:To:CC:From:Subject;
        b=D1NMkafKJO0+0BKc+Yr+Sz4F/W6Ja8Bod3UgOsOZB11yQrVat8uX5uOv+/YIcT2gn
         DgN4aX4ra0yl9NiactnalpSQ6HjgQJwWhP4EZGB0CEgg1h+mN2zA5R3QjaywDccpGS
         Q3YG1dETZ82MCLK0QsKjBqVUrxaxNnjYbm4mBEig=
Received: from [192.168.211.138] (192.168.211.138) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 3 Jul 2023 10:23:50 +0300
Message-ID: <e41f6717-7c70-edf2-2d3a-8034840d14c5@paragon-software.com>
Date:   Mon, 3 Jul 2023 11:23:49 +0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     <ntfs3@lists.linux.dev>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH 0/8] fs/ntfs3: Bugfix and refactoring
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.211.138]
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This series contains various fixes and refactoring for ntfs3.
Added more checks in record.


Konstantin Komarov (8):
   fs/ntfs3: Add ckeck in ni_update_parent()
   fs/ntfs3: Write immediately updated ntfs state
   fs/ntfs3: Minor code refactoring and formatting
   fs/ntfs3: Don't allow to change label if volume is read-only
   fs/ntfs3: Use kvmalloc instead of kmalloc(... __GFP_NOWARN)
   fs/ntfs3: Add more attributes checks in mi_enum_attr()
   fs/ntfs3: fix deadlock in mark_as_free_ex
   fs/ntfs3: Fix shift-out-of-bounds in ntfs_fill_super

  fs/ntfs3/attrlist.c | 15 +++++++--
  fs/ntfs3/bitmap.c   |  3 +-
  fs/ntfs3/frecord.c  |  6 ++++
  fs/ntfs3/fsntfs.c   | 19 +++++-------
  fs/ntfs3/namei.c    |  2 +-
  fs/ntfs3/ntfs.h     |  2 +-
  fs/ntfs3/ntfs_fs.h  |  2 ++
  fs/ntfs3/record.c   | 74 +++++++++++++++++++++++++++++++++++----------
  fs/ntfs3/super.c    | 38 +++++++++++++++++------
  fs/ntfs3/xattr.c    |  3 +-
  10 files changed, 121 insertions(+), 43 deletions(-)

-- 
2.34.1

