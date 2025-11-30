Return-Path: <linux-fsdevel+bounces-70278-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 686F4C94D54
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Nov 2025 11:08:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC8BD3A4624
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Nov 2025 10:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C9026FD86;
	Sun, 30 Nov 2025 10:08:10 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C6C1373;
	Sun, 30 Nov 2025 10:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764497290; cv=none; b=O+UHp7Fx3edXGE8RkbWhcxSqalVopGJrMcBIpcqkbWwM7KJdOoB8mz0HiZd56FLVuyLdUgZY9toQb4nqJCG3199y4Rznd3VbMb/oJ4v6DoTOmJh0n6gC5tXWHM+g+xKhrm2iDUCt3cHbug2BFo8y55Uh05JejYcVLoRntx1x0hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764497290; c=relaxed/simple;
	bh=BXFBs7UfsJ23azeDN894SfOybCJKtFZxo4EJfCmeyb4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SWpaIPFVIRFxHaWDis2uycLh7etRWwbqvK2lQ5SYrrAZ39ie7L9fMxwVtp55CqFVf2aQdOuGyr6HbBu7+0KK8kzEcf5iD3AdDL/WF+OuRA2txT9wmr598qZuMBP8ihh/ZjVA+ui/VzYKchQDlXeVYhof5abfVaZ6Kpys8+jeQZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 5AUA7CS2080474;
	Sun, 30 Nov 2025 19:07:12 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 5AUA7CaR080471
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 30 Nov 2025 19:07:12 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <43eb85b9-4112-488b-8ea0-084a5592d03c@I-love.SAKURA.ne.jp>
Date: Sun, 30 Nov 2025 19:07:13 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] hfs: Validate CNIDs in hfs_read_inode
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
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <aSTuaUFnXzoQeIpv@Bertha>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav202.rs.sakura.ne.jp

On 2025/11/25 8:46, George Anthony Vernon wrote:
> On Tue, Nov 11, 2025 at 10:42:09PM +0000, Viacheslav Dubeyko wrote:
>> On Tue, 2025-11-11 at 23:39 +0900, Tetsuo Handa wrote:
>>> On 2025/11/04 10:47, George Anthony Vernon wrote:
>>>> +	if (!is_valid_cnid(inode->i_ino,
>>>> +			   S_ISDIR(inode->i_mode) ? HFS_CDR_DIR : HFS_CDR_FIL))
>>>> +		BUG();
>>>
>>> Is it guaranteed that hfs_write_inode() and make_bad_inode() never run in parallel?
>>> If no, this check is racy because make_bad_inode() makes S_ISDIR(inode->i_mode) == false.
>>>  
>>
>> Any inode should be completely created before any hfs_write_inode() call can
>> happen. So, I don't see how hfs_write_inode() and make_bad_inode() could run in
>> parallel.
>>
> 
> Could we not read the same inode a second time, during the execution of
> hfs_write_inode()?
> 
> Then I believe we could hit make_bad_inode() in hfs_read_inode() once we
> had already entered hfs_write_inode(), and so test a cnid against the
> wrong i_mode.
> 

My "Is it guaranteed that hfs_write_inode() and make_bad_inode() never run in parallel?"
question does not assume "make_bad_inode() for HFS is called from only hfs_read_inode()".

write_inode() already checks for !is_bad_inode(inode) before calling
filesystem's write_inode callback
( https://elixir.bootlin.com/linux/v6.18-rc7/source/fs/fs-writeback.c#L1558 ).

If the reason for "ubifs is doing it in the ubifs_write_inode()" 
( https://elixir.bootlin.com/linux/v6.18-rc7/source/fs/ubifs/super.c#L299 ) is
that make_bad_inode() could be called at any moment, it is not safe for HFS to
depend on "inode->i_mode does not change during hfs_write_inode()".


