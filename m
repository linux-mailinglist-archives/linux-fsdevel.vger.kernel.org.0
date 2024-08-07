Return-Path: <linux-fsdevel+bounces-25225-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9266C949F53
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 07:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E37DAB259BA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 05:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E22A19753F;
	Wed,  7 Aug 2024 05:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="QMr6QKCQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF53558A5
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Aug 2024 05:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.30.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723009560; cv=fail; b=jGPpJkteellJWX1HQmOiUmyhMmQJrBJWkbagz2nmuwGlec3NZ1WLdPzXQOpVamTNYAHtgJniwK+jT4Hl2llbrKgRf6lvO1gCEsXetUugJt40FkWxiZZF8Y/F2qIL0/UWcNdaHxG4XN2bifl3fCRhonQgHM4uAmk6+d0iEXsZQEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723009560; c=relaxed/simple;
	bh=qAMXniJVUCkAK0/TCmnntJiv1SD2wdShosY+9z7t1G8=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=mNi8DO6oZKQLxf+mlLc8ZIxZkDipYvvAs6J/yBM5gBy+XHtTHjmHXQ8+jEWFo5dzXJAbWuL8jwKAamnTWM3syGS4d7sRwpUtMzHNpBZoEr/QTIUGaYm9gthRLsBBTajBWkhi/myLRY5iM3hVP6a0k0eVRTvKEBBFlaK3AkKOO0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=QMr6QKCQ; arc=fail smtp.client-ip=185.183.30.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209320.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4775doFu030177;
	Wed, 7 Aug 2024 05:45:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=S1; bh=vCGKLuDPnVKmQeql1alxh3bVYSgZ/
	bDKLfACQExNED0=; b=QMr6QKCQJfZHzGIv4In1sufoCbMK4FKNHwZM8n6aYuNyO
	KCxr+GdtZrvoLTjkEXqOndippzzZdwERTe6PKgyLMrw9a4Qk0IxDzRHr+FTWRqlJ
	WUzH80qXxW4WiRBFKXl9TwKANX1mb+4GcEffK9FxbATk5CL0Co3YaAIF6LvtHu8X
	ddUmM791b1gT6QCFA4Rovwc3WgE337WRwxhsO6q3YOo5TWWWXonj+zw0DOXONyAH
	+U1rty68vQeK6YhdG+xYl48BY0En+fmrHBNm+KQ60bi8izzUY/d7rfdPSMMSZrRH
	BunDoBizk5JDUTWXsQl/Ts9+YId8AKFOAeGa+e9ww==
Received: from apc01-tyz-obe.outbound.protection.outlook.com (mail-tyzapc01lp2041.outbound.protection.outlook.com [104.47.110.41])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 40saep383b-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 Aug 2024 05:45:33 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HQDxoqTQkd0ViNrVKGITgiy1vf84urth3lhFxH0MsioZ+Xo5szespg729GPp5Gyh4dq8rWI3XIVAEO7bjQmqzb7sRkDFaK1jZKYF8vYnXF6ud8eY8z/Y84QHHzsNvEP1OZIcgMbpPwRdnSs2H3Ki+2sfj/HEyy5crmuCulYn2RdZs6Mgo90osTSlCFNAmiPIxhlgBV6zcX+2WnbOuTefjpT7K1wqzrGLqN9PPaRdTCwqfUWSpKN+tbr9lBjKRr6ChL2Myrf7kvFUleENOzdEawqWmrZUtS6mmkDDSPVz8MXHyk+7j5haiw9qiZ50OPhH93nIjfgI3rZevk2qaYt0tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vCGKLuDPnVKmQeql1alxh3bVYSgZ/bDKLfACQExNED0=;
 b=XSE6bn4NHGcWHQfQEsaJ8k7lOWSwnZ1h+UGD2N64PMuRolt5C3i6TDEL13pYDQ3NzJxmEW9zq50FaWCU72uQkn0rN8vg+s1iAB2Ot8BeSOPIUejX9/80a0+G5pcKbr8Hrfa6gC+kJPnRpKyQGsY9xZdkqjHnQSAegdfG7qB8adUtVMV/xX/h2p+U1zozJymcJYJGVEi8KCcO5Py7QzkzXBqhdgrUyrTVMQGKcYbkSVO48PSxdc+rFsU7w8dTW/sc7mpsB8LHIMaSSrcaimK+eEcoM4omuoWpFV4K5NUgNAV4T4hrodr+8Gy2wL5ntYgRwBis3bzjFkbNNYWvpAqNYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by PUZPR04MB6886.apcprd04.prod.outlook.com (2603:1096:301:118::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Wed, 7 Aug
 2024 05:45:28 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06%5]) with mapi id 15.20.7849.008; Wed, 7 Aug 2024
 05:45:28 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com"
	<sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>
