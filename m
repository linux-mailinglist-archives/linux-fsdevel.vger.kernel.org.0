Return-Path: <linux-fsdevel+bounces-25722-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B60194F916
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 23:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B77D628405D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 21:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC911957E9;
	Mon, 12 Aug 2024 21:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uwaterloo.ca header.i=@uwaterloo.ca header.b="0KMg9fhO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa.hc503-62.ca.iphmx.com (esa.hc503-62.ca.iphmx.com [216.71.131.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0E04D112;
	Mon, 12 Aug 2024 21:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.131.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723499213; cv=fail; b=cJ/G9PWdz4ALBcYdT/blcPUhvuwb/vBicBk0ZvIPDA0JQp7D2LuM+Vfaautm4SZh+7bIs8ImdjcPikwj5PjCWmxn9JyXcWpQRrPqk5zl+ONxIGiWakIql1Z+fIEk2gvqBuHkisd4XjGMfY6Wr8aGYkSx+7wd7NTrXAe0TMgs8Wo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723499213; c=relaxed/simple;
	bh=mR5q2iepjCWzHHU2JoJ794ebkN6mHmuoZEPlVvqIwjA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GCGYtj0xDF0KmhGno0+iwxaBUwYTEsJwnKiXFZ4tMjjrk+pVH+H9/CZZgJneHMRvfte66pXxHl1xIbA6dcq7T0s1Z0xYtsOb3DKxniNQa79e2U7OZiihro1YzoEnhfzvHM9xGPzbTVk3HZx9LO1TLHZTHWfzxm3iBN1joN6iqN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uwaterloo.ca; spf=pass smtp.mailfrom=uwaterloo.ca; dkim=pass (1024-bit key) header.d=uwaterloo.ca header.i=@uwaterloo.ca header.b=0KMg9fhO; arc=fail smtp.client-ip=216.71.131.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uwaterloo.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uwaterloo.ca
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=uwaterloo.ca; i=@uwaterloo.ca; q=dns/txt; s=default;
  t=1723499211; x=1755035211;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mR5q2iepjCWzHHU2JoJ794ebkN6mHmuoZEPlVvqIwjA=;
  b=0KMg9fhORcuy+UMiXdH04BOUudyPzirhqlnwYXXRS4+DqOKbiqbl3rry
   +ES62k4G160lMpnfpw0zUJUm1keO1452XfzvSv1mSPalgyHXBSrkJVoz8
   aYckxJeCDgVRGCki1Fq0+b8KWBtrF6i6I3hSgrPs7FliJWezCsi19ie+P
   o=;
X-CSE-ConnectionGUID: TCB4ShDaT4q4jwsmAhemVw==
X-CSE-MsgGUID: DlG0R/5IRISQsWGChNCUUQ==
X-Talos-CUID: 9a23:ZWA2zWx4Q0DJOno/CzdFBgUoMep5SX3xxUuMOhO6Fn1sYb2YTGGPrfY=
X-Talos-MUID: 9a23:Zx6S+wpVMHtUDjkjvoEezx1mG59SpPmPMmE2qI45lOKEEwdNBg7I2Q==
Received: from mail-canadacentralazlp17010002.outbound.protection.outlook.com (HELO YT3PR01CU008.outbound.protection.outlook.com) ([40.93.18.2])
  by ob1.hc503-62.ca.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 17:46:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BSjHxcY/NK2GKosLS458axOQDeX+Fsr8IPxACqzKeULtVjeHZOL0K83lPCVn2s2B0yikMdQUpVz55vbc9g7xvwm6Tvpx7zxApxShZIo//a3/8cTyOyZ8dg3KnaOgfjFT/6bsCvoL+iWsJdw8OgDT8iR7eFxltRhJbo5rXHaYAeRKjfZkdNKPzyG4w7Dz+ZUL1ghUfxc/70mxn/aDYmuhanxSdDw3qD8a2LCeyz0lFqO8AMIOxi9Q42Kmvz6z+fOkYwMYmeO9vAs5bXtsVEc1x+I9X+OPESu+TtIg1ASglnGotxzXMlHU8pqL9FZ5IFVljYOczzlcvMWWEBD2bkBqDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eLzlmhDoZAYl5KUXDAK0UuHKE2k32uBLwI3ZZImGo9c=;
 b=kZeCIyMfZZRtNnycnNQk8c5kwiaGS8FyIeqfilSelkRL5BJYqagJf86LyFBovl0zX6Szp0rRPX/z2VlW1kC0qW5Gmg8W9GcRg74Za40O5anUs57NaeP3B4hCR6aM28CJxryzAmP83ln2vitg70fatBKxNz3F3krqwoOIVXX+JN9xxJAIrHjQ+BACMuaCypPyAJYpcIo7yWpDhQ5GUvHZq43+ew0jw4CYZAxOx2+kxiATUbT9uJ7rxClUbVUhp+fvd+MHkc6Mh5x8BiAF44z45nvV47EfLFE+KtvMT7CT1ODwbYN6baIgU+3lcC0nV6yN8CtjJw3iK2na7yqIqlfW8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uwaterloo.ca; dmarc=pass action=none header.from=uwaterloo.ca;
 dkim=pass header.d=uwaterloo.ca; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uwaterloo.ca;
