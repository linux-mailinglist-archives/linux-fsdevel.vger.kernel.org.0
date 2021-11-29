Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A454146230C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Nov 2021 22:12:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232630AbhK2VQI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Nov 2021 16:16:08 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:28058 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229875AbhK2VOH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Nov 2021 16:14:07 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ATKaNnL021038;
        Mon, 29 Nov 2021 21:10:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=rZhZXkrlkEd1s2cLBnRL3fw3y5Cr1TTcDKmgG2ri7W0=;
 b=OJiY9Dqe9KltjraM5lCypuIoO6A0vloXy4XuAeZTVZXxXtR5RiOsE28aqjUIbRRJzH1o
 4O+1RIY4STFryCIpcJch+6GTnqDgFgEIf61hC5Vlv8dpbUIjIAy81HVxVPpu4k0k8AVq
 k4ix9rjQVNVkFoTwai7vtgnXjfHs1tqB8jccjvEvBeXvjZEx2Vv2ZHKUshCKibVqzGUd
 3eSL8YEpPIjnZWOgRhdIAw8gUCb8sk4sTCpxxpAOhigmBuKLtzHmCulgBnctBdInFbsv
 aQMlETPDDFiD5pucexLTATttktOrqZfrUjuQEjWYzNEDcamac6FhQik53IG9keaRDf5+ Cg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cmvmwm6w4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Nov 2021 21:10:48 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1ATL1grs032445;
        Mon, 29 Nov 2021 21:10:47 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2040.outbound.protection.outlook.com [104.47.56.40])
        by aserp3020.oracle.com with ESMTP id 3cmmunrqa1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Nov 2021 21:10:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WhDhQUso/Xi7RHObC5JiKnftdgseK3jscgI9sJT3fKiv080n8zNidn58BUDXIqMhut3e12OYcvPgX+tzR33YymMDFskYjXlfDMzeq4LH42Ac3jS9nfYTCYv+r++dzjg7N9viRj89Emw4HMXd6EUxfuwjnRUoGAtyHiKYUWhmmZvTMS9Da/HWW+DT6B6yIeotOS8RpRDbpWgNX9PEbwrITygflakBo6p/3Usc0qZ15xFPq+VaBtccXZ89seDgpLg4MgBTnRl3fA8nJIVVYhqtAg1Ou7LkPrallJqA0uJKHvsikTOnw8e+znExQpGasPTIAkMHkZgQaR9Ck/FsdPWg2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rZhZXkrlkEd1s2cLBnRL3fw3y5Cr1TTcDKmgG2ri7W0=;
 b=b8FZTzwU/xMuFpGnM4yY5s4Z7JXMLI0yyYt+GcB9jrzE0ZVzH4U5s+Gx1TTX7cnlkEiZFmZN+GbZdrvie3amL8y62mgnJ8aHEgOa/7yocClqn6ht9qrgq/hmk7+C46O3ldS7eppWXxxBiGqEzhXFv1iOMzUtqRiLO5vvYwFpKnkkiKAklnvJ7xhouHLlGYMYVPYpm78zdS0cQMJT1Za/a5Ue9fEwZhAaYt2/ftSFsT5l6FCPOkGhPvbbQVfwPDQtVKU6L77uG0ftLcFb2J69b0zRTy1IZytJZnTUx8oOTJed+lDdeU1CnwznXAcSzwNyjuVxkqZQ7J9SIziTM87Y6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rZhZXkrlkEd1s2cLBnRL3fw3y5Cr1TTcDKmgG2ri7W0=;
 b=EZ5EurCNRc3pvTa807VVgKpKIMVRNUy5A+2lGQFtU1AAT0kXkqC0vYJV547cBl/vqBQ/taTHbRQrSGXXIEm9TUsFykO9ftYW0CL/O5WNFk/Y3yWEoONI8y6UxBdwk9UgVNs4ZA8NOx9zdmWMbLZCZQNn4SXj+D7sa4Dzrva8Kf8=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB2966.namprd10.prod.outlook.com (2603:10b6:a03:8c::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Mon, 29 Nov
 2021 21:10:45 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::48f2:bb64:cb4b:372f]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::48f2:bb64:cb4b:372f%8]) with mapi id 15.20.4734.024; Mon, 29 Nov 2021
 21:10:45 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RFC v5 0/2] nfsd: Initial implementation of NFSv4
 Courteous Server
