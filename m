Return-Path: <linux-fsdevel+bounces-50234-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3449FAC939D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 18:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67904A2232A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 16:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261FA1A7AE3;
	Fri, 30 May 2025 16:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DWTtPc4v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128B946B5;
	Fri, 30 May 2025 16:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748622809; cv=fail; b=rUcOZ+NUVMhY1G7kFqV/2Dis2v5hGdPGSu5DpsSqTeV4/KH63f2GYY0Nh4go+gPQc9nqdXP6TQtK68F8L+S03frfegfOtryREsWd03C8TPlrFjAvT/WNrmc9GCrHJv/9cBFimX1IYeCFuLtcwCKx/fzGmGunT7+2u8zfWqjA668=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748622809; c=relaxed/simple;
	bh=vu0Sfdh2CWDCnG/ucPAhVe93OGXuLSItH5rN+QCCUdA=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=BwjlOYww7+02Vz6p+QKbWKJTpOCwoflOG0g/CZdEHuATtAtQcRYk7JAP0bClN9zwwzhJq2b/LlIjgn8ioZdHJrKGOoJzDh7PsQJCrU6MemJdC6Msf7XlD+CeTlKbE28kLBy0JEf/ipNqDa6maOM6X/WvY/NbTEWC6rClHh1G4z4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DWTtPc4v; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54UEMB7E014192;
	Fri, 30 May 2025 16:33:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=vu0Sfdh2CWDCnG/ucPAhVe93OGXuLSItH5rN+QCCUdA=; b=DWTtPc4v
	fRoDGiQhpQvfqr9bR9XEC8XojL7QEzdB2iGuXM3hWDrNoF6K08ZQY8CEfItkRNON
	5a8i9ViCJbedmGPrG8n7wJRNtyCtDIw+bdF7aMhmMOq5wKupWs17NZ2PRw2oSqtQ
	V7/9VfcC47BE48GbhLtqiZyJTpJdZPqUyJNKh1eIzw+jFDYN+Wc7nZ/UPyyTp3pc
	19bwfXB5AJHjNyc23ykbCIj+lktetv1dYmcfWiqjN+lWvUtfjPQuDu7Rjy0DdDI4
	XAkNLMkdz4EftJnckdtrSjSEtzJUBKJH5Uijmff90uKoH+xmjD1lT66wEQ0Q0QnF
	lG05CEXNlWVHyQ==
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46x40kmr80-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 May 2025 16:33:23 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NRwMWckbZ7fWLPHWu1mWTWY82D/SEKivK1uYelvXgN++loK8HB0FTQ+rkfGHjl5soTSToO8+HQx1kO7dsfdGQWOLdv0oCZFpJHnHcZFjWtBXKlTmaq2C0001HzEknFV2KQGBd/V6io/c4kJc7iVOii3I9U7fFyJil/+EOQN9q8daoik4i9SAQqfedi/m8rnkKiUbJo0OpEAxqd0vXLxMvKZCLIuBg1eplQdBfRPAVXC7+/2gKPLJvbFD0RmlgfabX2lHyJR6wbevx1WW2d8ADIl1oi+e7dyZWr5n6jih5h6NmFXIk84G+R4SMepJAzpo0t44MWgP50FEDHBKP/AxjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vu0Sfdh2CWDCnG/ucPAhVe93OGXuLSItH5rN+QCCUdA=;
 b=AhAi8k0/WeYvrvJfK/FleEkxELpQTebS0WVWAnWw/hyvvHLCpCDREL6Cem7euJ8KR0lrTkkxYgcm7JBvVV7qeZ/fb2nSCIr+LhMopt82heZA2t12/LfB3kwN0cdksZ5uk2eosizhQBKg1KbO+ziibigOKKYxrVR4U2Rm/WlUAYc0O++Vbj3W3P3dA3jXkXNO5uHW9o62Kq4ZHhHwwaXLBQFG5PaB8KglVBDTKzpOIK9sRLoiM7XuhHrQNRFDjNUbJ8HiiMIKF51eXcuhJPLBFX22C87k5It7/h8hlxlSWA2QeAQLDjgZpNvjU3ck9t/+oR4Mep/DCKhuvLE6zRZ8Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by IA3PR15MB6748.namprd15.prod.outlook.com (2603:10b6:208:519::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.31; Fri, 30 May
 2025 16:33:20 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%6]) with mapi id 15.20.8769.025; Fri, 30 May 2025
 16:33:19 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "frank.li@vivo.com" <frank.li@vivo.com>,
        "glaubitz@physik.fu-berlin.de"
	<glaubitz@physik.fu-berlin.de>,
        "slava@dubeyko.com" <slava@dubeyko.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Thread-Topic: [EXTERNAL] [PATCH v3 3/3] hfs: fix to update ctime after rename
