Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1D18497E6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jun 2019 06:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725934AbfFREEP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jun 2019 00:04:15 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:20105 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbfFREEP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jun 2019 00:04:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1560830655; x=1592366655;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=SCVXW3KeDxoNe7tLG4QIktUBSGECiO/3dZ3kkKz/khM=;
  b=iiVLTufcZO1AMDsdLAsSXsSEMvjFWQFdo68O/2XyT0HVn/THzk0JTTkj
   C0ES0trpDfULscsmBa9GHl1kYOsunPU8vaQC9KBwuQ8j56YHWVj702CaH
   7udv44bZaefu+/A6WeDX6pfbq6qNKuo/xV3eP0isTGEy5HahqV/KbHCK9
   wVPl3IROXJzd8ZFodfhsVqSnHvKO890rqJqU+VXUozx2/ZDvEdyIAPa8z
   fVTZ1BXDBtVoNc7MZRve679vqsOrwkJL0w/AHNRNz1I1pT78UX1MdPg9F
   FuyspT0ZRhvil1wwvTVZcK5t32IarekoM3en5VDqChFrM1ZcusKk3Uur+
   w==;
X-IronPort-AV: E=Sophos;i="5.63,387,1557158400"; 
   d="scan'208";a="112466183"
Received: from mail-dm3nam05lp2058.outbound.protection.outlook.com (HELO NAM05-DM3-obe.outbound.protection.outlook.com) ([104.47.49.58])
  by ob1.hgst.iphmx.com with ESMTP; 18 Jun 2019 12:04:03 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jxyvuF/PZGyuS7rqHu2Uyl+HbB6Rqt0liXUTCZM6zEQ=;
 b=KOeM/EfFMZnb+ul8dSVP8X+ofMeErYnS4TRZThSkQfp3AR4wp3Q6H62g32zpqCOcjwudYo4KVvNpnTNEvgy5lFgA1b9VkA2HwM4yk/sb0jdtnnD5ZrT8JxNYPGIZTFZoblmEF+ay2QVbRiU2KOAqCiu5y9Fqp/ssFWNXHU83hS8=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.58.207) by
 BYAPR04MB5751.namprd04.prod.outlook.com (20.179.58.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.10; Tue, 18 Jun 2019 04:04:00 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::e94e:8ead:40b1:fae6]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::e94e:8ead:40b1:fae6%7]) with mapi id 15.20.1987.014; Tue, 18 Jun 2019
 04:04:00 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>
