Return-Path: <linux-fsdevel+bounces-23106-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B19FD9273E3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 12:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CCDD1F2238A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 10:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394E51AC231;
	Thu,  4 Jul 2024 10:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QZLPAWKJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="So0fJanI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9231AC226;
	Thu,  4 Jul 2024 10:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720088372; cv=fail; b=tc2VSH8tXFguZgbrAjqESa0fSkzM73PH3HsGCLFScnuCxG5YVDdDzc/1ovZxSscUEoQ/BbdFkzKP9DkqUkV4LrpRqOUB0NOpAo5D2evPTtqzFWVQezzov25W3ktpwao1j5Ro2Sbls7XXvKGJ2jvaMWUScMESyMWrM8sVQf0LwHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720088372; c=relaxed/simple;
	bh=vqLZYyhdxtEidRqdaQD+/KpOAJYS4MkdoCDF0I8q4RI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=od7rM1cdTWJPuwSXGPDZSdgd55AapnY5EY9LOigs7d8RSRTDyqSQSgluTVxqT+dyhonuVZ9GicNwGtpgjtIFby6MK4qvaym98gGPe2FP/ojmm8Nl8u4g5KjUUAZJkD5GS67EpZXMp+yVyjO/OaX+K75xRU61Xv4ymxhziQoMtbU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QZLPAWKJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=So0fJanI; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4642MTrA031058;
	Thu, 4 Jul 2024 10:19:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:content-transfer-encoding:in-reply-to:mime-version; s=
	corp-2023-11-20; bh=JwgrXVZXfeHtLvwfI6JbFibHeWCW2nCvz8+uLCZ2ImQ=; b=
	QZLPAWKJRzOdTiuh0fZSY4gmiQth/uNRfrXt/YnXPBnm2C089y/lWbR0I5nVh7cG
	icUhCB9jz1O6I6D7Bngz09KFfiUHRFb/BrNdWVCPdS+CzeUkxhe4FrNIgJWJclKE
	H74W+12Jfww3SHlxYV6olbcs/ki7jEvm2A38+pj7qwZOkIdqgKsSTZPUtscO5w9/
	i+D9yBN6q+6n01PM0Ug2ScaX27f57lJ0mzmV9KowkrG9r5Y23feiEHHQcHdUQ9gm
	3K4xkxhZ6U/nEBkKNTMex6qyv9d6RBtTu8Re3Z/tddi9DV8yzcP8AYHz4vDy90cG
	3UJYjRJAYymYrR6vN6bKbQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 402aacj4g3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jul 2024 10:19:00 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4648IK5C024927;
	Thu, 4 Jul 2024 10:18:59 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2047.outbound.protection.outlook.com [104.47.70.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 404n117jfx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jul 2024 10:18:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZxFP5cyEiy9lFmMWiYL+lUV7LBUVGpVL7vKfmDLq0m+E49tsT+JsY6KT0bd7kpcYyHTkQNJrwEVh0foKheklliosvacMcUfwgn/5Ngyn+mfb/cTdT0+9n2k/eP/2ZGesGb1nNsW9VgDVdTzbXBtSnkrrDcUex2/4XC7roeOPhe42EolUwowvtaoSRRHpszO9wWyyPlL0PjfFYw23NSdIgng89a62X2+Gnqz5HXLCyrwngo9VEd8TfkoIlM8Sz9NpZqLGdtKrdFxZ8cOKt8b28S5MSWnzZEsUuTVUa0SnZgvf9B7bagSgONjBK4IDP4WrnkJ4QamU9VlShDJrZiqqLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JwgrXVZXfeHtLvwfI6JbFibHeWCW2nCvz8+uLCZ2ImQ=;
 b=BFyNyFjxFa0igkX6kavtG7ASFVqt+igojX9Z326n6WE6IZiaR16lPqW7JTjiTg0/b9b9/JM/NZd+3WPbO8DAxp9zC+D0xtV7zTEhNbGuqTsybaqRqJLTYEe/uojs0l15bguwh2SoUio7ZFf9nWB2CLa9cOU5YJI2hXvxRDXGSN2z+vVGrDfkLGGIWXv18gQdwmHhh1Y/fBWcBwdCjsyqEnQpiwlhVc8TFClWb+ivlr6toQhTh94SiwmR4LWFuTVFwVZCjCclwttWzlby+n6WuhGXaYhF8hrh21pfnf7F7oUsjepL8j0b6ggSVaPWuTzSGJG9SBKKESwI/ni9XHGyKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JwgrXVZXfeHtLvwfI6JbFibHeWCW2nCvz8+uLCZ2ImQ=;
 b=So0fJanIIJhM0P5vJyFV2U0Rzy0Hb9V/zGJsyZhuFOxFGmQcJbrQIaTS8CQPMKKT9yuTX9/5kvjlGCflflm6HmGYL3KbBM/V+mGi+fN7Zab1V4s02D3arzoBfx3+O7NAs61meNAqKVQAySYLxxuPf3QHEh6irNQ6k3gEasjwgxE=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by CO1PR10MB4612.namprd10.prod.outlook.com (2603:10b6:303:9b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.28; Thu, 4 Jul
 2024 10:18:56 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7741.025; Thu, 4 Jul 2024
 10:18:55 +0000
Date: Thu, 4 Jul 2024 11:18:50 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Gow <davidgow@google.com>
Cc: SeongJae Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Shuah Khan <shuah@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Rae Moar <rmoar@google.com>
Subject: Re: [PATCH 0/7] Make core VMA operations internal and testable
Message-ID: <76f6ffc6-2750-4578-b845-67b4e7920830@lucifer.local>
References: <1a41caa5-561e-415f-85f3-01b52b233506@lucifer.local>
 <20240703225636.90190-1-sj@kernel.org>
 <CABVgOSk9XTM2kHbTF-Su8fXxCcNzu=8vF4iUbC=2x-+O_MNUWg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABVgOSk9XTM2kHbTF-Su8fXxCcNzu=8vF4iUbC=2x-+O_MNUWg@mail.gmail.com>
X-ClientProxiedBy: LO4P265CA0312.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:391::20) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|CO1PR10MB4612:EE_
X-MS-Office365-Filtering-Correlation-Id: 83086569-4585-4007-d94c-08dc9c12b572
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?RGQyeTliNnVnUlpET0RUOVpEdGkzS3ZqRklwTVNJUExhMlZ6dGczTTRlWmdr?=
 =?utf-8?B?OFpmWVF3WnR5a253WGk5eHVTWUFDRU9pem1tUkZLaFdJT3VETDF2SWd2eWlv?=
 =?utf-8?B?RUd3bDQxZEFJYkMyVTJnZHlZdUFxQUZFUTRCYXVFUFNFUTVScGJPb2pSSm9F?=
 =?utf-8?B?Qjh3aWlUWkJseXI0dGhqcC83WXdRNk05NGw0bDdTVHVxL0dEUk5mckJQbG9j?=
 =?utf-8?B?TjZ0amsrSTh3RVhydHI2RzFCNlJZU21yZDRhN2pON2p6NWlnc0k0ZnVKZ0xY?=
 =?utf-8?B?cnQxY09mTE1yNGI2ancvSVlXREtyY0xhK0dtbytiMCtNcHRSeHZ5SDM1THJz?=
 =?utf-8?B?RkhiQWY2UFdQcUgvM3FCMFdiV0JvYkdmWmI5ZzlMekVrb0JjNTBWTW5aZ0Z5?=
 =?utf-8?B?SUVwZTcwbng5cFNrMDVKVi9kRWNjMnVtaTMyS1Q2RHdMeFVidUF2bWpmMlhj?=
 =?utf-8?B?S1FRK3lzNjZDUE5kZEMxVFNFRWEydW91aVBxOTdNSCtUNGt6eThlOGxkcFpM?=
 =?utf-8?B?TWdIdDB4cUFCV3BUeVVDcklhUTM1VzVxUW5uMFlFaXo4YnNyZjlKbXNnbXpJ?=
 =?utf-8?B?SmFNV3oxN3pCWGx2bEJsQWx2dS9vTEM3aXVoK1J5bTFmOTM4YlJJWDF6RFpI?=
 =?utf-8?B?QUdreThlWDhGbTgzdGIwdW9XRUIzZlZJVGQ1dVNrZ3orQmEzazFZODEyNVh3?=
 =?utf-8?B?bGVNNHNHT0FmYTQvSE1obGE3T2ZHL3J0RzUzdDNObjdHcE1DRkloS0pYOFZs?=
 =?utf-8?B?WlZESTJIUmFzcDdSYW5zMlNtVTI5N25DRUs0VndYMHQxWGZwdjdjTlhERzVC?=
 =?utf-8?B?aWY0OVd0R3Y2a1VncmpkQ1V5RjFTaXplNmc3dWowbDBlV2RiOE5naGtkYU9B?=
 =?utf-8?B?V2VHRG5iSUJWNWNmY3JDUzhxUEtKRjRrU0NjMUp6WWRRR0ZKSmE5SXpJVlFN?=
 =?utf-8?B?YXZsSGhTMk5Uak5GV2MxU3FlQ0EvRCtYanNqK1c1TGx5WWJMdnZvSitCMFR0?=
 =?utf-8?B?L0ZVcU5ZWVROTlhFMkF4OTN1S1M0U0RJQzFUR0lWa2FEZ1FZZnBGYnVrcjFG?=
 =?utf-8?B?NFB5RVlBTGxZMmpRNHRudlNtb2RDOUZaMyswY25Va2lVY2ZZTTA3MndzWDhM?=
 =?utf-8?B?M3NweDRJZXRIUC9rdEVMTm5RSGJ0dXVSSk9IK25tRlcxSDduYTJPTnNEaXJW?=
 =?utf-8?B?eFYwYWhZR0FuNUhrL1d2TmZwdnZEMTZkZWEzWGpEU0NkUVRnRWIyL0hSZXF1?=
 =?utf-8?B?ZWdCYVRkVlBCRktKMFp2VTlodFZnSURZQitmcDNicW5Xam4rTW1GT0dyV2Fj?=
 =?utf-8?B?NlRZazJYLzZhK0RlRENESWh1cVBMMnBHOE9JOWRwWTBzRGYrdzNWQnBEOWdJ?=
 =?utf-8?B?cUFlMEczbjlOSEdmd0tWaWkrdjUrVXYrQWJ4YXI4SmNyVjU1NjdqWUcvQkc3?=
 =?utf-8?B?OE0wNGRETHl0a2loNytrZkIrUkd5V0dMWm1hUzN1ZXNGUkV4VkdIb296TmpN?=
 =?utf-8?B?RkFCS0ZZSFc2cVJjeWdNYSttOFZQOGlGNTZSMjhQQmltRG42SWkwYk5haWV1?=
 =?utf-8?B?eVBYQ3hrWlN2TXRIaUZ5V0FKZGhNYWlXSUIvdkUxUS9nVDlWTitjT2xsQmdu?=
 =?utf-8?B?QmZrVmNGcUNxNW9wa1ZzS2svZWpUUHBtaDV0YXZRdmJ4QVd6SFFlVk1hQkFQ?=
 =?utf-8?B?RkNFNllsVTNCTGJDeFJwNjBUbVdqZHBTSENWUEkyNnFkeFhYYjA3b2xMYkU0?=
 =?utf-8?Q?DUmGmsy1FCudhSET1k=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WEtVclFjNXdOZmVPSDFMSkx5RHpwcGQ2SVQzYlplVVBkbVNIdy9DZWVtZmJB?=
 =?utf-8?B?SjlJUXUwa29jMDFlZ1RZc25hcE1Ya0FEMzQ4RW84eW15aDk1NUJlSVp3b09S?=
 =?utf-8?B?OUV6VHNUaDlEYWJEZmwzNUpCSDZqU2pqSjFmVHFDaTNyaWs1UXFkVEhTNk8z?=
 =?utf-8?B?bVdoUnNvQXAvUEltQUt0UFY4Vy9lb2Y3eXh6OVRQSWF3YjRSa2RKdGhFWTVa?=
 =?utf-8?B?U3JhVEVJL3Y1REdmVzVSVlFMM1h6eGtGZTlNeThhcnZIUVJEaU54Vk42UzBH?=
 =?utf-8?B?S1VHVDA1WUlEOEY4K2R5bVkwN20zZkRyUEVSRkFmQU02MEs5VzJpMXp6bk4y?=
 =?utf-8?B?MkZGSUgrQ3cwNmtPamtFdzhUak1YbEYxaDI5K1ZoZ1g0RElqUlhNbDYzNURv?=
 =?utf-8?B?RDY5QVBtRDNqR2JtWG1FUDA3Z1J4UkhiWHhhczBGNC9hZVNPVjIwK1NTdzJ3?=
 =?utf-8?B?ekJmMEJXNTNzUlpzMUV0Tm80YkFaR2Y4eFg3bDRQTm9pV3NNRTBIc0Y0L3Ez?=
 =?utf-8?B?b2RiYXhHejlsTmtNQkZvQi9XTUxMTzNiVU9xd2J3QzNud0Z0MTVZM0JhVVMv?=
 =?utf-8?B?ampFVk5MdEVvSHdqTjVNeTREeTZLejYycUk4YUFjNzhITmYzOHljcThVMXps?=
 =?utf-8?B?YkU2bExyZU1lQThxdjlhTU1pdFFtRkZHRTFOVHllZzB1eGNRUlE5K2FORmtn?=
 =?utf-8?B?QUVNYkltNmVOSnFCN1VyVXNJOWxuTk15N0poWTl5Wko1SWVZZG9yN3Y5eVpK?=
 =?utf-8?B?RUxFY3ZzdGhKaUxiVms5TzNoWDJ3bkYxand2MVJnRGNiS3l1WkFjTWtldE0y?=
 =?utf-8?B?ajZPYUhXem9wOG5QR3ZPNzQwTG5laWluSTdtaEMrRTVLV2pyNjdZT0JlL1JD?=
 =?utf-8?B?YkE4N1pKUlVhRFdLOG9nY2l6cklJMTArWTFGaU56TUkrbmEvNGpac3N3a2Vs?=
 =?utf-8?B?NzhLcG4zWTNQaHZza3RkUktHUHhvSDlzY0tRTXh1TlVnaWRlcHZxV3VIU3Ny?=
 =?utf-8?B?Zzh1OHA4bU5NSDlyUzJPQVVWZlY2WUVTcVVYWWw3ZWNEcDhmWU5JRExucE5P?=
 =?utf-8?B?MGVnMkFUemFzODEvN2dXcXRRbU9yU1NHVDNOS1l6cUZoekk4eGd3bFdSZzRx?=
 =?utf-8?B?QXpwMXFoSFF4NVFISzFvVEdNS01jemFIZldTYURFQ3gwSFJjU205U3A5Y25Q?=
 =?utf-8?B?OGt4c3crbjF6K3M0czBKek1BSkIvcVIrZ0lOS0hRODAzRGgva1VudnNJVG1P?=
 =?utf-8?B?Y2hFbHphbFhVeWI5SmJRZWhaYXZhV1BCdG4xY2M1dy9BOVozY2JuOFIvblBE?=
 =?utf-8?B?dmtXZzBOV2FnMWZGb2Frem9ncU9vR3JTaHhqM0VMa3JwSTNWLzBhTE9zWXdD?=
 =?utf-8?B?TklxcS9jZXc2TzRNNWNQQ3poUVFsYzNEblhpVEY5ZGhpTlpNNmJkWFBtS0tB?=
 =?utf-8?B?bkVxUCtSQTdhVGdyWm9IL1hZaFd0emxxUHRKajN2RHU5Y0Rmd0pneEdlb1FJ?=
 =?utf-8?B?UElNblE2d2xKSkJrTWl3bFlSbzZmZEtPN0FnbXF3Y3ZUNG9PUFNFbkhXd2J3?=
 =?utf-8?B?UzFVWTlXMSs4ZlFsMWxjQ0gzaE5yaGN2MWZvMEhkTTNHNlcrWHBrcXN1VXlZ?=
 =?utf-8?B?cmgvWUdWSGxHV3doWGlKdzJ6YnB3WkhlMk8zdnJjZ3hvTkFPa2ZQdHBtdThQ?=
 =?utf-8?B?NVN2M3ZOSmVJMUNZVWpKdnZldEVON2Y4MERHcGxLUUNycTJRWDI4QVJFRFZW?=
 =?utf-8?B?Q0JVbXRYVHd5d09aUjIwd01FZGo4dlIwRDlINFB5OTRzZ3kyVHJ2cjdWWUl6?=
 =?utf-8?B?VTNPOWlULzFhUy9hdXJuUkIvbHZxTVBMS0RENFI4QzIvWVNPMDhPNEZVYzEw?=
 =?utf-8?B?STZwQmdJcTc2UVRLSWpXbFEvTjFPcU8yNFJpcTJhUGdYVENMN3E0VEtNd1RU?=
 =?utf-8?B?UnQ2bmc0UXIvemhJY2kxQTBWRmRWNHBEZTFWU1h5MUN4U1RBblJKUFh0ekc4?=
 =?utf-8?B?eGVoamF0TEtYSFhXQThSVVdKTW1VYnQvcjNNejZUNGh5S2I1cEFZMWJqZWZD?=
 =?utf-8?B?MXRXeDJYYkhQa0x3V01IVkdWOE9MRDJLTHhxTVNzVkhIZUtxTzlVY3hqOVE1?=
 =?utf-8?B?UlMwbHE2MFdBZWowQVhiRjVjbGVSNUN2eFhUSmpPUm5DZ0FYdEJjU2ZWc0Rw?=
 =?utf-8?B?aHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	XmI5LBP3ldrHqFcByVx05PwHKCfKsnMGYbczbS7gyjSKIRZOVrP1blOVNpFHlDwG4X+sY01lPgucs+KQMfpodRvQSnjpiKmvIqac2FgaoMJqpdu5pDkgvcbcQsOJhJ/DL8JTsXPDrk2ZSTg5D6T+sNEiY4NaxkBMW2kEpBSveQeg+O7ShtSHZxy3KtGSOM5Eo2XQ7wwC/hM2xgdwoT6U3rVWYA2wQ4Lg72CpRORq8FQpVEJHhlxo128BUSgdZRLUl/boPWICN96y2HrU1CFzbzEtQxceJ5SpQjRFQV6lBPqYB3l1oOVePA7fisyl5ML66W7R4sGAybKp5LDK9EL4ytv6WWewiSPyV7i8X+QBqPDS2Z6IxaYxtYrYeRkaK4z691Nvi7WOoQm6mP8WVEHj+3tLzewvuu4xsG63rACvkuNGBKRS6FsxdbMhpzx640c1xMVy55+8lI9prtu6+JYiT8RferF6Tzl2tye7xhl11wP128CBHLq2Kyi/ZWSqvI2xIzNut3h++r/TpAfptYlI4mz/zA1UjHE8DtDvY2XpFDhseflM7ACKtrE121lOKhx11xWBnRAEzi8xrFgnPSuKoHLCRTJ+n/p0Ba5zRndksJU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83086569-4585-4007-d94c-08dc9c12b572
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 10:18:54.9614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QZKgN1BJivmuofOqV7NTlqt3Rp3k9j5hWr4nm3VQ4GMibV4tsn8niYI2RwDiQOX2b6YE7yfRu24Sc4X/b4hWcOZbWMeJU+gcz/H9S+hXpdQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4612
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-04_06,2024-07-03_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407040072
X-Proofpoint-GUID: 2Q-SM52_cz8NwS7yxCMARxxjvLtl_9wu
X-Proofpoint-ORIG-GUID: 2Q-SM52_cz8NwS7yxCMARxxjvLtl_9wu

On Thu, Jul 04, 2024 at 03:10:16PM GMT, David Gow wrote:
> Thanks, SJ.
>
> While I'd love to have the VMA tests be KUnit tests (and there are
> several advantages, particularly for tooling and automation), I do
> think the more self-contained userspace tests are great in
> circumstances like this where the code is self-contained enough to
> make it possible. Ideally, we'd have some standards and helpers to
> make these consistent — kselftest and KUnit are both not quite perfect
> for this case — but I don't think we should hold up a useful set of
> changes so we can write a whole new framework.

