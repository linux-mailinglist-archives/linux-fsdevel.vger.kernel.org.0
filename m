Return-Path: <linux-fsdevel+bounces-46639-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A4EA92627
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Apr 2025 20:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81514171C49
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Apr 2025 18:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E381DF756;
	Thu, 17 Apr 2025 18:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="f3H3m0RV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9402B152532;
	Thu, 17 Apr 2025 18:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744913436; cv=fail; b=n4D15lCCnh1jtY5Abx/kFpFdu34z2MX8/3jKGDYO/ZgZuTeQyqBxcNnHVwwa9yInq3ji3v84vcnE+ilU2BMFToQgphkDvJxD0KvSOi8mwaTg/kQy6npYXp1QfPhn5FZwsDpwCnhAuFIxo/btG8a7IRJD8+WrFydYMotmOH+euuA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744913436; c=relaxed/simple;
	bh=a22TTPFn1ax5dQbQmjMJKiAI0aZGdipNUh0BolFmxls=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=Kp/ZVQpyEiXMAk5p6/g9w1Fcjz5QrIQxYNbjtwhwDNwzYioZCcJNMnuoITAUQqassun35vkyB0fudKDKMV34xafhE1srpQgQomQdRv9a50PCafttNNcyiY4WltuEBbpeKmo5H2Tm6/2YH/lo/iw4SbAUjv/rgVVVJsHOsW5Nmv4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=f3H3m0RV; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53H9j6u6017998;
	Thu, 17 Apr 2025 18:10:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=a22TTPFn1ax5dQbQmjMJKiAI0aZGdipNUh0BolFmxls=; b=f3H3m0RV
	mr5sjMbSM88oMq5jBvXbhVeBZfoI8xgt3JVx/Rz87DddtCrgfNmd8Zw1OkxloD+I
	e7sV5M5MxX8bPkzBrsrUafHVmXPN6KcUkE8/C4G3UEAO6fIgwLyTfMYqyfdvbQuM
	O+uOl4or9juBSWCR9NNz+uTYOdonogz8HD3tcjTrUStQSdWzpc8P8PVsJARARdFO
	yC38rJAinT+BG1gh1vOWxzZxx+u79gNferoSK4xihelr7f7ORzYXXOGblyqCy5Xc
	N533AwUW4xMcyEnlrNOaEs0Iy7Ueed1Frf4FWvd5fovwHIyIVMMfyMzQmCItX6tY
	BNG5MH5LR3ZmDw==
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2042.outbound.protection.outlook.com [104.47.55.42])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 462mhu5a19-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Apr 2025 18:10:12 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q5zs8fohYRF9GdU73K2a0pXmlyHHsOysc3qXaUozM10UttmiWxOtV4U9F/P2ooGTb1eVI3bvhtijFgWjL6YnkVzX/j6RBLBsZTDOIIv0NOSZDo36d8ehcieODxWbklto1HIuuSx+SEKnqDYxMGjP2Qh1VReotJeIUY4bQILiZZJK1T3KzsNi5NmPOBfMn1TUF4FBpXjSV7p5IhhNI6uNXsJ4jsyutQIaInNMigygs5bUdLJ3iwoPDckUZnHq/vIssDkVPBseFqrOLrx66J1BCkziLTaYpu6cGnvc+KQSejMyjO0P7m+uvM4szjerpnCUV18YQ+a13ICMekSu2OIFmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a22TTPFn1ax5dQbQmjMJKiAI0aZGdipNUh0BolFmxls=;
 b=SwjFdQBQ6YLEyWvgAT/pGj05Qu16nI0gnY44A9NwmDPCbNwVsgUCIhRhKIfp699s4uvPPp4sTnVkP5tPjYr/346VmV3y1oeanQYwwTuyCqnwzVnu4OlzAcOkY9sRFKckKjcmsF3EQb0szsmk68hL/D8MuZwsYt3ie7q8R8t2tUXSE3Z/TfQPZBRHZew/Ze1TjlYkDFq0ZLLUkxofXa9VRnNpZn/75DHRdiNTivn2ByQ49MrAyy6pkqqLgBHL3L5d7nRmw6FItso/ggg/aHHhaGSeYcCVwKj+RI/txpEoKE8eCbzr2pK7luas00dcAdRQt9Ztw05wyZPsuCxj+3Os9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by BY3PR15MB5027.namprd15.prod.outlook.com (2603:10b6:a03:3ca::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.27; Thu, 17 Apr
 2025 18:10:10 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%3]) with mapi id 15.20.8632.030; Thu, 17 Apr 2025
 18:10:10 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "brauner@kernel.org"
	<brauner@kernel.org>
