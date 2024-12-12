Return-Path: <linux-fsdevel+bounces-37138-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCCE9EE45A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 11:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59D7C280E80
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 10:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B8F21148E;
	Thu, 12 Dec 2024 10:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TXwvI+nw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ECuZ/Cen"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B12210F60;
	Thu, 12 Dec 2024 10:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734000042; cv=fail; b=s/7TWVT78r5Ezf+iayWDjM6XHvu98odFBnrN/e5FbhIxI8SSrkeCkmlJFSX9yEfiySbqqR1n3yXCxEoZ/NSod4ZQknvXyYxqRbU9Z3nFkw9MVPbMhTjkGGo2OZ8+t6VhGyeCig24tyUkZ1FFGq12d2IRgxa/rl2UInGJQQh55Ac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734000042; c=relaxed/simple;
	bh=HjN+Z1XdBelE1SuMaafjpDBIxyP1dU8GOwFSWkt2aJ8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=A29fQC1+wsANFI4Amm8S+Fyfy6T9uoQ1pOVt+NnOz5uCgQR21A9Fczr2TXkkpN+VGcRRimP3nqLiOD+IVtgGEetsJF/cVcwhOTRczcVIjEdXJPAYnIRCSWCZcmWZJPpwo+e5WAfoEsC/URDH3wK8LUoYTZS3NQUoWZm87935s28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TXwvI+nw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ECuZ/Cen; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BC1u3KG014212;
	Thu, 12 Dec 2024 10:40:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=UJotwQ9Xf0SHI7Rux2JNMGzzxSxqtbOYM6O2mOchqjE=; b=
	TXwvI+nwGcTCAEdvXShDxflyLsPj1NDGby/kHcSR8Z3W/WeEf1QwAwKPzoGhlAjO
	VJcUpYxHY4OJdQtkMkacsPXwMFENxcbSwdgTh3xCm0UTr6hIC4A6b+6ti+xMOdgv
	O/Ou6vXdXtS6Ty6gDIw+a8NfyAhKzeb2SpzKv8M76PhkSskp3rSamNtARztTJJMn
	y4Gr1iKasJIltjZlGRhNcX8OqnNpEV5MdOrfWO7Eiv0Avk14xqA2AIB1LUlKDC85
	O1UKHUxb6RfNnKsKLNMVyC6Lfq340/waIOpfWhXSJBomgnf+Sd+PbbicC8XXCtAH
	xOq/WbpCXVLnbh0tFo2u/A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43ddr68wx8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Dec 2024 10:40:23 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BC95Cve021316;
	Thu, 12 Dec 2024 10:40:22 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2045.outbound.protection.outlook.com [104.47.73.45])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43cctaymc6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Dec 2024 10:40:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gefeWlX5Cc8LL5lQfukDsa0nBuwtXRhmriCkVpNplU+38jryuqA0Eww3oldYkdZb5uZgWOuQjDdvGsHa7hPU4ONmBmCMUPVXnXwHxCefcAJjujNYkp5zd/+M3agXQ43mP/1NjTxkxMoVBw2IC+3N2nDHdHA/xblwoQBF5GpHJy56jwvpvIwKUN6XXeRjdBKd6bjmxTFUbNvaQlY8NcvO0EgjwSpphzGbEarwX8zyjDK7KfjKUMffG2mggipBzMiIU+HrUw+Hc/gJnvR3z9JEwbl4dZCSLtiKGHGJRB/WE7+ttRts7j+vBUMFZlJ0ap9ODU4eiSDrxqESEscLEwUZfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UJotwQ9Xf0SHI7Rux2JNMGzzxSxqtbOYM6O2mOchqjE=;
 b=XC94vL6UK4fzFhWAsrM+iod0XDVOJ8XfqEa+NwAfUuMqWmTwC7QJlv6KJex0Wqw5VFTG3/Bhpr8psQah4saAq41dDteECvskOyiINr1WaIuK2JTniC1jtLUC9ChS1QLq9rvdDwXsWzK7xI1ei0+Dgjaxiw3cFPqUUNvDBwNAGPq3NTR5s0LKbRHeka4Pynhz/zK73ZdWX52TzI5WzTH6fwPZszYvZQHssibkr26Q+ClRkPsCDWNsm/mw267AgyRCOVRX3M3DbMCgZL6Hz2JI9A81XcAL3EUMWrOawWva9b0pmmhxW9nQzssaQ7FXYYjOCzcP3VpnOAw1YF7FYVkzow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UJotwQ9Xf0SHI7Rux2JNMGzzxSxqtbOYM6O2mOchqjE=;
 b=ECuZ/CenlUJ9qfTnu5Yupp/XlREsSDXdoTezy+Lugp2bCIxrVv6mez5sdid22KNU930+p498dKsNmuvCGTxdz+pPp06rlWJWoqf1/ltIBmR2ya/tii/7x+5gdclYSwjtZaB4LNRPaqc8FYC+J0jiYtlx8kjyiNWRVizrm6aDy04=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS7PR10MB6000.namprd10.prod.outlook.com (2603:10b6:8:9c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.14; Thu, 12 Dec
 2024 10:40:20 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8251.015; Thu, 12 Dec 2024
 10:40:20 +0000
Message-ID: <4d34e14f-6596-483b-86e8-d4b7e44acd9a@oracle.com>
Date: Thu, 12 Dec 2024 10:40:15 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] iomap: Add zero unwritten mappings dio support
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: brauner@kernel.org, cem@kernel.org, dchinner@redhat.com, hch@lst.de,
        ritesh.list@gmail.com, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        martin.petersen@oracle.com
