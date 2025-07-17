Return-Path: <linux-fsdevel+bounces-55201-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C85B082DC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 04:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66B4F1889ACC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 02:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE3B1DE4F6;
	Thu, 17 Jul 2025 02:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="prbiwIvQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012055.outbound.protection.outlook.com [52.101.126.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAE414EC73;
	Thu, 17 Jul 2025 02:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752719041; cv=fail; b=aX9hnU+gO1ha94Jrn+HOUoCuQYustoE4iU+aRYHAuUDzx1dZJYO/orCVxD1x/8Mbs3t2fCPAaAjyRWtot/3K7odNo0uxGsB9lOGANkHI8qCe2ETtqwp68NT8xbIEsqWEI/A/nn8c0jdBEi1IyQJxJSSvnSHMI1E7TIrOD5+sGC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752719041; c=relaxed/simple;
	bh=8Io5kS55/DXh257G2zghdhUaFHHpAUZLYwcjdI8BNOI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HtpRWjD4j1+FqRxYjva40TvP0Tc4HViZwHcJnCjDUygz5fMWLa5UxvPSGHCyfgXYTKFHPe9TOwYtV2ltkyph89FCg9nAs7OQu1ZmXwQ2uCkCL2tG4CDucGDzdfgiRadWZ1BKSAmKO5eJU5loPBveKY3bPqQnGOh/C1EkpbxJ/SM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=prbiwIvQ; arc=fail smtp.client-ip=52.101.126.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nLK5yRP5opDJnEzrQr+P1BO9Kf2Mhw+QC429Q8ZzfMnPpzjViiXQKioBFUYcNdYEqnRfnXHEM5sW7ZkGHYqydxKXS/haSIzHwDbhQMjiHYfLZDCsx/mytpJWRfNskdxqb5Ky6Fj98vyCKNsus1TKeixxWsFwRNu29FtIdHV1qtCRSM2Br/1KnSWjvYiXJp4cAZAt26aK1yUDABw4MchMWIt2+ZchkhKkKjsRdIlrPBk0fVOvyo+Z0ZPue3qt0VMbmOhnpmhkN4K/diEKhQZY60wnYe311AfdLTsjw//Macpwp7bHMWw6ApRBOYHgnF287mb/P2F6S5jDH3K8pBQq4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8mYlsoPqr3kcHH7oeTrJxN0JfMG/b9G6dpuO4NcpFI8=;
 b=NPr4b1iocFlssVkf4AopJcPb3Te1shup1511FlTB1ozWpnY408B42JSqK0KolvteKs8WQ3awOpb99gfdDr9dYtuJlCxe9pO6H8XXEccs+D/qwz+zIQU2nYA1+Ruz7VPqFYUhqZHBFgtuw6EGlatm83Hg7yWjD3UZS2EJt7yxByMvMSOlqy+ZfjdZjupnmFCNeZUnSYLVAiM3T3HCzixIYopC7wOpABTW7v31QG3471gYi5sAIGfhrLxnzj8ueI8CzlLN7PIWmuacSq1XEoFoqhjkmSEN6zXbR/I/qD2O6ko0orZPq/KbHUUgKbEAA/mTdB6lMyaWaHjGLH61D4TMKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8mYlsoPqr3kcHH7oeTrJxN0JfMG/b9G6dpuO4NcpFI8=;
 b=prbiwIvQTCV1cyIX6+YlLjeboVudkFA8KH8b2QCtHNcDrn6AHPihS/r3jyI6r+KbnC51J1vDfUCoxGLF8TMqy1WqXuL+6uETwI4vhRmXknw2zamB3cpsBj+OYnKQLGQFZ9EbrmA9NNr+NzF6+wZN0OafVWMChWadg/IJ1bCQZBg5tQV7mrHNChwZ7gIN9Ok0cdPNWJqF9JBLiAFqHJ9N3ZJz/WcmhPodWGXwcNTInF8mABtj24tUtEIUY9M789FReEn4geb2KhK3DMIvMFKytRXuKnf+FVXdK/qoSQ+l6Ro2DTj9oeyJgvyDZqpRKImtg1CkY8ZQw1zbzm5/HdcpgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB7140.apcprd06.prod.outlook.com (2603:1096:101:228::14)
 by TYZPR06MB6935.apcprd06.prod.outlook.com (2603:1096:405:3c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 02:23:55 +0000
Received: from SEZPR06MB7140.apcprd06.prod.outlook.com
 ([fe80::9eaf:17a9:78b4:67c0]) by SEZPR06MB7140.apcprd06.prod.outlook.com
 ([fe80::9eaf:17a9:78b4:67c0%5]) with mapi id 15.20.8901.028; Thu, 17 Jul 2025
 02:23:55 +0000
Message-ID: <bd44135e-a86f-4556-8219-baa2f73c98c9@vivo.com>
Date: Thu, 17 Jul 2025 10:23:40 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] fuse: modification of FUSE passthrough call sequence
To: Amir Goldstein <amir73il@gmail.com>, Ed.Tsai@mediatek.com
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, liulei.rjpt@vivo.com
References: <20250716121036.250841-1-hanqi@vivo.com>
 <CAOQ4uxi5gwzkEYqpd+Bb825jwWME_AE0BNykZcownSz6OZjFWQ@mail.gmail.com>
