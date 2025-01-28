Return-Path: <linux-fsdevel+bounces-40263-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D77A214F6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 00:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DA4B1888BBC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 23:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4C791E98E7;
	Tue, 28 Jan 2025 23:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bXxvTfWa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD69B17B50A;
	Tue, 28 Jan 2025 23:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738106834; cv=fail; b=RkZtRt5jRzJIsdKsOuGnvhc9IFncKFh2umyibqS9bEnc87SowZ4WLMnxwEPAw98z8KLhcY9hBRu+G3M4k4Tg000ssjm91S4NysQB4sXWrNupmaDwU2dMc3VLiQMAahcohlI9C7q+PgKGa4eHqBh1/b/CfS7FNilvVRuwmRNY9ZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738106834; c=relaxed/simple;
	bh=tkRr3TIM1s1VkFIEdWkkZs8Lb2hkfHL459ZVQWnpeZU=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=r5p5e8u995Myjj5rnxvjrcfFoyFmVKKNX7xWBbV0hJrm50JzcWIQ8ntBoLWwW3DP39eA90vufAw/QcwhjQbHwnQXmBteq4hnHdY9moOiDLQ1pI1wC4SaSCQwrNbL7PSg5tX18fPNCdy4ywc2TnVeytcvQIqqjIwgQisAzdTZ+Lc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bXxvTfWa; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50SF1N4l006769;
	Tue, 28 Jan 2025 23:27:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=tkRr3TIM1s1VkFIEdWkkZs8Lb2hkfHL459ZVQWnpeZU=; b=bXxvTfWa
	oLkpuYxzH1eWvAwEAJaIXSxcfhKqAJ6OIVYZLlaw3PW0rHgPi/xnxOqoazIvGauM
	kFH5xgjaMEJWrljVw6MY2/PnGz24Yk7WKyCOQlkbADSh+r7T6CacLYM/gRP4Hu8o
	50oLzgEuQARNjoWZ4ZXm45OrYfthIqj272PGoY9HxtWjGO25/X4lFLkyWJsEgMfV
	U3LdJM0j0VoFPmauJoQBpenBU9tskQnawkH1uKLTnm7sdVDKhXKmwWyUeq2xDinx
	h8+x52K6GLPuFimjrlaJH+hwBPdo+E6GJC2vCxZ7F+6YzedXLWemtDaMxzbpqZKz
	XC5cBDA0CMlk6Q==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44f1gyj9bh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jan 2025 23:27:09 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50SNR8Ld015739;
	Tue, 28 Jan 2025 23:27:08 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44f1gyj9bf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jan 2025 23:27:08 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hBH8X7Z9+JTikuBb7v5RcKjBbG2AFUMc2hlsAqFhc+Imdx+7o9zvX8hq9Fj4aHuxKVaHXyxoFrFU0mzmaFn0/7G3nKOyHx/5q8vSSgPyDggR0CJG3fEUb2kF/T9kmP6hA//7q9BdrFNb4ueqpA8yTAE2hr2RJg5BgTWSR77vSfS171XzmA6q/fc6kjzyoKmOkyeLVrhqnqHYQTJ+a6q6Y82PmTk7nrCkh9tVNlarTYruX9ysZaWLupOFk+IA7CU0Qfc5vjqGhEnySfcrGCdO3sCYlVOD+BZhBpB7RAU9iCA/Qzu+hjR6tlu9Z3qW+u3TI+3pP4Z3MelP2x30dP07ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tkRr3TIM1s1VkFIEdWkkZs8Lb2hkfHL459ZVQWnpeZU=;
 b=gqw+ZVkkNLbO6KTHRz3AV+wFFcDiDku0FRoQZrEaZKwI7VF90raJJBQLr5C0i1iTKrItDRREQPPqI2B4QolbsBNwe5ZjeljcLIR4Eamg0Sk6qvzidhSouzJiCxkZM5ZUYjNCRGefdyRhKD5XuB8HfXfEuUo1rdeJhVbWdlvRHomyR7KtTTkuanyCfDfIehCU3Gowsyfvk4b9d5oEUKfTzQwHHLwlboBu8Sf+01tZ7W+yUJEdLfeBZ37wug9RMoagUNYmE7HZvg0rFOcVzmuvbDukvrCfXSBsKl1Fyb90JLvKJqPJnCPWcwRgm4HZ2mL1cALQiEF61Ob7yuXR4Yttpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by CH3PR15MB5914.namprd15.prod.outlook.com (2603:10b6:610:12c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Tue, 28 Jan
 2025 23:27:06 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%7]) with mapi id 15.20.8377.021; Tue, 28 Jan 2025
 23:27:05 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "slava@dubeyko.com" <slava@dubeyko.com>,
        "viro@zeniv.linux.org.uk"
	<viro@zeniv.linux.org.uk>
