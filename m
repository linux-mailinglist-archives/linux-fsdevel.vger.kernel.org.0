Return-Path: <linux-fsdevel+bounces-18984-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC768BF401
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 03:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAFCB285F00
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 01:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D819449;
	Wed,  8 May 2024 01:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Bb3MgcRa";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DMrZeNcC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C11D79EA;
	Wed,  8 May 2024 01:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715131280; cv=fail; b=gCdU6solggNSNG02fUlnsxQAatE7SeO8kHMTE/ts6XryfDvT0g1/NXeTlKvbZlRRrQdqF+TxM9VTIyRZoZTN/47ylsRRcg6LYRzOoU69NfggqIG7LDO+4txKArwvqSffQ90IoPEww0P0rTJaQFs37L2juY43yMhHR5eEDthrQp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715131280; c=relaxed/simple;
	bh=AFtgzLCVvpCOhJgElJcDy6d8aVszAhtqPLum8Jnh8FQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CFL17AluGz0F8L51khm77pRFFZE4Jkivga6BLVFibZb+N0FBc8JBxAV1dllAzPETemeFrQM29qHu7E9r0gdYm7czCpKqiwCB81uKWqy7/BOsOxxTvUIX4lE/Xlzc7OOL2G8CsegfP4H6YHAAPrI4u8dCdILBLulXbgb9q3U0yzw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Bb3MgcRa; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DMrZeNcC; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 447IJndW014441;
	Wed, 8 May 2024 01:20:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-11-20;
 bh=QFgUh1UHTNz2+4nm+jNKfOiOVoH6IrRIgxaT3YFIKQM=;
 b=Bb3MgcRaYa13ed/kMTStp2OqUz9TczQck3e1NlQECpZlm8aAA5mOAYctQd56/PXrr6SP
 Jpt3F5Xo/nKRAg2AxYAnb1SH9JJOWqC1lV5dQHME3P/KaOwNa/pGgWGpaYCDjZ2dDmRn
 luDp3kfkTpbQEQmVTc5iYNQ9Tn53ubIiyNyvhhEXHwJvzcg6akE2jPSReHr+fBLjEKRt
 VuIY3ZPzPExNeZ5sL1wSstxQZ/kyodlyTBgl0DHN3bPfSKj5J0LttQ/r+q9f3fCGpoWm
 6WTAMwAIhSRJsQHgoyatWd/BhnztJSMZuPb4W3bGozhIVPNV0ENgLvGO6KowaFYwEvxj 0w== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xysfv0mbg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 May 2024 01:20:55 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4480TQha035482;
	Wed, 8 May 2024 01:20:55 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xysfnn4uh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 May 2024 01:20:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cg/Vn2MV7iktS9oYXh0GjIgpTRP//kGpL4zAaRqJtpBzLQe28WWyIB9CunjAQepBUxlfD3C7Bo9kRMj9Ag9YmJGaZ/+TC4NphNC5MADRL9crkU7K0OR0q1JA3/gYTsDUx9UhyuCwNrRdrsz1hUbumuSlwY/A07sLcXnVrcR4D06bLAeogOL5xIzP+zPJn/3YlCiunNYt057bQ3dJ3mqoJvju8s7Z/MMj8Qyhadz9OYyem/RNBO1zXshYNNKaehdnwae3+LWhyb2HwZkdfeE/lX2MCdcxwY8zlKIblWaop1B9G3E3b041IBukVDBINGK4RIYG6TXs8trOs8LxgfSGJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QFgUh1UHTNz2+4nm+jNKfOiOVoH6IrRIgxaT3YFIKQM=;
 b=LQRC0bRouQ9RUQqmRcTjFP0ODrbg1icIDOxxfUCVpW2X3SOWghBXLN1kAIs8ntzvQU9u2lOBg1cXSO8VlC/mdFeKIwBZv6ZJXwUvLAl16HFGXKx+ZwlEMLFxNhwtpCOfYxM5C2ZhAUaUzpvJPx8zDF3Hf0K/6CnWdbo5IGPn02Airc5x+xHe06RnBvzC2AS+S5ibeqxfq42S/S7VXt22sOkdfisX4MaMY9WK9X8H7/m3oGU1qDLFEA/no6G3hiKgfnz2rbaxgJkQ40oUXrljuAmuRXnOZSQzR/m0pUP9+rPTLzz94T8xLgnyUKa9bdtKobAbFMVESuWqWiwl1QhoWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QFgUh1UHTNz2+4nm+jNKfOiOVoH6IrRIgxaT3YFIKQM=;
 b=DMrZeNcCGssYLS7S+DpnEuAVt47FZpkOwVH3zSc35OaGYPwuKht+D9EkfsEC++eRvxQbHntyljwiTzbtsKSBXgNX+Ok4y/yI+4OOENp5U16f7Lt08cQTXYDLK8DJ6jcDFZaUt2+0hVP5UqjDp4x6xtEalQA8WdIy8OOIqT1X5Is=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by BY5PR10MB4372.namprd10.prod.outlook.com (2603:10b6:a03:207::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45; Wed, 8 May
 2024 01:20:28 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.7544.041; Wed, 8 May 2024
 01:20:28 +0000
Date: Tue, 7 May 2024 21:20:25 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, Andrii Nakryiko <andrii@kernel.org>,
        linux-fsdevel@vger.kernel.org, brauner@kernel.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org, linux-mm@kvack.org,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 5/5] selftests/bpf: a simple benchmark tool for
 /proc/<pid>/maps APIs
