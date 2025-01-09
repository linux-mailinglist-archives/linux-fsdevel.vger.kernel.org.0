Return-Path: <linux-fsdevel+bounces-38688-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D34BA06A0E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 01:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B90F1887885
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 00:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7AC5846F;
	Thu,  9 Jan 2025 00:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YH0r4Gqf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10CE28F4;
	Thu,  9 Jan 2025 00:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736384067; cv=fail; b=mvojL7RXskI/iJnAwhj298ZzmJd7EilMh9Aj1yWonl/c5xwnMFNKaisSRLY/mGQTcxMaw+uo9lH+0f4A+YXbKyhxOe8IwcN9FlNxLEooZGlm6TRJzcqQXLvD1BuX5bJ79T348r7EBwQOKMbZ8BVKhapIoOGnDGRNi5wySGl3RGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736384067; c=relaxed/simple;
	bh=WCEsZDoqPx8MkYiV2138e9jb4qct129gmCHrEFWQvgY=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=JsguRCKE3eLv8V2EufK/91fcPEcpRv7VAt5xsUa6dBi8EvXt+jYgP7MO6DF3cY9IUQf8H/OtY0hvAhJtvshwp9aKuLN+wod1vrtW9kpB7cLhS44WqbHjwEhpbydpHnG4yEwhyEKXuAGvyLHg1seDG4TwDJy3NWxdXzM5CXFYAVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YH0r4Gqf; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 508EjJfO015896;
	Thu, 9 Jan 2025 00:53:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=WCEsZDoqPx8MkYiV2138e9jb4qct129gmCHrEFWQvgY=; b=YH0r4Gqf
	jKUHPUigSunKzIL7JD7mt1D8cLIuRr6IcIf9oLwG1h0wsqAavmI8J78CjsikWULN
	hhkVJ+PJ8M4VWLjLwdyB/mCg4pcOnphGFxjhnl0N0Cvr2gnElZe+dksws1ANsXV9
	VNNY9qLeUy5+3P+CHIdM+M+cbDw+zFsyg+8OYBdXWKeq3xgedJRGwcixN7eT0Yno
	c1tRoR742J0cR7n2TWGkJKaRs7CikGD83l9KDlGO8iB5V+UJE5B+RfKJwzV4Zp08
	zWmqbM+aNl7ef5kxt5kFMLYBRvV9Mo8cfLdyJzDav1g/xUSGboUhTgK1hXiWwXpW
	BrItF4CCD7PRAw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 441huc5ajw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jan 2025 00:53:21 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 5090gMQF029486;
	Thu, 9 Jan 2025 00:53:21 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 441huc5ajt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jan 2025 00:53:21 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C17dXSQMeE9i/jiWVFe2pKPG9YQfx0HQWddP1RStGtC67IK/dKCMRvErywTUpECtSzZG6eJ3YqAKUlnIr+k0jsKWJazRpAX7x6GSDko4ca69egIXF06xj+j5LLuWwb9t7pRTiMVgU2yhNjdB6U9GqUeCdoiSTvwUEI8Pjge0wW0KjfeoX4+rD9T6iDDu/pRLSNE6nDmX3/54JdkDpfWhVy81YytMm39DGZrcvPl9Y2NRjRiu8vsaihz1NU0YjGvCxZXxQ76U2i6Vegbx4wQrQRM09fCzeVXwSPNrIt6NKk+PpX4Agd2AC52HKNuKamgRSP243gerBgKgRjnSrLLczw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WCEsZDoqPx8MkYiV2138e9jb4qct129gmCHrEFWQvgY=;
 b=aoacNn7NgK862Tb5pLlR98fmKue1Px9qBtN3eXioTyHlEaiCtdpLciUn5zlh6ji1oclMnJgAJPLrF4C1zHdukazbVhISAjwPgx3WnDhzgMBiGntJaq8pZaw4T2lJPS8leKeRgGjj/+SsRmVr3YUX/J47oKHkfv+0pqdr4tG2buzyfQ3ClKowaR/nFPIfpWxSLDy1mnNenWOxAhxt4UOS2MpxgFzwxdlM0lFi01yBUrUVRiIruseQy9aRGrCUiFhY7NqyNqDzWtH4gB8pukaIkHUkSkDzhDwHi82Wo7+7NXSbw2caXU8JrXWLY/d+W0BvPIBFG4JEiu+a7XtBpqZp0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by MW4PR15MB5182.namprd15.prod.outlook.com (2603:10b6:303:186::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Thu, 9 Jan
 2025 00:53:19 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%7]) with mapi id 15.20.8314.015; Thu, 9 Jan 2025
 00:53:19 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "willy@infradead.org" <willy@infradead.org>
