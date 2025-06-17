Return-Path: <linux-fsdevel+bounces-51982-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67838ADDE86
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 00:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DAC718984C0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 22:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6892C293C55;
	Tue, 17 Jun 2025 22:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MXEqh+Dh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5D31514F6;
	Tue, 17 Jun 2025 22:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750198334; cv=fail; b=V4qSTJsb7/u0tT6ZKMfCj7X2+kkWQL510G2vmHOZY2y86vwDo53VAkOnyaIbEH3jFawMGbstB76PCoG9PLzoU3LzSzoawSmiD9BJusQ3fLeVpMX3V38TBb6wrExQlb7x4zqpzuLrv/gIb8ALOzk7SP32O8W50VSqTdNbIts6Zo8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750198334; c=relaxed/simple;
	bh=6ujDScw6/w/QisaB/felp+eE8thcr+dN/uPLPvnHtXY=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=DLk4gPRVu5JJZSA0aC/UROXNItMB5EZZeJDKWFVatHF5dA4Th2PPTUb9Rj2JGkIUbo99ZKUfvYPh8ICPU6Zf296EB7tf5GgP5RZdOxJhMzVyvstkOJyef3KEH4SQDJcM53D2i5uOseZUm7Y2DktEmmlZnV+yohxkTqI5ne4mik0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MXEqh+Dh; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55HIvtiK015947;
	Tue, 17 Jun 2025 22:12:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=6ujDScw6/w/QisaB/felp+eE8thcr+dN/uPLPvnHtXY=; b=MXEqh+Dh
	+ubJt3VeY/s4fqWQmAfuOGpBxcGg2ttdeTfA0r0WtMUPCOy1FckReH4kxiVhg/ma
	bLorpox+tW7/HSusK20EwO2p2e2RjVCGQhbgDr8FaZeez14UYR+B+i8tiXW25nVU
	Q65HW1VUJX9mbiKIU6cxKWzf655QtjgtGh00fcjaY0t6JBskkqb3eeXzbXocBrPv
	wvFxSmhUEfmBPwH2bZBgLyzEo9hEGmYErohWHXTUSABWr285Vrvfkv7tdiQFRf9S
	7vQlXzO6A7AG1A2SsQHw/JVugNea9RuXxytnzfBTAL29NkkqqEvnYkrkN9L2B9tV
	JowV+hr/qKvqwA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4790r22pce-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Jun 2025 22:12:11 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55HMCB4M010216;
	Tue, 17 Jun 2025 22:12:11 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4790r22pcd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Jun 2025 22:12:11 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dp00u3gg1TQiJoUGfvP9NqHDsEkibIDXhFePAUIouOibmohbX7grRnqtlg3cePFETLZ54vphgaQkvGyzJFUwLFaV+69YojzML6kyH6u8A8vvAw+lkvT+5Re012ItprDnaDkLQMe2eeo4uvuOftJkVUKAJlDscvfX+6wfI7CMsOKTcgspAuBwJavWB2r5os7HJwLpFqhqNsHpGCiduiRXoJUyBTu/VZWhxnZgWvXIhgGRHXiPoYrvo9gk5buV6zqRBNxH2GKJVezq91M96wVhy71QHT+QTQ57VfPQNFU2pOdEXPjtxsQRJ6aGKaMKebo5vsYHT/dQ55Amy+RucA5beA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ujDScw6/w/QisaB/felp+eE8thcr+dN/uPLPvnHtXY=;
 b=m0J/o78khWzO8tMfQXyODGDdTZs97gt241WUc5snx/eG7Lp+DSO6vt/Opqr/s/KooduscGcrL0FrbRwRe0GvS4zWpE6imvowSU5GWOb8FZ6BFGz/tHZD7Kv8U9PNAz0+NFuiNKr1Rlog2KASC5bzVI+lBBOxz8hg5esGXNtzcDpcoyUBEAiuaNv9L59bLIiXI1YMtMnNQrKd8KBvKd598vlGsaGFovw06Ok8cq/GB4XBttABQHXG6qpjgFQWVd30ONrjwtia+LOkeOos8f0Gv9xfbzefYMBopOJhpeOwaVh2h0xSXrjN4Zgag3viIdpR3bLXti8OKDxNgHPs9nRYpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by DS0PR15MB5965.namprd15.prod.outlook.com (2603:10b6:8:15a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Tue, 17 Jun
 2025 22:12:09 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%7]) with mapi id 15.20.8835.027; Tue, 17 Jun 2025
 22:12:09 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "idryomov@gmail.com" <idryomov@gmail.com>,
        "viro@zeniv.linux.org.uk"
	<viro@zeniv.linux.org.uk>
