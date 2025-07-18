Return-Path: <linux-fsdevel+bounces-55451-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1958DB0A9D2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 19:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13BC9AA31E1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 17:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795902E7F2C;
	Fri, 18 Jul 2025 17:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="d0iJTePR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip191a.ess.barracuda.com (outbound-ip191a.ess.barracuda.com [209.222.82.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A442E7189
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Jul 2025 17:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752861039; cv=fail; b=BnJ1JxUji2Gm7luUQxeVKZaWHowIYUn23bs4YkoN/OA/s0yM6yxO+R3ay9WobZyyRtX0xo4FIfkQ07gYIsrbmd+iTVtppt16WUCgyHib1gkLfr9691p+/o9sA3LOmzoYF+hVA47j8id35ffSJWgoybmhtV47A7d6MK6ODrxs3r8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752861039; c=relaxed/simple;
	bh=HTJEBshRMO6eoJFvzdgxQGf7yAoJqAO1z6Is9gv52p8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UofhyPRArHh3yI4fWLzJEtCf0jGErwGNEIxMIreSh9rkxIUtxg14MtVs8mTYOfkDanHTVTCRKc8YnYKLqUcMi/J4NGOA1g/1s1hCT9rdx/LUE6eWlFPWrfs89glJqP+qtUWZBHpaunoYzI2nTNkXEiLxw02X0G4BkYwK9UW6+ww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=d0iJTePR; arc=fail smtp.client-ip=209.222.82.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2120.outbound.protection.outlook.com [40.107.92.120]) by mx-outbound42-76.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Fri, 18 Jul 2025 17:50:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XXTeIK4Q4rxIT8MIwDHSVfiRVKiO49oa74Rb9yIVgVYeNDvPK+CnfgX+8/LRTWNWEqhnqjNsjE792PIA11uDv1ZnZURKEvYxT1zfJE3KTHdUvTDpNN/REyGbxHqcbgvdwr+VvBUjU6jURf8mGjJAE/gNiyHfs7dA6ra5iJcyASd75lYRn/tNHV1FwnPRjMqu5M4AutI0mhlK+BC3L7pwl+05FTF2RP7Yqge6Mb4Zc79tfJjrz6d7eNHvwcjx4gp3OdR9culXlRZqFjZZQTkmxcq7aW/ZbeWsiKyrknkx2qpuUZYYUySMu40GF62xBn9iqNSlAfsyJ1/aXX7j5UnL0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HTJEBshRMO6eoJFvzdgxQGf7yAoJqAO1z6Is9gv52p8=;
 b=ksocJ0IW382Hn+uok/lpXj4od3f4wBc1t68RlNl92rJU1ESd8xWYjOJZNHSW3yye8wRFUj2nHYOmUukVd1b+yGa+cYPZzK6S824xnEcgx0NJTfFwWDkvPduBJc2wG8HNrjh/hYJEBV0CjcI2rSQYYIkn+N/aONO+vSlOIBc3yVyBdXN0YxbIzZYXkMgqw+y4g1FlGekoiRINz7KjAF5tRhQDUXhIkHThnXWWKnsGHJP4P8EMoMTDssF44t0HcxvS1gBRZACAjWNLyiel+LLQI6QFz4xJARHkqBRijmp6TkC4s2Dz4PU9XlflAaW7X4yxEz/AMvIdD23FIHfX2VttxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HTJEBshRMO6eoJFvzdgxQGf7yAoJqAO1z6Is9gv52p8=;
 b=d0iJTePRYQGp5q8scdKICTjcjf9FLynupsy0bfAo34BtxSLKWFjhTU3gIfCi6PG19V56PVlu+xvdgIequFW1kk7Nm9QkbonDEOlTpVjQyqOpr4hI9P1etW7F/clsSgervSaXkEB1WTwcZFrpX+xzWofILgcG4VcGPr+O+3n8fJI=
Received: from CH2PR19MB3864.namprd19.prod.outlook.com (2603:10b6:610:93::21)
 by DM6PR19MB3914.namprd19.prod.outlook.com (2603:10b6:5:247::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.24; Fri, 18 Jul
 2025 16:16:28 +0000
Received: from CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03]) by CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03%4]) with mapi id 15.20.8922.017; Fri, 18 Jul 2025
 16:16:28 +0000
From: Bernd Schubert <bschubert@ddn.com>
To: "Darrick J. Wong" <djwong@kernel.org>
CC: "John@groves.net" <John@groves.net>, "joannelkoong@gmail.com"
	<joannelkoong@gmail.com>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "bernd@bsbernd.com" <bernd@bsbernd.com>,
	"neal@gompa.dev" <neal@gompa.dev>, "miklos@szeredi.hu" <miklos@szeredi.hu>
