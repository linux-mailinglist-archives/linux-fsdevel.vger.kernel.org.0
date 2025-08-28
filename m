Return-Path: <linux-fsdevel+bounces-59595-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 389E4B3AE67
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 01:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C98703A5D84
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 23:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C54E2D59E8;
	Thu, 28 Aug 2025 23:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="D2JjEjJt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2056.outbound.protection.outlook.com [40.107.100.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F937082D;
	Thu, 28 Aug 2025 23:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756423322; cv=fail; b=dtwc4ZnOlsaBLY642vSes1mqFv76+SbZRn6r9MbUfiFbxaNrYlJy8Bp4YhvUL8G8Xh5KiV0CLcamjPPmrOAUVBP0vnnPq5lPUIZyfzJaf7TfsmqFmjwZ/YRO3BH+7bsWSBqXMZ9hYhegnYiwp+V+3BnlMc/p55w8Vy756trdiz4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756423322; c=relaxed/simple;
	bh=Mu/AtxMqIIrsF5tNwjDZf2ZhBFrZmdYOMv2jFqhjbQw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=f1nxZgb6rEJ/BOaK8EK8sWqS5gz76ncvpD1vSeklj8GuN+mlse9MVQ8rs54210KIzXb30eTi0VkjACI6/suADmHdRLAUfJpnsLWal3q0N4n8l+6FCVSSZDe5oinLeb6HFGfIP3qC6DvovvYdxfNFRWF38/hvcVmuzKgsfF+QRck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=D2JjEjJt; arc=fail smtp.client-ip=40.107.100.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iCezLI5ukzGJDHkI3Cf24SiR1mv19g3LRnSESK2vYbgnJuKIEnNq7f+SdmroEfZnboYbXhLHmjTOsCZmMRhEkgcrxtvwJKvCb4ntODAT0sFlabwiHCpT5GkTIfkY16R2UH8FlIvdBzD4IY8KhxDsY8RItamrK0FYpp8kGNVuqbtkav6S+ZWd4z1LK4OuEnzBTrMgOM0NuQZepSqEL4/9bLyDwDTf7oRbz+n2r5NTSAscssQLfH7HPk+MFeEEuIf9VETMUqTrTCkUwmFQYPzDlqAnqwKX6NDWs5YusZD3TzKPUTEbZeLDkkAoxl7JxNf00yGaSHDdACMpLWn/O5yJew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=49MDLf3OS6fC2bhh5S5hdRU3IIXnzJvulArvU+EpOfo=;
 b=o5JsJYbus5XsLbXmD0XVOvYa0FRlnNgPdHYtMY3lpRcswPXNzSPyuA8skxwHTwWfdK4iBozqDFX7e+1cMMCX7hhxDaApyLuimjILoa4jr0Qy9nlxMDEGzWeUZ4oA089B+6GqLjVVKmhc3AjrRfQqQcfwF0kZD+PvNbUBRQOWJK1iCS3GVfJwqrcC8uRvbepCl60Ezm7O5bwDy8jGPhspCG+bzggRHVGwB8vXJb9CRJ5tYsckk9VYhODGO4gYPm3b576PuDr3YkAGHmNMNkeUlYfsmiYvsUY1ydE2SovrCMZqaNznPQWCdrjXkvTfffnFRObhc5WVqUuNSKc+2NHd1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=49MDLf3OS6fC2bhh5S5hdRU3IIXnzJvulArvU+EpOfo=;
 b=D2JjEjJtV5tKZVh+j0k/yIZ4rV2/DPyglmkau8XcgG1YDfvWyS+YZAbl7Q1+LEsJXEZ35adTMJByKuUIlhwtOZoJwGJH5AwSlJDQWzGxh6tjBOmmPchHmFyUfUWGKVyTXDc3VwtfLavllJ04SiNwIz7GKzmSntQ74Rn1ZTzOVOA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB7142.namprd12.prod.outlook.com (2603:10b6:303:220::6)
 by PH0PR12MB8774.namprd12.prod.outlook.com (2603:10b6:510:28e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Thu, 28 Aug
 2025 23:21:57 +0000
Received: from MW4PR12MB7142.namprd12.prod.outlook.com
 ([fe80::e5b2:cd7c:ba7d:4be3]) by MW4PR12MB7142.namprd12.prod.outlook.com
 ([fe80::e5b2:cd7c:ba7d:4be3%3]) with mapi id 15.20.9052.014; Thu, 28 Aug 2025
 23:21:57 +0000
Message-ID: <a2e900b0-1b89-4e88-a6d4-8c0e6de50f52@amd.com>
Date: Thu, 28 Aug 2025 16:21:54 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/7] cxl/acpi: Add background worker to coordinate with
 cxl_mem probe completion
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
 Alison Schofield <alison.schofield@intel.com>
