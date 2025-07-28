Return-Path: <linux-fsdevel+bounces-56119-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6377B135D0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 09:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3F95171D48
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 07:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA02221F02;
	Mon, 28 Jul 2025 07:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="ndvVjsKn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012043.outbound.protection.outlook.com [40.107.75.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E7821D5B5;
	Mon, 28 Jul 2025 07:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753688434; cv=fail; b=VPXlQAWklfSNn71FeJghQbeTdXTHC1cJBlC8NSvuiK/3GrezaKsWaafPktbtet/PJNAnpL6JifucPXy/qbrD5cQFV5r3wmCJwKmAqoyfHJUkipcdtqPaPUi8pv4NpWfkSSvfN92mCNITse3dl6KmTIctMJWLY/msnmhcyg0bJU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753688434; c=relaxed/simple;
	bh=rjWxxHa6lzX4qtaBYchpfpih0eBVmdVLehJYRSGIy6U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aOc/KB56Fu1RC9SjVbmomH42pYYHCZ2Pv7Xy7FVB4scr7gGseSY/SpGDLNvfDmtESYXmUEQdImNeI9NbEpy4baKodmI5SFnzvK/en0DHW0M0vspoVyNM+U4Q1vsYnps1uSMdtltzoDZPmWhiEg/FECtZKG7NPKUSBi+4cYGR0i8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=ndvVjsKn; arc=fail smtp.client-ip=40.107.75.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kMA9oS7mc+WjNQv9HholT07pl4RO7NX4MMsx3Z5Ntor9iWdEW0P3afvC6bZ8lbMVRzEgYJ95XoZv+WVRDJo+gHIGQOkIaNj7qN/7lbw/zWBtr1eisnvz56iGwa5CWxLyS/ejFlHHzwEfLQTWBWVeDWEDvqeY96cCw4no9P8AE3lw4E30YpnBNxEJeTx4rrX9D77GrhiViWmq2GkIKh9SR8SozqjBoW52kpf0FYCFTdCDyIgt6W91PAVtoSi+FgluJaJ5GJs1cvHKa1LdijkMYTE5KqAORDhDH/B8iu9rhKCAn/FPOKypAUE8jMC+QY14Fk8LHQyC9sSDKfxw2lrYAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rjWxxHa6lzX4qtaBYchpfpih0eBVmdVLehJYRSGIy6U=;
 b=nVvQzBccXYA58/2k3hWEfF8e5bLgMgBllGKkvgf+W7iLpyhfI2Hz9qLJule4z+p59zgKfrhH/MTivVEgxzim7owMxH2hqbEQhdHLE+C/MeSW9CaJ1PQw4Nmz3O8Shbv/IFhgdONkMt3lri6seWGW214tlJr9Jwee92f4vFIiAh6UYrAX0Eg008tP1zMxx+c7n6eu4UNrqxeyT2PZjJEqEHBC1RnFVHqkY+ESP3D7Y3VLXBGz5TyG5dSTlT2v1Bx4+SggYklbbvKhrFqu1xfzhWdQaO4cbzHFeJGs26eB0ssJe/65TNWgVK9I2x122I6/8I/eJOSb5Ln/gsGoRNzY8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rjWxxHa6lzX4qtaBYchpfpih0eBVmdVLehJYRSGIy6U=;
 b=ndvVjsKnPY6VB+sc04pJwa7MfShQ4lgRG8Pnkq6bMczm7Zixl5QGfAD8rvgaiEgKQWy0/8GYx+vs2gAw1hbQwkmgd7y316jihjMMpBZflp0pu3ABHEIybrs5vzTS2jfsWOX6DRnFAoWYLTXzte8FBb9ivvYKtWmMJ3Td+et6ZDHwdnaroebkeqGrIgu69LadYRz+CUSo8XeFXQmAoCYstDANZkf9Zc8m0BVxTw9RWAP5heLx+2fsyOmkmc8um3+twT+rs/MXidIMflX72QmnotOWTIwuwjkdPjGTxf0JMKaMqpczW1F6TeMspVTHXrHLCIDNYQ8osqtXWOv2QkD3MQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from OS8PR06MB7586.apcprd06.prod.outlook.com (2603:1096:604:2b3::13)
 by SE3PR06MB8048.apcprd06.prod.outlook.com (2603:1096:101:2e1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 07:40:25 +0000
Received: from OS8PR06MB7586.apcprd06.prod.outlook.com
 ([fe80::1aa6:945c:5dfa:fea2]) by OS8PR06MB7586.apcprd06.prod.outlook.com
 ([fe80::1aa6:945c:5dfa:fea2%4]) with mapi id 15.20.8964.025; Mon, 28 Jul 2025
 07:40:24 +0000
From: Chenzhi Yang <yang.chenzhi@vivo.com>
To: huk23@m.fudan.edu.cn
Cc: Slava.Dubeyko@ibm.com,
	baishuoran@hrbeu.edu.cn,
	frank.li@vivo.com,
	glaubitz@physik.fu-berlin.de,
	jjtan24@m.fudan.edu.cn,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	slava@dubeyko.com
Subject: KASAN: slab-out-of-bounds in hfsplus_bnode_read+0x268/0x290
Date: Mon, 28 Jul 2025 15:40:14 +0800
Message-Id: <20250728074014.271654-1-yang.chenzhi@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <5703A932-C5B0-4C98-BC5D-133F6E7943B3@m.fudan.edu.cn>
References: <5703A932-C5B0-4C98-BC5D-133F6E7943B3@m.fudan.edu.cn>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0082.jpnprd01.prod.outlook.com
 (2603:1096:405:3::22) To OS8PR06MB7586.apcprd06.prod.outlook.com
 (2603:1096:604:2b3::13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS8PR06MB7586:EE_|SE3PR06MB8048:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fc95dc3-a262-4a21-0398-08ddcdaa0341
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1NDQW/2Yat4Jrm3wqg3hehFaU8mXOwUAKCTUuJUWS+zvm/cWXWGwoqeJZ8pY?=
 =?us-ascii?Q?X90Qrzwiu/sBWELTpqU6ILkWDtO3kPFl0OFeKjT5IpPP7UhLoVwzGZuw2+dm?=
 =?us-ascii?Q?D8tNp86mzbROmm6WyeHid17474hx0d6emdJ0kgf7s+YR0Z660aGHUdFmsNHZ?=
 =?us-ascii?Q?IUpsiqfSE1lBbuJ3LUWgRT/jiulR02JzXl757bjkVcpb2ty+otfPXzL6xxYh?=
 =?us-ascii?Q?rOHM65LpaSsC5e+JjROeCha1LX7RtZH3AOPjRBUZp9KQ1P7O4aJh2J/zxBbh?=
 =?us-ascii?Q?JDY7f8CesGsrspvx0rhNEcAZvBv7u4qCyq+CKiw52Oq4L+m9ZzKuQuD6S+tW?=
 =?us-ascii?Q?TyV3dEB5KzRFqhVEpzFhJsDP2kZ2NAYysj+hP9i/0KK1Arlo86FRkJAKPqsL?=
 =?us-ascii?Q?4o5RdhOQo7pUtp4epDDquriR5e/HMcCcGPfkiVNSfKqpgwEpiO50awTlTIGk?=
 =?us-ascii?Q?+U9mgirI4qXaIFDLJgD2R3gx5ss2nzTbX0ToMuabPDsuXt0TuvMm89s4y3w0?=
 =?us-ascii?Q?WWz5mO8pA+x8auN224O3duYOhpeUj27t37zGS8BeH4jMXSOwjbjjTpJTvV3C?=
 =?us-ascii?Q?3dtueN6EKxdo1bPun/QDkVGdkgAwcPGMaa3N7L0uJgHvI73zXTUbGVkWPNSF?=
 =?us-ascii?Q?V/0DPOfPeYJs9tQJs8FUCLFiXZyus7wg6MLIELw7xMhPrZY4bWqSsUfC1r2V?=
 =?us-ascii?Q?zU0N84q6jsYRzCymtDJKhg3rExaOocHBucbHRpAk5mQbtyPl9j+3V1exiLKz?=
 =?us-ascii?Q?1WBgiLnbiFryvLflobcuwlHbkbzd9+7DEt23x22cIFsnAC5VFnAl0VZLHlJf?=
 =?us-ascii?Q?VJPcul47IeMKwuGmWxsBiwfN/iYx2umImztSF8sZV8sVMVdcc8o2cJM/fTIZ?=
 =?us-ascii?Q?mKOxVGO8y4RmmoPzJnNR3yJiQAOdnjVBbsd1ZxMm8d8kHPHT4jjGoUZ48CVm?=
 =?us-ascii?Q?e08SdWdh13yl3BjUqQL5fJ79gj7ScF869pk1J9WERqBygicpLlxNVDocvakg?=
 =?us-ascii?Q?9QWm86UNM+aqvS6HrExcrhJwxsxyI/hIXNWob4eA25HPKEdImb3vhKQafAq+?=
 =?us-ascii?Q?BPuySVMR7zDGFP39XeYam4uw8dCer0+BYf5BhcKe2sRj9qZS88Vl5Xv4njmU?=
 =?us-ascii?Q?igdgkaQH8+UUcSv1sMp0/U7QO2UzMUWjx6L38lcE9mXO3Yvxtwo4iBIa8Yew?=
 =?us-ascii?Q?AhJHblqoZLvgnoeEW8IgAQBFcvsVw4XGjklR6OQ50GNds22eB9y1b4d5pDG+?=
 =?us-ascii?Q?HFEFMk4DW8u5ZPrvJnvN/stNt2UXm3Vub0Bgq80UIoKra62umKcehkfA3l89?=
 =?us-ascii?Q?uci7+29IruS3j220N77i1Uv1wnldtwNNZbHU7fHjd9d7lUKaBaCRDQj3UgpD?=
 =?us-ascii?Q?yZcyh1VNj3gvJH8f3/7s/jdUA0ehEGN6mmCzB0My1pUGISbi/acTB/3nQhAi?=
 =?us-ascii?Q?atNCUH51mcTLJqRWIWX+n1fpTa6elxPS8T2qytpqZ0h1QuuOQ2XHzX8L888I?=
 =?us-ascii?Q?RgZK2vLChRg1Kuw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS8PR06MB7586.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UVgdZMlilQ3Z/q5X0HmRYk9OP2lIZEQcTwgmhiu7maXhJEUXjMRm4kr2QYf8?=
 =?us-ascii?Q?Z3353L2rUcNcWqPboQlmxxoSwaUDZTEmSOl5N03oAEGQl85nA7CBc05Eyh2w?=
 =?us-ascii?Q?+r5RmqUsufUCGFnCDTBbJqLRstjAz2rLUjhyF47ooYdIPkshdSIVM0ZX5aSG?=
 =?us-ascii?Q?ALLq9smfuKovkbNhhccPOfO7/a948mxhtp63FPYtvIjHBl3qK7bjhQx/yNct?=
 =?us-ascii?Q?RPh7bab5jiOZSMYmxGmCe0L2ZFDTs5M5KXePw3jT9xroJONIfR72IlAFEXOZ?=
 =?us-ascii?Q?DR1KiGp2BeJY15InNx3tAkq5BoGyjnTcIsq2kTxRYdl1ntmK0m3GWtxa+fTo?=
 =?us-ascii?Q?5KfhsBkTnpsUmFFc/IcCk/2cn0oodyX7AG8HBLAq1wkoGS9y5M11JyltwZOc?=
 =?us-ascii?Q?gHAG0ImJKaN++JBlS5c4cQAyfcHHGi9uD4+zdOpTunjqgPlONxECrS6x9eH6?=
 =?us-ascii?Q?1yJZoz5OkZ5WUxcJiIsHZ/nQ1UX8KgFg8Ugs3LTv3vkMkfyo4uvHe7vWj6jt?=
 =?us-ascii?Q?ir0geeHXn6M1YVN3y3kB5RFlFJ3G6hvGuND4GqhOUGxNIMVGOMRYWG4im83/?=
 =?us-ascii?Q?R1sRseJEsSlQDwhCBXT/jnAfrjcgOMplKFm29zgJT4Nbkw6lTBGHaKFmIYNB?=
 =?us-ascii?Q?NDUtJiE3o75pmm1l22i9PAb/NjgKCqd+8gUox3gxV4I1zAtLA0TjgX+UHZcx?=
 =?us-ascii?Q?PyQW4hUeW2Ek3X5dFs7OJ9oDIAMiqyI0N+5HN8xjeNJ+s2Zjmr6AsqldXLrV?=
 =?us-ascii?Q?qmi1sk90Dmr9PaSCZ6eHEJAQ+f64QPRnliP5/RcBilupn0FGW+37C0vL/P/y?=
 =?us-ascii?Q?cyFpTdxSuux40dtkysseNINokvgMwe/tT6LcFumMW4o/HxJLdsSt1z62Mud6?=
 =?us-ascii?Q?s5AOTSvSXIBHuxuVOJ4zEa+smz7akRycXJA5kZ7lG15Dfp8xCogKwACPyDjx?=
 =?us-ascii?Q?LPdh9qX4JtiaUzPgnY6sSdR8I4fgNsVNWOObpzqY42uArhF0eOq1NkuzokCD?=
 =?us-ascii?Q?W6jI5lKNY2r6Ig+8nhl6H0ZqDE7GPJ/QvOZBSd94gocE14Tl0hGhF/APdH3h?=
 =?us-ascii?Q?snjxM8PcUj/muH1WaE8/c4mfyOk6lQs9YGOnqQMZ4IGHjxDEDhIlbg5xp/ZK?=
 =?us-ascii?Q?0w56KsTNmvqmcaltTN8CYa3kpUz3pejT7ioHdpG5jIykyKHRxAB5fN2qGUrP?=
 =?us-ascii?Q?QcI7ol43wYkD3Qqp7fUkdL4c+5KqXp0Zo4a7qwVEkozmNCPqCDOTVD0XyEAF?=
 =?us-ascii?Q?q53TW7Rnupmou5mZ+OK1cE5GhfhfSoW+ApSzfpibs8DQzEEPyrp6CQeLO8eK?=
 =?us-ascii?Q?HmuchMQIL1arqWAVn+oG9+uFjfox5Bw4aKPOoS6wyh1Kbtvwn38uDT/KmMm7?=
 =?us-ascii?Q?5vec90/dtDa3WpBC+r0oy2R3fS9S2wTxzBe3j8s2j9sxxI232JeRclzZ670s?=
 =?us-ascii?Q?HPdAtLr8BYkfgZKPGJYsXLr1W3wfqNR47AI+CXbxAgepigQw8bNISjADnCCU?=
 =?us-ascii?Q?t333+X36lOuN/Vi7ZBxN/kDmGdLix/8AEfhYNbHQXz86Exk3ncH9gP5suW6E?=
 =?us-ascii?Q?G/PRQWJPywJ6Bi/k052BA7yWqAaeKtqBQRRpPC+y?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fc95dc3-a262-4a21-0398-08ddcdaa0341
X-MS-Exchange-CrossTenant-AuthSource: OS8PR06MB7586.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 07:40:24.3302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1JnDc7BvaLa7D/87I5eWdunlLsQcRhSRc/8/ZhGsDe37L76e5+TO7Dnh9DMexldKSuTJWg/mPu7VymkkbRKBRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE3PR06MB8048

>Hi Slava,
>Thank you for taking your time.

>We originally obtained this issue's syz and C reproducers using Syzkaller's repro tool (refer to the URL below). The issue was triggered when we ran the syz reproducer through Syzkaller.

>Url: https://github.com/google/syzkaller/blob/master/docs/reproducing_crashes.md

>Syzkaller also provides syz-execprog to verify whether the C program can trigger the issue. We are currently in the process of verifying whether the C reproducer can reliably reproduce the issue. Please allow us some time to complete this verification.

>We'll follow up with you once we have more concrete results.

>Best regards,
>Kun

Hi Kun,

Just wanted to follow up, how is the verification of the C reproducer going?
If it does reliably reproduce the issue, could you also let us know under what
scenario or environment it occurs?

Best regards,
Chenzhi

