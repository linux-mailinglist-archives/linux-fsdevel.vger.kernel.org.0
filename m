Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1197649E70E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jan 2022 17:08:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232851AbiA0QI3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jan 2022 11:08:29 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:49750 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbiA0QI2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jan 2022 11:08:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 43BB3B8018B;
        Thu, 27 Jan 2022 16:08:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD59AC340E8;
        Thu, 27 Jan 2022 16:08:25 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH RFC 0/6] NFSD size, offset, and count sanity
Date:   Thu, 27 Jan 2022 11:08:24 -0500
Message-Id:  <164329914731.5879.7791856151631542523.stgit@bazille.1015granger.net>
X-Mailer: git-send-email 2.34.0
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1717; h=from:subject:message-id; bh=E/VP6iMtTFrSABpfc1OeDYO6duDHScST683Ajmfql34=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBh8sNzSk/rTxZDE6+Y4nX67b07koxqmA0Zq+dkfbNK d8Gcsd+JAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYfLDcwAKCRAzarMzb2Z/l9D6D/ 4uU9Y9zM7d958eEJ727amQPb/TWnnTiLXeB3NWhLbQDAPYSyxJcy/7HdYg83TvKkmmfNmLi2BvH+uq pI4VEb/rKM2yV9L6EfIrQAQAoFbm4EVXDVmiTdP7iS4QWT8UVpFTMQ9+d7+W4VaqGf9QNf+pmDNmpP PouZHuRiL1jRdHvJeVK6jeUTcsIgugyq+FZYvQryu4X0E3B/Z10FeqD9uKizaSbFQCgQHLC2d6jZOS Ze/Jp4SZjyJ2qOX/krmsJ388hRcM8j/tEYehPHoZYihuiKg7JcBzRKyfuIPR2c7Kr5a+Rn0mLswt7g Qf7WYVHsDDwWHCTg+t53OvvCPNQ87iJxmEXlLSOut3ZA1F3gblH70gQiW02AfGw+IxdW/lCVfwwOOp cqETY/FnkZ6QjSWow9bjNJ5rNLneakjnWbdCawMdmYSCm15bZIqzWke8Ku9OSxxl8yJrM/No5sNdSk zpKbctuj4CJgU4ldP9jXdA4huoNavY0qfLJ6n9VkLRyd5I6WolmYy2iUFjwZOcm4HvuEke4Di8K1LL kkucAlAxCtJLZItt1IeY3s54dbHdwFq5sHVBZS5b2oKPWdThy5iXhEEvy0jlm/fraJ6lF3/9yWBtiA VmPxij0r6ER6wfKvs+RsMrwQZv6zrDBHJAuDtI2UT8nPKTffH5+Mxo0+5nwQ==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dan Aloni reported a problem with the way NFSD's READ implementation
deals with the very upper end of file sizes, and I got interested in
how some of the other operations handled it. I found some issues,
and have started a (growing) pile of patches to deal with them.

Since at least the SETATTR case appears to cause a crash on some
filesystems, I think several of these are 5.17-rc fodder (i.e.,
priority bug fixes). I see that NLM also has potential problems with
how the max file size is handled, but since locking doesn't involve
the page cache, I think fixes in that area can be delayed a bit.

Dan's still working on the READ issue. I need some input on whether
I understand the problem correctly and whether the NFS status codes
I've chosen to use are going to be reasonable or a problem for NFS
clients. I've attempted to stay within the bound of the NFS specs,
but sometimes the spec doesn't provide a mechanism in the protocol
to indicate that the client passed us a bogus size/offset/count.

---

Chuck Lever (6):
      NFSD: Fix NFSv4 SETATTR's handling of large file sizes
      NFSD: Fix NFSv3 SETATTR's handling of large file sizes
      NFSD: COMMIT operations must not return NFS?ERR_INVAL
      NFSD: Replace directory offset placeholder
      NFSD: Remove NFS_OFFSET_MAX
      NFSD: Clamp WRITE offsets


 fs/nfsd/nfs3proc.c  | 32 +++++++++++++++++++++------
 fs/nfsd/nfs3xdr.c   |  4 ++--
 fs/nfsd/nfs4proc.c  |  7 +++++-
 fs/nfsd/nfs4xdr.c   |  2 +-
 fs/nfsd/vfs.c       | 53 ++++++++++++++++++++++++++++++---------------
 fs/nfsd/vfs.h       |  4 ++--
 include/linux/nfs.h |  8 -------
 7 files changed, 72 insertions(+), 38 deletions(-)

--
Chuck Lever
