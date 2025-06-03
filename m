Return-Path: <linux-fsdevel+bounces-50493-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73FAEACC8BA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 16:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 250EC3A68D0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 14:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F5E238D3A;
	Tue,  3 Jun 2025 14:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ZvdbtNjI";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ZvdbtNjI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011018.outbound.protection.outlook.com [52.101.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5875E72618;
	Tue,  3 Jun 2025 14:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.18
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748959693; cv=fail; b=fZaQ8vA9zGQoMu3vCO/FkJ9FUtqH1ObVSvtt8eCCdiKU9qaFdlkxP2UNOy+zoxyuhW+z7+7ExfDch3kdG/1DzC9pH6BBy1aXVIi9vIoefYqWyookvTr2DdZUwUQZCTYeJ3DqA6OfUYoYtxWtP/d5olQ4FKrOmZlUh4E9v9akcS0=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748959693; c=relaxed/simple;
	bh=+X+KvwSbpWD5LbgnxX9A4KQVNeJKt6X1HcMArLXLFvg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YWjVxGrSaCSKT1E4TmVawTWsN/g7Ybj0IVcbRGcFyESbNCuL26i1N0W06Iipb+mVWhwnzP6C5I3u8YRkz1oVcHTBrQVYc3ZGsUKno8UisQpfbDBi/q2xYj9A7+lT/EpjrVJtG/SfCVzYhzEhMkgiLwkr2somp99++WoNceXQpv8=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ZvdbtNjI; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ZvdbtNjI; arc=fail smtp.client-ip=52.101.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=oIxaJkBBH35OosVPFTFMDDSw/Oqdbz1vL6vEiL1ehnk4GDLqL/4xj5pFVVlUwQ9qrAGb2TM0Lfm00iGX0znPcdg3MJbB8ycnyvPPODGKkQkhQi1SW3I7QGCi9P4jIkLBRa6Fxe9pTUz0nOlgxZXpgN13pf8lHpUCVlnhGUTz2rpdZ2oXWgdRTmSvWVcVidnbJ/uurTmz8xv3c0BH+oSkq8RDov5yoq92tHM2ISLMms7PRxB/uCiB7q8KAAIHbJ8MZ18ssKbZYPE2K7Dpz215eOzLbZ0Q9N/bL0puVt+un/9aBIjqGvMXhPB9cinQxLAd4HErvg4yNxVO4U8pXpnULQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+X+KvwSbpWD5LbgnxX9A4KQVNeJKt6X1HcMArLXLFvg=;
 b=Sdct02zIYf446gvgFiGbIdWPg7ljJ+9eMJuplaGgxRtO8EXEOUbLzJVjUJTnxj0osWvJghZaoZspoBK9crjDB8ZiWW6choBy28nX2oOL7+zht/UDTuVc+/9VWQV6rmoCzGEgekrScGXtN+9Wpww26C4LVKJSVxrOMZnbzYZuRuVuw83c8M7KXFsVzXBQp/p7hUD3IqJ6+SqYukz4ulV+6rrel4gNfrIAXTnXEuKV50EIKTRG0hYonZl+bZddQNFVdhl+Fv2LXYUBe/GoDzHo6mZN+vqt2RhOdM9zj3SN4zdg9c0zdALWyfyuIB8iLx7SFzycLXe9Dq/0CMyjnKGE+g==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=nvidia.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+X+KvwSbpWD5LbgnxX9A4KQVNeJKt6X1HcMArLXLFvg=;
 b=ZvdbtNjITbVIDzyQUPUXklFiM1WrlXI4y7/DD1Y55LJmHBuLgNa8yhMxL6HIzc87Kah5whGfIc3lCSNTakDr53KiyMRDRYVj/lDIgwzvZlKEKWXbEpa5kY9TjuRHZTJHNBNRSdMXI2v93UDV9RsUesms58TZU/+XJl3pv/amccI=
