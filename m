Return-Path: <linux-fsdevel+bounces-32830-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED02E9AF650
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 02:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76BDBB21F6C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 00:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A621078B;
	Fri, 25 Oct 2024 00:43:11 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C681859;
	Fri, 25 Oct 2024 00:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729816991; cv=none; b=pkqgjA4iqKVFsW1V4L/GLODOW/1tKHj9DW2L3pfhHQN4W0DVovBtOWelHKhhCL5bpZSueqtV29PCVOmBpvT3LZPxD3Le0weXiSo4Ma/oEBoWL+0/S6li+dioOzu4XeqQKdLOPl/KjG8UvOyUxKgQObQ+uasSJKqLFPPqvy7iI/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729816991; c=relaxed/simple;
	bh=h6uqLKA0bM7Qsdxx/tRPyXPx0R9jRJ9lBRgpxGwPhAk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=D+/txLD8lChZ5MUSZw3OClbIyth34Wn3KjRS+31T8BaW42V7OkPC6s53QBsoS/0z/TFCwCzebxaAlje2I2Z3KoMwfNYlNKxASfaS+O0047poh+yqYhCeXzMmd6Ik5bQ5NIx7H6nCZdwzCCoYKEGKKmDTjDXp/qIJgH26JIBHHDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 49P0fPbA057437;
	Fri, 25 Oct 2024 08:41:25 +0800 (+08)
	(envelope-from zhaoyang.huang@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4XZP8n5gfyz2K9cNZ;
	Fri, 25 Oct 2024 08:40:57 +0800 (CST)
Received: from bj03382pcu01.spreadtrum.com (10.0.73.40) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Fri, 25 Oct 2024 08:41:22 +0800
From: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
To: "Theodore Ts'o" <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, <linux-fsdevel@vger.kernel.org>,
        <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Zhaoyang Huang
	<huangzhaoyang@gmail.com>, <steve.kang@unisoc.com>
Subject: [Resend PATCHv3 1/1] fs: ext4: Don't use CMA for buffer_head
Date: Fri, 25 Oct 2024 08:41:06 +0800
Message-ID: <20241025004106.1031756-1-zhaoyang.huang@unisoc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL:SHSQR01.spreadtrum.com 49P0fPbA057437

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

cma_alloc() keep failed in our system which thanks to a jh->bh->b_page
can not be migrated out of CMA area[1] as the jh has one cp_transaction
pending on it because of j_free > j_max_transaction_buffers[2][3][4][5][6].
We temporarily solve this by launching jbd2_log_do_checkpoint forcefully
somewhere. Since journal is common mechanism to all JFSs and
cp_transaction has a little fewer opportunity to be launched, the
cma_alloc() could be affected under the same scenario. This patch
would like to have buffer_head of ext4 not use CMA pages when doing
sb_getblk.

[1]
crash_arm64_v8.0.4++> kmem -p|grep ffffff808f0aa150(sb->s_bdev->bd_inode->i_mapping)
fffffffe01a51c00  e9470000 ffffff808f0aa150        3  2 8000000008020 lru,private
fffffffe03d189c0 174627000 ffffff808f0aa150        4  2 2004000000008020 lru,private
fffffffe03d88e00 176238000 ffffff808f0aa150      3f9  2 2008000000008020 lru,private
fffffffe03d88e40 176239000 ffffff808f0aa150        6  2 2008000000008020 lru,private
fffffffe03d88e80 17623a000 ffffff808f0aa150        5  2 2008000000008020 lru,private
fffffffe03d88ec0 17623b000 ffffff808f0aa150        1  2 2008000000008020 lru,private
fffffffe03d88f00 17623c000 ffffff808f0aa150        0  2 2008000000008020 lru,private
fffffffe040e6540 183995000 ffffff808f0aa150      3f4  2 2004000000008020 lru,private

[2] page -> buffer_head
crash_arm64_v8.0.4++> struct page.private fffffffe01a51c00 -x
      private = 0xffffff802fca0c00

[3] buffer_head -> journal_head
crash_arm64_v8.0.4++> struct buffer_head.b_private 0xffffff802fca0c00
  b_private = 0xffffff8041338e10,

[4] journal_head -> b_cp_transaction
crash_arm64_v8.0.4++> struct journal_head.b_cp_transaction 0xffffff8041338e10 -x
  b_cp_transaction = 0xffffff80410f1900,

[5] transaction_t -> journal
crash_arm64_v8.0.4++> struct transaction_t.t_journal 0xffffff80410f1900 -x
  t_journal = 0xffffff80e70f3000,

[6] j_free & j_max_transaction_buffers
crash_arm64_v8.0.4++> struct journal_t.j_free,j_max_transaction_buffers 0xffffff80e70f3000 -x
  j_free = 0x3f1,
  j_max_transaction_buffers = 0x100,

Suggested-by: Theodore Ts'o <tytso@mit.edu>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
v3: switch to use getblk_unmoveable as suggested by Theodore Ts'o
---
---
 fs/ext4/inode.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 941c1c0d5c6e..a0f48840c5c1 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -869,7 +869,14 @@ struct buffer_head *ext4_getblk(handle_t *handle, struct inode *inode,
 	if (nowait)
 		return sb_find_get_block(inode->i_sb, map.m_pblk);
 
-	bh = sb_getblk(inode->i_sb, map.m_pblk);
+	/*
+	 * Since bh could introduce extra ref count such as referred by
+	 * journal_head etc. Try to avoid using __GFP_MOVABLE here
+	 * as it may fail the migration when journal_head remains.
+	 */
+	bh = getblk_unmovable(inode->i_sb->s_bdev, map.m_pblk,
+				inode->i_sb->s_blocksize);
+
 	if (unlikely(!bh))
 		return ERR_PTR(-ENOMEM);
 	if (map.m_flags & EXT4_MAP_NEW) {
-- 
2.25.1