CC: "jack@suse.com" <jack@suse.com>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "dsterba@suse.cz" <dsterba@suse.cz>,
        "sandeen@redhat.com" <sandeen@redhat.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "torvalds@linux-foundation.org"
	<torvalds@linux-foundation.org>,
        "viro@zeniv.linux.org.uk"
	<viro@zeniv.linux.org.uk>,
        "willy@infradead.org" <willy@infradead.org>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>
Thread-Topic: [EXTERNAL] Re: [PATCH] hfs{plus}: add deprecation warning
Thread-Index: AQHbrhWWXaRwwnXSdkukdsi2+kZKRrOl1QqAgACQ7wCAAC+YAIABBJgAgACRlIA=
Date: Thu, 17 Apr 2025 18:10:10 +0000
Message-ID: <6fcb2ee90de570908eebaf007a4584fc19f1c630.camel@ibm.com>
References: <20250415-orchester-robben-2be52e119ee4@brauner>
			 <20250415144907.GB25659@frogsfrogsfrogs>
			 <20250416-willen-wachhalten-55a798e41fd2@brauner>
			 <20250416150604.GB25700@frogsfrogsfrogs>
		 <4ecc225c641c0fee9725861670668352d305ad29.camel@ibm.com>
	 <0e27414d94d981d4eee45b09caf329fa66084cd3.camel@physik.fu-berlin.de>
In-Reply-To:
 <0e27414d94d981d4eee45b09caf329fa66084cd3.camel@physik.fu-berlin.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|BY3PR15MB5027:EE_
