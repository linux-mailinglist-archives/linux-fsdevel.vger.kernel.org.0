Return-Path: <linux-fsdevel+bounces-40051-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B241AA1BAFD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 17:52:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BA58188413D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 16:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB9919B5AC;
	Fri, 24 Jan 2025 16:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="md1D7N2p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip168b.ess.barracuda.com (outbound-ip168b.ess.barracuda.com [209.222.82.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E54AFBF6
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jan 2025 16:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737737569; cv=fail; b=RKLixOtIF/WbOe+UAkrZl51OhEEB5QUTFYALhBq/YISLRvq1BLNv6ypmzwqQZ0b/98VXNtpAMePWDg1w9AOH+fDmszckEy3CxxUHdAyFk1+jN2ZVwFwd9x9nIPPxJj53jpe7E3ULAq1zzjFoTCtL9dXwBIdK4oDvMwYtak3w8sI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737737569; c=relaxed/simple;
	bh=rqinmXyTe4b8isa9mxcELguHeneq5MqSvKfAd0uwJi4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Flj01adfowVbv/n1ivDNF0XcbQKJYb+uO8y4106UQdCEuqCFSEKhprAw5a7lrvADcfVRKaOzKO32MJMqA3C7+CgehTaTznoHXdAqY6gZ1ySCa0EaM/SqghlVzQQLRuJjPPNtPPoWyOiM3xCOavjTSOQO5oxGZgriqaD2INMTw3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=md1D7N2p; arc=fail smtp.client-ip=209.222.82.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2043.outbound.protection.outlook.com [104.47.56.43]) by mx-outbound20-117.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Fri, 24 Jan 2025 16:52:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p/oLtBZXuIxRr2re6EA41jYIocRuXkxi4bUIZfCj33iwPDrwUTw0tMnFNJNMMN2A8kOlI5PQHmdFlkMeXr7nN5D+uFPvjBHfEwLkWAefndtTA4xWw69BQs3YHczzmYQeqZJTkO1xqPu9sClF22SuZze7GzqtFZen87Ukj3T3aCkpVhAGz4tDGM9DscxH3ATnMJxkDM4HpioHI9z7zFhNapxIACEgy+YYQRx1//IOy0C5GBYW9EjmCkdHNOB8B7uE1e55X1eW5YPAEe+epUyvqSYr2++hPtcZN2masyim3cbNBQ84pts1MLN14e2OBj686qaf1gAfCuxwpvpXvUgzQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XU0xiTxNNiPe/7/M6zzBYFbAS77K1a5VqHTMKv65tRY=;
 b=A5f5jqVM7gb9A0hqvMWJeMMA0wTtFip2w9ewaMDC3PeAKTnYuqe+KH6UXMAjsk6QDbbkmXi65RxAhOEzfKFNu4Zxetf1IdWbnX33dUUX7nuT+bG/KbGBYgYQDeVRSZWLiD91PepbS5oWYvyHtPn/eAgi9XKNhrMylhizpA09O96CdLS4yq9Ib0gUf2i74tmUSEwRDTXhp4P6oN8FYPcKlqB6Hr8ZR36NSFPsBtZsX4jbnQLA3fL+5KcFDYyMJ1LiNP7OkZ63Czpk3XChVpeey+qyr5gQ4JSfrk7NUiUuZLLWuCz25xA01qtqlYcX4MjM1u+Cgb0e95aW1WrjxtoTKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XU0xiTxNNiPe/7/M6zzBYFbAS77K1a5VqHTMKv65tRY=;
 b=md1D7N2pQWAtCgb2ynu08cwOBnhgBtSidRC8h9QDW70jQ2YXlG3Lt3LWrOO5XHyztugoNArimyocooCnUsxq+VIbyMbq6KsreC7mc4mhfGpnEmRLB/eIMWY6BnNP3f6s0LCaujZOv23sCsLN2fbZw+Q7RdqOlTl8ykxNzrYorZo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
Received: from CH2PR19MB3864.namprd19.prod.outlook.com (2603:10b6:610:93::21)
 by CYXPR19MB8402.namprd19.prod.outlook.com (2603:10b6:930:de::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Fri, 24 Jan
 2025 16:52:36 +0000
Received: from CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03]) by CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03%5]) with mapi id 15.20.8377.009; Fri, 24 Jan 2025
 16:52:35 +0000
