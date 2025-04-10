Return-Path: <linux-fsdevel+bounces-46212-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D47CBA84764
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 17:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4EA619E10F8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 15:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C8A1DE2DE;
	Thu, 10 Apr 2025 15:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="R52WrP7o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE371E7C12;
	Thu, 10 Apr 2025 15:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744297659; cv=fail; b=mNxbjPB+KIO0CiTaUDsdYPKfpc1ecpmrP5vWrSkjNx2DLlggUeUVtMMfgVwEuaRu7WVzZCswY6um6QCAVFloPL7ajX2lHwIY1gAvITg0qQ6Pgj8IKXXiAyZybR/OjA+lqwY3CMPZOA+m2nv2AI5wT16Kg7GTpkdsg4faAf9W/UA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744297659; c=relaxed/simple;
	bh=6UT8CXKkfyhWEQZp12egzp1Fn454G6J8Fcc1NZzNYz4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ME494vuYP+uX9LgfV4oHj2KeqYTkgpmbeY6Kpt4/C84bmixNJkzJuHE/+f4TIRug+UelO/sJ5VfRYqaJ1v5oReNeO1JwvTiCkF81Snf+9kIyOPXspW+PvVOlpANb1+Co7mDG1Ev9gA0XYP3pI7dCB7iX8fPxuhIa+u3elx/s8F0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=R52WrP7o; arc=fail smtp.client-ip=40.107.220.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aI25/6ce8LxU6MUDrJpgEOLSIfzib7aC67TRPzxnnSkBvwGLbUiWMbINszqZiAAYLLmJcheeDakPB8cyXtZt95WG1ExDWZlsfIqeJ81R5hT1R6C7DFS5+/mmG7nnyXVSU7W+8R2exg0gAaCif9pCZnDjwGjSARMbajl/BSWy7COViF98ldW3yk+Ov4ao+lPeX2knb/agZ6iO471GkQpgozBfNlQO8iSh1SRy2sFOrEusBMs42SpD9ofn7TTyFOEDC5FgbNxsHkYbLLyryQg4CPn2cMhKtEfkpJmkeWNegDVnmVgqv3rydODvmsKaQuCipdmZ5hmdb1uDirEQ4w8Vuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IdpctxRNpK0LhlesUOQt1PYM5PRWd1zvOSGVyxCRDaE=;
 b=RtZAv7tQhJfIpEVn2RHPynnpKbfQ/MZd+Ldb1gIRfcev+Omb8/l3gxN2qQycDYBwQp/wnGf35KeQaZMQ/GIgt5jFNFG7Ij9TgpXI8K0kSoOn7qCy/JRcks75ihzkt4pWykkC/vnZrOTcDdyG+XNnIS3en4QxHMhcGj8RFxEZKHm7p1G92nKeHxRtFq246Ns6FA9TPE+4MEgPHzycUsrYruYMuQQ3ycititt9fR0qZnsTKkDj44eP+VYMCSHWwrqIcjkbZm0AUAXi/JE5BURCNY4KdVUPPkbc5XeUfpycpNMIEMPCENne0YdWRuOPV+fRpPVmZUhzfomD3YwimNlTXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IdpctxRNpK0LhlesUOQt1PYM5PRWd1zvOSGVyxCRDaE=;
 b=R52WrP7op0LKG9wmL0OMaA9ECbKu9qWPUEKBjC2WjG4j9WBzBdnR9P2lKwGkKzbxvVp60kkRo77Bd2q1dNkMDl8NLsISSNu3XByhJH+krtxX+A3sGfnD4bqMhvQ/rqaEbWusNuZY7lhzG+81R9arvzsPazmOJIWBsomjvWfDTPU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 SJ0PR12MB6990.namprd12.prod.outlook.com (2603:10b6:a03:449::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.22; Thu, 10 Apr 2025 15:07:35 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%5]) with mapi id 15.20.8606.033; Thu, 10 Apr 2025
 15:07:35 +0000
Message-ID: <93e45085-1ddf-4f99-a7c3-17670e9a2164@amd.com>
Date: Thu, 10 Apr 2025 10:07:30 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] kernel/resource: Provide mem region release for
 SOFT RESERVES
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: dave@stgolabs.net, dave.jiang@intel.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 willy@infradead.org, jack@suse.cz, rafael@kernel.org, len.brown@intel.com,
 pavel@ucw.cz, ming.li@zohomail.com, nathan.fontenot@amd.com,
 Smita.KoralahalliChannabasappa@amd.com, huang.ying.caritas@gmail.com,
 yaoxt.fnst@fujitsu.com, peterz@infradead.org, gregkh@linuxfoundation.org,
 quic_jjohnson@quicinc.com, ilpo.jarvinen@linux.intel.com,
 bhelgaas@google.com, mika.westerberg@linux.intel.com,
 akpm@linux-foundation.org, gourry@gourry.net, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-pm@vger.kernel.org, rrichter@amd.com,
 benjamin.cheatham@amd.com, PradeepVineshReddy.Kodamati@amd.com,
 lizhijian@fujitsu.com
