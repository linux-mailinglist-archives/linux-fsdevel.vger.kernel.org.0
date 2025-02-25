Return-Path: <linux-fsdevel+bounces-42608-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C94A44DC8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 21:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1684B4229CF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 20:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC052153C5;
	Tue, 25 Feb 2025 20:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LPtdLYYq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6B920E6E4;
	Tue, 25 Feb 2025 20:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740515579; cv=fail; b=YZDRcT5nxlpDLV8Xp+0adxTEmDcxZf+X+1+2GfwG9dPS3jT2du+BvC1+cIuRrkqa7KiCj+ftMgBkI6EgNF2Ou/gGVm/g0VqnhoB9pyRJmj0ZnwUGjEvBhhOZB4lm7SYfMJuuB6udHfDAek1rRFSOmmX5sEiUV+c++LyaeniPsp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740515579; c=relaxed/simple;
	bh=1mqyr7T6BTpjc3tMHQJEd+8VS3hY54P1A3MNcUOyeD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UZ9eZgq3/cUfWN4wKvFfHMwdQ2U3ZBZ+X4ms4QYKd8bP1MaUVCPuMhSlWAPDqNdWsgp/aouJ9WNhwdOIBT/uAVXHdWFrST+9p+dVHSr52bJn7N73IZpCEIrjhgU8eOWF3BT4lpTrzO9IsB6APQfEKbSr3GBx5ybZNWMOUzNAbUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LPtdLYYq; arc=fail smtp.client-ip=40.107.92.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JHDOdT2PA/aCVMGMsPTPCbxnXd5Dp2mw8QbE9tkNcV1yHxsynBPLMFpB470N24RbUMQ3N3G2qfqztlPOSf8YllFKBBHap/dl1wdnEty0rVusBDIMst7DIa8RMWNkTPNTBIsMQKV8Q9Pp2hA2lrtKiDn75176oN6ohYR21CL/W5RGHJ++P0+nWDYiZthplr/WOv9K7sroCfLrxBatle8JwdWhHz3iGJcsiW/YItDPooQOoXlbi3GxAbe3KDd1XUMz7ctN6bWq8uAU2DKewBydDuxLXwkjtlRADiXe3leFLpmwosMhFt8Hipu+KTO90uHP2vak3SEZEwZDoxFdy7T0FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VZq0pjuA5BNXjRRnXUvOKbU8wZkkhPTA7czP3bIpxw4=;
 b=uTmdVrxbbnIqFXORDJvArapzxakOvub1udOs2x8Qfm9XUlcBBi8hPyvUkhN2b3meMkuECDOCsYCD2CBbrcS8wwylMo8vSeTfrX5jjLCxr0PtnWSev1efW8qfkcMk2F5C1OViHQj2o6gla8n7/sb5abARGWL2xoPdwdM/JtRI5O6xQ2nHD8uOc7cYrU7qG61evKPsVxXuBRXz00gYaUMyhEfsDQ7VeWyxgu05amdoNTTdzY5ChzMvdncxMGhTl9MfoJrWsuMgmkOkYwMqOn6LRC7uRdbuxQIsPABoP9dBUqbMJrUeM+I3+iK5Vk67f/JHNiQ1B4ylSzqULTGmfKWtbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VZq0pjuA5BNXjRRnXUvOKbU8wZkkhPTA7czP3bIpxw4=;
 b=LPtdLYYqYp97tuPfjmaYkQ/AOeOUTQZiTH30mhgeklrYSqVlmYmwWQnBrLvd7jPuU3tIn4dv7OMzED17Rt1HNahFXqeBYDRPY9ImULDIBvWItr/RABhfIg0nJk3oXobPiz4V4lCshV+ciXrDliF2vNpYXi+faYoSgArFdayevzW8CPyCTqrM0mZlzZimbJEPDaRrdIgIGIxzK/6gQ7VW7cbzj4gWBIleyGF5/0RtXNqhTEiVSwZE1ryvhbNWM6yqGv0EjUhcXJBvb2IIvrwdZ7UtwoTd5ZbLwIGVx4OCqUMVGi5wGHF6SI+XvGK2yneGg5CbXo/CWY0v3XPt/71TLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SN7PR12MB7107.namprd12.prod.outlook.com (2603:10b6:806:2a2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.18; Tue, 25 Feb
 2025 20:32:54 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 20:32:54 +0000
From: Zi Yan <ziy@nvidia.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: <linux-mm@kvack.org>, <linux-fsdevel@vger.kernel.org>,
 Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>,
 Kairui Song <kasong@tencent.com>, Miaohe Lin <linmiaohe@huawei.com>,
 <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 2/2] mm/shmem: use xas_try_split() in
 shmem_split_large_entry()
