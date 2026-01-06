Return-Path: <linux-fsdevel+bounces-72470-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C9633CF7C4B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 06 Jan 2026 11:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0AEEB305E160
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jan 2026 10:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD3F32693C;
	Tue,  6 Jan 2026 10:22:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035FA325492;
	Tue,  6 Jan 2026 10:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767694946; cv=none; b=sHg/ZbAb6EqkVdullEmR7LUEIifzBKU29II710TwToUSViDh6sWfOoF/sId/dA0xio2Hz50ZBeZ3Ug16fNh862FTUVKylWWIo9WKBlL6yzU+0gzLI6l1rlSAs/VdolB/IJPg7ZZnu83v2ad5oH/M8BfxiYn7EkF0ZwOtAKFP4Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767694946; c=relaxed/simple;
	bh=Qb6WoV9Vb+9ivg8YiGHYmDmhRSLCLFqNAxPn2UOFfRk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=NIrC8SE5zm/ZsgI+BR4DKmi0Ux8uNbSUEcGpgQFZyTuE7MyOaLINamz06OKMU3aCJ7P7BFz23HhpCqzrqJ4cz4rT9t6sUnj2YWJ/PVvG20oK3mI2Doztg8U/xeoaefSy8tL4p1k2FvSpxcz59jQXdXKiWr/3WpZlNP7QkP5jkyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 606ALgNX054401;
	Tue, 6 Jan 2026 19:21:42 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 606ALgkU054395
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 6 Jan 2026 19:21:42 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <75fd5e4a-65af-48b1-a739-c9eb04bc72c5@I-love.SAKURA.ne.jp>
Date: Tue, 6 Jan 2026 19:21:39 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] hfs: Validate CNIDs in hfs_read_inode
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: George Anthony Vernon <contact@gvernon.com>,
        Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "linux-kernel-mentees@lists.linux.dev"
 <linux-kernel-mentees@lists.linux.dev>,
        "syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com"
 <syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
References: <d2b28f73-49c8-4e30-9913-01702da4dfe4@I-love.SAKURA.ne.jp>
 <20251104014738.131872-3-contact@gvernon.com>
 <df9ed36b-ec8a-45e6-bff2-33a97ad3162c@I-love.SAKURA.ne.jp>
 <a31336352b94595c3b927d7d0ba40e4273052918.camel@ibm.com>
 <aSTuaUFnXzoQeIpv@Bertha>
 <43eb85b9-4112-488b-8ea0-084a5592d03c@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <43eb85b9-4112-488b-8ea0-084a5592d03c@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav404.rs.sakura.ne.jp

On 2025/11/30 19:07, Tetsuo Handa wrote:
> On 2025/11/25 8:46, George Anthony Vernon wrote:
>> On Tue, Nov 11, 2025 at 10:42:09PM +0000, Viacheslav Dubeyko wrote:
>>> On Tue, 2025-11-11 at 23:39 +0900, Tetsuo Handa wrote:
>>>> On 2025/11/04 10:47, George Anthony Vernon wrote:
>>>>> +	if (!is_valid_cnid(inode->i_ino,
>>>>> +			   S_ISDIR(inode->i_mode) ? HFS_CDR_DIR : HFS_CDR_FIL))
>>>>> +		BUG();
>>>>
>>>> Is it guaranteed that hfs_write_inode() and make_bad_inode() never run in parallel?
>>>> If no, this check is racy because make_bad_inode() makes S_ISDIR(inode->i_mode) == false.
>>>>  
>>>
>>> Any inode should be completely created before any hfs_write_inode() call can
>>> happen. So, I don't see how hfs_write_inode() and make_bad_inode() could run in
>>> parallel.
>>>
>>
>> Could we not read the same inode a second time, during the execution of
>> hfs_write_inode()?
>>
>> Then I believe we could hit make_bad_inode() in hfs_read_inode() once we
>> had already entered hfs_write_inode(), and so test a cnid against the
>> wrong i_mode.
>>
> 
> My "Is it guaranteed that hfs_write_inode() and make_bad_inode() never run in parallel?"
> question does not assume "make_bad_inode() for HFS is called from only hfs_read_inode()".

In a different thread, it turned out that make_bad_inode() must not be called
once the inode is fully visible
( https://lkml.kernel.org/r/wqkxevwtev5p77czk2com5zvbbwcpxxeucrt7zbgjciqxjyivx@c7624klburuh ),
requiring "make_bad_inode() for HFS is called from only hfs_read_inode()" assumption being true.

When can we expect next version of this patch?

> 
> write_inode() already checks for !is_bad_inode(inode) before calling
> filesystem's write_inode callback
> ( https://elixir.bootlin.com/linux/v6.18-rc7/source/fs/fs-writeback.c#L1558 ).
> 
> If the reason for "ubifs is doing it in the ubifs_write_inode()" 
> ( https://elixir.bootlin.com/linux/v6.18-rc7/source/fs/ubifs/super.c#L299 ) is
> that make_bad_inode() could be called at any moment, it is not safe for HFS to
> depend on "inode->i_mode does not change during hfs_write_inode()".
> 


