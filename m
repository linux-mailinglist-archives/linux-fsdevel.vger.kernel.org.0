Return-Path: <linux-fsdevel+bounces-25752-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BFE794FBDC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 04:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0C831F225A6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 02:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4E018028;
	Tue, 13 Aug 2024 02:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uwaterloo.ca header.i=@uwaterloo.ca header.b="bhJA3/Nx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa.hc503-62.ca.iphmx.com (esa.hc503-62.ca.iphmx.com [216.71.135.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523E012E4A;
	Tue, 13 Aug 2024 02:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.135.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723516532; cv=fail; b=mFNWxTA6hfDzHJ3Q0ZcjRuk8QNfWdg6wqTYo0imGkGjBNhUlT4mKdqhZKVn2byNds0Ii2Y3YxuQqeb+AhDtDXmw6AaaZTqVGAJ3fHDFX/VdGGW5XBSnfyjMIfpO58qOvyVU0BW7pguHnFRxjpdwsMoRInTnUHrQmSQny6JNwnOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723516532; c=relaxed/simple;
	bh=Ni6DYdnt+VdD6kSV6wSXWMuejr0jx29L6+7jYukZNCk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XNyz3vbeXji4lt6BUgCsFaQCOOLNIfSQq8zGnHaMnTSCompBaqiq6DulyIuTTtO7JpphSVO/SX1sBLQMihrAC0GZEUAaL9NY9uXD2lE2ChgbrBaExIO4EIUy3Z5qmW2wV/khfnTDgUMuTHSqntYRcLK/kFzuXWLpOMEerEa3t2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uwaterloo.ca; spf=pass smtp.mailfrom=uwaterloo.ca; dkim=pass (1024-bit key) header.d=uwaterloo.ca header.i=@uwaterloo.ca header.b=bhJA3/Nx; arc=fail smtp.client-ip=216.71.135.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uwaterloo.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uwaterloo.ca
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=uwaterloo.ca; i=@uwaterloo.ca; q=dns/txt; s=default;
  t=1723516530; x=1755052530;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ni6DYdnt+VdD6kSV6wSXWMuejr0jx29L6+7jYukZNCk=;
  b=bhJA3/Nx158jzaEPjylwkKYjJM+a3RfuERjVFz2iarngqeRVquCMYHaI
   08K5Wfpc4GBFhm12Ll6b/V0ozQvz2uG6Hx2wJPKdawhI/yMtq4TZuACc2
   pbL1StpdWTzeXWTJ5sM+MTZfcYnBK0keSj082sbrKUPywgvHCgX+u2EkU
   A=;
X-CSE-ConnectionGUID: sAONgHlmSimx8GXzW7Ja0A==
X-CSE-MsgGUID: ItgUPVDhS9+zQAlwYTcN4A==
X-Talos-CUID: 9a23:RLdEU23GiF6BAI+acW22iLxfAekCVHL9yHLrIkqoWUlZWoLKa1bI0fYx
X-Talos-MUID: 9a23:mBbC4gmbbyX6dx7+jj+TdnpDKMhV25qCCHtc0oc/ks2bBBB7HWu02WE=
Received: from mail-canadaeastazlp17010000.outbound.protection.outlook.com (HELO YQZPR01CU011.outbound.protection.outlook.com) ([40.93.19.0])
  by ob1.hc503-62.ca.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 22:35:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SYqCM2IwmacP56WxD87OeFe/Ed81u5Wr7GoLMD9q6F3/6jtdOeJyzHozsPK1k87922fQuUUM8sW1795gYHtJj7Ar0ivkFeVQyJ4gVDEBKv4vTz+FtE7oXUBpEqkUP7Z2jJuxbdkpyQmBAW9Y6ushxXkY/RF2o68mN+ls2NGHvtkYxs3s6xCVYMzkdPbstwtyV2nJLwqQWY473Q+2i5qYC7Cb7jvY0sb6SGqwsiJFVPMtLjNUWJegljWZjyvukcs5WcGTWkvU2watg+UDkjnba+CfIMiOui5MsNdHc8k6IdYQXSOVXv+SUoK9QDCECpW0oRPfQbH405QSWEGSv9hsyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gAg49dXE2E/XoQev7tPnKyIMCTRQYO850LKz8jgQNOw=;
 b=JSuAhYRVz/EYCeMYaqz8/zmAmlhJcaMwU8wrzx4XYRkUM+VIHeHTpDTD1/cR4UGmV/th2+fdkdv6t/K8OMyXf35RKDByjh4a/odKcn1mJMIJZHsWTds7x+bj/B5fzX4rroi7hubEtH77rUeb+cUrNbKNqz7ug3bo4Ockqv5xyyj8rdhlr2YhueArdtbNty+WXkRnXoWT5nNCvWLHC74q9Q2sT88s6CGg/7A31zPqQC+6oPlnA5he/28g0U6y0wnp2T2i4oVuM76IG4h3+/iM37C5rHI/T5HQI8FScfifXrhAN722+6o0fX+T86QbSdfSarkMfkMuGca40752Mc7Zqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uwaterloo.ca; dmarc=pass action=none header.from=uwaterloo.ca;
 dkim=pass header.d=uwaterloo.ca; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uwaterloo.ca;
