Return-Path: <linux-fsdevel+bounces-75627-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MBnjN+7teGk6uAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75627-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 17:55:10 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A0AB398095
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 17:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C0997304FE01
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 16:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865AC362157;
	Tue, 27 Jan 2026 16:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Orx8+q1r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012056.outbound.protection.outlook.com [52.101.53.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC9835EDCF;
	Tue, 27 Jan 2026 16:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769532795; cv=fail; b=FAxqjRfxY1gRIwXikpKv4aWQH/JhZFZkjKEcc3wrU0GSWtIu41REGByPCFx6ens1QtPCta7ZBwS6YBoB2a03xOQVhJ6OQpaemcsQTI9AdqVP/Gx6Q1v/Zk97J0h1R7By8AyNID9tzBG2aegMKI+ckaD48yM5A/mc+lyF6uMa9Jw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769532795; c=relaxed/simple;
	bh=p78N3EktoUYFMs0wzgoGIlZ9j9zNPgg9DGyq8bc/Wn8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tnbGxzzC9HYkBjJzKhuRSJrQ6l8ZflvPraCp+0FjmvPfhbaDRVb89fWFNPGFVMw84qM3FXMisbH8uxfj949PQ9cpDDQZkf31MQZQAYLA3Lpotn6C0zBwE+J4Ab6mVR1J3DwENdlri7Xat+rHeZabcl6APMmHQoL8C5Gyf4hagxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Orx8+q1r; arc=fail smtp.client-ip=52.101.53.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yTC8D+3NSLh0Rsn2O+NQkXu2sobOsSlvVVM+TSgU8Yjb88igywmkwsuNI7DOBOecgQxsr9632qxFYjbdNF4Ii7EwEiswaKCALg4V3mf3ice7WrNJurB0i1NG1R84pLxmymnX5ne/NhaUcPxzxttGhCbRcIIZ5CPgAb53eMEaZ/XKFUyK5PBGm22XdxNroa8ZMKsTonknyTwsYJKR5hdq24CvNHGxuNCd747d42pQdXZNYTtF9pMk2j1vUQsHjYB4VeHUYYLyz+MJkwqPQEKJmxCYD7IHTvRQJoCFwAhWL9mAeUkO2CRqg3tac9B1w62IGdYq2zkgMLRzEBVPdJ50TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZQmL01ia4AfIAz8lwa08c4foMKtWuNuOBwDCYIXxu7s=;
 b=hpRTHVg1TFljtMYx+VajsI0bZIpUcuHcpSFHxCae2uCoPTfa84kvV59vbh0dUZ7eMiAXVh4DSTl2UeGeS6X//nS+qcpYjJ6YqBc8JtME0wNLfnEDo7t+9pKHz0q7GqsuA+Iyi9igr7JqTxlYcpazfzsXk2JjWJXh5xjthdRBc4R+ym2fiFcMHshLp0tuX1p0Wbn0zlYlUBBtdBNeDVAFREBCfNeXVjUy/eQvm4yLho4Ap1S/q44YCkkYUMi6BnFDplEjw42QrZU4EDsMXbROqeWc8jnHG4nE+RLiTPfJxRuucaTWeg6nZ9+mtRtrt+t6YJjh/bnOQ2MewC7fQh9Kmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZQmL01ia4AfIAz8lwa08c4foMKtWuNuOBwDCYIXxu7s=;
 b=Orx8+q1rILMK7xDjUcjgHQHSYMxY/CYqzvGWD+VKsTKzVwqM+2e9YzDClgN/KmezdpqjQlm3pbfiWjXQ9ir/FejjiICPZ+c9y+eM7lLEwUWx8fAF+Zt68LDaqgCQuHMwP66h8Zb/V2DL3LaYX3pImfCyMmy1WLkNkFiI9wu6Kls=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by DS7PR12MB6312.namprd12.prod.outlook.com (2603:10b6:8:93::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.16; Tue, 27 Jan 2026 16:53:04 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d%4]) with mapi id 15.20.9542.010; Tue, 27 Jan 2026
 16:53:04 +0000
