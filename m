Return-Path: <linux-fsdevel+bounces-65577-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A193DC07FBD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 22:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 580653B6D27
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 20:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F8B2E2EF3;
	Fri, 24 Oct 2025 20:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3OP5kaH6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011015.outbound.protection.outlook.com [52.101.62.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8780C2E040E;
	Fri, 24 Oct 2025 20:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761336507; cv=fail; b=h3j5MFwgd1waQdYshsvxGOzZlBvL/qxfmoyvHIqgQnu4unCkSBmPLrj5bTK2LxBnEH3NSExXl/0sIB63agJ7QQFU6S2O41MhhvR+MXUikgTw3AcfS/Op7BKexu/VwEOQz7spxHlPlnCtoYSpEwCT9BmEnGb5eLMchPwzJualjlk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761336507; c=relaxed/simple;
	bh=gY58F5j+5LJQzMoJLI2OUhhWe51O03vOTZmmJX5GLwA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CWUZmsxG9dJJ/XpAP5PIQeHZwxnIEGmyq12+JrFBwdokvNa6ndoifnROnXTJ5ehkUU9Y1lRqGKrBcE3eD/OIl9o/VMC0RojX1Y9/mOPwiPOEgV13qzxEsCoelx5O1xPnx8xD5lScARbbJSPbyAmL87Htzl6ZLxnmeEyogsMo6dA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3OP5kaH6; arc=fail smtp.client-ip=52.101.62.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nABi3FUWSdRAb6ZcHdVdwIwcxxt701D/c2ez6wap77u6z73hDeEYiIQ4ZSwEXc2zmu+BuVPzy2dwjdtM0smbdi/AfL9GrvjszzCUL9ksA6RDNSYTA08kuE2kmlRH5gBb7wvDjUPw37kYOQdT0+6/6wgknPbWbQM8EygvE9VbzsdGYsG2E7ajq7e4GMUt+E3grhdGWIAeDa+hFXy7nx0UxgR6Cw9SGd4iNpyfj3MGw/vNFMfoE45616z+B6oqaZQzvI0Yb9st2cmCzcjC1wHSSaP+vXQrhawkRY91RJwPgYUkUn0awbFwTPyyUx+XJhriax9H5RqpcJinxfGdJO7ebg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XWdVPrygvC0JJeFtmfNwN+G+FfQKfPKH+M85oxZtFF4=;
 b=J8W1r75tJFn+QkZvukmKdoCySxW0wwuMrHLRbFSZcoccUUn4nkip+zunBd7CsIQgzI7nCjQFS9dQjDlfvunE3Q8LxYZR7hMCnpV39Bdwlu6jZhunDkj9SGsAkuYbCv0zQ4fh/AYP7xyk30QLlr0pXbsyxMkMuUI1WrLxKXPxrD8QpjtPvDcF0Cya7a1Q+8QAUTu95vSWq01/v716ophUHC2VBzUMh9tz/4xscsppWNDhc0THf20XE9/dWeJus0QukZgrX1RVB2xQmqTZGp3750ShleUrXA+tdhQvArHbvjn2wxpllvJ7xfq6tHi115bbO0AyptuYqFahND8e56ca3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XWdVPrygvC0JJeFtmfNwN+G+FfQKfPKH+M85oxZtFF4=;
 b=3OP5kaH6Lo/jmHZo9jFQTBWeksPAhUlq2JctCQeyOh2umi77Cf526B5IsIe/yk1j5HfJQq964Jh5emIU6bar1wHXEVfjDn4UXl1cU+4Eq+Ig3MkZPhnm38dZSSHKNoG25m6+09xSNi8uQGUeM3GW3BfQRpUqKiBC62z70bccKtk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB7142.namprd12.prod.outlook.com (2603:10b6:303:220::6)
 by SJ2PR12MB8781.namprd12.prod.outlook.com (2603:10b6:a03:4d0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 20:08:21 +0000
Received: from MW4PR12MB7142.namprd12.prod.outlook.com
 ([fe80::e5b2:cd7c:ba7d:4be3]) by MW4PR12MB7142.namprd12.prod.outlook.com
 ([fe80::e5b2:cd7c:ba7d:4be3%7]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 20:08:21 +0000
Message-ID: <d920b7d0-61db-481f-b256-a1f51ac7f743@amd.com>
Date: Fri, 24 Oct 2025 13:08:19 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] dax/hmem, cxl: Coordinate Soft Reserved handling
 with CXL
To: Alison Schofield <alison.schofield@intel.com>
Cc: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-pm@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
 Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>,
 Pavel Machek <pavel@kernel.org>, Li Ming <ming.li@zohomail.com>,
 Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
 Ying Huang <huang.ying.caritas@gmail.com>,
 Yao Xingtao <yaoxt.fnst@fujitsu.com>, Peter Zijlstra <peterz@infradead.org>,
 Greg KH <gregkh@linuxfoundation.org>,
 Nathan Fontenot <nathan.fontenot@amd.com>,
 Terry Bowman <terry.bowman@amd.com>, Robert Richter <rrichter@amd.com>,
 Benjamin Cheatham <benjamin.cheatham@amd.com>,
 Zhijian Li <lizhijian@fujitsu.com>, Borislav Petkov <bp@alien8.de>,
 Ard Biesheuvel <ardb@kernel.org>
References: <20250930044757.214798-1-Smita.KoralahalliChannabasappa@amd.com>
 <aORp6MpbPMIamNBh@aschofie-mobl2.lan> <aOlxcaTUowFddiEQ@aschofie-mobl2.lan>
 <e2bf2bf1-e791-47e5-846c-149e735f9dde@amd.com>
 <aPbOfFPIhtu5npaG@aschofie-mobl2.lan>
Content-Language: en-US
From: "Koralahalli Channabasappa, Smita" <skoralah@amd.com>
In-Reply-To: <aPbOfFPIhtu5npaG@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR11CA0078.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::19) To MW4PR12MB7142.namprd12.prod.outlook.com
 (2603:10b6:303:220::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7142:EE_|SJ2PR12MB8781:EE_
X-MS-Office365-Filtering-Correlation-Id: 82042873-aadf-4a5f-2cfb-08de13391462
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eWJ3cnJSdU5YOUFlMlJabnkrTUhQL2MrMy9IRDZTZ3ZNQlRFbGtKMEVpWWNL?=
 =?utf-8?B?bzRTL2Y4azIyZk1vZkRlWUJwb3g1Z0hZK1Ryd21YSzlkSUR3RG5yZGV4VXFw?=
 =?utf-8?B?ektaQkNaRm5xQldKbVdnNlh4NzFzLzF2ZDRQbWNGcVNEdW9wdXRuZjg3RVFT?=
 =?utf-8?B?WURjeUMvdENtSWhEZitSZDdsQjgrRlZiNnh3eHNnRXB2YVNxTytlTEZTeFoy?=
 =?utf-8?B?YnVIelFlY3lVQ1dsTnVkOURSSWphWGRuc3ZhN2Z1Tk81SStpTUg1emtxY1lU?=
 =?utf-8?B?V1hMcnFuL3lRajJ1YW8xcThWMHExSmVVUzc4Wk9Sdm1xbkRRUVdxWWw5V0Np?=
 =?utf-8?B?cmN5UklTbUQzSUxYMitiQnNkMDBEOHYrY1Z0SDZvRDl4aEYwUzZqeTZXWXBY?=
 =?utf-8?B?WStYR0VxMkJYQkZmZCtwQTUyWXlhYVRPOGNFRFFYZUgwRTBMZEJLY1FROWo3?=
 =?utf-8?B?cHMzcjdLc3hKRDhhN2tyTDl1d2gwL0xHaDhuTU1tL1RqMElFaENoVUE5NmtX?=
 =?utf-8?B?R2pHU2hiSkh3N2JDdmg3Y3J0ZTlpTVdGZ1BLbGplQUwva2htTy9LNEVTSk8v?=
 =?utf-8?B?ckJiN09zRjNWRXlFa1dmc3YxckJ3OUhOdHZETW5MNTRkcEZtMStHOStQRjB6?=
 =?utf-8?B?VDFLMmdXNVZNU3U2dlkxMWx5anp2aHJtbnNCbGZkengvVnZrSVBZZDRibXEx?=
 =?utf-8?B?dVQyeUIxNDRTeHpUaVFZWENaMFdobzVpWjBuczZJWWdOaVNDa3dPNnNkdURE?=
 =?utf-8?B?eTJ1bXhLeThFK2JuRklLYzF0QTBrbGhsN1lnMjRxQlR5NEljNkRERkxWV08z?=
 =?utf-8?B?KytTaEFyanVpdDJ6RTNHN1REVlZ3ellDam9MQi9ReFdzSUtUMFBVaUV5YnVL?=
 =?utf-8?B?OXBVUGxzWFFxeWU1Z3hiYzFyRG5JMmpKSTl6RytVTm85TU9UWmhWZVhSYjVu?=
 =?utf-8?B?N1NEUWpzSk92eXJGM2srU1hXbjlySWFaaEdTcmFlSm5SU3UxaDc4RDFqdnRi?=
 =?utf-8?B?akFaejJBS1RJSTZSaklPeDBpa3ZLY0k1SkNwcUNOeGhYYnRlcjdsa0UzdjUy?=
 =?utf-8?B?bW1CQ0xoMDlBZDBHK2czZUd3cWJ6UlQzcUFPSDVXV2tRdjJTWnRwQTNpYXRD?=
 =?utf-8?B?ek43YVNEdkZvVHdFcEZQL3hmTGNYdm5pWGJVd1IweHprKyszT1R6T1BlYUNZ?=
 =?utf-8?B?SmlQTmROTTdXVUM3WlpSUWFjakJDblA1YitRUmFxUFpnL0lHVDQzL0pQM2NZ?=
 =?utf-8?B?NFpLYmFJYXNrNXBXWVlibmRKVDVjaWp4VnZDaXRUT0tud2VVSGFsaHVRVkJB?=
 =?utf-8?B?d2F1eGJlYTYwSkJzeUJYMHAyRDhWUnJYWG1XaTR0S0M0a2JqVndnSDNhcDZn?=
 =?utf-8?B?SjNlaDVZRkRsL1NQeXpkWUZhZzl3QmtuQjBVQUNnOVNQQ0x4VU96dUpxZkN4?=
 =?utf-8?B?ekk1MkxyMTlqTEIzdi9lYmtBb3Z6OHhIWjVsVW10YzhOOGxFdnl3YTNRVEw2?=
 =?utf-8?B?RDEvUDhWVVIyUXQ3V21VWUVXVElCaEh4amJBVjkxc1ZvN2J6R2hNMmlGbFFF?=
 =?utf-8?B?dEtxdm5UUFdmNURDaHRFMXZHcEE5MWlsL25yR1JlUnNTK1JtSlpuNEo1ZmNm?=
 =?utf-8?B?MFd5b1Z2cmN1OUtFcVVlbjF1NHNka2s5OEJkR1pWZWRWYVZCUFFFSXpaLzdj?=
 =?utf-8?B?OXhGVDllRGl3NkZCMGI2akFZUFNxVlNXaUNma2VSb0M0bDRBN2RPeFZOcU1W?=
 =?utf-8?B?Q3VEYXR6ajdYb3JTVlhhbU5vWUJsM1ZvaTVrRlRzS2plOW1pcTBxSzBPMjRC?=
 =?utf-8?B?MUNkaWNmalcvYlhnVElDcHlHTWwxcGdJNVpPWExjcjcwbHpmTW9ldjJzQ2ZU?=
 =?utf-8?B?WHlGdDBPcWlJaTFTZ21QeGUrZ1haZEhzTXNQYUdoZDFncEdhNmVhdWxVZnVB?=
 =?utf-8?Q?zdycqS+nqGE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7142.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bExlWU5aN0l1eUJkZHRUSGdobkVaLzdqbXpZWHNZVVljNHZyK1VRT3VHWUcw?=
 =?utf-8?B?eThXYVRuZ0ZyU0ZWOEgweTQ5a0tleFlnRXdzcmtUVkkrelZQSFpONzJ1NXQ5?=
 =?utf-8?B?ZEdSUEY0VDFpQ2NkeDYwSStkd1lIQUtLU2M5cFA4WUtHWVA3TjRRVi9RRjRk?=
 =?utf-8?B?eHBGNzBQNlB1YWJlZitOK0lOV2o0NDJ5NUlrZVEwUFhDanVWL1RaQ1dGQU1I?=
 =?utf-8?B?SkprbnQ2TVhseDhOQkxQNjdLNi9CL1dkcjAxQ1FmaDk4VUd3L2F3bHM1c05s?=
 =?utf-8?B?dVhOU0dDWk9hOXBmK1NlcEgzSE9FeCttUFFZdGVPd1o1L2hrQlJIOE9pTTRi?=
 =?utf-8?B?ZGxIUWdWeGFsV3o1cyt2TC91RFlBWWNxaHlCbFlScE4zd0N1bUtxK25kVTJs?=
 =?utf-8?B?YTdWT09id2tjTG01dG5RVW9KTXZjY1NiVElCZlcwZmxGYlBxdHJwTFZhcFdZ?=
 =?utf-8?B?cEwvMFNTUVlmRmxaTUZNZzBJczFaV1hhK2tlYXhhSHcxL1ZIWmgrWUJLWFN0?=
 =?utf-8?B?YWxxZDM3ODg1RFV5YmFMdGJjU2VDd01EeUt4MWp2SFdDZU1CM29OR1VhWk02?=
 =?utf-8?B?YldUd2p6bmpiU1k5OTAydkxXclBlQVhZUkpxWXNxOFByNEhKYjJGLzUyYjhT?=
 =?utf-8?B?WVJpRW9XaXZnRWNiR3N5Z0x4clNxYVkwM2JkYWJMOTEyTTU2amNKMHlJNDJ0?=
 =?utf-8?B?dEZmSVVMNUhNZWZCTEJrKzBmdTRNMjNLR01NSGd3UnJKWkVUNmgvSGVUYlhj?=
 =?utf-8?B?SFVLWFJXdnJsblNUMzUvbGdsQkN1cnBQTzlGZnZLOVRTSlJaZVQzbUhjSENK?=
 =?utf-8?B?R0pOajBqdi9GRDhlOEpTZkxsZE1JYnRYVDJiYjJvSEFhQVlLdmpucUpnUktZ?=
 =?utf-8?B?ak1YNVJhbW1mcWxPcENSbHZ2cytxekd0UWVhTXNiY0Qyd0dJblU0QTVaMkFi?=
 =?utf-8?B?NE5NNDkrdkVVVFR1WTJ0ZzhZa3RlaWJPUm5iTW5vWk1nVmZZYjNOOGhWV09G?=
 =?utf-8?B?TFRhUTc3T2RJOXJkcW9PVXU5V2E3RWZpSGtsQnFOTFZYdmlzemVESHRCaE1i?=
 =?utf-8?B?ajczMTE3RWpUaVBCcW1ENFNhVmFuRU5GbHpNZzE0MGkrbm5KTnorcXM1K0hH?=
 =?utf-8?B?WjFIbEFyMjE1WUZHNWprL2NZamtpSDBZeEgvWkRLQzVZUFdySEFkL1orMzhs?=
 =?utf-8?B?Z1c4dEtGeENaWmhSRWROQ2JoaWRzamQvdm1CSVJ2b2RuNnFJbElVN2QveGxl?=
 =?utf-8?B?UlNPMGFjY1Vtd0JkZ1BGdVZhTXF1TjZrRFlJblVXb1I4SXJ2dnlUVTdzVFBu?=
 =?utf-8?B?NXJ4QWdSOWQvV2ZDNWh6SWV1b1RUR0g2ZTUzYXIwMURtWXQ1bEQ3d0haN3N0?=
 =?utf-8?B?bmFpcFR5bkJmbTByRW9aR3ZaSWNOR0JmRE4vK0RqcGtTN2tNSmtBbjRPelFx?=
 =?utf-8?B?L0NobnJRT0V1ajVzM2U3N2Q4eWJ6bUNqeWxQVDhLSjNCbHN0bDJrYUY1QVdI?=
 =?utf-8?B?Y3AxUXN0c0tzZzZtT3RpZ29XUlNQUks3ZVhjMFlrSkVQbTUzb1RIamhXeC9o?=
 =?utf-8?B?blFaVWxiT3J5cTdDZnVRL0pQRGM2b1dZSUl0eW1sSXcyY2pjM0ZGcG0zZFNw?=
 =?utf-8?B?OGtjdGVxemFrN0NlTHFabjZYSG1kVFpKTjhZdGJ1ZWxyanVLSlZxTFZ1dmhC?=
 =?utf-8?B?SXl4OVJwM0xqUHI1U2hCaCtabWtyN3FHL1JrT2J2U2l6amtJdFdtZnEwK2p0?=
 =?utf-8?B?bUFuZ0Y1bVkzZlArM3p4Q3VSa09CVDdadWlPU1hwTVRrbXVpUWR2MkhFeVhM?=
 =?utf-8?B?NVEyWVlQSGVjMWFHaW5QQjZscjJ5bW9lcHUxVkN3Y2VReUpuN3Jwbm9oYjdh?=
 =?utf-8?B?YUxIWTBTZ1E3M0FVWWRjWm4zbktLajZBSWlQZWd5eVcrZjdoUjU1a2RwVDg4?=
 =?utf-8?B?ZmZuOGdiNFU1b3VUVHJyVXlUMlgxMkZZRjBCWGkyTERLNzNxU0tzZjFaU0xW?=
 =?utf-8?B?WmxiQTRXRitzQ1NMUUVXc09FQjZhTGNKNnJJMElmTjJzOE90bzB2aFBoZjVI?=
 =?utf-8?B?YVRPZnRKVDdkS2h4Wi9zNUtSV0VzcnZiQUU1YTBDc1FqN2g0REFIWWxXT0xW?=
 =?utf-8?Q?60PtI37hYClM/krufJ3maLz4Y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82042873-aadf-4a5f-2cfb-08de13391462
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7142.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 20:08:21.1368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9kNm1npN9o04otmVxp9cD+oznh8ryCXDlCrijclymdPTDxwcbEInduWRS5oXoffACtqLvKnrOaykrtFdy4CrKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8781

Hi Alison,

Thanks for the pointers and the branch. Here’s where I landed on the 
three items. Responses inline.

On 10/20/2025 5:06 PM, Alison Schofield wrote:
> On Tue, Oct 14, 2025 at 10:52:20AM -0700, Koralahalli Channabasappa, Smita wrote:
>> Hi Alison,
>>
>> On 10/10/2025 1:49 PM, Alison Schofield wrote:
>>> On Mon, Oct 06, 2025 at 06:16:24PM -0700, Alison Schofield wrote:
>>>> On Tue, Sep 30, 2025 at 04:47:52AM +0000, Smita Koralahalli wrote:
>>>>> This series aims to address long-standing conflicts between dax_hmem and
>>>>> CXL when handling Soft Reserved memory ranges.
>>>>
>>>> Hi Smita,
>>>>
>>>> Thanks for the updates Smita!
>>>>
>>>> About those "long-standing conflicts": In the next rev, can you resurrect,
>>>> or recreate the issues list that this set is addressing. It's been a
>>>> long and winding road with several handoffs (me included) and it'll help
>>>> keep the focus.
>>>>
>>>> Hotplug works :)  Auto region comes up, we tear it down and can recreate it,
>>>> in place, because the soft reserved resource is gone (no longer occupying
>>>> the CXL Window and causing recreate to fail.)
>>>>
>>>> !CONFIG_CXL_REGION works :) All resources go directly to DAX.
>>>>
>>>> The scenario that is failing is handoff to DAX after region assembly
>>>> failure. (Dan reminded me to check that today.) That is mostly related
>>>> to Patch4, so I'll respond there.
>>>>
>>>> --Alison
>>>
>>> Hi Smita -
>>>
>>> (after off-list chat w Smita about what is and is not included)
>>>
>>> This CXL failover to DAX case is not implemented. In my response in Patch 4,
>>> I cobbled something together that made it work in one test case. But to be
>>> clear, there was some trickery in the CXL region driver to even do that.
>>>
>>> One path forward is to update this set restating the issues it addresses, and
>>> remove any code and comments that are tied to failing over to DAX after a
>>> region assembly failure.
>>>
>>> That leaves the issue Dan raised, "shutdown CXL in favor of vanilla DAX devices
>>> as an emergency fallback for platform configuration quirks and bugs"[1], for a
>>> future patch.
>>>
>>> -- Alison
>>>
>>> [1] The failover to DAX was last described in response to v5 of the 'prior' patchset.
>>> https://lore.kernel.org/linux-cxl/20250715180407.47426-1-Smita.KoralahalliChannabasappa@amd.com/
>>> https://lore.kernel.org/linux-cxl/687ffcc0ee1c8_137e6b100ed@dwillia2-xfh.jf.intel.com.notmuch/
>>> https://lore.kernel.org/linux-cxl/68808fb4e4cbf_137e6b100cc@dwillia2-xfh.jf.intel.com.notmuch/
>>
>> [+cc Nathan, Terry]
>>
>>  From the AMD side, our primary concern in this series is CXL hotplug. With
>> the patches as is, the hotplug flows are working for us: region comes up, we
>> can tear it down, and recreate it in place because the soft reserved window
>> is released.
>>
>> On our systems I consistently see wait_for_device_probe() block until region
>> assembly has completed so I don’t currently have evidence of a sequencing
>> hole there on AMD platforms.
>>
>> Once CXL windows are discovered, would it be acceptable for dax_hmem to
>> simply ignore soft reserved ranges inside those windows, assuming CXL will
>> own and manage them? That aligns with Dan’s guidance about letting CXL win
>> those ranges when present.
>> https://lore.kernel.org/all/687fef9ec0dd9_137e6b100c8@dwillia2-xfh.jf.intel.com.notmuch/
>>
>> If that approach sounds right, I can reword the commit descriptions in
>> patches 4/5 and 5/5 to drop the parts about region assembly failures and
>> remove the REGISTER enum.
>>
>> And then leave the “shutdown CXL in favor of vanilla DAX as an emergency
>> fallback for platform configuration quirks and bugs” to a future, dedicated
>> patch.
>>
>> Thanks
>> Smita
> 
> Hi Smita,
> 
> I was able to discard the big sleep after picking up the patch "cxl/mem:
> Arrange for always-synchronous memdev attach" from Alejandro's Type2 set.
> 
> With that patch, all CXL probing completed before the HMEM probe so the
> deferred waiting mechanism of the HMEM driver seems unnecessary. Please
> take a look.
> 
> That patch, is one of four in this branch Dan provided:
> https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/log/?h=for-6.18/cxl-probe-order
> 
> After chats with Dan and DaveJ, we thought the Soft Reserved set was the
> right place to introduce these probe order patches (let Type 2 follow).
> So, the SR set adds these three patches:
> 
> - **cxl/mem: Arrange for always-synchronous memdev attach**
> - cxl/port: Arrange for always synchronous endpoint attach
> - cxl/mem: Introduce a memdev creation ->probe() operation
> 
> **I actually grabbed this one from v19 Type2 set, not the CXL branch,
> so you may need to see if Alejandro changed anything in that one.
> 
> When picking those up, there's a bit of wordsmithing to do in the
> commit logs. Probably replace mentions of needing for accelerators
> with needing for synchronizing the usage of soft-reserved resources.
> 
> Note that the HMEM driver is also not picking up unused SR ranges.
> That was described in review comments here:
> https://lore.kernel.org/linux-cxl/aORscMprmQyGlohw@aschofie-mobl2.lan
> 
> Summarized for my benefit ;)
> - pick up all the probe order patches,
> - determine whether the HMEM deferral is needed, maybe drop it,
> - register the unused SR, don't drop based on intersect w 'CXL Window'
> 
> With all that, nothing would be left undone in the HMEM driver. The region
> driver would still need to fail gracefully and release resources in a
> follow-on patch.
> 
> Let me know what you find wrt the timing, ie is the wait_for_device_probe()
> needed at all?
> 
> Thanks!
> -- Alison
> 

