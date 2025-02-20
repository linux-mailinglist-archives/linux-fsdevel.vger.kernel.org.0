Return-Path: <linux-fsdevel+bounces-42193-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D20BA3E8B8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 00:44:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 478C87A9F73
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2025 23:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BCBD267737;
	Thu, 20 Feb 2025 23:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=juniper.net header.i=@juniper.net header.b="1cTbNpSf";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=juniper.net header.i=@juniper.net header.b="jhBIVSJ0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00273201.pphosted.com (mx0a-00273201.pphosted.com [208.84.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA44E26389E;
	Thu, 20 Feb 2025 23:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.84.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740095008; cv=fail; b=eKWk8JPPifvkQfTqNCO82VZ4gIfNg3JknEqmKNxEr5ZB22cSSKwGTDT7zZTtrp9qe6KuXmktsTlmlX7TM/Mr0dSDCGkq+MyU7hQeaMELvsu5QJuLCcufuGS022WoDZJAh56WErk5FeqwOVZh4Skbsxy2YAFonVHcHwxr6kStufE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740095008; c=relaxed/simple;
	bh=LSlMWrZEnPLXqqwfXrQW7CTkeyWkocGcxVOsaCkIsjs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OmclguQtKSYYByRjDV3TUd/ful3OFJDR9y/1lf7yBSZWEt7TPrN4LLHfvPCQrjEa9yOGEeiZ7kiQ7W6aN5hL0KtV9hLla/kDvU9554JiUy2QMtfUVyzKSYnv5/OaZ4NK6+qVdfTiv90GdlVmK3MJI4e/EAXaDx2NcInefYf53qs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=juniper.net; spf=pass smtp.mailfrom=juniper.net; dkim=pass (2048-bit key) header.d=juniper.net header.i=@juniper.net header.b=1cTbNpSf; dkim=fail (0-bit key) header.d=juniper.net header.i=@juniper.net header.b=jhBIVSJ0 reason="key not found in DNS"; arc=fail smtp.client-ip=208.84.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=juniper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=juniper.net
Received: from pps.filterd (m0108159.ppops.net [127.0.0.1])
	by mx0a-00273201.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51KFK6Oc004489;
	Thu, 20 Feb 2025 14:59:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juniper.net; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS1017; bh=8zvCUW9rqIKG0lfYeHjOv7zn73Ku2HPdZnmXaCHsQro=; b=1cTb
	NpSfHG/Ert0/qnVlo1xcYqi6JfD2G75l+Ts6xTQ4mWC3LL+frGXXOa/jGZzP66j5
	werrnBwTnPvTUBWAhyG0QU71H4sNzI6LP+dHwR+O+fjtS0tMEsJ5d27DZ0f6JBPC
	gIBBKrI4njO6t7uQLGX0XjamXL1UbB8VWg8dVDmzBKSGYz5CzpgOl0pV3fa1ma8P
	3wkbLvLKjiq4HkkoCQbKVTa7syaQfQDjJqZZFkwtlv13i4W1d2B7zjVy5WBT1l0c
	6BEDLb4FTRW2GwgcPjHC32YjlzFR9J9jlE/COBv5ao2LSDATPvlcBNHtpU6Rjv89
	M1D/im2ZKFT600xsuw==
