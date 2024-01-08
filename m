Return-Path: <linux-fsdevel+bounces-7548-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D89827027
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jan 2024 14:46:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 125D2B223B5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jan 2024 13:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8CC45961;
	Mon,  8 Jan 2024 13:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aisec.fraunhofer.de header.i=@aisec.fraunhofer.de header.b="nm6xH59Y";
	dkim=pass (1024-bit key) header.d=fraunhofer.onmicrosoft.com header.i=@fraunhofer.onmicrosoft.com header.b="KaLRLFlq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-edgeka27.fraunhofer.de (mail-edgeka27.fraunhofer.de [153.96.1.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9BE45940;
	Mon,  8 Jan 2024 13:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aisec.fraunhofer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aisec.fraunhofer.de
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=aisec.fraunhofer.de; i=@aisec.fraunhofer.de;
  q=dns/txt; s=emailbd1; t=1704721581; x=1736257581;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oRgkPsKhtZzWviDVeB6NvKhz4qKenJoHBSExf4b7SxI=;
  b=nm6xH59YUHXiLHgem9e9NEIk+jxZ3RcZo7o6CwSyoeBm0MldGYuBAC3B
   KEUxQRIvBlTv80Yyo7mMDVGM1ZJgpo1vNBULBBoMspEVMfgzvUHo3stf0
   Ba9Xz9ZNqaNynlaeNzZB0+XDe7JCHDMFIZHTcL8Zs/fJIDRPG98X1rE1J
   oKsYVdt19XvNHJ7JSTI9owBSnOm9FBLYlXlO5VDHMipc7kWP413q5M/JE
   IKl6IaOqcxB8rJsDeMrmFuOTjZSjm1j6OzC9KqnorWMv9fqn8kYGAMqAb
   KEZvjIuinD4oo2o8vwHv+gSn1kPQk8vDkIxAp6YqXAFyn5Sisl4gpjaGl
   Q==;
X-CSE-ConnectionGUID: te2S7fvLT1ux3VlE7CuEIA==
X-CSE-MsgGUID: poospWb1SZagkSWgUgAPQw==
Authentication-Results: mail-edgeka27.fraunhofer.de; dkim=pass (signature verified) header.i=@fraunhofer.onmicrosoft.com
X-IPAS-Result: =?us-ascii?q?A2GAAACu+5tl/xoBYJlaHQEBAQEJARIBBQUBQIE9BgELA?=
 =?us-ascii?q?YIQKIJbhFORNi0DgRObGCqBLBSBEQNWDwEBAQEBAQEBAQcBAUQEAQEDBIR/A?=
 =?us-ascii?q?oc7JzYHDgECAQMBAQEBAwIDAQEBAQEBAQEGAQEGAQEBAQEBBgcCgRmFLz0Ng?=
 =?us-ascii?q?3mBHgEBAQEBAQEBAQEBAR0CNVMBAQEBAgEjBAsBDQEBNwEPCxIGAgImAgIxF?=
 =?us-ascii?q?w4GAQ0FAgEBgnyCLAMOI7Eien8zgQGCCgEBBrAjGIEhgR8JCQGBEC4Bg2aEN?=
 =?us-ascii?q?AGFZ4Q7gk+BFScLA4I9OD6EKi6DRoJoghmDQoRcinZSfx0DgQUEXA8bDx43E?=
 =?us-ascii?q?RATDQMIbh0CMTwDBQMEMgocCyEFVQNDBkkLAwIaBQMDBIEwBQ0aAhAaBgwmA?=
 =?us-ascii?q?wMSSQIQFAM7AwMGAwoxAzBVQgxQA2gfMgk8CwQMGgIbHg0nIwIsQgMRBRACF?=
 =?us-ascii?q?gMkFgQ0EQkLKAMsBjgCEgwGBgldJgcPCQQlAwgEAyspAyN0EQMECgMUBwsHd?=
 =?us-ascii?q?wMZKx1AAgELbT01CQsbQwKWGRFCDhE+PoEggS0ekwSDNAGPdJ8mB4I0gWChG?=
 =?us-ascii?q?AYPBC+XNJJah3WQWCCiUy8EhRcCBAIEBQIOCIFqA4IMMz6DNlIZD44gOHQBA?=
 =?us-ascii?q?oJJj3p1AjkCBwEKAQEDCYI5iC8BAQ?=
