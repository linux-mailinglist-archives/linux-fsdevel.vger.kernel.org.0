Return-Path: <linux-fsdevel+bounces-25170-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B31949833
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 21:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C3C81F2332C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 19:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 213EA158DD1;
	Tue,  6 Aug 2024 19:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=juniper.net header.i=@juniper.net header.b="yH3s/GaP";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=juniper.net header.i=@juniper.net header.b="AGmM/rxc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00273201.pphosted.com (mx0a-00273201.pphosted.com [208.84.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68C215689A;
	Tue,  6 Aug 2024 19:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.84.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722972317; cv=fail; b=E7wPhgQJW5KyjPs8nqnHXo8JCK+Z0gO5rjlBEqKAyQlvGDlCYvmd5I1Utnej0FaRXie6Bg0LuK6rCJIlYSDnkcN0WHwDjxYGndEFWjP6Gw8SuHjHcjplAKjpaw+ZkISJlrFIx4uZVixI1O8g2dyou5pEhy+cVZtOdjCOheiKmi4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722972317; c=relaxed/simple;
	bh=gOmhiWc6U6lV5sw/F04elfTJfO57COj7j247PT6MKZE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cOeAVWeU3+x+np3h5lh5/8i3FR3e4DgI5HG3hX012Z/27fmYNgwQpjq5cLwJm7AMrjzW3w1AMpDE9YeX8BKswSpTKNL+jHl+lXd6xB1QZdfwSDnb+zyJuZz9xBfhqqMbl1EGZNKi9LwCt/hjSK6Y2uZObRio+4dkBh/e4Nw8ZkA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=juniper.net; spf=pass smtp.mailfrom=juniper.net; dkim=pass (2048-bit key) header.d=juniper.net header.i=@juniper.net header.b=yH3s/GaP; dkim=fail (0-bit key) header.d=juniper.net header.i=@juniper.net header.b=AGmM/rxc reason="key not found in DNS"; arc=fail smtp.client-ip=208.84.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=juniper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=juniper.net
Received: from pps.filterd (m0108156.ppops.net [127.0.0.1])
	by mx0a-00273201.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 476Ii6aE032376;
	Tue, 6 Aug 2024 12:24:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juniper.net; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS1017; bh=gOmhiWc6U6lV5sw/F04elfTJfO57COj7j247PT6MKZE=; b=yH3s
	/GaP/zwta09LphT+xu1ad7ROQZg7CX+FgTTkWREYSmXQRQOYV1QAUeC6rbB9NayU
	O+4iNuJQ3RJq2GMt1q9SHHMUUBrF924cPAosjEquuYh1H2JFJ4P0o5RzPQTN8nv/
	hOarlpjVUA90mYE1fC5DxySWzJXMaJhvmUeGCPtGWwFVSCR7ngQDlPFet2+Lf1nh
	Co6J8EWvEvi+R+xWJgSPsiU67htRYNCFvVqH72QBIkVpuIIj4cF0pw7Dm93XLyfC
	2bgDvYf8fm84dPZUp7dGFBXL/jCqjY8ofIlZ0EZvey+b93DOGaLO6W+ojWxogpTu
	pv7ySrJt7atK1Q77kw==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazlp17010005.outbound.protection.outlook.com [40.93.11.5])
	by mx0a-00273201.pphosted.com (PPS) with ESMTPS id 40skjee85d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Aug 2024 12:24:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QBsAAruj4t9eyuSejbOWh4DTQJCAgohB/nVi+RnkQAk2x9kp13Jrj2OhlZ2E6uEg8/ICqadscFp61ohBKVL0LArVGWu4bQK/jMHdwZBT1Ba3o+3n3+QZ77nlNMW3UDlMEE5iqXaFrKlgba741kftjAAQ/gap1VASSkNQIxcmcaJCruyQDZyHuTwirliFmFpB8fptOCX9VNF2BHQe3h1pvjJyieFx5y7w9vJYh5VnIR78u8sBScjQ8qUR1sQij36Xy78IxKIzJclPvZjcnkJVoD1zdg1DCec1La06IsVELO2hxq0Zc2oaly59mNAuvj//hJmtFoZ0RsmNtvf6t0LXKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gOmhiWc6U6lV5sw/F04elfTJfO57COj7j247PT6MKZE=;
 b=cO0oCeiYsFm5q5Fk3u+VO8aPlzvUSzwTkR7eLgb9wr5GYBp73pq/uiungrdGluYEo9vj6U6SAeUSFh/Bh8nXYY4RCkSfwdSpQqTdCtljw7Fsph3GbwkcFcPf6Z0DbvXnqm5ur0PwFieiiyWZZi8OJylRxqAc5ePRoOJBdG0JsjsPNC1cFat9TRqUYvXZTBW1Sne3ILp1uwGAhEC4wwsFVF2B+q95Rw2FlRA3DQSjQ/lwgGSuHPEqhN+ngiokiHsmKN00wi/ir9Y/uMA7bMpCkSFHR+9xrBgPnA/0kwCm3eLTrXoxUKg2V+IgTK+YfnwuJ3WaIU7u3cTtFO3tMVo1xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=juniper.net; dmarc=pass action=none header.from=juniper.net;
 dkim=pass header.d=juniper.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juniper.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gOmhiWc6U6lV5sw/F04elfTJfO57COj7j247PT6MKZE=;
 b=AGmM/rxcqvHnXlY9jX3TNEw+bYPfXF8q2oZpEmizEwP6eGAHsEa/2l+m7BMjX2/9jazb5voQaKaWW9YCnaq0jataZajBDobxg5d3Z2eEHNAjUJgpk+5ZKQxGdkNylCjSt4mzHKLaJ+P4ox59XQIzP+Q39x1YL20YvuIkh59lZYY=
