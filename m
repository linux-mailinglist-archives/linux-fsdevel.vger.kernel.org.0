Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47A81762852
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 03:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbjGZBvU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jul 2023 21:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjGZBvS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jul 2023 21:51:18 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D3839B;
        Tue, 25 Jul 2023 18:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690336277; x=1721872277;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8HMFjbfGoJwNh+7WarFotOY18eCfFTE5S6rOL1cPxsE=;
  b=kFiBC3A2sA7Jub0kfnJtJMkgC5sGp4WcNkw08KnmXqVTzYEgCWH4HpAc
   IIVs+yFqwP9E0L+nW38CbSUq/VIB94MkBkmH91WMUrZBKojLzfX+E0C1W
   i7ER3ZaYih+e580po6TNE+l3X8IlS5Y0EC1tt8FCl1JWyzdUlRJQkqu6F
   3j40BRGRQao7tM6FeIEw15GYDyiz25YHdF/Uxedv+0fXPn3AoCzKqUk2j
   xattGti7v90ZnF1/JpF+D31JLnjaEn7ZbqtFVQSHffzg4ThWKNy1oCIpb
   8Ftxh/cPtE5bCrcF7VYJsi+nVuZUABN0F6ai5i+upvHAUOajhLgtRt7rq
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="398809437"
X-IronPort-AV: E=Sophos;i="6.01,231,1684825200"; 
   d="scan'208";a="398809437"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 18:51:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="796346104"
