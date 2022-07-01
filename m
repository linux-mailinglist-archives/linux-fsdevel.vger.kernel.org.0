Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BBE6563417
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Jul 2022 15:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234049AbiGANJU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Jul 2022 09:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiGANJT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Jul 2022 09:09:19 -0400
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F342EBDC;
        Fri,  1 Jul 2022 06:09:17 -0700 (PDT)
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id A962221B4;
        Fri,  1 Jul 2022 13:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1656680898;
        bh=MKsRJ8t+8zaBZCE5e9v9aMhJnYe1KsFG588Y04zQGIM=;
        h=Date:To:CC:From:Subject;
        b=os8jk9fNLTrNYSRxtCswNaTjIT84rUcaEMD/AXbeX7O0iO7N7ouHmFlSdk8H6pBkc
         RdYcLPCkw92jLB8QGnzxB6Vm0UjSw/Dfs4GxHBo/HlF0jcK5LrwclyWNrkt+zHFZNb
         XO8PT2IdMQeAHrNMKipfK6N5q3Mu3s3fKlEqGR2s=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id F0AC821B8;
        Fri,  1 Jul 2022 13:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1656680956;
        bh=MKsRJ8t+8zaBZCE5e9v9aMhJnYe1KsFG588Y04zQGIM=;
        h=Date:To:CC:From:Subject;
        b=hBQ0fEMeeSKv7qyDMImHu6Ks/MjyDgTJmNS1grqvMC03MMM8slBafpo6vVtN5HVz+
         rdUR8mqMh3KB4Fo5RKdUkYLSWo8kleYDxTqV2WVI5zN33JR1HWLdPdVNKRpCwuEwl+
         feFv2vUNeidlWsoLZdnOJ1vj9TENlCIKZALYyCeQ=
Received: from [172.30.8.65] (172.30.8.65) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 1 Jul 2022 16:09:15 +0300
Message-ID: <34e58f6e-e508-4ad8-6941-37281ea7d3ef@paragon-software.com>
Date:   Fri, 1 Jul 2022 16:09:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-US
To:     <ntfs3@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH 0/5] fs/ntfs3: Some fixes and refactoring
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.30.8.65]
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

5 patches with various fixes and refactoring:
- fix for fragmented case
- remove old code
- fix double locking
- hide internal function
- refactor function

Konstantin Komarov (5):
   fs/ntfs3: Fix very fragmented case in attr_punch_hole
   fs/ntfs3: Remove unused mi_mark_free
   fs/ntfs3: Add new argument is_mft to ntfs_mark_rec_free
   fs/ntfs3: Make static function attr_load_runs
   fs/ntfs3: Fill duplicate info in ni_add_name

  fs/ntfs3/attrib.c  | 17 ++++++++++++++---
  fs/ntfs3/frecord.c | 32 ++++++++++++++++++++------------
  fs/ntfs3/fsntfs.c  |  9 ++++++---
  fs/ntfs3/inode.c   | 12 +-----------
  fs/ntfs3/namei.c   |  2 +-
  fs/ntfs3/ntfs_fs.h |  5 +----
  fs/ntfs3/record.c  | 22 ----------------------
  fs/ntfs3/super.c   |  2 +-
  8 files changed, 44 insertions(+), 57 deletions(-)

-- 
2.37.0

