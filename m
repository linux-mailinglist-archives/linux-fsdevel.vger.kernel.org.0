Return-Path: <linux-fsdevel+bounces-56815-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5518B1C034
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 08:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81E463B959F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 06:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81CCA1C7017;
	Wed,  6 Aug 2025 06:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="tif2PJKd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazolkn19011024.outbound.protection.outlook.com [52.103.33.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4914651C5A;
	Wed,  6 Aug 2025 06:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.33.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754460193; cv=fail; b=IRW7Z7UavUp4+FnmmWh6OtxDEhd2qbqhUSLazqP4/Jy2x67D29WRcjP79s9yrsb3rdeJGvP5wLy+lFalGQGXaOSWbXbzly3y7xHTYhjxANeIiVo0fMTz+Akz93hycubEU7/+k8cxItceEh/Qa2HuTxOzDD61vyIRr3x7kaWu13c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754460193; c=relaxed/simple;
	bh=gWw3CEdjwo+dc+7viSFSXas0Kv9ZLBlh1WFPnebDw6U=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=lEHY/4NUO/5DihIoLWvr0J+5Or23e8cYsTLFZhTIC19IdEawgVt4d+p17O2M8oD4PMTrM/rGeWdXWE1idW3tM60pYDM6a9vP8pTm/DJgimoyn3kqYUooncK23FiKxjJlfL5+thzpMuUr97XGRFZKHz4h2L/lvvAYzVyLjpTfI4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=tif2PJKd; arc=fail smtp.client-ip=52.103.33.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gmNj+qoKEzBezWw4PA4/aBA5o7x7bVUmGiXMAsFPxCkn+Qw300OSyisaG0syM7yECJf1jCOWe0ojmr5P9Ps56uwrU4QN0v6IZ82ajrmX92t4DIjwoBMIgYh8HufIii47r7/poXDwgOSPQXDxI8pWsRIA/3w0pCCgG9wOz1YJr5pOzr4jzRWQx1I6+ZzGm9YGeR6w54ji3oJlEqKuLcNoeGZGFxjzQiaaSATghpC8Mxj6Hk3IeCQHa4yG7rsegr0EtHNenJ96nS1ueafTBCZVVBnyXuiZwthwAIjf1ObUaiMGN04Nj9haNCYHx+AegzIz2Lf3u2TW8RKUCO48AbIHdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LktEqotsmVK24orWcsm9q3vL5c8Tq1cx6Zu6kSIDs8Q=;
 b=ka7EkEo1rR2ZBg/aH8qaVwM/jA3iY42Y2/KgQPTcnYwV8Lm5fl39NKj9hU5SlXs2QTscan6UoggjAZhcieETcdJbFf+orScELoz8DLjyQeqmG6JEfqF9uThoV8Vt2vkwydUzJZ3UvKQAS9YPWEdkBSdzjggexq07sMCv9mJYEmOpfAvBJghTiwFm/zUQCtxCITkLWxOqhXfV/d1J2agQ6IfJyZDbMS/laFCNJi/WZw6qmeahO+717gRsMPPGg8PivnpDpdGYNAMnW/sF13X3O+aHYEhOf5WwenJwzNojIlQhclIZcnDnq5eowY/z7AOMKy3vdBeFDUwdyIbFY90i5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LktEqotsmVK24orWcsm9q3vL5c8Tq1cx6Zu6kSIDs8Q=;
 b=tif2PJKdudW/4BhMMZyaUnmyp2SampaGHlkmbeseHHwtawVUTI3fEFNxddmjOF9Uwwp5s3J/l4LIVLeH6gCf0po1aXtXhYdI5xYwsqEeB2n9WM7/aGwCmxxYlbjx1m1cbGnnNrPhO5rvJZB/49DsEKtXFLtXedyWuiNA6Ny2QnY7F9u8FuvDuBRhNKxEoxMu3U3Hb8ebdJVXKGWqV3vu9gSU5ZzqPcp+rNrWGxmfEBCn5OZjgy0RYb+JxJoZV2bHeBf+9qAzslf+Df82QIH3c+1sA6d0JOOej2SxMq/IruC8rqq+hzLlY3Zy/N6IvsvmnteHrNhSjJau5aVpcoTWkA==
