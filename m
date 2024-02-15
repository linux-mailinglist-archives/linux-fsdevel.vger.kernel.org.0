Return-Path: <linux-fsdevel+bounces-11768-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B2E7856FB8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 23:01:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF737281D17
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 22:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C6A145334;
	Thu, 15 Feb 2024 22:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kGt/QKgT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NPW1aLB2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9451420B8;
	Thu, 15 Feb 2024 22:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708034438; cv=fail; b=Irb4wm8MM7dEfMIiEbIfQGr4KqcqLuBEJqySk7kXGWYXssCcHbSkVDhhb2W83uhcCZhXvaa5GKXz7DwqLgheM16pN9YDGwurQEtda8+7qGpsfeueHpbFC+oDnz/zQ/Jr24nlYt913OCvB8w4iSNjOVWylxAwmNqkCrAXyeAKl3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708034438; c=relaxed/simple;
	bh=IIc9Hm6XcKO7BDVhZqgSiExVsbRDnX4FykhVD/isMEo=;
	h=To:Cc:Subject:From:Message-ID:References:Date:In-Reply-To:
	 Content-Type:MIME-Version; b=U83K+zneQVGQu0pMSKG80PbVtbb1JEYWqQYcy8s7fEzopKzk+igl0rW12OyzzpNAzZMGNWCufun0KLiZV4ELeGwNT2YeeD+NJhU8ktbsizl0zOERdw+dhcRFaUMWoBLxJu64xUL+EWdlQ238VRBWZnJkkwfG1tQOusMVS8YEQBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kGt/QKgT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NPW1aLB2; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41FLSxe1001931;
	Thu, 15 Feb 2024 22:00:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-11-20;
 bh=TV9i+qr/oCOz/BgiJBTZAkfdcwnrILSlvF17rF0ygz4=;
 b=kGt/QKgTfpTMSfRwNEFi0Au4ahSqiLHUMWA2wsuiLrx88HiwokCaG5f94aE6fcC7DK2g
 g+0p9FZFX7A46O6UX6aUx6JJqSiKTjH+w9nXDkld6G7rO4qIQrM+oZFGLkiDDigYfrmp
 CsySzKVKPuV24d/SKexhV4S1mGoyx/+B9z+fqzwqSxeltB0VOsprbLvliTyxMJGNPx1Y
 ZX5bPzg9GrR0pQNINk5HIraHiHOccbT1gaBs1Fr7VcsWyVkJYFoZk65rtFJDm8xBY6xL
 brnjCmWRffJrmomAtthPPPw5DMhGgBo4ac6/z284oWKq3JlOfcW7qNXEM0aQnruxZgrZ iQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w91f03pn4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 22:00:17 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41FLxKZF013824;
	Thu, 15 Feb 2024 22:00:16 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w6ape3dtg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 22:00:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S4WQTutDpyCMB3K1o/PfhoEKztXbYwYESDecalhzUBlE6XdCBMSLyv39zxSp+DO6kPhJx4Ivol10qAVTX23sFuNPbU0IamisLGzG5W0x0nl6fZZiVqBNBmFBPXcgpMBlmw6dlMhXnu/hO3YiOim3eaMbwBsH++rmXVXyav4Sfg1scixjUDDQLuChBR2V9uZqCzGA9uta+OV0GtFLc00rzo78HxTHJhXWk1dPx6gX/lwvch5VWniIEzESdjHM9M2KHWqifhkGxczjF4HweG1Ygj4xg6URwEDdV4JKRJKk7FPT3NTwJtoqg/Ta3PzPi+6G0BzQsJ7+MyOd6jY5ME6XNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TV9i+qr/oCOz/BgiJBTZAkfdcwnrILSlvF17rF0ygz4=;
 b=cAqBDQsiQ2KTmgmYdK/CADegWkD3e1k25mS4ImuUQxaLacba4UDD1HuNKs7VQYTUtDzB6J83SVDSwqrtFs0qjhPAbo4U+dO4Qu3/Tme95fxISY5qF5T0GTnvzMOQNrdeWuOkA6iR3Osh6UYMU0XkBV5SWcXcAr37iiwuDIf/jMCerq0OtbPfw0229/1BuOUX7jbxizKvwVrHgA0HkCZI63iJ0UTdlZypP1zRwIM5a6sxUN+ztWIY7G8jGV3R9uyWOi64JE6UZbiqXrgBJSrkvWJK4v0848VpHduzx6wgWAfFh51ye0UmVFBG9QmnFvAXXqz515Q6XSyw7X5SMZQHYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TV9i+qr/oCOz/BgiJBTZAkfdcwnrILSlvF17rF0ygz4=;
 b=NPW1aLB2Zeb8FhTZmet3H9dT1LuiMVlvVencx4w1ATwl1hRgng0u8cieSnpaWU1C8EODEhjDiOSj+8EosrNI0SYInNY8JMeV+H968gie+B+Ir8X7NB5fQBnSmuDh6926MBEuSMy4xAk8d/u8jl5ou7jS/en7TkYOdXNLmpG10Xo=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH0PR10MB4616.namprd10.prod.outlook.com (2603:10b6:510:34::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26; Thu, 15 Feb
 2024 22:00:14 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::1b19:1cdf:6ae8:1d79]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::1b19:1cdf:6ae8:1d79%4]) with mapi id 15.20.7292.027; Thu, 15 Feb 2024
 22:00:14 +0000
