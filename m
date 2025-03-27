Return-Path: <linux-fsdevel+bounces-45160-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C2C6A73E71
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Mar 2025 20:15:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 180083BCD73
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Mar 2025 19:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2976C1C5D60;
	Thu, 27 Mar 2025 19:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fh2GXN8j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F88A55;
	Thu, 27 Mar 2025 19:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743102943; cv=none; b=nRdRlTkYqXX9Z3dJL522Q84QHqPPkQadfjMbvb325rhaSwx4rEN0IXaX9LB9BqTUv2+dhK7otv3puZf5VQOCGBjzLTPAavGJunQZzufQ+rt94tCk6pzpuCjc/UGCNGm8YceHnzyN+FaIGpQsSf00++WWP2Lu264KtFAe8IsWheE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743102943; c=relaxed/simple;
	bh=Rw5YIuasHI4FgVTE4nUpNhBDzZD/qo8wURofcGnCHPA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=HrursWj+QuPTB6DkxwmbM1YSo9NKeMhu1EVWHgmypl+dU54WQ9hiC/TbA0B1SCebHOd/+Tm6QJ0Vd9J667YH/jZpR8NHPXaPaNk3x5PYTxsCka+SMZ/Fvw9193ZHVrYoOgFfQv0g9KLjkb6Yb9EgGm2mCWv4EF2P1ADg6q7umXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fh2GXN8j; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4394036c0efso9598185e9.2;
        Thu, 27 Mar 2025 12:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743102940; x=1743707740; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zfwfv1QkpZUVspd7kmNSz+5Pyv+VFy0ns7dOJv/HVl4=;
        b=Fh2GXN8jSFKLObAex6klCqe1FmDDjFjcR6CXTILaxhNf3Y8hR483QoPxp1O1jenUeH
         NAhCfls2T5cZCbwuNE32CI9K9IcSc6DSEuUe+WIGP7iqPHpSaKcvop88S4M0cQ5xv32H
         uoeB21ddooGtV7suz/5yzKN/Zs1dhMHacmu4qzRQJ6/AduAtb2o+SF73GOEgpMUUA+Oy
         igORk4AWQye2CgM9rlWWN5xm70NSobXKl1HE98UUcakVaEW8d2aL8OIy+EFz8SGvJ9ZV
         GpqBI426e4fHzWwoSmlgQcRLjhdkP99gtG6MiS1u48ou7iKmKLckREmUylMvuK2Sr1Kx
         0e6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743102940; x=1743707740;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zfwfv1QkpZUVspd7kmNSz+5Pyv+VFy0ns7dOJv/HVl4=;
        b=Dssw4gv4a7A/G26ptVef010ugNvSw9o6xNh7G1bt9iNfGP8Bd+sdaWb0tKYlZGqHb1
         ZGUaviOGO2lak4KEm4x1Yl+lQGcz6HOdFZi7A/fLQEUTo1Hy4TSGZG3MMSq+CDCPaJGe
         CuoFhx6D9wpHJCkmCz/+LkwlyfCJXuCCFu8TplZe5bsr2/eCrRtyHufTuSuc5JLn+ysS
         j/8BRr/zP5vIyrfH2YQGPaU9270F4VA+YwElAbHVCqd71Qx2MrGRGAJZdH2AU3BH7JK0
         /k+4eM1WOnV7NqnzNq1/CyoyogSJjmC6m5PaKuIyizha3A7JJXNN4vjRDidThgA3uhmF
         Z9PA==
X-Forwarded-Encrypted: i=1; AJvYcCWXDd1kiV4B0etWxVrFXxcuGcuE+Kkt+ZP9wfSdcltWJeLzcSgF9tRfKVLHujftTDqV7O2BqOOx@vger.kernel.org, AJvYcCWm33hqdNTVUq+3XStstDhY+Rpq08JVWGliAaInQpPDn6/5wXouktN1k8UsgX22tdVvGaYzggARGDJVQ/W+@vger.kernel.org, AJvYcCXApjFDVsdo6T5CFahldbrAnCK2cQHr+pEr1Zij50vPe3pI4zkWnlOWieZ5E1ZXDnw93Ot721OlwkQ3QRoB@vger.kernel.org
X-Gm-Message-State: AOJu0YxL9wZbPWTs14q36ymyRYP1eMh65IF1KoR7AsvPewAXzVRGHZPw
	rO/Sz3vTw2BDvLGOAv2PbImam2gEz8Tx+0whEigMvMzyrPh6bGl2
