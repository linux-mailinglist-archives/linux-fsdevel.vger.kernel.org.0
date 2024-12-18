Return-Path: <linux-fsdevel+bounces-37740-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E2F9F6B74
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 17:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 229B3188B10A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 16:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50B41E9B33;
	Wed, 18 Dec 2024 16:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="mA8gCxJY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053C213B58F;
	Wed, 18 Dec 2024 16:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734540533; cv=fail; b=CNKn2UbsR6eXewOh09n3QRdQiB1C6/8JSrnag1t5iE7COLptn+k3f6JsMnqIDyEScYSsNZuAwijf1GAprD27WP6nlOQ4Z+KlRXW5gV3X2vKFTQ3h684xuDKYcCBhgAb2JvduDh5mLmMM8JOhhTpiARdrHmh+IqGwdUfqXLYwRfM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734540533; c=relaxed/simple;
	bh=+RAuuH2m6yjt6oNb16y0ZS8qZXz14SqKFjYazLdFf9Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FNVF1DKzyoYvsBOCxBiopE6kknDWcNpcwT+mFbzLPN3ohQqtXH76TSwlGMihXUghXDDy/D2vPQD+ymrVoyp+saGBFCJ7mjdlqBI//hRycyMnxrtGqXVcxwsp49wVkcNbmE4WtAYt32AM9OuQbU6nFpxcBhTIChOO9e9dox/4FoU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=mA8gCxJY; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BIGRepe016267;
	Wed, 18 Dec 2024 08:48:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=+RAuuH2m6yjt6oNb16y0ZS8qZXz14SqKFjYazLdFf9Y=; b=
	mA8gCxJYBtmhOx2pOfAyKQlEP0CpMx/8lLOABz/EJukWOidhkc/HDHWXv0L9cxJu
	iF+UTrpisnLFA8Z73F4fLo0UkVWnMz6HO2tgOGkLBqQTz5QPJY+ZKruCqHmGILgc
	RC4laPMczpjP5i/1QjdR7ZsMSkHi1g+qNqpQiLQowCYkaly/nTovO69mhAzGapLz
	S69dz+clydSUwucAnI7Y13BWZWJrSqxIVCXvK/TDvU+flpifBBkX+42NG8lblpQJ
	/1MurGBmyFVa0PH0RY34z0GQfcLSiViQPv5vnhc5/cA3jUd+fuJd1pOgw/Ia6yWF
	4gYBTySlUCBIqMhLX565Jw==
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 43kv7rab6g-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Dec 2024 08:48:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fd2sMhOMI0jpi1wf5QhlxXCxJbiCUuC34GH4sEGVH352uSqKZtJACMMLpEvwcNFqTJmvRVXAZ7ts2VypprVB27DhhznhFmcfBBHA8sLb9BvYutD/5qv07DU+ImQ2r2hV7cq+Bvcfb9Gc3lNZwTwKY5yFF9EANSZy5Js36ngJbT6oXm/GMeHo19+yWAIMClV+UV0/Dn8lz8WddIRbrrW9dqXWYyOR96/3gFwInwlBGLktOmdhwKCz0qz8AVG5rSJ9KcWrKgjXJb3XcW01iKFDp/e7A5KIxuQ1edYxrmgMrr/ChamXJhLSFPVmIvCFR8njM7sMahUlNdOlWBLB67Idag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+RAuuH2m6yjt6oNb16y0ZS8qZXz14SqKFjYazLdFf9Y=;
 b=keTP7ge1UIoH96PdkAK1Q+za0Bi9RtC0jTfBZUm5TgQpHrMLri6j/Fa4zllEigdI43heXft7N9ESYZdHI8+3jhBlGG9bdiqmATgIY0mC6lyXpOtvTdqkz+N330LF7bzv8FWqrWspGYBH5/BqiiS+eNb7Blj+WGjlyy7OgMfV0HbwmzRUjh8M/SzM2KsylMfJcJ455sAELwnlFZUTA6ng9SoaVOSyblBSR5Wyn35kjVsI0l+WsHrOirxUi+9nD/dY4ggn5OJUSes4Ml+HUfP+R2oHPxVwgUtiyTvkn8x/A1kxHWpOAO8CLxQCGGQC7J8CdO2XSOQw1u9+WaNaXsXUmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by DS0PR15MB5942.namprd15.prod.outlook.com (2603:10b6:8:121::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.24; Wed, 18 Dec
 2024 16:48:46 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610%7]) with mapi id 15.20.8272.005; Wed, 18 Dec 2024
 16:48:46 +0000
