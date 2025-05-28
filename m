Return-Path: <linux-fsdevel+bounces-49989-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7DFAC6E7C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 May 2025 18:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E44C74E54DE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 May 2025 16:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3DB228DF1C;
	Wed, 28 May 2025 16:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="FkrtymbL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013013.outbound.protection.outlook.com [52.101.127.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A09028DEFD;
	Wed, 28 May 2025 16:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748451386; cv=fail; b=YuSGDqEa0aDRnAzg04arUI42Bz5keMpEHGlOkV5gm1AnS/19tBll2u6R06m2gW3wabQlzcFkSYyU5ydcUmfVFRFSEEGSCj0Uk/eGVsp7eY//hJMjyLeMhC1a0enu2SwZkSGTC50f89RPyxi0t/PLtpDkGJ7pi3bbNOt28bjB+cw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748451386; c=relaxed/simple;
	bh=QMx+5fh26p81n0F/r33n5f3zwfqB1bsYvio39E+yqL8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JFJF8aHnmF2AoR+8MhTdmLaZCH5YLtbebkxxUk9jjJ02YJsNhSqz1vgMWuSxPtEAkeRbamnLGdjbV1P37smk+BYJwcnvtajzAx1j6Cv+SBIbiiU8uB3KALJO8fjULQ/Y5whVh9ulN6D6hl166uLntpE0A83si9HJsg/u3n+PsjU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=FkrtymbL; arc=fail smtp.client-ip=52.101.127.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IKem3SufYqdKloUoE6eedSaPuRUcSzbbqbozrg7QM59VHP2dww0SVh8hj0CBErORc9iKUcjuNUAwqesPdwKTbNfZP1BRaYXlMRoWwJbtPKX4dhaGmQk2htNd9QHHwhv82up2hLpBSxkV0HpoSzC3Bryv+l8crglOvZ1tPwCPXlAg21Eh14o6TiMxUuDuKZMgEo/t9CbaaACa5ysK9e/ELXOsNb+lywKy+TKvNQAiKXpoSAt+qWcU4S5qPv0U2kO9krFYXHPt/ukkb93KnI6LsAmPbWn3wtbpeBI39IBxthfIeHcHR9p5lGoR8Oc40/KeHIxvOgKwXHurtWIYvnnDKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QMx+5fh26p81n0F/r33n5f3zwfqB1bsYvio39E+yqL8=;
 b=bmS9CCYKPeaKlwBzfmlCBult3QXwbz7t/o4fKTwEcTHEApGNs4OaemhPU+tg+glGXXRKvt/RxFPTQIxKrUy+yerllTcOyBGI/gSsOgm83F9mfHV2AftUujGqjp+odkYscVtCL4maT5+0SU5ua7gjEMRFIE8dS/wFvkhSOob2vEJLRlSQOKyIag+qD7Q5hNUc+QGUz8sPFu5MYi1Chq0+FRIUq5SCn0sK2tIHrjt38i9bPAymi8sxzCtrXP+HRLyRjsLDcpkVDtwp4iNSVDUZIhw9PozHqzspgw8pu+eZXzZx3n05tFgF8cFsSAOwRhNeMsAxapldZUPU/AdxwYm8PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QMx+5fh26p81n0F/r33n5f3zwfqB1bsYvio39E+yqL8=;
 b=FkrtymbLvuCwsN7V5t1bzaF1SHjiayMGOYnhffUFbnIkTK4+RBbP5exqjHGgJELSCsveETOPV3sUQRaZ5Wpc93Vetr3tXn7ZrOAzz5acHkruJFGdsqGRGT+vXK4HGVfZSTQ937TxnmPCl/fZA94RWCgbAZ/IhD0S+4HAuW3TDi7Puh1g7P5E+TGCieMLWOW9NRAj2WRzcNjR4Cv8k72ltovd+fL6DnjyEnxbWBi8O5fsUEbxerkNbXqHWfPK9cULR6Eb5bxFWiplmS7yzEXHDmoSakjCtz83EabrEwmE+MSio35erfJkVPbTBv4Y4IZXT8SJY6kjzjIyHGPtXWKTzQ==
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SG2PR06MB5240.apcprd06.prod.outlook.com (2603:1096:4:1da::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Wed, 28 May
 2025 16:56:21 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535%5]) with mapi id 15.20.8769.022; Wed, 28 May 2025
 16:56:20 +0000
