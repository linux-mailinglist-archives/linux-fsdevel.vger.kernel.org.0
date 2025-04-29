Return-Path: <linux-fsdevel+bounces-47645-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 835E4AA1D4C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 23:27:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D408D467192
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 21:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F51C26982C;
	Tue, 29 Apr 2025 21:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XV2H6Yi/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2403921B8F7;
	Tue, 29 Apr 2025 21:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745962046; cv=fail; b=fWEb1quXQX7TcqSuGv4rSlzqlaEXMYBSFQqpYukxAgkZvyjGbBjASWl5/PvU73GdZaCtGxfmW1bN6loX46Xu4ogOnc7ecp4mdVSBtYpjpY1ThAcHH/Zewl6P2WKaqEdSPztaBV0zpDh69777SeUCpHfI2WDaxNF0jCehQJXdfMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745962046; c=relaxed/simple;
	bh=DU6ISjt6rufpXV2gJFoCUUf6TuCgfOm+DQ1il7Rgr1I=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=NLmA908lsnXHCDceveQaI/KZ1UphCvT4p52cDNkhNJFmpv623FZTYnSe/RZbnmxAKcLENfVLoCMOOfT+Ps7gulYRvgtPEW2KOu6VAHuA07kHQ5H614nqX1YHOOEEdmCkU35c+MoOiV3n3HpX+F43//eZHlkZo08jHCxg7H1urcE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XV2H6Yi/; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53TAexGZ009444;
	Tue, 29 Apr 2025 21:27:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=DU6ISjt6rufpXV2gJFoCUUf6TuCgfOm+DQ1il7Rgr1I=; b=XV2H6Yi/
	yHUj4rOptgRn2HZMIkmGwWiJd3BuSUyG2viCxqk1pmHrFLhB7xez1nBGmpwkcljW
	tY/QBYXftxhMBo+r408X/pVw9WLUtY8IX+f0MOZNzyF4Ejn7btYauL+clqpsS7yd
	O6Ini7f+8sDIQqplLveZfDSvfZRQjL2yeSpY9XHgR6+/DNrA8AtcEIE1MyNfcS9R
	NRVaAidN+Eqvl1Db93uG1r45c6yiRCTvOR0lreIVXLjmpx177YhSbdKuHXXPHoeH
	3ln47SPGyjvGSOpS32rWy8O30iohA3V8ckM9dJ3eznzH7COqLrMV8RsQe5q+aFIR
	CYO/EHewlJKwfg==
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46aw7t2vdt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Apr 2025 21:27:20 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bQg02DHxJStiI6Y6+XA302odjyDn/ckfWKzc9m+HlHNGktaYq26qDIoGWYuHb4w1XqmQWpH0g/pWiLxspPR9wdaplG/OxV4RScWRMU1wiX/FC8K605kOK+I9QXtiGIoOlOo0iM820bMrp7ndqUnSlSLu/ldGkZfmbJpMf5Xg2YztS0DfomAW06cqRj4XJSgMUS7gJsQ5BqBpLrtY9X2pC4tzWAV/fp2PKzL7CxallKDHltXYWEFUkRUvT7KDewcYRvLY5RDZwuJInKQ5HP3N7HsbNuW8m5USntxoXC+wPvp4yXLXFDWbqZPUDdGIMOYdECuFZSVeFwKEP51JfL/doA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DU6ISjt6rufpXV2gJFoCUUf6TuCgfOm+DQ1il7Rgr1I=;
 b=RyEabREb7OPy3K7KfrVGWe08VS47L+B4FrYdufk0N3mrfOEZApqBXRtRNPiVQnhKy2aS8WLmDW9gn+xkJtlbhohNJvDJJcSfKLw/b6CoTLCLoGf+nsy3avsSII/NEJDyI5efQo8qWHz4rOZ91kqHoUc7VNppt0IoB9KRteL/IAOnDBbJRwdw8ScvhzSGuBTUtdyDajUyTJegtVrI8v3IVvhxIVDpjMEJm+DekduWI74+8WYCZt8w4UyvawpZU949WFsBOjTYbxm1FprdjigDxkxYNbBhU7140UdkoGqJ021dSjMYCdJU3JIgqTXQSxIeLcUH/Lo5WQKOBog7wCbSnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by PH0PR15MB4864.namprd15.prod.outlook.com (2603:10b6:510:c2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Tue, 29 Apr
 2025 21:27:18 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%3]) with mapi id 15.20.8678.028; Tue, 29 Apr 2025
 21:27:18 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "frank.li@vivo.com" <frank.li@vivo.com>,
        "glaubitz@physik.fu-berlin.de"
	<glaubitz@physik.fu-berlin.de>,
        "slava@dubeyko.com" <slava@dubeyko.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Thread-Topic: [EXTERNAL] [PATCH 1/2] hfsplus: fix to update ctime after rename
