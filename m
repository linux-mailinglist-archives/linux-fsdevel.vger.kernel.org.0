Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3777339EB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2019 23:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbfFCVku (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jun 2019 17:40:50 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:43974 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726055AbfFCUgt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jun 2019 16:36:49 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x53KWr9j017740;
        Mon, 3 Jun 2019 13:35:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=OPssNFO3i/ZLXoO3dC2MAgO7WatPCHbc6KOMcUalcgA=;
 b=EIZBOWJ7b5/slK/o33CeUjKoDDpRa47+snbohmnXBuso4nQ4NOT6l4Vgsd9GWeLAjWmG
 RpyZojv2G8AgBQexjYCIZDqoob5fF92kNiKDp/cOzH8VmcYULzPbUv4piI9JqBn0c5fl
 k4mFihtQhdvtigzfjrHFQNTBWeEYb1F4Xq4= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2sw5y0938e-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 03 Jun 2019 13:35:23 -0700
Received: from prn-mbx06.TheFacebook.com (2620:10d:c081:6::20) by
 prn-hub06.TheFacebook.com (2620:10d:c081:35::130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 3 Jun 2019 13:35:02 -0700
Received: from prn-hub06.TheFacebook.com (2620:10d:c081:35::130) by
 prn-mbx06.TheFacebook.com (2620:10d:c081:6::20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 3 Jun 2019 13:35:01 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Mon, 3 Jun 2019 13:35:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OPssNFO3i/ZLXoO3dC2MAgO7WatPCHbc6KOMcUalcgA=;
 b=dtxeqp8qG9KvYUgS4ED7inlnnfX9pJKif9b6oLkv0Jiv+eMJJ4OX0uf0BveRvjGO67+sFA4nV4U2KdENbCSY1gIk3G+H0y+YfGkerRnaIEWxB5YYtyQ9fIfPUkeCid8ZRPj72VTxwa8uvkMnKL5TpDdNhSotZUwZJ151D6i/Mu8=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.156.24) by
 BYAPR15MB2472.namprd15.prod.outlook.com (52.135.200.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.18; Mon, 3 Jun 2019 20:34:58 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::d4f6:b485:69ee:fd9a]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::d4f6:b485:69ee:fd9a%7]) with mapi id 15.20.1943.018; Mon, 3 Jun 2019
 20:34:58 +0000
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
Thread-Index: AQHVDs7p5YZCYW51S0W/c+2xf0nte6Z0TWwAgAB+vAD//5Q4AIANJlUAgABaJgCAB4qDAIABDpyA
Date:   Mon, 3 Jun 2019 20:34:57 +0000
Message-ID: <20190603203452.GC14526@tower.DHCP.thefacebook.com>
References: <20190520054017.32299-1-tobin@kernel.org>
 <20190520054017.32299-17-tobin@kernel.org>
 <20190521005740.GA9552@tower.DHCP.thefacebook.com>
 <20190521013118.GB25898@eros.localdomain>
 <20190521020530.GA18287@tower.DHCP.thefacebook.com>
 <20190529035406.GA23181@eros.localdomain>
 <20190529161644.GA3228@tower.DHCP.thefacebook.com>
 <20190603042620.GA23098@eros.localdomain>
In-Reply-To: <20190603042620.GA23098@eros.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR0201CA0084.namprd02.prod.outlook.com
 (2603:10b6:301:75::25) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:152::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::5409]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ddcec678-ba46-4af9-2b44-08d6e862f17c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR15MB2472;
