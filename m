Return-Path: <linux-fsdevel+bounces-27867-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA689648C0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 16:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26E65281AEA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 14:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397F91B0125;
	Thu, 29 Aug 2024 14:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="IWPAjXcC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip191b.ess.barracuda.com (outbound-ip191b.ess.barracuda.com [209.222.82.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB15D1AB500
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2024 14:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724942444; cv=fail; b=bvONHhAJUUkk88QnqXUf00Uta8V0W0eezcuFAm3Paq/nHhhXPDS+o5UAInbIjxbxUU+YijuRmJU9fhs4YD0opWFzBBTFshv2K4Z8pQeIJkm4ti5tIF9375J0m8ijhuEYljRUce4HMK1gbH8YI8VlZAiNCast4qCDcoCOIpe2lAw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724942444; c=relaxed/simple;
	bh=XzSkW7og1fXIQtXkOn4sdA71D1vUBtw5hOkOCpOoNWQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oDwggqvyWOZVh2Bo8Lq/3QIp9Ez5QbsJlhy2GKt9HCCcRGuFLK9+qYtolu7dJHidz26eZc9MZsOCa0l0JxPgyi4jHrS3kza/jwy6H42ALB2D/v2wtO+ZazPSAZaiQwl2TO7PutviFvSBpUaZ+OuB5GfIYSzDm1Pmw68jNywwdAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=IWPAjXcC; arc=fail smtp.client-ip=209.222.82.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177]) by mx-outbound21-220.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 29 Aug 2024 14:40:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SelVyiwTSD0oSZjWRLOIx6ve6TNPxecHeogEFyZH/QCP/fg1Qi0+cmKo1BZxQSHnjEmMrd5bohX6qrwUKh/O/yMkgR9fetU9xEq3/faAYfP2g/gpxmQoDkjw1Z3BfSaic5yBC7NCs9ewNyjDmh2Ipsq+zIyd8JdMEyrb2+ix4+q61I4RyvnrJyAWwNusf9ep/HnlW4D7+VO4reauE7WHDrbwT9B22c1dZL1ypB3sPM7E/dO2E1YJ2XeVL7HR5cOTGox+EGIqyyfG/5AnUzQ0i1gmUgpWIbZa4Z5QJRmAxpDU+B8Kak6PuyCBaiMVoJeoswlDdF5q5u7tSyqNHk9x1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XzSkW7og1fXIQtXkOn4sdA71D1vUBtw5hOkOCpOoNWQ=;
 b=GmKUVKe9UfnyRhDc5DHSwJ8qmt7ghijAyHRyL17JGgbLc5uyfjKDlknkjn6wpio3kfQwerkYY4RCwKFdg/+YWLFDP7Wkb95XxxLdXMrxuS8VPU8IdvcJf2CnJctJjCc/qqMxCU7+cUS6uJMw5e3RyMnG0cwgUPzEBtYVlzz/GkicWoZDzpKbZJtgR5buF2SfezBZgM1eCj3QdZFg+6WJgyNGOKpT8SRw/E6hgGLMgnlroLyNrEpOlqSZKb8vi9q0xC5BnGH/Am+rM15eVFX+oyie0QxMFBYAHv5r8pz5YWwvmMtmyPcNmPnamCjX317bf2uLCNbZd/ye2CCTpqsCVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XzSkW7og1fXIQtXkOn4sdA71D1vUBtw5hOkOCpOoNWQ=;
 b=IWPAjXcCX1I5Dz+KiETKCE1FFpmJF5x2Pbd1NGO+eZWJESTLhCulJd6XcwJjCUhOjKutxPrOdvxdogxaZaO4V40QhvuoKhzbX0zUrfoM+iI7dftgAWT1Ket6CgwdpuXgBdfEO6vN1QWDce+gFiz9kitbAHMVtplQ5bEKFevyOUk=
