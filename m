Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80A914A9D6B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Feb 2022 18:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242432AbiBDRJy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Feb 2022 12:09:54 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:44524 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236191AbiBDRJx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Feb 2022 12:09:53 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 214GTGdr031261;
        Fri, 4 Feb 2022 17:09:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=ustaxTojCYNfOD4AEl8+1kh+F7GEOpE6WUH1qIFyWro=;
 b=GBPFwSNM5cjx1N/ZPfUwjRAyhgFSb0IOA3q5qdPkR6DQvnWxOusY/WQkjjvyyGqKGcTm
 Yv+68flXZY5Sw678IQcqspDK7OmT2BsisJudVnOAzs+19vY7CugTJJNqbbEMEEfsdu73
 pnFmnytiwwPfKCXUThWeNJzAJfYsNWz17ZKwM6NEZGh0d0/u19jvlp8stsds0+wNLFtj
 J7LNTnYsJW7CK2Lt5NqkzbO+kqroNHD2UEJlsUFL9RVDITGl1+eRdDO62N9thYyxGMGa
 ebAPg3RlwbFkAzClQrSyztGXoy664tM84AGzl+4waDH3tbskp2aeZrG7tb1tqXAwlwJS pw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e0hfwb6gt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Feb 2022 17:09:50 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 214H2DOD122438;
        Fri, 4 Feb 2022 17:09:49 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by aserp3030.oracle.com with ESMTP id 3dvumnspca-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Feb 2022 17:09:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jzEtsWWJwxCp9wnPlFNrG02Z8asJmBe6GwME+ccw1iO8qjdk1rmR51cCro9QTIvvm6pwj8bP8M8Y4LrU/1piijzVWaaakSOycOhIJi8i29n8CzvKztj746z6IckHGaIcgrconWye5XeeiiwAtNzb7wGuAzrDkWWmSJYRvbwRWLa0XE0T+jpM1xUvCSwyT4IRcg0NtbvuF1jScSTN38ACxCJ/yi5GY7RWQVCNDv/vSYB405vpRxCUwo/OlsqLs4+C1kK7xZsmq7Dfzkgm67nrmmJvIihTzzfK/Q2TnFmMPMeUyw/r7iqS/81Cduw2+AgYcNNsISStG6Lv3NY7CsjQDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ustaxTojCYNfOD4AEl8+1kh+F7GEOpE6WUH1qIFyWro=;
 b=V1DqJ8mmLw1yeoA+SIpNAOOIPG9pza5xDsoaar+S2j/4K8eXPqDX2Kv9XMFf0ZOrC32EiL/z/hXPryV6L1ClnmWgWZDGVS5xLUOF/lXQJHvYdWWIk9m2YxkmjnKyrynLq+gNnuOCPheb6jz4Q+TGY8T3LE5bkX/hh3fF4g4yO357F0vxsD0ISf7cAhKuRvxoArg6ORKv6IAw6rO/LyECd9IVH9lkqBbbREfO67DeCHqbjWfqXpfjYNFTAlfQ5F7mUVZ1rFvIU11ke8bOmwJdxpOGaU0okjH/JFTq0yTq8UF8sv7vF4izS/dXJELCpaWznOKq9kOIxyYcakKWnkzaBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ustaxTojCYNfOD4AEl8+1kh+F7GEOpE6WUH1qIFyWro=;
 b=IoSNgD88FzpOp/m/jC7jRmHN6vIRU8Z0Xn3lsrwsXt0XvcvzXUmUg/MTMY/ZrzLuYJXAzLILR9TQaV6j3geaf6MSNfw8bgEg2w6dtPfcu0hQhn+mE/WXsm99Y+brpgwwWOAycK3qsi8VpHtmcctTsaqdm5PeAsvBUKQfXdD4lk4=
Received: from DS7PR10MB4864.namprd10.prod.outlook.com (2603:10b6:5:3a2::5) by
 BYAPR10MB2488.namprd10.prod.outlook.com (2603:10b6:a02:b9::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4930.20; Fri, 4 Feb 2022 17:09:47 +0000
Received: from DS7PR10MB4864.namprd10.prod.outlook.com
 ([fe80::6438:8348:3b0a:5b00]) by DS7PR10MB4864.namprd10.prod.outlook.com
 ([fe80::6438:8348:3b0a:5b00%5]) with mapi id 15.20.4951.016; Fri, 4 Feb 2022
 17:09:47 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     Bruce Fields <bfields@fieldses.org>,
        Jeff Layton <jlayton@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RFC 3/3] nfsd: Initial implementation of NFSv4 Courteous
 Server
