Return-Path: <linux-fsdevel+bounces-42167-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DFD8A3DAE0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2025 14:07:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F79E1719EC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2025 13:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE6E1F76B5;
	Thu, 20 Feb 2025 13:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lKBZPpmB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842201F3BAF;
	Thu, 20 Feb 2025 13:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740056812; cv=fail; b=uPA92H66ijSzV4aKDbgtkyddYzI5a0tiDdwfDlo0adN0Ddky34fzQo5QO1g8Ml+VZ7nJAe7WeNQTbnbrACm4FDfJ1b0FkI5iTFb19WBm/hqaJVFF4WJhRtjbTkVD2rPAH6ko34MDr7CeEcITVXfmNYIA7MbxODl/eL42IWyLLYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740056812; c=relaxed/simple;
	bh=3WX1Fqq3Ikz06OMDlOJQ8DbhTdjzKwOPpm9+RGjmo0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b4DlzDXE8WQY1zI8yWKtkiBlm30G/M9pDNcdtrKsSnH7UMLRq5JhNzcSfmXNjhEKN0DsdokSWy194lHa5enSWy1VxfAllULBxWabDVU/4+NPe/E+w1ROPyX73tJjn6fRL2Id+FNjR0sVIAOS0TxX5KPgnUrPGHQTDmBtNHrzYrM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lKBZPpmB; arc=fail smtp.client-ip=40.107.92.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S20zAGIKocje4AOedSBvyp1BjSiYLXFtKIldckmZHUrCz/G3E5zt5/AO4E4imCM4j/cndfdBxWXxPAVT7GDjCMQgYLuP+1jzZUil0HRSwfSv2qWQkSdC8QwztulouAmLKq17HStZIq5eG4dbqC9TtAKBvHHq8kx402/sAIiDO2K9FnRgg6sG+S321y6eE4mM7ir+NTKRvprEe7GAlom8X7U5vX/9+at8tfm9v+wsMRwip8dt4AC5KfB2R6bilu1n5goUGx9t6EwyZJzlzC1wfH+wVcL1izCs65sRCqCVnLtkOmOUdvSMOSvn9iYscdr1bwEMUwSHTWAJU8BptDcKRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q/o0c+PUBGv50NPnKGpXhXSCI/MQkSkFe/qW7tRNmBQ=;
 b=pr1HZswUoKm/0VfwU6gf3CVwnvfwsO2ORXEk/qj+7wnfk09x0PIqJSPgQKKcTyq5sKjkbDqsLOVKriqe7fCf0r2TjTvo3EOsUnFM7D7VviNHf3KFNYFPbLLgkNwb0ZmXwsNKK+BPXgfGBvuY6mllwp1aRVHnZm+Zk2tkaFXsl+3LJ0TsKfhySTTFFVN9v4Bf9NJzLsEfA4WaV9DLichcSYEv/bYpLOJa6IOxCiIOyKSDezFgqwZ90QW23WWZj7M7ToTPRi+5dyPK453iqx3Cl1YAAL/vLxRJJqhCwwmsdfl0vPl0WBPMTuAXOXssq1xcekApBWmX1csAvsqtAorosg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q/o0c+PUBGv50NPnKGpXhXSCI/MQkSkFe/qW7tRNmBQ=;
 b=lKBZPpmBMNkRIH1VAWNOjAMhOeOmXQzlAqVmWc6eMxj6J5pDvDJMeYsTJQNZw/5ilsTDL0RJn3nhq7UPSMgZ1YIVwVtC4cOQj8xm79wz9Gwo8idikW6kq69lSJ/31VaiJS/z9zxrYqlCzVHTDTnnK+5UnudGWJwFnrzInaviUgMZOPVpNGJML3v2KKc7cI4Q+jCQdnL04SaFulP1P/Vrg8xGwxHOrakvvyb9jvrsBFrBL6RBlntvFDFiIanhK9rXYL3bjiTfXE7Azifn00s5oqLZcPl4H4cQZ9UOB0UIhrqX91F8tKW6CbXdj7LOi0Pxi3KcRNsGJRqd0EhjLq5agg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Thu, 20 Feb
 2025 13:06:38 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8466.015; Thu, 20 Feb 2025
 13:06:38 +0000