Received: from BYAPR05MB6743.namprd05.prod.outlook.com (2603:10b6:a03:78::26)
 by SN7PR05MB7535.namprd05.prod.outlook.com (2603:10b6:806:105::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Tue, 6 Aug
 2024 19:24:48 +0000
Received: from BYAPR05MB6743.namprd05.prod.outlook.com
 ([fe80::12f7:2690:537b:bacf]) by BYAPR05MB6743.namprd05.prod.outlook.com
 ([fe80::12f7:2690:537b:bacf%6]) with mapi id 15.20.7828.023; Tue, 6 Aug 2024
 19:24:48 +0000
From: Brian Mak <makb@juniper.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
CC: "Eric W. Biederman" <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner
	<brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH v3] binfmt_elf: Dump smaller VMAs first in ELF cores
Thread-Topic: [PATCH v3] binfmt_elf: Dump smaller VMAs first in ELF cores
Thread-Index: AQHa6Cyyr+Pv/zK/REOrOTMOkQf+lLIajdYAgAAOXYA=
Date: Tue, 6 Aug 2024 19:24:48 +0000
Message-ID: <9619CDB8-59A1-4314-B4EA-10F51303A065@juniper.net>
References: <036CD6AE-C560-4FC7-9B02-ADD08E380DC9@juniper.net>
 <CAHk-=wh_P7UR6RiYmgBDQ4L-kgmmLMziGarLsx_0bUn5vYTJUw@mail.gmail.com>
In-Reply-To:
 <CAHk-=wh_P7UR6RiYmgBDQ4L-kgmmLMziGarLsx_0bUn5vYTJUw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR05MB6743:EE_|SN7PR05MB7535:EE_
