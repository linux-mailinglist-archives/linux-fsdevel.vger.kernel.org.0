Return-Path: <linux-fsdevel+bounces-44395-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C299A68191
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 01:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74B7319C2A85
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 00:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F1161FCE;
	Wed, 19 Mar 2025 00:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GV8d5bBG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F64F18E25;
	Wed, 19 Mar 2025 00:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742344359; cv=fail; b=dSy5MZDH8KUHyxykVay6zC7g140v+bl3gYMOOHgohHfuyczS7TvmrlknHlTcDLwL/Z2ia/v5+pQSuVMLo9UGcCkbFSuNdxP6QO1c8byaODYlX5E2Ba3EtB6Dta8JkwM3zvd0Ysb0QoxunWzVYNJ+jjNeNlzaZL5N16eNKXGWyVE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742344359; c=relaxed/simple;
	bh=aGbXi0ZzYwhhml7Y4xILlPFZqB6G1CcQsnHHeW2V4LI=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=MoumS9/N1ERHAiUhgP4VrAo2hK53solyN4QmuS3I1fhRh4XK46FTWMXwcgpheqUyu04FAMAVJPvQUXI7SaC/bwheLOFUux3Sb0nNy8a7JCBn4SP8CJ0HhuAHI0icTMiZ8mg7ww9bmjpdbBRgMNnt3THVgct9m8YFcN5VUUxk1ZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GV8d5bBG; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52IKa7Xc014692;
	Wed, 19 Mar 2025 00:32:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=aGbXi0ZzYwhhml7Y4xILlPFZqB6G1CcQsnHHeW2V4LI=; b=GV8d5bBG
	a8X4MYFb1B2j9zgzVuqgYabRMDRwzD7S6nCkOjHqVw/f82NvJVdpzKMDqoWoIkcy
	0K9K94HFON+9pWVaqMW4JjfpCS0RwFo9hPR/AR060h5JWVXITRcvip0Tg3F7VWsF
	zY8jalR9xAbFUfEp5SNDoQWdufcbzDTVQ764BC1t3KM1Dgyoe95q8K/Ly4wrXw8Q
	53iHrjwsbHjUAY+jK52Ym6JpSHjRqlqMSOnn69w+j/pervJsxxYb1bPi03IJy5tr
	iBqOcqO0no4V4//MPb9fGzI6fnxZZUDIMxX2mZxbLQgj+9CigooVfPirTO1ql75e
	m0WihvLRshebZQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45fg0prqjb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Mar 2025 00:32:26 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52J0SKvr007569;
	Wed, 19 Mar 2025 00:32:26 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45fg0prqj9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Mar 2025 00:32:26 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kmU5TlmIDQceG2TzEgDfwJvAe+bmrNKXpU3wPaIxPlVFF/uGWJd9Pwk/ud0No6rUjAGmdVRWy6iIi+43g/iDPHDg7VGrQ03IHbNQsjPPNN3leXg2xKeXyeSDspdsbYPXd5mcaZwZQWx6UgB/I6zl1+/HAWMXxvLdFbsJURkYJE6986fRHgozyQ6K2uiqYK3c3dXuNkGSaYrIvDhBPGWKH3XAZNiC/Se2vZB5SdxQfdtr2sTdW22nn+8tTU0tEfgtEjswYeNY/GdL7zUONND+AEThgYMqAqghoGDhcPAHr6fl+en884ZRYFuIUS90f0spT5Xvu+HXkdWrSz0PJdLG4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aGbXi0ZzYwhhml7Y4xILlPFZqB6G1CcQsnHHeW2V4LI=;
 b=w/0w94M3vX3a7tKYykxERZ0FZCvedS+CHu+54Ahilv7TgSl1qmT2iHZTK+GT9xweExGyKNTYdWa/pK/JulAocJcp/VCsSC0jfBqukHylqtx55ZNAsAFqHLfTOYOrEV43HFnZGppuRLs9888s99T+1HjFJwCpkJbQYz8JJhc6cT8ddpDf1xgWE65tkO9rC7UtBvxzbwL5Uivl3k9X/JTkAx8jkTH04xkLx631YGvZJkdLrIcsB8oBX9XY8slsJnWLDez23+0d0+4Mgvhtg+yMSa8oQMcAszqE+oIk3iNItGSR2bx4EG1dt7HHlQx4jhfwQ5aNvbj1XG6sbY2qDGlfyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by SN7PR15MB5682.namprd15.prod.outlook.com (2603:10b6:806:349::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Wed, 19 Mar
 2025 00:32:24 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%7]) with mapi id 15.20.8534.031; Wed, 19 Mar 2025
 00:32:24 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: Alex Markuze <amarkuze@redhat.com>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>,
        David Howells <dhowells@redhat.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        "jlayton@kernel.org"
	<jlayton@kernel.org>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "ceph-devel@vger.kernel.org"
	<ceph-devel@vger.kernel.org>,
        "dongsheng.yang@easystack.cn"
	<dongsheng.yang@easystack.cn>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Thread-Topic: [EXTERNAL] [RFC PATCH 23/35] rbd: Use
 ceph_databuf_enc_start/stop()
Thread-Index: AQHblHGDcVNx2TbZ10W/hgZWxIgGGrN5o+CA
Date: Wed, 19 Mar 2025 00:32:24 +0000
Message-ID: <749dc130afd32accfd156b06f297585a56af47f3.camel@ibm.com>
References: <20250313233341.1675324-1-dhowells@redhat.com>
	 <20250313233341.1675324-24-dhowells@redhat.com>