Received: from AS8PR02MB10217.eurprd02.prod.outlook.com
 (2603:10a6:20b:63e::17) by GV2PR02MB11369.eurprd02.prod.outlook.com
 (2603:10a6:150:29f::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Wed, 6 Aug
 2025 06:03:09 +0000
Received: from AS8PR02MB10217.eurprd02.prod.outlook.com
 ([fe80::5556:4de5:6245:a3c]) by AS8PR02MB10217.eurprd02.prod.outlook.com
 ([fe80::5556:4de5:6245:a3c%7]) with mapi id 15.20.8989.018; Wed, 6 Aug 2025
 06:03:09 +0000
From: David Binderman <dcb314@hotmail.com>
To: "dhowells@redhat.com" <dhowells@redhat.com>, "pc@manguebit.org"
	<pc@manguebit.org>, "netfs@lists.linux.dev" <netfs@lists.linux.dev>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-6.16/fs/netfs/read_collect.c:575: Pointless test ?
Thread-Topic: linux-6.16/fs/netfs/read_collect.c:575: Pointless test ?
Thread-Index: AQHcBpd55YHW9Nnr7kCsjSd/BsBJ8w==
Date: Wed, 6 Aug 2025 06:03:09 +0000
Message-ID:
 <AS8PR02MB10217782094C222870CC5A7A29C2DA@AS8PR02MB10217.eurprd02.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR02MB10217:EE_|GV2PR02MB11369:EE_
x-ms-office365-filtering-correlation-id: 2d1663f6-1a29-412a-e0ed-08ddd4aeeb3e
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|19110799012|8062599012|8060799015|31061999003|15030799006|15080799012|39105399003|51005399003|440099028|40105399003|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?TO8d5sIrWy0Qhp+nvZbdXF6ZE1lfNp23nZTfCetimSdBvbz7f5Gf+3SSTU?=
 =?iso-8859-1?Q?GXXXG6RjYaDvWwi9QMFrKNdZnQqU38xPOCaVCP8OUUmLvCZhtuC4OW1Rah?=
 =?iso-8859-1?Q?oW29J87G3KE2/uWfwdHGOI/EWwJLUW9qBVn3mcnAcosyK3Nd9EgryLZdKr?=
 =?iso-8859-1?Q?xNrJuG3OYzkv1SFWGG7AwDGClqVLlbQdXDiF8jqqp9wrBFAbLa0VpUO/sn?=
 =?iso-8859-1?Q?Msf2hI+cBnvTO12vTZD9QjbUH/8KQLWsY5qd3+ocAP4hfrbT6/kPOVkS44?=
 =?iso-8859-1?Q?byHt0VnyjF6r/jCKfbOYj5bC4Xzp1hgtjHr80YY3mw33Exxu+gc2AS+sHL?=
 =?iso-8859-1?Q?lN+FBWeVjA+6H4/EDBm0ZnpkPf5fP0FQ+13UFTnsAHBgD+wmVauM+3Dbv6?=
 =?iso-8859-1?Q?+lGqg0Xp4wWlCi1KtuLFKMEZ01bqrheecYD7+gf2Qn8rwIDjMKRlo7f7gw?=
 =?iso-8859-1?Q?8b4bhlu7XhGWeM2CVyZrxUxBCzFu40sQ3lX3DqutOJgGJ6C9TtcRZUT7Eu?=
 =?iso-8859-1?Q?DBMWSOPEzVGDdS2MQld0Q3jUStFFFjMcqFFLOWeytoMoazfepQ+a5CnoEr?=
 =?iso-8859-1?Q?Jtbe6CrqlzmqGaomdyN8RzyGA6Vk6VEjCM9gkppTD8K5eFs/aYU2fpnYPx?=
 =?iso-8859-1?Q?W2kpkk34AUNrwhS+3I1UiEXGs2yicNUclzMXW5z6MF//3vU056V/K7HfcS?=
 =?iso-8859-1?Q?HHx87OND66/DCRYfPzer8f0bCB25CQqHmLeGVpbaJJddlqUoDmfJiPZSLf?=
 =?iso-8859-1?Q?gk6mCdnXyirOUjW3R9wNQT9Wg2aG7mt0fdJ3vnuGcfI69UFQdMSq/7Roxi?=
 =?iso-8859-1?Q?BL2PQfgKhMO8OtleisQmV1FLvoSrXCTF1Oj6lWZo1+vYtgAWVs8FFPuzUQ?=
 =?iso-8859-1?Q?UNiaPC/vbpXMJ+BjBiI/mezUQrWKyUaMyc0DbpbcoKPDpRvEMqanNzQYs2?=
 =?iso-8859-1?Q?Z5fnwMovM9HjsmIIJgpY92LLzs5jvN3zcZaU7j+25kv1M9SFtJ8RYbwpj5?=
 =?iso-8859-1?Q?mcY+c/5DkxnN2kxPXYDMJfCcZQLSGx9YGkZnGLen4AAcF+qsRjXJcXV/JL?=
 =?iso-8859-1?Q?bqBF2YIYOKGm0A1b/N8W4KMKY6Nw8Th05yF3gNdUq9MbCXL4ibM6QINhMM?=
 =?iso-8859-1?Q?vzrs/zQc3XCVgpHUufxna03zPvFd1y/Yqc88n2OXLSdl5z/uWIqmaBYcje?=
 =?iso-8859-1?Q?sBVuY3kHMkyYoSbhDkDXyXGTbgYFHM4yZUN3tTfH7qgxqw0SuCUvbFZmoe?=
 =?iso-8859-1?Q?JIRAfnSGcCVC+a4E2oBBkxkk2zbHIotqRoItNstni6aXGfpIziRWzwba86?=
 =?iso-8859-1?Q?XzlI?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?XMlal6RLtZ4n9ZxsWEqG2kV39MTMDX7Jlsz8WzPiccpm3jRuKDOAu7u2KK?=
 =?iso-8859-1?Q?0K0eYNVkFIa6rbWRE3LEAg2d/riLa6A+re8gjGEYGVhb2tR66pEHDe0RER?=
 =?iso-8859-1?Q?ODL0a3Ixtrrd2oL4OE483s4IRl5NUAbpaBNozQmw64phCFsJ9mLyTyVyIC?=
 =?iso-8859-1?Q?mxod1EjC1ClUjHpClskM9je4769THD21uk5wLjOpSZfnFjm01Wi5jDj3c8?=
 =?iso-8859-1?Q?0B3ZE/6bZ962ljFUhow1KRq+GHEnl6qgRwwxiiI/GvAOMzma9wZY+2ClEu?=
 =?iso-8859-1?Q?BXr2DSI0EEDXPNkOgZ7McI+MMyPoqZX9dXOGzqGq1FMT6acKPF8rodvQlx?=
 =?iso-8859-1?Q?uXZdt2HSumKmLAvld9+LIowrI2ygmXlVVBQe3VnyWqEtETfHunafgCu7OL?=
 =?iso-8859-1?Q?op1c8S/WhAKnja0woHWhz5rLcoOdZ/jTt49ZcRSKFAvFc0atQfGMK9/mQk?=
 =?iso-8859-1?Q?zjB4Xjwbj/dGKmZGUob0c1GT3TiPsftabF2ET498GC8+0bzwh4DyDUUJ4b?=
 =?iso-8859-1?Q?FPoDWJk1fRMeWxZGKzC72qhruEoP4SgueZQbpGU50wjw/uErh8ovaE30vT?=
 =?iso-8859-1?Q?h+ee5LyakRm070jNv0TN3zO16+wzlgd2NtwKhXdrTUifQxRGSxyJw5tZSO?=
 =?iso-8859-1?Q?KLrEDnuldWsXDwtp3fZX8l8pBrrXGNKd0vb1QFtcPPnI0D+kzt33SFWZXI?=
 =?iso-8859-1?Q?sU8/ufnH8r7Pog9maQNOdzHnoQ1umNqbAvpDjz9R5gbfSiXBuCoSFl8v2X?=
 =?iso-8859-1?Q?j8v6q3DrW3YoEqeUs/Qzbt5FArOqrXlCP2YVrReNqHpx8h50uTCOLrneBX?=
 =?iso-8859-1?Q?ywFTpVYmDZKhFRApr2G3nDmCuyfn1Kc6z5S0pLAftbHCX3xLGC9LR1/85G?=
 =?iso-8859-1?Q?ugvMt40ph0P2XJoblBD5Egf1N4iV1twBfs7fi+TYTpNbmocSy5XByHdSSA?=
 =?iso-8859-1?Q?r4jjQJpT7XE2LBd6nEecTxlXjwjWrUb1DZ4e8xZ3l8kDjOEsv509C/gIiV?=
 =?iso-8859-1?Q?iT6Eq/CnHCqJepPGlPFqU8wk3Nq+ucwyk7aiVo9LDpXKRJUqQgIoNwVTPX?=
 =?iso-8859-1?Q?CuzG+xBK5hqA4FElYPjrMAEqUsms18RJpGu3APlDF9ErBAP4zg3+jdAVaf?=
 =?iso-8859-1?Q?D/ku8Eha6YaAnPpjwiHdlN169/ezhE9EJdG/t8h2Cqz8fIA7DXS53+3mFv?=
 =?iso-8859-1?Q?vsiFFCFwt9CoM9v8U/+MNjPtbQ+58ybmlABza22YnYv1fCpjo7sVZRqjII?=
 =?iso-8859-1?Q?SoI7TSWKpPUqf9cdJZcg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-8534-20-msonline-outlook-5faa0.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB10217.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d1663f6-1a29-412a-e0ed-08ddd4aeeb3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2025 06:03:09.2480
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR02MB11369

Hello there,=0A=
=0A=
Static analyser cppcheck says:=0A=
=0A=
linux-6.16/fs/netfs/read_collect.c:575:28: warning: Identical inner 'if' co=
ndition is always true. [identicalInnerCondition]=0A=
=0A=
Source code is=0A=
=0A=
    if (transferred_or_error > 0) {=0A=
        subreq->error =3D 0;=0A=
        if (transferred_or_error > 0) {=0A=
=0A=
Suggest remove second test.=0A=
=0A=
Regards=0A=
=0A=
David Binderman=0A=

