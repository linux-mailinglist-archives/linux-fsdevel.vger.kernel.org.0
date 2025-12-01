Return-Path: <linux-fsdevel+bounces-70406-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 944E2C99863
	for <lists+linux-fsdevel@lfdr.de>; Tue, 02 Dec 2025 00:07:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7ADD94E2036
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Dec 2025 23:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C175296BD0;
	Mon,  1 Dec 2025 23:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CkMRaXgx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215ED287516;
	Mon,  1 Dec 2025 23:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764630422; cv=fail; b=sVyRV424UMAnAfozy9hw4+Ny9YZS7QggQVWrPUKE6TiAshznPDxFgT4pWxNwoxq5ftULq6e9jjoY092tauYQ7QqOEsGrsiGigUEw4s7H3oSXb0NvvZZfiv8Doo9s55RJ/4jfCNYA1iQ6SqlQ+miMlF1Gc4mWrU1ah8X0aoIctv8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764630422; c=relaxed/simple;
	bh=XY01sgMlEArIJuk9rpTZJ/Y+ywn3y2diYqlaIHBnXks=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=YeraC67nD5i2fLmoNvCeD2vHu/2kv4FyBeActZYtRS6BwUTxq1v1UmcVIIHlLDRKhMNudQP6P7raa5j2baObxi4m9X99HzlkF3zDpUgRxoeotoh/ZlJQNEeQ+19QOweSLXhtr/ld0pSWlUZtrpeePRlA59k8vQ8pY+nuscQUZ/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CkMRaXgx; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B1KPUgK014613;
	Mon, 1 Dec 2025 23:06:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=XY01sgMlEArIJuk9rpTZJ/Y+ywn3y2diYqlaIHBnXks=; b=CkMRaXgx
	WsN+X/jxUxvmJf09d+xNbnee4pi3UEAmKpnFY8zzkN+Ms5a49qSZG3dDuo+yqZ8f
	sA2opz1WGxtlypTyeAA9wC10Ttm4egF8r/+ot39ScuN9Je6iaBBAi4eZ/tZTsJTQ
	qCbXGFQC1ecnusVxFOYrGU/n0F6LS9JFdAoYXfW6DTdk0fvYmkJQjT4u+iaD2jbr
	X8hKONYf3scHgiEkfJd8Al7dXEhQXt8e7OdiShScFUJccxkGtSDJq/+Lle3nDzr/
	qdwlIXCPzz6SoR2WuQewSDaJpT9Z2/b/EEP6g3uEBXCXq8TftmCfQiF8RUMPdRvb
	ibgi0fRON+FPhA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqrj9hvk4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Dec 2025 23:06:48 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5B1N5uqG003817;
	Mon, 1 Dec 2025 23:06:47 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012039.outbound.protection.outlook.com [52.101.53.39])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqrj9hvjy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Dec 2025 23:06:47 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fVYwOTveDFfJOCwPuwqqIPb0qTG8Zf6X5CSZNV1JedtpQd4ibU7YI0SuQqLuHF2Rkw5z425LDzWIpC7gIPyHr9+pTdOob+qhCnoTBnQy6lU8G3zDvczdNPe1juyGpCj1fTLafFdYsoK4DUr7sBcaMj42POIBnVG0GIkTHyIZgwp6uU9+wsJyBzqBd5WSfWBizLr+xN8v8rbdOfWvJ3va6j952p5U95j0Uv+GbEqRFL7ikRzzQbJGe1QE6+SiAO8NiAe857s387QZhjvPR6bkJQQuRKcglcB4CWqlgNHo17FL0wvWnwRNZiRxODzV6sERgSY5mRc8oLlc9Djpfsw7QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XY01sgMlEArIJuk9rpTZJ/Y+ywn3y2diYqlaIHBnXks=;
 b=laipRR5Z/lZdJ8ceqJd0fVn1AddzJQwFfd56s/4/oAQSMUygiDrXLpq8RgrV3ZyAgR8XAjUNiEqt7ZP8Tkdn73VNmFu3gLBb78nEuzUeIcWihKSlZq+T71uiy1LDp+uqBP42WsbaoJbi5trBOhscdLkChTsEe5V2mJUNZfZQWbhATT/dYINXGJ1zjSczclSbo361muD5SPlODKHTubxU6muygTNTefsoUBmipI8z6F6jgfJMAzUdYj+EvlUoiBO4XzGG/ZFm9rpgMcxlMznXnkC97JVZfXRAiKKUq+1tiu3PORNvRuSmU7Y/4knROJBXnK2v3VEZfPV9lQhEiFDn6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by CO1PR15MB5018.namprd15.prod.outlook.com (2603:10b6:303:e9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 23:06:32 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%4]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 23:06:32 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "brauner@kernel.org" <brauner@kernel.org>,
        "glaubitz@physik.fu-berlin.de"
	<glaubitz@physik.fu-berlin.de>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>, "jack@suse.cz" <jack@suse.cz>,
        "mehdi.benhadjkhelifa@gmail.com" <mehdi.benhadjkhelifa@gmail.com>,
        "sandeen@redhat.com" <sandeen@redhat.com>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "khalid@kernel.org"
	<khalid@kernel.org>,
        "linux-kernel-mentees@lists.linuxfoundation.org"
	<linux-kernel-mentees@lists.linuxfoundation.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
        "david.hunter.linux@gmail.com" <david.hunter.linux@gmail.com>