CC: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re: [PATCH 3/3] ceph: fix a race with rename() in
 ceph_mdsc_build_path()
Thread-Index: AQHb39NggKmJO0MvZUaR/wUvvjNfRrQH6hQA
Date: Tue, 17 Jun 2025 22:12:08 +0000
Message-ID: <cd929637ed2826f25d15bad39a884fac3fd30d0c.camel@ibm.com>
References: <20250614062051.GC1880847@ZenIV>
	 <20250614062257.535594-1-viro@zeniv.linux.org.uk>
	 <20250614062257.535594-3-viro@zeniv.linux.org.uk>
	 <f9008d5161cb8a7cdfed54da742939523641532d.camel@ibm.com>
	 <20250617220122.GM1880847@ZenIV>
In-Reply-To: <20250617220122.GM1880847@ZenIV>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|DS0PR15MB5965:EE_
x-ms-office365-filtering-correlation-id: 7290cdce-fb96-4de9-3b50-08ddadec009b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TkFKeTNvRGZBeXZKRUYxVlRBZGpoalhhQUxwRVB6VklWb3IyNklwY1lVOHRo?=
 =?utf-8?B?VWtqS1RuQWFCMDB5SHkwK1BhR3YxRHRKdkFQbk1zWFd0MDNyK0xqblc3empB?=
 =?utf-8?B?dVVLWGE0amxLa3RjM3Iyc1ZySUdmcXlKVjI2ZlVydEJBaHd0SUwvallRUEVw?=
 =?utf-8?B?UXNvbkt5Y2VEbWlUdVFMMnFSRjRQVURMRURYVDc3OUhwS2swMEVycnpqc29Q?=
 =?utf-8?B?ZjBtN3dtaW9tMVRoNllXbk0yVm5sYTNrSVNqbklaT3p3bVZDZllOM1ZGa0JQ?=
 =?utf-8?B?enU4OHRZSFlkVjR1MkJkWkt5dnErZDJUUGJ4NitINkJydm50d1FoMXk0RUt4?=
 =?utf-8?B?aHkvV1pGUFZaeWx0QTlrdzFpSGx1Q3pKSlQ5R1crVzdmY2dXVlk0QURrT2Qv?=
 =?utf-8?B?dnRQS1kzTXJmNVV0R3ZUT2l3eGxRdEtqdlZPQkZhWElENGQ0ZzBtUmtrYlp4?=
 =?utf-8?B?ZEo2aEw2SDVxTGpYdnU3M3o1NGV6bmlOMnlwTmJEeHlRTFZRcit3UHJxNFZt?=
 =?utf-8?B?TzVuNUx0Zno0S3ZrM25jY0Njd3ZWS005eU94bkkzMytTOXFrZ0pvUmJyamRp?=
 =?utf-8?B?Myt3MjRmMjJyR05DMzJjUjc0ZVZzS3lxc2l1ZDFadFVDTXlnbkpuTDNIWUdh?=
 =?utf-8?B?T0U3aG5ON3F1Q2ZMT21rTWZXUkRpenAvU1paeVplMWdDK25iQ2ZQS2FSSGlG?=
 =?utf-8?B?UGYwbmlZelFBb28vVWwzQVF3SHZxSTNaZ0gxTzBIdW1jVWxSUjZPanFNOHE1?=
 =?utf-8?B?UE1zTllvQlE3VG5GdnZlYnBwbWhRU0oxejBVbEZVYzdvOTNOSWFQZXRqeXlK?=
 =?utf-8?B?K2w4Tnh2eE90cDZDNGMzYkkxT3R3UWM2Q0xmUkJWNFE3OVRWT0MrYS9Gejha?=
 =?utf-8?B?NDZKeklQSXlDSndWSXpiaEFhYWJpZ09tWGx1VDZEajZkeW5FV0lHVW5EOE82?=
 =?utf-8?B?ckVsRnVtako1RlNuQXg0cWxXSE04eUNnRXJKK1hFZzJZVXJ1QTl4TWdKcjQ2?=
 =?utf-8?B?VGs3MEhsVHF6QXVHTEo5Nk5lZG1vekg0bnhaR1B1TGJMRWE5cUt5ZzR4QzR4?=
 =?utf-8?B?OGxyb3oyZld5aTQ1cGlqVnN5TVVLamFrbGIrL0FJRS9hYnhZbE0yejBFMGov?=
 =?utf-8?B?MGZCc0t5ZlRCUFFNdFQvTlJ3OW1zcmI4R0x0ZWs2ZlZ0WC80OEdUekYyTnlQ?=
 =?utf-8?B?UUV2RGpEMmdsN1U0NWRJMWg3TURRSU1sblA0REdIR2t4SSs3Q2hyd2ZZd3FQ?=
 =?utf-8?B?SlMzb0dyWllselF3NVJnTysvR1dZVmd0SHhRZlVDREtRS3NURHB6ei9rRjV0?=
 =?utf-8?B?OFBWVzBxbElmQW9rOEpGN1VSNGV4Qm5CaGNNQm54bHZnMS9zN3E1bk1GRm4r?=
 =?utf-8?B?ZDRjRDFQcXZjS0Y4WUk4cnlzMVdVRDQ4TlNmbHJNU2dCVlFJeEo2NDd4aU1W?=
 =?utf-8?B?aXhwWFp2U0k0V2ZnRFJBMndBMkt6Y3FORkNzbDlOQmx0MXpiTW9NOGdqNkM5?=
 =?utf-8?B?VjVia3BzdmJEeGZkT0E2RFNFbER4QkNDYWZ1S2wyN0U4andqODI2QktFTFBt?=
 =?utf-8?B?NC9HL0pjbjArdXNldTBwOElXRTNBU1FTMDY0RHo3bDhaRzF3dGVLcVFtRmdY?=
 =?utf-8?B?eC9BVEw1dEpTeThicTh0UFltd1ZGMkRvZEFzcmc4cFpIOGh0VmFkK3NLV2lV?=
 =?utf-8?B?YkFaQ2tmK0xTdXd2MC85NEx0ZmxwS0cwcklWM0tQaTRQbHpRWWNTamN5MUVo?=
 =?utf-8?B?dktMVzhDWEdRUitxK2ZQMFM3U25ST2V1UXRtaGZlcW9hS0dIUWpqUWhySFFi?=
 =?utf-8?B?NUJ1QSs0dHRZMG02WXlXbXl2VzRPT2FiZklubXRHWW9OaWpOWkdya1NwQVRl?=
 =?utf-8?B?eXREb3FhN2tGS1d1TjJrWUl2SnBjNUFGTmhtR2R0TStybHpEcVdFV2FTNTBr?=
 =?utf-8?B?c0tFVk9PblF2a09oS0dXWm1mNG1pNG1MUzM4VWlqcGVPSXQ1d1ZCbkVpYnQw?=
 =?utf-8?Q?DMH68VI9rIhZhCfT85mPoFMxFVYEZI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dno0QzNCdS9mbmZvUTNRRCt4OHNVdUw3cko3aVJGbGoyUmU0Y09sQ0pSK1BM?=
 =?utf-8?B?WXRBcU9ZZ0p4Z0E3V3VmNGJDTklOZUpBVHU5bWZtd1ZmajhjZk1jK0R6Yk9l?=
 =?utf-8?B?enZlQjNjcGErQVdFU2RtZlVCdzBiMFhOUW1GSlJOL2J5MmlYSHZDMVl5blFy?=
 =?utf-8?B?dGVqSEdXbGNqeVFjWTVTVXdtRXVtMWtNMVFBNHc2d3owQlNURXJsQ0dPaHZ2?=
 =?utf-8?B?blVydlVlM2x0MWpoOFkzUVhud0tXekxvKzZuRnJ1Y0pTaFhEWVhCYkxEREli?=
 =?utf-8?B?blZaZGtpMFFuSTJ4ajYzSHNPcndXd2cwUGNJSEtWcXVucGpVVmpEYk9ONTkw?=
 =?utf-8?B?dWZXM1ppb1VQY2wvak5aNVFBNXFVbWgwd1hnc1BVSG9kWHk3cmc3UUVyZXBO?=
 =?utf-8?B?OGpxY2lHdVI5Y01zNXpNZHZRWFVVOTZxTWdPMUxFa2wvM0tZT1NENDZIenVD?=
 =?utf-8?B?L3YzUzZYbWpJaDFUa09YWkQwNU4zOXdkQmtrRzg1TjNEMk1lRmhhOC9qdEFj?=
 =?utf-8?B?Q1lCZjcxUWpMeUtMb0pQQjF4TlB3aDR3RkhXbGVaV1pBMDhwZnAwTmF5UFox?=
 =?utf-8?B?aWF3RmJvRHhFcG5ZRXhqL0U2eHQ3T1FUVTcrQkM0SWZPb1FPK0M2eDRQeksx?=
 =?utf-8?B?cjJYTmszRWg4SHN2SWY5emNtRTdXR0x1c3Vlb0xXcGtLUlNrWXVLZGRWeHBE?=
 =?utf-8?B?aHkvbm85Vm5OQ1dOYzlNZmlnM3RtRm52UEx1YWQ2cGViSzhaeFZxRW94OGl6?=
 =?utf-8?B?dFFBZ0JWVGNtR24zVnpnRVhZNkNxeE5tWnZjdGU2b0dkdm9KVUZ3TGtoTTR4?=
 =?utf-8?B?aERpRG9Na2paU0dUS09ONW1pZVJQcWVmMEVxK2hjdXI3QmdWa29pdU5TaS84?=
 =?utf-8?B?QjRlT1NvVUNROTZsbmdmTU5zWWtNOVdUc2hYSm0rVVJjYUVNT3pjbkF0L3Ra?=
 =?utf-8?B?MFNmb3lNS3I5WjdSWElBYWJDdTJ1citTZExIaHBRYXNPUnEyM2lnNzR3R01V?=
 =?utf-8?B?YVllZjJXaGlGZHc1OG1QcjlSS2pVMUllcEZ6U280ZmtUdWk3bWltT0JjeWxw?=
 =?utf-8?B?ZHI2UXFIUUhucWViVTA3Ulo2OVo2K1ZCdUo5U1ZrL3JNNFV2T3RSTmpXVXln?=
 =?utf-8?B?SGNzT3JnOUpUeGd0TjY1eGJmZVFobmxJNmpxL0xCc3UwYXhpYTMxSWpMekpk?=
 =?utf-8?B?WWtiUGpUWWJOZWJaSnAxcW1oeHA4bWJCM3lhUE5ac2pFWXdHbTZTZHdjekdq?=
 =?utf-8?B?aFpBRTg0WWVvUmlOZFNGK2YwK3dWTzUrNDhQRmduczVOakhCRlgwS1JYemM4?=
 =?utf-8?B?SStaVys0ejlGWlI4VWdPU0gvdFJaODNwcnliQkRaSVNxc1hrQ2FRcFlRVndM?=
 =?utf-8?B?WW1JUFhZYUFUdWY5dTJvYmhNUUt1WHloSW9UMEwrVGYyaGt0K2haT1FZOHFW?=
 =?utf-8?B?TS9TcHFua2lLOHNhY282UXlhejF1Nkx5QnRPd2xUSWNacUhiaXY1WVczSXAr?=
 =?utf-8?B?ZnNzalVLcUxndjRmYmcxZWdROVZYWGhHSHVIOXd0a2lZVGZZRitlbXQzV1pi?=
 =?utf-8?B?NjVZY1VrMTdReVM1SHNFbDBBM1BPUkRaRlFQMUZjMUErUXd0cys4L2hZWGhM?=
 =?utf-8?B?bzBIWGlMSHUzczh1TXhPQkJ4OVB0QmRYTFozcDQzRzdYTlBKUTQvT3NMTUIy?=
 =?utf-8?B?OG5mWWJZTnlDbGtFVU9NTW1BSlJ0SHhkdWlrd1NDZnBZYVdQYlMrSGZOMFhm?=
 =?utf-8?B?STQ4cDl1NHJBM2NxOW5QazUzYlNTTmkybUF2eUJUWERCWklsaGVQMjhPblNk?=
 =?utf-8?B?NGZ0N0hoNWQyaXhSWXZ0ZnMvOWNQNUZoNmEwN1pCK1hodVpTK3ZrZko3TEFx?=
 =?utf-8?B?RVNBeWR1WThsT0JoY1E4eWRhMVZ5L25oQmVXVDhHc0NMOUU5eVJ3Uys4dmpD?=
 =?utf-8?B?Ri93YTVTYjF4RVRyZko2S0cvS1Z5UEZKVjFwZnppTGRuV29EeWRqOGF0UlFz?=
 =?utf-8?B?Zk1iUmwreWxYUE9tQTZNY2N5NVBxcEo0MXhjVE5TQjE4MDJuOW5TOWhDbWlC?=
 =?utf-8?B?UzNkOG1qb21iclpEMkhKQlV2M21yblkybkJUM055RDVXVjhrY0M4NWtEY0k1?=
 =?utf-8?B?K0NDc2VoVG03SHpBcTNKVFIvY3hLWnA0UkoyeWN6WjhLL1FqaElCZW5OdjJl?=
 =?utf-8?Q?g20lsb6S9EghAn56t7+qteU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <43B02DEA628FF44F9BC860C29FD5F546@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7290cdce-fb96-4de9-3b50-08ddadec009b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2025 22:12:09.0489
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tsu0YXdnbkqKFuL63I4w5oUxoVgHYih9jC/+4wVBJ8L9uAi8OeVh6Ei633esvpCIRfFlCzrNsz5nmdVWwoFK1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR15MB5965
X-Proofpoint-GUID: TyeFLLEP71DsWyCuFW4We22JuxgvLtfK
X-Proofpoint-ORIG-GUID: RSpzfcJfmfqkOEBsY-nZbr5ScvtS6Rso
X-Authority-Analysis: v=2.4 cv=AqTu3P9P c=1 sm=1 tr=0 ts=6851e83b cx=c_pps a=XbCLgsAEGm7m6p89S+a4Ww==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=SmkHewMKT1EVu9Eo:21 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=l5KmBjzonciyOKpagJYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE3MDE3NSBTYWx0ZWRfX42f5ACQ8cTP7 Isui5Tc3Amb4A6g9OFUNaMAjJtBks4SUuIbq707K86x6cIR/ohqh89JGe0Ihr583VL5Y0TK9501 mtdBlExDL/M5t1LxUYHynssk0g2dJifpssPmT7zMB8Gknfc45AVh3tKdwCoXsORzyfSGjdyEmL2
 f0+2Z1SHF2b3wAk6h42QKXtd5bNJtYEVLj/RIKyeL7FX/fHjlL1Xs8ubj8J62tXOqJc+IlrRfPq ZJHnrYNUUkufOYqQWekfh+BUVrXW9xqbR8Z/w5oztQAYuXWDcPWIzu60xYWC8THMLNwRo3x0GTo fEaHaCdOlzUmO/T6dfC5vL79dtdCkwISDOakNwxsRgh7MWwEC2jXkx/HMnREhjTKNiQ8YQtIa5i
 F3xdhuHoErcmQSXpZMrPWlguhEB36rU5Er3RYsE37CKs+p39CHJQc6auOYESaIYJY7JHF2op
