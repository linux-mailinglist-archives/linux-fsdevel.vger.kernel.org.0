Return-Path: <linux-fsdevel+bounces-50849-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B0DBAD0443
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 16:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9A127AB1A4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 14:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F3F1C1741;
	Fri,  6 Jun 2025 14:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mbuNADFm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ddC9jfmd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0E1189B84;
	Fri,  6 Jun 2025 14:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749221613; cv=fail; b=C+5EJ4DIYpfropGuqJfvYSJegdM0BQTiefSLDXkDfpNX6UgzYkCqfDFVwmI1gJZBBV0Pvcn1re1Z+IJAudp+sED1HCnqlliKjcABYpwAkOc9Fu+Lvd1NcOsew4JFklKPV2aYZW+c8QzYtqfltZ1PXMbdLcbM29Ucza0XDDi9uyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749221613; c=relaxed/simple;
	bh=C1oPQcHj4UwTjt7yDPbXrLYN8ZPgKorB5PaGLRt+Yus=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=MVY0rT1QUkO9b8QfRpwzNZa2koJXHS9PIaZSFYwJlcbUCCGVRbMYjt6NAAqk2Y4wnhLcHl0URNd2OpPHwbfyQ6sIgYc16YPviq94cKoxHpxEfy1LaaN33mxmtFMBWFcEKSwX+944RYhZoIO5HsgxHuf5ucx+cntrZCSuV0idGAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mbuNADFm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ddC9jfmd; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5565NOqZ021716;
	Fri, 6 Jun 2025 14:53:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=hWFNKoOQdMkWz0GnXoGVpsF2xeHDxl4Yk373X3mOnHg=; b=
	mbuNADFmTVr2jmO+bunkVfOPOU9DhuG57HY+dzx045TvBRJ6Z3W2OcG3LrW2ZbJX
	VzTCGsOxNY+u2ugz+Ulg1xLKilbs8xRbI+B9dIhAuAKmV+iaAOZD1sxqxrAZtFFF
	YdQa+31+VpgORSBWUjUVSNjapYHbiyfy9bXYUmpy+vCEM2V+C5j/hgjdBhurEBiw
	3UCXDhHGK63650RKcpwq89x39iGtUVysgyzK4sPWIO7jJ8ElwUc26//d1lK85NFp
	3Gnhzbl/KT0XIpA0mU09gSBn91THqGHUFIxV/TaTTW9f4l5JGeQPX6OaK5zN1lhf
	jGjC7gQdWesguI7xx7r4Ug==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 471g8br3jq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Jun 2025 14:53:14 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 556Dd5oq016369;
	Fri, 6 Jun 2025 14:53:14 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2065.outbound.protection.outlook.com [40.107.236.65])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46yr7dcdd5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Jun 2025 14:53:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qdtoY55koXVp4K3332Xm1p6CQX/MW5hAGq8h8GmeWaraqRWnjLo2h+G8MyHrQrfqFZEcc/Mq8eSO7aooXi7hhENmNEMfpGdym9m32BfO8YDBcnlHYyiGrQ1uYxmZbwWyFbuJyT8573Lqt31Tvw7l/nh9CYaWmVP0pCrr8sMFEM6s2YFWAw3qUNUE2ZWSIqY8LmVFGUkGjea4h84TJ+xtq5bZ847ojZ9lpZG7dS2HSdWPKlxtO8bXx7TKVbtiLn1rN4e5GimenHRlYM6KO1elAauAcSBtZMocY/Vah0G/+uTgeip1xdAME8LCMxc/4RJkZBlPkPKXp0mxT2R8wikWVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hWFNKoOQdMkWz0GnXoGVpsF2xeHDxl4Yk373X3mOnHg=;
 b=dWB0QWyf4JZQmVhIjk7H9lQv/dLXtA+JvXfzJ2+vC0CLKqWpbkbhT3822WZlH9HfCWi5cLrs7d7SIXYemY3vZzpecg2X1R8/SGXfHMc8m+lv8XXcZZonpH6MjZAhxPdS0VZ88GsSC5Ot1K19F9G1dzuYTWA+vAYeXlhNzBUtFedpH/ijItNY+zh+rfysyfdHNjEB4+Rc89RbPeQAdR4UyI0KVAgazGjm0aCPOqJP4wYNTr/pjXLGRITfVgsZGWFySm57GwCoh0AvWBhmuxSo2obA40kIHpEl/wk7iLrMFhhFJ2ThuaCkIDD8cBTm8A1SyVaL3rwk4KH8Eg8RLlgq0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hWFNKoOQdMkWz0GnXoGVpsF2xeHDxl4Yk373X3mOnHg=;
 b=ddC9jfmd9arRXyy4scWzRPaKdHvmyF9l/uUzlNuwxKgq82qhK+JDHAzwIlcYFdjxm/Ah72crZVnzOK69vq1T65zMscToz0fQsr7yBseJ7BvTEI/Dox4v01JJ0mCbevGswHbrmte7rko8v7doESwzq4H6LRcZhNoiusaqVIJWM0A=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by DM3PPF3367D7B9B.namprd10.prod.outlook.com (2603:10b6:f:fc00::c1a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.40; Fri, 6 Jun
 2025 14:53:11 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%7]) with mapi id 15.20.8813.018; Fri, 6 Jun 2025
 14:53:11 +0000
