Return-Path: <linux-fsdevel+bounces-26200-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B4E955946
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Aug 2024 20:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EBA7B213BE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Aug 2024 18:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22737155352;
	Sat, 17 Aug 2024 18:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uwaterloo.ca header.i=@uwaterloo.ca header.b="rgn6K6Mp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa.hc503-62.ca.iphmx.com (esa.hc503-62.ca.iphmx.com [216.71.135.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A027BA50;
	Sat, 17 Aug 2024 18:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.135.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723918539; cv=fail; b=bVOHbppHvNeb3KyWbcAnhmc6xm4f5bQM74iHxIvH7Z37pBiLx5yfsPleSj2VoHFjE7TBdPfXlA3+jLRtthgoqkzFUutRvyEBLhVIhMala34a/2vGqA4LQoy4ccbA9k3gAAn86029LeI4ETaetW9U7L4YvfgWzOvtJVkZCLFs9JA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723918539; c=relaxed/simple;
	bh=IpkTsMMXh1B1/XJZ80U5IzpBmK/lI4zTJNLLzUSLEgU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=R+cXkzH//X2dDzepkgt8yML56pWua2I8AR5cBjf8843WZaYuRbwyRNEOrnIQm2BAx8kdh9QjSd8mKUJaqcGECjonj6cLLuNQ3dVKSjUg2aIJQQjjt7419uwrBlg1TqoNLSpWpNEgO+uPaAI/JcCZ5fBet87zcJE9+eAz8J4qRJk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uwaterloo.ca; spf=pass smtp.mailfrom=uwaterloo.ca; dkim=pass (1024-bit key) header.d=uwaterloo.ca header.i=@uwaterloo.ca header.b=rgn6K6Mp; arc=fail smtp.client-ip=216.71.135.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uwaterloo.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uwaterloo.ca
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=uwaterloo.ca; i=@uwaterloo.ca; q=dns/txt; s=default;
  t=1723918537; x=1755454537;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IpkTsMMXh1B1/XJZ80U5IzpBmK/lI4zTJNLLzUSLEgU=;
  b=rgn6K6Mphs4c44Hd1OtV/s04jggvOB7t0uw3wfSZdkvwFWwYS2MX2ioL
   3FkD8HSDQNFoeRDlBhsWA6CELXBTP7KniiTW0dSxxPveg842Tc7b2eUX0
   A0f4n4lCBcylSzW7wBDcJ16AxEuHdY7XKAXqKRqJy2rhxJv+fuQ8e45LW
   c=;
X-CSE-ConnectionGUID: aftdBSR6QBKIcGmE2FAmMA==
X-CSE-MsgGUID: GBZP5eyTSuW5SUBzNWEGUA==
X-Talos-CUID: 9a23:275kxmwVBUX2ZzoLXzGfBgUdFNwpWEbnkk76AG6zJmNEEpO8THq5rfY=
X-Talos-MUID: 9a23:4LsLlgg+osV7AdmmwKxOicMpG+1a2/mjGXw2jKpbgPSuJwpPFhigpWHi
Received: from mail-canadaeastazlp17010006.outbound.protection.outlook.com (HELO YQZPR01CU011.outbound.protection.outlook.com) ([40.93.19.6])
  by ob1.hc503-62.ca.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2024 14:15:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IiHHRE25l2sYw12T8lXXv3Sv1hBZ/Xy8g1ylXImJo3u4F0Etb6/GrDewkkY5UhebD2XQlxvhBYMfXsITH24Jb3sFy4SMXuvVmK4iVAzX4G+3ntkPaviZpzPAeYYYk0EeplIcLnhWNUHxAQJJSdR6thGkLWXiSm5njsN3byUSrdll2SfRVkcXLAmmTaed4UQ/ld5qlToskrylPXFGTQHI7AE7rIaRtGezbzWe/daKI0B2ESfs5gtJrEIs8ZmeK1TzXQ024rie/9V+gIPfXbths1oGGsp+JjtXok7y32OmwqnRdbbDqSiBOyXOp684JBQNQ9/C36tgKVOUozgKSUF3aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gh3K+RZOlo5raAj+cC2xXEyejSnmAVLyHcVEPzA3WxM=;
 b=R9PjnAS9OVzhKMsmBZryJ1boZd2POXelXBQNTc+rsOt9gtwz12qgDz9yWEjhiXaSZNwWsuH5lCN9GxuuKgraol0UveCv/HCzfikt+Cmo/hGqACSBkTtPCToZSppZZM21wk30BcjrqbihXAa6hRrC663r48wVeGZr26zvgAvnDYghHNgBKo8c/Z8GlZfNjjeRh4aDtXBkeX+LiFsxv3CGdzzQR/n8oBhS3T2Mqn0yO3a24LbVXIQMKLv0F8zay9GklOoFNic1Pu750D/fBFue+iXLt+3NQXZViHNRlZzXH/uUTh7gcJo4UbS25vZIYOEnDkEfCZC3Visq/nEmhJiARQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uwaterloo.ca; dmarc=pass action=none header.from=uwaterloo.ca;
 dkim=pass header.d=uwaterloo.ca; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uwaterloo.ca;
