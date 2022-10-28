Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB846118A4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Oct 2022 19:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbiJ1RCt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Oct 2022 13:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbiJ1RCT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Oct 2022 13:02:19 -0400
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A83E107CDD;
        Fri, 28 Oct 2022 10:00:43 -0700 (PDT)
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 8FA89218D;
        Fri, 28 Oct 2022 16:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1666976282;
        bh=dcXBJqP5J7y8af2ml7/6zVJ1mbSL2vR83MREQmr2Fo4=;
        h=Date:To:CC:From:Subject;
        b=Nkry+1za2eS5K3TDmAS6oj14shR/MZNT0XF8u9zF9m+DtGjARsYFN5hdgZmN6RNzL
         IkuAxuMtQoN0bUc1lFBNYjnjFMazCyIRFn+JJCsgQMvHoNms7HaqAi9eHIgch4nLZh
         cfXNtkzFrIuOlD6sYJH1guqwuZvzuQNemLXYcph0=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 83EC8DD;
        Fri, 28 Oct 2022 17:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1666976441;
        bh=dcXBJqP5J7y8af2ml7/6zVJ1mbSL2vR83MREQmr2Fo4=;
        h=Date:To:CC:From:Subject;
        b=a61ub4n7+duuS061L8SfOxG51d4ioIvVEfzk+81yhrb/CoCPxL5jTTrfRC+OU83DG
         ZnY8l7awLkOapAt8/HBFZBSSxQZQFc6VIvIamZ2dNDU66sVzOl0iCYKqv1WFle38Eb
         0iY4HTCnQZ8DGe0u6YBGzskl2dfR1R869CQOMzqU=
Received: from [172.30.8.65] (172.30.8.65) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 28 Oct 2022 20:00:41 +0300
Message-ID: <fc5957cc-a71b-cfa3-f291-cb63b23800d1@paragon-software.com>
Date:   Fri, 28 Oct 2022 20:00:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     <ntfs3@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH 00/14] fs/ntfs3: Additional bugfix and refactoring
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.30.8.65]
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

Second part of various fixes and refactoring for ntfs3.

Konstantin Komarov (14):
   fs/ntfs3: Fixing work with sparse clusters
   fs/ntfs3: Change new sparse cluster processing
   fs/ntfs3: Fix wrong indentations
   fs/ntfs3: atomic_open implementation
   fs/ntfs3: Fixing wrong logic in attr_set_size and ntfs_fallocate
   fs/ntfs3: Changing locking in ntfs_rename
   fs/ntfs3: Restore correct state after ENOSPC in attr_data_get_block
   fs/ntfs3: Correct ntfs_check_for_free_space
   fs/ntfs3: Check fields while reading
   fs/ntfs3: Fix incorrect if in ntfs_set_acl_ex
   fs/ntfs3: Use ALIGN kernel macro
   fs/ntfs3: Fix wrong if in hdr_first_de
   fs/ntfs3: Improve checking of bad clusters
   fs/ntfs3: Make if more readable

  fs/ntfs3/attrib.c  | 338 +++++++++++++++++++++++++++++----------------
  fs/ntfs3/bitmap.c  |  38 +++++
  fs/ntfs3/file.c    | 203 ++++++++-------------------
  fs/ntfs3/frecord.c |   2 +-
  fs/ntfs3/fslog.c   |   3 +-
  fs/ntfs3/fsntfs.c  |  35 ++++-
  fs/ntfs3/index.c   | 105 ++++++++++++--
  fs/ntfs3/inode.c   |  86 +++++++-----
  fs/ntfs3/namei.c   | 104 ++++++++++++++
  fs/ntfs3/ntfs.h    |   6 +-
  fs/ntfs3/ntfs_fs.h |  22 ++-
  fs/ntfs3/record.c  |   5 +-
  fs/ntfs3/run.c     |  28 +---
  fs/ntfs3/super.c   |  64 +++++----
  fs/ntfs3/xattr.c   | 116 ++++++++++------
  15 files changed, 737 insertions(+), 418 deletions(-)

-- 
2.37.0

