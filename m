Return-Path: <linux-fsdevel+bounces-64965-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3F1BF7876
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 17:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 225E01897CED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 15:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6ED73446C2;
	Tue, 21 Oct 2025 15:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pRG4aQC1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012066.outbound.protection.outlook.com [52.101.48.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A57355057;
	Tue, 21 Oct 2025 15:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761062241; cv=fail; b=R1DUUwmok4xLlsvb5IMYhi/jlvzzEB8PTFbYY7OF7YcIAPgpmizzqUdygb9imevNVE2od54ozXwWoMpMEDnsVqgvFnYySVb8Pzew7DC5uLPId+QZO04db6xEPSUOXaJKuP+OSz5eXX+2LlUy6AUHRvustAaQGAZpMygs+2yDWDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761062241; c=relaxed/simple;
	bh=/OIVuQledAL4VSbtldu8UwKlJsKokE9zSjKs5kovuQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Wfun8eTSwNESJbf0ulJJaUByAL7LFKmv/q9KB1nATwgBxDYnCvh9YAk6VjdGn3C6VUhAGEdlgUT01A/HrLnFP/s1FfaWEtGC67GRdPxiTpLBNsHmn3gKXM4g1YsjiQFbOdcLM3VcKZrnOHZQ0oX6q35Z0nsJ190M7VH5fStU44o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pRG4aQC1; arc=fail smtp.client-ip=52.101.48.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xEL7pSoqrc7Ge+IariZylC4qcSDtD+9NPk5iWOtWOHp0nF06s6BUVZxyl/Gxy0zxkLr4S5QSJerKpC4KwXi9SBP7FPzGnvFd9s8sb9D1wWlvAVlYIkv4jNUSQtK9riGC3ze3RCiQM1vPwu94TAQXe5p+XK0BZsuKiw5xCBlJuYYvwmp2w5Ohx0Oq+xeP7lPZSpmik0NjsR5qDJrwlm/MFo0cIjuieCTVoI2jTn74vyTQfBBWa5w5PytnX1T8ri9lGkF5zhPz+ns35hhqegyQEjUH3qqbQUtMIjCH8MG3QpeDzyvm0Z7wtaU4tHRF5Kr4FxNPg0kNwG9ncvfRV93BSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/OIVuQledAL4VSbtldu8UwKlJsKokE9zSjKs5kovuQg=;
 b=atooYQ9WAAfKYgFTU0nCLS4h6IdCewegkANcJH2aDRzApcnR0Tl+Ty7NE2YhmcnkMb206wOI8OK//+ZecLf/2VvnBjyyAATg08X638E4dMC1rMXCERHGpt5SHBuBe+HHSpB8cGODCzo2vCCf7LPrfac5YATi2t4k+H9MUnDT3yWic4JWgu1QRZeOB5pDcexQDnk0MCqDcaWE2gkPIXrhV3/Gzy6hb8LD7Pta9HjNb0E3J+CRgdn+UkSF8enrXD4M9GjeynjJMsxrcBwacYNtHdBSAj8CwWGMP0cVEkV1jikH6920wATqqXAejApK53rLd68X1Q+EN0vkv/yRLFlw1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/OIVuQledAL4VSbtldu8UwKlJsKokE9zSjKs5kovuQg=;
 b=pRG4aQC1u6Rz4QRgJSIL02mmeHLmbxMMCSL4/OXtNBdD1iqWO5bbgKQO+kQEkkQuRzxlfKNF84U9fYzIBsAIFvx2Yh4XWN300CQ8kOfkJ4n3o2LBYF+7npnyMJnt6msnzgrsuKPOlV0aePRwo+I8AUReUvE8TxBKc74nbFc1C8Rw6QMRGaHamCBpYRxKqzOuhPk8NysTI1s/sIQckgHmb4YcrOIhJoyC9TRqBZQgNF0xbnmzebKiBoq0lYFqwZA+X15LETlMedeOMUq9Dq/8GPD82v1FHDfm0d44GNZ0ndzBOwpbMKP32Zs4MSQQocWOYR5Emfv1mqHYkU5so0qa5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SA5PPF9D25F0C6D.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8d9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.15; Tue, 21 Oct
 2025 15:57:11 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.9253.011; Tue, 21 Oct 2025
 15:57:11 +0000
From: Zi Yan <ziy@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: linmiaohe@huawei.com, jane.chu@oracle.com, kernel@pankajraghav.com,
 syzbot+e6367ea2fdab6ed46056@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com, akpm@linux-foundation.org,
 mcgrof@kernel.org, nao.horiguchi@gmail.com,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Wei Yang <richard.weiyang@gmail.com>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, stable@vger.kernel.org,
 Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH v3] mm/huge_memory: do not change split_huge_page*()
 target order silently.
