Return-Path: <linux-fsdevel+bounces-54382-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14464AFF07A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 20:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04EF83B4984
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 18:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5587235050;
	Wed,  9 Jul 2025 18:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HC244+Rm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833356BFCE
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Jul 2025 18:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752084479; cv=fail; b=qQ+usA/o6ZvwAprmFbGLiQp0bT8PtA2tDFsqjAwqn6HKrrd+ngrnCXZLaDCUub5utci6XpJK6iHbwaZGtvq/mSDpB8ISC3QQUsScl7zUhxuXI2ALh6Ku/3tgFxAmk/ExToOntn+FsB30EwdxHjcDlPJET1JpPrcHsVFV2Pdk6mA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752084479; c=relaxed/simple;
	bh=m+HP3RKrEYDz9ZUbxuL56y+pz18wibWTx5FX3gEQoKs=;
	h=From:To:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=qejyS7sJd9+C08XFvzFCinF/gzvE0UMlE27SqRLS54gTJOC6YWfsicNj7HuB9lHpkNyXJ2dIl9iT9m4O0M8zy9McklP75Rpl34vGoTo9d+ZvRkar7FycuRdyfkB8oZmcmZ3tAT96Tq35esbOd2z1N/0One4j6xou2rJg0c0TOzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HC244+Rm; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 569Gr4ud010225;
	Wed, 9 Jul 2025 18:07:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=m+HP3RKrEYDz9ZUbxuL56y+pz18wibWTx5FX3gEQoKs=; b=HC244+Rm
	mdcY7U79DDETeXZ5wrhLsNzI+WZouW5UieHET+C6GJ0ltj3/vZDQ0bD2409R/exO
	eZ5V4L32ZrS/UL+LnTPCeki4aaefswxmT1m/c9Uu6Tw+wS2482NrBCvqjV1xk2uB
	Qz3AjceabIWUUX8iqaKL6flucGfd75/haJ3hMbc4fCKWOOsZ3BN9SWvE/IRrrp7O
	w5cfjLTIaPYJQBLSW3e5czfCeG8JFE2vcYtkzQ1iOOsBWhJNwew29QMpROXDJr4p
	1g8nVXhoaPEH8m2eO6s9iaxQOvhHsoSZIVCJX8ASl+qUOcyva5qckjUluf4dEjaG
	AgfWJeZnC/hnMg==
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47svb20dcc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Jul 2025 18:07:52 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JMjikfI53Kat3pLh2qaaUTZybQr8NhhqBcwj7Uk4dCykBRmwJnqF4P3i5KhUVnj7Oe9Vs43CB7CWIcAzlXtjJzk9UACR4kolhg4e4yWD58XPgzcWvmaJ2erpI+EsaUDk8mqhCuEimZ9kl1vPPVaLgJrL9slKf9PIY3C4gikG+JXP4xGFl671OYiuqEtPn3Q1nZM772zq6ypCZbc3DS3fNuORdMWgzdBTXME+MEkKBNXkbjpuVUyzADGoHn+sllKt+lH2G1rUVxI/L9thJBJqtjl9O3eLElnfAyVAUjpZqOUrIbbV0ukq71oOzNSPiAWTDPdQGnT/W/heYzAAqUY+bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m+HP3RKrEYDz9ZUbxuL56y+pz18wibWTx5FX3gEQoKs=;
 b=ORFAqIuvK6++bbNHQjRP68QkYjFda0Lbkcxn32hUz9r70qi/FeEszz2ouPh0gH+jbRgeVLVViKRqOOz3emVf/bd/LVaSbn/rKSsXl3HXPPvvnAQNcsuK+KV78Z2dVwLAp1AGjHgTUt9M8gwENyei45bQcgNgUkFZoXh8FjCyr23ing9zWNlQlS07t7Hig7+EW39xRXrf8I67umGzUvaX6Vd+OLeIPYWODLd0Rm6T7ho7REpK3wD3Ode9OiYU+S/G7vAYq4tRkrGBHu12tE3/J8/s0YU5lfW+4YBk61Y2vTu4R4+vrcCPGbFgqWA8AjeiCfnJcNiwI1SwAz2B5MscOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by IA1PR15MB6056.namprd15.prod.outlook.com (2603:10b6:208:44a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Wed, 9 Jul
 2025 18:07:50 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%7]) with mapi id 15.20.8880.026; Wed, 9 Jul 2025
 18:07:50 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "Johannes.Thumshirn@wdc.com" <Johannes.Thumshirn@wdc.com>,
        "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "frank.li@vivo.com" <frank.li@vivo.com>
