Return-Path: <linux-fsdevel+bounces-41756-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AAACA36721
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 21:54:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1986170D6B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 20:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE1E1C8637;
	Fri, 14 Feb 2025 20:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NxIgU87U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09B41C8611;
	Fri, 14 Feb 2025 20:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739566456; cv=fail; b=eBZ7lpHyXnBCAM9lylmni/C9D0aheNcmkZ3D5/iTM7bLpGcrxl5JkZRdXw5ccaHkCndL0L2yMBzfa3J0jIhhR9FUKneM5ngEIFCpch5ce/INHw8Yb/3eyqwNIJRapTJRBZ8mWRpcaTgi+YwvV4M3EVgnlIEZU/GVOse5dGLPQWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739566456; c=relaxed/simple;
	bh=2QhbxHTAAWP7h1GmZSPZK+iaximvTF/cWT8/g2M4Bb0=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=R+vULVdXnBkbIQvLKGPkA817Md10czpAcEf8B1XKekrnyWxBv/d3pNnEsJciNGKrMgIjh/smIJgQCDsLhjEX1U4LOZxHc7PR3NDJfaijTkOWddDkFzl4VFH++lCXkBsigYmraQw9PBAVTIYW706lF+OSUCUO35DNFYZ66AQR3dA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NxIgU87U; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51EHRhHB026031;
	Fri, 14 Feb 2025 20:54:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=2QhbxHTAAWP7h1GmZSPZK+iaximvTF/cWT8/g2M4Bb0=; b=NxIgU87U
	XHylzmhD7ycryGDgMir+Oq5Euylt9FXowUqgTvQwAf5P44VLCTr/FtTyzpH9/pDr
	Ake5Tzgd/mrRMydE/p8pPEBbrC6dXcr6RE2hd9r2iXHA5S1kXj0fGUAqIz3RzKYt
	ODR5FtGlqZNf9+QInA+iBK+LunoZJkJ6ce7aW0fE4ykHQ0AWQXN02LCRFFCEhSNt
	gNVNYMuL9DXDc4QO89wX0Rrio6yd5E3fKgACJPJWsfTH93/NnChXddyC8zQeKDhp
	RW33PKp9yVKJfxUZx2KzMsJCtPeA/pf1Wmgmqx7KWBw+JPze7lR85YH3NMEZ59hK
	edd7gctNlugLjg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44t1hpupyw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Feb 2025 20:54:09 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51EKs8dX019903;
	Fri, 14 Feb 2025 20:54:08 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2043.outbound.protection.outlook.com [104.47.73.43])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44t1hpupyt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Feb 2025 20:54:08 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uUPgxycVyEn2yUrsJuMpvPpoKUraXXT24sZhgsiozAuShF95wucMLSs0aLc/y7XjDzx4rV21HYtKMMjtrUIMCHeIkQvSAvHaSu5WrXgJnQ9KBfTcNrN/KHNXwQKbBVzE7mZeRVMjYRPh+ReqHsY4eId6IeiuYgtXoaoZr73EayeDEtElHpREQDtBGMl4vWWlLpWeMrpICnLAs0am++LqmYSLTAQLX6bO3XFwig5Qc0vZbqQ/lwRrn4BZcPLgbsr/Byx4G91RX9MXFbGw/c0bSVKvNgLkc51b3TcLOTwZfK7dB2iOSlz7U3v2axGcpS10GRGL/zHha78Iva2gfjf/SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2QhbxHTAAWP7h1GmZSPZK+iaximvTF/cWT8/g2M4Bb0=;
 b=ErWy/TJ0Xn7C++81IImV7n6S7UDD85WF/SV4z478Dp0xkqSjTkgHQM6h5/2p90akaJgqZpJbdbiriJnHKi0+pGg6NBZdrOot/vy5UqgsfaTX1Jd27Alyjk0KqyeP2cQURVQamwvJh0lQQn6LId6b+uSHF2goSY757dUBhkAw9tHWOdVyyBTJC2O3eRwJfOpPwM9GsgCEIwK9IO5VYt6bJBilEOWewmP5kQM8ZtL5wFjlBmq0026a83Vr1boJF9pAEeY6Sxn5xCqLRIw9iKwM6pDb+oXT3UMp4bFkRuQ2Yic4SttoVfxrIQA8F6e/7W8H1LVUGLW6kgiLxCRG6lr0kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by SA1PR15MB5078.namprd15.prod.outlook.com (2603:10b6:806:1dd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Fri, 14 Feb
 2025 20:54:06 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%4]) with mapi id 15.20.8445.016; Fri, 14 Feb 2025
 20:54:06 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "slava@dubeyko.com" <slava@dubeyko.com>,
        "willy@infradead.org"
	<willy@infradead.org>,
        David Howells <dhowells@redhat.com>
