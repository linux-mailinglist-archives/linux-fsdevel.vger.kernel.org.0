Return-Path: <linux-fsdevel+bounces-19557-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F078C6E78
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 00:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA6BD2831CB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2024 22:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC5215B574;
	Wed, 15 May 2024 22:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XfxjSMGv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SzS0mCts"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B750415B0E3;
	Wed, 15 May 2024 22:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715811302; cv=fail; b=prNg0ZdLkjNzw9uycYADwhXvAmHc99nePommDeMjHTjRJRrIoIkwqXPosi7Dn7XSwoKIqzXogVok+nxSfk2cjFAXNd+T45PBwwrNK32KtES7LKO5idEDpPtXpvwZH8KcUtwAqwlAbnnJW6pQHtCpgpwRzIVsSor/Jx7U+7MmSCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715811302; c=relaxed/simple;
	bh=96nzm7KDVxI/TNMf4hGs9SZrHngXwzHlev8Bhu5ie7U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=laFR51t0bOpqDs4mRSrmC2RtxfAiXR5cU87vZjJ/uAino0IPHANQD0yIqp1UXYNfoJDLDpFQJ8dB2Th1iFSvGZlgahpIEhke28gHOSnTvAHV9QRCBiEh4CYySCGHbmiKVcUvAwqCQ7QAt0FBDc1cZUI8xPDsfeA17FHeRqMYre0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XfxjSMGv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SzS0mCts; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44FL0vaK016113;
	Wed, 15 May 2024 22:14:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=96nzm7KDVxI/TNMf4hGs9SZrHngXwzHlev8Bhu5ie7U=;
 b=XfxjSMGvFklssmXjtyV7vLCsQzsZCiluWsEYid6HpLJXoObSs1Mex7u2uXA8o0tj2Ser
 4Lqv7pr6Hfk4GhAddwn1m42/EoU/GDYS24wJJGYeypUdLkAOtjt6YgIscOYwRESC3YQM
 qcQSKLhABEIVmP4rBSnQPvdDIDtwG50WRTMRjJMOqnb0z1d6JMdn/CfGT4xTTjuBOZbM
 F1iFhhgLSRIx6reWvtfu8RobxfJMeoDMwhYG7tcqKszOxn77GzKTYnjDOA2NKpXaiDGc
 LyvwyiWrG6AjEgYXxt/+J3TF/5TvxJkwyi2K31J/DICjyDrNZojkd2gzQt+XX+9ogm4Y ZQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y3txc474k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 May 2024 22:14:56 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44FLnBnR038451;
	Wed, 15 May 2024 22:14:55 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3y24py6kxj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 May 2024 22:14:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dq5ccmGxXrNkecBci+3QO9jr0kxCu+mlxb5H7VvxWhpTDlSo/tTb5g6lp1w7l9uwjjl2kU9ZR76bS6B2+hkVO90Jri+A6k9KIqsCm1Ax7nzN6oy5F+eWWw4rNX9/Q7KaZmOJ1pvHTAcZroQ9wY6ejJ883B7x6pfkkhOUa7g6vLr2mSAMZZjwQQe+j040JjiRhFVxgU7rImKEeNrgdb4pXIu+5MyyMUhmD+cV04r2hywmv//1YMH1hg8Ps30bCL+xhdiFGMaZ1EnuJBBzd1YAO9PVWajlID14p1Q+DLH6JOhsLuwzpMU19eWSnErLokS1ZESYgoKxOJxYVgcKizyUwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=96nzm7KDVxI/TNMf4hGs9SZrHngXwzHlev8Bhu5ie7U=;
 b=JWs0iUS4bLw9Xa7ygHsppe/+Gmq3MwlXpSsLw4Dx76P3CwyuoVhBW7hqq/21sfkRuYIPpMTSToX9z7KRxLoJMhVQbiL/88KAYrDp6eKkPLwMqsShOhZqnETJJzK9LLti0B9ZOS2qJXPJDEqIi6q4fwo3m7yLdw/6OEh2PXXfhv2OjP6RtacP1IdqmpFkJcdlXPRy+LdJ3+FVdRA+k5xNIFv0UcMnwDrnr/45YQrk02nVrJL8vaLfJ4TG3wxeA7R1Fvn2us12RCSjJfZnhfqlYdK8UKgrIDqaAmNDK3dB0CAmfarqkoyjLNbvTkWKMWE3JcQYNMgfUBpvk9iC8+ccPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=96nzm7KDVxI/TNMf4hGs9SZrHngXwzHlev8Bhu5ie7U=;
 b=SzS0mCtsFVFnHU3I6S0EHUDuh4TjgGV3Oq/LwiDLmu1BR4Vm5oZwEgNl1qHHIiD27oyD23pKL+/f7KE6pOlOs92KemEsYeSyKAGw//+ibxiEJ8YGzXL1DOD8smOb7fdl/6LVGHfZAA5x2fuu465Z+H/p/EGqVja1ubw8ndQkVAs=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by SA1PR10MB6640.namprd10.prod.outlook.com (2603:10b6:806:2b6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27; Wed, 15 May
 2024 22:14:53 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca%3]) with mapi id 15.20.7587.028; Wed, 15 May 2024
 22:14:53 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Jan Kara <jack@suse.cz>