Received: from YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4b::13) by YQBPR0101MB5481.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:44::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Sat, 17 Aug
 2024 18:15:32 +0000
Received: from YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::d36e:ef93:93fd:930]) by YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::d36e:ef93:93fd:930%4]) with mapi id 15.20.7875.019; Sat, 17 Aug 2024
 18:15:32 +0000
Message-ID: <e4f6639e-53eb-412d-b998-699099570107@uwaterloo.ca>
Date: Sat, 17 Aug 2024 14:15:30 -0400
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
 <02091b4b-de85-457d-993e-0548f788f4a1@uwaterloo.ca>
 <66bfbd88dc0c6_18d7b829435@willemb.c.googlers.com.notmuch>
Content-Language: en-CA, de-DE
From: Martin Karsten <mkarsten@uwaterloo.ca>
In-Reply-To: <66bfbd88dc0c6_18d7b829435@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0139.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::18) To YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4b::13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YQBPR0101MB6572:EE_|YQBPR0101MB5481:EE_
X-MS-Office365-Filtering-Correlation-Id: 64dd5293-7fb5-4483-fb4b-08dcbee89508
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b1pJTmR3eWpDWVJtbmticGFLY0swMWhWSnNHd2NOOElUSktIb3JvNGx3NXZW?=
 =?utf-8?B?cTMvTWFHbE15Rnl4b1YxeCtjcXVyY2p5eml1NGR4dy95dGpVUEc1alZtTm9i?=
 =?utf-8?B?RmdBazE1d3Y3WEZqNWdGVkx5eFFsTUZHcG9ub3ZkZVZDN1U3Umk0ZUE1akt4?=
 =?utf-8?B?TDlsb0hJWVk1UHFlaVlsbW0xVGk4MGRmS1VpMUpPZThwaDRJTmdPS0FsL2Qr?=
 =?utf-8?B?eWErYmN1dW5DUVVnMm9xOEl6VGZPdkVpVjUrZjhmVVVxTjdyRjJZSVNCL3FI?=
 =?utf-8?B?UXZPRWQwMk5qNGRwY1FtV1BFaDlGeXM0UVRXZlIra2NDVmt0LzhvUTVvOEJ5?=
 =?utf-8?B?bm9YQkljeGVMMjJCU2FTTXdzQlAvRGtpenVPYnNwR3p2WGJVMDRmUW52VG11?=
 =?utf-8?B?Ly8wSmtxZ0ZHR3JjUmtDeWlpbjNhRllZT1Jiek5EblFPc1c2YzJqMGwzTy9l?=
 =?utf-8?B?Y3JHb2VmZm1Pd3QwZGRKVmkrbDVnRk5qL1NUSmt3K0ltSHBqeit0ekd4bEpk?=
 =?utf-8?B?ZlNONkgxTnlXaHFGc2hoUG84MXBmd0lHTFg3MU1wd1NMQ3F1UUo1aGNxdk10?=
 =?utf-8?B?dWZmT2V0NEtrQUV6VHJCUmxmYWJEUXZ6U2FiYW11dU9OalJGOS9hWjNQdTJN?=
 =?utf-8?B?cmRqdy9DRHAxcXRpdWtZUWpmdFNnenlmaGtsSjUxc2E0cjZNMnhhT3duVG8w?=
 =?utf-8?B?TVBkK1ZCOXo5NTZ5bDdONXdjeXNhY29tZzVNL2toV1FxWVVsbjN5VjRGZGdi?=
 =?utf-8?B?dmZBTlNHMnpYSEUrNXg1WWltQTZ5a044VEpqRTMrN3ozNXgrZWRNSVNsUWF0?=
 =?utf-8?B?cFl3dzJTN0JLYnRBWUxSYkxOeDF5USswdmU3RVhaR3lZa085OHNrZ2NKdkhP?=
 =?utf-8?B?aXNiYUwxWkhLcHFJM0tVUCs5dXFnTU5nNHZIZHdvVFV3RUhhZnNVa3NCLzdk?=
 =?utf-8?B?dk9mZU1OaHJGR2Q1bkY4aCtaRUNwR3V2VHRwbDJUbWRBRXhaaUJsVHVQZSt6?=
 =?utf-8?B?WG5rTTZhSktYaDJ4REFwVW84eG03SUxjM2Qvbmk4ZWRVTzhFZWJvbTQ3WklR?=
 =?utf-8?B?K3ZXLzk5Wm9vR3pyVC96TmhnVXhCR3BNNExuOFREeWtWMFEzTzVoanBYNTRr?=
 =?utf-8?B?Umo3OXJhMjd4S1dianRkYzJMSVNlNVlLU3pJVC9kN0Z2TWpqNnhMdG5yblNF?=
 =?utf-8?B?ckdaU2Z2UjYyZ0REdzFoYnpXS1p1cGl0c093Q1lGZ0pKcUxIQlJiSE9rQWdM?=
 =?utf-8?B?UmNyUFJCQUhCK0JEakxpa3NLSEt3cVJZRURWVjkrTzBRUVdZVUxjZ3hkS29U?=
 =?utf-8?B?THp2UENLZGxqVmw0c3MxKzU3Z0c3bGx0UEhFTmZ1amZKZE5TZTRRTUQwdWo1?=
 =?utf-8?B?bi9yaDRobU5WOEFvNzJPbVhCUmxnMTBqN2hFUURpVytMS3g2cXgzQTByZjdv?=
 =?utf-8?B?dGdnV1o3WjBwSlEzanZaaEdBcUpEdFVoMXNIT08rZC9DWC9wN1AyMXNkc0dn?=
 =?utf-8?B?ay9XQ2FGNWVsZDZkaVIxdStuaTB0RmZEYW1LQTkrb01Bd2ZOamdTblVmRVEy?=
 =?utf-8?B?V3JXdTR5V2FOZ2N6TE1FbmZ6bEdQRmo0TytKaHRVbjJ6bm12a1lQeWFYc1hT?=
 =?utf-8?B?L0RwUThITkFtSllMSFIyNVdXSkJlSWlUWlpwQzVZK3BjQ3Rib2ZlOHlBWHZI?=
 =?utf-8?B?SkpDTXAxaFRsZFhld2R4WUxlU01CcmlDMmlHSUdVVEg0MHA4c1dnN0psaWFo?=
 =?utf-8?B?TXpJc2xQcGVFRWRDNkg0Y2JJQ2xwQ3ArVG0wUW13K0h5VWtyUnVJY1NsY09J?=
 =?utf-8?B?a3BQclllQXYwL1Z4Wm9kZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bmNLN2g0SEJXZXovYlQyTzRtZURDMm03d09UZ1ljMzZMcVdjUmJoWHRjYkJO?=
 =?utf-8?B?eVhkdzlxQ1loMVhVTkN4VFpCeEpUOFA1WmZrdEkzZFJjZ01sRkZGVjRFUVZy?=
 =?utf-8?B?OUZ3MTRpNnhOYzg4NGN1a3hzMXVpMGgyRzczK05IQmxoQWs5VWtTSUpocUlQ?=
 =?utf-8?B?OTVLQ0hhR0Ixbm1SMTloZ01HV2hDN0E1RGV1dXRLeTlwdG1rS0JuQzhQbWh0?=
 =?utf-8?B?VjFxd3dBenlVTVIzc2NTSGlMd29ja21ON2Y4NW15Q2gveUtETytzNHM0cXVv?=
 =?utf-8?B?Zm5mTTZzc245T1U3c05sZGVqc2habHZGbHlRaWFGTVN0V0cra1ZCdHJLSmZL?=
 =?utf-8?B?RHdvWXFTVGdZdS9teWRhaXNhSVo3cFk3SFNHb1NSMW1yQmJ4b2JMVXFFWlZv?=
 =?utf-8?B?L2NGaFhuUU9rcDE2ZFNXUWJNYkx1RzgyZ2xublhnVGRIZ25qRkNtUzZCeC81?=
 =?utf-8?B?N2g0ZW1vaWxXVUFnVE1jWmhUSm45REZLSFY0OTMwejQ3b01OVmZnaGZ1R3hZ?=
 =?utf-8?B?TWpLSXBIZHJkdDJCYkV5bXZ4dFR4QXpMR0EwZ1VpMENXdDdvKzFEbmN3anp6?=
 =?utf-8?B?L1VTa3BzQXgxeXB4MFdCcUJhUk5Nd1ZzeERHaHB6UnlkYk9haUpDbzF1cE5E?=
 =?utf-8?B?R2xXYzM3WEZ2bXlqMkplS2hBWkkzN0Y5VHlpTUhjMmN4QXZTbnQvY05IL0Nv?=
 =?utf-8?B?Y213VVd1UG5PeThEWlNXL01ZY2N6S3QzNGlJZFBBYmp6VGNPME5EN01XZkZT?=
 =?utf-8?B?VjJOaVRLNWRPQzQ0eTBUTXIxTGJ5V0NEUFFRNzVXNnA3YUZmQjVLZmRpdjgr?=
 =?utf-8?B?NFh1bTdUYUJ2L0xGTlVhUkZJOHJmNUFoTWp4UnVtYU9Jcm42ZkdYM20rZko0?=
 =?utf-8?B?NVBxWVdISDNwa0N0Y0VkRjFIa0dmQ09BUzNMVmxxQzN3YVNzUU4rdzRtSVEx?=
 =?utf-8?B?clJSTU53MFlJTUZqTHBEdHpFZFp5bjBBdnh1eGdWREt3bzRxK1dJY2Z5TDdI?=
 =?utf-8?B?RzJHb2JrZDJTM09xVWhDOUFZZm9HUWMwcFNBZ1hEQ2UveDdiZG9aVGtDWUYv?=
 =?utf-8?B?WXp0OW1JUG92aGZqeStqM1lPMlFVaFRheUN0ck5pRzdLQ1ZWNnVtUlNzRDRa?=
 =?utf-8?B?ZjI5Z0VQTnRrcXFSOEpVS1hhTGovS3FVbk0wN29sc2F6MklxNDQyVGo1amh6?=
 =?utf-8?B?VmpIREMvNkIvMWdvbW5UWUh3RExCNEczNGtBeTJFQzBIWWFXZGlvTzQrQjhG?=
 =?utf-8?B?SmlFbkJOdFRVQUYzeUxTMzVMSUJCY21SVnRWamZmaWxmb1U2ZzdYNUpBNHFH?=
 =?utf-8?B?SFFGM1VpSXdlRUhMS21ON0MxV252bkVXZm1uci96ekpqTUVMUjlJbHI5UXRt?=
 =?utf-8?B?Y2hkVjcxNHExOXh6TUFGN1hDaEl4MW5NckdjL0NRcWxSZHhrZEtISGxoVXdq?=
 =?utf-8?B?eFdvd25RUnNLelBidmUySi9jdC9OM01TTmM5d3UyMFFCWXVsaXZjeFowZzY4?=
 =?utf-8?B?WCtOTGxXUXJ2bjVGem5VL2J0Q0JFWEJFZXE0bnhjd3dnV0F4ek1nT0JwU2Rk?=
 =?utf-8?B?Q2dFU0lXMmg5VURTVnowd1NLd1diOGhCS1FRWjQ0a1pkVXVKTHJSOS9pUU5x?=
 =?utf-8?B?WjlCakxhblBkbDV1WXgrNy9TbW81aUVqRUgzODhudVZzUEdRNmJtMDR2QSs1?=
 =?utf-8?B?aWQvR0FvZFBlZ0VlVkN6Q21UWFU1MlNMY1hrQjdIRi9pbCt5Mlh2UGZUeFM5?=
 =?utf-8?B?MkNJUGVWSmw1OG9ML1hNc3ZnQ2xzbFJabXNTMnNjWTlWQ2htRzBIcXVZQ3RI?=
 =?utf-8?B?TE5kUXJKdE1wbTYwU0kxY3hoQldUZVVLbVI2SkN5U2dkZjlaQUI1YjJRd2dV?=
 =?utf-8?B?TGYxWHdCSWx4RkFxTkh2d2NHTXY3MDJ2K21UT1drbVlXU0tNdWRMbmpJVjBW?=
 =?utf-8?B?djQxVkVJMzEyeVdvWXluY3FranRzeThvWEg5MVM2cVRLODZ4MFEvbmZDck9j?=
 =?utf-8?B?cGdleGRQRXZ1NWJvVzU2WmVnK3lsVElhc3BaeTFsb3NzdktqS255UjZSUzhm?=
 =?utf-8?B?WHkvWm1BNGI2RUk3QXJrUk1zVS9XK2xyM1ROSENoZjFCYWZnNFF6UUV0M3hQ?=
 =?utf-8?Q?FyBQl+dAVYodnEyTe21xyIUIS?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LjpUp3FJM7/P9rEbe5sDJ+9OsZU82tFG6vUv7k+Nju35UI8ZBmbYGUiz+yaZQil3y3sUYBqfABHWdHt/Bl5AGzgmxZ2vJYGj7Oa24KJZtNfABEoOG/QGDEcJgqwsJXNSwC0Nh1EdxJAGfwbj15CNOCpbyYKlnYdhuQAyCezGIoPHf0LcfYX4IKEVY+SHPm6zUrBtoXKVPRXTg9Fb8iDwyzpm44l8mseqqT6Q2pDb6Rcl8Lo2bRlb0Ps/MXlbTKat2c/ptm4F3/yK5YJTYSC/iZcGo/wmel0Kh0Ob6xrvh9zTNEGCeUwcNU+Vk55i+p9bfNiGe12l9Yl6Gjj4FdjLSVTdts71Z8JcqKkRjk2U2gJlvGHv9hETdUtm/GiO1RFecSJ2rzFvQVaOiQv+PBiSVT3PH6a7kYa/O2Nh+A6oJY+X8vB5MJjKse1qMUbaPTq91usKSH5gxG2UhtffjCmEpHlJb3B/6ffopm0orOPCXQJpqqobjTJGl+sNYqsdxGk/xjBkeOtbhKk3vFaHtIL+/ok0Gc77t3Tt+APrfrbUjC3MBzwWBasHj5oukbShHo/lNeS960zZbCtMaTUrP7+/KV+xfCVhdE44awaJYYPFd2721p7FRs5UmRzpO9ZSimk9