X-IronPort-AV: E=Sophos;i="6.01,231,1684825200"; 
   d="scan'208";a="796346104"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP; 25 Jul 2023 18:51:12 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 25 Jul 2023 18:51:12 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 25 Jul 2023 18:51:12 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 25 Jul 2023 18:51:12 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.46) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 25 Jul 2023 18:51:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Buj4J0dEF3iQxatu3agY4BK7pzdis1avdUZxXfaUbkKhd3GiZyAOqI4F8KjVlBXHbwJXnSeVotVtRUGh4aZeeYHMP+wTi1tZa0u5lnlsysnq93zdx5oZ8poYz7ZEMkfWo9lLdAuasQ3IbdTghSsVnZtYEEqVhVGCYxve5JjIjIbqkU0R39Vl0YNa246eNNpdOGA30Ek/xFKY2iRjatC35/YHztBAbNm0cn/B3y0VsiKBoCwDb0SwlWF41UVKMzIFeXOMUPzkNM/4kt3wICVHLh33FPnFdQ2XwXpXQTuKPDrRM4gPFGagiR8nPeR/6pl/XFRTWrihuNBCht+1SsUwJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0WVBUI0oOjS5DYh8nig0BHkwqi/HR+gO6cWvYHjFxm8=;
 b=UX4FT5YBwg2Ok6JnGbDyvJkI7a0J+au5s9cK1osoo93yTAaP440KGDKZAP3Cl4ltPJ/goV0mbLUz9d5S1ldvPYKrUOyUqTlnqLQx5YP5L2ftQvQK49eqRbzFmgvWfq6i9GlGdCJDACTk/8p+JeQgqZdUfRUwrgE6/LCADJmqXhWhQ5OD7oOiM3BLnH1QR7AsiGYQ2l1Rf05SA3S8y8lIr/nmQCtZ+6Q/cdh+H5sFBKfZxKoIwJLgadfmsasWB78ysizfYkF3lrB5X6QIos8rySQZpZc8r7kBM7klmolZU0gufWCl0d94wmf+6bU5gvKaeOmRVx4GQ3GfcgKPxw7z0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB6373.namprd11.prod.outlook.com (2603:10b6:8:cb::20) by
 IA0PR11MB7209.namprd11.prod.outlook.com (2603:10b6:208:441::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Wed, 26 Jul
 2023 01:51:06 +0000
Received: from DS0PR11MB6373.namprd11.prod.outlook.com
 ([fe80::ace1:c0df:7dd9:d94a]) by DS0PR11MB6373.namprd11.prod.outlook.com
 ([fe80::ace1:c0df:7dd9:d94a%4]) with mapi id 15.20.6609.032; Wed, 26 Jul 2023
 01:51:06 +0000
From:   "Wang, Wei W" <wei.w.wang@intel.com>
To:     "Christopherson,, Sean" <seanjc@google.com>
CC:     Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
        "Oliver Upton" <oliver.upton@linux.dev>,
        Huacai Chen <chenhuacai@kernel.org>,
        "Michael Ellerman" <mpe@ellerman.id.au>,
        Anup Patel <anup@brainfault.org>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "kvm-riscv@lists.infradead.org" <kvm-riscv@lists.infradead.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Chao Peng <chao.p.peng@linux.intel.com>,
        "Fuad Tabba" <tabba@google.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Annapurve, Vishal" <vannapurve@google.com>,
        Ackerley Tng <ackerleytng@google.com>,
        Maciej Szmigiero <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        "David Hildenbrand" <david@redhat.com>,
        Quentin Perret <qperret@google.com>,
        "Michael Roth" <michael.roth@amd.com>,
        Liam Merwick <liam.merwick@oracle.com>,
        "Isaku Yamahata" <isaku.yamahata@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: RE: [RFC PATCH v11 12/29] KVM: Add KVM_CREATE_GUEST_MEMFD ioctl() for
 guest-specific backing memory
Thread-Topic: [RFC PATCH v11 12/29] KVM: Add KVM_CREATE_GUEST_MEMFD ioctl()
 for guest-specific backing memory
Thread-Index: AQHZudJw1MgLsjkkR0ChgAdWyO82ca/KHE2ggACTTICAAJT1MA==
Date:   Wed, 26 Jul 2023 01:51:05 +0000
Message-ID: <DS0PR11MB6373FDFA7B6FA11974297082DC00A@DS0PR11MB6373.namprd11.prod.outlook.com>
References: <20230718234512.1690985-1-seanjc@google.com>
 <20230718234512.1690985-13-seanjc@google.com>
 <DS0PR11MB637386533A4A10667BA6DF03DC03A@DS0PR11MB6373.namprd11.prod.outlook.com>
 <ZL/yb4wL4Nhf9snZ@google.com>
In-Reply-To: <ZL/yb4wL4Nhf9snZ@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB6373:EE_|IA0PR11MB7209:EE_
x-ms-office365-filtering-correlation-id: 1f741d1d-5183-4c78-e944-08db8d7ac65f
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MUIO0tRGeIcirj1bn9f/G1LrpRG94PQqkPPI3dQI1EDyfWGDRDwJV1f56lGe4Ec2vt6L8hGhHyimQBlUB/OWnDbPv+pw51B+EI6BYwG4engeuN36jMt2r+fWpobmo8W5RbWhYeuqPuLd0sktBvsH2jfanNChvro4NOCkk2u8jvPLJH6SzobAtRrMu7Cb/lOPTJVbSx/BpsRSJt37rpz7QjjPXiyhFrqAqa+GArxtoyCp+5x08je6BzsbL/pAt2RlXHp2RHhMXsFEYf/OkPzmm5vcxkyZQSVSU8IoX3udqIt04v75+Phrx6i+/wBVdeHGzrlmhkngtfhqshKpHL8/bSzWNePLzUKe1Q2BJ7Iv2Xgi72BxFpOsMe8ecVJlPlOr1ZWuqGdrOIzP0P9t72gkznMU80VESpRhK/Nh76vaW/hsvXfxjeLNaMshzpmfFZBVIT7xzCmg9GZ/dg/An3xuY4nnMAS9ouH0fZNbNijyd9hXtRbohq1fD3e2aGHiXSRuJ3iNHTjJKCZd6aE/yIxJvmrhwiF54eJ5Jekq3tOaq6rheH9u2lnvz/lDcrH59gY+BOZw/5eOlvgx6ITRFM1dWI9wmWxpNm36p1ZJDww8w4yA1Uq4h5mVNrPyibpaewnl
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6373.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(136003)(366004)(396003)(376002)(451199021)(6916009)(8676002)(8936002)(7416002)(7406005)(52536014)(5660300002)(41300700001)(316002)(4326008)(2906002)(54906003)(66946007)(66446008)(64756008)(76116006)(66476007)(66556008)(7696005)(9686003)(26005)(71200400001)(53546011)(478600001)(186003)(6506007)(82960400001)(86362001)(55016003)(83380400001)(38100700002)(38070700005)(33656002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BIquMuPkdoaDOtikGCqOB9NvKYy+xpaTJcozga3Yg3Xp0ybFWyCj2W7QUmUh?=
 =?us-ascii?Q?uuGXQ1+k0wNBorsHowL+8GF5OKIkV3o0M/XAmnkX+kZUGfi18WRYc19scDxe?=
 =?us-ascii?Q?vzdZC8/VhJAudx9IRATecXgY0XiyOJjEoyGp68xTt18W/Bwie7tINB1ch4Jn?=
 =?us-ascii?Q?oL2yZBmZF0C1RvNJWSpH4suijKpA6d2uQUy8bXnb7bgK1GA2PVnFqS0s6jPC?=
 =?us-ascii?Q?eqxaa2jKtTv/ccZr/eGX0tMTNpdW8xXJ8o+nej9Zk8xx6AlvRWZQ/2+P5IPt?=
 =?us-ascii?Q?v+cJWBCqQV2p09c6jv4SomQzzZ3ID2M9TmHmMaLMHn2R98Ecu+XsiBI4LPX7?=
 =?us-ascii?Q?VMmjD9JDcJieHOOXk6zPU3D5Xic/DDRani8y0mXUpxA8nF6TSRigNMOTF7bC?=
 =?us-ascii?Q?ou+OaPzjfIgXF5K6md4g7amwu3K/YqMhN5mJofuxUjkwQX6HwKMFj/RtzYp1?=
 =?us-ascii?Q?cvWJb7FLcePjT9yRbH8V5dBmrn2pUM8c6fsSIJeZahF1lu6vQbuUzy4cUt+K?=
 =?us-ascii?Q?kBrPDj7g7YqICbFfDZ2lv/acuvaGsVrkIPqBYTEBliIVjTQUG9tclC4AbJAk?=
 =?us-ascii?Q?MSYavjAQ+b/bAfl3QTQ4H319nS/0M/fxd7Ha5OHTvk4UploVg9Qw3my3CD4r?=
 =?us-ascii?Q?UGQcZrSvme80AsLmaSKwCWHVgsGRrlWV4eUT8ef1e5RY2bc30Khs3dN6DwiZ?=
 =?us-ascii?Q?VVLaFz2qUZZYybxSFZ2mJ5ZumPfS7Ioyhpz2cIZHnArH/pJNIPNIBpu7Dz+R?=
 =?us-ascii?Q?YlZT1ZrJ3FNiPCAPDYg5jxBdelPG8bRYXFkrn6haSY3PmCfddgU7ZY4QWITE?=
 =?us-ascii?Q?jD5Ih7CffOWypo7kK2duoVfzr2hlw5QuFVnhIriQz9o+CzgU49j6D28/rRIt?=
 =?us-ascii?Q?tK4AT57xgvk5OKb147/MdEo/o04HYAiU4JnNnpjeKg9e3IanzRXf9dwxmLY0?=
 =?us-ascii?Q?nUgu7UDrvt3DWFANx0twhc6n/g/58HcJA4PwC5bhUhuART8eu0Hh/rexA5u1?=
 =?us-ascii?Q?iMP7I+jfITZMAmVyMZfk3npJsh4jo78PMLTv+3WCtGN8emb/BBat5iKlrVnT?=
 =?us-ascii?Q?sfFej7RrErqQrn4yczX1+3bjllQpb5f/yxgwO8K7FdB8ynELBPJ6KYnW1i9R?=
 =?us-ascii?Q?ZVWBB9+67gWgou/Mrn8frQeFPCChvFhKRGu4oiXd5aaXLYjzazlnNW4JltSu?=
 =?us-ascii?Q?y/u6C5S9jx5qbbxSqepHHkiGan1AtMRfJvOg7aYQjovA1JE0EkS6vebzFWkU?=
 =?us-ascii?Q?vc5DteZZLGztCLF2sEUt6wb2wLcQAoIXdtfIkphaVJtYHAnTuq93Q3weVPxl?=
 =?us-ascii?Q?5UuTMXLNaTV+P4+8B6fo9V9YVoMtNQYio0ReIGhf0v7+KpS8yA6a6aJxt/F9?=
 =?us-ascii?Q?H03HhVO7IwJ3Oj5FB8xERb0FRNUfMXKWYjQUUXqEKxRq22JXB7JjiWiCDAjF?=
 =?us-ascii?Q?E5hFZIqlbWKPQ37TsWBb0wb3+xDAwR/KS/1aeoIaU+5A6+UX2ZN6GsZR3JKL?=
 =?us-ascii?Q?A6AICh1c55klW5UvafENnVU117AJm5nUTGI5C5rxzEXUUpAho/fPYt69xi7Y?=
 =?us-ascii?Q?ZhckZIiWyPdF/2cZfL4Hj/JbZttG1awZKW8MrjzR?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6373.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f741d1d-5183-4c78-e944-08db8d7ac65f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2023 01:51:05.5977
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YCOTcuFvhIGaxon9x2WSFOxYV1S+SVkfwmB/yqRnEsS9D/ynMOuSmSM6k/+mB78WtBIL/zRwMMANAGbnAQwr+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7209
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wednesday, July 26, 2023 12:04 AM,  Sean Christopherson wrote:
> On Tue, Jul 25, 2023, Wei W Wang wrote:
> > On Wednesday, July 19, 2023 7:45 AM, Sean Christopherson wrote:
> > > +int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
> > > +		     gfn_t gfn, kvm_pfn_t *pfn, int *max_order) {
> > > +	pgoff_t index =3D gfn - slot->base_gfn + slot->gmem.pgoff;
> > > +	struct kvm_gmem *gmem;
> > > +	struct folio *folio;
> > > +	struct page *page;
> > > +	struct file *file;
> > > +
> > > +	file =3D kvm_gmem_get_file(slot);
> > > +	if (!file)
> > > +		return -EFAULT;
> > > +
> > > +	gmem =3D file->private_data;
> > > +
> > > +	if (WARN_ON_ONCE(xa_load(&gmem->bindings, index) !=3D slot)) {
> > > +		fput(file);
> > > +		return -EIO;
> > > +	}
> > > +
> > > +	folio =3D kvm_gmem_get_folio(file_inode(file), index);
> > > +	if (!folio) {
> > > +		fput(file);
> > > +		return -ENOMEM;
> > > +	}
> > > +
> > > +	page =3D folio_file_page(folio, index);
> > > +
> > > +	*pfn =3D page_to_pfn(page);
> > > +	*max_order =3D compound_order(compound_head(page));
> >
> > Maybe better to check if caller provided a buffer to get the max_order:
> > if (max_order)
> > 	*max_order =3D compound_order(compound_head(page));
> >
> > This is what the previous version did (restrictedmem_get_page), so
> > that callers who only want to get a pfn don't need to define an unused
> > "order" param.
>=20
> My preference would be to require @max_order.  I can kinda sorta see why =
a
> generic implementation (restrictedmem) would make the param optional, but
> with gmem being KVM-internal I think it makes sense to require the param.
> Even if pKVM doesn't _currently_ need/want the order of the backing
> allocation, presumably that's because hugepage support is still on the TO=
DO
> list, not because pKVM fundamentally doesn't need to know the order of th=
e
> backing allocation.

Another usage is live migration. The migration flow works with 4KB pages on=
ly,
and we only need to get the pfn from the given gfn. "order" doesn't seem to=
 be
useful for this case.
