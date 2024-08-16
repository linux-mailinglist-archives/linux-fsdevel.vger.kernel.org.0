Return-Path: <linux-fsdevel+bounces-26151-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E15BC9551B4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2024 22:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 124311C21958
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2024 20:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414D91C463B;
	Fri, 16 Aug 2024 20:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uwaterloo.ca header.i=@uwaterloo.ca header.b="vk8S/x/H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa.hc503-62.ca.iphmx.com (esa.hc503-62.ca.iphmx.com [216.71.135.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6948D7E782;
	Fri, 16 Aug 2024 20:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.135.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723838619; cv=fail; b=NiLGrZEYONwKrre5VazTTB/miB9YAAqA+VnD7krJiIxdppNpipBDJLsnogmHJxtgKW8YIJKHdmfLGkp0BrnlCnQ/06aPv+aFdmVwixLdnm4xnS4i/PfzfETfr7bsM7RFJB+D1vwy6cF5yinegTkCiuS/CE4JGf2ws0C3wgMwrrA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723838619; c=relaxed/simple;
	bh=UJzSsKMvsuUx3McTqPHEyeGCyv3Oy7WeQnU5gj+SLAU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MTxauF3CIRHTdirr38T5/6NWNdVsQIFQ2OJBlyBPxj49kNff8wsLFifHAD9/X2GdiRh4jGLbt7rWI/xN8HRERwWKlJ2Z5nCu91NqmA48yrKgSBCuXysGDRq/Ow+avVDXlh1n4Rs6CGNqmgoMUWo9zvZHZMU+mxQGIogI5b+BhoA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uwaterloo.ca; spf=pass smtp.mailfrom=uwaterloo.ca; dkim=pass (1024-bit key) header.d=uwaterloo.ca header.i=@uwaterloo.ca header.b=vk8S/x/H; arc=fail smtp.client-ip=216.71.135.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uwaterloo.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uwaterloo.ca
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=uwaterloo.ca; i=@uwaterloo.ca; q=dns/txt; s=default;
  t=1723838617; x=1755374617;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UJzSsKMvsuUx3McTqPHEyeGCyv3Oy7WeQnU5gj+SLAU=;
  b=vk8S/x/Hd3Z+V+3ijJVoKgwyl3MAGBDy4YrH4T3V5+SP53Gr2JmVmUsO
   NcN1bZefdSvW2matXjYbZ/+DV5HtvXIHAfgujzCLubRZp1QtqpjL8EO1h
   0UH/BR1KCxQw1embrWPc9PlXGVCFM82XATrRjTiar9ZudyQrCK6nZ3ok4
   M=;
X-CSE-ConnectionGUID: JcfOu7zYToWBWV+QrVLC6w==
X-CSE-MsgGUID: Tc7gAX9EQkWqrvw21cjZxg==
X-Talos-CUID: 9a23:wOhsamCK+xnBHxP6Ewts+mkJRdIUTnri5kjuYHaiN0JCFqLAHA==
X-Talos-MUID: 9a23:CXHZfAitY9jcYWrA0panPsMpCMw37I2eWW00kqofodebb3V7OQWNg2Hi
Received: from mail-canadacentralazlp17011048.outbound.protection.outlook.com (HELO YT5PR01CU002.outbound.protection.outlook.com) ([40.93.18.48])
  by ob1.hc503-62.ca.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 16:03:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=chs8DpiA8NfXNj60Cxeg5710IhJh3nLKVX/Y6lqL6750baQ3tqJN0/dVD4DyoVLUNZ9b9M7CSOFDQTqmR9G5axh1qkCho/aakPHkT8zFnyEW1PpH/B6+cSA4lBd20Qkqq72/mbbBLi4CdhiiGKQi4L0paC0z9o9AvKJ2N9UNjUFrCzBYpSKBP2wG83IMErTBrAZyKCBoWxSZ6Dw4ePNlT/9CHYGjV4W6ce1PnDU4zDCBeEhNTm/g1xdY36gFeqEAQeXwbgz14PNGUh6yp2nEHrFgCdHSSi7sdvZsVbB82eYK+VGaz+/mn1Zhaj3xdB9rFAQLKrwVt35WD1yuEMZeEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r6GFgaJH1NJYC/+Tmg6NwZAJ5wc8Uc+I+o9yH3MllZU=;
 b=HH4Rn83hLTnDTyrPxl3zWEVEIzkzwWLDx4aLJ5gKbryWhNnuFtEyhNiCCW0NDaBxyvFl2lcUDMlgT4hhhCwYW8pGGY7pk0grM/YK4jyvrLjlOTOuqaXuiR6NU2MZj3kUyPuxUr0CH6Ccz/7AZTPPsxIVAsZeermW9gAGBJSbKWFmJ9mnHex+N1mIFfm0YpyAk9FQd/1uJkEBhjFDPALSB/iwlJrMOMswje3gJiy4JhtlxjRMPMigxu/1Cnz8K4h/Fbz0iiSKJ+lEv1kvkX6jnYnaMUoecjv/nkxukO0NdW19gAzjsHyd/BmjfBLWMFWdgHJt3mJQ0+J04hEQwoRWwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uwaterloo.ca; dmarc=pass action=none header.from=uwaterloo.ca;
 dkim=pass header.d=uwaterloo.ca; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uwaterloo.ca;
