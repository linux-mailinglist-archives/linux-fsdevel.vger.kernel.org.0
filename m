Return-Path: <linux-fsdevel+bounces-33360-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9407A9B7ECF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 16:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26C97282516
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 15:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564FC1A3047;
	Thu, 31 Oct 2024 15:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="mTvh0cvt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2073.outbound.protection.outlook.com [40.107.20.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D8A1A2872;
	Thu, 31 Oct 2024 15:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730389453; cv=fail; b=j98veyo11DI3kKb0V+j/JoZryl6KWEC0rd1g2N8E3Lz53cv/G4DhYLSXXaJb5HLt6ih218eANAzVslIlNJ+53KuXoNUR9hcjH8hiTCmUXYvT3q+wAM9esKAFAYWExcahqtrZ4+f43+bAtRbmMy8g4g2s0gtK9AtJCuU74dP9RvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730389453; c=relaxed/simple;
	bh=XSkXE2PVLUXmfkjPTX7DXJ1SMnRlydGTAgUxngGbcXQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=huyV39aAvzgxvM4XXiKEpjbc/Sx+wIHplcmCG6p8H4y2Fxgc+MV6+CkKtp9HM/dPSGmMyxWMkJEzZMCJkXjCAqosRfCoTvRBPS/I+p9CXWoCNA7pp6j4HV77EwDHo5k1znayV9FWjgJOcOtlvjbNh8jmfRtcDSRkYlBKTiOrGiE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=mTvh0cvt; arc=fail smtp.client-ip=40.107.20.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sFpKdA2ajXU7MrHp3XyeFGhvL7x6GsQxOYaXwQFBw55N0DW1kossRsvZw9B3fqutXFseXuw4GORApZm030Wt4i0cDgzWWoSQ3t2jQ/g181hKI7w4MFJOwVBLbiLwbhRKAagMpN3518k0koznMoFeWtRfCRU+kgb3SM69yocqlhDgC9P1wNVkxFrMKSFP/LMNgvOhK9K457QgvcihTOfwf5BWTxL8AplCAzjR5v1MtQldWCLkt5/ZGlfHVP9L8WIiN+r9rTC9pgdivpn44CLaQHkM4L49AQ3YiRQlmxzRrwvGI/KmuE5eDmsmYLGasP1wgrlUd2+hCy1p2C7O206XKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j+40//l1ZFFQiYjwD89l7TBWBEZ3FLu91Cmh76Xllwc=;
 b=WrjbAcnzClYGhLTbx0NAEx9dJeyqkthdWQoG8Mec0jmexpYc+wWT3Os1N9EanU2t0JBqUBsviBtei7ynz73pQIYHj1XBraawx15G4hG4ok8jqICdTFU7JwEE2L31Y2aLcxIfOyUjHxbnPvPDQwyJGAuoTPDiwNuOI01K2JkylgBIwKFYu5pH/aq/5EEFpwmu1aG0lohLkqNtrXchOR9dLvIXeVa9Q/+fE9+DqG6AR65oJun7/PIWrEfdALGaSdxKN5NEIOTDEg2QNPsAXKQlRv7u7dmJVQS84f7bJtXrKkbeJvohIvmYMOkBkRhQNQFmW2Z8UQLge/8Bl5O6CvLLVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j+40//l1ZFFQiYjwD89l7TBWBEZ3FLu91Cmh76Xllwc=;
 b=mTvh0cvtlyW9jrFIL45DO5s+nZSHmX0FPzzKCFN0XePr0zOYYQ3w7giQyc7o5hUT0QZxg0gXDRq3/eJy/XsunpIWVuUrRZNbfkmsa3lq8Y3obJy0NMaVrCBwXGYbAtzqCeQp4CnLURm4TEvbN/zTCG0fYeJkgaJ0M/2rasm2QQ+PEaxcBBjH77nJdoVjpxpceiyuIGo4f62nio/sFhMdOsJtG/eq93xyCozM+W11RzAzBuufNaya1ROukzvxongmzCo2f3VUURp6sO79kdryN/DA4yCco8OUBasLFmy5CpXKElYQSI3ZDmmSdao3KOVcyE8g8+htpAL1rq/sFkzJrw==
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com (2603:10a6:102:133::12)
 by AM7PR07MB6962.eurprd07.prod.outlook.com (2603:10a6:20b:1bb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Thu, 31 Oct
 2024 15:44:08 +0000
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56]) by PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56%6]) with mapi id 15.20.8093.027; Thu, 31 Oct 2024
 15:44:07 +0000
