Return-Path: <linux-fsdevel+bounces-41680-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB86BA34DB4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 19:28:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 246E516274F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 18:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6DF245018;
	Thu, 13 Feb 2025 18:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2Wn+U3xb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C811B2063E2;
	Thu, 13 Feb 2025 18:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739471282; cv=fail; b=fiUp4xLF8ELIIKFixEJjdrbkHdB5PPXa0bgJhBm2+rbpc21C9/lOmeQDjuc0vkI7ZGMemYT7YUrUDPIRNenil6fyt26j7NLNxAUo6K/ZU6jaae6EzVeYD7+gD39Tf90EltmfZnTRBqAKjm9SKkci6wt1c1PahTxj+T3L+xunm+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739471282; c=relaxed/simple;
	bh=BglIWmBjqltfLB1LjcPlBSyFeZvYnLSH9g0taNL3HIk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ho+rylqzjE/oFjGgdX2ZtKElephbTFxcqobPm+dzHLjgXUr7rTH47gp1TkdM//1QAZk6fpK+4wfFHVmBrL3lsOsu3V3+GCsF2vUZ7sk6XoB+UKlRecorq3xL5zcSejz7Yn6HqK+NamYsToVE1RAOLqWZNRi2O49GDqbpOjpHKgI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2Wn+U3xb; arc=fail smtp.client-ip=40.107.223.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OVhi99XUjriLFktW84psoO97IMvMI1cBAkncyxd1uOC8ifb5vxutPJej9RERxjnEbuHFe1fcehqTBHpw865338M2fHulT5+VvMKjWNhxefFGJ5tFhX/dwMc/1RtmVjaAHSyM6LGWwhk1txMiptmIi2jAfQqqTIwYW6QEaEyXST9D2KRI9TX75bbszZsmOhLmGQhFJl5WXxuHgJkjb5P56MvgdfKy5LY/QmgnhM4f/y3TXmtFE9Y0BU7nLcjFx4+TXlXR6f5qjw2hz/uvFfYLRsMSOecGQKCELYzZWHvIuTxdWZhiEgPZklJHfpgSBSs8t26sLlaM81Tq5++ZN7QaoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c2u2F3izwstCkzLPwiv5yUTi9AIJ/ADcVcOB9wS1anU=;
 b=gKwKTzmhOCzJBwQEj9gt2GATJEc7RptlgeMygG5zQZ9UOUz9EXxv/iqDit2wQxsc4b/Zo/7k8SQQFX1fO+WeCSKjALoet9RhxK9nRxU5KsmAeaDalGuuNQTQUCTsM+Hq+MtptOxh4P1+DsZ2BaVseo9wvhiW6TL6qqVN+OxQuN0igUGtlP7cS8XJej0L6MQjYHpU+PpQs3iKd2ouWWadbuFRZSLXJq1T51MD2xmY0RDl+MUMDzB7PJNTk0CoSw6rjlDfSuZkaUN5FKeGS7zycjZ5ai73lx2jGpLo9FD4mWoxclHgqMpG0TqZrfigfkWc/VOfsHwlV98zzXuUKVKzQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c2u2F3izwstCkzLPwiv5yUTi9AIJ/ADcVcOB9wS1anU=;
 b=2Wn+U3xbh2z28ru1IWE0Q3RNx1OwxDDScllYEEY9x/of/OeF3GTqz6uMrdzIrqZWP97PrUugeA2Gu2n+6OR8VPOirod0YalSEP0zLYtY7r+zjp3cihk3J4GCG3+5h9lKYyjkck1t6wBTKcEsVk67kcmc2z/0Rx85/jpknQ2v6OE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4262.namprd12.prod.outlook.com (2603:10b6:610:af::8)
 by SJ1PR12MB6026.namprd12.prod.outlook.com (2603:10b6:a03:48b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Thu, 13 Feb
 2025 18:27:58 +0000
Received: from CH2PR12MB4262.namprd12.prod.outlook.com
 ([fe80::3bdb:bf3d:8bde:7870]) by CH2PR12MB4262.namprd12.prod.outlook.com
 ([fe80::3bdb:bf3d:8bde:7870%5]) with mapi id 15.20.8445.013; Thu, 13 Feb 2025
 18:27:58 +0000
Message-ID: <5f6c92a9-cc1f-48fe-a2a3-67e1ede8006a@amd.com>
Date: Thu, 13 Feb 2025 23:57:48 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 3/3] KVM: guest_memfd: Enforce NUMA mempolicy using
 shared policy
