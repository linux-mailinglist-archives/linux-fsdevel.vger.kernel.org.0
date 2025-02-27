Return-Path: <linux-fsdevel+bounces-42784-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 054E8A488D7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2025 20:19:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7696D7A92E6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2025 19:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F9E26E96B;
	Thu, 27 Feb 2025 19:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iLyMpVlU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE031EFF83;
	Thu, 27 Feb 2025 19:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740683708; cv=fail; b=gqPAR8HoxjkF6x3U9wPGFgZNlh838Uxj5BfBaKDEYj4kBecEmu9WZo/SV1XIEvnksAJE3L9NB19DWhS1yBO7J6UlWLmKx0RHfcZhDFE/skwcC42h1VLVJwgbzM5uFRJwrNnNn7bBNmsCsBWU44PQb1Q0Pqkis5TaY8ncCsbRX9k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740683708; c=relaxed/simple;
	bh=DKDUfYxqwcBhHGgzqGEu+1sh7Jvhav6/Su/YMq31XwI=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=W78Q/kdrD3HHNMsWU679yvD1np23l/c9PhNBEp1V1kIcOhQQNR/tTHxuyQT5RNh3fq8JJ7biVsHbKIORjOJHWkgnVq7pV3aYaJUa5ac09YNa1eMSSDa9bMhcTFmgmgKYzRVmB4NFEleFi5j8xIrKDdkd7ryN5k36LF6oxP/cM8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iLyMpVlU; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51RFQ3UY020182;
	Thu, 27 Feb 2025 19:15:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=DKDUfYxqwcBhHGgzqGEu+1sh7Jvhav6/Su/YMq31XwI=; b=iLyMpVlU
	rwid6xw/U7WDTF/Kqnl7b+W4Y944GmodLu1YeRzxvW8BEwP8JXiG9zq6N4fIm8He
	3gIsCJ6CUdvoV/HqpyN/jVTiLYuTjbIJaT3Rjas2ouMLIcbTuFV+EmkHsLKyA0QE
	dQlGic3OzTKKp8pwL85SXBVCcZZ3jrpC7z21GwguZRbFH6RXLIRgiYVEDMvPXcJR
	LFEiySMzyH6xalRvWVBrgD6sZJtiSbiYKLwZk+t95LpPqO+O/R0paTwF61hTbLUJ
	4PyApJYwFFEECyb1K+yIYDfXMA4+mu6/QIPJb37vZiD0ueH9I5UfXPBmU346KLo7
	Iix1bATOVMNpag==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 452hv8v9mf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Feb 2025 19:15:02 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51RJE8xk026554;
	Thu, 27 Feb 2025 19:15:01 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2175.outbound.protection.outlook.com [104.47.73.175])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 452hv8v9m6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Feb 2025 19:15:01 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w6GJpZ9ZIdNoIQdU7ielKx8nzkzod5B8WyWAuNK7vB7Sybd+3w/14o5EWfTCzkxr2joZOSg2u5pDQ+6QP4dromND2/FgzAl+yHf7jQeSNoV4U2hanBDdAz9CEVf8DJzy5U6BfB/k8tVFX4AHD9W0QnUd6mJswN2z4QIUdLOu4hubcuizBw/aHAhLwCuWYYBYiaUMoP8NZ3qojMmBKlUT0/9FDhwaGKr2SwUd/wfUPcsOdPZ/f0QvSrgMRIElzC30ioyfsBHbszKXX7vf2HNECxaRmAzSvAaCCHewpymP66yGk3ST5e6t/5f5mUgx7a+6XjKp4w+xjih3iYjwSajHKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DKDUfYxqwcBhHGgzqGEu+1sh7Jvhav6/Su/YMq31XwI=;
 b=V8tF9xLCusQ6RB+3C2L7YSYupsiJRL/V8qTYUqiLYzc5kgE3mqoDrlDtP6Pd3JlzTieeufhq4VAo1uwp64KIs3JXTIuDUsBIEux36SC5lnCiu/BYDHtUQGW0auzi+l0rYCzObvQJpvv+fMSM/Y5sPuzozyodBnm3jb7orT30I7J5oOlJAKTx1byWI8AnWqdPOMhsFLBzrD8+k2StXZc1wS2kl8IgDbq7VESbQ7WZSxdWTUFvT1bTS3qqHZerfkqxRpHiEChctEwbajjHdoxIgTX+J3HRk2+vqqarXqUi9s8Ps8//D78MgxZbz9ASVni0cZ9zc0j51SvzxbFmheSn+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by IA1PR15MB6339.namprd15.prod.outlook.com (2603:10b6:208:444::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Thu, 27 Feb
 2025 19:14:56 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%4]) with mapi id 15.20.8489.018; Thu, 27 Feb 2025
 19:14:56 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "slava@dubeyko.com" <slava@dubeyko.com>,
        David Howells
	<dhowells@redhat.com>