Cc: Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] fsnotify: clear PARENT_WATCHED flags lazily
In-Reply-To: <20240515171503.loxpdv3xumgbc44w@quack3>
References: <20240510221901.520546-1-stephen.s.brennan@oracle.com>
 <CAOQ4uxjKdkXLi6w2az9a3dnEkX1-w771ZUz1Lr2ToFFUGvf8Ng@mail.gmail.com>
 <87bk59gsxv.fsf@oracle.com> <20240515171503.loxpdv3xumgbc44w@quack3>
Date: Wed, 15 May 2024 15:14:52 -0700
Message-ID: <87ttiypvs3.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SJ0PR13CA0208.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::33) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|SA1PR10MB6640:EE_
X-MS-Office365-Filtering-Correlation-Id: d03ae0d1-6974-408e-fba6-08dc752c71ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?eFVva0ZkWGwrOURLN1gvMzlBN0RZVDFnczZjeldoUFh3T2RYNDg4SXE3Wkph?=
 =?utf-8?B?MTZZTy9nUlduWHVoWjhTL080djhVcisyVlZIdTU5MUpUWUpZdkwzdlMwWWd0?=
 =?utf-8?B?MHVSRW1QdXpkWFRXY1cwYitQMkpRRlBvKzRLNjFxMi84eldLb0pnc2k5MUhT?=
 =?utf-8?B?UjcrWERoLzNZL243TzBONmpiVkpqQm8wb3l3dDRFTzY4T1pSTS90Z21xN3Y5?=
 =?utf-8?B?QjhlNDRpWE5INWlIL0tCUjZidmVTL1FrNWVlUXpLRDNpVVRxKzJjMjQvNnJU?=
 =?utf-8?B?Nng4T3pNT1FtWis0a3ZKL2VGNDE3OTA5RXBUWUdvbEgxMWpkMFlZQ01Id2JL?=
 =?utf-8?B?OHVQOFl4Mk84STJpbTkvRkNHdWlzUHBQa1U3ZVZDajBTUUViTXBNWVRSeHBR?=
 =?utf-8?B?aHRPdUE4VUp3NFJCMFJHUEVQdWgrcFFXbnUvaC8yZm8yRnBqVk5Sd1pzNndH?=
 =?utf-8?B?L3c3N1hENkQ5VEpwTkdtbWdYc2M0dmYxMGwvNDdldmVSWmZ5VHpZR0svRTc0?=
 =?utf-8?B?NGNTTEhIUmpFallYNWVDM0ZPb25pbisyQy9VeVpLd3JaL1lWYnlrZ0JTMTc0?=
 =?utf-8?B?ak44emE2dE96cTBOMmZsVTcxelpKTXdPb0tIdTNnbmsyWWRlYzRsUWUwTW9m?=
 =?utf-8?B?QkdBQzVoL0RaL2ZqQ0hLVXJnWjJETDVCVmJXYVJsVWtYQVBmbE5lMU51aUVw?=
 =?utf-8?B?NEIvQ2dwT2lONzVwS1R5eXFxcTNwbmEzM3JWbW8vTk1Kd2oxTFJnNVYvVmlr?=
 =?utf-8?B?eXVVQXY0cEszYU9seFJNd2YzS1RVM1NLNnA0M0kxc2RkSUhha201Njk3cjhM?=
 =?utf-8?B?bFlvQ3BwazZCNU91TmF4MFl4bXVSeXg0TllNdzB0NEZvUWNrYUpjamVscy85?=
 =?utf-8?B?NHhJN3FoeFdwenJlVTNrb1lmbEthTXZyd0pyVmU5OEJNbUpsQlBzL1JLU0dU?=
 =?utf-8?B?aDhDUWRqRisrTEcybVZPK3Bqa2FwZm5HL2JIM3VrbTU0MGQ4cGdVNDV2SVUr?=
 =?utf-8?B?L1RQbWNDTDh0bDEvdTdlK0FJYmJkUzNkeDRtWlFRUEw2U1FCWVZhZjZMZDMr?=
 =?utf-8?B?dktpblFYbUxGYmhvWkFnK1hFeW1ZenNPSGhvQmhNeTBVWG5IR1k4TUpIZSsr?=
 =?utf-8?B?dlRCUjFmQmtiUnUwLzNNOFFwN2ZwaUdVVEtjekE1bkVXVHNRam1CZE1BRVI2?=
 =?utf-8?B?V1BxaGJRbmRaM2o0QWR1dDZHRXhCV1Rjb2VqTVFHSG1wMjNRUFF6UnovcU5O?=
 =?utf-8?B?aFQzVG5NKzVUaXVIYis1L1RlNnFrdlZuWE5uY2pFRnRVVFFTQ3BMMzN2cVpr?=
 =?utf-8?B?QXlFMzhybXdUT0VRWmR3T0F5bUxZSy9VQ202RXFtM0haeG9vQTBKbFFuV0U4?=
 =?utf-8?B?U0NrYTBCcDB6WjNnV25HTm1nSlVFZDlObW5aWWdWN0FMY0tDZmZkc09qR3BW?=
 =?utf-8?B?aVRwRGVheXJBS3hXdVRYRXdlRVlmWTBzZ3RFTUJ3L1dDTkZrV2FVYUhNdFlq?=
 =?utf-8?B?K2gyZ2UzRHJQenhKYngwclBjVll4VG1uQk9CNys0djllWWFvVlZST1MwQjRx?=
 =?utf-8?B?S1VPMUJhZGNDUzJzMjRaMVhxNmdrMG56WTNVWGNFU3JFeXZmMmxVOUdYM0lj?=
 =?utf-8?B?Q0RXWVo0NXJDbnFEd2RBNWFIQ0QreTR3clZkaHU5THZRejZhQzlHUEJESC9u?=
 =?utf-8?B?Snc1c1FJaDlPMlFvZHFJS21JU2tWSzBOUXZEWUN0TjNDbCtYUm9DNDdRPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6597.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZzhpVUc1RVBGUkNpRVlPMkZzUUdyTGJuSldvcjIvWGhlTTEweHN6MDYrdHgy?=
 =?utf-8?B?UWRFVnlPYjE0SWZ0bm1nei9OUzFmR29GY080L0poUFh2Y0VHZ3BaM1cwV3hG?=
 =?utf-8?B?Y09xWUJqdnhlK0Y5ckR5MUF0M3lZYTR1N2ExQ0NYSWgvVm5mV1orUHF3SVdh?=
 =?utf-8?B?UXQ3WEN2VjJCU3FVZWMwWk1SWVhXbndabXMvSWpWdkowdEk3bjRISE5GbVRj?=
 =?utf-8?B?UjJOaWlqMlAyYXVZNG5CSXhSdE8vY0pzcDRiMG5rOWwvVWNSR2hIZkJKMWYx?=
 =?utf-8?B?bGdMWUJUMGR0dTUwSVRYUEFMOEhlYmNYTUhGOVZNNWZjU1JzdFhCSmlMTlE0?=
 =?utf-8?B?MzJ2MXRIVnFMMG9LR2VGTndDR0Y5QnEwQUd6MjZUMWVGa3lGZStYaFd2WWVU?=
 =?utf-8?B?Q2JIY3F2UXZINCs4T0FRNkhNUEdLbHdKVjBidVlsTjNvMkN2ZTQyUzhZTnFX?=
 =?utf-8?B?eFRYSFR6eVM3Mk92K2JYRTJwa20ybkc4NERYWDJyZnhhVzVxd2ZQaGIvZU8w?=
 =?utf-8?B?aFFEMjJNZlU3ZXhRN0R1aUZFMmdKS2hTQnlWdS9xSU92MXhYZTZMVnRPMUxn?=
 =?utf-8?B?TGJ2bFNtNXl6cGtLc0F5Um5JbG5wRXZrTGZBMTFRWFo3R1Q2bTdXYjkvR0RF?=
 =?utf-8?B?aTg5RlJNWTM3alBxK2daRVRwbm5Pb1k1M25CYURNa1BKbE92YUpCM2gxSVlx?=
 =?utf-8?B?VDY1ZFJXVGRoZWE2TTB6MXVsOUMzS2xqdDhLYm54ZlFvTDkvbENsSFRsOG1n?=
 =?utf-8?B?cnN5Ym54QnZpNnQ0Yk0wTks1NU5oWU5XTlRJUmwvWm5ZMVRSQ0NHZnErUDVT?=
 =?utf-8?B?SWl6azg2SkVJVXhLUTZJVE9FVHpMazhSVkdOS29iODFuWG9VbDl3MjUvMWlq?=
 =?utf-8?B?MlhuZHM2NjNXMHZTN3ZuRDFhUFJWY3pNTmppa01vSURXekFWNVhQR2FrMCs0?=
 =?utf-8?B?Q3RWWStIR2xhbElrV3NqRnlnMjRuR01PYnkwdm5WalFTbEZ2MDVkOXlKRjhy?=
 =?utf-8?B?REhtN2p3SzVxcjVKM0hxUUZXM0IxbVI1RkF4VmtpZkFFQUZIZGg1SVl5b2Mv?=
 =?utf-8?B?ckQ1VVZwc25jbXNPUmtEa2owWE9rdkpnZytGYytYY0t3dlR2a0tTRk5MTk1S?=
 =?utf-8?B?MWFpc1lXL0tJWXBRTHFVTWJKS1d0dU91SllXdnd5NVQ3N0xJT20zRHE0MHNZ?=
 =?utf-8?B?MTdJVnNVaVJGNVdWZm9LMnBPd0haSWhqUU4rQkVqTHRQcDFCVFpxck54bllx?=
 =?utf-8?B?NnBXdnF1RkEwa3F6ODQyZTJCejR0bW81dUNwajFRN3I5ejJodVBqZVhHakIv?=
 =?utf-8?B?VlJqbDhGQXZHckEzYTBHRUlneXdZTkN5YlRWTFBoc1VHVVFvVS9NblU3enc5?=
 =?utf-8?B?M255UXhiYnpoOFJSTmlXNFMyZnB3eE96c2dRS1RNQm1LVmdXOUNqem9Oakhk?=
 =?utf-8?B?eGNFTVpmZ3VNUTAycDZ5T2VCd2xIV0tMSG94NkJrSDJ5UlBxNmlidklVVjZU?=
 =?utf-8?B?ZnBzRERYVTAyWWQyWW9OL0ExdDh2VzJtRFovOVVMQlFzaytoczhqOVNzbWNR?=
 =?utf-8?B?bGo4RWo2U0Vod3VxY1J0QnlIeElGRyt1bktudUlIRU5Eb1ZYazk0ZVpnSitI?=
 =?utf-8?B?Y0pVSWpKQno4L0FNdXRjdDl6YlR2bXRzUnJ5aGNDSjJoU1lBSVFyc0NvSnFj?=
 =?utf-8?B?VEhZaktQT3lyaW9aOHJFdlZUUm9HVUovM25tZmg1Wk1YaEpoeUpMTWdlSnlY?=
 =?utf-8?B?MmlXMzNzMjdjeUJWTURhYVV5dzBVZUlZUkt1dTdJTVExWklxcFd1eldJREhZ?=
 =?utf-8?B?cGhFVC9WV3A1NGV1WHZ5Qi9ZZGpIM3hHcmE0YW5ZZFhQcWNKTHBZSWFOMzI3?=
 =?utf-8?B?M2REeUZhaXo2SGtJMnZLRUtvS0JranlBdkVrUjdKREdzOHJlMmFsWXVPeHV1?=
 =?utf-8?B?MnYrL0RGSW5jSnZ6SGJ2a3VuaWI2MVFiOERReEM4Y0lQczVaYnR0UVZGcE0x?=
 =?utf-8?B?TDRwVnRRVmFYbjhwOXhWNDdoSEZ0U05wY3RuNzFVTjMzZG9FenBTYnQrd3Vj?=
 =?utf-8?B?amx1TUlzTlJ2UHVwRnQ2V2dNMEF6NXh2alJkODlXQXR4bDY0Uk8xQ0FKR2VU?=
 =?utf-8?B?QXl4QmlwRVhUenRjT2N0aUpTcEFrMElGZWZ1cWJkOFJmR1JHOGZ1dmV3YzdM?=
 =?utf-8?B?SFpCQXg3RkZ2ZlBvcHdBSEo5WUFCQmlmSjNPeDBacmorQ1E4NTJiYWxoODJD?=
 =?utf-8?B?OXU3SWpEeHh1dUsrN05sWEg4VGp3PT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	5RMGdtgILsnhlNu4Fe+DM6M3sh2WyWr9bptoe/QvVyBW5p5DgTwTe+6wglU6AQ4hNHn0cZqjjFezQF8CQshcd3AJ+J5Ef0X+lqFuLX3cgbR5WmO7pYkNDrngBNGaGFIWR9LEQAgqET1nQhvj5vcJdnq1DHtT5mnwE3kZlfvnRX4KUJqeTvOuQT95yzEKx1ZPKCJCvJiAD1McDaZ3Txu1xfuvLxbCEBqsPmcCquii69rKCaO2an2taXQlLaCNaalPuR4LVZ342HzJW09yKtfGqkqXDWTpSaR7GvG897Qa9o3zAEN2v2uz3k71J+OSYHvuGSsBG8KAHvVZv4xD8m4//bIXfobqVym7/MrlC0AjL7uTIA6NAHiSQW1nR7+LU97joKs5Zv8iYP+EbLgY3yRPCF7EWLivbM31gLE2MUt3IcUmB627IU+1JZtMxJqVKe2bJ8oD9AeASiiOLaYP52tGyboJwHCI8r0+yIh6LKvS00CUblFQ5uMgoQcxJlnViHJItqbcqA+RZxcL3F4eb+LqBnxCHxcrM2k9m64GN88sdzP0kcYTuC7S2hd5276vTMXTtmvTVZdmLwz8y5SNKNef7huCLt2npofWH0uuS9VLczw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d03ae0d1-6974-408e-fba6-08dc752c71ed
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2024 22:14:53.1769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FUVDWVFiML3QRz7daYTjKdxxjDSSHjcdQfhZjYllwNw0NL+C6SV7O/W2JHC+AG653eotmSmv/nbjs27ICiMVlZY6PIiPEzNKwq9ClzBEkws=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6640
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-15_14,2024-05-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 mlxscore=0
 spamscore=0 phishscore=0 suspectscore=0 mlxlogscore=989 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405150159
