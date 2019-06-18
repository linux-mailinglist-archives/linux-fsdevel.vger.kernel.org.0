Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4B249A87
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jun 2019 09:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbfFRH07 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jun 2019 03:26:59 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:5736 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbfFRH07 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jun 2019 03:26:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1560842818; x=1592378818;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=d+wG2Fjx0bOhYYZT7YsRsIrQMqCTL7+/VTTJL4X/Ksc=;
  b=Gb0J09UnwD0iS9xfbqlsgyiN6dj5e1SwuRdWamMUcjrVDhW90ns3ewCq
   ij2vCI3wsRZVYWAjxmGUqIKr0WtGTEan8p98AT1xfmuxKUCDZXxW4dIHN
   A1Zu2H7J/H5HMzKg5yWQMDgUxmSSHDnFnMJzGChBlxAfOHKp7xECmbxAT
   jBniRil4TNJHUQnSyDU7xhdIM5lCKsdrjcd0CrSYifsu7GO6y2Zr3K/pn
   jHSdCzHy2CzHSwPQoaMZC8SSpa9XRR1L4hPzPbY/8kF5Drw5jacz+xAEK
   Es4o3B+GHAOnkCLrxCdUZemdEbQwbif9vl/EPm4MWZ7ruojV7eFotHlAu
   A==;
X-IronPort-AV: E=Sophos;i="5.63,388,1557158400"; 
   d="scan'208";a="112473576"
Received: from mail-dm3nam05lp2050.outbound.protection.outlook.com (HELO NAM05-DM3-obe.outbound.protection.outlook.com) ([104.47.49.50])
  by ob1.hgst.iphmx.com with ESMTP; 18 Jun 2019 14:04:23 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZmJFPMJq+tV8srk+lxwmuUSFY8ni9vRMTmfDiyJzrCQ=;
 b=ZOMzGEaGnl1DBqj3pnLxZo9Ct9ewG0RfZI23EHWK5ww7byBTjE/UR+Abz/W2llAYfDSlrJOLCn5CkhVEHdN/CD44BViSaWblTCM0S2VzosUaEF+ahfe+eN1bhx1HUGybQJg2+QhqelSFXkEVDUj0zfpfuGThklFSq1R+gmtjX64=
Received: from SN6PR04MB5231.namprd04.prod.outlook.com (20.177.254.85) by
 SN6PR04MB4941.namprd04.prod.outlook.com (52.135.114.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.12; Tue, 18 Jun 2019 06:04:21 +0000
Received: from SN6PR04MB5231.namprd04.prod.outlook.com
 ([fe80::5005:99a1:65aa:f088]) by SN6PR04MB5231.namprd04.prod.outlook.com
 ([fe80::5005:99a1:65aa:f088%6]) with mapi id 15.20.1987.013; Tue, 18 Jun 2019
 06:04:21 +0000
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
Subject: Re: [PATCH 02/19] btrfs: Get zone information of zoned block devices
Thread-Topic: [PATCH 02/19] btrfs: Get zone information of zoned block devices
Thread-Index: AQHVHTJ/1FX3VZfOTkaSGAxvcc7+NQ==
Date:   Tue, 18 Jun 2019 06:04:21 +0000
Message-ID: <SN6PR04MB52315752FF4D8E3CFF8801B38CEA0@SN6PR04MB5231.namprd04.prod.outlook.com>
References: <20190607131025.31996-1-naohiro.aota@wdc.com>
 <20190607131025.31996-3-naohiro.aota@wdc.com>
 <20190613135759.22siaadm7l4gz2ri@MacBook-Pro-91.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Naohiro.Aota@wdc.com; 
x-originating-ip: [199.255.47.8]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4ff130cc-6e51-48c9-775c-08d6f3b2ce8b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:SN6PR04MB4941;
x-ms-traffictypediagnostic: SN6PR04MB4941:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB4941C013C1C390B213378E9E8CEA0@SN6PR04MB4941.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 007271867D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(136003)(376002)(346002)(366004)(189003)(199004)(33656002)(7416002)(76116006)(99286004)(8936002)(74316002)(91956017)(7736002)(66476007)(66556008)(478600001)(68736007)(7696005)(66946007)(64756008)(8676002)(305945005)(73956011)(6506007)(102836004)(53546011)(53936002)(6916009)(229853002)(52536014)(81166006)(66446008)(2906002)(6246003)(81156014)(6116002)(6436002)(3846002)(54906003)(476003)(26005)(4326008)(186003)(71200400001)(71190400001)(66066001)(55016002)(446003)(486006)(5660300002)(86362001)(76176011)(14454004)(5024004)(9686003)(25786009)(72206003)(316002)(256004);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB4941;H:SN6PR04MB5231.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tmzyWYcZUOjUjH2r75U4CtTwBmWbwrI6qsbEbRoyLAw4PwRXjiXLyEG9nU6sdqUmDLqn5UudaowCffjUcYUpytDaAyj5QUh69ZlCzd4gc6hD73y/2M16HfIsZs9HDJv5rxYkQ06A/k7poXszCLksvQpD1ab63kmzp+sjoPH2NXDl/92DOnVEWSKBDiYyIjW1825xDfumQAfRPZQxA9PEwpT6t14S5eXsOQp5HWXKed5EJoG3yOm35W12nF7Gh/4jJHxg44OeoWeoZmNPq8TpW2a7iEijnpGtYAviE6c2jXvG2U6XEGfhzJKpckHrEvGQQq833yE13i1uCfxjmzGtYkcc0lpLR0H+18AoSyRzWlC/EsBdgjbt6ZPgQS6xRTI24QQsn3PZqc49uXYSPxEMnE4p8AVzcOYQCzp9MJ7a8XA=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ff130cc-6e51-48c9-775c-08d6f3b2ce8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2019 06:04:21.2979
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Naohiro.Aota1@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4941
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/06/13 22:58, Josef Bacik wrote:=0A=
> On Fri, Jun 07, 2019 at 10:10:08PM +0900, Naohiro Aota wrote:=0A=
>> If a zoned block device is found, get its zone information (number of zo=
nes=0A=
>> and zone size) using the new helper function btrfs_get_dev_zonetypes(). =
 To=0A=
>> avoid costly run-time zone report commands to test the device zones type=
=0A=
>> during block allocation, attach the seqzones bitmap to the device struct=
ure=0A=
>> to indicate if a zone is sequential or accept random writes.=0A=
>>=0A=
>> This patch also introduces the helper function btrfs_dev_is_sequential()=
 to=0A=
>> test if the zone storing a block is a sequential write required zone.=0A=
>>=0A=
>> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
>> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>=0A=
>> ---=0A=
>>   fs/btrfs/volumes.c | 143 +++++++++++++++++++++++++++++++++++++++++++++=
=0A=
>>   fs/btrfs/volumes.h |  33 +++++++++++=0A=
>>   2 files changed, 176 insertions(+)=0A=
>>=0A=
> =0A=
> We have enough problems with giant files already, please just add a separ=
ate=0A=
> hmzoned.c or whatever and put all the zone specific code in there.  That'=
ll save=0A=
> me time when I go and break a bunch of stuff out.  Thanks,=0A=
> =0A=
> Josef=0A=
> =0A=
=0A=
Thank you for the reviews.=0A=
=0A=
I'll add hmzoned.c and put the things (with more helpers/abstraction) there=
 in the next version.=0A=
=0A=
Thanks.=0A=