Thread-Topic: [EXTERNAL] [PATCH v3 2/2] hfsplus: ensure sb->s_fs_info is
 always cleaned up
Thread-Index: AQHcYwmVzsPNb1uaSUO2JIm74k8DqrUNaC+A
Date: Mon, 1 Dec 2025 23:06:32 +0000
Message-ID: <6e47c8e1ad26527da4e8a2c287ee035c6f00d773.camel@ibm.com>
References: <20251201222843.82310-1-mehdi.benhadjkhelifa@gmail.com>
	 <20251201222843.82310-3-mehdi.benhadjkhelifa@gmail.com>
In-Reply-To: <20251201222843.82310-3-mehdi.benhadjkhelifa@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|CO1PR15MB5018:EE_
x-ms-office365-filtering-correlation-id: 9c75ddcd-4136-4dd7-aa6d-08de312e44c6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|1800799024|7416014|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?VWJLanhhczBjTGZzcUFkQklnajZYalVSTW1YZ1FHeFRJUEtVdTRiRW5MRGhv?=
 =?utf-8?B?bDVZWjRNK1g4TlpZekQ1NWgyTmxIVE13MTA1UWdlZFhFcnhrazdOVlJock90?=
 =?utf-8?B?VnlLWnU5LzVXMjdGc2pUTUhoSXpBUU9Vd1UvcFpCVWUvMUN3Y2dDN0V4dDdq?=
 =?utf-8?B?Lzk0b0R0ak1HUzlXMU5IbkdWcC9aQ09pTFZTcFVXSzVjb3hYeVdRNjRNdG9t?=
 =?utf-8?B?a2ZDYk1kZFQ2UHBJVldBUXI3WTZPTmpCYy9xYzE0SnlER3BHRWxIWDY4Vi9Y?=
 =?utf-8?B?RGdGSW1HQ0R3NjRBU2RZNDZadi9GSi9NdEpCcHJBbGs3SHJ1VEFhanFVYkZx?=
 =?utf-8?B?ZnRrL2Y3aXNIbVBwNEkvZDlDTmszTE5FYXRQNkRwOEJHWlpMYiswTGltdjgx?=
 =?utf-8?B?ZlhwU2tkbnJ6V2tKZVAvM1IyNXlxeGpXa1pnT1NyZlhOV2hwc0xFelA1VkNi?=
 =?utf-8?B?M0U2Q05MdXJoNTFLZy9iSHc3OGs3UHNHK0xJbTdBWFRESlhZNmVTM2J3b2hL?=
 =?utf-8?B?cjJtalQyZFRBRFZjNnlNUERYTVVwdWlVWjZKRFF6ckF5c0tENnRzKzEzczV2?=
 =?utf-8?B?b1ZHangvUXJqSG43MjVsd1lVTERCVzNqY0h3a1ZZSUZ0cDFETEYvSmtCVGs1?=
 =?utf-8?B?U0N2cjJZYVB4c2R4VmQ2dnJ0ZGRUcXhsNDA1SERnMUNOWmxGRURYVDYwbWtQ?=
 =?utf-8?B?bHdPQXp5Mkt5aFNYTTlrcm90WGxpODRHUkV2TVFKZjk5T1pJTTVJbFBiekVX?=
 =?utf-8?B?c1JkMWsvTjBVUnZTYVJsaE9kUmhTZlpZeS9ORTRVMi93UXRQanBEcVlHemZS?=
 =?utf-8?B?cGwrL3VsMkpXVElCNW12aWVXb3p2WW9tcHRXMHJGUUxtUmtFZGwrL3Fwalg0?=
 =?utf-8?B?ZFcxak5WblZSQU41VnROSkNMbUxHUjc3UDZBMnEvMzJBMllJSHVadnlONmJP?=
 =?utf-8?B?QlVJYVloUEFnMGl6NWFvSUpnTjNuekhhRW5scitIbUJhTXlqZDhwTFAxS0Za?=
 =?utf-8?B?WXVFS0JhZE9HbUVUZGM1N05iSzNpQ1dxSHNKM2d5aS9RVEFXa1lac2hWMUpk?=
 =?utf-8?B?THpRUHNIWHcvVnhxZEhYS1ROMDhPcGMxL3RPQktGZmpaWGVCdjBOL3R4SktG?=
 =?utf-8?B?L1VJcHl3dTBSVVpMNzQrMEpTTVhybzhmWHROYWs2M1E3aW1JOFFJODNLZDAy?=
 =?utf-8?B?ak1tUkxSZnArWUxRQ3YvNDhLTlRudUp1cjk4VzJrLzExTEh4WFZRZDY3dDgy?=
 =?utf-8?B?eUMyTWMraDN4RS8vdkVPdjBFZkNLVkNGVmg5dUhjb1E3N2hDVFkxL01rbUxK?=
 =?utf-8?B?UzJkR0RhMWRTbFRVUVJYdmZ4TWlIcEVVazgzWnptZjByT2dqdFhZNVFVQjI5?=
 =?utf-8?B?NHJVTFd5dzRxNVplcE1zT2pCdzVIa1FIdk90QjNaQjhVeEdCL3J6RzkwY2pE?=
 =?utf-8?B?cGloWVUrUlloTS9MdUJ4YXV6UjFYcFFVSkdBdUZGWjh1UkduZ09tSEt2K3Rk?=
 =?utf-8?B?S0YvZlBRUXlBdVV5MWJJTjQ0WHVmL09DZHI3b0IwTmEyTXU1NlBsUG9XWDV0?=
 =?utf-8?B?Z1FBTmFsOGcxWkRyUTJmWFdRdWJiSjg1anhraTJ3anVOelNyNUVUcncvVzZm?=
 =?utf-8?B?MUJrTlQzdm4rMi9QWXNmeVVIMWtrajNwWUlhT1NjV0FLc1NjNjR4WXMxUEZV?=
 =?utf-8?B?M1orUFcrOXovUW50WTVwY04yb0svelIyVTZ3NlFOUHRLTW53OTRhaWNvY2RJ?=
 =?utf-8?B?ajlDK2drTUVpWUFtSGZqUDRiMnhKbWx5ZjBrUlVabStNS0RlemtnQmxhQVVq?=
 =?utf-8?B?VTNOdUloRTI0bW1WeGpDRW0zaUkvYnA2dVpIdlJiM1FsK1N2WTdPSGE0UEFT?=
 =?utf-8?B?OXJJcmlreHlMYVlwdW9xTGdwZzNQQ1YxeDRWcFlsZUJFdG9McGI0aHM0WTlL?=
 =?utf-8?B?akN1V3hYbnBrM211N2ZyeDhCNXZMZGsraU0xOEZHckpIMUppRlVkWFBLWFZW?=
 =?utf-8?B?OWdDZTdxN2NBcXVwRmZHcjEvb21ka1hmcGxTSEYvYndHMGRJUTNoVzhBMW1s?=
 =?utf-8?Q?BrkfND?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(7416014)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ajBCQUYvVjJaeFdQK1FDUis2UndHdzhZMlFBVlhCMis2YzVjNHRrWHhlR3Qy?=
 =?utf-8?B?UmY3dXF6NFlZZTVNZXhkOTQyVVFvdUNPSyt5QW5vU2xwQ3BRQ2hrVnM0dHo5?=
 =?utf-8?B?STg1UlJjWERyNjlhbU91ZUhrMWtDMjBLOCtUZmlqYjRlakIrWTNaUUkxS28x?=
 =?utf-8?B?dHBFQWFNSXZMMEZORVZBUzVQTVMwZCs3bk84dGhKdnAyS3BHc1JHcHVuNmpH?=
 =?utf-8?B?SHM0bTkwVWg2NjU1S216UHd5bWRLZWc0c3hma0RoZXN3RmhIajRHemtMWTdM?=
 =?utf-8?B?TmkvajVBektqUHNSUXV5TU1jMjhDSEpvN25Zc1dXTUhvdmZrang4TSs2UlVJ?=
 =?utf-8?B?SGJ3UGlZVGtLY0tnN1hxS2gvVEdyellYalVZWnhNTWRFMmN4MEdZc2oxU09Y?=
 =?utf-8?B?UitsTHY3R1g1MDVwQVdFYzJlcUtUbkFqdEt0MUY3NllHTGhPYjFzNVdiNzdJ?=
 =?utf-8?B?clhMMmpBNGJPZXFnOUtxeDBqcm1ZODJPT3dsZmFpSXVyQXlnR0l5cldQUEU4?=
 =?utf-8?B?eCsvRDRvUFNYN3owRTkwRFh0YVA1SjJFdkFQS250S0tMTDRDNVBSQyswQjdx?=
 =?utf-8?B?RFRHTm9XQklyc0xYOWZCVTNvcWtVZzdHRUppV2ZMbjliS3NjYjM5OFp2MUF3?=
 =?utf-8?B?YldBUVNrOG9wWXpwOGNKcm96VHJ6QnhtWTBYWXRKZ0FQK0dSamtDVmNUeVZp?=
 =?utf-8?B?TkxiSlVWRG9BYmRjVDdOSSsvUDdPakh5RmROcVphOWQ1MFMrOHhwNHpsSW41?=
 =?utf-8?B?bFZVMlQrbjUyQS9PTnlOQllHTXppZElmSFVkei9jVlBzMEYrcUlHOVQ3aEg3?=
 =?utf-8?B?T2xBMzFZb2tWUHR1dkpVUkNMSElJL2Q0c1l2SnpSckkxc1NXV3FRSjF1Y1Q5?=
 =?utf-8?B?R1pNc0Y2Z2ZtU2dmSk84dFdTUnJNa3QyK0RhYXFQMXdvb2JQQ2pvT3Q0b0Zs?=
 =?utf-8?B?T3k0SDRTK2FGN3FpdUI0V1NaVXJKRzJqbTUrRXdMVHZDam8ySXYzUmEzaURo?=
 =?utf-8?B?NlpRaGQ4ODVZTEhDRHB5MUpZQVlveGtLQkY4cDhNNk16Nyt0TmM3ZWZmUnlt?=
 =?utf-8?B?S0hCdTNOTVdFUUFyK0lRdXZ3VUt0RGVwZnRzbVRYVm8xMDU5RmxKTllweXhY?=
 =?utf-8?B?VUR2bkM3Qm5nN1lTWVhHWGVHRTV5SWhWSjR3WTF3MStETzVIN2dTamd3a2FD?=
 =?utf-8?B?WVVvaWZGc1pjQkpoVkhzZ3ZpeFVMdzRJQ0hoLzNyMFc4NE4vMlpnMHhIM0N4?=
 =?utf-8?B?TnVNT1lqUG84L0ZOalRxQnV1Qzhpbi8zNzBpZDJSd1gvbDNJSlBxSVJGVTd2?=
 =?utf-8?B?U0pYQVRsOC9tWDVFZmpLQ2FRK3I2RlMrZ3NDOGRlTmwzM1NoSmtSOGtMZWZU?=
 =?utf-8?B?dm56ZTVTMERDc3BDL1FFQk14dDlkY1lXT3J0dG95KzFjQkZwbyt4VlhEVHVT?=
 =?utf-8?B?V1htVTVmY0JXT0pnekkrYms5Q29LQTBUbEY3Vnc3VjlzeFpnRkNaZmUwMDJC?=
 =?utf-8?B?VkxJeVNBTGFmTmFRZDhkSmRnYlluTitKZHZMc1JOS3JKcjQxQXkrc3YwRnRy?=
 =?utf-8?B?ZXBvQW02YUxYc0hsalVFMzhiVXYya0dKa3JjbUxVeHVaWjQzOVRpcDNhano3?=
 =?utf-8?B?VnZSRHVxUXNoZGRJWVFvdlo3a0hYeUZJRWdiaHlZVmFEVlhKT2s5eW45b1I2?=
 =?utf-8?B?RXBNQ2VnS1FEQ0RzVnIyUzZHSlYrM0FtTGwyQVRqUGhjN0xxZlNxSlBCRVBQ?=
 =?utf-8?B?ZUtwMGRmOHZuSVJEQ3ZXR2ZWNUtMNFI5Ynh0WWh3ck1RcStGZWpRZ1c5Z09h?=
 =?utf-8?B?MjhuMXdmbk1hUzZJdUYzd1RJUHBUMVoxb2cyQ09TejhlZHBuMUR5b0pDYndu?=
 =?utf-8?B?M3hLSm52eEJ3S1BNbU9WQVJCTHRidDlrTnV3aWZaZ1dSU3RIYnpMeTFTek5C?=
 =?utf-8?B?YzM3NWpOLzBMbHF2aTVQMUhtOFc3cm5JS1pXSUtaT0lIajUzNUpJekI3Nkxu?=
 =?utf-8?B?bWdLR3d1YzkrblY2R3h5S2dzRTA3MTk2ZU4zdzk5NW5UZjM5Wi9JR3pOckMv?=
 =?utf-8?B?OEYzT3pXN2dyeGIvaVVqUkp4SDh1d0R0REZlNHppUElwTkVKTEcwUjZIamE3?=
 =?utf-8?B?OVpRTjRMVXpqNFZjTDZuVjlnSkJPaTFNSTJHRW1haWx1MUpHSjA2NjE2SytT?=
 =?utf-8?Q?3vPTfSjppchlDH28YxFo8Oo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2BEA394646B96C48B1E41A7B2C837DFA@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c75ddcd-4136-4dd7-aa6d-08de312e44c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2025 23:06:32.4751
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 789GkBP0V0RAbGK/6iXmSmrxA9Q9M7Qzzc2e7jNfGd3FCZ625so3FzlIPeEpsJS/XjXtA6qWOKGzYdAWnUE5Bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR15MB5018
X-Proofpoint-GUID: X3J5u8fAEUNtD_FvVEIPXOjOSoBq2oky
X-Proofpoint-ORIG-GUID: Rq5XLab0RjjplCei8LP_vwR_8paDOTkn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI5MDAyMCBTYWx0ZWRfX+xBVd9FTq6Tg
 Tu9BBv/onlC8QYgHkaW08uuO5YGDtS4LTqqJdsnkL/fgikuPNTS/iOKRVnsYz8NmIN2ErB72HtB
 7To0LY6L9X6yhTwaBwlyGrSGHXJJt4oRi5T7mUql1gaphmTrsACe2RnuqpIhSm6jsgNXZMIkqp3
 ONIrj/9eHkaXYydOcerN8PI1P2vIrh3FtKSAQ1FJBNDk1zjzN9D7Fm2nh1DMMXtzziPPqaEXIva
 ypddAEo0GXma0ymKFnkXieOWZXIT3yzgovvmYytIPgIFqgw/fC2ta/vTZrGidhDkHSqWgLwNMhC
 3seIFTPRXnOhboMiQ8WrpZAklZUJyZv0yE0ayCWFJuKvyzOleOlEBls30UF+iTNP09jBwrTk5rt
 Tml36XUwP7X0R3W4Os5t+1FvQmwadA==