Received: from CH2PR19MB3864.namprd19.prod.outlook.com (2603:10b6:610:93::21)
 by BY3PR19MB4916.namprd19.prod.outlook.com (2603:10b6:a03:36d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Thu, 29 Aug
 2024 13:06:53 +0000
Received: from CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03]) by CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03%2]) with mapi id 15.20.7918.019; Thu, 29 Aug 2024
 13:06:53 +0000
From: Bernd Schubert <bschubert@ddn.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert
	<bernd.schubert@fastmail.fm>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>, "joannelkoong@gmail.com"
	<joannelkoong@gmail.com>
Subject: Re: [PATCH v3] fuse: Allow page aligned writes
Thread-Topic: [PATCH v3] fuse: Allow page aligned writes
Thread-Index: AQHa7NNPtyDKGsbz7EGBL1Z84DeVcLIj0kiAgBp3EACAAAUBgIAAAKEA
Date: Thu, 29 Aug 2024 13:06:53 +0000
Message-ID: <06c60268-9f35-432d-9fec-0a73fe96ddbb@ddn.com>
References: <20240812161839.1961311-1-bschubert@ddn.com>
 <a71d9bc4-fa6f-4cfd-bd96-e1001c3061fe@fastmail.fm>
 <CAJfpegt1yY+mHWan6h_B20-i-pbmNSLEu7Fg_MsMo-cB_hFe_w@mail.gmail.com>
 <b3b64839-edab-4253-9300-7a12151815a5@ddn.com>