From: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
To: Joel Granados <joel.granados@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"dsahern@kernel.org" <dsahern@kernel.org>, "netfilter-devel@vger.kernel.org"
	<netfilter-devel@vger.kernel.org>, "kadlec@netfilter.org"
	<kadlec@netfilter.org>, "coreteam@netfilter.org" <coreteam@netfilter.org>,
	"pablo@netfilter.org" <pablo@netfilter.org>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "kees@kernel.org" <kees@kernel.org>,
	"mcgrof@kernel.org" <mcgrof@kernel.org>, "ij@kernel.org" <ij@kernel.org>,
	"ncardwell@google.com" <ncardwell@google.com>, "Koen De Schepper (Nokia)"
	<koen.de_schepper@nokia-bell-labs.com>, "g.white@cablelabs.com"
	<g.white@cablelabs.com>, "ingemar.s.johansson@ericsson.com"
	<ingemar.s.johansson@ericsson.com>, "mirja.kuehlewind@ericsson.com"
	<mirja.kuehlewind@ericsson.com>, "cheshire@apple.com" <cheshire@apple.com>,
	"rs.ietf@gmx.at" <rs.ietf@gmx.at>, "Jason_Livingood@comcast.com"
	<Jason_Livingood@comcast.com>, "vidhi_goel@apple.com" <vidhi_goel@apple.com>
Subject: RE: [PATCH v4 net-next 14/14] net: sysctl: introduce sysctl
 SYSCTL_FIVE
Thread-Topic: [PATCH v4 net-next 14/14] net: sysctl: introduce sysctl
 SYSCTL_FIVE
Thread-Index: AQHbJASIFUksbv4MTU2TzyQWLbR4BbKg9M8AgAAaUcA=
Date: Thu, 31 Oct 2024 15:44:07 +0000
Message-ID:
 <PAXPR07MB7984B50A4A61AB10F95C96A2A3552@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20241021215910.59767-1-chia-yu.chang@nokia-bell-labs.com>
 <20241021215910.59767-15-chia-yu.chang@nokia-bell-labs.com>
 <qnrzl4tjlgw5rzlvxavr3pt7fhkslnm4dd62q7uqzb3mfoa2jg@fuayx77rfcs6>