CC:     Josef Bacik <josef@toxicpanda.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
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
Date:   Tue, 18 Jun 2019 04:04:00 +0000
Message-ID: <BYAPR04MB58162A90A963BF9CE59BFA8DE7EA0@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20190607131025.31996-1-naohiro.aota@wdc.com>
 <20190607131025.31996-12-naohiro.aota@wdc.com>
 <20190613141457.jws5ca63wfgjf7da@MacBook-Pro-91.local>
 <BYAPR04MB5816E9FC012A289CA438E794E7EB0@BYAPR04MB5816.namprd04.prod.outlook.com>
 <20190618000020.GK19057@twin.jikos.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2c7343d2-921a-4eab-a93e-08d6f3a1fe99
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB5751;
x-ms-traffictypediagnostic: BYAPR04MB5751:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB575110C56AD6B093CB13E37BE7EA0@BYAPR04MB5751.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 007271867D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(376002)(366004)(396003)(39860400002)(52084003)(54534003)(189003)(199004)(76176011)(7696005)(81166006)(7736002)(76116006)(9686003)(4326008)(53936002)(73956011)(66476007)(2906002)(305945005)(7416002)(26005)(99286004)(256004)(55016002)(66946007)(186003)(52536014)(64756008)(66556008)(6246003)(66446008)(3846002)(66066001)(6436002)(71200400001)(71190400001)(102836004)(54906003)(2351001)(478600001)(316002)(81156014)(486006)(25786009)(86362001)(68736007)(5640700003)(53546011)(14454004)(1730700003)(229853002)(74316002)(2501003)(6116002)(476003)(446003)(8676002)(6916009)(33656002)(5660300002)(8936002)(14444005)(6506007)(72206003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5751;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ojS8OtEMSwR/DpbTj1kifOKttmiQf0ZB3V5a07u2Gxd+e4gvSVV/8HSpmjKYMrApx1/all0NGBH4C8gkyYq+umkknbFCNXZvpWdJ+Z4JMgN3w6HUjl89EGx+DKDSxIOT+6t8tSiLRjIV+uo8Heio9vbzyUY/cnyEX/072AJ3KmdHFM/oOqVJwAeNkSypPIgJDrBNrTNa7XXYjUPuWMakfTm3FWLdYp5liGsnMYlTr1fAsUJ7xE3OJYV0EwiHg4uKLTOz5PAOizf2H6WZy7MLZ7VTgIna0UjOfH4OfkSwxhW/iDD1I6fLnBWt3kSKM0FC/J9L5YCZvaYtPY2pSN8pXaLJb1jFU9leP2mLMhU74U8PHw9w6VnPezuh74yj82ctm0SOyFQT6zo+J4OoAd3yTiI021Twk2YnwMcORW0Una4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c7343d2-921a-4eab-a93e-08d6f3a1fe99
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2019 04:04:00.3852
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Damien.LeMoal@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5751
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

David,=0A=
=0A=
On 2019/06/18 8:59, David Sterba wrote:=0A=
> On Mon, Jun 17, 2019 at 03:16:05AM +0000, Damien Le Moal wrote:=0A=
>> Josef,=0A=
>>=0A=
>> On 2019/06/13 23:15, Josef Bacik wrote:=0A=
>>> On Fri, Jun 07, 2019 at 10:10:17PM +0900, Naohiro Aota wrote:=0A=
>>>> Sequential allocation is not enough to maintain sequential delivery of=
=0A=
>>>> write IOs to the device. Various features (async compress, async check=
sum,=0A=
>>>> ...) of btrfs affect ordering of the IOs. This patch introduces submit=
=0A=
>>>> buffer to sort WRITE bios belonging to a block group and sort them out=
=0A=
>>>> sequentially in increasing block address to achieve sequential write=
=0A=
>>>> sequences with __btrfs_map_bio().=0A=
>>>>=0A=
>>>> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>=0A=
>>>=0A=
>>> I hate everything about this.  Can't we just use the plugging infrastru=
cture for=0A=
>>> this and then make sure it re-orders the bios before submitting them?  =
Also=0A=
>>> what's to prevent the block layer scheduler from re-arranging these io'=
s?=0A=
>>> Thanks,=0A=
>>=0A=
>> The block I/O scheduler reorders requests in LBA order, but that happens=
 for a=0A=
>> newly inserted request against pending requests. If there are no pending=
=0A=
>> requests because all requests were already issued, no ordering happen, a=
nd even=0A=
>> worse, if the drive queue is not full yet (e.g. there are free tags), th=
en the=0A=
>> newly inserted request will be dispatched almost immediately, preventing=
=0A=
>> reordering with subsequent incoming write requests to happen.=0A=
> =0A=
> This would be good to add to the changelog.=0A=
=0A=
Sure. No problem. We can add that explanation.=0A=
=0A=
>> The other problem is that the mq-deadline scheduler does not track zone =
WP=0A=
>> position. Write request issuing is done regardless of the current WP val=
ue,=0A=
>> solely based on LBA ordering. This means that mq-deadline will not preve=
nt=0A=
>> out-of-order, or rather, unaligned write requests.=0A=
> =0A=
> This seems to be the key point.=0A=
=0A=
Yes it is. We can also add this to the commit message explanation.=0A=
=0A=
>> These will not be detected=0A=
>> and dispatched whenever possible. The reasons for this are that:=0A=
>> 1) the disk user (the FS) has to manage zone WP positions anyway. So dup=
licating=0A=
>> that management at the block IO scheduler level is inefficient.=0A=
>> 2) Adding zone WP management at the block IO scheduler level would also =
need a=0A=
>> write error processing path to resync the WP value in case of failed wri=
tes. But=0A=
>> the user/FS also needs that anyway. Again duplicated functionalities.=0A=
>> 3) The block layer will need a timeout to force issue or cancel pending=
=0A=
>> unaligned write requests. This is necessary in case the drive user stops=
 issuing=0A=
