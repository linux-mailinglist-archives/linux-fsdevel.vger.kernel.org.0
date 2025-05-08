Return-Path: <linux-fsdevel+bounces-48455-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75954AAF4FC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 09:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D1899E0DDF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 07:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22136218EB0;
	Thu,  8 May 2025 07:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pSTGyV85"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9F02E40E
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 May 2025 07:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746690767; cv=fail; b=N+XcIvm16SYjw0KHiD3PDBdGyFNiJBm1KTPUUcxmqjaExiryIzxVV4xesSNdPBSyValdIDv2nP8GYybQ73YKaMSHCrYAQkKXk5pQbWCTyK53S7DYRXoqSzlxAlJKPshYQUIvrWsCyvAzihPS/yzyHCsBtCrhHnhZ5ydJpyw2OFc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746690767; c=relaxed/simple;
	bh=8NyyS0tXz1btlCR16dgbYHk6Oz6r1TxNWW4su+Jjt6w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qxXu1OSI7Km7a7P1ai3CMtF4DlIW3QP365nh+8WZdVzUSC8cOSuaD/ol22o4sNqN1V8cENk3Xreg7gglNoc8GfUoe0BZ8QL/647H2va4FYCb2r0zRt3vCDrd1I1YjTx7zjMwWOJ8gy8t3b3+/9RZiXjd3DdU3l/mLvl8Nq7gb0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pSTGyV85; arc=fail smtp.client-ip=40.107.223.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pbZciQ5/hv5EqevZsRQb79WKpfZaJgDWi6nZeUEtNhkRPYzD5qwwGU7i1vXxDczp/2TpaBx39+BprfLkyRgUH13ffemacA3sTKWPKj+pMWHhbprN3zBUF6c7HKoWWqe9luRIbhPnYOrENmR3CewGroyMeKNec6H+Wz6Q9ORxyf6V7WNNSkYDP2FlyEBTlfXf9fGIwvhWnxHKXvP2Zjsrk2BkUb+Gy02o/MSnwEzuhiLN8+gusUXOXjZgJmLoMz3aI5pI2qte9iNhgViYOLA8S7jOls5o6MUx50Y+HKgUqI2bRipEvg1SRsbMRV8XU6vSKtC7oSn3+kVkRQ+T+26k9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X9C8STtPtJwOLqREw4aKshgaFGBT+qxl+e5GrO0b3DE=;
 b=O+xGFA42aOBwPuKJPw1XY2sUikXbsM3tW/4Ib18uq0cZKzrYA/4qFq39uGvC5InD2Cq8aKosd5gfmcQ+kYFXFXYotKru6aqzQziwZASVpXhRsAXfet1d79BkDZHg8zMQmuQ1IHTNH9tdmpMIEP4kuCvRka78/WFnFwf/6Y+aNeCU5phriHOa2GR13OXXz/ejf6CoSwI2BSPkXD+0mxA0p4oQYPIlYkqzVHpt45EK/gbWnOox7Aa04sMv1us5m4l11PeTbvSmAfvREM96w9GJTxAxz86XSZqze4I3rGnctjnANEoFNu2tXFEAQHBoUBC9hZK9jdkoQYKC19el8xk5Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X9C8STtPtJwOLqREw4aKshgaFGBT+qxl+e5GrO0b3DE=;
 b=pSTGyV853RngUMb6lmpl7UDP3wzjGni8K2+7Ykt0tdwtIkm8APbkk8v/cpMFlPZLROfbxGekTvgZBj7vW8EtA6DGiaaMNQPCdgqsQI8sIYDDaXslaA7JIfUf2m27AbmecwjhMmgyCG3uQVsGph7jZ/DUODkHzXA+VC+w8eUwNuoUCzsqMfmINdmoYpOHYCS6hXrtNFUnDVBzHG0OgMvw6db22Wiuw0oFXyKtbpYgSOK7zMUiHwat9Ucl0jvf5PBD6OGgFR5JsV5Y/bkycsf0aLtbhAXjqdZsH2IYlq0vwwPTsbP7HIP6fv4JGU/rk42Ik03bwTI79zXimcrOGcn37g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5968.namprd12.prod.outlook.com (2603:10b6:408:14f::7)
 by IA0PPFDC28CEE69.namprd12.prod.outlook.com (2603:10b6:20f:fc04::be8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.29; Thu, 8 May
 2025 07:52:37 +0000
Received: from LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4]) by LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4%7]) with mapi id 15.20.8722.021; Thu, 8 May 2025
 07:52:37 +0000
