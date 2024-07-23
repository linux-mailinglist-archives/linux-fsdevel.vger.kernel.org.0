Return-Path: <linux-fsdevel+bounces-24120-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F6F939E98
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2024 12:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A01BB218E9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2024 10:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ECC714E2F5;
	Tue, 23 Jul 2024 10:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kGjXNrQX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bSOq1ZsD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7A513B5B9;
	Tue, 23 Jul 2024 10:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721729516; cv=fail; b=XSVI2B4i3lCfxHGgo0W6Z2ZKMudK9ob/yoBmnOPqzKr8wiN09iDTAI26IdVFUmS7FvHxU9XkWcSSFQmqbBj0hyAgUDbUxGyqn0QNqsws1xMb7/jT+isJISFJeo9G0A7fbbKKZl5MXn4Awl9s6Wvbk4gmdcAQaB6dvuaTOU6O2Fc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721729516; c=relaxed/simple;
	bh=8q2+ymkVX4ojEwQPLfhy+IxkXzNxKW/HEhXiVq9Vn0c=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YaDbx4v6N9M8wEVMawy8MDVILSyp2yOqEhE7Fra0nELqA/dUJ35P95c0pIY27mmZ0ReYjaxtYt9WXLmtsgXW0VcvzTu13+QyVVQkXXWIN9n/6td9eBaZzKZXoD+d+n7ZdNvoNk06J8Hg0XA1cDZEdAPxfrbxN+a8JHY7yCUD9xs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kGjXNrQX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bSOq1ZsD; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46N6BWK0001354;
	Tue, 23 Jul 2024 10:11:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:from:to:cc:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=ogFbkZGd5PWjEe9DEqSWNmZBaLpWB6g7uMkSxCjBjX0=; b=
	kGjXNrQXYCjnb01XSEZwMi6653BYNUKDzH91sQRAeC4sLjRfXwDqcOK38q1766s0
	XMHaYfNGwFSBQSWE2EYev/06p7qQC5/8zMvDc/R6QJ/T+kNO8rgS9ibhcHNOifGQ
	7XTsGN66gm7oM8W+/KgGVoz8wDdZ6c1B/42nkynLoUcTMY2ug0AKRvfwtgq7caFC
	efLBKz3AbbWCq47jiJnSh5FUPVHBkHYabPf46ogX/ITQDOpin5Oa546CFGnU3Ucs
	Lb24XJCExWBRtCYH6p93ECu4w1rdlC/I1OowgGploX6BHcA03vQrmB8CA7Pgn6Tp
	ILj0IBX9c+oDhmrM9JCbgg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40hft0e2mk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jul 2024 10:11:37 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46N9Vwv8040153;
	Tue, 23 Jul 2024 10:11:35 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2046.outbound.protection.outlook.com [104.47.70.46])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40h26m7sqv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jul 2024 10:11:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hVqrtrXyK0KntuZo5gGe/79a3bQbWQSiUgs623bBILRQwqVCOTkbLhe9jmPWtH7q6+WbH8fGFtma8AaiG9HTBSSk5o17DpA1rp/BeP5CtLf/soMIEl8Jjj6caTcl8M/6FFsMKlxfT9/S027uqZb0IxHyVyBU+E9gHfKl9gcThJ/2GfnlQHs5vGfXCSvCWlIlWqiKMDWOpxsHb1gEEDi3Vz4qF/6rjkwd0b7swCqioWTe6ls9bypp0hxDpstkCHmx03jo4G4HClVJiZ+Erm8NeePwL5uhQQopTunHM1cqypZ8QAKxxLIz8W978SjZ94wd2jNRlnjDzhkfbxv5JHpZUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ogFbkZGd5PWjEe9DEqSWNmZBaLpWB6g7uMkSxCjBjX0=;
 b=XNPV1xzNEBLl5s8F29P6p9gSegEzed/Kjx0cK+pgWFYFNiJT1pfUOIu6DZZxxuzmDgeROdxtgng4/vYCQbSFmO2sPDM8GEdnVlHKsc+OzhIDyIihu9/TIXoxc8GVVnnPPhUa+Fo8kMyvWvaRvB5YqfobzeLpw3cR7AH4GHHWjc+SvYTRFl0nBaU+3GBBb62BAiWlqFNAhnjz7pI1gMbQBzT3UJQSZVWS37VtJWX7a+cSQ7Yl16E01JgWhzDOufBrBlgak3BETkIrdWTGUy4E6fBJNQHGvYWV7QT0u6Asv0SGlaTpuV6l9KuGF9WbYHv5jjY+Y0H20h3GiGkw6eKIAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ogFbkZGd5PWjEe9DEqSWNmZBaLpWB6g7uMkSxCjBjX0=;
 b=bSOq1ZsDi+Q6MIJQz5GQykzzMpcP6zy0oBZU9/z/oo2WHeymRZchGtjtZ+2nwy4fO1zzaB8Aa0T9X/0dqWv6YspjJSTR01HWT1UMUPoEgrK3jgomTabUGSZISFGByFR9qSSItUuWlKr4mfZZD+anwERXxY5s3ywqejzfPIV5uMo=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS0PR10MB8199.namprd10.prod.outlook.com (2603:10b6:8:1fe::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Tue, 23 Jul
 2024 10:11:33 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7762.027; Tue, 23 Jul 2024
 10:11:33 +0000
Message-ID: <bdad6bae-3baf-41de-9359-39024dba3268@oracle.com>
Date: Tue, 23 Jul 2024 11:11:28 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/13] xfs: Introduce FORCEALIGN inode flag
From: John Garry <john.g.garry@oracle.com>
To: Dave Chinner <david@fromorbit.com>, "Darrick J. Wong" <djwong@kernel.org>
Cc: chandan.babu@oracle.com, dchinner@redhat.com, hch@lst.de,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
        martin.petersen@oracle.com
