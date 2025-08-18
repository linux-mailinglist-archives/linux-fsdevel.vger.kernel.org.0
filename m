Return-Path: <linux-fsdevel+bounces-58131-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92CB8B29D62
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 11:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 135262011E7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 09:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0DE30DD21;
	Mon, 18 Aug 2025 09:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="UWRX0L/W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C09A307AEA
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 Aug 2025 09:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755508459; cv=fail; b=YJSGyHQuncDKKzlotQerV/yhMG37mqbB5IDGxRIb0mPgsZzonrjBrS7u9dW5iihWczZerQ2u8XNbqDEVM2PcDPMUtRWmaUOr3d5hKgJNO6+8D/CtWIr3gL1c7Ey3ALMcY7+CifRavdT6WxJQYO3CXUYcp8gBt8FEi0T8f1Xn5a0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755508459; c=relaxed/simple;
	bh=eBYIHRb7S2weTlKo8fmXUfJf338ZNu7HzLc1sSDvzZg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QPYErZqH8+LZr1Q1N8SymhrBLlU6SPSWhhL1pAhLp+RxgbwQpbyNMWxj9lDOTisddNkSTTwS6r8ZCVvlNkBtzu68ThiNa86UnPuGjWpNCQ9oHUA0L1NodceFT1aUQ+HnN1tOSpHApt6FpAl9zA/Ok+idA7hjEE3ICA00gvjocFM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=UWRX0L/W; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209326.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57I3VmoV010432;
	Mon, 18 Aug 2025 09:13:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=S1; bh=eBYIHRb
	7S2weTlKo8fmXUfJf338ZNu7HzLc1sSDvzZg=; b=UWRX0L/WOEhb605gEemfeFg
	UFy2ZnbtzBTVmmBlFo3SisrDpA6Qcr1cOrB5Ddt0Z1cc1E0N545X9rgSRBp38+YQ
	EJQEkBGpPJE8i+D/GdY4rsplbQQxWc5SZhZ6nGQbu2yHi4f21XrrW2Az5RhLE1Q7
	W/xTj8vzBObOsUJn53ilnd902lLQosJoJCumE6EFUvQ/PcSXtJ5RUKvBSrF4OfWA
	RvG4Han/BWpjKz9Ih2i+ezbUBHNFHanXbp0twPnxrYKnr90Z4Kf7n6nbeFO6NXVi
	E7Dx3+U5Gg+qgAnqQR35X950pE1JeygjxK6ZctUAPwBtNUUb2TuGdEBMx0ZMnGQ=
	=
Received: from os8pr02cu002.outbound.protection.outlook.com (mail-japanwestazon11012061.outbound.protection.outlook.com [40.107.75.61])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 48jg6f9mx5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Aug 2025 09:13:55 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xhv8kex/zFgMUb2Py6ND4jHj/5lAH7vtfGPjXELlr8JDxhvFLZMnurOLEffYxOYaO+2/tkvpuIHpjx+HtUNybBcK89A1FcOSXJmhJ49rSHHJKK1ORdP59d3bGzJduV/GM7DmhkfDcTD9lNv/GBuDuG53vSvEiX/mfA7zvvtS//Byvy5yHWvM5FFzsr+sCmqCWrm79VlEbg7g2D7JFZqKZYJhBVcl+1J00ZhJyL0FTRk9dbnwzmW3FvCq5SsIaAuHeTmCXOF/6bWC41OrYJ5EuSNi+GK/6QlaFQahkmNIaSyPVa6wWkEGzrswvfJ00HMGrZ+UdxSfdKQNEiKC5EN/Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eBYIHRb7S2weTlKo8fmXUfJf338ZNu7HzLc1sSDvzZg=;
 b=k37AppC7gE6aP+F858a22eewDGQuCR+n9JZ5GMPUQKOn5i8ZFfrlMK5PTJNbsZuG47MIMrQaUOOHQ9/hWJ59yVq3/Q4T1vXmg07js5sOOhUrlPwiRSgTuFAzaJitjcCsGh6f7GX1fJ1gL/V2m1U6Jw3X0a0OW/fVUZZcc8rTN6Mkj4BM/CiIDbZmJTJOZIMvlKouxt8jCHI+YdraPLfPxSSP/WmTQi/7QOIQWdXAtRcJn3bbzcjFTRJSurb2w+dnjYuxZ3sZNlF2LwAfHgoe+eZcT19/8kmZhjeBffglqHpl07ugic/Yk3hZRFKzmQhLqdAYQCmHnb5gXzONfp9rXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by OS8PR04MB8123.apcprd04.prod.outlook.com (2603:1096:604:286::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 09:13:46 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06%5]) with mapi id 15.20.9031.019; Mon, 18 Aug 2025
 09:13:46 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com"
	<sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [v2 PATCH] exfat: optimize allocation bitmap loading time
