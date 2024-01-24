Return-Path: <linux-fsdevel+bounces-8703-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F1B83A81D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 12:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70EFA1C2533A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 11:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30EB432C8E;
	Wed, 24 Jan 2024 11:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bSaiF746";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QoOD9vtu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1512BAF3;
	Wed, 24 Jan 2024 11:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706096378; cv=fail; b=PVR84Bxfw883rR8qfLkAPo2LwG0Q1BX08QfCgMRQP+OsNk7dMCF0cRjmckO5o9xz8uwtc/6cgD/txwNjmY8/QqS4jx1c4d3OG0q9TKpjOTH1d87WiAZAHGbgk5ZzACk1q6Ka7YLsexzF0uWdubaGleDVsGqstENZMMDWVBO++k8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706096378; c=relaxed/simple;
	bh=0ZZ6adVNyZS4ppIAJ2f3Xq2GD4ta+Q+ckwS3kHJykFQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NwcctGZ9pNRD+xG3gMguUDNNln5PS0xdH5b6y7OIOvKQ7k+fNJYtV+ankJrM3Z3kxWI28PVl9mDKgDs468qTdm/bsGFbsrfPXkf2ppYLoNwV1OGqdzpBfzar8yakYGDApQGqsTpjrjURSXUDUMqnKzQh4NP14r1GIS9bQaKE1/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bSaiF746; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QoOD9vtu; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40OAwtp4009439;
	Wed, 24 Jan 2024 11:39:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=UleFiMjebQfomIRfcZwKlfaUK4esV8jzRO6dV8lg0Iw=;
 b=bSaiF746R31HsqSclpbhu+fWKajkYBgwtyDqYcq2WGPe1pIcafn/G78Wxv7CO74n0lFw
 6w4vI+vDlD3+iSgancl8pZuP+8vX8xekGYu2ADdyB+wW3s1F1RYqtsZ6F8l0Zpv34QXS
 OXthLx1G0BSOtREEI5scpRP+iq8XRTGFM166YZwSBnw6OJscJDUghR1ZI5hzRp9OLVvI
 TQF7KwPL5ci09n8fqo05nX3zniJmuvAqbGb6+yiuKWAo/mSSjfo8Cq5XSgQVY69yk7uQ
 6ABDbYWRjGj5SIXH5PqxFlBoXCth8LJ4MDe0esrmRD9lxSylte6fIVJJXjIBWMzcaqNP fg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr7cy1tue-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 11:39:13 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40OBOr76040836;
	Wed, 24 Jan 2024 11:39:12 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vs316wnqu-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 11:39:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZCHao/KytGaypy2vijr8svLXJ4ieujF33R1SscVuqXu1lAZo7ARW585VAAEot30jl0wZ5KwK7H9v80bEkj0drbUrVuNfjvVc/iKuUqp+VpKUBl11DMeK5zzXulmZ2pR0oItvYLvYxTKz/2n2eCvGoTMEkkXlx53DJSDyq874x5kEjvXr7IKsgOn8sInGlwv5KaRbKb+qf7RaGbB/yQxkPAJoRyeOfCmstPXLngHH+tX4Hz04Tun/h+QYh1Eqw+6CmDRLCLeYFDqILwT4yigWgA0NpoFoCre0hiJ0/5IbfAvIA8g8wiGhKAuoKk6bmoT8JukoW/RaP2nNRDJPbmsRJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UleFiMjebQfomIRfcZwKlfaUK4esV8jzRO6dV8lg0Iw=;
 b=gISYTQmaASmSSujtw1Naay9hZPDv7QZj3fF3Z7JfV6qk1GpG1uJ/e0J2cI3tuXRoEAHjgclgmXv0ux52R9FYY/KoWQCOfVnJlLW/Yh5LhMDIriU/3ZjP/USJBBek9TNY+RTY1FdKgGVZ9jhShDjDZepZ10sYQkZCfIb1do/C9HVcUbw3R7LGJcYQXuPshT9NnRKoSiPzA40SBRtGaFE+0R/0/UDXq1s7qxN2ZVNjInXy7U4Tu47jsrIKNFoAo23KYf5F/zBLufG/b4PYDlHOjReoeH8T04QagcR1zev9x2QVgCQrsIz2Z72WhsdIQcrQVPOb8613UdZejDf/5emqog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UleFiMjebQfomIRfcZwKlfaUK4esV8jzRO6dV8lg0Iw=;
 b=QoOD9vtuSuWdL6s+A8fAEhZvwzEl4f0kEnSFB0KC75xNiJk8iJxzD5p4fuGefIeiYoLP9dm/ZYxXJkiF2O1dpGXM9budjBVRtRDs+PcGZ3pZqVp0MQszfbSBChPip90vikySquwADr+TZ1ePoT135X+Pf0jR0dsuSeYisA98NFM=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA3PR10MB7041.namprd10.prod.outlook.com (2603:10b6:806:320::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 11:39:09 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::f11:7303:66e7:286c]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::f11:7303:66e7:286c%5]) with mapi id 15.20.7228.022; Wed, 24 Jan 2024
 11:39:09 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
        jack@suse.cz
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-scsi@vger.kernel.org, ming.lei@redhat.com, ojaswin@linux.ibm.com,
        bvanassche@acm.org, Himanshu Madhani <himanshu.madhani@oracle.com>,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3 01/15] block: Add atomic write operations to request_queue limits