x-ms-office365-filtering-correlation-id: 900030d1-4962-418c-1f4e-08dcb64d6f99
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?un0fXueeNGct6+AdOw/ZRxb0hm/CQ9fIe7Zpfj35nNRAGNeT4/FyZvNkeQUZ?=
 =?us-ascii?Q?EPYrnqtbzQyoMF9T1GX7fTnNIhbMUZzNWeZZPK8OO6evIFU0KukVzcCDyK1a?=
 =?us-ascii?Q?FgQlTXLQlGsmtblwIx7PPb9dKGWxy6cGjDY33O5MpZqtipW//guHSD/g2ncv?=
 =?us-ascii?Q?HsGqJQdfWPvha6Fck5BLdpWrKYxRaDJzkk8J1VpzfQIKbBFOlcO6uxiCKEF2?=
 =?us-ascii?Q?LitWeWwJf6I0oswQsWTyRhizs9/0Uxd1YapGLjExrvfrIqBIxNovwTD0BMOd?=
 =?us-ascii?Q?GIY/ZAShxxSxbqaDQpp7lixHuByuNb1muSgwlEjaj7XVG9QFWFZzHxwleoOv?=
 =?us-ascii?Q?ZPwO5DE8mKfqfoGwX7/G84VVhprg/Gb/Ay/QitvXOA/8xR2gzHDdVB/9dG1Q?=
 =?us-ascii?Q?JZNIbkcVVRjZgwPIQcxsa9cby/o9ubDq01qaXbpTcK4/i2y4tsgQ33fK9+ge?=
 =?us-ascii?Q?SMMzLw8XueL5rn+AC0RSsaDJXkWlYOgXHVuYRINRgFuRsIAT5HmXUSJUiYh3?=
 =?us-ascii?Q?vhpsTT9ygRQxqbPNNfZ49XxDH9o7VbvWG6CJeTdvubJFHL8/UhpqqUHjA/q6?=
 =?us-ascii?Q?B3udZhC6mRL3G0vIEzneBFeTv8jtsJOff+fEoD3xJ978+5cI8dW4Q/g/Awcj?=
 =?us-ascii?Q?apjZ1udqJM1/J3/p0llF4D1oiyjiJTEWMRd2Mdk4/acatj+f1GHEsDHqUuXL?=
 =?us-ascii?Q?inkta8iDSSj7grRn78RL2SrQrKwUWd2Cmn0MeBv2hdDHvDuotK2OxWe4syiG?=
 =?us-ascii?Q?+JulitZvCPkBeHxKZIy5gfMwH3f3eF5YBykdUVcknqbJ5ZlkqxQJ9MlOloyu?=
 =?us-ascii?Q?dL0yvemu8qMUHnveYfoIxBP9SRiHWUr+RXld90KFSsPt4htRFfyoG18260Id?=
 =?us-ascii?Q?NWIZCXgQZAOg3rVbbDkJfC7Mhx/5nAX61CmzGKA1ovS01FsFfWsEJbw6ov15?=
 =?us-ascii?Q?gjXgYhfd2prLhGBJ+sX22Z89FvlG0A+robc1ZbgXIC68uhFmqFzDs4Qj2BOc?=
 =?us-ascii?Q?8zERViMlE09ZqLVoP8q43Ggo7/6Z4axwv9vLKwc9yCG3NnkzfK/xOX6x1vKk?=
 =?us-ascii?Q?I+0z5dqZgvVaxIQxLFdbtXi0L8n272m0JmuiZw2y5GDoUVo0BrBdKvU3wfft?=
 =?us-ascii?Q?mVVysTZf6eyj5oX5lwtMy5IkPDHk9PwLbaSie0wzm5+r6L/GECRgw66+m1t9?=
 =?us-ascii?Q?HtQ9qkCi5eS47W16kF4YI6WagB/oXfgmY9vedmLo9YjEQRANT5UZCR1tyh74?=
 =?us-ascii?Q?Mn7EnzlayC+ANpXFZxtTc6eRkIVLtqc1W6DCcpxHdmXlrgnHuRWqa1Z/Ne1F?=
 =?us-ascii?Q?XzIb2vfw6s8mnVidtxoIMkmxcIWPKOlx+Hcd9hxrzYkIHPlAtDQr2AonGmWj?=
 =?us-ascii?Q?rAZLIeXsVep5+n0ePzRFb36tGR63xNA53iZ+OqyOdanF/0z6iw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR05MB6743.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?A1w+Bg6zRYkVNwUC5M4Ab6JYrSLbTgLPSMQKhd+C8C1cgp7kYRw1tlqgJi1P?=
 =?us-ascii?Q?tzN169Hek4dvM036YeRPvxSuHbxC7oSC5eS44C5/rvfFSsd8yRMn7znGGR9v?=
 =?us-ascii?Q?5dye6DM4nIlV01XcJ4B2NydXXf2Kg4xLimvAqlP3qKrGST+AtwoMQ9cyqv9r?=
 =?us-ascii?Q?XkCB92TZKd6aCvZntyqx+ZBSeUUuNHVLr6UpR4xg/Tom2hfXp+J2tVZqcpTD?=
 =?us-ascii?Q?NK2935vyJ6064t8FY04AG55MVa5xqRC6z97nEGdOdK5z9ofpFFzGBMyeF2ci?=
 =?us-ascii?Q?g5ko4u/1JWF41Un96E9U4fanjTZKtUx3SrnOei3KbvRMQxIpN+aAH6tgzh3R?=
 =?us-ascii?Q?01dS/tC+jKASt7EO9dNLFS6Y6vnz+4+T4d0ZdNCAiJulWdlGGGke4QwdfQi8?=
 =?us-ascii?Q?1GKeUeCOoXKbajlZjK/V+0kFZTZzxnVzsmZmvfRof1LTShn7qp8ENwVNgKDT?=
 =?us-ascii?Q?ZueN1hj7zGp0n/4lg/XES/k/tLgpASDIAdMKe58c+Za4Vxvn6q9Hm1W6YBJ6?=
 =?us-ascii?Q?6SBv6m+vf18cdJRA3axt4Ke/9LrhBtYzNcPn/d7Ji0gV9TtvnasCHesZU9AQ?=
 =?us-ascii?Q?4FvZCEtYp/1fGTlXm2R6zDYxz7bYkJMLl0hL2jkKJ8Cz6Kq/bhPbDhmDGJGI?=
 =?us-ascii?Q?CP4ICSvfxEZFR3hDt2WbjpZdF7W2rXz8vqFwCXfZtpOWxZwYTB9BluZ3BnKf?=
 =?us-ascii?Q?fU6QVQ6LSLXtQ2Hj3F9ks/AFo51Gyj3GAtdj2lTJY0ODTb6RCcEoPKLIvo5T?=
 =?us-ascii?Q?LmG5CY15XdNB1brmaKVbC5KZKZSmgTcBwJf6sTYfiZrT3ZXVVSmNGfnusUT5?=
 =?us-ascii?Q?tV6NEVKeW5+vIL2ZBbIErjSZAkSON59pQmyThXrZ18ZqRepEQoTFD47pg5Mz?=
 =?us-ascii?Q?kcdgahIDw7zSj43BtoGkuSkzi+znbq7yv3VdUnVjlkjtYca5erSZ06gZDLxC?=
 =?us-ascii?Q?hwbRcswxmGz2wU69GOR3yAuykMXvUmvg+rSCHCrrwTWwAI7jCjLobMKSxLaS?=
 =?us-ascii?Q?JxR/vBTtv1b+YVVQNJCFOZe66uA9K5kExrmwsP4BqGxybIo3IuVrpdB3M0IU?=
 =?us-ascii?Q?I/R3ZEZxnG8eQ9fbzqzhJuEt9hnOz8hyYdBfvBJsI+s3U1ndL3Q2oubGDa2b?=
 =?us-ascii?Q?6RHI4t4ZfYVQk4wfgMQAPyUqt6S2jJF4/XsgfD/hYsMeBrIqv0lPr3WIqvA/?=
 =?us-ascii?Q?f3z1WmUc0yk16mc6JdkQs/TLUoMXyvNA/W1n+d8MQKCryvT5RoNC6halVz6h?=
 =?us-ascii?Q?eyOUBiosPkpGVDLAOVyGpfY1l9lK8XJnBMvBHyAd6INBnLU9+uiV2v1O3Xf/?=
 =?us-ascii?Q?U0/cMqbbfP2LeJHUUdsYXXsacPTVT3rng5hPr+zHm7SvOjUIBvIiOSNAFJ/v?=
 =?us-ascii?Q?Ml0gzvKrFmkttozTimZbtUrnv87ZBYiGj4PPz7M04/jmmn4CvrexIDPA8ueh?=
 =?us-ascii?Q?qot6H6E+Bsl+sBI51ad0Jqrg+ulY4FgMDF+skwN2VYa7EsJZdVLIoFkuhZPP?=
 =?us-ascii?Q?BWiI7xx5TszwBuGtuDqSyn5oCB2PzT/DzzpOwyiQrFjn0u/eFprZVkXaVPHO?=
 =?us-ascii?Q?Pm3Z+kltEmyC1N+gMkwlaJtrAu2wQXFrx5clz74O?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <553506E863695E4C844B6E25C06546FF@namprd05.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 900030d1-4962-418c-1f4e-08dcb64d6f99
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2024 19:24:48.0251
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bea78b3c-4cdb-4130-854a-1d193232e5f4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SSZLBp2qtuLSQhpVbReh78O3Mip2XDgPyO7gEe88EEWWEE6BCVB2k4nNeettbb8mJwFb/mLkPRmfedme+T1gEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR05MB7535
X-Proofpoint-ORIG-GUID: Ig54nPZuK-AlRliO6_yN0Ap07S_j4b5i
X-Proofpoint-GUID: Ig54nPZuK-AlRliO6_yN0Ap07S_j4b5i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-06_16,2024-08-06_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_spam_notspam policy=outbound_spam score=0 malwarescore=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 mlxscore=0 phishscore=0 impostorscore=0 mlxlogscore=999
 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408060136

