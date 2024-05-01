Return-Path: <linux-fsdevel+bounces-18421-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ABBA8B888C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2024 12:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E1E81C20E01
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2024 10:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16EAB535B8;
	Wed,  1 May 2024 10:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BzIrziPC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fZPknj21"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41413A1A2;
	Wed,  1 May 2024 10:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714559036; cv=fail; b=KtiMli4f5BrNpXt5Nt7k4TFSESc4fa/dfAsBypCgAe48iPpxbD68bHLYH/mrQD3IVvq2rKj0d0BFA87McOqkWYIWm8b8maknnrDoqU761vlA8BH37ufW9SVLt8AFv2PEEPW7heg09YaH8iicxbLUJPqF/xCugVApginKi5W3Yp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714559036; c=relaxed/simple;
	bh=uPF3Ae7yds8O+dAsLsUb3MKo1xH8HqmdbLVDYrWPCgE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=egEOMzb5onZTCipKugXAP9e0CtemICmGwQ74j3aHyxfVqfJk250ntpkBq7JbOBBMeCyjtQFox7mIUVwBCRS7mclDxErmWwZobbO9TwJNctVKLVdLRX8JwWtsK681dGKSqkqPaeOczB09hrxvQXBXAmxJ+9lIKcqRdwB9yMIdF28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BzIrziPC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fZPknj21; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4412ic1N022174;
	Wed, 1 May 2024 10:23:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=e5aufMp2797hvjxxWyUNTHnDGg3D8LlsRocuhZKfw1g=;
 b=BzIrziPCYbmQBycRMcJ64AF8sXG5cHNC8Sw5vPVLqlrUh4rBrlA1LN3FdZcphTDT5Ozn
 A5uGWS2eEUOhIiB3QMY8K/uom2nYfnThkq3tfnQCtrFddVC6YflDc93nxoc105irRC+/
 VZSs8mA69ErCmt1bgjQS+QzGf6fezXcNrYH5XGlveptCFzay1PZA5dXDcMF2TJiHo6uB
 W0f1/sUNhBVK5rI7U3n/4SBwvy2syL9Y7ii3+mtoR2Bmot22QdH836Y/GOA63mIYwOK3
 ZVc1YI/cB5DHbD1COB7odJer7/vYhSkYNuT/t9KeP5lnkzr2M5T0dEKZUlaUUsFw5ova tw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrswvpytn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 01 May 2024 10:23:22 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44180vJv005091;
	Wed, 1 May 2024 10:23:22 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xrqt8npx2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 01 May 2024 10:23:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XZlGO/+OvgzB6o1hpqw3s042fL7AQiVZSQN3y7J/4e1zl5EluVMhchgl3wRYEEyiOxwDeTj21jQDwVEDGmKlCnDpgE98U823bSkD6SN4NNebFBL1HG7GrAMXHq3tFl62NcWq+NOQ7bSPZm6DaEWgqjkemAfAt/qIh7lD0q8mF7sJOTooSfUHsuZVwXyP6RPkXWGU368Y8O+haMSei29HPPe3wwzrQrHM80dt271g9uJhn/gGGmA0a+ZZ6h9OjodpwVlD3CX8oY+3dH4x7lwHgUILWBZWdcrriSFYRrDn+UQIbeIwPVaCcvy2z9+qhMpDpD/NGiBiwcBAzlSxhqCa9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e5aufMp2797hvjxxWyUNTHnDGg3D8LlsRocuhZKfw1g=;
 b=ZxxqB5wxvsTxN7GQlyTOo59bfY4cPS9QoDRTUNlkhPoctLgp2oongbQND7qs5cDw64KlsZP6m3r/EmhO9IPtbyihKq028M6cBl0rwzWKCcUGp+Wqbn7qLVoBIBO5vTuLk2rxF6SXtQ0mIZ7Md6bC2VyFD3ZDs0EyYH8Th21JSp5w8+gl2Re5UO8SQoBAdaBM/aOzbEwmsGolfujOZG14PuPSyAi3Omus0Lt5+oLcW9L96juSTZDRXooGUqeys+p5VaL7GSsv7uh53baE10Bkn4mIhgcwYiTLyyXv9OJLq8y8xwNFbEaVA/DgCLx5b65E7iHiSzgN9JTfMY5ybk3Ysg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e5aufMp2797hvjxxWyUNTHnDGg3D8LlsRocuhZKfw1g=;
 b=fZPknj21AtHfYONoTXxO19ZBtG3ZotFkCMmfH+UNx5BcrxGPT4jI4G9D78Q8314yuNFKb7s2LVlVeiYtNA3XEkmRZPAhHXgjkRIHHZ5HRTicL4lPvCiotVBYdh4myZH/BVLKJ6y59Nd81FWfj7haa+gFJdb1NddhOHZKYyg8kcc=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH3PR10MB6881.namprd10.prod.outlook.com (2603:10b6:610:14d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Wed, 1 May
 2024 10:23:19 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.7544.023; Wed, 1 May 2024
 10:23:19 +0000
Message-ID: <f6a618e6-a00e-483d-bd6b-c7d58ff5b2fa@oracle.com>
Date: Wed, 1 May 2024 11:23:14 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 14/21] iomap: Sub-extent zeroing
To: Dave Chinner <david@fromorbit.com>
Cc: djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk, brauner@kernel.org,
        jack@suse.cz, chandan.babu@oracle.com, willy@infradead.org,
        axboe@kernel.dk, martin.petersen@oracle.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, jbongio@google.com, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, mcgrof@kernel.org, p.raghav@samsung.com,
        linux-xfs@vger.kernel.org, catherine.hoang@oracle.com
