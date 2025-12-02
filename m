Return-Path: <linux-fsdevel+bounces-70481-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A136C9CF18
	for <lists+linux-fsdevel@lfdr.de>; Tue, 02 Dec 2025 21:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 03AB84E0265
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Dec 2025 20:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117A32F12C5;
	Tue,  2 Dec 2025 20:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="j4eoN3xj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB11C2853F1;
	Tue,  2 Dec 2025 20:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764708257; cv=fail; b=po1y40pfciWZ9PgnnjM2ef1G54XLpq3OeXbotX5iVPhZdpou3tkQNEvh4i8GXpaMlxLyWqNq+uF++CHJLQKL0oeqkS5edTQLdOdjE14coXWBfPewApHZjLxQ3pteM1MpbZNdQ1ISeClEW3L3NEqqKBPU032+tzi/Y7i4mA5idGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764708257; c=relaxed/simple;
	bh=lIy/NHHNwDXUnCN7vxE8tSsKxZng02o8KaptGpm0Qvc=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=L2il3na2M6hJA1BqNNEFRYWHI7LXW5o6csBAK1GqfMQkQGnYFERTquTLVwFRJTdHGVqVmTJyy0RregC5MBLxHqNK4PiigPclYTo9xkYcnxbMUyoftZn0siL3xqMJzFVzdZzKx9UoZ5XdIf0bXJpcq2LJOuZSKU7TvHWHLsWlEh4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=j4eoN3xj; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B2BQd3L029603;
	Tue, 2 Dec 2025 20:44:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=lIy/NHHNwDXUnCN7vxE8tSsKxZng02o8KaptGpm0Qvc=; b=j4eoN3xj
	M0IjYta24BiYNooCsOh7EoK5WeK8Rq9pQ3zzviUcCIosQEaZCcMe+mKpsEvKYFAa
	/3PLCBljP7amOXGN+oQ4nayXU8/2Qa9rdhs/fFOzaKuirG2+N/+J0iRLizKKrmhN
	HcCgOaSFEHMRWcGB6mpHTo8Y29sHHT3yb1eQbs7o8fl3+3OCS1OOofpKzJWeVhEM
	4QR0PkW2xxF317SSPKCpoZSLRNGRWS9T3lp8mxYs+T2SP8DyqSQSyuR3YMKr4oFm
	4bupY0aH5fC2UnFg1P+YhS8lXpDXvWlWB1rbUMUifo/jt5CrqjH+2Z3uZVJ1Rm91
	GD91tmUv1A3KVA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqrbg7c06-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Dec 2025 20:44:13 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5B2KiCvt018809;
	Tue, 2 Dec 2025 20:44:12 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012011.outbound.protection.outlook.com [40.107.209.11])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqrbg7c04-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Dec 2025 20:44:12 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tFZRbrWQMAlaKGvpfCSbpwv8sUU1Eh2U4UMWsBkaf7/HX6R1zGG3OpM+5PwKiFHVhoQk2DkLUfETUCMCqbJLbnXI3L8vx1ArfP8HsJI/x1JkjYOLnUxKrhtg9HhLtDH3tNu/4Ya1jQwtIH2wvln/ZybAX8r1qQXJJeH8GDupjo9Xn2m74iTGj3FtcQTGI51X7dp3yYdC6fAe4no0S71OOe5IgHQPHq2N04em+w44/a7Yq0eVIRgniCk0oRFMH7uwbyQwX+yL3wzruh9M4VppBtre0JCS6Yu2kFrYmSpePZ1ym6kuZgvSy7bQbFIX1mFB/I2cWZpF5hD8XT/vSZMLPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lIy/NHHNwDXUnCN7vxE8tSsKxZng02o8KaptGpm0Qvc=;
 b=vBOop6DKLjDsc14fR4Nv9upcmCagGZ/Bpynp5IUYswQYelEb9YRaXgN2/Ym9XQkB0Xr0AJn0YAhRkgqCTP05kIUZp59Vp3pwNqMJjw4z1OWgMGcp645ZQQoclg3aQsXO/vxAgX/KkGJhVDN3szUTGhVKTr/TIkZfrJa88BiRQsCqw+GcE0YqO2s4nq7o+Z4xsnSObMoQX+G2I+TjapZ+w4M6zMa5mHzwYJ+7nSKYRUbbSR98+/YHZdaKI4GB1m+WpHMJgPQAj31q+RT88cejN8g6UNpMYwDzMijioL/dm9oJ/QLDXqN3M9h9PRfx+e1c4A8fjHW78MfXxLhsnVN1Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by DM6PR15MB3784.namprd15.prod.outlook.com (2603:10b6:5:2b0::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Tue, 2 Dec
 2025 20:44:10 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%4]) with mapi id 15.20.9388.003; Tue, 2 Dec 2025
 20:44:10 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: Alex Markuze <amarkuze@redhat.com>,
        "ceph-devel@vger.kernel.org"
	<ceph-devel@vger.kernel.org>
