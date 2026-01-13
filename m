Return-Path: <linux-fsdevel+bounces-73513-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D23D1B4B2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 21:52:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D4D10307F714
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 20:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8DA3191D1;
	Tue, 13 Jan 2026 20:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fm7IpI//"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20D0318BAF
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jan 2026 20:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768337571; cv=fail; b=oFZgQTvRQCaK+6RSY+S1m4WpY2HAEuPUC5T0pv8C2gtE88LV1Nh8CT07E34DvtQ/IF3cPBzf5kmaX90ELPEfguAhJLLf1uNXk0jP1WQwSnr9L+JuJr8LfEqD59rKlN6bDqwmMm9OE5x3ddnWjddbK0eVk9AYwS70wlVIY39Nmbc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768337571; c=relaxed/simple;
	bh=hScSgxqBK/nPjeSCuMaw9ENw/K8I7Afc62C456p3GME=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=Vp/KKCLFYcntfvZjLomnqHKo0YtBN1kUZL6wgSxYBlAAAIbLnG91085/6vCNcukWVXkhMJXc1jMglEt+KDu0r856bTDfW8cs/z/AfP35qaa3OSJYsXt82j92UzUKkGIgWtQQkPNXkdNQVsi9IPWzKvT9EMljFxvwmHvdhzINLSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fm7IpI//; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60DBvTLZ020335
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jan 2026 20:52:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=z5VOWQzwKByu9cWzw0AE/bQYHEeXqKvcnEvynla0SEk=; b=fm7IpI//
	ukyI3QjT+ujMD4meWD4pJTJptcJ2PgIZ8ItKTUE/0afMpoD5BLbslTPZYxdxmpNG
	90b3+x27UtxtPK1YLdnmBfr4jWzWRAX6nAsCvPEFbpJ0uRO0rn6Eap8FeLBnkc0f
	7Ty76DPJhPMEOZFOYkWjDFHvbxyNBuC2oraUMKx+yVXs7eIk6TVQeXI6zKMKurTo
	W5+qh9UnVVAVq63zWKYPcC/Df8JuzZfzP50tYVCJmkeq4Swa9FHogUQLyWxgleff
	6iiMRi5x3zfX8vSOEqIgVk1mjS/vglvCWurN7JjXonxjw1QM1c3KDBPw3qasRzz2
	6I35f9xQfJvk2Q==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkd6e694s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jan 2026 20:52:48 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60DKjSx4010548
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jan 2026 20:52:48 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkd6e694n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Jan 2026 20:52:47 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60DKqlVg024376;
	Tue, 13 Jan 2026 20:52:47 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010056.outbound.protection.outlook.com [52.101.61.56])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkd6e694k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Jan 2026 20:52:47 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jX1q+ZrajWiRdKF4KTRnG+EokqPO13iHYSGkzh00MnDuAlGuUhgNGeZUGvp50VqHzFcYyslhnY/J5VMxQCG8DFcHpjHnD+1506FATFXHjWjBd9a1lB2MI8057lIgAZ7K42tGTjrWeGmaeClRGJSz8nSqD4HjhoOLRNw50J6Z3PENy76rY7yDgyHGF4QcJkrt4bJtyxW8AhY6/xsJTZs0gwdM1VM++xjUT8Yh7b5R01+d3Z0yCj8bRsLYl3t/zrbBRd7DGda7lw4sl7ZY3U+dL8nfV8OkA3wtGcwmlml0WsAa+9Vos4s7Vv/1VLV/wdOWuSI5KajjGiqtOFsWcSdz3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OizO2JPcXhsixDLB3csw+s0FweV1Yyrgi9jqhOGAwMM=;
 b=y6YQ7xN1oYuBqNYFmQb3/3LazpNZ/7RPRVN8jQhnAw7tftRDHd+gCZ4qmJFif1kqVClJfcaIdbrhVmER9as9SFnP3lLAwV7ioSbxV4bLCRjHHglRZix0y0/Kbr8+MwEhVSl9cUTaFRrVE5rOPQ2IFGGKZX/SrMwTkeSq43wUd2NmxSWhzWG52JrpxsA+PfZ1tjKNREp4qCrCepXPVspApYjJTvWkkcnCLRaN7QNADWn2B+4NePxXm9RN+UDjy5xtKru3wpZDIxX4xYqODcAY4TEO5xZX3eNPvDXQ2a9PWsYT1Nz+zgZmhpifXCu+kxuKc6jDgjAzluF8ctAx6r9mNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by LVXPR15MB7104.namprd15.prod.outlook.com (2603:10b6:408:380::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 20:52:45 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%4]) with mapi id 15.20.9520.003; Tue, 13 Jan 2026
 20:52:45 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "wangjinchao600@gmail.com"
	<wangjinchao600@gmail.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC: "syzbot+1e3ff4b07c16ca0f6fe2@syzkaller.appspotmail.com"
	<syzbot+1e3ff4b07c16ca0f6fe2@syzkaller.appspotmail.com>
