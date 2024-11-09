Return-Path: <linux-fsdevel+bounces-34142-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9199C2EA4
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Nov 2024 18:01:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6ED54B21934
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Nov 2024 17:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC5919D8A7;
	Sat,  9 Nov 2024 17:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="R1r3AxDp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MP1BKOJs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A0B29CF4;
	Sat,  9 Nov 2024 17:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731171666; cv=fail; b=c3SWSbSs4pLUYMWuloXH4dPtVYY/642VciLwLAwWeIINijPwPwyeDHDNKwteQgYvsTNvBjiKnnFqX6wqmTf4wgWLKaWV0DnL1ApBWPLeIQvKqjOPBM9oDaU+6fPowZZ1hWrtvAa5wr2qq6lLxTlnYRc/uEBQdMBCnIGaE7wt1g0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731171666; c=relaxed/simple;
	bh=fqPNbtUdjp1jqf4wU/TRy2euygR/YApxFK7esikznKg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZZbjYVroG2iAF0PfAPFNjnwp13v1lBHbmJcwQe7oLZFKesFLjau1TCh1CQB4/nghF+uj73dwXvsyieVnjBtxbDcXaG0Nf568hsP+Talc/rviHW8MENWfeBhRhpSGrClewQjbqZbkdEPTe5aj+wVzYnqlftg2YyayTLwGrE/T5lw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=R1r3AxDp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MP1BKOJs; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A9C05fP021575;
	Sat, 9 Nov 2024 16:58:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=fqPNbtUdjp1jqf4wU/TRy2euygR/YApxFK7esikznKg=; b=
	R1r3AxDpwG0VrGWFqmBe7uuQeybDaYmNw3lyRC/Sj7Fg7lLhvVGqp3u3c8bIwXLO
	Z7Um8dMAy5Io+Pqw2FKJ7G3GgR+D1e7nF20iEVDlDVoz2ZwezUJx0+tfLVHdlojh
	bbykeYu3JjTHXZkw+0Wd2EajSNAF/xP+wEtMwT5bb3KHIn6CTrjt6RknuBHGelLh
	Bhi7kSeQ71H1ApJneK/lYbr5dBbEeDIRi+DdvuIrze6bv3NfreY14NwxlzpcGIhP
	405fFkR9PegXUD8VBGfWmoeaUjy33XbMIHuvhAw234hMic+KwbhkIcu2kXk11uM2
	emKprm4C0FYYjyK2J0WjZQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0hn8d0v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 09 Nov 2024 16:58:56 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A9Gss33028252;
	Sat, 9 Nov 2024 16:58:51 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42tbp4r19v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 09 Nov 2024 16:58:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=miCA6KwlVmLl9LKJAfBAJOBV3Ny/ymZY4P31nYIhiXIB2C01oDhJAwt4cUi5bj5rU3DaovqibOwKQ+UQh6JooQqajgnyzn+wPVJ7yB1oZ18RVJaUJdcQd6v71XtZTLj0tROibvKdxPFSwX8Do9DPmTxCKTgZfRtq8jsQrDfZSFeYnk99BTVVeGMovi56VZWWqPKfHk2nLwfKJuXogn2AsDCjFGKv8n1gRIL2r3FznjyYqctRIXA3AFaUS5IG60OAoCp6iZm+NQJL+ukOlmtuZBvLWznF+Vx1C1cvKRuiHVkQKjQMdJu8o75WSFN6nptMGtimEfPzGV/S3wcAORPqgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fqPNbtUdjp1jqf4wU/TRy2euygR/YApxFK7esikznKg=;
 b=xp1yi9etZecmRUM5MV5IM1ylYb2W2s0y8vhhjQvB9jY6OGSLTn1Xn9eamqlvnZ1qSzPuhuuSBUBL57D+irQOLl9CLqqzAri6jFNDbdY9kIYRqQUyBDcAxz0TDtz/qkPNtgWUzNopouBRLmHCQAf1bj7suEcjFJihRvzkLmhwZm/+jYCoRlOQPjYmgVK/oZ35zZi43E7yIcSHAZ1yPjoe5hqNGWMswvtM2fnwTKkuAOVUdB4EpIXRpKenqc9URDPVAiCkM59P9O5YyWIImd+gmDvV7Pfcf6b3r5zKntwkZmjCjqSG9bg4CY8Y7LhZYhq9jTZF8uEGuvBggNmpwSXCbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fqPNbtUdjp1jqf4wU/TRy2euygR/YApxFK7esikznKg=;
 b=MP1BKOJsXyFerXBfyYmRgSkNo6Rcy5VLPTmteSnXhZ/DmJ3oCByrOSScxy7NbqNND9YmeQteoY5oTwyR+Iew57gtP64ze8Sd1jcVT6C8jrVHDZsWxtor9voJmVuLP1aQ762/kb3oK9lb4vvTGefWceoM8UtNNvgsmjkHLB7boGk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MN0PR10MB5936.namprd10.prod.outlook.com (2603:10b6:208:3cc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.25; Sat, 9 Nov
 2024 16:58:38 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8137.022; Sat, 9 Nov 2024
 16:58:38 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Yu Kuai <yukuai1@huaweicloud.com>, Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
CC: Greg KH <gregkh@linuxfoundation.org>,
        linux-stable
	<stable@vger.kernel.org>,
        "harry.wentland@amd.com" <harry.wentland@amd.com>,
        "sunpeng.li@amd.com" <sunpeng.li@amd.com>,
        "Rodrigo.Siqueira@amd.com"
	<Rodrigo.Siqueira@amd.com>,
        "alexander.deucher@amd.com"
	<alexander.deucher@amd.com>,
        "christian.koenig@amd.com"
	<christian.koenig@amd.com>,
        "Xinhui.Pan@amd.com" <Xinhui.Pan@amd.com>,
        "airlied@gmail.com" <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Liam Howlett <liam.howlett@oracle.com>,
        Andrew Morton
	<akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        "Matthew Wilcox
 (Oracle)" <willy@infradead.org>,
        Sasha Levin <sashal@kernel.org>,
        "srinivasan.shanmugam@amd.com" <srinivasan.shanmugam@amd.com>,
        "chiahsuan.chung@amd.com" <chiahsuan.chung@amd.com>,
        "mingo@kernel.org"
	<mingo@kernel.org>,
        "mgorman@techsingularity.net"
	<mgorman@techsingularity.net>,
        "chengming.zhou@linux.dev"
	<chengming.zhou@linux.dev>,
        "zhangpeng.00@bytedance.com"
	<zhangpeng.00@bytedance.com>,
        "amd-gfx@lists.freedesktop.org"
	<amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List
	<linux-kernel@vger.kernel.org>,
        Linux FS Devel
	<linux-fsdevel@vger.kernel.org>,
        "maple-tree@lists.infradead.org"
	<maple-tree@lists.infradead.org>,
        linux-mm <linux-mm@kvack.org>,
        "yi.zhang@huawei.com" <yi.zhang@huawei.com>,
        yangerkun
	<yangerkun@huawei.com>, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH 6.6 00/28] fix CVE-2024-46701
