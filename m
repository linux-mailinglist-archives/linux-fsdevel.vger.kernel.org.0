Return-Path: <linux-fsdevel+bounces-6042-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA72812A23
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 09:17:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FCE81C2148A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 08:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A436D171C9;
	Thu, 14 Dec 2023 08:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aisec.fraunhofer.de header.i=@aisec.fraunhofer.de header.b="xfVEIhmL";
	dkim=pass (1024-bit key) header.d=fraunhofer.onmicrosoft.com header.i=@fraunhofer.onmicrosoft.com header.b="WgQLjUZh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-edgeka24.fraunhofer.de (mail-edgeka24.fraunhofer.de [IPv6:2a03:db80:4420:b000::25:24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D3A98;
	Thu, 14 Dec 2023 00:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=aisec.fraunhofer.de; i=@aisec.fraunhofer.de;
  q=dns/txt; s=emailbd1; t=1702541857; x=1734077857;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2TzibBNMVQWZGdWR1I69nuSRW/dTW1UOOt05xOW6sS8=;
  b=xfVEIhmLmWXTcgbUtE9DuKEE3T3SUwW9PW427+XP84sPRUz1r/dCKhYH
   cfZnvPnZsTfkRpdz7sPd8RnRKM0u4BB8SnrtFFQ5gMgz8jGKX+RUCI1FN
   1WKZkMO+R6Yvo1MvrhkT9nqIY/4ZD2Vb2tMI+0L6Hip6/NWKglhcbSN1M
   KzNJGjjm46pQFxUh5oB5/brDs3fEg4aP1BXAbxFJ3BG95NF6wCJ23ZbpA
   3Mm1y/v6u5O8R2Trn/6ZISD5wHSnaxf5YF320ed9kIBqTVkHDoZ4//+bI
   PXuvmfBv3I74pIfZiAJKow/Il3Q3nA/DavinE4Xu1XGVEKwcQNFr+yo/H
   w==;
X-CSE-ConnectionGUID: 8yORDYimTFOu54eblQIMbA==
X-CSE-MsgGUID: wBFREO/PRW2i/zzle4cE4w==
Authentication-Results: mail-edgeka24.fraunhofer.de; dkim=pass (signature verified) header.i=@fraunhofer.onmicrosoft.com
X-IPAS-Result: =?us-ascii?q?A2GDAwA9uXpl/x0BYJlaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?U+COYJZhFORNi0DmCWEBCqCUQNWDwEBAQEBAQEBAQcBAUQEAQEDBIR/AocxJ?=
 =?us-ascii?q?zgTAQIBAwEBAQEDAgMBAQEBAQEBAQYBAQYBAQEBAQEGBgKBGYUvOQ2DeYEeA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBHQI1UwEBAQECASMECwENAQE3AQQLCxgCAiYCAjIlBgENB?=
 =?us-ascii?q?QIBAYJ8gisDDiOuSXp/M4EBggkBAQawIxiBIYEfCQkBgRAug2eENAGFZoQ6g?=
 =?us-ascii?q?k+BPA6BBoFvPoRYg0aCaINmhTYHMoIhgygpg3aNaFsiBUFwGwMHA38PKwcEM?=
 =?us-ascii?q?BsHBgkUGBUjBlAEKCEJExJAgV+BUgp+Pw8OEYI+IgIHNjYZSIJaFQw0BEZ1E?=
 =?us-ascii?q?CoEFBeBEgRqGxIeNxESFw0DCHQdAjI8AwUDBDMKEg0LIQVWA0IGSQsDAhoFA?=
 =?us-ascii?q?wMEgTMFDR4CEBoGDCcDAxJJAhAUAzsDAwYDCjEDMFVEDFADaR8yCTwPDBsCG?=
 =?us-ascii?q?x4NJyMCLEIDEQUQAhYDJBYENhEJCygDLwY4AhMMBgYJXiYHDwkEJwMIBAMrK?=
 =?us-ascii?q?QMjexEDBAwDGQcKBAc6AxkrHUACAQttPTUGAwsbRAInpjYBATwtJSUdPW8OQ?=
 =?us-ascii?q?5ZMAa8MB4IzgV+hFQYPBC+XMZJXLodKkE0gqBICBAIEBQIOCIF6gX8zPoM2U?=
 =?us-ascii?q?hkPjiA4g0CPPAE9dQI5AgcBCgEBAwmCOYgpAQE?=
