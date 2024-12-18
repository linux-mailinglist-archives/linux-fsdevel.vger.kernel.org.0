Return-Path: <linux-fsdevel+bounces-37743-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B83C69F6C1A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 18:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A0051882354
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 17:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC4C1F8F0B;
	Wed, 18 Dec 2024 17:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HSWgVayx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA0C1F76A2;
	Wed, 18 Dec 2024 17:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734542055; cv=fail; b=dNUaDzRNVt3dDCasDt7NEMnfe9zcjhd8GkpB+GS8Hl/B5gXJhIONeMGFE/aws/8NrVLiskMfyVF3qnB8b5hLKHJ0ItW76bu5BO2/VAmU6Xwuz9vDhZ9INRR0ZE95Uve+pEQK2QnaGxqQ2zW0geZcx6bMO6/e2wyl5vR1y6oM458=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734542055; c=relaxed/simple;
	bh=T37FHLuglsbp/Nr1lNe8WGCK8od/5OmUcQBSj1T6f14=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QM5Q3YwnjvbPKRgsWAVppPQrJYukTG8KAB7bYjRx48/IvbPZAe1JKJtMtLs/2pQwfp8yQZTZwjQfEAKV3ULtSh896sAi4ZgdfTigK8a7u5tY+S1lgSMVc4T1W9fk3XNi981Vi+rGSifc2piC1of4TOLf7gg1LCr78xlOOx+m44Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HSWgVayx; arc=fail smtp.client-ip=40.107.94.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DfmOXsANi7oDlGqJPS2CYnlTSe18vtZL9iWcTKCjFOwqxVnl8a9v2vMCzUV7k0IwWWMam20rn7M4N7OK/h2kF0k5JVHniuG/oNhs+YJ28Ik1hfsEtVzHLS/+RoGUHt6JVceJW+bqrK0+GFrrqyRu1ul3hEyClQ6eiycfCa3YkNl/v+VIE+7Coa5hXMggIEVNR81KjaNuLx+ddKnZ+stUK+1N3qoOPDUWUxM7HaOZKDF8l8Nch+4t95Pu1RHxtohT/CbU6vaNskOd0wEWQycyf849WYQntEbbXqmohHOycJlXI2PzS3TpzU/GqeTr8Rt+cm3ul5HomgK0gfET4/OJmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mLuK7BzHrFZ0+91yiycrQHu3KNhCCzYO2Aoc5js9mGY=;
 b=i/xxAKM+TJyVnpduj8Emdn13JYu6G+SwRtxXfAFlAoTBYgSmfuIOo9TK0WIG1EVyV/HHc9yz8EQpxpGsnR8Enz9i6pi4whapi5eza5cxggFesHmNvKOLApWKjJ4Dn4WSz7tfv2kX0k0O8eh/A59y2Xa56ZBnyt8WTLO166tQWIZCV4Mp+aCMHhRaL2TaylFbVLMZgXob6GastUcQOqvygqnoLPGUNLbdua/PoIX0V0slukeyqniqr0BEDAQ5glRkQZFUJwqeTda9rBfTSMBEWUo0S4LklAi85OL1n8GoEXk/P3kaqEY4GEFivwe/H9Z1BxTXriFeTDp1Q3k9SbewoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mLuK7BzHrFZ0+91yiycrQHu3KNhCCzYO2Aoc5js9mGY=;
 b=HSWgVayxkz1sPmijv/m+OUsK1eipGQ8yC62KmEnnPSZHeykUmmSD6BpfiRi2WBwNPtHQQx1FCttXQCxi8pb2wcchvRzqH6kJOJ89y7Nnlry+a+XSj79aPm/302CdCqtv9kmvCvkmeqYkWZePQkByuSrXahv0eD2Q/bUrV1IGraJGFLSTl8aus+zxIDh77eqkQLdds6wGfOb7jje7Nh6PtcHZ1b12ymmim/qzzcfHI6BpFV90rbwOGvDzDygmFQaNe39npYCxwItIGRwDr1/2l4GTDwJyz6EwHavcvweq5fGdS/0pbpeZOJjfkVLo+h4OMhHY+4Re95RtHfynRc8MUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by SA3PR12MB9157.namprd12.prod.outlook.com (2603:10b6:806:39a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.24; Wed, 18 Dec
 2024 17:14:12 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d4c1:1fcc:3bff:eea6]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d4c1:1fcc:3bff:eea6%3]) with mapi id 15.20.8272.005; Wed, 18 Dec 2024
 17:14:12 +0000