Date: Tue, 25 Feb 2025 15:32:50 -0500
X-Mailer: MailMate (2.0r6222)
Message-ID: <AF487A7A-F685-485D-8D74-756C843D6F0A@nvidia.com>
In-Reply-To: <C643A2FC-316F-4AA2-8788-84E5D92793F2@nvidia.com>
References: <20250218235444.1543173-1-ziy@nvidia.com>
 <20250218235444.1543173-3-ziy@nvidia.com>
 <f899d6b3-e607-480b-9acc-d64dfbc755b5@linux.alibaba.com>
 <AD348832-5A6A-48F1-9735-924F144330F7@nvidia.com>
 <47d189c7-3143-4b59-a3af-477d4c46a8a0@linux.alibaba.com>
 <2e4b9927-562d-4cfa-9362-f23e3bcfc454@linux.alibaba.com>
 <42440332-96FF-4ECB-8553-9472125EB33F@nvidia.com>
 <37C4B6AC-0757-4B92-88F3-75F1B4DEFFC5@nvidia.com>
 <655589D4-7E13-4F5B-8968-3FCB71DCE0FC@nvidia.com>
 <bd30dc5e-880c-4daf-a86b-b814a1533931@linux.alibaba.com>
 <af6122b4-2324-418b-b925-becf6036d9ab@linux.alibaba.com>
 <C643A2FC-316F-4AA2-8788-84E5D92793F2@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SJ0PR03CA0017.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::22) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SN7PR12MB7107:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dd495d7-e3ad-46d7-a45e-08dd55db94be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UmJEVGJzbjg2b3REbEdLTThWUSt0SVJnWm12dnJHSDdWNUdiQVJzQUtLMCtF?=
 =?utf-8?B?VWpsWk1xMUpoNVc0YThsdC9Bd0pLR1pOamdSM1FwdG43eDM0R0lZVFJIeUQw?=
 =?utf-8?B?VlZEVmlMVFF1aFVEZUczY2FneThxZHZPRms2Sk92dEkvZldBVkprbjBtT09T?=
 =?utf-8?B?ZmExN1QzcXZXV3hDRGRaeVQxOWRnWndaU3R4TjFBNHFQV28xWFAvZGJodGg4?=
 =?utf-8?B?bFRMRUJudUhxN21OQ25tSE4zMjRSZXJSaDRZT0l4eTJ0Q2p6bzNlb1dGTVpM?=
 =?utf-8?B?UTRLdi9CT0lVQUNrckdJYXorNmVlUW5qQllXQXBmQmpaeGcwb1VUOUkyOG9q?=
 =?utf-8?B?Q3JNRGN6QktvYzJZcEdIWXFPZ2tWcm9XZnFyV0xyS0gvNk1ZSk5LcFdhRTdP?=
 =?utf-8?B?VEpHY0F1bkoxbVFlajRPYXQ0STc0Nm1QalNiU005bWRPaEhEd0tQU0xmMlpR?=
 =?utf-8?B?WWE3R25YOEkwN0FQTTFyeVQ2OHpuQ2tRTzhrOCtEWWVGWUFscFlOQW9XM1Ix?=
 =?utf-8?B?eUIwc1NXMFZxeVpwSGt1alVPcDFnVUIrb211OHpsZWVmMlpkNUpWaDI0TGNP?=
 =?utf-8?B?R3NlK0JVeVBqbHpEQ1NRU2trbEFtMDNpbjlUei9aY2RHWVhEWVFLdTM5R0tP?=
 =?utf-8?B?L1ZDNEg4ODZvUFovMlRMaHNqbitlbkNGUzZxMEVpbFFmaEhCQktWdWtpanNH?=
 =?utf-8?B?YVFzZlpCYm5QUzgxdFJsd0pHYUZWWnRhNnRmdDI0RnROZUo5UlpYOHBtNDhw?=
 =?utf-8?B?VVViL0g2eTRtY2kzWVhpYTV0Mm9uWjZSMXpiVENXZ25mQlBROVhpRFJ3YW53?=
 =?utf-8?B?S1piayttVXpDV1RDSnV4R2Y2RGUwQldKQ3g4YVNBVUhWVnJ6SjdoMUN4OXFZ?=
 =?utf-8?B?NW9HZ0sxQ2twcnhmeVZIRDBaMy9xVE5YeUdicTdVWXc1RXdtZ1hjYkNmZ2x0?=
 =?utf-8?B?TWJqd2prbzU5TElKNVVzOVJNZ1JldGpnNlcwdU16Q1ZqQzdmUTdiVk1vcE9W?=
 =?utf-8?B?dGhuNTZGdU03WEJLRHkwRGJIUFIraFFMSFNoMW11dUlQMWxTUHE3cDJ5VEtx?=
 =?utf-8?B?bmJmcmVxZUd1L29pdXBzeFVBbUF2VVpTYjFBb2R6NUlmWEFTb3BtN2UzZUV6?=
 =?utf-8?B?bnYxOE5ab0hiZ091bThoUjFtU2ZQRnllUUUxSGZSQ3owOFd2UGU2NWdNMldv?=
 =?utf-8?B?bmVCbXUzNjVqUkhKMkpCMzV2QzFuV2VELzY1OGRzdjlnYTk2YzRaRG94VG9p?=
 =?utf-8?B?dG9kcjVtd2dOSTRjV2g2cmVWM09QOTI1amtNSnRCQjV6SDRzNWg2enVpOWJu?=
 =?utf-8?B?L2tBRUlsQTdxa3I5aVNpNFVCWWFFc1BIcjQ3TVNWMWJFZlp4dlJ3L1kyZjBq?=
 =?utf-8?B?bnlDS3F2N3VmcTluWVI0VkhmUW5tdWp0Vlp3cHpFOWMyUGZMTDFIbi9Vd2V1?=
 =?utf-8?B?dnQ3S0x6aXZ6QWJUOGNKMVFwa3FLa3ZZakR4WUhQRE9TTEZGNHJReDVGK2J5?=
 =?utf-8?B?bGJlR3kxN29jZXZhTU81ZlJod2JFR29OTnB6WEtNR05mdkFrVXZTQVR3RFQv?=
 =?utf-8?B?MUo2UE45aFB0RnlnazVGeXZLc1hVTTZtNFlHa3gxelNHbE5DSUFjNW0zZWJt?=
 =?utf-8?B?QnhzRU1pOWNPS0ZOMGxldVZ6Q0c2dGczY2UyODJjYTZxNExJb0p2dXlrVlNU?=
 =?utf-8?B?aXJGdXJkZkZ0QWdxOTBBWFEyc2N6NFZYRGQvbWprWmV3WWc0T1d4TTRBYmhu?=
 =?utf-8?B?YjBySlFJaEE3NjRjVHhDK0I4by9ZVUI3WE84TEFucjFEQnN5NGdQb0hWTzdz?=
 =?utf-8?B?a0d5MG5SZDhwWTV0dzZaN0JuTy9NeitRUW4xOEYrQ3lUeC9nb1VDZEgyN2Uy?=
 =?utf-8?Q?vdxfU+750NI6m?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L3VFdkd3Z2s1T3NtZnlQakpIa25wakhFdlZVRDQ2bWpIMTlYc2Yzc3lYSzc4?=
 =?utf-8?B?Tm1lTGR3Vkd6L3dZK3J5V1ZMUXRWTlk4Mm9Tb1UzSWl6eDFhMmp2UUxsQ094?=
 =?utf-8?B?TE5hRVNJTmMrQ0tqUy92RHZXaXJYWk0xaGpVWmZNYTJzWXpzcVF6OHdnMk5V?=
 =?utf-8?B?YzVSQ3M0NnZzN3AraGZES3I0dmdEaTNySmM0VW1tVFBkSDNVZ0dEUlRtVU41?=
 =?utf-8?B?c3drL0d3YnFtc0U4dnVDRHFCN3pHMUorOVh1b2lWRStZaFRJZW5VczJycTJS?=
 =?utf-8?B?S0VKclBxS0tpZ3hMTTVRaUpuRXRWWVBZVXNISUR2YUppS29sM2pRaFpEMnVB?=
 =?utf-8?B?UnQ1aEFOVHZ6RElqd0NDTkN1WnpkUngzd1BjbTVMZGJrTTZjQ25neDRYL09W?=
 =?utf-8?B?bUtvVGJHU1laUXRNZFhFVzMxYVMzZ2R5VVNaV3BQak1ZTzFJektpNFNWaHpD?=
 =?utf-8?B?dkhGcjZKbzJ0U1BzVzJoVHMvck1yMzR3eXF4RnBDdHcvVk9PVGwxc1BkeS9R?=
 =?utf-8?B?WXM2ZWphclpETHNnT3F4WmZ6RlNIUjY3WnhpcFJwZ3FObUs1ZEJ2QXlPWGlI?=
 =?utf-8?B?V2tGOWpuTm5vTCtRajRFanZkcHZMaVNGblFkOTlMWXNLVUx0SWlhUUk5amkz?=
 =?utf-8?B?WkxuUVZoNEs2MDFhbGkza25KMzlpb3g0OXJlb0gvK2dRQVdMTlFzYkh2anlG?=
 =?utf-8?B?STBIbTIyWUFsV3FWbXZyT3dDODNnd09TYnlzQTB2R1BSbTFSYnBkSEc4QlNB?=
 =?utf-8?B?RnYxeTBuUjN4N00yRERtK0VQY0t0UkJHT296azZBRk4wZXN6QWdIWHdTVy9y?=
 =?utf-8?B?OHoxNzB4WmE2QkJWM1phNk5xY2hFMjkzTzNaQmp3K2hnb0p0cXBCTEpZU3Nv?=
 =?utf-8?B?M2k5MGVIN2g2QmRUU05nNnFZWjh3VkdxNis1T1VaM2YrdmhGRW1YZG8wTlA5?=
 =?utf-8?B?L2RsM1JCZ20yVWpEbUxlZjcxRm9qb1ZaWnBKWE1YUGI0aHl6MUdaOXcvN2Jp?=
 =?utf-8?B?NXdaU2o4aEZpNmhieGI0dk5YbmFZOEVLaGRYNWQwdEg1K1g0aUdVNVNVcktO?=
 =?utf-8?B?SlVQOFRuQlU2alhmTEMyaGkxdHRvYW9tL0FlUkNqS25pajJwaWQ0Vm1sS1d0?=
 =?utf-8?B?Tm9GaW1kbi9ldVY3Z1dxbW9sSlY5bW9EMUxXNzJldldKYUwvSXZVNXo0cDZu?=
 =?utf-8?B?UzFGN05QZ3V3TUtlWkVkS1hzeW9wTUczMGNRRlBvSFM4UGF3VEdydUJFZ1ZM?=
 =?utf-8?B?aU91dGd4d29yeDV0OE9GNXA4UmpyVllIZGRjbktJSC9GaGRIQ0trN003WGdE?=
 =?utf-8?B?djg4Y3JOQlFZUEx2VWRsM2huQzI1QVhiMTlRZ1VFWDlJTzREMjd4Y1pNMUFt?=
 =?utf-8?B?OG92M01vdlNjb2NrdUZwU3IyZmhwK1Q5MVZQT0xlZ2tBS2hlSlh0RWJjQ1pI?=
 =?utf-8?B?Zkdwei9nMnRvN0d5L2syZytHNjNkTFBRT25ycXNvMnNWRUFhR20ybVVvcDFi?=
 =?utf-8?B?YWVRNDNheXlUREVIZ04rV3YzRDFrRURQa21GbG5tVDlpcWhSVVJIRytaOG9N?=
 =?utf-8?B?RXhuRTJLRW5ValBaR2p5ZEE2SkJOdlIyZmxlaTlEVU1BMDRucllUNjlXSkxE?=
 =?utf-8?B?bk42Z0Yya2RGblcyVUxXeDgrN3Y1b1d3K3NQTWcrYnArV2c4MmNEN002OXRu?=
 =?utf-8?B?V2QrODBZMWRFMGp6MDVUQ2R6Q0M5VHZCb0M0NnN1bERVM0tILzE1MHBXUTNo?=
 =?utf-8?B?aFhrdWQxeURqcEdDblUwWlNta1p6STBGSXhuN25wdjJHWmFDWXZ4MS9QWHVs?=
 =?utf-8?B?eFBRTXp2ODNyQjN3MWtrbnNubGV6WlBZS3BkT1ZSTVd6emt6ZHJrV0czUENZ?=
 =?utf-8?B?WUFMbG0rYzJ4RERvWk9HRkpvS2dTMkg3d091MmtLU0dBdVoyQmtUOStUKzBL?=
 =?utf-8?B?SjhtaVloclhyTTZxRkQ5Z0NrNWU3Q3F5cFJFRVFNYWt4VThtdzRRd0tGMjU4?=
 =?utf-8?B?bUpFeXdTcXVNbzF3N1hxR1VJR3V0K3BXMWJCVUR3WlRBWnFKeVQ0Kzg4UW1P?=
 =?utf-8?B?TzBuK2hLQzg1S0tzd2pnTkJ2enRYUEZoa3lTN2hjbTcxWHlzN3lhMG5nS2d5?=
 =?utf-8?Q?zP4CkjIH/C+/ib/HwpHiO36tL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dd495d7-e3ad-46d7-a45e-08dd55db94be
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 20:32:54.0475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UcDPxXqkHI/HyweFtpm1JnzGHqy0dPbjSLhmiz+a4h6R9K24Ueuug4RigiU8Ig5S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7107