Message-ID: <k6tdxhcli4upvrkhjabf6nxn62kaag4rwtancotpoqgs7lyqgg@upccyvmkr5cq>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, Greg KH <gregkh@linuxfoundation.org>, 
	Andrii Nakryiko <andrii@kernel.org>, linux-fsdevel@vger.kernel.org, brauner@kernel.org, 
	viro@zeniv.linux.org.uk, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, linux-mm@kvack.org, Suren Baghdasaryan <surenb@google.com>, 
	Matthew Wilcox <willy@infradead.org>
References: <20240504003006.3303334-1-andrii@kernel.org>
 <20240504003006.3303334-6-andrii@kernel.org>
 <2024050425-setting-enhance-3bcd@gregkh>
 <CAEf4BzbiTQk6pLPQj=p9d18YW4fgn9k2V=zk6nUYAOK975J=xg@mail.gmail.com>
 <cgpi2vaxveiytrtywsd4qynxnm3qqur3xlmbzcqqgoap6oxcjv@wjxukapfjowc>
 <CAEf4BzZQexjTvROUMkNb2MMB2scmjJHNRunA-NqeNzfo-yYh9g@mail.gmail.com>
 <qa3ffj62mrdrskqg33atupnphc6il6ygdzbtknpky4xfhilqg2@mqojpw2vwbul>
 <CAEf4Bzap9QkdQqxwE4_yjYJ4V-QVnwyCXaOChDswFwmaGJUvig@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAEf4Bzap9QkdQqxwE4_yjYJ4V-QVnwyCXaOChDswFwmaGJUvig@mail.gmail.com>
