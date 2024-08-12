Return-Path: <linux-fsdevel+bounces-25714-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FFCD94F690
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 20:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AD241F253B2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 18:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE596189B8F;
	Mon, 12 Aug 2024 18:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=juniper.net header.i=@juniper.net header.b="e0trPfy6";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=juniper.net header.i=@juniper.net header.b="Pa6RQZmh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00273201.pphosted.com (mx0a-00273201.pphosted.com [208.84.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB1F12E1D1;
	Mon, 12 Aug 2024 18:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.84.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723486906; cv=fail; b=nVnCSTXHxzd9JqASS3hUBPKeI0+56s9rwYF7TfDdZb4atWrPHMs9bg28/N1oYNkT/pP3EHXbJQxBqexwlHRPnLdC0k0FtVV17aB0FwtAoC/6t1lYil0DlYZZjP5Vm9THDxVRtKm9nDWUqIwgUhekscxEbRPtvxrq9RCryPZ7+hE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723486906; c=relaxed/simple;
	bh=n6d8pOiMqsJ2n42LOGxeotvstR3N4sl1eS+1nxrtW6E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nNww5TieaUGH/nzIogD888rHYV39Hhm+7sEx1I7Wsg3KdE0cCGY7JJza4Busy+WECPYy3HNAXBsjmErhM0IEjlH3KyFCGEsw6E57T/CxqpCbddhi1/CSzeU+XTzvRmv6SQ+xk+IleJywfodtpNNNuVL0AGnlXHTlncpmSgQ7pkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=juniper.net; spf=pass smtp.mailfrom=juniper.net; dkim=pass (2048-bit key) header.d=juniper.net header.i=@juniper.net header.b=e0trPfy6; dkim=fail (0-bit key) header.d=juniper.net header.i=@juniper.net header.b=Pa6RQZmh reason="key not found in DNS"; arc=fail smtp.client-ip=208.84.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=juniper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=juniper.net
Received: from pps.filterd (m0108157.ppops.net [127.0.0.1])
	by mx0a-00273201.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47CD4CW8016620;
	Mon, 12 Aug 2024 11:21:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juniper.net; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS1017; bh=n6d8pOiMqsJ2n42LOGxeotvstR3N4sl1eS+1nxrtW6E=; b=e0tr
	Pfy6d3W8FCdPZfqfj4PXQ0pJMDSJT4CLEsxDqrqsaib6PLGy5XedemmA5eX4mcfu
	/cpqkeK+rIW/d2rbDaxgwP+0wxVEInVGvaio3COw7LSHbE34k4VQ2oTVGg1u2SKQ
	Q9s5KBP894NnAb30LQzRm1l74e07QhztTenrXFAKCOImbYGNULJuooZcIb7n2o+t
	GAJ9OXCG4tRx19OCoCbH0/VDH7Vb+yG9CSy6uiWrMRGJTz56BTILcHvzsHGvJuJo
	G3s+x/8rTiAv0AxEStdw9MNR3sGNIcmS6zANUiO4/tBTUBRWMod5f+PKv2W29w4m
	MQ3U4ZcWxjNoEujsDQ==
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azlp17011027.outbound.protection.outlook.com [40.93.12.27])
	by mx0a-00273201.pphosted.com (PPS) with ESMTPS id 40x7fg3gf1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Aug 2024 11:21:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PpPojCVXy1OE0IpYPxmdiqmGUtKMaeknOFNlZhvph3r3JO0+2wZaiGX4Wbb+FnxNxc7KqDcaMa4k2djrTEuIpNmyJJihRxGaHWMdQ6Bv/y5hCmwTVk1Jh5D+QPeoU8smNjDlD3OV5hufu3VN7yuLY+zl907BBoHllxsjsHBbl8ZLttcuZpLOlOuJSHjLJPYtEnsBtv5Zje2uYTvNczwdI375xsAO6coXrMfvacy0Z1jgRObP7clHviJT7njgURoFuETCF0gE4VMfcxN2MBVH/962PZeeHJb5AkkPL6c35bjNBdVjI13a2nAjQbJKvNiMJAjQdTanJjwrIjmAX+oMwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n6d8pOiMqsJ2n42LOGxeotvstR3N4sl1eS+1nxrtW6E=;
 b=rXJhCWTKOje1L4NPKr+AOqJ66oNFSbEt71s3dyiVY/a4TCnhdunU/hBlaeqAZXRHMG13U2PjCpAxS1dWEg1j8uKlpIGgJ+00yAfBUbuUYOTA/q915fLV419Q31nesktSadn7v5FtshKba1v+5pw0CGPCVwvatvOMO9s2b/rYc35sA1DIY8uq8i8gL3vJ/5rzOZ4sbWpxfo6ytdfuK9yOLxcJaCYER9hOa8OJSa062tIG8mTbn5yDGFe/Vz2t6eWVStlZGVZLA+k5Ar4cqZy8hpvdYGxtr000o1QuuUt8g7WHf/eBsxxmN5nAroV8O9clQVwC4VgW8NVMDjvSL4qYxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=juniper.net; dmarc=pass action=none header.from=juniper.net;
 dkim=pass header.d=juniper.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juniper.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n6d8pOiMqsJ2n42LOGxeotvstR3N4sl1eS+1nxrtW6E=;
 b=Pa6RQZmhjTPDEtTMZa0wSfKNd6qBU2M3P4KxEmbhgjJDS1H4zFvpajRmWvOZc0MtOJMZwOFHb+tXQBU6jFBtUAbZTVQzMdGwJRU+gXvDiQe9kf4UQ2ncaPQwIAkuWPoue/cyFCSCr2C7vXpj2WxAcz2OfB2ne2npAHL9K2GfXyE=
