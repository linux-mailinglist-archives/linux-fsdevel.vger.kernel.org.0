Return-Path: <linux-fsdevel+bounces-34653-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFACF9C7340
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 15:15:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F0BD284629
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 14:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC63762EF;
	Wed, 13 Nov 2024 14:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="GkCTAPtM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E834C6C;
	Wed, 13 Nov 2024 14:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731507329; cv=fail; b=XoYS62dWtcu2H4gLI9bo908YwSI7qGup+SJ7XHTqAA8n5Z+QhWDFmMPkkEyzEXi03N0ItEt5T8dA8M67Z7yAKLpj00tRSOy2WkwNMFho252Mu+0tlBBd1x+eOqKF0ttIemuGXQZPCz3sZz7Xmc6AutfXFe130VP8DfywsRzaCz4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731507329; c=relaxed/simple;
	bh=05NcaUaygxqn5+LHptrbRM54O0kFdUJWpWS7bn+UK5Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y84K/tPaXuWCVMTrailWmoVQ1Hllb8py106KmP+l+BrX4KHHeCbgDCXXKZMbKAANIDAfQtKPn2ell6OPJ2vRDjnG2E8oemVZrdJhNxhZIudgd09UM1KjgZJSLj+62UGzFrrP+T4EN8afwvmeNRuDuN/BdRtuouxbG+ywyfBFpus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=GkCTAPtM; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 4AD7pedh012274;
	Wed, 13 Nov 2024 06:15:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=05NcaUaygxqn5+LHptrbRM54O0kFdUJWpWS7bn+UK5Y=; b=
	GkCTAPtM3uYh0TlFyqnzRtlGcDq2D5v1weJoSEB/Jlw+5Q45r/zVohSomMRynQPj
	YmLkGqQEw27sOWc1kYSdXooxdVPyClUq932RBbC+CoUOGeEinnfoZML8eyeqHbta
	gp6b/2HsYUu50OPH36eVbvGSKv9jhKiwWRa8NJQoEqEK0Z1ohfnQ1rBrZKlFJfX3
	a9eRRB1B4iwAev+GRtlmTaOUABb0KWHKyUZC7RWZ/ptlbhlS0A0a7GhVRmyfw4/K
	S87ap3L/JgIMMPmEEGzIav/RlPYnClE/x1r6auETqZkvPUghQtvMKpI736Va4urK
	McGyJN2hI78v36TWH75CDg==
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
	by m0001303.ppops.net (PPS) with ESMTPS id 42vr3j9ur3-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 06:15:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kwrA2OP+VBRX3Dvy55CQfXAnWD+jsmlCY0UOOufZfSF+w8gpQsTeDnmmbYscAfxB8ZC643FvLDWtbt3Kbo8upRtlvRs0gba6YZOymJa80vbrbI6xVH46ht5Evf/KP7OEI6W8ntFU53NUodpGMdw1iKAAqo7BcrHd+6SoBLD5aOVj/hoPsnioqNcGuzjSE5n/RcdCAYh8VteHLpkrVq0nsKUW8XSf6QFlqa4xuPk1xpuMDPyJhnr71mUxRjQo/R2t5EZ2DWMqfyLjRt3nmJreb6YybG73yOmI6QeezUWYzqcH0Jz54/OFiC8MWqDZzAIt1rBgT6zRYMSqumbLo1003A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=05NcaUaygxqn5+LHptrbRM54O0kFdUJWpWS7bn+UK5Y=;
 b=BIIpn291y/t83vIxk8qmU1ZdTnY+N6VvpTD65/D1Rhv4fkXnDNYUmF901dhLFY+mS8jeV5qZf+RXyoolFOEVOuVTk7Ytox0P3OQ2zoKR4I4SWWjo07vFpbGAxN+qscNITOGexGY9v+yucmQJ6WSn4QqHNHEMn3xuKwA9BYIpR0HRE7Qs3KvhQsHgD0lW7dH3QNtaxek+vlGPFJT2eG/1HobQFIiCEmRrjIj+O4Nb2rQlvJ/AsEEJWrnD4bLuFFCqj1kJqisyLAOaGaM3NotyEpyRLhd+fDEYJS58Tz5znA29WC2rCp8h8rIvfkBHsnpNBMquizgtPhxRS8afHxWtyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by LV3PR15MB6585.namprd15.prod.outlook.com (2603:10b6:408:27a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Wed, 13 Nov
 2024 14:15:21 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610%3]) with mapi id 15.20.8158.013; Wed, 13 Nov 2024
 14:15:20 +0000
