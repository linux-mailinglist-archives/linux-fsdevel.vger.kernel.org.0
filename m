Return-Path: <linux-fsdevel+bounces-33959-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC29D9C0F67
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 20:53:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D112B1C22A4B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 19:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51CE1217F4A;
	Thu,  7 Nov 2024 19:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="XvsjMBui"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430C6185B56;
	Thu,  7 Nov 2024 19:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731009219; cv=fail; b=DgFfga5t5Yn6uwCPRcbMxrMmrcprAd+bjnCOchsND1Hy2r3ZsoimryRkL6M4xwOZmKmiIqEM/ieMP/hpV7ZyqhCA6t20k4PM1/DiIzffiv185TzAun10/0RO2P/hWV06ztOBviBMl0FGGu0e7XSJ6UoVO6fgIY5Kma+OWs5Yv/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731009219; c=relaxed/simple;
	bh=My2RpGZrEewWI92unSPPrav0msKRp58/zAADtUbEzRg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ji71YNXaSD6NhM8VGqg8Uqls2IVjrK0eNgWxwpOr0PYmsnXWqx6IZiiMZYY7xbNiOVbFOZf0zHea0BoQZm8yTKJ1Wsih+D5P5sgajQDpAwoHVaz0wdLeVQveomT2ZaJoU/dSfN4NKtrv2An8f4XO4GexHmgp7vsXIAuj10iXEYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=XvsjMBui; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7ImPe1018725;
	Thu, 7 Nov 2024 11:53:37 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=My2RpGZrEewWI92unSPPrav0msKRp58/zAADtUbEzRg=; b=
	XvsjMBuis7XeoNpFt3yEcdzHvbHr4KY0MkRKAnDcx+UugxW9Iwwy4ZAQfQsdq8cu
	810RAUpVxuhFLJ8QO+Pr9IibUHM+ZFnTSzhClkisTmSfqvfbmPdB+Js8L9YcwMag
	kMUbwfb18T69/rEZTgLkFVG4luYduyfnmB0TGvPjqCdHgiGJmtv+oCL6L6h9lO+i
	22jUXEQ9iFS+zaRx82s08AYHdkwD5Sjqm3SlnWkAvMkzoDE4Qln/kuy7x2zTGaQj
	Kk7zjjr/DzfcCg2Zk+OcA8Tc7ZyBAuauSyrhdIC0eY26eYn7mYT0BDngwW1t+8fO
	5/9VrzOZwTKPp15vskViOw==
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 42s12shp3j-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 11:53:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GYuX1HIGWRWczFGhLwTzznvRNlZHRRu0ZmTLgyyJUpzAlHyK8/vWlBFm29l8Z7e0cMu64yATKbxNO2FLgpYcYorXYH1UVh6wOczGUf7qx7iUv66aQJqWfy8yFe8z8hV+/AYdofvaqoZqBRfuWbglVEDCGdWRy1/7deeOGOJPFA7LVIdFXR5eYXkVkgBaFFOXCVcpWVzkpJ2PaZ3LhmzHLc+h6x2qw+fI2tpu9JR6bwXW/KU/N6PtTbGuTRNU16/icsludm+knnxTWMndBem2Wzz34eZ+UpHgOpvdYLoI5kTHfmd5MwBalkrj6az8BB1Lr7pkyxaSnYHzKdqhFvLcdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=My2RpGZrEewWI92unSPPrav0msKRp58/zAADtUbEzRg=;
 b=JS+bwadbfCed5dJjn+mL45oaWMXd1uVua5nRudzxwxsIdfe16cj0+7rsATuW4J9W2C7dycma5Rw4aGmcwBTGvAqdtQk3RObjKMBECOsGziOP8sBDEVdAG+UXoB4JRKMqsfmIv0ll5w5HJ0aspuVBoE4l/bdi/6Z6eQqShRaQHgxBvV+aTJSlGZeH40U2RikXO9NSaj11/VsFRGsRSe9gmeEGHoATZ0Zfc2/qWYvcLMnZv63IhKVakS75QWvykrIOD71qgm+PBRRBl8Cqebn0ZTcSUzHTiIKRpiq5tK1WTaaH1teSdURTJph9b+WBEXfxAJSn6jOpsTCSnd6PDmPjyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by CH4PR15MB6697.namprd15.prod.outlook.com (2603:10b6:610:221::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Thu, 7 Nov
 2024 19:53:33 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610%3]) with mapi id 15.20.8137.019; Thu, 7 Nov 2024
 19:53:33 +0000
