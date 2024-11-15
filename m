Return-Path: <linux-fsdevel+bounces-34961-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 819709CF2BE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 18:22:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8434EB2BF9A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 17:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67CE81D618A;
	Fri, 15 Nov 2024 17:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="PWDUTYfe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E75B1D5173;
	Fri, 15 Nov 2024 17:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731690694; cv=fail; b=W43T8y6L/9z1Fo06wK/W21m/Mn36+QMOoACTrgqKKedsGCX1Z6sFF6p2nnp1fAgsU9TggIPhsPLQa4/r4W1ThWScqiJCGxBmMf+EcC+AICNIXxX3vs1YW57SABkoe86x6nrPCJ8VlRK+r/KTQ84ulJK9rprYWWaI813gs0wmg6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731690694; c=relaxed/simple;
	bh=1L5BF1hsDXgqLx4oTJOoheenWnv/UTLBgoui1yoEwY0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XlvIhceRXFzvSoeldLXWxfABvtEIYU5mKIiOewHwiuAP2Za421uGwAVm3y7G1JGhpO98CTv2fbuf6kWe3XEqjWF1xRm3mP6TohEttF/b8zYo+yil5yet3at87B8smskKSWFwPXouBDbWhnc4TsTera5pRs8QXvKcmeEj8lrS/fM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=PWDUTYfe; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFGZxiO029114;
	Fri, 15 Nov 2024 09:11:32 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=1L5BF1hsDXgqLx4oTJOoheenWnv/UTLBgoui1yoEwY0=; b=
	PWDUTYfeXLo3A86Ij4yXPd4TrGU7tozgfoOwBzkTA6X0FVidN1c4X2zlhf4+hXB1
	MaziT6/SX9v1Olw6CSDn8zFyBAN9LH7IhD/cL1LiGNndeNU5l8HIpFEV4j1gQoRz
	NM3dPx/whlttEjCU/6k7xJCmkXuBVf+P3ipzpeOB0f+R/NylViFIhS4Q9ADlUOb/
	u9GX3WQOmlq/ODjRW/NEVH8so7c8a2a3YxSan3TcF/lAWSk1qtf8rHOCEkFkQOmT
	QvmNSfJ9cJMw78CoHKnOQ6FkoQpwN9iw//S+CnWCksxEFjq9DGybNhmIoBghz2Ym
	p2QMH6236w4zKDmnhxUaBA==
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 42x7gy1g45-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Nov 2024 09:11:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hUAKwee45btdHsCFU8xMiWOTcWb12fQtMIX3LZ2soj7GFuAZ6R+X75B+kFIwwXA9e42ndsz2d2vf4mEC6DaTyL9b2/vFxx2YkzY2QF/nBiPPJbxuAV3ORjOXf90AhTeIw1wWGNoBBhZIKu28eh0rRUb69hMHndg2F4tSz1QtSfkfG4FtyetTqiPw8ldrqB6zHilITe3TYvpxhREWEx4vbyhzjjLGc4GVMIRnDFWEV8gKsKRNdhTRwqiCv0rxln5MtZsMJj1lJoIHhcYaUEcPrLuvUDJcwn9HLEfvIsTRasCB6HmEgm+ZCqAyfurPpOiLwCiuyrHG/hWWcmE/5Ovpeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1L5BF1hsDXgqLx4oTJOoheenWnv/UTLBgoui1yoEwY0=;
 b=EcdWaMpsLXt4t0A32oWeiiWd+AXiTYfyBgWdPKWHXE+pN3HKxAS6USWU/LP8b4yITr6W+Ju3UdQ5UcgwOzPzEwBkNy8bGkBEooa3MAo/IqpdVxRxgeVXPccA59xB1r8ZpXKOy+bWOASEIbYZdFs4wk1+I9OzQkKlNdm6Ei+5kEoD2w5Ldrv6xB7MFRV1YSX534BI7URdKggNgnhT6lHzUYZv2OAn4KiXVxZnCzBzVN05cIOV5RnMS1qvDMMz64NDdzmy9ukJjeCE/NlffB2BXp1wUlXCw5h9kWVDAyT4GDvMX0YlbGHU/Bc/qDiMUuXIN7EIibqNPopGaPeLToH47w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by DS0PR15MB6185.namprd15.prod.outlook.com (2603:10b6:8:114::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Fri, 15 Nov
 2024 17:11:27 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610%3]) with mapi id 15.20.8158.017; Fri, 15 Nov 2024
 17:11:27 +0000
