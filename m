Return-Path: <linux-fsdevel+bounces-65932-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E89C158E9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 16:43:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 222BA5684BD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 15:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1313F34676E;
	Tue, 28 Oct 2025 15:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aCkgbCgy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB336340A47;
	Tue, 28 Oct 2025 15:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761665669; cv=fail; b=cnVX/mnSqTkhY14wAfMphzkBIT6VB6/UFbfTxzUFZv4HGP1jF+oi4s4j/ff50Bm0oN1xW3a/JEOG2QL5fhczQs7w+uvr8vt6fO0f7QFm+qYx0DKpke2F6P6LZkzoePmO5YHNnA7gWpkq9wS5MCdwfzFWthl+GnfjmusDEtjphSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761665669; c=relaxed/simple;
	bh=Ea0LHcUpmRn9HBEVPc0ypCavO6P+piaNbKf5Iv1fDNY=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=rhjDfh/J5k5MMipnhOh/wTvH0A9Ri69dzRJGPad4biHzyjozCvxNPqOcnHTQ8l4knGjT7zY/tu6p/zLyrIqBsLQNxfxunaSSmjNpLMsHIhnTEqgPzJpaavGvQGB1psN3vBcRmmYqokUsgYU1YaOnR7IGuxFeyX6xq5epcDPFMAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aCkgbCgy; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59SDwT7D020055;
	Tue, 28 Oct 2025 15:34:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=Ea0LHcUpmRn9HBEVPc0ypCavO6P+piaNbKf5Iv1fDNY=; b=aCkgbCgy
	M/1Gs6ngR1Y2c+cd1OIKrwqVQVruBRooSgAKNgbJRRY0wbDMvIBAplnmeVTY/e8u
	pElMQvPPfT4czX4dj+qdy+kSqiufC7vdaiJcSdRnr+7lV/TAwVD1XrnuJkr3p+90
	FgCD4uNBoYgS/aEMu6tlUhIiRo8MJi1yZUyZXIRtafZcopV57K9vLoOhnANxkzvD
	dJzw+f2iL+w3DSUsck834RfOTN6X7zbbuuQfTVNzps88eoS3GguE7i2jIxwyWH6n
	SjM+kYT1D4LDzxLO4d9DzD49KQlXxcSA+epowkNcpjtkCrjEhZP6e4dQI75Iqpur
	jv5ZQwXavzrPug==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a0kytd36g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Oct 2025 15:34:24 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59SFYOtF029373;
	Tue, 28 Oct 2025 15:34:24 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011042.outbound.protection.outlook.com [40.93.194.42])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a0kytd36b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Oct 2025 15:34:24 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k1jSzDxCvHOqEN8IyycYNfFVME+DY4i+wfDkDYHSJ4qx8KcPUUToX4ByrnkRGR13EUjqabjl1iO2rSmZ+ELdRkJdCfqXla41fHCOFQdrEKIfo46kmlhDPbGotFA6igsMW6yKCWCLKp88vXrEBRCkeh5HhDZbkx/LbAcseMQXQrOYDZLVmypyVjMLoP/elUiZyGd1Wc44gnhmOD4IfXKkVgHm9EPFXCL2mlhc3WeHDrx/cGxZ/zVELhPO51nTnTmiOpuCU0qtLOnCBCgEVPtRJwkXgYLOOC1MM9MCARvM7R0+0YSOiKDlO6TsvMCXwcDOO4HGPxfLeffqdd7qkYPOJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ea0LHcUpmRn9HBEVPc0ypCavO6P+piaNbKf5Iv1fDNY=;
 b=nAF3n8ErpmwaXqG+lJVhfhd5qPZHDOivs2voU5czbNb9PgGMshi4tX01bvqGG3YTcU4XVw9HcNfGKxydzX2I0K4PW12oxeZHA22I6cezlXfiEYUJXPS6ahE29+RbeBc3QWBQZAgXCOwax8XdpBCcwaaoh/u6ydizi5pveqzTrrpNNHiVgbUrdrLEn1UWbwN0MlQBt8OpmwHVG77RNIL2HUZ7wU52Bha5uulSAkPZ48vqFJOzD1hNQjzwwT0SaWlqpDpJ11LmvHxtNqtzHbPVE0aUNklQLnXwPdnaRpgsTzFHdjRToX9/AMg7IzpMzODZJ6ZhoVBKFMbVfE0tqm3L9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by PH0PR15MB4957.namprd15.prod.outlook.com (2603:10b6:510:c8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 15:34:19 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%4]) with mapi id 15.20.9253.017; Tue, 28 Oct 2025
 15:34:18 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "idryomov@gmail.com" <idryomov@gmail.com>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>
