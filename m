Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8FC2E221
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2019 18:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbfE2QSm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 May 2019 12:18:42 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:43778 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726311AbfE2QSl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 May 2019 12:18:41 -0400
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4TG9CJi016734;
        Wed, 29 May 2019 09:16:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=pxUj1Jyj75v1FjBOqD0MZx0EI0nECYAry7BAEpEWZK8=;
 b=EVkOK3sJ3h2qxvgCx39hZFlhG5UK9JrFM60QP5E6KB8vg13KFRv60ssowFOoVj3m3iCC
 uzbgmJ/0ifOSx2gVYNFwm44sDbMnXtgZc5REXexJVeszdCgelFap8BddgoDs/SQhBzQO
 ZOo+4GBRIFCDmGvTKkiinhvhr/yUvBksMjg= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2ssv0erby9-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 29 May 2019 09:16:57 -0700
Received: from prn-hub04.TheFacebook.com (2620:10d:c081:35::128) by
 prn-hub04.TheFacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 29 May 2019 09:16:55 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Wed, 29 May 2019 09:16:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pxUj1Jyj75v1FjBOqD0MZx0EI0nECYAry7BAEpEWZK8=;
 b=axe9229Jo+ZJfag8PtMWDLnJh1KQn691QZvN7vHShV2B4ZjLrW4SgPzZuzneexGRr8M6UMkbpUrxjbhgXbqwN18t6ICAEPJH/Kp3W9sHjxWlROjYSaKmDQYc4XFXAuAnKuRCB66Guxgy35EAAQ77FAZ7CYMkhklirbnLuKKfZK8=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.156.24) by
 BYAPR15MB3144.namprd15.prod.outlook.com (20.178.239.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.20; Wed, 29 May 2019 16:16:51 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::d4f6:b485:69ee:fd9a]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::d4f6:b485:69ee:fd9a%7]) with mapi id 15.20.1922.021; Wed, 29 May 2019
 16:16:51 +0000
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
Thread-Index: AQHVDs7p5YZCYW51S0W/c+2xf0nte6Z0TWwAgAB+vAD//5Q4AIANJlUAgADPfwA=
Date:   Wed, 29 May 2019 16:16:51 +0000
Message-ID: <20190529161644.GA3228@tower.DHCP.thefacebook.com>
References: <20190520054017.32299-1-tobin@kernel.org>
 <20190520054017.32299-17-tobin@kernel.org>
 <20190521005740.GA9552@tower.DHCP.thefacebook.com>
 <20190521013118.GB25898@eros.localdomain>
 <20190521020530.GA18287@tower.DHCP.thefacebook.com>
 <20190529035406.GA23181@eros.localdomain>
