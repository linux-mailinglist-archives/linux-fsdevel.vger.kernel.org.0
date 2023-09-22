Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C22F17AAEE8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Sep 2023 11:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232916AbjIVJ5E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Sep 2023 05:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232783AbjIVJ5C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Sep 2023 05:57:02 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C002BF7
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Sep 2023 02:56:54 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230922095652epoutp01b3f65856461b4ffeedc7735fbc44f0af~HMAvkeq_m2519025190epoutp01Z
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Sep 2023 09:56:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230922095652epoutp01b3f65856461b4ffeedc7735fbc44f0af~HMAvkeq_m2519025190epoutp01Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1695376612;
        bh=5/1Y9VHgQcIm/DWs+esTLg8S98dJn/n15a06NGRtzIs=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=KEg27cHbP9ZTBQ5zf7iPeZCpWpUq/LuQQFKj8S32zw8mR70hChpYMmgSqZnPMThvR
         mEUDWs71TqJnaDJyiyN61RjlLvgZm2l73AXEzap6l76xjaAejr6khhCSjyZaubtb9Y
         t2SnJ80VpMwKcj1nP729eGdeqeOGia9KkoNenWxI=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20230922095651epcas2p371b9f8536ade2eb286cce8ce27fba03b~HMAu4pkhP2974629746epcas2p3s;
        Fri, 22 Sep 2023 09:56:51 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.102]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4RsSNM094nz4x9Pr; Fri, 22 Sep
        2023 09:56:51 +0000 (GMT)
X-AuditID: b6c32a45-84fff700000025dd-4b-650d64e25f49
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        55.37.09693.2E46D056; Fri, 22 Sep 2023 18:56:50 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH v16 03/12] block: add copy offload support
Reply-To: j-young.choi@samsung.com
Sender: Jinyoung Choi <j-young.choi@samsung.com>
From:   Jinyoung Choi <j-young.choi@samsung.com>
To:     Nitesh Jagadeesh Shetty <nj.shetty@samsung.com>,
        Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
CC:     "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "nitheshshetty@gmail.com" <nitheshshetty@gmail.com>,
        "anuj1072538@gmail.com" <anuj1072538@gmail.com>,
        SSDR Gost Dev <gost.dev@samsung.com>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        Hannes Reinecke <hare@suse.de>,
        Anuj Gupta <anuj20.g@samsung.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20230920080756.11919-4-nj.shetty@samsung.com>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230922095650epcms2p8e25340eff5de01f8b3ce63ae81266881@epcms2p8>
Date:   Fri, 22 Sep 2023 18:56:50 +0900
X-CMS-MailID: 20230922095650epcms2p8e25340eff5de01f8b3ce63ae81266881
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA22Ta0xTZxjHc3ra00IsORQcr7Bs5DgRMJS2ofAil5gJy4lzGYrJLsR0R3pW
        GNA2PcUpLhHYrNCNy6iTURgXYTDAISBjlQJhxVGBOcIIOiAS3Wg2QSgXiSgBR2mZ+7Bvv/fJ
        //k/lzcPDxXoub68VKWW1iipdAJzZ3f2B4WH/CHn0yJrF4TXhgZQuLS6zoa5xRsobL5XhMG5
        /mUEzvRdROBDSxDsWSjnwIm+GyzYfaWEBRubf2bBEssdBNrGjSzYM3kA1ujq2LC7Z5ANx7oq
        MFhVb+PCz++aMNhg3WTB34ttCDTN5CCwc70KhS1zdja8NekHRzasnEO+5A3jPS45Mt3GJsdu
        Z5LtTfkYeb3uPGmeyMbI2kIDhyz4dAEjl2yTbNLeO46RhR1NCHl9+By50v4K2T4zz0rweD8t
        OoWm5LTGn1Ymq+SpSkUM8Wai7LBMGi4Sh4gjYQThr6Qy6Bgi7mhCyBup6VvLIPxPU+mZW6EE
        imGI0NhojSpTS/unqBhtDEGr5enqCLWQoTKYTKVCqKS1B8UikUS6JfwgLaWodI6rno47o88b
        5WQjta/rETcewMPAYncrV4+48wS4CQG5hfcRPcLj8XFPsGHycqAXHgsqqw475AKcAL9eNSIO
        9sJF4LMpHdvBGC4Epr/M2zbe+DAKTM8fII4HivdwQPWGne0sxgdfX7S52A/82PDDtpMbHgXW
        Sq2oMx4I1uoLXLwbTDTPc3fYPlCFONkbXJi+7dJ4gvtPza74HmCxrGKOpgGuAq19x5zhT4Du
        md0lDwV38tq2W+Djb4Gcsufb9mx8H2h7tOKyiQNfNZdgDkbxA6C+Zg51WKJ4ELjWFep03wtu
        TrKdCg+Q17/B3Rkwu239f9lUOcNypgaAK7mSYmSv8cWajf8pZXxRqhpBm5CXaDWToaAZiVr8
        788mqzLake2jCI43IYb5RaEFYfEQCwJ4KOHNT152pwV8OXU2i9aoZJrMdJqxINKtIb9EfXcn
        q7auSqmVicMiRWHh4eIIiVQUQfjwpy98IxfgCkpLp9G0mtbs5LF4br7ZrEZjUfWg9SOiu8zc
        /Lc0UByQu0/22qODQvukuXGso8YeLD9ESQQFDZLCvE2wyGHOTYU84L2dOOT3pzw+VtA7eCtm
        UGmdX+Lm363dP3K2zDx7LPvmkRVdwBf5c1cvH/fzpIKwZ2ZlFH3peKUpcXgpqSZrWRPwTgeV
        lfPx0ae9JwMfDi1UDIeM5H7Poipap46cXPuuL3YxavXDYVXOmXKV3vBY8W18S+ryu/sFv5mD
        LKuEz2inrPGxTjkbV81rGmd8PPimU+LRutU9vF3mYtv5n05Flr682VLenTb7HjepbJd03LLi
        mdD7pF14ukpxIskw0NQVHWiY/0WXZXhyQrX46mWCzaRQ4mBUw1D/AFH2eOKdBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230920081447epcas5p144e631c5b8c72acf64d38b04d6c2c925