Thanks David!

>
> (Personally, I think a userspace implementation of a subset of KUnit
> or a KUnit-like API would be useful, see below.)

Indeed, yes.

>
> On Thu, 4 Jul 2024 at 06:56, SeongJae Park <sj@kernel.org> wrote:
> >
> > On Wed, 3 Jul 2024 21:33:00 +0100 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
> >
> > > On Wed, Jul 03, 2024 at 01:26:53PM GMT, Andrew Morton wrote:
> > > > On Wed,  3 Jul 2024 12:57:31 +0100 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
> > > >
>
> [... snip ...]
>
> > Also, I haven't had enough time to read the patches in detail but just the
> > cover letter a little bit.  My humble impression from that is that this might
> > better to eventually be kunit tests.  I know there was a discussion with Kees
> > on RFC v1 [1] which you kindly explained why you decide to implement this in
> > user space.  To my understanding, at least some of the problems are not real
> > problems.  For two things as examples,
> >
> > 1. I understand that you concern the test speed [2].  I think Kunit could be
> > slower than the dedicated user space tests, but to my experience, it's not that
> > bad when using the default UML-based execution.
>
> KUnit/UML can be quite fast, but I do agree that a totally isolated
> test will be faster.

Sure absolutely, the key point here is the essentially zero setup/tear down
and zero code is always faster than _some_ code so as we stub/mock
components naturally we get speed as well as not having to be concerned
about how we might set up fundamental objects like task/mm/vma.

