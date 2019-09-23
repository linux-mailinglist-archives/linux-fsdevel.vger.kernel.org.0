Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14373BBAD2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2019 19:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394184AbfIWRyv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Sep 2019 13:54:51 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:47448 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2393477AbfIWRyv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Sep 2019 13:54:51 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id x8NHdiNM007246;
        Mon, 23 Sep 2019 10:54:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=vA+vBlA+PtK6c7/gJ+6L/B7iV5xBvKZry+MBOi5xDj0=;
 b=Qh0BM0m6vraIlxXm5afjkSYHnFYLGRC6tgU36usRVsgZvFr0qU2y+0wn1K8aH6e8xKmF
 omkrp+x4pz2wc4Fe1r7BgZID2oPvyLUePif6htBA+AJMPeR/f5p5Ijg/b73/wYhkbXZX
 87Iby4LjBEnjyBf77blyBreY1G6qa6bfqUI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 2v5fc08y26-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 23 Sep 2019 10:54:03 -0700
Received: from ash-exopmbx101.TheFacebook.com (2620:10d:c0a8:82::b) by
 ash-exhub101.TheFacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 23 Sep 2019 10:54:02 -0700
Received: from ash-exhub102.TheFacebook.com (2620:10d:c0a8:82::f) by
 ash-exopmbx101.TheFacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 23 Sep 2019 10:54:02 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 23 Sep 2019 10:54:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AGXSccYtaTBSZ55RY22NHQBmBLRXekPumbIdgVjlaHgR1Xx42hq5I6udmae36r5V6S1WcexT0slXtnW7ySejlOf4RYM6+Jmko3juhFBrXzsk4aaIQKGSdcaWp/2b6mMGi62uQMgTqx8a1JXnoSxXjYEsliF/Kik1Tsilmz40FXk7esDOkD++gd+GXI0G7xvNrl2oaRMMMMIalhPn+FrxmbYR6LJaOkgZegq+nP6ZGVn2XQcanlAr9pGbooYS9tDIjra94feM0R8SWjN8cdr7zkUj/aPVAc2zDvrUwmRKxgSO5B6RsDsegV5LsKzWPGWyuHQwbjM1Xw5L1HQOdObwrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vA+vBlA+PtK6c7/gJ+6L/B7iV5xBvKZry+MBOi5xDj0=;
 b=F/Nrp9hMWG5gm7GfSOZuxcdhh0XGnEX798bZdcRbd6M34iHTz5nS1HGvF36Y2EbQNTywJt4tzK4kt6WAmYRp/i0PQfm1jXz8DBG1f5XukYKjk8rZ0aRTIEJYwbO+jv28H4TSH6TzJnmUoG/arhME5bXhiW6wEENf2kZ1fpeQd8xGO3ioVXClQTsRQlxGT5WD0YxVOE6IjwHJBMgqcsHlJbObghzhkW4PAvMDZptRPQGr6ZXHb/Sk+46k2hoWEI1/IkkupCpVJwbFlT5FRNPtNcGoyYVR27Yr+Pv3tWbZpxMcQc2DLgGcgMdVQFrItaGs3k5N9hEhTnPlKDxpcy8GVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vA+vBlA+PtK6c7/gJ+6L/B7iV5xBvKZry+MBOi5xDj0=;
 b=RV7jYdbF6+OdbfAZzkHCLc+BcH/sS8Aulq+ax1LQw+NZ0W77t4KIAdq0zCPaW87AKoxk2UOtMqhxQUo8ONZCjtGwxf6VFX1GdB7Fx01bSInHtcxd7+ck2Tus47yVEh7+3glxlJyhdnrJhYM4XL2xIxrJwU4MX9n4B0/I7SIKZsA=
Received: from DM6PR15MB2635.namprd15.prod.outlook.com (20.179.161.152) by
 DM6PR15MB3209.namprd15.prod.outlook.com (20.179.48.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.25; Mon, 23 Sep 2019 17:54:01 +0000
Received: from DM6PR15MB2635.namprd15.prod.outlook.com
 ([fe80::845f:c175:4860:45db]) by DM6PR15MB2635.namprd15.prod.outlook.com
 ([fe80::845f:c175:4860:45db%3]) with mapi id 15.20.2284.023; Mon, 23 Sep 2019
 17:54:01 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Vlastimil Babka <vbabka@suse.cz>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Lameter <cl@linux.com>,
        "Pekka Enberg" <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Ming Lei <ming.lei@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH v2 2/2] mm, sl[aou]b: guarantee natural alignment for
 kmalloc(power-of-two)
