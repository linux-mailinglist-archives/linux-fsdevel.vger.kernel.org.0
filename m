Return-Path: <linux-fsdevel+bounces-70042-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF79C8F262
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 16:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B1E43BC9E9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 15:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133D1333456;
	Thu, 27 Nov 2025 15:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ywiPYgB7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012034.outbound.protection.outlook.com [52.101.48.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB142260585;
	Thu, 27 Nov 2025 15:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764255749; cv=fail; b=be8iZIVaK2R2kK5dvy6BjOUl/+OdGi13taJUfK1P01BPeqlW/tUBYfErwvTA+IHsQQlogjpaAw9yoQuDWgR0XAcwjTRtnZji1i2DsNb6zuaCwozdYZ3Lx6l8xaPZqLLP7Rf8F8kWw4cqwe+MN5ju6wdWznQk9iFW4Y6Y5Sz2X8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764255749; c=relaxed/simple;
	bh=+Kv4LZpCZ8LwfJrSoUCErUfAHncwjmQ4UZs6srZXxpw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YUSB1teX8Dwcwr+wz90y/twRnUo+iF0mjYFWS3lVL1ZbnHi5t2V8A2FH35kdQ4o/8j/FnnJ70gk4GIouXzRTCQKYcDhoCi5T5iTtLm+zEU/7oH9dsQyj3fBo8XWELfI3Zk8MayByiZoQcvN3zIHFoye34CI7arsPh3bV3Zm5hvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ywiPYgB7; arc=fail smtp.client-ip=52.101.48.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xwhdFodf6iT2XjuVAl0fyHEBQb899VTUsNdJJuxdnzOJoNZXPQpfAAQlZdtwMr7PA0kjux2bmEFkB0NiMFAxfdQNVDV/dmjXXRViqab+dEw/iOso/Ea0EjN/nLmT3NFVI4MKyNbATgYWSuVCpyg2dKja0gy/MwmNCb1JjjcZ6j9C035esI+FX9tZT38uOL/ecPwtXL62aPNhkTBpKBsIFgjG5sOaMRWcwOtc6b5bLXADA9B+ugVWSIy4MeCV7qcjXGa9+h6TEzNJyemjZGGvxUaKHMT5W8tcUQKYUrBg4e5l5RPqScGA9Go5/gO5aoWiIA+wzrgFJy8PXrj0AT6z7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PuHLd4xDZuF7MFqb/07VkIYcVF/lsmY5geGAFu2PqJY=;
 b=CvzMm1mynmnoGsUB2GsaOb4ERjJxP/HDqCiHWPNvT/BZJ+IUNsXBhSThkWVT6EVtjyF+JCxGOoDC8XPvKHVV8xPo7M9tAUsVqnCvRFOJr5X02NYmrIvZrOGj5xjs791HBanTPeE9gtYnsZeXQ3jYYraHd1Y5/1wj49a45ngqooSTat9DgzbzxZz5esgIsILJYjGo7HyIQiOOIP6tdPGf6LizcU2uiE5XlF5LyE1+RO+U+C1BsJfMR0VvYeM1uQfEZZBYMrg+mQsuZiGRjeZphmuqk6EqyBBMm7fZIWSzuQmEvedQ6b1JZP+0u/7DeD13di0FYNRTC2U8mKDinsvc+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PuHLd4xDZuF7MFqb/07VkIYcVF/lsmY5geGAFu2PqJY=;
 b=ywiPYgB7+ImvMYHejknZD/7XTqGd/my4HcGR2jr8Njw0xh3g254gETyIw0PAUZvVo+BbZ4zPnFpsX1+uzypU8FGjhbkigXihmx7Y7ouEyYfSaUYgFs+0DUjLK03JBbgmNlnEvOxOX6lxTVH9YRoUAloOK1x4avspg48U83PYiLM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS2PR12MB9749.namprd12.prod.outlook.com (2603:10b6:8:2b9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.14; Thu, 27 Nov
 2025 15:02:25 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9366.012; Thu, 27 Nov 2025
 15:02:25 +0000
Message-ID: <414a5ade-3e2c-495d-bbb7-3e721e6897c9@amd.com>
Date: Thu, 27 Nov 2025 16:02:21 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/1] idr: do not create idr if new id would be outside
 given range
To: Matthew Wilcox <willy@infradead.org>
Cc: Jan Sokolowski <jan.sokolowski@intel.com>, linux-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org
References: <20251127092732.684959-1-jan.sokolowski@intel.com>
 <20251127092732.684959-2-jan.sokolowski@intel.com>
 <aShYJta2EHh1d8az@casper.infradead.org>
 <06dbd4f8-ef5f-458c-a8b4-8a8fb2a7877c@amd.com>
 <aShb9lLyR537WDNq@casper.infradead.org>
 <aShmW2gMTyRwyC6m@casper.infradead.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <aShmW2gMTyRwyC6m@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0524.namprd03.prod.outlook.com
 (2603:10b6:408:131::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS2PR12MB9749:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a2a53c9-1a2e-4cc6-771a-08de2dc5f9be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TFVCNmVjNVhwTmpWUmlDZU5FSXF4ZHdHUXpYdmFNS0hGWnMrYVlrcnVITXJu?=
 =?utf-8?B?ZUVJTWFQd3VKRy9VM09uejQvVkRuUW5TMW96TnVCY25kdHVaTW9KT245NGZI?=
 =?utf-8?B?S3JmQlVIdHNtdmdEZTh2cnRkcy9VWEVHUHluTlZOai9aM1ljL3BxNDB6WSs2?=
 =?utf-8?B?aUZmUllISUhkajIyMzgzUk12THBTRFZEOGVSMXNiMEozY1NZTmh0QTFZVWJ0?=
 =?utf-8?B?R3R3U1NYUTd1NXVxa0ZmQjludWpubWtQWERzcTVoYzNDencyMCt3YVFIZ1VQ?=
 =?utf-8?B?RUVwUXlHQ2tjaWVncHVLREFIYWhvN2lGSU1PY0FGeWxJeGVEZmhtRWNOeXhV?=
 =?utf-8?B?bUZpMUgrZlFMczNSbEc0V3R6ZjBBazdNYWZPK0tmYjM5WkxQRjhsQ25wamxm?=
 =?utf-8?B?M1B3MUVyUTA4TWlTZVh4MkF6TXdmcWFYQ3BQbG1BZjd2ajNONHJtOXUrWmR1?=
 =?utf-8?B?c3FjenNLWk1PeWxEdnJvdk9OSU0ycERqZUtTcUtwcE4vVUNGQ3BkNXpPSnVQ?=
 =?utf-8?B?dGQ2T2N2dHUyaG1Zc3NBdUlXVXppMjF0WTROQU5MeTJVWTVtTU5LQzQrZUF3?=
 =?utf-8?B?SkVvZ095NFR3UHlOZUU0QktMa0N4dzhlMnh1MThVUHBmR0xOOWIrdlhybW4v?=
 =?utf-8?B?eWNJVG1LODVBZGljZFBETFJvZWtnNXZ1TTFrbTBJVjQ5RzlnRmU5bkZpYlVz?=
 =?utf-8?B?VlRHelNDNmpZYjBOUmpWR1hMd0lyczdDOVIzaXBHelFHb0FhYlhidWt0dVVE?=
 =?utf-8?B?YmE4NnFqbkdoWWZDa0pZTXpmYXFkL3FkWjRHUHptNGJBOHp1OE9KL3ZjY09m?=
 =?utf-8?B?NG45WmFkeWFPN3JvbFNwUmQ0dlFVQ0tPVnp1WjJXTitVM0hPalhyR05pTmZU?=
 =?utf-8?B?cjFhcXBKeWdUaFZKWS9qZlc0NVY2QnFVN0NEZmFnZlQ1UjdKT3Z0Wk9US2hH?=
 =?utf-8?B?RWlFY1U3bUgzVzQ3aWp4Rm45UmNGZmhLZzdMNzlEeGF0cDUxcmtBYW9xVmcz?=
 =?utf-8?B?Mk9uK3JOOUR1SFF5dUJFdk4xMjQyNnkzbGlNU2l2K0JsbWVMNUNqMG9zQ0Zn?=
 =?utf-8?B?RGpzSy83NzlsUDQwK1VyMDM4dllER3FNQjdnQUs4NHp4NFNiT1h2QlovU0ls?=
 =?utf-8?B?R3had2dYZnk0Tk9lUjQ1N2lrbGtEVk83bTdCZVRIa2U5QjhFQUR0SG1vS1kw?=
 =?utf-8?B?ZU8xWlRzRit5dDF5SXZQbzQ4YXo1ekFmQmwzOVIxQ0t3ZEFsYWJXanNkUjJn?=
 =?utf-8?B?WEhrNUJDRHJ0dHF3NUZ4ZUZjZ29haDR3TTRoMXdNZlluVjY5Q0NOYkk2cUFC?=
 =?utf-8?B?eEZUSFlERFFESmwzcGFqN1VqS1Rzc2ZnbGo5QW5TU0FlWm41alZ0K0tnaGx4?=
 =?utf-8?B?RTF0dWZKeTZJOFpnb2xaZGhNQzBFOEcrVldqa3hrOVdMK0pLNXNFanVUR0NI?=
 =?utf-8?B?b2x2MTM0TEk1VXlzTmdZenFTT2U4K1dHaVowTnJOZmZRTnJoWDdOUVRna3Y0?=
 =?utf-8?B?Rmlyd3Exc2lyN01iWjd3NWRwSVpBK2JEZy9xQytEdnNLYUtQWHpjcVp3dnE3?=
 =?utf-8?B?S0tDOExWMFlKTTlvd0p0SzRYU1B4VWc1RjV5U2l6enNRd0dUZWkzdzNtem4r?=
 =?utf-8?B?QU9xYTBCVHhxS05jZ2FZWXVENUJsTzV5ZEFjKzQxSU9hNmVjRUx0cllNZ1NX?=
 =?utf-8?B?KzlJbXdsVDNrVVlPMFlrRFN1Qkt5RUp6UVU5NEVxcUI0elcxejFNNTVYYVd0?=
 =?utf-8?B?UEpyelhwVndZMnE0VWtJbTdqR1duUVExZEhEYm9KbU05VmhBcWo3VTFIUlJm?=
 =?utf-8?B?TXR2UGVvTmNhUXprUk9PY24yK21aZWdFOThScXlnK1NLbHFPZXc5WnJMeURa?=
 =?utf-8?B?LzY1Vk9KY1h6cTVmZ3BYNGxKWmFOQUdxK3JKaHFIT1RZaXBtQkQyOVBUVEoz?=
 =?utf-8?Q?3ChM1Tzt+UgOyxEt2btDcdGlR75XqvF1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ay9ZSVlrU2ViUitnd1V0ekRGZVNiZHR6dmU2dnFiNkt2VjdESmNHUlNBaVlW?=
 =?utf-8?B?V0ZtWU9aYzgrRlBrL1QvbGp4dlNTZWNKbnRjYjFpSzV3VzN2MDdVaUFST21C?=
 =?utf-8?B?VXV0S1ptbjVpOXpmZkwva1MycGFIc1VZbHhSTFJiMVEzVWhlVTE0WXd2K1ov?=
 =?utf-8?B?NldRSlpmaEhyQmtSemN0c1VGWHI4OUlaRmFPU2V5UXlsazZUWnBnUDRKeGgz?=
 =?utf-8?B?R3NMYUIvRG9jTUNTQU9PZXB0UGw1c2NubXQxUzljQkg1aXo2SWh3VVYvcVlC?=
 =?utf-8?B?ZTNZbXk1bDhKTmlWVkpFVjJ5bzgrYXpaUGtnUTJTVCt1UThhSVpaRVNkMWdR?=
 =?utf-8?B?THgrR2pxbGhIeXRYaE5OeTBGditTTmk4UVRIbjM1WEVMSHlieER6dU0yNkJh?=
 =?utf-8?B?ZlRzbmlndjE4TDNBcFd4d0J4a2RXVXB4M0JGSy96NG1GZXZRcno2dmFITlRI?=
 =?utf-8?B?ZDFnbTVvMnluWlI5OWFRc2F0SzhZYm9sdGNHQ2Vua2NqaE14V1RQZkg2YnpO?=
 =?utf-8?B?YUdlUEY3TlljY1IvY0g1ZkdFK0xTSE1qaFV5Sml2WWlyVVdrTWptbkdMR204?=
 =?utf-8?B?VDJQd1ZLVkg0Z0dHOHJVdi9wQURHUHAxQ3RxRXF6cks5YWI4dVFtaFNyMTdo?=
 =?utf-8?B?Zm1pc2V5OFgwZ0lUWjd6ZHJVSmhoUjNHcnlHbGJKZHJGQWZxeXhodXNoK0s5?=
 =?utf-8?B?RWVDejVLZEhzK1hjVWcrMFo3ektLNjVWZHhkUU50Qk45TzN4VzZ5R3lsV2tn?=
 =?utf-8?B?NndWRzBucUFDVFNnZlNEbDU3bFBxSjdDaVpBaXBhemJBNjJzY3BUaWtNUWdG?=
 =?utf-8?B?bnVFc0hNV0J4TUlmcUlhNlpDdjlrQ2hnNUxnc3VTWDR0WXQrdnE2d1o0OXdS?=
 =?utf-8?B?UFhxdE9uKzhWQk9abGZ4RlVoS2RVK0Mybnd0VkFybkpFUEtxcy9lK0FBaVpJ?=
 =?utf-8?B?aWU3RkpyOTRCVzdRdHdJSzNvVjRLeGRiRTFieUI3ZFo4S1JDdXFZTERBMlNp?=
 =?utf-8?B?TUVtMGlpMEZSVGZHdXFTYUVuRFV6S2UreTBtSWFvb203OHV5V3RYLzEvL0ZS?=
 =?utf-8?B?QVVZUVhtbHptWTRiS1dnbGlwV2hTWlhiUDRHV3NlYlM1RE5RNEw5d05XejF2?=
 =?utf-8?B?YVU4bzIzYmhUSE5pb0kvemlWNnkrRkxpQnBWNmF3ZkZPVXdGRkpRa3V4RDVR?=
 =?utf-8?B?N3BYSzRWUGh2V2RwZU1DSkM0WWVVcXlweHVJazF3c0FBRlVOaUVYUDN6SUxI?=
 =?utf-8?B?RWRwcmpSZnRjczF0QVhFS2RhYTl2aHhlZjNTRnUxbHMzWkRLdGRrM0JmMktj?=
 =?utf-8?B?WUZQNGNWcW5PYjh0WTE0TmdpVnpWa3d0VjNCQUQ1d2pwRW1hTklEVVJVTW5V?=
 =?utf-8?B?LzJXcCtOQ2RxRk10M2U5RUdIRUZLbzV6QURwOG1LL1cweHlZLzZTT01KZk1U?=
 =?utf-8?B?OUtKcitWNXVMdXpOVHhFTlk0bkRFSWJiLzJ1NklhdXhzUmhyWFgvOUdnQTFX?=
 =?utf-8?B?ZHp1ZVhqUkMxT3BxZ3pDTXllWmdQRDRmS2Z2ekxSLy9xVTdNSUxXSWlxc1Zs?=
 =?utf-8?B?Z29Dek91VE1NSFRCeGFKblBrVXhSYS9uY0VMc0hTVlpIdGljWEdyTU94dFQr?=
 =?utf-8?B?VUlnM3IzNHBqMW1KMTJGVUtsUWk3ZjdOQys4MDVJM25uQWplMnJIZzUxTDJq?=
 =?utf-8?B?QTlzRUhFOWlmUm1xTUNQWTIyeENiV0VqM05WOTNaa2RMdkV5MksyUncySTZv?=
 =?utf-8?B?M0JKUUVLVEhEMFBKQ3VOV1p3QzMxVzFzR2pheVN2WjBnRWtOZThsNGI5eFVV?=
 =?utf-8?B?N2V3aTU0WjNmdUdvenNMeGRLM3hmRkROYWdjWU5rUTZmZ2N3UFJjamVURU16?=
 =?utf-8?B?aEZqRW4zUnJOSklTY090ZERubER6S05vbjhnbU9IZkg0eGlIakVPckdidW9Z?=
 =?utf-8?B?VXBlMHhWSzFRRGFJNTJSUndQbFQ3SlVkS1NKQ00yeWFuVVlBN0U3MmhYZndn?=
 =?utf-8?B?eTN4NlNiT2tWNEdHeXpkbXJ4Yi94aVVHUGthTlVKNU9iQnFYcDFtaDc3Y3VK?=
 =?utf-8?B?MGRlK2F0UCtHVXl5UnROQ3ZBdFUwTGVpODZyaDdRMDFMaXh5N0lDNHFveWll?=
 =?utf-8?Q?gcYrog5vb9+KMotC+u0N98/DH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a2a53c9-1a2e-4cc6-771a-08de2dc5f9be
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2025 15:02:25.6675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C7N1MVD7SZpx5WpYq673BmSBa6dYj1J58zPQguhqqna+EtWMfO8efI1N3o7o0Mux
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9749

On 11/27/25 15:55, Matthew Wilcox wrote:
> On Thu, Nov 27, 2025 at 02:11:02PM +0000, Matthew Wilcox wrote:
>> Hm.  That's not what it does for me.  It gives me id == 1, which isn't
>> correct!  I'll look into that, but it'd be helpful to know what
>> combination of inputs gives us 2.
> 
> Oh, never mind, I see what's happening.
> 
> int idr_alloc(struct idr *idr, void *ptr, int start, int end, gfp_t gfp)
> 
>         ret = idr_alloc_u32(idr, ptr, &id, end > 0 ? end - 1 : INT_MAX, gfp);
> so it's passing 0 as 'max' to idr_alloc_u32() which does:
> 
>         slot = idr_get_free(&idr->idr_rt, &iter, gfp, max - base);
> 
> and max - base becomes -1 or rather ULONG_MAX, and so we'll literally
> allocate any number.  If the first slot is full, we'll get back 1
> and then add 'base' to it, giving 2.

Oh wow, not every day that we stumble over a bug in such a core kernel functionality.

> Here's the new test-case:
> 
> +void idr_alloc2_test(void)
> +{
> +       int id;
> +       struct idr idr = IDR_INIT_BASE(idr, 1);
> +
> +       id = idr_alloc(&idr, idr_alloc2_test, 0, 1, GFP_KERNEL);
> +       assert(id == -ENOSPC);
> +
> +       id = idr_alloc(&idr, idr_alloc2_test, 1, 2, GFP_KERNEL);
> +       assert(id == 1);
> +
> +       id = idr_alloc(&idr, idr_alloc2_test, 0, 1, GFP_KERNEL);
> +       assert(id == -ENOSPC);
> +
> +       id = idr_alloc(&idr, idr_alloc2_test, 0, 2, GFP_KERNEL);
> +       assert(id == -ENOSPC);
> +
> +       idr_destroy(&idr);
> +}
> 
> and with this patch, it passes:
> 
> +++ b/lib/idr.c
> @@ -40,6 +40,8 @@ int idr_alloc_u32(struct idr *idr, void *ptr, u32 *nextid,
> 
>         if (WARN_ON_ONCE(!(idr->idr_rt.xa_flags & ROOT_IS_IDR)))
>                 idr->idr_rt.xa_flags |= IDR_RT_MARKER;
> +       if (max < base)
> +               return -ENOSPC;
> 
>         id = (id < base) ? 0 : id - base;
>         radix_tree_iter_init(&iter, id);
> 

Not sure what it's worth but feel free to add Reviewed-by: Christian König <christian.koenig@amd.com> to both the test case and the solution.

Thanks for the quick help,
Christian.

