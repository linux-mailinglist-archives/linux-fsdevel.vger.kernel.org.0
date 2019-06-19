Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7B34B63A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jun 2019 12:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731487AbfFSKdA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jun 2019 06:33:00 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:27955 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727129AbfFSKdA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jun 2019 06:33:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1560940378; x=1592476378;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=pALDkZ91TNN7rp7ey2gEvfmy3WUv1oru2cMqoKY0Nok=;
  b=nTaojNmk8aDzVoZ2wa2pxMQlAeagbSTmh7A+FLUIIxTZCY0L5vO+C1kA
   UBzNDVPUb58/Zfy1R/hlkl/V1RxRVizxw+7r+nHE+Xr1ooLV5W5BvAU85
   BQs5JA8hMVrLhzl0GNsR5Gvtb70E19YROOJIIp3fMayDdrsLscJHFgL90
   X2vj/Wq7pvn7LK+5g5jo8c1fU7uahLjPhA1GJV/lU+Ms2FlTYT/h8WPtk
   K4nP+UdY3aziAUVYOB7Zk7XX10AHps1hed1nzTbgASiNoh3IAKEJsU3zf
   YIPJBgSznmGS+x96drCs3iXIHyEeFhKN/DcGr0I8fzLxgMrVTU8wEk1uX
   w==;
X-IronPort-AV: E=Sophos;i="5.63,392,1557158400"; 
   d="scan'208";a="110941521"
Received: from mail-co1nam05lp2057.outbound.protection.outlook.com (HELO NAM05-CO1-obe.outbound.protection.outlook.com) ([104.47.48.57])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jun 2019 18:32:47 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8w3W9YUfJS/XGFOJYoHkKCIPP0KSaAXtRg8CqhxFcSE=;
 b=mIJbvkURI1CllsLAn1nJjju0bfrpESGcGFb557T5hufWzx6WpmdTAZX/27sIImEKEQgpVFfp4okD117J5HIellLivQmAibmEfG6U+alAR4Nff1me/RxPpy6G8DZ/2NN7ZDfc1EUBvDimJ0W65SM0fqN+VF/ekcU65VTXLUWagzY=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.58.207) by
 BYAPR04MB4999.namprd04.prod.outlook.com (52.135.233.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.17; Wed, 19 Jun 2019 10:32:45 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::e94e:8ead:40b1:fae6]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::e94e:8ead:40b1:fae6%7]) with mapi id 15.20.1987.014; Wed, 19 Jun 2019
 10:32:45 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>
CC:     Naohiro Aota <Naohiro.Aota@wdc.com>,
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
Date:   Wed, 19 Jun 2019 10:32:45 +0000
Message-ID: <BYAPR04MB5816E605CD62611D8AAE6CE3E7E50@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20190607131025.31996-1-naohiro.aota@wdc.com>
 <20190607131025.31996-12-naohiro.aota@wdc.com>
 <20190613141457.jws5ca63wfgjf7da@MacBook-Pro-91.local>
 <BYAPR04MB5816E9FC012A289CA438E794E7EB0@BYAPR04MB5816.namprd04.prod.outlook.com>
 <20190618133357.l55hwc3x5cpycpji@MacBook-Pro-91.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a51fc769-a31b-4c3a-f38c-08d6f4a177d3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB4999;
