Return-Path: <linux-fsdevel+bounces-29068-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA4609747AA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2024 03:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 085D31C25731
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2024 01:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49731E87B;
	Wed, 11 Sep 2024 01:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="S4tYH/XU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2084.outbound.protection.outlook.com [40.107.255.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6E61863E;
	Wed, 11 Sep 2024 01:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726017258; cv=fail; b=fKpYSJ+86CMjBh8OE6YMFt90uj7NZPA6H8iU0jEGHcRdJrLMPsnbt7DoA+3C9MzjmkmRpHn3sY+T+2nzX9m9MY/MFb0kLuIo01XOOn7vKwHRsGoh+xoNzdsHCSvwjc8CFjz9TZu1r6kKbELvrYovieS8WdXJv58h+88PEFORIQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726017258; c=relaxed/simple;
	bh=+shNCQ6x4pTRE4v1lC+G/8bduxdHLLbT8jRprZ9KvXU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=s1oCSadHXZdZ+DMV1/WJAORFmFqK2Ll4SlJShSLHl4YVUOXZWPyPt8NS/QaR0CsEB39Wy7RTCnRICiliJ8yuxCAm3evfdZkVgo3Hd3QzuoP7FiQDiSG7BV0wTQr4p+3EPfwKT9M2dcDU4oYwgn6qV1IcKyRzY0nIK9UT6EmP2sQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=S4tYH/XU; arc=fail smtp.client-ip=40.107.255.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ozJPvGDt4oKeAkE7Nx+V+GAO57FrzWWmzR4nElui/oOSz+iuJhe9EBz2lHrXcqa5XqnHYOZLp9jpXlduZ3iF86Jv33Sc3+nUL804niTFRMzfSdKW1fp46bQLOQcVgKlvMy+YUFeiIzGw+Le/t7V/ZKEium5MNJrU3gIXDZWomjAh5xeVkmSeAFJUmYxkrzTPmjwTFxJpA8eSvapvWjN+IAcTY4or37dimtbFHMgLQf2Yn4QPHsg1njbBameKKtg0VHEBrhB6VopF59yrN74PfvLKOElQH8Vdwz3z2va4TKxwCpYribT47mn8KhkPYuFXaimOfRLdV5EuW4DQobY0Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2WIOrKozJslxUsEyfmHB7zyrcPVx+EC8nM7bCYNLj4Q=;
 b=oM1WmyYCQ9nB9N1S2L560Ta22B2d/hWOOFm0QGOVefODq+Zsd3J9yLkqp04Eb7/qyHE9OfLSiydms8G/FimNLCU10KeL3uvl3sZG8ZQbO7+a7RyIZRpZHFl7bnRwju/eGBABz8pHlIhNNAEmeX0csO+ooKY89TKZBi8EnyyOor7iVF4klx6QPmhozNqzYjg0NUQJf13zpuimX6/PT2h8z/V0rw4lp+E/t24S0Ng5TN7E1qAdid/7v3l0S3vQCvnqb07DHpU0ak9svumLVsHova3GW8RKuZ8RXTvY7/rzkBWRY0+9cLEZR92TNbuBpGOSvvwuEalX07dsSVSWo5CyHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2WIOrKozJslxUsEyfmHB7zyrcPVx+EC8nM7bCYNLj4Q=;
 b=S4tYH/XUek0HoI9H4EikTDj/xfy8Nmkm/edsgKOafYe3rz/bsqTmG7ODrSsiX47nALeW35NG9rDWBVeOwdJptOzL9qSmeqK0HGreCFBmOThAqmJdxn4gH6OiECkDxPkcCyl97UhsvXj8pYd4y3iAou1IrxUQzqYDrk2fzZQyiFqV6zIHkqpfv8KRSYSF0Nqi1lktA2Ipm9KC4oPk6vHgJe4kbGb80QMULFzqWm7tRQ9BgGAxh0gt+hdUvQgmSBlNBhBeq9fA3LPtliCu19oZeZwquUrhG5OzfWb2CfOcdbN1i+m8HeI9r/rGfWgfk83Y+gG20cMMq6Z2XBamAahxFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by TYZPR06MB6916.apcprd06.prod.outlook.com (2603:1096:405:42::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Wed, 11 Sep
 2024 01:14:14 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed%3]) with mapi id 15.20.7939.022; Wed, 11 Sep 2024
 01:14:13 +0000
Message-ID: <4a308d13-932a-494e-b116-12e442a6352d@vivo.com>
Date: Wed, 11 Sep 2024 09:14:10 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: remove redundant if overhead
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
References: <20240910143945.1123-1-justinjiang@vivo.com>
 <ZuBtvW9TWCnHte4V@casper.infradead.org>
