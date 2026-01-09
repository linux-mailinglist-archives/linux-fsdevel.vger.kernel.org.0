Return-Path: <linux-fsdevel+bounces-73090-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 32CF5D0C1A9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 09 Jan 2026 20:48:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A491C3012660
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jan 2026 19:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7841230EF7F;
	Fri,  9 Jan 2026 19:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="RS21Hoj1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip168a.ess.barracuda.com (outbound-ip168a.ess.barracuda.com [209.222.82.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1734E2E7F32
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Jan 2026 19:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767988086; cv=fail; b=L8AgkOb3ZTknz9+EpuPpAO+RSBzOZsfa0KR0YAgmnurLDbKYrt/OPb6wQDsSjs16Y2R4QfaK+EpvnGolA7vIfSxuWK4d4zeunR+cabotUpv0hBAH403E7cIpPcO6NjbYudd1XjhuyKUPX6ttwRkjCBlFviKMvfep9hKa3CmUAlA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767988086; c=relaxed/simple;
	bh=Uo3KGKwqKqk5Kt4QTu8Ewrgwlt1VbMFM37+PHUatJTI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=vAuxm9DEK3dce1N0fScoZNL680uK3KPzS6ZCRyIOlZ90ofNYgMRapp+KidRRjh/bKtPYSKufq4ClQIoUi2kgFBIF7fL5nbdgyy9z8prx+Q1pT2QyiXcAl6tDHFFKgNAyOb9JFKYJaLoGQicfWyw57vVybaiiqByRHPomFz0BZ0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=RS21Hoj1; arc=fail smtp.client-ip=209.222.82.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11022132.outbound.protection.outlook.com [52.101.48.132]) by mx-outbound13-2.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Fri, 09 Jan 2026 19:48:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x1gVJODJef/PNwM4Ij9DFMK+AOWhkwKy7qRr4P5uWAvsQqBhvUbDWR/5PnPJs6xJlkoizvS54lp4vIrSY0pLvQ4fKfr08dXqyED7VB75rCZr2MGxZlmE5/eqAhVvpsooRXtRO/GdyO56kH+L9QAvqDG9ghm9D2PVZGmTSk32Lfttry7paU7ZMjfyBBLziyubVcIe07+9gd6TY1Y/3VXnJ6hkFEbbzOEjcGHh6v0gmOuU1mKzqDcNnfHaGIlauTgdlLHk9VTTWKPS7YRaR74XqME//rFYoCYQE3dOQhHjQ/PuUK7XREHH+4HNHVWea27WUpyaIWj67pAXednZhZUaGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uo3KGKwqKqk5Kt4QTu8Ewrgwlt1VbMFM37+PHUatJTI=;
 b=MJCgtuVFlCvuEXeFMtkJx7iecYPc/yDsx9ihkQOM2OUrZ9k9uQn62PfXqLRdx4gEyTw9HizWWCS/pYt8Ac6hx1TY/QaQuxB7WgU2khNKMsGsPPpVGwGy5tS0CBSwvz/cLRXAprbBa0ftxcJpMLwewhpxthbp3ejMiAPi+vtzYpTnAom5H0JfT3EvGuGBHp9tb7F6j0ABoq3+9XbQ/EvNcJnIBQ4aRglT0Kb0YtJG+/GUg/aYDcncIGcecc0jd/IvoDS2/W3mpC5dfr8ok9X5T57UiDZujAaya7CIFYJurLP4/FiLQGDgKCPbJu+Js8JzbmEoYV/zuqS6BO+TXfOIDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uo3KGKwqKqk5Kt4QTu8Ewrgwlt1VbMFM37+PHUatJTI=;
 b=RS21Hoj1GB2N16yvin27i5dYPP5W2yzj87YnHzKEuqTv08Iu7edlwGLOSHGdayM7wcN6BPD8Ur9OjZ1Su6l94CTTW/6gi5xcX/CEwmm/5znbWelXmjTMGZk2JGQwWrM4aamIMNNUNfPR0OXZXbIRPLhNc9LLQOEguEaVtI/t7MQ=
Received: from CH2PR19MB3864.namprd19.prod.outlook.com (2603:10b6:610:93::21)
 by SA6PR19MB8803.namprd19.prod.outlook.com (2603:10b6:806:41c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.5; Fri, 9 Jan
 2026 19:12:41 +0000
Received: from CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::c2de:bba2:8877:3704]) by CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::c2de:bba2:8877:3704%6]) with mapi id 15.20.9499.003; Fri, 9 Jan 2026
 19:12:41 +0000