X-Authority-Analysis: v=2.4 cv=dYGNHHXe c=1 sm=1 tr=0 ts=692e1f88 cx=c_pps
 a=xAd66yR1laZozgwquCAwlw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=pGLkceISAAAA:8 a=wCmvBT1CAAAA:8 a=NTMD013UPlbqWiUSGOwA:9 a=QEXdDO2ut3YA:10
 a=6z96SAwNL0f8klobD5od:22
Subject: Re:  [PATCH v3 2/2] hfsplus: ensure sb->s_fs_info is always cleaned
 up
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-28_08,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 suspectscore=0 clxscore=1011 adultscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511290020

T24gTW9uLCAyMDI1LTEyLTAxIGF0IDIzOjIzICswMTAwLCBNZWhkaSBCZW4gSGFkaiBLaGVsaWZh
IHdyb3RlOg0KPiBXaGVuIGhmc3BsdXMgd2FzIGNvbnZlcnRlZCB0byB0aGUgbmV3IG1vdW50IGFw
aSBhIGJ1ZyB3YXMgaW50cm9kdWNlZCBieQ0KPiBjaGFuZ2luZyB0aGUgYWxsb2NhdGlvbiBwYXR0
ZXJuIG9mIHNiLT5zX2ZzX2luZm8uIElmIHNldHVwX2JkZXZfc3VwZXIoKQ0KPiBmYWlscyBhZnRl
ciBhIG5ldyBzdXBlcmJsb2NrIGhhcyBiZWVuIGFsbG9jYXRlZCBieSBzZ2V0X2ZjKCksIGJ1dCBi
ZWZvcmUNCj4gaGZzcGx1c19maWxsX3N1cGVyKCkgdGFrZXMgb3duZXJzaGlwIG9mIHRoZSBmaWxl
c3lzdGVtLXNwZWNpZmljIHNfZnNfaW5mbw0KPiBkYXRhIGl0IHdhcyBsZWFrZWQuDQo+IA0KPiBG
aXggdGhpcyBieSBmcmVlaW5nIHNiLT5zX2ZzX2luZm8gaW4gaGZzcGx1c19raWxsX3N1cGVyKCku
DQo+IA0KPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiBGaXhlczogNDMyZjdjNzhjYjAw
ICgiaGZzcGx1czogY29udmVydCBoZnNwbHVzIHRvIHVzZSB0aGUgbmV3IG1vdW50IGFwaSIpDQo+
IFJlcG9ydGVkLWJ5OiBWaWFjaGVzbGF2IER1YmV5a28gPFNsYXZhLkR1YmV5a29AaWJtLmNvbT4g
DQo+IFRlc3RlZC1ieTogVmlhY2hlc2xhdiBEdWJleWtvIDxTbGF2YS5EdWJleWtvQGlibS5jb20+
DQo+IFNpZ25lZC1vZmYtYnk6IENocmlzdGlhbiBCcmF1bmVyIDxicmF1bmVyQGtlcm5lbC5vcmc+
DQo+IFNpZ25lZC1vZmYtYnk6IE1laGRpIEJlbiBIYWRqIEtoZWxpZmEgPG1laGRpLmJlbmhhZGpr
aGVsaWZhQGdtYWlsLmNvbT4NCj4gLS0tDQo+ICBmcy9oZnNwbHVzL3N1cGVyLmMgfCAxMyArKysr
KysrKystLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9u
cygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2ZzL2hmc3BsdXMvc3VwZXIuYyBiL2ZzL2hmc3BsdXMv
c3VwZXIuYw0KPiBpbmRleCAxNmJjNGFiYzY3ZTAuLjg3MzQ1MjBmNjQxOSAxMDA2NDQNCj4gLS0t
IGEvZnMvaGZzcGx1cy9zdXBlci5jDQo+ICsrKyBiL2ZzL2hmc3BsdXMvc3VwZXIuYw0KPiBAQCAt
MzI4LDggKzMyOCw2IEBAIHN0YXRpYyB2b2lkIGhmc3BsdXNfcHV0X3N1cGVyKHN0cnVjdCBzdXBl
cl9ibG9jayAqc2IpDQo+ICAJaGZzX2J0cmVlX2Nsb3NlKHNiaS0+ZXh0X3RyZWUpOw0KPiAgCWtm
cmVlKHNiaS0+c192aGRyX2J1Zik7DQo+ICAJa2ZyZWUoc2JpLT5zX2JhY2t1cF92aGRyX2J1Zik7
DQo+IC0JY2FsbF9yY3UoJnNiaS0+cmN1LCBkZWxheWVkX2ZyZWUpOw0KPiAtDQo+ICAJaGZzX2Ri
ZygiZmluaXNoZWRcbiIpOw0KPiAgfQ0KPiAgDQo+IEBAIC02MjksNyArNjI3LDYgQEAgc3RhdGlj
IGludCBoZnNwbHVzX2ZpbGxfc3VwZXIoc3RydWN0IHN1cGVyX2Jsb2NrICpzYiwgc3RydWN0IGZz
X2NvbnRleHQgKmZjKQ0KPiAgb3V0X3VubG9hZF9ubHM6DQo+ICAJdW5sb2FkX25scyhzYmktPm5s
cyk7DQo+ICAJdW5sb2FkX25scyhubHMpOw0KPiAtCWtmcmVlKHNiaSk7DQo+ICAJcmV0dXJuIGVy
cjsNCj4gIH0NCj4gIA0KPiBAQCAtNjg4LDEwICs2ODUsMTggQEAgc3RhdGljIGludCBoZnNwbHVz
X2luaXRfZnNfY29udGV4dChzdHJ1Y3QgZnNfY29udGV4dCAqZmMpDQo+ICAJcmV0dXJuIDA7DQo+
ICB9DQo+ICANCj4gK3N0YXRpYyB2b2lkIGhmc3BsdXNfa2lsbF9zdXBlcihzdHJ1Y3Qgc3VwZXJf
YmxvY2sgKnNiKQ0KPiArew0KPiArCXN0cnVjdCBoZnNwbHVzX3NiX2luZm8gKnNiaSA9IEhGU1BM
VVNfU0Ioc2IpOw0KPiArDQo+ICsJa2lsbF9ibG9ja19zdXBlcihzYik7DQo+ICsJY2FsbF9yY3Uo
JnNiaS0+cmN1LCBkZWxheWVkX2ZyZWUpOw0KPiArfQ0KPiArDQo+ICBzdGF0aWMgc3RydWN0IGZp
bGVfc3lzdGVtX3R5cGUgaGZzcGx1c19mc190eXBlID0gew0KPiAgCS5vd25lcgkJPSBUSElTX01P
RFVMRSwNCj4gIAkubmFtZQkJPSAiaGZzcGx1cyIsDQo+IC0JLmtpbGxfc2IJPSBraWxsX2Jsb2Nr
X3N1cGVyLA0KPiArCS5raWxsX3NiCT0gaGZzcGx1c19raWxsX3N1cGVyLA0KPiAgCS5mc19mbGFn
cwk9IEZTX1JFUVVJUkVTX0RFViwNCj4gIAkuaW5pdF9mc19jb250ZXh0ID0gaGZzcGx1c19pbml0
X2ZzX2NvbnRleHQsDQo+ICB9Ow0KDQpMb29rcyBnb29kLiBUaGFua3MgYSBsb3QgZm9yIHRoZSBm
aXguDQoNClJldmlld2VkLWJ5OiBWaWFjaGVzbGF2IER1YmV5a28gPHNsYXZhQGR1YmV5a28uY29t
Pg0KDQpUaGFua3MsDQpTbGF2YS4NCg==

