Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E74D24096C6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Sep 2021 17:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346395AbhIMPLK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Sep 2021 11:11:10 -0400
Received: from relaydlg-01.paragon-software.com ([81.5.88.159]:33786 "EHLO
        relaydlg-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240168AbhIMPLB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Sep 2021 11:11:01 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relaydlg-01.paragon-software.com (Postfix) with ESMTPS id 63FA882267;
        Mon, 13 Sep 2021 18:09:43 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1631545783;
        bh=7dqnuSItHo/Nm50usnJkS4CyU9DPxf39OX6EeX5pDeY=;
        h=Date:To:CC:From:Subject;
        b=p3kn4+xo6q4dWpzWGSnfe30yLKroZd0iumWmvJ7ZXH9ggD/PjliAnMEuDKBRtcNhd
         qagfGGbTO77c/qpR7saZ6QIv0UexDjL5Y4fUPrGYKDxiiJKLTvANYAeva4+Y6SS28f
         HHTiVz06CzzX6V8fs++saKXWycJQ6+9Ryp2QXOSg=
Received: from [192.168.211.103] (192.168.211.103) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 13 Sep 2021 18:09:43 +0300
Message-ID: <a08b0948-80e2-13b4-ea22-d722384e054b@paragon-software.com>
Date:   Mon, 13 Sep 2021 18:09:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Content-Language: en-US
To:     <ntfs3@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH 0/3] fs/ntfs3: Speed up hardlink creation
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.211.103]
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

xfstest generic/041 was taking some time before failing,
so this series aims to fix it and speed up.
Because of this we raise hardlinks limit to 4000.
There are no drawbacks or regressions.
Theoretically we can raise all the way up to ffff,
but there is no practical use for this.

Konstantin Komarov (3):
  fs/ntfs3: Fix insertion of attr in ni_ins_attr_ext
  fs/ntfs3: Change max hardlinks limit to 4000
  fs/ntfs3: Add sync flag to ntfs_sb_write_run and al_update

 fs/ntfs3/attrib.c   | 2 +-
 fs/ntfs3/attrlist.c | 6 +++---
 fs/ntfs3/frecord.c  | 9 ++++++++-
 fs/ntfs3/fslog.c    | 8 ++++----
 fs/ntfs3/fsntfs.c   | 8 ++++----
 fs/ntfs3/inode.c    | 2 +-
 fs/ntfs3/ntfs.h     | 8 +++++---
 fs/ntfs3/ntfs_fs.h  | 4 ++--
 fs/ntfs3/xattr.c    | 2 +-
 9 files changed, 29 insertions(+), 20 deletions(-)

-- 
2.33.0
