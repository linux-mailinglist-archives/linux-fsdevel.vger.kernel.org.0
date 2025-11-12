Return-Path: <linux-fsdevel+bounces-68111-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D92C54790
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 21:35:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BE7CB4E888F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 20:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E292C11F1;
	Wed, 12 Nov 2025 20:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="P9vdo4pC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B44266568
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Nov 2025 20:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762979324; cv=fail; b=sjEqZxsQpNh6dLjNOhvBRhNLoCBqIvh2+/CwhWWHTWhZlyUengueaLcsHr64o1Q9J8gHZKf+LPNB9SYnXOGOjy78U+s9mbIhXnzvHy1tKviY7KDRkh/Ep3NAhGL7d8Fqb+iey0Gwqcp1CBA7FubcH/++QDy4ybIqzgH6+QSJ5CI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762979324; c=relaxed/simple;
	bh=TsmpF44By3BjBVC//6qXe/9cbGCvKXdtKJk3vF0d1Y4=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=l0zYnaQzYSAUi+8PaP4RGU/ZzXCefFKp9fyhza0AWyNooU00+sub/dB0CiBxfb2NwGEZBWFGfJsS2KYrkrN9jPhcCNuoM7HyKEUwRK/ZsryEEQt1caqkutuP1VXGTfiai+PivWSqUN/EM57E4hMR5uZTfRKGuPsAVSpm6wLx9Wg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=P9vdo4pC; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ACHAHRZ029112
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Nov 2025 20:28:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=CdY9pygu8dk7ObsnDLqQlRt/JT1EnbKF5A5gnyDf2nU=; b=P9vdo4pC
	jTXssuEMWyrVTNJYItDHgeHJ8lQrqG3W/KmG1NyNWMTolmUiFJOgcjokgN1j1mJz
	JhmQCjJH7+J/EzmuJsGWFB2Witoa++Cs9hc9PCA+iOzOsjXaiwFvcFtdNhD4e4Qe
	omDDcAXMshdvquiMDsI/6a8L4l9ytnnInUi5S6FjWmz9GTe97Ir8NfSWLI367/pV
	Fv7klf5u0Yq2zMWp5bYFkw+zEAjy4XV4zGBd+uFfZ7BzUPjc4+tvhkOcswmxZPUF
	wWLd0L+i5uZZfO/LvVt2I+mUk+r9jNQTr4Nd1iiQL2XYoYwACT+5+EUuan05Uzpb
	OGlIJOTF0BWPQQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aa5cjbf32-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Nov 2025 20:28:42 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5ACKNkbs011533
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Nov 2025 20:28:41 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aa5cjbf30-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 20:28:41 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5ACKQhKU016479;
	Wed, 12 Nov 2025 20:28:40 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010067.outbound.protection.outlook.com [52.101.193.67])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aa5cjbf2x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 20:28:40 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Im9pstrHtiqS7UxUNfn9zoudbtmZKz574tFVkyrI/kuEE5d9SOPYsRALYQYa9prOv7Y0skjSifJSDOZcj7b0AzqG7us8G+B4XgUZUwXvB7J9bEE2vWjNZorlLAF4/gfebwpf2XFtxapbpOkCgRGASU3kF7LB9czrKbAnZW5L5Uix6iqzmeSSaEwLf/N0mgyWKuiMzT2i/RdOWtwLg9N2AOlh2Xw+zrwoGNzdW2VP5jYF0d/H5cJUYW7rPlEAhDMA+aHAtwqn1417IK/9kU4cznqdsXuAVmX8lQHCJPVaNmMxKtLhJ7X+pN1fhWoVilzBghPTHdNMAb9fQP0b1aMXAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pAjgAwDJ6zALYKJhHLvil8+bcH0345nUdhC/1uJZ8g0=;
 b=JtvschtYYp6d383Z0xDCfqsaohrrOPrz1Bl2bvSR/lNQ+mGWajsyKj5osJS8clyZO6OvTia8a7KmXPfRLAbqUVqGKL40mfuRGsQoaXE/uHXeqohm/89/K+z6aa+d7C/9BjhNLf/sODqmCEcDQPBHzM/B96eWBZsdA3Sj4TAlWOvboo9DDQwsh0pWoffOZkavmFSt0fRvfAaI+sURiVHgCBGqjTBK3VMG5aK88tB9+sryRHeGTvr/mRV9hScimjHRRzsA8uAIfKfgXhFEVc1kfp2KO3bBU1ypLj77Tv+TWp11sTXV4opBniHKOotULvoy/vj8YbAMWsixCYbTiGEUsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by MW4PR15MB4348.namprd15.prod.outlook.com (2603:10b6:303:bd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Wed, 12 Nov
 2025 20:28:37 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%4]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 20:28:37 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "idryomov@gmail.com" <idryomov@gmail.com>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>
CC: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Patrick
 Donnelly <pdonnell@redhat.com>,
        Alex Markuze <amarkuze@redhat.com>,
        Pavan
 Rallabhandi <Pavan.Rallabhandi@ibm.com>
Thread-Topic: [EXTERNAL] Re: [PATCH v2] ceph: fix crash in
 process_v2_sparse_read() for fscrypt-encrypted directories
Thread-Index: AQHcVBIeNkZ6vr0N5UupqnKBOod0srTvfbMA
Date: Wed, 12 Nov 2025 20:28:37 +0000
Message-ID: <fe20de6d968f0c6a2822e77c17545000683bd0f8.camel@ibm.com>
References: <20251112195246.495313-2-slava@dubeyko.com>
	 <CAOi1vP8swC=q1njp=EPYxkpAMv9cqmcysRNoPzRPpGwCzd3xrQ@mail.gmail.com>
In-Reply-To:
 <CAOi1vP8swC=q1njp=EPYxkpAMv9cqmcysRNoPzRPpGwCzd3xrQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|MW4PR15MB4348:EE_
