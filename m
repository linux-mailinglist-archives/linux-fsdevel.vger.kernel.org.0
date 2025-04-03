Return-Path: <linux-fsdevel+bounces-45644-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B277CA7A364
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 15:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23E107A70AA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 13:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81BA24E4A4;
	Thu,  3 Apr 2025 13:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="vqpYafxw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip191b.ess.barracuda.com (outbound-ip191b.ess.barracuda.com [209.222.82.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A741C861F
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Apr 2025 13:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743685727; cv=fail; b=lN6ICUdTuLcMFhLeWcNu6bCkVD8lpOOjFiOMf8GmMwpuWunJHNZgiDJSpUhC8QNnZmghYfIc7aC2BSJWNMF00J5NYTJOP8kvt4BVDvtjsrSYyhGzI0sAxThE61burWlHC6GbShFhAf16GecYZcrM2p2OOhBxrTaBiT6YX68+C9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743685727; c=relaxed/simple;
	bh=3FIE/OEnOC91yaR/JpExPGP+Dmx5T5ITt1hbP5maatw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=G0um5cuW6k/1IMekaDJ3AJqwttAr4Xf/aUo9VwqEOdABMUUR8nTFTQIl85fmGQxeXdnsfjGGPMArYkyF6/5WgtykLMBhoKyN1uGG6rvW/q4xG7HDYk2Doew5VrP25Xjj92+ww/4ijuJw6AsPheedGYT+LuNk4kehiakkTfLuWks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=vqpYafxw; arc=fail smtp.client-ip=209.222.82.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41]) by mx-outbound46-141.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 03 Apr 2025 13:08:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tB7qBBR+oPT3ZMp3K56d65lLqix6AYmVIsnV3wlI4pbq3rT3wrH4ddYl7Rdd6kD3SOhHNE58FJMKjK/IP3bmjHYCA+NiQQgMt4aDylchMYU+uo1nW1jdRbuqhX5Ef/6JLFSZZ1dwZrVeXN3HV8jVR5gfqaqFiB0C6nqVm7Rf/5/B3euz+vpk7aHizLXfiR3tl7VbIz9UoY1NAWtsahCNTrJlJ3QYAf45ms1a91/+L2aMxjVcAuiPs9n+dFNF01hfhcZfUB/KJJPpAXcYt1d6M2Byi6ZFhzbSAp/QHvavRwT9w4Ud3Js97So9k+20JjrPb/+TMw6upr1gqDlnfh7ATg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KBBgw8Sx5M/Z4VEfCQDILD/nnEwN04u2ER5Rhjsyi+A=;
 b=rWkX9SoDfKCDXsHiR4f+eVRT1n7T1Q1Xl8OupNVr2JifemPLLn1SYAU7RjzuMBoXZuRF2/lazKudrf40IbW1Rfgaazhuvwz7jcsH1IEIs04uNo45VMjTXQIPWSSS4yzqWj0tIA0ngDdINkTj7Uh97yRnfuSX0yz+XZlzwmvwy3KhUBs3wnUDBNtJBLmIaooH5X7CrqJcEP1cqeraiJffOE/cZyPkip2iIxpFwBEDH1FcM1lazzQZlaWZZaSLJFeCQKToZ9OCErJBQgF/UmTbyuMyqoMOjyCnZVbxeHWA3UOP0dZK9pEkvb75SV9MndMjGS3PgjJPEDSheMyuwB9Nww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KBBgw8Sx5M/Z4VEfCQDILD/nnEwN04u2ER5Rhjsyi+A=;
 b=vqpYafxwSS0/1E4TnGHxuP60U+bumSSbIvec7dBTvGGz4qcVIorBjzV/Oz19jf8zkIGQh7JiFRrO4PWCPHiJTebF7K4soT3SQnSVDD+ceoJlBnQymRdd9BFl27DV8ARhrH7BJ49FbULQsmHxiiHrXKEAQrCQroZZMLRyohMUoQU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
Received: from CH2PR19MB3864.namprd19.prod.outlook.com (2603:10b6:610:93::21)
 by LV8PR19MB8323.namprd19.prod.outlook.com (2603:10b6:408:1ff::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.43; Thu, 3 Apr
 2025 13:08:29 +0000
Received: from CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03]) by CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03%4]) with mapi id 15.20.8534.048; Thu, 3 Apr 2025
 13:08:29 +0000