X-OriginatorOrg: uwaterloo.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: 64dd5293-7fb5-4483-fb4b-08dcbee89508
X-MS-Exchange-CrossTenant-AuthSource: YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2024 18:15:32.3408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 723a5a87-f39a-4a22-9247-3fc240c01396
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5loi7loqhzsSxihChQ0rIT/1WSe0l+LS3R1eXbbWemEWl+ieIM+YKMieJXHRm4bzvZEn+7o5FoxJ83OU6x63ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB5481

On 2024-08-16 16:58, Willem de Bruijn wrote:
> Martin Karsten wrote:
>> On 2024-08-16 13:01, Willem de Bruijn wrote:
>>> Joe Damato wrote:
>>>> On Fri, Aug 16, 2024 at 10:59:51AM -0400, Willem de Bruijn wrote:
>>>>> Willem de Bruijn wrote:
>>>>>> Martin Karsten wrote:
>>>>>>> On 2024-08-14 15:53, Samiullah Khawaja wrote:
>>>>>>>> On Tue, Aug 13, 2024 at 6:19 AM Martin Karsten <mkarsten@uwaterloo.ca> wrote:
>>>>>>>>>
>>>>>>>>> On 2024-08-13 00:07, Stanislav Fomichev wrote:
>>>>>>>>>> On 08/12, Martin Karsten wrote:
>>>>>>>>>>> On 2024-08-12 21:54, Stanislav Fomichev wrote:
>>>>>>>>>>>> On 08/12, Martin Karsten wrote:
>>>>>>>>>>>>> On 2024-08-12 19:03, Stanislav Fomichev wrote:
>>>>>>>>>>>>>> On 08/12, Martin Karsten wrote:
>>>>>>>>>>>>>>> On 2024-08-12 16:19, Stanislav Fomichev wrote:
>>>>>>>>>>>>>>>> On 08/12, Joe Damato wrote:
>>>>>>>>>>>>>>>>> Greetings:
>>>>>>>
>>>>>>> [snip]
>>>>>>>
>>>>>>>>>>>>> Note that napi_suspend_irqs/napi_resume_irqs is needed even for the sake of
>>>>>>>>>>>>> an individual queue or application to make sure that IRQ suspension is
>>>>>>>>>>>>> enabled/disabled right away when the state of the system changes from busy
>>>>>>>>>>>>> to idle and back.
>>>>>>>>>>>>
>>>>>>>>>>>> Can we not handle everything in napi_busy_loop? If we can mark some napi
>>>>>>>>>>>> contexts as "explicitly polled by userspace with a larger defer timeout",
>>>>>>>>>>>> we should be able to do better compared to current NAPI_F_PREFER_BUSY_POLL
>>>>>>>>>>>> which is more like "this particular napi_poll call is user busy polling".
>>>>>>>>>>>
>>>>>>>>>>> Then either the application needs to be polling all the time (wasting cpu
>>>>>>>>>>> cycles) or latencies will be determined by the timeout.
>>>>>>>> But if I understand correctly, this means that if the application
>>>>>>>> thread that is supposed
>>>>>>>> to do napi busy polling gets busy doing work on the new data/events in
>>>>>>>> userspace, napi polling
>>>>>>>> will not be done until the suspend_timeout triggers? Do you dispatch
>>>>>>>> work to a separate worker
>>>>>>>> threads, in userspace, from the thread that is doing epoll_wait?
>>>>>>>
>>>>>>> Yes, napi polling is suspended while the application is busy between
>>>>>>> epoll_wait calls. That's where the benefits are coming from.
>>>>>>>
>>>>>>> The consequences depend on the nature of the application and overall
>>>>>>> preferences for the system. If there's a "dominant" application for a
>>>>>>> number of queues and cores, the resulting latency for other background
>>>>>>> applications using the same queues might not be a problem at all.
>>>>>>>
>>>>>>> One other simple mitigation is limiting the number of events that each
>>>>>>> epoll_wait call accepts. Note that this batch size also determines the
>>>>>>> worst-case latency for the application in question, so there is a
>>>>>>> natural incentive to keep it limited.
>>>>>>>
>>>>>>> A more complex application design, like you suggest, might also be an
>>>>>>> option.
>>>>>>>
>>>>>>>>>>> Only when switching back and forth between polling and interrupts is it
>>>>>>>>>>> possible to get low latencies across a large spectrum of offered loads
>>>>>>>>>>> without burning cpu cycles at 100%.
>>>>>>>>>>
>>>>>>>>>> Ah, I see what you're saying, yes, you're right. In this case ignore my comment
>>>>>>>>>> about ep_suspend_napi_irqs/napi_resume_irqs.
>>>>>>>>>
>>>>>>>>> Thanks for probing and double-checking everything! Feedback is important
>>>>>>>>> for us to properly document our proposal.
>>>>>>>>>
>>>>>>>>>> Let's see how other people feel about per-dev irq_suspend_timeout. Properly
>>>>>>>>>> disabling napi during busy polling is super useful, but it would still
>>>>>>>>>> be nice to plumb irq_suspend_timeout via epoll context or have it set on
>>>>>>>>>> a per-napi basis imho.
>>>>>>>> I agree, this would allow each napi queue to tune itself based on
>>>>>>>> heuristics. But I think
>>>>>>>> doing it through epoll independent interface makes more sense as Stan
>>>>>>>> suggested earlier.
>>>>>>>
>>>>>>> The question is whether to add a useful mechanism (one sysfs parameter
>>>>>>> and a few lines of code) that is optional, but with demonstrable and
>>>>>>> significant performance/efficiency improvements for an important class
>>>>>>> of applications - or wait for an uncertain future?
>>>>>>
>>>>>> The issue is that this one little change can never be removed, as it
>>>>>> becomes ABI.
>>>>>>
>>>>>> Let's get the right API from the start.
>>>>>>
>>>>>> Not sure that a global variable, or sysfs as API, is the right one.
>>>>>
>>>>> Sorry per-device, not global.
>>>>>
>>>>> My main concern is that it adds yet another user tunable integer, for
>>>>> which the right value is not obvious.
>>>>
>>>> This is a feature for advanced users just like SO_INCOMING_NAPI_ID
>>>> and countless other features.
>>>>
>>>> The value may not be obvious, but guidance (in the form of
>>>> documentation) can be provided.
>>>
>>> Okay. Could you share a stab at what that would look like?
>>
>> The timeout needs to be large enough that an application can get a
>> meaningful number of incoming requests processed without softirq
>> interference. At the same time, the timeout value determines the
>> worst-case delivery delay that a concurrent application using the same
>> queue(s) might experience. Please also see my response to Samiullah
>> quoted above. The specific circumstances and trade-offs might vary,
>> that's why a simple constant likely won't do.
> 
> Thanks. I really do mean this as an exercise of what documentation in
> Documentation/networking/napi.rst will look like. That helps makes the
> case that the interface is reasonably ease to use (even if only
> targeting advanced users).
> 
> How does a user measure how much time a process will spend on
> processing a meaningful number of incoming requests, for instance.
> In practice, probably just a hunch?