Thread-Topic: [PATCH RFC v5 0/2] nfsd: Initial implementation of NFSv4
 Courteous Server
Thread-Index: AQHXtMzhlpWZW1OG5ESdBSdOgoHETqu+oymAgAANi4CASGLiAIAA/bOAgAA+8oCAAD8yAIAALy8AgAZzIgCAC+1zAIAABPIAgAARGgCAAAipAIAACTgAgAAabAA=
Date:   Mon, 29 Nov 2021 21:10:45 +0000
Message-ID: <C9C6AEC1-641C-4614-B149-5275EFF81C3D@oracle.com>
References: <20210929005641.60861-1-dai.ngo@oracle.com>
 <20211001205327.GN959@fieldses.org>
 <a6c9ba13-43d7-4ea9-e05d-f454c2c9f4c2@oracle.com>
 <33c8ea5a-4187-a9fa-d507-a2dcec06416c@oracle.com>
 <20211117141433.GB24762@fieldses.org>
 <400143c8-c12a-6224-1b36-3e19f20a7ee4@oracle.com>
 <908ded64-6412-66d3-6ad5-429700610660@oracle.com>
 <20211118003454.GA29787@fieldses.org>
 <bef516d0-19cf-3f30-00cd-8359daeff6ab@oracle.com>
 <b7e3aee5-9496-7ede-ca88-34287876e2f4@oracle.com>
 <20211129173058.GD24258@fieldses.org>
 <da7394e0-26f6-b243-ce9a-d669e51c1a5e@oracle.com>
 <1285F7E2-5D5F-4971-9195-BA664CAFF65F@oracle.com>
 <e1093e42-2871-8810-de76-58d1ea357898@oracle.com>
