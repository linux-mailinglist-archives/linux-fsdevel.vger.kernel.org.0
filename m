Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3027B49BE2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jun 2019 10:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbfFRIRz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jun 2019 04:17:55 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:59670 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfFRIRy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jun 2019 04:17:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1560845874; x=1592381874;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=nZVOgOzFmr6Kssz3+tjK0aNLllEcL1/lXKBhQcsyBh0=;
  b=B4i3u2NeOOqTkxwCI15xUVu0HP9boFZH6+Bcz8S8XQWa86J+348WtGdh
   2UDSjDwNMNRExMuThmxz8acilCYZaJ53p8OsK+QAWlwnJoGx2Conq/Do8
   phrnMQXPlKm2R4TIJJK7jQ95Z6WZY4NspiWfDSH2L1xiH88Ptv71DbGPE
   HIxO2v66p3pCuxFv4tu6WJQecscyy3dJUNI7q9db/oeRRWKDYC+F7bS31
   7sf6GF6ZT3eppIcPNY/7RcVVe1CpRlDITog/n0QQR643rLpqwPQMP0dC9
   erfSGWiYiVL0IXWj2eXi5peJ712EoDfnIAzV7SuBK9HADk9rWBxKSbnk3
   Q==;
X-IronPort-AV: E=Sophos;i="5.63,388,1557158400"; 
   d="scan'208";a="217192935"
Received: from mail-co1nam04lp2058.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) ([104.47.45.58])
  by ob1.hgst.iphmx.com with ESMTP; 18 Jun 2019 16:17:53 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qGPehlAUNA1ncKJZuPp2p0HXigQnhwMiSTBjnINLosI=;
 b=g6Y2P/gV7Ztkrt1aZW/odpNcZxY7WI1Jn7gJKsNV2AfOofM+0Y7Ql88CSd3H8/fTpk+TjNCIiHNG7E4KfKnGrG4EoP73Nag6XJWh5GMGxUVc1riNFPFOmmH3O8lV1Ea6VnllH6MgyNjMv10mQlBK7LuCkKfgQIDZWINkFomI5f8=
Received: from SN6PR04MB5231.namprd04.prod.outlook.com (20.177.254.85) by
 SN6PR04MB4365.namprd04.prod.outlook.com (52.135.72.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.13; Tue, 18 Jun 2019 08:17:52 +0000
Received: from SN6PR04MB5231.namprd04.prod.outlook.com
 ([fe80::5005:99a1:65aa:f088]) by SN6PR04MB5231.namprd04.prod.outlook.com
 ([fe80::5005:99a1:65aa:f088%6]) with mapi id 15.20.1987.013; Tue, 18 Jun 2019
 08:17:52 +0000
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
Subject: Re: [PATCH 05/19] btrfs: disable direct IO in HMZONED mode
Thread-Topic: [PATCH 05/19] btrfs: disable direct IO in HMZONED mode
Thread-Index: AQHVHTKDedTybPjxfEqayUijXk/wXg==
Date:   Tue, 18 Jun 2019 08:17:52 +0000
Message-ID: <SN6PR04MB523168E867B817288A587BA48CEA0@SN6PR04MB5231.namprd04.prod.outlook.com>
References: <20190607131025.31996-1-naohiro.aota@wdc.com>
 <20190607131025.31996-6-naohiro.aota@wdc.com>
 <20190613140020.iiqzrkdztindfjyh@MacBook-Pro-91.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Naohiro.Aota@wdc.com; 
x-originating-ip: [199.255.47.8]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 44ef5d6c-979b-466e-3f7f-08d6f3c57559
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR04MB4365;
x-ms-traffictypediagnostic: SN6PR04MB4365:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB43655183113FEA8AEFC3304F8CEA0@SN6PR04MB4365.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 007271867D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(376002)(366004)(396003)(136003)(199004)(189003)(52536014)(91956017)(478600001)(5660300002)(476003)(446003)(33656002)(2906002)(68736007)(6246003)(54906003)(25786009)(4744005)(66476007)(66556008)(86362001)(72206003)(4326008)(6916009)(316002)(6116002)(71200400001)(6436002)(55016002)(3846002)(81166006)(81156014)(14454004)(53936002)(64756008)(305945005)(229853002)(7736002)(7416002)(74316002)(66066001)(76176011)(6506007)(256004)(7696005)(8936002)(9686003)(66946007)(53546011)(26005)(73956011)(186003)(102836004)(486006)(99286004)(76116006)(71190400001)(8676002)(66446008);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB4365;H:SN6PR04MB5231.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: yt7azKT5bQLAwKC6ax3o3zOPOq6ITiVfyRYQoWdSP1e++rqW4mjKWQKe38No233nlft+hFhagUrP87/QkQWGgboQ7yUKk0ExJY3WiYq+ohbFl+nUPNq74Aerc67UwZbmWlUNR+FkV7+J0DFSk5aLrLK6wdDdssMBey8Nlw/UzX3OssM4xnc5JOOpM8/Z3A9mN4lO/labH7g2H0jiKR46vSRCk3miBClVS0iBEG0dOUPUupazSTPxS3TSk9iDyYzfjTBzoPbwSGKZXpaXkztuoLuCnDieKJQW1yYqEmlZ3hHg/B0/n6tbjvKGdkd2TOcdsSy5dOJBT0SynBYSZfJyJqyNbAoOtCL9GpGC99nwrULycHCrSEZAJLWTQsi4PPgvOJhSvaaJ6MeJQ9y/thrCo7rgxieIaC/9uF5r5Cb7AV8=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44ef5d6c-979b-466e-3f7f-08d6f3c57559
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2019 08:17:52.0595
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Naohiro.Aota1@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4365
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/06/13 23:00, Josef Bacik wrote:=0A=
> On Fri, Jun 07, 2019 at 10:10:11PM +0900, Naohiro Aota wrote:=0A=
>> Direct write I/Os can be directed at existing extents that have already=
=0A=
>> been written. Such write requests are prohibited on host-managed zoned=
=0A=
>> block devices. So disable direct IO support for a volume with HMZONED mo=
de=0A=
>> enabled.=0A=
>>=0A=
> =0A=
> That's only if we're nocow, so seems like you only need to disable DIO in=
to=0A=
> nocow regions with hmzoned?  Thanks,=0A=
> =0A=
> Josef=0A=
> =0A=
=0A=
True. And actually, I had to disable or ignore BTRFS_INODE_NODATACOW on HMZ=
ONED.=0A=
I'll replace this patch with that one.=0A=
Thanks,=0A=
