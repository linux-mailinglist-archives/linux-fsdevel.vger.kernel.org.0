Return-Path: <linux-fsdevel+bounces-59141-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A30A4B34E75
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 23:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65C8C20093F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 21:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B94D29D29B;
	Mon, 25 Aug 2025 21:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sK2oNKee"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BC12367C9;
	Mon, 25 Aug 2025 21:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756158842; cv=fail; b=cx8aAlDS3SupVPxki3yfqs1IBdwYcWeUwEHHwoclcrFYm4Zpqc66DH43TsIVSoHMrTDpNMe4ANOT+NEpf7KjB+PQNOXLWoRwVr1fO/cov+/Op/zs4DOOoiH8Mj+xPNc6GPPG3JeRbvcXewkl25TMGnDobJKEp9Ke3mdia7vsCnQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756158842; c=relaxed/simple;
	bh=AZbWn3K8CInlyrFEQqPhTczt2BwclVIKHj8wcgdqQmE=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=H2f/Cuas3W6mQ5J+R8LtB67ptoJ8EgvcUWaV3lEJ1N9ditI+CtK6F0qo+WbHSiA16jAuYMqJN+FVOr2eVuO4EJxpaHmdWI2wdeCOcyW05uk+GjblHc8Vc35JBr+Mrt3cf2QBUP6c6Q4YFqmGiIxrlTQueiDeqp18Mgjn5PNk4uo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sK2oNKee; arc=fail smtp.client-ip=148.163.158.5
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57PJ6mlL015750;
	Mon, 25 Aug 2025 21:53:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=pp1; bh=AZbWn3K8CInlyrFEQ
	qPhTczt2BwclVIKHj8wcgdqQmE=; b=sK2oNKeeoGPYFQWLUifFHPGbIQRdauuCo
	Yhyqf9TysybDXutwvS0Zix5eaynVudiDKLwhfDbYKpT1IAtia9LzWGi45jrTfXiV
	Mr2tr5ZUAUJLwzcc+eRBB2cRDXPty7k+WsBMdWR2Hu3yYJjFfmFgw+Py7nQyGWmQ
	/BHSP0teN7Tj+3qUX/93OWQhy0AzcNbxC3vqXMG3hsWUrn2hVHD8Ge/wo2UtSq5E
	+SjsfMQGlEiTYqan2sTD1sK1f05/aCSmQ3TgCng/SPT9TeeuoSoqW1tLy2x7ujIF
	+OSFAT4j7khhmZXc1eQ9rKGHvGgzLa0Og0zrFYZL9k4kR0ssnKWvA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48q42hud7k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Aug 2025 21:53:54 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57PLnZur032458;
	Mon, 25 Aug 2025 21:53:54 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48q42hud7h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Aug 2025 21:53:54 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k+fYVz+iAUjeA5AbYZMN3z/LmbNvMjnRTh2SG6YkcnHy0NiwgoIGmgmi5/rg8Qsr3zIxEyjJfAmzW/9AaI9AYJEuJUPwBJtUjMX9GqsjDaeufjG7N+QY6Np6evwkmZte2zB6T0ueziUjmMpM773F0REbFq0RUdAvXewmX3qY2X0Aigh3skVyfG17Eh4VeDGL6tzcPyBSbuk4VsuSaIFjaKq2not5wo0ioOiXuOrPFK+35CfjwKpdO8AS/2vVk1UaxiLSiyMro2E/OPv5AdiwwTNI+vUO8eKN4XW183eHx/9MFZcyGuAvzVa2XGEZHJ6b7W9YcGxVl6TFmgWb+TLirw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AZbWn3K8CInlyrFEQqPhTczt2BwclVIKHj8wcgdqQmE=;
 b=eyoytaRrcboI0FO/GvbdKebOi4VfLxUBaccuhXKTZ61RwW2OZ2D+OZaAHskLOhsi+H45YObs1tGDH83q3f6pA/Eg8I87doxIYuY9o7NLi3vH2UHY5r4+yt/1OndEYoyDIGi6ZRQGREmO16fxBUJk6V3fKGtSOfgElWB7K+6c0qD58AuuSzKGpfHtO3cZDPqBWZ7DxxpwOjPuG6M/qAQ1QNtPURXk0u4Ym950CHIfWlPwUPIl1c6MovP+WTpQpLPjzTYsjX3WX0lEwr6rFQmS5wGuTkrHJ2G277ByWp/tpHbqVIfzncTxf+Qzr2ik+wSlS/9C5SgldK8arRuXIcGtmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by BL1PPFF6F37B74B.namprd15.prod.outlook.com (2603:10b6:20f:fc04::e55) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Mon, 25 Aug
 2025 21:53:48 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%3]) with mapi id 15.20.9031.023; Mon, 25 Aug 2025
 21:53:48 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "brauner@kernel.org"
	<brauner@kernel.org>
