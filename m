Return-Path: <linux-fsdevel+bounces-55459-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A18B0AA22
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 20:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FF475A108D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 18:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9CBF2E7F34;
	Fri, 18 Jul 2025 18:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="JIKMGzI8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip168b.ess.barracuda.com (outbound-ip168b.ess.barracuda.com [209.222.82.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEF82E7F1F
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Jul 2025 18:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752863410; cv=fail; b=PsgKfsharTNTKiKuY+NH1K60ymqVNoG3pQipgY3RAd/w5tPdz5q+YQyujXLMa8BoFovedZC4/v49vs+zuo1yP7VI1rbRSTra822javoJvbpYfipdnPMvQTg8p9O7v/1J/5UVe7ZtfqScIQezyaKUx2G7wG/K8zoG6P1UHbftjcI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752863410; c=relaxed/simple;
	bh=nA7WmEjhD6xhmm7fw8ZKuMcXppO+K6DZCxHQwFaqCJc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lKkmnIZz5TbcJ8glpsdS4nNHBXpHYV/TT6k3eikM2GzMcoS7wUAhzP2QDr6S9uV+v1ikjoYJvVrlyOER7AH900zXZNHLv5F9ugYmVA6m4+I2LeEUINapKUY1Eu2qCYfm+EdyiiPVaNBAflJfYQc2NFm7H5puxavKrcqRhitsrKA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=JIKMGzI8; arc=fail smtp.client-ip=209.222.82.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2121.outbound.protection.outlook.com [40.107.94.121]) by mx-outbound43-143.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Fri, 18 Jul 2025 18:30:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dzI4UiQoa9yvVdKyrqM2jbrf1gmfaVrOgwc4HcyEnSBEYOR6XqyRPUv2MgrmsdjeDacnEzCyvRcOTJMc6X4wVXfj1T67ZDgo/IaWLR9Iv7eGj2ccW+wCv02NqXPt4CpQusT/eH7dawPPFQjDzqWgFWvfjomiVhqaOFRtmvBxZkvoN7WNH53VlH5u0z06ZVcgGhtAiNlxpWgfVgF6qgxJPjndbzEaQcvs5fzUgvae4sRdVwyF3mjhOYTowPhBEqChwlezYSEEAMO7Fb3SEziMM6zhi3h3hyYSQ2OiVEbKctyhLkwYlsbHjFdqR7yTCxKx3d48I3ux3z3y5znLRaJ31g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qUD6EWYBNtOTAI6D79StCGIYlI5Kd2xS+ZSMUqB7ncA=;
 b=dHKgg/F9ZKV5MGvYyyEqfE3ifY79BCjeNsxcU4MbS8Y8560wIsuNDo6CMpOIgDaybxgdlGi6DFH0Sx7KDKkeuWtUeFJ9VgG8zlT0QLymIWWiVp7qJ7XKc+Wv6aj96UyZPEVpFh8Dm6tI2kA6+1h5hDKGbuAjK2uuy2UmFdNZ+f3Ivjp7DY9qQ38BwyAbAlzNkQQyo+o8oRc5CEb1eszRONY8anwft2WyjxWeUb683i23WimCsAXdURDg0F94UIeXLdYHK1VV78MexZDnuFHPfYdwMVogEpCnP7p030MkX9SeDGD3dPA8mY73wXf32evus5oFM3mNHczF4yI19BNLew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qUD6EWYBNtOTAI6D79StCGIYlI5Kd2xS+ZSMUqB7ncA=;
 b=JIKMGzI8WrRqlkpT74WydVoF4w0PH92bnugVE0pcNSIeCtPJ6e9/d3HYQrPySTBW6QkQBDmHv92WrJx4nLncNlzSloB5RW2JyVBevg/0YueJqpG5dUQFqTEIcDzR5qeJoY37Zrm0DEGi7I/fUXZ8eYnuvyTg0bg/hDRi9Qi4ISY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
Received: from CH2PR19MB3864.namprd19.prod.outlook.com (2603:10b6:610:93::21)
 by BY3PR19MB5106.namprd19.prod.outlook.com (2603:10b6:a03:36f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.24; Fri, 18 Jul
 2025 16:54:48 +0000
Received: from CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03]) by CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03%4]) with mapi id 15.20.8922.017; Fri, 18 Jul 2025
 16:54:48 +0000