In-Reply-To: <qnrzl4tjlgw5rzlvxavr3pt7fhkslnm4dd62q7uqzb3mfoa2jg@fuayx77rfcs6>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR07MB7984:EE_|AM7PR07MB6962:EE_
x-ms-office365-filtering-correlation-id: ac7747d0-a6b3-4120-70ac-08dcf9c2db16
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?pUJfsW1EIC4aqFpBneDZAfwZ9JFOZB+YJ2m9pgLtu/60iMiSAZtbud8DQx4P?=
 =?us-ascii?Q?FGFh35hnGp4my2U6E6YEXLqntu18euyEMv3wJ8ch6QTlfKgDuiC/oV3P8p2U?=
 =?us-ascii?Q?M9+GvsQZOAtPWLmIvaUSh1neuIkXtRX8XZAEd2FVKcNGlL4O+Bio8HBQr10X?=
 =?us-ascii?Q?UHwDeCOZWURfnNpupeiDA8G3sbOV82M+4dn+xyLMoWYW9rlt+0YuT7PEYpjB?=
 =?us-ascii?Q?VaF6htqL1fGQctLuhF/kukk/643WWpTQre8sYPxF0KMiL+h2l5rT1fy6urBw?=
 =?us-ascii?Q?ueQnaT/hOL8HFfJ9reIsHfZR0Kgup17dlNkHbNObMi1FrpSJsYXPbJdtVY61?=
 =?us-ascii?Q?5fB7fyZJd63+PVKhoDECE9z+ScPrZXycehWiu+sXI0ZbOAkT14Zo3+i2SLEn?=
 =?us-ascii?Q?C5cBxLaAtNovWtZ8HzspUSlgTAUDsw0y0it7uS4KkkoIzavULuRAFEZ36nCi?=
 =?us-ascii?Q?+y5LLUi7ogc/4pRyjg4g7rTc8OqyvxUV0NeOBrhDqkXf8wLbF5x7YMxHDcRA?=
 =?us-ascii?Q?l/hYPEE3L8HhhXuCLas7psEpsD+d7k/Lc2IDVHHUE3RmS2IT3Wqaj8nu8C9f?=
 =?us-ascii?Q?A6Wh/B9i1f9tYgygQzY3CcV1Pm2j18csi1TQ0615AZO71ftvta2GlAX+7fH7?=
 =?us-ascii?Q?ubcxOPLb/XQauUhxBcQa1T3iYHLpK0jz2oJ2dFCWSVFYmtNA3QVoVYT/Fq9E?=
 =?us-ascii?Q?V1BuczvO9krw7o4pP99WHQIJiVClF7y5a2mSBu8oMCG3dEmbFvwAx0FxlvEO?=
 =?us-ascii?Q?6D4aNiDILyTTKVePhftOeb/83VJJFGaIF/IqH8Q2u2AvuKUUdVXKDfapjvx2?=
 =?us-ascii?Q?mStL0o/l/IWAuAacZtM6G7UQ1lJiOKK7ort/Ub1W+mCHjjASySV2xhBQLk+a?=
 =?us-ascii?Q?3rUTpwj2VJMS3sVZc+7fN5A7rYSaJo8XnH61xqtqumBgWdl2eTxwmz+JFQgE?=
 =?us-ascii?Q?S0yb+USHJCay28L3GMzaFVSbK/OaM3m+pwb1Uns+PfPpLiffjhPe8rPGoF5G?=
 =?us-ascii?Q?UBDIR8i8t0xL3fHMWigd7RfKvwn4aBYRNZ4GLZ5MRALgHS8O03KWk3xCQBkq?=
 =?us-ascii?Q?uErwBwFsUqapIXKdW63/JDgp1OSjXHeAlvFnv4VgVogjaSCq8tHP0fJFHSHe?=
 =?us-ascii?Q?hvf7b6OgIYAraOMtSzgmrzON3JoyqNOtv2q3r7t71eZ0L+XLq8R6jkHbaZY3?=
 =?us-ascii?Q?RjrePvw5Xuga8zA/IsBpU7iR/2Ox2NzCDn6jM+v+KHcPeTNbVWD36pc7Y6/0?=
 =?us-ascii?Q?lqoLRMGXhpFMBCuF2ewqkVWixHeujtdaNj1qewSIrdedhKsw3Tn65rULH68E?=
 =?us-ascii?Q?85KQa5PsCMEmUMKcG/6vIqbH?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB7984.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?BB8ZpdnDlveGjyAcWbTvQMoGjtO/FweexP8/lQtOGgsmP4tEvZpq/n0nBaXZ?=
 =?us-ascii?Q?w0dMF62iv5Irpca/MIiuYZ7uz/A7zBnvJ8+6rYJl1f0BPLhXtlPJaQ+OpBtR?=
 =?us-ascii?Q?Hr7GWoA0Q1ubWy6lEsZ6gx6Xu7NRx2RQq+xul7AaH7BqE2abCdGY+okFX0X8?=
 =?us-ascii?Q?G++K8NDx20PthAWiCwKn9tEk5Yhn6e03uSG480yFIJMyUr/1VErpFtmfDmHM?=
 =?us-ascii?Q?1DSZ87QW0CbGivwYdW/lQlpdawP7CAypCF9Nie9kWoA/ceA5D5uQcdXZ/5+V?=
 =?us-ascii?Q?ih4P48hOoiq4rFl2EN58B+IJnPXne8XplH7FM6s4eIaMa1xoOxHjk7k4Wgid?=
 =?us-ascii?Q?pDtXgEA2jy+lCk1Ha8kAFGxQ4sPSFvrr6OhLrhOw5YcxOIdQxRWKegouyV+Y?=
 =?us-ascii?Q?X9JQQjFXmsKCLBRY+Fc7yTPpZnEaBr0EgwDHt/oV0NW6X3zVB8bflImtLfBa?=
 =?us-ascii?Q?srC7zLzYIhl3jvl6lFD2jEJavZ0Qc/I48HugYmPOJBW3Fwfuytqn3b9OjNVx?=
 =?us-ascii?Q?bHs0Id4nhBFNkDmXMaofrGwtwYga0xaXWcAmRDiYCn7/BK1i4ezxX9tAQPUR?=
 =?us-ascii?Q?shfH0w6nmJzm+m44pqf5VpUskyYNvnIY/qNAN7URZcD9o0LEUnBPxmrtkQYj?=
 =?us-ascii?Q?wfsPdI2kYOkotHarxzNMgWHKAbJha3Vxyqf4UuvHuGTp6zh6FeTWWTsUIA3o?=
 =?us-ascii?Q?XlBHw12P6oqbucSlWrGtChuL69SaE4vFDWa7Bf3LkT65OyGSyemXrKgAGA5u?=
 =?us-ascii?Q?oZRx99J3aHgurzHzF+kvnZmF6uqB/IpfmTXB/bqgS9EgTu+eFDBHlHKtUKUG?=
 =?us-ascii?Q?IKBgEp7CsbvHXUmB2TN3WP7BKkY64pLor7Ico3k4G8FXCaERZu6wtfaHdFLB?=
 =?us-ascii?Q?dddhcICA5O2R0PPlrlCLJMI1gyShxOcbYr0WeCxd74J7XmclXLmO639SIjnU?=
 =?us-ascii?Q?sdavfGNHFixQS4r5l03QzdF0pHTcr8aQ7J7TVeIM8iItkygQuDXo+/TVRh6B?=
 =?us-ascii?Q?O4W4F1wV5LYBSlmzc3KN3B63wW+N0hI1zSj4n+ZYaB7gnOaYaUMP5NpZzsbC?=
 =?us-ascii?Q?3lQBBehBh+yyLhRHpYJ/qRfnhLkYimTcJT4VGqGb1/Yv2dR/ePwqJwkU0/fF?=
 =?us-ascii?Q?++g7g2a5it9AhfZxnNHpzMh1isNGPbVluV/fRMbo5OVqjxyHPXzu3Jx9r0io?=
 =?us-ascii?Q?iqTwdOGy6wxik655EF6rELWzrglTSE+jYiFyP+m4FF6fPCo9pAXX/OCGq5MF?=
 =?us-ascii?Q?GlHdHFIkRRhhyvPZRTwGezRvrGrrZ3fTg4nK3S0pjFVNirYOGJupyVFDGMYW?=
 =?us-ascii?Q?TWzFBosak/+esUZUqgyfP+p7UlMZTcXyeFhxuTYdUUYUltkf26RJ0PMDu1Aa?=
 =?us-ascii?Q?9GxyonZIFKau13RKfsuqF572zrfMCMxqcq40/UfmLvh7ov4bmWXORJERnhLR?=
 =?us-ascii?Q?Ur+BWPxLPGZEJqaFOVZXUCf5L+4MdzN9Hc7rp7TUacQcJz7W/L9BslN0YsaZ?=
 =?us-ascii?Q?++g7oraXbtFuXfTbQqrJwZmM9EZrNaMiqXcun+Z66wbaDGhqSTlAqHbCjaJq?=
 =?us-ascii?Q?QmetXG3VOqu7nQt9GpEQCZIBF2tJCzPLOeHGs9mnNeA3fd4iXW51kcWoLE1r?=
 =?us-ascii?Q?dw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR07MB7984.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac7747d0-a6b3-4120-70ac-08dcf9c2db16
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2024 15:44:07.4367
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wMPd9eZkArmUOzzFk9YSujlvM3VI9TMjioTW8DY+69QFv6ebNazQVCtzeVHhxGAKi/ZsA3QmfsVqfQ+i5wSZYuhFBVRRHNSE4uvFrqTbqdlotmqydC5rE0IbXlrqxL3o
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR07MB6962

