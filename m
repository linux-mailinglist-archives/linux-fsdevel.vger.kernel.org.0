Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4ED2284FA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2019 19:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731256AbfEWRcd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 May 2019 13:32:33 -0400
Received: from mail-eopbgr40053.outbound.protection.outlook.com ([40.107.4.53]:9217
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731176AbfEWRcc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 May 2019 13:32:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZU5LBTrwCvNrvkm2YReQkzqZCYnCCl80NBAzedXHgg4=;
 b=iuld8F/niZvmi78ivdyLqtR5ok0lvOdsDscoHx+/AkY1ZErPPJc0kQnE0z0Tvnp+h2KYU7J9kJfu2RCrOh8IsuKeNocPa7v7ZVZxLCo0XGDJ+oUy9vQaY1iQ0Cobu6gLZgLeVzw33QMWU7El2kTPhN1Cr12OGaMj0kjG5l/G3l0=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB5376.eurprd05.prod.outlook.com (20.178.8.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.17; Thu, 23 May 2019 17:32:26 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::c16d:129:4a40:9ba1]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::c16d:129:4a40:9ba1%6]) with mapi id 15.20.1922.018; Thu, 23 May 2019
 17:32:26 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Ira Weiny <ira.weiny@intel.com>
CC:     "john.hubbard@gmail.com" <john.hubbard@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Doug Ledford <dledford@redhat.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Christian Benvenuti <benve@cisco.com>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 1/1] infiniband/mm: convert put_page() to put_user_page*()
Thread-Topic: [PATCH 1/1] infiniband/mm: convert put_page() to
 put_user_page*()
Thread-Index: AQHVETjmp9NWw1+o9kWPqEfRe8aqV6Z494gAgAAA+wA=
Date:   Thu, 23 May 2019 17:32:26 +0000
Message-ID: <20190523173222.GH12145@mellanox.com>
References: <20190523072537.31940-1-jhubbard@nvidia.com>
 <20190523072537.31940-2-jhubbard@nvidia.com>
 <20190523172852.GA27175@iweiny-DESK2.sc.intel.com>
In-Reply-To: <20190523172852.GA27175@iweiny-DESK2.sc.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MN2PR10CA0030.namprd10.prod.outlook.com
 (2603:10b6:208:120::43) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.49.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3c52dada-5175-404b-e3a3-08d6dfa49f7b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB5376;
x-ms-traffictypediagnostic: VI1PR05MB5376:
x-microsoft-antispam-prvs: <VI1PR05MB5376D5618C2E76DDE621E336CF010@VI1PR05MB5376.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-forefront-prvs: 00462943DE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(396003)(39860400002)(136003)(376002)(189003)(199004)(186003)(25786009)(486006)(73956011)(66946007)(36756003)(5660300002)(102836004)(4326008)(6512007)(86362001)(26005)(476003)(66066001)(446003)(11346002)(2616005)(71190400001)(71200400001)(1076003)(3846002)(6116002)(256004)(6436002)(54906003)(6916009)(6486002)(68736007)(33656002)(8676002)(81156014)(14454004)(386003)(8936002)(478600001)(7416002)(76176011)(6506007)(64756008)(66446008)(6246003)(305945005)(66556008)(81166006)(99286004)(52116002)(53936002)(316002)(66476007)(229853002)(7736002)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB5376;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: VvJkrk5B5LxbnQ2vrRxnSIUM6BFVbjJjPHyXveUIsGzjTNKZzI7CV2YqDdGD/0WoReRD/0A4sSqRIvvmUZBQ4Wa+avwJhId8QA3xo8MF8SV2lpNEPBPEtEm/8Ap/yuKlc/35ik9RdkyIduaTXYzyLYlrnIGGb91ZHG0qGv1kLLvoDmES+OVRrZIyPRaHRtsJP5iLykC71brlqgod3Dx7EdCwdJWqNNoR4CQOJZSTmWxDxa+N+xePj0sFnrTs3bijiEtuK7OYZOrZGTCUOqgIC51D/oFK76soL1VrlISWpO+KP7qZSy4iXvtB9plpccuGh0dlKaulECYCb2kU9Xo5nYF99aG74w7Iro4D0W34v0GhjF2kbsuJv/JTgpOLzc9NhLoYevAgZlYfTtQ7gatDjrmRLmZXKEnMUhzEq8KXcKM=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FACFD97BF1EB824FBEE5790F977C0B3C@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c52dada-5175-404b-e3a3-08d6dfa49f7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2019 17:32:26.5249
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5376
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 23, 2019 at 10:28:52AM -0700, Ira Weiny wrote:
> > =20
> > @@ -686,8 +686,8 @@ int ib_umem_odp_map_dma_pages(struct ib_umem_odp *u=
mem_odp, u64 user_virt,
> >  			 * ib_umem_odp_map_dma_single_page().
> >  			 */
> >  			if (npages - (j + 1) > 0)
> > -				release_pages(&local_page_list[j+1],
> > -					      npages - (j + 1));
> > +				put_user_pages(&local_page_list[j+1],
> > +					       npages - (j + 1));
>=20
> I don't know if we discussed this before but it looks like the use of
> release_pages() was not entirely correct (or at least not necessary) here=
.  So
> I think this is ok.

Oh? John switched it from a put_pages loop to release_pages() here:

commit 75a3e6a3c129cddcc683538d8702c6ef998ec589
Author: John Hubbard <jhubbard@nvidia.com>
Date:   Mon Mar 4 11:46:45 2019 -0800

    RDMA/umem: minor bug fix in error handling path
   =20
    1. Bug fix: fix an off by one error in the code that cleans up if it fa=
ils
       to dma-map a page, after having done a get_user_pages_remote() on a
       range of pages.
   =20
    2. Refinement: for that same cleanup code, release_pages() is better th=
an
       put_page() in a loop.
   =20

And now we are going to back something called put_pages() that
implements the same for loop the above removed?

Seems like we are going in circles?? John?

Jason