>
>
> > 2. My next humble undrestanding is that you want to test functions that you
> > don't want to export [2,3] to kernel modules.  To my understanding it's not
> > limited on Kunit.  I'm testing such DAMON functions using KUnit by including
> > test code in the c file but protecting it via a config.  For an example, please
> > refer to DAMON_KUNIT_TEST.
> >
> > I understand above are only small parts of the reason for your decision, and
> > some of those would really unsupported by Kunit.  In the case, I think adding
> > this user space tests as is is good.  Nonetheless, I think it would be good to
> > hear some comments from Kunit developers.  IMHO, letting them know the
> > limitations will hopefully help setting their future TODO items.  Cc-ing
> > Brendan, David and Rae for that.
>
> There are a few different ways of working around this, including the
> '#include the source' method, and conditionally exporting symbols to a
> separate namespace (e.g., using VISIBLE_IF_KUNIT and
> EXPORT_SYMBOL_IF_KUNIT()).
>
> Obviously, it's always going to be slightly nasty, but I don't think
> KUnit will fundamentally be uglier than any other similar hack.

Indeed, I mean this patch set makes use of the 'include the source' method
in userland.

To me, the more you think about it and how you might implement testing of
fundamnetals like this the more you end up with a mocked out design as in
this series, unavoidably.

