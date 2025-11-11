Return-Path: <linux-fsdevel+bounces-68000-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C650BC4FF87
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 23:28:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DD1A3AD177
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 22:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9D52F1FF4;
	Tue, 11 Nov 2025 22:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RZl1gR9o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214CE35CBB6
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Nov 2025 22:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762900071; cv=fail; b=nnYD8eGWg7m6V3fCnGZL4NXfJcHXpdRKHZgYAKLHJysDeq6oFKvjMbjxaFbig0LtDDrqbS9zVyNRo1Oi+4ZNIPDslENnv58y5LvPDiSwFAzIz7yjKH8hzTe5rg6yLyr2X+lgjfEWSXWZFe2Ru0g8hV4BX61/kM4aT9ElTHu3D5U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762900071; c=relaxed/simple;
	bh=sUjfvpsWPnGIP3gUcOBu1Q9RRSIjbQSfWKYJKj8ArjE=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=nS4LaiP6BKCjTzvohPXoAujif6zq3SgA5xGuqFkoQW6TX/9beHgEia0jW2NNu13hjA3macuMiuXstosjs6AR+Gk06Iqbto7t/XoC59jjz0Tg3kNmdPkBtAcVGmQhpYxI8FkGCKh7mGZcmxDbedllvMGJ2iB2AcBeFpu6vajDxqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RZl1gR9o; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ABD0HBd021035
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Nov 2025 22:27:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=IiFCvQstySHTwH28Tk2e1x7y7iVQg7Zq00oUwQR9y8s=; b=RZl1gR9o
	AjusQ6BmsjdSIb4zXBbQUcVeXfgi0UCPq5Z/8DF16s1YfliyEGfdqPPVOCaIlc6j
	UPfweKaWU8gFKiu+mPiu6M2BShgeyo64DFOJz265oWpBJc34wbxE6BAdcQ9ax+yR
	cbpp9cnzlFTx3x88QMd27OVJSrnN25GNIL8yCYLS4vkAFRe570ERR/9JhjDzPHFT
	Pa9bO7/gm4MWRv27efoK1yK0P2CPQvrH8VRgZtOX8f5J/pCdi1LvHshe2c3U3QNY
	t8jhzq8KFyTJ4aFAQc2Cqqdn9BcuXfU1ssIRs8AoxuxBCAQAdM9OHOz3FYeHI0RW
	dGUKDaTMf4bHUA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aa5cj6cfw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Nov 2025 22:27:46 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5ABMRkGX016849;
	Tue, 11 Nov 2025 22:27:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aa5cj6cft-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Nov 2025 22:27:45 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5ABMRjUO016825;
	Tue, 11 Nov 2025 22:27:45 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010057.outbound.protection.outlook.com [52.101.56.57])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aa5cj6cfs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Nov 2025 22:27:45 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bZbnXsVW4de0XD47p3bU6aOypk6vwLsv9L+6eSpLa7g5rljliymsRFRp11h4Wn4Aq7CKyCxzkv/gUx4wD0ufslS66yg7p7JOCADZ1dp85R0072LL4K11S9xYkxuQesZgaOGlZ2ieMYNqt+L5j4pyRyH9OqhoicRGczhtJlhROUiHvuNDiJvpAye3gmU2CW3Z4c9cBkFKEwpaOoXRqjyKD0F3nhj7lRWAsInyqojDsowfNluufJ957LNxJqOmhjAd7IXh0hd5lcyYfJfMidn3l8SlSKNAUgb+7ZDqjjvGJDwOyrMw6p0NlWeagloFt9HWHnfIiMuOYLmcithQYMDzdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XP6YL70pPHwWJ0GWQ+S45ZX6I+fb3Zkt62hl644A4oo=;
 b=bIhMPT7/ADsG59Z+nckvaIEtvTTg8GkgTXYLfTtsTUYCPHiMFq8yh3NWTpp4Sh9LnreB/91yFKBTch4pkLgt11voD6HrQDXnY+K62ELxgrcI26kPMwoFom/f3I0xBISWFhW/f59BcKxvB+4o33mr2muOCIC6dcPdSiWWQ72wdcdd+Fh/Xas6cd4cHPYeVh+yainKFBwj+Fuzh7ej5+bigd+mT1YLaZIN3J0wq1ebMsEynrWAE37jLInTsQLGNFTZlXAzVSTzG22n7z1lMyTrSuT9Ei+WXBblMyRvopvyDM49xnlimgk1oqVxFfwwRM/7qhwPXsxaPBxVhK6wvFPJdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by PH7PR15MB5368.namprd15.prod.outlook.com (2603:10b6:510:1d3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Tue, 11 Nov
 2025 22:27:42 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%4]) with mapi id 15.20.9320.013; Tue, 11 Nov 2025
 22:27:42 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "idryomov@gmail.com" <idryomov@gmail.com>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>
CC: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Patrick
 Donnelly <pdonnell@redhat.com>,
        Alex Markuze <amarkuze@redhat.com>,
        Pavan
 Rallabhandi <Pavan.Rallabhandi@ibm.com>
Thread-Topic: [EXTERNAL] Re: [PATCH] ceph: fix crash in
 process_v2_sparse_read() for fscrypt-encrypted directories
Thread-Index: AQHcU1MrAGbWSOf7+EGK49QJUAaJoLTuDiKA
Date: Tue, 11 Nov 2025 22:27:41 +0000
Message-ID: <8e4d0443f5789b5335ab8526ee707fcb04156968.camel@ibm.com>
References: <20251111205627.475128-2-slava@dubeyko.com>
	 <CAOi1vP_tHEgBn-+EmSeOtpWnQezEZDnGWapGZ3ngXZYkzvPpiw@mail.gmail.com>
In-Reply-To:
 <CAOi1vP_tHEgBn-+EmSeOtpWnQezEZDnGWapGZ3ngXZYkzvPpiw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|PH7PR15MB5368:EE_