x-ms-office365-filtering-correlation-id: 84aeb49a-bce6-42c7-7beb-08de222a0f26
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?Rnl0eUQ4a01aUHlkNk4ydktjMmk5OGJybTNNbjRFS0w0ZVRlZEZqY3NVZHhL?=
 =?utf-8?B?WXM0RVV5a0tiR3d1cDBoQUdoNU1mR25NOU4rOStIcmlPWEVpM0Nxbzdacyt2?=
 =?utf-8?B?eXJZWVJIUWlISFRvZGhNSzdaZVpiR0w0TlpwYWN5RDZmUDdKek1MZHc2U1I0?=
 =?utf-8?B?RkJhSVI4ZG91Smd5WTlSUzJZdmNXOVdlQ3RlWk5wNmxtOUt6VnV4Z2VLYWNB?=
 =?utf-8?B?dHFXM21uWjJEZlRya3M5L2Q0WHBaVGt6SDRBZmhISFRMS3ZIVnBxc0dxQi9W?=
 =?utf-8?B?OW56UVZCVlpHVVVEWC80ekMxSzZsUlEwRGZpVHd6cDZuUUFkK1pLQmhrZ1dm?=
 =?utf-8?B?U1prTTZxVW5VeXd3V0ozUVFTOWxlRzJFT0RSSFp6d0RDa21jRDdhckttRGpj?=
 =?utf-8?B?SFN2VGRudEtKczk5ZjdXcityMk5xaFptM1NsYVdyNWRrNW9maGFJMTRVeGVw?=
 =?utf-8?B?S3hZdktHU3d3NVBGVWtBUEw5d1NmczQwRm1DMWR1SERGTGlzWHgrL0h0Q2dO?=
 =?utf-8?B?Ri91L3dJdC8vcnduK3NOSlNucDhveGZmdjBPdHk1ZDdnS1NQcWhWT0RjQWRU?=
 =?utf-8?B?ZzZNMzF6Q0hxaXl0enhWaWlMaXMvMUYrcE9rQmU0YUYzMHRwcmdxWW9ycnph?=
 =?utf-8?B?OHNZM1dmNG5HUWtKOGNxa2QwQ3k5eW81ejFaa1RWNFhoNDRJR3lwekFxUEFz?=
 =?utf-8?B?ZW0veFBzWUxaeXlzamhwM2hoNzlVOUFHVW5Kb2lmSFd0V0hOcjRFWlNIcE0v?=
 =?utf-8?B?bHBBa1h1b3JOZ2laaXF3L1gvd1QxdFJMRlcwditoMVRZVm5odVhiQnE1ejBX?=
 =?utf-8?B?T3R0NEVtYTRUUFRJU2lKeDNwVEdBZ2w5aERCM1ZMQTdyeEtJRHRxcUFSa1hW?=
 =?utf-8?B?c1V5TWdQdVpLcldEaXhrWmlZcVE5VTRFQlEyRTQ5OW91UFk1ZnRSOWpucm5i?=
 =?utf-8?B?ZU9sQTU4OThRYzZGUVgrcE5oMW1MMzhzazlONzdPVTNJV1luNXVhMCtpczdt?=
 =?utf-8?B?MzVENEU1aHdXcll2WndGMmRoNW9adnZvYWlwbEd6d3RwblVYN0ZEWDBuUmZw?=
 =?utf-8?B?Q3NuazEzQkRKREJ5dkJMS1dCdHlDVzlBcURoNDh5S1RldndKSmxIS0I3bS9r?=
 =?utf-8?B?ODBGT2VzM0FzZFovZzVtSk9lZlJPaENJVG5XTmdGQXcxenM1REhhNDBONXlB?=
 =?utf-8?B?akVQajlmOGdwbzhabWNSb2ZwNEV3cGczVUpodmVHRUs4cytYdmV5R0lQcHBD?=
 =?utf-8?B?SVdPYzZSbm5Icnc1Vmc3M0dNck1KZDZNNndOUGpVTEZpWGx1YWxCTXJaam93?=
 =?utf-8?B?U25nc3A2YXhHUVZoRkVIbDM3azgyK0pxVXh6SVpTckZIODU2VkVLbExJajBo?=
 =?utf-8?B?SDRuRWE1VkUyY1JjSndpbGJWV2pOYkdKT3dleTUxYnFaQ2xyQ0tsay9ObTBL?=
 =?utf-8?B?K0ZaQ2hGdnZJWEwyR2pJS0hVRUdZWWZsRW5ERytVUjNxU1cxbjk0a1VFOW15?=
 =?utf-8?B?aU92Q0ZVTU5BWks2SVlxZXVidk5aOXNDL1R0clpVcDUyTTdWek1yc2tkQzhM?=
 =?utf-8?B?bkI2Y25peUZZWHpqcjBhSk44ZHBibmh3RE9tUjRmaHpNYXc4NllMbGN4c1U1?=
 =?utf-8?B?WTRmMTU1dHc0d0JlMnVEZDJ5SjBYNkJLdWpiZnFNT0tYdlBUd1gyWmN0ZWlX?=
 =?utf-8?B?cnVWS3AzVzNhYlRpMDNOYjBSUTYwMnVheHVEbkFyZktUcjZSbEZqVGdXUDh6?=
 =?utf-8?B?Qk5ycmtPMXl1azFYMjNoQ2tvaGpUeVRSU0h4WXdoMGZSWU50SktyTGtFeGIr?=
 =?utf-8?B?WnMwOGt6ZS9JSnBPK3ZLeHV4S0RHUFIybG9FdC9KajcwQ1F4ZXV5aDE3bUNE?=
 =?utf-8?B?SWtKdUh4YkFubDBKWEsxRCs0cXA1Q1NieXduOTFYemJ3dXdCdGlmeGVKYlZ5?=
 =?utf-8?B?dEpJYUgyNTRuSm53L3VVWUNaWWtEaWsvNU1BUzM5dE5uRDkwbE5MQi9PTFBa?=
 =?utf-8?B?cVVQMkNzaFhaZHJCSU1kbXhIQzFTSWE2SVRsNkZmdFc0dG9OM3ErNkR5ZS9T?=
 =?utf-8?Q?f1K3lJ?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Syt1bVVFelg3dFBodUlKNUdHUllTLzdrWmZuQnhCQnVWQU40MlJ0TEpXeFFX?=
 =?utf-8?B?SFJzd01hYjhtL3Qvc0xwQjdWWDZiU09tL09jNUEvOWJIbzlmQnVrMlhLSG5G?=
 =?utf-8?B?MTViZkRaVnZrMnh3QzYxcmtrZUR0a3p3NHVxTVpaeStGZmdWSncxclJ3dkor?=
 =?utf-8?B?d3IrM2g4anJGa2hFSU5sRjNPNEdDOTB4NFZEOGpaWFQvdDlqWnNTdHVRc1ND?=
 =?utf-8?B?WEhZQjZ4WXpyM25qTkc5aDFOaDBIcVdOZVZPcUsyZ3pYWW9KajZWSDlJclZN?=
 =?utf-8?B?NkllYkZodk95RUhTZlV0bjUyZ3VFWjN3anhoUXBOQWlJanAxSHhieW16THZ2?=
 =?utf-8?B?Q01sZFNNa2VaNXNvMENLRWJYck0yVjhCRVhYb1RTYVVubG1PWEtrNnNKUE5P?=
 =?utf-8?B?aW0yT3pKalRQT1B2aEtTNzdJZnRHSURFRWVjZGEwQkpKSDNESlRJSU5teVhl?=
 =?utf-8?B?NXd4cUdsTHhLNWpIU1hyeitXNER3cXdvY1dWd3IxNDB4TzBXMnFiN2M4TlEv?=
 =?utf-8?B?YTJqNHJqa3NaZ3hMV0Y4WmQ2ZEdPZHV3QVN0L296dms0cUFxaDNPbGFPK0Nl?=
 =?utf-8?B?VjRZUEMrTmIzbDRLcGh5QkNHUjlwb0pDWFc1d2tDc0hBRVljaFgrNVBHNGl5?=
 =?utf-8?B?dUFpYmdzTGJBUXlmVnVmWmR6bW5NRzE4c1RraGlEQnh0ZDdhaGk0bjNtSG1H?=
 =?utf-8?B?bzYrUnA5K2Z5eWpGQ3hIZVNoQlpiRVc0cXFUYUdCYzgzem5RRTNiMG5vdFNP?=
 =?utf-8?B?MGNEYlJVbUFNTnpGb1pZb3dlRE1pRVFvbFNXa2dtWTcrdlJkSGlHdVlpTmNV?=
 =?utf-8?B?NDZlR3kzZzNwMTU4bjBPbWJDOGR4VjkzY0xHaTMxNmNjV1BHQnMyWlFwRFBP?=
 =?utf-8?B?WEhKYzlrdkc1TkwyZitybi94RzIvSThZUlpick1OSXlUekQxODNYUjUraW4r?=
 =?utf-8?B?VytzQXYzaXl2YkdTanZOWTB0Rnd3Z2tJejlLdk5MMnlWZFhWZ0tXeDVWTkcw?=
 =?utf-8?B?RVdvUnFOUTlaelBaeGQydHU2NEZ2TnFPbW9zSGVGb3BFZm1kYzZLcjV1K1ZN?=
 =?utf-8?B?bVNYK0kwQ3NGRWxMblBYVmFWeW1JYk4yK1FKRytsL0ZFaU9xSlVySjVMRm1T?=
 =?utf-8?B?KzFrbFlRRER4NGVMR1l2bzhqTTU5aG55M2VtM2Q1TzBVZHN0cTRqNVdBOUlF?=
 =?utf-8?B?a3NEdkFKeGk2SU1YWURBSDczSlN5alo5c3czNXo0bExLd3FUdlNtOXRUVmRK?=
 =?utf-8?B?dUFkbjlueUlrcXJQYjFxMFFucEVTVTBENVBiRG10RkpIdmU5QmRON01UMWpQ?=
 =?utf-8?B?eG5wd1BPTXlSZFVkYlgzaEdBajUyVC9sSWdHK0VTV0ZmeFhPY0ZMb201Nm1i?=
 =?utf-8?B?MEdYcDhrakVTZktOTlBUa1pQZW5TUHpsYXhESWFwZFRjekluTUNNZUFxVTVY?=
 =?utf-8?B?Yk9zOTV2WVVFZnB1L0ZXbXF6MS9jQmhoZnVWSHBxVCt1cERwVkQ4bFMyRGlv?=
 =?utf-8?B?cFh1NWNhR0k4WkV6YU1UMHJxWCtSdWJSWEM3QzFpbUtoMkk4dXFGeFlvcUVP?=
 =?utf-8?B?SFJPaFdFSGZnK2F1YnZPSXF1aE05QjFRM3plNWsyZldpV1RudFoycEVubVNJ?=
 =?utf-8?B?b000eUYvYmxSSHZadjJLSnlyZWZkbStNZ1J6cU1pVFFzM1FDTVJvUGQ2R3hH?=
 =?utf-8?B?MWpsNWZYT2VDcFl4clpDWmxpU1ZDUFkzbXNhQWRBKzJDanpzL1BTSkRqQ3ZS?=
 =?utf-8?B?YkMzbVR3MXRFZDMwYTB0UkNidUV2bktOZW1ucEhhRDlQK3lBTlVWdDdNZHY3?=
 =?utf-8?B?b3creStSdTZoZjZoOWEwMVZkY0hlcm9wSFlNMWVaS2o4VERhMGVFUy9tY3ZB?=
 =?utf-8?B?MXNYcjBwUzRmdWhEZEFqbk9jenF0blFWQ2RDUDRzc0xRS1VsUjg5bmtuVFRE?=
 =?utf-8?B?MHozR0xlWndmT3lqaDlhSlUzYWU4STByK2ZpRXZrL1oyb2RyS2NOeTgzVHND?=
 =?utf-8?B?azFUeUt0Z2QvQ3ZvbzRwWW9VNHBJZTVCWUlGUnUwVlJZNnFZb2VSNnRrKy9Q?=
 =?utf-8?B?NkFiWVlRa3hKdUY3SWdDOU9aRkdJQ1BzVUdrd1hWL1NyWmw3Mm1oVEhDNzJU?=
 =?utf-8?B?UTdPb2M4MnVWbGJGSmFUbGJ5dW1NZUhMTFdXZVA3SE15alJpTFFmb3JlWGVi?=
 =?utf-8?Q?GsxfJFGTgmB74a+Jh7H4/Kg=3D?=
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84aeb49a-bce6-42c7-7beb-08de222a0f26
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2025 20:28:37.0508
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RXc+hwzC4EkB/SIjK4i6VTIZzBu2w8+4J4hyFKuE2qm4tcLPw2zhZTbdU3URc2wbxgO/yy9goOcG/x/jkqMtsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR15MB4348
X-Proofpoint-ORIG-GUID: 5Yuk5K9LJPBZL_u3uI91z87d5ZeDHnFw
X-Authority-Analysis: v=2.4 cv=Ss+dKfO0 c=1 sm=1 tr=0 ts=6914edf9 cx=c_pps
 a=4Gx/Bq66bxzCWlClXrtOjA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=4u6H09k7AAAA:8 a=wCmvBT1CAAAA:8
 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
 a=Ui-BV7ERzK9wl0K3p90A:9 a=QEXdDO2ut3YA:10 a=5yerskEF2kbSkDMynNst:22
 a=6z96SAwNL0f8klobD5od:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: zKpJKMb2G7uMeM6BxzQVaiNV4N4yE_Ks
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDA5NSBTYWx0ZWRfX76YZnnXbiJXV
 hBzJhNS7vjHBJ7CXaum9RJirjpG5LM25b0LmznDmra9gzpwo+WlaVUD4yochVNVFp/P5tIbTWKY
 2zyjiAp38b+AjeVAgPQDUR0pPp1MW+Cdo1rizwQ9Oi3JfQ/G6qHfw2pVefvGmRtrPXT8q4MQDeQ
 3Bc9137Gx4Fx1ogYXAc66YzF5tnMaI8XlOUtf5Q/eoi1h1fOqkg66Pvf39VqHNthExllAdMFoQG
 rGAE6xw7x4jKKf6n8PG7xVL7UqAywGuMKiRhTKQgnVp0I/HBBf3Rjhn7DcDGG0MpJnoWpcoIOmR
 GXwLijSXp9WTFqXcyl0TxjCNkK3PkJMLxkhXz0pBw7sf6mfTiEeAv7foHz/mUM+vQvpiv175Em2
 4FqgbRH7C01q5BAAr5/oDs52f1MdAw==