Cc: "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>, Matthew Wilcox <willy@infradead.org>,
 Jan Kara <jack@suse.cz>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Len Brown <len.brown@intel.com>, Pavel Machek <pavel@kernel.org>,
 Li Ming <ming.li@zohomail.com>, Jeff Johnson
 <jeff.johnson@oss.qualcomm.com>, Ying Huang <huang.ying.caritas@gmail.com>,
 "Xingtao Yao (Fujitsu)" <yaoxt.fnst@fujitsu.com>,
 Peter Zijlstra <peterz@infradead.org>, Greg KH <gregkh@linuxfoundation.org>,
 Nathan Fontenot <nathan.fontenot@amd.com>,
 Terry Bowman <terry.bowman@amd.com>, Robert Richter <rrichter@amd.com>,
 Benjamin Cheatham <benjamin.cheatham@amd.com>,
 PradeepVineshReddy Kodamati <PradeepVineshReddy.Kodamati@amd.com>,
 "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>
References: <20250715180407.47426-1-Smita.KoralahalliChannabasappa@amd.com>
 <20250715180407.47426-4-Smita.KoralahalliChannabasappa@amd.com>
 <68808fb4e4cbf_137e6b100cc@dwillia2-xfh.jf.intel.com.notmuch>
 <68810a42ec985_1196810094@dwillia2-mobl4.notmuch>
 <01956e38-5dc7-45f3-8c56-e98c9b8a3b5c@fujitsu.com>
 <aKZW5exydL4G37gk@aschofie-mobl2.lan>
 <8293a3bb-9a82-48d3-a011-bbab4e15a5b8@fujitsu.com>
 <42fc9fa9-3fbb-48f1-9579-7b95e1096a3b@amd.com>
 <67e6d058-7487-42ec-b5e4-932cb4c3893c@fujitsu.com>
 <46b8e026-78c5-46de-97b7-074c1e75fd08@fujitsu.com>
Content-Language: en-US
From: "Koralahalli Channabasappa, Smita"
 <Smita.KoralahalliChannabasappa@amd.com>