Thread-Topic: [EXTERNAL] [RFC PATCH] fs/hfs: fix ABBA deadlock in
 hfs_mdb_commit
Thread-Index: AQHchGWsZFQkZj5k2USrGR10Bd2eNbVQlFYA
Date: Tue, 13 Jan 2026 20:52:45 +0000
Message-ID: <a2b8144a25206fba69e59e805d93c05444080132.camel@ibm.com>
References: <68b0240f.a00a0220.1337b0.0006.GAE@google.com>
	 <20260113081952.2431735-1-wangjinchao600@gmail.com>
In-Reply-To: <20260113081952.2431735-1-wangjinchao600@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|LVXPR15MB7104:EE_
x-ms-office365-filtering-correlation-id: da04c171-527e-41da-08b8-08de52e5b3f8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?MjFvWStFMU5GSTVmNzBZcE5yM29IajJndWRPK1YySWhxaHQySFB4SituNGZP?=
 =?utf-8?B?bTEyblBwSnZrL3VILzBmNzI2bmoyTFoxV0RGNk80ZHQ5T2VJdVk3Y3F5Umhh?=
 =?utf-8?B?dXc0clQyeXplK2hiVktpR2pIN1lUdjRaNUR1QmdlYU55Ykx2cFNveWw0MlVX?=
 =?utf-8?B?WEU2SXd5dVZvTjhaOEFzNytNUDVFSVdDbzFBd2djT2p0dXMyTGRSMzRXRW1K?=
 =?utf-8?B?eVdPZWFTYWUvSGowaGgxQWNRU0tXWFNPUW1Sc3BhSWY3WHQ4T1dMcjNyMG1n?=
 =?utf-8?B?OEp2M1hFQTRoUTNxVGdzakxDSW5Ocy9jazZIMHpTWmkrZVQ4VTVvZTY2L284?=
 =?utf-8?B?MDBKRlp4QldNL0VyMmIzSUp5VGR6YWhLWGVSY1ptVGpvRCswSUhINW5rcnNF?=
 =?utf-8?B?RXJvWVMwc2NVY3FvZ2lCb2RudmVTZFRLODFWdFh5Y0w0V0VqbjJxR2NBaHJG?=
 =?utf-8?B?VGhXK3dUQlIyb0ZrOTY3OGZqUUkvdlRjMHRCVUJkVG5TMzcvdi84aEZwc1dy?=
 =?utf-8?B?MExVWHN4aGswbDdOa3RzS2htanh2TVhyQXFqWFJLVU9MV3JZcWgyek9scVBz?=
 =?utf-8?B?YytaR25URmR2WW1GbllxZU1zRDR1bUxhRko5RUdYdmVOM2dRMU45MndVY2Fz?=
 =?utf-8?B?SHVOL1hNY3NZZ205UDgwYWx6VzNVNVV3cHdXYWFCRTJwd3BlaWo0WGlneE1Z?=
 =?utf-8?B?LzdROFFNaVVsd3RsVXRuZkN6bnFmZEFNM3k2Vm92cG1tK2cxZ05XUitFM0Zn?=
 =?utf-8?B?Nk1zVU9SRXNTODQzelBVSmY3MGVPN2VsQVhDTlQ2NjNJMVNkdU41akY0bjBN?=
 =?utf-8?B?K1RDa0E3WUlwU285Kzk1MHZmalMvblpNQnQrVnM3ald1UlJwaUE3TjZ1MlJB?=
 =?utf-8?B?Z1FFS1JRR0ZVT29ZNSt1QnJRRjZDVE45RTBabnp2YVJ2NTZSNGVkdFJPUUFp?=
 =?utf-8?B?Vm9YbE9VTlZBRVNuVmVUb2RWNWtDQnRrNXJHZnNxbHEvYU1zaXBnM3VUMzFF?=
 =?utf-8?B?cFcyV2FPSExLenAyalRRalJzYlh1WGNxS2h6L2d2QXM5RGwvM2ROTzIvMkVM?=
 =?utf-8?B?M0U1cUJHSitvTWRmMWJUSEpmTGJMcDVNaVVMcURxSDVUbW8yMkVldFNjbDFT?=
 =?utf-8?B?VE5lWkV0cDN3RUQxQlVaSjFtMFFIL3V4dHZsR1R6eEl3WkVBRzA0c1ZRNkhT?=
 =?utf-8?B?VnlRS3RRaFNmVnhEZzIrQkJJRXpFOGRBMjNFVStLOHViZ09tMXU4MDB0anlr?=
 =?utf-8?B?cllMamo5bldaQXRJczNJcndZQUo3QTBhYjZwd2ZLR3ZVR2NtbVRRS3pqOGR0?=
 =?utf-8?B?bXYxNzIySDhOZ3pScU5Rdkl5aDRIbk4yNW9sVXVXUnJYM0l1bXBFUmNBQ0Na?=
 =?utf-8?B?bTI1blNrcTlYZGlxL0pscVpmcDk5K2MrYy9tc2xleno2SXAvQWJwZ1NBTVI5?=
 =?utf-8?B?dzFVeDFlclpoREROemh4cmpnUVpJZnNyNDNBY2RnbVlUaVMrRkRVYThxcUxi?=
 =?utf-8?B?dUdpNU5lYis5RGVLUlJwVEE5QnZnWkhVa2NudGtSRUNqU042YnFnMjFKL003?=
 =?utf-8?B?bW1IZ01PVUV4RmVYaiszV082RGE0YUxtU25JbkpTQ0lZR05HOUYrb2lmTHZM?=
 =?utf-8?B?ejJjeFQrNW5QKzhRWUwzNmlmRWdqZGM3KzBDVXYvU2xWdXFmMXM1dm8xSWs0?=
 =?utf-8?B?S3ZLK2NiRnZPRGN1b215dyttYWt0U0Vha25SWkgrWXUvdXRnUHNWR0hsUktJ?=
 =?utf-8?B?eXduUGlMQVg1SDc3Qkx6ZlBqL2k1OVNmTUVnRGdjNHJQczlpbThTZzRBUkRo?=
 =?utf-8?B?VlJIUlJqSngwbmg5eUNYL1dCcmJoangwdjdHek9TMGdjcG42Z0F6ZWc3ZVQw?=
 =?utf-8?B?Y0V0d011Q09hdzJtSFlIK2N5ZWI1UTBJdVZlU0l0Q0RJcXNmVEpIZG9pRmtT?=
 =?utf-8?B?dzZIUEFsT3NKcVA3NzVIdXNNY2JwbG8wQjczbXF6VDFxTVRNNExOQVAxMVh4?=
 =?utf-8?B?RWJ6bjdYTzd3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dk5kb3F0ZjBmbDBDU1lpSkFjajc5TDNTQTFQMmJDSjBRRmVZNG5MclZiM0pL?=
 =?utf-8?B?YUNRMElLRXNXSjNHT08vQ3Jaa1hXZVZTOFBzVXllNVFwRzJBaEZ0STcwT21D?=
 =?utf-8?B?OW40MDdpMExJdDNlZkMrejNJbGVQVitrNlhSM1Awc2MxNUF1TTlWc3htRlZT?=
 =?utf-8?B?V1FrY1cvZlAvUzRmUGhZak1FeTBKL2tGY1BhSDhuUERwb2EvNC9zd2NEVGM4?=
 =?utf-8?B?MGR4dWdGZW1TTFpWVTdUOE1wUmlXTlpuWi9oa2pSd1FnMERUSXJNU3E5T2xo?=
 =?utf-8?B?S3FTak9pUnhRMmxSVCsyOEwyQ3V4Zm9PY2I0S2Y5UFp2OWZsamtSNmpPVUhT?=
 =?utf-8?B?ZGtXWVpGeGVnVXpGbXQxNGRTMW55bkV0V0gvdWVSNHlLQlRiZ2EybFh5QlFJ?=
 =?utf-8?B?K2NjNkNXeStYbWZRd1E4d3IxS0xDcUFFdWgveWIwQ0V5LzJrY0R5cFB2di9M?=
 =?utf-8?B?SzlqMUZjYjBFTHNxQ0JjUE9ndWMxS1ZDaGJBbjIrMDg2RUNTbnV6aE9IQnlm?=
 =?utf-8?B?ZHNpc091YjVYS3FEYkR0SDVhWUdNVVN1QUhNZ0wwdk5VMitBemxWRWlReHNV?=
 =?utf-8?B?a3hsRVdkT2pNb1VYUTFiOEpHSUp4SGZGMGQyVVU4MmJic0JvNkpHcU9ncCsz?=
 =?utf-8?B?b1pUVXBSMEE3ZURtMDVnUFJBS2pYK0o4ZWpzbkVPOElwWG0vTGh4KzRnbXRt?=
 =?utf-8?B?LzZTazF3YUd5cmxHUDVPNlczVUFyR2E0RGErZVFNbXVyQTVYRmRxekRWZitK?=
 =?utf-8?B?OFFRU1NOVnRSUU1lYXIwVE5NbDNDbkRYUyt5VHJHM0hCRVZSRmNKSE1sUDRI?=
 =?utf-8?B?WmNjUkpEZjBITFV6akNPSE5HVThFamY1MzhnU01RKzRJZVFJcDlDbmdGVlFR?=
 =?utf-8?B?bzBSeHlIUXRUeWNoSnVNUlYzaFJRUHFKUmhEbmFFYU5aMTZiNHR1cTJQcVhn?=
 =?utf-8?B?ZzBLWlhRT0hya1FvWllQRFpFYkVaS0dtMkRBRzd4UDdNZWZFWWV6ZUJya2lj?=
 =?utf-8?B?VHZHRjJBdmJQZytpVnBDNE00Nyt0OThKbFlNVGRISStpQWVFUnBRcVNFdzVP?=
 =?utf-8?B?bTNzMEUzNnc0U0VQY2ptalJUeVNWcFh4MnBNczNremxVb2NqZ0FyWkw0VHg2?=
 =?utf-8?B?VTdVOFNBZ05pQ3dnRXdLb3RnQ0NnV1hVSkFFbHNBWXh1Q1NSYWpDOXh0eE1C?=
 =?utf-8?B?bjYwOXBPbUpXZEJJQU1PdWw3eHcyd0hLNEhXbWhYN25DMm1JS0Y1QzRzZEpC?=
 =?utf-8?B?VkNwazhkR1JvR1V2czRodXE3RCtzL2dwR1ZVVjE2WGk3UFBiTlRwbllpSkI1?=
 =?utf-8?B?d2NGVEdCLzlVN0lNTHZlTjN0RU5sY2FqbHh6Ly9lL3lzbzcrc0Y0UFlYRVVx?=
 =?utf-8?B?enVDeHJrY1BudTE1ZFhzbkpaRVQzSWdZYlJRTUp0MXRnSW1tVEN4M05PT21K?=
 =?utf-8?B?Z0hDTnpDcHlLRGFySEkyWWRyMXh2STBzQ2R4R2loVmFNT3cwVmJVZVk5K1RV?=
 =?utf-8?B?dVcrelBMWTl6YVRJQTlJSFZtdHJObTh4OXhFeStxZlZyeFVnNENCd1VaNUs3?=
 =?utf-8?B?cHF1RG16TjRVaUVGYXFBc29YWE53cnl4U2tNeXFQWDV4YTJQUVptR2g2Vjhv?=
 =?utf-8?B?dEs0dHgwaEZjK2hVcjg5S1ZFa3c5eU1OWU0zMDlraVBDUWFyblQ2Y0xRZUdt?=
 =?utf-8?B?RGg4Ti9yVXZMNSs3cHNwb0pDVHQzWjk4OTJqWURZM1l1Z2VmTDJvODVaQVVk?=
 =?utf-8?B?REUyUTkxSmNESEVSM2diOGF6OG1NbFBTU2tCL0JZaisxQlpCN0RpY0JOTnZH?=
 =?utf-8?B?Q0dPWmNiQUw0KzNTRTdKUElnbDErcUFWYjVjQ2VQaUpaVkxEVWRrc1JrZmJI?=
 =?utf-8?B?VnFJUE9BVGF6RGpOS0N1UklOcWxtMy9HczJwMFlheTM2LzBOSk5oMUhVbmJP?=
 =?utf-8?B?T0tVTHhLOGs1eFBBWjlBbkN1SW1LaWpPaVpzeUp4SERmL0pMQ25GZUM3T1N6?=
 =?utf-8?B?TjQyU2FtcmdHS2RaazgzeDhEdVp6VEt1UEdjNkxnMW5BMzVQeFlVYnhhb29l?=
 =?utf-8?B?SEgwYW1WbDQ0dFdiZ3ZyT2NXcnZZTVU1b2s4NlFyclRXSlE1ampMa2ZOSzQw?=
 =?utf-8?B?M2V5QXRYd3RGb3JWcWZwUlBIQW9aSFdLbFBJaHdnNFhGY3FBVUV2cVhUd0dr?=
 =?utf-8?B?aFFOM0xHWFdxUk9MbXNFVnI4dHdjLzdXMWxySVk4cERobEFLWjJ4aStXTENH?=
 =?utf-8?B?TEoydnhyazdTSmt1d2ppTFZGeUIyeFJQRmFiaFZsMnNDbnNoOWZQR0gycXhH?=
 =?utf-8?B?MWN3ZnVQb2J2WVpUR3dOMjdyVSt2NnhYVU1XLzU4a3JzN3RXYi90a21iSTNn?=
 =?utf-8?Q?Db84Wg3wv+Vasnbd3j+WfDhB/wodnSv3zw55s?=
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da04c171-527e-41da-08b8-08de52e5b3f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2026 20:52:45.2948
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G7xUBfFPngGuQ24NS0/3gSfxXpySDo2xSGeN/1y0b/JPgQimOiumMpDMxQsZkUuhlV+FmlPeJE0+eMO/Wn2b+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVXPR15MB7104
X-Proofpoint-GUID: 4LKGy7mDZINeOEOcyFwCl2l9Sl7d5v-7
X-Authority-Analysis: v=2.4 cv=LLxrgZW9 c=1 sm=1 tr=0 ts=6966b0a0 cx=c_pps
 a=PxsVn2hUj41VgPYomOKOQg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=edf1wS77AAAA:8 a=P-IC7800AAAA:8
 a=hSkVLCK3AAAA:8 a=pGLkceISAAAA:8 a=e8f-TJqqESo1UKYmmCIA:9 a=QEXdDO2ut3YA:10
 a=DcSpbTIhAlouE1Uv7lRv:22 a=d3PnA9EDa4IxuAV0gXij:22 a=cQPPKAXgyycSBL8etih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDE3MSBTYWx0ZWRfX00oL4ueOG+rS
 rP0Co4MVbe5ha1xUjS9Njl9586LFe1KYTFu0gD55N4R3TBEM8ymcb9gtSTOt0uOJrsHDWySCkti
 q9wLNg805coT8wKYn5MW3lSW4v0pFsuZyl5eE/TJhas6MxmKy+p/cUxLu+7zNRsG8jIU4wuIJtE
 al7p96Vpoy4OwCMBXcZf75xlQ0Bb1JSyWWB3Z682qnNnp1y1Lv5cDeet+7g/IaATKLbQCkErS8k
 JiwOia9fpEt5bQ+jg3QqTJW6iJF4fiCdvOt26L1WlhztUwBWsOQ6GoEYHxG7MQRBpSiGfDL8n5P
 lBPyvHP11ujjIgxyXj3nA3jZbhWqSgF8MITvYrzM8x0DhvVSK9Y3v8b9eZUWXUHzgvRcRx5lSSr
 r+Gy157k9K3xkjd1QYy+jQm111llcO7E5ZXLR3K3oNFOc2v7xeFHebJGcgg+Ic6pb+jzcfE6vOw
 V/4LznAdoxvX2F/2tOQ==