From: Song Liu <songliubraving@meta.com>
To: Amir Goldstein <amir73il@gmail.com>
CC: Song Liu <song@kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>,
        Kernel Team <kernel-team@meta.com>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "eddyz87@gmail.com"
	<eddyz87@gmail.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "martin.lau@linux.dev"
	<martin.lau@linux.dev>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "jack@suse.cz" <jack@suse.cz>,
        "kpsingh@kernel.org" <kpsingh@kernel.org>,
        "mattbobrowski@google.com"
	<mattbobrowski@google.com>,
        "repnop@google.com" <repnop@google.com>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        Josef Bacik
	<josef@toxicpanda.com>,
        "mic@digikod.net" <mic@digikod.net>,
        "gnoack@google.com" <gnoack@google.com>
Subject: Re: [RFC/PATCH v2 bpf-next fanotify 1/7] fanotify: Introduce fanotify
 fastpath handler
Thread-Topic: [RFC/PATCH v2 bpf-next fanotify 1/7] fanotify: Introduce
 fanotify fastpath handler
Thread-Index: AQHbNnF1JE+3KJtsIUKJQ3ltj7B6crK4ChwAgACLxIA=
Date: Fri, 15 Nov 2024 17:11:27 +0000
Message-ID: <E48C3CBB-7712-4707-AE70-1326445CE4C4@fb.com>
References: <20241114084345.1564165-1-song@kernel.org>
 <20241114084345.1564165-2-song@kernel.org>
 <CAOQ4uxjFpsOLipPN5tXgBG4SsLJEFpndnmoc67Nr7z66QTuHnQ@mail.gmail.com>
In-Reply-To:
 <CAOQ4uxjFpsOLipPN5tXgBG4SsLJEFpndnmoc67Nr7z66QTuHnQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.200.121)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|DS0PR15MB6185:EE_