References: <20241210125737.786928-1-john.g.garry@oracle.com>
 <20241210125737.786928-3-john.g.garry@oracle.com>
 <20241211234748.GB6678@frogsfrogsfrogs>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20241211234748.GB6678@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P189CA0036.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dd::7) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS7PR10MB6000:EE_
X-MS-Office365-Filtering-Correlation-Id: cd1eec2e-862f-4c63-1b10-08dd1a996014
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UzZLMVlaWVNWOEFTS0M1Q1VyN3pIZ2Z3OFdBVUlBYkg2eHlqSUIzZnBnaG9V?=
 =?utf-8?B?T1pVb3c5YjhPMEMvcmY3QTVqRTd5WlNUaUpubzdNUWxMWmIxZndNQUgyaTV2?=
 =?utf-8?B?TCs5S0gvRXF5VGRaMkUxZExEV2dtSjMrWHF5Ym5xRjQxZFhPUmM4YlViOEl0?=
 =?utf-8?B?TURpdGR2UEFsZHVYc3lCbmpOTVhNcmtZQmoxaTBkbmpQU0VEVUxXYUlZRkNM?=
 =?utf-8?B?UEx0ZUFKMjJ4V1JSRnZVdmNFNUMrMWM1WCtOMy9OY3BPOUk0YlNxRTRVbjN2?=
 =?utf-8?B?RFZPQXFKcHZYdFN5WkQrNEd4a0FGRnNFSUNFdzNFVCtxaURibEI1NTh5a2l5?=
 =?utf-8?B?Y3ZZaVQ1a29OTnpTSGVTV2xXTS9Ta3hRQnBMbFNBeWxUaFg0andqSnV4WTFt?=
 =?utf-8?B?aFZWZ25LVjdSekl1d3hFVkdjTytGVTdNZzhTQ0NDWmljUDg4azBNcEgwZmxH?=
 =?utf-8?B?eDkrTU1wU1hZcWpoeFBMUWNKNVhMVjhka0pMTXVYNUxyb1BFeVpYWnh1cDNL?=
 =?utf-8?B?Z0ZKMG5sZk56NlBTUWIrYXExMU5neE5EbllnTEhSeGtURjA3V0Q4TXhZUVRp?=
 =?utf-8?B?TU5MZ1cwTDJaNjM0aXhWeXkyMjVkOUw0NmtFQ0hlR0tVM3d3YUE1T2hYSncw?=
 =?utf-8?B?aGZCbEF3K2V4RGlGMVRtd01QbGlCYS9mODVPczk2WE9UaFBNeks0Vnl5NmZY?=
 =?utf-8?B?OVErdkthc1ptYUpSR1ZmQitzWWx1UThVa240WU1yNkxrTmpXR01nVUFnc3Rt?=
 =?utf-8?B?Yis5RU9DUy9hVExLTFFFcElQVWwvSnA1WEsrVWpXVWIzT1grMU5NTDVwVVhE?=
 =?utf-8?B?T1RsWVVmZUF2eUpsT1NwOWhiNExaL2VXeEt6KzdNdWdNaDNKbDNpbVNpZHRQ?=
 =?utf-8?B?clVFdkNlckxhb3B6VVZuYjYyR056ejhsenE5SmdlNjZtaU4rTFQ3Unk2Tk1l?=
 =?utf-8?B?bkNxUDdaK0pQc1pXL20rWmxjQVlINlJ4bGxFaENjUWN0VkFvVGQ3dktzdStn?=
 =?utf-8?B?eEdiU1Z1c0F0THc4YlJ6Z2VZNWl1aVdBVjNhMHVnQkVBUVhFSEx3U2J4UWtm?=
 =?utf-8?B?dHJoY0hZV2FGSVppTEpJdm5SekpwanZyeU1RdVFIa1pFeGh6QUhGYmxBNTQ3?=
 =?utf-8?B?RzBIWXNCQklackVpKzFJZmVtUUY0NWV0OExiOGJkTE5DaDNKS1R2ei9lT3l5?=
 =?utf-8?B?T21NcXBEWUJIREJQcHhrSEhEYTAveEZnb2dnc2xkTzIyTkl1ckRXclFwbGtu?=
 =?utf-8?B?VExwTTA4TTBrUGJ0S0krRmtkamRwVVd2OWRSdGNQelZHdnlVTXlQejBoUFhz?=
 =?utf-8?B?Qis3RW9iMEFLVU1NSG1BY3hyM1kyL0F3L2ozQ01UVFZmd2FHanVvRlhlN1Qw?=
 =?utf-8?B?SnUrOFhJaS9SdWdMNXNaRkZkUzJqc09LK3NlR0E5T1RscU1MZFBxWmNJY2Ny?=
 =?utf-8?B?eEErRmx2TmVYRGxNVUVyWUU5ZFV5OWhjNXVMTU1HbE43NTlseEtkb2lsTzFn?=
 =?utf-8?B?dThXa3NRQ1RYZ1RuMkt0RXVYaEwvcDF2OWQ0QzVVY0FjQysvS2ZIZHlscjI0?=
 =?utf-8?B?YVp4ODhEOW8xbjgxUzltUHZsK2pNcUZseXV3eWx0TUZjc0JwMTZaRUppaEpC?=
 =?utf-8?B?RlNGZDRObVFiTWViWmFxejlYSmVMUzNPZyttSWJuUWNZMDBIeXNHaDdiRS95?=
 =?utf-8?B?eEFrL0Fjd2lZM205QWY2R2NHTmwxelFoRmlFSW11aXgzTVMwc3A3VnI3TEht?=
 =?utf-8?B?Tml6STlpd0s4MmMyNVNQejZWZXZRN3c0Q3RGQmRPQnJmUlFCeXVjMzVycDRD?=
 =?utf-8?B?R21MWkI3ZHV3bkNWMmU4Zz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WXBnL3dacUZJWWc3QlpxQW9WNEI4MGNMU05TeFRrL0owV3lvRzdjUUpuMTRC?=
 =?utf-8?B?TnNETlNrN1Awb280VERvd2JTd1ZmczN6WWh5NjlvS08vUkpHRkMzM283THB4?=
 =?utf-8?B?YkVsZkZkcEcvNk1TUWl3Ly9XdENlN2VRV0tFVWlnQ0FSYjhQdWNjeG82Y0Ft?=
 =?utf-8?B?c3lJb3dPaVF6Rk9RckNCbWd6NUtqOERUNVNmL3ZLTmcrYnZRMU04QW1XVHVP?=
 =?utf-8?B?a3NvdURrM3NtTXJ4RGxJcVBEaWg1aUgvQmxYc3dvWmtwZk93bWkrTGYvTnhQ?=
 =?utf-8?B?NkF4aHp3YUg5MkdTQWdFSEpvUEZOS2lCUmxmbTRRWTBsYzlGaS90YTVXQTho?=
 =?utf-8?B?bTNNMGFoY0M5NS8rYTJZN1o3N3lkeGUrVXhxVlBtWXVKNHRpQmpZdXhsbzhI?=
 =?utf-8?B?OWQ0a2YzTTcydzQ3eGducHF1RDdva0pFZ0hMRWlWOFkrSlFrM09MTXRHdFRY?=
 =?utf-8?B?N25YazNWOFNXcUJVZWFZUElDUVZQR0c4VEdSR0FNd3cyK0ZqN2VxU1NWMm1v?=
 =?utf-8?B?MUxUY3l6UU5tNzVkQ2MxRU1SdTBzZVVGY2RaTUNkamFRNUZiYTdGWWdMcW5j?=
 =?utf-8?B?Q2VOdVc3K1BrMGpsQmVyTnhwand1V2F5OXd3MzFuYnNON2V6OXkwZmo1YjBi?=
 =?utf-8?B?VXErM2ZsbkJ2ZWVZb1RhMWt5aGx6NHJ6QlRHYkk3M3FkbEVsQTFmS05LSlRV?=
 =?utf-8?B?cFpScDZ5WktSbVYxNVIyMFh2WFpqUXRrMHVZbGIrcVJkU3JVMmtnUTJlanRj?=
 =?utf-8?B?ZHplYU1sb2VobUxUTWVGMS9saFdPS2oweXN4WGloYVJFVHdqOWNJZ29Mdkp6?=
 =?utf-8?B?RjdYU25ZSzduMTlkbHFqMGMyaS9EUDVLYVJWc0QxelJDQ3p4MjJZekovNVNJ?=
 =?utf-8?B?ZlZZMnhpaEFERXRPVzBKMHFKMTgzLzI4U2JaY253S3FndnFYdFpWQ0IwVEtD?=
 =?utf-8?B?WEhoMlgvanViQWJoUEw2cGlpVVlaOEU5UEFBQUx0dlU2M1VuWk8xVlZLM0cz?=
 =?utf-8?B?ei93ek5vQkZsckgwVytSTExYYTBldUZYeVFPOHJ5d1FnNHgxQ1NOeVlROHdp?=
 =?utf-8?B?NXcxTW1xYUE4cjQ4QzVmRGlocFRQclp2ZFRGY3RFMjNCQVpERkxCa25zeXJQ?=
 =?utf-8?B?UldlQlAyb1ZJcSs5WXNtc0JaTzBjUVdVWjBpUVFyajRpMVBkMlNacUQwdmc0?=
 =?utf-8?B?aDZ2NVl0RkZQMHV2SHY4ZGpWMkhBOE1NY2JqS3NPMS8xM1FCSnJrZ1RLWGsr?=
 =?utf-8?B?aHBsY1JKN1Q3K1dQSTFKZWE3bmVwRWk1dFo2QVg1TFhGYms2aE1pMCsya2xY?=
 =?utf-8?B?R3FtQm0zbk13SWlDRGpOQWM2eTgwelRsMENmWEI2MlNpVjNhd3J6ZytadHNa?=
 =?utf-8?B?R1d3eHhRWk53ZUNYWTFVYnlwUkpjWVRTUllyT3pXZTliOVBiOU9wS004Z0Fz?=
 =?utf-8?B?WTJXYXA5UmcwRldUdGhyc1UwUXhBUWZzb2R2c05pbHA4TzdjQWdGZTBYQ2pR?=
 =?utf-8?B?a2xkU0lMN0l6TFdoaisrZW1EWFNVRjFqZHRxVXNFclg4T3h4R29yS3N0VUJ5?=
 =?utf-8?B?enB0ZjU2c09WYkE0ZlJoR1FOU3IvZDZUWnFlalRvamNEWXc1dmFaVG5oT0Vv?=
 =?utf-8?B?VEIzYWIzNE04S1M1RGxBU0pGbEhsM0REK21ZWXY2RjY1MUIvMHNaOGRlWU1S?=
 =?utf-8?B?RWNMQkRQWms4OGlaSXM2bTZHMHNrc0gzc0Z5WWY2RW1aSzAybEc5UUJYZnA0?=
 =?utf-8?B?d2V5c2J0VlQ0aUlONWtIZFBZYjZBdDdjam96WlJaajBZOFlIOEFFMlBnVk5p?=
 =?utf-8?B?Ump0UzNLVmUvY3h6RWNoSHVaT3dPdVNXb09ZMDFPNFpJaTFyVW0vZEJTcE4r?=
 =?utf-8?B?Z09UUXBBTlJnVjl0c3MzQmpWU3VxbktSYTZ1QlR6SmZsWm5QOVcwWDcyMUlL?=
 =?utf-8?B?bGVGSC9DcmtIemRuSUpISndwaXZNOWZBOWdMSGVUN3FrWUN0RmpQMWpSTkY2?=
 =?utf-8?B?ZmU4Ri9QUG9tRUlCb0REQUVWcWZkWDExbUJmZDJKYllzUWdYb0Vqa1FINmdR?=
 =?utf-8?B?anpRdzM2elR0RnptVXRJZWZIWkpqUms4TGNCSWtYblJPa3JkV0hvVWdCUzZY?=
 =?utf-8?Q?dr/a6L60VYanz69Zh3SlxvFeJ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vof8Z+9bUWn3A5hMlZi/nSp0KrBMNwCEhpY3Hdy/XEY4Fg8fqGyNUR47Pta5Vy+sXoFIMHJpLc0nCxUdWQAhpsFDaEvMiRzYMJYqlg7nx7AumU1bc+nvyf/VxXnj2obrwWG/VeE7z3qO2JsNM4bndQHe3dOhxWFcV5gKL6Tcg7S790szWnP1rh9EXWhitKAWntR5cpFN/uzS9Ukzadl2JGrWOIn0uvN3FZ6flP7Ddn93TaODKAXHbj8wlJvdHkEJh1DCVZWKV7vNjcaccwTDnefUXdyLdbQOhUHu+CWzgMG+3zCDhTWSd6UGc0RzaJgWqeAoT1BPeVcBKvcQ98L3mBSYpi7BRHEksXO2rTl24DYTzmBeZ9pl68crQcowek7fwMWMm5yDxf99QagJeyY1u3WavuKdvdewF8DepJApY67AkHRAJ1Nw0VS9FajlkdMNeoeGtkSGsHqWqcn9i7zCS7+jOFxZ67p/kZlg8EVmJ13horHuKX7jeGxTYiy8WJgDgsn7YIGd3pfU+YzqbWE7bCOEOnFms55b3visS3peNCmglyWD56RGZuLdpoBIz9iB4ID2P/dne6F/bdq3XPemi7xeV991Bs61GTbY/o+yA5M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd1eec2e-862f-4c63-1b10-08dd1a996014
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 10:40:20.2922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QQ+sbPW+bLVW4lUOM73Mg/b8CrUfyyvArixIQuss7pXPqUCEFc0id41spVXgXu0JkWd4kiRW/THVUWZHykx+Zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB6000
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-12_05,2024-12-12_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412120075
X-Proofpoint-GUID: EeubdkfOO7BguLZwxiTrxS4iObly8CSd
X-Proofpoint-ORIG-GUID: EeubdkfOO7BguLZwxiTrxS4iObly8CSd

