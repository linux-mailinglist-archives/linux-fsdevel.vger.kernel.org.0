Return-Path: <linux-fsdevel+bounces-29446-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED964979D2B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 10:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 513E2B21E71
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 08:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC2F143C4C;
	Mon, 16 Sep 2024 08:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="TWbzMK9K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38420F9DA;
	Mon, 16 Sep 2024 08:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726476467; cv=fail; b=SPKj2wJ8TcsCMgc3mbtFUH1fn22uc97UpM8SGgNyn1mt9jOV4BUXnQ+U/EIzSEh3RvOHKt3BbZX4ze4jvftIOS73+nUFUohFuEIcAZZmfi1Zvx0SGU1aQ1VWa0rX51HYInhAhFGslSrBfuI+EaopvAltJJ47bz/PXrGbJgsfDh0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726476467; c=relaxed/simple;
	bh=FIJ/K41UxhvOsAEBdrRJq2lQlX1raKV8MWZiddPZHzQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=M+zKJ9BL7HTdYDs9wYF4XINQRNESuCkM9u3zCswF9sGXpTSAA+lUf4GG6u0HajZtB0+b0h+eWg6v3JOUSuZNWwBlgF9wFYYRj8TA4EO8Phm6naDL/nlv2duTLk0gLWeA87iO2IGq9NEawpf/dQ3ody+Z7IavZzy6ifliYgMlnGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=TWbzMK9K; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48G1bdqK027506;
	Mon, 16 Sep 2024 01:47:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	s2048-2021-q4; bh=AU6RqrMguJdY/V3htHOD0JepMG7JsyhWGmq6KSOR/o4=; b=
	TWbzMK9K+IuGnZVfJN/kJhx4/m/vrErunz7uRjkwIu3jadxotx7pU4uTpZXvIKEr
	6KkyTckOzhyvhBA6e4w+4BGdmWv5ub32b2/XA+3xFR47W7P1l7q8PVTYC11cTXkq
	/eXXNIoKsM2IEuynTQTjUaoBPepWW/5GDXJeU5J7fuCvGLxoNiRlvkvZBnqHHKde
	hEwjjxKeA6D+dD8xKK+y3iE7MmlIu7aIZYm87QfvI7YghSqDq0n51HmB9esoqHua
	kKIyTL8XBu7gmO/fiAcX/vFejeP5ktRDithNwyiwNw3qmqkrfTCJ3G8LouQhtzy3
	zDQRA/7mwfGfi2pX44GskQ==
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 41n8arxewk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Sep 2024 01:47:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KJmmuthwj8blT8oVgEWa2SSBIJoctu0taeZjqkUN7evNih+lq8o68wC3Ipcl+LFOINLrhoh7sp7M4Z/Yg34902xVX+xoNNcJeGvk7pN5H0Fy06e+BLl4wgM+y31bkdszrwhZ7IBX/n0SQrEqve/qa1KhNkH/yhFwZtMcU3uAwx7a6XclEYYy8CHOM9/cQNcgF+1mXkzxWtx5vXvQ7FWdIxOIKCMJFh6ZlisJzNg8I8wdlL1Nyvi0wLqvVHdiPl2/EIlWDuXWcnuAHqAfGQWrJWR5dhtzK+QcRTX3jFGu+DDdfX4dT1sHaYAN7/q/wLGM4lwalZjghCefaZ23sjPhQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AU6RqrMguJdY/V3htHOD0JepMG7JsyhWGmq6KSOR/o4=;
 b=RI5eV/CJE2AC0Ll9CDFbvkNUXFauk6/qLGba8wiVkd1QbdbTX3DbowYxsQ0pK41KcZzdZ7slTE5YpYVYPwr2N6W8ceZbSDjArJbEv8CZoQNn20HHOSjNe45lQ4u/JILTiX6aFuTjWzHf2A5A/L0f+PzAeylbTTj0/rC6TOum8m6Sz/u9qAn69tJ3g6yQSy4qIpJd8IgnrF+pkyhkwynv5zcEda0QHobvN+AlVQtqg8o4Zn1+Ehsquy2xbpByHjjmyWFkv2A3w0NDIH3+8l6hnjxvMMYX2Wvjun1igczLjnAxDd6st+x0u811EtIbNcZenEe62oI7rMnoC0/HkwIFrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from LV3PR15MB6455.namprd15.prod.outlook.com (2603:10b6:408:1ad::10)
 by SJ0PR15MB4186.namprd15.prod.outlook.com (2603:10b6:a03:2e7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.23; Mon, 16 Sep
 2024 08:47:21 +0000
Received: from LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::740a:ec4a:6e81:cf28]) by LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::740a:ec4a:6e81:cf28%7]) with mapi id 15.20.7962.022; Mon, 16 Sep 2024
 08:47:21 +0000
