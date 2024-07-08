Return-Path: <linux-fsdevel+bounces-23288-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13BB092A518
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2024 16:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AB641F222FE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2024 14:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C319E142E6F;
	Mon,  8 Jul 2024 14:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Wgw7+1fL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kvv8w/EL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA5D13FD8C;
	Mon,  8 Jul 2024 14:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720450124; cv=fail; b=S1m7w4BLf8rOePwgvCZgEJnJcuG328vEWc+LYvru3j3JvyQljME6cvPxHVlTUqx4APZlwh3ZhbiUx3LwiBIpBK2ZRsrlV/B2RYhg1JdK63Lp6hqG80ye3dYMRZpviiaIHiNtWc3HBGLSp0cXfrtYmc/aucgqxkE6k4hDeNvBfHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720450124; c=relaxed/simple;
	bh=EntovUD7uPVII9w0xd4/Y0y+1CGDIhvOzEV799h+75k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fsEMafa5fh6Qy6w5q8xWuNlLMJIiPVhlY5VhZ5cGd6v0m1XBQx6hZPjb1hAu5VvjrcF0Ghtv2NAb8HLLCm/pK3mHyOvtt1q/vCOuK34DPVOX+bSE4Aca5pTYoDURlqvMwt/jt1ygfoTgtkh0drp5U3t9p1xTbcyW0haWbB9P6ek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Wgw7+1fL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kvv8w/EL; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4687fWS1018083;
	Mon, 8 Jul 2024 14:48:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=e/ZszIrFWxr9Mqb1naBEzFSPy+UaOaWqY8RB0FFIRdw=; b=
	Wgw7+1fLGxJBoxgR6mKyljoDGL6LT79oO7p4aX0mxcxieZ7pbXFdCBaIMs9kMzrj
	oTCmHOhmcvQhIJAljzAvajy5wQqvdGzWGvgEKQX0xDVLP2AxCKZmmeO3y0+ZD4Jn
	H+Wzmmr7375H08UmqiBwS1ypzLrjCtOmPg0hT97iN7wFd5bxEHyHuRLQ+kGjLYh+
	AI9NZUfIBXokjxFzqUCXBOAfEDBQGshjmeP53bXfFDmUAsILj0MEpVq3e/7IqPlx
	EQjpX5R6O1oqV7FxXDbome+ETgc8Ccpna5NhqLuqQoGXNCQulF8jK+ha69ClD9H9
	BTKQG1iHwc0jZi5ilGwVlQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 407emst77g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Jul 2024 14:48:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 468EDamE036237;
	Mon, 8 Jul 2024 14:48:32 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 407tuytfca-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Jul 2024 14:48:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jq3eQqP85LOfFVHKVxpQt3SR9V7XErK0MwQeqIO2+P33plY7nPhvTX9p86A+eEWtqO1LNBgMOa42Q5/y8LJ++r7Mq4L/oAX19X/JRrvU1QlLlq7EV6vw3SxQita0Yjhg8eX4p8UAQLHx6+aTmUg6lQvEOsk+aQGiVwh79dFf5vsmc5olwJtQofty3p977M98bG+lkQevfhia6bD4Dumg6q5snvNfDzddLbmdkeaE9WhKoxmiCXnLeF/8qhEZRvgvz/DtnDilIdyjG4N0Ydzx1BGkm9g2yaBgKvZxg3GmMlyqc8P5ysF+TN3/0V3W+7HX+g9AFQGoUE8ez9Sgw8QGOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e/ZszIrFWxr9Mqb1naBEzFSPy+UaOaWqY8RB0FFIRdw=;
 b=mJkOogFpGjxgxg2eHCfkbyybKBcHTRAWpG/idi+zAfs2es9d1ijuAi+TMqTdZM9/objuRYdh4tORTwUvDY/i/w/1ZkDcey1bhGCjmgznAABtbnm/l7Qg5eiq+0v5LXzcPaP9fAt0tfXmmoXQw0/iio7x047JbT9POUV7YUPCLFFpwR+Qjjd7DMUnmDNIhEesdGNG08Z1V/N+6+1x2/je7lWwA8/T6Gl6EiTFlGaUP5j7P8IA+I3bqFNJg8c8fI4ws3lhFss95wIxzTDlEYqPfwq5b5uDXhTfAB4og+zw4dgO7ajB+W9uTAOCqjrv9BvsIgfE7cu9M0XM7/isBhn29g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e/ZszIrFWxr9Mqb1naBEzFSPy+UaOaWqY8RB0FFIRdw=;
 b=kvv8w/ELqEQ93K5V7jgK/wf0cqZYfW5ttn8WNybsThd/rc4zACyUadkMPA3FRricAQlFUNNcl8NyM+xg4QM3xGhg+i18xdGQRLzfoCFWQmPhPGExYSz7ubU6W5m5rtH5sb/uRMDcynUwIWgq/Mb7X9ik3dfS0jPPCj8e0d8CCJk=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB7838.namprd10.prod.outlook.com (2603:10b6:510:30a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 14:48:26 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 14:48:26 +0000
Message-ID: <5e4ec78f-42e3-47cb-bf92-eddc36078edf@oracle.com>
Date: Mon, 8 Jul 2024 15:48:20 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/13] xfs: Unmap blocks according to forcealign
To: Christoph Hellwig <hch@lst.de>
Cc: chandan.babu@oracle.com, djwong@kernel.org, dchinner@redhat.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
        martin.petersen@oracle.com