References: <20240705162450.3481169-1-john.g.garry@oracle.com>
 <20240705162450.3481169-8-john.g.garry@oracle.com>
 <20240711025958.GJ612460@frogsfrogsfrogs>
 <ZpBouoiUpMgZtqMk@dread.disaster.area>
 <0c502dd9-7108-4d5f-9337-16b3c0952c04@oracle.com>
Content-Language: en-US
Organization: Oracle Corporation
In-Reply-To: <0c502dd9-7108-4d5f-9337-16b3c0952c04@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0159.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:188::20) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS0PR10MB8199:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fa847fb-d0ef-49e2-1be7-08dcaaffd43b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TkY0N3NxWjJxNlQzSjkzL05aK3Y2cEl2NHJGbGx1aFFVZXNkV0VTcG5uaW9R?=
 =?utf-8?B?MUp2V2VXaXBad0FHdnVNUkZzaDQrbm5Fd21sYVJNUFQ1RVUrZyt0a25OVFMw?=
 =?utf-8?B?ejJNL2VLVm92eWNQQTc2VWE5TVoyb2hmckZVR0NISWxxbE9kdVJ6a04yZkg5?=
 =?utf-8?B?NEhTb3dKVVhkNzVhZ3BIblNROW4vRmhKN0JCTEhxam04cm5uNmNNVXJFSU16?=
 =?utf-8?B?cGN2RFhDbnd2a3BvNlFrVDJZMjgwdE9kTW1zaUgvZzVZR2FxZktJc0VycUxL?=
 =?utf-8?B?czF2Y1prM1ZsRWlacTJyanY2KzJBSnBia2EyVlVhYXRwOGxHV1dxTHFrVUNF?=
 =?utf-8?B?VVY0WS9xQkRQaHZ0U2JXZFlzR0RrTnE1ajVYaHVkZjVsK1RTdjlrTjV3UVA1?=
 =?utf-8?B?M0VmNW9CZXJDSXJhTDF1NVBidmVBOHFmcHl5NDUzc1oxZmZQaHZMVXZKZU5Y?=
 =?utf-8?B?cW0wdnlMN2xYcG5vUnlITVNmV0J5S2huYjVkWS9qMGxJbnhxK01reXpqKzRw?=
 =?utf-8?B?VXE2ejZpNmxoSnRTdE5teHh3djV3eEhpR0gxOEdseTFHWkthK0Urc2N2L002?=
 =?utf-8?B?UWN0cnhhWnlGNmRoMlEzTHhSazNScngzSjFBZVgxLzRrZmhkRmpwVzJ6QVI1?=
 =?utf-8?B?MWtSbGRFbW1yejRQSHR1YWliYnhHSEQ2NjNlVk80UStUMHgxQ0txY2htMnM1?=
 =?utf-8?B?YVhCMEhEdEZ1RENqblVrWEgvdFUyUlZBbnIydkR1dmVRcnd4Szh3Q1VINWZi?=
 =?utf-8?B?VDZ3YTJaN1F3TmFCV21BK0tPVXRYMVRMc3F0WTY3c1pUNnBjU1NLcUxyVkds?=
 =?utf-8?B?Tk90Z2gxdjE0NUtrWnIrRHBvcVpCa1NqRlhQRC9pRi9zdUhoYVF0UVFXekhK?=
 =?utf-8?B?TEhCaVhRMERyRGZhOGV0RFVaZjVqYTR2ZGltTU1nbzdTSnljT0JTVU9oTEVx?=
 =?utf-8?B?bldlbkdqWVE4ZGc4eU02T1J2VlZpMkRZeXJ5dDJWeDNqWFFwZVEzdE9PeUhS?=
 =?utf-8?B?eEJERXZYcVl1SmQ2Njhja1VkMDVQck02ZExDNmoyczBldzlCZDBLWHVRQXRQ?=
 =?utf-8?B?RmVhMTdZTHBHTUprYllFSGVOYnk2L2hYZ1p3WVFKVGU0MXdvZVNiU3lMN0I3?=
 =?utf-8?B?WURGTFJoaWxoQk5UZEt2Q3RwbmdCa21CaWRrMUhwWnk1SzNjZWdySUI2TDRa?=
 =?utf-8?B?VzE0OFlVQ2JsNXFKSm1uaDJMVjd1MU5uN3IrV01UWmRUeDlrSWlKejU0a2FC?=
 =?utf-8?B?MkxMYis2NUFjWDRvVkZZQkNOZE0wdm1iYmVYTUJrcW4zRnJUTlBreEswODZ1?=
 =?utf-8?B?NGVUd2J1VU9VZFQyZnRSa3FseGxGeFluTjVDbHBEQzdPTjlDZWJia0Q3OFNu?=
 =?utf-8?B?UXNrL2lUczhYcjJkdXBYUWFSWHJOb0Vsd29VUmxkK010b21kRHpDcGlRbmxx?=
 =?utf-8?B?VXRYKzFhQ25jVE9lYTdMVEljaWIrNFkzbGZtL3pCN3FEYS9acFg2M2NNc0dj?=
 =?utf-8?B?ZFBBSjR0MitBZnR3c3BYczBacFF3SE9FbDBtRlM0dXJWNjhiT3FiczJyblRv?=
 =?utf-8?B?UHgzSXlJc2tvVURyRUVZd2hNejA4TWlXWkdqVHVJWjl6T3Z3MWlFZnNoblQx?=
 =?utf-8?B?SjIzM3VqaTBYOG1VeXVyaFU2YVRYRkVGcWxRWjBtZTZtVWptWHBHb3RrTTB2?=
 =?utf-8?B?V1VVNUFwSnlnWG15OVFNMWJ3bEhQRWJuaUFRYU1qVjMvZC95ZXFicW9aWmpM?=
 =?utf-8?B?RTd0QW1WdVJmVUVaSTZwbVR2ckx3dC84VTU0cTlTbnlrVW1jNkdWWTN6MFhO?=
 =?utf-8?B?a0JuTDkwbGJDU01CWTkrdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y1ZnSGFldGEwam1zeGlBODZFVkExL0RWT1VJVzQxejNBNmRVRzM2Y280d2Zm?=
 =?utf-8?B?Mm50SmJZcFo1RDRSMzJXV3FhRjFVQURsOHdOQThJeTVpZTNjdjNjZWpZRUZi?=
 =?utf-8?B?aWZ3QWR2bWZDM3ArMStLQlpocjE4THBHYkxYUlFVNklObHVzaTRxZWY1dm1w?=
 =?utf-8?B?aTg0RzdjNmNDS1FhOTdhYnE1S3g3RkVkL1dtdmVyWW5zR2dsV3RBQXpoY3FU?=
 =?utf-8?B?VEFSaEtRV2dhaUNqRWlIVEN5OWdNci9IK2V2Y1BTZUZEN0VPUnpXRG54Witp?=
 =?utf-8?B?K1FRUnFuWDhkbUpvY2w0Sk1CWlVxejFsWldFREZvK3RSWkx0dFNHd1MwL1ow?=
 =?utf-8?B?Mk1pcTl4NmREUU5nWjRuM2VBYi9CUGZMNndLbzk5QkVtSlY0ZEpWSXRveWk0?=
 =?utf-8?B?WXRSV2RzMExFL2FIREFmV2FqRHNKNlo5dTJTR1AvbDV5NXVNRitVUnAwSDRM?=
 =?utf-8?B?Z2phWDhUZ3ZhQzlVcTJkRHBZTkVkb0pxVm5xcnU4cnZtWG40eEJSejVJUGVI?=
 =?utf-8?B?R3EyYnBTa1J2RE53dkJ2a3l3cmphRHRwUmYvdlRjYWNBT3ZtV25pNnZxVHlp?=
 =?utf-8?B?bnd5TGVBRDMveUNUcWZzdFgxa3puRzNhc2RsVUx4OGZHL0t1YnBwZ0haSkZL?=
 =?utf-8?B?VGtiK3krK01YU2ZoQ2V3NXl6N1ZCVDZlcEdyMndXSm5QcktKUU9WL1c1cW1P?=
 =?utf-8?B?dy9WL2pWTnkwUlN6MTNVdHpGcmtPVmM1VDNvU2NUWmpOTTFHa1pCeU4rbFhn?=
 =?utf-8?B?dnlNcTE5SXBJTjBabXhEcm1lUTRNS2xOUHY4bWR5Y3RCbUMvVFFQT2tWQTNM?=
 =?utf-8?B?dmlMSHJnUE9QSFNRQTJVVVhVUVVhZnRjRG01NUZ6cXRQbUo4WmJQSW1UbmJk?=
 =?utf-8?B?bDZhR0twWjRWZlpPdHd6YnZvakRXN2JDWmVkNkhUaDFobHh0U09TQ3ZTSy9s?=
 =?utf-8?B?NVFRL3I2YW9KdC9FVkUrZmtTQ0x6azd4dHFiWUUxdTlEb01iRmpRTlRxNnZi?=
 =?utf-8?B?ME9Eb2U1R3QzYnRCK2hka0lGdWRoRW1UOFRicm1NMTFKVlRmV2FGUU1Hc1I5?=
 =?utf-8?B?R0N3aDRkNmlGSGNRSk9HQ255OXV3RDhlOVgxYjdHUVdIWWZJQVN3MWtuN3Fy?=
 =?utf-8?B?aHBhTjBpOUkrM3pSUCtBK1lIQkhXSWhaeDJDdGFSQ0JHSVFrZjV0MGljb3di?=
 =?utf-8?B?N25wemZNbUt5S2VaQlhiWHZPQmk2bW9LaWlJUkw3cFdyVE9oWHgvaG1ueTM3?=
 =?utf-8?B?MU9aVGZYaDFGVGoyaEF2V1ZMSnhGTUlOYmlLbXpZMjhQZnVkUnpaZXhtRDI3?=
 =?utf-8?B?SnJBS1JBTGh5VStSRjJhTzBTVUt1MEFaT3Bja3JYbkVhR0JkZkIrOUZVL3Fs?=
 =?utf-8?B?NDU1TWZoT0N5UCtaOHduTmxPNTlOR3RHNW9VNk5OSTdwLythV2NOMVFjK05D?=
 =?utf-8?B?MllNUnR1TWQ5UDErL0toeWtiR3ZSeVVkQlEwbTJBTUNZS3V3RUdOV2RSWEZj?=
 =?utf-8?B?T0gxSTlKb1VOZXU4eERhTzNhanhBNllnc0RpcjA2cmhkcnBTZFpVVDl4ZVA3?=
 =?utf-8?B?TjJsVnpyK2VFc0ZMZ1VQNUFhTmRjZFppRXpsTlR1Zy9ObTlKU1pxSVcrc0tQ?=
 =?utf-8?B?Rk5OZVB2K0NNVDloT1c5c092RjUwb1RHMm9hTHArSndsWDZ2ckxvRFV3bG5m?=
 =?utf-8?B?TFJiOW4zazBXS2d6U2czL0Qxc0tRSmxJalhhZ2F0TGFUT2ZmdmdRUHJTVFJN?=
 =?utf-8?B?ZTVScW5EdE51UGl2VzB3ektJTldXdTlMU2pVd3Y5L00rcFRwN3FBWEs0R2JC?=
 =?utf-8?B?UWg3QkM5Q0RmU0tPaEVWM20rNVBCSFZzZC93QzZ2VXdNSGxyT3R0dkIzZTZZ?=
 =?utf-8?B?MnQ5dWxiQWNkKytNM3BzR3QyL09oN3RiMkZTVU05b091Mnh1QjhyQW11bzNC?=
 =?utf-8?B?aWwyQ0ZoQkprMGpLRDFYa1h3dUt3M3NaR29HT3dVem5kNkZOeDJabVpiaXpX?=
 =?utf-8?B?VWpYYXVERWx0UCt4OUYyNXdmZUxXeFJRcjhsV1p6VnZ4blNPL0IzQTcxY2xm?=
 =?utf-8?B?K0lnZnlkQVJsVHpNL2o1VDdsdURyeCt5Z1VZblZFQnYvUkFEUGQrM1crRVFG?=
 =?utf-8?Q?StIP/BzRdYYNjFqB1ccRZwx7t?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FK0VHiD3xdNDcHR6BRauWRUFbdDYsCqAwOBPWFjnpQxmBivG+hmD6AGDQ9B4qHNbzJQiitxOUNi9DhAjfwpktV00PNTDlKh8mKmmhBMSrcec9Hpb4QKfYkvk1TU51dwKIGH1jOLF6w0ODqoB1hKg/mEK+cggxKHjSqzbCnl9ipoTvgVk2pupmV4YrGejbTz63hysXQiGaMJ3SSoq5FODgU0lGbTQAzoG009lgyQgQf6YEH/mv3dfzQ5uKjoo2xB9t7aWylq46mFX8U2heQYPiVJ2B4aNP2HkmoD9O34Zl9BImCxEGoMwrr85DpPmOyKXrZrmHY0IhhA61vM66131wb7Qgzx+/dQWd6HVg41zjmLTthwlvDe56vtpbRYs+k/5Lq86pF4Sy+JgnTAZEdlbuGOkachFTzu5DzsY2+iShPahz3NSJZHl0Ww+22S4vLjtMSVoOq3TU0Mk1yNSrMcTDn91KJ5wWlOJ1aKQ/5ZAFmxuHMtmyJPYiXX/cWTNwSUfgHndBvFO5TwZXpYZAOYhnLl+/M/q24NeGByoygNWhm+HaebBEb21LUk299TEco//sNuUClXwjqaciSj5wxYgBwJz9HPm5Ty5o3ilqLGgTHc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fa847fb-d0ef-49e2-1be7-08dcaaffd43b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2024 10:11:33.5742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6yh3bS8KwImbKUzRLcgsS5Zit/NieHyt0FtgisOeqWwdLmxyMDZ1g5QAHJZ3H7Qkcg7Ip/X3jfPtcHNUTXUtmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8199
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_18,2024-07-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407230075
X-Proofpoint-GUID: tAEiJK5MVm9K4BZ8iIxei_7BwxVAvazO
X-Proofpoint-ORIG-GUID: tAEiJK5MVm9K4BZ8iIxei_7BwxVAvazO