Received: from YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4b::13) by YT4PR01MB9926.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:e4::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Fri, 16 Aug
 2024 20:03:26 +0000
Received: from YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::d36e:ef93:93fd:930]) by YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::d36e:ef93:93fd:930%6]) with mapi id 15.20.7875.019; Fri, 16 Aug 2024
 20:03:26 +0000
Message-ID: <02091b4b-de85-457d-993e-0548f788f4a1@uwaterloo.ca>
Date: Fri, 16 Aug 2024 16:03:26 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next 0/5] Suspend IRQs during preferred busy poll
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Joe Damato <jdamato@fastly.com>
Cc: Samiullah Khawaja <skhawaja@google.com>,
 Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
 amritha.nambiar@intel.com, sridhar.samudrala@intel.com,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Breno Leitao <leitao@debian.org>,
 Christian Brauner <brauner@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Jan Kara <jack@suse.cz>,
 Jiri Pirko <jiri@resnulli.us>, Johannes Berg <johannes.berg@intel.com>,
 Jonathan Corbet <corbet@lwn.net>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 "open list:FILESYSTEMS (VFS and infrastructure)"
 <linux-fsdevel@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <ZrqU3kYgL4-OI-qj@mini-arch>
 <d53e8aa6-a5eb-41f4-9a4c-70d04a5ca748@uwaterloo.ca>
 <Zrq8zCy1-mfArXka@mini-arch>
 <5e52b556-fe49-4fe0-8bd3-543b3afd89fa@uwaterloo.ca>
 <Zrrb8xkdIbhS7F58@mini-arch>
 <6f40b6df-4452-48f6-b552-0eceaa1f0bbc@uwaterloo.ca>
 <CAAywjhRsRYUHT0wdyPgqH82mmb9zUPspoitU0QPGYJTu+zL03A@mail.gmail.com>
 <d63dd3e8-c9e2-45d6-b240-0b91c827cc2f@uwaterloo.ca>
 <66bf61d4ed578_17ec4b294ba@willemb.c.googlers.com.notmuch>
 <66bf696788234_180e2829481@willemb.c.googlers.com.notmuch>
 <Zr9vavqD-QHD-JcG@LQ3V64L9R2>
 <66bf85f635b2e_184d66294b9@willemb.c.googlers.com.notmuch>