From: Bernd Schubert <bschubert@ddn.com>
To: Amir Goldstein <amir73il@gmail.com>
CC: Miklos Szeredi <miklos@szeredi.hu>, Luis Henriques <luis@igalia.com>,
	"Darrick J. Wong" <djwong@kernel.org>, Kevin Chen <kchen@ddn.com>, Horst
 Birthelmer <hbirthelmer@ddn.com>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Matt Harvey <mharvey@jumptrading.com>,
	"kernel-dev@igalia.com" <kernel-dev@igalia.com>
Subject: Re: [RFC PATCH v2 4/6] fuse: implementation of the FUSE_LOOKUP_HANDLE
 operation
Thread-Topic: [RFC PATCH v2 4/6] fuse: implementation of the
 FUSE_LOOKUP_HANDLE operation
Thread-Index:
 AQHca5L6H9Qcz3ILT0uNUnhRpRthBrUkGXsAgCXNvhqAAAtXgIAAKHEAgAAJgACAAAVeAIAAKqAAgAAMMwA=
Date: Fri, 9 Jan 2026 19:12:41 +0000
Message-ID: <645edb96-e747-4f24-9770-8f7902c95456@ddn.com>
References: <20251212181254.59365-1-luis@igalia.com>
 <20251212181254.59365-5-luis@igalia.com>
 <CAJfpegszP+2XA=vADK4r09KU30BQd-r9sNu2Dog88yLG8iV7WQ@mail.gmail.com>
 <87zf6nov6c.fsf@wotan.olymp>
 <CAJfpegst6oha7-M+8v9cYpk7MR-9k_PZofJ3uzG39DnVoVXMkA@mail.gmail.com>
 <CAOQ4uxjXN0BNZaFmgs3U7g5jPmBOVV4HenJYgdfO_-6oV94ACw@mail.gmail.com>
 <CAJfpegsS1gijE=hoaQCiR+i7vmHHxxhkguGJvMf6aJ2Ez9r1dw@mail.gmail.com>
 <b2582658-c5e9-4cf8-b673-5ccc78fe0d75@ddn.com>
 <CAOQ4uxhMtz6WqLKPegRy+Do2UU6uJvDOqb8YU6=-jAy98E5Vfw@mail.gmail.com>
In-Reply-To:
 <CAOQ4uxhMtz6WqLKPegRy+Do2UU6uJvDOqb8YU6=-jAy98E5Vfw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR19MB3864:EE_|SA6PR19MB8803:EE_
