Return-Path: <linux-fsdevel+bounces-50127-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F69AC8648
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 04:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FCBDA20F1B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 02:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D0615855E;
	Fri, 30 May 2025 02:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dezfgUX8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46654A1D;
	Fri, 30 May 2025 02:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748572551; cv=fail; b=BQCLdI6iL1ILbOiAgryJmpeWJ/GdaUNE1jJmp1ZXoVaaa52leBylJgkM7id4WzrpSF8xT7xJQ1WaOJJv8kD81W8QhJO0zSZosj8Dup3mdofoY565Vp5RJVxaIeTShIUk4wpZM1NokAR2Oij0Gl7/cCO39Jmxdxb12nfxtMlZMjE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748572551; c=relaxed/simple;
	bh=sC+gkHPe8AGgILz4PldVf/S/EyiYshRhJilUSrjTW58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YEPVFc8mV+CY6a86wyVUBJwIiStdI4YlgkFLL+RTH54yZhzSpS3OpRP4r8vEwsB/4Z3Ye9tVVVh2gceLgXy2JDZHo230JQHXDNn7cPQ5qqcjuE3YQbiLyMyWlIBc53uYJofsu9Jy0shohEjtW1E9DYHOsw78FHaYhfBvjKCwiVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dezfgUX8; arc=fail smtp.client-ip=40.107.243.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ic7vyx15R+pB+GRjjAYGu7mYy7VGgCZACe8gjC5IKtJG/s5GzBZnVu1p1QehDjy31862dsSTcVmbnt30jO5TYSwXr0KEAvwSSKdf2t/1oWYRj+U3P5cnLhCKSjMv+8Q40gOm0gzK6KzxWPmPx9sSmFQGPIU/v1oXMtczlMBSAXxOUL3wn0pYZRFHEHtxmUnmVfKEf0cyEkGtwoiSFo2htiwUNQwnga5JD1ceuByEh6aHu/ScAxvPC/virdMxMrlNBYb0OnPKyA2zMsFtx8G6AJihKOBrZKzgZJNixdW6pqE0UUir8H98P41ulBaix+2+x0Yvdb1oqR61d7N4teHzxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vDqqvKJsxUybszXYVjAwCxa6AkikRdkAySZp6Q9Xdts=;
 b=LdxItmSwpPjTKdA2nUfq6TJn3acXMjiAB2XgqETl4djSPt3sKKQ1jSbrXbPZPWrq9AXmau3Xy3Le7mYfmaIHpUvvz84QRUx4Pp+i2qtgp7FvXza3fEpWrWoD+6fbFvGITVC+be2SqwI/8BJaDWq/Y+Q+O7rPK99HeKCmUYhkfw20akSNIely/gPMRJiH8jNIz4FrCGTQnVKbFfaz2TlG4RBOmAis9Dnw2rB7sta4qai7atWAEOySXS/QTYPsgWqwornPtCXVKMqyuGOe8R07QSMAXsJ3QKPzq+W28nhRsM4MBL9CUAYPxKd1XPz+dap2vgtSsbbUGs1i+puqCQrdYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vDqqvKJsxUybszXYVjAwCxa6AkikRdkAySZp6Q9Xdts=;
 b=dezfgUX8Bpz/SAUoh8OrBNWLbryfZCtveODbRMfLmhA6GsL6DiaPGJJoZxSDju6UYSrAmF2lD76LXUAdeULKqGdOIKc8VkpFeYDBoBAHvmRo9DlbJ/J27ksftSlcOMyYk+UFX9ILsOMk73YwuuIJS8uKvp061Gm1TFmc5E47u6BYJPYmnXk1XXfwepJ5A+eKCI8L/1x84+L+ci2CgDndDFLvQe2+kqyJx5yxNt3y5i3gUu44Lvv6R7bYowCk9eaHt2YDrtKGl/XhCZbxjwL42Bi+UMCWdI6JaIP1Q5Ysl0txqPghuFx/Pq/N22jPhHUSn7+4aOUmK11gNtm3GDTplA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 IA0PR12MB8086.namprd12.prod.outlook.com (2603:10b6:208:403::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.30; Fri, 30 May 2025 02:35:46 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%4]) with mapi id 15.20.8769.025; Fri, 30 May 2025
 02:35:45 +0000
