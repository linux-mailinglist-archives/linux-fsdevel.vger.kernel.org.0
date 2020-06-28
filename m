Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED2820C65F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jun 2020 08:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbgF1GKe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 28 Jun 2020 02:10:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:41960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725913AbgF1GKe (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 28 Jun 2020 02:10:34 -0400
Received: from sol.hsd1.ca.comcast.net (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 205F220702;
        Sun, 28 Jun 2020 06:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593324634;
        bh=Obir8NWpVyRdOF2tK7j8Pz3Unoae8GMKId/DtUm05yg=;
        h=From:To:Cc:Subject:Date:From;
        b=yN31eNYNzzLXSVQ1AuUz0ZUY1jN4jmlCZRGBtVP+t9qaHgQH53VNhIsp6QcgvUIVQ
         8eMD2+2mJ0DkJ/WPQDHbawydb81lHKUy5OyDdGCb+OZgklHmObvuIwjaat2re4tYyp
         fgYQBBHPhbEfibW+RKScSVHvjrDkFwSgwR8YlpY8=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Qiujun Huang <hqjagain@gmail.com>
Subject: [PATCH 0/6] fs/minix: fix syzbot bugs and set s_maxbytes
Date:   Sat, 27 Jun 2020 23:08:39 -0700
Message-Id: <20200628060846.682158-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This series fixes all syzbot bugs in the minix filesystem:

	KASAN: null-ptr-deref Write in get_block
	KASAN: use-after-free Write in get_block
	KASAN: use-after-free Read in get_block
	WARNING in inc_nlink
	KMSAN: uninit-value in get_block
	WARNING in drop_nlink

It also fixes the minix filesystem to set s_maxbytes correctly, so that
userspace sees the correct behavior when exceeding the max file size.

Al or Andrew: one of you will need to take these patches, since no one
is maintaining this filesystem.


Eric Biggers (6):
  fs/minix: check return value of sb_getblk()
  fs/minix: don't allow getting deleted inodes
  fs/minix: reject too-large maximum file size
  fs/minix: set s_maxbytes correctly
  fs/minix: fix block limit check for V1 filesystems
  fs/minix: remove expected error message in block_to_path()

 fs/minix/inode.c        | 42 +++++++++++++++++++++++++++++++++++++----
 fs/minix/itree_common.c |  8 +++++++-
 fs/minix/itree_v1.c     | 12 ++++++------
 fs/minix/itree_v2.c     | 13 ++++++-------
 fs/minix/minix.h        |  1 -
 5 files changed, 57 insertions(+), 19 deletions(-)

-- 
2.27.0