x-ms-office365-filtering-correlation-id: fd723a59-4df4-4c00-560a-08de21718769
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?aHU1V0g2d1cyTm1Yc213MXdZWGxpaHNqZ01IUnZQVFQ1dDBIK0ovbXBBUUhU?=
 =?utf-8?B?cFIzWEUzWkd6Z1VXTVdyV3hTRDdEUldzU0NvejMxb1ZsWEJkTWRIYzROS0NN?=
 =?utf-8?B?OFJPdVJqQ0ZpaW92TmFKMUl2Nk5HRzEzU2FDNGR0VjJ1R05rcHh5Szh1Mnpm?=
 =?utf-8?B?T2hoZzJIZVVIamlwZ0w3V3lXVWtZN2RqcFVybHQvZWh2Z3VCZmJ4dzc4SlFs?=
 =?utf-8?B?QXc3b2ZaMUZpbEw4VUplbHpWVmZGdStZVTJBOWhYRnhyNDl6ZzJJNUJyOE9s?=
 =?utf-8?B?aWt5V2Y0cXFlRUtGeDd0QTUvdmV6T24wTjU3ZFMvSTdqR0pNWGdGQW9RRjR6?=
 =?utf-8?B?V3dSTURSem1hbkpHenlObUp4c2Robkp3dlE1RjFFVVBXdCsxOXlMelVvMHBZ?=
 =?utf-8?B?R2YvdXY5S0Iva1JrMjkrV3R0RWdwaDdpY0lZTUNQVFVpL28wMTI2M2UyRmVF?=
 =?utf-8?B?RDYvY2ZaTkpseU1WOEc5VHlxUXgzenA4TXRZR3piSFg0SzM3NE52Q2ZsRzhG?=
 =?utf-8?B?eWpGZUxIU3JObmJnNmwxeGtKNWd5dXMxV1k3bXpwNEpqZjZlUHZUVnBWdito?=
 =?utf-8?B?VGEySXhhOXVoZlVtc2k4NDE3dHEwbE9KZzh5U3J3VU0zSXlrcWRlT2kvU2VL?=
 =?utf-8?B?MjdyTWJOcTU4Y0tOeWUwQjM0M1VYdHVxcGcwL0hQOUN3WGtsQnBVYzdxbHN4?=
 =?utf-8?B?Qy9yc1RKL1ErZndLUjBnOHBjaXpIVXdEaHNPLzZ3R1hMMFoxeDNKU09SenU3?=
 =?utf-8?B?bzM0NmRFV3dyVWRQRWVpQURTV1BnNjJzb0hnYTZZSEttellRam1vbU5EVUtK?=
 =?utf-8?B?dkcyOVlEakpOMGExV3pUcitGbEhMRXBjemxqTzBkaUQ0V1I1YWh2SGxocCs5?=
 =?utf-8?B?SWJWaFltOCtMQks4SnIzQTExb0IwUnhxU3NMcUdML3dJOWhkTlBqcnpBRGJl?=
 =?utf-8?B?dncySTRDWk1RU0d4U3ZEUzJJQkZPNDBBYThNMUtMTi9BeTkrb1BDTzNrelJS?=
 =?utf-8?B?ejRQdk1XaThnZ1kwNTRuVGI0WEIza0JjMmxrT0VFTmMrazI3WE9Cb3RWOFBV?=
 =?utf-8?B?Uk9KSFhTaHFacVZhb2xuRFArbjBpU0ZQa045aGF5SDBNNXo5elFpM3UxUXlI?=
 =?utf-8?B?cWZTVC9LUFptVDVPc3Rma1FKbGdySkdrVFIwTWFROHl4WWFqbWZmT3E5QjNG?=
 =?utf-8?B?a25qSzQxblB2Zk5NV3ZiVHZjTGVWay9saU9QanZlV2p3eEpHT1NBM1pjM3hv?=
 =?utf-8?B?b25WdjFVTHBEaXYwQXYwYUdmdnNaQnoxOVR2dngrL09VYWZZWDFTZE13LzBt?=
 =?utf-8?B?cU9nYzVSLzBra21qd0ZjZktlVXJZN3k5RFZFTG9sZkdhQWprTm5laHMwUUtt?=
 =?utf-8?B?dVM1NEpQQjBjR2RtU1ZSdGt6ajFMdHkrenpyTzUxMk9OYTJBSGxNdktSczJC?=
 =?utf-8?B?UmwxSWcyeGxRVTVBd1JXSnFuWWlZT0lEWFJlQmxYa3pyOVZ5cEdIRHRDWlFV?=
 =?utf-8?B?SDJzWkVlQWlPek00ejBuZnl1M3N3bEk5ck9NR0czOHhLWG4vUXRTWGljYm5O?=
 =?utf-8?B?VVFvT1k2RGZZR1R2KytHc0tiM2cwZktQV3VGNDlSNGpLeFdMN1o4TUJPZHJS?=
 =?utf-8?B?MDBQekM1cS9TZlJCMlFibkVMZEtNSDdGRHBmU1ljTHAzN3NsNDlIc1VrSVFu?=
 =?utf-8?B?YWwwOE5ueWtVUlc4aDNQWDlQYVpsbnByVUxTNFQzOVpCNzlMVVYvcEVtRG1r?=
 =?utf-8?B?WkFrOGR5eFFndmdiNityOWZGWVd6cVlQRG5DTmRJd3JKOVJvY1FFeG9XbTA3?=
 =?utf-8?B?d0lMSTBKazNua2NUQjdGVkV6cVpyMmlMdjNLQzNxRGZubTZlQ3NEd3l1bXF5?=
 =?utf-8?B?Q2R2VzZ0R3dSTEloamtFU3VjS01Mc1diL0hSR2pMUUpzUEduZTBTQnF5OWZE?=
 =?utf-8?B?T2NhYy9BYW9Wa0w0YXhmUzRCV1FOTmpWV0tDd3hQb0U0RUdjK2ZxdDVYbXdB?=
 =?utf-8?B?ZDBxSjZzSDBuRFN3aHJwMENYQWxvM25VUU9Md09sd1lnaGVnNHBtNGRod3FS?=
 =?utf-8?Q?PguSUF?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TGx3d2Q3VFBMOHhDc2RtTUtOc0s0NXZoMVhjNzRFd2diOUJWU0s4RWtTbGha?=
 =?utf-8?B?RENnM3R2YUd4bmhGd01aMXZkayt2SGRaNlU4TnNWZk5zWUFzNGFpcW51bU9Q?=
 =?utf-8?B?VGtEMmFSYVFha3lsNjlHejh5T1pOOWlmbkIyN1RybEV5UTBEb3llVnN1RFpx?=
 =?utf-8?B?OVJGbXVzclJWamJFK3RqazV2RXJicU1DUGZUejZqbHRwWmR2TjNFSEsvdjdJ?=
 =?utf-8?B?aGhQODJyR2tORVhHQ0huYnNZcTk0ZnNxaWlFUURoeGJrR1F5amtXV2NaNXZh?=
 =?utf-8?B?ZUVzaVJPbUUxQUJtRm4ycDRFcVh0MnJYMkNHdmdJYlhidG9qYkw3S1YwUExw?=
 =?utf-8?B?ZVBkeS8rUkdNUTEydlk5VklkdUZINy9hNUlPa1V3Rkkxb0tJSm5UcGRYV3JB?=
 =?utf-8?B?d0lLbHpMaDZ4YWtiZUsyTUE1Q2EvamZXd1lYd1FvOTd3QXFEQ3ZZNXNLYUxt?=
 =?utf-8?B?ZU8vMnJhcy93c0tMOGFKQlpqSUV6VFRxcGU0eEdlQm55eVlRM012SnFqcmty?=
 =?utf-8?B?ZnlsYUJ2a2l2K2VyTkxFU09BLzM2Q1drZnd2RDhnelc2Yi9JZW4weFNvUDZQ?=
 =?utf-8?B?MTNYK01lak5WRVhEajVQWVZwVGtIRVU2MVpxeXBOZ3BkdFRYMUgwYXdNMnRO?=
 =?utf-8?B?cXd3ckJwN1hNSTVlMkJrRmVJa2I5ZzZxR0p4bVdYVlIxNHI4dmpOSHkrOVVl?=
 =?utf-8?B?QlFtU2FlRVdCbEg0NkkzUCswOGd2RlVpQi9xa2Z4aWdFcUExdWYvcng2NmYv?=
 =?utf-8?B?Qy83NVJ4dmFjR1hIeWhFUjZGS1dBM1NKR003VjF1bGZLRW9acmhZWVhKRDQ5?=
 =?utf-8?B?NVp4akRwSEJvMm5xTDhQd3p3c1E2c0tkNGJIQjhpamFWVGFSZHdXN2JZRnJH?=
 =?utf-8?B?S2NveVBXb3VXK0V4Z1FJS0plWFk2eTQ0MXNTenNqUnduMncxRExkaks5K2RO?=
 =?utf-8?B?Sy9yL3ZlbFA3cS9zWHgrTURDOURJS1VKVitlM0wvZlZuNjNOREgyc05CN29E?=
 =?utf-8?B?c1MrZkp5bVAyaDFVMVBzMlg5KzNPRDhZM3E2STQ5M29uVjJwUG43OTZ6QjZE?=
 =?utf-8?B?VERtMlFnODNuaXdQUkVXcEZWRWp1UDZBemcyZnhIWGRIZkRBU3VBdnlwaGhK?=
 =?utf-8?B?eVpYeTlQSkZTWDI1N29vWWJZeWtUc0NKUGFYODhKTkdOT08wdDlwMmhKelhM?=
 =?utf-8?B?cWlIK3R1WlRUWU9mTDNCbUZvRjhvaWZXVXVkRzJjSHZremcxQ3BUN0JndlBQ?=
 =?utf-8?B?b0RUb0pYMys3bTN3OHk3YXpadElieUNrd0drQnc4SmhWZTRzUE1ESG9Yem8z?=
 =?utf-8?B?NnVjT1NVTHB2SGJzQ3lDMHVQRFo5a25kUExPQjJCZVlPQlUxMjlXZS8vNEdI?=
 =?utf-8?B?S09OV0I4RWY2Y1cycmN4N216SXgvL1h5dDFvbCtYaFlDdVVqMUxDWnoxR3lk?=
 =?utf-8?B?MHduYzdrV0M5QXNTOG4wUUNlOGFjdGhWVUpIOHUwQ2Z3akQ4eklGSTl2WXRL?=
 =?utf-8?B?UHZ3bEdWa0kzdXdrWFFPNkdGb0FHVUhBYkRCUnh6dW03dVVjM1pvTjRWaVpy?=
 =?utf-8?B?NWREVWxOMGh0S3JoL0NUWWprOHFvRGt4cnVZa0wyeEJZeUZncUErZjN3V0pj?=
 =?utf-8?B?ekRIVzBDMEFoc3pLVC9SKzhHdkltWTN0NHNvNlMwUU9Ra3l0cVFlYjAyaE96?=
 =?utf-8?B?bHFUZXQ0WGdGYkd6WWV6UGNtcEFFUUYyNVAvWXVaZExQMTdJVGQ3WjljdjJY?=
 =?utf-8?B?SmJ6Y1RJNG1tUUUweEJUNmVTT0taeEpoQmd0eUZWYkxpUVEwSmw2YmNpOHpp?=
 =?utf-8?B?YnhYbXNlbWxGMDZPTGszUG1lMm82bDE4ZEc2VDBJVm9FTnZxSmxBdk9YeHpZ?=
 =?utf-8?B?ZnhxZ0RlSFMzY0VaSUFCcjQ4L0Z1aWNYMlorWnJOQkVwZ2ErWjV3UXhzTEFl?=
 =?utf-8?B?TFBDaFduQVFySW1oWGJFQnFqTk84R2puRTBaN1RPUnI1R21hMFAwSHBlaXc3?=
 =?utf-8?B?SGhqNUFJY0xWWjlRSjRadDFSK3IveG5pMG02eVVnYXFHeGpyY0owRm9DZkU2?=
 =?utf-8?B?WUVZZlRmR2R1U2R4S2RhblFSV1YvRTNOSzhYZFAzRUdmOWFJVjE1a01yeEd1?=
 =?utf-8?B?RC9WcWQyaWIwb2FhUVIwZzhUUjJEbFlrOTM5SE9GYTdOcEVEdXZQT0RmYlgx?=
 =?utf-8?Q?laRqfFCsMlZ+P4Gr7l+BUCU=3D?=
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd723a59-4df4-4c00-560a-08de21718769
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2025 22:27:41.9526
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I8SYeFKe8loA4/HNcu/PODOEIbrS0WsDshcmtusFoskUrXngxJu2STfvr4/NtnLz61ZUPIAlMfk8XHVQg1S/hQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR15MB5368
X-Proofpoint-ORIG-GUID: SFxL_Rfm_7cDhNW347qTDY7-ls1_YPyN
X-Authority-Analysis: v=2.4 cv=Ss+dKfO0 c=1 sm=1 tr=0 ts=6913b861 cx=c_pps
 a=fyslLl4jtBSJ9QFfScbUNQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=4u6H09k7AAAA:8 a=wCmvBT1CAAAA:8
 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
 a=Ui-BV7ERzK9wl0K3p90A:9 a=QEXdDO2ut3YA:10 a=5yerskEF2kbSkDMynNst:22
 a=6z96SAwNL0f8klobD5od:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: ZwDkG_YsXygfqq4_7hXDUftr3g094a-y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDA5NSBTYWx0ZWRfX68rhUWxvQY5A
 6BEZs21t5TEXvFY6wL9uhcuE8tydmvWpmJuVQn2Bi0COS9Ac0dqMcv/IzL3wfH0m9MZhq/Ke4hr
 0GG8t6MHFCP9gbDH3Mfth8L0uM7tJBDonIwdKAvSGoxHDUURsHbU1NMKeZ2iWxx25XiScH0BBpi
 kuRArCY9eVrZDAM28wbx+ndDubBTMPB/pPkX3eJQS9HWFMOY7AZh+yhT0w5pyyhSf7QdGAknfUy
 IzN83hYJRqFvTJr7C9nHQBA0ZwiDVve5BhQfh1sftEaKXYFdf/SXTOvhmDjaO01HDVqmk8hG/1N
 d+fJreqFdqQqEuv8vZjuVhv421sWLgrHVl6j6RM+AE1497ncVAsTVcPXxkThXzGD35TESoiTGJn
 3cap27/Qovuj39G2yuO/ZxlQQMsaGQ==