Content-Type: text/plain; charset="utf-8"
Content-ID: <856B088AC6E36144B9B58E58E3A3E92B@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: RE: [PATCH v2] ceph: fix crash in process_v2_sparse_read() for
 fscrypt-encrypted directories
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_06,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 bulkscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=2 engine=8.19.0-2510240000 definitions=main-2511080095

On Wed, 2025-11-12 at 21:22 +0100, Ilya Dryomov wrote:
> On Wed, Nov 12, 2025 at 8:53=E2=80=AFPM Viacheslav Dubeyko <slava@dubeyko=
.com> wrote:
> >=20
> > From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> >=20
> > The crash in process_v2_sparse_read() for fscrypt-encrypted
> > directories has been reported [1]. Issue takes place for
> > Ceph msgr2 protocol. It can be reproduced by the steps:
> >=20
> > sudo mount -t ceph :/ /mnt/cephfs/ -o name=3Dadmin,fs=3Dcephfs,ms_mode=
=3Dsecure
> >=20
> > (1) mkdir /mnt/cephfs/fscrypt-test-3
> > (2) cp area_decrypted.tar /mnt/cephfs/fscrypt-test-3
> > (3) fscrypt encrypt --source=3Draw_key --key=3D./my.key /mnt/cephfs/fsc=
rypt-test-3
> > (4) fscrypt lock /mnt/cephfs/fscrypt-test-3
> > (5) fscrypt unlock --key=3Dmy.key /mnt/cephfs/fscrypt-test-3
> > (6) cat /mnt/cephfs/fscrypt-test-3/area_decrypted.tar
> > (7) Issue has been triggered
> >=20
> > [  408.072247] ------------[ cut here ]------------
> > [  408.072251] WARNING: CPU: 1 PID: 392 at net/ceph/messenger_v2.c:865
> > ceph_con_v2_try_read+0x4b39/0x72f0
> > [  408.072267] Modules linked in: intel_rapl_msr intel_rapl_common
> > intel_uncore_frequency_common intel_pmc_core pmt_telemetry pmt_discovery
> > pmt_class intel_pmc_ssram_telemetry intel_vsec kvm_intel joydev kvm irq=
bypass
> > polyval_clmulni ghash_clmulni_intel aesni_intel rapl input_leds psmouse
> > serio_raw i2c_piix4 vga16fb bochs vgastate i2c_smbus floppy mac_hid qem=
u_fw_cfg
> > pata_acpi sch_fq_codel rbd msr parport_pc ppdev lp parport efi_pstore
> > [  408.072304] CPU: 1 UID: 0 PID: 392 Comm: kworker/1:3 Not tainted 6.1=
7.0-rc7+
> > [  408.072307] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), B=
IOS
> > 1.17.0-5.fc42 04/01/2014
> > [  408.072310] Workqueue: ceph-msgr ceph_con_workfn
> > [  408.072314] RIP: 0010:ceph_con_v2_try_read+0x4b39/0x72f0
> > [  408.072317] Code: c7 c1 20 f0 d4 ae 50 31 d2 48 c7 c6 60 27 d5 ae 48=
 c7 c7 f8