In-Reply-To: <20190529035406.GA23181@eros.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR20CA0021.namprd20.prod.outlook.com
 (2603:10b6:300:13d::31) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:152::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::3:d07b]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 78798630-3dc5-4ed0-5125-08d6e4510e99
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR15MB3144;
x-ms-traffictypediagnostic: BYAPR15MB3144:
x-microsoft-antispam-prvs: <BYAPR15MB3144FCA92C6C076E79145BC3BE1F0@BYAPR15MB3144.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0052308DC6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(366004)(396003)(346002)(376002)(189003)(199004)(6506007)(8676002)(386003)(6512007)(9686003)(316002)(6486002)(64756008)(66946007)(68736007)(71200400001)(71190400001)(54906003)(66446008)(66556008)(66476007)(8936002)(76176011)(81166006)(6246003)(81156014)(73956011)(102836004)(52116002)(478600001)(229853002)(486006)(46003)(476003)(446003)(1076003)(4326008)(7736002)(2906002)(6436002)(11346002)(99286004)(25786009)(14454004)(33656002)(6916009)(86362001)(14444005)(256004)(186003)(5660300002)(6116002)(53936002)(7416002)(305945005);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB3144;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FXJEBL0FTk9aevgfkYXWcSFuOVdj8Q+dPpm0d6crp06NQe7R/YKIXnf581GesQely3FfKXvP17BMBuvBMQsKbB9ylIf3Dunn6C46XhPW0E6KkN1sQNGZZ+NkBe2NaIrnpuJPTDG/d4jo5mGGwiTB4pPm3mYHh2ehtUFf7xHP2isx5bs5raN1rxS/TWKtq3iLopYDYrnxuPPv3l7U+mzlwkPdNHq6SiNvFB17sGx7p1zHm/bdprua7ZuQxftAeuJutesHLHhKKus5GUDnQew5CMHLCsYcT3g/m00cG4VJYMAJx1wAiiSFRKukre1GzWI/nwiu5FjYLCn/Ybcx55mO3W/XOb29p4s1wVYec6Npvd+kGcdZSvbEY6MDfe2G9Kro2OC8pTzfGgU7f59FuOTFwFyvFOPDxHAAWW/cvwo7Z+M=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <99AB40E49837D447922689DB467C403F@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 78798630-3dc5-4ed0-5125-08d6e4510e99
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2019 16:16:51.3833
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: guro@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3144
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-29_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905290106
X-FB-Internal: deliver
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 29, 2019 at 01:54:06PM +1000, Tobin C. Harding wrote:
> On Tue, May 21, 2019 at 02:05:38AM +0000, Roman Gushchin wrote:
> > On Tue, May 21, 2019 at 11:31:18AM +1000, Tobin C. Harding wrote:
> > > On Tue, May 21, 2019 at 12:57:47AM +0000, Roman Gushchin wrote:
> > > > On Mon, May 20, 2019 at 03:40:17PM +1000, Tobin C. Harding wrote:
> > > > > In an attempt to make the SMO patchset as non-invasive as possibl=
e add a
> > > > > config option CONFIG_DCACHE_SMO (under "Memory Management options=
") for
> > > > > enabling SMO for the DCACHE.  Whithout this option dcache constru=
ctor is
> > > > > used but no other code is built in, with this option enabled slab
> > > > > mobility is enabled and the isolate/migrate functions are built i=
n.
> > > > >=20
> > > > > Add CONFIG_DCACHE_SMO to guard the partial shrinking of the dcach=
e via
> > > > > Slab Movable Objects infrastructure.
> > > >=20
> > > > Hm, isn't it better to make it a static branch? Or basically anythi=
ng
> > > > that allows switching on the fly?
> > >=20
> > > If that is wanted, turning SMO on and off per cache, we can probably =
do
> > > this in the SMO code in SLUB.
> >=20
> > Not necessarily per cache, but without recompiling the kernel.
> > >=20
> > > > It seems that the cost of just building it in shouldn't be that hig=
h.
> > > > And the question if the defragmentation worth the trouble is so muc=
h
> > > > easier to answer if it's possible to turn it on and off without reb=
ooting.
> > >=20
> > > If the question is 'is defragmentation worth the trouble for the
> > > dcache', I'm not sure having SMO turned off helps answer that questio=
n.
> > > If one doesn't shrink the dentry cache there should be very little
> > > overhead in having SMO enabled.  So if one wants to explore this
> > > question then they can turn on the config option.  Please correct me =
if
> > > I'm wrong.
> >=20
> > The problem with a config option is that it's hard to switch over.
> >=20
> > So just to test your changes in production a new kernel should be built=
,
> > tested and rolled out to a representative set of machines (which can be
> > measured in thousands of machines). Then if results are questionable,
> > it should be rolled back.
> >=20
> > What you're actually guarding is the kmem_cache_setup_mobility() call,
> > which can be perfectly avoided using a boot option, for example. Turnin=
g
> > it on and off completely dynamic isn't that hard too.
>=20
> Hi Roman,
>=20
> I've added a boot parameter to SLUB so that admins can enable/disable
> SMO at boot time system wide.  Then for each object that implements SMO
> (currently XArray and dcache) I've also added a boot parameter to
> enable/disable SMO for that cache specifically (these depend on SMO
> being enabled system wide).
>=20
> All three boot parameters default to 'off', I've added a config option
> to default each to 'on'.
>=20
> I've got a little more testing to do on another part of the set then the
> PATCH version is coming at you :)
>=20
> This is more a courtesy email than a request for comment, but please
> feel free to shout if you don't like the method outlined above.
>=20
> Fully dynamic config is not currently possible because currently the SMO
> implementation does not support disabling mobility for a cache once it
> is turned on, a bit of extra logic would need to be added and some state
> stored - I'm not sure it warrants it ATM but that can be easily added
> later if wanted.  Maybe Christoph will give his opinion on this.

Perfect!

Thanks.