Thread-Topic: [EXTERNAL] Re: [PATCH] hfs/hfsplus: rework debug output
 subsystem
Thread-Index: AQHb8ERqutV+FY/7eEOaZFpfR1Ybm7QpaAuAgACwKgA=
Date: Wed, 9 Jul 2025 18:07:50 +0000
Message-ID: <861a1e6ac11dc7e73aa45030f7d13e597fe8ef2e.camel@ibm.com>
References: <20250708201017.47898-1-slava@dubeyko.com>
	 <e80488fd-0b9e-419a-aa63-3887125b7f36@wdc.com>
In-Reply-To: <e80488fd-0b9e-419a-aa63-3887125b7f36@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|IA1PR15MB6056:EE_
x-ms-office365-filtering-correlation-id: 3d6f6dc8-b65a-421c-d455-08ddbf13849a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?YjlFaUZaWmlIbEVIZURsTGtQbDBZQ282RUphb1JvNjgrNkNEcXZ3bytaa0ph?=
 =?utf-8?B?VnlUckQ5amxWL21vNU9oQW1QMUUvK3VMR3k1c2V6dUZnTk5zekdUdTd2SUgw?=
 =?utf-8?B?MEJFQWdVZ05QZG5OVHl2ZmhwcjBIWFovalNTOGxsVWdyeDcrZkJMWEYrcDZm?=
 =?utf-8?B?VjVTVi9teHd0QWFJeUlDNm8xeWxlWEFoMGJRVFE3cHA1Z0hHT0EwUUxGbXpy?=
 =?utf-8?B?d3FJelI1N3JkOGVnbUpWOGQyOUpUaHZheEE1RVRpemNzQ1dVdWdoQXZqcEVU?=
 =?utf-8?B?U0hlOFdjZDJTZ2I3NXYzYWc4clpyemR2bVNEN0FNdlVnbjZ2YVEzblU0WU85?=
 =?utf-8?B?RWlJeWtqWWpacmlpdk5JcDlUQUVPL3ZjV2kwYzRZTVMyM0RoeTBnTXVQVHZu?=
 =?utf-8?B?NjRLSnIrUEdRdXhkWVNRaHdkZlZYTG1BZEFsT2laaXJXU3JYdzZjdi92aTFQ?=
 =?utf-8?B?Q252TkNTRXgxeGtPZXhsRVJrcEFIRFY0Ym5oMW5qVmhxcGtuZU5HTGM0WU1o?=
 =?utf-8?B?UTcwTE45MEl5WE1Dam0rZkFqNW5NWWRMUmh6OWc1SzdDOG11eEFNaTAxQ1pN?=
 =?utf-8?B?OHNKUEh0TGhTUXc3dzRqdmE3eDdCK3h5OXpHbE55Y1VEMlV5a1ZpUkhYcjZp?=
 =?utf-8?B?U3pkOHhVa1pZSVUxWi9BUTN6d2o0NXAydU8zUmdMZ3dJRHIxbUVMZ3pJd3lS?=
 =?utf-8?B?K29kTjc4OTltcXRia3VtN1IraUpTc3FUcnJGYlNGTEdGcDNTRHZDVUhwM0FR?=
 =?utf-8?B?TTh5TE9nVmk5SXphSWwranE1VTF4TmUzTDh6WFd3MWk2OFE1bGFHT1FLZ3dH?=
 =?utf-8?B?bXN4NVhMTlB4ODRFaU1QQWhEaGJVQURacVVlalpMaXgwcmpsRExvbjVIQzgx?=
 =?utf-8?B?dnRIaVRtQlVSU255L2dLcG5HQ2xTRi8zNXVoWGR2UHlGVkFsTkpvdEQ5WHBq?=
 =?utf-8?B?YnlhbnJ6ZWF3ellvTlJaSC9XTWdhb1VraXRIQ0NkRCtoZktrN2Q1OGZJellx?=
 =?utf-8?B?REdrTE4zTTB0QnMxODJOUDlDSWYvMHFHSGwzL3g0U0hHRnpwVmxqdEhGL1hK?=
 =?utf-8?B?OHNVT01aS0x3R3JtZHF1eUwxNjdiMWtoT3VHUERrUUx3N09uUGNVV1cvZzZy?=
 =?utf-8?B?Y2hwcGpSSi9OWTlMR3pXU3AwN2pkb0ovNFNhYmRveEY5d2p5MHFqZk9yd3Nn?=
 =?utf-8?B?R0lNWGovejl4RUQzRzBrWmVvby9Ta0NmaXZhSlZMSGpOaWc1ckFTZ0xCYStX?=
 =?utf-8?B?NHhMUmR6TXN1dkMvYm5jQkpBdDJBa0w1YmVBMmlXV1lxNm5yVzZvVW8yY1Bn?=
 =?utf-8?B?VE5kaXUxSGtKc0g1RTFCclh1aEIwaTFjNG84THBzalpTM3BqMW9kbFRwbEx2?=
 =?utf-8?B?UGcwUVlqeWhNNXNQc0dYRVNYSGxxTUZURmRQMVcwK3RoUnQ3ZXl3Y1RzY1U1?=
 =?utf-8?B?aWRQcnBKS2JCT1hQNDlzVThQK0dxWGE4Z0pBWmgzSWQyQnlEdFdLTC9mQUto?=
 =?utf-8?B?SXdmaUh3aUpoUjJEMEJxZnpoYXhwRjZNQXNmYndzY2lSbG1CZDlYS0pUK3RH?=
 =?utf-8?B?L1o2bWtzbGtGVTJjdXRGbXFOVHRjcSt3UVJPQnpXUnVaWVFqak80WHdQWXpQ?=
 =?utf-8?B?bTBqNElYSllNUEVROWFwUXNWYTJYc09tL1NkVTQ2Vmk0SVRhTGFnM1hXbWt5?=
 =?utf-8?B?dXY2YlAxZjI2QWlWOVBFN3NzRytzVElPNE5kUDlJUk5NNFdOU01RaCtkK1Ro?=
 =?utf-8?B?VFEvdmRqOVJLTE5tbnVhTkM0ejQ4VXhUbkl0M3IxWmdQM3hGME1NWEFvUjA2?=
 =?utf-8?B?bXNheG9UbzJKU1ZVMXZ6aS83aG1pTHQwYTlDakh3SVlhNjJzbXZaZm1kVU96?=
 =?utf-8?B?RWgrQlpPblR6dDMzQXRIZmdwZXpnaC9nOU5UekJMNEJKa2hOMno0NTByUHU5?=
 =?utf-8?B?UlFhclFjWkh1RWJFeWpWaSthS3RVMml1NXJteGdRRyt3N1JIdzljSU9EUTlz?=
 =?utf-8?B?YWd3ck1GSGdBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dTQ5TG5YejFWZ2FucWJVOTVVeDlCZVB4cnRhbDFmZjBOL0dIUWxWZjZId0pJ?=
 =?utf-8?B?aVc5MzVOSjluYXREeTV5TlVWeU1uT2FnbEFJVk9vMmM0WGlzcXNXeU9wSDQ3?=
 =?utf-8?B?NWxWY2FnVGZ0YmJWR2lTbDVYQzhXVW44Zkk1N01CempRdWpHOUYzbVZGOFBq?=
 =?utf-8?B?dmxaeDVMOTJ5YzJxWW5DdkkxbVhuNEE5eldaREhUSUh4dnUxQmJJNHJVZ3VK?=
 =?utf-8?B?L2ZqWCtVZDdBa0xaUFpsRjhnUGJ1TWQvN3VydFgwd2VpYmlsMU9McldGK0tP?=
 =?utf-8?B?MUdTV3NGSjNOeUdieG5kYmY4QVJHQkkyR2k3cFFoTkxKeU13Q29IRFJyY3Ba?=
 =?utf-8?B?aEMrWjNOTXpLUnJmdWs5RlluTE1yUStpOVc5bG1sVWgvbExIZXZQRnhnaUk5?=
 =?utf-8?B?RVVYVjhRQTlZaVRlZXh6d3k5aktFMVpCRDhJWnQzM0xRK3c2ZEFxUFdVbEI5?=
 =?utf-8?B?SEMya1l4MXdib1hMb0xlaTk3Q0U5OElYVDIrU1pZRE1FWEZsYlM5ZnBkKy8x?=
 =?utf-8?B?K1ZkSFU0TkdsNDZMRlp6Mi9mSEhMdDVuWFNXZ01kNmhJdEVoT05OK0JWZ3dU?=
 =?utf-8?B?WmhnMTdVRXpHd1Rkbmc2ZDZicVVqazBuSXV1RjJ2cXZEY3V2anNlbjlMU24x?=
 =?utf-8?B?VytMcUlMc1FvOUhyUWJpUjBvOXM2NGg1clNKYWpOOE1qT0MrZ3pSeUVuWk9R?=
 =?utf-8?B?aHRpVTVNUytDWG5VaWFCN1QyY2g3dFppYUJpQ3piR1ovYVM1TXllRmpQZ0l6?=
 =?utf-8?B?Uyt5dnZJVS8yM2l3eTd3M1B6ZVlUb0hidzArbjhCSWl1cklMdW9CNGxLMUM2?=
 =?utf-8?B?VEN4WGVIQ2FpWWxFbm5kNVJZeklnQkI3RkI5cFc4NGRTNTVWdkJvNWJMaGdR?=
 =?utf-8?B?NEhnYStPZnBraW1Lb2orc2w1OFR5Q09qWm8wQnk2U0JaNUtuckdkeitNWnNT?=
 =?utf-8?B?UGxQemxleVg0Ym44dFVuMVV4ZTVVSDR5R0ErNWVsNW0xWkRzZ0xqYXFWZkFJ?=
 =?utf-8?B?MS9vU1VrWjVJVVVLdzl6V2tJOUNQQ0lUaXU1djBzYW9rcWp2TEd4UzRuRDRE?=
 =?utf-8?B?WW1JTlkrdGdNemVBUDE3RnhNcG56QWhSYklzR3VSbFVXK2tORTAyU3RvcDNt?=
 =?utf-8?B?UzlPamtHalhsZ2NXcmJKYXZTLzNSU3dVRkQ3K2Y1OG9ic2MrS0FJeU5pY2Vk?=
 =?utf-8?B?RC9sT3dnN3BTZHk1amlWdHRON3NQMzFybFpIMi85eldKaWxGUWlCbGlTTnZ4?=
 =?utf-8?B?amFjaTZtL2ZYcnV6YmRoQWFxT2JPZkpYbmRFa0FkSGRVb3FnalVEc0Y2dlI0?=
 =?utf-8?B?WFMxRWFLWGlaNk5zb2h5dVQwWEdPR3psQ0dFM3crcEEza3hadkVROHVBeXIz?=
 =?utf-8?B?a1lEblg2UU93UFRHcWJkclZJczZTOStZZ2JYTEJlbC9jWmdrMGh3ajVTMVJV?=
 =?utf-8?B?Z2dMZlhYRWtWUW9weGE4aGFQZXEyME9RalQ5K3BIMHZMWVdQOHd1OGZ2Q1ZZ?=
 =?utf-8?B?MGM0MDh1cGtpUHBKVTczVEtQbUt3OWR5dlBiSzhDbS9KZEJTTmsvUmNnaWk2?=
 =?utf-8?B?WmhmRXlSWktWdVk5SzJVQjZXUWx4TlJoaTFOYS9wK08vTzlHMTVCeEw0c3Bh?=
 =?utf-8?B?ZXpDaG1TOWd2SXovdDkvZ1BUQU9CeFRuK2ZyYXBUT0swaUZlMG91eHJkTzJM?=
 =?utf-8?B?aUtOVDJMd1dmVytmUGk1UWZmVUFncWd5SDNJNk5uQTZIZkF1ZTRhU05qM0JM?=
 =?utf-8?B?bDdiNTFYN0t3THZUMmtGSGNJQzd4M1AzL3RkYTFPcGdmRGZHN00rQVRUTTJx?=
 =?utf-8?B?Ulc5RHRtOVg1NlpMTmVsMmpsVVJ0S1l1VVQ3aUZxT3BsK2VONGdFcTNRMk1B?=
 =?utf-8?B?YUNVcGFCVnlDRm94eWw2LzI5dUlPMFJ6bGNCb3l5ekV5TSsyekZMcXlpWlcy?=
 =?utf-8?B?UnMxanFwWmdMdTQzUm02VDN2NmNyNDdKcGVkY3QzcEFvcWVGY3l0ZTNFbWhT?=
 =?utf-8?B?NjQxaTl1RXNZL0x3aEp6NWlJVkJJM2tsZlFReWJ6aWh6V2FUZzkvM3g0aWRW?=
 =?utf-8?B?bmJ6dnVXdSs0SWxzMFdObGR0N2pkY3RXdGM5SExhU0JmVzdBcFQxMDA1ekZT?=
 =?utf-8?B?Smk3YVNrbGJqbGFvcU5uck1JS0FmVnNtaTJtTlE5TnlIRDM3OTI2alRpMnlT?=
 =?utf-8?Q?ht+Bev9b3RRWEHpDjM+4QJk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CBCF841101A9E249BC242D8E7B3E6EAB@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d6f6dc8-b65a-421c-d455-08ddbf13849a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2025 18:07:50.5970
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 32QSVTZU/oeRB8pGqEUB0NJUXZu0PthgS7JZ5/i2dy2yGZM4Jjw/7LSPQx2OxeS+kNg25petuYMBUgJkFoUFAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR15MB6056
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDE2MSBTYWx0ZWRfXwDPYBH3xj00B HzH2KvIZE+ZKWkmu1msC9y9BXwtJ33noiRx4TZTIlg7BL/5TuEE7gTEAApg7ME0OEPJkfYjetde xJeWyfrW/1u97di4J4pyjGFEB49x+U/N3M5ftb448K+RiMI9v8atB5dR3HhxZEV1PTIdoD1u5e9
 dk+V+NPc6NYbBCezxE2bNGNXlz3rpD5Nj1UNgCb5XHTPgS8qvq5M5WB+q6QT8oJLUN+fsYNnv0A FSm97aDh7KY78K0UCOiGY/UvM9ULJ5Y6bnm6UnJa11tld8hhl2r1wDqBY2aIHoPYsRz75YlyD4c YN/e/cdst+qNVc3CTxwS8+6beWzNKUP+4++DhjAkerQc38YvCXtDUmfBZglEOFgltgB0KTPQIlp
 stfJ3SHBXMh6vxUYxwNxc2V3w3T40yI9zpiNKPsep5fd1YFtQlA+Ioci+NuVXp5yjUnfJZR3