Hi Paolo and Joel,

	We will remove this patch as we check this will be only used by tcp_ecn in=
 the upcoming patch.

Brs,
Chia-Yu

-----Original Message-----
From: Joel Granados <joel.granados@kernel.org>=20
Sent: Thursday, October 31, 2024 3:09 PM
To: Chia-Yu Chang (Nokia) <chia-yu.chang@nokia-bell-labs.com>
Cc: netdev@vger.kernel.org; davem@davemloft.net; edumazet@google.com; kuba@=
kernel.org; pabeni@redhat.com; dsahern@kernel.org; netfilter-devel@vger.ker=
nel.org; kadlec@netfilter.org; coreteam@netfilter.org; pablo@netfilter.org;=
 bpf@vger.kernel.org; linux-fsdevel@vger.kernel.org; kees@kernel.org; mcgro=
f@kernel.org; ij@kernel.org; ncardwell@google.com; Koen De Schepper (Nokia)=
 <koen.de_schepper@nokia-bell-labs.com>; g.white@cablelabs.com; ingemar.s.j=
ohansson@ericsson.com; mirja.kuehlewind@ericsson.com; cheshire@apple.com; r=
s.ietf@gmx.at; Jason_Livingood@comcast.com; vidhi_goel@apple.com
Subject: Re: [PATCH v4 net-next 14/14] net: sysctl: introduce sysctl SYSCTL=
_FIVE