Received: from DB3PR06CA0008.eurprd06.prod.outlook.com (2603:10a6:8:1::21) by
 PAXPR08MB6398.eurprd08.prod.outlook.com (2603:10a6:102:12d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Tue, 3 Jun
 2025 14:08:06 +0000
Received: from DB1PEPF000509FB.eurprd03.prod.outlook.com
 (2603:10a6:8:1:cafe::a4) by DB3PR06CA0008.outlook.office365.com
 (2603:10a6:8:1::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.31 via Frontend Transport; Tue,
 3 Jun 2025 14:08:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509FB.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.29
 via Frontend Transport; Tue, 3 Jun 2025 14:08:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jJgClV3AGBgney41N2+Nz8pN6SLaVUY9pxceEbUyvgVyJkrLgw9MV9L5cw7KyvPAAnlBsa6ae2aslMY/7YRC2DFuN9i36SfVY6bTZdktKbew5iLguwHquxcoXP82ourMOFWEvcXYyli1qD4SgS9nMN05zB5SZpL/dNZ4AALdYcO8BsjZkxt37Pz9LSVRKSny/iuMWhs3ZMTQgbTJC2K4I8ndHma1ITkSfeaWcyDWVOKAjcHtne5RCioL607BZGrBlIvP5Qu4ngaPOHdAzFO9n6/iIpE199cV/p/ZRAVXMFnad6rW8Or0mT7h8ofgO2NOqka4gTZV27/nKKvjMNrJpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+X+KvwSbpWD5LbgnxX9A4KQVNeJKt6X1HcMArLXLFvg=;
 b=T92CNyfyin2kFBNyzrGNUUZUvel/tdMGWQM4DDDsKrAgjbhQ8bSKB8CZfpaIpA14Jpv3nHZR3gRS+J78C1xd7G8XpBEQjJD2faxhZZ4lVXCoBEOZ3sIM0sqiNxRvnFC0aPqvY6N1tSu8W8hdr7XN0e99bj7TqH6e7eec3RssZW9bd1yVOzlrBkNmutLrQD6Fou228dEbU258nyveDHnGaRDH7yVnSWfreAf+3Qyrw5gb8kzz+AoxsJH5YTx4LnARSvk+2rO1TVQRXd5aVvdQJCDSip0IlHqqz81f0Z3z6ExB0fj7dTLA65DUxs39JDasjU184ortxmh77Y1wm21D1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+X+KvwSbpWD5LbgnxX9A4KQVNeJKt6X1HcMArLXLFvg=;
 b=ZvdbtNjITbVIDzyQUPUXklFiM1WrlXI4y7/DD1Y55LJmHBuLgNa8yhMxL6HIzc87Kah5whGfIc3lCSNTakDr53KiyMRDRYVj/lDIgwzvZlKEKWXbEpa5kY9TjuRHZTJHNBNRSdMXI2v93UDV9RsUesms58TZU/+XJl3pv/amccI=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com (2603:10a6:20b:3dc::22)
 by PA6PR08MB10857.eurprd08.prod.outlook.com (2603:10a6:102:3d8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Tue, 3 Jun
 2025 14:07:30 +0000
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e]) by AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e%2]) with mapi id 15.20.8792.033; Tue, 3 Jun 2025
 14:07:30 +0000
Message-ID: <a0da82bf-1462-4c4f-85bc-bfcccf714fc6@arm.com>
Date: Tue, 3 Jun 2025 19:37:27 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xarray: Add a BUG_ON() to ensure caller is not sibling
To: Zi Yan <ziy@nvidia.com>
Cc: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
 willy@infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, anshuman.khandual@arm.com, ryan.roberts@arm.com
References: <20250528113124.87084-1-dev.jain@arm.com>
 <30EECA35-4622-46B5-857D-484282E92AAF@nvidia.com>
 <4fb15ee4-1049-4459-a10e-9f4544545a20@arm.com>
 <B3C9C9EA-2B76-4AE5-8F1F-425FEB8560FD@nvidia.com>
 <8fb366e2-cec2-42ba-97c4-2d927423a26e@arm.com>
 <EF500105-614C-4D06-BE7A-AFB8C855BC78@nvidia.com>
 <a3311974-30ae-42b6-9f26-45e769a67522@arm.com>
 <053ae9ec-1113-4ed8-9625-adf382070bc5@redhat.com>
 <D5EDD20A-03A2-4CEA-884F-D1E48875222B@nvidia.com>
 <9878157c-07aa-4654-943f-444f5a2952d3@arm.com>
 <49262EF1-2EB2-4136-A440-D3DEA8D1853A@nvidia.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <49262EF1-2EB2-4136-A440-D3DEA8D1853A@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR0P264CA0122.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1a::14) To AM9PR08MB7120.eurprd08.prod.outlook.com
 (2603:10a6:20b:3dc::22)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR08MB7120:EE_|PA6PR08MB10857:EE_|DB1PEPF000509FB:EE_|PAXPR08MB6398:EE_