On 11/12/2024 23:47, Darrick J. Wong wrote:
> On Tue, Dec 10, 2024 at 12:57:32PM +0000, John Garry wrote:
>> For atomic writes support, it is required to only ever submit a single bio
>> (for an atomic write).
>>
>> Furthermore, currently the atomic write unit min and max limit is fixed at
>> the FS block size.
>>
>> For lifting the atomic write unit max limit, it may occur that an atomic
>> write spans mixed unwritten and mapped extents. For this case, due to the
>> iterative nature of iomap, multiple bios would be produced, which is
>> intolerable.
>>
>> Add a function to zero unwritten extents in a certain range, which may be
>> used to ensure that unwritten extents are zeroed prior to issuing of an
>> atomic write.
> 
> I still dislike this.  IMO block untorn writes _is_ a niche feature for
> programs that perform IO in large blocks.  Any program that wants a
> general "apply all these updates or none of them" interface should use
> XFS_IOC_EXCHANGE_RANGE since it has no awu_max restrictions, can handle
> discontiguous update ranges, doesn't require block alignment, etc.

That is not a problem which I am trying to solve. Indeed atomic writes 
are for fixed blocks of data and not atomic file updates.

However, I still think that we should be able to atomic write mixed 
extents, even though it is a pain to implement. To that end, I could be 
convinced again that we don't require it...