As an example, we measure around 1M QPS in our experiments, fully 
utilizing 8 cores and knowing that memcached is quite scalable. Thus we 
can conclude a single request takes about 8 us processing time on 
average. That has led us to a 20 us small timeout (gro_flush_timeout), 
enough to make sure that a single request is likely not interfered with, 
but otherwise as small as possible. If multiple requests arrive, the 
system will quickly switch back to polling mode.

At the other end, we have picked a very large irq_suspend_timeout of 
20,000 us to demonstrate that it does not negatively impact latency. 
This would cover 2,500 requests, which is likely excessive, but was 
chosen for demonstration purposes. One can easily measure the 
distribution of epoll_wait batch sizes and batch sizes as low as 64 are 
already very efficient, even in high-load situations.

Also see next paragraph.

> Playing devil's advocate some more: given that ethtool usecs have to
> be chosen with a similar trade-off between latency and efficiency,
> could a multiplicative factor of this (or gro_flush_timeout, same
> thing) be sufficient and easier to choose? The documentation does
> state that the value chosen must be >= gro_flush_timeout.

I believe this would take away flexibility without gaining much. You'd 
still want some sort of admin-controlled 'enable' flag, so you'd still 
need some kind of parameter.

When using our scheme, the factor between gro_flush_timeout and 
irq_suspend_timeout should *roughly* correspond to the maximum batch 
size that an application would process in one go (orders of magnitude, 
see above). This determines both the target application's worst-case 
latency as well as the worst-case latency of concurrent applications, if 
any, as mentioned previously. I believe the optimal factor will vary 
between different scenarios.

