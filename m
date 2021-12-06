Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23E4C46AC10
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Dec 2021 23:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234195AbhLFWeU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Dec 2021 17:34:20 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:50176 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1357060AbhLFWeT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Dec 2021 17:34:19 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B6M5744019296;
        Mon, 6 Dec 2021 22:30:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=+hwSzP0+6cTVWrhBoBgxv/23LG+Z04KmKFWm/YqzId8=;
 b=A5DPk7c9SvWzyDB8Hm8eMW/ceF8czr7EIXJ8p2bBcR6im9bPvJ0WvGBmpRfVCZzp4p9u
 yja/xbnAKxyJAiDmDmNg3i/6YdIJ3w9RzzQir5ONM5ttIML16kRPZHkrmkpi+O8S2Qoo
 w5U7zRIicQcIKLVl7zQu82WeXsWY5xupjBSMXWvjwKCgAxaFjm7QPV547AM87MgJPxW+
 +NVo4CeDNoxRHL64Ytz8u6WqOocifq3rbNO6HCNC42tL6nWXjOF0rcCsBVycTGc3ZXIf
 xPmOX+38I0CFqNDbI6C98YGNdb/qb42PhoeCLtkX9ohmE8xQXggjHySb/BgF0hl5SHAA ZA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3csbbqm2jr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Dec 2021 22:30:48 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B6MB8QV055972;
        Mon, 6 Dec 2021 22:30:47 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2044.outbound.protection.outlook.com [104.47.73.44])
        by userp3030.oracle.com with ESMTP id 3cqwewqpya-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Dec 2021 22:30:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XijpcC9J4lbNTBhq7yk4UhTz1Kq6FrrWVU44oSBz8qTgVjksuAy3TG1ed30PpkV6JPwFukR3H6xpPJxKnd8Z1MfAY0l+d8wD6sJ6ytck1ogREgpddKqkywxi12MtW/63/5VO1VKlZdOTJLA8N8tMibqY5U6a7Zx8rB0Y79KyCSxHg7RgcJFnoJRpTsWiO0jxCtTfawrZG55lHfpDwU0MnUmlKDWYW2U6HRqYDViRNt8JsOqGB+wYPGMzuzK2BsiwpFVfBbIM1D5Pho+JdznM2KiGrFRiFbCiGLuvFTxg0CSo7uDfCobCootJKmceLUXI6vp3h7ExMmgYnHavIIhYbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+hwSzP0+6cTVWrhBoBgxv/23LG+Z04KmKFWm/YqzId8=;
 b=V/Fv9H0Nm4OjiRnyFLf6hGyvwxjNfXvoyNxXx4eDUYVxZTfkUNF2IqNZbV2uIgsWjBB57SmlBluNlq6o7jaEZOA1gGcTCjN4KtNdOxCfkAfvq90cXzvY18Gy3xvFYUNaLktBZ3aC27xzsRzrUSAsx0zj6KHHNx/vriXPrCNrU3aGBgjaBG9WM6IY2+QDAI6z0dsoD3NZUucqSFJzUYm3ytqIKfqv9+ESLO3aHrT/qfcCTEnFCrrbGoYrd1TuneJG9x9nFM+/HsV5CYoXCcbc6Xo3mMPKCBK/NKmyodTgcKjhNub6kflQdDdVUUC/O3/L1WOMz08cNOVSdivFENLz9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+hwSzP0+6cTVWrhBoBgxv/23LG+Z04KmKFWm/YqzId8=;
 b=OIB1B+QFjgwz6Dj16M9N+FObt1otCUsuLZj6CWpE/P/J2pfgeT7ZjnYSZ6RuP06E+OwsblHpyOMUkZ70aJQTtjsyQhtpBvD9A4EaIFphCrjELJfqvEmqZclqqlmmapmTCumE1Yx5eWOcu4eAkyJzJ2OKsa7zHckgI4ldh43Vvy8=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17)
 by CH2PR10MB4358.namprd10.prod.outlook.com (2603:10b6:610:a8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Mon, 6 Dec
 2021 22:30:45 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::a4f2:aef4:d02b:9bde]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::a4f2:aef4:d02b:9bde%9]) with mapi id 15.20.4755.021; Mon, 6 Dec 2021
 22:30:45 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RFC v6 2/2] nfsd: Initial implementation of NFSv4
 Courteous Server
Thread-Topic: [PATCH RFC v6 2/2] nfsd: Initial implementation of NFSv4
 Courteous Server
Thread-Index: AQHX6ssTAZRABZ1HqkCYuoltcOnBFawl4NyAgAAeY4CAAAz7AA==
Date:   Mon, 6 Dec 2021 22:30:45 +0000
Message-ID: <242C2259-2CF0-406F-B313-23D6D923C76F@oracle.com>
References: <20211206175942.47326-1-dai.ngo@oracle.com>
 <20211206175942.47326-3-dai.ngo@oracle.com>
 <4025C4F6-258F-4A2E-8715-05FD77052275@oracle.com>
 <01923a7c-bb49-c004-8a35-dbbae718e374@oracle.com>