From: Song Liu <songliubraving@meta.com>
To: Casey Schaufler <casey@schaufler-ca.com>
CC: Song Liu <songliubraving@meta.com>,
        "roberto.sassu@huawei.com"
	<roberto.sassu@huawei.com>,
        Paul Moore <paul@paul-moore.com>, Song Liu
	<song@kernel.org>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "linux-integrity@vger.kernel.org"
	<linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "dmitry.kasatkin@gmail.com"
	<dmitry.kasatkin@gmail.com>,
        "eric.snowberg@oracle.com"
	<eric.snowberg@oracle.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        Kernel Team <kernel-team@meta.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "jack@suse.cz" <jack@suse.cz>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
Subject: Re: [RFC 0/2] ima: evm: Add kernel cmdline options to disable IMA/EVM
Thread-Topic: [RFC 0/2] ima: evm: Add kernel cmdline options to disable
 IMA/EVM
Thread-Index:
 AQHbUMHZ/pEEoDutDkiUOsUV91UKILLq8+2AgAAIjYCAAAEqgIAADAaAgAAIRACAAASoAIAAd70AgACn3ICAAAGpAA==
Date: Wed, 18 Dec 2024 16:48:46 +0000
Message-ID: <746B14AA-7C89-451F-BE8D-3D2C485AA9E9@fb.com>
References: <20241217202525.1802109-1-song@kernel.org>
 <fc60313a-67b3-4889-b1a6-ba2673b1a67d@schaufler-ca.com>
 <CAHC9VhTAJQJ1zh0EZY6aj2Pv=eMWJgTHm20sh_j9Z4NkX_ga=g@mail.gmail.com>
 <8FCA52F6-F9AB-473F-AC9E-73D2F74AA02E@fb.com>
 <B1D93B7E-7595-4B84-BC41-298067EAC8DC@fb.com>
 <CAHC9VhRWhbFbeM0aNhatFTxZ+q0qKVKgPGUUKq4GuZMOzR2aJw@mail.gmail.com>
 <6E598674-720E-40CE-B3F2-B480323C1926@fb.com>
 <191ABC6C-1F0C-4B12-8785-C0548251ADDD@fb.com>
 <518fdb73-8daf-4181-a8e6-528e4824d955@schaufler-ca.com>