On 25 Feb 2025, at 11:41, Zi Yan wrote:

> On 25 Feb 2025, at 5:15, Baolin Wang wrote:
>
>> On 2025/2/25 17:20, Baolin Wang wrote:
>>>
>>>
>>> On 2025/2/21 10:38, Zi Yan wrote:
>>>> On 20 Feb 2025, at 21:33, Zi Yan wrote:
>>>>
>>>>> On 20 Feb 2025, at 8:06, Zi Yan wrote:
>>>>>
>>>>>> On 20 Feb 2025, at 4:27, Baolin Wang wrote:
>>>>>>
>>>>>>> On 2025/2/20 17:07, Baolin Wang wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 2025/2/20 00:10, Zi Yan wrote:
>>>>>>>>> On 19 Feb 2025, at 5:04, Baolin Wang wrote:
>>>>>>>>>
>>>>>>>>>> Hi Zi,
>>>>>>>>>>
>>>>>>>>>> Sorry for the late reply due to being busy with other things:)
>>>>>>>>>
>>>>>>>>> Thank you for taking a look at the patches. :)
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> On 2025/2/19 07:54, Zi Yan wrote:
>>>>>>>>>>> During shmem_split_large_entry(), large swap entries are coveri=
ng n slots
>>>>>>>>>>> and an order-0 folio needs to be inserted.
>>>>>>>>>>>
>>>>>>>>>>> Instead of splitting all n slots, only the 1 slot covered by th=
e folio
>>>>>>>>>>> need to be split and the remaining n-1 shadow entries can be re=
tained with
>>>>>>>>>>> orders ranging from 0 to n-1.=C2=A0 This method only requires
>>>>>>>>>>> (n/XA_CHUNK_SHIFT) new xa_nodes instead of (n % XA_CHUNK_SHIFT)=
 *
