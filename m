Return-Path: <linux-fsdevel+bounces-59310-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4A8B372C9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 21:01:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1E151BA57D9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 19:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A683680AA;
	Tue, 26 Aug 2025 19:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="rj4dQaB9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CC92F49EB;
	Tue, 26 Aug 2025 19:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756234909; cv=none; b=FmtHZKg5DnHzM/7WCVQVOZ3RKEIk+90auBFFPx16xXxVIS+Rgt9oLzDpg475tQT9a8t++TJxUJcXtdixt9Za5XavHvbQvxQVJqrZfgu0luQSlsr+IX1sG9iG3AS10qxldGtGjaMlK0LElMptGDO9hmOgpwv35pPaLAcNc9Yr48I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756234909; c=relaxed/simple;
	bh=PsujkU3WAIe+unlOeHB1UW1v53LMqA63zPaRUu/ssts=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D1iyaHqrVbnKpW3JrVcUbnynsVSR4C//IACjDDyaElXveC2hYLbT2Pi4YxK090ZnxhikcCkO6SEXOkZsf278v545ePKxXj0Aqz8rZ60X4+7rdM/W7+pCxdDdfsu9lrizhEuQ4I/fh5bE3AcKSFxZ0IGzPlB2+mS7hBK21AODroo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=rj4dQaB9; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=vzJV/EDDZjMhvVxr48dbxMuTMpEAoeJJukeiAdAVUxQ=; b=rj4dQaB9H52CQ7ZHRRqNHB6Y2d
	vNse0bRSboo8CuPrLZq944PDj26htYEHcH1E14aLd7rf40LMGZKvgguOXRYlzogq1L/otXPis1N58
	BzyehVSLvL8XdfN3tEpkNMV22BE9O99rtJK6YmswaKIkc7xvT1UQ5nsI4TR47u0lWbd6MmUgtDp6M
	RiVxfjUrkmY3EIfnRflo3MTFDjNdoXohVuZDBjFTVEi78AcBl75Jn8uQkOcnV2LmpQVJke/zZ2y7v
	J9Rx+6jxj125Tfmakoa4FIld9L7JEeSylOdGvrum8If9JGNaouKMPa5yQe1R9GERCmECMg9v+6Wd8
	zGjH4Mtw==;
Received: from [187.57.78.222] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1uqyuz-0023lF-P2; Tue, 26 Aug 2025 21:01:17 +0200
Message-ID: <18704e8c-c734-43f3-bc7c-b8be345e1bf5@igalia.com>
Date: Tue, 26 Aug 2025 16:01:13 -0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 9/9] ovl: Support mounting case-insensitive enabled
 layers
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Theodore Tso <tytso@mit.edu>,
 Gabriel Krisman Bertazi <krisman@kernel.org>, linux-unionfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 kernel-dev@igalia.com
References: <20250822-tonyk-overlayfs-v6-0-8b6e9e604fa2@igalia.com>
 <20250822-tonyk-overlayfs-v6-9-8b6e9e604fa2@igalia.com>
 <CAOQ4uxhWE=5_+DBx7OJ94NVCZXztxf1d4sxyMuakDGKUmbNyTg@mail.gmail.com>
 <62e60933-1c43-40c2-a166-91dd27b0e581@igalia.com>
 <CAOQ4uxjgp20vQuMO4GoMxva_8yR+kcW3EJxDuB=T-8KtvDr4kg@mail.gmail.com>
 <6235a4c0-2b28-4dd6-8f18-4c1f98015de6@igalia.com>
 <CAOQ4uxgMdeiPt1v4s07fZkGbs5+3sJw5VgcFu33_zH1dZtrSsg@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <CAOQ4uxgMdeiPt1v4s07fZkGbs5+3sJw5VgcFu33_zH1dZtrSsg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Em 26/08/2025 04:31, Amir Goldstein escreveu:
