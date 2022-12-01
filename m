Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAF3563FBAB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Dec 2022 00:10:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbiLAXKe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Dec 2022 18:10:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231446AbiLAXKW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Dec 2022 18:10:22 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF561C3FEC
        for <linux-fsdevel@vger.kernel.org>; Thu,  1 Dec 2022 15:09:35 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id y15so2995323qtv.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Dec 2022 15:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20210112.gappssmtp.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8r55NhVr723cwq0xc0lLRrnya0twXWY3CzmxTQ/dZkI=;
        b=dLEd/+ZmyTUCV4O9y9TMSltJmihMtv9UXsNn0xX/Q968beeCQDCwHJi5pPHXVTR78O
         7qeKTHd/S19uxhBD+8OH4MNNWg8+UR/rfukSPVBb4KHSTm/7gX/u5vhXETibNpCSOrwp
         xZ25CEfHMqwJkdU2iKMXAEIduAAyNECuDJY2CQkWK2gIVU105XWuXU2Bbq7tg4wN/7td
         /5QuwrSerATX7eI1xdLjGI4GireFJdMa/ovBXLHaS+uPHDuvsWLknxj/FCxDfdUVY5Rr
         vkRASZNdaPLrGg6PYBQE4GKTk8agTtdgxKkzdauMId1H1aWDduJIlV7XAZc5aQgMCKOk
         oIdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8r55NhVr723cwq0xc0lLRrnya0twXWY3CzmxTQ/dZkI=;
        b=M2RnAzSJZu6QRrM5oUS8MQO1vsBAbC1qG7I62+hROSF+4yNqN4jgzWobyGXL28yzO0
         HlLGwp/HnHNP3E5ZHDhISQDF1eOMTgKZmQo+GoRx0Gh1mD/N04IID+ZW4taxMiNYFTiE
         A2/YZgiaw3mlPaOEcMxYisRjQPCtZLIaggLMFCKgMGxRe1RtzObu2BxMJ9MoclTmDCbz
         MQ8vswDxnMhJDFEDW45sk2GZJD4Exj19C9qhHghCaQrGTJWna8JhSQlqboHXy4xidTBe
         /8Sz/LCVzfPbAsPx+p1IBKSzNuqaAzegwRHzKPWxu7G1SrKY6gHp9hj3/mR8vXv5WFbv
         cCYA==
X-Gm-Message-State: ANoB5pmdfpY7SRTbdJX+rzuIHbzEGv0QANYspyT2F4/4gikRxtAx8eUm
        vLCYIF2O9QMNrug1StHSLV4GDw==
X-Google-Smtp-Source: AA0mqf51axYhjkuyzk2AapRyYK9AGpKHMB+EfDiTiwEmH3b8i9FdDC6v9AeUlfPtkn/xwisHR+FMlA==
X-Received: by 2002:ac8:6897:0:b0:3a6:964c:c638 with SMTP id m23-20020ac86897000000b003a6964cc638mr2355191qtq.52.1669936174809;
        Thu, 01 Dec 2022 15:09:34 -0800 (PST)
Received: from smtpclient.apple (172-125-78-211.lightspeed.sntcca.sbcglobal.net. [172.125.78.211])
        by smtp.gmail.com with ESMTPSA id r12-20020a05620a298c00b006e16dcf99c8sm4384142qkp.71.2022.12.01.15.09.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Dec 2022 15:09:34 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH] hfs: Fix OOB Write in hfs_asc2mac
From:   Viacheslav Dubeyko <slava@dubeyko.com>
In-Reply-To: <2ca8a20b-047d-bae1-5a01-0892be4d7e7d@huawei.com>
Date:   Thu, 1 Dec 2022 15:09:22 -0800
Cc:     zippel@linux-m68k.org, akpm@osdl.org,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, sunnanyong@huawei.com,
        wangkefeng.wang@huawei.com,
        syzbot+dc3b1cf9111ab5fe98e7@syzkaller.appspotmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <7E14DFDD-CA11-46A7-8140-C4A0F9AD069D@dubeyko.com>
References: <20221126043612.853428-1-zhangpeng362@huawei.com>
 <9F97B7A6-9E20-4D70-BA79-8301D80DF9DB@dubeyko.com>
 <8e298cc0-27b9-a61a-48cc-64a9186048c8@huawei.com>
 <481BF13E-8CEA-48B4-A29B-0BDE4CAABAF9@dubeyko.com>
 <2ca8a20b-047d-bae1-5a01-0892be4d7e7d@huawei.com>
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