CC: Viacheslav Dubeyko <vdubeyko@redhat.com>,
        "idryomov@gmail.com"
	<idryomov@gmail.com>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>
Thread-Topic: [EXTERNAL] [PATCH v2 1/3] ceph: handle InodeStat v8 versioned
 field in reply parsing
Thread-Index: AQHcY6SCSfSk7up4Hk2qZHyClVLRzLUO0YeA
Date: Tue, 2 Dec 2025 20:44:10 +0000
Message-ID: <8e9ec4b352e3f0b67bc14ae9c78ee4f623a4900d.camel@ibm.com>
References: <20251202155750.2565696-1-amarkuze@redhat.com>
	 <20251202155750.2565696-2-amarkuze@redhat.com>
In-Reply-To: <20251202155750.2565696-2-amarkuze@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|DM6PR15MB3784:EE_
x-ms-office365-filtering-correlation-id: 95b21176-d987-4fa2-1e3a-08de31e38bc4
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?U3JwdmlKNUxKdlpmbVIvUWpKNVRia0VqMmlxL2VEdHgzbnB6ZjRKL1owRm1C?=
 =?utf-8?B?b2w5aDNDN2hpMEU4M2V5YU5jY0xLajZyU09hNGxzSlAwT1RXRnIybHFRbVg4?=
 =?utf-8?B?aUpkSE1jU2M2RVdFOU1yYXBMVlNDbHRmNFFsdXRvcm9QMWl1Z3o2Q1NOSUFp?=
 =?utf-8?B?YzhqbGJUSG1sYWpaZm1GQ25xQ0JRUVRBYnNIZmFnc3pUd0lKbXFhSTlmOGp6?=
 =?utf-8?B?ZlJORjc5QVNRdFliR1I1bnF4U21pUWNvamtjeitESjE5eDhwZ2s5Rk1nd211?=
 =?utf-8?B?UTF0QktUQlFmclVjc3EvZlR2OEowNDM3dzN5RmxtOTBjaHRGMDJTUlJ3VjJw?=
 =?utf-8?B?dUhWUElxYWhYZk5ha3JrQk1SZE95ZGJzQkg3Ym11TVpTTmtwVEtBSmJxcFBW?=
 =?utf-8?B?S0F0NGdQa2ZncVBRcUVFNENxeFVXVkg4MXBTWWI0dHpzNGtaT2tKRDhRSzVh?=
 =?utf-8?B?eXBrL1d4cU9zblJmZEFpTTk0dld0QU96c2NJQU9TaG5QNFdoMVBmcHoxVXZ0?=
 =?utf-8?B?QXFabmJtYXlwTEpPUSsrVm8zUzRxWFE5cWMrK0J0ZkRCU243OERGNFc1Qklh?=
 =?utf-8?B?UEM2cEQ5YWhGbnB1SVFnRllIajc2dUFaTmYxVE5FRHZaUTZqM2pla0prWEhv?=
 =?utf-8?B?SWtlYnd5aXhzNWJoVWZVaEt1bGJ6MkRxWEV6WHlWcHduTXlJM3ZOenZzTTNp?=
 =?utf-8?B?TmRRRXd2Zmg1Y1p6ZTJlUHJhVy9LemYrQk5FMlczbmtKSHFsbVV6UlZ2cFA0?=
 =?utf-8?B?YVdaNUxmYmgzTkZOTkVuREVMampDRU9nTm0vTmhJWlRVSmFkQSt1dEE2Y2Z4?=
 =?utf-8?B?SytTRXNTY2J1bzNsdDlka0JFalFZcnNqU29wTUVoV3NtODZhUkRzRUZhWjky?=
 =?utf-8?B?WUJrOXJuVzhCV3ozWkJRQjM4QUtzWTdRbjd2RGxqU0NROEtKU2YyaFdReENz?=
 =?utf-8?B?eXE1UVdrVjBoRmF1ODJLVGRJY1ZiTitlekttS0JrUW0wMzJra2N2ZDEwUkZL?=
 =?utf-8?B?MTJkMFVHT0N1OWpLZWFkUXRuSkgzL29DT0xZWVFXSjdmVmZjZ3UyTi9UaDlK?=
 =?utf-8?B?S2hLdVRKVytEUDREbG81M01IUUsycDYwUm1CS1BiSkdyY2FjcXZkaVg3TEV2?=
 =?utf-8?B?MGhENU45NHlWMVZJemk1TDNuOWhieEk3QWd2VEd2Nm8xZGxkSmxMd1k4TTBG?=
 =?utf-8?B?Sm4zY0NtK0kwRXNFdDFFUUoxTHZxVTk5N0R0V3FlTCtQN1BEMjFmRWxTY05Y?=
 =?utf-8?B?THA3TTUvVlpQZUt4L0xwWCs5aDdlSGNEYW9HUzBEeERNZWdmRVY2dGJueVR5?=
 =?utf-8?B?Vkdhc0QyWUtybTMvN05Udnp3NENmeW03eHh4em5rTlBkNG1iWnVzWHhmcklJ?=
 =?utf-8?B?RGdpT0QxOUl4L1U0K1QzUXE4Tm1XVENubENyanBLdG55ZUVNUWtER2pJRi8x?=
 =?utf-8?B?cmlGVFY5S2wxZUdndG1sbzhiVkw4dlFDNldFemdQOTNlQ0tKbmhFbmhOTElQ?=
 =?utf-8?B?VW1ZZXVsRmljcllvamRMWjZCakhqK0lKVEViSWloM1JRYWtLY050K3ZpU1JZ?=
 =?utf-8?B?UDNyVHFQZC85UHN5dGQ0TlRqSEpxREttZ3NPMXNQT3o0bVgvNHIvMVVvbnA4?=
 =?utf-8?B?ZEhyZlpKaTJ1emt6QVBIdzJ2c3NqTWdTUjZ5aUQzMllRd0tNbThzanYrL1Fr?=
 =?utf-8?B?NnNSWjBJSGg5QWVsRE1GbjFaclhEM0xGZ0M4Y3AvYTdLN084Yy81UmJLM0th?=
 =?utf-8?B?ZHRuWmFrV2hNQUdxSUo2NVJnNGdDNTZNYk5laHJYNjVNSUdiNFpTdmdjZHJt?=
 =?utf-8?B?b2RKRFBCTVo3VmI3UjFhUVUrZXU2ekNCOEhNQmI2SCtLcWVVc3I2bkFXblNW?=
 =?utf-8?B?bG1rYk5USFc0cFNPNm93YU44Q1FIREZwUnpOSkloNjNXdjNSdzRFNXMySEF3?=
 =?utf-8?B?YW4rRnZUTFhOQ0RTejZxZURwNkNabFNTUGFERHNUcTNnWGpacUJrMDU0bXFW?=
 =?utf-8?B?VDFld3VUVk41RU5NTHB0QzBoZUc5a0pkWldtQk9hZEsxUUVnRG9Hb3h0Q0xN?=
 =?utf-8?Q?D+7szr?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R0I5bXZENno5YnNNZytRMndVbi96REtqb0pjaFlHaWhlS2kzbE4rZHY4OXBw?=
 =?utf-8?B?R1ljR0FBUHFHSGdMcmJlU3krREkvTHU5UlRXOWVvZjFLb1NYMWRkbzZvaFJU?=
 =?utf-8?B?YkQ3eUI4bnN0dzAzNFRnUHF2UVNydHhvVm9XZ0kxTzJpNi9sL05zd256UzQ0?=
 =?utf-8?B?R0UxU2VDVUE2T1JnYk5vMCt5OE4rZEJoZGU4L3IwY1hBc2o5SzM5VEJNWi82?=
 =?utf-8?B?b0hQUHRaeGVzdU1wY3NsMnJYc3dJZFpnZ3QwK1Bpbk5qdEpVTVVGemV2bkJl?=
 =?utf-8?B?aGRzYVpKSkJyRWZsL0c4TFc3RjJjU0IvNDArS0NPYkpYL2Vrc2M4K1lnTitO?=
 =?utf-8?B?aFJCRlJiZkpSMlBoQzBMc2JlM3RVTFIveU55YTB3cTVLRWx5dTZQcTVNdGhz?=
 =?utf-8?B?c1owTW1rRHJIb1I2b2dITCtieDJqTWxsT1pTWFdVcUl6clFkMEJJUEZIZDFs?=
 =?utf-8?B?M0VyVzROcVpxRXlHaEhKZFZlM3R2Z1Rtdk5oNnJ4TzExZVBtdW9DeHIwWnMy?=
 =?utf-8?B?RDNqVm9JOUMyYmYxNFFLRlc5emE3K0JJcmJNK3k5L2dKWWtTbUtaYitPUStr?=
 =?utf-8?B?emV5YWxPY2hQdnR6ZkF6d1MyTFR1SFJMdkZtdmxHNHhJTEFvb3V2OVV5bHVn?=
 =?utf-8?B?aGliQno2RlB3TlM2emMrZjdkVE1OY2cwN1RkUVl5MVVzMnRPSEJOTHFsM1Rq?=
 =?utf-8?B?KzIvbUNSNGJBZVJkTXh1elhXWGdFcjJuRVJJMWt5eDAwRFd0ZGRYUTkxSHNr?=
 =?utf-8?B?WnZsbUR0MW1NdElFSE1IcTJJVXMvVjBXRHZSYjgzSitZdzVKdWZwbFlhc3FP?=
 =?utf-8?B?SCtMTEZCV2xNRmJpWkVXeXBMZ1RnS2UzZXdTYnpXSnNvaTRtaXhsYW5BdmQ4?=
 =?utf-8?B?SW16MjRYTS8rTkNXd1VvbkphSzFwMjNIR1NXQVlqOUl2UkwwckZzaXFNK2lV?=
 =?utf-8?B?eDFlV3M5MGxnaUNQVXJZTTk2UHpvdlBnVDdqZVpMRmlMOVU5K0RtRWpBQ3J0?=
 =?utf-8?B?aWxMUWNmVUZNV0FTc3I2anRLZ1Nid0Y5UE5TL01Oa3hBWjNMbWhhaldXVCs0?=
 =?utf-8?B?NXBaYUMzVjhSWUEwendaS3JaV1ZpMWJwSDVSamNWaWFuY2JOTU92eXdFMjhi?=
 =?utf-8?B?VjVzT2hxeDE4SXhxQlFJZUlsUzNGM3h1M2dLd2kzRkJ0QXd5NVJJeEVUMWJC?=
 =?utf-8?B?Z0RtLzVFVVpmeFpwT2JJWXJxN1BKRkNRTDdQUk1jVlB2TnVveWw1bWwyaUpr?=
 =?utf-8?B?OTVNNnVoeWwxWU5UNGxaUUdTbEdWcWxYYWhQS0JOSURYQXhxZG56OENGTTIr?=
 =?utf-8?B?b1k1d0gwcEQzNDVuTXpmS3BNVVljb0Z6bE9iZExFMmtPTGNEWWR6b2ZXVjBL?=
 =?utf-8?B?aHBpNTNLSUFIT2EwZ3NSMHNDak4yaFRTamN1TUZXRVppVlV4YmJYRkNaTWRN?=
 =?utf-8?B?NDEvK3lka0FrTlo3d1Q3VTREaHdlZktCTDA1SkFyY0pKdVRlazFvaWc1dytN?=
 =?utf-8?B?VGlEMHdCdFJqU1RpN3JCM2ErYUt3NC9lMVEzaWNOeVdpS3VLVjBsVC8zUzl1?=
 =?utf-8?B?K2ZkWVFpbnVUYU1QaWtkRitwczFRcXF3bTNoYWxVMWNDMmEvaHUyckpHKzFI?=
 =?utf-8?B?cGhpUWRVeDR4ZHhWL1JTRmN3NHl2akR0d3ZzUUl6d0NiclE4a21HbmNFQWVE?=
 =?utf-8?B?NDJydlNBT0NkdXdQcnBKZ0JXUDQzWGRJeWRyRnBKZ0ZmMExRcWszZWl0U0RN?=
 =?utf-8?B?TVUrVUlJemhxTEszRm13dkdiN1NUMzZBUGNJcmJuZUFKYmRrL2lCZWZjYVp0?=
 =?utf-8?B?OXBmZnVySDhPTWVrWms2ZHl0aU5XcUJsVExteVo3NU50OHo2c3p2SHY2K3lE?=
 =?utf-8?B?R0xvSjl6REhUOWxod1BFOFBXQWU5UVZBYXZodGFSaDZNeXY5ZU94bU4wWE1D?=
 =?utf-8?B?RWlCK3dCd24zRHhBbE1HZ0Z2RjF1ZVhRelRXTDdDNTUrWnByNVA4RWV1blhC?=
 =?utf-8?B?NmxFdklxOU4yQWU4cUx0K3ROZkord1F6Y2VhTXJKVTVlOEhoMmpiSjhsck1E?=
 =?utf-8?B?cjZWZXF4cytuTVhtbnZ3ZWZLY0NWQzBrcGJ3NUFlbi92SndzV0h3b1RCaDI2?=
 =?utf-8?B?anhOcDVscmF2K3Q0eG1sYlU3a1ZKMjJlMXlFNVpvaGZXS0xBSjk0M2FuQUlH?=
 =?utf-8?Q?AlpW+B1yezCFmd8xu56jcF4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BC074027EDF6F74A91D38E4E4A059B6A@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 95b21176-d987-4fa2-1e3a-08de31e38bc4
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2025 20:44:10.5082
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kYxxpay4eyQoz56Evk7auNJ8kAtMn7+DGLzkFH9dj4eY3KHKqU8UPapcmG9JAIzEnadCaQz4H3/k++DLyRlMqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3784
X-Proofpoint-ORIG-GUID: 2Im7GLFpVL72qBeoitYdj-YahQRvw_ob
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI5MDAxNiBTYWx0ZWRfXwA2KRt2ibeRw
 lR6+oJnNfp+Oz5jv0jSeAmbZiDwQq28o3uLU/Bw0dUh99aDWM4xFaq4SyHDqIe2dxbiZiYKU0ZU
 4smoLr0BRmAuFZxGI1BkFP+ePVvCUdrKFkWqteYqa/M1X3DpFPBy0zR6EKzi4O8I5ssYzigoDK1
 YpXvtRF/OoE9URIFRfYykpTrZZYFHA5JeyxModAPq7QT5d7P2nsdICTXTAUhAIyOGxzSazK7Fcs
 lx9T8wte5jVPAnGpBcXAEixz823aHAQTdyGLix5ZmktUy0zNAirmVGdVLRFao2Hmz5yu5FT4qH5
 L3bUpoZ4SD8zIP36vlE4lwQQyry6DusfUtc5wTtOnms5taiG9vpdDm9/kgOLphyhV3Y3sBGgFp5
 TOVPm8lgOPWhqfVj+moNjch6596r8Q==