X-Proofpoint-GUID: FogaO9gPDwMO7wUF07ivRXTURDj1Azzd
X-Proofpoint-ORIG-GUID: FogaO9gPDwMO7wUF07ivRXTURDj1Azzd

Jan Kara <jack@suse.cz> writes:
> On Mon 13-05-24 17:04:12, Stephen Brennan wrote:
>> Amir Goldstein <amir73il@gmail.com> writes:
>>=20
>> > On Fri, May 10, 2024 at 6:21=E2=80=AFPM Stephen Brennan
>> > <stephen.s.brennan@oracle.com> wrote:
>> >>
>> >> Hi Amir, Jan, et al,
>> >
>> > Hi Stephen,
>> >
>> >>
>> >> It's been a while since I worked with you on the patch series[1] that=
 aimed to
>> >> make __fsnotify_update_child_dentry_flags() a sleepable function. Tha=
t work got
>> >> to a point that it was close to ready, but there were some locking is=
sues which
>> >> Jan found, and the kernel test robot reported, and I didn't find myse=
lf able to
>> >> tackle them in the amount of time I had.
>> >>
>> >> But looking back on that series, I think I threw out the baby with th=
e
>> >> bathwater. While I may not have resolved the locking issues associate=
d with the
>> >> larger change, there was one patch which Amir shared, that probably r=
esolves
>> >> more than 90% of the issues that people may see. I'm sending that her=
e, since it
>> >> still applies to the latest master branch, and I think it's a very go=
od idea.
>> >>
>> >> To refresh you, the underlying issue I was trying to resolve was when
>> >> directories have many dentries (frequently, a ton of negative dentrie=
s), the
>> >> __fsnotify_update_child_dentry_flags() operation can take a while, an=
d it
>> >> happens under spinlock.
>> >>
>> >> Case #1 - if the directory has tens of millions of dentries, then you=
 could get
