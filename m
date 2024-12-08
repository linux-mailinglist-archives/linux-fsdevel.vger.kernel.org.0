Return-Path: <linux-fsdevel+bounces-36709-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 911299E86F9
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Dec 2024 18:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A5B5281540
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Dec 2024 17:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F0621865E5;
	Sun,  8 Dec 2024 17:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="miI+Lv3f";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JZVGf3+y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F6414658C
	for <linux-fsdevel@vger.kernel.org>; Sun,  8 Dec 2024 17:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733677935; cv=fail; b=DmWqQF3WeyNOLLIJ4WhLzxKGsQF+OS39NGF65+/mvkiUggoPZDAzHStY6Zn2eGgbecLSJd+xEcaML5qcYpFV5UrE+dVUtYbMxJnDMbB0ihyCjlLVsAoIaBlImb1Z7ymJXW4K+z3N4h4pvimE5A8bmXiN4cgc00FXPZBBrEN9E90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733677935; c=relaxed/simple;
	bh=A2CAkCwCT/8Cb+NpR4BW36Nta94iFW1bAHop9OWwN6Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Z419r2vaEBhF8yWYk/YPdqr0lukfxzR5J5z6/XiXAFPKC7gonRnwTsXEwcujTg1ngRMH04ZpyexblzVrvaf4NkxI4La6x4nVY5Xf43yN1ImY+yogpHpASoEAtWk2M2wWN8vCFeR7p0xV/Cqp3alpD+HjXcjSnfivHcnS5985rPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=miI+Lv3f; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JZVGf3+y; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B8Cq3q2024333;
	Sun, 8 Dec 2024 17:11:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=1q9G1rLJogjP1kB4RqDzgqfNQ7MTBQp2Lzkrz8GbRRc=; b=
	miI+Lv3fcj/A7+iy6tGMxdeAKJrzigPiSxHvZtOX5JNbOBngZ/N9DKal6KQxwgKp
	LXIMjge8kMW00K6+JQe0u0m9UnA6CL6XD0jMBltBMissqbTp9PYr0CBeqeaTiTz2
	9T0x2xRUpL9eNYf7HN4PUcaxgSJs9vSd72GngRL/LZd7h21yF7ZFD936OXrFd+BG
	A/s63glAZ24bvlMHlbmnaeJUmYPvX2gMDhU1NkjfB2sYy2n/p7G/TUh75EjzTu57
	m3eeosJdqbXDQ+IvdAdL2jVCbwW4q74HBg5Q1XghPVBba561qZSk39/p6Vr0Dk57
	ksisJzFOfjEt7qN+ZPTFeA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43cewt1w8g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 08 Dec 2024 17:11:35 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B8CnE65009456;
	Sun, 8 Dec 2024 17:11:34 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2042.outbound.protection.outlook.com [104.47.73.42])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43cct68y8x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 08 Dec 2024 17:11:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JaIb6tmsfJiblKlJ3kFrOigvBIg96qgADTmv7J2zq+40SQUfYkcddNw79u2MoO+Ow0AbUnnODRmoJejehSlcQgW/KUqaoXAkzo/xi5NCuhba7RT4UrIamN7s7X8S3n9Bt3XmPACZpbe/LknaHlFf5aeSzVdDzOHfGhhwjt+ShU1zVJcbLP7P4xNjvAeRo3XfRqUZR3e+fqKz2p9O6As1r2aagq32kw5wSHe0sbmvDPpOZcvK1lGOKIIWQsJCcGi38iyIJSHAh0wWLdt5xUu4aCueGiTcu6b5eGaLbRaejuY9s4JAM7BS4fsxLkxlUyPsXVqlsGMyzoZ21PsZUbhBVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1q9G1rLJogjP1kB4RqDzgqfNQ7MTBQp2Lzkrz8GbRRc=;
 b=P/V6n4xATiT4nsn0ts3KIFQbJ5J+aZG0jxSjnL1t1XiBjUN5qDgJCcIZynb7KMaB+Wd1pURQZ1GsAJQMrqESx3WuDfccySPNLArWZDG/GsvU4IsxmT9sGDcZAaRWSyjj+1LIevXPQmCWTUYWsVvkY3mxuK3AvvAma0ZVCmwLpTslsrO93BzN+cmjSyueMOc8dlaqHETLLtlmIBgAeZRyJLz1Mj9VsaqBLNCVO8XtHAYSMdU/yxDE8dfK755p7P0O1KMFQUgcnTzFnKtLt+Cln5lHXBSjmb3hsT50dDZcO1U/VXDMl5QjfAC4+FpuyL1IcvBId3Zka0Q9J6x16blcxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1q9G1rLJogjP1kB4RqDzgqfNQ7MTBQp2Lzkrz8GbRRc=;
 b=JZVGf3+yUqypbkZXfb0wnp63jpYI4UcGyQ2hcCwJYPVQRTKLLY9AN/rR6o6N09dWZDRqFhSfEEQIGqbuMDNxUvC1UdMHp2O6a2N1HjONzmYMm8r173bNm5Vs7M3GwhnVYTtAFxoIBAdeglcTMQJCFkvvFhoM7gBXHFOKmjLLNvA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB7152.namprd10.prod.outlook.com (2603:10b6:8:f1::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.18; Sun, 8 Dec 2024 17:11:31 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%7]) with mapi id 15.20.8230.016; Sun, 8 Dec 2024
 17:11:30 +0000
