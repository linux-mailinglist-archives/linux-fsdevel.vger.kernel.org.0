Return-Path: <linux-fsdevel+bounces-73508-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 33576D1B0C4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 20:29:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9ABB6301330E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 19:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF13F36E468;
	Tue, 13 Jan 2026 19:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ahrIcOai"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A85D30E82B;
	Tue, 13 Jan 2026 19:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768332550; cv=fail; b=rVUfCvt4uyNp3CEeX7AbgSNC6wtXAEI6Ib7nJzxj8/hW6NY01xpX+Q4rEtjcJ334vj7JAe22rmcX5+IUJ3jtcGJrLmsE+axs/qNOes4jVl5/Xi/0eQobL8MiuHoHLn9gWNBtK9oITLrmJ0zxs8fsUaEMuY1u6yrcoqUdWx/tEbk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768332550; c=relaxed/simple;
	bh=kNKMkpG55fYhyaISAAk2kJDmJgKsWEKfoQ53Bpl9/3g=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=qsHanQTzgMchuXCsDOzPQSSO45lLevTI2CEr4ySyknrF8V5MDaWrLJ7g6+sRGTzrdp5WIdA32UlaCUIQ+nV2r17uAiUsS4mWP0azC96tPy2z6vHJ2hPLvIJkMG7bWDQQDqxwkNWciSnVgdTaDyPNmIWjkTLFxxhiwIAze4NT0L0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ahrIcOai; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60DGS9AN014465;
	Tue, 13 Jan 2026 19:29:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=kNKMkpG55fYhyaISAAk2kJDmJgKsWEKfoQ53Bpl9/3g=; b=ahrIcOai
	oux9ira9By8rNby7BequNQyQULBBh6jk9FxIUy9kE4xESicH8YWcuZ/FqxhSaPg8
	X6Pq9D17bw05S9LAznqOmgxR762HzL3SI+iuFRt8A9iGY/HdJGDI4hPEDCpNozVy
	nfEJZdHcExHUq2b2oX/QrgHjnUGfgtUcYmsB3H0B1uiNbzHzRPtKfMc8zlCFO+GP
	H/v/Ru5SSnY4h0lnbKhZp2qX1z2AzWk3/vkGKqydGX5VX0bFh9CsgBmxRKWbKhAb
	ykk4RS0Z7MNP5iPmA7uqcNxLsS/5HcnRPVVq3N37oDecsD1Lc4neagFY4OTJ+9ZR
	IwFH7kNkddYzLg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkeepx5uy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Jan 2026 19:29:05 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60DJQ0D5007104;
	Tue, 13 Jan 2026 19:29:05 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010059.outbound.protection.outlook.com [52.101.193.59])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkeepx5uv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Jan 2026 19:29:05 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nlBpbZHdgRaimfkvTwrvbKc64pTvThm5rGuaGEr6cfSYE28Ri9Sr5MmUTPn4u55rgvEMbTy24fd3Z7IJEdmhVHPRWC/95Et3vkzSXpq6xggMAuBTNNNxFV1eJ8pLNKbb0K0x0Pm/cbWs9Mlw1PXmm6fJ1ogsJx/RD99kGLTa9qrGxwIhTlfgKjnjKy81294IfHSyA670aTUpnoDWE9fZs0u5uMGN5G/OK36txA+IUyu146Pgpp+BV0aBXRo3p9TF5SVDaWdpkEzGDX/hEQKV/ct0qwcCUI4zR+d4ICQWlKx7iXLReZ9K3ub+5Rx2+QCVnjTIWxU2DKVkveRABKTtig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kNKMkpG55fYhyaISAAk2kJDmJgKsWEKfoQ53Bpl9/3g=;
 b=TVmDRujw30DAoNPV1ZGGrI9YHOS2QEUBzO2QeO9LyGaHW3GUrgbs2W4rZBH8fwqfaKcoKQynRhSW1DxPPH4Hyz64lGvfZmsPdBy+Sg+40reg8icpvTiatJfz8BwtgKj2LR8MZv4/3NkQDbC3EDIOz6zms/TApb+29Q9n0KCzHSjkRbigTxPBXlWMptfhf94bHdi+zedF2S9qGfP0o7lihzwFsVA+pxyLW7OUUOvKHcViuC9g3zXqbF/ObxmVl3hV7cnbfWnX9za/bqKxWTmABWuXvB1Xlr2PCT+9M13v5Ix+lYkBDgYFI8DwsZEhpiEXIklDwNajf8yu4wSxrTaqeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by SA1PR15MB4449.namprd15.prod.outlook.com (2603:10b6:806:194::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 19:29:00 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%4]) with mapi id 15.20.9520.003; Tue, 13 Jan 2026
 19:29:00 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: Karel Zak <kzak@redhat.com>, "slava@dubeyko.com" <slava@dubeyko.com>