> > 8e 6f b0 68 60 38 d5 ae e8 00 47 61 fe 48 83 c4 18 e9 ac fc ff ff <0f> =
0b e9 06
> > fe ff ff 4c 8b 9d 98 fd ff ff 0f 84 64 e7 ff ff 89 85
> > [  408.072319] RSP: 0018:ffff88811c3e7a30 EFLAGS: 00010246
> > [  408.072322] RAX: ffffed1024874c6f RBX: ffffea00042c2b40 RCX: 0000000=
000000f38
> > [  408.072324] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000=
000000000
> > [  408.072325] RBP: ffff88811c3e7ca8 R08: 0000000000000000 R09: 0000000=
0000000c8
> > [  408.072326] R10: 00000000000000c8 R11: 0000000000000000 R12: 0000000=
0000000c8
> > [  408.072327] R13: dffffc0000000000 R14: ffff8881243a6030 R15: 0000000=
000003000
> > [  408.072329] FS:  0000000000000000(0000) GS:ffff88823eadf000(0000)
> > knlGS:0000000000000000
> > [  408.072331] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [  408.072332] CR2: 000000c0003c6000 CR3: 000000010c106005 CR4: 0000000=
000772ef0
> > [  408.072336] PKRU: 55555554
> > [  408.072337] Call Trace:
> > [  408.072338]  <TASK>
> > [  408.072340]  ? sched_clock_noinstr+0x9/0x10
> > [  408.072344]  ? __pfx_ceph_con_v2_try_read+0x10/0x10
> > [  408.072347]  ? _raw_spin_unlock+0xe/0x40
> > [  408.072349]  ? finish_task_switch.isra.0+0x15d/0x830
> > [  408.072353]  ? __kasan_check_write+0x14/0x30
> > [  408.072357]  ? mutex_lock+0x84/0xe0
> > [  408.072359]  ? __pfx_mutex_lock+0x10/0x10
> > [  408.072361]  ceph_con_workfn+0x27e/0x10e0
> > [  408.072364]  ? metric_delayed_work+0x311/0x2c50
> > [  408.072367]  process_one_work+0x611/0xe20
> > [  408.072371]  ? __kasan_check_write+0x14/0x30
> > [  408.072373]  worker_thread+0x7e3/0x1580
> > [  408.072375]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
> > [  408.072378]  ? __pfx_worker_thread+0x10/0x10
> > [  408.072381]  kthread+0x381/0x7a0
> > [  408.072383]  ? __pfx__raw_spin_lock_irq+0x10/0x10
> > [  408.072385]  ? __pfx_kthread+0x10/0x10
> > [  408.072387]  ? __kasan_check_write+0x14/0x30
> > [  408.072389]  ? recalc_sigpending+0x160/0x220
> > [  408.072392]  ? _raw_spin_unlock_irq+0xe/0x50
> > [  408.072394]  ? calculate_sigpending+0x78/0xb0
> > [  408.072395]  ? __pfx_kthread+0x10/0x10
> > [  408.072397]  ret_from_fork+0x2b6/0x380
> > [  408.072400]  ? __pfx_kthread+0x10/0x10
> > [  408.072402]  ret_from_fork_asm+0x1a/0x30
> > [  408.072406]  </TASK>
> > [  408.072407] ---[ end trace 0000000000000000 ]---
> > [  408.072418] Oops: general protection fault, probably for non-canonic=
al
> > address 0xdffffc0000000000: 0000 [#1] SMP KASAN NOPTI
> > [  408.072984] KASAN: null-ptr-deref in range [0x0000000000000000-
> > 0x0000000000000007]
> > [  408.073350] CPU: 1 UID: 0 PID: 392 Comm: kworker/1:3 Tainted: G     =
   W
> > 6.17.0-rc7+ #1 PREEMPT(voluntary)
> > [  408.073886] Tainted: [W]=3DWARN
> > [  408.074042] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), B=
IOS
> > 1.17.0-5.fc42 04/01/2014
> > [  408.074468] Workqueue: ceph-msgr ceph_con_workfn
> > [  408.074694] RIP: 0010:ceph_msg_data_advance+0x79/0x1a80
> > [  408.074976] Code: fc ff df 49 8d 77 08 48 c1 ee 03 80 3c 16 00 0f 85=
 07 11 00