IronPort-PHdr: A9a23:bl398Rz/77KWjuHXCzKPy1BlVkEcU8jcIFtMudIu3qhVe+G4/524Y
 RKMrf44llLNVJXW57Vehu7fo63sCgliqZrUvmoLbZpMUBEIk4MRmQkhC9SCEkr1MLjhaClpV
 N8XT1Jh8nqnNlIPXcjkbkDUonq84CRXHRP6NAFvIf/yFJKXhMOyhIXQs52GTR9PgWiRaK9/f
 i6rpwfcvdVEpIZ5Ma8+x17ojiljfOJKyGV0YG6Chxuuw+aV0dtd/j5LuvUnpf4FdJ6/UrQzT
 bVeAzljCG0z6MDxnDXoTQaE5Sh5MC0ckk95PSzo7wihD5v6kyHLm+pC+XGZB5ztRLMraT+Iw
 bZqRz7mtQ08LScp+k/Q358V7upR9S2unjh9/rzUJ7rFOfR/ILHMV/IabDRBQdlIZzVPGYCYT
 K0GXtIbP+hln7OthRwztkPlCzONH+PMxTlDg1/P16YQ1PQxFy7l4go6Etkyr13YgMuuPphVT
 eaplpvYwAfpLLAJ32769K2WdApwoKvde5lpW+TgzwoIFDyUj1vN8oP1Ew2Xyrk2k2GUtfM9S
 s+OtFIesh1xhDHowZgJlsqKhKYH61zgzHRAwKAWfYjrAF4+YMSjFoNXrT3fLYZtX8c+Fnlho
 z1polVnkZuyfSxPxZgoyh3WMaDBfZKB/xTjU+icO3F0iSEtdLG+gkOq+FO7gq3nV8ay2UpXt
 CcNjNTWt34M2hCSosiKQ/dw5AGgjB6BzQnO7OFDL00u063dLp8q2LkrkZQP90/EG0fL
X-Talos-CUID: 9a23:MbWkCGHs43nMDOY/qmI35WkuNvEkd0Hz62qNf0KyDV9Ibbe8HAo=
X-Talos-MUID: 9a23:z/U4QAa5qg/MGuBTqBXCvhxFc/9S3P6vT1IflZhasOTYKnkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,274,1695679200"; 
   d="scan'208";a="5367391"
Received: from mail-mtaka29.fraunhofer.de ([153.96.1.29])
  by mail-edgeka24.fraunhofer.de with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 09:17:33 +0100
X-CSE-ConnectionGUID: LBPPLmh/QiG9xCsQHUyFuA==
X-CSE-MsgGUID: gtCCguTuQ3qCMUVE0mNwmg==
IronPort-SDR: 657aba1b_M8XkSO/kr84WEcS8ZOpLP8Lxngi/jkushjhHVn5qsGC1IGl
 3uUOLkhqzMLsGdKMxcK4YDg/uYGK5cxQtpvrFuA==
X-IPAS-Result: =?us-ascii?q?A0AlBQA9uXpl/3+zYZlaHAEBAQEBAQcBARIBAQQEAQFAC?=
 =?us-ascii?q?RyBKoFnUgc+gQ+BBYRSg00BAYUthkUBgiEDOAGXbIQuglEDVg8BAwEBAQEBB?=
 =?us-ascii?q?wEBRAQBAYUGAocuAic4EwECAQECAQEBAQMCAwEBAQEBAQEBBgEBBQEBAQIBA?=
 =?us-ascii?q?QYEgQoThWgNhkUBAQEBAgESEQQLAQ0BARQjAQQLCxgCAiYCAjIHHgYBDQUCA?=
 =?us-ascii?q?QEegl6CKwMOIwIBAaJaAYFAAoooen8zgQGCCQEBBgQEsBsYgSGBHwkJAYEQL?=
 =?us-ascii?q?oNnhDQBhWaEOoJPgTwOgQaBbz6IHoJog2aFNgcygiGDKCmDdo1oWyIFQXAbA?=
 =?us-ascii?q?wcDfw8rBwQwGwcGCRQYFSMGUAQoIQkTEkCBX4FSCn4/Dw4Rgj4iAgc2NhlIg?=
 =?us-ascii?q?loVDDQERnUQKgQUF4ESBGobEh43ERIXDQMIdB0CMjwDBQMEMwoSDQshBVYDQ?=
 =?us-ascii?q?gZJCwMCGgUDAwSBMwUNHgIQGgYMJwMDEkkCEBQDOwMDBgMKMQMwVUQMUANpH?=
 =?us-ascii?q?xYcCTwPDBsCGx4NJyMCLEIDEQUQAhYDJBYENhEJCygDLwY4AhMMBgYJXiYHD?=
 =?us-ascii?q?wkEJwMIBAMrKQMjexEDBAwDGQcKBAc6AxkrHUACAQttPTUGAwsbRAInpjYBA?=
 =?us-ascii?q?TwtJSUdPW8OQ5ZMAa8MB4IzgV+hFQYPBC+XMZJXLodKkE0gqBICBAIEBQIOA?=
 =?us-ascii?q?QEGgXolgVkzPoM2TwMZD44gOINAjzwBPUIzAjkCBwEKAQEDCYI5iCgBAQ?=
