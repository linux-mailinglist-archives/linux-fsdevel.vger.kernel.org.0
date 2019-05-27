Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 895092BC48
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2019 00:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbfE0W5C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 May 2019 18:57:02 -0400
Received: from mail-eopbgr30045.outbound.protection.outlook.com ([40.107.3.45]:30182
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726905AbfE0W5C (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 May 2019 18:57:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BT+LPOjOIRF2MwRWJndkjgGRnHAYGV3viHIVEC775a8=;
 b=iUX3JWptB2/XhBGh0dk8UoIm50sJUlXk6+NX5DQufBl05mHPK/+t7sT+hILe76TvC9z9ubg71jBGYkztPGXA3ou5WQy7qn1kV/t0ZJi5RKzJP8k9+HIy4FDCpaX5KyVBPkyFUOTTtX1l1CSpFBr/2fJBP1zhSaNRMyLBxpbIxFo=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB6509.eurprd05.prod.outlook.com (20.179.25.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.17; Mon, 27 May 2019 22:56:57 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::c16d:129:4a40:9ba1]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::c16d:129:4a40:9ba1%6]) with mapi id 15.20.1922.021; Mon, 27 May 2019
 22:56:57 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Matthew Wilcox <willy@infradead.org>
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
        Christian Benvenuti <benve@cisco.com>, Jan Kara <jack@suse.cz>,
        Ira Weiny <ira.weiny@intel.com>,
        =?iso-8859-1?Q?J=E9r=F4me_Glisse?= <jglisse@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2] infiniband/mm: convert put_page() to put_user_page*()
Thread-Topic: [PATCH v2] infiniband/mm: convert put_page() to put_user_page*()
Thread-Index: AQHVEpuNgBqUKNuE/kmNGLYDDVPIqqZ9QO6AgAJYy4A=
Date:   Mon, 27 May 2019 22:56:56 +0000
Message-ID: <20190527225651.GA18539@mellanox.com>
References: <20190525014522.8042-1-jhubbard@nvidia.com>
 <20190525014522.8042-2-jhubbard@nvidia.com>
 <20190526110631.GD1075@bombadil.infradead.org>
In-Reply-To: <20190526110631.GD1075@bombadil.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MN2PR07CA0008.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::18) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2ac44459-f21a-46ea-24b9-08d6e2f69e16
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR05MB6509;
x-ms-traffictypediagnostic: VI1PR05MB6509:
x-microsoft-antispam-prvs: <VI1PR05MB650973D76D85F77B18ED1691CF1D0@VI1PR05MB6509.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0050CEFE70
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(39860400002)(136003)(346002)(366004)(189003)(199004)(66946007)(73956011)(66556008)(64756008)(102836004)(66446008)(66476007)(76176011)(53936002)(71200400001)(71190400001)(1076003)(52116002)(305945005)(6246003)(6506007)(7736002)(386003)(5660300002)(26005)(33656002)(256004)(36756003)(54906003)(25786009)(6916009)(2906002)(3846002)(6486002)(229853002)(2616005)(476003)(6512007)(81166006)(8676002)(81156014)(86362001)(68736007)(486006)(6436002)(7416002)(8936002)(99286004)(4326008)(186003)(316002)(14454004)(66066001)(478600001)(11346002)(446003)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB6509;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: CHp7qe7UlSF0sDMVzi5V7/a878fMOpXRT3t8fd8HreZNVdNzRtytBd8D/zp/Ekk5Hf32Jqg9cAIt45u35Uap3iUWC9dKdlGp4qCXatwmomYHlNr7IP7Ixs9HgUgnmTsTyWHvK0G9WTInbA0yA5XYrfuo0oncU5AnS2jQv8btJtfDYvEpbdiXDDkhesxMZ1ZiUOx3C/FEElE0KTtgaZL2EhlNcbD/65Ef8XoPJ9uKSE9JjHwZWxSUM1mctD1sdImntvZsR8df85oTwLAI082Hl0rILkHZID4A0UWPs6CxdofF8JCuS7OduVPAHloEJp3O17ipCV+y/aLXdw2AnkoYzOJDQtnoppkWnjwtp+uW7lX35y/BBLSNGo3gJ9SdATd3Vz68e5OPT0SAwUPXM9pmoIvFmvQpPzQV42lhK3tOcms=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <5BC0AB5A2E48604C93A93DEB61B51614@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ac44459-f21a-46ea-24b9-08d6e2f69e16
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2019 22:56:56.9183
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6509
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 26, 2019 at 04:06:31AM -0700, Matthew Wilcox wrote:
> On Fri, May 24, 2019 at 06:45:22PM -0700, john.hubbard@gmail.com wrote:
> > For infiniband code that retains pages via get_user_pages*(),
> > release those pages via the new put_user_page(), or
> > put_user_pages*(), instead of put_page()
>=20
> I have no objection to this particular patch, but ...
>=20
> > This is a tiny part of the second step of fixing the problem described
> > in [1]. The steps are:
> >=20
> > 1) Provide put_user_page*() routines, intended to be used
> >    for releasing pages that were pinned via get_user_pages*().
> >=20
> > 2) Convert all of the call sites for get_user_pages*(), to
> >    invoke put_user_page*(), instead of put_page(). This involves dozens=
 of
> >    call sites, and will take some time.
> >=20
> > 3) After (2) is complete, use get_user_pages*() and put_user_page*() to
> >    implement tracking of these pages. This tracking will be separate fr=
om
> >    the existing struct page refcounting.
> >=20
> > 4) Use the tracking and identification of these pages, to implement
> >    special handling (especially in writeback paths) when the pages are
> >    backed by a filesystem. Again, [1] provides details as to why that i=
s
> >    desirable.
>=20
> I thought we agreed at LSFMM that the future is a new get_user_bvec()
> / put_user_bvec().  This is largely going to touch the same places as
> step 2 in your list above.  Is it worth doing step 2?

I think so, as these two conversions can run in parallel, whichever we
finish first, biovec or put_user_pages lets John progress to step #3

Jason