1. Pick up all the probe order patches
I pulled in the three patches you listed.
They build and run fine here.

2. Determine whether HMEM deferral is needed (and maybe drop it)
On my system, even with those three patches, the HMEM probe still races 
ahead of CXL region assembly. A short dmesg timeline shows HMEM 
registering before init_hdm_decoder() and region construction:

..
[   26.597369] hmem_register_device: hmem_platform hmem_platform.0: 
registering released/unclaimed range with DAX: [mem 
0x850000000-0x284fffffff flags 0x80000200]
[   26.602371] init_hdm_decoder: cxl_port port1: decoder1.0: range: 
0x850000000-0x284fffffff iw: 1 ig: 256
[   26.628614] init_hdm_decoder: cxl_port endpoint7: decoder7.0: range: 
0x850000000-0x284fffffff iw: 1 ig: 256
[   26.628711] __construct_region: cxl_pci 0000:e1:00.0: 
mem2:decoder7.0: __construct_region region0 res: [mem 
0x850000000-0x284fffffff flags 0x200] iw: 1 ig: 256
[   26.628714] cxl_calc_interleave_pos: cxl_mem mem2: decoder:decoder7.0 
parent:0000:e1:00.0 port:endpoint7 range:0x850000000-0x284fffffff pos:0
[   44.022792] __hmem_register_resource: hmem range [mem 
0x850000000-0x284fffffff flags 0x80000200] already active
[   49.991221] kmem dax0.0: mapping0: 0x850000000-0x284fffffff could not 
reserve region
..

