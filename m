Return-Path: <linux-fsdevel+bounces-25579-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B820F94D994
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Aug 2024 02:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 048D1B21855
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Aug 2024 00:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662391BC2F;
	Sat, 10 Aug 2024 00:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=juniper.net header.i=@juniper.net header.b="D9iXPHCV";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=juniper.net header.i=@juniper.net header.b="LLCV+IgF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00273201.pphosted.com (mx0a-00273201.pphosted.com [208.84.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD81BE6C;
	Sat, 10 Aug 2024 00:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.84.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723251165; cv=fail; b=ivCLSrUGH/PRCF7IHSKDAd69fa0JmanfClxmJpVCm4ZbOe8YK7V5UWEXwwwGLHuSUem57qDs+NbEVB5fsRApJqvqV0r9fmmdiB62qyR9coHDXMRdpjnlvMJzXUKfK/qoD761FOieBaN24Hoo9xcZcc0WlMfFTijj+e+2xpiSK0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723251165; c=relaxed/simple;
	bh=8x/AROaZvseo/FX5zPJgd1QJrzu0xwNjXVWaXa+sNOA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SOdZGZjI8zGft4YFW6hyd1n6pgYux5a/mJIVOFcJ2dnIPoxeItsBdYAzmY5/PqSKoSDv/dNa5yxBUuwaTSQoF+jqc5pRirV8bEjW+i4isIMq6IpHDFeRqJayMZZcce+tFD+YNoMlbFs3fS9zbWz1+/cokritn3bnKg10osyFY2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=juniper.net; spf=pass smtp.mailfrom=juniper.net; dkim=pass (2048-bit key) header.d=juniper.net header.i=@juniper.net header.b=D9iXPHCV; dkim=fail (0-bit key) header.d=juniper.net header.i=@juniper.net header.b=LLCV+IgF reason="key not found in DNS"; arc=fail smtp.client-ip=208.84.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=juniper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=juniper.net
Received: from pps.filterd (m0108156.ppops.net [127.0.0.1])
	by mx0a-00273201.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 479N762k004701;
	Fri, 9 Aug 2024 17:52:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juniper.net; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS1017; bh=F/JRm5n7m0K8Mid50bRM25Q+8++KOUhhMaGE5jXHlsE=; b=D9iX
	PHCVaogJYNZSQWB86joLEFNkRjm+QxKzJG388erUxCUepqFzHpsPcjW8Blu5fr/X
	i0qx1Ol/dTRmArNXXLPpi34TgiFno4DH7co522Rb1QH/z/L5Hf0bHfilAnOUkYcc
	WJvb6wDtAhs+UoZutcDAkSC4eJDdy12gYWb0vV456blQ7DDOp86tqmWrBrwGhWP9
	UZ7u7N+l5n0E3jctZLAXDUyn1n9gOeA573Ewsz22+tQEkbJh0y/Qexky6q4qwImM
	qWGtSvRSaPJvpMMnlbhyDrODs70nJUInGd/MFnsuL1XWxqa7r1cyroSMGYF0dHWK
	urTX5xf73EkLrV+P6g==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazlp17010003.outbound.protection.outlook.com [40.93.20.3])
	by mx0a-00273201.pphosted.com (PPS) with ESMTPS id 40skjepa6w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Aug 2024 17:52:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hsm1xWSfUiYPiMIYVUEjxpdyCr4hRRfNGJTClfRorTQj889axhUdY5akQ9/pIdiKQXoJmkbR5hOdQPITw5+vcYCmwNNM6+tiqHM0UPiJF7VcCZbw/ntrktAh4l2UNY0p7kF/P6PjpeAT2Ba79zY2kzwurmqs2rLSTB8zmaMWAiwKf0iEjBDk+3LM/dWSUxssIKcjm/kzQxUHa9Te92jwtmXEFbFTy8TEhzAWTziYzy+9EWfxvOdJ3QgtErpt92atjBctbJkecttVcUsCnQGzWoAMONjGipO+UsDYSEtnuSzMEjSer/vB406BUMeKX1HDQiiYsLTVqC10S1LgBhkDIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F/JRm5n7m0K8Mid50bRM25Q+8++KOUhhMaGE5jXHlsE=;
 b=dTZate3C3AswSXbPyOzCeEisnvJ7vc1X6WjmXNxAcbx+QlkvRHYaOcEst58eix+Oq+CXwhxOWdPnDYRrxfUCClKxyX1zaTpypGKsJ01pxmUwGoSq4Lca4eUlAXCDcgRatK8VisAlZIIabiGK8ruvAeKNrZT46NUeHtpkOgHP8OdbzzpGZAxSsuJIjpbhVgtGIrHNmCqdhV1v6+il1A3hzVbfNq/krm49XhwNq3y+FaApiZaphMPmUVzZHk1ffZnlb8MSdpkv+AiNFIrZHfDcequg8rIRWn23Q/FB0GUlt0ehPHcRBSqjLs476BLXZzAlgenHbJOpyYyBCJ6qDy+BWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=juniper.net; dmarc=pass action=none header.from=juniper.net;
 dkim=pass header.d=juniper.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juniper.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F/JRm5n7m0K8Mid50bRM25Q+8++KOUhhMaGE5jXHlsE=;
 b=LLCV+IgF/dlwdnJeb3LxVl5cvFotdOl4X8JxUlK7eEevjg8YbIO6Mkvt+CU+VuN+dyVX+nlxYJBuneEr75IzKDR8f34In8oI0RMR7gTb1gsykGDeehr/7eg9iJVfWqmam+Pi5BOUflOqhEc7+VvYejwHhU8PF17BFNuodRhSaEY=