x-ms-office365-filtering-correlation-id: 24ffa53b-a8d3-43bc-7ebf-08dd05988aa6
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|10070799003|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UXZ1ZTdNdWx5SER0SHcvblo3KzFrcWt5cXovYnFFVE1wcWZ5cm9rMEZzdC9E?=
 =?utf-8?B?ZDVyTGFscDkxYTFCVWFXSmJ0VDNSb1ZyS2V6b2RIaGN4TXFhOEY0WmxLalpF?=
 =?utf-8?B?VkNEUjJWV0g3bEEwRm1OUXVnM1B1eWk1WUNpWVFtWGVZcWNNQkUvR29pWERl?=
 =?utf-8?B?d1BnV2tEOGRuSkl5RFhiU3Y5TXRjcTBTUUNaUy9oUER0RHRYOEduSDYrQnVr?=
 =?utf-8?B?R21Ec2lkaFp3R25tUWlta1NVeXBXaWZJendIQ0g0d1NLQlVIekUyaXhMbWdm?=
 =?utf-8?B?NkZYTmJVempObmd2RkRBdHFRaUg3c1J4TTg1bzF4c1FNQ2NIb1M5dndXTndH?=
 =?utf-8?B?MzlrZllBamxJVWdNTTNGNDE2ZE9KcHg1TkdMMlJVWXp3YUl5S25GVGhsbHh5?=
 =?utf-8?B?M2VEZTlkWHhudVV3UVI0YlprT2lSSkVVYTZObjgyNldGSGIyRTdHSWlOc2Vl?=
 =?utf-8?B?OXBvS01oTEZ0TU5PYmZndVF0VC9QTXo0d3NpcThhSHE5NWxwelJSNVhkdzhU?=
 =?utf-8?B?cFJOZnFDMXYwdHNPSm90OTBwS1ZRQTFIenJReE90dlVnNzlzOGg2a1JlTGMw?=
 =?utf-8?B?WDJ2T3RXWXRRVHQzdnJNMzlJZlJrakZkNjFxSDdLa1RydGkvVVI2YWhtakNv?=
 =?utf-8?B?NC9mTDQ0RTdSVW8xV0E3RGdNMzUvY25XYWVCSitTeGphalA0Y1RMNmN6Tnpj?=
 =?utf-8?B?c2VFSnIreU41UGIzdnZQRGFmTGRlRnh4WXZsMGJmcUtWRlR3RWVKbGdaWVdD?=
 =?utf-8?B?UzBEamc5Q2F3ZWVLTW50WURyRFN1QndQNDRsTVJ5TjhpV0dPeFMzRk5TMXJ0?=
 =?utf-8?B?bkVUdXZWeFVjWkt3VmFDYXlEU2J0c29jVSsvTWJSTkpQaEpRUXoxUmdCcXZU?=
 =?utf-8?B?SkRsWEZvVFNOd0NlM0pqbVk2NDJscXlTQnVGNzVnbS9yNUM3RXBIbitWR3pY?=
 =?utf-8?B?UnJPTUdXMGZjMFBKbTZtZGx4Rm1MclgzY2pCUUtMZndsb0UyWUFRM2NWaHRt?=
 =?utf-8?B?UUtqWUZXd2dDbmNONUszWVd1czNCbnJBWGNtQlJXSGVVUGpWS0xhOHNMaWxQ?=
 =?utf-8?B?TkwvVWNIYXdRZnUzUFV3QVpodkVvWTZ4M2c0NGJDV0wyZDFlUTdMa0lyc3hM?=
 =?utf-8?B?cC9lSHZVSE1lZU0rakxlOG1qYjBIc3lObitqWnA0SURtZjFoQ2V6dmIySHp4?=
 =?utf-8?B?YUFwSjFFc29ZYi9vei8zVXR3bENSYmpWZmduSmNlenEwNStWazU4OWdEMFNq?=
 =?utf-8?B?dS92WkVKc1d0OFZBUE44SDMrOExNdUdIYXA5TnBwUFhkckVzWlhPWFNGc3V2?=
 =?utf-8?B?dnBWZDF4eTRQTVNjc2tmakRrdkVXbzdVdWU5TXdZMzFSQlJESmJmQ21FQjRE?=
 =?utf-8?B?RGNnWkFVVXVHd1kvSkF3Q25RWVdtb1pGa3ZnWGlrMmxaRldZT2gvVE1sSkQz?=
 =?utf-8?B?bGwvRlQvamw2SnhLL3lPN3ZwS3FZZHhTZHA1RTdUMSt4R2plNDI5eGl2NjJE?=
 =?utf-8?B?OHpYWmRFK2lqcnA2eEtNNDVMMmhkaU02aEpGeUEvYVg5L20wekVzSUc2N29V?=
 =?utf-8?B?aW15a0VuQ1BrSFprUmhMRlFzbHRHZTlwMEN0L2JmMDlrRlF1SGhjOXI4WUtC?=
 =?utf-8?B?QjlKWElMcEU1L0EwSjJ1ZGR5YjB1THorMGwxbnNOQVhRK0VSRU1oMU9HTWlV?=
 =?utf-8?B?TUdNSTdWL1JmaEhYbm5RcWVBaGd4Z1FIek9EL0lmWXpHT0lFd1hYTkpLSmdX?=
 =?utf-8?B?WWd1OHNlREluTE9aQktQRTdKOVNsSkt6VFp5VTJoZE4rcS94Qk40UlJlTS9K?=
 =?utf-8?Q?mAM617HC/cGGpcPR1+LrPtokdMP7I66Fi/y4k=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RVlhdHcvZkswWkNGVERPcnc5N0w3bUZWMTI0NGRLZktlKzZZaSswTGVHQ3pZ?=
 =?utf-8?B?bjRTbEhhVkRydFpreDBsenQrMmJiVFI2a1BOaHFaTzBsOWRLTlcvWmo2ZWht?=
 =?utf-8?B?LzFSMTZyRnFUQ0FTNGpMV2c4OWVvZW40NSt2RmNpMjFyTFM2ekRTNm5McElZ?=
 =?utf-8?B?YlJ0eTdTZUtXQ1lWMjZjZlh2QUdyYW5IbW1VS3JsdFljTDhaVGZPQU9YcVRs?=
 =?utf-8?B?UWc1cENRZHBZcGZRUk9pLzIyZUcwam9ZekJXb3lpUVozK1YvNXZpRXRMbk5Q?=
 =?utf-8?B?VnV0THRGZzRmU2Y4UURvRThFYmtUVSt2RitVU3hsclBhbFMrKzdUSlBneng5?=
 =?utf-8?B?TVl5d3hqSXFRZU5JcStBeVo3S3VUSG9sanlOL1lDT29ScFAzTkxvVnV2ZWFw?=
 =?utf-8?B?R1lCVFRIcUU3ZFBSYk9PMGg5OU1nQlZoUmloWWlrSjJydEdWRkNrWXB2eEtD?=
 =?utf-8?B?dWVaV0YrYjc2WXNLSUFPc0M2OG8zY3JRK1VyazZDWDlqNUpaa2lja2RZMSts?=
 =?utf-8?B?enNMdDNGOHdQT3E0Z3lXQjhUeVRWNzBOcGtiSlRkeW1STmtsMEJIcE5Ha0Qw?=
 =?utf-8?B?N2xvZXFUWXBuZzkvbUdtbW9jNG1pbG1sUkI1Zkp0R3BLazZFbkJmaXdPNWx4?=
 =?utf-8?B?R3JPVzU3Y2pDSjEvR1lwd3p6cXdMaXlQSkJYbmtWSGVCMmlkKzBTSnJ1TXBj?=
 =?utf-8?B?NWJZOUFVL2hNWUp2bE1mZmNVOVd3eDVReDlaTXp4aDBMOUxXL1dDYWFkanRp?=
 =?utf-8?B?ODN4Vlc1UVJmckRHUXQxbzJ1eUtoOU9WNzU4aC9hM3YzN1VtdysraWlUSlRE?=
 =?utf-8?B?YTR0bGJmYjllN0VIUnhtdWRwaXl3eG1ORGNsNFY0Q3VPQWV4dlIzSGltcDIz?=
 =?utf-8?B?OUdvMWhjYnBUKzE3bmtSYmlEY0FOcy9Ob1B4UGZId3FXRzR0TXRJOXlpN21u?=
 =?utf-8?B?Mi9GMGV3ek0yM2dyclI4T2NUU0VGejQ0azVzUzROdFVpM01ITFFwbDBWQkh6?=
 =?utf-8?B?bmNZdnk5MGg4aGd3NWhhL1FzN0hPaXRraDZtdWNGbmZIZjJKTndOQ0N2WUVa?=
 =?utf-8?B?WWNNRVZhTWo2RTZOdDd0UGcwSUVXNGRsNjVveU1hNlFXSDZSSGJpMlltRVJu?=
 =?utf-8?B?SUNhaTA2V2xPelNMVUxBWGlTQU9yNlh5VjZMZXBVeVBDakpEUTFwQU9VRW9B?=
 =?utf-8?B?SlE1bkZLQU4zdkpId1RjZWlhWTlqM2xmOVVlZzZTQ0VFNDBROXFHZEsvODA3?=
 =?utf-8?B?SUlvVFZlZVkvczdsK2NlQzhFc1RmYjJ2RUV4d0JzUlVCSjJrUDhVUTFIdXlG?=
 =?utf-8?B?eUxPSXlFZElNOElPT2U5ZzdSaFVNdmJiQ3R2RGNnYlZyemV2cUZwdXlsRXE0?=
 =?utf-8?B?SGxZbWxFN3RWOVpkTFhmT2Y3MjNodXJsV3pQTmtudjIvcTgzNWtWSVpHLzFP?=
 =?utf-8?B?dE45SVNiM05TdWFZWkk4Y0N2SnM2QkhLQ0M2RjJYUzQ4TUdzRzJRNVppd1pk?=
 =?utf-8?B?VlFxY2FXMFNXNUtqdkJaK3JLLys3TGxjVEdiZlorVDc1U3NMT0tiTXM0RUdz?=
 =?utf-8?B?b3J3YjlUc2dFRG11dDFBOXVzVXA5Z2tZNmZ1aEQrVWFLSml0WGcxeWVwMUdY?=
 =?utf-8?B?MDlNL2ZCakNXaFBpT0tRcEYrYWVmVFg5Slg3ZmgwdUpuSUlJRXlnaWJ3YTlu?=
 =?utf-8?B?RzQ1T1F4Um9wMHRCV0FvK1RMRDV3RUJoWE1lK1B6d21NcWJFUk9McENrWExt?=
 =?utf-8?B?Y081ODhqa0ZpTHlWY215dU5UcXMxZkh5SEY3T2N0VFhIa0p5MjF2R050ZjNF?=
 =?utf-8?B?aTBKOXpxRGtpYzZGOTdJdDNHZlU5OGlxajVIeEtaUzVlREp2UnpLaXhhaUJo?=
 =?utf-8?B?OUprbU9Vek93TGlEN1g4TXg0ZkJkMHVta2thSnQ0VU0zL3FaNHQvbXp6VExp?=
 =?utf-8?B?ZEc3dlFsR3pobXRTTGhIekxpVGlNRysvZU4xMjB2Y1BGbkZ5SVhRSXlSS2pF?=
 =?utf-8?B?bzBidGNkdzJ4SGRtellmRzAvZXpXQzhja0MvT0dBRUJjdXpRTUhRdDFVeVVP?=
 =?utf-8?B?SE9RZzIxaWFEeFdvTlhuUytZYWsrL0g5eWpTb2F0K1J6cm9UcDZOaXVPb0x6?=
 =?utf-8?B?VXpMNWttb0NNNlZHV1Izb2pFQ2JCcm82eHlzekQrSjZXUHplcldJYnkvSXBm?=
 =?utf-8?Q?NT+vvvjP33g0MuoxIIbO18g=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F467A5B8478C7644AABBC9D4AC70E0DC@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24ffa53b-a8d3-43bc-7ebf-08dd05988aa6
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2024 17:11:27.5627
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fpfQuoQRcdhdriun0DlJfnTGbKYzM1mIOAaAw4qjNbH2Yco+Y1htNH9Cm2KOuzKTywJOF2plXuvv1XcBKn6M+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR15MB6185
X-Proofpoint-GUID: zdWjqaIVt96I9oeh3lTRiwUWfRxbUpOf
X-Proofpoint-ORIG-GUID: zdWjqaIVt96I9oeh3lTRiwUWfRxbUpOf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

