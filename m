Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87DFF4CC262
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Mar 2022 17:13:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234853AbiCCQOC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Mar 2022 11:14:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233858AbiCCQOA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Mar 2022 11:14:00 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC246E2361;
        Thu,  3 Mar 2022 08:13:14 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 223EtRfM013762;
        Thu, 3 Mar 2022 16:13:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=5gy2bjC1szxH3BGuzN0xV8fmJIQuGzLopLDjvo/nYaY=;
 b=trgNA+j5PExDxCkHF/zbG7oomy9oJcw+n5eKMOIvADFS00GPtoT0J/YVofBy2OI7Tac0
 yKqQ6TXsdzv11+K4DV9w+X9/3th5yQsUkHLg/vWrjFsOBagTQuz4U5jBEWbg4rNou3AQ
 UuA3ESoH4G8shRuBY2XuKs2OsWIattg5clZ3lVN5oFXACAjGAGjGxGOctiNd4eliYVLb
 BTGrM3jyt8FcPGgqQXQFQGKLpS9ReX/G0XfOsRsH7MHNs4B9aBruGWy/L5LFytF7W/pq
 oN7RnZM999cecP7b5MdqUyBVX564UyVoV/Gq584QhfH1Lco6j3WhzIciszzbyUuZ2vAO +g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3eh1k49as5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Mar 2022 16:13:02 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 223G7Maj063059;
        Thu, 3 Mar 2022 16:13:01 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by aserp3030.oracle.com with ESMTP id 3efa8je1g1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Mar 2022 16:13:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VgoggC2OVsc/wDdwfmaesafZa2DYOXlkq5CihmBISXa8A/YgPh8N9VdJC5xLYHIi0VhjwM3Hw+Bria8NahckG/JiLW7tixoON1BKp1vrP936YclYpoEJmTrG5jdM3Q93ZlPf8fEuU2uMXyrNJykAUMOB9jHj81QSA1MVJ+0vxaQOIo93NZqk7OoZejiznZouMOuZO84wAo1BoqdrJ9WyHU35d426a5oJR+HAfeCi9rh65dA4L+ME2qEFk8csujPmR9ReRk0gx6stHqu6jUgEPUYJdYZeX+YsHOluW1MyGidNCa7xE6qEBDFXVvUpOa021IVd3OtQDYIhv+aWNlEWMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5gy2bjC1szxH3BGuzN0xV8fmJIQuGzLopLDjvo/nYaY=;
 b=UQwHJDhVTHDIwKKx0mCXHh9mFL08xrDtmlwk+OSlYXEaeuUONxd29JXplWvbkiKQ2wRl/s0p2k1L5T5z9T8LXUNOKTgMnCZtiaojMMsyCtmh3zMaMbXyeBkjq1n/xJagpwzdqO0pgD4Tfy2og96Ha49m2Dm693oMAH2kCN2kV1HwcDIi264zp6c76Hj8ygyuZbLr3Ca86waZINvx+pFX9PN5+sQUojO8BD2DFXilq3r91q9iB/grf2z6VWR3XZdOFhL2aGZC/B/qcebs4YX7/mF+S7X9XqLhlNh9TsOiJi+tQ9aOFyuQ180ys7ppwTd7OsrXtD0P2G9SOBNAEFqZnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5gy2bjC1szxH3BGuzN0xV8fmJIQuGzLopLDjvo/nYaY=;
 b=SM7lk4KCuuJL+h5S5OxCYvd9GvJ16os5X/cv3T5jTaj9uJWI90ppSKUPa0nkfGvUwxmazyNA9ZwoQJBIWqB/HG3ffExXx6OkwBjJczrNzaXhxk+z72Pe7GNwrcKc2VqhaHqkcbwAJ3AoIZWkeBF6bs+4IP6HynPFuNg8GjNW+yk=
Received: from SN6PR10MB2943.namprd10.prod.outlook.com (2603:10b6:805:d4::19)
 by BN6PR10MB1986.namprd10.prod.outlook.com (2603:10b6:404:100::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 3 Mar
 2022 16:12:58 +0000
Received: from SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::69d0:6635:35d6:9be6]) by SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::69d0:6635:35d6:9be6%6]) with mapi id 15.20.5038.016; Thu, 3 Mar 2022
 16:12:58 +0000