CC: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        Alex Markuze <amarkuze@redhat.com>
Thread-Topic: [EXTERNAL] Re: [PATCH v2] ceph: Fix kernel crash in generic/397
 test
Thread-Index: AQHbfx8tS4aQcLCAJEq+DDko9HXrvbNHRu0A
Date: Fri, 14 Feb 2025 20:54:06 +0000
Message-ID: <48e78434fe4366d08265960531164442d9da4906.camel@ibm.com>
References: <20250117035044.23309-1-slava@dubeyko.com>
	 <17775.1739564968@warthog.procyon.org.uk>
In-Reply-To: <17775.1739564968@warthog.procyon.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|SA1PR15MB5078:EE_
x-ms-office365-filtering-correlation-id: 47b0d6f7-d07d-4ead-cb5d-08dd4d39b8e8
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bngrNWF4b0pBOWNuV1VpbmowVFlZWVoyU01tWVFUUU5iMmRXYWlHQjI2RkxG?=
 =?utf-8?B?RzFkQ09SK0pXNXFpTHFFbnMvcWV4YmVESy9IUFY5YTd2eXcvU1haUElVZHQv?=
 =?utf-8?B?UVBTQnlnaUxzSzNhNEo1THgvN1FLeTAvVCtMaTlGK081WFNSeFlFSFlVbjlw?=
 =?utf-8?B?bU1FRTdabGt6V3hsbkhINTlmWEhVczRKQVFyNGlWWnd0N01WN1JUL0xMQVlZ?=
 =?utf-8?B?VXBVazI1YVh0SnBxRTcxakNvbEF2L1E5UkhwSWJLVEEwNmVCTGJ5OTR4cm9s?=
 =?utf-8?B?ZUp1RUszYnl0c2VvUlRtQUhqK1ZFTzdRdU1qaU13N1NPSzhHU3RHY0RkSi85?=
 =?utf-8?B?cG5BZUNZbEZ2YUw0VVlvNkN4L1dJa2NFYUFMaHVzblc4UlhnbmxMR3ljbWZB?=
 =?utf-8?B?bGR6Sy9WdE45ak81OWt5VGQ4aGNiVlhoUWlVRHd2Ymk0TXdpZ05kUTNJU1pE?=
 =?utf-8?B?bUMyR1VKNng5RnRMU0RDZUZhR0w3L3ByTEw4c1dRWHdtU3pTRXNvVnZRcm8z?=
 =?utf-8?B?dkd0OThwOTJVZXVsVDdodjVxZWpvVlpQcUdpVE5adVBIVXhFUGdxMEJuaEF3?=
 =?utf-8?B?SUp2MGxtUlBpMHJlaS9rRWFuYitGdFpjaW9kUmhRZHRuSy85WFpFOUFrMmVL?=
 =?utf-8?B?S0FzVDE3cVVQR05UVlU4cFlDbm1BRWxQTVB3YWo0WmJrYzRHYmRrcWF5ZVMr?=
 =?utf-8?B?YUdvTzVBdlQwNlRzOXFlTm94eExjQ1V5dUxkaDB3dmRWYVpkSFlZV0svalRI?=
 =?utf-8?B?MXllM0J6WGtqL2V1OWxBSG5IV0VTdEVrdzhiT1lXQ0JNcGErZHRnTDIvdk9q?=
 =?utf-8?B?bk50b2R3UGdNZ3h6MmFSZWJYOU1TOUdJYjlQVTN5bUcrRlQrQ2FLbFd2ZXcx?=
 =?utf-8?B?aUdVQ0IyMG9BaUtWeldSMmIxK2RFbEFKRzBsdlcvZnBRSWJEOU9tMDhEZG1Q?=
 =?utf-8?B?ZTM2My9lM3NXWW1tOWZ2WTBuZ1FoNWlTZTM2S2VMZ2svSFRkV1EvZXBOYXZ4?=
 =?utf-8?B?d3hKR2hNMEt3OHJuTjlOa0psTGo0dmloL09URDJOZUJpMUhha2pEQStWdW1C?=
 =?utf-8?B?R2VNQklEME0yM3MwdW1DblBuaHU0RU1KTGdyUHpkMTB4b0drNlU3ZlVDRCtX?=
 =?utf-8?B?TmNnOS9QbFhkUzZWNUlUYlQ4UC9GVUNzUzZTaXV2OFNzTGxKR2hPaExldVRj?=
 =?utf-8?B?aTZESHo5bkJaWTFVWG0wUklJT0NESEJIMzBWVkNVcGRiZE5DdWNXQzRyc3BP?=
 =?utf-8?B?Z3JuRjJtWWdlNkEyYWgzM1E3NE91dU1CYytUckZXTlRtUnJWMnViYkQxeGNU?=
 =?utf-8?B?Qld5TUcwU0pqTmhaUmVYbDU1MHRnVjEzZUs3N3BMUS9WQUZmUHZobjNhK2Z3?=
 =?utf-8?B?YWg5bmFDRGhkOVJUMzhjSGdDQWpLSVBuQkhVdDhBZXFpNzlwTThSMkgxMjNv?=
 =?utf-8?B?YVcrUlFDZDFKN2hPcjNrK28ycVVCWUFFWi9TWEZ0QjBKaTZXdTNFdE5ObCtB?=
 =?utf-8?B?M2xsc3pIbzRHTmRKS29Vb0RReEdxdG55eEwyUXIxcWg4Uy9XbGVmY25ZVFFH?=
 =?utf-8?B?UkZqS1dibWRWOXJOaCtPQVlmWXBBbHFObFNZc2NGZ2ZWTGkyb0ZrOEl1MjFB?=
 =?utf-8?B?SVlXQlVhc2IwQVZDN2FDay93d3NTWDM3UjUxWDM0WUVCcUFYU2IyQlBBMHFZ?=
 =?utf-8?B?TmErWitjMXgycTQ5UDkzaWRLYWNUZ1NPOEt1czVHaXFhRk9TRzlGajVTamhY?=
 =?utf-8?B?OWwyR2xBbWdITmJzUFFCS21sYnZtakFkRDd4aVNHMzdFQWdGdWpDODBLd1ps?=
 =?utf-8?B?ckl1YUgzVUpkL2NCQjd1TGFYTGkvT2NaMDFvOXJNbjNhNmM5c3N5YUxtaElF?=
 =?utf-8?B?VFR5VitoM3lOMjNoYnUweFJjTHViaUlQWG5JV0lCSjRYMWNtQnA5aWNjQ0Nj?=
 =?utf-8?Q?klo+QO2x+g9gzLFtur/wyeNIK7vRY19G?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z3J2emZqaUQ3aTdwY09ZRzFSdkQzd0hSSEViZ1N0N2oxQ0VtcEtkem1RNUxO?=
 =?utf-8?B?MHpWQkl2V3ZpSHY2aU5mbkRqbFgrODZzL3JIQzhTdUl1d0lsSUFYTTFYeTV1?=
 =?utf-8?B?c09ZSzBvQjZMWEdhOTR2Z3F6TkhXUXovYnFZVXY2MDFXVitEVWRjRnRpcE15?=
 =?utf-8?B?ZVppajlWbWdaRmliNFd5ZHpBNkp2ak5xS083SldNSzc5U0V0amdhQjd4eUxh?=
 =?utf-8?B?WGFOS21ST0ZMaGFZdVN6NlNLNFhNYjFhN0tzTkV6TVpUS3NFVEFwTXR1OHIx?=
 =?utf-8?B?UGp5c1NWMUZRQ2FhK0xtSHRZdHpmNnFZNEI0VmdFMmN3TCs2TWI2Rzk0Y2tW?=
 =?utf-8?B?VitDUDk4ZkNUUFFBMS9EMkk5REJWMUNhclRhWEtyNTJ2REhsWVdqQ1dDc3B1?=
 =?utf-8?B?YjhBdG9hQ0g1bDkvTlJpVmY4R21zS2dMaUtLcHdFeVdoWWV2c0NvVVlzbnFC?=
 =?utf-8?B?MkRwWFE4OEtOU1Vva2pFbDY3NmFZaG8vZ3FkT2QzR1JzeGNEUDRFWlpYZlAr?=
 =?utf-8?B?TytrZkU3MEpyUy9PeXMrUStPTUdsR2lRNFNQM2RweS80OGhVeXVNZ1NIVGIx?=
 =?utf-8?B?Znc4d0pMUnJhMlZJb3lTUTFhWW9Fb2xXTEYrNkIvU0R5TFhUWEdjbGlLWWhr?=
 =?utf-8?B?MEh0L2dTRVRHUmZPYkl0M2NWbVI4WFVicHpqRzExS0tIVnFUYkpBeUxNSEI1?=
 =?utf-8?B?dFVDZzRvSG1uSGRMMTUxUFhnTmRNOTRFUm04KzZmVFVJSXRLZnRUN1NwL0RF?=
 =?utf-8?B?NEozUVZzK0hUTkJ1RE1ZdlMrRSt4U1l4SHdWWTRpWXZxc2l0U3hhQmVreksv?=
 =?utf-8?B?bzhvcEgrQjBjZnpmRFZhNHhwZkdhNkxSUGJIRFlndVUycnV4SzJTZWZuN21Q?=
 =?utf-8?B?QUd2TEMyNUVpN0xWOVRMd3pmcythVGp2TVI4cnAzb1RrNkpDSmFBRXl6MGRH?=
 =?utf-8?B?aUdTT1FybUQwa1BSYzVoRUpUajA3RVRuTUtvVW1WSEIrdFdsa0E5bnJQSGYr?=
 =?utf-8?B?M1hHRHIvQ05PZm1FU3Y3TmFOTTZveS9Qbi9sSmI0WUNUdW9zRktnVmI1ZjlZ?=
 =?utf-8?B?c0d3emNLeWJDZWhDNjMwL0hNM2NXSEl4dkE1akNCYWxrZjVsM05DMU5qeHhQ?=
 =?utf-8?B?VU5LRGJVYmx3UUJUTGhlQ1A5MDg2OWhWaEVOVzgxeDRRUjIzNzIzMXBveUdi?=
 =?utf-8?B?R1pzUFVKK0dsanVPSEp5Uml1NjJxSzArcUNVb0RsdjFkN01SODY2MWFnYVBT?=
 =?utf-8?B?TmNXWjkvL1R2akpIZHpKY2g4YjZtenh0SVV6bVhwZ1YrRGRnd3pGam9yYXFD?=
 =?utf-8?B?ak0rK2tCM281TGt6MERoMFFqdzVZZU0zQXg3dy9UZTVqK1JvKzA0TCtadDF5?=
 =?utf-8?B?VlZMM2ZFYUlFY3VRY1Y2cnhYcUM5WWFkSVd6dmJ4bE13MWs2SDBpaTdibU9D?=
 =?utf-8?B?T3dmRkpyb094b1N2RFQrbVJFVnZOamxreWx2WjZBVGhEaHFCaWFLZ3RvWlZD?=
 =?utf-8?B?ZFdYZFUxNDJyaTltMThIVXdaWVE2Q2Y3UVdNRjNYWHJPNU5BT3BiUTRUa1hh?=
 =?utf-8?B?RTNpY2hSREVKUm1KRGRHVkFoT29lMWdBUmRvSnZQQzV4Ymxnck5uSkNkWkdQ?=
 =?utf-8?B?UnJwcEFzeU5MYmtkcUtZTlJVUUp4Z2FqS2hKc0pYaWtIV293dEd5TUhiakV6?=
 =?utf-8?B?N0FVcWV4N0ZGMDBXS296QXJTSWMyY2xFM2tDTjVzMmdaV0NQL1A5a1hOcm1t?=
 =?utf-8?B?QXBjTTQwL3J0enlQSzltakFSb1RnZWltejBBQUx2aHVmM3hQUktUREs5Z3hU?=
 =?utf-8?B?ZDJwWkpISTZuRHJHbjcxK2JzdnlBQXhqcEpoMGpyeVRhcG1YTFNWMDdGRjhl?=
 =?utf-8?B?NnVTanQ2OVJaRWNHRlVlQXpxa1R3TUdPK3RRZ1AzS2RpaFE1SWtBL0xibFNM?=
 =?utf-8?B?RnBLTGI4L1YyM3R3SWZ5YVFpSGd5Q2hSUktkMzQzNVU5QjVicTZXQTJxbEtm?=
 =?utf-8?B?d3NUbFBHTGdiVnF2TDJMK24vcnU5TUtyZUNpS2VJQUgxbzEwWjlLYUUxV2ht?=
 =?utf-8?B?UXEramc1NTJaaHQ4MzVYL2ZBem5Fdm5yVzRabU5FRUxCYVplUzU3U0djSjFm?=
 =?utf-8?B?MnQwdnRrQmJILzB2Ynp1azBiNk96K0IxSzNtVzdhUWN1Qk9mWWFPTW1LWG1F?=
 =?utf-8?Q?qHuWE5PDsSyOViIoG649/M0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F55187E3138A8B45AF02C23C6ACC4448@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 47b0d6f7-d07d-4ead-cb5d-08dd4d39b8e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2025 20:54:06.7000
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5hewiG8CDY1Y6eNUd8uRCp0OqkwGVh76WU6GPBl1pvJraXP/AQ65QD/M5uGC5D0EToZhsPzlTrx2ppDSSXRuNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB5078
X-Proofpoint-ORIG-GUID: LlXduOVuWdWujEGrd2CAlYyCkeVUgFEG
X-Proofpoint-GUID: ZiBEWPvOSCuBNNmgmPwBZ0iQY5aLr9yv
Subject: RE: [PATCH v2] ceph: Fix kernel crash in generic/397 test
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-14_08,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502140140