As, region assembly still completes after HMEM on my platform, 
wait_for_device_probe() might be needed to avoid HMEM claiming ranges 
before CXL region assembly.

3. Register unused SR, don’t drop based on intersect with “CXL Window”
Agree with your review note: checking region_intersects(..., 
IORES_DESC_CXL) is not reliable for 'CXL owns this'. IORES_DESC_CXL 
marks just the 'CXL Windows' so the intersect test is true regardless of 
whether a region was actually assembled.

I tried the insert SR and rely on -EBUSY approach suggested.

https://lore.kernel.org/linux-cxl/aORscMprmQyGlohw@aschofie-mobl2.lan/#t

On my setup it never returns -EBUSY, the SR inserts cleanly even when 
the CXL region has already been assembled successfully before dax_hmem.

insert_resource() is treating 'fully contains' as a valid hierarchy, not 
a conflict. The SR I insert covers exactly the same range as the CXL 
window/region. In that situation, insert_resource(&iomem_resource, SR) 
does not report a conflict, instead, it inserts SR and reparents the 
existing CXL window/region under SR. That matches what I see in the tree:

850000000-284fffffff : Soft Reserved
   850000000-284fffffff : CXL Window 0
     850000000-284fffffff : region0
       850000000-284fffffff : dax0.0
         850000000-284fffffff : System RAM (kmem)