Message-ID: <6e03f1c9-27d8-4d30-9b13-93000e5cec6d@ddn.com>
Date: Fri, 24 Jan 2025 17:52:31 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] fuse: {io-uring} Ensure fuse requests are set/read
 with locks
To: Miklos Szeredi <miklos@szeredi.hu>,
 Pavel Begunkov <asml.silence@gmail.com>, Luis Henriques <luis@igalia.com>
Cc: linux-fsdevel@vger.kernel.org, Joanne Koong <joannelkoong@gmail.com>
References: <20250124-optimize-fuse-uring-req-timeouts-v1-0-b834b5f32e85@ddn.com>
From: Bernd Schubert <bschubert@ddn.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20250124-optimize-fuse-uring-req-timeouts-v1-0-b834b5f32e85@ddn.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR0P264CA0176.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1c::20) To CH2PR19MB3864.namprd19.prod.outlook.com
 (2603:10b6:610:93::21)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR19MB3864:EE_|CYXPR19MB8402:EE_
X-MS-Office365-Filtering-Correlation-Id: 3050ca64-e09e-4520-ddd2-08dd3c9780ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|10070799003|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RksyYXAycEtyQW5yRDFvVXdUUmxCa3pUSDAwTDdWZGVURW0xUDI0TklBUWlG?=
 =?utf-8?B?RENZdTI1eEJTZjFtRmo4TU1IR2I2aTVjaTZIemwwYU1FWjFGR016VGVlWUcy?=
 =?utf-8?B?c1cyWnJUYjR1cEZIMG9UbkFSRDZpQkd4SldwQ3VCNzMwcmNrYXZ4cUo2WlVI?=
 =?utf-8?B?cGRuclMrb2YrQzlFTnlwN29KZVJCK3hTczYwZG5ORzlPUjFWd0VzZXhjTVpS?=
 =?utf-8?B?NWQxWUl3QzVpRDd5Q1RCazdtMHNVZCtIZzl5OHJuT3ZORmlYMXhMbnZxRys5?=
 =?utf-8?B?T1g1WVgxSTZqcThmVFZJdnQxOHFhL2VmajRTR3R4djdWWU1LcG5xMHh3ZUJS?=
 =?utf-8?B?emtrVlp1c2hXNXpRNkpTN05GZ3JLa0VwWit5Rkx2OVFnWlZhb3VTTjJnWDM1?=
 =?utf-8?B?c2JEdGZZTFNCUXlMNjNCNUh6Q1pYNlpTVllhZE1vTFNsWnU1NVE1aG1QeXRV?=
 =?utf-8?B?WW1KUkJtQjh5VjFiaGdLRlkrTEJVY21iR3BESzRqNmg1Y2tOdE1mdDZXUkdG?=
 =?utf-8?B?UEI2emNJR1JDclZtMk52MlZvczR2T1J5cUxQMWdIYVczK3NKZ0xhRVFydnA5?=
 =?utf-8?B?amplM3JxdkVuTkZFd3pEZ0VFaGRvYXpXdDhrZDJ6RU92SGpVR0oyZVhwaFVl?=
 =?utf-8?B?TkpTNFNLRkw0MXBUVjZEblRrdFI2UkNwbVYreEIyZnk1ZExydFVmUjFlMDdJ?=
 =?utf-8?B?NGlHSnlNUGxBTTNtdTVsb29PT2hNRnYwdTMvTEVQZlNrd3phbEEyRVR4NFp2?=
 =?utf-8?B?bHBEMlFwSFNMKzJXWlExZlVJbm9HRjN3UjhyZUdLR0M0WDFzTTVRcXNaZ08w?=
 =?utf-8?B?QytELzQ5eEpDTjk4YXRSd044dnpFYWFWdWtJcUVPa213dDk3STdKK0E4YitF?=
 =?utf-8?B?VnVHcVg4UGROY1FiUUdhTVIzOGxWSTgyYWljL3QrS2tsMTludUJ6MlM1Rmk4?=
 =?utf-8?B?YjVnTWcvNjQ4V1VxbHEzNTJpeGIvYXJnNVBnUG1FLzlmUThxMk1nc05BL2d6?=
 =?utf-8?B?TTZkRXQ4NW1OR05HQUZwU3FRZUFyRTVxK056OEQyWG1qc3dnZTlNYmlVYTM0?=
 =?utf-8?B?SWZKVTd1V3A5U2YyL3R5UkU5ZXJJNytLL2tFQ0JDYzdzSVVud29YK3p1MUdL?=
 =?utf-8?B?WjBkYVJYN0NMN0JQWkFObGFwa2d0YlpnVWI1MXQ4dndJOWVyUUczNHBaaVhH?=
 =?utf-8?B?S3BVVDlJdkgyOUcwYk4wNHhuQXk3ejJQTVRLWUhwSDlpdTJ5NXEvZFhQOEJk?=
 =?utf-8?B?NkJ0KzRjVjN1ZHEwUkdmNEhLMXRFeHRqckowbkhKWHI0WW9kaWFCL1M4dnY1?=
 =?utf-8?B?eDkvMFBaQTBTMWlVeWdhdngyV054Wlk1bDlJMFd1dFJ3VFRzSmZSbktvZmJs?=
 =?utf-8?B?bWxseXRzWFkzY2RCNGNGNGEzSkpvaGdOekdnY1E3NWcvVThydHVyUGxZN1dX?=
 =?utf-8?B?WjZVcGMya2ZaYlhKQWZwMlpMa21kWDZwL1dMT2dMK05HNUVleEVLSll2a3pN?=
 =?utf-8?B?VUo0M3BkRTlhSENudjFNL1k2VHN2cUNlbTVObDZZY0ZKTmtqc01BdnNNeTI3?=
 =?utf-8?B?VFVoZ05mMFVsYThzUW81TlJBYm5yeGhuREkvK242aHNSRzlId256ZHgrNGFK?=
 =?utf-8?B?aGtZRmcrSTR0Y1RmdTRsZlBUZXRKTUVHOFBjQVN6UTJ5MCt4YkJobEpGTUZa?=
 =?utf-8?B?L1pZZk9LMXBFcXdOakxXZFF4OUlUWWRERUYxTXNyVjBMTG5LcU1GcHRUL3BN?=
 =?utf-8?B?UEpaQ2hxWXF0VEVna1drb0NsbjhHQVYvbVVJVmUxRlVmcW95K3VXbFRLeWhX?=
 =?utf-8?B?ai9xL0VIRDljL1JQREFLaTlUUkQ1ZTRPK2FtSkZjQUNSN3ZwTDB6R29GRHdN?=
 =?utf-8?Q?SzA+spPe8VjME?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR19MB3864.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d1ZzeCtzOGkzMGliVVlpMGx5cGhQYWdvd3VibTFteTNSY0NRbDBPZnE4bkFK?=
 =?utf-8?B?UkI5Z01BY3lwNFE0VXBDOUVKNU9DVXUrMXNOcys4S2E1WG1vSGFoUXpPb1NZ?=
 =?utf-8?B?amhIN3cxeFBDbCtnRDQ4SmNVNHVMMDNtVXRjTjRUOGVGNUpraEo4OGVucEJP?=
 =?utf-8?B?TkF2MklCaEVBdTJuYTNOUlhCZEhISFpGSktzY3dZUThTbE5OalNiVTJvZ2JG?=
 =?utf-8?B?Q0pKNTBxbVpyZlAxWDBNUEpERWx1U0JvN1IyYlVpU0lEcGduSkZwZk52aDBt?=
 =?utf-8?B?Ulh2bnZWb3YzZ3NoZ2dzSG1vclYybnpJcFViRHJYWkU2d0E5RnlTakJIdWl6?=
 =?utf-8?B?SDJwbmlpdG1XUjZQVUVlU2V1TklqZDZtbW1yRzc3UUpFdXIzK2Ixd20yMGJj?=
 =?utf-8?B?NGszWkhleWRMUHFLK2NRRHlzdTc0dWFzZ2tkcTlJMVJBcWFEUjhKVndZQUtC?=
 =?utf-8?B?OU12djFQSVBuU1pTc0VJWnJ2WHo5SEx5UXJ2bWFrNzFBMEhQY2Jsc1AwYzNk?=
 =?utf-8?B?anoyZVo5S1BqRUorbDRBTzZvVW9GUXk2VW9aWGhaYjlNN0ttVi9mUWY4ditz?=
 =?utf-8?B?N3JhVkFpMVRrU3dVK3lNc2VaRHJaNHh6UmJQeWFuUU5hU1NDRkUrdVVJQ2lB?=
 =?utf-8?B?bU8yaDNOK3l0VXh2TWNNbHowWExFZE1rRXp1MVY2U2llL3hFTTlNNWxCU2Np?=
 =?utf-8?B?UEVzTzVVakdYWk5HV3d6bmYvWDhPdnNHeFpySU1jelZTV1hUaW1kVDNLSkFW?=
 =?utf-8?B?OHpubU5wYzdSZVgzbC9qTk5xa2RqaDN2aVVCWFd0dlVnZVQraHBpZ1U1VmZz?=
 =?utf-8?B?b09keEJTcVNQVE9FT2YveGZpZE94MmhFZ3J2WXVDRk5LckdVQ29UVjJCRndN?=
 =?utf-8?B?ZGVtY2pWU0sxSHpjQjBZemsrbXZIL2MvcGkzZk9NMnFtYThCU1dHazNrMm9R?=
 =?utf-8?B?S1k1T3NwdUQ1b2IrKzcwVHJFQ01iYkNEc3JrMVRaUDduV1hXeU5pdGEzU3BJ?=
 =?utf-8?B?STJ6WFpCZkxKWTI0VUZJTmFOWVJON05pdUZheGl3S2xqRVJOYmJWSnB4MnVu?=
 =?utf-8?B?NkFuVmZYeWRPb1NiUFc0TkF0ZFV3LzlFSVNRaThyaGdHcHVLOU56a3llbHZz?=
 =?utf-8?B?bERzTEYwUDVCYUNQNHpNSWJBYmN0bStFbHJvR2RLNFJIMDVVMzU1blpxcitw?=
 =?utf-8?B?ZzJKS1Z1UTdySXAxWEZ3QWVRUmx6RFg2WEU0VGszeXRZMUdFZ0lHNWpveEkz?=
 =?utf-8?B?M3VISzBJNDVQUUwvbTV0aFpyUFM0K0t2MWRlVzZtekNyM1FHVFN0dTFKdGZN?=
 =?utf-8?B?SEE5ZzFIN1N0TGpIc01KTTNZU2xxWk1Pd3ZuWXVtMDdvbkhuNmdBUkxFWUJM?=
 =?utf-8?B?cGpDQjdQNFRibnZFa3FUQUtTaVhUSU9WUnQvWmdpRjVIaXJ1QVFlZ3ZxcVdN?=
 =?utf-8?B?TEdpcFZSeUpsZ1Q1OFcyclZQdkhkdEttYkE2T3NDRWlxK0txT3d6ZmpaK2VH?=
 =?utf-8?B?ZjFvRnEyL0Y0L2RNVTFGQnQ3VzhKZUo1aEtZTVRMdXlnNUowRUxIRURLTVB1?=
 =?utf-8?B?WnlHMVYyQUs0aHBlSTVEYlY4ZWdiLzlFeG1XdmdrN254TUdQc0QzVDlRQUZR?=
 =?utf-8?B?VGlVanNGN0NrSGVIWUlYcHpMa1VqVjZtV3NQK1Vac3k5L29heHhIN2NnSktG?=
 =?utf-8?B?eFUxWm1NVm1HRkpQUWNSemN2K3R0OUdSb2xKNmwvRFRGNHRjS0hwaVFoZ291?=
 =?utf-8?B?YzJ4NDhzcHExbzBzOGF2cHVhWWtNTk5Rdy9hZFhKaSsxaXRRdzdrb2I1TDN3?=
 =?utf-8?B?SnZvWkNycDcxODhZSytkck9NYmI5L1FGSnBPR2IyekZMcldHaUhBU3lWRnc3?=
 =?utf-8?B?TzBOUElPdFdvSlg5ejFSNXRwZFZKYUdwZ2hCdk5pTjNsTWFXUWhWRTVmd0tS?=
 =?utf-8?B?Rkg1TXRzbXZDMllWSk5MZnMrRnU0N2RhV2swRVRUZ0NuM0Y2RUlvKzNRSlBV?=
 =?utf-8?B?M2pnSVJJR2Fkc2Z5aU0zRUFxMEVDbjl0elBxWlRORDE3dWh4bnc2Y1BrWVlt?=
 =?utf-8?B?QVJSc3VKcHRtL3AwV3Z0d0RJakh6UTFmSHVVbEx1U1VuT3FDdjdOdklVcmMz?=
 =?utf-8?B?bEcxdnF4ejllZlBidEYxM1o1dzhpblNSVTRySFFGbUI4R1ZpWS90L2kzYXVs?=
 =?utf-8?Q?JlLq0R1dDd1Io6X9EfZfdAH3vnudH0oUuIKBJso2aYit?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cLb+wfaarqmyFla2nqCt+l0K+TdyzM9pHGfe6GWUPp3qxpJp/0e8tdfWJnzkYPZ7CcmpkA6RwbX2YpyMiR4MxeidfkFEQ6Qzw+bcddCugpJ0pWjeDeCo6dL4Fe4SE7NuTGhy5GJHcwY9Qsr1bzZa7oXNja2jjoLUuT5ri9lJuf5MaozYUNFSElrxIjQuReKFvUNGgElTC81Fl4IJgVFiNO3Db7ysyC+l2Sg2g+obkcEn66pCjpbypiRzx6fTF9LhAVZTCA7LW7sHM0TqHoe+r1PGpRbb03CZvxzbbScjnzdAFlZ+1RJB+4YM81gPulxFDntYX4U3T7WLRWdNFCP+dcajTZD2BLBVP8eKmnJBVbVnz+/Eaki5k184jLLI+7s/u2KSf8Trgu5NQ7kY1ONxKdEyi5JfDqxKn0kf6dan+5wS5e8CsqWsADbaXnMIH0fqiVp7l8WS3ot7Dex6+HP6xFGvRQl04tAv+XI6whFyJZ0h9XmDtxEYjqlGtYzSpMKm2N0vjZROpzVX+TIt8CcZmbFT5Kfn/MUXJGixY48VbMuivr//Ki8d8QgEWLhPciys0K36Iioc1NMq1OylPwos07PJ06vdhvxACv24Sn/JRpzQGRC8t+HImVJroNNDah5/V0bnVhwdDBEbi9tl+3UQ2Q==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3050ca64-e09e-4520-ddd2-08dd3c9780ad
