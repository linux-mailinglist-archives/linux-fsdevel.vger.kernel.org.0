Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2A694A781C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Feb 2022 19:40:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344390AbiBBSkt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Feb 2022 13:40:49 -0500
Received: from mail-mw2nam10on2081.outbound.protection.outlook.com ([40.107.94.81]:46016
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229678AbiBBSks (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Feb 2022 13:40:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xgp1d7rkYoHDgoKX5C9dqCVBRrbLYzlexmNzydYfcZxBdUZwsEE8KBfkQK6wnFLTlPi1xArErrWvNGFDbaWTAfvLZIqTiyHfdR/IHVMN0HNKIzA3zsPzoJIcUpGQRfaqK1t7iVN7OzmLhdO5e2/uGAFJG+VpkiIGT+yN6Du+TmzhypG90ashi3WrBy4pfJJrEGHiHQDerg/8uQDmhpM6yYencYslSm5kMkQ6GVaGSFOKp4wycJHIM8LmVhFVfowzzwDr0TmVtV7Zbvb5AE+ONqNt5V7kaaZmSR4v/pOv3mQemNUtBWmj0UvFW2psCYK2rMdhjhVY9rO/9NEGd4FEWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=abfgycCOsfBvkqBH9AnYvjUIc46IXF9WaPR/NPG0Hd4=;
 b=c/mIfLrOERTcd9L4Rc/ZmH/JoAUpmytBgvJwOzfkvL/GRFWYGkxCJOVzesuhTCzCvcIxcXdo9vPjLWGJRF3/8nIu3wk9y9tzTizRB5gVO/jKWSiTDZwwCQwEPfNSTS38dW2wbZ2CgK0WWo4ChtUtjEBEFTGtTh4Qxi2/pJKaLP2L6lj/i7hIueEw2Ye9DAd4Z0H2Nhdb3CIxT6AGtCVC+Mm+2nkGpNbVznsoR7owEJIc/xrtbuYew+ljxyt6W3er6nji/yWL4hpifYyfDtWWW3nIHiGF2rLF0o1wh67UHxHIsoiO+/czvgG4w0p8XQSJHZjuig8c6OaJt7C/snz0Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netapp.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=abfgycCOsfBvkqBH9AnYvjUIc46IXF9WaPR/NPG0Hd4=;
 b=uvrYwzj+hHHQizar4AYdWgCmd64dQpe7rSvKAfqS0pOGZ9sMM0eccIKzTmTWagRqxERFyaF0slHQALF4gHl6P+4i6NPuF22b2ssCQecD8olvneBDY1RtaVZBgAD2ztf0rMAYWVjJxAUhVGnGmL/s0eHrQZsxr2wJnf5pU5SAChnyXh7KEO9gIzJhXEfyvhZ2A/JcOujUHCp1uE0wXL01B6CpvW5OxqvKNt4aJJAHolDqy9zrA9dm0GO8q9Bc0oU4XUVdH8uzN7z+kKJ8T6+yB3TtWVapoorQ7/69mWL8TLrnJ7mMOLi1Ox0naFCo5+h9M9KLGvMZhPI/ar+tCp87mA==
Received: from DM8PR06MB7704.namprd06.prod.outlook.com (2603:10b6:8:32::16) by
 BN7PR06MB5235.namprd06.prod.outlook.com (2603:10b6:408:35::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4951.11; Wed, 2 Feb 2022 18:40:46 +0000
Received: from DM8PR06MB7704.namprd06.prod.outlook.com
 ([fe80::e5f8:848a:a023:2543]) by DM8PR06MB7704.namprd06.prod.outlook.com
 ([fe80::e5f8:848a:a023:2543%6]) with mapi id 15.20.4951.012; Wed, 2 Feb 2022
 18:40:46 +0000
From:   "Knight, Frederick" <Frederick.Knight@netapp.com>
To:     Keith Busch <kbusch@kernel.org>,
        Mikulas Patocka <mpatocka@redhat.com>
CC:     =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier@javigon.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "msnitzer@redhat.com >> msnitzer@redhat.com" <msnitzer@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "martin.petersen@oracle.com >> Martin K. Petersen" 
        <martin.petersen@oracle.com>,
        "roland@purestorage.com" <roland@purestorage.com>,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
        "zach.brown@ni.com" <zach.brown@ni.com>,
        "osandov@fb.com" <osandov@fb.com>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "clm@fb.com" <clm@fb.com>, "dsterba@suse.com" <dsterba@suse.com>,
        "tytso@mit.edu" <tytso@mit.edu>, "jack@suse.com" <jack@suse.com>,
        Kanchan Joshi <joshi.k@samsung.com>
Subject: RE: [RFC PATCH 1/3] block: add copy offload support
Thread-Topic: [RFC PATCH 1/3] block: add copy offload support
Thread-Index: AQHYF5ofJ+2cppXZJ0yy6uP6Lh6TA6yAcr6AgAAgXiA=
Date:   Wed, 2 Feb 2022 18:40:46 +0000
Message-ID: <DM8PR06MB770496AC8B09C430B835BC4FF1279@DM8PR06MB7704.namprd06.prod.outlook.com>
References: <f0e19ae4-b37a-e9a3-2be7-a5afb334a5c3@nvidia.com>
 <20220201102122.4okwj2gipjbvuyux@mpHalley-2>
 <alpine.LRH.2.02.2202011327350.22481@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2202011331570.22481@file01.intranet.prod.int.rdu2.redhat.com>
 <20220202162147.GC3077632@dhcp-10-100-145-180.wdc.com>
In-Reply-To: <20220202162147.GC3077632@dhcp-10-100-145-180.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.6.300.5
dlp-product: dlpe-windows
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=netapp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 303ec8dd-f5bc-40e7-7149-08d9e67b86bf
x-ms-traffictypediagnostic: BN7PR06MB5235:EE_
x-microsoft-antispam-prvs: <BN7PR06MB523595A16A86B8DE985AE269F1279@BN7PR06MB5235.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: irYwoV6gP3LNwqkaJIrcDDyi6lW7v6X1e875NeOWGxOT6kmM5kmJnAC015oprGlEQmstqRnvvSfiy5OpMfRMaegszGa9TYkY7WUWJYjM0s3SF+ebOictOR8AMh+S/BBeUBXND8+tr5pllQogv+eRZ8k1rM89wGbZNrz21BVXI0dQpnPkmdypf+Gr97Y6QJnfvzLM7eycBBmeHqptgdOhu5IyFb781amUVAjTVSrCuEK1dUhqaUnfkrXTdMA+Yfh0TnC5qOo2hf4xsi3ZAKmwIuRAbUgBPH7COHBtAckiEVhhU7ecuiLHYZYbz6q4YSwbzxP7HoJTGJSGdrnckT2jFy14ywmGR2nX5SPCx7sRD7ypdmskK0HY0hFbQv+XlWYxjCMF+WvYxYdE/KTtkZ5eTEnkTxa2DzZ1mbfmHalAyJnE7foP7wulNxsJQbiRXEmG5VqfQKSvfLYo9jtPYy9jJkVKloTk6TuMns0vD13KcskNQJm/QSqgtxJWPwFS0SYB7tHEW6Y90q7EtmJAHE3CWDsqtrq9az0hoHT4pPuZH0qaxCl0TnJNwkle2EjbkngBzdeHev+TrhJ6ndlc3Mu1lr8xVPgI7dyirFBLcdMGRaFNTwHeM/Gs6ERU0BBdstRg9q4s3+T834MiOL9joMQYDa8HirhPE/wgJ/27xkBYKLzscHgsIw+Xk+rn3ZFMZ311IjVFdpaVEPZa8a9rzK8X6Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR06MB7704.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(7416002)(122000001)(316002)(508600001)(2906002)(54906003)(52536014)(186003)(110136005)(86362001)(71200400001)(66946007)(66476007)(8676002)(66574015)(83380400001)(55016003)(38100700002)(4326008)(76116006)(38070700005)(66556008)(6506007)(64756008)(7696005)(66446008)(33656002)(53546011)(9686003)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?RMvynNVNP6XofsQG4rUnyHoLhqvwBZcAE5SWO1yFePXdVp9itcltYinoN/?=
 =?iso-8859-1?Q?6v8D7fS1ndAR1Xb1GUvPPKTtCI0KLYFq9ba2DqRk07bDw8dpoFc4sJf0Gf?=
 =?iso-8859-1?Q?pZQDEuNzOl50kDiPfevwSF9KJ67TeZj/0TRfKySByrnOIPbFtRTzrK40r0?=
 =?iso-8859-1?Q?hZ0EMxIBW9U3f8wZx9S7GP4ZGy9VWBNeY16xP2j5bMVuwNOV8kQ+veJNxN?=
 =?iso-8859-1?Q?w/Ze7dQ1+dKpCYJf9E8WWumtr1hdUvBEnqDi7UElSDJdg+tjgSQPsp+nDX?=
 =?iso-8859-1?Q?z+jHIx9Fj7JeXHAkUvDy/3AgGl5eN4ttGtcybSG+YrpcrdWBZZlAm2AIoC?=
 =?iso-8859-1?Q?gYsQ/y37VPG/tYWAtltlINJwTTPKue6Onpi3ZcXCVO0zs/6Rx64jSt3vo5?=
 =?iso-8859-1?Q?jdi3vkz0g4DjnvyE2qh1YLSkbAbJ/y9RIhWy/B8iEs+BtJmJ2xVlTYraXC?=
 =?iso-8859-1?Q?gJTXuA9n4aRFfW7ScbbBz02SoL/DBF/smQsEAM5sALEPaxqpN3EyspoMbO?=
 =?iso-8859-1?Q?wYxayexnxljNKVelG+sxIu3w7gEFV3TibHJQzrZE1ptKbwGVtwBqwRJsWb?=
 =?iso-8859-1?Q?lYeUSWkyrsLU1CAhknk6RvkboNbvTxNS3XBHWyKqv1DZVoc4Xnx+CQEGHY?=
 =?iso-8859-1?Q?Du5eu5GhjLeV7+bxvcVUnhOPWZUZB7A1ht6Hzq+fRlFmlw79MfgUIdG+tS?=
 =?iso-8859-1?Q?83N+kdACKd6DFsHHmhLOR6vqIN9HvFAz8gEoqBGd+lB0rYRqDfv/gfGCwM?=
 =?iso-8859-1?Q?j7Z8WikF7wbzUnW9g8ZWy/Qsmdz5L5k76XEarZsvVKEX6HVipbn9j7sk03?=
 =?iso-8859-1?Q?Azgkh6vANIjz0ezwGX9QA6VK/o9nr+n8WmOldDoE00SaanILpEVgG96k7N?=
 =?iso-8859-1?Q?kPVBjuj/c9ItxtLszWgPNIGPX7mwzbKURNVj7Isu3kMj4HkTufg1cAAfbb?=
 =?iso-8859-1?Q?Bp9h27OBEuCQp4oLftv4VMbXmqJBQvI7gENtRMo28QZKVRue5bpaO4uB/I?=
 =?iso-8859-1?Q?yRRAdSNp2qaz6mWWw5blaI6AmfTlgW/LVjDSluaI2CbaZE3A4ILa0qXnQ/?=
 =?iso-8859-1?Q?BB85m6jWu9INP+svqtXNVujDvEz7hjtMzOk6vx8Q8fg8Fjub6sXSVp3N3B?=
 =?iso-8859-1?Q?dnWYbbHd9ZEkBtjsj89qT5DVe/kSl8VIYLQeNWYVB7kVjO/X7sVVeOUVo+?=
 =?iso-8859-1?Q?BmIfpR1d0DdFE1xECkPfg2MtHlgwHxKxeFx8ODdpXNmvtflaeo9fYIBZqu?=
 =?iso-8859-1?Q?Nr/LF4RU9qMMa0uB9jXt61FAc8wRT9eLOZEd3bo+LYM5U+x0Pkc9qFzc2s?=
 =?iso-8859-1?Q?xjNAtxYxugoRk3Sxpf+hdF1UtC4IcokZPxvYU4FDiJ9pqrFkR+0KNRuC6m?=
 =?iso-8859-1?Q?Qi/X9aCBpSlVYftu0e+16SlOQ2DR1+FN1AyhC8PX5vWAcIHpdno+PM7QfD?=
 =?iso-8859-1?Q?RbXC+e8Ur7xw1lO/68d4gLnp0+K06bz7J6alGt17hyTBIKHHErGvpHT1C7?=
 =?iso-8859-1?Q?VFJL9lQ64JmVCF5FzH17Fo29NAOHw+NUJtNYu/C//YrYoRjvGTRD7xgJdG?=
 =?iso-8859-1?Q?9aZcWbVpuO1f4hqjLdXqSZDBLbQoHmFAsownJoD9m1WWtQNXWhOp4+ItU4?=
 =?iso-8859-1?Q?4m2fKxVJcvaX+TwayhFZcSiAK4LaqhePMk9QTI3NSujEbQKnJNeGZP9AMo?=
 =?iso-8859-1?Q?0Nc005zwCKXsQPxCBgXn128x3IExGFvYQxOdZRmz0eZCGlNWVv+efFTDsf?=
 =?iso-8859-1?Q?YAu1nl9+81K5XbXrloXufbYEc=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR06MB7704.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 303ec8dd-f5bc-40e7-7149-08d9e67b86bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2022 18:40:46.4757
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8YTRg9SYdHq4zEXMw6/v1CvAus1dZVz9OmUBu8d+hm4YSdzoiXvOz4mECpcHGEfdqXMdYIHXkQo0Ouf1fphHPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR06MB5235
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Just FYI about copy domains.

SCSI already has copy domains defined (it is optional in the standard).  Th=
ird-party Copy Descriptor - Copy Group Identifier. Here's the SCSI text:

A Copy Group is a set of logical units that have a high probability of usin=
g high performance methods (e.g.,
copy on write snapshot) for third-party copy operations involving logical u=
nits that are in the same Copy
Group. Each logical unit may be a member of zero or one Copy Group. A logic=
al unit indicates membership in
a Copy Group using the Copy Group Identifier third-party copy descriptor (s=
ee 7.7.18.13).

If a third-party copy operation involves logical units that are in differen=
t Copy Groups, then that third-party copy
operation has a high probability of using low performance methods (e.g., co=
py manager read operations from
the source CSCD or copy manager write operations to the destination CSCD).

NVMe today can only copy between LBAs on the SAME Namespace.  There is a ne=
w project just getting started to allow copy across namespaces in the same =
NVM subsystem (included as part of that project is to define how the copy d=
omains will work).  So for NVMe, copy domains are still a work in progress.

Just FYI.

	Fred

-----Original Message-----
From: Keith Busch <kbusch@kernel.org>=20
Sent: Wednesday, February 2, 2022 11:22 AM
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Javier Gonz=E1lez <javier@javigon.com>; Chaitanya Kulkarni <chaitanyak@=
nvidia.com>; linux-block@vger.kernel.org; linux-scsi@vger.kernel.org; dm-de=
vel@redhat.com; linux-nvme@lists.infradead.org; linux-fsdevel <linux-fsdeve=
l@vger.kernel.org>; Jens Axboe <axboe@kernel.dk>; msnitzer@redhat.com >> ms=
nitzer@redhat.com <msnitzer@redhat.com>; Bart Van Assche <bvanassche@acm.or=
g>; martin.petersen@oracle.com >> Martin K. Petersen <martin.petersen@oracl=
e.com>; roland@purestorage.com; Hannes Reinecke <hare@suse.de>; Christoph H=
ellwig <hch@lst.de>; Knight, Frederick <Frederick.Knight@netapp.com>; zach.=
brown@ni.com; osandov@fb.com; lsf-pc@lists.linux-foundation.org; djwong@ker=
nel.org; josef@toxicpanda.com; clm@fb.com; dsterba@suse.com; tytso@mit.edu;=
 jack@suse.com; Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [RFC PATCH 1/3] block: add copy offload support

NetApp Security WARNING: This is an external email. Do not click links or o=
pen attachments unless you recognize the sender and know the content is saf=
e.




On Tue, Feb 01, 2022 at 01:32:29PM -0500, Mikulas Patocka wrote:
> +int blkdev_issue_copy(struct block_device *bdev1, sector_t sector1,
> +                   struct block_device *bdev2, sector_t sector2,
> +                   sector_t nr_sects, sector_t *copied, gfp_t=20
> +gfp_mask) {
> +     struct page *token;
> +     sector_t m;
> +     int r =3D 0;
> +     struct completion comp;
> +
> +     *copied =3D 0;
> +
> +     m =3D min(bdev_max_copy_sectors(bdev1), bdev_max_copy_sectors(bdev2=
));
> +     if (!m)
> +             return -EOPNOTSUPP;
> +     m =3D min(m, (sector_t)round_down(UINT_MAX, PAGE_SIZE) >> 9);
> +
> +     if (unlikely(bdev_read_only(bdev2)))
> +             return -EPERM;
> +
> +     token =3D alloc_page(gfp_mask);
> +     if (unlikely(!token))
> +             return -ENOMEM;
> +
> +     while (nr_sects) {
> +             struct bio *read_bio, *write_bio;
> +             sector_t this_step =3D min(nr_sects, m);
> +
> +             read_bio =3D bio_alloc(gfp_mask, 1);
> +             if (unlikely(!read_bio)) {
> +                     r =3D -ENOMEM;
> +                     break;
> +             }
> +             bio_set_op_attrs(read_bio, REQ_OP_COPY_READ_TOKEN, REQ_NOME=
RGE);
> +             bio_set_dev(read_bio, bdev1);
> +             __bio_add_page(read_bio, token, PAGE_SIZE, 0);

You have this "token" payload as driver specific data, but there's no check=
 that bdev1 and bdev2 subscribe to the same driver specific format.

I thought we discussed defining something like a "copy domain" that establi=
shes which block devices can offload copy operations to/from each other, an=
d that should be checked before proceeding with the copy operation.