CC: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        Patrick Donnelly
	<pdonnell@redhat.com>,
        Alex Markuze <amarkuze@redhat.com>,
        Pavan Rallabhandi
	<Pavan.Rallabhandi@ibm.com>,
        Greg Farnum <gfarnum@ibm.com>
Subject: [RFC] ceph: strange mount/unmount behavior
Thread-Topic: [RFC] ceph: strange mount/unmount behavior
Thread-Index: AQHcFgq8up/kVXqx70yqH8FeecslxA==
Date: Mon, 25 Aug 2025 21:53:48 +0000
Message-ID: <b803da9f0591b4f894f60906d7804a4181fd7455.camel@ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|BL1PPFF6F37B74B:EE_
x-ms-office365-filtering-correlation-id: 83e4baaf-9259-4bbf-e19e-08dde421df3f
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr,ExtFwd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?V3lpcGVLVzZwRWREc1FtcVhZeHN3bDhkYjE4eGVKdmVUV0NpRVFBbHJTb1k3?=
 =?utf-8?B?ekxUYkx1Y01zU29vaUU3emVYdTBIQ1VPbE0xaE1HS1VZLytWQjVZQXhEaU9R?=
 =?utf-8?B?SytNV3RjbCtTb1pvTzN0T2V1c0ZsbUQyM0M2cUNMTXdPWlBZclBxMVIvZGcv?=
 =?utf-8?B?QlBWMkdGcHB6NlRNclFIWnc3K1AwS2FSVlpEeFlRekRpeER0WWx6d2FpUThz?=
 =?utf-8?B?U1o0Tks3RFJQY3ZiWFduVEY2dFdTZkxwTmFyUmszeVBtNEorWGJXTjA0SFpN?=
 =?utf-8?B?MW1tVDhrM040MmlFZlZqcnJwZnlJNlJnY1piWnErK1VSd0k4V2k5TjVBWlp2?=
 =?utf-8?B?Znp2SS83YzlBdGU0alE2TUx1a1Z4UDNWZndLS3hQZEVhbWJPMTVoUHRHV1Rx?=
 =?utf-8?B?bUVwWGZmMXlWMFVPTHF2bkdURDZuMkxqK3FyUENjeC84eUJuSndqN1hWWlNt?=
 =?utf-8?B?Q2wwZjd0S2VNWTQyc0FqOEpVdlhVWXF4eVJuc0lxWU82alV5ZVIwdmhCYTZt?=
 =?utf-8?B?U2NRVUxqbkNIZnNBM2d0a3poWlZEc21xMWhOaGYzeFFuZ1pESlRFU1BmVk5k?=
 =?utf-8?B?YzBKSHN5RVp5dHVnZ0NMS2ptRzhvWnBHT1lDemxWTzBSNlI5dFBoSTRSeWU4?=
 =?utf-8?B?V3F2eGR5ZjlQS0lnUmZ2L2RvbWxab2J1VnM3R0FRTk0wQU41eXFUTmJzWlRK?=
 =?utf-8?B?YVNPbHFZQUpTdzEzNExBQXhYSVdnbEtyZVhDcTVpOXhSbFdEWjQ4NEx5V29J?=
 =?utf-8?B?NXUwcjZxajFNU2ZHRjFvZmc4U0ZmczJZeVdjRVNpLzFjbG5kN3hIV1BKZW0x?=
 =?utf-8?B?RTVTQ280Mzg2QmZHRWhPZTNLaUVlVDZsNzNJNjh5ckw1L2xxbmJEZy9sODdL?=
 =?utf-8?B?Q1I3UE5yaWk3SG1SL2FGWkxFU1ZxdHpJdGlxZGtuTFlEMSt2YjROV3lZUTA3?=
 =?utf-8?B?T0VMeU5ybmxTWWs3UURtRjRtV1BqazlwN3lqeHM4QkVUKzREdzFyUVBEcGZJ?=
 =?utf-8?B?M2FWNlZtZG5heVEreS9tU3NudVVWMWI0OC85K0swTUlTR25WQWVHNmZRRkp4?=
 =?utf-8?B?a0owZFZGZzZoRml3MEFIZjhzT20zclhCR05aNEtXbDgyN0RYd1MycWtzYmpl?=
 =?utf-8?B?N3FWZG9OOFkva05JVStiYm9GZi85QmJjcHVpNVh1RmU5MFZUMkVJU05UOGd2?=
 =?utf-8?B?azIxa1c5T1hhTWhKUzJWZVJrc211WndUWW1aeWtYQmh1MHdCL1hGWkZ1VGRM?=
 =?utf-8?B?R3pIdGVxMnFlWkFiUS92bjdpSCtRYnBFOFdHRDdkZ3QyRjRiWkhEWXJSQi9S?=
 =?utf-8?B?VjV6SW9GVHhOcjZDZW9Md1lRbzRyOWdiaWtNOHJlcHAvNHV5RDMwYUdUWmh4?=
 =?utf-8?B?QkNUZlhBOHhuL3MrWmNGUm1KM0tWU2hWcXZuUlRzQ1VnWkVyRmV3bTU4Y2cr?=
 =?utf-8?B?dzRUcDZvV2RSUHlEVDVRVENHcHpRRzdKNUZIWkkvMW9YUVlhRXNZWi9GTXlt?=
 =?utf-8?B?aTN3a2RmTU1aRjJ5MUxxV3YraEY5RXR3Zlg2b1B5R0s5Y1BVOTlOSGYyZWkw?=
 =?utf-8?B?elNyblk0M0lNVVlDZDI5MDA4czk0VnRKZlRTaGtyT0cwVFFEQmN1cG8zUmhx?=
 =?utf-8?B?MFJ0MVNsYTIzdU1LNlEwVm9SQVpYUU1sNVp2TWt5dWFlQ014OFIvOEpqUGp2?=
 =?utf-8?B?YlJwUmE1SVN5cldwb3dMZnJJRU1UZWlocEt4TW0zd0tGZ24yMUtpQjFxVG1k?=
 =?utf-8?B?YzdFM1hmUzZtZWpJOHRueDRtbkd4dmh2ZkRNRW1WRTdwZWpNMnBkdWsvQk9n?=
 =?utf-8?B?U3d2YlZZUWZObEJYM0hVSnZQRTg0LzNnam93bnNseDFkQ3R1WTlhM2cxWXNr?=
 =?utf-8?B?MHJUUEViSFZPSmFUc0hQaE9VZ1BLNE5xQ0ZFa1VxdzBhWDNWc1FVWURrSGp4?=
 =?utf-8?Q?rAhvkv9myxs=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VmhJb0QvbzR6WDZmcU8yVEIyQzZhQTlXTkYxekdqQTBta0N2cGFJN2ltV05V?=
 =?utf-8?B?TUVpUy9ERUpINHFWcVdzVG55VWNWSy9UTC84VFBlWS9scUxZcHU2NjlHOFBD?=
 =?utf-8?B?OEJFSEVNTlkrcHZvb0VMZCtsbWxtOWl6NjZUeDVmeHdZaVFib1BocFQ0K2hv?=
 =?utf-8?B?clZMaFpoaGdNclBDa1N2YU9DRVFjYnZmdW1kVFFQMEVrNmQ3eXVNSUdacXhp?=
 =?utf-8?B?R09UWHZORnhXcHlOU1JXRnpENENVY3g1b3dBM1M2VlZZSk11OE9PUnZVdHlq?=
 =?utf-8?B?SHRTRE5aTG51REhsU1d3YitIam1HRWxZNzFPMzNuRWNXK2U4K2tjd1BoaHp1?=
 =?utf-8?B?MjA3Z0ZrUnd5S1pmdUY5VXM0WGpsZmdnWUxEQ3A5WnVaTVg0R25rcTdYRVBO?=
 =?utf-8?B?bVRPZlc2ZE8wbVk2RWhiQVZtbmhLNkVlalVDTmJZbks3VHhaRFNZN1dNdngr?=
 =?utf-8?B?Ty8yRlVzbmJGWDVwZ3Y1dFFXRXpYSlJ3SmxUMFZrTzdCWDhmMUE5WnNiRVpo?=
 =?utf-8?B?bGhNWVVzRkRIeVNucUs2ME5BaTRGWXFFOGprNVIxaE95NmVJTlQ3eGJIUUFE?=
 =?utf-8?B?Y3ZlZWpHZU1WREtwWWZ1TFZiZDBqaUtkTDZqVE90ODhXSEc3UFlkdndtK1JE?=
 =?utf-8?B?dTErczA2OEwyZk1Zd1E3NHRPZllxTk1ESmdRVWhwdGNocmMxcDA1bjdXQm9m?=
 =?utf-8?B?KytZRTAzYjhYaTk3TFowd1JDQnI3SkxDT2NxS0tUMnRiQ0hPeEIva1lpaEds?=
 =?utf-8?B?V1R4MFVJblYrUlBwZHN5TSt1UTM1WC9wQUl2N3NtWnliVGVPRmZoT1dHcW1E?=
 =?utf-8?B?T1JBcERaeFRocTNhR012TlBHeXIxaVg5andUUXBxZ3hiaTk4WnZaUFNCdUJP?=
 =?utf-8?B?SHJrbTNNdk81eUxaeWpsMzNmVkl1b0pwZTFqOVR1bmRxMDVHSldubG1RVXJ2?=
 =?utf-8?B?RXF4dSszMGpFNU9DUGJ4TTdqdWY3NnNPNmFpZlJWbnJCSmgycDg2YzBrZCtt?=
 =?utf-8?B?L1pxSnRybEEvOWNNMEt5M1JLdjVJMGxRVDNNMTZ5aXVpVjl6cjE4Zy9sdHVo?=
 =?utf-8?B?ZXdjN1dHWGhrbE95OFpqQTRvQ3RwenovWmc0bjlXMkpLd1hsTHRrVlFramRa?=
 =?utf-8?B?bkpZZ3pmczMveU1Rb0diRVZ3SVNvMHNBVnhtclN0dGZISDB1d0E5Znh3aTht?=
 =?utf-8?B?VVBFbnhTQlRyQUUrRUVDRDl0MzJSOU9VaGRsQnZhTjNtMDZBSC9WUW4xOW0x?=
 =?utf-8?B?VDNaS2l3VUJWVjNPekdlemtzMnlScXlNdUJkbHJHRVEybFN5L0t1YjN4NlJ1?=
 =?utf-8?B?azVsMGFZcTdOV3ErZ0l5V2Yyc25GSi83ZUl4aFBJUGFqUTV2OGgwSWVLTzZV?=
 =?utf-8?B?S05ld2YxR3pNYUpIK2l0WjZ6SVlDb2orV2s4SE9HZHZJU1FXY20zay9tcmEx?=
 =?utf-8?B?dGlXSkYzTFF6UHB6VFdFdmhrNjl5WGJTNjhFNzFpbnB2aEFWK2hoT3dyVk05?=
 =?utf-8?B?TEplcStMV3ViUXV5MjBKVjEzRVE2MXVBNU8vVUFIb2NZMDhIelZpYlRSUmhT?=
 =?utf-8?B?M0hFQzBvV1djaTNSNS9hdUJaTGlERWRiV3p5ZmVTQjJCY1RzK3JNTG9ackZL?=
 =?utf-8?B?YWgxNTdnSjlsMWRtWGQ1cEVSd0MrcjFVeW1mQ2g4WE1xeFN4dUdqY0xPTU1F?=
 =?utf-8?B?d1BsVGk0VWswWTFISWhUaFZna0Vsb01UMklJQ3NGV1ZPUnByYVZTTXpKMjB6?=
 =?utf-8?B?R09aWER6b3lZbmczSjV5UGZ6dzJQOVRISFNYdkMxK0RvU1JXc05EcVQwa0VR?=
 =?utf-8?B?bGxVWjJNYVVlMit0eXBCUitlM2Y5aG1mdUhUcFN1UzFtckN6ZjZTcFVTL1g5?=
 =?utf-8?B?SnJKQkhFUTg4R0R2MTdwNzdsZGs0Z1ltRXg5eHpGZWErSWVqUk1VdWlKZWFG?=
 =?utf-8?B?eDNrMlVaWDh5VklNZmpnUnpCN0tJNDdFYVlqQTlXaFc4RzVtR3Fick14N240?=
 =?utf-8?B?OWFhb2FqQnFmTTJzd1JYQlRNRDV6Z1M2Ui8zdWoya3JKdjNOcFkyTFJHR1NC?=
 =?utf-8?B?d2l4RFRKMFR1eXNaWXV6bnc5OFduNURrM1Rrd2tuY0hrY2grK0VCVjNiNmtr?=
 =?utf-8?B?ZXFCRGhCOURTSVoyaHkvakh0WDZLbEFZeFl2ais5b0Vxbk9oemN4QnlqaUtN?=
 =?utf-8?Q?YeHGcGZJsorHLTHvmqf64f8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9EFD8F4A182E564CAFAB18A0FB864EF5@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 83e4baaf-9259-4bbf-e19e-08dde421df3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2025 21:53:48.6824
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s9PI8o68ln/4xCJrr7FzeYPLC8qxU1s6SpVNosng1nzGJLf2C6Ndg9t9bPPYa3FMsJUUAdozBmKNbovGWlQm6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PPFF6F37B74B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAxMCBTYWx0ZWRfX/e1fSG5ukQXQ
 bVURgmf8SNdEnFU3lBFNlRM+BZIe22SCafWVmX4Si6eBS97ZeBMKIEesXyRty9iXkJoMN230XJ9
 RMgWHY7hDCtrZrUreRz0GH+2WUgHAj/Utrnyo+G2x/K6ZAx/PBlbRpegqjShzraIS+3C8qx+QQp
 XKLEec+ifCeqU+lqhbyh3oNUjSFj9z9Ti8BNDzNvmL2Mafu1JSMojknLp8NDBD92urJJ9IE+47y
 gkGQEJXVuPhUq9voRymaViYRZ+buZvCiNnlP3IIA3UTFX5AUDntGE/emekUe5MWpmfCMm4fbW92
 vSbeV2NCkS0/CWvFElIaT1yHtcitiDU2TLOEQEncEEjlbGd33ciW2kPImExSXHhJCdKsSzqU11x
 YKhVAVDh
