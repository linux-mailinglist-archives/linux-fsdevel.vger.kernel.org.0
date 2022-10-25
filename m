Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3171360D12B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Oct 2022 17:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232308AbiJYP6p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Oct 2022 11:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232730AbiJYP6h (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Oct 2022 11:58:37 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D02E17C570;
        Tue, 25 Oct 2022 08:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666713516; x=1698249516;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iqqCx7nAFxubOx9h/x991mjuZ5NAW3vt55g+3MRC80Q=;
  b=Jwy41ZWg2fF+LP+EKcz9ljqXox+SZpyJEmC2TKCPWsEyDPv0kfBXsTMb
   qufafNlEj510tJpgdW+JaDTlvExeNaR9p28epgiksA0N2d05MYlvfVnyc
   WCu+URvnsXfiRdILB8wz57/G++pTAr2ZJkrWg8sTJdOy1hWSsUhbdowZc
   rjptj6FEqbP9xb83BYynTOPlQ/gstxHY/sN3chEEI2OvQDK3qQkBO1U0K
   WfqMx9rLcypvuuVasVBNFWGlqfyQ5L0S1h0Yy0J1xc/fMDNVm/u7BEVfc
   hSyrHdcXywC9bv+gjfaM4zrxOoSmNHmPNu1QkKhYliajmQ8MkRmlLKAOw
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="307710780"
X-IronPort-AV: E=Sophos;i="5.95,212,1661842800"; 
   d="scan'208";a="307710780"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2022 08:58:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="960865985"
X-IronPort-AV: E=Sophos;i="5.95,212,1661842800"; 
   d="scan'208";a="960865985"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga005.fm.intel.com with ESMTP; 25 Oct 2022 08:58:36 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 08:58:35 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 08:58:35 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 25 Oct 2022 08:58:35 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.105)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 25 Oct 2022 08:58:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NSx2bmJJjNf+1sdmEMZ1g6bnFIF8Wk+UD2MmOsFYdkq/3CHAa2oI+ACfjCq5WTZBIGFTW64ctWijK70bhlp3wtIBFMREJAsst4bbUy8hQ/3QTTAkVhJxE2hSq+W2x8CIbbpSjIqQ80Gdmx2+xKbTivvPqF4suHO1aq24ILJXtc0b7WFlmmUGG/LRdzRodqL3vUoFb3yBck4ZRTcMtA2BFIhNL0aQDLs023JE82qRhysVyzkXwIc7uv/q5Iy72hgazxo3xRro/o+OB/xM+iLaHb1MiQ7bEj4qh1nMGlBMik9POOVmYm1PjwjfZFHfZRKEagQ1OF6jNbxNBfqzgNZxIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q2COmoCqTwx0Jv9Fy+5uUUHIkCEnLwqvI2tWtxdZPVY=;
 b=MWr4H5iGy2vwsMppRtk49+n3ak0zN3VXCe4Yml6vSovv5AZNwFi+9lgzJQtoGCZwrHqAaf/PGOQO7TYyA80cf/JCvfAawyMnog0MLxgu6T+GzbZHxUFCeXacRPU+w98foNlzXhhHE+TwHaE8gM335wM1BnDrLGsGmddKpbxjCVTZU8bJu9Q7KkyAZt55r6VIFTNBVxRaOuW2USS4lq72YKj8ZDEL6xt0Yo4oDZNOiGo8hNuFqxywIuiNN46Rdk+2yG45d84wX0aB/44RZqKrsgaHGoifa7yAjMccxzFPcUvD5pWbr13Ryy2ybLT5AuYuJA+ppivEUwdq2vAIqKGrRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB5827.namprd11.prod.outlook.com (2603:10b6:806:236::21)
 by MW4PR11MB7152.namprd11.prod.outlook.com (2603:10b6:303:222::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Tue, 25 Oct
 2022 15:58:33 +0000
Received: from SA1PR11MB5827.namprd11.prod.outlook.com
 ([fe80::6311:18b8:2bff:87ea]) by SA1PR11MB5827.namprd11.prod.outlook.com
 ([fe80::6311:18b8:2bff:87ea%4]) with mapi id 15.20.5746.026; Tue, 25 Oct 2022
 15:58:32 +0000
From:   "Arechiga Lopez, Jesus A" <jesus.a.arechiga.lopez@intel.com>
To:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>
CC:     Matthew Wilcox <willy@infradead.org>,
        Brian Foster <bfoster@redhat.com>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Hugh Dickins <hughd@google.com>,
        "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
        "Gross, Mark" <mark.gross@intel.com>
Subject: RE: writeback completion soft lockup BUG in folio_wake_bit()
Thread-Topic: writeback completion soft lockup BUG in folio_wake_bit()
Thread-Index: AQHY5+Ugu8Y19CaE9k+bMwH99A1zlK4d/pKAgAACEwCAABMdYA==
Date:   Tue, 25 Oct 2022 15:58:32 +0000
Message-ID: <SA1PR11MB582719B82C984A4AEEB36BAE84319@SA1PR11MB5827.namprd11.prod.outlook.com>
References: <YjDj3lvlNJK/IPiU@bfoster> <YjJPu/3tYnuKK888@casper.infradead.org>
 <YjM88OwoccZOKp86@bfoster> <YjSTq4roN/LJ7Xsy@bfoster>
 <YjSbHp6B9a1G3tuQ@casper.infradead.org>
 <CAHk-=wh6V6TZjjnqBvktbaho_wqfjZYQ9zcKJTV8EP2Kygn0uQ@mail.gmail.com>
 <6350a5f07bae2_6be12944c@dwillia2-xfh.jf.intel.com.notmuch>
 <CAHk-=wizsHtGa=7dESxXd6VNU2mdHqhvCv88FB3xcWb3o3iJMw@mail.gmail.com>
 <6356f1f74678c_141929415@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <CAHk-=wj7mRYuictrQjT+sacgj9_GrmRetE1KLTiz-nOk-H4DPQ@mail.gmail.com>
 <6356f72ca12e0_4da32941c@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <6356f72ca12e0_4da32941c@dwillia2-xfh.jf.intel.com.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.6.500.17
dlp-reaction: request-justification,no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB5827:EE_|MW4PR11MB7152:EE_
x-ms-office365-filtering-correlation-id: f4a0c4e8-5f5e-4fe8-04a8-08dab6a1c484
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6IRS7+peeZ0TjMz3PgQof2sdrGR+0k4Pob5IpiJStEMyRsKw3YLCZ06XZx7DPl/xtQpPqkKj/2ydQlM4sdkLo1Z38p5GopLulFZ35OLTgCT5utHdViTrj1ZtX+ZTP3JLZ2CllUdhAga3+2JVapOjfri24ovXeUJCB3YN5ZY38sRWidXnXeTlQR1nqdeYCcM3F2tZ3eVdGuQXYmp2CgSZAoA66ofvypa9XOMU7F7OJR9oFxhKLR3rBMqrm1sgD5Zme1KfULK6bxIGBYDARlhZUpO0Pd/5Yr1FbnLLA3b200ILU12R50wm4SZHP8YT6JMP9wauwhf+wPWrL8jWYUISsTiNNrucucwoQBB61CDZinyCNRV78cb3fsjVyVra6oExgCrQBgjeJ5jXU5NogWiQ2Za8XEfL1CKX0xJlQy9B2tjGskynwM2RZKab0M3Pi1A+dgglibpmOe09aNK6KiA8hd39je47J8zTivC+YqjTLjOllSFUVrcSptGrLQYlNXUAHcAQ3CJgWuu2NVpCDYQaxFj5qnJqBQbM9Q6N2vWgptVHQSVsnShb7BXyyuzTGmblH3dquoxMdmhT9gAl7VXB5mExYsfqsmNQm2knDVioeswaqOKzTYKAnUooXhTQ8LjAq42IHvClhUvLABSsX1cqM0Bo02ZXjPnuZrlovAIQlQkQEE+fvW3ZHKyg0Bw3ECf/LMW97KKV7fyUznHeu5RI4Gl/tdMoVK6x7aDv4t7JHsjj/XBIydkPqEEkOR6Jln2+KF/ur9dP/5Gsiy+pY1DU5Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB5827.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(376002)(136003)(396003)(346002)(366004)(451199015)(82960400001)(86362001)(122000001)(33656002)(38100700002)(38070700005)(55016003)(54906003)(110136005)(316002)(71200400001)(478600001)(2906002)(8936002)(5660300002)(41300700001)(8676002)(64756008)(52536014)(66476007)(66556008)(4326008)(76116006)(66946007)(83380400001)(66446008)(186003)(7696005)(53546011)(6506007)(26005)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mz+JQS1FtXthRRkwiIc9yFN/YdksGZmscEiFwkk/Z6J4NdbSV5LE2KN35Kuj?=
 =?us-ascii?Q?YIS42AEmhu7ZYSLO1uIuDuVF/dBRZ6qsZ4yYold8ekv3/urm8TJjirI5r7AO?=
 =?us-ascii?Q?UkhAfQpGqYvTacbqfhs+p8m2bf8wQvWdwhCgVfhqVvNU5fsPtlq6SIByiqIy?=
 =?us-ascii?Q?JFBNaTgVXGG4MG1QhlYx6r75oA9GYsUBFqlwxIAurVMXyGqMr9PJTIXcs/Gk?=
 =?us-ascii?Q?Rmxw7mEO1eRTNCJjHAk133/NE7vgV+EKIy7CL8VqIERZswTSIB0KaFPjqBzs?=
 =?us-ascii?Q?GO8RhT/fgl9I3qk5NtNyTewKWuTMkmUMMMndJcRKxlbJYff78R/iKolQ4T/X?=
 =?us-ascii?Q?BcHwmbMvfoFLgQe0gSBpqTz9Km2vtizaI9fubApPeLhDThAgL836HhalKA+J?=
 =?us-ascii?Q?igJDazWKgj+OvWBDcQzSRcW7qkGS273sdUgtz91RCOMs8hrl8NNslIz0j8ka?=
 =?us-ascii?Q?xeEwLaG3LnZlTHksDEv8oX7NZzohVYb8bTJ1y/CAhmAwHh98UkFuHZGOtToD?=
 =?us-ascii?Q?GxQN1vZN2I/SG5u1YfPd61Y0SlQwRIGPX+H+fnWgclbxUU9+YQE2B3tU67bX?=
 =?us-ascii?Q?9xkEhBfp8813m/Cf21PyUZqwf4QZqD8WjLLpMql3dy7mf+oF3ht8EpbIjk7q?=
 =?us-ascii?Q?hgpjTXalmJzBguvXAgE2lzuaKACKXNUahnMu0td275+juSXXMs8T/26ctg4R?=
 =?us-ascii?Q?pMAgPtr0e0SlXxuA1LvP8aOuJg3x3lZYIps5tef8xW5CZpZtUy7thGpbFVUd?=
 =?us-ascii?Q?8h2EvCU9EAw9lgOCCtlHj0+elfXle6ohakv2XM69pULBATrdlfoqtHkkGW4H?=
 =?us-ascii?Q?smS0+bP+b1T7KU/q5g3vp6dHhcYNzHnXjibXgCRRCN69mavDY93cI3aCfbrc?=
 =?us-ascii?Q?2hCdUHP5Js3gn7HMs+zfrOGN8SCDGr4Zpk/NML2+QtCQcpneatPV+GMSdDB/?=
 =?us-ascii?Q?NkXlMiUtJIl+IQGqAXPgDRFo3DR41AC6sTlqStXDLnM2SA5hUkqvD4aKebMj?=
 =?us-ascii?Q?9QjNLkmVkRSNZQMVPpQt/cBn3yXwcBR8nDGcmkAY/E8v/nZOODHM93QjzsP+?=
 =?us-ascii?Q?9Hs/2DKzvCAJtE6VDj989LxApKUcqxMA/tEhpIsqsOhYax6qXsH4CuEQ6mzp?=
 =?us-ascii?Q?YzBwAz73+aSySzytEU0vvFdEItyIUBnEWvULy5JpnW+u/TfGa7yP82J7ii1e?=
 =?us-ascii?Q?NF2oMNaN+19Ry3TyCvFkpAJngFlfUGTWXQKc1pnmkfopraKLYw50ADUE7j+p?=
 =?us-ascii?Q?Z0RiP65hlku+ppGslV19gTLWQmXiOCSDk9iPvwrhx1TvOQ4pXVD5ie/QLY7J?=
 =?us-ascii?Q?b7nPQA984rWHftE0XzZpy5cdKI1OlqYH0NOelnyJXjj66E9ucYGDuIghjk4y?=
 =?us-ascii?Q?xjqwljByCNezwbrFlkiLWmcjID/5feFIiqnRaqPDjoCyeX0bVHzwtmhPSnpF?=
 =?us-ascii?Q?UbCAfIk7OmnWZf8QYHKL1JcV+TpBDa9iPOO8pJ3e7xYSaEbdVDKXvKuFdfMi?=
 =?us-ascii?Q?DK2pJNrcKTf34JToLuyIZHqx41nNvurnx2iw5E7XVLsalYyLkBXBHOO/aZ6s?=
 =?us-ascii?Q?mY/HjLQHzsEz56n/Gcy3Bvgw/lN3PXzln7yxDV9Z0xZmNdDYvVpdlyre71oT?=
 =?us-ascii?Q?bQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB5827.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4a0c4e8-5f5e-4fe8-04a8-08dab6a1c484
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2022 15:58:32.9010
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PvLTdHcOWa9xa8CcWUVugx4tSxhpKYmnPk4GszQ9rpZSHBZ5V1aWRgm/kPKpL2abHL4Jw5P0f880Zn3CwbyD4CuMk8AJV4euZSQyxL9l3fjoLbx5CPTjuzrUpkopnZQ8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7152
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> -----Original Message-----
> From: Williams, Dan J <dan.j.williams@intel.com>
> Sent: Monday, October 24, 2022 3:36 PM
> To: Torvalds, Linus <torvalds@linux-foundation.org>; Williams, Dan J
> <dan.j.williams@intel.com>
> Cc: Matthew Wilcox <willy@infradead.org>; Brian Foster
> <bfoster@redhat.com>; Linux-MM <linux-mm@kvack.org>; linux-fsdevel
> <linux-fsdevel@vger.kernel.org>; linux-xfs <linux-xfs@vger.kernel.org>;
> Hugh Dickins <hughd@google.com>; Arechiga Lopez, Jesus A
> <jesus.a.arechiga.lopez@intel.com>; tim.c.chen@linux.intel.com
> Subject: Re: writeback completion soft lockup BUG in folio_wake_bit()
>=20
> Linus Torvalds wrote:
> > On Mon, Oct 24, 2022 at 1:13 PM Dan Williams <dan.j.williams@intel.com>
> wrote:
> > >
> > > Arechiga reports that his test case that failed "fast" before now
> > > ran for 28 hours without a soft lockup report with the proposed
> > > patches applied. So, I would consider those:
> > >
> > > Tested-by: Jesus Arechiga Lopez <jesus.a.arechiga.lopez@intel.com>
> >
> > Ok, great.
> >
> > I really like that patch myself (and obviously liked it back when it
> > was originally proposed), but I think it was always held back by the
> > fact that we didn't really have any hard data for it.
> >
> > It does sound like we now very much have hard data for "the page
> > waitlist complexity is now a bigger problem than the historical
> > problem it tried to solve".
> >
> > So I'll happily apply it. The only question is whether it's a "let's
> > do this for 6.2", or if it's something that we'd want to back-port
> > anyway, and might as well apply sooner rather than later as a fix.
> >
> > I think that in turn then depends on just how artificial the test case
> > was. If the test case was triggered by somebody seeing problems in
> > real life loads, that would make the urgency a lot higher. But if it
> > was purely a synthetic test case with no accompanying "this is what
> > made us look at this" problem, it might be a 6.2 thing.
> >
> > Arechiga?
>=20
> I will let Arechiga reply as well, but my sense is that this is more in t=
he latter
> camp of not urgent because the test case is trying to generate platform
> stress (success!), not necessarily trying to get real work done.

Yes, as Dan mentioned it is trying to generate platform stress, We've been =
seeing the soft lockup events on test targets (2 sockets with high core cou=
nt CPU's, and a lot of RAM).=20

The workload stresses every core/CPU thread in various ways and logs result=
s to a shared log file (every core writing to the same log file).  We found=
 that this shared log file was related to the soft lockups.

With this change applied to 5.19 it seems that the soft lockups are no long=
er happening with this workload + configuration.
