Return-Path: <linux-fsdevel+bounces-21122-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA5968FF385
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2024 19:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 745BB1F23192
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2024 17:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EECC1990DC;
	Thu,  6 Jun 2024 17:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EwsWS1Zg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jwu0yWPW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DB6197A8F;
	Thu,  6 Jun 2024 17:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717694170; cv=fail; b=tD5vBVcCSwhWuSgiWWxkdt010dDpM4VixciTyjI1mNga+mg/zciwzywGauGwjE30Nr0Lwwiu7aSbmdryXphdmaEzBaJNyk4M1cNrbS9TPSwSaRfdsb2Ne+05isINvMDbI3kUTtdgEyNWy5C4Vx/4h4GhrUaVrfMCy8g4RsJ1XZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717694170; c=relaxed/simple;
	bh=p+Tj4sdCZD3ztS/1Ic21wsDG9rlW/hml8vn+iMdqW+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DH9UoytX4Qd4HJJgf6hQglkGciec1NYHmh3SIzyxTH3P0JAj/DfT3JIM0Qe7IgeHfVWvXGBGz4m1tVE9VvwZgZgYro4wdoaRsLgzLNv/LbYeMmgmd1MT3ccex5NQegyk4hVQgH+MmJx1L0lSrZl29jx5AQRTvmLj1ZS158zcoPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EwsWS1Zg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jwu0yWPW; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4568ilui021994;
	Thu, 6 Jun 2024 17:15:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=corp-2023-11-20;
 bh=VEBVmKnHpWTTS7KU7mIicewI72j8qnZxJXALkV8pJ6E=;
 b=EwsWS1Zg1ogt+asSXL6E+23ZmG9QN/1RFmB34JAVkUWosRv6QT0X9I6mP2dYa7MIMJyx
 TnjWGkwYKDSKGUzQRBH5a42qd1bSijD3JWUHRCpjGS+HXY/wiKYC7AZVDDiJObqO0nNU
 HCkJ3QGn18lh3nrmSce+MpNNis3InoJkGTkTK3Gz0x5fYpF2x4JHitOC/lm9wsKyWlit
 Gm08CN6c8R6t88zNx/8MqNLA3zTsVxdidim8qDqlfnaesL6gGDei7IqYO/pZhsqje7ro
 CbnK+ZE8YoTtOdUPhQmJuSgIcj90NV1BoBnNNCvVJpfTJcTkNXW7s3bl8tX350kFJKpL rQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yjbqn412p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Jun 2024 17:15:50 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 456GYkMl025263;
	Thu, 6 Jun 2024 17:15:49 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrtbwk4m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Jun 2024 17:15:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HrFsOjZtIeQnsN9H4tZgJNwAJ5oO/ALIHvLBJA2sHlckQpuOpVqUj2vSW4mtK17KhuPxVo+PY5KQ/l7vr6P+IJIee/HlbKmslLqoY7/bd+YpAUZOS14QPp08NqZ5qtiF/IY78EKEQ5F7AlYgS4CcKzB+3EjgL5dAMiLS6EULdg1iZUBGJcnwG6YeQtcZDXvxrigcdd9LDHD39wSMRxKBVGnYGHcp3skV5csbQo5HIX+yn8A5htWbFu/FRpxZ2LVHPvOXmI+vIcOx9hXqfsxWgyjJE1yoqwBLbf91qGuutdI7L91KCyf6SuIigEem6ZX8MI17eSQGIa0YfkCJAwDMFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VEBVmKnHpWTTS7KU7mIicewI72j8qnZxJXALkV8pJ6E=;
 b=SgGJrRE6GRWcmaRnE7lO1qwaV7jtleCAc77TtXuALI/jsK4QLqMRWiaI3rg5aee5LeCrY4L5BBv5xApu0r/G8BdOfrpQ6awmOfY+SKN1G30Mgbkte4fMPsGHjm213uxx3GndCTPJKoe/REriS2xSmTnqFaiuKq+DRhrJ3slvRuDmgYwiTgllU/nDzxDnHeF8RgreB2Ejmr4xATGcjW8+S2pIQkvTikiBPG4kHW7BzeFVSFqpZ4BHfSmImnyBfy6ooLGnMgdEV4SSoH72guRyh1xwCem7fOrq+JN5RIxExqEBxKjWWoIpxU2eqp6GApZIWBPg1pwv8AxQFjH7+Qe6nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VEBVmKnHpWTTS7KU7mIicewI72j8qnZxJXALkV8pJ6E=;
 b=jwu0yWPWV7XcIYnnnBEIjsH66pJBACnQzxDNZRd3V1NPxb8+/pzvP+0JevcFD0xHxb/8O8vXs1Z3OyImiDf1j5FZ8Lc1KLerdUlw3EKswbKNGccN43YnmxDC1I/x5nNRxFhNRGZ9AbXjPus790cKgA3Wzqd1mV/FIIIVHhLwJ8c=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by DM6PR10MB4236.namprd10.prod.outlook.com (2603:10b6:5:212::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Thu, 6 Jun
 2024 17:15:46 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.7633.033; Thu, 6 Jun 2024
 17:15:46 +0000
Date: Thu, 6 Jun 2024 13:15:43 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Suren Baghdasaryan <surenb@google.com>,
        Andrii Nakryiko <andrii@kernel.org>, linux-fsdevel@vger.kernel.org,
        brauner@kernel.org, viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        gregkh@linuxfoundation.org, linux-mm@kvack.org, rppt@kernel.org
Subject: Re: [PATCH v3 4/9] fs/procfs: use per-VMA RCU-protected locking in
 PROCMAP_QUERY API
Message-ID: <ue44yftirugr6u4ewl5cvgatpqnheuho7rgax3jyg6ox5vruyq@7k6harvobd2q>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, Suren Baghdasaryan <surenb@google.com>, 
	Andrii Nakryiko <andrii@kernel.org>, linux-fsdevel@vger.kernel.org, brauner@kernel.org, 
	viro@zeniv.linux.org.uk, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, gregkh@linuxfoundation.org, linux-mm@kvack.org, rppt@kernel.org
References: <20240605002459.4091285-1-andrii@kernel.org>
 <20240605002459.4091285-5-andrii@kernel.org>
 <CAJuCfpFp38X-tbiRAqS36zXG_ho2wyoRas0hCFLo07pN1noSmg@mail.gmail.com>
 <CAEf4BzYv0Ys+NpMMuXBYEVwAaOow=oBgUhBwen7g=68_5qKznQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAEf4BzYv0Ys+NpMMuXBYEVwAaOow=oBgUhBwen7g=68_5qKznQ@mail.gmail.com>
User-Agent: NeoMutt/20231103
X-ClientProxiedBy: YT3PR01CA0066.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::17) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|DM6PR10MB4236:EE_
X-MS-Office365-Filtering-Correlation-Id: 3308434f-9243-41be-bc9d-08dc864c4dce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|7416005|1800799015|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?anlBYVlreEI2a3Q5bGZjZVVqV1BYN0hMV1lhdklqdVZQWW9TcGwrb3VXWVFB?=
 =?utf-8?B?bk9BRGc0NlFXbjdQSlBLdmhLdDZzZWNtRW5PdGR4Q3FpZUg0R3h0YXFJVHF6?=
 =?utf-8?B?YytaNGwwY2Jvb20rM2FIZTZHMkx5Q25PVmxkQXVtWExqNlJSSER1NWRSbXJD?=
 =?utf-8?B?V0VDR0dsVStTaW9vdWphSXcrakpyR055Nzdzai9BcFgyZFFHejRvN054WHFl?=
 =?utf-8?B?T29CWlM0M3dwRXY1a1FxMlV5dWE5SHRjSWE5WnMvQnJINjBkcU43S1FiYWhy?=
 =?utf-8?B?MWtQNDdCYTduNXpLV25DeVZuWW5GVkovRG1rdFpLZGpwUnZ6WWdHM0FHSUtu?=
 =?utf-8?B?MWxscExyVG5HQ0JGL1hSa3YxVHRpTmd0bkluSldRT3p1Wngvb3JWYjgvRVpM?=
 =?utf-8?B?cWRJdzFSN2hVdEorUGZFS0VTL3lndTM4blV3a2daTFNCUURhN1lLaTQrMTdu?=
 =?utf-8?B?d1ZmRS83Q2Q4UFBoLzFoUytDRDJpU2RuWkVYaHI3SHFVbmhBVzg1bDRZZ1FX?=
 =?utf-8?B?T1lvamovRjM0NmtSL3ZsWUI3eGtLdFpYdnN0bnhxaVIrRW5nVldYNmZzeGx6?=
 =?utf-8?B?NDNTM2g2MUJQZnZUQzVyOGd0TGJieTRaaXBQaDY0RjFmRG4rTXhpbndIWmd6?=
 =?utf-8?B?eEluWWtjNFRFV24ranBteHRyTEZidThSaVN3bytRZVdLYVFPNVR3bGtrRkRj?=
 =?utf-8?B?YW1kbDV0Mi8zc1JLakV5aHgrRXVRbUtDZ2dKZGd5Tmx3TjBBRFNJcVlnM3ZJ?=
 =?utf-8?B?RHBpRHVLMHRmV2NoV2lPSUoyZW40b3dIQTZUZG05c0x2VDlIN0NONHF2dGVv?=
 =?utf-8?B?YjRxVnBkMk4zWUpUK21rZ2o3Q1lhNi9iYm93SHJJRVJRR3I2UzJrRThJUGpq?=
 =?utf-8?B?aTgvbVhkSG9mQTMyU01GWlZ1dVphc00wTkdDczN0dms2RW41QWZqRHovZHpr?=
 =?utf-8?B?U2pTZlMyQ0F2NkdjVFZkck1yQ3Jpdk9uajhrUVJORmtHbzN1ZE5yZ2JsMU0w?=
 =?utf-8?B?TlA5aEhoWlBoOGZIUkNYaWxVYjlyUyt0ZXFSMjFwczg3Tkc4Q0N0Y2pzMVhI?=
 =?utf-8?B?RlRDTkdYNnpjMzVHcVlnWDNlSVp5amFhdVQxM013ck03VDZjdGNXZ1RqWWV5?=
 =?utf-8?B?NHM4YS9QcFNUNG1iSmZERlExOXlQRXREQVhRb1lIU0E0T2ZicmIrdUNWRE44?=
 =?utf-8?B?WXNsSkljaTdwb3VacHBRbXlvSTgwZ21LRjlnSHJJdVl3MDNoTVM4VlRGblI2?=
 =?utf-8?B?ZmllWENaRXV5NlZZa0ZQQUxuZEp2VG5VdG5tVlQ4K3RORXYrK3FrZ2N0Rkpu?=
 =?utf-8?B?ZDJZNWZ5b09nQk9FNE1meFhRQ1Z1MWNtZlZLVk1kUWRZWjhhYjZ5OEJUMVRu?=
 =?utf-8?B?ZXhIVzc3S2ptalREbVpLeFo5V1V6bmw3V0xSdU9rSjZVY0VFVGwwOUhwYjB6?=
 =?utf-8?B?eW1tNW5UbHdJRldYZ1NIeUFyRnJpSDhDeWp5WXZwM1l0WjM1V1B6c1VTM3JV?=
 =?utf-8?B?TkJUTjFWTUNhb0xNYU5xODNkaFFrQjRmd29JV1FydWh6L0NiVFVQTHJsdWln?=
 =?utf-8?B?emVScWljbkpaTXRLakw4NW1mT3Zjc0ZPN1k2ZXhXQ0EveUgzWVNNdHpXV1B3?=
 =?utf-8?B?alJsSm5vOU9acUJZYWc4aXBVWFplaUV4Sml4b2lDanZmTnUybHYrUTA0djZM?=
 =?utf-8?B?RXE1bkZKZGJIUnoyei9YQUxmcUQxRmk4QmZWelZwdlo1Mmc1bklwdlRRPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?N0cwYUtadS9KQVdXdzdONUl6eERkQ1AyRmZyQXBaSVZ1WDV0akhqUUtWbXJ4?=
 =?utf-8?B?U0ZvbVpGSTZIOXVIYytBUVI2cnh6S1JMckxUUnJkTUVpakxHMTdqYURGN0p2?=
 =?utf-8?B?T0hSQUJqSlV4K0VVRWVKWUtibzljdHdheUhPL2pIUE55dEc4d2pxTm5IMmpX?=
 =?utf-8?B?VDBuVTlENWVlVm4xMDBvdXhWbDJxQU5NUWh0TE5MNXlETGtPcWdPQWJpMmlV?=
 =?utf-8?B?UmFrSEhOZXo3K1VyNGZ2N09LVVU3OVV5a2haWXRjUDdpUnBjMGxWd0pxRWx4?=
 =?utf-8?B?TGJHQzFTTHhJUm1OQ0V2VXVoMmpXZUd5SGhVMDdna0NBVURYaUd6VUd4SGJG?=
 =?utf-8?B?WUlKMDRpQlZZNDNkNjQyTnV2ZDJmQUIrOHZiNjhjUDhIN2JJSWZ2VmxQZVlZ?=
 =?utf-8?B?RUJmc2ZBWmM3SjFOTjBucU1uTnlqYm5saDZMT2xtT0N5dDJMSS9GQ2FHWFZX?=
 =?utf-8?B?b20rY0dxVTl4NzlBbWF2aUpUaTZWSGhXak1jdDFWOXJLb1V1d2ZxQkJPcFc4?=
 =?utf-8?B?Y0dxazdwdjk5b1FlVWgvZjFhUTFPbjVod3hWODNSbjRlQTRLa0JyNFN1eEFy?=
 =?utf-8?B?bzJOKytjOHJ1ZlBXN3NSUU0xRDEzZmZSY2wzYVA1SWxKTUZOdjNDT0Z4YndM?=
 =?utf-8?B?bURtbVk5Y3FUc0hjL3cwcU44ZDVFaHltdktaUGtSN2lBanJoenZlOVZrNTRG?=
 =?utf-8?B?dGpvbUNjMGl6WVJ5d1VVQW96WkZGTi9WUFl3L0xOYzhBcGMwRzErSUM3YmJW?=
 =?utf-8?B?T0V5c0I4TUR5SlNVUEVqWERHL0ZLK050U3Zsc0ZleXN0bzhsMWdpdXJuMUVh?=
 =?utf-8?B?Uld4a2tXQjB6aWYwd0FhVFpSWlNaMlpySnllQlAyWERjTUNTTFJxU21Vanp3?=
 =?utf-8?B?cWYzVnRaK2FOMkQrTGZwZlpXWUhQSVh0SWx2aTZsVHMra1pTbW54bjIxN3dD?=
 =?utf-8?B?U3E0dUZ5QmR4WmZLRXlNU0NQUjN4L3VmdlBnSzdabGVpbDRaYVVweWtOOU10?=
 =?utf-8?B?Rys1TW5rRG9tZFpMMVhZcFpSTnhITDhPcGZKK2ZJcWxkYmpTR05QbVVvVW53?=
 =?utf-8?B?bFE1VTJ6Unl0Y1gyeGRrWlpWb05ZY083QmNVNjV2M1FZWmJETExRcGxRQWtV?=
 =?utf-8?B?R1FYMWFRSlpKNHI1ZE11QTNHT2x4eXkwVTY0cExHNkdaWVovcDFtTTFMMkJ1?=
 =?utf-8?B?djZWbzRLVmhKVFZmQTVBOWU4ekROcG8vWTZRNmYxSHNWaVVZaEcvSnliVGpX?=
 =?utf-8?B?aGVDa2lkY25wNCtlWDA2QzR0S0NUdmpuK3RPN2JUV1dSRmhDcnR1QUFTRnhD?=
 =?utf-8?B?M3I0YkVMczZ4dFoyd1Q4WU1VeFdNbW9KNHhYWU1xLzdHcTcwcWpkTGpHRVls?=
 =?utf-8?B?QzVXRzFMckw4ZERuN2Ztdk5DRGN0b2pqQzc2U3BDNFdEL0ppRU1JQ1JjTzR4?=
 =?utf-8?B?N1JhUWRMbDBDdXQ3K3Izbk44VElPNkY5U1Y4QXF2d3Q5UDRzVFIwaXFaMU1H?=
 =?utf-8?B?Y0NudDZBMC9iZ0hHZGhCMGdadUdXWFhsY3lKYWlKTGpzS3dVQ1plTjN5YUJk?=
 =?utf-8?B?UzdKcUlYdlhqZEpXNW1JbjVHSlZUdjByek5YM3BhUUpUT0ZmUW1sZUNzMnp6?=
 =?utf-8?B?cDZXZVVFLzkvRW16cFVYbFhCWG1ybXhmSXN4aG9JYmIyRkUvaFFLRGN3c0lv?=
 =?utf-8?B?MmY3cSttOXZjMC83alFKaDdGNVN3SFRNSHg0RmtSNUNBVUdPckU3M1FPNTAw?=
 =?utf-8?B?R0UrRTZDYlo0NlhGdTRodHJlWHF6MXkwTnFncVZ6ZGtlLzdUNXNwcWJLYmhS?=
 =?utf-8?B?Z3o1U05ucllXenpVVGx4dWcwcVhyUVB3ZWU1a0xUUVlodXdMcE9GRkRheVhl?=
 =?utf-8?B?bTJjOGpGS1Azb2poUVdwNUFGcWxLbzE3TDNrV1FTOWEwN1BlKzZ0WTVkcUFj?=
 =?utf-8?B?Q0tlb1ovcnNETjZ4VWhBZVpvNmFCZDE5OTAyS0x0RTM4cnhURDRGbkNBc1lS?=
 =?utf-8?B?VVN3dkp4UFRlM1FsS2JLOVBnMms4VGJzck9MR2NPTDdnMCtOSlhKOHlnb3NO?=
 =?utf-8?B?aFl0VmV2YjExRlQyemJseTJrWVFZM3dibVF5Nmd1RFNhT0Y0dmk0YmhNUjhQ?=
 =?utf-8?Q?al/8Y2ZbLtC4ueHdM8//VlL8M?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	RiRC1bTeGL3TSWAQsF7mEWPhZ5Gzbvd3w/N5dpjWTym8xqal9cuZ8uBWykdYDXFcsIS8EMpIBpwiuZ33XXecUXDYSu8wMgQbATDYDuTw8ybCn7hP+RL0TvIj75sOy4izB0LNXYj4T3KtU0lsOYpQV91u9LZfFZDANH9B3FERJs93KqBq0lF71wK9GuG4rfrpIFJhtq8DMSxlnZqAr0rGEDtcHZEaa+sGcHDECbhcMWA7vz31CjhrizBni27L4v03hGfUJie1BHBGSn2iR7IKcYzj8an3AJc+tpOyqm2qnvJuFN0BjuJb4v/TLoZl9IQjY20J0Q+3+RKI3+NKimFXZiCvztKnS5hSNzMUx8sWeVToas5Mf9VVyLsLZXYBsptSJPNzZCSt7xy64DUI9dtDfTcfeQopU0wHd8x15akdyjj7xHlj2ATy33HM0qYkIvzMKCPIJFWiAxKteToo74gZVrR2BoOsi+I3e/ChO90lq1Db+Dg0qP261ee77jlgUX2ijuWVGss5XEHz9LSXFg1GRFL5UyFH4y5Ex/ECKQumEOQwRvMTchAX+wm5sq9ikgsrtLla6qEzWRHFSZGVNxSLBcc/x5Upa50rMb6wKUxDQ/Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3308434f-9243-41be-bc9d-08dc864c4dce
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 17:15:46.2627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mi0XDLRkOguojEGruP1wsABnwW+/67LO1bDcOsXokA9VrJrp6qW5c+PY5agD1bDPLQwp8s+kMoj6F5u3iP4nLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4236
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-06_14,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 adultscore=0 suspectscore=0 malwarescore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406060122
X-Proofpoint-ORIG-GUID: 9hVc3AQJ64c88r9cu6cmbEZD1NbPdPcK
X-Proofpoint-GUID: 9hVc3AQJ64c88r9cu6cmbEZD1NbPdPcK