CC: Alex Markuze <amarkuze@redhat.com>,
        "util-linux@vger.kernel.org"
	<util-linux@vger.kernel.org>,
        "ceph-devel@vger.kernel.org"
	<ceph-devel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        Pavan Rallabhandi <Pavan.Rallabhandi@ibm.com>,
        Patrick Donnelly
	<pdonnell@redhat.com>
Thread-Topic: [EXTERNAL] Re: [PATCH] mount: (manpage) add CephFS kernel client
 mount options
Thread-Index: AQHchMDShsMo8mB/5kKaIAF9llyuV7VQfDmA
Date: Tue, 13 Jan 2026 19:29:00 +0000
Message-ID: <c15ce83bf9ee6c5c37db193c33a77b52f0594564.camel@ibm.com>
References: <20260112205837.975869-2-slava@dubeyko.com>
	 <binwryzqlbprj2t3ybxb5kychdeenhtmadbe23hov44urszvn5@kpbbv3qks47c>
In-Reply-To: <binwryzqlbprj2t3ybxb5kychdeenhtmadbe23hov44urszvn5@kpbbv3qks47c>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|SA1PR15MB4449:EE_
x-ms-office365-filtering-correlation-id: 5ea9c7e5-8585-4300-9959-08de52da00bd
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|10070799003|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?VUt5U1RPNEUzWFRtZmh4UHd1VWwyVjlJMVp4cWpQVXRMbEJad2taWkFKNUxs?=
 =?utf-8?B?eHA1OUVPa3pXZW84Y1NKdjVQOXBaYWVQYndOa1dwSm5rU0d1QTV4TFFIeFk0?=
 =?utf-8?B?bm5YM1FiaXAycGtubU9yTjhKSlRrUmdJNmlvdGxIblYxMWdEbXcvejhRUkhx?=
 =?utf-8?B?U1gyWDBlSXpqOWx2dGY0OS9rQ1Y4Wk1UV2JwTFdhWHU2SFBxTEZ0MGpJUytE?=
 =?utf-8?B?R2R3ZkFtT3dhbVIreWpwY1hIQXZtYzBBRk9Lc3BpSlNQYm5yYjhrK2JkRkpi?=
 =?utf-8?B?MDA2L2VUMTlZdVhjdXNpdW5zdngzbnV2N2pja1hUR2t2WkRhTjRoM1pGVlY2?=
 =?utf-8?B?NENZZGZPa2Z2NHovSDlrUGtCQVFsSnc2T3hiWGpLbzZ6RVZqZUNrbnVnWGVI?=
 =?utf-8?B?a2tydUpsSVd3M043eSt3Znk4RTZaKzRhaXhGbmxUWnNnL1NlOTFCRmpObzJ6?=
 =?utf-8?B?VCtrbjhzUG9IYkE2amFSSUlqMlF2OUs5VHpXRTNPTGJzZDh5WkhIN0Vwelhi?=
 =?utf-8?B?YnlqKzVVNEJLV0NpOVZRUll5TEI4bmRvc25ZM2VrRVFKQk9TNUE4OEpWQ2R0?=
 =?utf-8?B?aE5YR2llcGRPNXJqSXZXWklzSVJ6UWQyb1M1a3lmeU1HdGx5dnBwRTJBekNi?=
 =?utf-8?B?UEdDWnhVeE15MG1zeUpXQTM0dTZRd2kycVJXWnlWVkNFUFRqbkRCT21JQURx?=
 =?utf-8?B?MGZnb21CUTFJT2JEbUtxK0pZeUNlY0JwKzMyNE5VeU1aZnNWeDBTbm80M3BJ?=
 =?utf-8?B?eVROQ0ZUTUVnNmVNZzJPZ3NJQ25WNVJwNnV5dTlnQ2ZsTk13WU05dzVpMHVP?=
 =?utf-8?B?elJ4RlJpSDNmR3JPQlpKYzJmajdTR2tZOHZkSzJFMFNnaU1kbjR4R0hLRWFT?=
 =?utf-8?B?RiswY3Q2bkpuUTZvM0RZRStrdWhhS3BReUtJRzZoeUtPdHVxUmorRXY4M2Fq?=
 =?utf-8?B?N3VRY0lSUmVJUmMzUG9DSVV1bGhxU0dMaldIdmtWRVVEc3lxdGJBTjd5UG1V?=
 =?utf-8?B?eGxFeE9iRElKa2thdXpOeHBJOW5mOUFDN2FCWFA1U2dzcmpwbmxVTVRTblJm?=
 =?utf-8?B?dEYyR1l0a0lGMXVvRVFGbUx1ckxjbHFtRHcvUEo4OXJIZVRxWGVIdEl3Qm91?=
 =?utf-8?B?ZzhUTGJncGw0bFFiYW9sdDdIWHRCZjFCTzV6MXBMUEVLTjNpQXBTL0UrVUt1?=
 =?utf-8?B?ZEdRTDJOUmZQZmlueWx5MlBvQXZsSERpT2VkV0VIUkoza2VwdWFSb0k0UmU5?=
 =?utf-8?B?cDVSKzVqZWJVSU1wdG9YNDl3M09salcwZWd4bWRodUk2SjRNRTBsMnFVVHhl?=
 =?utf-8?B?cUljaDZydDdNdUN4cUVwTUFsbEYrbWVsYTRTcXovazMyVHNoaFVNWTk5RlF2?=
 =?utf-8?B?VHNsVWZneG1ldi9HMzkyYTg0b0R6UmplZWhpazZKWlMzTTZaMTJvQllNZ0ho?=
 =?utf-8?B?bmF1R3lnZnVob3cxUVU2OTM5cU9xdTg2NFY0UkdJQ05DUUtMckNvdk9TMlpz?=
 =?utf-8?B?ZU5LVDlLRXBza2ZZVjdGQWdJUVQwOHhFL3NYeWhzRndNU1ZGamFtbGlHNllB?=
 =?utf-8?B?SjVtVDh6Q2MvQWRPNXlxNDZmZWZMb0NHVWRRclFoQzFpT1pDdGFGS29rRDVW?=
 =?utf-8?B?TVk2QWs1NGdaNnE3enVvK2lHV2xVSmF1djBsNWpFTXdId25XeWh4ODZzaVlK?=
 =?utf-8?B?MWU0Nno4VzltYkEwelhjTVJpRE94Q3M0SUlHL1NGNXRwWHJPSll4eHJjeVQx?=
 =?utf-8?B?NUZJRzhHL0E1K0ljbUZTRWhkSkxtMUoyb1UvaHA3bzdpcjZIdmgrV1hyMW5U?=
 =?utf-8?B?MEpmK2hHakhnRk51TklWRU1OeEN5ZHJsYVdRSzA2emI3eHBhQk1rWkh2clIx?=
 =?utf-8?B?SlpvRmVNUEg4U1JBNWJSeEg3bjlLZXRMckZxVjNqcHpSak9ZQk80dlZKbmpE?=
 =?utf-8?B?bEhvSE5LUUdsTnRmY3dwRmNmYVUxZkR0ajgrTUwwdFpxQ0JxM21EUGdPV2xU?=
 =?utf-8?B?dFQ5ajQ5RHpUMHY4N3hZOUdhenZFWjQ3MDhFank3Z1d4ME1uK1NnbjlQZGtM?=
 =?utf-8?Q?qkj2jc?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dnNLZ21KbGZTeFg5TURhclg1SXIxYURWN0Fqa2VvWFB2cGRhZVR1c1hzL3FE?=
 =?utf-8?B?L1VNcVBMQXVWNTRNV0k3NmNxM0pNT1hDaDhaN0xPYVJDODZQNXBJMG9SZ3Ba?=
 =?utf-8?B?aUsxQjhObXlrbEZTSXdUamx1YUJoV2VkZ3dQUk9OYkZIcnh0TFlGMmw2Wlhp?=
 =?utf-8?B?SVZyVUhhL2ZseG1lOXFtOFJlbUhPRXZTZ3Nra3NtV3hzUFlEVzdPNFZuVFVp?=
 =?utf-8?B?VGxhaEhGSjVTUkNrS0NMVnhJcndpMXNRRFFVeGFjZXlYVmRnQ3hhbmFHdnNC?=
 =?utf-8?B?ZDNqK3ZuWGJYTS85dWFnUHpkSXZwZkxPZVA4bmI2bkFvVmp4UHFPTzBoeVJo?=
 =?utf-8?B?VWlvbmlibEdhM1p6WlRKT21ZNXZFWmZrQlpJQ1JSZ0lMUU9aVGxvWEFFVEZv?=
 =?utf-8?B?L2VzZUpjNVlJa1ZwOGs3R3JZT2dhNy9JOWwxTTFOTldCR0RKQTBlYTQ5QW1V?=
 =?utf-8?B?UU1IVWNFWDZoaVprandiN2l6aVY0MVFobTVBOUlYYm9ZREtxa2o2S3BYb3VV?=
 =?utf-8?B?VnowYkpKNE11anYya2J5d1gzNlpCUU9SS2VZRlFJMzBiVW5rckhGV3dRUWZ4?=
 =?utf-8?B?MS9NejZPNEQ0b0ZEMEtaa0htck5mOXhlc2tXNE1mc3NLU00rMnlVS2xYSXVz?=
 =?utf-8?B?T0xCUFZpSGVWV1BITkJBcW9NVUdaSWRvZnZZc1pxc0d2UTZkbUhwaVhoQTFn?=
 =?utf-8?B?ZGg3V252T3FVeWFHL1M4NFNDODRlZ3ZTSzBTUCtDclcySmhUUURjWXhWc0NG?=
 =?utf-8?B?a0ZHVDlXYWVEbkYzYzVPeDdDMGpxN2xYQUJDSVdvd3BOYXpWK2I5anBPdTZm?=
 =?utf-8?B?THZTTUFDSnc1Y2RiNVk0bXRRaWNlYm9jc1UxTkN5QW9GbW9XRUMzODI5eTli?=
 =?utf-8?B?TUVEamNaVDdtUnYvYVNSYVNJcEM2YjdwYTA4QnhoUmdZOVRzQ1NmWkEzTCtT?=
 =?utf-8?B?RkhkaHJDNFJTWWVuc3VTRFBxQ2lIekVpUlh3S0JtOGNqK3JVa2tKSkk3V1pM?=
 =?utf-8?B?SE9Fa3V5MzJFMlYydCtYQlVKam5IL05uWVF4cUpQRVVsR0dTdXZZSjgvQjdi?=
 =?utf-8?B?a0NwZy9aZDV5cHBIcy9rbjJJeUpveXlrU1BzejdJclY0QlZ1K1JhY1RRZ1Rx?=
 =?utf-8?B?TlM3ZHVWWWtyV0NtRkxHZ3Y0UjRmaXM5M245djkxL0hqWlJnRWF2MmowRnd0?=
 =?utf-8?B?dkJDWjlzZFRFNVlreXFZM3lvSGJDeTlOZzNYMVpKd21NWXcxUnpFc090OHY3?=
 =?utf-8?B?ZDBqK0piQ1BMZ0taSEIxUWRkOStPenpaWituM3hnSGo1NkYrdmpaMU52VDFn?=
 =?utf-8?B?OHl5OWhsdzJ5b0JweGtLY1J0YUs1SWZrUUNDUFg0RytVSHllejk1bUZudllx?=
 =?utf-8?B?TTJBQlM2QUxsV29HUXdMdUtqaFVnTU9JM0JUUGFuNExtR2dMUlI1aXg2blRq?=
 =?utf-8?B?RFdJL3Q3T3hBR3cvT3YzWkgwWW5JWDduOEpHTlovQ1k0WWFGY2J5QmZ4MHpz?=
 =?utf-8?B?K2huWGQ5VnZqOEVpR1c2Z0xTT0Y4VFpveDlIMW9OMHE0Q1QweS9kSitUNThm?=
 =?utf-8?B?cy8xcEU1TTc0TkdkWGluemtkUGlNZ1QwaDg3R0t3ejY4RFVNMFZraWpwV1RK?=
 =?utf-8?B?SC8yckhSQjNaVXVMaG53NWdGcE5JUG1yV3VHM1FXdUN3eHlFOUUrdlBxMXhW?=
 =?utf-8?B?Smg3SEM3T3hnVTdlV0tYWFd1U08vYjVCSGF1eFJSNzVSdWM5bnRZL1lpOWFs?=
 =?utf-8?B?a0I1NU41Q3orZkk0RlVNQVJSblBPZ1Jic0dtT2I0eXJFOGJOQ0c0KzZSQUYx?=
 =?utf-8?B?MVFRRWVFVTAydFc1T0pKcHc2OWNqTWtDeVhoQWI3NTFGK3NmRnZ2U1BWbStB?=
 =?utf-8?B?dU1NQWZFMTFEcHo0Z2NFSVhLM1Y4eGx0Ni9idHdCMy8yeVlrK1BWS0gvUmF3?=
 =?utf-8?B?VWNTc1lHZ0VSZCs0NVN5ZTRTWUpJUnpyREE1NDZhTVVwLzA3U0svUmtucG41?=
 =?utf-8?B?UGJBTDdjTXZmZDZSMjlRMlZzbE02bHlhdXhrRWVVUytXc3N6TzVlYmxySnVn?=
 =?utf-8?B?Z2EyQUJKdVU0N2NkN1hZajZGLzV4alBNanVpaENxeHZxQWFjazBhSG1BZkE0?=
 =?utf-8?B?akdXeWFiZ0ZsMGpSa21acnZOMXEvZjNWYno1YXc5Ti9qQ3F3SEd2RzRpTmVh?=
 =?utf-8?B?SWFSVkJObWU0MnFmcXlXdlUyZ05ZS3YxSUErdldPdzl3YllhSitobTRUd1pn?=
 =?utf-8?B?SFM3Q3J1SnZMVjZSVEJYdGVkbnp1M1JlSnhOZXJ2bVU2bTdvdzExYU1sQlBQ?=
 =?utf-8?B?bVBySjM2T3NGUzFnbEx1Ry9HSXFROWNaZ1lneTdQRTRobVlqaE90azRNQkJF?=
 =?utf-8?Q?AqUOE3vY3qr+Rjnoy1kDRnFTW86RKQjw5AI7I?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <038F369B20D99C41B1FCBE9F5AAC7047@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ea9c7e5-8585-4300-9959-08de52da00bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2026 19:29:00.1505
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zlWm2HErDUVUFkRnUN0czMBj7Y86DWy9Hs8l/KEHdsdyhUYrgCNQIcONrQkbP4P7EJWBFLK0MgVgMTBktfCETA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4449
X-Authority-Analysis: v=2.4 cv=DI6CIiNb c=1 sm=1 tr=0 ts=69669d01 cx=c_pps
 a=n1uwvu+HdmtEBt1mSuDWUg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=96IgwiJGe8SnkTifBlMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 78wcRAAezVc6go8D1CpN_rJ4ncbZC5qr