IronPort-PHdr: A9a23:jihpJBREi0fp3Mo+JsswFmiz3dpsou2eAWYlg6HP9ppQJ/3wt523J
 lfWoO5thQWUA9aT4Kdehu7fo63sHnYN5Z+RvXxRFf4EW0oLk8wLmQwnDsOfT0r9Kf/hdSshG
 8peElRi+iLzKh1OFcLzbEHVuCf34yQbBxP/MgR4PKHyHIvThN6wzOe859jYZAAb4Vj1YeZcN
 hKz/ynYqsREupZoKKs61knsr2BTcutbgEJEd3mUmQrx4Nv1wI97/nZ1mtcMsvBNS777eKJqf
 fl9N3ELI2s17cvkuFz4QA2D62E1fk4WnxFLUG2npBv6C6bDnjvfhsF3/wnKF5Tfd5EXBDCNy
 uBERU7k2AgmbTgm2XP8qJ1O0YQFvR309Hkdi4SBQ4ixDt5QerrEb48bbGgZBeMWDXRkX6KAP
 qw0L9QLZ7t28ojggmQCo0G8Pw3xNcnNwB9VuVnz46sj4e44TASc3xYwRMpNni7whfr2NuBNc
 tzl4q+Z/BHPQc9PyQ3C59ORS0EFodGBeq1MS5Dj8WUIJi/bsgqWg43mAh2FzbQh7lXCw8FwD
 N+Fj0gHthNjixyol9Y01bXl1qwF7w7qrnQg5dg0GfucR0BxTYaJRcgYp2SbLYxwWsQ4XyRyt
 T0nzqFToZegZ3tiIPUPwhfeb7mKf4eF4Ru5C6CfOz5lgnJidr+lwRq/ogCsyez5A9G9y00C7
 jFEnd/Fqm0X2lTN59KGRPpw8gbp2TuG2w3JrOARCU4unLfdK5kvz6R2kZwWsE/ZGTTxllmwh
 6iTHng=
X-Talos-CUID: 9a23:cBzzmW4AJWHyUqbz0dss6ENOIZ8rbFnhlWrAeHG8JDlCVZC0YArF
X-Talos-MUID: 9a23:1b5eMwmLtEgh2fz/VyfNdnp6M8Bz+5ukUXs/mJoFgPaLCCNZAw6C2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,341,1695679200"; 
   d="scan'208";a="6376445"
Received: from mail-mtaka26.fraunhofer.de ([153.96.1.26])
  by mail-edgeka27.fraunhofer.de with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 14:45:07 +0100
X-CSE-ConnectionGUID: UzoqWJ3FQwqNuWOfJkZS5Q==
X-CSE-MsgGUID: R1JiRx+oT1KUC3CNEZej9w==
IronPort-SDR: 659bfc61_9IlkRLLgEF7ypICz2Zi/8hGR0e9Cr9Wji9SGAj0255SggJe
 V3VZVwM0+hxcmk2EOcLIb+pfc62fN9aDyVO1G/Q==
