Return-Path: <linux-fsdevel+bounces-54180-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A02CAFBCD5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 22:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A55DF16F3EB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 20:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98EA421FF53;
	Mon,  7 Jul 2025 20:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rQrpcWnP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835C11F3BB5;
	Mon,  7 Jul 2025 20:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751921519; cv=fail; b=Lt0lFZoPg30J6kblLVFpuL177I9Pn2blJLJbVSEW/lLKnI/OjNYrKUDDtxaPoWqRIRdU6+m9s0nWZKsYbdLYyHczeU4j7E8Fu5lu4ARTwdGXbIyjPjUG8GpvYgedinS0q6FC+tKHDkvrsU6vE9ElpNT/yPUUMA/lDaew4FTN+Jw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751921519; c=relaxed/simple;
	bh=coD3UsTIQA69U5IpEVQ5fA/6F5OLIQAvQ6oYrUyTGC8=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=LXPqH1prejdU1Zi5JxV4gMf0dHICEI0jlpW7LAGDuX4VonU7izBkTOQrmZdWZmSp5om2t9KXyXNM4xW9PB7BHiEzz10z6qPuZBtH4YBqbVvXv+KSMez4T3N5RLwM6RUNzuQR47pDBA70CQeeE/rC4ZyKOqEZb0UBrCaZhaJOfYM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rQrpcWnP; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 567Ia8N8002107;
	Mon, 7 Jul 2025 20:51:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=coD3UsTIQA69U5IpEVQ5fA/6F5OLIQAvQ6oYrUyTGC8=; b=rQrpcWnP
	OpPAb1tpaW4Gf/cw9X2Wn+gY74UpqABYAn2Z9QusDLeMQfUlT0ehHupPGiQUEjuw
	SGL/kEgGHDSwKUJVp8CyBXchWSqk/ZOz7NAWnZyOR+O3dpmeMaKZ4WzrBewi4hDa
	0ti9xaWV84lhFR93rob/S1r6UHg3u/qdoP3BRIBTfII9D6dDITlROTABoVUbvcFA
	SXtsV0i5kh2qazoYYIJwlRTed5OzVddFYRSbjo3n24syuv06caf7By7jF777sFBz
	vfWNPQPP131kocGK58e/UZqOTw04qt5b8nP5CQIgj3daahwia9lUhvlWS+B8lD3h
	Y9uutJGigZ1kzQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47ptjqukvn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Jul 2025 20:51:49 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 567KndNF012268;
	Mon, 7 Jul 2025 20:51:48 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02on2054.outbound.protection.outlook.com [40.107.96.54])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47ptjqukvj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Jul 2025 20:51:48 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sH5wWX1Ob9jmYLBGzVRydJmUC0jjY4IBLI9AN9uysSadetrELZAASOvZ/S3DU6oWvdVWUa0C9PmwrjyMcCWi9sLZb5ym/kUdYaNq3IyjMjRpdl6I1u4fEaX1Gx5/dppadcMnagyYVsiFhVt8jxOrKsa7YrxvPvxkq/68W9+TBmtuYlk8SPhTBXyj3n+AoikWzLpdCiTK4sL6WYgQUuHHTdzoyzLL/F5wdBQJ+0jsYMc5te4nxEmqrhEXEqehUnY2tTjgdGtPyrdUVICVW0ntndA55694LcyRlNDl8/q08IDFHUxWH8fES4iun3jgrC+VTk2plGTSFIw6eJM4KcC+QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=coD3UsTIQA69U5IpEVQ5fA/6F5OLIQAvQ6oYrUyTGC8=;
 b=wXQATTgl3GGE+F2R6/ggzuodHzKDUbGXM7fZPH6isH3zU478gYc8KTl89wbs4QbSYa0yeUWQcS1jLyX/MzUZr0yOTF4O6BPcMfSlHG+0KofddGuo1JdlKdoSD28DjqOd03UY6F7gpZR4qT2scdCp/DmWUe2XcQyUcakuChzMx4cMw77xzCE/m3CKeIjFXNd/9GAV5q99YSkmY8Wh6XcCrBvb494ciT+QQC36hwcxEtBmyghfGOG9dFbEAw726onD7WA6QKv+vk60WVPpnx+UL02lYpPU5n2RBCiudPcS/WJz8vDfmmKXI0gpE8YOLDfvA1RTdbipZlTl/y6QiHTZyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by PH7PR15MB5805.namprd15.prod.outlook.com (2603:10b6:510:2b0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.22; Mon, 7 Jul
 2025 20:51:46 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%7]) with mapi id 15.20.8880.026; Mon, 7 Jul 2025
 20:51:46 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "willy@infradead.org" <willy@infradead.org>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>