Received: from YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4b::13) by YT2PR01MB5997.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:59::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Tue, 13 Aug
 2024 02:35:25 +0000
Received: from YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::d36e:ef93:93fd:930]) by YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::d36e:ef93:93fd:930%6]) with mapi id 15.20.7849.021; Tue, 13 Aug 2024
 02:35:25 +0000
Message-ID: <5e52b556-fe49-4fe0-8bd3-543b3afd89fa@uwaterloo.ca>
Date: Mon, 12 Aug 2024 22:35:23 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next 0/5] Suspend IRQs during preferred busy poll
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, Joe Damato <jdamato@fastly.com>,
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
References: <20240812125717.413108-1-jdamato@fastly.com>
 <ZrpuWMoXHxzPvvhL@mini-arch>
 <2bb121dd-3dcd-4142-ab87-02ccf4afd469@uwaterloo.ca>
 <ZrqU3kYgL4-OI-qj@mini-arch>
 <d53e8aa6-a5eb-41f4-9a4c-70d04a5ca748@uwaterloo.ca>
 <Zrq8zCy1-mfArXka@mini-arch>
Content-Language: en-CA, de-DE
From: Martin Karsten <mkarsten@uwaterloo.ca>
In-Reply-To: <Zrq8zCy1-mfArXka@mini-arch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0164.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ac::6) To YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4b::13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YQBPR0101MB6572:EE_|YT2PR01MB5997:EE_
X-MS-Office365-Filtering-Correlation-Id: e41dbad9-bcba-4e2f-8275-08dcbb409629
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UXFpVEhmaU1oRy9BTDAzTGtyVlc1N3M0RmNCSG42dUQ0bkozS0luU3ViYW9Y?=
 =?utf-8?B?eThnMGw5NWJON0ZpUHJpS25CZnlxaU9UNVJ4VFlLeGtwUXBOV1JWc2Mya05C?=
 =?utf-8?B?NVExUnVUNGJhYm9jRElZZFNPVWlkN1BBaUtydFVLeGt1VzJHaDNrRDI5bW1D?=
 =?utf-8?B?RVJKYUZRWk5tb3E4ck5wTmVZNStIdGc5Lzd2NWp5MU5HUGF6QWIwV2U3WDZ3?=
 =?utf-8?B?aEZRUjZQZENUTEk4ZzZJQ0xYeW8rTjlKTXFCK2lvMEYvMDdyOVFnVXdJaXl3?=
 =?utf-8?B?QXdubDFWazBJWDN3VEtOekM3QU9uaGoxSElsRFp4Z1JGbGZNdHgyTzBqeUtE?=
 =?utf-8?B?eVkybDZzSUc0ZWVEOUxFK2dVbi9kV1NLV3BIVFUwSDFkUGdWeFVLRjZ2WHla?=
 =?utf-8?B?aTdHdWFtclZTYTlaQzVUUG9kMFBQSGZpR2Y2N0lsS0xjYXhrN29kTlFqSlRS?=
 =?utf-8?B?VUJGY24yZE5OUlJuVlluQk9kcUVxVFFmTXVFUlpkVDJkUHN2ZVpJbEh4d05x?=
 =?utf-8?B?VklLY0VZMzQ4dy9EUC9zSDFjZWZrNE42V3ZCNjBkMDJoSFMvM040MUJGRUVn?=
 =?utf-8?B?Yml6ZU51NHpzSG1GYWhLa2JvY0RWV1pidjYyRzZGcFdtZEJVT2J3VDRTckMx?=
 =?utf-8?B?eDBYUm5abUd5VUNaSGhoQjkrNkYxVUY5dTc1YWZGdmdUVXN4R2VwSzRmeHk4?=
 =?utf-8?B?QVZXdVlsSzlPendjb3pJd2tPRmxFVzZCSEFSbDE1NFlrTUdtSDZGM0kwQlp3?=
 =?utf-8?B?U3M2NktESUdleXB2SjhQaXJyZmJlKy9sM2VLbjVmUkJFYVpVd2NNb2FhOW9p?=
 =?utf-8?B?MmtnWUVkTHVuOUl1NmRZVlZITUdQbFJkbExUTlgxK0p4QzROaWRSdDBTclhv?=
 =?utf-8?B?aXZyOW4wMGJTbmdsSEgyVEZoek1NVUxnMWJzbjMyRlNUL1NlaVExLzRTZVd4?=
 =?utf-8?B?bkdYSkZhT0Z4Qm5jc3d2ejFEclBaTHVWOGJxRHh2WWtuNTl4QmNuTUpEUTR1?=
 =?utf-8?B?OTY0OVhkYzJQSTVvM1lLei9YeU5xS1JrbVZqVkpXTEVxRHR0U2Z6NnZVQyt2?=
 =?utf-8?B?Tnh6TXdpcFJaVWN2cWFFTnB6cGZSSHhoVDg3M09SQXl4ZEZTNjVjRTBseGJy?=
 =?utf-8?B?UEVma0crbkdwNXFOSmtTSWVPQ1RHUlNNUFpDdUI5MXFYeW5Eb2Z2R2hpRFNK?=
 =?utf-8?B?V1ZEMUwvWWJ1YWZOWG1rODB3WGNMZUlINUpuNUZjV3lUNTVyeHNUS0JLbXlS?=
 =?utf-8?B?clpBU091KzRHNlh2dzM4endlOUVzc1N0ejYveVh5Y1lrMjFqQzRvZVhLdVNO?=
 =?utf-8?B?NC81NFUwYWRzeGdjYmx2ZWJabHltZG92a3RJMmVvdURmVlF1U2lscXRweTU0?=
 =?utf-8?B?YUdrYnNFbndmRS9IQnlKZExwRzVwV0JmQzErdVV1em5CVVhaMkw5K0VkbG95?=
 =?utf-8?B?S3JZOTRoS3cwMlV0N1BvSC83YXM2R0JIbW9LRUJuMGtMOXpwTHk2VnBib1Ez?=
 =?utf-8?B?aXlYa2Znd3pHREVCR1NTL0RDM0dGeFc1anI3a0lhRklza1BlQXFKaEo1aFls?=
 =?utf-8?B?SElmYy9EbDJvdmtoRk40dTZQdVM4TzA1eDJ1KzB3VlphSlo4RmFJR1VOUHlI?=
 =?utf-8?B?Qm1tWTh4TGowTEdrTklwV3VlQytYQ2VhMXJKWlJRdndhb2Y2bW8yYmpYNFpU?=
 =?utf-8?B?bjViVWljTGhkQUR6YUJ3STdmU2NOY3gzK0Ercnl3OTVEeHdFU1FlSWpKK25p?=
 =?utf-8?B?YzZyLzVzN3lvQzF2NGVXRi9WSHVkbkFHVGlHK0hYQk9pMUFIQjJFcjBBOU40?=
 =?utf-8?B?MGFaZ2NPUnhkcE5wY1ZjUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U2lTSStycU9UWGNKSk5jV2NVTXBrWnMrVGZ2bXNwQVZZTDdObzFpbjk4blNP?=
 =?utf-8?B?RGNqdlFaWjRhbFVUZ1M1ajkrSExsOUlwNmtSdHhtdVE3Snk5amwxaWZmeUU1?=
 =?utf-8?B?cUFLS0VkdU53V2psdjdlZElVaGVucXYwQnRRWkZidzFQOFdORTZHd2FUejFs?=
 =?utf-8?B?M2dWSHNsS24vNXVNVkc3WHFQUjB5Q1NNQkJKNjlITDNiaTFFOG1rUFhqTmlR?=
 =?utf-8?B?VG55TE9VbGNDKzdMcHl6bzB3UkpnNjJmaDhPb2pWMjdveE5GWEx2UjltbllB?=
 =?utf-8?B?Mi92SWVnU1ArR2NWM0d4ZTNKMzFsSkg0VTdkWXNOSFhIRmMvNENsZTdzaVVF?=
 =?utf-8?B?TFBrQy9lNjU2dFNnR0haQVV3c1hmdDllTmJjMTBJVWU0b2oxVXgwdXVFSUNu?=
 =?utf-8?B?MEFROS9qeU9aaDkzWERmeWJMamFCVkE0YXhsR2pTZDhPMDZiM0RsZTNBa3JK?=
 =?utf-8?B?RDZ6MWdpYmZUajRBYVBCRE5mcERvcEk5cGE4UkUvUW95Z2xWWkwwNFBUY0Jw?=
 =?utf-8?B?aGhBWnRzb21oRi9QTHpya1FpalVuVVlhSyszOTJRWURYWmJObTVhNWNndFFG?=
 =?utf-8?B?RkJXUk1JN0g0eUxlWDdaYVhncDIzQys3UElSZzJPQ1lTSXZZWG93bmlNUENa?=
 =?utf-8?B?MmQzeGtuSjdubkZIKzNSNk5UakIwK3Fod2RxWEcvUXcyTE81c2w3a2dyTndz?=
 =?utf-8?B?SmRWNk1hKzJyL3hXMmNPVjd4NTFTQWxGVXpxZEpDblYreStOcXhPWTNjVnpz?=
 =?utf-8?B?M214R0xsY003dHBhcGVFaFlWQzhHeXpMMy9Bd0UzSW16YzFsYTNWMldOelN1?=
 =?utf-8?B?QWJ3djQrc2ExWnhwaDl2Y0dJT0tKWU55MEhERzZ3UFhRc0Q0TGRXT1lSSUcw?=
 =?utf-8?B?MytKcjV2cEpabyt5SElrbmxNUnRwRERLQkF3alVIeTZHUEdCenBnYzFmYkhN?=
 =?utf-8?B?bzdXNlJZS1V5TkFJZ0g3VWRmTHpha1p6amVzOTFZcFQxZGxVYzZwSWY0eFdG?=
 =?utf-8?B?cHhBMjQ4a3dpaHVlcGhFZTlIS0RIQjh2S0xtVC9WcXM1a0FzSDBvcEdYY2pw?=
 =?utf-8?B?VTZPSGpMWjF1Uy9NZ3cxbVBNVkdPOGhLazMzYnpUeVpVWUlNOWdkWkpyUS85?=
 =?utf-8?B?ME12bnRqcFo2V2ZXeXZZNDBkMmRmR2k3aUxYRGtZRVRSaFF4T0FxL1JlUE0w?=
 =?utf-8?B?M1lFTjlidUs5ZFBNMTZsdytVV21qSEx1TGlIMUg5cUE3a01QOXB6MVJqcFFk?=
 =?utf-8?B?ZFZLOVhEYnBJS0Q5VEhEZnhHMEJoR3A2QWFsVStwSFFpaHptN0JLNnRKaElU?=
 =?utf-8?B?TWxVU0tZRUs3RTZ0NWV0ZjBZdE0rTXB4Z1VRTVhCcVAyZTJaaTZ5NHFUbkkr?=
 =?utf-8?B?d2hRZjNLVXBodzZDbWMyY3FjSEoxdFpSN0ZnUDhQdFc5aTBpdW9kRDNiL2Rw?=
 =?utf-8?B?Ump2WFR4MGl4QzVHbVRpUit6TFRlWjJGQmV6ZXB0QXQrb2Q0N1B0Z3JJcWxr?=
 =?utf-8?B?UFZkTlhqUXgzNHhKckU2S1RIbXpuZ0tVRzNiNTNVMFN5bWdvY0dvTFl3UmUx?=
 =?utf-8?B?aW5jd3NsS3R6Q21BcUdyMFZNS2dlajM4eDV5VTRJVjRzWVkvc2Z0bWZzTWJG?=
 =?utf-8?B?dWxKUFVSY25aVXd4TEpyT2tOazlKSmUwVStsZlZJNXpCbENxTFJjM25QZE9J?=
 =?utf-8?B?N21pVmd0aXRuZWdMUTdIYjY1NXhBWXpvRGkvZ3ozaUFKTUJnaDBQc0Q1R3Nk?=
 =?utf-8?B?WDZiSCs4ZzArMzRkeVptVndubWxiaEJTbmFwTmVwUEU1ZUhwcm84KzJKcUZU?=
 =?utf-8?B?RHlCS2NtaHh0bVdKMjBHOEhEbmd5Q1NkVEtRQ3I4MEVEY1oxYi8wS21PMlVY?=
 =?utf-8?B?QUZJVkZmZXRhOGFJK0pDTTQreHh6cXlRNGw1VmZIL1hVR2sxamtBbDJ4OGF3?=
 =?utf-8?B?YnVzc2VwMTQ2YmN6RmhqbmdhVUhjYUNiV2t2c281YmJRSm11bW5LSWkrVjBT?=
 =?utf-8?B?SFZaMkhFbE5kVHhYYm9xenJ1Zm5LRnVxbzdtMm1Ea3llYU5tTWlDdDNUMTdq?=
 =?utf-8?B?dDJvS21PNnRaZ1V4MFRMaG52RWlxQ3k1OTZHNHVHcFNSaDBocndpOSs5WGlP?=
 =?utf-8?Q?e7SVgKwN1ffamM0kSE/ZezTyP?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Fm/cjGdKYE7nGgnVk1qUlQtTDlEf3Fua22jizeAu0Y0XJXzyp/M0DV07K8/OjispnqLQanfWts1jzn5UWLaqzOBYALSbatPMxlCsxzHfxlF0X404+K0CdbjgQTA3N/Ujvp+uWVkitBACL85kTyV13H1z67tGf4xozTpB7lBrWg2sl2Uc/4WK/++JCLNr/TK74fmOTRrsEBr+nxs8XXZrJQKiZCqJbnYv/sxbkEz2Ygx2aCwYCsGJIOCfu/wcZRR9HtMnBMfHpTLL8GREMJl+XDFL0zGtIkkg3RpddICGZzIXQ2QiGPrkpswftoxDN5C5SxzL7zSlNt9w3zVnYCwVNskiEs0I3uojCbUMIp+5fW3ytMVNN2CS1TUKOj+X2TobX5bnu7kiNiH7ccn5gGGOX/QwNBxlSyOIK44rGL3MGomPpdvgYCv9Tb/ZOLuUIy6o0UozJrxnL4utHx8uhpabwGJ6w7t3+smRwSZmJ9dP4AUPkiyfigQ0W3ybOD8CCEg25sEvZPZnLf//xwSFcGhRQYxbLF/d1yrLrffQtBlmvyduqFtSF+7lOf82dn/p/JNyQaWt9D+B2mvZgJSt7XNbTWmEVlESPkus7CimKPX8arOX30Mx8SmetyYfeEWE3/cS