Content-Type: text/plain; charset="utf-8"
Content-ID: <95756F29EF692F449BB8080D4F9019B2@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: RE: [PATCH] ceph: fix crash in process_v2_sparse_read() for
 fscrypt-encrypted directories
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_04,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 bulkscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=2 engine=8.19.0-2510240000 definitions=main-2511080095

On Tue, 2025-11-11 at 22:35 +0100, Ilya Dryomov wrote:
> On Tue, Nov 11, 2025 at 9:57=E2=80=AFPM Viacheslav Dubeyko <slava@dubeyko=
.com> wrote:
> >=20
> > From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> >=20
> > The crash in process_v2_sparse_read() for fscrypt-encrypted
> > directories has been reported [1]. Issue takes place for
> > Ceph msgr2 protocol. It can be reproduced by the steps:
> >=20
> > sudo mount -t ceph :/ /mnt/cephfs/ -o name=3Dadmin,fs=3Dcephfs,ms_mode=
=3Dsecure
> >=20
> > (1) mkdir /mnt/cephfs/fscrypt-test-3
> > (2) cp area_decrypted.tar /mnt/cephfs/fscrypt-test-3
> > (3) fscrypt encrypt --source=3Draw_key --key=3D./my.key /mnt/cephfs/fsc=
rypt-test-3
> > (4) fscrypt lock /mnt/cephfs/fscrypt-test-3
> > (5) fscrypt unlock --key=3Dmy.key /mnt/cephfs/fscrypt-test-3
> > (6) cat /mnt/cephfs/fscrypt-test-3/area_decrypted.tar
> > (7) Issue has been triggered
> >=20
> > [  408.072247] ------------[ cut here ]------------
> > [  408.072251] WARNING: CPU: 1 PID: 392 at net/ceph/messenger_v2.c:865
> > ceph_con_v2_try_read+0x4b39/0x72f0
> > [  408.072267] Modules linked in: intel_rapl_msr intel_rapl_common
> > intel_uncore_frequency_common intel_pmc_core pmt_telemetry pmt_discovery
> > pmt_class intel_pmc_ssram_telemetry intel_vsec kvm_intel joydev kvm irq=
bypass
> > polyval_clmulni ghash_clmulni_intel aesni_intel rapl input_leds psmouse
> > serio_raw i2c_piix4 vga16fb bochs vgastate i2c_smbus floppy mac_hid qem=
u_fw_cfg
> > pata_acpi sch_fq_codel rbd msr parport_pc ppdev lp parport efi_pstore
> > [  408.072304] CPU: 1 UID: 0 PID: 392 Comm: kworker/1:3 Not tainted 6.1=
7.0-rc7+
> > [  408.072307] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), B=
IOS
> > 1.17.0-5.fc42 04/01/2014
> > [  408.072310] Workqueue: ceph-msgr ceph_con_workfn
> > [  408.072314] RIP: 0010:ceph_con_v2_try_read+0x4b39/0x72f0
> > [  408.072317] Code: c7 c1 20 f0 d4 ae 50 31 d2 48 c7 c6 60 27 d5 ae 48=
 c7 c7 f8