> On Mon, Aug 25, 2025 at 3:31 PM André Almeida <andrealmeid@igalia.com> wrote:
>>
>> Hi Amir,
>>
>> Em 22/08/2025 16:17, Amir Goldstein escreveu:
>>
>> [...]
>>
>>     /*
>>>>>> -        * Allow filesystems that are case-folding capable but deny composing
>>>>>> -        * ovl stack from case-folded directories.
>>>>>> +        * Exceptionally for layers with casefold, we accept that they have
>>>>>> +        * their own hash and compare operations
>>>>>>             */
>>>>>> -       if (sb_has_encoding(dentry->d_sb))
>>>>>> -               return IS_CASEFOLDED(d_inode(dentry));
>>>>>> +       if (ofs->casefold)
>>>>>> +               return false;
>>>>>
>>>>> I think this is better as:
>>>>>            if (sb_has_encoding(dentry->d_sb))
>>>>>                    return false;
>>>>>
>>>
>>> And this still fails the test "Casefold enabled" for me.
>>>
>>> Maybe you are confused because this does not look like
>>> a test failure. It looks like this:
>>>
>>> generic/999 5s ...  [19:10:21][  150.667994] overlayfs: failed lookup
>>> in lower (ovl-lower/casefold, name='subdir', err=-116): parent wrong
>>> casefold
>>> [  150.669741] overlayfs: failed lookup in lower (ovl-lower/casefold,
>>> name='subdir', err=-116): parent wrong casefold
>>> [  150.760644] overlayfs: failed lookup in lower (/ovl-lower,
>>> name='casefold', err=-66): child wrong casefold
>>>    [19:10:24] [not run]
>>> generic/999 -- overlayfs does not support casefold enabled layers
>>> Ran: generic/999
>>> Not run: generic/999
>>> Passed all 1 tests
>>>
>>
>> This is how the test output looks before my changes[1] to the test:
>>
>> $ ./run.sh
>> FSTYP         -- ext4
>> PLATFORM      -- Linux/x86_64 archlinux 6.17.0-rc1+ #1174 SMP
>> PREEMPT_DYNAMIC Mon Aug 25 10:18:09 -03 2025
>> MKFS_OPTIONS  -- -F /dev/vdc
>> MOUNT_OPTIONS -- -o acl,user_xattr /dev/vdc /tmp/dir2
>>
>> generic/999 1s ... [not run] overlayfs does not support casefold enabled
>> layers
>> Ran: generic/999
>> Not run: generic/999
>> Passed all 1 tests
>>
>>
>> And this is how it looks after my changes[1] to the test:
>>
>> $ ./run.sh
>> FSTYP         -- ext4
>> PLATFORM      -- Linux/x86_64 archlinux 6.17.0-rc1+ #1174 SMP
>> PREEMPT_DYNAMIC Mon Aug 25 10:18:09 -03 2025
>> MKFS_OPTIONS  -- -F /dev/vdc
>> MOUNT_OPTIONS -- -o acl,user_xattr /dev/vdc /tmp/dir2
>>
>> generic/999        1s
>> Ran: generic/999
>> Passed all 1 tests
>>
>> So, as far as I can tell, the casefold enabled is not being skipped
>> after the fix to the test.
> 
> Is this how it looks with your v6 or after fixing the bug:
> https://lore.kernel.org/linux-unionfs/68a8c4d7.050a0220.37038e.005c.GAE@google.com/
> 
> Because for me this skipping started after fixing this bug
> Maybe we fixed the bug incorrectly, but I did not see what the problem
> was from a quick look.
> 
> Can you test with my branch:
> https://github.com/amir73il/linux/commits/ovl_casefold/
> 

Right, our branches have a different base, mine is older and based on 
the tag vfs/vfs-6.18.mount.

I have now tested with your branch, and indeed the test fails with 
"overlayfs does not support casefold enabled". I did some debugging and 
the missing commit from my branch that is making this difference here is 
e8bd877fb76bb9f3 ("ovl: fix possible double unlink"). After reverting it 
on top of your branch, the test works. I'm not sure yet why this 
prevents the mount, but this is the call trace when the error happens:

TID/PID 860/860 (mount/mount):

                     entry_SYSCALL_64_after_hwframe+0x77
                     do_syscall_64+0xa2
                     x64_sys_call+0x1bc3
                     __x64_sys_fsconfig+0x46c
                     vfs_cmd_create+0x60
                     vfs_get_tree+0x2e
                     ovl_get_tree+0x19
                     get_tree_nodev+0x70
                     ovl_fill_super+0x53b
!    0us [-EINVAL]  ovl_parent_lock

And for the ovl_parent_lock() arguments, *parent="work", *child="#7". So 
right now I'm trying to figure out why the dentry for #7 is not hashed.

>>
>> [1]
>> https://lore.kernel.org/lkml/5da6b0f4-2730-4783-9c57-c46c2d13e848@igalia.com/
>>
>>
>>> I'm not sure I will keep the test this way. This is not very standard nor
>>> good practice, to run half of the test and then skip it.
>>> I would probably split it into two tests.
>>> The first one as it is now will run to completion on kenrels >= v6.17
>>> and the Casefold enable test will run on kernels >= v6.18.
>>>
>>> In any case, please make sure that the test is not skipped when testing
>>> Casefold enabled layers
>>>
>>> And then continue with the missing test cases.
>>>
>>> When you have a test that passes please send the test itself or
>>> a fstest branch for me to test.
>>
>> Ok!
> 
> I assume you are testing with ext4 layers?
> 
> If we are both testing the same code and same test and getting different
> results I would like to get to the bottom of this, so please share as much
> information on your test setup as you can.
> 
> Thanks,
> Amir.


