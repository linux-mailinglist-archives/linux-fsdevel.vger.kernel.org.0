Return-Path: <linux-fsdevel+bounces-8708-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7184083A838
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 12:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFEE71F27C32
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 11:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11BEF54F9E;
	Wed, 24 Jan 2024 11:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PxRv4HLp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fooCP7Xz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984E050A8B;
	Wed, 24 Jan 2024 11:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706096386; cv=fail; b=LsRCw8cQ08s5/5Qt58lb1X8Ahxn7ba8jvVBH2XpfWxrONSBQHJitLv7nyITHQVIYo4Rz/PGG5Tm/rXPYHQHY12jmwwl+eFrWr14ZfOUHXvFIf1iHunOeRJsvCofHPioKlbIx6WgUE5Rdv3AyvUnlDrTYtsn3WtwV9q/qGWkz0wo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706096386; c=relaxed/simple;
	bh=LLgflnzDfZh/eGcm6r4ptBZvmUO2fCiYcgNc+1tZ0u8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LknyCHtw1VY0RlfbEePJzyjBTnzrMgQ7ZwEop0w4o2xIYZh7qwe2cUHJS/BnDN6HK5ewfMAdHFOUsIs81p2iICIS/TwjCCbafy3mk4CkjfMyzTvIhqe6gEmCeIZe7lRskRxBZPZ18Hko7fzWqRPPZbGp+nvPOafqDCPbZn4FLCg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PxRv4HLp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fooCP7Xz; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40OAwsYQ009416;
	Wed, 24 Jan 2024 11:39:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=N33x0AgmSk/inaBUpiL120sCppRmMyE4ZMGnb6eay8I=;
 b=PxRv4HLpSCKP2+RIJYU085jeZYVeyCfMxhs+QgHeS8oNFX2LmLpuFWUczPRecLziejxW
 cpH3RF53Kk4yus7+orBuIsYQRxL/fITz0vUEHiLPOsDPoNsEDXCWzPbQiPmHILzo00WN
 RqrXp+JTzr0H+6F+B2uN74lBBwbn124M51MY59DxXTdgOKbFn6wIukSpgDjH/zF44Ps+
 aNnT8o/Im7J1o5AQSzHBVeC8axxHPuMe9lZGWAXfafFZPsXQNJBsMBlG7dTsZxywwie6
 6BjyWWxnaWalyxGBpWLH3t2jVCCusdK+M0GFfJ4BMaQiM3Owj5ZDFqDCHZ3bafu385Jp Cw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr7cy1tx9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 11:39:22 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40OAobaH040723;
	Wed, 24 Jan 2024 11:39:21 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vs316wnws-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 11:39:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S/Q/parSJ81CHCpuXlsLr7b0RuDyIQl5Mi/eIC0LF73W5z6cNE7AME0kgLEAqPWslKDi2QXF0miXM+NQGa46/gp1VrahjeCNKXtF39UJ3nvcrzccNbdtxZdxlgGXVytqagnTPjEHCktT1uMNjYeD80G5aYFo/g0O3r6iq7yux0t+Ikrn/DDlhJgm4ItLTxXC2gqvIo6+OC1LoLzwXwsRld9PFCXUbNWBYnWYqMI4gZyBL0EVgezSdodPYNM1sll628ar3dQwo2IaWhDPxULxFYQXddKiqweOlqU5h71DnZyGxPDaKpP16LynpDIqIiscVQuYJ0Sy3ccyJn8N2RL6CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N33x0AgmSk/inaBUpiL120sCppRmMyE4ZMGnb6eay8I=;
 b=JI6TwBB4N+fw9xTLNY2/nyDGC2F6SZ0EWTnAnGjy96pV1Ihf5Ml6jFmBMrIwe1YwBnAsgVtGbwiwaUUvZClrEvzYrL0GD3+NgF3mr4OpTil/JnsfwH/QFJY/m7F2+rustbXr9l/v8J+tqnSFIMonOguLXpFisUqt+E/gOXkJCpWaQOqwJc3tneVzoIKQSFQFJTLBVplmi9rhAMITSvglWAmzGjO9oxZIZzGO4z1llm6nGFrQbEXRhIH6Uc/i3odKhXleYWW+KTlByemgtuocDIAgo+7QJiw25z7/hmvPqfWHROHZxqKOaYVaDaaN7UYP4zyvw2syZexB8nyqq8bjZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N33x0AgmSk/inaBUpiL120sCppRmMyE4ZMGnb6eay8I=;
 b=fooCP7Xz957AlBEgZ8T9rnn6BAeJwX0Z4Ru5HxVo7aLB0+8MLijXi6GKjfylC0BNpQLKchkZ6/ZZd3pNZ02tSYfpoYqdl36qpizk2f7EQvpdgODmMyDW7ewcp34VAzX7fWg88WxRp/wdXNfBbxphPHRnqkeT3MOfba409DhBytA=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB5815.namprd10.prod.outlook.com (2603:10b6:510:126::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 11:39:20 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::f11:7303:66e7:286c]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::f11:7303:66e7:286c%5]) with mapi id 15.20.7228.022; Wed, 24 Jan 2024
 11:39:19 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
        jack@suse.cz
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-scsi@vger.kernel.org, ming.lei@redhat.com, ojaswin@linux.ibm.com,
        bvanassche@acm.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3 10/15] block: Add fops atomic write support