IronPort-PHdr: A9a23:LLa89h3nIplS9YObsmDO5gUyDhhOgF2JFhBAs8lvgudUaa3m5JTrZ
 hGBtr1m2UXEWYzL5v4DkefSurDtVT9lg96N5X4YeYFKVxgLhN9QmAolAcWfDlb8IuKsZCs/T
 4xZAURo+3ywLU9PQoPwfVTPpH214zMIXxL5MAt+POPuHYDOys+w0rPXmdXTNitSgz/vTbpuI
 UeNsA/Tu8IK065vMb04xRaMg1caUONQ2W5uORevjg7xtOKR2bMmzSlKoPMm8ZxwFIDBOokoR
 rxRCjsrdls44sHmrzDvZguC7XhPNwdemBodMjbhwRLjBcb9uQrwh8d95wjCPvenVrk3RgSpx
 Yl6SRDJhhotDCQg4Gv5jZkj6cATqkeeqCVbwbPmYMauZPdwf/3PbPk7RUMfXtlOThxYDJi/S
 6gpBrs5J+RWkrnH93lJkADmXgeWJfjv6TBOjXrW5Kcx+eMxAQfp/zImBd8FjGv9oPnrb60tF
 vyz0PP63TjxRbAVhjGk75TtLBY78PDWDJRbaOD/+E9sMAD631Se9NfqLx+r1PhQiEiS4LB5C
 P2CqlEbkhhtoh6mgcBzr5WKxYAx2HHI0Rwo+YYTBoXtGwZrJN++F51IsDuGcpF7Wd4mXzRws
 T0hmdXu2La+dSkOjZE7zj32Ma3BfZKB/xTjU+icO3F0iSEtdLG+gkOq+FO7gq3nV8ay2UpXt
 CcNjNTWt34M2hCSosiKQ/dw5AGgjB6BzQnO7OFDL00u063dLp8q2LkrkZQP90/EG0fL
IronPort-Data: A9a23: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
 NvIgJ19f3XN3Nc8mQRDiw==
IronPort-HdrOrdr: A9a23:/yjOmKzSKtNmq6Ar1M6jKrPwJL1zdoMgy1knxilNoH1uH/Bw8v
 rE9sjzuiWE6wr5J0tQ/OxoVJPufZq+z+8W3WByB9eftWDd0QOVxepZjLcKrQePJ8VlntQw6U
 5oSdkbNOHN
X-Talos-CUID: 9a23:SAD8DG9bXotisDQaLvWVv2o+IvgBd32a9Xb/cl+TEl9Jday7VHbFrQ==
X-Talos-MUID: 9a23:WYS0nAoYyRqm4NVkmMoezz5+H+xn/pizMRsUurA7heTcMApvPjjI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,274,1695679200"; 
   d="scan'208";a="885786"
Received: from 153-97-179-127.vm.c.fraunhofer.de (HELO smtp.exch.fraunhofer.de) ([153.97.179.127])
  by mail-mtaKA29.fraunhofer.de with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 09:17:30 +0100