T24gRnJpLCAyMDI1LTAyLTE0IGF0IDIwOjI5ICswMDAwLCBEYXZpZCBIb3dlbGxzIHdyb3RlOg0K
PiBBcmUgdGhlc2UgcGF0Y2hlcyBvbiBhIGdpdCBicmFuY2ggc29tZXdoZXJlPyAgVGhlIHBhdGNo
ZXMgSSBnb3QgZnJvbSBXaWxseSB0bw0KPiBkbyB0aGUgZm9saW8gY29udmVyc2lvbiBvZiBjZXBo
IGFyZSBnb2luZyB0byBuZWVkIGEgYml0IG9mIHVwZGF0aW5nIGFmdGVyDQo+IHRoZXNlIGZpeGVz
Lg0KPiANCg0KSSBoYXZlIGZvcmsgb2YgY2VwaCBjbGllbnQgd2l0aCBicmFuY2ggb24gZ2l0aHVi
Og0KaHR0cHM6Ly9naXRodWIuY29tL2R1YmV5a28vY2VwaC1jbGllbnQvdHJlZS94ZnN0ZXN0cy1l
bmNyeXB0LWJ1Zy1maXgtMDItMTQtMjAyNQ0KDQoNClRoYW5rcywNClNsYXZhLg0KDQo=

