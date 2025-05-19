Return-Path: <linux-fsdevel+bounces-49404-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3419FABBE25
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 14:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F26733BAE5D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 12:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB4C27935A;
	Mon, 19 May 2025 12:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ansys.com header.i=@ansys.com header.b="IlxTIXSz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2102.outbound.protection.outlook.com [40.107.237.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7638F27933F;
	Mon, 19 May 2025 12:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747658576; cv=fail; b=WDUcsQDluaGPZ2LX+dUw7Ja4QdkzNdb1ZHATA0AxwTUdAnidtH+7dM9govS35q7mD6Q35lYr04chqqCUXX6rf4U5nGv1A7OiVuv9leyaQzW5azzdHK08Mgr/KK+Fh3LfRwPYpWcDUdz/ttEU/oNSgK03OBMakWkhKWdiyRjw6PE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747658576; c=relaxed/simple;
	bh=5p4hSceL5Y0nuzmxVTmtcZJoYBzq4d5aJNTSL+fQw6M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XzcDhJ9Mt9r4YjeT/aDyUauNkQ8HOBqFveNv8fXA/O9tuAnqR1NH2HPAcaRTOQHAD5IZ7KY/xNS03/IloT8a7/lXPuOy3bBO1W4nEv4dsPqgc4Xs95Bb1xQVW3/c0MCxtdlX5OBnDDZdGROtV/GQED6xytSdFi1DYnYm1txzTKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ansys.com; spf=pass smtp.mailfrom=ansys.com; dkim=pass (1024-bit key) header.d=ansys.com header.i=@ansys.com header.b=IlxTIXSz; arc=fail smtp.client-ip=40.107.237.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ansys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ansys.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CZIZqnnNTqljnTPfhWW/gdbb9flLDZev5ynA0KUMRsVAJy2Xb/cEbDPhYpcKpcRFYUFxJaai3YqoTjlYqNZaOapM7r7qb8y3a+9bj3/578VXtIRt0oMmW8fmyyfxCGbIG6cYfEu0O5jb2FKGm5FdHa642d91F6wEqrkh13i/6es24IDBgC+XlTyVqTKnHRJFyLoEB/Oq4zSZJPkh/9vlkNbIrDsCujdy3dfB1IpUJvX+yo19xFS2Lz/r+Wt6XSvsJPvlorVVxgTJLChrOfJinEiJHtwQJdZ1cthGr8JfYe6+JYzb8smvM+RAgJ2zMYadTCwqHUuwAV8FNZIBMEHpdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5p4hSceL5Y0nuzmxVTmtcZJoYBzq4d5aJNTSL+fQw6M=;
 b=FM1Pt2K+yAcmsNvz4PeJBfBTVsD7qVBfxy/XiNPNRIX5pvy7nN5+u0jRwZT2gXvzc+9LRZFRhEDZp9+nXAsZIexseIBirrq8AzroFm1zUygvyq7vuZtXej1wfG1ojtMNLdC687D57UOOTgvSGY/RGRTJZgaU7q2yGeSOstxBDFK5VTTveCmqHc6n2zKrMPq4JAhjsLGDxH0bO4pYPpqvgHtXG+UMuvJE7KRx4vzVGL45P6n2mxE98R00UAYmAp23zKAAWtMW2+nlUY8osUw6UQ0lvscMckRhxenAiltQvgCrBrSmjM9jl9UmHqfkpPqqrA8uuN3LswRIwm0tr9gH8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ansys.com; dmarc=pass action=none header.from=ansys.com;
 dkim=pass header.d=ansys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ansys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5p4hSceL5Y0nuzmxVTmtcZJoYBzq4d5aJNTSL+fQw6M=;
 b=IlxTIXSzh9cmUgQUII84mMQUftGRZsaoeqnBL4uXMiKuIfRpYWt1dC4hRl9en9VWZC37qu/93E5MI32jWDgMr4ZfhLTI5bz3OgQc8jGabm6ubjvvMUdzQM2O9ZOZEvavsb07Wxriqt84Zk+F8PwHQnFaxC/Of+IYyPs4BeZR5XU=