References: <20240429174746.2132161-1-john.g.garry@oracle.com>
 <20240429174746.2132161-15-john.g.garry@oracle.com>
 <ZjGVuBi6XeJYo4Ca@dread.disaster.area>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZjGVuBi6XeJYo4Ca@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0041.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2fe::12) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH3PR10MB6881:EE_
X-MS-Office365-Filtering-Correlation-Id: 191307d0-d67d-4167-e4d1-08dc69c8b8c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?cTBsRHMrWEwwL2V4enNWK1duTDVCbVA2V2M5b0QzMHU1cXNkZEptSGl6RXhC?=
 =?utf-8?B?MzZ2Y2lCU1hOa21qY0dwck5ZY09lT2kyTitwVEYzQWhOZGptL2FtNDB0RjlZ?=
 =?utf-8?B?VVpjMm01M1diNGtZWHJYZUhlb0tDS1pHRk5ndGRuc092emZDYXBoVWlJY0dt?=
 =?utf-8?B?SlcxMTJUZUFnTWJ3cjlwR21CcWJRZ2ZOVmtUYjMwOU9yOURJZ1NWVDlmdmgv?=
 =?utf-8?B?R2l6ZytlM2ZKbDJrM0tHaUNDWVk1NXFYRDJaNzlkdFJRelZZaWJqem9vNGFi?=
 =?utf-8?B?M0dsWTZOKzFUaEJoRTZqb2krVHJKM3plaWdLVFFTbEcyNzRibUdQYXE1MHZw?=
 =?utf-8?B?UzlMaWNmV2tubEVjdHNhVHNsNHR2bCtUMWVVcVNhYUxCdGxqTWRFYTM1ZmhC?=
 =?utf-8?B?S2paVW5aYXhPM3l3VFQ4VC85YTYyeUxWWUg5WWFhNnJsRUZuREhSYVlQSWhj?=
 =?utf-8?B?SHJNSVRBd3RoaGlKeEN0TW85b1FmMis2MDM0N2NlTHJKallDcm44d3ltc3pr?=
 =?utf-8?B?S0x5NXllN0NUSDNVVWkwSVhtRDFNZS9wSzlqeFRXUmpGZ1JYR3BQdzhMUmpJ?=
 =?utf-8?B?Wk93M0ZlTlEwZjRPRlFDd2R2VTJLdjJtOGhBbVFIaElpQXY1M3ZYMXgyYjVI?=
 =?utf-8?B?Zi9RcXpuTGJuSVVpWXlDVE1aMzVLNUpTQlBFbXBJNFRpMDhlWlNkOGQrcGc0?=
 =?utf-8?B?Q2Nuc0haOXk3dVplZWpJZWhPd1VuT3p0YkVvNExMSSt0TnRENzArbHJxT1VK?=
 =?utf-8?B?VDRJdXllRzQ2eXQvbXpqV1Jqcys5Uy8zeW1GV2UyRzNFb0VtRk02M3hFd3Bn?=
 =?utf-8?B?WGlRdFBvTWhPa25ReXNrZ2owUVQyY3hyTHhaK3BHU3B2djBUdkNvOUt0NHVx?=
 =?utf-8?B?K0RjZUdXNm9lWDRSZTZuRlZjRjZLcFo3WG1aYk9CeU0wUzdOZHR2WnZHWjVO?=
 =?utf-8?B?V2ZteGI5YjhEMG9zazFGRUd4UExXdjFkM3VkT0J5bmtNSlJIS3JJenRucmIw?=
 =?utf-8?B?WElTa1l1VER1ejhNNnRPeHBZcmorVkVFdllyNjkvdFVBVEUvc2hOcWFyaUlB?=
 =?utf-8?B?QzZJbU01R05sc2ZHQ081bkt4b25uZGg4bnA1azZiRWdCUnJTOGoyRFFBV1U2?=
 =?utf-8?B?TjFIRVhpK211LzVrNlVNemJqeXJSSG5SZGZ2dnl0RVBGbjhMKzdyNTJDWHdt?=
 =?utf-8?B?LzJWcFN5RVJ2ejVVYTBTRUZaSUR2UUdJeGlCZGNzakV3Si9LTm5nQWJSYzZ5?=
 =?utf-8?B?c25zOGNTRVU0ejJCZDYwMDJHaUxwMnh2YkJTVFpKUW1UVkxLR05TNUhMakRp?=
 =?utf-8?B?bmlVbWp6MTdiTnZLeVB4clZSUklrQng3TnVaLy9MSmxDQ3RZbEw1b3p1Z2hN?=
 =?utf-8?B?YnBVYlNpczVpdGdKdFJxWUFQMnBjRVcrMUVmeHlmL1RrVVpIdTlaa0taa1Fn?=
 =?utf-8?B?ekFZallCa29MV2MwclpVUzZPdlFXL0dWWUE0ZTFQaERUVDNVbG5UaWttblBV?=
 =?utf-8?B?TXVBSWRzU0d3M1p6L2VKSlVRa0hKMnNtYkpERklZbmo5eHpNUjVreDJGL05w?=
 =?utf-8?B?Y0Q5azJ3VVkyV29IeVI4Y2lwQXluMUsyaitjOFhxNnZIb0lhZjhoTFZEb29W?=
 =?utf-8?B?aGFKQk8wMzVNMzFnUHlnMWl3T1hjVTRWZGN6dzBWVU1zVVE5dnFxbGNQYjYw?=
 =?utf-8?B?Y0ZZVUw1RDV2eGhveHRHTTZ1WTZIMlRGaEU5cFFKUVlIUDBTbU1ENTVRPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UE5oZC81bEVpMXNGSWhwN0Y2L1JIV2pmcTU4MVBZYXhyaDg2T0dsaVFkN0sx?=
 =?utf-8?B?N3k2Q2NlRWo0Rml0Mkw0cGFqYVkyeFpRc0c1OFFUbGsyVDcyQnMyVUc3ZmhF?=
 =?utf-8?B?RkZyQlV1aWZzV0V2Vjl6L241ZjUzZktDSWF4bGRLTzJmcTN5Nzlpdm5vV3FF?=
 =?utf-8?B?dHBGMWhnYnlPdXVxWTBQT3FNZFBXNWd5LzNpZks0WTVKT3dFK2loaWdTbkcx?=
 =?utf-8?B?VjdKOHZuQ1FLRnhJWUFXWGxoamd2ODRvSDNrai9wY29iaDJiTnIvQlhZSzY3?=
 =?utf-8?B?RW9FdTk2eVRhL2Y3dHVGN3RrWXJ2SnhTVzI1RjM1N2E3aWc2MC90V3dGUWlx?=
 =?utf-8?B?RzlUUmNPUUhjZkdNa1ZsL3RKL3h1UDZIUmVtNkZxUnBLaWlFQ3BSY2ZnSWE5?=
 =?utf-8?B?WHdrSm9vekp1N285aTZ6eHVzcTB3NnJzcWc1SGxTMWdoRmhxdkdIdWF3N0du?=
 =?utf-8?B?eXErNUlhZ2J2cUphQ0UvRlBDelp5dnNmMEwxcUFuY1pwTytENDk5Rk1vaXp1?=
 =?utf-8?B?OE5HQkVGUUpTd3dIUjgwQVpFeE5Yc2dwQ0M1cnArZ0d0QnY1WWJrWGd4djVh?=
 =?utf-8?B?c3ZRYkVQUFRtNmt4RnlYTHVwcjQ3dzZMbGlqM0hlRXk3RVA5MjlUSzBxdk1D?=
 =?utf-8?B?VmZLd1grV08rekVMNFZ4RGdvc0gyWEkzYVo2NU5qMGRqTTJSQ1oxK0NIejR2?=
 =?utf-8?B?NW5BRlhTMmdxdGRlZ0NndUNxT3JmZXk2REQzNi9BbGM4a1B3RjlWenNSUE1o?=
 =?utf-8?B?akRuR1VNQlcvWkdtUWtTQXBIa1NQbnRMVXpuanZHcmtYblNVQnpTOTRuenZs?=
 =?utf-8?B?N293ZW0rNkJHb1E2bmNlNE9BY3ZEZ01pc01SUndlN0VsZXAyOGhiaGZybk5N?=
 =?utf-8?B?OFdQR2tjUXd6ZW9Tck9KMU9VbEdmdG5zc1RtWWhvSHE3YXlnZTRGNE1DNmdP?=
 =?utf-8?B?YzNORWtBcGk2UXZua0VpblJ3Q0g3QVNJMVRqOEVJZXQ4NjJLcEJmRUdXcG43?=
 =?utf-8?B?ZVNkMG1HVldnK2MraldwQnpKbFNrclZUcXVWbERmUTZ6OGZ6QnhuQ2xMWGZN?=
 =?utf-8?B?VUJ5dnJWZkZLWFFENGgvYTZpZXNuRkxsOXNaRW5EN2hwWFZuWDZLTFFZRFZX?=
 =?utf-8?B?K3FDNTFEUTlMV2Q2RjEyeEJ3ZXlMU1FlVHRkcGxxL0Q2Z2lhS0g3MTdDcTFi?=
 =?utf-8?B?VUZBdzhKbGdtdUJyWC9JMU9Fb0pvb2w3TFhLQjJMYTVaUEsyMW1Yd2w4T2Ey?=
 =?utf-8?B?aTJpbHVUODdsUEE4NHVIUEtJZFZyanZaSGZFTFk5MHBNQkRJeFBSVTZxbHVr?=
 =?utf-8?B?bVl3NjRvVG9NempBMFpRSDNOd3hMMjNsTjc5dDFmSGdaT3RpQlgzNy9ZRnB2?=
 =?utf-8?B?YkUwa0pjcDJKaGxxMGEzWExvTElraU9iVEtTcnlIZ2djazVwaXhCdDM4eWFP?=
 =?utf-8?B?Qmx3b1dqZE5NemJ3dFZNSC8vc1NIODd6SDFRL29tOUxlNlZnWHM0L2daalA2?=
 =?utf-8?B?R01yRTZOMXhVSVVQeE83VEhJRysyM0kxTlVXZ0FoR2U5akVkcDRZVEJ0bWpW?=
 =?utf-8?B?RGQvOW5iUytXMlJiOHBnTFpUR1VHSnFLbGpsS2IzMnBQeDgwTmIrNWtlY0tw?=
 =?utf-8?B?TDRReEtDUFNHc3RnNTRsQnVuS1duWUJDeUxXZGhuUVcwUGovRmduNXd3UEd6?=
 =?utf-8?B?QXBwd2Z3eThZWXVCNHNudy9wWVlQaWVFdVA1UHJXVDdnMnRuWTFpN1FWL3pY?=
 =?utf-8?B?WlQvYmNwWGV5MDBHT0V6NWRINGlyckRNR0lTR0JWQ2QxWjlCdjl2M2RUclpT?=
 =?utf-8?B?REE5UVA1QytlQVlzSkp0anhrZHZVendXcXNpQnNCQkRpdGRCeEw4UDVsVW5J?=
 =?utf-8?B?M1NBNFk3ejdFaDAxU3lzOWk0QjV6bEMzcElRc1RxNEJMMHpqWDVBSkY2ZUx3?=
 =?utf-8?B?a3JzOUpXU3Q5QlNiaU1hK3I5aHF4RzhkT21aM3NDeFhybU1kbFErSmx5eFZj?=
 =?utf-8?B?Z0p0T2VvU1A0VnRhMW1IclNwanE3ajdIdFBXK0V2UkxJL2lZdmd3ek1zR1dR?=
 =?utf-8?B?djBTdUhFU0g5eUdaNXhZSnFFSVRheE15SlJEVzI5YTZaMnoyRWR2VGVBd0VK?=
 =?utf-8?B?REt3VHdNa3ZmKzJub3Z3cUovekV6a0J6T1l5TDVHZWxsVElvanNUK3ZuY1oy?=
 =?utf-8?B?SkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	iuim8AvclCNKJOkpWU0isXy37ZWo0C52Oxrv9v5iSu/O3qZ1PYxFahpwWqRoAFjBhjgt6m35WITbZ08SdM16oFANBy823rERNKUGw9TJdQSz9/oaOoef8ilK9/RHXBCit7Pl+vAljEY7EXJmFu8nKQ+HL0Ft6oJ+Wzu842U9IGQKLJpD2BDDHX1smqH5rg0btOgNeF2XiinHUUFEPyKFXBKkRzAsCAKqRnWA/oW9iaTfmY2Vcs/8lutXbBIgP1s4Y1iPLh1DGWvMYsJIdLCUGOhQPGKBE78q2i/NLw8IbU3FEM8OF3/sJWQ9CgXKarTgkBxpANYe+VOUrOuht/2Fuj81z9bLuFQCE0tI3vNrxHj9nIy2ukO/r7xjVZD3J6IVNmKI3d6KiWTrPHjbSDFI9Kab8u/2su76y4Tx5UzKaVOySlpNkZxkuuzjWsUCrEBGwOdru5wlFcMWTooVLeIagcWzpx+o6TPPgeNy1fj6gHWVhx87RXFXsbwRr3QdU5WBSa4P5YOIkVeFmd9agyZ4JF73pFdeH5SGxVht1ZL9l33lArCf8OcVFW5SsoqfFnNC1vmifiielqBHOtLeM6uwv5bkS25NwLGN1+oEQ4wCG3Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 191307d0-d67d-4167-e4d1-08dc69c8b8c6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 10:23:19.6203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JptDwRr7fIaT3Dwp4vE5lO3a0/vevVWeWvfJRmZy/0oaOm7fCcJTcodFBNZMAKJBPyasNKrKYle1WJdNMLVg4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6881
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-01_10,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 adultscore=0
 phishscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2405010073