Content-Language: en-CA, de-DE
From: Martin Karsten <mkarsten@uwaterloo.ca>
In-Reply-To: <66bf85f635b2e_184d66294b9@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0103.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::28) To YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4b::13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YQBPR0101MB6572:EE_|YT4PR01MB9926:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b4f876c-e88d-4630-47a4-08dcbe2e7d93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VEZQbFpBYVh4U3lsU1d5QkJNVnYvMmRVZGJUS012dEF3RU5lQnhaZHpkdXNN?=
 =?utf-8?B?dG5uTVFpK21FR2RyLy9CUUxBcHlIMko1MXdrOG1FM0VLQzFzK2tOL2Zkbzc5?=
 =?utf-8?B?ZTlRV1hpZXNXM1U0M3Rwc1k1ZGNRS3RVWEFJeWJZQ0tSUEtFdjNBaW54UFJI?=
 =?utf-8?B?aFlSOFplSVpxMlhCTENGaU45cnBlLzNFODFJVWxLL1g2dTkwYWcrRGpucDlP?=
 =?utf-8?B?d3pCdVBYOG1XU1FGY3A0bFdhRm5tczVjeWVDOHUzeklGNzh3TkdqbXgzdVZ3?=
 =?utf-8?B?MHBLUXBZZXVmT3BOeWFuVnZZQWYrekVVMXozR0NiUlBJczRCbGE1c2l3dGs3?=
 =?utf-8?B?OEl3Z3lkTTZBRzNvZXk0Ty9FeWNXOU14TldtZFNZNGM5bnlaek94RFIvOXFh?=
 =?utf-8?B?QTFhaXMxS3hRZVpSK1dlMm16bUl6TmNuaWloVUFUd25NeGhMa2VoQlk2dHc4?=
 =?utf-8?B?d25Mb0pLZzZnMlZzQ3NOUjlZUHRidzkrQnhyWG13SCt4NnArM2djR0FQd2xi?=
 =?utf-8?B?aHlpVGJqNnRXRXY4cW5kaXJ6YWRkWUs5UURrNDhBanlNUFBtMlg4OFlvTWx5?=
 =?utf-8?B?ZXFjeUE1YU8vMmEvYnZtUy91OWpla3JsV2FMYllZcUVyYmltczl4R2Q2MVZq?=
 =?utf-8?B?OUJ3MzZBb0x4UTBMN1hzMlNwUkV2ekZ2bmhlclQ0ZFdHS1UwZi9Jc2l0YXd6?=
 =?utf-8?B?NnFHRDRrNFFtd2gyd0ZjY3pLR3hlc1Y3Zm5uT052SWs4Z28yMW1DLzBTclNa?=
 =?utf-8?B?WWQ4TjZMem5ESjltdzBwMkJscVQwMEk0WnBxcWk4ekw4VTh5a3I0aGs4SHRy?=
 =?utf-8?B?aEVvdnRUelowL1N5WnJHK05wKzNkV0dieU5ZZDJEV3g1a1lUcldTUjkvcEZR?=
 =?utf-8?B?Nk15K1N2dURDbnpWd2VkNUVKMS9CTVp3aVpBLzIzQUtiRU13bGNTRmU4M3l4?=
 =?utf-8?B?TERsM2xKZTdXbFp4cTJCTFhwd1F0N0YrRS83b21Qb1k5d3RjWnBQTU02KzVH?=
 =?utf-8?B?YkxDK3g4d2t0RzUrNE51aFBGRjdlSkI3WlJVVEcvMlVFdVkzL2tvcEJKYVJn?=
 =?utf-8?B?MmpsUVl3bFk4UjE0TnhDQnNpZTlwOU9MTTB1SHo3MEs1Mmg5VFZsbzZuQkpx?=
 =?utf-8?B?VlNDRys5MFpSNW10dHVzSW9PZFNrejlUanJ1QUt1UU1xTFpNWVdRWDFnai9K?=
 =?utf-8?B?U29tUXhvb0Y3VGRObkRvSFpUa1VUTGpSdTRlRWR3NkZyNTdkK21NMnVBV3Fq?=
 =?utf-8?B?VjVNR1ZqVFFqUmRmSWF2ekJUd0NkeUhUNEZ4TlBUd2xHaU5YNWcvcFA1MlZ6?=
 =?utf-8?B?MmpSY1lMYXdFdG13aU1XY2svOGlBeVkrWEpwQTZoY1F4ckVxVFY3WlF4Z2JJ?=
 =?utf-8?B?blVTWFMxL285aFZEc3VTNG90L3R5MXB2U2pDRkF0S1dBL2MvcEQyZWRBVFhB?=
 =?utf-8?B?ZG1uNExBYURqWU1DSjdLK3huOU95YlZ5RWIreUQzZTdTVTJESlV6MHpuaTVu?=
 =?utf-8?B?QURCemlVbEdYcVNHSllnN1prejEyRVNtcjJQTzN1U2dldEdIeTVjc3gyYXQ3?=
 =?utf-8?B?SnpBTExBWlIyUmtTS2lob1BnTTc5STFGaVN0TlBNbEVxQTRnMWpEeTBWMUhz?=
 =?utf-8?B?Q0Q3Z0ord2lWVGJKd3BVd1d0NEM0WkJsTjl1SHR3VDNGaThGd0wrVm1tTzdl?=
 =?utf-8?B?Q2dHSmh4ZEpnY2JxUkpOWmlGeDh5aHBWL3h6OUtmeitaRTZXUmFTeHRxMEgz?=
 =?utf-8?B?RTJadkJaeTBTQVptdE43OW5SeXZ2VmtOdVFSalZkVXB5TE00dVh5QXA2MFR0?=
 =?utf-8?B?QkVoRGE3dDA2d0xlaDNJQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cklaajN0WmFEWFFaWmk2NXRGTXlzMmpOMVZXOUJtUi94ZWZlSU0rQk15RHhW?=
 =?utf-8?B?T3pzYVhaTFBQVU1ISFhUbkJZTlo5b3lmUDk2UHdnUGFVdFQ1UFFlU2s3d3NR?=
 =?utf-8?B?alAvOEQ0QStrZ0FyUklESWs0a3ZkdGgxN292V2FRSnRWaFdLOHFCWUVNSGk5?=
 =?utf-8?B?eVdtNkJVY2tBaWNuOFlSSEV0bjVSa2FPQmMra25jcHhmWG0vd2NWeU8xNDhn?=
 =?utf-8?B?b3Q3K3JVcjkzMzJmRHd0cjRacjFzNUJLTXpoQW1XZ3dhVldNUnZqTTVYVDU3?=
 =?utf-8?B?amJ1OStBM0NEc2xyVGlGZnkrZ1dqNjZpVTZZcFZwUzRmNG03emdtcW9xV2ZI?=
 =?utf-8?B?VUZONEVCQTQwQ0VXYUhtUy9zRjlVQUJ5SlZmMTg1MnJoSkZNOUQxSUFLc3V5?=
 =?utf-8?B?RkdadWpIOENITEFVcGxTVTRIUTRPRlYxbG8yVWNYNU0vWTRlMDVmaXVweFRX?=
 =?utf-8?B?WVY4SnU3NUtSMmgwTzMwQldnS1FaZHdmQWpyRW5mekRnOWoySk9BNnp4Q2Vj?=
 =?utf-8?B?T2hjTWhiWFlrMW44cnd6Q3h4cDA0RExQaVRjeHQxSDVUdG9rRlkxZTl6L2o1?=
 =?utf-8?B?RERDaUYvMzd5TVBwT2FxL3pQY1B4VE9zdmxnNmxmaStXU3YvcTNqRkJnOTZ1?=
 =?utf-8?B?aXJ2V0hRaDB2TTIrcTdqNTQwR2J3Z3lIRy90aWwwZnNybmpkbzNmclZkbzgz?=
 =?utf-8?B?TmkwaGdVbFFyS2RkUUlBSG05bDNnVzdwS1FhZFljMTdGZTd4Qi9QQ1pMRzd1?=
 =?utf-8?B?T1VBS3pFOTcwQlBFV1dIME9jbkw5eFhOZDlScFdMbnhkay9Vd1ZkSWs1bVBX?=
 =?utf-8?B?Tk9WZStVN2VtakFTbEJHVUx5MjF0SExaNzVWWVRQK3JUWWorK2lEVTI4NGM2?=
 =?utf-8?B?VEIzTmh0TnBrT2ZHOHhNUjNrenZzcmcwQWh1akJYcmRKek92TTFxRjY4a1A4?=
 =?utf-8?B?aWhnSEEwcTFNaTZKZmZES0dxQUVCNC91cVJTVHQ4dTE2WW1CSXdPYUk2Y0g3?=
 =?utf-8?B?aEs4LzlYUVNNWVMvMjUvZWQvMVlVVWtSZkE0YmlNdTBzSkMrcVpuQ2ZJNEdl?=
 =?utf-8?B?SXAwU2tpbzhzUFlpMnkxTjY5KzVhVXpOV1p4LzRiVXNyNlgzS1pPU3NZRDZz?=
 =?utf-8?B?ZmtxaUFuTUNOS09xSjZZOEJ4YUdtR3ZXc3hHZWZMYTdmWkJWVnM1Qjg2VFh6?=
 =?utf-8?B?dFhMS0lpeXMzNUw4aVc4KzZLdlA5eEhQWHFLSWMvcloremRNblpDMG1YVTBT?=
 =?utf-8?B?ZjdPYldVY2kzR2l0bWNIOVhBTjVDOHdFU2dqa1YvVXBoU1gyWXhzdWJmUVR0?=
 =?utf-8?B?RzZybWVpTWJyNEgwZ09LNU5oNWRnTTY5QmNsTzVyUHM1YTdObDVFOXRtd0Zn?=
 =?utf-8?B?QnNoMFhIenlSK0J5OWhTSlZsN2FGNVhjNXRkNVNDaEllVW52VWJpaE5vWW1l?=
 =?utf-8?B?RmxlMXFiMGZaM1Qvd3RXVzBlN2drUlFBZXJ5aURIdVR3OTFqYzlpczhtNlc5?=
 =?utf-8?B?Q0ZDTTFvamExTnZVVDFTQmtLTCtleXlYU0w1QzJUMXJnd2thUEh2cFB2ckhn?=
 =?utf-8?B?RlFyZFBHSytHdGlsbFdoQ0duMFBBSS94MnpmTWw3L2NsNTk1OHB6Si9aUC82?=
 =?utf-8?B?bmZjeUFvNWN0VWFnbCtUTkJZemIvZDViUnBMeklnUjV0cVRmTEErNEVnT2Jk?=
 =?utf-8?B?dVBLcU1tWTRNRjJGUzkyZWpDdlhYUlNUZ0NtUGVHazNhcjVkdUJMNWp3YThm?=
 =?utf-8?B?S3NtQnM1Uy9PZXo3L2o0ZlpTWVhlaERjOWhkaXZnM0NhY3lxcmkyWmtyN0xZ?=
 =?utf-8?B?SE5IZFNHLzhXalJ0akk2aGZIUVMxR3pXcDVIMEp1LzNhU29DU2hJUmJvSzdE?=
 =?utf-8?B?SXBOcUlHYVd5UTlJbnlNd0lmL3FidlZvMTUrOHFZL1VGOUJtQXpZT2YwVUU4?=
 =?utf-8?B?SjdGTzRQSG5mUEZvNHphcmFUUEtVZ01QRlNkeGI4Rm1TU0YzL2MxL0VQNjdC?=
 =?utf-8?B?K21wVFNOK2t2cjZ1Q2crVDhxUlQ3WkxydTc1dThKazhZTzg3R3lwZjZNR2Jn?=
 =?utf-8?B?VkVvQXlJd3UrSUNWVXdIUTlLOFJWdDQ3S1lZYU9QdDNEVm5sUVc2ZFhjMFZx?=
 =?utf-8?B?cUlHcndpdFQzdVQ0b2J5M3A3eXdLdmVUN1N2dENnMDVab1loK1VrbDVOWGJD?=
 =?utf-8?B?TGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	th8gvMndEP9rdlGrwFWDV3Gl5vfI2p++oHlNdDb0nJoWuAdn8AvwW2GgGO6jZUHAzhkM3Drgv0z7BDAQ1YNkuMEhvGhf3snXuFn+JlK0ooxMNPz/78kXimPCUAaGpJSInxBsz4sbYqhKNuOXhxBqdXB5HjPYKHuZJG5N3b3bxkryhQmVEEbUSa1ZeAYCj67ls7cH4/J9rkwhdaYZJNrNXB7ipSKlzkeRl0BF4wBnKZZAd3eR4X2jhF/qYYeWOCG3F8hc/1u5UIQwIaowXD/yDzRNa5BVhdPpF1sXbQmMgESVEaGoENbIlm/7adiucWWRllOE/x+epIaP2QxC1hN1PF/8/6mb1MAIROHUN7h+Y7wRMYVJMp797HTjLitpPBbDymX4KVFdyIDlze8LKp3swukIVbR6L4kGFxewV91hNVX3vUMo+50I8u+lcXCqkSg9kk8AJE+BgVhXE4WZOiCWkzmLQrcZ8KfWVziRyr3+3kahw7iFNs7XKDUvL7LYqAQwPUfyk3YHqYgqc+4IL8KYTmyB+qGFk5uB0OCBR1K/FgAU/Et+EbVNuJgWUB9aySWYIFWzJteq7YtyEwHe0pEsNJQ3ACsGMqgXEhxz60XnMljE7rDsinroDACfFaUFIMKY