Subject: [PATCH v1 1/2] exfat: drop ->i_size_ondisk
Thread-Topic: [PATCH v1 1/2] exfat: drop ->i_size_ondisk
Thread-Index: AQHa6Iwi3WQKJ9UsFUe2ryZR7fiZWg==
Date: Wed, 7 Aug 2024 05:45:28 +0000
Message-ID:
 <PUZPR04MB63166ED51D1DC677D254595381B82@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|PUZPR04MB6886:EE_
x-ms-office365-filtering-correlation-id: fb3b9bfa-426d-432d-7ae9-08dcb6a424ab
x-proofpoint-id: d8690225-876f-412f-87c6-a7cb45557a4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?YfCNNvbkWbwG/6bn2ObtwAGTizW9k/mT6q8hbVJ/9T6Qwe86dAnKHO6THx?=
 =?iso-8859-1?Q?6RU82Aw54RazGjHotO+AZdiCtKeEn4rRed5Lgo23OGlEcZDY3TysY7MslL?=
 =?iso-8859-1?Q?ce0ZGsf9mQyeiOi2aCHuh/YZhn0puAraagJcLsiK1ANjmeowa8vryxCbar?=
 =?iso-8859-1?Q?njSLB/6yQq0AJC5Y+QkEMstQS4ZERFL0XFSLktEYrmEmDufRgyHYvx7EWl?=
 =?iso-8859-1?Q?LO+xFWXG/KYiWywQza43ZG6D35GYXcr6eC1u/EK97lfl06Fz1+x6CU++2W?=
 =?iso-8859-1?Q?CaDyoGnQDmaa/a01ng5NtJIjeaSp6CWgRl+beDSre1hwrFdu85gkfK2qRj?=
 =?iso-8859-1?Q?HzeUC+B9feAMrjC2ETwRf4+hfOxNMm9WpoIbHObKiTT/dVoQCoOvQRmfwC?=
 =?iso-8859-1?Q?JgwEkYJa7IXGYEvg7AiBX6dDF+2eGZGIsBpjCgsB3fbizWZfjSnR7ibrDc?=
 =?iso-8859-1?Q?fUvHh4SLl9WdiTi2uFD6uGfoYqx0picIIzCIH1euPGVFlq+1pW8hPylJvs?=
 =?iso-8859-1?Q?+MI5b6vLLSEZDVO3BRgTdMotqbU+ZrW+hTsZMqd8sQ8O9oTiaXZ1xacivl?=
 =?iso-8859-1?Q?WGPI1kS1AR3tAWYZ8a+lVvYso2m2DPJrQTgYyad5AKIFZqOdS61FcheRay?=
 =?iso-8859-1?Q?MTW4FRnB+XmOulltUHKK0FEqbW63CljujJYEzcpkq/o+LooRjdAe9tR9rc?=
 =?iso-8859-1?Q?rJgM2teP0XiznMCh9YwEZZT6kMHTcE66/wUbHuGKQLbd2I8F6UNBdoIm29?=
 =?iso-8859-1?Q?Q1j/sa1EzqwoU72OxdEI5FSQzqPAYXZfqVt1aNJGgRw8tITg+7B3FguSrd?=
 =?iso-8859-1?Q?a65swAM4jZOV7FEE65kqj/VXZJmdpt30o6bHpqOsR0WHfLplIwgzERBoj2?=
 =?iso-8859-1?Q?ZEuwcrd5qJXWgFh+6Rsp5pKodOHwBttSG7byP+ul8EBkWbH+6PV2ZcHdg+?=
 =?iso-8859-1?Q?5uPFxSpDGJfG+qMRCVQS+NwC4ZLLTOGtFM+aEU1EGTdd6ijYuROx33iW9K?=
 =?iso-8859-1?Q?uDIAe3+YFtEvI+o6c6LvVEhuEy8lEPcV3rPPhZofpBGF0lffX8LObitD/4?=
 =?iso-8859-1?Q?ZHXA8ZNmA2YF4WA4prMSIqytxxyEoAuHINse0VwkkeT6HNVypvdypQVQTO?=
 =?iso-8859-1?Q?QP7rNhxkg69RLbEiIo1i73uVd2gYN9i5zBhS5jy3+vA9qa2Q1qxAdcERWg?=
 =?iso-8859-1?Q?9RwkeM6CRyBZ4I9o/dAy3tIMcLwKPV56WkPKuqlzK/apht4j3Mb7DVh3Wj?=
 =?iso-8859-1?Q?LbAXjbVOamyt+cbw8xdtY9L/BMXmfhmRE61Spc7cNDNo4y+Ipwoe/oVamV?=
 =?iso-8859-1?Q?YDUOqW3nYcDZAPp2v8Dq1ruo1XJFamGuMFPDg5i/BZZMAwYStjZvSpDUSD?=
 =?iso-8859-1?Q?8oqudEgKw3DvMJ1v4LzZALFyMyq/vdkIVPQmHXAC++GBgVUfPHr0KJNHBn?=
 =?iso-8859-1?Q?t64PD6iFrWw/2BHVSd51JEHHzUSdmIvjlP3RKA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?3/dv4NFi7M7nkMIx+r17slRnIPgQ5HVw+dSsZ37cc8cEO+RK2KB85BAqD/?=
 =?iso-8859-1?Q?55ZEEHsics1SYc/MLpxvbCiRhHqhMlYvymwvxrIwYm1CLzzQ+6tK4l8khZ?=
 =?iso-8859-1?Q?m4lr6Fi0GQcRnRr/DE0wuXzptw2H0t5apCA8+w4WUblzdCxRtZRteQT3Ri?=
 =?iso-8859-1?Q?7s/WJ5snjeQ2lNqTWJaqgRNcrshBYdl3Ei5Tx7N+k8Mi7RMRSaUGKNKNO/?=
 =?iso-8859-1?Q?ptmegwANktexvFwFhkM40KsmATITMUVvCORtrpmmtmzv8Is1DJfmYkM0wA?=
 =?iso-8859-1?Q?yp2r0BJTrUdobqyZyCG+2dgzd8i/SpdUlddcjJPaIr5NnJiq7o3xCMeb0F?=
 =?iso-8859-1?Q?rAdEXCUwlLVE2EKT7P+Ar8N5y+pLhDQdqo0BoKs1mFRj69M3fUsGDzSK2M?=
 =?iso-8859-1?Q?s3le43HzZHq/1vszXnCvlfiP6/9O0U2/6CVqVt4un6RCNQM0FCFdfiFwwZ?=
 =?iso-8859-1?Q?yxuaXBLY9UozQQQO6Fh/SFtnMVdcazySRukxwq13uJC8OG9SjFvI8nG0pM?=
 =?iso-8859-1?Q?0O4Y+qmOtnFJwB4VtQ3M/omjQ/FAvx/du5pvTEXlKVuZ+iUmTJP10U7xzr?=
 =?iso-8859-1?Q?SRWXs/jceBMuYTWEUethIGOeL2zPJlUhz5EI/th7JX6Uf9oyQ1zKNwsEHZ?=
 =?iso-8859-1?Q?R8/RdF1f7Xz3xNWBfHfDYjjDXLtGVNkN+Hq21gdhtZtSNcacvlw8QI4+83?=
 =?iso-8859-1?Q?0rw2VO/rKCnjqKvEdRkK3AnCHcmnOl5bI+eyEWooV2c9g3ccP47focUVxH?=
 =?iso-8859-1?Q?Lgdcv+olqHnGgSJ23DHgR27A6egY+tmwQD5MC070ii/T/d2xPUqZ8E4aZJ?=
 =?iso-8859-1?Q?1+WJ1xQLHk34d6dJ98mR/8lQ4y7OJG3xZVzV6h+pxRGNo5jqcmyzAS04ne?=
 =?iso-8859-1?Q?NKg933jpans7uySkjWjV3kUi0YDIvncThYD/6H2nGv7J44XNChLpafTmh1?=
 =?iso-8859-1?Q?JvXbV8SgOuXe5hFr+sV/CktM5ZFNMCJcrzgxF6DGUvQ2zHte34Q/oMkgRR?=
 =?iso-8859-1?Q?TD6wTzYMdED5RGvU9PIdU8UmtloJXxADbcWEOG+U60+QOmGc4oSfGfDKl+?=
 =?iso-8859-1?Q?FJfojlaEEDUHLyxTRmYq8jZYUOEpP4AWoD/DTJzBBN9TiEu25i89/xSDKF?=
 =?iso-8859-1?Q?Dex+C8ZB9iehoaZxFZ5U8k3vy5IntfyTYiBB16Sz2KKHdDTKMhcQfIg/cl?=
 =?iso-8859-1?Q?k1kD6E4Lw/UrcHPMkis8OJA1ocAS6alyau+6cEq56VNvpTE3uEoLdHCNtM?=
 =?iso-8859-1?Q?EBgEh4C7z62QO5U4dxu6aq1W02ogjuGgU42LNquCjXQLzQEUMTOy8Y/5m5?=
 =?iso-8859-1?Q?XQu77y2BTdfksvF9QHa/fC9LhhPJcDyL0IboK8K+3s9k7bLSKbiy6EDE0U?=
 =?iso-8859-1?Q?fyfOnjeBu1Dh1HY8p86LguhCjgnb7XVYE4eXQy0LhtZ1Ng24PL+O31zL2J?=
 =?iso-8859-1?Q?ewwSo7vYCQ6YGlC8dGeOVoz8i74QQTdaO8jNlEcZe1m057I/ClyLAhVhIn?=
 =?iso-8859-1?Q?uj9o4qIFTe1XnWaw+wqp9Up/CWBpUfUKEYqFStfrl9MJI38+12F+b4yByS?=
 =?iso-8859-1?Q?Fv9pKHGNW6tTLDjM8x5dXsJk0Oni6uXlmWe0gAykRbXw6zoxFgOh1k4kBN?=
 =?iso-8859-1?Q?HOOdhSZuGatvcJ5FoMAHN355712tSsjsW3VSkgCJb7CJMOsh8IgmW+OpzG?=
 =?iso-8859-1?Q?T0BrqeMSBG33Iwg3DtA=3D?=
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
	utJhCaa2TC9Y0ODqP5QGSa8O/IP42QKxMLoqIRxoRjrZRAb2aolkcgCU2rcB0ZErQvEPCUW4k3cPToWX/tsmKAWZZ30fZyDuyWGjhVBCQlRJeHiZUPysgsiLIPdJwWG8MJuhKbe3mT3WTFlHRmbTte08z2NTE7fI9NAmqJV2zyJMlPDo0px36f4wTqV6nvPfk+YNKhEyET7DfsixFcR2ocU/rd5fGPVVpcE8F7Al0xXoiR8REHBkFVRnjxTHcBcFSOf5sBTgZPoH7NEGwNPQ66PlJm0ZOv0ezs6hT8jhTlU30a9c1m55KAXEMkYd3s08lRYYg4mhko3K3a2I64wCgoCATD7oQpFj/NsKqJMR9rnhgOnPVkJGL45O0RnLyM+Esz8sdK3vL8D3VBKBeiDjkrtug+zmeAqt20jvwhGfXkPOmoBA5MRv8UFYuEb0+vj52rAFOladXwYd+4rikGcWJvPJZrZ5qREd6ZQMkr0G/fAjPuFH3561mn/ru6oTJ9K1sRpc3ec5TwPlJSe00ZqkIXhWZsQqeBHdtpLs41Wk1vgAQqPpDOeZcpA66N/xXKJM0U/o5NyJ9Gu01+V4AHBxqd5iQBcJKsMtyrri3olzQqrZk2Rvc8UzhiKDSqSJzDq2
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb3b9bfa-426d-432d-7ae9-08dcb6a424ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2024 05:45:28.5718
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YLvHQLOTenImR825YEnlGsoZdqAq9g9OAwDbOeTrIOKZEZqLgPPGbo60wqfqOKYm6vld5LsgIw5SBVMERGR8KQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR04MB6886
X-Proofpoint-ORIG-GUID: HolwNgN_xEeHw-tZNPfAWuorUrdDVaDu
X-Proofpoint-GUID: HolwNgN_xEeHw-tZNPfAWuorUrdDVaDu
X-Sony-Outbound-GUID: HolwNgN_xEeHw-tZNPfAWuorUrdDVaDu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-07_02,2024-08-06_01,2024-05-17_01

