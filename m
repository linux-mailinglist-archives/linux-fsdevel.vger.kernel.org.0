Return-Path: <linux-fsdevel+bounces-52366-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF99DAE23C7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 22:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89F9A16F70C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 20:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BCDA23E347;
	Fri, 20 Jun 2025 20:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="en9HLza/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5415C230BCC;
	Fri, 20 Jun 2025 20:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750452543; cv=fail; b=aDEUeBylWLDJuHxd3Tw1Ucp8MpEswEPv0n6V8fvTLkCNTrD2EON92PRbl2PehTDPqlIKiTJXRMGjKpgqgt47ZBK4IVEH+Q4Ud0Ty6y/z4jaI+KeH5Ht9y58ch7mQMijN8CFNabvBWaEEA78CLJLGJTINPJ7U8QfR3ttfq96yNBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750452543; c=relaxed/simple;
	bh=H8PMmSarB6NhEMatBGPUs+tdH5mMlnMYfnw4PLk5WII=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tCRr3mLm5aW7QT6MFqsuZCquBgo+ndf0nTkAUZDwfBzkEXxfPwUQVQE383965xgdc4NG+h2lDCU/xTbVE/e+YJq6C4nuqxtcP8ksQK5YccqAPm7RhMyBHHHHQr5JOtLpJ8OyTvlQgSIESMSpw5GZ9OVmqOoNqQReLhJ5RWaHyKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=en9HLza/; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55KJb59p013654;
	Fri, 20 Jun 2025 13:49:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=H8PMmSarB6NhEMatBGPUs+tdH5mMlnMYfnw4PLk5WII=; b=
	en9HLza/onjr/eE8PbZx9CpaX+wA1Xu5+epwMveQrYjnc3mVx6BHMKC52vQMVY+5
	MtTuQRwwtbXmtnXjTf8TPo1pu49NO/4ewdfEKwk0TBXtLcGEQGhtCGt6O3rid4CK
	U5GRlCKf1c5as/WWnODNnfQaIVUR54MOyvQzqFoTzIfVEB6rDvQtryorxf1Htbk8
	d5J6Xlnp5jipCVTWpuTiuhS0ifm4jw3hFI9i2+10JHH+Wezq1tsahkq0GwOcEWoa
	AgSMb5xhMG0/SLSYEubHXh3WVMmQWzNU0Y61dFFbyXFyfFFbaOBT1lQSPsNsJeoU
	n+hSh7Q8tn4zK7YGZ7yHlA==
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 47cun4egqb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Jun 2025 13:49:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f3l+VQVvLOijNnL2Fzt44IbUpqVIVyZO2V6VvfrirDtd4JA68rAq/aokfdxzqtyC3+zSE4MgAempm/9q4+71sN0UqWcA7TBPOdB+ZaEYKds7ddtm2jLbDtbshtXzSwXxsr/L86g7CtsZfgu9S9AItVGQS5lKROdGyyUQRtu+nJPpmd0LG6aqSkZcDO0qcYbZI7zHKZrYR//S0++Jc2QdTqOqpAt+YHNtbcEp3IKCU3xB/NAK6pcofW+9IEvmCZxb5CCrSSyns7Hf/MwG0Q7C7+/2kiQ4T33nlwKqP3kVy3qSDBBRSawdVpGH3OOID9nc6Ep1cMwNbXK41WBQ+35W0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H8PMmSarB6NhEMatBGPUs+tdH5mMlnMYfnw4PLk5WII=;
 b=WjbcfYt3yQoku/ZJMzZtGyFfTKhK2qTDpA2ePPob1dqrXBlhh1ti2YigKFzuIH0s2d4jce/uLcozBfDb7wXRpgJsTiyn2k6A8rmmH/bO9U7s/1atqG9potxODM9Y4OOytgga8p1rR+5/OjFxioJdo0/ITs488N+E1HkpJVsd2ErYpo9GSreqtEi1iuGb18VRhAm//uj3YZl3iG6Cbw1xGFh0eZacJ1DVTp1eGVOgb5nZX+5Jp3GNRmkVFcLgQHLfTi8YhCofKUT8ZcpDbyeFT9/iVqsoDvzWH6feQhzk1UdX/MrjZeKVHDHsplF6hKP+tuyBtzqUtHWuzDTUHlkmkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by PH7PR15MB5737.namprd15.prod.outlook.com (2603:10b6:510:277::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.26; Fri, 20 Jun
 2025 20:48:23 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610%6]) with mapi id 15.20.8857.022; Fri, 20 Jun 2025
 20:48:23 +0000
