Return-Path: <linux-fsdevel+bounces-57256-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D866BB1FFE0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 09:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 836551882529
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 07:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1E52D77EA;
	Mon, 11 Aug 2025 07:06:18 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7B62571C2;
	Mon, 11 Aug 2025 07:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754895978; cv=none; b=R+nsdJ3Uu016BchzXF642Fiib7f2XtfPd9bdKOJmD/FLeQzWbL9YIuXlgyavfAVskwjUc/TAefJbbzuqSD28VWpStOod6mvV+LXrtdZ3F54nb9SAMkiLz91oZwtYepe0m1GAo0rdsYX7noYBWT4ILpL6eKFaOPvdeJh+8wP4x60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754895978; c=relaxed/simple;
	bh=g38dvR1K3Fo/LDbNEVuBOvMYI6+/dcIMEIiYKMG4oxA=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=FNZkcQCDGZuoWIrbHjD7/oXoGW6P2jw7Id4GsyZdh4/xxlZw9q8uE+GvloMR4hEYoYpfD38g7AQY2pOXDpkQ8jS4AMDN/FSn+bTZMuYM7pKBeKCHIDgqkBUCrjE/XvtO6zQZGj6olSnpz0i0cW2p7OBkWyvcVQIkGG+8Fsjzs9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 57B75oE0052388;
	Mon, 11 Aug 2025 16:05:50 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 57B75o4L052385
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 11 Aug 2025 16:05:50 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <fb3888fb-11b8-481b-86a6-766bbbab5c81@I-love.SAKURA.ne.jp>
Date: Mon, 11 Aug 2025 16:05:51 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Mateusz Guzik <mjguzik@gmail.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, ntfs3@lists.linux.dev,
        LKML <linux-kernel@vger.kernel.org>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [RFC PATCH] vfs: exclude ntfs3 from file mode validation in
 may_open()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav102.rs.sakura.ne.jp

Since ntfs_read_mft() not only accepts file modes which may_open() accepts
but also accepts

  (fname && fname->home.low == cpu_to_le32(MFT_REC_EXTEND) &&
   fname->home.seq == cpu_to_le16(MFT_REC_EXTEND)

case when the file mode is none of
S_IFDIR/S_IFLNK/S_IFREG/S_IFCHR/S_IFBLK/S_IFIFO/S_IFSOCK, may_open() cannot
unconditionally expect IS_ANON_FILE(inode) when the file mode is none of
S_IFDIR/S_IFLNK/S_IFREG/S_IFCHR/S_IFBLK/S_IFIFO/S_IFSOCK.

Treat as if S_IFREG when the inode is for NTFS3 filesystem.

Reported-by: syzbot <syzbot+895c23f6917da440ed0d@syzkaller.appspotmail.com>
Closes: https://syzkaller.appspot.com/bug?extid=895c23f6917da440ed0d
Fixes: af153bb63a33 ("vfs: catch invalid modes in may_open()")
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
Is it possible to handle this problem on the NTFS3 side?

  --- a/fs/ntfs3/inode.c
  +++ b/fs/ntfs3/inode.c
  @@ -470,8 +470,9 @@ static struct inode *ntfs_read_mft(struct inode *inode,
          } else if (fname && fname->home.low == cpu_to_le32(MFT_REC_EXTEND) &&
                     fname->home.seq == cpu_to_le16(MFT_REC_EXTEND)) {
                  /* Records in $Extend are not a files or general directories. */
                  inode->i_op = &ntfs_file_inode_operations;
  +               mode = S_IFREG;
          } else {
                  err = -EINVAL;
                  goto out;
          }

I don't know what breaks if we pretend as if S_IFREG...

 fs/namei.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/namei.c b/fs/namei.c
index cd43ff89fbaa..a66599754394 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3471,6 +3471,12 @@ static int may_open(struct mnt_idmap *idmap, const struct path *path,
 			return -EACCES;
 		break;
 	default:
+		/* Special handling for ntfs_read_mft() case. */
+		if (inode->i_sb->s_magic == 0x7366746e) {
+			if ((acc_mode & MAY_EXEC) && path_noexec(path))
+				return -EACCES;
+			break;
+		}
 		VFS_BUG_ON_INODE(!IS_ANON_FILE(inode), inode);
 	}
 
-- 
2.50.1