CC: Xiubo Li <xiubli@redhat.com>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "ceph-devel@vger.kernel.org"
	<ceph-devel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        "netfs@lists.linux.dev" <netfs@lists.linux.dev>,
        Alex Markuze
	<amarkuze@redhat.com>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "idryomov@gmail.com" <idryomov@gmail.com>
Thread-Topic: [EXTERNAL] Re: Ceph and Netfslib
Thread-Index: AQHbUYXLTU7JxE5eTkerRf23TGd+kLL0fZYAgADl+oCAGFsiAA==
Date: Thu, 9 Jan 2025 00:53:18 +0000
Message-ID: <01486f0a36164e9e3bb774adc40bebf9dcdc5e94.camel@ibm.com>
References: <1729f4bf15110c97e0b0590fc715d0837b9ae131.camel@ibm.com>
	 <3989572.1734546794@warthog.procyon.org.uk>
	 <3992139.1734551286@warthog.procyon.org.uk>
	 <690826facef0310d7f44cf522deeed979b6ff287.camel@ibm.com>
	 <Z2qvlXf08wuZ81bv@casper.infradead.org>
In-Reply-To: <Z2qvlXf08wuZ81bv@casper.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|MW4PR15MB5182:EE_
x-ms-office365-filtering-correlation-id: b77ac324-780c-439e-7801-08dd30480243
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?V2ptSld1NDF3ZzArNEpsaU01NG5sQXhoSGpMakRyTlVOYTRja1hQbFlERTBQ?=
 =?utf-8?B?eDVMa0s0TDNaK2cvYVJhbTJDWVhReTRmaTJpdFhSWDBHZlJyL3loQy9CQTd4?=
 =?utf-8?B?b0JEeFNxUnpnelRDMmt5cW5GWmZtWDZRMGIzUVNqTnpXNjF6VGEyYTlzSmtW?=
 =?utf-8?B?akYvQ2swQ3hsdVVRTU0vWHIyeGpEdnY5VCtzOFpscjNtM0tWUUdTSGtZOUhW?=
 =?utf-8?B?aGk3TjZrQjVBVHh2MFBsTVdFRCtUR2lnTHRDR0ZxbFp1TENTZU55K2ZlNTQv?=
 =?utf-8?B?NHR6WUZVdkp4dFFmSDJmRk5yazY3OHJzWUR1QXo1eHpXT3ZiWlJDK2FDMGFQ?=
 =?utf-8?B?Z21GclZVQTdIVnAvaVZwMTlwVDhmNWJNQ3R6YkNXQ0p6MC9zdU9kQXNWRU5F?=
 =?utf-8?B?R2dJWW5MeWl3NmFkdFpmNndURFovK3hFdmFYU0xZOXJSbEhrNWZObXRxU2Fv?=
 =?utf-8?B?b1ZsMCtTQmc4dDNXakFBMTlScTE4dXZrMFBhRUM4ZllkTm5MU2tSU3NUTXBj?=
 =?utf-8?B?TFdMcXFhMXJUR2doNnJCOVBtYnhRZjEvZ1VxVTNRRXY0RnR2S29IR1lndlR5?=
 =?utf-8?B?bTIyWFcyN056UUF3MEZYZXg4VXg2RVYwRUM0VC8vVVpQdmpOYnN0NGVaQmh0?=
 =?utf-8?B?UTNSUHovT1VuSGJ5MytxcFdKODhlK2xsb2FmYURLQ21leTlGL0VyNGR1NUlS?=
 =?utf-8?B?aEFOUGwzTUlpNFpLbzhmWThYL1ViTHFZZzVxNVNDbm5jcDh2SW95WHJRK0FM?=
 =?utf-8?B?cUhUa29lNWN6TXFFeitxS1YyU3dVNGFiMU50NXdHZXNkL09EdS9Xd3NtY0Ux?=
 =?utf-8?B?M1liTFIzTGxBNnZod0JQQjBzejQ5R3Jja2Z1dnpBTVhIemw2Yk1BZEhIRi9s?=
 =?utf-8?B?bHZXYThLS3oyNEFxSkZWOFJNQ2JPSm53aVUxV3JlM29DU0xvcVBmSWRMelFK?=
 =?utf-8?B?WWlwSHg4WlFnYUVZdTlEQ09kWUlmU3VXcWc0ZHVGWm5wQ05CNW9UeWFvZUE0?=
 =?utf-8?B?dmpVK0FSVm5MNDlDVmluSklOL0UxN1llWkc5MjA5ckxTcFpoeVVRREhxQzdN?=
 =?utf-8?B?RlhCcWNOeTJxbTFFUUI2VGlSUGNjS1lBcCtXdzNROS93UzgwTWh2QTBYUHB0?=
 =?utf-8?B?c1M3SlY0Y1hpYWZKeEJDamJiWHdzUVpVbk03M0tRYlRzRzNSdndRNHdTM0ZF?=
 =?utf-8?B?N0VJMEVaVnFnWm9VcGlsT05icWFmUHNlTm9FTVJobXNjclg3UDhNaytWTEJk?=
 =?utf-8?B?T3BQT2YrL1lmSC96UUhUK3ZFOEY3cmtKUTlCTyswS0UyUTdQUTRSaWNrRXor?=
 =?utf-8?B?bHJxeFZhbkx3YmVMR1didFlUT3l3N3dYMGxlT0k0RnBjWjNkRUQzdjlDbElS?=
 =?utf-8?B?MDZMZy8zQk4yMTRGQTRkcm5NNndON0k0MWVwblFwU2ZJai9Bb1ZVVGx4M2du?=
 =?utf-8?B?SDhwOVZvMW9FaDZqL3VvbnZVdUtmT3FRQ0tPSEYzM1pXM213blV6OHlVa2h6?=
 =?utf-8?B?Rnp4UmtBQ1ZRNC9iNFNzV0dxYnpUQStzT3poTG1ZTm5TeWVxUlA4RXE2NUMv?=
 =?utf-8?B?V0NPQUtPNVl3R0ZPYmFkYVN1eCtOamlEUVpmYlVOb25vZEtHQXhFUkp6ZUlN?=
 =?utf-8?B?cmV0NytqOWcyUExwV1VSZ1VuaTFacjJFRFVyZ2YzRW12WG40bERGQWNBRW9O?=
 =?utf-8?B?d0JMSFpadTVYQ014MEE0ZXZpR1VDQjl1eHNlTU00OEV4bkpxeTZoZVRqRFNQ?=
 =?utf-8?B?VWtxcmk3MUtpaFlSVldaTUFoUGdpb2t4OU1EaFlQaG5IRWdGbzhnand1N3p6?=
 =?utf-8?B?eGdJc29yR3RqL1g3TERyYU1qUmJBTm5LQWNWVS9YbXNFQzJlSHMwVmpVUTFK?=
 =?utf-8?B?MUZnQndLeTBwcDlQejVTZ0JKcDVINk5YRzc4Zk85YTMxODU4d2wzRkl4ckla?=
 =?utf-8?Q?3uwPd+9O8jrjC8JQa2UV9aszwDmX+biL?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?c2w1ZVJ0OGtKcmU4eUpMOS9va0dGQUhtT0ZkeVV0M3FJcTQ3THRMUVRPQ3Qx?=
 =?utf-8?B?cEdtcVZ6UHVzV1BMTWtPYWNSVStjc2t0Z293RHNPQ3ZWbytRZ2hvRVJyWElB?=
 =?utf-8?B?NUplM3NjUWd2cE9mVzZLK2paZ0lqbloyd0ZhM3MrazJIYldMWHZHTWg0ZVJY?=
 =?utf-8?B?OTR1ZGJuVnM1eXNzT1pPcS9IaXJ1K0xSSW1TNjdKOXJ3NENiYUYvSVg4OUxo?=
 =?utf-8?B?bHgvemFsZnRVb2M4VUFEVC9RZFlRVDRuTnd6QmZVbkorclhRUHR2blNPVTVV?=
 =?utf-8?B?Tk1aZTRPMmZIWnNBOXZUSXFTRnlRNlRoUmVIcGFESEZXWEpnSzZkRkN5S3dy?=
 =?utf-8?B?UjV4bG5sM0kzRmZHWEZCcVlvVjhmeitlVGJQYWpuSjVDOU9FcDFuLzBtSVVs?=
 =?utf-8?B?SXZlOVpvR2RQbmhNQVhVVFZrbVk2OU96M290R3kyejNVVFdYelRRK1FMVVNx?=
 =?utf-8?B?cG9nckR0K1QrY3dPVjhLTVhFRmYvRk40QXd5Rzh4MGhvWE54Wjc4NkRvckZs?=
 =?utf-8?B?dGx0ZUl2dG1kT0FxM1BZa3hIZTFQN0YvSHR1djJBZ0lyRnlLb1hTUUhFZlVs?=
 =?utf-8?B?TkZnMDJ0dmRHQXFlSmRRemRuUTIrWDdBNzkxdWxPakQ2ZXlkUkJ5NE9CcFRX?=
 =?utf-8?B?VUdyYlRUUEsxTEVJblB5Q2s0bjZtcTkvS3ROU1Q4NGRIQncvMmt2KzRaUDR5?=
 =?utf-8?B?RkZRZlhFYnNVZk9LT3QyZnVJS1luOW1DQUw4S1RjMzdqRTJWWEQraVZSRXdR?=
 =?utf-8?B?eGl6TFU0MmdJQXk1cGIxWW91MWkvSXBYSFZHbGM4RHVkNGN1Rjh2SDhLN3dt?=
 =?utf-8?B?SnlSV3BuQXFwOStXbUtMZWhNcHZuamx3b21qUlpneldlbGVVY2ZnQ201YWhM?=
 =?utf-8?B?MHNTYlBIWndEUEUzRkdOdStKSFVpOFY4MWt0L1E2S1VmUmk5Y3JoZE1GUVg1?=
 =?utf-8?B?dDhEdlplQjlhMHlmMmE1RlZsUXdQcndFajdsSzBRdi8rcE9MdXhZTmQzMkRh?=
 =?utf-8?B?YkZMeFBocGUxRitRZzM2Qk9YQWRHeXZPZnNCZjlMcFM2S2lybFFqUWpXRHdE?=
 =?utf-8?B?L1BFRVRZSlZmVGVKMDNFSUVFcE13QnA2cVFSZWpZVytVengrUjBtYzZVdjlx?=
 =?utf-8?B?NFQzRzVKRDhObjZ3ckJDRVZ2TlhiZW9pUXd0Yk1KaU5Ha25WWnE5WVJoSTJo?=
 =?utf-8?B?Rmk3eFZlaXpKYWJLV3VQMWMxdkNtZzEyOFpEUHVRbjV3TmJXcytuTUdrMG9p?=
 =?utf-8?B?MkNjZW1aOTl2VDlqSnJKRFhuckF4cFRXanhRbTRkdjk4aVVDWnpIaEwzclFl?=
 =?utf-8?B?WjU3T0dneHV2SHU1WmFFUUU2dlcyZWdNZ3VVTEVpQWJZbGd3SmNXc3dtQjBO?=
 =?utf-8?B?Z1V1Q1FLcGdSWTFvU3BqRXpHTEFZMVdzelgvRWlQTDhSZndUbXFJRTdMcWNG?=
 =?utf-8?B?b2JqNDNlYlVob2YxWDk2S3dpOGdmejFIbFhiZHY3NjhScEFhRmQ1NXM5UnRF?=
 =?utf-8?B?dUlvTk4zdHF3SWR2eW4vWWFSQkZTcGU4Q2xSb1k3dERReEtUaEc4NTJaTDE0?=
 =?utf-8?B?Tms4UUg1RUw0NmhEZEg3amt3ZWZ3Tjh1SnhWU3JRZkdEMERxcVlkQzlBVXdr?=
 =?utf-8?B?MlU0TkNyakNWSzR0anlydzRLWXFFNGYxNGc1aERRNGErUm5LMWcwZEFrNGRT?=
 =?utf-8?B?T2RsMHkxMkI5T3RWbUFtLzBYMy9TZVBjb1Y3aDRHZ1d1QlFoelAzVXJzV2Q3?=
 =?utf-8?B?ellOUmJ6WktDZXZyOUJpOUZtckNxK1dYNndRNGQ3bXFEb0FJKzlzdVFnNVUx?=
 =?utf-8?B?ajRUcTJHclVpQUt4RkVPRksySEhrQ2pMNGNTYllNeFh5TzBjTEtjWm56SVV6?=
 =?utf-8?B?UlBqR21ESTQ4ZnRDSUpXckJrRjVVcXhDckVaSWFCbTFJRlNVWldUc01SZWU2?=
 =?utf-8?B?VG5mRTd6VXBML202YWNBcG10NjFNZittZHBaOTJmMXZVNWp2OWxDMnhncWpy?=
 =?utf-8?B?aFZsczN4dHZweFFRWlZEUG9ZUGJOTWdZT1c5K0VBTGlRUDA5clJaUkxUbzFZ?=
 =?utf-8?B?a0U0SUJER0ZrdDVKd01vajNKQVF0TXJZUEZBWldub3lZREhyY2VNM0hldlZ3?=
 =?utf-8?B?czNqTjJQQWhjeGU4bUc3RTVGQkE5TndhSkxkbWh5dUlxOUZ5TlBBRXRFU01Y?=
 =?utf-8?Q?j1GBDslPZ6fqql4WwSdH7G0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6C752A96F2062E4BBE0C442BD4C397D0@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b77ac324-780c-439e-7801-08dd30480243
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2025 00:53:18.9919
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2qTSQsJmA3IjYhjKqmn9nQnhpBoAl1AYqqg+RAS0NumrVX3XkTxgzuUDcDN/jARtxWafSRlY4Q/xGoYB5zbPYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR15MB5182
X-Proofpoint-ORIG-GUID: soXcMt-GGklUeptOoWB92HVs8KKlCD-7
X-Proofpoint-GUID: EorBRDwMfRmNh7SYHmicuFm6ggCdpFDw
Subject: RE: Ceph and Netfslib
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 spamscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 mlxlogscore=999
 bulkscore=0 mlxscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501090002

