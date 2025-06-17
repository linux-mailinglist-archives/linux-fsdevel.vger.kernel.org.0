Return-Path: <linux-fsdevel+bounces-51959-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23DB9ADDB3F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 20:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0828E3A88A0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 18:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24BA927817A;
	Tue, 17 Jun 2025 18:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WvwuQ2RA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CAC217F40;
	Tue, 17 Jun 2025 18:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750184505; cv=fail; b=EpV+ernhY+W2g69D7IpLj8Q1uvdxr+zqPnY1vghsxv5+tFJpRoAnqEux2SLjl8fyoOkeSA5LXN903WHM7kT5pe7BCKiUQ5UfRcwsyLztxjpIsOyy0nF7q2Q89saAXFB9DWxGiCX0t2iBm8MvDX40s8Rl1Djt05WhIt/c1uzAc40=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750184505; c=relaxed/simple;
	bh=jP8VUobzpXuaadNDVNnNuZzuWfCzdR0xljPPb/UbYwo=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=impDi4oeI+pQXuUdtlA9ft0Jy1q7/LJRzHx/Ppds9hqJXS9sOlq8QyDU1b+Pc0v+R0fzH5YNLx0jaiWOQaY1d/Nb2nRNgkxNhlbW3+hrHk2Le3g5HqRT+NjDdRDZGZfOrimZpB/eIpE17AK/f2htZ8I+jyjlna/1pefCRF0iTIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WvwuQ2RA; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55HDmfwn007523;
	Tue, 17 Jun 2025 18:21:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=jP8VUobzpXuaadNDVNnNuZzuWfCzdR0xljPPb/UbYwo=; b=WvwuQ2RA
	/5tlYPGxjjdsDTIl/0Bq/FpGEoCH0xr6VJgi32jDyq74L37Gf9ZcLBckVryP1fhH
	YivSLoYpNeKGLlX05kugm7BeyiKrjCjZS06ZnJZlrhrI3CoV13xXZgEEK6Uj88jO
	9Y5BiNA4MzC3ChvXW1eikIU5K1w0CDYpUPf9XkucaJLG9gFTNQDvQCeBmt4u7rIc
	uiV69jaEw02MAYh4M8ScndOAgi0vlwtBtf0MeekJdgxXW6cViU8liDALrPCEoDSa
	UDt8Gohx3cS3otJCAbxR5EwB/246mHlXhAnzVAkPZuOE4yXxBgWMaH3gEvnsWTm0
	TgVjERtMRGQtOA==
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4790r21q5a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Jun 2025 18:21:42 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rOytC9hGhl+y5E+3FLy1O5UtTw+5FP/EL6bSka3R4e8ulKBiudmbS8NkaPpNNoBQfSqpHPzV44e+spTG5zDNrMP0y0zkYOI7BZJ5IKnnUVy9mF3Tk71NgngHPBTC4BV5YlVEcT0C8SUMOapuWZp7BbqSSoctRfsmWXwJpIbUEElOlP73LehpU8ThuLkL2SuW5Y7CVBnI6EtqqmdikfBsWfNpvso8EelRM/DUdU+PCSu6qvA+sNbDGX5wvjCxJpphtpuFx7+aCa3ZX5OFr1EHKAZ3RY63EtPr1QV8fKwQgzo9U36ptMtmjKd5GgbB1h3M/lC12OCybDSEFtFiE59nDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jP8VUobzpXuaadNDVNnNuZzuWfCzdR0xljPPb/UbYwo=;
 b=UDSKatYUrk77oQl0AF3XGmc67aMYsatKJOK+VJfGNIFnvhYrRhFd8xwczo6pz0hLVqQckAsdGGKIA9Mgfvt8leEBx6bht9TGj+klcswTWUotdrBQyawmn9McLN62DXvI/E7sWSe9OZq+N0VB0STNo0O0GNII7cUAWj7JgdKdHdBjy6L9bKfPvYTmn9fAThiP/h0EknTJ1y8vxMh/cveGDd3TjdyxsdN4u45NegO+37o4taxQBZ+rxJpN3AMIcvrBJCqZnGX3c3o5N3GSQYF3mWuBl9yN71SeQvRV1n+QDyTqBLM0CNxTCXJpcclUuOLy8PuP0UIZQib10PcH7skFFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by CY8PR15MB5554.namprd15.prod.outlook.com (2603:10b6:930:96::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Tue, 17 Jun
 2025 18:21:39 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%7]) with mapi id 15.20.8835.027; Tue, 17 Jun 2025
 18:21:38 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
CC: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Thread-Topic: [EXTERNAL] [PATCH 3/3] ceph: fix a race with rename() in
 ceph_mdsc_build_path()
Thread-Index: AQHb3PTKzfhUZV4KfkGjaTmqsRZa+LQHr2oA
Date: Tue, 17 Jun 2025 18:21:38 +0000
Message-ID: <f9008d5161cb8a7cdfed54da742939523641532d.camel@ibm.com>
References: <20250614062051.GC1880847@ZenIV>
	 <20250614062257.535594-1-viro@zeniv.linux.org.uk>
	 <20250614062257.535594-3-viro@zeniv.linux.org.uk>
