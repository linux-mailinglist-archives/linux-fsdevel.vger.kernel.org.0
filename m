Return-Path: <linux-fsdevel+bounces-26389-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BED21958D95
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 19:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F0A51F236C8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 17:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC46E1C5784;
	Tue, 20 Aug 2024 17:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="Y9qln23+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC01A195985;
	Tue, 20 Aug 2024 17:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724175770; cv=fail; b=IO7yxM3kdBVCZ1Y/Bq9Ix4eKhXTlNpbhb+dE5bFLB2HVHdt0V0wtbLQOY97DRh/NHgS0sqq/59v+cnkVN4BNwlM1jCkHsA9gQWcC2zOMzi1yAW5+XX4BN4tkTXTjRRw9C+9UTLwYS+CObuBojouW519EM5oAvOkZQSscdCXq4Ko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724175770; c=relaxed/simple;
	bh=nzzqkGSMXcdpRgs1orT0c4nTH1SQPncTKX1OHQLbDaU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uDp9Qo3eRQmFJlzOA+85llsLY0IjMK5FlC2cd9tClfHx8trnamcXNtXGzkAh++IrKpPGQl6tjxDfhXKsAewm22xKnilCUIGmDn4r/HpVQk7DSfkwFPN6Q+J728FU7i/8JxI1Z0yxAVxNcmFQI4z44ltqXgNYe/zDB+M+1dQJdMA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=Y9qln23+; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47KFpqPD023849;
	Tue, 20 Aug 2024 10:42:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=s2048-2021-q4; bh=nzzqkGSMXcdpRgs1orT0c4nTH1SQPncTKX1OHQLbDaU
	=; b=Y9qln23+WzGDIA8mS8Gg5KIwuKm5ljB9Y60lEXceeOD+Zj3EcF4dehRWyYo
	QeYlZrU0PbINDIGJyN35vL0GE7anxjs+GsQ7cokj3lXRaDGtyYogTIKmFm2tuN9A
	OoH5+IC122gSkcf60V0+ruLLkaAUFCAUdYodi+E6qCIzf4nRqzKAFNUx3FZYAx1S
	JIoKoDLBz4Bv+vq+cvrcB0iQdzXTzvIqhr4icgYUWK3zkOHZAIHFJ1XdxKUOc8w5
	8MSjGwV0ozv4HltzLRkMMMNAPpxUm92i0dCIB88tIS2UYa6CjLT6ZCqE9qr19DAb
	eEp6USewM8p41fGlhXdODta6e1Q==
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 414ksfkwxf-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Aug 2024 10:42:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tu6r7z9D5GAIAgIlsBnu67WfD3csyz+f0DYBscVdu/RKcWt4LZ18tZWhNN0Kp6M2+Wscjs3ZSFTy2+xaaKHQmVLe/jpshrNaon2V6ve1CylhBmeVMlAel6c+cfkzBajjBiMcDzzj6FYPEOdDlI44Hvm3J9Anp7Hm9sdIUaoFaQ6Sr/0jhKrVvemt4yF6ip+fVS0NOdmeTQsiy71hkV2abpFNKAt04D5n09jcD5cZvTTMIchz30DhPCoA8QAfgDJ1kV96L/ovD8deC4Bnmt4jIqaVLZ0cGUnoPmojKyB0KWIIbm5q0ILdO2f6GpXV/DE92W/bduSV5ZpD5mZkD9pneA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nzzqkGSMXcdpRgs1orT0c4nTH1SQPncTKX1OHQLbDaU=;
 b=uAm1lyQsiE/WzOwFnLSLc57/YAFwWaEzD8ybkPLyq+IFQZQ9g9+JGOuDxC/8xCpWGegTUyHCyP3zeEO8+c/UqQOj3brWPC5C5/GZovtIhH1l/X2DLIuzeFkH2S9iyRsBjDQYj26QKV7YSMLPYGYtKKdXQRfo9s7EWpqtd9VUAQxoyPL+iYgmS/vix1UrU6aVpcHcPDABSlJkqaVOQLrNISM4JkZaqppl1KwKMKBTVgD03Vw0oAog9k9e0hwiq2qvaNOXb7k8HdVbXItxUJcAA3/rOYzZ25E8+si0mT8JxuFi7mAplSaqK8bdHlMDkwMasOwphiGvnIURc29JGEg/HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by MW4PR15MB4362.namprd15.prod.outlook.com (2603:10b6:303:bb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.16; Tue, 20 Aug
 2024 17:42:43 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610%4]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 17:42:42 +0000
