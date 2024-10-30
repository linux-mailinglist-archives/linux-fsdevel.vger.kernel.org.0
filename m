Return-Path: <linux-fsdevel+bounces-33219-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB7C9B59F9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 03:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3346D284723
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 02:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD440194143;
	Wed, 30 Oct 2024 02:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="Onvo2YbS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCB518E37B;
	Wed, 30 Oct 2024 02:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730255715; cv=fail; b=Keq7RcAzP61c/lnHOWkKkql4b8+FhZ4UuUrgCRV1FnHXQ/PpzudgjXHqlaNy4418oc9Ej0bURId00PAbXlHZU5BrSItO+0B5OlEja7YSn+rLkL0/hSHRW/wYxcwG3CRn+37mqk+gZU6sBPtPCkzcc7VtQRi1nFAVTJoOoTKhXYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730255715; c=relaxed/simple;
	bh=WU1E/JghN3ZuovzPIbDhN71FJAqyUIXhFIqDFHLqaeM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lJcG3/uo5xf2+X+kjjxzYDhGGUx1AID0DDoZzpSttN30lmdA4jmIJQq/eFBldsh9yKcwHq5MRzks205BgztgsfNk3P2Xh04r36jlADPPWonusOm5SL1ZdbMEvtnxDhSkgxxt58/UQf4UXTslBM5OoOvVbOZwZnqdFQfnLRcUnMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=Onvo2YbS; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49U1HhPq012278;
	Tue, 29 Oct 2024 19:35:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=WU1E/JghN3ZuovzPIbDhN71FJAqyUIXhFIqDFHLqaeM=; b=
	Onvo2YbSiAVUci5cNEREDxs3Pzi91wL0xo8scDSq7bp73rlvEtA+rEfyjB2HsVPp
	6/2KgtX/i43Ee+bDuokK6SSg8UBK9+CIz9QdrNYexxamO8RDs2VQdjvr3PiOaAH+
	cWyBTS8u51F/ljDlYz2oiaCMpjzI5keI4+Y/+dvB5oCP8BV/bLMLYBbvTLCjESpE
	QEhYmcw794lRmWGFm7r9sCA2DyDNTJiNBYCrrqGpOiPnW1bR4lLsVsOgeE7IIKfH
	v/XO6dy+SnMpm4MVtsDQagvcJFMceTnOKr/wDTq6mq389dLNXTCNu0SuwAcOnRHj
	9+4RCs+stpWizDRyWzYThw==
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2172.outbound.protection.outlook.com [104.47.73.172])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 42k6ewa3nm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Oct 2024 19:35:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E4qPuhAmOyqUUIYwWdbgnVDghL4szGvyPaHL1B5Rkkd2Y4Y3BdBIbcOxsdkTPeO3SbwZ3FJ617m6vo/icDPLsfRSW+D+FnobnXRhiEPgvLl98gCFYLVHkT0nfmB9Zty/cyqBIy3DIZKFcY4qMzChRqmzRqcLoQ1OsP/KJ14tvv7wR5VE1JryC6rwNAstkJxhdYwcHiWkOeQIdDffdZ9eEtQBcBChU82hF1FWjyQmDe8louHkJKUyzGkSqx3AiTBYlpue2imh3sLVfFOX/RmHghaUI0u9MRw/8wfVs6PMWfzmaxWgadoQUQbhJVoe59pT8bdcGI3QyCfFfl3IMEGoqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WU1E/JghN3ZuovzPIbDhN71FJAqyUIXhFIqDFHLqaeM=;
 b=onzpKbPV1GQ9N/rtJ4pGdGzlF+hNrz2FI0p9Xgf6ivKqQWxwxR+YKOsJoJpnO3Fm+y8LG+oxFxpJrB3tYo6EBZizhrL/73WbTvTTeZurIAtVeNylOTsVyrQGsvyz1a3uz+wXHHMGVGsFjZfkyWPd0nU0aIA0A1Qs1X0nWwgfqAMXqCePDFV6x4L6PYSfjhTSaWzrcr29AQ3BJhmIgK7QhYcUhVTgyFFGaZuXe1USkP98bSBR+pU9yHoRP1Pvt9vfYUed8AxskxZrxXigb4q8zA5pMLQxQQhqma7Uz+eCIadJ1Ff5MdbsPnyOGytMgXniSM4CoSqT046R+UWY5xJqRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by MW3PR15MB3866.namprd15.prod.outlook.com (2603:10b6:303:50::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Wed, 30 Oct
 2024 02:35:04 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610%3]) with mapi id 15.20.8093.025; Wed, 30 Oct 2024
 02:35:03 +0000