CC: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Patrick
 Donnelly <pdonnell@redhat.com>,
        Alex Markuze <amarkuze@redhat.com>,
        David
 Howells <dhowells@redhat.com>
Thread-Topic: [EXTERNAL] Re: [PATCH v8] ceph: fix slab-use-after-free in
 have_mon_and_osd_map()
Thread-Index: AQHcO7ga6oyZDsxRZkChtS4Ibmk3cLTXyTUA
Date: Tue, 28 Oct 2025 15:34:18 +0000
Message-ID: <5e6418fa61bce3f165ffe3b6b3a2ea5a9323b2c7.camel@ibm.com>
References: <20250821225147.37125-2-slava@dubeyko.com>
	 <CAOi1vP_ELOunNHzg5LgDPPAye-hYviMPNED0NQ-f9bGaHiEy8A@mail.gmail.com>
In-Reply-To:
 <CAOi1vP_ELOunNHzg5LgDPPAye-hYviMPNED0NQ-f9bGaHiEy8A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|PH0PR15MB4957:EE_
x-ms-office365-filtering-correlation-id: 9d3d4ffa-a1ec-4ad6-7738-08de163775d0
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?cnFhSzFMWHNXR1R4Rm5qbGl0TENxTmpiZGJvZWUzYTByMkFqTXNDQVlwbUdy?=
 =?utf-8?B?OUNDOHlvMmxWa01kVEQyZWhsYkdaSksxUTdXV08zNmlQczBkbGxhMGc2bUVs?=
 =?utf-8?B?d0hIejIzMG5tVTNQQXdIdFdTM0lMRVovZ3cxcFVSNkVUVER1UWY1SWM1azhT?=
 =?utf-8?B?eHEralQzaXM5ZDI5U1ZrckRmdk1UR2pvU2NKQ2pmYXlZcW9yMDA0VE90YnNI?=
 =?utf-8?B?K2Q0Q1FweGh4a2dQcnFnbHNjY3lKRXh0R3ZmWGNZNXFtcXZENUFRS3kyVXhr?=
 =?utf-8?B?V1ZLVS96VWx1Z2IrTlRmeEQrWmxjVi9PMHYxRGwxWUQxdWVFdWdibG5TNi9H?=
 =?utf-8?B?ekxJUG1OV2R4WXV2cFVUdGdGTmVYYlUxQkk2OFNvR2lVcER5OGZ6T1hYc1lq?=
 =?utf-8?B?NEtkazB3ZGUzNWlkUDZ4VUpSSDlSNTl3U09VL3g2ZUR1SHYzcmNPM3l1N0FR?=
 =?utf-8?B?NzFUQXJ1T1JCU0VKUUQrc1ZIcVRuaFFEYjgydkR1M01YaXlMWGpVa2pLR0Nz?=
 =?utf-8?B?NmJqRzN6Tk1nYzkvUysvUUZVOTMvVXR6eXgvcTUzdlFjdHYrbDQ4a3Bjd2hH?=
 =?utf-8?B?UStrVURqOXJpWDVIU1poWWl1aERLcnRMMTY5ZWlCYWtqckgwbU1UQXpDYkFE?=
 =?utf-8?B?UmdUMi9XaEZmWEF5RjB2a3I4c2lqSTZKakM5OTVpSGxxTjhKUlc3LytLdE1w?=
 =?utf-8?B?aDR6YnpMbXJ1OUdYUkFCL2szSWw1MXZSaDU1aS9UN0tFMks3Rm1YK0JGRzNU?=
 =?utf-8?B?dE1CbnZEMFo4VG91eHNxazFwazhPZkdGbll4L3RZQWpEdDV6WUtVblUybjMw?=
 =?utf-8?B?WEgzYlFjY3VtbHhWMkpObStyRWo0RWVQMjRQQ3hJK1dJanZGRW5Ec3pJWVo3?=
 =?utf-8?B?OVZQRzI4VjB0ejdET2FBVk1sZUkvQmR1R2E1bHJlSGtPeFdGWFVIVWd6cERK?=
 =?utf-8?B?MEFNNFhhRythWWlHd2Nna3NyZTFyUWppcnUzNkNDbUd0dkNiYi83ZVlQby9F?=
 =?utf-8?B?dGZ5OW5qeFN4T0lmUm1Ec0JjN1NxNlk4ZjJkT1h6ZExpVnNZMGZDUlF1WVJC?=
 =?utf-8?B?RklnTzh5Q3hNNTEvMHVNT20vV1cxdDBHREF0YktpZllVZkVRcFNSZ0MwVlUw?=
 =?utf-8?B?OVg1RmlMc2J1WTNGTTB6eTVXV0g2ZGY2L3BCVU1Ed0ZzcXZWdzcwNzRibnhQ?=
 =?utf-8?B?bFNJeFhDQTJkQms2U0dBS21JWFRLNWpFcjl0VlJTbENwT1p6cEdNeHY3bTlr?=
 =?utf-8?B?RHEvOW93WFJmUVVZTnhjVlY0REpSQ2JRMVQ4VkJzbjF3T1MzcmRZVFYwMURB?=
 =?utf-8?B?d2dVSUJEMjFUTnlJdWoyMyt3dzdSRStzMHhud0FOVExZUnlSaUVvYUFTTWh6?=
 =?utf-8?B?cjFoVm16T2xOeHRPNWp0dzlneDBER1NxSGpzcXJBc0hvU1c5b2RRcmlmTnU0?=
 =?utf-8?B?VnpYYzQxUVBRU2VCcTUxYWJ3bHU5RUsxdmxhaXVwMU54aEpkMWRIblRGSkRP?=
 =?utf-8?B?NWJYVjduZ0tOQ2IzanpsWkVpVGpWbXZyMGNMTDZVSmo2MnVaSkhnRzY1Nlgy?=
 =?utf-8?B?WDVqL21hZENaRlYyeFhzY3dGVmFCc1hGQVQ5Uk9RQUhsbjVId3dIVG5KYWYv?=
 =?utf-8?B?Y2Q3dmU5QXMxdEtZSmxjdkVFNkIraWFHNVlFcFNhTURDems2OTQxd1NZRHJx?=
 =?utf-8?B?SWxwUklHYmpuNHlzUWdHTEZGZnh3OUZjWTlncys3UDAzWjZ1d21MMUVvNjBO?=
 =?utf-8?B?OXFlS0grbTduZ1d5Tko1MHRTTTFzaVE1SEFkN1dSZ2lWNXRtdkxKU2lTN2dz?=
 =?utf-8?B?N1QvZFNQNTBKdmM1MVpBSVV3WG1OMnYyazVPRkR6L2lvTEhhRkZMSUQvK1dB?=
 =?utf-8?B?NVByK3phT3picFJNWmgvMXZYNVZXNk9PaHFvNVBMWXVhUy9iTTVUYmw1ODhk?=
 =?utf-8?B?aXVUQVVpVkxNSnRhazB2WlJhUjEvVXpzWW5MeTFiVFdXaUhaQ3BZa1ZwYk51?=
 =?utf-8?B?MHBPaVJ6Y09IcGRra2dkTTJJMSsvVVJ1ek1OTHZGS3pWa2xIdURtWkovbVVp?=
 =?utf-8?Q?2RGAEk?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VE1rNGxTcGN6aTlVNCtDMmRyQjVrOHI5aXJOUHd5VXRCRGFYV0hnSEQvV1Zr?=
 =?utf-8?B?blEwK0hkdlV0WGhGUkEzSC9XZHp6YzZYNVh2RzNUanpheFRGdFA2RnZMK21r?=
 =?utf-8?B?N0pweUlWazJrNmhVY3BKMkduZXNOQkFpeDJQUGFZbE1LYUVoYzhkUm0xWUFR?=
 =?utf-8?B?NTl4eC9ONytJQm9LT0FRMCswVkVCdlg3aHhmSHlqVE44cVkwYjZOdENyS015?=
 =?utf-8?B?Zm1Sci9aaFBMRHdKRVAzdjNaV1JXbGNVdkppQTNHbWExQjB4WmtjMUt0djJi?=
 =?utf-8?B?N0RoMVJ3SEkvT1ZNcHRtS1Mxbm9xU0dKRjg2aXBLMjNEYjJzZzJlY1dxa21v?=
 =?utf-8?B?ZW85M1U5N0h5Mk41YkpIRms1cVU3YzZKd2pTa1U3TWk4MHp3dTJtalBZS042?=
 =?utf-8?B?ZnJ0Skt3TW11eDFjRmZSZjNxMGNsOVJyVUt2MFd5Z0FpZVlmNjdsM2lnREtX?=
 =?utf-8?B?dkZSQXNVYUpWS3BVdWQ5bEpUdnkyVGcwU1pUZkxCWjZEZW8xeUdNaVd2dW9v?=
 =?utf-8?B?eFVGUHJMREY3VjY4cVBxcXJWYTI2dDFIMklPVzNwQlVPVlpJQjFmV3RTUm16?=
 =?utf-8?B?N21DZnpobDlkV0d0a21xWU5TekJjRTQ4NEtUV01xU2J1WE41ZithZVZXSVRJ?=
 =?utf-8?B?b1Qvc3hZS1pmMi9USFl0TlpZc2pwK2NWZmtjQWpkRkl4YUl4d3NYbHRrUEd4?=
 =?utf-8?B?ZzZLVGRlQXNwUklVWVh4RnlqOXQ1N1ZrQU4xdzFObGFDUi9tZ1VXMVFSdzNk?=
 =?utf-8?B?Vkw1YmFwQ3VYOXA3N3ZNWWJvVU94TWJuWVVCZldVWlhWMUxzeVFseGtPYzhM?=
 =?utf-8?B?ZWdrNy9qbElOT3ZrdHZySkRqbkJzNFFHZDNNVzFIaVJEZjcwd2ZDUGxLaTND?=
 =?utf-8?B?czBsTG11YmZpZjB3Q0dZeDlFelROViswOVZOVmdCQzNWS3ZNajdpRHgwWjRo?=
 =?utf-8?B?ZlMzYmwrK1JSVkZyUXUvQzVLL2xVS0NRSXhIbklCSlhyWktiRjdySTZUM0NK?=
 =?utf-8?B?TlR6cW56bHpIUlB6R2I2U2dGWEN3aDg0SDZ6S050QW5TSXpDVmk2SFNOU2Ro?=
 =?utf-8?B?aHVUUlFPNXRFNnNLb09STm5rbTN6dGI4VkhRcTNUOUFhZGJYNjhaSC96cTQw?=
 =?utf-8?B?UklBSjk4NWdGUlp0S21JRExTUm5wekw2Z3JUc1JKYTFKUWZYRW8wdEpxNEdN?=
 =?utf-8?B?bnc0ODFSZzQ4K0g5eUVwYUZ4ZUY1WmkrV2c4MFZseHgyM1FFdmxvTzk2cnhT?=
 =?utf-8?B?cjlZL2JwVFFvTG5VbXFRY1kvaEo1M1dOL3BKWjVXN0U2TEU4Z0VrMXZ4N1FQ?=
 =?utf-8?B?Vm1OV25ZTXpTNGk0QVg4bk5yM0xaRS9IdXRMbjhVRThzbURHcXphYzk4OU5Y?=
 =?utf-8?B?L211YUdmL0NmdzNhRzh1cnZNWWxkcnhCVmxKVHA1SXVVSzZOZWNIbHE5YnZH?=
 =?utf-8?B?WDliZ0hVdnVNUDZGQVc4bzlHK1VkdmlVRko2aUZZU01CQ1FzeFh1dTNQeTZW?=
 =?utf-8?B?MnNvcG52MzNPbS9lbE9vdXVxKzMyallGU29DTVlBWUcxTlNWZnhaRVh4UG1V?=
 =?utf-8?B?Ym1NWlFSNnNFY2pEcGxEb01OamIzZFA4T0tDVFRVMWNlQ3lONnd0aFJEUVRs?=
 =?utf-8?B?cnY3b3h4aVNkcTNHZ1k5TUN3Y3lMaFlIOWEzNEhOTXpEcTVxUnA4WGpEZkl4?=
 =?utf-8?B?cko4b0lPRHpUL0lucEgvbGw5TFFpbGFQaVAzdE1lTlVucWF2VElMVWNQRlNy?=
 =?utf-8?B?WTBqNmgvRWZVRlhWbWRDMzJJM2x6Y3RnUXVnSG5yZUZ2V3J4Zlp4eUhpVXcx?=
 =?utf-8?B?RXZLd2tScVJzVmxWRUpBTVZNaGZncU9SdElwc1F0OG9nTmhTcElxcTVQMVha?=
 =?utf-8?B?TkRkRGV5VUtlUWtrNlpFZElyeGxLQjNocVVqZVJOSUM2RkoyQlRHbmt5TDRV?=
 =?utf-8?B?cmFuS2VlMFhvVjJMRHRPbTB1VytsM1FnRE53ZXUwVkVOY1FQcGtFaDViWjRL?=
 =?utf-8?B?aEhrRHFMTDlJRmo0U29LSk9NYXl2Z3RLOGZMbml0Nml2eWcwMDcxamxVdXdw?=
 =?utf-8?B?VTEvU0xmbDRoZ2x4VldFcmc0akhXRE1pVjNRRGx5dUJXQjJrY290bFRTTFEy?=
 =?utf-8?B?RGlaQ2p3VVIyWS9Vc0ltYkdQWDZ0YmN5Qld3c2lqSUlURVpDZzdXalNDZU5J?=
 =?utf-8?Q?EhCCE1w8Czg3GipahGpdHHE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2E708B64CFBD8D4A9460959C7069AE48@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d3d4ffa-a1ec-4ad6-7738-08de163775d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2025 15:34:18.8190
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 09xv8cDWC79ADn4zZcU2Egv8uy5rq5d4sKwvPVdO/jpgHIbaSLb6WjgWbnI0hsxJQCW1bMkJp0tpsV1yNAnJ+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4957
X-Proofpoint-ORIG-GUID: J7pSF5MXncOqzDGw3gvGUdk246ptTwNl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI1MDAwMSBTYWx0ZWRfX2cPFrDClwnKU
 47hNRU3Q+lZOtMWKDyDIqSO8x5I4bzApzSIwCN6cUtOydDgj51xyrzWnoc1WvDrflWbxilTZqdN
 UlQuI6X9rCOVr8YQizZ88Ep6DijG0bPQvCTKsDhKMBikqzm77XuBGeDzdvigjJk0SXth+IU1Wlg
 48Iw36HFmXVu/csFcO2O+kKp+m5RDnF5Xx5ISDjx7JphKmQcwQ+ns2989gJ8H/sfwhM1QWgbZXi
 b7Rf75L5E+rL+YPI5k6hRBh8QJZe5uybFQbUGHZRuua5azns1qVGVlAaxOJPXQWX0lsxP16BjCo
 5zrFta0Ba2q+L2FGT7dN3xxZAqWraI4x6u5u+Tw6YNP9ntOWfx4iaBdc1NZy5EPdDvgOlcGi/J/
 5pBeDIzyPqIALFj09EAjKr5gH7cnog==