x-ms-traffictypediagnostic: BYAPR04MB4999:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB49993F8D3CEE7E224AE90FE6E7E50@BYAPR04MB4999.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0073BFEF03
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(376002)(136003)(366004)(346002)(199004)(189003)(8936002)(6116002)(71190400001)(102836004)(8676002)(256004)(6246003)(476003)(66066001)(2906002)(478600001)(316002)(86362001)(14444005)(81166006)(81156014)(486006)(33656002)(53936002)(55016002)(76176011)(186003)(7696005)(53546011)(54906003)(3846002)(14454004)(4326008)(446003)(99286004)(72206003)(26005)(71200400001)(229853002)(305945005)(66946007)(30864003)(6436002)(66446008)(6916009)(7736002)(5660300002)(25786009)(73956011)(74316002)(52536014)(66476007)(64756008)(76116006)(9686003)(7416002)(66556008)(68736007)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4999;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: HH0FVOJDxKGYIQtuf2kzifoF7VYio9B+NiHg3KW8FRkA5HleZWkyuOUAKsc5s8DydIYfhkG/TCFEo/m8bxHPGW+F++1aYbuaKVjHJrjWgfDMWAaaoRUcgnhhBTgBqXLufDU7evh5/FEX8jcZ2EXjkbBc+pudMXNK+CtNaqLo+kLQi4VuWlWqY0MdzgGZqJd9UEqOqVbT6LeMxGPI9XLzhLZgyahjg3LNBEO7i8r8peWmgMngO05lpqm+uIVsTquEHvCbcsdxMyT86/Hz9aoygnS7Io/RiAJP02Pv7YLY+6MR0mTA4I8hy1Kja6hBn5IwRM5u4Gnt8BFVRvtIXUx+7pX0lzi6nDLkUj52gkeB14XHJtXGD9C8i2ddJy1dl8K4woIE4sI25WM2kFAL024HAAYfAfTyZR2eQr/mIXmufnw=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a51fc769-a31b-4c3a-f38c-08d6f4a177d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2019 10:32:45.4456
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Damien.LeMoal@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4999
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/06/18 22:34, Josef Bacik wrote:=0A=
> On Mon, Jun 17, 2019 at 03:16:05AM +0000, Damien Le Moal wrote:=0A=
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
>>=0A=
> =0A=
> This sounds like we're depending on specific behavior from the ioschedule=
r,=0A=
> which means we're going to have a sad day at some point in the future.=0A=
=0A=
In a sense yes, we are. But my team and I always make sure that such sad da=
y do=0A=
not come. We are always making sure that HM-zoned drives can be used and wo=
rk as=0A=
expected (all RCs and stable versions are tested weekly). For now, getting=
=0A=
guarantees on write requests order mandates the use of the mq-deadline sche=
duler=0A=
as it is currently the only one providing these guarantees. I just sent a p=
atch=0A=
to ensure that this scheduler is always available with CONFIG_BLK_DEV_ZONED=
=0A=
enabled (see commit b9aef63aca77 "block: force select mq-deadline for zoned=
=0A=
block devices") and automatically configuring it for HM zoned devices is si=
mply=0A=
a matter of adding an udev rule to the system (mq-deadline is the default=
=0A=
scheduler for spinning rust anyway).=0A=
=0A=
>> The other problem is that the mq-deadline scheduler does not track zone =
WP=0A=
>> position. Write request issuing is done regardless of the current WP val=
ue,=0A=
>> solely based on LBA ordering. This means that mq-deadline will not preve=
nt=0A=
>> out-of-order, or rather, unaligned write requests. These will not be det=
ected=0A=
>> and dispatched whenever possible. The reasons for this are that:=0A=
>> 1) the disk user (the FS) has to manage zone WP positions anyway. So dup=
licating=0A=
>> that management at the block IO scheduler level is inefficient.=0A=
> =0A=
> I'm not saying it has to manage the WP pointer, and in fact I'm not sayin=
g the=0A=
> scheduler has to do anything at all.  We just need a more generic way to =
make=0A=
> sure that bio's submitted in order are kept in order.  So perhaps a hmzon=
ed=0A=
> scheduler that does just that, and is pinned for these devices.=0A=
=0A=
This is exactly what mq-deadline does for HM devices: it guarantees that wr=
ite=0A=
bio order submission is kept as is for request dispatching to the disk. The=
 only=0A=
missing part is "pinned for these devices". This is not possible now. A use=
r can=0A=
still change the scheduler to say BFQ. But in that case, unaligned write er=
rors=0A=
will show up very quickly. So this is easy to debug. Not ideal I agree, but=
 that=0A=