In-Reply-To: <518fdb73-8daf-4181-a8e6-528e4824d955@schaufler-ca.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.200.121)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|DS0PR15MB5942:EE_
x-ms-office365-filtering-correlation-id: 0b6422f4-e3a6-4ba4-eee9-08dd1f83d711
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|7416014|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RGo5eTM1Y0lqZXlFR3o4ZUZQaE1aYzJFbWo3cDFMbEg5Q3lIMWZGaDVyOEN5?=
 =?utf-8?B?OWJKZjgzaldRK3RMdFN0N01sV3BTb01ZdVhaNGtVUmF2TU0wd3BIbzJmUnZB?=
 =?utf-8?B?aEZ6NU8wNzhNOVlkMXRKdENDS09weFNXVmQ1U3RZS2RCOE1lSTJpNzBEK3BR?=
 =?utf-8?B?ZkNDbXNvUUU1RldaeXg3ZS9nZ1NOVFB2S2NKUUVkKzBKUzRGcUxZRnhkL2lN?=
 =?utf-8?B?VmpHUEJYTW1Hc3JkQUsyOFFnN1hoc3VCd3JMUjNxUjJUQVZvdXVIUUlVTEdz?=
 =?utf-8?B?QWRZOWhaZGswMGlwWFFRa05xdHlxUzVUYTdFejVTSmJ0Tm8xaHUwVEEvVTU0?=
 =?utf-8?B?bzVNMWF2SWFkbHhtbnhPRVVlZGI3UUptRUoraW80T3ZyV0JwVHMxVlA1djBp?=
 =?utf-8?B?RGhiOTQvMVdEeHB1aVBQb2cxQWg2K2hLRXpJbmpBMmoraVEraUEzd0sxMm1m?=
 =?utf-8?B?aWFUVStIWHhGeGhGMHNaby9aaUtmcjRWYmVMUFhqaVNhYjM0ODhmUUl1Y3h5?=
 =?utf-8?B?V0NQQVBtaG0ya2U4S00vV2FKTkFYMHBWYXNhUVVHdGE3WWJMSWMvNWo2bzhO?=
 =?utf-8?B?RTRETWtuaDhPWDZtTm1VTE1xSlRydXBJcnIrYmNMM1pGNVhMUUtRRzBVb1RT?=
 =?utf-8?B?Wnk1dXFxcVJyK0pON0FZajRnS3lSQXJrM0NBQnh0TXhILzM1SGFlaDhrY3RU?=
 =?utf-8?B?THVncGh4M20yMk1xOGpjbVN3ODlSVTZNVE1sa3NqQ2xrcElKQVpJRE9KZ0l0?=
 =?utf-8?B?Q0xiL0ZlK3VKeHp4ZlJiNUVLSE5qT1RSWXEva1gxOUhNdDFGUkNXUGxNak0y?=
 =?utf-8?B?WHZmUWtncVU0ZDh5NFRRNVhIRzh2RzhaK0tuU3Y2RUV2TzRFdWF6WTFtSW05?=
 =?utf-8?B?QWhGdVI3dUd6ZnlTTzEvSjZrZ0pSVFFGTENrS3paZmhHdEs0WEorK2UySkUv?=
 =?utf-8?B?RDRSeGk5d0hUL3BVVUpMWE1qN1dMNkdQRkhOcFhRMnVaRHdoaWdEZFRsd3VT?=
 =?utf-8?B?eDJHRnllVUZER2tLZUVveDY3NFUwa25nNnROd1kwYjBKcnZ0QW9TU1NzdVBX?=
 =?utf-8?B?N0tRN2F1cHZJK3ZkUDNZcVpNYkdLLy82MTFkVGNzSmM3STB2NktnNkFmSk90?=
 =?utf-8?B?L2JUckRzNlAwVEdxbTJUSm9RL09FRnFHVDdaaCt4MDRSTCtCVE9UMTIrVXYr?=
 =?utf-8?B?K1Qwa1E3K1dIaUsza3F6QWlNbGtzOVd5RVhTQmJieEZkdzVYdXB3OHA0R0ZJ?=
 =?utf-8?B?TStxQytxZFBEaWU3VVlzblNMU2xFakxWNHZHREVvTVd4cUlxZ29sQW92cjgw?=
 =?utf-8?B?Q1l3dEY4N25LSlZlekgzN1RPNUQ5UkdVQjlPaDkyaUprdkJDcGZoQTJyWDZW?=
 =?utf-8?B?S3hCTXVNKys5MGxINjFzc1JYaC9KM2pwS3ZHUi9ONXhTTHYya3ZwcHFtWFZE?=
 =?utf-8?B?eDUrSThvZGlrM1JOZ2ZxRlFPWXNNQytZVlg1dHFkTS9sL1VZaSt0aGM2V2do?=
 =?utf-8?B?SE82cWR0VU01RXU5MkNKeE9ieFJzbTllWXc1N1VEeEQ1Zlgrd1hxcm1pZzVy?=
 =?utf-8?B?eWpLWFE3NVJhVTN0U09xZ0IwT25PTUlLL3A5eldwdUtsYVVickh5RUxxQzRn?=
 =?utf-8?B?ajk4OFFaRVZOMmlyRlBPbG0xbkVremdVMDA4UkhEQUFETUhxbnk4aWVtbW1s?=
 =?utf-8?B?UVQ1aUZQTDZHdmNQUHBUSXR5Uk1kN2YvNmRYZ3I4NEFDc2hjNWNEQkc0a3kw?=
 =?utf-8?B?bmUrWGNhSW8rVmtaYzBkTkZqRElVbFhYQnY0dWRqa3YvR21zVWcyZVNQdFc2?=
 =?utf-8?B?UTRXY0RYa2NvLytuQkt2ZWlwOGdSVG55c2FuTEZaM25tTWxwY0hwVFFaNEEv?=
 =?utf-8?B?UUM4MExjR2E1U281T2NiVnU1U0dtU1JoclcvTU50dzlSVVR4bnVkR1hNTVVR?=
 =?utf-8?Q?EMJBX/i3WJIsu5SIovXzSh7s1h1AGSyg?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RFYwQlVNSUlkQ1A2Mlg2SW15a2xWQ0JXSGhocFF2UHp4bWM5SmNEMldkWGd6?=
 =?utf-8?B?UFVVNVg1ZXo5SUVCZkVUcjFxNGhsVlRia3c0aFFSQ2c2MDNwSGduZ3VJc1dM?=
 =?utf-8?B?WnJLbGlnK1BLWVNTOEFFWWRjalVsL0YxWVdFMThtZDV3QmdBRExRbjBHNVJQ?=
 =?utf-8?B?K0dOM1hrVU1MZFI0UEcyQ1BuV3g3ZlBzN3FWek1KejNFLzNzOVI5NVY1aldW?=
 =?utf-8?B?cDk1UHZPcmxTeWtzYklkQVRWV2FOVmJabkV1Q3k5RzhQRkNHdzhUOW1JUWVx?=
 =?utf-8?B?dnBXN1Z4QWhKekpEL0tORk1KcEFsQlB6dlFEY2hoUTNNczdGSEppYTZBaG1C?=
 =?utf-8?B?dEdDRGVlcHV1eTI1NkZDUmY0Ukl1d2FULzF6YUxycWxEWlIzZ3RtS0Y2MHM1?=
 =?utf-8?B?ZUlncUxCNGhjTzA0ckpibTJVWDdMMWt6VVo2THRhcmFvMnBSWjlRZTRoNWwy?=
 =?utf-8?B?dXBCcnQvZ3N5SGpvTnBYaVJUMDkzb3RlWk9EZ0RlVzNkcUNxUENTRWJ3MDBM?=
 =?utf-8?B?V1o5ZXNyemEvYUExdVdEWGtBbVJMZ20xT0FVNnZmZXNXdjVaNUhTZjZPRzd5?=
 =?utf-8?B?TTBoYkM1R0R5QnJ3ODByWldIcTFnc1JxUHR2L1JEUlAvV25keDZmWlRoM044?=
 =?utf-8?B?aXU2cFdiTWd3N1FiV0hJU3RPSkNUKy9MZXFPMjVndytoRTVVS05vOGpDeGhZ?=
 =?utf-8?B?OERTWU03d1ZGSjhnT1g1VXVRSmFpTGhzdVU1bGdqTWZtd2Jjb0o0TGF5dDl4?=
 =?utf-8?B?emR1VVZLbEE1UnRQdGRkM05YcVVwYS93TnZMaks4WVZQdnpTNENYQnMvTXZD?=
 =?utf-8?B?MEdYdkJ2VytQWDJjVzA2M1R0NlJ4VjJCNXVDajJFenY3a0Q5V3BneDJhbVBx?=
 =?utf-8?B?WlFEb2ptU0l6UDhwbUpDRUpRbmZTYWsvUTVkMkl4N05VZ2VIVjJlU2VBUXNy?=
 =?utf-8?B?Z0pXY1Y5UHk3N1hHVVBaSFI3UmVhZE1tRDBPOTJPWmlibG03QXoyV0pSZzZZ?=
 =?utf-8?B?WXpsdU5pSnRWeUZsaVJQS1puc2s0SUVib2oyT05TRUtvVzliTzBYQzBqakht?=
 =?utf-8?B?ak0xMVlFRFd6eDhOSnIvbzdmL1J4dktzMkp3MnJBdkdhei9rV00ybVlDd2xm?=
 =?utf-8?B?NGNQZkRqWjNaczVXSmRUMzFWRUNBZFFlR3hCSGQ1Qld0SWJoekd3TWF5Z1Br?=
 =?utf-8?B?NElCdDBKc1NlQ055aXZxbG1XZE8yU2tRTGh4dEVDcno2dkN4N0VyTVE5N2tO?=
 =?utf-8?B?VGN1VSs5VGQ4SkZpVXNFaHBYVVNuSUxXOURqdkdOQU1kMFRNUGlneGc0VTZH?=
 =?utf-8?B?UEZOa0ZvZnVhdGNRRWNES2diVDE5Qy8waER3eTNLY1cvZm9iK0NHQmc3VkNE?=
 =?utf-8?B?Q2VZSk4vTEVobUxqdXBUU2tzOVJZSTNURlpneFpYdTlmYzlRS0pocm9jWVFl?=
 =?utf-8?B?dGtkQ08yRzV5U2hKYW1DdTRXM2hyT3NjdUN1MWwyTE1LTklzMjdoN2dXV0pD?=
 =?utf-8?B?Q1BuM21wMHJkUkF5OGhtQ05hUzFWcGRMbGcvZTRsTGV4VDlYNUN0RzJKekNu?=
 =?utf-8?B?SnlQMzFuQ243SUVSbWE0ZzZjWjkrdnhqdGJCNFl2QU1UTUlPTUxRWnhUditk?=
 =?utf-8?B?WEFBcUt2bjhwNGpwWkJwR2ZLSUttSldUdFZTMzVPVDE1YUtQTHl6Rmg1K2pm?=
 =?utf-8?B?ek92SlV6bkRFV3RaMDZMTmdHdjI2MkxsTGo4Ym8wZjJyczRZM3BlODJ2TUNy?=
 =?utf-8?B?SC9iL2JJOW1xQkpTK25JZFdoWVdqQk5Wb0QzOXFVQVB4SnZ1cGxwZC9CTXcz?=
 =?utf-8?B?RDQ2TnF3dkI0eEVXOHFzNUEvS2tsNW02Tjg0eEhlaUdMbWZUYXhTcDZYbVg2?=
 =?utf-8?B?dWtvUGdhYi92WWoreUdNbkNsN1gybWNrRkhaS1hiVDFKSGt3M1lHTU5RYU1J?=
 =?utf-8?B?empNTXRjKzFEWUhicm44bEtDMWFRQmhHSnpZMEFGM3dQSWZHRlQ2WlhiMGJx?=
 =?utf-8?B?SlV3amN2VmUzNXpUTzZWajlpTGlsb3Y2TWhWc0JVbnZTWk54UEVvRDJDSGtW?=
 =?utf-8?B?MHRiYXU4SU9LWWVhNFY5NkZHdHJML3I4bmpVdFVETjkzVEJuL00wdUNhM2J2?=
 =?utf-8?B?QkxGMjRwMC82aFdDNnBYM2VJU2I1SElmb0Qra2xDR0dWNTBJL1V4R0xoNEJI?=
 =?utf-8?Q?TWlUy45ZKXNgm7ifPAzpyR0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8D7511DF78B72C499BD6D0467A7C0837@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b6422f4-e3a6-4ba4-eee9-08dd1f83d711
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2024 16:48:46.5593
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PL/ogiy1FwT3kd9xgNaDSuLW/wKNjUsC7DPCj+CWmnzfT6pR8wbT48oQfEKm25HFVlrzut7zHUwvWWB/kj3LKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR15MB5942
X-Proofpoint-GUID: VWW408fPdMoP5_hKkX-hb6a0MLMNjG9j
X-Proofpoint-ORIG-GUID: VWW408fPdMoP5_hKkX-hb6a0MLMNjG9j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_02,2024-10-04_01,2024-09-30_01