CC: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        Alex Markuze
	<amarkuze@redhat.com>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        Patrick Donnelly <pdonnell@redhat.com>
Thread-Topic: [EXTERNAL] Re: [PATCH v2] ceph: fix slab-use-after-free in
 have_mon_and_osd_map()
Thread-Index: AQHbiQ3Zl/fqczNX/UiOPJFGY72VorNbhaoA
Date: Thu, 27 Feb 2025 19:14:56 +0000
Message-ID: <5597d089eecc8384a50f1c561fff9d438b7d0592.camel@ibm.com>
References: <20250226190515.314845-1-slava@dubeyko.com>
	 <3148392.1740657038@warthog.procyon.org.uk>
In-Reply-To: <3148392.1740657038@warthog.procyon.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|IA1PR15MB6339:EE_
x-ms-office365-filtering-correlation-id: 5192b266-d59e-4670-1c45-08dd576305d5
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UVZ4OVB2Ty9ZS1cxdWxFSTJGTGxGZCs0Rm5NbFBodU4za21sTjRUYUlzTFlO?=
 =?utf-8?B?Vk5LOVg2eVBFZjRtSnVHVm5KM2pRYnJabjMxRDhnV0FpWE5tMyszVU1wZGlT?=
 =?utf-8?B?MklqNVlOdHpyc1NlakJjL05TQTF4cm0rWjdUZ0JrNzRWTDZ2WEszeUNvM2hG?=
 =?utf-8?B?Z0lieG9DRHQvZEREa04wWC9BRitQZ0gwRVZaK0lGUmJpeFpQN0tsRCtwdmcz?=
 =?utf-8?B?NG1GVm5Hay9xMDMzV0d6M2ZpNE43MzZmNUhvanBod2x0Y0djSllpck9vdFNp?=
 =?utf-8?B?WUpJMFhNM3o1UEpFVWd3STVMcUd5S2pKWlV6THhQeC80M1FDMFo4dCtOazR5?=
 =?utf-8?B?empvZFFrVDg1TFpFYzJ3TW4rbVFucXJwY3UyZStRTm9keURwWFhjK2Z4alRW?=
 =?utf-8?B?ci9QMUtNSjhnaFgrSnVGaXg4Y1lTcmVJOVhudVh4TVZvVFZDcWNSVmRGUWkz?=
 =?utf-8?B?R3dRNDlPRWRWTzR1bDU0a2lhVmxmQUdVc2xJTlFRR3o5UXpoam1IK0lpeTJo?=
 =?utf-8?B?ZGdiR28vZkxBQWx6Qm5HamZhZFlla283QmREcWZOU2hmN014VGFJVjQzYXcv?=
 =?utf-8?B?SGpITGREaFlQeDBTaEthbkhMaTZWMzh0QmVJK1BtZkxPNStWSkFLbXJYYVVN?=
 =?utf-8?B?Y3FVN3RSTjdzbHpydlhjV2tTZzF2eG5Ub3hNbExmcGI0ZkxUN28vT1JPRHZK?=
 =?utf-8?B?QkFsV09BK1lHZTJPUlQ2alVOSi9kRnhZL1ZrdysxMkhpUE5pNGlUcysxNG1F?=
 =?utf-8?B?Nm9Udjk1QUkydFMrWHFiblBEMzZ6SHQ1eXBDSU1jNm1lNnZIWE1VdzBFTnJX?=
 =?utf-8?B?Vmtram1hbWE4S3o2T1Rhc3VXdWNGN0VZRnYrS1ZXUmFhMGduV25JZGxBWDNv?=
 =?utf-8?B?aVRBWmJVcnMxU0M4L2JDWGZlN2tCeCs4RExPYUVLTFB5UzR5NGlLekcyWHEw?=
 =?utf-8?B?b0doUkZzTGE2dDUwVndDWm5hbkhNeEl3ei9WMGJNV3lVbUdBMzVnZ2QweTVv?=
 =?utf-8?B?Z1h4UG4wNy9naGw5bHZNblBIK2s5Z3FlQ2szYVpyQkJHQlFhTEF2UnlucnBv?=
 =?utf-8?B?dXpUZGtkNFNQa2NGVlliN29lYnJwUXg5YUlXVEJJSGE4RDZVODhGYXNRUUN6?=
 =?utf-8?B?UHp4NzA5eHpIVkxhT1REdVFwTkVmRFl2ZlZNUU5XQldJRDJjbFZtQkNMNHN0?=
 =?utf-8?B?YWt1QWRaUmlNZEVNSmQwZ2xRT0xpUldEN2VUOVJYbUIwdzJ0WVM5V21GT2RP?=
 =?utf-8?B?QVVQZUxYY3ZzRDN2Q0RLdTFNZ3BvZlpValFvTnQ5cHN5clAxRTl6MnRxYnpt?=
 =?utf-8?B?TUNkenV6bTZFRk9BNkkxOHhxaHlDMjV3NXVqUDVIZjErQjh5N1ZDbzdWT01W?=
 =?utf-8?B?c3NSNW5WajVSckZaNzlhWkY0YXlNcU9MSW1xR3JFd09GdXcrWmlPUG5IVE0w?=
 =?utf-8?B?VnFMdWI2L1E4ek1XdVRBTW1qWUNsb2xrdUZOeGZQZlNyRnY5VXRHRW1GV2dJ?=
 =?utf-8?B?ZzFTUytzR2RQdThLN1IvR0h5TnpBNEdMdjFGUHc1NHZPWnkwQ0RhcWtjRmhu?=
 =?utf-8?B?Q0tmbXJDRDFNdUU1OVpURlBSVXdKb2xSaFp1YnRZTFk1b3BQRDZnekxPcUoz?=
 =?utf-8?B?KzdHSjBQZzRlTHhxdjVVM1lzZ09wUTFMR3ZKOU9MOFpBazRPNHQrVTJOSWZQ?=
 =?utf-8?B?Zy9pdlVwUisxdjFCUU9oUUJ6OTBQSU5EOThKenFWRi9ZaTBmSVBTek5rYjNK?=
 =?utf-8?B?VmU4WFQreGxwRGVUNDVsNGllWGdHbEpxdmZpN3JoRDdHaDdIVXBEMEk5bWJw?=
 =?utf-8?B?NXpUYldsSHZFVFcrQzV3MjFPWk4vSU9iR0ZOSG9yQURKQXUrREVjMElub1BM?=
 =?utf-8?B?OGlNaDg5M3F6YmFQVFp1d09BaUJUWlFvbVFwRmFndkdPRHNLd3psczJ6VUVG?=
 =?utf-8?Q?M0nwdQyFODXG1PsQFZSzidcpQNk1a1eW?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dElheUUrZ25QdHhNRTlJemtoNVFWYnRGZENWVHoxeDlsYndRRU96WkFBTlF4?=
 =?utf-8?B?eXpBYnFON2FvNFJCVVYrb2cydGUvTTkybVF2b3NaTUtQSXBuWEduUzliWkNx?=
 =?utf-8?B?K01XdXc1ZDVISCtqVEU0RzQ2WUxDQXlHRmNRbUJyQnRyVVhuZmZsMGNiTjZF?=
 =?utf-8?B?NjljcEM3aXIyTElpeEE5K2RTMmlORmdDZXVOc1JjenVnNmVwSUFVZlZEanZk?=
 =?utf-8?B?OG43VHdJRGxGZkQ1YUNGcnNIbFZWcHBvSzNkcFdOMjFTdGlFR0t2ODg2Zks5?=
 =?utf-8?B?bzVBV2ZwRXR2R3pyT1BOb0xlK1hlVHlhOVBJWTk3bk80MUZRbDE3L1YvYWxC?=
 =?utf-8?B?TGtmcXBiZjlpUlorT0I4UkNYQzRZd04xWUtIMWZ2aU9MOEJDMWpOL3V3SmRR?=
 =?utf-8?B?REJXNnVEcXR4YjhUTkpBRmxBZXNwMkhzaEJuMWV6eTBEalZiWk1Sa3JXZnl4?=
 =?utf-8?B?SG5TUmZadmVOMWRRd3Z6dGZCc21RWlU0bkxzTGhSNjlGNjhRcno4ZVpYOXlj?=
 =?utf-8?B?Mit5S2phZk0wMmNNMHBhMkdvdWEzdUY4VFUzVWhpV0ppWC9jTHBHTXpZWkVW?=
 =?utf-8?B?aFA5REE3UHU0SnZkRTZnYmJGVkRGaXVaVy9qVFB4aDVpeDlOSW13VU1tMzZk?=
 =?utf-8?B?Wk5KblduRnd5bkE0aGhRYldsM2pTL3pZQ3ZFa2Q4cDg2dHpQdzNDYTBYSkFP?=
 =?utf-8?B?SGhkTURBa1BzbE15SUk1aDR5U3doU2NWc25pRk1FM1cyVGhMamd4TnNUQ0Fv?=
 =?utf-8?B?VHkra2FhUmQ2bWphdmVQT0Y0bTVlcnlxZHJvS2Y1VXliOUdvOFRjL3dWSGJC?=
 =?utf-8?B?bUxUanRwNEVVRlNaMWtNdEV6amJCem1iTUhDa1NEN1dVWldRRUxYN3JpWDN1?=
 =?utf-8?B?U1Fqdk9yTEhiWEhQOHFrc3dRYyt5M2FwT2hKWW43ZTQ4bC9vWi9VMUdiK1Jx?=
 =?utf-8?B?USs3cnFvWjM2b0xXdnhNdXFqVkVuTzFFMU9QbGZ1eDVRSEFRUFdLNzdmSERx?=
 =?utf-8?B?QUFLODJkWkE4aFA2TXJPTjhGRENDS2Qxc2FITHJ6T295cjB1MFc1WWo2dzdO?=
 =?utf-8?B?dTAva0FFU1FsZTJWRU5NYWplbTFjR1JjOFV4KzBnV2dERzRSb3V4dHMyNFRk?=
 =?utf-8?B?RFRMT2FjOVowaiswR01TMkRwYVNsRlNZU2tCVlE4S2JGYTJsNlRaSTR3bHpW?=
 =?utf-8?B?Y0I2TjYyRGRJOVBkRjhMOUZIb3VJQkdPUmVvREZxT0t0bXNZWkN4MG1wYSs1?=
 =?utf-8?B?cEx2OFRIMU1DSHVWK3dSeGFKWVZYOE4vRHNGQ3I3SzlrdTl0ZXo1RVpLdWxQ?=
 =?utf-8?B?NWdhZldhM3dvRFU3c211cG54THg3K3l1d2xlcjRlU1Noa2kyM2F0eW4wQ29F?=
 =?utf-8?B?Vk91S3I4WnBhSkRCUSt5bjZBeGR6SDN3eU9xSjFWK0xNTnFqYkRCdlEvaHcy?=
 =?utf-8?B?VkJyU1QzeWZwcmpjdGt0bEpjdU1tWTNPNSs4bHhKUytXek9mWjNqUDdqQ21C?=
 =?utf-8?B?QU15WjBxbS9NRnZyZ3lCTVlLLzBoQXo1UVhxR08vc3ZJNEdsTWk0MDJXWE83?=
 =?utf-8?B?QkQ4dElBK3dUazVCUzh4QVFROWsrY3VtOHVTTWt3am9YajFqM0ZOR0hqQ2Zh?=
 =?utf-8?B?ZXB2M0RDSUE5eGFmTjh1RFpEMFBrdEJQMnUybEg1d25qazlmWkVGVk1xaGh6?=
 =?utf-8?B?ODNSNkJCU3lFU2wvbkdsUWUvekdtRUcxSS9FWGtjbXE3ZG03NmhBRUxEY2tF?=
 =?utf-8?B?UlQrSE1YUVBwVmpOK3NVNmo5NG9xek4reVNZOHo3MzVhZFQ2S2N4a2JZZlE1?=
 =?utf-8?B?cXRnK1poRVlGbkZFaFFOTE0vV1Z4Y2IvbzZiR2U2bWU0dWdNQmRaQXFDRDFj?=
 =?utf-8?B?TXJrb3R2Ukk1eVBoa3lpdTZPYWFGU2xsaWdpbGF1M0xXU2MzMmRCZDQreE5H?=
 =?utf-8?B?YURHY2tGR1g0THkwVDVHTnJRWkp3VFNkcmlWK1d4TkJWQlA4U1dON0JjejB6?=
 =?utf-8?B?S1gxcFVwamFlUk4vWitsNm1uVzY4M1Y0ZHNsT0EzVGRtMjF5YVdIV0p5YmdJ?=
 =?utf-8?B?VEY4TzJ1b1I0R1lsTDVCSzlUdlp4QUh2VHJSUm9uRGUvMGdkSnI5R3hIZ3pq?=
 =?utf-8?B?M241UXFPQVZLWWRJdjBRUkJDdFJlS0pvZ2V4cmxEdlA2MjQ1SWR1MENkSUF0?=
 =?utf-8?Q?DhwXGfLlfHCS+swxVboVEsY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7B2FAE266FF9BD4596495D863E4CCE42@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5192b266-d59e-4670-1c45-08dd576305d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2025 19:14:56.7165
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uDGgX1oZ0MGsIIcer8o0tUS1J9ZhM3XTTOybeyEVczwetIZ6AY538ccsxo3qN66t5cywEHWjDJ34kC5FEu6QAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR15MB6339
X-Proofpoint-ORIG-GUID: TAGiU3SLGGjHRB82vAR7Z69RQLdLeaMI
X-Proofpoint-GUID: _EfpDHoFOhSoS4pQ1nfGRi7BAQL9xAwi
Subject: RE: [PATCH v2] ceph: fix slab-use-after-free in have_mon_and_osd_map()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_07,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0
 impostorscore=0 mlxlogscore=795 priorityscore=1501 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2502270141