can be fixed independently of BtrFS support for hmzoned disks.=0A=
=0A=
>> 2) Adding zone WP management at the block IO scheduler level would also =
need a=0A=
>> write error processing path to resync the WP value in case of failed wri=
tes. But=0A=
>> the user/FS also needs that anyway. Again duplicated functionalities.=0A=
> =0A=
> Again, no not really.  My point is I want as little block layer knowledge=
 in=0A=
> btrfs as possible.  I accept we should probably keep track of the WP, it =
just=0A=
> makes it easier on everybody if we allocate sequentially.  I'll even allo=
w that=0A=
> we need to handle the write errors and adjust our WP stuff internally whe=
n=0A=
> things go wrong.=0A=
> =0A=
> What I'm having a hard time swallowing is having a io scheduler in btrfs =
proper.=0A=
> We just ripped out the old one we had because it broke cgroups.  It just =
adds=0A=
> extra complexity to an already complex mess.=0A=
=0A=
I understand your point. It makes perfect sense. The "IO scheduler" added f=
or=0A=
hmzoned case is only the method proposed to implement sequential write issu=
ing=0A=
guarantees. The sequential allocation was relatively easy to achieve, but w=
hat=0A=
is really needed is an atomic "sequential alloc blocks + issue write BIO fo=
r=0A=
these blocks" so that the block IO schedulker sees sequential write streams=
 per=0A=
zone. If only the sequential allocation is achieved, write bios serving the=
se=0A=
blocks may be reordered at the FS level and result in write failures since =
the=0A=
block layer scheduler only guarantees preserving the order without any=0A=
reordering guarantees for unaligned writes.=0A=
=0A=
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
> =0A=
> Again we could just pin the hmzoned scheduler to those devices so you can=
't=0A=
> switch them.  Or make a hmzoned blk plug and pin no scheduler to these de=
vices.=0A=
=0A=
That is not enough. Pinning the schedulers or using the plugs cannot guaran=
tee=0A=
that write requests issued out of order will always be correctly reordered.=
 Even=0A=
worse, we cannot implement this. For multiple reason as I stated before.=0A=
=0A=
One example that may illustrates this more easily is this: imagine a user d=
oing=0A=
buffered I/Os to an hm disk (e.g. dd if=3D/dev/zero of=3D/dev/sdX). The fir=
st part=0A=
of this execution, that is, allocate a free page, copy the user data and ad=
d the=0A=
page to the page cache as dirty, is in fact equivalent to an FS sequential =
block=0A=
allocation (the dirty pages are allocated in offset order and added to  the=
 page=0A=
cache in that same order).=0A=
=0A=
Most of the time, this will work just fine because the page cache dirty pag=
e=0A=
writeback code is mostly sequential. Dirty pages for an inode are found in=
=0A=
offset order, packed into write bios and issued sequentially. But start put=
ting=0A=
memory pressure on the system, or executing "sync" or other applications in=
=0A=
parallel, and you will start seeing unaligned write errors because the page=
=0A=
cache atomicity is per page so different contexts may end up grabbing dirty=
=0A=
pages in order (as expected) but issuing interleaved write bios out of orde=
r.=0A=
And this type of problem *cannot* be handled in the block layer (plug or=0A=
scheduler) because stopping execution of a bio expecting that another bio w=
ill=0A=
come is very dangerous as there are no guarantees that such bio will ever b=
e=0A=
issued. In the case of the page cache flush, this is actually a real eventu=
ality=0A=
as memory allocation needed for issuing a bio may depend on the completion =
of=0A=
already issued bios, and if we cannot dispatch those, then we can deadlock.=
=0A=
=0A=
This is an extreme example. This is unlikely but still a real possibility.=
=0A=
Similarly to your position, that is, the FS should not know anything about =
the=0A=
block layer, the block layer position is that it cannot rely on a specific=
=0A=
behavior from the upper layers. Essentially, all bios are independent and=
=0A=
treated as such.=0A=
=0A=
For HM devices, we needed sequential write guarantees, but could not break =
the=0A=
independence of write requests. So what we did is simply guarantee that the=
=0A=
dispatch order is preserved from the issuing order, nothing else. There is =
no=0A=
"buffering" possible and no checks regarding the sequentiality of writes.=
=0A=
=0A=
As a result, the sequential write constraint of the disks is directly expos=
ed to=0A=
the disk user (FS or DM).=0A=
=0A=
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
>>=0A=
> =0A=
> So we're duplicating this effort in 2 places already and adding a 3rd pla=
ce=0A=
> seems like a solid plan?  Device-mapper it makes sense, we're sitting squ=
arely=0A=
> in the block layer so moving around bio's/requests is its very reason for=
=0A=
> existing.  I'm not sold on the file system needing to take up this behavi=
or.=0A=
> This needs to be handled in a more generic way so that all file systems c=
an=0A=
> share the same mechanism.=0A=
=0A=
I understand your point. But I am afraid it is not easily possible. The rea=
son=0A=
is that for an FS, to achieve sequential write streams in zones, one need a=
n=0A=
atomic (or serialized) execution of "block allocation + wrtite bio issuing"=
.=0A=
Both combined achieve a sequential write stream that mq-deadline will prese=
rve=0A=
and everything will work as intended. This is obviously not easily possible=
 in a=0A=