Message-ID: <5eb7bbdb-0928-4c80-bf03-9de27d6f3f89@oracle.com>
Date: Sun, 8 Dec 2024 12:11:29 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/5] libfs: Use d_children list to iterate
 simple_offset directories
To: cel@kernel.org, Hugh Dickens <hughd@google.com>,
        Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, yukuai3@huawei.com,
        yangerkun@huaweicloud.com
References: <20241204155257.1110338-1-cel@kernel.org>
 <20241204155257.1110338-6-cel@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20241204155257.1110338-6-cel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0011.namprd03.prod.outlook.com
 (2603:10b6:610:b0::16) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS0PR10MB7152:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e278cb9-4d17-465a-89f0-08dd17ab5c11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dU1wRm54czk4aE1saGtKSTIxSGxkd0xTblprcHFUMEZIdFpFalRMbDdEcUNa?=
 =?utf-8?B?SWk0bnFER2FSSW5tdTlDcSs4b0J3WkxZTGVmTXJaanlKN3NxaWh3ck45TWNT?=
 =?utf-8?B?ZGxXMzNhK2U3ZGJ0ZDc2ZC95M0dMSHdncDhObkw3ZEhFcXF2U1p5QUEwOE8r?=
 =?utf-8?B?U2kwcnJlQmxIZ0tPMi9mM01mUzJBSkFvei9ycDV2bERQdnREYllYWTNYcUdM?=
 =?utf-8?B?enFpZ01pZXlJYThLbFNHdkc2MDVySFhybUVLVEZ1WkJhQ0IxQk5vcDlxUk5B?=
 =?utf-8?B?LzJ3NFpEaE9sNnZRcHlDdkZVa0ViOTlzTGE2WmQzMk9ZY0tIOEQ3VDZUUzJQ?=
 =?utf-8?B?L0tQQ2xMcWxBQnp2YVgvN2trUmZJclE2ZHplcEtwMXZSV3d1UkJvdmg1dVJa?=
 =?utf-8?B?MHJ6QzFVTVZ2REJpZFZ1dVpkZUFEWEkvNWZIcktJaFBITHJHdlFxR2VHOHNC?=
 =?utf-8?B?MFVQTXAyS3BtNDRNTVdkd1h0RkRxWEpFbmZPUXQxZnd3ZC9FQXRuWXdxZ3Ix?=
 =?utf-8?B?bk1QQVByYzBidXp3aHhHZ3lZcWNQNk5NT2tnNk1jcFI3ZjVIamcyMkRqSGNr?=
 =?utf-8?B?c2t3QUNZcjUrVnpHWmszODEyeEI4NWJTVS82alYrWHg3MVBkQUJBU0NNbW9U?=
 =?utf-8?B?bndCT2V6ZnNhTVU3Z0I5ZTdoRURXcUh2RzZVTlZ1THlSTTVqY0sxdWczOCtN?=
 =?utf-8?B?dVdBZDFsL2NsWFNUUTJYOXFXdUZDU05MNzBaL1ZDOTFLSTUyTWpnMFFwWi9S?=
 =?utf-8?B?S1lyMzlvNXlDTVRvTFM3bEdJUFR6VWUwM2Rta2RjL2RrelVVdHYyVzJaMHpH?=
 =?utf-8?B?SER4RDlqeEpGRVQ2dWdKUFVsWkpaUHFtQVdWbUg4eWhpaDRmSmVTeExNMEU2?=
 =?utf-8?B?bE85R085M3IwTmNNQ0s1VE1iSGVXejE3aHR3WGcrNm5nRElSWU5CbzdtRW1J?=
 =?utf-8?B?c1JwUVI4eVNwSFNuNHBrNmNIT3NmSjFlZzdncG5nSXN2elc3RlpHU0lKS0pq?=
 =?utf-8?B?L01rV2lTRGZlOTdlQmNYUHRFUFZZS3FlVUpyNzVGamh5djhXQ3JyV2FDNnNP?=
 =?utf-8?B?aXFWTW12TTRLbDlJQU5DbFVNZXhYTUhUNWN1TURva1BwSzFZNWdQT1FYNlA4?=
 =?utf-8?B?dTZMWDlNbnExakNlVXpZVmplVUpXWGJad3ptbHNHNmdydDdiOVVOT2RRWi9u?=
 =?utf-8?B?Nm5iK2trZEJIUkN0ZTJBQ1F4T2xLRmxHZUNOVGtZaEwwTFM5N1ZFVHpwRjJx?=
 =?utf-8?B?NnFSUGtLNm1EMHdrdVAveUJKSzdaZFF5T3JVRnU2a28zalNibnhMNllubmp6?=
 =?utf-8?B?djNVNzIwRGk2RDI4NDI1MlVEUXAxT0xFM2FXa05halMwbHdmQUFQL3VUdjF1?=
 =?utf-8?B?RzhHUFYwVEVFeW9MakptVlc0TlFFdEcvT0FNZDQ2YWNSbjg1bE9uVFZsenJa?=
 =?utf-8?B?MU9BNTNOZU5qcVBsVEkzcmZUd1MzaVoydkVlYVU5bVpGeVZSYzBrOVBrNXJj?=
 =?utf-8?B?SlJlK3JFS2pTeDZRNEFDN1lxclk5R05lYXNIemF0TXJxcjNrL1ZGb3NFQ2d6?=
 =?utf-8?B?eFZlNExpOE5vaktONDNYaU54QytjL0tTT2V1MHdvNDFWdnFwK2lHV2dZNDNy?=
 =?utf-8?B?T3dPOSs1YmFYYzBleDRTbE5HZ2tSeDJkbkxmdTNiUHNpVmtJdGJUL3J4MFd6?=
 =?utf-8?B?Tm5VQXl1bTZVUmd0TGpoTkNzRXVLRlVMWnVyK29sMnBCVEptdUlqZlJHaWdG?=
 =?utf-8?B?UnlEb1ZETy9VNnRRbmpQWk1hMmplMkpwMSt2b1R2WHd6b3ZtdGR0ZW5LVjBo?=
 =?utf-8?B?ODBnNVJLL2VOcVVva0xZZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZjZvVjdEMDdEbUdFSVhVSk1IRGZ1RG8ySVlCVElkbWJOOExhV2xhOWdDREZE?=
 =?utf-8?B?NGF2clg1dEgxd25qYnE1ZE10V2djcFZ2MEJIU21idjlNR3psYWlEc3dEMElB?=
 =?utf-8?B?T25ubzYvVTNXVXN5U0ZXUU4rYnY5SDBISmNrTmlHZ2V3M1JEUVJ1dnkxWHVH?=
 =?utf-8?B?MlVMV1Q4b3Zxc3l6Y2ppWWU5TnNzWHZCQkFLY1BMS0RvZzlkN2pseTJueXF2?=
 =?utf-8?B?M1d0QTdDNmtTT0Z0bndWc1BORUU5TWdBVDM5eDRTa3JkT1FKSUx4VUlad3ZF?=
 =?utf-8?B?dGR4STVvUTljcjM0SEszbDlSNmpuaCs5MnAxRFg0TGNIcVdGbEVrM0J3V2Fr?=
 =?utf-8?B?bThuNDJNTXVQc2NUY0tIUWJGcVJzZ0gwU0RiMlg3T0VzWUN4R0NoNXArb3lh?=
 =?utf-8?B?aDkwVk5NZGU2SHBxUU14aXk3RmtTa3VQWnJtMGZhaXFHRy9oc21DakpJU1p2?=
 =?utf-8?B?TXMwR1hndkhXZGNscVlGUDh0dm5QQndPS2J5SXZxanhTVW5HeXFqUVRzOWl5?=
 =?utf-8?B?WkNCQ1lYZTJQNmhmVjN6RlQyWXkyNnRtd2JNakw0bmdTRlRWcy9pZStXeks0?=
 =?utf-8?B?SXo4Y2JGRHc5d0lUWVlaNGxGQ2YzdkFQWkZkMEcxTTlLbURoNzVGUTI0a05D?=
 =?utf-8?B?MlBpdFVQZTR2ZHFzdmZlOHVSZmlrQnBsM3RIZGZQSFNhdTQveXF0bXpqbzJW?=
 =?utf-8?B?aVBvSVpQbE91V0VOYzM5Z1UxTFhkZkhFYnhYSE9MZU9oakpkQ29veFdScFB0?=
 =?utf-8?B?Z0YxSEpKNkpEcE5vYmIwUU1pSlE2ZDd0YmhtVWRLWCtyVSttdmJLV093Tjll?=
 =?utf-8?B?bCtyRG00TzRLbGdMazBQTW5vbUJ5TVE5VlVjbm50YVgza0crOFVTZHpwWkhD?=
 =?utf-8?B?aFgzWDJVM0VuL1BlSFI2eWZ0c0lYWGphaEtFMStKWjRRUWwrUEFLaVpZK3hK?=
 =?utf-8?B?MUZTWVdkNXpnMG01OEttbThhbnVrcE5iK2grM0gvc256Z3YrNFJ6NTBwdkVm?=
 =?utf-8?B?TFIzc1REektlVDZ5L2JId0k2MUUvbmJZckRGNmpoOHJxN3EvdDFCR1FYaW1z?=
 =?utf-8?B?NnpjZGlJTDNFeGkyQ0RqY1RvdDJNUHdhTEZvdnNYRHhYS0ZFaE5zdndzOGFN?=
 =?utf-8?B?WU0zT2drTGRkb3lBRE1kdWJXd3dmUTgzMUE2Vzd2QTZoSEVzOUJqeis4YkR1?=
 =?utf-8?B?WTFqTFU0em0wZDhwV3U5VVBLSlg1aXZqRkhaejR6bDR2c3NySXJjUlFwYm5h?=
 =?utf-8?B?Uy9Ed0lzeW42ZGticnRtQ09tdm1vUU51NlFEQkdRb2oxU0JwMFRwK25INXpF?=
 =?utf-8?B?aVRQT1UyeWExKzBwb3ZzOWwwREFhUlFreWplTk5WWHBaMm9HaGdKVEdGOXNT?=
 =?utf-8?B?NkY1cWJRMWxkMDhWYTZBUDlWUDZLbGNwNG5vTTdiV3IyNXplUGw5Q0VhaWYr?=
 =?utf-8?B?emdpQXZSY1F2OVdOaWFNV0U4cklaNWN0aFRxMHlmbzB6RXZHUklqYjI5Rndq?=
 =?utf-8?B?RGxReVB0WnkrT25ER2VGYnI1bmwzd2lsTFV3ZEFHYVNrN1Z4ak12ZEVETWpj?=
 =?utf-8?B?M0NobmpiTEJWcStvak5GMzY1UE5WTU1zSHhRMDYrc0VWQUxPNmt2aElrVFVy?=
 =?utf-8?B?akxuWmI4VU1sM2MzNXpQNitZeUs5azB0cllPMDNiV1VONFNva3ZJRmpZREoy?=
 =?utf-8?B?SXdhM0U3VGxobG1EZGFVTmQxR2M5WmE1NTF6RHN0R3FERzN4cnRmelYycFZS?=
 =?utf-8?B?bGxrN2Nmb3BLdkI3NlhJUlQvWVJFd0NnaThraDFHZFNUNWxIbmVRYVJtL3h6?=
 =?utf-8?B?ZStjV2hhUlRXTi9RMmkwTWlMUHRVV0lKNXYwLzdXc29wdk9KeUliUTJLbEMr?=
 =?utf-8?B?M0w5UlN4anhWVWhhNTlsdFN5cGVoSkFkWHpFOCtrLzZRTkIvT3MvRjREYmNE?=
 =?utf-8?B?VlpOWE1xRU50cXJsQ21rWWsxSGhVYTRvVTlWZWJxYXVtRTNTVk1nT3BQKzB2?=
 =?utf-8?B?WS9kWklJSFRubnZ5dTUySmRjcDhpc2o2L3Q0K2MraXdJc29iMy9xUFNzeW0y?=
 =?utf-8?B?dTRkYnVWUUJzcWpkU3hHWGxxdnBwaTEwN2FSOWwxNXBJQVJwRWEwaS9zVG50?=
 =?utf-8?Q?2kud4BiAUObWDb7oFFJGZv8Kx?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8fwaCN0z9NxIz7uUpn3eFA/drO23eVQrqrVybbMZWe8eEj3EJVBfaWgtzOU/ktXrKKEDZMl7LteFZRJHocEh5oa6kuvG6LCdkh7z7ufwHNjR4/Qm90Zs5XJ9iFIBlynKO0JtbSgkvktehE1t1ZmMyX2PjBspeVBI89g6F3UiTu5RU5n0v7UKr5EJ+GR2LOATCqDY1W0jBEyvN5MHeP6QEG4hiv52jJZE31Py2YL9qsEz754192Tp3JqwVqwSluUJDMWWj/sdH/j5yYo8pj4WKUDmL7607NE4Qf3uhYZsRao2mOX4R2MSPQQ71P59AdBiZvf5GqPNe3RmrnEcQN0vnhddF1jxATrWPoKJVXz5G4XrKFl7cJp1Q7SxkBLb8UUhHazBV47NOB0JvUuws6BznMxPoq9fx9kJbp0oLvWvIUfhVRsdORayjMFkFF6NcZnK6eoncP9ZLUPQgVlliLsaFGuEP8jGaERULVh1VlPMPW7EwPGBefrAn3aWDL18HLIHsqNqIRqgfLMZ4WpCbhCAItlb0BII0rmOSFt+VLk1V1iyGIriIinRgQaCYGR9J39UWxxoMpWHBH5/DPDhHxz/zvAvCWUjRPfO4T2CsVvtSkI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e278cb9-4d17-465a-89f0-08dd17ab5c11
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2024 17:11:30.9336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RaHxHUJ0at+lDZoSNuyE5E5+YyBllFi/TP0GsJzNb4UzsmKxrDisIo8SHDUav1F2vC2oC1GDfpRl678mCrgi3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7152
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-08_07,2024-12-06_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412080143
X-Proofpoint-ORIG-GUID: 733t1uhnElGbIUXU89XRp7YyoDr2YtUe
X-Proofpoint-GUID: 733t1uhnElGbIUXU89XRp7YyoDr2YtUe