Thread-Topic: [v2 PATCH] exfat: optimize allocation bitmap loading time
Thread-Index: AQHcD3G7HUibtZSpmEKyYNmxeJ0R7bRoIXyM
Date: Mon, 18 Aug 2025 09:13:46 +0000
Message-ID:
 <PUZPR04MB631618145EE52A86C363017B8131A@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: <20250817122239.5699-1-linkinjeon@kernel.org>
In-Reply-To: <20250817122239.5699-1-linkinjeon@kernel.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|OS8PR04MB8123:EE_
x-ms-office365-filtering-correlation-id: 1b6e342d-6f45-4bf2-a652-08ddde378929
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?OniyK6iUA2iMkeUZViDIe4XSn+AfmApZfr6ijSJX0BKPdnXSMtVa/0HDc1?=
 =?iso-8859-1?Q?+sGiSOy7jAnqLCagPw4Msy7/PSPFwpbDrtmev4D+if4X5kInFsO3nT66y8?=
 =?iso-8859-1?Q?D7/FZTYOMfd6i01Dj2w5z4emSTAsH2yMrrIBULQDBUX5u3Y1mB2MThfqui?=
 =?iso-8859-1?Q?1nXvC+xoxAHHEs0kMKrVZ/VnvCG7VB8CE2vKjN/h0fhAfSmdsGdO9gdVt7?=
 =?iso-8859-1?Q?SF/4TirGM5GgVpU1Eqnuv/xeeJF6F/yZnPKqaK65Tto9IRAd9JLBEYfd6n?=
 =?iso-8859-1?Q?bmvzoFX+e4RQ8TFrcjKN8OqhahtZPi33cBtEQS+sl4o7BPQSUVIfT9vUmN?=
 =?iso-8859-1?Q?uVFcCuDKJQrMxnK7bzb0XB9GD3u/2iq+qbD4ZV4El60vTf6BfBmH9UegPB?=
 =?iso-8859-1?Q?z1XCz7W7FXlmyu0hDpXKpEw8iyhmMiUnzsYMdSK5pdCboxJ75xV3i4RQVX?=
 =?iso-8859-1?Q?z8jXEPFawJx0RRdqJLmqxpebtB3JWhJtM79hz3V+ldOz41HfewoqLrgpUF?=
 =?iso-8859-1?Q?0lLqE8e4PxuKKeh7DPTotmuuH9tauT7/PEpUnIWEWDNNk92J/+DHdrZ1QE?=
 =?iso-8859-1?Q?zlfY59g4ZvK6nyDjcbC0bR1oqh0EGliGV7HvHwzqYMb4j7etJwDtrpVS58?=
 =?iso-8859-1?Q?vkc15aVPwq9jgPbf2HjeHsxvfMcCTdqMG/OY9fsLAQ0nbOciU7Y+KhZ8E4?=
 =?iso-8859-1?Q?jR1gjNrz35HPjlrIskhe2dIpLEiD3/bsf8DFOV3JwEaFQH5BilQAbEDGpg?=
 =?iso-8859-1?Q?1Wach55EEk5GQ8YJkgZYxsKIoxjOtYnQupjUTNSS8pgHxO6hjZ1s4f8nCW?=
 =?iso-8859-1?Q?9VU8N6fSmxjlbqFczgYFNSQZ3ARWkVS5S1KFgFvbJw1nESnyWDybdyxjcL?=
 =?iso-8859-1?Q?vH9FmhRmGnb4owsN9BGkS6dqjK4NzIB/mUIFoK99kRWHFKIUdLAu7WV1F3?=
 =?iso-8859-1?Q?SffA9g+vwH2fGqV4uuHu0ByIeIIjqu7iGJ+eEOaMvaOtWZYzBmyJzw/8Jd?=
 =?iso-8859-1?Q?jCetg6dOG5hqpc9b3oHKAK0XszQ4+iVGYvsb+IpD3czjsYhsb1R+qwpr7Q?=
 =?iso-8859-1?Q?ApkVHROJfzTfB5BJKUOc4/mb7sJg3/efVkle2BUbICl2oKJLza4vEM18Fr?=
 =?iso-8859-1?Q?IqCwffVhTG/5ybnwUacel+axFWp1GlwvNemUwvPCMMAS4MqrClbP33oue5?=
 =?iso-8859-1?Q?T2Sx31xar3klLRhzFtf8xXopPHIa3q0SOEEdlmWyyz+LWXOOlAYZXNtVV9?=
 =?iso-8859-1?Q?YVY3fmVR7bO4LAPLUKcZY2+cFI9m7E3SHOiq28cJsSDtAdQNPz9Rm2D3v0?=
 =?iso-8859-1?Q?lwcQgX4iuL1+TtYiyAPCfh8vKstb+WUm/JT21L58Ul1ZPdT09VBEiocabI?=
 =?iso-8859-1?Q?Fi1lX/+HR1kEuQqabTo47jcpIbznO8SKdPEWR4f83J3r5E7R/hPv4AECfB?=
 =?iso-8859-1?Q?SD4A4lv+ob/VN/xQ1mTURZrytahy0XI1pmrrJ9ptBNR2X2404RH7FlK9Ez?=
 =?iso-8859-1?Q?Le/SXwROyuXXxjRsKnVi1LvWdVDEWL5zdZYRWPR1YhTqCmSKQFVMJk6b62?=
 =?iso-8859-1?Q?W946zR4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?SFPOkpwxOOsLKIQPXG6xrzvFIMQs0/xX9rZCjBKsgcRzFBVEeUSMmTgUBw?=
 =?iso-8859-1?Q?buN6UwnvL8JJ8MBrxvyKSCtiM9Bhwu3IPx4JNPesQCvGtHrBaamXLZN3Xl?=
 =?iso-8859-1?Q?e9oC9/VeCxYuaTMc+ITWCzQLA3PZeJkZWsEkYMft4VsAXKVsJ13dvnHWxk?=
 =?iso-8859-1?Q?NXFjUE1zgWMDQX15q6mnZc5HYyO+eBubB1I43kzT3rJPv6ZJI3qbdzoQ7g?=
 =?iso-8859-1?Q?lfm4vcOCn8ypLMqAuPJhvYhpScywLWz5IQ7BXAWtYJQlM43s/OTp0MaZ+M?=
 =?iso-8859-1?Q?tH77tjpg+BiZ7XGDPGXxHov//LV7Ysd4shbZox6rrZewdVyuyPna+UrRIa?=
 =?iso-8859-1?Q?e8JsUu0vlzxelMfIjHZhxD4VGp9pYGXKNyDB9SHa4KCsqtbsFN/02LQX98?=
 =?iso-8859-1?Q?7kMmyV1hzU63AiLAdQ0/l3w+sMg0RJmUUbHM2hzeSRKNR6nyEYZy8zd6K7?=
 =?iso-8859-1?Q?fMuXy4FNKQdIjykph3yJwC5LToa0il6s1GApkUMfspTnrii9peo0wIuBpw?=
 =?iso-8859-1?Q?bcGPeXDHB7e6p0JqhfgIG/lw2qIbT110VP+tuBRW5T2bpC6BfiM+lTbLwa?=
 =?iso-8859-1?Q?9MIaaOVK1cSand49DxR4dU/ula4A+RyVn005LvbdKsMtsT7ZLFk9FDYnpP?=
 =?iso-8859-1?Q?Sw8cul4TtQIL9MIygW76PYOGHflHbRlXDK/gkGblAtJD7ns4LgYOrE+9o9?=
 =?iso-8859-1?Q?vj3nwCb/dp+0ybpb0F7Z67R+mu6Jt8IQBAPaTjjK/VNEkBrcvrSm34U76h?=
 =?iso-8859-1?Q?dVHB7zn/bcBriTO+gipCQzl/4I2xQ8ErFLscwG8kjrkC2HQVwdElcB83ax?=
 =?iso-8859-1?Q?Cz62Jkb69DhUM+LigMy0lOt9OHgcyCEYiMy6caFFotdlcLE2DQ1Phd30pa?=
 =?iso-8859-1?Q?vpXq6jbPFc+3pyAH8PJ32ZVQZhn6Ee9ntBI0ZMPFkIRYNclfqQuxeYgeNv?=
 =?iso-8859-1?Q?h9A/1fnJd9N8qImuMH+qFB5RR35QvkN/w3lh0ETKslpBe99yXQEOHJh6I4?=
 =?iso-8859-1?Q?RTea+lzNRgM2bex7BDhDYHk9RTWC9tHdrAChbiVPgXNF+0BjiOPtwFIoGQ?=
 =?iso-8859-1?Q?RA4zTtdU5Yk51H6i2m6XSm2gREMZJmF15DYXqAJhl1Ms3HAA0Oaxqcectl?=
 =?iso-8859-1?Q?e2W5D3YDDPmuQawDtp1E5jq5BJDudrf2VQ8J4ai0noyzgGWw2lQQiBDyXM?=
 =?iso-8859-1?Q?h7KlEsko+UFvbnS8eaeDqgobGvRadXO+am8DnIkPOxWjbrs1MXdAD22OuG?=
 =?iso-8859-1?Q?v3g3F58w3q8f77AtFHkgiinqnrM6sd1uxqM2F4vb6dyImik4VZcRGdbAZP?=
 =?iso-8859-1?Q?0aLSNffwFM/TyEBXM1wRfNLK5PwfmBL6jBRh+5gYLoWGwQ7/uTIZCK8+pQ?=
 =?iso-8859-1?Q?M85lDbq2DynVxqz9po6rWcH4ugTGbQqofGFdEcylyCrb8HUOitcuKd2gnC?=
 =?iso-8859-1?Q?PpPpyVce9yNRP5nGq+BK/oTsJRNaBWwDguQ0cHHf0jgZ5sHLw9jRhqbqL5?=
 =?iso-8859-1?Q?CpIQkRnBXDnH4Xx7b4CykdEctsRZzP5DTuwt8UPGLWcBh9X8JinvFskpqe?=
 =?iso-8859-1?Q?VIvuv2+fM4+3mjGA50rLiWEKW18zsVCsbkZqDEyaiwK5vC+8js4TNfsw6U?=
 =?iso-8859-1?Q?+pEmvP58YQEHNWJmH+Yn5Q27ErfGJ0e67nDzhilVRFA12T3ckD5X3tdNv2?=
 =?iso-8859-1?Q?BS6HPBcwcpxVMf04aVk=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dN4w+VCuprSSo0YHuFoSElD/JBYqM6e+Q06HuF1NC61jxfxqAiAc6sGTD+iI6sl+jfUVh0YYd/y7OwBgJN2RY5mYGq3BbdxosV9DyQbKFBRvz/YRvG+UuUUsVMaI0R3IFhaJq0iAtKqFuhpo4scpZIeRZywhXNlhAE/zTKiXdMfY2IXvQbpRKoZNLZYzdbIusfHIHqqNJtm0hEDu6xsjZW/sgPNMjBMmt1i6s8DZ7MUBviZx+s2OJNZsIZw6l11n1Fsmf2rYvMALcmCnEgcEw9nnt+I8h8BgZdEdX8M7aYRmLvc9Jw6jDBJ6AzSH6z3+EL2U0UScaLwvn18wgjShfGpP5zC0M804f1q7JWz9tCk/CeDWi4yS4GhLarnzlKx7EEaLils/6gWCuFodqGUaw7abaVmmvJGXyOgg++Vcs4ubcmZMW7ke1q3z2ex6G3G9BkR52qqKrSgoc+SpnzAMCWzuVjjE762n44bWecYFAH801kr/Mfr+0e7VBh+yD+OkGNOyn/OofLIb8VB5z9EMEwTWdcxbBVASuvwxHaJOcbSWGRgYiuWB2VwHxFnAghkxJMe6vz/BtgNXf3YsnWyELeYXXVm40G/oCGGQU+3wuA09b4zniMLz8lp8kNsAKHiq
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b6e342d-6f45-4bf2-a652-08ddde378929
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2025 09:13:46.1735
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o7ZdR2mkhlIDFbxR/4QjHkJMe1ioJMzifkoTre1pUsEt1tk3UmQu4iC66kJeFn150DzmacHCc2NF00wz+myqvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS8PR04MB8123
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAxMSBTYWx0ZWRfX/AMwnPu9WfGL CG6skqM57NmlDCBQ1gjM//Qt5uJzQgwlSj92qoXk4xn2+PH0OURqzfcfl3TJfpi6JUp7kRiKvcH JWl3iEm+UHSt9Gv5g7OGQeHINHwJ1l7IygZ2IhE7+Rz9uRaOtJ/YFRpbYNV+cL7R3FaaNI5btNr
 cnMhg4IK30g7muODmasYLW2QMmiAA9vJ1UBbHzUyV5epFOjWc8bPLdUxkg46gs2z01RA+4k10Fl odGZ7UDu0NAAPkii7uluDwvu7LKZe+FmoLc9Z61CxnKmMNRGjPB4dEkxt+iCOO2URgB+5NsTjnP 9dlEmx0rpCLd9STjBl/k2j308757PLvljcGP6PrQaJf/ToleEf3ZlrDi2FPkzjLpzc5kKonUY3k yWeRncc8
X-Proofpoint-GUID: PahvWKB20hPPMn38tCs--FdUDkbAc6hB
X-Proofpoint-ORIG-GUID: PahvWKB20hPPMn38tCs--FdUDkbAc6hB
X-Authority-Analysis: v=2.4 cv=VN3dn8PX c=1 sm=1 tr=0 ts=68a2eed3 cx=c_pps a=w9H+tr4aW3PjTjxc+w6/Cg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=2OwXVqhp2XgA:10 a=7j0FZ4iXMVMA:10 a=xR56lInIT_wA:10 a=z6gsHLkEAAAA:8 a=TSVp5swo6LpNLtneyT4A:9 a=wPNLvfGTeEIA:10 a=hjbc2OpvlusA:10
X-Sony-Outbound-GUID: PahvWKB20hPPMn38tCs--FdUDkbAc6hB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_03,2025-08-14_01,2025-03-28_01

Looks good to me.=0A=
=0A=
Reviewed-by: Yuezhang Mo <Yuezhang.Mo@sony.com>=0A=
=0A=
=0A=

