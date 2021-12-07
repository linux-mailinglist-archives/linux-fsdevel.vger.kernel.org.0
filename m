Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4909E46C70B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Dec 2021 23:00:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240714AbhLGWEB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Dec 2021 17:04:01 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:7222 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239120AbhLGWD6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Dec 2021 17:03:58 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B7L5JTG021499;
        Tue, 7 Dec 2021 22:00:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=SoKNYDWfP3HSXcxa7BRl4qvO6EiRLVIR4o0mu8LIKuA=;
 b=foWQ7angbGRuT/cQc+j9KlDgExwoQfn0082Vg/7XQtt3LfTrJ0mzheICFuc29fkcTasU
 alXKiNm9awOs2clahuYvSUCs155k2s+4n+L6DQc6rI0jz3b0olOiJmsb/cUBt+FpGXUm
 G9ImsyCMqxMQyaOBshiZtaID2ZaUeW1TNesj/TpcGaRyR68QmpZ3jsFX9K/n/1vhzQxb
 yIRP1e685zKIgsoSsvg21m3IuRScB3tnsh/0QSlzfiZyg7uqF0qXv3soQ9wuj8c6cc7P
 GaKw9cAgiJnwDbo/IzB1rqLFoWk0ifqafk5TgtSZS55RsTAY5Wn3ATegtkgYGdDqcjXo Zg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3csd2yef5s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Dec 2021 22:00:25 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B7LpDhG192510;
        Tue, 7 Dec 2021 22:00:24 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by userp3030.oracle.com with ESMTP id 3cqweydthy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Dec 2021 22:00:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KzPyK3Wa+wJ5vL+1tWgaNdIPws9Syn2Ec0l/gQaRSw1YrSYHZRN2hN7z7pqVUxaGaClGxrzx7oRod5h2nRnh2SnU8ycWnxtUJiERaa8K9PbE7n7TbiigKCVDM/aladbXHi3dImqhD4hRCfHhb/KjiK5AUDe5pyBPCy/sgYdVz+7XJYq2dBfIJYlgituhMZ+Jb/SkwP9+5bBDcML+yjMVUSRf5EPyHMBcY+6hwMiZYzXs+6+dhM0v281ePHiXnv8iFFjYfhjZvR9DbgQ2bwxkvwuLvEPvbTrXZQAoE+uqTnZM55nfYybEW3EITcCsn+cFyR7bpKQdbDA6ZcdcGZgpJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SoKNYDWfP3HSXcxa7BRl4qvO6EiRLVIR4o0mu8LIKuA=;
 b=U/qCE3CFD6pogkpfCPgdUI86EJXSCliyJsalAJGtI3OKPY9c6xDjMlslaW+KMGUFlqUrp5VQ89Qpm5hmOqJTH+U5ZodbS+sNTHPwbyZuipW1ggtVErXY55q1Hl+1l2E0MR3r11UOeLDAPL5f2flA9cgP8dpG46JaqCFNbGsMfKyuxB0ptRXHvWVGUjk+tHWgifvWW084oBNMOHT7OF3REHuK3BrW/IJdFQzELm/1OYV1T6pRHDt4HdzzDSc5ITMkiWUNmuuvRwkMzJpBucoxD6mwOoB4vL0wbsMRQEPU6l3nn8KJB5C4ES33JqKxdIvo2mLlx1wexQCUfssH7bmYeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SoKNYDWfP3HSXcxa7BRl4qvO6EiRLVIR4o0mu8LIKuA=;
 b=Umx2c9qoSLu9uF0ktsVWTX6G/9xiJLzIqqkfR4hLOC0m/h1wdQF/rd9SpHm2e1i+6ncVDnfN+yTGGh06uaqsZZWWvDF5rvcCFWuNAVV9aGfpJovLe6Dn02XU4PACpztxmVOG+pMO88P+oRcxEDSaK/AdUqXn94Ea4XY+ocLoymQ=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17)
 by CH0PR10MB5145.namprd10.prod.outlook.com (2603:10b6:610:db::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Tue, 7 Dec
 2021 22:00:22 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::a4f2:aef4:d02b:9bde]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::a4f2:aef4:d02b:9bde%9]) with mapi id 15.20.4755.022; Tue, 7 Dec 2021
 22:00:22 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@fieldses.org>
