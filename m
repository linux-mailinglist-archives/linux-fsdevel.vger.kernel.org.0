Return-Path: <linux-fsdevel+bounces-72064-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AF9B1CDC944
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 15:51:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 97B583088864
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 14:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ADC3361DB9;
	Wed, 24 Dec 2025 13:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="dR75wlmt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020112.outbound.protection.outlook.com [52.101.189.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024BF361DB0;
	Wed, 24 Dec 2025 13:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.189.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766584344; cv=fail; b=TVT38VxEVOSfSXfBU6ZHAhtVdDIBQsMXsZmQJKEGYnfVG3jLVr3o88YRJJhcwp7TlNf8BuaK2vXKrf/8XWqp0YO2y+wiK1Om6JFRkiVkMitigoIx9w8udXPN4yJbJKvlKdFzm/vZCgAEqEcVwMwHIFt+vBvLNOUBnVWjfZXCuus=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766584344; c=relaxed/simple;
	bh=m83aLlHNWP7rx6DKIyAGgop7j3BYIK42h1+F7HdzKOI=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ri6SCnEmMhkjNHVh9JhjHhlfeEcqQRQUPVeXDDnyePL+QEAeyPI3a/x3XXoBoBDZ9NidqrM5K71fDuEyLq+AXga1zFT15eaHBipwgGXQRXu3C3tNiy6AiCyU88KP7enVPJFzo5ZD4TXIc11rW2oK7rrAQIEdfQZ22o+cEMuM4hw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=dR75wlmt; arc=fail smtp.client-ip=52.101.189.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vFEkTzvCUhOMFuwXiiL3LfQFPwCo7JhgPN+ZQPvxBuV2XNSmlpsE9r3NW55ecKEKNexQxZN2cc+KpzSb+xiQVLYDfN0iTfdTc2AWzpXx+cPevHbOVOxlDUXRG+fvPoDYfD8fQmh5B/MwTTmJiQojUnpcRIl8Tyx+LXP/WuARClx+FJTmr/kGjlsuvlo2AP1luQzrbkbRMIH2fMJdz8Zua5k0WnXMAgZasDAl1xZwp6604PX3fTSdaZpYata7UctSBMuKmWKxKDfL6c/abQ8DDYgm5Cczhw/A22kBM6ZQxvnYcpDcIsgMwkBoXkDYgsFmR/7aBZWNXbxTyDi6PkTdyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cb/5Mlucnwq4Fl1N/Y50Y29hkTN5lMT6zBWJRjuV9S4=;
 b=dhh7YB6iq1tyEjS6SGDpE9xvDXuGa2rOfKfVTtwhYh5cWa9O5FUtJkGBjXKTY6bSY708Tlix6WQe/Hu2ux4uEtq6rSBpxI7aQOHmddRgYSbfxIhBjyJvVE4GfnjgjOHJG/biOaWVAf3zDg+v88qC+pMj3ir9ZWcb6992KCRdhJ4CsW/+B71oHUS/QgdoHE7xEUmTjlzyBC9IfE7KjdnEPhZRhA19Sbwpi6fECxGLrAkymtrjqqaFCr00wc2Pio6eqKkiUpOG2iYmzIgEYOIwaVWa8vUR0v5lgHw0wAw28BNXGSz3Xxt3uVrCAh+8nPwJgE8HWXBlrkwL3vpzlem55w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cb/5Mlucnwq4Fl1N/Y50Y29hkTN5lMT6zBWJRjuV9S4=;
 b=dR75wlmt4vA9fUS5GgjeOsEH+54Ed7lIo5MX6wYPeI/X2vwr4DtfsBU98lY+NdNu1e4mnKbSbdQxdyuryHhp+SVPiAhV6iOnedHyXdSOIfZghXJi5Kzfz37RweQsWRyQrvkfTSinJvZa4QFNaaNOoGl+Gx6sPeFXu4jjLE+2VtfOR0oXZE8P3D9IouXvh4ROZJdUGhV5Hs5kvJHYWvCi9GkjJK354MrqDah2FIIKmiwIfxBnl5Ny0i66WNyAsi5POoamSpG+CNQmIzpdYs73Op7R7hRMyRiLSjx8XAQfelOQ7dpqNmOy4i3VQpD3FJ0kf+4LHcr69BCY9vclvz/FWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQXPR01MB6219.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:2a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Wed, 24 Dec
 2025 13:52:18 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1%5]) with mapi id 15.20.9456.008; Wed, 24 Dec 2025
 13:52:18 +0000
Message-ID: <4b221d91-84f8-4600-83b6-a2aa16a02c57@efficios.com>
Date: Wed, 24 Dec 2025 08:52:16 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] exec: do not call sched_mm_cid_after_execve() on exec
 fail
