Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76B55461326
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Nov 2021 12:06:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354876AbhK2LKF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Nov 2021 06:10:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376792AbhK2LIE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Nov 2021 06:08:04 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB017C08E89B;
        Mon, 29 Nov 2021 02:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=y+N6T9OX7HOXSR0XwGBs9AqYCmtI5mlyJgGLesZ2HD4=; b=WyDrKe/Bh7nQ7b/8LTVDbNFSYn
        EXxq5n73/ibf7zm6FmAT7XVapvybXUPlIXP78x4LNgdHQjtaVpQbj3XC2X3raEe99lvIRSxOmR7wW
        HiLQFMH92Ia/3oGO/pOBIv+fFbSdLCDdMhrsch/OnvhZd5mpH/29mtxEaEAJmrkCBxOc1wfFWNiM6
        rh/11Uz6PTBjfTQAj6T0jTJTP6rj3K0mpycAiDunQm4hT8eUpq7Ss6q5cooBawGxSohnff0n4TPZ4
        A9BNZkhL6PdqBIQElzxZLhNJAaZpf1SaVpH4aSbq7eHNN5/AkQlQrGoHjmlPCKPlRx4cjrl73Dh/y
        2ICGPwQA==;
Received: from [2001:4bb8:184:4a23:724a:c057:c7bf:4643] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mrdnP-0073IP-RJ; Mon, 29 Nov 2021 10:22:04 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Mike Snitzer <snitzer@redhat.com>, Ira Weiny <ira.weiny@intel.com>,
        dm-devel@redhat.com, linux-xfs@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-ext4@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: decouple DAX from block devices v2
Date:   Mon, 29 Nov 2021 11:21:34 +0100
Message-Id: <20211129102203.2243509-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Dan,

this series decouples the DAX from the block layer so that the
block_device is not needed at all for the DAX I/O path.

Changes since v1:
 - rebase on latest v5.16-rc
 - ensure the new dax zeroing helpers are always declared
 - fix a dax_dev leak in pmem_attach_disk
 - remove '\n' from an xfs format string
 - fix a pre-existing error handling bug in alloc_dev
 - fix a few whitespace issues
 - tighten an error check
 - use s64/u64 a little more
 - improve a few commit messages
 - add a CONFIG_FS_DAX ifdef to stub out IOMAP_DAX
 - improve how IOMAP_DAX is introduced and better document why it is
   added