Date: Tue, 21 Oct 2025 11:57:08 -0400
X-Mailer: MailMate (2.0r6283)
Message-ID: <7A31812E-7AC3-4F0F-B813-9C6940D952F4@nvidia.com>
In-Reply-To: <88f8477b-5898-4d7e-8583-9d769a34645f@redhat.com>
References: <20251017013630.139907-1-ziy@nvidia.com>
 <88f8477b-5898-4d7e-8583-9d769a34645f@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BL1PR13CA0078.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::23) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SA5PPF9D25F0C6D:EE_
X-MS-Office365-Filtering-Correlation-Id: dc1a7633-b5c7-4e80-8060-08de10ba7f15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SkFpWWJSZkxHcmlacjNSVEdubFVZSWRKbnY3ZkNGaFVJYlMzcHV3SXlUWEpu?=
 =?utf-8?B?dTE5RTBlTXdqSVp5c0xONXRhZnRqY0lGb01WOWJJdVcrOTZRK0Z4Ylo3TTd3?=
 =?utf-8?B?TWU1MjN5M2JsR2ViWmtWRVRZWHlSZUhWcnRHdGliMnNJUDU2eXlScHNsZGlV?=
 =?utf-8?B?clhGMDY4RFJwRVNxd2lTU2M4VzlZSXhwVE9vVFZBYklLdU5wWWxHMUI4S2FT?=
 =?utf-8?B?T2VtNlpvV25rRlNhZWFLQkhocGx3SzZmQ0NaRUlkK0RTdFQxTXJ6bUJFd1gv?=
 =?utf-8?B?cjhWVW9XYmJmbE81Nnk1ZHpjOWhzZXdQd1N4S0ZMSEJ3dlVtYTJaYXJzMGR2?=
 =?utf-8?B?c2pSOC9OVENHbUoxejFNczFKUFhOcjVFNWZGRXRBaHoyNnAyTXJSWjZhN3J1?=
 =?utf-8?B?c0ZXK2VGRnZscWJHcTFkRFdtUW4rWjhWdml3RStBZkdJOVgyZU1KRHJlZE9a?=
 =?utf-8?B?K2lFd1VlOWkwdVpYbDNVVVBXQVVDdGRNUjZDbmlycXl5TWFUNm5WcCtwSXR1?=
 =?utf-8?B?MUVuclgvYmVROExlaWEwQ1ZxWHNrMDBEOW1XWUZSa3dSaGc4TlBCNXZpd1Bs?=
 =?utf-8?B?MjZMOEZla1hTRUlhbDB0V1Bsc0hiWDVlcnFDRWw5VC9CRXh4L3hVaE1pbjBX?=
 =?utf-8?B?bFZHaHEyQjBPcW8yL0FvS2pDZEJMR1NZdUw3eFhMdEd2UnNSc0lEVWlDM0ND?=
 =?utf-8?B?NXNqSVdkc0V6R2wxaVpEdFoxTnM0cTdacjlpV3lSazAweExGc0RyTVJEUWph?=
 =?utf-8?B?Wk9MQ3RWVE54MFRGY08rdEJSNDhHY2NtZ2V3cERiakE2ZWFtbUtMWW1YQyth?=
 =?utf-8?B?OElEM3N4b2pMbWIvWVAycWRHanlEN1NRSzNWS25QZlNTVnl1dmpiYkpVRm5i?=
 =?utf-8?B?WjF3RnBxdXhwbnpiZEZJTlp4L3dPa1d3aDRxa2UrYWowV1RqVklFYTd5NVNi?=
 =?utf-8?B?VnZ0d1dmR2NLNlN1cFFkdEVWYkdCWnBrNVRkWWE4Z20ycUVxdFpERGJITnNu?=
 =?utf-8?B?RlhvcmR2d0lEMkpyWW0xWFViN1JCMVJEQmQwT1l4eExHZUhvdDVhVEFDQlhw?=
 =?utf-8?B?c3lWbnVBb1Y5UENlLzc0a1Z1VmV0aXhZdXNLWVA4NUdRdVZHYmF1b2JsdWRR?=
 =?utf-8?B?TkhrRkZXd3l5QlRFM05IaDdSK05kWEsvNC9uOUR6UnQ2VDh4ZnZWR1hFaGoy?=
 =?utf-8?B?YVZUMXVtaXlCZ2dlVDd1TXJrTzU5VjFNNzhoS0xzcThoVERldWM4MnVRRkw5?=
 =?utf-8?B?TlJkQS95cVEvcllQU3o3UUhCUDk4bHI2dStRRkF6ZFJaVUFwa01MN3R6N09a?=
 =?utf-8?B?VGhxUmZ6MFAvbWNYQVpBS2FmUWhyTUJnVGpyeERtVUNuUUY0bkFDMkNjOUc3?=
 =?utf-8?B?SUJ0a3hrWE8wajlhTnRWaFZwRUwweXNhalZZaUNLL2k3YzEzYWUwZFE3VC9q?=
 =?utf-8?B?Qm1nUDFoQ204ZTl1bkF5NEJZNC9ndWlML2Rxbk52SWV2bUM4WGNObW1uWmVL?=
 =?utf-8?B?WFlEM1h2KzVjZDVpcUFpTDVWL3VkbUJpMUVaU09RNkZIMjUyUnViNlVYS0Jt?=
 =?utf-8?B?YmRmVUVKK1ZveWlrdXdHaTR4Z0dJOXgyMHVhRHFIYVpQV3BOT1V5WXJlamdh?=
 =?utf-8?B?WWpQUTluZGZoV0tuY0ZvbDZ3THB2eFRXS1JlbWsxQU83V3BGckRLMldwREQ0?=
 =?utf-8?B?L1N0MDluOWY4djV4MzEvQ3hTSXRFbnFLdEZ3d2wzWTl0T0VrMDZ0M3FTd3Ay?=
 =?utf-8?B?Zlo1Y0pIYUlzcVowMkVxN1BWRStuN2hOSmVGWHFqRGZyR2p4U1ZTWk9yWTJO?=
 =?utf-8?B?ZGNPNTEvajJBSDBCTVRtVFBzdmdYU0tWYWRKQ3Yxa1JFQUNldk95ZC9SRlBQ?=
 =?utf-8?B?UitSWEtYYWNGcTVIcE1BRE8xYTlxU0MvVHNXNE5XbjZybnlJL2R3SkIrQjVV?=
 =?utf-8?B?QlB0OUFtVVpIbHRwdnJFRmNwdXVSQVludzhSY0xIUUltZGI0WiszVS9JVmdY?=
 =?utf-8?B?SE1xOEhxZkRBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bTZVK2hGNGxjSFY4dzYvay9hSXc4bGdndmFIZjI2eEVsWUZtT0Y3dDN3RUR0?=
 =?utf-8?B?YW5zY1k5VmRtYmFVSzNoMmFrd2EzK1VyTGxnbE5QTE8vWHoxejFrcXZDWlpM?=
 =?utf-8?B?eTVEZERudFJDdkVmSUt0ekg0cXFXUHZBMTFBOStaNnhyRVZQenZ4OFJNZDUr?=
 =?utf-8?B?ck1MMDQwc3BCTEk3Zmg3cDhxVWJGS0RMOTVwaWdQTy9lSFMrT0s5T25NYWNN?=
 =?utf-8?B?eTBsNXlxbVlkYlNwdmxSek1EQ3ZtQ2xTbVMwZzVhSDg0YnI1bTFKQVhVWGlR?=
 =?utf-8?B?YXB2bWNxN3JVMlpQWGR1MHlLV0hkalpDQXdjNXVRMlMybUdHdWpnSys5bTFE?=
 =?utf-8?B?NzlyYW1kZlVDNW9tbFg3am16RTlncE5RNzcwRjhvYnZzaU1paHY2TGFCMUZ2?=
 =?utf-8?B?MXc3Mlk1ZSs2Q3VxUmVjME9RK09ZNFVaa1Z2TGhIMkxjNnI2WVpQSnpZTmts?=
 =?utf-8?B?d1JjTkpZZFVkNHdIUHNYOHJlaE5hUXUzTk5CQVB0NGlCVHdEalk5SGtYeDl0?=
 =?utf-8?B?ellXZEFKbGtzRU9ZeHROb2ZlRDNHVGZoUlJ6TS9vTVRkeTFSUHV2Ti81VWFh?=
 =?utf-8?B?WUM5YW5weFhHTEVtUTlKMk5tNDdWR0FaQm5ycmcvN05VL2h1L2JabmJ5cVd1?=
 =?utf-8?B?KytSUFFCZjdsUHdEdDdlYlVQekNCNEpxN1laNmlVanBqTVpJSitDN3VJM25T?=
 =?utf-8?B?Tm5mcGpyWlBzR1hzNklEd0JxdjkxQlJadVN4SlVTdzkvZGg2a1pRNVlwZUhs?=
 =?utf-8?B?dkV0Q0VJT2RSRVd6UkgyVU5nZG1IQURxU2FVQ3B6KzZTQjU0b2xrWjljTWNz?=
 =?utf-8?B?Tnc2QWNZbUxWZGFHVit6WUh5QytEanlGUS9rQVREVXE1RXJQNjEvRURwYVFY?=
 =?utf-8?B?d3Z6blBWenAyenFJSHNsR1MwTzN6eXM4WXFvalc5ajBkMXh5b01FMEpKWWw3?=
 =?utf-8?B?SjZYZkwvd0l0aE9JUlBmSEN2S1VmSFBJbkZudmk4aG9LSlVJeHVQMjhGVEJv?=
 =?utf-8?B?S3ViTHZuWkd3M2V1OStXWDR1U2d0ZUVCQ3pUWHFLWnZqVzBRVGRTSDBqUkpm?=
 =?utf-8?B?TVdqVTJISkZQSFpMVVBBNWNvQm02RldGdGtiZlpIZk03SkZ6a3BDbWU1SWxw?=
 =?utf-8?B?eXFCTENYMnI2NTBBeW1wUVlxdUFod21QTHA5bUdrbExMdlR1TWNsTDF5M29z?=
 =?utf-8?B?ME5ybWhod29jdEJGbHlHbGtCM29sKy95ZUVjeWVNci9qRGhxM1VEbDlTWUVJ?=
 =?utf-8?B?enRLWkVKSFVXT0lvYWUvbXVqQnlLTWhqeVh3S3hvUWNPNHpVa0lCekx2c0Fl?=
 =?utf-8?B?R2ZDbWtNVkVuWExBVjRpMUFYYTcwZzB1amZXZUxHd1dBL096R0hWS3ZSRytM?=
 =?utf-8?B?VzV0a0QyTHM0UmxzNUpCS3hTVU0yQXY2aDVMemNGb2E4YXZoT0hBc3FaSTlD?=
 =?utf-8?B?N3pRQkphbTBGcmxGRjVXLzg2dXF6cVBibXIrQ20yTS84TmJKOTNUKzBXd3Yr?=
 =?utf-8?B?QVJLcFBJelNEc3o4VnpQMldTMFFZYlhid2FOdHcxbWhIditLRTVzT1FSL0tT?=
 =?utf-8?B?bHVmRXJYZ3NDRFFBOEFaL3V2d0FHMmF0Z0Y1T3Zxdmdua2gwaWFyUGg1Tjhr?=
 =?utf-8?B?TjZRdmV6emhMeVFpNEtRa0JYWlI2aUlTMlpvZW04VGpadWlldUdQbXQ0T3VS?=
 =?utf-8?B?VURKZ2dnNU54ek5wRW9pTFNvbHdYWDNzdVZKbUJHaFNVU2pjWEpJTG42bWUr?=
 =?utf-8?B?UW1jZDhmWkdoTzZuRGVxc3dLOHZ5a1RsRXNEMWNBaER4ZHdDNzRvVnJWd3VY?=
 =?utf-8?B?ZER4QmtIelI1ODJKWDBKVTBSSU9SQk13NThDSi9zOVo1SWllQ2RBVGoyNmdI?=
 =?utf-8?B?MjNVSzY4Zm4yd25JTkROdEJXdFlObEZYaUYzZGJJczZHc2lLVXZDUE0rL25V?=
 =?utf-8?B?NlltTG11UjRYMjV4dlIxUFJJTGgvam9mZTg0dEwwRUoxUnRDS0VueFhBUEJH?=
 =?utf-8?B?MlBiQkMvSmo3b0VSQUk0bG5ZQmtONDg5b3FxMFdUZWxrbGdlWkpjaTdmblMw?=
 =?utf-8?B?d3BlN1NOMXovZ014eFI2eEw0UzVOOVpqbVlnSGZ5cXVGMEMveVYzZ2lVM3Rh?=
 =?utf-8?Q?m2fPtP8A4cklgXdmQl5A+ipsg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc1a7633-b5c7-4e80-8060-08de10ba7f15
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 15:57:11.7197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zbiL2ScwwGqc50MlsSYwx+24OLp/hGF8dzcZ3m+/q3JAX8rX/nUeWM3lcwrpgJqh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF9D25F0C6D