On Aug 6, 2024, at 11:33 AM, Linus Torvalds <torvalds@linux-foundation.org>=
 wrote:

> Hmm. Realistically we only dump core in ELF, and the order of the
> segments shouldn't matter.
>=20
> But I wonder if we should do this in the ->core_dump() function
> itself, in case it would have mattered for other dump formats?
>=20
> IOW, instead of being at the bottom of dump_vma_snapshot(), maybe the
> sorting should be at the top of elf_core_dump()?
>=20
> And yes, in practice I doubt we'll ever have other dump formats, and
> no, a.out isn't doing some miraculous comeback either.
>=20
> But I bet you didn't test elf_fdpic_core_dump() even if I bet it (a)
> works and (b) nobody cares.
>=20
> So moving it to the ELF side might be conceptually the right thing to do?
>=20
> (Or is there some reason it needs to be done at snapshot time that I
> just didn't fully appreciate?)

The main reason it was done at snapshot time was to make it so that it
works with other dump formats like ELF FDPIC (that being said, yes I
didn't explicitly test it). If another format is introduced and isn't
compatible with this type of reordering, then I think the introduction
of that format should be reconsidered for lack of flexibility, or if it
really must be introduced, then this logic can be changed at that time.

That being said, my opinion on this isn't too strong, so if you feel it
is better to have it in elf_core_dump, we can do that too. Since Eric
originally brought up placing it here, maybe he has his own opinions on
this as well.

Best,
Brian Mak=

