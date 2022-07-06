Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3735690B1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Jul 2022 19:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232706AbiGFRba (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Jul 2022 13:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232118AbiGFRb3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Jul 2022 13:31:29 -0400
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 651ED2408C;
        Wed,  6 Jul 2022 10:31:28 -0700 (PDT)
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id B5F7E1D06;
        Wed,  6 Jul 2022 17:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1657128624;
        bh=TxFto+XyTzzpSGbGmxKAFRhYC4BH97NHqyyBDVSPC14=;
        h=Date:To:CC:From:Subject;
        b=TOFZ47Jv8S/zLdB944jKEvgNjZK9KpdRFOCxO0fRq1KgkVW3bsQAKBne5Dvz4SI7w
         PHCwZpHnfn+7LL5gK8jvB3Vkp3HU27uRo8ttsiQQ4YEOqdFNGhqB3MX4mb0vOlpn8r
         uMQdNcwaP2KCpTXO8Rml66BrUgHaxchfd5YAE4Co=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 6FC762133;
        Wed,  6 Jul 2022 17:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1657128686;
        bh=TxFto+XyTzzpSGbGmxKAFRhYC4BH97NHqyyBDVSPC14=;
        h=Date:To:CC:From:Subject;
        b=uV4GCvSLVBrIjnxduhw1q78x8XN27Sq7LdiktiX55UKoKVLD0vS+tlJnhckIbbo50
         FFuE7Y57cZ9drf9mrz5hqY7bttGnqJpel8JftbvaAqmaAB/KLEg/0XX2FvIjcGQlE0
         bGmwPfc5pq5bz714eF1eg9/ppjgMcoqNst+vBLKs=
Received: from [172.30.8.65] (172.30.8.65) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 6 Jul 2022 20:31:26 +0300
Message-ID: <d578fcbe-e1f7-ffc7-2535-52eecb271a01@paragon-software.com>
Date:   Wed, 6 Jul 2022 20:31:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     <ntfs3@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH 0/2] fs/ntfs3: Refactoring and improving logic in run_pack
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

2 patches:
- some comments and making function static;
- improving speed of run_pack by checking runs in advance

Konstantin Komarov (2):
   fs/ntfs3: Added comments to frecord functions
   fs/ntfs3: Check possible errors in run_pack in advance

  fs/ntfs3/bitmap.c  |  3 +--
  fs/ntfs3/frecord.c |  8 ++++----
  fs/ntfs3/ntfs_fs.h |  1 -
  fs/ntfs3/run.c     | 41 +++++++++++++++++++++++------------------
  4 files changed, 28 insertions(+), 25 deletions(-)

-- 
2.37.0