Message-ID: <9ff44eee-fc59-4aa1-a3f5-5ece8d1af5ed@amd.com>
Date: Tue, 27 Jan 2026 16:52:56 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/7] dax/hmem, cxl: Defer and resolve ownership of Soft
 Reserved memory ranges
To: Tomasz Wolski <Tomasz.Wolski@fujitsu.com>
Cc: Smita.KoralahalliChannabasappa@amd.com, alison.schofield@intel.com,
 ardb@kernel.org, benjamin.cheatham@amd.com, bp@alien8.de,
 dan.j.williams@intel.com, dave.jiang@intel.com, dave@stgolabs.net,
 gregkh@linuxfoundation.org, huang.ying.caritas@gmail.com,
 ira.weiny@intel.com, jack@suse.cz, jeff.johnson@oss.qualcomm.com,
 jonathan.cameron@huawei.com, len.brown@intel.com, linux-cxl@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, lizhijian@fujitsu.com, ming.li@zohomail.com,
 nathan.fontenot@amd.com, nvdimm@lists.linux.dev, pavel@kernel.org,
 peterz@infradead.org, rafael@kernel.org, rrichter@amd.com, skoralah@amd.com,
 terry.bowman@amd.com, vishal.l.verma@intel.com, willy@infradead.org,
 yaoxt.fnst@fujitsu.com, yazen.ghannam@amd.com
References: <f4bdf04d-7481-4282-b9da-ce5fcf911af9@amd.com>
 <20251001171553.31343-1-Tomasz.Wolski@fujitsu.com>
