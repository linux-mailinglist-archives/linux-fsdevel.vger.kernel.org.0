Return-Path: <linux-fsdevel+bounces-34964-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3802B9CF30A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 18:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B18441F23C32
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 17:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6421D7986;
	Fri, 15 Nov 2024 17:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="J4onMEZh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D65715573A;
	Fri, 15 Nov 2024 17:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731692145; cv=fail; b=PuwJl9sHQQvh5oeJVJbH9g8DJoRB2sgn/yoEc4PPaTZgf0VSuhPGEeelLK6UQnX5Arn4iUau0zs//hM11boTWItTSQu1FCO7OCU8S9PXIMPwtf9NcJ2cvfG5SLDF6foKc7W6Oni3KlPHK4CATZNRuDU3qY1GBt0hvE5mLIwUorw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731692145; c=relaxed/simple;
	bh=VcTO7eJ6c2OCLjTFfJjnX7RT1iNLVgWz0zokxpxFyWQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=esGRLIfmvSMWoR+7wgZmpnAXcp9U+5JpEc+jabqokTCAPazU2cUFxqTND7DS8l/02hGEPu8OYQpMOHTxMgyVxUOToOhZUnjsGbCh6/YHbYr/8qidDh3uAR8YPp9FI2Ekp6NXa6IlzaYie9Xg2It/6qxuO5SdFlonCfv1a2nSJTA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=J4onMEZh; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFGZfvN015521;
	Fri, 15 Nov 2024 09:35:42 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=VcTO7eJ6c2OCLjTFfJjnX7RT1iNLVgWz0zokxpxFyWQ=; b=
	J4onMEZhGuWmpz7buxX7Kv/m/jia3XSM/zKKTZ0E6ze6zKaSye4+38vMJHgt1gD8
	QLkpxM22piqLDctUUnW2McfmDA1dntzHAnbTuaoUO7SKiTKlcR09HiBU0BGx4XQr
	rHGe0O6WxBvb21PPdvCMS86k4ptgl7npPPbveJEfSZjcEvULS77U8kMXe89iHZlT
	kFcHo6nRt0ZotsboTZdz8KsOhns8W8qs0zeXVvhKrKXzP74KUTha6af8VDuKzOlA
	pZcXm3kLyb1Zv9u88UxXAyMIIoECUsVjvYpCe6Mlg5CLOjMfNMthNmsQK2bD1TR2
	2yNq167JO3NowVl+Uc5MUg==
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2040.outbound.protection.outlook.com [104.47.70.40])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 42x6tyswvr-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Nov 2024 09:35:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QiUCLNHCQeOR8lS4iOxFna/ff3koUbQb3FkfyvR6FQ+5XfcN+kfnvijaKiBUJnGBsMk149UG1G0fVmfsiMPwFBR/n40MY/say1qrUS+skTeInokj/FoABJc3LVJqxyD9RF1+Npm0+IKlHu4nGvjab/QhzXNrbM51twm2PlPDAcW8YwbMtjRxvFmsdXdDYtdFl+sx0vQaznWHkM9fkaR0dpA/MFixpkFfzcg9k6R5AUAEqI7fdtMIbmRZkK3bFxLAIgjMZumN68MlJsgxkCy3Q1ksYyHl+CQ3mkv79cHyWUWMzmgRqH8dnAuaGA4h4xFXKhisEbsScyj+ue8/mbmkfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VcTO7eJ6c2OCLjTFfJjnX7RT1iNLVgWz0zokxpxFyWQ=;
 b=yPP2PctzGQ+6cXP7oJL4e+adkii6KoLQhWQtCxu+HIybMxNIJOJHEbHkYv17mlxGrdDhTPjtln+xl50xgthSt4e0ed0nSx151cCUdGQ4na03MRcpc84tuIIRjKrIMlI7SELeQUFDnbN4lZaQLnBorBV5i5FVFes4oznvO1HzZkNajxX1k1yerNF63g9Uyl0vOrk7QQMbQktUICeAU0/UBcg66N4+HrhyyCN37S5f8pXPchUpi2UvqPoxj0j8GC4knRiE4aRxB/2ycdB2blpduxi2JQ9Z3qI+mJ8lWHrhz7QM6XYez9iTv6y2Pium8ucEkTugMmoQk2Q7VmthEwr5hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by LV3PR15MB6717.namprd15.prod.outlook.com (2603:10b6:408:26c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Fri, 15 Nov
 2024 17:35:39 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610%3]) with mapi id 15.20.8158.017; Fri, 15 Nov 2024
 17:35:39 +0000