Message-ID: <74cceb67-2e71-455f-a4d4-6c5185ef775b@meta.com>
Date: Mon, 16 Sep 2024 10:47:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Known and unfixed active data loss bug in MM + XFS with large
 folios since Dec 2021 (any kernel from 6.1 upwards)
To: Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>
Cc: Jens Axboe <axboe@kernel.dk>, Matthew Wilcox <willy@infradead.org>,
        Christian Theune <ct@flyingcircus.io>, linux-mm@kvack.org,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Dao <dqminh@cloudflare.com>, regressions@lists.linux.dev,
        regressions@leemhuis.info
References: <A5A976CB-DB57-4513-A700-656580488AB6@flyingcircus.io>
 <ZuNjNNmrDPVsVK03@casper.infradead.org>
 <0fc8c3e7-e5d2-40db-8661-8c7199f84e43@kernel.dk>
 <CAHk-=wh5LRp6Tb2oLKv1LrJWuXKOvxcucMfRMmYcT-npbo0=_A@mail.gmail.com>
 <Zud1EhTnoWIRFPa/@dread.disaster.area>
 <CAHk-=wgY-PVaVRBHem2qGnzpAQJheDOWKpqsteQxbRop6ey+fQ@mail.gmail.com>
Content-Language: en-US
From: Chris Mason <clm@meta.com>
In-Reply-To: <CAHk-=wgY-PVaVRBHem2qGnzpAQJheDOWKpqsteQxbRop6ey+fQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0104.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:23::19) To LV3PR15MB6455.namprd15.prod.outlook.com
 (2603:10b6:408:1ad::10)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR15MB6455:EE_|SJ0PR15MB4186:EE_