In-Reply-To: <e1093e42-2871-8810-de76-58d1ea357898@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cc655cd8-8477-44c7-a65e-08d9b37cb573
x-ms-traffictypediagnostic: BYAPR10MB2966:
x-microsoft-antispam-prvs: <BYAPR10MB2966DBB402F356B3E3D6E23593669@BYAPR10MB2966.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hCk7db7RhS+CJuTrvcMU0o64Hd35tfk6wjxe8OZ/GX28ks/Zg0bOYMqRZlk9ixLvSp1KqsZ9wYBz/khAGO5xWynvZyRZJ4MWf75n2xgUQ/N4VHoKwE8CXYVVeaipd1MBhLbsegX0T4riMGxaiPhtNOP5rOuLv4EqBb7Yh/BFmMEOEeg6/ZWKrt7408CN2RQMuSQySDbNwUCM6HrAWG+Td2asDtmpJ92lvkXm4DBxQz61KGaJ/HjR5ObUbAwo1FYdwFsxfmZCIITMN0kkY9joG11SJySPyzDF2Ri2+2vbYyZCYEzQoUG4eEQk0wp0Fu+9LUwkdrNNkOkFV/Wx5Eav+si62oDeKxcQueKC/3oLr56e0A4Pdyjs6cET7N697NR3vjV88E/oRI1f0qVd+zE0hKbG492So+TS+MOg7NGmPlumiK2nadtBNT7JTwVukx5wk6CB9VC0Gmy2pHEX8mKiHgqAifKUm54lmAeDmY8DpKFD3s42dHwYIeAHgVSQdUfhrllm0UUdurZBbJ1GttX77Vzr0KoiZycCLAfkkCxZTdgptG6tEo/1PwRsWhVBJ5RYHBlde7rCNxXLihwMtcCPAA1SczlkEAySmunK4cByk+u3fVX0iQw2vHzI4APjs50kmAjyvMW6YfPbIW2vkSEMaY/EHgFaNlPljOwiYZOddogYxFLhesGfi9RxAEw36pAARgMl5iP7DurCSeGVjyXvNKTsD2VwvBGYeKkiVrrgaPDzlz0Ch64LpP8/L4KCcja2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(4326008)(33656002)(6636002)(38100700002)(2616005)(122000001)(36756003)(26005)(8936002)(6486002)(2906002)(71200400001)(8676002)(6506007)(53546011)(5660300002)(508600001)(6512007)(38070700005)(66446008)(37006003)(54906003)(316002)(64756008)(66946007)(66476007)(66556008)(6862004)(83380400001)(186003)(91956017)(86362001)(76116006)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4LLqxunxNtRkHJic27sxTnOI82V6i7Th+9mdzelckH8QspjdFFK7d9qZ8H1T?=
 =?us-ascii?Q?KV8PGXBCXCm6o6e2kuNaEMTL2g34m6cMizUDPCD043+ShjXBifBZgE72jhW0?=
 =?us-ascii?Q?QxHbrOFHgvCgf6BnZQZeVGvik357kj6yDhmuGSq8WPp/RhT6eHTZDkW0tytI?=
 =?us-ascii?Q?eQ7f9d4lUP158SXzwIzG8OROT9h8HUDoRBTys86PJREgSZ+RSAxZEasduCdv?=
 =?us-ascii?Q?JK5X1rlUsHNW/68IeL4XX6VkHWss/hZtoeCEpfgMVOLsJlTFMLiDpBd5qTSS?=
 =?us-ascii?Q?PLROhWTHM5+X9IMdDwvFnVOdAQSlY5gDOMH0y38Ho5Xk0WAWQIpo4pcVSMKT?=
 =?us-ascii?Q?/nfsn7v7ESJVrA9mVylqS64XwH9T/NJln5xF1KY9aTTYd4Nj1qb02qig+Y6o?=
 =?us-ascii?Q?IJsYf7E4yCkzptDsJXtOe9OrptNblT9MXTi46kynR0LNdp97PfOYIJtDxna2?=
 =?us-ascii?Q?6X9jVh7IAk9rLdGB5do0QMTIVe4BJQ8zIuKxri/aU3aeXAMX17D8RMa8BpeU?=
 =?us-ascii?Q?EqdkSxlVFvDUqZMCdZ+wem8KB3K2caST4jDmNNvwFlToRxD/ETp1CshL+nYq?=
 =?us-ascii?Q?KjRXCx+yWa0pzf9mIhSfxjYQ/wneHCH/i2VL/UcIZ9wRCraHE5iP2saH7L7G?=
 =?us-ascii?Q?k6+OuUUNKcyA0EYMjBhexFJbUOJSZHWbW15jfj003MRIFT3ZJh29Uv9NHhQw?=
 =?us-ascii?Q?DtYG4o2lbL9YGR5XQKAOinB+cLUxmKOafIaU3Gt47nLxpA3y89zyFnVej6W7?=
 =?us-ascii?Q?KotR5VkgqRBYmQNQFvD3XKrCkz+StSXzYiy1c6ntDUux28EtJvLtmIyuzAXB?=
 =?us-ascii?Q?jxoqBie9GZ4MJclremg1vU+Rihfnrw4xCC2ucuE7js9CB7i6KIWaPyNh7XFO?=
 =?us-ascii?Q?tvMg8cVch9NxXtKYfqOKXjqyheijyTxDBnTOH1pQQ3QLCwabIRJP9a+XY7HB?=
 =?us-ascii?Q?byRsJ1bC3WE9ZYjOCT5O20MilRzVrzx4iDXH6O8c2izwx+ql76aCW3d7/GAa?=
 =?us-ascii?Q?cTK61dpv0d2oW1W8nEZVP/1wFpJufOncZ+AMiWY3w85px0MgWae6iny3eg15?=
 =?us-ascii?Q?bzUaBbTpXJidnOgd4HY1Hm9mrH/5OeKnEwPXqRnJjhWAruvH9p0L63PDqufa?=
 =?us-ascii?Q?42xEI9YLmRu2JejDJE4xiqZc3DpBhlOMC9xjCbe/nAKGUezKEqnCodlJsVN3?=
 =?us-ascii?Q?GcYPuDT3Y1Q6O18b3e8yg3EzfAZfXTgyKdDFpfbscXKuksUVf7NHlF4yAkvb?=
 =?us-ascii?Q?hP4WE/VKn2/yVh2HfTZNKBcpC0onqu36CKv8n8NyH7IRo9I5vsj+kMlaUVdh?=
 =?us-ascii?Q?NhTeUD7pmFEupmKXdVNlPEsLhqLddncWgRoHD6VJVgTBykqQTtngFfogSvLk?=
 =?us-ascii?Q?TQ8uJB9hPYKmYwgIm3v4SKNL7vNT+iK8Yt8d+gdZp8/M6MslZ4+Scn3eYG5v?=
 =?us-ascii?Q?FKsmiM6zgeYXAlQv2DQXG7z7IpKJReketyNL3fcLK6wpteISDbdzXBTc/byQ?=
 =?us-ascii?Q?Y0HTE4q1dDXMOfr4IjYSTuqKVmAhXNWapg6ka73umVd9GqL97uv2T7lUyKYt?=
 =?us-ascii?Q?Vt9+KIPneVB7ajUIc/+XwVEMMD/hr+YIPGlk4RZFnfRw8HdYCs3JaROYjBfV?=
 =?us-ascii?Q?U4dzJCC582XNPwnMnTaxyRo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B2504040B1AE58439909F1116E90955A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc655cd8-8477-44c7-a65e-08d9b37cb573
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2021 21:10:45.0182
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AhHjLmkvyQaYWCxLwEjnCW/h84ykATcnOcFrOP/daKzOSpNECSOThdqusVsAwBzjYyMH+SdFmv/vjWhtRg0Qpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2966
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10183 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111290098
X-Proofpoint-ORIG-GUID: BUcrCepnpAbAXpNnzBX5tJtyq0FFXyLs
X-Proofpoint-GUID: BUcrCepnpAbAXpNnzBX5tJtyq0FFXyLs
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Nov 29, 2021, at 2:36 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
>=20
> On 11/29/21 11:03 AM, Chuck Lever III wrote:
>> Hello Dai!
>>=20
>>=20
>>> On Nov 29, 2021, at 1:32 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>>=20
>>>=20
>>> On 11/29/21 9:30 AM, J. Bruce Fields wrote:
>>>> On Mon, Nov 29, 2021 at 09:13:16AM -0800, dai.ngo@oracle.com wrote:
>>>>> Hi Bruce,
>>>>>=20
>>>>> On 11/21/21 7:04 PM, dai.ngo@oracle.com wrote:
>>>>>> On 11/17/21 4:34 PM, J. Bruce Fields wrote:
>>>>>>> On Wed, Nov 17, 2021 at 01:46:02PM -0800, dai.ngo@oracle.com wrote:
>>>>>>>> On 11/17/21 9:59 AM, dai.ngo@oracle.com wrote:
>>>>>>>>> On 11/17/21 6:14 AM, J. Bruce Fields wrote:
>>>>>>>>>> On Tue, Nov 16, 2021 at 03:06:32PM -0800, dai.ngo@oracle.com wro=
te:
>>>>>>>>>>> Just a reminder that this patch is still waiting for your revie=
w.
>>>>>>>>>> Yeah, I was procrastinating and hoping yo'ud figure out the pynf=
s
>>>>>>>>>> failure for me....
>>>>>>>>> Last time I ran 4.0 OPEN18 test by itself and it passed. I will r=
un
>>>>>>>>> all OPEN tests together with 5.15-rc7 to see if the problem you'v=
e
>>>>>>>>> seen still there.
>>>>>>>> I ran all tests in nfsv4.1 and nfsv4.0 with courteous and non-cour=
teous
>>>>>>>> 5.15-rc7 server.
>>>>>>>>=20
>>>>>>>> Nfs4.1 results are the same for both courteous and
>>>>>>>> non-courteous server:
>>>>>>>>> Of those: 0 Skipped, 0 Failed, 0 Warned, 169 Passed
>>>>>>>> Results of nfs4.0 with non-courteous server:
>>>>>>>>> Of those: 8 Skipped, 1 Failed, 0 Warned, 577 Passed
>>>>>>>> test failed: LOCK24
>>>>>>>>=20
>>>>>>>> Results of nfs4.0 with courteous server:
>>>>>>>>> Of those: 8 Skipped, 3 Failed, 0 Warned, 575 Passed
>>>>>>>> tests failed: LOCK24, OPEN18, OPEN30
>>>>>>>>=20
>>>>>>>> OPEN18 and OPEN30 test pass if each is run by itself.
>>>>>>> Could well be a bug in the tests, I don't know.
>>>>>> The reason OPEN18 failed was because the test timed out waiting for
>>>>>> the reply of an OPEN call. The RPC connection used for the test was
>>>>>> configured with 15 secs timeout. Note that OPEN18 only fails when
>>>>>> the tests were run with 'all' option, this test passes if it's run
>>>>>> by itself.
>>>>>>=20
>>>>>> With courteous server, by the time OPEN18 runs, there are about 1026
>>>>>> courtesy 4.0 clients on the server and all of these clients have ope=
ned
>>>>>> the same file X with WRITE access. These clients were created by the
>>>>>> previous tests. After each test completed, since 4.0 does not have
>>>>>> session, the client states are not cleaned up immediately on the
>>>>>> server and are allowed to become courtesy clients.
>>>>>>=20
>>>>>> When OPEN18 runs (about 20 minutes after the 1st test started), it
>>>>>> sends OPEN of file X with OPEN4_SHARE_DENY_WRITE which causes the
>>>>>> server to check for conflicts with courtesy clients. The loop that
>>>>>> checks 1026 courtesy clients for share/access conflict took less
>>>>>> than 1 sec. But it took about 55 secs, on my VM, for the server
>>>>>> to expire all 1026 courtesy clients.
>>>>>>=20
>>>>>> I modified pynfs to configure the 4.0 RPC connection with 60 seconds
>>>>>> timeout and OPEN18 now consistently passed. The 4.0 test results are
>>>>>> now the same for courteous and non-courteous server:
>>>>>>=20
>>>>>> 8 Skipped, 1 Failed, 0 Warned, 577 Passed
>>>>>>=20
>>>>>> Note that 4.1 tests do not suffer this timeout problem because the
>>>>>> 4.1 clients and sessions are destroyed after each test completes.
>>>>> Do you want me to send the patch to increase the timeout for pynfs?
>>>>> or is there any other things you think we should do?
>>>> I don't know.
>>>>=20
>>>> 55 seconds to clean up 1026 clients is about 50ms per client, which is
>>>> pretty slow.  I wonder why.  I guess it's probably updating the stable
>>>> storage information.  Is /var/lib/nfs/ on your server backed by a hard
>>>> drive or an SSD or something else?
>>> My server is a virtualbox VM that has 1 CPU, 4GB RAM and 64GB of hard
>>> disk. I think a production system that supports this many clients shoul=
d
>>> have faster CPUs, faster storage.
>>>=20
>>>> I wonder if that's an argument for limiting the number of courtesy
>>>> clients.
>>> I think we might want to treat 4.0 clients a bit different from 4.1
>>> clients. With 4.0, every client will become a courtesy client after
>>> the client is done with the export and unmounts it.
>> It should be safe for a server to purge a client's lease immediately
>> if there is no open or lock state associated with it.
>=20
> In this case, each client has opened files so there are open states
> associated with them.
>=20
>>=20
>> When an NFSv4.0 client unmounts, all files should be closed at that
>> point,
>=20
> I'm not sure pynfs does proper clean up after each subtest, I will
> check. There must be state associated with the client in order for
> it to become courtesy client.