Received: from BYAPR05MB6743.namprd05.prod.outlook.com (2603:10b6:a03:78::26)
 by PH7PR05MB9778.namprd05.prod.outlook.com (2603:10b6:510:272::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Mon, 12 Aug
 2024 18:21:15 +0000
Received: from BYAPR05MB6743.namprd05.prod.outlook.com
 ([fe80::12f7:2690:537b:bacf]) by BYAPR05MB6743.namprd05.prod.outlook.com
 ([fe80::12f7:2690:537b:bacf%7]) with mapi id 15.20.7849.019; Mon, 12 Aug 2024
 18:21:15 +0000
From: Brian Mak <makb@juniper.net>
To: Kees Cook <kees@kernel.org>
CC: "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexander Viro
	<viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara
	<jack@suse.cz>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Oleg Nesterov
	<oleg@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v3] binfmt_elf: Dump smaller VMAs first in ELF cores
Thread-Topic: [PATCH v3] binfmt_elf: Dump smaller VMAs first in ELF cores
Thread-Index: AQHa6Cyyr+Pv/zK/REOrOTMOkQf+lLIgcbYmgAOCb4CAAARLgA==
Date: Mon, 12 Aug 2024 18:21:15 +0000
Message-ID: <713A0ABD-531D-4186-822A-4555906FD7EC@juniper.net>
References: <036CD6AE-C560-4FC7-9B02-ADD08E380DC9@juniper.net>
 <87ttfs1s03.fsf@email.froward.int.ebiederm.org>
 <202408121105.E056E92@keescook>
