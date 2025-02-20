Return-Path: <linux-fsdevel+bounces-42138-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC9CA3CE0E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2025 01:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D13A27A8852
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2025 00:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20401BC3F;
	Thu, 20 Feb 2025 00:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=juniper.net header.i=@juniper.net header.b="oRSvfkOj";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=juniper.net header.i=@juniper.net header.b="gsttkRlM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00273201.pphosted.com (mx0b-00273201.pphosted.com [67.231.152.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A731401B;
	Thu, 20 Feb 2025 00:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.164
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740011038; cv=fail; b=rOV1Q8XYNtnW1CbvKqDb6CxRmYYvS+JTaeyT2diWEMLojSsvc1PzWnlKS7XDpKN6Iv1Zy0QIwT4bZxgljxNcjhU8NSrTGofBcC2QojJK1PNoe4G5kuGfEy3mg0FnjjWWWRLOfEmafQPSdabCLf03fPdi+Mht8zh6FGRtv5dUxW0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740011038; c=relaxed/simple;
	bh=6uCjzPrWcpzHcRGRuqlMftFq+2iKd/lqVem3XUQqVF0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kBIihX4Sdhuo94P0dSIGoi5ag+GY51OaGXopNf2cw416Oje5tpmWZhIWKv50WGYOf0HKO0BxazL23q+lfFbjxt1wbcJ4bze1lZK49XC7F7huEcMXUX8LxFWTXCY2aXtotnn7+CmMVlSWTyx0h5RNm4xFOGFjDwl0rqX16D2x2F0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=juniper.net; spf=pass smtp.mailfrom=juniper.net; dkim=pass (2048-bit key) header.d=juniper.net header.i=@juniper.net header.b=oRSvfkOj; dkim=fail (0-bit key) header.d=juniper.net header.i=@juniper.net header.b=gsttkRlM reason="key not found in DNS"; arc=fail smtp.client-ip=67.231.152.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=juniper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=juniper.net
Received: from pps.filterd (m0108162.ppops.net [127.0.0.1])
	by mx0b-00273201.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51JFhlPi003763;
	Wed, 19 Feb 2025 16:23:42 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juniper.net; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS1017; bh=6uCjzPrWcpzHcRGRuqlMftFq+2iKd/lqVem3XUQqVF0=; b=oRSv
	fkOjj8dUYJa377ghPIuSDV3rSJHLfOs66EH4jeyfEc4D8Wdxl0R20f95F/EqzKvN
	6QaQYQ7s8sdYgmYk/auaE4XFwW3yx09mCBp3sRPaQAXuZ84vpxOdAcJ6uqc50KUp
	VjjtYs4VPfTaq96mNfvh3TT/kOflLbSvOdhKAIbecraZkBJNWINovjXL9nK2gj33
	D1UwGsjdzRKzXtIAQYYWUoh6zibzEdTuIyXuMF4q7e+tWBZWBbysIQg09L9w1xb1
	n3qnEmPeevfnlFThMe43gu6a4Uao6Icl91XA5UKDyvjoFk2OVkuNyW1s6yVa2Wpn
	Kziw4/9V232NZmHWVA==