CC: Alex Markuze <amarkuze@redhat.com>,
        "ceph-devel@vger.kernel.org"
	<ceph-devel@vger.kernel.org>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Patrick
 Donnelly <pdonnell@redhat.com>
Thread-Topic: [EXTERNAL] Re: [PATCH] ceph: refactor wake_up_bit() pattern of
 calling
Thread-Index: AQHb732lMTah+obSE0CYHsKCfvIFyLQnIuqA
Date: Mon, 7 Jul 2025 20:51:46 +0000
Message-ID: <69ed72dc0c27cd14a8fd6dcf8bf39ddd74a19185.camel@ibm.com>
References: <20250707200322.533945-1-slava@dubeyko.com>
	 <aGwtzNKatYxN1U7p@casper.infradead.org>
In-Reply-To: <aGwtzNKatYxN1U7p@casper.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|PH7PR15MB5805:EE_
x-ms-office365-filtering-correlation-id: a4504339-b925-41b3-e269-08ddbd98166c
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dGdNby8rWWJKTTM1cDRwZlRlSkpLaTZqYUpoanpUV2lSL0ZqeEtrdFIxcXpE?=
 =?utf-8?B?alAyYy9SS000czZpbFJUZjZFME53NFVaNG1QMG5icGJlcW03NHJ1TVVOTnBF?=
 =?utf-8?B?azhQRkhMWDNHUldtRjlNc0toNTZmOGR4UWs5bDV2Z2ZMa0cxOFkyOWlVSGVY?=
 =?utf-8?B?Z2VYdmF6NFlvQU5IcEJNVTY4UHAraGg3amd2MzR1YTJDc1M1QkwxN08zdXB2?=
 =?utf-8?B?aUtMY3VSMm1naFhEeDl0Y3Q0L0tPeHNHb2Vrd1M1dEJ6WG5Hb3pEMXRaOWda?=
 =?utf-8?B?bEdScHc5ZWFLSWY2YW5Wa3VGdklKL1FGTmZaNU03aC90Rk1UMTRyZXhtM2FW?=
 =?utf-8?B?SkVEUzI4MkJITFhMTWVOVkV6NlgvWFpKcHBZd2JLMjZTamJJejRaZnRxa2Ry?=
 =?utf-8?B?Y3hmK2NYaG55d21ZcEk0d3YzNmJ2dlMrU2hJRU9qSTJQS3pXRHBralZyTjBa?=
 =?utf-8?B?Y1ljbU9FRSs0SFAwUjBDVmxOM2JBckFJaWFsMGNQTXptRTVMQ2ZlR2hHcUUr?=
 =?utf-8?B?M2pTbVdtQ2VXTktjQVZZRUJmSnh0dzhFRXc5Y1plbm5iMHZxZEhBQnJtQlIy?=
 =?utf-8?B?eFZqelFwODNWL1JOSG1XYUZQSkVTVVN1ZFlxTHR5RVNxVnFqMFIvY2RmSG92?=
 =?utf-8?B?QlZoRjhRR1BsS0pOVHptM2owSFBFQ0FGZk1xQXE0L2lmNkJjN2xnR2RvSDVq?=
 =?utf-8?B?WmNock1oaDM5N3A4WW9WYnY0eVpQeGVmNzEvSnBCS2h5eGVIVlFYSndneDhM?=
 =?utf-8?B?ODdtWldZWDhMZmVyeVlsZXFSVzRFUWtZTmxURExrZm9lUEk2dTd4c3gvVDBJ?=
 =?utf-8?B?UEVVaUxUWGVVa3VNdFhlSWJsSlRFaDk4RC9uNUZkZUxVR0FvVGV5Rk9xWmxw?=
 =?utf-8?B?dXRUeTl4a1ZNMXBQVFRKSC9DaWpkZThOTWxUbGFOY0lPNWZ3NHJ2TUwrZzlh?=
 =?utf-8?B?aFRaUVdDQlJoRzlTamNpcFhYVDhxQ0lhcmxXMHNFSEZOVlk4cWpadldOQnhr?=
 =?utf-8?B?SEdSamczaWpuTHRFbE56azFJNDFwWWJhQ3ppZ1ZMcWxRWGZVank0eVhZbDRS?=
 =?utf-8?B?SXJFNXkxS1psU2gvbWNHVTQ5d3hKTW9hVTA1QkN0TW9TRlUyMzVXaU9wM09u?=
 =?utf-8?B?TzhDK29nVzBpM1ltSllXZXFBZEF5QTZDWllYb3VSNEVrZlVnZ2pmQUJDUmpa?=
 =?utf-8?B?RW95KzVFN2Q1MVdDZE9yRWllblZVWkQ3WjlQa1ZneEs3cXdQZXVlUlQrcnVS?=
 =?utf-8?B?QkRicVViTnVnRDFERjc1SDdkZDkxUk5FQ29VbHBHSmhWSEwxWG11bmZXL0wr?=
 =?utf-8?B?M284Y2E1NFM2d3hKSWExYngrMHpvcG5IZkVVNnJxY01PZHgwdUNZU1RvSzJ0?=
 =?utf-8?B?TmIzMjI3SjZTcGt1Ym4xc0NGMVNjVGNsMUF4S29JbG90akVHTmV2Smd6U2VZ?=
 =?utf-8?B?RmM4dnYwZWsrZEFzRnBXbFgzUUZLK0h6ams4cFc4OFAzbGpQRE41blAxRytm?=
 =?utf-8?B?ZWxIWENFS3JJY0pRSDNIWVNTOTNlUVhVaXJhZkszQWtiYmR5U2xISzNSTkt3?=
 =?utf-8?B?eFlFa2YyMlllOU9KbUdPSGxCOGIzdHNaYW9sa2Yyc0ZvSTNURjBCNC83L0xT?=
 =?utf-8?B?bnJvQjloOEFsMGFjTzhrT1ZuQmlLUlFPV3BqUWRmMEVZbXNxN0V0U21yd2Z4?=
 =?utf-8?B?OSsrSHU4SXIvTjlvQnlMS0owWDRMZ3dvd1hVeHYzdFd2S2RqY2o1UlJVcFho?=
 =?utf-8?B?VGJtNlpOSFFmTDNsdjVjRmY1bTV0QWsxREtraTE3RCtNVTZ3Nk9iaTBRaXN2?=
 =?utf-8?B?T1lLMTR5VnByMXk3WUNaNXFRWGZCWWFoS2NCWmgyS0thRWs2Z0FpYTBTVTJs?=
 =?utf-8?B?K3AwNjRKWjhrdFNpUTdDaFY3TVlId0F1TExKdERSbEFEZHZMS2JtR2ZhNHpE?=
 =?utf-8?B?ZVI4TWJpcUhQTU5kTEZVYm1NalJtaXU1Q0dIdVVDQTVHTkVkT3lmMENXNG8y?=
 =?utf-8?B?VElSbG9BNzR3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?KzJtUm9zWnUxQTgxNi85cWxlWXVOcFhPMFVYVkJXc2ZRbGtMZHdTMVdFaG5S?=
 =?utf-8?B?Vk1oZWxmMzhlZ3Y5cU5yTjkxc2lwU2xDeDUyWHd6bnRUT2hESUU1WHZ6NXNt?=
 =?utf-8?B?UTEwN2JZakEvazJjK09RQTRHdU1xc2RZWVBkSUVBRWxSbWJ6VjJsdkIzOGd2?=
 =?utf-8?B?eDdDUTJXMzBiZjBibjdxZW1sZTcvR05Fc0R0cmFrbWxhWXFqU3gvQmxGeXZ1?=
 =?utf-8?B?MFN5NTVwd1ZHbzA1L3djVEhyd2U0ODdubDFGNHpaRWZud0cyOVF3UW5CNkZO?=
 =?utf-8?B?aUMyb1VGdXl1dDJNWWRsRklOUlovbE5hbTN4UnluVjl0aFdpN25KYmhUbE85?=
 =?utf-8?B?UTl0Z1hvNVllbEZFWVNFK2NVTDhVVG9RbUhEa2JFMlAyUjh3bVRJZWtXamkr?=
 =?utf-8?B?T0g5bTZjbE1EVDBNTW9PbGtiRnBnem9Vb1phTHJuUGJrTHh2S0dGOTRoYWJU?=
 =?utf-8?B?MkEzTnB3c2NyRUtpL0JmRzRLNFZLYXVnOEtaQjJjVWREUjNDVmFKOGJYUktl?=
 =?utf-8?B?OHZzdWhqVGJlSjl4RFdpN3laSGpLdC9GQVpYZzVXUHFUOUVkTWd4bU9sYjlo?=
 =?utf-8?B?Q1pWb1RWK1djZ0VLWGovWENOWE5EL1V2cFdvSHRJTjlrQWVOMkZ3cVpxSnZt?=
 =?utf-8?B?aUd3UXJobTVwM1UxYzBZYTNodkpSWWhJUFJ0RzBwYmlmcXFyc04zdWw1YkRn?=
 =?utf-8?B?QkhoVlpSY1RMMURsZDJjNmI4TU0xWnAxc1duYUkzTnQ2L0M3UzIrNUg5MXp5?=
 =?utf-8?B?RkhzWThHYkxDVGQ4QmhMRWtRQU1XOGZPVUJXdXlQMSs3MGJRSnlGemFFZ21n?=
 =?utf-8?B?V3hkaTk2ZXlwTFFSMkxwYkdVSUVGTkZQZHEyT3RWWFVoUzIrNDF0a0RWditT?=
 =?utf-8?B?OFN2SVBpWVJRb1h3UldJdWxSS0NiZWdaS2Erd0NVdTBCZWNIZGZpZjRvSlVz?=
 =?utf-8?B?Z0VzNWQ0b1o4TFVJVEptbS83MUlLMjFudzYvMXB6NDExeXYyN1BlUUQ1TkJB?=
 =?utf-8?B?RWhTMGpmVEhBMkQzZlRaZHpiaWVtZlRyNGYyNXgzd3d3UTBkQWNXbWdZaVRk?=
 =?utf-8?B?alFjMWg0U0hGaDdieXBjNUFoYWtQazBSV1JkdnFVMUdqTHg5M1RLRjlFSDNG?=
 =?utf-8?B?RnhMWklDN0NaRUp3ZnFuK1FoREQ3T3h1dnU5dVJ5eHYwV3RyQzBHT3NObUJC?=
 =?utf-8?B?a2tVbUt2UC8yajBwSWhkZW5IMEdDRGlhWlc2bmowNVZpeTUxMExhdVl0M2Ns?=
 =?utf-8?B?REI3MVMvUWlCT3doa2s5TFU2TFdpRkNHOXNkVUk4Zko0UXNRTnNJMU5kakFP?=
 =?utf-8?B?TkUvUEp5Q3VoWHc5ZS9FRUpXd2tRWUVMV1kyQ1NOWGd0S0NGTHhjMFJLVzFB?=
 =?utf-8?B?b2ZHbnBvZXpGTk5Hd3JIYVVLaDkyakxSSUw0Tm9XZlFBQVI0SnRMQ0Q5RkVB?=
 =?utf-8?B?MExGZUNGQm1kbFBiNXJHQXdjcVRIOExvYjdCWnFIdzBGclY3Rk5EdVNMbXJI?=
 =?utf-8?B?enI5bmJGemtxbEk3dlZIQzZxY0RPQndRck1wOEtWUXVUeExkRHU0TEd5TXVz?=
 =?utf-8?B?eVIyVUcrcjFmSWhCZVBZRUFrRDZseTJDTThUV2M1N1EwMlpQZjBTVEZuUzJD?=
 =?utf-8?B?c2M3dVR1YSs3SERNQTZSN0hWNCs5dllWRXlIR2tBaVZXVlVMQTNMS2dzK3BY?=
 =?utf-8?B?VG1NUDd0WTlaeUlwK0FSSlV0anQ4MWlLWE8xU25hVExnT0Zac1BldXVpMHpa?=
 =?utf-8?B?TnYvQTFycDljNHlseGFueE5nUGMvQk0vOWNCQSsrUFllamNKVWR2bHNuRkV1?=
 =?utf-8?B?T01IZ1doZVcwa0xSTE95a0ZLTDBTM0xmUy9UVXFocGRleU5nb3BGdzY3aTMy?=
 =?utf-8?B?NzFmaUZzcDFPNXkvOHhZeEk2Y1lVOUtiUFh2YVBvdmR4S2dldkhCMFlUWlRL?=
 =?utf-8?B?c1F1YjZLR3JxdnJQV1pvc3c3dW9PY2pCcVhMS2ZQVmFLWkdKNmZPdVFHWVJu?=
 =?utf-8?B?ZkFTSjNoS1B0dGtDRjZ2am5heGloaGFxbjdKMjVUYzRkMDlZTEsvQmZlVk9H?=
 =?utf-8?B?cTIxbEZQZEtqMTAvN1kzVm1xdHZ3a2xNYzFUbWEySEozYW9meGtXM0dueGJE?=
 =?utf-8?B?NWNwZ3lwU2VqcVROcWVLYXpZM1lvTFVSdkQzTEc3dDYzeVZJVFREa2pDbTBR?=
 =?utf-8?B?VlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C498718A4A0F5646A9B171FC068BDAAF@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a4504339-b925-41b3-e269-08ddbd98166c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2025 20:51:46.5164
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6s35SljrhgahaEMttDhne5NsBPgAd6RvO57jeoCfXMM7FLWH3/iSXEZoBTG9Xbe0axYSq7OcSyfNM3sHmmWWjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR15MB5805
X-Authority-Analysis: v=2.4 cv=GL8IEvNK c=1 sm=1 tr=0 ts=686c3365 cx=c_pps a=pPA9pUlqwZqWzjgWBQ0dYA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=0PjYYyD39LnDYTuQfiAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: AiKjoJh2C-_P47oSudQwPI96yCGYj2Yd
X-Proofpoint-GUID: 845NjSWqGcNUQuHdbNWEo819K-uYi3bX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA3MDEzOSBTYWx0ZWRfX/IInXEMbX2WQ CB6ud9wQm15uScWQvOM2+l7jhG50nlLUavCthkVHYQgRw+9WZL+KKDd5ggskqvUYLBJNTafqmZG v/7x8rgLVIEJqEa8QbBRK2FHXhixn7jPDa+mBC9SVXE4sHEwvtElrsu7HxDKipxRwiqVz8kTCeR
 yUKBYvK4dxiI1ZgLTqTOa+dwLlj4eCl1ISwFHJHiwU2/Jvi4u6rClE8TRMLv9vK6i2hm05p970+ xbdzu/eEHGV2jHOk836DoHswhzQub1PJBX0ODJOWjrV6UV5YPlMpRsYi8u/kjFxMpV2/OmxfJ4i EN3IEmMWJctWMggc5KhqWLcME0lCRWeBUP64AfAYd4IyEseFmNEabRCHOcZFRMQbus6icZmdCF4
 3GlHp4S4gXYjPG5zRKv0yvP1qAqewEDvp/suw8cr/B0FDY0M653G6UDVO3Au/ykP0xZvd70m