X-IPAS-Result: =?us-ascii?q?A0CFAQCu+5tl/3+zYZlaHAEBAQEBAQcBARIBAQQEAQFAC?=
 =?us-ascii?q?RyBGAUBAQsBgWYqKAc+gQ+BB4RSg00BAYUthkUBgXQtAzgBWptCgSwUgREDV?=
 =?us-ascii?q?g8BAwEBAQEBBwEBRAQBAYUGAoc4Aic2Bw4BAgEBAgEBAQEDAgMBAQEBAQEBA?=
 =?us-ascii?q?QYBAQUBAQECAQEGBYEKE4VsDYZFAQEBAQIBEhEECwENAQEUIwEPCxIGAgImA?=
 =?us-ascii?q?gIxBxAOBgENBQIBAR6CXoIsAw4jAgEBpTMBgUACiih6fzOBAYIKAQEGBASwG?=
 =?us-ascii?q?xiBIYEfCQkBgRAuAYNmhDQBhWeEO4JPgRUnCwOCPTg+hCqDdIJoghmDQoRci?=
 =?us-ascii?q?nZSfx0DgQUEXA8bDx43ERATDQMIbh0CMTwDBQMEMgocCyEFVQNDBkkLAwIaB?=
 =?us-ascii?q?QMDBIEwBQ0aAhAaBgwmAwMSSQIQFAM7AwMGAwoxAzBVQgxQA2gfFhwJPAsED?=
 =?us-ascii?q?BoCGx4NJyMCLEIDEQUQAhYDJBYENBEJCygDLAY4AhIMBgYJXSYHDwkEJQMIB?=
 =?us-ascii?q?AMrKQMjdBEDBAoDFAcLB3cDGSsdQAIBC209NQkLG0MClhkRQg4RPj6BIIEtH?=
 =?us-ascii?q?pMEgzQBj3SfJgeCNIFgoRgGDwQvlzSSWod1kFggolMvBIUXAgQCBAUCDgEBB?=
 =?us-ascii?q?oFqAzKBWTM+gzZPAxkPjiA4dAECgkmPekIzAjkCBwEKAQEDCYI5iC4BAQ?=
IronPort-PHdr: A9a23:dJEH3hThwp4nXRCXIB8SPv2wyNpsovKeAWYlg6HP9ppQJ/3wt523J
 lfWoO5thQWUA9aT4Kdehu7fo63sHnYN5Z+RvXxRFf4EW0oLk8wLmQwnDsOfT0r9Kf/hdSshG
 8peElRi+iLzKh1OFcLzbEHVuCf34yQbBxP/MgR4PKHyHIvThN6wzOe859jYZAAb4Vj1YeZcN
 hKz/ynYqsREupZoKKs61knsr2BTcutbgEJEd3mUmQrx4Nv1wI97/nZ1mtcMsvBNS777eKJqf
 fl9N3ELI2s17cvkuFz4QA2D62E1fk4WnxFLUG2npBv6C6bDnjvfhsF3/wnKF5Tfd5EXBDCNy
 uBERU7k2AgmbTgm2XP8qJ1O0YQFvR309Hkdi4SBQ4ixDt5QerrEb48bbGgZBeMWDXRkX6KAP
 qw0L9QLZ7t28ojggmQCo0G8Pw3xNcnNwB9VuVnz46sj4e44TASc3xYwRMpNni7whfr2NuBNc
 tzl4q+Z/BHPQc9PyQ3C59ORS0EFodGBeq1MS5Dj8WUIJi/bsgqWg43mAh2FzbQh7lXCw8FwD
 N+Fj0gHthNjixyol9Y01bXl1qwF7w7qrnQg5dg0GfucR0BxTYaJRcgYp2SbLYxwWsQ4XyRyt
 T0nzqFToZegZ3tiIPUPwhfeb7mCb4Gry0i9EuiLKCp+hHVrdaj5ixvhuUSjy+ipTsCvyx4Kt
 StKlNDQq2oAnwLe8MmJS/Zxvw+h1D+D2hqV67RsL1o9iKzbLJAs2Pg3kJ8Sul7EBSj4hAP9i
 6r+Sw==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:g6kUcq27OIIz3tCNmaC6nwqjBL4kLtp133Aq2lEZdPUzSL38qy
 nOpoV46faaslsssR0b9exoW5PwIk80l6QV3WB5B97LN2PbUQ2TQ72KhrGD/9SPIUPD3/RTka
 N7fex/BbTLfDxHsfo=