To: Bart Van Assche <bvanassche@acm.org>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph
 Hellwig <hch@lst.de>,
        Daejun Park <daejun7.park@samsung.com>,
        Kanchan
 Joshi <joshi.k@samsung.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        "James
 E.J. Bottomley" <jejb@linux.ibm.com>
Subject: Re: [PATCH v9 11/19] scsi: sd: Translate data lifetime information
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq15xype6k9.fsf@ca-mkp.ca.oracle.com>
References: <20240130214911.1863909-1-bvanassche@acm.org>
	<20240130214911.1863909-12-bvanassche@acm.org>
	<yq1h6i9e7v7.fsf@ca-mkp.ca.oracle.com>
	<7e3662b4-30c0-496b-be19-378c5fab5f33@acm.org>
Date: Thu, 15 Feb 2024 17:00:10 -0500
In-Reply-To: <7e3662b4-30c0-496b-be19-378c5fab5f33@acm.org> (Bart Van Assche's
	message of "Thu, 15 Feb 2024 13:51:21 -0800")
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0263.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:194::16) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|PH0PR10MB4616:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a3ab9ed-4c44-487f-305b-08dc2e717d0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	1Bqj15BDgjQZSfgTy1Drjr4YsNaZKyRmrBW9WBXIeQUd21EUM4Kh1Ko8znSX8vp+z7RaIyHsTg1aswQ5dMp3Kj6GhxXBIOvfNVy+4WL0mdi5rNaMXOiLCGch1ZLiu2PE0c8HlJWXek6fSneRVJuZI8qyFZ4/g+Owtt+GdgOkfq+eObGDqAuyM6PDvR7hXZaeiqFgLhxWA44jIoxXdz1vhq6e1DaV3kLzP0qUh2amKTRx50fXwaD/h7r4m6epMUkL2J1ON0T3ouYmRN0YLKoUsz5kFjT1+kwlVLQU3SupZCnB9p52vfsIeq+VAc0LFbYKALAf2lVFoEwq0IBZqcn0Mzi2o8pN6LPadw2C30+sIIdXwsWYNNfXPeyGyBHjPjbMDuI0F0QEQ8+PdONXgo/XjyA6HtUQiSBVBASs+ee2NAstBnM8FfMaynlirwVhlRxWUjwehzM2RFaEQfxmM5gPTqODn+5MC0PHVObBckbYnEyYq8gJ7BHL+i3kRIGnU5AEz8ilI9sn794Z/riGDb2MZTBZESRSrUY23fDN9DL4p4r/BuTK7/483baeNLACSutZ
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(396003)(376002)(346002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(26005)(38100700002)(83380400001)(4326008)(6916009)(7416002)(4744005)(5660300002)(66946007)(66476007)(66556008)(8936002)(8676002)(2906002)(6506007)(36916002)(6512007)(6486002)(478600001)(6666004)(41300700001)(316002)(54906003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Uyihj2EPnh/gesPlNgBNLN10PVWnV/em+fAxgPmmxhPHTukno3ASEhuGdfVc?=
 =?us-ascii?Q?z5SPeZ7ohxiSCb8Cft37+jtLWy4jR4DQp4LzF8j8oaAaMBXpqGDAL6KHNToP?=
 =?us-ascii?Q?EhdOIP3nHGVpg5vi34oewAR1EPNUNzFRNBN6T/LhgNghzOTzV9967+W7XDCX?=
 =?us-ascii?Q?unnpZqUqosfk6GjhimvXmnhIunZzYkDjrECKiSVaWdOhhbYnv0foDYiIEUmV?=
 =?us-ascii?Q?zGM8Bm7hfd/rxTAqtbHrBuQTxSrmyx3zusllZzzU9rPE7OEm4VquxpzW1nBB?=
 =?us-ascii?Q?7IDbLHim96pplIxzj1EfJA0AWoBb13v/T4aJ2koP3VsW/d6Ywcnamq4VzteL?=
 =?us-ascii?Q?Tl8VCOV03g/X81SPQ88yjjXHRlQ5g8MJpgvKQ0oS0Fly5T8c7TY7wqRP9hMe?=
 =?us-ascii?Q?AymSl+q5hDQbeDJfsce9+zViQZ3YEqJhl512i5J15Pg8hIBK4IjXJDsE2Ty0?=
 =?us-ascii?Q?Krah8MofLgkyALf5boM7/F6+FwL4RIExl+jWXxvwIN57RD83pC6KT3NfFoUB?=
 =?us-ascii?Q?FnqhgxocyQl0PCOK+V3yrwpMnUtXG37+YHHd0DjSvpIRbpjBE6DuQMiS7OOw?=
 =?us-ascii?Q?yMV1vlfPMSTCVgt0h0W6VxnDilTpN6RLQYA3Ai+Y7e9DvWNznWAMl1EVQRqd?=
 =?us-ascii?Q?WNDN1dAOoEWHWIJHe5uuwJLu2BhtJOROLR7Sv0n3LUpYV19lSQTKyTEX3VGz?=
 =?us-ascii?Q?hEuDNYTMvThOewkynTpyh7AkwJ74aqhSSaCCoEpT39SXydGZNm5fRMlkmeum?=
 =?us-ascii?Q?mCs8i6xHHHwCAs1O/lwweXjCEexPQEJJoSySbDuygpTBaCSHc1lPCM54rvPh?=
 =?us-ascii?Q?BlJay58Xg1J0mOHpBFsnLa+Qn2R79DYnnnqoAKQ483jJTAC2fiV4djsDqJj5?=
 =?us-ascii?Q?sMh2nFqKM+4ui+1Rt+hV7VZMZoH1CfqVCK1jJQuQyjieoKwH5fMdYncb/gdk?=
 =?us-ascii?Q?6UrO6KyOQkuLHfQhWASynDH85eHtOe0U5bmRwDcUjDExFQbtvTw2obYFgEYR?=
 =?us-ascii?Q?jHVFdkA1uuBMvQED6itK215cDmJ1QFsj/zmo0/IgnUQL1KHE+WLxffBO910e?=
 =?us-ascii?Q?EnFQy3PveIKt8ky2+FW4Y85g/OHAlSqzhOPCME7nTmG3E7VHaw4JnZYHtQuN?=
 =?us-ascii?Q?KPmn0uEJZok+GOo8pngJPh+dpQXjkZJ1wH5yFAZKr8EoeINNpM8yVxWHWO0t?=
 =?us-ascii?Q?PMW/KqGuRj4SBj+8/s/0ohtxVK8HPgNdYGrv8LxC/9xdBQ0HIXHal7JZnSdN?=
 =?us-ascii?Q?DHAeu4kRNnORm+m8HpsO56OAZXiloHrhA8RnRDCPkleqL6G5BehtLsP4vioA?=
 =?us-ascii?Q?H08YscA5ExY5svXik+jKkWjOrFnc9dZH/KxW16vHjvJ5VC0IwAQME05bYVCw?=
 =?us-ascii?Q?uXknmw9mGoWkaVkJltW2aKkowSGBRaS/RUmCyU6YEu4yYmtxi1HzpN108cDF?=
 =?us-ascii?Q?HVTT5o7bq1bL6sOu6xgd+gvZgDiJwKLTn3JBSAwtifS34w88ib2hlG9XJKRC?=
 =?us-ascii?Q?0c3LENazfmeU0F6qmqTjSKkEq5Ztg2klb8Rpws/jO/CFsgi9eyJRqEFvMF8t?=
 =?us-ascii?Q?VfuPZdsEto1SKR2crgu8gnzbXZDuBG30XBkDn1/IEoDxQRHBrRzmhZqLUHHI?=
 =?us-ascii?Q?Ag=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	BYQDEa2+PJqdIqt/PgxdjsU/c3ZfPhCdeFxs0eYyxeAEuWWVLdOZFZgu3q0MjRoEaq7ExhMyaSddNE0S/HL2kMy9ZFpmOwejZ8EGEV/YCP83ZMgijfYA1pcvwABaIarV+GN2G6jPM9ELf0TD3oWyn2qAi63lJrcXUTO9VnJLKqRVcBRoDCEgRHECCcHYAOYwqv/f26EPx4X8scWt4CJUmlO4i/MYruMjBJIrGuOyU8BMWYtFxmBlrW+0OVuIHIMoaYmdIVO/AjTCj/kVGVjP3guG81j/IOUG5dn3OrvA3OysXGsPU+F0jrqvE3A3IlbdDFnNa60f1Tu0rAzuvbbPvDgCIA+E08izipeBwa/hHDQqPkg+3Zqkb6vzu2uMsiVVd3/0lAADvt8cBIwjPpDLsXyKQp+a7wzFSsCD8Bgu3WAgzx7ZGU0jyjgbTZ2Gh2hdlg+PUFDAuRKH4WmdB/LHeNJDczUiIWsbFBqggoQRMfehTG7Eg2pS1MLIP5zQjK/klUaJxpkBKUkIGXF/QQqCaSaQRsmGGf+hEgTPqKdcVE0YeES5w+zXh29T/NjIJ0W8Xft4dqkCQm+gynlaDmHQ6L+hkqzMsOadCU1VdMyGMi0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a3ab9ed-4c44-487f-305b-08dc2e717d0a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 22:00:14.4641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ikgOzINAHqqHVVjZLugmLwuRWFWbo2Yk8r8oFmv5prXkT1Fe/SBeBUput6QeYJ2QNwFZZIwKcU830x5v4X6qwWDL04WrRoAT1TVr+SyO9eI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4616
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_21,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 mlxscore=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402150171
X-Proofpoint-ORIG-GUID: hGKXdUTKW3qmS6fYVw0iMUjAnx7rUYGw
X-Proofpoint-GUID: hGKXdUTKW3qmS6fYVw0iMUjAnx7rUYGw


Bart,

>> Wouldn't it be appropriate to check sdkp->permanent_stream_count
>> here?
>> rq->write_hint being set doesn't help if the device uses 6-byte
>> commands.
>
> Something like this untested change?
>
> @@ -1256,7 +1283,8 @@ static blk_status_t sd_setup_read_write_cmnd(struct scsi_cmnd *cmd)
>  		ret = sd_setup_rw16_cmnd(cmd, write, lba, nr_blocks,
>  					 protect | fua, dld);
>  	} else if ((nr_blocks > 0xff) || (lba > 0x1fffff) ||
> -		   sdp->use_10_for_rw || protect) {
> +		   sdp->use_10_for_rw || protect ||
> +		   (rq->write_hint && sdkp->permanent_stream_count)) {
>  		ret = sd_setup_rw10_cmnd(cmd, write, lba, nr_blocks,
>  					 protect | fua);
>  	} else {

Do we even care about rq->write_hint being set? sd_group_number() will
check that later.

In my book, the device supporting permanent streams is a good heuristic
not to bother with 6-byte commands.

Another option would be to simply set use_16_for_rw when streams are
supported like Damien does for ZBC.

-- 
Martin K. Petersen	Oracle Linux Engineering