On 12/4/24 10:52 AM, cel@kernel.org wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> The mtree mechanism has been effective at creating directory offsets
> that are stable over multiple opendir instances. However, it has not
> been able to handle the subtleties of renames that are concurrent
> with readdir.
> 
> Instead of using the mtree to emit entries in the order of their
> offset values, use it only to map incoming ctx->pos to a starting
> entry. Then use the directory's d_children list, which is already
> maintained properly by the dcache, to find the next child to emit.
> 
> One of the sneaky things about this is that when the mtree-allocated
> offset value wraps (which is very rare), looking up ctx->pos++ is
> not going to find the next entry; it will return NULL. Instead, by
> following the d_children list, the offset values can appear in any
> order but all of the entries in the directory will be visited
> eventually.
> 
> Note also that the readdir() is guaranteed to reach the tail of this
> list. Entries are added only at the head of d_children, and readdir
> walks from its current position in that list towards its tail.
> 
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>   fs/libfs.c | 77 ++++++++++++++++++++++++++++++++++++++++--------------
>   1 file changed, 57 insertions(+), 20 deletions(-)
> 
> diff --git a/fs/libfs.c b/fs/libfs.c
> index fcb2cdf6e3f3..398eac385094 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -243,12 +243,13 @@ EXPORT_SYMBOL(simple_dir_inode_operations);
>   
>   /* simple_offset_add() allocation range */
>   enum {
> -	DIR_OFFSET_MIN		= 2,
> +	DIR_OFFSET_MIN		= 3,
>   	DIR_OFFSET_MAX		= LONG_MAX - 1,
>   };
>   
>   /* simple_offset_add() never assigns these to a dentry */
>   enum {
> +	DIR_OFFSET_FIRST	= 2,		/* Find first real entry */
>   	DIR_OFFSET_EOD		= LONG_MAX,	/* Marks EOD */
>   
>   };
> @@ -456,19 +457,43 @@ static loff_t offset_dir_llseek(struct file *file, loff_t offset, int whence)
>   	return vfs_setpos(file, offset, LONG_MAX);
>   }
>   
> -static struct dentry *offset_find_next(struct offset_ctx *octx, loff_t offset)
> +/* Cf. find_next_child() */
> +static struct dentry *find_next_sibling_locked(struct dentry *parent,
> +					       struct dentry *dentry)

