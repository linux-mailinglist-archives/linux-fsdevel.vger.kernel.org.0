Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94CA7573B70
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Jul 2022 18:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236686AbiGMQoV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Jul 2022 12:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiGMQoU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Jul 2022 12:44:20 -0400
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A09B325C5A;
        Wed, 13 Jul 2022 09:44:19 -0700 (PDT)
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 2FDB21DDC;
        Wed, 13 Jul 2022 16:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1657730590;
        bh=JJZqCAdnrfuB7RD4OYdiO0bmt2rcKXrgBA7htjDoFXA=;
        h=Date:To:CC:From:Subject;
        b=RxhqXSkkEA5ActIanYBYP2kNjfaYRzXNbYc8B3MrUbVDlwbOFYPGv2p/WIQeRQWf+
         D9kPFMXYh2YeQFPX/kTysyIUU2p7PJsuGffePOifJWMmlRt7rTlnnBMPjrkvWJqNSV
         iMUmO0GyoATkZu8DP/lsexTEIXj9TSN4aKI/C23o=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id B4A54213E;
        Wed, 13 Jul 2022 16:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1657730657;
        bh=JJZqCAdnrfuB7RD4OYdiO0bmt2rcKXrgBA7htjDoFXA=;
        h=Date:To:CC:From:Subject;
        b=u+JJew6pi2B6nXWC07H/8q287XntPg46hvMlj9Ueh2YZYM1VRXERQ4wd3igI7BUm5
         6lN+5E7lPq83b7AaehUAaSQ17ySuZs3flZQKp5BI6t552bqmqSmFP0MYRnquBplFz2
         ZFSraJabwdPjfim21N4uHw2rBX8pBrUWQ8ffw5Zk=
Received: from [172.30.8.65] (172.30.8.65) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 13 Jul 2022 19:44:17 +0300
Message-ID: <2101d95b-be41-6e6d-e019-bc70f816b2e8@paragon-software.com>
Date:   Wed, 13 Jul 2022 19:44:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     <ntfs3@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH 0/6] fs/ntfs3: Refactoring of several functions
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.30.8.65]
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

6 commits, that hopefully improves code (tests are ok).
While working on attr_set_size, attr_punch_hole and attr_insert_range
I've noticed how convoluted the code is.
I'll think about how to make code less complex.

Konstantin Komarov (6):
   fs/ntfs3: New function ntfs_bad_inode
   fs/ntfs3: Refactoring attr_set_size to restore after errors
   fs/ntfs3: Refactoring attr_punch_hole to restore after errors
   fs/ntfs3: Refactoring attr_insert_range to restore after errors
   fs/ntfs3: Create MFT zone only if length is large enough
   fs/ntfs3: ni_ins_new_attr now returns error

  fs/ntfs3/attrib.c  | 416 +++++++++++++++++++++++++++++++--------------
  fs/ntfs3/frecord.c |  35 +++-
  fs/ntfs3/fsntfs.c  |  25 ++-
  fs/ntfs3/inode.c   |   6 +-
  fs/ntfs3/namei.c   |   4 +-
  fs/ntfs3/ntfs_fs.h |   3 +
  fs/ntfs3/run.c     |  25 +++
  7 files changed, 368 insertions(+), 146 deletions(-)

-- 
2.37.0