References: <20250403183315.286710-1-terry.bowman@amd.com>
 <20250403183315.286710-2-terry.bowman@amd.com>
 <20250404141639.00000f59@huawei.com> <Z-_d0YCpMiRVB0cA@smile.fi.intel.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <Z-_d0YCpMiRVB0cA@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:806:20::7) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|SJ0PR12MB6990:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ca66a85-ccac-4fa0-c620-08dd78416cb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NDE1M1FZaGE2WHpQSG1SVDFJSmgrdUxpYUZoZEI1R0xLV0d4M1ZQSkVReFQ0?=
 =?utf-8?B?TlRzUUV0N1B3a2JLNGx1dnJqUFR2N21vN3RUTlhSa3NtaXMrMTlLSi96NGM4?=
 =?utf-8?B?Vk1Id3RqcmVuWEhqVXc3VHJiM0VubVU1WVZla3U2cGhybUM3eTlxQ3lUOTZN?=
 =?utf-8?B?Wm5lNTVsbzRZTzRDNlN3ekpTOGw2Qm42RlRoVlRHaHF6N2JzVlNNZGJwTzlX?=
 =?utf-8?B?a0llRmk2UEdkRkorVnEwRHgzY2JwMGFNb1U1WVVnZHdnVVBRbUZiVWJlTGhY?=
 =?utf-8?B?S0ZaUFk4UG5JUTNjeDJHYm5nbzdvSndvMFFGM08wdE5oaFNGTTZHdUdOaXpH?=
 =?utf-8?B?QmlQQ1gvZ1pqRHUrVS8ycjhQRnBScGthZFNOckVDMVMrOThvZ2Uva1RTZnJR?=
 =?utf-8?B?UTcxQW9VLzRzSFhXVWJFeTduaUFvMzB4QXk5KzhDbUZhTkJ6aUVqOWdxQk93?=
 =?utf-8?B?dUlxYlRmZ2kxR0xqQlVjVEkxSEFkOTd2M01iUGhQZnFaTlRoZDdQSld4RDg2?=
 =?utf-8?B?ZFM5OGQ2OVlMWi8xSW9OWUJCdisycWJxVFZCQ2JiY3YvUlV0NkdDaG12V1NB?=
 =?utf-8?B?MnRXQkxoVGxkQXpLalovalFmbWtQWnQrQ2NLMnkvMVU4TllHeURxVytGZzJa?=
 =?utf-8?B?dEsyK0RqM1RlTy96QVk2RWc3MnhpNzJMekNvczJ4d3dGaFZORjczYlFUTGN6?=
 =?utf-8?B?NktzNXBBQ0ltamhoUGZwYTF5dXVFZmlZQ0w2WlVaQ2xLZTBDb0NNcTN0ZjVZ?=
 =?utf-8?B?WlEzQ2Uxb3AvV2srYlJvRW51TGhTU0JKUFVkTXV1Q0lvempxcS9EMWMyODl5?=
 =?utf-8?B?QkNPdHg0Mm1NT2hma3B5S3NUN3dzbGtEd2pJWWtwZHpseEhMVmszNkdxYUQ0?=
 =?utf-8?B?QTNpUk50VTEzbkRtcmljMUhaSjFQQXJITDR2WDR6NzltV3lINERMQStCaHJ6?=
 =?utf-8?B?OXFwNzNoeEJiVkE5ZU5vSERHZkZoMUNZOTFZRDJTU2psU0dpc3QyMndHdVZn?=
 =?utf-8?B?VEFSa2U0bkVJd0Y0VTRaL21ETFNYZ2tqTm9zNlBQWGtzSllINWVZK1ZWQXR3?=
 =?utf-8?B?YnMxejNtMmtQNFMxK0pkMWdqWlFNb1ltblFZcHJpTGRDVDdqT1duTUtEbEdP?=
 =?utf-8?B?MGh6YmxmaXpUUm1lWTJoZVI2czhFdVphS09SdjFxYlZBV3hoRnYxZURJcGsv?=
 =?utf-8?B?VUNWZjFnRnpSUnBuckVxVysxcmorVXlDZjdKaENZL2FtRU9XTXdrdHlDTG5q?=
 =?utf-8?B?d0tZRTB5SFQxQkpra1ZmcXlRaXlnU0x0ZWN5dlNZTmo1NmhWU2lEOEY0eXRD?=
 =?utf-8?B?Y0VMazNydUNqenpIeEVpL0d2dTdHbFdMazFUeTRLdG9rcjBWSlBXdWpOTFRJ?=
 =?utf-8?B?YmViS2JHeHB1emladkY2Y1drdWRvZ1lGVzZ1Z01qYmlRcHFkZnk0elNlMVNS?=
 =?utf-8?B?eWZhN2oyS0FuTkNZb2g2RG5UeHlkTWVZcHZqRFRGemNuUUl3TFV3WVliMzFK?=
 =?utf-8?B?NTMxWkVCWEdNZ2RqVTJRcGh5amw0TGhGTnFiOGVoOWZPWVl6UUk4dGJQQjZT?=
 =?utf-8?B?MnFBOHp3c3lrdk5FUzRwT29ML2gxbERPRE9paTEyeU5rT3ZERmJtMm82RkJJ?=
 =?utf-8?B?dmlHMmtUV3c4K3JCSGQxWFZ2ZzNXZ2pkbHlpSlltMzdGN0J6a0t4RzZFTU9N?=
 =?utf-8?B?Y0ZOZXRLKzFyTmpsclBGRVJGaHNvQ0N6NXpmNzhPNEFLV1JZcWNtSlAzVG5L?=
 =?utf-8?B?OHIrbjFVOVJ4dlJuUmZYL2tDZ3Q1QVJtZDd0aWdQWTN1ZmplUklCQUFsUzBK?=
 =?utf-8?B?bkx6VWNON2E2VFI0SkwrQnRRczk4MFc3SkU1VEJwbDZuNHlBZnB6ZkxJdGxN?=
 =?utf-8?B?azltWHFhdVo4VnBuRWJtNGtDM2N6Y0hjN2dyZHh3WDMvSHFUT2ZnOFRqT3hY?=
 =?utf-8?Q?7yF9cFCG10s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QnVDd3FObk5WK1Urbjh3c0ZaejJaYTVtSlJ0Q2RMallxVWwxVUpEd3NDcXpY?=
 =?utf-8?B?aHlGYzJJUHpYZWxVcWF5N1FvK1F1SjZZTzdWZURSWGc1MSt4dUM4MVkyYWdQ?=
 =?utf-8?B?d0R3RkRUMmNxVldNMm16dkpyWWlMUlAyRnhsS0hxU2lLNUJNL3hGUU1MKzIz?=
 =?utf-8?B?dkNTRUp6TVA2RzE3NlhiVkMyT0FqblJEZC95cGFoRFBGU2VRbm53czJwVkFj?=
 =?utf-8?B?OUEvOHM4dTRpZTFZK04xTUpMZUk0d1RaK2NlR1M4bkJqVlE1ZkNGRDNHK0VY?=
 =?utf-8?B?VjJhd29rYSt6TFhTOUx6ZDhGK2NwcVRwNGFlaWZYUENlUmJYQW1zdmUrMGd5?=
 =?utf-8?B?RUVhdWkrOGFpbEtOWThwbjJNbTdKSHIyaVMyaWZLY1pBUFRlK0RndGRBVUEw?=
 =?utf-8?B?czMwa243ZlVVdW1YeU1jeFpNdTNMY3pTVGdYTUo3Uk8xMDh2SnN3MEE5YmM1?=
 =?utf-8?B?S09YUWVuTHpSTG1oSUU0cGhpdE16T0VVZ09sSnB3RVZYcFVBd0Y3eHhnTzNB?=
 =?utf-8?B?d0dHYWFDTll4dTd5a21ReHZydDJwWnpWcWQvdm16VnRuVmlOQjNGOE5iVXhB?=
 =?utf-8?B?RnB3bkZwUkhFaE1TQytyU3dIK3FBVlhObk1zWFhaK0J0SjVaSFhZdEd1NTVu?=
 =?utf-8?B?TUhlWWV3dnJid0NiK0tRdkM2R2ZCZWhibGUweGM5RXJ0M25ReFZJR3JZL2tn?=
 =?utf-8?B?d0ZVSTFXRU9ENXRMb3dLOG4waEVLN0FWbEdyV3k1OEsybC8zODk1VUlsYkNn?=
 =?utf-8?B?SmJ2UnZYY3Z0K1pMbzYvSHBsckpRbnY0MEJvM3J6QWNobGNXWDdyc3d0SjZv?=
 =?utf-8?B?cTVRcXpWbWh2bTZwOFRwZ3VxdlpOM0ZyMVg4UDV4dm55THFSeHRtZHhKYStF?=
 =?utf-8?B?MDdxclpLZ1Ztd2lacVlLY0JDSHluRlQxa1BMRzlubjJVZG8zcy9xT24zZnAx?=
 =?utf-8?B?c3pCSDlUN2pPSjlSUkFHSnBHekdLT2lFc0JLc1RSOGRiTW5ncm1malZjREZV?=
 =?utf-8?B?MlhYNTJKLzNVL25Nc1J3eFJBTWcxNzBvTGVDMnU3QTZ3dWdFbWtHT3cwT2RD?=
 =?utf-8?B?SnRIYUM5WXdndGUrMmwvV01Hd0hlaEZSbUVKS1V0dVl0Q2tzM2k3NUc3ZHJq?=
 =?utf-8?B?TUx1M3BRd2RxSTdKWHh0QTJuTHRmN01oMTZuQ3VnTXNmekp5QlVjb2V6Nkta?=
 =?utf-8?B?cm9nbTVHM1E0TjJ5dEU2MUlrVktJS3hjbVllL1B3aWE4TkZoMGlhbU1BbXVn?=
 =?utf-8?B?VTdPK2dkK3NtZHhZSFk5ZFVkWU9pelMwdkZ3d1pYZUcxeW5nY2JGdXM5L1Ey?=
 =?utf-8?B?NDhmbytWaGlmQm5XQWJtWGxpelUvbkNWZWJzTFRxcmtFUzdBb3g4U1Z4ZjRT?=
 =?utf-8?B?UnFMMVVscXB0OWRoVXJFakpuRWtYU3NJVzU1NDFUSXEvZjRiL1BYb28zdk9x?=
 =?utf-8?B?ZDUrSElIRkpGbzFmaCtnaDNVYXZSaFBoZlM1cEMzc1NKdXRVK0VaSEpUdlVp?=
 =?utf-8?B?bnY2N3NuVS9vQUFQMlVtSVh1TWNWODV6OXowQlVzU0FqVHFoU3FkWi84OWRq?=
 =?utf-8?B?SmlTN3l2RlhIU052U29Ub0JmZ3E3SVVTaW42d0dIR25uaFJXZzNtZncxb0NV?=
 =?utf-8?B?cDErTTNla01LYm9SSUpaZm1vcm0wOGxaR2Z2SXd5V3hPR3FRazNpWjlNUGFy?=
 =?utf-8?B?VjBZYTBvRWRhV0w5ckdiOS9GVGs1QVMxYWxSald5Y0FNTXdUTk5iRWsxRWF2?=
 =?utf-8?B?R3Y1Vm83VWM4VjZ4bzg2MEVFOGVtUG9IVUFFZkRBQjFBS01ZcEtYalBRSVBH?=
 =?utf-8?B?R1ZvenVHdkI1SEhYQTlzMEFwaG9oYlduZ2tBNFRwQ2I3RE1xT1lkaG1VM2Nh?=
 =?utf-8?B?QlQvMzRab0p2RGJ5bnE1clNYL1UxR08yeVdBVzdPSDZOeXI0T0dGOHJvSkpG?=
 =?utf-8?B?TWxqdUR4ZnRpYUR2OFhka3JSQjFxMTJ0UWFqdUxka2tKajBuVUZMTjZsenpy?=
 =?utf-8?B?TGc4QldPdTM1eFFCTFFqRGg2c3B2WnBSdkRyK21PVnZSRFQxM3ltWXZxbS9W?=
 =?utf-8?B?TXZERHk1eEZibFdGSHdYRlB4ZmU1em1kOE9tTUxXOGtRR2F5T3VGRW5vTmsx?=
 =?utf-8?Q?LsvZV6nFC6cmzxvJknseyWC/9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ca66a85-ccac-4fa0-c620-08dd78416cb3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 15:07:35.0312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5xOLeiFdtXdaSMgfEgiQeAAorByujbulzFldE7F9bF+fh/F6/TtGIPFXqTWwZUdigKiUCDLV2yPVVO9LKFygEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6990

On 4/4/2025 8:25 AM, Andy Shevchenko wrote:
> On Fri, Apr 04, 2025 at 02:16:39PM +0100, Jonathan Cameron wrote:
>> On Thu, 3 Apr 2025 13:33:12 -0500 Terry Bowman <terry.bowman@amd.com> wrote:
> 
>>> Add a release_Sam_region_adjustable() interface to allow for
>>
>> Who is Sam?  (typo)
> 
> Somebody's uncle?
> 
> ...
> 
>>>  #ifdef CONFIG_MEMORY_HOTREMOVE
>>>  extern void release_mem_region_adjustable(resource_size_t, resource_size_t);
>>>  #endif
>>> +#ifdef CONFIG_CXL_REGION
>>> +extern void release_srmem_region_adjustable(resource_size_t, resource_size_t);
>> I'm not sure the srmem is obvious enough.  Maybe it's worth the long
>> name to spell it out some more.. e.g. something like
> 
> And perhaps drop 'extern' as it's not needed.
> 

Got it.

-Terry

>> extern void release_softresv_mem_region_adjustable() ?
> 
>>>  #ifdef CONFIG_MEMORY_HOTPLUG
>>>  extern void merge_system_ram_resource(struct resource *res);
>>>  #endif
> 


