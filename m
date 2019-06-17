Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08F1447899
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2019 05:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbfFQDTN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 16 Jun 2019 23:19:13 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:4430 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727383AbfFQDTN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 16 Jun 2019 23:19:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1560741552; x=1592277552;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=83c7DmHWdGCQdYsUcr3GMDaxUdVq1wOVner+tJ0hhrM=;
  b=m/xMF01QsBroF0hvkjrW7VtUnlw8cIrMXECe4TlhDRyWBQynzt1hoJsb
   X3KL7jXc/P/eRTbtQLK9imRy9HUk6sLZ6OTJEGsfMXd5OJWmba9lF6ZQ0
   Vq+Ts0/q6f6NGm7IClntNNLWxWd8FFCTpCPv3Uzq+giKaMPupXbfWXLnX
   FcOaNOL+Bbfmayw5Qddf3+9+8U7ePe/tC6WWIx2oaGOjZuYFoK23f7sFs
   EpMFMLgG52tEam7yN2NV3aECZbKSRuwzkS5PRXRwgqelAAZqR42c3YQDu
   HQX3pkYfHIPHys9PqwUsEszXehOTqOQ/vFqvknG5WzIonyrbpKqO2uLye
   A==;
X-IronPort-AV: E=Sophos;i="5.63,383,1557158400"; 
   d="scan'208";a="112368754"
Received: from mail-co1nam05lp2055.outbound.protection.outlook.com (HELO NAM05-CO1-obe.outbound.protection.outlook.com) ([104.47.48.55])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jun 2019 11:19:12 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XXRU3OIUR1Iq4Ff/qMgYnjzKjHT9Ti2qKIyweLj4uhQ=;
 b=lXXluEGIljh+Vq0thlJznrtDkksfQK/DAYH8OszD8G8BJZo0WrlGgaLs/tJ4KsiMElCRjlk4RQgNIY6NXjNBmKIMbfc1lBSUCCCk67p2DJ3Eerqo6XszSz69RxWJfQeI9LPvHHE2eS37j3eEZ9cYHxkeB52afjxTW4W0XNL9oDc=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.58.207) by
 BYAPR04MB5238.namprd04.prod.outlook.com (20.178.48.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.13; Mon, 17 Jun 2019 03:19:10 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::d090:297a:d6ae:e757]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::d090:297a:d6ae:e757%4]) with mapi id 15.20.1965.018; Mon, 17 Jun 2019
 03:19:10 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Qu Wenruo <wqu@suse.com>, Nikolay Borisov <nborisov@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hannes Reinecke <hare@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        =?iso-8859-1?Q?Matias_Bj=F8rling?= <mb@lightnvm.io>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH 12/19] btrfs: expire submit buffer on timeout
Thread-Topic: [PATCH 12/19] btrfs: expire submit buffer on timeout
Thread-Index: AQHVHTKNw7/mCQKsqka4kbTmHgZhiA==
Date:   Mon, 17 Jun 2019 03:19:10 +0000
Message-ID: <BYAPR04MB5816CFF901A5BF10A2E51A52E7EB0@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20190607131025.31996-1-naohiro.aota@wdc.com>
 <20190607131025.31996-13-naohiro.aota@wdc.com>
 <20190613141548.vlczaxiqqzbxgtzk@MacBook-Pro-91.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7e6c63a2-6e30-4828-96a2-08d6f2d290ec
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB5238;
x-ms-traffictypediagnostic: BYAPR04MB5238:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB523823A5D129F41A850BA9C2E7EB0@BYAPR04MB5238.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0071BFA85B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(136003)(376002)(366004)(39860400002)(199004)(189003)(256004)(72206003)(6506007)(3846002)(8676002)(81156014)(7416002)(305945005)(53936002)(7696005)(81166006)(66066001)(6636002)(86362001)(4744005)(66476007)(68736007)(71190400001)(71200400001)(14444005)(9686003)(229853002)(76176011)(478600001)(6436002)(446003)(6116002)(55016002)(486006)(52536014)(476003)(54906003)(64756008)(316002)(14454004)(5660300002)(4326008)(6246003)(110136005)(2906002)(66446008)(25786009)(76116006)(26005)(73956011)(186003)(99286004)(7736002)(8936002)(33656002)(66556008)(102836004)(66946007)(74316002)(53546011);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5238;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0cOIhPQh1+3AK4r7RkKNqA5ybHVRY6xYvDc5uVJDdsoIjOoQ0UuLAxQpnmfeZ31khiYKP7RdkyxiBwMYlWvWjP63NIAE8/ljra0KgDlBZs545vVzt22LY6t779Haqe5ugeR+ym3n77R0mAhJijb72ySvBU53rR6/y+eEVn46ov4mEom0+8EilGvSwj3cu0cABSIZp7qfphc+5HZrZI8dXGvN6YpSSTXaoNW6QqHSY320yBJ1mwpz+IBKmwiBTu44Fr00GfqTurSOWNz1wxhl5vwBwrqIxBA0JNoo6V6aChFIrfCoM/+WnupS0h5PvlcoJZ1wu5o9GIs1tc84mCNC3D1mlNvho8HXszcAyJKFrAz6UkUWXCnSsgKjHKUAWuA1ecXenPDax6PSN0PLA8fS0h3pJ6DENm/WFW0GkRvsw1g=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e6c63a2-6e30-4828-96a2-08d6f2d290ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2019 03:19:10.6063
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Damien.LeMoal@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5238
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/06/13 23:15, Josef Bacik wrote:=0A=
> On Fri, Jun 07, 2019 at 10:10:18PM +0900, Naohiro Aota wrote:=0A=
>> It is possible to have bios stalled in the submit buffer due to some bug=
 or=0A=
>> device problem. In such situation, btrfs stops working waiting for buffe=
red=0A=
>> bios completions. To avoid such hang, add a worker that will cancel the=
=0A=
>> stalled bios after a timeout.=0A=
>>=0A=
> =0A=
> The block layer does this with it's request timeouts right?  So it'll tim=
eout=0A=
> and we'll get an EIO?  If that's not working then we need to fix the bloc=
k=0A=
> layer.  Thanks,=0A=
=0A=
Joseph,=0A=
=0A=
The block layer timeout is started only when the request is dispatched. The=
=0A=
timeout is not started on BIO/request allocation and so will not trigger fo=
r=0A=
bios stalled inside btrfs scheduler.=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