From: Song Liu <songliubraving@meta.com>
To: Christian Brauner <brauner@kernel.org>
CC: Song Liu <song@kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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
        "jack@suse.cz" <jack@suse.cz>,
        "kpsingh@kernel.org" <kpsingh@kernel.org>,
        "mattbobrowski@google.com" <mattbobrowski@google.com>,
        "amir73il@gmail.com"
	<amir73il@gmail.com>,
        "repnop@google.com" <repnop@google.com>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        Josef Bacik
	<josef@toxicpanda.com>,
        "mic@digikod.net" <mic@digikod.net>,
        "gnoack@google.com" <gnoack@google.com>
Subject: Re: [PATCH bpf-next 2/4] bpf: Make bpf inode storage available to
 tracing program
Thread-Topic: [PATCH bpf-next 2/4] bpf: Make bpf inode storage available to
 tracing program
Thread-Index: AQHbNNya8stOo5GwQE2QhVtvXBjXrrK1AUcAgABB44A=
Date: Wed, 13 Nov 2024 14:15:20 +0000
Message-ID: <2621E9B1-D3F7-47D5-A185-7EA47AF750B3@fb.com>
References: <20241112082600.298035-1-song@kernel.org>
 <20241112082600.298035-3-song@kernel.org>
 <20241113-sensation-morgen-852f49484fd8@brauner>