Thread-Index: AQHbuUCvMoIBkNVd7ka331jcjCdQj7O7KHWA
Date: Tue, 29 Apr 2025 21:27:18 +0000
Message-ID: <d865b68eca9ac7455829e38665bda05d3d0790b0.camel@ibm.com>
References: <20250429201517.101323-1-frank.li@vivo.com>
In-Reply-To: <20250429201517.101323-1-frank.li@vivo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|PH0PR15MB4864:EE_
x-ms-office365-filtering-correlation-id: a7cd8b60-1ab3-4b29-fd7d-08dd87649e74
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?d3ZJQmhMY3ZPVllBR0J6NEZlY1MvZEdadlpGZU9QVFBFUDIza2lWc0k1NXVr?=
 =?utf-8?B?Zm14cmx2dlNJWmxJU3lYSVVPTnNxWkpSakFoM0FUSWNjcnZ0SmJ5NHNpTFpS?=
 =?utf-8?B?dXlZRWRFc0N5d3ZjNFV2bTVGeHZaTVVHaFNRSndiQ0dDejJYMmVHLzdMdEhx?=
 =?utf-8?B?YWVUV0lDakljSDdESUNIOWE0Nk5qam0zYWNTWWNoMGZ1LzVrM3hXcXI1My9j?=
 =?utf-8?B?UmNhRU5FdmplWVoyUXVEbnE2Z0oxdjBYeXAzeG9ML3VYTUprbnNWQmVQN2tW?=
 =?utf-8?B?MytJQlZqMnY2alk0RGU5ZURHemsrOU4rU2xNRXVMaDREWmVxTVFzM2J2bW9G?=
 =?utf-8?B?MnpNRm5pR1FQbjlUTkxWdWUyRW9pMnhNd1dBTjdGRlNRQlh4eFdHVkRhMGE1?=
 =?utf-8?B?d2VtQzdMVnQ3SGhwUC93bmhjZytXRFdOR2NFZXVFU3F1MWJLbktjYUsrSlVs?=
 =?utf-8?B?cXh4RUM0bEdnVTRtUy9lZU1sZGd1ZVBMK29QcWFTb0k3REJTMUs5T2xOMkxP?=
 =?utf-8?B?VzBFVE9DY1htTGxvQWlKelQyU09nMlVhQnEyUzJ2NDN4TUQ5aHNjMUtWcVRW?=
 =?utf-8?B?S3owMmoxS3QwVG1XL0pSNTM1UEFZaTYzbHdyeFVUcmRrdUd3NW1VVnExWmlz?=
 =?utf-8?B?VVRQZC9LN203bGhONUhielBsOHNhUFdBckd1d1BoTGhUSm9BNGRNdlBNeTJw?=
 =?utf-8?B?MUVHQ3dXZzhzbGpQaUgzMUdldE1rdWwyWTFrK3FXMXlMSVBaR0dNZDZQcFVx?=
 =?utf-8?B?R0xKM3hlZlZJNFpBUWVZdHJVNk1HTUVBc2tReDVsbENxUnBWdHBwWUxRZmRJ?=
 =?utf-8?B?TWxhL3FqV2dxb2p6V01YYmZMMGVJdnJjYU15SkEyNk5MdFYyOG4rbSsvOVRL?=
 =?utf-8?B?eHdwcnk1c3hzdjEyQ2FwMDB5eWR5WWE3WVl1citMTUl6cit6WGE3T1ZqSzd2?=
 =?utf-8?B?SFJ2MlV3bjlONmUwdWR3NWN4Q1VNbkg2OUY0MjZNNlRSeVRZQTNzSExpbjA1?=
 =?utf-8?B?VVdHUmU5UDJaU1JRUmliUGFqMk91aWtWalFrZUxwSnEwRmFqL2lvUGI1b1Zj?=
 =?utf-8?B?ZTlGZEY3NFdnQWl1bU0xamtNTkMzL0daNHJTR1dFZlBReWhEbjUweXlsdXYw?=
 =?utf-8?B?ZHpTVlRIK3VmZTFUb2RERSt1c2EyS0lHektjOVN0VUJYNEt5Z0tyVHVSc1NV?=
 =?utf-8?B?Vk1MN0hUTGh1UGxta2pCMlc4endTNW9tSElMWW96OHR0Z2UvblVhRzVxQksx?=
 =?utf-8?B?eFdaTlQ5MG1OYS9SNEpmZmZXNXd5a3FPT3pEQ0tIZTE0QUpFcGp6Ukg1UkQy?=
 =?utf-8?B?NHc0QlVrZEljZHBBdVZWSEwweEI2TnZhY0xPSDIreHBENTZCaktsWk0xalVL?=
 =?utf-8?B?S1gzdGZZbDl5S2pHSkFRM0JmeWN5RHRkc2RTa0VQVHpIeDd4NEFjdUo4c0dL?=
 =?utf-8?B?dmNrZkEzODBScmZOVmRYY2dKQmY3QzNDSzNraG43M2xsa09BK09Vak9zbVUy?=
 =?utf-8?B?QW5mZVRQa2o1SXIyVFB0RGh0TUg1TTBGZDR6dE56Rkp1M1RraTJ6cVBaaFZ3?=
 =?utf-8?B?M2k3MytKMWkzcmlKTVp5RFpMdk5LbVB1QXVyOCtGUEFybkhpa1VPekZRSGRz?=
 =?utf-8?B?UnlNd1ZQeHgvRFJ3ckFadXk3dVh5SXpxVDJQcnIwWndpa2JHdVMxbm9wNnFs?=
 =?utf-8?B?a1BuY2xDSEpJRXJMT1JPNTI1ZzQ2d1dxclRkQUR4MU9BN3IyanhBZXcvcElz?=
 =?utf-8?B?aXBVc2hwR1BwdWZNREowZHlwRFJsRGcwZHdESjVNU0dxK0NiL3UzRGZ0d2x3?=
 =?utf-8?B?bWhyZXZqdlNYOFNxaEZ4SUtoVE9oYi9vOGRoR05ZUUllbHhHRWFSeTkvMXA2?=
 =?utf-8?B?ckpyNUVsWlkyZmtSMG9Zd0tscW5sKyt5a0Vybzh2WFpMUXJDeExtekdGb29G?=
 =?utf-8?B?b3VjSStLRHFFYSthTU9pTC9TNjA5UDk4c01iTEk2Zk5BRzhZdnl3WGtqQlV6?=
 =?utf-8?B?d2N4RExyTXhRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V1dVS3k2cHpRbGtEa2ZJeXlCV1F1b2JBOE52OFJMczY5bWVJUk1BWFE2ZGFM?=
 =?utf-8?B?UFFCMTIzQ1NyVmZwN0xtaldvUzJ3cUtYVmhPcEZUWllhR0RlZ29rRkxOVG9r?=
 =?utf-8?B?anRsd0tvRlF4b3ZpL3VSL08yODBwV284TkFFV3RjS1duMzUzV0lsT3BBckZB?=
 =?utf-8?B?Ty9MMWNEeG1rRWRRa0lSRWdFT3ZaQ3U5cjNGRUdYZ3RWMm1hSnMxUlZzdElq?=
 =?utf-8?B?R096T1l1WE1FZEpVclRrNDF1Mk5xS3NJWXRXdWduZlFNQlR6M040SmRmREVH?=
 =?utf-8?B?cUtMWldDa1Fkcml0d0FiZkkzdGNUV3FIOC90NmpJUGJ1Y3BQQS9lKzUzS01y?=
 =?utf-8?B?ZFlqRHQrZzZxRUxqUXJMYVM4MWl6NlZ0OXNaWFpLY2ZPNGx3QWVDalN0YUxH?=
 =?utf-8?B?M0M4K3U2eG56T3lrQVRBR0Z2VHlVeTFSRFR5QytKYVMvWDhZTHBzbXVwYTh2?=
 =?utf-8?B?L09XWVVDdlBHQXBQWmpoWU5iU0RXZzl2ellhQXZmNnNsYkV5WjlOYlFCc2xC?=
 =?utf-8?B?YmowdWpra09PSDA5UTBDckxPSGE2SXF6bFVVeHh1TU5xYVRkR1lRZExVM2gv?=
 =?utf-8?B?TG5NdWpFbDkrNFNEeW9oRGVvb1Q1ZEdIWmpvNUpKaVdTNlUwNVpIdmI0eDh1?=
 =?utf-8?B?Wll4bWt3SmFPQ0k4K3grN1QvTUlMVzBEMjZLSzhoTlhoc1hTcUo4N2xvMVFM?=
 =?utf-8?B?TC84SHIrb04xQWMzMUtQVGtLLzhQL0NaOXdYZEFOeDMrbEN3R0JBOWxETFpN?=
 =?utf-8?B?dnlUb3AySHlmVWVTNC9qK0c2bFJCb2hOOXVzd2Rod0k5a1ZRTGpaQndWajBV?=
 =?utf-8?B?ZEFjN1ZPYWVneCtoejRqWHBhdHVuSFZrYVJrYTFhUER4ZU9TL2Z4UnZLSWJ3?=
 =?utf-8?B?eUlHay9kMXBmT1ZES2NQd1FkTXI0V2RPMmFZQ1lCQzJveXorc0lrZGd5aDli?=
 =?utf-8?B?SGpBZkhHOXVldFFrSkZDeEpVQnBueEx2Qy8yVmNUT0dBYjBCa05CY0l4cFRm?=
 =?utf-8?B?N2hXSEgvNVk1ZVRWaXUvMk4xNytIMWs0Ukxxd3E4czdWcVcxWklsalVkQk1h?=
 =?utf-8?B?dE1WNHZXSldkQW9Od0pyUlJKd0I0a2pwK3NSWHN2eHNvUDFQTVIzdjZnQmxt?=
 =?utf-8?B?ZzJHSjVqclN0Zm5QNlRMWm1vcUw2TXpCZWlYUTJlQmZneTNnbGpEQmt6bk1a?=
 =?utf-8?B?YjdibC9qSVRYU1g0MWhmWXd6Unk4UUlUZDNYQy9DRHRpTEd3Ujk5VUpkUjZK?=
 =?utf-8?B?MlFMRkg2bEpOQXRnWTkyWEQ1S2NwUlNPaUJHZjMrVVFJclNRWFE0Ly8veVln?=
 =?utf-8?B?MW1qa1EyL2haa0duYmg1K3VBYVl4SWhEVWRjdkRPTXZzeVVqWkdPcDFqUkRO?=
 =?utf-8?B?ejRxNTY2N1p3bks3UXVIbjF6Q2U4UzlyUlhaMFpMdlNZRnd2ellQdXRvWGdC?=
 =?utf-8?B?LzN2enBxZG1sd1E1SzBWRktDTWZvZHVBQTJrZEg2U2VyTldHNDBLRFl4U3RO?=
 =?utf-8?B?L2Q0ZkNuR1g1S0xDODhOZ20xbVpESk4rOC91K0RLRGt2cEpqdTJEdmx1Tlo4?=
 =?utf-8?B?RXZWc2lJZWFMVWE4bVNIWk4zSVFaMnJVNEhLb2s2a0N2a2lTNWdNc3pja2J3?=
 =?utf-8?B?WnMzUndoVitRMG5jWmlzYnJjSGtHQ2VuTFRkMzl5UysvQ2cwWU1xaVVGbmJT?=
 =?utf-8?B?UkhZdFRNRnlJVEJtNm4xd3pncmZOTmRLb0lSMkpGR3Q3UStJWDRkd3RJV3hJ?=
 =?utf-8?B?Q0dHZkFZZldnanF2NWl1akIrdWpTa0xacmZva2tOdG5OQ1RwSU1QQXE0aU83?=
 =?utf-8?B?MTdPUW9RbFMxRE9WRm5IUVhSVFdGeitydlVReEZFSjVpVldud05SdnJHUUQy?=
 =?utf-8?B?TTk3TWYxd25vU2ZmbklRdStpZkZ2SzFjaTdrMW9vL2crM2VGMi9SYU01R3F1?=
 =?utf-8?B?OWFtL2N5eWhocGVnd25paUQrTi9BWDZkL1YrbUZHaTJRYXkrbWhsOGdhbEpp?=
 =?utf-8?B?cENBRHUvSGZNTGlzRUthWm40ck9PZFdVRUt4VWUrOGVpTXFzRU9XRExlT0Fq?=
 =?utf-8?B?QmdMME12eWIxbG9oWitUaW80UUhhTGt6R0VHVnRkK3owaU9NaEdlaWN3bkZM?=
 =?utf-8?B?V2Zwd0lpY2w5WW1kRlBpRTJTM2tjVnF5MjhUQ3Y0OWwvNDlZVjdpazI1RE5u?=
 =?utf-8?Q?7s+uByxL0EZV416Y9nWDSBg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0E41D41474D1A3409170D31C277D5350@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a7cd8b60-1ab3-4b29-fd7d-08dd87649e74
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2025 21:27:18.1359
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EysWqW7PF3v1Vhy29MBaAGgagWRWZI4ScfMeZZYXgnBemqOK68pdoOLqK8nwQd+GP6+eeOfron7Or8NbxWXuog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4864
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI5MDE1NiBTYWx0ZWRfX0m+TqHwPyVX0 /ClZptfnVwom7r5K+3WrXs8wc0ksIZkBaogoushsrnxh6r4tU2sxyeiJE3UpdNLNcmJutU3Nmnd s0EnXVoytW/+fqQ8Ca3s2bzUopaH3i956CB+/RhYZup5VWzeDvPGEFbBkcmmqhSL59lk544yg8b
 ryKoFEzA1Eah4flyzpMzoLjixZFMy4aMD8DX2Zxvyp7g3k8TecBD5FXe2b4pMWEwFzEuZT5Xdtb /lu77P4+xMUU2Dgz43yU8DNx1iKm9qyru/4nIAfpYndM8PVpcXLChdI8/n0RWUbbuZKzGGitoPt MrUt7W7mrVuPEEo8VGrmHPsQfze8/FQOnAcSE5F17WbLFxNtVbi+3UwpdBgsQMIlpfPTKA2/ttS
 GTimoZTnHmDg9AUhF20mGQa25L87UDbnszUwL3FycsiyBhfYjLzz4BxC+okHiVbbKrzgLudd