X-Talos-CUID: 9a23:NMwcHG1FXeuo1o8AA9J3kLxfJ9Iia0L/l1npPFaeFFlORp+We2TNwfYx
X-Talos-MUID: 9a23:Xhf5vQZwR/V4b+BTjWbOhQtyd8BUuoeTIxsmt7g0tsvVKnkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,341,1695679200"; 
   d="scan'208";a="76086392"
Received: from 153-97-179-127.vm.c.fraunhofer.de (HELO smtp.exch.fraunhofer.de) ([153.97.179.127])
  by mail-mtaKA26.fraunhofer.de with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 14:45:04 +0100
Received: from XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) by
 XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 8 Jan 2024 14:45:03 +0100
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (104.47.11.169)
 by XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28 via Frontend Transport; Mon, 8 Jan 2024 14:45:03 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VMWW4vIN/3vXL30sqWENgzpzvd1P2HM51NqRlximUZAMcCQHBNrBwgPaveibQB0cihAcwQkeENPhWavB0CXC5LOJ2MbyZ7HrPyC7wBVKMsRuSvqL5eccztFpJohfutKfhhu14QGv9mE3rkhPP361EvRuefSpZEFhBXZq+p/RLqkfjGfkLebEzybjNCR18+elpjVEbPEb3oXF3vBeD5o4RmS6ngUiselTFsgcGc3XOiK6pjPLHnALS9gSe8AqmaGBMzdj+sKkMakhQJ/Gsp3FDEH2X/9hoYybz62s+NgSOzGYV259JNHA92b4MooTMdJbVQkbvXgvU8+lpctclSar8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YZDxMXCbOH8B1ARIK5lGM/Ge9d8GI2nwAzCJ9V5N6ug=;
 b=i2FWBAh83elHCOZASJKKVkhdDNvqqq2g2KGIJGL2INJJmMNSd9fzJyVHfyAO5XZpuRwho35p/lpJoIh0vpmLS277x2HfhzU3yCo52xbl/d+p+iq5OrVdBx+1LVSxk80LOHrxrZxQ97P3IxL9naDqqqux1UC/8PGn2JQHvYWgiHum18/L//qvQOtYev0aYZLpukJt9mbE4rj8cZIIBlQ0D4/i31/miKPa/Z0H3IUGfRMq9Rgt3wDGKS7EUoUxBQfvpQ49blDTPA40mP2W0mGytZEtpP2rSPff0KxgvsGDbY7qLRwMy1f/hmZwhDftN6RNGggMbN2ezjFE9htqfOPzMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aisec.fraunhofer.de; dmarc=pass action=none
 header.from=aisec.fraunhofer.de; dkim=pass header.d=aisec.fraunhofer.de;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fraunhofer.onmicrosoft.com; s=selector2-fraunhofer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YZDxMXCbOH8B1ARIK5lGM/Ge9d8GI2nwAzCJ9V5N6ug=;
 b=KaLRLFlqqz4iAj03M/20M5IT9OSHVb25F5iuMWdf2jRl5YBJbHuWNmVnqZbq5m2krx3p+F2LAGkj/7KT8Fn9YLdFTqxRWg31Q9LhHeOwTR2ZPDOYDvT7nBikUFxs8D5U1DCx1UBlNHuzzALo9yp7TD8FxM6F391M6iTNLgfbD0E=
Received: from BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:50::14)
 by BE1P281MB1681.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:1d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Mon, 8 Jan
 2024 13:45:03 +0000
Received: from BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
 ([fe80::d273:9b9b:dadf:e573]) by BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
 ([fe80::d273:9b9b:dadf:e573%3]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 13:45:02 +0000
Message-ID: <6c2eb494-0cbf-4493-ae31-6dea519c4715@aisec.fraunhofer.de>
Date: Mon, 8 Jan 2024 14:44:59 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 3/3] devguard: added device guard for mknod in
 non-initial userns