* Andrii Nakryiko <andrii.nakryiko@gmail.com> [240606 12:52]:
> On Wed, Jun 5, 2024 at 4:16=E2=80=AFPM Suren Baghdasaryan <surenb@google.=
com> wrote:
> >
> > On Tue, Jun 4, 2024 at 5:25=E2=80=AFPM Andrii Nakryiko <andrii@kernel.o=
rg> wrote:
> > >
> > > Attempt to use RCU-protected per-VMA lock when looking up requested V=
MA
> > > as much as possible, only falling back to mmap_lock if per-VMA lock
> > > failed. This is done so that querying of VMAs doesn't interfere with
> > > other critical tasks, like page fault handling.
> > >
> > > This has been suggested by mm folks, and we make use of a newly added
> > > internal API that works like find_vma(), but tries to use per-VMA loc=
k.
> > >
> > > We have two sets of setup/query/teardown helper functions with differ=
ent
> > > implementations depending on availability of per-VMA lock (conditione=
d
> > > on CONFIG_PER_VMA_LOCK) to abstract per-VMA lock subtleties.
> > >
> > > When per-VMA lock is available, lookup is done under RCU, attempting =
to
> > > take a per-VMA lock. If that fails, we fallback to mmap_lock, but the=
n
> > > proceed to unconditionally grab per-VMA lock again, dropping mmap_loc=
k
> > > immediately. In this configuration mmap_lock is never helf for long,
> > > minimizing disruptions while querying.
> > >
> > > When per-VMA lock is compiled out, we take mmap_lock once, query VMAs
> > > using find_vma() API, and then unlock mmap_lock at the very end once =
as
> > > well. In this setup we avoid locking/unlocking mmap_lock on every loo=
ked
> > > up VMA (depending on query parameters we might need to iterate a few =
of
> > > them).
> > >
> > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > ---
> > >  fs/proc/task_mmu.c | 46 ++++++++++++++++++++++++++++++++++++++++++++=
++
> > >  1 file changed, 46 insertions(+)
> > >
> > > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > > index 614fbe5d0667..140032ffc551 100644
> > > --- a/fs/proc/task_mmu.c
> > > +++ b/fs/proc/task_mmu.c
> > > @@ -388,6 +388,49 @@ static int pid_maps_open(struct inode *inode, st=
ruct file *file)
> > >                 PROCMAP_QUERY_VMA_FLAGS                         \
> > >  )
> > >
> > > +#ifdef CONFIG_PER_VMA_LOCK
> > > +static int query_vma_setup(struct mm_struct *mm)
> > > +{
> > > +       /* in the presence of per-VMA lock we don't need any setup/te=
ardown */
> > > +       return 0;
> > > +}
> > > +
> > > +static void query_vma_teardown(struct mm_struct *mm, struct vm_area_=
struct *vma)
> > > +{
> > > +       /* in the presence of per-VMA lock we need to unlock vma, if =
present */
> > > +       if (vma)
> > > +               vma_end_read(vma);
> > > +}
> > > +
> > > +static struct vm_area_struct *query_vma_find_by_addr(struct mm_struc=
t *mm, unsigned long addr)
> > > +{
> > > +       struct vm_area_struct *vma;
> > > +
> > > +       /* try to use less disruptive per-VMA lock */
> > > +       vma =3D find_and_lock_vma_rcu(mm, addr);
> > > +       if (IS_ERR(vma)) {
> > > +               /* failed to take per-VMA lock, fallback to mmap_lock=
 */
> > > +               if (mmap_read_lock_killable(mm))
> > > +                       return ERR_PTR(-EINTR);
> > > +
> > > +               vma =3D find_vma(mm, addr);
> > > +               if (vma) {
> > > +                       /*
> > > +                        * We cannot use vma_start_read() as it may f=
ail due to
> > > +                        * false locked (see comment in vma_start_rea=
d()). We
> > > +                        * can avoid that by directly locking vm_lock=
 under
> > > +                        * mmap_lock, which guarantees that nobody ca=
n lock the
> > > +                        * vma for write (vma_start_write()) under us=
.
> > > +                        */
> > > +                       down_read(&vma->vm_lock->lock);
> >
> > Hi Andrii,
> > The above pattern of locking VMA under mmap_lock and then dropping
> > mmap_lock is becoming more common. Matthew had an RFC proposal for an
> > API to do this here:
> > https://lore.kernel.org/all/ZivhG0yrbpFqORDw@casper.infradead.org/. It
> > might be worth reviving that discussion.
>=20
> Sure, it would be nice to have generic and blessed primitives to use
> here. But the good news is that once this is all figured out by you mm
> folks, it should be easy to make use of those primitives here, right?
>=20
> >
> > > +               }
> > > +
> > > +               mmap_read_unlock(mm);
> >
> > Later on in your code you are calling get_vma_name() which might call
> > anon_vma_name() to retrieve user-defined VMA name. After this patch
> > this operation will be done without holding mmap_lock, however per
> > https://elixir.bootlin.com/linux/latest/source/include/linux/mm_types.h=
#L582
> > this function has to be called with mmap_lock held for read. Indeed
> > with debug flags enabled you should hit this assertion:
> > https://elixir.bootlin.com/linux/latest/source/mm/madvise.c#L96.

The documentation on the first link says to hold the lock or take a
reference, but then we assert the lock.  If you take a reference to the
anon vma name, then we will trigger the assert.  Either the
documentation needs changing or the assert is incorrect - or I'm missing
something?

>=20
> Sigh... Ok, what's the suggestion then? Should it be some variant of
> mmap_assert_locked() || vma_assert_locked() logic, or it's not so
> simple?
>=20
> Maybe I should just drop the CONFIG_PER_VMA_LOCK changes for now until
> all these gotchas are figured out for /proc/<pid>/maps anyway, and
> then we can adapt both text-based and ioctl-based /proc/<pid>/maps
> APIs on top of whatever the final approach will end up being the right
> one?
>=20
> Liam, any objections to this? The whole point of this patch set is to
> add a new API, not all the CONFIG_PER_VMA_LOCK gotchas. My
> implementation is structured in a way that should be easily amenable
> to CONFIG_PER_VMA_LOCK changes, but if there are a few more subtle
> things that need to be figured for existing text-based
> /proc/<pid>/maps anyways, I think it would be best to use mmap_lock
> for now for this new API, and then adopt the same final
> CONFIG_PER_VMA_LOCK-aware solution.

The reason I was hoping to have the new interface use the per-vma
locking from the start is to ensure the guarantees that we provide to
the users would not change.  We'd also avoid shifting to yet another
mmap_lock users.

I also didn't think it would complicate your series too much, so I
understand why you want to revert to the old locking semantics.  I'm
fine with you continuing with the series on the old lock.  Thanks for
trying to make this work.

Regards,
Liam