From: Song Liu <songliubraving@meta.com>
To: Song Liu <songliubraving@meta.com>
CC: Al Viro <viro@zeniv.linux.org.uk>, Song Liu <song@kernel.org>,
        bpf
	<bpf@vger.kernel.org>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML
	<linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@meta.com>,
        Andrii
 Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Alexei
 Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin
 KaFai Lau <martin.lau@linux.dev>,
        Christian Brauner <brauner@kernel.org>, Jan
 Kara <jack@suse.cz>,
        KP Singh <kpsingh@kernel.org>,
        Matt Bobrowski
	<mattbobrowski@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        "repnop@google.com" <repnop@google.com>,
        "jlayton@kernel.org"
	<jlayton@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [RFC bpf-next fanotify 2/5] samples/fanotify: Add a sample
 fanotify fastpath handler
Thread-Topic: [RFC bpf-next fanotify 2/5] samples/fanotify: Add a sample
 fanotify fastpath handler
Thread-Index: AQHbKlgjXcuBZV3LVEOnRP7zXkEQ0rKea/eAgAAgGwCAAAfWAA==
Date: Wed, 30 Oct 2024 02:35:03 +0000
Message-ID: <C89A3382-B602-4EC7-A146-868101CBFF9D@fb.com>
References: <20241029231244.2834368-1-song@kernel.org>
 <20241029231244.2834368-3-song@kernel.org> <20241030001155.GF1350452@ZenIV>
 <0D8D4346-722D-4430-B15D-FA1E40073CFE@fb.com>