X-Authority-Analysis: v=2.4 cv=UO7Q3Sfy c=1 sm=1 tr=0 ts=692f4f9d cx=c_pps
 a=q3M5bEXgJc9IxHNyMLvWsA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8
 a=WymzpGUFUZ0znDCykXUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: wd2wXvJh4FlKnTUieTuv3SiVbD0dp6js
Subject: Re:  [PATCH v2 1/3] ceph: handle InodeStat v8 versioned field in
 reply parsing
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-01_01,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 phishscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511290016

T24gVHVlLCAyMDI1LTEyLTAyIGF0IDE1OjU3ICswMDAwLCBBbGV4IE1hcmt1emUgd3JvdGU6DQo+
IEFkZCBmb3J3YXJkLWNvbXBhdGlibGUgaGFuZGxpbmcgZm9yIHRoZSBuZXcgdmVyc2lvbmVkIGZp
ZWxkIGludHJvZHVjZWQNCj4gaW4gSW5vZGVTdGF0IHY4LiBUaGlzIHBhdGNoIG9ubHkgc2tpcHMg
dGhlIGZpZWxkIHdpdGhvdXQgdXNpbmcgaXQsDQo+IHByZXBhcmluZyBmb3IgZnV0dXJlIHByb3Rv
Y29sIGV4dGVuc2lvbnMuDQo+IA0KPiBUaGUgdjggZW5jb2RpbmcgYWRkcyBhIHZlcnNpb25lZCBz
dWItc3RydWN0dXJlIHRoYXQgbmVlZHMgdG8gYmUgcHJvcGVybHkNCj4gZGVjb2RlZCBhbmQgc2tp
cHBlZCB0byBtYWludGFpbiBjb21wYXRpYmlsaXR5IHdpdGggbmV3ZXIgTURTIHZlcnNpb25zLg0K
PiANCj4gU2lnbmVkLW9mZi1ieTogQWxleCBNYXJrdXplIDxhbWFya3V6ZUByZWRoYXQuY29tPg0K
PiAtLS0NCj4gIGZzL2NlcGgvbWRzX2NsaWVudC5jIHwgMjAgKysrKysrKysrKysrKysrKysrKysN
Cj4gIDEgZmlsZSBjaGFuZ2VkLCAyMCBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
ZnMvY2VwaC9tZHNfY2xpZW50LmMgYi9mcy9jZXBoL21kc19jbGllbnQuYw0KPiBpbmRleCAxNzQw
MDQ3YWVmMGYuLmQ3ZDgxNzhlMWY5YSAxMDA2NDQNCj4gLS0tIGEvZnMvY2VwaC9tZHNfY2xpZW50
LmMNCj4gKysrIGIvZnMvY2VwaC9tZHNfY2xpZW50LmMNCj4gQEAgLTIzMSw2ICsyMzEsMjYgQEAg
c3RhdGljIGludCBwYXJzZV9yZXBseV9pbmZvX2luKHZvaWQgKipwLCB2b2lkICplbmQsDQo+ICAJ
CQkJCQkgICAgICBpbmZvLT5mc2NyeXB0X2ZpbGVfbGVuLCBiYWQpOw0KPiAgCQkJfQ0KPiAgCQl9
DQo+ICsNCj4gKwkJLyoNCj4gKwkJICogSW5vZGVTdGF0IGVuY29kaW5nIHZlcnNpb25zOg0KPiAr
CQkgKiAgIHYxLXY3OiB2YXJpb3VzIGZpZWxkcyBhZGRlZCBvdmVyIHRpbWUNCj4gKwkJICogICB2
ODogYWRkZWQgb3B0bWV0YWRhdGEgKHZlcnNpb25lZCBzdWItc3RydWN0dXJlIGNvbnRhaW5pbmcN
Cj4gKwkJICogICAgICAgb3B0aW9uYWwgaW5vZGUgbWV0YWRhdGEgbGlrZSBjaGFybWFwIGZvciBj
YXNlLWluc2Vuc2l0aXZlDQo+ICsJCSAqICAgICAgIGZpbGVzeXN0ZW1zKS4gVGhlIGtlcm5lbCBj
bGllbnQgZG9lc24ndCBzdXBwb3J0DQo+ICsJCSAqICAgICAgIGNhc2UtaW5zZW5zaXRpdmUgbG9v
a3Vwcywgc28gd2Ugc2tpcCB0aGlzIGZpZWxkLg0KPiArCQkgKiAgIHY5OiBhZGRlZCBzdWJ2b2x1
bWVfaWQgKHBhcnNlZCBiZWxvdykNCj4gKwkJICovDQo+ICsJCWlmIChzdHJ1Y3RfdiA+PSA4KSB7
DQo+ICsJCQl1MzIgdjhfc3RydWN0X2xlbjsNCj4gKw0KPiArCQkJLyogc2tpcCBvcHRtZXRhZGF0
YSB2ZXJzaW9uZWQgc3ViLXN0cnVjdHVyZSAqLw0KPiArCQkJY2VwaF9kZWNvZGVfc2tpcF84KHAs
IGVuZCwgYmFkKTsgIC8qIHN0cnVjdF92ICovDQo+ICsJCQljZXBoX2RlY29kZV9za2lwXzgocCwg
ZW5kLCBiYWQpOyAgLyogc3RydWN0X2NvbXBhdCAqLw0KPiArCQkJY2VwaF9kZWNvZGVfMzJfc2Fm
ZShwLCBlbmQsIHY4X3N0cnVjdF9sZW4sIGJhZCk7DQo+ICsJCQljZXBoX2RlY29kZV9za2lwX24o
cCwgZW5kLCB2OF9zdHJ1Y3RfbGVuLCBiYWQpOw0KPiArCQl9DQo+ICsNCj4gIAkJKnAgPSBlbmQ7
DQo+ICAJfSBlbHNlIHsNCj4gIAkJLyogbGVnYWN5ICh1bnZlcnNpb25lZCkgc3RydWN0ICovDQoN
Ckxvb2tzIGdvb2QuDQoNClJldmlld2VkLWJ5OiBWaWFjaGVzbGF2IER1YmV5a28gPFNsYXZhLkR1
YmV5a29AaWJtLmNvbT4NCg0KVGhhbmtzLA0KU2xhdmEuDQo=