CC: Alex Markuze <amarkuze@redhat.com>,
        "ceph-devel@vger.kernel.org"
	<ceph-devel@vger.kernel.org>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Patrick
 Donnelly <pdonnell@redhat.com>
Thread-Topic: [EXTERNAL] Re: [PATCH] ceph: is_root_ceph_dentry() cleanup
Thread-Index: AQHbcTHI6MoXeV145U6GsShlXuSWerMs1eMA
Date: Tue, 28 Jan 2025 23:27:05 +0000
Message-ID: <dfafe82535b7931e99790a956d5009a960dc9e0d.camel@ibm.com>
References: <20250128011023.55012-1-slava@dubeyko.com>
	 <20250128030728.GN1977892@ZenIV>
In-Reply-To: <20250128030728.GN1977892@ZenIV>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|CH3PR15MB5914:EE_
x-ms-office365-filtering-correlation-id: 44446ff0-16fa-4d19-0ae8-08dd3ff346b2
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?aUEweHIvcTJEWUxiaUZQb3owNGRIWGxub2tsUTJLZVV3Y0RvR2xhdmRmSk9U?=
 =?utf-8?B?U3ZpdTZUQk4xcFlDei9hQXFjMERQNklTS1k2VkNMall4ZE9NMzQ1NitQUVR4?=
 =?utf-8?B?NUMxWGE1UDhNT2hNck9wM1BlOWVOYTdTVHhDVFZPSG5sTTFpZ2dPN1E3ZG8r?=
 =?utf-8?B?aFZtZjAwU2I5a3A2U1o2cGd3YzZaZEhUcURwOUFNc2JjVDlwSW1EbjdHVklW?=
 =?utf-8?B?T0VqSlBFdWprWkxycUMxVW5yTWlieTlPcDBtY0VOZ3BNRkdPV0JmbUN3QzAv?=
 =?utf-8?B?YVhWb0M5bnJUbkZsQmVQNUxzYjVqd2xSSDY5ZkR1bjhhSUl0WUxRTHNyMUU0?=
 =?utf-8?B?N0p2eHpQSkR4M2hOV293NWV4Wmttd2hMM1Vsay84d3dCaTBPQTBjZzVmWnFj?=
 =?utf-8?B?alMxZXVBaE1laWMxd3l6VUVNWU15SlJJN1dicU5jS3dNZURXZG51cE5nZjBS?=
 =?utf-8?B?cWdlbVJtKzJJVWsyTWxXRzdLb01nZUdRZWNOZjRXUU9qK2g2eU5mRGpGcDJ1?=
 =?utf-8?B?MVk0czZ1dFBjRTRZMGRWSDd6U21uUkJReCtaWmtJRGROQmsra09JQU54cWU3?=
 =?utf-8?B?QlhVWHQwWkhudVVTanNQc3B4aVNBNmc4QW9xMDhxMlVtbFQxWUhNMVBWQkNW?=
 =?utf-8?B?Y2lXM1RhOXFiSlVYaXg4K3Jlc3dUeGlvNlhSZ1VScW9LRFhhWmo2Z04zbGpp?=
 =?utf-8?B?bytWSkRqZzdyS1JpbE8rME5HdGJTdzJsblBKaHZZOGZRbENKR3dJR1dmWXNQ?=
 =?utf-8?B?TFB0NFA1LzB4MU56U2I3Q0VXdEhtL3RvSXJFNHRuQmhGYjFEY2pBRk1CQUdK?=
 =?utf-8?B?S1ZyVWdMbC9qNUNWVm4ybjFOanpNOFQraWR1WnpJYWsvaHFNVWhYN0tSYmRL?=
 =?utf-8?B?UnBsc0ZwTmF5Z09UOC8zeGJobHpRRlN4V0lYb203amFYZEF1NzBqcDFWU0dx?=
 =?utf-8?B?MnZVc01iTXlVU0NpQ3VjT1N1SXh1ckQwK1FkaktmUkVKeUcrTkZCd1BjVjRz?=
 =?utf-8?B?c0VmMmRYd3BKT29BR2RXTytqM2tnOGlYVml0WXlFb2NCa0JZcjV1VVFuUytW?=
 =?utf-8?B?d1dKK3d0K0t5WVowSzlNMndlUUdCVXVhbEdXMFZuS1E0TnQrUTcxbGR0ODJS?=
 =?utf-8?B?NlBlVXk4ZGdramdaR085dGxvZUYwRklkSWJuZWx6dDlhZjBQYlhJakpJcWMr?=
 =?utf-8?B?V3RLLzR0a0ovaXZVOCs4OVpmYTZwK005RzRKL1M2bHRLVkFyZ0RIZXp3Nld0?=
 =?utf-8?B?SVhjNUw5M0ZrSk5OMEZwbEJmTzFuUEkzaWRxZ0x1SDNhalFqWkcvcEFGV0Fx?=
 =?utf-8?B?N0hzNmdtVUZRd1MvaFcrUXRxaURCcTdCVjQraFNnUzk0Y294RE1WOHFXNUxl?=
 =?utf-8?B?VldNVzdQUExVRlpIZFJXc0VhY3ZTMnJrRFgyOFZqYU8wclk5ZldLR0FXbmVz?=
 =?utf-8?B?cXIyUWFJK0FxZnRFSFR2WmsvK1RPcUdwWE1VZ2pVRVl4SkVlU2djNnhseHBJ?=
 =?utf-8?B?VjdiNkVQOG1FQjdvZ0dsVnZPZllGcUE1YXo5OHdoWGJ1TnR5QytpemlZZDJL?=
 =?utf-8?B?Z1JVTWdDT2JlWUFhQWJjWlcvZE1vVjAzOGtuSFhKbDJsOXRxOU5JSjFnNVlI?=
 =?utf-8?B?S3IycFJqVXN4bTN1MHByelhrR1ZwaDBKOWt4dE9wK1V4MU5NbU5UbE1YQnZJ?=
 =?utf-8?B?WTdnbG9yanRPT2tEUjFuaUN1bzJCenRRVC9BYUFWSm9seHZKMUFQTk03eWJh?=
 =?utf-8?B?b2JBdmNWRFEzUG9xTndKalZNK3pDcmJzSWY4VkdjUjVhVjZoK0YyRmQzdDRv?=
 =?utf-8?B?cDJFOWZwNXNidWZDclk5dEtLRmxsQmZiWitGSXp3dWZkOWRVM0Y2eFc0cS8v?=
 =?utf-8?B?UGFDSXJDcUxMSG8yU3ltODMrM0lqTjljaDdUZ2pHVGp2LzZzcjdBUW0yNENK?=
 =?utf-8?Q?NyWVKJBWxpx5VYHZVB14ztZ1VM6LVG39?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dUZQWTBlVFFOaFo2YTVzbG9sSldVRjBvTlUraW1ObXU0NGp5c0JrSnlDVjZY?=
 =?utf-8?B?OGliTWRmVlNPZVdYZkdsQ1R5ei9mbHFjZHpvZDJIZGFzQVd6d1ExcDFBVVVn?=
 =?utf-8?B?WDA5eG43dmkwR01mSmtFY2NxMzlVU05Zek5DaXYzQkVmWTRNdUJoZHdYcWVT?=
 =?utf-8?B?ZEsySE9Oc1Q1emdwenRJYWc1U1VwakVJN2dXYkdaSXZJdFlHeDg0MG9DM1Ro?=
 =?utf-8?B?Wk9ncnFnVWlRK0RPZzh5MDd0azNwbnpxU2JmelEwN1k3eEsrQ3k3SmhyNEV6?=
 =?utf-8?B?SEI0REdSV2pncDlVczVZV3d2WThCY2hKWU9PaUFRWWJEVEpuZVBRSWxWMWNS?=
 =?utf-8?B?T3ViUVcvUVRZVUgyWjBsNWh4Q3NJeW9aa2pxTXBuZXFFenFrelNFUDFQT1ZT?=
 =?utf-8?B?ano0QUtCK2IyZ1ZXc1QvLzJhSkQvWVllbTZpZzJ3NWhSdnpoQjdMWFNTSUl5?=
 =?utf-8?B?YmMyUDM4TVQ0SG9qWDd4NVdneGRnUk43RVdmQjRHMXNCVzVNd1MvUDFjY01B?=
 =?utf-8?B?VDJZb0tZVFpnRG5qenNnM3V1eTBoSE5qU09ybURibEVMMlpCR3gwZ0E1cHUr?=
 =?utf-8?B?ZmQrZmhzckxwL3NHOVpYVGVxS2s3cVh3OC8yTUJWeVdJTVBDUlV2UFBHUUJ2?=
 =?utf-8?B?YmV1aTBxZGFwbytpK0RGZE02MzFQUDVSWGJmeW40OGl2czY1dmhsb0pGTXg0?=
 =?utf-8?B?M2VLV2p6c0VtWnZtaExQUW1pQ1pDbHA5WUFvcXZoa1BhTkpQRnB3TFNSd3Uz?=
 =?utf-8?B?V0FEYzhMdkFxek0zWkk4TE5jc3EzMXdqUDkxcU5LMWowNzBrQytNM08yTndQ?=
 =?utf-8?B?RVR4ZGhOTERiVzcwUE85bFlvbjJueHFheHN3OE1OdDVFRnhNTnMyQUVSSWZ4?=
 =?utf-8?B?UkNUL05CbnRDNkxlY3UvakFaeCtBRlZvaDZPS3RRTzBGcGJkTXI1Q3J6V2hh?=
 =?utf-8?B?Q3JPaTZtSG9SOUhncDFBWHVHK0l0NTR2MytKWlFwNzlndUVKRVdJT3M5MmpE?=
 =?utf-8?B?Rk0yVldzcWdZMndhVm4vMXovcThEY0ROL0E5cG9RQ3UxMk8zR0hhUUFuRTU4?=
 =?utf-8?B?L0x2bjNYNEp6MlQwRlJMQjRGR3h5b3hGOUVCZ3BDK3o4bWxySnorYjhoRmFx?=
 =?utf-8?B?UDlPTlZKQzNkaFZ4MDVZRzhOZ3VFdzVIaFkzSmx2YkpJN0xhbU5Td3ArTG9Y?=
 =?utf-8?B?azJnc1pXRlR2RVZqVlVVR29CbUsrY3M2d1ZicVpBNjNLR05uUUJrMVNlcnl1?=
 =?utf-8?B?c0NIRHByWEE1VGEzL05NczRSejR3azBPbGlTV0duWnZPKzdjaFBXR1pKZFRC?=
 =?utf-8?B?NFd0QnZpR1NKdnliM3hQVE1IblFzSUNPWUtuWmZmYTE4S21YbEp0Y0lndEox?=
 =?utf-8?B?NkQzMFp2MC80azNHdTJjNlY0N2xZQWIwTjZSbmFTNERuMjh3N3lYVHZueHlu?=
 =?utf-8?B?aUhuWHBNdDEyRkQ3N0dqdWlsMnJvdGNicXpuUzZ3L2lyRE5ZSVlUT1Q0KzBS?=
 =?utf-8?B?N3FGTXh6VWxWYmZmTmRCTUV0OVhVRC9qKytCOWYzd0toUEQ0Y05PdllrYVpw?=
 =?utf-8?B?OUhqa2NyaGYzY0JKQXRqT3NmVVFjTVhjM3FsS3d6S2xnalp3N2s3cStBcC83?=
 =?utf-8?B?WjlPRnZsbTk5RGpnVmhOVzNuSVRTekt0VUcwQW5EVUhZTjdCbE8vVzQ3SVpx?=
 =?utf-8?B?c0xrRzFmQWVUQy9FZE5MMDhSQkE3ZXRLTUxzSmZUZEJhRlFKa2tCQWdPQUNT?=
 =?utf-8?B?L09mOHAzek0va3dMSHQrL3hlaGtoLysyeG5xQWs1TlR6RE1oL2ZxYTNGb011?=
 =?utf-8?B?ZzVxVW9FeHlldTZwcGFXcjc1cElJWWUwc2cxdGdCUFR4eHVuNnYxUVp0UU5C?=
 =?utf-8?B?bUVOUVgwWWdvZVRuRGJUMEttMzRsV2FpTXp2UkNQSUF0dVFZWVFKMmJ4WXNj?=
 =?utf-8?B?S1dwU0pjM0ExeTRtUVd2NnFTMUJOYjV5cmNpUy9ZN2FoUEthOGMxaDI0SHJC?=
 =?utf-8?B?UHBiMFpXTDY5RDB1VVhKeTgydnJsV005QUpEOE9rMnBVZEZnTW9KTnZ1MUJq?=
 =?utf-8?B?K2RWWGZYT2J5ellvMlpVV0RZL1VUSFc2Y2hrb1lDbzIwbk1PekVsNGlOamJv?=
 =?utf-8?B?UWFjVitLMzdMN3o0NGpPNHl6Wlo4V1ZTNEw1NW83Vm5uRjJrZ29XQmdCSEpD?=
 =?utf-8?Q?EFcUFtL6XE3MhFs152p8slE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DB62EE4EFDCDC24495E928640895CA39@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 44446ff0-16fa-4d19-0ae8-08dd3ff346b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2025 23:27:05.1534
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hjy9UBilfv4PdOKz2yl9MJD3m3mpq5xI9LqW+dJ2uIfWTbWktIheMjo2oatiJttoA4j6ELN80ib3QkWKidJIyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR15MB5914
X-Proofpoint-GUID: SYVODQQY5FEKxarjtnuP70vD6qus9a9f
X-Proofpoint-ORIG-GUID: rgRvkuBvaYXNYnp3RZcisrLhmYelOtIr
Subject: RE: [PATCH] ceph: is_root_ceph_dentry() cleanup
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_04,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 suspectscore=0 phishscore=0 mlxlogscore=955 impostorscore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501280168

