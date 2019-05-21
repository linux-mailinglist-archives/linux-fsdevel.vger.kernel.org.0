Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB407245D6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2019 04:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbfEUCGb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 May 2019 22:06:31 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:53426 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726533AbfEUCGa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 May 2019 22:06:30 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4L1xEL9026293;
        Mon, 20 May 2019 19:05:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=JufoTuKodLOP6cNvtUurbE0MDMs17aY9sLS5YnGw8dw=;
 b=VfHbP3eRnvj1wXJhvJA/w33AM9Y3vvPzH3ypX6ym2zJimfj9AgHBeYQsI0PBhGrVoMkJ
 eJ/C8AJt0tcPRFLGK6jVXDNyxK5IvFK97upJgbm6WU+SVtp6tU9rtS/8e0Qq8SAI73RI
 ecy8gpbOOrBTb2tbm39urcqRQBj4h7h8nDk= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2sm0ahsndm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 20 May 2019 19:05:42 -0700
Received: from prn-hub04.TheFacebook.com (2620:10d:c081:35::128) by
 prn-hub03.TheFacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 20 May 2019 19:05:41 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Mon, 20 May 2019 19:05:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JufoTuKodLOP6cNvtUurbE0MDMs17aY9sLS5YnGw8dw=;
 b=U9a69QI6d0UrpKYJED1rtLt/AIuBXwHvvdIY7oSWF04D9BZOybozSChPITtBulKEgJnU3s6UnJ2n5Ft/hp4qXaRfoETaJWcEgFlzVkSidSsEYHrjd2Sm5Uy7gN2bsZ2Rai7yOsnt8+ymIjRahgQGuadTCUthDv1St08b+fKKGfk=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.156.24) by
 BYAPR15MB3304.namprd15.prod.outlook.com (20.179.58.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.17; Tue, 21 May 2019 02:05:38 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::d4f6:b485:69ee:fd9a]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::d4f6:b485:69ee:fd9a%7]) with mapi id 15.20.1900.020; Tue, 21 May 2019
 02:05:38 +0000
From:   Roman Gushchin <guro@fb.com>
To:     "Tobin C. Harding" <me@tobin.cc>
CC:     "Tobin C. Harding" <tobin@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Alexander Viro" <viro@ftp.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Pekka Enberg" <penberg@cs.helsinki.fi>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Christopher Lameter <cl@linux.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Andreas Dilger <adilger@dilger.ca>,
        Waiman Long <longman@redhat.com>,
        Tycho Andersen <tycho@tycho.ws>,
        "Theodore Ts'o" <tytso@mit.edu>, Andi Kleen <ak@linux.intel.com>,
        David Chinner <david@fromorbit.com>,
        Nick Piggin <npiggin@gmail.com>,
        Rik van Riel <riel@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v5 16/16] dcache: Add CONFIG_DCACHE_SMO
Thread-Topic: [RFC PATCH v5 16/16] dcache: Add CONFIG_DCACHE_SMO
Thread-Index: AQHVDs7p5YZCYW51S0W/c+2xf0nte6Z0TWwAgAB+vACAAAmSgA==
Date:   Tue, 21 May 2019 02:05:38 +0000
Message-ID: <20190521020530.GA18287@tower.DHCP.thefacebook.com>
References: <20190520054017.32299-1-tobin@kernel.org>
 <20190520054017.32299-17-tobin@kernel.org>
 <20190521005740.GA9552@tower.DHCP.thefacebook.com>
 <20190521013118.GB25898@eros.localdomain>