From: Song Liu <songliubraving@meta.com>
To: Amir Goldstein <amir73il@gmail.com>
CC: Song Liu <song@kernel.org>, bpf <bpf@vger.kernel.org>,
        Linux-Fsdevel
	<linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel
 Team <kernel-team@meta.com>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "eddyz87@gmail.com" <eddyz87@gmail.com>,
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
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [RFC bpf-next fanotify 5/5] selftests/bpf: Add test for BPF based
 fanotify fastpath handler
Thread-Topic: [RFC bpf-next fanotify 5/5] selftests/bpf: Add test for BPF
 based fanotify fastpath handler
Thread-Index: AQHbKlgxUTztwWHbLU6QH8kadsRF/rKrtrcAgACR/gA=
Date: Thu, 7 Nov 2024 19:53:33 +0000
Message-ID: <DAAF8ED0-42E2-4CC6-842D-589DF6162B90@fb.com>
References: <20241029231244.2834368-1-song@kernel.org>
 <20241029231244.2834368-6-song@kernel.org>
 <CAOQ4uxjDudLwKuxXaFihdYJUv2yvwkETouP9zJtJ6bRSpmV-Kw@mail.gmail.com>
In-Reply-To:
 <CAOQ4uxjDudLwKuxXaFihdYJUv2yvwkETouP9zJtJ6bRSpmV-Kw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|CH4PR15MB6697:EE_