From: Zi Yan <ziy@nvidia.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>,
 Kairui Song <kasong@tencent.com>, Miaohe Lin <linmiaohe@huawei.com>,
 linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 2/2] mm/shmem: use xas_try_split() in
 shmem_split_large_entry()
Date: Thu, 20 Feb 2025 08:06:36 -0500
X-Mailer: MailMate (2.0r6222)
Message-ID: <42440332-96FF-4ECB-8553-9472125EB33F@nvidia.com>
In-Reply-To: <2e4b9927-562d-4cfa-9362-f23e3bcfc454@linux.alibaba.com>
References: <20250218235444.1543173-1-ziy@nvidia.com>
 <20250218235444.1543173-3-ziy@nvidia.com>
 <f899d6b3-e607-480b-9acc-d64dfbc755b5@linux.alibaba.com>
 <AD348832-5A6A-48F1-9735-924F144330F7@nvidia.com>
 <47d189c7-3143-4b59-a3af-477d4c46a8a0@linux.alibaba.com>
 <2e4b9927-562d-4cfa-9362-f23e3bcfc454@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BN8PR07CA0023.namprd07.prod.outlook.com
 (2603:10b6:408:ac::36) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|BY5PR12MB4130:EE_
X-MS-Office365-Filtering-Correlation-Id: 3241747c-2abb-41e2-b369-08dd51af6943
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NmxybGVVN1FkdW1BcnlxU2RmRHJCdkhoSFd5YXpmaU5jUWlQeTh5eGpsRXNQ?=
 =?utf-8?B?OE9SVm9zNUtDanhtcXFWU3dhNU81N3hRMkM1RVFQSlRMbVovdXFFQkVRczJ0?=
 =?utf-8?B?R2dqaTd3c241bC9PTHdaMkVGWHNOTC9QVURtSTRJNnk4U2gzTkxOcGxlM3VM?=
 =?utf-8?B?U3UwdkViaFBpcGc4RytCcndZUVEvckZDZ3VDS2RSU2VoTmhmL3JzZWUrd3Ir?=
 =?utf-8?B?TkJxNWRHd0doWCt5M2p6ZmZSSk5TaFFXRnBwTVNPRDBCUUYrVWt6bTBsaU1E?=
 =?utf-8?B?OXRYckxvTkhQSzhZK2ZzUVhlTTBqbFpYTHcyTTlDV3FCMXdjUTFXeDVWRDd2?=
 =?utf-8?B?dnlRd25kTnY0akZGVXNFVkZnZ3lHUTA4aFFPb0taRGRtdmgvdUhpd1ovL2ly?=
 =?utf-8?B?TGZYVE9GZXRGZVhxYStCR0Y4V0IwaEQ2VWpiT0YzbHg0WUpoR2pxY3JhNlE0?=
 =?utf-8?B?a1kvb2NMREJCd3hsT282ajdmZVRhdkowQjk0UldwNi9DemtkOVkwVGNjSWxr?=
 =?utf-8?B?aWw1M0pLU20wTWlQR0FTSUFNQkd6RkExYWtGNzFRNmtjY0RvTzh3eWwwT1ZZ?=
 =?utf-8?B?M2JnMWQ4ZFg3MFFpSHhUaFlGZEVwRmp6VWFqTVhuU0s1Mzdyd1g1SnRkeEpK?=
 =?utf-8?B?TXQ3TnJJODlheWhxMC9XMmUwMFF0WDZkK2FxbVExbkxsYkl0SXU4Y3pDRFd2?=
 =?utf-8?B?TjdGYnp1Q3RpREdNZmNoK0NjQUNlaXNqWDFlenhPZmt6MnM5Q2Y0eE5pVUR4?=
 =?utf-8?B?S0dkbVZsU0lRMWdrcEdDOTBBZmhzclEvUEFxTDQrQ2toR0ZSemg0clk5OWFS?=
 =?utf-8?B?Tld3RTBnOWtqeVNCRkprTlQ2Qm1ERzdFS2JmRkFqZHNrdGtIbDNjUDE0cEdv?=
 =?utf-8?B?VnJPS2U0ZWF5K1JGNHFuaU0wWlgvdGJpeEhhaHR1dmV5cU4xajRkYS9CTGZh?=
 =?utf-8?B?dWRoQnFaTERFOUlKQW9tQTlhYXNjK3RneXg3MHNoY0V1NzVjTkZZL1NPenFY?=
 =?utf-8?B?TkVNdjFmYnFjdE82MmRpcnJmQnU5RE9Ha0dWKzdYQng3VEo2dHNTa09vZjZJ?=
 =?utf-8?B?anM4YlQrSEhsWHF3ME1GTWRjUmFuOTRGSHNsYk9XZ09nZGhEQzNGSGwvMGNz?=
 =?utf-8?B?aTFlZlRVVTU3VWcrYWRiUUl1S2JMQ3ByaDVMZkhmV0tQYjczZGt5alFCMHM0?=
 =?utf-8?B?eTZpM1IzR2R3WW53YmVkdDVPWHRoNWVYMG1tMUkvVVRUNW1FeXU5czRLRlFW?=
 =?utf-8?B?dE5pRkpkM0N0bDNsaDJHOGtXNGYzY0hjb3U1S2tFN2diM0c5TzlYNDY1SjRx?=
 =?utf-8?B?aWhEemdRcXZzcE9ZdVVSVUl5UjBjSHRkcEZEc2R4cEtsOU9uWGhGeUNoMTNp?=
 =?utf-8?B?L0JNMXJVSjFKMmtNU0FhdjBsT1ZsY2t3dlpyS0RMYWU5QU9sdEY4dTZwTCs5?=
 =?utf-8?B?eG0wSllCNmh2UTFPTm50S1BGdE04aHRtWDhVTTVQSkdiR2ViNkZBOFFyeHBr?=
 =?utf-8?B?cnk2RFJTSHdMSmFlY3k3dllYWlo4ZTJSb2MyQUsySEEwbFZ1a3ZxNmI0bjRR?=
 =?utf-8?B?MTk1TDVCM01DN1YrY1VWZHMydUNCQlZ1eDFKNk1OTkhiY2FmMkdPNFNHQkRp?=
 =?utf-8?B?ZG9OcWZlald0Z2UvWU4vdUtGZkZ1SUVtak94RDgvNzgydUlzb210NjZ0Z09K?=
 =?utf-8?B?eWtyQllINkMwb2srZkl0U3JnR2RQWS90cWRwem9BY0ppR2pNMGhjZXRlL0o4?=
 =?utf-8?B?MnA5K1p3Y2VPOXZyRkF1amh0akhjeldNYlYvSDlMR2NoMmtndDRKQnEzNnU5?=
 =?utf-8?B?Rkt0Sm1DWnphM28vUkRmVWt6T1BKTjVLdGd1OVF0WWY5dXJjSEQ2NjN5QWdj?=
 =?utf-8?Q?e2yEsYv500DW0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VGRVRFZKZ2pZSUo3aXRFNWo4Q1VZL1hMcy84YWV6UFRSTU9KNHBZblE0WVU4?=
 =?utf-8?B?VUovMHhJUEMvSU9iZ2xPTDlaVThrOGhHRm50ZjhnamozaWU1MmxwWlRxQnF1?=
 =?utf-8?B?aVgxcGY2YTN5S2FLeGxTSm00dGl6RmY2ak5yS1k0SzBTV25jNis1NDVURlJM?=
 =?utf-8?B?bzVFS0U3b2s5NmVoVi80L1JuRFVXSWJnODNFdHdVeU9sOGk3Um52d1BwMmxt?=
 =?utf-8?B?dnhGRUJYa1laYWVsQVF3RWsrTzd6Z1lLUmZTWU1BeXIwRnh0OEFadm93KzVK?=
 =?utf-8?B?a2dhZno2VnM1T1pQOTg4aGFiTmI0UHlVZ0dLckhOMHBGVlZPSkpOL0lkZDd4?=
 =?utf-8?B?NDdFOUZVU01IWDNpMWhKKzFaS1dWVE5MYmdoeVV3T1dEbktubmdVZHFkazRK?=
 =?utf-8?B?ZklGdXN5bHJ6aFUyeForSTZrQlhtU1oxMU1nT3RjQzhWMSs5dFU0OGdlMGlW?=
 =?utf-8?B?b3Mvc2dRZ2JZc1VBVUVKM29MQ3hFeCs3ZHZvU2dtMWcvaGtEbVI0b1c4S05q?=
 =?utf-8?B?NFUwQjFCd1BhUXFmQkNlWjhTWFg5bHVtSk9hWjIzMkJrc29MNUFINHd3Unl3?=
 =?utf-8?B?aWlQeUJlYkNuc0gzNGlMUUFQbTNnNjkvOEVqeTM3cm5zNC9ndllzNWEwVjhx?=
 =?utf-8?B?aHZkSkdkbTlYSlZkSU5JYms1SHgwczRVSU84UXJ3K3J5a0xhM05PZXc3QTBB?=
 =?utf-8?B?cnBnTjh4dkRUZHEzVDc2K0dWK1VlREl2bTFhVDlpOEw0cVZlQWZvOWRXZ0Vl?=
 =?utf-8?B?VG9VMjdUblBXZXk5SiswelF1QVBkdU5XWnlvazYxdkkwbVZhanY5d3RNSWdx?=
 =?utf-8?B?NjlYMEhoNnRkVzBuSzVRVkFzRlE4S2hVQWlsaG8xbDFIeTVtY3JVVFg1RGc1?=
 =?utf-8?B?dkdEOW9PZFRqT1B2RVQyQUJmams3WXM5VnBJc0V1WkgrMWtxOVc3R0lEb1E4?=
 =?utf-8?B?d2N2VmpmN3lZayt6Sk9iZmJWVjFnOWNCNzBCeVVEOXEwMXNKbWFSL2RPYWRq?=
 =?utf-8?B?dVJhZU5uNndDMHgySWsweUpWZS84R2xOS21DTGNIV0NMTWNkL21pb0RNSkFa?=
 =?utf-8?B?d21VRStzL1l1L1daenZqUzNRM1NpL3VYd0xrdkFpZjZyRjhTMGtnNDN4YUcw?=
 =?utf-8?B?ZnR6dGRaYndQZ1dFVUxnNERBWUhqVml3SFVDZnJzRC9SYUQ2YzBGNVVxUXZq?=
 =?utf-8?B?dDFMbmVBTllSVlc5MEI5TDYrSDA3bGZGYlY3aTZYdmF5eStrZEVPYzlZd2VQ?=
 =?utf-8?B?czNEYktYUjI1QWJraFhzMFpDMnBMTEE3RG4yei9HYVFGT2c5T285VWRPb3FR?=
 =?utf-8?B?a1dDSVhUSjJBQnB5RUkwRGttcU00OC9QcEtIeEJzTVhGSVN0VjI5YWl2cnFx?=
 =?utf-8?B?cG1FOG9mTmpuQ1pjTDFGR0dpRmJWajBxSktIMUdnUGJJaGwxbngxYXhEcWZi?=
 =?utf-8?B?WWs2dVZsUFpLWHNySEJ2eXlGMU5oSXhwRE11TVVqb3VvL1YzZFRqeWcwdEZ5?=
 =?utf-8?B?VGNEYlpXS0cyRGFGcXdjdks4Q1VRTkRJc2ZNbmhXRTlaK3JBNm9jUEtlYWFG?=
 =?utf-8?B?Wk1pOTlQT1Z5eTloZWphY0ZSUEI3aDRaUmpWZ2M0aFJ2dTZuNTFtTE1SbnJs?=
 =?utf-8?B?c2Y1c2pmSm1Ta0VPQWE0NjZUaytPZEJkYjl4aENnTXp4WFRhcWkyME52ZXdR?=
 =?utf-8?B?Mmp4YW4zQlZuYWtlblhpd3B6Qys2NHVJVTFBWkhkbmxnR1hsWExiVmlFRWNn?=
 =?utf-8?B?WkVWbVdEZTlHL2xMdi93Y2I5THl4ZVgyc3VWU1VyTyt0K0h4NmY2WWVhRUpZ?=
 =?utf-8?B?MUdOMjg3SEl3ajhzQUxRdHltMzVNRzU1cFgvelQvdWxtQm9NWlhrdmo5RmlZ?=
 =?utf-8?B?UEVBK0Y2WW16R0w2UHFuYm50QUc3TS9LYTFOOWtQZ1JxbER1RUVrNTFrVDZx?=
 =?utf-8?B?SWxrbGFzQXdVWVFGSjVHbml3cDBTVmc0MThVUldtSzZjZ3ZsUWhlMVg5UUVl?=
 =?utf-8?B?cEhjYlJSOUdieVI5NE1US2w5NllvME5nUFJqeHZuZW4rbit3cVJsTnNEblNX?=
 =?utf-8?B?b0Q0ZDRhbmNFVFMwZVBxRGQyaHdaVVJBTW1FdjFLZTNEZS9mTlJ2TUlhUFQx?=
 =?utf-8?Q?SaAw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3241747c-2abb-41e2-b369-08dd51af6943
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 13:06:38.4932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LhzwikCBAVFJzN4KV3MeuNY8tRywSMeE5IDD43ySmGAe6potK3mDiTogC5fShDkm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4130

