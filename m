Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8686A697DA3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Feb 2023 14:41:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjBONlN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Feb 2023 08:41:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjBONlM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Feb 2023 08:41:12 -0500
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42BCA392B7;
        Wed, 15 Feb 2023 05:41:09 -0800 (PST)
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 94D882117;
        Wed, 15 Feb 2023 13:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1676467759;
        bh=NZPb6ApnwJMAApHEhGf4/rLuvvBZKCTDmGmIFpkr4eA=;
        h=Date:To:CC:From:Subject;
        b=PyicJA0dJaD5NuEcGJuwebC87EDvYd6HprVt2WJAzyyRsTSGYOksBW23qjtRB/1VV
         4A1uofaQztCf7lZSE8yIswKreWY+LxTSHZiewFDcV9pyEPv7+/NTAdmGGSUe/AeFIK
         eZOBO7keoAw36Nr2Fe+99bGl2f8gXszy/MNMsKIU=
Received: from [192.168.211.36] (192.168.211.36) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 15 Feb 2023 16:33:29 +0300
Message-ID: <d7c91201-5e09-5c06-3283-7887f5a5b7f1@paragon-software.com>
Date:   Wed, 15 Feb 2023 17:33:28 +0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Content-Language: en-US
To:     <ntfs3@lists.linux.dev>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH 00/11] fs/ntfs3: Bugfix and refactoring
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.211.36]
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This series contains various fixes and refactoring for ntfs3.
Added error output on failed mount. Reworked some other error messages.

Konstantin Komarov (11):
   fs/ntfs3: Use bh_read to simplify code
   fs/ntfs3: Remove noacsrules
   fs/ntfs3: Fix ntfs_create_inode()
   fs/ntfs3: Optimization in ntfs_set_state()
   fs/ntfs3: Undo endian changes
   fs/ntfs3: Undo critial modificatins to keep directory consistency
   fs/ntfs3: Remove field sbi->used.bitmap.set_tail
   fs/ntfs3: Changed ntfs_get_acl() to use dentry
   fs/ntfs3: Code formatting and refactoring
   fs/ntfs3: Add missed "nocase" in ntfs_show_options
   fs/ntfs3: Print details about mount fails

  Documentation/filesystems/ntfs3.rst |  11 --
  fs/ntfs3/attrib.c                   |  17 +-
  fs/ntfs3/bitmap.c                   |  22 +--
  fs/ntfs3/file.c                     |  50 ++---
  fs/ntfs3/frecord.c                  |  39 ++--
  fs/ntfs3/fslog.c                    |  77 ++++----
  fs/ntfs3/fsntfs.c                   |  73 +++----
  fs/ntfs3/index.c                    |  58 +++---
  fs/ntfs3/inode.c                    | 118 +++++------
  fs/ntfs3/lznt.c                     |  10 +-
  fs/ntfs3/namei.c                    |   9 +-
  fs/ntfs3/ntfs_fs.h                  |  16 +-
  fs/ntfs3/record.c                   |   9 +-
  fs/ntfs3/run.c                      |   6 +-
  fs/ntfs3/super.c                    | 291 ++++++++++++++++------------
  fs/ntfs3/xattr.c                    |  64 +++---
  16 files changed, 435 insertions(+), 435 deletions(-)