Content-Language: en-US
To: Paul Moore <paul@paul-moore.com>, Christian Brauner <brauner@kernel.org>
CC: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Alexander Mikhalitsyn
	<alexander@mihalicyn.com>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
	<yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh
	<kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
	<haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Quentin Monnet
	<quentin@isovalent.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Miklos
 Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, "Serge E.
 Hallyn" <serge@hallyn.com>, bpf <bpf@vger.kernel.org>, LKML
	<linux-kernel@vger.kernel.org>, Linux-Fsdevel
	<linux-fsdevel@vger.kernel.org>, LSM List
	<linux-security-module@vger.kernel.org>, <gyroidos@aisec.fraunhofer.de>
References: <20231213143813.6818-1-michael.weiss@aisec.fraunhofer.de>
 <20231213143813.6818-4-michael.weiss@aisec.fraunhofer.de>
 <20231215-golfanlage-beirren-f304f9dafaca@brauner>
 <61b39199-022d-4fd8-a7bf-158ee37b3c08@aisec.fraunhofer.de>
 <20231215-kubikmeter-aufsagen-62bf8d4e3d75@brauner>
 <CAADnVQKeUmV88OfQOfiX04HjKbXq7Wfcv+N3O=5kdL4vic6qrw@mail.gmail.com>
 <20231216-vorrecht-anrief-b096fa50b3f7@brauner>
 <CAADnVQK7MDUZTUxcqCH=unrrGExCjaagfJFqFPhVSLUisJVk_Q@mail.gmail.com>
 <20231218-chipsatz-abfangen-d62626dfb9e2@brauner>
 <CAHC9VhSZDMWJ_kh+RaB6dsPLQjkrjDY4bVkqsFDG3JtjinT_bQ@mail.gmail.com>
 <f38ceaaf-916a-4e44-9312-344ed1b4c9c4@aisec.fraunhofer.de>
 <CAHC9VhT3dbFc4DWc8WFRavWY1M+_+DzPbHuQ=PumROsx0rY2vA@mail.gmail.com>
