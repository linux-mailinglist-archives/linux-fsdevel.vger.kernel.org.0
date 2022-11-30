Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9403563E0B1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Nov 2022 20:24:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbiK3TYY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Nov 2022 14:24:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbiK3TYD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Nov 2022 14:24:03 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B575755CB6
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Nov 2022 11:24:02 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id b126so5329865oif.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Nov 2022 11:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20210112.gappssmtp.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+wo+rpyosrQ5mo9ZKXiEdshfV8pblh1Ox95hEXjzopc=;
        b=lN5NZq66xcfgJmWvkkoUluI350bdxZR00+FKoZxMShq9efk+8Ito/DmHVUAqiIZSj/
         HLC5ZS3q8yiIl6OMYtzoomsmFwxjrbaYBHRambc5r56FFvdEvwmVL22/c89sELLl7Wsv
         dr8jdIMx2/ogKPh0XRRh+VnQwgcBU8+5sSLa4EevsSBWM13Us0E0pyloCjrTAFVx1SOO
         PnL5OqbegXw5uerTa2r93gI7++ZPnIoahH+NJnzmhXo3rFgNzEvFiAHA2PC2OU8d/yn0
         2enDE7G8oj+M8KXNxMRTk5w0UqWrHT5jIqpAGNlKjiww0N9TSA2GYrW8QRgGY7YB6n0+
         KCDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+wo+rpyosrQ5mo9ZKXiEdshfV8pblh1Ox95hEXjzopc=;
        b=kb0kHrCTdt5pp+5T8L5bu46SvkJOeAWV7hZAtlACob43lAlwL64qlzrQpIsWHVDnZr
         y9HRJhDa/lHRXOZVEIhkHq40vb0MSUmZtbAvLVr578porfv74BwQ52Vt2DXvDIWm37uR
         fBvS5h08cdhKPflhcAukcKOgGWM2dsZAm2ADgULagteZiHaPDOjen+tjmSZFSPSmipZU
         w4nm7R10AJ015pX/sHps9bHUCH1oyiSfo6devh3AQ8n311w0ruC5RHDL9DjlicRWVJ9l
         +xwuASieE1qGK8QM9cK0mJioFZByVp5DjLlLYXx2KZ6EcAXsGMfVNr/XrASe/G7HkjPx
         v9ig==
X-Gm-Message-State: ANoB5pn8jJcwxuQigl9P8OoHcL4XL8lL2MvZGTJwed656RJSjCV9Wu1c
        g3riBnQT+d2o7fMI2FE/OWSAeRBv+ii1JyPJRxY=
X-Google-Smtp-Source: AA0mqf758Pu+ja29ReuXlHGUpRKc/XuI+oOE7XGxbaP8x37MIQDpqzC4Mn9T29U26LQ54g7cXZLuTg==
X-Received: by 2002:a05:6808:10d6:b0:354:9397:4cc4 with SMTP id s22-20020a05680810d600b0035493974cc4mr21155160ois.147.1669836241968;
        Wed, 30 Nov 2022 11:24:01 -0800 (PST)
Received: from smtpclient.apple (172-125-78-211.lightspeed.sntcca.sbcglobal.net. [172.125.78.211])
        by smtp.gmail.com with ESMTPSA id c39-20020a9d27aa000000b00661b019accbsm1283915otb.3.2022.11.30.11.23.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Nov 2022 11:24:00 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH] hfs: Fix OOB Read in __hfs_brec_find
From:   Viacheslav Dubeyko <slava@dubeyko.com>
In-Reply-To: <20221130065959.2168236-1-zhangpeng362@huawei.com>
Date:   Wed, 30 Nov 2022 11:23:56 -0800
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, sunnanyong@huawei.com,
        wangkefeng.wang@huawei.com,
        syzbot+e836ff7133ac02be825f@syzkaller.appspotmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <AF1D5323-061B-4B7E-83E4-90BF1275DB30@dubeyko.com>
References: <20221130065959.2168236-1-zhangpeng362@huawei.com>
To:     Peng Zhang <zhangpeng362@huawei.com>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Nov 29, 2022, at 10:59 PM, Peng Zhang <zhangpeng362@huawei.com> =
wrote:
>=20
> From: ZhangPeng <zhangpeng362@huawei.com>
>=20
> Syzbot reported a OOB read bug:
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KASAN: slab-out-of-bounds in hfs_strcmp+0x117/0x190
> fs/hfs/string.c:84
> Read of size 1 at addr ffff88807eb62c4e by task kworker/u4:1/11
> CPU: 1 PID: 11 Comm: kworker/u4:1 Not tainted
> 6.1.0-rc6-syzkaller-00308-g644e9524388a #0
> Workqueue: writeback wb_workfn (flush-7:0)
> Call Trace:
> <TASK>
> __dump_stack lib/dump_stack.c:88 [inline]
> dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
> print_address_description+0x74/0x340 mm/kasan/report.c:284
> print_report+0x107/0x1f0 mm/kasan/report.c:395
> kasan_report+0xcd/0x100 mm/kasan/report.c:495
> hfs_strcmp+0x117/0x190 fs/hfs/string.c:84
> __hfs_brec_find+0x213/0x5c0 fs/hfs/bfind.c:75
> hfs_brec_find+0x276/0x520 fs/hfs/bfind.c:138
> hfs_write_inode+0x34c/0xb40 fs/hfs/inode.c:462
> write_inode fs/fs-writeback.c:1440 [inline]
>=20
> If the input inode of hfs_write_inode() is incorrect:
> struct inode
>  struct hfs_inode_info
>    struct hfs_cat_key
>      struct hfs_name
>        u8 len # len is greater than HFS_NAMELEN(31) which is the
> maximum length of an HFS filename
>=20
> OOB read occurred:
> hfs_write_inode()
>  hfs_brec_find()
>    __hfs_brec_find()
>      hfs_cat_keycmp()
>        hfs_strcmp() # OOB read occurred due to len is too large
>=20
> Fix this by adding a Check on len in hfs_write_inode() before calling
> hfs_brec_find().
>=20
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: syzbot+e836ff7133ac02be825f@syzkaller.appspotmail.com
> Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
> ---
> fs/hfs/inode.c | 2 ++
> 1 file changed, 2 insertions(+)
>=20
> diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
> index c4526f16355d..a0746be3c1de 100644
> --- a/fs/hfs/inode.c
> +++ b/fs/hfs/inode.c
> @@ -458,6 +458,8 @@ int hfs_write_inode(struct inode *inode, struct =
writeback_control *wbc)
> 		/* panic? */
> 		return -EIO;
>=20
> +	if (HFS_I(main_inode)->cat_key.CName.len > HFS_NAMELEN)
> +		return -EIO;

If I understood correctly, we have corrupted struct hfs_cat_key =
instance. But what is the initial place
of this corruption? What function could introduce such corruption? =
Maybe, it needs to find a place(s)
where we can add some additional check and potentially exclude the =
incorrect input into
hfs_write_inode()?

I think it is not only place where it makes sense to check the =
correctness of struct hfs_cat_key
instance. Could we introduce a special function that check struct =
hfs_cat_key on corrupted
state and to use this function to check the state of the key in =
functions that operates by
keys?

Thanks,
Slava.=20

> 	fd.search_key->cat =3D HFS_I(main_inode)->cat_key;
> 	if (hfs_brec_find(&fd))
> 		/* panic? */
> --=20
> 2.25.1
>=20

