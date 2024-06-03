Return-Path: <linux-fsdevel+bounces-20858-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F1A8D8A0F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 21:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 248C61C21293
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 19:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3A5137C3F;
	Mon,  3 Jun 2024 19:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="HD+T7JZa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip168b.ess.barracuda.com (outbound-ip168b.ess.barracuda.com [209.222.82.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1593A137748
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Jun 2024 19:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717442683; cv=fail; b=Px0pTmE7KGOaDmaFMKNfTrbw1UV6wJXUWZ0h12RdtfMkcktkUJfimCxx8LwrH6pN2MXG6++jYVsBUV8gFU0vbvCtnxNXK/HWNX6obuTz7fMN6lknTy72Z/hi9Llh4CzYlpn3ZJLjfLeS6fXQBesxXYbUyx4A9w+gSNfGJFJtfVk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717442683; c=relaxed/simple;
	bh=zUrvGzt08meydcs9iTRzB2+9fR9Hj8MSpkYPnHeRWXA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cAMqSdjMREYUXNABtycQf3wmVnBN8Dp7fB0dLOjHSa8X32AnOVNAc6mwylxA+QjuBoU/eA8QtNi2d1ynNEORH8srWPmSBnRUvQzS+ekbFpBIqkTHEydF0OCUcVq0yjk3VivjI+R4gF7Vm6+LDuOpzZBWmlxS9ePnAYhDQPB4mF0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=HD+T7JZa; arc=fail smtp.client-ip=209.222.82.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169]) by mx-outbound-ea46-177.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 03 Jun 2024 19:24:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M9au+X9f/1EQdRVSMMqlQS2w/7hBzNNz8THpVvN71MDmqAs2nBp7Oa/SGP8pO80+ktmXWawXAUkyV7aiOi4G37+RD9cvytVdEwhYsGrH5Z1gDZjBX3mIyQRu/72qeAwpzpDGvHYNr8quBEsnfsK5jpJ+gEvA3yfgADMz5YMZYEBeUV72wswGgmoKxlpkmpCxG7L0sKgnEW2RWsPKhKkVnd3MdxBOp09Tf8HH+yxEApUKcI0pKGcgqq8Ww6xHt2Rd3EIcWgiXaCwtwvAARjCdYCP2BflQaI8H+7OXl97F6EGi9fnuWlLjUFjfs9ztohV1xiJXjCY2XcyhCD/8A1FRBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zUrvGzt08meydcs9iTRzB2+9fR9Hj8MSpkYPnHeRWXA=;
 b=hRBysHEDqMaGo75tYaopReQnqN94U+8mVqzBa8ht58MrCrXJywWTQ1cBhTUp4nDUpA7pXEGM8yd/9UXOC/RazBz2VQ8WT94SEd5838eWCl68e+xZtnb9JjMRe1f8zQrpYyD2mDGdc7X0gikRdl67MzqVxJP+saUmgmhvtrfhaoKT0HHfUOYLTbeZXbFxl5rUIkzBs8zf52jqn3gKeGf+mYKoOGgiFOTMc1gftlobB7IMwOHyJeSpU2pck1x7JYVtRYhAfnmlVTp1uTBWTQHEIAU0U+NAghJM8vEmRU7pEDqK7AYRBwfxAYpzz4Yd8/9lh3ESiQbVMnELF0JsePg55w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zUrvGzt08meydcs9iTRzB2+9fR9Hj8MSpkYPnHeRWXA=;
 b=HD+T7JZaP6n+y2LIn8Q7+6SFw8p68m4miXLZz1EcMIETF3abzLh4er6g2y70i/Z7OH+PBDGEwaXMxqk0/phAB6QKd6usjJzpPn/Pit9dezc2XN+wQz/i9S7UXpVnL2eWaaYwQI9kk5NPQqTSn3P+1NCnxXUL7ImvOwEyYUaKuOI=
Received: from CH2PR19MB3864.namprd19.prod.outlook.com (2603:10b6:610:93::21)
 by DM6PR19MB3993.namprd19.prod.outlook.com (2603:10b6:5:1::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.24; Mon, 3 Jun 2024 19:24:03 +0000
Received: from CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03]) by CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03%4]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 19:24:03 +0000
From: Bernd Schubert <bschubert@ddn.com>
To: Kent Overstreet <kent.overstreet@linux.dev>, Christoph Hellwig
	<hch@infradead.org>