Subject: Re: [PATCH 1/1] libfuse: enable iomap cache management
Thread-Topic: [PATCH 1/1] libfuse: enable iomap cache management
Thread-Index: AQHb93PlEXyFTLJbhkyGJjo+xflLsLQ4D7kA
Date: Fri, 18 Jul 2025 16:16:28 +0000
Message-ID: <573af180-296d-4d75-a43d-eb0825ed9af8@ddn.com>
References: <175279460162.714730.17358082513177016895.stgit@frogsfrogsfrogs>
 <175279460180.714730.8674508220056498050.stgit@frogsfrogsfrogs>
In-Reply-To: <175279460180.714730.8674508220056498050.stgit@frogsfrogsfrogs>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR19MB3864:EE_|DM6PR19MB3914:EE_
x-ms-office365-filtering-correlation-id: 31f955a9-58ad-4b56-14cc-08ddc6167357
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|19092799006|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WDBGd1ExUnhiWkY2YUkrZUJOS0NXbFdaMkNxYWg2OVVOczNUVjBlTlc0N2p3?=
 =?utf-8?B?OEtOQnNSc2liQXZSb296SUNJbUN2cWNPVFFEL3FVYkpDZ2RjWk90d2lSSDBp?=
 =?utf-8?B?QnlKQmFESG9FeFpNSHhkWHUxM3JTdzB4dmFibm53Z1QzMUVUWk4zejdWeHJr?=
 =?utf-8?B?VlltRjRidWVnUTZTemtuNWM4czRpeC96VzNlaFFSc3BnQW9DYWc1WFA5R3o0?=
 =?utf-8?B?KzN4K3NPTVhyUlI5ODJNbVJQdXpkRXJsV1NyVFVCYmgyLzh0aUJ2MnhtVm1N?=
 =?utf-8?B?dVlWSkZrVmJUUWhsODZ5M2pMQmhSbnFDNDdlTHVtR1NKOGpQQTltUWpEQ1lP?=
 =?utf-8?B?L2xKb1J0R1pLZnFJMTBVMzNKaFhqRGFrOG14ei9hT2Q1TkozMDVua2U3QWhD?=
 =?utf-8?B?RDlIUG5IK0RzaWlaaGVSL3VERlVEaDR4QzBnUGZ5em84K2pXbWVlRHRTYmpT?=
 =?utf-8?B?aldPMGZab3FjTGdkRGFqdHQxQXJtU2hMYTQvMDRGM1pYOEV2dk1UT2RHeHdh?=
 =?utf-8?B?OVgrMjRscFZDVS82WmR3Y2gvbE1GYlM4Z1RHdjd0UlBQTVFEYUFUZjNHV2tP?=
 =?utf-8?B?M0F4RzFaTnJFQVNBVFNWdGRqZUVISGVESnF5MzZ5djVBWVlhQ1Jzb242Vkwx?=
 =?utf-8?B?bU50M1NVSjBnb0JDOU5RYjdoWDd6bFB5NEplR1VyVHhXc0xtWHI4QUlWWUhx?=
 =?utf-8?B?ck42YWl2WjdXSjkxTjdsVC9NU2J3a3FwNG9BVEtTS0RLY2ZGQUJlZEJEY2NC?=
 =?utf-8?B?VC9zTHpvYWRGNTVHRVNxQVBlNE5YTnR1endUdEV2ZDVJSXhvNHM1c3lwQ0dG?=
 =?utf-8?B?Wm13RlIxdnZUT3pkNFNBTDRlWGNOSHVFdDFPZm1QSUdhbkdkZTVxdTFVN1NI?=
 =?utf-8?B?aGFLbG9GZXZGTUFwazc4enpRZkZ2RGFVV3I4Y2xUc2RsSXcxSitwVWxYanhY?=
 =?utf-8?B?d1YwQ1RDY3lRLzN4Z0UwakFrRy9ERUFiNHhoSjIyM1Z5UkRkUGRZcGlNb3RY?=
 =?utf-8?B?QzdPNThnUnJZdDZvY2s1TWZ4SnJ1K1ZPMjltRlhwRkRSelFwak05V1RBNkJK?=
 =?utf-8?B?ZGZEZjI2R0xMS0lDVDQybXZ4WS9tUGRpeGNhbzV6NmMyK1o4YnRRbnRaY2VS?=
 =?utf-8?B?aEtxSlp2N2pZMGNrQ2FuckJNei9LeDhUd3dwMlcrNWxPaFN6bWZXWWR0YURo?=
 =?utf-8?B?RTJLd01kdE5kUHgrNVdOUzVXSy8wTkd2ZXh2bStkR3dNTnBxQVdlRlZBOVlV?=
 =?utf-8?B?Y0lnbGhlQlpSd3FWc0JtdEhPcDB0UEhZWENwV1NEcTlvMlE5NVM4cEhPU1lJ?=
 =?utf-8?B?dlQvNVRsamprYjdFeitKQkxHREQ5bmQxcTdRaXNBdTc3YlRTVmJpcElCQ2hz?=
 =?utf-8?B?NFBralJJdnRqaFJVYmEvcXNETVBvSTd2ZzBMRWNPbG1tSVpJcXdibkxnQ3lq?=
 =?utf-8?B?TDRUaDFEbG9hN0NVWUxrNzRvdEhubmorY1ZMUVIyVUNiNE1iVkwwUzIrRzV4?=
 =?utf-8?B?a3Zua2xPUGVGQ3E5c1R3aDZXZ3M0L0JUL1NuNWZZRVV3TmhuUkRKVzBOakN2?=
 =?utf-8?B?MkhGOUZCU3V3cEpoUnU3UE9NK3g0NTlDa3diTVNJWHROUWU0Q2hYREVtekV4?=
 =?utf-8?B?U2tlZXM4ZUdkL1ZCOHpGS3hKZVgrNXVwNEpwdmhydEZrWXR1Q0pZdHRkYTF1?=
 =?utf-8?B?RFB0RHJRT0ZseW43MWRNVjEwTmhwTldSYjFJUUJoQmdDUDdUOC9LUWhBbm42?=
 =?utf-8?B?Tkppa3VhcjNFUGdZNzJvaWJjazBOZmRMb3ZFcHdiWHhBU2pzQXdiNWltWFh0?=
 =?utf-8?B?OVRLczUxeTYzb1hIcjZJa2laUkhFVnc3cWoyajB3ZG9BMkV5dWZHbC9aQ2k3?=
 =?utf-8?B?eXlPM1JEN2I4bVk0Y0JvOUNGUStkcld2eHEwNUhqQXlWQUk3RndVNlFubEtp?=
 =?utf-8?B?OUNacjNnd21YZFBHVEcxTkZlYXc5Nnp1cVA4TWsyMm9RR3VjUTVrQ1VMbnla?=
 =?utf-8?B?aWdQZ1I1WTVnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR19MB3864.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(19092799006)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Y0dwYmFmV1h1VFJaeUIyanJZOTM5aFViUk9wZS9wM0dONjk5MWtFVFdtdVBq?=
 =?utf-8?B?TVRmOVdoWS84Z290QjVVRjFuU2w4a1hMbFplaVdocjJNdVA5SFQ0enR3K0d4?=
 =?utf-8?B?N1JpRk9VWnhLM1JnRmM1Y3kwYlNaRVRabXBwcFUzeHlaZ1k5ZnlkVDFvNWs2?=
 =?utf-8?B?azd0ZWFHTlJjOFV3bmhwMzhsdkpHT0hLQUsvTmppOEZkbStvT095b2hmSDA3?=
 =?utf-8?B?ZWNUd1hoS2hmNTNIWG10QXRpZ1dNUGtPU0xXaXpqR2ZBUEMrNFdKWjFNQVBV?=
 =?utf-8?B?S0ZnL29OeVZjNDh1Wnc3Q3FqOVc2Z0RndUhrRXJvUHZvUEhnUisvV2thVWkz?=
 =?utf-8?B?TzNoUmFnOWMyTmU0akpuaTRIdHBxckhRSklyR1hNL2ZVdFRSSG8vSU1FLzhj?=
 =?utf-8?B?M0pNUFhVc1Q3SGlmeDM1Z09qZktUbHhVQnZBQStGZXBYaGQ0ek9LZ2NFajZO?=
 =?utf-8?B?VFF1bDNSTmVUbkltWVV3eVIvOG43MHJmWEJEWkdpWFNTRk1tS25Ydmw1bW5p?=
 =?utf-8?B?eGNGK2d3L1U0a2Fla3NmTFVPdm5iUFlzSGkzM3RCWWZDYU1yMjhhdU9pUG9C?=
 =?utf-8?B?ZlJ2dEhwcXp4OUx5KzIzV2k1c0U2a0huMHJHYmhjaXF2ckpuUU9qN0EzMTVV?=
 =?utf-8?B?SW9CVTY3bWFWNEtXdSt4SWNYNHNmbnVMbGtQL1czUDV0TU40dS92a1NkdGJ1?=
 =?utf-8?B?UXNNWmRyRzR2KytoTmgvNlF0MjhNYUlxTXc5R0tNTTNqWE9aSlZFRFkydFoy?=
 =?utf-8?B?ZTdqWWJqUkZyK2tZeDlFZDFRRUd5U0hUaExzL1ZZcThDWnlpUG1vcit1a1R2?=
 =?utf-8?B?Mkp5eTZSRkQ5Rk5hdnRqNkUzemhoaVRHTTN5NDJFRk1PcXhJdVBWWWNZK1VI?=
 =?utf-8?B?cTY5V2VFSVVBaXZ2cE9nY2RmdDI0bXVGSlhFcVFJSG9saEFlMExFNWFCNm0v?=
 =?utf-8?B?TkdZcHR1aEFMY09NWTdTTUN2UGtSQTdyaEZES0xLdnZrMGVvT2FmMUFzSTRD?=
 =?utf-8?B?a3VIdC9ML2g3bW45a29ER1Q0RU9Bdjg4YklGclRteEZCVnVKbUZ0OHNWQmFr?=
 =?utf-8?B?Vi9ZNEE3MS9NcldJeERteGhKR0R6VkFDdFR3UjdjcHZ5OGZPZ1U5RGROSFNl?=
 =?utf-8?B?TXVJSTVBRjRiQk5tRTFCMVhLbS95Z0hndW9zRjJpbG1qWFRKN2licExBZnk5?=
 =?utf-8?B?OG9ydHMwbmRpNWZxcURSQi9BS1RxM1UrMndnTVlpK1NWeDV2MmEwRWZuUnVT?=
 =?utf-8?B?ZEVqYlVPN01TQTloalYxR2E3UTVCWWw2VjJ6ajY1WUtGTGltbVVldmdEM3ZX?=
 =?utf-8?B?TG1KK3hKNzExb0sxWEtMdXQ4VkpJSTZvaS9lZzYrSVZ4WnV0SDZ3UG1CVHdz?=
 =?utf-8?B?bWk1dDExYkptSmtPcllZTGFTV2t0U09kT0VlWkxkd3VnMEFEcXFFS3hsZmVQ?=
 =?utf-8?B?RkxKdzlUZGhQY0pWYjhYRzNqS0xvTGdIbEtDeGpOQzNOaTQxRWhyQ0dVMTE3?=
 =?utf-8?B?eDdKV3kxL2tUaWV6MTNCdFBHQTJCdWFjSzBvU1g1NHY1T2pXcWVvNjhsVTkr?=
 =?utf-8?B?dTczcmg5enJQYXFnVXcwVWo5SzAvZ2EweWRvbWh1aTZtblJBaEZ3VWlnZzNx?=
 =?utf-8?B?OGRMU01MeWdyaUFLTHVJcGRFQ2gxWS9VeUdmaHRvSnQwUitXTWJtNjh4c1hE?=
 =?utf-8?B?SFBrVWVXYVFvSkRKdy8rSGthVkNJeWNvWERkSHU4czlEQWRCQitXSVJjamlE?=
 =?utf-8?B?V0dSbHVWMm5TS3lDOE1UTWdQcWtkZktQc3ZZNVJ0ZFZrUzRTWThMRGhzV0Rj?=
 =?utf-8?B?ZjJjNTdFc3dwVmQxWjFkK3I3a3ZXTERJdGNsSDN0c3Nnbmh3T3JYZFAxQVda?=
 =?utf-8?B?OGtvaHpvTkQyMVJoZXkxTjVsNVM2c2V2R3htRWxrQ2x6alNJVmcyZGU0UjJr?=
 =?utf-8?B?NVY2ZDBHcHN4VFBaRHE0T3BJVGZ6Qkk5d09weDBDOUlxU2VTL1NnR0xNL01o?=
 =?utf-8?B?OHBxcWtnZTdjVkYxSi93Q0trTUpob3JpRFBlM2JqRjFCazFOL0h5R25pSkZ0?=
 =?utf-8?B?U0NNSFVlRTZTYnVPeFlmaWN5aVQrNjFUVWsxVTk1UXpLWlhiOTFQN05yeE5z?=
 =?utf-8?Q?AGZo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9682B7B84089614E8820820AD5036C01@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
 6u4xyE3AuaLTgmtZ4BHZEH/GC2gdA6Z2hQHd+FXiE2HDJZSQf0jkDpE9rRwdSv/CLg/aV0oGkhGVADv4lrKlWyh8YZkROMGzdmPb9c4dqyc4z0GvVUDAQwg2NFYinQbqEaWQS5FdhV3T4TdT3pF58cH36hs/hnXiRzoPpOSrgBVu0Y7O3/LqCbfRqhq5L3YT42zkAwYa8hbvCbvpY77QnsEPv3M0ykj0HT1nJKcw45AmBhfyS+8n0syjFhq6o/SjRAvQMRNTMEw/JkagVokjjR+wa2ZNaIvB22SA0lmQ9CUz5olsi1eostotG8syVHMIi40+k8AmRQ89gAqGp3qkqLkKxw1+mCnKkybf3EJPtq8Kwj+0Bqy6qqP1dHAhUM6ZDtXYC5NrQ7tpGnMT8AmpuQCSiblO00gCuqJVTcoUVXlC91vUaTqsRbeB1Tj4OEwy8kl+8ZaH6WHwhXFCSO5W63NxF2Ol9epqCizu8Arhe2E/G3RVhkgdMgnsnyxyfIy4+FLOMvVW+HGDIcqrITYXqXrUbGiAM7DWaVV2rHPDIniSAcULi/mfj6SnN7jxCLtAParQLcstnHzaEUNfdDOkZGz3T/z1iHhb2Vx+qDHvQULdY4atHxhu4biDNaOq28vvSeP7B5n56nKhEozT/HDP9w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR19MB3864.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31f955a9-58ad-4b56-14cc-08ddc6167357
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2025 16:16:28.2878
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KHXJ455PhKVDklZ07AKnEbSUUqEndgiiXTebkBc+bxfa1PfItHLdou1xkECcYB4UCGlXBHqIRPj5JxgSe4SI9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR19MB3914
X-OriginatorOrg: ddn.com
X-BESS-ID: 1752861035-110828-7612-19142-1
X-BESS-VER: 2019.1_20250709.1638
X-BESS-Apparent-Source-IP: 40.107.92.120
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVqbGJqZAVgZQMNHYLNHCKMk80c
	TSMC3F0sTSNM0gOcXS2NI4LdU4Oc1cqTYWANtSkT5BAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.266138 [from 
	cloudscan15-242.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

T24gNy8xOC8yNSAwMTozOCwgRGFycmljayBKLiBXb25nIHdyb3RlOg0KPiBGcm9tOiBEYXJyaWNr
IEouIFdvbmcgPGRqd29uZ0BrZXJuZWwub3JnPg0KPiANCj4gQWRkIHRoZSBsaWJyYXJ5IG1ldGhv
ZHMgc28gdGhhdCBmdXNlIHNlcnZlcnMgY2FuIG1hbmFnZSBhbiBpbi1rZXJuZWwNCj4gaW9tYXAg
Y2FjaGUuICBUaGlzIGVuYWJsZXMgYmV0dGVyIHBlcmZvcm1hbmNlIG9uIHNtYWxsIElPcyBhbmQg
aXMNCj4gcmVxdWlyZWQgaWYgdGhlIGZpbGVzeXN0ZW0gbmVlZHMgc3luY2hyb25pemF0aW9uIGJl
dHdlZW4gcGFnZWNhY2hlDQo+IHdyaXRlcyBhbmQgd3JpdGViYWNrLg0KDQpTb3JyeSwgaWYgdGhp
cyByZWFkeSB0byBiZSBtZXJnZWQ/IEkgZG9uJ3Qgc2VlIGluIGxpbnV4IG1hc3Rlcj8gT3IgcGFy
dA0Kb2YgeW91ciBvdGhlciBwYXRjaGVzICh3aWxsIHRha2Ugc29tZSB0byBnbyB0aHJvdWdoIHRo
ZXNlKS4NCg0KPiANCj4gU2lnbmVkLW9mZi1ieTogIkRhcnJpY2sgSi4gV29uZyIgPGRqd29uZ0Br
ZXJuZWwub3JnPg0KPiAtLS0NCj4gIGluY2x1ZGUvZnVzZV9jb21tb24uaCAgIHwgICAgOSArKysr
Kw0KPiAgaW5jbHVkZS9mdXNlX2tlcm5lbC5oICAgfCAgIDM0ICsrKysrKysrKysrKysrKysrKysN
Cj4gIGluY2x1ZGUvZnVzZV9sb3dsZXZlbC5oIHwgICAzOSArKysrKysrKysrKysrKysrKysrKysr
DQo+ICBsaWIvZnVzZV9sb3dsZXZlbC5jICAgICB8ICAgODIgKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gIGxpYi9mdXNlX3ZlcnNpb25zY3JpcHQgIHwg
ICAgMiArDQo+ICA1IGZpbGVzIGNoYW5nZWQsIDE2NiBpbnNlcnRpb25zKCspDQo+IA0KPiANCj4g
ZGlmZiAtLWdpdCBhL2luY2x1ZGUvZnVzZV9jb21tb24uaCBiL2luY2x1ZGUvZnVzZV9jb21tb24u
aA0KPiBpbmRleCA5OGNiOGY2NTZlZmQxMy4uMTIzN2NjMjY1NmI5YzQgMTAwNjQ0DQo+IC0tLSBh
L2luY2x1ZGUvZnVzZV9jb21tb24uaA0KPiArKysgYi9pbmNsdWRlL2Z1c2VfY29tbW9uLmgNCj4g
QEAgLTExNjQsNiArMTE2NCw3IEBAIGludCBmdXNlX2NvbnZlcnRfdG9fY29ubl93YW50X2V4dChz
dHJ1Y3QgZnVzZV9jb25uX2luZm8gKmNvbm4pOw0KPiAgICovDQo+ICAjaWYgRlVTRV9VU0VfVkVS
U0lPTiA+PSBGVVNFX01BS0VfVkVSU0lPTigzLCAxOCkNCj4gICNkZWZpbmUgRlVTRV9JT01BUF9U
WVBFX1BVUkVfT1ZFUldSSVRFCSgweEZGRkYpIC8qIHVzZSByZWFkIG1hcHBpbmcgZGF0YSAqLw0K
PiArI2RlZmluZSBGVVNFX0lPTUFQX1RZUEVfTlVMTAkJKDB4RkZGRSkgLyogbm8gbWFwcGluZyBo
ZXJlICovDQo+ICAjZGVmaW5lIEZVU0VfSU9NQVBfVFlQRV9IT0xFCQkwCS8qIG5vIGJsb2NrcyBh
bGxvY2F0ZWQsIG5lZWQgYWxsb2NhdGlvbiAqLw0KPiAgI2RlZmluZSBGVVNFX0lPTUFQX1RZUEVf
REVMQUxMT0MJMQkvKiBkZWxheWVkIGFsbG9jYXRpb24gYmxvY2tzICovDQo+ICAjZGVmaW5lIEZV
U0VfSU9NQVBfVFlQRV9NQVBQRUQJCTIJLyogYmxvY2tzIGFsbG9jYXRlZCBhdCBAYWRkciAqLw0K
PiBAQCAtMTIwOCw2ICsxMjA5LDExIEBAIHN0cnVjdCBmdXNlX2lvbWFwIHsNCj4gIAl1aW50MzJf
dCBkZXY7CQkvKiBkZXZpY2UgY29va2llICovDQo+ICB9Ow0KPiAgDQo+ICtzdHJ1Y3QgZnVzZV9p
b21hcF9pbnZhbCB7DQo+ICsJdWludDY0X3Qgb2Zmc2V0OwkvKiBmaWxlIG9mZnNldCB0byBpbnZh
bGlkYXRlLCBieXRlcyAqLw0KPiArCXVpbnQ2NF90IGxlbmd0aDsJLyogbGVuZ3RoIHRvIGludmFs
aWRhdGUsIGJ5dGVzICovDQo+ICt9Ow0KPiArDQo+ICAvKiBvdXQgb2YgcGxhY2Ugd3JpdGUgZXh0
ZW50ICovDQo+ICAjZGVmaW5lIEZVU0VfSU9NQVBfSU9FTkRfU0hBUkVECQkoMVUgPDwgMCkNCj4g
IC8qIHVud3JpdHRlbiBleHRlbnQgKi8NCj4gQEAgLTEyNTgsNiArMTI2NCw5IEBAIHN0cnVjdCBm
dXNlX2lvbWFwX2NvbmZpZ3sNCj4gIAlpbnQ2NF90IHNfbWF4Ynl0ZXM7CS8qIG1heCBmaWxlIHNp
emUgKi8NCj4gIH07DQo+ICANCj4gKy8qIGludmFsaWRhdGUgdG8gZW5kIG9mIGZpbGUgKi8NCj4g
KyNkZWZpbmUgRlVTRV9JT01BUF9JTlZBTF9UT19FT0YJCSh+MFVMTCkNCj4gKw0KPiAgI2VuZGlm
IC8qIEZVU0VfVVNFX1ZFUlNJT04gPj0gMzE4ICovDQo+ICANCj4gIC8qIC0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tICoNCj4gZGlmZiAt
LWdpdCBhL2luY2x1ZGUvZnVzZV9rZXJuZWwuaCBiL2luY2x1ZGUvZnVzZV9rZXJuZWwuaA0KPiBp
bmRleCAzYzcwNGYwMzQzNDY5My4uZjFhOTNkYmQxZmY0NDMgMTAwNjQ0DQo+IC0tLSBhL2luY2x1
ZGUvZnVzZV9rZXJuZWwuaA0KPiArKysgYi9pbmNsdWRlL2Z1c2Vfa2VybmVsLmgNCj4gQEAgLTI0
Myw2ICsyNDMsOCBAQA0KPiAgICogIC0gYWRkIEZVU0VfSU9NQVBfRElSRUNUSU8vRlVTRV9BVFRS
X0lPTUFQX0RJUkVDVElPIGZvciBkaXJlY3QgSS9PIHN1cHBvcnQNCj4gICAqICAtIGFkZCBGVVNF
X0lPTUFQX0ZJTEVJTy9GVVNFX0FUVFJfSU9NQVBfRklMRUlPIGZvciBidWZmZXJlZCBJL08gc3Vw
cG9ydA0KPiAgICogIC0gYWRkIEZVU0VfSU9NQVBfQ09ORklHIHNvIHRoZSBmdXNlIHNlcnZlciBj
YW4gY29uZmlndXJlIG1vcmUgZnMgZ2VvbWV0cnkNCj4gKyAqICAtIGFkZCBGVVNFX05PVElGWV9J
T01BUF9VUFNFUlQgYW5kIEZVU0VfTk9USUZZX0lPTUFQX0lOVkFMIHNvIGZ1c2Ugc2VydmVycw0K
PiArICogICAgY2FuIGNhY2hlIGlvbWFwcGluZ3MgaW4gdGhlIGtlcm5lbA0KDQoNClBlcnNvbmFs
bHkgSSBwcmVmZXIgYSBwcmVwYXJhdGlvbiBwYXRjaCwgdGhhdCBqdXN0IHN5bmNzIHRoZSBlbnRp
cmUNCmZ1c2Vfa2VybmVsLmggZnJvbSBsaW51eC08dmVyc2lvbj4uIEFsc28gdGhpcyBmaWxlIG1p
Z2h0IGdldCByZW5hbWVkIHRvDQpmdXNlX2tlcm5lbF9saW51eC5oLCB0aGVyZSBzZWVtcyB0byBi
ZSBpbnRlcmVzdCBmcm9tIEJTRCBhbmQgT1NYIHRvIGhhdmUNCnRoZWlyIG93biBoZWFkZXJzLg0K
DQo+ICAgKi8NCj4gIA0KPiAgI2lmbmRlZiBfTElOVVhfRlVTRV9IDQo+IEBAIC02OTksNiArNzAx
LDggQEAgZW51bSBmdXNlX25vdGlmeV9jb2RlIHsNCj4gIAlGVVNFX05PVElGWV9ERUxFVEUgPSA2
LA0KPiAgCUZVU0VfTk9USUZZX1JFU0VORCA9IDcsDQo+ICAJRlVTRV9OT1RJRllfSU5DX0VQT0NI
ID0gOCwNCj4gKwlGVVNFX05PVElGWV9JT01BUF9VUFNFUlQgPSA5LA0KPiArCUZVU0VfTk9USUZZ
X0lPTUFQX0lOVkFMID0gMTAsDQo+ICAJRlVTRV9OT1RJRllfQ09ERV9NQVgsDQo+ICB9Ow0KPiAg
DQo+IEBAIC0xNDA2LDQgKzE0MTAsMzQgQEAgc3RydWN0IGZ1c2VfaW9tYXBfY29uZmlnX291dCB7
DQo+ICAJaW50NjRfdCBzX21heGJ5dGVzOwkvKiBtYXggZmlsZSBzaXplICovDQo+ICB9Ow0KPiAg
DQo+ICtzdHJ1Y3QgZnVzZV9pb21hcF91cHNlcnRfb3V0IHsNCj4gKwl1aW50NjRfdCBub2RlaWQ7
CS8qIElub2RlIElEICovDQo+ICsJdWludDY0X3QgYXR0cl9pbm87CS8qIG1hdGNoZXMgZnVzZV9h
dHRyOmlubyAqLw0KPiArDQo+ICsJdWludDY0X3QgcmVhZF9vZmZzZXQ7CS8qIGZpbGUgb2Zmc2V0
IG9mIG1hcHBpbmcsIGJ5dGVzICovDQo+ICsJdWludDY0X3QgcmVhZF9sZW5ndGg7CS8qIGxlbmd0
aCBvZiBtYXBwaW5nLCBieXRlcyAqLw0KPiArCXVpbnQ2NF90IHJlYWRfYWRkcjsJLyogZGlzayBv
ZmZzZXQgb2YgbWFwcGluZywgYnl0ZXMgKi8NCj4gKwl1aW50MTZfdCByZWFkX3R5cGU7CS8qIEZV
U0VfSU9NQVBfVFlQRV8qICovDQo+ICsJdWludDE2X3QgcmVhZF9mbGFnczsJLyogRlVTRV9JT01B
UF9GXyogKi8NCj4gKwl1aW50MzJfdCByZWFkX2RldjsJLyogZGV2aWNlIGNvb2tpZSAqLw0KPiAr
DQo+ICsJdWludDY0X3Qgd3JpdGVfb2Zmc2V0OwkvKiBmaWxlIG9mZnNldCBvZiBtYXBwaW5nLCBi
eXRlcyAqLw0KPiArCXVpbnQ2NF90IHdyaXRlX2xlbmd0aDsJLyogbGVuZ3RoIG9mIG1hcHBpbmcs
IGJ5dGVzICovDQo+ICsJdWludDY0X3Qgd3JpdGVfYWRkcjsJLyogZGlzayBvZmZzZXQgb2YgbWFw
cGluZywgYnl0ZXMgKi8NCj4gKwl1aW50MTZfdCB3cml0ZV90eXBlOwkvKiBGVVNFX0lPTUFQX1RZ
UEVfKiAqLw0KPiArCXVpbnQxNl90IHdyaXRlX2ZsYWdzOwkvKiBGVVNFX0lPTUFQX0ZfKiAqLw0K
PiArCXVpbnQzMl90IHdyaXRlX2RldjsJLyogZGV2aWNlIGNvb2tpZSAqICovDQo+ICt9Ow0KPiAr
DQo+ICtzdHJ1Y3QgZnVzZV9pb21hcF9pbnZhbF9vdXQgew0KPiArCXVpbnQ2NF90IG5vZGVpZDsJ
LyogSW5vZGUgSUQgKi8NCj4gKwl1aW50NjRfdCBhdHRyX2lubzsJLyogbWF0Y2hlcyBmdXNlX2F0
dHI6aW5vICovDQo+ICsNCj4gKwl1aW50NjRfdCByZWFkX29mZnNldDsJLyogcmFuZ2UgdG8gaW52
YWxpZGF0ZSByZWFkIGlvbWFwcywgYnl0ZXMgKi8NCj4gKwl1aW50NjRfdCByZWFkX2xlbmd0aDsJ
LyogY2FuIGJlIEZVU0VfSU9NQVBfSU5WQUxfVE9fRU9GICovDQo+ICsNCj4gKwl1aW50NjRfdCB3
cml0ZV9vZmZzZXQ7CS8qIHJhbmdlIHRvIGludmFsaWRhdGUgd3JpdGUgaW9tYXBzLCBieXRlcyAq
Lw0KPiArCXVpbnQ2NF90IHdyaXRlX2xlbmd0aDsJLyogY2FuIGJlIEZVU0VfSU9NQVBfSU5WQUxf
VE9fRU9GICovDQo+ICt9Ow0KPiArDQo+ICAjZW5kaWYgLyogX0xJTlVYX0ZVU0VfSCAqLw0KPiBk
aWZmIC0tZ2l0IGEvaW5jbHVkZS9mdXNlX2xvd2xldmVsLmggYi9pbmNsdWRlL2Z1c2VfbG93bGV2
ZWwuaA0KPiBpbmRleCBmZDdkZjVjMmMxMWUxNi4uZjY5MGM2MmZjZGQ2MWMgMTAwNjQ0DQo+IC0t
LSBhL2luY2x1ZGUvZnVzZV9sb3dsZXZlbC5oDQo+ICsrKyBiL2luY2x1ZGUvZnVzZV9sb3dsZXZl
bC5oDQo+IEBAIC0yMTAxLDYgKzIxMDEsNDUgQEAgaW50IGZ1c2VfbG93bGV2ZWxfbm90aWZ5X3Jl
dHJpZXZlKHN0cnVjdCBmdXNlX3Nlc3Npb24gKnNlLCBmdXNlX2lub190IGlubywNCj4gICAqIEBy
ZXR1cm4gcG9zaXRpdmUgZGV2aWNlIGlkIGZvciBzdWNjZXNzLCB6ZXJvIGZvciBmYWlsdXJlDQo+
ICAgKi8NCj4gIGludCBmdXNlX2lvbWFwX2FkZF9kZXZpY2Uoc3RydWN0IGZ1c2Vfc2Vzc2lvbiAq
c2UsIGludCBmZCwgdW5zaWduZWQgaW50IGZsYWdzKTsNCj4gKw0KPiArLyoqDQo+ICsgKiBVcHNl
cnQgc29tZSBmaWxlIG1hcHBpbmcgaW5mb3JtYXRpb24gaW50byB0aGUga2VybmVsLiAgVGhpcyBp
cyBuZWNlc3NhcnkNCj4gKyAqIGZvciBmaWxlc3lzdGVtcyB0aGF0IHJlcXVpcmUgY29vcmRpbmF0
aW9uIG9mIG1hcHBpbmcgc3RhdGUgY2hhbmdlcyBiZXR3ZWVuDQo+ICsgKiBidWZmZXJlZCB3cml0
ZXMgYW5kIHdyaXRlYmFjaywgYW5kIGRlc2lyYWJsZSBmb3IgYmV0dGVyIHBlcmZvcm1hbmNlDQo+
ICsgKiBlbHNld2hlcmUuDQo+ICsgKg0KPiArICogQWRkZWQgaW4gRlVTRSBwcm90b2NvbCB2ZXJz
aW9uIDcuOTkuIElmIHRoZSBrZXJuZWwgZG9lcyBub3Qgc3VwcG9ydA0KDQo3Ljk5Pw0KDQoNCg0K
VGhhbmtzLA0KQmVybmQNCg==

