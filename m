Return-Path: <linux-fsdevel+bounces-72469-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D21CF7BA2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 06 Jan 2026 11:15:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 225683031343
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jan 2026 10:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB96F30FC34;
	Tue,  6 Jan 2026 10:11:51 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FE630F545;
	Tue,  6 Jan 2026 10:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767694309; cv=none; b=ZnPQIE42aPTCnwT+fEqPIjpnzeRrRt/o+l7YOEH/NPI7i1HgU6hEF17HWFiplJyhGkocIWQ3mtjG8wP7VmMU/Kgid34cRmpWyEdg5qgsU4ptRALYB/Qm7HUnhf5qfLHR+UVj/HcGDgjEFaZfpBcZQXHxG85pvjddS3cqQDnYv4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767694309; c=relaxed/simple;
	bh=7+pJ9a9wzlsO0NlkO0D77NZZGffvvy6kI4LGzXtpMqs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O7TKBZJZ5dXs/UI7iMU6u2wMAjzYAYLedjd9z98omfBkJFHe5ObPSpeu9msmckPQdcr79aAMi6z4a7f6iMZlWbeiauXM7uA0dOHzSbHH10hIhCybS6u89Ydpcp0f3PI/FaoSSGyZfw+0C5a4XLQx62p12Onvc/rZRea6t2R5hKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 606AAhR4051469;
	Tue, 6 Jan 2026 19:10:43 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 606AAhFa051464
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 6 Jan 2026 19:10:43 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <afaeed87-66bd-4203-ae81-842ca4619db9@I-love.SAKURA.ne.jp>
Date: Tue, 6 Jan 2026 19:10:41 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for 6.19-rc1] fs: preserve file type in make_bad_inode()
 unless invalid
To: Jan Kara <jack@suse.cz>
Cc: Mateusz Guzik <mjguzik@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>,
        syzbot <syzbot+d222f4b7129379c3d5bc@syzkaller.appspotmail.com>,
        brauner@kernel.org, jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
        linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, mark@fasheh.com,
        ocfs2-devel@lists.linux.dev, sj1557.seo@samsung.com,
        syzkaller-bugs@googlegroups.com, Chuck Lever <chuck.lever@oracle.com>
References: <6w4u7ysv6yxdqu3c5ug7pjbbwxlmczwgewukqyrap3ltpazp4s@ozir7zbfyvfj>
 <6930e200.a70a0220.d98e3.01bd.GAE@google.com>
 <CAGudoHE0Q-Loi_rsbk5rnzgtGfbvY+Fpo9g=NPJHqLP5G_AaUg@mail.gmail.com>
 <20251204082156.GK1712166@ZenIV>
 <CAGudoHGLFBq2Fg5ksJeVkn=S2pv6XzxenjVFrQYScA7QV9kwJw@mail.gmail.com>
 <7e2bd36e-3347-4781-a6fd-96a41b6c538d@I-love.SAKURA.ne.jp>
 <wqkxevwtev5p77czk2com5zvbbwcpxxeucrt7zbgjciqxjyivx@c7624klburuh>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <wqkxevwtev5p77czk2com5zvbbwcpxxeucrt7zbgjciqxjyivx@c7624klburuh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav304.rs.sakura.ne.jp
X-Virus-Status: clean

On 2025/12/10 19:09, Jan Kara wrote:
> On Wed 10-12-25 18:45:26, Tetsuo Handa wrote:
>> syzbot is hitting VFS_BUG_ON_INODE(!S_ISDIR(inode->i_mode)) check
>> introduced by commit e631df89cd5d ("fs: speed up path lookup with cheaper
>> handling of MAY_EXEC"), for make_bad_inode() is blindly changing file type
>> to S_IFREG. Since make_bad_inode() might be called after an inode is fully
>> constructed, make_bad_inode() should not needlessly change file type.
>>
>> Reported-by: syzbot+d222f4b7129379c3d5bc@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=d222f4b7129379c3d5bc
>> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> 
> No. make_bad_inode() must not be called once the inode is fully visible
> because that can cause all sorts of fun. That function is really only good
> for handling a situation when read of an inode from the disk failed or
> similar early error paths.
I'm surprised to hear that.

But since commit 58b6fcd2ab34 ("ocfs2: mark inode bad upon validation failure
during read") is a bug fix, we want to somehow prevent this bug from re-opening.

Minimal change for this release cycle might look like

----------
diff --git a/fs/ocfs2/inode.c b/fs/ocfs2/inode.c
index b5fcc2725a29..2c97c8b4013f 100644
--- a/fs/ocfs2/inode.c
+++ b/fs/ocfs2/inode.c
@@ -1715,8 +1715,13 @@ int ocfs2_read_inode_block_full(struct inode *inode, struct buffer_head **bh,
 	rc = ocfs2_read_blocks(INODE_CACHE(inode), OCFS2_I(inode)->ip_blkno,
 			       1, &tmp, flags, ocfs2_validate_inode_block);
 
-	if (rc < 0)
+	if (rc < 0) {
+		/* Preserve file type while making operations no-op. */
+		umode_t	mode = inode->i_mode & S_IFMT;
+
 		make_bad_inode(inode);
+		inode->i_mode = mode;
+	}
 	/* If ocfs2_read_blocks() got us a new bh, pass it up. */
 	if (!rc && !*bh)
 		*bh = tmp;
----------

but what approach do you prefer?

Introduce a copy of bad_{inode,file}_ops for ocfs2 and replace
a call to make_bad_inode() with updating only {inode,file}_ops ?

Or, modify existing {inode,file}_ops for ocfs2 to check whether
an I/O error has occurred in the past?