Content-Language: en-US
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20251001171553.31343-1-Tomasz.Wolski@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0180.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18a::23) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|DS7PR12MB6312:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a2070f8-1581-4f74-c281-08de5dc489ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TmF1MGtzUzlxMEhpd1p1MERwTFAxa2ROblVycUREaStiUmVCdHNuUFMvTi9F?=
 =?utf-8?B?ZENYSnY2OUFhUHVudmZPYU5kTG5TN0RRRW1ZcEM3Q1JNbGtoTm9GVU1uamZQ?=
 =?utf-8?B?QzBwYS9CTkY5MndybDZ3SWlNZ1VNa1E4Ynd2SVJrL0NMQzFRWjJCSDREZWFD?=
 =?utf-8?B?dGFSRExJZ0h3TTFTT0VDNzEvV2FVaUxxNzhVcy8weWJtRWRIb2MxQ2lweVl0?=
 =?utf-8?B?ajIrUHU5Mlc3ZWNtaDVGaTdWdGx3dERubkQrSjlYL2JCdHoxNDBCSjJJRGhT?=
 =?utf-8?B?OFQ2Z1FaQkhzbU9wbFBkczJEVjdyOUN6K25lR2IyLzZNNkt5TUo0NzdlZ0dv?=
 =?utf-8?B?N0dqQWVTZC9IRmFjV1p0N2sxNWFFc0tSUkUvdkJpa256WTV5aTAycDBvVmhL?=
 =?utf-8?B?dzN6T2RiUFpMRk5OOUU0a09vSzYvOFFoRjV1NVBoNi9HQ2wxSHhGTFpreEpy?=
 =?utf-8?B?Ukl5YUt0bTZrZWlvc1V3UDBWOGNhZm5NdkFuSmw4NHZBSnR5dlg1azNEaUxU?=
 =?utf-8?B?TmozOE5OTDBld0tIMUEvY1ptTEttR05ScHN6YnhjNXNKTmxDaTVXWG9YTEMy?=
 =?utf-8?B?Y2p5TDB3eE0wc0hlc20ySENGeWVieWhjQTBITERCOWRCWjZrNTBSc3FlVDEy?=
 =?utf-8?B?SUtzRG1QTHJ3VFgyM1RqVnB0NFVGYnZRS3Fkd3Rwbnl0WjlUU0RxVHJCandq?=
 =?utf-8?B?R2RNeFJzMU5DNDFFYlJqcTh5U241UGdWeThvcXlCMXQ5SEk0ZWJId3hjWXhz?=
 =?utf-8?B?UFMvV25NZlN5bVlIM25IaWpRc2tPbXZQcVkraS9NWFB6T1ZqeVg0TXV0REI3?=
 =?utf-8?B?V3liTnkyWkVWOHVBZWRhSHcyS1NocnlxWnNFak8yRSs4UmtIUWpxUHdpaVNx?=
 =?utf-8?B?NTVYeWEvbjFWWG9NNEg5UUxpN2FEMlFGWjFjWEtNYktVTTlLOUI1Vjd4bnlt?=
 =?utf-8?B?bno2S1FSczdLMTdEYnc2VEJuekRVc05OQ0IyaTkzRGtmVWEreUdtSEFRQlcv?=
 =?utf-8?B?MEswTkNWYjZEd2lFTkJkRDltMWEvbUJHc0RLcGttaDBCdjkvSzlHamtPL1FY?=
 =?utf-8?B?c3I5Ym5jNTI2dkhlTWsxZlF0UEdhMURLSVd5RW84UlIydkVMQ1E2TFBYa2di?=
 =?utf-8?B?aUxPenFhZS93NFpHVTd2QnRVa1NEU2tvTHpkYzFRVk9mellBU2RWZWdsaW5F?=
 =?utf-8?B?SGY0Y09sbFhtam9jYjhIa28wajlYc0hrMTVzeXlqYjZXUGJPdnFjZ3Ardk11?=
 =?utf-8?B?S2lKTStiVFFrQ25RK2NTbERteVFrbGU2TVJaTlZKWHo4R2Y0SW9TR0ZJMUJQ?=
 =?utf-8?B?RWVjMDl3ZEtGWmxCZzZKd2loVUFlZElDajFCWUorVnFKWDFsdEREaEVVa0kz?=
 =?utf-8?B?TS9oUXV4S0ZNOER4YzRjTFRpckZ5cHo2SmZ5eGVYSzBSdy9MejNyZ1I1eFFQ?=
 =?utf-8?B?TFVZNkFNNTd2MFBZbzBNTUtham8yRjR2dzFKMFZJb3gwQXJkUXVCczRaTzN1?=
 =?utf-8?B?M0ozR0MyeGhZVkRha0xjNjg0NEVKY3A3dktpSW15bEtIeVE0L1NZOStwN0oy?=
 =?utf-8?B?VVIzbnRIRFI1eUx1Wk5wdyt6UmtGbEJ4cG1TNkFIRnVJaExyVnFuUzV4VUIz?=
 =?utf-8?B?TEdxTDRPQlBYYlNzbWlYSHBFMTkycXVJaExhSHJVNHl3dVo4Sktvd2lMNG5E?=
 =?utf-8?B?Y3A0L3VjT2NIMTZMYmZhejI2WE1pSUxHZjhCU0ZNeGNaSmZ6a0FKa1NycWJF?=
 =?utf-8?B?Y2liUVplNDVoZ1pQMEFuZ29JZTFZUmMvU0dVb2todTZhNjRBTkJJdktjb1pL?=
 =?utf-8?B?TEoyMW1CdVFLbWwzZE5jdzZNZ0lETlp6YVBqdThsejhSZ2VCZ3A3MTNWR2gz?=
 =?utf-8?B?cVpzR3Bzc0xmLzdYWTlLRzFnNTNNdUxGWlFrclVtT05PTHFJWVNPaXQzYjFi?=
 =?utf-8?B?d2NMcENraktGTXowMXlZa1hHSTJZdlRiWVlUd0p4UWNETVpTcVoyVUhBRTlD?=
 =?utf-8?B?WlJscHVoZStwZHZZZUpuU2ZsdUhQVmdrQ3drSzBxT3NaYWRGQUJCdS9mVW1W?=
 =?utf-8?Q?mS5sTT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OXJnbmQ0SFVKK1dDelp2ZzNQZmRrVUdHek9tOWs2RndDTGpkWTE5dkl3NFUx?=
 =?utf-8?B?b2crMjdtc0g3cWY0RGRrZ3FsdWdoeE9pU09ZVkoyYTd1M3lrRlhBWktTeVli?=
 =?utf-8?B?QldZTXkxZ2dVK1ZZeUpzU2cxQlRZTHNuczRwNXlJdlFTdmNVZXpIVTlISVYx?=
 =?utf-8?B?QWFYV3hJQ2V6TzlaNkpZaWxuUldOTTJhaDJwVndzME5kcXhRcEN3QTNPeEJi?=
 =?utf-8?B?S0NBMlpzNmMwd0NydjR0MGdoRExQSjJRQkRkQkFXOXV0U3VaclozOXBoQ3Fw?=
 =?utf-8?B?N0ZxdVhNMzNtdDhYdEsyK0RkWVA4cVVZdHkycDNydk1JRUprMHZYVU4yMDgv?=
 =?utf-8?B?RzE3aXIzNXZNbHpSc2ROcFpjRWtJa2t2REtDWDNLdWdDTTVOclMySUFRNVc2?=
 =?utf-8?B?MEdqZTRzQ2NlLzl1TytwdWZKNHluM0NpSy9TdkJNSHVBd3hhOUJvVm5RN2g3?=
 =?utf-8?B?T0J6RFpJVHRYZnd5SGF6bm5GWkVjVzVjTjFkZWNUUWFOMXhWa2ZyZWRqZHls?=
 =?utf-8?B?SDFZSHlIVy9XbDdCbUFTVjdIQ0VsNXlydm42RWFDRWlFblhvTE53cDFYVDIz?=
 =?utf-8?B?akhGMlpBOWdBNEJBUUpWWjgyUWFkblJEb2VQTHFRczlFKytyWUxLdkxPV3Ry?=
 =?utf-8?B?Y25KWnNzM3pMR0RNVlBCOGV3RFcwV1E0QkV1NWtnSlpLL1M5emoxQktNWmUz?=
 =?utf-8?B?a2dCcEpsZTFYVlo4TzZSdytIdWhQUW85cEtKUGRsa1RZQVVlS1dQQlFvKzJL?=
 =?utf-8?B?TDNVU1d2eUNncUx6cjY3c3A1MFRHbmora2pLUGR0R3kxSHJpZVdsZEErTXZt?=
 =?utf-8?B?TWlGVURMRVBSRnF3eGY0NEgwREVEcUc4V01jNmpXdXp1Nm1SRUhDVjBrbUdk?=
 =?utf-8?B?V0Y4RE9ZVnFUcElhT1RQY3cyMWE3S2twVzl5eFRTVDZ6Q0wxenJmdWR6d0ow?=
 =?utf-8?B?VFlOcDVxR1loNDJWQWptNFBmdE5TWU9qUy9pWERrdnNaNGxjWS94eHlFeTVz?=
 =?utf-8?B?Q295L2pvQmxMYmUrM0o5ZzdIaC8yclZ2U2xzTWRFZE0xZnkydmhxMkh3bjhz?=
 =?utf-8?B?ZUFNZ2d1WXFwd2hUbGttOE1td3d0YWNOM2lwVEIwQWNzQ1JYSkJMbTd3QzBp?=
 =?utf-8?B?c3FFbktQckw5OXl0NmNwRTEwU3hxNStpcEd1dG91cldON09KZmhTSVE5VllS?=
 =?utf-8?B?aFY5VUJwMFRTSXNQd1dyMlJBaVJVUXlGbGFYclVzRU5naFVEMTF6RExDc05u?=
 =?utf-8?B?VHRKVWJtYzhXcThBMmU5SDFEUjhzMXpZUHQ4QXprbTRLRXlvQTJyRjZMcWZ0?=
 =?utf-8?B?T01nd3ZPK1NlRUhFRmltL2NLakFxYVA3dEUzTmRUZVB5TE9MZlAxNWVRczBm?=
 =?utf-8?B?RldSVVpNSHRldHZaeUlqeDVQcnNXM1RBVEtoazNGTHZJRm1pZEpRWnFlN1hz?=
 =?utf-8?B?cytWWk9jSlJWRjAyZHNZdENnV3JOUHVOazR0K3pLV3IvS1dJaGtTV1VVb0xv?=
 =?utf-8?B?TmUxdUlINmdkSzVMbnFwYlUzdTFDVXQ1RzMzdE03QWNyeEY1WmUxR1lsdlpV?=
 =?utf-8?B?cEpGMzVkVkxmNCtHMmZoWWpIS1BXVWlXMUhTUm1OMHl0QVB1eHNGZVdscFF1?=
 =?utf-8?B?RFVDUjBTTE9WTjk4UnRhelNlWUJLQWgyU21xZ3NlTzZudFZ1M244SWlaYXBs?=
 =?utf-8?B?SzNsZmxzZEE3N3lTL1cvYVRjaXJ1dU5ySUlFRjFOOVAxVXVob01Ta0plZ0dv?=
 =?utf-8?B?R0NQUTdVOTVveXhwUThCYm9GSDJleEl0SFF4dTlNdHh1ampnT1FsNjZzajF0?=
 =?utf-8?B?WHc3aEZlR0pacDFBOUwyRzF2RllKSVBjUnZSS1lpY01YVkdaWEVCWnZjYnY2?=
 =?utf-8?B?TjdKU0htd3VwQmVlM01vUlBEc1NGbUwrMmJIQ3lCN0l6UWw4dUN5VVJuQ0ht?=
 =?utf-8?B?d29vcVFJZlpGNjUvOHkzOUl2MDkxMUs0L1RQNTZZaEJuN0hnZFUzWFNUajJZ?=
 =?utf-8?B?M0JQWXI5aUpTRUNCTnc3Y1lwL2tOYXk2ajJFNFo4TXlwZm5Ja1pHeWNCdUxY?=
 =?utf-8?B?MHJ2cHo0dzJZWHUvbStmUjFKZUpDUDd0dVMzb29vTVArSmlRQTMxTG5PbklV?=
 =?utf-8?B?ZE5RQ3hsNFdSNXpKcWxWMHg3dHFXd084Y0tQUHgxOHBwU0t0NDJGYjdWaUpK?=
 =?utf-8?B?QXo0WndLK2FQUTlRblNYVlgwUm9vTm5Hb0I5b1NqNzlZYXFSM0o3YlBDcmFE?=
 =?utf-8?B?NEhNZHVYNW9OUE1jaWhSYkpaNlFScU1NRmVCNmxybmU5WDNkeW1VS3d5c09H?=
 =?utf-8?B?M2dTdGZJTXFYNHcvZE1IV2lSNkRUMHRnUmJuaXNZWHp3cjhSRjJYZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a2070f8-1581-4f74-c281-08de5dc489ab
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 16:53:04.1011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 86OE2CJkHUfJXXPf464nkIffcdoyZ8qnQfIjEya3tWKMWIUb+GKb8VNw/SkjERb89GoyfJ29m5JkvwFl7FVH5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6312
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[34];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75627-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[amd.com,intel.com,kernel.org,alien8.de,stgolabs.net,linuxfoundation.org,gmail.com,suse.cz,oss.qualcomm.com,huawei.com,vger.kernel.org,fujitsu.com,zohomail.com,lists.linux.dev,infradead.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alucerop@amd.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lpc.events:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,amd.com:mid,amd.com:dkim]
X-Rspamd-Queue-Id: A0AB398095
X-Rspamd-Action: no action


