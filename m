Return-Path: <linux-fsdevel+bounces-42862-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 790B3A49F39
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 17:45:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7035A1894628
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 16:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7307A275604;
	Fri, 28 Feb 2025 16:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MQmipvxQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1A2274275;
	Fri, 28 Feb 2025 16:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740761107; cv=fail; b=rKp7SGG8CmjaXZa4ZE6V4Q1490QOXNvY8we0GPR5+2zH66R9786GobDuB/uMHKkHw78jPDHHl+9HB7E0cBLAgLMiOmk4smsoS8IL+5m8bH+eV5Gt6ZtlhYEwRX6/RlLVZT/9ZpdlWSWuelgNv1IiRSchfGYj9CZnp/q/Ch491ww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740761107; c=relaxed/simple;
	bh=K9ub49SO48MMYkHmYdlsT95k92e2JLrTb7MXHmzSljo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NkevMMG6ADKhoSBENL3VvjHeWmid/hbuibYUKjwVVajWxT8EQxmhhjbSjKm9Aq668u4ysxR1dtMYZC/avKk7sRRp9yJeFBgNNo/FZi040zsSEOROPSs1Lxn+BGeltT3Bb939jrzvLXmt3NJF4FIumg+oOSYCPLGY1XQHVwGncmQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MQmipvxQ; arc=fail smtp.client-ip=40.107.94.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ppo0owxBXKFCanTkp7cbekUUP7mDAQqQ23y2GVF2Tm9RUKiJU//WPWZ/JlNKwtay6BfLciB2RIx9WOFEPboGxEjVxcHA/X5Gz+i31w6md8XlLfzccir9TJBLH3o1wzpS5+3KHmaxjgCvlWGdm6vgNzkzOrWp3zXw9gY+MgmTcTMH0Fb0aCgJgnilfnqfiqp2TacQuBcTvAvRFTkj3cTAsy4P15yWVUMCHTQDuMqnQ7vUQXg3VXBN2ZCjcjlYpKmchCco3S9W78ybFIuAE5QPDDs2SaFjHQPe5lAJTRnH1e73JG89IrO4ftcN6IKCnt2J4lVzzzzG6114r1qX5fDTZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m0j7xEp56AbVDMEoGJeMU7Je8uhLjxEhQVnxjcFw9RU=;
 b=kO60aYE1i7SFIrQuD3YYIaLtFJbNWg2IDz5dMwe8fm+h2ufKXtFdGH+xJR8dui8c3Wx4bqVbBe4WLZ7RkA9grR10k7Dcwt74wahs47KocOn1vvS25G0+BHkNYLVqf4uhTdCvEvby3ewO5PglzywxlC4TEC2Opc+iyQDbC3w7YoS6AYXLry2B166kAuc28DuIU6z9bsdYErJU+68KTkU95T4yVd+vMRrQW63k5m3IH//OdWO0Q7WJTpvwd5Q0FSCchbHWbsGynSq7sYwMHP2aWSVo1MMYJ/zT+OGLHV9yjD1CBicjLtNCdwDMPFe/Cia95HRdkupyM4FeGjejYEJRsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m0j7xEp56AbVDMEoGJeMU7Je8uhLjxEhQVnxjcFw9RU=;
 b=MQmipvxQnBQPFoGRzqjAi1OoYe+j3szuBt4VkAs5Yp58yra3aBNcGtaJJDEz0G9D6++Brc1nIkV47snJUy4JtJLF0cE9sX/rzrpGOQlfC6TDlfHtRdu8+SK61DIeGOpgL+NXeGU4yvbKFHMxLOjn53Zmt4pYUhO+g9hyHuilxx8OaO/smlJJ4d+HNvAU3eTHJ/0sNIjdRTwJWqIpwgPL0WhrLNRF9rAxfzQNCvPSkrNGf6hmCLlwK9LpOsiSTf+r0MYDZLpKvkeI+MXrx6DkKnarR+tQVID3QsTW8kU+LohTu05VSCf/4CjQJGFgW8ovYlryNi0+eQzuk8Lli/ByQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by PH7PR12MB6979.namprd12.prod.outlook.com (2603:10b6:510:1b9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 16:44:58 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%6]) with mapi id 15.20.8466.016; Fri, 28 Feb 2025
 16:44:58 +0000