>>>>>>>>>>> (n/XA_CHUNK_SHIFT) new xa_nodes, compared to the original
>>>>>>>>>>> xas_split_alloc() + xas_split() one.
>>>>>>>>>>>
>>>>>>>>>>> For example, to split an order-9 large swap entry (assuming XA_=
CHUNK_SHIFT
>>>>>>>>>>> is 6), 1 xa_node is needed instead of 8.
>>>>>>>>>>>
>>>>>>>>>>> xas_try_split_min_order() is used to reduce the number of calls=
 to
>>>>>>>>>>> xas_try_split() during split.
>>>>>>>>>>
>>>>>>>>>> For shmem swapin, if we cannot swap in the whole large folio by =
skipping the swap cache, we will split the large swap entry stored in the s=
hmem mapping into order-0 swap entries, rather than splitting it into other=
 orders of swap entries. This is because the next time we swap in a shmem f=
olio through shmem_swapin_cluster(), it will still be an order 0 folio.
>>>>>>>>>
>>>>>>>>> Right. But the swapin is one folio at a time, right? shmem_split_=
large_entry()
>>>>>>>>
>>>>>>>> Yes, now we always swapin an order-0 folio from the async swap dev=
ice at a time. However, for sync swap device, we will skip the swapcache an=
d swapin the whole large folio by commit 1dd44c0af4fa, so it will not call =
shmem_split_large_entry() in this case.
>>>>>>
>>>>>> Got it. I will check the commit.
>>>>>>
>>>>>>>>
>>>>>>>>> should split the large swap entry and give you a slot to store th=
e order-0 folio.
>>>>>>>>> For example, with an order-9 large swap entry, to swap in first o=
rder-0 folio,
>>>>>>>>> the large swap entry will become order-0, order-0, order-1, order=
-2,=E2=80=A6 order-8,
>>>>>>>>> after the split. Then the first order-0 swap entry can be used.
>>>>>>>>> Then, when a second order-0 is swapped in, the second order-0 can=
 be used.