Date: Wed, 24 Jan 2024 11:38:27 +0000
Message-Id: <20240124113841.31824-2-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240124113841.31824-1-john.g.garry@oracle.com>
References: <20240124113841.31824-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1P221CA0001.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::12) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA3PR10MB7041:EE_
X-MS-Office365-Filtering-Correlation-Id: 48abc66e-d99f-4f52-0e2f-08dc1cd1142f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	xD+TvSFBLPDdtQGup/SD3f+/lRXD4/PNmbJd9Z3qN6fj9BtwoQ3Bk4fmkuZ9sDYEoYUbRrK6hoykRfdHdfA3zRUrSl/D519HtWtHQLXbueo98IJPtfTcvds0PAyQUrzMaNfBqehTOaCkixZRrv1DKw9WjlPov1ZYN24n8FgLpxbN+y6oozvEmkL3ZibXVSPE6KrgwYWj0/ld+tRpgYUSK4iE+wo2Ywk1+g5CufzoA50ScFfyTdZIIogrNBE93oJhR8ijmCghfo3qVThC4kzO7iy3l2ECiwC6ZeAsp5cqtQ+gpGs4vrtozyeONxHOb+3Mjhh9br/VjmlCHoW0waASK2UIFZ1qiY2mHnp0Q60pMMKiJae+zxqTFMt3lF+OXt7V+CyxqfrRq7Igd8B24ZYt1cSsoQNlC6mJbxHpMaebQ1kADl4qtW8Omm+AR1F1aBGukVedSm7l2wtgTmuED2PfQHHFFl2NnUnQC9KEtMU99F4fJmrs9nyUzNyBI4FZcSrNdnjz3Cg/+3ZKjhOYnad/vrEtsZWmdta+1Vsnfvl1fDL2C/w9wILD6gcXBGHgZN02Iu34etjp+Q3s9NagiOYydfs+cukxh2l1aX7icnpUe1c=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(39860400002)(366004)(396003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(4326008)(8676002)(8936002)(66946007)(66556008)(316002)(54906003)(66476007)(921011)(30864003)(2906002)(103116003)(36756003)(5660300002)(41300700001)(86362001)(7416002)(38100700002)(6506007)(6512007)(6666004)(83380400001)(966005)(26005)(478600001)(6486002)(2616005)(107886003)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Vi5/9DoU72cO1vxN5onlt6SGftCOof3uLAxO6t0dcvWPyt0SFLpwlaQNnorK?=
 =?us-ascii?Q?YBFFVsqAdTObjFbEeDxy2nkJHZvjIGT+FK2u4uirbDm9KPAE2l+2QnIkSF2x?=
 =?us-ascii?Q?XW6frmhN74I6ILP5zhnw88dfPgdbh5CwVA2VqDU4WCoR69x8KH1Sc/UtihQl?=
 =?us-ascii?Q?bMSF8iKZ/mnxTiLUqZKzZYMK8DCeA8TedSlKyE6v69gIcePC04rK8XvSoARj?=
 =?us-ascii?Q?/G1P40dxUFviPQgrNa4ZTqkTR3gpD6PmB5m3Swa3cd18EI/DZDmgR7/weojN?=
 =?us-ascii?Q?dEPiSGKfjLf/r3HTicni0slFA3J43MyJ3wycDHCLMLSYszg14s9SzkXsw9Jo?=
 =?us-ascii?Q?8ViGEFE0G5dsQz5q9alzugCcLFz0PKMYxjAEPU0boFa1rY2WPkoUawBc1o3x?=
 =?us-ascii?Q?8LnXu/Cnq9BiPuedpu091w+sVlQwFaU80uKToLTefsbyc2HYeL2pm+os5Omz?=
 =?us-ascii?Q?ksVGhRYMSJVYgmguESY64geMuqqhj1ACaIzT2DapkICa3fDN4v3IEnrpATPW?=
 =?us-ascii?Q?CcDwP8Yafhk8eqH5WQnnXzLEwa4AbxI02cgtsuYB2RlpiKujConUDQg1WEBA?=
 =?us-ascii?Q?cnoBZXbwWs6OetMuyECj7Wywzw56BD98LmuE8R0BqCAH4Yndnri+kb4e01eh?=
 =?us-ascii?Q?eLrZqhs/bKqQRWXR6Cl7NStZThX4HEOhYzzBM2CvgzXkBNfWNzbIKakAq0Ze?=
 =?us-ascii?Q?5BtG8TjUOBoh1AmmW18ymm1lES2Y8rhXPHivixa6Y+GRHCPgCFJKPnk0+8AD?=
 =?us-ascii?Q?TdDoUADEpChS2lP82qfq2N/c/J9o6I34gD0O1s2dxCpU9nqPARjq/0etmTr2?=
 =?us-ascii?Q?CjGQ87HGoufZr4cI/lHIzQlDRTWUg/2d1JqahqSQSJ9KgnQmciGDdoEwjKKD?=
 =?us-ascii?Q?TOTCv7ee/fbb5KwKzIiFIpOo4na9AKHemDazkFu6Tsa05y6nrFib/xKyTVzq?=
 =?us-ascii?Q?77IV4GeZ3ktSgsDUUuIesL4M/05g131aXcDP6vlBN7k3/dwrk1h8mo9dDqi9?=
 =?us-ascii?Q?9DibePY4qW+zatoUlH27VYsOjj2MMF6WzwQ49rn67YfUGo6EVi1GHxmZQatD?=
 =?us-ascii?Q?08Ox7FYCvuDLlz+qiNMqoOpZ5EGsAx9EZPUwsuJBDYcMD8tvh+4PAlhM+ADv?=
 =?us-ascii?Q?3wisbM+GsfZIPW5CK8/xyWEzYemcMjyuXMUUQElDcWY+siMFDqM9kZoWpvsr?=
 =?us-ascii?Q?D/wU05APCDyJTbuFnHNzz/L1nvOftCMthcOtoNMIWQB3ArjumaQyPpqpury1?=
 =?us-ascii?Q?ziWN6jeM5wY91iFttkV9+U7xywrSzRmVedwvzBjZ8EhobyF8X50Tm+b75gDp?=
 =?us-ascii?Q?mJCHhtVM9OWgLadk9zAXy+lZoD956tiCbvitdDczjr52vKrZNvApTEdnBwZh?=
 =?us-ascii?Q?LWM4XywN/KEa5xAhv2B/hMo+xSYVmg30x9jo6ppdA/xKCjO0M1ubF4AJZfxu?=
 =?us-ascii?Q?oGLfHNEI0UbLEO1oVf/t/v3CKu/F4Ln3UpUrNSYCKPW5EeF1lJxCwBT9ElqX?=
 =?us-ascii?Q?jFsAHH+GACGVt3tV96Zn2ElB2Z9MxX8k+mfMpT/iuVtuWDV2JGmL+Fl9XGyP?=
 =?us-ascii?Q?+5WMLL6AGZfg/N7j9cp7KHIrXuHe7A6onK+0VLpIrfDC0c7StfgU1h0ylpuW?=
 =?us-ascii?Q?Hw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	3p4wLupB2gE+6sF16GcEhZxI03M2/WOn2eGf5czNkX0O3g2yznd6z68JaESKP55QbIQSwJeTb+JD19qjfL+5cM7W4mF4OPmXLLXT5Ces+jnB5WffEA3DOE6LTPU0LwTcw1ioRcq55ZHsjquhyOrIQlwVBPij86liGsBnJCkyrr48CS5wC3ew4/LjCxDOBUEP1NEs36XPcHiImljz2Vtws/hR+8EZahGV41NLvt7HMYVsQ8pB6dv+qVUIRLEZa7MssaG3/aehBdJK0Mw/rUIKE8Uonyv1hjYPh+qV87wHmOXKgHNJT0IstqgDDHftYxe2ZzfqrmTpHf/o97GV/gFmyQRG1mIn0RS4dckAaC3jRIlUX7et+QNaIqiHOqqqmb8mmX/XjPbWTigIJL1J6CaQ526GO6TR/7idgdYYWfJ5xtZtymLwZ5H6WnJiNA1zciqZJgJqyUUbkryImgp5jxFN229WdYMV0beq8SiOptJmpYt2pXSyRpHY5NT2z+OWROsxhI7f4jNMsGWpK1TFoBVrVcEiYSZGhfIHlyrMJF92ZpXv9LUBO7SEOEDcj+XeL7iDga8SXHRrJfahuOLMhx8pSuC2EqwQJrHGOVA6RHFCqVA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48abc66e-d99f-4f52-0e2f-08dc1cd1142f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 11:39:09.3229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sMUtCWLC/DqvF6+3Xhh/66FYL9A4emukv23pNBndygc0haSQrqdoIbqSxmuilHXf92TpnXhUyN7kUBoIZvJBWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB7041
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-24_06,2024-01-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401240083
X-Proofpoint-ORIG-GUID: y9_Mh8uzZZ80VPW2YXPt0LXovJwFl4Z_
X-Proofpoint-GUID: y9_Mh8uzZZ80VPW2YXPt0LXovJwFl4Z_

From: Himanshu Madhani <himanshu.madhani@oracle.com>

Add the following limits:
- atomic_write_boundary_bytes
- atomic_write_max_bytes
- atomic_write_unit_max_bytes
- atomic_write_unit_min_bytes

All atomic writes limits are initialised to 0 to indicate no atomic write
support. Stacked devices are just not supported either for now.

Signed-off-by: Himanshu Madhani <himanshu.madhani@oracle.com>
#jpg: Heavy rewrite
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
This will conflict with
https://lore.kernel.org/linux-nvme/20240122173645.1686078-1-hch@lst.de/T/#mf77609a2064fe9387706ce564d8246c5243eeb99,
but I will rebase when that is merged and I assume
blk_atomic_writes_update_limits() will be merged into a larger "update"
function.

 Documentation/ABI/stable/sysfs-block | 52 ++++++++++++++++++
 block/blk-settings.c                 | 79 ++++++++++++++++++++++++++++
 block/blk-sysfs.c                    | 33 ++++++++++++
 include/linux/blkdev.h               | 40 ++++++++++++++
 4 files changed, 204 insertions(+)

diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/stable/sysfs-block
index 1fe9a553c37b..ac3c6b46f1a3 100644
--- a/Documentation/ABI/stable/sysfs-block
+++ b/Documentation/ABI/stable/sysfs-block
@@ -21,6 +21,58 @@ Description:
 		device is offset from the internal allocation unit's
 		natural alignment.
 
+What:		/sys/block/<disk>/atomic_write_max_bytes
+Date:		January 2024
+Contact:	Himanshu Madhani <himanshu.madhani@oracle.com>
+Description:
+		[RO] This parameter specifies the maximum atomic write
+		size reported by the device. This parameter is relevant
+		for merging of writes, where a merged atomic write
+		operation must not exceed this number of bytes.
+		This parameter may be greater to the value in
+		atomic_write_unit_max_bytes as
+		atomic_write_unit_max_bytes will be rounded down to a
+		power-of-two and atomic_write_unit_max_bytes may also be
+		limited by some other queue limits, such as max_segments.
+		This parameter - along with atomic_write_unit_min_bytes
+		and atomic_write_unit_max_bytes - will not be larger than
+		max_hw_sectors_kb, but may be larger than max_sectors_kb.
+
+
+What:		/sys/block/<disk>/atomic_write_unit_min_bytes
+Date:		January 2024
+Contact:	Himanshu Madhani <himanshu.madhani@oracle.com>
+Description:
+		[RO] This parameter specifies the smallest block which can
+		be written atomically with an atomic write operation. All
+		atomic write operations must begin at a
+		atomic_write_unit_min boundary and must be multiples of
+		atomic_write_unit_min. This value must be a power-of-two.
+
+
+What:		/sys/block/<disk>/atomic_write_unit_max_bytes
+Date:		January 2024
+Contact:	Himanshu Madhani <himanshu.madhani@oracle.com>
+Description:
+		[RO] This parameter defines the largest block which can be
+		written atomically with an atomic write operation. This
+		value must be a multiple of atomic_write_unit_min and must
+		be a power-of-two. This value will not be larger than
+		atomic_write_max_bytes.
+
+
+What:		/sys/block/<disk>/atomic_write_boundary_bytes
+Date:		January 2024
+Contact:	Himanshu Madhani <himanshu.madhani@oracle.com>
+Description:
+		[RO] A device may need to internally split I/Os which
+		straddle a given logical block address boundary. In that
+		case a single atomic write operation will be processed as
+		one of more sub-operations which each complete atomically.
+		This parameter specifies the size in bytes of the atomic
+		boundary if one is reported by the device. This value must
+		be a power-of-two.
+
 
 What:		/sys/block/<disk>/diskseq
 Date:		February 2021
diff --git a/block/blk-settings.c b/block/blk-settings.c
index 06ea91e51b8b..11c0361c2313 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -59,6 +59,13 @@ void blk_set_default_limits(struct queue_limits *lim)
 	lim->zoned = false;
 	lim->zone_write_granularity = 0;
 	lim->dma_alignment = 511;
+	lim->atomic_write_hw_max_sectors = 0;
+	lim->atomic_write_max_sectors = 0;
+	lim->atomic_write_hw_boundary_sectors = 0;
+	lim->atomic_write_hw_unit_min_sectors = 0;
+	lim->atomic_write_unit_min_sectors = 0;
+	lim->atomic_write_hw_unit_max_sectors = 0;
+	lim->atomic_write_unit_max_sectors = 0;
 }
 
 /**
@@ -101,6 +108,20 @@ void blk_queue_bounce_limit(struct request_queue *q, enum blk_bounce bounce)
 }
 EXPORT_SYMBOL(blk_queue_bounce_limit);
 
+static void blk_atomic_writes_update_limits(struct request_queue *q)
+{
+	struct queue_limits *limits = &q->limits;
+	unsigned int max_hw_sectors =
+		rounddown_pow_of_two(limits->max_hw_sectors);
+
+	limits->atomic_write_max_sectors =
+		min(limits->atomic_write_hw_max_sectors, max_hw_sectors);
+	limits->atomic_write_unit_min_sectors =
+		min(limits->atomic_write_hw_unit_min_sectors, max_hw_sectors);
+	limits->atomic_write_unit_max_sectors =
+		min(limits->atomic_write_hw_unit_max_sectors, max_hw_sectors);
+}
+
 /**
  * blk_queue_max_hw_sectors - set max sectors for a request for this queue
  * @q:  the request queue for the device
@@ -145,6 +166,8 @@ void blk_queue_max_hw_sectors(struct request_queue *q, unsigned int max_hw_secto
 				 limits->logical_block_size >> SECTOR_SHIFT);
 	limits->max_sectors = max_sectors;
 
+	blk_atomic_writes_update_limits(q);
+
 	if (!q->disk)
 		return;
 	q->disk->bdi->io_pages = max_sectors >> (PAGE_SHIFT - 9);
@@ -182,6 +205,62 @@ void blk_queue_max_discard_sectors(struct request_queue *q,
 }
 EXPORT_SYMBOL(blk_queue_max_discard_sectors);
 
+/**
+ * blk_queue_atomic_write_max_bytes - set max bytes supported by
+ * the device for atomic write operations.
+ * @q:  the request queue for the device
+ * @bytes: maximum bytes supported
+ */
+void blk_queue_atomic_write_max_bytes(struct request_queue *q,
+				      unsigned int bytes)
+{
+	q->limits.atomic_write_hw_max_sectors = bytes >> SECTOR_SHIFT;
+	blk_atomic_writes_update_limits(q);
+}
+EXPORT_SYMBOL(blk_queue_atomic_write_max_bytes);
+
+/**
+ * blk_queue_atomic_write_boundary_bytes - Device's logical block address space
+ * which an atomic write should not cross.
+ * @q:  the request queue for the device
+ * @bytes: must be a power-of-two.
+ */
+void blk_queue_atomic_write_boundary_bytes(struct request_queue *q,
+					   unsigned int bytes)
+{
+	q->limits.atomic_write_hw_boundary_sectors = bytes >> SECTOR_SHIFT;
+}
+EXPORT_SYMBOL(blk_queue_atomic_write_boundary_bytes);
+
+/**
+ * blk_queue_atomic_write_unit_min_sectors - smallest unit that can be written
+ * atomically to the device.
+ * @q:  the request queue for the device
+ * @sectors: must be a power-of-two.
+ */
+void blk_queue_atomic_write_unit_min_sectors(struct request_queue *q,
+					     unsigned int sectors)
+{
+
+	q->limits.atomic_write_hw_unit_min_sectors = sectors;
+	blk_atomic_writes_update_limits(q);
+}
+EXPORT_SYMBOL(blk_queue_atomic_write_unit_min_sectors);
+
+/*
+ * blk_queue_atomic_write_unit_max_sectors - largest unit that can be written
+ * atomically to the device.
+ * @q: the request queue for the device
+ * @sectors: must be a power-of-two.
+ */
+void blk_queue_atomic_write_unit_max_sectors(struct request_queue *q,
+					     unsigned int sectors)
+{
+	q->limits.atomic_write_hw_unit_max_sectors = sectors;
+	blk_atomic_writes_update_limits(q);
+}
+EXPORT_SYMBOL(blk_queue_atomic_write_unit_max_sectors);
+
 /**
  * blk_queue_max_secure_erase_sectors - set max sectors for a secure erase
  * @q:  the request queue for the device
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 6b2429cad81a..3978f14f9769 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -118,6 +118,30 @@ static ssize_t queue_max_discard_segments_show(struct request_queue *q,
 	return queue_var_show(queue_max_discard_segments(q), page);
 }
 
+static ssize_t queue_atomic_write_max_bytes_show(struct request_queue *q,
+						char *page)
+{
+	return queue_var_show(queue_atomic_write_max_bytes(q), page);
+}
+
+static ssize_t queue_atomic_write_boundary_show(struct request_queue *q,
+						char *page)
+{
+	return queue_var_show(queue_atomic_write_boundary_bytes(q), page);
+}
+
+static ssize_t queue_atomic_write_unit_min_show(struct request_queue *q,
+						char *page)
+{
+	return queue_var_show(queue_atomic_write_unit_min_bytes(q), page);
+}
+
+static ssize_t queue_atomic_write_unit_max_show(struct request_queue *q,
+						char *page)
+{
+	return queue_var_show(queue_atomic_write_unit_max_bytes(q), page);
+}
+
 static ssize_t queue_max_integrity_segments_show(struct request_queue *q, char *page)
 {
 	return queue_var_show(q->limits.max_integrity_segments, page);
@@ -502,6 +526,11 @@ QUEUE_RO_ENTRY(queue_discard_max_hw, "discard_max_hw_bytes");
 QUEUE_RW_ENTRY(queue_discard_max, "discard_max_bytes");
 QUEUE_RO_ENTRY(queue_discard_zeroes_data, "discard_zeroes_data");
 
+QUEUE_RO_ENTRY(queue_atomic_write_max_bytes, "atomic_write_max_bytes");
+QUEUE_RO_ENTRY(queue_atomic_write_boundary, "atomic_write_boundary_bytes");
+QUEUE_RO_ENTRY(queue_atomic_write_unit_max, "atomic_write_unit_max_bytes");
+QUEUE_RO_ENTRY(queue_atomic_write_unit_min, "atomic_write_unit_min_bytes");
+
 QUEUE_RO_ENTRY(queue_write_same_max, "write_same_max_bytes");
 QUEUE_RO_ENTRY(queue_write_zeroes_max, "write_zeroes_max_bytes");
 QUEUE_RO_ENTRY(queue_zone_append_max, "zone_append_max_bytes");
@@ -629,6 +658,10 @@ static struct attribute *queue_attrs[] = {
 	&queue_discard_max_entry.attr,
 	&queue_discard_max_hw_entry.attr,
 	&queue_discard_zeroes_data_entry.attr,
+	&queue_atomic_write_max_bytes_entry.attr,
+	&queue_atomic_write_boundary_entry.attr,
+	&queue_atomic_write_unit_min_entry.attr,
+	&queue_atomic_write_unit_max_entry.attr,
 	&queue_write_same_max_entry.attr,
 	&queue_write_zeroes_max_entry.attr,
 	&queue_zone_append_max_entry.attr,
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 99e4f5e72213..d5490b988918 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -299,6 +299,14 @@ struct queue_limits {
 	unsigned int		discard_alignment;
 	unsigned int		zone_write_granularity;
 
+	unsigned int		atomic_write_hw_max_sectors;
+	unsigned int		atomic_write_max_sectors;
+	unsigned int		atomic_write_hw_boundary_sectors;
+	unsigned int		atomic_write_hw_unit_min_sectors;
+	unsigned int		atomic_write_unit_min_sectors;
+	unsigned int		atomic_write_hw_unit_max_sectors;
+	unsigned int		atomic_write_unit_max_sectors;
+
 	unsigned short		max_segments;
 	unsigned short		max_integrity_segments;
 	unsigned short		max_discard_segments;
@@ -885,6 +893,14 @@ void blk_queue_zone_write_granularity(struct request_queue *q,
 				      unsigned int size);
 extern void blk_queue_alignment_offset(struct request_queue *q,
 				       unsigned int alignment);
+void blk_queue_atomic_write_max_bytes(struct request_queue *q,
+				unsigned int bytes);
+void blk_queue_atomic_write_unit_max_sectors(struct request_queue *q,
+				unsigned int sectors);
+void blk_queue_atomic_write_unit_min_sectors(struct request_queue *q,
+				unsigned int sectors);
+void blk_queue_atomic_write_boundary_bytes(struct request_queue *q,
+				unsigned int bytes);
 void disk_update_readahead(struct gendisk *disk);
 extern void blk_limits_io_min(struct queue_limits *limits, unsigned int min);
 extern void blk_queue_io_min(struct request_queue *q, unsigned int min);
@@ -1291,6 +1307,30 @@ static inline int queue_dma_alignment(const struct request_queue *q)
 	return q ? q->limits.dma_alignment : 511;
 }
 
+static inline unsigned int
+queue_atomic_write_unit_max_bytes(const struct request_queue *q)
+{
+	return q->limits.atomic_write_unit_max_sectors << SECTOR_SHIFT;
+}
+
+static inline unsigned int
+queue_atomic_write_unit_min_bytes(const struct request_queue *q)
+{
+	return q->limits.atomic_write_unit_min_sectors << SECTOR_SHIFT;
+}
+
+static inline unsigned int
+queue_atomic_write_boundary_bytes(const struct request_queue *q)
+{
+	return q->limits.atomic_write_hw_boundary_sectors << SECTOR_SHIFT;
+}
+
+static inline unsigned int
+queue_atomic_write_max_bytes(const struct request_queue *q)
+{
+	return q->limits.atomic_write_max_sectors << SECTOR_SHIFT;
+}
+
 static inline unsigned int bdev_dma_alignment(struct block_device *bdev)
 {
 	return queue_dma_alignment(bdev_get_queue(bdev));
-- 
2.31.1