... (same for the other windows)

So there is no overlap error to trigger -EBUSY, the tree is simply 
restructured.

insert_resource_conflict() is also behaving the same.

and hence the kmem failure
kmem dax6.0: mapping0: 0x850000000-0x284fffffff could not reserve region
kmem dax6.0: probe with driver kmem failed with error -16

walk_iomem_res_desc() was also not a good discriminator here: it passes 
a temporary struct resource to the callback (name == NULL, no 
child/sibling links), so I couldn't reliably detect the 'region under 
window' relationship from that walker alone. (only CXL windows were 
discovered properly).

Below worked for me instead. I could see the region assembly success and 
failure cases handled properly.

Walk the real iomem_resource tree: find the enclosing CXL window for the 
SR range, then check if there’s a region child that covers sr->start, 
sr->end.

If yes, drop (CXL owns it).

If no, register as unused SR with DAX.


+static struct resource *cxl_window_exists(resource_size_t start,
+                                        resource_size_t end)
+{
+       struct resource *r;
+
+       for (r = iomem_resource.child; r; r = r->sibling) {
+               if (r->desc == IORES_DESC_CXL &&
+                   r->start == start && r->end == end)
+                       return r;
+       }
+
+       return NULL;
+}
+
+static bool cxl_region_exists(resource_size_t start, resource_size_t end)
+{
+       const struct resource *res, *child;
+
+       res = cxl_window_exists(start, end);
+       if (!res)
+               return false;
+
+       for (child = res->child; child; child = child->sibling) {
+               if (child->start <= start && child->end <= end)
+                       return true;
+       }
+
+       return false;
+}
+
  static int handle_deferred_cxl(struct device *host, int target_nid,
                                const struct resource *res)
  {
-       /* TODO: Handle region assembly failures */
+       if (region_intersects(res->start, resource_size(res), 
IORESOURCE_MEM,
+                             IORES_DESC_CXL) != REGION_DISJOINT) {
+
+               if (cxl_region_exists(res->start, res->end)) {
+                       dax_cxl_mode = DAX_CXL_MODE_DROP;
+                       dev_dbg(host, "dropping CXL range: %pr\n", res);
+               }
+               else {
+                       dax_cxl_mode = DAX_CXL_MODE_REGISTER;
+                       dev_dbg(host, "registering CXL range: %pr\n", res);
+               }
+
+               hmem_register_device(host, target_nid, res);
+       }
+
         return 0;
  }

