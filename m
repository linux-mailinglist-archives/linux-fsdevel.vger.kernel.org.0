Return-Path: <linux-fsdevel+bounces-41742-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A44EAA364AE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 18:36:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F07673AC5D2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 17:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A712268C69;
	Fri, 14 Feb 2025 17:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VAeNlumq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323DE264FA7;
	Fri, 14 Feb 2025 17:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739554585; cv=fail; b=Xcqb0AyDW9hKaxMCD+NpXQvIiVXJrKI258yoR8DKr3wctfvCkAo2aEJRgEimxircCPXsTQ8DcQ8sUTNP89BdC84w0U7/uUduZcrQ4saHfFiZUo2o4TjlerXffEhTiesnqB8ijyfTgg+Fz0ajjcGghqBhMlBhr+tEk1Q6tnLQmxI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739554585; c=relaxed/simple;
	bh=Af1S1miNl/WkEmhl7YfrsO4TYVXPSpZ5pHY+sjZ31cY=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=FYnGKUrrSksDGXootdisGYQfnzrxbQI7UNMj2K1hvylPldDVR48Vy7tk3hqElmUw5TK8kw1bAZPxplGBP+Cxf1FwSz/NO1fRAarrcNZ37gVCcdH9q81j072Yf0QkZSv1565PeP777cZnW4HhtwIsLgrcLWcUyBVUlCAEBJsWLsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VAeNlumq; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51E9XjZf000657;
	Fri, 14 Feb 2025 17:36:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=Af1S1miNl/WkEmhl7YfrsO4TYVXPSpZ5pHY+sjZ31cY=; b=VAeNlumq
	sGdC5NSwLwqJi4bAJlMW60xvxKQis/0MzNyvfe1MgAST+9QF3PD6HtMGqh9PxgfY
	MHJlSPOrJpMXo5OvT09bFVI9XcvwVQ9wLVxiqpT1kSpCF2KcRwOXBLpCEEKhIdPq
	UTW4SKY/sDekN8R6/zATY6arW9o3ZCEAnqFsYIjgwBSTjzuO0qxUlGYQBvZjhK6z
	2xOpw30jKbhoDNkQjsUUlXiBoZ0WNj062HTurQyjyE4tlVXwirww5GfM/1qb4PEJ
	JCH5aUUdEaQYU0+38NnFpNq1GNJO1Spkx9ynh8zn9DztUahcgeIhMrcUQE+FTvny
	CFDsnzZtR/bWBQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44ssvacqta-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Feb 2025 17:36:20 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51EHTuI9026848;
	Fri, 14 Feb 2025 17:36:19 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2049.outbound.protection.outlook.com [104.47.74.49])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44ssvacqt7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Feb 2025 17:36:19 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fdwo0oSXQsRKwKip2O77msNYDX+Tk0xRmVqpR9UDhAwayefY4uTkLPQ8gnxCZIW3RSXHOj9+K2WgTKm4RUXxGhQrxY5tNOegHx3wzPIrJLo7GGi4zRbrJl6jD1J9c2P/GTigzFoN+Y/PYx18vjnmAnlho//ch826yk3wBg6st4EEf4h8p55kF7twNLb/KACkN5QdKMIy4vuLtLBi29ehlI4D+JBJCfxm/iOlQsTkd88uVzL8YWm1B5u+gy3Nl1wYYKY3n5Dh+LwBE0CxVwjXuV+sWCUsqDQSbqAJpreEVQU398yzzrHTmhMZWIxTZhCEirVRpYoPXiAM9K9MpBDvvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Af1S1miNl/WkEmhl7YfrsO4TYVXPSpZ5pHY+sjZ31cY=;
 b=bEhrzbobzfbl7oJiysv0nE25+lTyqfmUre3kAvSjJul5uItHNEcucBB0bhRHug6PSnaTCbAUL6lDPr9ZAxLQclRxy93M7U1k09kS8pv0COhfADLm5JT169WIpYu2zprT9f1iI71u2QlFEMs3m/mnMHczXN77HATqTUXhmezz3fKQBaiIAzw3aCzCfTWV37nXGLBfV5k/vsBI6ml1BQvs3hFg1jRhTRsEsMOL7zmvSgNZnWhnaUVah3HZyYXY1muEmVBoz87U4/mDb5+q2O0qKJONdZiMnI1Tb67GrsgZzJvF0UueDqcq3/0y27+nMZicKV1iICI1R8tCrXyC5oGPiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by DS1PR15MB6592.namprd15.prod.outlook.com (2603:10b6:8:1e4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Fri, 14 Feb
 2025 17:36:17 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%4]) with mapi id 15.20.8445.016; Fri, 14 Feb 2025
 17:36:17 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "slava@dubeyko.com" <slava@dubeyko.com>,
        David Howells
	<dhowells@redhat.com>
