Return-Path: <linux-fsdevel+bounces-27456-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A3E961956
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 23:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 181931F243B6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 21:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDCF11D1F59;
	Tue, 27 Aug 2024 21:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="KCROUbsT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip191a.ess.barracuda.com (outbound-ip191a.ess.barracuda.com [209.222.82.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5420876056
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2024 21:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724794726; cv=fail; b=WpgaJtyAAHYnXBQrbSo+hOCbqB31xnofPeZ/tupAYnZ7RKBPc6GUaM7bkh0rjcV6foFrbNfgNgk+baRhDuwwDgI88c9rs7t1/dzYHum/btt55OavrG0N78RKQLrlKoITtnadpQSrPVDsOVUxhCvjjBZh/Ojl/ONxiHYdoFcWUwE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724794726; c=relaxed/simple;
	bh=v+ZgVN43iavwS9inC/I69xGBmSn12DLqbm8sEfdSjMw=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=irjPyE44gN+w1QBUdCiGHdLx4CWduRbf26bV4DMYlPr4JF37KzXis904E9L9IqRTeYFozh0qHN6+meXlxSS+gIvKn/Sy7ZO44Bu58e21HeGjimkYm63jOUexJKN52c+NuimZdAKk6LX3+kE5VAlnEM/fAu/nV83kQZdHQfCSUwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=KCROUbsT; arc=fail smtp.client-ip=209.222.82.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2042.outbound.protection.outlook.com [104.47.56.42]) by mx-outbound13-71.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Tue, 27 Aug 2024 21:38:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BTZMtl+EzZvDvXJxLw1cHcqjhj4kRuR55PtUfN8ofcRNiZpaYQ1gpJwDQGNkCxqdTABPVAgYVq5h11ltbX5C0Sn8qXOh1IcwerbcUNcgMMwyFEpomQe8bg4tp9ZWDJNSZLMqLfFRIYDVuIX0Z+SU3kN2eLY+94iCVtnaWMm5f/WmJMn1tZv+ltqToEoCMV3qAyr4wW4DWqZlmfR8S5A/ueRnvCJBRhbPi8RSy8YLviWzfLawURBtheJUsnlMTiORpE7eKf2f+ah+2qgwVNbOo0vOkQhHc8rjkLkXyx3Mgz5OLNPE5FWSSrTsYVFKNhKi3asUuNYZYlXJiLvR7AnG9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bcLDDmxZhihEMou8gWuLWO5DA4JkmEdyLwP7xAhkmOU=;
 b=sK8/PDW9zqsTJB8CaGVK/cHzn0OgJxKpG2dV/FA1BExS59fo87pO1/uvktUos6/FFR79Ypz9+srJeGtVS3SEAigPHzq45h1tU7zewGl+L5R9QkNKT22DhWCFEj/+y/oUTtggNLzZZIXk7JOh4X7ev1IccPPz7er9wk+EFerKz2IsjyjnWgi0kMUiUzHH1tQMJP00/b/1pFtTfMJYJBmstkarsRc7JqEPPnayCMGkZoJsQ2g40Y0C7RHe5Hnm5UNuLiAP4+lg2D5CkDks40I5ECH/2fG99T8G+zVtPSrWcV52Vif2j7dbuow/o4+9K3Te2mOdWIi3Uj+2AouZZ0ZaUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bcLDDmxZhihEMou8gWuLWO5DA4JkmEdyLwP7xAhkmOU=;
 b=KCROUbsTY+2CI9xBIk3Ry9px7HpVXTj5tFHqGMPSpCM49hofVuBT/RBa5z0pI5XtDuUb8qSUd6P9Rho0QHndcTJlE+l2KaY1NV/0QyKDqv7+0+2YBc3s8XM5tHl3dgr18B7uHi/OML7Lz7EZkVTFypWbxwCzHfsTXKc5SGvdTz0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