Received: from YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4b::13) by YQBPR01MB10832.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6f::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Mon, 12 Aug
 2024 21:46:45 +0000
Received: from YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::d36e:ef93:93fd:930]) by YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::d36e:ef93:93fd:930%6]) with mapi id 15.20.7849.018; Mon, 12 Aug 2024
 21:46:45 +0000
Message-ID: <2bb121dd-3dcd-4142-ab87-02ccf4afd469@uwaterloo.ca>
Date: Mon, 12 Aug 2024 17:46:42 -0400
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
Content-Language: en-CA, de-DE
From: Martin Karsten <mkarsten@uwaterloo.ca>
In-Reply-To: <ZrpuWMoXHxzPvvhL@mini-arch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0315.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10a::28) To YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4b::13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YQBPR0101MB6572:EE_|YQBPR01MB10832:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c0860e2-635b-447c-9155-08dcbb184286
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZlIraS9Lc1hQdFNaNEJPNjNoTlhRdnE0OW1sRzdGTXlPRjhwRDZXMm1VbzNM?=
 =?utf-8?B?S2JBZDF2OHM1YmhoNldnaE1Sb2xyeldqTkIvZEx1RTJjMjdmQjM1SXgvblJN?=
 =?utf-8?B?RUpCSEhnV3VvQ2xEQ29sZnZkTmp0SDRwcTJvTFNvRjlFN0llVGFtQUhrdmVz?=
 =?utf-8?B?K3VhSnNQRTBWYnAxbDU1b0hKVFJaRGhQZmlVOGpSakIrOXQxcDdZQk0vckVY?=
 =?utf-8?B?eHFsNWhXMlpzREN6NjV0ZHJvZGFaWlJsd0pBSTZCcDRvUTBFSlBtRVpWbDlJ?=
 =?utf-8?B?aUJ5S0RaSnNMcU5vUDZUck9WNWRBMmpZNUdZOCtKMCtQMlpPQXNCM1RNY1Z6?=
 =?utf-8?B?R2pva1lNdnlZTVVhbDIyNGdyT3ZZSWFKdUFyTnlibmxOeWFWQm9lVXhTZUpG?=
 =?utf-8?B?Z2Jaek9McUpKTHRkOER2ZGw2RkxCY0paQlRwR2NlN2J5Y01BbktKKzd1bFE2?=
 =?utf-8?B?TWdGUnJDQlo2NUNrT1hxUkdlWEJGVDFSWEw4TUJLOUpyY3gzZVkxUWNBVTds?=
 =?utf-8?B?emREWEF6Zklwc2UrblBsYXNHN1oyUW5tNi9BdjNIT0xBbjVvNkFmU3pveTY3?=
 =?utf-8?B?ZjNsb2lxOEt6VjMvNkV5TFh3OXg5U21pUldCRHg3MjZMTS80eVAzeERYRzZR?=
 =?utf-8?B?ekFnMDFEMmxCdXUwVDR5WkdRMFE4M3Fqc0hmOE1WaldORXJRbDNKa1RHM2RS?=
 =?utf-8?B?ejRjWlRKQWtFN2U2R3ZXVUdQU0J3anJwbk9QZ0NTYm5ja3pFOFdzU3ViUE5W?=
 =?utf-8?B?U1BGMkhHWXNId21mcWxNQU9XTHlNWlQyRlJvTktPVURrd25zdFJLakVQckpT?=
 =?utf-8?B?MW0wZzR5Wm14bEpuc0ROU3JLbUNtTlVBRGpRSm12K3o4Mno0UDZoeGVweVVq?=
 =?utf-8?B?eEZBY2FGQU8vNnhjTUZCUEtXMDJXQmpydWlRMDMzODNwbWJSUm9ORGJOY0NX?=
 =?utf-8?B?MEt3eEFHNjFiQXdaT0phWHNWMlZ6YlRkVkRIVmJYZmp5R2tLTjh1NDEwZEVL?=
 =?utf-8?B?T0dyckZlN0U0TGJCcU5YU1NEVmRnY2FTY3pMSkJpVUpOM3oxS2t1VVBhR09k?=
 =?utf-8?B?dmRVRnVKdWxTUmlLRUs0VmttbVUzQ0VLbW1zM2hYTWdyY3VYL01oVWFPVjlh?=
 =?utf-8?B?U3Z1a3R2SEVHWGE5UHlsa0hBWjV0QUF3Q2VYMDloK0tLMGQ0aU9JKzBBQWlp?=
 =?utf-8?B?WUhOQVJuUGwzSWNXY2s0eU81UXc3NVRxdkp4NmExenFmR0tSOTFpdk1pK3Vw?=
 =?utf-8?B?UGFlM2FZcGFLbUxNUTNiSm5Pa0RLb2FvcXdQMVIwNDA1anoxYWhvZmt2VzFT?=
 =?utf-8?B?d1JscWJTeU9CYU93ZG9Dc05pTHZmVGFFZ2x5enNyUXFHM0lhaUR2dlg4RmQv?=
 =?utf-8?B?eXVlWmpvZmo0bStLVTVGaUd4Vk9NTmdaaG5iMEJkbldpOXZ6NkYrRzRSWmVJ?=
 =?utf-8?B?RlJYUWRFb25BN3ZMZGNFZFg4WmJsbmJpSmxWQjZ2OW1GaEFlUldFam5yc2pm?=
 =?utf-8?B?SDdVcndzV2hwVXdUVDdoQWlxQWF3L2NOZnREN1JTdVJhT1dQMjhReCtyVVRR?=
 =?utf-8?B?QWhXSllhaXNOOUlYVGE1emxZcDlPT010TE9KODgvWE9PQjJBaUlvYldNVXRQ?=
 =?utf-8?B?TmVNY3Q5SU1QTHR3U1h0ZjRadmRlVm5kYllVMmgrR1FCUmZ2Z2U1RXVPZThK?=
 =?utf-8?B?Z3ZldDhuS25Vbmt3SHdXNlJTaFpLYnVtMDlKVktKSWV6SkJVRFp0ZmhLdjhw?=
 =?utf-8?B?cm01L3NvZ1lwNFlpWVlzbjBiSEJNejJoZFZJSlIzc0lWdmdpUG1KRUhHQzJJ?=
 =?utf-8?B?cEp2WktVRVIyTEYvZWF3UT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YzY2Q1oyd3ZGZTRmSWdUYUh1YnArRUdyY1ZzbyttRjRWTzRIcVJJUnkraXN6?=
 =?utf-8?B?WVpjTFdsVjVSWlBmZ2dqbElPR2htSmw0UGtzaXJIQmxzeDc0NTNTRlhndWZE?=
 =?utf-8?B?NURwZTlSRmhIMjU0c2VxQU9HRXJkVS9LOTVPcUM2eHRBalhHL2o1RUdHeVVy?=
 =?utf-8?B?bjByeWIxTFZxbzh1dnM2TW9vako0WlhyZVNORkFxVkNVaWtTd1R6QjdyNU5w?=
 =?utf-8?B?bWRaMVhnNUU3RThuQk02NEc3cGJxZE1CN3p3UVFVTkxscURKemh0b21jMlhZ?=
 =?utf-8?B?QXBTVVJpUUFidC9SYWZuVFBpcEhua1ZINm90cUpVY2hhQjMzM1VJeUFOM1g4?=
 =?utf-8?B?L1REVVNzTU1lNjhyd0xXMnc1dFY5WG1jQWZWbWdTRW1EQU5aa0hqSk1VY2dW?=
 =?utf-8?B?amlocFhhakt4MkdkYXE0cmN0amRtUm5CSWFYaG1DRGpScktaaTJvRStNQTFJ?=
 =?utf-8?B?VGg0S2NQbDEveFIyb09TREdtMWVKZ0o0WkdjRmxzVTF4Y3MxVnJWNmpHdUR5?=
 =?utf-8?B?UVlJK3E1RWRNUkhWc0hJcnZjdEFWMHV3Q2xNNnhLOXREaEF1czdjZGJZZ2Ry?=
 =?utf-8?B?TlBlVDV2bDh5TXo0bmw0bjkwS1hwOWdkMXQwbFhRM3lxWXdXbTJDTFRzREJY?=
 =?utf-8?B?UlN2OGU0bXJSOEZhN2pycTkybGU4TFZ2MEljQjRBZHU2OWhLQzNnR3dFVXZK?=
 =?utf-8?B?V2pRYlNQQ2VlL3lneFJrTHZKUEhUWGhjMVBqb01rTDR2c1ppUWxYdlRaa0V0?=
 =?utf-8?B?NzRPVWlmQ3cxUUV3czR4SkJnNWgzRTk3T0IvMFM2eWtZVjVHcVJkeGxDRFFk?=
 =?utf-8?B?YTQ1WkZ5ZHRnbG91NjMwTjNXZXp2eGxTV0dSRFFQb0lPM1B3QjFtM3N1SHVJ?=
 =?utf-8?B?bDZyc2tCcDB0VHhRNXNiSEdCRXkvQk15RU1iN0FzTWxYRG5lM1N2TTRFTjg2?=
 =?utf-8?B?Z0FBb2tzRDNxRlJML3JSVFlnRCtKNkNLaTNacXRsbXRyL0ZxUGdPU09Kb0M5?=
 =?utf-8?B?US9QYU5SZDVEbmlwWStkVEdVcXBBamJob0JweWJ5bHhSc1VrZ0dPTDlwSnJv?=
 =?utf-8?B?dk5kTmtXcUdzSUY3amxDMHN5VHRXekI5N05adytBZG1nRThIbFRqR3FQeWV0?=
 =?utf-8?B?M3VVTlZVUXM5NzJWSHpQNERQTXpybzBwRFQ0bFd1YlhIV3FncHBhK0syejNS?=
 =?utf-8?B?aWlpejhOd2hVYU1XS1hTcnAycmZiYkQrdlYyRy80clFBRzFrL05la0J4S2NO?=
 =?utf-8?B?ekltNmJnQkVMc0krdVQ0dldrK2RsdFVzVy8yRXAvQlgrdHB6SWdzc2V6UTJQ?=
 =?utf-8?B?NXY2WTZEYmpLMWFwK3lPNkhydDRjUVBzZ1hnaTBrV2pwL1BjMmNjVEZQTjE5?=
 =?utf-8?B?TXdBOTNaWHRWKzROSkVRS0cxVWVWY1ZEOTZMTGxxSTUyUXZtckZPcXcvekNU?=
 =?utf-8?B?TjR0cUVTN3c2Nk1yZnpEcXFuTTk1MDNNOHB2djZwSFlycU5OalNlblZRNnF1?=
 =?utf-8?B?QVViSnlGZ2R2L1ExbXE2dWt3TWZGb21HSUYrY2d0UExLUXB2TWFrZTB3d0p5?=
 =?utf-8?B?bG92K1l1bVBsS0s4aVJ1bUJFRTlBRU9mTTQ2amVVdUYyRFJERGRVNjBHdXht?=
 =?utf-8?B?V3BxOXI0STZjU2Q2bEkwMlhlWG4wa0Y1eU1xMUtSNmtPMFNZQ0JXSWUwVHdq?=
 =?utf-8?B?VkJSZmFOb3lzZ3lmbHBEaG5sN2RWd0syOFpFY1BsU3B5aWVRWlZMeG9sa2xq?=
 =?utf-8?B?VDZaaTBuMmc3V24xeklMUWxGbnVXNWFtdHlObGpvWkx5MmkrTjNSdVRlTFFY?=
 =?utf-8?B?b3E5QzRkeC8xQWVJMGQwa2owb1RpNzlhcHNIdmZ6WUpKMUxoWHdiaGVRR0JX?=
 =?utf-8?B?ZVRMVDR3Zk84TStJVTh0YkQxTUlHaVFEZjA1ZzdMZUNFSFRjSnhQUERqSmFK?=
 =?utf-8?B?WmZmNXN6OGRwK3ZYWVNwTFBNQm1kWFVyaTN5WEZ6aE1kcjlQMTFsd1dCenY3?=
 =?utf-8?B?U0x6RnYyUkZ2RnhySFI4YlFyaExxZExyd3hEcGdac2ZvcXZkZzhFcWZLSTIr?=
 =?utf-8?B?emorelRhWmt0Sm5mQlQ0N3luYkNoZ1RxRnBTVGpDS2ZvL3dkSE5pcFZZN0lK?=
 =?utf-8?Q?ZdKJZD19cn+oilC3n5X7ZO51Q?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UvGutpASwDmdAzwrTVcnmCQdE3CdDsvey2YjCncedQ43Dq6urQ89ypzrYjiX8I7znVIViD+KTKW93J5M4m8EyvCOhT98NQB60BvgUBWKi/UPdkEK4Qvh02I/l2EXxpIvPLAr9/hJPumq+bcXtp2P6CDnrStJ5XjxUCn8Ew/HMd47/VZoY45I6Xm3dKGFfzcsN+80DAwCJiXzS+pp4fZqqQtHZvRJYAuSjBWpiagwRQZDOOUk3BhcZPxF5r3vxt3pBRQve7oY+0vIBaAT76Sjw1xqO61RGLpsorcKwN14pOOHBiyx1v4OLWvH7hBXYxzTsa1LISUeH5eLK6cJS0v7uPwu0CpZVjp2z/h8uQ0MDnv1HUivLyO0gBP1f5MCK5PkALUC4hE/ZRBlivQL6tfewxgPtKIOCryznWCCuJKw695uth0oozq4rlA99+TlOZ2Q0Yo12qrLfPAMF5hD2XavczSssUrRMloc8WQ80Wi+6MBAyosDvuaeRLEZGGMRUBA68/akBQn07i58D+/LWXp8xZmdTwTuqRj5536xNAOxdulFkfWVTdCJMh/cEw0jj+ibfLHQJ5dnHZKwz4DJ4GKwT3k/GOYv8rypFyFBz4gvM0j5pMdEiTNFsYK8oTok5CNP