X-Proofpoint-ORIG-GUID: vjFenPAtX9_0OEM_UHSmd72ngisF0uED
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDE2MSBTYWx0ZWRfX38QR5fTgHRdS
 5dfJqaMU/xQffm0EMYVt8LqjQa7dpVtthLD7pMBB3uoXs6s6lVuMV6NPnQdiYuhRPXagB2WUBda
 ra2OiAV12QGguq27vr2PJOH1sTGs3696J05BNbB/mScuSG0CLUbJeXQMU5XFqVA8kYMXgIljD/2
 Hp9SXHaaWQtTg23IdGGz3HkZ10ua6XNgHF5F5kCJQLwUPzpeh8uP1qn5swB43Mtdabvd6daMyUD
 VK6UrgT0HQcnfjH91goLMCTmIoKhmNHYDWLqiq/xmqDRL1O36nb+YR38hUxsJZdW4IeJcXpDA+u
 +HvUhiqxX3tS0ThHXIBpCLLtnE4LSef0gOJqFLpJ0JKcamUatP3Ps0JD0z8pzrAtso+7f2eNofk
 Q+2EjhhI/nXc6y8RtpSa4U0qhua4mLcEsDOjjOIgLZzSt30yYHs4yGeIzBEYa98rwmkA+V0VFNV
 bLBwxG+Netg6pjy1LCw==
