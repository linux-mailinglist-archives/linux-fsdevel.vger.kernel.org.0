Return-Path: <linux-fsdevel+bounces-71369-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A15CBFA5C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 21:03:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B00ED305E340
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 20:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC2A328266;
	Mon, 15 Dec 2025 19:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="T6of7WEg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9B031280F
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Dec 2025 19:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765827008; cv=fail; b=BHspDG6XTxAdMI7JHPlNRgl2pYmk6nkN53mP2K+5AwcAyghRe+3HT7j0AtJM0hf28b2cOAt41laGiO2EiENJvjH8OGByJreMOl/J3VpG4JKBvQg87lMG8GZloKlCwhrFhZ7RimZfooBcI2oL2cMmjPSFoZoU/3fgyLbZGrlyTic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765827008; c=relaxed/simple;
	bh=09QLX03td3mCZrT6OFOuPFkse6no69tHn6nS6iPsWnA=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=LSt/yfm3FVP6D2c5xwcrQxC31XBKQ2hWWlk7cAkkkn5kCZk/cGyeA9+7+UElu6pGBnswVLvow1NeGER7lu/UxVJBwFxIzLU8F0Ia2MDGBpdFvu25VyM17pUB8vegUgrOuxd+PuC6A1hhN3AOzdKG4D3q06Woq37fPGHkGYhp1RM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=fail smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=T6of7WEg; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BFH5KAS024778
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Dec 2025 19:29:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=9Uo6TBEAMpzbsfKU4UK+LA80SXsvc4Uuqd/JQWQd1BE=; b=T6of7WEg
	3nFgE+UJjgVzsNIvALaqdV/H7QtQmgxhv5t57u3KbLj2VvTCpJP+Ry0id653BQa2
	xU5AzBdmCoXWjQeFZR9EjehRcGRtjHWah5mj3dQNJnW3/BD/SIAPV8Aazv8HZJI5
	RuxeD8hQpE4WDDGgcwmz+9Y5S/upJnf+jWH9e0bo4CVfsCsvAe8rLLeowbz5xwAs
	bMLSdzxotcEYMFNfJs4tIYmH+JyO/AjmwoLVfcsPdQ+ZPJnVQnvgB2jDBfpF7Wa3
	2wBrXjM5HyUwnQhUF4uhxR7Xiaguzj2QJJArXxHQt4pann8RPn9csP/CpjYm/fP+
	lg5sjzoOu1T0pA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0ytv3n2c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Dec 2025 19:29:59 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BFJKPvo003296
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Dec 2025 19:29:58 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0ytv3n25-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Dec 2025 19:29:58 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BFJN06o007295;
	Mon, 15 Dec 2025 19:29:57 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012061.outbound.protection.outlook.com [40.93.195.61])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0ytv3n23-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Dec 2025 19:29:57 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MonzlpJ1JFLk5Gcyz+MiOqrgZcAIkNLSggJ+o1eERvnf0a+bftrK5D4aIA/1udxcGv21SWs1S+D2fTLgD2KHUpRsAwA4T9A2nawi6fZBa4MQZy8LGzTpojbeyF0734Q7qWY3lxEOSNm95Z2UJFSeIqUa8YJCbM5yl2xikFNwDpnKIwLgcCYEARaFfRES0mBrsaBOd8bJZvBiz3qwNnpboNRQ7btu/PCJx9hOhTJcZuC3me8H5x4N4Sdz1SfqJCjiZnk3K/zlH/7opBW6/LfknczkeHw7nYPOuX0240l6YdYqWOoXHYeGLm0ACVUDgm+AhkNUbgx6f1VkN93DFIiQMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o0a8a4cnWY3xE6LYIsHRc/bZIw6SmkISUJ/ThNqc/h4=;
 b=HNtymBL7n6zC8s9UfmOlLBdjIsJ0G0jTWFIiItvo2hM89mvJxfY+9669EVIf30f1bMSAeIB8MMVYtYyZBSM60vXiazf830BCZdhIdhx7oFti/5cPgCVP+JkzK9Suiwgw8bf5Kl5agW9MdRYC8VP0Bka2VPLH5PzrymKdNCF0KWPpYx9BFwv80JAt1C6BkTJL9IrDp/JE9gKAWFREV4JpqUgalLwfFglhJkAV9nHW3S9blmieg/2hLgpsJoS0OCFIqk0CALVB13MGrbafzDqmoncyKkdfaKzNK2HTdqQEOQhMNcMJQYvL4RpY3Td8z+0//qbJh/sFJ8auPhf571tvoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by BY3PR15MB4819.namprd15.prod.outlook.com (2603:10b6:a03:3b6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 19:29:54 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%4]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 19:29:54 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "shardul.b@mpiricsoftware.com" <shardul.b@mpiricsoftware.com>,
        "zippel@linux-m68k.org" <zippel@linux-m68k.org>,
        "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "frank.li@vivo.com"
	<frank.li@vivo.com>