x-ms-office365-filtering-correlation-id: ef8c200a-5ade-4caa-e27f-08dcff65dc55
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Q1NhYTE4UytIcUMyak1GSGtCeEFaK3pjWGMwc3ZiUWNlMU9WMVpQbHZxeHpL?=
 =?utf-8?B?U0hLYTFzaE9Za0hoS2NhOHArdVUxeXZFN3JjUWRtWEdGNzZZQVA5bjE4ZVJP?=
 =?utf-8?B?ejhKcm5pQ01nYjNSbCtCek1Xem9abE03ZUsyVTBKU21GaVB0QVllamNGaDFN?=
 =?utf-8?B?d2FzZ0hHQitIbnhSMkZBbjg4SUtTK0wwNytVaGI1VmZBd0pFU2pRVFlHS2J4?=
 =?utf-8?B?YU9US2hZMTMzeFplekdTbW1ZWUxSOC9wYkxTdXR0bVVpNS9oKzF4d1JSWlJh?=
 =?utf-8?B?VitUSWo0ZnR0NU1hSW9Dd0VPSE41aU85STF4aEplTTZwRE5WWGhOMWhaODhV?=
 =?utf-8?B?b3RkbG4xb254SExXQmozN2RSbytscjZ5bkRPajdOcjlycDB1SWR1Z3ZKd3Jq?=
 =?utf-8?B?c3g1SkJZb0lsSUo3M1FLbGk3RWNNdzlGVUF4aGVQN0h5cXJ6bERDZUtDcWJm?=
 =?utf-8?B?a2FEWFdHcVN4blprOFhWMVZGZXNibUkzRXdpdFBIeFVCTlcvdy80VmQ1VWZt?=
 =?utf-8?B?WGQ4ZHdlZUNlSkFRWWhDQnlPL05tbllnYmwyYnlDYlVsRnMwaHBFaWloWk9D?=
 =?utf-8?B?NW1VYnBlS3pWRG9SejZlME5zbzBEaDhIRzFHdkh5NjB4YVBtSWR2eU9vSlk3?=
 =?utf-8?B?NVNVWndWZ3JDRFJGZERMbUFXTkJreHkydnZDa3BpVjFVS1cvTE4wUDFsUzdZ?=
 =?utf-8?B?VDh6dFR4MWtJQm1tdHM0dVBtR2E1aFFTZ054a3k2Y04xTnZYQU9zcEpSYnRV?=
 =?utf-8?B?L01QMm0yQ0VIVzBuMlJWSFRYNFI3N1BNeUFBVlZpUEl2cG5LRElBa1gyRjln?=
 =?utf-8?B?L1NOYzhyQjkzTXIxb1VqR21abDZJamxjYlVRbCtWUE1tWk1WMDg0MFlaTSs1?=
 =?utf-8?B?MGZLL1VYSENDU0MrVnB0R2V2Rk1LSERDVkV6bE03NzdlV3BHZ1lDMVBvVElT?=
 =?utf-8?B?SFlvaS9Ba09YS0JqVndEZ01PM3lPWWlwTWlzeUtpM1pPZ3p6ZVg1bytnYWdR?=
 =?utf-8?B?aEsyMHZhci9VeWxIQVgyTFlKMktRV0s1M3lpQitqTk1jaWo3S1kvQllqTEpB?=
 =?utf-8?B?Qm9ySWZJRVVGemJkOXh5V2R3d3B0OG5DRkIrVCtvU1BxSmlQaUxzZXUzVzVT?=
 =?utf-8?B?UEYrMUtQYzZmNHhqcm91Y2pMem5oS3BPSG1HbHp1NVMyUTArZTM2cm5RWmVL?=
 =?utf-8?B?RlljeUNDQW5JekJ3ODhJbnFSWkNzRzZ6bFBKYVZodHhyRHRPTGRDTXdkZ3Zt?=
 =?utf-8?B?djljYll5YjFpTzlFckdhTDJvT01aUGkyb1NWVTJJTU1mbldhaVhaN1hpOTFX?=
 =?utf-8?B?Zzg0cUwrYUlJTjFyeGtQc0YwZzBYSGhUUW8yTUx6aEJmK1A1Y0tLQlVZS1hK?=
 =?utf-8?B?UkhCaHlPWGVlMDAyajAvcGpIRnJxSndNbFB6VS93eGY0Vzc4WEZLN2dPKzlV?=
 =?utf-8?B?OHlVc0F6NmRmYjZlZ0dMN3puVmV1K2NOczNpNGpDNGhrenZNakFGNU54bUtl?=
 =?utf-8?B?azRaSXZHMy9qVjROZytvYlRnQlFPNVo0OWRBeG83bXdrbnJFempUTTFKTXNE?=
 =?utf-8?B?WG9CRERPekhCNWRzVjFtcExpTEVkMTVpWWgxc2dUanNhQkE3MTJsdUN1Rllx?=
 =?utf-8?B?Qno2S3hTaENnRXZ1UEtSaS9OTENYZUNFQ0hWV2hjNWRUc2toelg4OU4zSGZH?=
 =?utf-8?B?bVhxeVpxM0pYcUd2OFhDV2tXTXhxZWFVbGoyRTlkYjhDeU1Ed0JtcUg4M3Ri?=
 =?utf-8?B?RllLQ0R4eFNhdk1XZlJacENPenE3T0VkQ3FudnYyWWUydHh1cmNEV0U3U2pz?=
 =?utf-8?Q?TUV7RyNKhjMsXOfV0eAfunDTz638EJIxxcRCE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K21CMWJ2UmNKaUQ2N0crWU5LU2JnYzR3TXlYN2NhWE91Ym9RaGRFSE1kV2s0?=
 =?utf-8?B?SnpKT0hmenZQREFKcjF0Mmt3Rmd2MXlmMEhZR2dOSmphL2pnUHNPSjVRNXZ3?=
 =?utf-8?B?N0hseDVGTjBkRDgxMFhhdVA3N2RBK01qUlExbkMrVG42TWg3aVlPeEZzQmxt?=
 =?utf-8?B?OUVWZzlNRTdPdlBFc3lVb0FXQnowbERMa0Q1WEVlUDhCQmxuc1BCZ3Juc0JF?=
 =?utf-8?B?NDJoK0JNdm5RV0wyaHVsSUdZazIvVm9XYnFlWndUOVJpdlBGVFp4WXBhdXZy?=
 =?utf-8?B?dnN3QUtPLzdmRTJoTThNRGVYUGUxR1RFMGlYVmwxd2ZsU1VOQU9IN1N5OHIy?=
 =?utf-8?B?UW9nY3Y0WFh0bHIyWmg1Q2ZMSWZ5c251YVJ1UUpnQmFQSkx3MVJzNDlSS0g0?=
 =?utf-8?B?K3hvZnFDUjVZTFRJVUxYYkxlOGFWbDVneVloOFhRNmVGMUNwUDBvYnZtV3hk?=
 =?utf-8?B?LzBGcDZIc3R3T3hncmhlbWNXV2F6T21IRDg0bjAyeDRObzVvbEl4cW93dlpa?=
 =?utf-8?B?NStMZUUzMm9QL1B6dVhYaW1KVTM5NTYyQjRlWkl6SzVzS1ZibHpibUdqUExt?=
 =?utf-8?B?d0hUWlZ6RXI1VEFpdkMvNXpNcy9LZEp1VzJxRVZWc2NvOVhmZjI5bUZCQ0Ez?=
 =?utf-8?B?QTlnRGhwM2tFVU1kTHJMNDVFdVJyVW1tbHdCOVBWVjdaMVpUV1I5Ty85Uk1l?=
 =?utf-8?B?azNWVU5PbXhxNUNLaXBRQUEzNXNGaG5UckNwY1JaeXRkeXZkSWU2dUJ0aU5l?=
 =?utf-8?B?cExLclZDZXRmaks1dEtlaEc0QVNyMjBFMWxnOWlxVkUwSVYwU2czYW1hOFo5?=
 =?utf-8?B?NUZEWnFYdEFhMU9UR29TUkRLUVlDK2tETjhrbVZ4aFVsVzloTXpEbXJ1K3Bj?=
 =?utf-8?B?TzAza3BzYzZnd0o1QXdlWE14ZEJrWkliU1FSZ096Q3ppTHlwdGE3M2tQekw1?=
 =?utf-8?B?QUtlUFNocC9hZDI2ekRQTzRpZWxXN2grSzFrbGtRQzViQTd6SDM5bzdkc01i?=
 =?utf-8?B?TkdhRjJETjdtZVd5UkZNUnNvbVBMQWR2am4zZDlWc3BPR3E4L3VONXVodi9O?=
 =?utf-8?B?ckcySWo4MXZQL05tYkVnQmJmSDA3RjBqNFVwTTlkVkVaNDRNZXl2YW5QR0ow?=
 =?utf-8?B?M1UyWW9xbG9BVlhiU3UveERyNEUzN084dVNIY1pwZGg0SDQ5Q1VwWDBPYlVY?=
 =?utf-8?B?ZHpBZXJkLytFeHhIY09QL1BDaTk2RVRpbFQwcFF6Z2lUejJoeEI4bW5ZTjZj?=
 =?utf-8?B?RjhEeWVlQk5DdEFmN3Jxcnc5ZWE1d25KTy9lYnBrQSs0cXBGeUZIRGlPcFNJ?=
 =?utf-8?B?Zi9lSk5mMzB0OSt1Ukxib2lOY3NpK1JVQlVIbTRWN3hFQTRlZkd5OFZSV1ZE?=
 =?utf-8?B?U05sbldrcW0zd2oyQ1pEdnFhOVg1Q1dFRE9ML3h6SThEeW9Xdy9aNUlyaG53?=
 =?utf-8?B?MFRYSjh6ZnB0ZUpJUDVFNlpzbmo5QmF1V0o1N25UUkRUR1hkWmpPeFAxRUNU?=
 =?utf-8?B?Q1hMRExhWWNKYmlxU3hTRi9uazFONTRjeGFMcU5hdllielB3NCtidlpXU09R?=
 =?utf-8?B?R0lrQXZPaDFqNWwwTWsvbHlqdkN4eEtHWGhaci92SFAzK0FWaENFS0F6RjZW?=
 =?utf-8?B?S3Q5ODBjWDRJWFlzK2tuaDBzMUxwbytjcnFvREhtd3IzejRic0tIT1VWMXoy?=
 =?utf-8?B?NGpuWFZVTzlycEh6b3dXV2kyK2Q0bTQ0N2R2Z01tcjBCdzJQeG1tYVptQ05w?=
 =?utf-8?B?aEpDcU9yR1JtRVdjM1VkU3FGY1F0YldMaW40WTZRUDVCaTNqdGh4TnVFOUlW?=
 =?utf-8?B?L3ZqS1pLdUl4U08rbkpGcGk1UHI0OGVKOWVveFNUdHR4VE4yN2N0dnlPekNX?=
 =?utf-8?B?bWx2elFVcE1oTVR0SHpJdW1SeHBrUzNiSjNYNlVtUHZQdUdhRFFFTzB4ODZJ?=
 =?utf-8?B?R1JVbXk5UXIrQkdLRDVDdDJmV1lnQ0t3TjE3NkxIQ3VtYktjMHBxRkxBM0N0?=
 =?utf-8?B?ckVCZk41LytYb3N6bUlMdFhmbksxMUlrUUhyeWR5OFVzMm9tQjFBTndQaXBS?=
 =?utf-8?B?QUxnbVlob0VJVFV6YmVCM1krdkd4ZnBUd2FpSnUxVlYvYmJqVlQ5OHhpUnl6?=
 =?utf-8?B?QkFyM0FpbVZacVpQeGVPcHlDOWo1dlFBdmN1RGdPd1hxMWpXYVBYdDY4WU5R?=
 =?utf-8?Q?/Ao9O0NkulAnv/4C7ceLLzk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <72209EE9272DF546862E6C263FD7BC0E@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ef8c200a-5ade-4caa-e27f-08dcff65dc55
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2024 19:53:33.2658
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CQ7nGz2AScdufttuyDphMkpRyB/zpg+mDnQ0aUoe9buGjoCpbyg+/ukh3I6Nw+UK6MlMEwZZ8F9VYvC0Ywmu8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR15MB6697
X-Proofpoint-GUID: j_Ep1GyICQpDmkDjWh-2vePCEKzE1TGh
X-Proofpoint-ORIG-GUID: j_Ep1GyICQpDmkDjWh-2vePCEKzE1TGh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