X-OriginatorOrg: uwaterloo.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b4f876c-e88d-4630-47a4-08dcbe2e7d93
X-MS-Exchange-CrossTenant-AuthSource: YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 20:03:26.5643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 723a5a87-f39a-4a22-9247-3fc240c01396
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GmRdF0v4M9Kyb22147Xpiwz3LQT38rTXGkJ4GEBxVrRsKNSKbhGZLIEQRswr3/U7p3HOh8KvhWNS8QDEt79GlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT4PR01MB9926

On 2024-08-16 13:01, Willem de Bruijn wrote:
> Joe Damato wrote:
>> On Fri, Aug 16, 2024 at 10:59:51AM -0400, Willem de Bruijn wrote:
>>> Willem de Bruijn wrote:
>>>> Martin Karsten wrote:
>>>>> On 2024-08-14 15:53, Samiullah Khawaja wrote:
>>>>>> On Tue, Aug 13, 2024 at 6:19 AM Martin Karsten <mkarsten@uwaterloo.ca> wrote:
>>>>>>>
>>>>>>> On 2024-08-13 00:07, Stanislav Fomichev wrote:
>>>>>>>> On 08/12, Martin Karsten wrote:
>>>>>>>>> On 2024-08-12 21:54, Stanislav Fomichev wrote:
>>>>>>>>>> On 08/12, Martin Karsten wrote:
>>>>>>>>>>> On 2024-08-12 19:03, Stanislav Fomichev wrote:
>>>>>>>>>>>> On 08/12, Martin Karsten wrote:
>>>>>>>>>>>>> On 2024-08-12 16:19, Stanislav Fomichev wrote:
>>>>>>>>>>>>>> On 08/12, Joe Damato wrote:
>>>>>>>>>>>>>>> Greetings:
>>>>>
>>>>> [snip]
>>>>>
>>>>>>>>>>> Note that napi_suspend_irqs/napi_resume_irqs is needed even for the sake of
>>>>>>>>>>> an individual queue or application to make sure that IRQ suspension is
>>>>>>>>>>> enabled/disabled right away when the state of the system changes from busy
>>>>>>>>>>> to idle and back.
>>>>>>>>>>
>>>>>>>>>> Can we not handle everything in napi_busy_loop? If we can mark some napi
>>>>>>>>>> contexts as "explicitly polled by userspace with a larger defer timeout",
>>>>>>>>>> we should be able to do better compared to current NAPI_F_PREFER_BUSY_POLL
>>>>>>>>>> which is more like "this particular napi_poll call is user busy polling".
>>>>>>>>>
>>>>>>>>> Then either the application needs to be polling all the time (wasting cpu
>>>>>>>>> cycles) or latencies will be determined by the timeout.
>>>>>> But if I understand correctly, this means that if the application
>>>>>> thread that is supposed
>>>>>> to do napi busy polling gets busy doing work on the new data/events in
>>>>>> userspace, napi polling
>>>>>> will not be done until the suspend_timeout triggers? Do you dispatch
>>>>>> work to a separate worker
>>>>>> threads, in userspace, from the thread that is doing epoll_wait?
>>>>>
>>>>> Yes, napi polling is suspended while the application is busy between
>>>>> epoll_wait calls. That's where the benefits are coming from.
>>>>>
>>>>> The consequences depend on the nature of the application and overall
>>>>> preferences for the system. If there's a "dominant" application for a
>>>>> number of queues and cores, the resulting latency for other background
>>>>> applications using the same queues might not be a problem at all.
>>>>>
>>>>> One other simple mitigation is limiting the number of events that each
>>>>> epoll_wait call accepts. Note that this batch size also determines the
>>>>> worst-case latency for the application in question, so there is a
>>>>> natural incentive to keep it limited.
>>>>>
>>>>> A more complex application design, like you suggest, might also be an
>>>>> option.
>>>>>
>>>>>>>>> Only when switching back and forth between polling and interrupts is it
>>>>>>>>> possible to get low latencies across a large spectrum of offered loads
>>>>>>>>> without burning cpu cycles at 100%.
>>>>>>>>
>>>>>>>> Ah, I see what you're saying, yes, you're right. In this case ignore my comment
>>>>>>>> about ep_suspend_napi_irqs/napi_resume_irqs.
>>>>>>>
>>>>>>> Thanks for probing and double-checking everything! Feedback is important
>>>>>>> for us to properly document our proposal.
>>>>>>>
>>>>>>>> Let's see how other people feel about per-dev irq_suspend_timeout. Properly
>>>>>>>> disabling napi during busy polling is super useful, but it would still
>>>>>>>> be nice to plumb irq_suspend_timeout via epoll context or have it set on
>>>>>>>> a per-napi basis imho.
>>>>>> I agree, this would allow each napi queue to tune itself based on
>>>>>> heuristics. But I think
>>>>>> doing it through epoll independent interface makes more sense as Stan
>>>>>> suggested earlier.
>>>>>
>>>>> The question is whether to add a useful mechanism (one sysfs parameter
>>>>> and a few lines of code) that is optional, but with demonstrable and
>>>>> significant performance/efficiency improvements for an important class
>>>>> of applications - or wait for an uncertain future?
>>>>
>>>> The issue is that this one little change can never be removed, as it
>>>> becomes ABI.
>>>>
>>>> Let's get the right API from the start.
>>>>
>>>> Not sure that a global variable, or sysfs as API, is the right one.
>>>
>>> Sorry per-device, not global.
>>>
>>> My main concern is that it adds yet another user tunable integer, for
>>> which the right value is not obvious.
>>
>> This is a feature for advanced users just like SO_INCOMING_NAPI_ID
>> and countless other features.
>>
>> The value may not be obvious, but guidance (in the form of
>> documentation) can be provided.
> 
> Okay. Could you share a stab at what that would look like?