From: Zi Yan <ziy@nvidia.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, hughd@google.com, david@redhat.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm: shmem: disallow hugepages if the system-wide
 shmem THP sysfs settings are disabled
Date: Thu, 29 May 2025 22:35:43 -0400
X-Mailer: MailMate (2.0r6255)
Message-ID: <548AFF46-93AF-40CB-80E4-372DAAA9F80B@nvidia.com>
In-Reply-To: <6132583a-1754-4eb1-9b84-19b55cac176c@linux.alibaba.com>
References: <cover.1748506520.git.baolin.wang@linux.alibaba.com>
 <c1a6fe55f668cfe87ad113faa49120f049ba9cb5.1748506520.git.baolin.wang@linux.alibaba.com>
 <BB3BDA79-3185-4346-9260-BA5E1B9C9949@nvidia.com>
 <bd89651e-0ee0-4819-87da-d3a5db04c5b3@linux.alibaba.com>
 <D61B9FA2-4EAC-4F0E-AF56-236D37A766BE@nvidia.com>
 <6132583a-1754-4eb1-9b84-19b55cac176c@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BL0PR02CA0044.namprd02.prod.outlook.com
 (2603:10b6:207:3d::21) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|IA0PR12MB8086:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a445a22-9f1e-474d-062e-08dd9f22ade9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SkRWRndPSlU1ZS9WeDNEL1RvY2o1QnAweERlTXFqcTI4Q1VJaVFoVEw1VVRz?=
 =?utf-8?B?WjFTWmRFckVRZGM4K09wMFhVTlFCMURoT1U4UG5PdkpkUHNneFQ3bDl0dGNV?=
 =?utf-8?B?NUFINGZoVUhacGxaNm1ORmR2azFoK1gwSWdXK0NxM01ycm9QQmtpZFlOYk40?=
 =?utf-8?B?aXQvdmVmL3BwOEZnajQ2eEhqWkNrTXYrVi9DTHk2cGZsZUQ3Z09HeGdFa1Rm?=
 =?utf-8?B?THNzQlV1Vk9BNC9tamdJUmd0ZUZpUlB0Y1dTTGxsRjBqSVI2c0hWUzZoeUdx?=
 =?utf-8?B?WUY0ejBQM3RHVzRQZnlNeiszWUFHaUZEQWozd1RrWVBIRG81K05ZNW9EVWRI?=
 =?utf-8?B?THlha2VjYWpOQllzTS9ocjRLU1lqY0kzYU9SZXZCVjFRaUoxZURvUjRibHZP?=
 =?utf-8?B?cUQ1eWU0U045YXUrWlkzTjR4a3ZuU0VpQjNpeG5oWTZmNXl2a2NpVUQrSGJu?=
 =?utf-8?B?RWd3Y2hsYmVyQklTbklFNkVqZHVOWHF5VVNQdUpUV2JxWWZpblozc3g3TXg4?=
 =?utf-8?B?NVdUekpyc05ueUtFYmpkVEZsdWZLcmVLYkU3dDJyUTlCL2RNZ2lIR1VWUWpa?=
 =?utf-8?B?Y1FDaXlkb2xNZWRRYWNqL1A1a2JjaHZobUhvaHM4aGhkK2Q4KzJNZ1NHTGlO?=
 =?utf-8?B?eXRTM3dscnlmakwvQXVpT204Nkl1ZzRPbHlqRE83bFJjZUIwS1BFb3VzRjEw?=
 =?utf-8?B?TUdBTXZyQmt5bDdFRlNFU3dJOWFQQmlOMDcraGxSZnFheTBuNnhDZ0ExRHlE?=
 =?utf-8?B?OWttZmRJbEJHT01SbXROWnNrTitrK2M2L2RvaTE0YTg4aWp4MjRKNEF6MTdn?=
 =?utf-8?B?STJMcTFFb1hnTkhUOTlMbmJFZ3E0dFVqNHl3ZDJ6ZzVBVEhHT0ZsQXhEcEdq?=
 =?utf-8?B?dmRkNW5SUW1tck1jbjlYa0JUTXpYdjNKUW1md3JyOTZoZmEzejFBcDJFVUxu?=
 =?utf-8?B?aTREUzRKaGNPTURGRTU0dytBYkg4ZVk2RjdWcXhLakVyNWo1c0xDaTBHZ01j?=
 =?utf-8?B?M1ova0o5Uk1uZC9CMmM1M1drU3RKQnVSQ1FZVW1Bd3UzU1QxcStMMEhjdDl1?=
 =?utf-8?B?cEhoRzZoa1lLRWxicmppR3cyUWsvNU8vbjczS2VxSlduN056SVM5Ykd1V2pR?=
 =?utf-8?B?TDIvbXhIV2FFZ2sva3dUZU4zS08rVThjeDVmMG1UeFREZmtqeFlINWVBdEox?=
 =?utf-8?B?bTFyMkJhL2ZtOGZUdDdYd3JkblJKd0JaR0N5QndDbXVsd01Md09mKzNOMHB2?=
 =?utf-8?B?c0l5SGh2aXcyd0VidEc3eVFtbnhxbUVzMWJJSVE0cS9RbDJzRXFKOVdHbzVW?=
 =?utf-8?B?STlJZ3d5VGJmZEJOQmpLNlFVWGxEYUFiVCtMQUlSZ3RFaDFNK0MzM2Z5MHJE?=
 =?utf-8?B?V2xxQWpDakd4SW1DdzZtK3hUOWhETU5MOWRhT1FCVFpoZHVtTnNSbEUrT1g5?=
 =?utf-8?B?b0NSUnlaeVk0RG04bkxPaEplc05ZcWQyaFlpYldVeTJPWGpJSHBHdVpZM1kr?=
 =?utf-8?B?djhhWm1oVUc1TzN2c25PV2Q2ZThZd3laaVRRUTNZWXUrempBYnUwQ2JsZ3Bu?=
 =?utf-8?B?VFdTOFdqenM5M1d1bnpWWXRsYU8ycklYQnh4STRINVNyNTBlTlNzZll5d2dz?=
 =?utf-8?B?cDMzSlFSVnlydmhoU1ZjbWp0SkNZb2JmNVk4MGJTSVZUSHNvMGZVcEk1clNi?=
 =?utf-8?B?cTk2Uzc5Nk5NcVBNZW5FdG43ZlNzNHg5NlduUXZUYjNia2xwNlpuOVIxTVJW?=
 =?utf-8?B?SXZzLzl3VVpjQ29pOU9UY3BUc1p6NzAxK01hd3p1aHlsWis3SDI5ZVlZSnNR?=
 =?utf-8?B?dzVNbG5JMDhkL2lsYnhxREhLZW9KVyt2N1lGWitzNzBXWEF1TVFYOWhVSDQx?=
 =?utf-8?B?ZHZETlRNM2dDTEhNVTRmYnRtK25XV1EwYnF2ZEdxUStDd004cnprVkpkcU9Z?=
 =?utf-8?Q?Z8jqie2wFfA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z05laExqNmpiTS9jRVhTUEJ5MStBL01GRjlwWGduYzRuekwvcHh6NmNBcDVZ?=
 =?utf-8?B?SC9HVkZhNjAyZFIwVkE5MGZ0N1ROSlI3UjYyTVdkNFQ3MkkwdityOVRJUC9t?=
 =?utf-8?B?RkEzTkpiNjB1amRDTFNoZHBHd1RQRFZzRkZ5bDIzL2VZa0FvU01mYTM1eEc5?=
 =?utf-8?B?d0RJbHFHVXFwMFZSZXE4RjNRU3QvcEd6RmZjRkdzWlEvck5KZXlrVzQ5eHpw?=
 =?utf-8?B?VTg2MDFnZzRmRENRU1JIVW1yVzM2QWNXMThUME14Ri9NTDUrY1ljdlhZMWZ3?=
 =?utf-8?B?MTdERE9MM1k2Y0FUanRzQU9NUXpFdTdtbzhpc2c5N01JdE1peHE3Q2xJV1RF?=
 =?utf-8?B?OEp1VndwYmkzVXRpclJkMXNTbFliR2s1UHU4cUMyaHdRQXlLWHdNMEVpWFJk?=
 =?utf-8?B?am1uUnpaei94djhGWW1xNFlwMHJ0RVY5S2ljOW5iUFFxUHdaU0M2T2VDMExk?=
 =?utf-8?B?U1drS0pDMC9EY0xlOGtHZE1JaGhJTTNGYVYyR3lXa0FZVWxGTFR4TE9iSHg3?=
 =?utf-8?B?VitqZTUyYnhQSk9QVEIzaFBHYzNLSTN1QzJTT1FWTW1ieXU1NnhqVlNxemFp?=
 =?utf-8?B?ejY3UlJKUzZwWWEzOTZvakhpMy9VV1NjNXlCdit5OVRzN0ZBdERLajl5L1p6?=
 =?utf-8?B?RnBoaEhaOU5SV3phUHdQRFMvOXk3ekRBU1U4aGxqbDVlcVVXNGdua2FxcC92?=
 =?utf-8?B?MW92Zk5qd3grQ1oxNkZsYkVXRGQ2dWpWRFEwWER6WVF3MUwzR0lKdC9mRUFi?=
 =?utf-8?B?YjlFZnlGSU40SHdZR2pNMGJpM3lURjRhajljcnJkb2pZWnl3d1JjdkFLVmNv?=
 =?utf-8?B?UlAzcGJSajdCUXMrdkpSejJDWWU2Z2lkZ1ZJa01tcUVycEM2b2h3b2Z6Snht?=
 =?utf-8?B?MlJ2cXFEVVlrMnZDM2VGZEY1UFlqd3BwWENPbHNQV1c4U2FqSC92Yjh1TlVX?=
 =?utf-8?B?ZldCalMrNTBxRGJUcENIYS84d09OVld6UGRmYXR6L25uK2dncERqOWFuOU9x?=
 =?utf-8?B?QWtCbzJiSmFzcWcyeHltVzcvVFJWakJVSnRtK0J2YnVPVGpLK0tRQkJCSzRp?=
 =?utf-8?B?YWZQY01HemU4WTBGdmFZNU5OT3FDRmR2Rm5QclpxRm45Sk85eHpWb2doZGFq?=
 =?utf-8?B?SHpEbjc5YkM5ZG1DQVVKdzgwQlAyN1JjazN4aFlFQklTZTdxRm8yWmV2SHBW?=
 =?utf-8?B?cEZuTjhLMldxU2gwTVdzbU12RDVNTU1lOFZRS3V1ZE00cmhBSWRuQXNrUEh1?=
 =?utf-8?B?VW1yODhSMk5iek9xVjZJNDdrM09wOEQ1TGg1U1pLNkJIWjlHVXU5ZmUzSUtu?=
 =?utf-8?B?VE9pTUoyaG5QSjZNdVlNMm42K3FDbUVOTU1OL2QwTUtDdy8vSEZsc1lSUzZz?=
 =?utf-8?B?Lyt1eDVWS3RLRmNwbHJoTGxUaXgwcnZjM3BuWUpyOUdZUTNxZnpBdXNpV2pq?=
 =?utf-8?B?Y0xHNzRYRW1YeTkvV0xXY0FOcEtkbW1lV3J2a2VYUnpZSHhxdmtkT0RrTitJ?=
 =?utf-8?B?VzVlT01YR0RaY2JtUEhseUN5ZjhjV05IRHJQcG9yczFnYlduRmZkbzRNcENC?=
 =?utf-8?B?MmpocnlEWDY3T2RkN1RDZVcxWGtLbXZETGI2Zlg0cmQvNHpWS2RheE1zQnR6?=
 =?utf-8?B?dXR0blZGMktDNTBaTVkvVjBkazlvVmxlWUQ4VTNuZlpJZzZsdlFzR1diMmlG?=
 =?utf-8?B?blQ3MlVsYy9IbnljUHFzNU9hckFxMUJZOER6ZU1VTzRlYyt1eEloTm9ab1Qw?=
 =?utf-8?B?Q1JxRzdMUU1veGNiR3JtQk9ocmtqTmpINi92eXhLWXhTVE9VMFpIeE5jZHRI?=
 =?utf-8?B?VHN4RExmcXZtazJ2RXpJSjRwNFV3ZTIxWHIvaThMd0JDTlFFTmg3dS92MllC?=
 =?utf-8?B?aWF1YVQ1ajd6djJkRVZHZkI0cUZza3ZIQnJ0VURtWlBVbi9QVnlmRlRSVmdW?=
 =?utf-8?B?bDMzZ2FIbEhvWm54NWNENE4rT1F2WU9iMTFMZnZkNFhWQ1RtU2ZvZzgzeGlK?=
 =?utf-8?B?VldCNHdCeGFEalhLQTdMU3FxVDFDSTJZZVNmK2VQSVVxUGxTN3VGL0duY0VR?=
 =?utf-8?B?K2RVejlYZW5kdVBVR1c3M1NxVlNLa3hGZzViY1lIcmVtM3ZYUEs2SWJWd3VB?=
 =?utf-8?Q?AFKLvKYHuZtZpbB+ox/SnEQ68?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a445a22-9f1e-474d-062e-08dd9f22ade9
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 02:35:45.2922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4+DbfD8istRcAy6jT1id5uhoe/opRsgMaYWH9cdc5bqNmG3JRZUtjYOFgvPxp1h7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8086