>> >> a soft lockup from a single call to this function. I have seen some c=
ases where
>> >> a single directory had this many dentries, but it's pretty rare.
>> >>
>> >> Case #2 - suppose you have a system with many CPUs and a busy directo=
ry. Suppose
>> >> the directory watch is removed. The caller will begin executing
>> >> __fsnotify_update_child_dentry_flags() to clear the PARENT_WATCHED fl=
ag, but in
>> >> parallel, many other CPUs could wind up in __fsnotify_parent() and de=
cide that
>> >> they, too, must call __fsnotify_update_child_dentry_flags() to clear =
the flags.
>> >> These CPUs will all spin waiting their turn, at which point they'll r=
e-do the
>> >> long (and likely, useless) call. Even if the original call only took =
a second or
>> >> two, if you have a dozen or so CPUs that end up in that call, some CP=
Us will
>> >> spin a long time.
>> >>
>> >> Amir's patch to clear PARENT_WATCHED flags lazily resolves that easil=
y. In
>> >> __fsnotify_parent(), if callers notice that the parent is no longer w=
atching,
>> >> they merely update the flags for the current dentry (not all the othe=
r
>> >> children). The __fsnotify_recalc_mask() function further avoids exces=
s calls by
>> >> only updating children if the parent started watching. This easily ha=
ndles case
>> >> #2 above. Perhaps case #1 could still cause issues, for the cases of =
truly huge
>> >> dentry counts, but we shouldn't let "perfect" get in the way of "good=
 enough" :)