Message-ID: <5205ea6a-92eb-4c3d-a135-f3c3ea3bbf1c@nvidia.com>
Date: Fri, 28 Feb 2025 16:44:52 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] efivarfs: add variable resync after hibernation
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
 linux-fsdevel@vger.kernel.org, linux-efi@vger.kernel.org,
 linux-pm@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Jeremy Kerr <jk@ozlabs.org>,
 Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
 Lennart Poettering <mzxreary@0pointer.de>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20250107213129.28454-1-James.Bottomley@HansenPartnership.com>
 <20250107213129.28454-3-James.Bottomley@HansenPartnership.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20250107213129.28454-3-James.Bottomley@HansenPartnership.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0135.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c4::10) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|PH7PR12MB6979:EE_
X-MS-Office365-Filtering-Correlation-Id: f3ed9212-8476-49de-09fa-08dd58173c76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eVBtcEpPVlJhKzhkTG1IWHFFRmplNXlBT0dwRUY2Tm9GOHpHWVl1akdsZHNS?=
 =?utf-8?B?a0Q2YzFxRkZ5UkZTYnd3bUVnM0JMT0Q2SVg0b1YxSVhPdWxWQmlGcnp6MTFr?=
 =?utf-8?B?OUJoYnRMSnJhV2lWb0QyWnJjOXc2Y0VaSDdIMThsY2lDWjgxM3pYd1VzOXpH?=
 =?utf-8?B?ci8vRTFwNmQyeXcwcE1ObnI5cTNEbm9EQXYvY0tNdGFvZmNKeHVvOG12OUFS?=
 =?utf-8?B?L1BmQU1aMUoxaFlNQkswbmxUckhaZDFXM1ZwZGswQ00wWElaRlM4WkwwaUJW?=
 =?utf-8?B?QldTVEtGRktWdXArT0VXVnVnYm1yaW1ZZmtBdm5ncy9CWDFuNDlaSzV1bko4?=
 =?utf-8?B?TDdEMUlXQys5UDZrUk1PZXd3NzJIRlhxdTlrcTltM2pxTVhXNGNzcW8yR3oy?=
 =?utf-8?B?dVhJeGZNTkFpQW9lQWg3UldIYmRZZjNjNEVFRzNxc0xkTjhvWEZici9rWFhQ?=
 =?utf-8?B?a0RGbUx6QVBrTERNbWIvK3FrMm4wczk4MG0rMTc2SWFKZHhQNXBiTVB6WUU0?=
 =?utf-8?B?dFg0WG9PTUErbFZVMzlKQTdWR1I4eEY0a1ord1JQa0tQczRZTGFkeHJwNjBS?=
 =?utf-8?B?bzEwTXo1aGZrT1U5TEFzL0h4TkhhN09ybTRESHRJbEVHdytHeGRaRDM2ZUEy?=
 =?utf-8?B?dUJKcUhqcklxalB5YlhJbHRjZnJwZEw4V2lvSThmU3o2RkFTRTFrdFNmcUwz?=
 =?utf-8?B?RG8ycjhDU2hJdlRQNkdQd1llTEI5cWxwdXhOZ3ZYV3pvTTJ0VnF4Q05TaXlR?=
 =?utf-8?B?NWplaVQ4a01CSGFSZVJFWmJZOUhjb3JaaFZlRmJHSjZMY3lBb25nV2NXN0x0?=
 =?utf-8?B?N2hnK1o5YXhOTzZUTVE0RVNJaUpzeHZvWTMwb09TNWdMS296U1IvTXZ2Q3B3?=
 =?utf-8?B?bWQ1bWd3dXUrcGVGZUhsdWtrN21MVmVXZzEwZEVXQ2VhZVpMV3FDTjRtY1V6?=
 =?utf-8?B?dG1oTkREcDk2aGZ4QlJycUdMTzJHY01JTThpa0wyUU9UbHIxS3l6OHExeHVt?=
 =?utf-8?B?bEcxRkY0ZUR3NE9PS0FsQWtoZEx3cTlSN0t4WGN3VVk3QlhmZURXMVhxR0Fv?=
 =?utf-8?B?dTJZcXVjREtXY2NHaDIyaHRzRWEyRU1jT2wzM2R2SWRUaTkveEtVRnJKbytN?=
 =?utf-8?B?WWRVQlkxdWJxb2V4ZGRIMDRLNWkwSDRySzlMZzFzTVVQejdpU1g4aEFPakpt?=
 =?utf-8?B?cVlIRk5CN0ZnV3FPYVJyVEJ4QU5Oc2c2SjlEb1p3Nmc4a3V5d1cwWFRzOUc4?=
 =?utf-8?B?Rk1VMEMvekhEYmFjMmc2STk4ZEhNMVFSQklyTkZPUkg2Vkt6R3A4YUFEWXR4?=
 =?utf-8?B?WkpGckdVeUN5azhvNkdwSEwrdUVRRjBmeTZaSzBEVzJ6SFExam5zWmVGSEFX?=
 =?utf-8?B?NkZlS2RvU2VSUU1mTEVwVG1nNlBpd0lvMFNOVnY5SUozNlFrQ1JOcGkzVEY4?=
 =?utf-8?B?VmNHR3RhT3Rzemo2ODBUSG1JSHZSRjBCUEZRRCtkdWpKdUw2MWhmRmY0QUdx?=
 =?utf-8?B?L0huam91WTFMY1FOaCtnWE1PSHlLYytwL3RGaExva3l6R21KVGJIeEtJZi9r?=
 =?utf-8?B?THF5ZmRLaVVSSHZGVEMxSXZKbjYxcWROVUk5eTR5dDk2U2JBWkFUNjZ6MDIw?=
 =?utf-8?B?UGFhWFFXQ2t1UVVDSCt5M3Y2ckttWkhjdmVqSE80dWR4LzZzRitnOGVoMkpD?=
 =?utf-8?B?VC9pbHk3TmZVU1FlckpZQllvY0pmRXBxV0w1U1lweTNMV3ppa1pnMUlzdGwx?=
 =?utf-8?B?S1F0bnFaaXJwaGFXSU5MZXJUOVFrNWYrNngrNk9iQWx5UHd2aE1yNTNHWUE2?=
 =?utf-8?B?V1YzaXBvMTVyNzFVSmtTVGx2cVFVUXFPcERYWk9hNWtOdHVMQ29kdmJqMWo4?=
 =?utf-8?Q?UNbg5BWQvEDhY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dDAxYlZCRnA0bDhvVzRHdnE2WjkySi9BYlpSYWxCTy9pRGZJaHRJcmpSNDkv?=
 =?utf-8?B?WWxmZGNpRUllVU1TUmFaVkFnRmNXelJtdE1mS2hrVGV3N0lXdkFyS1YvRE05?=
 =?utf-8?B?WjZyVTc1Sk1FS1E5dDFnMXcya3pWNnZ5RmNQdUxla25FdDdwdVRwdE1GSWZj?=
 =?utf-8?B?VEhjZDllU2gyYXFVL1hxRUhMdkNnb2VSaXE4ci9aOTJrN05hUWg1MW9oWm12?=
 =?utf-8?B?R0JxV2w0RTA3LyszNXpyRGhqVGl0alpCb1ZueFBCYjQvclkxZDdzMk91MTNx?=
 =?utf-8?B?RkJGTnlWRUs0SmpzMUg0dmszQ0VOeTJocEMyWXExdG8vZHd2RStMdHBpVjkr?=
 =?utf-8?B?ZUt5K0ZYRFdPL0ZLOGpJR01GbWhyNFduZkxFVkF0QjJobXFHQk5lUVVQR1Ay?=
 =?utf-8?B?M09Fa1hJWStTaDhFQTExY0hmNElwSG9jTm5iT0JycE1oM0hadlo3Sm9TVEs5?=
 =?utf-8?B?dE9ISzYzUUN4dUxqNGVXeWlOc25LbXVrNTYzTTlHY1NOSE12UjY5U1FyakE1?=
 =?utf-8?B?VzBYMWRxYUJhV1RDc1p1N2wwYTNRNU1ma3NVbElvYi9UdU05MEJmazc0bW5y?=
 =?utf-8?B?WEYxTG9YbER3WWpxd0h5KytxS3M5NlAzNktJV3hVU3E5Njk1WmpJMFF1ZkZY?=
 =?utf-8?B?QjNVcFUzVUtIb1NrRFJuYnI0ekZjUHQzSFBPR1ZZQytYdy9PWnMwaUdtcjRK?=
 =?utf-8?B?dDFYQzY2Y3lFbW5IbXRnV2pUM0xkVUlZSjdqaHFPRVpxOVErT3ljc2V3b3Av?=
 =?utf-8?B?SXBoNFFZdDdwQWFhYUhydHIwM3hhQUpBZGM1eXBmNEpPOGVaUWUxYm5Rd08r?=
 =?utf-8?B?QjhBd2pNTGNtYmFDWmgzdlIrQi9ZeTVRdkdad1ZGMjVselRjMFJXUjA0N0Z5?=
 =?utf-8?B?dXdCVS9KaUFkZC9UY3VKZE1RMjJsRXIrejluek5YYm1IWGs1bWN0dmU4RC9Q?=
 =?utf-8?B?b0VySkRKTjhvRXZETHhJM2VwY002K2MzY1NkNi9OMWUyVUJra2EvV2EwcStq?=
 =?utf-8?B?Q1VYZXdTdmJ5bUtXSW52blQyYWtTV0xqK21vM1NHbllXMTdUOW5uWUFVbDY2?=
 =?utf-8?B?QWJhMmtockN4ZEk3OWpOVVA4ZVdXY1NmRERja1I2bHZjdmw0bVNRYzNwWnd4?=
 =?utf-8?B?QUtJd1hMTVJhUkE5eXlSdVJIZzR1YkRac2RPWjZTQ2tiQzhZYmk4eXpNSTY2?=
 =?utf-8?B?N1hqZHJDWDgyS2dxeVBCYXBXa1c0U1BUaUR3eGlzNStXY2JkMi9FclgyUTFO?=
 =?utf-8?B?NzdvWDBUNGhxSWptQ1dNbUxmNFBRTnJ2UGlHUE9FQXFQN3YvbHJiRXFxWjdL?=
 =?utf-8?B?SUxPT053OTh5K3Z0VXpLdlVSN0pVU3U2WVFSZWFaalplQ3pOL0ZER2JlOFpP?=
 =?utf-8?B?L0k1ZGlUUml0b1hveHdpZnJoOGJlSUhpSlI3MDZhby9IeUt4elQ2cHdwU2hx?=
 =?utf-8?B?ZmpJRzNhNE9xRlo2QnpkcWZUSTlzY2ptL1NSemxNMzdiV3R4WFdnQjMyVFlm?=
 =?utf-8?B?NWwva28vNXNTM3JLTTVMTmNaN3dVSDhLdXNaM0F6blM0SXFoa1BsRmNoN2NC?=
 =?utf-8?B?YjFFNStqdGRNYnp5aGNMclByOUd1Z2l4RnB1WDltRG85a0hYWmZiWHlFNGE0?=
 =?utf-8?B?WmF6UVdIc2JKaGdkVE9QMjdOTEd2cUxNTW0zUXUvRkF5dlpMcC94VGt4YXVG?=
 =?utf-8?B?L2JqYlk2alFvNUtlMXdnWWprREtPRnNPb0dNMFF0YUVDSnR6QjM0Sk0wWUM0?=
 =?utf-8?B?cFdGS21yVVp1U1Y0a0YvL1pwbXFpQlNQcEdyVUxjQW9ZMTZDZ1lpRWwxdVZS?=
 =?utf-8?B?ZUkzUzdleUtBcVRlNnVsSzBHdDFCOWtTbFMvK0t4QUhuSU9obzhnOW5xdjg5?=
 =?utf-8?B?L0VTVHBwVTZQWkloM1BFZ1B3blhaTkUzbUpMT2x2dXRveE1zc1JUZWdpUlNQ?=
 =?utf-8?B?bkFhd3pBOEkzaWFsUCtSVXo1NTRpNjg5WXRzZ00zdUZZcmV1eWtaWldDTUdD?=
 =?utf-8?B?dTlVTUFIbTZYYm1UVms5bmRoUDRHNlZDcmhheUhSSm51SnVFRE9MSmZ0OExY?=
 =?utf-8?B?MHRUR01iK09LaWdiVzdJYmhNQjhub1hOc3hOd0I0Mm50SEltTnYyeGlpZGhl?=
 =?utf-8?Q?43JgIo+lAgpoLGqfirvhltXNR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3ed9212-8476-49de-09fa-08dd58173c76
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 16:44:58.1292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0V2fZyVqWtewkKUUfKu++f3Ues9581wdK6AveA/VQg99KXx/qvGXAqIw2mwEKHhX+TBKdyU05sk7Az4suHX+Qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6979

