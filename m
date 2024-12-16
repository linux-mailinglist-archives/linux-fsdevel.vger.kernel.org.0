Return-Path: <linux-fsdevel+bounces-37566-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3419F3E06
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 00:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C98B16C0E2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 23:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D431DA612;
	Mon, 16 Dec 2024 23:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="n6k/DCDu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazolkn19011035.outbound.protection.outlook.com [52.103.33.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327231C2443;
	Mon, 16 Dec 2024 23:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.33.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734390513; cv=fail; b=Xv5mZ6+L3QcviRMI4BIr1RRvM+sZXT/POpKr49+HslJovbsZG7kz3PwxD02k/fgsUY8QPn/ZWyNB7Oq8pEhx6GyUHL+vsrhaGi8fXgESVaazI6SqicGIUG4yhIWGFvjJPJaM1gwEKRSpMrpYJmDrZGeEGM5FA7CF3pcYefPIC6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734390513; c=relaxed/simple;
	bh=gUljUfuYJoMtkcak/K9i0IDRqOYGOOK6x1RdlIk3wlU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DP+Z7oxnd1CLK2qn1L+z0sntUVGvwWs99imPqDkJ/cCJq3V5MF45bWD28QVsKCj4BZ1B2Mj5CkPsSXelQiHovVJct2f7IfMq4pep816CCDaZnvATLEiOZv/cUaA/KwX/3hiKa4YTs91aMFimoisbYpWjgL0bLBkSvGxPHI/COdc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=n6k/DCDu; arc=fail smtp.client-ip=52.103.33.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tpklRATjjQWb/wkjVlIyZNX4wssGV8nhH64sT094D9DYPVTdJHlgOcsP6dRKE8EBq6pY+DuLGR3rESN3+eeAO8ozdtuRcS6nMA9Lp+BadTpRXhtK4WUKyjS6UaGSU7XyHzzXzJLJI5hOeihT37xepnmSXbq5o4RV/nKXEYRq+wUPUZo7mAz/jahwIz5Lsm9Ud3302HTBV/6hSWXAhJ3E0Qp5olAgjUMw6l1ehCY8GxPMqiQVKQVwTxkRnzMjsrpACF0P0RzrTSVT1E5bXQieLCWM41QCtWL8zNrK6oqHS8justFmRuYwNd1R5g9tVWwQPDW4EqTiHHLdcpbs85ezZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZKBEWobjrW25j7k1fzHNlrcGVWXWBtyhPfxDaKQI/0k=;
 b=y4yjLKJT1iMrjXcclpBrwz+Bcykf5PP4Zfp62vdRdI2+9z/obpx6pwgJO2lOwrjMLr47zc6wCl4OCr4MU0iZp+abtHYwFpv8t0A9uedLXUzKmFYeRR42RYhhzq97c4KsxAE7agAA/aQ2v6eCIYnv8eQt8jFY2GTKFWlNP6/Z6Bj8mNZ45QwS6kBKspLIjhLLtheZFoibMj6ErUXX2gh2MeqmeRXWVX8AjEU+HiHYpsDUgP3yHERRMCeBgmAkvohZ1EZdCjTCBOMpW6W9KWUl5hwwsO7jJ49BN1BP3m2J0d1ZWYwBLpKtM+YWq5ENotM8eObb5RsaNLgvMxL6E4um9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZKBEWobjrW25j7k1fzHNlrcGVWXWBtyhPfxDaKQI/0k=;
 b=n6k/DCDuJ6e6ZYEbu7FM6gg0tHPeajoyPmItZnxQ/aeLgnNDxfQx2L0ESc42U4bWgSr8GrfXvAlcaZfgei6YSxgP1hpgfqbrziTHj51TH1R7tTGCjzRLAcKFDkprlBpMuzQpqe3sO6KiUF8Gl9lnBAT/yOKlVpPQz0WJAXpYPRIQOk5X0fo8mMMvkZDgZ0GvJ0zBfaTMx9yWZ5PnM/xJRVCWzdXgGLJYuH3TVeXXGCbI8zHLx7Ge4tYQ7f5sLolYs4VjC+8B4T4yOgz39w7ey4sSrAYYLpB6yXyksFgVnzmj2zfOjsULk2963kKMbMG+B9iirRhPv1h6IpgTlzq1MQ==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by VI0PR03MB10808.eurprd03.prod.outlook.com (2603:10a6:800:268::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 23:08:28 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%5]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 23:08:27 +0000