CC: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"bernd.schubert@fastmail.fm" <bernd.schubert@fastmail.fm>, Andrew Morton
	<akpm@linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH RFC v2 06/19] Add a vmalloc_node_user function
Thread-Topic: [PATCH RFC v2 06/19] Add a vmalloc_node_user function
Thread-Index: AQHasfIqCiagHUDXrUC5ZokYmrgD+bGxYKaAgATZXICAADlJgA==
Date: Mon, 3 Jun 2024 19:24:03 +0000
Message-ID: <984577b6-e23d-4eec-a5da-214c5b3572ba@ddn.com>
References: <20240529-fuse-uring-for-6-9-rfc2-out-v1-0-d149476b1d65@ddn.com>
 <20240529-fuse-uring-for-6-9-rfc2-out-v1-6-d149476b1d65@ddn.com>
 <ZlnW8UFrGmY-kgoV@infradead.org>
 <sxnfn6u4szyly7yu54pyhtg44qe3hlwjgok4xw3a5mr3r2vrwb@3lecpeavc2os>
In-Reply-To: <sxnfn6u4szyly7yu54pyhtg44qe3hlwjgok4xw3a5mr3r2vrwb@3lecpeavc2os>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR19MB3864:EE_|DM6PR19MB3993:EE_
x-ms-office365-filtering-correlation-id: a4061c65-c178-42a4-f35b-08dc8402ba86
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?SzhSOXBHNUkrMDVScHpNSitjY2Nybzk4UDh2bDVGWDdmLy9DNXExU3oyd0tC?=
 =?utf-8?B?emdvZmR1ai9ONUR3WEMzQ0tRZ3VlZ0FkU08ySlQwcWtCQ1ZZZnQwSjdqWklG?=
 =?utf-8?B?R2U3NVRXbVBBUVZSb3V3UCtvOVM4UVArbHlaQ3BVODVpMDg4YlZ5UkY0Q1hh?=
 =?utf-8?B?eGttbWVVZXJoRHk3RjFzSk00UkFjNHFFbExlbWZHeDdJekJQdytJRXJSVU0r?=
 =?utf-8?B?VHh3ZndnQlZvWlJDSTJ5SlFxd1JUdVhoYVhWZjZneWx0Z2lueFMvMmVPeXZX?=
 =?utf-8?B?WlR1ZHl1aHhtY3FqMTRyd1hOajNUeUxEK0ovcjJMUnVOczhjNnZmd0N3UUJw?=
 =?utf-8?B?QnZLMnBMUWgxWksyTjh4ZDJoYTZuRHlONkIzUllpNjMyL2UwZFpJa29lUUtQ?=
 =?utf-8?B?NG5zK084dmw3U3phSFpYTXJScHdtc0tIYWpTak0wRGc4M1ZZUmJrR0xpMkYv?=
 =?utf-8?B?RDZudTlwemNCU1hodTBFK3FGc3ZHMUhUK2Jobjg2SmE5V0I4ZlRmRlZ1VElN?=
 =?utf-8?B?OHNOc0NmN2R5aHc1Rmk1YStwckkveUl5SHZITWNNU2M4R2pwVlo2c1dRRllu?=
 =?utf-8?B?N0QzTEx5a1M4R2dSbWFWQ3hndzJZalRZSzZtZC9GZ0Fma0dxcExYb3RUYzVi?=
 =?utf-8?B?RnVPeGQ3L21xdWhzalpsNXJidnhDbkFNUWNybCthbEdqTzhOV2Z0T09Malh2?=
 =?utf-8?B?VWRvQTVzdlh3QXQ1eFBYMnRDZnY2MjdzZGhRb3ZoUnRsZXNIRzlhaUdlL1FE?=
 =?utf-8?B?RlJnSzd3NVdyOHBNWTIwMkc3US9QTkIvd0hJZHUydSthV0wzaUNCWUtQeVpv?=
 =?utf-8?B?eTZWTndndEU1Ujg4M2Nud3M1ZS93KzduMS9aZU1QWmk0OEdqd1RxTkFUUGh6?=
 =?utf-8?B?WnRVU3JnWTBtbzR5WCtOMkdKL2dkVUpUcG43ZGFobVk5M2d0S1A2WHY5bXZC?=
 =?utf-8?B?VWhuM3AvazIzZzBzdDhxaURWVHgzR3NJdWNlZkhQckllM1FqSVZ6QUY5TWdw?=
 =?utf-8?B?QXp5c1RCb2U4c2hIZjhESGJPVFBsWlhYVmZSdSsrUmZBKzBiK3pzM0lLZHhI?=
 =?utf-8?B?cU5HQmlJUGpiZTgrNnN1d1h0WGd0Zi9DMlhVRmw4OXVjM1ZybXdTbnVnVy9U?=
 =?utf-8?B?Qm9BWUNEdHlBL1ptY2dORWl4YTdOdUFpTUdzYnRNNEZCdTcwV05tTy9jWjhO?=
 =?utf-8?B?UEU4dFM3dTRUK0dnVFZlSllZVnRyQ0xJTmJsTkI3dmtVQ1h5Rnh1ZmROa0Jz?=
 =?utf-8?B?MWYwQkdvWnloSjkvVlZsWStoL3I0NVBkLzlocFZtT2tLTlNtMGdqY3k0Q28y?=
 =?utf-8?B?ZzAybjd1RldScDk2U01LUjBjVDFpNHNnbUpKS1RmbTg0QlF1bzBxeXBsdW5h?=
 =?utf-8?B?Y05ualM2U2lZZ0FTejF6SktJQWpicngyaG5rS0FkUGdmRGp6N2p6RTZId3lZ?=
 =?utf-8?B?MzB0eXFmcGROWVMvcEhnU0RFUm9DWVB6aFJmVUU0ZndITlh6My9qaXFSQVh4?=
 =?utf-8?B?OXZleFo0MWFjbFYzdndHTWJ4cXRJZHkrWUZ4emxzN0d3Wk5wR1hsUWkxYW5j?=
 =?utf-8?B?SDk1V3IrY3hKdDBjeng0Nk1RVCtvelgrRWFvVElUT0NOSlllSFBMaGo3dkJL?=
 =?utf-8?B?MUVJU3FYVFErV1VRbGZlTFhnZmVubHRtckZqU1hXOUNITkpucVhyYzNZcUNl?=
 =?utf-8?B?MzhkdjZLVnBQQVJCY3BSSVphTndmRUx2bUpBeFhadXZILytESXZLQ0dmdGYv?=
 =?utf-8?B?cjJyK0pRVFYyNjJsT3FSNXVDZVFhODlGaTgybjZOd0pKZ0ZrZnF1K3M3RVhZ?=
 =?utf-8?B?NzNaWkh1Sm0wRGFHQ3U2Zz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR19MB3864.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aG9kL0wvS1h5aU9IbnZPYkVxMElGUkdlSjBYT29HUXZLYWwyYXh0a0NSbUdC?=
 =?utf-8?B?anNOU2NKNUxrc1pVV3VVVUkzN0JTbElTTng5c0s2ZlA0WFBzTHZ2US9PSWI0?=
 =?utf-8?B?Vzl1NGsvZmFacElUR1BGMTRRRmFpampXUThNMmo3eFRpenFER25aSWlORkxa?=
 =?utf-8?B?SmpwZ00vS0d2OWwwM0lTendyczJlaDRaNFBrdXphUlhteGVCbm5QckVpV3dU?=
 =?utf-8?B?SndUUkF3RE1OQ3NGaGhPZ2QrMHB5S2o4VkRaYUMwTi9EMVcrSTRjWWtTNzJW?=
 =?utf-8?B?dHZ1VVNQaGZ0RmZ6L21Hb3NucWNDTVIvdU91VU5RbHVBYm9yOFBQR3UwTHpS?=
 =?utf-8?B?WXU4QSsrdTVpWk9zSHE4cy9yeG1YWmQyTTM2YUxQYTMyT0Z2UEE2dG1SMHVZ?=
 =?utf-8?B?YzVodEZGMklhc24rc0ZtdWxVTTNnOTN5anRjVEdOR1pNUlI0OXJJOVQ3Z2E4?=
 =?utf-8?B?L2xTMU9ZSUZnY3FRSEpGVHdIUnR4Qk13MnpHVHh2VTE2akViWVNFSHhWRk81?=
 =?utf-8?B?L2ROeWJ1b1hBYVVFUlU5VU52eUk2WDViZmd2ZDFEei9lZEwrMEdOakhvMHkx?=
 =?utf-8?B?L3phc25UUWxpVmxRUTFxeE1JS2NNM29STHJablVpMjFsK1FrZzdHM3grM2h4?=
 =?utf-8?B?QkJQNitSZnEwRjVoWG1IWFBYMXJMZkxJUDBMOUo5K21raVg3NFdFeVlmdE9Z?=
 =?utf-8?B?QldRc2xHTndOZFZZQTRCMGhwa0hqclNCSWtmaHZoa2xNSmxqbmw5UnBMNG0w?=
 =?utf-8?B?eTRLQzBqUGdqUU5MVXlDclBrQXZlc3RyMitybHJCZmROTTZCU09RR3N2U1VF?=
 =?utf-8?B?TXVLU2FoYm9mQ2pzOGNUOWtjWTFpSjBvZUg1VUZhQnR3TnYwOEpBcWVabzha?=
 =?utf-8?B?NVQ5YmtsRGJiQ2hmemJWUWRpcmJQZFg1VDlaTnNwNlV3QjFrVTdkWEtKcC9D?=
 =?utf-8?B?K3Z4UTJLd2Q0ZVk4RUFjTGNhMGhkdU00TWV5R0JoRGVOY3htYy94S2hlandP?=
 =?utf-8?B?Z0V3ckVOdXZ0ZG9wNHZ3SmV0OXpZQTl6cDN6eFVDVDRZQXJYbnQxM3pXSzVT?=
 =?utf-8?B?THZHVUpCK29qV0RHcnlzR2JCbjRud2czU0NrTEhocWJid0hDZEVDdGdxMUdI?=
 =?utf-8?B?OThrbEMwQXBXQ2pJVXNEK29GeWlGUlRFMlJSN0pyRUVNUTU0TmtOQnRuWEVD?=
 =?utf-8?B?OTRKTkhma1I0K3MrQ1MvRjlpRE1iTE5RQzh2c3JvVTh3V1lQU29PbTEzc1RM?=
 =?utf-8?B?dUMzT0FVaDhlQnloN01wZXlKOEtoMnQraXc4ZnpwTTQwSVBPVTlHd3hjeVZ3?=
 =?utf-8?B?NmNNeGpNSHJYWEhyUE5vRFBqT0RuWTVHV2FTUmZHZHMvNVkwZXRGa25WSUFx?=
 =?utf-8?B?bzNReGI0RHdIK25Rc25aQndrclR1ZjFiZGowNVZDV1lkTVlJcjNPYXhsYkdI?=
 =?utf-8?B?SzBVaU0xaWp6TDVyNzBhZXBHdFZnY0gzK2dHZ01Ib3p4K28xSFhJT0xuRVhH?=
 =?utf-8?B?dncxR1ZZSThMY2l3QVZVQ1Z5QzZXOVNkeGxqcE5PWHBVNTRqTVo5RDIreFh5?=
 =?utf-8?B?Z2poMWs0SkIzcHl4amRMNUs3M3R4eGFuNmpyVUpWNWIrdlNxK0N3REhIUHJq?=
 =?utf-8?B?Q3V1UVhPRTlPZmNENFRUclFkSnlUOW92VjJ1Z0FvN0Q5ODRMclZOTTVqVHZQ?=
 =?utf-8?B?Ti9Ud3NyMXdUa0hoNTVNZmhWYUR0bXRzWC9mZWN0VXVnQnNQME1wbDlaODdO?=
 =?utf-8?B?WXRQRWFIdmZlSjQxVDJtZkpRY1Y0Uzh4L2tUQUs3TjVkZ2didXBQR1FkaFRQ?=
 =?utf-8?B?NGZTSDk4cnBuY2lpaXRzVGRVUFJ1eEtJdE1XRVVkcis3RkZ4ZWRBU2xEbTFS?=
 =?utf-8?B?b3ovb3I5T3d3c0NEdEtCY0I0L2tmdFVsK2FMSWQ1OEZudVk0ajBBd2ZxMVhJ?=
 =?utf-8?B?SkRubVczYkJ2Qm9tVU9wTzBsOW1KVGFpMjNEL3YzZkptcVJYN2hOZTJlVTdT?=
 =?utf-8?B?L2VJYllCZHlubHo1M3ZYKzZ3ZGVPZjRNZ2NmQVAzSlYwNmUvay95QVJDZUZN?=
 =?utf-8?B?Y3J4VUdRL25pT1Z5MUprM3oyd3ZRaUllV1FoM3piS3RibkRkdkdMUVhnMG1Y?=
 =?utf-8?B?L2lScWM3VU15V1AreWNKWVU1YjdXem5nYjVTRDZUNXJXTVA4QUNxMG83OTBX?=
 =?utf-8?Q?TyaJm8XxxQ+i9QSEBAVsBHk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <70E954115CC61542B3C5C6E082E8A8A2@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jYhF8Cn/DeMZPccj9ceeQocCmAMbNhaKFgXRGbetpcDl4lFXT5vTPcDgM9AyWp0QYeo/ZxPmM9xc+9zOHY8VTRaBEgwf8fIF+10wDoNcy+qjnaG5ZkUd11ublvqSCOoXW83M/Ch9UwY4xglnJKK2LNpJUhuRcqafMBnbEJeimDIZbJKVXhIczQz+fQUBnHeRbhrv5yJDo7p/hUMEmL+NDYKk1wQK8t21WXiRZ9LFDfbyRir1/rsyKfXotB/Uyly69QsSObVQC3WSyCEhLrMzDxhHualCjaoviDN5YXYJTUNrRxQSDofyuDbmh2N6h8OlINDVW4OqTl65Z1GVehneGWkuT6OgRChTuV2+xWrW+LZG2WXQmYHz0bZQHR6XJ7yOEaWaIvOdDRQ3gRCriwjnuq8+prqu28XAEcPvbDna++lFKFeep7C1ppluLduK9UOQiAc4VTImUr3Xyg8j3Iypxog0caA022+KTi9zLAVI14oNCsESTvxiwQqbezvdd9kPTuXrlq8DtFEXTAf7iA+RL9Lw/lh5kZoOXTh4ypcoXrvYBrmG2VB+gPv2iioMBY/4JReSdD5kPAU9+VerS5v06qLOZLtguuXYX2G3djiWKoenKyl3ihbkBfJHskCd4bTuiPjv30qcOqPpOD8OkQXzsQ==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR19MB3864.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4061c65-c178-42a4-f35b-08dc8402ba86
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2024 19:24:03.3435
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NrZlMwyVFWqM9j3gd6wIrLT0ozYa8jf45+UBFtqwxWoipuXxgvNRw9R0nybyxoYawKKVffDyiDKIPkrGntwc8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR19MB3993
X-BESS-ID: 1717442649-111953-321-12227-1
X-BESS-VER: 2019.3_20240529.1550
X-BESS-Apparent-Source-IP: 104.47.55.169
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoaWZgZAVgZQMM3E3Ngk1dgg0T
	jZyMIsycjcPNHUPNkkzcgs2cLAIi1ZqTYWAAVYu9dBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.256702 [from 
	cloudscan19-36.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

T24gNi8zLzI0IDE3OjU5LCBLZW50IE92ZXJzdHJlZXQgd3JvdGU6DQo+IE9uIEZyaSwgTWF5IDMx
LCAyMDI0IGF0IDA2OjU2OjAxQU0gLTA3MDAsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPj4+
ICB2b2lkICp2bWFsbG9jX3VzZXIodW5zaWduZWQgbG9uZyBzaXplKQ0KPj4+ICB7DQo+Pj4gLQly
ZXR1cm4gX192bWFsbG9jX25vZGVfcmFuZ2Uoc2l6ZSwgU0hNTEJBLCAgVk1BTExPQ19TVEFSVCwg
Vk1BTExPQ19FTkQsDQo+Pj4gLQkJCQkgICAgR0ZQX0tFUk5FTCB8IF9fR0ZQX1pFUk8sIFBBR0Vf
S0VSTkVMLA0KPj4+IC0JCQkJICAgIFZNX1VTRVJNQVAsIE5VTUFfTk9fTk9ERSwNCj4+PiAtCQkJ
CSAgICBfX2J1aWx0aW5fcmV0dXJuX2FkZHJlc3MoMCkpOw0KPj4+ICsJcmV0dXJuIF92bWFsbG9j
X25vZGVfdXNlcihzaXplLCBOVU1BX05PX05PREUpOw0KPj4NCj4+IEJ1dCBJIHN1c3BlY3Qgc2lt
cGx5IGFkZGluZyBhIGdmcF90IGFyZ3VtZW50IHRvIHZtYWxsb2Nfbm9kZSBtaWdodCBiZQ0KPj4g
YSBtdWNoIGVhc2llciB0byB1c2UgaW50ZXJmYWNlIGhlcmUsIGV2ZW4gaWYgaXQgd291bGQgbmVl
ZCBhIHNhbml0eQ0KPj4gY2hlY2sgdG8gb25seSBhbGxvdyBmb3IgYWN0dWFsbHkgdXNlZnVsIHRv
IHZtYWxsb2MgZmxhZ3MuDQo+IA0KPiB2bWFsbG9jIGRvZXNuJ3QgcHJvcGVybHkgc3VwcG9ydCBn
ZnAgZmxhZ3MgZHVlIHRvIHBhZ2UgdGFibGUgYWxsb2NhdGlvbg0KDQpUaGFua3MgS2VudCwgSSBo
YWQgYWN0dWFsbHkgdG90YWxseSBtaXN1bmRlcnN0b29kIHdoYXQgQ2hyaXN0b3BoIG1lYW50LiAN
Cg0KDQpJIG1pZ2h0IG1pc3Mgc29tZXRoaW5nLCBidXQgdm1hbGxvY19ub2RlIGxvb2tzIHF1aXRl
IGRpZmZlcmVudCB0bw0Kdm1hbGxvY191c2VyIC8gdm1hbGxvY19ub2RlX3VzZXINCg0KDQogdm9p
ZCAqdm1hbGxvY191c2VyKHVuc2lnbmVkIGxvbmcgc2l6ZSkNCiB7DQogICAgICAgcmV0dXJuIF9f
dm1hbGxvY19ub2RlX3JhbmdlKHNpemUsIFNITUxCQSwgIFZNQUxMT0NfU1RBUlQsIFZNQUxMT0Nf
RU5ELA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBHRlBfS0VSTkVMIHwgX19H
RlBfWkVSTywgUEFHRV9LRVJORUwsDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IFZNX1VTRVJNQVAsIE5VTUFfTk9fTk9ERSwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgX19idWlsdGluX3JldHVybl9hZGRyZXNzKDApKTsNCiB9DQoNCg0KDQp2cw0KDQoNCnZv
aWQgKl9fdm1hbGxvY19ub2RlKHVuc2lnbmVkIGxvbmcgc2l6ZSwgdW5zaWduZWQgbG9uZyBhbGln
biwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICBnZnBfdCBnZnBfbWFzaywgaW50IG5vZGUs
IGNvbnN0IHZvaWQgKmNhbGxlcikNCnsNCiAgICAgICAgcmV0dXJuIF9fdm1hbGxvY19ub2RlX3Jh
bmdlKHNpemUsIGFsaWduLCBWTUFMTE9DX1NUQVJULCBWTUFMTE9DX0VORCwNCiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgZ2ZwX21hc2ssIFBBR0VfS0VSTkVMLCAwLCBub2RlLCBjYWxs
ZXIpOw0KfQ0KDQoNCnZvaWQgKnZtYWxsb2Nfbm9kZSh1bnNpZ25lZCBsb25nIHNpemUsIGludCBu
b2RlKQ0Kew0KICAgICAgICByZXR1cm4gX192bWFsbG9jX25vZGUoc2l6ZSwgMSwgR0ZQX0tFUk5F
TCwgbm9kZSwNCiAgICAgICAgICAgICAgICAgICAgICAgIF9fYnVpbHRpbl9yZXR1cm5fYWRkcmVz
cygwKSk7DQp9DQoNCg0KDQoNCklmIHdlIHdhbnRlZCB0byBhdm9pZCBhbm90aGVyIGV4cG9ydCwg
c2hvdWxkbid0IHdlIGJldHRlciByZW5hbWUNCnZtYWxsb2NfdXNlciB0byB2bWFsbG9jX25vZGVf
dXNlciwgYWRkIHRoZSBub2RlIGFyZ3VtZW50IGFuZCBjaGFuZ2UNCmFsbCBjYWxsZXJzPw0KDQpB
bnl3YXksIEkgd2lsbCBzZW5kIHRoZSBjdXJyZW50IHBhdGNoIHNlcGFyYXRlbHkgdG8gbGludXgt
bW0gYW5kIHdpbGwgYXNrDQppZiBpdCBjYW4gZ2V0IG1lcmdlZCBiZWZvcmUgdGhlIGZ1c2UgcGF0
Y2hlcy4NCg0KDQpUaGFua3MsDQpCZXJuZA0KDQo=