Received: from CH2PR19MB3864.namprd19.prod.outlook.com (2603:10b6:610:93::21)
 by CH3PR19MB7930.namprd19.prod.outlook.com (2603:10b6:610:160::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Tue, 27 Aug
 2024 21:37:01 +0000
Received: from CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03]) by CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03%2]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 21:37:01 +0000
Message-ID: <1f36f129-fdd3-4992-87f6-e05943a376c1@ddn.com>
Date: Tue, 27 Aug 2024 23:36:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/11] fuse: convert to using folios and iomap
To: Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org,
 amir73il@gmail.com, miklos@szeredi.hu, joannelkoong@gmail.com
References: <cover.1724791233.git.josef@toxicpanda.com>
From: Bernd Schubert <bschubert@ddn.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <cover.1724791233.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR0P264CA0148.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1b::16) To CH2PR19MB3864.namprd19.prod.outlook.com
 (2603:10b6:610:93::21)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR19MB3864:EE_|CH3PR19MB7930:EE_
X-MS-Office365-Filtering-Correlation-Id: b2c37541-db2e-4b83-88b2-08dcc6e062c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NDZuN0hBV25WelQ3R2ZKZUsvd1Q4QnB4YnFJTE5iMVl5blRlaUh2RGpaK1FI?=
 =?utf-8?B?RU52UHdYalF2ZGhYMVoxRDhUNFV5eVZVM2daY2FkUUkreG1BSENkL21zV00x?=
 =?utf-8?B?d1hxdFN0a2pIL2FJc1FVSE1INzZPUXZkcmFFRGdEalZaek9UZHFaWW1OY2dG?=
 =?utf-8?B?UCtFYVVlVzEwTlA3blVKZHlvamwxQnpnd2VaVzVPcnFnWlZWWVZoMk8wRzBi?=
 =?utf-8?B?WmZkRDhxT1ZvamVrNXpVOXlQL1hEbzk0c2tXb3R6and3ZTdhV05ET1hpdzla?=
 =?utf-8?B?MlJKYnF6RlN2bk8zcGUxYjBsY050bkJxekVTYkpwOUthOFRwS0tPK1ArbWdq?=
 =?utf-8?B?bmRuUXc2cm93UXNLdjBmYmNjYkp5Y0VqdEtCS2lVMzVrcXpQR1U4MkJBNkRn?=
 =?utf-8?B?ekJJTlJGemdxVXlPMkJveWhJUEVuODF1K0ZLKzhONUF5eW1icDgyd0pEazBq?=
 =?utf-8?B?LzgxRjh5cGQvcmxJSEZUT3phdUZOWEh0TCswdGx5U2JlQmVuWkZZcTJNcEE3?=
 =?utf-8?B?NUJGN2twL1o5K05oSjgyN2Erak9rNkZ3Tkt6b1llTGc4VTVFT0sySHNUa2NH?=
 =?utf-8?B?aE9Ybmd3Q1JWV0d2WUxldzJ3TDBCaUkzNEQ5SFVYMEhSVzdYbHBBcU1jNnN1?=
 =?utf-8?B?eVJGS2NUOHZNVHc4dFJ3aStiWHFFRlcyN2NTay9vWEVUajVqM0RoczB5cmpa?=
 =?utf-8?B?WElJMnhxZUVXMlRzQ0JOWVVlUTFzKy9yYjFhbVhzQjQ0VytNdnpmVStsN3A4?=
 =?utf-8?B?ZTFWMUpwT2pkYmF1aHFsWDcyOFo3NlpiT1d5dWN2VnQxZHA0QzZnS1JRSENk?=
 =?utf-8?B?bmxYNG0vbFI4M2VGR2IwNEZZa1pxdCtDVEpydTJxTW5hSDM1VDdZTWg1OGpw?=
 =?utf-8?B?MFVMWXJIc0M2bkRyWEp0U1hZZERrbnBSYlBacW1PY0FnMXR1My91ZlE2TmJa?=
 =?utf-8?B?TVU2anEza1h5d0hrak5zRkM1WjZMNU02QkVFZkxVV2hKSkRrc0ROMW5EWTFx?=
 =?utf-8?B?Y2d0TkhjR0RTekJFejAyYnJnL2lVL3ZVdHlHcmpldUFCLyt1QmRuVSszb1pi?=
 =?utf-8?B?bkdScFlwSEkwbjlIOWdvRk9jVG1xQWxtU2tHMXZWSldkVWx0YzZNeGw5b0kx?=
 =?utf-8?B?cjl5ekFsQjIremxWeVNvUzIzc0QxeGtNczVNb2lrUnNFQ1dUa1I5MFV1emgx?=
 =?utf-8?B?N2ZtZXlwa1RpS2RDc2NKTDdpMU9ZR20yQU9ZeU8wcUZ6azMwZ2hBcXBtVVNP?=
 =?utf-8?B?Uzg1WVU0Sk80MHdiMWFXcTg1ZmxOM0t3SUFCdHUrYVhQSDBrYnE0THJiUWl5?=
 =?utf-8?B?cXp2Qm9nc3lHWCtpWmhZVTZpTUFTR0VFOEV6VjJTSmJ5Vm1wOFhoODJremJ5?=
 =?utf-8?B?Y3VmYVNiK0UrdFhKbXRYNUE3OXFvOGFFTi8zUXJ2TFFEeDFyQW9HR080U2Zu?=
 =?utf-8?B?SjY5eWpSam1LcDliTDlDUTZrL2s2d0FCMVpBbHcxd0xZTXRHdUlrKzBPR0tL?=
 =?utf-8?B?d1BCU0MzcGhHRDdJelg0MnovWm9raDExdUFDN0tkS2pPY0dBYWhmT3FhNVVS?=
 =?utf-8?B?TWFMSVNsL2hvUVVDQXZDd1J5T3F4WHUrN0hxTm9YcVRaQTVLVENmTVE3M3NH?=
 =?utf-8?B?RGxCR3c1M0RkZVNFbC9XekxMdzU4dUV4QzhNRmhEL2hESUlzNGFENUFxbEht?=
 =?utf-8?B?MTBPUkFuWi9MVStwMU1wZ2hoRTFwN3BCQ1JGaFM0a1JLVGRsZTZ6aS80U1ow?=
 =?utf-8?B?RzVTTlM1R2NFaWZFdnFqZHRwVDRQa2J0MXZueXlESHJSeFJiNTZBTG1RNFlh?=
 =?utf-8?Q?t7zq+kYzVRKxSfCPbPgfLVJIA6sXFjN5x6X1Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR19MB3864.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bzdnOTBRbGgzWmxCL3A0UjBkYmErQ0pua0t4SE9vbGROc29wWXB4Z00zK09q?=
 =?utf-8?B?ODlnVTFuTkFoa0ladFZyQ2gwakc2Ly8xci95TTc0ZnQwYzJVYU16YUN0bEUv?=
 =?utf-8?B?aDF0S29xdnBIZzBWUFRMb0dHM1NMcEptR3FkRzUvZVU3OXZHUEdOYzFEKzU4?=
 =?utf-8?B?eGU3VVQ5T3orWjEvdTh4TGpLU3J2VEx0TE96UnNFcG14dVdrb00xdlJqY3VY?=
 =?utf-8?B?L0pyZ2JzNGNrZlE4OWpkRlNFZGZoS1BQaDMwRWQ0K1h5djFKV0xpOVdEVkU3?=
 =?utf-8?B?L0NabFQ3Z29CODZNcWFqRzRkOTljOE1YcG8zVjd4MHRJTTh5cnRmYW9abUxM?=
 =?utf-8?B?VDE2Z09NWHpkaEdsd2w4SVJUYStoTFVyWEgyOWdCaWZLTXVCSW4zQ3I3cHox?=
 =?utf-8?B?ZzRTWnViNXdJdlREQnp6YUQyR0NaSEpLZFEvMHo1K0JjcU1xS0JGRGVjWDBv?=
 =?utf-8?B?WFhIZmYzVlUrUFh4aWlrbEI0dFhSRC9hMUR4TFRoZmFwR0N0U051SEtlRW5x?=
 =?utf-8?B?RHJmVStVSlYxYWIzMlorRm9NWUY3b3N1bEc5MzYvWjZIU3hkVk5pRVA0UDlO?=
 =?utf-8?B?UktMSGl6UTJKUHVWK2JLVmwxcndSd05KTm1MbXg4cGMwSjRXUHhjQXFnakR1?=
 =?utf-8?B?Rno0amszTFpIa3ZDTFpnZzIxSjJDcGhSbmtVNHZsVDlQd2F1eHkvb2hnYW1B?=
 =?utf-8?B?R01wZHBTVnJxaDlLLytnQk9nbG0wQmNQQjN6NDlrbUFMcWh2TGJQUVY5T1Fv?=
 =?utf-8?B?QzB6WmFIUXNVWERaU0xrSElSaXRreUxNTlF6OFFsdzBhb3NxbmFWZUpOZlVE?=
 =?utf-8?B?NVFRSVB0Y0xXWG5wZmpzdDBURUJiUTZIZE9JUXhJQXpYUERzVWVpL0ZHRXBG?=
 =?utf-8?B?aEJoVCtzWU5kVVdNTE52N25ZcVc5TjB3N2htUzFGeklla1V2Q1hMV0NtZU1T?=
 =?utf-8?B?V21QNy9CQXZwVHpUMldPMy9DanZHMW5VVTVSeVJ3SS9SZmtlUkRvTk1ZUC9X?=
 =?utf-8?B?Uk9WVURxcXF1eHBoRUFEUFV1SFFLaUh5RTBZby9OYXpNUzdzNlZaTHRyUVNS?=
 =?utf-8?B?aWlhTy8vV09tUU5IMFlxUllzTG9TUWdNYTRkY1gxTVRxR1ppR29NTG9CbXBR?=
 =?utf-8?B?TndnMkF2REtucXpEQVJHMW5rcHJlZUp1VlZua3NIcVI3dDdhbkJ6Tm1QN09n?=
 =?utf-8?B?dTUzcVhLcDdvZGdqQWZHT1JWZkgzbE9XRlZDYkc3Z3k5enRLaFpQRlVqRnp2?=
 =?utf-8?B?Y2U3RzZEeUdHUStNb00vdFU2SGs5WGxyMi9GWWFuVGJTbnpZYXZNWk9KK1NU?=
 =?utf-8?B?TFdSUDdXbGhCYmx4UzVKK2dXK3RBYk1Ta1ZjVlNMWElhbStUOU9ZdUpqWlB5?=
 =?utf-8?B?VmwyemxEVVpnNmVEQ080TEd4L2xHQnNyU29URVBQUEVFdjJLZzJYOW1xMDJ1?=
 =?utf-8?B?bVU1SlNuNkx0WVBsRjVET3FvN0JScUtUT21EcHRwU0tZcG1nYXBHNWRpOUxW?=
 =?utf-8?B?ZmliNVB1bnUxNEtMMUlOQ0xoTDhwd2t6MElEdjFOQnpTeERFa0ZwTTlqcDQ1?=
 =?utf-8?B?Y3pMYk81am9zV2hUMVovbXdENEl5d2o0K094czlQNDFUWE9RVStWRkRmcmE0?=
 =?utf-8?B?VUd1dVlwU3BJcDMxT0xEcVNDTUp1WTczWk9oOXR6ejJwRWJMT3BtMENGakVV?=
 =?utf-8?B?NFBUR1RiTmRSVk5zNy8vZ0JZTTBCODVDWmlIaUlwR1lDTElCRkxpMVMvOHhs?=
 =?utf-8?B?aElnQ0V0WUZLUy9tcUlqOW1hZkxiUS9sS2lCei9xNXBIbk1aZE11MmNBS1NM?=
 =?utf-8?B?elA4alNnbWlTYU9PWmhPZVJMbnNMZ2Jqbm5MN0ZuN21WT1psOTRKcGFKSGdX?=
 =?utf-8?B?Z2lUU3JMWkM2RHdveUIreGhTbmkyQVlxeC8xeXlFQmZHUnMrS2FuelZOYlBy?=
 =?utf-8?B?b3R6OCtJSVViT095M2NKblUvellla3dEZnJaUU9RVGt2TkdSNUIxckVkUjlo?=
 =?utf-8?B?dHpTYytETVFOcnRIT2FHNUdpNVdJZ3NWRkVBeG5MdnRVaGt1dE5pbzZBaW9x?=
 =?utf-8?B?d25CUEtPMmFES29CYUhRbTRtQkc0Zkd5S2I2ZzdNWkFTVWV0bm9BZ2w0Y3ln?=
 =?utf-8?B?alRSSHJkdUNzYmgvQUp3ZWNVTWF1TW4yUTBiU2g3NDN1cElhdjlSTDNOYkZB?=
 =?utf-8?Q?usbvM8rrx54vN/02uLSLvg3XdbxXRXT5/JOa3YJQp9H6?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	D8PRWBC4zAl/5GALRICu5UnEy9fI0ljWAwjh0PhALFfZ8Mb7StJwmDXKcgsm55uehgWy1DoFM+a6J+dLV0NjmXzk++AOh/zA7jlQkxoQOoamBTdqMd5GQ5v5EF4fsI57+BTIdrBKDziXfeyAIYD1ieKR0zCcXWm7EGLvPQjxSvDvtNtd89DeQ+uqpsr8VckEXmA4LOiLYIxQEZ6PyR8d7d+CX4a1j+Xpp3tn+Ak+g0QBsnyVPIXcdE+1E20y20vbc9Vav6nHpd3CMZ4X0omCzrAuXupU0PjDfTr/UcCfByPkqzei8/b4A6s5UjxZfcy6Ps/rRxGig05H0nrasMp3f4QjXP/JnshFGgKfaXcNQGgsyaycU9xpZ5OBlugtPMa/Tby8hwz4dsFOkAWrQ2RnIQohrPNLO9NMUnXLAJmlabrdc/d2e+Dl6uV+P9gucmhuMSlpgDFlW/9YQr53tsmzcSu4piQsjlhnrcozAMBv5GUoHJIxsIC7h0bzwFrB7qN/T77r78k2K0tuEJhe/+N4lCU/f+vG0Pmsx+aOaHs06A5gbeA7oJUdq+4LDlfjVAMdZsFPaXOzvgSyIJbl8tH/LsU79n36q3IJPTmFOzMj8EgC34jpBsrtToftt9C1qR8iXLoamWxet/QV0vwqyLMVkQ==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2c37541-db2e-4b83-88b2-08dcc6e062c6
