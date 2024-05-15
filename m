Return-Path: <linux-fsdevel+bounces-19554-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C228C6D07
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2024 21:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 743541C211BB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2024 19:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BACD815B0E0;
	Wed, 15 May 2024 19:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mrDYA7Xv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zIRONDvk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B03C15ADA7;
	Wed, 15 May 2024 19:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715802903; cv=fail; b=H9HiJSOvG9IbZTK8J1aQnhOL+M0owrF5vRmec98y1hwNX6eXiyjQUlL4oBUfgnT5bzRcj3XYFVtEHYUTTjEzsyFECDYPh0/vDtQBc+79gdVy0OvH1iAolDabPdpG85flHJHj62D9R5slvt8eAcUQxJlVL1lBf8jKN03Fo4D+ljo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715802903; c=relaxed/simple;
	bh=XyEjvn4pOCjPigbvPy5htyHdrQYRQgKdSX2CQ+EE/RA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tU8chA7RkicGK19SoUH2ztrr+OrUNkTAP9gty3DNWrKk89diLSv5qCAsfzM1k7yxW+vAkecUn0wDG2SAesMZAmqJWqmMN12N6zUztio1/nYFVgkey56Dhre9WHSXLKU60ZsUGY6qbyDZ791R9BsY+Tj6vkDOZfFBcS1NwPDtMZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mrDYA7Xv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zIRONDvk; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44FHxofb031436;
	Wed, 15 May 2024 19:54:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=Z6TrAf0nwGZF8ndN99fNG4Pf+QUz7pMYjqR6gHvDlWI=;
 b=mrDYA7XvDd1oc3RL7Nf7cWMdDNOptImNg9lcxYabqHweq/yrbJNB/qOUiwf644I68CyY
 YTjAnILriUQSbDrGJYbR7yYAFNy1sUcPaMbIYIm+jXYVXHLKO30Jb9SlgWKwfz4egJQX
 IUWC4BnKDEuBgDyChYNrLX575MPieSAoZt6nfFCmr2omwztSl8+152hjQvgt6O6v2i3s
 gejix+einN4So3W/ZKqhWLjHTyztiZsLGb5KpHhrR67AT4kzJe9OQH62ZwJqs9+OutHE
 e9VC8EDTvOVsA0AUVZF9UTr0EcYeNgnQCQvrxiegV3oGoRiXrK5Sw2RtVZB0rAh6qL5M Mg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y3rh7e5g0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 May 2024 19:54:44 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44FIWR4H018054;
	Wed, 15 May 2024 19:54:44 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3y1y4fgfyr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 May 2024 19:54:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BuysphiL1tKh52JRQFc99xvegBK7Gya+y8r05Xdx0T3sLbh8g69+L3ba/OFZgroC7Cxy4oIutyII6/BWLusrLjQIN/+X2Su6lJbHdTuRvRMUxb+NcDIV5mq8yNZv9W7faKwGaOzP95J7qJ3j00GYDhtY0DujnB5MvanlT69ZE3vFUJbqNKZWyDqqiBNSQmiCZfYISWeHa5W8AqmozZtNiV8qTu4urBi2k7tz4kkfxQhqfinZob+dgtmCUQl+fR1O9SYwByGHR0avKVAhFo8LXc2IZXRoKr1tIQplWY6MM4uP1sx45zaXwdVseZxV34eAGgUC035XG6FVG1vrLLuhGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z6TrAf0nwGZF8ndN99fNG4Pf+QUz7pMYjqR6gHvDlWI=;
 b=D8oLknkPj3MBUv1xPT69zRPnWAdD1CHzWdF3PmIOMxcWIfeE1ortwDUEflwHcdy7VoxpDy9UDXaSjmcOySPHLGnwFZP2XruX64G2VXr7zZ9pJ0sdB8s1AeawwbLFhYwi6o9hk0nheL/J9vJv56byXQH9TuHNFyHHxg11lUFLSuc5NbRdNmS30IJsWEoWnwc7SAmAii2jyq5xfKRPp6z+BvuInlNkOXlg8zDOh3CbsKxI3496HXfN7IxdWEaWBJtcKbGxKLHdSjRa/HeFJWettaQpOiXP7XIJNdQ2WUvY9wIeIpb2mqp3zJXiNZg/5mQuAfMD/FwRy9z9jlWWZGgPjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z6TrAf0nwGZF8ndN99fNG4Pf+QUz7pMYjqR6gHvDlWI=;
 b=zIRONDvkQNxI+YYK3MeD/WIRp1+bQID/i7KbIyUo1eNbg2wKIaIvuYj2qRWJVChSC2WEl9zcOiv2PxTXW7yp6B8mkWwSVQAR693SIklK71XdLtuTup4ttgisrwjPrQMDy6Xc3mcc7e105CQzWuHCd2K05RzaEgOd5KK/Iuec4fI=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA1PR10MB7699.namprd10.prod.outlook.com (2603:10b6:806:38f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Wed, 15 May
 2024 19:54:41 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.7544.052; Wed, 15 May 2024
 19:54:41 +0000
Message-ID: <9e230104-4fb8-44f1-ae5a-a940f69b8d45@oracle.com>
Date: Wed, 15 May 2024 13:54:39 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] untorn buffered writes
To: Theodore Ts'o <tytso@mit.edu>, lsf-pc@lists.linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org, linux-mm <linux-mm@kvack.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org
References: <20240228061257.GA106651@mit.edu>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240228061257.GA106651@mit.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0011.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::24) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA1PR10MB7699:EE_
X-MS-Office365-Filtering-Correlation-Id: 64647efa-01fc-4d82-1512-08dc7518dc40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?WDh0TklXMzlPa2hORE10NGRMaXM5QTBtaHlYZ3ZNb0FiMWRoazJUdFNoazVJ?=
 =?utf-8?B?c3VsSjBQUllzQndvWVk5SExpY2wyK2w5RXhKOXkwTVJiSyt1d3d5Z2krWUUz?=
 =?utf-8?B?MXVhS2pYOFRMN052QUNTWFRFRDJDOTZmaFJ4RXN4TGg2ejZpRks5a21YNDFH?=
 =?utf-8?B?a2R2azI5UFF6M3BmN2hYbWxWK05GdGNaVE5aYklPVytPR3gvRktJZ2YwMG4v?=
 =?utf-8?B?d2FFVm1DU1Q4WmFkaHpFZHlaUUs2Nmp6ZHV6dEtBNjNMSHdBZ0NuWVlOWURW?=
 =?utf-8?B?emc2aERLVXhLcDEzekE4clNmWDZpTFQvc1JpWjFUYzdxQUJNWE80cW01M1cy?=
 =?utf-8?B?K3dGTXByS05JanVubjIyUWh0TFByaSsrR0pscjQvRWRJWlhrdFFVL1RuMmhS?=
 =?utf-8?B?MHQwZXlEOWx5cUxNa0ljYmcyanpjcFpkL0FabnhiM2F1TFFVditkdjEyTjd3?=
 =?utf-8?B?MWJIaHJMaTZrVXFndUxkMjVXSDFFMU5rYmRHeU1hMXVWY2lNS3BOc244b0lj?=
 =?utf-8?B?cXdnNVBJUmFpaVU1SlVyZ1hYQVV0eVJHRUkxYndIWUVCSWVhN3pVbG5RWlFh?=
 =?utf-8?B?dWFHd1ZBQkVRRG1laDc0blVJenNIRmdWdVJPZVNITlE3NzFNVmNnWmgzNVNH?=
 =?utf-8?B?YW9KWnRGVHNOS2RITC94SU1KQ1RwbldFZnVKOW9CM3h3T0Eyd0cwVWY4SjJE?=
 =?utf-8?B?Rk1pWU1WMlViS3BVaHg4QnFlTUprWmhlQlFUNFpRQW0xMFNrb3ozREw2RWhZ?=
 =?utf-8?B?NWVMMTQraWVjTTQ4NUNIOHc4blZmaVhGOE0rNEVTZ0w5TUFEa1M1YUEyZGtP?=
 =?utf-8?B?Z29WS2dERXd4YjQwME42NEN6VHBheG5nTVBTMFBZT1dyUUdtcDdOcDdHQjZz?=
 =?utf-8?B?QWJuOFlvblg4RFlJTkdOZ3lzWE1HOHRwUVdxUnM1OFByb2hHQnQ5aE4xdEV0?=
 =?utf-8?B?dVFRODBIU2NVeG4ySTNjYnB1OXhDTmtyQ1BBSVNETHl0OGlLb0htZnJWN1kw?=
 =?utf-8?B?WGRUckVrNG1XRE5vcjFHeGt0MVlxUTVMbW9KQkVDMUd2RXhJbFZqMjBsNGl5?=
 =?utf-8?B?c3VMNlNOalNxZTRxcjZ5bWdDcGcraWVEN01Fb1c1VkY3Nm1ENlYrc2JzeVdY?=
 =?utf-8?B?azIyOHFYMERrUlRyOE5kMjdMb04ySFZFZE9xZlBzc3RqTUdMYjVzZEVBK250?=
 =?utf-8?B?Q0lxNGxKZE5tL2VyUnR1TmgrSXVlNDR3Zmd0MzZBN0c1WDFpOXZIZEdTRTRa?=
 =?utf-8?B?eFRId24ydVpHOHI5Q0F2KzQ3UGFDcm83cXFoUkc0M3JyOFR6WjZadnVrQ09x?=
 =?utf-8?B?eWZvRU9ZRzhQNEs4TTFpWFFJYXYwZmhNa2lwdmpMeDJrQkNHbHRGYlRUTFdJ?=
 =?utf-8?B?ZXcvUGdqMGxjQTNwSTR4eVYwam5LYWRkMjVNSjE0VXpIaUp6UDZ2dk1tTUNl?=
 =?utf-8?B?Zjd3OTM1Ti9acXBmVWk4bUl1OWljc2dnNk05SE0zSXRnWkZuOG9kWHowTkgw?=
 =?utf-8?B?VStSVlVqZlMyT0k2dkNsTFlUL3FTcVBmbG5HblBCeFozSVdBTStrSi8vMVZi?=
 =?utf-8?B?TjE4b002bDJhdUM3YjF0cEpDZy9Db2VpMEJDVGptTHJiRVFGNmFSRlFVM0pB?=
 =?utf-8?Q?Y9xTaokfDxxKv+uvXbKrLv60Bz/hwLE79H8X17OOPlJw=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?d1dKMXMySG94K1BPVXB0UnhtWWl5WEtNUDRvZXE4dGJ0TGZ6RmxneGtvZFpV?=
 =?utf-8?B?Qjhib3BuK2tLOVlsa1ZXTWg3ektsUUxKTXdLdEg5N1VQVU5TWE9NZVNWa1RI?=
 =?utf-8?B?OG1pNUlLY3lsMW1kbWhEYUxPc1FFL2c0VUptb0drbHlCYkFRUDRnRTZoNno5?=
 =?utf-8?B?TzBvb3Z3N2dTYktTZ3IwODh3UDhpaXA2RHBINlRVQWFKVERIUmxGM1J4bGpX?=
 =?utf-8?B?UGZvb2xMSi8zRVNzL0hYMVZESVh3VVoxczZtY3VBS3BwZEMzOUx5VXZuU0Ey?=
 =?utf-8?B?Vmh6NWRVRjFpN0M2ZERQeWZzQ3F4anhjdUJLN0pQRW54T1ZXbWZ6YkNPdGlK?=
 =?utf-8?B?aGxNVERMVHpLcmR4SFdzR2VQOUxCS09ZeDhYQnJ1TzJQMTM4VHJabDhzZWZZ?=
 =?utf-8?B?VDI1TnlCWHM2OU9VUzJneUp2eWlPKzhCN0hFTVFFL21RaVJNY1RHVWFDT0l0?=
 =?utf-8?B?UENldC8rZUppQzVPVlF5OS9DMTQzL0JaaHprMTNpT0RDUHVKL2o1Z3VIcnBQ?=
 =?utf-8?B?UldtdkFXUnZPTjRaTURoV1dKMnJRanJla0xFRHRwWDdZZGYrWkkwdTNDdmtB?=
 =?utf-8?B?NmJTSHRFdU9pYkFYNUc1NTgyLzE1cndPV2hSYmpzbWlUS2h0MXJ2dEEwakpM?=
 =?utf-8?B?VTJKOFladmV0Z0RWK2FsVjgzajV0bEwzQUtvUzZOWlNnejFSMXNPeUM4OEhK?=
 =?utf-8?B?YUJRWVVBbXdydmhla2pSNWsvdEU5Myt1U2pZSEl3aUZZMHlJaC9uOVBXeGcz?=
 =?utf-8?B?c1E3REtSSTZ6SVZoVnQwTDVFUUg2aGQrY2U1a2ErdWl4Z1loODVhT1pJa3p3?=
 =?utf-8?B?ZWs0ZjJDT1NSbkFpREhnWnFKUlZEYTJLY3dpNkVYWkxad095Sm1YK0hVYjZC?=
 =?utf-8?B?Z3RCbmRxQmU0d0gyYmdzdWRDaFJGRmdmTDdOanVYcHg5ZTYxMFNveFBCUG9y?=
 =?utf-8?B?ZDhjRUphNzZ0TEZ5TENuSXlQU3pSTjUzaXR6SFdaSW9SQkhnN3kzTnE5NUhS?=
 =?utf-8?B?TGRrdTJVcS9uZXNyc1lORnFsMG1oZ2pvN3JnZXRlU0R2dVVqY1ZJU0VyT3l6?=
 =?utf-8?B?cHFFcVdDekFuRkFteWNCcThwYWhFZnJaeDVHWG5ySHFYT0pMSVFCbXFnQWc3?=
 =?utf-8?B?MWVPdi9xU3pibjNjWElCT0tJc25sL2dGNVVHZDVNZWJyUkEyYjVNMmY2QTR1?=
 =?utf-8?B?MDNLM0pVYXFJelpKdG81VC9veEFJd1hCS3g5ZzVHVUtjbnJ2bjR0c3Q1MXNp?=
 =?utf-8?B?Y3hNOUszc3pZMGVoVURjMkE2RWRTRFlhaEZVTGNVSzZYZ2hLKzI4Uko0OE9F?=
 =?utf-8?B?Y3Zvdnk4TmdZNkJvc042OExrWC9mT2RuS1h1VmFVcWEvQ1J0K3NpdTh4YXhK?=
 =?utf-8?B?UU0zSVJlN0YwbW0rTGlJV3F2eFdxeWlOZW83QWpnalVYM1hvMmFFc1ljMkp1?=
 =?utf-8?B?MHJ6Tm1nMDdKNHl4ZjFPVnZlVkVLcENYWklSU25tWkhRdTloKzRVWHVKQW8y?=
 =?utf-8?B?S3BsS3huQi9IaUN3RzJ3c3hvWjU1RFRGUVVOc3BUUEpFbGYwZ09tak9GTENk?=
 =?utf-8?B?Mm9uK0NaK1BJblVmY21UMEFNWFV3Ym41VDBvMDRUZTRoTVl2N1JjZXNnWmdC?=
 =?utf-8?B?cHY4dmhFQnRib3YwQW1NQWRnYmVPdEpLaEZDa05Nb3RWVlRQeDA3UXMwUVg0?=
 =?utf-8?B?TG1icy9MbTU3UmJOL1BwQU9XTG9adFRRdVlGSmdHbXpPWVJPRUZaaW81NDJt?=
 =?utf-8?B?NmRWZ1dldC8vS0VNSWVsV3Q3WlQ4MnFDdFREVHpyVndVRDJ5TTRQUEljbEtZ?=
 =?utf-8?B?a3B1alpGZTE1KzF6OGFacmswV0FGM2tsMkFxRHBraUhQakFTM1p2ZUlORlk0?=
 =?utf-8?B?cDVIQmFiTkNBbTBpSTdqamdyTGcwVkRDVTV1ZENleUtuTFMvcG5rNGFjTWJE?=
 =?utf-8?B?V0Nqek5hcStCd0xtNmdUcmZOeHl0QVhNc1dsdndScFQwaDZVRVpQSWltd3Vt?=
 =?utf-8?B?M3JSUVIxWnVoVldBa2RiUnpHcDgyektTck9DeGZpVWY5UDVwSnhsKzIrMWpo?=
 =?utf-8?B?VlhFSVBGR0ZnTjFQVXduelFvdGtKY0ZuQSs4eGNUa0kvNk9jaEh4cU5QNlZF?=
 =?utf-8?Q?0OgLoTW+SSVZE625nogszP4hN?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	qiwcZqugvgYog35mAtwlZlO+ZCARes0j4pXlmaYjJWtEXOSdw/7Qx3wTLxdgC5aZFqZqk/T3qpiiUxP6NHnDTDnzqi21aing1wJzfLCr0Fs+qlFPW/nvSS9eXL/I+aLakkN3XwxJQaaAQNSC6UZQecybXH9K330iNJOkmXwuzgi5ydQ0EyB2SHLv3EFxsh8Py5PdnZVftTKEBvGV341hceb/qPS04+126YoizDWdHVY8wS51IWNu7uK627+YTPeIxfrWIWZN9UbeKU8X4Ev0QtpBGoWBcFJDA6wB8rXDP6LoHdxfYoo+9AYvGu+rhTX1l3m3O23RH0Tkk4PYUffLX8T3mKAhaKCLnJBVraG7EptRUwiXW1PbUzIE34Qp3/iGrTM3OSCC8RTvvTI5SbNj7+gKswLYU3fRhMDnbJ2Mtfuss60tL8DKCG/jqCFvCwnsY3G/GJYAJu9b0PMp8PNkKaxOBy3O3JYcS0dkebFcS94UxMczohcS46aqUTr4HxudHZvOkS6f3B16f2EuOZG79/SmD7f99zb6B3uQApR76T5uEZ1AEOMscCkmVUpf5QbJ5YiGIhVePPpA3DQ80phRPh8KxqvXVPO6mPGkMXuh/0U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64647efa-01fc-4d82-1512-08dc7518dc40
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2024 19:54:41.6236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6ZMH85UGiizkcipk2QkGXOi0oWrbVy3EVvxmaBqyEBcPZ6p5YzAKMF+rIg8EokhBsVkI0WcVkxk+4kshPidclQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7699
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-15_12,2024-05-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 spamscore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405150142
X-Proofpoint-ORIG-GUID: StZrP23CJUj5kJycqu2WPUZ5gUEWVxm3
X-Proofpoint-GUID: StZrP23CJUj5kJycqu2WPUZ5gUEWVxm3

