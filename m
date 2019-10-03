Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5517DC9FFD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2019 16:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729984AbfJCOB6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Oct 2019 10:01:58 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:13244 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727488AbfJCOB6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Oct 2019 10:01:58 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x93E029H011131;
        Thu, 3 Oct 2019 07:01:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=nWCjv/0VUUgyKxXY8YiIIFWJXH3ewch6Vct3UP8IKPk=;
 b=CXumEZuEGJRTkQMFmiF0Kd9vI9bIKti/qpWWYAMu5hJHPq2rpTmun5995d0nbJk3K6sM
 docMKqmH05PgKTYFXaO8Keb3zzmFtEA/cdLuQG7m8CzHYVOQUnDLCX3nUdrxGmYqAcR7
 0TWEuyyYgXl/CmoKNnthvwJcRMM9fkIr/ho= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2vdaa41r5c-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 03 Oct 2019 07:01:31 -0700
Received: from prn-mbx05.TheFacebook.com (2620:10d:c081:6::19) by
 prn-hub01.TheFacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Thu, 3 Oct 2019 07:01:16 -0700
Received: from prn-hub02.TheFacebook.com (2620:10d:c081:35::126) by
 prn-mbx05.TheFacebook.com (2620:10d:c081:6::19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Thu, 3 Oct 2019 07:01:14 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Thu, 3 Oct 2019 07:01:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z5Q+7E0jP0m/IP/7Lz9NFfbCzqdhBEsj4es+y4etUY6ZxtiTgjhANc4W3/3U77JWFR33A0XxIKkNJpGm6nZJyDBRaaSp+xebrZ8NXKRjJkU3Lw441ecFY25cqot7OHBwidYJhjMqJarESMDscSXOOktaqukg06yIP0IkSKhtfre/hdjEARW+ny+gEyyA76OZmJImJ0tMroRbanPc0Hej0J+T/b7/PVR4ANF9x/8CYmoiPbvr5lfsYX+rcGgITc9A4xIO6Qq3ikWTDqKGx2dqm0wvqP6VPtG9vOwUWQJeL4/Si/6en38gxVjKLEg5TCwnWunWJhXS0JyPUsMVaCHepQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nWCjv/0VUUgyKxXY8YiIIFWJXH3ewch6Vct3UP8IKPk=;
 b=T+EE9Yg1DhVY+/WiGd6LDAkJVP2ANsZSfAR4AGJE2xRFEPcgz5Rr7B1W5ogF+CcTvYwiPwctRzR5pMgT90cxymBm5btgqxKnosVDdtK68hJ986op9iGkZOyEs0gjQON/VgTHyRaTmUD0lqmmad6++YdiylKneUq1VRvIAtVd79zVWMnfOw5YVRkLJ6jwTVQKV1c5p4O4KXvQBVT8X6beGtYL0Uy85coMgWAt9LRxL/rCyDt7GFcTl2u7gkLNWharsicqESs1+NP1575z9VjUNh8eUwziSA2atMSqRm63hubwGfMuIKSbJOZx9B7DGLRYDjbpkCPUnPzxcyAIfe1t1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nWCjv/0VUUgyKxXY8YiIIFWJXH3ewch6Vct3UP8IKPk=;
 b=MNpJIyHZL5+pxZcY2+tvaw2liYS4D0MFckvv1LKVfXFyPRAIfSZ+0rKQvC7eYkyFxUtLrkjzs2S0jGgMdEm906G+aUcRk4pf/dBK5nbGxaJ7zqls9KU2aF7rgT/mqeAJOmzSV6/xz8ZHSsredpwBAwCS+prBWBnMoEXHzpePK9A=
Received: from DM5PR15MB1290.namprd15.prod.outlook.com (10.173.212.17) by
 DM5PR15MB1273.namprd15.prod.outlook.com (10.173.210.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.16; Thu, 3 Oct 2019 14:01:14 +0000
Received: from DM5PR15MB1290.namprd15.prod.outlook.com
 ([fe80::7931:b386:1db:7e6e]) by DM5PR15MB1290.namprd15.prod.outlook.com
 ([fe80::7931:b386:1db:7e6e%3]) with mapi id 15.20.2305.023; Thu, 3 Oct 2019
 14:01:13 +0000
From:   Chris Mason <clm@fb.com>
To:     Gao Xiang <hsiangkao@aol.com>
CC:     Dave Chinner <david@fromorbit.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        xfs <linux-xfs@vger.kernel.org>, "tj@kernel.org" <tj@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [5.4-rc1, regression] wb_workfn wakeup oops (was Re: frequent
 5.4-rc1 crash?)
Thread-Topic: [5.4-rc1, regression] wb_workfn wakeup oops (was Re: frequent
 5.4-rc1 crash?)
Thread-Index: AQHVebV9yjzYkcmTjkGpczdk1UiqcKdImWgAgABZMoA=
Date:   Thu, 3 Oct 2019 14:01:13 +0000
Message-ID: <41B90CA7-E093-48FA-BDFD-73BE7EB81FB6@fb.com>
References: <20191003015247.GI13108@magnolia>
 <20191003064022.GX16973@dread.disaster.area>
 <20191003084149.GA16347@hsiangkao-HP-ZHAN-66-Pro-G1>
In-Reply-To: <20191003084149.GA16347@hsiangkao-HP-ZHAN-66-Pro-G1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: MailMate (1.13r5655)
x-clientproxiedby: BN6PR2201CA0007.namprd22.prod.outlook.com
 (2603:10b6:405:5e::20) To DM5PR15MB1290.namprd15.prod.outlook.com
 (2603:10b6:3:b8::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c091:480::38af]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6d9e79e6-5c2c-4dc3-6d01-08d7480a26e6
x-ms-traffictypediagnostic: DM5PR15MB1273:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DM5PR15MB127312EB06DC76E2DF38B803D39F0@DM5PR15MB1273.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01792087B6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39860400002)(136003)(366004)(346002)(53754006)(199004)(189003)(33656002)(50226002)(6486002)(6506007)(7736002)(386003)(966005)(66446008)(86362001)(71200400001)(71190400001)(81166006)(25786009)(8676002)(81156014)(8936002)(14454004)(66556008)(6916009)(5660300002)(36756003)(66476007)(66946007)(64756008)(4326008)(99286004)(446003)(11346002)(54906003)(46003)(316002)(486006)(2616005)(476003)(186003)(6116002)(478600001)(76176011)(6436002)(305945005)(14444005)(256004)(53546011)(6306002)(6246003)(6512007)(2906002)(102836004)(229853002)(52116002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR15MB1273;H:DM5PR15MB1290.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O3VaQZG04LlOL3q8Ww1vTyBElfxYXVXNqNnmrbpWYM6IFW9JyTWQJHOEz9kaGY1ol4lcWp3F+WejwljX9J2MeQ28N1awPu8mxX2yd3ZQWZRp3mrGt4dCq28vwMBTRr2awg9p2/ibgnTf2dLceyMK4hV4CfwYbp9eYgsMT8ly1YOZKHGWwc/mJLzh/pyJy7CaSF8n6cLog+XRJoyPC0OwRwjngYFcqu0S0LOir//3dMug8mX+MRYuuGB9LCH2jvFg64hOZIP0CZEmHJduWdJjfecaqS/0BGHSdgdmrfCsOQH33804g5P3P8KQOIjCTO3bYKin50CL95V96rQJfWnWrS61xsnLXmg8HU4NgIyGSFv6CtxBrgn9ap0XSunOX9hpYL+FkdnWDDX/GJugUFEvuxwDvTqVyZ+8XhF4xjJA1kGMWmmmdj9AFTw4wKpBf1DzUJnxzmGII959PhGH+HA0cg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d9e79e6-5c2c-4dc3-6d01-08d7480a26e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2019 14:01:13.8241
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XSts73a3T5xzGtyUczUhYmzqqsh1j8zN0Cug3sjSdzEaCB9hWPOLRZynBadyDFpe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1273
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-03_05:2019-10-03,2019-10-03 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 suspectscore=0 spamscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 mlxlogscore=876 mlxscore=0 clxscore=1011
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910030132
X-FB-Internal: deliver
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 3 Oct 2019, at 4:41, Gao Xiang wrote:

> Hi,
>
> On Thu, Oct 03, 2019 at 04:40:22PM +1000, Dave Chinner wrote:
>> [cc linux-fsdevel, linux-block, tejun ]
>>
>> On Wed, Oct 02, 2019 at 06:52:47PM -0700, Darrick J. Wong wrote:
>>> Hi everyone,
>>>
>>> Does anyone /else/ see this crash in generic/299 on a V4 filesystem=20
>>> (tho
>>> afaict V5 configs crash too) and a 5.4-rc1 kernel?  It seems to pop=20
>>> up
>>> on generic/299 though only 80% of the time.
>>>
>
> Just a quick glance, I guess there could is a race between (complete=20
> guess):
>
>
>  160 static void finish_writeback_work(struct bdi_writeback *wb,
>  161                                   struct wb_writeback_work *work)
>  162 {
>  163         struct wb_completion *done =3D work->done;
>  164
>  165         if (work->auto_free)
>  166                 kfree(work);
>  167         if (done && atomic_dec_and_test(&done->cnt))
>
>  ^^^ here
>
>  168                 wake_up_all(done->waitq);
>  169 }
>
> since new wake_up_all(done->waitq); is completely on-stack,
>  	if (done && atomic_dec_and_test(&done->cnt))
> -		wake_up_all(&wb->bdi->wb_waitq);
> +		wake_up_all(done->waitq);
>  }
>
> which could cause use after free if on-stack wb_completion is gone...
> (however previous wb->bdi is solid since it is not on-stack)
>
> see generic on-stack completion which takes a wait_queue spin_lock=20
> between
> test and wake_up...
>
> If I am wrong, ignore me, hmm...

It's a good guess ;)  Jens should have this queued up already:

https://lkml.org/lkml/2019/9/23/972

-chris