In-Reply-To: <46b8e026-78c5-46de-97b7-074c1e75fd08@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0262.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::27) To MW4PR12MB7142.namprd12.prod.outlook.com
 (2603:10b6:303:220::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7142:EE_|PH0PR12MB8774:EE_
X-MS-Office365-Filtering-Correlation-Id: b61ad5e8-629b-47d8-bbd9-08dde689ae93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y2V6OVRlSVZ2SVVhWWdla1VCTDFrNk92MlgwakFSVmU5Uk5vL2tTSmR5MDVQ?=
 =?utf-8?B?VzIrTHBNY0Yyb1BqT2xlbVJ3dGRjbkJ0ZGNhWGlBeWppRGlwK3JxQ0Zsc1A5?=
 =?utf-8?B?OVVHRitRRVdyZVh1WWphM2JqVVJjdEpEVU9TMitQblBGZkpscjYvbXlHRTR3?=
 =?utf-8?B?Z0FFa3ZGSWl1ZFR3U09taHpOanUxUXpBdk9yZFAwOGg0b2NUTXJLR1g4TXFE?=
 =?utf-8?B?bnhCZVNSd1EwallScm5GWnhWZGl3UTdOMjdCZ2I4UzJsWWU2VzJnNVAvdk9a?=
 =?utf-8?B?dTREQzhGbk5nRlErV2EwWUc4UE5LYnBWYVFnL21zYUVjYlkzMFk0MWRYZnZM?=
 =?utf-8?B?b0I1b3lRMElIdFZ5Z1BIajV6Z1RlK29HMU9kNzFRUHdMTHpZdytwdmR1MG5F?=
 =?utf-8?B?RmVWZFIrN2tBc29vd1MzL3dYZTBxSWtNcTFFZm1wK0d5RGNaT2crVmxWSFo1?=
 =?utf-8?B?aXRmdFU1Z1Vtd0o0THBwQ0N1MGhlVTRpYWlOZEU4ZXZBTy9kdzhOZGRkWEN1?=
 =?utf-8?B?SExoUXowcmVlWmZRL3RpcitVeGQ2eUdmSFNGeUhpMXZqcXZrZWJUT3BrUWNl?=
 =?utf-8?B?TVJyYVBKVWtPdUwzV3Nhai9BQUIxQno1NGZBaWtZampxVDF0RmNxSmR1K3ZO?=
 =?utf-8?B?Q0llY2VDMENucDh3d1NnNjRkc1l2cGcrOU85N3l2YXdFemlNUG5qaTk1U1Fk?=
 =?utf-8?B?K1N5OG44MWw1bEh3aXdEbVliMUlHKy9ZVG9JcHBZeSs2ZUI2SXhKanA1WFR5?=
 =?utf-8?B?ODY4L3pTSmhscFJDNnFFRHFKSUM5V3BOYUViSlZ6WTFWQm9ob0JFSkZmZGo1?=
 =?utf-8?B?YjBUTFlIdUFXZ0l4TWdLTk5jLzRtUGc3N0ViNWhXL2tna3IrSHM3dVNndUJm?=
 =?utf-8?B?S2pheFhsTFJ4SkJUSG5hSGwvWVp3bUx0MDhoRldycUY2QzYyY1RhUzhFMUdK?=
 =?utf-8?B?ZUJiRjBjSG1aajZuNXRrM2xiSElFU0VkeHhoNGUzaHJHSm5aRElTVDBYOXE1?=
 =?utf-8?B?NU0xNHg1aTAxbVNiRDlzd0NNUlVKZzJQakdvVXRzallPZmgwWUFQUkE3RVdQ?=
 =?utf-8?B?VzJVMEQxanVYZGZLS0kxck9DWkQwNU1lMHlZYWtZNGxZQ2lNbXRqUk9aQVU0?=
 =?utf-8?B?Nk1kbGNWTEF3cE1kQVIzV0VCYklSMWl5bWhIY0NUTnFKbWpacCs2MURTa3Ex?=
 =?utf-8?B?N1VuWEVXUm5jSXlVbEJDS3VIWnZjd0dzU00xay9lOVAycktDbzZGRHg1ay9a?=
 =?utf-8?B?dzIvRi83RG9jK1JOSDhxVllKWXlKQWtURmlEZC9GaUptdVF3bGRoLzY0b0Vw?=
 =?utf-8?B?elEvNEJTSUVvRHB1eVlOR21ldU12ZFhBTkFmalBYOVhuRnA2Vlk5K0dXa2Zs?=
 =?utf-8?B?SmdOMmIvZzVNM2ZIWHVUa2gxb3Z5a3EwOGZNeVRZUUpaUjlkeGRRc09tTDM5?=
 =?utf-8?B?VWE0YUdyRDR1UHNZRHFmRFNVckhtQm9VQ0t5bnA0WWtPK2plc2FiQ1V6VGVI?=
 =?utf-8?B?eExkanA1ZHdlNyt1bys1TWs1RnFGMXlabjJ1MlplSHk2NUN0R0NJRVdkbmJN?=
 =?utf-8?B?SkVqSE9SZm1hRVpFeHhLVEUxR285U1RSdnpIdnFZUEtiMUlIV1B5Z3dlUXRa?=
 =?utf-8?B?a2RGdHFzc2xwUUVqaHQrOHdiOE1Hc3JpeTdLazRsMGFPMEpnSkFXUXdSamxC?=
 =?utf-8?B?QzdXaHM4aGNYbmg4QkpPai9pK1I2Q2lPWDA2ZWdxNHovVlZ2dE9kUkNCaHlN?=
 =?utf-8?B?Z3l6SjdVOGNUMFU5b2h2K1YrdWY2WC9MdzR2RGlUMndsOHdoV3FaaVhNaTFP?=
 =?utf-8?B?TGVzamNCVW5NcWdEWkV6UzRJalJZUG1yVlJNc3NlNUFBcWNqbnhIdWszL0wv?=
 =?utf-8?B?dFhkSGRHQUtQZlFoMFB6aGNDRDVyNXNjYTFXWWtYTnZrMzNmYThNQkhKbXFu?=
 =?utf-8?Q?/rVeGbK9igU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7142.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S3ZQKzBaV1RWWXhJODk5VlJ4bU9tMFJCMHVBY0tWREQ1Um9SaFNLNWp1WGl1?=
 =?utf-8?B?NStacDVLVjhWZHdLSld4WXhVZDhaSzZRNWowWEUzRG9STlRjSmhNZ1FpRzgw?=
 =?utf-8?B?Rm8xSVBaODVQaTIwczM4V0pkWURIOFdPTUFlN3hSaFExUjRhaFprNENnRmFm?=
 =?utf-8?B?OElFVGlTcWJ5Rm52NXpJSUpQQmlDRklUMHZTWWlNUmZuUXNEWVk0ZHV2V3dp?=
 =?utf-8?B?TmlRbEU4N0RJSnNOK3FGaGFVbTFSKzlJTXgzdGxvb1lpZndtd1NtWUNDY3BF?=
 =?utf-8?B?MVdYM0Rab1pqUDJOK21EZlNrNk9laDROc213OVNKM0cvVmx1MjR4SXA5WUpC?=
 =?utf-8?B?Z0RiZjJXdEozaUIzdTJrRElua1FCcFIyRW81N0dIV1lrRmNTTFJ5cGxGYmxN?=
 =?utf-8?B?RmZsQTF4aExwOW1KaEN3NWRFOEhURUxzNzJjTWozSEpZR2JONVRpUThEc2lZ?=
 =?utf-8?B?UGE4d1c1TS85UCtiWkNhWXNuS0RITk5SZlQycUFHY05CRlpvZ083dUFFSzM2?=
 =?utf-8?B?d01RcVl4SXVmVW9aVlEyUXNpd2FLRDBwMUdlWGdHT2l0R2UxejZQdGk2Z1FN?=
 =?utf-8?B?WTFScm1peEJRaElDSmtDWWhvNHJtc1VMc1hIVmxXRk1tM3RUU1ljalIrMWNJ?=
 =?utf-8?B?Z1Q5Z3JjTmluajJpb2dCMDlIS1BPNEZ5OFYrTTJpRlBxbEo1ZGQ5WVBNaTY1?=
 =?utf-8?B?QVByNm9OMDNCbzhJaVhhVHB2RDNWTEM2VlRmV3hHSEdxZ09yc2pCSXpoYjFy?=
 =?utf-8?B?YkEzdVpBdjUvVDI2T1Z0K2Q5em4yTi82OFAwVjRDTW91S1JZUVlRa2xBZFJt?=
 =?utf-8?B?YnpaYnhZd2t2dXFEWm1VQ0ZrcHhQWXozRnBZWEFNWUxjRTQ4aDJpRHhpQUVh?=
 =?utf-8?B?Uk1KMUxMWjJ3Y3cwUkFXY3llK0lmaFhUU0FmbG5ncEQzSHNKM2dFc21oYlBS?=
 =?utf-8?B?UGh6S014Q1FLejI2cmE5ZXFlU3J1dDBpWlpQNlcxWlRidUltUVg3K1ZnOGhu?=
 =?utf-8?B?Lzh6MnpYUm9iMjNkUVVpUkEvMHJyM1YzTVE1QXJwdW8yK0R5akZkK1pCbmdK?=
 =?utf-8?B?UkJNeUVUanRUamlNZDFIZmp3RW81UU90QWVlcmF2ZlIzVVljbDRzejRuMU5o?=
 =?utf-8?B?aitVNE5HaC9oZ3ZhOGpNK2VjaVlGUXM2Z0sxN2wxUjc2YlhiOFhuWVF4K1NK?=
 =?utf-8?B?NkxiTWM5L3JVNTdKRXJwb3FQRm9uUTVRbXlLR2Fqd01COE5xcS9yT2V5VFdn?=
 =?utf-8?B?REZrQm5DemJvUTcxZ0pLSnlxdXRMQmJPeG12YXI0dXFWQ2QzWkYzSzNwaTZy?=
 =?utf-8?B?SmNxZk0vOTdBbVZtdjQycHJPN0lsSTF5Ym9oNHAzWVQ2bytQcFFPT3FvM0gv?=
 =?utf-8?B?d0VEeDdySnFTeit4RHpiSEtRdUJoazk2NnVObVBrMXVBcDhDNmR6Yi9nQTY1?=
 =?utf-8?B?aEExT21TZk9wZVF6RFJTc2tvTk9IYXNZWHNYZ1pQcmg0bkNxT0w0RkxZdEZM?=
 =?utf-8?B?QjZUdjRmZlg5VkdsVHdmNmxFa0grZWpjRGxkbDRRdmxaNTgyMlp6SXA4TlNy?=
 =?utf-8?B?M0UwbzI3L0pXbmtkY2FsQzc1bHlSWG1MeVJvVktSZksvRmIydUdIZnZzaVow?=
 =?utf-8?B?cHlHRkc5cDJJcncrbTR6ZWo5T3h2Y0E0LzlpVjMxV3ZoN01ZWExlaWI5Sjlv?=
 =?utf-8?B?QjRUK2ErdjdLRXBSeC9kS0RFMU1XYmVRZ1ZRdTk5Y0ZEMGhmQytta1VxcXov?=
 =?utf-8?B?RGVLdVplU3kxU21JSzU4RlR0NFVTUVFDeldTWGxFR01zR0ZxWVpYVzIrYlJh?=
 =?utf-8?B?aGhIUUcwNGZIOTVQVytoZzA5c0VSTHZTS09FWGFwaVBralZnWG53anhhZkJ4?=
 =?utf-8?B?UmloWDd2b2xkbE1qR3FWOHoxVm02RDR3QVRtNDhJZ0pUWGFiRDJrbmxmb0Zi?=
 =?utf-8?B?VGFpNG9TYTlkalduYWt5Yk5XRUx5MlZOZ05tZEM5b2lCMmZvSDhtL2Iranlj?=
 =?utf-8?B?MmE4K0ljb3Y5UEFORmp6NEwyUkRYYVUrOTg1dXdCZ2FPUWxRaEpiMEQyKzk4?=
 =?utf-8?B?dHJPdUlUSXlXRDIzcVhiT0N5WmpOTFdPQ3plUmJSWjhXWkc2TnFpc25NVXZG?=
 =?utf-8?Q?41qHa/Thcmxu6N792D8q/R99m?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b61ad5e8-629b-47d8-bbd9-08dde689ae93
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7142.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 23:21:57.2840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vvjYlF6axhbIOvU57vj12gJR7I5Hc/z9aKTs5LnKsXvX5tzxlZWJHo/g1SDFjFV/0yOGYmONd4rJEs3IMyurXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8774

Hi Zhijian,

On 8/26/2025 11:30 PM, Zhijian Li (Fujitsu) wrote:
> All,
> 
> 
> I have confirmed that in the !CXL_REGION configuration, the same environment may fail to fall back to hmem.(Your new patch cannot resolve this issue)
> 
> In my environment:
> - There are two CXL memory devices corresponding to:
>     ```
>     5d0000000-6cffffff : CXL Window 0
>     6d0000000-7cffffff : CXL Window 1
>     ```
> - E820 table contains a 'soft reserved' entry:
>     ```
>     [    0.000000] BIOS-e820: [mem 0x00000005d0000000-0x00000007cfffffff] soft reserved
>     ```
> 
> However, since my ACPI SRAT doesn't describe the CXL memory devices (the point), `acpi/hmat.c` won't allocate memory targets for them. This prevents the call chain:
> ```c
> hmat_register_target_devices() // for each SRAT-described target
>     -> hmem_register_resource()
>       -> insert entry into "HMEM devices" resource
> ```
> 
> Therefore, for successful fallback to hmem in this environment: `dax_hmem.ko` and `kmem.ko` must request resources BEFORE `cxl_acpi.ko` inserts 'CXL Window X'
> 
> However the kernel cannot guarantee this initialization order.
> 
> When cxl_acpi runs before dax_kmem/kmem:
> ```
> (built-in)                 CXL_REGION=n
> driver/dax/hmem/device.c  cxl_acpi.ko      dax_hmem.ko               kmem.ko
> 
> (1) Add entry '15d0000000-7cfffffff'
>                                            (2) Traverse "HMEM devices"
>                                                Insert to iomem:
>                                                5d0000000-7cffffff : Soft Reserved
> 
>                        (3) Insert CXL Window 0/1
>                            /proc/iomem shows:
>                            5d0000000-7cffffff : Soft Reserved
>                              5d0000000-6cffffff : CXL Window 0
>                              6d0000000-7cffffff : CXL Window 1
> 
>                                           (4) Create dax device
>                                                                   (5) request_mem_region() fails
>                                                                     for 5d0000000-7cffffff
>                                                                     Reason: Children of 'Soft Reserved'
>                                                                     (CXL Windows 0/1) don't cover full range
> ```
> 

Thanks for confirming the failure point. I was thinking of two possible 
ways forward here, and I would like to get feedback from others:

[1] Teach dax_hmem to split when the parent claim fails:
If __request_region() fails for the top-level Soft Reserved range 
because IORES_DESC_CXL children already exist, dax_hmem could iterate 
those windows and register each one individually. The downside is that 
it adds some complexity and feels a bit like papering over the fact that 
CXL should eventually own all of this memory. As Dan mentioned, the 
long-term plan is for Linux to not need the soft-reserve fallback at 
all, and simply ignore Soft Reserve for CXL Windows because the CXL 
subsystem will handle it.

[2] Always unconditionally load CXL early..
Call request_module("cxl_acpi"); request_module("cxl_pci"); from 
dax_hmem_init() (without the IS_ENABLED(CONFIG_DEV_DAX_CXL) guard). If 
those are y/m, they’ll be present; if n, it’s a no-op. Then in 
hmem_register_device() drop the IS_ENABLED(CONFIG_DEV_DAX_CXL) gate and do:

if (region_intersects(res->start, resource_size(res),
                       IORESOURCE_MEM, IORES_DESC_CXL) !=REGION_DISJOINT)
	/* defer to CXL */;

and defer to CXL if windows are present. This makes Soft Reserved 
unavailable once CXL Windows have been discovered, even if CXL_REGION is 
disabled. That aligns better with the idea that “CXL should win” 
whenever a window is visible (This also needs to be considered alongside 
patch 6/6 in my series.)

With CXL_REGION=n there would be no devdax and no kmem for that range; 
proc/iomem would show only the windows something like below

850000000-284fffffff : CXL Window 0
2850000000-484fffffff : CXL Window 1
4850000000-684fffffff : CXL Window 2

That means the memory is left unclaimed/unavailable.. (no System RAM, no 
/dev/dax). Is that acceptable when CXL_REGION is disabled?

Thanks
Smita
> ---------------------
> In my another environment where ACPI SRAT has separate entries per CXL device:
> 1. `acpi/hmat.c` inserts two entries into "HMEM devices":
>      - 5d0000000-6cffffff
>      - 6d0000000-7cffffff
> 
> 2. Regardless of module order, dax/kmem requests per-device resources, resulting in:
>      ```
>      5d0000000-7cffffff : Soft Reserved
>          5d0000000-6cffffff : CXL Window 0
>              5d0000000-6cffffff : dax0.0
>                  5d0000000-6cffffff : System RAM (kmem)
>          6d0000000-7cffffff : CXL Window 1
>              6d0000000-7cffffff : dax1.0
>                  6d0000000-7cffffff : System RAM (kmem)
>      ```
> 
> Thanks,
> Zhijian
> 
> 
> On 25/08/2025 15:50, Li Zhijian wrote:
>>
>>
>> On 22/08/2025 11:56, Koralahalli Channabasappa, Smita wrote:
>>>>
>>>>>
>>>>>>        ```
>>>>>>
>>>>>> 3. When CXL_REGION is disabled, there is a failure to fallback to dax_hmem, in which case only CXL Window X is visible.
>>>>>
>>>>> Haven't tested !CXL_REGION yet.
>>>
>>> When CXL_REGION is disabled, DEV_DAX_CXL will also be disabled. So dax_hmem should handle it.
>>
>> Yes, falling back to dax_hmem/kmem is the result we expect.
>> I haven't figured out the root cause of the issue yet, but I can tell you that in my QEMU environment,
>> there is currently a certain probability that it cannot fall back to dax_hmem/kmem.
>>
>> Upon its failure, I observed the following warnings and errors (with my local fixup kernel).
>> [   12.203254] kmem dax0.0: mapping0: 0x5d0000000-0x7cfffffff could not reserve region
>> [   12.203437] kmem dax0.0: probe with driver kmem failed with error -16
>>
>>
>>
>>> I was able to fallback to dax_hmem. But let me know if I'm missing something.
>>>
>>> config DEV_DAX_CXL
>>>           tristate "CXL DAX: direct access to CXL RAM regions"
>>>           depends on CXL_BUS && CXL_REGION && DEV_DAX
>>> ..
>>>
>>>>>
>>>>>>        On failure:
>>>>>>        ```
>>>>>>        100000000-27ffffff : System RAM
>>>>>>        5c0001128-5c00011b7 : port1
>>>>>>        5c0011128-5c00111b7 : port2
>>>>>>        5d0000000-6cffffff : CXL Window 0
>>>>>>        6d0000000-7cffffff : CXL Window 1
>>>>>>        7000000000-700000ffff : PCI Bus 0000:0c
>>>>>>          7000000000-700000ffff : 0000:0c:00.0
>>>>>>            7000001080-70000010d7 : mem1
>>>>>>        ```
>>>>>>
>>>>>>        On success:
>>>>>>        ```
>>>>>>        5d0000000-7cffffff : dax0.0
>>>>>>          5d0000000-7cffffff : System RAM (kmem)
>>>>>>            5d0000000-6cffffff : CXL Window 0
>>>>>>            6d0000000-7cffffff : CXL Window 1
>>>>>>        ```