On 20 Feb 2025, at 4:27, Baolin Wang wrote:

> On 2025/2/20 17:07, Baolin Wang wrote:
>>
>>
>> On 2025/2/20 00:10, Zi Yan wrote:
>>> On 19 Feb 2025, at 5:04, Baolin Wang wrote:
>>>
>>>> Hi Zi,
>>>>
>>>> Sorry for the late reply due to being busy with other things:)
>>>
>>> Thank you for taking a look at the patches. :)
>>>
>>>>
>>>> On 2025/2/19 07:54, Zi Yan wrote:
>>>>> During shmem_split_large_entry(), large swap entries are covering n s=
lots
>>>>> and an order-0 folio needs to be inserted.
>>>>>
>>>>> Instead of splitting all n slots, only the 1 slot covered by the foli=
o
>>>>> need to be split and the remaining n-1 shadow entries can be retained=
 with
>>>>> orders ranging from 0 to n-1.=C2=A0 This method only requires
>>>>> (n/XA_CHUNK_SHIFT) new xa_nodes instead of (n % XA_CHUNK_SHIFT) *
>>>>> (n/XA_CHUNK_SHIFT) new xa_nodes, compared to the original
>>>>> xas_split_alloc() + xas_split() one.
>>>>>
>>>>> For example, to split an order-9 large swap entry (assuming XA_CHUNK_=
SHIFT
>>>>> is 6), 1 xa_node is needed instead of 8.
>>>>>
>>>>> xas_try_split_min_order() is used to reduce the number of calls to
>>>>> xas_try_split() during split.
>>>>
>>>> For shmem swapin, if we cannot swap in the whole large folio by skippi=
ng the swap cache, we will split the large swap entry stored in the shmem m=
apping into order-0 swap entries, rather than splitting it into other order=
s of swap entries. This is because the next time we swap in a shmem folio t=
hrough shmem_swapin_cluster(), it will still be an order 0 folio.
>>>
>>> Right. But the swapin is one folio at a time, right? shmem_split_large_=
entry()
>>
>> Yes, now we always swapin an order-0 folio from the async swap device at=
 a time. However, for sync swap device, we will skip the swapcache and swap=