Received: from bl0pr05cu006.outbound.protection.outlook.com (mail-BL0PR05CU006.outbound1701.protection.outlook.com [40.93.2.11])
	by mx0a-00273201.pphosted.com (PPS) with ESMTPS id 44vyyxp2gd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 14:59:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zR/JT8OxoZoIx0LVemtSiYzYW4GtsifGCyxUl4fVfkCZGcy/09t300VXwBDu/VsHEfSvSKcdrs40YU56cA6CJlyooZ7Y9nRX3KXyYUoPZV970r1NCyRuXPNHDMjKyxxWEqs+yfQzwMVALi3/u+ZcWpj92X+JCty5PCHCwQKvFMon4GkOw/V7zM1hGlNC3+XO/Ku7G5CyePBAQGtoFGhcuP30TWzdmIzb5llPPNNDNYCH+gLEO0SzyPog/H/cE/R4eBjicDJIi6AY+7ulkcao/vVHxOybPnjCASNY1syd1jfPcx2/S8NmDOxdmK1c1BlPBfw/pWpXNIOC2FZkbXHVCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8zvCUW9rqIKG0lfYeHjOv7zn73Ku2HPdZnmXaCHsQro=;
 b=duLI0KWp+fOIZe0PW7+EVJMoGokn1K8B5MZ6UG08vUdc/pspgoCIVHN+P2X1iQfavr6MEg9ux5/BIpQ1K8It81PCfkOTtWlXFxdK6EXULyvYqZI2XkDE3+A0L1cjLYmm70YRf+KG53R00BMCZ9sVK9VqkG52VSUUrk8q9Yu/ZVriwffGWCGjVFoeChgVgs2PoZ+J/p32KB6tJd1Seb3ozDMUfERajGTaiayxxMIduSvg8M9Drl+Nj/N6f1olXpkh5LGRhV/2TCV05x15/Yc7mscyStBnoJjRgECXsDi8yvnzDZ+n8Nt5WP6fmkni/RLso9An39C4OoBk2mFO7qHaXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=juniper.net; dmarc=pass action=none header.from=juniper.net;
 dkim=pass header.d=juniper.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juniper.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8zvCUW9rqIKG0lfYeHjOv7zn73Ku2HPdZnmXaCHsQro=;
 b=jhBIVSJ0y7UyQt0x+tXy8bnf/+MrWJsQpvQQ9WBCKXQPTyWLoU+MWgukxjsTbqAywXMPYQHhTz59+8/HsNKzuE5IHCRhqHqHLTjSVq5iOImC3ZZlieqLiPrTR0nRpCNt+nL/VP8Bs/T2jysSmFUFnhz1oXkj0x3a8fu1IFl/KLw=
Received: from BYAPR05MB5799.namprd05.prod.outlook.com (2603:10b6:a03:c9::17)
 by CO1PR05MB8491.namprd05.prod.outlook.com (2603:10b6:303:ea::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Thu, 20 Feb
 2025 22:59:27 +0000
Received: from BYAPR05MB5799.namprd05.prod.outlook.com
 ([fe80::e33:dc6a:8479:61e2]) by BYAPR05MB5799.namprd05.prod.outlook.com
 ([fe80::e33:dc6a:8479:61e2%4]) with mapi id 15.20.8466.016; Thu, 20 Feb 2025
 22:59:11 +0000
From: Brian Mak <makb@juniper.net>
To: Kees Cook <kees@kernel.org>
CC: Linus Torvalds <torvalds@linux-foundation.org>, Jan Kara <jack@suse.cz>,
        Michael Stapelberg <michael@stapelberg.ch>,
        Christian Brauner
	<brauner@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v3] binfmt_elf: Dump smaller VMAs first in ELF cores
Thread-Topic: [PATCH v3] binfmt_elf: Dump smaller VMAs first in ELF cores
Thread-Index:
 AQHa6Cyyr+Pv/zK/REOrOTMOkQf+lLNN9PkAgAC4SgCAAVa2gIAAOzWAgABQU4CAAA/ogIABZj+A
Date: Thu, 20 Feb 2025 22:59:06 +0000
Message-ID: <5870D095-D47F-447F-A079-B32D9C415124@juniper.net>
References: <036CD6AE-C560-4FC7-9B02-ADD08E380DC9@juniper.net>
 <20250218085407.61126-1-michael@stapelberg.de>
 <39FC2866-DFF3-43C9-9D40-E8FF30A218BD@juniper.net>
 <a3owf3zywbnntq4h4eytraeb6x7f77lpajszzmsy5d7zumg3tk@utzxmomx6iri>
 <202502191134.CC80931AC9@keescook>
 <CAHk-=wgiwRrrcJ_Nc95jL616z=Xqg4TWYXRWZ1t_GTLnvTWc7w@mail.gmail.com>
 <202502191731.16FBB1EB@keescook>