Message-ID: <86eec0dd-91dd-4b58-b753-5bc6a830114b@ddn.com>
Date: Fri, 18 Jul 2025 18:54:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] libfuse: add statx support to the lower level library
To: "Darrick J. Wong" <djwong@kernel.org>, Amir Goldstein <amir73il@gmail.com>
Cc: John@groves.net, joannelkoong@gmail.com, linux-fsdevel@vger.kernel.org,
 bernd@bsbernd.com, neal@gompa.dev, miklos@szeredi.hu
References: <175279460363.714831.9608375779453686904.stgit@frogsfrogsfrogs>
 <175279460430.714831.6251867847811735740.stgit@frogsfrogsfrogs>
 <CAOQ4uxjzU7o9j9LE1cQjGsKMpfrH0S2DGsrd=xGAqHyWbGFwng@mail.gmail.com>
 <20250718162710.GU2672029@frogsfrogsfrogs>
From: Bernd Schubert <bschubert@ddn.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20250718162710.GU2672029@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR1P264CA0094.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:345::19) To CH2PR19MB3864.namprd19.prod.outlook.com
 (2603:10b6:610:93::21)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR19MB3864:EE_|BY3PR19MB5106:EE_
X-MS-Office365-Filtering-Correlation-Id: 54ba98a6-8aaf-4ef4-1505-08ddc61bcde8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|19092799006|1800799024|376014|10070799003|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?NFpDU2tqeG54NW5ydFFBaSttVEwzMTN1ZUhnUlo0dFNlMjNRNk9RUU5jaVQ2?=
 =?utf-8?B?Tk1LQUZTaWNKQitoeFJEUkRpelBiQVVvbkRKUTF5M0JqZ2plQU0ydm5Xcm80?=
 =?utf-8?B?OVRSWTFpWkhYdEJUeVEzZGJaUnRzVUZXdW9FUnRac3d6NnhTb3JvU2tvSWlp?=
 =?utf-8?B?UXEybTJERUNsdUIwMkl1SXY5L1N6Y09BNDBaU3VsY2tUN3czcjI4RlljeUdl?=
 =?utf-8?B?Y3ZFTTZ6OUZjYXFQS3BmaWFuV1RzT1gwQmhHb1p6VGJiRnltT0RTcEhmbFY4?=
 =?utf-8?B?TTRDK1Joam9kbFlIdWswUTVPN1o1OE93a2dKamRUS1RSTFljSXlrbmM1bzlw?=
 =?utf-8?B?aUpMVnVWN0xXbVoxVzB2OHdIZWZabUthM1VsSVU3YlRDUzNrMmNQT2N4TmtX?=
 =?utf-8?B?clBZRW9hQmZ2cDdnMXdRenQ4Uk9KVjJOY1hVREtiWE1Ra21UOWxIMElCT1ZF?=
 =?utf-8?B?bTZIczcyUHphV295QVZPMmd0WFNrcXRyWXprclZINzhiSWwyVnd4N2lSaFhR?=
 =?utf-8?B?elVlbUdTVUdkOXlUdTVBcTJDSkRFMDVTblhIWW9GZ3dsRlBlM29zOFBxZkpl?=
 =?utf-8?B?aFJ3SWxOYkVGb1pZQzlub3p0cnd4cGZFUjBiVFpFa3NMVEl0d0NvN2t2Z0pU?=
 =?utf-8?B?dGtyZ3pvUDhZUHVWSm1sZXR1SGtqa3duUVFBdnJxbkNTemNYaWZ1MVhUcFVk?=
 =?utf-8?B?WHkvRmxWeU9hYnZydVJieTIwOWt0d3RVNHVOaUNZM1llR1J5cXV1Q01hL05w?=
 =?utf-8?B?b1h4YlgxazJ6b1djaW5EOHMxWWdhUHc1czM1TDRCcGMrMzRhUW94RzMycGxE?=
 =?utf-8?B?Zy8vSnhmTHNJVU5paVZWckJVSGZ1ZDVmenpBblFZQmRUZzNtQ2VqYk5TVVRN?=
 =?utf-8?B?c3lLK01DVFpMK3FtVFRxczhrcXJnbGQ2M1QvUXBoV1lZY29pNXFDQi9CVG1l?=
 =?utf-8?B?UjVZQnFmVHEwTE52TDhkcm5iNGpVS3lQRjIyQ1BHL0RqcDRONWl4K1ZKa2VK?=
 =?utf-8?B?M1B5WDdnT2FkWjk5UWp3VmZleXY0OUxGS25NQUxhdS96cS96bDJuZWxCeWpX?=
 =?utf-8?B?OTVPcnpEN3JRRUc0RFVmN3IxT1JoNmtybVdwai94dmRFelhXNW5kQXpBWWNJ?=
 =?utf-8?B?MUlhbFRNckJyQVk2UTRhNTF4K0NiT2RKbVlYQW5IQW0rT0VVQkFQM3h2bFBr?=
 =?utf-8?B?M01hMURiWHgxZEFwK1JrMmthVFF5bmZSWlhDaDViZzgzbVQ0RmVaN2FHd1Jy?=
 =?utf-8?B?dnNudlNocHh5WkJ1TjhYWG9USytNVXQyMVNjTWkvYWduNDlBQTlHempvYXhO?=
 =?utf-8?B?LzZaajhyNjQ4ejJ5bFZIMGJCMSszcDJrMnpMV2ZZanF6T05PT0ZGMGRIcHpy?=
 =?utf-8?B?cU9KVUcxQXF4ZHFtM1duallqR2E1bVZqTGRFRlVsd1dtRGpvQ25WamM1cW56?=
 =?utf-8?B?ZXZITDJpUXk0RWVpN01aZnZneDRWa2NMRVNtVDcwL04wWWErRWpXYVllU0ts?=
 =?utf-8?B?b3NSWGFNVmVOY1ZRT2M3UVZIeXlWZHJGcHhYWitkQ2lQSUxBajJkZFkxc0Jl?=
 =?utf-8?B?NTNaWitRRUpYaENSanY4VG82S2NyQ1poV21QMDJxTlRCejZpaUFvM1NuY3pF?=
 =?utf-8?B?ZFVzVUVJZFpoMzk2TDlwWWt2b2d1clRDd0tuQUxOZHNsSU1jdTZuWEd3RjlH?=
 =?utf-8?B?NllDdkFITlVmdjNRZFF1YkY3TkswS09PakJseElPSVFZblVBWW1wUDUxUGRv?=
 =?utf-8?B?cEFaakVhdGtNN2tSbHdnUTNyZlZVVzFFbHRTanhYNDkveWt1VGExdFo2RVdw?=
 =?utf-8?B?czBaSGd3MDFua1ovRSt0cmFYREdMRUR2dDVCNDhQWkV4YkdTWTNIbVhWTmM3?=
 =?utf-8?B?aTA5ZXBBc0xyeTc2YjFkTWdldFVtQnBFQnBUTHpYc3h0dTlGRWN0ZjRQR3Aw?=
 =?utf-8?Q?Q9tzJsaRElk=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR19MB3864.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(376014)(10070799003)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?VDlwYjV4bnlYZmZMZVF3dVI2WEtJcmZuTHRPOXRnR0p4ZUYvS0E2SXROdGty?=
 =?utf-8?B?N0I0RUt3a2t5azFKSFdYMnFMYXduWit3NHVsdmZDMDdNQk01QWs4TFY5MHFt?=
 =?utf-8?B?UWJBYWlab1F4MUJoNGtnR3p5dFUyRW1URVRJZzlKNkNQK2FYZmQwdnlaaVBQ?=
 =?utf-8?B?VURXbTFGcHVUYlFJeEdWSGJzU0xvUGMxcFNHR2tDdnJZQjcvY1o0MjMxV013?=
 =?utf-8?B?VFF4dDROTnhnVmN1dlg1OHJ1MzEvZm9KU0dUN2dqeHlRQTM0SlNFaEQ5UHJu?=
 =?utf-8?B?TnhrVFdGcWJsd3RrcU1LSVRneC9oc1FyQzUxcDdBMFBJVEViRHlHWnpQb25U?=
 =?utf-8?B?VUI4ODI2dkVLTlpGZmVTclYrbjVDY1dmWjFHbGg5cWNEbjhpeHJsZExyeENS?=
 =?utf-8?B?TkpHcG9ncnduWUxXWTRsbDlUOHpYYWtXTXd0QkJCUGN4WEUycWk4SWF5NkNX?=
 =?utf-8?B?QTVTd1NGdkhxdWN5ZlRxcHUyYWdFSExpd1VzeEZzQXJGbmF6UUVTMXdsKzRh?=
 =?utf-8?B?ZU0wWGhaY01tQStYazkyS0dvMi9BZGJIRElRUVlPY21iNkFLb1dPSXZjUDZQ?=
 =?utf-8?B?VVZnbHBIQ0lOU1pnZ3EwdVpkRytsMzBxUUZEU3B5M1RST1VmenYxQzFpVDJP?=
 =?utf-8?B?T3RVOFh3dlhFWWFacjcxODBVbFQ5NnBqOVJTYVFicC9vMWZJczZkUEE1Z3dX?=
 =?utf-8?B?T1E4NGhBNFNhZG9rZTFHTzVEdjROOSttZjN3VDlkaW1ESEJyMENKL1dNajY1?=
 =?utf-8?B?QitZVWFTYk9zRkoxa2VFNlJJbHhtR0NUU01weUk4eHE0WlZhNmxRa3BFdml1?=
 =?utf-8?B?anQ2UXl1cDJ0NlpTZGVCZFpJdXdvQnVTZHk5azc1Nlh3RlFERUpEbkQ3M3Za?=
 =?utf-8?B?dXRXM3kya2Zad2JnaXRsVFBPd0pockN1L0VBZFgvcDRrMVA2S3lFSHpLZWo0?=
 =?utf-8?B?OFZXOWRhNUhrOGtXOHBmU2tyMjh5SzNZVG5LMU84RXZTbmUxL0huU0VtWEJi?=
 =?utf-8?B?TndGbGJNQ2xyVzYzNGVYNVNpSXBsWVdxeFBVVkt1UG56ZkNvOHVGcGFzVGIx?=
 =?utf-8?B?MTZvOFcrbTBXNHBtazZEeHZkVnpaVnR6eFRCR3YxcGpBTkxRQW9hY1A0aTRN?=
 =?utf-8?B?NWJ2L09kT25aRkQzd1JIY1prZlUzWFB6V2J4bXkySnRTTWU4NUcwUDk3aWNa?=
 =?utf-8?B?VVRsY0dsZzRKenNyZ1NXU2l1OThqUjJrRmFycitkTjJtWnp3N2xKVk9ZdGFt?=
 =?utf-8?B?d1RoamRpc0I2bUNDK3VtemNUOVhCcVNncEU2OVVrcHBZYlFxZDMySXZyZWti?=
 =?utf-8?B?bmZMZnVrTWg0cmtDeGl6eGpUK2R4a1ljRzBnUjBPSWkrU3ZwL3ZqVll6dFBy?=
 =?utf-8?B?L3ZBOURYWFJxS3VCbkN0RmdUdEc3VFVEaW5nOFNENm10L3JiTnR6eFVBSFN0?=
 =?utf-8?B?Q2hTQnpkWTVMd2MwUzdVamtvb05XUUpSZ2VicElMbnkwcUNldmo1dnJ4d3Vi?=
 =?utf-8?B?MnRVanlTT29NL2ltb2I5bXBFYVcrTDh6NWh6ZnVnQ0M5NmNSb0hmaTdWWGhx?=
 =?utf-8?B?V2l3K1hlRVZ3dUF6VHZoRnpPbzREQnEvOThGVTJSS3pCV3cxdnFwZFRYaUpY?=
 =?utf-8?B?YkNmc3VrNldHb3M0dmFBTGdoRjBDMit5VHJ2b0NjL1lkQ3BsMG11M1BGM3JL?=
 =?utf-8?B?Y0dpQkJpYXE2WDRNTjNLM0tIMWRTU0NZbExydyttNkRQazRLL1hUbmMwYjZo?=
 =?utf-8?B?Z0VZYVVsRXoyQmdiK0dZdW8yY2p0RXUwVXcxQTFyOVJRWk9DdXdBMDlJRU44?=
 =?utf-8?B?TUN6cmdNallFejVNZTltSTdOV1kzL1BIWFpmblNuRnpVVUlXckRxQVRPakcv?=
 =?utf-8?B?SXByT3dORmw1VHBtNkIwRGtZL0VhRkk3YjZzVnM3Z3lKTkdRYituZTdaUFdQ?=
 =?utf-8?B?SVlsc0w5Yy9icjJ6WnJWLzMybkNrbGRrNzVTS0tQQzFXTjBOTlpmUncwRWN3?=
 =?utf-8?B?Q1FJTzhEWm94Y3p1dmt0Z2NZeTRuQUR4b01nWlFVaUJtN1lVbUJDWURNZndx?=
 =?utf-8?B?VjI1ZDVsVTd5RDIyNXNaQkJCdmdtOEszOTRUWDlGQk8xRjdTalpLbHcvMWdn?=
 =?utf-8?B?Ujg2Y1hNOHVab1Vna0xTbjNUTEFRRytOT2c0WS9iTFFBOXEzSy81R1dOUDB5?=
 =?utf-8?Q?cyHKob3AjY/iOQQoP9nxD84iDLn5511R7MXuJLMUP7yG?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
 CZlD4eVm8j/xwxhULsv6NqPq85XpOZPeiFiveIOJAW4Rf1kZy//VlC1s3JvLIFjfpdJeoXjsa05tqjq4YR29ZL3tX/cCG4gnP2/lOZB1WzD8b3ENdqvVTsKesYpKD6L5M39+9LprwigR9NgIU+CY/dp0Xn735VCZ/PLB7geDDxPqRlOZkp5u+Xx0+uLv1kYl6MCoHOPQLwUsHl+8skZlMECad58Opd2f4vGYRLGE6eG81PYWK0HBWImG1buH4M9AvomFugh02up5imAIE2P/BpFLLNj+BsWDIRld0aKp42rFyBsOKWqVV3CyGHFOzObM5GgR/z3a7SQMACbpP3zggUVyCeHMmjghEJuZgUjcMqY44gSak/YDlcBm+GaLv5i5Vu4tJzFr2UYz55njJgqEQLuisIvI9QZpp+W8SRO2VAmSLgmU9a9B43JfgYccCoz53dW3q3NDIl+9VydwgguTcZZkfySnwFTo6Z1qC8DReqYtVGlyG6/BL1buKSYkDgTX7vIpPqVnVc7HcsXp2qh1piy50j73CgMkEn5XgxwwCQldvpDp0jhVyL9YlJy+7OoQFFQvpRdBipN3czutqL3TfGjbeoB2dG4A12w75nul2t1Xtub5EZWvhY6bJE4KZzeVelF8k0LAHMbvhfhf26ii7A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 54ba98a6-8aaf-4ef4-1505-08ddc61bcde8