X-MS-Office365-Filtering-Correlation-Id: 71f4df3f-6adb-4aa5-cace-08dcd62c2dbb
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cDhjRDNYbC9ieVdzWUpvdUNvNlpUd2pDWHQxelNGYnZoeHRDK3oyaGRQMjNq?=
 =?utf-8?B?LzZXc1pUNGNuR1R5R2ZkY2RGb3I4NXZ4UUZwZ2tLYzRJZ3VzTm42MkY5TVZN?=
 =?utf-8?B?Ky9zNCthODFBMDhYRm5LOTgyd1JZWHBKcjladUUrTlhiTUVEMVJFRHpjV295?=
 =?utf-8?B?YXVSbTE3aSt2Q1ZqNHdCUWZMSG8veTFtTit6T1NYK1hhakw3aHpQb3RjV011?=
 =?utf-8?B?MExZOUE0SytQS1ZsMlJwSmg1bzhNYmxYdUsrRXBReVkyNTljMUJNZW5JZ1Jk?=
 =?utf-8?B?MkRwcjVMbmdPZG9BVWdVdHVCTXB6dlpONmZOZ2w0VitRWFR2SzhZbFZ0SG1l?=
 =?utf-8?B?WFF4amxNSG8yM29ZbGxpd0ZHVlhqRnZrcWkrelltamFaSUMwb2Rvc3ZnbVZH?=
 =?utf-8?B?Z2d4ZllyaGtvcUNkTlBKK3FMYTY2RmJObXZvdWIvb2dNenJxcmQzT3RjTEJU?=
 =?utf-8?B?NmdiSkJ6U1VsOGJibFZRRUNsTGxNS3pET0ZxOTdpbjZHNEErMnpJZERmUWcy?=
 =?utf-8?B?Q280QjVjM1cvamJQd3d5MERIaldlUEZLd3NxYVF2Sms5bXlJYUpYYzBhSCtn?=
 =?utf-8?B?UTZGQzhPdmo1WnN0emNJRTlibzZrSThPRnJlM1JZMVlwNXFLdzlWVWcrTXRy?=
 =?utf-8?B?VGFQNENuMWNPMmV0aUxFanVWRTRONFIrdG5qaXVQWHFLKzlNVTdYaVgvNG93?=
 =?utf-8?B?b2FzNFFYMjVVeE1BZW4razEzSDMxaURzVzlyT1NickJIU3hSMEFzdVlvYlRU?=
 =?utf-8?B?dXI2Y05STjJpZkNHaWlNY3pCNVNvak5sYkxTMWl0a09FbkU5OEV4bU1YSHZQ?=
 =?utf-8?B?VFNpSmxMY08xYVoydW5lYXVLNmNTd0VVZUJ5bFYzcmxveStKdUJIMlVPRnN3?=
 =?utf-8?B?a1N6UGNGOWlUeTFwcU5pZVFxYThyZUw0alVCMXJvZmkzS0ZQT3BEenRSU0x3?=
 =?utf-8?B?N05CS2dWblhUeHlBNXdaNm5vYlBONGpCS0toVWpadmgweFpDajNZTnRDRTJs?=
 =?utf-8?B?SVo2TFVRK1pPOHlIT09lOFJMS090cTU5am1SaG9HN1NCOVdGL1RkUUtLMlJr?=
 =?utf-8?B?eUwrdXpKVXRhQlc0R2VQdXkzdzNHV3B3VkYzWVZ2L1pObXNxdERFYndOZUdr?=
 =?utf-8?B?MVVObXlWQm9sWlhLb2p1Z1BtUld4OWZrOTdSRjdqMExqclJnOWdDR1BqRU1H?=
 =?utf-8?B?NlE2WUkxWU1mR3hRelREQzlIcmozZEc2QmwzSThjdXR6RXJkWkpSTVVUWWZ6?=
 =?utf-8?B?TGRhMmMraFR3SlBmeGc3MVVqMEkvcklWZlBVaGsvSnMvR213b2Q2dmdSV1lS?=
 =?utf-8?B?Y3lKZnVISnVzaWdIdG51WUEwZkdZeklIQXlDRVRTZWpTdTk4T0ozQzdEZ0h6?=
 =?utf-8?B?STlpK01oNHdzVytwcnVXcXFKbEU1UEQ1cEFSYVZxZkJLWDlsUko2SWI1ZTJE?=
 =?utf-8?B?K0RxcHd2aVFQZm1idnh4bTVpMFQ2Z1JSOXJhUDV4VDZFdmI5SVVBeXJ5bVJx?=
 =?utf-8?B?eW1qM0VGajgrenFRd0FaK2MvcGpKcVhZTHhLekhEOVRBMTNWSWVqRjZ3b2x2?=
 =?utf-8?B?Tnp4REpvSDBNZzE4V2tGVTRoWTRLY0lPakl1ejhobXpsRGdwY0s1YXJwM0dU?=
 =?utf-8?B?VFh4ZHZkckhNdjd5UCtyNkVHWHB2dnEwWmExZ2FuVlYxQkY2T2lUekhIZVpa?=
 =?utf-8?B?UmJrWkdzbEwvaEdtZ3FZbmUvU2Z0ZjN0eEMvb3RQaUFxTlVEL3oreFZiYU5F?=
 =?utf-8?B?clZJb0YxSjZJVE83bllDRU1zNXNiRTZJSHd0aFRVRmxCUVFiWEJqOUxEL1cz?=
 =?utf-8?B?TzJuR0RHQ2piektTbUZ4UT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR15MB6455.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MEkzL2RKNnJ1SzNNMXpaam1OMHhmR1dKb2NOVllGSXhHNGt6SCtlVFdCZGQ5?=
 =?utf-8?B?eUIxM1IxWVI0TzlTdjg5OGszeFZHcytYK09pdGNWRUhyM3p3c0NjMndROVli?=
 =?utf-8?B?T2YxeUUzc3J6dkpvV1c2cTgrNEkyVWRmTnNlOG4yVkJrazVzbFM4L1lFczU4?=
 =?utf-8?B?VXpXeFB2YWxaWnF1NWZWR2t5V1hGVlFXRERUdk9Ga2V5ZTRmQTB4NWdiYzRi?=
 =?utf-8?B?clZPU2xLWlZ1clM5T0szbVdlN1dvZHArZVZEbVptYXd5WGNmQ2syQ0xFUlc1?=
 =?utf-8?B?Q1ZOKzJDWEFVOGZHZkg0MVh2YmdkTklEWXRXc2J2a3ZZdUhzNnpUbHJXNjNY?=
 =?utf-8?B?a0U1NGlhTjJTblJKclJKVW5UanNycjdKelo2RDllb1NDYXJCSVZBeFhCNkI2?=
 =?utf-8?B?UVBiYVdiNlNWWnNPUmFvWWErTWJFUGRZcVI0bnhGdWVWODM4eXZDZlNOMDJl?=
 =?utf-8?B?UE04T3Iyd2FkeHFNbk9ZMTVsNE81WU9ERUFXa0p4MTJuczB2THZXcUk4NW81?=
 =?utf-8?B?c1dGMDY1dXBzRUZnVzdicFl4OXk3VzFISG9lK0hFdVNEcG8vSFJvazB1eHdq?=
 =?utf-8?B?ZTNCQXVEdDUyTnM4SkovUUNPK2dnUVg5TEVJY1U2MExGaHp4enFySjFOUTNZ?=
 =?utf-8?B?ZlZVMlc1cUVYdmVqZkZpaFZ2WmFXamNyZlIxbWlvQkQ1RUFoeXJGYzRTOGNs?=
 =?utf-8?B?b2E3emxqM211bFpjekNXZ3FlSXdwNk1ZRzJlaitkQk1pSXowcjBVTHlSZlNa?=
 =?utf-8?B?TE1CSXJGbWtzZERJTzY2dTQyTmIwb29mTDh5Wlg5anp6aEg3Nm1NZlYzeEgy?=
 =?utf-8?B?aG5GbWRmV29yTFhROHZ4YlN3ajJ4SVFoK2l2RUgvaXNGaEJQTGprZ3FLMUZQ?=
 =?utf-8?B?aktsaHhvT0pkVmxoWGJheUJtQmZOajRHaWZ3L0xScE4yRTJiZ1o1YzhFNktP?=
 =?utf-8?B?UHNvSDVpMGJVelpReldOcEovOGhzRnh1OTd6TUJLNEFuT0c4ak1hWmNMczdM?=
 =?utf-8?B?TUkwbHloZ0Z5WllwQTFXR0Vab094b0ViY0o5TXRFY01lakFpRTNCVzJuUVZE?=
 =?utf-8?B?TUhuNzJ6MFRyV0VpallBWm40MUJtd2tjRUZzajFjeExQT3FHOFh6Z2lwOW5t?=
 =?utf-8?B?cER6c0l6NXVNc3lreWZnbE5WTWF5Z0xuajZXYjNRY1hoMlJmTXZrQTJrTHR5?=
 =?utf-8?B?UzdlbXdrYm9vMWZJRkhSbUNkVkVqcUFvbkhMWGZpeFBIakZ2czExUzZncjlz?=
 =?utf-8?B?WHZzdXFqeGFxOUFKSzZNb1RQeTJRVkhmazhnUGl3dmRpNnk1RDN6SFFna2FV?=
 =?utf-8?B?OWRRZkZCMzMxMk02N2VVWTd1TjFtbXZ5cURZT29OSkhHQWRkRXpZL01MeTQ0?=
 =?utf-8?B?aThtQSsrdUtPUlg5NjQwQ1dzMm14alZDeExYTGtGRWxwYjRBTEFOdTZHQ3ZN?=
 =?utf-8?B?VVBqWXZpSW83eHhhU2Z6ZG5OSkRQODdxSno5SndqTE9GRmU1ZEYyZzBWdlRQ?=
 =?utf-8?B?bkpYVE5zcVpsZVk4UEZ1anNYb24yMWlBcHR3QlNzb0QzLzg2OC9mNDhvY0Vj?=
 =?utf-8?B?YVg4Zy9PS2NvZk5CQVp0QzdsLzlrMXBXUVc3Q0JRRUF3Q0lBY1JoTTZzUXNx?=
 =?utf-8?B?TFFtbDV1dythMCtBdXJnN1FiV0xqU3QybEhDKzFpenV2N3M3eUpMZDE4UnZs?=
 =?utf-8?B?cDdMZG5mVzN0NUcvSm1FMjZBZ083NFlKaU1wR1FQT2VYd01WMWp6KzFjRlJo?=
 =?utf-8?B?ZExCNWh0WHRzVlc5ZDRHckJoZTlQQ00ySXJ5S09TNjZ3cGk1WVF6ZkVYTFFR?=
 =?utf-8?B?MnJ4bU1FMHRqcnFibVVlY2pGOTVJekk1Qy9yL3B3VUd0MzFKMDdBMjJVSE1a?=
 =?utf-8?B?R1FOK2lFank5UHBQSjlWaDZwclR2WHg3NDY5Zmh2L2tvVy8yY1ZLSk5ITUQz?=
 =?utf-8?B?SG5GY1Ayc3VYLzJUQ3hlZDNUUGF4Y3lqYnB3NTI1TUJ5bFBFd1lRQk53K2FG?=
 =?utf-8?B?c0JsR1paQjZic1d2WEVlbjNRSytnWHE2RUpVUGFvT3d2SDE1VmNCSDBJTGho?=
 =?utf-8?B?aUhSQUxjWnN2R0hqUmZDS2d6TG9ibXV6d0ZLajVhcWFoRFVoVUZyNDhJK1Zu?=
 =?utf-8?Q?5qqQ=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71f4df3f-6adb-4aa5-cace-08dcd62c2dbb