Subject: RE: [PATCH] mount: (manpage) add CephFS kernel client mount options
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_04,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 spamscore=0 suspectscore=0 phishscore=0 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2512120000
 definitions=main-2601130161

T24gVHVlLCAyMDI2LTAxLTEzIGF0IDIwOjE0ICswMTAwLCBLYXJlbCBaYWsgd3JvdGU6DQo+IE9u
IE1vbiwgSmFuIDEyLCAyMDI2IGF0IDEyOjU4OjM4UE0gLTA4MDAsIFZpYWNoZXNsYXYgRHViZXlr
byB3cm90ZToNCj4gPiBGcm9tOiBWaWFjaGVzbGF2IER1YmV5a28gPFNsYXZhLkR1YmV5a29AaWJt
LmNvbT4NCj4gPiANCj4gPiBDdXJyZW50bHksIG1hbnBhZ2UgZm9yIGdlbmVyaWMgbW91bnQgdG9v
bCBkb2Vzbid0IGNvbnRhaW4NCj4gPiBleHBsYW5hdGlvbiBvZiBDZXBoRlMga2VybmVsIGNsaWVu
dCBtb3VudCBvcHRpb25zLiBUaGlzIHBhdGNoDQo+ID4gYWRkcyB0aGUgZGVzY3JpcHRpb24gb2Yg
Q2VwaEZTIG1vdW50IG9wdGlvbnMgaW50bw0KPiA+IGZpbGUgc3lzdGVtIHNwZWNpZmljIG1vdW50
IG9wdGlvbnMgc2VjdGlvbi4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBWaWFjaGVzbGF2IER1
YmV5a28gPFNsYXZhLkR1YmV5a29AaWJtLmNvbT4NCj4gPiAtLS0NCj4gPiAgc3lzLXV0aWxzL21v
dW50LjguYWRvYyB8IDg2ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
Kw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgODYgaW5zZXJ0aW9ucygrKQ0KPiA+IA0KPiA+IGRpZmYg
LS1naXQgYS9zeXMtdXRpbHMvbW91bnQuOC5hZG9jIGIvc3lzLXV0aWxzL21vdW50LjguYWRvYw0K
PiA+IGluZGV4IDQ1NzFiZDJiZmQxNi4uMTkxYTNmYWJmNTAxIDEwMDY0NA0KPiA+IC0tLSBhL3N5
cy11dGlscy9tb3VudC44LmFkb2MNCj4gPiArKysgYi9zeXMtdXRpbHMvbW91bnQuOC5hZG9jDQo+
ID4gQEAgLTg1Myw2ICs4NTMsNyBAQCBUaGlzIHNlY3Rpb24gbGlzdHMgb3B0aW9ucyB0aGF0IGFy
ZSBzcGVjaWZpYyB0byBwYXJ0aWN1bGFyIGZpbGVzeXN0ZW1zLiBXaGVyZSBwbw0KPiA+ICB8PT09
DQo+ID4gIHwqRmlsZXN5c3RlbShzKSogfCpNYW51YWwgcGFnZSoNCj4gPiAgfGJ0cmZzIHwqYnRy
ZnMqKDUpDQo+ID4gK3xjZXBoZnMgfCptb3VudC5jZXBoKig4KQ0KPiANCj4gSXQgc2VlbXMgdGhh
dCBhbGwgd2UgbmVlZCBpcyB0aGlzIGNoYW5nZS4NCj4gDQo+ID4gIHxjaWZzIHwqbW91bnQuY2lm
cyooOCkNCj4gPiAgfGV4dDIsIGV4dDMsIGV4dDQgfCpleHQ0Kig1KQ0KPiA+ICB8ZnVzZSB8KmZ1
c2UqKDgpDQo+ID4gQEAgLTkxMyw2ICs5MTQsOTEgQEAgR2l2ZSBibG9ja3NpemUuIEFsbG93ZWQg
dmFsdWVzIGFyZSA1MTIsIDEwMjQsIDIwNDgsIDQwOTYuDQo+ID4gICoqZ3JwcXVvdGEqKnwqKm5v
cXVvdGEqKnwqKnF1b3RhKip8KnVzcnF1b3RhKjo6DQo+ID4gIFRoZXNlIG9wdGlvbnMgYXJlIGFj
Y2VwdGVkIGJ1dCBpZ25vcmVkLiAoSG93ZXZlciwgcXVvdGEgdXRpbGl0aWVzIG1heSByZWFjdCB0
byBzdWNoIHN0cmluZ3MgaW4gXy9ldGMvZnN0YWJfLikNCj4gPiAgDQo+ID4gKz09PSBNb3VudCBv
cHRpb25zIGZvciBjZXBoDQo+IA0KPiBJZiBtb3VudC5jZXBoKDgpIGV4aXN0cywgd2UgZG8gbm90
IG5lZWQgdG8gcmVwZWF0IHRoZSBtb3VudCBvcHRpb24gaW4NCj4gbW91bnQoOCkuIFRoZSBpZGVh
bCBzb2x1dGlvbiBpcyB0byBrZWVwIGZpbGVzeXN0ZW0tc3BlY2lmaWMgbW91bnQNCj4gb3B0aW9u
cyBpbiB0aGUgZmlsZXN5c3RlbS1zcGVjaWZpYyBtYW4gcGFnZSBtYWludGFpbmVkIGJ5IHRoZQ0K
PiBmaWxlc3lzdGVtIGRldmVsb3BlciA6LSkgIFNlZSBidHJmcywgZXh0TiwgWEZTLCBldGMuDQo+
IA0KDQpNeSBhc3N1bXB0aW9uIHdhcyB0aGF0IGlmIG90aGVyIGZpbGUgc3lzdGVtcyBoYXZlIGRl
c2NyaXB0aW9uIG9mIHNwZWNpZmljIG1vdW50DQpvcHRpb25zIGluIHRoaXMgbWFuIHBhZ2UsIHRo
ZW4gQ2VwaEZTIHNob3VsZCBoYXZlIHRvby4gOikgQnV0IGlmIGl0IGlzIG5vdCByaWdodA0Kc3Ry
YXRlZ3ksIHRoZW4geW91IGFyZSBjb3JyZWN0IGhlcmUuDQoNCkxldCBtZSBzaHJpbmsgbXkgcGF0
Y2ggdGhlbi4NCg0KVGhhbmtzLA0KU2xhdmEuDQoNCg==

