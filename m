Return-Path: <linux-fsdevel+bounces-55973-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEAC2B111FC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 22:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D1761C23BD5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 20:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228EF239581;
	Thu, 24 Jul 2025 20:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="frZIPqiU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF00C1F4701
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Jul 2025 20:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753387593; cv=fail; b=YObBkEQ2FFcFKz92iOdrJavtbfTGj4yVyPttPd0agsqvfNWrG+A716BZvq6R/UCt+IB1iVKuYZOi3MyG2OZla8pwh2LcpavilHxwy1TeJrOpmEH5t8ZFGMqJP+nSy7hLcZt7DNEX6VNzmLtHBIKtYWrfQrtbcx1VX3SEz9kX5iY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753387593; c=relaxed/simple;
	bh=s+QxaukGKaEMB55swxD+FtQqtIzfyswgDsHs5h1R5Y8=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=kvXohjFIMdMuh8eHOV0UlJpwOBIbpUiT3g2Fdfc60ocH2yQZZ/veN4gDG+ET67bjrEaHl3k55V3ZjhZKKedIZnh+akbdV4Mxs4dF/sQP5QAZVUL++uskBM71oVn5NiX1PerNLkNFQYl+0k2EUUoQr2R6PA7lqZXuPc/bRg/jOIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=frZIPqiU; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56OD01kC004417
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Jul 2025 20:06:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=ghjYCcoi70a3DT/GPTNXgHY+d5i1oC4W4b8jAW86eew=; b=frZIPqiU
	f2/wrDtddjgEnYmsagjV7uhNxVvMLpq+Gio5KY8yu3yOxoVzsVg3uqgQ0RE8aemY
	k33cUiGhsXtWeMqOpoxVO+PM7ZWMfnBRPNqjlsFmugRxaUn+67pTPZYdWi3FetXO
	yINd7qbsgMai7e1zSRTDmHbGBa0a9FtcURS2BR9oN5/c1udwXwOQp973evIChmPm
	P0HTusprE9cN5/egHH3L66o6kDm4UGvAiaUlb84Jd4nm+3U+mrjMoyBOesRH3DUL
	/sDV/mfyTb8YVJNnFBCJwY2cvmTewvxzpqOle6ZR5q0CoVs99uUWlESM6li0llHW
	m83KLVdBUZkoFw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 482ff5551f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Jul 2025 20:06:24 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 56OK4aoW002030
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Jul 2025 20:06:24 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 482ff55519-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Jul 2025 20:06:23 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 56OK6N59005622;
	Thu, 24 Jul 2025 20:06:23 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 482ff55515-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Jul 2025 20:06:23 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tSu88rn1WSMNOcMRLp1cKzImPf1r8FsQ8MPZDbjKu630+FLf+YeO0q++49OeNwjwFPk8vrOzpC7Ud9DnjroslhHdgcMBaRJt6UouE86411f3esYbXVgdE3OPtFvJ6bfA1Id5oqD794gUgnvoOTupFh524mSbx45BWQ9pWfGvmqpVzfT2CCYpjwrZ4xoPQqb8JoHTyCOlSQdqdTjyFoq6C7dmG65qU++EzdHh37O3Vbhr/ONr132DeVzmTc+lURLnqIkEV23AcploEyXSE5w6DIGS9Pev+ti6YB4qK8noiqS/DhVBQLAS7ga0GML6CogQAneUD6SbRBmp0i72iJWAdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C7l9flnhiNIg1i8wPt4FbmDnD4ipJkIFXzcjHkd7f74=;
 b=klaWYkf1HhFB6kLorEH8a6ygOoCXa9c29wOdGHI0KBD5g5Dro0Wg/R689PgFJlsmrwP4MC0FpVwbJUFMEAW5y0zJMnKpGCKWhAVG0BUfRAVUDMeYt04Fuhgq4Gc2NTcb3Zt/wB41lDKE0yUrQarjwZPELfk471zIHxV1BHfveAaum1rHBTsIzDLgIqah1DgrtNN9e2sNnTyBQ0LZkYQkNFe1gx3HQVXZESnqWkGSfX9cliS6Z737Pr0meO2l8X7WYS7DjB6dlC2pRBrb//l45Txl0so6Pqp9PrYJCAM/DHCwWBbmDPdHFdIVNaS6GYF2rXPGQnmujzSFDDjXl/421w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SJ0PR15MB5821.namprd15.prod.outlook.com (2603:10b6:a03:4e4::8)
 by SJ2PR15MB5645.namprd15.prod.outlook.com (2603:10b6:a03:4cd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Thu, 24 Jul
 2025 20:06:20 +0000
Received: from SJ0PR15MB5821.namprd15.prod.outlook.com
 ([fe80::266c:f4fd:cac5:f611]) by SJ0PR15MB5821.namprd15.prod.outlook.com
 ([fe80::266c:f4fd:cac5:f611%4]) with mapi id 15.20.8880.030; Thu, 24 Jul 2025
 20:06:20 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "syzbot+41ba9c82bce8d7101765@syzkaller.appspotmail.com"
	<syzbot+41ba9c82bce8d7101765@syzkaller.appspotmail.com>,
        "eadavis@qq.com"
	<eadavis@qq.com>
CC: "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "glaubitz@physik.fu-berlin.de"
	<glaubitz@physik.fu-berlin.de>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "slava@dubeyko.com" <slava@dubeyko.com>
Thread-Topic: [EXTERNAL] [PATCH] hfs: Prevent the use of bnodes without
 entries
Thread-Index: AQHb/K4UfpflhoUCl0GMNs1yVkAMfbRBs3qA
Date: Thu, 24 Jul 2025 20:06:20 +0000
Message-ID: <0ead1ebdbbecc1802e3ffed0867ba6a2c567e415.camel@ibm.com>
References: <68811963.050a0220.248954.0005.GAE@google.com>
	 <tencent_DFFF86C192DEC64EC99B6EF96EDE4C986706@qq.com>
In-Reply-To: <tencent_DFFF86C192DEC64EC99B6EF96EDE4C986706@qq.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR15MB5821:EE_|SJ2PR15MB5645:EE_
x-ms-office365-filtering-correlation-id: 3988be5f-59fb-4b2f-53e3-08ddcaed8e90
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|38070700018|7053199007;
x-microsoft-antispam-message-info:
 =?utf-8?B?UDZlR2tmRHozZlNxRkZRR2h0Mm5ETlE4dkU4NSticHBNa0h0MmpScHl2VDNO?=
 =?utf-8?B?RmEzY3BmbHVKQUNTSVY0cGwvYmp6eXFIZVB2THpQSkFHYnNDczVQZndiYVdE?=
 =?utf-8?B?eDUzSjJ1ZkdxdllFbzRhT0VDSDNiQlFFN0hQWXJDbFhVY3A5N0U1QU5lUDR5?=
 =?utf-8?B?N2xURXNTUmZiVDhUWFpDcGhqRDdod3VuRE00d3djRzdIcXpMaHUvaFAydnVH?=
 =?utf-8?B?KzQvaFFSdTZUVTJ1ZTFLZkM2bnZJaU5Xa2t4R3FabTJCK0J3R0lmUDl4bVNC?=
 =?utf-8?B?SzFJZ2diaFVMZnMrMlhuRXhPUXFyenpzRWtpVmJTdXAwcE5ZaDRrNDl0YlIz?=
 =?utf-8?B?clNYdmY3eTdLS1lQdUg1QnJkdm1OTmlsbTVlbXJQOVFHU3dGMlVDY1FUTVMy?=
 =?utf-8?B?eWRTa29lRFlxVHNjZEp5KyszZnMxV3pZdExwSjNZVjZQeklpSlhKTHNRckF3?=
 =?utf-8?B?NzZLMWU0M0tDTGZ3aXRZcU44azdBRithRjRyQ3Jjc0RiWHE0QjM4WjZ2Wkxw?=
 =?utf-8?B?c0xlZzlBS0JPV2xOWTdnc0p6bC9OWDVoQmZMM3pqWkJaTlIvc0I1cVg4b0dT?=
 =?utf-8?B?T1M4N055TkFUaUZOZ2lQY21WWDNGMkp3RWMxZHAyS1FnZU5IQ3dMY0orNXJi?=
 =?utf-8?B?Njl4NEFDVDZ4WGpzS2Y4a1htU1IwUTlQNFh0MVNWMDBTcXRway90eG8yQ3NC?=
 =?utf-8?B?TElueUpYYkhraCtDOTVHTWlWa0ZpR3IrVHIydlpYV1dlRm1LbkVMcGlyVnRT?=
 =?utf-8?B?K1VGVjhHR3JKV3M0aFJsY1pCUUZIVzhmbG52ZlF2VFdIVURyQmwybmFMdk1Z?=
 =?utf-8?B?dU5HUXZwT3RmSmVleXZ0eDliVVhSNlViZ25CS3hnZ0RRcVIxRzIwaVhQREg2?=
 =?utf-8?B?aWZGNnZUZXRYTmZKbzRSb3hpYkhuY2dhdE14enpWRDRCYWd4N0g4MlFmeHJC?=
 =?utf-8?B?eHdwMldkd3hobXVWdU9rN1hrbGV4VUwwVk05eUxlSElpbWFVS1dGWmc1eWND?=
 =?utf-8?B?R3hiVWhNZkFEVTdOT3g3MGt2SHBaazBMaEM0RDBsQnpmbUlCbFIxSDI2cjVt?=
 =?utf-8?B?VnFJblBVN2p0YXlEVC9VYUgwTXkyVWFJRkUvNVduL2EzblVtWStWNnBnTUJs?=
 =?utf-8?B?TDhaRDZZTDRLd0hqdXpmU25vV1kxMDBsSE54b0U1T2F0ZFRCMVlnNHFDeXU1?=
 =?utf-8?B?QTJzZFVGbGN4VGJUWjJMeFRuOXJneFp2QUZsbDFBem1HQUpjMGV4T0tSTUxJ?=
 =?utf-8?B?YTZRZ3c0MnFlMm9yZGVneXZsK09xQW5WS3hLa2FqR1gxT3FFb0JoaWpnc0pT?=
 =?utf-8?B?SWptTGNzbjdWNUdvYVJHbUxabjZHM1NXeUl4VmhTeGQzNzE4a1N5QzFBM0hR?=
 =?utf-8?B?UVVnVHpRYlM2d0dQdDdTejR1WHRVSE5Mc3dFd0VyOU1WVEdYU0xqMWM1dmlj?=
 =?utf-8?B?Wmc0QVpQS3JJWEpPL1JOTVQ4aWo0Um9uV2NxWHFlUXo5RW1XRDBXc3h0YXA4?=
 =?utf-8?B?UzBaQUlpY3FRWFlCQ1pSUUROR1daNnJMV3ZzMUd0aHAwZ0JXYlhuMHh2VjJr?=
 =?utf-8?B?SlErTCtXZm1yREczSlR1ek41V3o2eDc4cEdEQ3NyODFVYkl5bU5aTzQ2UW9B?=
 =?utf-8?B?QzFvVHZEd3ZWK3YyM1N6bmlRZWRJVWQ1SnZBZVpRVFltamVJWUR5MXhMTVNx?=
 =?utf-8?B?THZiQWg2MW9DczhSL29iUG9JNUJ1Q282MDRIb055a0NzUEh3c2FLYzhDaUl1?=
 =?utf-8?B?OEtjQTh4K0E0dzFlTndMZlR6elk3aFNjNzduMmUyeFFIenFwYmFHTERDL0s5?=
 =?utf-8?B?Z1lQMllubmovYk1EQ0ZqUVE4WnU1c0lxMmlGVjF5SnZ2cUdDVGJoK3pIN2FC?=
 =?utf-8?B?cUlVdm4wZG1hcUNOSUVJQzJUN2JSOW90YWdnWGdCOGQ0RUJMSlBhZi9iN2dE?=
 =?utf-8?Q?Nxd36xN4yOo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5821.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Qm1kN21BQjZweUd5SVgySDEveGY5eVl0TWxyR0xqL2xyZ2c1cmNCS04rQ3Yr?=
 =?utf-8?B?bWtNODVEV2lJdUZmVCtBK3RZOEgxSVlIdVJiSVg2aWxjaW1IRk0wbFdNb0JW?=
 =?utf-8?B?STB4VEx1eHg3TFBXM1NBM09ZMUMzNFRlVHdCZ0RmWlEydTE1UnlyMXBuMFp2?=
 =?utf-8?B?S2g1ZTdGa1FDTVRnZnFLWG5JYlQ5T0NVa2NHTDhxY3dxM3crL0NCS3dhd2N1?=
 =?utf-8?B?V1F1dC9IMUtBTmtyWmJkOExjcEJEc2N0UXhJQ2ZWaFVTb1BoMStlL201cGtJ?=
 =?utf-8?B?Q2hIK2JRU3VYSzY1Mm9vV3ovdFZZdVU1VEJDRjl6WXBRRkZZYkVBNXdKc1I2?=
 =?utf-8?B?ZmtGYzRQR1RGbENodGpXTGhhM0tGcWtBWVNsWDcrTWRqejZmWTU1OVczbG1t?=
 =?utf-8?B?eElHbTN3dG1nZFg2Sjh1Tk1Tc25DNWZHSTkzbS9NK1V1UGxaMk5PTXpmRXZR?=
 =?utf-8?B?c2lrNlp5WUkzd25zd3FkWlFxeFo5ZDh2bU9uaGtBa2R5Z0dvTGF3TDYzb20w?=
 =?utf-8?B?TWZEckZVbFNIemVkc0tncTNPQ0V3Zm9WK3pxZkptazU1WVg0WGd2TGg4Uk1Q?=
 =?utf-8?B?WkNhbmFMNGUzY2Nidjd3MmE3SGFoTGhLdEVrby9PM0V3d3hGaGdpVnhVWVYr?=
 =?utf-8?B?clNtRlJNNnE0RUt0cHI0MzVhdW93U0xRMXhERUFvVVZvVDJIbnRpN0tzTEJu?=
 =?utf-8?B?Y05VVTRBM1FuRW1MTW5WTTZ4bWRRZkRhYkdYa0M0c21NeDl0R1orcXBYS1lI?=
 =?utf-8?B?SE9ac2tHa1Vzd2R3YTJMT1VrMktQbDBnYXpUNWNFOG5HOHd0c1RnZmxOT1Z0?=
 =?utf-8?B?SjBtUXhtb1ZMZTFRTmJxeENzaTFYSG8zWFYwd3RHWDJoblFZeUE3eVBsVjc2?=
 =?utf-8?B?YUJOVWRoMk5LdnpuUWFTVWJCOTk2S21xb2RQTVNBMk90YlJ6QlJCT0UxbWty?=
 =?utf-8?B?V2RpOWJIMlJ4Vis3OXVxRlJxMHY1c0MzSTY5cEpWaENWL3M0ZUxKMG80QTdT?=
 =?utf-8?B?TXR2MVVnU1dUOVdlWVNsUDFaK0Z0cTNTUm5FbUtrY20yRXlwZDRtRngrTVRk?=
 =?utf-8?B?U2VMZGdJZ2FzOHJGc25qUmhzYlNmMjlDTUVPS2s4Tm5wSW5QVTNoa3dJTDNH?=
 =?utf-8?B?eXRvN2gzNUNpVEVHaGJYc0xJZWJDWUdxRDB6S29PZ1o0TitibEVKY1ZnZ3JI?=
 =?utf-8?B?MzdvV0ZQMjU2UG9Cd3laYWFsdWtPSG5ZbzJvWVVSOWRHclR2YVJGbkVtVHFN?=
 =?utf-8?B?K1pGK3l0Q0hjRStkbkdwWm42UEwwb0wwTmZiTjBpNmVyTm82ejRUazY5Z0lC?=
 =?utf-8?B?aUxTR0hGWXU2eG0yekZTbVk1NkcwZmZ5cGRnMEh3QXRhSkplVVExLzhnQkRo?=
 =?utf-8?B?ak15WFBBaVJac0ZPK3Z3Ym9YYmlVQXU3M1QzcHV0VTBNWTh1c0ZIVDgwa1k2?=
 =?utf-8?B?U0V3T3pWb3pMaTgrYkF0M1hDMU9TU2ZqOE8vRkJRY21MT3J6OHRwc0UrbW10?=
 =?utf-8?B?Mk5kY25aS3hoOWl1SnpVTi9yUXJHaGptdTJpdURSUGEyTnRJY3pNVXNXeTFT?=
 =?utf-8?B?dlBNTHQ5eDZtbUt6czhjWEUwQ2tmdXR0Vis2NFBGQnplQzVPNCtaSlAyRyt5?=
 =?utf-8?B?M21iM3JITEg4cnhYNXc2ZGM3eHEwc1Q5SnZDbTFTQ2xVU0FVaFp2bW4vT1A2?=
 =?utf-8?B?aElSK3A3d2FkY0E1bXdWczhNM1NEM2ZtNUNST2ZPbkROaWNnMWgvTVk5TnBu?=
 =?utf-8?B?RkpGVFg2ZUNMbTVQaXdWdkxCRnp5QzZTckRGd3hHZEpEQ0ZUbmVhN21mM25N?=
 =?utf-8?B?RkdaV285UENpdlFOcmRHaS9oOEdNa2gvdHY3UHk0bWNSSVQrQ0Y5UVJYZ3A0?=
 =?utf-8?B?MzgvdXZsdlVLdkVpL2pRcXdGRlR4NGpyUXc4OWx6TFVkaXNsS1ZKNkFCSldI?=
 =?utf-8?B?WHZPRnVtNzdVZkZqSW1FUTNha2R4Nkh2T3B2WFlaVHpXOGF3R2lmeGxqUVZZ?=
 =?utf-8?B?VkxBRXNkbVpodm9Ka29TWXVDV0hMVERTQW9UMlB6bWlkSThHb1hzMWhJU3Fk?=
 =?utf-8?B?MXZGclBHMzFNb0h5Nk1hODBHa0xFa0F2bVJaU0xBNUxxejVKQjFWSWhoeVcx?=
 =?utf-8?B?dVJNRmNQdHhDcy9pcjNFMUhxTnBZTlFmTVYyb29ZS0h2V0tRNU5iM0Jwc2g4?=
 =?utf-8?Q?qKSHxnBpW/weoAybplxdFQo=3D?=
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5821.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3988be5f-59fb-4b2f-53e3-08ddcaed8e90
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2025 20:06:20.4155
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gUL9q0eWKxZnsg/P/IiSybaFWLi91g3xl2/6vvdauRi4PRXfLBQTw5z+Sx1GzlNqoY0zc/Fx8PE2NkBW0zGrlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR15MB5645
X-Proofpoint-ORIG-GUID: -LDa33XlK1MiG7twbON2_0HSiVQw7w01
X-Proofpoint-GUID: gUZfxPDoDpKtaJzmQ16HQNgFyF3CF4dH
X-Authority-Analysis: v=2.4 cv=Ae2xH2XG c=1 sm=1 tr=0 ts=6882923f cx=c_pps
 p=wCmvBT1CAAAA:8 a=RjtLz+qli6Ia6ygbqnDkgw==:117
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=n15javzGqmNhUcao:21 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=edf1wS77AAAA:8 a=P-IC7800AAAA:8
 a=VwQbUJbxAAAA:8 a=hSkVLCK3AAAA:8 a=dZbOZ2KzAAAA:8 a=xM42AZ8UZk31C9XkhmIA:9
 a=QEXdDO2ut3YA:10 a=DcSpbTIhAlouE1Uv7lRv:22 a=d3PnA9EDa4IxuAV0gXij:22
 a=6z96SAwNL0f8klobD5od:22 a=cQPPKAXgyycSBL8etih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDE1MyBTYWx0ZWRfXwx6MSMBiaUYv
 FuA5WM3gBg15VCaaLN0R6yAhANzcxjSPm7DQp5pi7TKNQnop+pMtLTIrNDezXvHRsuG3MYa1m0q
 7Rhr/74CKl72STXjp6Vru7ZiMELyG+/wTyvUsmw7951hBCchOTpUGVqIfWE1fFRWKO8Go71GlQK
 1TCfFIkV9+0Eew4AUNF1e7MzTTk9YXczhkOsdSferP90o6O5+QYJEyUf5o1g/oGLCttYhMygG3/
 SGc13K169YhFJEIlpy7InwRquww1lMLEDIZM6H+XkOXKKEh8BdojMUA/b71lHWgtHrPn42M/a19
 wdwhVW3DihRZcU+qsLdt8dIUqxK/tfzO1HBGgzXkCrVP2iBiliDz9IZJp3+JfO3lEhODMHN/Cl3
 11Cp9Qi69EW53ZRNY3jQeibk4TpVPZgpb1pwsDZKcxgTUIRtVez/uRQdxp+u404vzXqxxEUY
Content-Type: text/plain; charset="utf-8"
Content-ID: <4D12CDF17EEDBF49AC4213FC38180509@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re:  [PATCH] hfs: Prevent the use of bnodes without entries
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_04,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 lowpriorityscore=0 adultscore=0 malwarescore=0 bulkscore=0
 clxscore=1011 phishscore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 spamscore=0 mlxscore=0 classifier=spam authscore=99 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=2 engine=8.19.0-2505280000
 definitions=main-2507240153

On Thu, 2025-07-24 at 23:08 +0800, Edward Adam Davis wrote:
> If the number of entries in the bnode is 0, the bnode is considered
> invalid.
>=20
> Reported-by: syzbot+41ba9c82bce8d7101765@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D41ba9c82bce8d7101765 =20
> Tested-by: syzbot+41ba9c82bce8d7101765@syzkaller.appspotmail.com
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
>  fs/hfs/bfind.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/fs/hfs/bfind.c b/fs/hfs/bfind.c
> index ef9498a6e88a..1d6f2bbafa7a 100644
> --- a/fs/hfs/bfind.c
> +++ b/fs/hfs/bfind.c
> @@ -133,6 +133,8 @@ int hfs_brec_find(struct hfs_find_data *fd)
>  			goto invalid;
>  		if (bnode->type !=3D (--height ? HFS_NODE_INDEX : HFS_NODE_LEAF))
>  			goto invalid;
> +		if (!bnode->num_recs)
> +			goto invalid;

If b-tree node hasn't records, then it doesn't mean that it's invalid. Beca=
use,
if we go into invalid way, then we show the message that node is corrupted =
[1]:

invalid:
	pr_err("inconsistency in B*Tree (%d,%d,%d,%u,%u)\n",
	       height, bnode->height, bnode->type, nidx, parent);
	res =3D -EIO;

But it is not true because the node simply has no records. It could be inva=
lid
if bnode->num_recs < 0.

Also, I've sent the patch [2] already. I believe it should fix the issue. A=
m I
wrong here?

Thanks,
Slava.

[1] https://elixir.bootlin.com/linux/v6.16-rc6/source/fs/hfs/bfind.c#L152
[2]
https://lore.kernel.org/linux-fsdevel/20250703214912.244138-1-slava@dubeyko=
.com/

>  		bnode->parent =3D parent;
> =20
>  		res =3D __hfs_brec_find(bnode, fd);