On 21 Oct 2025, at 11:42, David Hildenbrand wrote:

> On 17.10.25 03:36, Zi Yan wrote:
>> Page cache folios from a file system that support large block size (LBS)
>> can have minimal folio order greater than 0, thus a high order folio mig=
ht
>> not be able to be split down to order-0. Commit e220917fa507 ("mm: split=
 a
>> folio in minimum folio order chunks") bumps the target order of
>> split_huge_page*() to the minimum allowed order when splitting a LBS fol=
io.
>> This causes confusion for some split_huge_page*() callers like memory
>> failure handling code, since they expect after-split folios all have
>> order-0 when split succeeds but in reality get min_order_for_split() ord=
er
>> folios and give warnings.
>>
>> Fix it by failing a split if the folio cannot be split to the target ord=
er.
>> Rename try_folio_split() to try_folio_split_to_order() to reflect the ad=
ded
>> new_order parameter. Remove its unused list parameter.
>>
>> Fixes: e220917fa507 ("mm: split a folio in minimum folio order chunks")
>> [The test poisons LBS folios, which cannot be split to order-0 folios, a=
nd
>> also tries to poison all memory. The non split LBS folios take more memo=
ry
>> than the test anticipated, leading to OOM. The patch fixed the kernel
>> warning and the test needs some change to avoid OOM.]
>> Reported-by: syzbot+e6367ea2fdab6ed46056@syzkaller.appspotmail.com
>> Closes: https://lore.kernel.org/all/68d2c943.a70a0220.1b52b.02b3.GAE@goo=
gle.com/
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
>> Reviewed-by: Pankaj Raghav <p.raghav@samsung.com>
>> Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
>> ---
>
> With Lorenzos comments addressed, this looks good to me, thanks for takin=
g care of this!

Just to be clear, I do not need to respin a new version of this, since all
Lorenzo=E2=80=99s comments are addressed in my reply except the changelog o=
ne, right?

>
> Acked-by: David Hildenbrand <david@redhat.com>
>
> --=20
> Cheers
>
> David / dhildenb


Best Regards,
Yan, Zi