CC: Alex Markuze <amarkuze@redhat.com>,
        "ceph-devel@vger.kernel.org"
	<ceph-devel@vger.kernel.org>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Patrick
 Donnelly <pdonnell@redhat.com>
Thread-Topic: [EXTERNAL] Re: [RFC PATCH 0/4] ceph: fix generic/421 test
 failure
Thread-Index: AQHbfwSitHI2EkU8vkKyDr1N+60bsbNHD9oA
Date: Fri, 14 Feb 2025 17:36:17 +0000
Message-ID: <4e993d6ebadba1ed04261fd5590d439f382ca226.camel@ibm.com>
References: <20250205000249.123054-1-slava@dubeyko.com>
		 <4153980.1739553567@warthog.procyon.org.uk>
In-Reply-To: <4153980.1739553567@warthog.procyon.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|DS1PR15MB6592:EE_
x-ms-office365-filtering-correlation-id: b2c8cd89-27a2-48ec-2534-08dd4d1e1654
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?eHpJb0E0a2NibmJRWm1sdmVHZ0Z1dGIxSGJLT3UxVDJ6bXdMQUNLOGl1eE5Q?=
 =?utf-8?B?V2VrcVRLOUEyYXpEOGJ5NjJzL2o5SVpXWTI0NTdtUTBnbTdmMnJ2T091bTMw?=
 =?utf-8?B?KzBxaDZKcXVRRk9KdUJBekZHUWg5elBHV1FZUjdwSzdPSzJHZ2pvWFJXYm5V?=
 =?utf-8?B?WFpmMnYyQnJ4SldXazg4SkRLeGtJMS9GRGxWcXFHMFd6WFVSRFEyRWZYNlRK?=
 =?utf-8?B?b1hsVnZiNkE4L0VaSmc3dFBzZWEyWnVHdmNoVURSd3k2citvSGpubDJLN1Ba?=
 =?utf-8?B?Mm1PcS9BY3FFZ01PV2J3Vm9sMEVmdytzYWx3V3BuMWZpanZWU0ovK3pMN1dt?=
 =?utf-8?B?QUxxQWh0emZMQ2pjbjZMbC9NaFJOcGJyOGRuS0dwSzV5UWFVd0RLZzBUU2M3?=
 =?utf-8?B?OFFLM1BvcGdjckJaQng5MmI2dTNRd3J5OXV3ZUloY0RaT2Vhay92SmpleGY2?=
 =?utf-8?B?YXZ3SlB2MG4rc2RWS2g2RFgraWZMQkY5d2lWRkpXV3h1WWN0NkJlc0FaNkY1?=
 =?utf-8?B?MncvbTAxVWZrRER2bTZST1NheHUxbjRIQ3gzQ0RTeTBNajRnd2J2ZlhiNE5U?=
 =?utf-8?B?VE9RRDNtbXgwQmZQcGZBK1V3M1FlWC9FaUQzZERPWlk5L1gxazJNQ21raEk1?=
 =?utf-8?B?SXhBa1pOL0VYRGt2Q251ZSs5ZDVYc1hrTzNsRDcvLzUyeGlhTWgzYmxoQ1lh?=
 =?utf-8?B?Ui8wdWMxaFk1c2RvcmEwVXFVL3BvUDA0bHA0WGlRdWN4T2VITFcxUWR6QkRE?=
 =?utf-8?B?eFdYYjRrR3lQTENiYm9TQmgvUVZOaWhEVzUvUHY4Q2w2d1V4TFBRTkxxLzRN?=
 =?utf-8?B?QTdQSlh6RHpibFJRUWtKN2Y1ZFV3TWdqWmVPVG9DTk9zOVliS3l4blpTZk9X?=
 =?utf-8?B?d00vdmhiSFdFM0dNRjRKQXZ6anFTbGI0SUYwWVMwNFBSV1RkMUFyeVVDMDYv?=
 =?utf-8?B?K1p0MFFKanc4Qk5UdE1VbmJlVVBRbVZsVHRuRVU1MTRROHVKb1pFOTVhS1Qv?=
 =?utf-8?B?dGdsdnVRRUdxMFhXaDk2OXkvVzhiUnZENHVxazZkbkQxd0IwOERIakpZVGM3?=
 =?utf-8?B?RDZJRGlPTTE3RjhYUGJKb3hjL25ZRW4vRVR0dkNQRmhNWlRKWWloZ0VSQkRv?=
 =?utf-8?B?NGhwaHRDamhFWXh2azdpOFdoYnpBTjU2cXBNQjlRd3UraUFtUzVqOFIyc2lO?=
 =?utf-8?B?MTFlSzBZUG1WN2diaG0xbWxOVzVkVElqMFhLUFRudFN4WGh4VmwveTY4Qlhx?=
 =?utf-8?B?RzdYNzlJMGpaeXVYZlBjLytFcXM4WFE0ZlpjYnRxcjZoUjlDa3RoN09ZQ29n?=
 =?utf-8?B?M0ZGVWVqQ0tDeHd0MEQvWHRKZVZ6eG1BWVc3clBZZFFHcEd1Um4zVWtQTllu?=
 =?utf-8?B?dmIrOVZ4TGlTY2hsdk1TWGVUSXliakJRNTdjc1YrWkRMSVdZMll5TU9pUjZu?=
 =?utf-8?B?clRUbmxiUzgzK3cyMDhpWUVHUDNmVW1PVGFXQTdkN1NRekN4QmpCTldnQWZU?=
 =?utf-8?B?S3hLbGt6bVkxeGZSNWtnNllJeE5weWdQbVk0RVhNVlhCL09oRitsZExZdEZu?=
 =?utf-8?B?dlp0TnN6QWU0ODR6ODVTMVhqV2oyM3pvajEzS2gzQjlHUlRWK0RrVWUwaDRR?=
 =?utf-8?B?Mmd2TDVpSWpqY2Z6MTBmMWZyVDZzc2Q4YUt3VzF0cW9KRUR6SlFJbkpLS2Fm?=
 =?utf-8?B?UW16QTdudWNGc2gweCtRR1RFOEVqWjJPQlhvY2IyTlpOYURPTzgyRDcrUk9O?=
 =?utf-8?B?eFlLczRqS3ZvOU5CYWowOTN2SVhvOE1KUkdQeVZmZUp1TmgvWXZyNWc2Rklm?=
 =?utf-8?B?eG42MzE0MXc2RU9MZjZudC9QcHJvK1l1STZiNURsN3BWV05mbnZDb1h6VkdS?=
 =?utf-8?B?a2poWUJyWTlOMlRab09jOTZqQU1RUFVvRElnSFNUSS9DMGc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?S2xGaTZkUTU3L3E1aDRISnUwWitmU013Tm5lZVRFUVJRZHdqR0tFbS9NV1c3?=
 =?utf-8?B?dndvZHliM3RDS1FtZUt3YUxuZTNtNWljNitWTzUrZGdBSGNYODM1T1lqWUZF?=
 =?utf-8?B?SlNhRGFKS3NlVHZYc2tzVUtsS0JmUGZCS21qeXZUVkFzZzBablBJZ1k0cnIx?=
 =?utf-8?B?UkxOSGNnMDUwWEZacEJsQlV5QlNVbTBEcGxzc25memRVMmk0K2VDSEZuZUh2?=
 =?utf-8?B?Nm9zS0ZKcGxqN1JaOFVtVlRIamFuT0YvbWJ2NlI4VGdiTnM0a3FLWllYbHBM?=
 =?utf-8?B?NTBkY3hXOWMybzJlVWwvbUVuekdHN2hwNFgxVkhlMVBRUlJ4aXRqNE02a01y?=
 =?utf-8?B?czNUTGlTM2FMUU9WMTNJMFJodjkraHdtdVJnQ0VaOTBONEFUU2t2cnc3U0l0?=
 =?utf-8?B?SitKT095SnBrVkhIOFFiRTdONEZ1NkVTUjRsNDNSLzBEK1MvOTd0Mm9GWUVL?=
 =?utf-8?B?K1E3eDJEZURHZTdpWVgwRFhscmlaVE9yRXgyZm4yc3pBZnNjM0xHL1kvUloz?=
 =?utf-8?B?SHlqMGZLR0swbjZic0FWbGdiYzhLTUZPMGhvMWxlcEltMjdPRWdKbUVua3VB?=
 =?utf-8?B?RC82OTNobWpLMFlBTnpYQjdvNlBvazhBZkxLQ1l2cGhucUU5d2lJQ1pPbWNQ?=
 =?utf-8?B?WlU3aWJCa3hhV05oOGlpK1N4empoS1F5MG9GNFJLdHZWYytVUUpyTDZ5ek1I?=
 =?utf-8?B?Sy95eXJ5a04xY0U4bEpwbk5lNHgxZGJQV1FiR3lmVGlOZWhLc0hIUTJLS0Jo?=
 =?utf-8?B?bnZ5L3RHbzNtN2gvL21YZVR1NnU0bUhnZlYxMDU4TzFWc2hKK1AvdFpkemVS?=
 =?utf-8?B?YkYxUnBtSXRDb2VaSjUrTEhhWlM1dWdwSWFyU3dzVDFDTFRuMi91N1ZGSFcr?=
 =?utf-8?B?RGlWWjV5RXpKdElDVnZhaEM5ZlZSYzJER3ZYbnYxL3JISktJanVjdzNneE9t?=
 =?utf-8?B?VmVnL2pJTm1TalpzTWdpQUY3RDltYncydHVhRGxlYTlVTmJJWUZvc0IwMklK?=
 =?utf-8?B?bEtpNVgyWW93S1BKV2l3dzYzand0TEdERWlvTGNacWVqaEREMlZpeWUzZVM3?=
 =?utf-8?B?L2VzYS9Td0l2bTJZWDVxejVYeUtHZTc1V0RRRXVUaUZJRDlMQXZMWG1GWGpn?=
 =?utf-8?B?VzJudGJuNlRZYURGdTF0SW5LbjErUzRtZXNBWG14N0FnaS9uYms0dnhnM1k0?=
 =?utf-8?B?VlppRjZrTnNNMFBoU2p5NnFSbjl3YUVXa0RqMktFRUJGQ2I1Ujd0MG90cnU2?=
 =?utf-8?B?WUxzOFhZbUZlV0V0Q1JXckpoeWZJWENCT3lMRGx3bEdXSVMxa2c4Wm9ZU0JV?=
 =?utf-8?B?RzhiaWR1RHNzSXEwaTlHbUFnWGd5MUF2UjhtN1VhWVJHRVo4WU5BWVNQbGlw?=
 =?utf-8?B?TjcwUnVaRXVIVXJDdHdsWkk2UXVuNXpScEhBbk9DYnAvVnlRYzdpOStMQjUy?=
 =?utf-8?B?cUhRTkt1RUJaenBOZjljcnJRTXBVTUZ3b1REWUxIRUR0WE84QUVSWHR3Q2Ft?=
 =?utf-8?B?eHFuc2k4dUUxSDUyMDU1NUxVZWI5dHB2ai9sRU9xTmdCOVp1ZkhyWGVGdGFG?=
 =?utf-8?B?ZE1WOXlqOHppQjNTT1BSNGlJNUUzSzBBdTFQOUM2bnRESCtqci82MXpqWlh6?=
 =?utf-8?B?THZWUEg2am1wQWpNWUJiaTIvOForK0IrOVJDYy9pcTErQ2ZhQjErQTZ2ZlB5?=
 =?utf-8?B?KytnZ0ZKb1duQURWTnJnZ0I3QTlLTWJUOVpYcTU2ZFBGL3V3bGoveGtOZmV3?=
 =?utf-8?B?cjdsK2VOY2htYkhDUEdUQ2Rwei9la2wrWEgzd1AzNUx3RDN1WGRVZ1ErNkJ4?=
 =?utf-8?B?bjZadnJhL2VkY3lYVDNTbHRwd29xWkVxSjU1MFVBVi80Si9XeTZ3clFZbzFW?=
 =?utf-8?B?VkxQQmYyNHZmVFBtWWRqcUxzT3F5WHhDMXUxU2dTVHpkQ1JHdzBvNTVOWU5a?=
 =?utf-8?B?WTgwaFBVWTZ2VmVhNzZ5WE1ibm5sWDNVZ1pGM3M2bU45VDVza0VMUUdMVjRJ?=
 =?utf-8?B?bXZ2VHBNK3M1VXVEekJzWHRYRWxXTGV0RlZkeXNBQWllMnFBb2hCNWQvNkE2?=
 =?utf-8?B?V2VYSnFFSk4vWVVnOWdrZGhoVWxqOFZSYzF6ZEw5R29VaC82ZnBKNWN2RTZl?=
 =?utf-8?B?VG1teVM2d3g0U1d6YUJYS1ZZMFoxdlhhS0tiUUVuUlIzVVNCSjYycSt3ZFM5?=
 =?utf-8?Q?fT8SG7sA4MDI3ECtdmL+vUU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3CC0BD7A66464B46AD22325C057A1690@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b2c8cd89-27a2-48ec-2534-08dd4d1e1654
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2025 17:36:17.4879
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jx0UC+Jm0FfLVvfqymi2hH8aAZTQPhuXph1DrMtgCh23g87tc5lPvWpKUBlxgB5tdOwcfIa6a1SgWqhd96Gwww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR15MB6592
X-Proofpoint-GUID: uOsjuKlTlh0CxCfEXGPNsqqoYr74TJXX
X-Proofpoint-ORIG-GUID: cAyn8vshlSMeqMnNmi4bC2izsZK5nc3m
Subject: RE: [RFC PATCH 0/4] ceph: fix generic/421 test failure
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-14_07,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 mlxscore=0 spamscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 impostorscore=0 mlxlogscore=971 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2501170000 definitions=main-2502140121