Received: from bl0pr05cu006.outbound.protection.outlook.com (mail-BL0PR05CU006.outbound1701.protection.outlook.com [40.93.2.8])
	by mx0b-00273201.pphosted.com (PPS) with ESMTPS id 44vyyukufb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Feb 2025 16:23:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T5JUBVWjn2MQ/7KX9IV09k/sQZEia7F/tG+SSck/t6Q4clWpFFdz0KLr0qRC/EwM3Ng7set3Q9xZQRAALegiOoyw1werU2IHfWmz79U0nft5pPU0shDq1uPZeWLFKig5xf8C+bQ/WA0TRI4PHvolcQGrmS8vP+EZ2zEWi4i+jlKXeWsKIFtT6oDZ/ibaEG5e23xLKBGO4h4LTuqSF5rpmPFhwvaqnzPxYB24z1YXGyLukUcyK19KPpTUo7NG2TdLFJNe1v6wOXim5zh+QXJ0QNqN3myKQEzTLgUbuGabTAQ7i9IB90wTuZlDPr0IYu2/bmtGsMD3N+qn02aEhfFB4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6uCjzPrWcpzHcRGRuqlMftFq+2iKd/lqVem3XUQqVF0=;
 b=XgEsjNKqgdeMkrRKP6d/tlV93Ta1toPXdm0zJnX/t5oIDI+p8mrkuvDHxygP1HH9Dz7B4XX1MbJl3JRHjaCJqHTTx5LkpVfRO0/eDxI2y/n34jSmGyxyCZxIYii6Bb5j+Bw6f/7wNEn3/O7SSfYgvORaxSx3mbWCAqF2e0rb/Exm6H3feUlg34RgRqerImW9cI6Z1Bzh6pFLnWTHUE2ezarSQKoGPYFlVyyrFW8c8Z7aEqc66T+9Rlgd+oufsSIl3I3r7i+BNHfQ+N2C+YhZGMuyrH7eI5hT5yTodMS74aw+P+H93doVquEg4H9WiCxbSvOVL49odIDwAfJnF29D4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=juniper.net; dmarc=pass action=none header.from=juniper.net;
 dkim=pass header.d=juniper.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juniper.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6uCjzPrWcpzHcRGRuqlMftFq+2iKd/lqVem3XUQqVF0=;
 b=gsttkRlMLjXSJcy4wlIQ9UEaqzfQqeRwdNIzcODaUXJs6zjP7ZJvK5NW9lE/7IayEu/huTSk4qZftbADhTRwV0SLjHZDovlWq/h2t7xaFI77Qhv65NbPz2ZwQp3OrE8IbgZbvrCnpq0G9Z2cuNUHlWLl0bJxV/5COQalqyvxXgQ=
Received: from BYAPR05MB5799.namprd05.prod.outlook.com (2603:10b6:a03:c9::17)
 by CO1PR05MB8457.namprd05.prod.outlook.com (2603:10b6:303:e8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.17; Thu, 20 Feb
 2025 00:23:40 +0000
Received: from BYAPR05MB5799.namprd05.prod.outlook.com
 ([fe80::e33:dc6a:8479:61e2]) by BYAPR05MB5799.namprd05.prod.outlook.com
 ([fe80::e33:dc6a:8479:61e2%4]) with mapi id 15.20.8445.017; Thu, 20 Feb 2025
 00:23:40 +0000
From: Brian Mak <makb@juniper.net>
To: Kees Cook <kees@kernel.org>
CC: Jan Kara <jack@suse.cz>, Michael Stapelberg <michael@stapelberg.ch>,
        Christian Brauner <brauner@kernel.org>,
        "Eric W. Biederman"
	<ebiederm@xmission.com>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Linus Torvalds
	<torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v3] binfmt_elf: Dump smaller VMAs first in ELF cores
Thread-Topic: [PATCH v3] binfmt_elf: Dump smaller VMAs first in ELF cores
Thread-Index: AQHa6Cyyr+Pv/zK/REOrOTMOkQf+lLNN9PkAgAC4SgCAAVa2gIAAOzWAgABLzgA=
Date: Thu, 20 Feb 2025 00:23:40 +0000
Message-ID: <F3A6D0B6-6F6D-4EA6-851C-12621A24BE93@juniper.net>
References: <036CD6AE-C560-4FC7-9B02-ADD08E380DC9@juniper.net>
 <20250218085407.61126-1-michael@stapelberg.de>
 <39FC2866-DFF3-43C9-9D40-E8FF30A218BD@juniper.net>
 <a3owf3zywbnntq4h4eytraeb6x7f77lpajszzmsy5d7zumg3tk@utzxmomx6iri>
 <202502191134.CC80931AC9@keescook>
