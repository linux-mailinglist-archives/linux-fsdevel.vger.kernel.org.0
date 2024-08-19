Return-Path: <linux-fsdevel+bounces-26231-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D6C95643F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 09:18:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E74741F22B20
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 07:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0266157E61;
	Mon, 19 Aug 2024 07:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="OjNGs40v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EA113BC1E;
	Mon, 19 Aug 2024 07:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724051928; cv=fail; b=Q9YYPmkPsyljjC3Tj7qK4zqe4KXN44oZGrxoMqQtSAfwPNpyAZS9guxbeISifzTIp2Z2fURkvDtoPfLIRtIhCZS/9kDx4axfPSnrp9MQIbxYXgqM53ienf2Ic8S1UJnqmYOIoP1ILHd4ZW+Ixbyewv5DxR6ThhVH5VJR4sBm8ZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724051928; c=relaxed/simple;
	bh=ro85A3s9QWQlxfJV4CcmUR3xMGMh1AjJl7k/r0h4ekU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=d0Hs4F9H8lSHqyN+D1U4/lzYNPTrCIdl+tiouTPIsF+W9upJiuKR73ULrqW3SPd9Epm7k8tWfayrZYJiiCqOwl9YrkexEcPM8iG7fpYPwowgpW8kqdAAOuoJKmUyoks+DD4l4BNYLxjkCJTv6t2CABgjWdPztglmYQJJgmVnzWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=OjNGs40v; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47IMncX9022524;
	Mon, 19 Aug 2024 00:18:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=s2048-2021-q4; bh=ro85A3s9QWQlxfJV4CcmUR3xMGMh1AjJl7k/r0h4ekU
	=; b=OjNGs40vVED1xK3rKTLvqn/Bb18AKkSQ5LdUADpl0y6Mlmyy53QJ0VWTAN2
	v0uD92voDNIB3ayQMAIPLjPWmqLsQN1aVF7ll8cA0xKvWINzEPCeGL9yNrB45TAn
	XaK/yfqPu5ne9QNZYoa46WndvqUkgy9wsmccurBLdkkS6tajUHoZCa1iKBOJmTFm
	SGYeMiIFTEzkKFrc6DjDpNZYPZ0HIVRRzvLT7P2ma/MAT4M6c3vPYbu7Ex6UUuGe
	ckyUIuuEdLf33C8JmEDjAbUhMZlAN8z0xSNPThDWequ88gkAXSfkkjY3VGZbTLdO
	vWVEwhy8TDGhu8sIcVyE9G+2G2A==
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2048.outbound.protection.outlook.com [104.47.55.48])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 412q6cdrp5-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Aug 2024 00:18:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dyJtu4N6o4cs3sF9Y3WS5F5uId+BBWyaFlfFie5IyRoMJD7pe24gbshMSyavJLXeUI5XSHaBt4gN1bnndQEUfNINgigeNERp5ehekRtQg3PRPIBHAd7fJkpAtqJtkz2QyYqUEW7eYa7cDTJSQgIoSlXkRJ/ok7CJv+Mx0r+BNqAV+0QOyFXEmHCr2cCowxwsOGfC072/9FCs7xnlbPcnhat79Hh41Q9HHIYpJcEjptEDNovq/EgEtBG/urVTtuDxTEp/qxl1buX14QQYwcuTZzfNNgv2B0gTO8N/L7FeR9V432cLo5RRctYi560gSoa0XFWe06Ta+UvBgFerawDd5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ro85A3s9QWQlxfJV4CcmUR3xMGMh1AjJl7k/r0h4ekU=;
 b=Q5soIfyrrWOF4h8OG3fiMc/denDIhiZQYrFKYUnLAmz0EMdp04t7jbYUBMtddxNB789ZDi7iXLwuTv2zuBKkaEUGxKP7F3H7lWBDOKWLpT5h5RXg3q9r8kpBMCUCI0/Dj9F+Xh/Pu12dnQwUCBuabUxZmkYAHCO46626uEW9sWAv6on9xFMc49429VVmS8+SNlVbSNCkQp31OXLRtmnHHRIid650gJsu9cYwd97CmzOe3/lv12bOWB/es7cScyOvnLTV2HTSlJyT/RFkP/kfGaGTsfz9HA97mdOM1ng0MxLyAsizPMwrffYAWytaKcfXU2aJwQHZCIMPVOXXqYcqAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by LV3PR15MB6620.namprd15.prod.outlook.com (2603:10b6:408:278::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 07:18:41 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610%4]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 07:18:40 +0000