From: =?UTF-8?Q?Michael_Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>
In-Reply-To: <CAHC9VhT3dbFc4DWc8WFRavWY1M+_+DzPbHuQ=PumROsx0rY2vA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0135.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::19) To BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:50::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BEZP281MB2791:EE_|BE1P281MB1681:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b870768-6803-46e3-dbc7-08dc105003b4
X-LD-Processed: f930300c-c97d-4019-be03-add650a171c4,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s69wXzqoLh0qGpWXkGPWyKVsfouAPzw+oIz4l1BwBh+1ODgzvChKwqXoiwXgbLOE3BvLQCm4cfnVYzEwREgFFlFWlXF7yTVY3aEu4vJDQ75PYWwtxty0hNipc49wEml/frqLA1hvI9Snsz+7Le6/pHDlu7dyNCbas8Yuw2Pix4XKAHr2tCCSDxF8It/zqywoyjC6kTBAi5VnsDFi5BsBmkh/Mt9fN3FshoCpdakoNjdb0Sv6tMxURZNxxrqzU3OMHPhmVtI7qTS3bv0tqurOVUXv+ckXRDftWmXVK2pHPdEPUeUp9qGj9j/YPRKgSKepW+SHtbiZcep1hEF+YFNxwhFak8SrdUax5OImt5dgYFn/63WfjArz3CC7gur35ZW/Ynka8iEOpieUYdvHtkRFdC5xk0YwqeFqP4IGUP9H4kCBLZr10cuixv9tfo3cwk306AutxZ8D95ovqe1R66n35QmB6T2SV9cZmg25iES8qMhKzZrIV7Eqk+fRRxIT9cwsqGmZjCd5E7KVLCflyGZ0ujUNN7beL6uOjzIGUVlyMnhdbII5tEoO3nChfwgxAdQWzX465HIbO9coPeI109wCnZcLx8LT6XnG49ruy8LcapEouw0Vcl/aensAdL6ay6gjjbKM/d76l1InKqIOh9eMW6ZZaZ38nhhgqoroksXgenRGeFpEYNat/AywjZwAdH5yxh0igxniAgLgakwQ7bcWcQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(366004)(396003)(136003)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(2906002)(41300700001)(86362001)(31696002)(38100700002)(82960400001)(54906003)(316002)(110136005)(6512007)(66476007)(66556008)(53546011)(8936002)(8676002)(6666004)(6486002)(478600001)(7416002)(6506007)(5660300002)(83380400001)(4326008)(66946007)(107886003)(2616005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXpIUTZkc21nSEk4ZlpTTDlldXhJVEZLOVJPelJ0b3lpSDNrQmg3djk0MFBK?=
 =?utf-8?B?Y3NJNlRlS090eWZPdVZsZDFMT0dtaDBtTWE5ZEx2MlNxRjdPaEYvTk04MlFM?=
 =?utf-8?B?alNtZVR0VmJGRkcwYjE2MXJkNkZ4SU15NHlVNTdnVURwbEtxSTBFemIxazFZ?=
 =?utf-8?B?aDE5V2ZpcTdZZ0lKR1JWcDVRSkJyTC9wMS8rK2tuKzhnazFNdkxmbjljWDhu?=
 =?utf-8?B?TzF1NHY2bldwYmFRNmNaM2h6em5CMmJBZUE0MUNuVldEdWNWSUN0Um01c3Zx?=
 =?utf-8?B?QkRUVmMxY3JCNGRkdGtCYjZ6UkZvRUF5Z0VDSzlmQ3VaYkZrMUNzUGVMVXJE?=
 =?utf-8?B?S2NPNythNEt5V0RmWjBYVjNCdkpaaHljS3hNYUg0dUFOSzBjbEdjYlNINklR?=
 =?utf-8?B?aFVjSnM4QW1CZ0FycUtvMjVHMTJseUpVczh2ZlJYWnhaSFdVV1puUFlwZ080?=
 =?utf-8?B?dk9MOW5ZOXpjK3hybmx0Z0VKWnh6RTU2NkpIZTR6bW5zNHJKNlRjVHlWQ0hE?=
 =?utf-8?B?NmdvdnQzV2toeXY0QmdxbzZTWmFoT3ZyZ3RGemxjOGZYUGgrYnlNZWFwODJY?=
 =?utf-8?B?ZWJkcGI0RWRzMW1BeWt2WlVRVnBEcFU0M3hVRDFMK1N4WlVUMVZrWVFaNEgx?=
 =?utf-8?B?OGxFUTk5aWg2dG9aUmZuSEZLbzVaVjNva2V5Uk5DeklwdG1zVG1hOTM1eitx?=
 =?utf-8?B?ZkdCZlVrQWk3VlhsZUZkdnU0U3NsQkJFMWEvRFVDSlI1M21xekRBcDBoNXVz?=
 =?utf-8?B?SkdidjBCQklhalVWc2lLTEM3M3RRSHlrNEZjNHplSjlWZ2tBbDJtYiswWE43?=
 =?utf-8?B?NjZ4S0ZNRFlGZWk2dnFaazFyRlhnV2thMHV4UDgwNnhCMnNXVHlZaFdTNXcx?=
 =?utf-8?B?akh4Z1hkMUo3SXQ0QUlkMEtIOUUzM1R3eW9CcTVZUnJ6TDFUMDY4QU5mMzE4?=
 =?utf-8?B?VU9qUmhSaXN5SkdIalYyRDE4MWFKSlNBUmRBdm0xQUptQnhpNEE0Z2sySmg2?=
 =?utf-8?B?RWE5U2RJVlZ2cnNCNzdUK1cxYXF3bjdUc2lVRXNBUVZNUjhUeWpEMm84WDFO?=
 =?utf-8?B?TzBXZTBzTlZQMW11bkFzWWZJTm5DMHdJR0xTOGw5UFpqZU9uMmZmVlg5OHNR?=
 =?utf-8?B?bmRrQkp1Qm9MM2VUcHE5cVhSWmE5d2J3S2U3NEhMSlpKeWpWWW9tb2w4Rk9G?=
 =?utf-8?B?Y01kZEtORmdYM0tuRWYyYkFXVWpraTB3V3pLWHNnTjNpemVOUlpscDFNajVP?=
 =?utf-8?B?Ti9RQlJrem8va2ZVSmh5QmpGcTFlQTBxMG1aTHljTVJ4bktXTDg1S1JMdm03?=
 =?utf-8?B?M0VBRXpRL2hzdFZBRkJKNGNBQWdoaGQ4WUdMSVZpQmFXMlBwTTlaSFJGV3Nu?=
 =?utf-8?B?aWUxRFlRanhYWFBzRm11VVZJM0NrZFEzVVNHbnFKSzlyK2Y3VDNXd2RnZW1W?=
 =?utf-8?B?U3JORHY2YzJUcFdEQnJDbXVPRTBtTFZhZUZ6VEJSM0RrRVRYQnZVekJDcTZX?=
 =?utf-8?B?VUJCUVZhR01WVlliT2pDWU52T3hYWGp4Mzd4SlNlNzVBM2hRZ0Y1bGNSTGlr?=
 =?utf-8?B?bzJIYmlvWWxVaXc5TXRyTGxjMFVtcVJTTkVlQTJaeDBFMThPT0NaV1VHOTVR?=
 =?utf-8?B?VkhUeTllNDJPZFZGWVR0WFplVDZUSjkwRHFiR1IrY2xra0liQTkyWGFIRWFV?=
 =?utf-8?B?cml6K1dCRVdmZEl0UnpEWm83U0kxaVRJSTA3cDVVc2YvSXBOdmFSaUthaGdi?=
 =?utf-8?B?U1NJTkFYWS9WQTdreHRObXBNcHVSdXNRamRBRG5qWWhiSkVoQXhBYUxZQ3g4?=
 =?utf-8?B?dzVid0tpK28wNWx0UHBZWjF1UkVkVncra0VRMVlaTEJPdmxIeEtjT1ZNQ2dw?=
 =?utf-8?B?NzFpdGhDbVFEZ3pUek1JVmdCTGg3UTNJY1pETHUyUTZvSXo4UUxnZWhQdWMz?=
 =?utf-8?B?dWs4OWE2aTlwdU5sQlhhSlFtNmlFdHd0aU1zeVRSVVo3Z3BRdkRlSi9EMkxY?=
 =?utf-8?B?ZUdFM0FyWmxiSGJTUmdwcndpUCtRYVZDbGgzRWdmc3JXWWZDUm9zWXozWllU?=
 =?utf-8?B?c0FGRUNNeFlZWlRmZ2luVGs1cCtyY1JUUjFIcFJZS3BSL1RScnIzUElaR3Qx?=
 =?utf-8?B?dXU3TFlXdjF5RUFLbHhaMWJBTkl6cFdxaDZhRm02ZzVpaHFxL0dXcXh4TkVQ?=
 =?utf-8?B?cDFKb1RnMXZLQ2xxYzNKcHRiUktDNlFNVjR1K0wreGE1ZzMxOGhYUUtvUkhR?=
 =?utf-8?Q?4rDbyRsSAnRzr2CC75OtBPl8lJiJkxXP/Guw5lhWbs=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b870768-6803-46e3-dbc7-08dc105003b4
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 13:45:02.7978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f930300c-c97d-4019-be03-add650a171c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6BF45VkwNRbE8zxfO1Qo9XdNUcmQ5aFJhTKaISac4V/u+4lAW7VAMP0BWKoBt+2CRUD2wIpHz8k4VpqWFTOYBLs1RhURHOpo3RgETq9MglS4VOmGlAahqjyls23oy/ey
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE1P281MB1681
X-OriginatorOrg: aisec.fraunhofer.de

On 29.12.23 23:31, Paul Moore wrote:
> On Wed, Dec 27, 2023 at 9:31 AM Michael Weiß
> <michael.weiss@aisec.fraunhofer.de> wrote:
>> Hi Paul, what would you think about if we do it as shown in the
>> patch below (untested)?
>>
>> I have adapted Christians patch slightly in a way that we do let
>> all LSMs agree on if device access management should be done or not.
>> Similar to the security_task_prctl() hook.
> 
> I think it's worth taking a minute to talk about this proposed change
> and the existing security_task_prctl() hook, as there is an important
> difference between the two which is the source of my concern.
> 
> If you look at the prctl() syscall implementation, right at the top of
> the function you see the LSM hook:
> 
>   SYSCALL_DEFINE(prctl, ...)
>   {
>     ...
> 
>     error = security_task_prctl(...);
>     if (error != -ENOSYS)
>       return error;
> 
>     error = 0;
> 
>     ....
>   }
> 
> While it is true that the LSM hook returns a "special" value, -ENOSYS,
> from a practical perspective this is not significantly different from
> the much more common zero value used to indicate no restriction from
> the LSM layer.  However, the more important thing to note is that the
> return value from security_task_prctl() does not influence any other
> access controls in the caller outside of those implemented inside the
> LSM; in fact the error code is reset to zero immediately after the LSM
> hook.
> 
> More on this below ...
> 
>> diff --git a/fs/super.c b/fs/super.c
>> index 076392396e72..6510168d51ce 100644
>> --- a/fs/super.c
>> +++ b/fs/super.c
>> @@ -325,7 +325,7 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
>>  {
>>         struct super_block *s = kzalloc(sizeof(struct super_block),  GFP_USER);
>>         static const struct super_operations default_op;
>> -       int i;
>> +       int i, err;
>>
>>         if (!s)
>>                 return NULL;
>> @@ -362,8 +362,16 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
>>         }
>>         s->s_bdi = &noop_backing_dev_info;
>>         s->s_flags = flags;
>> -       if (s->s_user_ns != &init_user_ns)
>> +
>> +       err = security_sb_device_access(s);
>> +       if (err < 0 && err != -EOPNOTSUPP)
>> +               goto fail;
>> +
>> +       if (err && s->s_user_ns != &init_user_ns)
>>                 s->s_iflags |= SB_I_NODEV;
>> +       else
>> +               s->s_iflags |= SB_I_MANAGED_DEVICES;
> 
> This is my concern, depending on what the LSM hook returns, the
> superblock's flags are set differently, affecting much more than just
> a LSM-based security mechanism.
> 
> LSMs should not be able to undermine, shortcut, or otherwise bypass
> access controls built into other parts of the kernel.  In other words,
> a LSM should only ever be able to deny an operation, it should not be
> able to permit an operation that otherwise would have been denied.

Hmm, OK. Then I can't see to come here any further as we would directly
or indirectly set the superblock flags based on if a security hook is
implemented or not, which I understand now is against LSM architecture.
Thanks Paul for clarification.

Christian, what do you think? 
Maybe we just set the SB_I_NODEV and SB_I_MANGED_DEVICES flag based on
a sysctl at the same place for backward compatibility,
drop the additional security hook and keep the rest as is from your
proposal:

	if (sysctl_managed_devices)
		s->s_iflags |= SB_I_MANAGED_DEVICES;
	else if (s->s_user_ns != &init_user_ns)
		s->s_iflags |= SB_I_NODEV;

A device access managing LSM can then just implement the current
security_sb_alloc() hook to deny creating the super block at all.

> 
>>         INIT_HLIST_NODE(&s->s_instances);
>>         INIT_HLIST_BL_HEAD(&s->s_roots);
>>         mutex_init(&s->s_sync_lock);
> 