In-Reply-To: <202408121105.E056E92@keescook>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR05MB6743:EE_|PH7PR05MB9778:EE_
x-ms-office365-filtering-correlation-id: 15e1b3e5-a3bc-487e-0936-08dcbafb8da4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?CsTVb4aP54ELOA8S04nYOIhUDtGQLyIWNi8lRWJIHB3ykgUNWjC5pr+QZn/U?=
 =?us-ascii?Q?r+8MmIQmLozWIb/Y0PkcEEtoTME7Yi4u6SfudSakbUYEBaDnKUzDgIwXRI1N?=
 =?us-ascii?Q?IDCDLexev9Y1C1LMv4LQymoflj5gf27h463tWckCv7rlaKHxyuGY86Z4XULR?=
 =?us-ascii?Q?dKcJdIIDFIz2FkDOYthEu/olZMHX+edmxctE9ZPEAPSvP2RS4CGYlf8+2cye?=
 =?us-ascii?Q?q7bmLIPDjt4DDSHJrK1u3t+EYlRoalvE59hIfy6b8OYS0auq3ZeLeHHIYK8G?=
 =?us-ascii?Q?gagDL7Jlk/sALbA1KerFr4IP05VOits5pB3n/WHnm+YVV/IIuEYyaEB4H8gE?=
 =?us-ascii?Q?+Tq/b2Cy34e9mG9C5zQQZX6vXSDkT3tI74NaQpVKe8SddOIV1ZQZNjudVD0c?=
 =?us-ascii?Q?y1BxG6su7QaccJFPjlj9RqOwSOpAmnpkPM7KCs7tpas01xWF8+nA9/GBWtvJ?=
 =?us-ascii?Q?+8IfjBqTrhioXqJVjlB2XWQRR0fbX6ZBw8m3M6ihW8qZoGenjzR8Gyd2zXmh?=
 =?us-ascii?Q?Ww+grI0qgDMTo+g8k7KyMhw9eutJkLeqJ1w/6+rLzKG+nk7bwMLO7vkevCwX?=
 =?us-ascii?Q?8zVH+4CoYwzi9ZeuCzHuhUOn0wQh4DL09pas/hiVCvWg9kKHsQTCY0l8xYJ0?=
 =?us-ascii?Q?uiX2EG3gb9TOwvrybQK6kZ3Qs/Zt2m6ZeRGo75rGHeuOYTrfESHqOgLuQcaE?=
 =?us-ascii?Q?U1XW/vTce/4RjLmavUB7AE5UjViWBP+bh0jZROKjwHlrcZ6d6J7HjD0Np7q3?=
 =?us-ascii?Q?yX1NNoiyExACxVS42y/teOBbFOEVFlrLv8SyU1Zu2/rz+EXMfBN7ogiAbEqi?=
 =?us-ascii?Q?gFoxepnb2lcNTwszFLWT9eetmme9KELi2EZifJNaE5VyArK9Dt2PAYm1vK7T?=
 =?us-ascii?Q?sVsHzm/XAgIUei1BAq/Xr/ewwETkKujwAcwTLu8unfNPW5usR7CGqHOXlgY/?=
 =?us-ascii?Q?zo4Ckw5ynLmdn2ORMMY0qvxN+CMDG7KIwXK8JgIlSKKeOHyopwZgSZNMzpTb?=
 =?us-ascii?Q?3Fs71L9cynK42z+Z21pKbpc4aQKZMimGK+VyFww7ZWc8nneKGPO5iRa5aaas?=
 =?us-ascii?Q?15QXR4RMZgazmSbBOaUbJyzc1MvqZ+6dO2wbIpvc4cAOnKHJYMe061sUAFGN?=
 =?us-ascii?Q?jUT7nrAIj2i2hIlxMyA+ME/bob3c7ld/7P7yL4VUZNwbpJIAJ9kZLW66vLJv?=
 =?us-ascii?Q?r+bOx2A6/4uSW+40GZC1E32YJmS9sUySHw+X/N+OYjA8RNzuDPBrgFUk79N1?=
 =?us-ascii?Q?eejQE3Q47CJm1q67NHkswTKPhjx9qVzLdUVMhcBa/qmDf+DDxoApzQYCRv7o?=
 =?us-ascii?Q?9veSS9wO0gj7B6LvAKs10LMX?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR05MB6743.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?uWmV9oGzwuui6njYVIdbhsa4CUXnt/OTQLSAIUNjJWNKX6ShH5ZowdhMPehj?=
 =?us-ascii?Q?7lZRygtvhnL1bNml9jedFPx7bk/MAfrFcEB0ggeLjJkc+8QXr08x8qK2HSIe?=
 =?us-ascii?Q?+8XXQWPHvmgzUiMM2HDgOwtCNEmTf7bJw+zNbYPRW24GJJBKfep0bJCEIc/J?=
 =?us-ascii?Q?w5SyhavIanYeM1eIMVKhrrzit2p+e44d9kBz+O/cmUF3+sy07sksWqjFORTm?=
 =?us-ascii?Q?r7F9+5bj2z3K6gfquR6Tp7K67LD7tHpkssTaadXEbTvQewYqJ/iu9ziA2rrG?=
 =?us-ascii?Q?uqNlTFBIZEncjcbSSAQ2kusqrdHd54MbJrJPdN/Vyw2zlIxHmzIJ9vQoCoj7?=
 =?us-ascii?Q?xsmNq6UhsAXts4VMmYupN//9/rPBiOhH6NBD92GZHxfY025CuSKHNtcBKAtQ?=
 =?us-ascii?Q?qyvkDjVb9YJkN5KS1tJ1EQftRyAZSm9D7DlR/5IRvRJaQQToQZsrX85vJrSq?=
 =?us-ascii?Q?clPDyhcvSn6ocYgu7dGaispLTlm91qbHxCQPMEPCaVbpqoGpqaZQJpHoErS1?=
 =?us-ascii?Q?AB3gVzdp/7Hka0/JhDS6AsNPFAThgwzTgnfi+uJ9kIG8Xv3inIRSUmOdbzfv?=
 =?us-ascii?Q?fLHtcpClvEtjzy09DsqRw6gNHkhd8k2TBZdX439LaDz2brrcnLYWS0mwSjjc?=
 =?us-ascii?Q?4GZcNoeSoGNw+a7b0MQsRwTctCUCs309R2tBKKJVkTfAzv+BcC9PYp7DU/tG?=
 =?us-ascii?Q?fZWoWgIBxCdEPtXyXGsA9SFWdgqI7pQrQ1lCl9uBEeI7n/QYJwLwcl2ayo0p?=
 =?us-ascii?Q?t+/gvul8fhnEHMBdkYxHzAppjB6ySiIA9g4q1lbzNjHJgUQsOQv9i88nSVpX?=
 =?us-ascii?Q?Hz93ObuIF9erRasRbSxkepl+6cFp54OjUUHqbQ485vMMWk/MZAzPL9/Fsu+2?=
 =?us-ascii?Q?+ZMQHrXLPHZdF3ropeQ/4SpooLqRspjmKbPEhtSq7Oa/Lh9P7LhsMiyCHx6n?=
 =?us-ascii?Q?DC3LFy7C2eC7QdUxXQ9Pc4fZUV7Ug/ZDt8hGmiE85dCouHAMjGQ0IV4sQl5J?=
 =?us-ascii?Q?0OAhGABXxSqSz2Y0kfySCkB8mpwBPSJNsWiHQmejtE8qkyS1lyrcHD7OJMLA?=
 =?us-ascii?Q?CXZuJIAO/sjM4Ze8XE9feDw/fXJNhah4tr9Nd6GspKWpBlgesOPyBxO72C5W?=
 =?us-ascii?Q?tawoJOrsJHukUXjZtlo+u7xK6hBBUidAWkE3+8OAVZq2VVmQYzpKXgf+wiO7?=
 =?us-ascii?Q?8SdDV8Eqgy0ZPjV8eYWLCMnZWc2EsF08vB82WGPOwCV/+yLdpTinRkBFCt1u?=
 =?us-ascii?Q?pcigspJ30nXP+ChYauDzqYRz6ncycGU64rKu3Cfg1AzjF4SZUtEbQOGl9Crz?=
 =?us-ascii?Q?DYsLkjcBw5p5pEvWrQ7bMdl+ehVJ4MffuSxwaAh7xXKFhY6piqjjWDi9Bkvh?=
 =?us-ascii?Q?13Hvtc8d/KHq4ZkQLDCYpwu+3lXIqwxFResuV58R5No2xc9DwqXDyOl9Jids?=
 =?us-ascii?Q?BLVLvWrW+J8EdX4WUs7aHGiMwJ1mdbL6NKsWYvPXpLUyDYjOMPh6rcjAKC/3?=
 =?us-ascii?Q?i+yY5cK8JnNhhPtJzXDw16Dtp0EihVynNUWquYVpjnVwlmly0DBkMjoEhEGf?=
 =?us-ascii?Q?w5PlhgUItEvnbLHHOK8Qam0yBoff5qVc1D2Lw5tn?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3C791E09FEBA554CAD533364ED604D08@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: juniper.net
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR05MB6743.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15e1b3e5-a3bc-487e-0936-08dcbafb8da4
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2024 18:21:15.5123
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bea78b3c-4cdb-4130-854a-1d193232e5f4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L9yRHOu4HrWlxv+WoqXgcu/AJBgItk/Tq94FOuDV578NbLhxrLIc5r6wuICbp+dz5wxz2OAzE4pcSg3KMWqSmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR05MB9778
X-Proofpoint-GUID: rrucjevZXPaHivxc2muyjDDT-_Ea53K8
X-Proofpoint-ORIG-GUID: rrucjevZXPaHivxc2muyjDDT-_Ea53K8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-12_11,2024-08-12_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_spam_notspam policy=outbound_spam score=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=791 mlxscore=0 adultscore=0 spamscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 clxscore=1015 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408120135

