Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70EB147895
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2019 05:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbfFQDQO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 16 Jun 2019 23:16:14 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:3215 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727383AbfFQDQO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 16 Jun 2019 23:16:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1560741374; x=1592277374;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=CrXKPsAMdScfC9QEoBLnj9DSSqXoXky9HKTeSrXgxpE=;
  b=AHY+PkYR29tXQVhEWQHJQCjZTBib47dWTpyylquJmCD4QSXJC+M9QlJW
   7VKX8K+LOa86mIm4NyD2pO6hPMnCfO5pnkOoO59a4LNYjRpOZbJAORAXD
   rDFOGxQGYuE3DWNVNTT5tUmwNmhzi9vTvQbJonuPrfmoeT55pwAa59JLK
   GKe8PM0s3N7eYT0+cOX8FphRpVgxjC3CIAiMa3podTN5PMj9LNCLekvne
   A/v4jxVMK7D6eE7Mt/i3ttOdge+A0U/EMiQ+itSlLe8UzZeODasJwSCIu
   7InNYPXmWdjlW/mY5bfINvUrtdt4ctNQ6wYU6QYgdE6TP+M0lOT002D70
   Q==;
X-IronPort-AV: E=Sophos;i="5.63,383,1557158400"; 
   d="scan'208";a="110705567"
Received: from mail-sn1nam01lp2051.outbound.protection.outlook.com (HELO NAM01-SN1-obe.outbound.protection.outlook.com) ([104.47.32.51])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jun 2019 11:16:07 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iLuszdpRLoQma80gnykj4WlU3EBYT2u1117mFYOHA20=;
 b=E+9cppGNtEGQ+EV+b08ps5v7V6ESbJU6ECzh9IYjkz+IqmzfnmVHOwnMWC1D2GmNCucgKTboLrKM5hllCYHZXQafjM2fAEr9rutn/mTZWmBKPhkHZfua5EkLEzn7t900S/t+e5rONe8KRNyVu1DyNrEeOanz5J1L/EXHuw+mV/Q=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.58.207) by
 BYAPR04MB5991.namprd04.prod.outlook.com (20.178.233.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.12; Mon, 17 Jun 2019 03:16:06 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::d090:297a:d6ae:e757]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::d090:297a:d6ae:e757%4]) with mapi id 15.20.1965.018; Mon, 17 Jun 2019
 03:16:06 +0000
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
Subject: Re: [PATCH 11/19] btrfs: introduce submit buffer
Thread-Topic: [PATCH 11/19] btrfs: introduce submit buffer
Thread-Index: AQHVHTKKjg778rmXIkyNFIGQA7/Xbg==
Date:   Mon, 17 Jun 2019 03:16:05 +0000
Message-ID: <BYAPR04MB5816E9FC012A289CA438E794E7EB0@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20190607131025.31996-1-naohiro.aota@wdc.com>
 <20190607131025.31996-12-naohiro.aota@wdc.com>
 <20190613141457.jws5ca63wfgjf7da@MacBook-Pro-91.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 45f42baf-75ad-4e76-7f31-08d6f2d222cd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB5991;
