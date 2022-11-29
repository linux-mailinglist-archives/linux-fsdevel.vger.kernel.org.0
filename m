Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC86663C7CB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Nov 2022 20:08:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236459AbiK2TIl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Nov 2022 14:08:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236422AbiK2TIj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Nov 2022 14:08:39 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107DA58017
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Nov 2022 11:08:38 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id d7so10561388qkk.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Nov 2022 11:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20210112.gappssmtp.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OaILpFq40Bz5P6+kzmAM1bn1Kpvx1kZ5TG22njvyBfw=;
        b=pd16YOH8W1VGnctWBWbpgxn8O5/gsIFhdijjfEsbeIJVGJqk7tRQdy3cRw9wBG0qq3
         e7eNV2nnUviJe5FrcVFHurXT1bCGzIbEN2EBHkT2Di+aZqv/I0yrxx2tZsq1b1nSmQ7z
         6pZzyu9ukAdN8UF/ZU7yQUZxpZxA52NdZ4QL+F2ge1lE4OatoI4YJCyqK0bJ1HadfwxC
         XDD7WgwaJUUdaQlqO989tEwebcyTflvQ1RjldvRZpdnKUofpknzpPPNJdpzj/jSVf4Yq
         M7JmfWr60TEeO9E5XDG48gjpNXLludDXaUy519ZGvszP9Z10gbCLODTTOjrRdVUE54Y1
         78Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OaILpFq40Bz5P6+kzmAM1bn1Kpvx1kZ5TG22njvyBfw=;
        b=0pdD/bEq+j3j2O+2HoOOdoNLj5gT1kN8aylRNXsxWB7YPuiC9yWmVG8Zw/LJBsFRnk
         Vf8xSljReTHIrHlqAKDDkRKQRzzKrDhcHG8QlL6W+w+JbpZt6uWFSB11suqYLZnf1za/
         w63A4n7s4oxDaX9kPYX3ncS22fmggLrLMtYpFL9ml9o8X45j8gLA5nOnwAG5oXUrYzWI
         avAq2zWE0jaGvcBMRzlYdlIFwa03c4iGwvPRKSlMJIIn/0d1zG6pHzOfo+v1xB8EBRN2
         QraaLqY3KMFjUyTQw7pVx4ioOqA1c2OCOMG9N8wpiEdlyBEm8pov1H1+m0N0wctUkAIE
         1oyw==
X-Gm-Message-State: ANoB5pl0Zhhs1or2CpLZFQqQoMAUfsmyhACmsZlXPqIVVXizBIw39iKz
        +razb0rxMg3cg0k+MLE31bcotg==
X-Google-Smtp-Source: AA0mqf4U9V0pn9mrlhnm5AnQV90Mtj4xBmBqrOFEAsI7/5rOHdQS5x2wSISMxqS11M0oo9o+gQP5lA==
X-Received: by 2002:a05:620a:3cf:b0:6fb:c039:c1b1 with SMTP id r15-20020a05620a03cf00b006fbc039c1b1mr37579478qkm.644.1669748917040;
        Tue, 29 Nov 2022 11:08:37 -0800 (PST)
Received: from smtpclient.apple (172-125-78-211.lightspeed.sntcca.sbcglobal.net. [172.125.78.211])
        by smtp.gmail.com with ESMTPSA id h4-20020a05620a400400b006f9e103260dsm11287366qko.91.2022.11.29.11.08.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Nov 2022 11:08:36 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH] hfs: Fix OOB Write in hfs_asc2mac
From:   Viacheslav Dubeyko <slava@dubeyko.com>
In-Reply-To: <8e298cc0-27b9-a61a-48cc-64a9186048c8@huawei.com>
Date:   Tue, 29 Nov 2022 11:08:31 -0800
Cc:     zippel@linux-m68k.org, akpm@osdl.org,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, sunnanyong@huawei.com,
        wangkefeng.wang@huawei.com,
        syzbot+dc3b1cf9111ab5fe98e7@syzkaller.appspotmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <481BF13E-8CEA-48B4-A29B-0BDE4CAABAF9@dubeyko.com>
References: <20221126043612.853428-1-zhangpeng362@huawei.com>
 <9F97B7A6-9E20-4D70-BA79-8301D80DF9DB@dubeyko.com>
 <8e298cc0-27b9-a61a-48cc-64a9186048c8@huawei.com>