Thread-Index: AQHb0Th86U8RhDcg4kWinTEZoy7AzrPrXqmA
Date: Fri, 30 May 2025 16:33:19 +0000
Message-ID: <0f96f555b85457d179f474718010e433498d563b.camel@ibm.com>
References: <20250530081719.2430291-1-frank.li@vivo.com>
	 <20250530081719.2430291-3-frank.li@vivo.com>
In-Reply-To: <20250530081719.2430291-3-frank.li@vivo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|IA3PR15MB6748:EE_
x-ms-office365-filtering-correlation-id: 2968d98c-bbeb-4b9f-b0c9-08dd9f97b00d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WThZeWVkQjI1cisvMWJpVWRYV0daWEpHNys0emN4dS80emU4UGVwbDZMcEla?=
 =?utf-8?B?a25INEEwbm5QbUp4WjNGdGMxN1NqUjd6bDNGZXd6bGd0Nm4vUDV0c3VRcVc0?=
 =?utf-8?B?dFBrdjgxQXBSVCtYVzQ3MDBxYUJXc2NlWmtqSlZ0QkplOTZ2cElmRklnYnVY?=
 =?utf-8?B?RGxXQy9HMkVJcFZ5OEhISGo1clZTcFlHQi9GM0tuTkoxbDRWZmk3dHBrY29X?=
 =?utf-8?B?N1dUYXhBK3dZUDJPODhwQkFrV2l5VC9SVjhFTmV0dlJnc2l4ZS91UTlid3dS?=
 =?utf-8?B?NVYzOGJQZ3ZYMzUrem5jYlEvN3U5MkM5S3MzeFVlOUV5SGxEMUI1TTlEUVda?=
 =?utf-8?B?MGtvQi8yS2pBWWVMc3orczhoNXRPbWdscE9aRHBXT1laVlB6Vmd4bW5nQWlz?=
 =?utf-8?B?dTNkb3B6ZmtCWW9qcUNScTAxVS9jUDVEcGFaMXVVOUwvNTFlcVFLSjBJZzF6?=
 =?utf-8?B?KzVZT1BHK3V4QnlQMWc0VExEZ0trU252UGlhVEpUYUVtWWFUa0wzUzd0UHFL?=
 =?utf-8?B?Tlo4THZKRVZkQitRU1hDZkZOOEZNQ0dNRWpKTlNMN3Y2NGZnUWNmWTRPeHlK?=
 =?utf-8?B?T2Z4dTZ1YUNOVm1nNTFNb1B1dTZwMDJsaVgzSGhxVEVEQVZ2V0hnTTdFb2Q2?=
 =?utf-8?B?RlZIcWR3R3dlOGFZbkdFUlZURysyTlBKVWR6YUlnZ016Y2RXNkxidWgzcHlJ?=
 =?utf-8?B?d012ekJwamlMekJ6N2R5SHd0TU1VNHUxRXNJdml1N2Z2WDB3WEZ6Y1VzNjNx?=
 =?utf-8?B?VWxUTlhPZ0t5em8yUHVZSUhvTk1QRUM0aHdjN2ZxNEcrUEZPbnhJOTEyQmV4?=
 =?utf-8?B?bXgwc0swdXkyZWJRK1RPQ3hlYmxMQ2tDZ2U5WnJmNGttT2JrSGcxOG1GRlBr?=
 =?utf-8?B?SUhoUVV2S2tkaVZmR2c0dklyQWg5bFliR1hQVFcwUUl1VENWMUpZUEtMWHdY?=
 =?utf-8?B?VTNRR2M3elQ4K1VUeHNxTFk0cVdEdThzekdhM2JqVjdUU0I3M05HZU0yL09Z?=
 =?utf-8?B?aUlCWmE4QnVmRHl3cEdqK0RwZGNxSTBxUlVhT2VQZ3kvSnNIM0ZyQXFKOGJT?=
 =?utf-8?B?SndUTVJsU1YvY2tHVWROMXpVQTVBcUlpYVB1VVlWYzB2MzNMTVFuOTdlU3ky?=
 =?utf-8?B?T1Ayd2w2N3llSXh1QzR5dW9VQVNuNmpFbFVkOXJnaERiNiszUzl1RVQzcG92?=
 =?utf-8?B?eDh2YkY4MGtMOE9ZM1RINXdNSTRXZzU3czhleUszOS9saW8wYTczaDM5K05k?=
 =?utf-8?B?T3dUUHd3WVJrQlk3SnEzTkV0VzVpeFlkTXhTZU1LNXFUSUdzSDZ5RHZHUEFz?=
 =?utf-8?B?ekgya3dFNTZFZ1UzdEdNc1dlUFV4VWp1cTRaRC83RlN1aVhIaWNyaWVzajBT?=
 =?utf-8?B?R09OQWhFUjRpTC9yczR6UThYT2xrRXI2Z1BlWFd5L0JLdHBWTTJoejhxSHE2?=
 =?utf-8?B?c1hBN3lrbzVITkwrYld2eTdFdDc5Nm5PUVpkM1NCZDdqb293NHFlOEJBUS80?=
 =?utf-8?B?Ym9QZzhqc21nUmZDOE42WGw0a09uK2drNC9KcmNpUGdTc1U1bnF4c1dnTXdM?=
 =?utf-8?B?V1U4Z25kbDd1OGpMUEdtUEdET0R6aDgzak1vOFY5RG4ydDd0aUM3QUcwRHp5?=
 =?utf-8?B?YmF6cSs0TmFwdVNVMklMSktJTml6by9aYmhPc3Y4enZIdVhseitRTFJYY1Nl?=
 =?utf-8?B?VnFIcjE4bnh2dVFjejFvVHJJbVdhek5BUzdIQWlFMnRtYW93WFNxQXcwMmZZ?=
 =?utf-8?B?S01ZODNucWYxUjM5VVZUdFFxZHZnQzJoVlB4LzcrVk1ENCs1UDUrWnVOSnlQ?=
 =?utf-8?B?eWo3NWdqVTJxRld6d2diRHdhM0xScHJhdjQxQVlDZnpkbFNnejkxQXdrcC8x?=
 =?utf-8?B?RnRpczlEV1dNUXhtTVBLbkhGTFM1UUNKazZpbUM3Qk5oOGRta2FMaDFKSzRT?=
 =?utf-8?B?UUJ6cjJZWUI3elkrell3cGY3R3BXc0tRRTdQV0N2dDJxbFYvWmoyL3Yra1RL?=
 =?utf-8?Q?ICqGNW1lIPNYPs508/g7dVh0rfRFPI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q0sxRE5PbWJkcEhYbVA4L3pqSDA3WlhQNENSMUJnM0dBeUlxOTF3bGhNUTJS?=
 =?utf-8?B?MTlhYkI4U3U1R3l1NVRMMHF4MktIRWxneE55TjBUKzEwMTVvckRjSUtNMmVD?=
 =?utf-8?B?NXBrc3ZaMTU4KzFRWGp3NlMxWnNlVTZ3KzJ1ZUFob2tGYUtrNElmSnlEQUFW?=
 =?utf-8?B?TXlQQVdhUWQ0M0d5R0htWlNLL1dMbm1wUjk2aTdhRm1aVkdsYnBZeU5iSmxV?=
 =?utf-8?B?MUtKd2Nubk82TnloV1ZHdFhRdlc3Z0RKV2o3TnNyV0tOUGgyUk1JVEZuK0tq?=
 =?utf-8?B?UTFiUU5CSTNUUjAxVTNSSDJsR1JHSGs1NGcrRlVnZTlMTHpmSkI1QVNZY1dW?=
 =?utf-8?B?c1ZtOTNSaUZJd2czeVd3RUhLczBqbDRON0ZtbDZRUzJ5OUsycGFKM2lHZzht?=
 =?utf-8?B?ZHNVSnRpc2R6S1pmTjZyNkg3WHQraEVJYTVUVlFheFJIVFdXY05KdUFGc1Jv?=
 =?utf-8?B?cjNTb0pSS0hiZEZiNUFtU2VjU1oyeVFlanN1V2d2L256YnJCa2lGQTExM3dR?=
 =?utf-8?B?VWNjQ2x2SFdjTDlqWmhaM0kwejAzUFNqeG55NjNBdzYvQWtxTDBpOU1sck1r?=
 =?utf-8?B?VDdvb29nU2JnelgxemcvdDIxai9BN2s2a0U5ZjFYYTFIalJJTnA3ck9PeWdW?=
 =?utf-8?B?emwwWHdWb1V3NHFENXRuVmh2UEZSNlpsY0dLWENudm05NGtobXlGclMvWXVE?=
 =?utf-8?B?QVRRSnYxV1Y1U0xjUlFORjJ5MmxKbWxqaXhMSC9VNDJvZlEwempXWjNuUSt4?=
 =?utf-8?B?ZlRpc0lod2pCTWpwWXE3TEIxbi9YVk9haUNwSWVMQXczcVpSM0psY3I1WXdo?=
 =?utf-8?B?WCt3QXBGWmdOekR5TU1LRGdRODNsR245bmFuVXF6L3V5WndrbDZnbjdnNldF?=
 =?utf-8?B?MUExRmJMc2lqUTJZSE1JclI2QmdqL1I0TmVSdVFQS0F4QkkzSlpxKzQ0dWoy?=
 =?utf-8?B?MWxWYzU4UjkyWm8yV2VGNmloRHQvTUhDUll4UWdLTmZPWHVkRy9sR21kK3NF?=
 =?utf-8?B?TzhSdnlSUlBXR2NXSWp4T0owU3BUYjJxN0s5T2JZcXlURjFTMUZsaXg3bytK?=
 =?utf-8?B?a09vM0FLT2JxZ3JXWXVKdUNhYm5Dc3JYbHlOWEZRQ3VhYnJBVTVpSlU0aElG?=
 =?utf-8?B?cGkvekJ6eUFnK0FXQnhhUlh4c281Y096UkRxYnNzRjF4b3hWTEhONHVwVE1H?=
 =?utf-8?B?dXBkRll0ZXdNMEZ0eU5NU1d2OFc3STVOVEVmUHZSbnRhT2tIL0JNSkdiUUJr?=
 =?utf-8?B?L1ZzblhId201SkxmTEpLSUV1NEVqNUp5RDNJOFhHdy9jK0I1dEhTemhyeUpI?=
 =?utf-8?B?MnpGS2o5dVFXNjlQMkJkTXI1cTJJcjZUa29UaG94OFQ3NUp2Vk4wNkNJQ0pi?=
 =?utf-8?B?TGpHeEFna2VUY0I1UFZ0azRseTVadXM4US9hUHVHVUFySkFmQ294V0pMbzRt?=
 =?utf-8?B?SGdIMDNFNnVmL1YweXRjMm5lSWM1anpNU3VKcHhtY25DZ1N2YzFYRWdLNWxM?=
 =?utf-8?B?ZGsxbUsxNnNyTUZDeHZNOHN0UkJtM3lidnlTTDVxMWdCTDZYSzZya0l6Y1Fh?=
 =?utf-8?B?TVBpMWhPOVdubWdXQjJKdjRKeStvRGNpVHhGajJUamd6UE5nakFpbVI5WkYx?=
 =?utf-8?B?eFlEeUVDR2hsS05uSlBxOVZ6M0VVZ0hHZVVFdjI3cERDR1FBNGtXQ2g2VEps?=
 =?utf-8?B?TlVnSFVxM0ZHbHl3V0V3M2RxVXd2bnNKQmQ5WjlYVE5qUGhQZVRIMlBPQktW?=
 =?utf-8?B?TWJuRWROQlA0T05aSHJyZ1N6THlvUXhqZjBUTXo4TXViL3RabmV6bjFWdGsw?=
 =?utf-8?B?enZ0a3MyVzltZjBOMnp4RnZhbllmMjFDcmhmTjJnaHFJWnFjdTNEWjRxc3RC?=
 =?utf-8?B?OVcyLzExZXNPZVVnTVN4YWtsYlZuTW1IektEaDZCcWNGR0hQakxxWnptQWRm?=
 =?utf-8?B?bWZYeGcrMHZRd3FZajRJcSt1Rk1XY0RTUEpyOXQ4ZVhDYk96QUV5QmphN3ZW?=
 =?utf-8?B?dG5kdG82VVhjNkR2bU50TTRvNDlpUDhqNElQbXVnbHNSQkxyUFFVWUU5Mit3?=
 =?utf-8?B?a1JIV3Q4czBmK1VSYXdyak5ObjI4NDVwT2psM05CeFFmenZrUzc2K0ttZ1pK?=
 =?utf-8?B?VmtqMmFyWWxVdGFBV2hxamd5dUpKZGFDUk5Ka1lNMklaZjhlL3FLY1ZnMUs1?=
 =?utf-8?Q?IymKD/u6hguslmEWizroJP4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <75B56BA153BECD41BC4469DF81776848@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2968d98c-bbeb-4b9f-b0c9-08dd9f97b00d
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2025 16:33:19.8899
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PF7sHCUhq+HXw11HMlV7zR5TjrOkWCIXZ10wZzR4CNG2kG1i0sivnM6rFrvf6IYD81x62VR73vJGsr/KXGeb1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR15MB6748
X-Proofpoint-ORIG-GUID: JJnWhEdgRsg8_uZp-J4HL_jofE02I8jH
X-Authority-Analysis: v=2.4 cv=fuPcZE4f c=1 sm=1 tr=0 ts=6839ddd3 cx=c_pps a=CmVQekPX50wMUWcHeKemng==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=1WtWmnkvAAAA:8 a=awCEHo8y9DgXWhMretUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: JJnWhEdgRsg8_uZp-J4HL_jofE02I8jH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTMwMDE0NiBTYWx0ZWRfX2t4ru8Qi/4Q1 EMvoXrMy3cDgUHUvidq4apgRlHajSQMNB8Vd6gjQ64TVubKRE0Ooe5DlA97WUv05CyY79umKAhW xRoNGtaiVBrfWQoi+E7B5PEtnAXMpnYJNdi0tny8UxA515E4XoW80w7fpDXZDXZBcWBaURuajwH
 UgSyLp/mcQKLI2U60YM5OPsl0QhBUnw5MhiC1jkQDG1+dJUAuxYmZ2iV4M2ixVKC3lSSbDut82Z PAc4HisLy4bFPMqvOBJ8Nap1/2X39uoC1y47ESmTfRG2MO1cPgrMjP6F78WypYPGfqAsV/zMhVd YU9pJXsQtyI1NJv3jdXXaRoMyUDEKlBVNVJBWQBowZdr0+T3EUpcm4ep24Z/cdrw/RjbfEfzHa1
 /N5iLC3paNeH8mNmn3ceWBt8DS04jO6QDZu8OhpjgkGC1mjQ6yn4sjIZKcUSDoZwmFnPJQKI