>> >>
>> >
>> > The story sounds good :)
>> > Only thing I am worried about is: was case #2 tested to prove that
>> > the patch really imploves in practice and not only in theory?
>> >
>> > I am not asking that you write a test for this or even a reproducer
>> > just evidence that you collected from a case where improvement is obse=
rved
>> > and measurable.
>>=20
>> I had not done so when you sent this, but I should have done it
>> beforehand. In any case, now I have. I got my hands on a 384-CPU machine
>> and extended my negative dentry creation tool so that it can run a
>> workload in which it constantly runs "open()" followed by "close()" on
>> 1000 files in the same directory, per thread (so a total of 384,000
>> files, a large but not unreasonable amount of dentries).
>>=20
>> Then I simply run "inotifywait /path/to/dir" a few times. Without the
>> patch, softlockups are easy to reproduce. With the patch, I haven't been
>> able to get a single soft lockup.
>
> Thanks for the patch and for testing! I've added your patch to my tree (n=
ot
> for this merge window though) with a cosmetic tweak that instead of
> fsnotify_update_child_dentry_flags() we just have
> fsnotify_clear_child_dentry_flag() and fsnotify_set_children_dentry_flags=
()
> functions to make naming somewhat clearer.

Thank you Jan! I agree that change will make it clearer when reading
code and stack traces :)

-Stephen