From:   Himanshu Madhani <himanshu.madhani@oracle.com>
To:     =?utf-8?B?SmF2aWVyIEdvbnrDoWxleg==?= <javier@javigon.com>
CC:     Luis Chamberlain <mcgrof@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <matias.bjorling@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Keith Busch <keith.busch@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [LSF/MM/BPF BoF] BoF for Zoned Storage
Thread-Topic: [LSF/MM/BPF BoF] BoF for Zoned Storage
Thread-Index: AQHYLpnbLuldSojLckaK1ogrRaNFTKytIu+AgAAQCACAAKLtAA==
Date:   Thu, 3 Mar 2022 16:12:58 +0000
Message-ID: <9E1B815C-5F59-4A25-9960-88E78D6A3224@oracle.com>
References: <YiASVnlEEsyj8kzN@bombadil.infradead.org>
 <B3F227F7-4BF0-4735-9D0F-786B68871963@javigon.com>
 <20220303062950.srhm5bn3mcjlwbca@ArmHalley.localdomain>
In-Reply-To: <20220303062950.srhm5bn3mcjlwbca@ArmHalley.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3693.60.0.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3dc18c9f-d02e-4a72-d08f-08d9fd30af28
x-ms-traffictypediagnostic: BN6PR10MB1986:EE_
x-microsoft-antispam-prvs: <BN6PR10MB19869DD7D746EB9282F6D8A6E6049@BN6PR10MB1986.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fFL0t2zHnavV16VFaOiQy/g3cDcxnra6XrYiH9j2Un19WJ5jqifqPvcuv/Ya/naydqCh0W/EGGznzw1ac6izy7Zo3oQaXm2HlGoSq9nfXJahRVZNqlB0HHkhnsdupX1xeiw8Oe8x5oBUOWuizw3R9zf+V/fG6p/bmHvh4XFmIxf9CBXiigxqGB411hXAP7TuAEftPL1DlFO1RG0IX9dM61MRTBg/OUJdacE8eVlh4Mb/ihy0284QvOkufR9LUaR4VtBJlX+GYqHQ6Gco5UgQUr/kna99z7GRVMiT7CdrRhh6gt9jCMh3jp/+a3VqICjWqPSk3ILdExebCt+eCiMTLuLhudqu5G3JSyXgm3vA6CNd/Uup4Wqj/k3y9hLhk+uqwvEGPrcx6VMyuCkg+Qs5tImf7s8aJ2QOs5KUMPniew9L2jmCGfA5X7Dsic7f6ezArA4Ietti4Znn60Ovq1rKkXFrmKDuiOD1Sbbnqe6lQ2tikaW2aTQuZBxeWAdiInzVrwVaBcIId1H4uKxyTLlhYh0aL6DgqmiYBm390dp6t4Um/NelqPqX8Fz1pWpD5LTewdMbP+VYMICnroa+3k/dxpx4Q6RjaWGFuyCToi+j4HcJ6Jnpgwnr9n9+Mxrf0HSgSGIzusdrGyfYRWSEj06vwDwz1jfCmvp43mw9MoSOzAx0G4FuA9RBjlWzANwEuN09GcSEfpkmtAy6OOSu4qiO6ZUVZFz/Z5iL10QSh450aX/rmhIb8N5b3bPpEZyVp81m
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2943.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(53546011)(122000001)(186003)(2616005)(26005)(33656002)(83380400001)(54906003)(6512007)(66574015)(44832011)(86362001)(36756003)(66446008)(66946007)(66556008)(71200400001)(76116006)(66476007)(8936002)(8676002)(64756008)(4326008)(7416002)(38070700005)(91956017)(5660300002)(38100700002)(316002)(6916009)(2906002)(6486002)(508600001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V1ZYRy9RclFWcjZMdTk1SWY5ZDVCN3NFaU1sblEweGtkemZadGVKOXFBZEFy?=
 =?utf-8?B?VVlRMUJjWVo3N0taVXhWRHJPOXpWZk1ZVXAwNHZ0TEFVcmN2Nk9zb0RMUm11?=
 =?utf-8?B?ZHFZb0NHckgvU2Z4bmw0KzZQWE80ZngzbDc1WXd5ZDJ3bTJOc3Bod3dNYXZj?=
 =?utf-8?B?YVVLd2liS3BEREtJYnlyWVd6QlUxVDZhUWlLazZSQTlwVHVVUHJnRUdQdGlP?=
 =?utf-8?B?VWt1OE1HRnZJL1I5S1R6aEpHSDE3ajZxVExNd21zdXVVaUxGb0g1L0tielph?=
 =?utf-8?B?SjQ1T2NlNGs5SmYwUTIyOURiekJ2ZWw1TEFIYlo5c0pYUFlvTEpxTHRYRG1H?=
 =?utf-8?B?aWlNOXlnbHdDQ3dFK0NsQURGUG42WkFrMm9CN3BCUnVMWm1oQ1M0TVJFM3k3?=
 =?utf-8?B?OFZPZ0tzc2FUUW5Nc2EydEltUW9OS1QzVXZUMEJ1MW5qSmphaGpuUUxsRCtZ?=
 =?utf-8?B?MDlkZVFwOXRzVmxVL1pIK2d6M3h0UmNxZ1d6T20ydmY1cXFHNkJyS0JnNCtn?=
 =?utf-8?B?ZmphSkNaSTRhbCtzdW9iTDJFNDdPT2pMQUJwZUgreWo5ZWlvZStyU3A1S0tx?=
 =?utf-8?B?TGxwYW9SNndkN2g5dXBNYW9QTWQ1eTc0VnJ1VCt0SENsRmozMm9OcHQ0WHE3?=
 =?utf-8?B?TldEUXpmVURpNUk5UFNHR1R6aHBrUUNTWVVUelBjVnZiNTdJbUFqQ1Y5UGZn?=
 =?utf-8?B?ZERDNDR2OU5XcmpIbzR0WmplOXFjMnVkbWdaM1RYemNIVjB1L1RNOFozQ25E?=
 =?utf-8?B?NXRYR3JyY3hySTBsUXN0TlZQOEZ0NWFUeVY0anBKd3JhVUFHUkNYL3NRTTJ1?=
 =?utf-8?B?TnFSeVZoeFgrUFlnbGx3S0o1MnM5VGtOVmM4Z3NmVzNBb2kweWVpUXd4WmJD?=
 =?utf-8?B?dGpRMEZPcCtleVRXSTYxZWdZMU5rUjdZV2NXSkJzZEdhUlRZQmJwTlhOUGRs?=
 =?utf-8?B?OU5hNm1LdFpzR0RMMUpuTDZsVTR3dllPNURjYy8rVXcxb3daU0NwK3NPUE12?=
 =?utf-8?B?VE9VK2FhQW5sS08zZ3dtU2FNb3NXUXBBVC9HaVZjek5CZ1QyNmJobVVWaVE2?=
 =?utf-8?B?SkhFK0diUHBsdktnS0Y0NVcxUTBQM2hlQUp5RGNjcVBwRURtUVR4cUVKdGcr?=
 =?utf-8?B?b0NzV3lBV3JDS0ZJb3Q5Wml5VUZqVElEM0ZydCtuUWRseHpqZTBJVFp0eG9P?=
 =?utf-8?B?MTM2SDVHYWorWVFnQ3EwR0o3QU45dURITVBiNU5BOGlFYVdZdXl0STlkbnF2?=
 =?utf-8?B?c1ZTSGhxcGVDZm5lKzk3MGh6V1VrOThiU2RramFhV280Y05PNjBVWGxQNWFx?=
 =?utf-8?B?RTRzbU5heDBHTlo4bGVuUERGYndTa1Z1b1NtTlVwWXNYSkxGdkpqMFlQeGYr?=
 =?utf-8?B?VHNvdWRrQkRibnpiakNsRnU0aHBndmxvdFVsN1lUNnJwYXZMTlhYMW9TS28v?=
 =?utf-8?B?a2VHbXZpSThrbGRaa2gvYWNySEh1amM5elRUYWQ3SnZ5OFhmdGI4K01XME1E?=
 =?utf-8?B?clBMai9oSnd1OGpiTWFZc0I0UC9RK1Rnb3BhU3dFcXpXbzlkQUdUVHhUZ1do?=
 =?utf-8?B?VXdoOGxJZnhrQm5HcURKVkRlMjFLRXJNSTMzSGc4OCtyVFhIdWdWZlNwdEdK?=
 =?utf-8?B?SHJlVjdSd2wvc1dWMEdqZjFXUnkwejlseGh3ZmExTlRrdmNyc3VpbUtxTTR0?=
 =?utf-8?B?UDI5V2dPMTVPcFU0MGpKMlViek1laTVpMk1WYkdhdWptYmpsSFhITG10K3Br?=
 =?utf-8?B?RitzSW9DYUJQMHVWdjdLY2pocTcwNTVLMmduWTFkRlYzbDAvdmNpLyt2bW5i?=
 =?utf-8?B?Z1VpYWIzRUdON1hIck1obUNoM0d1WmJPU25ENEtodWdqTmJEWjU4cDJnSVVz?=
 =?utf-8?B?c1pxRlg4ZUlRWDBhMUE4aWN1RUQ5ZGpPRVZMWnZwMTdBbHFUUlIvNElueWZp?=
 =?utf-8?B?VFVDQjVNUTdaV3JKOEhYcmY1dG1oYnd0VXVSeHVmT21OSjc4WldVazQ5aFRS?=
 =?utf-8?B?aElWekJoTTdJTURISjZZb1JWOVBHbm8zN3J3R01ZNTZURFdLQ0JpQktUWE9a?=
 =?utf-8?B?UzBVNkdQWnpCN0gwTitzcy9TUk9BcEl4eUEzeXFhMG5zelRjcnpiZzcvcE9E?=
 =?utf-8?B?NHdqR21DdFM2b05XQW50b3UvSzZVN3FicDBPVGJ5K1puckdVTXE4RnFTUzZD?=
 =?utf-8?B?L2FIVVNpQWVQSUZHTThDemxreTErV2dvUHZWKzg2UFdaNFlZRkFWTVAyUld2?=
 =?utf-8?Q?vZlc5HMm7uWieUnv+L+xwP2dMsr7/FM/QLFKMpx7dA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8342857A5630934F94001B4DA309CBBB@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2943.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dc18c9f-d02e-4a72-d08f-08d9fd30af28
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2022 16:12:58.7799
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YUQefiwaYIwO2DlGe0shYoZ4foFt6i5rEUNDVK/S+SpnS53BKGFGWswPoJ2qCZxvnHWYMxdwpwpBDSORIag5rmOVKboDRUai8QH0k17G7M0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1986
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10275 signatures=686983
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2203030078
X-Proofpoint-ORIG-GUID: le_9D909BijgGUwN95BqtcX9IiaBWSNr
X-Proofpoint-GUID: le_9D909BijgGUwN95BqtcX9IiaBWSNr
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

DQoNCj4gT24gTWFyIDIsIDIwMjIsIGF0IDEwOjI5IFBNLCBKYXZpZXIgR29uesOhbGV6IDxqYXZp
ZXJAamF2aWdvbi5jb20+IHdyb3RlOg0KPiANCj4gT24gMDMuMDMuMjAyMiAwNjozMiwgSmF2aWVy
IEdvbnrDoWxleiB3cm90ZToNCj4+IA0KPj4+IE9uIDMgTWFyIDIwMjIsIGF0IDA0LjI0LCBMdWlz
IENoYW1iZXJsYWluIDxtY2dyb2ZAa2VybmVsLm9yZz4gd3JvdGU6DQo+Pj4gDQo+Pj4g77u/VGhp
bmtpbmcgcHJvYWN0aXZlbHkgYWJvdXQgTFNGTU0sIHJlZ2FyZGluZyBqdXN0IFpvbmUgc3RvcmFn
ZS4uDQo+Pj4gDQo+Pj4gSSdkIGxpa2UgdG8gcHJvcG9zZSBhIEJvRiBmb3IgWm9uZWQgU3RvcmFn
ZS4gVGhlIHBvaW50IG9mIGl0IGlzDQo+Pj4gdG8gYWRkcmVzcyB0aGUgZXhpc3RpbmcgcG9pbnQg
cG9pbnRzIHdlIGhhdmUgYW5kIHRha2UgYWR2YW50YWdlIG9mDQo+Pj4gaGF2aW5nIGZvbGtzIGlu
IHRoZSByb29tIHdlIGNhbiBsaWtlbHkgc2V0dGxlIG9uIHRoaW5ncyBmYXN0ZXIgd2hpY2gNCj4+
PiBvdGhlcndpc2Ugd291bGQgdGFrZSB5ZWFycy4NCj4+PiANCj4+PiBJJ2xsIHRocm93IGF0IGxl
YXN0IG9uZSB0b3BpYyBvdXQ6DQo+Pj4gDQo+Pj4gKiBSYXcgYWNjZXNzIGZvciB6b25lIGFwcGVu
ZCBmb3IgbWljcm9iZW5jaG1hcmtzOg0KPj4+ICAgICAtIGFyZSB3ZSByZWFsbHkgaGFwcHkgd2l0
aCB0aGUgc3RhdHVzIHF1bz8NCj4+PiAgIC0gaWYgbm90IHdoYXQgb3V0bGV0cyBkbyB3ZSBoYXZl
Pw0KPj4+IA0KPj4+IEkgdGhpbmsgdGhlIG52bWUgcGFzc3Rocm9naCBzdHVmZiBkZXNlcnZlcyBp
dCdzIG93biBzaGFyZWQNCj4+PiBkaXNjdXNzaW9uIHRob3VnaCBhbmQgc2hvdWxkIG5vdCBtYWtl
IGl0IHBhcnQgb2YgdGhlIEJvRi4NCj4+PiANCj4+PiBMdWlzDQo+PiANCj4+IFRoYW5rcyBmb3Ig
cHJvcG9zaW5nIHRoaXMsIEx1aXMuDQo+PiANCj4+IEnigJlkIGxpa2UgdG8gam9pbiB0aGlzIGRp
c2N1c3Npb24gdG9vLg0KPj4gDQo+PiBUaGFua3MsDQo+PiBKYXZpZXINCj4gDQo+IExldCBtZSBl
eHBhbmQgYSBiaXQgb24gdGhpcy4gVGhlcmUgaXMgb25lIHRvcGljIHRoYXQgSSB3b3VsZCBsaWtl
IHRvDQo+IGNvdmVyIGluIHRoaXMgc2Vzc2lvbjoNCj4gDQo+ICAtIFBPMiB6b25lIHNpemVzDQo+
ICAgICAgSW4gdGhlIHBhc3Qgd2Vla3Mgd2UgaGF2ZSBiZWVuIHRhbGtpbmcgdG8gRGFtaWVuIGFu
ZCBNYXRpYXMgYXJvdW5kDQo+ICAgICAgdGhlIGNvbnN0cmFpbnQgdGhhdCB3ZSBjdXJyZW50bHkg
aGF2ZSBmb3IgUE8yIHpvbmUgc2l6ZXMuIFdoaWxlDQo+ICAgICAgdGhpcyBoYXMgbm90IGJlZW4g
YW4gaXNzdWUgZm9yIFNNUiBIRERzLCB0aGUgZ2FwIHRoYXQgWk5TDQo+ICAgICAgaW50cm9kdWNl
cyBiZXR3ZWVuIHpvbmUgY2FwYWNpdHkgYW5kIHpvbmUgc2l6ZSBjYXVzZXMgaG9sZXMgaW4gdGhl
DQo+ICAgICAgYWRkcmVzcyBzcGFjZS4gVGhpcyB1bm1hcHBlZCBMQkEgc3BhY2UgaGFzIGJlZW4g
dGhlIHRvcGljIG9mDQo+ICAgICAgZGlzY3Vzc2lvbiB3aXRoIHNldmVyYWwgWk5TIGFkb3B0ZXJz
Lg0KPiANCj4gICAgICBPbmUgb2YgdGhlIHRoaW5ncyB0byBub3RlIGhlcmUgaXMgdGhhdCBldmVu
IGlmIHRoZSB6b25lIHNpemUgaXMgYQ0KPiAgICAgIFBPMiwgdGhlIHpvbmUgY2FwYWNpdHkgaXMg
dHlwaWNhbGx5IG5vdC4gVGhpcyBtZWFucyB0aGF0IGV2ZW4gd2hlbg0KPiAgICAgIHdlIGNhbiB1
c2Ugc2hpZnRzIHRvIG1vdmUgYXJvdW5kIHpvbmVzLCB0aGUgYWN0dWFsIGRhdGEgcGxhY2VtZW50
DQo+ICAgICAgYWxnb3JpdGhtcyBuZWVkIHRvIGRlYWwgd2l0aCBhcmJpdHJhcnkgc2l6ZXMuIFNv
IGF0IHRoZSBlbmQgb2YgdGhlDQo+ICAgICAgZGF5IGFwcGxpY2F0aW9ucyB0aGF0IHVzZSBhIGNv
bnRpZ3VvdXMgYWRkcmVzcyBzcGFjZSAtIGxpa2UgaW4gYQ0KPiAgICAgIGNvbnZlbnRpb25hbCBi
bG9jayBkZXZpY2UgLSwgd2lsbCBoYXZlIHRvIGRlYWwgd2l0aCB0aGlzLg0KPiANCj4gICAgICBT
aW5jZSBjaHVua19zZWN0b3JzIGlzIG5vIGxvbmdlciByZXF1aXJlZCB0byBiZSBhIFBPMiwgd2Ug
aGF2ZQ0KPiAgICAgIHN0YXJ0ZWQgdGhlIHdvcmsgaW4gcmVtb3ZpbmcgdGhpcyBjb25zdHJhaW50
LiBXZSBhcmUgd29ya2luZyBpbiAyDQo+ICAgICAgcGhhc2VzOg0KPiANCj4gICAgICAgIDEuIEFk
ZCBhbiBlbXVsYXRpb24gbGF5ZXIgaW4gTlZNZSBkcml2ZXIgdG8gc2ltdWxhdGUgUE8yIGRldmlj
ZXMNCj4gCXdoZW4gdGhlIEhXIHByZXNlbnRzIGEgem9uZV9jYXBhY2l0eSA9IHpvbmVfc2l6ZS4g
VGhpcyBpcyBhDQo+IAlwcm9kdWN0IG9mIG9uZSBvZiBEYW1pZW4ncyBlYXJseSBjb25jZXJucyBh
Ym91dCBzdXBwb3J0aW5nDQo+IAlleGlzdGluZyBhcHBsaWNhdGlvbnMgYW5kIEZTcyB0aGF0IHdv
cmsgdW5kZXIgdGhlIFBPMg0KPiAJYXNzdW1wdGlvbi4gV2Ugd2lsbCBwb3N0IHRoZXNlIHBhdGNo
ZXMgaW4gdGhlIG5leHQgZmV3IGRheXMuDQo+IA0KPiAgICAgICAgMi4gUmVtb3ZlIHRoZSBQTzIg
Y29uc3RyYWludCBmcm9tIHRoZSBibG9jayBsYXllciBhbmQgYWRkDQo+IAlzdXBwb3J0IGZvciBh
cmJpdHJhcnkgem9uZSBzdXBwb3J0IGluIGJ0cmZzLiBUaGlzIHdpbGwgYWxsb3cgdGhlDQo+IAly
YXcgYmxvY2sgZGV2aWNlIHRvIGJlIHByZXNlbnQgZm9yIGFyYml0cmFyeSB6b25lIHNpemVzIChh
bmQNCj4gCWNhcGFjaXRpZXMpIGFuZCBidHJmcyB3aWxsIGJlIGFibGUgdG8gdXNlIGl0IG5hdGl2
ZWx5Lg0KPiANCj4gCUZvciBjb21wbGV0ZW5lc3MsIEYyRlMgd29ya3MgbmF0aXZlbHkgaW4gUE8y
IHpvbmUgc2l6ZXMsIHNvIHdlDQo+IAl3aWxsIG5vdCBkbyB3b3JrIGhlcmUgZm9yIG5vdywgYXMg
dGhlIGNoYW5nZXMgd2lsbCBub3QgYnJpbmcgYW55DQo+IAliZW5lZml0LiBGb3IgRjJGUywgdGhl
IGVtdWxhdGlvbiBsYXllciB3aWxsIGhlbHAgdXNlIGRldmljZXMNCj4gCXRoYXQgZG8gbm90IGhh
dmUgUE8yIHpvbmUgc2l6ZXMuDQo+IA0KPiAgICAgV2UgYXJlIHdvcmtpbmcgdG93YXJkcyBoYXZp
bmcgYXQgbGVhc3QgYSBSRkMgb2YgKDIpIGJlZm9yZSBMU0YvTU0uDQo+ICAgICBTaW5jZSB0aGlz
IGlzIGEgdG9waWMgdGhhdCBpbnZvbHZlcyBzZXZlcmFsIHBhcnRpZXMgYWNyb3NzIHRoZQ0KPiAg
ICAgc3RhY2ssIEkgYmVsaWV2ZSB0aGF0IGEgRjJGIGNvbnZlcnNhdGlvbiB3aWxsIGhlbHAgbGF5
aW5nIHRoZSBwYXRoDQo+ICAgICBmb3J3YXJkLg0KPiANCj4gVGhhbmtzLA0KPiBKYXZpZXINCj4g
DQoNCkkgYW0gd29ya2luZyBvbiBab25lZCBzdG9yYWdlIGZvciBzb21lIHRpbWUgYXMgd2VsbC4g
SSB3b3VsZCBsaWtlIHRvIGJlIHBhcnQgb2YgdGhpcyBkaXNjdXNzaW9uIGFzIHdlbGwuIA0KDQpU
aGFua3MhIA0KDQotLQ0KSGltYW5zaHUgTWFkaGFuaQkgT3JhY2xlIExpbnV4IEVuZ2luZWVyaW5n
DQoNCg==
