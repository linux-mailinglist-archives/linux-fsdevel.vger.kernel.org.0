Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05E097AE9DC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Sep 2023 12:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234339AbjIZKDm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Sep 2023 06:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234327AbjIZKDk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Sep 2023 06:03:40 -0400
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB862B3;
        Tue, 26 Sep 2023 03:03:33 -0700 (PDT)
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id CA2BF21AE;
        Tue, 26 Sep 2023 09:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1695721710;
        bh=cgW4FIdgGbuvm9U/H1+L1e/9qzZXAm0KOwXO3mAfiYI=;
        h=Date:From:Subject:To:CC;
        b=grMTRHSAu06JyKVSu++6XnV9b84G4TL1gEoLd1A18NmlVCJdFKHM2QBBRe/PeqJvS
         QlEBKStigYa86i+KqKqfgzC9o3Tforv8/8kGZammSiA2PTkRp5lNxc+tRGpsoVelWH
         XQ+GIhZ8JWq16G51VUxonJjU0qvnAAY2r4/+VcwM=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 270B41D45;
        Tue, 26 Sep 2023 09:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1695722061;
        bh=cgW4FIdgGbuvm9U/H1+L1e/9qzZXAm0KOwXO3mAfiYI=;
        h=Date:From:Subject:To:CC;
        b=TT/k+3Sv65rRZt/02mRwCkxiLKLKkOUuQ4xaD0ZGKMil5QDsNnUGfOga/0QrSeuYl
         G6IXfulL4m1mntNI/aplDVNtLqYfjsxyfTwH2ZUbYlNgtpBSsSw6RFzlIeRmzGYB18
         DEBDhECVgZfY2ZUZSle6LGC25c+korSHhJCj5wvQ=
Received: from [172.16.192.129] (192.168.211.137) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 26 Sep 2023 12:54:20 +0300
Message-ID: <7c217d7d-6ee4-4603-b5f1-ebe7b68cf430@paragon-software.com>
Date:   Tue, 26 Sep 2023 12:54:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Konstantin Komarovc <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH 0/8] fs/ntfs3: Bugfix and refactoring
Content-Language: en-US
To:     <ntfs3@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.211.137]
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This series contains various fixes and refactoring for ntfs3.
Added more info into /proc/fs/ntfs3/<dev>/volinfo

Konstantin Komarov (8):
   fs/ntfs3: Use inode_set_ctime_to_ts instead of inode_set_ctime
   fs/ntfs3: Allow repeated call to ntfs3_put_sbi
   fs/ntfs3: Fix alternative boot searching
   fs/ntfs3: Refactoring and comments
   fs/ntfs3: Add more info into /proc/fs/ntfs3/<dev>/volinfo
   fs/ntfs3: Do not allow to change label if volume is read-only
   fs/ntfs3: Fix possible NULL-ptr-deref in ni_readpage_cmpr()
   fs/ntfs3: Fix NULL pointer dereference on error in
     attr_allocate_frame()

  fs/ntfs3/attrib.c  | 12 ++++----
  fs/ntfs3/bitmap.c  |  1 +
  fs/ntfs3/file.c    |  4 +--
  fs/ntfs3/frecord.c |  2 +-
  fs/ntfs3/inode.c   |  5 ++--
  fs/ntfs3/namei.c   |  6 ++--
  fs/ntfs3/ntfs.h    |  2 +-
  fs/ntfs3/ntfs_fs.h |  2 --
  fs/ntfs3/record.c  |  6 ++++
  fs/ntfs3/super.c   | 71 +++++++++++++++++++++++++++++++---------------
  10 files changed, 70 insertions(+), 41 deletions(-)

-- 
2.34.1