X-MS-Exchange-CrossTenant-AuthSource: CH2PR19MB3864.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2025 16:52:35.5558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sQ2XymPahFsSDmRe/zgOal1aKDko5RSlcjCphZHY28BZqzIKfzOAXowijNkGieWPvKGJGVp0bkBWCC2+So0OzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR19MB8402
X-BESS-ID: 1737737557-105237-13553-10154-1
X-BESS-VER: 2019.1_20250123.1616
X-BESS-Apparent-Source-IP: 104.47.56.43
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoYGFqZAVgZQ0DzVLCktJdU4yc
	zAOMnANNXCJNEoxdzIzNDSyDzZwjhZqTYWAKzxL25BAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.262028 [from 
	cloudscan11-243.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1



On 1/24/25 17:46, Bernd Schubert wrote:
> The timeout optimization patch Joanne had set ent->fuse_req to NULL
> while holding a lock and that made me to realize we might have
> a problem there.
> 
> And based on that, I believe we also need to set/read pdu->ent
> with write,read_once.
> 
> Cc: Luis Henriques <luis@igalia.com>
> Cc: Joanne Koong <joannelkoong@gmail.com>
> 
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> ---
> Bernd Schubert (4):
>       fuse: {io-uring} Use READ_ONCE in fuse_uring_send_in_task
>       fuse: {io-uring} Access entries with queue lock in fuse_uring_entry_teardown
>       fuse: {io-uring} set/read ent->fuse_req while holding a lock
>       fuse: {io-uring} Use {WRITE,READ}_ONCE for pdu->ent
> 

Hi Miklos,

I'm sorry, more fixes, I could have noticed this before :/ 

It would be possible to squash patch 2 and 3 into the initial patches,
but is hard to send as patch series on top of linux-next. Please let
me know if I shall try to split it further up and you you those
patches with instructions in which order to apply.


Thanks,
Bernd