The timeout needs to be large enough that an application can get a 
meaningful number of incoming requests processed without softirq 
interference. At the same time, the timeout value determines the 
worst-case delivery delay that a concurrent application using the same 
queue(s) might experience. Please also see my response to Samiullah 
quoted above. The specific circumstances and trade-offs might vary, 
that's why a simple constant likely won't do.

>>> If the only goal is to safely reenable interrupts when the application
>>> stops calling epoll_wait, does this have to be user tunable?
>>>
>>> Can it be either a single good enough constant, or derived from
>>> another tunable, like busypoll_read.
>>
>> I believe you meant busy_read here, is that right?
>>
>> At any rate:
>>
>>    - I don't think a single constant is appropriate, just as it
>>      wasn't appropriate for the existing mechanism
>>      (napi_defer_hard_irqs/gro_flush_timeout), and
>>
>>    - Deriving the value from a pre-existing parameter to preserve the
>>      ABI, like busy_read, makes using this more confusing for users
>>      and complicates the API significantly.
>>
>> I agree we should get the API right from the start; that's why we've
>> submit this as an RFC ;)
>>
>> We are happy to take suggestions from the community, but, IMHO,
>> re-using an existing parameter for a different purpose only in
>> certain circumstances (if I understand your suggestions) is a much
>> worse choice than adding a new tunable that clearly states its
>> intended singular purpose.
> 
> Ack. I was thinking whether an epoll flag through your new epoll
> ioctl interface to toggle the IRQ suspension (and timer start)
> would be preferable. Because more fine grained.

A value provided by an application through the epoll ioctl would not be 
subject to admin oversight, so a misbehaving application could set an 
arbitrary timeout value. A sysfs value needs to be set by an admin. The 
ideal timeout value depends both on the particular target application as 
well as concurrent applications using the same queue(s) - as sketched above.

> Also, the value is likely dependent more on the expected duration
> of userspace processing? If so, it would be the same for all
> devices, so does a per-netdev value make sense?

It is per-netdev in the current proposal to be at the same granularity 
as gro_flush_timeout and napi_defer_hard_irqs, because irq suspension 
operates at the same level/granularity. This allows for more control 
than a global setting and it can be migrated to per-napi settings along 
with gro_flush_timeout and napi_defer_hard_irqs when the time comes.

Thanks,
Martin