> > 8e 6f b0 68 60 38 d5 ae e8 00 47 61 fe 48 83 c4 18 e9 ac fc ff ff <0f> =
0b e9 06
> > fe ff ff 4c 8b 9d 98 fd ff ff 0f 84 64 e7 ff ff 89 85
> > [  408.072319] RSP: 0018:ffff88811c3e7a30 EFLAGS: 00010246
> > [  408.072322] RAX: ffffed1024874c6f RBX: ffffea00042c2b40 RCX: 0000000=
000000f38
> > [  408.072324] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000=
000000000
> > [  408.072325] RBP: ffff88811c3e7ca8 R08: 0000000000000000 R09: 0000000=
0000000c8
> > [  408.072326] R10: 00000000000000c8 R11: 0000000000000000 R12: 0000000=
0000000c8
> > [  408.072327] R13: dffffc0000000000 R14: ffff8881243a6030 R15: 0000000=
000003000
> > [  408.072329] FS:  0000000000000000(0000) GS:ffff88823eadf000(0000)
> > knlGS:0000000000000000
> > [  408.072331] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [  408.072332] CR2: 000000c0003c6000 CR3: 000000010c106005 CR4: 0000000=
000772ef0
> > [  408.072336] PKRU: 55555554
> > [  408.072337] Call Trace:
> > [  408.072338]  <TASK>
> > [  408.072340]  ? sched_clock_noinstr+0x9/0x10
> > [  408.072344]  ? __pfx_ceph_con_v2_try_read+0x10/0x10
> > [  408.072347]  ? _raw_spin_unlock+0xe/0x40
> > [  408.072349]  ? finish_task_switch.isra.0+0x15d/0x830
> > [  408.072353]  ? __kasan_check_write+0x14/0x30
> > [  408.072357]  ? mutex_lock+0x84/0xe0
> > [  408.072359]  ? __pfx_mutex_lock+0x10/0x10
> > [  408.072361]  ceph_con_workfn+0x27e/0x10e0
> > [  408.072364]  ? metric_delayed_work+0x311/0x2c50
> > [  408.072367]  process_one_work+0x611/0xe20
> > [  408.072371]  ? __kasan_check_write+0x14/0x30
> > [  408.072373]  worker_thread+0x7e3/0x1580
> > [  408.072375]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
> > [  408.072378]  ? __pfx_worker_thread+0x10/0x10
> > [  408.072381]  kthread+0x381/0x7a0
> > [  408.072383]  ? __pfx__raw_spin_lock_irq+0x10/0x10
> > [  408.072385]  ? __pfx_kthread+0x10/0x10
> > [  408.072387]  ? __kasan_check_write+0x14/0x30
> > [  408.072389]  ? recalc_sigpending+0x160/0x220
> > [  408.072392]  ? _raw_spin_unlock_irq+0xe/0x50
> > [  408.072394]  ? calculate_sigpending+0x78/0xb0
> > [  408.072395]  ? __pfx_kthread+0x10/0x10
> > [  408.072397]  ret_from_fork+0x2b6/0x380
> > [  408.072400]  ? __pfx_kthread+0x10/0x10
> > [  408.072402]  ret_from_fork_asm+0x1a/0x30
> > [  408.072406]  </TASK>
> > [  408.072407] ---[ end trace 0000000000000000 ]---
> > [  408.072418] Oops: general protection fault, probably for non-canonic=
al
> > address 0xdffffc0000000000: 0000 [#1] SMP KASAN NOPTI
> > [  408.072984] KASAN: null-ptr-deref in range [0x0000000000000000-
> > 0x0000000000000007]
> > [  408.073350] CPU: 1 UID: 0 PID: 392 Comm: kworker/1:3 Tainted: G     =
   W
> > 6.17.0-rc7+ #1 PREEMPT(voluntary)
> > [  408.073886] Tainted: [W]=3DWARN
> > [  408.074042] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), B=
IOS
> > 1.17.0-5.fc42 04/01/2014
> > [  408.074468] Workqueue: ceph-msgr ceph_con_workfn
> > [  408.074694] RIP: 0010:ceph_msg_data_advance+0x79/0x1a80
> > [  408.074976] Code: fc ff df 49 8d 77 08 48 c1 ee 03 80 3c 16 00 0f 85=
 07 11 00