[Some people who received this message don't often get email from joel.gran=
ados@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSe=
nderIdentification ]

CAUTION: This is an external email. Please be very careful when clicking li=
nks or opening attachments. See the URL nok.it/ext for additional informati=
on.



On Mon, Oct 21, 2024 at 11:59:10PM +0200, chia-yu.chang@nokia-bell-labs.com=
 wrote:
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>
> Add SYSCTL_FIVE for new AccECN feedback modes of net.ipv4.tcp_ecn.
>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> ---
>  include/linux/sysctl.h | 17 +++++++++--------
>  kernel/sysctl.c        |  3 ++-
>  2 files changed, 11 insertions(+), 9 deletions(-)
>
> diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h index=20
> aa4c6d44aaa0..37c95a70c10e 100644
> --- a/include/linux/sysctl.h
> +++ b/include/linux/sysctl.h
> @@ -37,21 +37,22 @@ struct ctl_table_root;  struct ctl_table_header; =20
> struct ctl_dir;
>
> -/* Keep the same order as in fs/proc/proc_sysctl.c */
> +/* Keep the same order as in kernel/sysctl.c */
>  #define SYSCTL_ZERO                  ((void *)&sysctl_vals[0])
>  #define SYSCTL_ONE                   ((void *)&sysctl_vals[1])
>  #define SYSCTL_TWO                   ((void *)&sysctl_vals[2])
>  #define SYSCTL_THREE                 ((void *)&sysctl_vals[3])
>  #define SYSCTL_FOUR                  ((void *)&sysctl_vals[4])
> -#define SYSCTL_ONE_HUNDRED           ((void *)&sysctl_vals[5])
> -#define SYSCTL_TWO_HUNDRED           ((void *)&sysctl_vals[6])
> -#define SYSCTL_ONE_THOUSAND          ((void *)&sysctl_vals[7])
> -#define SYSCTL_THREE_THOUSAND                ((void *)&sysctl_vals[8])
> -#define SYSCTL_INT_MAX                       ((void *)&sysctl_vals[9])
> +#define SYSCTL_FIVE                  ((void *)&sysctl_vals[5])
Is it necessary to insert the value instead of appending it to the end of s=
ysctl_vals? I would actually consider Paolo Abeni's suggestion to just use =
a constant if you are using it only in one place.

> +#define SYSCTL_ONE_HUNDRED           ((void *)&sysctl_vals[6])
> +#define SYSCTL_TWO_HUNDRED           ((void *)&sysctl_vals[7])
> +#define SYSCTL_ONE_THOUSAND          ((void *)&sysctl_vals[8])
> +#define SYSCTL_THREE_THOUSAND                ((void *)&sysctl_vals[9])
> +#define SYSCTL_INT_MAX                       ((void *)&sysctl_vals[10])
>
>  /* this is needed for the proc_dointvec_minmax for [fs_]overflow UID and=
 GID */
> -#define SYSCTL_MAXOLDUID             ((void *)&sysctl_vals[10])
> -#define SYSCTL_NEG_ONE                       ((void *)&sysctl_vals[11])
> +#define SYSCTL_MAXOLDUID             ((void *)&sysctl_vals[11])
> +#define SYSCTL_NEG_ONE                       ((void *)&sysctl_vals[12])
>
>  extern const int sysctl_vals[];
>
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c index=20
> 79e6cb1d5c48..68b6ca67a0c6 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -82,7 +82,8 @@
>  #endif
>
>  /* shared constants to be used in various sysctls */ -const int=20
> sysctl_vals[] =3D { 0, 1, 2, 3, 4, 100, 200, 1000, 3000, INT_MAX, 65535,=
=20
> -1 };
> +const int sysctl_vals[] =3D { 0, 1, 2, 3, 4, 5, 100, 200, 1000, 3000, IN=
T_MAX,
> +                        65535, -1 };
>  EXPORT_SYMBOL(sysctl_vals);
>
>  const unsigned long sysctl_long_vals[] =3D { 0, 1, LONG_MAX };
> --
> 2.34.1
>

--

Joel Granados