> > 00 48 ba 00 00 00 00 00 fc ff df 49 8b 5f 08 48 89 de 48 c1 ee 03 <0f> =
b6 14 16
> > 84 d2 74 09 80 fa 03 0f 8e 0f 0e 00 00 8b 13 83 fa 03
> > [  408.075884] RSP: 0018:ffff88811c3e7990 EFLAGS: 00010246
> > [  408.076305] RAX: ffff8881243a6388 RBX: 0000000000000000 RCX: 0000000=
000000000
> > [  408.076909] RDX: dffffc0000000000 RSI: 0000000000000000 RDI: ffff888=
1243a6378
> > [  408.077466] RBP: ffff88811c3e7a20 R08: 0000000000000000 R09: 0000000=
0000000c8
> > [  408.078034] R10: ffff8881243a6388 R11: 0000000000000000 R12: ffffed1=
024874c71
> > [  408.078575] R13: dffffc0000000000 R14: ffff8881243a6030 R15: ffff888=
1243a6378
> > [  408.079159] FS:  0000000000000000(0000) GS:ffff88823eadf000(0000)
> > knlGS:0000000000000000
> > [  408.079736] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [  408.080039] CR2: 000000c0003c6000 CR3: 000000010c106005 CR4: 0000000=
000772ef0
> > [  408.080376] PKRU: 55555554
> > [  408.080513] Call Trace:
> > [  408.080630]  <TASK>
> > [  408.080729]  ceph_con_v2_try_read+0x49b9/0x72f0
> > [  408.081115]  ? __pfx_ceph_con_v2_try_read+0x10/0x10
> > [  408.081348]  ? _raw_spin_unlock+0xe/0x40
> > [  408.081538]  ? finish_task_switch.isra.0+0x15d/0x830
> > [  408.081768]  ? __kasan_check_write+0x14/0x30
> > [  408.081986]  ? mutex_lock+0x84/0xe0
> > [  408.082160]  ? __pfx_mutex_lock+0x10/0x10
> > [  408.082343]  ceph_con_workfn+0x27e/0x10e0
> > [  408.082529]  ? metric_delayed_work+0x311/0x2c50
> > [  408.082737]  process_one_work+0x611/0xe20
> > [  408.082948]  ? __kasan_check_write+0x14/0x30
> > [  408.083156]  worker_thread+0x7e3/0x1580
> > [  408.083331]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
> > [  408.083557]  ? __pfx_worker_thread+0x10/0x10
> > [  408.083751]  kthread+0x381/0x7a0
> > [  408.083922]  ? __pfx__raw_spin_lock_irq+0x10/0x10
> > [  408.084139]  ? __pfx_kthread+0x10/0x10
> > [  408.084310]  ? __kasan_check_write+0x14/0x30
> > [  408.084510]  ? recalc_sigpending+0x160/0x220
> > [  408.084708]  ? _raw_spin_unlock_irq+0xe/0x50
> > [  408.084917]  ? calculate_sigpending+0x78/0xb0
> > [  408.085138]  ? __pfx_kthread+0x10/0x10
> > [  408.085335]  ret_from_fork+0x2b6/0x380
> > [  408.085525]  ? __pfx_kthread+0x10/0x10
> > [  408.085720]  ret_from_fork_asm+0x1a/0x30
> > [  408.085922]  </TASK>
> > [  408.086036] Modules linked in: intel_rapl_msr intel_rapl_common
> > intel_uncore_frequency_common intel_pmc_core pmt_telemetry pmt_discovery
> > pmt_class intel_pmc_ssram_telemetry intel_vsec kvm_intel joydev kvm irq=
bypass
> > polyval_clmulni ghash_clmulni_intel aesni_intel rapl input_leds psmouse
> > serio_raw i2c_piix4 vga16fb bochs vgastate i2c_smbus floppy mac_hid qem=
u_fw_cfg
> > pata_acpi sch_fq_codel rbd msr parport_pc ppdev lp parport efi_pstore
> > [  408.087778] ---[ end trace 0000000000000000 ]---
> > [  408.088007] RIP: 0010:ceph_msg_data_advance+0x79/0x1a80
> > [  408.088260] Code: fc ff df 49 8d 77 08 48 c1 ee 03 80 3c 16 00 0f 85=
 07 11 00