From: Song Liu <songliubraving@meta.com>
To: Jan Kara <jack@suse.cz>
CC: Song Liu <songliubraving@meta.com>,
        Christian Brauner
	<brauner@kernel.org>, Song Liu <song@kernel.org>,
        "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>,
        Kernel Team <kernel-team@meta.com>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "eddyz87@gmail.com"
	<eddyz87@gmail.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "martin.lau@linux.dev"
	<martin.lau@linux.dev>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "kpsingh@kernel.org" <kpsingh@kernel.org>,
        "mattbobrowski@google.com"
	<mattbobrowski@google.com>,
        "amir73il@gmail.com" <amir73il@gmail.com>,
        "repnop@google.com" <repnop@google.com>,
        "jlayton@kernel.org"
	<jlayton@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        "mic@digikod.net"
	<mic@digikod.net>,
        "gnoack@google.com" <gnoack@google.com>
Subject: Re: [PATCH bpf-next 2/4] bpf: Make bpf inode storage available to
 tracing program
Thread-Topic: [PATCH bpf-next 2/4] bpf: Make bpf inode storage available to
 tracing program
Thread-Index: AQHbNNya8stOo5GwQE2QhVtvXBjXrrK1AUcAgAJInwCAAOzHAIAAaR8A
Date: Fri, 15 Nov 2024 17:35:39 +0000
Message-ID: <E79EFA17-A911-40E8-8A51-CB5438FD2020@fb.com>
References: <20241112082600.298035-1-song@kernel.org>
 <20241112082600.298035-3-song@kernel.org>
 <20241113-sensation-morgen-852f49484fd8@brauner>
 <86C65B85-8167-4D04-BFF5-40FD4F3407A4@fb.com>
 <20241115111914.qhrwe4mek6quthko@quack3>