X-Gm-Gg: ASbGncs82fum2XvsvF+vE1Xjo5/xZDeSnwbEiruihtD1EAUFMH7NSnS11H/608aPW57
	bRcJQLGCVhQy41zMfqnrr/dMVXwxtvez06Lmus81D/lI0p6SyzsT+El7qqJyNjrA/qXL4HPSyqU
	0jcWk1CpaMOnMgd2KOyrxPZ4pKyDNlLuUOPi5SpU+pV3zWWkP9kR9Ubi0jtVdNRg+CQgtTKsGxV
	viG9HZTMZP44+surchnlfnzjD1SQjH0ryhDg5l3Xc5jdIZeYkqqD0ZRWXSQLvb/leUMrRciO9F8
	kyi9v5Km8cDQwF/+FsjrXU+gS5s0wW1WQi0Ta1vCSfSgaLd45KITCA==
X-Google-Smtp-Source: AGHT+IF6wQGZ2i0qPbjE48g6AoqxPSkbrIx5QXDhbvYGV8JqzaVvMSMYLsYltI99DKGgpV1fk5VzWQ==
X-Received: by 2002:a05:600c:5103:b0:43d:683:8caa with SMTP id 5b1f17b1804b1-43d84fbea4bmr40267415e9.15.1743102939774;
        Thu, 27 Mar 2025 12:15:39 -0700 (PDT)