Hi James,

On 07/01/2025 21:31, James Bottomley wrote:
> Hibernation allows other OSs to boot and thus the variable state might
> be altered by the time the hibernation image is resumed.  Resync the
> variable state by looping over all the dentries and update the size
> (in case of alteration) delete any which no-longer exist.  Finally,
> loop over all efi variables creating any which don't have
> corresponding dentries.
> 
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> ---
>   fs/efivarfs/internal.h |   3 +-
>   fs/efivarfs/super.c    | 151 ++++++++++++++++++++++++++++++++++++++++-
>   fs/efivarfs/vars.c     |   5 +-
>   3 files changed, 155 insertions(+), 4 deletions(-)

...
  
> +static int efivarfs_pm_notify(struct notifier_block *nb, unsigned long action,
> +			      void *ptr)
> +{
> +	struct efivarfs_fs_info *sfi = container_of(nb, struct efivarfs_fs_info,
> +						    pm_nb);
> +	struct path path = { .mnt = NULL, .dentry = sfi->sb->s_root, };
> +	struct efivarfs_ctx ectx = {
> +		.ctx = {
> +			.actor	= efivarfs_actor,
> +		},
> +		.sb = sfi->sb,
> +	};
> +	struct file *file;
> +	static bool rescan_done = true;
> +
> +	if (action == PM_HIBERNATION_PREPARE) {
> +		rescan_done = false;
> +		return NOTIFY_OK;
> +	} else if (action != PM_POST_HIBERNATION) {
> +		return NOTIFY_DONE;
> +	}
> +
> +	if (rescan_done)
> +		return NOTIFY_DONE;
> +
> +	pr_info("efivarfs: resyncing variable state\n");
> +
> +	/* O_NOATIME is required to prevent oops on NULL mnt */
> +	file = kernel_file_open(&path, O_RDONLY | O_DIRECTORY | O_NOATIME,
> +				current_cred());
> +	if (!file)
> +		return NOTIFY_DONE;
> +
> +	rescan_done = true;
> +
> +	/*
> +	 * First loop over the directory and verify each entry exists,
> +	 * removing it if it doesn't
> +	 */
> +	file->f_pos = 2;	/* skip . and .. */
> +	do {
> +		ectx.dentry = NULL;
> +		iterate_dir(file, &ectx.ctx);
> +		if (ectx.dentry) {
> +			pr_info("efivarfs: removing variable %pd\n",
> +				ectx.dentry);
> +			simple_recursive_removal(ectx.dentry, NULL);
> +			dput(ectx.dentry);
> +		}
> +	} while (ectx.dentry);
> +	fput(file);
> +
> +	/*
> +	 * then loop over variables, creating them if there's no matching
> +	 * dentry
> +	 */
> +	efivar_init(efivarfs_check_missing, sfi->sb, false);
> +
> +	return NOTIFY_OK;
> +}