From: Song Liu <songliubraving@meta.com>
To: =?utf-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
CC: Song Liu <songliubraving@meta.com>,
        Christian Brauner
	<brauner@kernel.org>, Song Liu <song@kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML
	<linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@meta.com>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "eddyz87@gmail.com"
	<eddyz87@gmail.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "martin.lau@linux.dev"
	<martin.lau@linux.dev>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "jack@suse.cz" <jack@suse.cz>,
        "kpsingh@kernel.org" <kpsingh@kernel.org>,
        "mattbobrowski@google.com" <mattbobrowski@google.com>,
        Liam Wisehart
	<liamwisehart@meta.com>, Liang Tang <lltang@meta.com>,
        Shankaran
 Gnanashanmugam <shankaran@meta.com>,
        LSM List
	<linux-security-module@vger.kernel.org>,
        =?utf-8?B?R8O8bnRoZXIgTm9hY2s=?=
	<gnoack@google.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add tests for
 bpf_get_dentry_xattr
Thread-Topic: [PATCH bpf-next 2/2] selftests/bpf: Add tests for
 bpf_get_dentry_xattr
Thread-Index:
 AQHa3u0J3x+q9TWVEkq4VV2cIBgMWrIIlswAgAAlQQCAACpzAIAAg8YAgARTMQCAIJSqAIAAQmAAgAAgpoCAAHu3AIABDvwAgABS9gA=
Date: Tue, 20 Aug 2024 17:42:42 +0000
Message-ID: <1FFB2F15-EB60-4EAD-AEB0-6895D3E216C1@fb.com>
References: <20240729-zollfrei-verteidigen-cf359eb36601@brauner>
 <8DFC3BD2-84DC-4A0C-A997-AA9F57771D92@fb.com>
 <20240819-keilen-urlaub-2875ef909760@brauner>
 <20240819.Uohee1oongu4@digikod.net>
 <370A8DB0-5636-4365-8CAC-EF35F196B86F@fb.com>
 <20240820.eeshaiz3Zae6@digikod.net>