T24gVHVlLCAyMDI1LTAxLTI4IGF0IDAzOjA3ICswMDAwLCBBbCBWaXJvIHdyb3RlOg0KPiBPbiBN
b24sIEphbiAyNywgMjAyNSBhdCAwNToxMDoyM1BNIC0wODAwLCBWaWFjaGVzbGF2IER1YmV5a28g
d3JvdGU6DQo+ID4gRnJvbTogVmlhY2hlc2xhdiBEdWJleWtvIDxTbGF2YS5EdWJleWtvQGlibS5j
b20+DQo+ID4gDQo+ID4gVGhpcyBwYXRjaCBpbnRyb2R1Y2VzIENFUEhfSElEREVOX0RJUl9OQU1F
LiBJdA0KPiA+IGRlY2xhcmVzIG5hbWUgb2YgdGhlIGhpZGRlbiBkaXJlY3RvcnkgLmNlcGggaW4N
Cj4gPiB0aGUgaW5jbHVkZS9saW51eC9jZXBoL2NlcGhfZnMuaCBpbnN0ZWFkIG9mIGhpZGluZw0K
PiA+IGl0IGluIGRpci5jIGZpbGUuIEFsc28gaGFyZGNvZGVkIGxlbmd0aCBvZiB0aGUgbmFtZQ0K
PiA+IGlzIGNoYW5nZWQgb24gc3RybGVuKENFUEhfSElEREVOX0RJUl9OQU1FKS4NCj4gDQo+IEht
bS4uLg0KPiANCj4gU3BlYWtpbmcgb2YgdGhhdCBhcmVhDQo+IAkqIGhvdyB0aGUgaGVsbCBjb3Vs
ZCBjZXBoX2xvb2t1cCgpIGV2ZXIgYmUgY2FsbGVkIHdpdGggZGVudHJ5DQo+IHRoYXQgaXMgKk5P
VCogbmVnYXRpdmU/ICBWRlMgY2VydGFpbmx5IHdvbid0IGRvIHRoYXQ7IEknbSBub3Qgc3VyZSBh
Ym91dA0KPiBjZXBoX2hhbmRsZV9ub3RyYWNlX2NyZWF0ZSgpLCBidXQgaXQgZG9lc24ndCBsb29r
IGxpa2UgdGhhdCdzIHBvc3NpYmxlDQo+IHdpdGhvdXQgc2VydmVyIGJlaW5nIG1hbGljaW91cyAo
aWYgaXQncyBwb3NzaWJsZSBhdCBhbGwpLg0KPiANCj4gCSogc3BlYWtpbmcgb2YgbWFsaWNpb3Vz
IHNlcnZlcnMsIHdoYXQgaGFwcGVucyBpZg0KPiBpdCBnZXRzIENFUEhfTURTX09QX0xPT0tVUCBh
bmQgaXQgcmV0dXJucyBhIG5vcm1hbCByZXBseSB0byBwb3NpdGl2ZQ0KPiBsb29rdXAsIGJ1dCB3
aXRoIGNwdV90b19sZTMyKC1FTk9FTlQpIHNob3ZlZCBpbnRvIGhlYWQtPnJlc3VsdD8NCj4gCUFG
QUlDUywgY2VwaF9oYW5kbGVfc25hcGRpcigpIHdpbGwgYmUgY2FsbGVkIHdpdGggZGVudHJ5DQo+
IHRoYXQgaXMgYWxyZWFkeSBtYWRlIHBvc2l0aXZlOyByZXN1bHRzIHdpbGwgbm90IGJlIHByZXR0
eS4uLg0KDQpJIGFzc3VtZSB0aGF0IHlvdSBpbXBseSB0aGlzIGNvZGU6DQoNCgkvKiBjYW4gd2Ug
Y29uY2x1ZGUgRU5PRU5UIGxvY2FsbHk/ICovDQoJaWYgKGRfcmVhbGx5X2lzX25lZ2F0aXZlKGRl
bnRyeSkpIHsNCgkJc3RydWN0IGNlcGhfaW5vZGVfaW5mbyAqY2kgPSBjZXBoX2lub2RlKGRpcik7
DQoJCXN0cnVjdCBjZXBoX2RlbnRyeV9pbmZvICpkaSA9IGNlcGhfZGVudHJ5KGRlbnRyeSk7DQoN
CgkJc3Bpbl9sb2NrKCZjaS0+aV9jZXBoX2xvY2spOw0KCQlkb3V0YyhjbCwgIiBkaXIgJWxseC4l
bGx4IGZsYWdzIGFyZSAweCVseFxuIiwNCgkJICAgICAgY2VwaF92aW5vcChkaXIpLCBjaS0+aV9j
ZXBoX2ZsYWdzKTsNCgkJaWYgKHN0cm5jbXAoZGVudHJ5LT5kX25hbWUubmFtZSwNCgkJCSAgICBm
c2MtPm1vdW50X29wdGlvbnMtPnNuYXBkaXJfbmFtZSwNCgkJCSAgICBkZW50cnktPmRfbmFtZS5s
ZW4pICYmDQoJCSAgICAhaXNfcm9vdF9jZXBoX2RlbnRyeShkaXIsIGRlbnRyeSkgJiYNCgkJICAg
IGNlcGhfdGVzdF9tb3VudF9vcHQoZnNjLCBEQ0FDSEUpICYmDQoJCSAgICBfX2NlcGhfZGlyX2lz
X2NvbXBsZXRlKGNpKSAmJg0KCQkgICAgX19jZXBoX2NhcHNfaXNzdWVkX21hc2tfbWV0cmljKGNp
LCBDRVBIX0NBUF9GSUxFX1NIQVJFRCwNCjEpKSB7DQoJCQlfX2NlcGhfdG91Y2hfZm1vZGUoY2ks
IG1kc2MsIENFUEhfRklMRV9NT0RFX1JEKTsNCgkJCXNwaW5fdW5sb2NrKCZjaS0+aV9jZXBoX2xv
Y2spOw0KCQkJZG91dGMoY2wsICIgZGlyICVsbHguJWxseCBjb21wbGV0ZSwgLUVOT0VOVFxuIiwN
CgkJCSAgICAgIGNlcGhfdmlub3AoZGlyKSk7DQoJCQlkX2FkZChkZW50cnksIE5VTEwpOw0KCQkJ
ZGktPmxlYXNlX3NoYXJlZF9nZW4gPSBhdG9taWNfcmVhZCgmY2ktPmlfc2hhcmVkX2dlbik7DQoJ
CQlyZXR1cm4gTlVMTDsNCgkJfQ0KCQlzcGluX3VubG9jaygmY2ktPmlfY2VwaF9sb2NrKTsNCgl9
DQoNCkFtIEkgY29ycmVjdD8gU28sIGhvdyBjYW4gd2UgcmV3b3JrIHRoaXMgY29kZSBpZiBpdCdz
IHdyb25nPyBXaGF0IGlzIHlvdXINCnZpc2lvbj8gRG8geW91IG1lYW4gdGhhdCBpdCdzIGRlYWQg
Y29kZT8gSG93IGNhbiB3ZSBjaGVjayBpdD8NCg0KVGhhbmtzLA0KU2xhdmEuDQoNCg==