In-Reply-To: <202502191134.CC80931AC9@keescook>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR05MB5799:EE_|CO1PR05MB8457:EE_
x-ms-office365-filtering-correlation-id: d81a00ec-ca10-49fe-8cd3-08dd5144d3b2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?9JwZL3/AXpSCFhQJRBa2P0SBCp/XBWK64QKEyR/Y0xy+1UKmhhLC5INJdwFs?=
 =?us-ascii?Q?PpIyypCNfcvNgHe6O72DWNZifwQaxzOqNudcIGnR3sVRrxSbhF4NHXOyvIHr?=
 =?us-ascii?Q?H6gxeY7aKHUvlWFYL7HN+4ePhYx7Gy1KwL3S/e/nJcen39U/6e0208AG4wqk?=
 =?us-ascii?Q?L6/motbH82spPPGk59L4Rnfd4TI+L+y3twrhrfkC8aedgRyb2b7rVLb0a+sc?=
 =?us-ascii?Q?BD8rj2zXeFWeHjATKBGw1lkT31DzQbtpNyAMJvpi75MmmKKoJZ4A7SQXEZ5w?=
 =?us-ascii?Q?ckhLuWQI4RJJM90SmGPlJj9jVdmhUn50gsAopt2fMe3nnZKi0rGySkVNds6i?=
 =?us-ascii?Q?uG4uzLEXxqNg4vRj3pdtkAYq+1FZtjCpdesPDaNdv1ZeMj8sbW88KdAWzH1J?=
 =?us-ascii?Q?tUJbAxWv2wnU//TesFsn/ys2xKBv276u6j6/G0iTF9jRqkyvq2BrLBzKE6YB?=
 =?us-ascii?Q?EWJopCKw4GRpdnFag0mk4RTT1FepGGUzAWNDx70oUN5ARR6zMMF2BSrJ6Mfw?=
 =?us-ascii?Q?RQXSTvtuJLHr9SxlqDbaeZ82pRrP/ERNFkqmjUm7OFpGzXonVcnL/TYT182U?=
 =?us-ascii?Q?S3y5xim3wCe07BRPEzlTCbefeTpGBtGIj/BjoSMNkJDtaAara8BO/wHExRip?=
 =?us-ascii?Q?NdmYwvr7iUYCzyhv0oq0uZM9kbzggUjoyhXItUOwxZy/IlAieU+T3UsQTznZ?=
 =?us-ascii?Q?sEUWnxRBwGUSbzUcVqC/CuYpnGnq1ibE3+KgzSUH/X6aQSN9pBARK0nU4GMn?=
 =?us-ascii?Q?53Z0cMHnrhCztYYs1X17E+oxuR86noT/alC6lI1teHZJaKz8rStG3csxJgBE?=
 =?us-ascii?Q?iENhOvWz04K/D3hQetNiAtH0nv9EP4QSPB8u6iYnP0wJVV90087xemzw9/pu?=
 =?us-ascii?Q?Z3wDNcEaO4/4zxqLf+aOS9O42VvUh5HJU1wWmLtDA3AUcQwjPADFg+SrWuhG?=
 =?us-ascii?Q?LqesHpfq2yVLiLLlj5eZ28yakqxrrhEK6J+EHmx8rakvGRz72Kw2jl/tP9Rv?=
 =?us-ascii?Q?lNq8v2OBOCqgHYHReOi5YUJasQFb9vysYga3ET1AnlRgERtdKb5wMCeXV4ij?=
 =?us-ascii?Q?0ghWBwttSOM7zkyqHexLraF3vbgnttdbXIqxM2ikwkqM8jUCznKlUjdQqpLi?=
 =?us-ascii?Q?kBXqgPp17LiB090zQ4VB15+xi2qwub3Fe5FBE26WaqfK9JwYbMHUddDaQBNm?=
 =?us-ascii?Q?kD9O808weEaYYgyoSu6yWCPavIOIN+xX3rOSuUVX1IA7IF0h1d1MoxIYiud7?=
 =?us-ascii?Q?lTnuVBIbrc11a6TqVqcHLvgOAyKC60BePct5Al4sJGiaZlD7Fkhyq4hOwTna?=
 =?us-ascii?Q?Vjkq2ONHPyBGB9pTDYYOLR0/c+DvtVbECc5qI3r7p+qnC3UH/UlIIL3Vnqw0?=
 =?us-ascii?Q?qCnfELNJEqM/03cTBot5JqnV6m6HsJA1PqUkZLamAMCzKLMV0bfsY69DGfP3?=
 =?us-ascii?Q?bvvw9JANP/MVmB5eSQfsbC8xgCZsdHyf?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR05MB5799.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?GTEv2QlIXN8lRNY9lkR3TufrKjOLoh3ko6cLFr3rZd+C84xbhR84LJnHhP7/?=
 =?us-ascii?Q?fjJHwKTxx7dukfpnu5QvQhT0Td5DbClmG7r2iZoYfZjTpdVZSI56lX+K8zZ/?=
 =?us-ascii?Q?vXPFlgA57G1hcrrE5M+Tkc12Of9U3sF8V1X4BqwVwP5ZSAlNyy9hgfT31ZVJ?=
 =?us-ascii?Q?TcYxZef1roWS8QecMY5mxS87dEOJUsJmdLX13uVrHT0kcJx2BrGrxLmOTuJW?=
 =?us-ascii?Q?I0vEHJfXytXJyMaH48xIg4fbrTtQaXVbFhhq3dHw2tLVKZPxHNprRDXtEnKN?=
 =?us-ascii?Q?rIGO1UdNQ6pFwx74nuifGuF2UDe8k0oWKQGybbZ10z2JX5XUuB3cyGe6MImV?=
 =?us-ascii?Q?fAJZqcGzttmKjp7NM6hyGcXkf35M0SWd0PwmFiHkM5teG5A78wdoNn15lCd6?=
 =?us-ascii?Q?0rXrVagL7U3irA1BhaJ1xGaELp+r0z4oFPEhev8z9aqefkbHFu4p7TB3YTcb?=
 =?us-ascii?Q?dG3ODp15jHSxPWe2CWrZ6WVSDQ5N4Az0RdGDqBNiIWxkyRQY7aftk8j/k082?=
 =?us-ascii?Q?N9zKG6n/UHZk+psTYwuRe9xp5Fvz2v6Q73nQ4+YuCIRTYGFozEi4MUTvsw9E?=
 =?us-ascii?Q?KFmUh78dWLV4lpSEmvPsHYQvy4KiT4BqAnnCXLkXhDgskToyqAmQyK5eRWb2?=
 =?us-ascii?Q?6muFueg5DHeXXfuYi4IM78GS28SJVpzz9/2qwXoGypk6H5Y49a4zNeoVZ97R?=
 =?us-ascii?Q?rxTHwkKo11YCX06hwjmQM5ExHQkUoGkk5kWW67VfY8mmNa2rtsDFkh2X9aDM?=
 =?us-ascii?Q?IFEzBq9v0kOch/Caha4SMNe0eYMA+DgHOs3Um3roQW81qYRYISk3x9Y/BxCp?=
 =?us-ascii?Q?p9bZhlB/w2oG+utsSm7esi8KoF48Im1EniW/RlEQ1tvIU9qceeL4np761Hkp?=
 =?us-ascii?Q?1+L+qtqIgUksrWo2eguZgKANMh6A5bT6gILodSoouBNLxHOkZPWRekjp182J?=
 =?us-ascii?Q?zoM5lDLF1r6opmlZezldjxBAvLFHV8AZXHRvYqrZlMz13g6sYuZq7+H6t7ta?=
 =?us-ascii?Q?dL5C7gJa767mx/qPLdLtMtBbCheI2prEVgde9SvlQf/BxmeB8UvnwgRKOJcp?=
 =?us-ascii?Q?nWdsz62pxqtZbwm8TBg276rUvfba9RYm51YdOlmv9ebqxXgYfIa0mmQXNDI/?=
 =?us-ascii?Q?SG515Mq6hUX8ZHWuQVjGKYcgVCJmyU6ZfaO6qWuaeX3MOAeN6cvEJgVW9qrX?=
 =?us-ascii?Q?jUXHVSB1qmdTSL+0Z8GjdYJzUjzX2jxx5rNExw2xAfaLfPFOw3MRzjYIMHbK?=
 =?us-ascii?Q?RZbXLvA0NNaAVOL+xJxLBTGzt9IHraQz6uAZ+FlvtI772jb9S2WG+24UBT9Y?=
 =?us-ascii?Q?dWbbNBAo7zgfPRXjErbEU6jqhfs4elTBkzbSLH6X94G8r896w5/1A1b5xANU?=
 =?us-ascii?Q?Nzg/OXUovORpQTonaDxkC40qYmJl+MDBtST91UUmOJPiGnBYFy4vczWJ25FC?=
 =?us-ascii?Q?UzM9NkADO+AKzzRypfkUExWX0JyTALrxlyRnQby5Xg/i6oZKa3WZUumjDolN?=
 =?us-ascii?Q?PPZcz7wUyLLXjj8qqWaUj+u9nhY/ZRM7v2tQe3x2p0HFp5L9/+TGnuFUF0Hx?=
 =?us-ascii?Q?gyx/Zifc4BqrRgGUg2u6+WhsN14eM5yoX4TFqP1E?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BE7CF233C0B75D4EB2F1FBE25BDFEC36@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: juniper.net
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR05MB5799.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d81a00ec-ca10-49fe-8cd3-08dd5144d3b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2025 00:23:40.7440
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bea78b3c-4cdb-4130-854a-1d193232e5f4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QCpS+J4F+gwlNgmseg3lBjTMk/GrOxUa9JEZg8qpL4aSX3rGDgoCprUtAFAofkTlLkos2nwUWMccKMUiBpbTFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR05MB8457
X-Authority-Analysis: v=2.4 cv=LNicQIW9 c=1 sm=1 tr=0 ts=67b6760e cx=c_pps a=Kq952KYlFoMAqHE57MuLQQ==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=T2h4t0Lz3GQA:10 a=rhJc5-LppCAA:10
 a=VwQbUJbxAAAA:8 a=PbRDF27-LJ64wO0NA0oA:9 a=CjuIK1q_8ugA:10 a=iFS0Xi_KNk6JYoBecTCZ:22