Subject: RE: [PATCH 3/3] ceph: fix a race with rename() in ceph_mdsc_build_path()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-17_09,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=854 mlxscore=0 spamscore=0
 bulkscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506170175

T24gVHVlLCAyMDI1LTA2LTE3IGF0IDIzOjAxICswMTAwLCBBbCBWaXJvIHdyb3RlOg0KPiBPbiBU
dWUsIEp1biAxNywgMjAyNSBhdCAwNjoyMTozOFBNICswMDAwLCBWaWFjaGVzbGF2IER1YmV5a28g
d3JvdGU6DQo+IA0KPiA+IFRlc3RlZC1ieTogVmlhY2hlc2xhdiBEdWJleWtvIDxTbGF2YS5EdWJl
eWtvQGlibS5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6IFZpYWNoZXNsYXYgRHViZXlrbyA8U2xhdmEu
RHViZXlrb0BpYm0uY29tPg0KPiANCj4gT0ssIHRlc3RlZC1ieS9yZXZpZXdlZC1ieSBhcHBsaWVk
IHRvIGNvbW1pdHMgaW4gdGhhdCBicmFuY2gsIGJyYW5jaA0KPiBmb3JjZS1wdXNoZWQgdG8gdGhl
IHNhbWUgcGxhY2UNCj4gKGdpdC5rZXJuZWwub3JnOi9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQv
dmlyby92ZnMuZ2l0IHdvcmsuY2VwaC1kX25hbWUtZml4ZXMpDQo+IA0KPiBXb3VsZCB5b3UgcHJl
ZmVyIHRvIG1lcmdlIGl0IHZpYSB0aGUgY2VwaCB0cmVlPyAgT3IgSSBjb3VsZCB0aHJvdyBpdA0K
PiBpbnRvIG15ICNmb3ItbmV4dCBhbmQgcHVzaCBpdCB0byBMaW51cyBjb21lIHRoZSBuZXh0IHdp
bmRvdyAtIHVwIHRvIHlvdS4uLg0KDQpGcmFua2x5IHNwZWFraW5nLCB5b3VyIHRyZWUgY291bGQg
YmUgdGhlIGZhc3RlciB3YXkgdG8gdXBzdHJlYW0uIEhvd2V2ZXIsIEkgY2FuDQpwdXNoIHRoaXMg
cGF0Y2ggc2V0IGludG8gdGhlIGNlcGggdHJlZSBmb3IgbW9yZSBkZWVwZXIgdGVzdGluZyBpbiB0
aGUgaW50ZXJuYWwNCnRlc3RpbmcgaW5mcmFzdHJ1Y3R1cmUuIEJ1dCBJIGRvbid0IGV4cGVjdCBh
bnkgc2VyaW91cyBpc3N1ZXMgaW4gdGhlIHBhdGNoZXMNCnRoYXQgY291bGQgaW50cm9kdWNlIHNv
bWUgYnVncy4NCg0KSWx5YSwNCg0KV2hhdCBpcyB5b3VyIG9waW5pb24gb24gdGhpcz8gV291bGQg
eW91IHByZWZlciB0byBnbyB0aHJvdWdoIHRoZSBjZXBoIHRyZWU/DQoNClRoYW5rcywNClNsYXZh
Lg0K