From: Song Liu <songliubraving@meta.com>
To: Christian Brauner <brauner@kernel.org>
CC: Song Liu <songliubraving@meta.com>, Song Liu <song@kernel.org>,
        bpf
	<bpf@vger.kernel.org>,
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
	<linux-security-module@vger.kernel.org>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add tests for
 bpf_get_dentry_xattr
Thread-Topic: [PATCH bpf-next 2/2] selftests/bpf: Add tests for
 bpf_get_dentry_xattr
Thread-Index:
 AQHa3u0J3x+q9TWVEkq4VV2cIBgMWrIIlswAgAAlQQCAACpzAIAAg8YAgARTMQCAIJSqAA==
Date: Mon, 19 Aug 2024 07:18:40 +0000
Message-ID: <8DFC3BD2-84DC-4A0C-A997-AA9F57771D92@fb.com>
References: <20240729-zollfrei-verteidigen-cf359eb36601@brauner>
In-Reply-To: <20240729-zollfrei-verteidigen-cf359eb36601@brauner>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|LV3PR15MB6620:EE_
x-ms-office365-filtering-correlation-id: 0999a51c-f3d9-40e9-a847-08dcc01f26e4
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZTZtVVhscXZMdEZtVVlBRGpQaDg1NUJtc0orSnNFWVlKNmJnSEdkT2krZ013?=
 =?utf-8?B?NnhoZFhBcllFNFhWRHcyUEFzOWlMVm8reTBsM1pLaWk3RVh1Q3E4bnkwRkQx?=
 =?utf-8?B?dmZwWHVQQTl2ay9DVHZxZVdCREJWeTk5NExCR0x5TEdOMFo0WEVWZHlXWFdz?=
 =?utf-8?B?SDBNbmhkeW5nRHBuYnVQYVZNNlY3WGJMaXNhUVlNUmoyNG1kMlp2eDZhRjA5?=
 =?utf-8?B?blhHWHpQQkhLN1c5cVZoSEtoRDM0bURmUVV1WDZBQXlBM0loUzhURkxzaTFK?=
 =?utf-8?B?VklVR3lDd3c3bWdHd3FCUWhuemhxaE5RejdXWFlpazJRUHhmaWpqSGFNa0Q0?=
 =?utf-8?B?blYwSmJrUWJjQndyOE1xL2V2V2xiWjNNWmIvNFRrTERPOXlReVVPQisrV2FI?=
 =?utf-8?B?bG1LWjU3UjJaeUVLN0JoK3l3OHZldFZXc1JkdExYdmo2cXY3NWNlY28yWDQx?=
 =?utf-8?B?eUR1SVl3aEY0TUtNbkxGU1N3SUVqRytrNGxBblBOQTh5bXBLeGJDcll3Sm1C?=
 =?utf-8?B?ODFyVTVCOWs5eXc3MkRrQjFqa3R1NFZLWVJpVHpmL2tYbE9kNnFKbmJLdkRH?=
 =?utf-8?B?OVlaamw3YXZkZUNCdmhlUUhIRzJSNnMyM0Y4bUFrMkNDb2pKbXNLSEJKaEsw?=
 =?utf-8?B?U3BzV05ZcmJQK0pwVmhsdHF1aDRZQ0UvZUp2RjlFL0RjdWZyVTd4dDE3a3A0?=
 =?utf-8?B?SWYza0dXczNTSm1nbklJZ0liOThIM0xDdDdKUnZ6MlBqd1l1YXZobjRLNjh3?=
 =?utf-8?B?Y3ZWMURORVNTSzZpUDFhL2VCbUpnRUNxMUJGeUo3dklUQkR0OVZwb2x0cXNL?=
 =?utf-8?B?Tk9zMmk0aitWcXBwMks2aE83TDBMVHJNbU1MQlJNRGhqdzNOeXlnVDdFUGJ2?=
 =?utf-8?B?OHdNSkdKcUtZZFpVc25Pd1JDeVYwS1hnbHFuOUY4ZE5Ec2h3YWgwRWpDaFVL?=
 =?utf-8?B?ci9jQnN3U0NVNVN5YllWV2NSQXVuUWxwUkk5WUtwNGsyK1g3ODFmS3lZVm10?=
 =?utf-8?B?YVIzbGZuSTJXYTBCL0N5R2srYVE5Y1RBSWtaOEY0RTFwb24vN1ZyOVUweUty?=
 =?utf-8?B?bitqM29oMVRNRW9OZ240VkVwekYrMXQ3dWNVM3k4ckhXT1Q4ZG1PZ3ZRWGsw?=
 =?utf-8?B?bFFVNGwrM1pDdVlJblFzWkZxeTZ0eU5EUFM0bXdXUndCWGZFUjBpMVdCL05O?=
 =?utf-8?B?dG1JNDBNSUtVMUtpb0ZRT29wVEZ2SnVncU12TlZYMFBsV0JkWGV2NmRBVXBT?=
 =?utf-8?B?cHpQZSsyOVBHZGxSUE1ZT1BQQkg3aVdmZjdDTnVYQzYzbUJDZGpiZWlaNnV3?=
 =?utf-8?B?QmlwbU1mZnZlclB6b0hVOFBSSFU3bDZ1bGNmdGV6aVhad0JOVXhiQko5OXE1?=
 =?utf-8?B?dHFQRkxBdkkxdlpITUMzQ0VRSXVmR0trNHBoVTVDVjJEL0t1MlhkTDBVOWNo?=
 =?utf-8?B?ZEJvMS9qWVp5UlhQd2JiN1JheGFlZnpwa1dUWHBkLzFvbmdhbVBUQjRHYWNX?=
 =?utf-8?B?SHU3d3F6NDZpci93N1VXdHhaSVFvNjk5SlZ6TzdVdld4aEg5OGlUVjdaZU5o?=
 =?utf-8?B?SXFyYUt4Wm9DOHVQQVN1WGZobEVmNUxPMU1XVjdMUkRYV0ROYXUyNEJ1VEdF?=
 =?utf-8?B?R0JzampFNnZ3V3JhYU15a294bXlTMUZzZFMvekNMYjNOYXpsNFVJWXcwWlJV?=
 =?utf-8?B?NlZzMHlJT2MwVk1PVUhidUplUzYrYmZUaHBVanhscXNPYUxaZUQzZWIxMVhi?=
 =?utf-8?B?Qy9IRXEwTWNjVGNwS2Uvc3dEZ093ZTUvK0ZNVFc0RFBFMVFOY08vdHQ1QzVl?=
 =?utf-8?B?bG5hUC9iYXpuR0psTS8vd1E0OGFwK1BBNnB0N2k5T05TRzA1bEJ6Sjd4eExP?=
 =?utf-8?B?cVB6clZvZXhYUnEwY1pidWZSVTN2MEVibldrN1JDSGRXMlE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bEpRbkU0RHVGcFdDazg3MG9GRFg2NGJjKy83bjg1V29EdFRJQXdybmFkbDdN?=
 =?utf-8?B?VSt0RGxueTFTalRkZE5zTU4zdFd3VmIyTW5KRFpDQm94SzIra085MDdzdnVv?=
 =?utf-8?B?UER3cTFvdlJIUXhLVXQremVJZUFmR0RrSWh2SE8vMmhuRXI5cnFBYTdxdlBk?=
 =?utf-8?B?NXI3NDdNT0VYZjR5MWg0K3JaUVZjUi9xeEVJMHRIZFZnN3R1TmkwaHlqZVhG?=
 =?utf-8?B?eG5zbXFBV1ZkZ29YVDFBTlFKWnJaUlFDOXgrd2p3Zm5vVkJxWEZKbm5tMmx6?=
 =?utf-8?B?L3pDcFJkMzI0UW8rUkxsaWZxRkNHY2NDTy9ZWVFkQXZ3aEl5cXdzcFZXeDhm?=
 =?utf-8?B?WWZmeUZQQTA5bHVidEtLVkZBMXM0RjB5WTVhMTVZcEhnU0JZT3V1ajI3Z2RR?=
 =?utf-8?B?M1ZQZzFNVWRIWHZBL3Vqa2tOTHNUZjNZN1g0VlBEQWJGcFIxRDd0K3pyVy9X?=
 =?utf-8?B?TVJ4OTJyZmpETFUzZzBqMENKa3VUZysrTmcwNHluTXA1bUZDNmtWYXRhdk5l?=
 =?utf-8?B?RUFuRGN2QUVHejJnd2U5R09kbU56KzdMS2FUNkoyQ09LbDRIbnU4cWx2UGtK?=
 =?utf-8?B?aUZBSXJsTWMyTno5VkN1QUR3eHZzOVZoMnNpWGI0azlBK2dCbzk2OS9FZlZW?=
 =?utf-8?B?TmluRnJ1QVR2MktKZjJGWGJ1M1hOSnpPclNrbG45QmJJd00rcVhCbURBUy91?=
 =?utf-8?B?ODcrNkc2NWJyWE52UDJmb1JjV0E3RlluYjhuQXhKNVNyQlh1TExYeHo0OU9P?=
 =?utf-8?B?czFrdlFFQU5ubGJic3VVNWh3dkFESDcyYzdTS3RRTXV1cXdzVmlBOEJzem1L?=
 =?utf-8?B?NG9LSmVRUnFYVWZ2eERuM1YwNk1TR1Z0Z1d6Z2JqVGVaUVlVZ3J3RkhnZGRt?=
 =?utf-8?B?SDN2S2ZXYkZlR3FsbmZ2N1YrLzV4ejBuM0dxWlJNRG5wcWllVEpRUHFHa3dj?=
 =?utf-8?B?aXJqeFJaWGVoSWtFcERtRm5yT3NmcXJLc2syZFFCdENicHgvN285azFyb0Zy?=
 =?utf-8?B?d3pDcEhGKzgrV0R0dWhhMnRBK0k5WkdjcGZQV28rUDZqaVAwUitRa0VpNmVl?=
 =?utf-8?B?eVJlU2UwdE9qQjdXd1hjUUdZMElTeExjZkhUK1ZGUklycUNuUGdWTmppbkd2?=
 =?utf-8?B?WlBsNE5DN09iSlJSNVIrcmNabktYVU5pSWZpWUpWNG9XZUJhY1RCL2o0WGtl?=
 =?utf-8?B?c0lJWGFXd0tVQU56K2JnSHp1S1JTU2VZcWlwdVE3cHowSG9IaitRNWg1OWRP?=
 =?utf-8?B?dUx0ak5nTDhxM0FMeThVeUlyTTF4Umhoa255WXBubTBUakdXVkRwdm5JSGVr?=
 =?utf-8?B?MWJnUWNHSzRJL2trTXdjK1RYSUpRYXZqdGVlTWx2SkY4Tk1zZ0wzZ1VoaXV4?=
 =?utf-8?B?Vzd3Q3U1U1EvSGJ1MTZiQlh3RE5VUFArbTAxeUhqK3VGSTBzTGtZeEprcnE1?=
 =?utf-8?B?N0xVOUYvSU5WWXpLYUljOVVsbFBUT203ZitzNkFKVDZJZDg1elhJb2QzbXBK?=
 =?utf-8?B?bzNkTmpwUjMyNG1qYXlCVE5IL0FWcXBUcDRPcldHUzlPWUFWNlUvdWFZTDdY?=
 =?utf-8?B?UjUrbjIrV0Z3QjVDY0YzSHg5c3NaWXJxdVZKYjFSZEVhdjFrTDhGQ29EQ3lU?=
 =?utf-8?B?YkFuNnhaQmlSdHZQMzMxd0tGV3hIcnVsOGJoLzhYa3JSRUVlTWhjVGMxSHFS?=
 =?utf-8?B?R0FmUGpPOFFBTjc0TFN5am9uUWZDMU9VcWhBVkVqSk5BTjgybXdUSmhpYVZR?=
 =?utf-8?B?N0ZuUWlveVU5blE5VWduTm1raVJ5Z2o3QlM4Z3BRV3ZENml1aXRiTGlEck1J?=
 =?utf-8?B?TXIzM1MxTmFrN1owM1I0SzVpY1Y2a0FoMnFTU0psK2RmblBYczcrL2lEUkls?=
 =?utf-8?B?bnlSRkZFNDBXQlZJbU0rV2ZZRjlRWXNSR2J4RzVwRDBsQjJDWnUyYlVEbFVq?=
 =?utf-8?B?QTlJZlRzSk9tSXdqZlU3cEJFR2NlUWRTSkdVYWpac1YxZHM3S1k2bGJSc1Fh?=
 =?utf-8?B?bDZaOWlBNk9idXNMN25iVnFFNHo5Qy9LdFBhNnFOcU50NEZHWkgzZjZ1cFVi?=
 =?utf-8?B?NjFFK29xQWhBakYydWVndC9zakUwQTRsVVlYa3dCZnRoNVFlNCtRL3graFJl?=
 =?utf-8?B?d3hzcHJXc1IxcDNvbUdueXd0Mm1nMC9aRjYraE5jQTMvR1Z6c1ZTRC9HVVdy?=
 =?utf-8?B?Zmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4A4B9F13582E244AABD0251A6BEC0160@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0999a51c-f3d9-40e9-a847-08dcc01f26e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2024 07:18:40.8680
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oEWJCotw8zA52prnhqcNPOA13Axnpcu/QE3wX5PtkLZIS7FMU9GuATOdaHP32mP4BxbtpYJy30yp7EXBOomObA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR15MB6620
X-Proofpoint-ORIG-GUID: RW-5Mmsoa0MYyO8W09iPZuyUd6V1YoYu
X-Proofpoint-GUID: RW-5Mmsoa0MYyO8W09iPZuyUd6V1YoYu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-19_04,2024-08-19_01,2024-05-17_01

