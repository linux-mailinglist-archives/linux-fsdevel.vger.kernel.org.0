Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 788FEBE0AC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2019 16:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438255AbfIYO6J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Sep 2019 10:58:09 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:8796 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728575AbfIYO6I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Sep 2019 10:58:08 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8PEfe6G030198;
        Wed, 25 Sep 2019 07:57:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=Q6YZx+cNLo8QIs+sj0sS+JecN9PrgzOB+8KM/mQ2pNo=;
 b=ABjsPKjln44zoTDNZATt+6gU3mbYnOxJrZA4GeWtPuuPk9VPLCennEBBqr7DfzOYNuY/
 qqkrjAoOPVsg/aMk4yS1v8S5o1OiCUfBFw3m8mE0q+3jHTGI29BOjGWSMATddIolhUw4
 BbbJXWjInTUMJ9v5oTmPls3hZ2y4VMqg4zI= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2v7q74cwcw-15
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 25 Sep 2019 07:57:39 -0700
Received: from prn-mbx04.TheFacebook.com (2620:10d:c081:6::18) by
 prn-hub06.TheFacebook.com (2620:10d:c081:35::130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 25 Sep 2019 07:57:11 -0700
Received: from prn-hub03.TheFacebook.com (2620:10d:c081:35::127) by
 prn-mbx04.TheFacebook.com (2620:10d:c081:6::18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 25 Sep 2019 07:57:02 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Wed, 25 Sep 2019 07:57:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oCpWGyRaq3cT7MaLHvDKWSd8iyxpSpqR+EZMDoNzVxvfLJkgRQWcDZLhkklrHk1BFsBxHMXKY+qXxFACHD1jijM0nbRxrLzu/VVGE9TifoaPum36DmLuzgyT1xZJnbzGAu8d2DF/D8PZ9VMW+A2fvHVe/naxnuOgDwszTw0l5udAthVs3cSXWA7KuBJyKuNPMo4iJUbbBWECRs3L3sofsF6AZN610g+UTslgfMMA2b5zUdusc24jy5CkPnhJO0y2tZ4EnnVf8V9bzYufOz3aepXK4WMvZi71rL1b+vtdlAcp/JlJHdtCzH3+1WBWeryWVFavoRWO37p1jrgfPlIiVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q6YZx+cNLo8QIs+sj0sS+JecN9PrgzOB+8KM/mQ2pNo=;
 b=GpSedhn3FNkXjcF2QehuSYbRNpxQrOFpDC3CqHrExk0+vQGbMQ4yvRAwUx7aGqI/lZP/w45qIrKTKTyafX/OrB63Elrm6I79Kpmrex+T5ctpGr5iQemqR2f5q04YW2/kE1t4e/+KPE4ilkGOfNekKUqN1qsX7VrChIgIkIuVJ5c+0b/n1BWwdvQ93SBobk2rtsmzMDGkZqNyvWR1xLHZuLlQY4ITZnzipHg5H16/2UjBILUFAySFxeVt8LbBUTGuh3/FXRq6+XjhrBUcvUN5/Rz3knlR8U0PQJkTVSeB4ekR1eSwAtsnCDnnX7oPphii4jzl311obw/senjPvqKSYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q6YZx+cNLo8QIs+sj0sS+JecN9PrgzOB+8KM/mQ2pNo=;
 b=Fhf18WxVpHYJXSri+2NPKSo6JZ5XYPXUbLlM89Qqj3zy7Jd4xC4MNEoZ1AihCOYBwRktJ1xOpNRbW7m7A4UTxdMuH3LuO83POd6YUE4+5UaF9B8WO19zSCOm1yeuduIiT/et6oqlHl/8OIHw6hDX+EiHQY4+/r3tlkvzIWGSz5k=
Received: from DM5PR15MB1290.namprd15.prod.outlook.com (10.173.212.17) by
 DM5PR15MB1177.namprd15.prod.outlook.com (10.173.209.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.18; Wed, 25 Sep 2019 14:56:15 +0000
Received: from DM5PR15MB1290.namprd15.prod.outlook.com
 ([fe80::49e0:1c1c:5b16:8cc8]) by DM5PR15MB1290.namprd15.prod.outlook.com
 ([fe80::49e0:1c1c:5b16:8cc8%7]) with mapi id 15.20.2284.023; Wed, 25 Sep 2019
 14:56:15 +0000
From:   Chris Mason <clm@fb.com>
To:     Colin Walters <walters@verbum.org>
CC:     Dave Chinner <david@fromorbit.com>, Jann Horn <jannh@google.com>,
        "Omar Sandoval" <osandov@osandov.com>,
        Aleksa Sarai <cyphar@cyphar.com>, Jens Axboe <axboe@kernel.dk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "Andy Lutomirski" <luto@kernel.org>
Subject: Re: [RFC PATCH 2/3] add RWF_ENCODED for writing compressed data
Thread-Topic: [RFC PATCH 2/3] add RWF_ENCODED for writing compressed data
Thread-Index: AQHVc7FhwISisFCeRE+U/nwK1a+Utw==
Date:   Wed, 25 Sep 2019 14:56:15 +0000
Message-ID: <FF3F534F-B40D-4D7D-956B-F1B63C4751CC@fb.com>
References: <cover.1568875700.git.osandov@fb.com>
 <230a76e65372a8fb3ec62ce167d9322e5e342810.1568875700.git.osandov@fb.com>
 <CAG48ez2GKv15Uj6Wzv0sG5v2bXyrSaCtRTw5Ok_ovja_CiO_fQ@mail.gmail.com>
 <20190924171513.GA39872@vader> <20190924193513.GA45540@vader>
 <CAG48ez1NQBNR1XeVQYGoopEk=g_KedUr+7jxLQTaO+V8JCeweQ@mail.gmail.com>
 <20190925071129.GB804@dread.disaster.area>
 <60c48ac5-b215-44e1-a628-6145d84a4ce3@www.fastmail.com>
In-Reply-To: <60c48ac5-b215-44e1-a628-6145d84a4ce3@www.fastmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: MailMate (1.12.5r5635)
x-clientproxiedby: BL0PR02CA0016.namprd02.prod.outlook.com
 (2603:10b6:207:3c::29) To DM5PR15MB1290.namprd15.prod.outlook.com
 (2603:10b6:3:b8::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c091:480::b4ee]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e68d34ff-d512-4345-b67d-08d741c883c0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM5PR15MB1177;
x-ms-traffictypediagnostic: DM5PR15MB1177:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR15MB11775493BABC5AF6378F8E9AD3870@DM5PR15MB1177.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 01713B2841
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(136003)(39860400002)(396003)(346002)(199004)(189003)(4326008)(36756003)(14454004)(6116002)(7736002)(66556008)(7416002)(66476007)(478600001)(446003)(256004)(305945005)(52116002)(5660300002)(71190400001)(71200400001)(66946007)(25786009)(76176011)(6506007)(186003)(53546011)(386003)(2906002)(102836004)(486006)(476003)(2616005)(46003)(11346002)(81166006)(64756008)(33656002)(99286004)(14444005)(8676002)(81156014)(50226002)(8936002)(6436002)(86362001)(6486002)(229853002)(6512007)(66446008)(54906003)(316002)(6246003)(6916009);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR15MB1177;H:DM5PR15MB1290.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XZauVGjmIkjqyToOAhQyTi4GpdsP9DABPvSpUd9Hvv3dpZ0wtjMpzmFU4s3mtqC4dQ2846FjPzLgbo2OSxAsaM/AayssbZlWVY6yEPp0EeptirirecoqvH4NkRyKwvRGe0H3Q+Q2w95marY9B8RNKgqWqzRmUySrvsxQ6FYkQjHoozcbCp/NTCg4p1my1N0j43Gz0Ea7i5cavsghvrwjMzhtVJTS8SWm85wYJxVMPjfz8BKwwE/MoG3o6Xfn2unlrcF5grthFZJncZlC7US3hnywBVbtbT+Gg64kRFYHk0MXlZ/hJKuieElDYHeLdbdo1TWozSBHXvRRlSTqoyeASYG0wwfNsPXVEh8IUtqWwV4q1/Jv+NksGysyS2KMw6++WIkuQQnN37DXGPVyUoymf2bfv3Q4ju+ZV7ZCSf177HA=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e68d34ff-d512-4345-b67d-08d741c883c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2019 14:56:15.8173
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J6SnwsgkvkhC2aEw8p5IhNQyobo7SkwV5xEruzpyUG8wp52ui1l4vDUFd4OjduL0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1177
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-09-25_06:2019-09-25,2019-09-25 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 clxscore=1011 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 mlxscore=0 impostorscore=0 phishscore=0 bulkscore=0 adultscore=0
 spamscore=0 mlxlogscore=942 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1908290000 definitions=main-1909250143
X-FB-Internal: deliver
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 25 Sep 2019, at 8:07, Colin Walters wrote:

> On Wed, Sep 25, 2019, at 3:11 AM, Dave Chinner wrote:
>>
>> We're talking about user data read/write access here, not some
>> special security capability. Access to the data has already been
>> permission checked, so why should the format that the data is
>> supplied to the kernel in suddenly require new privilege checks?
>
> What happens with BTRFS today if userspace provides invalid compressed=20
> data via this interface?  Does that show up as filesystem corruption=20
> later?  If the data is verified at write time, wouldn't that be losing=20
> most of the speed advantages of providing pre-compressed data?

The data is verified while being decompressed, but that's a fairly large=20
fuzzing surface (all of zstd, zlib, and lzo).  A lot of people will=20
correctly argue that we already have that fuzzing surface today, but I'd=20
rather not make a really easy way to stuff arbitrary bytes through the=20
kernel decompression code until all the projects involved sign off.

-chris