References: <20240705162450.3481169-1-john.g.garry@oracle.com>
 <20240705162450.3481169-11-john.g.garry@oracle.com>
 <20240706075858.GC15212@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240706075858.GC15212@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0073.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:138::6) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB7838:EE_
X-MS-Office365-Filtering-Correlation-Id: 41f34818-e0fa-45ab-91d3-08dc9f5d05d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?VTJqZUVsMkVscXpiempZUlN3eXI1elFheWFscU9GdmxzYmxIamFHSXo5aHpq?=
 =?utf-8?B?YTNOMGI2VXpYeVhZajNPeW1XR1VjOFppZHg4VTlyUjB1a2o2MmtrcFZMSVgr?=
 =?utf-8?B?QUExTk9lTUlMdTFUMHhhZVJNRlNoZ1d5dm9aWndLbFZoeGYwKzlNQVFVd1N4?=
 =?utf-8?B?akdoazg0TDltMHhHU3ZCYUF3ZG1EdmpYTG9YdkhVTDVvTnBtaTI4UUVLQlgy?=
 =?utf-8?B?S3ZWZDVDcUJxRCszVlMwQmV4RThPZFRrNXRiWllocVh5akJtNk4vNERyUXNV?=
 =?utf-8?B?d0JQWm5OV09RWnh5ZFVKZUdGMzBFZlowT0F6UWpoRlBqYVNBS3NCY29lM3R0?=
 =?utf-8?B?RE1XanFiRTZ3OEo4amViTW1peTVweEJnRk1TUy9KaFVDK0dQamdELzBJdFVp?=
 =?utf-8?B?QllHQjJZU0ZRR2lXTjRNazdyS1ZoMm1BNlhIUG9yckEwakpKMk9sQzJ0U3Y3?=
 =?utf-8?B?NWI4clJqb1FIajBvTnhGRW1VTkFRdTBqQ01va1pscUZkOWJYUUdMOXA2ZFFi?=
 =?utf-8?B?QXBaYUd2aGt4Z3d0YmY0YnRuaHhsREtVM0NmMklYb2w5NXhvMUh3cU42VUVV?=
 =?utf-8?B?eGQvbHNyejdJWHowTzJhS0M2SW9VUkphNG1kM1BVZ0plQkpjalU4cmFQeUhP?=
 =?utf-8?B?Q3BvZVBTZkV0ZDduelRpd2JBRUhzNzhyR3B0Y3hwTXJhS1loRmxCb0NXaWZF?=
 =?utf-8?B?NkZBZklwZkRocGJEalFTTmN0Z2lCU2FuVVNScXFHUjN2M0cySnFtcFBINUdY?=
 =?utf-8?B?dGgwVWpBV2ptZkNyN0NsQXZGV3ZqV05UbWtqdE1mbDhVOG84dGhlTWVhai8z?=
 =?utf-8?B?NElVVHNmdEdqaEdReTRIQmV1RmQwME05WWZwU3NHdDBML2UxWXJrQUg1Ri9F?=
 =?utf-8?B?QjdTdWhHNm5CM0ZDTzhyeG1yQ2NZcVI5UGdkem1RcXBKT3NIYk1KZWllT1Fk?=
 =?utf-8?B?Vm0rSWFWS0NYUzA4a1l1VkZRZDBBeHJ6TW1ER1lwSXY1T3VjdXFCclpFQkxh?=
 =?utf-8?B?R0QwWUpLSzhPd01YNCsvNC9PZGc2ZXluRkE3eDNiZmVHcXh2S1lyb3FTY0Ez?=
 =?utf-8?B?TWhhZVVMV2F6ZXYrT0JjYmxudUZodjJDODd1bHZSc3Zwb3BoZVVwVnlVZ2xj?=
 =?utf-8?B?T3cwVy9oKzlIQXhUV2F2T0VBTjRKeUFhWHdMV2ZOYnBaS3NRdTB1T2tPZjBr?=
 =?utf-8?B?elJ1MEpSUy93azVXdTVkSCtzUlRTZlBpNWNHVVMvVEVKRGNOV3JsRWNoeTRi?=
 =?utf-8?B?dTBVV0J3S2RUMjc2U3pLbkdQcDQwdWJyU2xvbHpmUmk2bGNtNS9Bb3gzR3d3?=
 =?utf-8?B?RHd5TzhXelFta3NZeWhBaGxxejhOVFkvYjFCY3FpRGIzeWFhQVI1c0FSbFZx?=
 =?utf-8?B?RlQxWFcvYnZTUHROMUxuaVEzM0loOGVSVVRFMmZxOENtKzNYVjlBQjFFRzk5?=
 =?utf-8?B?R0xKT01iWFY5T3lwZFBuRXdZM2I3dmp1dk5RekFLWm1aQVBvYmdTblVwSk1G?=
 =?utf-8?B?US9WWnVHMUVXT2VjUmJqZ0toYXlIMGVQbksrVGd3U2h6S0NIU0M4V2RjRDhY?=
 =?utf-8?B?RWl5ZmpRejFQY05jZUFmNFJ5M1hZbCszb1E5UDRCNnhOdm1ZOUM2TzJCODRp?=
 =?utf-8?B?U1crNEk4UC90TDVzb1lTKzhpQTlpRktiaEtsdVgrdWNQWmNFaWtBYVo3VTRa?=
 =?utf-8?B?a0NFcXU0Y0FZWlRtMUU2UXdMd1p5bEkrWlR2WlpKS0h3NkpZTU5DbG1ZV0lk?=
 =?utf-8?B?SjJLVFV5MlgzK3JQOUdEaTFzMzAyTXB0TUIyZ29uL2h3R0E1cmhtQU9YTHla?=
 =?utf-8?B?eVMvU3VCU0ljMWFMUnZEQT09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WUVoL2g1cTB1dWZ2aFFPK2lRVGxPVzJJdnFTSUthMUJPQVJjZU94dERyM08r?=
 =?utf-8?B?WmtuOXYvTnViMzhSUFp5bjRoVUE3MDEwRFB3Y2g2b3pHcTkyYWJvVGluRUs5?=
 =?utf-8?B?bWhPK3c4NG9DNGl2MVJQQ0o2MTREU2p4NG5rdHpRVHJIbk5wNER5bkxaWklq?=
 =?utf-8?B?UlRMMEcrU29sbUVza3VZMkZMTVRGbFRleTdiK25yQUJPUmIxT0E4NjFieERI?=
 =?utf-8?B?eEdmZmNFZW1wTzBGRnp2N2poYmhma1dDak4rWWRqUmR2dGhacDYzZFV4c0t2?=
 =?utf-8?B?QmtPNmlNWjdqRkptcnJzMzZYSlU3M3NlODlvbHY5bnlqQ1VHMWlFYUJIcTBT?=
 =?utf-8?B?SnU5K05YR2xFVGNpYVBoL2dxMXN1WVJoeVYyTm5ONlc2Q2RKaW02ZWUySVE5?=
 =?utf-8?B?MjhuMTF6d2ZVQjVWZVBYVUJId2thKy9DVkg0L0VodE5jR1QxWnliUDVwalVD?=
 =?utf-8?B?MFFXTjc0RUxqeTNWMU1YZ1IvdmJQSWdnRzZQRWc4b3FIaUpQQkVGOC9Idyt2?=
 =?utf-8?B?MllvTjN2YVQwdlc5c0pUd2J5NEpiNmJwN09DdGRSMEJHQ0JDaEdyTVVocTlK?=
 =?utf-8?B?NjNUanRKQ2pWWi9lbmFVREp0d0Q0a05iQzVtd3RHNDJFNk1JbU4vRW9qZ3ZI?=
 =?utf-8?B?RVgzYjUvOGl6MC9JOGtVdDQvakVCS2xWK2xZNFpSVXBIeFRGN0NrdGpyMDAy?=
 =?utf-8?B?QXVqS1NseGxPbmhWdUU2NEtUVU53T2p6UExPVHNiRm8xS1M0bDJIT3NOMVo1?=
 =?utf-8?B?dno5S2xDNHArRWRlU3llYzVOSkVNbWJHL3dJTkFFNEUrVkdxbWxJNlpHbU9H?=
 =?utf-8?B?WUVqTTVJbll6bkVmcWdxeWJIRGVmM2g4NlpPL2lBZnJqVFZoR1VnMlFLb01v?=
 =?utf-8?B?V1RYSmRSUVRnZGw2MGh3NHQyOVJlaFpjbURnd1JRQmRxU0NjOXJ1K202ZUM0?=
 =?utf-8?B?ODdndlZFL0R4aTRieUxrZFdxUnN3aGNxSnJ5Zm9IYlMxRFpHNzRpMUxWVk1J?=
 =?utf-8?B?MkxrYzZtS1BoZm1iQmxsZmJtTGFVTWVaSHdIOGQ3UllNSDRNMzltaVJDRFhY?=
 =?utf-8?B?MGJrTjJicE5xdFJNWDFtd0JvZ0kyVjZScWdNajh3QW1jVXNuTGJZSnRma2R0?=
 =?utf-8?B?MGRySndGa090ZXVKdHpjZ3pSRklsbUhzWFM5LzVTR1Nka1BRNkFuRzRTRG9i?=
 =?utf-8?B?cWNDblQraTZNR1ByS1hJTEVEQXBveHRZNUJaZVRQNEp6aTV0QmtpNE5hbDdR?=
 =?utf-8?B?d0Zob05SQ2ZjdVVQbWVtcjdVelJvYi9wSWZFc1I5NDl0cTAxS3dYM25xR3pW?=
 =?utf-8?B?MFZnV210SmRWY0NtMEIzQUI4Zi9MdERVbzBycCtRYmFYd2c3OHN0MFBNY3Fx?=
 =?utf-8?B?anZhVllxS2xSL05pK3o5VFZ6V205NTBWYm04NTNLa0hSZ0I1VGZiOE52UTQv?=
 =?utf-8?B?Ny9hRU9XRGFTZmpvV3FYWVZ0SXBnQ2k5bThVRWZwTjhxc0UzSW5kbjFOd2Jz?=
 =?utf-8?B?WnBOVUUyMFVOWFlWLy9qbldIZUluSEJnNktpNnlBV3MwSkNMbDk3V0ZQVmRo?=
 =?utf-8?B?VXgzRFdJU200YlFHRXZ1SHdWUjZpdHQzWjZuU2tCTk5rMTltaWdHZHdUZFRj?=
 =?utf-8?B?SzQ1V0d3cG10WnNPTUFQWk9OUnBPWkptUStoc3U4N0VJZ1QxNHBYNEpOQllV?=
 =?utf-8?B?WlcrcFJ4UEhXc1hWOGhYVlZteGR5TG4xRndHb1N4MmNCekZrZldURm1LVnRZ?=
 =?utf-8?B?R2Z1ejlFQXVUaGpPSFR1VnNFNFZUMzNIWEV5YUtqVTRPNnZ2YzNhWkRuU1JV?=
 =?utf-8?B?RXM4blhyTnN4ZUpBMVFFL045OGNrSHJvdFJyTFZleE5iZE8wN2lvd01zNWZs?=
 =?utf-8?B?L3k0c1UxcWhSdUlnN3RYQW1Wa1BmUXdVeFZWUW5vcGxDRTY5bGUyMXNwelRs?=
 =?utf-8?B?Ui9SbGoxSFc4NkR3ckJHeVhUSFpjdDFoOHVQdkREWDBXVFhnNUZUTDRuVXYx?=
 =?utf-8?B?SVVtNXVSR1B6Tm5jSGFQaFcwZ0VUczI0Sk9PWXJOYlkwelpGSVRiaUZvK0xC?=
 =?utf-8?B?RFAwTmUrU3ZkRHZQbjFDY0V3emRuNVkwNXhwZ0swSWUwOURISlRrSDh0N21l?=
 =?utf-8?B?MklISk5zZG5tTTRrdUxlaHlERU82ZnRERnlBOU9GUE1kZ2tSV1ptM1NVeEhF?=
 =?utf-8?B?a3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	gWqDcb6nH5YODDRN3KJirXVQvou3Iv/Pe9diTh7T8mkchjVOZODeLaUa6HJyvUlrsnqB2OHX4kOJoBt61NW1f40HzuT82namQ9BQ5Vllwic0tSq2GacrWrvWq8+gw+dcwi8c/W/HAL2ed3HTdB8+XfxOyNwipbmJYlc20WlFD1akUJ1vtp4LyWFup9xIW+tix/kAhSifIUdg+IJx7UtY7XsYEz7gjX+xNO051m/ppKLood/RqYfQAQcqqI93QvWjZH67OD5Bdj+MNfv1n/qYCRxuK2R4f1tTTpdVtVXlW4fiWbkg2cqe3Elnn1E1bN1VWZ3byvhHWd3lawsNjvzMa12mzBAmq6L5rOfHaTBSVHJn09lC/99s/VbXCxr6HK3udZlVMUM/emBNjU4QItOYhamowj3Y2/orsHmkuh/p0gjYjEy90Yas9RPzWdUGB+FGEphPP+yMN7fe1irputNrnySvgNv11QpQO8r0uVLyA8+iABdWpistnOT9XkInYggj3iPWnHYcCc6z7axukYmYyTxmGDmieV6Rex7P084AMrzzLbsnpa2gju5wjvYA0whdGIR8xQq2EoDTW/T41Njsgvac1tJSL+UsWr+2BFPTbY0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41f34818-e0fa-45ab-91d3-08dc9f5d05d6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 14:48:26.0407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /+4tv6qJU5zqoO2zSTWtKtlEIwxnDN+yUxm3jND6iWMMKbN/GjuuKfSn26n0VZVxtdpGaCo2oZr52Y4sZoA97g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7838
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-08_09,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407080110
X-Proofpoint-GUID: XgOTUuiyq7LPSCsHU-2j8YAPj7oD0gU2
X-Proofpoint-ORIG-GUID: XgOTUuiyq7LPSCsHU-2j8YAPj7oD0gU2