Message-ID:
 <AM6PR03MB50803643583825DB4387F62A993B2@AM6PR03MB5080.eurprd03.prod.outlook.com>
Date: Mon, 16 Dec 2024 23:08:26 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v5 4/5] bpf: Make fs kfuncs available for SYSCALL
 and TRACING program types
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, snorcht@gmail.com,
 bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux-Fsdevel <linux-fsdevel@vger.kernel.org>
References: <AM6PR03MB508010982C37DF735B1EAA0E993D2@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <AM6PR03MB50804FA149F08D34A095BA28993D2@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <20241210-eckig-april-9ffc098f193b@brauner>
 <CAADnVQKdBrX6pSJrgBY0SvFZQLpu+CMSshwD=21NdFaoAwW_eg@mail.gmail.com>
 <AM6PR03MB508072B5D29C8BD433AD186E993E2@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <CAADnVQK3toLsVLVYjGVXEuQGWUKF98OG9ogAQbJ4UeER42ZyGg@mail.gmail.com>
 <DB7PR03MB508153EF2FECDC66FC5325BF99382@DB7PR03MB5081.eurprd03.prod.outlook.com>
 <CAADnVQKyXV8jHv2_0Sj2TcmWXwUsv+2Mm00pdCveRmNbWF5mXA@mail.gmail.com>