In-Reply-To: <20241115111914.qhrwe4mek6quthko@quack3>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.200.121)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|LV3PR15MB6717:EE_
x-ms-office365-filtering-correlation-id: 6d960373-4b5e-4a51-bebd-08dd059bebd1
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|7416014|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?K0Q3SXZEWUw3aFhBdERDN3BTa1JYb1N4QnB6bnQ4U2RaMGhsU3Z3WE1MZ2Nr?=
 =?utf-8?B?YUh6Y0pVanYyVXVoZlFOd3VoYnJJSHpaMFNSSDk1ZW0wTm1zc1lHQndnS1RP?=
 =?utf-8?B?ZFloaStTSmkrb1dhSE16V3lDdHZwNDBwWXhoVkNWbWM4NWpDakwxbTZsbkdx?=
 =?utf-8?B?R2xibGljYTRZRkN3ZFVkSVlORXFnVjFEaWN0U3FYaUlvNWp0MmZ4ODV6SFY0?=
 =?utf-8?B?MHIvS2s3ZEFGY0RoOVFONi8xZ1RKS09jdmc2SFFVWUdHZ2xNemxXdUdPUUJC?=
 =?utf-8?B?UmNTUnhwUVBqZ0tZbkx1TnF0U2F1UlhtT1F2aGhFaFVLODJhTUVyTkl4WERy?=
 =?utf-8?B?bFN3cTk3Z1hZZ1QvcXNtOHRHaFZHSkVCWG5xT3UzN3d0SmNwVEh0M3U3K2pT?=
 =?utf-8?B?QXlGVkxMSnE4K29FdVNsUWNjRzJuS0gvSE8rUGVNYkZqVVJRY1JMaTBGdWFs?=
 =?utf-8?B?aCtycEdCRGgyNjU3akJWZ3k0NlgwTXhLVWlLQ0xyMXJXTjFDM2NKNkVHZ2xh?=
 =?utf-8?B?d1pMN240WmVOeHBZZ2Zhclo5UnVOTExJeGExRUhmRzhhVVNyZ1hQMGs0M1pn?=
 =?utf-8?B?ZEpRLzNRaGNtL0ZDOTZ3Nm9xa1NxWDhiUFc4dWxJdXM1NzRIQy92NmFocEFL?=
 =?utf-8?B?SjRnaWRVV3BrSUdWZHNFRThuM2FTZzlSOWk1ZFdGcENVS1FSODBhZi9EejZB?=
 =?utf-8?B?M0V0MFNWNnVQL3pHV1FWdUo1eEtGQzZsclNlS1pqOWdldTBNbTgwUm0vTk5Y?=
 =?utf-8?B?QkVKUnpXdGljTWlGbCtOSDl6aWhXUTB5bklTSnNWR2g2ZVo2S3V5cnFhTUNO?=
 =?utf-8?B?NnZrVmx5bXFxYmM3aFF3WTUrbGZZT0dVaVFadnhIdU5hYU5IQ2k4R1ZSUnM5?=
 =?utf-8?B?WUlKb1AyRnVkV3RSbEQxR0Zvd2V1MzJRTEdCeHlPVDNUZXovU28zbVF3QnJB?=
 =?utf-8?B?Njl6Tlc2M1RWZEJ4b1NReGJIM3FnV0k2NHV0R2tSWGxDMEhKNkthQ2lzNGZP?=
 =?utf-8?B?eFErTEJ5OE9zcTJBZmswWWMzYkVHSXlZK1hzYldtemk1VkE0TGU2amVHdWhK?=
 =?utf-8?B?STIraWpTUGo3K25XZ3NuZnJ0YWFCcG9VOU9wcDV1SDR0NE1IVXVvQ3NMeHdM?=
 =?utf-8?B?TmRiN0RIY043eXJMMGRNMVFsVnVrdnJMVlRpb2V6cHVEa2gvRXdhcXdLbFBv?=
 =?utf-8?B?ekk0Sk00Y0lzcEZMMnhHMGw3R1dZaEV3T3FSTkp0USs3c29YTmRaeHVkdDM5?=
 =?utf-8?B?dEJOUk5LYWwydFo5M1ZOM3RUa0d5a3N5c0FKYldlQ25ZODhDcjZhR2NvN21h?=
 =?utf-8?B?SnQwS0tkeGcvYVpFNXd5U2RNeFludTgvbzhWSjhsWjJ6OFd3SGFoY01TQk5q?=
 =?utf-8?B?RDFIazRZSy93UGxVL2NsbnljOVBxcWE3TkdyeHdnRmtLcmYzaDE1QUhLOEh4?=
 =?utf-8?B?SXozNHVENFdQdFBrMlhkaGwzb0FxeHNmY21RVVY0akNXa25wV3JBYitHWnla?=
 =?utf-8?B?UGZtQVpVZFc4cDAvb3QyMkd6Q3FDczVaSVlCcDdGbnZCYnQrSDgzb05kMW1k?=
 =?utf-8?B?Z1E0NkV4R25ydkk5am5vVzBSTXNkeWdhcExoNCsrRDJBZ0M2RjZ5VTZDVUh0?=
 =?utf-8?B?QkplTGhIaUhmZXRWcC9ZcUx5NGkvWjA4MjA2VHdYWlFLYjlXWnhjYkdHTk1E?=
 =?utf-8?B?NEJTc3l2Y0VXYjdtb285N294NmlOQjA5NjBCUCtkUDMvN2tsUlBtMlRpY2dU?=
 =?utf-8?Q?rldY0LabAwlwnJlzeJt1hjl1JEjorE7S4cs/KPC?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZTNhdzZONW1CVk9DTzQ2QmNLK0RwS2p6ckxsUGkwdHduK0pDWUsydGlDN0g2?=
 =?utf-8?B?azZKQ3RXbFFQUUtDYmxlWFJjTGtqaVdYYWlzREZLQ0s2MHZnUW9YYmRZQTF6?=
 =?utf-8?B?Q3BVQ1RQMnh1cW90KzZzUHhaNytjcFA5cG10dHp2bUp4SUtnOEtudmQvZ202?=
 =?utf-8?B?WWxCWTlJQjVWc29PMnh0Y29lOEU4Z0FpdE9QTjFnRUZwRlhsRXN3eW1BQXRO?=
 =?utf-8?B?Q20wY0hYOE9qZTEzelNUSW84M054SjBxcENZSUlINkxGNjBaaDQ4U0R5R2Uz?=
 =?utf-8?B?bm1jTWNRRTR2Vjd5SkxuRWpodUpwbHNYcjhVZUs1VEJWNDdUcjMvdnp2bVI2?=
 =?utf-8?B?NGR6dm1MeE0vOXV0bERmcDdnSWRxV0E2TzJXMXFMR1BJbVkyK25rcmVHcWJJ?=
 =?utf-8?B?VXV6SDFIelo2V3dXaXpSUks0NmNjenY1ZmFOMExKUnM2cE5MREhuMlRzZWVv?=
 =?utf-8?B?dENXcFNsR2ttNmxhVE0yK05IWU9adkt5QlFSdHFvZE5ZZ1BMR1o1OTAvcUNy?=
 =?utf-8?B?L2RIY0NSSVBTNS9aWnptWHdYZjFwR3NiTTU3UTJnT1FQendONVBnOWtvNFFI?=
 =?utf-8?B?L1NwNmlRdjkwMVYrd2JhTzFpVDR3d0VtMHVKdW9abHBOYm1DSWZYZlYwUGgx?=
 =?utf-8?B?T0Q2TUhTQTR3STVGZWdCaUc3SFlnMGdUcnlDMkNsM2hFckhuZmJuSTFVdkpu?=
 =?utf-8?B?cnZRQi85MEU0U3IwazJ0UUJ2S096SnVvemJaMHY4K3RiRDgwSDdJMzFVcGxt?=
 =?utf-8?B?OWdZdFlBa3E2OEVvQlJpb0VGMXBIM1Z5SVZrRHBTNWd3YnF5SGhzTE5TT1RW?=
 =?utf-8?B?alo4WHRrNDEydjd0QnZCUHllUm0vMjIwd0o1SUxaeHNTZlhxUFltNm92RkRz?=
 =?utf-8?B?UW1OaGZyMVA5NzJvU3lsWng2WUM1S3EzQmlweThEdVREWitzbVZFSDNWZUdB?=
 =?utf-8?B?WkFSYUVXRlFiU0Z0UnpKUk1vWmYrcUdnK2ZYVWVKZ1FnZ3JSZGdwVFBnOEN0?=
 =?utf-8?B?Q1ZuekU1S3poaWlyTWo1NU05ZFRHTVJ0bjhyY25Ea3dhY1B6ZDFMRFJOcmY4?=
 =?utf-8?B?U3dGamdYdE95YXB1UVBRQjA0T3VFSnI5M3UrcFVDSVpSOStpZjlyQSthRW0r?=
 =?utf-8?B?ajZaSlNwdUhWQ1dBUW94M29yajQ5VGhKY3FBRXArenpuNWx0Wms0R2d6UmVO?=
 =?utf-8?B?TjR6L0d5T0dzYmdCOEFLc1c2VVJEVEx2bUJidG01eWdrTG5tdGU2REd0TUVL?=
 =?utf-8?B?WTY0ZDZ4Vlp0NnlBSnhhWDdKLzFQUnBxeEtiM2xhaDFzeDVzODB2eHhxazJ6?=
 =?utf-8?B?ODlNRUlkc2RTYnhtS1VTeXd5STJrMXRpSkd6UkE3WWtjQm14b0J4NVp6eXFV?=
 =?utf-8?B?bzFGSUp6ZEx0VXFLZGZlZ3R3Nm15NllwNWtjRzNwMnp6MkNKOWcxTVM4SkZ2?=
 =?utf-8?B?OStiMUhYWlk5QUtKVFhlSStuaWkzd2xTcFNqOVhRUXlwOHkvVlhPWW1EazZM?=
 =?utf-8?B?a09ScWlZSUNzeVZtRzdvUU9qdjEvM3FUN0FXdm50YnlEdnlpMU9mQXZvWUNU?=
 =?utf-8?B?L3FZMWJVMkZHNEhkUFBnaFhINW04Q1J4UkNSU2Z6R3dTMlJHWCtIT21nYzdn?=
 =?utf-8?B?a2pLNDE1WU1ocFZOMkQ5R0Zwd3pIajV4eXJ2RkxJem1YT3EyTmt6ZERNSDFF?=
 =?utf-8?B?alVpRVRVeVNaT3R3RCtsQVg3bThZMWh4bU5EZVJLblVnOXVpS20wcTYrV2FL?=
 =?utf-8?B?clduUnZVeGlLSVlFLzNXajAvWVp6bm4vMnZCV29NZUVzMVI4cnhwUVZkcDlH?=
 =?utf-8?B?aG1nVmI4VGw5U2VWbGZmVDEzMFBIWjBYWHEzdWcrL0ZjZEpYRjJKTFUwZUl2?=
 =?utf-8?B?Yml3aEU2aFBYNVIrSTNRVGQ0N1hEZE9INjBzQnkrQVB5ZlQrZGZRUkkwNzdQ?=
 =?utf-8?B?TTdlR1NsR2JuU3RzNjRibXdDWENjZzJUM2VnV1drVC9uOVA0OGZkamFmZTU0?=
 =?utf-8?B?Rk9CTHFXZHduRUQwUitmTEpneDIwYVc1NTNpdTh0VzlwbmNxL2JIM1JZeSs1?=
 =?utf-8?B?NmJqWmFrK0dJVk1QZnVMTjQwNkJGdlBvWjl3cDYvYVRXQ2k4RldPZHlnWG1z?=
 =?utf-8?B?MkhDV1Y3c0lKa3hOYVNIMzhKOVE1L3VNaGN5VU1RSEhTWEkrclR6YmcxT0hL?=
 =?utf-8?Q?t8q3m+eabz3531E4Li2Ijak=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <74F64D3974255E46B8530844959CC577@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d960373-4b5e-4a51-bebd-08dd059bebd1
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2024 17:35:39.0841
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gz70HsiMqlGlEjxIBf0tRQXIlTrkMyBCtXDi2yPnvWK0WOCRk5yFQsZcqVbnczqDNeQIAP6vjQTYjoPu4PywbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR15MB6717
X-Proofpoint-GUID: tOvSjnQX8sI03BjLnE2aFTyd6RNlv54x
X-Proofpoint-ORIG-GUID: tOvSjnQX8sI03BjLnE2aFTyd6RNlv54x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