From: zhiguojiang <justinjiang@vivo.com>
In-Reply-To: <ZuBtvW9TWCnHte4V@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0126.apcprd02.prod.outlook.com
 (2603:1096:4:188::11) To JH0PR06MB6849.apcprd06.prod.outlook.com
 (2603:1096:990:47::12)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|TYZPR06MB6916:EE_
X-MS-Office365-Filtering-Correlation-Id: 21cf5b41-6527-4fa0-a1d3-08dcd1ff0c1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|43062017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WXAwTmxjZnRhTHpNc2IyeU9UeENqYnV4djdMVW5uRVZwNnh4V3AzYXU2YXFN?=
 =?utf-8?B?ZnF2dzdnZ3E3WmVnYjNLdGdhQ25yNFJ4L3pUOXdpeVpXc3RoaWNzeFFtSjdV?=
 =?utf-8?B?dzBaWTRMS2lNaWhUSDlIazJWbEE2aStobVBIVjBlbWpBRUdNU05nMjhqVFFs?=
 =?utf-8?B?OGV4NWRDVkFJVUpLWWxNZzVibkRaNVhOL2RwVDZId0wya0wvZjFqNDd6KzQ0?=
 =?utf-8?B?YVY4QXVEeGJJOFZSOTZnT1FpRkN0Tk1mc0tpdnphaTh3bEtwdW5wTE52c0NM?=
 =?utf-8?B?cGlRODhZQnVPM05ZSDZDd2JSckozN216dFdyVHRpa0JGK1p5SGRpK2Erczk0?=
 =?utf-8?B?WHNheTZuK1VONng0UWtrTGZSNjZoTHcvcnRydFRNQzBSbm1iNncwbGVra1h6?=
 =?utf-8?B?U2drVCs4UDRpTlhsZ21YcHhwUklubkVYa0ljeVFUOXF2aWpIVUxMS0NzNlFR?=
 =?utf-8?B?Tm1UYjJyRjgzSjI1WW9QRlBERTBEaEhYZ2tybjhSc3BOczlWb0I2eHJzVzd3?=
 =?utf-8?B?RVBlQnhyMTFEdklMdzNuL291dk9HV0d0MEF4VVc4L25VcUZLbzc0ZWlUbVV5?=
 =?utf-8?B?MnpQUWRhZmV2RU9pTUZrWlNWSWx1alZINFQzUlJEY08razltOGwveVNQNGZu?=
 =?utf-8?B?MVM5anh4ZHVIQXMrTkxyVklGUHkwQWgzUGVrMkxKWCsyUk4yb2VhajBIUmhO?=
 =?utf-8?B?SFYvSCs0TkVOZTJmSlV4bGFPQ1k4TkRJcHV0Wm8vZy9nbTdKdyswUXF5c1Q5?=
 =?utf-8?B?OTlpeFFkSlFiWWxvdTRKQUlWcUhrNHk4TmtnVFpyd1Rrak1JVjgzK3hVcDJO?=
 =?utf-8?B?LzhYZDFOV3hWcUlRMnllTTUzeWs4cFNjcmhQMXlYVmJoWVlYZ1h2cjNzSTZF?=
 =?utf-8?B?RFRnN0pJdlpjYmF3cmRHejQzUDNJRkdHangrL1VqWWdWK0JiTVlDL2ZySGVq?=
 =?utf-8?B?b0JjMEVOMUxHSE84NFlEUFdrU1NscHlaL1ZSNHpyL21ZbDhDMHhiV2xhWmZa?=
 =?utf-8?B?TW02VDJUZHd3R1o0UWxaT0xYOGpPL3A4cG1KSU81WUc1TEFOS0R1bEhmTFZM?=
 =?utf-8?B?TWZaTnBrbC9OUDIyWWtMVzJjYnNRSWg4TS85MWh3aU9rVkJZRit4Uk91MTNU?=
 =?utf-8?B?MzNla0N2YU5iRjROdTM1d3JZSkhIRHgxQ0ZnaWlPbkZhSHg3YzFSdVh5RWt1?=
 =?utf-8?B?RENLckVFaFE4MWdtTzZQaWUycmpXYTA2dlJOOUJBWU5wcU5vK0tmVS9jRXlF?=
 =?utf-8?B?amtNUmEya1o4NW8yN2JoVlhZaHZmeXhlYjd0UGk0dUUrWmRwdmxXd1o3SzY5?=
 =?utf-8?B?Zml0RWpqalIvZmVzNmdEWlpENnVpWDF5cUhPdGFrM0dBbUVoY0pIQm1aRjNj?=
 =?utf-8?B?MVhNNXlQaUZIbHdER0NsYWNqUlZkWTNMbmszeGtPemdEZ0FyaTNTOGFXa1U5?=
 =?utf-8?B?L2J3aCtqRWMwV3hLa1A5eWhETTIreGsybm5HU2t1UkpFaGhIZmk0OElrN1NG?=
 =?utf-8?B?czhRN05ud3ZhY3FOTzRoLy9wVFdDaXFXRzhzU1FhNmFwZFRpOUczWkVLUEIx?=
 =?utf-8?B?VGkwWTlpRnBNazNkNjZHR3o3OWpuSkNDd1ZkQWEzeCtYZEViL0ExbXFxMjBl?=
 =?utf-8?B?dllWTWNIQTVYRi9WNmxkVFlJRXY5UnYwZGh5WkRFUjV6ZzBLdTIrMXUxRlV0?=
 =?utf-8?B?WitPMCtGeEtYcTRudGo0OFREL0pod1M5U2FrV05heW8raUlwejBqbTZWNW1v?=
 =?utf-8?B?elNOdlBlVGtDQzh3cWh2bHk5cVdpb3gyKzdOdzB1UzdhekdYeUw1UDdITUYx?=
 =?utf-8?B?NnVEaVlzWWF4UDc1VkxvQkhQWEpYQmM2T0QzUEJIaFI4SjdNS2haR2ttcU9j?=
 =?utf-8?B?bXNKMnhwRVRneU56T2JRVFZQSkhlSUR0YW9GcTBsSjcrZnc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(43062017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T1pUaTlNVUJYN3d1UWRCN05FUGlBOVdCUmJCQmN2OHFMNE4zTFU0cVZlMGli?=
 =?utf-8?B?azlkT1RrcTM4b1ZTcjFEZ0JtbFM0YkQzRTE2eldLWGcydW4xYUx0czM0bEp3?=
 =?utf-8?B?V3FQV0xYNHlUOVNRRnFCbVRKV2drQWFLK0hsVWhKSzJBSURDSjUyMGwveUM4?=
 =?utf-8?B?MVh3QXJGbzc2K3pMeUFkdUN0N2dGQ2FUSFpmOWQ5UGJSNmxtRmpzVFRuaFNW?=
 =?utf-8?B?eEZKbWtMY1ZpdFFjelBJT2U1RFNON0ZlOFh0VnlrVStaN2ZjZ2JNZW5KYmtE?=
 =?utf-8?B?MDJtc2JkWWJ3WjgrTVpKNngwU081Mm9uK2xjNXFHeVpDSHNmcm5DOE5lMEVh?=
 =?utf-8?B?S2NjK2w2TnVncm1ES01hY0RqV2JkWGxxTnU3ak8yOVRjT3REU3Q4Sm56TXc2?=
 =?utf-8?B?WlhDRm1ZcVB1d2llcWFZM3QxKzdaTWZOb3JRTEU0cEprOHJ1aEhZVWtDNzJj?=
 =?utf-8?B?WXFoTUlkbGlZMS9qak1KaTVGWFFOWlMyaHNJVVMzQUppQTFFQXR3dWc3ZW5W?=
 =?utf-8?B?Sk1YSWRHdlJTUW1qa3Z4ZWVqY041TGdleFk0Slk2WUlHb29jUkN0amVWazlR?=
 =?utf-8?B?MmNwaGNoTEFiZFI4VWZOOERNc3UvSy9Db0U2cEVpNkw4SzdDY3ZFT2dkZHE2?=
 =?utf-8?B?RHRiT2x1M2pZUmRTTmd4TmpOOExqYVZIUnBOa3ppNHpYeHo5aUtBSWxTcEl4?=
 =?utf-8?B?MWZnYzZpMGxiYVhnQWM4L0txUUR3K0FLUk5heUNhQjBEMDBOSUVaUW1zNko3?=
 =?utf-8?B?b3BZcVBITW8xZTcyZEZOUFI5M3NSbHoyQVlCQ2FkdVduSXY4RGQ4VEtHZENQ?=
 =?utf-8?B?WXJLUHVTSUV6bkN6T2ZING5uVDZzZ2tHV0Zwbm03V0pSdTNwNTJTczRpdmVX?=
 =?utf-8?B?aXJZdDNkb3loYlArYkFzSnovaHVVVHphcWs4Y1RPWkNFeWRZSXdiY3VGQStF?=
 =?utf-8?B?UTI5S3g1R1I3RFJNVkNHMm5yeS84ZzJic3I3VTNqWnFYOW96bTlqQ3BRS1cv?=
 =?utf-8?B?R2VRWTMxT1pwd21FN1hiSXExVHhhVWtsT3hPc1lreWU1OUhaeHc5SU1hRmRX?=
 =?utf-8?B?QjRNcGtBeU02aThkVzk0TmI1Mlc0ZHQzNlJxbW1yS2tuN3daeTN2a3pmNFN0?=
 =?utf-8?B?TWV6cGpsL1VOMitSKzZuUDcwd2FJbDI4V0dQd2Qvbng2djlncCs3aDlJNzdm?=
 =?utf-8?B?bDFtWGprK1h2Y3doWTJod2R2ckdyN3padThwejJzeDhCS09CaHNlNFpHdWc2?=
 =?utf-8?B?cFNTZXJSUUh2alM4WWJMcy9WS1NEMnlVQlJRbWVzNzU0VlczeDlWcEZVdDVu?=
 =?utf-8?B?K3kzZ2F3dFp0VVY3M2dFV2FOTVFBR0JvUldPUFljN2FWbnpxcGpZY0RNMjNi?=
 =?utf-8?B?TERGbHZvc0doaVIyYjIyR2R3bDgyZE9GaWNISWlIaW5URXJXV0RpdG92dnNl?=
 =?utf-8?B?ZWF3c0dqVDVXZmhQbUJ3a3d6cjB1SVl4ampSQS9nV1pBRWhTQThDTERrUG5T?=
 =?utf-8?B?aU1sUkFpdG1VV0tERmk3OXozUFpkYlJXMU92S2RUcGdrb3JKRXU0VWd2MFor?=
 =?utf-8?B?aThxZGF1SFVIOExEL2wwbzB4bUNkS3pwaGlDM1JCRk1jQ0lJRmFXTFZyYmRO?=
 =?utf-8?B?aW1qRGpOajVCZHBSVDZzTjZDYlZQU2NtRzRPSVVvem9JV05VTHRNMGxXYzV6?=
 =?utf-8?B?UGlDU1d4ejRGOUlYWXBBZTh6RkgwdXJyTWpMUERuellSaVZXbVFSZmhBME5Z?=
 =?utf-8?B?cnR6ekFzb3VMVWovNXZvL0htVVZRN1dQMCt2VTlkZHNxRmlhR1B0UlcvUjIr?=
 =?utf-8?B?M2hCQWxCczZlanZNS0E3S2NPUTV2eTc0cXNmTEs2OFRsejA5SzNpdW9zeDBZ?=
 =?utf-8?B?KzZjM2Y5RENnb3YvVkRLNGNHbkc2Yll5WTEzMmNIeDZndFBqTENjOFE3QkJH?=
 =?utf-8?B?UTFIeW5zRGhKNHlTRzMvUHE0VFlSMmgwQVRySXFseUtYRnB3aHNhM3IwYUxC?=
 =?utf-8?B?RzAwSHBUMW1XUWM2N3dMYm53emE1OGV3K001Yng2MFhkVFJ1cWlwb3htb3kw?=
 =?utf-8?B?M3AxODViYmZiaDA1bUgzSTllWEpQaHE2ZnlYd2toUnNQRkU2dUowRG1SMUxv?=
 =?utf-8?Q?/VlW+m0j/l6AHTbCakPPG+CvU?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21cf5b41-6527-4fa0-a1d3-08dcd1ff0c1e
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 01:14:13.1740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dCoyKig7w+4hmrft2GXdbLaT9gscCaY593+jUw8wADEh0oBvNAVaEOBVGI3vzO0QSu9cpljMqKw1JHavD2oyWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6916



在 2024/9/11 0:03, Matthew Wilcox 写道:
> On Tue, Sep 10, 2024 at 10:39:45PM +0800, Zhiguo Jiang wrote:
>> Remove redundant if judgment overhead.
> It's not redundant; it avoids dirtying the cacheline if the folio
> is already marked as dirty.
Ok, Is it necessary to add comments here to explain and avoid readers'
misunderstandings? E.g. 'Avoid dirtying the cacheline if the folio is
already marked as dirty.'
>>   bool noop_dirty_folio(struct address_space *mapping, struct folio *folio)
>>   {
>> -	if (!folio_test_dirty(folio))
>> -		return !folio_test_set_dirty(folio);
>> -	return false;
>> +	return !folio_test_set_dirty(folio);
>>   }
Thanks
Zhiguo

