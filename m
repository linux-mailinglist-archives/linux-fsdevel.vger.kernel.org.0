Return-Path: <linux-fsdevel+bounces-42189-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B17A3E5FE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2025 21:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 775043BD077
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2025 20:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE8126389E;
	Thu, 20 Feb 2025 20:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="G41ZBjPk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6618E2B9AA;
	Thu, 20 Feb 2025 20:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740084032; cv=fail; b=m/YExgx/+9Kz2+XFC/QjdPYI6vhOsEiGDuoqVPRRadGqMawcX5tc9jyRzgu3AYHd5V7+dt5yu4d1E7cS85gRqMblcj3Ig8n6UoeeNZsN4mTln6xGQGDv+d/clPJIbKHnhm6VBYu8LhRlGaM182hQTysx4l1yCY0Y1QxYMuOk1mk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740084032; c=relaxed/simple;
	bh=YnO4EmMzQxLLntFG76injcHsg1rSpX0FQ84DfX555KQ=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=mUgFXXWkP+MwPinF7JU62oycAvSwW8Ffx2bWkmvx6KYM/HTKQSZrR0IWOcuiGdfdA57H/OAnGI7DLyR6fx6o6UxzBgKdjDycQxiEsp8SzayRVR9nCsj+fJ094EQq24N7I+HLajSKye6cxaUu5yWlb1PRPJpRc+4WEXanjwIrbLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=G41ZBjPk; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51KH2E0l010611;
	Thu, 20 Feb 2025 20:40:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=YnO4EmMzQxLLntFG76injcHsg1rSpX0FQ84DfX555KQ=; b=G41ZBjPk
	LUCM4o0mV2en8l/PqgqXZVMEXygHUcF2uD+bZkJyCfy4UMKIn9i3M/KqBxmelu01
	EfwsF01pMngQc0MsMMWfqh4OMIFVV+ZgWXVIyi/5N0RES9P7LrpzsfDjUX3LHl9F
	I0CnShyZEEe2gJZBXA0s+lxymr/zzi15e1PrwRu7lK+k8eAjCYXx0DcVZLCw65VO
	++DMnyE1RpZUQifniUf8neEF37xuZI/y+XLsathLxJRPRBBESfxFU2Z+Tww+renV
	3hpIywAMvxO+th1QkkqTAB7O62pUr0KevOHucSyj3Go5/HJCbcVQVUuUHjOfALQz
	+WJzKOTxCNSYnA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44x1qybcse-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 20:40:26 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51KKQh4M002496;
	Thu, 20 Feb 2025 20:40:26 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44x1qybcs8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 20:40:26 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x1xGuQaqX0uULEfeWc0p6WkzWhfmeHlkl+QWm+VCNS2okIbc6MLeJlwCsuiScmXRy67jOPHDrPJNI9VOB0IPGgIPyW1FpW187aTgsvmUkgIUo5gd5+omg3l8IMQBugbvg78iQnMkqabB2q7M5XWDRg6ceznmAKp8O6Fo8QIN9ZWpJ/HKLzS2N7euOmHUuK2vHHx8UJjiBJs5cFG1lyOTzXORaCa2RYFd54+2SguSAdtOWCfwcf8iG1Wb5y2k2Y2NbDA27tqrQjWDzekDDDPmacc4TVgWd4GLsfdDItWACkRBdmtQ3wj/HL6UKPjibbsM6Bex8WqiFfp+BPqsK2s7pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YnO4EmMzQxLLntFG76injcHsg1rSpX0FQ84DfX555KQ=;
 b=LJ3q2kb90slHc2y3LFkUN99kw2FTA7pX8f/zbklvCn2M4JrJBIK8NGYK26GI9iMZevXBCTKQS3HTTwIWU7iLHEXf2mq4e1LFpm+DLVIwBXcmG8GEVHZEP+scG0uUAlyD2alMdz3gyXhrvVJ9ctF/pABZJL9sFKWH3Y0oA4aaysrF0ykeaQotOWk27OHcwFn9XNHczbRtv/Ozc5DY8Bu1iB8ARWrm9Orau6txnWYx1n96XY/T/jKAFiFQ/FS5++Z0yzL902uKBLw//717gPdfUm1ogKk7L4x62zCOy2RuWGNyVeraWl+oGHYLXBX9T6KSZK9L79w7X4C/PBSvhJKgCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by SA1PR15MB4769.namprd15.prod.outlook.com (2603:10b6:806:19d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Thu, 20 Feb
 2025 20:40:24 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%4]) with mapi id 15.20.8445.017; Thu, 20 Feb 2025
 20:40:24 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: Alex Markuze <amarkuze@redhat.com>