Date: Wed, 24 Jan 2024 11:38:36 +0000
Message-Id: <20240124113841.31824-11-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240124113841.31824-1-john.g.garry@oracle.com>
References: <20240124113841.31824-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0158.namprd03.prod.outlook.com
 (2603:10b6:208:32f::24) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB5815:EE_
X-MS-Office365-Filtering-Correlation-Id: eee08816-ee24-47ce-5438-08dc1cd11a68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	SApAgXlyQUNV8N7Sk7PEW5YN+Q5F0IGH6lk/PmmWcgKqfJYF2uweFTTDb1Zj/6JRHBl00Kji/YBTblsji1l2YQoHNZ5Pwd2CCrNXFuZaKHC/U88QF/HgucbZBZumjLrWCqrZru4FZVunHL5TIC/5Ie77AvyOMnuFcFyUvf+TTXy8VOaAdYyqF8HazEYxtQNNeIfBwsAtgKhOnq09w9DZlq21CY1Hum+Sz2/ke1zpmhrvXm5wWDY3CCb6rYKhWsCrEHq4Y+L/gm5QPjBhqjYTcU6K6pzpsB6952af2WjajykyWQnFH8yyXQHApW/OwabfJcijjkeQrHYO1wQWtCPGKZwXikwo2jgR82/Q81BkZBdT/geBnx2Swmlc7uWoV8wM1OLhtJNLQ471Zsx/5OCB4mechJ2l7d+rvAQMm3fEnc9IMz5sKmTD36h6AnDp5nnEgAU/PB0OfeS4ZLEjayp7JF63tuJB7tTUJVsd8VL1SiB1+YZ1AKo5Pilk/w+uQd5qraocXPGP7Ex7Q2DBVQ216gLBPgtbyxQ//4Sig9dJ1tEy+AQR2IptssAm6hlR6zPDCie76YG4++WiTELwhxXe9WIzRdxB9TnF2owQuViliX4=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(136003)(346002)(366004)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(83380400001)(41300700001)(1076003)(6512007)(107886003)(26005)(2616005)(38100700002)(6506007)(8676002)(4326008)(8936002)(5660300002)(7416002)(2906002)(6486002)(478600001)(66476007)(66556008)(6666004)(66946007)(316002)(921011)(36756003)(86362001)(103116003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?cazXGbIxvpFCSnfuWUJnUNutDhhOGdeuMdQyp6O79biCnr/0M1CD62Kqu/6B?=
 =?us-ascii?Q?cE9S6oSuKkic5mczrBAUmAIPQOZmWv5a8g6QF0h628gWAMsHA5pD2HI9Iq7v?=
 =?us-ascii?Q?um97dVfDPzM0nNZ86LA55qvXqvHi74MD4GUO/ur4IMAXNriQSVtf2QK81SXs?=
 =?us-ascii?Q?TAm4WxKUwt/kZCxm4hxoVnW76JikWCCaaIW9rQU2PFHBouo/Q/aVL+P0//rD?=
 =?us-ascii?Q?dixJUFeFyn0GztI9EMNLB7b5Ksga9TtAiTUc82jIYHVIjnXE/iqwws6IYnnY?=
 =?us-ascii?Q?GuG8nRh9m8Bg4Nn6C8EH7uMd0WSAhC++iOmVypFpJX72/3MD5IBPACNzlXPM?=
 =?us-ascii?Q?uZeAU2NCmnd167iQVgJaJYRmNKFmOto//fs7w/WP6ks0CDZGw0kfLkOugfsz?=
 =?us-ascii?Q?cvg3JEbtddmlgZ+xbJXoF3LTuKhzzqOJ1KpsgVZTHpoGdi8tJ6cTvz1KNrT9?=
 =?us-ascii?Q?TZi/B/XNLdjbRRrmqMz7dd+Xzuy8HHdld7xUd7j7fdMtqr+31o73azdSmrix?=
 =?us-ascii?Q?zgfzI1aF4/CN/TVV1wqszcRJicZsnIgDav8YvyL/B/rnXgcHQaoZWOwhcraX?=
 =?us-ascii?Q?ah2h30ZubIQlcUc9ciU8kKvziZXpG5T1ZBvIUKw7yQ7euCbCIFKelajUlmPG?=
 =?us-ascii?Q?+enV+XFeYFupvf7qIOtaxRXTsXldlQ14m78+3atnYa5w3KFa8xSydsfiYeKa?=
 =?us-ascii?Q?VnGZ1NHYBkmxotH1GhxXH6i/jDh0fxrQB2CDzhEjYnzTE0zjwQ3q/aga4Svi?=
 =?us-ascii?Q?qH/fq8ofjCZobg6+Zgo6TMXiCJTJL3b2VRHNyoGav1tKpJ1+KFBZDt2plIkV?=
 =?us-ascii?Q?+ybYEySjJZrv8eP+fsKsds/TL02eXOAYunUhzPhiGqteS36anX5+qgOqCCi5?=
 =?us-ascii?Q?+wg7ngR+et17ofombu0rY9MXAYt1vfe/cX/MDwHbAWXsGkh+ePFkTfFRkn1x?=
 =?us-ascii?Q?2oJNasNwjUbTQnYVzehsPUO5RTye4fCk763s1Ie3mFoI8N3ZmxP4QPGYpMPa?=
 =?us-ascii?Q?AbGOBo82+eXMuWV7raI4GiBt4PDvU8qhchYaFcnykN1FrCP6ZaehJ0oIpLuj?=
 =?us-ascii?Q?QYPyxF36oyjWrX35tAASgzdZT8CZYMMWvaW1dTg8xQzK7XABMC/ggV0V7NbR?=
 =?us-ascii?Q?tclEpR4Z7C/bfUM/9UdFmin1IksovAj5vXdYNz9U0lVVZaQtF4l/Y5hJDVWY?=
 =?us-ascii?Q?PggNLwExQZN0wq9+L7iEuYZzLQVLRYquyyIJxxlgJMLlUoEULsvzgcTDWdQl?=
 =?us-ascii?Q?L4L2ihs5pfRCXppPyogfcxT38x2lO4OSfNOPna0CFAAIHnndhh6W2UbLFiSy?=
 =?us-ascii?Q?usATA/LkYERO8cGnPn3Lg0rXD7eagu2hbF0tJfukDeK5BwtOBKk5rjZyW2fv?=
 =?us-ascii?Q?eDXoqon+Pdrhr/M3mN89L5P3upxI7gt4LpJbrYFy4c8m1l3HBAz9MxvzIA1a?=
 =?us-ascii?Q?3vF3zokXSiVc80K3fDpdBwNM7oCFYk9ms6c/l8Tkn1V7hf8LbxWyn2A4pCDq?=
 =?us-ascii?Q?fCkRKh1jbR5U5MvojTiI4X1mpoALGmwyEFoAbGHROUYlB/8uarzTvL3UvOb4?=
 =?us-ascii?Q?owlbAztBDJdS8C3tHLbsnMiRV+99D8J2KU8JFw9QQwYzncNVHd6a7siNQEEl?=
 =?us-ascii?Q?oQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	S0Z+EFQGi/ou/I+7+lSQKOJL3U6QItNmRlOioIhoWznuwj20lsnmUfh9PWfEwMfai0rnCeDkTszZWyUwEiFuuvUaXVPa7wEiHuK+XCCRKsWpg4/DUpG3erRjxggxP55SvrgoNXHpDE78cnkU7ShoHB3GRk9KjifXijbP6IqympQJOXulvYZKpN6zjvPkrqe8oQplh22+bPTqd3rrK49obfFjOxZgdkRuB7pxb+hsTp+3kkRdMh5eakFdNrWA/0fzCGiRqhRJgLWMrb+L3wMzjJx97UpUsMY4BNCdwF5Nx+5ny1+U1wJFgu54GIxiGlOaAkGTJTXM8iYzpmvSqvRj8Ok/48ecLtpakRsF1CSTqENspfg7CIm5Wf9A4IqSOMSX032VB1OuLZpm5MVXt3T8EUdl+angShMZf0LzJ48LDjJsVH2F7eqHi3Z59J2Tpj/r073D+00qZx1t8NkeLWeNTOg/g6nhVMAW8Aq0QXiwGO1x+AJYgFix3DnyEDgi6bXzEUXLQpHPhZQ5R5NRdMVd/euZxu8YtBSAp34cCMtloRnpFQneBMx+vh1aH7CBv7e2Oa9pbGmYVD/CYr1e8uy7FraXgp4bfU1B92+JZUNpfbw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eee08816-ee24-47ce-5438-08dc1cd11a68
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 11:39:19.7836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eXDEq8+A8swuEflb3zOMTI8OdJ3skLsNncSRB75NslFnfKHaVLJ9gwFnkBcaP3rmZeMspgClT8yEdkQqeemrkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5815
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-24_06,2024-01-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401240083
X-Proofpoint-ORIG-GUID: e_9dzEjHk8EU2avSMx8l_zE45bN1TrZM
X-Proofpoint-GUID: e_9dzEjHk8EU2avSMx8l_zE45bN1TrZM