DQoNCj4gT24gTm92IDcsIDIwMjQsIGF0IDM6MTDigK9BTSwgQW1pciBHb2xkc3RlaW4gPGFtaXI3
M2lsQGdtYWlsLmNvbT4gd3JvdGU6DQo+IA0KPiBPbiBXZWQsIE9jdCAzMCwgMjAyNCBhdCAxMjox
M+KAr0FNIFNvbmcgTGl1IDxzb25nQGtlcm5lbC5vcmc+IHdyb3RlOg0KPj4gDQo+PiBUaGlzIHRl
c3Qgc2hvd3MgYSBzaW1wbGlmaWVkIGxvZ2ljIHRoYXQgbW9uaXRvcnMgYSBzdWJ0cmVlLiBUaGlz
IGlzDQo+PiBzaW1wbGlmaWVkIGFzIGl0IGRvZXNuJ3QgaGFuZGxlIGFsbCB0aGUgc2NlbmFyaW9z
LCBzdWNoIGFzOg0KPj4gDQo+PiAgMSkgbW92aW5nIGEgc3Vic3VidHJlZSBpbnRvL291dG9mIHRo
ZSBiZWluZyBtb25pdG9yaW5nIHN1YnRyZWU7DQo+IA0KPiBUaGVyZSBpcyBhIHNvbHV0aW9uIGZv
ciB0aGF0IChzZWUgYmVsb3cpDQo+IA0KPj4gIDIpIG1vdW50IHBvaW50IGluc2lkZSB0aGUgYmVp
bmcgbW9uaXRvcmVkIHN1YnRyZWUNCj4gDQo+IEZvciB0aGF0IHdlIHdpbGwgbmVlZCB0byBhZGQg
dGhlIE1PVU5UL1VOTU9VTlQvTU9WRV9NT1VOVCBldmVudHMsDQo+IGJ1dCB0aG9zZSBoYXZlIGJl
ZW4gcmVxdWVzdGVkIGJ5IHVzZXJzcGFjZSBhbnl3YXkuDQo+IA0KPj4gDQo+PiBUaGVyZWZvcmUs
IHRoaXMgaXMgbm90IHRvIHNob3cgYSB3YXkgdG8gcmVsaWFibHkgbW9uaXRvciBhIHN1YnRyZWUu
DQo+PiBJbnN0ZWFkLCB0aGlzIGlzIHRvIHRlc3QgdGhlIGZ1bmN0aW9uYWxpdGllcyBvZiBicGYg
YmFzZWQgZmFzdHBhdGguDQo+PiBUbyByZWFsbHkgbW9uaXRvciBhIHN1YnRyZWUgcmVsaWFibHks
IHdlIHdpbGwgbmVlZCBtb3JlIGNvbXBsZXggbG9naWMuDQo+IA0KPiBBY3R1YWxseSwgdGhpcyBl
eGFtcGxlIGlzIHRoZSBmb3VuZGF0aW9uIG9mIG15IHZpc2lvbiBmb3IgZWZmaWNpZW50IGFuZCBy
YWNlDQo+IGZyZWUgc3VidHJlZSBmaWx0ZXJpbmc6DQo+IA0KPiAxLiBUaGUgaW5vZGUgbWFwIGlz
IHRvIGJlIHRyZWF0ZWQgYXMgYSBjYWNoZSBmb3IgdGhlIGlzX3N1YmRpcigpIHF1ZXJ5DQoNClVz
aW5nIGlzX3N1YmRpcigpIGFzIHRoZSB0cnV0aCBhbmQgbWFuYWdpbmcgdGhlIGNhY2hlIGluIGlu
b2RlIG1hcCBzZWVtcw0KcHJvbWlzaW5nIHRvIG1lLiANCg0KPiAyLiBDYWNoZSBlbnRyaWVzIGNh
biBhbHNvIGhhdmUgYSAiZGlzdGFuY2UgZnJvbSByb290IiAoaS5lLiBkZXB0aCkgdmFsdWUNCj4g
My4gRWFjaCB1bmtub3duIHF1ZXJpZWQgcGF0aCBjYW4gY2FsbCBpc19zdWJkaXIoKSBhbmQgcG9w
dWxhdGUgdGhlIGNhY2hlDQo+ICAgIGVudHJpZXMgZm9yIGFsbCBhbmNlc3RvcnMNCj4gNC4gVGhl
IGNhY2hlL21hcCBzaXplIHNob3VsZCBiZSBsaW1pdGVkIGFuZCB3aGVuIGxpbWl0IGlzIHJlYWNo
ZWQsDQo+ICAgIGV2aWN0aW5nIGVudHJpZXMgYnkgZGVwdGggcHJpb3JpdHkgbWFrZXMgc2Vuc2UN
Cj4gNS4gQSByZW5hbWUgZXZlbnQgZm9yIGEgZGlyZWN0b3J5IHdob3NlIGlub2RlIGlzIGluIHRo
ZSBtYXAgYW5kIHdob3NlDQo+ICAgbmV3IHBhcmVudCBpcyBub3QgaW4gdGhlIG1hcCBvciBoYXMg
YSBkaWZmZXJlbnQgdmFsdWUgdGhhbiBvbGQgcGFyZW50DQo+ICAgbmVlZHMgdG8gaW52YWxpZGF0
ZSB0aGUgZW50aXJlIG1hcA0KPiA2LiBmYXN0X3BhdGggYWxzbyBuZWVkcyBhIGhvb2sgZnJvbSBp
bm9kZSBldmljdCB0byBjbGVhciBjYWNoZSBlbnRyaWVzDQoNClRoZSBpbm9kZSBtYXAgaXMgcGh5
c2ljYWxseSBhdHRhY2hlZCB0byB0aGUgaW5vZGUgaXRzZWxmLiBTbyB0aGUgZXZpY3QgDQpldmVu
dCBpcyBhdXRvbWF0aWNhbGx5IGhhbmRsZWQuIElPVywgYW4gaW5vZGUncyBlbnRyeSBpbiB0aGUg
aW5vZGUgbWFwDQppcyBhdXRvbWF0aWNhbGx5IHJlbW92ZWQgd2hlbiB0aGUgaW5vZGUgaXMgZnJl
ZWQuIEZvciB0aGUgc2FtZSByZWFzb24sIA0Kd2UgZG9uJ3QgbmVlZCB0byBzZXQgYSBsaW1pdCBp
biBtYXAgc2l6ZSBhbmQgYWRkIGV2aWN0aW5nIGxvZ2ljLiBPZiANCmNvdXJzZSwgdGhpcyB3b3Jr
cyBiYXNlZCBvbiB0aGUgYXNzdW1wdGlvbiB0aGF0IHdlIGRvbid0IHVzZSB0b28gbXVjaCANCm1l
bW9yeSBmb3IgZWFjaCBpbm9kZS4gSSB0aGluayB0aGlzIGFzc3VtcHRpb24gaXMgdHJ1ZS4gDQoN
Cj4gDQo+IFRoaXMgaXMgc2ltaWxhciwgYnV0IG1vcmUgZWZmaWNpZW50IGFuZCByYWNlIGZyZWUg
dGhhbiB3aGF0IGNvdWxkIGFscmVhZHkNCj4gYmUgYWNoaWV2ZWQgaW4gdXNlcnNwYWNlIHVzaW5n
IEZBTl9NQVJLX0VWSUNUQUJMRS4NCj4gDQo+IEZvb2QgZm9yIHRob3VnaHQuDQoNClRoYW5rcywN
ClNvbmcNCg0K