X-Proofpoint-GUID: 0fiyg81A4Ac93HL0phdpTk527ka7nU1U
X-Authority-Analysis: v=2.4 cv=MJRgmNZl c=1 sm=1 tr=0 ts=68114438 cx=c_pps a=CSNy8/ODUcREoDexjutt+g==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=XR8D0OoHHMoA:10 a=1WtWmnkvAAAA:8 a=8VAGL0tb3FcyTf3Cz3YA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 0fiyg81A4Ac93HL0phdpTk527ka7nU1U
Subject: Re:  [PATCH 1/2] hfsplus: fix to update ctime after rename
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-29_08,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 phishscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504290156

T24gVHVlLCAyMDI1LTA0LTI5IGF0IDE0OjE1IC0wNjAwLCBZYW5ndGFvIExpIHdyb3RlOg0KPiBb
QlVHXQ0KPiAkIHN1ZG8gLi9jaGVjayBnZW5lcmljLzAwMw0KPiBGU1RZUCAgICAgICAgIC0tIGhm
c3BsdXMNCj4gUExBVEZPUk0gICAgICAtLSBMaW51eC94ODZfNjQgZ3JhcGhpYyA2LjguMC01OC1n
ZW5lcmljICM2MH4yMi4wNC4xLVVidW50dQ0KPiBNS0ZTX09QVElPTlMgIC0tIC9kZXYvbG9vcDI5
DQo+IE1PVU5UX09QVElPTlMgLS0gL2Rldi9sb29wMjkgL21udC9zY3JhdGNoDQo+IA0KPiBnZW5l
cmljLzAwMyAgICAgICAtIG91dHB1dCBtaXNtYXRjaA0KPiAgICAgLS0tIHRlc3RzL2dlbmVyaWMv
MDAzLm91dCAgIDIwMjUtMDQtMjcgMDg6NDk6MzkuODc2OTQ1MzIzIC0wNjAwDQo+ICAgICArKysg
L2hvbWUvZ3JhcGhpYy9mcy94ZnN0ZXN0cy1kZXYvcmVzdWx0cy8vZ2VuZXJpYy8wMDMub3V0LmJh
ZA0KPiANCj4gICAgICBRQSBvdXRwdXQgY3JlYXRlZCBieSAwMDMNCj4gICAgICtFUlJPUjogY2hh
bmdlIHRpbWUgaGFzIG5vdCBiZWVuIHVwZGF0ZWQgYWZ0ZXIgY2hhbmdpbmcgZmlsZTENCj4gICAg
ICBTaWxlbmNlIGlzIGdvbGRlbg0KPiAgICAgLi4uDQo+IA0KPiBSYW46IGdlbmVyaWMvMDAzDQo+
IEZhaWx1cmVzOiBnZW5lcmljLzAwMw0KPiBGYWlsZWQgMSBvZiAxIHRlc3RzDQo+IA0KPiBbQ0FV
U0VdDQo+IGNoYW5nZSB0aW1lIGhhcyBub3QgYmVlbiB1cGRhdGVkIGFmdGVyIGNoYW5naW5nIGZp
bGUxDQo+IA0KPiBbRklYXQ0KPiBVcGRhdGUgZmlsZSBjdGltZSBhZnRlciByZW5hbWUgaW4gaGZz
cGx1c19yZW5hbWUoKS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFlhbmd0YW8gTGkgPGZyYW5rLmxp
QHZpdm8uY29tPg0KPiAtLS0NCj4gIGZzL2hmc3BsdXMvZGlyLmMgfCAxMSArKysrKysrKy0tLQ0K
PiAgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gDQo+
IGRpZmYgLS1naXQgYS9mcy9oZnNwbHVzL2Rpci5jIGIvZnMvaGZzcGx1cy9kaXIuYw0KPiBpbmRl
eCA4NzZiYmI4MGZiNGQuLmU3Nzk0MjQ0MDI0MCAxMDA2NDQNCj4gLS0tIGEvZnMvaGZzcGx1cy9k
aXIuYw0KPiArKysgYi9mcy9oZnNwbHVzL2Rpci5jDQo+IEBAIC01MzQsNiArNTM0LDcgQEAgc3Rh
dGljIGludCBoZnNwbHVzX3JlbmFtZShzdHJ1Y3QgbW50X2lkbWFwICppZG1hcCwNCj4gIAkJCSAg
c3RydWN0IGlub2RlICpuZXdfZGlyLCBzdHJ1Y3QgZGVudHJ5ICpuZXdfZGVudHJ5LA0KPiAgCQkJ
ICB1bnNpZ25lZCBpbnQgZmxhZ3MpDQo+ICB7DQoNClVuZm9ydHVuYXRlbHksIEkgYW0gdW5hYmxl
IHRvIGFwcGx5IHlvdSBwYXRjaC4gSW4gNi4xNS1yYzQgd2UgaGF2ZSBhbHJlYWR5Og0KDQpzdGF0
aWMgaW50IGhmc3BsdXNfcmVuYW1lKHN0cnVjdCBtbnRfaWRtYXAgKmlkbWFwLA0KCQkJICBzdHJ1
Y3QgaW5vZGUgKm9sZF9kaXIsIHN0cnVjdCBkZW50cnkgKm9sZF9kZW50cnksDQoJCQkgIHN0cnVj
dCBpbm9kZSAqbmV3X2Rpciwgc3RydWN0IGRlbnRyeSAqbmV3X2RlbnRyeSwNCgkJCSAgdW5zaWdu
ZWQgaW50IGZsYWdzKQ0KDQpDb3VsZCB5b3UgcGxlYXNlIHByZXBhcmUgdGhlIHBhdGNoIGZvciBs
YXRlc3Qgc3RhdGUgb2YgdGhlIGtlcm5lbCB0cmVlPw0KDQpUaGFua3MsDQpTbGF2YS4NCg0K

