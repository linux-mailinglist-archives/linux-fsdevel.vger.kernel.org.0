Return-Path: <linux-fsdevel+bounces-43213-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F09FFA4F6DB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 07:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E0AD16A452
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 06:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1921DB128;
	Wed,  5 Mar 2025 06:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HPEsFP5g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2046.outbound.protection.outlook.com [40.107.236.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3E0170A13;
	Wed,  5 Mar 2025 06:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741155059; cv=fail; b=HEbuf09WrztPjZt7P8x6lzKQAO40Piv4R+iB1SWvqyzhVGkvXHsSgbJtV7pG7SOA/03/XDPdJfIpzpMr+CXp/xBiw72KXZknFbdbcZI9qqOP+1+aL13XPq5XY6YAb1K2fbEMJNzcStn4D34zLoiCySZhSvq+fdrPk5cr8qQin/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741155059; c=relaxed/simple;
	bh=F2vM6bdoZxhWmSkKCRkUDEkPDGRX8ZlINtwVazdGDqc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FTj4t0rjXK56h91V+fepvoVaapToURbLM+YIRBiqY+PvBk3/2B/4hx5rHTbCem9ZRANYfrdOuYQd6+VqjuvyXb0nsZeFRzOcK2DyTJlrjWLap1nN95qO5sHRpVW2kPFXNDbKM7bSUHVSfJz1DrRyqgptFFpt/owBMnQ9ni2+fTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HPEsFP5g; arc=fail smtp.client-ip=40.107.236.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dphgHOrHS/oGfUPsOuoSO659LCqq8WEoGSl0H+62c9CluKG0SQqbpOzpWRqNwiCSoRcto9hY0IsMceTsU51Y4YCKVWqQcDhmmHCIoGGvCrq3hH3cGPiydNM2AWJS65jqYrXhHoqtzNZbMwKh6lrkQUTLdkt8OB0i+/Klr3dUQHTjRyMOQ2QY0U3i8B/Egvx8UoLaa8/SasfbxPa6PD1/yMleTmtg50tOeHlTmpADzym+VZqXDCBhDwbangcBpK441EgzDcM6i/ApiBoNziyjJCh0Ngm/g138AkgTgXVh7dGr8f04r4/AXp+wyHMuzbbPN/UEDIrO7O73/J4/9xqKpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qyTXpHcVfgoEcrTj/hOybcrS08QQ5PuT2e3ccUDhUsw=;
 b=MfMbGENFhL8JJpmo48/d7/jbBmKnm5o9kGdjzVJUSl3LzdUw2DXaWPu8ZTXvCevwYXQ1RGj1ldZtkLS5aMgURcqkjpPeC9Ya86DtPph8zWzwzyc5fYttB7Rueb7fhW1WXm83a7Gklo56BG4TJExSHL4xSh/92hTQxQWS29tLeI9MMAF9JoaAJp300maiym/5TFJNyu2vy4/iXjBcQ+kkNgbgXKHxgL1kpUc94NI07dyFb3DpX01d+TPpafDSdSrj92U4tu1ILeQ0HibfQlugSz8YkVfCnUBL1W2wLOXySZcV5s5bQrbFcx3oD7BDTrHYpfLaeYa1hPMV50KOBOSzKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qyTXpHcVfgoEcrTj/hOybcrS08QQ5PuT2e3ccUDhUsw=;
 b=HPEsFP5gk/q14Ecz/pAKLDnf5PsMXXqx/98EqKQWwPoe90GuhTtVVIHX/M+NqrQL6awVEb2eebKfdHFCmqRPr7pmIrVXmQokQX76UcNWTc6X3qVj+Du5JxaX+R3hSwkl/z+bmSkM5sgjO/8O6wRp+wZwxtzQWpLWPednx8vYIFQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4262.namprd12.prod.outlook.com (2603:10b6:610:af::8)
 by DS0PR12MB6582.namprd12.prod.outlook.com (2603:10b6:8:d2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Wed, 5 Mar
 2025 06:10:55 +0000
Received: from CH2PR12MB4262.namprd12.prod.outlook.com
 ([fe80::3bdb:bf3d:8bde:7870]) by CH2PR12MB4262.namprd12.prod.outlook.com
 ([fe80::3bdb:bf3d:8bde:7870%5]) with mapi id 15.20.8489.025; Wed, 5 Mar 2025
 06:10:55 +0000
Message-ID: <476ddccb-3736-46c9-bbd6-b803138d5a3a@amd.com>
Date: Wed, 5 Mar 2025 11:40:45 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/5] mm/filemap: add mempolicy support to the filemap
 layer
To: Ackerley Tng <ackerleytng@google.com>, Vlastimil Babka <vbabka@suse.cz>
Cc: akpm@linux-foundation.org, willy@infradead.org, pbonzini@redhat.com,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 linux-coco@lists.linux.dev, chao.gao@intel.com, seanjc@google.com,
 david@redhat.com, bharata@amd.com, nikunj@amd.com, michael.day@amd.com,
 Neeraj.Upadhyay@amd.com, thomas.lendacky@amd.com, michael.roth@amd.com,
 tabba@google.com
References: <diqz8qpqlzzv.fsf@ackerleytng-ctop.c.googlers.com>
Content-Language: en-US
From: Shivank Garg <shivankg@amd.com>
In-Reply-To: <diqz8qpqlzzv.fsf@ackerleytng-ctop.c.googlers.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXP287CA0009.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::15) To CH2PR12MB4262.namprd12.prod.outlook.com
 (2603:10b6:610:af::8)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4262:EE_|DS0PR12MB6582:EE_
