Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39046F9B9E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2019 22:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbfKLVNE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Nov 2019 16:13:04 -0500
Received: from outbound.smtp.vt.edu ([198.82.183.121]:37392 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726991AbfKLVNE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Nov 2019 16:13:04 -0500
Received: from mr5.cc.vt.edu (mail.ipv6.vt.edu [IPv6:2607:b400:92:9:0:9d:8fcb:4116])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id xACLD25k029401
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2019 16:13:02 -0500
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
        by mr5.cc.vt.edu (8.14.7/8.14.7) with ESMTP id xACLCvne025276
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2019 16:13:02 -0500
Received: by mail-qk1-f199.google.com with SMTP id c77so44301qkb.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2019 13:13:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=WJCGNCQuaefXamcTcKNT2rb/G1MBbPGc68q4Yzm/TOg=;
        b=fTuirjVZUG72gD/IlTM9mylLx+e+pOv6sdMZjYp1bs1BOwDEfqucHfNvn6oQvCfMdZ
         Xj7tZBFkNzpVS7FjvphlvM5cLdiDDULAwvm5bir/+ZNoThwna7Xe1qORiKZYsFt5jXKR
         BRY6kZBWBBoksH9cAOfHXHbMWhys1+tJ3uDAwVfgGrjSAWr9i8tW+wSvqhhyR/HK7aSM
         ahxflkAtYyspmlR/+5uWj+7LxD0CQVYL7hvAXVgxo+2xKFaDipeenyNHVV0dhwiB7zl4
         W5Fb4Zf6I9ZNLVk6PjqkYcY+nj0xfrLN/vycL5GreoVhC9Cnu4g9vwgTRJxqHJ6VV0ji
         l1cw==
X-Gm-Message-State: APjAAAXMPtKB+7VIGJwLJHN9IHeH2ixmOrwNTBiS1ax3mzDqS/3c+lsw
        EKaGNVZm6lrrnaCP+ulC7XnlJ4t1by6Oj7u/XbZM/wGZjJsF4hTnW1TXdG4jHiS6fgo103hyM4L
        IVrWes+aR9nd8k/b9laT39YNYOFUQgpO9PbBP
X-Received: by 2002:a05:6214:852:: with SMTP id dg18mr31121808qvb.8.1573593177305;
        Tue, 12 Nov 2019 13:12:57 -0800 (PST)
X-Google-Smtp-Source: APXvYqxsliWtv6xDWsmrevBQ5GtlwQfk6b3uvCdFIZKa5oLiD2vzGoyheoUDQPh5rXVBdDUZpoLpDA==
X-Received: by 2002:a05:6214:852:: with SMTP id dg18mr31121782qvb.8.1573593176974;
        Tue, 12 Nov 2019 13:12:56 -0800 (PST)
Received: from turing-police.lan ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id 130sm9674214qkd.33.2019.11.12.13.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 13:12:55 -0800 (PST)
From:   Valdis Kletnieks <valdis.kletnieks@vt.edu>
X-Google-Original-From: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Valdis Kletnieks <Valdis.Kletnieks@vt.edu>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 00/12] staging: exfat: Heave FAT/VFAT over the side
Date:   Tue, 12 Nov 2019 16:12:26 -0500
Message-Id: <20191112211238.156490-1-Valdis.Kletnieks@vt.edu>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The first 4 patches iteratively remove more and more of the
FAT/VFAT code.

The second 8 patches make a lot of functions static, and
renames many of the rest to avoid namespace pollution.

Valdis Kletnieks (12):
  staging: exfat: Remove FAT/VFAT mount support, part 1
  staging: exfat: Remove FAT/VFAT mount support, part 2
  staging: exfat: Remove FAT/VFAT mount support, part 3
  staging: exfat: Remove FAT/VFAT mount support, part 4
  staging: exfat: Clean up the namespace pollution part 1
  staging: exfat: Clean up the namespace pollution part 2
  staging: exfat: Clean up the namespace pollution part 3
  staging: exfat: Clean up the namespace pollution part 4
  staging: exfat: Clean up the namespace pollution part 5
  staging: exfat: Clean up the namespace pollution part 6
  staging: exfat: Clean up the namespace pollution part 7
  staging: exfat: Clean up the namespace pollution part 8

 drivers/staging/exfat/Kconfig        |    9 -
 drivers/staging/exfat/exfat.h        |  160 +--
 drivers/staging/exfat/exfat_blkdev.c |   10 +-
 drivers/staging/exfat/exfat_cache.c  |  251 +---
 drivers/staging/exfat/exfat_core.c   | 1896 ++++++--------------------
 drivers/staging/exfat/exfat_nls.c    |  192 ---
 drivers/staging/exfat/exfat_super.c  |  359 ++---
 7 files changed, 595 insertions(+), 2282 deletions(-)

-- 
2.24.0