Thread-Topic: [PATCH 6.6 00/28] fix CVE-2024-46701
Thread-Index:
 AQHbJhfg+I/QGRtH80+9+XvDi7dLrbKp2oMAgACX0ACAAKF/gIAA5l2AgACyM4CAAMomAIAAy0wAgAEDLYA=
Date: Sat, 9 Nov 2024 16:58:38 +0000
Message-ID: <976C0DD5-4337-4C7D-92C6-A38C2EC335A4@oracle.com>
References: <20241024132009.2267260-1-yukuai1@huaweicloud.com>
 <2024110625-earwig-deport-d050@gregkh>
 <7AB98056-93CC-4DE5-AD42-49BA582D3BEF@oracle.com>
 <8bdd405e-0086-5441-e185-3641446ba49d@huaweicloud.com>
 <ZyzRsR9rMQeIaIkM@tissot.1015granger.net>
 <4db0a28b-8587-e999-b7a1-1d54fac4e19c@huaweicloud.com>
 <D2A4C13B-3B50-4BA7-A5CC-C16E98944D55@oracle.com>
 <a223b1dd-9699-5f6c-2b71-98e9cd377007@huaweicloud.com>
In-Reply-To: <a223b1dd-9699-5f6c-2b71-98e9cd377007@huaweicloud.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51.11.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|MN0PR10MB5936:EE_
x-ms-office365-filtering-correlation-id: 51517712-1838-43e8-1043-08dd00dfc1ad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NWtJM1pFTzVNY2l1Y0IzYkhwS05hQVdRaTlIeWpkNmxhYmxCa0pETW95S2lU?=
 =?utf-8?B?S1FqdmJEa0FzVmdjY0FGVWhtMGU1eEJ6Y2JqK2NwNEVhdW1yTG16Um1qUUVk?=
 =?utf-8?B?b0RCQ3EwTmNwb1Z5L2lNRCs1a2E1TUtKa0IzQkxINnBpSWVJYy9MUEdSQUdB?=
 =?utf-8?B?UktZM2wvOXJ3ZmV3V1dpOFQyK0xoYjhBOGJZdVQ2cXlrRE0yODhodXFwMlpP?=
 =?utf-8?B?ZkM1b3YwdnpHWWJVU0ZOTWJQY2NKRW5zNC9INDEyRWNuUW1Ya3F2NXdwSEp5?=
 =?utf-8?B?NkRVQ3RpTzlMR1F2RmsxWmxYRHZQZVVDZWxzZGtDM3daMU9lNzNrM1c2ZkV6?=
 =?utf-8?B?Zjh2b04zUzY1RGVlS3J0TlBlaTVXOVJlZTV0OGdTQjZQdVhyR0hzczJzNFFX?=
 =?utf-8?B?RTRpOGRMcFgvQTBSSzVsckxRM2hrL2RwdmE5OVY3NXJJbDlJTVJIbGY3ZEsy?=
 =?utf-8?B?SkZZaUdXNjJsZ0l0YUZ1R2haenFqV0VhTHNTOHB5dXlWcFY4WVoyeVdkUGs3?=
 =?utf-8?B?ajBjSmtZd3YzNjB3NERaUEcyV3NTV0hxY3ZWZVZqZGc0UjY2UkRwMFhWaXAw?=
 =?utf-8?B?QUZCaFRyRlJiMWJrd05lU1BzNWVIdW14RXFEbXMva21YcFBUWDdhb1RsZktQ?=
 =?utf-8?B?OEVUUlhuUDkxMDkwc2E3MlFBYXFiNDIrcmJNdjVtanhlcFJpbWxRUTlSZGl3?=
 =?utf-8?B?UThTSHNUQWwzdHg4YTZQSmhNWHJDRVpmUnJTMmhzUEFuSjJGZmNWMHJKMGN0?=
 =?utf-8?B?SmlwY2xNTXJHQTc3akdDRmxnZXFlaUpPNHIyYjZMK0lOT1QwK1hlc0tFSEdo?=
 =?utf-8?B?QVhiTVZKTXg5b2tRUlpsQ0I3UmpsczJKZDdaQlZ1ZXFTT3hQQitFT2pkWXE2?=
 =?utf-8?B?M3VLcnA3aVppQmhVc0xUcnFsaUR6SlZSZ29wT25QV3lTdHVYWGRkdXBBeWxh?=
 =?utf-8?B?Mktkam1WM2duUi9kWE1zRkpoV0hJZUR1TlBKMnhYcHozbExFKzMxM1B6N1hR?=
 =?utf-8?B?a21pTzl5N1dRempGcEVmUFkrQUF2b0QxcCtZNDF2ZENzRUV2N09TZ0lOV3RY?=
 =?utf-8?B?Ryt0dzVPbXg0aXVhVGJxQUVGMjZHRmozZzZkMmI3Lyt1M2RIVmZsclFqNkMx?=
 =?utf-8?B?VGczSk1WeVoyMGIyanp0RUdJdTFoY2RwRVlzcStYbUtTMUw1VnNncVptRmFm?=
 =?utf-8?B?dG9zZU1nU2RkSmFNNGRtd1RvbmQ2b0NQRGIyK3RNYXZrS0pkNkp1UnNBS1o2?=
 =?utf-8?B?dFZZaHphVkV6NS93aXFqYjFzQ0pJSmplbEJXYXZMaS9vVW9TVDJyZzZ0RHUr?=
 =?utf-8?B?bC94UFZVdHpzeDlEUUlKYjlUdXJSSFovcUdlWDhVdGRYd2JZdVhXbFQ4cnJt?=
 =?utf-8?B?QThCY29wdGhsb2dKQTlzdXB4U0hzU3NEZ0RrMnBkWVFXMXdYUTA4WG43L0cx?=
 =?utf-8?B?VVJvV2ViVkQ0d3M5L0VyWFdsMjhIcHpQanM3dXJuWmNPakc2N3g1a0dhcGlX?=
 =?utf-8?B?aUp3OTFjbVlUZlJ1TmdDZlQvSG9VeGJJUGtsK2JyUElud1RsYnFhTnk3c1JQ?=
 =?utf-8?B?OHZ1dWNHM1NjeVQyOVlNdW1NNVNkY0ZZV3VxaXROUm5NeVo5c29QK2xpOW9z?=
 =?utf-8?B?dzVrVVh1ZTM0c1Q0Z2p4UmVoc3RoZnVqcDJjWUZYSndDd0U4WG1PdUh3clhQ?=
 =?utf-8?B?L1kzYmhYL0l3OW1LNGUzRlhZVHoxTGF1SzQ5eDdGUWtjY2grM3RMdUZIWGty?=
 =?utf-8?B?WVp1VEc3L1dmSWk3MFp4dE9ldEJ5NlZZVkdRaW5QSjNNRVVDOFdJSEtOWkdk?=
 =?utf-8?B?WWViK3VDQnFQcHhzdmkzTnFqdGxRZXVVcUJjZkhpWldVV20xTzFuZjVOZHlx?=
 =?utf-8?Q?9wmgI6bcBiwBc?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M0xuYTBaeUxLZjV0Vmpoa3ZCUnRZM0FFalIyTkZ2YWZ1MDdJVlI0QzNoanRZ?=
 =?utf-8?B?dTAvOUhUYzVrbG04NXdIblVMREE2cmF2b01nZ3BWMXh3K3E3R0lTVVRwdzE0?=
 =?utf-8?B?VTVYU0M2RGRJWlYrMWJWK1ZDQTJnOFcxTDVKMzduV1d1RGg1dWZ0NEVZN2V4?=
 =?utf-8?B?M0VqMjJsTStUcjhZNFQreGpPSk9TUzczWHhkTmZiVS91U3ZHNjlDK1hPWmN3?=
 =?utf-8?B?NUI1UkRMekZ3SENKbDl3ak5wWGxxbjhKall0TzduQ1ZMVzBQdUVDZ0dRN091?=
 =?utf-8?B?K0ROUGdQcGM1SGlPVG5wSGhEalhQM1d3YW9pelg3QVBxdGxvcmNlTU4yZ0FR?=
 =?utf-8?B?SHdpMzZzLzR0dWlwMkR3Z2laaEp5QWNoNUtWN2ladndRUEJrZ1U5WkdhaHJt?=
 =?utf-8?B?UG50aTIrOURtMURYWUZIbCtzU2E4MElWQ0xzU1E2QnN3M1o3Q0VYTVhjNy9m?=
 =?utf-8?B?VktsMFhENXBxWDQvOVZpSmE3ZVhMckVuMzlmdE4yb3lGZmIxUkdkMytDUHlF?=
 =?utf-8?B?ZTRTMXZPUmxTNHR5RlprcDh3UHBYRXZ3SFZkaDFQMC8vVXhoRGFQVDFlYVcx?=
 =?utf-8?B?Q1pVVFdnVENqdFA5SkVSWGxBWUdEcGFaK1pvRUEyS2NpbUIyRGd0WlMwVnNR?=
 =?utf-8?B?Rmg4UHJvUFhXUXdBZDNVU1BUV0w2cUhvR3VvVGo0ZTJ4THdVNitTYXdHWW8v?=
 =?utf-8?B?V2x1ZHNpZ05xb2VVQUlpWVRUc1BqS2NPa0RxV1lPUTljR3UwZDFIME5Gcmdk?=
 =?utf-8?B?MjJQSDR3dmFXTDI0bzhRdmNPTXpUa3RRbzRFUEgvQlFxbHFCVWRwWTB2MVdN?=
 =?utf-8?B?QjhKVW5WVVp0anFhME1QeVpRZlRNZXJ3Q213bmJRRU5rMlJqajBOdjNxNVJj?=
 =?utf-8?B?V3FXRDVtV0t5elRkZzhXcXdVNnJ2OVBnU2lSUEZ2QWxockNKNU5ybnR2RzNr?=
 =?utf-8?B?RkpXWnppeW1KdVpvY3lSdHgvUks2NjNKbDY2Vnp1SVlWeU1iWWZmU0lsaHBN?=
 =?utf-8?B?a0d2cjQxRityZEg0RHZieWRCNXBpa05BaGVQaEJLU1R2WllnLzc0Q0FnMTZ0?=
 =?utf-8?B?SjU4UzVsOVM3SnZtNE53K1R0bFBjdWtLYkFWVVZIWnMrTUVIZGZXL1l5MGFy?=
 =?utf-8?B?ci9BQ3RHRzJ1eU1vUEUvaHovZzdrWDRuV2hYTTVpKzR1VnRVZTl2ejFscGgr?=
 =?utf-8?B?VUhqeVJBYkgwZ2h3WnVRTXRneThHbWlCcmZVQjhqNG0xQnJlVnMzZ1Q0N2NZ?=
 =?utf-8?B?emRKRXBvclpGVktNQkw3M2hIQXVlSlg2b25JSXYrL1c1dEtkQUt4Y01zd3RK?=
 =?utf-8?B?d08xVnBoSzhRSlZrRWZnekNSb0xjWjY4Wlp4bzFwUkxYeTh1YWk0TjN3ekdF?=
 =?utf-8?B?N0Q5UmdDN0JOQW9wb2ZVcmkrRUdLYzJyQk5SQmlIS29vbndQRUZ1SzVxZndW?=
 =?utf-8?B?OHJrV0ZzUjZaeVpBVnY5TCtKWGd3U3Z4bGE0TDUzNmVTdUJPRVd4eVY3RmRB?=
 =?utf-8?B?ZlVrT3NWekJ1NHVQS2FUaUgzY09YU09BclZKbFpRYUV2Ni9qcFYzM1NXQ1B6?=
 =?utf-8?B?bmpNUzZBMXkzVDZWNXFhVmY3RWN1T04vc1pOOUg3NTlnZVd0ZWp5Z0w4dHVm?=
 =?utf-8?B?UXlEeDVkTjhlbW91aTVBS3ZkM0c2L0NJdkNxQVVnM2ZINDVMQ1NCM3owTHBL?=
 =?utf-8?B?VGFwRldueUc4RHVkSEdPM1E0c0laRDl4ejlpNlNwd3Q0YURCQ2N1am1XY3NK?=
 =?utf-8?B?bGEzV3hkODBCdVFoQUNkcm9RaTNOVmQwdG9TQWZrbW96WjlhRWM5eVByWmFZ?=
 =?utf-8?B?Nlp3Zit6d3pHYkF6OEhQRFhreStPekVsUlUyTEpsVStrUnlxN3gwSzVndVNk?=
 =?utf-8?B?cGNvcWFGWE5vS1pxYzJlSEp2ZEVLcndFOExWNnFpNG1RMDBMYy80TDRQbThr?=
 =?utf-8?B?aEk2NDA1Q0ZiNFBmMjdoN3RLM0MvMTgvTktZdVZ4UE1PZGViZ1N3Zlh0dnVR?=
 =?utf-8?B?TW9YNDlrNWI1dXhTV3ZvTFJuRUJTdTdIS1VRcDl0RHMxSVFheUN4T2JWaXNZ?=
 =?utf-8?B?NGRwNU9KNVVNNUtOYXJHSzRKS0RMUlI4cld3NURxZk9NZEhJekhIRGFMcS91?=
 =?utf-8?B?UlovMmdReDlsYzNLVU9RMXNKK0VCOHFqR0NFS0E0NFdIUUtJSHNsWkhEVnhz?=
 =?utf-8?B?WUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <66FECE7881F21445B8081354E88C6F3F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DYtl7IWg/gW43ouAN9kWZoPDETrQxV2SdL1uBc+td6b7XGKi3dlLnt2caNl1W47n1036gLQxWD6UHDI8TBM6Z1iFJmtFMG8+Fwd41tMtSyGnAhfYNFOmD6Ody99d3nsy044p9TOpN/92JKcKvWjCGuETZCIZ/d5N1XFV6BJQ5AQ7rC1aePnMvGmdMTnut7wmxjr7sBAQdlX9q5bPQzOvgrAe1yXSUrVckWjGp+du8Ay9shD+vvBxxkWxr+gtQNpHt1xszJDIJBdBYeQ7R6lMZi/sZHcZwGPmQbSqi9AXDEn8nqDjKFPeB9nKhxcVheF+Ih1XClcroQ45+KSoQwm0l2WgVAlffRttKFY9p/C7tomWrViDtKqizDH8ZSog8mC0D35oRruOThX0VHpuW7cRWhPl4/vm1vOgxUaImLC2iSbaEc9Oooo8aechOUai0RxmG5np1+f/yD2OobQjWYej0FcivUNCgyqhJzP5/eEWvPSo86Uy2At5CgOUIStSulLs8Mc8Cq5DF95rTLqMA1Bu8bWOrFxqRzqFhQnkrxZkRn53Wkobn49NnqBJfE1mxqflppLdaqZhqS/bgHrRh5BmScBu7XbVvaTRh6yv88QZalw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51517712-1838-43e8-1043-08dd00dfc1ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2024 16:58:38.3390
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M+Gps7Dv8R8yr/E4k9W8KezdDBu3BIUb18xve8tiejwmxuI670AiSLpm0ND4S5IPOXoN3eV31shV1sIniKNpbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB5936
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-09_16,2024-11-08_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411090145
X-Proofpoint-GUID: c_irG-9gONSaTnZHtsZA4eWwUai0hSkr
X-Proofpoint-ORIG-GUID: c_irG-9gONSaTnZHtsZA4eWwUai0hSkr