Message-ID: <75a3cb6f-a9cc-441f-a43e-2f02fbfc49bf@nvidia.com>
Date: Thu, 8 May 2025 00:52:35 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] selftests/filesystems: create setup_userns() helper
To: Amir Goldstein <amir73il@gmail.com>,
 Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Shuah Khan <skhan@linuxfoundation.org>,
 linux-fsdevel@vger.kernel.org
References: <20250507204302.460913-1-amir73il@gmail.com>
 <20250507204302.460913-6-amir73il@gmail.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20250507204302.460913-6-amir73il@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0150.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::35) To LV2PR12MB5968.namprd12.prod.outlook.com
 (2603:10b6:408:14f::7)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5968:EE_|IA0PPFDC28CEE69:EE_
X-MS-Office365-Filtering-Correlation-Id: a3fa57ad-1e8b-48ca-c9c5-08dd8e054d14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|10070799003|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MHRWSzJqQytPdFRITWkwREp0Q1dLbkhLdHJyNWM2R3FOWDg2dHM0dDNkWGVM?=
 =?utf-8?B?ZlJHSDZEZzJPYTJ0b3VuSE91UjBWM01jaFA2cG5lNk9oQzgvMDEyMnBXeHo4?=
 =?utf-8?B?eFlLM3FxZFQwWUVlTVZ5TGpKWmhzNVVhK2NNbW1xNGQ5c0pMMnZTUmhkMTJJ?=
 =?utf-8?B?azFLeUJQQ3U1UHg5bUdFeHZBWWloT1k3cE1kdkZMbFk5S1RIQ2xWOUl2ZWUr?=
 =?utf-8?B?RDJ1SGZ1dTlMRzhDVHROUWY1UDM4Y0ExS0VXMWdYWFZNcTVnZ3J2TzJKRnZu?=
 =?utf-8?B?MkEzMkV1SDB2S1NxZC9UZzNHWFZEaWU4THcrWDZNZ0lOaDlqU3AzTFpnWERJ?=
 =?utf-8?B?Tkd5RnVIbmhwMjI2Rkg0SmxEcFI5bFBkR3VuUDBGNStubWtpbXhCVnRhODhu?=
 =?utf-8?B?RWFWTjF3clhhK3g3WVBMa0R1UmxBM1NPbzhoc2dKTlMrdXFnbEF4V09saFJr?=
 =?utf-8?B?emJpNHg5N1BwSGowRlBJODNWMjRaRkRaVmFZcVY1ODJLVW5HeEtkV25OZVdZ?=
 =?utf-8?B?T09hbUJRRmtJMnc0UzcvdmRQTTVURUlLMklnVXFvWVFISHpEaktVWGt1czdJ?=
 =?utf-8?B?cHY1aW1nekNHVXBKamJ4d0gxbjBiK2VUeTg4aENXOUlsUU40NjlSbDgrVzFq?=
 =?utf-8?B?VkFJYTZoN1JCYjhYWEo2aXBadXY3TDdibDVoeU9ubXNqTFlSalZ3cmZiSURG?=
 =?utf-8?B?dkFSS1ZIOW1QcHhtcFdNNDNuYnpUY1pCK1dtWFNORTZqOUpmL25YZVhuQzhj?=
 =?utf-8?B?aHZRaW1WTGU2QWw0ZFFtTWc2K1NEMkhoVUV3aG4wd3VFWmFqQ3ByVUxmUWh3?=
 =?utf-8?B?eUJ2a2gwdjJEcVdHb1FZUlZKK0NmRWY5ektMOWl6L2RjTkwwWERnMkc3eldz?=
 =?utf-8?B?N0JZemtlSTMzL1FTOGtWeUFIWXpsVGZ4ZGxUTDJXdm0vZ0w2ZWxXN2lnTFNP?=
 =?utf-8?B?ZmNPdWcrWkRaSWJiVEZ5SCs3NTJhdC9iMDJNVUxhQ29LTG9QVlZ6eE1LVnJm?=
 =?utf-8?B?L2pZNlhCSEpncXJEYjV4R3FoazI3a3MxRUUybzUzWnZRd0Y3L2M2QnNWMFl2?=
 =?utf-8?B?MjVTSy8ybjJUUmQ5QjR0YUZYSjlLUFM4d2NGYVEyMzErUjExNzVNQ1dpeVN1?=
 =?utf-8?B?KzRQNmttZGF5N2szc3lzNDl0YXFwaG00bkxLNzd3NHNST2I4VWtVMk81WVho?=
 =?utf-8?B?SVBuM1BwVThSN3FQUkhqWmFmaW9hclVHa2tIa0U4UTBDZkZRalVxMkRndUVW?=
 =?utf-8?B?a2cycTNMMnF2Wk5yQ003S3pKYklncUJ5VURPdGdhMjFkenN1Skw3MUU2bks5?=
 =?utf-8?B?REN0SllILzJjWEgwWDV5aTU1MU9tUEpEQjNpNHpXMXNDTldSaFhyd1gxTklw?=
 =?utf-8?B?YzdNM1d5UkFIN3pIWFNNZks5OElpMGlOd0VuNWMzRkRxTjhUb2RmdTgvaHgx?=
 =?utf-8?B?N2hQZkhFZmRpSmwydFluK2VWN0VEZzdkQldwakVvTkxadTZjd1ZJMTdEamtQ?=
 =?utf-8?B?dm5KNEY3U2hDKzJtUEQyN0hQNHloeFhKd1pNZDFQN2lDY1VXcC9OaTNlQloy?=
 =?utf-8?B?akRPOWpoY01VNURzLzdaY21UeVBWN05WMVJwOXV0cDByekRDNnRsZFQ2TzVK?=
 =?utf-8?B?OHFVN3k0Mm5FaHFqTytJamlHRXcrZUN0dVdZLzV3ckZzZnhyVDd4N1VMTko5?=
 =?utf-8?B?K09RNTgxVzlrNnlXRURDVmd3SzNxRWY3aEpwNDRlQ1hoUGRsbU1iYTNLQ1Yx?=
 =?utf-8?B?QXA0NlV4NjNPekE4aHk3RnVzR1U2OXVNRWkxeEkwZGl1T05XbzNjOTM0WnBZ?=
 =?utf-8?B?Z082aHFGcjZwOTJzTUhxcjZtbU1VWmM3dXNuMzE4eG15bklWNlFpdkFFbFg0?=
 =?utf-8?B?UXIzREJ5WnlYbnlKK3k3dWZlUCs0VlZ2bXFKT3JQTGFxNlArR2wrTkdmQVdu?=
 =?utf-8?Q?9Qbx/ufnhyA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5968.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YTBQSUowM2dBYjh4YWVLQTVSaytnaW0vVy9mZ1hyOWd5YnVHU3pEU1pJYnZt?=
 =?utf-8?B?ZW5LaEcxemFOVlRaUlZ4UWd0dU81UkVsZWlrbmd3UTRqWjdLZm5HUjdWZ2tX?=
 =?utf-8?B?ZUlBQzJnZit6SHNIUHVBRllMMjZXU2Z5Mm5RMmtoa0hUL3N0WFpiQ29PNHp5?=
 =?utf-8?B?Tk1EY2Z5UmNvQTh5bUhUT2MyYTFNRUcyNkFUVnRSam8walE2ckx0bTNPcU9x?=
 =?utf-8?B?Wld1L0VZMmRnYlZhZDd1am8xUnVNNEZzNmdJdmNjc1h5U2JKSGk1bFg5ejBh?=
 =?utf-8?B?YmF6VFdwek11UlExdjNWeUdhVFlMdXBTcHNqaDFnRHNxaWVlUTRHS251OTlj?=
 =?utf-8?B?dUpUbDA0aFJWd2c3TXhIWGk3U0JyNEJ5cDh0VUgrOTJxS3E0TG9uYS96cnJt?=
 =?utf-8?B?cTVTME5FNmxQQ1lTRnAyOTZQeVdYRnFJNWh6ZTRWTEZDY00yTGthV1FQdmdk?=
 =?utf-8?B?S0RLOTJkeVpqSnJXT1Qrd3oyWmRFZXFrMzNnY3RFODlROEdQd2d3UVZLU3Ix?=
 =?utf-8?B?Ni96SDZWa2svb20xVlZ2SHlrRUt0TkNVZW9ta2x4ZzFTR1I4azY2MHd2WnVn?=
 =?utf-8?B?WXlTb0REK0dBZFJjaEtYUDNZaDlEY3lLRkZneUw3aXo4M1RkNjd1QWhVSFhS?=
 =?utf-8?B?aE5BZnV6OEdsYWtQSWliRy9mYXV3aGtGSUFyRTd5S29WczBjSWpSeXNVaUlQ?=
 =?utf-8?B?Nmc2eXd6R0Mvek1jNlZDNDhoRCtPdndLeFhsendpTE00ZUZycDFqak9UTVda?=
 =?utf-8?B?bEkyRlFOd0dNeGRtZE1wRVUvSDJFRFlnUENaOURmM3pQMGlaUStKQlNDcFNn?=
 =?utf-8?B?YWk5UFlRU09YdnoyWWhvcnQ1R0MzR1hLNE0vR0JkbzcvUEJUSG9ZVVdWRU5V?=
 =?utf-8?B?dGRIcDZjdmczWW5SWnZ6djRhOWR4VytIQ0RMaVh0V001OG41d3Z1clZkdjFO?=
 =?utf-8?B?YVFEMWdGdmFzaXdnUFl0VzdvZzZvWlBuUFc0Tk05MVRVQVQ0WmJWRXJnVzBJ?=
 =?utf-8?B?MUZQdy9MTVl3N3gwUFp0aWtSRXd2SCt6TGNJV1dnY2VIMGJvRWdlU2taTkcw?=
 =?utf-8?B?K1h5SzlyNEduRFRCcTVzcWdRVzdRWkI3UmRVd0NpRFlQQTY5QWFuOUZCVHJT?=
 =?utf-8?B?RHVlUW1LTE1xbHpiSDVKanBYMlB5UkJpd3Z1RmMwYmJ6MlR3VXNFZUgzVzVC?=
 =?utf-8?B?QUVjdjVySElabzZhYzIrN2ZYb3pFbUtmUmhtS0ZFbldXdVAzQkpLaUhxMnVT?=
 =?utf-8?B?K3JVRW9JQllKRHU2ZUt2TStEYzFaQlpzeXMyY2ZyOEZOZlFqanNENlVyaHlI?=
 =?utf-8?B?RTYyVDM3dDJGRnJBWHZRMzhIWGxIUFZDUUptOXlXUXJtSmlNWXBreHZsK2dz?=
 =?utf-8?B?OENrRXNqTWYzejMwUTJBdnZTV09qNTNlZ1BBVlMzR2N5d3J1c3hRTFhJaDhI?=
 =?utf-8?B?RVc3TWJoaEYyZmFUMzd0VlNPTmo5VklBdXk3M1Bhc2JUYzdmSDR2MDBYSGhB?=
 =?utf-8?B?TEtoeVluNkJXN1c0ZlE3cnNJaVRlUmJFb2tTbGIyaGNReXVuNFMvN08vTmxQ?=
 =?utf-8?B?V1FtSk1pYWdhVnFhaFB2dEFxNmF3OGZ3U3ZJbG5QUVFwNWVmQnAyaUVMZitu?=
 =?utf-8?B?b3FBV21zZTR0dm1NRXV3RnRYamNNNkw0SmVSWndzZnZZM3U4QzVwbFlGeGcw?=
 =?utf-8?B?aWJxRUhSZjlSY29MdFBsaUYwdW41MUNKWXh2aEM1VkR2N29SRjUvM3g1Skxs?=
 =?utf-8?B?RVlJZ29yaGp4V1JURDFGaFUrY0NWYVVtT1IxUmJxOXJpM3VzUmkyNVg3cUJx?=
 =?utf-8?B?bFhBbnE1WGxzZjhJeUhXdUcxTGQvbDVjR1R2SzBNdTVNeWZSaUd1N0I1ZVRE?=
 =?utf-8?B?SVJMb0h0S2xWQkkvQ05XUTBkUlAvdXA4QzYvYzNKa0hTTTJOb3lTNjFmTGhC?=
 =?utf-8?B?TVJ3dk0wWFVjVzkybGhSZHZ0eEpFUmxQdE1uVE5SMGUrVTVweE1ESVFSYWEx?=
 =?utf-8?B?OFE5a2FMQVFBSmh2NGlhdDB0cVp1cE02Y2hkS1lEQW05V1poWmVHVUkvY1d2?=
 =?utf-8?B?a0t6aUZtalFueHRQVlp4emJmbnFuNE1xRkR0MGpBMnRHays2Q1dFQk9zK1JE?=
 =?utf-8?B?aStPK3pnUlV1ZmZvWnIrZU9oQWpvcHpMbStad1pGc3czdjk4TGZKNTRKaVBp?=
 =?utf-8?Q?ihwYGY0JpcxlmjrMVl+oAoc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3fa57ad-1e8b-48ca-c9c5-08dd8e054d14
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5968.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 07:52:37.7645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KduZcOTrT3T6d0WM7bZjRp/GmWNmGljg0onbGDOloj53bnVyEvzSkPT5rFfko/Kalv6vx83es3z7h6nDqC2PLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFDC28CEE69