Received: from XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) by
 XCH-HYBRID-03.ads.fraunhofer.de (10.225.9.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 14 Dec 2023 09:17:30 +0100
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (104.47.11.169)
 by XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28 via Frontend Transport; Thu, 14 Dec 2023 09:17:30 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d2L54OBpo6ODku6UM5lawVQsB0IY/iPVA0szrs83UGigyk5hFA1v4je8aBziRiN9WEZuZgfTGRA2JcEuz+9yP9AMAl3cJVzoxzfpenXV4SlefTdry6+YqnUT4MlbuQ9AInm/ABlZvgn0Y1jjCOpZWg7UfCft2KNBUvhlbMGcwxgqo66Ty3bjh7fuybCA8XUH+BP0EKbPc4sY87iVa+Y+tIcmE63v+2hJZYVSc5B2CWzj49QBHjF68KKx3KDhha/kZpTm5DxOtC2k213ebCb9L8iI7Ec/GpJ1s7FdB1ACzzapUWCc3fl44TWu9ttX7j3v82cu9U/LCxYcvFLc2xZEEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YVLEkq39dcIbYEhWI0kR9sakwXcBFyigIfUBSrqxbFo=;
 b=BXNb/u+p6ydfdwEsEo46AsmgATTkKP3Nz+ZNwhnuBpc929DNwtgDf6Tb+1Pf/ERG2vhIARJrjNOQrNCKhIQsOXV01duw2ESlUVe4qVYlhxVjsBG+/m2xZmRtxjvtioR9ZcS3ewwtUD5MBAzlCME523WSU8vE5u/R6kjNpO63TxNZJ4bzRAYpRl+AXrQsAFZN35X903odAW/4KSjgwaAjMd4GVn3oTgPWijExRLiziWgOc9fqcBBtpjpfEBFX30caDlaizf74UHX8UGlsrF0noHewEiXMMfxctl1KB7YeqehPXCQF+h/wQts9fXP5EMmYPRfxNSCTQAYDKP7AfPYAKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aisec.fraunhofer.de; dmarc=pass action=none
 header.from=aisec.fraunhofer.de; dkim=pass header.d=aisec.fraunhofer.de;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fraunhofer.onmicrosoft.com; s=selector2-fraunhofer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YVLEkq39dcIbYEhWI0kR9sakwXcBFyigIfUBSrqxbFo=;
 b=WgQLjUZh/S8efi6zyBIhA6hwwqXqfskLKNa9PrjfUXR8J/Us03fRIshKgncmHQbcBoxxnGKVnrecTwAdDv3bW/tnt2ZxeZB++7n1otM6nr9i29NCqBFYn+OkW9if53gxDVjt5SHag2q5wEIWTQqthNa/o7Mt++jLzIdLQ9QhNK0=
Received: from BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:50::14)
 by FR6P281MB3791.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:bc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 08:17:29 +0000
Received: from BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
 ([fe80::d273:9b9b:dadf:e573]) by BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
 ([fe80::d273:9b9b:dadf:e573%3]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 08:17:29 +0000
Message-ID: <3e085cef-e74d-417b-ab9b-b8795fa5e5c3@aisec.fraunhofer.de>
Date: Thu, 14 Dec 2023 09:17:08 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 1/3] bpf: cgroup: Introduce helper
 cgroup_bpf_current_enabled()
To: Yonghong Song <yonghong.song@linux.dev>, Christian Brauner
	<brauner@kernel.org>, Alexander Mikhalitsyn <alexander@mihalicyn.com>, Alexei
 Starovoitov <ast@kernel.org>, Paul Moore <paul@paul-moore.com>
CC: Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
	<andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu
	<song@kernel.org>, Yonghong Song <yhs@fb.com>, John Fastabend
	<john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav Fomichev
	<sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Quentin Monnet <quentin@isovalent.com>, Alexander Viro
	<viro@zeniv.linux.org.uk>, Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein
	<amir73il@gmail.com>, "Serge E. Hallyn" <serge@hallyn.com>,
	<bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
	<gyroidos@aisec.fraunhofer.de>, Alexander Mikhalitsyn
	<aleksandr.mikhalitsyn@canonical.com>
References: <20231213143813.6818-1-michael.weiss@aisec.fraunhofer.de>
 <20231213143813.6818-2-michael.weiss@aisec.fraunhofer.de>
 <6960ef41-fe22-4297-adc7-c85264288b6d@linux.dev>