> 
> Instead here we are adding a bunch of complexity, and not even all that
> well:
> 
>> Signed-off-by: John Garry <john.g.garry@oracle.com>
>> ---
>>   fs/iomap/direct-io.c  | 76 +++++++++++++++++++++++++++++++++++++++++++
>>   include/linux/iomap.h |  3 ++
>>   2 files changed, 79 insertions(+)
>>
>> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
>> index 23fdad16e6a8..18c888f0c11f 100644
>> --- a/fs/iomap/direct-io.c
>> +++ b/fs/iomap/direct-io.c
>> @@ -805,6 +805,82 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>>   }
>>   EXPORT_SYMBOL_GPL(iomap_dio_rw);
>>   
>> +static loff_t
>> +iomap_dio_zero_unwritten_iter(struct iomap_iter *iter, struct iomap_dio *dio)
>> +{
>> +	const struct iomap *iomap = &iter->iomap;
>> +	loff_t length = iomap_length(iter);
>> +	loff_t pos = iter->pos;
>> +
>> +	if (iomap->type == IOMAP_UNWRITTEN) {
>> +		int ret;
>> +
>> +		dio->flags |= IOMAP_DIO_UNWRITTEN;
>> +		ret = iomap_dio_zero(iter, dio, pos, length);
> 
> Shouldn't this be detecting the particular case that the mapping for the
> kiocb is in mixed state and only zeroing in that case?  This just
> targets every unwritten extent, even if the unwritten extent covered the
> entire range that is being written. 

Right, so I did touch on this in the final comment in patch 4/7 commit log.

Why I did it this way? I did not think that it made much difference, 
since this zeroing would be generally a one-off and did not merit even 
more complexity to implement.

> It doesn't handle COW, it doesn't

Do we want to atomic write COW?

> handle holes, etc.

I did test hole, and it seemed to work. However I noticed that for a 
hole region we get IOMAP_UNWRITTEN type, like:

# xfs_bmap -vvp /root/mnt/file
/root/mnt/file:
  EXT: FILE-OFFSET      BLOCK-RANGE      AG AG-OFFSET        TOTAL FLAGS
    0: [0..127]:        192..319          0 (192..319)         128 000000
    1: [128..255]:      hole                                   128
    2: [256..383]:      448..575          0 (448..575)         128 000000
  FLAG Values:
     0100000 Shared extent
     0010000 Unwritten preallocated extent
     0001000 Doesn't begin on stripe unit
     0000100 Doesn't end   on stripe unit
     0000010 Doesn't begin on stripe width
     0000001 Doesn't end   on stripe width
#
#

For an atomic wrote of length 65536 @ offset 65536.

Any hint on how to create a iomap->type == IOMAP_HOLE?

> 
> Also, can you make a version of blkdev_issue_zeroout that returns the
> bio so the caller can issue them asynchronously instead of opencoding
> the bio_alloc loop in iomap_dev_zero?

ok, fine

> 
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	dio->size += length;
>> +
>> +	return length;
>> +}
>> +
>> +ssize_t
>> +iomap_dio_zero_unwritten(struct kiocb *iocb, struct iov_iter *iter,
>> +		const struct iomap_ops *ops, const struct iomap_dio_ops *dops)
>> +{
>> +	struct inode *inode = file_inode(iocb->ki_filp);
>> +	struct iomap_dio *dio;
>> +	ssize_t ret;
>> +	struct iomap_iter iomi = {
>> +		.inode		= inode,
>> +		.pos		= iocb->ki_pos,
>> +		.len		= iov_iter_count(iter),
>> +		.flags		= IOMAP_WRITE,
> 
> IOMAP_WRITE | IOMAP_DIRECT, no?

yes, I'll fix that.

And I should also set IOMAP_DIO_WRITE for dio->flags.

Thanks,
John