static void process_defer_work(struct work_struct *_work)
{
         struct dax_defer_work *work = container_of(_work, 
typeof(*work), work);
         struct platform_device *pdev = work->pdev;

         /* relies on cxl_acpi and cxl_pci having had a chance to load */
         wait_for_device_probe();

         walk_hmem_resources(&pdev->dev, handle_deferred_cxl);
}

For region assembly failure (Thanks for the patch to test this!):

hmem_register_device: hmem_platform hmem_platform.0: deferring range to 
CXL: [mem 0x850000000-0x284fffffff flags 0x80000200]
handle_deferred_cxl: hmem_platform hmem_platform.0: registering CXL 
range: [mem 0x850000000-0x284fffffff flags 0x80000200]
hmem_register_device: hmem_platform hmem_platform.0: registering CXL 
range: [mem 0x850000000-0x284fffffff flags 0x80000200]

For region assembly success:

hmem_register_device: hmem_platform hmem_platform.0: deferring range to 
CXL: [mem 0x850000000-0x284fffffff flags 0x80000200]
handle_deferred_cxl: hmem_platform hmem_platform.0: dropping CXL range: 
[mem 0x850000000-0x284fffffff flags 0x80000200]
hmem_register_device: hmem_platform hmem_platform.0: dropping CXL range: 
[mem 0x850000000-0x284fffffff flags 0x80000200]

Happy to fold this into v4 if it looks good.

Thanks
Smita
> 
>>
>>>
>>>>
>>>>
>>


