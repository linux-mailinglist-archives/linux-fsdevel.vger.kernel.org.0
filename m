Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC7C51521B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Apr 2022 19:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379719AbiD2RbP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Apr 2022 13:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379700AbiD2Rau (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Apr 2022 13:30:50 -0400
Received: from mailout2.w2.samsung.com (mailout2.w2.samsung.com [211.189.100.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61FE4D64D1;
        Fri, 29 Apr 2022 10:27:14 -0700 (PDT)
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
        by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20220429172713usoutp02645adda6df5e5dd344de6f9eb3a4506a~qbhE6Gv4Q0403704037usoutp021;
        Fri, 29 Apr 2022 17:27:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20220429172713usoutp02645adda6df5e5dd344de6f9eb3a4506a~qbhE6Gv4Q0403704037usoutp021
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1651253233;
        bh=Fi2WQlQ+0mZFujneK3WIoLAN6h7B2z2e6gI7T3/FrUI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=Smuiu79gYUyRK7yyR2rr36OnCWYRZ+cjfbqMUJ8vfDicUh6yTiyU50am/U6r43+cj
         n87/Z7lZF0Qjr+gcHH76ynB5aiej9Qz/NoV5BGDbY3dBjmKOcMn9f8OdzFSHOc7S8e
         YJ6Z1x0+i2CozSHo18nuQwBWrlUPa/52ZHEfS5YI=
Received: from ussmges3new.samsung.com (u112.gpu85.samsung.co.kr
        [203.254.195.112]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220429172713uscas1p2d8cbaee723fac12a091c47f415ff47f3~qbhEhXC2I0887908879uscas1p2u;
        Fri, 29 Apr 2022 17:27:13 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
        ussmges3new.samsung.com (USCPEMTA) with SMTP id A1.6D.09749.1FF1C626; Fri,
        29 Apr 2022 13:27:13 -0400 (EDT)
Received: from ussmgxs2new.samsung.com (u91.gpu85.samsung.co.kr
        [203.254.195.91]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220429172712uscas1p2364e5c23f9df513deed5c6c522e9d6b1~qbhD_H7sP0887908879uscas1p2s;
        Fri, 29 Apr 2022 17:27:12 +0000 (GMT)
X-AuditID: cbfec370-a83ff70000002615-8b-626c1ff14c8b
Received: from SSI-EX3.ssi.samsung.com ( [105.128.2.146]) by
        ussmgxs2new.samsung.com (USCPEXMTA) with SMTP id D7.83.09672.0FF1C626; Fri,
        29 Apr 2022 13:27:12 -0400 (EDT)
Received: from SSI-EX3.ssi.samsung.com (105.128.2.228) by
        SSI-EX3.ssi.samsung.com (105.128.2.228) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.7; Fri, 29 Apr 2022 10:27:11 -0700
Received: from SSI-EX3.ssi.samsung.com ([105.128.5.228]) by
        SSI-EX3.ssi.samsung.com ([105.128.5.228]) with mapi id 15.01.2375.007; Fri,
        29 Apr 2022 10:27:11 -0700
From:   Adam Manzanares <a.manzanares@samsung.com>
To:     Pankaj Raghav <p.raghav@samsung.com>
CC:     "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "snitzer@kernel.org" <snitzer@kernel.org>,
        "hch@lst.de" <hch@lst.de>, "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "naohiro.aota@wdc.com" <naohiro.aota@wdc.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "clm@fb.com" <clm@fb.com>,
        "gost.dev@samsung.com" <gost.dev@samsung.com>,
        "chao@kernel.org" <chao@kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "jonathan.derrick@linux.dev" <jonathan.derrick@linux.dev>,
        "agk@redhat.com" <agk@redhat.com>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "kch@nvidia.com" <kch@nvidia.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "jiangbo.365@bytedance.com" <jiangbo.365@bytedance.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "matias.bjorling@wdc.com" <matias.bjorling@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 06/16] nvmet: use blk_queue_zone_no()
Thread-Topic: [PATCH 06/16] nvmet: use blk_queue_zone_no()
Thread-Index: AQHYWlBImLMJLgQoTkmYJjdfDQL7UK0HnXCA
Date:   Fri, 29 Apr 2022 17:27:11 +0000
Message-ID: <20220429172711.GC174938@bgt-140510-bm01>
In-Reply-To: <20220427160255.300418-7-p.raghav@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <38ADAEB8F5BE6745ACC883C41F5D725E@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUxbVRjGc+69vS1g3aUj4wDLmI0fk2mljGVHtoHo4q5TGcnikjmdFLmW
        z4Lt6th0CmGMUYaULWx6UVrQVBhsrHTRSVtEdHwMm5ry3Qw2AkwMUEDYCiJMyu0S/vu9532e
        8zw5OQJc1EwGC1IUxxmlQpYuJn2JH1sf2F+cDU1PDO9lSVR/uxVHtYMlJLo0s4ijzjIbhi6U
        fMVHSzY7jqyuch76cyEXQzW1tzA0Ws/i6HzzDIGWNUOrZ2eGcfTfsBRdaOkFaKyHxZDVuR05
        Rqr5yFG1H1msHQTqavyGRDrDGB9pzz7AUb92DKDSNhMPXZuYJlC7M+SVELqr+016pb2OpEvz
        XHzaPmQk6C6bmm64UkjSlTllOG36/gvarJ/DaPNADkkX57lI+uf8uzx6uqmHpOtv9BC01mTk
        0XMNW+L93/Xdk8Skp3zCKF+KTvBNts0O8bLmfbK/0z/CcoBOoAE+AkhFQk2uGdcAX4GIqgHQ
        cHaU51mIqHwMdrjfeiyyDjYRnOgqgBP3dF7HLIA/VHzpHQwAjl97SHosJBUOl9qMuIcDqG3w
        frcJ8zBOafzgYFmkhzdSL8OixcZVvWBVEwWn9DSHEVD/+5qToJ6BFa2ONaeQ2gkrrk4SHvah
        dsOugeK1JEBtgu7bdd7bA6FzVIdxpf1hVbkF53gTXGkcJjl+Ct51/83n9C9AvfkfkuNo2Ovq
        xjneDg2VEziX6w87vh4lOG8Q/LW6f+0hIGX0hc4itzdsHxwaqfSGhcDlQQPGiQoAnNE28bhB
        C+CdqUVvjd1wpbCXrwVPs+uas+tasetasetaseta6QHvCghUq1QZcka1Q8GckKhkGSq1Qi75
        MDOjAax+8s6V37JuAqdzVtICMAFoAVCAiwOE8+bkRJEwSXbyFKPM/ECpTmdULSBEQIgDhYaU
        6zIRJZcdZ9IYJotRPt5iAp/gHGxvWqi96nS89Dml9tDbsURsLDsQ91fMVkUb61cdhIvaZLLK
        0+5UC1lQ0x5DJOx57/0a17kjAaUFS53lm3mTVlYf5so40Jdw6qdzOcJ7KxVw7yWxunuz/B13
        3hNxc/yLRw8Khw/P7Kpbfv7Zz6buB40Umq6HHiX8mcxx6f5d0ptRWH6kX5vlzLxkZ0/f64fj
        ojYcU7gb5c5Eh1+R7o+D/75hOf/Ro7TWGzGfH7kcEd+ccGJLM+EIpz/NJosrEiNei264eCz1
        l6SChT510cOSmMnw1PG+AduGsG12P0nwkyMhjlr7yelbC/1bExROiTG6NDRzR2r2pJJ49dDH
        dzaymtyOb21iQpUsk4bhSpXsf7Ss+D1TBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHKsWRmVeSWpSXmKPExsWS2cA0SfeDfE6SwddX0hbrTx1jtlh9t5/N
        YtqHn8wWp6eeZbKY1D+D3eL32fPMFnvfzWa1uPCjkcli5eqjTBZP1s9itug58IHF4m/XPaBY
        y0Nmiz8PDS0mHbrGaPH06iwmi723tC0uPV7BbnFpkbvFnr0nWSwu75rDZjF/2VN2iwltX5kt
        bkx4ymgx8fhmVot1r9+zWJy4Je0g7XH5irfHvxNr2DwmNr9j9zh/byOLx+WzpR6bVnWyeSxs
        mMrssXlJvcfuBZ+ZPHbfbGDz6G1+x+axs/U+q8f7fVfZPNZvucriMWHzRlaPz5vkAgSjuGxS
        UnMyy1KL9O0SuDLOfrzHWvCFs2Lxgv9MDYzzOboYOTkkBEwk9t7dx9LFyMUhJLCaUeLVwj42
        COcjo0T31lWsEM4yRomjJ1vYQFrYBAwkfh/fyAxiiwhoSDy7spkJpIhZoINb4uvPJYwgCWEB
        S4nun7uAGjiAiqwk3i7wgDCNJBYcAWtlEVCVmHfsEhOIzStgKjFv7RuoK/YzStzpOQC2i1PA
        WuLyzV4wm1FATOL7qTVgDcwC4hK3nsxngnhBQGLJnvPMELaoxMvH/1ghbEWJ+99fskPU60gs
        2P2JDcK2k7j27gozhK0tsWzha2aIIwQlTs58wgLRKylxcMUNlgmMErOQrJuFZNQsJKNmIRk1
        C8moBYysqxjFS4uLc9Mrio3yUsv1ihNzi0vz0vWS83M3MQKT4Ol/h6N3MN6+9VHvECMTB+Mh
        RgkOZiUR3i+7M5KEeFMSK6tSi/Lji0pzUosPMUpzsCiJ876MmhgvJJCeWJKanZpakFoEk2Xi
        4JRqYLI1iLl7813Xrp8bvba3TPXdWX7PIehUzAJew58Lku136jnPr5/ey6NsrWKgezbSu2lF
        8fv6O8HJn0TWV4mu1XXylPktK3Hx8OFt+7SnP1q12Srvs57x8pUlDi7vxGWWPb3EZa7qyr4v
        9Oh8ubaDq320vewdpVQ8o5hYOb5NrT512flPaCXnDn1hJw0/cbfusltfv/BdfXB90ctfoUc8
        JQrZ1LakHM8MD+RjqJt1nfv4h4o7kkFnnFIvV4rkVj5W2rIq+KG1EvNDNnO50vbNy8x27V25
        4Z7AmXnzfKrml+YmT9Y5/Ez9F5fYjOW/eV6ub9Q7ukhgrZLXldZ9OV/+yj1ar/D3ui3fs0QV
        /qINt5RYijMSDbWYi4oTAXgIuhDxAwAA
X-CMS-MailID: 20220429172712uscas1p2364e5c23f9df513deed5c6c522e9d6b1
CMS-TYPE: 301P
X-CMS-RootMailID: 20220427160302eucas1p1aaba7a309778d3440c3315ad899e4035
References: <20220427160255.300418-1-p.raghav@samsung.com>
        <CGME20220427160302eucas1p1aaba7a309778d3440c3315ad899e4035@eucas1p1.samsung.com>
        <20220427160255.300418-7-p.raghav@samsung.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 27, 2022 at 06:02:45PM +0200, Pankaj Raghav wrote:
> From: Luis Chamberlain <mcgrof@kernel.org>
>=20
> Instead of open coding the number of zones given a sector, use the helper
> blk_queue_zone_no(). This let's us make modifications to the math if
> needed in one place and adds now support for npo2 zone devices.
>=20
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  drivers/nvme/target/zns.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
> index e34718b09550..e41b6a6ef048 100644
> --- a/drivers/nvme/target/zns.c
> +++ b/drivers/nvme/target/zns.c
> @@ -243,7 +243,7 @@ static unsigned long nvmet_req_nr_zones_from_slba(str=
uct nvmet_req *req)
>  	unsigned int sect =3D nvmet_lba_to_sect(req->ns, req->cmd->zmr.slba);
> =20
>  	return blkdev_nr_zones(req->ns->bdev->bd_disk) -
> -		(sect >> ilog2(bdev_zone_sectors(req->ns->bdev)));
> +	       bdev_zone_no(req->ns->bdev, sect);
>  }
> =20
>  static unsigned long get_nr_zones_from_buf(struct nvmet_req *req, u32 bu=
fsize)
> --=20
> 2.25.1
>


Looks good.

Reviewed by: Adam Manzanares <a.manzanares@samsung.com>=