User-Agent: NeoMutt/20231103
X-ClientProxiedBy: YT4PR01CA0015.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d1::22) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|BY5PR10MB4372:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f9063ef-480d-4472-1432-08dc6efd0bac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|7416005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?WFVxbDNMRWNTR0dxZzdIYUZDbkFEaTRVMVl1ZU1ONFUwVFhFZjdCL3hZYUk4?=
 =?utf-8?B?Ni9MemtQckwrVWFCaW5ZSWZWWHV1QXAzS1dqSUZ1aXM4MnkxZWQ5NUwrTmV3?=
 =?utf-8?B?T2NIaThJNHpkclV6MnFOOXdNU3R2YU15YUh0TXUwdlpqZjh2ZlNqMVE0OXFm?=
 =?utf-8?B?S3RjQ0FxMmdZV1ZaOHFDV3EvcVJ4Vk1sQWJxQjlDdGpKYmcySlQ0QVpMSVl1?=
 =?utf-8?B?dmM1Uk9pa3NZWG9ZVDlXODVCWmsvbzF0N2ZwN1BsWUFpamluUGM1WmpNalhC?=
 =?utf-8?B?NVROd0hIM2R2cmR0Rzc0WlVrMStnS3dyL0VBK3JoaGRSTHZEWXlHNjNLL3R2?=
 =?utf-8?B?NjFWcDQycjRhKzJuSFRHUnJRY24zZUZMb0pMaVI4eElZekNlUm5ERlJLYkxH?=
 =?utf-8?B?ajdkd28xV0FyeHZGS2cvL0hhbkdLckp2MVdQdDA5eHhGQ2lJQ1BjUGxiNHgy?=
 =?utf-8?B?QkNGbFc4c1RCUnFHTUVhaC9EZG1Zb0xLNXYyUndYc25ZeWVRVDlnUWhNbjI4?=
 =?utf-8?B?YXFVYWh1eVQvVWRuVGEwY1RoekZvYVBnWDlkc2EycWlQK3p0d2JoZmlMcTRy?=
 =?utf-8?B?cmNBQlNJMVN1RFZWTTB6bHYzajFhMDNrQS9NUzVuRmJUTy8xaU9PdGhpRDcr?=
 =?utf-8?B?bmJZYlpLSHpyS0s0RXYzZW5QV1ZueTVBaUtaWFZZNjAzTkF6QmNIb1VHQUtQ?=
 =?utf-8?B?VjdyelVRSHorb0hTOGg1dGhoalkwN3N4ZXFLTnByeGkzc1QwUWJzd2MrUEth?=
 =?utf-8?B?MDNHVDZ1Y2ZKSzZYeE01TFFrRkM4b0lIWi94VytqbG90OWRQdGppRm1ndHN3?=
 =?utf-8?B?SDZ0ZExFRDRVZy9Fa1RkVUNJby94ZGllWmZ1amxSNC9SZDZEbVRYOUhZUkhH?=
 =?utf-8?B?di8xMk9saDc5VlZ6SFgvSXdBRkRGQjhKUmRXYzdDTVFNM3RubkM2SDZsYmNK?=
 =?utf-8?B?T3dUaGRueTlCNGhob1hSUUx4dHhTN2lxdDc4OWlNNXhhWFNuYWpoRWpkZnpN?=
 =?utf-8?B?SU92bVVCNm5KOW5ZYnZYRmFrT2xrQ0tEdHVnSkxYVndNWEU4WHZBR0lSM1hM?=
 =?utf-8?B?YUt0REZGQnMranZEc2x6a2Z2QWlyTkNucE92OG1QSXdMY2ZVdzE5WlZ2SjUy?=
 =?utf-8?B?WnRqakxDaE5UY0hMTHcydC9hNEV4Zk02QmlSSUdwUndCbmdwTzhkMC9aMUZR?=
 =?utf-8?B?Q3lCNmxQYXg2ZU1IbWp6eHpxbVJWV0dTbFFTRGI1RFFzcVljR2h2U29aUjZM?=
 =?utf-8?B?dmZJckZUUlVRVlQ5YUVyK3RYMEhRSXlqWUFsMkNMUTl0Q0V3QzN1NDB3U3ZI?=
 =?utf-8?B?MEsyUytNdW43SUV1bU9KajBnUFQwWDJzcEV0elhidTJYeU94VkxoYUNGRzk3?=
 =?utf-8?B?RW9MYVR3OUU5VXFCR25XdnhoYVZKWnl1RHY4SExyS3VjTGEyWmdxN0ZCQ1dI?=
 =?utf-8?B?ZWFJWHlHeE1vK1dIbmRXWlpUV0NMV0Q1Mnptend3Y0swSzZzRHJleHFUblo5?=
 =?utf-8?B?OTE4bnNndGR3N2F5SDVkeUw3ZW1tUDV3MUcvNTgrd3luQ3FvdHQrVVg5OElk?=
 =?utf-8?B?TjRvNUMrZkZucnY1blFNT29CRWVDSHpyTy94VnZvMU1PVndyeWE1WTlLODVq?=
 =?utf-8?B?SWt4eEZMcXZ3WFFnd0oxd3ZRZm91MEpUbTZxMG91VW1tS3NzQ0FhVzFpRlAx?=
 =?utf-8?B?cXJqRVNhWnk3TVltSzIvcXdWdDZyZFhtS3daeG1zOXNhOWdEa3VWSXh3PT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MlNzU3FGMlY1TUpHYk9Rcyt6N3VnSnIwc29jcWJQZ3FSQ3VqazZMYTZaWC9j?=
 =?utf-8?B?MXpUTTEyVEpuMjdXT0xzcnFqL0xWbGVvMThGeGpnbXVWR3d2UUJ1c2k0a2RJ?=
 =?utf-8?B?dE0zZlBOOURsTTdFUXpCWXJBSHlrTFBnYTA5RFBtUklSNE9DUXhIREJIVFl4?=
 =?utf-8?B?Q0orNHVSVlI3ZEpMZ2tBcUlFZXJWUTNUTnVjRWlSbnFEM2xPN1M1dDN0R24z?=
 =?utf-8?B?amUxcG5ncWp3VWNBMUIrSzZ5ZEljS0wzODV6TWNXOWsxSmRYUnhHWm9JanJD?=
 =?utf-8?B?SlFQb01zWkNTMTQ5eC9rQTZvZFF2Qnkxc2R2RWx1aWZ4ejQxM2NCK0xIVUd0?=
 =?utf-8?B?aGJFbXBFbmZkZGkreFZtTUtxRUdyQ3R0WE16RmtzSFlNMmxuVnVPZFV0Z0pX?=
 =?utf-8?B?SThPeklick11eTRaa1BNa1BqaXhoWjFEUEhDakxKR0JVUVZUbERSNHVhQlFl?=
 =?utf-8?B?YkFPTkRLNVo3TTlyTHp5NDdEK28wOVRSWStoY0pQZTVGRkNNQyttQ0krUzJQ?=
 =?utf-8?B?NGhXQTgvT0psK1hVektLTUFxQkd6aG5SUmk1bDA5MTB2dTdrTXNlci9XcC9K?=
 =?utf-8?B?UFN0RXVaODlJMzMwWGxXL0ZzeGE2dXpNR0hVcEZ0MitjK1hhNitlTFVJZmNF?=
 =?utf-8?B?S0VFaloyMVZRREVZMC9HZ3JzdXVCd29YaXJrclVDMHFEaTlNamdQTmZFT09x?=
 =?utf-8?B?U0JFaFlhd2tMbTB1dkF6T2gzeDFwcnMxVHNmMVZ5ekFjQzNuS0x1cDZYQVRS?=
 =?utf-8?B?cWlqcUM5NTBsaVg2cUtuN1kxRVArbnJ1dkIxRm9VYnc2bC9PTnVzd2kxdWFq?=
 =?utf-8?B?TlI3QXltU0hmMklMMGRrSE9OOGw2VlZDbGFxWHE5YjVyQmdURjZRYWhKOGxI?=
 =?utf-8?B?K2JrZFVHQjFyYjVpMHZ5TW9ObG95N2hWQXdiSFhiQmloZDNXSnV4MTVUN0ZJ?=
 =?utf-8?B?YndURFgrelZrR2FBUDdZbzBmOXdERUI0U1JxSmlJQXZqYklSODhXZXBGaURY?=
 =?utf-8?B?WDZtK0xyY09iaTBLZkg3V0hrYU10akFtWkY3Z1VsUkg4dGVVelFxajlkWUwr?=
 =?utf-8?B?dGVQaExvR1B2OE9YeXRrYm5idW1ObWZwV2RQc01KcXoyUWVqaUNSb3hDeSsr?=
 =?utf-8?B?Rk9lQXQxV0pMR01zdlJuTjVidkRYdUI5ZHdOSG0yRy94MHhTZ0c5aXJkMUVo?=
 =?utf-8?B?V084ejVJOXRtUGpzWlYyRnNCRFk1V2prdHhyNmkwRVVwWHYvSWJYdlAvZEkv?=
 =?utf-8?B?Q25VSVg2NlU2eGt3NmcvYi9Xd1gxcVd5SGJ1Y2lNTzJxdGo4U1YyZzZKM3VZ?=
 =?utf-8?B?cmZqRGQ2RS93MG9QWlJwSWhkQkZWUUc3MngrWnVJdU9ueithMzFuUi9QUFQ5?=
 =?utf-8?B?MzZhNVU0L09ETVRpVlB4bmRaQjVudjRjTVprcVMxNFUrcHhwNCtEOGxsWmEy?=
 =?utf-8?B?dWJZa2VKMVI5cVFTOXlXOUtzMkRiSDI0WFBGcDBDNGJwbiswaVdrbkQ4NzJZ?=
 =?utf-8?B?K0ZySEdTS2JRdExVV01KNVhaSFNHMFpUUUdRZEFYaHREQ1ZoeGtwQ3RHWWJX?=
 =?utf-8?B?UHIrY1BDd09pUHA3QTBsNHNZSTIzNkdCNHNUeE4vQk5Md0Z2WEhHZzRuQUUy?=
 =?utf-8?B?dTVkM1lVanVDVjIvMStYbkdUZGlseWs0ckpueklYL2lLeWpaUU1rWW05YlJo?=
 =?utf-8?B?US9vVUVTQ3cxd0dJV204elV5TU5XVEhhYXV4a1lvL2c4a01jNjdLcXUxY1ZI?=
 =?utf-8?B?VWRMSVRYa0RSa0FEakFRcXZyYWJZSkdreVo0amFjb0x3T0FOSVQ4MGJqcEVD?=
 =?utf-8?B?a2lISndqYUtNWHpUZHFrWHZDR09CTzA2aEVFaG9MbEduZEE0SHhHaDFVdkFz?=
 =?utf-8?B?b2xDcHV3a0VJbE1MeVlxN3BZaHlJMGQxK2oxUjQ2ZHZaOXFDc3JJUDNQUytS?=
 =?utf-8?B?VFVLelh3VEJ1c3kyRUU2MmoxWjhEb1JuZlBMSXpqNE5Td1NYQmFKd0V3dVlP?=
 =?utf-8?B?b3paaDNZSG1NN2hLZjlrOElmT01pVy9TRWd0a3BYR1F2Q2pEVlJkRDJ1SURY?=
 =?utf-8?B?MlpGS1hlUm5YamJWQjhpcVV6VFpZN0pmZ1VLV0xadmNlL3VNa3Z6OTZFUTI3?=
 =?utf-8?B?dUJHTXhCUlJQR3JZdnBUKzFvdkxhaXNKM2cwYm16NWJxUmR6VjhPZkQ3TzNT?=
 =?utf-8?B?U0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	aS4iYq30I9M7O6EUWfIdTdQaEFzLENLVa6dwPFca7tIxkYi559xDEQCEN9QQgjFx+59y8AX/t8lObU8/XHkKofpCBT4zv5uZ+MNCqP5sPbkE+mpGtaj48EM+ZNO9kgYzgUWZWxLz5ihj4PdUcqpvlaXZekfl11jx/GflMItvgAJeayyKf5tcQrD9z2UAbLhqyKH3TeWVoiYUtBm0c0xeLLmnpqiNpNXYRj9Et5/SiC/tJQbQfsxll4my1YxHGMWk8QVxYEiGWutwsujHJi0EY7E2Y59jLLwS6/Zie4E/QmJBR93MtgMDt9yaNnykuS11QNWPP4I99bsbmSADZHUwMZVrXypbsXTWXLOTmrIm9rxC5T4DSjtL+V9Af/eUAwdFBkAdjn77tEsJbKhDV8/fipKkRhdB2xCagt+ZgfgIiKoxL7pRJaxJnc1IX1j/rGjitUuu7ChVLiLn4MGkq5f1kSy3TpYbHzVtT4fvZukVTyR/ZDykscPL6upeHXZI+shcMDj81HGJ+if2O+LRHQAddECnROrL/X5wqwbAPVkoxEfSx9bshEiMYl+yiFg38bgbwanl60TkqvXN5bq6kDhs/i7aKOmSQDvNCozhajQLNWA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f9063ef-480d-4472-1432-08dc6efd0bac
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 01:20:28.3658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yeFqyv0bMhjXmv8/8GOmlIgcv5g9v/dl0tNGzATq+sL2Udyz2LIU2PYjokVdoU1bD0QZEqU0cLJhEepI/w5Xjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4372
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-07_16,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 adultscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405080008
X-Proofpoint-ORIG-GUID: XqMiyDxB9GHcgwju2eb55HFyGufAErYW
X-Proofpoint-GUID: XqMiyDxB9GHcgwju2eb55HFyGufAErYW

