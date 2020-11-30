Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5BA2C886E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Nov 2020 16:43:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbgK3Pmn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Nov 2020 10:42:43 -0500
Received: from mail-mw2nam12on2110.outbound.protection.outlook.com ([40.107.244.110]:61551
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725933AbgK3Pmm (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Nov 2020 10:42:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aarb+l0RwuAbPnYfbVHSY8+TFvcGE6SxQxEnOfYNs//09FI/2DSWlwZDGEbOqn5gADiyjZvnTvEfJfk/+t71UCaUekw+iXtTo0dihbSxBywbnLo+AJaQoxtyzLhcJVYudtbzb++2y+ATd8HH1F9uL7HI/QxwL3tw1GkT+fivJPNWFoMJ+F1mkO/3NUtmlX+uSDNnKKy/JxagzuhUBv+9LuZlSqqb76eXwthCv3+F/1IJgN/9G4kkQTvTJ/72E1zxWheGDcBDlZgikbetNwzHSjoCnEpRkAAfTD2x2eHe4wpPT4vwvihRXUXqLc9QYPZ3dPF4VjcXaPRxZo5HxsGHgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=25W4fMBm0hzoUX7gc5SmyhbttOQtYDRr/QogN8ouHN0=;
 b=but5jKAv7rDTv3qdJoLgwqxxbMh7DiPL11dzCXgsGszxIfpHnS/oJoicXZlUkaPlf8eemc3MtVx1+gN5hzV9tg39X1zrVSeHP7iPttXRHcoM8nnF4guBwQCfUx/tClHJi6ULOTfWQ1PFIFLF9ZfQWB4LFqNnXtutg0GphKiuTgFdNEEHz5ooZdxH104cfSI3N3CIhEdRKLmM/KgLyFnVyyg8HmqZs5PF7+9UBXt3le271UbJHGEAMgNuhaXyhtgwYM/Bm1xZAaDfFezUgX9lJWmypTP0jXans+4jlaVMF8o1DkypoWWkHyqldRJ+lQ6LoLDuUz0kiNeCK9dsCbwSkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=purdue.edu; dmarc=pass action=none header.from=purdue.edu;
 dkim=pass header.d=purdue.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=purdue0.onmicrosoft.com; s=selector2-purdue0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=25W4fMBm0hzoUX7gc5SmyhbttOQtYDRr/QogN8ouHN0=;
 b=jzQesixO1pZv1vB2vegAwZ6Rj2L+bvWWdieweYczHSx3fPKzBLFVHOjNu8yA5IJfrFDZ8PFheq5QgnYVm9qC3J/6TsQ2K4WUWQzyg5VnBQGHruMtB2xHUUQuuKS1Gbd1KcDziBWDrFsaBd1/upru+PzCSJfsSyB1JkKqxGfez14=
Received: from CH2PR22MB2056.namprd22.prod.outlook.com (2603:10b6:610:5d::11)
 by CH2PR22MB1944.namprd22.prod.outlook.com (2603:10b6:610:5e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.25; Mon, 30 Nov
 2020 15:41:53 +0000
Received: from CH2PR22MB2056.namprd22.prod.outlook.com
 ([fe80::1922:c660:f2f4:50fa]) by CH2PR22MB2056.namprd22.prod.outlook.com
 ([fe80::1922:c660:f2f4:50fa%7]) with mapi id 15.20.3611.031; Mon, 30 Nov 2020
 15:41:53 +0000
From:   "Gong, Sishuai" <sishuai@purdue.edu>
To:     "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: [Race] data race between do_mpage_readpage() and set_blocksize()
Thread-Topic: [Race] data race between do_mpage_readpage() and set_blocksize()
Thread-Index: AQHWxy9TVWzVp8+MGUWofSg11Z+ldg==
Date:   Mon, 30 Nov 2020 15:41:53 +0000
Message-ID: <A57702D8-5E3E-401B-8010-C86901DD5D61@purdue.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: zeniv.linux.org.uk; dkim=none (message not signed)
 header.d=none;zeniv.linux.org.uk; dmarc=none action=none
 header.from=purdue.edu;
x-originating-ip: [66.253.158.157]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 218cdbc5-1024-46f0-3dcb-08d895467656
x-ms-traffictypediagnostic: CH2PR22MB1944:
x-microsoft-antispam-prvs: <CH2PR22MB1944419F08A66FC66C19022DDFF50@CH2PR22MB1944.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ELL0Oggp6aQ1Kp3E+t/2vNufQSz6NeST6swZUbfu6/pTpFPk6KVG8jJG2+x9+NhCc1MCzFDtW6aUcSyKE1/GDcrlk5rUmxhHQeeyxUPZPCTurOi3ABUXWC0MdRyZzO9FHr480Dguq+MQhiG+fkFR8fq+B8LBG+wGRwaaMIwDXou2RyI5CFkGvata71MQ8xkjlpVqqDLUudV2ujbG2PdQ7/Sf3UByOxclp4lmkXT/maVQhNgGOHKnucaXYZNxhZJDRy05UlSLsVcGJwYJDFUY2XrZaVeRvqi2sNPpedOAA08fcRvPNqWJKq+If/VJq6R16JjlBk7+Qa5K6sq7wHZqug==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR22MB2056.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(136003)(396003)(39860400002)(346002)(2906002)(8936002)(36756003)(66946007)(75432002)(71200400001)(86362001)(76116006)(64756008)(66556008)(66476007)(786003)(33656002)(66446008)(316002)(6916009)(2616005)(6486002)(5660300002)(6512007)(4326008)(8676002)(83380400001)(186003)(6506007)(26005)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?baYrr6tbcDBa6ReSHRnPXsWS8sCLtf3yt2il+oFspkhX6/Ka5zZQYcNw3rMb?=
 =?us-ascii?Q?xCFpFG8C2MJw5ggYFbyl6bGybg7e2le15+NA4lg/SgRrMwbwOodGK03NtOly?=
 =?us-ascii?Q?gNLGv3NMwm6WHO//h/07dMzKNsiWmHqNpe2sdrHd98vlOoQf8hog2HnEexrA?=
 =?us-ascii?Q?uDkIo0VfW9GrLcgyMcb3FwoeDuld7DyXrTsS/iCKD9YQLlC2Zazsmm/ey034?=
 =?us-ascii?Q?lv8xa9Y5SgPRv9U2zVguGV2yJeQqUgqOu5x5eNpSmgQFKN2y7j62S+ZzDZ/Q?=
 =?us-ascii?Q?JQesjdjRoDX27VEYc86hvIzKdEW9EDfxSBIRCOgk1VbbyUNuQRgzqBqa8A1L?=
 =?us-ascii?Q?8RG0UAAnHf1alOLdeb1PaZM0nDGh/8tTX0eiaDqeHwDAbBk31vbIxlHq0n3V?=
 =?us-ascii?Q?m9DGGIVh57+RZ/TMGQUqONas9El1rapSBlFRzdyjNfeYeI4JAZVQcYe2uTXQ?=
 =?us-ascii?Q?kCuifwOZr0fi7tR3vu6Zgino+B70aayaJEr3KVsTe3GIXtamoMWEsSBBhk5P?=
 =?us-ascii?Q?T1afKVqOce2ACS++bE0nb8Afgmflz7lRxUgziQpdHRqHLW9/2EWTDosksjii?=
 =?us-ascii?Q?6KddMYdcULw9OqZNX0c3OfOO/RzPhdVfuAB4sHaubf0GfCoc0zfSMGPDrkOp?=
 =?us-ascii?Q?XNsJRJ6IXS2YEHwkVv3PxBeyvxF8r2ueXwbgtBxg76us4BEtNkPcU65d4r8L?=
 =?us-ascii?Q?WiOJeCwPSNlRth5jydOQFPlTcWKl+G94bC/e3ZM+dZuo31iGLoT0euK98YMC?=
 =?us-ascii?Q?EsF3HYGFMi2AXitiVS51LTSNt6TCAeJrlVZn3efvWHlFmYLjad/pDzS559qc?=
 =?us-ascii?Q?ofrbqHYYLYLhAS9HcPrkzWjSBvpRMefm+5BSxz7hVWoo9Xr0qLDyi1GMwTBx?=
 =?us-ascii?Q?gt25mJmJp0gYPGH6zOzOMqoJhwKcZce2++6QMyQjs4eqUoKulgQJVVXvPYk7?=
 =?us-ascii?Q?QyMcwG78fMcFQ04MCoJDY89tTNgqLZSjvnadvndeJuBzaCCyX2FfW5m501BP?=
 =?us-ascii?Q?fPDt?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1C798881F9CE734BBED71B5C1B27EB7F@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: purdue.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR22MB2056.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 218cdbc5-1024-46f0-3dcb-08d895467656
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2020 15:41:53.7831
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4130bd39-7c53-419c-b1e5-8758d6d63f21
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1P/yWgkWiBFJIp01qYDugBk+v8RF0AilCdYywEN4DMrGx18T1NNJx8MPZxtPHQjjlftuBPj5vviLveXCtbhgEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR22MB1944
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Hi,

We found a data race in linux kernel 5.3.11 that we are able to reproduce i=
n x86 under specific interleavings. Currently, we are not sure about the co=
nsequence of this race so we would like to confirm with the community if th=
is can be a harmful bug.

------------------------------------------
Writer site

/tmp/tmp.B7zb7od2zE-5.3.11/extract/linux-5.3.11/fs/block_dev.c:135
        120
        121  int set_blocksize(struct block_device *bdev, int size)
        122  {
        123      /* Size must be a power of two, and between 512 and PAGE_S=
IZE */
        124      if (size > PAGE_SIZE || size < 512 || !is_power_of_2(size)=
)
        125          return -EINVAL;
        126
        127      /* Size cannot be smaller than the size supported by the d=
evice */
        128      if (size < bdev_logical_block_size(bdev))
        129          return -EINVAL;
        130
        131      /* Don't change the size if it is same as current */
        132      if (bdev->bd_block_size !=3D size) {
        133          sync_blockdev(bdev);
        134          bdev->bd_block_size =3D size;
 =3D=3D>    135          bdev->bd_inode->i_blkbits =3D blksize_bits(size);
        136          kill_bdev(bdev);
        137      }
        138      return 0;
        139  }

------------------------------------------
Reader site

 /tmp/tmp.B7zb7od2zE-5.3.11/extract/linux-5.3.11/fs/mpage.c:160
        147  /*
        148   * This is the worker routine which does all the work of mappi=
ng the disk
        149   * blocks and constructs largest possible bios, submits them f=
or IO if the
        150   * blocks are not contiguous on the disk.
        151   *
        152   * We pass a buffer_head back and forth and use its buffer_map=
ped() flag to
        153   * represent the validity of its disk mapping and to decide wh=
en to do the next
        154   * get_block() call.
        155   */
        156  static struct bio *do_mpage_readpage(struct mpage_readpage_arg=
s *args)
        157  {
        158      struct page *page =3D args->page;
        159      struct inode *inode =3D page->mapping->host;
 =3D=3D>    160      const unsigned blkbits =3D inode->i_blkbits;
        161      const unsigned blocks_per_page =3D PAGE_SIZE >> blkbits;
        162      const unsigned blocksize =3D 1 << blkbits;
        163      struct buffer_head *map_bh =3D &args->map_bh;
        164      sector_t block_in_file;
        165      sector_t last_block;
        166      sector_t last_block_in_file;
        167      sector_t blocks[MAX_BUF_PER_PAGE];
        168      unsigned page_block;
        169      unsigned first_hole =3D blocks_per_page;
        170      struct block_device *bdev =3D NULL;
        171      int length;
        172      int fully_mapped =3D 1;
        173      int op_flags;
        174      unsigned nblocks;
        175      unsigned relative_block;
        176      gfp_t gfp;
        177
        178      if (args->is_readahead) {
        179          op_flags =3D REQ_RAHEAD;
        180          gfp =3D readahead_gfp_mask(page->mapping);


------------------------------------------
Writer calling trace

- ksys_mount
-- do_mount
--- vfs_get_tree
---- mount_bdev
----- sb_min_blocksize
------ sb_set_blocksize
------- set_blocksize

------------------------------------------
Reader calling trace

- ksys_read
-- vfs_read
--- __vfs_read
---- generic_file_read_iter
----- page_cache_sync_readahead
------ force_page_cache_readahead
------- __do_page_cache_readahead
-------- read_pages
--------- mpage_readpages
---------- do_mpage_readpage



Thanks,
Sishuai