x-ms-traffictypediagnostic: BYAPR04MB5991:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB59915EDB8C8669899A10A945E7EB0@BYAPR04MB5991.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0071BFA85B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(376002)(396003)(136003)(366004)(199004)(189003)(6246003)(66946007)(66446008)(52536014)(53936002)(54906003)(102836004)(99286004)(478600001)(33656002)(110136005)(14454004)(256004)(74316002)(55016002)(6506007)(9686003)(26005)(446003)(72206003)(2906002)(305945005)(76176011)(316002)(186003)(6116002)(7696005)(476003)(66066001)(5660300002)(81166006)(7736002)(7416002)(229853002)(14444005)(3846002)(6436002)(68736007)(53546011)(8676002)(73956011)(64756008)(66476007)(6636002)(81156014)(66556008)(76116006)(4326008)(486006)(71200400001)(25786009)(8936002)(71190400001)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5991;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vCA6NlQZpox7jOFv1HRt+6UlcVhi8lpmTc/bJ0cromuq11JXK2nha6CzXY/1prqHCXzM+A5X1PqcQemyCkeGIu8enPAaAkGkKyQ8xeGgNPvzI7waoNmVu46dzgawwokR/IBM2umq5+PVqqxl17oRLQF6o08uc1SWukQpNiHmEZLQZT+ZG/0dBcsDWDZFSujSQL4t3k1QVjaFAXbJxsS7EnwiD3jzFe0fbIV+zSYFIqZWyYorj4ZlReZXAwMjdX3pFs8tX8yIp4I6MRf+WbsvgkGQ2oFYkIVxmdTTUY6bqt115l3/vk9LSfg6FU355a+WEIy7rvGYjyDx+jeTs9WGJ6s6s85LFSUXHkgZnRmQxfgoDpvBy5ss7nkEl5KJU4qclUlAMgIUMVCrtQYnoXlH5/mWx4OdiD6Q+xzV6GxXgc4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45f42baf-75ad-4e76-7f31-08d6f2d222cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2019 03:16:05.8391
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Damien.LeMoal@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5991
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Josef,=0A=
=0A=
On 2019/06/13 23:15, Josef Bacik wrote:=0A=
> On Fri, Jun 07, 2019 at 10:10:17PM +0900, Naohiro Aota wrote:=0A=
>> Sequential allocation is not enough to maintain sequential delivery of=
=0A=
>> write IOs to the device. Various features (async compress, async checksu=
m,=0A=
>> ...) of btrfs affect ordering of the IOs. This patch introduces submit=
=0A=
>> buffer to sort WRITE bios belonging to a block group and sort them out=
=0A=
>> sequentially in increasing block address to achieve sequential write=0A=
>> sequences with __btrfs_map_bio().=0A=
>>=0A=
>> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>=0A=
> =0A=
> I hate everything about this.  Can't we just use the plugging infrastruct=
ure for=0A=
> this and then make sure it re-orders the bios before submitting them?  Al=
so=0A=
> what's to prevent the block layer scheduler from re-arranging these io's?=
=0A=
> Thanks,=0A=
=0A=
The block I/O scheduler reorders requests in LBA order, but that happens fo=
r a=0A=
newly inserted request against pending requests. If there are no pending=0A=
requests because all requests were already issued, no ordering happen, and =
even=0A=
worse, if the drive queue is not full yet (e.g. there are free tags), then =
the=0A=
newly inserted request will be dispatched almost immediately, preventing=0A=
reordering with subsequent incoming write requests to happen.=0A=
=0A=
The other problem is that the mq-deadline scheduler does not track zone WP=
=0A=
position. Write request issuing is done regardless of the current WP value,=
=0A=
solely based on LBA ordering. This means that mq-deadline will not prevent=
=0A=
out-of-order, or rather, unaligned write requests. These will not be detect=
ed=0A=
and dispatched whenever possible. The reasons for this are that:=0A=
1) the disk user (the FS) has to manage zone WP positions anyway. So duplic=
ating=0A=
that management at the block IO scheduler level is inefficient.=0A=
2) Adding zone WP management at the block IO scheduler level would also nee=
d a=0A=
write error processing path to resync the WP value in case of failed writes=
. But=0A=
the user/FS also needs that anyway. Again duplicated functionalities.=0A=
3) The block layer will need a timeout to force issue or cancel pending=0A=
unaligned write requests. This is necessary in case the drive user stops is=
suing=0A=
writes (for whatever reasons) or the scheduler is being switched. This woul=
d=0A=
unnecessarily cause write I/O errors or cause deadlocks if the request queu=
e=0A=
quiesce mode is entered at the wrong time (and I do not see a good way to d=
eal=0A=
with that).=0A=
=0A=
blk-mq is already complicated enough. Adding this to the block IO scheduler=
 will=0A=
unnecessarily complicate things further for no real benefits. I would like =
to=0A=
point out the dm-zoned device mapper and f2fs which are both already dealin=
g=0A=
with write ordering and write error processing directly. Both are fairly=0A=
straightforward but completely different and each optimized for their own s=
tructure.=0A=
=0A=
Naohiro changes to btrfs IO scheduler have the same intent, that is, effici=
ently=0A=
integrate and handle write ordering "a la btrfs". Would creating a differen=
t=0A=
"hmzoned" btrfs IO scheduler help address your concerns ?=0A=
=0A=
Best regards.=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