In-Reply-To: <202502191731.16FBB1EB@keescook>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR05MB5799:EE_|CO1PR05MB8491:EE_
x-ms-office365-filtering-correlation-id: d57d58a9-1425-4452-dc1f-08dd52022e73
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?qbq00nKB3x72U4kVHkq4YKBXbF1/x8swaL0m5RofB6zne9UKqulh8x9MBhhs?=
 =?us-ascii?Q?kqgKG+Br33OE6DiBUDJj1T1skU7jRCJ1jhS6+ZCb8DenDtldlNQbw7HsSMv2?=
 =?us-ascii?Q?DEw85nifJ0vAXWiWWArrg2W6Q6DLkh8ps3DkW9/UEgQtLNGMQdQQG5xov2ux?=
 =?us-ascii?Q?ZkQ5ccmrrxwns7/1hIeizpnVZNGEMPYRgYq1vRR15s00W/y4qZz+nLeT2YeA?=
 =?us-ascii?Q?WXK+T9dWT9MsQ/cIxFuKQbUfTBJ74eieP2lEBc/Op7Gbo+KSkC1gr4zPNfpK?=
 =?us-ascii?Q?GI2RnN+OiMB6c1BLmyhh/gZktW726mhqwcjqq90Pd5vbLBzX41r4gBn7LdXF?=
 =?us-ascii?Q?i+774J3xasWW5E3wI+H6X3gbw/4f+pBpa9yeuG1dizBujz/kpcFvFvEnGLX9?=
 =?us-ascii?Q?OoAs22uD2W1EjYdiCN8VG67CMKEBUchn0ZpZ5/bAKo6h+UUmUM8eSKlXieTB?=
 =?us-ascii?Q?p3aPUktYfa4fbWqBbwZN1J5zwc9iNDQDfn0RymNIykMey82WlVoaEBS313NH?=
 =?us-ascii?Q?94zSsuPprgdh07Gy8CprUvaB8T2BPiG3dh78+WBduSYLvEQYfGrTS3JJm3/P?=
 =?us-ascii?Q?D7JJr87iM/Qm9IIYTQu/1WnjD5YyT1hKVNtr3+iQ2WsnFccFCkwtPqKpfwn1?=
 =?us-ascii?Q?jLmr87kVUIrFi7bFx0Oc81crzmP/ccVHgzDJeraSMHYetoWzAWzsw5hTciUb?=
 =?us-ascii?Q?yLKzs3lXdtWaUO+GBpJOGcw3l7W8L1fe0AvDaXe+rNX7fJ0uW+cbp1ewJ3JV?=
 =?us-ascii?Q?QEcdTJHpfgb3LwBxtcXITHCVECaglGThuQ3sDLLUcCiGd9njxgClt2J0RtL2?=
 =?us-ascii?Q?FDeH+B/zs29p7Kdfe5xXoKf1ANFcRWqBgi9mBBsacvWz9KP8RDpZ159ICDI0?=
 =?us-ascii?Q?8JEbvwoeO+aFcQkyxaEUyzBlMJ74fCYg/iPZrE6MGMagiNFEJZsjwcOoXlAh?=
 =?us-ascii?Q?h0riTCB8bzmJ7JMGq7pyQoByUvhfsg6V3YQF9KGOW7h+Q1b7AnUdzfo2lLPE?=
 =?us-ascii?Q?4zJgruesDLGlkKRL/8Ow4GG8UzLYPG0OLyFhuURecazsIfT/IOwzxG//FitP?=
 =?us-ascii?Q?aq9NzuM27zaKkbwLYedgMJfbrUupEyfqZUm+nQ1u/LViUY7AgKRH6cSWk1bs?=
 =?us-ascii?Q?iX8WAXkrwvfyHBjofXZ9sFMJPhtHHx+LTfLSruJDILdKBtSYjfdIHKkFeQBx?=
 =?us-ascii?Q?8t3R+SmOnjmSRXNwYjvOWBe74LuD7Ca6xuVBMp4sx1vsnDuLwwi+iuedbWrh?=
 =?us-ascii?Q?rf6SmeWcn4BSffGOZnnrC9w5dS5LvVh7Q+SuYmBJOX2zpCXzNPOWaKr8s+gh?=
 =?us-ascii?Q?5ZHb/+1B9Uq3VwF/aeAUexIrOnKpVPl4bPO4r5GzQJbFzuIif3QVWMoWZ3vB?=
 =?us-ascii?Q?vhDdqbRe90DkS7l5l6ZZvk+j0kJDpbEL+xD0fv7Zmvigi/BPzW4YYINwk37j?=
 =?us-ascii?Q?AscypzpjAoPOk+/BkbNwYtnclWBqfkpF?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR05MB5799.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?kCvsvRw/prZg55p/DanXTI/KDEoS6ADmHwvHpyHOkbxSgG2rcSA9TVI6ADDk?=
 =?us-ascii?Q?nFES//QJgzAEXD1nq/2uv//g7UipuFTKGtrOH7l2YfBJ5NgiiWZxHF3c0BOO?=
 =?us-ascii?Q?KuM+22JbnyoIdmThcne6au1Unh0gSGwPK7f9bxzBW/T7SjeeSh0BjC7NHTfo?=
 =?us-ascii?Q?xQ/lEvpq91nGwUwRE4bk5M3JDOpsOZMAt8is80yENPv7yKWkTSfLz3KLAN0K?=
 =?us-ascii?Q?eamrhrWTtY4Acx2dRdG8dSvksACqYrV1D+IhB+SXCQwl1fiWXPRes5o0kwM/?=
 =?us-ascii?Q?j5S79zWn33TFOdxFXtXbxNDoXZ2PKnHEfO/n1yEukhZR8nxnAC9PuLABxhZy?=
 =?us-ascii?Q?ing23afVBZja66XnK4BfL+L2ujRYBrXYAxwIHsGJBoQQsL4uEY2pOLaVqunR?=
 =?us-ascii?Q?rocNTJwTA6Vp1eUq3Z7iN9Ve3z1HG3ll3g/sQueMb/RYLhyTMaf/9bJvZ5rh?=
 =?us-ascii?Q?5nehJhXWejJxa55Kq9stv8CIrBIpVDL7zb8TzpCeaCjli5g2HG3xvLubOyxF?=
 =?us-ascii?Q?OvNxZ7rB0SANmoIFRAfXgf78hoXvEqJI6mVZJLhNjONfr1i9n/dVNPe639kn?=
 =?us-ascii?Q?HAy4Z+U16SV4asM4at286ranzb58OtsSv7con6tOV3Y1v1icXxqnvVB2xMmq?=
 =?us-ascii?Q?1XaJ9PiDUk7ANGorYB1mDJk/GkT6WKcjNuIIla/nFB4Y94Tfb5x5rrEzWM4G?=
 =?us-ascii?Q?waSY7ya1Cve9SbApuQoajEZoAn04gcYmjku5R8Wdac0AhlgFwctRHJVaWn7K?=
 =?us-ascii?Q?egZrVw/2M5IoQPNhwPVlq1N22f8CIH4tbRZekETORhlpZ3jDldNgdLypTd2X?=
 =?us-ascii?Q?m41BaaJZTXDN0WM7lwNjJuTg7VDiNDDEmnc6SQUNw/KtVDXlNc+4kQF2hvht?=
 =?us-ascii?Q?MngUJuOC/A6uuOF2gjo2ytAgfXP+k+rgWN19WI3smuTewL8L36xcIU5gjoex?=
 =?us-ascii?Q?eQ/xAIQwBYuSzMoJI03az4eBLUTfc4jt+FWeqOONSx7rKQaDTUuAtCHRf3Gu?=
 =?us-ascii?Q?kLUPp+tsyGSlWKwJbN6IYltqFrHrCpWDQo9mpFe6V3A36Kztu16tKH8dwWDi?=
 =?us-ascii?Q?swkrBTRUpD46fkXoqOr42sS5dcFpeGEu+NqgSfVpqaRP3Hi6dLe0UaZTRcYd?=
 =?us-ascii?Q?kMAGF2Q/pu/18sc9eR1zFMlKzY1rAhel4A0Yyhzv4Uy2Q8g4wO/AUP4mmY+m?=
 =?us-ascii?Q?r87geCoJ/QLlwPIhGcjBOuXUaoicAWHr2hKybd6msBUtxwg8K0tO9WnnaRqM?=
 =?us-ascii?Q?7MVfq6xOAZlJFUb78WqMlwPgrodWFMFvgoooBHEGvpqmdKYHLb4lVrW2/t/W?=
 =?us-ascii?Q?iJ4+rWJ4ezMt3jQEjOX0seZ5+hfoxatfrBWb8YUqY2niAwOe56ca4/kaEJP/?=
 =?us-ascii?Q?iMQwDE0dhJacFDgx9n+2S5+nceIr/jbM+TC17/ixji316MYf7ViVa/naC+Nm?=
 =?us-ascii?Q?XTAUqvml/xWYTob3Ot5AxECx3uOl4e+VJITQ73exqBBypJGecjslHdNEw3Nx?=
 =?us-ascii?Q?NZXvh/gRiNKanJ3cnc/AfxBPNtBlQ7vWOzHOSYEep4d/vVy1/85TqVwdCN5B?=
 =?us-ascii?Q?qMbbyTBivd3GNqcMJEioTyGEFfZkw+Ep9uPUH5RP?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4B36C1AEA9B486408D51077ECBB88234@namprd05.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d57d58a9-1425-4452-dc1f-08dd52022e73
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2025 22:59:07.9087
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bea78b3c-4cdb-4130-854a-1d193232e5f4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6A7sUM6bbqKPfqygKGmQlKXOt0/8Xv75cg9dmOi4Cetwc7HzEgRnvcm5MxIyFhPY8xJX/045t0/eNHnw33ZEqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR05MB8491
X-Authority-Analysis: v=2.4 cv=d74PyQjE c=1 sm=1 tr=0 ts=67b7b3d1 cx=c_pps a=XJbScVYJ+YTk0JuXi+vtpg==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=T2h4t0Lz3GQA:10 a=rhJc5-LppCAA:10
 a=VwQbUJbxAAAA:8 a=Ugll38AFM-JoRbNtZf8A:9 a=CjuIK1q_8ugA:10 a=VYcpXjmDHnEIALPoEwzu:22