X-Proofpoint-ORIG-GUID: 1bGV5Q7MRpU_UltuGL8b0S7QFiL1Bj2x
X-Proofpoint-GUID: 1bGV5Q7MRpU_UltuGL8b0S7QFiL1Bj2x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_10,2025-02-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_spam_notspam policy=outbound_spam score=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015 phishscore=0
 spamscore=0 impostorscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2502200000

On Feb 19, 2025, at 11:52 AM, Kees Cook <kees@kernel.org> wrote

> Is anyone able to test this patch? And Brian will setting a sysctl be
> okay for your use-case?

Hi Kees,

I've verified that the sysctl tunable works as expected. readelf is
showing that the VMAs are unsorted by default, with the tunable set to
0. When the tunable is set to 1, the VMAs are sorted.

I also verified that the backtrace for unsorted and sorted cores are
viewable in GDB. The backtrace reported by eu-stack shows up fine in
the unsorted case, when attempting to reproduce with Michael's steps.
As expected, I see the same error as Michael in the sorted case, when
reproducing with his steps.

Interestingly enough, in the sorted case, I found that if the crashing
program is not linked statically, eu-stack will work fine. However, if
the crashing program is linked statically, eu-stack will throw an error,
as reported.

Anyway, this patch looks pretty good.

>=20
> diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/=
admin-guide/sysctl/kernel.rst
> index a43b78b4b646..35d5d86cff69 100644
> --- a/Documentation/admin-guide/sysctl/kernel.rst
> +++ b/Documentation/admin-guide/sysctl/kernel.rst
> @@ -222,6 +222,17 @@ and ``core_uses_pid`` is set, then .PID will be appe=
nded to
> the filename.
>=20
>=20
> +core_sort_vma
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The default coredump writes VMAs in address order. By setting
> +``core_sort_vma`` to 1, VMAs will be written from smallest size
> +to largest size. This is known to break at least elfutils, but
> +can be handy when dealing with very large (and truncated)
> +coredumps where the more useful debugging details are included
> +in the smaller VMAs.
> +
> +

Just one comment here, this should go up one entry to maintain
alphabetical ordering.

Thanks,
Brian=

