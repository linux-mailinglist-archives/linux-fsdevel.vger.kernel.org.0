Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4C2D4294DA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Oct 2021 18:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbhJKQ5k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Oct 2021 12:57:40 -0400
Received: from relaydlg-01.paragon-software.com ([81.5.88.159]:41681 "EHLO
        relaydlg-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229816AbhJKQ5k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Oct 2021 12:57:40 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relaydlg-01.paragon-software.com (Postfix) with ESMTPS id 37F2880901;
        Mon, 11 Oct 2021 19:55:38 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1633971338;
        bh=22cj4zb7cIg8ILTzWd3ObiPRTCpiobozufK3uDfMdw8=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=Od5qxkUDoRm3+5BdN0czT2LzjoShwi09s0xfV9JiQ3j9pfx2gOPs8WBwLeQQZSmhp
         8eDM7L4Iq/nvLg/6JshWnh0vjLMaoFfhsoaRBUJuQi4Kr6LRAsCF16qlCsiZ3Yvmma
         3Y1FnwMtVCne5+7b1V7xZuyEty5dwfpUYRry0J/0=
Received: from [192.168.211.33] (192.168.211.33) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 11 Oct 2021 19:55:37 +0300
Message-ID: <7e5b8dc9-9989-0e8a-9e8d-ae26b6e74df4@paragon-software.com>
Date:   Mon, 11 Oct 2021 19:55:37 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCH] fs/ntfs3: Check for NULL if ATTR_EA_INFO is incorrect
Content-Language: en-US
To:     Mohammad Rasim <mohammad.rasim96@gmail.com>
CC:     <ntfs3@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>,
        Kari Argillander <kari.argillander@gmail.com>
References: <227c13e3-5a22-0cba-41eb-fcaf41940711@paragon-software.com>
 <20211003175036.ly4m3lw2bjoippsh@kari-VirtualBox>
 <c892016c-3e50-739b-38d2-010f02d52019@gmail.com>
 <bcbb8ddc-3ddf-4a91-6e92-d5cee2722bad@paragon-software.com>
 <2998a9b9-8ea0-6a44-7093-66c7a08dcab2@gmail.com>
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
In-Reply-To: <2998a9b9-8ea0-6a44-7093-66c7a08dcab2@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.211.33]
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello.

Presumably we found the code, that panics.
But it panics in place, where pointer must be always not NULL.
Please try patch provided below.
If it helps (there is no panic), then check dmesg for
message "Looks like internal error".
And please compare copied folders.
This way it will be clear what file / folder cause this logic error.

Thanks for all your help so far.

[PATCH] fs/ntfs3: Check for NULL pointers in ni_try_remove_attr_list

All these checks must be redundant.
If this commit helps, then there is bug in code.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/frecord.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index ecb965e4afd0..37e19fe7d496 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -705,18 +705,35 @@ static int ni_try_remove_attr_list(struct ntfs_inode *ni)
 			continue;
 
 		mi = ni_find_mi(ni, ino_get(&le->ref));
+		if (!mi) {
+			/* Should never happened, 'cause already checked. */
+			goto bad;
+		}
 
 		attr = mi_find_attr(mi, NULL, le->type, le_name(le),
 				    le->name_len, &le->id);
+		if (!attr) {
+			/* Should never happened, 'cause already checked. */
+			goto bad;
+		}
 		asize = le32_to_cpu(attr->size);
 
 		/* Insert into primary record. */
 		attr_ins = mi_insert_attr(&ni->mi, le->type, le_name(le),
 					  le->name_len, asize,
 					  le16_to_cpu(attr->name_off));
-		id = attr_ins->id;
+		if (!attr_ins) {
+			/*
+			 * Internal error.
+			 * Either no space in primary record (already checked).
+			 * Either tried to insert another
+			 * non indexed attribute (logic error).
+			 */
+			goto bad;
+		}
 
 		/* Copy all except id. */
+		id = attr_ins->id;
 		memcpy(attr_ins, attr, asize);
 		attr_ins->id = id;
 
@@ -732,6 +749,10 @@ static int ni_try_remove_attr_list(struct ntfs_inode *ni)
 	ni->attr_list.dirty = false;
 
 	return 0;