In-Reply-To: <20250614062257.535594-3-viro@zeniv.linux.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|CY8PR15MB5554:EE_
x-ms-office365-filtering-correlation-id: 9fef9d04-e73c-4eaf-d728-08ddadcbcd33
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?eXhJcEVDQ20zMDc1ZVErMEtPZ2hPNkVlMmtKSUZrdXdMNWxOTTQyOS85b3Rj?=
 =?utf-8?B?ejZjZ21HZlpYTWhHcDdiOGVOV1VRL2R0L01ncGpSVWVKUE5WbGVyUDZQVkZW?=
 =?utf-8?B?R3daUHJnK2xnei9zb0x5eG9PWkZBTjB5dEtjVmFFbGtSZ3J1QkNGcVkvMThU?=
 =?utf-8?B?QkdHSTdaTFlGRFcrZzE0OUtpdHZEYVZuNWNYWlNNMzI2RGlRVG5SYnQrcjhQ?=
 =?utf-8?B?OWcrKzhzM1dBOHgzaXdKMUMrb1huQXB4UDVPV2FYL3pweWIvS0h6YkRIK2FX?=
 =?utf-8?B?RU5Sazg2aE01aTVTOXZVVEhtTXBHMTFLc1cwd0t2QTZZbTFnd2xVYXVTSU5K?=
 =?utf-8?B?U09LVmNOMSt3Ym1xNjlaMDdIeFE2a2h3Q1FBckYxNlpkazQzb3BZQnBTeUg3?=
 =?utf-8?B?NkQ3cjNkYUpLSXBZNUlPaHFlYmtGbDRpN0xIKzZmcXc4Um5iclQ0RC9pZkow?=
 =?utf-8?B?bERpQmJrVG53ZlJjK1p2NHA4dGVBUzh6bXNoUTNqWEkxejMwME00ajBIOHFU?=
 =?utf-8?B?MW0wVzdrRjVLRnczWTluUEVMc3hteENIdWR5WWhsTnV0YjQwYnNYNVhDNmo0?=
 =?utf-8?B?eDRBcGJVTEt5QW1mbDBtbjlpYXFHR0Y2TnJHU05rQ1F3KzhWTlY5NFZOeFlo?=
 =?utf-8?B?MzhpTDcwSk5leHM5Uk4xaGowTTE3S3FPYnFRcW9zVnNsZDQvNklsWFFxTnIw?=
 =?utf-8?B?WnJKWHdtNDFILzN2RkJ2eTVnMFdZNXpWZzBobjZZZzVxZHZsUmpwaXN6bGs5?=
 =?utf-8?B?MitxRjFJMEF2SjBVWjFDZFRuWWc1U0NGNjVwWU52Nk9UOXBNRG5uWkpTa2pS?=
 =?utf-8?B?YWFJbStyNXloMXRhdVZQZGRwRnplMEhWcGtXK3hxZjVxNXFQOVdBUUlBajc2?=
 =?utf-8?B?b1pkSTI2MXdVSkpPU1UwTE9ld3FyV1VhVjRFTHU3ZVVZNVhTOEt1UEVDU1o3?=
 =?utf-8?B?MnNtMUJ5Qm5NSFBNY2d5RU9VZXdSQVpYQXFWY2JsMDhGYllXeTk1aHFVVk5v?=
 =?utf-8?B?Yy8yb3BWTFpEenVsdTRUYlJPNExqZXhvTGZwMlRmWGdjWGN5UGEyUFV2eDVr?=
 =?utf-8?B?dXE1MHZZWTZSMWdxNGZRcUxIY2Q3Sm11WDJIVDlSV2RQZ0hwaG9KRWc3bGpY?=
 =?utf-8?B?RjRqYTNjSGhtYlBFMmpvMDFLYXE5Kzh2bTJhLzlQL3gzRC9ySlRSVGZCWTV6?=
 =?utf-8?B?UnFPSDdkaUd1c3l2TmZXT001Mks5RkZzeSt3b1pISDZzT3JtQm1WdjlraElT?=
 =?utf-8?B?cnBjS0ZUbVF2Q3J3M2FCZkp6SFh2Q3ljTjk4UlVGUFJTdjZNR1dhcEpXd2d2?=
 =?utf-8?B?YVIyTVhOcVczdHNLY2NyTTdseUt3elBWOHdXeXVFMFZrNUIveGlLL01rOGVy?=
 =?utf-8?B?aDM3MXFaV2ljZXl5K25YbWl0YVBnMlVtdEdUMjBmdkF2YkRnS2oyRGVwV3oy?=
 =?utf-8?B?OGNDajlaaGRMcW9RMHRtRnVNSmZkNlRPMWp6N000OFl4cjhUR2ZWNkpDWFFG?=
 =?utf-8?B?NzVkQ0tOWFlFSlF5cTh4NDRaOFJ3YW85N1Z5aVlaV3JtREVTNTFuem9NTnV1?=
 =?utf-8?B?V2NxeEJnQUFMVnc1QVVwYTMwSGkrT3QvdTJ0MzNJbHIxQ2cxazJiZklrTUd4?=
 =?utf-8?B?amk2bE4yZ3g5ZjlJbHlWVHFoOGtzRkhYVE1JOU9JMi8rY1IwQ1gxZGRJanFB?=
 =?utf-8?B?cW44NVlQZlRHTnU1Ti83cWZ6MnQvK0FlQkY5WFV5Yzlrdy81WWdxYitmZjJY?=
 =?utf-8?B?TFpka3ZGazE3Q3BjQVhkM2lndWFoejZGelhxQVhUT1huMXBaWjZtOVJBTlRY?=
 =?utf-8?B?OVFZb0NucVRpMTd2S2Uxa2F5VjRaS3AxWkE2M1lFWGQ5MjFHbzdSN21lS2t1?=
 =?utf-8?B?bDlnQ1ZUQ2VmcW15WVIySW5yL21DSlA0RUdFUnM2UHFGR1JacHNTNitDNEhT?=
 =?utf-8?B?c1pKczhZSnFsZFpFN2tSKzdZUHEvd2wrdmJtOWpoaW9lZy9YOFY0WVJ4M1M5?=
 =?utf-8?B?anh3azQxSGN3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?akVkKy9hMFlQOXlZYUdmUG02VUQ4T1dQeVd5dlFUVWIrWFB0dWZZRVhzN2pi?=
 =?utf-8?B?WlplZzVFdjEyWTJpbEcyMnVOUFFUR1lqTDU2dDVtdUZJMEJpeHpibFU5UnB0?=
 =?utf-8?B?RGFBS25mWUFhcURhV3F4VnNtTW1iSU9CYzk1Z3M2SDNhSjU5TFhBTTJYWDhn?=
 =?utf-8?B?alhaeW1xOFNWWkgrSmswNDg0Vi9jOFVVU3l1Sk1xLzdPZ0psd2JUMHZKWlEx?=
 =?utf-8?B?RTdsdHh6MHFHc003Um1wVUF4ZzFEbU1LTkpJZ01XcHFxd2o2OE9PeHRNQmFs?=
 =?utf-8?B?ZFBGMHl6RUFGdXN6OFJPT29IRUU3dGUwWFRuS0I0TEc4VjhlUkVVQS8xK1pj?=
 =?utf-8?B?U2puSHZSeG5VQU5BZ1JwVU9KZWdSWU1PdnFPY0g0dEtGN29EeG1BZzZsZjB5?=
 =?utf-8?B?RElIbk8yZTFGUzRraGhTT1FtQ2xSeW1VNGZlaUdNemp1WE16STZTRkV2TGox?=
 =?utf-8?B?WDAyZmtaSG5PbVFyZmdiQkl2YTBHb2xxMDQweDI4SGV1Nkp2VmtHU3NtcTJE?=
 =?utf-8?B?eC9LOXE2aGZWS1VwcEJpN0JxMUY2OGt3bXJHaHVCQ2dLU3B5bXVKNWVoSWNa?=
 =?utf-8?B?NUxadFhuRm85MElMT04vVEp4VTlWa1lDWXpJUy9HU0NGNkpIVEhhU2pMOEts?=
 =?utf-8?B?MWx6cjBmdk0ySStPdFRhT1hMeERJM1BldnRhdVZDbExSL3lvY2hMSHE4ZXJD?=
 =?utf-8?B?blQwQThDTnJyc3Nyd0c4ckFlaUtFRk1IdC9QTkQ0N0RoRnVNRWp6VTBVK1FT?=
 =?utf-8?B?Q2RaQ1lId1RnSnU3QXdzdFNNUEt6Zkp0MjlkSTh6emp5bFZJSjRxMVo2ZkFM?=
 =?utf-8?B?YnlZNWREYjUyMGFBa05NQUtJL0pqczUzelFFelc5RzRueFU5NUF3VDJERHNs?=
 =?utf-8?B?ZFRLSUVobU94a2h4bUwrU1NKTXYwdFZMMVJWOXBjeVhuOE9naVFJTEFMWWRY?=
 =?utf-8?B?dklpMHlFRzlWZE5aRHpwbEpxdk54UTltZlRNMW90VnM2NHBIZDNDeHZMZ1E3?=
 =?utf-8?B?L2dVeG4wUENTcG1TRnNIVUdldHlPUzIvKzlJWFhZVm8zTjdPalEzVTNaZlNJ?=
 =?utf-8?B?T0Z1Y1ZEZnowSHdhd1lkNVl2eElDV253V3RiTWx4bEQ4WStxZDZxbzZIMHFo?=
 =?utf-8?B?cEJ0amcrd3ZyUXBvUGpHc0Z1dEk4ekR1TERUNzFaZHBoRVJLMUhNNnpzVUZ5?=
 =?utf-8?B?bzQ1dGdKdUtwSTRJWE5iL2hGSVdiRmEzOHdwWG5XbzJhY21EcFFwa2FaaHlS?=
 =?utf-8?B?aWNnSDJkWllpbUFGeThhVG02SXJJdWhTdE1WQXM4VHkrTGdSY1JtNURpS0w3?=
 =?utf-8?B?TklLa3VDa2NzaUJMN3FDUlIwOVJzWFNXcTErWnM0V1VFWW1kUGg1MTN6RFQy?=
 =?utf-8?B?eTNMenZRNjkwdmFsSE5CUC9mWFBpSTM0TktjR29hVXBDR2xxdFl5UnJxMlVR?=
 =?utf-8?B?R1AzaW5kWTBRcFAyOUJTNUVkOUswU1Y5UU5PeVJ5UVBXNENpZVUxaERGeFNs?=
 =?utf-8?B?V1R5MmNidlgwQm50MVk1aENCcmF5TkFUN0ozWjc2dlUxVlZOKzgxMU00L3hh?=
 =?utf-8?B?bVJoL1hXcDN4SXo3Y213ZTlWOGpLMFNZZjk3aEdSVXJnNE9teDVYTVp2UmZv?=
 =?utf-8?B?N3RoWU00MytrR04rM2wxblVFUWRjZjR0cWUxcHM0Q0VVRWZORDV2VUtIMWkx?=
 =?utf-8?B?L0p6UlhQakZIQThQRWxsQlNvaGpZcnZTRFFlbHpLSHpiaXA1a0J6WmtWZkZo?=
 =?utf-8?B?R3BRSFpWQ2wwMG1oQllIL1pHOUpsY3VzSk9KUnY3VkdPOGZkeFVpSk92aXN0?=
 =?utf-8?B?OVk3OVVYeVpsWDl0SGV2NjZsRFd2cTI1K1Rudmc1NUY1Q2tHR2hMY09IOGtM?=
 =?utf-8?B?QmVydTVPMGF5UWQvbHp3RzRkMCtPenlEREk3RTlzQzIyZEUrVldLd2FJam9p?=
 =?utf-8?B?RTJEUmhWYkVhaENQMWhGaEg4QXpQUDNTcXdCMzBrcElhOUwycXpnMzdlUnhV?=
 =?utf-8?B?RFUwM2ZUR1BHV05RenE1ZzJoYlQ4amFFQ0xqRGdibTVPV0Q5R1EybVVUZHR4?=
 =?utf-8?B?Uk9WazV5VkRWNmIyRS94SHZhelRkTk5BNlZzWGh3a2dmZWordSsvQTZTekwx?=
 =?utf-8?B?ckViRFVZd1pJMTcwTFZDSWlleXB5RGhkSUJxSUlWVUNsYjZablhDQ3RKc3lu?=
 =?utf-8?Q?bLKP2oBtIkQrvKAoSKTegUI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <701947F1A6198D4594AF0758C64C7B26@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fef9d04-e73c-4eaf-d728-08ddadcbcd33
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2025 18:21:38.8652
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZF+n0yFbyqo+zqBCvTn00zVsuz7KisYJ9kbZQJfHITjUr7htb+tZ2uUj/ygvbkyqMVCcYRuN5hWD2I7llGoDSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR15MB5554
X-Proofpoint-GUID: 7TJK10MszuihrGy2sfU9jrGSe_YJ23Vo
X-Proofpoint-ORIG-GUID: 7TJK10MszuihrGy2sfU9jrGSe_YJ23Vo
X-Authority-Analysis: v=2.4 cv=AqTu3P9P c=1 sm=1 tr=0 ts=6851b236 cx=c_pps a=vKeSO0BrL3/Ii9Ozv4iuzw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=SmkHewMKT1EVu9Eo:21 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=drOt6m5kAAAA:8 a=VnNF1IyMAAAA:8 a=xPPaGEVpfZl3r7pYv-YA:9 a=QEXdDO2ut3YA:10 a=RMMjzBEyIzXRtoq5n5K6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE3MDE0NiBTYWx0ZWRfXw3XMD5Zn6+Oa rQYmAUqWL9sYDotm+D5VC7Qx41XYrj2b3ebYYA0ukFfN56jDuk4dHGT+XIcusGkisMYJKs2hzoS W1rqNpmxMPldhtf5M7+YYiF2KQt1CSjOJVfX6/lMPp2fBrJtFtalRXqpNqXepSbOjlqhJ4RsDGp
 5cpOegoy1zpfIV2An/S+P0WLGc+gzLPwIjQiovakq4h+n/g0eYHVMSUpywyFazRg1ofcD0++nmr bBnfLUgTOKkSUNozsdV8gsIh3oATpK2yfixJjIemBLX/Zb5GAeCGEzQS+R5Vq5WbRYF/upHPWko 1QQLu6YwyujHpX5+L/vRfol5+7qR8Jpu9l1yhrpxQpNKg7M/bWtGuuQkjL8gU3oDibROtdAJdEG
 5rgaqfDPFgGe1oO8Tl7JzYsrrQQ7jYJfCeRMTfzIJ/D9w+sQ6khkiZp9O8agvXCXkVXuxAzB