->i_size_ondisk is no longer used by exfat_write_begin() after=0A=
commit(11a347fb6cef exfat: change to get file size from DataLength),=0A=
drop it.=0A=
=0A=
Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>=0A=
---=0A=
 fs/exfat/exfat_fs.h | 10 +++++-----=0A=
 fs/exfat/file.c     |  8 ++------=0A=
 fs/exfat/inode.c    | 17 +++++------------=0A=
 fs/exfat/namei.c    |  1 -=0A=
 fs/exfat/super.c    |  1 -=0A=
 5 files changed, 12 insertions(+), 25 deletions(-)=0A=
=0A=
diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h=0A=
index 1d207eee3197..40dec7c0e0a0 100644=0A=
--- a/fs/exfat/exfat_fs.h=0A=
+++ b/fs/exfat/exfat_fs.h=0A=
@@ -309,11 +309,6 @@ struct exfat_inode_info {=0A=
 	/* for avoiding the race between alloc and free */=0A=
 	unsigned int cache_valid_id;=0A=
 =0A=
-	/*=0A=
-	 * NOTE: i_size_ondisk is 64bits, so must hold ->inode_lock to access.=0A=
-	 * physically allocated size.=0A=
-	 */=0A=
-	loff_t i_size_ondisk;=0A=
 	/* block-aligned i_size (used in cont_write_begin) */=0A=
 	loff_t i_size_aligned;=0A=
 	/* on-disk position of directory entry or 0 */=0A=
@@ -417,6 +412,11 @@ static inline bool is_valid_cluster(struct exfat_sb_in=
fo *sbi,=0A=
 	return clus >=3D EXFAT_FIRST_CLUSTER && clus < sbi->num_clusters;=0A=
 }=0A=
 =0A=
+static inline loff_t exfat_ondisk_size(const struct inode *inode)=0A=
+{=0A=
+	return ((loff_t)inode->i_blocks) << 9;=0A=
+}=0A=
+=0A=
 /* super.c */=0A=
 int exfat_set_volume_dirty(struct super_block *sb);=0A=
 int exfat_clear_volume_dirty(struct super_block *sb);=0A=
diff --git a/fs/exfat/file.c b/fs/exfat/file.c=0A=
index 781b4d4dbda1..8041bbe84745 100644=0A=
--- a/fs/exfat/file.c=0A=
+++ b/fs/exfat/file.c=0A=
@@ -29,7 +29,7 @@ static int exfat_cont_expand(struct inode *inode, loff_t =
size)=0A=
 	if (ret)=0A=
 		return ret;=0A=
 =0A=
-	num_clusters =3D EXFAT_B_TO_CLU_ROUND_UP(ei->i_size_ondisk, sbi);=0A=
+	num_clusters =3D EXFAT_B_TO_CLU(exfat_ondisk_size(inode), sbi);=0A=
 	new_num_clusters =3D EXFAT_B_TO_CLU_ROUND_UP(size, sbi);=0A=
 =0A=
 	if (new_num_clusters =3D=3D num_clusters)=0A=
@@ -75,7 +75,6 @@ static int exfat_cont_expand(struct inode *inode, loff_t =
size)=0A=
 	i_size_write(inode, size);=0A=
 =0A=
 	ei->i_size_aligned =3D round_up(size, sb->s_blocksize);=0A=
-	ei->i_size_ondisk =3D ei->i_size_aligned;=0A=
 	inode->i_blocks =3D round_up(size, sbi->cluster_size) >> 9;=0A=
 	mark_inode_dirty(inode);=0A=
 =0A=
@@ -159,7 +158,7 @@ int __exfat_truncate(struct inode *inode)=0A=
 	exfat_set_volume_dirty(sb);=0A=
 =0A=
 	num_clusters_new =3D EXFAT_B_TO_CLU_ROUND_UP(i_size_read(inode), sbi);=0A=
-	num_clusters_phys =3D EXFAT_B_TO_CLU_ROUND_UP(ei->i_size_ondisk, sbi);=0A=
+	num_clusters_phys =3D EXFAT_B_TO_CLU(exfat_ondisk_size(inode), sbi);=0A=
 =0A=
 	exfat_chain_set(&clu, ei->start_clu, num_clusters_phys, ei->flags);=0A=
 =0A=
@@ -270,9 +269,6 @@ void exfat_truncate(struct inode *inode)=0A=
 		aligned_size++;=0A=
 	}=0A=
 =0A=