X-MS-Exchange-CrossTenant-AuthSource: CH2PR19MB3864.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 16:54:48.0136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m0Dp2Y9jo+FM//Jytukbzk7zh4ltbewqhIIt1mmYVwllyMFf4u37is+6uu8VT1fcnrpUlVb7ACUlrTBlQCXzMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR19MB5106
X-OriginatorOrg: ddn.com
X-BESS-ID: 1752863405-111151-7691-37979-1
X-BESS-VER: 2019.1_20250709.1638
X-BESS-Apparent-Source-IP: 40.107.94.121
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVsaWxiZAVgZQ0CLV0BDITTIyTD
	QwNTNOTU0yMDAzNDdOSTMxSjFJSVSqjQUA7y0Y7EEAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.266139 [from 
	cloudscan16-79.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1



On 7/18/25 18:27, Darrick J. Wong wrote:
> On Fri, Jul 18, 2025 at 03:28:25PM +0200, Amir Goldstein wrote:
>> On Fri, Jul 18, 2025 at 1:39 AM Darrick J. Wong <djwong@kernel.org> wrote:
>>>
>>> From: Darrick J. Wong <djwong@kernel.org>
>>>
>>> Add statx support to the lower level fuse library.
>>
>> This looked familiar.
>> Merged 3 days ago:
>> https://github.com/libfuse/libfuse/pull/1026
>>
>>>
>>> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
>>> ---
>>>  include/fuse_lowlevel.h |   37 ++++++++++++++++++
>>>  lib/fuse_lowlevel.c     |   97 +++++++++++++++++++++++++++++++++++++++++++++++
>>>  lib/fuse_versionscript  |    2 +
>>>  3 files changed, 136 insertions(+)
> 
> <snip>
> 
>>> diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
>>> index ec30ebc4cdd074..8eeb6a8547da91 100644
>>> --- a/lib/fuse_lowlevel.c
>>> +++ b/lib/fuse_lowlevel.c
>>> @@ -144,6 +144,43 @@ static void convert_attr(const struct fuse_setattr_in *attr, struct stat *stbuf)
>>>         ST_CTIM_NSEC_SET(stbuf, attr->ctimensec);
>>>  }
>>>
>>> +#ifdef STATX_BASIC_STATS
>>> +static int convert_statx(struct fuse_statx *stbuf, const struct statx *stx,
>>> +                        size_t size)
>>> +{
>>> +       if (sizeof(struct statx) != size)
>>> +               return EOPNOTSUPP;
>>> +
>>> +       stbuf->mask = stx->stx_mask & (STATX_BASIC_STATS | STATX_BTIME);
>>> +       stbuf->blksize          = stx->stx_blksize;
>>> +       stbuf->attributes       = stx->stx_attributes;
>>> +       stbuf->nlink            = stx->stx_nlink;
>>> +       stbuf->uid              = stx->stx_uid;
>>> +       stbuf->gid              = stx->stx_gid;
>>> +       stbuf->mode             = stx->stx_mode;
>>> +       stbuf->ino              = stx->stx_ino;
>>> +       stbuf->size             = stx->stx_size;
>>> +       stbuf->blocks           = stx->stx_blocks;
>>> +       stbuf->attributes_mask  = stx->stx_attributes_mask;
>>> +       stbuf->rdev_major       = stx->stx_rdev_major;
>>> +       stbuf->rdev_minor       = stx->stx_rdev_minor;
>>> +       stbuf->dev_major        = stx->stx_dev_major;
>>> +       stbuf->dev_minor        = stx->stx_dev_minor;
>>> +
>>> +       stbuf->atime.tv_sec     = stx->stx_atime.tv_sec;
>>> +       stbuf->btime.tv_sec     = stx->stx_btime.tv_sec;
>>> +       stbuf->ctime.tv_sec     = stx->stx_ctime.tv_sec;
>>> +       stbuf->mtime.tv_sec     = stx->stx_mtime.tv_sec;
>>> +
>>> +       stbuf->atime.tv_nsec    = stx->stx_atime.tv_nsec;
>>> +       stbuf->btime.tv_nsec    = stx->stx_btime.tv_nsec;
>>> +       stbuf->ctime.tv_nsec    = stx->stx_ctime.tv_nsec;
>>> +       stbuf->mtime.tv_nsec    = stx->stx_mtime.tv_nsec;
>>> +
>>> +       return 0;
>>> +}
>>> +#endif
>>> +
>>
>> Why is this conversion not needed in the merged version?
>> What am I missing?
> 
> The patch in upstream memcpy's struct statx to struct fuse_statx:
> 
> 	memset(&arg, 0, sizeof(arg));
> 	arg.flags = flags;
> 	arg.attr_valid = calc_timeout_sec(attr_timeout);
> 	arg.attr_valid_nsec = calc_timeout_nsec(attr_timeout);
> 	memcpy(&arg.stat, statx, sizeof(arg.stat));
> 
> As long as the fields in the two are kept exactly in sync, this isn't a
> problem and no explicit struct conversion is necessary.
> 
> I also noticed that the !HAVE_STATX variant of _do_statx doesn't call
> fuse_reply_err(req, ENOSYS).  I think that means a new kernel calling
> an old userspace would never receive a reply to a FUSE_STATX command
> and ... time out?
> 
> My version also has explicit sizing of struct statx, but I concede that
> if that struct ever gets bigger we're going to have to rev the whole
> syscall anyway.  I was being perhaps a bit paranoid.
> 
> BTW, where are libfuse patches reviewed?  I guess all the review are
> done via github PRs?

Yeah, typical procedure is github PR. If preferred for these complex
patches fine with me to post them here. Especially if others like Amir
are going to review :)


Thanks,
Bernd