X-Authority-Analysis: v=2.4 cv=Y774sgeN c=1 sm=1 tr=0 ts=686eaff8 cx=c_pps a=syx2/ttNfA1aKFKOgUl8fw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=sJISyEnL8PtnnzRcQyUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: HZV8A2-RblGlqyEIR7Q1EjBZRSXt-e6I
X-Proofpoint-GUID: HZV8A2-RblGlqyEIR7Q1EjBZRSXt-e6I
Subject: RE: [PATCH] hfs/hfsplus: rework debug output subsystem
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_04,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 mlxlogscore=946 mlxscore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507090161

T24gV2VkLCAyMDI1LTA3LTA5IGF0IDA3OjM3ICswMDAwLCBKb2hhbm5lcyBUaHVtc2hpcm4gd3Jv
dGU6DQo+IE9uIDA4LjA3LjI1IDIyOjEwLCBWaWFjaGVzbGF2IER1YmV5a28gd3JvdGU6DQo+ID4g
ZGlmZiAtLWdpdCBhL2ZzL2hmcy9iZmluZC5jIGIvZnMvaGZzL2JmaW5kLmMNCj4gPiBpbmRleCBl
Zjk0OThhNmU4OGEuLjQ0YThiM2JhNDMwMCAxMDA2NDQNCj4gPiAtLS0gYS9mcy9oZnMvYmZpbmQu
Yw0KPiA+ICsrKyBiL2ZzL2hmcy9iZmluZC5jDQo+ID4gQEAgLTIzLDcgKzIzLDcgQEAgaW50IGhm
c19maW5kX2luaXQoc3RydWN0IGhmc19idHJlZSAqdHJlZSwgc3RydWN0IGhmc19maW5kX2RhdGEg
KmZkKQ0KPiA+ICAgCQlyZXR1cm4gLUVOT01FTTsNCj4gPiAgIAlmZC0+c2VhcmNoX2tleSA9IHB0
cjsNCj4gPiAgIAlmZC0+a2V5ID0gcHRyICsgdHJlZS0+bWF4X2tleV9sZW4gKyAyOw0KPiA+IC0J
aGZzX2RiZyhCTk9ERV9SRUZTLCAiZmluZF9pbml0OiAlZCAoJXApXG4iLA0KPiA+ICsJaGZzX2Ri
ZygiZmluZF9pbml0OiAlZCAoJXApXG4iLA0KPiA+ICAgCQl0cmVlLT5jbmlkLCBfX2J1aWx0aW5f
cmV0dXJuX2FkZHJlc3MoMCkpOw0KPiA+ICAgCXN3aXRjaCAodHJlZS0+Y25pZCkgew0KPiA+ICAg
CWNhc2UgSEZTX0NBVF9DTklEOg0KPiA+IEBAIC00NSw3ICs0NSw3IEBAIHZvaWQgaGZzX2ZpbmRf
ZXhpdChzdHJ1Y3QgaGZzX2ZpbmRfZGF0YSAqZmQpDQo+ID4gICB7DQo+ID4gICAJaGZzX2Jub2Rl
X3B1dChmZC0+Ym5vZGUpOw0KPiA+ICAgCWtmcmVlKGZkLT5zZWFyY2hfa2V5KTsNCj4gPiAtCWhm
c19kYmcoQk5PREVfUkVGUywgImZpbmRfZXhpdDogJWQgKCVwKVxuIiwNCj4gPiArCWhmc19kYmco
ImZpbmRfZXhpdDogJWQgKCVwKVxuIiwNCj4gPiAgIAkJZmQtPnRyZWUtPmNuaWQsIF9fYnVpbHRp
bl9yZXR1cm5fYWRkcmVzcygwKSk7DQo+ID4gICAJbXV0ZXhfdW5sb2NrKCZmZC0+dHJlZS0+dHJl
ZV9sb2NrKTsNCj4gPiAgIAlmZC0+dHJlZSA9IE5VTEw7DQo+IA0KPiBUaGUgZnVuY3Rpb24gbmFt
ZSBwcmVmaXggaXNuJ3QgbmVlZGVkIGVpdGhlciB3aXRoIGR5bmFtaWMgZGVidWcuDQo+IA0KPiBl
Y2hvICdmdW5jIGhmc19maW5kX2V4aXQgK3BmJyA+IC9wcm9jL2R5bmFtaWNfZGVidWcvY29udHJv
bA0KPiANCj4gd2lsbCBhZGQgaXQNCg0KWWVhaCwgaXQncyB0cnVlLiBUaGVyZSBhcmUgc2V2ZXJh
bCBvdGhlciBzaW1pbGFyIHBsYWNlcy4NCkkgZGlkIHNtYWxsIGNvcnJlY3Rpb25zIHRoZXJlLiBC
dXQgSSBhZ3JlZSB0aGF0IGl0IG1ha2VzIHNlbnNlIHRvIHJld29yayBpdC4NCg0KVGhhbmtzLA0K
U2xhdmEuDQo=