Subject: Re:  [PATCH 3/3] ceph: fix a race with rename() in ceph_mdsc_build_path()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-17_08,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 mlxscore=0 spamscore=0
 bulkscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506170146

T24gU2F0LCAyMDI1LTA2LTE0IGF0IDA3OjIyICswMTAwLCBBbCBWaXJvIHdyb3RlOg0KPiBMaWZ0
IGNvcHlpbmcgdGhlIG5hbWUgaW50byBjYWxsZXJzIG9mIGNlcGhfZW5jb2RlX2VuY3J5cHRlZF9k
bmFtZSgpDQo+IHRoYXQgZG8gbm90IGhhdmUgaXQgYWxyZWFkeSBjb3BpZWQ7IGNlcGhfZW5jb2Rl
X2VuY3J5cHRlZF9mbmFtZSgpDQo+IGRpc2FwcGVhcnMuDQo+IA0KPiBUaGF0IGZpeGVzIGEgVUFG
IGluIGNlcGhfbWRzY19idWlsZF9wYXRoKCkgLSB3aGlsZSB0aGUgaW5pdGlhbCBjb3B5DQo+IG9m
IHBsYWludGV4dCBpbnRvIGJ1ZiBpcyBkb25lIHVuZGVyIC0+ZF9sb2NrLCB3ZSBhY2Nlc3MgdGhl
DQo+IG9yaWdpbmFsIG5hbWUgYWdhaW4gaW4gY2VwaF9lbmNvZGVfZW5jcnlwdGVkX2ZuYW1lKCkg
YW5kIHRoYXQgaXMNCj4gZG9uZSB3aXRob3V0IGFueSBsb2NraW5nLiAgV2l0aCBjZXBoX2VuY29k
ZV9lbmNyeXB0ZWRfZG5hbWUoKSB1c2luZw0KPiB0aGUgc3RhYmxlIGNvcHkgdGhlIHByb2JsZW0g
Z29lcyBhd2F5Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQWwgVmlybyA8dmlyb0B6ZW5pdi5saW51
eC5vcmcudWs+DQo+IC0tLQ0KPiAgZnMvY2VwaC9jYXBzLmMgICAgICAgfCAxOCArKysrKysrLS0t
LS0tLS0tLS0NCj4gIGZzL2NlcGgvY3J5cHRvLmMgICAgIHwgMTkgKystLS0tLS0tLS0tLS0tLS0t
LQ0KPiAgZnMvY2VwaC9jcnlwdG8uaCAgICAgfCAxOCArKysrLS0tLS0tLS0tLS0tLS0NCj4gIGZz
L2NlcGgvZGlyLmMgICAgICAgIHwgIDcgKysrLS0tLQ0KPiAgZnMvY2VwaC9tZHNfY2xpZW50LmMg
fCAgNCArKy0tDQo+ICA1IGZpbGVzIGNoYW5nZWQsIDE4IGluc2VydGlvbnMoKyksIDQ4IGRlbGV0
aW9ucygtKQ0KPiANCg0KVGVzdGVkLWJ5OiBWaWFjaGVzbGF2IER1YmV5a28gPFNsYXZhLkR1YmV5
a29AaWJtLmNvbT4NClJldmlld2VkLWJ5OiBWaWFjaGVzbGF2IER1YmV5a28gPFNsYXZhLkR1YmV5
a29AaWJtLmNvbT4NCg0KVGhhbmtzLA0KU2xhdmEuDQoNCj4gZGlmZiAtLWdpdCBhL2ZzL2NlcGgv
Y2Fwcy5jIGIvZnMvY2VwaC9jYXBzLmMNCj4gaW5kZXggYThkOGI1NmNmOWQyLi5iMWE4ZmY2MTJj
NDEgMTAwNjQ0DQo+IC0tLSBhL2ZzL2NlcGgvY2Fwcy5jDQo+ICsrKyBiL2ZzL2NlcGgvY2Fwcy5j
DQo+IEBAIC00OTU3LDI0ICs0OTU3LDIwIEBAIGludCBjZXBoX2VuY29kZV9kZW50cnlfcmVsZWFz
ZSh2b2lkICoqcCwgc3RydWN0IGRlbnRyeSAqZGVudHJ5LA0KPiAgCWNsID0gY2VwaF9pbm9kZV90
b19jbGllbnQoZGlyKTsNCj4gIAlzcGluX2xvY2soJmRlbnRyeS0+ZF9sb2NrKTsNCj4gIAlpZiAo
cmV0ICYmIGRpLT5sZWFzZV9zZXNzaW9uICYmIGRpLT5sZWFzZV9zZXNzaW9uLT5zX21kcyA9PSBt
ZHMpIHsNCj4gKwkJaW50IGxlbiA9IGRlbnRyeS0+ZF9uYW1lLmxlbjsNCj4gIAkJZG91dGMoY2ws
ICIlcCBtZHMlZCBzZXEgJWRcbiIsICBkZW50cnksIG1kcywNCj4gIAkJICAgICAgKGludClkaS0+
bGVhc2Vfc2VxKTsNCj4gIAkJcmVsLT5kbmFtZV9zZXEgPSBjcHVfdG9fbGUzMihkaS0+bGVhc2Vf
c2VxKTsNCj4gIAkJX19jZXBoX21kc2NfZHJvcF9kZW50cnlfbGVhc2UoZGVudHJ5KTsNCj4gKwkJ
bWVtY3B5KCpwLCBkZW50cnktPmRfbmFtZS5uYW1lLCBsZW4pOw0KPiAgCQlzcGluX3VubG9jaygm
ZGVudHJ5LT5kX2xvY2spOw0KPiAgCQlpZiAoSVNfRU5DUllQVEVEKGRpcikgJiYgZnNjcnlwdF9o
YXNfZW5jcnlwdGlvbl9rZXkoZGlyKSkgew0KPiAtCQkJaW50IHJldDIgPSBjZXBoX2VuY29kZV9l
bmNyeXB0ZWRfZm5hbWUoZGlyLCBkZW50cnksICpwKTsNCj4gLQ0KPiAtCQkJaWYgKHJldDIgPCAw
KQ0KPiAtCQkJCXJldHVybiByZXQyOw0KPiAtDQo+IC0JCQlyZWwtPmRuYW1lX2xlbiA9IGNwdV90
b19sZTMyKHJldDIpOw0KPiAtCQkJKnAgKz0gcmV0MjsNCj4gLQkJfSBlbHNlIHsNCj4gLQkJCXJl
bC0+ZG5hbWVfbGVuID0gY3B1X3RvX2xlMzIoZGVudHJ5LT5kX25hbWUubGVuKTsNCj4gLQkJCW1l
bWNweSgqcCwgZGVudHJ5LT5kX25hbWUubmFtZSwgZGVudHJ5LT5kX25hbWUubGVuKTsNCj4gLQkJ
CSpwICs9IGRlbnRyeS0+ZF9uYW1lLmxlbjsNCj4gKwkJCWxlbiA9IGNlcGhfZW5jb2RlX2VuY3J5
cHRlZF9kbmFtZShkaXIsICpwLCBsZW4pOw0KPiArCQkJaWYgKGxlbiA8IDApDQo+ICsJCQkJcmV0
dXJuIGxlbjsNCj4gIAkJfQ0KPiArCQlyZWwtPmRuYW1lX2xlbiA9IGNwdV90b19sZTMyKGxlbik7
DQo+ICsJCSpwICs9IGxlbjsNCj4gIAl9IGVsc2Ugew0KPiAgCQlzcGluX3VubG9jaygmZGVudHJ5
LT5kX2xvY2spOw0KPiAgCX0NCj4gZGlmZiAtLWdpdCBhL2ZzL2NlcGgvY3J5cHRvLmMgYi9mcy9j
ZXBoL2NyeXB0by5jDQo+IGluZGV4IDJhZWY1NmZjNjI3NS4uZTMxMmY1MmY0OGU0IDEwMDY0NA0K
PiAtLS0gYS9mcy9jZXBoL2NyeXB0by5jDQo+ICsrKyBiL2ZzL2NlcGgvY3J5cHRvLmMNCj4gQEAg
LTI1MywyMyArMjUzLDE2IEBAIHN0YXRpYyBzdHJ1Y3QgaW5vZGUgKnBhcnNlX2xvbmduYW1lKGNv
bnN0IHN0cnVjdCBpbm9kZSAqcGFyZW50LA0KPiAgCXJldHVybiBkaXI7DQo+ICB9DQo+ICANCj4g
LWludCBjZXBoX2VuY29kZV9lbmNyeXB0ZWRfZG5hbWUoc3RydWN0IGlub2RlICpwYXJlbnQsIHN0
cnVjdCBxc3RyICpkX25hbWUsDQo+IC0JCQkJY2hhciAqYnVmKQ0KPiAraW50IGNlcGhfZW5jb2Rl
X2VuY3J5cHRlZF9kbmFtZShzdHJ1Y3QgaW5vZGUgKnBhcmVudCwgY2hhciAqYnVmLCBpbnQgZWxl
bikNCj4gIHsNCj4gIAlzdHJ1Y3QgY2VwaF9jbGllbnQgKmNsID0gY2VwaF9pbm9kZV90b19jbGll
bnQocGFyZW50KTsNCj4gIAlzdHJ1Y3QgaW5vZGUgKmRpciA9IHBhcmVudDsNCj4gIAljaGFyICpw
ID0gYnVmOw0KPiAgCXUzMiBsZW47DQo+IC0JaW50IG5hbWVfbGVuOw0KPiAtCWludCBlbGVuOw0K
PiArCWludCBuYW1lX2xlbiA9IGVsZW47DQo+ICAJaW50IHJldDsNCj4gIAl1OCAqY3J5cHRidWYg
PSBOVUxMOw0KPiAgDQo+IC0JbWVtY3B5KGJ1ZiwgZF9uYW1lLT5uYW1lLCBkX25hbWUtPmxlbik7
DQo+IC0JZWxlbiA9IGRfbmFtZS0+bGVuOw0KPiAtDQo+IC0JbmFtZV9sZW4gPSBlbGVuOw0KPiAt
DQo+ICAJLyogSGFuZGxlIHRoZSBzcGVjaWFsIGNhc2Ugb2Ygc25hcHNob3QgbmFtZXMgdGhhdCBz
dGFydCB3aXRoICdfJyAqLw0KPiAgCWlmIChjZXBoX3NuYXAoZGlyKSA9PSBDRVBIX1NOQVBESVIg
JiYgKnAgPT0gJ18nKSB7DQo+ICAJCWRpciA9IHBhcnNlX2xvbmduYW1lKHBhcmVudCwgcCwgJm5h
bWVfbGVuKTsNCj4gQEAgLTM0MiwxNCArMzM1LDYgQEAgaW50IGNlcGhfZW5jb2RlX2VuY3J5cHRl
ZF9kbmFtZShzdHJ1Y3QgaW5vZGUgKnBhcmVudCwgc3RydWN0IHFzdHIgKmRfbmFtZSwNCj4gIAly
ZXR1cm4gZWxlbjsNCj4gIH0NCj4gIA0KPiAtaW50IGNlcGhfZW5jb2RlX2VuY3J5cHRlZF9mbmFt
ZShzdHJ1Y3QgaW5vZGUgKnBhcmVudCwgc3RydWN0IGRlbnRyeSAqZGVudHJ5LA0KPiAtCQkJCWNo
YXIgKmJ1ZikNCj4gLXsNCj4gLQlXQVJOX09OX09OQ0UoIWZzY3J5cHRfaGFzX2VuY3J5cHRpb25f
a2V5KHBhcmVudCkpOw0KPiAtDQo+IC0JcmV0dXJuIGNlcGhfZW5jb2RlX2VuY3J5cHRlZF9kbmFt
ZShwYXJlbnQsICZkZW50cnktPmRfbmFtZSwgYnVmKTsNCj4gLX0NCj4gLQ0KPiAgLyoqDQo+ICAg
KiBjZXBoX2ZuYW1lX3RvX3VzciAtIGNvbnZlcnQgYSBmaWxlbmFtZSBmb3IgdXNlcmxhbmQgcHJl
c2VudGF0aW9uDQo+ICAgKiBAZm5hbWU6IGNlcGhfZm5hbWUgdG8gYmUgY29udmVydGVkDQo+IGRp
ZmYgLS1naXQgYS9mcy9jZXBoL2NyeXB0by5oIGIvZnMvY2VwaC9jcnlwdG8uaA0KPiBpbmRleCBk
MDc2ODIzOWExYzkuLmY3NTJiYmIyZWIwNiAxMDA2NDQNCj4gLS0tIGEvZnMvY2VwaC9jcnlwdG8u
aA0KPiArKysgYi9mcy9jZXBoL2NyeXB0by5oDQo+IEBAIC0xMDIsMTAgKzEwMiw3IEBAIGludCBj
ZXBoX2ZzY3J5cHRfcHJlcGFyZV9jb250ZXh0KHN0cnVjdCBpbm9kZSAqZGlyLCBzdHJ1Y3QgaW5v
ZGUgKmlub2RlLA0KPiAgCQkJCSBzdHJ1Y3QgY2VwaF9hY2xfc2VjX2N0eCAqYXMpOw0KPiAgdm9p
ZCBjZXBoX2ZzY3J5cHRfYXNfY3R4X3RvX3JlcShzdHJ1Y3QgY2VwaF9tZHNfcmVxdWVzdCAqcmVx
LA0KPiAgCQkJCXN0cnVjdCBjZXBoX2FjbF9zZWNfY3R4ICphcyk7DQo+IC1pbnQgY2VwaF9lbmNv
ZGVfZW5jcnlwdGVkX2RuYW1lKHN0cnVjdCBpbm9kZSAqcGFyZW50LCBzdHJ1Y3QgcXN0ciAqZF9u
YW1lLA0KPiAtCQkJCWNoYXIgKmJ1Zik7DQo+IC1pbnQgY2VwaF9lbmNvZGVfZW5jcnlwdGVkX2Zu
YW1lKHN0cnVjdCBpbm9kZSAqcGFyZW50LCBzdHJ1Y3QgZGVudHJ5ICpkZW50cnksDQo+IC0JCQkJ
Y2hhciAqYnVmKTsNCj4gK2ludCBjZXBoX2VuY29kZV9lbmNyeXB0ZWRfZG5hbWUoc3RydWN0IGlu
b2RlICpwYXJlbnQsIGNoYXIgKmJ1ZiwgaW50IGxlbik7DQo+ICANCj4gIHN0YXRpYyBpbmxpbmUg
aW50IGNlcGhfZm5hbWVfYWxsb2NfYnVmZmVyKHN0cnVjdCBpbm9kZSAqcGFyZW50LA0KPiAgCQkJ
CQkgIHN0cnVjdCBmc2NyeXB0X3N0ciAqZm5hbWUpDQo+IEBAIC0xOTQsMTcgKzE5MSwxMCBAQCBz
dGF0aWMgaW5saW5lIHZvaWQgY2VwaF9mc2NyeXB0X2FzX2N0eF90b19yZXEoc3RydWN0IGNlcGhf
bWRzX3JlcXVlc3QgKnJlcSwNCj4gIHsNCj4gIH0NCj4gIA0KPiAtc3RhdGljIGlubGluZSBpbnQg
Y2VwaF9lbmNvZGVfZW5jcnlwdGVkX2RuYW1lKHN0cnVjdCBpbm9kZSAqcGFyZW50LA0KPiAtCQkJ
CQkgICAgICBzdHJ1Y3QgcXN0ciAqZF9uYW1lLCBjaGFyICpidWYpDQo+ICtzdGF0aWMgaW5saW5l
IGludCBjZXBoX2VuY29kZV9lbmNyeXB0ZWRfZG5hbWUoc3RydWN0IGlub2RlICpwYXJlbnQsIGNo
YXIgKmJ1ZiwNCj4gKwkJCQkJICAgICAgaW50IGxlbikNCj4gIHsNCj4gLQltZW1jcHkoYnVmLCBk
X25hbWUtPm5hbWUsIGRfbmFtZS0+bGVuKTsNCj4gLQlyZXR1cm4gZF9uYW1lLT5sZW47DQo+IC19
DQo+IC0NCj4gLXN0YXRpYyBpbmxpbmUgaW50IGNlcGhfZW5jb2RlX2VuY3J5cHRlZF9mbmFtZShz
dHJ1Y3QgaW5vZGUgKnBhcmVudCwNCj4gLQkJCQkJICAgICAgc3RydWN0IGRlbnRyeSAqZGVudHJ5
LCBjaGFyICpidWYpDQo+IC17DQo+IC0JcmV0dXJuIC1FT1BOT1RTVVBQOw0KPiArCXJldHVybiBs
ZW47DQo+ICB9DQo+ICANCj4gIHN0YXRpYyBpbmxpbmUgaW50IGNlcGhfZm5hbWVfYWxsb2NfYnVm
ZmVyKHN0cnVjdCBpbm9kZSAqcGFyZW50LA0KPiBkaWZmIC0tZ2l0IGEvZnMvY2VwaC9kaXIuYyBi
L2ZzL2NlcGgvZGlyLmMNCj4gaW5kZXggYTMyMWFhNmQwZWQyLi44NDc4ZTdlNzVkZjYgMTAwNjQ0
DQo+IC0tLSBhL2ZzL2NlcGgvZGlyLmMNCj4gKysrIGIvZnMvY2VwaC9kaXIuYw0KPiBAQCAtNDIz
LDE3ICs0MjMsMTYgQEAgc3RhdGljIGludCBjZXBoX3JlYWRkaXIoc3RydWN0IGZpbGUgKmZpbGUs
IHN0cnVjdCBkaXJfY29udGV4dCAqY3R4KQ0KPiAgCQkJcmVxLT5yX2lub2RlX2Ryb3AgPSBDRVBI
X0NBUF9GSUxFX0VYQ0w7DQo+ICAJCX0NCj4gIAkJaWYgKGRmaS0+bGFzdF9uYW1lKSB7DQo+IC0J
CQlzdHJ1Y3QgcXN0ciBkX25hbWUgPSB7IC5uYW1lID0gZGZpLT5sYXN0X25hbWUsDQo+IC0JCQkJ
CSAgICAgICAubGVuID0gc3RybGVuKGRmaS0+bGFzdF9uYW1lKSB9Ow0KPiArCQkJaW50IGxlbiA9
IHN0cmxlbihkZmktPmxhc3RfbmFtZSk7DQo+ICANCj4gIAkJCXJlcS0+cl9wYXRoMiA9IGt6YWxs
b2MoTkFNRV9NQVggKyAxLCBHRlBfS0VSTkVMKTsNCj4gIAkJCWlmICghcmVxLT5yX3BhdGgyKSB7
DQo+ICAJCQkJY2VwaF9tZHNjX3B1dF9yZXF1ZXN0KHJlcSk7DQo+ICAJCQkJcmV0dXJuIC1FTk9N
RU07DQo+ICAJCQl9DQo+ICsJCQltZW1jcHkocmVxLT5yX3BhdGgyLCBkZmktPmxhc3RfbmFtZSwg
bGVuKTsNCj4gIA0KPiAtCQkJZXJyID0gY2VwaF9lbmNvZGVfZW5jcnlwdGVkX2RuYW1lKGlub2Rl
LCAmZF9uYW1lLA0KPiAtCQkJCQkJCSAgcmVxLT5yX3BhdGgyKTsNCj4gKwkJCWVyciA9IGNlcGhf
ZW5jb2RlX2VuY3J5cHRlZF9kbmFtZShpbm9kZSwgcmVxLT5yX3BhdGgyLCBsZW4pOw0KPiAgCQkJ
aWYgKGVyciA8IDApIHsNCj4gIAkJCQljZXBoX21kc2NfcHV0X3JlcXVlc3QocmVxKTsNCj4gIAkJ
CQlyZXR1cm4gZXJyOw0KPiBkaWZmIC0tZ2l0IGEvZnMvY2VwaC9tZHNfY2xpZW50LmMgYi9mcy9j
ZXBoL21kc19jbGllbnQuYw0KPiBpbmRleCAyMzBlMGMzZjM0MWYuLjBmNDk3YzM5ZmY4MiAxMDA2
NDQNCj4gLS0tIGEvZnMvY2VwaC9tZHNfY2xpZW50LmMNCj4gKysrIGIvZnMvY2VwaC9tZHNfY2xp
ZW50LmMNCj4gQEAgLTI3NjYsOCArMjc2Niw4IEBAIGNoYXIgKmNlcGhfbWRzY19idWlsZF9wYXRo
KHN0cnVjdCBjZXBoX21kc19jbGllbnQgKm1kc2MsIHN0cnVjdCBkZW50cnkgKmRlbnRyeSwNCj4g
IAkJCX0NCj4gIA0KPiAgCQkJaWYgKGZzY3J5cHRfaGFzX2VuY3J5cHRpb25fa2V5KGRfaW5vZGUo
cGFyZW50KSkpIHsNCj4gLQkJCQlsZW4gPSBjZXBoX2VuY29kZV9lbmNyeXB0ZWRfZm5hbWUoZF9p
bm9kZShwYXJlbnQpLA0KPiAtCQkJCQkJCQkgIGN1ciwgYnVmKTsNCj4gKwkJCQlsZW4gPSBjZXBo
X2VuY29kZV9lbmNyeXB0ZWRfZG5hbWUoZF9pbm9kZShwYXJlbnQpLA0KPiArCQkJCQkJCQkgIGJ1
ZiwgbGVuKTsNCj4gIAkJCQlpZiAobGVuIDwgMCkgew0KPiAgCQkJCQlkcHV0KHBhcmVudCk7DQo+
ICAJCQkJCWRwdXQoY3VyKTsNCg==