+bad:
+	ntfs_inode_err(&ni->vfs_inode, "Looks like internal error");
+	make_bad_inode(&ni->vfs_inode);
+	return -EINVAL;
 }
 
 /*
-- 
2.33.0



On 06.10.2021 20:42, Mohammad Rasim wrote:
> 
> On 10/6/21 17:47, Konstantin Komarov wrote:
>>
>> On 04.10.2021 23:39, Mohammad Rasim wrote:
>>> On 10/3/21 20:50, Kari Argillander wrote:
>>>> On Wed, Sep 29, 2021 at 07:35:43PM +0300, Konstantin Komarov wrote:
>>>>> This can be reason for reported panic.
>>>>> Fixes: 4342306f0f0d ("fs/ntfs3: Add file operations and implementation")
>>>> I see that you have include this to devel branch but you did not send V2
>>>> [1]. I also included Mohammad Rasim to this thread. Maybe they can test
>>>> this patch. Rasim can you test [2] if your problem will be fixed with
>>>> this tree. Or just test this patch if you prefer that way.
>>>>
>>>> [1]: github.com/Paragon-Software-Group/linux-ntfs3/commit/35afb70dcfe4eb445060dd955e5b67d962869ce5
>>>> [2]: github.com/Paragon-Software-Group/linux-ntfs3/tree/devel
>>> Yeah unfortunately the problem still exist, moving the buildroot git tree from my nvme ext4 partition to my wd ntfs partition still causes the panic.
>>>
>>> Note that i used the master branch if that matters but it contains the same commit
>>>
>>>
>>> Regards
>>>
>> Is panic the same as old one?
>>
>> BUG: kernel NULL pointer dereference, address: 000000000000000e
>> RIP: 0010:ni_write_inode+0xe6b/0xed0 [ntfs3]
>> etc.
> 
> This is the complete panic log:
> 
> [  241.985898] ntfs3: sdb1: ino=724a0, "buildroot-raw" add mount option "acl" to use acl
> [  241.985905] ntfs3: sdb1: ino=724a0, "buildroot-raw" add mount option "acl" to use acl
> [  241.987109] ntfs3: sdb1: ino=724a1, ".git" add mount option "acl" to use acl
> [  241.987114] ntfs3: sdb1: ino=724a1, ".git" add mount option "acl" to use acl
> [  241.987630] ntfs3: sdb1: ino=724af, "branches" add mount option "acl" to use acl
> [  241.987634] ntfs3: sdb1: ino=724af, "branches" add mount option "acl" to use acl
> [  241.987645] ntfs3: sdb1: ino=724b0, "hooks" add mount option "acl" to use acl
> [  241.987647] ntfs3: sdb1: ino=724b0, "hooks" add mount option "acl" to use acl
> [  241.987670] ntfs3: sdb1: ino=724b1, "info" add mount option "acl" to use acl
> [  241.987672] ntfs3: sdb1: ino=724b1, "info" add mount option "acl" to use acl
> [  246.614529] BUG: kernel NULL pointer dereference, address: 000000000000000e
> [  246.614531] #PF: supervisor read access in kernel mode
> [  246.614532] #PF: error_code(0x0000) - not-present page
> [  246.614533] PGD 0 P4D 0
> [  246.614535] Oops: 0000 [#1] PREEMPT SMP NOPTI
> [  246.614536] CPU: 8 PID: 196 Comm: kworker/u64:7 Not tainted 5.14.0-rc7-MANJARO+ #51
> [  246.614538] Hardware name: Micro-Star International Co., Ltd MS-7C02/B450 TOMAHAWK MAX (MS-7C02), BIOS 3.B0 05/12/2021
> [  246.614539] Workqueue: writeback wb_workfn (flush-8:16)
> [  246.614543] RIP: 0010:ni_write_inode+0xd69/0xe40
> [  246.614545] Code: 4f 06 44 8b 40 04 41 8b 37 48 89 c3 44 0f b7 48 0a 48 8b 7c 24 18 4c 01 fa 44 89 44 24 30 e8 ae 32 01 00 8b 54 24 30 48 89 de <44> 0f b7 48 0e 48 89 c7 44 89 4c 24 28 e8 85 fc 97 00 44 8b 4c 24
> [  246.614546] RSP: 0018:ffffac2dc09cbac8 EFLAGS: 00010286
> [  246.614548] RAX: 0000000000000000 RBX: ffff98b0d08ac430 RCX: 0000000000000000
> [  246.614548] RDX: 0000000000000050 RSI: ffff98b0d08ac430 RDI: ffff98b0d88b31a4
> [  246.614549] RBP: ffff98b0d654f7a0 R08: ffff98b0d5be0000 R09: 0000000000000001
> [  246.614550] R10: 0000000000000002 R11: 0000000000000002 R12: 0000000000000000
> [  246.614550] R13: ffff98b0d4f6a000 R14: ffff98b0da2fcc80 R15: ffff98b0d08ab060
> [  246.614551] FS:  0000000000000000(0000) GS:ffff98b7dea00000(0000) knlGS:0000000000000000
> [  246.614552] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  246.614553] CR2: 000000000000000e CR3: 00008001011f8000 CR4: 0000000000350ee0
> [  246.614554] Call Trace:
> [  246.614558]  __writeback_single_inode+0x25a/0x310
> [  246.614560]  writeback_sb_inodes+0x1fc/0x480
> [  246.614562]  __writeback_inodes_wb+0x4c/0xe0
> [  246.614563]  wb_writeback+0x1ff/0x2f0
> [  246.614564]  wb_workfn+0x2f8/0x510
> [  246.614566]  ? psi_task_switch+0xb9/0x1e0
> [  246.614567]  ? _raw_spin_unlock+0x16/0x30
> [  246.614570]  process_one_work+0x1e3/0x3b0
> [  246.614573]  worker_thread+0x50/0x3b0
> [  246.614574]  ? process_one_work+0x3b0/0x3b0
> [  246.614575]  kthread+0x141/0x170
> [  246.614577]  ? set_kthread_struct+0x40/0x40
> [  246.614579]  ret_from_fork+0x22/0x30
> [  246.614582] Modules linked in:
> [  246.614584] CR2: 000000000000000e
> [  246.614585] ---[ end trace 7c7c742732266d51 ]---
> [  246.614585] RIP: 0010:ni_write_inode+0xd69/0xe40
> [  246.614587] Code: 4f 06 44 8b 40 04 41 8b 37 48 89 c3 44 0f b7 48 0a 48 8b 7c 24 18 4c 01 fa 44 89 44 24 30 e8 ae 32 01 00 8b 54 24 30 48 89 de <44> 0f b7 48 0e 48 89 c7 44 89 4c 24 28 e8 85 fc 97 00 44 8b 4c 24
> [  246.614587] RSP: 0018:ffffac2dc09cbac8 EFLAGS: 00010286
> [  246.614588] RAX: 0000000000000000 RBX: ffff98b0d08ac430 RCX: 0000000000000000
> [  246.614589] RDX: 0000000000000050 RSI: ffff98b0d08ac430 RDI: ffff98b0d88b31a4
> [  246.614589] RBP: ffff98b0d654f7a0 R08: ffff98b0d5be0000 R09: 0000000000000001
> [  246.614590] R10: 0000000000000002 R11: 0000000000000002 R12: 0000000000000000
> [  246.614590] R13: ffff98b0d4f6a000 R14: ffff98b0da2fcc80 R15: ffff98b0d08ab060
> [  246.614591] FS:  0000000000000000(0000) GS:ffff98b7dea00000(0000) knlGS:0000000000000000
> [  246.614592] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  246.614592] CR2: 000000000000000e CR3: 00008001011f8000 CR4: 0000000000350ee0
> [  246.991844] ntfs3: 6354 callbacks suppressed
> [  246.991846] ntfs3: sdb1: ino=73f4b, ".gstreamer1-mm.mk.SxnMfX" add mount option "acl" to use acl
> [  246.993111] ntfs3: sdb1: ino=73f4c, ".Config.in.2oeC7E" add mount option "acl" to use acl
> [  246.993135] ntfs3: sdb1: ino=73f4d, ".gstreamer1.hash.MS4lZ2" add mount option "acl" to use acl
> [  246.993159] ntfs3: sdb1: ino=73f4e, ".gstreamer1.mk.YFKaZf" add mount option "acl" to use acl
> [  246.993189] ntfs3: sdb1: ino=73f4f, ".Config.in.KMudor" add mount option "acl" to use acl
> [  246.993360] ntfs3: sdb1: ino=73f50, ".gtest.hash.2RTkJH" add mount option "acl" to use acl
> [  246.993383] ntfs3: sdb1: ino=73f51, ".gtest.mk.KTCGz4" add mount option "acl" to use acl
> [  246.993403] ntfs3: sdb1: ino=73f52, ".Config.in.8W4t5y" add mount option "acl" to use acl
> [  246.993423] ntfs3: sdb1: ino=73f53, ".gtk2-engines.hash.AOVwL1" add mount option "acl" to use acl
> [  246.994082] ntfs3: sdb1: ino=73f54, ".gtk2-engines.mk.WB8hM4" add mount option "acl" to use acl
> 
> 
>>>>> Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
>>>>> ---
>>>>>    fs/ntfs3/frecord.c | 4 +++-
>>>>>    1 file changed, 3 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
>>>>> index 9a53f809576d..007602badd90 100644
>>>>> --- a/fs/ntfs3/frecord.c
>>>>> +++ b/fs/ntfs3/frecord.c
>>>>> @@ -3080,7 +3080,9 @@ static bool ni_update_parent(struct ntfs_inode *ni, struct NTFS_DUP_INFO *dup,
>>>>>                           const struct EA_INFO *info;
>>>>>                             info = resident_data_ex(attr, sizeof(struct EA_INFO));
>>>>> -                       dup->ea_size = info->size_pack;
>>>>> +                       /* If ATTR_EA_INFO exists 'info' can't be NULL. */
>>>>> +                       if (info)
>>>>> +                               dup->ea_size = info->size_pack;
>>>>>                   }
>>>>>           }
>>>>>    --
>>>>> 2.33.0
>>>>>