* Andrii Nakryiko <andrii.nakryiko@gmail.com> [240507 15:01]:
> On Tue, May 7, 2024 at 11:06=E2=80=AFAM Liam R. Howlett <Liam.Howlett@ora=
cle.com> wrote:
...
> > >
> > > As for the mmap_read_lock_killable() (is that what we are talking
> > > about?), I'm happy to use anything else available, please give me a
> > > pointer. But I suspect given how fast and small this new API is,
> > > mmap_read_lock_killable() in it is not comparable to holding it for
> > > producing /proc/<pid>/maps contents.
> >
> > Yes, mmap_read_lock_killable() is the mmap lock (formally known as the
> > mmap sem).
> >
> > You can see examples of avoiding the mmap lock by use of rcu in
> > mm/memory.c lock_vma_under_rcu() which is used in the fault path.
> > userfaultfd has an example as well. But again, remember that not all
> > archs have this functionality, so you'd need to fall back to full mmap
> > locking.
>=20
> Thanks for the pointer (didn't see email when replying on the other threa=
d).
>=20
> I looked at lock_vma_under_rcu() quickly, and seems like it's designed
> to find VMA that covers given address, but not the next closest one.
> So it's a bit problematic for the API I'm adding, as
> PROCFS_PROCMAP_EXACT_OR_NEXT_VMA (which I can rename to
> COVERING_OR_NEXT_VMA, if necessary), is quite important for the use
> cases we have. But maybe some variation of lock_vma_under_rcu() can be
> added that would fit this case?