X-MS-Office365-Filtering-Correlation-Id: 962d7486-b956-43b4-9cb0-08dda2a80fcb
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?VHpjNUdlZW8yZWxTc042VU5NcWJjY0pxOWVZc3NVOGozakZXQ3JQQTlFaHFQ?=
 =?utf-8?B?dFZGN3doZFV4VkV4ek9kMWVoL3hXMzF0eGVDbHVnYW1mM2dqSmxiUFE0TnU4?=
 =?utf-8?B?VmsxdVduMndndFpXbFhKTlIwRGRNdFRobXpQNjhramhQVDlrQjZrZzRNdDdY?=
 =?utf-8?B?ZEhNcWVRbDM1MVQrbTBFeUhGK0xHQzduNjNHdGhiR3hSZjhadEdGRW9sNjNh?=
 =?utf-8?B?Z3Ayb0Y4OHVuWUc2aGZuSE1SUGxBNDluVEg0bm05OXZlTGJQRlhOSm5pOWVT?=
 =?utf-8?B?SFJ1KzV5VDhvRlM3RHRZYlpmSTE4T0o4Wnp2MlNQeU1UaGYvM0VPR2dtMmxG?=
 =?utf-8?B?bHkzL29yb281aktSRjJDMDNYNkhUTDRoSDB5S2JuL3ltODgxQktNUExBSEUw?=
 =?utf-8?B?UW93dWxnNjV5MHFkMkR5M3orMkpmWVBvOFIvT1QyanFkeDd2emtFeis5OTNn?=
 =?utf-8?B?WFFkUldSSS9FTnN6NkdRQkVwMmp4ZEh4YVd5OXNBUW5tVFFLcjVlUkpJZWlv?=
 =?utf-8?B?Q1pLVWJnZktRcVZsdGNoTDhtZmZqVWtodjlockxFUzlEVGFyRnhoRnNqQ1I2?=
 =?utf-8?B?N1pPWnE0NHpmMGhtU3FtNE9uK0JJbGs4RUZxd1d3QmwwQ0ZpNjhvT2dRRkc5?=
 =?utf-8?B?UWZrSmdJMWVYWGdyNVZaNjhadTFqeTByTm5DMzZTRkZYVmxlTUV3TVBybzNO?=
 =?utf-8?B?ekZ4bGVYMWNrTFVmdlBWUTFYZzJMa0Yya2pFV1BFaDBJcDQzWkF1RWQ2UVRG?=
 =?utf-8?B?cm1Vb0M2d0c2dlBnaGpENno4dWhFS2htVDF0WUkxWktGUTlPNFcrNlYrMlUr?=
 =?utf-8?B?bVdkUDhEclk1TDNSVisyM25iRTBicVdFa2ZVSUZITXUyZHlXVHBDR1NmeUVk?=
 =?utf-8?B?VEhtalE4WWYzT05sUXdxZjZPRWIvSi8vZVMwRzhoc0ZEazJwaDZtYmhxc1Ay?=
 =?utf-8?B?T0h4TjNTTjJ6c1oxYXVKZGNZQmZrcnBwS2VSZ2lvOGIxMFpuekh0bk5YRGZJ?=
 =?utf-8?B?aGJuUWozMGpOTUdOcXZacnYzNnBGTEM4WWx3NDBKL2VEY2llakU3YUQ2WTlZ?=
 =?utf-8?B?Q0hndUwzY1VNVnZoak4wVnpwQkZmV0xTaFZaaGIrVyt1VUlZSlZpUFdXVEU3?=
 =?utf-8?B?cnpwZm5oVWJZS2dzRDc4WFUvVDdMRnJPQTZ1NWVRVUVFbDVOZUU3cmRVR3Zz?=
 =?utf-8?B?RERYZTBUUUxRTnJTZ2R6WklRY1IrR0gvamQyYmxiSTY2dTh1VFBHSW1OSXNY?=
 =?utf-8?B?TytNOWMzNVduL1o2MDVkemFnOEltRXpyWVI2VE94a0FTVjVZTkRHMkpmYnVF?=
 =?utf-8?B?dXRWMFQ2TGZuc1Q2bER5UFZVZ1AyUlZmbURSV0h6cEVZbC8rQ0VyZkEzTmU4?=
 =?utf-8?B?L3hpS0tkODVBa0c5UkYrQjVLTndpRnl2eFF2UVhNVGZyN0IxYjhJNjdXZmkr?=
 =?utf-8?B?eDR2YUFSeG9xZEp0VlE4L24xODhnejM2ek8xS1dKY1FLVlZQNGxZQmQrNkw3?=
 =?utf-8?B?SnZkaUxqQzVaKzVZMWVPNmxLeUFWUzVzdXBlN0xSNlZvNHFldnFkSkhZaVJR?=
 =?utf-8?B?L0M4YkczNnVKUWVGczlabTdPUHBPNlQrWGlBcDVKN1pvWTNHTGdmZ0VESVoz?=
 =?utf-8?B?aEprUVFVQURVOE9SZ3FBMkt3Ym5pUzVqc1pHSjBzYTQ1YUtOVEF6NFZkRVlr?=
 =?utf-8?B?bHdZWnFQbzVlWjBvcjRhR1A3TCtyWnRPbDlZNVVnU0cxRml3aWdPVFlpNU42?=
 =?utf-8?B?STdoSU8zK1AwUEVDcElPekFUMHhZWkZGNGd2cHRldDV1L2ppanA5NGxYM3Vm?=
 =?utf-8?B?N0NpWDYzRkdVQ0JLWDY1SE1RRzFKcmNmZzJvVUVvaTE3dWhyYnE3WWZleG9L?=
 =?utf-8?B?YWdLbVN2QWZiQUt3LzFzcFpWSkEvQ2lYOVlRZHpmQncrd3ZnL0QwelVUazgx?=
 =?utf-8?Q?EckzXd5qncw=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7120.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR08MB10857
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509FB.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	32eb82e7-5d58-476e-c6f8-08dda2a7fa90
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024|35042699022|14060799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U3lVNi9QckRIYkJMSm9vMFMvSlhlRmlSSHY3M2ZrdUFYL3phMEx4K1NPMld2?=
 =?utf-8?B?TkZMZllpUys3YUtYbkpvUFlXanpYU21LWERHOXN6TGF6OWVtcThQTlBVSTJ5?=
 =?utf-8?B?Q3RDdlo1K2ZYeE9BTUVYRmt1ODZHRzBzUUlzRzliZnJtdkVwTkF4NmxjbTl0?=
 =?utf-8?B?aGpiM204YkZXK3ZmMTBvZDY2dDZQZEhHSTFaQ2kzSFR1b0d6ZlorTzNadkFK?=
 =?utf-8?B?QXpSVE12WmhsLzU1RTNYd0lNS2NZa3ExaG9UdGcrR3ZmRDhGT0MycmIycHcx?=
 =?utf-8?B?OWdkdTVqU0pheU5zZGlvcC9ObVpKUjFoM1lJaUJzYjRNYk5DbVFiUU53cm1h?=
 =?utf-8?B?Y3ZGM1VDTFVCYVJIUXYzZmkrcmpRdTBaV0dHejFGS1p1M0dEUGpWTE05U0ds?=
 =?utf-8?B?U0U4VHpFS2paSXZtWVNZc0FCa1dkbVRGb0lRNHZTTmc1aUQ5ek14ZEcrcXc4?=
 =?utf-8?B?QnVBN2Foa1QrS2dPdVFtamhxQXQ5N2RPQzJWNWtoNFg5ZUZUeEJhV3BkYysv?=
 =?utf-8?B?RGlmTkFqOHZpZzNaQ0lsQjhBbUFycytsMkVobmo2cFphdGtSNm9SM3V6WFNt?=
 =?utf-8?B?SEYyT1huRy9idG5aQTNWMUNEUTM4Q3ZXTXIvWG51VlIxQmQ2RUNGeHNJdEJE?=
 =?utf-8?B?S01qamdsSllva3lWQU5zd0dvd3JObWI3ekVSU09jRDlWU0hEbVhYc3VKMS84?=
 =?utf-8?B?ZjlEMFd4Mk9lb2ZKWlhENU9zUkFsN2VtSDc4cGViaEx2UzFVdlIvbk9sQjM2?=
 =?utf-8?B?WmYyTU5DQzFPL2hqQTRNVit1S0RsOFkyLzFzL2xEVlBlYzdwckxEcU5rS3Ir?=
 =?utf-8?B?ZE1PYTRac014QXJ6YVkvWWd0dHMzYUxSZEk2WFpueVhkOHNTNXZjZGZVUmFY?=
 =?utf-8?B?QVdtdXU4dStLVTZtUERKOTNtN0hTaXNURXlyWWhXaWcxQ0FaNlBKcG4rSit2?=
 =?utf-8?B?TndYUmhtbjcyQ0t5aUwzU2ovTE1VV0lzZmVWRTlwQ0IwM0lsVjdYeEpSTjYx?=
 =?utf-8?B?Y29kQUF3TjhtS2ZoR2M0dGdRUVJJS0hLZmtYTk9XaGFGNUlUZktTbUxTUVZD?=
 =?utf-8?B?Q214T1FWZmJYUWQvZTZOT05xTWx6aDE3OWlUVy94dERobnlyTS8weGE0UmUr?=
 =?utf-8?B?ZVh6bHNvd2p1VlVNZ2ZVVkErZXhwd29VaEdaM3dKcjYwWnJhaXF6ZVVscC91?=
 =?utf-8?B?TTh5TnMxd2U5MmxsS0UzUTcwVGY3eEtnMGN1Y2FKME9KQVJNWGhrNFlBQlVk?=
 =?utf-8?B?S25uY0RjaHpyUTNRK0VDdXNjanhiQW5sL2xuSTk3YUNyYnQ4NG9tRms5N0JI?=
 =?utf-8?B?Q2wxNW1aSEh3ZU5JbklsK2tnZnlNeXJ4R1lySkJ2TEliOXZ5WVhtSk8ydDlJ?=
 =?utf-8?B?WWhkZDRzckRBbW1VSkt1ODFqckpMOHpZSEEyNnFMaTJBQ1YwVWV2bU9ENnNM?=
 =?utf-8?B?d2FhWTdqTC9mT0JOa3J3L3hiRFpVMS9QNGRxellGNG1LZ0MyM3FTNDQzZEcy?=
 =?utf-8?B?enprTm92WWt0c2IvRSthWkEvekRwak13NTJVME9lWTV6WTBkY0lwT2NwK1NU?=
 =?utf-8?B?LzhVQ0tnamM5VFRCbGVnZlo2ajdXSnU1eEJoaHFOd2FFUlF0dmdPZ3lzdGxa?=
 =?utf-8?B?Y2hHY1VYK2JiM01hWk10SHhCdksxTks5dVppSlE4di90VGFpaEpsenJpZGhE?=
 =?utf-8?B?dGUxb2s3NXNkZmtVZ2FGVzJ6aXU1NDdPRytLY29XaldDcS9vczZsUmhGdFhJ?=
 =?utf-8?B?bHhkdXNLTVQxOVZSWTBwSTNPQTJjb2p6enJTb0RCdEYxZ29yYnB3Q0F2RDJs?=
 =?utf-8?B?MnZHeVFhdFRtbzl4eXFnSGpNM3VmSDB1UnpiTnlPaVR3QkU4V3dqbmZ5TjJp?=
 =?utf-8?B?RngyWVdzRkgyRGo1dFlXU1l5cnB4cUVkNE9YczhMY2xwUUVsZVRrZERvSFlI?=
 =?utf-8?B?LzU5dUpUSjdnWlI5Y3huMnd5MHR1Y3hLR3pUUWRYaVZaQlFLdldCSldFMUhh?=
 =?utf-8?B?Qk83ci9ra3llQTBzV093QUVNdU1lQ09CM2ZVT2JTS3ZWRDFlSWNaRXBYL2R1?=
 =?utf-8?Q?DcglIj?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024)(35042699022)(14060799003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 14:08:05.8509
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 962d7486-b956-43b4-9cb0-08dda2a80fcb
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509FB.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6398


On 03/06/25 7:27 pm, Zi Yan wrote:
> On 3 Jun 2025, at 8:59, Dev Jain wrote:
>
>> On 03/06/25 5:47 pm, Zi Yan wrote:
>>> On 3 Jun 2025, at 3:58, David Hildenbrand wrote:
>>>
>>>> On 03.06.25 07:23, Dev Jain wrote:
>>>>> On 02/06/25 8:33 pm, Zi Yan wrote:
>>>>>> On 29 May 2025, at 23:44, Dev Jain wrote:
>>>>>>
>>>>>>> On 30/05/25 4:17 am, Zi Yan wrote:
>>>>>>>> On 28 May 2025, at 23:17, Dev Jain wrote:
>>>>>>>>
>>>>>>>>> On 28/05/25 10:42 pm, Zi Yan wrote:
>>>>>>>>>> On 28 May 2025, at 7:31, Dev Jain wrote:
>>>>>>>>>>
>>>>>>>>>>> Suppose xas is pointing somewhere near the end of the multi-entry batch.
>>>>>>>>>>> Then it may happen that the computed slot already falls beyond the batch,
>>>>>>>>>>> thus breaking the loop due to !xa_is_sibling(), and computing the wrong
>>>>>>>>>>> order. Thus ensure that the caller is aware of this by triggering a BUG
>>>>>>>>>>> when the entry is a sibling entry.
>>>>>>>>>> Is it possible to add a test case in lib/test_xarray.c for this?
>>>>>>>>>> You can compile the tests with “make -C tools/testing/radix-tree”
>>>>>>>>>> and run “./tools/testing/radix-tree/xarray”.
>>>>>>>>> Sorry forgot to Cc you.
>>>>>>>>> I can surely do that later, but does this patch look fine?
>>>>>>>> I am not sure the exact situation you are describing, so I asked you
>>>>>>>> to write a test case to demonstrate the issue. :)
>>>>>>> Suppose we have a shift-6 node having an order-9 entry => 8 - 1 = 7 siblings,
>>>>>>> so assume the slots are at offset 0 till 7 in this node. If xas->xa_offset is 6,
>>>>>>> then the code will compute order as 1 + xas->xa_node->shift = 7. So I mean to
>>>>>>> say that the order computation must start from the beginning of the multi-slot
>>>>>>> entries, that is, the non-sibling entry.
>>>>>> Got it. Thanks for the explanation. It will be great to add this explanation
>>>>>> to the commit log.
>>>>>>
>>>>>> I also notice that in the comment of xas_get_order() it says
>>>>>> “Called after xas_load()” and xas_load() returns NULL or an internal
>>>>>> entry for a sibling. So caller is responsible to make sure xas is not pointing
>>>>>> to a sibling entry. It is good to have a check here.
>>>>>>
>>>>>> In terms of the patch, we are moving away from BUG()/BUG_ON(), so I wonder
>>>>>> if there is a less disruptive way of handling this. Something like return
>>>>>> -EINVAL instead with modified function comments and adding a comment
>>>>>> at the return -EIVAL saying something like caller needs to pass
>>>>>> a non-sibling entry.
>>>>> What's the reason for moving away from BUG_ON()?
>>>> BUG_ON is in general a bad thing. See Documentation/process/coding-style.rst and the history on the related changes for details.
>>>>
>>>> Here, it is less critical than it looks.
>>>>
>>>> XA_NODE_BUG_ON is only active with XA_DEBUG.
>>>>
>>>> And XA_DEBUG is only defined in
>>>>
>>>> tools/testing/shared/xarray-shared.h:#define XA_DEBUG
>>>>
>>>> So IIUC, it's only active in selftests, and completely inactive in any kernel builds.
>>> Oh, I missed that. But that also means this patch becomes a nop in kernel
>> Yes, but given other places are there with XA_NODE_BUG_ON(), I believe
>> this patch has some value :)
> Sure. Can you please also add something like below to the function comment?
> “The xas cannot be a sibling entry, otherwise the result will be wrong”
> It saves other’s time to infer it from the added XA_NODE_BUG_ON().

Sure.

>
> Thanks.
>
> Best Regards,
> Yan, Zi