On 10/1/25 18:15, Tomasz Wolski wrote:
>>> [responding to the questions raised here before reviewing the patch...]
>>>
>>> Koralahalli Channabasappa, Smita wrote:
>>>> Hi Alejandro,
>>>>
>>>> On 1/23/2026 3:59 AM, Alejandro Lucero Palau wrote:
>>>>> On 1/22/26 04:55, Smita Koralahalli wrote:
>>>>>> The current probe time ownership check for Soft Reserved memory based
>>>>>> solely on CXL window intersection is insufficient. dax_hmem probing is
>>>>>> not
>>>>>> always guaranteed to run after CXL enumeration and region assembly, which
>>>>>> can lead to incorrect ownership decisions before the CXL stack has
>>>>>> finished publishing windows and assembling committed regions.
>>>>>>
>>>>>> Introduce deferred ownership handling for Soft Reserved ranges that
>>>>>> intersect CXL windows at probe time by scheduling deferred work from
>>>>>> dax_hmem and waiting for the CXL stack to complete enumeration and region
>>>>>> assembly before deciding ownership.
>>>>>>
>>>>>> Evaluate ownership of Soft Reserved ranges based on CXL region
>>>>>> containment.
>>>>>>
>>>>>>       - If all Soft Reserved ranges are fully contained within committed
>>>>>> CXL
>>>>>>         regions, DROP handling Soft Reserved ranges from dax_hmem and allow
>>>>>>         dax_cxl to bind.
>>>>>>
>>>>>>       - If any Soft Reserved range is not fully claimed by committed CXL
>>>>>>         region, tear down all CXL regions and REGISTER the Soft Reserved
>>>>>>         ranges with dax_hmem instead.
>>>>> I was not sure if I was understanding this properly, but after looking
>>>>> at the code I think I do ... but then I do not understand the reason
>>>>> behind. If I'm right, there could be two devices and therefore different
>>>>> soft reserved ranges, with one getting an automatic cxl region for all
>>>>> the range and the other without that, and the outcome would be the first
>>>>> one getting its region removed and added to hmem. Maybe I'm missing
>>>>> something obvious but, why? If there is a good reason, I think it should
>>>>> be documented in the commit and somewhere else.
>>>> Yeah, if I understood Dan correctly, that's exactly the intended behavior.
>>>>
>>>> I'm trying to restate the "why" behind this based on Dan's earlier
>>>> guidance. Please correct me if I'm misrepresenting it Dan.
>>>>
>>>> The policy is meant to be coarse: If all SR ranges that intersect CXL
>>>> windows are fully contained by committed CXL regions, then we have high
>>>> confidence that the platform descriptions line up and CXL owns the memory.
>>>>
>>>> If any SR range that intersects a CXL window is not fully covered by
>>>> committed regions then we treat that as unexpected platform shenanigans.
>>>> In that situation the intent is to give up on CXL entirely for those SR
>>>> ranges because partial ownership becomes ambiguous.
>>>>
>>>> This is why the fallback is global and not per range. The goal is to
>>>> leave no room for mixed some SR to CXL, some SR to HMEM configurations.
>>>> Any mismatch should push the platform issue back to the vendor to fix
>>>> the description (ideally preserving the simplifying assumption of a 1:1
>>>> correlation between CXL Regions and SR).
>>>>
>>>> Thanks for pointing this out. I will update the why in the next revision.
>>> You have it right. This is mostly a policy to save debug sanity and
>>> share the compatibility pain. You either always get everything the BIOS
>>> put into the memory map, or you get the fully enlightened CXL world.
>>>
>>> When accelerator memory enters the mix it does require an opt-in/out of
>>> this scheme. Either the device completely opts out of this HMEM fallback
>>> mechanism by marking the memory as Reserved (the dominant preference),
>>> or it arranges for CXL accelerator drivers to be present at boot if they
>>> want to interoperate with this fallback. Some folks want the fallback:
>>> https://lpc.events/event/19/contributions/2064/
>>
>> I will take a look at this presentation, but I think there could be
>> another option where accelerators information is obtained during pci
>> enumeration by the kernel and using this information by this
>> functionality skipping those ranges allocated to them. Forcing them to
>> be compiled with the kernel would go against what distributions
>> currently and widely do with initramfs. Not sure if some current "early"
>> stubs could be used for this though but the information needs to be
>> recollected before this code does the checks.
>>
>>
>>>>> I have also problems understanding the concurrency when handling the
>>>>> global dax_cxl_mode variable. It is modified inside process_defer_work()
>>>>> which I think can have different instances for different devices
>>>>> executed concurrently in different cores/workers (the system_wq used is
>>>>> not ordered). If I'm right race conditions are likely.
>>> It only works as a single queue of regions. One sync point to say "all
>>> collected regions are routed into the dax_hmem or dax_cxl bucket".
>>
>> That is how I think it should work, handling all the soft reserved
>> ranges vs regions by one code execution. But that is not the case. More
>> later.
>>
>>
>>>> Yeah, this is something I spent sometime thinking on. My rationale
>>>> behind not having it and where I'm still unsure:
>>>>
>>>> My assumption was that after wait_for_device_probe(), CXL topology
>>>> discovery and region commit are complete and stable.
>>> ...or more specifically, any CXL region discovery after that point is a
>>> typical runtime dynamic discovery event that is not subject to any
>>> deferral.
>>>
>>>> And each deferred worker should observe the same CXL state and
>>>> therefore compute the same final policy (either DROP or REGISTER).
>>> The expectation is one queue, one event that takes the rwsem and
>>> dispositions all present regions relative to initial soft-reserve memory
>>> map.
>>>
>>>> Also, I was assuming that even if multiple process_defer_work()
>>>> instances run, the operations they perform are effectively safe to
>>>> repeat.. though I'm not sure on this.
>>> I think something is wrong if the workqueue runs more than once. It is
>>> just a place to wait for initial device probe to complete and then fixup
>>> all the regions (allow dax_region registration to proceed) that were
>>> waiting for that.
>>>
>>>> cxl_region_teardown_all(): this ultimately triggers the
>>>> devm_release_action(... unregister_region ...) path. My expectation was
>>>> that these devm actions are single shot per device lifecycle, so
>>>> repeated teardown attempts should become noops.
>>> Not noops, right? The definition of a devm_action is that they always
>>> fire at device_del(). There is no facility to device_del() a device
>>> twice.
>>>
>>>> cxl_region_teardown_all() ultimately leads to cxl_decoder_detach(),
>>>> which takes "cxl_rwsem.region". That should serialize decoder detach and
>>>> region teardown.
>>>>
>>>> bus_rescan_devices(&cxl_bus_type): I assumed repeated rescans during
>>>> boot are fine as the rescan path will simply rediscover already present
>>>> devices..
>>> The rescan path likely needs some logic to give up on CXL region
>>> autodiscovery for devices that failed their memmap compatibility check.
>>>
>>>> walk_hmem_resources(.., hmem_register_device): in the DROP case,I
>>>> thought running the walk multiple times is safe because devm managed
>>>> platform devices and memregion allocations should prevent duplicate
>>>> lifetime issues.
>>>>
>>>> So, even if multiple process_defer_work() instances execute
>>>> concurrently, the CXL operations involved in containment evaluation
>>>> (cxl_region_contains_soft_reserve()) and teardown are already guarded.
>>>>
>>>> But I'm still trying to understand if bus_rescan_devices(&cxl_bus_type)
>>>> is not safe when invoked concurrently?
>>> It already races today between natural bus enumeration and the
>>> cxl_bus_rescan() call from cxl_acpi. So it needs to be ok, it is
>>> naturally synchronized by the region's device_lock and regions' rwsem.
>>>
>>>> Or is the primary issue that dax_cxl_mode is a global updated from one
>>>> context and read from others, and should be synchronized even if the
>>>> computed final value will always be the same?
>>> There is only one global hmem_platform device, so only one potential
>>> item in this workqueue.
>>
>> Well, I do not think so.
>>
>>
>> hmem_init() in drivers/dax/device.c walks IORESOURCE_MEM looking for
>> IORES_DESC_SOFT_RESERVED descriptors and calling hmem_register_one for
>> each of them. That leads to create an hmem_platform platform device (no
>> typo, just emphasizing this is a platform device with name
>> hmem_platform) so there will be as many hmem_platform devices as
>> descriptors found.
>>
>>
>> Then each hmem_platform probe() will create an hmem platform device,
>> where a work will be schedule passing this specific hmem platform device
>> as argument. So, each work will check for the specific ranges of its own
>> pdev and not all of them. The check can result in a different value
>> assigned to dax_cxl_mode leading to potential race conditions with
>> concurrent workers and also potentially leaving soft reserved ranges
>> without both, a dax or an hmem device.
> Hi Alejandro,
>
> Isn't below  check in __hmem_register_resource ensuring that only one
> hmem_platform device can be created? So first resource would
> create platform device and set the platform_initialized bool to true
>
> static void __hmem_register_resource(int target_nid, struct resource *res)
> ..
> 	if (platform_initialized)
> 		return;
> ..


Upps. Silly me. So focused on platform_device_alloc() ...


So, the concurrency problem when updating dax_cxl_mode does not exist as 
all potential concurrent workers use the hmem_platform device, but I 
think, or maybe I'm having a really bad day, the hmem devices are 
"indeed" created based on those soft reserved ranges when walking 
hmem_active ... the work is schedule as many times as hmem devices, and 
maybe there could be a problem with concurrent works invoking 
cxl_region_teardown_all().


Anyways, thank you for pointing out what I could not see.


> Thanks,
> Tomasz
>