From: Song Liu <songliubraving@meta.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC: Song Liu <song@kernel.org>, bpf <bpf@vger.kernel.org>,
        Linux-Fsdevel
	<linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        LSM
 List <linux-security-module@vger.kernel.org>,
        Kernel Team
	<kernel-team@meta.com>,
        Andrii Nakryiko <andrii@kernel.org>, Eduard
	<eddyz87@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann
	<daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Alexander
 Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan
 Kara <jack@suse.cz>,
        KP Singh <kpsingh@kernel.org>,
        Matt Bobrowski
	<mattbobrowski@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, Daan
 De Meyer <daan.j.demeyer@gmail.com>
Subject: Re: [PATCH v2 bpf-next 5/5] bpf: Make bpf_cgroup_read_xattr available
 to cgroup and struct_ops progs
Thread-Topic: [PATCH v2 bpf-next 5/5] bpf: Make bpf_cgroup_read_xattr
 available to cgroup and struct_ops progs
Thread-Index: AQHb4WXSxvH03hTOjE2ZPY/FeQ2tXrQMXJ6AgAAp3AA=
Date: Fri, 20 Jun 2025 20:48:22 +0000
Message-ID: <6E50D47F-EC06-417C-8512-9CAA3734821E@meta.com>
References: <20250619220114.3956120-1-song@kernel.org>
 <20250619220114.3956120-6-song@kernel.org>
 <CAADnVQLCyk4O6w4WRxTKcQsEdZ3y6_CNc4mBF2ieT9m51E+2Lw@mail.gmail.com>
In-Reply-To:
 <CAADnVQLCyk4O6w4WRxTKcQsEdZ3y6_CNc4mBF2ieT9m51E+2Lw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.600.51.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|PH7PR15MB5737:EE_