In-Reply-To: <0D8D4346-722D-4430-B15D-FA1E40073CFE@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|MW3PR15MB3866:EE_
x-ms-office365-filtering-correlation-id: 6eee12e0-4dec-48bf-b5d3-08dcf88b75bb
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bng5T2psSE5hdEx0VUlBdUtZbXhVTEk0TU0zR25NTWJBK3grS0J0UE5RSktv?=
 =?utf-8?B?azl6NXljVE9pWjFyRUU5ZE40OVBVUy9GbDBNWUc5cFFwQzlweThRckpZS3FL?=
 =?utf-8?B?MDhmb3ZGRFlEUjF2SXd1VVRGSXU2aXpQcStIUGhOaVJJVXkyNGw5eWhBYlNx?=
 =?utf-8?B?bm1ReFZyNkNVVXpTY1VLSS92YTlUVVBZakJzcmlQMElEaExpbllud1RZbWhD?=
 =?utf-8?B?dnEvWFNrQldIRUY1Z1hBOHlwdTc3RVZRN2pKd28wNWxiYlBHNDFhWXV2Znpv?=
 =?utf-8?B?dWRuVExjRERQNlhYTjE1bW9qcC9OdWRZeUdGdmo1T2cyanVDNFM4U2hqczQx?=
 =?utf-8?B?L1ZSd3RNZE50OUJLcEdTUGdFbjVyaG4waktLZ2M0R3laN1lPZmpSNy9SRGsz?=
 =?utf-8?B?aXlyWFlXTXUrdS82clozcVcyT2pUQjFLc29SL09VYmJaQUtiQ3o5VmhYWnlT?=
 =?utf-8?B?czJCa1Azc2dmZkIxV1M5MkdlTE1QQzdzck4yVy83YmNlYmNkRnN5YWVPRGtD?=
 =?utf-8?B?Y2lKWk5LUW1hYUZYbWxkQ1ZwWk44d1FtYm9xdTUybkl6QVJKN01ENTAyMXdz?=
 =?utf-8?B?R0h0cDFPZ3RUaDlzSkhTR2NWSkovRDlzWC9SVWMvSnQvSDdFSjcwYUc5Q3ZO?=
 =?utf-8?B?dFdJb3hibE91dUFDSFBmTEpIM25xZ3Z4bEZPZUZ5T04xSFNreTU5enllK085?=
 =?utf-8?B?SzJENUxSa3FDYzdmSDFPNlJoL1NiNjN3bVNFeExheXNKakdqMG9ENjFuam5K?=
 =?utf-8?B?KzA4ZU1KNGJFdm8rWVcveVJrVCtrblM5bjJ4RzNQdGF4U2RMYS8zOWFLVzd6?=
 =?utf-8?B?VnRSd1U0UkZWNThMWTlUYmtFQ0tVb1gyR2NlRC9lYWlhZ2dmVUJISXdJUGhi?=
 =?utf-8?B?ZDJobE5LTFZ3Umh5dFNXL3JWUnAzRy9aVUt0MFg5QVNHKzEyU1A1V09ldW1k?=
 =?utf-8?B?TUZxYWY3Rmx6Z3VhWlVHOG1WbnBKejM2MWpvaEtpNzBaWkNkMzlCbGp2RUh0?=
 =?utf-8?B?QVdFNnFyV3oyQjFrZkllUnpTY3pmK1BGWjYvRzJMVHIySWJ0NUNDRktUWVVa?=
 =?utf-8?B?UjBUTzFVRVluWm1uWmIxWGY5STBIUG95TWlIQ1pzWW04QlYxR2phMVVqZTdC?=
 =?utf-8?B?TWZleTNoYXlNbGEwc3JwKzRJVmo1Wnd5eWZLaysyWEsvcXgrOHlkWktTY084?=
 =?utf-8?B?SEh5RGFNdGZzbVRXa3JrM0FJWUtiYzU5MWJQVU9pWkNoOUErRFlXdW9mSkZW?=
 =?utf-8?B?MGprMktXajhZdHVDZ1dEdnRyNUN3T0NoTVRPeEZTOGhyUENLL0x1VkhTdUNO?=
 =?utf-8?B?Y3I0S2NFejhkZnAyN2RSUjgxY0QzaWJwQ1dPNXBKUVo3cnhCSHZFTXExTCtx?=
 =?utf-8?B?TG1oU1d6M2prRjBUZGxmWmpMMHQrN21ocU5mclpJTDRDSVRXcmUyN0ZyVllK?=
 =?utf-8?B?d2lNUlA0NEp6RlhCajViWDJEVlpJNkNBQXVVeStCeGVCU29qYWVUMkJHclhR?=
 =?utf-8?B?TlFLdTB6VExVdjFYb1NtUTB0TlVleEpDYWVzNnRqTVI2eXhmZGM0aEtld3Fp?=
 =?utf-8?B?bVJydG1RWmE5aEFaNDNVQitkRHRVTk1yQVgyZEZQNG0vcGNoRUR6dDZRR2E5?=
 =?utf-8?B?WGRpUEFKMzVOUjNyUzV6QkpaMXd2M3VIWHdQUGFvUmxIQUxRbGttNjl3Mm5T?=
 =?utf-8?B?amVHS01oc25ZN1Z0MkhHV0NsNjZoeUJiVGxuTXhFa0FWRDRNSDJSY3ZqOElw?=
 =?utf-8?B?bXhtbERaVE4zYWNTQUdyZlU2c2tReUJvRlRXNTBFQjV4TG9JZmt1ejB4NUk3?=
 =?utf-8?Q?r2oPpN89LtN923FE9F0EVXtJwycgDK7dTHV/g=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YXI2dExObkliN2plQ3BwcVdEc2xTZGc5MUI5QmVkN3ZLbytjOGRzdllWSlUv?=
 =?utf-8?B?anNqVFhGdzN5VzVFMHpLQm5aN2FIblpxdlBmTEs1THplVjR6ZEFnL2E5eWpF?=
 =?utf-8?B?UXN6UncxZHBvMzFvS0FLb29DeXhjL3ZEcG8vdGRod0ptM0dubzYzWTRlVjB6?=
 =?utf-8?B?REVCTDJmMHdJN2RGQU9HU0pqY3UxZ0N2OThKQjBOMm1FbjdWWEV4RGJTaWw5?=
 =?utf-8?B?cGcxajRwQ0FZZ2FZelNjTzNrMlQvVkdXcjEzUGNyR2dlcWNDc0xIeFJ3a2Qz?=
 =?utf-8?B?Um5CWXFlM0MwdHJzZGFRem5XcXZlc0FOb0dkcTVSK1pQVXVzM3lTRkJvU0ZZ?=
 =?utf-8?B?WmdaSWg2VitjTjZmQlRZQkd0UkV2VXhzN29pMG9UbDl3ZFR2RTlOOTIydUp6?=
 =?utf-8?B?YXl3Z1FLejRGZE5YSUwwU0gvSUxuNldKcVZaL3VwejMxd3J2VUppVmtOSzFp?=
 =?utf-8?B?eWNUT2dqcHp1SytzcUlBbCtzYlBVMFVHdlN0d24xR0pPWFRvMHkzMVRlbDAx?=
 =?utf-8?B?WC80b2JwREZtYzhaeW9neDlVczF2b3phaklGMm41OUJYMFhON3cvT2Q1RWl2?=
 =?utf-8?B?Skdhd0FYWVJPZWdmcnJ2OUkxOWxGcjFmUmU3aFhvY2U2bktVNzRRbzhUL2RS?=
 =?utf-8?B?NlFGemd1aWpTRnRyTjZSeFBleVhtYW5aZnZQOEJ0SDVHRFl0UW84UEtWa21Q?=
 =?utf-8?B?Yytpc1E5UlY0UkIzM1c4QTZsVFJ2MjFqQm8wSVZkdGZQT3FOdzNZUTBPVmE2?=
 =?utf-8?B?NFlITER5NDZkaUFDdW85b2x6VVBOWU50bnlGM3Bna0ZtY0RwNy93TFFVV3Y3?=
 =?utf-8?B?QWNvaTg1Y3FqTUhaSkl2MmxPY0RuSkc4WW8rSDBwZjlvdFp4NmJ5emEzZDFz?=
 =?utf-8?B?cjc3eGpwc3RKM0V4dStla0VCRmdsbDFNeC9UWUcxUTRrbmRFcjRNUnVVZmRo?=
 =?utf-8?B?RGFSa1ZYaFRJc3lZY1pMcmNwV3NTdkdOQmdKVTRsdTVlRkh3TWVhTE9IZ0hh?=
 =?utf-8?B?b2NXVmx0YkpaRE00WjVJVmlYcXJ1K0xJNEpHWHdKMENsbWJDZ2NyTlEyOFVT?=
 =?utf-8?B?dkxHdUFLOHhLUUpaanRxYmFBVWRhd0wzS1c5TXQ5VHJtWHNFZ3d3M3dyd1Vo?=
 =?utf-8?B?ZkNoNVlJclBGK3huU2RkbVJWeGt6ZTZMckhwRUU0NDJ4MndrOVUwRWZrTkdR?=
 =?utf-8?B?aXkvT1pzNE1wUjhZb0NaalFXY2FiZTEyTEZEQmNhZlNEZGplNUdzSUR5UGdQ?=
 =?utf-8?B?VlUxRU1uUnBEeGxINVcvL2svS3ZpWlNDYzRKUzFtMzNRMFNkQStUWW4rZVdP?=
 =?utf-8?B?VFppNE9mYnAvcHBmQ1cyMWduYVpDd1BmOU1McnZDZzRPMHlqZ0ZQZDdmR25z?=
 =?utf-8?B?aGczS003REFOa0VKNGNDR1BneUJEa3R3YXBXTU8xUUFnZ0hvbytEaU54ZnZW?=
 =?utf-8?B?YllObnduK2JlSlQxMHJsd0F0MUlLTTNKNEpwNTNRNXdMNitDZ3RYSW9QWHJ4?=
 =?utf-8?B?YnVGZmJBV2syVmlsQmx2OEIyRUh4V3p5a24wQitlMDJBTWMwVi8yUFNSN1Fj?=
 =?utf-8?B?d1Z0YjhTQlhBbCs2SXVwclMvaUlmVEEyeEVSWWNJWUNKVGplSTYxeFFRQndu?=
 =?utf-8?B?aW8xY3VvZExnUnFzMTMwL0pSWjFqa0pEUmdKemxzRUpDOWczeGl3Q1h2czJK?=
 =?utf-8?B?TXl0VTJhUDFzM0FzREZUdmliS2d6RGdaR0l5UFZFMEhXQnh3YXBtYVk1QlAz?=
 =?utf-8?B?WDlwY3JlRVZ5UXBGWUZmaWllN2hHNFRRc3QxckRqU0cvR0JJd2pMdmVxQjBq?=
 =?utf-8?B?YkN4MFRnT2YrQk9MRXdLMm9rZm0xVGdwNW1tSzJCRW5rNzRWSDdtbUxiRHls?=
 =?utf-8?B?aldzc3ladUJBQVJ6QmoxZzdIZGNJTHE3WktheHVqOCtnTzBPWkJYRmIraWha?=
 =?utf-8?B?cTJmZjlieWhMSlFldFNKQ2x6QkNZSzEyYWtNWDN6RWdpOS9qQ2RvbkFiR05Y?=
 =?utf-8?B?NlZqTm9iblFITjBvdjlFWXJRbjZMSmRkWk9KQ2tOT05JUVUyQnVGbC9RQmNj?=
 =?utf-8?B?RFliemNVZDdVUlFVTlVxa1pQS1J0SktoQWN0ZmFzRXlKMElpdUZuajdXbG9r?=
 =?utf-8?B?VmcwdGQ4V3VoQWoybHNIM25wSnB0d2MwVEVSTExDRDNRYkh6T3VuTEwrMVVT?=
 =?utf-8?B?MHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B430630F1F5D0C49A4A64AF4755A7190@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eee12e0-4dec-48bf-b5d3-08dcf88b75bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2024 02:35:03.8693
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bMZyzLq0HSycoky7/TqF0X2tQgwNmbXIQgA61irgXwbM+UfNlWoAVIgYqfxi0cSM0x9RzgrokAIZ/rc9y81TUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR15MB3866
X-Proofpoint-GUID: QVVIGkOKXVJbNRiz9WIPQ_tRdBW7yz5K
X-Proofpoint-ORIG-GUID: QVVIGkOKXVJbNRiz9WIPQ_tRdBW7yz5K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