SGkgQW1pciwNCg0KPiBPbiBOb3YgMTUsIDIwMjQsIGF0IDEyOjUx4oCvQU0sIEFtaXIgR29sZHN0
ZWluIDxhbWlyNzNpbEBnbWFpbC5jb20+IHdyb3RlOg0KDQpbLi4uXQ0KDQo+PiANCj4+ICsjaWZk
ZWYgQ09ORklHX0ZBTk9USUZZX0ZBU1RQQVRIDQo+PiArICAgICAgIGZwX2hvb2sgPSBzcmN1X2Rl
cmVmZXJlbmNlKGdyb3VwLT5mYW5vdGlmeV9kYXRhLmZwX2hvb2ssICZmc25vdGlmeV9tYXJrX3Ny
Y3UpOw0KPj4gKyAgICAgICBpZiAoZnBfaG9vaykgew0KPj4gKyAgICAgICAgICAgICAgIHN0cnVj
dCBmYW5vdGlmeV9mYXN0cGF0aF9ldmVudCBmcF9ldmVudCA9IHsNCj4+ICsgICAgICAgICAgICAg
ICAgICAgICAgIC5tYXNrID0gbWFzaywNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgIC5kYXRh
ID0gZGF0YSwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgIC5kYXRhX3R5cGUgPSBkYXRhX3R5
cGUsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAuZGlyID0gZGlyLA0KPj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgLmZpbGVfbmFtZSA9IGZpbGVfbmFtZSwNCj4+ICsgICAgICAgICAgICAg
ICAgICAgICAgIC5mc2lkID0gJmZzaWQsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAubWF0
Y2hfbWFzayA9IG1hdGNoX21hc2ssDQo+PiArICAgICAgICAgICAgICAgfTsNCj4+ICsNCj4+ICsg
ICAgICAgICAgICAgICByZXQgPSBmcF9ob29rLT5vcHMtPmZwX2hhbmRsZXIoZ3JvdXAsIGZwX2hv
b2ssICZmcF9ldmVudCk7DQo+PiArICAgICAgICAgICAgICAgaWYgKHJldCA9PSBGQU5fRlBfUkVU
X1NLSVBfRVZFTlQpIHsNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgIHJldCA9IDA7DQo+PiAr
ICAgICAgICAgICAgICAgICAgICAgICBnb3RvIGZpbmlzaDsNCj4+ICsgICAgICAgICAgICAgICB9
DQo+PiArICAgICAgIH0NCj4+ICsjZW5kaWYNCj4+ICsNCj4gDQo+IFRvIG1lIGl0IG1ha2VzIHNl
bnNlIHRoYXQgdGhlIGZhc3RwYXRoIG1vZHVsZSBjb3VsZCBhbHNvIHJldHVybiBhIG5lZ2F0aXZl
DQo+IChkZW55KSByZXN1bHQgZm9yIHBlcm1pc3Npb24gZXZlbnRzLg0KDQpZZXMsIHRoaXMgc2hv
dWxkIGp1c3Qgd29yay4gQW5kIEkgYWN0dWFsbHkgcGxhbiB0byB1c2UgaXQuIA0KDQo+IElzIHRo
ZXJlIGEgc3BlY2lmaWMgcmVhc29uIHRoYXQgeW91IGRpZCBub3QgaGFuZGxlIHRoaXMgb3IganVz
dCBkaWRuJ3QgdGhpbmsNCj4gb2YgdGhpcyBvcHRpb24/DQoNCkJ1dCBJIGhhdmVuJ3QgdGVzdGVk
IHBlcm1pc3Npb24gZXZlbnRzIHlldC4gQXQgZmlyc3QgZ2xhbmNlLCBtYXliZSB3ZSBqdXN0DQpu
ZWVkIHRvIGNoYW5nZSB0aGUgYWJvdmUgY29kZSBhIGJpdCwgYXM6DQoNCg0KPj4gZiAocmV0ID09
IEZBTl9GUF9SRVRfU0tJUF9FVkVOVCkgew0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgcmV0
ID0gMDsNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgIGdvdG8gZmluaXNoOw0KPj4gKyAgICAg
ICAgICAgICAgIH0NCg0KaWYgKHJldCAhPSBGQU5fRlBfUkVUX1NFTkRfVE9fVVNFUlNQQUNFKSB7
IA0KCWlmIChyZXQgPT0gRkFOX0ZQX1JFVF9TS0lQX0VWRU5UKQ0KCQlyZXQgPSAwOw0KCWdvdG8g
ZmluaXNoOw0KfQ0KDQpXZWxsLCBJIGd1ZXNzIHdlIHNob3VsZCBjaGFuZ2UgdGhlIHZhbHVlIG9m
IEZBTl9GUF9SRVRfU0VORF9UT19VU0VSU1BBQ0UsDQpzbyB0aGF0IHRoaXMgY29uZGl0aW9uIHdp
bGwgbG9vayBiZXR0ZXIuIA0KDQpXZSBtYXkgYWxzbyBjb25zaWRlciByZW9yZGVyIHRoZSBjb2Rl
IHNvIHRoYXQgd2UgZG8gbm90IGNhbGwNCmZzbm90aWZ5X3ByZXBhcmVfdXNlcl93YWl0KCkgd2hl
biB0aGUgZmFzdHBhdGggaGFuZGxlcyB0aGUgZXZlbnQuIA0KDQpEb2VzIHRoaXMgbG9vayByZWFz
b25hYmxlPw0KDQpUaGFua3MsDQpTb25nDQoNCg==