x-ms-office365-filtering-correlation-id: a8cc1d53-bcb7-4d0a-fe28-08ddb03bcc17
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?V3dzZTRKbk1VazhXU2daTFE0UXQwbWs3a1hCZWt4aUJaR3dLWlNTUjVYVHM5?=
 =?utf-8?B?Mks5NmxxWjU2dnV2NGIxbzJxbjNES3NSc2ZRMERkaGZrM3c3ZTR6bjFENERS?=
 =?utf-8?B?OGM4T3NOV0JVUzl3RHI4RWRrR0JJc2VMY1p0VFVDZmh6dmIzZ0dLdTlzY2FT?=
 =?utf-8?B?UGphWE94M0FlRjAvWVcyanIwdzZ1OW13ZzZMY0o0Qy9KZXI0dDdXWDJPL2Jm?=
 =?utf-8?B?Smxkd0daMjVtbHVnY2FHOGdIQmNPYWFEYUh0Q1R2UmFQQVVMTUR5ZVVydm52?=
 =?utf-8?B?T0l4d3NKZ3VSWnhxY3ozSG5JZVpkemNJWGlyRHA2dkliZURBbEpxeGlKTWZi?=
 =?utf-8?B?R3VqK3k2M1d5WTE5U0hENUx6UTlsSk9aRVg1ZDJLeTN0d3o2bzNhbGNHNXJy?=
 =?utf-8?B?QU1JRXdFWUc4T0doWFVTdTlMRUdiVVFZdjB6Rk1lN0hLOVFsQnpldzhEZ0My?=
 =?utf-8?B?Z3M4MU9vTllyNTVkY0tJMkc1SzVRTHVCS0NTVXlYK0VMazVSb0tzTXg3Mjgw?=
 =?utf-8?B?Z29FR0F2V01nUVpRRkVFNGQ2UHV4eG1lRkZkV2N3bEwzbnRZNDFwVG5wNFo5?=
 =?utf-8?B?c3A4c2o2MkFLUmw2OUg4ZDFhT0Y3RTQ1b2gxYmVjV0l0Rk5GNDUzMlY4Tks5?=
 =?utf-8?B?WDZLY203V2hwMzdreWdqSkpqbjFiOGpmdWltbUZBaUdidkRPMDF2V2dxSmdv?=
 =?utf-8?B?TXJTVzhrc1NwcUNKaTFaSFhlWW9DbmpmNk5uQVpkSE9ScklQRGs4MVpuckVZ?=
 =?utf-8?B?Z0U2NzZta2dwU2Qyb2d1SzRzenRSOFBLUUt6eVFPSkMzd1gvejZXWnFlclM1?=
 =?utf-8?B?Tm0vaFpkaEhEdjJiMDVXTXExSWx1SzI5aWIwSExaNEMwRTRtRnNoMlVPOE9j?=
 =?utf-8?B?Yi9GRWpYWGhJWTVXRkVPR04vbVR4QUoxQ01NTm1VZ0hLOE0vbDZsSVRSWXRq?=
 =?utf-8?B?dU5ybE5sTFNxUWJWRXZHZU04YzIrUG52V0I5MDU3YjdiTE5TNVJUdkxNNERw?=
 =?utf-8?B?eHpkSGQraHpkR2dwV2liVjd2WFhTU2tLN2VIWWEyVVdWbmJ0TGR2YjRNT3RN?=
 =?utf-8?B?dFBVWXRWNEdUOGh0VWZTandnOXJ6QWJvZHFxVXU1VDlNRVl3ZHVXcWhTWGxh?=
 =?utf-8?B?dFJxdllYK3NwWVRPZ2hPRXpGZDJpYWxPU1JPc3cvczBiOEd2c2YxaFlZaFA1?=
 =?utf-8?B?UXlWeVhGT2pqTUtDd1VsWmkwakpMaFQyTktYaHE3MlZueG5xM00vSFhuNmlQ?=
 =?utf-8?B?U1U2ZzAzaXBqRHV5SHFKQUJoS0U3bk54cUFJS0R4bmUxQzE4OXdKaStrTm12?=
 =?utf-8?B?NzNOdUVmK3lZdDFFbTI0NUpSTGlqRHptYmlISlQ1LzYxZHhEd1lQWU9NZ1g1?=
 =?utf-8?B?S05HTDd6ZmZzNHNyWE1oMjVSQlkxWDUxdkNHRmozNEl6ZnJzZEc5dVIyT0Fu?=
 =?utf-8?B?enRSaDB5R1MxdHdoQ3VQS1hCcWpJREUvOWJXS3U5RXpEQkNuWDAzSDhvY0xY?=
 =?utf-8?B?MWFBTFFXTVJVeGo5WGhaL2lUYmN2N2djVDVINkVxSGxqMnF1Q09kSHFmUG5J?=
 =?utf-8?B?TzcvRC85M1AxU3hXYUNUSGJFdlVOUEZnWFkwRnIwVENoR3c3aWhXV0JEZVVk?=
 =?utf-8?B?MUxlbll6eFFkcFN5dzc5cXJNa056NU1TRnM5V1V2YVZBR2prQ2RlZFV5YXdD?=
 =?utf-8?B?VVcvN0pCMHorTVBhZ0Z2eC9qZmkvc0ZtV3V3UFFXT1R0Y21UbFc5NTBhek51?=
 =?utf-8?B?WXhoR3JCSW5UbHNCS3RVMzVOdlJOdXZhTTNsTDBOSDkrcnlyVlQ2NWNnWUx2?=
 =?utf-8?B?ZUt5M0p4cE5ESDZMWTZQbCsrQmZmeUE5VENrVWQ1eVJjbytabGVMQTc0VmxS?=
 =?utf-8?B?NXdTZmRDcHc1Ni9teVh4NDJLaVdSb1BYS0dZQ3NvSm1kcXJtbVBmNWppWjBl?=
 =?utf-8?B?QVlYdVlvc0RleGRGR2FhRitVMmRkSnZhSjUrcXJvaUIzRE9YREFpdXR2Q3Zu?=
 =?utf-8?Q?LLfN2zrHiWaH2Ij5CjLggYEBi5XISQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VlBDNW1lbGMwZzVZd25FSlpCdTF6Q0ZQenIweGEzUnRhaVNyNzRaMHlJdjQ5?=
 =?utf-8?B?bHVGOTRSS2NoOHdIaDMyS1RSeVdyendCcUdKZjE0K2lqRlJNeFZyVXZaU1JC?=
 =?utf-8?B?TmhSS3d1UTFHc3AzWm5mV0tHTDFlMXNaWjFwN3Y2SEkzSHhoNjJidWtrRVNJ?=
 =?utf-8?B?dTZROVZQWHNIQzVyTE9qMFp0Tm92aGdramZzN2EwM3d3REFBaUJWYU9FNjg2?=
 =?utf-8?B?aFc4MlhEUXBYZXdFdllFdmxYcVFCdnVxNCtOT2lQQlNoMEptRW41SS8rSWxk?=
 =?utf-8?B?b2ozQkc3NGZ4SWR4UkJnWGxZNG1ocUlmUUY0aXpRc2VQd3o4dHVaMVZ2cUM2?=
 =?utf-8?B?c1N1ZlFnM2JKaEhCdTFTYVM3QzBTN2lvVEVJdWVKcU4zTDJLWGs0am1XVyt6?=
 =?utf-8?B?a2M0TEpqSmRzeEM2cHpEQ3VFNFZMOU1Yc1hJUi96SU5qeGRzbUxxdnR2S3U2?=
 =?utf-8?B?YkQ0SUQ2S2lrV2YwSjZzL01XZDF1TFVlRjlBMGdId05zRmJ2TEl2dXR2TFBh?=
 =?utf-8?B?QmFsOWhjdXlFa3RDczA2c2J1cjJRbGZWRE9VVmtmL0E3SVFRZmxKTS95dmV3?=
 =?utf-8?B?UGdmUkVuem1OcDdFRTNZcWZqZWcyVTdpRlBKWm02dms4cmFhWFZaUjFKT3lS?=
 =?utf-8?B?cTJqSUp5dFUvRFYzb1dzaUZCQWJJK29BQUF2VnZZTmh3UEVQb1VvSWU3Z01o?=
 =?utf-8?B?d2c2c3VMQVdlc3lMUHA4T3hKZkd3OTVmV05RZ1ZVZUpVcEROeU1ONE1LS2Nm?=
 =?utf-8?B?VVVySXJRd1FwajRubmpNa1pRZ1pXenY2MFN0V2FpWDJUbWJEYVZ1SWFyNzFG?=
 =?utf-8?B?bCtkaHR1WHJaRmUrMldicmwrWk1BbERXZ2tVSlIrekJIM3IwaS9FaGo4QXVx?=
 =?utf-8?B?NmdSTm4yTlMrcmlYVGxLUzA5TlhLYy92WFprd1VSRGNnSENoRDlRWTIyWXlW?=
 =?utf-8?B?dUVKbmFIYjFnSHB4SG1xLzBlc2lTQk91ZU81bzdDTXAyYUlEZnpHaDNIV3dB?=
 =?utf-8?B?eDViVnJocExBbHpVYStxUnNBS0hIRmZkMHJwSGo2ZlRSZ0k5bWV0N0xLVEZT?=
 =?utf-8?B?Z1U5NEdmR2xodjNoeFQyRjVkS2FIUmFwQ2xmWUpSRFVnOFZJYndUbVFPUUFa?=
 =?utf-8?B?d3lIbVNPNjFDWDRrQUt1SnMwbjNxaGpEcHgwRzJ5NG9xQnpMSnRvTkxzRThT?=
 =?utf-8?B?YWhaVDd5b2cveHRoVUpEbG1vNWUrUTRkMEJ2N1BjdlZYSkJMWTE0OUxOamlK?=
 =?utf-8?B?WTc3UDlXcGlnUW1kb0hjdmEramNObHBROEhwU1IrWi9YTkxZZFQ0Z0YvS01Y?=
 =?utf-8?B?OGs1akR1UFg1SklFZ0ExY21zUHhDaXdVUjJLNVBhWFN1QlhHY29GQ0p2bTRa?=
 =?utf-8?B?M290RUYrakI4ZHU0L21rOFMxazQrYkhUcVNTU0RJYmcyUzR1UDZoUzJORUE0?=
 =?utf-8?B?ZmhpQ2kxSWpmL2hWbHhzQ0RKNlIzN1c0NDl5UVhtR01rZUgraXFRcHpKcXJI?=
 =?utf-8?B?TWFpZkQxS2dqbjltbVdZOVBubU44UXoxMWViMk1QYUdiNXVacUY2VzV4Y2ZF?=
 =?utf-8?B?WHErR01HeWpabEljc2N6MXcrZmtiT08rUTBqc2c4bmNXVEdBSDRQdFpGdFU1?=
 =?utf-8?B?S1dTajJUb21ZTlRna1QzRzltWS81YmIvRWxXY2J0cERzUmJEd3paOHBjV1ZK?=
 =?utf-8?B?SXF6OEZQem9BdHRuQ2p6Y0g1MXdBOWtuSEM4eDhOblNvckNxRXVaaExJV1Q2?=
 =?utf-8?B?THhvVSs1SzlLeS9CZm02VkNLVEFSb2tDcU1wTkJsV29SZjc0WlZ4Q0FhRXp5?=
 =?utf-8?B?TWppdlNmZEN1QnJUSWtBZjVPQ3ZyVmVrUVNnYmxseUJvcGNSOXFaTngxMnFi?=
 =?utf-8?B?aHZtZCtOK3pJWTNtaktHdXdXL2tWR2poV2RZbXl5K0xQY3RUNGcyd2JaRzJM?=
 =?utf-8?B?K3VQM0JsSlE4a1VMMlZVQ08reGVadWxVN25PekEzYUV4amVVY29sYmdRZGhE?=
 =?utf-8?B?azRNWFVzS3h4VWUwQmdpdDBjVkMySnNiQUNZQlBhTDQ0TzVRSVVvMGpFZDkx?=
 =?utf-8?B?NDIxL1M4QXRnWkZzSUNXQWFFaThtcU9iKzlzNDBLc1RIbWpGcFY2eXNmSDVW?=
 =?utf-8?B?cXFQdEY2Y1Z6dURFeFFpTlRJTUhrTVloWG5Ed2t0QWMrMTU0V0h4RkxyQWg5?=
 =?utf-8?B?YWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <37A8D8567403BB49B8320097AA53B9C1@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a8cc1d53-bcb7-4d0a-fe28-08ddb03bcc17
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2025 20:48:22.9938
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NotClVil0RedcHEUlyGit0/TDN3XPhDm/0qmuNDsooSnnPRUGcG8XiWvcJ2KjbGHib4IrEsxaw35veRBTkkEqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR15MB5737
X-Proofpoint-ORIG-GUID: nI5MLEdm6MjGViwkvp-TsnKzEScccOmj
X-Proofpoint-GUID: nI5MLEdm6MjGViwkvp-TsnKzEScccOmj
X-Authority-Analysis: v=2.4 cv=eMwTjGp1 c=1 sm=1 tr=0 ts=6855c93c cx=c_pps a=uxpPEJxh2mAsh5WBefDKvg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=j3xTJ6tf1T2RjVLUOOYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIwMDE0NCBTYWx0ZWRfXyXDQUxyIOBqk BceyUw+zfIvBkB7yS/5FtoojChcg8Mun57bG3P0wLt2JxVJtbtkxyvf6JoyL5LIr2rvWC15qgKI TU/vwuwntWbXjxyhcaErgonoT/yWhyKaHPCCE4fjPpHGtMMv6KKUauLUT6T2chYQFUGoaHKeI/k
 HxoU5XAienzPf4ki2JOC0SoIEruJEjDnRXpGmYhhsOeMCbgSgkxofKBrjgYO4oiT3NzytxidBlB vrNXmdZH1Q6K+1enKWh99kww0TaZh7fD+cgi3YWngWbcXndiR+6lh8h8rxlS4bI7iIXnuRw6/50 BVuUC4ODz4dEihE/ogWJ9O+8IXmyyxHBUlnMZKneZk3VR9x8ta6uQg2s8p+5buXciWmhPehGW/e
 HuytE103X5DGqlH1KtbByVLo1adHbESzfKXmB9/NXxwYO7+KuTurIlnK4kB1fXUUMFtPsD+t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-20_08,2025-06-20_01,2025-03-28_01