To:     "zhangpeng (AS)" <zhangpeng362@huawei.com>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Nov 28, 2022, at 6:23 PM, zhangpeng (AS) <zhangpeng362@huawei.com> =
wrote:
>=20
> On 2022/11/29 3:29, Viacheslav Dubeyko wrote:
>=20
>>> On Nov 25, 2022, at 8:36 PM, Peng Zhang <zhangpeng362@huawei.com> =
wrote:
>>>=20
>>> From: ZhangPeng <zhangpeng362@huawei.com>
>>>=20
>>> Syzbot reported a OOB Write bug:
>>>=20
>>> loop0: detected capacity change from 0 to 64
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> BUG: KASAN: slab-out-of-bounds in hfs_asc2mac+0x467/0x9a0
>>> fs/hfs/trans.c:133
>>> Write of size 1 at addr ffff88801848314e by task =
syz-executor391/3632
>>>=20
>>> Call Trace:
>>> <TASK>
>>> __dump_stack lib/dump_stack.c:88 [inline]
>>> dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
>>> print_address_description+0x74/0x340 mm/kasan/report.c:284
>>> print_report+0x107/0x1f0 mm/kasan/report.c:395
>>> kasan_report+0xcd/0x100 mm/kasan/report.c:495
>>> hfs_asc2mac+0x467/0x9a0 fs/hfs/trans.c:133
>>> hfs_cat_build_key+0x92/0x170 fs/hfs/catalog.c:28
>>> hfs_lookup+0x1ab/0x2c0 fs/hfs/dir.c:31
>>> lookup_open fs/namei.c:3391 [inline]
>>> open_last_lookups fs/namei.c:3481 [inline]
>>> path_openat+0x10e6/0x2df0 fs/namei.c:3710
>>> do_filp_open+0x264/0x4f0 fs/namei.c:3740
>>>=20
>>> If in->len is much larger than HFS_NAMELEN(31) which is the maximum
>>> length of an HFS filename, a OOB Write could occur in hfs_asc2mac(). =
In
>>> that case, when the dst reaches the boundary, the srclen is still
>>> greater than 0, which causes a OOB Write.
>>> Fix this by adding a Check on dstlen before Writing to dst address.
>>>=20
>>> Fixes: 328b92278650 ("[PATCH] hfs: NLS support")
>>> Reported-by: syzbot+dc3b1cf9111ab5fe98e7@syzkaller.appspotmail.com
>>> Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
>>> ---
>>> fs/hfs/trans.c | 2 ++
>>> 1 file changed, 2 insertions(+)
>>>=20
>>> diff --git a/fs/hfs/trans.c b/fs/hfs/trans.c
>>> index 39f5e343bf4d..886158db07b3 100644
>>> --- a/fs/hfs/trans.c
>>> +++ b/fs/hfs/trans.c
>>> @@ -130,6 +130,8 @@ void hfs_asc2mac(struct super_block *sb, struct =
hfs_name *out, const struct qstr
>>> 				dst +=3D size;
>>> 				dstlen -=3D size;
>>> 			} else {
>>> +				if (dstlen =3D=3D 0)
>>> +					goto out;
>> Maybe, it makes sense to use dstlen instead of srclen in while()?
>>=20
>> We have now:
>>=20
>> while (srclen > 0) {
>>    <skipped>
>> } else {
>>    <skipped>
>> }
>>=20
>> We can use instead:
>>=20
>> while (dstlen > 0) {
>>    <skipped>
>> } else {
>>    <skipped>
>> }
>>=20
>> Will it fix the issue?
>>=20
>> Thanks,
>> Slava.
>=20
> Thank you for your help.
>=20
> After testing, it fix the issue.
> Would it be better to add dstlen > 0 instead of replacing srclen > 0 =
with dstlen > 0?
> Because there may be dstlen > 0 and srclen <=3D 0.
>=20
> we can use:
>=20
> while (srclen > 0 && dstlen > 0) {
>   <skipped>
> } else {
>   <skipped>
> }
>=20

Looks good to me.

Thanks,
Slava.

>=20
> Thanks,
> Zhang Peng
>=20
>>> 				*dst++ =3D ch > 0xff ? '?' : ch;
>>> 				dstlen--;
>>> 			}
>>> --=20
>>> 2.25.1