From: =?utf-8?B?5p2O5oms6Z+s?= <frank.li@vivo.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>, "glaubitz@physik.fu-berlin.de"
	<glaubitz@physik.fu-berlin.de>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Slava.Dubeyko@ibm.com" <Slava.Dubeyko@ibm.com>
Subject:
 =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjIgMi8zXSBoZnM6IGNvcnJlY3Qgc3VwZXJibG9j?=
 =?utf-8?Q?k_flags?=
Thread-Topic: [PATCH v2 2/3] hfs: correct superblock flags
Thread-Index: AQHbyNuJv/srDI0VbU2+b3+qqSvHfLPnHcmAgAEyQzA=
Date: Wed, 28 May 2025 16:56:20 +0000
Message-ID:
 <SEZPR06MB5269ED00C454799C7D32FF40E867A@SEZPR06MB5269.apcprd06.prod.outlook.com>
References: <20250519165214.1181931-1-frank.li@vivo.com>
	 <20250519165214.1181931-2-frank.li@vivo.com>
 <ca3b43ff02fd76ae4d2f2c2b422b550acadba614.camel@dubeyko.com>
In-Reply-To: <ca3b43ff02fd76ae4d2f2c2b422b550acadba614.camel@dubeyko.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB5269:EE_|SG2PR06MB5240:EE_
x-ms-office365-filtering-correlation-id: 46f66777-caa3-4f33-cf75-08dd9e089249
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RjMzZjZOSC9Fc3d4NEpna2EyZElXcDd6YjlBWGNyQ01DaVdYb2J3b2xnK0VF?=
 =?utf-8?B?cnUvK2hlQWNVQS85ODczZHo4M0dWMFovZHpIdE4rd1NyLzhtenBtd05NdmI1?=
 =?utf-8?B?N2FsMUJmWmdUeWM3a1VBTUw2Tkh1d05SNGoyU1huQjQ5NmFWd1pwNnlFb2Rl?=
 =?utf-8?B?RlZ4NTJkMldnSmc2a3R6eENTQ0VXbHpjOTJFR3J5S1prTHN5Z1lIM0U4cUtZ?=
 =?utf-8?B?eWFRd3BaMDRNMjRMdng2eTRwdFROQmhOSHBhcTdZZlVhb3cva01zWldXTWxw?=
 =?utf-8?B?V25kOG9VNUZjM0ppRFdtKzFhT1UzdWlqMGFIK04zT25IMFY5aEkvME5jeThy?=
 =?utf-8?B?aDZlYXBJRkZCZXI2S1luSjlNWG4vTXZJd1VJeXlJYkdMYnlSWVI4MWdNQU9j?=
 =?utf-8?B?RW5XOE9vWFVnK2dYUkFMWHRrR2JkRWlIajAzRlp0WCthQVhzcGhaYjFBdG5m?=
 =?utf-8?B?MTBxaWxJOFkvWEtKQWFrRnRJRnJGNEx4c2RuTE1ZQUczNmFMYmc3cHp5Zmxk?=
 =?utf-8?B?MGVQcXZRRzBoR3NCclZTNnZkOXA2SnZGc1NiOWVBZllpNUF2VkZEYkkxeWN0?=
 =?utf-8?B?ekVoQ29FdUpxYmVJVkVsck9YSlpBRVV2bFpQMWprVEFpY2R2OWZuRUtQdDFL?=
 =?utf-8?B?WkJLbUd1REdHemRMQ2lUblJUQXlxd2FsSFZYUFo1SUFtUGgwQlFHT3A4UkJ6?=
 =?utf-8?B?anhTQm95ZlhSb0ZYSHkzbm1jSmhoYUNiV3FLSmdOVVFGM0NUY1BmbElPcENW?=
 =?utf-8?B?NjAwcHBXZHNRaHpxZzNZNE5rOFUzMzQxSTJyclRFdUR5VEVKbSsyUGExVklW?=
 =?utf-8?B?bHdkOHQyZTNaWkxGMlVBcjZWTWpXMkFDN0NaWitVbldxVWJBTWZOeWJtNUdP?=
 =?utf-8?B?OEhjdjNYOWxVc05JczhtdDhDK0NnWmt2Zm42QlJIU2laNjhKY1JMWWMwOHJL?=
 =?utf-8?B?bXAxZ1NhWUU4aWs4aUo2OFFQcGdYa2hSUG9kcDF1eVNTUCt2emYwNlpndVN3?=
 =?utf-8?B?YmNLTDl2YnhiVjNxWDJtT0pRVHgzM2xEUzFKRy82Z3Rnejd5YjdlcnBrLzQ5?=
 =?utf-8?B?dXU5MjMyZ1djbUJVZWxTRGwydUZydHpIUGJ1NStpSVdYR3lFYXpPUkQ2NkYy?=
 =?utf-8?B?MFNuVnFIWkpxbkJsdUlrSWt5WFZPN3VSWjhlM2lyYS94RlJVMWtHWGtTZmRn?=
 =?utf-8?B?QWNhNmhrSXJNMFNUbTNSakY0NlhxU0dMd3VJSVQ4bW9MaDg1cXYySHFiQng2?=
 =?utf-8?B?ZW1rL1VCMHI3b2Rhc0UvQktINlhKK2xmT1cwUTl4RE5JS2ovSUFzZVdJdHhH?=
 =?utf-8?B?MHhXUm5SallLZXZncU9DMGpLblpFcC9PNHdWeHJYdjZvWVNRdlJBK2NrRnRF?=
 =?utf-8?B?aWtFVVBpaFlTQW9sQmZCdGRzYlFBTzJGVm1XMGJzZGhNU0x6SjlsYzJNeGd2?=
 =?utf-8?B?Q1BhUjR0TmE1VnorMnQrSHpsS0dPSXI2TmEwazhLbS96OVVFWXlaTzhXNnNs?=
 =?utf-8?B?cjlTOUYvTm5JNWJ4ZjVPc0lvU3o2VU03WDh2UXA1T0p2S0h6dTE4cUFDTUxs?=
 =?utf-8?B?Sm83MVR1Q3BiV2VQeGNLMkZEVDErckhpbjFoQzJJK2dicWkyNUxFRVcxcTJY?=
 =?utf-8?B?dWw5Y1ZIbDZObjZkWlAxOTN3dXMydnliOVhXUGFXaGNtWWZQTEEyYjhKazk4?=
 =?utf-8?B?cXd1WTJqV1RKMjlGaGQrN3dScm40NlNZT25uN2dkRGlTRGo1R1gvWEw4VzQz?=
 =?utf-8?B?bUh4RDB2blBzUzJsUDM4MlozOW0wNS9jSVJJNU0zaFBad29UeldmSTlYanhz?=
 =?utf-8?B?KzQwZmlZZjdoUFo4Q3lraXEyV0U2eHJ0VnducE5SUFpCVzhXMnB2RzhvRnFT?=
 =?utf-8?B?RS93SWZsalh3Y2NVRjIrVmNVYmtlaEoyTHVOS3ZyRjRiSXdNY05rSWwzNVlV?=
 =?utf-8?B?K3RnZ0tSUnViUUJSLzJWelQ1SURYMDN0TG41Rjc1SnNsL2pCTSswa00xcHVZ?=
 =?utf-8?Q?y4AuDZkKEDOTrgR95/ZZrMS5JtUD08=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aWF0UzEveWpwRUZRSkpwNE5CSXVHaHlxYkRBQmlNZVU0MkF1T21KQStJL1hm?=
 =?utf-8?B?QjZucUIyOVlkZDlmRFc0ZkdYTUpXd0tleTB3V1loZ2ZKc0xnSmNCUk1TSjRi?=
 =?utf-8?B?anJKT0llMExyS2M3eXllT1VVZnJHdVMrMjUxSDgvYXhmM0NmRFo2U3BDdGJl?=
 =?utf-8?B?MWN1SlNxc0ZpSDVTdFB3L0hDYkMva2JhTEdnUmR3QXhOY1VEZ3ByYUo1TjdF?=
 =?utf-8?B?a0dZYVVzTjBxZER5WXZwWUJLU0NxcHVrRy9aenVqWDFQUXEydE9FQy9TTTI3?=
 =?utf-8?B?RkExenhVbnE5NGtVSlNDOUhMbDczOXBrZGF1TFQrSnZqV2Z4ZG9MUW1qcGNm?=
 =?utf-8?B?TXJCaElPSzN2blFBd2t5ajJ3VkErb1BlMi9BdG1ZNzJtWnRnbFJhZEU3dEJH?=
 =?utf-8?B?SDlCMml4d3NXNVNqN0xOdHVNMFJnN1lQMEVLRHNwU3BuWTJ3ZGJMeCtaTFBp?=
 =?utf-8?B?eVBNckd5SGlYR2swcEhPTUJOUkVpNWhuOEhhOFZDVHF4NW44M0pQajMwaWlv?=
 =?utf-8?B?Z3k2bWlFdW1kT1ArMFl1TStkcUNHbEM2SjFabjRLMzJiS290cTFodWc5VWE3?=
 =?utf-8?B?OTN1dFpiKzk3dFd2M1RSOXpJQWFXT1RXV0RhZVN4WE1paThmVERQTUQ0d2FI?=
 =?utf-8?B?dUJ5MGZ4QlpaM0Vmek1xUXk2cDFDVzBuUy9iOXRyY2ZPbi9YMkxsbEZtdzZD?=
 =?utf-8?B?L0p5QXlVWFdnOFNVaklXMlZTeEJSV2ZOcmpqa0JGcVdoVVpiSFRlWW5OT0I4?=
 =?utf-8?B?NEZXZUhaejBHTXIrZ2puMTRvMVpZQ1RSV0c1NStLYVNHcm5uMy9oaldRd3l2?=
 =?utf-8?B?QXlwNFZUNjk1UFBPK2RmSGRHMUdJSlNVeWRWYitsc094TVFwN09MMndNY0xq?=
 =?utf-8?B?MXFzZFBpdzErUTVxWnNPSGZ5d0lNQm85d3NHSDh0Y0ZlYWFmYnlBM2J4M1hV?=
 =?utf-8?B?cVF0bmVMTjF6YjE3UnRISlNmL292NE9hNy85Qit5Y2w4MGZ1NjFQbWJPSU5M?=
 =?utf-8?B?cytndzdISTBGN2dNRHFQbmRwQ2J2djJtMlBnZmVBRFQ4ays4aDE1a21ORFUx?=
 =?utf-8?B?V2FtQ3pBZkl0MXJCUUFuSkNHOHBOYjlyVHRkZ29XNkx1Z2oydEd1RlhlcEZm?=
 =?utf-8?B?dU00dndBaDBZaXYwYXVGVWR3cEE4aExPRGVIZ1A4RUZKUittTkpZRllLc0l0?=
 =?utf-8?B?ZlNtdjdKcENNZTI5VUI3bFkzS3E1SzNJZHBseVlLWHZsUmhnZXJFU2pyQkps?=
 =?utf-8?B?SlF2MVMzblZHdlhQV042b1MxejdDaXFYOEVXSDhQUnRqQ2lCRGhsRFJGMFN2?=
 =?utf-8?B?eDV2L2N0QXI1WkhjVXFYeHBoOVZ5WGxQVkhDSTd6MlJ5RXNPM2Y5UHpGVGFC?=
 =?utf-8?B?TUI2d05OY0EvWHUxV0xZRG5MM3ZOd0NsL0NiRjlOUjY5QWJlRFRjeTdLMXQ4?=
 =?utf-8?B?N0RmSkZZU1BwM2xwSmlJU1h1UzJUZ3FiWVRydmJPeEdpa2dsdUdRajlGd3NB?=
 =?utf-8?B?c2Q1ZXVjNnN1dUQzOWtuSW5BTlVJMC8wYTNWQ3ZVemdiMzB2S2VydERleWVB?=
 =?utf-8?B?RVdDNHpUSXNwcHFoWXZiQlEvV2dlZ2FrcWNJUnVNRklra3l4aWJqb1h5clY2?=
 =?utf-8?B?ZVZlRFNRYXcrY0F4V2tCU3p6OS83Z0t2ZWYrcm1ZM3g1SHEwYkxMb0RmUWxl?=
 =?utf-8?B?UFhpUHR3N3pYb2JUL1JWVnJwd25id1FwcTduS0cyUndhZ2ZzTzFGTElNL0tj?=
 =?utf-8?B?b3BhbWhPTHlISWdXaWk2U2s2aVVpTks2UzYxM1B0REJURlFzVzdTUGRMTTNw?=
 =?utf-8?B?VTNxci9LQW9qQlF2WjRQS2JldFpLcGtXVGxORUMyaWt4eC9XUi9uekh5Z1pG?=
 =?utf-8?B?OUg4RmFkUVM1TkZObzFuT1FFbTQwNGEvaVhlMXRkQTZkaElOcEQrYjFjb1Fi?=
 =?utf-8?B?clgzeU10VG9nT2tzZ2RmaFZoUEszL1A3N1o0NWxxRTN0OW5KRGVMNXR3ckhP?=
 =?utf-8?B?cEFkNW1EN1hDQ2YxUzF0ZUt1RWpIa2xnSThXanlOYzlWVVRFTUlyekZzdXlW?=
 =?utf-8?B?cGVma1hSa01XTkFKcHFPV25aOFJkQTRJdlM1NjZIcVJObXMxOWduTzQzd0dU?=
 =?utf-8?Q?eBFM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46f66777-caa3-4f33-cf75-08dd9e089249
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2025 16:56:20.7433
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KdFb08OPp7th19BoKS4+muDsiqjUCyGnmkeqUGCWGEfBxosNjAB2tCCEHadziPOMxlncEaAoXN8Q0a4z/7rX+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5240