In-Reply-To: <20240820.eeshaiz3Zae6@digikod.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|MW4PR15MB4362:EE_
x-ms-office365-filtering-correlation-id: 2d5cc5f5-d642-48c7-f2a1-08dcc13f7e7a
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ekFWQlNRMGZzSVFiTUVZVXdZZ0J0SHJaQWcyUmlJYk83cS9XdnF3R0NuOXJo?=
 =?utf-8?B?Yy9NSy9ETkpvMjcreWtabFF1dHk0OG5Vc1p5U1BFTFdSa0VaNWpudkpwdk0v?=
 =?utf-8?B?ZkhFYVUxRHE0UG5CSVpMVFgvK3RqajhaOXozbmVjc3ZDaXBXL0xaQ3p5ODJ6?=
 =?utf-8?B?Ty96STJYU2VWaFdxa1ZpMXFzSVBFYmtYaURzNHA1ZnJGVEs0SDduWU5NTkNT?=
 =?utf-8?B?MElWcUJwRE5haGU1WGpGN1FHY1RIbEVuQXJoR0k0T3QvNWJCVzRLUGgzaTly?=
 =?utf-8?B?SCtlQTI1SkIzZkhJL2NQM1R4RDBpamxjYlF1NkpML0FOMXNTa0E0V0p1MG1Z?=
 =?utf-8?B?TWFqSlVIcDdRdDBPZEFiWjRrbHNwTE83U1NRaXVOK1lZZzBGQVJKL1ZQdHMy?=
 =?utf-8?B?KzlTQnN3RmlJQU9jNkQzTldhREpPcm5KalVvWkdpN1pYZDhYKzBydUY4dUwv?=
 =?utf-8?B?QkdINWxzQUlFWkR0aVQ4VDA3RFcvOE1TK21QN05mVHhKU29tY1FpNmxiUVRa?=
 =?utf-8?B?NCtnOEd6dlYxcW5rem01SW9SZ05aVVVpL3BrQ1A0NnVYZGIybG9aQVVFUFQr?=
 =?utf-8?B?UFlibzdwVFUzYVpiMWlwU1dxcE1Fb0NsaVFxWFpDbHF2K3NrVHlaT21lUGpI?=
 =?utf-8?B?U05hTnhPL2FpQ0EwUWZ6SHBRd1BGTUl1Q2llMFB6TVNhNWtyaVJPek1SZDVh?=
 =?utf-8?B?VzR1QnlLNXpQSzhwK0Z2MytLL0pJNGV5WWJ1Q0orWUtITDAwUERGUjRuSXdX?=
 =?utf-8?B?OVI4UzZkbXhTYjJVUVZodmJZbVlPaWRWVFl4Vm11YlVmRGJvUEl4VVRZOHVG?=
 =?utf-8?B?THNGUkFmcmdHM3o0dVpaRlRiNFd4Y2xocm9oZHd4VzIvak1FTW9nSGlXQlFC?=
 =?utf-8?B?ZWc1MFdaN2pIT0FidlI4cGQxUFRmTnJQbUJiWkNXSTR3OEk1aFJaR3UzcUtV?=
 =?utf-8?B?ejN0R1JwSlJTMTI2anQrbUpiaFBteTBSVk1Md3lqZCtOZk9XeGhwRVMwL09O?=
 =?utf-8?B?OStuQjlFcVdKcnZUdExWa2Q1Y09IRkxURnJqMXFqUEI5Znc5Q0lUWUxIWU01?=
 =?utf-8?B?MU1Xc0JaaEVid2FqeWFDRXVCRlZWODVtL0FodWlWaHRrN1M1d3dKLzNsNzRC?=
 =?utf-8?B?S0hrNzVReDlxYjRhRXRmbW9EZ29VUFZZVkpXRDhHck90MTl4aWVHK1pKSGZx?=
 =?utf-8?B?dCtXUHFmNlJONE9mcVBOdFM1UUl3aUNCVy9ZTTZQNVI5ZmVBK0tWdEpmdHBF?=
 =?utf-8?B?Z092b1lhRmRGazY5MjlHbnV1aExITWNYZ3NEcGlqb1MxVDQ2b0t5djNKakJM?=
 =?utf-8?B?V3d6ZE1KMUJXMnRRM2FzaWp0d2lJU00rNURWWmlxbmVYSHlOVUEvMkNZZGxx?=
 =?utf-8?B?dmpYTzFIR1BKWTdBSnpmcDFhQ2FzZFBaZUJLdkJ6RWhkUkIxTXJ1ZmV0Y2Uz?=
 =?utf-8?B?REpLQUUya3dpWXBuZVJsKzY0a0ZLQ3p0Q3lyc0taL1NGc2lIdzVoSXJJY1Zj?=
 =?utf-8?B?ZmNRUVpuM2pVYmtzbitzaG9RWFJSTGJzSW0wbFBzTmpIQk9TaE5Vd1lTbDE2?=
 =?utf-8?B?UzZlV2F6bjFocFRsWVBLYXNFdkdtTndZSzdYTHV6NUdHNmIzK3hqTE92Vkor?=
 =?utf-8?B?Z2hmOW1wL3pxWS9GMWpVa1hHekwxNGRvRnN0aTNVa3prVEQraXBLZ1p3ckNN?=
 =?utf-8?B?UEtIVm5zQ2xJYnZ0Q01pSDFXMElPZGVwS2tsSHpQczhFUC9tUGlOY0ZaM2hs?=
 =?utf-8?B?eGFld2tzbEM2T1hGa2c5aXdKTUdRNzFHZ0RUdSt4N1g2RGpPa1psZlVhdmQw?=
 =?utf-8?B?dWMySkJzend6QmFXWWJjZUU0OEJKeU93Wk5YQjFibWYxMHRRTHFoeEFCUFBz?=
 =?utf-8?B?aHg2OCtTQ0ducFEvOHZVbCt0c2R0UXZuN0NvQkRSZDdrNnc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SVNlbExRbWU4OUpRWHRIazM0alJJLzBublhlZzNOUWcxdkV5Q0lRVDZLckE5?=
 =?utf-8?B?V2I3ZHE5QUFOUThjR2lueWxCRXJtRXFjWXlkRVlDWHR0S3VGa2lvK3Z2WDFT?=
 =?utf-8?B?a2F3SlJxS1YwZkFzaXZVUWNxdFE4dkUvd0hKSE13Wm9xSWlNb2QrTzdXaFNK?=
 =?utf-8?B?c3VyV0VnVDlrZDBjT0dDTis5VXpmK2ZFZ2FRNWx4d3NqdW9TMWdsblpMS0k3?=
 =?utf-8?B?Q1lJV25YeUw3ZWx6aVZaS3ZWTUZRMnVVNkZLWk5COEVZcVYyVTRjdXh1K2hF?=
 =?utf-8?B?cUdQVDlPZG5BWVdhUGdzK3lyaGVOTk5EbXNRdmN2TkpDMHAwMUlwcVVvc3BL?=
 =?utf-8?B?V3IrZ3Uza3pET1FaUG85Sk1zdVI0TkNsYWtuamlNRzBRVTVjekd3cStsR3NN?=
 =?utf-8?B?SXVGWGpjYzBvQ3lyMVhqNTkvTUdnak5tUnh3Nmt4S0VxOFg3RlpUQkprRXMx?=
 =?utf-8?B?NTZ5M0pGaU8yUm1nWlF3MktWcllXM0d2VGhwL3lDR1ZoNUJ0RlFPZUVoMUNx?=
 =?utf-8?B?Q1duQTR0ODlEK3NvUnd6a3ZPdUIwUzlLY2hvZzdNWUNVTk4yK096Q3AwRmZF?=
 =?utf-8?B?MmtGampscVg4SFBoazArT0J2QUUvUlhONUpNYk8zSngyZytlMmkxUFdUcCt5?=
 =?utf-8?B?cWtJV3lyUnN5U0F4WXU2NEFmS1FZdHVDTXJuckgzRGc1MHBJZVpoSG1WeTIv?=
 =?utf-8?B?d0pHdi9yNFlnY2lCVDVhMmw5ZElqRGNYajlWTlJVbnJXQWdzVUo5SkUyUXFT?=
 =?utf-8?B?TFdQK3Q0ZVpnem90QmtwR1NzSzRya3pxVzduY2NMNTE0MG52TEJMMWF6UVlQ?=
 =?utf-8?B?ekN4cjlMRks4Q1IwajY1VmdabmRMY0lnTkJ3dWZ3VDJpcFhYVERUakhUSjFM?=
 =?utf-8?B?OHJQbHNpUGlITW5rUjYrVk1GUWZaM1BJZ1JFSkErekM2RG9INGE0VFp1VkhV?=
 =?utf-8?B?dkZhNzNURHhHU29yMHI4Y0kxVmpnUjRPOVNvZk4wSVo1cWgrREtPeE0vZVlD?=
 =?utf-8?B?Z3pnQnh2R3c5RHhCWWJ0Q0N1RXdFY1orVTA4YzNGOTFtaTVJTkhPdGpDMFEr?=
 =?utf-8?B?am5uQ015VlFLdXhNS3l2VUN5STU1dEU5OUpKRnBSbUhOcFdidmpZSG5ySlRF?=
 =?utf-8?B?RTRBWHY5UFZpSzQ1dE1oc3N0ZmIyK0pvMGlwSTBMSmhUYm04WEhsUGtvUUxh?=
 =?utf-8?B?MTlQUFNaMS9HSUpQYi80ZEZVeXRYL1BHVXJwd0VlQ0JDRlVxcXNZRGRlTGhW?=
 =?utf-8?B?UWRHZ3ZMemJkNlFZYWthVHdSNHZ4ODRTb250aXRTVXhmeGkxUTdoZFVHR3hV?=
 =?utf-8?B?Ym9pc2FpdUVvTCt3dmFGQ1FxWnRIeFZWSXB2bVl1bmdXRVE5U21IL3FvZGdp?=
 =?utf-8?B?ek8rNngzamFPZ04rZEgxOG1CbHpEMVh4VElDNWh4eWpJeGxFaVlZV0ZTdnZX?=
 =?utf-8?B?NmZ6Tlg0NVVZK2tpNlZSTm9pcjJhWXFIN0tUYjJRQ0hXNkhEbEpzcUsvWk1u?=
 =?utf-8?B?NUNWZU5sWVZxcHB2QnoyTC9KL1cyZHlvUXJ2ZkFKMDk4dUdLNDNOQ3FSRTI3?=
 =?utf-8?B?Z2hzMWVweVVRWjJ1cU1RNE9mM2JZQ2cyeFh3WmJ2dFQ0aThEajdoS1g4Zngz?=
 =?utf-8?B?Z0I3Rk0rN05FNXZvZjZ0SDZYNzdkSUloL0xCbC9tWnA0Z2FLUzhCWWppK3RK?=
 =?utf-8?B?UFUxNXF5RWxZcERHRU1HQTlIZHVwcXVwYkJlVjdiQ3dDSnMwaTE4eVJrczRE?=
 =?utf-8?B?NHlqY20vc3liOXZrMlhuc3NWYVpWR2NLY3VrZkRmc1lLVUwxSkM5OXJXN3c5?=
 =?utf-8?B?cTlld0FYaTFjbDRmR1c1b3hiWjlGSDFIRzAwQjRJL0N1M2NHTUhpUHRiaTBi?=
 =?utf-8?B?aG5kMlMxN2F5SVNkbWtEU1UvNjlaNS9ZSzlvQk4wRHZSdVFJSVBIQ1QvdFRB?=
 =?utf-8?B?TmZYLzNvSjFYU00xQllXc0FEaFAxbVVSbUpNYXZyaC9EQVZCWmp2Q2o2MDdt?=
 =?utf-8?B?S1EwR210YXJERGEvUk9NTGJibXkzd2ErQ2RQZkdzY1paOFdralMwTTFIbTZq?=
 =?utf-8?B?MEJnZmJ2RElua2MyMmJpMWY0WUNRQ2dMSkxsRFZTTWk0dUZwbmNIcHJ1cy9U?=
 =?utf-8?B?NDhRNDhETGp0OHdDSHBJbmxXUkRuUEkySVFsUElrQlBuZzZ0UzFjQ1lBakZW?=
 =?utf-8?Q?7sT2Uxl0G2fQCqOH8B1dF48=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DB499216E6C8ED46818D6BE881102969@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d5cc5f5-d642-48c7-f2a1-08dcc13f7e7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2024 17:42:42.8636
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W2cclMwic9SIJcHd2yk1Kc7O4txloGA/yFAXzZX4RyePkLSPrjiEJq+V5uD+AXZBHX3XA4yBLSFdmDSibsvrSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR15MB4362
X-Proofpoint-GUID: P1tQxYjFubR3ck1FJUsLoO01fkV4AbTW
X-Proofpoint-ORIG-GUID: P1tQxYjFubR3ck1FJUsLoO01fkV4AbTW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-20_13,2024-08-19_03,2024-05-17_01