T24gVGh1LCAyMDI1LTAyLTI3IGF0IDExOjUwICswMDAwLCBEYXZpZCBIb3dlbGxzIHdyb3RlOg0K
PiBWaWFjaGVzbGF2IER1YmV5a28gPHNsYXZhQGR1YmV5a28uY29tPiB3cm90ZToNCj4gDQo+ID4g
VGhpcyBwYXRjaCBmaXhlcyB0aGUgaXNzdWUgYnkgbWVhbnMgb2YgbG9ja2luZw0KPiA+IGNsaWVu
dC0+b3NkYy5sb2NrIGFuZCBjbGllbnQtPm1vbmMubXV0ZXggYmVmb3JlDQo+ID4gdGhlIGNoZWNr
aW5nIGNsaWVudC0+b3NkYy5vc2RtYXAgYW5kDQo+ID4gY2xpZW50LT5tb25jLm1vbm1hcC4NCj4g
DQo+IFlvdSd2ZSBhbHNvIGFkZGVkIGNsZWFyYW5jZSBvZiBhIGJ1bmNoIG9mIHBvaW50ZXJzIGlu
dG8gZGVzdHJ1Y3Rpb24gYW5kIGVycm9yDQo+IGhhbmRsaW5nIHBhdGhzIChjYW4gSSByZWNvbW1l
bmQgeW91IG1lbnRpb24gaXQgaW4gdGhlIGNvbW1pdCBtZXNzYWdlPykuwqANCj4gDQoNClllcywg
bWFrZXMgc2Vuc2UuIEkgbWlzc2VkIHRvIGFkZCB0aGVzZSBkZXRhaWxzIGludG8gdGhlIGNvbW1p
dCBtZXNzYWdlLiBJIGNhbg0KZG8gaXQuDQoNCj4gIElzDQo+IHRoYXQgYSAianVzdCBpbiBjYXNl
IiB0aGluZz8gIEl0IGRvZXNuJ3QgbG9vayBsaWtlIHRoZSBjbGllbnQgY2FuIGdldA0KPiByZXN1
cnJlY3RlZCBhZnRlcndhcmRzLCBidXQgSSBtYXkgaGF2ZSBtaXNzZWQgc29tZXRoaW5nLiAgSWYg
aXQncyBub3QganVzdCBpbg0KPiBjYXNlLCBkb2VzIHRoZSBhY2Nlc3MgYW5kIGNsZWFyYW5jZSBv
ZiB0aGUgcG9pbnRlcnMgbmVlZCB3cmFwcGluZyBpbiB0aGUNCj4gYXBwcm9wcmlhdGUgbG9jaz8N
Cj4gDQoNCkxldCBtZSBkb3VibGUgY2hlY2sgaXQuIFByb2JhYmx5LCB5b3UgYXJlIHJpZ2h0IGhl
cmUuDQoNCj4gPiAtLS0gYS9uZXQvY2VwaC9kZWJ1Z2ZzLmMNCj4gPiArKysgYi9uZXQvY2VwaC9k
ZWJ1Z2ZzLmMNCj4gPiBAQCAtMzYsMTggKzM2LDIwIEBAIHN0YXRpYyBpbnQgbW9ubWFwX3Nob3co
c3RydWN0IHNlcV9maWxlICpzLCB2b2lkICpwKQ0KPiA+ICAJaW50IGk7DQo+ID4gIAlzdHJ1Y3Qg
Y2VwaF9jbGllbnQgKmNsaWVudCA9IHMtPnByaXZhdGU7DQo+ID4gIA0KPiA+IC0JaWYgKGNsaWVu
dC0+bW9uYy5tb25tYXAgPT0gTlVMTCkNCj4gPiAtCQlyZXR1cm4gMDsNCj4gPiAtDQo+ID4gLQlz
ZXFfcHJpbnRmKHMsICJlcG9jaCAlZFxuIiwgY2xpZW50LT5tb25jLm1vbm1hcC0+ZXBvY2gpOw0K
PiA+IC0JZm9yIChpID0gMDsgaSA8IGNsaWVudC0+bW9uYy5tb25tYXAtPm51bV9tb247IGkrKykg
ew0KPiA+IC0JCXN0cnVjdCBjZXBoX2VudGl0eV9pbnN0ICppbnN0ID0NCj4gPiAtCQkJJmNsaWVu
dC0+bW9uYy5tb25tYXAtPm1vbl9pbnN0W2ldOw0KPiA+IC0NCj4gPiAtCQlzZXFfcHJpbnRmKHMs
ICJcdCVzJWxsZFx0JXNcbiIsDQo+ID4gLQkJCSAgIEVOVElUWV9OQU1FKGluc3QtPm5hbWUpLA0K
PiA+IC0JCQkgICBjZXBoX3ByX2FkZHIoJmluc3QtPmFkZHIpKTsNCj4gPiArCW11dGV4X2xvY2so
JmNsaWVudC0+bW9uYy5tdXRleCk7DQo+ID4gKwlpZiAoY2xpZW50LT5tb25jLm1vbm1hcCkgew0K
PiA+ICsJCXNlcV9wcmludGYocywgImVwb2NoICVkXG4iLCBjbGllbnQtPm1vbmMubW9ubWFwLT5l
cG9jaCk7DQo+ID4gKwkJZm9yIChpID0gMDsgaSA8IGNsaWVudC0+bW9uYy5tb25tYXAtPm51bV9t
b247IGkrKykgew0KPiA+ICsJCQlzdHJ1Y3QgY2VwaF9lbnRpdHlfaW5zdCAqaW5zdCA9DQo+ID4g
KwkJCQkmY2xpZW50LT5tb25jLm1vbm1hcC0+bW9uX2luc3RbaV07DQo+ID4gKw0KPiA+ICsJCQlz
ZXFfcHJpbnRmKHMsICJcdCVzJWxsZFx0JXNcbiIsDQo+ID4gKwkJCQkgICBFTlRJVFlfTkFNRShp
bnN0LT5uYW1lKSwNCj4gPiArCQkJCSAgIGNlcGhfcHJfYWRkcigmaW5zdC0+YWRkcikpOw0KPiA+
ICsJCX0NCj4gPiAgCX0NCj4gPiArCW11dGV4X3VubG9jaygmY2xpZW50LT5tb25jLm11dGV4KTsN
Cj4gPiArDQo+ID4gIAlyZXR1cm4gMDsNCj4gPiAgfQ0KPiA+ICANCj4gDQo+IFlvdSBtaWdodCB3
YW50IHRvIGxvb2sgYXQgdXNpbmcgUkNVIGZvciB0aGlzICh0aG91Z2ggbm90IG5lY2Vzc2FyaWx5
IGFzIHBhcnQNCj4gb2YgdGhpcyBmaXgpLg0KPiANCg0KUG90ZW50aWFsbHksIFJDVSBjb3VsZCBi
ZSBnb29kIHRvIHVzZSBoZXJlLiBMZXQgbWUgdGhpbmsgYWJvdXQgaXQuIEkgc2ltcGx5IG5lZWQN
CnRvIGVsYWJvcmF0ZSBhIGJhbGFuY2Ugb2YgbW9kaWZpY2F0aW9ucyBhbmQgcG90ZW50aWFsIGJl
bmVmaXRzLg0KDQpUaGFua3MsDQpTbGF2YS4NCg0K