X-MS-Exchange-CrossTenant-AuthSource: LV3PR15MB6455.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 08:47:21.5968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e6V2IGR2VDKbKFgApB8KtrX93yeIgHoh2QbvDKqokf0/nDaTvGIYOl1ODUKKBiPP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4186
X-Proofpoint-GUID: UtfPJQxWdwLsN4HFWH2OiCqjJpFf93XD
X-Proofpoint-ORIG-GUID: UtfPJQxWdwLsN4HFWH2OiCqjJpFf93XD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-16_05,2024-09-13_02,2024-09-02_01

On 9/16/24 12:20 AM, Linus Torvalds wrote:
> On Mon, 16 Sept 2024 at 02:00, Dave Chinner <david@fromorbit.com> wrote:
>>
>> I don't think this is a data corruption/loss problem - it certainly
>> hasn't ever appeared that way to me.  The "data loss" appeared to be
>> in incomplete postgres dump files after the system was rebooted and
>> this is exactly what would happen when you randomly crash the
>> system.
> 
> Ok, that sounds better, indeed.

I think Dave is right because in practice most filesystems have enough
files of various sizes that we're likely to run into the lockups or BUGs
already mentioned.

But, if the impacted files are relatively small (say 16K), and all
exactly the same size, we could probably share pages between them and
give the wrong data to applications.