in the whole large folio by commit 1dd44c0af4fa, so it will not call shmem_=
split_large_entry() in this case.

Got it. I will check the commit.

>>
>>> should split the large swap entry and give you a slot to store the orde=
r-0 folio.
>>> For example, with an order-9 large swap entry, to swap in first order-0=
 folio,
>>> the large swap entry will become order-0, order-0, order-1, order-2,=E2=
=80=A6 order-8,
>>> after the split. Then the first order-0 swap entry can be used.
>>> Then, when a second order-0 is swapped in, the second order-0 can be us=
ed.
>>> When the last order-0 is swapped in, the order-8 would be split to
>>> order-7,order-6,=E2=80=A6,order-1,order-0, order-0, and the last order-=
0 will be used.
>>
>> Yes, understood. However, for the sequential swapin scenarios, where ori=
ginally only one split operation is needed. However, your approach increase=
s the number of split operations. Of course, I understand that in non-seque=
ntial swapin scenarios, your patch will save some xarray memory. It might b=
e necessary to evaluate whether the increased split operations will have a =
significant impact on the performance of sequential swapin?

Is there a shmem swapin test I can run to measure this? xas_try_split() sho=
uld
performance similar operations as existing xas_split_alloc()+xas_split().

>>
>>> Maybe the swapin assumes after shmem_split_large_entry(), all swap entr=
ies
>>> are order-0, which can lead to issues. There should be some check like
>>> if the swap entry order > folio_order, shmem_split_large_entry() should
>>> be used.
>>>>
>>>> Moreover I did a quick test with swapping in order 6 shmem folios, how=
ever, my test hung, and the console was continuously filled with the follow=
ing information. It seems there are some issues with shmem swapin handling.=
 Anyway, I need more time to debug and test.