Content-Language: en-US
From: Juntong Deng <juntong.deng@outlook.com>
In-Reply-To: <CAADnVQKyXV8jHv2_0Sj2TcmWXwUsv+2Mm00pdCveRmNbWF5mXA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO6P123CA0045.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2fe::14) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <786780b8-aa0c-48cc-ba52-e2d872996c95@outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|VI0PR03MB10808:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d994d8a-ec4b-41de-84e9-08dd1e268c30
X-MS-Exchange-SLBlob-MailProps:
	vuaKsetfIZkOVoj0UqpnLtxcZHTVbEDrNSmTVQn3CwFM9RnCVfN63VF6lj7whfftH+Q3IM1uHSz+298UlQsgfzVoeqAPhKYjg1n5OXs9V+fASt/QPMOgJup7b5r91rkw5XI8aM/uL2W3zuAna4z37fWeZEyzgpIV0hd2pDr+nNrCsXvxtNp7WhyNZBEJyT1xc6EPGlY7f7x8K4Ub51ZXQWDYOgvRdUxbGY21zsDz3U/PXkNLABVHTLT8CTDgCc2NJDzB1VR/otRpTEqkP3oaz/gY+iPyIZH/XRa+Z4zIaC4oeIrI9MoCenR88NkitXrgYgftaQolc5LzL/NW1fiEaFcfwOgA+is96XZ3REZalWFUBtmuEFP2Zhw1vAqLszvgdyNgDMgEZhIR0l68xpkSwe1ObKovCu0qBlKJb3e0cWU0ue8cslIj4zT42+G0qHuses8Yla6kLJ8h1q2IT1+/aqLedkD0GVTppb8EhEKwc3aPj2sKTuqGvqvgPFvoNuqolVYxglF83GjkmpDai3CrQ1RUe6EN5jL/wnUqAhawD36+1Z0U7GYR2NaYyV4CqCjcHfF8KEfTR/FfbqjSfN520niKxrm2Jp7hBAoRBOpj69yae7+07S82wuxNCsw9xKcL3lOgz2GhM1tF+F8izd89Uar4XexLYP11sDRV6x65ORSsl65sm4jVOYGYK3iY7Gc8JuEbMgx73p0RCoWFDvy2lgPBf36cpI5fdghzyjH0ZnQixxRi5Maicb306tRS02rsZgJhUoz5DtFHTplpgkHqwqr0uBayJmvwF3thGRDJyk6qcopQo94zqco6ZPQFAUMV
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6040799012|19110799003|6090799003|461199028|15080799006|8060799006|5072599009|1602099012|10035399004|4302099013|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a3hPTmxTbzMwSEJQRGhXNVRSM0VIeStsejJ0R0d6aE5adlZlVDd2SFJRVlJk?=
 =?utf-8?B?Szk1STc1MDZ1UUpkZk5RT28xbExJdjNZSG84RDR2SWhtVmM2SldQOVhRY05G?=
 =?utf-8?B?RTh3dWVVeWkvTEcxQXU3Y09vUFFjV3g5RWJLbFR5YVdVMFNxT2hIejNIZ3N6?=
 =?utf-8?B?K0tLOEt1RE5rcER3MVdhK3A3Mk85OHN4Sm1Xbko5RUN6NDhBZWlGM1R2V200?=
 =?utf-8?B?dC8rN1dCbnFTN3c2YWV3UWMzRm5JN1Rrd3JiSHRHWCtIYmlHRzh3ZFJmRUg2?=
 =?utf-8?B?S2wxaXJ5TExCcWQ5OEMwbDFLejNXcVFOQlNuR0o5Um14NmpKbENrdm1NaTB4?=
 =?utf-8?B?UGpJNlBTeTNYRExlTER1ZXNnRkJoeEtHUm9sTElUM0d0ZkUrZUtZT3VQZGhU?=
 =?utf-8?B?S1lIdHZnWktHZ3dKT3A2ZVJRTXljOVlHc25KWTI5SGFlNXJKRlg4dHNpWGhj?=
 =?utf-8?B?M2NUZjF6VkhtdHpJTC91Mm1iR0FQVVN5clhna3hQNEkrZTdBSTZWemZyWWFJ?=
 =?utf-8?B?dXR5NWZnUkpWWkoydE0zbkZrQTJadmQxVm44NGkzWVpiNGorL25oTnZ3UDla?=
 =?utf-8?B?Mlp5dlRQSHE4cFRzL2lQYnhhcEhPZzBGM0dyeCtrNHdRVHlZSitZNzJwZlZS?=
 =?utf-8?B?bHlQeStHK0poWjAxZ3krRVBuRWtGakFUK2hhcTMyNUwzcDBsOHkrcUhvUkl2?=
 =?utf-8?B?eXNHSk1yLzVWUHZ4ZkZSYkMrN2dBelp5c1BZUnNvbm5qZjNtRVVKbE9Kc1dC?=
 =?utf-8?B?aEEvZXBybW9oNFJQRnB3YWZnTGUvTU1NZHNkYUZQMzkwMGlNQTQ0bFQySzBN?=
 =?utf-8?B?YmQ0dFZUc01uTUk0MlE5amdKUWdNZjVWeVExREpYQzUyRFhDK1BSRGFSUGZT?=
 =?utf-8?B?RnFSQlpLS0ppdVZHVGtxeWVaOVFPa0dMT1Z6RzVwcVdSQktWMFhlNzl5NnRv?=
 =?utf-8?B?MnRpOTFRbWVhRi9vUTEzeHRLS1picDgwRlRESHJqSlZ5cGI2YS9OZE92MTdW?=
 =?utf-8?B?Q1I0Y3hwQ3F3bGVOVk1PeEh4RFJjY0srVUQzdHgvT3hkOU91eVFJV01oV294?=
 =?utf-8?B?ZUpWbllmVS9BdmpXaFF1N0EwVWt2Z1NWMWFESVp0ZGVOUG8vQ0NEbU5iYlYy?=
 =?utf-8?B?VkZjWEEwOVZRVUcwelI3cC9XSENKMXhNeDBtcVRCcWV3bllGN0svVHZ3dk5R?=
 =?utf-8?B?YmFuTXRnemp3ck1FNENkOEZBNkdWZ2ozR09Ea0xEQ2svWXdUWDlRMmFKdk1h?=
 =?utf-8?B?Yk9VSEFxMCsyQ2hVRHN2NFZkdUF5ajhGSWhFWTd6Yk1YQmV0Y3pLbVNyQ1BE?=
 =?utf-8?B?eXRwbktac2pNZHZlWGNlK1laRktIbDJsMmd2bU0xNm5BVVdTYVdBc3JPWk41?=
 =?utf-8?B?dnFOT1RCUnNBWjhTYXFoaHFFRGtyYmp1OW4zQVdHVDhrb2JxNjBvRjlmWlQv?=
 =?utf-8?B?dU1WcUJtVTNmeHl3b1FXWFFERDhEWVhUWXZGajF1OGU4UEVpOE5sZm1DU3dJ?=
 =?utf-8?B?aEpYOVNHa05EWmsyNGpjUHgxRGc5WFFJenZtTHJySmFCbG9vRzdoRFY0SHlr?=
 =?utf-8?Q?k7YsgFZx9JBgmyGjX/nMZKrgvIhoiNVXvH7cv/TGrrJrag?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Tmhlb1lTWXpPcllrK0hjUy9DUno3MUptOVNzUk1EZ1VkT1l2aWcwVERpMnVj?=
 =?utf-8?B?c3VLWmRWa25JSTRBM2VyOXFSYjdPeXdjVHViekxHbU9BNk53K3E0TStmK0ov?=
 =?utf-8?B?dTJmZ0FjZnZManozMjZBV204SU1jUENzaXNJVUhzYUt2N0U1bTgyN1ZhWXpX?=
 =?utf-8?B?K1VDMjJhc2p1MERrRnhqREJYejdrMG45RzZqeTVnYi9EZlhQV0E5M3VQNkk1?=
 =?utf-8?B?dVhSdUFmaEo2WHJjZ0xJVmhITWZCS2d0TnVjcU45Zmg5SGt6b1lqOUdhTjZC?=
 =?utf-8?B?b1RUUnZsOFRkeVoxSVVXRzFMNTdMRVZIOVdVN1FmWTVqZEUvcUptdHE2UkQv?=
 =?utf-8?B?aG5kSVZ2dzI4TGlHTEgyby9uTU1KdUt6ZVpZS200THJJY0pJMGJudDN1aWZv?=
 =?utf-8?B?QmR2bUJNUlNUeStRVlVEZVpUeFF6MXZTbFRmZFZNQ1FZQmJVZGFKTlU3cHJr?=
 =?utf-8?B?ZHRPenlNbk1lRWsyM2pkdmxyUXF0TE9TMW1jOFZBV3M1Ry9LU05Yb0VFSWUr?=
 =?utf-8?B?UmVZUWZ0WGZLa2Y4Zi9RNmlBTDVRTkJidzJjUVBwRTU4aFNhSVZtalNxcnE4?=
 =?utf-8?B?SlF6MUdpK3d3MlQyemUxMlVDNWpwckdCZFMrV0t0V2VQczRYU29FdmpGNjND?=
 =?utf-8?B?RDZ6Mm1pYlhzN1FNSmtqSklST0Y4UWdEOHVzOVkrZURaWms3cG00ckpOajNV?=
 =?utf-8?B?OS9YVXFMVTRoc1lxRE1JV3ZwYlppS1IwMW1nVmM0ZWIzSHZzbTgrUSttWXpE?=
 =?utf-8?B?ZWUwVURKS2Q5eFpyV0NIaVpHcHREVHlKSTNMcXd0MjU4alN3dHJmd2wvaHR0?=
 =?utf-8?B?N0NnYjJIWWhycWNUUm1Lc2htY2kveXJFVkErblNITzAxSmpZdHdOUEphWklP?=
 =?utf-8?B?cWNZOEF4MFA4TU5LVUZHa3ljYzF4Zm00UlBwRGwxb09vUUlwUGhPTklDS0RY?=
 =?utf-8?B?c1BLYy9uencrMnNpaW9kcE9zK3hRRlgveWJxd3luTC92YjRDajJ1WE96T05x?=
 =?utf-8?B?RG1SalNLSFRYWHVRUzVMN1hPYlJ0TXc0ODJNUHYzVzFTUGg5NWVhZ0E3YVVU?=
 =?utf-8?B?dTNCOW8vWW90alBkYTFrQk85ZFNBckpYbzVSdXF1eUZ0TUhyUUw1S0s1L0xk?=
 =?utf-8?B?R2tCaFgxSGpPOVpFZUtIY282SXZBSVo2dmRZN0o2Qms2anNpUXpNSUFQSlBj?=
 =?utf-8?B?NVc5bTFJNHYxWnAvRHlqMnlIV2JJaWJ6eU9qZTM2WE9hWG1ocWVyYmViQUkx?=
 =?utf-8?B?MjVxY2xScVZ3VWJWa2x0ZUR5Y1BoRVI4S2R5aG55YlNOUGtURTdJc1VzTENT?=
 =?utf-8?B?T3JOSjVqV04yNXNNSDduZDM0WVBhSlhsSEI3dC9kV0MwUEUrZjVGU1RESHVt?=
 =?utf-8?B?ZEsyK3o2K21pQlV6ck5jZWpTeS9icE00OHRteGJFRUFzaHY3eG83U2ZMQnFp?=
 =?utf-8?B?dGNFY3BzSFk2bDhBdnMwM2FSOW9DOVVSOGRHNGR6TTFQL3lDbDNocnNRR1FT?=
 =?utf-8?B?QzNNellEZFdaWU1WTU5SV25POHRlak5VTWFaNWEvVy9BZjhLdDVKSHhPNUJa?=
 =?utf-8?B?ekF5SUFWRzNXY2VXN2JoVWpNd0w5RjNtR1NzcEt2a0UyUUxFdnNZOFE2WUZ6?=
 =?utf-8?B?RUdoc2FXN0dGOUF2Qk96TzBjVFoyMHlUY2NLUXBNSjhQbFpuWFVPOE14c0pI?=
 =?utf-8?Q?4wYHFxHLyKnDO6mPaz/w?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d994d8a-ec4b-41de-84e9-08dd1e268c30
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 23:08:27.6785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR03MB10808