On 18/07/2024 09:53, John Garry wrote:
> On 12/07/2024 00:20, Dave Chinner wrote:
>>>> /* Reflink'ed disallowed */
>>>> +    if (flags2 & XFS_DIFLAG2_REFLINK)
>>>> +        return __this_address;
>>> Hmm.  If we don't support reflink + forcealign ATM, then shouldn't the
>>> superblock verifier or xfs_fs_fill_super fail the mount so that old
>>> kernels won't abruptly emit EFSCORRUPTED errors if a future kernel adds
>>> support for forcealign'd cow and starts writing out files with both
>>> iflags set?
>> I don't think we should error out the mount because reflink and
>> forcealign are enabled - that's going to be the common configuration
>> for every user of forcealign, right? I also don't think we should
>> throw a corruption error if both flags are set, either.
>>
>> We're making an initial*implementation choice*  not to implement the
>> two features on the same inode at the same time. We are not making a
>> an on-disk format design decision that says "these two on-disk flags
>> are incompatible".
>>
>> IOWs, if both are set on a current kernel, it's not corruption but a
>> more recent kernel that supports both flags has modified this inode.
>> Put simply, we have detected a ro-compat situation for this specific
>> inode.
>>
>> Looking at it as a ro-compat situation rather then corruption,
>> what I would suggest we do is this:
>>
>> 1. Warn at mount that reflink+force align inodes will be treated
>> as ro-compat inodes. i.e. read-only.