Yes, as long as we have the rcu read lock, we can use the same
vma_next() calls you use today.  We will have to be careful not to use
the vma while it's being altered, but per-vma locking should provide
that functionality for you.

>=20
> >
> > Certainly a single lookup and copy will be faster than a 4k buffer
> > filling copy, but you will be walking the tree O(n) times, where n is
> > the vma count.  This isn't as efficient as multiple lookups in a row as
> > we will re-walk from the top of the tree. You will also need to contend
> > with the fact that the chance of the vmas changing between calls is muc=
h
> > higher here too - if that's an issue. Neither of these issues go away
> > with use of the rcu locking instead of the mmap lock, but we can be
> > quite certain that we won't cause locking contention.
>=20
> You are right about O(n) times, but note that for symbolization cases
> I'm describing, this n will be, generally, *much* smaller than a total
> number of VMAs within the process. It's a huge speed up in practice.
> This is because we pre-sort addresses in user-space, and then we query
> VMA for the first address, but then we quickly skip all the other
> addresses that are already covered by this VMA, and so the next
> request will query a new VMA that covers another subset of addresses.
> This way we'll get the minimal number of VMAs that cover captured
> addresses (which in the case of stack traces would be a few VMAs
> belonging to executable sections of process' binary plus a bunch of
> shared libraries).

This also implies you won't have to worry about shifting addresses?  I'd
think that the reference to the mm means none of these are going to be
changing at the point of the calls (not exiting).

Given your usecase, I'm surprised you're looking for the next vma at
all.

Thanks,
Liam