Thread-Topic: [PATCH v2 2/2] mm, sl[aou]b: guarantee natural alignment for
 kmalloc(power-of-two)
Thread-Index: AQHVW//Qkc1FZr/iRUOtm5BItvED66c5oh0AgAAVoAA=
Date:   Mon, 23 Sep 2019 17:54:01 +0000
Message-ID: <20190923175356.GB3644@tower.DHCP.thefacebook.com>
References: <20190826111627.7505-1-vbabka@suse.cz>
 <20190826111627.7505-3-vbabka@suse.cz>
 <df8d1cf4-ff8f-1ee1-12fb-cfec39131b32@suse.cz>
In-Reply-To: <df8d1cf4-ff8f-1ee1-12fb-cfec39131b32@suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR12CA0050.namprd12.prod.outlook.com
 (2603:10b6:300:103::12) To DM6PR15MB2635.namprd15.prod.outlook.com
 (2603:10b6:5:1a6::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::2:72a9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a741e502-e759-48c0-77b0-08d7404f0424
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM6PR15MB3209;
x-ms-traffictypediagnostic: DM6PR15MB3209:
x-ms-exchange-purlcount: 4
x-microsoft-antispam-prvs: <DM6PR15MB320990FA688C75DBDC6CDCD5BE850@DM6PR15MB3209.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0169092318
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(396003)(39860400002)(136003)(376002)(346002)(366004)(189003)(199004)(14454004)(229853002)(52116002)(186003)(6916009)(66476007)(76176011)(8936002)(86362001)(25786009)(8676002)(66446008)(386003)(6506007)(6116002)(4326008)(53546011)(66556008)(99286004)(5660300002)(14444005)(64756008)(256004)(6486002)(66946007)(2906002)(305945005)(446003)(966005)(33656002)(6246003)(81156014)(81166006)(71190400001)(11346002)(54906003)(6436002)(46003)(1076003)(6306002)(6512007)(476003)(71200400001)(9686003)(478600001)(102836004)(7736002)(316002)(7416002)(486006)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR15MB3209;H:DM6PR15MB2635.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Ud6k41Ck0lD3jRYjGhDanm3smt0xi2Arlnler4l+j1nntsKgnPEw89MdEjoX2wN3cs1p/abHxfK8y5AU/QEUu8xvWoKVMmcdlpf88gJrG03M44M62scc8B4v8oDKML0F8hbJ+ndvpXwOe16035ctVqsEUf4OV4ZGw39vNxg6olMbiy39pKB/Fww/5thYRexrfLqeYtVb52u7tNo12v+sqt6f1kJOm31QwLM6QDIXBsuJiG5Ggv4Qy7OPYAgTB8SCGSbVakEuMln3reN82kRYjXCHnMOZBg+AmudDoFO3eLCUMrHlPhSL5JTD9Hyr06UnKQMswMJMYLOpVpwCahOtn9BW4RpOLAftwM+mKkYzinZ8DZvizg7eHVraxa0KLmLtSz+qltnAAqSllilXYF8WldYAL7FXwbP8igAZhdA+K0E=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0DD892B4BD83D84B96C38E3F678300A7@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a741e502-e759-48c0-77b0-08d7404f0424
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2019 17:54:01.3756
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XU+zcsoeyP9zKRq1CC7aXE50ErcFNvASZPURvAubMPDbrpm+T6lXgblM8G3F0RYC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3209
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-09-23_05:2019-09-23,2019-09-23 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1011 mlxlogscore=793
 lowpriorityscore=0 bulkscore=0 adultscore=0 priorityscore=1501 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909230157
X-FB-Internal: deliver
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 23, 2019 at 06:36:32PM +0200, Vlastimil Babka wrote:
> On 8/26/19 1:16 PM, Vlastimil Babka wrote:
> > In most configurations, kmalloc() happens to return naturally aligned (=
i.e.
> > aligned to the block size itself) blocks for power of two sizes. That m=
eans
> > some kmalloc() users might unknowingly rely on that alignment, until st=
uff
> > breaks when the kernel is built with e.g.  CONFIG_SLUB_DEBUG or CONFIG_=
SLOB,
> > and blocks stop being aligned. Then developers have to devise workaroun=
d such
> > as own kmem caches with specified alignment [1], which is not always pr=
actical,
> > as recently evidenced in [2].
> >=20
> > The topic has been discussed at LSF/MM 2019 [3]. Adding a 'kmalloc_alig=
ned()'
> > variant would not help with code unknowingly relying on the implicit al=
ignment.
> > For slab implementations it would either require creating more kmalloc =
caches,
> > or allocate a larger size and only give back part of it. That would be
> > wasteful, especially with a generic alignment parameter (in contrast wi=
th a
> > fixed alignment to size).
> >=20
> > Ideally we should provide to mm users what they need without difficult
> > workarounds or own reimplementations, so let's make the kmalloc() align=
ment to
> > size explicitly guaranteed for power-of-two sizes under all configurati=
ons.
> > What this means for the three available allocators?
> >=20
> > * SLAB object layout happens to be mostly unchanged by the patch. The
> >   implicitly provided alignment could be compromised with CONFIG_DEBUG_=
SLAB due
> >   to redzoning, however SLAB disables redzoning for caches with alignme=
nt
> >   larger than unsigned long long. Practically on at least x86 this incl=
udes
> >   kmalloc caches as they use cache line alignment, which is larger than=
 that.
> >   Still, this patch ensures alignment on all arches and cache sizes.
> >=20
> > * SLUB layout is also unchanged unless redzoning is enabled through
> >   CONFIG_SLUB_DEBUG and boot parameter for the particular kmalloc cache=
. With
> >   this patch, explicit alignment is guaranteed with redzoning as well. =
This
> >   will result in more memory being wasted, but that should be acceptabl=
e in a
> >   debugging scenario.
> >=20
> > * SLOB has no implicit alignment so this patch adds it explicitly for
> >   kmalloc(). The potential downside is increased fragmentation. While
> >   pathological allocation scenarios are certainly possible, in my testi=
ng,
> >   after booting a x86_64 kernel+userspace with virtme, around 16MB memo=
ry
> >   was consumed by slab pages both before and after the patch, with diff=
erence
> >   in the noise.
> >=20
> > [1] https://lore.kernel.org/linux-btrfs/c3157c8e8e0e7588312b40c853f65c0=
2fe6c957a.1566399731.git.christophe.leroy@c-s.fr/
> > [2] https://lore.kernel.org/linux-fsdevel/20190225040904.5557-1-ming.le=
i@redhat.com/
> > [3] https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lwn.net_Arti=
cles_787740_&d=3DDwICaQ&c=3D5VD0RTtNlTh3ycd41b3MUw&r=3DjJYgtDM7QT-W-Fz_d29H=
YQ&m=3DUUX1YoPTOOycNowHuRP2ZnqwSwZFjAFrkQFrqstidZ0&s=3DKt_XTKlh2qxbC_7ME44M=
V3_QWFVRHlI1p2EQZYP0uqY&e=3D=20
> >=20
> > Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
>=20
> So if anyone thinks this is a good idea, please express it (preferably
> in a formal way such as Acked-by), otherwise it seems the patch will be
> dropped (due to a private NACK, apparently).
>=20
> Otherwise I don't think there can be an objective conclusion. On the one
> hand we avoid further problems and workarounds due to misalignment (or
> objects allocated beyond page boundary, which was only recently
> mentioned), on the other hand we potentially make future changes to
> SLAB/SLUB or hypotetical new implementation either more complicated, or
> less effective due to extra fragmentation. Different people can have
> different opinions on what's more important.
>=20
> Let me however explain why I think we don't have to fear the future
> implementation complications that much. There was an argument IIRC that
> extra non-debug metadata could start to be prepended/appended to an
> object in the future (i.e. RCU freeing head?).
>=20
> 1) Caches can be already created with explicit alignment, so a naive
> pre/appending implementation would already waste memory on such caches.
> 2) Even without explicit alignment, a single slab cache for 512k objects
> with few bytes added to each object would waste almost 512k as the
> objects wouldn't fit precisely in an (order-X) page. The percentage
> wasted depends on X.
> 3) Roman recently posted a patchset [1] that basically adds a cgroup
> pointer to each object. The implementation doesn't append it to objects
> naively however, but adds a separately allocated array. Alignment is
> thus unchanged.

To be fair here, we *might* want to put this pointer just after/before
the object to reduce the number of cache misses. I've put it into
a separate place mostly for simplicity reasons.

It's not an objection though, just a note.

Thanks!

>=20
> [1] https://lore.kernel.org/linux-mm/20190905214553.1643060-1-guro@fb.com=
/
>=20