In-Reply-To: <b3b64839-edab-4253-9300-7a12151815a5@ddn.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR19MB3864:EE_|BY3PR19MB4916:EE_
x-ms-office365-filtering-correlation-id: eca245d1-ee6e-44b7-85cb-08dcc82b73e2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?L3FoYWUxNTU5elE3dzl6U3BBcnoyWVlrZEdaZGJMdi9PSmtJMTlmcmV1SkFq?=
 =?utf-8?B?Ulh2cVBaWUVCMmEwYmthOEhaejRsRE0zZ1AzQysxMitQOWVKd2dkT2dKMGlY?=
 =?utf-8?B?M2NCQnltNlptZ3VYSDBGQzFscnVOVVREWnJRS1NvT2NuNGlpd1ltUjlXYmcx?=
 =?utf-8?B?NTg5clpJNEJpQWp0MWUzd3g5TGxFSGF3SUZ0M1pKVXBaY3U1dGJhbDZSR3Rr?=
 =?utf-8?B?Z0VOazJDb1ZBWENDMjVLaUx5TXFZUUViTnhjNjIxWTZnVzdPUGNDUHBadXJ2?=
 =?utf-8?B?cWtWQk5qM2dhTjVWWDJHZTJ6OG42ZzRHcnAyaXZveHByMEcxMldXQVF6UTFu?=
 =?utf-8?B?YWJzY0VVZTBVM0VBR2VkRXFlS0lZbjB1Q0hHczkwR3lXN25WVklHM09lTXd1?=
 =?utf-8?B?VC9WWmZBRlJmYjhIeDFCNzBPZjhJbWxsbHU2aGw2OE9TRVlvUXgrU2VpQnhp?=
 =?utf-8?B?ZU1wTVg0NkNiaGxMNlpYSklWUEcvQ0JYQ1JvU0RzWk42YWd4ZC9MMmJKOWpV?=
 =?utf-8?B?MWFwTlgxY212ZVdMaGlvYTFRejA4NWpuOW8yS0V0a0UxVjUrYzlnTUdMNXU2?=
 =?utf-8?B?NXVWLzlUWG1vcnVscTU5bEVSWW93NE9UdFMxeXdWYW92THdrUG5kbkZFVzZ1?=
 =?utf-8?B?UG9NdmZmcUJOTW5oWGoxMFZ2anpES0FUTEVEbTJ0cnRCWHY4WDJMMFhyMEJS?=
 =?utf-8?B?c0NkNXREWTg1Q0llbFJhQVZFQXk4RjJMOVB5cElrU1dYYjY0eFVpYXVZejRQ?=
 =?utf-8?B?eVF0SjZWdWs4T3hSQzFGVUtYZmlVZURzTlBqby9sWXJvL0IreGs5Nnp6NHhY?=
 =?utf-8?B?d1lwa0pkcjhLZEZwTlpRQURhVkVub2pka2I5R3Fzd3h2MUx5NWppa0pmeXZ0?=
 =?utf-8?B?N2h1UElKWHpWNlViYm05L1lIN0Z4akI2UngzMmpsc2E5RXNDNzlaYkpIeFRE?=
 =?utf-8?B?L0pyVEJocHlQWStEOHY0Ty9yS052dGpweVVJaTh4d3RvWVFiay9NY2VLUWxO?=
 =?utf-8?B?ZTNLbDJKMVEwS2ZhdVJObjl1eEIzb3Q5Y09JOFMyalBBcCt5TTRLMkFFbzZN?=
 =?utf-8?B?aWE5YzNWSlhsZjNjNXQwZjJIaVVyVkJEZkFqM2VhbkFJZkpNRWJkd2xJTXU0?=
 =?utf-8?B?YnhDaDBDMnduL0VVcTNFUWx3R2RpRVp0cndWYjBQUHp1N1BCVzE4YThxUlFa?=
 =?utf-8?B?Mk9mWGxld1dtK2NuQkVCZk9OVkR5aHljclU2VmVNQXB4L1hGSjRTNXJ6M3JV?=
 =?utf-8?B?ZXM0eWo4K3c2Sm9CNmlEN3VIVVZDeWo2dERMeVJxd1lRd21xOXJqRjFFOTdW?=
 =?utf-8?B?ditzdEdaeWFHdGdxTm5OWVhiZytDSW1hZEV2eFpIQllFRXdXeG9EVXExb3RO?=
 =?utf-8?B?cWlGLzM4djZYemtDUytFeG9zTE5UY0lUQjNibGtTNnREaU9KU3c1S3JVWk1j?=
 =?utf-8?B?dW5JNzZvWllhT3paaURNQnBwcUcxbTU5MHBQNlZZalJveWl5OFFHbStwT0JC?=
 =?utf-8?B?V3FpVDVYZk5GeTdVV3ZhaTlwR1BNcUtLazVPM0FWSWx2dHFGRXByOGpHdVh3?=
 =?utf-8?B?YUZDa2ltTFB1U2V3SHFuTVdTdlZlWWR2TElvb0x2M3FLNTRkejdEU3lqREZu?=
 =?utf-8?B?dXhPbWVZUjgzaUNFR1ZpeG9ZQk9Qd3dZeW55NnByeUhiZHh5eGw2SVNWbGt5?=
 =?utf-8?B?YUNEZmlnbHM3Yjl3eUgyQmx5QnNYemtDdEc4MlQ3RHBrUUcxT2Ryb3YyL3BY?=
 =?utf-8?B?K3FOMGJ6bDNZS1dCZGxaTnRJQ3hPY3NncnVjS253WlZmMnpaOTNZRHFLdlZ3?=
 =?utf-8?B?WHQ1cExmRU5TbHR0V1FBNHN5OWRucXVVdnlGK1NWUUFCME90NU5oTHdoTzF1?=
 =?utf-8?B?QkdCd3p0YVM2OFd6d2ZjTWZrT0lGbG16dFBaNXdPSUY0c2c9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR19MB3864.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?L1JzYksyUTl1V0JSSHU3cUt0SjV1Y3p4TkM4cUNDL2t6bnV2c1VHTTRDb2t0?=
 =?utf-8?B?T3NJQ3o5YmxoRVhYNTRjQkcrNGN2VWh0UDlGdW1sYjgxYlNVc0tEZmlEYzFa?=
 =?utf-8?B?T215clptN1dqakt2TWszbXUyVGNsK1lpRXhLZXh3ek13dXgwRUNZZXdoZTh5?=
 =?utf-8?B?MFlGS2Y1ZDErVm1vN2FQNkptN3A5UW1kRGZBa2F3MjgrQkZlTzdFSmJlZUx0?=
 =?utf-8?B?c2gxelNPNHNzYlNxbWwybHlNemZGdFU5MzF4ZzlJR2hmL3puU1cwR3AzVDdo?=
 =?utf-8?B?QlFNdHE1L3I3cUttaTVWOVZ5a3lrWkFzRnZBcUNrSWNaNzNwYUs2Vm10YkVh?=
 =?utf-8?B?bE5EZmd6dEtaakxKeGgydDVTYnFITEZWYW1tWkRvZUd3bXZGVldvaW9acGV6?=
 =?utf-8?B?S1ZtT08zSXVUL256dGVRWmQrdnlBV29IVUs1bWhYUHNIVWRoSmZmT3JqWU5r?=
 =?utf-8?B?cjFON2thd0pYSUVrZldsSG5rNjc1UGNqR2s5Z0pIQW9hckhBaFZPMThTM0U2?=
 =?utf-8?B?MEtiZHFxT0FINU9CbVUvSkxIWXByaGNkd1AyeHhzbGpobmg0ckFuV0I3Z29m?=
 =?utf-8?B?T09nckxkQ1J3SFY0NG82anIySG8yZlgzNzlqc25HdzdNdkRmNTZvUEFZbDZR?=
 =?utf-8?B?dXhEMFo0V01XQ2hHQjJ2U2lZSkF2c1lvR3ZGbVpMczVWaEZCRVZPYXZtUlBH?=
 =?utf-8?B?Q2NnN2lRSWR2ZXVwcjJvR2V1NFAzTi9yZzdaend4WmJsWFVJb0oyVFNQZFVD?=
 =?utf-8?B?Mnpkc2JmMW9meXBQTVdSaFhUMlZOcmJERmdNeTVSTkRLZFRFMUtyYnFNd01F?=
 =?utf-8?B?WDRndG9Kdzl5bThMb0xTdndadGpRWVhCUVVPVm1DWmV5VWt2MitsRkdTeXAz?=
 =?utf-8?B?YVBWUFBBODI4dWUwT3JTSnMvOVkyaWlGKzVFbERaSmpaaDlYalBLRDNOS1Vh?=
 =?utf-8?B?ZHo2ejJmVzFNVlM3L1dSSldscWdWcG52ZHVkUmVOU1FiQ3RSbm9TZmNrcGhn?=
 =?utf-8?B?U1B5YVFtSTF6TmFldWUrYXZKTFEwckVJYmxybEowZmx1MzN1cEdsTEFaNXM0?=
 =?utf-8?B?cmpkV0Q5bE1FYUxxV09GOVBJZ1J4eDAxcEdSeHdRSFhkYW13ZW1MU2JVeXhD?=
 =?utf-8?B?b3ZiME84UmR6NEpWNEdoaUxNaUJBN2cveWZsY2NmdlVPTHJlUk80UTNWSDcw?=
 =?utf-8?B?SlQxUnp1QzQ2cmlyeEdXN3RDK1pZSlVCYjh1UElPUE14U2oyUUhWZGhPNEZi?=
 =?utf-8?B?VDhoQ01lWVdseW8ydnJqN2Z1aklJT3IyRTFxNG1oOStkV1NGaWxDOWRjZGxj?=
 =?utf-8?B?ME1RbXlFbUxNWExhRmZoVmZCZ3dOUDFySnpaS1ppajdWNlJKdzVmcklLOXFo?=
 =?utf-8?B?Z1ozanlhRi9hNHhYVVI4akJoR1ZvWStlR2RMRkF6UnhvWVc5T0NKSTRlbUcz?=
 =?utf-8?B?U3kzOFZTMnM3a0hVTmxtcGJwR092dUZ0NDFPaW1KWVIwL2NRUWhKUzB4WXRh?=
 =?utf-8?B?bnVnd1VVUlRTeTAvTUtqak1YbXREdVRVejdzNlpnWGVvTlRualVkajhCSG9w?=
 =?utf-8?B?RGZxTnVBL2w1ZVZ2UlkwcWhkVTUzK1Y0U3JxMGtxNzU4VUxtOGxSOXAvMXda?=
 =?utf-8?B?VWtLUDdOc0xQSXJNSzkwdWdMNXFjeFJFN3QyV1JzMnFEalY3R0RONGZGYUI2?=
 =?utf-8?B?eDBwSDN5bk1uWFA0ZGR4QjFBSE85K1lWUlRHTzd0ZEg5bFBVa2l3Z3FKV3hG?=
 =?utf-8?B?TFFHQUZvWXR0T3hGRTRsSXR1Vys2V1VLOXdlQ3czOTVkM2d0OWVSVFMxdk0x?=
 =?utf-8?B?aEhJcjBtOFYvNlNVbjhEWFMrVjhVWElZb1k3RWRYSXhtVHZZRnM5U0xnWnUw?=
 =?utf-8?B?T3dOVlNZTWVDa29JaWEyZ0U3YmZZSlNBRmYrRUN2VkhnekpOekdWMlhoRlpv?=
 =?utf-8?B?NVRzbEFDd0lxNytSMjZtQnAxbjNOaTZJdUdIc2hBaU1GdHpTWmh0a1plSFJJ?=
 =?utf-8?B?K3NxOXFGSU5FU1VOWFR0QXROVE9PVW9zMWxrdlMzNlFTeGpCR1NwWThnQ04w?=
 =?utf-8?B?bHdoWThiNXQ5MWx5MzVpdDJuOXZId2RFcTAxcURlbTkxQVdXTHU0T3k1RzVO?=
 =?utf-8?B?dUZkanp0MFBrcXZ3blZqcVg2YjdDdkErRGhwMmFscnVlK2hPSmg3WmJIeEp4?=
 =?utf-8?Q?BtXbHprsa1dX/5taPmiuUDA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <82E15E299C5E1447937A8DCB1AB35904@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2krOxdJJ/MSLR6g0vrwh9IrzaoO3LL8jlAa+lG15SL/qm7zrEWKJtGGgXfFoKxIohEYF8/XuK93ATveCh+LJuWa4Qjt5iCn5FfmxOowahMM9BS5EU49ot7Na56e2GG4kliVr5u0kgpZqaolAyeBptIw+YJwwt1NiQ2fjuJXpS8mmq3kB9+Dc3QhMisfLIDkSpySMspPtCRMSnf7REQ9eULxXBvcTq4HMDksTASu3thRa4MhOD08QMS6uPkqJDxLn79pqpUXYFSVGD+uzGColTM5lD1rozuZWBPYkStOAml0P2N0HYGpw3lcucY7BMCiFAtagH94HgXyNij1XggQ2dFn1YCXa7VNVrvgcCDM6wdgvAGye+H+17WaYyMd15rZFSxYDlLWP0uGsaJ5lAyWjV4Khn8DkaJqJh0R6yjrGQNlN+QhW7z2YKyYy01Nedybh+rjxHocf4bHwdabmCjEvctHotaDpYyD2sKWMcYAXmjxHR9qU0z/9c69lRqqyuTgYrUvJPaD8VYKnA/8uFusrVbiq8LgH3s10SYaYpwT370oMQcAgPHflOrm5Vehh2Ff58VXe2myymkl9oqa6+1d5FdUrrUXDq+62BtG48ALCdIoXA0TufKssjz8FbQrBSbnWr2NtaggMRwoR+BV2nEyrKg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR19MB3864.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eca245d1-ee6e-44b7-85cb-08dcc82b73e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2024 13:06:53.2596
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: onPVw+SqCxPvn+IE78zNBnr24JBvIl6Ymmn50kwgn/HINu/Ow1Mhlx3recxILtW1NCE+1yFPNJBElF9WygislA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR19MB4916
X-OriginatorOrg: ddn.com
X-BESS-ID: 1724942441-105596-22694-5193-1
X-BESS-VER: 2019.1_20240827.1824
X-BESS-Apparent-Source-IP: 104.47.57.177
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoYGhhZAVgZQ0MDc1DTNxDjJ2M
	LSzNDcyNTcLC3Z2MzEMNUsKcXYwjRRqTYWANbocO9BAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.258676 [from 
	cloudscan16-174.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_SC0_MISMATCH_TO, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

T24gOC8yOS8yNCAxNTowNCwgQmVybmQgU2NodWJlcnQgd3JvdGU6DQo+IE9uIDgvMjkvMjQgMTQ6
NDYsIE1pa2xvcyBTemVyZWRpIHdyb3RlOg0KPj4gT24gTW9uLCAxMiBBdWcgMjAyNCBhdCAxODoz
NywgQmVybmQgU2NodWJlcnQgPGJlcm5kLnNjaHViZXJ0QGZhc3RtYWlsLmZtPiB3cm90ZToNCj4+
Pg0KPj4+IFNvcnJ5LCBJIGhhZCBzZW50IG91dCB0aGUgd3Jvbmcvb2xkIHBhdGNoIGZpbGUgLSBp
dCBkb2Vzbid0IGhhdmUgb25lIGNoYW5nZQ0KPj4+IChoYW5kbGluZyBvZiBhbHJlYWR5IGFsaWdu
ZWQgYnVmZmVycykuDQo+Pj4gU2hhbGwgSSBzZW50IHY0PyBUaGUgY29ycmVjdCB2ZXJzaW9uIGlz
IGJlbG93DQo+Pj4NCj4+PiAtLS0NCj4+Pg0KPj4+IEZyb206IEJlcm5kIFNjaHViZXJ0IDxic2No
dWJlcnRAZGRuLmNvbT4NCj4+PiBEYXRlOiBGcmksIDIxIEp1biAyMDI0IDExOjUxOjIzICswMjAw
DQo+Pj4gU3ViamVjdDogW1BBVENIIHYzXSBmdXNlOiBBbGxvdyBwYWdlIGFsaWduZWQgd3JpdGVz
DQo+Pj4NCj4+PiBXcml0ZSBJT3Mgc2hvdWxkIGJlIHBhZ2UgYWxpZ25lZCBhcyBmdXNlIHNlcnZl
cg0KPj4+IG1pZ2h0IG5lZWQgdG8gY29weSBkYXRhIHRvIGFub3RoZXIgYnVmZmVyIG90aGVyd2lz
ZSBpbg0KPj4+IG9yZGVyIHRvIGZ1bGZpbGwgbmV0d29yayBvciBkZXZpY2Ugc3RvcmFnZSByZXF1
aXJlbWVudHMuDQo+Pg0KPj4gT2theS4NCj4+DQo+PiBTbyB3aHkgbm90IGFsaWduIHRoZSBidWZm
ZXIgaW4gdXNlcnNwYWNlIHNvIHRoZSBwYXlsb2FkIG9mIHRoZSB3cml0ZQ0KPj4gcmVxdWVzdCBs
YW5kcyBvbiBhIHBhZ2UgYm91bmRhcnk/DQo+Pg0KPj4gSnVzdCB0aGUgY2FzZSB0aGF0IHlvdSBo
YXZlIG5vdGVkIGluIHRoZSBmdXNlX2NvcHlfYWxpZ24oKSBmdW5jdGlvbi4NCj4gDQo+IEhvdyB3
b3VsZCB5b3UgZG8gdGhhdCB3aXRoIHNwbGljZT8NCj4gDQoNClNvcnJ5IGZvcmdvdCwgYWRkaXRp
b25hbGx5IHdlIChhdCBERE4pIHdpbGwgcHJvYmFibHkgYWxzbyBuZWVkIGFsaWduZWQNCnNldHhh
dHRyLg0KDQoNClRoYW5rcywNCkJlcm5kDQo=