X-Proofpoint-ORIG-GUID: z0weDoQvY7Vij0L_Gyu8sP1eZXhnjX-1
X-Proofpoint-GUID: z0weDoQvY7Vij0L_Gyu8sP1eZXhnjX-1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_09,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_spam_notspam policy=outbound_spam score=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 mlxscore=0 adultscore=0 mlxlogscore=999
 bulkscore=0 phishscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2502200151

On Feb 19, 2025, at 5:36 PM, Kees Cook <kees@kernel.org> wrote:

>> We already have the code to count how big the core dump is, it's that
>>=20
>>                cprm->vma_data_size +=3D m->dump_size;
>>=20
>> in dump_vma_snapshot() thing, so I think this could all basically be a
>> one-liner that does the sort() call only if that vma_data_size is
>> larger than the core-dump limit, or something like that?
...
> Oh! That's a good idea. In theory, a truncated dump is going to be
> traditionally "unusable", so a sort shouldn't hurt tools that are
> expecting a complete dump.
>=20
> Brian, are you able to test this for your case?

Hi Kees and Linus,

I like the idea, but the suggested patch seems to have issues in
practice.

First, the vma_data_size does not include the ELF header, program header
table, notes, etc. That's not a terribly big issue though. We can live
with that since it makes the estimated core dump size *smaller*. An even
bigger problem is that the vma_data_size doesn't take into account the
sparseness of the core dump, while the core dump size limit does.