CC: "akpm@osdl.org" <akpm@osdl.org>,
        "janak@mpiricsoftware.com"
	<janak@mpiricsoftware.com>,
        "shardulsb08@gmail.com" <shardulsb08@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Thread-Topic: [EXTERNAL] [PATCH] hfsplus: fix missing hfs_bnode_get() in
 hfs_bnode_create()
Thread-Index: AQHcbIjSiGsumzDpVEutPY2yy61iRbUjGU8A
Date: Mon, 15 Dec 2025 19:29:54 +0000
Message-ID: <e38cd77f31c4aba62f412d61024183be34db5558.camel@ibm.com>
References: <20251213233215.368558-1-shardul.b@mpiricsoftware.com>
In-Reply-To: <20251213233215.368558-1-shardul.b@mpiricsoftware.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|BY3PR15MB4819:EE_
x-ms-office365-filtering-correlation-id: 5a9067f0-15d0-4888-1837-08de3c10533f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|376014|1800799024|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?cTFpQmxPZkRwVkVzdlBydTFZc0RsODhWdy9TMnFyMTJXY3JRbzlVaEh6ejlN?=
 =?utf-8?B?aTlORjNxZXdiMU9FNlZHakV3MDNpZVdWalJaZUxQNlh3M3R1VEtSY2tGZ3Nz?=
 =?utf-8?B?MzJNNHZLRVU1aTFXUyszU3l0aFhTSTJBUHdrdXYrN2FyQkpuSWQzZkNqaGZ5?=
 =?utf-8?B?c0RPYU53dE5oTG4yM0Z0RWFwWFUyMHVJd1NKcHlLMTJPUE1DRkFSbElmZE44?=
 =?utf-8?B?Y1grM1FRSUUydHU5d0pLcjR5OXRjRStHWlRpMUZjT1B4Tk5PODhacERqTnVt?=
 =?utf-8?B?aHU2ZVZqUGc2bWFKOUMyY1VLN0hYYi9sTkdSNmVQQ09jb0owNzlwc3FrQ2N5?=
 =?utf-8?B?ZS8zKzRab1l2U0ZoVm02SDZNZ3U5Qm0yTzBoVng4Y0Jndm1vWGNhUEdvQzVj?=
 =?utf-8?B?UE84aDFnNjh2UmNOQUlUUTZUVkkycDlNK3g1ZmNOUFBvNHZyd3ZBc1lXbmxu?=
 =?utf-8?B?TGc2RnV4eDJDRlF3d2pjWTN4RGdTNGQ4dE1XK0ZacC9DbnU0NlVXNTgrNjBN?=
 =?utf-8?B?cFdWMXhBcWlsZGtoSXVudEs0Mm4vRjNaaG9sbVlEUWNUMkJjUDdwRVJwMWYr?=
 =?utf-8?B?QmhvencvakQ3MnIrSXhrSExxYW5rNzArOGppc0JGZ0crRGdYNzRta2NwbTFT?=
 =?utf-8?B?Wi9SQ1c2a3g2STFpVUNuak9RL2l4eks3Mk16K1JUYnVFVkZTRTVxNXluNEt6?=
 =?utf-8?B?Mll6aEZ2R2t6K1JYb1N6L05kMmdsTGZTVW42SjljZW5VR2w4QUlsYVViZU5S?=
 =?utf-8?B?Vm9oVEFsb1JjenJmL2lTUGVhRWcxdGxHU0NxWEs5dGRPL0JYZHFqbnpET2U5?=
 =?utf-8?B?UGRSQjRwa2xsYXFRVC9QdS9Qc2tHeGJVUnZ0TTlCKzIvUGZFQU9ySkhRTXI5?=
 =?utf-8?B?UEE2Ymg4c2RoSXpKaWgyVFBsejI0MVl6VWx1VXllUXlMYUNhb2twWUpnSDE5?=
 =?utf-8?B?cWpIUEd5TEs0MkJUaU0yaVFLQVU1TWtuRWhpd0xFVzVvZmV3SVNlQTI5MTlr?=
 =?utf-8?B?MUIxcjczaVptWWpaZW1CcHk2OHFSakZuR2ZQRStiSUFCdW95Y0h2ZmM1OElE?=
 =?utf-8?B?K0YzNVkrczgwV0xWV0t6T1YvU21ESDBKTVBSQlBpMGdhMzl6OHI3eWZGRUpB?=
 =?utf-8?B?V3kvOGw4Smc3RWVjSEczamtjM1pJVmZCOGl3c3RvZVhlYnJLb1BtZDJ1ZFdU?=
 =?utf-8?B?M1NyWlRIOTlraTlvN3pwMWx1OWd6VGJZb3FSS3Zzc0RPbGNMOThiY2hOVWR0?=
 =?utf-8?B?YTM4eGdWUUtWL0xmUTNkclFDcHMyY3N4cUw3VzVIT0wwUHl0TWhwUi9tM1pR?=
 =?utf-8?B?MS9OQStmWWdlRnlET2dub0NRNUJvbXVNL091cUN5blozMDRJKzM3ZzkwZkIw?=
 =?utf-8?B?VG1WTlFOYmxzNEpFbE9YQVh0RFhIdzhPMDErSjZKNGo4YlFwWjFHT2VoN1Fn?=
 =?utf-8?B?eU5Kd0N2OXdVSkJtMG1tOGN4QTc0YzBxOXM5c3dSV2FLcEgvbEpXdmVnZWti?=
 =?utf-8?B?RlUwMDVPWUU3UUNBWkdTc0lvbXdQN1dxOENoU2ZBNXlFVmRVcE02bnRRMnlS?=
 =?utf-8?B?UXFEYzlGcmV6NnFSeWNmQ1lGRUVoK2VJaHgrZVJVd00vVUgyb3AwU2p5c25l?=
 =?utf-8?B?S0NMdmFSdEN4YWdjcXRTVUx3YjhTb0ljSGphc1RCejFvbHVGckJabmdRQ3R0?=
 =?utf-8?B?dTJaODM3blJSdFcrcHdlMzBSNjBBRmFsREg2cnMvb2J6c1QyQlBiVVlYMzJP?=
 =?utf-8?B?Q21Zd0lDSDJkU2ZmS2xhQ3h5QWhISjJEc2EwRWw2aitFbkNzTTVpL242R01r?=
 =?utf-8?B?M0FaOE5EbkN6RUV3MUgxMEo4RmhUdTV1c3QxMlFSR0tHRUFITHhab2wwNnU0?=
 =?utf-8?B?UWZ2RWwxSkFhS2xUR0xCa3hRbXk4QkVqeldyWW4xZi9udkw3VHViOFZtbVhT?=
 =?utf-8?B?VGhpODk5WlFELys3bktZaC9maHVwS1NHZWZtZTZteCtNb0ViNmFzR1BLTlIw?=
 =?utf-8?B?SWZ5aURmY2N3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RGg5VW1qcGdUVldUVjc1K2lCQlhDTTJ4cDN3SHRidGI1dnNrR3AyMHFxWVZJ?=
 =?utf-8?B?RU5SZWkySnN4eEp1NVBVR1o5K2toeWQvYm1PekRsWkVja1UxRXFNdzkzRHgr?=
 =?utf-8?B?L1E3RmlmdWhDY0tGMEZZRUZZMHR0RnlCNHlpbHFyb2twS1JCSUFua3B1S1Ez?=
 =?utf-8?B?bWxndStzTE1YNUNkaUJqbHU5N0FGelVxLzk5czJFc0piTlhnSE8rdm1KV2RF?=
 =?utf-8?B?c1MreVhRdFlqeVFuTnpST056ZWFoVnlhWktqczYzLy8rVU44UFJWSFI1Q1c3?=
 =?utf-8?B?ejQyVDB6bXEwMTJEUklRRGdWN1BFMHZVN3YyYy95VTJubHdIYXJoRUtOUEFN?=
 =?utf-8?B?SVVLNk1HSWVlVVF4TU5NaFo3Y0EwM0k4TG02azVrUHFRempoRnp5S0RRQlJt?=
 =?utf-8?B?NlhtMElMNnMvUm5ZaXQ0TUlHbm5LcVl4ZnFXYis1WUsySk41azF6eU1wS0dM?=
 =?utf-8?B?T0NBN2JDRWdJMmlGZkg2ZDk3eGI4SUVLY3FjKzEvSVc3cGxrcEhHeWd4U3Vn?=
 =?utf-8?B?NjNqZGFwNXFtNzFjdjhUcnhWRGE2V0VjNlE5ZzRXNEFzeTVpRDdhcytDWmlU?=
 =?utf-8?B?TDVhUmxOMi9sbDczRUZFYWhIQmxXK0lYRlRuSTVYbmh3dkpQaHdlRVBUSzZh?=
 =?utf-8?B?Nm9EdHZ0dVRERVpQMG5iMkpVdlZiS0Nwc1dmVzhjOThhMmdqYkk1MDI3Rnly?=
 =?utf-8?B?cXJ2RUd5ZXdWRXpDakRsd255U0c4K25pdmN5dzhhb0xjWTR6Q1BYQjRhbjFw?=
 =?utf-8?B?QWVsR2doYTFid2xRWUVQMFdKSTVWSmJ4VjRxQXVGZkx6OG9MWnV0NG1DSW0r?=
 =?utf-8?B?OVlndGhUU0V3SHFWcGtRdXBsdXF0V09hM3kzMU4xemt1QkZPWTU3RTl6ODM4?=
 =?utf-8?B?MEVYT2ZaVHFMWHl3SHZYRmplQTZEdEl4TEo4MFpaZ24zUkpXbWI3d3pVTStr?=
 =?utf-8?B?TE9UT3U4QnBSL1F3YTNZckhlU0tWZk1kVlBXNTRwTHBFcEJ1YlZHS0hyME16?=
 =?utf-8?B?K2Q4UjdWNXFrM1FpWHNpOUp6Y2VKZmtjdmx2eUdLYXUxNldHWC82STc3RXdl?=
 =?utf-8?B?alpGSnhWVlU2QS9nWlBVRXNuOVRib05ENHZvMFFOS1RyR1NxUWo2bm9ZcTRq?=
 =?utf-8?B?V3RJOHEvZ1g5OVVBZFZyMzI0TG1EcDdLVVp2Mm9Yc2wwWlI3NkVuSm5LbUha?=
 =?utf-8?B?TWpjdFArdUtrUGNoWlI1aWZaRUNnZE0ySEJOQnBmemljcDVDdmUybzdZZDZG?=
 =?utf-8?B?NldxeFZ2SExGVGQrZjdjMTN4NmxoZ0RickVpSTFiZmtyRExEekxuY1pVNWp5?=
 =?utf-8?B?NEZ6RXl1bFhBWFg4S3BwRm90UWc5cEI3WEV6QWxldmhUd2ZZZmN1S3o0ZFh4?=
 =?utf-8?B?WTNvVisxS2ZySUhrT2hqckQrY2c5NFIwRmFLVk9JdWR6eGVJcVFtWEVrNGhR?=
 =?utf-8?B?bHk5M1JMalRPRmFkWnpGUW5pWlNtcmc0cCtHUWp5bFlGWXVQdUZKcEg2dnF3?=
 =?utf-8?B?c1p2NHVneTR3UmhCeHhUcC9lUjl3QUZFdTltZmZJek1ibFhxOEhwLzNpYndP?=
 =?utf-8?B?d0dDbTh2UFJzV2RITmFUaDdsZG5heEJFQ2I3UTc5YlZoUkMxQUw5Rlhya1Vt?=
 =?utf-8?B?eVMvdmQ4UTlMQU1hTnU4eG9HOFRDaC84Tmt4ZVNUZStKQ1hXYUdoOSs4Rksz?=
 =?utf-8?B?N0hxTUZqSTlXMHcrbXFGUllGMEN5QmF1cktUODJvMHBSdWpNeGg0TlZRREU4?=
 =?utf-8?B?QXdNRWtaZWJwT0RwbTdpSWw4eGE3VktwZmd0RTgzOHdTSUYxamcvVmhQRzZ4?=
 =?utf-8?B?bmZsL0o2Z0ZRakJvK294UDd1UTBkTGpwTU0weTVLbFhUT1VZZVllSi9ZdlJa?=
 =?utf-8?B?L2RINFFneHVNd2pqZ2t3Vk1EM1BoYXR0d09yclVLK2tLbXJTejZQdlJYZGx5?=
 =?utf-8?B?dDhkaVVhTnFZcDlvTWtTNXJ2V1I3N1J3ODRRbUlyUTJSekRhY0tTK1BPRjZD?=
 =?utf-8?B?a0ZHUkUySTVEeDZzYzRQWGtVdzExcG9kNGJKYmR6L3RzOFVON3BzaGYzak8r?=
 =?utf-8?B?QytlKzloaGoxSG5XMTYrK1JYRXZOczJmUW5kZkJvN0dSSUpFWUphWUYvQ1Zz?=
 =?utf-8?B?Y0FHcWpMOTVvMUR0eE9aVVNxcVBmVlh4RlpQYlVTKzVHRHN4S0RPblQzcS9G?=
 =?utf-8?Q?nHk3r/Rrm52aV9CpxCZPV4M=3D?=
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a9067f0-15d0-4888-1837-08de3c10533f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2025 19:29:54.6775
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zGb9HZe6Xy2RaTqMDq4AALld1lxQ1zjmWNLhbknKECfFE+xctzoDIrqcASjiHzFd5GaiImkRzdCCU9pWVko2Ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR15MB4819
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEzMDAyMyBTYWx0ZWRfX7YVgHVXtY6y6
 n9RYN5tePgwLzoXBzLjG8bTOHlA3RKaKNhlUQoQ5G+eokJ1HK2HPB5Y3DGzFWaDmh2oBgAqzDMw
 +GSWMaYoiLsuCpKv+dqQEVjEQQ5HN9fAATgwO1QmZzzCv7XkP/wb3u6H8En9NnoBiS8HfA4Qo6B
 4COGKpjMJQ0DC/S418vum1XhTwHzBHP3cRHUO8eLvQV1/3jBjLSHNiQ4EagyvZOA/wFXZ5ZZbfm
 CkmvS4g2KLmn0M7F5IwI3Yboy85AFquyehr+l1KlL3/KJwApf8qtDXYPVwlRQz8J2qMg7EFTqEE
 S2teUhsn8EApClVNarqO0u6wRXRY6NOCYj0Rg31hh6Vx21/0X4QRX+uGNOhpeeM459iqXGouwpY
 emspcAR0pNNeFQG6jjJj54qqdIrTIQ==