> > 00 48 ba 00 00 00 00 00 fc ff df 49 8b 5f 08 48 89 de 48 c1 ee 03 <0f> =
b6 14 16
> > 84 d2 74 09 80 fa 03 0f 8e 0f 0e 00 00 8b 13 83 fa 03
> > [  408.089118] RSP: 0018:ffff88811c3e7990 EFLAGS: 00010246
> > [  408.089357] RAX: ffff8881243a6388 RBX: 0000000000000000 RCX: 0000000=
000000000
> > [  408.089678] RDX: dffffc0000000000 RSI: 0000000000000000 RDI: ffff888=
1243a6378
> > [  408.090020] RBP: ffff88811c3e7a20 R08: 0000000000000000 R09: 0000000=
0000000c8
> > [  408.090360] R10: ffff8881243a6388 R11: 0000000000000000 R12: ffffed1=
024874c71
> > [  408.090687] R13: dffffc0000000000 R14: ffff8881243a6030 R15: ffff888=
1243a6378
> > [  408.091035] FS:  0000000000000000(0000) GS:ffff88823eadf000(0000)
> > knlGS:0000000000000000
> > [  408.091452] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [  408.092015] CR2: 000000c0003c6000 CR3: 000000010c106005 CR4: 0000000=
000772ef0
> > [  408.092530] PKRU: 55555554
> > [  417.112915]
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [  417.113491] BUG: KASAN: slab-use-after-free in
> > __mutex_lock.constprop.0+0x1522/0x1610
> > [  417.114014] Read of size 4 at addr ffff888124870034 by task kworker/=
2:0/4951
> >=20
> > [  417.114587] CPU: 2 UID: 0 PID: 4951 Comm: kworker/2:0 Tainted: G    =
  D W
