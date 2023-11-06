Return-Path: <linux-fsdevel+bounces-2095-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2227E2634
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 14:58:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9148F28158C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 13:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B61725103;
	Mon,  6 Nov 2023 13:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="F/xG9O7S";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gUaT5BuQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C2A23777
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 13:58:43 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE1B13E;
	Mon,  6 Nov 2023 05:58:39 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A6D26bl011532;
	Mon, 6 Nov 2023 13:58:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=OX5sgHA1z3EIWaDZHkYHFMW0wqP6pKJmKJ1kMUr9PXY=;
 b=F/xG9O7SJOIzenAxNQmdG6om0kJ1NWW4AVatNJ8X05OboXuwx4UeKEnytUGLb7LC5pMA
 mYszFjYdCtjyVBif3SHHYoKW7T5op31GA0vF2Flc5meHonQNeowDoVNafzmlzQoi+0UB
 pVzGUpx9QIVjyZhB0lQyROFPLOB9UJOuoWRsmLby9CJEZ1x82ZjYvlEamvgRokG21+mX
 OZgw0bdm33BxpNqxX5yZLgK22iAemSG+6tXNhBZezfu31fM1d30kURLxSWMjbPeFUoRN
 qwXLY7Gi6ZQSpsDbgu/Q0+qvIu81IB+SCwcq+FsPs26afFVHvptIyB6kAljiGvAhtcS1 7w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u5cj2u5bv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 Nov 2023 13:58:26 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A6D0ST1023602;
	Mon, 6 Nov 2023 13:58:25 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u5cd4vp9p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 Nov 2023 13:58:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oiu9BgETNk1bITvmO8uD6p0ErEmABpV9Ycm02JIqkDW1a6oNqB0jfn29mPRgaOFMoRC8vuD/73bHcr4IG6xucQjiNnXCwR2Ay07+G5Dce26XI8bIB5nlBAm1BcZ9oq1FX8Okqm31fUm+7cuKVDQUAWnbROIKME6Gl3Y5n/3nqgsWLKE8FIo/OqQTXit3hTHu1DdO1BG31TiQouvuIu5PZ3xs4Rjasx4oex68lcRwfbbNh0i/rnEdEzIEYairthELpJPrUDbPscel/2yyij5Z0e93O9LdwG6OHCttF93LLO0+nD/eMHCRAKaLOh54QzR0nxvP+A/s8vg0brE7LNhBjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OX5sgHA1z3EIWaDZHkYHFMW0wqP6pKJmKJ1kMUr9PXY=;
 b=AKuPfNMSltPTrueLdpkHnMM0jMRLYagQBIWqjxWEVqWz3an8odbMSlTrQXbO8xb9RlQ1Ky1dBlfDBPX3ngRmfxXSwLb805d8dxK6OWARs/mQCV9niaKxrygF/YpKef3LquOjzrcXUtvDh1L8I33Ms+OUtqEifYMAN1ZAEjUFCfL9N0ckwYqgyRH6OEcS0cKPjXhkmfu8GDIQiJOjS6sWRVQXDCLHVLoQCw3SqlE4SBe5gehXkXXdpNsC7dPZqfAhul8VgKj/J9EHeW2Mg1XMKXMZf7Fg+Jjl9AW41goiDMtOwudeGMFj5KyZLTNw1BS+dEJggRcn/FRH3G0m80YGgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OX5sgHA1z3EIWaDZHkYHFMW0wqP6pKJmKJ1kMUr9PXY=;
 b=gUaT5BuQi5P7tkJel137HNxu2lAjZqeCaADaVRgEP8+7R32PTUQCCxQzQRGPZroMfCRQ/tna2BA7wA21So0b4a00/ANDrlNi31Zgxfcz+SD2YVQtWhphbbRNX3xbrdSENGc4M9QmylVf6HRt71s57WYA1ApN+W55jRQWenWZBUA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH3PR10MB6810.namprd10.prod.outlook.com (2603:10b6:610:140::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.22; Mon, 6 Nov
 2023 13:58:23 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::3474:7bf6:94fe:4ef1]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::3474:7bf6:94fe:4ef1%3]) with mapi id 15.20.6954.028; Mon, 6 Nov 2023
 13:58:23 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Donald Buczek <buczek@molgen.mpg.de>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: Heisenbug: I/O freeze can be resolved by cat $task/cmdline of
 unrelated process