X-Proofpoint-ORIG-GUID: GDJpLUrSUY7fDV4JdCryluNfG-oVSilA
X-Authority-Analysis: v=2.4 cv=QtRTHFyd c=1 sm=1 tr=0 ts=694061b6 cx=c_pps
 a=N7UEZcGu6nKKiVkixTDHSg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=edf1wS77AAAA:8 a=szKgq9aCAAAA:8
 a=As_SrxrcICVb7s3P-v4A:9 a=QEXdDO2ut3YA:10 a=DcSpbTIhAlouE1Uv7lRv:22
 a=R_ZFHMB_yizOUweVQPrY:22
X-Proofpoint-GUID: D9qXt0su8ekp-RzBVfrdlfMh3ES0ALbJ
Content-Type: text/plain; charset="utf-8"
Content-ID: <362F213B5EA3F243BA871775491B0E79@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re:  [PATCH] hfsplus: fix missing hfs_bnode_get() in
 hfs_bnode_create()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-15_04,2025-12-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 clxscore=1011 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=2 engine=8.19.0-2510240000 definitions=main-2512130023

On Sun, 2025-12-14 at 05:02 +0530, Shardul Bankar wrote:
> When hfs_bnode_create() finds an existing node in the hash table, it
> returns the node without incrementing its reference count. This causes
> the reference count to become inconsistent, leading to a kernel panic
> when hfs_bnode_put() is later called with refcnt=3D0:
>=20
>     BUG_ON(!atomic_read(&node->refcnt))
>=20
> This occurs because hfs_bmap_alloc() calls hfs_bnode_create() expecting
> to receive a node with a proper reference count, but if the node is
> already in the hash table, it is returned without the required refcnt
> increment.
>=20
> Fix this by calling hfs_bnode_get() when returning an existing node,
> ensuring the reference count is properly incremented. This follows the
> same pattern as the fix in __hfs_bnode_create() (commit 152af1142878
>  ("hfsplus: fix missing hfs_bnode_get() in __hfs_bnode_create")).
>=20
> Note: While finding an existing node in hfs_bnode_create() is unexpected
> (indicated by the pr_crit warning), we still need proper refcnt management
> to prevent crashes. The warning will still fire to alert about the
> underlying issue (e.g., bitmap corruption or logic error causing an
> existing node to be requested for allocation).
>=20
> Link: https://syzkaller.appspot.com/bug?extid=3D1c8ff72d0cd8a50dfeaa =20
> Fixes: 634725a92938 ("[PATCH] hfs: cleanup HFS+ prints")
> Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
> ---
>  fs/hfsplus/bnode.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/fs/hfsplus/bnode.c b/fs/hfsplus/bnode.c
> index 191661af9677..e098e05add43 100644
> --- a/fs/hfsplus/bnode.c
> +++ b/fs/hfsplus/bnode.c
> @@ -629,6 +629,7 @@ struct hfs_bnode *hfs_bnode_create(struct hfs_btree *=
tree, u32 num)
>  	if (node) {
>  		pr_crit("new node %u already hashed?\n", num);
>  		WARN_ON(1);
> +		hfs_bnode_get(node);

Frankly speaking, I don't see the fix here. You are trying to hide the issu=
e but
not fix it. This is situation of the wrong call because we sharing error me=
ssage
and call WARN_ON() here. And the critical question here: why do we call
hfs_bnode_create() for already created node? Is it issue of tree->node_hash=
? Or
something wrong with logic that calls the hfs_bnode_create()? You don't sug=
gest
answer to this question(s). I've tried to debug likewise issue two months a=
go
and I don't know the answer yet. So, you need to dive deeper in the issue o=
r,
please, convince that I am wrong here. Currently, your commit message doesn=
't
convince me at all.

Thanks,
Slava.

>  		return node;
>  	}
>  	node =3D __hfs_bnode_create(tree, num);