In-Reply-To: <01923a7c-bb49-c004-8a35-dbbae718e374@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 18e188fd-c13f-46c3-bc85-08d9b9080b8b
x-ms-traffictypediagnostic: CH2PR10MB4358:EE_
x-microsoft-antispam-prvs: <CH2PR10MB4358B138EFF59FBA5CC4BA9A936D9@CH2PR10MB4358.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2QIRgmEY1p4W2UHWa9T7EPyTD57+81P89rFCpl6hZsLgQleAS+Y8nwpeavlkfbe1v0ksIQj+1nYZMiF4vh8XgMq5/A4uLPp1wmJq3UN6VpL6jandTzPRkR8MooM+DqVvEMx8WZARXnod3Fy/ruSZe9qiYc4vcu8bPo9BE2C70zVdK4LnI9NwGQgsWP5gpzbfwt/cLYxu3A+oZwKLfexFgUutPaxgPraASHdbmJ6YadRwjbH9+GF2Bo1yBVDAB6Ga4o5MwzoLAYqYE+6u3KNf4mdcbtTFnvKuwyp5ePIo9vns7sToondfgI/DbYFUuoUJBxFUezHpOfXfEy+a+CVsOonSHLPFmjnzX+J1ffXX/JBK6wiVwfC+4U+zVwxgy0AB/rBcll2It0unx67Ogfh9CMgTI4Etqt127bO0CxTIetVCLy6hL2r4/ZRF8Qdf4Yl5e1nkxhmcjLXsxotoUT/iGBQ9YmaY7Ae/EmWoirkLEZtZHR8SI9p6NPZ3xrGQ6Kr0O7df6yerPVMkfyiwUDAj614fCeWMQo+nkOeVWw/70gQ5/8c3Pa77h/9CKTGCNjUUygEpiiplQ9XjrVo8iyWjGhSnskmBk6QCES/epxPvgPpgRKjc8yyY9Zf53H2oKwdPwCFnmnZzWhFiQQPsd7TWvF0/3uo3iOHEse/jiithNrg1z2vCG39deuPXxdUVM/HfFuyt00KWxhqJB9JG9wQ5PnQwcQL5p9wc+lt1A/lZBVmGI2yIt8F5q6eyzk2yD7ZJqjr4oMFbqmgJ1Lzwg9fYpw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(4326008)(37006003)(54906003)(122000001)(33656002)(2616005)(8936002)(6862004)(6512007)(6486002)(38100700002)(316002)(6636002)(5660300002)(36756003)(66556008)(66476007)(66946007)(71200400001)(64756008)(66446008)(83380400001)(76116006)(26005)(186003)(6506007)(30864003)(508600001)(53546011)(8676002)(2906002)(38070700005)(86362001)(45980500001)(559001)(579004)(309714004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lmdd/B3xCYYI2vMcvOxVYprwq9ZnoXdsA9XWpxV9CfoscnOOy1CdHU4sTWp1?=
 =?us-ascii?Q?5q67zHYeyj2JSl20sevMoLOrT36xWGLMrwfSd5ydvKItnMnzij4UkwqHySba?=
 =?us-ascii?Q?KYKNDiY7grB9ra3N4jql7YsATI8qVPufN76CLUKTdEG/4YsCkcgC1LgK7ibu?=
 =?us-ascii?Q?CN+p9/B4fr1S2d8LGUs8sH9kUQR1zDNCHfKbJOKZuJdA1GdRubeUPmFyojDZ?=
 =?us-ascii?Q?PxrCLlYOct2vLnegL3UTB/oQjTy7KpsejOVHkOup9A3cdQK11H0l1zdBjDKc?=
 =?us-ascii?Q?nM7BZkuLdpMV/PT14EKfXazu+kACUfNDJRGe5QGP8NPHASsiDRdsyZ6KBpQN?=
 =?us-ascii?Q?aSarhOo+ICZp8kShAshQv4i/j80dTFY1QZwWHqgSDnojrdgxH+XOlb0OOAHn?=
 =?us-ascii?Q?F46F2BDIPFL4/hZltWLSleRXnJfam4EkM7QjKXb9H9Ml39cnZ85TPaqwOm3l?=
 =?us-ascii?Q?4DPLHuHr4skFEILsKvz+3m2mAYPg+yejdvbnD+Xkni3Vem77HVCJQLKkezAn?=
 =?us-ascii?Q?WDfgcPpgQbAnfAxtSzWR2q3f+l9Q9BaLLNhoe+f02l1ILd3wjn3NL0YJd91q?=
 =?us-ascii?Q?k7gQSQwO2LxHc0fdxwHTMzlL6VnAi/PHWhTaG2i/34HHQNtBHz6MUPXv4tCs?=
 =?us-ascii?Q?tXfcfFAM2QjTnZYtBA15Fs3TwH1pIuoRl/bqtyB4yJMsSmle+IEbTQXs2/Ke?=
 =?us-ascii?Q?qJV1VyKiDusoukyycU8XRDgQG75qkugDrUoMst4Thn/OlMGNMwF//KWX8Elh?=
 =?us-ascii?Q?JGhJyyBvDpGluz1rUzMO6uT86TLo7B8TQfHs/e2Hg2KqUfPHEQ5HvxreS0uW?=
 =?us-ascii?Q?vkhh35fo1OpXUcWcIy/0yEf14MNIspDEwIRA4sQp9UHhtFys84mNOHQTo95J?=
 =?us-ascii?Q?BNHtBf68Im6uBVuDcswtXlrykMNXUEo2pYX/Wz13+tw4FIPoDgrrprt6og7Z?=
 =?us-ascii?Q?1jETX4J4C/7D3JwaKlEnD0QaGIIZ68ALvd1jlKDyHBw4b3t1q4xSChbdKMJk?=
 =?us-ascii?Q?/r0egvzVEptZhmPzpwtxv23dgVtMsI+2zQ0+UmeBJrORWoEHruvQ9dau1AOG?=
 =?us-ascii?Q?LTqtyJuRa87+NJ/Xk2ESiuWHsAU/GI0oy8GF1hqbjGNosNoc+JznSmagPyRb?=
 =?us-ascii?Q?R0e13ki+O1bL7jFVRdngoo8DuRg2ALBI933Wzhs2MJvprb+N9n6oUn0JCwm9?=
 =?us-ascii?Q?yXpWPS4FS+jzk6Fh7ALk/tW0qubt09h8/40+FWILxNCy2ep6NhLWaiBOhGom?=
 =?us-ascii?Q?AxUIcizvQdT9dvMBYovM7HrnT5quuyG1oUZ+zSznxMcvDaNOxW+Ipoqmjypp?=
 =?us-ascii?Q?8x9vAeazGBJzcK5tY7BifKY1MxyO1q4WE67f0qEmtyko99CmcMp/nbEupEeo?=
 =?us-ascii?Q?Ns9hvRy36d7+N1NPZdeNIooJGWTs+Muvg+t6coooZEOYT4huxQ5B8f7qwkbD?=
 =?us-ascii?Q?5kTP5JZg+kLSQUj5R/vzyRadXGOM4vBGW9zNPMEUit0c3HpTxlQX7JDUHUR1?=
 =?us-ascii?Q?sonRbMNsBrusvu/5i0HIQDWuYZNkQwFkp/BQFX/IxGlPru5YOMRS8B8BNa7U?=
 =?us-ascii?Q?roBNmgLbdieTebmB5eOV3+ZqcPvN1lc/62kYHtOtZMemD2DmMYPVqLmKNn1E?=
 =?us-ascii?Q?qQD/QQGY5HNs4q77AkTX7Ow=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CD52EFBAC115DA4BA87A5453B951E501@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18e188fd-c13f-46c3-bc85-08d9b9080b8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2021 22:30:45.3383
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e6jZ/SOYnlbOvgLmpWaq0djXHywgMk/8gL5ltomwA4MscbpY8oZOlp8mbS63cIEzNLBGaiezrUq0FZIcJSKo3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4358
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10190 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112060137
X-Proofpoint-GUID: hte2wIMVR1KVUHI6pUwJmaU3ZfmX2jIb
X-Proofpoint-ORIG-GUID: hte2wIMVR1KVUHI6pUwJmaU3ZfmX2jIb
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Dec 6, 2021, at 4:44 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
>=20
> On 12/6/21 11:55 AM, Chuck Lever III wrote:
>> Hi Dai-
>>=20
>> Some comments and questions below:
>>=20
>>=20
>>> On Dec 6, 2021, at 12:59 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>>=20
>>> Currently an NFSv4 client must maintain its lease by using the at least
>>> one of the state tokens or if nothing else, by issuing a RENEW (4.0), o=
r
>>> a singleton SEQUENCE (4.1) at least once during each lease period. If t=
he
>>> client fails to renew the lease, for any reason, the Linux server expun=
ges
>>> the state tokens immediately upon detection of the "failure to renew th=
e
>>> lease" condition and begins returning NFS4ERR_EXPIRED if the client sho=
uld
>>> reconnect and attempt to use the (now) expired state.
>>>=20
>>> The default lease period for the Linux server is 90 seconds.  The typic=
al
>>> client cuts that in half and will issue a lease renewing operation ever=
y
>>> 45 seconds. The 90 second lease period is very short considering the
>>> potential for moderately long term network partitions.  A network parti=
tion
>>> refers to any loss of network connectivity between the NFS client and t=
he
>>> NFS server, regardless of its root cause.  This includes NIC failures, =
NIC
>>> driver bugs, network misconfigurations & administrative errors, routers=
 &
>>> switches crashing and/or having software updates applied, even down to
>>> cables being physically pulled.  In most cases, these network failures =
are
>>> transient, although the duration is unknown.
>>>=20
>>> A server which does not immediately expunge the state on lease expirati=
on
>>> is known as a Courteous Server.  A Courteous Server continues to recogn=
ize
>>> previously generated state tokens as valid until conflict arises betwee=
n
>>> the expired state and the requests from another client, or the server
>>> reboots.
>>>=20
>>> The initial implementation of the Courteous Server will do the followin=
g:
>>>=20
>>> . when the laundromat thread detects an expired client and if that clie=
nt
>>> still has established states on the Linux server and there is no waiter=
s
>>> for the client's locks then mark the client as a COURTESY_CLIENT and sk=
ip
>>> destroying the client and all its states, otherwise destroy the client =
as
>>> usual.
>>>=20
>>> . detects conflict of OPEN request with COURTESY_CLIENT, destroys the
>>> expired client and all its states, skips the delegation recall then all=
ows
>>> the conflicting request to succeed.
>>>=20
>>> . detects conflict of LOCK/LOCKT, NLM LOCK and TEST, and local locks
>>> requests with COURTESY_CLIENT, destroys the expired client and all its
>>> states then allows the conflicting request to succeed.
>>>=20
>>> . detects conflict of LOCK/LOCKT, NLM LOCK and TEST, and local locks
>>> requests with COURTESY_CLIENT, destroys the expired client and all its
>>> states then allows the conflicting request to succeed.
>>>=20
>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>> ---
>>> fs/nfsd/nfs4state.c | 293 +++++++++++++++++++++++++++++++++++++++++++++=
++++++-
>>> fs/nfsd/state.h     |   3 +
>>> 2 files changed, 293 insertions(+), 3 deletions(-)
>>>=20
>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>> index 3f4027a5de88..759f61dc6685 100644
>>> --- a/fs/nfsd/nfs4state.c
>>> +++ b/fs/nfsd/nfs4state.c
>>> @@ -125,6 +125,11 @@ static void free_session(struct nfsd4_session *);
>>> static const struct nfsd4_callback_ops nfsd4_cb_recall_ops;
>>> static const struct nfsd4_callback_ops nfsd4_cb_notify_lock_ops;
>>>=20
>>> +static struct workqueue_struct *laundry_wq;
>>> +static void laundromat_main(struct work_struct *);
>>> +
>>> +static int courtesy_client_expiry =3D (24 * 60 * 60);	/* in secs */

Btw, why is this a variable? It could be "static const int"
or even better, just a macro.


>>> +
>>> static bool is_session_dead(struct nfsd4_session *ses)
>>> {
>>> 	return ses->se_flags & NFS4_SESSION_DEAD;
>>> @@ -172,6 +177,7 @@ renew_client_locked(struct nfs4_client *clp)
>>>=20
>>> 	list_move_tail(&clp->cl_lru, &nn->client_lru);
>>> 	clp->cl_time =3D ktime_get_boottime_seconds();
>>> +	clear_bit(NFSD4_COURTESY_CLIENT, &clp->cl_flags);
>>> }
>>>=20
>>> static void put_client_renew_locked(struct nfs4_client *clp)
>>> @@ -2389,6 +2395,10 @@ static int client_info_show(struct seq_file *m, =
void *v)
>>> 		seq_puts(m, "status: confirmed\n");
>>> 	else
>>> 		seq_puts(m, "status: unconfirmed\n");
>>> +	seq_printf(m, "courtesy client: %s\n",
>>> +		test_bit(NFSD4_COURTESY_CLIENT, &clp->cl_flags) ? "yes" : "no");
>>> +	seq_printf(m, "seconds from last renew: %lld\n",
>>> +		ktime_get_boottime_seconds() - clp->cl_time);
>>> 	seq_printf(m, "name: ");
>>> 	seq_quote_mem(m, clp->cl_name.data, clp->cl_name.len);
>>> 	seq_printf(m, "\nminor version: %d\n", clp->cl_minorversion);
>>> @@ -4662,6 +4672,33 @@ static void nfsd_break_one_deleg(struct nfs4_del=
egation *dp)
>>> 	nfsd4_run_cb(&dp->dl_recall);
>>> }
>>>=20
>>> +/*
>>> + * This function is called when a file is opened and there is a
>>> + * delegation conflict with another client. If the other client
>>> + * is a courtesy client then kick start the laundromat to destroy
>>> + * it.
>>> + */
>>> +static bool
>>> +nfsd_check_courtesy_client(struct nfs4_delegation *dp)
>>> +{
>>> +	struct svc_rqst *rqst;
>>> +	struct nfs4_client *clp =3D dp->dl_recall.cb_clp;
>>> +	struct nfsd_net *nn =3D net_generic(clp->net, nfsd_net_id);
>>> +
>>> +	if (!i_am_nfsd())
>>> +		goto out;
>>> +	rqst =3D kthread_data(current);
>>> +	if (rqst->rq_prog !=3D NFS_PROGRAM || rqst->rq_vers < 4)
>>> +		return false;
>>> +out:
>>> +	if (test_bit(NFSD4_COURTESY_CLIENT, &clp->cl_flags)) {
>>> +		set_bit(NFSD4_DESTROY_COURTESY_CLIENT, &clp->cl_flags);
>>> +		mod_delayed_work(laundry_wq, &nn->laundromat_work, 0);
>>> +		return true;
>>> +	}
>>> +	return false;
>>> +}
>>> +
>>> /* Called from break_lease() with i_lock held. */
>>> static bool
>>> nfsd_break_deleg_cb(struct file_lock *fl)
>>> @@ -4670,6 +4707,8 @@ nfsd_break_deleg_cb(struct file_lock *fl)
>>> 	struct nfs4_delegation *dp =3D (struct nfs4_delegation *)fl->fl_owner;
>>> 	struct nfs4_file *fp =3D dp->dl_stid.sc_file;
>>>=20
>>> +	if (nfsd_check_courtesy_client(dp))
>>> +		return false;
>>> 	trace_nfsd_cb_recall(&dp->dl_stid);
>>>=20
>>> 	/*
>>> @@ -4912,6 +4951,136 @@ nfsd4_truncate(struct svc_rqst *rqstp, struct s=
vc_fh *fh,
>>> 	return nfsd_setattr(rqstp, fh, &iattr, 0, (time64_t)0);
>>> }
>>>=20
>>> +static bool
>>> +__nfs4_check_deny_bmap(struct nfs4_ol_stateid *stp, u32 access,
>>> +			bool share_access)
>>> +{
>>> +	if (share_access) {
>>> +		if (!stp->st_deny_bmap)
>>> +			return false;
>>> +
>>> +		if ((stp->st_deny_bmap & (1 << NFS4_SHARE_DENY_BOTH)) ||
>> Aren't the NFS4_SHARE_DENY macros already bit masks?
>>=20
>> NFS4_SHARE_DENY_BOTH is (NFS4_SHARE_DENY_READ | NFS4_SHARE_DENY_WRITE).
>=20
> I think the protocol defines these as constants and nfsd uses them
> to set the bitmap in st_deny_bmap. See set_deny().

OK, this is really confusing.

5142         set_deny(open->op_share_deny, stp);
5143         fp->fi_share_deny |=3D (open->op_share_deny & NFS4_SHARE_DENY_=
BOTH);

Here set_deny() is treating the contents of open->op_share_deny
as bit positions, but then upon return NFS4_SHARE_DENY_BOTH
is used directly as a bit mask. Am I reading this correctly?

But that's not your problem, so I'll let that be.

You need to refactor this passage to manage the code duplication
and the long lines, and use BIT() instead of open-coding the
shift.


>>> +			(access & NFS4_SHARE_ACCESS_READ &&
>>> +				stp->st_deny_bmap & (1 << NFS4_SHARE_DENY_READ)) ||
>>> +			(access & NFS4_SHARE_ACCESS_WRITE &&
>>> +				stp->st_deny_bmap & (1 << NFS4_SHARE_DENY_WRITE))) {
>>> +			return true;
>>> +		}
>>> +		return false;
>>> +	}
>>> +	if ((access & NFS4_SHARE_DENY_BOTH) ||
>>> +		(access & NFS4_SHARE_DENY_READ &&
>>> +			stp->st_access_bmap & (1 << NFS4_SHARE_ACCESS_READ)) ||
>>> +		(access & NFS4_SHARE_DENY_WRITE &&
>>> +			stp->st_access_bmap & (1 << NFS4_SHARE_ACCESS_WRITE))) {
>>> +		return true;
>>> +	}
>>> +	return false;
>>> +}
>>> +
>>> +/*
>>> + * access: if share_access is true then check access mode else check d=
eny mode
>>> + */
>>> +static bool
>>> +nfs4_check_deny_bmap(struct nfs4_client *clp, struct nfs4_file *fp,
>>> +		struct nfs4_ol_stateid *st, u32 access, bool share_access)
>>> +{
>>> +	int i;
>>> +	struct nfs4_openowner *oo;
>>> +	struct nfs4_stateowner *so, *tmp;
>>> +	struct nfs4_ol_stateid *stp, *stmp;
>>> +
>>> +	spin_lock(&clp->cl_lock);
>>> +	for (i =3D 0; i < OWNER_HASH_SIZE; i++) {
>>> +		list_for_each_entry_safe(so, tmp, &clp->cl_ownerstr_hashtbl[i],
>>> +					so_strhash) {
>>> +			if (!so->so_is_open_owner)
>>> +				continue;
>>> +			oo =3D openowner(so);
>>> +			list_for_each_entry_safe(stp, stmp,
>>> +				&oo->oo_owner.so_stateids, st_perstateowner) {
>>> +				if (stp =3D=3D st || stp->st_stid.sc_file !=3D fp)
>>> +					continue;
>>> +				if (__nfs4_check_deny_bmap(stp, access,
>>> +							share_access)) {
>>> +					spin_unlock(&clp->cl_lock);
>>> +					return true;
>>> +				}
>>> +			}
>>> +		}
>>> +	}
>>> +	spin_unlock(&clp->cl_lock);
>>> +	return false;
>>> +}
>>> +
>>> +/*
>>> + * Function to check if the nfserr_share_denied error for 'fp' resulte=
d
>>> + * from conflict with courtesy clients then release their state to res=
olve
>>> + * the conflict.
>>> + *
>>> + * Function returns:
>>> + *	 0 -  no conflict with courtesy clients
>>> + *	>0 -  conflict with courtesy clients resolved, try access/deny chec=
k again
>>> + *	-1 -  conflict with courtesy clients being resolved in background
>>> + *            return nfserr_jukebox to NFS client
>>> + */
>>> +static int
>>> +nfs4_destroy_clnts_with_sresv_conflict(struct svc_rqst *rqstp,
>>> +			struct nfs4_file *fp, struct nfs4_ol_stateid *stp,
>>> +			u32 access, bool share_access)
>>> +{
>>> +	int cnt =3D 0;
>>> +	int async_cnt =3D 0;
>>> +	bool no_retry =3D false;
>>> +	struct nfs4_client *cl;
>>> +	struct list_head *pos, *next, reaplist;
>>> +	struct nfsd_net *nn =3D net_generic(SVC_NET(rqstp), nfsd_net_id);
>>> +
>>> +	INIT_LIST_HEAD(&reaplist);
>>> +	spin_lock(&nn->client_lock);
>>> +	list_for_each_safe(pos, next, &nn->client_lru) {
>>> +		cl =3D list_entry(pos, struct nfs4_client, cl_lru);
>>> +		/*
>>> +		 * check all nfs4_ol_stateid of this client
>>> +		 * for conflicts with 'access'mode.
>>> +		 */
>>> +		if (nfs4_check_deny_bmap(cl, fp, stp, access, share_access)) {
>>> +			if (!test_bit(NFSD4_COURTESY_CLIENT, &cl->cl_flags)) {
>>> +				/* conflict with non-courtesy client */
>>> +				no_retry =3D true;
>>> +				cnt =3D 0;
>>> +				goto out;
>>> +			}
>>> +			/*
>>> +			 * if too many to resolve synchronously
>>> +			 * then do the rest in background
>>> +			 */
>>> +			if (cnt > 100) {
>>> +				set_bit(NFSD4_DESTROY_COURTESY_CLIENT, &cl->cl_flags);
>>> +				async_cnt++;
>>> +				continue;
>>> +			}
>>> +			if (mark_client_expired_locked(cl))
>>> +				continue;
>>> +			cnt++;
>>> +			list_add(&cl->cl_lru, &reaplist);
>>> +		}
>>> +	}
>> Bruce suggested simply returning NFS4ERR_DELAY for all cases.
>> That would simplify this quite a bit for what is a rare edge
>> case.
>=20
> If we always do NFS4ERR_DELAY then we have to modify pynfs' OPEN18
> to handle NFS4ERR_DELAY.

Changing the test case seems reasonable to me. A complete test
should handle NFS4ERR_DELAY, right?


> Since I don't think this code is overly
> complicated and most of the time in real usage, if there is a share
> reservation conflict nfsd should be able to resolve it synchronously
> avoiding the NFS4ERR_DELAY and also it'd be nice if we don't have
> to modify pynfs test.

You're adding a magic number (100) here. That is immediately a
sign that we are doing some guessing and handwaving.

In the long run it's better if we don't have a case that would
be used most of the time (the synchronous case) and one that
would hardly ever used or tested (the async case). Guess which
one will grow fallow?

Having just one case means that one is always tested and working.


>>> +out:
>>> +	spin_unlock(&nn->client_lock);
>>> +	list_for_each_safe(pos, next, &reaplist) {
>>> +		cl =3D list_entry(pos, struct nfs4_client, cl_lru);
>>> +		list_del_init(&cl->cl_lru);
>>> +		expire_client(cl);
>>> +	}
>> A slightly nicer construct here would be something like this:
>>=20
>> 	while ((pos =3D list_del_first(&reaplist)))
>> 		expire_client(list_entry(pos, struct nfs4_client, cl_lru));
>=20
> You meant llist_del_first?

No, that's for wait-free lists. How about list_first_entry_or_null() ...


> The above code follows the style in nfs4_laundromat. Can I keep the
> same to avoid doing retest?

The use of "list_for_each_safe()" is overkill because the loop
deletes the front of the list on each iteration. Technically
correct, but more complicated than you need and there's no
justification for it.


>>> +	if (async_cnt) {
>>> +		mod_delayed_work(laundry_wq, &nn->laundromat_work, 0);
>>> +		if (!no_retry)
>>> +			cnt =3D -1;
>>> +	}
>>> +	return cnt;
>>> +}
>>> +
>>> static __be32 nfs4_get_vfs_file(struct svc_rqst *rqstp, struct nfs4_fil=
e *fp,
>>> 		struct svc_fh *cur_fh, struct nfs4_ol_stateid *stp,
>>> 		struct nfsd4_open *open)
>>> @@ -4921,6 +5090,7 @@ static __be32 nfs4_get_vfs_file(struct svc_rqst *=
rqstp, struct nfs4_file *fp,
>>> 	int oflag =3D nfs4_access_to_omode(open->op_share_access);
>>> 	int access =3D nfs4_access_to_access(open->op_share_access);
>>> 	unsigned char old_access_bmap, old_deny_bmap;
>>> +	int cnt =3D 0;
>>>=20
>>> 	spin_lock(&fp->fi_lock);
>>>=20
>>> @@ -4928,16 +5098,38 @@ static __be32 nfs4_get_vfs_file(struct svc_rqst=
 *rqstp, struct nfs4_file *fp,
>>> 	 * Are we trying to set a deny mode that would conflict with
>>> 	 * current access?
>>> 	 */
>>> +chk_deny:
>>> 	status =3D nfs4_file_check_deny(fp, open->op_share_deny);
>>> 	if (status !=3D nfs_ok) {
>>> 		spin_unlock(&fp->fi_lock);
>>> +		if (status !=3D nfserr_share_denied)
>>> +			goto out;
>>> +		cnt =3D nfs4_destroy_clnts_with_sresv_conflict(rqstp, fp,
>>> +				stp, open->op_share_deny, false);
>>> +		if (cnt > 0) {
>>> +			spin_lock(&fp->fi_lock);
>>> +			goto chk_deny;
>> I'm pondering whether a distributed set of clients can
>> cause this loop to never terminate.
>=20
> I'm not clear how we can get into an infinite loop, can you elaborate?

I don't see anything that _guarantees_ that eventually
nfs4_destroy_clnts_with_sresv_conflict() will return a
value of 0 or less.


> To get into an infinite loop, there must be stream of new clients that
> open the file with the conflict access mode *and* become courtesy client
> before we finish expiring all existing courtesy clients that have access
> conflict this OPEN.

>>> +		}
>>> +		if (cnt =3D=3D -1)
>>> +			status =3D nfserr_jukebox;
>>> 		goto out;
>>> 	}
>>>=20
>>> 	/* set access to the file */
>>> +get_access:
>>> 	status =3D nfs4_file_get_access(fp, open->op_share_access);
>>> 	if (status !=3D nfs_ok) {
>>> 		spin_unlock(&fp->fi_lock);
>>> +		if (status !=3D nfserr_share_denied)
>>> +			goto out;
>>> +		cnt =3D nfs4_destroy_clnts_with_sresv_conflict(rqstp, fp,
>>> +				stp, open->op_share_access, true);
>>> +		if (cnt > 0) {
>>> +			spin_lock(&fp->fi_lock);
>>> +			goto get_access;
>> Ditto.
>>=20
>>=20
>>> +		}
>>> +		if (cnt =3D=3D -1)
>>> +			status =3D nfserr_jukebox;
>>> 		goto out;
>>> 	}
>>>=20
>>> @@ -5289,6 +5481,22 @@ static void nfsd4_deleg_xgrade_none_ext(struct n=
fsd4_open *open,
>>> 	 */
>>> }
>>>=20
>>> +static bool
>>> +nfs4_destroy_courtesy_client(struct nfs4_client *clp)
>>> +{
>>> +	struct nfsd_net *nn =3D net_generic(clp->net, nfsd_net_id);
>>> +
>>> +	spin_lock(&nn->client_lock);
>>> +	if (!test_bit(NFSD4_COURTESY_CLIENT, &clp->cl_flags) ||
>>> +			mark_client_expired_locked(clp)) {
>>> +		spin_unlock(&nn->client_lock);
>>> +		return false;
>>> +	}
>>> +	spin_unlock(&nn->client_lock);
>>> +	expire_client(clp);
>>> +	return true;
>>> +}
>>> +
>> Perhaps nfs4_destroy_courtesy_client() could be merged into
>> nfsd4_fl_expire_lock(), it's only caller.
>=20
> ok, will be in v7 patch.
>=20
>>=20
>>=20
>>> __be32
>>> nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, =
struct nfsd4_open *open)
>>> {
>>> @@ -5572,6 +5780,47 @@ static void nfsd4_ssc_expire_umount(struct nfsd_=
net *nn)
>>> }
>>> #endif
>>>=20
>>> +static
>>> +bool nfs4_anylock_conflict(struct nfs4_client *clp)
>>> +{
>>> +	int i;
>>> +	struct nfs4_stateowner *so, *tmp;
>>> +	struct nfs4_lockowner *lo;
>>> +	struct nfs4_ol_stateid *stp;
>>> +	struct nfs4_file *nf;
>>> +	struct inode *ino;
>>> +	struct file_lock_context *ctx;
>>> +	struct file_lock *fl;
>>> +
>>> +	for (i =3D 0; i < OWNER_HASH_SIZE; i++) {
>>> +		/* scan each lock owner */
>>> +		list_for_each_entry_safe(so, tmp, &clp->cl_ownerstr_hashtbl[i],
>>> +				so_strhash) {
>>> +			if (so->so_is_open_owner)
>>> +				continue;
>> Isn't cl_lock needed to protect the cl_ownerstr_hashtbl lists?
>=20
> Yes, thanks Chuck! will be in v7
>=20
>>=20
>>=20
>>> +
>>> +			/* scan lock states of this lock owner */
>>> +			lo =3D lockowner(so);
>>> +			list_for_each_entry(stp, &lo->lo_owner.so_stateids,
>>> +					st_perstateowner) {
>>> +				nf =3D stp->st_stid.sc_file;
>>> +				ino =3D nf->fi_inode;
>>> +				ctx =3D ino->i_flctx;
>>> +				if (!ctx)
>>> +					continue;
>>> +				/* check each lock belongs to this lock state */
>>> +				list_for_each_entry(fl, &ctx->flc_posix, fl_list) {
>>> +					if (fl->fl_owner !=3D lo)
>>> +						continue;
>>> +					if (!list_empty(&fl->fl_blocked_requests))
>>> +						return true;
>>> +				}
>>> +			}
>>> +		}
>>> +	}
>>> +	return false;
>>> +}
>>> +
>>> static time64_t
>>> nfs4_laundromat(struct nfsd_net *nn)
>>> {
>>> @@ -5587,7 +5836,9 @@ nfs4_laundromat(struct nfsd_net *nn)
>>> 	};
>>> 	struct nfs4_cpntf_state *cps;
>>> 	copy_stateid_t *cps_t;
>>> +	struct nfs4_stid *stid;
>>> 	int i;
>>> +	int id =3D 0;
>>>=20
>>> 	if (clients_still_reclaiming(nn)) {
>>> 		lt.new_timeo =3D 0;
>>> @@ -5608,8 +5859,33 @@ nfs4_laundromat(struct nfsd_net *nn)
>>> 	spin_lock(&nn->client_lock);
>>> 	list_for_each_safe(pos, next, &nn->client_lru) {
>>> 		clp =3D list_entry(pos, struct nfs4_client, cl_lru);
>>> +		if (test_bit(NFSD4_DESTROY_COURTESY_CLIENT, &clp->cl_flags)) {
>>> +			clear_bit(NFSD4_COURTESY_CLIENT, &clp->cl_flags);
>>> +			goto exp_client;
>>> +		}
>>> +		if (test_bit(NFSD4_COURTESY_CLIENT, &clp->cl_flags)) {
>>> +			if (ktime_get_boottime_seconds() >=3D clp->courtesy_client_expiry)
>>> +				goto exp_client;
>>> +			/*
>>> +			 * after umount, v4.0 client is still
>>> +			 * around waiting to be expired
>>> +			 */
>>> +			if (clp->cl_minorversion)
>>> +				continue;
>>> +		}
>>> 		if (!state_expired(&lt, clp->cl_time))
>>> 			break;
>>> +		spin_lock(&clp->cl_lock);
>>> +		stid =3D idr_get_next(&clp->cl_stateids, &id);
>>> +		spin_unlock(&clp->cl_lock);
>>> +		if (stid && !nfs4_anylock_conflict(clp)) {
>>> +			/* client still has states */
>>> +			clp->courtesy_client_expiry =3D
>>> +				ktime_get_boottime_seconds() + courtesy_client_expiry;
>>> +			set_bit(NFSD4_COURTESY_CLIENT, &clp->cl_flags);
>>> +			continue;
>>> +		}
>>> +exp_client:
>>> 		if (mark_client_expired_locked(clp))
>>> 			continue;
>>> 		list_add(&clp->cl_lru, &reaplist);
>>> @@ -5689,9 +5965,6 @@ nfs4_laundromat(struct nfsd_net *nn)
>>> 	return max_t(time64_t, lt.new_timeo, NFSD_LAUNDROMAT_MINTIMEOUT);
>>> }
>>>=20
>>> -static struct workqueue_struct *laundry_wq;
>>> -static void laundromat_main(struct work_struct *);
>>> -
>>> static void
>>> laundromat_main(struct work_struct *laundry)
>>> {
>>> @@ -6496,6 +6769,19 @@ nfs4_transform_lock_offset(struct file_lock *loc=
k)
>>> 		lock->fl_end =3D OFFSET_MAX;
>>> }
>>>=20
>>> +/* return true if lock was expired else return false */
>>> +static bool
>>> +nfsd4_fl_expire_lock(struct file_lock *fl, bool testonly)
>>> +{
>>> +	struct nfs4_lockowner *lo =3D (struct nfs4_lockowner *)fl->fl_owner;
>>> +	struct nfs4_client *clp =3D lo->lo_owner.so_client;
>>> +
>>> +	if (testonly)
>>> +		return test_bit(NFSD4_COURTESY_CLIENT, &clp->cl_flags) ?
>>> +			true : false;
>> Hm. I know test_bit() returns an integer rather than a boolean, but
>> the ternary here is a bit unwieldy. How about just:
>>=20
>> 		return !!test_bit(NFSD4_COURTESY_CLIENT, &clp->cl_flags);
>=20
> ok, will be in v7.
>=20
>>=20
>>=20
>>> +	return nfs4_destroy_courtesy_client(clp);
>>> +}
>>> +
>>> static fl_owner_t
>>> nfsd4_fl_get_owner(fl_owner_t owner)
>>> {
>>> @@ -6543,6 +6829,7 @@ static const struct lock_manager_operations nfsd_=
posix_mng_ops  =3D {
>>> 	.lm_notify =3D nfsd4_lm_notify,
>>> 	.lm_get_owner =3D nfsd4_fl_get_owner,
>>> 	.lm_put_owner =3D nfsd4_fl_put_owner,
>>> +	.lm_expire_lock =3D nfsd4_fl_expire_lock,
>>> };
>>>=20
>>> static inline void
>>> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
>>> index e73bdbb1634a..93e30b101578 100644
>>> --- a/fs/nfsd/state.h
>>> +++ b/fs/nfsd/state.h
>>> @@ -345,6 +345,8 @@ struct nfs4_client {
>>> #define NFSD4_CLIENT_UPCALL_LOCK	(5)	/* upcall serialization */
>>> #define NFSD4_CLIENT_CB_FLAG_MASK	(1 << NFSD4_CLIENT_CB_UPDATE | \
>>> 					 1 << NFSD4_CLIENT_CB_KILL)
>>> +#define NFSD4_COURTESY_CLIENT		(6)	/* be nice to expired client */
>>> +#define NFSD4_DESTROY_COURTESY_CLIENT	(7)
>>> 	unsigned long		cl_flags;
>>> 	const struct cred	*cl_cb_cred;
>>> 	struct rpc_clnt		*cl_cb_client;
>>> @@ -385,6 +387,7 @@ struct nfs4_client {
>>> 	struct list_head	async_copies;	/* list of async copies */
>>> 	spinlock_t		async_lock;	/* lock for async copies */
>>> 	atomic_t		cl_cb_inflight;	/* Outstanding callbacks */
>>> +	int			courtesy_client_expiry;
>>> };
>>>=20
>>> /* struct nfs4_client_reset
>>> --=20
>>> 2.9.5
>>>=20
>> --
>> Chuck Lever

--
Chuck Lever