On 27/02/2024 23:12, Theodore Ts'o wrote:
> Last year, I talked about an interest to provide database such as
> MySQL with the ability to issue writes that would not be torn as they
> write 16k database pages[1].
> 
> [1] https://urldefense.com/v3/__https://lwn.net/Articles/932900/__;!!ACWV5N9M2RV99hQ!Ij_ZeSZrJ4uPL94Im73udLMjqpkcZwHmuNnznogL68ehu6TDTXqbMsC4xLUqh18hq2Ib77p1D8_4mV5Q$
> 

After discussing this topic earlier this week, I would like to know if 
there are still objections or concerns with the untorn-writes userspace 
API proposed in 
https://lore.kernel.org/linux-block/20240326133813.3224593-1-john.g.garry@oracle.com/

I feel that the series for supporting direct-IO only, above, is stuck 
because of this topic of buffered IO.

So I sent an RFC for buffered untorn-writes last month in 
https://lore.kernel.org/linux-fsdevel/20240422143923.3927601-1-john.g.garry@oracle.com/, 
which did leverage the bs > ps effort. Maybe it did not get noticed due 
to being an RFC. It works on the following principles:

- A buffered atomic write requires RWF_ATOMIC flag be set, same as
   direct IO. The same other atomic writes rules apply.