>>>>>>>>> When the last order-0 is swapped in, the order-8 would be split t=
o
>>>>>>>>> order-7,order-6,=E2=80=A6,order-1,order-0, order-0, and the last =
order-0 will be used.
>>>>>>>>
>>>>>>>> Yes, understood. However, for the sequential swapin scenarios, whe=
re originally only one split operation is needed. However, your approach in=
creases the number of split operations. Of course, I understand that in non=
-sequential swapin scenarios, your patch will save some xarray memory. It m=
ight be necessary to evaluate whether the increased split operations will h=
ave a significant impact on the performance of sequential swapin?
>>>>>>
>>>>>> Is there a shmem swapin test I can run to measure this? xas_try_spli=
t() should
>>>>>> performance similar operations as existing xas_split_alloc()+xas_spl=
it().
>>>>>>
>>>>>>>>
>>>>>>>>> Maybe the swapin assumes after shmem_split_large_entry(), all swa=
p entries
>>>>>>>>> are order-0, which can lead to issues. There should be some check=
 like
>>>>>>>>> if the swap entry order > folio_order, shmem_split_large_entry() =
should
>>>>>>>>> be used.
>>>>>>>>>>
>>>>>>>>>> Moreover I did a quick test with swapping in order 6 shmem folio=
s, however, my test hung, and the console was continuously filled with the =
following information. It seems there are some issues with shmem swapin han=
dling. Anyway, I need more time to debug and test.
>>>>>>>>> To swap in order-6 folios, shmem_split_large_entry() does not all=
ocate
>>>>>>>>> any new xa_node, since XA_CHUNK_SHIFT is 6. It is weird to see OO=
M
>>>>>>>>> error below. Let me know if there is anything I can help.
>>>>>>>>
>>>>>>>> I encountered some issues while testing order 4 and order 6 swapin=
 with your patches. And I roughly reviewed the patch, and it seems that the=
 new swap entry stored in the shmem mapping was not correctly updated after=
 the split.