SGkgQ2hyaXN0aWFuLCANCg0KVGhhbmtzIGFnYWluIGZvciB5b3VyIHN1Z2dlc3Rpb25zIGhlcmUu
IEkgaGF2ZSBnb3QgbW9yZSBxdWVzdGlvbnMgb24NCnRoaXMgd29yay4gDQoNCj4gT24gSnVsIDI5
LCAyMDI0LCBhdCA2OjQ24oCvQU0sIENocmlzdGlhbiBCcmF1bmVyIDxicmF1bmVyQGtlcm5lbC5v
cmc+IHdyb3RlOg0KDQpbLi4uXQ0KDQo+PiBJIGFtIG5vdCBzdXJlIEkgZm9sbG93IHRoZSBzdWdn
ZXN0aW9uIHRvIGltcGxlbWVudCB0aGlzIHdpdGggDQo+PiBzZWN1cml0eV9pbm9kZV9wZXJtaXNz
aW9uKCk/IENvdWxkIHlvdSBwbGVhc2Ugc2hhcmUgbW9yZSBkZXRhaWxzIGFib3V0DQo+PiB0aGlz
IGlkZWE/DQo+IA0KPiBHaXZlbiBhIHBhdGggbGlrZSAvYmluL2djYy02LjkvZ2NjIHdoYXQgdGhh
dCBjb2RlIGN1cnJlbnRseSBkb2VzIGlzOg0KPiANCj4gKiB3YWxrIGRvd24gdG8gL2Jpbi9nY2Mt
Ni45L2djYw0KPiAqIHdhbGsgdXAgZnJvbSAvYmluL2djYy02LjkvZ2NjIGFuZCB0aGVuIGNoZWNr
aW5nIHhhdHRyIGxhYmVscyBmb3I6DQo+ICBnY2MNCj4gIGdjYy02LjkvDQo+ICBiaW4vDQo+ICAv
DQo+IA0KPiBUaGF0J3MgYnJva2VuIGJlY2F1c2Ugc29tZW9uZSBjb3VsZCd2ZSBkb25lDQo+IG12
IC9iaW4vZ2NjLTYuOS9nY2MgL2F0dGFjay8gYW5kIHdoZW4gdGhpcyB3YWxrcyBiYWNrIGFuZCBp
dCBjaGVja3MgeGF0dHJzIG9uDQo+IC9hdHRhY2sgZXZlbiB0aG91Z2ggdGhlIHBhdGggbG9va3Vw
IHdhcyBmb3IgL2Jpbi9nY2MtNi45LiBJT1csIHRoZQ0KPiBzZWN1cml0eV9maWxlX29wZW4oKSBj
aGVja3MgaGF2ZSBub3RoaW5nIHRvIGRvIHdpdGggdGhlIHBlcm1pc3Npb24gY2hlY2tzIHRoYXQN
Cj4gd2VyZSBkb25lIGR1cmluZyBwYXRoIGxvb2t1cC4NCj4gDQo+IFdoeSBpc24ndCB0aGF0IGxv
Z2ljOg0KPiANCj4gKiB3YWxrIGRvd24gdG8gL2Jpbi9nY2MtNi45L2djYyBhbmQgY2hlY2sgZm9y
IGVhY2ggY29tcG9uZW50Og0KPiANCj4gIHNlY3VyaXR5X2lub2RlX3Blcm1pc3Npb24oLykNCj4g
IHNlY3VyaXR5X2lub2RlX3Blcm1pc3Npb24oZ2NjLTYuOS8pDQo+ICBzZWN1cml0eV9pbm9kZV9w
ZXJtaXNzaW9uKGJpbi8pDQo+ICBzZWN1cml0eV9pbm9kZV9wZXJtaXNzaW9uKGdjYykNCj4gIHNl
Y3VyaXR5X2ZpbGVfb3BlbihnY2MpDQoNCkkgYW0gdHJ5aW5nIHRvIGltcGxlbWVudCB0aGlzIGFw
cHJvYWNoLiBUaGUgaWRlYSwgSUlVQywgaXM6DQoNCjEuIEZvciBlYWNoIG9wZW4vb3BlbmF0LCBh
cyB3ZSB3YWxrIHRoZSBwYXRoIGluIGRvX2ZpbHBfb3Blbj0+cGF0aF9vcGVuYXQsIA0KICAgY2hl
Y2sgeGF0dHIgZm9yICIvIiwgImdjYy02LjkvIiwgImJpbi8iIGZvciBhbGwgZ2l2ZW4gZmxhZ3Mu
DQoyLiBTYXZlIHRoZSB2YWx1ZSBvZiB0aGUgZmxhZyBzb21ld2hlcmUgKGZvciBCUEYsIHdlIGNh
biB1c2UgaW5vZGUgbG9jYWwNCiAgIHN0b3JhZ2UpLiBUaGlzIGlzIG5lZWRlZCwgYmVjYXVzZSBv
cGVuYXQoZGZkLCAuLikgd2lsbCBub3Qgc3RhcnQgZnJvbQ0KICAgcm9vdCBhZ2Fpbi4gDQozLiBQ
cm9wYWdhdGUgdGhlc2UgZmxhZyB0byBjaGlsZHJlbi4gQWxsIHRoZSBhYm92ZSBhcmUgZG9uZSBh
dCANCiAgIHNlY3VyaXR5X2lub2RlX3Blcm1pc3Npb24uIA0KNC4gRmluYWxseSwgYXQgc2VjdXJp
dHlfZmlsZV9vcGVuLCBjaGVjayB0aGUgeGF0dHIgd2l0aCB0aGUgZmlsZSwgd2hpY2ggDQogICBp
cyBwcm9iYWJseSBwcm9wYWdhdGVkIGZyb20gc29tZSBwYXJlbnRzLg0KDQpEaWQgSSBnZXQgdGhp
cyByaWdodD8gDQoNCklJVUMsIHRoZXJlIGFyZSBhIGZldyBpc3N1ZXMgd2l0aCB0aGlzIGFwcHJv
YWNoLiANCg0KMS4gc2VjdXJpdHlfaW5vZGVfcGVybWlzc2lvbiB0YWtlcyBpbm9kZSBhcyBwYXJh
bWV0ZXIuIEhvd2V2ZXIsIHdlIG5lZWQgDQogICBkZW50cnkgdG8gZ2V0IHRoZSB4YXR0ci4gU2hh
bGwgd2UgY2hhbmdlIHNlY3VyaXR5X2lub2RlX3Blcm1pc3Npb24NCiAgIHRvIHRha2UgZGVudHJ5
IGluc3RlYWQ/IA0KICAgUFM6IE1heWJlIHdlIHNob3VsZCBjaGFuZ2UgbW9zdC9hbGwgaW5vZGUg
aG9va3MgdG8gdGFrZSBkZW50cnkgaW5zdGVhZD8NCg0KMi4gVGhlcmUgaXMgbm8gZWFzeSB3YXkg
dG8gcHJvcGFnYXRlIGRhdGEgZnJvbSBwYXJlbnQuIEFzc3VtaW5nIHdlIGFscmVhZHkNCiAgIGNo
YW5nZWQgc2VjdXJpdHlfaW5vZGVfcGVybWlzc2lvbiB0byB0YWtlIGRlbnRyeSwgd2Ugc3RpbGwg
bmVlZCBzb21lDQogICBtZWNoYW5pc20gdG8gbG9vayB1cCB4YXR0ciBmcm9tIHRoZSBwYXJlbnQs
IHdoaWNoIGlzIHByb2JhYmx5IHN0aWxsIA0KICAgc29tZXRoaW5nIGxpa2UgYnBmX2RnZXRfcGFy
ZW50KCkuIE9yIG1heWJlIHdlIHNob3VsZCBhZGQgYW5vdGhlciBob29rIA0KICAgd2l0aCBib3Ro
IHBhcmVudCBhbmQgY2hpbGQgZGVudHJ5IGFzIGlucHV0Pw0KDQozLiBHaXZlbiB3ZSBzYXZlIHRo
ZSBmbGFnIGZyb20gcGFyZW50cyBpbiBjaGlsZHJlbidzIGlub2RlIGxvY2FsIHN0b3JhZ2UsIA0K
ICAgd2UgbWF5IGNvbnN1bWUgbm9uLXRyaXZpYWwgZXh0cmEgbWVtb3J5LiBCUEYgaW5vZGUgbG9j
YWwgc3RvcmFnZSB3aWxsIA0KICAgYmUgZnJlZWQgYXMgdGhlIGlub2RlIGdldHMgZnJlZWQsIHNv
IHdlIHdpbGwgbm90IGxlYWsgYW55IG1lbW9yeSBvciANCiAgIG92ZXJmbG93IHNvbWUgaGFzaCBt
YXAuIEhvd2V2ZXIsIHRoaXMgd2lsbCBwcm9iYWJseSBpbmNyZWFzZSB0aGUgDQogICBtZW1vcnkg
Y29uc3VtcHRpb24gb2YgaW5vZGUgYnkgYSBmZXcgcGVyY2VudHMuIEkgdGhpbmsgYSAid2Fsay11
cCIgDQogICBiYXNlZCBhcHByb2FjaCB3aWxsIG5vdCBoYXZlIHRoaXMgcHJvYmxlbSwgYXMgd2Ug
ZG9uJ3QgbmVlZCB0aGUgZXh0cmENCiAgIHN0b3JhZ2UuIE9mIGNvdXJzZSwgdGhpcyBtZWFucyBt
b3JlIHhhdHRyIGxvb2t1cHMgaW4gc29tZSBjYXNlcy4gDQoNCj4gDQo+IEkgdGhpbmsgdGhhdCBk
Z2V0X3BhcmVudCgpIGxvZ2ljIGFsc28gd291bGRuJ3QgbWFrZSBzZW5zZSBmb3IgcmVsYXRpdmUg
cGF0aA0KPiBsb29rdXBzOg0KPiANCj4gZGZkID0gb3BlbigiL2Jpbi9nY2MtNi45IiwgT19SRE9O
TFkgfCBPX0RJUkVDVE9SWSB8IE9fQ0xPRVhFQyk7DQo+IA0KPiBUaGlzIHdhbGtzIGRvd24gdG8g
L2Jpbi9nY2MtNi45IGFuZCB0aGVuIHdhbGtzIGJhY2sgdXAgKHN1YmplY3QgdG8gdGhlDQo+IHNh
bWUgcHJvYmxlbSBtZW50aW9uZWQgZWFybGllcikgYW5kIGNoZWNrIHhhdHRycyBmb3I6DQo+IA0K
PiAgZ2NjLTYuOQ0KPiAgYmluLw0KPiAgLw0KPiANCj4gdGhlbiB0aGF0IGRmZCBpcyBwYXNzZWQg
dG8gb3BlbmF0KCkgdG8gb3BlbiAiZ2NjIjoNCj4gDQo+IGZkID0gb3BlbmF0KGRmZCwgImdjYyIs
IE9fUkRPTkxZKTsNCj4gDQo+IHdoaWNoIGFnYWluIHdhbGtzIHVwIHRvIC9iaW4vZ2NjLTYuOSBh
bmQgY2hlY2tzIHhhdHRycyBmb3I6DQo+ICBnY2MNCj4gIGdjYy02LjkNCj4gIGJpbi8NCj4gIC8N
Cj4gDQo+IFdoaWNoIG1lYW5zIHRoaXMgY29kZSBlbmRzIHVwIGNoYXJnaW5nIHJlbGF0aXZlIGxv
b2t1cHMgdHdpY2UuIEV2ZW4gaWYgb25lDQo+IGlyb25zIHRoYXQgb3V0IGluIHRoZSBwcm9ncmFt
IHRoaXMgZW5jb3VyYWdlcyByZWFsbHkgYmFkIHBhdHRlcm5zLg0KPiBQYXRoIGxvb2t1cCBpcyBp
dGVyYXRpdmUgdG9wIGRvd24uIE9uZSBjYW4ndCBqdXN0IHJhbmRvbWx5IHdhbGsgYmFjayB1cCBh
bmQNCj4gYXNzdW1lIHRoYXQncyBlcXVpdmFsZW50Lg0KDQpJIHVuZGVyc3RhbmQgdGhhdCB3YWxr
LXVwIGlzIG5vdCBlcXVpdmFsZW50IHRvIHdhbGsgZG93bi4gQnV0IGl0IGlzIHByb2JhYmx5DQph
Y2N1cmF0ZSBlbm91Z2ggZm9yIHNvbWUgc2VjdXJpdHkgcG9saWNpZXMuIEZvciBleGFtcGxlLCBM
U00gTGFuZExvY2sgdXNlcw0Kc2ltaWxhciBsb2dpYyBpbiB0aGUgZmlsZV9vcGVuIGhvb2sgKGZp
bGUgc2VjdXJpdHkvbGFuZGxvY2svZnMuYywgZnVuY3Rpb24gDQppc19hY2Nlc3NfdG9fcGF0aHNf
YWxsb3dlZCkuIA0KDQpUbyBzdW1tYXJ5IG15IHRob3VnaHRzIGhlcmUuIEkgdGhpbmsgd2UgbmVl
ZDoNCg0KMS4gQ2hhbmdlIHNlY3VyaXR5X2lub2RlX3Blcm1pc3Npb24gdG8gdGFrZSBkZW50cnkg
aW5zdGVhZCBvZiBpbm9kZS4gDQoyLiBTdGlsbCBhZGQgYnBmX2RnZXRfcGFyZW50LiBXZSB3aWxs
IHVzZSBpdCB3aXRoIHNlY3VyaXR5X2lub2RlX3Blcm1pc3Npb24NCiAgIHNvIHRoYXQgd2UgY2Fu
IHByb3BhZ2F0ZSBmbGFncyBmcm9tIHBhcmVudHMgdG8gY2hpbGRyZW4uIFdlIHdpbGwgbmVlZA0K
ICAgYSBicGZfZHB1dCBhcyB3ZWxsLiANCjMuIFRoZXJlIGFyZSBwcm9zIGFuZCBjb25zIHdpdGgg
ZGlmZmVyZW50IGFwcHJvYWNoZXMgdG8gaW1wbGVtZW50IHRoaXMNCiAgIHBvbGljeSAodGFncyBv
biBkaXJlY3Rvcnkgd29yayBmb3IgYWxsIGZpbGVzIGluIGl0KS4gV2UgcHJvYmFibHkgbmVlZCAN
CiAgIHRoZSBwb2xpY3kgd3JpdGVyIHRvIGRlY2lkZSB3aXRoIG9uZSB0byB1c2UuIEZyb20gQlBG
J3MgUE9WLCBkZ2V0X3BhcmVudA0KICAgaXMgInNhZmUiLCBiZWNhdXNlIGl0IHdvbid0IGNyYXNo
IHRoZSBzeXN0ZW0uIEl0IG1heSBlbmNvdXJhZ2Ugc29tZSBiYWQNCiAgIHBhdHRlcm5zLCBidXQg
aXQgYXBwZWFycyB0byBiZSByZXF1aXJlZCBpbiBzb21lIHVzZSBjYXNlcy4gDQoNCkRvZXMgdGhp
cyBtYWtlIHNlbnNlPw0KDQpUaGFua3MsDQpTb25nDQoNCg0K