DQoNCj4gT24gTm92IDgsIDIwMjQsIGF0IDg6MzDigK9QTSwgWXUgS3VhaSA8eXVrdWFpMUBodWF3
ZWljbG91ZC5jb20+IHdyb3RlOg0KPiANCj4gSGksDQo+IA0KPiDlnKggMjAyNC8xMS8wOCAyMToy
MywgQ2h1Y2sgTGV2ZXIgSUlJIOWGmemBkzoNCj4+PiBPbiBOb3YgNywgMjAyNCwgYXQgODoxOeKA
r1BNLCBZdSBLdWFpIDx5dWt1YWkxQGh1YXdlaWNsb3VkLmNvbT4gd3JvdGU6DQo+Pj4gDQo+Pj4g
SGksDQo+Pj4gDQo+Pj4g5ZyoIDIwMjQvMTEvMDcgMjI6NDEsIENodWNrIExldmVyIOWGmemBkzoN
Cj4+Pj4gT24gVGh1LCBOb3YgMDcsIDIwMjQgYXQgMDg6NTc6MjNBTSArMDgwMCwgWXUgS3VhaSB3
cm90ZToNCj4+Pj4+IEhpLA0KPj4+Pj4gDQo+Pj4+PiDlnKggMjAyNC8xMS8wNiAyMzoxOSwgQ2h1
Y2sgTGV2ZXIgSUlJIOWGmemBkzoNCj4+Pj4+PiANCj4+Pj4+PiANCj4+Pj4+Pj4gT24gTm92IDYs
IDIwMjQsIGF0IDE6MTbigK9BTSwgR3JlZyBLSCA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+
IHdyb3RlOg0KPj4+Pj4+PiANCj4+Pj4+Pj4gT24gVGh1LCBPY3QgMjQsIDIwMjQgYXQgMDk6MTk6
NDFQTSArMDgwMCwgWXUgS3VhaSB3cm90ZToNCj4+Pj4+Pj4+IEZyb206IFl1IEt1YWkgPHl1a3Vh
aTNAaHVhd2VpLmNvbT4NCj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4gRml4IHBhdGNoIGlzIHBhdGNoIDI3
LCByZWxpZWQgcGF0Y2hlcyBhcmUgZnJvbToNCj4+Pj4+PiANCj4+Pj4+PiBJIGFzc3VtZSBwYXRj
aCAyNyBpczoNCj4+Pj4+PiANCj4+Pj4+PiBsaWJmczogZml4IGluZmluaXRlIGRpcmVjdG9yeSBy
ZWFkcyBmb3Igb2Zmc2V0IGRpcg0KPj4+Pj4+IA0KPj4+Pj4+IGh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL3N0YWJsZS8yMDI0MTAyNDEzMjIyNS4yMjcxNjY3LTEyLXl1a3VhaTFAaHVhd2VpY2xvdWQu
Y29tLw0KPj4+Pj4+IA0KPj4+Pj4+IEkgZG9uJ3QgdGhpbmsgdGhlIE1hcGxlIHRyZWUgcGF0Y2hl
cyBhcmUgYSBoYXJkDQo+Pj4+Pj4gcmVxdWlyZW1lbnQgZm9yIHRoaXMgZml4LiBBbmQgbm90ZSB0
aGF0IGxpYmZzIGRpZA0KPj4+Pj4+IG5vdCB1c2UgTWFwbGUgdHJlZSBvcmlnaW5hbGx5IGJlY2F1
c2UgSSB3YXMgdG9sZA0KPj4+Pj4+IGF0IHRoYXQgdGltZSB0aGF0IE1hcGxlIHRyZWUgd2FzIG5v
dCB5ZXQgbWF0dXJlLg0KPj4+Pj4+IA0KPj4+Pj4+IFNvLCBhIGJldHRlciBhcHByb2FjaCBtaWdo
dCBiZSB0byBmaXQgdGhlIGZpeA0KPj4+Pj4+IG9udG8gbGludXgtNi42Lnkgd2hpbGUgc3RpY2tp
bmcgd2l0aCB4YXJyYXkuDQo+Pj4+PiANCj4+Pj4+IFRoZSBwYWluZnVsIHBhcnQgaXMgdGhhdCB1
c2luZyB4YXJyYXkgaXMgbm90IGFjY2VwdGFibGUsIHRoZSBvZmZldA0KPj4+Pj4gaXMganVzdCAz
MiBiaXQgYW5kIGlmIGl0IG92ZXJmbG93cywgcmVhZGRpciB3aWxsIHJlYWQgbm90aGluZy4gVGhh
dCdzDQo+Pj4+PiB3aHkgbWFwbGVfdHJlZSBoYXMgdG8gYmUgdXNlZC4NCj4+Pj4gQSAzMi1iaXQg
cmFuZ2Ugc2hvdWxkIGJlIGVudGlyZWx5IGFkZXF1YXRlIGZvciB0aGlzIHVzYWdlLg0KPj4+PiAg
LSBUaGUgb2Zmc2V0IGFsbG9jYXRvciB3cmFwcyB3aGVuIGl0IHJlYWNoZXMgdGhlIG1heGltdW0s
IGl0DQo+Pj4+ICAgIGRvZXNuJ3Qgb3ZlcmZsb3cgdW5sZXNzIHRoZXJlIGFyZSBhY3R1YWxseSBi
aWxsaW9ucyBvZiBleHRhbnQNCj4+Pj4gICAgZW50cmllcyBpbiB0aGUgZGlyZWN0b3J5LCB3aGlj
aCBJTU8gaXMgbm90IGxpa2VseS4NCj4+PiANCj4+PiBZZXMsIGl0J3Mgbm90IGxpa2VseSwgYnV0
IGl0J3MgcG9zc2libGUsIGFuZCBub3QgaGFyZCB0byB0cmlnZ2VyIGZvcg0KPj4+IHRlc3QuDQo+
PiBJIHF1ZXN0aW9uIHdoZXRoZXIgc3VjaCBhIHRlc3QgcmVmbGVjdHMgYW55IHJlYWwtd29ybGQN
Cj4+IHdvcmtsb2FkLg0KPj4gQmVzaWRlcywgdGhlcmUgYXJlIGEgbnVtYmVyIG9mIG90aGVyIGxp
bWl0cyB0aGF0IHdpbGwgaW1wYWN0DQo+PiB0aGUgYWJpbGl0eSB0byBjcmVhdGUgdGhhdCBtYW55
IGVudHJpZXMgaW4gb25lIGRpcmVjdG9yeS4NCj4+IFRoZSBudW1iZXIgb2YgaW5vZGVzIGluIG9u
ZSB0bXBmcyBpbnN0YW5jZSBpcyBsaW1pdGVkLCBmb3INCj4+IGluc3RhbmNlLg0KPj4+IEFuZCBw
bGVhc2Ugbm90aWNlIHRoYXQgdGhlIG9mZnNldCB3aWxsIGluY3JlYXNlIGZvciBlYWNoIG5ldyBm
aWxlLA0KPj4+IGFuZCBmaWxlIGNhbiBiZSByZW1vdmVkLCB3aGlsZSBvZmZzZXQgc3RheXMgdGhl
IHNhbWUuDQo+IA0KPiBEaWQgeW91IHNlZSB0aGUgYWJvdmUgZXhwbGFuYXRpb24/IGZpbGVzIGNh
biBiZSByZW1vdmVkLCB5b3UgZG9uJ3QgaGF2ZQ0KPiB0byBzdG9yZSB0aGF0IG11Y2ggZmlsZXMg
dG8gdHJpZ2dlciB0aGUgb2Zmc2V0IHRvIG92ZXJmbG93Lg0KPj4+PiAgLSBUaGUgb2Zmc2V0IHZh
bHVlcyBhcmUgZGVuc2UsIHNvIHRoZSBkaXJlY3RvcnkgY2FuIHVzZSBhbGwgMi0gb3INCj4+Pj4g
ICAgNC0gYmlsbGlvbiBpbiB0aGUgMzItYml0IGludGVnZXIgcmFuZ2UgYmVmb3JlIHdyYXBwaW5n
Lg0KPj4+IA0KPj4+IEEgc2ltcGxlIG1hdGgsIGlmIHVzZXIgY3JlYXRlIGFuZCByZW1vdmUgMSBm
aWxlIGluIGVhY2ggc2Vjb25kcywgaXQgd2lsbA0KPj4+IGNvc3QgYWJvdXQgMTMwIHllYXJzIHRv
IG92ZXJmbG93LiBBbmQgaWYgdXNlciBjcmVhdGUgYW5kIHJlbW92ZSAxMDAwDQo+Pj4gZmlsZXMg
aW4gZWFjaCBzZWNvbmQsIGl0IHdpbGwgY29zdCBhYm91dCAxIG1vbnRoIHRvIG92ZXJmbG93Lg0K
DQo+IFRoZSBwcm9ibGVtIGlzIHRoYXQgaWYgdGhlIG5leHRfb2Zmc2V0IG92ZXJmbG93cyB0byAw
LCB0aGVuIGFmdGVyIHBhdGNoDQo+IDI3LCBvZmZzZXRfZGlyX29wZW4oKSB3aWxsIHJlY29yZCB0
aGUgMCwgYW5kIGxhdGVyIG9mZnNldF9yZWFkZGlyIHdpbGwNCj4gcmV0dXJuIGRpcmVjdGx5LCB3
aGlsZSB0aGVyZSBjYW4gYmUgbWFueSBmaWxlcy4NCg0KDQpMZXQgbWUgcmV2aXNpdCB0aGlzIGZv
ciBhIG1vbWVudC4gVGhlIHhhX2FsbG9jX2N5Y2xpYygpIGNhbGwNCmluIHNpbXBsZV9vZmZzZXRf
YWRkKCkgaGFzIGEgcmFuZ2UgbGltaXQgYXJndW1lbnQgb2YgMiAtIFUzMl9NQVguDQoNClNvIEkn
bSBub3QgY2xlYXIgaG93IGFuIG92ZXJmbG93IChvciwgbW9yZSBwcmVjaXNlbHksIHRoZQ0KcmV1
c2Ugb2YgYW4gb2Zmc2V0IHZhbHVlKSB3b3VsZCByZXN1bHQgaW4gYSAiMCIgb2Zmc2V0IGJlaW5n
DQpyZWNvcmRlZC4gVGhlIHJhbmdlIGxpbWl0IHByZXZlbnRzIHRoZSB1c2Ugb2YgMCBhbmQgMS4N
Cg0KQSAiMCIgb2Zmc2V0IHZhbHVlIHdvdWxkIGJlIGEgYnVnLCBJIGFncmVlLCBidXQgSSBkb24n
dCBzZWUNCmhvdyB0aGF0IGNhbiBoYXBwZW4uDQoNCg0KPj4gVGhlIHF1ZXN0aW9uIGlzIHdoYXQg
aGFwcGVucyB3aGVuIHRoZXJlIGFyZSBubyBtb3JlIG9mZnNldA0KPj4gdmFsdWVzIGF2YWlsYWJs
ZS4geGFfYWxsb2NfY3ljbGljIHNob3VsZCBmYWlsLCBhbmQgZmlsZQ0KPj4gY3JlYXRpb24gaXMg
c3VwcG9zZWQgdG8gZmFpbCBhdCB0aGF0IHBvaW50LiBJZiBpdCBkb2Vzbid0LA0KPj4gdGhhdCdz
IGEgYnVnIHRoYXQgaXMgb3V0c2lkZSBvZiB0aGUgdXNlIG9mIHhhcnJheSBvciBNYXBsZS4NCj4g
DQo+IENhbiB5b3Ugc2hvdyBtZSB0aGUgY29kZSB0aGF0IHhhX2FsbG9jX2N5Y2xpYyBzaG91bGQg
ZmFpbD8gQXQgbGVhc3QNCj4gYWNjb3JkaW5nIHRvIHRoZSBjb21tZXRzLCBpdCB3aWxsIHJldHVy
biAxIGlmIHRoZSBhbGxvY2F0aW9uIHN1Y2NlZWRlZA0KPiBhZnRlciB3cmFwcGluZy4NCj4gDQo+
ICogQ29udGV4dDogQW55IGNvbnRleHQuICBUYWtlcyBhbmQgcmVsZWFzZXMgdGhlIHhhX2xvY2su
ICBNYXkgc2xlZXAgaWYNCj4gKiB0aGUgQGdmcCBmbGFncyBwZXJtaXQuDQo+ICogUmV0dXJuOiAw
IGlmIHRoZSBhbGxvY2F0aW9uIHN1Y2NlZWRlZCB3aXRob3V0IHdyYXBwaW5nLiAgMSBpZiB0aGUN
Cj4gKiBhbGxvY2F0aW9uIHN1Y2NlZWRlZCBhZnRlciB3cmFwcGluZywgLUVOT01FTSBpZiBtZW1v
cnkgY291bGQgbm90IGJlDQo+ICogYWxsb2NhdGVkIG9yIC1FQlVTWSBpZiB0aGVyZSBhcmUgbm8g
ZnJlZSBlbnRyaWVzIGluIEBsaW1pdC4NCj4gKi8NCj4gc3RhdGljIGlubGluZSBpbnQgeGFfYWxs
b2NfY3ljbGljKHN0cnVjdCB4YXJyYXkgKnhhLCB1MzIgKmlkLCB2b2lkICplbnRyeSwNCj4gc3Ry
dWN0IHhhX2xpbWl0IGxpbWl0LCB1MzIgKm5leHQsIGdmcF90IGdmcCkNCg0KSSByZWNhbGwgKGRp
bWx5KSB0aGF0IGRpcmVjdG9yeSBlbnRyeSBvZmZzZXQgdmFsdWUgcmUtdXNlDQppcyBhY2NlcHRh
YmxlIGFuZCBwcmVmZXJyZWQsIHNvIEkgdGhpbmsgaWdub3JpbmcgYSAiMSINCnJldHVybiB2YWx1
ZSBmcm9tIHhhX2FsbG9jX2N5Y2xpYygpIGlzIE9LLiBJZiB0aGVyZSBhcmUNCm5vIHVudXNlZCBv
ZmZzZXQgdmFsdWVzIGF2YWlsYWJsZSwgaXQgd2lsbCByZXR1cm4gLUVCVVNZLA0KYW5kIGZpbGUg
Y3JlYXRpb24gd2lsbCBmYWlsLg0KDQpQZXJoYXBzIENocmlzdGlhbiBvciBBbCBjYW4gY2hpbWUg
aW4gaGVyZSBvbiB3aGV0aGVyDQpkaXJlY3RvcnkgZW50cnkgb2Zmc2V0IHZhbHVlIHJlLXVzZSBp
cyBpbmRlZWQgZXhwZWN0ZWQNCnRvIGJlIGFjY2VwdGFibGUuDQoNCkZ1cnRoZXIsIG15IHVuZGVy
c3RhbmRpbmcgaXMgdGhhdDoNCg0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvc3RhYmxlLzIwMjQx
MDI0MTMyMjI1LjIyNzE2NjctMTIteXVrdWFpMUBodWF3ZWljbG91ZC5jb20vDQoNCmZpeGVzIGEg
cmVuYW1lIGlzc3VlIHRoYXQgcmVzdWx0cyBpbiBhbiBpbmZpbml0ZSBsb29wLA0KYW5kIHRoYXQn
cyB0aGUgKG9ubHkpIGlzc3VlIHRoYXQgdW5kZXJsaWVzIENWRS0yMDI0LTQ2NzAxLg0KDQpZb3Ug
YXJlIHN1Z2dlc3RpbmcgdGhhdCB0aGVyZSBhcmUgb3RoZXIgb3ZlcmZsb3cgcHJvYmxlbXMNCndp
dGggdGhlIHhhcnJheS1iYXNlZCBzaW1wbGVfb2Zmc2V0IGltcGxlbWVudGF0aW9uLiBJZiBJDQpj
YW4gY29uZmlybSB0aGVtLCB0aGVuIEkgY2FuIGdldCB0aGVzZSBmaXhlZCBpbiB2Ni42LiBCdXQN
CnNvIGZhciwgSSdtIG5vdCBzdXJlIEkgY29tcGxldGVseSB1bmRlcnN0YW5kIHRoZXNlIG90aGVy
DQpmYWlsdXJlIG1vZGVzLg0KDQpBcmUgeW91IHN1Z2dlc3RpbmcgdGhhdCB0aGUgYWJvdmUgZml4
IC9pbnRyb2R1Y2VzLyB0aGUNCjAgb2Zmc2V0IHByb2JsZW0/DQoNCi0tDQpDaHVjayBMZXZlcg0K
DQoNCg==

