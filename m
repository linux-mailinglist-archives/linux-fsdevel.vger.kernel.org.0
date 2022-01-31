Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10F474A4E1D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jan 2022 19:25:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355691AbiAaSYw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jan 2022 13:24:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355009AbiAaSYo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jan 2022 13:24:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3936CC061401;
        Mon, 31 Jan 2022 10:24:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EB1F6B82BDD;
        Mon, 31 Jan 2022 18:24:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83CA9C340ED;
        Mon, 31 Jan 2022 18:24:41 +0000 (UTC)
Subject: [PATCH v2 0/5] NFSD size, offset, and count sanity
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Date:   Mon, 31 Jan 2022 13:24:39 -0500
Message-ID: <164365324981.3304.4571955521912946906.stgit@bazille.1015granger.net>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dan Aloni reported a problem with the way NFSD's READ implementation
deals with the very upper end of file sizes, and I got interested in
how some of the other operations handled it. I found some issues,
and have started a (growing) pile of patches to deal with them.

Since at least the SETATTR case appears to cause a crash on some
filesystems, I think several of these are 5.17-rc fodder (i.e.,
priority bug fixes). Dan's still working on the READ issue.

Changes since RFC:
- Series reordered so priority fixes come first
- Setattr size check is now in a common function
- Patch descriptions clarified

---

Chuck Lever (5):
      NFSD: Fix ia_size underflow
      NFSD: Fix NFSv3 SETATTR/CREATE's handling of large file sizes
      NFSD: Clamp WRITE offsets
      NFSD: COMMIT operations must not return NFS?ERR_INVAL
      NFSD: Deprecate NFS_OFFSET_MAX


 fs/nfsd/nfs3proc.c  | 21 ++++++++++++-----
 fs/nfsd/nfs3xdr.c   |  4 ++--
 fs/nfsd/nfs4proc.c  |  5 ++--
 fs/nfsd/nfs4xdr.c   |  2 +-
 fs/nfsd/vfs.c       | 57 +++++++++++++++++++++++++++++++--------------
 fs/nfsd/vfs.h       |  4 ++--
 include/linux/nfs.h |  8 -------
 7 files changed, 63 insertions(+), 38 deletions(-)

--
Chuck Lever