>>>>>>>>
>>>>>>>> The following logic is to reset the swap entry after split, and I =
assume that the large swap entry is always split to order 0 before. As your=
 patch suggests, if a non-uniform split is used, then the logic for resetti=
ng the swap entry needs to be changed? Please correct me if I missed someth=
ing.
>>>>>>>>
>>>>>>>> /*
>>>>>>>> =C2=A0 =C2=A0* Re-set the swap entry after splitting, and the swap
>>>>>>>> =C2=A0 =C2=A0* offset of the original large entry must be continuo=
us.
>>>>>>>> =C2=A0 =C2=A0*/
>>>>>>>> for (i =3D 0; i < 1 << order; i++) {
>>>>>>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0pgoff_t aligned_index =3D round_dow=
n(index, 1 << order);
>>>>>>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0swp_entry_t tmp;
>>>>>>>>
>>>>>>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0tmp =3D swp_entry(swp_type(swap), s=
wp_offset(swap) + i);
>>>>>>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0__xa_store(&mapping->i_pages, align=
ed_index + i,
>>>>>>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 swp_to_radix_entry(tmp), 0);
>>>>>>>> }
>>>>>>
>>>>>> Right. I will need to adjust swp_entry_t. Thanks for pointing this o=
ut.
>>>>>>
>>>>>>>
>>>>>>> In addition, after your patch, the shmem_split_large_entry() seems =
always return 0 even though it splits a large swap entry, but we still need=
 re-calculate the swap entry value after splitting, otherwise it may return=
 errors due to shmem_confirm_swap() validation failure.