I am looking at something like this to implement read-only for those inodes:

diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 07f736c42460..444a44ccc11c 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -1132,6 +1132,17 @@ xfs_vn_tmpfile(
  	return finish_open_simple(file, err);
  }

+static int xfs_permission(struct mnt_idmap *d, struct inode *inode, int 
mask)
+{
+	struct xfs_inode	*ip = XFS_I(inode);
+
+	if (mask & MAY_WRITE) {
+		if (xfs_is_reflink_inode(ip) && xfs_inode_has_forcealign(ip))
+			return -EACCES;
+	}
+	return generic_permission(d, inode, mask);
+}
+
  static const struct inode_operations xfs_inode_operations = {
  	.get_inode_acl		= xfs_get_acl,
  	.set_acl		= xfs_set_acl,
@@ -1142,6 +1153,7 @@ static const struct inode_operations 
xfs_inode_operations = {
  	.update_time		= xfs_vn_update_time,
  	.fileattr_get		= xfs_fileattr_get,
  	.fileattr_set		= xfs_fileattr_set,
+	.permission		= xfs_permission,
  };

Or how else could this be done? I guess that we have something else in 
the xfs code to implement the equivalent of this, but I did not find it.

>>
>> 2. prevent forcealign from being set if the shared extent flag is
>> set on the inode.

This is just XFS_DIFLAG2_REFLINK flag, right?

>>
>> 3. prevent shared extents from being created if the force align flag
>> is set (i.e. ->remap_file_range() and anything else that relies on
>> shared extents will fail on forcealign inodes).

In this series version I extend the RT check in xfs_reflink_remap_prep() 
to cover forcealign - is that good enough?

>>
>> 4. if we read an inode with both set, we emit a warning and force
>> the inode to be read only so we don't screw up the force alignment
>> of the file (i.e. that inode operates in ro-compat mode.)
>>
>> #1 is the mount time warning of potential ro-compat behaviour.
>>
>> #2 and #3 prevent both from getting set on existing kernels.
>>
>> #4 is the ro-compat behaviour that would occur from taking a
>> filesystem that ran on a newer kernel that supports force-align+COW.
>> This avoids corruption shutdowns and modifications that would screw
>> up the alignment of the shared and COW'd extents.
>>
> 
> This seems fine for dealing with forcealign and reflink.
> 
> So what about forcealign and RT?

Any opinion on this?

> 
> We want to support this config in future, but the current implementation 
> will not support it.
> 
> In this v2 series, I just disallow a mount for forcealign and RT, 
> similar to reflink and RT together.
> 
> Furthermore, I am also saying here that still forcealign and RT bits set 
> is a valid inode on-disk format and we just have to enforce a 
> sb_rextsize to extsize relationship:
> 
> xfs_inode_validate_forcealign(
>      struct xfs_mount    *mp,
>      uint32_t        extsize,
>      uint32_t        cowextsize,
>      uint16_t        mode,
>      uint16_t        flags,
>      uint64_t        flags2)
> {
>      bool            rt =  flags & XFS_DIFLAG_REALTIME;
> ...
> 
> 
>      /* extsize must be a multiple of sb_rextsize for RT */
>      if (rt && mp->m_sb.sb_rextsize && extsize % mp->m_sb.sb_rextsize)
>          return __this_address;

And this? If not, I'll just send v3 with this code as-is.

> 
>      return NULL;
> }
> 