Makes sense. Then a synthetic client like pynfs can DoS a courteous
server.


>> so the server can wait for the lease to expire and purge it
>> normally. Or am I missing something?
>=20
> When 4.0 client lease expires and there are still states associated
> with the client then the server allows this client to become courtesy
> client.

I think the same thing happens if an NFSv4.1 client neglects to send
DESTROY_SESSION / DESTROY_CLIENTID. Either such a client is broken
or malicious, but the server faces the same issue of protecting
itself from a DoS attack.

IMO you should consider limiting the number of courteous clients
the server can hold onto. Let's say that number is 1000. When the
server wants to turn a 1001st client into a courteous client, it
can simply expire and purge the oldest courteous client on its
list. Otherwise, over time, the 24-hour expiry will reduce the
set of courteous clients back to zero.

What do you think?


>>> Since there is
>>> no destroy session/client with 4.0, the courteous server allows the
>>> client to be around and becomes a courtesy client. So after awhile,
>>> even with normal usage, there will be lots 4.0 courtesy clients
>>> hanging around and these clients won't be destroyed until 24hrs
>>> later, or until they cause conflicts with other clients.
>>>=20
>>> We can reduce the courtesy_client_expiry time for 4.0 clients from
>>> 24hrs to 15/20 mins, enough for most network partition to heal?,
>>> or limit the number of 4.0 courtesy clients. Or don't support 4.0
>>> clients at all which is my preference since I think in general users
>>> should skip 4.0 and use 4.1 instead.
>>>=20
>>> -Dai
>> --
>> Chuck Lever
>>=20
>>=20
>>=20

--
Chuck Lever