CC: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Patrick Donnelly <pdonnell@redhat.com>
Thread-Topic: [EXTERNAL] Re: [PATCH] ceph: fix slab-use-after-free in
 have_mon_and_osd_map()
Thread-Index: AQHbgswSFOetK3CmSU29/fUzZmt7ubNPD9UAgAED2QCAAJYNgA==
Date: Thu, 20 Feb 2025 20:40:24 +0000
Message-ID: <d66bff978298529fb50e182f54c990a4e1acd9a7.camel@ibm.com>
References: <20250219003419.241017-1-slava@dubeyko.com>
	 <CAO8a2SjeD0_OryT7i028WgdOG5kB=FyNMe+KnPHEujVtU1p7WQ@mail.gmail.com>
	 <8b6bcbf5ba377180fed3a31115b1a20b31f0b7df.camel@ibm.com>
	 <CAO8a2SgWRBXH2hFg5m9Gf0Nvr5=0PZXE8n2aane6kp7G8pCO_g@mail.gmail.com>
In-Reply-To:
 <CAO8a2SgWRBXH2hFg5m9Gf0Nvr5=0PZXE8n2aane6kp7G8pCO_g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|SA1PR15MB4769:EE_
x-ms-office365-filtering-correlation-id: 90a98ccb-9461-4c35-da77-08dd51eecd35
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?N0dMcndqaDY5NlpheGVDWmtxa1BxUGs2R2NoeGpLcGU3a3lUeGhoNDc3WGlk?=
 =?utf-8?B?TUUzRjZOR2tkZUIvYlFGbDhUcThVeHpDazRTUHB4MWZkVDdqVlhRZFJDY1ZG?=
 =?utf-8?B?TTM1ZDJaV2h0U1N6Y1F1c1pKaGVGRFZ4UXJvUFRPK093Znp6a3g3bnR6VHMy?=
 =?utf-8?B?WWtURmpMN243QkZiTFkrR1VEQ3Nvc1FtRlBGV2NnTTd5bFJITVZIYVJpS2lt?=
 =?utf-8?B?RW5QTmJSTXp3b0pLM3ErQ0tUT2xTMnJxdGNwWDhpSDI3THNERDJodGNNNlB0?=
 =?utf-8?B?eTNFTXN2MGdWVnhHV1VxdU51VWFkYWxNL1hIL0twSkdmKzd3bmRlOHJFV0Nw?=
 =?utf-8?B?OFZnajdXdEp4WEpIMnRCdnRIQ2ZjSGpoVllabXQ2Q2FJRk1neGRSMENyQUU4?=
 =?utf-8?B?RUFTbGs0U1hReFVLeGVDQ3lFT1RwdDFFejIxd2dKVGI3ME1qWVBPQlJ2Y3J4?=
 =?utf-8?B?cU16MTdBMUF3YUZuWWgzQkM4QXZCL1o1ZHVpU2o4SmlTUElrMEp6RDdPVjVL?=
 =?utf-8?B?cllhLzlGMERaZkE4QXc5KzBCSVdKTmJSZk0vbHU3ZjBpZkNYNUZ3NVlkN09q?=
 =?utf-8?B?ZG8rY2UrR3lpQm44TC9MT2F4dy9vWnVUQlFyZVhmWjhBZkdrY20vZmFlZlRU?=
 =?utf-8?B?b1F5bEtwMW9mam5HbGplcHkyWXdack4zTTUvMkkvVXVFZ1JMWEFLblRrdEs4?=
 =?utf-8?B?d3VuaE5TajdMRzBOa3A3K0J0b0FVWXlTRGtiR1NJRWE4ektRTFl6QTFZYWFs?=
 =?utf-8?B?Z1U2S0JhWGVCcVJEQ0hMSElGT3ZXVS9UeTRmS1g5OHdPRXR1UWI2Vk00em9J?=
 =?utf-8?B?dDB4OE92azhGcnd5b0pOdTVZYjFseENWbjNOUGZIOGc4d0FXVTR0RGpOTHgx?=
 =?utf-8?B?dGJnSHFPemNHQW9hbGsxcnJpWjhNdzU1bVlDRGZUeGNXZjQwV2xRaExtMlI5?=
 =?utf-8?B?OEVwWm8vdDhuQ01tWHF0K0ZMUHlCYm5zbWNLbkhZQ0NRQ2VGVVlJeDNUR3Yz?=
 =?utf-8?B?YzBNSXBvYTFEZ0JyY0tqSlB3RXZPKzA2bVRzZVVFOVU0emtVdVdUdXErQk5V?=
 =?utf-8?B?S0VwVXQvMEt4R2VKa3J1b0xONWE5clBSZEg4cmM0TzFwM1pRUmx3WXlMWDNO?=
 =?utf-8?B?QVpEMWNaWTM4cDdUTzhhOForNUNvTllpbkxaeDZjblFNT01WVXM0Q1RRMytG?=
 =?utf-8?B?VzlNM2Fyeno0N1lLRFB4b2thMU1mU3JjUWVWTGExZ1hwT1ludEQ2K3V5alF6?=
 =?utf-8?B?dW5BUzdYVjE5Vm9NL0YzM3lGeHpDSDNGaXJaOE9nRkp6eWhTQWFzNGV6dThw?=
 =?utf-8?B?RUZZbUNDME90Z3MwR2k1Q1lSTkFMdGUzWTJsdmpLOUZ0MFdaeGloUU1JL0Zv?=
 =?utf-8?B?Z095MHZJcnIwaU5ucS9MTnI0VXJDcWZRdGNHOGVSSXFBUlpRdmVxcjRPTnh0?=
 =?utf-8?B?VU1CYjFTejlqaTFWNWxVNHpWNzlCUElWQnZYVkd0VTlhdlVQMko2YXgxUUtx?=
 =?utf-8?B?N0tTZ2hCWW1Id2hERDhqQk93bnNVbCt4bG94akt0WU1NKzRnbytoM0N2TGZF?=
 =?utf-8?B?TEtqREk4MVNuOEczdi9YZk43OEVMbUZHeE5aQlFSRjdXSDZMcmhWRVpxckFl?=
 =?utf-8?B?a3FwME51Qm14aDh1b3o0ZTdCS3VTK2t5VisxejZzY2Z5TUFvUXZkOTNmTWpZ?=
 =?utf-8?B?dHZSWHZYbmhYNndycE95T0taK0lYUzRrYjQvTGhjeWttcTlJNUpnK3pDYWx6?=
 =?utf-8?B?L1NkWTZJaS9iT3EyQnNLaW52QkJHS3JCQ0tpM2Rtei9GM3pqaXpmWEJwNDg5?=
 =?utf-8?B?S0F3aW1xSEhyVkt2OTBVcGN4UG9lc0owRzFwaDVTTGZQbksvT1dNcGVtRHQr?=
 =?utf-8?B?d1ZzdGowSTRDZ2FaUEl3RWxydmdydnROblErTnNjdXZxWUQ5WWYvM0JTQ0RM?=
 =?utf-8?Q?klcelhozfuuH8HAH+rSxDPMhTwJuY0z+?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RGJCSVozMHR2VnJ2SzBsQzAvZFBkWDhZSDRqSDdKcTdlQjZiNDdaNS9LU2lU?=
 =?utf-8?B?SWhSd2duWEJYNWtkT0luYitlOGxQUDZyVVd1dDkydXFaQlJYcWduRytGTHJa?=
 =?utf-8?B?VjBzTGttTE9DcnZpS25vL0cwNUljMWlPNnAreHlMVVdiUC85OUswS1BSSWpI?=
 =?utf-8?B?dGlQLysrOWVwbDdOdVJOT2xlYkR1NFNTeTZ1L003dERBMi9kaCtjUlExVWJ0?=
 =?utf-8?B?aHNESjBvN1hQalhENnVPQ0taVnNMVk1WQkUrd01Qc1hoNjl0RTVIeW1JZ3lQ?=
 =?utf-8?B?MjJ3Q051VjJ4bklKMUZXVU1nWHRDMTl4aU9KQTFrSmtva1hKd0xIMURNT0Za?=
 =?utf-8?B?K1I5dVNCeUw0U0NEWVptYlBGdk84L0ZZdW9aSG8yckFtNUk5SHdSYTNHSUJy?=
 =?utf-8?B?eG9MZVdJeENPeFBZRnQrVGU0UmJ6S2ZMWEwzeTlUMWVRSVZGSktNQW5rV0h4?=
 =?utf-8?B?U0Z2OFNzVU5hcDRReVVDRWhrb1REbGU5cHRoWHowcXNaQ3R4UnpGemQ3TFQ5?=
 =?utf-8?B?NHFxVGNQOUZ5bVVEamFSMGNzQjdLU21ZbFE2N0VmRkxERXorRkJ0aGU2b1FP?=
 =?utf-8?B?a1E1UnptQkh0aVBKdVRkODN2UzhzSEdqYjVYZVZoWmZhNWo1WjFWUGhMd0Vt?=
 =?utf-8?B?NlhDZHNpLzRUcWJqMmtnVG8yb1RsMEZRNEN1VWRNMi9oWTFrTjFISlN3UGF2?=
 =?utf-8?B?amsrQ1VVbnd4M2h2cGdaL244a1FRMHBPdGllc0JCQnNTYnQ4NmkvNzByMm5Z?=
 =?utf-8?B?enl5WFUwVmw5RWR4T3lDQVMrMnFkOERVUXdTM2Ywa251NHlXVXk5V1pDTEMv?=
 =?utf-8?B?bVJNdEY4bUJnWDkwdnVCZHRRUjBqV2ZNYVlNY3V3RjV0Y0k3M0lKeC9RK1lZ?=
 =?utf-8?B?UmRmcTQ2bEx3cHg1bkF4cklsOGVVSzkrQk05K1dXTzZQQ0ZDQXV0bUpwOGNs?=
 =?utf-8?B?RkNUeXJUMXUxQnNxNE1XeGh4RVljcEphQXZRaGcrRUU2UmYwVDVvRUdNWHpF?=
 =?utf-8?B?OHJSVVBpdjFlTUZjbU5DR0FPUHVhUUxHMmk0djhDUXlDSmRvSWJYcEpyMnVK?=
 =?utf-8?B?eEtJZXBxbER2c2lEZHNodnNQZk1pZTJZUjBoWDRWcjZPYzc2clV2V3R2QTU5?=
 =?utf-8?B?VkVMcU1oOXFKNUR1U2xPSWV6djRJTzM1VVRLaVNuUFVXNzcrSEhCdzZaTGh1?=
 =?utf-8?B?MFkwQWM0cXBYc0JsVVk4RVJXdFNtQlhGS0x6aHpNeVB6RWZmOXJVUVN5RWtN?=
 =?utf-8?B?d0RYTURlb1VQMk9uSnBsNWxRa1dWQjVyV0dJc3h0OG9xdm0rVEg5d2MrTis3?=
 =?utf-8?B?NXJKMVEvQXl0T3pDd0NRMEFMMC9xSm83UHJkWWdrWEZPTEhuMDRycFgzdzVF?=
 =?utf-8?B?OVZkZ1ZFZmVPS1BGeWJkWHFKVlpVRS9VUVUzeU1jTndxRzVmd0Q1SVU0eHhD?=
 =?utf-8?B?T1Rmb0RkdFdhN1hCeS9nWHVLejlvb1U4M3FMQ29BNnVrT21uZVB1SkdTQng3?=
 =?utf-8?B?NUl6SzhTNlB0ODdOL091NDJRTkVKZGpyY2F0UXpZMzNmL0dybmtLdW5qRkUr?=
 =?utf-8?B?a3pxWXhLeldtSm16SlFDamNuRTlCNEVEaDBjbmduQzRvcjVDQm5vWWdkeStC?=
 =?utf-8?B?UDBIQ0dwRzY0K3F3WDRheTNCYzdEcG9yNVNrSDNMbitEMnNROGxSR1NWYzFW?=
 =?utf-8?B?UCt1ZmhFRjc3SjBDS1NsbUpKSHJHbmlrL2VrOEwvT0NFN1l1Wnc4Vmk0dlE2?=
 =?utf-8?B?bE10NG5keEZvandqbTFrWngrcmcvN3lPbTZkNHBTaHlreDZqc2t1cjZmYzUy?=
 =?utf-8?B?QzA4TWt0N2lyb2c2akwwU2pacFVkSnkxckx3L05MdUd5dDlzRHFDTkU0ZTRO?=
 =?utf-8?B?ZTNaVEVJRklWSnVDWDRWU1Y5aW41Zmx4dDFyT2cvcmRkdFJlZTZ4UVpTWlF5?=
 =?utf-8?B?NE1HaHpzY1Z1WTRaQ09SRlRqMHdsWmxRdlAyWXAxdkY3dmNzRHUzVXZzSDR0?=
 =?utf-8?B?SGdBd0FaU0liUTZIYUJZSDVrUXNqb0VsNng1V3JTVVFhR0JYK0U1anpyRGxt?=
 =?utf-8?B?cHp1NDdIWDNCME9VbWdES1FLMktiOFR1ckhEZVV1cFluOFpOWEhHdGVtTXNy?=
 =?utf-8?B?M014blpOdkhORlY3Uk8wMlpEQm52TEhiRkU3Um9PV0lLcml2VWhEY0FKbyto?=
 =?utf-8?Q?foRwkWYW+BPlcoxlad6jptk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <69179027C39AF640841291565D3FAD0F@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 90a98ccb-9461-4c35-da77-08dd51eecd35
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2025 20:40:24.2824
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JOBrbT9tzpxQQA9rclsGxsBGY7EMP4hnGOIo5i14YeWaSyKoGWmpQ1IbS0f0MrdDP+yeSUS1ZLHN4vbZ/eIxyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4769
X-Proofpoint-GUID: Ni3lofPcjRBNWyiINER36U3IfMqC4GKn
X-Proofpoint-ORIG-GUID: 3iPZ3AXqlWGXk7wrQyaikJeNRboceNSw
Subject: RE: [PATCH] ceph: fix slab-use-after-free in have_mon_and_osd_map()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_09,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 phishscore=0 impostorscore=0 bulkscore=0 mlxlogscore=496 adultscore=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502200137

T24gVGh1LCAyMDI1LTAyLTIwIGF0IDEzOjQzICswMjAwLCBBbGV4IE1hcmt1emUgd3JvdGU6DQo+
IEl0J3MgYSBnb29kIGZpeCwgSSBqdXN0IHdhbnQgdG8gbWFrZSBzdXJlIHdlIGFyZSBub3QgbGVh
dmluZyBtb3JlDQo+IHN1YnRsZSBjb3JyZWN0bmVzcyBpc3N1ZXMuDQo+IEFkZGluZyBhIE5VTEwg
YW5kIGEgcHJvcGVyIGNsZWFudXAgc291bmRzIGxpa2UgYSBnb29kIHByYWN0aWNlLg0KPiANCg0K
U291bmRzIGdvb2QhIExldCBtZSBzbGlnaHRseSByZXdvcmsgdGhlIHBhdGNoLg0KDQpUaGFua3Ms
DQpTbGF2YS4NCg0K