Message-ID: <d6abe503-10d5-4e7c-9831-d64f010aab7e@nvidia.com>
Date: Wed, 18 Dec 2024 19:14:02 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] block size limit cleanups
To: Luis Chamberlain <mcgrof@kernel.org>, axboe@kernel.dk, hch@lst.de,
 hare@suse.de, kbusch@kernel.org, sagi@grimberg.me,
 linux-nvme@lists.infradead.org, willy@infradead.org, dave@stgolabs.net,
 david@fromorbit.com, djwong@kernel.org
Cc: john.g.garry@oracle.com, ritesh.list@gmail.com,
 linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-mm@kvack.org, linux-block@vger.kernel.org, gost.dev@samsung.com,
 p.raghav@samsung.com, da.gomez@samsung.com, kernel@pankajraghav.com
References: <20241218020212.3657139-1-mcgrof@kernel.org>
Content-Language: en-US
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20241218020212.3657139-1-mcgrof@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0128.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::10) To CY5PR12MB6369.namprd12.prod.outlook.com
 (2603:10b6:930:21::10)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6369:EE_|SA3PR12MB9157:EE_
X-MS-Office365-Filtering-Correlation-Id: dbfd4a4f-e8c9-4ac5-4833-08dd1f876417
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WTVxZm82ekFSV0ppMVRESVNwaWFrNTFOUGtBdk5KYnNHZUtWcmsxMWtieVV2?=
 =?utf-8?B?SFdoc2NUdEYxZGlNYVMyNzZoaHNsV09rU0lNU3o2anp5dDhMSjNKRjFGaWha?=
 =?utf-8?B?RWJFTmY2TkhqckM4Vm1Id3RUUG5Tblkwckt4WW9jeXZvNkNMWE1OR2NHVXZq?=
 =?utf-8?B?ZWRuOHUyTkpJUjlqc2dXOW4xcDNqeG10QXl6NnJRTFpxcE84SDRhSzhkb25L?=
 =?utf-8?B?dVhxMzk1d2I4SFVvTCt0MFhLdndvSjY3SzdMSmxiOHhGcXA3MjZHQmxIQ1hv?=
 =?utf-8?B?ODZaYXBkVFl5ZHFpbC8wbHZTMjlqbXlZZUtpbm9rYW41Q1hzOFJZTDNFcnVU?=
 =?utf-8?B?aEdtTXdyMENzTlVYZXdUK1dnZjNiVWJUWnpKaFF4cHNJUjFHOXNRQzNVNGJs?=
 =?utf-8?B?ZEQ0OE9XckQyRmhFdUFhUEMxRUJiMzBXVFdJRmZISzhCUGJZSmFEQm94NFVG?=
 =?utf-8?B?QnFvOGJ6K1pDSklwZW5Fakk4VHgrS0tkSFBib1ptM0tKSnN1WDRIeVJVdFVC?=
 =?utf-8?B?czhSUnZOV2dJcnplUFpPN3FBSFdWNFRaeEhudThidjBkdTVJeXFaellqVjQ1?=
 =?utf-8?B?aURpT3dhNjlNbmJ4Ymh1WVdFSTdNV21OeGhidVNQUmZZVjlJbVJ6MEhkeFBt?=
 =?utf-8?B?OUpCaE0vaDRxOWc2aThuVUZuZ281K0ZjeEc3MGNiNk9QeUpKc2lZT1Q1Q0Yw?=
 =?utf-8?B?Q055MjZScTNVYlk4NW83MGxUMWErVTVxYUp3TFUvd2J2ektDamExWjZIenhS?=
 =?utf-8?B?SHl0aW9OSG0vMStMeS9MeGw2YjNsbVVJRXhSWlNOVFdodWM0ak9CWm9iZi9T?=
 =?utf-8?B?QytyN0c3ZUhsRXd1L2NCWlh1cDUxUzU3TmM3a2kxeGV2bUxVaFFTUWhGUlRW?=
 =?utf-8?B?ZDVFQUc1ZXd2SWEzWUFvcVU1aXdqVDZrbklxYkpRdmIzOC85UFAwVi9qZWdR?=
 =?utf-8?B?TTV6eTJmUjBWMlNqS1h1R3JqM3cxSDZrSnkyN2V3ekdJTFM3NUhqQWxkTENF?=
 =?utf-8?B?ZUcybjRSdWk0RTd2bXkvaEJxVUUxRnRNcGk0cGJlcklzVHZRRUNUS1dEN0NF?=
 =?utf-8?B?U3ZYZW5kYVBXK3MrbVd2MUFSekxiQnVWbHFJRDFCWE5LRGpTQkV5cU9NbDd3?=
 =?utf-8?B?cnpNN25pd05pL3RCR3N0YWx0N1pyTS9sb0cyQzVOZUdPWWdSZ3VpK2NoMHJH?=
 =?utf-8?B?UnAzcngzN094cHdvWUtrRENPOUdwL3ZudmZIWmRLc09lYnNGTE8xVmN1dDc5?=
 =?utf-8?B?KzY4b0xzbjljZGM5YnI0alU4cG8xMlFsbWl1c0Z3UmFUODNmQ3dFVlNSQTNx?=
 =?utf-8?B?WXNSNGVVdjJZZ3hPU09YOE1DMVFndElNdEJMWDYyVGg2NVJCMGhYcVNqcDIr?=
 =?utf-8?B?aHgvOExBSkUyRHh3VG1maWE3UloxVjBWVExNTTJCcDlHMVlBcG55Sjh6V2VF?=
 =?utf-8?B?MG0yK0FXMDRmNzdsS3NURHZiME5kdTNOcC9xUTQzc1NMdTNDa3QycVp0b2NG?=
 =?utf-8?B?a0RIa0Z6QVJDZHkwU3B1QUpQNVZaK2lCb0tzcFlmZXpXM1JualRncHJET3Ur?=
 =?utf-8?B?Q3diYm01S1EwOWNIQk5UZmgrOWNjNUZMb1IvT0p4L1hZT0FJbkZrTFo0MXpj?=
 =?utf-8?B?S2ZsYUljMVpwazRidStTWUNjVURTTmYrSjFqcFdEOHFjdnRCRjhUUldhcTcw?=
 =?utf-8?B?azJtUDlxSUFkd3g1U1VvYzkyVXhGYTJJRFEyV1lkdmFUVkxXamg1YU91WXJv?=
 =?utf-8?B?NXphcXpia3BTMTVYQWpMclJ5VDY1RUxqQ0JreEFkVExwcXNRbnlUWi9rTXhJ?=
 =?utf-8?B?VmwwcTg1WDNIZ3NFcVRad1RwNExnZE83N0NzYWFTaGdsU0p5K0o0bmRtUWJP?=
 =?utf-8?B?aDY1OWhhRnNLK1drem90ZXlFNFYyeE1BVlZ4eHFwN2FIcUh2Q1ZJZXg3cHd5?=
 =?utf-8?Q?EAnLAxzrXzc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6369.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UTVhNGM4YmVOdWNVNEJZbVNzQ1BxNzNPYVU0WkR2dG5NMzJ4MXd2cWF2RWZo?=
 =?utf-8?B?RlI1ZGxETzhBSUtQWS9oMG56cVlRZ2FsSGIzZHlicFM4cy92ZDd4MVZUK1dP?=
 =?utf-8?B?UUV6S3dLSUJzRG4zYnd6NW5PMmZxNXZCNWhUOUNyY0t4NGdrU3AwZG1jWXph?=
 =?utf-8?B?U1hsb0NTOENPMjRNU2NxNXo5a0hIN1pXQ3BXcE8xS0tUcVkrM1hUaWJmS1Z0?=
 =?utf-8?B?K1hZdDNBcTJQSE9kZlFVL296N09PeTFlNFcxQldiaWY1MUN2Vk56RUNZcDBB?=
 =?utf-8?B?UVRLSVJMb2g3cndaZXhnZlRBQUF4NEVKcGJHeWlsb3NTd05BTTFHcWFPSHNN?=
 =?utf-8?B?RzBFMExjWDkwWE5jMGxpWktFNFN4WmJzS0NpWS9sQm9lTUNyc3BqMFNwMThZ?=
 =?utf-8?B?NWdPNWN6U3ZyNEZoYnJGVzJ0YzlsRGh0dEdEc3Z6RGUyUWFqNTVMOWQ0Z2xN?=
 =?utf-8?B?WDFYTDg1MWZaSVNCdDhjZ1JYSHNZYjROV0MrQ285WnRRZVNLNWNUcEhVdVhu?=
 =?utf-8?B?R2RQa3J3WmU2NStzTGNXdWUrcFVMUDdrMll4alp2NGhXU0tDR1FyL1kvTENJ?=
 =?utf-8?B?UlRraGUwMG11dHppbFlIdG9HYis1QkNWa2RFbTl4RGJ6dXMrejYyR3llSFR0?=
 =?utf-8?B?QXN2QUlrUjJ6bUtYaXBqWnQ2TFA4VlFrZGVoMTBTOXRiUmNXWG9XYnRoWUR3?=
 =?utf-8?B?UVFudEs0elpOR3VqSEgrMXZGaVhKU1dPNmZWYUdjRHl6dmZ3L1o1WjRtTDJ3?=
 =?utf-8?B?a0hFMnVMUk5rR0RHTWVDVGxRVDZNZ0NDVUlaWmw2YVpaN3Urai9IOHhlMWxQ?=
 =?utf-8?B?ZVRvN0N4eEY1OGpOeUdmVjVXTXdkbU1MZkVEYy9BaVRxVXpvN2c3QmkwUHBB?=
 =?utf-8?B?SEdzZ3RHc1NOWEdVdmxyblkxUjI5NUlWWHVCN045SVJJYW5QR1E5SHEvbklw?=
 =?utf-8?B?NVBFbFRLaWhORk9NcDUvV21WSDdjUHRLbHVWTDVQTWFLN01YdjJvTG1NMFA0?=
 =?utf-8?B?RTI2SDlXV0lXdTJTUHMxZWtodlNVcXFOVGxiWVNyemtObXYwbjhyeU1VTUh3?=
 =?utf-8?B?OEMrNUlzMVBQY3A1S1pSZlo4YThNYWlSOFo2ckhTZmN2YkRTTElBSmFOZmEy?=
 =?utf-8?B?c0VOVS92Rjd2WVBDaWN3b0NOTVh4cEs3UnVDSkwrT29HS3pRZFM1Y3crVm1G?=
 =?utf-8?B?dlJicmtxY0tCV0txWWJoVGZBTzFSbTduY29YUXp3L0pCV1hFZytaQnJaVUdl?=
 =?utf-8?B?MUZPeVZrNFhZYlVjQzYwYlU4bU5CbjY4WkNnN1MxeHpDVEQ4R3NCaTJTNXo5?=
 =?utf-8?B?SGdiMlVjNXgrTHJSK1I2SnFoZUhFdElSekc2TW0xdWxkdVRQaURLY0J0WVAy?=
 =?utf-8?B?TXpkeVNGd3FkUE03SC9PcytkUUxIWE9nOXJJSkpIUnNaNDNYTWZ5UHdpSk12?=
 =?utf-8?B?czgvRVcxTUpnTTBQdHpETzBhNERlYWR3NU1EZFFPWXlWT2I1N2lpTEtLaHJj?=
 =?utf-8?B?VG9MSGk2SndtbHRhd08rS3ppQ09sNEhtaWI0MGdtem9WZzlUTU9UaG44SGpa?=
 =?utf-8?B?OVJCa1JhL2Y3eHc1Y1RZMHhmaE1NWnZHUW16bUpGcUtBMEVuMXZQdDB2Ynpp?=
 =?utf-8?B?OG9oK2xZWDB0citvSFdzTXlydDVMK1hsZFJjN3JXaWd3RzlJRkU0Vm54V3dW?=
 =?utf-8?B?S21IcnZiNkdjTStOdklpNWhBSzlrRlZTSUU3Z1hXS2F4V2RSTlc3cUhhdzQz?=
 =?utf-8?B?RktQWnFlSUFGL04wTDMyaUJTQURqM212bGd1dyt3ODIrOFF6dE5ybGJIbjZV?=
 =?utf-8?B?WklQMWRtczl5WG5mdmF5NHM2a2psbS9pM1FmSWJwOGZWQkJHd2IxTWVJV0hU?=
 =?utf-8?B?ejJnT241NHdFaVp5ZlpCYWRXUHVMczlnS0phS3pJQVdPTmtCTUUxbUdBVGNN?=
 =?utf-8?B?U1RySHA3U200VytEVXpnakhiM0cwenhnRFRSZkFkSzNYWGc0eFI2ZzU2eFlY?=
 =?utf-8?B?QktydEdUZnVVYXpqdUJGbGpNVHhybFVQc0NoMUhVcnNjRlllK1pzWTVWMXNv?=
 =?utf-8?B?SDJvQXpSNXBJQnNjankrRi83aWVodEFuODRSTHptZzhJSmszTFVGRU9VQ0VI?=
 =?utf-8?Q?TczGlrhLD+EwgZtTSfdqCjYHN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbfd4a4f-e8c9-4ac5-4833-08dd1f876417
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 17:14:11.9500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CJb4mDLw3QggZGM+zH/cUD1e0/b1IiHGe+ejBwklhyTw7V+y4ckRRB4MHGOYRSS7PUiQ6axDqQtNgJqcbief0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9157


On 18/12/2024 4:02, Luis Chamberlain wrote:
> This spins off two change which introduces no functional changes from the
> bs > ps block device patch series [0]. These are just cleanups.
>
> [0] https://lkml.kernel.org/r/20241214031050.1337920-1-mcgrof@kernel.org
>
> Luis Chamberlain (2):
>    block/bdev: use helper for max block size check
>    nvme: use blk_validate_block_size() for max LBA check
>
>   block/bdev.c             | 3 +--
>   drivers/nvme/host/core.c | 2 +-
>   2 files changed, 2 insertions(+), 3 deletions(-)

Looks good,

Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>