CC:     Dai Ngo <dai.ngo@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RFC v6 2/2] nfsd: Initial implementation of NFSv4
 Courteous Server
Thread-Topic: [PATCH RFC v6 2/2] nfsd: Initial implementation of NFSv4
 Courteous Server
Thread-Index: AQHX6ssTAZRABZ1HqkCYuoltcOnBFawl4NyAgAAeY4CAAAz7AIAABiuAgAGDrIA=
Date:   Tue, 7 Dec 2021 22:00:22 +0000
Message-ID: <DEB6A7B8-0772-487F-8861-BEB924259860@oracle.com>
References: <20211206175942.47326-1-dai.ngo@oracle.com>
 <20211206175942.47326-3-dai.ngo@oracle.com>
 <4025C4F6-258F-4A2E-8715-05FD77052275@oracle.com>
 <01923a7c-bb49-c004-8a35-dbbae718e374@oracle.com>
 <242C2259-2CF0-406F-B313-23D6D923C76F@oracle.com>
 <20211206225249.GE20244@fieldses.org>
In-Reply-To: <20211206225249.GE20244@fieldses.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ea157984-d9de-4b03-3d26-08d9b9ccf754
x-ms-traffictypediagnostic: CH0PR10MB5145:EE_
x-microsoft-antispam-prvs: <CH0PR10MB5145EAA48494CD3E2E61BB6A936E9@CH0PR10MB5145.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mQUV52RhH9wgKIdXrm/SxI7qFjOII+jgFJ3t32HfdXpm8zheu2Fw2im5rhc2VftbCHWaMExxLwIA5xvahRPg+aUWaSuu0dNwWE9wZLo2KrIGtPqfnTtgdsQbApkXXzWoePPWrWeRoB8MKW7spjTVNsGUG3+Eq/P3uydP/DQnnwsUDxhfB6GaaxJk+f3lOEHOocf+OPsPQdsf7FZniryCO/vo+I9kH7NP0dIZQR4hVKttocAU9Tm12ySXznEpGtVVWjLkMqeiOABxBMHYOmQ9bc/4UIFJfyq7BbbqYoyCQENIpL1tOXilhjUSBlqhiIih0ejF5XDNm0fcBCq+gagKPrhym63XCtdE2RHwzvwkbLTsAAGMC79op0XM7VwQNI6BTl3zcKvAwsL1O4+6ldTvoENYvI3Z/eyj8znxinM3AAd1bqp8reXUGYiHQ7r5m3X/mGsOpLG7MKIjoPAlVZa2+HL1LQ9j4FDoIV0ZH7kz9vvCkjKwH5+KBsw7vCvRVChQFLO3x7HPdAMDnbESPMSVW/p6wD+TBFZMWJLFeqSssGQzQ17iIbfLGcKqV8cJv/Ok7OZa+UqLaTCcbyesByvgYZcFBJgZs7iL8DgssSqW0wpnyPaMwOaMFlBeWeFUcrd4EfFrNDX9/u1E0dld7qvoNC00aGFBf2WDrzu65v5CoqbBVSyMFrupFt4VFOD9DzqK2YcyKq04q/ENkK5pRWSSeRl0e4Hf8Nz0ZbQ38AUBQn/akAdBuIaEwl0YZTyYAT/Udk30SdVK4rzCzbJfB56tUARtALxOjq9bAiWOux28Q3wLGspLGBr/vBSateqG97zy
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2906002)(86362001)(26005)(71200400001)(6486002)(8676002)(2616005)(5660300002)(122000001)(36756003)(54906003)(4326008)(53546011)(6506007)(6512007)(8936002)(186003)(6916009)(66476007)(66556008)(66446008)(76116006)(66946007)(508600001)(38070700005)(316002)(966005)(33656002)(64756008)(38100700002)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?n7dzw3uD8rFDtczg/J7UpAyI7OyMn9xQBcpusxhfVsyfWGq/mydTiXpE3k+o?=
 =?us-ascii?Q?/IlEVuaWyvNwJrp7RBEVQGdzzvRp1PEWWUEHRkqCSz0aTpc+9G9zAad98zfp?=
 =?us-ascii?Q?YwWcyet04LVOE8vI7/PyPFgiE2V+XD7YRva5ZPS+GeS5K98kWjLg7ABR4j76?=
 =?us-ascii?Q?IJrZRKWpe1DKlRt5Hc5/nKKTkc3zKdu6uR98Kaf0LaVIeOxIP4jhnXzHZAVz?=
 =?us-ascii?Q?p3Z9o3Q+BMTCludbflluPDRrkNpwRqlODWBpUsXICVXPwwM7hKWwNzNnwQWg?=
 =?us-ascii?Q?jQRlmGm4uykGJAVQtXO07KHseIRhKjdgE/olvUnqbaYWDn+HuNuxBF3Jg1zs?=
 =?us-ascii?Q?k6/qpjX/NICWiQRhiAzYO8hHSou3bDMUkyaGtcYILGBcE04b71AICeVGccek?=
 =?us-ascii?Q?7wzQeF+9hfwPvRgJsn6cBDc/MhwdOGeklWHb5xH/kRtoA6bpkbp0QnWyTsDX?=
 =?us-ascii?Q?slLC+vPRRHlcKUkJNOArIbCN/XtGdLbjbAVDsf5Jz3THGsy5JttNktDH1Dae?=
 =?us-ascii?Q?bN8Kp9QVDUH2nNL/5FFZuE1dl1y8t9QdXIW8trbm/v/L04n+fME4lPZbZuAv?=
 =?us-ascii?Q?n+eF5lKr+xqNPr86f14InFsqNLpJbKCIVj2eYLpftcUTjBTmftZtUxakdGs9?=
 =?us-ascii?Q?DAqTZgZHJLHc34MX/eJR56UpaxFUCWw9TjFmryPH1R4HGw1ZwzieOcHW/9wX?=
 =?us-ascii?Q?R/zXSQvAXMd5A5hBNisw59uJ18J6/7isM6FbuxMHqoPYTmTZXCDHPSBbvBe2?=
 =?us-ascii?Q?HyrEk0geH118x69P7HOv4YYnI9Z3Wo+fyH1OAOHBZ8Zzzv5Jd3VEdAaMHtV2?=
 =?us-ascii?Q?M1jKFCU//sMIR7EB2bP7nCk+PGGTYO8nsgVo+UXf1UsY7BAybL4JfQNp2I1u?=
 =?us-ascii?Q?ZSjXlGfY15LfBkQb+yhAIXo6FdQfgdaIaLrGKKBdkzxl1NI+7RER7eNOpo7i?=
 =?us-ascii?Q?3Ca+P3VXJVsiWcrl/bcnSWsEGeM2C9e0m2ybyTMaTk7mn5lHh6ntcFfVdIWz?=
 =?us-ascii?Q?0BacMOF3/jn8WN0UiPJXjaGEmqaoPC/0eGCMqPup9jiU73Z20LUW8XM8dovk?=
 =?us-ascii?Q?TLAip9IBxj8Kp4HTXicOG49vYmOLYfbt7VLagrbQr2NtrgwDUFdHMopsjBq9?=
 =?us-ascii?Q?X9m322jMQr2Ua5S6eOMK6V8hD+YcYsSNdgLUZ3tesfDBBg71RzzPYbTUQquv?=
 =?us-ascii?Q?RHYnfU5xpWwaCrcKgwh+kLdYa2TcHkE82sU4KUzqj+a2pOTQrbehSffhgO5l?=
 =?us-ascii?Q?BK7Im+3PWsQuak1WJMQWccV62gml02hfDGPXQXAzqHvETb4P4S4PMjYPZ64d?=
 =?us-ascii?Q?HI7X5gVfjh2SPO7LhmOutNTFaAt6l1WeyIseHjqNxTFVbZbzk62twCz7ed2Z?=
 =?us-ascii?Q?VE4veOEkKZpVaecpqCiMZ5a6ZylIg/5FljdyY8WHJXGjp1DQBQIWzaRgGIWJ?=
 =?us-ascii?Q?EDTMpBohsS5JRY9QvZGuzZVpWa3IqQGYat9ClhslTgHuw7j+kdwvM7s9hkPp?=
 =?us-ascii?Q?N7FQg81GcJ0HYvkFTZvYkE8pj4Etc0iGQ9ZwtiupGLjIcIu5XV2WzLx5TwYg?=
 =?us-ascii?Q?1uUvEZdxhtObycJAHF0B1G4KsqSHfk8ke9KhGdTx2mwTO4DaaoszgHRuGVA9?=
 =?us-ascii?Q?m16OiB7kvO+FypnBy7KPnSY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5E21BCF4B00DF642B3B6CA6B46B2A8C9@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea157984-d9de-4b03-3d26-08d9b9ccf754
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2021 22:00:22.2450
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QKj2TFilIkMAJSzdvQJyv/HfdHhLlXWooqBk/wZypubb8U6taqvu7dq98sHQDbHHj8IIzj3s4ivv0BE4Gu2+zA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5145
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10191 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112070134
X-Proofpoint-GUID: rSgY64D-tJbotaPZnO5O-b9D7G3tlgp9
X-Proofpoint-ORIG-GUID: rSgY64D-tJbotaPZnO5O-b9D7G3tlgp9
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Dec 6, 2021, at 5:52 PM, Bruce Fields <bfields@fieldses.org> wrote:
>=20
> On Mon, Dec 06, 2021 at 10:30:45PM +0000, Chuck Lever III wrote:
>> OK, this is really confusing.
>>=20
>> 5142         set_deny(open->op_share_deny, stp);
>> 5143         fp->fi_share_deny |=3D (open->op_share_deny & NFS4_SHARE_DE=
NY_BOTH);
>>=20
>> Here set_deny() is treating the contents of open->op_share_deny
>> as bit positions, but then upon return NFS4_SHARE_DENY_BOTH
>> is used directly as a bit mask. Am I reading this correctly?
>>=20
>> But that's not your problem, so I'll let that be.
>=20
> This is weird but intentional.
>=20
> For most practical purposes, fi_share_deny is all that matters.
>=20
> BUT, there is also this language in the spec for OPEN_DOWNGRADE:
>=20
> 	https://datatracker.ietf.org/doc/html/rfc5661#section-18.18.3
>=20
> 	The bits in share_deny SHOULD equal the union of the share_deny
> 	bits specified for some subset of the OPENs in effect for the
> 	current open-owner on the current file.
>=20
> 	If the above constraints are not respected, the server SHOULD
> 	return the error NFS4ERR_INVAL.
>=20
> If you open a file twice, once with DENY_READ, once with DENY_WRITE,
> then that is not *quite* the same as opening it once with DENY_BOTH.  In
> the former case, you're allowed to, for example, downgrade to DENY_READ.
> In the latter, you're not.
>=20
> So if we want to the server to follow that SHOULD, we need to remember
> not only that the union of all the DENYs so far, you also need to
> remember the different DENY modes that different OPENs were done with.
>=20
> So, we also keep the st_deny_bmap with that information.
>=20
> The same goes for allow bits (hence there's also an st_access_bmap).
>=20
> It's arguably a lot of extra busy work just for one SHOULD that has no
> justification other than just to be persnickety about client
> behavior....

Thanks for clarifying! If you are feeling industrious, it would be nice
for this to be documented somewhere in the source code....


--
Chuck Lever