DQoNCj4gT24gSnVuIDIwLCAyMDI1LCBhdCAxMToxOOKAr0FNLCBBbGV4ZWkgU3Rhcm92b2l0b3Yg
PGFsZXhlaS5zdGFyb3ZvaXRvdkBnbWFpbC5jb20+IHdyb3RlOg0KPiANCj4gT24gVGh1LCBKdW4g
MTksIDIwMjUgYXQgMzowMuKAr1BNIFNvbmcgTGl1IDxzb25nQGtlcm5lbC5vcmc+IHdyb3RlOg0K
Pj4gDQo+PiBjZ3JvdXAgQlBGIHByb2dyYW1zIGFuZCBzdHJ1Y3Rfb3BzIEJQRiBwcm9ncmFtcyAo
c3VjaCBhcyBzY2hlZF9leHQpLCBuZWVkDQo+PiBicGZfY2dyb3VwX3JlYWRfeGF0dHIuIE1ha2Ug
YnBmX2Nncm91cF9yZWFkX3hhdHRyIGF2YWlsYWJsZSB0byB0aGVzZSBwcm9nDQo+PiB0eXBlcy4N
Cj4gDQo+IC4uLg0KPiANCj4+ICsgICAgICAgcmV0ID0gcmVnaXN0ZXJfYnRmX2tmdW5jX2lkX3Nl
dChCUEZfUFJPR19UWVBFX0xTTSwgJmJwZl9sc21fZnNfa2Z1bmNfc2V0KTsNCj4+ICsgICAgICAg
cmV0ID0gcmV0ID86IHJlZ2lzdGVyX2J0Zl9rZnVuY19pZF9zZXQoQlBGX1BST0dfVFlQRV9TVFJV
Q1RfT1BTLCAmYnBmX2ZzX2tmdW5jX3NldCk7DQo+PiArICAgICAgIHJldCA9IHJldCA/OiByZWdp
c3Rlcl9idGZfa2Z1bmNfaWRfc2V0KEJQRl9QUk9HX1RZUEVfQ0dST1VQX1NLQiwgJmJwZl9mc19r
ZnVuY19zZXQpOw0KPj4gKyAgICAgICByZXQgPSByZXQgPzogcmVnaXN0ZXJfYnRmX2tmdW5jX2lk
X3NldChCUEZfUFJPR19UWVBFX0NHUk9VUF9TT0NLLCAmYnBmX2ZzX2tmdW5jX3NldCk7DQo+PiAr
ICAgICAgIHJldCA9IHJldCA/OiByZWdpc3Rlcl9idGZfa2Z1bmNfaWRfc2V0KEJQRl9QUk9HX1RZ
UEVfQ0dST1VQX0RFVklDRSwgJmJwZl9mc19rZnVuY19zZXQpOw0KPj4gKyAgICAgICByZXQgPSBy
ZXQgPzogcmVnaXN0ZXJfYnRmX2tmdW5jX2lkX3NldChCUEZfUFJPR19UWVBFX0NHUk9VUF9TT0NL
X0FERFIsICZicGZfZnNfa2Z1bmNfc2V0KTsNCj4+ICsgICAgICAgcmV0ID0gcmV0ID86IHJlZ2lz
dGVyX2J0Zl9rZnVuY19pZF9zZXQoQlBGX1BST0dfVFlQRV9DR1JPVVBfU1lTQ1RMLCAmYnBmX2Zz
X2tmdW5jX3NldCk7DQo+PiArICAgICAgIHJldHVybiByZXQgPzogcmVnaXN0ZXJfYnRmX2tmdW5j
X2lkX3NldChCUEZfUFJPR19UWVBFX0NHUk9VUF9TT0NLT1BULCAmYnBmX2ZzX2tmdW5jX3NldCk7
DQo+IA0KPiBObyBuZWVkIHRvIGFydGlmaWNpYWxseSByZXN0cmljdCBpdCBsaWtlIHRoaXMuDQo+
IGJwZl9jZ3JvdXBfcmVhZF94YXR0cigpIGlzIGdlbmVyaWMgZW5vdWdoIGFuZCB0aGUgdmVyaWZp
ZXIgd2lsbCBlbmZvcmNlDQo+IHRoZSBzYWZldHkgZHVlIHRvIEtGX1JDVS4NCj4gSnVzdCBhZGQg
aXQgdG8gY29tbW9uX2J0Zl9pZHMuDQoNCk1ha2VzIHNlbnNlLiBJIHdpbGwgYWRkIGl0IHRvIGNv
bW1vbl9idGZfaWRzIGluIHYzLiANCg0KVGhhbmtzLA0KU29uZw0KDQo=