To: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
 willy@infradead.org, pbonzini@redhat.com
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 linux-coco@lists.linux.dev, chao.gao@intel.com, seanjc@google.com,
 ackerleytng@google.com, vbabka@suse.cz, bharata@amd.com, nikunj@amd.com,
 michael.day@amd.com, Neeraj.Upadhyay@amd.com, thomas.lendacky@amd.com,
 michael.roth@amd.com, Fuad Tabba <tabba@google.com>
References: <20250210063227.41125-1-shivankg@amd.com>
 <20250210063227.41125-4-shivankg@amd.com>
 <824f7d52-3304-4028-b10a-e10566b3dfc0@redhat.com>
Content-Language: en-US
From: Shivank Garg <shivankg@amd.com>
In-Reply-To: <824f7d52-3304-4028-b10a-e10566b3dfc0@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0051.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::13) To CH2PR12MB4262.namprd12.prod.outlook.com
 (2603:10b6:610:af::8)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4262:EE_|SJ1PR12MB6026:EE_
X-MS-Office365-Filtering-Correlation-Id: aa83e11c-87f7-4447-2391-08dd4c5c23e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?REhHZUpIN1ByZFVIMDRRRlJVVVdXWHZJUk05OGk4QmV3dHY5cHhZUHlLcUgv?=
 =?utf-8?B?WGdmMlc2SURuaHBuM21wSEljS284bVFtaXJCV3JzdzhpUzIzLzM3Smg0b0xM?=
 =?utf-8?B?c2Nhc1RXOWpWZXFjckNQSUdYdDFQYUw0alY1RnNpVnRpaU9WTUVZNDkrTUo4?=
 =?utf-8?B?Vm0zRXlBaERvcmlpdy80a3puSlZ3eHIyRXc2VzJNU0dheUlSakh4di8xd2I3?=
 =?utf-8?B?RGFuN1hnODc1TFVlQXRSTVdhc28reklLMUtPcFhlOTJuQ0dKU1ZnMHhPbFJa?=
 =?utf-8?B?OFB1dDhtR01LSm1SYUZPWlA3Y0xZWWZYV2Ftby9ucnMySFN0a3BUNkZSMG4r?=
 =?utf-8?B?dE9iQkVaVlNEb3d6NnpWbFZ2QzJ1VEFiZFVWelVodCtIZjh3U3JlemFER1Rx?=
 =?utf-8?B?NnY3dnVKLzNTVW5VTThLT3pYdkk2WXlNYTdkYXJkYlBPbG03NkQwRlhvVXVN?=
 =?utf-8?B?bWp6eWV6cEFFMXFWWmgzWEFUazBxWE9LaXhpN3JRVXNvbks5SEU4K0xQemd2?=
 =?utf-8?B?aDlmOU5pNTNjNjB5M1dRWWN0WTh4ZnpSN254YUdvMTdlSm1MWWxrWDVTMjZV?=
 =?utf-8?B?M2oxbTAwaTZsN2t5OUFjdnpKZFpOaXF3ak9rc0pEbHVCWTIyRHdVSEVOVVc1?=
 =?utf-8?B?Q3hPelJKc0xUOExzcG9CTHVOU0lkOGNJR3hGYU9TbmNneWdzSWhJSWxyeEF3?=
 =?utf-8?B?L2M1cTNYajdEL0NZT1o2VWxSVFpZL1pXUm1lSUVvdllKaS9IWUpBWGZuVUNh?=
 =?utf-8?B?endlZE1aSzl1dkcvcytDL2ZnTmZWOTN0QS8zdWtCL2VvWWNEcW5wbEQxT2VB?=
 =?utf-8?B?T1psZVJaVVpuY0F0L2E3ZlRUQWZvcjlXZTA2blZtTWliZkFGczZZTldmd1Fy?=
 =?utf-8?B?bVBBNVEyTURSU3JRVDdkSTZaYUdBZ2dEb0FsZVVTVnB1UEhLLzI1WmxmTWxQ?=
 =?utf-8?B?VW8rR3R5Y0V3dVAxOTBhS1NrUEoxejVjajFWcUpRNklNOXhkYUxVRTlsRkI4?=
 =?utf-8?B?cFUxYUZ2KzE0YXFqaGF2ZkNQbmxDUWw5ZDAzQ1hxZFE2TFJ1TzIzNldaM3FT?=
 =?utf-8?B?WUNNbElZeHRwa1dZSjNqcTFkYXVWTmZmYmRkdU5OV1V6emZzL1lDTmY3MnFj?=
 =?utf-8?B?VFdEelhPVUU5R2VCdnFjZ0lkUXpsMlBraVdROVZveTJiRitvMTRWbTV1bGJI?=
 =?utf-8?B?bncza0UvTnlocXF3MmZaSjB3ZE0rbjdMTkJWYWREbDVUbGhKMC9Gd3dPbVpj?=
 =?utf-8?B?RStFWXo3NTRkREgzM2ZEcDZ2aXU5TG41RTJrWG1DWFFEcytLVU5qVDFMclYx?=
 =?utf-8?B?b2syMWszV1NsbWhwczhoMnVybEJVTmJ0ckZXZTZCaUs2YzB6OWlUYXROVjFO?=
 =?utf-8?B?bXN4VjVITy81SVNYRXl0YVZVVnZza0JHRTFWb3p6K0pFZVZkZGRYbS9ySTdM?=
 =?utf-8?B?NjUvT1E4d293V3RETytOa1kweHh5dkVBUjNERGlGRUlPRmRnV09yRUQvOUI5?=
 =?utf-8?B?M3FUaUVZV1daSUdFU1d0Y1BzZDlmNWZTZ20ydGVldkY0dVF4NG9lRklvY3J3?=
 =?utf-8?B?K1gveW5DbFlhZkVjdjdwdFVVS24wanBxb2pNbUZaTElMN25wVEkwYWQ1aTZr?=
 =?utf-8?B?ditsc2VFQzBqRVhQbHZmaUlsbm9UanlJQVB2dGpPK29LaDg3MWcvZHhFSUZK?=
 =?utf-8?B?ejFTUzRITkZ1MFZCWjFSUmRsQkVZQ2JZb20waFhPMUx5WDUzdFlYSmh2eDlJ?=
 =?utf-8?B?b2ZlNzdTdDZPK0FYd2ZWc2V1SkJOeGFLK3dScDMyd205cC9vbVQ0RlhMdWJr?=
 =?utf-8?B?bHVxeUZMdnJBRm54eGVpcjFGcnlTcHRjVUQ4cGJkS0QwMG1JY1BsUlJpOXVC?=
 =?utf-8?Q?UNuFMgZb02dt9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4262.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VmN4T3FHNU5saTJpb3NKenVaSkhYR05QTGhFbkhqdGIzd3phK3p1TFlCWGJD?=
 =?utf-8?B?RzZrUjBGdkhVNVhKVDNvWEtaSFNldTBFTlBaRGFja1RLSDNSU2VKZmlYUUdw?=
 =?utf-8?B?SVUybk04dWdNekdsV01GL0QxT1Fjd3EvVGF2OExDZ24wa3E5RDFoalhNWTF3?=
 =?utf-8?B?UlpQWUJhcWdDSzdId3pRTnlTcGM1Nk53dmZEaTI2MjFOaFhzRE9TYkM5Vzkv?=
 =?utf-8?B?Y1RFTDkwdmhBR3k2UDNHWnJUZ0szTXRPQkVRdVAzalZ6OTV5eFdQczlHTEl2?=
 =?utf-8?B?MmI2MjhOWThsQ3NQVlhCL2RPK2VFNFhVckZGNm05dXgyeVBtTEpBdHdZSVlH?=
 =?utf-8?B?QWczdTVna2FZVjBSWWtOcGtlRkJacHd3WFdKVW9Ld1J2QVBPejdMc3EyZnJL?=
 =?utf-8?B?bU9hcjNQZ1hDMDVaUWpkY1JGRW9KRytVSkU1dU9DSUFnTnEvRjFkeUdMYnBK?=
 =?utf-8?B?UlUzaG1NQytWblkxOUFqSFZkWERGcU9ycUtBK1BSZ3NwTlRSUnlyNE05SFYv?=
 =?utf-8?B?RkRyRWhDdGlPMkFJbkdzbVpudDk2L3J5a013S05abEN6M2JENHBIVlFsR240?=
 =?utf-8?B?VXFUZEVmNVZVaE9oakFsM0x5WXFaUHFqdmFpOTVldHFKSXQ3Y3o3VHpncmJI?=
 =?utf-8?B?MDdyRzFXbGVJREllbmlBUHVLZUtYU0pPZThRc0lXS2EyN2Vrb3NvTERFR1Ji?=
 =?utf-8?B?V0lQWXhCeDl3ajNKT1E4Qkw2cVkybWsrRnFhdmZOa1pyZlg4dS8xUVJOL0Mz?=
 =?utf-8?B?UVVGbjBqNUdGQlNpWWhrM3BJdmRaaHFqZmtaNENFblcyMXAwY0pLY0xMTmQw?=
 =?utf-8?B?bUt1bEIwMGoxL1F4dU9pWVJtaUp1a3BSMUFsTDhtNXkycVovY21tQndoTFVx?=
 =?utf-8?B?UXNDYmRjM2ZNc3hkQm94UDZLaG10SXlXVFpyMVdCSnVJaVh2U2RabXpXUzkw?=
 =?utf-8?B?UHdFMHpHK2pUWGppaitiaVZtZG41TlFNN1ZuUjJlZjJsNG5xSlBGUk5EWkFQ?=
 =?utf-8?B?R2VDM2ExeE5YTlZyN0ZUdk4xVGdoLytKRmlNNlBBUmlPSFRZM1RpZzNnRnFo?=
 =?utf-8?B?a3dFWkVZcVVXamwyNllkdUFzQ1NpSmF0bVNYNGdXTkZ6aG9uYUlPK1dFUU9P?=
 =?utf-8?B?ekdZb1FzNjN4U3crdWxBRStnQTRkS2VQcUY2Rk9lakIzbThwbUt0NThQZTdI?=
 =?utf-8?B?aEhqaWtVNHpHRVB1L3c0eWJkQnBRVmpNM0kySmp4K1NESWsrTDh6ZHJ4dkVF?=
 =?utf-8?B?QUtKdHI0K0pWMG95RC9HUVFNRXNpNkZXWnJkOVloemZzMzdsRzlkcml2UzRZ?=
 =?utf-8?B?M0Nndk4vaTFOcHB0YklBM0QxYVg3NFFwT2NkcWZqMmI1SUFEL0haSG9KTDBz?=
 =?utf-8?B?bmJ2c0tyMHpaN2puTUZlbGU0VUtXUThQV0h5bzZLVmV4a1RMM3M3QW9aelZW?=
 =?utf-8?B?NW1rdWtyNVoreVlDK2VqN0NTQkFmUnRuYzc0cG5HN1hYV1BWSjBlbVJNQmFF?=
 =?utf-8?B?bzJLWGNrK1pKZENmSWV2ZytDOGhuaC9zY1V4OVAzRzRNeU9IWjRWS3lMbEl3?=
 =?utf-8?B?MWJFbmhvVFo4RnpSejdIOHhsUEI3cmt2NU1nSkxVS004WG1JQysvSVV0bVV5?=
 =?utf-8?B?eWRsQWJHcUZ0cmd2Z0lmWWpYY2NUd0pya05Sd0xxY1RxekVYeTBxY3VwdnRy?=
 =?utf-8?B?TjBaSTArZGo0YmpyY3U4eFdNSEFKckEwUnNWcWNTUGxkTDd4YVdYdksvVUVw?=
 =?utf-8?B?UjFoenNOVE1ETlFaL1M1M3RqV1dnWWhkVHFUUlNBazl0TFBoMU5qaWRuT0Jh?=
 =?utf-8?B?YXppSXE1Tm9JVW1WZENTVG02WjZTR0M5cVVrTzI1UkIwTXRXdTFwOGFsZEJn?=
 =?utf-8?B?S2VWa0tNczhveGRYWk5VdVBZZWdYUmVlblJLdURkMDFPaGVvSjFWN0RNa2Z5?=
 =?utf-8?B?UDIzN1Q2NE5nYmJtUjlrOFJNWStXY2ZOOEdXRjJwWkZXVWMrQWNONjBYd1BC?=
 =?utf-8?B?N3JEdTZ3L2gwcXdTUGxNUGUydEM1TG8wUjlUVzZaSU5KVVY1aG1hUmwzRlJV?=
 =?utf-8?B?L2VGcm9CUnBHbE9xMytLbklpUUV0L3FGajJ6WHBoWlRUTDNwSTFnVE1RaDBu?=
 =?utf-8?Q?HI+1B21YOAXOMcQGAKVSAY4pe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa83e11c-87f7-4447-2391-08dd4c5c23e7
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4262.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 18:27:58.2755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p8U9MgHOACp7MZlhBRXDtQ6N7j9XKM4QkEfd8xk3RRmwSPVZx6quZ0JHVCpMDCDhuEZJXtIyl45rGT0c/E4Eaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6026