From: hanqi <hanqi@vivo.com>
In-Reply-To: <CAOQ4uxi5gwzkEYqpd+Bb825jwWME_AE0BNykZcownSz6OZjFWQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0029.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::16) To SEZPR06MB7140.apcprd06.prod.outlook.com
 (2603:1096:101:228::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB7140:EE_|TYZPR06MB6935:EE_
X-MS-Office365-Filtering-Correlation-Id: d44fcf6f-959d-4eff-0280-08ddc4d8fa5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bWdSMmdOUEY2MUlhbVhCNHhPODdkTU5zUTRSR1VnRDBkWW93MjBoMkNiUGtN?=
 =?utf-8?B?V1c2OU8zL3ViVWZQM3JJRXViTDBSTFpuTm5leDN2a3NjVUlOcjNLaUZkOVNI?=
 =?utf-8?B?eHdTTGxtQUNsMjlqVWlyaTNGNjFoMjhFUEc2VVhIMzRVYThDYm1EcTJoVElh?=
 =?utf-8?B?eWtvVjkwSWRtZzJVU0NjVlExRisrK25GVkRpcEZMMzRvdEZ5WXZsYm1jcVBj?=
 =?utf-8?B?clRtMG84Zk9aUW1lR2tQaVI4dlZsdzRMNW1IUTFSdEZIOHBSeEhUWnJrdXpr?=
 =?utf-8?B?d1U2OUFWQ0RHd1V4cDdOZm1pWEowNmxpSzVTTHhpbnBUNkxDMGNHMGJ6N3da?=
 =?utf-8?B?NzBNNG5RVFdMeDZkUXJJN05ybk1Ma0V6V0JMUEJqVkFGb2xLM0ZrY2prTmdj?=
 =?utf-8?B?Mi90UGdaaEc0UHlKNThibU91dkxqQyt2SUVYODFCZWtQYXJGVUFpWVVxZFFZ?=
 =?utf-8?B?dUJMOUpqbWdaRkJLbEJkdGg3VTFsRHdUam9IZFIyZTUvS2VFSW9JSUE3dHZk?=
 =?utf-8?B?TEV5L2k2dnRiWHpGMGNjaE45azM1TFptTitMT3ptUTFIaWNzdVBMMnAzWnlJ?=
 =?utf-8?B?N3ZNWUQ4Y2tUM24ydTV1N2xDTUZzVzFRYml2SHBtOHBpS1Fsc3dncmx1c21G?=
 =?utf-8?B?T3JaUm83VHExV2kvekNTSGNQTjJBUXdFMGJpVmM0N2cvU2h3UU9rcURodzZs?=
 =?utf-8?B?VFhIa2crbnV3WjlCVDlxWXVDWWw0YkFneW5vK0ZNTWwwWm53MkZXdFlTanda?=
 =?utf-8?B?ZWMwTk5XMTFYL1QzSm0yRGp0ZlROaVBmWXE2NHd5dHJMWS9zaTZXUmhvYUUx?=
 =?utf-8?B?d3NaWFlTVllDVTFUZ09VYUJlWHJBZHVSbkZxVkc5dEt6VnZMMmVqTVhxdk9h?=
 =?utf-8?B?NEtYekdIYkR1UVY1V21NV3pOVmVuaWN1SjNhOE1wMzY0dW5SSURCaTMrRTVw?=
 =?utf-8?B?NWVvZGRhbmdsdEtNRUJKdkN2K2tuU1U2eXVubkRMUkFDY3hIR3pVRUk4SDk4?=
 =?utf-8?B?amNiaW5JUzRPSG1XUWVsVmhCaWN3aWl3bHFNaVlxcUh5ZG5taU9reG5jQ3Jl?=
 =?utf-8?B?OWJTNTZ2QnZpbEVOa0pXWVpRODJiQXYwZDlsU2JzenkzOWkxTTR0YW1Cb01R?=
 =?utf-8?B?YWZEeC8zZVhSZ2d2QUdpeXpQNVRmZlJHeEloNWlhVFJHTk5ZeUdNc3hpSm5P?=
 =?utf-8?B?ajBVM3p4SEJzWWtOUkxmaCtpWkVmZjY2RnJhMGdrNmNUNWVPZkhXYjgvaFZi?=
 =?utf-8?B?TXpua3RnQXNQanZzMG9HemVNbmhzK0tXTGZHTDFoaFFoOXNkUllHcmRYK09M?=
 =?utf-8?B?TnphWHhJS0N6aS9tUVpzWXdwNFdQK0FDQ1cvNnhYTzc3VHRrMlNFS01OR1lS?=
 =?utf-8?B?VzZFVXJ0Q3NuMk9rd0lxZjNKQUdsK3hKdnhHNVlBQ3kzQ2gxb2x3NFBaNXVx?=
 =?utf-8?B?aUQ0Y09QYXhqVEl1NFN6UnU4UHE1RXNndStsRnlGMUpEc3F5MitvVTRJTE9Y?=
 =?utf-8?B?dDAzYUl0MXU1UFpaalNrVm1wTnVITzdaVi9oTCttTko3NjBJdU95MnhxdmR4?=
 =?utf-8?B?UWhNUFU3TTF5U2xlb3BXY2xRc1c5aWxRalBoVGJ0WTMvZ2JmYzExVGwvK1ln?=
 =?utf-8?B?dFF4MnVkMDh1bDhHU0RxcTZnV0VFSUJlNXJzNlJPZnk5N1g3V2FWdFFKZXBz?=
 =?utf-8?B?ak43eUlNQ2dGcWhONzlwaGRFaGR4MHhnTlg5STlRaUdVbDJvdnVNa1Ziamg4?=
 =?utf-8?B?TDZNQ3daeDEwOVYxOGYwME5vR0tTQmxDRWY3ZElzWHgramFJOCtsdjZ5S2VB?=
 =?utf-8?B?QWErMU96cXBabWFVWU5HdGcrYnpmdEt2ell6RlUyQW81dGZqeklKSUNhbTQ0?=
 =?utf-8?B?M2UwTjJGWExEejFuQ3kzSC9FZFVoTUFOcUJCelg2L2V4TjMweDRBQVZuTjVQ?=
 =?utf-8?Q?dNRfIk6KRpg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB7140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dExmWjFaR2FMQVVweSt0WFZCdHY0S0JWUUlNK0ZPTmRHbldIdDl6ZmVLV2Fv?=
 =?utf-8?B?VXBOcU92Qk5DZ0xXNnpOWXlsdnFWTno0dWdiNEh2Z0JyYzJvbjlUcHFoM3J2?=
 =?utf-8?B?VTJiYksvNjB3aituQWdteGtoNkdkTlBXWHdaZExQOGNaMUJqUHI5c2xTemd0?=
 =?utf-8?B?cDY1RGl6ZTYvd2NtYjZ1RS92VHpPVWYxQkVmU3JtL3ZUUU9XZ0JvZWFYV01p?=
 =?utf-8?B?YVRKd21rTDhzblZaSktFaGZ6ZWwwa25sS0lTRlpsUGtUWHBySE5aT1hJVVls?=
 =?utf-8?B?VjBwRXJ3RnpMNjdvVHlLR0JrOVpzbm8wVUtqZFlOZmFrWDVXYmxPRHkyL3pn?=
 =?utf-8?B?ZzlMd3g1dDhWcmdQczNvWStFU0pNdHE1bHRyQUQ5a2tMZzZMWjBkMjZTbWk4?=
 =?utf-8?B?LzhaWUMxalpmcFdEa1huU0lodTE3a3VkUnd6NEhNWVZyWC91NlVMZTJoYUpu?=
 =?utf-8?B?TDdGUERrWEJuSmZLdi83ZEdIczljczNvQW5YcVBWSkRjWU1MSHB3bHhkdDR0?=
 =?utf-8?B?V2Y5R2xJWDF4bUloTDEyaGRNS1kzTkJsaHBHSTNPaHVQYmxLdmlxNlRyL0NY?=
 =?utf-8?B?VUZjclh6c0JqMjJXZXFZQjMrMFNEekZSODJ1d0R6M3JKeHNVczhQUXg5ei9D?=
 =?utf-8?B?aUJkWlIzc2F1ODZXQmYvR3V5c0RoV0p3Qks4Nzc1emRaTkFrdkYyVVJrS0Y3?=
 =?utf-8?B?TGhGS0VJYkZVV255VHVYcWxxWmJmUGZXTlhLWit2VzNnTG1EY2NHZUN4UzZr?=
 =?utf-8?B?RUJKVkxvdVIwTGRQbVpJMFNqNHNuT1JITjJGVjd1c1JHUFZCenpzaVRaeU8v?=
 =?utf-8?B?VDlEZ0JBT3FjK2dQMTlGVjRpRVNVbCtuRnFTSWVOVUlBYkZsNldCTUdTeVBH?=
 =?utf-8?B?d2gxNVl5ek85ZFZzZVR5V3lOQWRwN2hHTUZ0Y1ZBMVordVR0c3ZZYVo3RDZE?=
 =?utf-8?B?T2lCdFVLZnBhc1luaFBGeGZTT3AyTWxZcWU3MmJuc0RCbGpnQ1JxQ1V3Qi9X?=
 =?utf-8?B?NHFCNk5YR05ENTNaWDk1NjNnUHM5N2duM09zWE5oS3kxbG50VHlDcFdtOUVa?=
 =?utf-8?B?UEVzUUV0TWVSRTIzSGN5TkhLdFlIRnVJUFp1ZlAxYXFPM2NXYnBVbG1VTWwv?=
 =?utf-8?B?OFhzT0J6YjQ1OFhndWZtWE5GaGl2blZDQW03S1RMNXBTZnFObWg3bzNpMEdR?=
 =?utf-8?B?WERqK1lVV1NLc0Z2YWh1WUdqK3hHdkxaZ1hjRWRYQ1RBbEQ0OGlDMmFuc2ZY?=
 =?utf-8?B?L3ZVUk8xdUc1UDJKcFdCMDhyc2lRMlppeERzWnBhK2lvYlB6QXZud2FtYWwy?=
 =?utf-8?B?dHRHdDlQMHg1VDJCdzJ1ZjhXZmp4RGNhQ0Y0UFJTYlNBMWxhNkRyR1p5bWs4?=
 =?utf-8?B?TXpDUDJvMWdZbW81cXBrRy9majFuaFZCN205SjVwY2pFMU5aeDFSTHUxSkFx?=
 =?utf-8?B?K2MzaDI3QnFGcTZ6OVV3SHhLeitMTEdRRk54a212M0pjMm0yNkVkQ3JKSllv?=
 =?utf-8?B?VmR0R28xNU0yY2YyL05FYmFMS1g1YTFwdDhOZDJMaVkxYTE5ZHlvTlRWQmZw?=
 =?utf-8?B?cEJTeFlpNmQ3ajNseTZqT0VPT1RwbGNMdHV4Titia2xZTU1pRk9kTlZVQnVj?=
 =?utf-8?B?V1dsWk1LU2xXZGpNOTZ0SHRhZ21RRFN6RTdsNG9pQWJaSlJsRlgzQzNwTElu?=
 =?utf-8?B?WUdIK3Y5RXhiaTQ3WU5WSUFDUnZpQWg0YTA3Y2cvbUNhSHZVdk1CQWZDaXpr?=
 =?utf-8?B?cWFTa1NWNE5QNnBISzNnSys4ZWI5cS9JZ0JNV2JJb3QwOFE2STIwdEhBWmJq?=
 =?utf-8?B?VjBiTVpMU3pLRWRNRmsvYUhuMElYK0pHUS8rYW1YRXdkdjRoQytJWmRaUS9E?=
 =?utf-8?B?dDdmQlVZSUgxSG1RVlZKc2NBZzFsQU9vWUVyckFLcUxha1VDZmF2WnJkaGtJ?=
 =?utf-8?B?Vm56YWRWNzY3UTdXQm5sbjY2ZFhuck1kMUNPQTdZQTJiMzlaY3JCNVo5cEZv?=
 =?utf-8?B?d1REeHh6VDdUaG1FUEtpOW93Q0Qydk42QUE0aWMzaTJOZFQzMnJLRy9CdWRX?=
 =?utf-8?B?ZEkwU0xwRzlGOUtjT2Qrd2RvWmtXdDB4Z24zd1RRWjBhV2R6elpXZkdMN1Vo?=
 =?utf-8?Q?CeMYsWXGlpIRLlzAK839tvvKY?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d44fcf6f-959d-4eff-0280-08ddc4d8fa5d
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 02:23:55.1599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wfHmPppVpijVBaHxL1UFiz6CUt1EMoQTLTwMCFBoaMLOLl+f8UfqXRF9NtSFWFsRWVfwqfd2iaIsX9HkmDal4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6935



在 2025/7/16 20:14, Amir Goldstein 写道:
> On Wed, Jul 16, 2025 at 1:49 PM Qi Han <hanqi@vivo.com> wrote:
>> Hi, Amir
> Hi Qi,
>
>> In the commit [1], performing read/write operations with DIRECT_IO on
>> a FUSE file path does not trigger FUSE passthrough. I am unclear about
>> the reason behind this behavior. Is it possible to modify the call
>> sequence to support passthrough for files opened with DIRECT_IO?
> Are you talking about files opened by user with O_DIRECT or
> files open by server with FOPEN_DIRECT_IO?
>
> Those are two different things.
> IIRC, O_DIRECT to a backing passthrough file should be possible.

Hi, Amir
Thank you for your response. I am performing read/write operations on
a file under a FUSE path opened with O_DIRECT, using code similar to [1].
However, it seems that the FUSE daemon adds FOPEN_DIRECT_IO, as Ed
mentioned. I need to further investigate the FUSE daemon code to confirm
the reason behind this behavior.

[1]
fd_in = open(src_path, O_RDONLY | O_DIRECT);
fd_out = open(dst_path, O_WRONLY | O_CREAT | O_TRUNC | O_DIRECT, 0644);

Thanks,
Qi.

>> Thank you!
>>
>> [1]
>> https://lore.kernel.org/all/20240206142453.1906268-7-amir73il@gmail.com/
>>
>> Reported-by: Lei Liu <liulei.rjpt@vivo.com>
>> Signed-off-by: Qi Han <hanqi@vivo.com>
>> ---
>>   fs/fuse/file.c | 15 +++++++--------
>>   1 file changed, 7 insertions(+), 8 deletions(-)
>>
>> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
>> index 2ddfb3bb6483..689f9ee938f1 100644
>> --- a/fs/fuse/file.c
>> +++ b/fs/fuse/file.c
>> @@ -1711,11 +1711,11 @@ static ssize_t fuse_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
>>          if (FUSE_IS_DAX(inode))
>>                  return fuse_dax_read_iter(iocb, to);
>>
>> -       /* FOPEN_DIRECT_IO overrides FOPEN_PASSTHROUGH */
>> -       if (ff->open_flags & FOPEN_DIRECT_IO)
>> -               return fuse_direct_read_iter(iocb, to);
>> -       else if (fuse_file_passthrough(ff))
>> +
>> +       if (fuse_file_passthrough(ff))
>>                  return fuse_passthrough_read_iter(iocb, to);
>> +       else if (ff->open_flags & FOPEN_DIRECT_IO)
>> +               return fuse_direct_read_iter(iocb, to);
>>          else
>>                  return fuse_cache_read_iter(iocb, to);
>>   }
>> @@ -1732,11 +1732,10 @@ static ssize_t fuse_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
>>          if (FUSE_IS_DAX(inode))
>>                  return fuse_dax_write_iter(iocb, from);
>>
>> -       /* FOPEN_DIRECT_IO overrides FOPEN_PASSTHROUGH */
>> -       if (ff->open_flags & FOPEN_DIRECT_IO)
>> -               return fuse_direct_write_iter(iocb, from);
>> -       else if (fuse_file_passthrough(ff))
>> +       if (fuse_file_passthrough(ff))
>>                  return fuse_passthrough_write_iter(iocb, from);
>> +       else if (ff->open_flags & FOPEN_DIRECT_IO)
>> +               return fuse_direct_write_iter(iocb, from);
>>          else
>>                  return fuse_cache_write_iter(iocb, from);
>>   }
>> --
> When server requests to open a file with FOPEN_DIRECT_IO,
> it affects how FUSE_READ/FUSE_WRITE requests are made.
>
> When server requests to open a file with FOPEN_PASSTHROUGH,
> it means that FUSE_READ/FUSE_WRITE requests are not to be
> expected at all, so these two options are somewhat conflicting.
>
> Therefore, I do not know what you aim to achieve by your patch.
>
> However, please note this comment in iomode.c:
>   * A combination of FOPEN_PASSTHROUGH and FOPEN_DIRECT_IO
>     means that read/write
>   * operations go directly to the server, but mmap is done on the backing file.
>
> So this is a special mode that the server can request in order to do
> passthrough mmap but still send FUSE_READ/FUSE_WRITE requests
> to the server.
>
> What is your use case? What are you trying to achieve that is not
> currently possible?
>
> Thanks,
> Amir.
>