X-MS-Exchange-CrossTenant-AuthSource: CH2PR19MB3864.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 21:37:01.3999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GFxbTgXQECf3M4pYHxK7ozqRzzc5E1Id3j2NjEw/8zoTc2y43u9XG7nXiAJg9Jr1DzfUbyG5tZOpaOMWe2WMeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR19MB7930
X-BESS-ID: 1724794714-103399-799-8415-1
X-BESS-VER: 2019.1_20240827.1824
X-BESS-Apparent-Source-IP: 104.47.56.42
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVhZGxkBGBlDMIC3R3CTJJDXJyN
	DA3Cwx2dg8DQjMU43MzcxNjQ1TlGpjAeEYLmxAAAAA
X-BESS-Outbound-Spam-Score: 0.40
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.258639 [from 
	cloudscan12-192.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.40 BSF_SC0_SA085b         META: Custom Rule SA085b 
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.40 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_SC0_SA085b, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

Hi Josef,

On 8/27/24 22:45, Josef Bacik wrote:
> Hello,
> 
> This is a prep series for my work to enable large folios on fuse.  It has two
> dependencies, one is Joanne's writeback clean patches
> 
> https://lore.kernel.org/linux-fsdevel/20240826211908.75190-1-joannelkoong@gmail.com/
> 
> and an iomap patch to allow us to pass the file through the buffered write path
> 
> https://lore.kernel.org/linux-fsdevel/7f55c7c32275004ba00cddf862d970e6e633f750.1724755651.git.josef@toxicpanda.com/
> 
> I've run these through an fstests run with passthrough_hp --direct-io,
> everything looks good.

why with --direct-io? It is not exactly O_DIRECT, but also not that far
away - don't you want to stress read-ahead and page cache usage on write?
I typically run with/without --direct-io, but disable passthrough.


Thanks,
Bernd