SGkgU2xhdmEsDQoNCj4gSSBhbSBzbGlnaHRseSBjb25mdXNlZCBieSBjb21tZW50LiBEb2VzIGl0
IG1lYW4gdGhhdCB0aGUgZml4IGludHJvZHVjZXMgbW9yZSBlcnJvcnM/IEl0IGxvb2tzIGxpa2Ug
d2UgbmVlZCB0byBoYXZlIG1vcmUgY2xlYXIgZXhwbGFuYXRpb24gb2YgdGhlIGZpeCBoZXJlLg0K
DQpIb3cgYWJvdXQgYmVsb3cgY29tbWl0IG1zZy4NCg0KV2UgZG9uJ3Qgc3VwcG9ydCBhdGltZSB1
cGRhdGVzIG9mIGFueSBraW5kLA0KYmVjYXVzZSBoZnMgYWN0dWFsbHkgZG9lcyBub3QgaGF2ZSBh
dGltZS4NCg0KICAgZGlyQ3JEYXQ6ICAgICAgTG9uZ0ludDsgICAge2RhdGUgYW5kIHRpbWUgb2Yg
Y3JlYXRpb259DQogICBkaXJNZERhdDogICAgICBMb25nSW50OyAgICB7ZGF0ZSBhbmQgdGltZSBv
ZiBsYXN0IG1vZGlmaWNhdGlvbn0NCiAgIGRpckJrRGF0OiAgICAgIExvbmdJbnQ7ICAgIHtkYXRl
IGFuZCB0aW1lIG9mIGxhc3QgYmFja3VwfQ0KDQogICBmaWxDckRhdDogICAgICBMb25nSW50OyAg
ICB7ZGF0ZSBhbmQgdGltZSBvZiBjcmVhdGlvbn0NCiAgIGZpbE1kRGF0OiAgICAgIExvbmdJbnQ7
ICAgIHtkYXRlIGFuZCB0aW1lIG9mIGxhc3QgbW9kaWZpY2F0aW9ufQ0KICAgZmlsQmtEYXQ6ICAg
ICAgTG9uZ0ludDsgICAge2RhdGUgYW5kIHRpbWUgb2YgbGFzdCBiYWNrdXB9DQoNClcvTyBwYXRj
aCh4ZnN0ZXN0IGdlbmVyaWMvMDAzKToNCg0KICtFUlJPUjogYWNjZXNzIHRpbWUgaGFzIGNoYW5n
ZWQgZm9yIGZpbGUxIGFmdGVyIHJlbW91bnQNCiArRVJST1I6IGFjY2VzcyB0aW1lIGhhcyBjaGFu
Z2VkIGFmdGVyIG1vZGlmeWluZyBmaWxlMQ0KICtFUlJPUjogY2hhbmdlIHRpbWUgaGFzIG5vdCBi
ZWVuIHVwZGF0ZWQgYWZ0ZXIgY2hhbmdpbmcgZmlsZTENCiArRVJST1I6IGFjY2VzcyB0aW1lIGhh
cyBjaGFuZ2VkIGZvciBmaWxlIGluIHJlYWQtb25seSBmaWxlc3lzdGVtDQoNClcvIHBhdGNoKHhm
c3Rlc3QgZ2VuZXJpYy8wMDMpOg0KDQogK0VSUk9SOiBhY2Nlc3MgdGltZSBoYXMgbm90IGJlZW4g
dXBkYXRlZCBhZnRlciBhY2Nlc3NpbmcgZmlsZTEgZmlyc3QgdGltZQ0KICtFUlJPUjogYWNjZXNz
IHRpbWUgaGFzIG5vdCBiZWVuIHVwZGF0ZWQgYWZ0ZXIgYWNjZXNzaW5nIGZpbGUyDQogK0VSUk9S
OiBhY2Nlc3MgdGltZSBoYXMgY2hhbmdlZCBhZnRlciBtb2RpZnlpbmcgZmlsZTENCiArRVJST1I6
IGNoYW5nZSB0aW1lIGhhcyBub3QgYmVlbiB1cGRhdGVkIGFmdGVyIGNoYW5naW5nIGZpbGUxDQog
K0VSUk9SOiBhY2Nlc3MgdGltZSBoYXMgbm90IGJlZW4gdXBkYXRlZCBhZnRlciBhY2Nlc3Npbmcg
ZmlsZTMgc2Vjb25kIHRpbWUNCiArRVJST1I6IGFjY2VzcyB0aW1lIGhhcyBub3QgYmVlbiB1cGRh
dGVkIGFmdGVyIGFjY2Vzc2luZyBmaWxlMyB0aGlyZCB0aW1lDQoNCldpdGggdGhpcyBwYXRjaCwg
d2UgZG8gbm90IGFjY2VwdCBjaGFuZ2VzIHRvIGF0aW1lIHVuZGVyIGFueSBjaXJjdW1zdGFuY2Vz
Lg0K