> > 6.17.0-rc7+ #1 PREEMPT(voluntary)
> > [  417.114592] Tainted: [D]=3DDIE, [W]=3DWARN
> > [  417.114593] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), B=
IOS
> > 1.17.0-5.fc42 04/01/2014
> > [  417.114596] Workqueue: events handle_timeout
> > [  417.114601] Call Trace:
> > [  417.114602]  <TASK>
> > [  417.114604]  dump_stack_lvl+0x5c/0x90
> > [  417.114610]  print_report+0x171/0x4dc
> > [  417.114613]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
> > [  417.114617]  ? kasan_complete_mode_report_info+0x80/0x220
> > [  417.114621]  kasan_report+0xbd/0x100
> > [  417.114625]  ? __mutex_lock.constprop.0+0x1522/0x1610
> > [  417.114628]  ? __mutex_lock.constprop.0+0x1522/0x1610
> > [  417.114630]  __asan_report_load4_noabort+0x14/0x30
> > [  417.114633]  __mutex_lock.constprop.0+0x1522/0x1610
> > [  417.114635]  ? queue_con_delay+0x8d/0x200
> > [  417.114638]  ? __pfx___mutex_lock.constprop.0+0x10/0x10
> > [  417.114641]  ? __send_subscribe+0x529/0xb20
> > [  417.114644]  __mutex_lock_slowpath+0x13/0x20
> > [  417.114646]  mutex_lock+0xd4/0xe0
> > [  417.114649]  ? __pfx_mutex_lock+0x10/0x10
> > [  417.114652]  ? ceph_monc_renew_subs+0x2a/0x40
> > [  417.114654]  ceph_con_keepalive+0x22/0x110
> > [  417.114656]  handle_timeout+0x6b3/0x11d0
> > [  417.114659]  ? _raw_spin_unlock_irq+0xe/0x50
> > [  417.114662]  ? __pfx_handle_timeout+0x10/0x10
> > [  417.114664]  ? queue_delayed_work_on+0x8e/0xa0
> > [  417.114669]  process_one_work+0x611/0xe20
> > [  417.114672]  ? __kasan_check_write+0x14/0x30
> > [  417.114676]  worker_thread+0x7e3/0x1580
> > [  417.114678]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
> > [  417.114682]  ? __pfx_sched_setscheduler_nocheck+0x10/0x10
> > [  417.114687]  ? __pfx_worker_thread+0x10/0x10
> > [  417.114689]  kthread+0x381/0x7a0
> > [  417.114692]  ? __pfx__raw_spin_lock_irq+0x10/0x10
> > [  417.114694]  ? __pfx_kthread+0x10/0x10
> > [  417.114697]  ? __kasan_check_write+0x14/0x30
> > [  417.114699]  ? recalc_sigpending+0x160/0x220
> > [  417.114703]  ? _raw_spin_unlock_irq+0xe/0x50
> > [  417.114705]  ? calculate_sigpending+0x78/0xb0
> > [  417.114707]  ? __pfx_kthread+0x10/0x10
> > [  417.114710]  ret_from_fork+0x2b6/0x380
> > [  417.114713]  ? __pfx_kthread+0x10/0x10
> > [  417.114715]  ret_from_fork_asm+0x1a/0x30
> > [  417.114720]  </TASK>
> >=20
> > [  417.125171] Allocated by task 2:
> > [  417.125333]  kasan_save_stack+0x26/0x60
> > [  417.125522]  kasan_save_track+0x14/0x40
> > [  417.125742]  kasan_save_alloc_info+0x39/0x60
> > [  417.125945]  __kasan_slab_alloc+0x8b/0xb0
> > [  417.126133]  kmem_cache_alloc_node_noprof+0x13b/0x460
> > [  417.126381]  copy_process+0x320/0x6250
> > [  417.126595]  kernel_clone+0xb7/0x840
> > [  417.126792]  kernel_thread+0xd6/0x120
> > [  417.126995]  kthreadd+0x85c/0xbe0
> > [  417.127176]  ret_from_fork+0x2b6/0x380
> > [  417.127378]  ret_from_fork_asm+0x1a/0x30
> >=20
> > [  417.127692] Freed by task 0:
> > [  417.127851]  kasan_save_stack+0x26/0x60
> > [  417.128057]  kasan_save_track+0x14/0x40
> > [  417.128267]  kasan_save_free_info+0x3b/0x60
> > [  417.128491]  __kasan_slab_free+0x6c/0xa0
> > [  417.128708]  kmem_cache_free+0x182/0x550
> > [  417.128906]  free_task+0xeb/0x140
> > [  417.129070]  __put_task_struct+0x1d2/0x4f0
> > [  417.129259]  __put_task_struct_rcu_cb+0x15/0x20
> > [  417.129480]  rcu_do_batch+0x3d3/0xe70
> > [  417.129681]  rcu_core+0x549/0xb30
> > [  417.129839]  rcu_core_si+0xe/0x20
> > [  417.130005]  handle_softirqs+0x160/0x570
> > [  417.130190]  __irq_exit_rcu+0x189/0x1e0
> > [  417.130369]  irq_exit_rcu+0xe/0x20
> > [  417.130531]  sysvec_apic_timer_interrupt+0x9f/0xd0
> > [  417.130768]  asm_sysvec_apic_timer_interrupt+0x1b/0x20
> >=20
> > [  417.131082] Last potentially related work creation:
> > [  417.131305]  kasan_save_stack+0x26/0x60
> > [  417.131484]  kasan_record_aux_stack+0xae/0xd0
> > [  417.131695]  __call_rcu_common+0xcd/0x14b0
> > [  417.131909]  call_rcu+0x31/0x50
> > [  417.132071]  delayed_put_task_struct+0x128/0x190
> > [  417.132295]  rcu_do_batch+0x3d3/0xe70
> > [  417.132478]  rcu_core+0x549/0xb30
> > [  417.132658]  rcu_core_si+0xe/0x20
> > [  417.132808]  handle_softirqs+0x160/0x570
> > [  417.132993]  __irq_exit_rcu+0x189/0x1e0
> > [  417.133181]  irq_exit_rcu+0xe/0x20
> > [  417.133353]  sysvec_apic_timer_interrupt+0x9f/0xd0
> > [  417.133584]  asm_sysvec_apic_timer_interrupt+0x1b/0x20
> >=20
> > [  417.133921] Second to last potentially related work creation:
> > [  417.134183]  kasan_save_stack+0x26/0x60
> > [  417.134362]  kasan_record_aux_stack+0xae/0xd0
> > [  417.134566]  __call_rcu_common+0xcd/0x14b0
> > [  417.134782]  call_rcu+0x31/0x50
> > [  417.134929]  put_task_struct_rcu_user+0x58/0xb0
> > [  417.135143]  finish_task_switch.isra.0+0x5d3/0x830
> > [  417.135366]  __schedule+0xd30/0x5100
> > [  417.135534]  schedule_idle+0x5a/0x90
> > [  417.135712]  do_idle+0x25f/0x410
> > [  417.135871]  cpu_startup_entry+0x53/0x70
> > [  417.136053]  start_secondary+0x216/0x2c0
> > [  417.136233]  common_startup_64+0x13e/0x141
> >=20
> > [  417.136894] The buggy address belongs to the object at ffff888124870=
000
> >                 which belongs to the cache task_struct of size 10504
> > [  417.138122] The buggy address is located 52 bytes inside of
> >                 freed 10504-byte region [ffff888124870000, ffff88812487=
2908)
> >=20
> > [  417.139465] The buggy address belongs to the physical page:
> > [  417.140016] page: refcount:0 mapcount:0 mapping:0000000000000000 ind=
ex:0x0
> > pfn:0x124870
> > [  417.140789] head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapp=
ed:0
> > pincount:0
> > [  417.141519] memcg:ffff88811aa20e01
> > [  417.141874] anon flags:
> > 0x17ffffc0000040(head|node=3D0|zone=3D2|lastcpupid=3D0x1fffff)
> > [  417.142600] page_type: f5(slab)
> > [  417.142922] raw: 0017ffffc0000040 ffff88810094f040 0000000000000000
> > dead000000000001
> > [  417.143554] raw: 0000000000000000 0000000000030003 00000000f5000000
> > ffff88811aa20e01
> > [  417.143954] head: 0017ffffc0000040 ffff88810094f040 0000000000000000
> > dead000000000001
> > [  417.144329] head: 0000000000000000 0000000000030003 00000000f5000000
> > ffff88811aa20e01
> > [  417.144710] head: 0017ffffc0000003 ffffea0004921c01 00000000ffffffff
> > 00000000ffffffff
> > [  417.145106] head: ffffffffffffffff 0000000000000000 00000000ffffffff
> > 0000000000000008
> > [  417.145485] page dumped because: kasan: bad access detected
> >=20
> > [  417.145859] Memory state around the buggy address:
> > [  417.146094]  ffff88812486ff00: fc fc fc fc fc fc fc fc fc fc fc fc f=
c fc fc
> > fc
> > [  417.146439]  ffff88812486ff80: fc fc fc fc fc fc fc fc fc fc fc fc f=
c fc fc
> > fc
> > [  417.146791] >ffff888124870000: fa fb fb fb fb fb fb fb fb fb fb fb f=
b fb fb
> > fb
> > [  417.147145]                                      ^
> > [  417.147387]  ffff888124870080: fb fb fb fb fb fb fb fb fb fb fb fb f=
b fb fb
> > fb
> > [  417.147751]  ffff888124870100: fb fb fb fb fb fb fb fb fb fb fb fb f=
b fb fb
> > fb
> > [  417.148123]
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >=20
> > First of all, we have warning in get_bvec_at() because
> > cursor->total_resid contains zero value. And, finally,
> > we have crash in ceph_msg_data_advance() because
> > cursor->data is NULL. It means that get_bvec_at()
> > receives not initialized ceph_msg_data_cursor structure
> > because data is NULL and total_resid contains zero.
> >=20
> > Moreover, we don't have likewise issue for the case of
> > Ceph msgr1 protocol because ceph_msg_data_cursor_init()
> > has been called before reading sparse data.
> >=20
> > This patch adds calling of ceph_msg_data_cursor_init()
> > in the beginning of process_v2_sparse_read() with
> > the goal to guarantee that logic of reading sparse data
> > works correctly for the case of Ceph msgr2 protocol.
> >=20
> > v2
> > Ilya Dryomov suggested to remove BUG_ON() calls from
> > ceph_msg_data_advance(), to rework cursor initialization
>=20
> Hi Slava,
>=20
> My suggestion was to drop the new BUG_ON that wasn't bringing any
> substantial value.  The existing BUG_ON is useful because it catches
> much less obvious things like off by one errors and similar attempts to
> advance too far early on.