In-Reply-To: <20241113-sensation-morgen-852f49484fd8@brauner>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.200.121)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|LV3PR15MB6585:EE_
x-ms-office365-filtering-correlation-id: 384adbbb-b05d-4971-61d7-08dd03ed9b7f
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NW5jcVlLQVdraFZyQS9JcEp5d0YwQUxHUEI1Vnh3N3htb2hNbHowNTV6MWlV?=
 =?utf-8?B?ZTJNZThZSWZvYVNIc2VheG9ORzUwMWszU0Ruck9oTjJ2bTRXRjJzc2Y4eHhI?=
 =?utf-8?B?Q1BlRUxZTGtudVNhdW0yMWltN3dTVDZvUk1kbjVjajBqd1BIdFBod2s5cGRK?=
 =?utf-8?B?VytJNVNOZ2x0ZUd2MHlsam9CdHkxSG9RM1ZWMEliUHplMUJVRlcyR2NTVFpB?=
 =?utf-8?B?cTc5cmdzOG9RbEJKL2VRZHg4MzhsbVZqeDZueFhkSDdnRjZlQnZWU2VkT3ZM?=
 =?utf-8?B?Ti95Mkp0OXNDcUhSb2p3enFEQXJOSk1tVlVtQ3pFeFkyZExyUGVNRmFmdVBr?=
 =?utf-8?B?N2V5MUwwbmpkVDZJREtRL1RqWndjM2w3L1lvemFBKzQzNzluRlp3QkptS0t5?=
 =?utf-8?B?Z2x3eHJTajdSaXFOWVltaWZlK2pndFlteTJsdmViUklWODZHelA0UmJKZ0l1?=
 =?utf-8?B?QjFQaXJFalMrQWpzWGFKa1VZRGMrRmpsd1FUQVNQbEplc3psMEt2eDZuMHBi?=
 =?utf-8?B?cURTbjEwbHRTYkNIRUVGbmRYdnhSanNoSS9vVFYzbVF0bFY3TjAyNzFISEtT?=
 =?utf-8?B?RUxoZ3REUjVGUE1SSGVwelhETWtTT0NndFg2Y0dHcEpOUjZNUDBDRmNFY29F?=
 =?utf-8?B?c3ozZGo3ckkvUkRmUHk5SFEwWTZGYkxHTnVab2JzWGxUVHB6MTB6dmlmaVJo?=
 =?utf-8?B?MThURHZnQkhVK2NwNnZHSjVrYUpOWGE0YW9Qc211OE1IRUpuenpLZW44UmRt?=
 =?utf-8?B?ditFLzZhUC95Y1pOZFhmaXJxZlF3K2ZLYWJBWEtidG95b2VudjBpbHI2Rzdu?=
 =?utf-8?B?eWhnV25iY240VVhZdmRnYzZMN08xa3R1TGw1WHlrSEoyc0dldGM1b2x4dUp0?=
 =?utf-8?B?TUFNKzArcjFUUnN0bFYxMklDVjVtb0M3VkwxVWk3V21wbFF3djVDNDB4WUxG?=
 =?utf-8?B?MjJOOUlGdXhXa3JlVUppZHVxcFQwdEJtalgrMzAxckNGTGIyMzhiSm9PSkNR?=
 =?utf-8?B?N2xTS2VPL3czTjNOMlFWcnptYi9MUEJqaVBtZm0yMDFwMTFodnlMS3FUTGcz?=
 =?utf-8?B?VjI4bjIvaHh6SXJEVlkvNHJsbGZSVG5KdkxFT1RHYTJjUldMOHdXTE9YQnpa?=
 =?utf-8?B?Ni9IRFg3SUZsRWZBbjJjSmtBczhjTFVZaVZQWG1paHJPU1ltdUZkMzEwV0lN?=
 =?utf-8?B?cU44c3MwaFZ1eDd6bFZSNTdKTzJWZnJXalQ3dkJkY2xqR0xCY1cwT1VTYjZj?=
 =?utf-8?B?dDhEYXFRWDBadWxVRUtWZERCZkVwOURIcVVuK2lKb3BOVndwMmhFdkdjQUlC?=
 =?utf-8?B?OEl6dStHb05oamt2Tmp6eWhLeHZiV0l2eEZkMWxCZnlFOU1MN1RzZGNkckdL?=
 =?utf-8?B?OE9Vd1NqRDdzcVAwTGhkbTVDQnkvUWtqL1pjQTJxNWFLckV6RDZFd2NjMWpJ?=
 =?utf-8?B?disrWTNQcEs2Qkw0RFIwdkkva3R4MUNIUVgyQXVLSkFkZzQxUGltR1FISnQx?=
 =?utf-8?B?RTdDd1VTZ1UzNmU2YTRpeGVxcnpiMGVNeXJyTVpHOXNUd3o2VCtlVUlqVEQ1?=
 =?utf-8?B?ZnJiTlhkRU8zZ1dra1RzSDd5SFI1aVk2OVdKWTVSUWZlYkI5dVpWTTN4dmxF?=
 =?utf-8?B?c1JXcEVyR25EdndGUytDTTZacGhFTU8ycUlTTUtGZ3VvbG5qRXVaamFZWERR?=
 =?utf-8?B?c1dsL3pVTndRRVRJQ3Q4ZGZLRmtDOTduUG1lcWlpa3htR0pxUTdnZFN1Zy9Y?=
 =?utf-8?B?Rm1NYTBSbzcwSm9SOWNtalRvTEI2Z2ZtTm53dHgzdEM4K0pmbGZZZGpFYWcw?=
 =?utf-8?Q?6xasJkHshsFVhzIj74mBQX2GNfwC5nRprboko=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SjJYMHoyWlAvUjJPTDVPVlo3Q3k1a0pkU0xvZ3NpTGNsTWdBMWsrMVI0Nnda?=
 =?utf-8?B?SjhJd3NCZnpRK1FNWkdKUWwvK2kzVzNiNE5Cb2JHTUk3SjhEekhpZVFLVUtX?=
 =?utf-8?B?Y212OUQwLzZ6RmVJZWVwOGpLQVNIWnl5VW5NaFc1U2xFMnRqaHUwUENPdi8x?=
 =?utf-8?B?K1kxZzl4b2tXS2dhbW13T0srclZjb1p4NXdEc24yb2RJNytnSC9ia0FLRmRJ?=
 =?utf-8?B?Y2wrNksxRVE1SEt2cU82N0dadC9VTlVxZHYxMnNETzd6WkdDUHJRNWhONjh2?=
 =?utf-8?B?dnhGMXdrelFQT25MNkxteW40bGVzdGo5dkNFcEc1anA3cnBJMEtMME1OZ3V1?=
 =?utf-8?B?bGR4aGtnazhTejRSMzI0cnlkZjBMWG8wRGM0a0Y0ajJRTzA1SFJ3WXJ0ODF0?=
 =?utf-8?B?VS9xdllOakYxMm0xb2p6cHd1VVhJcG5TTUltVy9LL3JSVmdYLy9PV2ZPU05j?=
 =?utf-8?B?WUZ1Q0JPbExzMWJpN253UHJ3M3dTdVQ1YklUaXJHcW1sWjZpTDNvUXd4OURi?=
 =?utf-8?B?aW9ZWDcrUlJsWEpYY0h0UElGTTFGOHZndUJOTFdiMDRYdm13azE5K3JXbkhL?=
 =?utf-8?B?Zk1oNVpMM0Zwanl3cUFkV2h6SWRiMXhiVmRROUgrbmcrdEcrSTh1ZmR6YTM5?=
 =?utf-8?B?aFhlVWkvaVRqOWJwU0tKQ3NRSTREVmdhWTVvMXJTcXhRZWh2VGlROTFZWEly?=
 =?utf-8?B?MHBmeXgwQWVEWUJMR1FLWkN4U0Q0M1ZVUTNpQkV2RGsxM2FrdGk1NU91MW1R?=
 =?utf-8?B?aUZOMGMxTzRtRVc4aDNkK2dIbEtHTzFkWmNHeXJsSVAyVmhhRUNMckwzOXVk?=
 =?utf-8?B?b0ZuMTJTcU45QU52WjM0SDFhS0poeEhleDZOTElzV3dHWUk0aW1DVTFtcUtz?=
 =?utf-8?B?U1VENERWbFFENmFkWGYxWElDVWRkN2ZyN1dmNjdmVm9TbDRGS043ZXhRby9D?=
 =?utf-8?B?LzF3S3VoYVZWV244ZFZFcGtqdWgyK25sU05QQkw2UUFiQlo4L0xXcmxNZGR5?=
 =?utf-8?B?bUxNUXVGOUR0bzJSOTd1QzA5Zkc4RVp2bno5S3V1RXVvUHQ2UGlGdlpLdnc1?=
 =?utf-8?B?WElrUkhZYnRWY29ucTV4YUFPZmxaalN2bnNPQnMyY0VkK0E0YldTbHNKL3NR?=
 =?utf-8?B?Ynl4KzNQR1Jtdkk5aU5FZ0d5Mkx6dXNBVUMwdnJQdERHbUxzdWpndWl0RndZ?=
 =?utf-8?B?eDFyNjc2dkUxUkhSWndmK245YU16ZGJGVXVvYmhIQ3duTW5UdXJCNW1HZDlT?=
 =?utf-8?B?THA3ZDFOdklkL0plVUw5ZE1FK1UycFNqSjhQKzIzakw4K251OE83c2VHZFFQ?=
 =?utf-8?B?NTU4MEJEWEZaS0xvT1pyRDVmT1hGTGk3OVRjamI1YkFQcUpOOHlSbGZHZUsy?=
 =?utf-8?B?dGNUMXBYODRpZW92bmFxb2hWVXVZcDFtU3VSK0FtWkRzRmUwejcvRndHWGVM?=
 =?utf-8?B?SFVwbkZNN2JucDIzTisvUm1lQVpOT21kM1BpOURiZ0Ric2E0Qm9UYmc2R0lh?=
 =?utf-8?B?U29zQ21wcmVnbUJHZzh4c1lWc0FCSGVSTDlkQUJlVEtST1EvQ2FUd3JFRFd1?=
 =?utf-8?B?SDJBS1VTaVAxelY1Qm5tbE0rMXQ5clloNGwrdk9YUmRSd3VTK1Q4bzUyYVBn?=
 =?utf-8?B?QnJoQzU2SzU3RkpxMnhXdWhKUWpSTy9vaUxYRXJzQU9QTG5VMFoxamRZTGRD?=
 =?utf-8?B?M3ArRzA2NmxlcGNIeEZreS9GMzk5RXRPZCswTngxOFdtbXk3WUw2TlNlWEl3?=
 =?utf-8?B?NzBZbmJqRks2a2M0TXplU3o5am1sd292Rjd2SEpXS3dYSEpiNTRPSnNhYm1p?=
 =?utf-8?B?U1dzUkpHVzI5OVVUbnp4VWdhZytIT0VFUjB1WTNGSVNlWk53djBqZnMvUThm?=
 =?utf-8?B?MEpEZFlBR2RaQlVwNFJma1lNbXg3Y1V2V3gwRlkxcDVobm9ESklUMkl2ZVhY?=
 =?utf-8?B?aUlkTEZwamlIZ01ZZzJwbmxROXJFZUtKUlV0V3ZBRGJQdGE0c1plM2FsOUpS?=
 =?utf-8?B?Tlk1emRZK3V2N3NIV05GUzZrWUlMVWlubjhWNjNMcHVROEhrZVROdG8rbWc0?=
 =?utf-8?B?d0F4NVMyZjlyZXY2bFVOMjVnS0c0RitscUFPazJlY01KR3Z2bnBERFdUaXh1?=
 =?utf-8?B?dFdWa2plVlZ1eGRhWHNsSDJTaUJ6SFFxSmcwZTIrNm1Ma2I0L1pBM051Slln?=
 =?utf-8?B?MVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <852B97B7F2684347889060EB398A648E@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 384adbbb-b05d-4971-61d7-08dd03ed9b7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2024 14:15:20.6903
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9SqcLiqdcTA+jx+roPtVtvAFzOQ8R8d8UGUMz/BUWG9oohcUQuCD/WyKDV2p6k+Dn8zTFNlK9Y82rQSbrECiJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR15MB6585
X-Proofpoint-GUID: YMsnGe3sHazYECYMV1RFdNo7_-YfNZMY
X-Proofpoint-ORIG-GUID: YMsnGe3sHazYECYMV1RFdNo7_-YfNZMY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

