Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24581EFCC7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2019 12:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730876AbfKEL6n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Nov 2019 06:58:43 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37388 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730852AbfKEL6m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Nov 2019 06:58:42 -0500
Received: by mail-pf1-f194.google.com with SMTP id p24so8643927pfn.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Nov 2019 03:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=h9VpA2g34Bu2I5d0STf5cy+RDlAZuPn+9VMhiuJJ58A=;
        b=sd3856InG/QyYul3VqhlArnsF0x4iZ/HQeEp+06OsidvKULY528KU0cR56wIdGhOXP
         nyehJRfCF4biYQ71fq6+lCd/JJOZKZY4EBWcthnaXzHimJoZGMR7K1Q2wE5sK8//7Aax
         L0ju/OrbBNRg4OTXt65AzHW8/NWRDvZAXZrg0aLMkWJJiiLy8l5yQ3MpX/itIkC4LpJK
         C+2dureap91CyCr76meAYTav4jfd2YrR801MdogeZFyzWs6vRXM2/yrC3Fz8YdWluHQ7
         JU4HWIOybDwca5FFmnTTpvpY2SK54YJmBRe16zlE7xckDKwnkPleeFsYRbrPMn0Xh2KE
         hwQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=h9VpA2g34Bu2I5d0STf5cy+RDlAZuPn+9VMhiuJJ58A=;
        b=Z0fXWz2mrmK3myCIz9H8DVUe866iMmz7u1PbPLXMD6+il7Njg2wijYJZbyHlytJL2n
         60jfcdAc5SuoNAQJG9PyjMI7G7xSGYC1awCMpAKYi/gyfaZNBueH/IuoVvkmHh4tcyFd
         MsYTBDvPVRUBzf9TMKR8p1/W2DilnDJ4t9JaDdlxjBrBbBVNWaoAvyoYO/rDH6AymUd7
         +Xlu9PjzxCfPBi1rgJk8htlrPYOzznqx7kNYLKJsEt0E/Sy/lJurMeXk7NPvp0tTaQvO
         LsZzcW1lucv4V1Hx1LibO7rKU52bGOx35uBIy8q4WAeKxNJQXQVxhP5+0Qnot942ryS4
         Umkg==
X-Gm-Message-State: APjAAAV7PjKD0eeOtfP+Qx66UdYyuIjbLTTzhbpvUzWqYOMr5yzPm2sP
        sAbYrpYAr9YCiDOiyrel6hjl
X-Google-Smtp-Source: APXvYqxJOgJ9erhU70ajuchnWDu639AJUNZmISD9Zn8d8WjfPdfLOUHwQdcwtgH5ctZan0kUobswwA==
X-Received: by 2002:a62:7a8a:: with SMTP id v132mr37566824pfc.228.1572955118184;
        Tue, 05 Nov 2019 03:58:38 -0800 (PST)
Received: from poseidon.bobrowski.net ([114.78.226.167])
        by smtp.gmail.com with ESMTPSA id 70sm20386845pfw.160.2019.11.05.03.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 03:58:37 -0800 (PST)
Date:   Tue, 5 Nov 2019 22:58:31 +1100
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        riteshh@linux.ibm.com
Subject: [PATCH v7 00/11] ext4: port direct I/O to iomap infrastructure
Message-ID: <cover.1572949325.git.mbobrowski@mbobrowski.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

This is an updated patch series of the ext4 direct I/O port to iomap
infrastructure. This updated series includes some minor updates and
fixes that were identified within the preceding patch
series. Changlog since v6 has been summarised below:

Changes since v6:

 - Removed duplicate map->m_flags check in ext4_set_iomap(), which
   cleaned up some of unnecessary levels of identation.

 - Fixed an issue with the buffered I/O fallback path within
   ext4_dio_write_iter(). Previously, we only returned the value that
   ext4_buffered_write_iter() would return without taking into account
   anything that possibly written for the direct I/O. This meant that
   we'd return incorrect values back to userspace. 

 - Added missing fsync + page cache invalidation for written I/O range
   post buffered I/O fallback. This was missing from my original patch
   series, but this is actually needed in order to preserve direct I/O
   semantics.

The original cover letter for this series has been provided below for
reference.

---

This patch series ports the ext4 direct IO paths to make use of the
iomap infrastructure. The legacy buffer_head based direct IO paths
have subsequently been removed as they're now no longer in use. The
result of this change is that the direct IO implementation is much   
cleaner and keeps the code isolated from the buffer_head internals. In
addition to this, a slight performance boost could be expected while 
using O_SYNC | O_DIRECT IO.

The changes have been tested using xfstests in both DAX and non-DAX
modes using various filesystem configurations i.e. 4k, dioread_nolock,
nojournal, ext3.

Matthew Bobrowski (11):
  ext4: reorder map.m_flags checks within ext4_iomap_begin()
  ext4: update direct I/O read lock pattern for IOCB_NOWAIT
  ext4: iomap that extends beyond EOF should be marked dirty
  ext4: move set iomap routines into a separate helper ext4_set_iomap()
  ext4: split IOMAP_WRITE branch in ext4_iomap_begin() into helper
  ext4: introduce new callback for IOMAP_REPORT
  ext4: introduce direct I/O read using iomap infrastructure
  ext4: move inode extension/truncate code out from ->iomap_end()
    callback
  ext4: move inode extension check out from ext4_iomap_alloc()
  ext4: update ext4_sync_file() to not use __generic_file_fsync()
  ext4: introduce direct I/O write using iomap infrastructure

 fs/ext4/ext4.h    |   4 +-
 fs/ext4/extents.c |  11 +-
 fs/ext4/file.c    | 412 +++++++++++++++++++++-----
 fs/ext4/fsync.c   |  72 +++--
 fs/ext4/inode.c   | 720 +++++++++++-----------------------------------
 5 files changed, 563 insertions(+), 656 deletions(-)

-- 
2.20.1