Thread-Topic: Heisenbug: I/O freeze can be resolved by cat $task/cmdline of
 unrelated process
Thread-Index: AQHaD8wf9wfCnocwJkyj2TZn1rGbbrBtUvcA
Date: Mon, 6 Nov 2023 13:58:22 +0000
Message-ID: <9822F555-42F5-44AD-8056-469E85A86C3D@oracle.com>
References: <77184fcc-46ab-4d69-b163-368264fa49f7@molgen.mpg.de>
In-Reply-To: <77184fcc-46ab-4d69-b163-368264fa49f7@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CH3PR10MB6810:EE_
x-ms-office365-filtering-correlation-id: bb6cdee1-bf4c-4759-be39-08dbded070ce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 vyw7HXuAi4ew8a7QBCaIyHISZOa2FVOScb+waYKwmE2drfNTA0QDB2tamzZ6/sBAHCQFRFDTKhersZDYak1yVb30nqZma55e8n9Z4b7A3StUn9Tv5V7Mk2i1T0U15Yi7gqLswzF5cSS/jG+89nnmCHCp7fIRWYNyGbA4Bis13kDiVV/vMc3lfvN1tG2xj2u/0iHtbhS3kKY6vmZ19RN/xYZfwMsIuTlQqmCmu+5KoL/uBPm0xRbaUCKw8SckCxxewiK9Z/AJTwp/E5SRnMOwAOuYcZbFc1ZaJVl2lhkSyG2hhTMwaDw7W54VtlmsdrWkzfyt4c7lYQlvZVWqX4euhalTUA86WB2cu5gLkCtMfM/195I3K0UFmLXSLXgonH6CuSy0IozzhzCDIQqpDijCOEysEVHDf8M8fK5IPz1t2njEtazdQ42o5gb4KXgqXLZ6BzDTyeYJ5hf08N2EzN2RiEGbrjquzpD0WMqCmVndVkq10BuPa9UNLXIHMKmBjirJ0NvrHsCDQOFU4BqpPZKRdolu/6PHFX+lmKYpOTuR98YlWkrotpy27pOJsGrffMRpoR7zOxSOvU9grJ01J4rvYAYcxu1NLLiVE/xI57T3BUmR1WfWxnjDCrNlImtWQ7Ts6nSepnrSvxS+KctlrfCdrA==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(366004)(376002)(39860400002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(8936002)(122000001)(26005)(2616005)(71200400001)(53546011)(6506007)(38100700002)(83380400001)(6512007)(6486002)(478600001)(66946007)(91956017)(76116006)(66556008)(54906003)(6916009)(64756008)(5660300002)(38070700009)(66446008)(41300700001)(316002)(4326008)(66476007)(2906002)(36756003)(8676002)(86362001)(33656002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?QRLPUupgQGQr2WF67h4w8sfBlbqBsE8MIiTlQ9b5Gcgf4ACiBQUWI2YaX6PK?=
 =?us-ascii?Q?9fyeJOmNsZCC5pd/SwhogGMYnMKVAdwv0qBIz3VaaotLSUtqfM4R+feVtNvR?=
 =?us-ascii?Q?KOJt/2Muj6hQ3i1EZ20bESQsL4DNEexsw/75LuSlTWVoP74tCtBCOWxGJn0s?=
 =?us-ascii?Q?qURul9z4I+JFXnfOT4EHFzOqLG/TyqxRCoZ8Gvv29fwy5MMiiY7rC9/8lei1?=
 =?us-ascii?Q?ZMKZLikElloIyfQCeRuUQ8NWaJ9wa7zaNJ2omVhxBrQxHzGxOfHCgWaRoecx?=
 =?us-ascii?Q?zuEShaX63a03KenVc3rvW94w58A54ZopBMzY1KXNXmqZnQlvBVvIQQiBOuEw?=
 =?us-ascii?Q?RA5PLsFjqVIl1cO6xcRRtz+s8exH82Jr33DwhWjQH35np4Ba7TT1fHcE7xLz?=
 =?us-ascii?Q?JUXRBSBdzJeA+ss+LerXdpkU0neXs8zACKYHeOJv97KoKYAdzhxD8kxh+mZR?=
 =?us-ascii?Q?kHlEThgUbva88Lf5ySNl0Rnm3gvtt4zqhGpfnPhyp6WNCchcFF3c2h7y2iVi?=
 =?us-ascii?Q?I8e1nOLIO8AHIlfx95P2Hir+FmqcW8d8pZo7h1tRVulnmc7dxANAXcRc6oVZ?=
 =?us-ascii?Q?RmQxjJUQNdQuEPQOy+u/z3E61GNHUFpGl4u/2E/cICfy0VaidChDO+pSzOk7?=
 =?us-ascii?Q?4bAGQlk0fPDxTX4wmt9Iz/MwcNNdatxJdX0D5jQ9ON0PApdtoQSO2C1VyCsB?=
 =?us-ascii?Q?K8+k7+0GLdkxY2s4UC3cEbqQaFR3EI87tP3NLrgczz8i/UIb4E+22AJWGpOK?=
 =?us-ascii?Q?uZgF0OC9tYBKHKDYjrvz0tQLC0u/9Goe5s0tywqp2Pyg2RWVJ29oyF6FD9vM?=
 =?us-ascii?Q?49w1nSOqC6s2w6KMwHt7Os/Yi2VzVNr1oHgbldGlT9H9VBYH4+P0EQSE4qlv?=
 =?us-ascii?Q?AY/cKAXzOJFksWvP/EGeiioY7MVPVkrxp4DIu7UcKV/yTPUL/Q2Z6j+ZEEQH?=
 =?us-ascii?Q?WELrrt8i7+qKaHGYA6ha1lLj/GYY9k2xl7RKVziOtViT5agPgaBzGOVz+oaM?=
 =?us-ascii?Q?qM+3wezveJXQ/1OvlLdakZHQvjt7P72AVfpTaXQAfG1XqYClJayysJmcjGNg?=
 =?us-ascii?Q?41qG/sggZwr2hWKfkKr8wj4tF+UOUaWufmLCNTUu5+GYta8vjS75rUrrce/A?=
 =?us-ascii?Q?E0L2+5BYKXknzERNzlLRqkfrmQIUEBNriyAVmLb3VRjme1+dUF90HVNU/5vs?=
 =?us-ascii?Q?Cnx65yu/lIdtO76fJhKPKb0YQ2aPZ1nkiOPVcGi7U31wiXNxxMdlwoMxAKL/?=
 =?us-ascii?Q?B1XqKzmh6o6u9zEFfCtEr1q3IhpBfMOAUw11L9fZtUHQ/zOLB8w8fA/HuZcu?=
 =?us-ascii?Q?JX114dSN5x50UKvwEhUpSGtd/wIASVP21ee8vDyiNuAybwy3oVSaluldrc/2?=
 =?us-ascii?Q?nQ/QDK76W6ZsHbZFUGxxXXI4sPo6bitKhZjfKyyUVB8xA5ThpmYDypPeJocV?=
 =?us-ascii?Q?ObOuPB6ZkfNDSMHQnQfk1c0Mp3n4LRxRKp5zlR7WLMotY2xcZ9SPvRq+zpn4?=
 =?us-ascii?Q?owSCHXpzynopC4AiPMq+YRpjpQ3/oDoLyedi/onAGasRTOaR6mC0Ppvz2tKZ?=
 =?us-ascii?Q?1UJJolhAovZiqv7bVwssAWm6rLiIXiWoEdECYSELNaRR8P1FnZcZl8+d4O1y?=
 =?us-ascii?Q?cQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D714127A55769B4FBB0EBB476B1BFFC5@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ePbFMhxelKuxQ4Z3rjvbIfiYOVH0Plga1Rh15uHFw5LX+7u+Nqbe/gk04PrKqloDR1HKnJzJo38g3AQHyHbECajhT0+PWjrz3+CN8sLCp6iM/w3//uD2q5H6UwuB9Jjr8+sGiPp9keNy9wmpNM/d64aP0WmTs54BhLHLOOSM+IHZltzH0lfCXdX0B3BuL0R8zF/Q9JySf2eKBQTXxbCyaJcezqHoUb3GFv2cfNGmkCIhbRrfFgVAgWMSJ1xbefDjeZYsXKTJ5EvtSXS5sfZhK0BlT/KIbYa2IVmcRpUh5tL8oPzit24Ze061lCbd4yiiGi1ikp+4/mIs8icvfXtRxrd/KhR77dM/ntCK4oXnlQFHU6Oyht53qdxHwS+3dEtQKY2IC2H96IWxkAcA4yvuYmXgZa4abjAJ45bZZt/zd7xZ+DhaUNhC0Ay0+QdtpFynGpOBg+pkM4vjoHignirqLzDQPp54UIqMBhEF2+WR008wFVVouGHqAsSHgx9rt3jmbXrIew8OOP+Yyg998EUA/C3NRjjPxwpD7fadiI/DEZ1oUXuadMUaEic2I+UC9VmsmQqoOFo3VxruiyVClxrtq0VzM3m/AGJtO/1N2wFOpWDfYhgXlMTaGcg41sTQtcBZ8uyliB7Ld7tIN/gHVQldF44ov2UrnYZqsr+d4OSmaVaPNFucQtOZNgeLBzlWzxtuuMHE3vH04mBgUl5iwwWi3Y4hefkZJLGvMm4k3mQTdqud4wj/P1i76Z2cOWkfFw2YSbh0UGtIQmbVnjwwzFITvlowWxZsD7XedlMitrdEkek=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb6cdee1-bf4c-4759-be39-08dbded070ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2023 13:58:22.9772
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mSDXFPh/Nl/j+F7XxDWfLiPqkfsQeGzWUoYtDNIRCeRRxLwI7xvTF5MPKkCZQDdzipSUEwjjJ60RQG/vvJROlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6810
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-06_12,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 suspectscore=0 phishscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2311060113
X-Proofpoint-ORIG-GUID: 36NRgISih62OGqkcixYqJhzNMBgjyquu
X-Proofpoint-GUID: 36NRgISih62OGqkcixYqJhzNMBgjyquu



> On Nov 5, 2023, at 4:40 AM, Donald Buczek <buczek@molgen.mpg.de> wrote:
>=20
> Hello, experts,
>=20
> we have a strange new problem on a backup server (high metadata I/O 24/7,=
 xfs -> mdraid). The system worked for years and with v5.15.86 for 8 month.=
 Then we've updated to 6.1.52 and after a few hours it froze: No more I/O a=
ctivity to one of its filesystems, processes trying to access it blocked un=
til we reboot.
>=20
> Of course, at first we blamed the kernel as this happened after an upgrad=
e. But after several experiments with different kernel versions, we've retu=
rned to the v5.15.86 kernel we used before, but still experienced the probl=
em. Then we suspected, that a microcode update (for AMD EPYC 7261), which h=
appened as a side effect of the first reboot, might be the culprit and remo=
ved it. That didn't fix it either. For all I can say, all software is back =
to the state which worked before.
>=20
> Now the strange part: What we usually do, when we have a situation like t=
his, is that we run a script which takes several procfs and sysfs informati=
on which happened to be useful in the past. It was soon discovered, that ju=
st running this script unblocks the system. I/O continues as if nothing eve=
r happened. Then we singled-stepped the operations of the script to find ou=
t, what action exactly gets the system to resume. It is this part:
>=20
>    for task in /proc/*/task/*; do
>        echo  "# # $task: $(cat $task/comm) : $(cat $task/cmdline | xargs =
-0 echo)"
>        cmd cat $task/stack
>    done
>=20
> which can further be reduced to
>=20
>    for task in /proc/*/task/*; do echo $task $(cat $task/cmdline | xargs =
-0 echo); done
>=20
> This is absolutely reproducible. Above line unblocks the system reliably.
>=20
> Another remarkable thing: We've modified above code to do the processes s=
lowly one by one and checking after each step if I/O resumed. And each time=
 we've tested that, it was one of the 64 nfsd processes (but not the very f=
irst one tried). While the systems exports filesystems, we have absolutely =
no reason to assume, that any client actually tries to access this nfs serv=
er. Additionally, when the full script is run, the stack traces show all nf=
sd tasks in their normal idle state ( [<0>] svc_recv+0x7bd/0x8d0 [sunrpc] )=
.
>=20
> Does anybody have an idea, how a `cat /proc/PID/cmdline` on a specific as=
sumed-to-be-idle nfsd thread could have such an "healing" effect?
>=20
> I'm well aware, that, for example, a hardware problem might result in jus=
t anything and that the question might not be answerable at all. If so: ple=
ase excuse the noise.

I'm with Neil on this: I believe the nfsd thread happens to be in the
wrong place at the wrong time. When idle, an nfsd thread is nothing
more than a plain kthread waiting in the kernel's scheduler.

If you have an opportunity, try testing without starting up the NFSD
service. You might find that the symptoms move to another thread or
subsystem.


--
Chuck Lever