In-Reply-To: <20190521013118.GB25898@eros.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR04CA0051.namprd04.prod.outlook.com
 (2603:10b6:300:6c::13) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:152::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::2:8d5a]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0730f6cc-3600-4ad1-e2a2-08d6dd90d155
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR15MB3304;
x-ms-traffictypediagnostic: BYAPR15MB3304:
x-microsoft-antispam-prvs: <BYAPR15MB3304176D412FC8039AD398A0BE070@BYAPR15MB3304.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0044C17179
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(39860400002)(366004)(136003)(199004)(189003)(446003)(33656002)(86362001)(4326008)(6246003)(8936002)(54906003)(5660300002)(8676002)(53936002)(6916009)(476003)(11346002)(81166006)(81156014)(14454004)(186003)(2906002)(46003)(25786009)(316002)(486006)(6116002)(9686003)(6512007)(6436002)(99286004)(73956011)(1076003)(102836004)(66946007)(71200400001)(71190400001)(52116002)(76176011)(386003)(6506007)(66476007)(64756008)(66446008)(7736002)(229853002)(68736007)(6486002)(7416002)(256004)(66556008)(305945005)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB3304;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: czXufusqJ0EjO7U4QtmV/sg52PG37cUGE105N3ZrhVVZkBMoLRh6oYzJit8/rae0Q1m3f1nx+mYjIZVUPzGfxcat6j4pbhR9fLgeegBXKfcGxK4hwopsvrlwSDmVcOtdrrN7PTL1Lf02jemZ2YpRsJq+Suiz8idsSaRDFz1fogUG14nQTAqrovLQbnKF5C+Qn5pBEdCPAW3usX5aSHvobkHfnibDDYgkk0EL0nWPW8IHJbG43NFrhWsqgGOi0DZa85gpf+nqRqdMO+ZD2PnOr9jeveEUdRpjxwVo/7aqDmXmzPGyFSgBiRNrFFOlHWvSh8lvcrvXhv8OPrUlcdB5FB3zOusp9rElXOkEGs2Ks7LVITP8SBhB7KLirX32wd0sWmZBDxRO/xcpe2iu/vSevyo3lNE08tHqjphbzvxEXhs=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3186B1609B811D4389B9037DA091B469@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0730f6cc-3600-4ad1-e2a2-08d6dd90d155
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2019 02:05:38.0377
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3304
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-20_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 21, 2019 at 11:31:18AM +1000, Tobin C. Harding wrote:
> On Tue, May 21, 2019 at 12:57:47AM +0000, Roman Gushchin wrote:
> > On Mon, May 20, 2019 at 03:40:17PM +1000, Tobin C. Harding wrote:
> > > In an attempt to make the SMO patchset as non-invasive as possible ad=
d a
> > > config option CONFIG_DCACHE_SMO (under "Memory Management options") f=
or
> > > enabling SMO for the DCACHE.  Whithout this option dcache constructor=
 is
> > > used but no other code is built in, with this option enabled slab
> > > mobility is enabled and the isolate/migrate functions are built in.
> > >=20
> > > Add CONFIG_DCACHE_SMO to guard the partial shrinking of the dcache vi=
a
> > > Slab Movable Objects infrastructure.
> >=20
> > Hm, isn't it better to make it a static branch? Or basically anything
> > that allows switching on the fly?
>=20
> If that is wanted, turning SMO on and off per cache, we can probably do
> this in the SMO code in SLUB.

Not necessarily per cache, but without recompiling the kernel.
>=20
> > It seems that the cost of just building it in shouldn't be that high.
> > And the question if the defragmentation worth the trouble is so much
> > easier to answer if it's possible to turn it on and off without rebooti=
ng.
>=20
> If the question is 'is defragmentation worth the trouble for the
> dcache', I'm not sure having SMO turned off helps answer that question.
> If one doesn't shrink the dentry cache there should be very little
> overhead in having SMO enabled.  So if one wants to explore this
> question then they can turn on the config option.  Please correct me if
> I'm wrong.

The problem with a config option is that it's hard to switch over.

So just to test your changes in production a new kernel should be built,
tested and rolled out to a representative set of machines (which can be
measured in thousands of machines). Then if results are questionable,
it should be rolled back.

What you're actually guarding is the kmem_cache_setup_mobility() call,
which can be perfectly avoided using a boot option, for example. Turning
it on and off completely dynamic isn't that hard too.

Of course, it's up to you, it's just probably easier to find new users
of a new feature, when it's easy to test it.

Thanks!