- For an inode, only a single size of buffered write is allowed. So for
   statx, atomic_write_unit_min = atomic_write_unit_max always for
   buffered atomic writes.
- A single folio maps to an atomic write in the pagecache. So inode
   address_space folio min order = max order = atomic_write_unit_min/max
- A folio is tagged as "atomic" when atomically written and written back
   to storage "atomically", same as direct-IO method would do for an
   atomic write.
- If userspace wants to guarantee a buffered atomic write is written to
   storage atomically after the write syscall returns, it must use
   RWF_SYNC or similar (along with RWF_ATOMIC).

This is all along the lines of what I described on Monday.

There are no concrete semantics for buffered untorn-writes ATM - like 
mixing RWF_ATOMIC write with non-RWF_ATOMIC writes in the pagecache - 
but I don't think that this needs to be formalized yet. Or, if it really 
does, let me know.

There was also talk in the "limits of buffered IO.. " session - as I 
understand - that RWF_ATOMIC for buffered IO should be writethough. If 
anyone wants to discuss that further or describe that issue, then please do.

Anyway, I plan to push the direct IO series for merging in the next 
cycle, so let me know of what else to discuss and get conclusion on.


> There is a patch set being worked on by John Garry which provides
> stronger guarantees than what is actually required for this use case,
> called "atomic writes".  The proposed interface for this facility
> involves passing a new flag to pwritev2(2), RWF_ATOMIC, which requests
> that the specific write be written to the storage device in an
> all-or-nothing fashion, and if it can not be guaranteed, that the
> write should fail.  In this interface, if the userspace sends an 128k
> write with the RWF_ATOMIC flag, if the storage device will support
> that an all-or-nothing write with the given size and alignment the
> kernel will guarantee that it will be sent as a single 128k request
> --- although from the database perspective, if it is using 16k
> database pages, it only needs to guarantee that if the write is torn,
> it only happen on a 16k boundary.  That is, if the write is split into
> 32k and 96k request, that would be totally fine as far as the database
> is concerned --- and so the RWF_ATOMIC interface is a stronger
> guarantee than what might be needed.
> 
> So far, the "atomic write" patchset has only focused on Direct I/O,
> where this stronger guarantee is mostly harmless, even if it is
> unneeded for the original motivating use case.  Which might be OK,
> since perhaps there might be other future use cases where they might
> want some 32k writes to be "atomic", while other 128k writes might
> want to be "atomic" (that is to say, persisted with all-or-nothing
> semantics), and the proposed RWF_ATOMIC interface might permit that
> --- even though no one can seem top come up with a credible use case
> that would require this.
> 
> 
> However, this proposed interface is highly problematic when it comes
> to buffered writes, and Postgress database uses buffered, not direct
> I/O writes.   Suppose the database performs a 16k write, followed by a
> 64k write, followed by a 128k write --- and these writes are done
> using a file descriptor that does not have O_DIRECT enable, and let's
> suppose they are written using the proposed RWF_ATOMIC flag.   In
> order to provide the (stronger than we need) RWF_ATOMIC guarantee, the
> kernel would need to store the fact that certain pages in the page
> cache were dirtied as part of a 16k RWF_ATOMIC write, and other pages
> were dirtied as part of a 32k RWF_ATOMIC write, etc, so that the
> writeback code knows what the "atomic" guarantee that was made at
> write time.   This very quickly becomes a mess.
> 
> Another interface that one be much simpler to implement for buffered
> writes would be one the untorn write granularity is set on a per-file
> descriptor basis, using fcntl(2).  We validate whether the untorn
> write granularity is one that can be supported when fcntl(2) is
> called, and we also store in the inode the largest untorn write
> granularity that has been requested by a file descriptor for that
> inode.  (When the last file descriptor opened for writing has been
> closed, the largest untorn write granularity for that inode can be set
> back down to zero.)
> 
> The write(2) system call will check whether the size and alignment of
> the write are valid given the requested untorn write granularity.  And
> in the writeback path, the writeback will detect if there are
> contiguous (aligned) dirty pages, and make sure they are sent to the
> storage device in multiples of the largest requested untorn write
> granularity.  This provides only the guarantees required by databases,
> and obviates the need to track which pages were dirtied by an
> RWF_ATOMIC flag, and the size of the RWF_ATOMIC write.
> 
> I'd like to discuss at LSF/MM what the best interface would be for
> buffered, untorn writes (I am deliberately avoiding the use of the
> word "atomic" since that presumes stronger guarantees than what we
> need, and because it has led to confusion in previous discussions),
> and what might be needed to support it.
> 
> 						- Ted
> 