In-Reply-To: <20250313233341.1675324-24-dhowells@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|SN7PR15MB5682:EE_
x-ms-office365-filtering-correlation-id: d6f2b7db-2335-4c08-15d2-08dd667d84c4
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SzM2RS9hSW5uTnphQ3JyS0Z1aHh2UXQ3eGcxVk1ROXk0WXFrRHVZREwwNFNX?=
 =?utf-8?B?czhkemo2Sm9qYXhINGxYV1grQ1RObWhRazkzd3BJS3BJclZycGZmaXcrcm5q?=
 =?utf-8?B?RWp5dnZzVGhjbXZwR3RIQXJWY1h1Q25QWGw1VGRVc1hTREt5MGJvcVhwMXhn?=
 =?utf-8?B?bDJKb05BWUxLRnlCMmlTbXU5UEk3OFNScTNlMDllYkVaSjRKckZxTElwS1Zr?=
 =?utf-8?B?eXlFSTB3NXc5c01VaFFabmNYRG1QSkdmQVJSY0d1N0JDTXpvcEtTaGYrSk9l?=
 =?utf-8?B?UzgrNlRRQ0g4cTFZbzg0djZLM05yK1QwRXl0MVYvdmZVVUdvRENHNFBQTEo5?=
 =?utf-8?B?WDRQRXVVWHhhSTZFZWtLbU9UUXkxeGZqV2tZZ0o1QnloZVhvWE1zazlOQW4x?=
 =?utf-8?B?MCtVVHk1ZVBiRjdVVmk5M1dseXhDRFppYXlneWQ5a1E0bUF1anBlZXl1TVlW?=
 =?utf-8?B?bXNLUkQwb3YwWlk1VkhRSzFzaStPa3JsTU4rQTZtczc3b1h3dlh3WUVORGJk?=
 =?utf-8?B?MnQ3L0x0bUFuNkIvOUM2OFJDRHNxdmxFZ21sdmRRL2dHUXhUdy9xRUxjcm56?=
 =?utf-8?B?NUxCNHhKeXpFWE93WVVyVjhGeittbkFsTUZXd2Q1UnZQN3VudU9UYjJUb1RN?=
 =?utf-8?B?dnJRT0luK3A1MWdLcDYrS2RCaC9qVXZGNHRLZXlKeG1sYnRoamFWbDhRU3Zp?=
 =?utf-8?B?SE1wbkFoWTRwejdVRzJ6TW1IT3BOQ2tyS0N2eFFaSUtGU2xCa0xhczdDbWVr?=
 =?utf-8?B?WmREeTRGSkJHWUNEQXNlTWJBcStpYmFLeXB1cy9FZUZwdjZDTWo3QSt2MlBM?=
 =?utf-8?B?VC9YQnEwQURCVmltS2FOSlMzVC9hV1RnVkVrTW9QdXFiekxseTVrQ2lxR3hC?=
 =?utf-8?B?TVJra2VlZnBGcVR0RHZVN3dJYVZGTVBkL0U1cmxXeENtT1JpYkV0azh1alJP?=
 =?utf-8?B?L29VV0lUdmZuOUdHTkIvcWdKOElIaEVtYUNFMHAvRHBKMHdBSUt5WnE2ckZX?=
 =?utf-8?B?NEUyeitHWFRTbXFLRCtmV2dMbi9WRDh3ZjE3Y2RhdzNVVFJaZTZJMmFja2Zm?=
 =?utf-8?B?T0J3bkpxNlZDRjlpTXpxb2cxcmppL3I5WnVBc1h4THBkSXhKM0VEaUY2UVR2?=
 =?utf-8?B?MUd0QSt3V1g0L3libU4weUJMdmg4MUdua1dpMVBQaUZJbVpoc2s2OHU4QnVS?=
 =?utf-8?B?LzF1Q3NYNS8zbFNsemtkV2ZhaEtVYWJOTWVTNVIreVZKWjJ0bDE4WW5oa2x4?=
 =?utf-8?B?S1h5azhIa0RrVVhCWHc3bFpTMnhFRC9pb2JENkMxdXNCZDBrRXRUM2xQNTBi?=
 =?utf-8?B?N3NkMGEzdHNSd2FXdm56dE0weDBmY2gydVN2Y1NVYmZHaElVSm4wWnhuK3hZ?=
 =?utf-8?B?ZmNKRnRJRWZxR3RmMkZiZUxpMVdUUHcyVHg2Wm9SdHl2WXQrRVpwUndxTFdh?=
 =?utf-8?B?RTdiNG8rRWo1U0dzUTJBcVY1L3VESkQrenJZZURWWXV6SDU5NjR2Q3NuakJJ?=
 =?utf-8?B?Mlc1MllBVUFxSzNTRS84NzFTR2xXZDBrUmFBVHlPNnd5ditUcUNwMlNianFF?=
 =?utf-8?B?dGZQT0ZDZDRzNWxaZXMzeHluQ3dCeXVQcmtTeE9xUU5MMEQzWER3OSs2dXJZ?=
 =?utf-8?B?cEx5WkJOSDdSREZ2WEorOW4rdEVyOVc2TTUyamZPR2VITllEdG1kaHExL01C?=
 =?utf-8?B?RmdPL3JnTFYvWGhJWmJTUWVQWGN3dnc1dHVWTkNtbHRZTEt6VWk1YVlZdXg1?=
 =?utf-8?B?K3Nra25UZkFYYmRDdVQrQkR6MVZEMThCd3NJNGdWYmtNVFBrcUZUcGZ2QkpG?=
 =?utf-8?B?aXYvUmtzUXcyM2Nsb3V2U2QwUGxycnl3N3ZFOW5RbXhDZ0hUeHJRTU9wSWFK?=
 =?utf-8?B?Q2FsWmo3byt2V0d0Yy9PNlNDZWh0enYxRnpGd1hFRXdxbzlqcmNyR2lBbm42?=
 =?utf-8?Q?DKmBCesbRoos9Qh3s7HHQntgr1emexWG?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WXlBYXZpbDZNM05GNXd3S044SlpvQTBNYkFOOWU3RDVDZ1lOSEhUSHpZUDF0?=
 =?utf-8?B?WjVPWk4vaDVRQWN0STZQOHV6VFJQcHFKUHNPaUNSaTJqU1dSaFFqa0Y3a2hM?=
 =?utf-8?B?V3JPNXVGV3N2TzhqWU1Ec25KYTduVTViRjBNZXZobzZYVXc0QzRLLzAwN1Bh?=
 =?utf-8?B?Z1ZTbEVFVi96dEEyZkxMTWUwRkROU2FzdHFoalFacnNjZjBFWkFRYjIyVnFB?=
 =?utf-8?B?c1RZb1lOelE1eGNkdEc1NjFXOU5sMHFTWUY4OG8wZ1crOThycGtQYk9jaTUr?=
 =?utf-8?B?ZTJmMSs4SHhTbG04M2pyTWhIajloQ05QajBJUzZyWDVZdzFwS05hNk5PK3N4?=
 =?utf-8?B?TklUcmN4bnVYd0RpMkM3QzEzMUlscHBnK0pSMUdicHdsRGVpTlVPQUVSOEpI?=
 =?utf-8?B?aFVFL1JZMkJDUVdyai8yQ3U0b3J0am50Uk54MXJUL2lSVmk0aXRuellHa2Yy?=
 =?utf-8?B?bVQ4VU9kZTlMVVdvMUpxVDJxakxlUndBVVc4dGZwaUhyZmNEby9iK0t6VFhJ?=
 =?utf-8?B?cG9JYURBc3hKZEJWMEs4ZE5OTGVZc3FCbUgyMmx0V2RVVVhoZWY5YWpTenpH?=
 =?utf-8?B?SXl5cVpQYVVMSUVJaTRrUTVsQWJNSU94aDF4OEthUGxFRmdDK3BFbUtrR0Fn?=
 =?utf-8?B?RWJFZW9hSlk2OG1QWGpLcXhiU1EvdFlpVVNnamZ0dEhRMXRNTnJ6UXN5WlJG?=
 =?utf-8?B?S0FUeExCMm82TTcwOWpsVEFyWkdGdG5KU2c0OFFDOGs1WDlXRkxJMXU5anZN?=
 =?utf-8?B?dG1KYTJqRDlYdGs4OGVlMnpIcTVIUlc1Ym9heC96dkZRYTJpc0NlZFJSNmFN?=
 =?utf-8?B?M2dDMlFiL0FXaWQ5Mm1jNStVZUxMTGdnT0RYSTRJc08xajdzNXRyR2FSLzYw?=
 =?utf-8?B?S1lrcHpoRFR5d2Y5cTYxN0FodEV1NnVkU2I4TkRqK3VxcFlCSXJmd2Jwc042?=
 =?utf-8?B?dENJcmZJWExIY0tWVWMwK1ZkN2RlcCt1aUtyaEZHcTlOalBVcDJVYlR2a2ov?=
 =?utf-8?B?NVhXSU9LQ0dWbHVKWlYreitkeXFDQVVXZHo1aGE1MWtLMUhCdGFFdS90Ny9R?=
 =?utf-8?B?M1Iwd29CTHpjMTdaelhKRS9qNG9mc0pnc29qQ0RLcHRHRXMzVVQ0SmV0cnpr?=
 =?utf-8?B?L3ZpMDBPVDNCWkREQmM4YzFSVGhRYVNSVkVXcGkyMXJHcGd1emFFdUU0M0xa?=
 =?utf-8?B?bU13WG5IaHl0aFdMR2lyTEpLdElMZTA3WGJIRllDQmhvNnluRjdId1pJSlhz?=
 =?utf-8?B?cm9VczQyc1AyQlNkeUJmUCs0SE9sUXA0STliUjI0aDIrSnFNU3BrOVl2dnov?=
 =?utf-8?B?L0ZtZmpvTlJIcmp6bEpCcDN0eVhKMVZhb282Vlozdm9WTzk0UEFnQUJSV2M1?=
 =?utf-8?B?RUJQb3Qzandtd0Zuelo0WFBTei83WDZkc2p3aXVkNC8vWGhBdjdZMzFza2dS?=
 =?utf-8?B?WjRjWFJDeEpVUVBWNzZYUERRNnpSNVpQT2F1M0lSeG1VLytFL21RZktFVytt?=
 =?utf-8?B?aW1MdEpRN0p0RFY5LzY0VElOUlFpb0NrYTUxVzJ5b21ydmhQUUszbXFTS1Jm?=
 =?utf-8?B?c09VVkZJV3lmekhSeForS053cjI1SkxYcEpHR2V3OEVnaWEzbE5FTjNtNURB?=
 =?utf-8?B?WStxWFFueU9CWGJsY1pxU2M2Sm02M0w0Wm5uUk1CdkRYZ3ZWNDBpWkZLdjhB?=
 =?utf-8?B?WkZVOWIyWlNpWTY2a0JMQStoWXc5U3Z2ZDFzK290cUpUNUJOeDljejlBMFQ1?=
 =?utf-8?B?bmd1S2E0NWtFeUd4WEF2Ykcrd2hNTnpkVGJpTlU3Rm10aXplLzFCUG5zckhI?=
 =?utf-8?B?azVpc2FZT21lZmhROEVaaXlSb2JCd0N4Yk5RZEovMUNRN3d3Vlo4YUR5RUlv?=
 =?utf-8?B?Y2MvYnBsZGFFZEt5VEJnWGk4RXUrYSttZ0kyYmxyYnJBRjhRQzlRNFJtVXNX?=
 =?utf-8?B?a1JabGhvVkcvRTNRSDJhdWRrelNxSzl1bjlCeGRQMjFTMnYyZ2RkdEVaQWFz?=
 =?utf-8?B?VHFzMzljR3RybWtYc1RiY1RpSFBQTU1mNGpyZld2L2tjQVltOS9JeTRjYnZy?=
 =?utf-8?B?NU5PQ1ZjVmd0UU9DREtJRS9FZDN1MTkvSlFmN2l5aHFkK3R4OFpPbE5hZ2dl?=
 =?utf-8?B?ZHBKRVNmaFdxSVJPVXdZM1I5cGdiUXcvWGs1b2JSUnpBbWdjSjZIRWMrRVZz?=
 =?utf-8?Q?axT7rEDSEwbnIBixYSHk4Zc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5345802E82F49340A2402DE9A38468D8@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d6f2b7db-2335-4c08-15d2-08dd667d84c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2025 00:32:24.0632
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OSw2VL8LiZ1aNRRfwt5G/KEOl/Y1UAgvGD/K4scN44ynnZGkM3adDRzmLJtI6AvZWPpZW3SIfQ87oU8OT/XDmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR15MB5682
X-Proofpoint-GUID: 4XJaBcVe7Qr2viRt8UkO9eTFm3pwiSSu
X-Proofpoint-ORIG-GUID: bsBjTwIt2WAW8BNLyKhgr_70-ArDirPt
Subject: Re:  [RFC PATCH 23/35] rbd: Use ceph_databuf_enc_start/stop()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_10,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 spamscore=0 adultscore=0 clxscore=1015
 impostorscore=0 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503190001