X-Proofpoint-ORIG-GUID: tMDxokKWea3z-3HFYXRUnoQumSMoY5PJ
X-Proofpoint-GUID: V9FcUaQCmZg3gwz6xfXCTSsc7oFy3MQq
X-Authority-Analysis: v=2.4 cv=evffzppX c=1 sm=1 tr=0 ts=68acdb72 cx=c_pps
 a=fuPBXZG3M7Sc+qedpsXBqw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=P-IC7800AAAA:8 a=KxHa3Zix7xUVjHfBVFMA:9 a=QEXdDO2ut3YA:10
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_10,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230010

SGVsbG8sDQoNCkkgYW0gaW52ZXN0aWdhdGluZyBhbiBpc3N1ZSB3aXRoIGdlbmVyaWMvNjA0Og0K
DQpzdWRvIC4vY2hlY2sgZ2VuZXJpYy82MDQNCkZTVFlQICAgICAgICAgLS0gY2VwaA0KUExBVEZP
Uk0gICAgICAtLSBMaW51eC94ODZfNjQgY2VwaC0wMDA1IDYuMTcuMC1yYzErICMyOSBTTVAgUFJF
RU1QVF9EWU5BTUlDIE1vbg0KQXVnIDI1IDEzOjA2OjEwIFBEVCAyMDI1DQpNS0ZTX09QVElPTlMg
IC0tIDE5Mi4xNjguMS4yMTM6Njc4OTovc2NyYXRjaA0KTU9VTlRfT1BUSU9OUyAtLSAtbyBuYW1l
PWFkbWluIDE5Mi4xNjguMS4yMTM6Njc4OTovc2NyYXRjaCAvbW50L2NlcGhmcy9zY3JhdGNoDQoN
CmdlbmVyaWMvNjA0IDEwcyAuLi4gLSBvdXRwdXQgbWlzbWF0Y2ggKHNlZQ0KWEZTVEVTVFMveGZz
dGVzdHNkZXYvcmVzdWx0cy8vZ2VuZXJpYy82MDQub3V0LmJhZCkNCiAgICAtLS0gdGVzdHMvZ2Vu
ZXJpYy82MDQub3V0CTIwMjUtMDItMjUgMTM6MDU6MzIuNTE1NjY4NTQ4IC0wODAwDQogICAgKysr
IFhGU1RFU1RTL3hmc3Rlc3RzLWRldi9yZXN1bHRzLy9nZW5lcmljLzYwNC5vdXQuYmFkCTIwMjUt
MDgtMjUNCjE0OjI1OjQ5LjI1Njc4MDM5NyAtMDcwMA0KICAgIEBAIC0xLDIgKzEsMyBAQA0KICAg
ICBRQSBvdXRwdXQgY3JlYXRlZCBieSA2MDQNCiAgICArdW1vdW50OiAvbW50L2NlcGhmcy9zY3Jh
dGNoOiB0YXJnZXQgaXMgYnVzeS4NCiAgICAgU2lsZW5jZSBpcyBnb2xkZW4NCiAgICAuLi4NCiAg
ICAoUnVuICdkaWZmIC11IFhGU1RFU1RTL3hmc3Rlc3RzLWRldi90ZXN0cy9nZW5lcmljLzYwNC5v
dXQgWEZTVEVTVFMveGZzdGVzdHMtDQpkZXYvcmVzdWx0cy8vZ2VuZXJpYy82MDQub3V0LmJhZCcg
IHRvIHNlZSB0aGUgZW50aXJlIGRpZmYpDQpSYW46IGdlbmVyaWMvNjA0DQpGYWlsdXJlczogZ2Vu
ZXJpYy82MDQNCkZhaWxlZCAxIG9mIDEgdGVzdHMNCg0KQXMgZmFyIGFzIEkgY2FuIHNlZSwgdGhl
IGdlbmVyaWMvNjA0IGludGVudGlvbmFsbHkgZGVsYXlzIHRoZSB1bm1vdW50IGFuZCBtb3VudA0K
b3BlcmF0aW9uIHN0YXJ0cyBiZWZvcmUgdW5tb3VudCBmaW5pc2g6DQoNCiMgRm9yIG92ZXJsYXlm
cywgYXZvaWQgdW5tb3VudGluZyB0aGUgYmFzZSBmcyBhZnRlciBfc2NyYXRjaF9tb3VudCB0cmll
cyB0bw0KIyBtb3VudCB0aGUgYmFzZSBmcy4gIERlbGF5IHRoZSBtb3VudCBhdHRlbXB0IGJ5IGEg
c21hbGwgYW1vdW50IGluIHRoZSBob3BlDQojIHRoYXQgdGhlIG1vdW50KCkgY2FsbCB3aWxsIHRy
eSB0byBsb2NrIHNfdW1vdW50IC9hZnRlci8gdW1vdW50IGhhcyBhbHJlYWR5DQojIHRha2VuIGl0
Lg0KJFVNT1VOVF9QUk9HICRTQ1JBVENIX01OVCAmDQpzbGVlcCAwLjAxcyA7IF9zY3JhdGNoX21v
dW50DQp3YWl0DQoNCkFzIGEgcmVzdWx0LCB3ZSBoYXZlIHRoaXMgaXNzdWUgYmVjYXVzZSBhIG1u
dF9jb3VudCBpcyBiaWdnZXIgdGhhbiBleHBlY3RlZCBvbmUNCmluIHByb3BhZ2F0ZV9tb3VudF9i
dXN5KCkgWzFdOg0KDQoJfSBlbHNlIHsNCgkJc21wX21iKCk7IC8vIHBhaXJlZCB3aXRoIF9fbGVn
aXRpbWl6ZV9tbnQoKQ0KCQlzaHJpbmtfc3VibW91bnRzKG1udCk7DQoJCXJldHZhbCA9IC1FQlVT
WTsNCgkJaWYgKCFwcm9wYWdhdGVfbW91bnRfYnVzeShtbnQsIDIpKSB7DQoJCQl1bW91bnRfdHJl
ZShtbnQsIFVNT1VOVF9QUk9QQUdBVEV8VU1PVU5UX1NZTkMpOw0KCQkJcmV0dmFsID0gMDsNCgkJ
fQ0KCX0NCg0KDQpbICAgNzEuMzQ3MzcyXSBwaWQgMzc2MiBkb191bW91bnQoKToyMDIyIGZpbmlz
aGVkOiAgbW50X2dldF9jb3VudChtbnQpIDMNCg0KQnV0IGlmIEkgYW0gdHJ5aW5nIHRvIHVuZGVy
c3RhbmQgd2hhdCBpcyBnb2luZyBvbiBkdXJpbmcgbW91bnQsIHRoZW4gSSBjYW4gc2VlDQp0aGF0
IEkgY2FuIG1vdW50IHRoZSBzYW1lIGZpbGUgc3lzdGVtIGluc3RhbmNlIG11bHRpcGxlIHRpbWVz
IGV2ZW4gZm9yIHRoZSBzYW1lDQptb3VudCBwb2ludDoNCg0KMTkyLjE2OC4xLjE5NTo2Nzg5LDE5
Mi4xNjguMS4yMTI6Njc4OSwxOTIuMTY4LjEuMjEzOjY3ODk6LyBvbiAvbW50L2NlcGhmcyB0eXBl
DQpjZXBoIChydyxyZWxhdGltZSxuYW1lPWFkbWluLHNlY3JldD08aGlkZGVuPixmc2lkPTMxOTc3
YjA2LThjZGItNDJhOS05N2FkLQ0KZDZhN2Q1OWE0MmRkLGFjbCxtZHNfbmFtZXNwYWNlPWNlcGhm
cykNCjE5Mi4xNjguMS4xOTU6Njc4OSwxOTIuMTY4LjEuMjEyOjY3ODksMTkyLjE2OC4xLjIxMzo2
Nzg5Oi8gb24gL21udC9UZXN0Q2VwaEZTDQp0eXBlIGNlcGggKHJ3LHJlbGF0aW1lLG5hbWU9YWRt
aW4sc2VjcmV0PTxoaWRkZW4+LGZzaWQ9MzE5NzdiMDYtOGNkYi00MmE5LTk3YWQtDQpkNmE3ZDU5
YTQyZGQsYWNsLG1kc19uYW1lc3BhY2U9Y2VwaGZzKQ0KMTkyLjE2OC4xLjE5NTo2Nzg5LDE5Mi4x
NjguMS4yMTI6Njc4OSwxOTIuMTY4LjEuMjEzOjY3ODk6LyBvbiAvbW50L2NlcGhmcyB0eXBlDQpj
ZXBoIChydyxyZWxhdGltZSxuYW1lPWFkbWluLHNlY3JldD08aGlkZGVuPixmc2lkPTMxOTc3YjA2
LThjZGItNDJhOS05N2FkLQ0KZDZhN2Q1OWE0MmRkLGFjbCxtZHNfbmFtZXNwYWNlPWNlcGhmcykN
CjE5Mi4xNjguMS4xOTU6Njc4OSwxOTIuMTY4LjEuMjEyOjY3ODksMTkyLjE2OC4xLjIxMzo2Nzg5
Oi8gb24gL21udC9jZXBoZnMgdHlwZQ0KY2VwaCAocncscmVsYXRpbWUsbmFtZT1hZG1pbixzZWNy
ZXQ9PGhpZGRlbj4sZnNpZD0zMTk3N2IwNi04Y2RiLTQyYTktOTdhZC0NCmQ2YTdkNTlhNDJkZCxh
Y2wsbWRzX25hbWVzcGFjZT1jZXBoZnMpDQoxOTIuMTY4LjEuMTk1OjY3ODksMTkyLjE2OC4xLjIx
Mjo2Nzg5LDE5Mi4xNjguMS4yMTM6Njc4OTovIG9uIC9tbnQvY2VwaGZzIHR5cGUNCmNlcGggKHJ3
LHJlbGF0aW1lLG5hbWU9YWRtaW4sc2VjcmV0PTxoaWRkZW4+LGZzaWQ9MzE5NzdiMDYtOGNkYi00
MmE5LTk3YWQtDQpkNmE3ZDU5YTQyZGQsYWNsLG1kc19uYW1lc3BhY2U9Y2VwaGZzKQ0KDQpBbmQg
aXQgbG9va3MgcmVhbGx5IGNvbmZ1c2luZyB0byBtZS4gT0ssIGxldCdzIGltYWdpbmUgdGhhdCBt
b3VudGluZyB0aGUgc2FtZQ0KZmlsZSBzeXN0ZW0gaW5zdGFuY2UgaW50byBkaWZmZXJlbnQgZm9s
ZGVycyAoZm9yIGV4YW1wbGUsIC9tbnQvVGVzdENlcGhGUyBhbmQNCi9tbnQvY2VwaGZzKSBjb3Vs
ZCBtYWtlIHNlbnNlLiBIb3dldmVyLCBJIGFtIG5vdCBzdXJlIHRoYXQgaXQgaXMgY29ycmVjdA0K
YmVoYXZpb3IuIEJ1dCBtb3VudGluZyB0aGUgc2FtZSBmaWxlIHN5c3RlbSBpbnN0YW5jZSBpbnRv
IHRoZSBzYW1lIGZvbGRlcg0KZG9lc24ndCBtYWtlIHNlbnNlIHRvIG1lLiBNYXliZSwgSSBhbSBt
aXNzaW5nIHNvbWV0aGluZyBpbXBvcnRhbnQgaGVyZS4NCg0KQW0gSSBjb3JyZWN0IGhlcmU/IElz
IGl0IGV4cGVjdGVkIGJlaGF2aW9yPyBJIGFzc3VtZSB0aGF0IENlcGhGUyBoYXMgaW5jb3JyZWN0
DQptb3VudCBsb2dpYyB0aGF0IGNyZWF0ZXMgdGhlIGlzc3VlIGR1cmluZyB1bW91bnQgb3BlcmF0
aW9uPyBBbnkgdGhvdWdodHM/DQoNClRoYW5rcywNClNsYXZhLg0KDQpbMV0gaHR0cHM6Ly9lbGl4
aXIuYm9vdGxpbi5jb20vbGludXgvdjYuMTctcmMxL3NvdXJjZS9mcy9uYW1lc3BhY2UuYyNMMjAw
Mg0K