Thread-Topic: [PATCH RFC 3/3] nfsd: Initial implementation of NFSv4 Courteous
 Server
Thread-Index: AQHYFH7X1sEKJuZpaUeYDd9pPdXaRKyCQCmAgAAjwYCAACHnAIAAQ5OAgADEaQCAABtUgIAAAeYA
Date:   Fri, 4 Feb 2022 17:09:47 +0000
Message-ID: <E9919E4A-48C3-4C1E-9C05-4D1DBCF60319@oracle.com>
References: <1643398773-29149-1-git-send-email-dai.ngo@oracle.com>
 <1643398773-29149-4-git-send-email-dai.ngo@oracle.com>
 <3A7DD587-0511-4F04-AE9A-41595BA421F4@oracle.com>
 <9abcb71b-6a1b-941d-5125-c812a13b549e@oracle.com>
 <36731CD8-E35E-436F-AF1A-9F97C0ADCA57@oracle.com>
 <36d579fa-8d7b-113c-704a-479b7365173b@oracle.com>
 <1C0AD92E-900C-4F47-9255-A50CE184F241@oracle.com>
 <8dee77c4-05cc-3722-9b57-096aa45fd10f@oracle.com>
In-Reply-To: <8dee77c4-05cc-3722-9b57-096aa45fd10f@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 509456ed-0688-4931-b249-08d9e80125ba
x-ms-traffictypediagnostic: BYAPR10MB2488:EE_
x-microsoft-antispam-prvs: <BYAPR10MB2488C55E60F031F2DE118D8B93299@BYAPR10MB2488.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z4cqYCupwSXFlyhxXeJN84gftujQ4CiROaR630NWs1KDfFB3w6qoofTO1I3HKqzz1SQNf0ZiMxbEJVdzU7fTgQ7qocwxOtkZdTkrf39w/FZcNGPyrr9ckfogn00M4Pioy48aScWYjEvGLkHplCcvGcKImEPEwxGlZjLiXepFibJuN2C67z/yW3qbuTBnxATrtJEqR5onMkzWpRh/CZO/4yl5EUMjgFsisfSU1LiXE9lY1w+Tw5aGJI+nQk4m79jv2Q/9c8nu0lj/kpMou6cNxgR4Nj5vwbpY6LjxDTUSzIATjMxS+6a22IfHbEYit8gT4BFR0InmxJQQwkAo5LcVngf8nOH7jW4+tsWoHXGynjA0XsWv7Ecf9TEaGqbUgiEa9Vgz3YKUGgL15OYShVqWT4KAZVQmiQFaRvxJdePi5NFL4Sptr+o7ATYLPZt0qLyPs1ZuvdNUU/k0+P1zY0vBuMydWpJYp0tp+WgsvQ2Zox9EmL5QQ6sk/As9bke+Ud0HsacCU4gJpmwLuTJfoYwHNX+MMtmVVQ7CzoD6juaiPKsNpYyuFBsNd/rpPyQ3jncYydq8YRt6tcQJlpUOGKV0b46f/cDo6++khy7huN5Zeq5+PwP6lfLPyIY8y0XJERb+z48WBRFN6mzryGLNMLqbSaf4p7PMUs+mus4+3zGfdaMX6THUa9iFcjZ7UA2+npwwJKRO1qtwLY9OBx90wfqD5O6pMx9lhO8iiEHs/k6J0EggMQCOQtZokRlBfYcSsziB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB4864.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(91956017)(64756008)(38100700002)(66946007)(66556008)(6862004)(4326008)(66446008)(66476007)(83380400001)(76116006)(508600001)(6486002)(8936002)(38070700005)(8676002)(6506007)(53546011)(6636002)(316002)(2616005)(54906003)(37006003)(6512007)(86362001)(71200400001)(26005)(36756003)(2906002)(122000001)(186003)(33656002)(5660300002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EwMRLgV/+jYhJOqwBQ+q7G1wPMC7VESrsum2mBGpzV42JgIUgURntLP/l1Jx?=
 =?us-ascii?Q?9JrjvX+wBsKKpOUDa8iPj4A5f1GmWxtVHFWSmZITYfGqFk3Svg4x3CJQbUVC?=
 =?us-ascii?Q?2IkerjWskHHmbws02pKlGrr6Uc6Bam7BmofuhkGCTdnMR8sdp1udo+tRHK7J?=
 =?us-ascii?Q?t8bVhdNgzOzbvLbbywSE/Ege+5g7NjCX/cOHLm5KpIyNVZwnaJs1Z/dFIOjl?=
 =?us-ascii?Q?ODtqmbEU8QfQW0vdZ8OvfrWOZLhYwEzxK2Yyfor6Lh/rnkg1QF04+uW+zZnE?=
 =?us-ascii?Q?uV4eT1RA6Z8MHhsKhfcCMaTD19HxMxqd6mpm0JQzxXK+Kcno0KINBxCTwLEg?=
 =?us-ascii?Q?vK1FbD5MXJFqJZ0s6mUTKHXOi4/YV97twjnuebYnRUllquDaNroU/dmwPw01?=
 =?us-ascii?Q?AkXV7XhNJ10dRSiQAhpgt6b3PsBv3cd69CHEkOzQoDUl1C3TQr0zENHgHV5F?=
 =?us-ascii?Q?Odbzs/O+DYj4WrTTYagAJPWNXx8woyls4kaRDzzccXYd2VBDJ1TrenFGR4L4?=
 =?us-ascii?Q?i1h2w82Q4Vhmz9/O4u5zAmzmc8aGh30lxtxx+QbCbFCRJePC0i/6f8yUpUZC?=
 =?us-ascii?Q?NwGuBBxambeNUySb7hNxAe3sSs7KFHOMgRkpadf8oC1lnmobe3lEWjmra4ZX?=
 =?us-ascii?Q?4Oj4mC185ug0w+MrxnYSaeygr3Ywh09KB3dqBYFNE8mCSqD6dnox7lbxexsp?=
 =?us-ascii?Q?5mTOjlw/PTLsLJBod3+VNtf0X8mGoStqb/Aa0S/B6AR00Yp5p6OShYCUDzw/?=
 =?us-ascii?Q?Z9YzE4Wb84NScEbj0eF7NowwvUpaBd2lYRewgCIJM2un1BGvd4EmLcpJZP0H?=
 =?us-ascii?Q?2XngKzDkVAuKfcaE4dWiRZBK5gnQo3geFdSBSr21eZJUzq9HCVbfXeG3nQbg?=
 =?us-ascii?Q?6pNW2XW9tlzh5o7d+7dQcV50OxAOIyw3rakz7BNSbJUcuRM1uYv1yyOE98Wa?=
 =?us-ascii?Q?v9zlBZCiwhaxVMh/H8dzei24glzWno+/08AGkvkyb/2a8FJsJBkciDI3SkLf?=
 =?us-ascii?Q?6o0j+BG+QfF8dA4nclOWQl4bhOgWtvsiMXZ/e+pBTu7OVjH5vwDNh2CyVRn+?=
 =?us-ascii?Q?419ynCgobhMdHe0eC+99kTD7HJXHrbbt76EfD8/Bufd8zAsJ6rJYoxDyqgAv?=
 =?us-ascii?Q?MftxE4Ul9/BDD1Y8SKN1HR8v1+1YIXHL+yZBTuEN5cp5hfhwjMy+NLqervNp?=
 =?us-ascii?Q?Uiwzbs9+StlOvl8ZHYMUr3TUKLJLP8gjXFe8qB2GOZRwpPxW/WXWfBeXqiAO?=
 =?us-ascii?Q?dHCM0cR2oX5COxXUtSyvTZN9fNVutdbwgglQieoTOEou52PsBBdh+2UG0+Hq?=
 =?us-ascii?Q?DRmeF75nmlRHrP74c1R1ohozRJ9c3Q+pi/U2llz0xrTBVtjBpv/tMEPldmvC?=
 =?us-ascii?Q?AzKhF6buKruCR+f0NDe9XGSxHhNjpVz3gQSrCs9UgBbS0SyknqsfqOrBeQy/?=
 =?us-ascii?Q?N59GJJhjugQvC/+9JDi0DPuzqLkM40YTt9dtzKyy4HQWhESVVcmmOs/1pJmH?=
 =?us-ascii?Q?XcF6M3OmxISvfdenweQq0ms+G6B63OutM2XAOBuellHZJrGP/d+f0EL6ufRW?=
 =?us-ascii?Q?oZykFfV5/VBSgL0lSjYQrl0cIorPkKt8xSsZU2Hv2IZ6mn130En+hxhZKVcH?=
 =?us-ascii?Q?Ql3Sbs1ZKcNf913mxpBiNZ8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DBC2EE67D48CA44DAB6D1435DD48E815@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4864.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 509456ed-0688-4931-b249-08d9e80125ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2022 17:09:47.4145
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: elGNCK1scx2lihT+X3UIKo8wzzyignuFLicFJOBgl4zyY1uWX0awoWEGmo1O34bSnup+l5Gakcfee4of3+ZyLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2488
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10248 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202040095
X-Proofpoint-ORIG-GUID: NNWJcU_LsPRJQ1m1_fA9iFXWpcwXSbIk
X-Proofpoint-GUID: NNWJcU_LsPRJQ1m1_fA9iFXWpcwXSbIk
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Feb 4, 2022, at 12:02 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
>=20
> On 2/4/22 7:25 AM, Chuck Lever III wrote:
>>=20
>>> On Feb 3, 2022, at 10:42 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>>=20
>>>=20
>>> On 2/3/22 3:40 PM, Chuck Lever III wrote:
>>>>> On Feb 3, 2022, at 4:38 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>>>>=20
>>>>>=20
>>>>> On 2/3/22 11:31 AM, Chuck Lever III wrote:
>>>>>>> On Jan 28, 2022, at 2:39 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>>>>>>=20
>>>>>>> Currently an NFSv4 client must maintain its lease by using the at l=
east
>>>>>>> one of the state tokens or if nothing else, by issuing a RENEW (4.0=
), or
>>>>>>> a singleton SEQUENCE (4.1) at least once during each lease period. =
If the
>>>>>>> client fails to renew the lease, for any reason, the Linux server e=
xpunges
>>>>>>> the state tokens immediately upon detection of the "failure to rene=
w the
>>>>>>> lease" condition and begins returning NFS4ERR_EXPIRED if the client=
 should
>>>>>>> reconnect and attempt to use the (now) expired state.
>>>>>>>=20
>>>>>>> The default lease period for the Linux server is 90 seconds.  The t=
ypical
>>>>>>> client cuts that in half and will issue a lease renewing operation =
every
>>>>>>> 45 seconds. The 90 second lease period is very short considering th=
e
>>>>>>> potential for moderately long term network partitions.  A network p=
artition
>>>>>>> refers to any loss of network connectivity between the NFS client a=
nd the
>>>>>>> NFS server, regardless of its root cause.  This includes NIC failur=
es, NIC
>>>>>>> driver bugs, network misconfigurations & administrative errors, rou=
ters &
>>>>>>> switches crashing and/or having software updates applied, even down=
 to
>>>>>>> cables being physically pulled.  In most cases, these network failu=
res are
>>>>>>> transient, although the duration is unknown.
>>>>>>>=20
>>>>>>> A server which does not immediately expunge the state on lease expi=
ration
>>>>>>> is known as a Courteous Server.  A Courteous Server continues to re=
cognize
>>>>>>> previously generated state tokens as valid until conflict arises be=
tween
>>>>>>> the expired state and the requests from another client, or the serv=
er
>>>>>>> reboots.
>>>>>>>=20
>>>>>>> The initial implementation of the Courteous Server will do the foll=
owing:
>>>>>>>=20
>>>>>>> . When the laundromat thread detects an expired client and if that =
client
>>>>>>> still has established state on the Linux server and there is no wai=
ters
>>>>>>> for the client's locks then deletes the client persistent record an=
d marks
>>>>>>> the client as COURTESY_CLIENT and skips destroying the client and a=
ll of
>>>>>>> state, otherwise destroys the client as usual.
>>>>>>>=20
>>>>>>> . Client persistent record is added to the client database when the
>>>>>>> courtesy client reconnects and transits to normal client.
>>>>>>>=20
>>>>>>> . Lock/delegation/share reversation conflict with courtesy client i=
s
>>>>>>> resolved by marking the courtesy client as DESTROY_COURTESY_CLIENT,
>>>>>>> effectively disable it, then allow the current request to proceed
>>>>>>> immediately.
>>>>>>>=20
>>>>>>> . Courtesy client marked as DESTROY_COURTESY_CLIENT is not allowed =
to
>>>>>>> reconnect to reuse itsstate. It is expired by the laundromat asynch=
ronously
>>>>>>> in the background.
>>>>>>>=20
>>>>>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>>>>>> ---
>>>>>>> fs/nfsd/nfs4state.c | 454 +++++++++++++++++++++++++++++++++++++++++=
++++++-----
>>>>>>> fs/nfsd/state.h     |   5 +
>>>>>>> 2 files changed, 415 insertions(+), 44 deletions(-)
>>>>>>>=20
>>>>>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>>>>>> index 1956d377d1a6..b302d857e196 100644
>>>>>>> --- a/fs/nfsd/nfs4state.c
>>>>>>> +++ b/fs/nfsd/nfs4state.c
>>>>>>> @@ -1913,14 +1915,37 @@ __find_in_sessionid_hashtbl(struct nfs4_ses=
sionid *sessionid, struct net *net)
>>>>>>>=20
>>>>>>> static struct nfsd4_session *
>>>>>>> find_in_sessionid_hashtbl(struct nfs4_sessionid *sessionid, struct =
net *net,
>>>>>>> -		__be32 *ret)
>>>>>>> +		__be32 *ret, bool *courtesy_clnt)
>>>>>> IMO the new @courtesy_clnt parameter isn't necessary.
>>>>>> Just create a new cl_flag:
>>>>>>=20
>>>>>> +#define NFSD4_COURTESY_CLIENT		(6)	/* be nice to expired client */
>>>>>> +#define NFSD4_DESTROY_COURTESY_CLIENT	(7)
>>>>>>=20
>>>>>> #define NFSD4_CLIENT_PROMOTE_COURTESY   (8)
>>>>>>=20
>>>>>> or REHYDRATE_COURTESY some such.
>>>>>>=20
>>>>>> Set that flag and check it once it is safe to call
>>>>>> nfsd4_client_record_create().
>>>>> We need the 'courtesy_clnt' parameter so caller can specify
>>>>> whether the courtesy client should be promoted or not.
>>>> I understand what the flag is used for in the patch, but I
>>>> prefer to see this implemented without changing the synopsis
>>>> of all those functions. Especially adding an output parameter
>>>> like this is usually frowned upon.
>>>>=20
>>>> The struct nfs_client can carry this flag, if not in cl_flags,
>>>> then perhaps in another field. That struct is visible in every
>>>> one of the callers.
>>> The struct nfs4_client is not available to the caller of
>>> find_in_sessionid_hashtbl at the time it calls the function and
>>> the current input parameters of find_in_sessionid_hashtbl can
>>> not be used to specify this flag.
>> I see three callers of find_in_sessionid_hashtbl():
>>=20
>> - nfsd4_bind_conn_to_session
>> - nfsd4_destroy_session
>> - nfsd4_sequence
>>=20
>> In none of these callers is the courtesy_clnt variable set
>> to a true or false value _before_ find_in_sessionid_hashtbl()
>> is called. AFAICT, @courtesy_clnt is an output-only parameter.
>=20
> If a caller is interested in the courtesy client, it passes
> in the address of courtesy_clnt and find_in_sessionid_hashtbl
> will take appropriate action and return the result, otherwise
> pass in a NULL.

Dai, please get rid of @courtesy_clnt. All of the callers
can check the returned client's status. If they are not
interested in knowing whether the client needs to be
re-recorded, they can ignore that bit of information.

You need to address this before posting v11. Thanks!


> -Dai
>=20
>>=20
>> The returned @session::se_client field points to a client
>> that can be examined to see if it has been promoted back to
>> active status.
>>=20
>> --
>> Chuck Lever

--
Chuck Lever