Subject: Re:  [PATCH v3 3/3] hfs: fix to update ctime after rename
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-30_07,2025-05-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 mlxlogscore=999 priorityscore=1501 malwarescore=0 mlxscore=0 phishscore=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 adultscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505300146

T24gRnJpLCAyMDI1LTA1LTMwIGF0IDAyOjE3IC0wNjAwLCBZYW5ndGFvIExpIHdyb3RlOg0KPiBT
aW1pbGFyIHRvIGhmc3BsdXMsIGxldCdzIHVwZGF0ZSBmaWxlIGN0aW1lIGFmdGVyIHRoZSByZW5h
bWUgb3BlcmF0aW9uDQo+IGluIGhmc19yZW5hbWUoKS4NCj4gDQo+IFcvTyBwYXRjaCh4ZnN0ZXN0
IGdlbmVyaWMvMDAzKToNCj4gDQo+ICArRVJST1I6IGFjY2VzcyB0aW1lIGhhcyBub3QgYmVlbiB1
cGRhdGVkIGFmdGVyIGFjY2Vzc2luZyBmaWxlMSBmaXJzdCB0aW1lDQo+ICArRVJST1I6IGFjY2Vz
cyB0aW1lIGhhcyBub3QgYmVlbiB1cGRhdGVkIGFmdGVyIGFjY2Vzc2luZyBmaWxlMg0KPiAgK0VS
Uk9SOiBhY2Nlc3MgdGltZSBoYXMgY2hhbmdlZCBhZnRlciBtb2RpZnlpbmcgZmlsZTENCj4gICtF
UlJPUjogY2hhbmdlIHRpbWUgaGFzIG5vdCBiZWVuIHVwZGF0ZWQgYWZ0ZXIgY2hhbmdpbmcgZmls
ZTENCj4gICtFUlJPUjogYWNjZXNzIHRpbWUgaGFzIG5vdCBiZWVuIHVwZGF0ZWQgYWZ0ZXIgYWNj
ZXNzaW5nIGZpbGUzIHNlY29uZCB0aW1lDQo+ICArRVJST1I6IGFjY2VzcyB0aW1lIGhhcyBub3Qg
YmVlbiB1cGRhdGVkIGFmdGVyIGFjY2Vzc2luZyBmaWxlMyB0aGlyZCB0aW1lDQo+IA0KPiBXLyBw
YXRjaCh4ZnN0ZXN0IGdlbmVyaWMvMDAzKToNCj4gDQo+ICArRVJST1I6IGFjY2VzcyB0aW1lIGhh
cyBub3QgYmVlbiB1cGRhdGVkIGFmdGVyIGFjY2Vzc2luZyBmaWxlMSBmaXJzdCB0aW1lDQo+ICAr
RVJST1I6IGFjY2VzcyB0aW1lIGhhcyBub3QgYmVlbiB1cGRhdGVkIGFmdGVyIGFjY2Vzc2luZyBm
aWxlMg0KPiAgK0VSUk9SOiBhY2Nlc3MgdGltZSBoYXMgY2hhbmdlZCBhZnRlciBtb2RpZnlpbmcg
ZmlsZTENCj4gICtFUlJPUjogYWNjZXNzIHRpbWUgaGFzIG5vdCBiZWVuIHVwZGF0ZWQgYWZ0ZXIg
YWNjZXNzaW5nIGZpbGUzIHNlY29uZCB0aW1lDQo+ICArRVJST1I6IGFjY2VzcyB0aW1lIGhhcyBu
b3QgYmVlbiB1cGRhdGVkIGFmdGVyIGFjY2Vzc2luZyBmaWxlMyB0aGlyZCB0aW1lDQo+IA0KDQpJ
IHN0aWxsIGRvbid0IHVuZGVyc3RhbmQgdGhpcyBjb21tZW50LiBXaGF0IGRvZXMgZmluYWxseSB0
aGlzIHBhdGNoIGZpeD8NCg0KVGhhbmtzLA0KU2xhdmEuDQoNCj4gU2lnbmVkLW9mZi1ieTogWWFu
Z3RhbyBMaSA8ZnJhbmsubGlAdml2by5jb20+DQo+IC0tLQ0KPiAgZnMvaGZzL2Rpci5jIHwgMTcg
KysrKysrKysrKy0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCA3
IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2ZzL2hmcy9kaXIuYyBiL2ZzL2hmcy9k
aXIuYw0KPiBpbmRleCA4NmE2YjMxN2I0NzQuLjc1NmVhN2I4OTVlMiAxMDA2NDQNCj4gLS0tIGEv
ZnMvaGZzL2Rpci5jDQo+ICsrKyBiL2ZzL2hmcy9kaXIuYw0KPiBAQCAtMjg0LDYgKzI4NCw3IEBA
IHN0YXRpYyBpbnQgaGZzX3JlbmFtZShzdHJ1Y3QgbW50X2lkbWFwICppZG1hcCwgc3RydWN0IGlu
b2RlICpvbGRfZGlyLA0KPiAgCQkgICAgICBzdHJ1Y3QgZGVudHJ5ICpvbGRfZGVudHJ5LCBzdHJ1
Y3QgaW5vZGUgKm5ld19kaXIsDQo+ICAJCSAgICAgIHN0cnVjdCBkZW50cnkgKm5ld19kZW50cnks
IHVuc2lnbmVkIGludCBmbGFncykNCj4gIHsNCj4gKwlzdHJ1Y3QgaW5vZGUgKmlub2RlID0gZF9p
bm9kZShvbGRfZGVudHJ5KTsNCj4gIAlpbnQgcmVzOw0KPiAgDQo+ICAJaWYgKGZsYWdzICYgflJF
TkFNRV9OT1JFUExBQ0UpDQo+IEBAIC0yOTYsMTQgKzI5NywxNiBAQCBzdGF0aWMgaW50IGhmc19y
ZW5hbWUoc3RydWN0IG1udF9pZG1hcCAqaWRtYXAsIHN0cnVjdCBpbm9kZSAqb2xkX2RpciwNCj4g
IAkJCXJldHVybiByZXM7DQo+ICAJfQ0KPiAgDQo+IC0JcmVzID0gaGZzX2NhdF9tb3ZlKGRfaW5v
ZGUob2xkX2RlbnRyeSktPmlfaW5vLA0KPiAtCQkJICAgb2xkX2RpciwgJm9sZF9kZW50cnktPmRf
bmFtZSwNCj4gKwlyZXMgPSBoZnNfY2F0X21vdmUoaW5vZGUtPmlfaW5vLCBvbGRfZGlyLCAmb2xk
X2RlbnRyeS0+ZF9uYW1lLA0KPiAgCQkJICAgbmV3X2RpciwgJm5ld19kZW50cnktPmRfbmFtZSk7
DQo+IC0JaWYgKCFyZXMpDQo+IC0JCWhmc19jYXRfYnVpbGRfa2V5KG9sZF9kaXItPmlfc2IsDQo+
IC0JCQkJICAoYnRyZWVfa2V5ICopJkhGU19JKGRfaW5vZGUob2xkX2RlbnRyeSkpLT5jYXRfa2V5
LA0KPiAtCQkJCSAgbmV3X2Rpci0+aV9pbm8sICZuZXdfZGVudHJ5LT5kX25hbWUpOw0KPiAtCXJl
dHVybiByZXM7DQo+ICsJaWYgKHJlcykNCj4gKwkJcmV0dXJuIHJlczsNCj4gKw0KPiArCWhmc19j
YXRfYnVpbGRfa2V5KG9sZF9kaXItPmlfc2IsIChidHJlZV9rZXkgKikmSEZTX0koaW5vZGUpLT5j
YXRfa2V5LA0KPiArCQkJICBuZXdfZGlyLT5pX2lubywgJm5ld19kZW50cnktPmRfbmFtZSk7DQo+
ICsJaW5vZGVfc2V0X2N0aW1lX2N1cnJlbnQoaW5vZGUpOw0KPiArCW1hcmtfaW5vZGVfZGlydHko
aW5vZGUpOw0KPiArCXJldHVybiAwOw0KPiAgfQ0KPiAgDQo+ICBjb25zdCBzdHJ1Y3QgZmlsZV9v
cGVyYXRpb25zIGhmc19kaXJfb3BlcmF0aW9ucyA9IHsNCg==