x-ms-office365-filtering-correlation-id: 44e79874-5184-43b7-e7b4-08de4fb30faf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|19092799006|376014|366016|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?Zi82R2ZiOGN1MjY5Mm0wN1BZUVVvN3RIUXNuM0t2bkJPVjFlaXZkdVYzNG5I?=
 =?utf-8?B?aVI4OTJtRDM5QmJrdG5wMGdpcXhTdkRNN1Z5L2hUWWdLa3ZvRTE1WUp1eUhh?=
 =?utf-8?B?bUpqTDFoNzk5NjREaTdMZ2tHUEh2RWN3Zk5lcjkxVGk2ak1OL2dZSUNQOUVv?=
 =?utf-8?B?Tk9qN0lXa09sdGxBMFlkNHBkeEdPek9UdExXci9uN3UvdVZWZEhwUFRaRXIz?=
 =?utf-8?B?Y3RUMVhXNHdkQmhHejlnc2ltRnNUcnNnVW9ITjBZbDRzMnBPdnkrVmUwVHhs?=
 =?utf-8?B?a1lad3pVZ1RDNWlWdlMrZjZDalVUcUpNd1hTTHF5UlkxaGtZUGE2d1Fsd0dY?=
 =?utf-8?B?ODFKWHhXWjNYelNWVzJQNlpUMmF4eGxVaEozSFhVY1k3NWRBWWFlZFl3R0lD?=
 =?utf-8?B?RnBMUXozK1N4bXBXZHJxSTVNVTFaT0FBeGRCRW5qVlV2WjdqdzlnL2VWSzdh?=
 =?utf-8?B?bmd3STlqYXJ5clhndGRXYnlmak43aDRTQXRhVyt0ZmlnbVdyLytHdlc0c2U4?=
 =?utf-8?B?dkZBWDlyYk9KckJ4SGR6NExlbm95RlpHazRvdkpzOFE3dUlKQzYyL0pzTS9v?=
 =?utf-8?B?U25Nb0x3dFJlTjI3dTlFVElMUStxd0ZPOEpZcElvcXZWOHJKSkV6NnY5eWk2?=
 =?utf-8?B?Q3lvcDU0QjduYUtRSmxrcDIwRlZ1R0NsL0RZcjdiL1Exb3V0cTJmR0FMd0Na?=
 =?utf-8?B?L1dvcDliUjBYYm9sOFRxVFg3aWlrUzJ2djZ0VmxpcFNtbmxjVk5Yb3VXeGFJ?=
 =?utf-8?B?K2hzc1hQemFDM2J2YXVNZXA4WDB2aWJHSXhVc0xFZXR2SFVDU2NhV1d1UzNS?=
 =?utf-8?B?OEpBaExsUEoyd3FHRFpMdW0xUXY1bkJpQTZvbTFCZ2NNMm9mYndxUURGY2Zr?=
 =?utf-8?B?dlJSN1MrVDhKeks1dzZHMm1EM1hoYjBpVkdpSU5lQi9zYXQrcTM0Y2FZaE5q?=
 =?utf-8?B?SWVPT0dsb1VJZGoxbE5nUnJPcThUZm9VUmRWVllIT2QrcENRUE5YbU1TN0xD?=
 =?utf-8?B?cEJxUnRDMHJkMjNQRjM4WGpvVllDd3MxTmxKa2ZFbFJrb3FtL1dIR3JiYjd3?=
 =?utf-8?B?cTYxbDBjSVhTS1NIa2xzSXRPbDk2b2NrdDNEVDRGSkJYU2FvTFA3TUQyYmEv?=
 =?utf-8?B?blJ1RDdWRThmVVl4NmppNEJFamJZQjk3bUZhRUgwVGpCYTMwTTZ4clRwRkRi?=
 =?utf-8?B?aHMvZjhhMGZlZERjeldpZDlYdi8zaVc0WDN4MXZLMlFSdmI5Q1RGbTZFWFF5?=
 =?utf-8?B?Nk1JWkhnTk94bXQ2aCtNZ2I0WUJUYkY1V2dBNDR5YzFITC9hbHc2UGxKeHky?=
 =?utf-8?B?by9ZTERmenVIMnl4ZnBRR3VrV3ZVMGFrdFc2ajNkVVNLUm5iZ3NSb0lEOEs2?=
 =?utf-8?B?V1RUem1XaThmTDRjU1YxSGtxSkwwQXBtQldTRTJlY3ZManpoTUcybHl4dklK?=
 =?utf-8?B?dDFOeW9nSVUvalNSNUh6QnNvREZyM0Q0eCtFMFhIWVVYL1FjcmdoQk93eERl?=
 =?utf-8?B?NnVkUkNweE5neXVTclFoQmttM2FvSGZQWVpRa2RrakxZOUZDQ3B6VlFQT3ZH?=
 =?utf-8?B?ZGxweE9yTzJYalkwN2toNFpDOEtmRDgyVnFFL096N0psckpMWlV3eUE0cEFG?=
 =?utf-8?B?QVp3R3FlWFFXeTZGb2RQOTFJV1FQbFhBMnAxMGo4cGNYQ3ZET01oNW1iNThp?=
 =?utf-8?B?QU9LUVlKMW1WWjFoWUZOWkpTRmFseVdOMGJpdlJPbWNxMFlaVXAram1qb2VU?=
 =?utf-8?B?NVNCT1c0dElJSGt1aEcyNVlGNy9peU1JTUpuOHpseXdZTENkV3FmMGlPWCtJ?=
 =?utf-8?B?ZFUya1FpL3JXVlhRM1FNYzJUSkQ4d3djNjUvZ3I3M3p5WHIveWlySENuL2dw?=
 =?utf-8?B?VGZjblZzKzBFSjkydWdnaEJxOWZscERqUUtLTjJwLzVkOEsxTE9sTkFQMldW?=
 =?utf-8?B?T2xmalROTDVBbXFxOVpUcHJ5aGwyckdnUDZlVVBxeUg2b3N4Q2pJc2ZMK3l3?=
 =?utf-8?B?QkYzNGFucnZEQ0NHSHIzRzdyWWpaZlBOOEZWUWFidWlIVHZnU25FZTFkTnAw?=
 =?utf-8?Q?xat4VU?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR19MB3864.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(376014)(366016)(10070799003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Wnp2Q2owUWhZQ1RJbGg5QVRsSThad2pXYVdvUjUwWklYdzRqMkRjdkxLRnp0?=
 =?utf-8?B?MFdHL3Z2ZXRlaTljdWJUTGpzSW9VQTdrcWFqTkVuSTlIQU9kVFEvRm51czhx?=
 =?utf-8?B?RUFRb0VBT1l5UXNIOXlKc3l2U1FRUEVISmxkbnRqYzA5WGpydWI1VnZnVy9C?=
 =?utf-8?B?LzdxZlo3NUVtTGZDMWNXK3BwK3lqMEtuaGloOXcyL1g3aUdpSloxT2NXWkZv?=
 =?utf-8?B?YXNWY0lNOVlFRCt0NzBzaG4vcytlWit2dTh5eTVmVlU0ZWlVSEdKaGpzeTh3?=
 =?utf-8?B?WWRJS1R3UW9tOUdjZlpOUDhDM1o4QWd5YWx1eGhzL1JlUGl2QlZWU0E0dkhr?=
 =?utf-8?B?UjdjN1lkcG5EbFBFcW1rZ3ovcUo4a1UvRVloMUFLc0ZOeS9pSGJrUnVNRHRl?=
 =?utf-8?B?dnFlZTlESFhkMURMZFhjMlV0dDdWMGoyOGRRQ0pEZDNSR0Q2YjdLc2lXMHAw?=
 =?utf-8?B?WmI4bmQrVVJwSFZIOFN0OXZZVzFYNzdlRFo0a1hOSDV1TlArSm1yMk11aXJp?=
 =?utf-8?B?L2pqRS9vSDBGanVwZEVIdlNBREJpOFRqTGFiMmtqWVY1SWhWSk85WGQxM0lX?=
 =?utf-8?B?NkxQc3FKdUNzWXVYOERMaVoxR3RhNkF1ZUMwVmh0Z1VZaUxtQWgxK1dNK2lK?=
 =?utf-8?B?dFduR0MreGQzMiswQkl3NVlRdVYyeDlydmM5TUhkZWNTZDBxTWxjNlVFMzFR?=
 =?utf-8?B?aXdqeTRGYm9CQ0RFRVRTUlYwSy9UTEhsYXIwdTd3bU9Wb2QxVVFEdXVybitG?=
 =?utf-8?B?a0hKV3dCbExiNTJBNDJHclhPa3hiZDdCdzJIaTE4a0tvelZFQ0xOU2xObDYv?=
 =?utf-8?B?L0MzbHNQMkhvTEgxdEJqeENHSFNQSWNuUGMyekRQUTNhUW1OK1pUYVhMR2xy?=
 =?utf-8?B?U2ZSc3dERHBQQTFMUzdjbWJRcjhKT2F0VGJpc0p3L1liNUVtYzRyL1JXVG9Y?=
 =?utf-8?B?clJ3K3E5OWRhOEdaakRUeXJtUkRkVGdjeGJ5ZjdraEJuZ2xGWmdZdi9KdHNP?=
 =?utf-8?B?RnR6NTdzcU1PVXVxNXF2MTVDRGhwRkhjc0s4VmNtcUNpbGtTcmpyMFp1NTZK?=
 =?utf-8?B?Qjl5bFVoNmFaUXFmNXE4TGttUVJpUVg0N0IxZVJIQ0t6V1RvMGZQeGRZUmR1?=
 =?utf-8?B?OWQ0OWJyQ0VPR0RTQ0NLMHlsRloxdDdNWnpkajlleXFwakduajdRQ0Zxbi9G?=
 =?utf-8?B?d0JCZEJwUGNURTNxZW1pdXRzemZ4YTd5R3JwZ2M0VWNNL05IYTQ5UkM1VDg2?=
 =?utf-8?B?UEExTEo0clBrYjNjbzJVakFHK1ZlUVpIMjZPNkpheFVNRlZJeDFqRXhsM01I?=
 =?utf-8?B?YTcxS1R1dWFHaGZyTkFlb3ZGaXZjM3NlbVdqcGZlblphQjRGZzVUUnBVYWkv?=
 =?utf-8?B?SDdKeU1rVEt5YkpWOGZPTllLYTdocWtDd1JSVm0zQWU5dGNSNkYvOGtCUjJz?=
 =?utf-8?B?cmhlZ1oyQmpJdDhWNXJuZ2laNjJ1TUxTVmVoMFlvRmk0OGNGUU9mUVRUbmtY?=
 =?utf-8?B?UlhLOEN0STFIczZzSU4wRlJNSnIyT2R6WTR4RCswczMvV2dRSFpXbDRxemlw?=
 =?utf-8?B?VVpsVktiRUhBaVFuUkZ3dXZXS1kzUnZsY0lxc1lPWER3NzhnNy9wNmExZi9Y?=
 =?utf-8?B?NkVwZjk4dUNjR1dzWWxlbjFGY21Pc1dWbnFwd3R1K2IxNjE1NjZ2TUZFOWlT?=
 =?utf-8?B?dTlpbGs1RmczWElVZUNFR28yN3BBU1J2ekFTRUFsM1JqVE5vbW5wYWIvN1hv?=
 =?utf-8?B?VWx5dHpIN2Z3L0hPVnAwWUt2akM2cmFLQU45T09oRGp5aUk5Y1NUOGJuU3Y5?=
 =?utf-8?B?V1lqeS90eGdKWWdtNFozaWpnY1hKYmk5dWRuYzFTQzk2Sng1aStJeUVRY09I?=
 =?utf-8?B?eU1YaDYyN0lMUEtBditUL3N5blJaM1dyTU5Mbnc0L1FWb3pLYld0YVdkV2NJ?=
 =?utf-8?B?ejc0bHhlSmh0a0VHUXhCVEFJUlY2Qy9KYkVTNkZtRVFycGtQNEFRcUxVandZ?=
 =?utf-8?B?eW5WTm1QNWIybm81K21rdmVXY2RhNnluSTFTTjNBQWpNdVBJMmdYd2s2VGl2?=
 =?utf-8?B?bE1YVzk2SWlyeVNKUy9USGgxWmVURCtHWDJBS0sxdkcvQVg3c1c3UnMrbW8v?=
 =?utf-8?B?WDZGS2lhYk9NTlg5UUFwZlZ5NHNUcFdpdVV3SkJHcUt5c2VmSXBvVEJSQ1Ru?=
 =?utf-8?B?MzZaQ3k5YVBZNGtsY0EwdHh1T1BpQjMwRDdhby9BRE42c0FGdytkdlpHdnlm?=
 =?utf-8?B?d0VrTGR4U0g2eEE3c29RMnhKTEdvZU1kOEN6OUNzOW4zSEduRUszTWJkblFZ?=
 =?utf-8?B?aEU1Uk5jRithQ1RMS2QyK3RwUjR4TnhjTGd6aUtlT1dob0x0YldmR0cxbWNU?=
 =?utf-8?Q?VNZCn1HJxp/CNabV6OyMBF1Bm1nXsyKrnsRSI?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4A1F6876684B3B45A133C991A744B4BB@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xwn5ax8SXeXc4VrXYraW4GxX/pC7DdRifzMYDFlbJ205EWs//DNwU9wbhe3tx7oW+I+8QClHcawypPb65R21exYaSY7Mp5e45KjD1ISNwYyOdv4Q4g6SLTuo/WeBs8das6CdhPErPaoBO5i4LAujrpNulsJmXcLNw5ipsnjb8Y8dMlvffh78KbULQYSo3Og8DSkzAMhsQndVDKwRRWBbRyjGhoC9xnRHWtYQ3ouHkZ3GgEfdGithWRXReGVvITHJXXab5I57d+1+WV4OJY/QHaQKo+7u66SrlPEDSIN0PvyFgDKmzl5rfAyjn10UlhDO6+jQE+RFuHJzlfUfIBUYz4tYvs/H3TeR2zmiTbEcDfblrN8+Zt3d9QZaF6RjEKFwhpKxPTo5rk03HnLlHPRQJsDDHk2vJtL+1rIHAA0/VAHm4vewUlvNWSBv69/FQ73uR1UethXxxZoq/v2qFDkFHB8lXYXccw+vft/jJUmKQVWxrM2jgpN6xOkDQkraZ0UWi0k36YSp98tZng8pB9g5Nmp28nFIte4owkcLkDNFYuBohKjCu6hYd06mZmkdR+jfj2xf8aocWAlrzFWs0+XQgk8NQZumYmS4n67ZUKiSz8lch7wntgZb/dpBCN94cHaKxubI8bgy3wkzTTLwAJiYkg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR19MB3864.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44e79874-5184-43b7-e7b4-08de4fb30faf
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2026 19:12:41.3752
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XqQcWmQuCpqNoXkDYbz56i+0vv23Ht9XQdBuETDrJONE684mZCN5guTTO9CBjE1IAjXND9+4foLrqMrbn6YaCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR19MB8803
X-OriginatorOrg: ddn.com
X-BESS-ID: 1767988080-103330-7675-11416-1
X-BESS-VER: 2019.1_20251217.1707
X-BESS-Apparent-Source-IP: 52.101.48.132
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoaGFmZAVgZQMC01NTXFyNgkJS
	XZ1MA0JTXV0CAx2TAp1SjR2CItOdlUqTYWAPiIJ65BAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.270279 [from 
	cloudscan8-105.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

T24gMS85LzI2IDE5OjI5LCBBbWlyIEdvbGRzdGVpbiB3cm90ZToNCj4gT24gRnJpLCBKYW4gOSwg
MjAyNiBhdCA0OjU24oCvUE0gQmVybmQgU2NodWJlcnQgPGJzY2h1YmVydEBkZG4uY29tPiB3cm90
ZToNCj4+DQo+Pg0KPj4NCj4+IE9uIDEvOS8yNiAxNjozNywgTWlrbG9zIFN6ZXJlZGkgd3JvdGU6
DQo+Pj4gT24gRnJpLCA5IEphbiAyMDI2IGF0IDE2OjAzLCBBbWlyIEdvbGRzdGVpbiA8YW1pcjcz
aWxAZ21haWwuY29tPiB3cm90ZToNCj4+Pg0KPj4+PiBXaGF0IGFib3V0IEZVU0VfQ1JFQVRFPyBG
VVNFX1RNUEZJTEU/DQo+Pj4NCj4+PiBGVVNFX0NSRUFURSBjb3VsZCBiZSBkZWNvbXBvc2VkIHRv
IEZVU0VfTUtPQkpfSCArIEZVU0VfU1RBVFggKyBGVVNFX09QRU4uDQo+Pj4NCj4+PiBGVVNFX1RN
UEZJTEUgaXMgc3BlY2lhbCwgdGhlIGNyZWF0ZSBhbmQgb3BlbiBuZWVkcyB0byBiZSBhdG9taWMu
ICAgU28NCj4+PiB0aGUgYmVzdCB3ZSBjYW4gZG8gaXMgRlVTRV9UTVBGSUxFX0ggKyBGVVNFX1NU
QVRYLg0KPj4+DQo+IA0KPiBJIHRob3VnaHQgdGhhdCB0aGUgaWRlYSBvZiBGVVNFX0NSRUFURSBp
cyB0aGF0IGl0IGlzIGF0b21pY19vcGVuKCkNCj4gaXMgaXQgbm90Pw0KPiBJZiB3ZSBkZWNvbXBv
c2UgdGhhdCB0byBGVVNFX01LT0JKX0ggKyBGVVNFX1NUQVRYICsgRlVTRV9PUEVODQo+IGl0IHdv
bid0IGJlIGF0b21pYyBvbiB0aGUgc2VydmVyLCB3b3VsZCBpdD8NCg0KSG9yc3QganVzdCBwb3N0
ZWQgdGhlIGxpYmZ1c2UgUFIgZm9yIGNvbXBvdW5kcw0KaHR0cHM6Ly9naXRodWIuY29tL2xpYmZ1
c2UvbGliZnVzZS9wdWxsLzE0MTgNCg0KWW91IGNhbiBtYWtlIGl0IGF0b21pYyBvbiB0aGUgbGli
ZnVzZSBzaWRlIHdpdGggdGhlIGNvbXBvdW5kDQppbXBsZW1lbnRhdGlvbi4gSS5lLiB5b3UgaGF2
ZSB0aGUgb3B0aW9uIGxlYXZlIGl0IHRvIGxpYmZ1c2UgdG8gaGFuZGxlDQpjb21wb3VuZCBieSBj
b21wb3VuZCBhcyBpbmRpdmlkdWFsIHJlcXVlc3RzLCBvciB5b3UgaGFuZGxlIHRoZSBjb21wb3Vu
ZA0KeW91cnNlbGYgYXMgb25lIHJlcXVlc3QuDQoNCkkgdGhpbmsgd2UgbmVlZCB0byBjcmVhdGUg
YW4gZXhhbXBsZSB3aXRoIHNlbGYgaGFuZGxpbmcgb2YgdGhlIGNvbXBvdW5kLA0KZXZlbiBpZiBp
dCBpcyBqdXN0IHRvIGVuc3VyZSB0aGF0IHdlIGRpZG4ndCBtaXNzIGFueXRoaW5nIGluIGRlc2ln
bi4NCg0KDQpUaGFua3MsDQpCZXJuZA0K