X-MS-Office365-Filtering-Correlation-Id: cd9a4931-c234-4551-67a7-08dd5bac7d13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bFNGQVR3UWRuR2lrbFIwcHdTR2o5TDU5RkdmSHNTMnRUclVHOEtUMkdHSjFD?=
 =?utf-8?B?VU1McHpYaHgwbHcrTVhzcHlPT0RiVUZFanBGVGw5amEwcTY1em9vdkVaSlVG?=
 =?utf-8?B?cWEzU0ozTEs3WjZ6L0xZQVpIdXROQm51TDNKZGtCcGREWE96MW5wb0ZmQ2pU?=
 =?utf-8?B?YVpyZExDbzJKTXVWOWFYUzlxOXNKbGVBcS9tdnJCUzlXZnU4eGZVa0JkNmdW?=
 =?utf-8?B?a0tqNWNoLzRaL3lEQ2FLNkxTU0lDM0lQUHF0VG16cms5ZXFhaks3eG9MMVhT?=
 =?utf-8?B?dENmRVVwckk0a1BJYzlSdHg2aGVHUklRY0Fnb3NmamEzWjRJOWNTTU11b2g4?=
 =?utf-8?B?UjZidTZqdW0zWmVRRC9TRlpLNmxLbjd4WENRK1FoOWMvMEo5aDJCTTk0Nms2?=
 =?utf-8?B?dUl2cmxoSmJkWk42ZENNZytzMnorYnlQK2pYeHF1NTRDMFYzbmZNTVZuNkxE?=
 =?utf-8?B?TUlYdS8rTVZyMllKL2FNNGIwTmpXRFRPQlZpU0pDT0Rwa0VySWJJSXJ4ZGZz?=
 =?utf-8?B?RzFyd2diOHB5REU1d1k4SzFxbXV5OWo4RFBkV2hQY0VLaGovVmpBRVc5dzly?=
 =?utf-8?B?d29LajhCVG9jeW9PbFU1MG05NW1oZUpVL2RSTjVxUTRQL2VSb3l4b3RoRlJk?=
 =?utf-8?B?U25ZK3VhUVVjVjlNTkhjMHNhUlBqTWRuZGtXb09FZmlrV3Z3WGV3SUZDL25B?=
 =?utf-8?B?SytuWk42OEQrVnVvTlpBOFkydUN6Mnh4ckZRWk45dGpQL0xhWi9DWEo1V09O?=
 =?utf-8?B?K3hyRDBXN3FYZXVrVkh3a0dMb0ptWWhrSDI5OGtzVmkxbDArbzNJNXlRUUdR?=
 =?utf-8?B?VXhiQk81SUErSVBOZnlOWFp6aXducUE2YitIdm85TmtpeU5kTlpqMDZaNUZD?=
 =?utf-8?B?aXhXcDBUMUxwQ0VJMWszZ0FUd3NkOFBFN2RlekxaUmlZYWg3OWRGa1k1Z1ZC?=
 =?utf-8?B?bFRjOG90U2xLRjlhZG1hdkpZZFR6Y2lpek1aS1JsVUYwdkw1L0hJOVAzcEVM?=
 =?utf-8?B?ZlNIaUdMNUFuSCtZUUhIb2cyVFZiQzF6ZTkwa1BKYVllcjJhaGlmcTRNTGww?=
 =?utf-8?B?ZHhRY1JOMXlsY3dIS2JVdkJuVkhHOTB2c0ZmVGtFRk0zcEVqcGhCOCs2WG5V?=
 =?utf-8?B?K09BSzFtMTlYVVdWekY3TjRad1kvOXBEWkhwT05aNVN5R3V1NzlGOXBTUTlZ?=
 =?utf-8?B?SU82blpmMW1LWG9ocjhwL1FnNEpyRmdFMEQycmhCMXpPZzczc0M4RWtkMzNP?=
 =?utf-8?B?bU1hRXJGZ2hiam1waDlhODdWRkZTZllSbVZac2JDTmNkemJHTEtDdXFFc0xK?=
 =?utf-8?B?c1hjclZVNXdSNnRGbmhQTWwrWEFDUnVNdGJ3eHdwUElJMmdNZ2QwUGhnbjRC?=
 =?utf-8?B?L1NpUVdBOUhFTFNJUGg4UU9SV0xCUS9uNVRCaFg1eEkxSitLWXlyNm05MEVo?=
 =?utf-8?B?cHd5NkYrcVdXcDBaSVZwcy95NmE2RG9SK3owZ2xwTXhId2hsOG9SNnJkcXZJ?=
 =?utf-8?B?OFAvcHdvVjkvNVhGR2lkKzVDMVAxOEpDRnF3eWY2cDVJUkJsR3RZbGh2ajFl?=
 =?utf-8?B?ME0wdElqUkR3OE1mYStxTmxGcVRGdlo5QktwWGxSbktRL1JFaXh2TmppcW1I?=
 =?utf-8?B?ekU0Q0wySHBjc0VTZ3lmMTROY3NpNnBqVWRtSVJtZlIzRXkyLzJNenlqTFlX?=
 =?utf-8?B?bnFyMDF1RXpvbWIzVTZkRWF3WG1SWVIvNGhIaTlHWC91RHIxUzBsMFZyUjBh?=
 =?utf-8?B?MXhnVTMwSE1kc2JrTmJXVlFJUVdwSURQSTk1QW1wSTZlSVgvazkxendWK092?=
 =?utf-8?B?NzIwWWtpd2ZGQTVQa0xSUU5VcnFqQ05wMzRUSUpOSDIwMDR1ZmYwVk1YNFdk?=
 =?utf-8?Q?RVB2LXiCg/w/L?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4262.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZVhtb01RUnpabVZxeERIZGxMUU1xV0Y2VlhacysySEltYS9BeXdtUmc1VXpi?=
 =?utf-8?B?ampBcW5sdlgvbnpjYi9jVVRpdlR0TytFeFc0eG9mR0V5ZmlXOXNmY05CZTlm?=
 =?utf-8?B?L0pEMTVxU0djcDlZT0FMRXNPakdDQi9wRnJTZHVpWmZHektIeE1RSVdNNFlW?=
 =?utf-8?B?eXFEbXNGNkc0dkMybFc2UG8vMDlleGpQZThNeHArQkdKM2N5OHNPMGR3cnp2?=
 =?utf-8?B?dGl5Q2c5R0Q0cUMvZW9xTUFmSmk3MWZSR3ZRM3lnU0paQmc3ekdGTWdDK2pa?=
 =?utf-8?B?eUlMWWlUM25BSGl6VXRXTXp3T1dCU1ZRVWgybThnU3ZOOGFvUjZhVCsxZVdJ?=
 =?utf-8?B?bUVRMnowMnNGOEo3K1dSQk1SRVdXMG11dGtSMllUOE1FOGdIdEU3ZVVmTzFR?=
 =?utf-8?B?M0p2RHI5OXVVakVtRVVDek84V0tRTjFZVkRFRmJEVE5QTEU0TTBmS0pBOVp2?=
 =?utf-8?B?UXBJY2RXUXlKOXkxd1R4NUR4cW9xT0huSkVSRDAyYUE1WVh4dllwaWcxMVlW?=
 =?utf-8?B?a3FmSTNQelY2MGgyYWxYR2lHV3NvN2pYblA5bURzMGhCcXU1ZFBaLzI0a3hi?=
 =?utf-8?B?V0FhRUxEdFJpeCtEZUNST1FqQ0Q5eDBpTy82VmJyY1lGMnc1aU5yUHBhWnBL?=
 =?utf-8?B?aEU3MzJya2ZVcFhyL3ZNK3UzZm5ySzN4L3RxOEFOYWtNQ09vU0NTTzNKd2JO?=
 =?utf-8?B?QUZPZVdZaWRid1E0RkhCODZSQytJU0JuNGxObytuSEFsY1VMdDZyY0xMTlgv?=
 =?utf-8?B?VXZzOUJieWw2bkhMQXpWRmRTTmxOU1R1dzY3VDlqLzNlRnNxc3NMWXdPU0t5?=
 =?utf-8?B?UnBRaDFCMlowcEJjYlM1WTFtMTBKNFE1Wk9udHFzenlUUTczRHNESFhJWDVE?=
 =?utf-8?B?VVVIamtyYzVUcVdJQnU0Z0pFS2ExcFhvZUd6ekZXZW81RFBaMHJrOWp3Q3VT?=
 =?utf-8?B?aGlYSUkzZURLTDFubVZBanZFN2hoRnNSK25BOHhmV1ZBN3NWdE1ZNG0rcWV4?=
 =?utf-8?B?MVBvU3UyYmlSbEkvL2NKMVVYeUtJcTk4KzJxdlNXWlF4M2JMc3dsLzRuV3ll?=
 =?utf-8?B?VHFkeDhOb1VROWR0SHB3WXAyUDFValU4RCthYXJ4YmhNSXRQdE1EWlp2SWFW?=
 =?utf-8?B?NUZNRGYxaWF1TXU5YWIzbUx2N3kyeVJtMVhCNUFBaEVOV1B1QnNQbWpITStF?=
 =?utf-8?B?Zi9CektCOGlEYUpNNEJNMXZXc0N2bkYxQjlKQW9XdnhHSmd3OFphN0pwczlw?=
 =?utf-8?B?RFMwdXkxd0xtejh5S3pMcnNhZHM4OUR4M3U1S0dZbUJIMnRxMXNBcXB6VW1o?=
 =?utf-8?B?Ykh4K3RBSmFmSFFWNHhxK2pMWFhqK29RSksyeDFONTg4SlE5SmRqSEE4OHpV?=
 =?utf-8?B?NFhJeUd4VVlsbVNua2d0QkFQYmhCVGVzbDI0ZnBnOGRNQkZLUUt0akpUQzlU?=
 =?utf-8?B?OHgydy9FYzB6aHBHNGUyNjd3SW5HWFplUCtnOXpOdjNYbjc0NUJLQ3pvRThD?=
 =?utf-8?B?d0pJb21HcTE3cU1wUjZOZHJKUCszblF1Zkg1bkVIZ1dsQXJmbWxrZWkzeHF2?=
 =?utf-8?B?VUxYY3IxaU9RZnh1aG1GdjBlU2ZzR1FSYi9pYzJ1YURLdWRkblhUTVZUN21q?=
 =?utf-8?B?NFhZYXF1L2F0Mlk1b2Mvbm94TVhKVFpHRnkybzNrdHVkR2lOaWVEalltVXdY?=
 =?utf-8?B?Qlo5VmNpakdvVXRiY1BpeUhuL0l4dUxqL01sL2ErOEkxeFJCcTJoSUw3RnNM?=
 =?utf-8?B?N0JIYU1NV1lQYmt0U1ZhcDhYbkpnTkF2YWcwa3JDMkYrNmpZVThtdzc3RVlF?=
 =?utf-8?B?R2NwenM0QmozR2J0TXpJektTR2pKSDIxREduOVA3L2RFOVJ3Zk9HWXBHVVZV?=
 =?utf-8?B?UE1ybEYzZ2xOZE5MV2dSYkdnYVZWL28rcDZPYU4yUVdMQUxad2p4QTZUU2hp?=
 =?utf-8?B?V0Z5RVBNd3pGT09jN2p3bmZDeG1HWGZpZjdWeEJsMnA2YkNQeUh1RVc5NWJq?=
 =?utf-8?B?NGJHcytTZnBRMnVpaTFoTEMvUGZRZ1VOR0dUbHAwaDdYQUgraUVTdHNLR2Nh?=
 =?utf-8?B?TVdtS0VOSTdmSEVCd3lLVXF6YnI4UWQ0bENBTzlGc3Foa2JmWDZGU1pZNzR4?=
 =?utf-8?Q?ybG0dQ2+O71KBSdNThs+CBD2K?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd9a4931-c234-4551-67a7-08dd5bac7d13
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4262.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 06:10:55.1158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r2H/F0h1s5WX3Wm0hVt6RLRctraeuKFngo5QAXzbExLLId2/MZdRnD8N3k5mYbUuOlX0kCR2cc3OX0bT5pdHEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6582