X-Proofpoint-GUID: EyZ2iepOn6ckE9GxOVXnJuYET3NTqMKq
X-Authority-Analysis: v=2.4 cv=FaE6BZ+6 c=1 sm=1 tr=0 ts=6900e280 cx=c_pps
 a=audpxvcsMtk9YILK9bmPfQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=wCmvBT1CAAAA:8 a=20KFwNOVAAAA:8
 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=ma_qimaHHXbqdjzJyt8A:9
 a=QEXdDO2ut3YA:10 a=6z96SAwNL0f8klobD5od:22 a=cPQSjfK2_nFv0Q5t_7PE:22
Subject: RE: [PATCH v8] ceph: fix slab-use-after-free in
 have_mon_and_osd_map()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_05,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510250001

SGkgSWx5YSwNCg0KT24gU3VuLCAyMDI1LTEwLTEyIGF0IDIyOjM3ICswMjAwLCBJbHlhIERyeW9t
b3Ygd3JvdGU6DQo+IE9uIEZyaSwgQXVnIDIyLCAyMDI1IGF0IDEyOjUy4oCvQU0gVmlhY2hlc2xh
diBEdWJleWtvIDxzbGF2YUBkdWJleWtvLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gDQoNCjxza2lw
cGVkPg0KDQo+ID4gDQo+ID4gdjgNCj4gPiBJbHlhIERyeW9tb3YgaGFzIHBvaW50ZWQgb3V0IHRo
YXQgX19jZXBoX29wZW5fc2Vzc2lvbigpDQo+ID4gaGFzIGluY29ycmVjdCBsb2dpYyBvZiB0d28g
bmVzdGVkIGxvb3BzIGFuZCBjaGVja2luZyBvZg0KPiA+IGNsaWVudC0+YXV0aF9lcnIgY291bGQg
YmUgbWlzc2VkIGJlY2F1c2Ugb2YgaXQuDQo+ID4gVGhlIGxvZ2ljIG9mIF9fY2VwaF9vcGVuX3Nl
c3Npb24oKSBoYXMgYmVlbiByZXdvcmtlZC4NCj4gDQo+IEhpIFNsYXZhLA0KPiANCj4gSSB3YXMg
Y29uZnVzZWQgZm9yIGEgZ29vZCBiaXQgYmVjYXVzZSB0aGUgdGVzdGluZyBicmFuY2ggc3RpbGwg
aGFkIHY3Lg0KPiBJIHdlbnQgYWhlYWQgYW5kIGRyb3BwZWQgaXQgZnJvbSB0aGVyZS4NCj4gDQoN
CkkgZGVjaWRlZCB0byBmaW5pc2ggb3VyIGRpc2N1c3Npb24gYmVmb3JlIGNoYW5naW5nIGFueXRo
aW5nIGluIHRlc3RpbmcgYnJhbmNoLiANCg0KPiA+IA0KPiA+IFJlcG9ydGVkLWJ5OiBEYXZpZCBI
b3dlbGxzIDxkaG93ZWxsc0ByZWRoYXQuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFZpYWNoZXNs
YXYgRHViZXlrbyA8U2xhdmEuRHViZXlrb0BpYm0uY29tPg0KPiA+IGNjOiBBbGV4IE1hcmt1emUg
PGFtYXJrdXplQHJlZGhhdC5jb20+DQo+ID4gY2M6IElseWEgRHJ5b21vdiA8aWRyeW9tb3ZAZ21h
aWwuY29tPg0KPiA+IGNjOiBDZXBoIERldmVsb3BtZW50IDxjZXBoLWRldmVsQHZnZXIua2VybmVs
Lm9yZz4NCj4gPiAtLS0NCj4gPiAgbmV0L2NlcGgvY2VwaF9jb21tb24uYyB8IDQzICsrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLQ0KPiA+ICBuZXQvY2VwaC9kZWJ1Z2Zz
LmMgICAgIHwgMTcgKysrKysrKysrKysrKy0tLS0NCj4gPiAgbmV0L2NlcGgvbW9uX2NsaWVudC5j
ICB8ICAyICsrDQo+ID4gIG5ldC9jZXBoL29zZF9jbGllbnQuYyAgfCAgMiArKw0KPiA+ICA0IGZp
bGVzIGNoYW5nZWQsIDUzIGluc2VydGlvbnMoKyksIDExIGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+
IGRpZmYgLS1naXQgYS9uZXQvY2VwaC9jZXBoX2NvbW1vbi5jIGIvbmV0L2NlcGgvY2VwaF9jb21t
b24uYw0KPiA+IGluZGV4IDRjNjQ0MTUzNmQ1NS4uMmE3Y2E5NDJiYzJmIDEwMDY0NA0KPiA+IC0t
LSBhL25ldC9jZXBoL2NlcGhfY29tbW9uLmMNCj4gPiArKysgYi9uZXQvY2VwaC9jZXBoX2NvbW1v
bi5jDQo+ID4gQEAgLTc5MCw4ICs3OTAsMTggQEAgRVhQT1JUX1NZTUJPTChjZXBoX3Jlc2V0X2Ns
aWVudF9hZGRyKTsNCj4gPiAgICovDQo+ID4gIHN0YXRpYyBib29sIGhhdmVfbW9uX2FuZF9vc2Rf
bWFwKHN0cnVjdCBjZXBoX2NsaWVudCAqY2xpZW50KQ0KPiA+ICB7DQo+ID4gLSAgICAgICByZXR1
cm4gY2xpZW50LT5tb25jLm1vbm1hcCAmJiBjbGllbnQtPm1vbmMubW9ubWFwLT5lcG9jaCAmJg0K
PiA+IC0gICAgICAgICAgICAgIGNsaWVudC0+b3NkYy5vc2RtYXAgJiYgY2xpZW50LT5vc2RjLm9z
ZG1hcC0+ZXBvY2g7DQo+ID4gKyAgICAgICBib29sIGhhdmVfbW9uX21hcCA9IGZhbHNlOw0KPiA+
ICsgICAgICAgYm9vbCBoYXZlX29zZF9tYXAgPSBmYWxzZTsNCj4gPiArDQo+ID4gKyAgICAgICBt
dXRleF9sb2NrKCZjbGllbnQtPm1vbmMubXV0ZXgpOw0KPiA+ICsgICAgICAgaGF2ZV9tb25fbWFw
ID0gY2xpZW50LT5tb25jLm1vbm1hcCAmJiBjbGllbnQtPm1vbmMubW9ubWFwLT5lcG9jaDsNCj4g
PiArICAgICAgIG11dGV4X3VubG9jaygmY2xpZW50LT5tb25jLm11dGV4KTsNCj4gPiArDQo+ID4g
KyAgICAgICBkb3duX3JlYWQoJmNsaWVudC0+b3NkYy5sb2NrKTsNCj4gPiArICAgICAgIGhhdmVf
b3NkX21hcCA9IGNsaWVudC0+b3NkYy5vc2RtYXAgJiYgY2xpZW50LT5vc2RjLm9zZG1hcC0+ZXBv
Y2g7DQo+ID4gKyAgICAgICB1cF9yZWFkKCZjbGllbnQtPm9zZGMubG9jayk7DQo+ID4gKw0KPiA+
ICsgICAgICAgcmV0dXJuIGhhdmVfbW9uX21hcCAmJiBoYXZlX29zZF9tYXA7DQo+ID4gIH0NCj4g
PiANCj4gPiAgLyoNCj4gPiBAQCAtODAwLDYgKzgxMCw3IEBAIHN0YXRpYyBib29sIGhhdmVfbW9u
X2FuZF9vc2RfbWFwKHN0cnVjdCBjZXBoX2NsaWVudCAqY2xpZW50KQ0KPiA+ICBpbnQgX19jZXBo
X29wZW5fc2Vzc2lvbihzdHJ1Y3QgY2VwaF9jbGllbnQgKmNsaWVudCwgdW5zaWduZWQgbG9uZyBz
dGFydGVkKQ0KPiA+ICB7DQo+ID4gICAgICAgICB1bnNpZ25lZCBsb25nIHRpbWVvdXQgPSBjbGll
bnQtPm9wdGlvbnMtPm1vdW50X3RpbWVvdXQ7DQo+ID4gKyAgICAgICBpbnQgYXV0aF9lcnIgPSAw
Ow0KPiA+ICAgICAgICAgbG9uZyBlcnI7DQo+ID4gDQo+ID4gICAgICAgICAvKiBvcGVuIHNlc3Np
b24sIGFuZCB3YWl0IGZvciBtb24gYW5kIG9zZCBtYXBzICovDQo+ID4gQEAgLTgxMywxMyArODI0
LDMxIEBAIGludCBfX2NlcGhfb3Blbl9zZXNzaW9uKHN0cnVjdCBjZXBoX2NsaWVudCAqY2xpZW50
LCB1bnNpZ25lZCBsb25nIHN0YXJ0ZWQpDQo+ID4gDQo+ID4gICAgICAgICAgICAgICAgIC8qIHdh
aXQgKi8NCj4gPiAgICAgICAgICAgICAgICAgZG91dCgibW91bnQgd2FpdGluZyBmb3IgbW9uX21h
cFxuIik7DQo+ID4gLSAgICAgICAgICAgICAgIGVyciA9IHdhaXRfZXZlbnRfaW50ZXJydXB0aWJs
ZV90aW1lb3V0KGNsaWVudC0+YXV0aF93cSwNCj4gPiAtICAgICAgICAgICAgICAgICAgICAgICBo
YXZlX21vbl9hbmRfb3NkX21hcChjbGllbnQpIHx8IChjbGllbnQtPmF1dGhfZXJyIDwgMCksDQo+
ID4gLSAgICAgICAgICAgICAgICAgICAgICAgY2VwaF90aW1lb3V0X2ppZmZpZXModGltZW91dCkp
Ow0KPiA+ICsNCj4gPiArICAgICAgICAgICAgICAgREVGSU5FX1dBSVRfRlVOQyh3YWl0LCB3b2tl
bl93YWtlX2Z1bmN0aW9uKTsNCj4gPiArDQo+ID4gKyAgICAgICAgICAgICAgIGFkZF93YWl0X3F1
ZXVlKCZjbGllbnQtPmF1dGhfd3EsICZ3YWl0KTsNCj4gPiArDQo+ID4gKyAgICAgICAgICAgICAg
IGlmICghaGF2ZV9tb25fYW5kX29zZF9tYXAoY2xpZW50KSkgew0KPiANCj4gT25seSBoYWxmIG9m
IHRoZSBvcmlnaW5hbA0KPiANCj4gICAgIGhhdmVfbW9uX2FuZF9vc2RfbWFwKGNsaWVudCkgfHwg
KGNsaWVudC0+YXV0aF9lcnIgPCAwKQ0KPiANCj4gY29uZGl0aW9uIGlzIGNoZWNrZWQgaGVyZS4g
IFRoaXMgbWVhbnMgdGhhdCBpZiBmaW5pc2hfYXV0aCgpIHNldHMNCj4gY2xpZW50LT5hdXRoX2Vy
ciBhbmQgd2FrZXMgdXAgY2xpZW50LT5hdXRoX3dxIGJlZm9yZSB0aGUgZW50cnkgaXMgYWRkZWQN
Cj4gdG8gdGhlIHdhaXQgcXVldWUgYnkgYWRkX3dhaXRfcXVldWUoKSwgdGhhdCB3YWtldXAgd291
bGQgYmUgbWlzc2VkLg0KPiBUaGUgZW50aXJlIGNvbmRpdGlvbiBuZWVkcyB0byBiZSBjaGVja2Vk
IGJldHdlZW4gYWRkX3dhaXRfcXVldWUoKSBhbmQNCj4gcmVtb3ZlX3dhaXRfcXVldWUoKSBjYWxs
cyAtLSBhbnl0aGluZyBlbHNlIGlzIHByb25lIHRvIHZhcmlvdXMgcmFjZQ0KPiBjb25kaXRpb25z
IHRoYXQgbGVhZCB0byBoYW5ncy4NCj4gDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgaWYg
KHNpZ25hbF9wZW5kaW5nKGN1cnJlbnQpKSB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBlcnIgPSAtRVJFU1RBUlRTWVM7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBicmVhazsNCj4gDQo+IElmIHRoaXMgYnJlYWsgaXMgaGl0LCByZW1vdmVfd2FpdF9x
dWV1ZSgpIGlzIG5ldmVyIGNhbGxlZCBhbmQgb24gdG9wIG9mDQo+IHRoYXQgX19jZXBoX29wZW5f
c2Vzc2lvbigpIHJldHVybnMgc3VjY2Vzcy4gIEVSRVNUQVJUU1lTIGdldHMgc3VwcHJlc3NlZA0K
PiBhbmQgc28gaW5zdGVhZCBvZiBhYm9ydGluZyB0aGUgb3BlbmluZyBvZiB0aGUgc2Vzc2lvbiB0
aGUgY29kZSBwcm9jZWVkcw0KPiB3aXRoIHNldHRpbmcgdXAgdGhlIGRlYnVnZnMgZGlyZWN0b3J5
IGFuZCBmdXJ0aGVyIHN0ZXBzLCBhbGwgd2l0aCBubw0KPiBtb25tYXAgb3Igb3NkbWFwIHJlY2Vp
dmVkIG9yIGV2ZW4gcG90ZW50aWFsbHkgaW4gc3BpdGUgb2YgYSBmYWlsdXJlIHRvDQo+IGF1dGhl
bnRpY2F0ZS4NCj4gDQoNCkFzIGZhciBhcyBJIGNhbiBzZWUsIHdlIGFyZSBzdHVjayBpbiB0aGUg
ZGlzY3Vzc2lvbi4gSSB0aGluayBpdCB3aWxsIGJlIG1vcmUNCnByb2R1Y3RpdmUgaWYgeW91IGNh
biB3cml0ZSB5b3VyIG93biB2aXNpb24gb2YgdGhpcyBwaWVjZSBvZiBjb2RlLiBXZSBhcmUgc3Rp
bGwNCm5vdCBvbiB0aGUgc2FtZSBwYWdlIGFuZCB3ZSBjYW4gY29udGludWUgdGhpcyBoaWRlIGFu
ZCBzZWVrIGdhbWUgZm9yIGEgbG9uZyB0aW1lDQp5ZXQuIENvdWxkIHlvdSBwbGVhc2Ugd3JpdGUg
eW91ciB2aXNpb24gb2YgdGhpcyBwaWVjZSBvZiBtb2RpZmljYXRpb24/DQoNClRoYW5rcywNClNs
YXZhLg0K