Message-ID: <1c02b0d4-f8f9-4f5c-b9f8-d9358ab68474@ddn.com>
Date: Thu, 3 Apr 2025 15:08:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/4] fuse: Set request unique on allocation
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Vivek Goyal <vgoyal@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 linux-fsdevel@vger.kernel.org, Joanne Koong <joannelkoong@gmail.com>,
 Josef Bacik <josef@toxicpanda.com>
References: <20250402-fuse-io-uring-trace-points-v1-0-11b0211fa658@ddn.com>
 <20250402-fuse-io-uring-trace-points-v1-2-11b0211fa658@ddn.com>
 <CAJfpegt5VGcSPOFA10YhGq6W+pZR8m+YEfhLSL8uFbJhqT7kuA@mail.gmail.com>
From: Bernd Schubert <bschubert@ddn.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAJfpegt5VGcSPOFA10YhGq6W+pZR8m+YEfhLSL8uFbJhqT7kuA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0510.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:3da::13) To CH2PR19MB3864.namprd19.prod.outlook.com
 (2603:10b6:610:93::21)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR19MB3864:EE_|LV8PR19MB8323:EE_
X-MS-Office365-Filtering-Correlation-Id: dcbd79c9-732e-48ae-90e3-08dd72b0a0c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UHpzK2QxbWwzMkM3eWRIcng3WkpSSERRYWJYYUgxZUZXeTA0NHNmMDFwdk9t?=
 =?utf-8?B?a0I1bzRqd0dlb3RTK1huTjVUU0puNFVQdmVjcVlGNWNvdWprcFVVQVdzb2h4?=
 =?utf-8?B?elBoUHNDMFlEbkx5ZndkMVJGeU04Q2lpbDVJT1A2ZFMrS3VPNmJaVWFBUWds?=
 =?utf-8?B?aXVxd1h0cXV4aXhkZTE0RVRaMUR0VUtJMWUzckZwN01TOFJtaHVEcVczaEZF?=
 =?utf-8?B?OGY2UGhtM3h2d05sSVkzVDF3MTRxMFc4cGxJK1p3NzRrMWJ2a054K2w3eEF2?=
 =?utf-8?B?UUhYdFBydXErVkhyNE9LVDJtd1RvMDlkSHBicVdZZzRUMnNDRDdyQmFDQzN4?=
 =?utf-8?B?UFJZRTRPWTNQUjZlZDdkQm9ZaFNhSloyNVlUQXlSbC9yQ2ZaSFlLWGg0ajEr?=
 =?utf-8?B?bmlCTThaOTdUU2ZCMThCQXhnay92M1ErQ2sxajc0VGsvb0N5SFpLZnJBQS9V?=
 =?utf-8?B?bjg5OHh6eDBZVG1pM281WDBYRzNmcU1hcWJkVnRpdDBxTmovcHpPb3JnbVl0?=
 =?utf-8?B?dWJWVEtyQXBNL1Bvc3NUWTBvb3d6ZEtrZjVCSytOSWhxMndOa3VndzVXL0l2?=
 =?utf-8?B?NlJhYzhoeFJLOE9MbUFmVE90Uyt6NUYzbDIwSlZpYWpmMkJtRExCUnVkem5t?=
 =?utf-8?B?OUFGNThIU2pzWlgzcVppU1pJNC8wcERSdlJoYnNLTGxDOWtpaWhIbkwxdCt2?=
 =?utf-8?B?K2hCNTBXNUpOUmJZMFpiR05oMW45V0RWS0M2K3RiQ2NhakZYYWx6QnVrUEZu?=
 =?utf-8?B?N2tqd0l2dW82VHA4bWNYRDAzMThLeUFEbTc1MGZiZHI1Szgzbm1uSzF1S2Fq?=
 =?utf-8?B?cjNFNm1zQ21ya3JVRWZUOFRMdDkybkZxTDlRLzFpanl3RXYrc2RDZVdSdytq?=
 =?utf-8?B?U2ozOWNveVpjdnhnajFMNFFOQVBhMmxSbVFybDZEN3ovNUl4YlZBaDc2cUtB?=
 =?utf-8?B?Rkl1VUVDVW9qM0J2UjRIT293ZVZFSWJyRW9JK3JITTNVdmgxb1dBRjVaZW54?=
 =?utf-8?B?OUNnZVZZN2RUYWc5cXBUUlkwWGtDb3RpR1pyc2xLSmRybEZ4WmZEM3JkdXYy?=
 =?utf-8?B?dVphRUx3dFZQOVBqaERjZHJVcENiTXRlSUNiUms2OVhHOS9nbUZiU1lXa1Nm?=
 =?utf-8?B?RmpYaXQyamFKelJEV2R4bWgyZFpKRk5naXRjcElEZnorYjgzRE5HdDFWbnFN?=
 =?utf-8?B?c3hCTE9CaGtKUDJWUzVXQThkeHJCYzl4T0E4UERPQ1pxbEJqS2FNVWx5a2E0?=
 =?utf-8?B?Q0JycGgzc3MvaGhNdDdpQ0s5OE4rSXlSSGxyOWpLMHpESUZaMVhPN2NVaUZI?=
 =?utf-8?B?MFRrc0IyR0pxSG8wUGFJSjhiSXVwdUNSK2pWM2RaN0h0SlZ5NGNjRE9obnpN?=
 =?utf-8?B?c1FONTllRmxCOWZsblRLZ0dtWWx3N05mL2lueDdYWTE5MnVYZTd4MEg3NmI1?=
 =?utf-8?B?SE9nVHVtWGtoeVJyRE5mQzQ4eWI1VE1NVXc4Wmt2MXJ3VTFsRmlmbHV5YXIy?=
 =?utf-8?B?cnRWenBmSWdUMG0waEhrYmg5T0xWOTd0R0IyWmRxQno3Q0xuNFJ6ZnZiVitP?=
 =?utf-8?B?V2pkeVJNeWRZS0E0QkRWeGhUQXpqZ0pENnBjMUROV01hK0ZuaVpNU3dNbVhn?=
 =?utf-8?B?dHgzTTJUZkovdUNPREF2djYrQ3B3TnB1aFRnYThuMVdKOEMrR2lnUEgwNkVo?=
 =?utf-8?B?aFhRMmFpT0RKRFB1ZE5aTm9sWnk5aFJJdlZFZ21tamxKaWNHWGxDRXpvS05r?=
 =?utf-8?B?MklnSmc5dU4yMFZKUENyN2ZYcGRHdUlaY0VrTFdpOWVoQXRobVdGSmtYSUpS?=
 =?utf-8?B?UkJPc2ZIelNObmxwVGVhOHlQdjE4VjNOQmJIY3dnRjhjTWNQUkd3cDdWVUdW?=
 =?utf-8?Q?jH8TMvPEmbVam?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR19MB3864.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aFY1M1NBVmlzRlRzeFI5a1kzOStqTll0alV6SFdRN3ZBeFZtR05hZzBpZVZT?=
 =?utf-8?B?KzdLOEtUY2w3NDdOaTk4S1p0eTl4SUpZZ1JVZ3hESUN1cGhaVGxaeDdlcDRQ?=
 =?utf-8?B?OEh4N3B5VGpxRmJMbVpPSmJCQkpPQVdjckhOVks4QXdyNkZTQ04vM0YyUGxi?=
 =?utf-8?B?YVBSRU5MdURSWTJUQjM3anhtOUhnUXJ2MDFqNk03N0xEWDBvOHNLa2owNzBL?=
 =?utf-8?B?c0VjRjA3VGMyYXB1YlQyUzdTcHFNQW5MTjU3ZjBiOUNHZGUyZmJMUFpNa3dO?=
 =?utf-8?B?WVR3dXJDM0UwUnFmTkZRams2RjU2RkJTVDhYYUN4L28yMWU4dVBQbSs1bmtB?=
 =?utf-8?B?NVRBVE11K0RMUkFKVmFNR2VCUmhPVUVydkozREZZVWRPUWhZRkZrM2M2QXpq?=
 =?utf-8?B?RHBmL0FPejlGNGhCRmIvemlibDJCSjNpcW5YWkdyQ0FCVWhIQ0poNjlLQXhr?=
 =?utf-8?B?TjFDSkV4RUNDRTVXQXl5MWxDWWlyZWltUGpUdWxOdERyNVlhSG9FRDlDSS9C?=
 =?utf-8?B?LytSWDNYK29hVkUrYUc5cUxnWGVzVDZVTGk2SnViTGVib0ZHR1VwdG5xWDlT?=
 =?utf-8?B?Wk0wRUJFNHJXdG9hVzRhYTR5NWxFdS91NUd3NVZyVm9ZRnRZckU5c1hETGNI?=
 =?utf-8?B?ZmdJY2tqRVpxWDllYVI1YnhqRDlpZnNEakJpQU50UjU0N25QUHpLRnBzMlBM?=
 =?utf-8?B?N0k0LzIrZkVaMHFRMnRnbHlGa0xKZzRLdDkvQmZtVEhGZTQxc2hWM09iK2FZ?=
 =?utf-8?B?QlNoVUxzYXpmVHNkaWxQaU1lNGlQRmRlYXg2cGxCRndnNHJ6SUJEcFVQZGlj?=
 =?utf-8?B?RnpUZytCN05XUDI2c2MwbnB3Q0F4QmZZYnExWUl3TnVVeTlHU0dtQjcxVlMr?=
 =?utf-8?B?ZGkxN0x4WXlFZkNPNGVMWlF6SVNpWjJkNjlUOURCVkpKM2pHSDE0SkMwWHEz?=
 =?utf-8?B?ekNsdFQ0SlpTa1I4Z3lsaldCZEEzNU1wZkNnN1MzWDhBMkVCYWVwUEJMOGMv?=
 =?utf-8?B?L2VkRDZ3bjkvZHlyVWJKRWgzVWQ4YmM5UWh4b21hQUFpS2lXU1BBN1BVUmFi?=
 =?utf-8?B?b1FtYWJhNTFlMUI3WUhrdFJpMEg5c1Uwc045RUpXNUhic3IrbTVyNmFWYnNh?=
 =?utf-8?B?NUxEeXBEL05VVjNiVzd4SVFXWjF2R1dTclVncDcxSmQ4YXlLMTJabEFZbnVK?=
 =?utf-8?B?Ykt4U2hzSEFCQkhVZnBPRFBoazBQb0c2NzY1djRrSWJLcDlFN1dyMmRhc00r?=
 =?utf-8?B?NHVlTzkyTkttNTVGMlRPeG44Sk5ZTHBKZ1o4TC95L1JPNWJjcTlDanBYSUNZ?=
 =?utf-8?B?Q015WUlBZENJQng5ZGV2NEJzZlh6VDJkenMrM0dQTXVOUXFiU0pxeW5lR01T?=
 =?utf-8?B?bDI0aEYrL2lPTWVhTmhzQW1teEkxeW1MU2lXdThvYk1VWk9kNmR1R2dEc3dS?=
 =?utf-8?B?S01IeCt4YjNIY3VDU2w2eUlwSHVHaXRyUVRkRWhBNHQwMlhJOVloTExOVDE0?=
 =?utf-8?B?elo4a0JIbzE0TEQ2a3hBakJQTU1WTkM0alJlZXNOQUVEdkl0VWxIZ0hmQnNR?=
 =?utf-8?B?cUFQQmMzOEtyUHhtLzBubWFlenNFeVUvanF0SFlydDlMWGkwdkVHSmhWWHhS?=
 =?utf-8?B?SzYwZ0VjU3h3L2VJRDZ4MnIrNVVpZnc5YlJNc2R2dnVzSUpsSytDWGtXNDhw?=
 =?utf-8?B?UUFFd3dXWFVzTUovUVJhSEpWQkU0d1JUMUd6Y21Gcis5bTdqNVVTZE5LTEdj?=
 =?utf-8?B?dnpheXdrTjVXalp3cS9sWGFWNXZpNTduOGdtam5KUWRaem9kaGlXOHd2RWUw?=
 =?utf-8?B?Q1dXeW1pcnM2azF4ZE9LODQ2dkVsR1pnY3dVNkNYR1RxSmhwaHhPQUFnWUxC?=
 =?utf-8?B?WTNOMlFiYXJsMEdwL2FacW96SHdFWUNvMWVyVHlwNE10b2pPbk5KMWRWem1s?=
 =?utf-8?B?OUZ4VTJmajR4NVVOdXlZTzVNeFhxOURZRUJkNVFPN0ZEcmd6WGljZ01OdlBv?=
 =?utf-8?B?REpML3JhZTlHdkNUNW5WTTJGWkJES0x0eFVFU2RwNjFmd0VHZ2ZKalcvc0lz?=
 =?utf-8?B?Mmd2b2RFSHRKbXhUTGR1b2xVYXZuZ2pNcjVoaGRMT0dOMEllemE0Zjh2cU1I?=
 =?utf-8?B?K2NkeUcva09zVE1rRDJFc0RDZk04MkI5MUpRM0wva2Z6bFEybmhwLzc5V2JF?=
 =?utf-8?Q?w2/AwFoYvdqMLZLuZ5OBbTdAfzn6OY4XMaiejUnabsbO?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3ltEsxRJqiITE+LmC4Qk6gmFi9J3wOFz+obrTD0h5IN7mPihi6WhCCmyEd8Lvlo16iDp40GVsVj6daL4hJ+/N5RbGaJ5ReIdUasr7IWB6ZHy09mIWyRnaWGWIIc4qxXKX5eFIeM2YAnHQeqpmsfjULf7ryeqF7AMNVuP8gL4lnbwtwXGHDZRx/yF6Giuquq99aIIcUX5hM3eR5z89xIln5JNNIt5zyhDRVZmWmDQj4f5K3od21x72SjMsHCHwtsBZU6wJp+KLjQI6QwmuvZjjOh7YylcFvoNmX0s8NdEBJCswH6BcmaMB1ajWTpl0j2Kzc2FiJva7pJELgwwBqO7SD9Nqqps4FYIAA1XTQ3syHQ5ay1Yr/sgTJoFhShemda9jS/3u8oMW2C+02RKuyN5hRnbFHefq6iVeSxvSj4YPtjcq5jFPld1T5gd9U+Cwsoo8RCJDNhcB9eDZNjwbDAMCRVfMBkT1vidXaRPeJNOtVj9UF3caDiAOxNaA+hAWrkm2Uz9eFSOrJ+Vc3u0mTJsTlgMb43FLyV5hHW2rue5xwB3/KTvbTj3Gu+/7vnvgOyVi9r1Uchp4AsmpeJb3zdnYkYDvGfrW6Mxv8zrIKyfoGLw/3oViYeyDU/JDJ7szHL6fN0oz+jQaPwAs6EkskBKFQ==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcbd79c9-732e-48ae-90e3-08dd72b0a0c2
