Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE63349C8A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jun 2019 11:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729179AbfFRJBj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jun 2019 05:01:39 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:16103 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729042AbfFRJBj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jun 2019 05:01:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1560848498; x=1592384498;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=0jP7IPAKzA41nuDjRxo8fzpcwS8n4yOAmfM6hcSZ5bs=;
  b=BCkmFItuSeX419TRNtCKdQ0jgRyXvSG1VaiTOkH9fepuh9EiAH0D5Arg
   VPXC0ebQCUERfv9qITvUX1sw1a5/aMLV3jX+qYZZx1nnBMJ1UOMHek4Rp
   ox3viiYgpWE7WIw3MY1fREipWYEG8Vw2jTOsNx1e58mswseYvkZbVDkPB
   tbas9etzVXJKKy4EV+U70E8UCIq99QALfVAaa5K9UaBxgRpBr1kWXo8/H
   9oHcan+fqqq3Iyl+1GWkwZ0f4tGOYLdSyStbR+bIlEmh5CqR34Ebbvn74
   q/JhnRkfilbWDIJVBWd5QdoGYXxVrZ7DrguKCsIWw0mWAyYUsdgXPn04+
   w==;
X-IronPort-AV: E=Sophos;i="5.63,388,1557158400"; 
   d="scan'208";a="112086525"
Received: from mail-dm3nam05lp2059.outbound.protection.outlook.com (HELO NAM05-DM3-obe.outbound.protection.outlook.com) ([104.47.49.59])
  by ob1.hgst.iphmx.com with ESMTP; 18 Jun 2019 17:01:37 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t9GsIx7yapJY4EzGqpUuDoteTNozhnh2ZdFWrlOP34A=;
 b=mjnz38CG6lPSYVpOcDzMAX3SczHY1xPRr/Nbm7PFwgrO85NA0pucMkIznky0tvV+ByrITIPcSG8KE8bVJQlLHpTIOB8ot3VLMKBWm4E2G9wfJgUrjW8P+9Lp+gGplrH8jHWAfbkoE03opAOyhyN6pSncoEALcLT0ubN9Fh0HE6Q=
Received: from SN6PR04MB5231.namprd04.prod.outlook.com (20.177.254.85) by
 SN6PR04MB5118.namprd04.prod.outlook.com (52.135.116.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.11; Tue, 18 Jun 2019 09:01:35 +0000
Received: from SN6PR04MB5231.namprd04.prod.outlook.com
 ([fe80::5005:99a1:65aa:f088]) by SN6PR04MB5231.namprd04.prod.outlook.com
 ([fe80::5005:99a1:65aa:f088%6]) with mapi id 15.20.1987.013; Tue, 18 Jun 2019
 09:01:35 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hannes Reinecke <hare@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        =?iso-8859-1?Q?Matias_Bj=F8rling?= <mb@lightnvm.io>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH 09/19] btrfs: limit super block locations in HMZONED mode
Thread-Topic: [PATCH 09/19] btrfs: limit super block locations in HMZONED mode
Thread-Index: AQHVHTKI41mlZbldhUiKC20uoMUKKg==
Date:   Tue, 18 Jun 2019 09:01:35 +0000
Message-ID: <SN6PR04MB523133E2B4DA6705F79A48FF8CEA0@SN6PR04MB5231.namprd04.prod.outlook.com>
References: <20190607131025.31996-1-naohiro.aota@wdc.com>
 <20190607131025.31996-10-naohiro.aota@wdc.com>
 <20190617225356.GJ19057@twin.jikos.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Naohiro.Aota@wdc.com; 
x-originating-ip: [199.255.47.8]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e783fce6-b5f3-4945-069e-08d6f3cb90e7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR04MB5118;
x-ms-traffictypediagnostic: SN6PR04MB5118:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB51186FC5ECFC39F8C9838C9E8CEA0@SN6PR04MB5118.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 007271867D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(136003)(396003)(346002)(366004)(189003)(199004)(305945005)(91956017)(66446008)(66946007)(52536014)(76116006)(66556008)(64756008)(2906002)(66476007)(73956011)(5660300002)(25786009)(6246003)(4326008)(2351001)(6916009)(6116002)(14454004)(3846002)(478600001)(2501003)(55016002)(71190400001)(71200400001)(68736007)(9686003)(72206003)(5640700003)(53936002)(6436002)(86362001)(54906003)(316002)(256004)(33656002)(229853002)(1730700003)(8676002)(102836004)(14444005)(76176011)(81166006)(81156014)(66066001)(6506007)(8936002)(446003)(53546011)(7416002)(7696005)(486006)(74316002)(476003)(7736002)(26005)(186003)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB5118;H:SN6PR04MB5231.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: p9jAN4NCw+ivTJ1GClLpObfxPMRrUkfoMPKfIV31apbGREgdy0f6T2uSGVSfhGBHckvVnLxrVKUVu8znm95u8p2vgWBV23hMuZvVQ1zaUslH/mq1kyCWVvMu9/19tRCF7SLhkM2RnmLHwcIETlcMkLdt+Jp3dUymKUvGrR/QKTYDGQbefZuDjTu1Ykf3M8PMcUmjccgFrJu9GvsG/wQSAAS778YQfniV5jm1hRA1lcHxFEl8QAmbVpQWoDFtePgoKZwoK27W3HDajqP56V4bUHfbVT6NBdw7LRihCrcPyN475HGdq4/2Iao30N1yXwkpO6Y3tsRcmci+0r3Ohk3BiuGG+ig74oi+pL/ibhFqMW+dLPtztvkX56tjR/Lo2hvfJoNcO2Z4D6S/Ru9VcZC21S6zrDWOB7FWIz/yhUEd5wM=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e783fce6-b5f3-4945-069e-08d6f3cb90e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2019 09:01:35.1076
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Naohiro.Aota1@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5118
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/06/18 7:53, David Sterba wrote:=0A=
> On Fri, Jun 07, 2019 at 10:10:15PM +0900, Naohiro Aota wrote:=0A=
>> When in HMZONED mode, make sure that device super blocks are located in=
=0A=
>> randomly writable zones of zoned block devices. That is, do not write su=
per=0A=
>> blocks in sequential write required zones of host-managed zoned block=0A=
>> devices as update would not be possible.=0A=
> =0A=
> This could be explained in more detail. My understanding is that the 1st=
=0A=
> and 2nd copy superblocks is skipped at write time but the zone=0A=
> containing the superblocks is not excluded from allocations. Ie. regular=
=0A=
> data can appear in place where the superblocks would exist on=0A=
> non-hmzoned filesystem. Is that correct?=0A=
=0A=
Correct. You can see regular data stored at usually SB location on HMZONED =
fs.=0A=
=0A=
> The other option is to completely exclude the zone that contains the=0A=
> superblock copies.=0A=
> =0A=
> primary sb			 64K=0A=
> 1st copy			 64M=0A=
> 2nd copy			256G=0A=
> =0A=
> Depends on the drives, but I think the size of the random write zone=0A=
> will very often cover primary and 1st copy. So there's at least some=0A=
> backup copy.=0A=
> =0A=
> The 2nd copy will be in the sequential-only zone, so the whole zone=0A=
> needs to be excluded in exclude_super_stripes. But it's not, so this=0A=
> means data can go there.  I think the zone should be left empty.=0A=
> =0A=
=0A=
I see. That's more safe for the older kernel/userland, right? By keeping th=
at zone empty,=0A=
we can avoid old ones to mis-interpret data to be SB.=0A=
=0A=
Alright, I will change the code to do so.=0A=