And sadly I think no matter how you do it you have to put the ugly
somewhere, in this instance it's in the stubbed-out vma_internal.h.

>
> >
> > To recap, I have no strong opinions about this patch, but I think knowing how
> > Selftests and KUnit developers think could be helpful.
> >
> >
>
> More generally, we've seen quite a few cases where we want to compile
> a small chunk of kernel code and some tests as a userspace binary, for
> a few different reasons, including:
> - Improved speed/debuggability from being a "normal" userspace binary
> - The desire to test userspace code which lives in the kernel tree
> (e.g., the perf tool)
> - Smaller reproducable test cases to give to other parties (e.g.,
> compiler developers)
>
> So I think there's definitely a case for having these sorts of tests,
> it'd just be nice to be as consistent as we can. There are a few
> existing patches out there (most recently [1]) which implement a
> subset of the KUnit API in userspace, which has the twin advantages of
> making test code more consistent overall, and allowing some tests to
> be available both as KUnit tests and separate userspace tests (so we
> get the best of both worlds). Having a standard 'userspace kunit'
> implementation is definitely something I've thought about before, so
> I'll probably play around with that when I get some time.
>

Well indeed, [1] is what this patch series uses, heavily, to be viable :)

I do absolutely agree going forward that some means of standardisation
would be very useful.

> Otherwise, if Shuah's okay with it, having these userspace tests be
> selftests seems at the very least an appropriate stopgap measure,
> which gets us some tooling and CI. I've always thought of selftests as
> "testing the running kernel", rather than the tree under test, but as
> long as it's clear that this is happening, there's no technical reason
> to avoid it,.

Yeah, this implementation is explicitly intended to be a skeleton to be
built on, providing a minimum implementation with the most important
component provided, i.e. the stubbed out code - in order to demonstrate why
the refactoring bits of the patch sets were done (i.e. to answer 'why so
much churn?') AND to provide the basis to easily move ahead and write
serious tests.

I think it is still viable to add further tests to this as-is (I'd rather
not add too much friction to this hugely valuable exercise - we are
seriously lacking for fundamental VMA unit/regression tests), but moving
forward I think it should also be very easy to adapt this code to use a
consistent userland kunit implementation.

>
> Cheers,
> -- David
>
> [1]: https://lore.kernel.org/all/20240625211803.2750563-5-willy@infradead.org/

