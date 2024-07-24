Return-Path: <linux-fsdevel+bounces-24199-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58DC393B294
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jul 2024 16:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8855028223B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jul 2024 14:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D3B9158871;
	Wed, 24 Jul 2024 14:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MT7PdLPf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0A9134DE;
	Wed, 24 Jul 2024 14:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721830891; cv=fail; b=R8ZP2xbrFCCfpOiJzu5onc6IX+2blWcZz0POui/rr2n5DKXXxHHmHsWCpueVUZfwf9O38K/ubXRCju+HsyIVt4qfORPvlLAsylHXLMsGAWT9wqNsENKqyECB9a58eXr0ZIlxYL5KTQbh0OfZIsvUKuCVZgPqyUd+xAScH5Fy6fU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721830891; c=relaxed/simple;
	bh=7kFAMhIrgVNzz34CJWjCoAj0WTFBYGrgN0gyj5y+Gew=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=I7+i/cnEXDGvs+SqbkadS0984svZK3O8P+ZaGdSJ+3s99KzqhgfahAYFoj+oygCskyrzz+Fqb3IlyYXkVevDmVby3DuCNxKGDy0hW6A2KFqJIoJqAnlk4NLVkEYOZ1ToI+MxHh+H73ZbU1GccXYg0LOpTLp2lTCxnJyQSr7kDQ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qti.qualcomm.com; spf=pass smtp.mailfrom=qti.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MT7PdLPf; arc=fail smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qti.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qti.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46O9YLL5004298;
	Wed, 24 Jul 2024 14:21:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=SKmdrOYGU9HmMYytc4jjVN
	GI8/1jBv3glDtzPtZ+iZI=; b=MT7PdLPfb2u796ySW+nmr0rncfdtFxa/sT/Sr0
	5cPo95ArBqgHo5S6ey3kgi+gS6jiPfgyCTeUxzw02vOp6p/UA/StAApIxG9hQudp
	qHilbg9Tdorg9aNIgCBVBnHXXKKGzKOj7ivf965y8vczx5V98EmymV5fJO16APWd
	/du2r4WP7gB82NP3x18iQeZT0wvlqnTHVo6R7V1p2pOdXpXs6i+5G3mzUaZfYfid
	49Uoi5F+802BChJyFWPK/kQaAQV13gAcg6Z6ZglysGG8DPBrOi44+JzxLyR3Nt8A
	MprJIulUb3QQORCKwl0eNgKi/y/zLQDkSOLybiocgFE+YFwQ==
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazlp17012032.outbound.protection.outlook.com [40.93.1.32])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40g6dk240p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jul 2024 14:21:29 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s4HthrHUfz2RwRTeBNGYymVGujPjOx3p6iGqzwC7bQ+hTnvzKj2fmEwN8POYYqF8Nfy1Gc5HVPs/3Pjqj6UeodOFp5URUoHZ6TCoUTTGXG23XwlGU5vsEasfqbxSBWy6sgyElpFr/hKRpMe091InEmjmnAXh3XPVYiSxIXV3YLUUAnvIrOvN4vYs8shbepvoPdp8jyXE4Z3q5OnerKOGv+eh3z6iZiQ9fFIcwmV8a9Z6IrrO5kNH3hkx7tjYh4eyHr+XkZJeOXi9vzMj1q2XHp6t4XGmc8bd/U3U126rO5SsrGNmL2THY1m2istnrNZAsTspglkioYOrfsVJrKbWEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SKmdrOYGU9HmMYytc4jjVNGI8/1jBv3glDtzPtZ+iZI=;
 b=U69Vwl/shhc0eD8NQXc+CEDIrS+JwZ8TAfHGrCihHSxbS+imZaS5MCHsyutd8uaIhhPx6mu9elMBWKXaNZlEOPcjXl8AH8EG54H4OZtS2nZIcms5D8EKfTONUWXad8uT0vi7LZAFLKbwb6Naa6wh/KAFXx1JgYCNkwWreAxdXZyIzeG0Exl26B7vXrAYGWF/a8VhlRFckVH3fmqctUcq3Rl4Msfm/WERYskXzOt/nke4GzGZBtamOVtMOId4XVPcfOo+J5hAY1Zglg6u47qYAkdGypHZs51wvY1pNIF5w6clQj7EZecqPBgICJ7IAuT4aC6VYpPVoLvRJwX016XM7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from PH0PR02MB7319.namprd02.prod.outlook.com (2603:10b6:510:1e::14)
 by CYYPR02MB9843.namprd02.prod.outlook.com (2603:10b6:930:c6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Wed, 24 Jul
 2024 14:21:26 +0000
Received: from PH0PR02MB7319.namprd02.prod.outlook.com
 ([fe80::b661:1899:2a90:c909]) by PH0PR02MB7319.namprd02.prod.outlook.com
 ([fe80::b661:1899:2a90:c909%6]) with mapi id 15.20.7784.020; Wed, 24 Jul 2024
 14:21:26 +0000
From: Yuvaraj Ranganathan <yrangana@qti.qualcomm.com>
To: "linux-fscrypt@vger.kernel.org" <linux-fscrypt@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Software encryption at fscrypt causing the filesystem access
 unresponsive
Thread-Topic: Software encryption at fscrypt causing the filesystem access
 unresponsive
Thread-Index: Adrd1KUCOvwqSMIDSn6WwsATXV2bdw==
Date: Wed, 24 Jul 2024 14:21:26 +0000
Message-ID:
 <PH0PR02MB731916ECDB6C613665863B6CFFAA2@PH0PR02MB7319.namprd02.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR02MB7319:EE_|CYYPR02MB9843:EE_
x-ms-office365-filtering-correlation-id: db78b0f3-06a5-43d7-f6c5-08dcabebe701
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?jH25z8d0rhnYu13KBLvn6qb8yozuB4XpWsyeBUVNHLFxq8FYHazwpXEoojMs?=
 =?us-ascii?Q?yAYUZ5xQhXz85P4LTeLp7MtO/8ZEkbFcpqSzlEwlZshPIdWsaGNLLCIApVbW?=
 =?us-ascii?Q?EIvFzp/yqN5h6mDe729EJQ1P9J8wEE0Mv0rFpJ/4FlEjkpW49ZCFkao3vs87?=
 =?us-ascii?Q?nTIJMFhb8zGgGUq/+7TP25ueZvAkpd/Qcs729IjzhlqCPy/PFxxkE/LMQ8co?=
 =?us-ascii?Q?bm62ZYum2NcKRgthJ7MDhTQX2/YAlwLAF7C5aTX3jGDSgoZ5HRkLJhjY/KoH?=
 =?us-ascii?Q?xQt/h2mUuPQ2HWxmUkXe28m/McCYa7aU8VzC6CpnrJC+6KAa4TILZ9CJauxn?=
 =?us-ascii?Q?cacix2wBuY9CEOurXvrZUdm6CgT2QeQyYNVI4Pd8XaxEwZTeDoRVEKshmoqM?=
 =?us-ascii?Q?FzULqomGXDhS5j8RxM3/2nDrNAQetYNJUYf04WMV332ZqQ2G1Lb0+BubtaZh?=
 =?us-ascii?Q?tBKikJjbiyhjnj6a6j5yi/8y1neGQZEu8C2ZzxFrt5nN+TYfgubPmMYogPAL?=
 =?us-ascii?Q?Ry8J6YTNKwC4Tn26E1yiTvMbVNdRuD7OxuxKlxJ85ovSbF70AbQQdx41KT4c?=
 =?us-ascii?Q?vie1xWIEUqKu0lxe1SCmcTvBGYLbBppgjVg+lcX6YmzEWRg9Y49pnhERE37D?=
 =?us-ascii?Q?UwHYuQBdvoUuEYPX/HTHyxAN8hJgEn/0/gltLw3aZ6fLcN4jsorail7SA+ih?=
 =?us-ascii?Q?dt7xT6R327PTluwg6OrjfHJVZlNi18J1wYI/qkjCX98CfEoEuvBXmA9VDB5V?=
 =?us-ascii?Q?XQPx5L7gL16LrhnBziN9FVpghxYqLylOx4B9gYLLB84m1KlkXdrDm7GVsgaD?=
 =?us-ascii?Q?XioMLKFrYN3ZXClSNrSLoM7wRJjPn3OJ6q3kr7ifC+fXtYYkTrp78ri+VIS0?=
 =?us-ascii?Q?y8DUS4dHr7wua08cR2U/UgAlyknPVZJXUNHATKt/oQ9Uo2qZuIQNPu2nNZyq?=
 =?us-ascii?Q?JNBFSSd+MRukUlErYVIE2zFbm8EkFICPJ3BE9EfDK24Xx0EjhigcQH4Cg6gc?=
 =?us-ascii?Q?2zzN2Yv2hq3gWikmI3hhqQo0NWyxXLXsoJDVga7t1JwG1Kz+HHKlZ0WuPVWZ?=
 =?us-ascii?Q?Kiyc7bEpFe/4SVtKnHQyxRD2vqc8k14L8Cnretj3pWWUlL623/Ijf9Gddv9f?=
 =?us-ascii?Q?mt/twPdMnXoC2G2zxmucvj2fANx92DooOGwFjOscgKDiK8qEeN6TTTRN6yoo?=
 =?us-ascii?Q?bQttVTllMKYfEuvHFvH5LlPOv+UZH5X+8/hsdyB7x4mVgKPJgzhblMxEJDUR?=
 =?us-ascii?Q?0e0tPYJywMLezR14goz/hieha6371LvwlRPBIPtivrHBfu4r1TmI8oegVGO9?=
 =?us-ascii?Q?GgfUISaXfMAPfBKS8OXXL/LUSCRETWpI/Cnor1/pv3C+5asBf3j0MhrT9GFX?=
 =?us-ascii?Q?EvxM0DQVsTrrvYDJTPPcz1o8suW0Odpn5qEQZxdv9HVH0778Qg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR02MB7319.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ySWYybES77w8cZoS6qGLPDJTgQLZN3gAADBz6VMkleOhd+NHXomZiWZRR2UH?=
 =?us-ascii?Q?d38ZvLxFANgiMkDE4YEXlxxIaoRqOic7JTUzjGhSREuqPi18p/5roOv0QRUh?=
 =?us-ascii?Q?LP7ncgjzRHmtOB6Ub6zAr1cjJyb3Nl7yO72UKBI0qNK0hlmqaYNCbB9U59Sl?=
 =?us-ascii?Q?BaZAvTLKx2F7q+QxhZ27vlPCb70c0SiLGjN1USV3ZhnZA0EXwN+VDVKYYMUM?=
 =?us-ascii?Q?C0u1syijYu5d7XdJF3aCH3Uu5JoWqg04FHopSmEBZ87blBbFex8qnefvYce9?=
 =?us-ascii?Q?QGQ4a4WCjrAkFvAF1O4ZEs80Vzz6IWIUUOYRu6It9+CnG3lSXwuztiL6Ce/j?=
 =?us-ascii?Q?G+Y67iE84NydcPQzgHQrHaHRkGVWWAN8hGeEuECKfCdV8MdvKi2dlglexAhm?=
 =?us-ascii?Q?zLs+i9kHHeUoG3tmFW6dUR/R843kdye629MDAMNx4yp7fEsRTVDuUy1rTbAG?=
 =?us-ascii?Q?cTM0pxuPYxCqDKfTUzXQKGjAMy1TuBpMQ1by482amijSOTOnE0loJ9rvRJux?=
 =?us-ascii?Q?pCEsY5WPU12gtI3yyXn7Wy7tuigJTad/Z9B9AiX2JTWZa64telx5FoCJFOLq?=
 =?us-ascii?Q?mJY4b2lrMBaQIowK6wSetZYtplKtc4Rfh9ORl+mclP1MIsurx0YKN6ef3tn5?=
 =?us-ascii?Q?FJoPRUVKXF5UkFPfI7YR9Zg76f4SuuE165Y0eZwTIlWN9XYkvRHPcH+Qua2V?=
 =?us-ascii?Q?3IIuUnLO3hmJs7D/ScBaNQX1fYs/DqUnbSW1ex8UzSJk5oBFsf5TwM6rvMio?=
 =?us-ascii?Q?Ppa0GMOIfvBzrt2xpmrlwwlUp4plPeXuxYOfzEEqtEZ/dERQithqCt3wPrxX?=
 =?us-ascii?Q?rKCdr9NbtNSQpCwZL8mC0wYIb96YBoDJSmPRmuOp4VBs2aWYENAXuQtsT4RN?=
 =?us-ascii?Q?ART+5Z3pZFXaNmNyOyLIBOCAcSU9aQ7LWq9njjmw75Ow1QSv6GAG8NLkOXV/?=
 =?us-ascii?Q?0aEwCR2IQK2Wyy68ap9xDdyZNz4lEzSxLINjcOnrJZ7rJpaDkLc2cvgfGVjD?=
 =?us-ascii?Q?US3rVHqoYE9QuZ/DiSTsbXCZC1okPzvK5JAz+5q/Vqg6fIUUtF9FCSF8iVCK?=
 =?us-ascii?Q?TQQIEsauWhB1ApW5CgG7DkhFyCpvoA2AyEokXWWiCdmXXzCaUA4QosUmuNqE?=
 =?us-ascii?Q?c3WsQqwscQ2E20HGfGP4/2e7C04yGo9axbjSQKNpuv3W5On3d7AZt7LpZexI?=
 =?us-ascii?Q?BkZTaywnBxCpDxXI38NhN4A4uHORpLfkq136EfDgzf/zGfh9UzTmgQ4ERJj/?=
 =?us-ascii?Q?sNUBXw1EnhggqhoyxjPx6gITtPE+O7QufVy/bKXj4oKmjFVr8sKoaPxSd7j4?=
 =?us-ascii?Q?q9hbeBAMUuDqvuqfhFxeCwlBS3SHarrp1vSqd3vPsqmN6xrfNQipmHJSvA/N?=
 =?us-ascii?Q?DYn/nw0jcOL+xN1BCcWJcg0+KaQb90b+nHeYHduOphuyK5QrmbjvP8ec0Ezd?=
 =?us-ascii?Q?86t7xTkTOACj81Un+P4mPwbUhY8dNG4Tr8izwWn9FC7I50z0ohHYWUegTEWW?=
 =?us-ascii?Q?v2FxVuNzuAF+BUIQNivz9NvNN+FYgIPV/OSGSNJ8IVrS2KXtqtMuJT06n+bx?=
 =?us-ascii?Q?W5ZdUZXlS68sgt+vF7WBTLpiDPBtKad/xJ6Xk0tZ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4TJWbn/Njns18zG9xqqkAr/HqsgUiDoW4njDDrZh0UbwfKxHUVb/dBDfrks/DWN5k1EPs+Yu4qtVDP7Bs4xU+yAAmR4kzPDEZi5p6odvYBM6n7DxQR7gGe0LRZLkj5Vcw8SUbTWIQQrrfXIB6eNvw5gTBjTKujyeKEPB3uKXIlA6RQ6PY5V2ZWDLwDZp9S/myuVtQfFQ/zvLIv4FSN3do/BqTX1ekIEvQQES1eJDnQmO5AR0tS0Hqy4RlJnPEPliIHk+FkawC0wMx+giHI24fAF8Az860fM+JacCctfBbYQKTpm9roaAsZYIE3uHjTUplAXcjj4XRGxg8bI3A1yhiNxdtt5xJjAL2rdQB1eu8XsRf2nbqoY8JvUBvkR8As49K/qtOHS40vuTsYfSmPhEv6RkzQd3rs5KcCk7TRohvFcOIN40wSZCA2jvkonAE6b47a9UBo54iOuH1LS2VGcnu0Q9k5khXEz6olDGuVFsaZC5oOrvkKXgvlRfdoXb2U3/04Jrre9+j06c1WRyidx0u1z3/tp8C3Cl+htvFWeBm2g49j1IBfisntenkA8UA6krS5wXdK0wzuTo5/CJxIHJcQHGe2BIvXux5cVDRLenV/Tawbfj58Q1JGYMLUvm8rMa
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7319.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db78b0f3-06a5-43d7-f6c5-08dcabebe701
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2024 14:21:26.0966
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c1YhJAEdwoqbTzRzjuCnyCDSzmOw+j2oBmeQlF2+n863WdpnPvbw4xhWBtRJYHLfn8xjwFVebcuVsjNPWXZBfFVC9w8/o6WiLrqt0L/dFjI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR02MB9843
X-Proofpoint-GUID: jDA78Y7nPSoGE1B3nLSCqYga5cXCr_3D
X-Proofpoint-ORIG-GUID: jDA78Y7nPSoGE1B3nLSCqYga5cXCr_3D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-24_13,2024-07-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1011 suspectscore=0 impostorscore=0 phishscore=0 mlxlogscore=956
 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407240106

Hello developers,

We are trying to validate a Software file based encryption with standard ke=
y by disabling Inline encryption and we are observing  the adb session is h=
ung.
We are not able to access the same filesystem at that moment.=20

Please note, we don't see any issues on validating the standard key with In=
line encryption HW.

Test:
adb push/pull of 1MB file with a sleep of 1s between each push & pull on th=
e encrypted filesystem for 10 iterations and device going to hung at 7th it=
erations.

Dump:
[ 1694.844307] INFO: task systemd-journal:575 blocked for more than 120 sec=
onds.
[ 1694.852455]       Tainted: G        W  O       6.6.33-debug #1
[ 1694.859301] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables =
this message.
[ 1694.868128] task:systemd-journal state:D stack:0     pid:575   ppid:1   =
   flags:0x00000801
[ 1694.868147] Call trace:
[ 1694.868153]  __switch_to+0xf0/0x16c
[ 1694.868175]  __schedule+0x334/0x980
[ 1694.868184]  schedule+0x5c/0xf8
[ 1694.868194]  wait_transaction_locked+0x7c/0xcc
[ 1694.868208]  add_transaction_credits+0x130/0x338
[ 1694.868218]  start_this_handle+0xf0/0x52c
[ 1694.868227]  jbd2__journal_start+0x110/0x24c
[ 1694.868237]  __ext4_journal_start_sb+0x114/0x1c4
[ 1694.868250]  ext4_dirty_inode+0x38/0x88
[ 1694.868261]  __mark_inode_dirty+0x58/0x41c
[ 1694.868274]  generic_update_time+0x4c/0x60
[ 1694.868285]  touch_atime+0x1bc/0x21c
[ 1694.868294]  ovl_update_time+0x50/0x94 [overlay]
[ 1694.868351]  touch_atime+0x178/0x21c
[ 1694.868362]  ovl_file_accessed.part.0+0x50/0x7c [overlay]
[ 1694.868396]  ovl_read_iter+0x180/0x274 [overlay]
[ 1694.868423]  vfs_read+0x200/0x2a0
[ 1694.868429]  ksys_pread64+0x78/0xbc
[ 1694.868434]  __arm64_sys_pread64+0x20/0x2c
[ 1694.868439]  invoke_syscall+0x48/0x118
[ 1694.868453]  el0_svc_common.constprop.0+0xc8/0xe8
[ 1694.868459]  do_el0_svc+0x20/0x2c
[ 1694.868465]  el0_svc+0x40/0x120
[ 1694.868473]  el0t_64_sync_handler+0x13c/0x158
[ 1694.868479]  el0t_64_sync+0x1a0/0x1a4
[ 1694.868487] INFO: task journal-offline:2276 blocked for more than 120 se=
conds.
[ 1694.876656]       Tainted: G        W  O       6.6.33-debug #1
[ 1694.884212] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables =
this message.
[ 1694.893185] task:journal-offline state:D stack:0     pid:2276  ppid:1   =
   flags:0x00000a00
[ 1694.893190] Call trace:
[ 1694.893191]  __switch_to+0xf0/0x16c
[ 1694.893195]  __schedule+0x334/0x980
[ 1694.893197]  schedule+0x5c/0xf8
[ 1694.893199]  wait_transaction_locked+0x7c/0xcc
[ 1694.893202]  add_transaction_credits+0x130/0x338
[ 1694.893204]  start_this_handle+0xf0/0x52c
[ 1694.893206]  jbd2__journal_start+0x110/0x24c
[ 1694.893208]  __ext4_journal_start_sb+0x114/0x1c4
[ 1694.893211]  ext4_dirty_inode+0x38/0x88
[ 1694.893213]  __mark_inode_dirty+0x58/0x41c
[ 1694.893215]  generic_update_time+0x4c/0x60
[ 1694.893217]  file_update_time+0xa0/0xa4
[ 1694.893219]  ext4_page_mkwrite+0x84/0x554
[ 1694.893221]  do_page_mkwrite+0x58/0xdc
[ 1694.893225]  do_wp_page+0x14c/0xe08
[ 1694.893227]  __handle_mm_fault+0x5c8/0xce8
[ 1694.893230]  handle_mm_fault+0x68/0x2a0
[ 1694.893232]  do_page_fault+0x228/0x514
[ 1694.893235]  do_mem_abort+0x44/0x94
[ 1694.893238]  el0_da+0x30/0xb4
[ 1694.893240]  el0t_64_sync_handler+0xe4/0x158
[ 1694.893243]  el0t_64_sync+0x1a0/0x1a4
[ 1694.893245] INFO: task journal-offline:2277 blocked for more than 120 se=
conds.
[ 1694.901766]       Tainted: G        W  O       6.6.33-debug #1
[ 1694.908540] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables =
this message.
[ 1694.917324] task:journal-offline state:D stack:0     pid:2277  ppid:1   =
   flags:0x00000a00
[ 1694.917328] Call trace:
[ 1694.917329]  __switch_to+0xf0/0x16c
[ 1694.917333]  __schedule+0x334/0x980
[ 1694.917335]  schedule+0x5c/0xf8
[ 1694.917337]  jbd2_log_wait_commit+0xb4/0x14c
[ 1694.917341]  jbd2_complete_transaction+0x90/0xd0
[ 1694.917343]  ext4_fc_commit+0x400/0x754
[ 1694.917345]  ext4_sync_file+0x1d8/0x3c8
[ 1694.917348]  vfs_fsync_range+0x34/0x80
[ 1694.917351]  ovl_fsync+0x10c/0x124 [overlay]
[ 1694.917363]  vfs_fsync_range+0x34/0x80
[ 1694.917365]  do_fsync+0x3c/0x84
[ 1694.917367]  __arm64_sys_fsync+0x18/0x28
[ 1694.917370]  invoke_syscall+0x48/0x118
[ 1694.917372]  el0_svc_common.constprop.0+0xc8/0xe8
[ 1694.917375]  do_el0_svc+0x20/0x2c
[ 1694.917378]  el0_svc+0x40/0x120
[ 1694.917380]  el0t_64_sync_handler+0x13c/0x158
[ 1694.917382]  el0t_64_sync+0x1a0/0x1a4
[ 1694.917396] INFO: task jbd2/sda6-8:787 blocked for more than 120 seconds=
.
[ 1694.925099]       Tainted: G        W  O       6.6.33-debug #1
[ 1694.931810] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables =
this message.
[ 1694.940558] task:jbd2/sda6-8     state:D stack:0     pid:787   ppid:2   =
   flags:0x00000208
[ 1694.940561] Call trace:
[ 1694.940562]  __switch_to+0xf0/0x16c
[ 1694.940564]  __schedule+0x334/0x980
[ 1694.940566]  schedule+0x5c/0xf8
[ 1694.940567]  jbd2_journal_wait_updates+0x68/0xdc
[ 1694.940569]  jbd2_journal_commit_transaction+0x184/0x1b4c
[ 1694.940572]  kjournald2+0xbc/0x260
[ 1694.940573]  kthread+0x118/0x11c
[ 1694.940576]  ret_from_fork+0x10/0x20
[ 1694.940583] INFO: task systemd-timesyn:859 blocked for more than 120 sec=
onds.
[ 1694.948628]       Tainted: G        W  O       6.6.33-debug #1
[ 1694.955332] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables =
this message.
[ 1694.964088] task:systemd-timesyn state:D stack:0     pid:859   ppid:1   =
   flags:0x00000a00
[ 1694.964090] Call trace:
[ 1694.964091]  __switch_to+0xf0/0x16c
[ 1694.964093]  __schedule+0x334/0x980
[ 1694.964094]  schedule+0x5c/0xf8
[ 1694.964096]  wait_transaction_locked+0x7c/0xcc
[ 1694.964098]  add_transaction_credits+0x130/0x338
[ 1694.964100]  start_this_handle+0xf0/0x52c
[ 1694.964102]  jbd2__journal_start+0x110/0x24c
[ 1694.964104]  __ext4_journal_start_sb+0x114/0x1c4
[ 1694.964106]  ext4_dirty_inode+0x38/0x88
[ 1694.964108]  __mark_inode_dirty+0x58/0x41c
[ 1694.964110]  ext4_setattr+0x48c/0xa64
[ 1694.964112]  notify_change+0x1a8/0x3f8
[ 1694.964114]  ovl_setattr+0x114/0x1f0 [overlay]
[ 1694.964121]  notify_change+0x1a8/0x3f8
[ 1694.964122]  vfs_utimes+0x12c/0x228
[ 1694.964125]  do_utimes+0x94/0x178
[ 1694.964127]  __arm64_sys_utimensat+0x78/0xd0
[ 1694.964130]  invoke_syscall+0x48/0x118
[ 1694.964132]  el0_svc_common.constprop.0+0xc8/0xe8
[ 1694.964135]  do_el0_svc+0x20/0x2c
[ 1694.964137]  el0_svc+0x40/0x120
[ 1694.964139]  el0t_64_sync_handler+0x13c/0x158
[ 1694.964141]  el0t_64_sync+0x1a0/0x1a4
[ 1694.964179] INFO: task rs:main Q:Reg:2005 blocked for more than 120 seco=
nds.
[ 1694.972145]       Tainted: G        W  O       6.6.33-debug #1
[ 1694.978856] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables =
this message.
[ 1694.987612] task:rs:main Q:Reg   state:D stack:0     pid:2005  ppid:1   =
   flags:0x00000200
[ 1694.987614] Call trace:
[ 1694.987614]  __switch_to+0xf0/0x16c
[ 1694.987617]  __schedule+0x334/0x980
[ 1694.987618]  schedule+0x5c/0xf8
[ 1694.987620]  wait_transaction_locked+0x7c/0xcc
[ 1694.987622]  add_transaction_credits+0x130/0x338
[ 1694.987624]  start_this_handle+0xf0/0x52c
[ 1694.987626]  jbd2__journal_start+0x110/0x24c
[ 1694.987628]  __ext4_journal_start_sb+0x114/0x1c4
[ 1694.987630]  ext4_dirty_inode+0x38/0x88
[ 1694.987632]  __mark_inode_dirty+0x58/0x41c
[ 1694.987634]  generic_update_time+0x4c/0x60
[ 1694.987635]  file_modified+0xcc/0xd0
[ 1694.987637]  ext4_buffered_write_iter+0x58/0x10c
[ 1694.987640]  ext4_file_write_iter+0x54/0x69c
[ 1694.987642]  do_iter_readv_writev+0xbc/0x14c
[ 1694.987645]  do_iter_write+0x94/0x214
[ 1694.987646]  vfs_iter_write+0x1c/0x30
[ 1694.987648]  ovl_write_iter+0x278/0x300 [overlay]
[ 1694.987654]  vfs_write+0x230/0x2f0
[ 1694.987655]  ksys_write+0x6c/0xfc
[ 1694.987656]  __arm64_sys_write+0x1c/0x28
[ 1694.987658]  invoke_syscall+0x48/0x118
[ 1694.987660]  el0_svc_common.constprop.0+0xc8/0xe8
[ 1694.987663]  do_el0_svc+0x20/0x2c
[ 1694.987665]  el0_svc+0x40/0x120
[ 1694.987667]  el0t_64_sync_handler+0x13c/0x158
[ 1694.987670]  el0t_64_sync+0x1a0/0x1a4
[ 1694.987674] INFO: task kworker/u16:3:2154 blocked for more than 120 seco=
nds.
[ 1694.995628]       Tainted: G        W  O       6.6.33-debug #1
[ 1695.002335] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables =
this message.
[ 1695.011094] task:kworker/u16:3   state:D stack:0     pid:2154  ppid:2   =
   flags:0x00000208
[ 1695.011097] Workqueue: writeback wb_workfn (flush-8:0)
[ 1695.011101] Call trace:
[ 1695.011102]  __switch_to+0xf0/0x16c
[ 1695.011104]  __schedule+0x334/0x980
[ 1695.011105]  schedule+0x5c/0xf8
[ 1695.011107]  schedule_timeout+0x19c/0x1c0
[ 1695.011110]  wait_for_completion+0x78/0x188
[ 1695.011111]  fscrypt_crypt_block+0x218/0x25c
[ 1695.011114]  fscrypt_encrypt_pagecache_blocks+0x104/0x1b4
[ 1695.011117]  ext4_bio_write_folio+0x534/0x7a8
[ 1695.011119]  mpage_submit_folio+0x70/0x98
[ 1695.011120]  mpage_map_and_submit_buffers+0x158/0x2c8
[ 1695.011122]  ext4_do_writepages+0x788/0xbfc
[ 1695.011124]  ext4_writepages+0x7c/0xfc
[ 1695.011126]  do_writepages+0x8c/0x1c0
[ 1695.011128]  __writeback_single_inode+0x44/0x4a4
[ 1695.011130]  writeback_sb_inodes+0x214/0x498
[ 1695.011132]  __writeback_inodes_wb+0x50/0x108
[ 1695.011134]  wb_writeback+0x2d8/0x3bc
[ 1695.011136]  wb_workfn+0x278/0x5c8
[ 1695.011138]  process_one_work+0x170/0x3b8
[ 1695.011139]  worker_thread+0x2c8/0x3d8
[ 1695.011141]  kthread+0x118/0x11c
[ 1695.011143]  ret_from_fork+0x10/0x20
[ 1695.011146] INFO: task sync:2271 blocked for more than 121 seconds.
[ 1695.018313]       Tainted: G        W  O       6.6.33-debug #1
[ 1695.025025] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables =
this message.
[ 1695.033779] task:sync            state:D stack:0     pid:2271  ppid:1086=
   flags:0x00000208
[ 1695.033781] Call trace:
[ 1695.033782]  __switch_to+0xf0/0x16c
[ 1695.033784]  __schedule+0x334/0x980
[ 1695.033786]  schedule+0x5c/0xf8
[ 1695.033787]  wb_wait_for_completion+0x9c/0xc8
[ 1695.033789]  sync_inodes_sb+0xb8/0x268
[ 1695.033791]  sync_inodes_one_sb+0x1c/0x28
[ 1695.033794]  iterate_supers+0xa0/0x124
[ 1695.033796]  ksys_sync+0x4c/0xb8
[ 1695.033798]  __arm64_sys_sync+0x10/0x20
[ 1695.033800]  invoke_syscall+0x48/0x118
[ 1695.033803]  el0_svc_common.constprop.0+0xc8/0xe8
[ 1695.033805]  do_el0_svc+0x20/0x2c
[ 1695.033808]  el0_svc+0x40/0x120
[ 1695.033810]  el0t_64_sync_handler+0x13c/0x158
[ 1695.033812]  el0t_64_sync+0x1a0/0x1a4

Thanks,
Yuvaraj, Senior Engineer,
Qualcomm Incorporated.