On 06/07/2024 08:58, Christoph Hellwig wrote:
>> +static xfs_extlen_t
>> +xfs_bunmapi_align(
>> +	struct xfs_inode	*ip,
>> +	xfs_fsblock_t		bno)
>> +{
>> +	struct xfs_mount	*mp = ip->i_mount;
>> +	xfs_agblock_t		agbno;
>> +
>> +	if (xfs_inode_has_forcealign(ip)) {
>> +		if (is_power_of_2(ip->i_extsize))
>> +			return bno & (ip->i_extsize - 1);
>> +
>> +		agbno = XFS_FSB_TO_AGBNO(mp, bno);
>> +		return agbno % ip->i_extsize;
>> +	}
>> +	ASSERT(XFS_IS_REALTIME_INODE(ip));
>> +	return xfs_rtb_to_rtxoff(ip->i_mount, bno);
> 
> This helper isn't really bunmapi sepcific, is it?

Right, it is not really. Apart from the ASSERT to ensure that we are not 
calling from a stray context.

> 
>> @@ -5425,6 +5444,7 @@ __xfs_bunmapi(
>>   	struct xfs_bmbt_irec	got;		/* current extent record */
>>   	struct xfs_ifork	*ifp;		/* inode fork pointer */
>>   	int			isrt;		/* freeing in rt area */
>> +	int			isforcealign;	/* freeing for inode with forcealign */
> 
> This is really a bool.  And while it matches the code around it the
> code feels a bit too verbose..

I can change both to a bool - would that be better?

Using isfa (instead of isforcealign) might be interpreted as something 
else :)

>>
>> +		if ((!isrt && !isforcealign) || (flags & XFS_BMAPI_REMAP))
>>   			goto delete;
>>   
>> -		mod = xfs_rtb_to_rtxoff(mp,
>> -				del.br_startblock + del.br_blockcount);
>> +		mod = xfs_bunmapi_align(ip, del.br_startblock + del.br_blockcount);
> 
> Overly long line.

noted

> 
> We've been long wanting to split the whole align / convert unwritten /
> etc code into a helper outside the main bumapi flow.  And when adding
> new logic to it this might indeed be a good time.

ok, I'll see if can come up with something

> 
>> +			if (isforcealign) {
>> +				off = ip->i_extsize - mod;
>> +			} else {
>> +				ASSERT(isrt);
>> +				off = mp->m_sb.sb_rextsize - mod;
>> +			}
> 
> And we'll really need proper helpers so that we don't have to
> open code the i_extsize vs sb_rextsize logic all over.

sure

> 