References: <20230920080756.11919-4-nj.shetty@samsung.com>
        <20230920080756.11919-1-nj.shetty@samsung.com>
        <CGME20230920081447epcas5p144e631c5b8c72acf64d38b04d6c2c925@epcms2p8>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> +/*
> + * This must only be called once all bios have been issued so that the r=
efcount
> + * can only decrease. This just waits for all bios to complete.
> + * Returns the length of bytes copied or error
> + */
> +static ssize_t blkdev_copy_wait_io_completion(struct blkdev_copy_io *cio=
)

Hi, Nitesh,

don't functions waiting for completion usually set their names to 'wait_for=
_completion_'?
(e.g. blkdev_copy_wait_for_completion_io)


> +ssize_t blkdev_copy_offload(struct block_device *bdev, loff_t pos_in,
> +=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20loff_t=20pos_out,=20s=
ize_t=20len,=0D=0A>=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
void=20(*endio)(void=20*,=20int,=20ssize_t),=0D=0A>=20+=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20void=20*private,=20gfp_t=20gfp)=0D=0A>=20+=
=7B=0D=0A>=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20struct=20blkdev_copy_io=
=20*cio;=0D=0A>=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20struct=20blkdev_copy=
_offload_io=20*offload_io;=0D=0A>=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20st=
ruct=20bio=20*src_bio,=20*dst_bio;=0D=0A>=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20ssize_t=20rem,=20chunk,=20ret;=0D=0A>=20+=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20ssize_t=20max_copy_bytes=20=3D=20bdev_max_copy_sectors(bdev)=20<<=
=20SECTOR_SHIFT;=0D=0A=0D=0Awouldn't=20it=20be=20better=20to=20use=20size_t=
=20for=20variables=20that=20don't=20return?=0D=0Avalues=20such=20as=20chunk=
=20and=20max_copy_bytes=20may=20be=20defined=20as=20'unsigned'.=0D=0A=0D=0A=
>=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20struct=20blk_plug=20plug;=0D=0A>=
=20+=0D=0A>=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20if=20(=21max_copy_bytes)=
=0D=0A>=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20return=20-EOPNOTSUPP;=0D=0A>=20+=0D=0A>=20+=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20ret=20=3D=20blkdev_copy_sanity_check(bdev,=20pos_in,=20bdev,=
=20pos_out,=20len);=0D=0A>=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20if=20(ret=
)=0D=0A>=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20return=20ret;=0D=0A>=20+=0D=0A>=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20cio=20=3D=20kzalloc(sizeof(*cio),=20GFP_KERNEL);=0D=0A>=20+=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20if=20(=21cio)=0D=0A>=20+=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20return=20-ENOMEM;=0D=0A>=20=
+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20atomic_set(&cio->refcount,=201);=0D=0A=
>=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20cio->waiter=20=3D=20current;=0D=0A=
>=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20cio->endio=20=3D=20endio;=0D=0A>=
=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20cio->private=20=3D=20private;=0D=0A=
>=20+=0D=0A>=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20/*=0D=0A>=20+=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0*=20If=20there=20is=20a=20error,=20copied=
=20will=20be=20set=20to=20least=20successfully=0D=0A>=20+=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0*=20completed=20copied=20length=0D=0A>=20+=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0*/=0D=0A>=20+=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20cio->copied=20=3D=20len;=0D=0A>=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20for=20(rem=20=3D=20len;=20rem=20>=200;=20rem=20-=3D=20chunk)=20=7B=0D=
=0A>=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20chunk=20=3D=20min(rem,=20max_copy_bytes);=0D=0A>=20+=0D=0A>=20+=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20offload_i=
o=20=3D=20kzalloc(sizeof(*offload_io),=20GFP_KERNEL);=0D=0A>=20+=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20if=20(=21off=
load_io)=0D=0A>=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20goto=20err_free_cio;=
=0D=0A>=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20offload_io->cio=20=3D=20cio;=0D=0A>=20+=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20/*=0D=0A>=20+=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0*=20For=20pa=
rtial=20completion,=20we=20use=20offload_io->offset=20to=20truncate=0D=0A>=
=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0*=20successful=20copy=20length=0D=0A>=20+=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0*/=0D=0A>=20+=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20offload_i=
o->offset=20=3D=20len=20-=20rem;=0D=0A>=20+=0D=0A>=20+=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20src_bio=20=3D=20bio_allo=
c(bdev,=200,=20REQ_OP_COPY_SRC,=20gfp);=0D=0A>=20+=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20if=20(=21src_bio)=0D=0A>=20=
+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20goto=20err_free_offload_io;=0D=0A>=20+=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20src=
_bio->bi_iter.bi_size=20=3D=20chunk;=0D=0A>=20+=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20src_bio->bi_iter.bi_sector=20=
=3D=20pos_in=20>>=20SECTOR_SHIFT;=0D=0A>=20+=0D=0A>=20+=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20blk_start_plug(&plug)=
;=0D=0A>=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20dst_bio=20=3D=20blk_next_bio(src_bio,=20bdev,=200,=20REQ_OP_COPY_D=
ST,=20gfp);=0D=0A>=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20if=20(=21dst_bio)=0D=0A>=20+=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20goto=20err_free_src_bio;=0D=0A>=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20dst_bio->bi_iter.bi_size=20=3D=20=
chunk;=0D=0A>=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20dst_bio->bi_iter.bi_sector=20=3D=20pos_out=20>>=20SECTOR_SHI=
FT;=0D=0A>=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20dst_bio->bi_end_io=20=3D=20blkdev_copy_offload_dst_endio;=0D=0A=
>=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20dst_bio->bi_private=20=3D=20offload_io;=0D=0A>=20+=0D=0A>=20+=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20atomic_inc(&=
cio->refcount);=0D=0A>=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20submit_bio(dst_bio);=0D=0A>=20+=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20blk_finish_plug(&plug=
);=0D=0A>=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20pos_in=20+=3D=20chunk;=0D=0A>=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20pos_out=20+=3D=20chunk;=0D=0A>=20=
+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=7D=0D=0A>=20+=0D=0A>=20+=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20if=20(atomic_dec_and_test(&cio->refcount))=0D=0A>=
=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20blkdev_copy_endio(cio);=0D=0A>=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20if=
=20(cio->endio)=0D=0A=0D=0AIsn't=20it=20a=20problem=20if=20the=20memory=20o=
f=20cio=20is=20released=20in=20blkdev_copy_endio()?=0D=0AIt=20is=20unlikely=
=20to=20occur=20if=20there=20is=20an=20inflight=20i/o=20earlier,=0D=0Ait=20=
would=20be=20nice=20to=20modify=20considering=20code=20flow.=0D=0A=0D=0A=0D=
=0A>=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20return=20-EIOCBQUEUED;=0D=0A>=20+=0D=0A>=20+=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20return=20blkdev_copy_wait_io_completion(cio);=0D=0A>=20+=0D=0A>=
=20+err_free_src_bio:=0D=0A>=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20bio_put=
(src_bio);=0D=0A>=20+err_free_offload_io:=0D=0A>=20+=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20kfree(offload_io);=0D=0A>=20+err_free_cio:=0D=0A>=20+=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20cio->copied=20=3D=20min_t(ssize_t,=20cio->cop=
ied,=20(len=20-=20rem));=0D=0A>=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20cio-=
>status=20=3D=20-ENOMEM;=0D=0A>=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20if=
=20(rem=20=3D=3D=20len)=20=7B=0D=0A>=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20kfree(cio);=0D=0A>=20+=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20return=20cio->s=
tatus;=0D=0A=0D=0Aisn't=20it=20a=20problem=20if=20the=20memory=20of=20cio=
=20is=20released?=0D=0A=0D=0ABest=20Regards,=0D=0AJinyoung.=0D=0A=0D=0A