My question was:

>
> So, should I remove both BUG_ON()?

Your answer were:

>> Yes, that would be my preference.

So, I did what you've asked me finally. No?

>=20
> > logic, and to make additional minor cleanup.
> >=20
> > [1] https://tracker.ceph.com/issues/73152 =20
> >=20
> > Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> > cc: Alex Markuze <amarkuze@redhat.com>
> > cc: Ilya Dryomov <idryomov@gmail.com>
> > cc: Ceph Development <ceph-devel@vger.kernel.org>
> > ---
> >  net/ceph/messenger.c    |  1 -
> >  net/ceph/messenger_v2.c | 11 +++++++----
> >  2 files changed, 7 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
> > index f8181acaf870..84c652f4efd8 100644
> > --- a/net/ceph/messenger.c
> > +++ b/net/ceph/messenger.c
> > @@ -1128,7 +1128,6 @@ void ceph_msg_data_advance(struct ceph_msg_data_c=
ursor *cursor, size_t bytes)
> >  {
> >         bool new_piece;
> >=20
> > -       BUG_ON(bytes > cursor->resid);
>=20
> Let's keep this.
>=20
> >         switch (cursor->data->type) {
> >         case CEPH_MSG_DATA_PAGELIST:
> >                 new_piece =3D ceph_msg_data_pagelist_advance(cursor, by=
tes);
> > diff --git a/net/ceph/messenger_v2.c b/net/ceph/messenger_v2.c
> > index 9e39378eda00..e0e4f094e5a6 100644
> > --- a/net/ceph/messenger_v2.c
> > +++ b/net/ceph/messenger_v2.c
> > @@ -1061,13 +1061,16 @@ static int decrypt_control_remainder(struct cep=
h_connection *con)
> >  static int process_v2_sparse_read(struct ceph_connection *con,
> >                                   struct page **pages, int spos)
> >  {
> > -       struct ceph_msg_data_cursor *cursor =3D &con->v2.in_cursor;
> > +       struct ceph_msg_data_cursor cursor;
> >         int ret;
> >=20
> > +       ceph_msg_data_cursor_init(&cursor, con->in_msg,
> > +                                 con->in_msg->data_length);
>=20
> I'd use sparse_read_total instead of data_length here for consistency
> with other sparse read code paths.

What is the difference between data_length and sparse_read_total?

Thanks,
Slava.