X-Proofpoint-GUID: lWdW62ODyFIiY4U72HjnrJ6u64mU2SdZ
X-Proofpoint-ORIG-GUID: lWdW62ODyFIiY4U72HjnrJ6u64mU2SdZ

On 01/05/2024 02:07, Dave Chinner wrote:
> On Mon, Apr 29, 2024 at 05:47:39PM +0000, John Garry wrote:
>> For FS_XFLAG_FORCEALIGN support, we want to treat any sub-extent IO like
>> sub-fsblock DIO, in that we will zero the sub-extent when the mapping is
>> unwritten.
>>
>> This will be important for atomic writes support, in that atomically
>> writing over a partially written extent would mean that we would need to
>> do the unwritten extent conversion write separately, and the write could
>> no longer be atomic.
>>
>> It is the task of the FS to set iomap.extent_size per iter to indicate
>> sub-extent zeroing required.
>>
>> Signed-off-by: John Garry <john.g.garry@oracle.com>
> 
> Shouldn't this be done before the XFS feature is enabled in the
> series?

Well, it is done before XFS iomap zeroing support patch. But I can move 
this patch to the very beginning of the series.

> 
>> ---
>>   fs/iomap/direct-io.c  | 17 +++++++++++------
>>   include/linux/iomap.h |  1 +
>>   2 files changed, 12 insertions(+), 6 deletions(-)
>>
>> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
>> index f3b43d223a46..a3ed7cfa95bc 100644
>> --- a/fs/iomap/direct-io.c
>> +++ b/fs/iomap/direct-io.c
>> @@ -277,7 +277,7 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
>>   {
>>   	const struct iomap *iomap = &iter->iomap;
>>   	struct inode *inode = iter->inode;
>> -	unsigned int fs_block_size = i_blocksize(inode), pad;
>> +	unsigned int zeroing_size, pad;
>>   	loff_t length = iomap_length(iter);
>>   	loff_t pos = iter->pos;
>>   	blk_opf_t bio_opf;
>> @@ -288,6 +288,11 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
>>   	size_t copied = 0;
>>   	size_t orig_count;
>>   
>> +	if (iomap->extent_size)
>> +		zeroing_size = iomap->extent_size;
>> +	else
>> +		zeroing_size = i_blocksize(inode);
> 
> Oh, the dissonance!
> 
> iomap->extent_size isn't an extent size at all.

Right, it's a poorly chosen name

> 
> The size of the extent the iomap returns is iomap->length. This new
> variable is the IO specific "block size" that should be assumed by
> the dio code to determine if padding should be done.
> 
> IOWs, I think we should add an "io_block_size" field to the iomap,
> and every filesystem that supports iomap should set it to the
> filesystem block size (i_blocksize(inode)). Then the changes to the
> iomap code end up just being:
> 
> 
> -	unsigned int fs_block_size = i_blocksize(inode), pad;
> +	unsigned int fs_block_size = iomap->io_block_size, pad;
> 
> And the patch that introduces that infrastructure change will also
> change all the filesystem implementations to unconditionally set
> iomap->io_block_size to i_blocksize().

ok

> 
> Then, in a separate patch, you can add XFS support for large IO
> block sizes when we have either a large rtextsize or extent size
> hints set.

I hadn't been considering large rtextsize for this. I suppose that it 
could be added.

> 
>> +
>>   	if ((pos | length) & (bdev_logical_block_size(iomap->bdev) - 1) ||
>>   	    !bdev_iter_is_aligned(iomap->bdev, dio->submit.iter))
>>   		return -EINVAL;
>> @@ -354,8 +359,8 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
>>   		dio->iocb->ki_flags &= ~IOCB_HIPRI;
>>   
>>   	if (need_zeroout) {
>> -		/* zero out from the start of the block to the write offset */
>> -		pad = pos & (fs_block_size - 1);
>> +		/* zero out from the start of the region to the write offset */
>> +		pad = pos & (zeroing_size - 1);
>>   		if (pad)
>>   			iomap_dio_zero(iter, dio, pos - pad, pad);
>>   	}
>> @@ -428,10 +433,10 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
>>   zero_tail:
>>   	if (need_zeroout ||
>>   	    ((dio->flags & IOMAP_DIO_WRITE) && pos >= i_size_read(inode))) {
>> -		/* zero out from the end of the write to the end of the block */
>> -		pad = pos & (fs_block_size - 1);
>> +		/* zero out from the end of the write to the end of the region */
>> +		pad = pos & (zeroing_size - 1);
>>   		if (pad)
>> -			iomap_dio_zero(iter, dio, pos, fs_block_size - pad);
>> +			iomap_dio_zero(iter, dio, pos, zeroing_size - pad);
>>   	}
>>   out:
>>   	/* Undo iter limitation to current extent */
>> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
>> index 6fc1c858013d..42623b1cdc04 100644
>> --- a/include/linux/iomap.h
>> +++ b/include/linux/iomap.h
>> @@ -97,6 +97,7 @@ struct iomap {
>>   	u64			length;	/* length of mapping, bytes */
>>   	u16			type;	/* type of mapping */
>>   	u16			flags;	/* flags for mapping */
>> +	unsigned int		extent_size;
> 
> This needs a descriptive comment. At minimum, it should tell the
> reader what units are used for the variable.  If it is bytes, then
> it needs to be a u64, because XFS can have extent size hints well
> beyond 2^32 bytes in length.
> 

ok

Thanks,
John