On 2/12/2025 4:09 PM, David Hildenbrand wrote:
> On 10.02.25 07:32, Shivank Garg wrote:
>> Previously, guest-memfd allocations were following local NUMA node id
>> in absence of process mempolicy, resulting in random memory allocation.
>> Moreover, mbind() couldn't be used since memory wasn't mapped to userspace
>> in VMM.
>>
>> Enable NUMA policy support by implementing vm_ops for guest-memfd mmap
>> operation. This allows VMM to map the memory and use mbind() to set the
>> desired NUMA policy. The policy is then retrieved via
>> mpol_shared_policy_lookup() and passed to filemap_grab_folio_mpol() to
>> ensure that allocations follow the specified memory policy.
>>
>> This enables VMM to control guest memory NUMA placement by calling mbind()
>> on the mapped memory regions, providing fine-grained control over guest
>> memory allocation across NUMA nodes.
> 
> Yes, I think that is the right direction, especially with upcoming in-place conversion of shared<->private in mind.
> 
>>
>> Suggested-by: David Hildenbrand <david@redhat.com>
>> Signed-off-by: Shivank Garg <shivankg@amd.com>
>> ---
>>   virt/kvm/guest_memfd.c | 84 +++++++++++++++++++++++++++++++++++++++---
>>   1 file changed, 78 insertions(+), 6 deletions(-)
>>
>> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
>> index b2aa6bf24d3a..e1ea8cb292fa 100644
>> --- a/virt/kvm/guest_memfd.c
>> +++ b/virt/kvm/guest_memfd.c
>> @@ -2,6 +2,7 @@
>>   #include <linux/backing-dev.h>
>>   #include <linux/falloc.h>
>>   #include <linux/kvm_host.h>
>> +#include <linux/mempolicy.h>
>>   #include <linux/pagemap.h>
>>   #include <linux/anon_inodes.h>
>>   @@ -11,8 +12,13 @@ struct kvm_gmem {
>>       struct kvm *kvm;
>>       struct xarray bindings;
>>       struct list_head entry;
>> +    struct shared_policy policy;
>>   };
>>   +static struct mempolicy *kvm_gmem_get_pgoff_policy(struct kvm_gmem *gmem,
>> +                           pgoff_t index,
>> +                           pgoff_t *ilx);
>> +
>>   /**
>>    * folio_file_pfn - like folio_file_page, but return a pfn.
>>    * @folio: The folio which contains this index.
>> @@ -96,10 +102,20 @@ static int kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slot,
>>    * Ignore accessed, referenced, and dirty flags.  The memory is
>>    * unevictable and there is no storage to write back to.
>>    */
>> -static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t index)
>> +static struct folio *kvm_gmem_get_folio(struct file *file, pgoff_t index)
> 
> I'd probably do that change in a separate prep-patch; would remove some of the unrelated noise in this patch.