>>>>> If the only goal is to safely reenable interrupts when the application
>>>>> stops calling epoll_wait, does this have to be user tunable?
>>>>>
>>>>> Can it be either a single good enough constant, or derived from
>>>>> another tunable, like busypoll_read.
>>>>
>>>> I believe you meant busy_read here, is that right?
>>>>
>>>> At any rate:
>>>>
>>>>     - I don't think a single constant is appropriate, just as it
>>>>       wasn't appropriate for the existing mechanism
>>>>       (napi_defer_hard_irqs/gro_flush_timeout), and
>>>>
>>>>     - Deriving the value from a pre-existing parameter to preserve the
>>>>       ABI, like busy_read, makes using this more confusing for users
>>>>       and complicates the API significantly.
>>>>
>>>> I agree we should get the API right from the start; that's why we've
>>>> submit this as an RFC ;)
>>>>
>>>> We are happy to take suggestions from the community, but, IMHO,
>>>> re-using an existing parameter for a different purpose only in
>>>> certain circumstances (if I understand your suggestions) is a much
>>>> worse choice than adding a new tunable that clearly states its
>>>> intended singular purpose.
>>>
>>> Ack. I was thinking whether an epoll flag through your new epoll
>>> ioctl interface to toggle the IRQ suspension (and timer start)
>>> would be preferable. Because more fine grained.
>>
>> A value provided by an application through the epoll ioctl would not be
>> subject to admin oversight, so a misbehaving application could set an
>> arbitrary timeout value. A sysfs value needs to be set by an admin. The
>> ideal timeout value depends both on the particular target application as
>> well as concurrent applications using the same queue(s) - as sketched above.
> 
> I meant setting the value systemwide (or per-device), but opting in to
> the feature a binary epoll options. Really an epoll_wait flag, if we
> had flags.
> 
> Any admin privileged operations can also be protected at the epoll
> level by requiring CAP_NET_ADMIN too, of course. But fair point that
> this might operate in a multi-process environment, so values should
> not be hardcoded into the binaries.
> 
> Just asking questions to explore the option space so as not to settle
> on an API too soon. Given that, as said, we cannot remove it later.

I agree, but I believe we are converging? Also taking into account Joe's 
earlier response, given that the suspend mechanism dovetails so nicely 
with gro_flush_timeout and napi_defer_hard_irqs, it just seems natural 
to put irq_suspend_timeout at the same level and I haven't seen any 
strong reason to put it elsewhere.

>>> Also, the value is likely dependent more on the expected duration
>>> of userspace processing? If so, it would be the same for all
>>> devices, so does a per-netdev value make sense?
>>
>> It is per-netdev in the current proposal to be at the same granularity
>> as gro_flush_timeout and napi_defer_hard_irqs, because irq suspension
>> operates at the same level/granularity. This allows for more control
>> than a global setting and it can be migrated to per-napi settings along
>> with gro_flush_timeout and napi_defer_hard_irqs when the time comes.
> 
> Ack, makes sense. Many of these design choices and their rationale are
> good to explicitly capture in the commit message.

Agreed.

Thanks,
Martin