With the current mainline I have observed the following crash when
testing suspend on one of our Tegra devices ...

rtcwake: wakeup from "mem" using /dev/rtc0 at Fri Feb 28 16:25:55 2025
[  246.593485] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000068
[  246.602601] Mem abort info:
[  246.602603]   ESR = 0x0000000096000004
[  246.602605]   EC = 0x25: DABT (current EL), IL = 32 bits
[  246.602608]   SET = 0, FnV = 0
[  246.602610]   EA = 0, S1PTW = 0
[  246.602612]   FSC = 0x04: level 0 translation fault
[  246.602615] Data abort info:
[  246.602617]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
[  246.634959]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[  246.634961]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[  246.634964] user pgtable: 4k pages, 48-bit VAs, pgdp=0000000105205000
[  246.634967] [0000000000000068] pgd=0000000000000000, p4d=0000000000000000
[  246.634974] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
[  246.665796] Modules linked in: qrtr bridge stp llc usb_f_ncm usb_f_mass_storage usb_f_acm u_serial usb_f_rndis u_ether libcomposite tegra_drm btusb btrtl drm_dp_aux_bus btintel cec nvme btmtk nvme_core btbcm drm_display_helper bluetoot
h snd_soc_tegra210_admaif drm_client_lib snd_soc_tegra210_dmic snd_soc_tegra186_asrc snd_soc_tegra210_mixer snd_soc_tegra_pcm snd_soc_tegra210_mvc snd_soc_tegra210_ope snd_soc_tegra210_adx snd_soc_tegra210_amx snd_soc_tegra210_sfc snd_soc
_tegra210_i2s drm_kms_helper ecdh_generic tegra_se ucsi_ccg ecc snd_hda_codec_hdmi typec_ucsi snd_soc_tegra_audio_graph_card snd_soc_tegra210_ahub rfkill tegra210_adma snd_hda_tegra crypto_engine snd_soc_audio_graph_card typec snd_hda_cod
ec snd_soc_simple_card_utils tegra_aconnect arm_dsu_pmu snd_soc_rt5640 snd_hda_core tegra_xudc ramoops phy_tegra194_p2u snd_soc_rl6231 at24 pcie_tegra194 tegra_bpmp_thermal host1x reed_solomon lm90 pwm_tegra ina3221 pwm_fan fuse drm backl
ight dm_mod ip_tables x_tables ipv6
[  246.756182] CPU: 9 UID: 0 PID: 1255 Comm: rtcwake Not tainted 6.14.0-rc4-g8d538b296d56 #61
[  246.764677] Hardware name: NVIDIA NVIDIA Jetson AGX Orin Developer Kit/Jetson, BIOS 00.0.0-dev-main_88214_5a0f5_a213e 02/26/2025
[  246.776569] pstate: 20400009 (nzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  246.783718] pc : efivarfs_pm_notify+0x48/0x180
[  246.788285] lr : blocking_notifier_call_chain_robust+0x78/0xe4
[  246.794286] sp : ffff800085cebb60
[  246.797684] x29: ffff800085cebb60 x28: ffff000093f1b480 x27: 0000000000000000
[  246.805021] x26: 0000000000000004 x25: ffff8000828d3638 x24: 0000000000000003
[  246.812355] x23: 0000000000000000 x22: 0000000000000005 x21: 0000000000000006
[  246.819694] x20: ffff000087f698c0 x19: 0000000000000003 x18: 000000007f19bcda
[  246.827029] x17: 00000000c42545a5 x16: 000000000000001c x15: 000000001709e0a9
[  246.834372] x14: 00000000ac6b3a37 x13: 18286bf36c021b08 x12: 00000039694cf81c
[  246.841713] x11: 00000000f1e0faad x10: 0000000000000001 x9 : 000000004ff99d57
[  246.849046] x8 : 00000000bb51f9d6 x7 : 00000001f4d4185c x6 : 00000001f4d4185c
[  246.856382] x5 : ffff800085cebb58 x4 : ffff800080952930 x3 : ffff8000804cba44
[  246.863713] x2 : 0000000000000000 x1 : 0000000000000003 x0 : ffff8000804cbf84
[  246.871045] Call trace:
[  246.873550]  efivarfs_pm_notify+0x48/0x180 (P)
[  246.878119]  blocking_notifier_call_chain_robust+0x78/0xe4
[  246.883753]  pm_notifier_call_chain_robust+0x28/0x48
[  246.888852]  pm_suspend+0x138/0x1c8
[  246.892438]  state_store+0x8c/0xfc
[  246.895931]  kobj_attr_store+0x18/0x2c
[  246.899791]  sysfs_kf_write+0x44/0x54
[  246.903553]  kernfs_fop_write_iter+0x118/0x1a8
[  246.908113]  vfs_write+0x2b0/0x35c
[  246.911608]  ksys_write+0x68/0xfc
[  246.915013]  __arm64_sys_write+0x1c/0x28
[  246.919038]  invoke_syscall+0x48/0x110
[  246.922897]  el0_svc_common.constprop.0+0x40/0xe8
[  246.927731]  do_el0_svc+0x20/0x2c
[  246.931127]  el0_svc+0x30/0xd0
[  246.934265]  el0t_64_sync_handler+0x144/0x168
[  246.938737]  el0t_64_sync+0x198/0x19c
[  246.942505] Code: f9400682 f90027ff a906ffe2 f100043f (f9403440)
[  246.948767] ---[ end trace 0000000000000000 ]---