Content-Language: en-US
From: =?UTF-8?Q?Michael_Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>
In-Reply-To: <6960ef41-fe22-4297-adc7-c85264288b6d@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0266.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::11) To BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:50::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BEZP281MB2791:EE_|FR6P281MB3791:EE_
X-MS-Office365-Filtering-Correlation-Id: 891c47af-c38f-4229-bb26-08dbfc7d1d2b
X-LD-Processed: f930300c-c97d-4019-be03-add650a171c4,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KMjhVp0TXSxGGtEMHzXfgo02xLkZFLsAmoseEtBaJ90bQxzM+iummudYTjJeawKDTQY8bZIDpsARqZR+cyh8LbDERuqvkCXE/Yyq/soa9EvtMNJo7QHVUJ08s1P65EFMFCJnTJxdVCj72lVo7JmPeUNWwWdW1zBy9XCUkakoOqF0dMMRsHbrBUBwmDsjvPRx7Sjrjn3iNjYmU4WM8Dmp3WOXyehbcrs0BwWp3GKk2q1zx1a8xuZaFpYJ0HbaTemqSdmSfjUc2w7TNSG+2svnLJiEquOh0DZbYHkadTHH9EpbyepzL0oZvnh0zFNMPgNH8T+PqgOqhvxs0QL0LE3zm+Svz+rIX+tZExRxV/VRJK0SC/sE1JUKxltIsfYISH6Ti3NA14fg9jTjx5XzrnbJIa0y/jvTkERaPSt+F715dpbVvBWGCvHAY/dyLz5kjTYrMC1WKNkVRThu2kClkWuqBNKHfmxxEt21zNcJKCMLSpk5C8ZVIgRhs+gqZIMWQspFhNPdGhuHJpXSN9J6VG3tI6P9fFOfTchGx4/2wNvw3l4npEzvNRBs3S6KIvikgwxRntjNJB2sN4GKvijdyUwsE5p3BIRXD+GM3q84mA4jINn6r4QxuQO8t4rQeqB6tfdogAoVW3MW4EWOsqUP2g8pO3QUgXY8YbUPzRELkcENtoKcMdtNMkbwxxKz+Kz0fNS59vH84GkvEFuj+ws38s66VA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(39860400002)(396003)(366004)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(41300700001)(7416002)(5660300002)(2906002)(8676002)(4326008)(8936002)(2616005)(83380400001)(53546011)(6512007)(6666004)(6506007)(86362001)(31686004)(31696002)(82960400001)(38100700002)(66946007)(110136005)(6486002)(478600001)(54906003)(316002)(66556008)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?clRWQ3dsOXlzZFF2dnNyTC9ZOGNlVm4xZVlyZWh3cmVWMm5FTWF6NU1NUjVh?=
 =?utf-8?B?bW95eURKWmpGbE55RGYxRzhIK0hQUmp0TzF5QmdBVjU3dm1zRjJ6anI2MGJu?=
 =?utf-8?B?aVZPQy9yMmlaYzBUNFZPVTdVc3EyakxZUFY3MTlMUjh0dFBVSy9CYlRtSXRI?=
 =?utf-8?B?cFk1V2RXOTg0Nms2eVZYRFFJeEZpTnlCOVR0aGJ1cTdEdkVoeVNrbnhET0kr?=
 =?utf-8?B?c0VOcmk4VkNDR1JCalZoc0llakQyK1p1dlJFYmcrMllsVXlBaWVNTGwveVNv?=
 =?utf-8?B?T3I1aTk1NVIrTWg3RE1kdFNMeWdZbmVUL200WFZWS2Zab254d2VPZUpObi9P?=
 =?utf-8?B?OWJQdlhiZUoxUkEvcHM2ZkJCSi8zbm8rREFLUWpWc2JoYVRGeTRNWU02a281?=
 =?utf-8?B?U2NTazdOd0ZnNnBmczNLZC9mOGlYNWprbEpmYTNUbEx1UW1lMm1tcU1GMGZn?=
 =?utf-8?B?N05oMktGNEdBUUN6aWtuVDlWajlHOXo3bzVBYmNsMEZwRzQyRmxqNWJSYnZU?=
 =?utf-8?B?THdLZU1idmcrSHB5WFFoQ2lUcit6NDZzTDMvR3N6cEI3UUtuZzV6TTJWKzQx?=
 =?utf-8?B?Qi9yNnZxSFgwQ0dtQWRJaVFrVjhsNURLdlhtejIzVU9wajZGeCttVUZ4cHR2?=
 =?utf-8?B?NFU5eGVIZ2Z4cnFkRWRsZW4rOWJhSXg5eFNlN2cyNUlhdFcwODdKZlFRcGJJ?=
 =?utf-8?B?NU9KTVZTaHFEa1ZPYW4zVlhzTk9RWUozY1JaT3EvR0lib1hXd280a0ViVndI?=
 =?utf-8?B?U0lwbTV4MnkvS2owbm1UdkJlMUwrQUFWalV6d3lZQTRtaDFxVllJd3kvYjN2?=
 =?utf-8?B?NmsrWm1ycXRISE9RNDNER2p4VmhkYldsN2plZ0tpUElURmhzRmMzZCtNUzNM?=
 =?utf-8?B?dlBHK29hZVB5UGQ0aUZDUFh5NGFxaXhkRlF1NnhhNUpSdjAzNis0WlkvbVE2?=
 =?utf-8?B?eWRPK21XOEY1TFd5bFdwTmZkejBnTS8zV3hVdDNFa1Q0L3h5aTZTa0NuRFk5?=
 =?utf-8?B?M2JEb0VqUk9saVFJZXc2d2NWVk05TnRKcks2enFDbzVyaEZNOTMzU2wzUE0v?=
 =?utf-8?B?d2tjZGdQaTZ1aXdhQWt0Z3phUzJNOFcyMExVakx6S2lvbWk0S0JGUGVsOWRV?=
 =?utf-8?B?VGZOU2p1czROV1djRllWSnZKQnpPVXhwZVlMYWNKdm9YcDR5RUI2cm9mVlhF?=
 =?utf-8?B?eXZKMXZ2R2F4RUg3WEdybVFaM1B3SGhUcktMWjBIMUhmNkFwTFJiMWVnWW1h?=
 =?utf-8?B?R0s1WGJlYmlIK2RKajBvSGc4RXFjamNaOGtDclpLWW9UVzEyeWR3NlVTa1Ex?=
 =?utf-8?B?blA4RXRNUUsva2lhMjk4TUtKT1Faa0Iyd1grbnJwb2kvYlZyWnY1NEhCTEVz?=
 =?utf-8?B?a1FYWjZJNFd3dVlSejZMRGlOWHBVSnovTHl2YVJlOFRGUWlONGZ3L3F3YnJC?=
 =?utf-8?B?bmxrNWQ1VUV6RWlwcURJUkwvQ0o4QkhNNWkrVFdzMS9IbHlHVXNOSWk1c01V?=
 =?utf-8?B?THU0VjVZSGhqeVFJeEhhZHphL3FrRHdXb3B6K1dXYitvTXZaekFMQi9lU3NC?=
 =?utf-8?B?SjdnMjdZY1pLd1Z0STN5dU93SGNMV3VYVnQ1eUUxeFpGNTBwR0lTa3kxTmYx?=
 =?utf-8?B?elVySVhZdkVkMi9TVDBqUExJcE5GVjB1cW96cE5Xd2c4c0wyRFlGMm5pSU9L?=
 =?utf-8?B?Qnc0YmRaV0F3VDZNMEpwZzVtRjVlMlBQeUE5RkZVMDBiQWtrQnVXcjhTQm51?=
 =?utf-8?B?TGo1MHM5QitjSzJWZ3Q2WFZmSkdHNE5iMEdnN3Nodm5PeDc3V0s3RmVISW14?=
 =?utf-8?B?Z3RrdGV3a0dzbS9YRUFId010b2V3UXRoLzNzeGhBNldscjEvY1RIMDRFV3Vz?=
 =?utf-8?B?SWdlOTJzbDFKUGlTT0x2aC9OTVdPb01jdWpISmUxOHNXeW03RHluaWU2YkN4?=
 =?utf-8?B?T3RBUm1pOFBxR3owb2ZwMFduL3VpWjRieDR2cEpnYXpkNXF1L0preHVZL2pQ?=
 =?utf-8?B?M0FTaFF4MzdxTy8zTGRtQ1Z1dm14ZmhabjRmbmFVbVJQNTRKc1l2NUtvcTM1?=
 =?utf-8?B?Nkd2UnVyMmVZbWVxbDZOQ3BJeVRDZW5MSjA1bGhxRVU5UzRNa1FHVG9FVmxD?=
 =?utf-8?B?RW5TeU01MDhvakRKTmJiZVY1K2ZUZU41U1lpSnBlZDNoV1p5TWRCekpjNHpk?=
 =?utf-8?B?WHBvMkU4c3A5NUNJNHFJU2lpR3dOOUg4NTJRTW52L1NwQyt4LzdSMzZFY2E3?=
 =?utf-8?Q?+mf5DYYEK7nGJxbYv1gnMcO0CcfQALHEaPTjCzpZr8=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 891c47af-c38f-4229-bb26-08dbfc7d1d2b
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 08:17:29.5055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f930300c-c97d-4019-be03-add650a171c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mAhp9/D4On5aWOiXC4l/ybHkXidHy6yQIEhFQbUDbL2uomBcpZi+TQ1eGv7Oi1SmPika4HamBhgN2cueSKUHveM9ELgwF6ljP9ublZGyEo6+JQyjA6qJHeonB1kPY4Em
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR6P281MB3791
X-OriginatorOrg: aisec.fraunhofer.de