T24gVHVlLCAyMDI0LTEyLTI0IGF0IDEyOjU2ICswMDAwLCBNYXR0aGV3IFdpbGNveCB3cm90ZToN
Cj4gT24gTW9uLCBEZWMgMjMsIDIwMjQgYXQgMTE6MTM6NDdQTSArMDAwMCwgVmlhY2hlc2xhdiBE
dWJleWtvIHdyb3RlOg0KPiA+IMKgKiBPbiB3cml0ZWJhY2ssIHdlIG11c3Qgc3VibWl0IHdyaXRl
cyB0byB0aGUgb3NkIElOIFNOQVAgT1JERVIuwqANCj4gPiBTbywNCj4gPiDCoCogd2UgbG9vayBm
b3IgdGhlIGZpcnN0IGNhcHNuYXAgaW4gaV9jYXBfc25hcHMgYW5kIHdyaXRlIG91dCBwYWdlcw0K
PiA+IGluDQo+ID4gwqAqIHRoYXQgc25hcCBjb250ZXh0IF9vbmx5Xy7CoCBUaGVuIHdlIG1vdmUg
b24gdG8gdGhlIG5leHQgY2Fwc25hcCwNCj4gPiDCoCogZXZlbnR1YWxseSByZWFjaGluZyB0aGUg
ImxpdmUiIG9yICJoZWFkIiBjb250ZXh0IChpLmUuLCBwYWdlcw0KPiA+IHRoYXQNCj4gPiDCoCog
YXJlIG5vdCB5ZXQgc25hcHBlZCkgYW5kIGFyZSB3cml0aW5nIHRoZSBtb3N0IHJlY2VudGx5IGRp
cnRpZWQNCj4gPiDCoCogcGFnZXMNCj4gDQo+IFNwZWFraW5nIG9mIHdyaXRlYmFjaywgY2VwaCBk
b2Vzbid0IG5lZWQgYSB3cml0ZXBhZ2Ugb3BlcmF0aW9uLsKgDQo+IFdlJ3JlDQo+IHJlbW92aW5n
IC0+d3JpdGVwYWdlIGZyb20gZmlsZXN5c3RlbXMgaW4gZmF2b3VyIG9mIHVzaW5nIC0NCj4gPm1p
Z3JhdGVfZm9saW8NCj4gZm9yIG1pZ3JhdGlvbiBhbmQgLT53cml0ZXBhZ2VzIGZvciB3cml0ZWJh
Y2suwqAgQXMgZmFyIGFzIEkgY2FuIHRlbGwsDQo+IGZpbGVtYXBfbWlncmF0ZV9mb2xpbygpIHdp
bGwgYmUgcGVyZmVjdCBmb3IgY2VwaCAoYXMgdGhlDQo+IGNlcGhfc25hcF9jb250ZXh0DQo+IGNv
bnRhaW5zIG5vIHJlZmVyZW5jZXMgdG8gdGhlIGFkZHJlc3Mgb2YgdGhlIG1lbW9yeSkuwqAgQW5k
IGNlcGgNCj4gYWxyZWFkeQ0KPiBoYXMgYSAtPndyaXRlcGFnZXMuwqAgU28gSSB0aGluayB0aGlz
IHBhdGNoIHNob3VsZCB3b3JrLsKgIENhbiB5b3UgZ2l2ZQ0KPiBpdA0KPiBhIHRyeT8NCj4gDQoN
ClNvcnJ5IGZvciBzb21lIGRlbGF5Lg0KDQpJIGRpZCB0aGUgdGVzdGluZyBvZiB0aGlzIG1vZGlm
aWNhdGlvbi4gQXMgZmFyIGFzIEkgY2FuIHNlZSwgYXMgY2VwaA0KcmVsYXRlZCBhcyBnZW5lcmlj
IHhmc3Rlc3RzIGFyZSBnb2luZyBpbnRvIGNlcGhfd3JpdGVwYWdlc19zdGFydA0KKHdyaXRlcGFn
ZXMpLiBFdmVuIGlmIEkgYW0gY3JlYXRpbmcgYSBzbWFsbCBmaWxlICg8PSA0MDk2KSwgdGhlbiBp
dCBpcw0KcHJvY2Vzc2VkIGJ5IGNlcGhfd3JpdGVwYWdlc19zdGFydCgpIGFnYWluLiBTbywgYXMg
ZmFyIGFzIEkgY2FuIHNlZSwNCnRoaXMgbW9kaWZpY2F0aW9uIHNob3VsZCBiZSBzYWZlIGVub3Vn
aC4gUnVubmluZyB4ZnN0ZXN0cyBkaWRuJ3QgcmV2ZWFsDQphbnkgY3JpdGljYWwgaXNzdWVzIHJl
bGF0ZWQgdG8gd3JpdGVwYWdlIGZhbWlseSBpbiBDZXBoLiBJZiBJIGFtDQptaXNzaW5nIHNvbWV0
aGluZywgdGhlbiBJIGFtIHJlYWR5IHRvIGV4ZWN1dGUgYWRkaXRpb25hbCB0ZXN0aW5nLg0KDQpU
aGFua3MsDQpTbGF2YS4NCg0KPiBkaWZmIC0tZ2l0IGEvZnMvY2VwaC9hZGRyLmMgYi9mcy9jZXBo
L2FkZHIuYw0KPiBpbmRleCA4NTkzNmY2ZDJiZjcuLjVhNWE4NzBiNmFlZSAxMDA2NDQNCj4gLS0t
IGEvZnMvY2VwaC9hZGRyLmMNCj4gKysrIGIvZnMvY2VwaC9hZGRyLmMNCj4gQEAgLTgxMCwzMiAr
ODEwLDYgQEAgc3RhdGljIGludCB3cml0ZXBhZ2Vfbm91bmxvY2soc3RydWN0IHBhZ2UgKnBhZ2Us
DQo+IHN0cnVjdCB3cml0ZWJhY2tfY29udHJvbCAqd2JjKQ0KPiDCoAlyZXR1cm4gZXJyOw0KPiDC
oH0NCj4gwqANCj4gLXN0YXRpYyBpbnQgY2VwaF93cml0ZXBhZ2Uoc3RydWN0IHBhZ2UgKnBhZ2Us
IHN0cnVjdA0KPiB3cml0ZWJhY2tfY29udHJvbCAqd2JjKQ0KPiAtew0KPiAtCWludCBlcnI7DQo+
IC0Jc3RydWN0IGlub2RlICppbm9kZSA9IHBhZ2UtPm1hcHBpbmctPmhvc3Q7DQo+IC0JQlVHX09O
KCFpbm9kZSk7DQo+IC0JaWhvbGQoaW5vZGUpOw0KPiAtDQo+IC0JaWYgKHdiYy0+c3luY19tb2Rl
ID09IFdCX1NZTkNfTk9ORSAmJg0KPiAtCcKgwqDCoCBjZXBoX2lub2RlX3RvX2ZzX2NsaWVudChp
bm9kZSktPndyaXRlX2Nvbmdlc3RlZCkgew0KPiAtCQlyZWRpcnR5X3BhZ2VfZm9yX3dyaXRlcGFn
ZSh3YmMsIHBhZ2UpOw0KPiAtCQlyZXR1cm4gQU9QX1dSSVRFUEFHRV9BQ1RJVkFURTsNCj4gLQl9
DQo+IC0NCj4gLQlmb2xpb193YWl0X3ByaXZhdGVfMihwYWdlX2ZvbGlvKHBhZ2UpKTsgLyogW0RF
UFJFQ0FURURdICovDQo+IC0NCj4gLQllcnIgPSB3cml0ZXBhZ2Vfbm91bmxvY2socGFnZSwgd2Jj
KTsNCj4gLQlpZiAoZXJyID09IC1FUkVTVEFSVFNZUykgew0KPiAtCQkvKiBkaXJlY3QgbWVtb3J5
IHJlY2xhaW1lciB3YXMga2lsbGVkIGJ5IFNJR0tJTEwuDQo+IHJldHVybiAwDQo+IC0JCSAqIHRv
IHByZXZlbnQgY2FsbGVyIGZyb20gc2V0dGluZyBtYXBwaW5nL3BhZ2UgZXJyb3INCj4gKi8NCj4g
LQkJZXJyID0gMDsNCj4gLQl9DQo+IC0JdW5sb2NrX3BhZ2UocGFnZSk7DQo+IC0JaXB1dChpbm9k
ZSk7DQo+IC0JcmV0dXJuIGVycjsNCj4gLX0NCj4gLQ0KPiDCoC8qDQo+IMKgICogYXN5bmMgd3Jp
dGViYWNrIGNvbXBsZXRpb24gaGFuZGxlci4NCj4gwqAgKg0KPiBAQCAtMTU4NCw3ICsxNTU4LDYg
QEAgc3RhdGljIGludCBjZXBoX3dyaXRlX2VuZChzdHJ1Y3QgZmlsZSAqZmlsZSwNCj4gc3RydWN0
IGFkZHJlc3Nfc3BhY2UgKm1hcHBpbmcsDQo+IMKgY29uc3Qgc3RydWN0IGFkZHJlc3Nfc3BhY2Vf
b3BlcmF0aW9ucyBjZXBoX2FvcHMgPSB7DQo+IMKgCS5yZWFkX2ZvbGlvID0gbmV0ZnNfcmVhZF9m
b2xpbywNCj4gwqAJLnJlYWRhaGVhZCA9IG5ldGZzX3JlYWRhaGVhZCwNCj4gLQkud3JpdGVwYWdl
ID0gY2VwaF93cml0ZXBhZ2UsDQo+IMKgCS53cml0ZXBhZ2VzID0gY2VwaF93cml0ZXBhZ2VzX3N0
YXJ0LA0KPiDCoAkud3JpdGVfYmVnaW4gPSBjZXBoX3dyaXRlX2JlZ2luLA0KPiDCoAkud3JpdGVf
ZW5kID0gY2VwaF93cml0ZV9lbmQsDQo+IEBAIC0xNTkyLDYgKzE1NjUsNyBAQCBjb25zdCBzdHJ1
Y3QgYWRkcmVzc19zcGFjZV9vcGVyYXRpb25zIGNlcGhfYW9wcw0KPiA9IHsNCj4gwqAJLmludmFs
aWRhdGVfZm9saW8gPSBjZXBoX2ludmFsaWRhdGVfZm9saW8sDQo+IMKgCS5yZWxlYXNlX2ZvbGlv
ID0gbmV0ZnNfcmVsZWFzZV9mb2xpbywNCj4gwqAJLmRpcmVjdF9JTyA9IG5vb3BfZGlyZWN0X0lP
LA0KPiArCS5taWdyYXRlX2ZvbGlvID0gZmlsZW1hcF9taWdyYXRlX2ZvbGlvLA0KPiDCoH07DQo+
IMKgDQo+IMKgc3RhdGljIHZvaWQgY2VwaF9ibG9ja19zaWdzKHNpZ3NldF90ICpvbGRzZXQpDQoN
Cg==

