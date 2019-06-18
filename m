Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA9E249AE3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jun 2019 09:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbfFRHmu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jun 2019 03:42:50 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:10688 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfFRHmu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jun 2019 03:42:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1560843771; x=1592379771;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Vp0gajc0AUKCNXniwxKjAE6yiS5x1Z72dI2t5uje7WA=;
  b=OoLKJP4N3AFSyAhjnDstQguyk/4POrNb+HHI1RLONgdBS8KDMTMlSzWB
   3c/ON7angBEfCY4mSd4RRxAi77kXmAcANEItQpInDEbFMNvjJ62jy1Y15
   d/eiSyKnClM7XM9YhucXszBY0ikP91uO4/FluEQN33+vLMYtyFO1KyFMz
   BlE3zWlJ2kFbhaWxnAnqubkcHg6Z9JvZwd3n29Pac3qZbDmYYBlUsMbkv
   mxFtbdCODNkTI2MU2Jr8Arx5KYcXWawjQTZF36dmMmx74X9Fs9fa2nl4p
   vCXtNtSPhvK/OwXk80NkKRwmM/s1yBQjh6ObwZl8Fk6ewq8DiaEjTNurv
   A==;
X-IronPort-AV: E=Sophos;i="5.63,388,1557158400"; 
   d="scan'208";a="112080014"
Received: from mail-bn3nam04lp2055.outbound.protection.outlook.com (HELO NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.55])
  by ob1.hgst.iphmx.com with ESMTP; 18 Jun 2019 15:42:49 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4soMqB8JcQ292FDbHxyq43xOkHi5Qss6ToFLyhSKqJk=;
 b=mM8DG5bYLy5T0VkUc9WE7RNa8q2hEFPjEDBRMXMb361M2+i1nNnKZ88pbQVKom5vtQzoF4j5X/E4VH0/fNdeQQaTwcd+1NZmh1ZgYNaKw+NW65HLE8M3E310B6LyPsJ7q0EnvvX+A7ocCLgf0g8fFME/3rnTpIKeRah3ROeFrAU=
Received: from SN6PR04MB5231.namprd04.prod.outlook.com (20.177.254.85) by
 SN6PR04MB5184.namprd04.prod.outlook.com (20.177.254.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.11; Tue, 18 Jun 2019 07:42:46 +0000
Received: from SN6PR04MB5231.namprd04.prod.outlook.com
 ([fe80::5005:99a1:65aa:f088]) by SN6PR04MB5231.namprd04.prod.outlook.com
 ([fe80::5005:99a1:65aa:f088%6]) with mapi id 15.20.1987.013; Tue, 18 Jun 2019
 07:42:46 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Qu Wenruo <wqu@suse.com>, Nikolay Borisov <nborisov@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hannes Reinecke <hare@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        =?iso-8859-1?Q?Matias_Bj=F8rling?= <mb@lightnvm.io>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH 08/19] btrfs: make unmirroed BGs readonly only if we have
 at least one writable BG
Thread-Topic: [PATCH 08/19] btrfs: make unmirroed BGs readonly only if we have
 at least one writable BG
Thread-Index: AQHVHTKH8wZ92WupxkqjiXGkYBnq9g==
Date:   Tue, 18 Jun 2019 07:42:46 +0000
Message-ID: <SN6PR04MB5231CACF687ED7001C73111A8CEA0@SN6PR04MB5231.namprd04.prod.outlook.com>
References: <20190607131025.31996-1-naohiro.aota@wdc.com>
 <20190607131025.31996-9-naohiro.aota@wdc.com>
 <20190613140921.a2kmty5p6lzqztej@MacBook-Pro-91.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Naohiro.Aota@wdc.com; 
x-originating-ip: [199.255.47.8]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 69bd77c0-1694-4496-90b3-08d6f3c08e59
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR04MB5184;
x-ms-traffictypediagnostic: SN6PR04MB5184:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB51842EF74CC681035044CBF58CEA0@SN6PR04MB5184.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 007271867D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(366004)(39860400002)(346002)(376002)(189003)(199004)(53936002)(476003)(6506007)(72206003)(73956011)(55016002)(4326008)(486006)(26005)(66476007)(6116002)(86362001)(91956017)(6916009)(3846002)(64756008)(5660300002)(76116006)(6246003)(66556008)(66946007)(71190400001)(71200400001)(6436002)(478600001)(52536014)(25786009)(66446008)(102836004)(316002)(446003)(76176011)(54906003)(68736007)(256004)(9686003)(53546011)(81166006)(81156014)(14454004)(7416002)(305945005)(66066001)(229853002)(7696005)(7736002)(33656002)(186003)(2906002)(8936002)(99286004)(74316002)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB5184;H:SN6PR04MB5231.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Ozu0phr/4NqlurWGRDZ2ypToNTKiWy5Cb/kHLpfDLy7X7X+RLqPoXNRgWDBmftlY2PUyZw3nBtG26PkzjNNFtFzWskP1OYbBucGEz84OVBcqQ8NZcMVD4u2+VUn+2QT4HIXKm8NrUTB48vvUmlOaCLWZPTeQWFbaRqk8Oi+VtCaoubU6l4YY6vCQzYcOJWhg8ihJA1YBI18JZ21Z/v3/db9hW8BJI7yXDIQ1O2sRG2lTd9KTp3AhJAb+uqxZlqTAt6d2DYpUeF9YTNyuBvtTHDgmbHR4RDSr0Wg3//6TutAebuBoMup+sD8LisxlO/JpKrVXkaL3wfxFKzbugoRcVqq1ttM1bF6xVIublnyTRQHqPpt4vyXbithaWX4UQ+SrkoU9yX9b7zpB72TlTQES6ituaMPe3KDQ/Nnw1WfbHQ0=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69bd77c0-1694-4496-90b3-08d6f3c08e59
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2019 07:42:46.6129
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Naohiro.Aota1@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5184
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/06/13 23:09, Josef Bacik wrote:=0A=
> On Fri, Jun 07, 2019 at 10:10:14PM +0900, Naohiro Aota wrote:=0A=
>> If the btrfs volume has mirrored block groups, it unconditionally makes=
=0A=
>> un-mirrored block groups read only. When we have mirrored block groups, =
but=0A=
>> don't have writable block groups, this will drop all writable block grou=
ps.=0A=
>> So, check if we have at least one writable mirrored block group before=
=0A=
>> setting un-mirrored block groups read only.=0A=
>>=0A=
> =0A=
> I don't understand why you want this.  Thanks,=0A=
> =0A=
> Josef=0A=
> =0A=
=0A=
This is necessary to handle e.g. btrfs/124 case.=0A=
=0A=
When we mount degraded RAID1 FS and write to it, and then=0A=
re-mount with full device, the write pointers of corresponding=0A=
zones of written BG differ.  The patch 07 mark such block group=0A=
as "wp_broken" and make it read only.  In this situation, we only=0A=
have read only RAID1 BGs because of "wp_broken" and un-mirrored BGs=0A=
are also marked read only, because we have RAID1 BGs.=0A=
As a result, all the BGs are now read only, so that we=0A=
cannot even start the rebalance to fix the situation.=0A=