> > 00 48 ba 00 00 00 00 00 fc ff df 49 8b 5f 08 48 89 de 48 c1 ee 03 <0f> =
b6 14 16
> > 84 d2 74 09 80 fa 03 0f 8e 0f 0e 00 00 8b 13 83 fa 03
> > [  408.075884] RSP: 0018:ffff88811c3e7990 EFLAGS: 00010246
> > [  408.076305] RAX: ffff8881243a6388 RBX: 0000000000000000 RCX: 0000000=
000000000
> > [  408.076909] RDX: dffffc0000000000 RSI: 0000000000000000 RDI: ffff888=
1243a6378
> > [  408.077466] RBP: ffff88811c3e7a20 R08: 0000000000000000 R09: 0000000=
0000000c8
> > [  408.078034] R10: ffff8881243a6388 R11: 0000000000000000 R12: ffffed1=
024874c71
> > [  408.078575] R13: dffffc0000000000 R14: ffff8881243a6030 R15: ffff888=
1243a6378
> > [  408.079159] FS:  0000000000000000(0000) GS:ffff88823eadf000(0000)
> > knlGS:0000000000000000
> > [  408.079736] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [  408.080039] CR2: 000000c0003c6000 CR3: 000000010c106005 CR4: 0000000=
000772ef0
> > [  408.080376] PKRU: 55555554
> > [  408.080513] Call Trace:
> > [  408.080630]  <TASK>
> > [  408.080729]  ceph_con_v2_try_read+0x49b9/0x72f0
> > [  408.081115]  ? __pfx_ceph_con_v2_try_read+0x10/0x10
> > [  408.081348]  ? _raw_spin_unlock+0xe/0x40
> > [  408.081538]  ? finish_task_switch.isra.0+0x15d/0x830
> > [  408.081768]  ? __kasan_check_write+0x14/0x30
> > [  408.081986]  ? mutex_lock+0x84/0xe0
> > [  408.082160]  ? __pfx_mutex_lock+0x10/0x10
> > [  408.082343]  ceph_con_workfn+0x27e/0x10e0
> > [  408.082529]  ? metric_delayed_work+0x311/0x2c50
> > [  408.082737]  process_one_work+0x611/0xe20
> > [  408.082948]  ? __kasan_check_write+0x14/0x30
> > [  408.083156]  worker_thread+0x7e3/0x1580
> > [  408.083331]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
> > [  408.083557]  ? __pfx_worker_thread+0x10/0x10
> > [  408.083751]  kthread+0x381/0x7a0
> > [  408.083922]  ? __pfx__raw_spin_lock_irq+0x10/0x10
> > [  408.084139]  ? __pfx_kthread+0x10/0x10
> > [  408.084310]  ? __kasan_check_write+0x14/0x30
> > [  408.084510]  ? recalc_sigpending+0x160/0x220
> > [  408.084708]  ? _raw_spin_unlock_irq+0xe/0x50
> > [  408.084917]  ? calculate_sigpending+0x78/0xb0
> > [  408.085138]  ? __pfx_kthread+0x10/0x10
> > [  408.085335]  ret_from_fork+0x2b6/0x380
> > [  408.085525]  ? __pfx_kthread+0x10/0x10
> > [  408.085720]  ret_from_fork_asm+0x1a/0x30
> > [  408.085922]  </TASK>
> > [  408.086036] Modules linked in: intel_rapl_msr intel_rapl_common
> > intel_uncore_frequency_common intel_pmc_core pmt_telemetry pmt_discovery
> > pmt_class intel_pmc_ssram_telemetry intel_vsec kvm_intel joydev kvm irq=
bypass
> > polyval_clmulni ghash_clmulni_intel aesni_intel rapl input_leds psmouse
> > serio_raw i2c_piix4 vga16fb bochs vgastate i2c_smbus floppy mac_hid qem=
u_fw_cfg
> > pata_acpi sch_fq_codel rbd msr parport_pc ppdev lp parport efi_pstore
> > [  408.087778] ---[ end trace 0000000000000000 ]---
> > [  408.088007] RIP: 0010:ceph_msg_data_advance+0x79/0x1a80
> > [  408.088260] Code: fc ff df 49 8d 77 08 48 c1 ee 03 80 3c 16 00 0f 85=
 07 11 00