Received: from [192.168.3.5] ([212.115.166.76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d830f5f22sm46351685e9.30.2025.03.27.12.15.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Mar 2025 12:15:38 -0700 (PDT)
Message-ID: <3b1f2031-9f91-48d8-8c79-65d470142f26@gmail.com>
Date: Thu, 27 Mar 2025 20:15:36 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Attila Szasz <szasza.contact@gmail.com>
Subject: Re: [PATCH] hfs/hfsplus: fix slab-out-of-bounds in hfs_bnode_read_key
To: Greg KH <gregkh@linuxfoundation.org>,
 Cengiz Can <cengiz.can@canonical.com>
Cc: Salvatore Bonaccorso <carnil@debian.org>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-patches@linuxtesting.org,
 dutyrok@altlinux.org, syzbot+5f3a973ed3dfb85a6683@syzkaller.appspotmail.com,
 stable@vger.kernel.org
References: <20241019191303.24048-1-kovalev@altlinux.org>
 <Z9xsx-w4YCBuYjx5@eldamar.lan>
 <d4mpuomgxqi7xppaewlpey6thec7h2fk4sm2iktqsx6bhwu5ph@ctkjksxmkgne>
 <2025032402-jam-immovable-2d57@gregkh>
Content-Language: en-US
In-Reply-To: <2025032402-jam-immovable-2d57@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

hi, Attila here—the one who wrote the article and the PoC.

just for the record: this was a mistake then, and if one happens to 
discover another impactful bug in a potentially orphaned filesystem or 
another subsystem, it might EVEN get prioritized by upstream and stable 
over /panic_on_warn/ stuff next time, right? or am I missing something?

On 3/24/25 17:17, Greg KH wrote:
> On Mon, Mar 24, 2025 at 07:14:07PM +0300, Cengiz Can wrote:
>> On 20-03-25 20:30:15, Salvatore Bonaccorso wrote:
>>> Hi
>>>
>> Hello Salvatore,
>>
>>> On Sat, Oct 19, 2024 at 10:13:03PM +0300, Vasiliy Kovalev wrote:
>>>> Syzbot reported an issue in hfs subsystem:
>>>>
>>>> BUG: KASAN: slab-out-of-bounds in memcpy_from_page include/linux/highmem.h:423 [inline]
>>>> BUG: KASAN: slab-out-of-bounds in hfs_bnode_read fs/hfs/bnode.c:35 [inline]
>>>> BUG: KASAN: slab-out-of-bounds in hfs_bnode_read_key+0x314/0x450 fs/hfs/bnode.c:70
>>>> Write of size 94 at addr ffff8880123cd100 by task syz-executor237/5102
>>>>
>>>> Call Trace:
>>>>   <TASK>
>>>>   __dump_stack lib/dump_stack.c:94 [inline]
>>>>   dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>>>>   print_address_description mm/kasan/report.c:377 [inline]
>>>>   print_report+0x169/0x550 mm/kasan/report.c:488
>>>>   kasan_report+0x143/0x180 mm/kasan/report.c:601
>>>>   kasan_check_range+0x282/0x290 mm/kasan/generic.c:189
>>>>   __asan_memcpy+0x40/0x70 mm/kasan/shadow.c:106
>>>>   memcpy_from_page include/linux/highmem.h:423 [inline]
>>>>   hfs_bnode_read fs/hfs/bnode.c:35 [inline]
>>>>   hfs_bnode_read_key+0x314/0x450 fs/hfs/bnode.c:70
>>>>   hfs_brec_insert+0x7f3/0xbd0 fs/hfs/brec.c:159
>>>>   hfs_cat_create+0x41d/0xa50 fs/hfs/catalog.c:118
>>>>   hfs_mkdir+0x6c/0xe0 fs/hfs/dir.c:232
>>>>   vfs_mkdir+0x2f9/0x4f0 fs/namei.c:4257
>>>>   do_mkdirat+0x264/0x3a0 fs/namei.c:4280
>>>>   __do_sys_mkdir fs/namei.c:4300 [inline]
>>>>   __se_sys_mkdir fs/namei.c:4298 [inline]
>>>>   __x64_sys_mkdir+0x6c/0x80 fs/namei.c:4298
>>>>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>>>>   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>>>>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
>>>> RIP: 0033:0x7fbdd6057a99
>>>>
>>>> Add a check for key length in hfs_bnode_read_key to prevent
>>>> out-of-bounds memory access. If the key length is invalid, the
>>>> key buffer is cleared, improving stability and reliability.
>>>>
>>>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>>>> Reported-by:syzbot+5f3a973ed3dfb85a6683@syzkaller.appspotmail.com
>>>> Closes:https://syzkaller.appspot.com/bug?extid=5f3a973ed3dfb85a6683
>>>> Cc:stable@vger.kernel.org
>>>> Signed-off-by: Vasiliy Kovalev<kovalev@altlinux.org>
>>>> ---
>>>>   fs/hfs/bnode.c     | 6 ++++++
>>>>   fs/hfsplus/bnode.c | 6 ++++++
>>>>   2 files changed, 12 insertions(+)
>>>>
>>>> diff --git a/fs/hfs/bnode.c b/fs/hfs/bnode.c
>>>> index 6add6ebfef8967..cb823a8a6ba960 100644
>>>> --- a/fs/hfs/bnode.c
>>>> +++ b/fs/hfs/bnode.c
>>>> @@ -67,6 +67,12 @@ void hfs_bnode_read_key(struct hfs_bnode *node, void *key, int off)
>>>>   	else
>>>>   		key_len = tree->max_key_len + 1;
>>>>   
>>>> +	if (key_len > sizeof(hfs_btree_key) || key_len < 1) {
>>>> +		memset(key, 0, sizeof(hfs_btree_key));
>>>> +		pr_err("hfs: Invalid key length: %d\n", key_len);
>>>> +		return;
>>>> +	}
>>>> +
>>>>   	hfs_bnode_read(node, key, off, key_len);
>>>>   }
>> Simpler the better.
>>
>> Our fix was released back in February. (There are other issues in our attempt I
>> admit).
>>
>> https://git.launchpad.net/~ubuntu-kernel/ubuntu/+source/linux/+git/jammy/commit/?id=2e8d8dffa2e0b5291522548309ec70428be7cf5a
>>
>> If someone can pick this submission, I will be happy to replace our version.
> any specific reason why you didn't submit this upstream?  Or did that
> happen and it somehow not get picked up?
>
> And why assign a CVE for an issue that is in the mainline kernel, last I
> checked, Canonical was NOT allowed to do that.
>
> Please work to revoke that CVE and ask for one properly.
>
> thanks,
>
> greg k-h
>