It should crash eventually, that's probably the nrpages > 0 assertions
we hit during inode eviction on 6.9, but it seems like there's a window
to return the wrong data.


filemap_fault() has:

        if (unlikely(folio->mapping != mapping)) {

So I think we're probably in better shape on mmap.

> 
> Of course, "hang due to internal xarray corruption" isn't _much_
> better, but still..
> 
>> All the hangs seem to be caused by folio lookup getting stuck
>> on a rogue xarray entry in truncate or readahead. If we find an
>> invalid entry or a folio from a different mapping or with a
>> unexpected index, we skip it and try again.
> 
> We *could* perhaps change the "retry the optimistic lookup forever" to
> be a "retry and take lock after optimistic failure". At least in the
> common paths.
> 
> That's what we do with some dcache locking, because the "retry on
> race" caused some potential latency issues under ridiculous loads.
> 
> And if we retry with the lock, at that point we can actually notice
> corruption, because at that point we can say "we have the lock, and we
> see a bad folio with the wrong mapping pointer, and now it's not some
> possible race condition due to RCU".
> 
> That, in turn, might then result in better bug reports. Which would at
> least be forward progress rather than "we have this bug".
> 
> Let me think about it. Unless somebody else gets to it before I do
> (hint hint to anybody who is comfy with that filemap_read() path etc).

I've got a bunch of assertions around incorrect folio->mapping and I'm
trying to bash on the ENOMEM for readahead case.  There's a GFP_NOWARN
on those, and our systems do run pretty short on ram, so it feels right
at least.  We'll see.

-chris