> > 00 48 ba 00 00 00 00 00 fc ff df 49 8b 5f 08 48 89 de 48 c1 ee 03 <0f> =
b6 14 16
> > 84 d2 74 09 80 fa 03 0f 8e 0f 0e 00 00 8b 13 83 fa 03
> > [  408.089118] RSP: 0018:ffff88811c3e7990 EFLAGS: 00010246
> > [  408.089357] RAX: ffff8881243a6388 RBX: 0000000000000000 RCX: 0000000=
000000000
> > [  408.089678] RDX: dffffc0000000000 RSI: 0000000000000000 RDI: ffff888=
1243a6378
> > [  408.090020] RBP: ffff88811c3e7a20 R08: 0000000000000000 R09: 0000000=
0000000c8
> > [  408.090360] R10: ffff8881243a6388 R11: 0000000000000000 R12: ffffed1=
024874c71
> > [  408.090687] R13: dffffc0000000000 R14: ffff8881243a6030 R15: ffff888=
1243a6378
> > [  408.091035] FS:  0000000000000000(0000) GS:ffff88823eadf000(0000)
> > knlGS:0000000000000000
> > [  408.091452] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [  408.092015] CR2: 000000c0003c6000 CR3: 000000010c106005 CR4: 0000000=
000772ef0
> > [  408.092530] PKRU: 55555554
> > [  417.112915]
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [  417.113491] BUG: KASAN: slab-use-after-free in
> > __mutex_lock.constprop.0+0x1522/0x1610
> > [  417.114014] Read of size 4 at addr ffff888124870034 by task kworker/=
2:0/4951
> >=20
> > [  417.114587] CPU: 2 UID: 0 PID: 4951 Comm: kworker/2:0 Tainted: G    =
  D W