Yes, I'll separate it.
> 
>>   {
>>       /* TODO: Support huge pages. */
>> -    return filemap_grab_folio(inode->i_mapping, index);
>> +    struct folio *folio = NULL;
> 
> No need to init folio.
> 
>> +    struct inode *inode = file_inode(file);
>> +    struct kvm_gmem *gmem = file->private_data;
> 
> Prefer reverse christmas-tree (longest line first) as possible.
> 
>> +    struct mempolicy *policy;
>> +    pgoff_t ilx;
> 
> Why do you return the ilx from kvm_gmem_get_pgoff_policy() if it is completely unused?
> 
>> +
>> +    policy = kvm_gmem_get_pgoff_policy(gmem, index, &ilx);
>> +    folio =  filemap_grab_folio_mpol(inode->i_mapping, index, policy);
>> +    mpol_cond_put(policy);
> 

I'll remove the kvm_gmem_get_pgoff_policy.

> The downside is that we always have to lookup the policy, even if we don't have to allocate anything because the pagecache already contains a folio.
> 
> Would there be a way to lookup if there is something already allcoated (fast-path) and fallback to the slow-path (lookup policy+call filemap_grab_folio_mpol) only if that failed?
> 
> Note that shmem.c does exactly that: shmem_alloc_folio() is only called after filemap_get_entry() told us that there is nothing.
> 
Yes, It's doable.
A filemap_get_folio() for fast-path: If it does not return folio, then falling back to current slowpath.

>> +
>> +    return folio;
...

>> +}
>> +#endif /* CONFIG_NUMA */
>>     static struct file_operations kvm_gmem_fops = {
>> +#ifdef CONFIG_NUMA
>> +    .mmap        = kvm_gmem_mmap,
>> +#endif
> 
> With Fuad's work, this will be unconditional, and you'd only set the kvm_gmem_vm_ops conditionally -- just like shmem.c. Maybe best to prepare for that already: allow unconditional mmap (Fuad will implement the faulting logic of shared pages, until then all accesses would SIGBUS I assume, did you try that?) and only mess with get_policy/set_policy.

Yes, I'll change according to it.
I have to try that out.

Thanks,
Shivank