Bisect is pointing to this commit. I had a quick look at this and the
following fixes it for me ...

diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
index 09fcf731e65d..1feb5d03295b 100644
--- a/fs/efivarfs/super.c
+++ b/fs/efivarfs/super.c
@@ -477,7 +477,7 @@ static int efivarfs_pm_notify(struct notifier_block *nb, unsigned long action,
  {
         struct efivarfs_fs_info *sfi = container_of(nb, struct efivarfs_fs_info,
                                                     pm_nb);
-       struct path path = { .mnt = NULL, .dentry = sfi->sb->s_root, };
+       struct path path = { .mnt = NULL, };
         struct efivarfs_ctx ectx = {
                 .ctx = {
                         .actor  = efivarfs_actor,
@@ -487,6 +487,11 @@ static int efivarfs_pm_notify(struct notifier_block *nb, unsigned long action,
         struct file *file;
         static bool rescan_done = true;
  
+       if (!sfi || !sfi->sb)
+               return NOTIFY_DONE;
+
+       path.dentry = sfi->sb->s_root;
+
         if (action == PM_HIBERNATION_PREPARE) {
                 rescan_done = false;
                 return NOTIFY_OK;

I am not sure if we are missing EFI variable somewhere, but
I guess this is something we need to fix. Let me know what your
thoughts are.

Thanks!
Jon

-- 
nvpublic