Add support for atomic writes, as follows:
- Ensure that the IO follows all the atomic writes rules, like must be
  naturally aligned
- Set REQ_ATOMIC

We just ignore IOCB_ATOMIC for reads always.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 block/fops.c | 44 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/block/fops.c b/block/fops.c
index 0cf8cf72cdfa..9c8234373da9 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -41,6 +41,26 @@ static bool blkdev_dio_unaligned(struct block_device *bdev, loff_t pos,
 		!bdev_iter_is_aligned(bdev, iter);
 }
 
+static bool blkdev_atomic_write_valid(struct block_device *bdev, loff_t pos,
+				      struct iov_iter *iter)
+{
+	struct request_queue *q = bdev_get_queue(bdev);
+	unsigned int min_bytes = queue_atomic_write_unit_min_bytes(q);
+	unsigned int max_bytes = queue_atomic_write_unit_max_bytes(q);
+
+	if (!iter_is_ubuf(iter))
+		return false;
+	if (iov_iter_count(iter) & (min_bytes - 1))
+		return false;
+	if (!is_power_of_2(iov_iter_count(iter)))
+		return false;
+	if (pos & (iov_iter_count(iter) - 1))
+		return false;
+	if (iov_iter_count(iter) > max_bytes)
+		return false;
+	return true;
+}
+
 #define DIO_INLINE_BIO_VECS 4
 
 static ssize_t __blkdev_direct_IO_simple(struct kiocb *iocb,
@@ -48,6 +68,8 @@ static ssize_t __blkdev_direct_IO_simple(struct kiocb *iocb,
 {
 	struct block_device *bdev = I_BDEV(iocb->ki_filp->f_mapping->host);
 	struct bio_vec inline_vecs[DIO_INLINE_BIO_VECS], *vecs;
+	bool is_read = iov_iter_rw(iter) == READ;
+	bool atomic_write = (iocb->ki_flags & IOCB_ATOMIC) && !is_read;
 	loff_t pos = iocb->ki_pos;
 	bool should_dirty = false;
 	struct bio bio;
@@ -56,6 +78,9 @@ static ssize_t __blkdev_direct_IO_simple(struct kiocb *iocb,
 	if (blkdev_dio_unaligned(bdev, pos, iter))
 		return -EINVAL;
 
+	if (atomic_write && !blkdev_atomic_write_valid(bdev, pos, iter))
+		return -EINVAL;
+
 	if (nr_pages <= DIO_INLINE_BIO_VECS)
 		vecs = inline_vecs;
 	else {
@@ -65,7 +90,7 @@ static ssize_t __blkdev_direct_IO_simple(struct kiocb *iocb,
 			return -ENOMEM;
 	}
 
-	if (iov_iter_rw(iter) == READ) {
+	if (is_read) {
 		bio_init(&bio, bdev, vecs, nr_pages, REQ_OP_READ);
 		if (user_backed_iter(iter))
 			should_dirty = true;
@@ -74,6 +99,8 @@ static ssize_t __blkdev_direct_IO_simple(struct kiocb *iocb,
 	}
 	bio.bi_iter.bi_sector = pos >> SECTOR_SHIFT;
 	bio.bi_ioprio = iocb->ki_ioprio;
+	if (atomic_write)
+		bio.bi_opf |= REQ_ATOMIC;
 
 	ret = bio_iov_iter_get_pages(&bio, iter);
 	if (unlikely(ret))
@@ -171,6 +198,9 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 	loff_t pos = iocb->ki_pos;
 	int ret = 0;
 
+	if ((iocb->ki_flags & IOCB_ATOMIC) && !is_read)
+		return -EINVAL;
+
 	if (blkdev_dio_unaligned(bdev, pos, iter))
 		return -EINVAL;
 
@@ -305,6 +335,7 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb *iocb,
 	struct block_device *bdev = I_BDEV(iocb->ki_filp->f_mapping->host);
 	bool is_read = iov_iter_rw(iter) == READ;
 	blk_opf_t opf = is_read ? REQ_OP_READ : dio_bio_write_op(iocb);
+	bool atomic_write = (iocb->ki_flags & IOCB_ATOMIC) && !is_read;
 	struct blkdev_dio *dio;
 	struct bio *bio;
 	loff_t pos = iocb->ki_pos;
@@ -313,6 +344,9 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb *iocb,
 	if (blkdev_dio_unaligned(bdev, pos, iter))
 		return -EINVAL;
 
+	if (atomic_write && !blkdev_atomic_write_valid(bdev, pos, iter))
+		return -EINVAL;
+
 	if (iocb->ki_flags & IOCB_ALLOC_CACHE)
 		opf |= REQ_ALLOC_CACHE;
 	bio = bio_alloc_bioset(bdev, nr_pages, opf, GFP_KERNEL,
@@ -350,6 +384,9 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb *iocb,
 		task_io_account_write(bio->bi_iter.bi_size);
 	}
 
+	if (atomic_write)
+		bio->bi_opf |= REQ_ATOMIC;
+
 	if (iocb->ki_flags & IOCB_NOWAIT)
 		bio->bi_opf |= REQ_NOWAIT;
 
@@ -620,6 +657,11 @@ static int blkdev_open(struct inode *inode, struct file *filp)
 	if (bdev_nowait(handle->bdev))
 		filp->f_mode |= FMODE_NOWAIT;
 
+	if (queue_atomic_write_unit_min_bytes(bdev_get_queue(handle->bdev)) &&
+	    (filp->f_flags & O_DIRECT)) {
+		filp->f_mode |= FMODE_CAN_ATOMIC_WRITE;
+	}
+
 	filp->f_mapping = handle->bdev->bd_inode->i_mapping;
 	filp->f_wb_err = filemap_sample_wb_err(filp->f_mapping);
 	filp->private_data = handle;
-- 
2.31.1