x-ms-traffictypediagnostic: BYAPR15MB2472:
x-microsoft-antispam-prvs: <BYAPR15MB247203EA794ECFE544756451BE140@BYAPR15MB2472.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0057EE387C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(136003)(346002)(396003)(376002)(189003)(199004)(316002)(8936002)(1076003)(478600001)(7736002)(68736007)(81156014)(81166006)(8676002)(305945005)(6246003)(14454004)(86362001)(46003)(33656002)(446003)(486006)(71200400001)(5660300002)(476003)(102836004)(71190400001)(386003)(6506007)(11346002)(256004)(14444005)(76176011)(52116002)(6116002)(186003)(6436002)(9686003)(6512007)(54906003)(6916009)(53936002)(25786009)(99286004)(4326008)(73956011)(6486002)(2906002)(229853002)(66476007)(66556008)(64756008)(66446008)(66946007)(7416002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2472;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Qav9L8Mr32UJfVLohh32ASpryiD2aI5DqOFyd4qvodDq0k/Awz4Lja9vMscQS3ZooPyFck//Db3YgN58v3xdk+5ZwaF6s9A+w7H4383eUebBeBDfwFYGk85H8j1pJhCChFaztGJ3tvIgjA+IwKxNZsfUUJeNh2duJ5vdhVxaYlyCNJZkCPovBqiHQpMUQGgEEjWzmfFJc+aJOVfUGROImx/364g3NTh0niRGp52H3zBqpy4lVFnrIKPb2aRO+LINML39GLJUWdkCACZ4A6CX9VaHRx0r6qRXQfriQbniaSy3gMB195BAPtQrMdLg2MV3janeG11LiXNJUmbXDi4Lt06Wet5cASd7ZxAy6Vp8f67SpeSVzDhHWv1/ndZHVr7jl/cTR7QcJ9kG3Y8v9c5DBbpvs50lM8W6AWqo9PASb/A=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <12C316C555CDFA43824239090DA0C4CF@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ddcec678-ba46-4af9-2b44-08d6e862f17c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2019 20:34:58.0006
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: guro@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2472
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-03_16:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906030138
X-FB-Internal: deliver
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 03, 2019 at 02:26:20PM +1000, Tobin C. Harding wrote:
> On Wed, May 29, 2019 at 04:16:51PM +0000, Roman Gushchin wrote:
> > On Wed, May 29, 2019 at 01:54:06PM +1000, Tobin C. Harding wrote:
> > > On Tue, May 21, 2019 at 02:05:38AM +0000, Roman Gushchin wrote:
> > > > On Tue, May 21, 2019 at 11:31:18AM +1000, Tobin C. Harding wrote:
> > > > > On Tue, May 21, 2019 at 12:57:47AM +0000, Roman Gushchin wrote:
> > > > > > On Mon, May 20, 2019 at 03:40:17PM +1000, Tobin C. Harding wrot=
e:
> > > > > > > In an attempt to make the SMO patchset as non-invasive as pos=
sible add a
> > > > > > > config option CONFIG_DCACHE_SMO (under "Memory Management opt=
ions") for
> > > > > > > enabling SMO for the DCACHE.  Whithout this option dcache con=
structor is
> > > > > > > used but no other code is built in, with this option enabled =
slab
> > > > > > > mobility is enabled and the isolate/migrate functions are bui=
lt in.
> > > > > > >=20
> > > > > > > Add CONFIG_DCACHE_SMO to guard the partial shrinking of the d=
cache via
> > > > > > > Slab Movable Objects infrastructure.
> > > > > >=20
> > > > > > Hm, isn't it better to make it a static branch? Or basically an=
ything
> > > > > > that allows switching on the fly?
> > > > >=20
> > > > > If that is wanted, turning SMO on and off per cache, we can proba=
bly do
> > > > > this in the SMO code in SLUB.
> > > >=20
> > > > Not necessarily per cache, but without recompiling the kernel.
> > > > >=20
> > > > > > It seems that the cost of just building it in shouldn't be that=
 high.
> > > > > > And the question if the defragmentation worth the trouble is so=
 much
> > > > > > easier to answer if it's possible to turn it on and off without=
 rebooting.
> > > > >=20
> > > > > If the question is 'is defragmentation worth the trouble for the
> > > > > dcache', I'm not sure having SMO turned off helps answer that que=
stion.
> > > > > If one doesn't shrink the dentry cache there should be very littl=
e
> > > > > overhead in having SMO enabled.  So if one wants to explore this
> > > > > question then they can turn on the config option.  Please correct=
 me if
> > > > > I'm wrong.
> > > >=20
> > > > The problem with a config option is that it's hard to switch over.
> > > >=20
> > > > So just to test your changes in production a new kernel should be b=
uilt,
> > > > tested and rolled out to a representative set of machines (which ca=
n be
> > > > measured in thousands of machines). Then if results are questionabl=
e,
> > > > it should be rolled back.
> > > >=20
> > > > What you're actually guarding is the kmem_cache_setup_mobility() ca=
ll,
> > > > which can be perfectly avoided using a boot option, for example. Tu=
rning
> > > > it on and off completely dynamic isn't that hard too.
> > >=20
> > > Hi Roman,
> > >=20
> > > I've added a boot parameter to SLUB so that admins can enable/disable
> > > SMO at boot time system wide.  Then for each object that implements S=
MO
> > > (currently XArray and dcache) I've also added a boot parameter to
> > > enable/disable SMO for that cache specifically (these depend on SMO
> > > being enabled system wide).
> > >=20
> > > All three boot parameters default to 'off', I've added a config optio=
n
> > > to default each to 'on'.
> > >=20
> > > I've got a little more testing to do on another part of the set then =
the
> > > PATCH version is coming at you :)
> > >=20
> > > This is more a courtesy email than a request for comment, but please
> > > feel free to shout if you don't like the method outlined above.
> > >=20
> > > Fully dynamic config is not currently possible because currently the =
SMO
> > > implementation does not support disabling mobility for a cache once i=
t
> > > is turned on, a bit of extra logic would need to be added and some st=
ate
> > > stored - I'm not sure it warrants it ATM but that can be easily added
> > > later if wanted.  Maybe Christoph will give his opinion on this.
> >=20
> > Perfect!
>=20
> Hi Roman,
>=20
> I'm about to post PATCH series.  I have removed all the boot time config
> options in contrast to what I stated in this thread.  I feel it requires
> some comment so as not to seem rude to you.  Please feel free to
> re-raise these issues on the series if you feel it is a better place to
> do it than on this thread.
>=20
> I still hear you re making testing easier if there are boot parameters.
> I don't have extensive experience testing on a large number of machines
> so I have no basis to contradict what you said.
>=20
> It was suggested to me that having switches to turn SMO off implies the
> series is not ready.  I am claiming that SMO _is_ ready and also that it
> has no negative effects (especially on the dcache).  I therefore think
> this comment is pertinent.
>=20
> So ... I re-did the boot parameters defaulting to 'on'.  However I could
> then see no reason (outside of testing) to turn them off.  It seems ugly
> to have code that is only required during testing and never after.
> Please correct me if I'm wrong.
>=20
> Finally I decided that since adding a boot parameter is trivial that
> hackers could easily add one to test if they wanted to test a specific
> cache.  Otherwise we just test 'patched kernel' vs 'unpatched kernel'.
> Again, please correct me if I'm wrong.
>=20
> So, that said, please feel free to voice your opinion as strongly as you
> wish.  I am super appreciative of the time you have already taken to
> look at these patches.  I hope I have made the best technical decision,
> and I am totally open to being told I'm wrong :)

Hi Tobin!

No boot options looks totally fine to me. I just don't like new config
options. No options at all is always the best.

Btw, thank you for this clarification!

I'll definitely try to look into the patchset on this week.

Thanks!