If a generated core dump is very sparse, the vma_data_size will be much
larger than the actual size on disk of the core dump, triggering the
sorting logic earlier than expected.

One thing we can do though is to iterate through the pages for all VMAs
and see if get_dump_page() returns NULL. Then, we use that information
to calculate a more accurate predicted core dump size.

Patch is below. Thoughts?

Best,
Brian

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/ad=
min-guide/sysctl/kernel.rst
index a43b78b4b646..dd49a89a62d3 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -212,6 +212,17 @@ pid>/``).
 This value defaults to 0.
=20
=20
+core_sort_vma
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+The default coredump writes VMAs in address order. By setting
+``core_sort_vma`` to 1, VMAs will be written from smallest size
+to largest size. This is known to break at least elfutils, but
+can be handy when dealing with very large (and truncated)
+coredumps where the more useful debugging details are included
+in the smaller VMAs.
+
+
 core_uses_pid
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
diff --git a/fs/coredump.c b/fs/coredump.c
index 591700e1b2ce..496cc7234aa7 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -63,6 +63,7 @@ static void free_vma_snapshot(struct coredump_params *cpr=
m);
=20
 static int core_uses_pid;
 static unsigned int core_pipe_limit;
+static unsigned int core_sort_vma;
 static char core_pattern[CORENAME_MAX_SIZE] =3D "core";
 static int core_name_size =3D CORENAME_MAX_SIZE;
 unsigned int core_file_note_size_limit =3D CORE_FILE_NOTE_SIZE_DEFAULT;
