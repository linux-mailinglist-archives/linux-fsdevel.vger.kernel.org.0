Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0761C422E33
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Oct 2021 18:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236564AbhJEQpd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Oct 2021 12:45:33 -0400
Received: from relayfre-01.paragon-software.com ([176.12.100.13]:34190 "EHLO
        relayfre-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230445AbhJEQp2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Oct 2021 12:45:28 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 158531D3B;
        Tue,  5 Oct 2021 19:43:31 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1633452211;
        bh=4SlxtbDubO4N9p0GVXOUXPd4mZzR8LaYmU53E74TNIU=;
        h=Date:To:CC:From:Subject;
        b=PMwhkxL3MzQ53EEWM5lt9YyZYfaXSwAxsqB11nxTrDsiiUh6atG5QwMSYNLbodFp3
         LmA5IDcBNZzApAPM+G+6nVQyjIbuk0j+PyTugHMangT286JlwvBqykTrHUEx1EkAr8
         9D2CgDjP1NeDhRbJoGVyZEXySp8K91EySL7//TRY=
Received: from [192.168.211.181] (192.168.211.181) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 5 Oct 2021 19:43:30 +0300
Message-ID: <98a166e4-f894-8bff-9479-05ef5435f1ed@paragon-software.com>
Date:   Tue, 5 Oct 2021 19:43:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Content-Language: en-US
To:     <ntfs3@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH 0/5] fs/ntfs3: Reworking symlink functions
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.211.181]
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If length of symlink > 255, then we tried to convert
length of symlink +- some random number.
So main theme is removing 255 symbols limit in ntfs_utf16_to_nls.
Other bug - we haven't always returned correct size of symlink,
so we save it now in ntfs_create_inode.
Many commits affected, so no fixes tag.
This series fixes xfstest generic/423.

Konstantin Komarov (5):
  fs/ntfs3: Rework ntfs_utf16_to_nls
  fs/ntfs3: Refactor ntfs_readlink_hlp
  fs/ntfs3: Refactor ntfs_create_inode
  fs/ntfs3: Refactor ni_parse_reparse
  fs/ntfs3: Refactor ntfs_read_mft

 fs/ntfs3/dir.c     |  19 +++----
 fs/ntfs3/frecord.c |   9 ++--
 fs/ntfs3/inode.c   | 124 +++++++++++++++++++++------------------------
 fs/ntfs3/ntfs_fs.h |   4 +-
 4 files changed, 74 insertions(+), 82 deletions(-)

-- 
2.33.0