-	if (ei->i_size_ondisk > i_size_read(inode))=0A=
-		ei->i_size_ondisk =3D aligned_size;=0A=
-=0A=
 	if (ei->i_size_aligned > i_size_read(inode))=0A=
 		ei->i_size_aligned =3D aligned_size;=0A=
 	mutex_unlock(&sbi->s_lock);=0A=
diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c=0A=
index 804de7496a7f..82a23b1beaf7 100644=0A=
--- a/fs/exfat/inode.c=0A=
+++ b/fs/exfat/inode.c=0A=
@@ -130,11 +130,9 @@ static int exfat_map_cluster(struct inode *inode, unsi=
gned int clu_offset,=0A=
 	struct exfat_sb_info *sbi =3D EXFAT_SB(sb);=0A=
 	struct exfat_inode_info *ei =3D EXFAT_I(inode);=0A=
 	unsigned int local_clu_offset =3D clu_offset;=0A=
-	unsigned int num_to_be_allocated =3D 0, num_clusters =3D 0;=0A=
+	unsigned int num_to_be_allocated =3D 0, num_clusters;=0A=
 =0A=
-	if (ei->i_size_ondisk > 0)=0A=
-		num_clusters =3D=0A=
-			EXFAT_B_TO_CLU_ROUND_UP(ei->i_size_ondisk, sbi);=0A=
+	num_clusters =3D EXFAT_B_TO_CLU(exfat_ondisk_size(inode), sbi);=0A=
 =0A=
 	if (clu_offset >=3D num_clusters)=0A=
 		num_to_be_allocated =3D clu_offset - num_clusters + 1;=0A=
@@ -268,10 +266,10 @@ static int exfat_map_new_buffer(struct exfat_inode_in=
fo *ei,=0A=
 	set_buffer_new(bh);=0A=
 =0A=
 	/*=0A=
-	 * Adjust i_size_aligned if i_size_ondisk is bigger than it.=0A=
+	 * Adjust i_size_aligned if ondisk_size is bigger than it.=0A=
 	 */=0A=
-	if (ei->i_size_ondisk > ei->i_size_aligned)=0A=
-		ei->i_size_aligned =3D ei->i_size_ondisk;=0A=
+	if (exfat_ondisk_size(&ei->vfs_inode) > ei->i_size_aligned)=0A=
+		ei->i_size_aligned =3D exfat_ondisk_size(&ei->vfs_inode);=0A=
 	return 0;=0A=
 }=0A=
 =0A=
@@ -317,10 +315,6 @@ static int exfat_get_block(struct inode *inode, sector=
_t iblock,=0A=
 	max_blocks =3D min(mapped_blocks, max_blocks);=0A=
 =0A=
 	pos =3D EXFAT_BLK_TO_B((iblock + 1), sb);=0A=
-	if ((create && iblock >=3D last_block) || buffer_delay(bh_result)) {=0A=
-		if (ei->i_size_ondisk < pos)=0A=
-			ei->i_size_ondisk =3D pos;=0A=
-	}=0A=
 =0A=
 	map_bh(bh_result, sb, phys);=0A=
 	if (buffer_delay(bh_result))=0A=
@@ -680,7 +674,6 @@ static int exfat_fill_inode(struct inode *inode, struct=
 exfat_dir_entry *info)=0A=
 	}=0A=
 =0A=
 	ei->i_size_aligned =3D size;=0A=
-	ei->i_size_ondisk =3D size;=0A=
 =0A=
 	exfat_save_attr(inode, info->attr);=0A=
 =0A=
diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c=0A=
index 631ad9e8e32a..6313dee5c9bb 100644=0A=
--- a/fs/exfat/namei.c=0A=
+++ b/fs/exfat/namei.c=0A=
@@ -372,7 +372,6 @@ static int exfat_find_empty_entry(struct inode *inode,=
=0A=
 =0A=
 		/* directory inode should be updated in here */=0A=
 		i_size_write(inode, size);=0A=
-		ei->i_size_ondisk +=3D sbi->cluster_size;=0A=
 		ei->i_size_aligned +=3D sbi->cluster_size;=0A=
 		ei->valid_size +=3D sbi->cluster_size;=0A=
 		ei->flags =3D p_dir->flags;=0A=
diff --git a/fs/exfat/super.c b/fs/exfat/super.c=0A=
index 1f2b3b0c4923..61d8377201f6 100644=0A=
--- a/fs/exfat/super.c=0A=
+++ b/fs/exfat/super.c=0A=
@@ -371,7 +371,6 @@ static int exfat_read_root(struct inode *inode)=0A=
 	inode->i_blocks =3D round_up(i_size_read(inode), sbi->cluster_size) >> 9;=
=0A=
 	ei->i_pos =3D ((loff_t)sbi->root_dir << 32) | 0xffffffff;=0A=
 	ei->i_size_aligned =3D i_size_read(inode);=0A=
-	ei->i_size_ondisk =3D i_size_read(inode);=0A=
 =0A=
 	exfat_save_attr(inode, EXFAT_ATTR_SUBDIR);=0A=
 	ei->i_crtime =3D simple_inode_init_ts(inode);=0A=
-- =0A=
2.34.1=0A=

