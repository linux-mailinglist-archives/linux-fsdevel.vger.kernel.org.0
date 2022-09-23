Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FEED5E7A2A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Sep 2022 14:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbiIWMIR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Sep 2022 08:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbiIWMGN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Sep 2022 08:06:13 -0400
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C383131987;
        Fri, 23 Sep 2022 05:00:49 -0700 (PDT)
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id C96892173;
        Fri, 23 Sep 2022 11:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1663934318;
        bh=nWecK01lWlm/+fHoFjSIP0puhvwdtsZ9P4N00vH53BU=;
        h=Date:To:CC:From:Subject;
        b=Wi67S3Us29uKLjNU2fF9bStc8sW3/Qg9pbpsfTE3wnDd1MOr6mHX2w5kulR4kZ1pM
         VgHUxBfRDpcYiMZvk8RC0asedkSgb+7uXH7UFQGAUaYhBoZD6JpfDfuOmAMhL5UHOr
         XCIFDA11wHKqHIwEKRhzqwRo97SGVEI2Eu0VLuBw=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id B70BFDD;
        Fri, 23 Sep 2022 12:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1663934447;
        bh=nWecK01lWlm/+fHoFjSIP0puhvwdtsZ9P4N00vH53BU=;
        h=Date:To:CC:From:Subject;
        b=pgOx/Q2CFvwOhsvvpXltsxnXSu6qMKR/+TojPK6s3GyrnoOg2mK8AFrFIMdV0hXco
         ga/gVYsm3Ie/thLjTNmVPqR9y1UGRe4migiObIqCjMF66KUOR9IeL+F3cGrfJeg0s4
         Asn1jNuvgr/3tPydXs75cJnhUiRP0RBub+hFH5BI=
Received: from [172.30.8.65] (172.30.8.65) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 23 Sep 2022 15:00:47 +0300
Message-ID: <91c21f32-cc6f-2c2e-ebf7-d1d738090aef@paragon-software.com>
Date:   Fri, 23 Sep 2022 15:00:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     <ntfs3@lists.linux.dev>
CC:     LKML <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH 0/2] fs/ntfs3: Add option "nocase" and refactoring
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.30.8.65]
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[PATCH 0/2] fs/ntfs3: Add option "nocase" and refactoring

Added another option that may be useful to users.
I've noticed in fslog.c some linebreaks, that can be fixed with
renaming, so I've done it in second commit.

Konstantin Komarov (2):
   fs/ntfs3: Add option "nocase"
   fs/ntfs3: Rename variables and add comment

  fs/ntfs3/frecord.c |   1 +
  fs/ntfs3/fslog.c   |  24 ++++----
  fs/ntfs3/index.c   |   2 +-
  fs/ntfs3/namei.c   | 139 +++++++++++++++++++++++++++++++++++++++++++++
  fs/ntfs3/ntfs_fs.h |   4 ++
  fs/ntfs3/super.c   |   6 ++
  fs/ntfs3/upcase.c  |  12 ++++
  7 files changed, 174 insertions(+), 14 deletions(-)

-- 
2.37.0