@@ -1026,6 +1027,15 @@ static const struct ctl_table coredump_sysctls[] =3D=
 {
 		.extra1		=3D (unsigned int *)&core_file_note_size_min,
 		.extra2		=3D (unsigned int *)&core_file_note_size_max,
 	},
+	{
+		.procname	=3D "core_sort_vma",
+		.data		=3D &core_sort_vma,
+		.maxlen		=3D sizeof(int),
+		.mode		=3D 0644,
+		.proc_handler	=3D proc_douintvec_minmax,
+		.extra1		=3D SYSCTL_ZERO,
+		.extra2		=3D SYSCTL_ONE,
+	},
 };
=20
 static int __init init_fs_coredump_sysctls(void)
@@ -1204,6 +1214,7 @@ static bool dump_vma_snapshot(struct coredump_params =
*cprm)
 	struct mm_struct *mm =3D current->mm;
 	VMA_ITERATOR(vmi, mm, 0);
 	int i =3D 0;
+	size_t sparse_vma_dump_size =3D 0;
=20
 	/*
 	 * Once the stack expansion code is fixed to not change VMA bounds
@@ -1241,6 +1252,7 @@ static bool dump_vma_snapshot(struct coredump_params =
*cprm)
=20
 	for (i =3D 0; i < cprm->vma_count; i++) {
 		struct core_vma_metadata *m =3D cprm->vma_meta + i;
+		unsigned long addr;
=20
 		if (m->dump_size =3D=3D DUMP_SIZE_MAYBE_ELFHDR_PLACEHOLDER) {
 			char elfmag[SELFMAG];
@@ -1254,10 +1266,27 @@ static bool dump_vma_snapshot(struct coredump_param=
s *cprm)
 		}
=20
 		cprm->vma_data_size +=3D m->dump_size;
+		sparse_vma_dump_size +=3D m->dump_size;
+
+		/* Subtract zero pages from the sparse_vma_dump_size. */
+		for (addr =3D m->start; addr < m->start + m->dump_size; addr +=3D PAGE_S=
IZE) {
+			struct page *page =3D get_dump_page(addr);
+
+			if (!page)
+				sparse_vma_dump_size -=3D PAGE_SIZE;
+			else
+				put_page(page);
+		}
 	}
=20
-	sort(cprm->vma_meta, cprm->vma_count, sizeof(*cprm->vma_meta),
-		cmp_vma_size, NULL);
+	/*
+	 * Only sort the vmas by size if:
+	 * a) the sysctl is set to do so, or
+	 * b) the vmas don't all fit in within the core dump size limit.
+	 */
+	if (core_sort_vma || sparse_vma_dump_size >=3D cprm->limit)
+		sort(cprm->vma_meta, cprm->vma_count, sizeof(*cprm->vma_meta),
+		     cmp_vma_size, NULL);
=20
 	return true;
 }