> > 6.17.0-rc7+ #1 PREEMPT(voluntary)
> > [  417.114592] Tainted: [D]=3DDIE, [W]=3DWARN
> > [  417.114593] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), B=
IOS
> > 1.17.0-5.fc42 04/01/2014
> > [  417.114596] Workqueue: events handle_timeout
> > [  417.114601] Call Trace:
> > [  417.114602]  <TASK>
> > [  417.114604]  dump_stack_lvl+0x5c/0x90
> > [  417.114610]  print_report+0x171/0x4dc
> > [  417.114613]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
> > [  417.114617]  ? kasan_complete_mode_report_info+0x80/0x220
> > [  417.114621]  kasan_report+0xbd/0x100
> > [  417.114625]  ? __mutex_lock.constprop.0+0x1522/0x1610
> > [  417.114628]  ? __mutex_lock.constprop.0+0x1522/0x1610
> > [  417.114630]  __asan_report_load4_noabort+0x14/0x30
> > [  417.114633]  __mutex_lock.constprop.0+0x1522/0x1610
> > [  417.114635]  ? queue_con_delay+0x8d/0x200
> > [  417.114638]  ? __pfx___mutex_lock.constprop.0+0x10/0x10
> > [  417.114641]  ? __send_subscribe+0x529/0xb20
> > [  417.114644]  __mutex_lock_slowpath+0x13/0x20
> > [  417.114646]  mutex_lock+0xd4/0xe0
> > [  417.114649]  ? __pfx_mutex_lock+0x10/0x10
> > [  417.114652]  ? ceph_monc_renew_subs+0x2a/0x40
> > [  417.114654]  ceph_con_keepalive+0x22/0x110
> > [  417.114656]  handle_timeout+0x6b3/0x11d0
> > [  417.114659]  ? _raw_spin_unlock_irq+0xe/0x50
> > [  417.114662]  ? __pfx_handle_timeout+0x10/0x10
> > [  417.114664]  ? queue_delayed_work_on+0x8e/0xa0
> > [  417.114669]  process_one_work+0x611/0xe20
> > [  417.114672]  ? __kasan_check_write+0x14/0x30
> > [  417.114676]  worker_thread+0x7e3/0x1580
> > [  417.114678]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
> > [  417.114682]  ? __pfx_sched_setscheduler_nocheck+0x10/0x10
> > [  417.114687]  ? __pfx_worker_thread+0x10/0x10
> > [  417.114689]  kthread+0x381/0x7a0
> > [  417.114692]  ? __pfx__raw_spin_lock_irq+0x10/0x10
> > [  417.114694]  ? __pfx_kthread+0x10/0x10
> > [  417.114697]  ? __kasan_check_write+0x14/0x30
> > [  417.114699]  ? recalc_sigpending+0x160/0x220
> > [  417.114703]  ? _raw_spin_unlock_irq+0xe/0x50
> > [  417.114705]  ? calculate_sigpending+0x78/0xb0
> > [  417.114707]  ? __pfx_kthread+0x10/0x10
> > [  417.114710]  ret_from_fork+0x2b6/0x380
> > [  417.114713]  ? __pfx_kthread+0x10/0x10
> > [  417.114715]  ret_from_fork_asm+0x1a/0x30
> > [  417.114720]  </TASK>
> >=20
> > [  417.125171] Allocated by task 2:
> > [  417.125333]  kasan_save_stack+0x26/0x60
> > [  417.125522]  kasan_save_track+0x14/0x40
> > [  417.125742]  kasan_save_alloc_info+0x39/0x60
> > [  417.125945]  __kasan_slab_alloc+0x8b/0xb0
> > [  417.126133]  kmem_cache_alloc_node_noprof+0x13b/0x460
> > [  417.126381]  copy_process+0x320/0x6250
> > [  417.126595]  kernel_clone+0xb7/0x840
> > [  417.126792]  kernel_thread+0xd6/0x120
> > [  417.126995]  kthreadd+0x85c/0xbe0
> > [  417.127176]  ret_from_fork+0x2b6/0x380
> > [  417.127378]  ret_from_fork_asm+0x1a/0x30
> >=20
> > [  417.127692] Freed by task 0:
> > [  417.127851]  kasan_save_stack+0x26/0x60
> > [  417.128057]  kasan_save_track+0x14/0x40
> > [  417.128267]  kasan_save_free_info+0x3b/0x60
> > [  417.128491]  __kasan_slab_free+0x6c/0xa0
> > [  417.128708]  kmem_cache_free+0x182/0x550
> > [  417.128906]  free_task+0xeb/0x140
> > [  417.129070]  __put_task_struct+0x1d2/0x4f0
> > [  417.129259]  __put_task_struct_rcu_cb+0x15/0x20
> > [  417.129480]  rcu_do_batch+0x3d3/0xe70
> > [  417.129681]  rcu_core+0x549/0xb30
> > [  417.129839]  rcu_core_si+0xe/0x20
> > [  417.130005]  handle_softirqs+0x160/0x570
> > [  417.130190]  __irq_exit_rcu+0x189/0x1e0
> > [  417.130369]  irq_exit_rcu+0xe/0x20
> > [  417.130531]  sysvec_apic_timer_interrupt+0x9f/0xd0
> > [  417.130768]  asm_sysvec_apic_timer_interrupt+0x1b/0x20
> >=20
> > [  417.131082] Last potentially related work creation:
> > [  417.131305]  kasan_save_stack+0x26/0x60
> > [  417.131484]  kasan_record_aux_stack+0xae/0xd0
> > [  417.131695]  __call_rcu_common+0xcd/0x14b0
> > [  417.131909]  call_rcu+0x31/0x50
> > [  417.132071]  delayed_put_task_struct+0x128/0x190
> > [  417.132295]  rcu_do_batch+0x3d3/0xe70
> > [  417.132478]  rcu_core+0x549/0xb30
> > [  417.132658]  rcu_core_si+0xe/0x20
> > [  417.132808]  handle_softirqs+0x160/0x570
> > [  417.132993]  __irq_exit_rcu+0x189/0x1e0
> > [  417.133181]  irq_exit_rcu+0xe/0x20
> > [  417.133353]  sysvec_apic_timer_interrupt+0x9f/0xd0
> > [  417.133584]  asm_sysvec_apic_timer_interrupt+0x1b/0x20
> >=20
> > [  417.133921] Second to last potentially related work creation:
> > [  417.134183]  kasan_save_stack+0x26/0x60
> > [  417.134362]  kasan_record_aux_stack+0xae/0xd0
> > [  417.134566]  __call_rcu_common+0xcd/0x14b0
> > [  417.134782]  call_rcu+0x31/0x50
> > [  417.134929]  put_task_struct_rcu_user+0x58/0xb0
> > [  417.135143]  finish_task_switch.isra.0+0x5d3/0x830
> > [  417.135366]  __schedule+0xd30/0x5100
> > [  417.135534]  schedule_idle+0x5a/0x90
> > [  417.135712]  do_idle+0x25f/0x410
> > [  417.135871]  cpu_startup_entry+0x53/0x70
> > [  417.136053]  start_secondary+0x216/0x2c0
> > [  417.136233]  common_startup_64+0x13e/0x141
> >=20
> > [  417.136894] The buggy address belongs to the object at ffff888124870=
000
> >                 which belongs to the cache task_struct of size 10504
> > [  417.138122] The buggy address is located 52 bytes inside of
> >                 freed 10504-byte region [ffff888124870000, ffff88812487=
2908)
> >=20
> > [  417.139465] The buggy address belongs to the physical page:
> > [  417.140016] page: refcount:0 mapcount:0 mapping:0000000000000000 ind=
ex:0x0
> > pfn:0x124870
> > [  417.140789] head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapp=
ed:0
> > pincount:0
> > [  417.141519] memcg:ffff88811aa20e01
> > [  417.141874] anon flags:
> > 0x17ffffc0000040(head|node=3D0|zone=3D2|lastcpupid=3D0x1fffff)
> > [  417.142600] page_type: f5(slab)
> > [  417.142922] raw: 0017ffffc0000040 ffff88810094f040 0000000000000000
> > dead000000000001
> > [  417.143554] raw: 0000000000000000 0000000000030003 00000000f5000000
> > ffff88811aa20e01
> > [  417.143954] head: 0017ffffc0000040 ffff88810094f040 0000000000000000
> > dead000000000001
> > [  417.144329] head: 0000000000000000 0000000000030003 00000000f5000000
> > ffff88811aa20e01
> > [  417.144710] head: 0017ffffc0000003 ffffea0004921c01 00000000ffffffff
> > 00000000ffffffff
> > [  417.145106] head: ffffffffffffffff 0000000000000000 00000000ffffffff
> > 0000000000000008
> > [  417.145485] page dumped because: kasan: bad access detected
> >=20
> > [  417.145859] Memory state around the buggy address:
> > [  417.146094]  ffff88812486ff00: fc fc fc fc fc fc fc fc fc fc fc fc f=
c fc fc
> > fc
> > [  417.146439]  ffff88812486ff80: fc fc fc fc fc fc fc fc fc fc fc fc f=
c fc fc
> > fc
> > [  417.146791] >ffff888124870000: fa fb fb fb fb fb fb fb fb fb fb fb f=
b fb fb
> > fb
> > [  417.147145]                                      ^
> > [  417.147387]  ffff888124870080: fb fb fb fb fb fb fb fb fb fb fb fb f=
b fb fb
> > fb
> > [  417.147751]  ffff888124870100: fb fb fb fb fb fb fb fb fb fb fb fb f=
b fb fb
> > fb
> > [  417.148123]
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >=20
> > First of all, we have warning in get_bvec_at() because
> > cursor->total_resid contains zero value. And, finally,
> > we have crash in ceph_msg_data_advance() because
> > cursor->data is NULL. It means that get_bvec_at()
> > receives not initialized ceph_msg_data_cursor structure
> > because data is NULL and total_resid contains zero.
> >=20
> > Moreover, we don't have likewise issue for the case of
> > Ceph msgr1 protocol because ceph_msg_data_cursor_init()
> > has been called before reading sparse data.
> >=20
> > This patch adds calling of ceph_msg_data_cursor_init()
> > in the beginning of process_v2_sparse_read() with
> > the goal to guarantee that logic of reading sparse data
> > works correctly for the case of Ceph msgr2 protocol.
> >=20
> > [1] https://tracker.ceph.com/issues/73152 =20
> >=20
> > Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> > cc: Alex Markuze <amarkuze@redhat.com>
> > cc: Ilya Dryomov <idryomov@gmail.com>
> > cc: Ceph Development <ceph-devel@vger.kernel.org>
> > ---
> >  net/ceph/messenger.c    | 1 +
> >  net/ceph/messenger_v2.c | 2 ++
> >  2 files changed, 3 insertions(+)
> >=20
> > diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
> > index f8181acaf870..02d2fc075ce7 100644
> > --- a/net/ceph/messenger.c
> > +++ b/net/ceph/messenger.c
> > @@ -1129,6 +1129,7 @@ void ceph_msg_data_advance(struct ceph_msg_data_c=
ursor *cursor, size_t bytes)
> >         bool new_piece;
> >=20
> >         BUG_ON(bytes > cursor->resid);
> > +       BUG_ON(!cursor->data);
>=20
> Hi Slava,
>=20
> What is the reason for adding this BUG_ON?  If cursor->data is NULL,
> it should result in a distinctive crash on the very next line because
> the data item is dereferenced there to get its type.
>=20
> I'd rather we remove some existing BUG_ONs than add more of them.