DQoNCj4gT24gT2N0IDI5LCAyMDI0LCBhdCA3OjA34oCvUE0sIFNvbmcgTGl1IDxzb25nbGl1YnJh
dmluZ0BtZXRhLmNvbT4gd3JvdGU6DQo+IA0KPiANCj4gDQo+PiBPbiBPY3QgMjksIDIwMjQsIGF0
IDU6MTHigK9QTSwgQWwgVmlybyA8dmlyb0B6ZW5pdi5saW51eC5vcmcudWs+IHdyb3RlOg0KPj4g
DQo+PiBPbiBUdWUsIE9jdCAyOSwgMjAyNCBhdCAwNDoxMjo0MVBNIC0wNzAwLCBTb25nIExpdSB3
cm90ZToNCj4+PiArIGlmIChzdHJzdHIoZmlsZV9uYW1lLT5uYW1lLCBpdGVtLT5wcmVmaXgpID09
IChjaGFyICopZmlsZV9uYW1lLT5uYW1lKQ0KPj4gDQo+PiBIdWg/ICAiRmluZCB0aGUgZmlyc3Qg
c3Vic3RyaW5nIChpZiBhbnkpIGVxdWFsIHRvIGl0ZW0tPnByZWZpeCBhbmQNCj4+IHRoZW4gY2hl
Y2sgaWYgdGhhdCBoYXBwZW5zIHRvIGJlIGluIHRoZSB2ZXJ5IGJlZ2lubmluZyI/Pz8NCj4gDQo+
IFJlcGxhY2VkIGl0IHdpdGggc3RyY21wIGxvY2FsbHksIGFzc3VtaW5nIHN0cm5jbXAgaXMgbm90
IG5lY2Vzc2FyeS4NCg0KT29wcywgd2UgZG8gbmVlZCBzdHJuY21wIGFuZCBtb3JlIGNvZmZlZS4u
DQoNCg0K