X-Proofpoint-ORIG-GUID: wtT4my_nFWT00jMy47n7S4mC48-l-rjU
Content-Type: text/plain; charset="utf-8"
Content-ID: <B1F6F091F524FF409C49714B5116F33E@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re:  [RFC PATCH] fs/hfs: fix ABBA deadlock in hfs_mdb_commit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_04,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 spamscore=0 clxscore=1011 impostorscore=0
 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=2 engine=8.19.0-2512120000 definitions=main-2601130171

On Tue, 2026-01-13 at 16:19 +0800, Jinchao Wang wrote:
> syzbot reported a hung task in hfs_mdb_commit where a deadlock occurs
> between the MDB buffer lock and the folio lock.
>=20
> The deadlock happens because hfs_mdb_commit() holds the mdb_bh
> lock while calling sb_bread(), which attempts to acquire the lock
> on the same folio.

I don't quite to follow to your logic. We have only one sb_bread() [1] in
hfs_mdb_commit(). This read is trying to extract the volume bitmap. How is =
it
possible that superblock and volume bitmap is located at the same folio? Ar=
e you
sure? Which size of the folio do you imply here?

Also, it your logic is correct, then we never could be able to mount/unmoun=
t or
run any operations on HFS volumes because of likewise deadlock. However, I =
can
run xfstests on HFS volume.