x-ms-office365-filtering-correlation-id: 6ae22ee9-3a07-4fd8-032e-08dd7ddb178a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NnJLRWNlUDJvWDRUVHhodENvNmdLTU5pYjNYbkxyb0dmYko0ZE5hbWU5bTgv?=
 =?utf-8?B?NHBRdnIxM2ZzaWQwTkFqaHB0cEVDMTFLc0M1eHlrNW5ZYnl0U0gzYThiNlZJ?=
 =?utf-8?B?MHlpNTRtZ2tiWk5KeXF3VWtyNGxZT1ZxT3NZaWJCVkMvcTlJWEJDSXhYMGFp?=
 =?utf-8?B?VU9Jdk9BQzh5MTdWR1VlRE1LTkZqdkRrSjJkdnVvdVhxaktMemo5eC9VaTcw?=
 =?utf-8?B?ZEY4RS8rOWN0TjVhYWZDRitmK0xRSkltMDdCbTdadU51YlJ6d3hxdCtDajNI?=
 =?utf-8?B?NkFhWDZyc0g0RFVkcldleDFhWTBXM0ZwM0FHSkt6RlZOaHYyRmhIcThMWlBv?=
 =?utf-8?B?YU5xV2xoZVgweitoemFDTzZOZ1c5Q0FsRDZkTzR2SVRpd0FlOXp3R2N2ekNY?=
 =?utf-8?B?bHF6MHJRMEJPVVE1a0dVNG9EUXZmV2p4NGxjWVV5aXFJWVZTTE51YS9KdzBM?=
 =?utf-8?B?NnJKaWNvYWFSNmdpeTlRcW1VQmVtc2thSjgxVk1HQndmSlJJWjJEc1BMUE9Q?=
 =?utf-8?B?WmFtOGhLenorQ0V1ZDliRWZyTlZUVmw2QzlJVkZRV2xuNGNhb21VUVBaWkFx?=
 =?utf-8?B?MW5YNW1YU0N2Q0pnTm5Wd2x2SDFHWU8wUzQyMFQ4akhSQS9yV3hPVk1SamlV?=
 =?utf-8?B?WWtxbGdCQ3NYYVd5TngzMG0zelJGMmJMMFNyTUNOSm9nc1ZTcDBiWTg4Yzhq?=
 =?utf-8?B?NzgzRE1ORjEzdVVkR1NwdW9QODJzd2ZKNldxdUltcDFoNFV0NW5OMmV3T3dU?=
 =?utf-8?B?RFZuQ0tqaENFMzAva0F1aXdTU25mbWdZallzRFdjWm9tN1ZwL0V2VnYxU2U3?=
 =?utf-8?B?SWpuU3V2L1l6b1QwVDRvZXRmVmJyUys4UWthekxacWJ2V1pkMXB5cXZLU2tz?=
 =?utf-8?B?ZGxUVmQva3U5VjZoVENBMHg4SmRRS1EwU2RQOUQ5ekZISy84Y2hPSDBmcWtm?=
 =?utf-8?B?a1NEenRhN3piYlJUbld1ZUtXb2R6Y1ZHOThZM3RTUmo0bU9JenFzRFRMOEtS?=
 =?utf-8?B?Z1dUR0hDblFBRFpNa3VrbUdNeXVnWDl6SlNQbkdmaUttMjk5TkFhKzczaERF?=
 =?utf-8?B?V0dVK05sK2t1bVBsVXBTTXpxOFpzMzNKbUpTRDVTbjl0TTArSnJ3S0RUV0dB?=
 =?utf-8?B?MGlrK1hiSFBUMmYrb1l6OVBreEhGTXNVZk92clRGMmk5Q01WZDVmQTM5dW1x?=
 =?utf-8?B?V1BWaHdwRWRiWVMrR1QrMnRYVktMeVdNN2pXZDVWc0NQZmp4aWdKbS83MGxa?=
 =?utf-8?B?Ulh0czNxRXlLOTlteURRUStEc0dTTmt6NWlOc1pDU0V4UFZWazk2a1BERll1?=
 =?utf-8?B?SEJRRWFXRDIxcHVBL3p2RjJzSUxpVnpEOG94VlJtcjNKVXIwNTMrZ3o2SWFl?=
 =?utf-8?B?a1dxUG9WSyt3TzI3dE9TSGtRcE9obVpDVnNma3RNaFBSejlxQWY4WlRjR2Nj?=
 =?utf-8?B?eUJianV2MzYxck1oRWxaV0xoSm1ZZTdreUJoYkhidEttWWhYTmtOTTZteEFL?=
 =?utf-8?B?Ymp6TElwWnBac0t4NkY3Q3BCa2lsdFErdHhNNkFzU3NSQWN6YVBjd0drWmtn?=
 =?utf-8?B?QVgrWldpVW0rbExBRTdCaTR6Nzg0cmVObFIrejZQWE15eWNyeEFhbWdXK1VF?=
 =?utf-8?B?VmFYcGszTDVGZnBMeXdQNU9JYUNMYUtla1FzdmlxR2NNVGZ4dHJBZFFJa3Jn?=
 =?utf-8?B?US9xaG15VnFRcTVIWlNYakpQTlhFajJ1TjNGTHBHdHhwalVjSWlaVE9SMVVZ?=
 =?utf-8?B?Z1lJaVhhSmNvOC85REIzSm9PV0xLZHFneUJIRUVVenQ4Y0NidGZzazdyRGc5?=
 =?utf-8?B?UmRNRlBzc3dMS0QxVkMvTHROaHVqcEg5Y0hrRnZJSUFxSEFkL0dXV21CSWlV?=
 =?utf-8?B?MEFFdU95a2NUMjc3K04zYm11SmxodGwveTR0QWNzQmhSTVV2K2tnSzJMaEpa?=
 =?utf-8?B?TVYvQUdTaDlXWkw3alJNbSt2N2lpNTB1RTJqMGlQaldmT1JvOWtudzV4ZDhq?=
 =?utf-8?B?bGRNSzNIV1lBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SGtDNkFpaWhjQWdGZjJMeHhhckZta2cvV0JmdCtCcHphRDN0ZDZtMWpQTXdx?=
 =?utf-8?B?WjFkYVFLTE41djdRODNSdzV5NUFLc1Z3b01jT1I3emJnWWhnV1ZlNUJiNU1a?=
 =?utf-8?B?SUNId1RmVzZvSXg5N3JVbDFNbXBIVXFLL25lOE5iR0xXeHJ1Z2R1dEE5ZWw5?=
 =?utf-8?B?THZ4KzAxaUxiYlV0bWZUQTdYUzZWRUhJV21WSG9Ua1pZdzhaS3JJa0FMeTBr?=
 =?utf-8?B?OTAzZnBCSXFRQnFsMWNnREhWQVdqcWF5SExWMGUzakc5clA3NkJKMmxhT0tn?=
 =?utf-8?B?ZEJhNTM2MlQ5eS9LOGxMZGo1MUJudG9IUHlVd2ZZRlFHRGxJelRSUGh2YmNR?=
 =?utf-8?B?am1jbU5VVytuL28wUlVxWmxHRFQzVlpuUkt0WlQrRFdDQTRXM2Z5WUZwdWpO?=
 =?utf-8?B?bVdzMTFYc1FVNHpvajNSTVF1RXBDcG9wMnZld1FOcWJ1RkFpMElRc1pRN0g5?=
 =?utf-8?B?ZXdKQno0WFJVZlQ5SWt3WXdkWWRucExGNUJHNTdpQUlqSHN0YzF3dGVuZW9R?=
 =?utf-8?B?MHRORGVndjhaTGdZQW9ZdFEzNklDREQvbEM3SjVGdmhseWdGT3o2NHhPMHFE?=
 =?utf-8?B?STVXYVcrTThsbzZGUVluWHh2cS9TaDJHYTlHdi9hK1U4RUNDdjl6VXRNVnEw?=
 =?utf-8?B?VWh0YWUybktWdUZRTi9UQ3VRbGJnQW9iWjZ6ZC94VWZ3MXpWNDBGMFRQNkJa?=
 =?utf-8?B?alkxbHhkYlJEUmx1ZVNyN1p2RWk2a2k0R21KbDFmSUNPM28ybGJaYTR4VEti?=
 =?utf-8?B?aXo0V1FsRm5jMFpFbWx2SHYvNGFRckYrT1lGVEdqcitFajZHQXJyTlNVRXJm?=
 =?utf-8?B?emFza0tIR0FFWnJxZEMvbW44eTN0bVNMU21vRE82d21ncXEzSllSN1pRTVUw?=
 =?utf-8?B?YXE2SG1qbTZSMjg0TStrZVkwVklWZWo0YlhkNDRpWURSbXZYdlVndG5rUmlp?=
 =?utf-8?B?dWM4RjMwakNaZ01DK1liZ2VaVkZsNUJiU05wKzF2SmxYcEJEOFgvMThya1dp?=
 =?utf-8?B?Z2E2RC9CQTJyamtxODA5OUg3d2tvZGhSZ2V1ZFNUMnhqRnFWZzJ0ZXRvVEJ6?=
 =?utf-8?B?OWxabWFBbC9JdWp3cnR2RXFEb2ZyR2xCcVoyRUxZejFxc2lMM1VWSnR5ZjRN?=
 =?utf-8?B?S1lRdml5WDQ2RXVURTlGM0U1SUI4UDJuZXpnbDdhZ3RLcFgwMWNKUFh3NjUy?=
 =?utf-8?B?VXpucEJaNWhEZWdJeHNZZDBDbjU1TWFscFFnc05Ud3Q2bDUydXl6dU9EWE1l?=
 =?utf-8?B?WGFTbTM5eDZHRjMxSGMvaGdzMGZ5T1Vvd0VMZDFTU1BHdk8vV0FXdjY2WDFU?=
 =?utf-8?B?NEtXVkZEM01sMG45TUtQNFJ1QkNPaUMwRzlhNlE5UkdkbTVILytYUStab052?=
 =?utf-8?B?a3prUlUwTWtzY09kRVBpWUNGbkQzNTA1c2d3c3hZOC9xK3Q0TXNVRllldzhD?=
 =?utf-8?B?WUszdWxPMUJhdmtFNjRXWkhTdkVZVDRHS0JlZ2lGVnVhM1pERTREclIrWHNB?=
 =?utf-8?B?WllYbGZlT0tDMVlxVi9kNkY1Z3NFcXhPQlBTaU1zMzdRQkN0TGpZUnNOWVhM?=
 =?utf-8?B?Mm00Zm5RaTVHOERwQ1VkOERkZ05PVXdPVjZPdER1cUZQc0R0RldHbGRQVnZT?=
 =?utf-8?B?dVFqeXorckxoNm4vMG1xakpNaVZENjUzdm9TdU1pZUJ3K2VVeGdhMmVRMVd5?=
 =?utf-8?B?N0RIcU1BbzBEVzBtZmIwc2ZFUG9lcFd0RWVpVWR1L3VzWmdkRWlndStTWmc4?=
 =?utf-8?B?cnZNeEhwN2pEWmkwZGVVQUhlTXhTVHFyRWRhMVZLMStVVUNmWTR6WFlRei9T?=
 =?utf-8?B?MkgrV3kzajduQ1JhOXlHSTdCRlVJOEcxOEl0ZUdDM2RUTFU2MzZsbXRoemFp?=
 =?utf-8?B?MUQvenN4SjZ3N090OFFmSFhjQTcraWlQUE0zMHdmVkE5WlNydnBPM3FzUWRo?=
 =?utf-8?B?dCtPb0d3dTd2eDhETU5YcVVDSXhMZ3pIM1lqR0RsR3NzUE1LbEJrNVEvRXcz?=
 =?utf-8?B?dmp1UHFvTm1GQ1doc0FlcnZmaFo5cUdmZkVITlkrQVFMb0NjNzZMSVZabVZK?=
 =?utf-8?B?cEdaQzU4d1QyWmtWN0R0WGhXUDhsY01vM2pJVy9WLzgyb0NteHhOdFFKWEJx?=
 =?utf-8?B?KzJKZHVIZDloVHAxVVhKeCtYNnNKaW9HMFM1UWJkY0VRaGVhalVWQUl5S1hp?=
 =?utf-8?B?d2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EE17E2AE32AB874FADB22D4679EE82B0@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ae22ee9-3a07-4fd8-032e-08dd7ddb178a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2025 18:10:10.2426
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AiLI+UR5y7S6+ufYOwcQgAc1mnJyIYS67Yhm7qnP85p9UcJsqpq0tUhUCmGCDm2gjIJgWMICi+4+srdpcmcRXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR15MB5027
X-Authority-Analysis: v=2.4 cv=Hvd2G1TS c=1 sm=1 tr=0 ts=68014404 cx=c_pps a=SXeWyiAXBtEG6vW+ku2Kqw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=XR8D0OoHHMoA:10 a=IxiatnJ6wO4qZr-joGMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: GwH1CrYVhzSxeDje5YrgNQYPtRchr3wZ
X-Proofpoint-GUID: GwH1CrYVhzSxeDje5YrgNQYPtRchr3wZ
Subject: RE: [PATCH] hfs{plus}: add deprecation warning
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_06,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 bulkscore=0 clxscore=1011 impostorscore=0 mlxscore=0
 phishscore=0 priorityscore=1501 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504170132