generic manner for all FSes. In f2fs, this was rather easy to do without=0A=
changing a lot of code by simply using a mutex to have the 2 operations=0A=
atomically executed without any noticeable performance impact. A similar me=
thod=0A=
in BtrFS is not possible because of async checksum and async compression wh=
ich=0A=
can result in btrfs_map_bio() execution in an order that is different from =
the=0A=
extent allocation order.=0A=
=0A=
> =0A=
> I'd even go so far as to say that you could just require using a dm devic=
e with=0A=
> these hmzoned block devices and then handle all of that logic in there if=
 you=0A=
> didn't feel like doing it generically.  We're already talking about esote=
ric=0A=
> devices that require special care to use, adding the extra requirement of=
=0A=
> needing to go through device-mapper to use it wouldn't be that big of a s=
tretch.=0A=
=0A=
HM drives are not so "esoteric" anymore. Entire data centers are starting=
=0A=
running on them. And getting BtrFS to work natively on HM drives would be a=
 huge=0A=
step toward facilitating their use, and remove this "esoteric" label :)=0A=
=0A=
Back to your point, using a dm to do the reordering is possible, but requir=
es=0A=
temporary persistent backup of the out-of-order BIOs due to the reasons poi=
nted=0A=
out above (dependency of memory allocation failure/success on bio completio=
n).=0A=
This is basically what dm-zoned does, using conventional zones to store=0A=
out-of-order writes in conventional zones. Such generic DM is enough to run=
 any=0A=
file system (ext4 or XFS run perfectly fine on dm-zoned), but come at the c=
ost=0A=
of needing garbage collection with a huge impact on performance. The simple=
=0A=
addition of Naohiro's write bio ordering feature in BtrFS avoids all this a=
nd=0A=
preserves performance. I really understand your desire to reduce complexity=
. But=0A=
in the end, this is only a "sorted list" that is well controlled within btr=
fs=0A=
itself and avoids dependency on the behavior of other components beside the=
=0A=
block IO scheduler.=0A=
=0A=
We could envision to make such feature generic, implementing it as a block =
layer=0A=
object. But its use would still be needed in btrfs. Since f2fs and dm-zoned=
 do=0A=
not require it, btrfs would be the sole user though, so for now at least, t=
his=0A=
generic implementation has I think little value. We can work on trying to=
=0A=
isolate this bio reordering code more so  that it is easier to remove and u=
se a=0A=
future generic implementation. Would that help in addressing your concerns =
?=0A=
=0A=
Thank you for your comments.=0A=
=0A=
Best regards.=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