DQoNCj4gT24gRGVjIDE4LCAyMDI0LCBhdCA4OjQy4oCvQU0sIENhc2V5IFNjaGF1ZmxlciA8Y2Fz
ZXlAc2NoYXVmbGVyLWNhLmNvbT4gd3JvdGU6DQo+IA0KPiBPbiAxMi8xNy8yMDI0IDEwOjQxIFBN
LCBTb25nIExpdSB3cm90ZToNCj4+PiBPbiBEZWMgMTcsIDIwMjQsIGF0IDM6MzPigK9QTSwgU29u
ZyBMaXUgPHNvbmdsaXVicmF2aW5nQG1ldGEuY29tPiB3cm90ZToNCj4+IFsuLi5dDQo+PiANCj4+
Pj4+ICsNCj4+Pj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZm91bmQgPSB0cnVlOw0K
Pj4+Pj4gICAgICAgICAgICAgICAgICAgICAgfQ0KPj4+Pj4gICAgICAgICAgICAgIH0NCj4+Pj4+
IEBAIC0zODYsNyArMzg5LDcgQEAgc3RhdGljIHZvaWQgX19pbml0IG9yZGVyZWRfbHNtX3BhcnNl
KGNvbnN0IGNoYXIgKm9yZGVyLCBjb25zdCBjaGFyICpvcmlnaW4pDQo+Pj4+PiANCj4+Pj4+ICAg
ICAgLyogTFNNX09SREVSX0xBU1QgaXMgYWx3YXlzIGxhc3QuICovDQo+Pj4+PiAgICAgIGZvciAo
bHNtID0gX19zdGFydF9sc21faW5mbzsgbHNtIDwgX19lbmRfbHNtX2luZm87IGxzbSsrKSB7DQo+
Pj4+PiAtICAgICAgICAgICAgICAgaWYgKGxzbS0+b3JkZXIgPT0gTFNNX09SREVSX0xBU1QpDQo+
Pj4+PiArICAgICAgICAgICAgICAgaWYgKGxzbS0+b3JkZXIgPT0gTFNNX09SREVSX0xBU1QgJiYg
aXNfZW5hYmxlZChsc20pKQ0KPj4+Pj4gICAgICAgICAgICAgICAgICAgICAgYXBwZW5kX29yZGVy
ZWRfbHNtKGxzbSwgIiAgIGxhc3QiKTsNCj4+PiBCZWZvcmUgdGhpcyBjaGFuZ2UsIGxzbSB3aXRo
IG9yZGVyPT1MU01fT1JERVJfTEFTVCBpcyBhbHdheXMgY29uc2lkZXJlZA0KPj4+IGVuYWJsZWQs
IHdoaWNoIGlzIGEgYnVnIChpZiBJIHVuZGVyc3RhbmQgeW91IGFuZCBDYXNleSBjb3JyZWN0bHkp
Lg0KPj4gQWNjb3JkaW5nIHRvIGNvbW1pdCA0Mjk5NGVlM2NkNzI5OGIyNzY5OGRhYTY4NDhlZDcx
NjhlNzJkMDU2LCBMU01zIHdpdGggDQo+PiBvcmRlciBMU01fT1JERVJfTEFTVCBpcyBleHBlY3Rl
ZCB0byBiZSBhbHdheXMgZW5hYmxlZDoNCj4+IA0KPj4gIlNpbWlsYXJseSB0byBMU01fT1JERVJf
RklSU1QsIExTTXMgd2l0aCBMU01fT1JERVJfTEFTVCBhcmUgYWx3YXlzIGVuYWJsZWQNCj4+IGFu
ZCBwdXQgYXQgdGhlIGVuZCBvZiB0aGUgTFNNIGxpc3QsIGlmIHNlbGVjdGVkIGluIHRoZSBrZXJu
ZWwNCj4+IGNvbmZpZ3VyYXRpb24uICINCj4+IA0KPj4gUm9iZXJ0bywgaXQgZmVlbHMgd2VpcmQg
dG8gaGF2ZSB0d28gImxhc3QgYW5kIGFsd2F5cyBvbiIgTFNNcyAoaW1hIGFuZCBldm0pDQo+PiBJ
IGd1ZXNzIHRoaXMgaXMgbm90IHRoZSBleHBlY3RlZCBiZWhhdmlvcj8gQXQgbGVhc3QsIGl0IGFw
cGVhcnMgdG8gYmUgYQ0KPj4gc3VycHJpc2UgZm9yIFBhdWwgYW5kIENhc2V5Lg0KPiANCj4gSSBj
YW4ndCBzcGVhayBmb3IgUGF1bCwgYnV0IGhhdmluZyBtdWx0aXBsZSAiZmlyc3QiIGFuZCAibGFz
dCIgZW50cmllcw0KPiBjb21lcyBhcyBubyBzdXJwcmlzZSB0byBtZS4gV2Ugc2hvdWxkIHByb2Jh
Ymx5IGhhdmUgdXNlZCBMU01fT1JERVJfRUFSTFkNCj4gYW5kIExTTV9PUkRFUl9MQVRFIGluc3Rl
YWQgb2YgTFNNX09SREVSX0ZJUlNUIGFuZCBMU01fT1JERVJfTEFTVC4gQXMgZm9yDQo+ICJhbHdh
eXMgb24iLCBJIHJlY2FsbCB0aGF0IGJlaW5nIGFuIGFydGlmYWN0IG9mIGNvbXBhdGliaWxpdHkg
Zm9yIHRoZQ0KPiBzZWN1cml0eT0gYm9vdCBvcHRpb24uDQoNClllcywgX0xBVEUgbWFrZXMgbW9y
ZSBzZW5zZSB0aGFuIF9MQVNULiBfTEFTVCBpcyBhIGJpdCB3ZWlyZCwgYnV0IG5vdA0Kc3VycHJp
c2luZy4gDQoNCkJ5ICJzdXJwcmlzZSB0byB5b3UgYW5kIFBhdWwiLCBJIG1lYW50IHRoZSAiYWx3
YXlzIG9uIiBwYXJ0LiBJdCBhcHBlYXJzDQp0byBtZSB0aGF0IGJvdGggeW91IGFuZCBQYXVsIGJl
bGlldmVkIHRoYXQgaW1hIGFuZCBldm0gYXJlIG9ubHkgZW5hYmxlZCANCndpdGggcHJvcGVyIGxz
bT0gY21kbGluZS4gT3IgbWF5YmUgSSB0b3RhbGx5IG1pc3VuZGVyc3Rvb2QgeW91cg0KY29tbWVu
dHM/DQoNClRoYW5rcywNClNvbmcNCg0K