To: Anuj gupta <anuj1072538@gmail.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
        Anuj Gupta
 <anuj20.g@samsung.com>, vincent.fu@samsung.com,
        jack@suse.cz, axboe@kernel.dk, viro@zeniv.linux.org.uk,
        brauner@kernel.org, hch@infradead.org, ebiggers@kernel.org,
        adilger@dilger.ca, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, joshi.k@samsung.com
Subject: Re: [PATCH for-next v2 2/2] fs: add ioctl to query protection info
 capabilities
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <CACzX3AujmHHvzBVta2fjrQvytscv5kS0NSgt4iUq-LtXP167BA@mail.gmail.com>
	(Anuj gupta's message of "Fri, 6 Jun 2025 17:29:02 +0530")
Organization: Oracle Corporation
Message-ID: <yq1qzzx9dd2.fsf@ca-mkp.ca.oracle.com>
References: <20250605150729.2730-1-anuj20.g@samsung.com>
	<CGME20250605150746epcas5p1cf96907472d8a27b0d926b9e2f943e70@epcas5p1.samsung.com>
	<20250605150729.2730-3-anuj20.g@samsung.com>
	<yq1a56lbpsc.fsf@ca-mkp.ca.oracle.com>
	<CACzX3AujmHHvzBVta2fjrQvytscv5kS0NSgt4iUq-LtXP167BA@mail.gmail.com>
Date: Fri, 06 Jun 2025 10:53:08 -0400
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SJ0PR05CA0159.namprd05.prod.outlook.com
 (2603:10b6:a03:339::14) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|DM3PPF3367D7B9B:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e7556b9-4536-42cb-5d9d-08dda509dba0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?THh1SERFbm9kV3VLUWxCelVISklsOXlpSUhBd05nVUNqQjlVMHFPekg2dW9v?=
 =?utf-8?B?cFovMUxJY3FjTzVQZzJMZXE4bU5EcndvSng2QWRDUG5zc0JBckdMS0VDeHoy?=
 =?utf-8?B?N1czZHR6d01qV3hNL1NsT1U0L0ErUGtHQm44a1VNZjg4ZWRJekxqQzRhSjgv?=
 =?utf-8?B?TGRZN2t1TFRCU0JFVk5acEZQY1ZxWk9sNC9KOGdESVFhQUY5MFFUYis2Qm9D?=
 =?utf-8?B?NXVQZXlodG4vNUJHNVZjeE9Jc2txUXFIS2U3azFOTUtlK0VRMENmUHJmRXBs?=
 =?utf-8?B?ZlV1K0xnaGNjMTBCQzUvWEZ2UllPdFo0eTU5RUVTeFkxNEx1L0FyRWpHVm9k?=
 =?utf-8?B?aGJIUWJXSkc2c080ZUI0OWdiRGVNZWtRclBxYTgvTnhyY1hOc2d2bDNlUTlt?=
 =?utf-8?B?UnY1UHZRVy8vT3dXblM3TUhQSzVRVTFvTHIwZ29kMUNzT3dyQjNhSGJiaXdY?=
 =?utf-8?B?VmhGNUlFNTdCRGRYRS81Q3NJaU8vTk54YjIzRjhjbkFFaktjRHFpaFFKZnNk?=
 =?utf-8?B?dHhid0c1dHlVRnk3T0J4L3RVWG9xUjBuVDB3MkhhQjdqQVcyZjhoT2VWb25W?=
 =?utf-8?B?cXBWTDY5UjFMUUV0S2VOK1ZsYy92dkkxNk1LZHd4Zk42TW9JM3o3alhVZkc2?=
 =?utf-8?B?QUh4bUI1NlI3SE8vdHVmREN2NldSbnBPTFU0WjliVThZajAvWmI3RXdyZnlV?=
 =?utf-8?B?bDhMTjNHSVdCVThqenBJQUJUUjhGdGVuN3lBdXVZTXMyeEJaTFpjb0JiQjVB?=
 =?utf-8?B?TkxscldFeFltVG9VV2xvaFFTc3MwMnJFVmdLUVVEeXFtR1hqNG9PWnZPdWYz?=
 =?utf-8?B?WXRodU9lVDNQUW9IUm1rL0cwNWZ0ajM0U2RVdFB5c0ZpclRkZ0ZQY3BHOWlq?=
 =?utf-8?B?bXVyUFJxSzRJZ2pMcGtYRWlZeDlBemRoVTlKNGUyNW04dEQvWmFBb2tsREJH?=
 =?utf-8?B?S2p1K1paWkk1eWJPYnVLM08rTHJuVHJYRUxPOE8zQUV4TFhTMEQ5QmtRak9q?=
 =?utf-8?B?TlA0VDFwR3dKS21TTUpkd2JIZTBoWFpTRDZtTkFMRnlTbE8wYWo5akVXYlha?=
 =?utf-8?B?N2dOZks3OU43NDVNaU1zT0twZ0YvK0FQVXRMYkhBSjk0dlN3ZXE3WW9JTXMy?=
 =?utf-8?B?amNsZDRrVDIwaGZMWkRseVpYdUtKNUhjY2tOWTFXb3pOcmVyZEdNWnFOc3Fr?=
 =?utf-8?B?NkpOOUlHdlV4aUVjQzFUTlhkWU9QaU1HdHhiays1QytwNGhJZFc2dXlKaERt?=
 =?utf-8?B?SWJPUzB1d0JSRFp6REVaU3psUHlMbWNSL0N3Vy9pSnllaGhVV1RhTHZza3hD?=
 =?utf-8?B?SUVvRk9ocTYzWVdaRzIreG9ZQ2kyTnBPU0laZTA0a0s2eVV4L0FOZjFtRVFH?=
 =?utf-8?B?aXV4U1ZwSmJNdE1od0t0OCtXMG5SU1B3K3I4c1hZY2dJTDk2c3F6UGxoMHdv?=
 =?utf-8?B?U1FMZHhQanozU2tUQWp3ZVBpTzBDV2NHTDVvRHVDVmpybm1iNklkZ0Z4OCtj?=
 =?utf-8?B?czR3OTJTS2RCU1paOHRmUWwyYStpSHl6bUFPQ1B1TTJYRlVDYWl1eEs3Z0Nz?=
 =?utf-8?B?UUZ6TjUxa3hyb1pmanBLN2JyclpQRUV6TGNpZ0FONkZubkc2R1lualRnRzFl?=
 =?utf-8?B?UjhZTFBocVphbWRRMmIvQm5HYVRJMWhySnF1dHhNSFpvNjNMRldiQk0zY2tl?=
 =?utf-8?B?cWtkREEwWnlub2xvOVVIeHY3TlpJYU5aOXo1MVVLaTY5UEM5djMxY2F0RUl1?=
 =?utf-8?B?WTVGcEhHbWVCL3ZOVER4ZWMxSk5rU1ZTSjlJRWxmemtiTUY0cFFMYWNQK1BE?=
 =?utf-8?B?ZFJWREtMN2o0YzBNbjFLYWpVdnNPNDRqT3dUazl3SXlxMXNVL2dDdmN0SVV4?=
 =?utf-8?B?Ri95K3UvK3ZIaThJb1B1eGJIMjBYNGpjQWRiZ3h0OXAwVkZ6emVPY0VIcXNV?=
 =?utf-8?Q?HqWCCh0gHsc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q2N4UG9uUHBxWi9hVFFEKzdsTDQ5RXhmd3JmU3V4MklweU1YTW51VUxaWEhz?=
 =?utf-8?B?MWVrKzVySkdDT1A1cUoxR3I4RW56akhiS1NHckxsd0ZXRmVucDJiVllDWWY4?=
 =?utf-8?B?dDFER2g5TmVCSUJkQ3V0aS9CdHZnNm4xdEVSd0xxYi9NUDZqOHRUUmVjZ0FV?=
 =?utf-8?B?MDlXZzUzRDNFRHFIdHZselhqVmtJUlJDTEQ0elVMeDIvalpYdjR0QTR1SDBQ?=
 =?utf-8?B?S2ZSMHp5UXc4b2VPV240djdLM09DK090NHJpZEhKbVN6RElsdUUwMHVuSUhR?=
 =?utf-8?B?RHBRQklzL0pCRkIrMlZCemFsQjlBVFdwNkdPNTNjYzNtSmdwb3Azem1UcDBs?=
 =?utf-8?B?TTJQV09FeVBMeGNPampONDF4NFNtUW9seU5ObjRrYUFwY1QvWkdSNy9JdlUv?=
 =?utf-8?B?ZGo1cXZ2TGprZ0YwRURBQXFxSFpzbUxWL24yVzdQeEgxWG9RbXorajY5QVJL?=
 =?utf-8?B?bzNGLzZkOUtHSHFsSG5vSktUSGRITzRyWWkxekNPL0FWMWpNemJSdTgvaWVj?=
 =?utf-8?B?WWZpOE9GbmdVZG8rZDl6NDk5NGVSdmxtK2c0WU9ISWMvV3FOb2QrZTdwQUIz?=
 =?utf-8?B?eXBoSXVVcFQ0THRVT1l5SHBYTG8vNHFEcXVYZ3lmcEtGSURieUMrZXBRa0M0?=
 =?utf-8?B?L1B5Sm9HT1AyWWxCcTBqamZkRENwVU56bXgrQTV1a0FXSXVPOFN5WWNOVzhX?=
 =?utf-8?B?My9tZmszSnZwLzcxeE5BK3V3TGpFd2RjL29LdVBlRzJ6NG9lcHY5WlFNcDZv?=
 =?utf-8?B?WGlTYzk3K3pLZE1HMzJxMmhGSno0OFZDbjNudTBBQTRkdHpzQVlubzVaRVpG?=
 =?utf-8?B?Tk9GOURDS0ZVdnA3c2JJTGJTMndCM0FhNzFhM2cxMmUweitVVzJMYjMwT2pk?=
 =?utf-8?B?cEFaYTlGWEhZTXBCSW9vTWp0QlhtbTNTRmRmeS92Z0RvajFZQ0VQaEppZWdM?=
 =?utf-8?B?UnowVFNKc2JHRDIvaGhQMUw2NXViNTZLMzRNWWo0L1lQM3pBajNPSmlLU3N3?=
 =?utf-8?B?anlGK25TQ21sV29PU1F5T1BiZWRMNmZUVlVtWnJxL0JQVjM5UWYyZnhrUGhP?=
 =?utf-8?B?cEtDMVVDUnl0WXFkRDVLZUVnbE9CNkU3L1FvTTVaWXMvNUhHL3FsNjRuV2wz?=
 =?utf-8?B?U0tQVWhGdzB4MVN2YmxXUzc3OTFxd3pabGhxNXl2MG81K3JFS1hSUnNMVmky?=
 =?utf-8?B?dWJ0U2pFcER1QUtZQU52b0loWUpIWXVJc3hBMjBhU1ZFMGh0R0xqR0NEMnFR?=
 =?utf-8?B?TjhMcm9vekt1N0UyM3o2R3lmSGdVSXQ0akk2ckF1QXEwSmZDR1pVSHFJckNV?=
 =?utf-8?B?TjJXejlrR0svUlpxc0ptYnpKOFlVSStwRzd6Rk9zVGN2MVBSSkdic1pTb2dn?=
 =?utf-8?B?Mm1UYTZMby9WZmdOM2tKQ2d1akdDdHN4U1doWWFSbkN5cWhOcEVzNFJPelNH?=
 =?utf-8?B?UHE2VzhiMGduUWw2Zm5NbUxYVmgyTC81am5pN1p6dE9CanEyQm1MejBhdmZm?=
 =?utf-8?B?V0h3NytJRDlMQ1FrOXFZcVVNSDZrVUhoOHExaEoyTW9weGdSemY3ZFlmalNI?=
 =?utf-8?B?TzMyZnpvVGo1cjdGWjdLMy9XS1NyOEt5b1p3Ryt2Z0Z0VlROeHBMQUp1cEJ0?=
 =?utf-8?B?c09lREVxNzFZMkRVOENGT3kzc3ZBQ3ZaeEUvR0FJd2pVTzNJWTErMS9iejls?=
 =?utf-8?B?d0ZtMjdycmxrWnlhYjFEK3dYNndKYTd4WVA3RmlLUXZ4amtjQUpoV3VxS3o2?=
 =?utf-8?B?M1Z3aGNQU3JXRnN3SnAxQ3VEM0ZoUzBCS04ya2NnWk5vYi83Q1VxTDViT213?=
 =?utf-8?B?UUdlUjZVQmloQzlRSGhwb1dSQ1pZOERZZElYZ1U5eDlKYWpVZFFDR3dwSEJQ?=
 =?utf-8?B?UkJjcTJ6bE5YRFgxbVI3Q3JrTEVlU3NyRkNVK3hyNDg0dXp1VmRXWE1vWVFI?=
 =?utf-8?B?OEFqSnVTRUxsc2N2Vk94Q3hUVlBuK3o3MVg4cm0wUE42U20vQmdoUDEvMHk3?=
 =?utf-8?B?WE1JZktmaHBnWStjQmRRcHp5TjRINWYwakRXNUFRcE1Cd0plenVLdkdCVHZK?=
 =?utf-8?B?VFA1ZXA1T1B3dkVXT2t6SjZrLzNzaWhLM2VIQXhJeTJ1dEhwajRnbzdoRDJx?=
 =?utf-8?B?dnVjajUyQ2R3aWtiWXNYQzZvSXh3TG9NMzg4WVBPSnI3ZENnVy84T0ljL0VM?=
 =?utf-8?B?YlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qmI0Ahj4bONKf0uElqTnEzghgdWeAKX8OYDhD9wf9CLR+5gujIdyy9zE5SnHqKz9ejmnB3KsA8Y9qjeRjd7cu+j7Yf3xGZGundKi8OC90NUFDKnuSobj1hPSSjgmlpqzzqaUXlLe4kPUSgQSXudivcU6QJGHJrLhIGf3r0jc9GOc0am8z4DWvn0dqxmPNiV4G1FebrxlxrZJNHgPaJp+eSqxk4AeStdUDg1BdgKHqrdGQgzeDFC5KRir2m4aJfebdvT8Xah44uk0IW/fKjZISTcOLPgQE0hFuvrdvc7fNL97oNrQrkv+A+Spu04p6XzDEQywtYbVASKMQMd2TtD2Nzex3Xlkk+ldwM+SyJUvXKU3GboC29qOs04NZTZ+Iua+lsmfZy9KEx6mmBrPSoKocVDe7Xfw3hbyvOooLXdlj9z5ODRabpprijcYSRjl+rCHLxFJuA8m7YGVHpWEkbc2BhBiKjIDoIFK4MhRxJElKJxQITx0gfT/uhVLBj6p4whNL50YD1xKGDu45ZFVkjXATqRtd76BzZz2tlYAE/ZFGqOduR0WbKsav0wYxLrErLvoXGxa9aZFGvMOW7bd+Umf9c/gx+2S8WRJeHmiQbvvXa4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e7556b9-4536-42cb-5d9d-08dda509dba0
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 14:53:11.6855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7MTaV6nUe4Yla3v7ttiDS6DhjVJBl3D4VCvu9SR4x2HivlHxeWNPv/myYhhMKVDrBeXOhir7qZW3xRts5BHalGd2mrmJTvP2Y0qmz9y9NfI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF3367D7B9B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-06_05,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 bulkscore=0 spamscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506060131
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA2MDEzMSBTYWx0ZWRfX0lllVZwM32wu UktYUGu1I2WmAl19JN2YprG1lF1becQqgl7bUvAjMFD4sv292gsZdG8jRcSMg2LEqbkHqQfr92f ePTQNwSlHcftHggCJAaTFp27bHhi/mUMWHnnTOHSi1MqSvTVhZXj/2aMOo8/wkgQkeXfNXKB5X2
 raifWpu9pA1SwjrBbmR+oFzPEPd1KKGq/pFrfzixVi4gQdPXk+H/aceriSMOtOMo7Uc7LwkEBkI AkFMEOGxI/nBDe/afQ1WEKRz7Zul0+YDpVn19FzXL0P115BJTUVbX283CYdG1PciZsGU1jCYbct P7mxBO9NbVMBkHc6SacpaIdhvhvJY3mDtj6Q4MwJAjSwqczbm58laEHF+3qyUfswNIVyFCr/0eG
 nSUokxLfYuDM0W6WPoulqA8Q7MfMh+JuswV7abQJ9NBsVXrKYdgSyvA0q0aI6Tt2pf/tDX93
X-Proofpoint-GUID: gW69dIEwAHfmDqJ20WKpaHBExkE2eC5S
X-Proofpoint-ORIG-GUID: gW69dIEwAHfmDqJ20WKpaHBExkE2eC5S
X-Authority-Analysis: v=2.4 cv=H+Dbw/Yi c=1 sm=1 tr=0 ts=684300da cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=OdSQyYjR-AHRPebLRoQA:9 a=QEXdDO2ut3YA:10


Hi Anuj!

> Thanks for the suggestion. I see your point =E2=80=94 especially from the=
 NVMe
> perspective, where integrity buffer can be larger than just the PI
> tuple.
>
> However, since this ioctl is also intended to work on regular files,
> where "metadata" usually refers to inode-level attributes, timestamps,
> permissions, etc., I worry that FS_IOC_METADATA_CAP and
> fs_metadata_cap might be confusing in the broader filesystem context.
>
> Using FS_IOC_GETPI_CAP and struct fs_pi_cap seems more narrowly scoped
> and avoids that ambiguity. Do you see this differently? Or if you have
> a better alternative in mind, I=E2=80=99d be happy to consider it.

I agree it's ambiguous. I just find it equally confusing that "PI" is
now being used to describe opaque metadata which has nothing to do with
PI.

When the block layer code was originally implemented I tried to be
careful about using the term "integrity metadata" everywhere to
distinguish it from "filesystem metadata". It was deliberate not to use
T10 terms in the block layer since there were other competing protection
formats at the time. So one way to get us out of this naming problem
would be to clearly distinguish between for instance "logical block
metadata" and "filesystem metadata".

An alternative would be to revive the concept of "block tagging". The
reason the existing "tag_size" parameter is not called "app_tag_size" is
that the "tag" is "filesystem tag". The fact that it was backed by the
application tag in the PI case was coincidental. The idea at the time
was that filesystems would tag their filesystem blocks with backpointers
and additional information about the contents which would be useful in a
recovery scenario (i.e. "this is a data block for inode XYZ"). So we
could entertain "block tag".

Anyway. I'm thinking something along the lines of this:

* struct logical_block_metadata_cap - Logical block metadata
* @lbmd_flags:			Bitmask of logical block metadata capability flags
* @lbmd_interval:		The amount of data described by each unit of logical blo=
ck metadata
* @lbmd_size:			Size in bytes of the logical block metadata associated with=
 each interval
* @lbmd_opaque_size:		Size in bytes of the opaque block tag associated with=
 each interval
* @lbmd_opaque_offset:		Offset in bytes of the opaque block tag within the =
logical block metadata
* @lbmd_pi_size:		Size in bytes of the T10 PI tuple associated with each in=
terval
* @lbmd_pi_offset:		Offset in bytes of T10 PI tuple within the logical bloc=
k metadata
* @lbmd_pi_guard_tag_type:	T10 PI guard tag type
* @lbmd_pi_app_tag_size:	Size in bytes of the T10 PI application tag
* @lbmd_pi_ref_tag_size:	Size in bytes of the T10 PI reference tag
* @lbmd_pi_storage_tag_size:	Size in bytes of the T10 PI storage tag
* @lbmd_rsvd:			Reserved for future use

That way there's a clear distinction between "all of the metadata", "the
non-PI metadata", and "the PI metadata". Also saves the caller from
doing size and offset calculations by hand for the non-PI stuff.

--=20
Martin K. Petersen