On 13.12.23 17:59, Yonghong Song wrote:
> 
> On 12/13/23 6:38 AM, Michael Weiß wrote:
>> This helper can be used to check if a cgroup-bpf specific program is
>> active for the current task.
>>
>> Signed-off-by: Michael Weiß <michael.weiss@aisec.fraunhofer.de>
>> Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
>> ---
>>   include/linux/bpf-cgroup.h |  2 ++
>>   kernel/bpf/cgroup.c        | 14 ++++++++++++++
>>   2 files changed, 16 insertions(+)
>>
>> diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
>> index a789266feac3..7cb49bde09ff 100644
>> --- a/include/linux/bpf-cgroup.h
>> +++ b/include/linux/bpf-cgroup.h
>> @@ -191,6 +191,8 @@ static inline bool cgroup_bpf_sock_enabled(struct sock *sk,
>>   	return array != &bpf_empty_prog_array.hdr;
>>   }
>>   
>> +bool cgroup_bpf_current_enabled(enum cgroup_bpf_attach_type type);
>> +
>>   /* Wrappers for __cgroup_bpf_run_filter_skb() guarded by cgroup_bpf_enabled. */
>>   #define BPF_CGROUP_RUN_PROG_INET_INGRESS(sk, skb)			      \
>>   ({									      \
>> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
>> index 491d20038cbe..9007165abe8c 100644
>> --- a/kernel/bpf/cgroup.c
>> +++ b/kernel/bpf/cgroup.c
>> @@ -24,6 +24,20 @@
>>   DEFINE_STATIC_KEY_ARRAY_FALSE(cgroup_bpf_enabled_key, MAX_CGROUP_BPF_ATTACH_TYPE);
>>   EXPORT_SYMBOL(cgroup_bpf_enabled_key);
>>   
>> +bool cgroup_bpf_current_enabled(enum cgroup_bpf_attach_type type)
>> +{
>> +	struct cgroup *cgrp;
>> +	struct bpf_prog_array *array;
>> +
>> +	rcu_read_lock();
>> +	cgrp = task_dfl_cgroup(current);
>> +	rcu_read_unlock();
>> +
>> +	array = rcu_access_pointer(cgrp->bpf.effective[type]);
> 
> This seems wrong here. The cgrp could become invalid once leaving
> rcu critical section.

You are right, maybe we where to opportunistic here. We just wanted
to hold the lock as short as possible.

> 
>> +	return array != &bpf_empty_prog_array.hdr;
> 
> I guess you need include 'array' usage as well in the rcu cs.
> So overall should look like:
> 
> 	rcu_read_lock();
> 	cgrp = task_dfl_cgroup(current);
> 	array = rcu_access_pointer(cgrp->bpf.effective[type]);

Looks reasonable, but that we are in the cs now I would change this to
rcu_dereference() then.

> 	bpf_prog_exists = array != &bpf_empty_prog_array.hdr;
> 	rcu_read_unlock();
> 
> 	return bpf_prog_exists;
> 
>> +}
>> +EXPORT_SYMBOL(cgroup_bpf_current_enabled);
>> +
>>   /* __always_inline is necessary to prevent indirect call through run_prog
>>    * function pointer.
>>    */