DQo+IE9uIEF1ZyAyMCwgMjAyNCwgYXQgNTo0NeKAr0FNLCBNaWNrYcOrbCBTYWxhw7xuIDxtaWNA
ZGlnaWtvZC5uZXQ+IHdyb3RlOg0KPiANCj4gT24gTW9uLCBBdWcgMTksIDIwMjQgYXQgMDg6MzU6
NTNQTSArMDAwMCwgU29uZyBMaXUgd3JvdGU6DQo+PiBIaSBNaWNrYcOrbCwgDQo+PiANCj4+PiBP
biBBdWcgMTksIDIwMjQsIGF0IDY6MTLigK9BTSwgTWlja2HDq2wgU2FsYcO8biA8bWljQGRpZ2lr
b2QubmV0PiB3cm90ZToNCj4+IA0KPj4gWy4uLl0NCj4+IA0KPj4+PiBCdXQgYmVjYXVzZSBsYW5k
bG9jayB3b3JrcyB3aXRoIGEgZGVueS1ieS1kZWZhdWx0IHNlY3VyaXR5IHBvbGljeSB0aGlzDQo+
Pj4+IGlzIG9rIGFuZCBpdCB0YWtlcyBvdmVybW91bnRzIGludG8gYWNjb3VudCBldGMuDQo+Pj4g
DQo+Pj4gQ29ycmVjdC4gQW5vdGhlciBwb2ludCBpcyB0aGF0IExhbmRsb2NrIHVzZXMgdGhlIGZp
bGUncyBwYXRoIChpLmUuDQo+Pj4gZGVudHJ5ICsgbW50KSB0byB3YWxrIGRvd24gdG8gdGhlIHBh
cmVudC4gIE9ubHkgdXNpbmcgdGhlIGRlbnRyeSB3b3VsZA0KPj4+IGJlIGluY29ycmVjdCBmb3Ig
bW9zdCB1c2UgY2FzZXMgKGkuZS4gYW55IHN5c3RlbSB3aXRoIG1vcmUgdGhhbiBvbmUNCj4+PiBt
b3VudCBwb2ludCkuDQo+PiANCj4+IFRoYW5rcyBmb3IgaGlnaGxpZ2h0aW5nIHRoZSBkaWZmZXJl
bmNlLiBMZXQgbWUgc2VlIHdoZXRoZXIgd2UgY2FuIGJyaWRnZQ0KPj4gdGhlIGdhcCBmb3IgdGhp
cyBzZXQuIA0KPj4gDQo+PiBbLi4uXQ0KPj4gDQo+Pj4+PiANCj4+Pj4+IDEuIENoYW5nZSBzZWN1
cml0eV9pbm9kZV9wZXJtaXNzaW9uIHRvIHRha2UgZGVudHJ5IGluc3RlYWQgb2YgaW5vZGUuDQo+
Pj4+IA0KPj4+PiBTb3JyeSwgbm8uDQo+Pj4+IA0KPj4+Pj4gMi4gU3RpbGwgYWRkIGJwZl9kZ2V0
X3BhcmVudC4gV2Ugd2lsbCB1c2UgaXQgd2l0aCBzZWN1cml0eV9pbm9kZV9wZXJtaXNzaW9uDQo+
Pj4+PiAgc28gdGhhdCB3ZSBjYW4gcHJvcGFnYXRlIGZsYWdzIGZyb20gcGFyZW50cyB0byBjaGls
ZHJlbi4gV2Ugd2lsbCBuZWVkDQo+Pj4+PiAgYSBicGZfZHB1dCBhcyB3ZWxsLiANCj4+Pj4+IDMu
IFRoZXJlIGFyZSBwcm9zIGFuZCBjb25zIHdpdGggZGlmZmVyZW50IGFwcHJvYWNoZXMgdG8gaW1w
bGVtZW50IHRoaXMNCj4+Pj4+ICBwb2xpY3kgKHRhZ3Mgb24gZGlyZWN0b3J5IHdvcmsgZm9yIGFs
bCBmaWxlcyBpbiBpdCkuIFdlIHByb2JhYmx5IG5lZWQgDQo+Pj4+PiAgdGhlIHBvbGljeSB3cml0
ZXIgdG8gZGVjaWRlIHdpdGggb25lIHRvIHVzZS4gRnJvbSBCUEYncyBQT1YsIGRnZXRfcGFyZW50
DQo+Pj4+PiAgaXMgInNhZmUiLCBiZWNhdXNlIGl0IHdvbid0IGNyYXNoIHRoZSBzeXN0ZW0uIEl0
IG1heSBlbmNvdXJhZ2Ugc29tZSBiYWQNCj4+Pj4+ICBwYXR0ZXJucywgYnV0IGl0IGFwcGVhcnMg
dG8gYmUgcmVxdWlyZWQgaW4gc29tZSB1c2UgY2FzZXMuDQo+Pj4+IA0KPj4+PiBZb3UgY2Fubm90
IGp1c3Qgd2FsayBhIHBhdGggdXB3YXJkcyBhbmQgY2hlY2sgcGVybWlzc2lvbnMgYW5kIGFzc3Vt
ZQ0KPj4+PiB0aGF0IHRoaXMgaXMgc2FmZSB1bmxlc3MgeW91IGhhdmUgYSBjbGVhciBpZGVhIHdo
YXQgbWFrZXMgaXQgc2FmZSBpbg0KPj4+PiB0aGlzIHNjZW5hcmlvLiBMYW5kbG9jayBoYXMgYWZh
aWN0LiBCdXQgc28gZmFyIHlvdSBvbmx5IGhhdmUgYSB2YWd1ZQ0KPj4+PiBza2V0Y2ggb2YgY2hl
Y2tpbmcgcGVybWlzc2lvbnMgd2Fsa2luZyB1cHdhcmRzIGFuZCByZXRyaWV2aW5nIHhhdHRycw0K
Pj4+PiB3aXRob3V0IGFueSBub3Rpb24gb2YgdGhlIHByb2JsZW1zIGludm9sdmVkLg0KPj4+IA0K
Pj4+IFNvbWV0aGluZyB0byBrZWVwIGluIG1pbmQgaXMgdGhhdCByZWx5aW5nIG9uIHhhdHRyIHRv
IGxhYmVsIGZpbGVzDQo+Pj4gcmVxdWlyZXMgdG8gZGVueSBzYW5ib3hlZCBwcm9jZXNzZXMgdG8g
Y2hhbmdlIHRoaXMgeGF0dHIsIG90aGVyd2lzZSBpdA0KPj4+IHdvdWxkIGJlIHRyaXZpYWwgdG8g
YnlwYXNzIHN1Y2ggYSBzYW5kYm94LiAgU2FuZGJveGluZyBtdXN0IGJlIHRob3VnaCBhcw0KPj4+
IGEgd2hvbGUgYW5kIExhbmRsb2NrJ3MgZGVzaWduIGZvciBmaWxlIHN5c3RlbSBhY2Nlc3MgY29u
dHJvbCB0YWtlcyBpbnRvDQo+Pj4gYWNjb3VudCBhbGwga2luZCBvZiBmaWxlIHN5c3RlbSBvcGVy
YXRpb25zIHRoYXQgY291bGQgYnlwYXNzIGEgc2FuZGJveA0KPj4+IHBvbGljeSAoZS5nLiBtb3Vu
dCBvcGVyYXRpb25zKSwgYW5kIGFsc28gcHJvdGVjdHMgZnJvbSBpbXBlcnNvbmF0aW9ucy4NCj4+
IA0KPj4gVGhhbmtzIGZvciBzaGFyaW5nIHRoZXNlIGV4cGVyaWVuY2VzISANCj4+IA0KPj4+IFdo
YXQgaXMgdGhlIHVzZSBjYXNlIGZvciB0aGlzIHBhdGNoIHNlcmllcz8gIENvdWxkbid0IExhbmRs
b2NrIGJlIHVzZWQNCj4+PiBmb3IgdGhhdD8NCj4+IA0KPj4gV2UgaGF2ZSBtdWx0aXBsZSB1c2Ug
Y2FzZXMuIFdlIGNhbiB1c2UgTGFuZGxvY2sgZm9yIHNvbWUgb2YgdGhlbS4gVGhlIA0KPj4gcHJp
bWFyeSBnb2FsIG9mIHRoaXMgcGF0Y2hzZXQgaXMgdG8gYWRkIHVzZWZ1bCBidWlsZGluZyBibG9j
a3MgdG8gQlBGIExTTQ0KPj4gc28gdGhhdCB3ZSBjYW4gYnVpbGQgZWZmZWN0aXZlIGFuZCBmbGV4
aWJsZSBzZWN1cml0eSBwb2xpY2llcyBmb3IgdmFyaW91cw0KPj4gdXNlIGNhc2VzLiBUaGVzZSBi
dWlsZGluZyBibG9ja3MgYWxvbmUgd29uJ3QgYmUgdmVyeSB1c2VmdWwuIEZvciBleGFtcGxlLA0K
Pj4gYXMgeW91IHBvaW50ZWQgb3V0LCB0byBtYWtlIHhhdHRyIGxhYmVscyB1c2VmdWwsIHdlIG5l
ZWQgc29tZSBwb2xpY2llcyANCj4+IGZvciB4YXR0ciByZWFkL3dyaXRlLg0KPj4gDQo+PiBEb2Vz
IHRoaXMgbWFrZSBzZW5zZT8NCj4gDQo+IFllcywgYnV0IEkgdGhpbmsgeW91J2xsIGVuZCB1cCB3
aXRoIGEgY29kZSBwcmV0dHkgY2xvc2UgdG8gdGhlIExhbmRsb2NrDQo+IGltcGxlbWVudGF0aW9u
Lg0KDQpBdCB0aGUgbW9tZW50LCBJIHRoaW5rIGl0IGlzIG5vdCBwb3NzaWJsZSB0byBkbyBmdWxs
IExhbmRsb2NrIGxvZ2ljIGluDQpCUEYuIFdlIGFyZSBsZWFybmluZyBmcm9tIG90aGVyIExTTXMu
IA0KDQo+IFdoYXQgYWJvdXQgYWRkaW5nIEJQRiBob29rcyB0byBMYW5kbG9jaz8gIFVzZXIgc3Bh
Y2UgY291bGQgY3JlYXRlDQo+IExhbmRsb2NrIHNhbmRib3hlcyB0aGF0IHdvdWxkIGRlbGVnYXRl
IHRoZSBkZW5pYWxzIHRvIGEgQlBGIHByb2dyYW0sDQo+IHdoaWNoIGNvdWxkIHRoZW4gYWxzbyBh
bGxvdyBzdWNoIGFjY2VzcywgYnV0IHdpdGhvdXQgZGlyZWN0bHkgaGFuZGxpbmcNCj4gbm9yIHJl
aW1wbGVtZW50aW5nIGZpbGVzeXN0ZW0gcGF0aCB3YWxrcy4gIFRoZSBMYW5kbG9jayB1c2VyIHNw
YWNlIEFCSQ0KPiBjaGFuZ2VzIHdvdWxkIG1haW5seSBiZSBhIG5ldyBsYW5kbG9ja19ydWxlc2V0
X2F0dHIgZmllbGQgdG8gZXhwbGljaXRseQ0KPiBhc2sgZm9yIGEgKHN5c3RlbS13aWRlKSBCUEYg
cHJvZ3JhbSB0byBoYW5kbGUgYWNjZXNzIHJlcXVlc3RzIGlmIG5vDQo+IExhbmRsb2NrIHJ1bGUg
YWxsb3cgdGhlbS4gIFdlIGNvdWxkIGFsc28gdGllIGEgQlBGIGRhdGEgKGkuZS4gYmxvYikgdG8N
Cj4gTGFuZGxvY2sgZG9tYWlucyBmb3IgY29uc2lzdGVudCBzYW5kYm94IG1hbmFnZW1lbnQuICBP
bmUgb2YgdGhlDQo+IGFkdmFudGFnZSBvZiB0aGlzIGFwcHJvYWNoIGlzIHRvIG9ubHkgcnVuIHJl
bGF0ZWQgQlBGIHByb2dyYW1zIGlmIHRoZQ0KPiBzYW5kYm94IHBvbGljeSB3b3VsZCBkZW55IHRo
ZSByZXF1ZXN0LiAgQW5vdGhlciBhZHZhbnRhZ2Ugd291bGQgYmUgdG8NCj4gbGV2ZXJhZ2UgdGhl
IExhbmRsb2NrIHVzZXIgc3BhY2UgaW50ZXJmYWNlIHRvIGxldCBhbnkgcHJvZ3JhbSBwYXJ0aWFs
bHkNCj4gZGVmaW5lIGFuZCBleHRlbmQgdGhlaXIgc2VjdXJpdHkgcG9saWN5Lg0KDQpHaXZlbiB0
aGVyZSBpcyBCUEYgTFNNLCBJIGhhdmUgbmV2ZXIgdGhvdWdodCBhYm91dCBhZGRpbmcgQlBGIGhv
b2tzIHRvIA0KTGFuZGxvY2sgb3Igb3RoZXIgTFNNcy4gSSBwZXJzb25hbGx5IHdvdWxkIHByZWZl
ciB0byBoYXZlIGEgY29tbW9uIEFQSQ0KdG8gd2FsayB0aGUgcGF0aCwgbWF5YmUgc29tZXRoaW5n
IGxpa2Ugdm1hX2l0ZXJhdG9yLiBCdXQgSSBuZWVkIHRvIHJlYWQNCm1vcmUgY29kZSB0byB1bmRl
cnN0YW5kIHdoZXRoZXIgdGhpcyBtYWtlcyBzZW5zZT8NCg0KVGhhbmtzLA0KU29uZw0KDQo+IEkn
bSB3b3JraW5nIG9uIGltcGxlbWVudGluZyBhdWRpdCBzdXBwb3J0IGZvciBMYW5kbG9jayBbMV0g
YW5kIEkgdGhpbmsNCj4gdGhlc2UgY2hhbmdlcyBjb3VsZCBiZSB1c2VmdWwgdG8gaW1wbGVtZW50
IEJQRiBob29rcyB0byBydW4gYSBkZWRpY2F0ZWQNCj4gQlBGIHByb2dyYW0gdHlwZSBwZXIgZXZl
bnQgKHNlZSBsYW5kbG9ja19sb2dfZGVuaWFsKCkgYW5kIHN0cnVjdA0KPiBsYW5kbG9ja19yZXF1
ZXN0KS4gIEknbGwgZ2V0IGJhY2sgb24gdGhpcyBwYXRjaCBzZXJpZXMgaW4gU2VwdGVtYmVyLg0K
PiANCj4gWzFdIGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0
L21pYy9saW51eC5naXQvbG9nLz9oPXdpcC1hdWRpdA0KDQoNCg==