On 29 May 2025, at 22:32, Baolin Wang wrote:

> On 2025/5/30 10:17, Zi Yan wrote:
>> On 29 May 2025, at 21:58, Baolin Wang wrote:
>>
>>> On 2025/5/29 23:21, Zi Yan wrote:
>>>> On 29 May 2025, at 4:23, Baolin Wang wrote:
>>>>
>>>>> The MADV_COLLAPSE will ignore the system-wide shmem THP sysfs setting=
s, which
>>>>> means that even though we have disabled the shmem THP configuration, =
MADV_COLLAPSE
>>>>> will still attempt to collapse into a shmem THP. This violates the ru=
le we have
>>>>> agreed upon: never means never.
>>>>>
>>>>> Then the current strategy is:
>>>>> For shmem, if none of always, madvise, within_size, and inherit have =
enabled
>>>>> PMD-sized mTHP, then MADV_COLLAPSE will be prohibited from collapsing=
 PMD-sized mTHP.
>>>>>
>>>>> For tmpfs, if the mount option is set with the 'huge=3Dnever' paramet=
er, then
>>>>> MADV_COLLAPSE will be prohibited from collapsing PMD-sized mTHP.
>>>>>
>>>>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>>>> ---
>>>>>    mm/huge_memory.c |  2 +-
>>>>>    mm/shmem.c       | 12 ++++++------
>>>>>    2 files changed, 7 insertions(+), 7 deletions(-)
>>>>>
>>>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>>>> index d3e66136e41a..a8cfa37cae72 100644
>>>>> --- a/mm/huge_memory.c
>>>>> +++ b/mm/huge_memory.c
>>>>> @@ -166,7 +166,7 @@ unsigned long __thp_vma_allowable_orders(struct v=
m_area_struct *vma,
>>>>>    	 * own flags.
>>>>>    	 */
>>>>>    	if (!in_pf && shmem_file(vma->vm_file))
>>>>> -		return shmem_allowable_huge_orders(file_inode(vma->vm_file),
>>>>> +		return orders & shmem_allowable_huge_orders(file_inode(vma->vm_fil=
e),
>>>>>    						   vma, vma->vm_pgoff, 0,
>>>>>    						   !enforce_sysfs);
>>>>
>>>> OK, here orders is checked against allowed orders.
>>>>
>>>>>
>>>>> diff --git a/mm/shmem.c b/mm/shmem.c
>>>>> index 4b42419ce6b2..4dbb28d85cd9 100644
>>>>> --- a/mm/shmem.c
>>>>> +++ b/mm/shmem.c
>>>>> @@ -613,7 +613,7 @@ static unsigned int shmem_get_orders_within_size(=
struct inode *inode,
>>>>>    }
>>>>>
>>>>>    static unsigned int shmem_huge_global_enabled(struct inode *inode,=
 pgoff_t index,
>>>>> -					      loff_t write_end, bool shmem_huge_force,
>>>>> +					      loff_t write_end,
>>>>>    					      struct vm_area_struct *vma,
>>>>>    					      unsigned long vm_flags)
>>>>>    {
>>>>> @@ -625,7 +625,7 @@ static unsigned int shmem_huge_global_enabled(str=
uct inode *inode, pgoff_t index
>>>>>    		return 0;
>>>>>    	if (shmem_huge =3D=3D SHMEM_HUGE_DENY)
>>>>>    		return 0;
>>>>> -	if (shmem_huge_force || shmem_huge =3D=3D SHMEM_HUGE_FORCE)
>>>>> +	if (shmem_huge =3D=3D SHMEM_HUGE_FORCE)
>>>>>    		return maybe_pmd_order;
>>>>
>>>> shmem_huge is set by sysfs?
>>>
>>> Yes, through the '/sys/kernel/mm/transparent_hugepage/shmem_enabled' in=
terface.
>>>
>>>>>    	/*
>>>>> @@ -860,7 +860,7 @@ static unsigned long shmem_unused_huge_shrink(str=
uct shmem_sb_info *sbinfo,
>>>>>    }
>>>>>
>>>>>    static unsigned int shmem_huge_global_enabled(struct inode *inode,=
 pgoff_t index,
>>>>> -					      loff_t write_end, bool shmem_huge_force,
>>>>> +					      loff_t write_end,
>>>>>    					      struct vm_area_struct *vma,
>>>>>    					      unsigned long vm_flags)
>>>>>    {
>>>>> @@ -1261,7 +1261,7 @@ static int shmem_getattr(struct mnt_idmap *idma=
p,
>>>>>    			STATX_ATTR_NODUMP);
>>>>>    	generic_fillattr(idmap, request_mask, inode, stat);
>>>>>
>>>>> -	if (shmem_huge_global_enabled(inode, 0, 0, false, NULL, 0))
>>>>> +	if (shmem_huge_global_enabled(inode, 0, 0, NULL, 0))
>>>>>    		stat->blksize =3D HPAGE_PMD_SIZE;
>>>>>
>>>>>    	if (request_mask & STATX_BTIME) {
>>>>> @@ -1768,7 +1768,7 @@ unsigned long shmem_allowable_huge_orders(struc=
t inode *inode,
>>>>>    		return 0;
>>>>>
>>>>>    	global_orders =3D shmem_huge_global_enabled(inode, index, write_e=
nd,
>>>>> -						  shmem_huge_force, vma, vm_flags);
>>>>> +						  vma, vm_flags);
>>>>>    	/* Tmpfs huge pages allocation */
>>>>>    	if (!vma || !vma_is_anon_shmem(vma))
>>>>>    		return global_orders;
>>>>> @@ -1790,7 +1790,7 @@ unsigned long shmem_allowable_huge_orders(struc=
t inode *inode,
>>>>>    	/* Allow mTHP that will be fully within i_size. */
>>>>>    	mask |=3D shmem_get_orders_within_size(inode, within_size_orders,=
 index, 0);
>>>>>
>>>>> -	if (vm_flags & VM_HUGEPAGE)
>>>>> +	if (shmem_huge_force || (vm_flags & VM_HUGEPAGE))
>>>>>    		mask |=3D READ_ONCE(huge_shmem_orders_madvise);
>>>>>
>>>>>    	if (global_orders > 0)
>>>>> --=20
>>>>> 2.43.5
>>>>
>>>> shmem_huge_force comes from !enforce_sysfs in __thp_vma_allowable_orde=
rs().
>>>> Do you know when sysfs is not enforced and why?
>>>
>>> IIUC, shmem_huge_force will only be set during MADV_COLLAPSE. Originall=
y, MADV_COLLAPSE was intended to ignore the system-wide THP sysfs settings.=
 However, if all system-wide shmem THP settings are disabled, we should not=
 allow MADV_COLLAPSE to collapse a THP. This is the issue this patchset aim=
s to fix. Thanks for the review.
>>
>> Got it. If we want to enforce sysfs, why not just get rid of TVA_ENFORCE=
_SYSFS
>> and make everyone follow sysfs?
>
> Now MADV_COLLAPSE will ignore the VM_HUGEPAGE, while the others will chec=
k the VM_HUGEPAGE flag before using 'huge_shmem_orders_madvise' with the TV=
A_ENFORCE_SYSFS flag set.
>
> That is to follow the rule: =E2=80=9Callowing for collapsing in a VM with=
out VM_HUGEPAGE in the "madvise" mode would be fine".

Can you add this rule in your commit message? It clarifies things.

>
> So I think we should still keep the TVA_ENFORCE_SYSFS flag.

Got it. Thank you for the explanation.

Acked-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi

