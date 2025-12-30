Return-Path: <linux-fsdevel+bounces-72224-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3E3CE8765
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Dec 2025 02:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9D066300E468
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Dec 2025 01:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71AA32DCF58;
	Tue, 30 Dec 2025 01:07:18 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8427B13B584
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Dec 2025 01:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767056838; cv=none; b=VP1gK9abm+cKymz0t2d6rPPixKbbisWsPwuSpKQxXTcBt2Px164s/+oRMvIAG1/OEFLC5+dugs3dvokkZXYiDczt63RtM02pyekAtDXB8BvMTHIuhoh3dk0LnSLXfLau82BtU4WGVS+YsjuWOpJTLUBD+f61f/zbH1DMFLLmvKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767056838; c=relaxed/simple;
	bh=A5qa1/JUS2SYOKW6dk5Rhh2CemJrG3Xt6ORJFHJ0gSQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=h1SUDGEtuQnYmIvMPCgzEpVyF0VYKz9sbqGOmxb+00VxBMLP8vmGNJDJG+Spt2idQZpZjBmJ12n/19N8qTmgC7zDTtjxyzUEikexF7FyvOTvzVHcUU1u7JysRebuZ3CWs5zoScRmWL/g+g0IdqyuUtanTI57qG5MQieELJF6iPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 5BU171KU002533;
	Tue, 30 Dec 2025 10:07:01 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 5BU171v6002529
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 30 Dec 2025 10:07:01 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <bfa47de0-e55e-419c-9572-2d8a7b3b99f8@I-love.SAKURA.ne.jp>
Date: Tue, 30 Dec 2025 10:07:01 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hfsplus: pretend special inodes as regular files
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
        "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <8ce587c5-bc3e-4fc9-b00d-0af3589e2b5a@I-love.SAKURA.ne.jp>
 <86ac2d5c35aa2dc44e16d8d41cf09cebbcae250a.camel@ibm.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <86ac2d5c35aa2dc44e16d8d41cf09cebbcae250a.camel@ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav404.rs.sakura.ne.jp

On 2025/12/30 5:28, Viacheslav Dubeyko wrote:
> On Mon, 2025-12-29 at 20:42 +0900, Tetsuo Handa wrote:
>> syzbot is reporting that hfsplus_system_read_inode() from hfsplus_iget()
>> from hfsplus_btree_open() from hfsplus_fill_super() succeeds with
>> inode->i_mode == 0, for hfsplus_system_read_inode() does not call
>> hfsplus_get_perms() for updating inode->i_mode value.
>>
> 
> Frankly speaking, commit message sounds completely not clear:
> (1) What is the problem?

Commit af153bb63a33 ("vfs: catch invalid modes in may_open()") requires any inode
that can reach may_open() to have a valid file type (one of S_IFDIR/S_IFLNK/S_IFREG/
S_IFCHR/S_IFBLK/S_IFIFO/S_IFSOCK type). Even if an inode is for internal use only,
that inode must have a valid file type if userspace can pass that inode to
may_open(). Commit 4e8011ffec79 ("ntfs3: pretend $Extend records as regular files")
was an example for assigning a valid file type to an inode that is not meant to be
used (but still usable) from userspace. This patch is the same change for hfsplus.

> (2) How it can be reproduced?

Just build and run the attached C reproducer, on a kernel built with
CONFIG_DEBUG_VFS=y .

> (3) Why should we fix it?

Because that is a requirement introduced by commit af153bb63a33.

> 
> So, could you please rework the commit message?

F.Y.I. Regarding ntfs3, commit be99c62ac7e7 ("ntfs3: init run lock for extend
inode") was also needed due to hidden dependency. I don't know whether hfsplus
has similar hidden dependency.

> 
>> Reported-by: syzbot <syzbot+895c23f6917da440ed0d@syzkaller.appspotmail.com>
>> Closes: https://syzkaller.appspot.com/bug?extid=895c23f6917da440ed0d  
>> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
>> ---
>>  fs/hfsplus/super.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
>> index aaffa9e060a0..82e0bf066e3b 100644
>> --- a/fs/hfsplus/super.c
>> +++ b/fs/hfsplus/super.c
>> @@ -52,6 +52,7 @@ static int hfsplus_system_read_inode(struct inode *inode)
>>  	default:
>>  		return -EIO;
>>  	}
>> +	inode->i_mode = S_IFREG;
> 
> It's completely not clear why should it be fixed here? Currently, it looks to me
> like not proper place for the fix. Could we use already existing function for
> this? Why should we use namely S_IFREG for this case?

Do you mean "existing function" == hfsplus_get_perms() ? If yes, where can we find
the parameters needed for calling hfsplus_get_perms() ?

> 
> Thanks,
> Slava.
> 
>>  
>>  	return 0;
>>  }