>> writes (for whatever reasons) or the scheduler is being switched. This w=
ould=0A=
>> unnecessarily cause write I/O errors or cause deadlocks if the request q=
ueue=0A=
>> quiesce mode is entered at the wrong time (and I do not see a good way t=
o deal=0A=
>> with that).=0A=
>>=0A=
>> blk-mq is already complicated enough. Adding this to the block IO schedu=
ler will=0A=
>> unnecessarily complicate things further for no real benefits. I would li=
ke to=0A=
>> point out the dm-zoned device mapper and f2fs which are both already dea=
ling=0A=
>> with write ordering and write error processing directly. Both are fairly=
=0A=
>> straightforward but completely different and each optimized for their ow=
n structure.=0A=
> =0A=
> So the question is where on which layer the decision logic is. The=0A=
> filesystem(s) or dm-zoned have enough information about the zones and=0A=
> the writes can be pre-sorted. This is what the patch proposes.=0A=
=0A=
Yes, exactly.=0A=
=0A=
> From your explanation I get that the io scheduler can throw the wrench=0A=
> in the sequential ordering, for various reasons depending on state of=0A=
> internal structures od device queues. This is my simplified=0A=
> interpretation as I don't understand all the magic below filesystem=0A=
> layer.=0A=
=0A=
Not exactly "throw the wrench". mq-deadline will guarantee per zone write o=
rder=0A=
to be exactly the order in which requests were inserted, that is, issued by=
 the=0A=
FS. But mq-dealine will not "wait" if the write order is not purely sequent=
ial,=0A=
that is, there are holes/jumps in the LBA sequence for the zone. Order only=
 is=0A=
guaranteed. The alignment to WP/contiguous sequential write issuing is the=
=0A=
responsibility of the issuer (FS or DM or application in the case of raw ac=
cesses).=0A=
=0A=
> I assume there are some guarantees about the ordering, eg. within one=0A=
> plug, that apply to all schedulers (maybe not the noop one). Something=0A=
> like that should be the least common functionality that the filesystem=0A=
> layer can rely on.=0A=
=0A=
The insertion side of the scheduler (upper level from FS to scheduler), whi=
ch=0A=
include the per CPU software queues and plug control, will not reorder requ=
ests.=0A=
However, the dispatch side (lower level, from scheduler to HBA driver) can =
cause=0A=
reordering. This is what mq-deadline prevents using a per zone write lock t=
o=0A=
avoid reordering of write requests per zone by allowing only a single write=
=0A=
request per zone to be dispatched to the device at any time. Overall order =
is=0A=
not guaranteed, nor is read request order. But per zone write requests will=
 not=0A=
be reordered.=0A=
=0A=
But again, this is only ordering. Nothing to do with trying to achieve a pu=
rely=0A=
sequential write stream per zone. This is the responsibility of the issuer =
to=0A=
deliver write request per zone without any gap, all requests sequential in =
LBA=0A=
within each zone. Overall, the stream of request does not have to be sequen=
tial,=0A=
e.g. if multiple zones are being written at the same time. But per zones, w=
rite=0A=
requests must be sequential.=0A=
=0A=
>> Naohiro changes to btrfs IO scheduler have the same intent, that is, eff=
iciently=0A=
>> integrate and handle write ordering "a la btrfs". Would creating a diffe=
rent=0A=
>> "hmzoned" btrfs IO scheduler help address your concerns ?=0A=
> =0A=
> IMHO this sounds both the same, all we care about is the sequential=0A=
> ordering, which in some sense is "scheduling", but I would not call it=0A=
> that way due to the simplicity.=0A=
=0A=
OK. And yes, it is only ordering of writes per zone. For all other requests=
,=0A=
e.g. reads, order does not matter. And the overall interleaving of write=0A=
requests to different zones can also be anything. No constraints there.=0A=
=0A=
> As implemented, it's a list of bios, but I'd suggest using rb-tree or=0A=
> xarray, the insertion is fast and submission is start to end traversal.=
=0A=
> I'm not sure that the loop in __btrfs_map_bio_zoned after label=0A=
> send_bios: has reasonable complexity, looks like an O(N^2).=0A=
=0A=
OK. We can change that. rbtree is simple enough to use. We can change the l=
ist=0A=
to that.=0A=
=0A=
Thank you for your comments.=0A=
=0A=
Best regards.=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