X-OriginatorOrg: uwaterloo.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c0860e2-635b-447c-9155-08dcbb184286
X-MS-Exchange-CrossTenant-AuthSource: YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2024 21:46:45.0432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 723a5a87-f39a-4a22-9247-3fc240c01396
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4cYYatssH+/a3D6igR2lU9V6N0NNeJDoIAeceZZBQZvqIZBS0B2HIHN4iVumq+oKZuf2QBxuvgh2eQ+9OzitEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR01MB10832

On 2024-08-12 16:19, Stanislav Fomichev wrote:
> On 08/12, Joe Damato wrote:
>> Greetings:
>>
>> Martin Karsten (CC'd) and I have been collaborating on some ideas about
>> ways of reducing tail latency when using epoll-based busy poll and we'd
>> love to get feedback from the list on the code in this series. This is
>> the idea I mentioned at netdev conf, for those who were there. Barring
>> any major issues, we hope to submit this officially shortly after RFC.
>>
>> The basic idea for suspending IRQs in this manner was described in an
>> earlier paper presented at Sigmetrics 2024 [1].
> 
> Let me explicitly call out the paper. Very nice analysis!

Thank you!

[snip]

>> Here's how it is intended to work:
>>    - An administrator sets the existing sysfs parameters for
>>      defer_hard_irqs and gro_flush_timeout to enable IRQ deferral.
>>
>>    - An administrator sets the new sysfs parameter irq_suspend_timeout
>>      to a larger value than gro-timeout to enable IRQ suspension.
> 
> Can you expand more on what's the problem with the existing gro_flush_timeout?
> Is it defer_hard_irqs_count? Or you want a separate timeout only for the
> perfer_busy_poll case(why?)? Because looking at the first two patches,
> you essentially replace all usages of gro_flush_timeout with a new variable
> and I don't see how it helps.

gro-flush-timeout (in combination with defer-hard-irqs) is the default 
irq deferral mechanism and as such, always active when configured. Its 
static periodic softirq processing leads to a situation where:

- A long gro-flush-timeout causes high latencies when load is 
sufficiently below capacity, or

- a short gro-flush-timeout causes overhead when softirq execution 
asynchronously competes with application processing at high load.

The shortcomings of this are documented (to some extent) by our 
experiments. See defer20 working well at low load, but having problems 
at high load, while defer200 having higher latency at low load.

irq-suspend-timeout is only active when an application uses 
prefer-busy-polling and in that case, produces a nice alternating 
pattern of application processing and networking processing (similar to 
what we describe in the paper). This then works well with both low and 
high load.

> Maybe expand more on what code paths are we trying to improve? Existing
> busy polling code is not super readable, so would be nice to simplify
> it a bit in the process (if possible) instead of adding one more tunable.

There are essentially three possible loops for network processing:

1) hardirq -> softirq -> napi poll; this is the baseline functionality