SGkgQ2hyaXN0aWFuLCANCg0KVGhhbmtzIGZvciB5b3VyIHJldmlldy4gDQoNCj4gT24gTm92IDEz
LCAyMDI0LCBhdCAyOjE54oCvQU0sIENocmlzdGlhbiBCcmF1bmVyIDxicmF1bmVyQGtlcm5lbC5v
cmc+IHdyb3RlOg0KWy4uLl0NCg0KPj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvZnMuaCBi
L2luY2x1ZGUvbGludXgvZnMuaA0KPj4gaW5kZXggMzU1OTQ0NjI3OWMxLi40NzkwOTdlNGRkNWIg
MTAwNjQ0DQo+PiAtLS0gYS9pbmNsdWRlL2xpbnV4L2ZzLmgNCj4+ICsrKyBiL2luY2x1ZGUvbGlu
dXgvZnMuaA0KPj4gQEAgLTc5LDYgKzc5LDcgQEAgc3RydWN0IGZzX2NvbnRleHQ7DQo+PiBzdHJ1
Y3QgZnNfcGFyYW1ldGVyX3NwZWM7DQo+PiBzdHJ1Y3QgZmlsZWF0dHI7DQo+PiBzdHJ1Y3QgaW9t
YXBfb3BzOw0KPj4gK3N0cnVjdCBicGZfbG9jYWxfc3RvcmFnZTsNCj4+IA0KPj4gZXh0ZXJuIHZv
aWQgX19pbml0IGlub2RlX2luaXQodm9pZCk7DQo+PiBleHRlcm4gdm9pZCBfX2luaXQgaW5vZGVf
aW5pdF9lYXJseSh2b2lkKTsNCj4+IEBAIC02NDgsNiArNjQ5LDkgQEAgc3RydWN0IGlub2RlIHsN
Cj4+ICNpZmRlZiBDT05GSUdfU0VDVVJJVFkNCj4+IHZvaWQgKmlfc2VjdXJpdHk7DQo+PiAjZW5k
aWYNCj4+ICsjaWZkZWYgQ09ORklHX0JQRl9TWVNDQUxMDQo+PiArIHN0cnVjdCBicGZfbG9jYWxf
c3RvcmFnZSBfX3JjdSAqaV9icGZfc3RvcmFnZTsNCj4+ICsjZW5kaWYNCj4gDQo+IFNvcnJ5LCB3
ZSdyZSBub3QgZ3Jvd2luZyBzdHJ1Y3QgaW5vZGUgZm9yIHRoaXMuIEl0IGp1c3Qga2VlcHMgZ2V0
dGluZw0KPiBiaWdnZXIuIExhc3QgY3ljbGUgd2UgZnJlZWQgdXAgOCBieXRlcyB0byBzaHJpbmsg
aXQgYW5kIHdlJ3JlIG5vdCBnb2luZw0KPiB0byB3YXN0ZSB0aGVtIG9uIHNwZWNpYWwtcHVycG9z
ZSBzdHVmZi4gV2UgYWxyZWFkeSBOQUtlZCBzb21lb25lIGVsc2Uncw0KPiBwZXQgZmllbGQgaGVy
ZS4NCg0KV291bGQgaXQgYmUgYWNjZXB0YWJsZSBpZiB3ZSB1bmlvbiBpX2JwZl9zdG9yYWdlIHdp
dGggaV9zZWN1cml0eT8NCklPVywgaWYgQ09ORklHX1NFQ1VSSVRZIGlzIGVuYWJsZWQsIHdlIHdp
bGwgdXNlIGV4aXN0aW5nIGxvZ2ljLiANCklmIENPTkZJR19TRUNVUklUWSBpcyBub3QgZW5hYmxl
ZCwgd2Ugd2lsbCB1c2UgaV9icGZfc3RvcmFnZS4gDQpHaXZlbiBtYWpvcml0eSBvZiBkZWZhdWx0
IGNvbmZpZ3MgaGF2ZSBDT05GSUdfU0VDVVJJVFk9eSwgdGhpcyANCndpbGwgbm90IGdyb3cgaW5v
ZGUgZm9yIG1vc3QgdXNlcnMuIE9UT0gsIHVzZXJzIHdpdGggDQpDT05GSUdfU0VDVVJJVFk9biAm
JiBDT05GSUdfQlBGX1NZU0NBTEw9eSBjb21iaW5hdGlvbiBjYW4gc3RpbGwgDQp1c2UgaW5vZGUg
bG9jYWwgc3RvcmFnZSBpbiB0aGUgdHJhY2luZyBCUEYgcHJvZ3JhbXMuIA0KDQpEb2VzIHRoaXMg
bWFrZSBzZW5zZT8NCg0KVGhhbmtzLA0KU29uZyANCg0K