T24gRnJpLCAyMDI1LTAyLTE0IGF0IDE3OjE5ICswMDAwLCBEYXZpZCBIb3dlbGxzIHdyb3RlOg0K
PiBPa2F5Li4uICAgSSAqdGhpbmsqIHRoYXQgZml4ZXMgdGhlIGhhbmcuICBUaGVyZSB3YXMgb25l
IGNhc2Ugd2hlcmUgSSBzYXcgdGhlDQo+IGhhbmcsIGJ1dCBJJ20gbm90IHN1cmUgdGhhdCBJIGhh
ZCB5b3VyIHBhdGNoZXMgYXBwbGllZCBvciB3aGV0aGVyIEknZCBtYW5hZ2VkDQo+IHRvIGJvb3Qg
dGhlIHByZXZpb3VzIGtlcm5lbCB0aGF0IGRpZG4ndC4NCj4gDQo+IFNvLCBqdXN0IHdpdGggcmVz
cGVjdCB0byBmaXhpbmcgdGhlIGhhbmc6DQo+IA0KPiAJVGVzdGVkLWJ5OiBEYXZpZCBIb3dlbGxz
IDxkaG93ZWxsc0ByZWRoYXQuY29tPg0KPiANCj4gVGhlcmUncyBzdGlsbCB0aGUgaXNzdWUgb2Yg
ZW5jcnlwdGVkIGZpbGVuYW1lcyBvY2Nhc2lvbmFsbHkgc2hvd2luZyB0aHJvdWdoDQo+IHdoaWNo
IGdlbmVyaWMvMzk3IGlzIHNob3dpbmcgdXAgLSBidXQgSSBkb24ndCB0aGluayB5b3VyIHBhdGNo
ZXMgaGVyZSBmaXgNCj4gdGhhdCwgcmlnaHQ/DQo+IA0KDQpUaGlzIHBhdGNoc2V0IGRvZXNuJ3Qg
Zml4IHRoZSBnZW5lcmljLzM5NyBpc3N1ZS4gSSBzZW50IGFub3RoZXIgcGF0Y2ggKFtQQVRDSA0K
djJdIGNlcGg6IEZpeCBrZXJuZWwgY3Jhc2ggaW4gZ2VuZXJpYy8zOTcgdGVzdCkgWzFdIGJlZm9y
ZSB0aGlzIG9uZSB3aXRoIHRoZQ0KZml4Lg0KDQpUaGFua3MsDQpTbGF2YS4NCg0KWzFdDQpodHRw
czovL2xvcmUua2VybmVsLm9yZy9hbGwvQ0FPOGEyU2pyREw1VHFXNzBQM3l5cXY4WC1CNWpmUVJn
LWVNVHM5TmJudHI4PU13Ym9nQG1haWwuZ21haWwuY29tL1QvDQoNCg==