2) timer -> softirq -> napi poll; this is deferred irq processing scheme 
with the shortcomings described above

3) epoll -> busy-poll -> napi poll

If a system is configured for 1), not much can be done, as it is 
difficult to interject anything into this loop without adding state and 
side effects. This is what we tried for the paper, but it ended up being 
a hack.

If however the system is configured for irq deferral, Loops 2) and 3) 
"wrestle" with each other for control. Injecting the larger 
irq-suspend-timeout for 'timer' in Loop 2) essentially tilts this in 
favour of Loop 3) and creates the nice pattern describe above.

[snip]

>>    - suspendX:
>>      - set defer_hard_irqs to 100
>>      - set gro_flush_timeout to X,000
>>      - set irq_suspend_timeout to 20,000,000
>>      - enable busy poll via the existing ioctl (busy_poll_usecs = 0,
>>        busy_poll_budget = 64, prefer_busy_poll = true)
> 
> What's the intention of `busy_poll_usecs = 0` here? Presumably we fallback
> to busy_poll sysctl value?

Before this patch set, ep_poll only calls napi_busy_poll, if busy_poll 
(sysctl) or busy_poll_usecs is nonzero. However, this might lead to 
busy-polling even when the application does not actually need or want 
it. Only one iteration through the busy loop is needed to make the new 
scheme work. Additional napi busy polling over and above is optional.

Thanks,
Martin