We crashed here because of trying to dereference the cursor->data that is N=
ULL.
So, I've added this BUG_ON() to show that we expect to have cursor->data of
properly initialized.

Technically speaking, I can remove both BUG_ON() here, if you like. I remem=
ber
one of our discussion before and you said that BUG_ON() is good way to stop
execution at the issue place. :)

So, should I remove both BUG_ON()?

>=20
> >         switch (cursor->data->type) {
> >         case CEPH_MSG_DATA_PAGELIST:
> >                 new_piece =3D ceph_msg_data_pagelist_advance(cursor, by=
tes);
> > diff --git a/net/ceph/messenger_v2.c b/net/ceph/messenger_v2.c
> > index 9e39378eda00..445a60e6fe91 100644
> > --- a/net/ceph/messenger_v2.c
> > +++ b/net/ceph/messenger_v2.c
> > @@ -1064,6 +1064,8 @@ static int process_v2_sparse_read(struct ceph_con=
nection *con,
> >         struct ceph_msg_data_cursor *cursor =3D &con->v2.in_cursor;
>=20
> Instead of con->v2.in_cursor, I'd suggest using a private cursor here
> like it's done in setup_message_sgs().  This is to highlight to the
> reader that this cursor isn't being advanced as the data is read in
> (which requires maintaining connection-wide state) but rather just
> arranging a simple copy from con->v2.in_enc_pages to the user-provided
> buffer.

OK. If I understood correctly, you suggest this:

struct ceph_msg_data_cursor *cursor;

Am I correct?

>=20
> >         int ret;
> >=20
> > +       ceph_msg_data_cursor_init(cursor, con->in_msg, con->in_msg->dat=
a_length);
>=20
> This line is too wrong, please wrap before the last argument.

Any new line is wrong. ;) I see you.

It's only 81 symbols long. But, sure, I can wrap the line.

Thanks,
Slava.