>>> To swap in order-6 folios, shmem_split_large_entry() does not allocate
>>> any new xa_node, since XA_CHUNK_SHIFT is 6. It is weird to see OOM
>>> error below. Let me know if there is anything I can help.
>>
>> I encountered some issues while testing order 4 and order 6 swapin with =
your patches. And I roughly reviewed the patch, and it seems that the new s=
wap entry stored in the shmem mapping was not correctly updated after the s=
plit.
>>
>> The following logic is to reset the swap entry after split, and I assume=
 that the large swap entry is always split to order 0 before. As your patch=
 suggests, if a non-uniform split is used, then the logic for resetting the=
 swap entry needs to be changed? Please correct me if I missed something.
>>
>> /*
>>  =C2=A0* Re-set the swap entry after splitting, and the swap
>>  =C2=A0* offset of the original large entry must be continuous.
>>  =C2=A0*/
>> for (i =3D 0; i < 1 << order; i++) {
>>  =C2=A0=C2=A0=C2=A0=C2=A0pgoff_t aligned_index =3D round_down(index, 1 <=
< order);
>>  =C2=A0=C2=A0=C2=A0=C2=A0swp_entry_t tmp;
>>
>>  =C2=A0=C2=A0=C2=A0=C2=A0tmp =3D swp_entry(swp_type(swap), swp_offset(sw=
ap) + i);
>>  =C2=A0=C2=A0=C2=A0=C2=A0__xa_store(&mapping->i_pages, aligned_index + i=
,
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 swp_to_rad=
ix_entry(tmp), 0);
>> }

Right. I will need to adjust swp_entry_t. Thanks for pointing this out.

>
> In addition, after your patch, the shmem_split_large_entry() seems always=
 return 0 even though it splits a large swap entry, but we still need re-ca=
lculate the swap entry value after splitting, otherwise it may return error=
s due to shmem_confirm_swap() validation failure.
>
> /*
>  * If the large swap entry has already been split, it is
>  * necessary to recalculate the new swap entry based on
>  * the old order alignment.
>  */
>  if (split_order > 0) {
> 	pgoff_t offset =3D index - round_down(index, 1 << split_order);
>
> 	swap =3D swp_entry(swp_type(swap), swp_offset(swap) + offset);
> }

Got it. I will fix it.

BTW, do you mind sharing your swapin tests so that I can test my new versio=
n
properly?

Thanks.

Best Regards,
Yan, Zi