Received: from SJ2PR01MB8345.prod.exchangelabs.com (2603:10b6:a03:537::11) by
 SA1PR01MB6800.prod.exchangelabs.com (2603:10b6:806:185::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8746.30; Mon, 19 May 2025 12:42:48 +0000
Received: from SJ2PR01MB8345.prod.exchangelabs.com
 ([fe80::6b00:1585:571d:c7a9]) by SJ2PR01MB8345.prod.exchangelabs.com
 ([fe80::6b00:1585:571d:c7a9%3]) with mapi id 15.20.8746.030; Mon, 19 May 2025
 12:42:48 +0000
From: Bharat Agrawal <bharat.agrawal@ansys.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "hughd@google.com" <hughd@google.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "rientjes@google.com" <rientjes@google.com>,
	"mhocko@suse.com" <mhocko@suse.com>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-api@vger.kernel.org"
	<linux-api@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"legion@kernel.org" <legion@kernel.org>
Subject: Re: mlock ulimits for SHM_HUGETLB
Thread-Topic: mlock ulimits for SHM_HUGETLB
Thread-Index:
 AQHbyKcHO9z3CBT88UaaZrmPml1IQ7PZvpe2gAATngCAAAb6nIAACZcAgAACd5qAAABO6Q==
Date: Mon, 19 May 2025 12:42:48 +0000
Message-ID:
 <SJ2PR01MB83451DF444635655D68210C38E9CA@SJ2PR01MB8345.prod.exchangelabs.com>
References:
 <SJ2PR01MB8345DF192742AC4DB3D2CBB78E9CA@SJ2PR01MB8345.prod.exchangelabs.com>
 <SJ2PR01MB834515EA00BD7C362A77972F8E9CA@SJ2PR01MB8345.prod.exchangelabs.com>
 <2025051914-bounding-outscore-4d50@gregkh>
 <SJ2PR01MB834507D46F44F65980FE09668E9CA@SJ2PR01MB8345.prod.exchangelabs.com>
 <2025051946-ransack-number-e5e7@gregkh>
 <SJ2PR01MB83451550F3A9C1636C9E50618E9CA@SJ2PR01MB8345.prod.exchangelabs.com>
In-Reply-To:
 <SJ2PR01MB83451550F3A9C1636C9E50618E9CA@SJ2PR01MB8345.prod.exchangelabs.com>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ansys.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR01MB8345:EE_|SA1PR01MB6800:EE_
x-ms-office365-filtering-correlation-id: 92c53e19-fb72-4c83-1e97-08dd96d2a93d
x-ansys-tr-msexprocessed: True
x-ansys-tr-senderinternal: True
x-ansys-tr-recipientexternal: True
x-ansys-tr-notconnectorflow: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?0esTYJ9doex3BTP8IecjKsYcpfxLDZONPfecNrp8yuo5k7pq9DkYb2Ofup?=
 =?iso-8859-1?Q?X0hvofOFLSmQ5HxIdHRdkzwyBHT6ftaFsQDNkCgH/G8FcaTVuadQg0H0/x?=
 =?iso-8859-1?Q?XOPdCCTZu7bw2FQcwq7J+4wZn/cCk7wEYIU5MwlMtpOwUs95oYBQVm0qOc?=
 =?iso-8859-1?Q?BjzZcr0m7GhM1KMiLMqRPljRdwE6/9+ULd4jNYvuF0e7TWPWcxWSocKQ8Y?=
 =?iso-8859-1?Q?FnXaTkAAmvDfrE6c41ZwlQc+094KjEqWzadh7usRh8EYI+ADmosz31Q8Qd?=
 =?iso-8859-1?Q?LXzpT7jw/lR3+G9IFNYP6tgvApn96IVb3gzqkzOfHkp4h08kf3nnJwtONV?=
 =?iso-8859-1?Q?JjFLNVvHMaFJ6GD5V+qOfYXZbZAHT7HBwBzPXstEIg4+c/fHosAUUdN7+O?=
 =?iso-8859-1?Q?m2mHtcy//qNM84juISbu1JDRZcdZYCTtMYtAqTp7ZuJtPzCSiZ16oSEkGr?=
 =?iso-8859-1?Q?de0Xc6IMkH9tYIUpyU5I3hhd1r2mMOha3iLlqxsIW0rag9bDCLZZPJCsgG?=
 =?iso-8859-1?Q?r79Oj+LXAAbGzOXE/ZPXOsUvvES3YYbXSrzJrmOE5XEhyKMhJm/pNtsH+f?=
 =?iso-8859-1?Q?kNbdv1GAQmTtQuoWKvP0y0NydH259d3U11ger9JME55K/rxkFZUlOMivRR?=
 =?iso-8859-1?Q?uXmfxROgCeNMAlIhjeVbcH3FhsqoRVJMsFEW0oB/msorWgXpTQh49ppJ/4?=
 =?iso-8859-1?Q?gn7yhMksxk3ry5jZv7YY6QU/XTD72FwVhn9n6q7vlQntgFD09m2XicWkAk?=
 =?iso-8859-1?Q?uqCOey9Lv2GLZ1p7wuNtJR/loIq4w3X8v7Fr3D/9f6kSQfyEbsbdj9V2Ru?=
 =?iso-8859-1?Q?I2KzGpgI/Re0KPwlYTqImBMAJ1jCV2RU2IAru/h+yEtsW+78SE5ojU/VFZ?=
 =?iso-8859-1?Q?dMeVNI8TJNbZ2F15cQGS5E+t0OKg6XZyj0GqTHej2UmQdnyW+3fdOTT1Vv?=
 =?iso-8859-1?Q?tkleB80+DgN91Y2QCnOu+XoT+sRSIAxbLnViiKpcsFmRCBr7MK39RVkdvY?=
 =?iso-8859-1?Q?dsrE//MhQVLp0UIGPRFtlLioUG9NgEY/5rSsSGa1mQXBiAF0JLWgQT84i5?=
 =?iso-8859-1?Q?Ksbcdqj+a+gtZ2S6mvZjeQ+GHm1OxGP1dhwMfY/f2BP+dk5O7r3hyKvkbG?=
 =?iso-8859-1?Q?dIBhyPwtb15iTV0KO6IcsX4seuC1nneHwoFz1E0znvdsxA2A9XshW1D/HE?=
 =?iso-8859-1?Q?Nj/P6DHpfqhYcdYBSUwcA6ukAGqTAhuk5W6knXxZFRREYS7bDYLt98Nq4D?=
 =?iso-8859-1?Q?p19zN8YFzsK7gukFZGP7VZiIYwWygKT8VgO28tcSBH+LhiVJMmDsjuuBjP?=
 =?iso-8859-1?Q?4j9I1PLEpKlzvJLCoHJSOZPUmUDSSVyaG6jdPJzF4Hk6/qbSWtAu2Ko1dS?=
 =?iso-8859-1?Q?KpXhPhLWCVIuGdhoR/A3rD+8cCC8iEiXU6ZwlUgPsT3BABC9AwMvrtN7Qh?=
 =?iso-8859-1?Q?NahZ8Kzo1ilKpFv89sYifuW/4moSy9/GulzTd66EDg4Adcf+aKhOm6ZVNh?=
 =?iso-8859-1?Q?96da/yNOcDk9uwaizaVkmc+v8vWbOBOS9nPC5gTEE1sw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR01MB8345.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?cuw+M11Y7/+uf1cpUW8cFYdlegFr8oiy3rgd4NRYnCSz22kN/g0aisg4ee?=
 =?iso-8859-1?Q?kqrFu/mQ+4Yi4N5iaAq9RhihTqn9FWBH9teJwCqSJo7pyLTyfidsMQShIQ?=
 =?iso-8859-1?Q?8akdnmc4fITX012lPV9SmsQ2X+9izCtMkTIzs+jIAqNl/Oc6mljQU9EZSj?=
 =?iso-8859-1?Q?FO/zV2fSycDTVONDxeSllH003fK4cZZrUcW2mwVdUvOs6qYUnAq62Rp4jP?=
 =?iso-8859-1?Q?DpGt6fsT97fwIC7PkpqkzhbFnntUYt3wYU91weK7dJ5PcbFzaT0FMEVmO7?=
 =?iso-8859-1?Q?ecYfXLqRPRdzFqyjW2wBcr3mWI7n+r0uXNFcZDzdNQErvo5Hzd8DMo3cg/?=
 =?iso-8859-1?Q?+r5LpijSW2yKn3vERDP7roU4Cv3NGi2I3UqmmHvWTIP1mbex8vYxVPyNtJ?=
 =?iso-8859-1?Q?J3unnIHW3houGCLfIXlqwfl5VVjsCOLh4ss0jXnQ2yimAzE8Lc06UxKChP?=
 =?iso-8859-1?Q?K3TgABowpYRHc105yNk9Mc2TqlgDAYpUN6hoZLM6oP3WUbNtVr0bNS7YBY?=
 =?iso-8859-1?Q?9RWRov529mHd9Doa5dQ4wShxs4BvOco6MNpMpXxISA46KAt0GsvyqMeOjo?=
 =?iso-8859-1?Q?9d7/YRisXD+G8GY/IgVrypYeNM2lRrnZcY49Is+UYfxE7WKaram/Woug9m?=
 =?iso-8859-1?Q?8I6j9r3n/1XnJ1PrmPTdw8UDst3c5L7NeV8sGAVJj6AeY44Twemu1yHy2g?=
 =?iso-8859-1?Q?JiTlD0SF9hNhsqdiRWW9wnVejVx9+btQ9ubV1XLus/rPIF0IVtMIFuTfle?=
 =?iso-8859-1?Q?SElZvv5bcqAGaBh6B6S6uPHhiISg7QQnbmEBRZb6jrf5wiXDRaPuZzRqE9?=
 =?iso-8859-1?Q?TBHdk+72Gd0/XK6Jf0RZJnhRRysJCaFu/N2pFpmTyj4YXZM4ELf+X/xPPk?=
 =?iso-8859-1?Q?iHt8+B6Xca/noaXjkQOBAaTwciYou9Uyv1XvUnpS+2V72LmOoPXiUypllf?=
 =?iso-8859-1?Q?5ewivHwiUnDDfL1zoKJDUsKqed/El47C4DETx2AC7XA2fQGz3pXy93gzVm?=
 =?iso-8859-1?Q?R3CFAyFaSORMpCoU7+nuCSNLcFcOmb4BrmQfrwRTOQchjru1rD+n26JlX+?=
 =?iso-8859-1?Q?Sib3YWdiRmVuDdPauPg+xxctjlfprXC0o0wsIAB3zt31iColBq0FMDr8AC?=
 =?iso-8859-1?Q?X1wlVurkLKZSQKVWiX5RFi5+p/0xr97CA4qF2lv2QM1+JMJB1axT9TeC21?=
 =?iso-8859-1?Q?oWh+EzUralSBdtt15uNLX4yylT2gqaMljGZ3vwxA3selqYOc/u5MQ4DX0/?=
 =?iso-8859-1?Q?6zvFdxNeJ8ShLOMoKo9/Rs/CRTxyRCPUaitDKzoKjx82+VyQM1GqUms+wG?=
 =?iso-8859-1?Q?q8II5dS+OvkZZcSafCFkATVC/SmW0mA1kPl4H4A4a7UEbQ1x9CD5qpqr/D?=
 =?iso-8859-1?Q?r9g39TsgViH6ocOL9l46jYtcxB3FkqG3chTLzvUk4RmQtWqLhbQWuk6xMi?=
 =?iso-8859-1?Q?M8e7z47szD0aVtqbtT79oWcL+pKkePEqcqFaHYh9zwtMjx6OaEs4kWKndK?=
 =?iso-8859-1?Q?WcGKJWxnnjzw7t5a7OX6QPbUGRVXgrtHthjrXqjsnjRTgsUqGI4AhRR0WD?=
 =?iso-8859-1?Q?AHEswT5OyVIbk9NiFEi2KMhNux9aWH/SpYGT8+idXGAhxCRzifxLA57vZv?=
 =?iso-8859-1?Q?Z2ZYev0ZTqBzzJBDMCEIqSdhZoU7qmG2nY?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: ansys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR01MB8345.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92c53e19-fb72-4c83-1e97-08dd96d2a93d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2025 12:42:48.3112
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 34c6ce67-15b8-4eff-80e9-52da8be89706
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1tXepj91CmLggbTDIsXw7rei5cW2ra7MjmrlQwt3B6oqX9YVFPlmEXeGHzeT5Jp43LDBWH52siO61quR/NudLNw2lNADfNhEolBUozr3eEw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB6800

No problem. Thanks for your reply.=0A=
=0A=
Bharat=0A=
________________________________________=0A=
From:=A0Greg KH <gregkh@linuxfoundation.org>=0A=
Sent:=A0Monday, May 19, 2025 06:02 PM=0A=
To:=A0Bharat Agrawal <bharat.agrawal@ansys.com>=0A=
Cc:=A0hughd@google.com <hughd@google.com>; akpm@linux-foundation.org <akpm@=
linux-foundation.org>; rientjes@google.com <rientjes@google.com>; zhangyiru=
3@huawei.com <zhangyiru3@huawei.com>; liuzixian4@huawei.com <liuzixian4@hua=
wei.com>; mhocko@suse.com <mhocko@suse.com>; wuxu.wu@huawei.com <wuxu.wu@hu=
awei.com>; linux-fsdevel@vger.kernel.org <linux-fsdevel@vger.kernel.org>; l=
inux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>; linux-api@vger.=
kernel.org <linux-api@vger.kernel.org>; linux-mm@kvack.org <linux-mm@kvack.=
org>; legion@kernel.org <legion@kernel.org>=0A=
Subject:=A0Re: mlock ulimits for SHM_HUGETLB=0A=
=A0=0A=
[External Sender]=0A=
=0A=
On Mon, May 19, 2025 at 12:04:58PM +0000, Bharat Agrawal wrote:=0A=
> Thanks Greg for the response. RHEL has not been very helpful. I'm not loo=
king to ask for patches because of the old versions.=0A=
> These messages appear in production runs, raising concerns about possible=
 failures. Thus, the question is: Can they be ignored safely?=0A=
=0A=
Again, you are paying them for support for this, please use them, there=0A=
is nothing that the community can do to help out here, sorry.=0A=
=0A=
greg k-h=