There might be a better name for this function.

It looks a lot like find_next_child(), but it acts more like
scan_positives(). It starts looking for positive dentries starting
at @dentry, thus it can return the dentry that was passed in @dentry.

find_positive_from_locked()  ??


>   {
> -	MA_STATE(mas, &octx->mt, offset, offset);
> +	struct dentry *found = NULL;
> +
> +	hlist_for_each_entry_from(dentry, d_sib) {
> +		if (!simple_positive(dentry))
> +			continue;
> +		spin_lock_nested(&dentry->d_lock, DENTRY_D_LOCK_NESTED);
> +		if (simple_positive(dentry))
> +			found = dget_dlock(dentry);
> +		spin_unlock(&dentry->d_lock);
> +		if (likely(found))
> +			break;
> +	}
> +	return found;
> +}
> +
> +static noinline_for_stack struct dentry *
> +offset_dir_lookup(struct file *file, loff_t offset)
> +{
> +	struct dentry *parent = file->f_path.dentry;
>   	struct dentry *child, *found = NULL;
> +	struct inode *inode = d_inode(parent);
> +	struct offset_ctx *octx = inode->i_op->get_offset_ctx(inode);
> +
> +	MA_STATE(mas, &octx->mt, offset, offset);
>   
>   	rcu_read_lock();
>   	child = mas_find(&mas, DIR_OFFSET_MAX);
>   	if (!child)
>   		goto out;
> -	spin_lock(&child->d_lock);
> -	if (simple_positive(child))
> -		found = dget_dlock(child);
> -	spin_unlock(&child->d_lock);
> +
> +	spin_lock(&parent->d_lock);
> +	found = find_next_sibling_locked(parent, child);
> +	spin_unlock(&parent->d_lock);
>   out:
>   	rcu_read_unlock();
>   	return found;
> @@ -477,30 +502,42 @@ static struct dentry *offset_find_next(struct offset_ctx *octx, loff_t offset)
>   static bool offset_dir_emit(struct dir_context *ctx, struct dentry *dentry)
>   {
>   	struct inode *inode = d_inode(dentry);
> -	long offset = dentry2offset(dentry);
>   
> -	return ctx->actor(ctx, dentry->d_name.name, dentry->d_name.len, offset,
> -			  inode->i_ino, fs_umode_to_dtype(inode->i_mode));
> +	return dir_emit(ctx, dentry->d_name.name, dentry->d_name.len,
> +			inode->i_ino, fs_umode_to_dtype(inode->i_mode));
>   }
>   
> -static void offset_iterate_dir(struct inode *inode, struct dir_context *ctx)
> +static void offset_iterate_dir(struct file *file, struct dir_context *ctx)
>   {
> -	struct offset_ctx *octx = inode->i_op->get_offset_ctx(inode);
> +	struct dentry *dir = file->f_path.dentry;
>   	struct dentry *dentry;
>   
> +	if (ctx->pos == DIR_OFFSET_FIRST) {
> +		spin_lock(&dir->d_lock);
> +		dentry = find_next_sibling_locked(dir, d_first_child(dir));
> +		spin_unlock(&dir->d_lock);
> +	} else
> +		dentry = offset_dir_lookup(file, ctx->pos);
> +	if (!dentry)
> +		goto out_eod;
> +
>   	while (true) {
> -		dentry = offset_find_next(octx, ctx->pos);
> -		if (!dentry)
> -			goto out_eod;
> +		struct dentry *next;
>   
> -		if (!offset_dir_emit(ctx, dentry)) {
> -			dput(dentry);
> +		ctx->pos = dentry2offset(dentry);
> +		if (!offset_dir_emit(ctx, dentry))
>   			break;
> -		}
>   
> -		ctx->pos = dentry2offset(dentry) + 1;
> +		spin_lock(&dir->d_lock);
> +		next = find_next_sibling_locked(dir, d_next_sibling(dentry));
> +		spin_unlock(&dir->d_lock);
>   		dput(dentry);
> +
> +		if (!next)
> +			goto out_eod;
> +		dentry = next;
>   	}
> +	dput(dentry);
>   	return;
>   
>   out_eod:
> @@ -539,7 +576,7 @@ static int offset_readdir(struct file *file, struct dir_context *ctx)
>   	if (!dir_emit_dots(file, ctx))
>   		return 0;
>   	if (ctx->pos != DIR_OFFSET_EOD)
> -		offset_iterate_dir(d_inode(dir), ctx);
> +		offset_iterate_dir(file, ctx);
>   	return 0;
>   }
>   


-- 
Chuck Lever