SGkgQWRyaWFuLA0KDQpPbiBUaHUsIDIwMjUtMDQtMTcgYXQgMTE6MjkgKzAyMDAsIEpvaG4gUGF1
bCBBZHJpYW4gR2xhdWJpdHogd3JvdGU6DQo+IEhlbGxvIFZpYWNoZXNsYXYsDQo+IA0KPiBPbiBX
ZWQsIDIwMjUtMDQtMTYgYXQgMTc6NTYgKzAwMDAsIFZpYWNoZXNsYXYgRHViZXlrbyB3cm90ZToN
Cj4gPiBJIGNvbnRyaWJ1dGVkIHRvIEhGUysgZmlsZSBzeXN0ZW0gZHJpdmVyIG1vcmUgdGhhbiAx
MCB5ZWFycyBhZ28uIEFuZCBJIHdhcw0KPiA+IGNvbXBsZXRlbHkgZGlzY291cmFnZWQgYmVjYXVz
ZSBub2JvZHkgbWFpbnRhaW5lZCB0aGUgSEZTKyBjb2RlIGJhc2UuIEJ1dCBJIHdvdWxkDQo+ID4g
cHJlZmVyIHRvIHNlZSB0aGUgSEZTKyBpbiBrZXJuZWwgdHJlZSBpbnN0ZWFkIG9mIGNvbXBsZXRl
IHJlbW92YWwuIEFzIGZhciBhcyBJDQo+ID4gY2FuIHNlZSwgd2UgYXJlIHN0aWxsIHJlY2Vpdmlu
ZyBzb21lIHBhdGNoZXMgZm9yIEhGUy9IRlMrIGNvZGUgYmFzZS4gTm93YWRheXMsIEkNCj4gPiBh
bSBtb3N0bHkgYnVzeSB3aXRoIENlcGhGUyBhbmQgU1NERlMgZmlsZSBzeXN0ZW1zLiBCdXQgaWYg
d2UgbmVlZCBtb3JlDQo+ID4gc3lzdGVtYXRpYyBhY3Rpdml0eSBvbiBIRlMvSEZTKywgdGhlbiBJ
IGNhbiBmaW5kIHNvbWUgdGltZSBmb3IgSEZTL0hGUysgdGVzdGluZywNCj4gPiBidWcgZml4LCBh
bmQgcGF0aGVzIHJldmlldy4gSSBhbSBub3Qgc3VyZSB0aGF0IEkgd291bGQgaGF2ZSBlbm91Z2gg
dGltZSBmb3IgSEZTKw0KPiA+IGFjdGl2ZSBkZXZlbG9wbWVudC4gQnV0IGlzIGl0IHJlYWxseSB0
aGF0IG5vYm9keSB3b3VsZCBsaWtlIHRvIGJlIHRoZSBtYWludGFpbmVyDQo+ID4gb2YgSEZTL0hG
Uys/IEhhdmUgd2UgYXNrZWQgdGhlIGNvbnRyaWJ1dG9ycyBhbmQgcmV2aWV3ZXJzIG9mIEhGUy9I
RlMrPw0KPiANCj4gSWYgeW91J3JlIHdpbGxpbmcgdG8gc3RlcCB1cCBhcyBhIG1haW50YWluZXIs
IEkgd291bGQgYmUgaGFwcHkgdG8gYXNzaXN0IHlvdSBieQ0KPiB0ZXN0aW5nIGFuZCByZXZpZXdp
bmcgcGF0Y2hlcy4gSSBoYXZlIFBvd2VyTWFjcyBhdmFpbGFibGUgZm9yIHRlc3RpbmcgYW5kIGl0
J3MNCj4gYWxzbyBwb3NzaWJsZSB0byBqdXN0IGluc3RhbGwgRGViaWFuJ3MgMzItYml0IGFuZCA2
NC1iaXQgUG93ZXJQQyBvbiBhbiBlbXVsYXRlZA0KPiBQb3dlck1hYyBvbiBRRU1VIHVzaW5nIHRo
ZSAibWFjOTkiIG1hY2hpbmUgdHlwZXMgdG8gdGVzdCBib290aW5nIGZyb20gYW4gSEZTL0hGUysN
Cj4gcGFydGl0aW9uIFsxXS4NCj4gDQo+IEkgYW0gRGViaWFuJ3MgcHJpbWFyeSBtYWludGFpbmVy
IG9mIHRoZXNlIFBvd2VyUEMgcG9ydHMgaW4gRGViaWFuIChub3QgdG8gYmUgY29uZnVzZWQNCj4g
d2l0aCB0aGUgbGl0dGxlLWVuZGlhbiBQb3dlclBDIHBvcnQpIGFuZCBJIGNhbiBhbHNvIGVhc2ls
eSBidWlsZCB2YXJpb3VzIHRlc3QgaW1hZ2VzDQo+IGlmIG5lZWRlZC4NCj4gDQo+IFBsZWFzZSBs
ZXQgbWUga25vdyBpZiB5b3UncmUgaW50ZXJlc3RlZCBpbiB3b3JraW5nIHRvZ2V0aGVyIG9uIHRo
ZSBIRlMvSEZTKyBkcml2ZXIuDQo+IA0KDQpTb3VuZHMgZ29vZCEgWWVzLCBJIGFtIGludGVyZXN0
ZWQgaW4gd29ya2luZyB0b2dldGhlciBvbiB0aGUgSEZTL0hGUysgZHJpdmVyLiA6KQ0KQW5kLCB5
ZXMsIEkgY2FuIGNvbnNpZGVyIHRvIGJlIHRoZSBtYWludGFpbmVyIG9mIEhGUy9IRlMrIGRyaXZl
ci4gV2UgY2FuDQptYWludGFpbiB0aGUgSEZTL0hGUysgZHJpdmVyIHRvZ2V0aGVyIGJlY2F1c2Ug
dHdvIG1haW50YWluZXJzIGFyZSBiZXR0ZXIgdGhhbg0Kb25lLiBFc3BlY2lhbGx5LCBpZiB0aGVy
ZSBpcyB0aGUgcHJhY3RpY2FsIG5lZWQgb2YgaGF2aW5nIEhGUy9IRlMrIGRyaXZlciBpbg0KTGlu
dXgga2VybmVsLg0KDQpUaGFua3MsDQpTbGF2YS4NCg0KDQo=

