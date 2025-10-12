Return-Path: <linux-fsdevel+bounces-63854-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F61BD005E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Oct 2025 09:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 389911895DEC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Oct 2025 07:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B81E221F26;
	Sun, 12 Oct 2025 07:35:11 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE43221D596;
	Sun, 12 Oct 2025 07:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760254510; cv=none; b=MVOHPl9dMUR8uNjxLhPA5lFQKj9XMeO8koNf2SdcCz2aq+7yc76TM5mQ93WRbZ2CekzO5RAFlFgvQccvLFCoCFHJ+Ur3L5ci4OlrzqFjwA8XzsVf0sk6ZWAKnyCbT9VJDibzwKEzZQMrAbCzwmBU4IUVIs4cZG6geF2ViAxiTG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760254510; c=relaxed/simple;
	bh=o6tyA3/YxVabiXapleK9xx0h/rI5xhFsgTrkc3SOF1M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jADVdYog13/gYHLpk5d2rQi4Q/EiaiIaWsyQUWfzayX21nhzxxmU9IY4pmLrHpZBCr8BRULr5XcEW4Wmb4BN7Ildcn+jtj06MmpXS0LRyS5Y+Qtjh1ZQy33PpzbNGR2BQH66wfufDatjmcPXIlpq7lffprXzg/w+ety3Q/BTK/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 59C7Ywho024093;
	Sun, 12 Oct 2025 16:34:58 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 59C7YwkB024090
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 12 Oct 2025 16:34:58 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <ddd2cd94-683f-462b-a475-cc04462e9bdd@I-love.SAKURA.ne.jp>
Date: Sun, 12 Oct 2025 16:34:56 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bfs: Verify inode mode when loading from disk
To: Tigran Aivazian <aivazian.tigran@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <a5f67878-33ca-4433-9c05-f508f0ca5d0a@I-love.SAKURA.ne.jp>
 <CAK+_RL=ybNZz3z-Fqxhxg+0fnuA1iRd=MbTCZ=M3KbSjFzEnVg@mail.gmail.com>
 <CAK+_RLkaet_oCHAb1gCTStLyzA5oaiqKHHi=dCFLsM+vydN2FA@mail.gmail.com>
 <340c759f-d102-4d46-b1f2-a797958a89e4@I-love.SAKURA.ne.jp>
 <CAK+_RLmbaxE9Q-ORiOUV8emrB+M6e7YgUNZEb48VwD28EuqwhQ@mail.gmail.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CAK+_RLmbaxE9Q-ORiOUV8emrB+M6e7YgUNZEb48VwD28EuqwhQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav403.rs.sakura.ne.jp
X-Virus-Status: clean

On 2025/10/12 1:29, Tigran Aivazian wrote:
>> Which pattern (just adding a new "if", or adding "else" with "if" and "else if" updated,
>> or replace the 0x0000FFFF mask with 0x00000FFF) do you prefer?
> 
> There is also the fourth way, see the patch below. It makes it as
> explicit as possible that vtype value is the authoritative one and
> sets the type bits from vtype by keeping (in i_mode) only the
> permission/suid/sgid/sticky bits upfront. What do you think?

Well, I feel that we should choose "replace the 0x0000FFFF mask with
0x00000FFF" approach, for situation might be worse than HFS+ case.

HFS+ explicitly explains that all bits are 0 when that field is not initialized.

  If the S_IFMT field (upper 4 bits) of the fileMode field is zero, then
  Mac OS X assumes that the permissions structure is uninitialized, and
  internally uses default values for all of the fields. 

But "BFS inodes" in https://martin.hinner.info/fs/bfs/bfs-structure.html did not
say that SCO UnixWare sets 0 to the unused 23 bits when writing to disk.

  32bit int 	mode 	File mode, rwxrwxrwx (only low 9 bits used) 

This means that the unused 23 bits might be random, and therefore we can't
trust S_IFMT bits. Please see the patch shown below.

 fs/bfs/inode.c |   19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/fs/bfs/inode.c b/fs/bfs/inode.c
index 1d41ce477df5..984b365df046 100644
--- a/fs/bfs/inode.c
+++ b/fs/bfs/inode.c
@@ -61,7 +61,19 @@ struct inode *bfs_iget(struct super_block *sb, unsigned long ino)
 	off = (ino - BFS_ROOT_INO) % BFS_INODES_PER_BLOCK;
 	di = (struct bfs_inode *)bh->b_data + off;
 
-	inode->i_mode = 0x0000FFFF & le32_to_cpu(di->i_mode);
+	/*
+	 * https://martin.hinner.info/fs/bfs/bfs-structure.html explains that
+	 * BFS in SCO UnixWare environment used only lower 9 bits of di->i_mode
+	 * value. This means that, although bfs_write_inode() saves whole
+	 * inode->i_mode bits (which include S_IFMT bits and S_IS{UID,GID,VTX}
+	 * bits), middle 7 bits of di->i_mode value can be garbage when these
+	 * bits were not saved by bfs_write_inode().
+	 * Since we can't tell whether middle 7 bits are garbage, use only
+	 * lower 12 bits (i.e. tolerate S_IS{UID,GID,VTX} bits possibly being
+	 * garbage) and reconstruct S_IFMT bits for Linux environment from
+	 * di->i_vtype value.
+	 */
+	inode->i_mode = 0x00000FFF & le32_to_cpu(di->i_mode);
 	if (le32_to_cpu(di->i_vtype) == BFS_VDIR) {
 		inode->i_mode |= S_IFDIR;
 		inode->i_op = &bfs_dir_inops;
@@ -71,6 +83,11 @@ struct inode *bfs_iget(struct super_block *sb, unsigned long ino)
 		inode->i_op = &bfs_file_inops;
 		inode->i_fop = &bfs_file_operations;
 		inode->i_mapping->a_ops = &bfs_aops;
+	} else {
+		brelse(bh);
+		printf("Unknown vtype=%u %s:%08lx\n",
+		       le32_to_cpu(di->i_vtype), inode->i_sb->s_id, ino);
+		goto error;
 	}
 
 	BFS_I(inode)->i_sblock =  le32_to_cpu(di->i_sblock);