X-MS-Exchange-CrossTenant-AuthSource: CH2PR19MB3864.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2025 13:08:29.5926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TKLVqwvGzb3rGvf3CLdSNQ6Yq9I71bBtRL0nh2NRoe5wFakQMsVrNWdLEL61LFWQaivdsFEkuLUXfTTDdftccg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR19MB8323
X-BESS-ID: 1743685715-111917-7672-1049-1
X-BESS-VER: 2019.1_20250402.1544
X-BESS-Apparent-Source-IP: 104.47.66.41
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVuamZkBGBlDMwNLcwtTU1MzC0t
	AoMSktxSzNODnJ1NAsxTQ1zcggMVmpNhYAufCesEAAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.263622 [from 
	cloudscan16-174.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1



On 4/2/25 20:33, Miklos Szeredi wrote:
> On Wed, 2 Apr 2025 at 19:41, Bernd Schubert <bschubert@ddn.com> wrote:
>>
>> This is especially needed for better ftrace analysis,
>> for example to build histograms. So far the request unique
>> was missing, because it was added after the first trace message.
>>
>> IDs/req-unique now might not come up perfectly sequentially
>> anymore, but especially  with cloned device or io-uring this
>> did not work perfectly anyway.
> 
> Well, we can try in any case.  It would be a pretty insane server that
> actually looks at the h->unique value, but not impossible.

Should be easy to revert if someone complains. We could have
another (and for sure per-cpu counter) and add that
into ftrace output.



Thanks,
Bernd