Subject: RE: [PATCH] ceph: refactor wake_up_bit() pattern of calling
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-07_05,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 clxscore=1015 impostorscore=0 suspectscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507070139

T24gTW9uLCAyMDI1LTA3LTA3IGF0IDIxOjI3ICswMTAwLCBNYXR0aGV3IFdpbGNveCB3cm90ZToN
Cj4gT24gTW9uLCBKdWwgMDcsIDIwMjUgYXQgMDE6MDM6MjJQTSAtMDcwMCwgVmlhY2hlc2xhdiBE
dWJleWtvIHdyb3RlOg0KPiA+ICAJc3Bpbl9sb2NrKCZkZW50cnktPmRfbG9jayk7DQo+ID4gLQlk
aS0+ZmxhZ3MgJj0gfkNFUEhfREVOVFJZX0FTWU5DX1VOTElOSzsNCj4gPiArCWNsZWFyX2JpdChD
RVBIX0RFTlRSWV9BU1lOQ19VTkxJTktfQklULCAmZGktPmZsYWdzKTsNCj4gPiArCS8qIGVuc3Vy
ZSBtb2RpZmllZCBiaXQgaXMgdmlzaWJsZSAqLw0KPiA+ICsJc21wX21iX19hZnRlcl9hdG9taWMo
KTsNCj4gPiAgCXdha2VfdXBfYml0KCZkaS0+ZmxhZ3MsIENFUEhfREVOVFJZX0FTWU5DX1VOTElO
S19CSVQpOw0KPiANCj4gU2VlbXMgbGlrZSB5b3UncmUgb3Blbi1jb2RpbmcgY2xlYXJfYW5kX3dh
a2VfdXBfYml0KCk/DQoNCkRhbW4sIHdlIGFscmVhZHkgaGF2ZSB0aGlzIHByaW1pdGl2ZS4gOikg
TWFrZXMgc2Vuc2UgdG8gcmV3b3JrIHRoZSBwYXRjaC4NCg0KVGhhbmtzLA0KU2xhdmEuDQo=