To: Jinchao Wang <wangjinchao600@gmail.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Kees Cook <kees@kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>
References: <20251218032327.199721-1-wangjinchao600@gmail.com>
 <aUvYMRmkWXUuuWXW@ndev>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <aUvYMRmkWXUuuWXW@ndev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0108.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::7) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQXPR01MB6219:EE_
X-MS-Office365-Filtering-Correlation-Id: 989976e1-f7b4-4fa2-33fe-08de42f3a71a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VGpZVzlEZ0x5dzZCSFFHU05KR2ZQWHM3dW1NNG4yNmVod3BGemNCNXN3MVRR?=
 =?utf-8?B?QkVUazhZdUNoQXVmTFRlWkU5VStkU1I5M0FsY3RncytGRlhESkZzTS9UamM5?=
 =?utf-8?B?bmV0WU9JVkhjY2lkZzBsZFM4VlE1K2tEMnlHYStZckZhTzNQeGMzZE96blRK?=
 =?utf-8?B?YVk2U090ZWhhaEJOc0pZem5kaGFHSVVxRm1XYkV2UlZsbm9FTHE2ajAyVkxW?=
 =?utf-8?B?R0p6cHRUd2l4ZkJwd3hoc2ZXdTNxT1B1K1ViWVZUblRqTTVYZy9mSkpCcGNO?=
 =?utf-8?B?SkxNZG5pOHVaZFdCcnppU1F6UWoySlcyenNBcGlJU3BjS21PQzN6b3lmUGs5?=
 =?utf-8?B?b0pqd3V2SmhEai9UdFBkL2o5ZjlaOUdpVGx4YktEZUxZQkpyL0dmUXpRTFRS?=
 =?utf-8?B?N2ozOXVrSnRVcjZjY3I5RG5WcWJTdnZTRmlwTDFZZFNyR0pEWnN6Mmh4TG1s?=
 =?utf-8?B?OUlSYTByelhVTXh1SUxLNVJRVTlMRXBwYzluMmFLU1RQa0E3UWFTcFZXUzdO?=
 =?utf-8?B?R0R5bWF0RUttWmJUUjJWMWRMSHdGWnRTczY2N2J1SmxRNFpXOThkemx2cE9h?=
 =?utf-8?B?MUM4dWlYSlJySExmNFJRVDFQTXhhRjBrbU5Rb1ZSUnFmRkM3eGlNN3IzMVlq?=
 =?utf-8?B?UGJiZGh4eUc3M2g2akxCS1J4bC8xcCsrR0IxZzFUeVJuQkxJb1daQ28xTFY5?=
 =?utf-8?B?anhJWGRvWEd3YkNVVWNFdENvZ2JRbzdxN05ZdTNvclhlNGw1SGd0VG14N1JB?=
 =?utf-8?B?UkFyZDYva1BIRXNQOXk3MzVSYXdOd2RadVpHRnZjbmF4dTczaHFlLzhpVUln?=
 =?utf-8?B?QXVrQ1dUOWdab3BYY1gzVVZqclZaU1Iwb01HSk94aUU4UFhtdHNQK1NMd291?=
 =?utf-8?B?TzhWS1R6OS93MEdzbk5RYWd6V1A5U2JSMFNJNzRmVEJ5RXYyZlFSMTdabUgr?=
 =?utf-8?B?S2xaVU5YZkJ0WDZTYWVEdEYwSDdRdC9wNlN0UTlhS01HMjkycXNOTWlsY1pt?=
 =?utf-8?B?ejVBd0RYakpEV1dHR0ZNVnlkNTQ3K2U0T3JMR2ZjN0dzcVk4blJaQlhvc2ta?=
 =?utf-8?B?Y2N2Qi8wYWdUaTUzT0EvNTZLcGdaTUJyQVhMWG50cTVwcmkwYTVEcGpjRUZX?=
 =?utf-8?B?dVhpeFlveDZ2b3FDWDFDQlcvUU1hVHIxNDYzM1pEUUV0Ump5Um4rUkNneXlt?=
 =?utf-8?B?ZjdyamVMaWxnbVZZVUhaZkFISVJuV1MzQzh1ZlJ6d3c5blY0d3o0UUxOTU5v?=
 =?utf-8?B?UFIyRk5zaElpczdXN2IrVk1hSXY5bldmakdCbGlhVlZFbEZySE4yOWtqRU9m?=
 =?utf-8?B?d1I1N2oxb2NqSFZ0aHJWM1RLV2dyVWx5Q24vYXhGcU45OFBFS2ViUGxsb3lQ?=
 =?utf-8?B?TXp4QXMyRFJrZHllSkhQNGthcytueHQ3T0t2UytNb3dhSG9VYWwwdzdoa2JD?=
 =?utf-8?B?dkFGMG9GeFR1dERqaHdMaEs3TUlzeGRKUTRZazJUa3hiZ09wUTI0VWpGZW9s?=
 =?utf-8?B?VGFaSm1KV1lDdmFwei9aV2ZNSlJ5Y2pIQXBETit3cEVISm1wZVdmMnNWKzFi?=
 =?utf-8?B?OGJyNUdncjM1cGptbExhbjlRTU1hY3NTK2NBeUlqNnhFbE94b0ZVUkNZemIz?=
 =?utf-8?B?NWV6K2xJRFNIcUNHYk0vd1JUcURCRFp0VmU4VWwxMmdqTFNDaXpBME9IUDdN?=
 =?utf-8?B?OGsyTVBZUEtJdGlJYnloTnJhdmRUWEJWU1E0b01IcHNKbTVKb0lVWW8rV0VS?=
 =?utf-8?B?UG1hY0VmbFVZQnFaZWVKck03NE9QWUFmc3RKanlIbDJHUDU5dWtJZFhDZzAy?=
 =?utf-8?B?YkkzVEYrTHk0WEsyVVowTXRTMW1UVEdzWnAvTStXYnczV1AzdDcyK2tZYWxG?=
 =?utf-8?B?RWpUQ0NlWU9YNW5IMThwZVZyc3VOTEViMUZ0ek1rSzZ6eWc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a21FSGJ6eGoyVS9tR0lCWlJGeVhkbmFUSTNSa2dkK2xyRGM2VStocTJiakxI?=
 =?utf-8?B?OWk4ejQvcGJ0ZFJobFhqOGt4aS9XOWZmbWFDTW1oNE1rTm9meFZOcFJMdkFW?=
 =?utf-8?B?azFOQVJCeElaNURxQ2I0VmNKclQrTmV3VUZIRGMrc1hucDhJMDVpay9BNzVH?=
 =?utf-8?B?Ti9Wa0dYUGZKa1NqTDJMMUtRUEtkbytra1BtM3ZLNHRYMjRzQldZci9IbHla?=
 =?utf-8?B?THBMdHZIa204QW1jYlJEdWFhT3k1YWNQQXROV0s2eUVBYlozWXllblE2TnUw?=
 =?utf-8?B?YnVpYWZMN1BOYlg1cUozWkltQzcrbkRWODdZYlIwb3ZZMFYyQWwwWWRJN3RJ?=
 =?utf-8?B?NVIrWlhXTFRvVlg4OXRDQUZLTUtZZWxmVzVqTWZkakpwRi9QeGQwaXU5YkZL?=
 =?utf-8?B?ai9lMjBrQkx6LzJBZUdYMkZNcFVhdnluUTh2SUdUamN1Zmh1ckhzSkdqbW13?=
 =?utf-8?B?QXJHeUpYZFc5Vnp4aThEVitTUDBuczZFRjh2Vk9HTCtodkJqRW1zVWRtNitk?=
 =?utf-8?B?K0ZuSnlweEVrTEpVakpYL0E0K1ExUGhEaG9yNGxFRWtBc3I2ZTdWUG5kTDQ3?=
 =?utf-8?B?YVJkdG9kdHZCMis0ZlY3b0k0ZmVmZDR4NnhXQm54Z0ErSWZ5QTFrTXhwbk11?=
 =?utf-8?B?R2tMVkpMVmNVczZnb2szSTVkbHVhRW9qZEk1WitoOVVZcDN2TG5jZUFwNHZx?=
 =?utf-8?B?RTN0RWZEUG1yRDk4OVJwbGNWUTFadlROa2NMWVZaZWVkTTQ4SnlXUHBNODlO?=
 =?utf-8?B?L2pXUDVBS3RLLzJJSDMvT21ES3RRMmduSGtFNmp3QUl3M0p5T1Fjb0s4djMx?=
 =?utf-8?B?ZXc5MjJtbnVQKzBYSTRrcitwVWl6QURmekU5MURqbTlTWVg4MXBNY2RmUmw0?=
 =?utf-8?B?NDdWSTFXR2ZQdkY3VWNjM0dZSUc0NjIrT3BwYjNLVG9vbW1YSjl3WlFUTkF5?=
 =?utf-8?B?N2ttSG0vZCsvTCtlQTh5dFFIWEtEclRQWXRPekxBU1d6eGxUQzRjNUlsR09P?=
 =?utf-8?B?dTg4Z1hSNVRYbVlZaE5mQXpZZTlUbDVjK1ZBRHU1NDMwQlpCMFFTc0dJN0Ja?=
 =?utf-8?B?eHhrZFlHWHE1Qjd4K05RU2FYV0lyeEIxaTFXV3NBZXZHekhlKzFDYnliLzlx?=
 =?utf-8?B?aEtQVlU0eWNIT3dqNUJYaG1xRE9jVlFzUm1PZFBpamdSZ3g4cmNDWDk1T1FY?=
 =?utf-8?B?VWN2NWErWlg1T2ZnOGVScnRRS3drVm9oY3NBdjRiQzhYN2xwbkdUclIwTk1F?=
 =?utf-8?B?QjlPMFVpS1dkUGRMQXRpSmlTOSswOFZqQXJjRXZKeEVWbDdSV1djWmJoNGFY?=
 =?utf-8?B?NXFsanQ3OS9OVmRzQVZOcXNJRkRieVMwelNTOGlCQkJ1N2tFcDJCc1hsM1Vp?=
 =?utf-8?B?Kzh5Vjc1aHdqdVNSNGwrZXB4blFBdEVWblJVNnNBR2NNck9OTnAyTjBCcitO?=
 =?utf-8?B?WDlWZjlaZndabkIrU1dhRTJHRVh0MklCQ1MwUnMwblZ5cUFnTDBiWVA2SXdT?=
 =?utf-8?B?czNsODJhVGNUNjN4bkhISGxDQzJuelBvc0pPQzZRTHFUQVZzQVJXQ0RvWi8v?=
 =?utf-8?B?RTBtZHVVcmNzMmE4VTUyRHE5RENRU0tBcDdrM2I1NFpVYXBDVTB0MlZqSFJL?=
 =?utf-8?B?eWhIRDBzRk1mTDRLWGp0R2dvZHRhK1ZDRnhBWTh1ZkpnK0xFcFdZRlBsOEpB?=
 =?utf-8?B?T1kxckE2MFZ6bXIxYWJPZjBsZDNSL3ExVXQxQ3VlWFQ2bWQ0YWJiL0ZlTTUr?=
 =?utf-8?B?SGthNExlV1JVNjVZanFsTXpFQnJodzE5ZC9rUGxJdlEyVzVqRSsxVXU4T1NI?=
 =?utf-8?B?Q1BSSXZPclVCWERsTS9GaEJuY042emdTUUdaTEdjNFdJaVJuZzJYM1NiYVRY?=
 =?utf-8?B?QUxpcWtrTC9JdmhKUGxNdVErU2ZVZU8rVEZabXZ5VnBjYnhvRGNEQ1NYdHVw?=
 =?utf-8?B?MysrWitEQ21TUGsvNDVrOUVEd0duUWh5MVhZVXJmc2RyLyt5R3FCUTM1NVU0?=
 =?utf-8?B?UGFwY2E3Vm5ORzRGRXhGTWYrWmJtUFF5dDArN0RpNXdKd0pCMjdZZVNXYXh2?=
 =?utf-8?B?OU1qbkxXekdoYmhzbDV3VGZ5cDJpR3h6UitkV2FuejVtQ0dTZlQzOU9xS3da?=
 =?utf-8?B?OEhKVVdOSXA1SXJ6Rzd3SXRtWWJKbVllbXVSQitsZEdpUjJKREVBMmhLVFh6?=
 =?utf-8?B?Vy80Y1dNVEZpb1pQeUoxMFpwZjJuM1UyLzNOOXdkVFFJbmZ0WG9QWjdoT1Yz?=
 =?utf-8?B?MFBqdGUxNFdleU85YS9RMnNSbDQ3enFUTnpxcXhLaE05SzFhaUtjMVp0WUJt?=
 =?utf-8?B?UWFRdUx5Vnd4a0dHMzJFR3pXVGdVMEp1T3orV2VJaEhCT2UvRUZ0RFQyMGZF?=
 =?utf-8?Q?YzS8h4gDeL/Amzh4=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 989976e1-f7b4-4fa2-33fe-08de42f3a71a
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2025 13:52:18.2466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zZ6KWp/Cr9dj7kb1aFeP4bTI7DaoNe4u0+1WbilBShFu5J80+yj9+XJYDRMvqv6RvgZGHGKK7RKou1KBdCkoPxuM01wlVJZjUcAYa2HDvdw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQXPR01MB6219

On 2025-12-24 07:10, Jinchao Wang wrote:
> On Thu, Dec 18, 2025 at 11:23:23AM +0800, Jinchao Wang wrote:
> 
> Hi, mathieu
> 
> Please review this patch for mm_cid.

Nack. Your fix lacks context and removes a needed call in the
common case to fix what I understand to be a init task issue.

See this patch instead which addresses an issue very similar to
yours removing the relevant sched_mm_cid_after_exec() call:

https://lore.kernel.org/lkml/20251223215113.639686-1-xiyou.wangcong@gmail.com/

I added Thomas Gleixner in CC.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

