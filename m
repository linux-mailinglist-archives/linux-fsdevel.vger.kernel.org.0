Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D98633C540
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Mar 2021 19:08:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbhCOSHs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Mar 2021 14:07:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:48678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229928AbhCOSHT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Mar 2021 14:07:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E28A564F2A;
        Mon, 15 Mar 2021 18:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615831639;
        bh=v295vxGsC8ahqX+bV7Fu6wGb2RI3+X2koc0sedd0Jo0=;
        h=From:To:Cc:Subject:Date:From;
        b=d6gqOStNXhfjMECBN+vVoBUWiY4H4DeHzIa9A792+ZQThO8tkUOn919izl0ZIS154
         CmBgF8DwsJIcBTBxeAT7JkUdIdBiFMw9dQSvOGeajbrCiTLhBZzFNm1CkPT2KUPFOh
         DYCigy026h2DpMIG43rxy+9Ockc6ev0nZfS7qT3wlAU8brdPIYtvrxUN/yfNfPjisI
         YTl1nQ196CUZFMQizv8EDyBhGi1xnz7c7UU34PiUv3wTcsN6WOeicc95KA0m7QUYuG
         euNtoJ9K/sSEc6vy6uEH0+/QGUaqBLcpjA2jEA3e1nM7xUM5uJRjy9HySGViDrFDlL
         +IAkqllXB7D0Q==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org, idryomov@gmail.com
Cc:     linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk
Subject: [PATCH 0/2] ceph: snapdir dentry handling fixes
Date:   Mon, 15 Mar 2021 14:07:15 -0400
Message-Id: <20210315180717.266155-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

These patches fix a couple of problems that Al noticed around our
handling of snapdir dentries.

I'm going to feed these into our testing branch soon, along with
the ceph fixes (and helper patch) that Al posted in this series:

    https://lore.kernel.org/linux-fsdevel/YExBLBEbJRXDV19F@zeniv-ca.linux.org.uk/

It makes for a bit of a messy testing branch for now, unfortunately,
with the fscache changes in there as well, but hopefully we can
merge some of these fixes soon and get the branch back into a
simpler state.

Jeff Layton (2):
  ceph: don't clobber i_snap_caps on non-I_NEW inode
  ceph: don't use d_add in ceph_handle_snapdir

 fs/ceph/dir.c   | 30 ++++++++++++++++++------------
 fs/ceph/file.c  |  6 ++++--
 fs/ceph/inode.c |  7 ++++---
 fs/ceph/super.h |  2 +-
 4 files changed, 27 insertions(+), 18 deletions(-)

-- 
2.30.2