On 5/7/25 1:43 PM, Amir Goldstein wrote:
> Add helper to utils and use it in statmount userns tests.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>   .../filesystems/statmount/statmount_test_ns.c | 60 +----------------
>   tools/testing/selftests/filesystems/utils.c   | 65 +++++++++++++++++++
>   tools/testing/selftests/filesystems/utils.h   |  1 +
>   3 files changed, 68 insertions(+), 58 deletions(-)
> 
> diff --git a/tools/testing/selftests/filesystems/statmount/statmount_test_ns.c b/tools/testing/selftests/filesystems/statmount/statmount_test_ns.c
> index 375a52101d08..3c5bc2e33821 100644
> --- a/tools/testing/selftests/filesystems/statmount/statmount_test_ns.c
> +++ b/tools/testing/selftests/filesystems/statmount/statmount_test_ns.c
> @@ -79,66 +79,10 @@ static int get_mnt_ns_id(const char *mnt_ns, uint64_t *mnt_ns_id)
>   	return NSID_PASS;
>   }
>   
> -static int write_file(const char *path, const char *val)
> -{
> -	int fd = open(path, O_WRONLY);
> -	size_t len = strlen(val);
> -	int ret;
> -
> -	if (fd == -1) {
> -		ksft_print_msg("opening %s for write: %s\n", path, strerror(errno));
> -		return NSID_ERROR;
> -	}
> -
> -	ret = write(fd, val, len);
> -	if (ret == -1) {
> -		ksft_print_msg("writing to %s: %s\n", path, strerror(errno));
> -		return NSID_ERROR;
> -	}
> -	if (ret != len) {
> -		ksft_print_msg("short write to %s\n", path);
> -		return NSID_ERROR;
> -	}
> -
> -	ret = close(fd);
> -	if (ret == -1) {
> -		ksft_print_msg("closing %s\n", path);
> -		return NSID_ERROR;
> -	}
> -
> -	return NSID_PASS;
> -}
> -
>   static int setup_namespace(void)
>   {
> -	int ret;
> -	char buf[32];
> -	uid_t uid = getuid();
> -	gid_t gid = getgid();
> -
> -	ret = unshare(CLONE_NEWNS|CLONE_NEWUSER|CLONE_NEWPID);
> -	if (ret == -1)
> -		ksft_exit_fail_msg("unsharing mountns and userns: %s\n",
> -				   strerror(errno));
> -
> -	sprintf(buf, "0 %d 1", uid);
> -	ret = write_file("/proc/self/uid_map", buf);
> -	if (ret != NSID_PASS)
> -		return ret;
> -	ret = write_file("/proc/self/setgroups", "deny");
> -	if (ret != NSID_PASS)
> -		return ret;
> -	sprintf(buf, "0 %d 1", gid);
> -	ret = write_file("/proc/self/gid_map", buf);
> -	if (ret != NSID_PASS)
> -		return ret;
> -
> -	ret = mount("", "/", NULL, MS_REC|MS_PRIVATE, NULL);
> -	if (ret == -1) {
> -		ksft_print_msg("making mount tree private: %s\n",
> -			       strerror(errno));
> +	if (setup_userns() != 0)
>   		return NSID_ERROR;
> -	}
>   
>   	return NSID_PASS;
>   }
> @@ -200,7 +144,7 @@ static void test_statmount_mnt_ns_id(void)
>   		return;
>   	}
>   
> -	ret = setup_namespace();
> +	ret = setup_userns();
>   	if (ret != NSID_PASS)
>   		exit(ret);
>   	ret = _test_statmount_mnt_ns_id();
> diff --git a/tools/testing/selftests/filesystems/utils.c b/tools/testing/selftests/filesystems/utils.c
> index 9b5419e6f28d..9dab197ddd9c 100644
> --- a/tools/testing/selftests/filesystems/utils.c
> +++ b/tools/testing/selftests/filesystems/utils.c
> @@ -18,6 +18,7 @@
>   #include <sys/types.h>
>   #include <sys/wait.h>
>   #include <sys/xattr.h>
> +#include <sys/mount.h>
>   
>   #include "utils.h"
>   
> @@ -447,6 +448,70 @@ static int create_userns_hierarchy(struct userns_hierarchy *h)
>   	return fret;
>   }
>   
> +static int write_file(const char *path, const char *val)
> +{
> +	int fd = open(path, O_WRONLY);
> +	size_t len = strlen(val);
> +	int ret;
> +
> +	if (fd == -1) {
> +		syserror("opening %s for write: %s\n", path, strerror(errno));

While I have no opinion about ksft_print_msg() vs. syserror(), I do
think it's worth a mention in the commit log: there is some reason
that you changed to syserror() throughout. Could you write down
what that was?

In any case, it looks correct, so with an update commit message, please
feel free to add:


Reviewed-by: John Hubbard <jhubbard@nvidia.com>


thanks,
-- 
John Hubbard


> +		return -1;
> +	}
> +
> +	ret = write(fd, val, len);
> +	if (ret == -1) {
> +		syserror("writing to %s: %s\n", path, strerror(errno));
> +		return -1;
> +	}
> +	if (ret != len) {
> +		syserror("short write to %s\n", path);
> +		return -1;
> +	}
> +
> +	ret = close(fd);
> +	if (ret == -1) {
> +		syserror("closing %s\n", path);
> +		return -1;
> +	}
> +
> +	return 0;
> +}
> +
> +int setup_userns(void)
> +{
> +	int ret;
> +	char buf[32];
> +	uid_t uid = getuid();
> +	gid_t gid = getgid();
> +
> +	ret = unshare(CLONE_NEWNS|CLONE_NEWUSER|CLONE_NEWPID);
> +	if (ret) {
> +		syserror("unsharing mountns and userns: %s\n", strerror(errno));
> +		return ret;
> +	}
> +
> +	sprintf(buf, "0 %d 1", uid);
> +	ret = write_file("/proc/self/uid_map", buf);
> +	if (ret)
> +		return ret;
> +	ret = write_file("/proc/self/setgroups", "deny");
> +	if (ret)
> +		return ret;
> +	sprintf(buf, "0 %d 1", gid);
> +	ret = write_file("/proc/self/gid_map", buf);
> +	if (ret)
> +		return ret;
> +
> +	ret = mount("", "/", NULL, MS_REC|MS_PRIVATE, NULL);
> +	if (ret) {
> +		syserror("making mount tree private: %s\n", strerror(errno));
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
>   /* caps_down - lower all effective caps */
>   int caps_down(void)
>   {
> diff --git a/tools/testing/selftests/filesystems/utils.h b/tools/testing/selftests/filesystems/utils.h
> index d9cf145b321a..70f7ccc607f4 100644
> --- a/tools/testing/selftests/filesystems/utils.h
> +++ b/tools/testing/selftests/filesystems/utils.h
> @@ -27,6 +27,7 @@ extern int caps_down(void);
>   extern int cap_down(cap_value_t down);
>   
>   extern bool switch_ids(uid_t uid, gid_t gid);
> +extern int setup_userns(void);
>   
>   static inline bool switch_userns(int fd, uid_t uid, gid_t gid, bool drop_caps)
>   {