On 2024/12/14 00:41, Alexei Starovoitov wrote:
> On Fri, Dec 13, 2024 at 10:51 AM Juntong Deng <juntong.deng@outlook.com> wrote:
>>
>>>
>>> sched-ext is struct_ops only. No syscall progs there.
>>>
>>
>> I saw some on Github [0], sorry, yes they are not in the Linux tree.
>>
>> [0]:
>> https://github.com/search?q=repo%3Asched-ext%2Fscx%20SEC(%22syscall%22)&type=code
> 
> Ahh. I see. Those are executed from user space via prog_run.
> https://github.com/sched-ext/scx/blob/e8e68e8ee80f65f62a6e900d457306217b764e58/scheds/rust/scx_lavd/src/main.rs#L794
> 
> These progs are not executed by sched-ext core,
> so not really sched-ext progs.
> They're auxiliary progs that populate configs and knobs in bpf maps
> that sched-ext progs use later.
> 
>>
>>>> As BPF_PROG_TYPE_SYSCALL becomes more general, it would be valuable to
>>>> make more kfuncs available for BPF_PROG_TYPE_SYSCALL.
>>>
>>> Maybe. I still don't understand how it helps CRIB goal.
>>
>> For CRIB goals, the program type is not important. What is important is
>> that CRIB bpf programs are able to call the required kfuncs, and that
>> CRIB ebpf programs can be executed from userspace.
>>
>> In our previous discussion, the conclusion was that we do not need a
>> separate CRIB program type [1].
>>
>> BPF_PROG_TYPE_SYSCALL can be executed from userspace via prog_run, which
>> fits the CRIB use case of calling the ebpf program from userspace to get
>> process information.
>>
>> So BPF_PROG_TYPE_SYSCALL becomes an option.
>>
>> [1]:
>> https://lore.kernel.org/bpf/etzm4h5qm2jhgi6d4pevooy2sebrvgb3lsa67ym4x7zbh5bgnj@feoli4hj22so/
>>
>> In fs/bpf_fs_kfuncs.c, CRIB currently needs bpf_fget_task (dump files
>> opened by the process), bpf_put_file, and bpf_get_task_exe_file.
>>
>> So I would like these kfuncs to be available for BPF_PROG_TYPE_SYSCALL.
>>
>> bpf_get_dentry_xattr, bpf_get_file_xattr, and bpf_path_d_path have
>> nothing to do with CRIB, but they are all in bpf_fs_kfunc_set_ids.
>>
>> Should we make bpf_fs_kfunc_set_ids available to BPF_PROG_TYPE_SYSCALL
>> as a whole? Or create a separate set? Maybe we can discuss.
> 
> I don't think it's necessary to slide and dice that match.
> Since they're all safe from syscall prog it's cleaner to enable them all.
> 
> When I said:
> 
>> I still don't understand how it helps CRIB goal.
> 
> I meant how are you going to use them from CRIB ?
> 
> Patch 5 selftest does:
> 
> + file = bpf_fget_task(task, test_fd1);
> + if (file == NULL) {
> + err = 2;
> + return 0;
> + }
> +
> + if (file->f_op != &pipefifo_fops) {
> + err = 3;
> + bpf_put_file(file);
> + return 0;
> + }
> +
> + bpf_put_file(file);
> 
> 
> It's ok for selftest, but not enough to explain the motivation and
> end-to-end operation of CRIB.
> 
> Patch 2 selftest is also weak.
> It's not using bpf_iter_task_file_next() like iterators are
> normally used.
> 
> When selftests are basic sanity tests, it begs the question: what's next?
> How are they going to be used for real?