>=20
> thread1:
> hfs_mdb_commit
> 	->lock_buffer(HFS_SB(sb)->mdb_bh);
> 	->bh =3D sb_bread(sb, block);
> 		...->folio_lock(folio)
>=20
> thread2:
> ->blkdev_writepages()
> 	->writeback_iter()
> 		->writeback_get_folio()
> 			->folio_lock(folio)
> 	->block_write_full_folio()
> 		__block_write_full_folio()
> 			->lock_buffer(bh)

The volume bitmap is metadata structure and it cannot be flushed like regul=
ar
user data blocks. So, I don't quite follow from your explanation how
hfs_mdb_commit() can be deadlocked with ->blkdev_writepages(). Currently, y=
our
explanation and the fix motivation doesn't make sense to me completely.=20

>=20
> This patch removes the lock_buffer(mdb_bh) call. Since hfs_mdb_commit()
> is typically called via VFS paths where the superblock is already
> appropriately protected (e.g., during sync or unmount), the additional
> low-level buffer lock may be redundant and is the direct cause of the
> lock inversion.
>=20

Even if you remove lock_buffer(mdb_bh), then, somehow, you are OK to keep
lock/unlock_buffer(HFS_SB(sb)->alt_mdb_bh). :) No, sorry, your fix is wrong=
 and