> On Nov 30, 2022, at 5:53 PM, zhangpeng (AS) <zhangpeng362@huawei.com> =
wrote:
>=20
>=20
> On 2022/11/30 3:08, Viacheslav Dubeyko wrote:
>>> On Nov 28, 2022, at 6:23 PM, zhangpeng (AS) =
<zhangpeng362@huawei.com> wrote:
>>>=20
>>> On 2022/11/29 3:29, Viacheslav Dubeyko wrote:
>>>>> On Nov 25, 2022, at 8:36 PM, Peng Zhang <zhangpeng362@huawei.com> =
wrote:
>>>>>=20
>>>>> From: ZhangPeng <zhangpeng362@huawei.com>
>>>>>=20
>>>>> Syzbot reported a OOB Write bug:
>>>>>=20
>>>>> loop0: detected capacity change from 0 to 64
>>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>>> BUG: KASAN: slab-out-of-bounds in hfs_asc2mac+0x467/0x9a0
>>>>> fs/hfs/trans.c:133
>>>>> Write of size 1 at addr ffff88801848314e by task =
syz-executor391/3632
>>>>>=20
>>>>> Call Trace:
>>>>> <TASK>
>>>>> __dump_stack lib/dump_stack.c:88 [inline]
>>>>> dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
>>>>> print_address_description+0x74/0x340 mm/kasan/report.c:284
>>>>> print_report+0x107/0x1f0 mm/kasan/report.c:395
>>>>> kasan_report+0xcd/0x100 mm/kasan/report.c:495
>>>>> hfs_asc2mac+0x467/0x9a0 fs/hfs/trans.c:133
>>>>> hfs_cat_build_key+0x92/0x170 fs/hfs/catalog.c:28
>>>>> hfs_lookup+0x1ab/0x2c0 fs/hfs/dir.c:31
>>>>> lookup_open fs/namei.c:3391 [inline]
>>>>> open_last_lookups fs/namei.c:3481 [inline]
>>>>> path_openat+0x10e6/0x2df0 fs/namei.c:3710
>>>>> do_filp_open+0x264/0x4f0 fs/namei.c:3740
>>>>>=20
>>>>> If in->len is much larger than HFS_NAMELEN(31) which is the =
maximum
>>>>> length of an HFS filename, a OOB Write could occur in =
hfs_asc2mac(). In
>>>>> that case, when the dst reaches the boundary, the srclen is still
>>>>> greater than 0, which causes a OOB Write.
>>>>> Fix this by adding a Check on dstlen before Writing to dst =
address.
>>>>>=20
>>>>> Fixes: 328b92278650 ("[PATCH] hfs: NLS support")
>>>>> Reported-by: syzbot+dc3b1cf9111ab5fe98e7@syzkaller.appspotmail.com
>>>>> Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
>>>>> ---
>>>>> fs/hfs/trans.c | 2 ++
>>>>> 1 file changed, 2 insertions(+)
>>>>>=20
>>>>> diff --git a/fs/hfs/trans.c b/fs/hfs/trans.c
>>>>> index 39f5e343bf4d..886158db07b3 100644
>>>>> --- a/fs/hfs/trans.c
>>>>> +++ b/fs/hfs/trans.c
>>>>> @@ -130,6 +130,8 @@ void hfs_asc2mac(struct super_block *sb, =
struct hfs_name *out, const struct qstr
>>>>> 				dst +=3D size;
>>>>> 				dstlen -=3D size;
>>>>> 			} else {
>>>>> +				if (dstlen =3D=3D 0)
>>>>> +					goto out;
>>>> Maybe, it makes sense to use dstlen instead of srclen in while()?
>>>>=20
>>>> We have now:
>>>>=20
>>>> while (srclen > 0) {
>>>>    <skipped>
>>>> } else {
>>>>    <skipped>
>>>> }
>>>>=20
>>>> We can use instead:
>>>>=20
>>>> while (dstlen > 0) {
>>>>    <skipped>
>>>> } else {
>>>>    <skipped>
>>>> }
>>>>=20
>>>> Will it fix the issue?
>>>>=20
>>>> Thanks,
>>>> Slava.
>>> Thank you for your help.
>>>=20
>>> After testing, it fix the issue.
>>> Would it be better to add dstlen > 0 instead of replacing srclen > 0 =
with dstlen > 0?
>>> Because there may be dstlen > 0 and srclen <=3D 0.
>>>=20
>>> we can use:
>>>=20
>>> while (srclen > 0 && dstlen > 0) {
>>>   <skipped>
>>> } else {
>>>   <skipped>
>>> }
>>>=20
>> Looks good to me.
>=20
> Can I put you down as a Reviewed-by or Suggested-by?

Sure. I hope to see the second version of the patch.

Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>

Thanks,
Slava.

>=20
> Thanks,
> Zhang Peng
>=20
>> Thanks,
>> Slava.
>>=20
>>> Thanks,
>>> Zhang Peng
>>>=20
>>>>> 				*dst++ =3D ch > 0xff ? '?' : ch;
>>>>> 				dstlen--;
>>>>> 			}
>>>>> --=20
>>>>> 2.25.1