SGkgSmFuLCANCg0KPiBPbiBOb3YgMTUsIDIwMjQsIGF0IDM6MTnigK9BTSwgSmFuIEthcmEgPGph
Y2tAc3VzZS5jej4gd3JvdGU6DQoNClsuLi5dDQoNCj4+IEFGQUlDVCwgd2UgbmVlZCB0byBtb2Rp
ZnkgaG93IGxzbSBibG9iIGFyZSBtYW5hZ2VkIHdpdGggDQo+PiBDT05GSUdfQlBGX1NZU0NBTEw9
eSAmJiBDT05GSUdfQlBGX0xTTT1uIGNhc2UuIFRoZSBzb2x1dGlvbiwgZXZlbg0KPj4gaWYgaXQg
Z2V0cyBhY2NlcHRlZCwgZG9lc24ndCByZWFsbHkgc2F2ZSBhbnkgbWVtb3J5LiBJbnN0ZWFkIG9m
IA0KPj4gZ3Jvd2luZyBzdHJ1Y3QgaW5vZGUgYnkgOCBieXRlcywgdGhlIHNvbHV0aW9uIHdpbGwg
YWxsb2NhdGUgOA0KPj4gbW9yZSBieXRlcyB0byBpbm9kZS0+aV9zZWN1cml0eS4gU28gdGhlIHRv
dGFsIG1lbW9yeSBjb25zdW1wdGlvbg0KPj4gaXMgdGhlIHNhbWUsIGJ1dCB0aGUgbWVtb3J5IGlz
IG1vcmUgZnJhZ21lbnRlZC4NCj4gDQo+IEkgZ3Vlc3MgeW91J3ZlIGZvdW5kIGEgYmV0dGVyIHNv
bHV0aW9uIGZvciB0aGlzIGJhc2VkIG9uIEphbWVzJyBzdWdnZXN0aW9uLg0KPiANCj4+IFRoZXJl
Zm9yZSwgSSB0aGluayB3ZSBzaG91bGQgcmVhbGx5IHN0ZXAgYmFjayBhbmQgY29uc2lkZXIgYWRk
aW5nDQo+PiB0aGUgaV9icGZfc3RvcmFnZSB0byBzdHJ1Y3QgaW5vZGUuIFdoaWxlIHRoaXMgZG9l
cyBpbmNyZWFzZSB0aGUNCj4+IHNpemUgb2Ygc3RydWN0IGlub2RlIGJ5IDggYnl0ZXMsIGl0IG1h
eSBlbmQgdXAgd2l0aCBsZXNzIG92ZXJhbGwNCj4+IG1lbW9yeSBjb25zdW1wdGlvbiBmb3IgdGhl
IHN5c3RlbS4gVGhpcyBpcyB3aHkuIA0KPj4gDQo+PiBXaGVuIHRoZSB1c2VyIGNhbm5vdCB1c2Ug
aW5vZGUgbG9jYWwgc3RvcmFnZSwgdGhlIGFsdGVybmF0aXZlIGlzIA0KPj4gdG8gdXNlIGhhc2gg
bWFwcyAodXNlIGlub2RlIHBvaW50ZXIgYXMga2V5KS4gQUZBSUNULCBhbGwgaGFzaCBtYXBzIA0K
Pj4gY29tZXMgd2l0aCBub24tdHJpdmlhbCBvdmVyaGVhZCwgaW4gbWVtb3J5IGNvbnN1bXB0aW9u
LCBpbiBhY2Nlc3MgDQo+PiBsYXRlbmN5LCBhbmQgaW4gZXh0cmEgY29kZSB0byBtYW5hZ2UgdGhl
IG1lbW9yeS4gT1RPSCwgaW5vZGUgbG9jYWwgDQo+PiBzdG9yYWdlIGRvZXNuJ3QgaGF2ZSB0aGVz
ZSBpc3N1ZSwgYW5kIGlzIHVzdWFsbHkgbXVjaCBtb3JlIGVmZmljaWVudDogDQo+PiAtIG1lbW9y
eSBpcyBvbmx5IGFsbG9jYXRlZCBmb3IgaW5vZGVzIHdpdGggYWN0dWFsIGRhdGEsIA0KPj4gLSBP
KDEpIGxhdGVuY3ksIA0KPj4gLSBwZXIgaW5vZGUgZGF0YSBpcyBmcmVlZCBhdXRvbWF0aWNhbGx5
IHdoZW4gdGhlIGlub2RlIGlzIGV2aWN0ZWQuIA0KPj4gUGxlYXNlIHJlZmVyIHRvIFsxXSB3aGVy
ZSBBbWlyIG1lbnRpb25lZCBhbGwgdGhlIHdvcmsgbmVlZGVkIHRvIA0KPj4gcHJvcGVybHkgbWFu
YWdlIGEgaGFzaCBtYXAsIGFuZCBJIGV4cGxhaW5lZCB3aHkgd2UgZG9uJ3QgbmVlZCB0byANCj4+
IHdvcnJ5IGFib3V0IHRoZXNlIHdpdGggaW5vZGUgbG9jYWwgc3RvcmFnZS4NCj4gDQo+IFdlbGws
IGJ1dCBoZXJlIHlvdSBhcmUgc3BlYWtpbmcgb2YgYSBzaXR1YXRpb24gd2hlcmUgYnBmIGlub2Rl
IHN0b3JhZ2UNCj4gc3BhY2UgZ2V0cyBhY3R1YWxseSB1c2VkIGZvciBtb3N0IGlub2Rlcy4gVGhl
biBJIGFncmVlIGlfYnBmX3N0b3JhZ2UgaXMgdGhlDQo+IG1vc3QgZWNvbm9taWMgc29sdXRpb24u
IEJ1dCBJJ2QgYWxzbyBleHBlY3QgdGhhdCBmb3IgdmFzdCBtYWpvcml0eSBvZg0KPiBzeXN0ZW1z
IHRoZSBicGYgaW5vZGUgc3RvcmFnZSBpc24ndCB1c2VkIGF0IGFsbCBhbmQgaWYgaXQgZG9lcyBn
ZXQgdXNlZCwgaXQNCj4gaXMgdXNlZCBvbmx5IGZvciBhIHNtYWxsIGZyYWN0aW9uIG9mIGlub2Rl
cy4gU28gd2UgYXJlIHdlaWdodGluZyA4IGJ5dGVzDQo+IHBlciBpbm9kZSBmb3IgYWxsIHRob3Nl
IHVzZXJzIHRoYXQgZG9uJ3QgbmVlZCBpdCBhZ2FpbnN0IG1vcmUgc2lnbmlmaWNhbnQNCj4gbWVt
b3J5IHNhdmluZ3MgZm9yIHVzZXJzIHRoYXQgYWN0dWFsbHkgZG8gbmVlZCBwZXIgaW5vZGUgYnBm
IHN0b3JhZ2UuIEENCj4gZmFjdG9yIGluIHRoaXMgaXMgdGhhdCBhIGxvdCBvZiBwZW9wbGUgYXJl
IHJ1bm5pbmcgc29tZSBkaXN0cmlidXRpb24ga2VybmVsDQo+IHdoaWNoIGdlbmVyYWxseSBlbmFi
bGVzIG1vc3QgY29uZmlnIG9wdGlvbnMgdGhhdCBhcmUgYXQgbGVhc3Qgc29tZXdoYXQNCj4gdXNl
ZnVsLiBTbyBoaWRpbmcgdGhlIGNvc3QgYmVoaW5kIENPTkZJR19GT08gZG9lc24ndCByZWFsbHkg
aGVscCBzdWNoDQo+IHBlb3BsZS4NCg0KQWdyZWVkIHRoYXQgYW4gZXh0cmEgcG9pbnRlciB3aWxs
IGJlIHVzZWQgaWYgdGhlcmUgaXMgbm8gYWN0dWFsIHVzZXJzDQpvZiBpdC4gSG93ZXZlciwgaW4g
bG9uZ2VyIHRlcm0sICJtb3N0IHVzZXJzIGRvIG5vdCB1c2UgYnBmIGlub2RlDQpzdG9yYWdlIiBt
YXkgbm90IGJlIHRydWUuIEFzIGtlcm5lbCBlbmdpbmVlcnMsIHdlIG1heSBub3QgYWx3YXlzIG5v
dGljZSANCndoZW4gdXNlciBzcGFjZSBpcyB1c2luZyBzb21lIEJQRiBmZWF0dXJlcy4gRm9yIGV4
YW1wbGUsIHN5c3RlbWQgaGFzDQphIEJQRiBMU00gcHJvZ3JhbSAicmVzdHJpY3RfZmlsZXN5c3Rl
bXMiIFsxXS4gSXQgaXMgZW5hYmxlZCBpZiB0aGUgDQp1c2VyIGhhdmUgbHNtPWJwZiBpbiBrZXJu
ZWwgYXJncy4gSSBwZXJzb25hbGx5IG5vdGljZWQgaXQgYXMgYSANCnN1cnByaXNlIHdoZW4gd2Ug
ZW5hYmxlZCBsc209YnBmLiANCg0KPiBJJ20gcGVyc29uYWxseSBub3QgKnNvKiBodW5nIHVwIGFi
b3V0IGEgcG9pbnRlciBpbiBzdHJ1Y3QgaW5vZGUgYnV0IEkgY2FuDQo+IHNlZSB3aHkgQ2hyaXN0
aWFuIGlzIGFuZCBJIGFncmVlIGFkZGluZyBhIHBvaW50ZXIgdGhlcmUgaXNuJ3QgYSB3aW4gZm9y
DQo+IGV2ZXJ5Ym9keS4NCg0KSSBjYW4gYWxzbyB1bmRlcnN0YW5kIENocmlzdGlhbidzIG1vdGl2
YXRpb24uIEhvd2V2ZXIsIEkgYW0gYSBiaXQNCmZydXN0cmF0ZWQgYmVjYXVzZSBzaW1pbGFyIGFw
cHJvYWNoIChhZGRpbmcgYSBwb2ludGVyIHRvIHRoZSBzdHJ1Y3QpIA0Kd29ya2VkIGZpbmUgZm9y
IG90aGVyIHBvcHVsYXIgZGF0YSBzdHJ1Y3R1cmVzOiB0YXNrX3N0cnVjdCwgc29jaywgDQpjZ3Jv
dXAuIA0KDQo+IExvbmdlciB0ZXJtLCBJIHRoaW5rIGl0IG1heSBiZSBiZW5lZmljaWFsIHRvIGNv
bWUgdXAgd2l0aCBhIHdheSB0byBhdHRhY2gNCj4gcHJpdmF0ZSBpbmZvIHRvIHRoZSBpbm9kZSBp
biBhIHdheSB0aGF0IGRvZXNuJ3QgY29zdCB1cyBvbmUgcG9pbnRlciBwZXINCj4gZnVuY2lvbmFs
aXR5IHRoYXQgbWF5IHBvc3NpYmx5IGF0dGFjaCBpbmZvIHRvIHRoZSBpbm9kZS4gV2UgYWxyZWFk
eSBoYXZlDQo+IGlfY3J5cHRfaW5mbywgaV92ZXJpdHlfaW5mbywgaV9mbGN0eCwgaV9zZWN1cml0
eSwgZXRjLiBJdCdzIGFsd2F5cyBhIHRvdWdoDQo+IGNhbGwgd2hlcmUgdGhlIHNwYWNlIG92ZXJo
ZWFkIGZvciBldmVyeWJvZHkgaXMgd29ydGggdGhlIHJ1bnRpbWUgJg0KPiBjb21wbGV4aXR5IG92
ZXJoZWFkIGZvciB1c2VycyB1c2luZyB0aGUgZnVuY3Rpb25hbGl0eS4uLg0KDQpJdCBkb2VzIHNl
ZW0gdG8gYmUgdGhlIHJpZ2h0IGxvbmcgdGVybSBzb2x1dGlvbiwgYW5kIEkgYW0gd2lsbGluZyB0
byANCndvcmsgb24gaXQuIEhvd2V2ZXIsIEkgd291bGQgcmVhbGx5IGFwcHJlY2lhdGUgc29tZSBw
b3NpdGl2ZSBmZWVkYmFjaw0Kb24gdGhlIGlkZWEsIHNvIHRoYXQgSSBoYXZlIGJldHRlciBjb25m
aWRlbmNlIG15IHdlZWtzIG9mIHdvcmsgaGFzIGEgDQpiZXR0ZXIgY2hhbmNlIHRvIHdvcnRoIGl0
LiANCg0KVGhhbmtzLA0KU29uZw0KDQpbMV0gaHR0cHM6Ly9naXRodWIuY29tL3N5c3RlbWQvc3lz
dGVtZC9ibG9iL21haW4vc3JjL2NvcmUvYnBmL3Jlc3RyaWN0X2ZzL3Jlc3RyaWN0LWZzLmJwZi5j