X-OriginatorOrg: uwaterloo.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: e41dbad9-bcba-4e2f-8275-08dcbb409629
X-MS-Exchange-CrossTenant-AuthSource: YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 02:35:25.2151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 723a5a87-f39a-4a22-9247-3fc240c01396
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EtP2kBxJSDzrEYtKjgW0CpfCh9AbVuNby6oFNxTGYYOm+p5XSlsB4Wefn59GSoTRmT+iWj7J2vYEUGTVMg764Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB5997

On 2024-08-12 21:54, Stanislav Fomichev wrote:
> On 08/12, Martin Karsten wrote:
>> On 2024-08-12 19:03, Stanislav Fomichev wrote:
>>> On 08/12, Martin Karsten wrote:
>>>> On 2024-08-12 16:19, Stanislav Fomichev wrote:
>>>>> On 08/12, Joe Damato wrote:
>>>>>> Greetings:
>>>>>>
>>>>>> Martin Karsten (CC'd) and I have been collaborating on some ideas about
>>>>>> ways of reducing tail latency when using epoll-based busy poll and we'd
>>>>>> love to get feedback from the list on the code in this series. This is
>>>>>> the idea I mentioned at netdev conf, for those who were there. Barring
>>>>>> any major issues, we hope to submit this officially shortly after RFC.
>>>>>>
>>>>>> The basic idea for suspending IRQs in this manner was described in an
>>>>>> earlier paper presented at Sigmetrics 2024 [1].
>>>>>
>>>>> Let me explicitly call out the paper. Very nice analysis!
>>>>
>>>> Thank you!
>>>>
>>>> [snip]
>>>>
>>>>>> Here's how it is intended to work:
>>>>>>      - An administrator sets the existing sysfs parameters for
>>>>>>        defer_hard_irqs and gro_flush_timeout to enable IRQ deferral.
>>>>>>
>>>>>>      - An administrator sets the new sysfs parameter irq_suspend_timeout
>>>>>>        to a larger value than gro-timeout to enable IRQ suspension.
>>>>>
>>>>> Can you expand more on what's the problem with the existing gro_flush_timeout?
>>>>> Is it defer_hard_irqs_count? Or you want a separate timeout only for the
>>>>> perfer_busy_poll case(why?)? Because looking at the first two patches,
>>>>> you essentially replace all usages of gro_flush_timeout with a new variable
>>>>> and I don't see how it helps.
>>>>
>>>> gro-flush-timeout (in combination with defer-hard-irqs) is the default irq
>>>> deferral mechanism and as such, always active when configured. Its static
>>>> periodic softirq processing leads to a situation where:
>>>>
>>>> - A long gro-flush-timeout causes high latencies when load is sufficiently
>>>> below capacity, or
>>>>
>>>> - a short gro-flush-timeout causes overhead when softirq execution
>>>> asynchronously competes with application processing at high load.
>>>>
>>>> The shortcomings of this are documented (to some extent) by our experiments.
>>>> See defer20 working well at low load, but having problems at high load,
>>>> while defer200 having higher latency at low load.
>>>>
>>>> irq-suspend-timeout is only active when an application uses
>>>> prefer-busy-polling and in that case, produces a nice alternating pattern of
>>>> application processing and networking processing (similar to what we
>>>> describe in the paper). This then works well with both low and high load.
>>>
>>> So you only want it for the prefer-busy-pollingc case, makes sense. I was
>>> a bit confused by the difference between defer200 and suspend200,
>>> but now I see that defer200 does not enable busypoll.
>>>
>>> I'm assuming that if you enable busypool in defer200 case, the numbers
>>> should be similar to suspend200 (ignoring potentially affecting
>>> non-busypolling queues due to higher gro_flush_timeout).
>>
>> defer200 + napi busy poll is essentially what we labelled "busy" and it does
>> not perform as well, since it still suffers interference between application
>> and softirq processing.
> 
> With all your patches applied? Why? Userspace not keeping up?

Note our "busy" case does not utilize our patches.

As illustrated by our performance numbers, its performance is better 
than the base case, but at the cost of higher cpu utilization and it's 
still not as good as suspend20.

Explanation (conjecture):

It boils down to having to set a particular static value for 
gro-flush-timeout that is then always active.

If busy-poll + application processing takes longer than this timeout, 
the next softirq runs while the application is still active, which 
causes interference.

Once a softirq runs, the irq-loop (Loop 2) takes control. When the 
application thread comes back to epoll_wait, it already finds data, thus 
ep_poll does not run napi_busy_poll at all, thus the irq-loop stays in 
control.

This continues until by chance the application finds no readily 
available data when calling epoll_wait and ep_poll runs another 
napi_busy_poll. Then the system switches back to busy-polling mode.

So essentially the system non-deterministically alternates between 
busy-polling and irq deferral. irq deferral determines the high-order 
tail latencies, but there is still enough interference to make a 
difference. It's not as bad as in the base case, but not as good as 
properly controlled irq suspension.

>>>>> Maybe expand more on what code paths are we trying to improve? Existing
>>>>> busy polling code is not super readable, so would be nice to simplify
>>>>> it a bit in the process (if possible) instead of adding one more tunable.
>>>>
>>>> There are essentially three possible loops for network processing:
>>>>
>>>> 1) hardirq -> softirq -> napi poll; this is the baseline functionality
>>>>
>>>> 2) timer -> softirq -> napi poll; this is deferred irq processing scheme
>>>> with the shortcomings described above
>>>>
>>>> 3) epoll -> busy-poll -> napi poll
>>>>
>>>> If a system is configured for 1), not much can be done, as it is difficult
>>>> to interject anything into this loop without adding state and side effects.
>>>> This is what we tried for the paper, but it ended up being a hack.
>>>>
>>>> If however the system is configured for irq deferral, Loops 2) and 3)
>>>> "wrestle" with each other for control. Injecting the larger
>>>> irq-suspend-timeout for 'timer' in Loop 2) essentially tilts this in favour
>>>> of Loop 3) and creates the nice pattern describe above.
>>>
>>> And you hit (2) when the epoll goes to sleep and/or when the userspace
>>> isn't fast enough to keep up with the timer, presumably? I wonder
>>> if need to use this opportunity and do proper API as Joe hints in the
>>> cover letter. Something over netlink to say "I'm gonna busy-poll on
>>> this queue / napi_id and with this timeout". And then we can essentially make
>>> gro_flush_timeout per queue (and avoid
>>> napi_resume_irqs/napi_suspend_irqs). Existing gro_flush_timeout feels
>>> too hacky already :-(
>>
>> If someone would implement the necessary changes to make these parameters
>> per-napi, this would improve things further, but note that the current
>> proposal gives strong performance across a range of workloads, which is
>> otherwise difficult to impossible to achieve.
> 
> Let's see what other people have to say. But we tried to do a similar
> setup at Google recently and getting all these parameters right
> was not trivial. Joe's recent patch series to push some of these into
> epoll context are a step in the right direction. It would be nice to
> have more explicit interface to express busy poling preference for
> the users vs chasing a bunch of global tunables and fighting against softirq
> wakups.

One of the goals of this patch set is to reduce parameter tuning and 
make the parameter setting independent of workload dynamics, so it 
should make things easier. This is of course notwithstanding that 
per-napi settings would be even better.

If you are able to share more details of your previous experiments (here 
or off-list), I would be very interested.

>> Note that napi_suspend_irqs/napi_resume_irqs is needed even for the sake of
>> an individual queue or application to make sure that IRQ suspension is
>> enabled/disabled right away when the state of the system changes from busy
>> to idle and back.
> 
> Can we not handle everything in napi_busy_loop? If we can mark some napi
> contexts as "explicitly polled by userspace with a larger defer timeout",
> we should be able to do better compared to current NAPI_F_PREFER_BUSY_POLL
> which is more like "this particular napi_poll call is user busy polling".

Then either the application needs to be polling all the time (wasting 
cpu cycles) or latencies will be determined by the timeout.

Only when switching back and forth between polling and interrupts is it 
possible to get low latencies across a large spectrum of offered loads 
without burning cpu cycles at 100%.

>>>> [snip]
>>>>
>>>>>>      - suspendX:
>>>>>>        - set defer_hard_irqs to 100
>>>>>>        - set gro_flush_timeout to X,000
>>>>>>        - set irq_suspend_timeout to 20,000,000
>>>>>>        - enable busy poll via the existing ioctl (busy_poll_usecs = 0,
>>>>>>          busy_poll_budget = 64, prefer_busy_poll = true)
>>>>>
>>>>> What's the intention of `busy_poll_usecs = 0` here? Presumably we fallback
>>>>> to busy_poll sysctl value?
>>>>
>>>> Before this patch set, ep_poll only calls napi_busy_poll, if busy_poll
>>>> (sysctl) or busy_poll_usecs is nonzero. However, this might lead to
>>>> busy-polling even when the application does not actually need or want it.
>>>> Only one iteration through the busy loop is needed to make the new scheme
>>>> work. Additional napi busy polling over and above is optional.
>>>
>>> Ack, thanks, was trying to understand why not stay with
>>> busy_poll_usecs=64 for consistency. But I guess you were just
>>> trying to show that patch 4/5 works.
>>
>> Right, and we would potentially be wasting CPU cycles by adding more
>> busy-looping.
> 
> Or potentially improving the latency more if you happen to get more packets
> during busy_poll_usecs duration? I'd imagine some applications might
> prefer to 100% busy poll without ever going to sleep (that would probably
> require getting rid of napi_id tracking in epoll, but that's a different story).

Yes, one could do full application-to-napi busy polling. The performance 
would be slightly better than irq suspension, but it would be quite 
wasteful during low load. One premise for our work is that saving cycles 
is a meaningful objective.

Thanks,
Martin