On Aug 12, 2024, at 11:05 AM, Kees Cook <kees@kernel.org> wrote

> On Sat, Aug 10, 2024 at 07:28:44AM -0500, Eric W. Biederman wrote:
>> Brian Mak <makb@juniper.net> writes:
>>=20
>>> Large cores may be truncated in some scenarios, such as with daemons
>>> with stop timeouts that are not large enough or lack of disk space. Thi=
s
>>> impacts debuggability with large core dumps since critical information
>>> necessary to form a usable backtrace, such as stacks and shared library
>>> information, are omitted.
>>>=20
>>> We attempted to figure out which VMAs are needed to create a useful
>>> backtrace, and it turned out to be a non-trivial problem. Instead, we
>>> try simply sorting the VMAs by size, which has the intended effect.
>>>=20
>>> By sorting VMAs by dump size and dumping in that order, we have a
>>> simple, yet effective heuristic.
>>=20
>> To make finding the history easier I would include:
>> v1: https://urldefense.com/v3/__https://lkml.kernel.org/r/CB8195AE-518D-=
44C9-9841-B2694A5C4002@juniper.net__;!!NEt6yMaO-gk!DavIB4o54KGrCPK44iq9_nJr=
OpKMJxUAlazBVF6lfKwmMCgLD_NviY088SQXriD19pS0rwhadvc$
>> v2: https://urldefense.com/v3/__https://lkml.kernel.org/r/C21B229F-D1E6-=
4E44-B506-A5ED4019A9DE@juniper.net__;!!NEt6yMaO-gk!DavIB4o54KGrCPK44iq9_nJr=
OpKMJxUAlazBVF6lfKwmMCgLD_NviY088SQXriD19pS0G7RQv4o$
>>=20
>> Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>
>>=20
>> As Kees has already picked this up this is quite possibly silly.
>> But *shrug* that was when I was out.
>=20
> I've updated the trailers. Thanks for the review!

Hi Kees,

Thanks! I think you added it to the wrong commit though.

Please double check and update accordingly.

Regarding the sioc tests from earlier, I've reached a point where I
think I have a compatible virtual NIC (no more ioctl errors), but it's
giving me some mismatched registers error, causing the test to fail. I
can see this same test failure on a vanilla kernel with my setup, so
this is probably either some environment issue or a bug with rr or the
tests. Since all the other tests pass, I'm just going to leave it at
that.

Best,
Brian Mak