In my plan CRIB ebpf program will look like this

SEC("syscall")
int dump_task_files(struct task_arg *arg)
...

SEC("syscall")
int dump_task_socket(struct socket_arg *arg)
...

SEC("syscall")
int dump_task_pipe(struct pipe_arg *arg)
...

Since the complexity of an ebpf program is limited, I am unable to
implement dumping all types of files within one ebpf program, so I need
to provide separate bpf programs for different file types (restoring
part is similar).

In dump_task_files will use bpf_iter_task_file to obtain the file
descriptor, the file type (socket, pipe, ...) and other necessary
information of all files opened by the process.

And then the userspace program will pass the file descriptors to
different dump_task_xxx ebpf programs based on the different file
types. bpf_fget_task will be used in the dump_task_xxx ebpf programs.

In restoring part, ebpf program is used only as minimal necessary help,
and most of the restoring part continue to use the original kernel
interface.

For example, when restoring sockets, we still use the original kernel
interface "socket" to create sockets, and only use the ebpf program
when necessary (e.g. to set TCP internal states).

Thanks to BPF CO-RE, it would be more convenient to extend the data
structure of kfuncs than the data structure of the system call
interface, so this still has value.

Once I have finished a good enough solution, I will send out this part
of the patch series (as soon as I can, even though I cannot do it
full time).

All other patch series related to opened 'files' (socket, pipe, ...)
depend on bpf_iter_task_file and bpf_fget_task.

