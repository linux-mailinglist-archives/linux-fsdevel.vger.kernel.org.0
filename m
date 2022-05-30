Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4538F538630
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 May 2022 18:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239126AbiE3QhD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 May 2022 12:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237660AbiE3QhB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 May 2022 12:37:01 -0400
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C6A52E7E;
        Mon, 30 May 2022 09:36:55 -0700 (PDT)
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 211992571;
        Mon, 30 May 2022 16:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1653928583;
        bh=C8bL2a+SxD1sCl+bANc/dqmF/YcTnxAaEyjCFwOiBAU=;
        h=Date:To:CC:From:Subject;
        b=J5Mo7Qp2gnu0v7446MKyJ9vbrEWjKFYhbqkJT4GLgCVTewuwuhB3qvmYA/ZF1Ff17
         lM8Z3pNA8HMLRM7liB0svjBJKyvl3Wvz5sqFOT5HxuaZLXpa/eys9wM0YN9vhx3P5u
         nN584wlUN14LL4LYTzTJJgFW+rhbjCWzI1jaExOw=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 6CA1221B3;
        Mon, 30 May 2022 16:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1653928613;
        bh=C8bL2a+SxD1sCl+bANc/dqmF/YcTnxAaEyjCFwOiBAU=;
        h=Date:To:CC:From:Subject;
        b=bVlKdwm8r/BeLynx9q9CYH+eej28H8IDMhaKygrsPgNqYt+6LK100INTfXZe172Sz
         P82eIAtp7yoVXsKll4wXhlXBhQwuUwJh3C6k/z9bg3OF/po8XGbygL1z1/VBdnvGOP
         MRte//M5kMoOEMK3ES4bRqS47/0S9M6thZR6dCCI=
Received: from [172.30.8.65] (172.30.8.65) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 30 May 2022 19:36:53 +0300
Message-ID: <6afbf4c7-825b-7148-b130-55f720857cb0@paragon-software.com>
Date:   Mon, 30 May 2022 19:36:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To:     <ntfs3@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH v2 0/3] Refactoring and bugfix
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

There are 3 commits.
First - to improve code readability.
Second - bugfix for xfstest (fixing wrong logic).
Third - restructuring function logic so
we can restore inode in some error cases.

v2:
   fixed patch 1/3 - fixed typo and improved code readability

Konstantin Komarov (3):
   fs/ntfs3: Refactoring of indx_find function
   fs/ntfs3: Fix double free on remount
   fs/ntfs3: Refactor ni_try_remove_attr_list function

  fs/ntfs3/frecord.c | 49 ++++++++++++++++++++++++++++++++++------------
  fs/ntfs3/index.c   | 25 +++++++++--------------
  fs/ntfs3/record.c  |  5 ++---
  fs/ntfs3/super.c   |  8 ++++----
  4 files changed, 52 insertions(+), 35 deletions(-)

-- 
2.36.1