>>>>>>>
>>>>>>> /*
>>>>>>> =C2=A0 * If the large swap entry has already been split, it is
>>>>>>> =C2=A0 * necessary to recalculate the new swap entry based on
>>>>>>> =C2=A0 * the old order alignment.
>>>>>>> =C2=A0 */
>>>>>>> =C2=A0 if (split_order > 0) {
>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0pgoff_t offset =3D index - round_down(index=
, 1 << split_order);
>>>>>>>
>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0swap =3D swp_entry(swp_type(swap), swp_offs=
et(swap) + offset);
>>>>>>> }
>>>>>>
>>>>>> Got it. I will fix it.
>>>>>>
>>>>>> BTW, do you mind sharing your swapin tests so that I can test my new=
 version
>>>>>> properly?
>>>>>
>>>>> The diff below adjusts the swp_entry_t and returns the right order af=
ter
>>>>> shmem_split_large_entry(). Let me know if it fixes your issue.
>>>>
>>>> Fixed the compilation error. It will be great if you can share a swapi=
n test, so that
>>>> I can test locally. Thanks.
>>>>
>>>> diff --git a/mm/shmem.c b/mm/shmem.c
>>>> index b35ba250c53d..bfc4ef511391 100644
>>>> --- a/mm/shmem.c
>>>> +++ b/mm/shmem.c
>>>> @@ -2162,7 +2162,7 @@ static int shmem_split_large_entry(struct inode =
*inode, pgoff_t index,
>>>> =C2=A0 {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct address_space *mapping =3D inode=
->i_mapping;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 XA_STATE_ORDER(xas, &mapping->i_pages, =
index, 0);
>>>> -=C2=A0=C2=A0=C2=A0 int split_order =3D 0;
>>>> +=C2=A0=C2=A0=C2=A0 int split_order =3D 0, entry_order =3D 0;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int i;
>>>>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Convert user data gfp flags to xarra=
y node gfp flags */
>>>> @@ -2180,6 +2180,7 @@ static int shmem_split_large_entry(struct inode =
*inode, pgoff_t index,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 order =3D xas_g=
et_order(&xas);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 entry_order =3D order;
>>>>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Try to split=
 large swap entry in pagecache */
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (order > 0) =
{
>>>> @@ -2192,23 +2193,23 @@ static int shmem_split_large_entry(struct inod=
e *inode, pgoff_t index,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xas_try_split(&xas, old, cur_order, GFP_N=
OWAIT);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (xas_error(&xas))
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto unlock;
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 /*
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Re-set the swap entry after splitting, and th=
e swap
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 * offset of the original large entry must be co=
ntinuous.
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < 1 << cur_order; i +=3D (1 << split_=
order)) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pgoff_t aligned_index =3D rou=
nd_down(index, 1 << cur_order);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 swp_entry_t tmp;
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D swp_entry(swp_type(sw=
ap), swp_offset(swap) + i);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __xa_store(&mapping->i_pages,=
 aligned_index + i,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 swp_to_radix_entry(tmp), 0);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 }
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cur_order =3D split_order;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 split_order =3D
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xas_try_split_min=
_order(split_order);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 }
>>>
>>> This looks incorrect to me. Suppose we are splitting an order-9 swap en=
try, in the first iteration of the loop, it splits the order-9 swap entry i=
nto 8 order-6 swap entries. At this point, the order-6 swap entries are res=
et, and everything seems fine.
>>>
>>> However, in the second iteration, where an order-6 swap entry is split =
into 63 order-0 swap entries, the split operation itself is correct. But
>>
>> typo: 64
>>
>>> when resetting the order-0 swap entry, it seems incorrect. Now the 'cur=
_order' =3D 6 and 'split_order' =3D 0, which means the range for the reset =
index is always between 0 and 63 (see __xa_store()).
>>
>> Sorry for confusing. The 'aligned_index' will be rounded down by 'cur_or=
der' (which is 6), so the index is correct. But the swap offset calculated =
by 'swp_offset(swap) + i' looks incorrect, cause the 'i' is always between =
0 and 63.
>
> Right. I think I need to recalculate swap=E2=80=99s swp_offset for each i=
teration
> by adding the difference of round_down(index, 1 << cur_order) and
> round_down(index, 1 << split_order) and use the new swap in this iteratio=
n.
> Thank you a lot for walking me through the details. I really appreciate i=
t. :)
>
> My tests did not fail probably because I was using linear access pattern
> to swap in folios.

Here is my new fix on top of my original patch. I tested it with zswap
and a random swapin order without any issue. Let me know if it passes
your tests. Thanks.


From aaf4407546ff08b761435048d0850944d5de211d Mon Sep 17 00:00:00 2001
From: Zi Yan <ziy@nvidia.com>
Date: Tue, 25 Feb 2025 12:03:34 -0500
Subject: [PATCH] mm/shmem: fix shmem_split_large_entry()

the swap entry offset was updated incorrectly. fix it.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/shmem.c | 41 ++++++++++++++++++++++++++---------------
 1 file changed, 26 insertions(+), 15 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 48caa16e8971..f4e58611899f 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2153,7 +2153,7 @@ static int shmem_split_large_entry(struct inode *inod=
e, pgoff_t index,
 {
 	struct address_space *mapping =3D inode->i_mapping;
 	XA_STATE_ORDER(xas, &mapping->i_pages, index, 0);
-	int split_order =3D 0;
+	int split_order =3D 0, entry_order =3D 0;
 	int i;

 	/* Convert user data gfp flags to xarray node gfp flags */
@@ -2171,35 +2171,46 @@ static int shmem_split_large_entry(struct inode *in=
ode, pgoff_t index,
 		}

 		order =3D xas_get_order(&xas);
+		entry_order =3D order;

 		/* Try to split large swap entry in pagecache */
 		if (order > 0) {
 			int cur_order =3D order;
+			pgoff_t swap_index =3D round_down(index, 1 << order);

 			split_order =3D xas_try_split_min_order(cur_order);

 			while (cur_order > 0) {
+				pgoff_t aligned_index =3D
+					round_down(index, 1 << cur_order);
+				pgoff_t swap_offset =3D aligned_index - swap_index;
+
 				xas_set_order(&xas, index, split_order);
 				xas_try_split(&xas, old, cur_order, GFP_NOWAIT);
 				if (xas_error(&xas))
 					goto unlock;
+
+				/*
+				 * Re-set the swap entry after splitting, and
+				 * the swap offset of the original large entry
+				 * must be continuous.
+				 */
+				for (i =3D 0; i < 1 << cur_order;
+				     i +=3D (1 << split_order)) {
+					swp_entry_t tmp;
+
+					tmp =3D swp_entry(swp_type(swap),
+							swp_offset(swap) +
+							swap_offset +
+								i);
+					__xa_store(&mapping->i_pages,
+						   aligned_index + i,
+						   swp_to_radix_entry(tmp), 0);
+				}
 				cur_order =3D split_order;
 				split_order =3D
 					xas_try_split_min_order(split_order);
 			}
-
-			/*
-			 * Re-set the swap entry after splitting, and the swap
-			 * offset of the original large entry must be continuous.
-			 */
-			for (i =3D 0; i < 1 << order; i++) {
-				pgoff_t aligned_index =3D round_down(index, 1 << order);
-				swp_entry_t tmp;
-
-				tmp =3D swp_entry(swp_type(swap), swp_offset(swap) + i);
-				__xa_store(&mapping->i_pages, aligned_index + i,
-					   swp_to_radix_entry(tmp), 0);
-			}
 		}

 unlock:
@@ -2212,7 +2223,7 @@ static int shmem_split_large_entry(struct inode *inod=
e, pgoff_t index,
 	if (xas_error(&xas))
 		return xas_error(&xas);

-	return split_order;
+	return entry_order;
 }

 /*
--=20
2.47.2



Best Regards,
Yan, Zi