T24gVGh1LCAyMDI1LTAzLTEzIGF0IDIzOjMzICswMDAwLCBEYXZpZCBIb3dlbGxzIHdyb3RlOg0K
PiBNYWtlIHJiZCB1c2UgY2VwaF9kYXRhYnVmX2VuY19zdGFydCgpIGFuZCBjZXBoX2RhdGFidWZf
ZW5jX3N0b3AoKSB3aGVuDQo+IGZpbGxpbmcgb3V0IHRoZSByZXF1ZXN0IGRhdGEuICBBbHNvIHVz
ZSBjZXBoX2VuY29kZV8qKCkgcmF0aGVyIHRoYW4NCj4gY2VwaF9kYXRhYnVmX2VuY29kZV8qKCkg
YXMgdGhlIGxhdHRlciB3aWxsIGRvIGFuIGl0ZXJhdG9yIGNvcHkgdG8gZGVhbCB3aXRoDQo+IHBh
Z2UgY3Jvc3NpbmcgYW5kIG1pc2FsaWdubWVudCAodGhlIGxhdHRlciBiZWluZyBzb21ldGhpbmcg
dGhhdCB0aGUgQ1BVDQo+IHdpbGwgaGFuZGxlIG9uIHNvbWUgYXJjaGVzKS4NCj4gDQo+IFNpZ25l
ZC1vZmYtYnk6IERhdmlkIEhvd2VsbHMgPGRob3dlbGxzQHJlZGhhdC5jb20+DQo+IGNjOiBWaWFj
aGVzbGF2IER1YmV5a28gPHNsYXZhQGR1YmV5a28uY29tPg0KPiBjYzogQWxleCBNYXJrdXplIDxh
bWFya3V6ZUByZWRoYXQuY29tPg0KPiBjYzogSWx5YSBEcnlvbW92IDxpZHJ5b21vdkBnbWFpbC5j
b20+DQo+IGNjOiBjZXBoLWRldmVsQHZnZXIua2VybmVsLm9yZw0KPiBjYzogbGludXgtZnNkZXZl
bEB2Z2VyLmtlcm5lbC5vcmcNCj4gLS0tDQo+ICBkcml2ZXJzL2Jsb2NrL3JiZC5jIHwgNjQgKysr
KysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICAxIGZpbGUgY2hh
bmdlZCwgMzEgaW5zZXJ0aW9ucygrKSwgMzMgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ibG9jay9yYmQuYyBiL2RyaXZlcnMvYmxvY2svcmJkLmMNCj4gaW5kZXggYTI2
NzQwNzdlZGVhLi45NTZmYzRhOGYxZGEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvYmxvY2svcmJk
LmMNCj4gKysrIGIvZHJpdmVycy9ibG9jay9yYmQuYw0KPiBAQCAtMTk3MCwxOSArMTk3MCwxOSBA
QCBzdGF0aWMgaW50IHJiZF9jbHNfb2JqZWN0X21hcF91cGRhdGUoc3RydWN0IGNlcGhfb3NkX3Jl
cXVlc3QgKnJlcSwNCj4gIAkJCQkgICAgIGludCB3aGljaCwgdTY0IG9iam5vLCB1OCBuZXdfc3Rh
dGUsDQo+ICAJCQkJICAgICBjb25zdCB1OCAqY3VycmVudF9zdGF0ZSkNCj4gIHsNCj4gLQlzdHJ1
Y3QgY2VwaF9kYXRhYnVmICpkYnVmOw0KPiAtCXZvaWQgKnAsICpzdGFydDsNCj4gKwlzdHJ1Y3Qg
Y2VwaF9kYXRhYnVmICpyZXF1ZXN0Ow0KPiArCXZvaWQgKnA7DQo+ICAJaW50IHJldDsNCj4gIA0K
PiAgCXJldCA9IG9zZF9yZXFfb3BfY2xzX2luaXQocmVxLCB3aGljaCwgInJiZCIsICJvYmplY3Rf
bWFwX3VwZGF0ZSIpOw0KPiAgCWlmIChyZXQpDQo+ICAJCXJldHVybiByZXQ7DQo+ICANCj4gLQlk
YnVmID0gY2VwaF9kYXRhYnVmX3JlcV9hbGxvYygxLCBQQUdFX1NJWkUsIEdGUF9OT0lPKTsNCj4g
LQlpZiAoIWRidWYpDQo+ICsJcmVxdWVzdCA9IGNlcGhfZGF0YWJ1Zl9yZXFfYWxsb2MoMSwgOCAq
IDIgKyAzICogMSwgR0ZQX05PSU8pOw0KDQpUaGlzIDggKiAyICsgMyAqIDEgaXMgdG9vIHVuY2xl
YXIgZm9yIG1lLiA6KSBDb3VsZCB3ZSBpbnRyb2R1Y2UgbmFtZWQgY29uc3RhbnRzDQpoZXJlPw0K
DQo+ICsJaWYgKCFyZXF1ZXN0KQ0KPiAgCQlyZXR1cm4gLUVOT01FTTsNCj4gIA0KPiAtCXAgPSBz
dGFydCA9IGttYXBfY2VwaF9kYXRhYnVmX3BhZ2UoZGJ1ZiwgMCk7DQo+ICsJcCA9IGNlcGhfZGF0
YWJ1Zl9lbmNfc3RhcnQocmVxdWVzdCk7DQo+ICAJY2VwaF9lbmNvZGVfNjQoJnAsIG9iam5vKTsN
Cj4gIAljZXBoX2VuY29kZV82NCgmcCwgb2Jqbm8gKyAxKTsNCj4gIAljZXBoX2VuY29kZV84KCZw
LCBuZXdfc3RhdGUpOw0KPiBAQCAtMTk5MiwxMCArMTk5Miw5IEBAIHN0YXRpYyBpbnQgcmJkX2Ns
c19vYmplY3RfbWFwX3VwZGF0ZShzdHJ1Y3QgY2VwaF9vc2RfcmVxdWVzdCAqcmVxLA0KPiAgCX0g
ZWxzZSB7DQo+ICAJCWNlcGhfZW5jb2RlXzgoJnAsIDApOw0KPiAgCX0NCj4gLQlrdW5tYXBfbG9j
YWwocCk7DQo+IC0JY2VwaF9kYXRhYnVmX2FkZGVkX2RhdGEoZGJ1ZiwgcCAtIHN0YXJ0KTsNCj4g
KwljZXBoX2RhdGFidWZfZW5jX3N0b3AocmVxdWVzdCwgcCk7DQo+ICANCj4gLQlvc2RfcmVxX29w
X2Nsc19yZXF1ZXN0X2RhdGFidWYocmVxLCB3aGljaCwgZGJ1Zik7DQo+ICsJb3NkX3JlcV9vcF9j
bHNfcmVxdWVzdF9kYXRhYnVmKHJlcSwgd2hpY2gsIHJlcXVlc3QpOw0KPiAgCXJldHVybiAwOw0K
PiAgfQ0KPiAgDQo+IEBAIC0yMTA4LDcgKzIxMDcsNyBAQCBzdGF0aWMgaW50IHJiZF9vYmpfY2Fs
Y19pbWdfZXh0ZW50cyhzdHJ1Y3QgcmJkX29ial9yZXF1ZXN0ICpvYmpfcmVxLA0KPiAgDQo+ICBz
dGF0aWMgaW50IHJiZF9vc2Rfc2V0dXBfc3RhdChzdHJ1Y3QgY2VwaF9vc2RfcmVxdWVzdCAqb3Nk
X3JlcSwgaW50IHdoaWNoKQ0KPiAgew0KPiAtCXN0cnVjdCBjZXBoX2RhdGFidWYgKmRidWY7DQo+
ICsJc3RydWN0IGNlcGhfZGF0YWJ1ZiAqcmVxdWVzdDsNCj4gIA0KPiAgCS8qDQo+ICAJICogVGhl
IHJlc3BvbnNlIGRhdGEgZm9yIGEgU1RBVCBjYWxsIGNvbnNpc3RzIG9mOg0KPiBAQCAtMjExOCwx
MiArMjExNywxMiBAQCBzdGF0aWMgaW50IHJiZF9vc2Rfc2V0dXBfc3RhdChzdHJ1Y3QgY2VwaF9v
c2RfcmVxdWVzdCAqb3NkX3JlcSwgaW50IHdoaWNoKQ0KPiAgCSAqICAgICAgICAgbGUzMiB0dl9u
c2VjOw0KPiAgCSAqICAgICB9IG10aW1lOw0KPiAgCSAqLw0KPiAtCWRidWYgPSBjZXBoX2RhdGFi
dWZfcmVwbHlfYWxsb2MoMSwgOCArIHNpemVvZihzdHJ1Y3QgY2VwaF90aW1lc3BlYyksIEdGUF9O
T0lPKTsNCj4gLQlpZiAoIWRidWYpDQo+ICsJcmVxdWVzdCA9IGNlcGhfZGF0YWJ1Zl9yZXBseV9h
bGxvYygxLCA4ICsgc2l6ZW9mKHN0cnVjdCBjZXBoX3RpbWVzcGVjKSwgR0ZQX05PSU8pOw0KDQpE
aXR0by4gV2h5IGRvIHdlIGhhdmUgOCArIHNpemVvZihzdHJ1Y3QgY2VwaF90aW1lc3BlYykgaGVy
ZT8NCg0KVGhhbmtzLA0KU2xhdmEuDQoNCj4gKwlpZiAoIXJlcXVlc3QpDQo+ICAJCXJldHVybiAt
RU5PTUVNOw0KPiAgDQo+ICAJb3NkX3JlcV9vcF9pbml0KG9zZF9yZXEsIHdoaWNoLCBDRVBIX09T
RF9PUF9TVEFULCAwKTsNCj4gLQlvc2RfcmVxX29wX3Jhd19kYXRhX2luX2RhdGFidWYob3NkX3Jl
cSwgd2hpY2gsIGRidWYpOw0KPiArCW9zZF9yZXFfb3BfcmF3X2RhdGFfaW5fZGF0YWJ1Zihvc2Rf
cmVxLCB3aGljaCwgcmVxdWVzdCk7DQo+ICAJcmV0dXJuIDA7DQo+ICB9DQo+ICANCj4gQEAgLTI5
NjQsMTYgKzI5NjMsMTYgQEAgc3RhdGljIGludCByYmRfb2JqX2NvcHl1cF9jdXJyZW50X3NuYXBj
KHN0cnVjdCByYmRfb2JqX3JlcXVlc3QgKm9ial9yZXEsDQo+ICANCj4gIHN0YXRpYyBpbnQgc2V0
dXBfY29weXVwX2J1ZihzdHJ1Y3QgcmJkX29ial9yZXF1ZXN0ICpvYmpfcmVxLCB1NjQgb2JqX292
ZXJsYXApDQo+ICB7DQo+IC0Jc3RydWN0IGNlcGhfZGF0YWJ1ZiAqZGJ1ZjsNCj4gKwlzdHJ1Y3Qg
Y2VwaF9kYXRhYnVmICpyZXF1ZXN0Ow0KPiAgDQo+ICAJcmJkX2Fzc2VydCghb2JqX3JlcS0+Y29w
eXVwX2J1Zik7DQo+ICANCj4gLQlkYnVmID0gY2VwaF9kYXRhYnVmX3JlcV9hbGxvYyhjYWxjX3Bh
Z2VzX2ZvcigwLCBvYmpfb3ZlcmxhcCksDQo+ICsJcmVxdWVzdCA9IGNlcGhfZGF0YWJ1Zl9yZXFf
YWxsb2MoY2FsY19wYWdlc19mb3IoMCwgb2JqX292ZXJsYXApLA0KPiAgCQkJCSAgICAgIG9ial9v
dmVybGFwLCBHRlBfTk9JTyk7DQo+IC0JaWYgKCFkYnVmKQ0KPiArCWlmICghcmVxdWVzdCkNCj4g
IAkJcmV0dXJuIC1FTk9NRU07DQo+ICANCj4gLQlvYmpfcmVxLT5jb3B5dXBfYnVmID0gZGJ1ZjsN
Cj4gKwlvYmpfcmVxLT5jb3B5dXBfYnVmID0gcmVxdWVzdDsNCj4gIAlyZXR1cm4gMDsNCj4gIH0N
Cj4gIA0KPiBAQCAtNDU4MCwxMCArNDU3OSw5IEBAIHN0YXRpYyBpbnQgcmJkX29ial9tZXRob2Rf
c3luYyhzdHJ1Y3QgcmJkX2RldmljZSAqcmJkX2RldiwNCj4gIAkJaWYgKCFyZXF1ZXN0KQ0KPiAg
CQkJcmV0dXJuIC1FTk9NRU07DQo+ICANCj4gLQkJcCA9IGttYXBfY2VwaF9kYXRhYnVmX3BhZ2Uo
cmVxdWVzdCwgMCk7DQo+IC0JCW1lbWNweShwLCBvdXRib3VuZCwgb3V0Ym91bmRfc2l6ZSk7DQo+
IC0JCWt1bm1hcF9sb2NhbChwKTsNCj4gLQkJY2VwaF9kYXRhYnVmX2FkZGVkX2RhdGEocmVxdWVz
dCwgb3V0Ym91bmRfc2l6ZSk7DQo+ICsJCXAgPSBjZXBoX2RhdGFidWZfZW5jX3N0YXJ0KHJlcXVl
c3QpOw0KPiArCQljZXBoX2VuY29kZV9jb3B5KCZwLCBvdXRib3VuZCwgb3V0Ym91bmRfc2l6ZSk7
DQo+ICsJCWNlcGhfZGF0YWJ1Zl9lbmNfc3RvcChyZXF1ZXN0LCBwKTsNCj4gIAl9DQo+ICANCj4g
IAlyZXBseSA9IGNlcGhfZGF0YWJ1Zl9yZXBseV9hbGxvYygxLCBpbmJvdW5kX3NpemUsIEdGUF9L
RVJORUwpOw0KPiBAQCAtNDcxMiw3ICs0NzEwLDcgQEAgc3RhdGljIHZvaWQgcmJkX2ZyZWVfZGlz
ayhzdHJ1Y3QgcmJkX2RldmljZSAqcmJkX2RldikNCj4gIHN0YXRpYyBpbnQgcmJkX29ial9yZWFk
X3N5bmMoc3RydWN0IHJiZF9kZXZpY2UgKnJiZF9kZXYsDQo+ICAJCQkgICAgIHN0cnVjdCBjZXBo
X29iamVjdF9pZCAqb2lkLA0KPiAgCQkJICAgICBzdHJ1Y3QgY2VwaF9vYmplY3RfbG9jYXRvciAq
b2xvYywNCj4gLQkJCSAgICAgc3RydWN0IGNlcGhfZGF0YWJ1ZiAqZGJ1ZiwgaW50IGxlbikNCj4g
KwkJCSAgICAgc3RydWN0IGNlcGhfZGF0YWJ1ZiAqcmVxdWVzdCwgaW50IGxlbikNCj4gIHsNCj4g
IAlzdHJ1Y3QgY2VwaF9vc2RfY2xpZW50ICpvc2RjID0gJnJiZF9kZXYtPnJiZF9jbGllbnQtPmNs
aWVudC0+b3NkYzsNCj4gIAlzdHJ1Y3QgY2VwaF9vc2RfcmVxdWVzdCAqcmVxOw0KPiBAQCAtNDcy
Nyw3ICs0NzI1LDcgQEAgc3RhdGljIGludCByYmRfb2JqX3JlYWRfc3luYyhzdHJ1Y3QgcmJkX2Rl
dmljZSAqcmJkX2RldiwNCj4gIAlyZXEtPnJfZmxhZ3MgPSBDRVBIX09TRF9GTEFHX1JFQUQ7DQo+
ICANCj4gIAlvc2RfcmVxX29wX2V4dGVudF9pbml0KHJlcSwgMCwgQ0VQSF9PU0RfT1BfUkVBRCwg
MCwgbGVuLCAwLCAwKTsNCj4gLQlvc2RfcmVxX29wX2V4dGVudF9vc2RfZGF0YWJ1ZihyZXEsIDAs
IGRidWYpOw0KPiArCW9zZF9yZXFfb3BfZXh0ZW50X29zZF9kYXRhYnVmKHJlcSwgMCwgcmVxdWVz
dCk7DQo+ICANCj4gIAlyZXQgPSBjZXBoX29zZGNfYWxsb2NfbWVzc2FnZXMocmVxLCBHRlBfS0VS
TkVMKTsNCj4gIAlpZiAocmV0KQ0KPiBAQCAtNDc1MCwxNiArNDc0OCwxNiBAQCBzdGF0aWMgaW50
IHJiZF9kZXZfdjFfaGVhZGVyX2luZm8oc3RydWN0IHJiZF9kZXZpY2UgKnJiZF9kZXYsDQo+ICAJ
CQkJICBib29sIGZpcnN0X3RpbWUpDQo+ICB7DQo+ICAJc3RydWN0IHJiZF9pbWFnZV9oZWFkZXJf
b25kaXNrICpvbmRpc2s7DQo+IC0Jc3RydWN0IGNlcGhfZGF0YWJ1ZiAqZGJ1ZiA9IE5VTEw7DQo+
ICsJc3RydWN0IGNlcGhfZGF0YWJ1ZiAqcmVxdWVzdCA9IE5VTEw7DQo+ICAJdTMyIHNuYXBfY291
bnQgPSAwOw0KPiAgCXU2NCBuYW1lc19zaXplID0gMDsNCj4gIAl1MzIgd2FudF9jb3VudDsNCj4g
IAlpbnQgcmV0Ow0KPiAgDQo+IC0JZGJ1ZiA9IGNlcGhfZGF0YWJ1Zl9yZXFfYWxsb2MoMSwgc2l6
ZW9mKCpvbmRpc2spLCBHRlBfS0VSTkVMKTsNCj4gLQlpZiAoIWRidWYpDQo+ICsJcmVxdWVzdCA9
IGNlcGhfZGF0YWJ1Zl9yZXFfYWxsb2MoMSwgc2l6ZW9mKCpvbmRpc2spLCBHRlBfS0VSTkVMKTsN
Cj4gKwlpZiAoIXJlcXVlc3QpDQo+ICAJCXJldHVybiAtRU5PTUVNOw0KPiAtCW9uZGlzayA9IGtt
YXBfY2VwaF9kYXRhYnVmX3BhZ2UoZGJ1ZiwgMCk7DQo+ICsJb25kaXNrID0ga21hcF9jZXBoX2Rh
dGFidWZfcGFnZShyZXF1ZXN0LCAwKTsNCj4gIA0KPiAgCS8qDQo+ICAJICogVGhlIGNvbXBsZXRl
IGhlYWRlciB3aWxsIGluY2x1ZGUgYW4gYXJyYXkgb2YgaXRzIDY0LWJpdA0KPiBAQCAtNDc3Niwx
MyArNDc3NCwxMyBAQCBzdGF0aWMgaW50IHJiZF9kZXZfdjFfaGVhZGVyX2luZm8oc3RydWN0IHJi
ZF9kZXZpY2UgKnJiZF9kZXYsDQo+ICAJCXNpemUgKz0gbmFtZXNfc2l6ZTsNCj4gIA0KPiAgCQly
ZXQgPSAtRU5PTUVNOw0KPiAtCQlpZiAoc2l6ZSA+IGRidWYtPmxpbWl0ICYmDQo+IC0JCSAgICBj
ZXBoX2RhdGFidWZfcmVzZXJ2ZShkYnVmLCBzaXplIC0gZGJ1Zi0+bGltaXQsDQo+ICsJCWlmIChz
aXplID4gcmVxdWVzdC0+bGltaXQgJiYNCj4gKwkJICAgIGNlcGhfZGF0YWJ1Zl9yZXNlcnZlKHJl
cXVlc3QsIHNpemUgLSByZXF1ZXN0LT5saW1pdCwNCj4gIAkJCQkJIEdGUF9LRVJORUwpIDwgMCkN
Cj4gIAkJCWdvdG8gb3V0Ow0KPiAgDQo+ICAJCXJldCA9IHJiZF9vYmpfcmVhZF9zeW5jKHJiZF9k
ZXYsICZyYmRfZGV2LT5oZWFkZXJfb2lkLA0KPiAtCQkJCQkmcmJkX2Rldi0+aGVhZGVyX29sb2Ms
IGRidWYsIHNpemUpOw0KPiArCQkJCQkmcmJkX2Rldi0+aGVhZGVyX29sb2MsIHJlcXVlc3QsIHNp
emUpOw0KPiAgCQlpZiAocmV0IDwgMCkNCj4gIAkJCWdvdG8gb3V0Ow0KPiAgCQlpZiAoKHNpemVf
dClyZXQgPCBzaXplKSB7DQo+IEBAIC00ODA2LDcgKzQ4MDQsNyBAQCBzdGF0aWMgaW50IHJiZF9k
ZXZfdjFfaGVhZGVyX2luZm8oc3RydWN0IHJiZF9kZXZpY2UgKnJiZF9kZXYsDQo+ICAJcmV0ID0g
cmJkX2hlYWRlcl9mcm9tX2Rpc2soaGVhZGVyLCBvbmRpc2ssIGZpcnN0X3RpbWUpOw0KPiAgb3V0
Og0KPiAgCWt1bm1hcF9sb2NhbChvbmRpc2spOw0KPiAtCWNlcGhfZGF0YWJ1Zl9yZWxlYXNlKGRi
dWYpOw0KPiArCWNlcGhfZGF0YWJ1Zl9yZWxlYXNlKHJlcXVlc3QpOw0KPiAgCXJldHVybiByZXQ7
DQo+ICB9DQo+ICANCj4gQEAgLTU2MjUsMTAgKzU2MjMsMTAgQEAgc3RhdGljIGludCByYmRfZGV2
X3YyX3BhcmVudF9pbmZvKHN0cnVjdCByYmRfZGV2aWNlICpyYmRfZGV2LA0KPiAgCWlmICghcmVw
bHkpDQo+ICAJCWdvdG8gb3V0X2ZyZWU7DQo+ICANCj4gLQlwID0ga21hcF9jZXBoX2RhdGFidWZf
cGFnZShyZXF1ZXN0LCAwKTsNCj4gKwlwID0gY2VwaF9kYXRhYnVmX2VuY19zdGFydChyZXF1ZXN0
KTsNCj4gIAljZXBoX2VuY29kZV82NCgmcCwgcmJkX2Rldi0+c3BlYy0+c25hcF9pZCk7DQo+IC0J
a3VubWFwX2xvY2FsKHApOw0KPiAtCWNlcGhfZGF0YWJ1Zl9hZGRlZF9kYXRhKHJlcXVlc3QsIHNp
emVvZihfX2xlNjQpKTsNCj4gKwljZXBoX2RhdGFidWZfZW5jX3N0b3AocmVxdWVzdCwgcCk7DQo+
ICsNCj4gIAlyZXQgPSBfX2dldF9wYXJlbnRfaW5mbyhyYmRfZGV2LCByZXF1ZXN0LCByZXBseSwg
cGlpKTsNCj4gIAlpZiAocmV0ID4gMCkNCj4gIAkJcmV0ID0gX19nZXRfcGFyZW50X2luZm9fbGVn
YWN5KHJiZF9kZXYsIHJlcXVlc3QsIHJlcGx5LCBwaWkpOw0KPiANCj4gDQoNCg==