Received: from BYAPR05MB6743.namprd05.prod.outlook.com (2603:10b6:a03:78::26)
 by CO1PR05MB8330.namprd05.prod.outlook.com (2603:10b6:303:e1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.17; Sat, 10 Aug
 2024 00:52:17 +0000
Received: from BYAPR05MB6743.namprd05.prod.outlook.com
 ([fe80::12f7:2690:537b:bacf]) by BYAPR05MB6743.namprd05.prod.outlook.com
 ([fe80::12f7:2690:537b:bacf%6]) with mapi id 15.20.7828.023; Sat, 10 Aug 2024
 00:52:16 +0000
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
Thread-Index: AQHa6Cyyr+Pv/zK/REOrOTMOkQf+lLIbQu4AgARrwwA=
Date: Sat, 10 Aug 2024 00:52:16 +0000
Message-ID: <D1EFC173-A7A8-4B0E-8AF6-34AB1A65D2DB@juniper.net>
References: <036CD6AE-C560-4FC7-9B02-ADD08E380DC9@juniper.net>
 <172300808013.2419749.16446009147309523545.b4-ty@kernel.org>
In-Reply-To: <172300808013.2419749.16446009147309523545.b4-ty@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR05MB6743:EE_|CO1PR05MB8330:EE_
x-ms-office365-filtering-correlation-id: 192a1df5-851c-43f9-a80a-08dcb8d6ae72
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?D6vX9MsdvdGqHsmBkL3V1bsrg0xF422Ezs/dqW0k6kQDiE8p6kZVVIZh0JKF?=
 =?us-ascii?Q?vY4uRZ7S0H6Cogt5QzEfidkAilZwu7x2unzisVdkkDXQ+v086hYiB+eUlngZ?=
 =?us-ascii?Q?0PyziLM7KxaGA+e0v6BQ8MK+rYVaJO8vm/BV6EUXBeKu396i6r4b9n+SuXvs?=
 =?us-ascii?Q?acUfvxZVQnAfFDrsqWR40vwGP5iZjMqwWtQNF5DSxRo9c1VMi6gEjmLuYX/w?=
 =?us-ascii?Q?4z7MGEtTGg3pB8KX/QCFaikVSnSv9iajCibiQ00UfBSwB7HYMQKr3Z5tO92Y?=
 =?us-ascii?Q?1d9WDqGyGbUX5kzdg6Waav44A5GvozrFmRiAXpyiTgUu+N1qd+CmSy40Apw3?=
 =?us-ascii?Q?1trCBv6w1DOsiJJ/5umxp/1rJCr9eb6kPQgWUJqimJrVN45aTMxTaXQyp5+M?=
 =?us-ascii?Q?od5FwR683MEGad4l6HJJr5D02OwaQngYh4QmicuxqOaJABmZ+Unh12PJHfSJ?=
 =?us-ascii?Q?9jsBgKSJtq/F9Y6Uxv8hZTy/xnpgLZmywXwavIAQYDoF7bZnhYT4u5KqSIr5?=
 =?us-ascii?Q?fcOnu6gO/MXQo/DZaJJmq2voEgA1OBzbuGjgC7tpKiiTixFuxt5Wk7GApQ1A?=
 =?us-ascii?Q?GynwjaV7HKtZNiumMbnMdqq6J0Pvzfpx8b3wIiLHGXkgOmQ+tGn/XkA0CjRe?=
 =?us-ascii?Q?ssKOUoj1ynTRpyfbKlX5PyqQ4ZSJakko3t3KXcwIJkiHGZRfxBKYpsAi61n6?=
 =?us-ascii?Q?zz9ZGYVT7IQTXKN9LgXl4axKJ2cTaUrO04EhrD12dRdCXJzbILf18rtLY0ME?=
 =?us-ascii?Q?IelTcYEk9JxHL24o/DkD/TOXgg2c/RNJ+cj6q8e59mkM9La2zARXv8jqj30W?=
 =?us-ascii?Q?csrOZY4zWJc47UWCdQoLdq7GSH8CfIhHDIDrlB/nU8dtH3YNfqo5R4eVknAz?=
 =?us-ascii?Q?oyPWgWAfxSlMP8jrmvIsKoduJeysfOIa+Cu51XgPh8mf/dm+rNEhc96mrUzu?=
 =?us-ascii?Q?jf2xt/E0Std9CYtKjQMCdvBKieg0rr0NlmLN5pSp3MYXMfkVRDh2zN5I3XQa?=
 =?us-ascii?Q?U9dAhGAsgk++blpvSz1td5rDAioroZO8zIUXxfolEWS5fnwU1Eo5+GXgH3pa?=
 =?us-ascii?Q?U30tAB+HxVcUo4TNyXG2fv6SF1l/IyZ0ZeyiAieZ7AwxO88ZT3cne0pDYGOR?=
 =?us-ascii?Q?CXE6zvFYYJPyCdgX09Lu6r6IHIFGmbsUaVz8Mgd2BImenl6LXnmKo0D5P0pE?=
 =?us-ascii?Q?MxPWfwkMTgSdPEycxyXNMrfpQTQF9ONgSFC3nTUpKNkrCF5rYSfIbIpnxASp?=
 =?us-ascii?Q?29Qbtun0OWCgUJ0I/lYmsI53BEGWyuAXxhuh0kJbIQFyoowVjdQoqPL8+iuO?=
 =?us-ascii?Q?LcamzLsiE1QRD14zzImhQk10?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR05MB6743.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?rQ8tveGySOWZVXFLBGTnhk3NYoLNF/RkmvZTP4DOGo6q+55+hR8ncG+3YtEB?=
 =?us-ascii?Q?wVIL9/vLgxM4Njx7wt23c8G7NrNr9vI3QIWKh/dmlZ+tsJ7tXjMAs9DhFJcG?=
 =?us-ascii?Q?guWhunW9U3UtQilWKy9esIX3xw1kEocH22dAriuF29pG/a0aNsfCZGYX1Dip?=
 =?us-ascii?Q?uHgF9+m4GM3xAw5jH5bLtdLalgoHmvC6wQv7vX9VPLcYagfADc0+EOVDXXH1?=
 =?us-ascii?Q?C3iibtORoNUhhXUeAuRBQ99l+ECbWVyGwE/gizj3+4Zn9KaU3wNQlS+2TvU+?=
 =?us-ascii?Q?ta84jRNpKNUSyPMz9DjP/idpQO3MLTmR9c0pOqaXExkasPilUyVr2uUPmr25?=
 =?us-ascii?Q?if4WROOPIcga1ujuNS8EkIwlmMnHhCZ9p2nqw9hx08m9z1gXOvJQTyccsii0?=
 =?us-ascii?Q?xmkVPJd7cOJWOPcENT0L/9legN6bxYyESienwQwaUjnPQmHIw6addLbu5IG4?=
 =?us-ascii?Q?nQjAp52TuDmIUf9KW25Oc09e1F+u4UedlFv+jIVm6NFH5UtX8fCaWQ/4sdo7?=
 =?us-ascii?Q?bYNvlzlHdzFi02MUpL00vJqbvm4Mx13gNIARp5d35lZmHG711x2MNR9QBWQG?=
 =?us-ascii?Q?TY9heWIE6AV9a0YmpZee0NwUaQtACO52EnxuYJi+SkynDZLWUnDinTLB4aHY?=
 =?us-ascii?Q?nS5dEkAH5GuMIWkrXI2EiMvolO7EADBuqouhXBcCJdmT2aZHnwHRnaEDNLr+?=
 =?us-ascii?Q?Uu317VOXkSeA/Kcs6URgZxSaaKHuhqTM/MBTBW5afDfC7vmo31n8ICi7K4l8?=
 =?us-ascii?Q?/If4hsA9RvpHlSzRANCFfzcCbZBol002aGo6V7OCzNHbkJTCNotoO6bqr2eO?=
 =?us-ascii?Q?A3B9RBk/3N7/XP5C9KYVW2qiS+oV4tNL8MxglV4e0QALSTyU1LFgVC6pHBBJ?=
 =?us-ascii?Q?h8JvqrRzfAjYrYYQZiAF00qXyJ2lf7qPRn4fnrrmH28dEba0ODjvVDaFpFh0?=
 =?us-ascii?Q?0sbqVV81SLu/XfzgtuiLqmrHQlTspENc0WNrB1S9BYKOCL1oiOmLF/XQtHOD?=
 =?us-ascii?Q?0N/QN7JOZiGXk1/+mc6ABimEpdPdMq7pHZ+C5nYHxfak3K7H6vwwTAA8qF99?=
 =?us-ascii?Q?s8lTi7bx67NLVlknK1/nVR2A+d6QMFFgWCTKRwkj0VYsQ54rrE6PFJ/wYr0D?=
 =?us-ascii?Q?K9wiRd/x+SLTOIyX0yl9WVUzJzfp5ek6t3qjspgB8LGAA0VW+ldrR6NvQb/g?=
 =?us-ascii?Q?BIt4kmTpJhY42vCsAvVFn4GEr8i00WjHWkNLgxde5wYl9YkCymX557GMkpja?=
 =?us-ascii?Q?zSBzeWLS+bNDjX2ay9OoWYyy4l/GIDM6k7s9iPxz3PcH3KGHbQEjuwvKgVqR?=
 =?us-ascii?Q?cZNi02QEraTSN+7ZftI4GoP5KdXiXFnpJRiBtfuT6gjOLig3m7i0ch61Pg12?=
 =?us-ascii?Q?AI+k/GzVFcl22GPC96zUhXwNm2qZiGBCrzeFQS6c5KooDhYjj12LM4WksFPZ?=
 =?us-ascii?Q?1LoUgrsnEk3MzK/+HAOYb6z6UHSXkYT+rNxWRUfE+TApPMPyf/pGh4ZrLrGE?=
 =?us-ascii?Q?rmqlSnay6MKwwY8e+BzndLwXZuBNqRwAZPPjsM6Jp8ut+qMe8G6AtCH4hoEh?=
 =?us-ascii?Q?5AysaIC3u8htQdex4oyUlB1OZTe74CcMmtN6jv+s?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AC87F863B8EFEC46B2AEE18134DB844E@namprd05.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 192a1df5-851c-43f9-a80a-08dcb8d6ae72
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2024 00:52:16.8548
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bea78b3c-4cdb-4130-854a-1d193232e5f4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s9yKOe9RMrUYNozf8Xhyd9Tyg3xBnDwTKiRXUVF9VuHmQNYvDPlLQ6vtGXmVsMTI4BJyFB7x9SoVryoBjakiHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR05MB8330
X-Proofpoint-ORIG-GUID: XHPaoQQA_g_E47rECj78vYqCHodpWO9s
X-Proofpoint-GUID: XHPaoQQA_g_E47rECj78vYqCHodpWO9s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-09_20,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_spam_notspam policy=outbound_spam score=0 malwarescore=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 mlxscore=0 phishscore=0 impostorscore=0 mlxlogscore=960
 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408100004

On Aug 6, 2024, at 10:21 PM, Kees Cook <kees@kernel.org> wrote:
>=20
> On Tue, 06 Aug 2024 18:16:02 +0000, Brian Mak wrote:
>> Large cores may be truncated in some scenarios, such as with daemons
>> with stop timeouts that are not large enough or lack of disk space. This
>> impacts debuggability with large core dumps since critical information
>> necessary to form a usable backtrace, such as stacks and shared library
>> information, are omitted.
>>=20
>> We attempted to figure out which VMAs are needed to create a useful
>> backtrace, and it turned out to be a non-trivial problem. Instead, we
>> try simply sorting the VMAs by size, which has the intended effect.
>>=20
>> [...]
>=20
> While waiting on rr test validation, and since we're at the start of the
> dev cycle, I figure let's get this into -next ASAP to see if anything
> else pops out. We can drop/revise if there are problems. (And as always,
> I will add any Acks/Reviews/etc that show up on the thread.)
>=20
> Applied to for-next/execve, thanks!
>=20
> [1/1] binfmt_elf: Dump smaller VMAs first in ELF cores
>      https://urldefense.com/v3/__https://git.kernel.org/kees/c/9c531dfdc1=
bc__;!!NEt6yMaO-gk!FK3UfXVndoYpve8Y7q7vacIoHOrTj2nJgSJbugqUB5LfciKy0_Xvit9a=
Xz_XCWlXHpdRQO2ArP0$

Thanks, Kees! And, thanks Linus + Eric for taking the time to comment on
this.

Regarding the rr tests, it was not an easy task to get the environment
set up to do this, but I did it and was able to run the tests. The rr
tests require a lot of kernel config options and there's no list
documenting what's needed anywhere...

All the tests pass except for the sioc and sioc-no-syscallbuf tests.
However, these test failures are due to an incompatibility with the
network adapter I'm using. It seems that it only likes older network
adapters. I've switched my virtualized network adapter twice now, and
each time, the test gets a bit further than the previous time. Will
continue trying different network adapters until something hopefully
works. In any case, since this error isn't directly related to my
changes and the rest of the tests pass, then I think we can be pretty
confident that this change is not breaking rr.

Best,
Brian Mak

> Take care,
>=20
> --
> Kees Cook
>=20


