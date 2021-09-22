Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1BC7414DE2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Sep 2021 18:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236584AbhIVQQw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Sep 2021 12:16:52 -0400
Received: from relaydlg-01.paragon-software.com ([81.5.88.159]:39904 "EHLO
        relaydlg-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232357AbhIVQQw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Sep 2021 12:16:52 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relaydlg-01.paragon-software.com (Postfix) with ESMTPS id 7BEED82304;
        Wed, 22 Sep 2021 19:15:20 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1632327320;
        bh=M5bfFgoFlXE4KcXmZ923eoBepB1UY06djY36XfpJqD8=;
        h=Date:To:CC:From:Subject;
        b=AnMm+MOUivqDSWHpbRKht4sFkHLQT7L8HPV68cpsn0MjCXqblrfjIydc08/7e4tjY
         V3PJq2xYOaIQ4BVgwbjAmg3X5w3NtDxeTz4TqZDioDVSligWOQzcT97hOwobWYQf1o
         wMvCFINhroRqEj6nM6VzpbkjCdg/EJNE0e15oyCg=
Received: from [192.168.211.195] (192.168.211.195) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 22 Sep 2021 19:15:20 +0300
Message-ID: <2771ff62-e612-a8ed-4b93-5534c26aef9e@paragon-software.com>
Date:   Wed, 22 Sep 2021 19:15:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Content-Language: en-US
To:     <ntfs3@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH 0/5] Refactor locking in inode_operations
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.211.195]
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Speed up work with dir lock.
Theoretically in successful cases those locks aren't needed at all.
But proving the same for error cases is difficult.
So instead of removing them we just move them.

Konstantin Komarov (5):
  fs/ntfs3: Move ni_lock_dir and ni_unlock into ntfs_create_inode
  fs/ntfs3: Refactor ntfs_get_acl_ex for better readability
  fs/ntfs3: Pass flags to ntfs_set_ea in ntfs_set_acl_ex
  fs/ntfs3: Change posix_acl_equiv_mode to posix_acl_update_mode
  fs/ntfs3: Refactoring lock in ntfs_init_acl

 fs/ntfs3/inode.c | 17 ++++++++--
 fs/ntfs3/namei.c | 20 -----------
 fs/ntfs3/xattr.c | 88 +++++++++++++++++-------------------------------
 3 files changed, 45 insertions(+), 80 deletions(-)

-- 
2.33.0
