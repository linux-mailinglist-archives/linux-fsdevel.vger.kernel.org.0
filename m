Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58FEB63B23E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Nov 2022 20:30:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233391AbiK1TaF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Nov 2022 14:30:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbiK1TaD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Nov 2022 14:30:03 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E09942CC92
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Nov 2022 11:30:02 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id w4so7456499qts.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Nov 2022 11:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20210112.gappssmtp.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NjZkaDVMKTzaqiyH90BF4ExxRXxg/Ij7l2eo+wL7k7Y=;
        b=4sZ9GwIPbixXbiOcbczJccyJKxuY4hJWzWuvxuGary9Gih0Yd47slt4PVVR+bL+8xU
         EE8X/PNxZhmH0qtfoAFqCtbwz6MSXHB+mc2Lkp9scdzFAmoqiDuBZrZ7WZxUTncLLPQo
         JVBdZiX0a4ApgjgZRM6xfCvNFAh9ogDntT9tFjoV9A9J3JoZq0pFZJzjowKH0SXCy2cn
         YyvDiTO64Ac/pl2nhWQJHpjXXlkc8/Bx/ZgKoJHbemSgmFI521Tt+ViY40bpbtHMvmOt
         vo231e2gYqhh39oq8axDCuFQvnFPrQHDK6B7DN++RlGH7QCDbadARLNJfDhHsbLYYEqm
         U8Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NjZkaDVMKTzaqiyH90BF4ExxRXxg/Ij7l2eo+wL7k7Y=;
        b=2N489xSaV6hidhBJ8hrS7rS8hbfuLpQpchGCA79CrocLAQ5kQF0z6SDBeiVclMzAh7
         wgWnWnXYL1cm3vbhh+rGWWFo1ylQI6gAR+Eekn7RaHVul9DlrLxD5igccCdCHQUF7IQe
         cki2rVcktFJh1k5Ze7+bCyCTidYWzOsQwdOQH9240OzaBViUnACnf6QoSnogC1x/MQjH
         YhCynhuq96Ni62c0DQKYhOg2QDUmm+hxbsJjiBrp0BpKM474ju4wEnwIhIG5yeMdLs2W
         PVuqY4IgB3bOohH6eRREWrYQOeMCct5a7XrI8VUL6smKbXxIpOXOT8nwktoh4uaQqWUF
         6G0w==
X-Gm-Message-State: ANoB5pn/JEil9j2lJqTBKIBJQTW9paRe2ny4z/vF8qXXwC0dRq5PYc3M
        zPwLILuBfAdLGImuS3iq7Nj4/KZE4jgPMZedsjA=
X-Google-Smtp-Source: AA0mqf4KT9Uqgg3efFvZhSFMLETz2zg9NQtK+X+Wrve6HgJeaQdUhf5SaOkJY4LErxvJF5p+IlIn9w==
X-Received: by 2002:ac8:4d4e:0:b0:3a6:5afc:9a20 with SMTP id x14-20020ac84d4e000000b003a65afc9a20mr26215221qtv.183.1669663801991;
        Mon, 28 Nov 2022 11:30:01 -0800 (PST)
Received: from smtpclient.apple (172-125-78-211.lightspeed.sntcca.sbcglobal.net. [172.125.78.211])
        by smtp.gmail.com with ESMTPSA id a195-20020ae9e8cc000000b006fb3884e10bsm8822247qkg.24.2022.11.28.11.30.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Nov 2022 11:30:00 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH] hfs: Fix OOB Write in hfs_asc2mac
From:   Viacheslav Dubeyko <slava@dubeyko.com>
In-Reply-To: <20221126043612.853428-1-zhangpeng362@huawei.com>
Date:   Mon, 28 Nov 2022 11:29:57 -0800
Cc:     zippel@linux-m68k.org, akpm@osdl.org,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-kernel@vger.kernel.org, sunnanyong@huawei.com,
        wangkefeng.wang@huawei.com,
        syzbot+dc3b1cf9111ab5fe98e7@syzkaller.appspotmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <9F97B7A6-9E20-4D70-BA79-8301D80DF9DB@dubeyko.com>
References: <20221126043612.853428-1-zhangpeng362@huawei.com>
To:     Peng Zhang <zhangpeng362@huawei.com>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Nov 25, 2022, at 8:36 PM, Peng Zhang <zhangpeng362@huawei.com> =
wrote:
>=20
> From: ZhangPeng <zhangpeng362@huawei.com>
>=20
> Syzbot reported a OOB Write bug:
>=20
> loop0: detected capacity change from 0 to 64
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KASAN: slab-out-of-bounds in hfs_asc2mac+0x467/0x9a0
> fs/hfs/trans.c:133
> Write of size 1 at addr ffff88801848314e by task syz-executor391/3632
>=20
> Call Trace:
> <TASK>
> __dump_stack lib/dump_stack.c:88 [inline]
> dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
> print_address_description+0x74/0x340 mm/kasan/report.c:284
> print_report+0x107/0x1f0 mm/kasan/report.c:395
> kasan_report+0xcd/0x100 mm/kasan/report.c:495
> hfs_asc2mac+0x467/0x9a0 fs/hfs/trans.c:133
> hfs_cat_build_key+0x92/0x170 fs/hfs/catalog.c:28
> hfs_lookup+0x1ab/0x2c0 fs/hfs/dir.c:31
> lookup_open fs/namei.c:3391 [inline]
> open_last_lookups fs/namei.c:3481 [inline]
> path_openat+0x10e6/0x2df0 fs/namei.c:3710
> do_filp_open+0x264/0x4f0 fs/namei.c:3740
>=20
> If in->len is much larger than HFS_NAMELEN(31) which is the maximum
> length of an HFS filename, a OOB Write could occur in hfs_asc2mac(). =
In
> that case, when the dst reaches the boundary, the srclen is still
> greater than 0, which causes a OOB Write.
> Fix this by adding a Check on dstlen before Writing to dst address.
>=20
> Fixes: 328b92278650 ("[PATCH] hfs: NLS support")
> Reported-by: syzbot+dc3b1cf9111ab5fe98e7@syzkaller.appspotmail.com
> Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
> ---
> fs/hfs/trans.c | 2 ++
> 1 file changed, 2 insertions(+)
>=20
> diff --git a/fs/hfs/trans.c b/fs/hfs/trans.c
> index 39f5e343bf4d..886158db07b3 100644
> --- a/fs/hfs/trans.c
> +++ b/fs/hfs/trans.c
> @@ -130,6 +130,8 @@ void hfs_asc2mac(struct super_block *sb, struct =
hfs_name *out, const struct qstr
> 				dst +=3D size;
> 				dstlen -=3D size;
> 			} else {
> +				if (dstlen =3D=3D 0)
> +					goto out;

Maybe, it makes sense to use dstlen instead of srclen in while()?

We have now:

while (srclen > 0) {
   <skipped>
} else {
   <skipped>
}

We can use instead:

while (dstlen > 0) {
   <skipped>
} else {
   <skipped>
}

Will it fix the issue?

Thanks,
Slava.


> 				*dst++ =3D ch > 0xff ? '?' : ch;
> 				dstlen--;
> 			}
> --=20
> 2.25.1
>=20