I don't see how the picture that you are sharing could happen. I assume tha=
t you
have not correct understanding of the issue.

Which call trace do you have initially? What's the real problem that you are
trying to solve? The commit message doesn't contain any information about t=
he
issue itself.

> I am seeking comments on whether this VFS-level protection is sufficient
> for HFS metadata consistency or if a more granular locking approach is
> preferred.
>=20

This lock is HFS internal technique that implementing the protection of int=
ernal
file system operations. Sorry, but, currently, your point sounds completely
unreasonable.

Thanks,
Slava.

> Link: https://syzkaller.appspot.com/bug?extid=3D1e3ff4b07c16ca0f6fe2 =20
> Reported-by: syzbot <syzbot+1e3ff4b07c16ca0f6fe2@syzkaller.appspotmail.co=
m>
>=20
> Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
> ---
>  fs/hfs/mdb.c | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/fs/hfs/mdb.c b/fs/hfs/mdb.c
> index 53f3fae60217..c641adb94e6f 100644
> --- a/fs/hfs/mdb.c
> +++ b/fs/hfs/mdb.c
> @@ -268,7 +268,6 @@ void hfs_mdb_commit(struct super_block *sb)
>  	if (sb_rdonly(sb))
>  		return;
> =20
> -	lock_buffer(HFS_SB(sb)->mdb_bh);
>  	if (test_and_clear_bit(HFS_FLG_MDB_DIRTY, &HFS_SB(sb)->flags)) {
>  		/* These parameters may have been modified, so write them back */
>  		mdb->drLsMod =3D hfs_mtime();
> @@ -340,7 +339,6 @@ void hfs_mdb_commit(struct super_block *sb)
>  			size -=3D len;
>  		}
>  	}
> -	unlock_buffer(HFS_SB(sb)->mdb_bh);
>  }
> =20
>  void hfs_mdb_close(struct super_block *sb)

[1] https://elixir.bootlin.com/linux/v6.19-rc5/source/fs/hfs/mdb.c#L324