On 2/28/2025 11:21 PM, Ackerley Tng wrote:
> Vlastimil Babka <vbabka@suse.cz> writes:
> 
>> On 2/26/25 09:25, Shivank Garg wrote:
>>> From: Shivansh Dhiman <shivansh.dhiman@amd.com>
>>>
>>> Add NUMA mempolicy support to the filemap allocation path by introducing
>>> new APIs that take a mempolicy argument:
>>> - filemap_grab_folio_mpol()
>>> - filemap_alloc_folio_mpol()
>>> - __filemap_get_folio_mpol()
>>>
>>> These APIs allow callers to specify a NUMA policy during page cache
>>> allocations, enabling fine-grained control over memory placement. This is
>>> particularly needed by KVM when using guest-memfd memory backends, where
>>> the guest memory needs to be allocated according to the NUMA policy
>>> specified by VMM.
>>>
>>> The existing non-mempolicy APIs remain unchanged and continue to use the
>>> default allocation behavior.
>>>
>>> Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
>>> Signed-off-by: Shivank Garg <shivankg@amd.com>
>>
>> <snip>
>>
>>> --- a/mm/filemap.c
>>> +++ b/mm/filemap.c
>>> @@ -1001,11 +1001,17 @@ int filemap_add_folio(struct address_space *mapping, struct folio *folio,
>>>  EXPORT_SYMBOL_GPL(filemap_add_folio);
>>>  
>>>  #ifdef CONFIG_NUMA
>>> -struct folio *filemap_alloc_folio_noprof(gfp_t gfp, unsigned int order)
>>> +struct folio *filemap_alloc_folio_mpol_noprof(gfp_t gfp, unsigned int order,
>>> +		struct mempolicy *mpol)
>>>  {
>>>  	int n;
>>>  	struct folio *folio;
>>>  
>>> +	if (mpol)
>>> +		return folio_alloc_mpol_noprof(gfp, order, mpol,
>>> +					       NO_INTERLEAVE_INDEX,
> 
> Could we pass in the interleave index instead of hard-coding it?

Good point.
I'll modify this to allow passing the interleave index. 

> 
>>> +					       numa_node_id());
>>> +
>>>  	if (cpuset_do_page_mem_spread()) {
>>>  		unsigned int cpuset_mems_cookie;
>>>  		do {
>>> @@ -1018,6 +1024,12 @@ struct folio *filemap_alloc_folio_noprof(gfp_t gfp, unsigned int order)
>>>  	}
>>>  	return folio_alloc_noprof(gfp, order);
>>>  }
>>> +EXPORT_SYMBOL(filemap_alloc_folio_mpol_noprof);
>>> +
>>> +struct folio *filemap_alloc_folio_noprof(gfp_t gfp, unsigned int order)
>>> +{
>>> +	return filemap_alloc_folio_mpol_noprof(gfp, order, NULL);
>>> +}
>>>  EXPORT_SYMBOL(filemap_alloc_folio_noprof);
>>>  #endif
>>
>> Here it seems to me:
>>
>> - filemap_alloc_folio_noprof() could stay unchanged
>> - filemap_alloc_folio_mpol_noprof() would
>>   - call folio_alloc_mpol_noprof() if (mpol)
>>   - call filemap_alloc_folio_noprof() otherwise
>>
>> The code would be a bit more clearly structured that way?
>>
> 
> I feel that the original proposal makes it clearer that for all filemap
> folio allocations, if mpol is defined, anything to do with cpuset's page
> spread is overridden. Just a slight preference though. I do also agree
> that having filemap_alloc_folio_mpol_noprof() call
> filemap_alloc_folio_noprof() would result in fewer changes.
> 

Your proposed structure makes sense.
I'll update the patch to add these suggestions in the next version.

Thanks,
Shivank

>>> @@ -1881,11 +1893,12 @@ void *filemap_get_entry(struct address_space *mapping, pgoff_t index)
>>>  }
>>>  
>>>  /**
>>> - * __filemap_get_folio - Find and get a reference to a folio.
>>> + * __filemap_get_folio_mpol - Find and get a reference to a folio.
>>>   * @mapping: The address_space to search.
>>>   * @index: The page index.
>>>   * @fgp_flags: %FGP flags modify how the folio is returned.
>>>   * @gfp: Memory allocation flags to use if %FGP_CREAT is specified.
>>> + * @mpol: The mempolicy to apply when allocating a new folio.
>>>   *
>>>   * Looks up the page cache entry at @mapping & @index.
>>>   *
>>> @@ -1896,8 +1909,8 @@ void *filemap_get_entry(struct address_space *mapping, pgoff_t index)
>>>   *
>>>   * Return: The found folio or an ERR_PTR() otherwise.
>>>   */
>>> -struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
>>> -		fgf_t fgp_flags, gfp_t gfp)
>>> +struct folio *__filemap_get_folio_mpol(struct address_space *mapping, pgoff_t index,
>>> +		fgf_t fgp_flags, gfp_t gfp, struct mempolicy *mpol)
>>>  {
>>>  	struct folio *folio;
>>>  
>>> @@ -1967,7 +1980,7 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
>>>  			err = -ENOMEM;
>>>  			if (order > min_order)
>>>  				alloc_gfp |= __GFP_NORETRY | __GFP_NOWARN;
>>> -			folio = filemap_alloc_folio(alloc_gfp, order);
>>> +			folio = filemap_alloc_folio_mpol(alloc_gfp, order, mpol);
>>>  			if (!folio)
>>>  				continue;
>>>  
>>> @@ -2003,6 +2016,13 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
>>>  		folio_clear_dropbehind(folio);
>>>  	return folio;
>>>  }
>>> +EXPORT_SYMBOL(__filemap_get_folio_mpol);
>>> +
>>> +struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
>>> +		fgf_t fgp_flags, gfp_t gfp)
>>> +{
>>> +	return __filemap_get_folio_mpol(mapping, index, fgp_flags, gfp, NULL);
>>> +}
>>>  EXPORT_SYMBOL(__filemap_get_folio);
>>>  
>>>  static inline struct folio *find_get_entry(struct xa_state *xas, pgoff_t max,


