Return-Path: <linux-fsdevel+bounces-20435-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABCB08D37BE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 15:35:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFDCBB23C07
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 13:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D977214AA9;
	Wed, 29 May 2024 13:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="SblErRyu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2101.outbound.protection.outlook.com [40.107.92.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98DB101E6;
	Wed, 29 May 2024 13:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716989714; cv=fail; b=BiKEbKyuYyMiBoZmzc+2SV0/ZiRDzRr6skecpPTIonztuzQD0Bo0oAc9RQ+V8dbhU+7dRtWKOnEnXz4wEcGJHh6tqotFjuHoOuajk7t5TgzWoTMBlULslcFHx2/li9UKH1L3Vgy9xGQH6B8FWeiKxev9XgQyz0l+waxFJNa466Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716989714; c=relaxed/simple;
	bh=neDScIps1tkPDmwTYMaTUeuE6jc0TQhMRawj9fZh6Dw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UdbWZaTYAQL34LwezQ2Pdob3x7Tly8nTPidetA8HV6hdx3TJSGScLfHmg9JLKc7IWgKZrJ/yNNvaFFRA/iC14kOh60SEqs9DwT7CNOrV8R94GBoEb4boc1GQW6abQLAswhzlXe+/fMiaXhspXjvfPgU7LGn0D3Fgq8TNROTjNZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=SblErRyu; arc=fail smtp.client-ip=40.107.92.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HzSGe8BQA3SjObwe1iLrMG1Qbw4LPjDo/gxWCXFjjYVQJ9rfu9t9TZ0qbUG9iIXCIuic8Mq5NIQwV6ZMOvZ+OLjIAt0tZ9Jt/ZEt3HPTfCFsa8S33vjRDD3s/XB1vLV7cBr6kV3IdYrVYmoVw8nG1L3GMdZ6WFSoOqf8zEzzkMZC1uD41YcrIv5BYXV2YuZhqEXx+5mwCDhCQIwxkxjqfUo2w32jz5Ur5q3+5Bi5wd32b+Qi4npm4fo+Y3REu4d8PI7z+wnmB+uPbVKTEJofBPNsdIBHZGzS26SxZMu6HhJ15agEQfDmeIVSpnpy4hA3GWwufrobynrcWwI3qyo5mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=neDScIps1tkPDmwTYMaTUeuE6jc0TQhMRawj9fZh6Dw=;
 b=X1hhb9iC8SOVVxMzaMOutOs4g+hpFmTiCQ6VuoC7iEcKJD3O7Ct3HFsz8TNO/tchBScYswPlPzGE9pqKQuGyXy8K+LrUYukYPf0XOq0Dw18WbnH6Jx+xJnnicI14+nYzaISmhjLJMDa9DXfynvj2W9vUuS8geWqBzIiEBRuJ06V5LAH6AwNMVX/5Nt25eFeRffuzoVxgeOyPWlCnu/zo/62kiSoXxxDTixD9HBPZAVeu7f08nuK923iTcqO+UWfRyii9xei0SFpCMEMbpFGFH9uWyQTgmtMv1DfyhzXwTB7lt/RrAcQ065haY1JpwmNscbgmLwxAVMy5vOpfA/1i1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=neDScIps1tkPDmwTYMaTUeuE6jc0TQhMRawj9fZh6Dw=;
 b=SblErRyulU8dV6RjWtbGuQISrKg8f9GYZcvW4v4CI4qyyVPYZgKS65lyI//hLbpzTopzWvHK6EVT1Jij0D+nim3dqlfSeaKDizvFw7bkT0VIDCTuRyRH6fq/YaJZrrLGttkke+vUSg9yDpx8bwUpPZEiAAFba0SKjzV7nAAaUM8=
Received: from DM8PR13MB5079.namprd13.prod.outlook.com (2603:10b6:8:22::9) by
 CH2PR13MB4554.namprd13.prod.outlook.com (2603:10b6:610:66::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.17; Wed, 29 May 2024 13:35:06 +0000
Received: from DM8PR13MB5079.namprd13.prod.outlook.com
 ([fe80::3312:9d7:60a8:e871]) by DM8PR13MB5079.namprd13.prod.outlook.com
 ([fe80::3312:9d7:60a8:e871%6]) with mapi id 15.20.7633.001; Wed, 29 May 2024
 13:35:06 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "hch@lst.de" <hch@lst.de>, "willy@infradead.org" <willy@infradead.org>
CC: "anna@kernel.org" <anna@kernel.org>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, "linux-nfs@vger.kernel.org"
	<linux-nfs@vger.kernel.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>
Subject: Re: support large folios for NFS
Thread-Topic: support large folios for NFS
Thread-Index: AQHasFQEtVPFzJw4R0eoRu1V26ovVbGtJQQAgAEUW4A=
Date: Wed, 29 May 2024 13:35:06 +0000
Message-ID: <bea18efca1a72be056ba6a936b9873e53ae3c6d7.camel@hammerspace.com>
References: <20240527163616.1135968-1-hch@lst.de>
	 <ZlZHNsejJkJNhKHR@casper.infradead.org>
In-Reply-To: <ZlZHNsejJkJNhKHR@casper.infradead.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR13MB5079:EE_|CH2PR13MB4554:EE_
x-ms-office365-filtering-correlation-id: c2ea2984-6d8a-4f39-5d48-08dc7fe4272c
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?Snlqc1I0d1hyMTZPanZoazU1WnlvU1I4dGlESCtyaU9nSUF3MXk4NThqa1JZ?=
 =?utf-8?B?ZXRrakMvczM0QW1BZEFYVW9CODdhb3ordTc0alZqUmhBYXo3TURVcDV0MU9n?=
 =?utf-8?B?SWFDRTl4SjBUVlZSZ2dnWHQ2YktzRVVQSisvY2hkZ0RDSU41MXRxV2FaY0ZP?=
 =?utf-8?B?VlczaS9LMDRpRHFZVFJyR2JkVFljeTBKOFNEVVJEdUZYMDl4b0JYRCtPYmFT?=
 =?utf-8?B?N2MyUlV0VkRKeGFxaWxHTHl1VGdjeXRaZC9vdm96YmhVbFZtbnlOQjBSR3VZ?=
 =?utf-8?B?ZDk3ckV0NUNxZmVJZnM4NmpLR3BEakp1cHVOR0djNEZ3b21pMERsVVoxTklm?=
 =?utf-8?B?Qjk5YXdaT1ZiM3ZHaFEraDBYVGhub3FKcHMyMWZYM3VhZFpJdmxiOTlyUThk?=
 =?utf-8?B?UU1qeTAwM29TeFRqck9BU2xrbXBFeDd5ZjJCRjZ3Y1RzVHZYNmREMDdXK0Jr?=
 =?utf-8?B?V3BvczFQd2tWWEVsZU9ub2U1ZmN5NWZYNm5IUlpEWjJNTzgwZGpxdWY2Qmw2?=
 =?utf-8?B?emNoZ3hZUE5Pamp1VXZNT1QwSlQ4VHh4NW53YmFUSGZ6cVhoZmRaeXhWSlVm?=
 =?utf-8?B?SGQyZk11VEpsSHlVTm8wYnhPSEk5VVQ3YWhORGRHcnZmRjhIUUcyUUE1SzZu?=
 =?utf-8?B?eU41SkY0SEtDMERsS0Z5RmtkcEY3Q2V6ZlJxWFR6Q21PaTZDVzBWNkg2K2RL?=
 =?utf-8?B?MmZibXVzd1ZKSnU1VVNhUVNUVjVtekR0TFlhT1hqcnBoRDhtdnJERk14eUN3?=
 =?utf-8?B?bTF5YlpKaW5oUUd5NlNLVUR5RGZzWVkxbkpMTFV4V1FyK3F3dTd0SWhmM05T?=
 =?utf-8?B?R0ExbEgwVkpTSlFIRDZCT0hBSUpvT292L0YyT2JjOEh4Uk1oSktaSG5VZGJ6?=
 =?utf-8?B?WDlnaXNJZURQaXoyR1JIWkcxMVk0STZ5Y21mZkJmYzAzeUVkVS95Zng5VDhI?=
 =?utf-8?B?ellSY0VXT0RPZHBZaVh6QnVWWnNmc2dTbG9iKzZwR0J5d014RUU1aHJjUDJq?=
 =?utf-8?B?ak0rRUNsNDlRVXpuTHhxL0ZJVUhUWmp3dzlkMTV2dEVnaVd4REIyODFsZldH?=
 =?utf-8?B?MWwwMmZxeUllRjJNWnRQWlRxNkNCbUlhRlJOLzJxYnc1bFNvMmNYcmpNaEgy?=
 =?utf-8?B?dEoydy9mc1k4NWo3L2FXRU1IMTdFNW81VFhXVGZMTXl2OG1ONWF1cjJKSXR4?=
 =?utf-8?B?NkYvcWwrcEFqQ2dVMmxrdTJaTHZLM1cvN0ZpQnI0TGJzWG5FbkcxbEluOFZp?=
 =?utf-8?B?cUF0eTlPWHhnbUIwczkzNjE4bytJcUNJRkFRY3FtMGZFcUR5ZDAvdWtqaGVW?=
 =?utf-8?B?akZmak9OM21JS2lrbE9JT0IveWhHRGJwaysvdTEzeUVVU0pQaUhvUGxRK1VQ?=
 =?utf-8?B?VkNXd2FmZ040cG45T1VuVnp5NXp5WmY0cEl6d1B2amk5Z28reG9ycit5Qk1j?=
 =?utf-8?B?UndyUERFeXVEZUVBTTk5UEdBdEpWOFJxWWhOTlRNVUtXMUdqZWdub0NrWHQ0?=
 =?utf-8?B?OHJkTldRd1BCODJTdFB2YjkxR1ZuWnlRSGVLNiszczFaWnVNb1pZVFNCclhz?=
 =?utf-8?B?ck5TaHVqQWhQRnhHS1V4b2hlaWNqZ3pCaHc2dVQweUsvOXhnUzFEMUhEVmh1?=
 =?utf-8?B?UkM3cXpYTnpERDFLaHZvZUY1Zy85T2h4TzJlMFlpc0tKeVlxd2ZpZWJXNkhz?=
 =?utf-8?B?VzRVSXZoUk1hMmtNNW00RlJGOW9tamJybnJucU1KcnMyUnlraVBlNHBGU29W?=
 =?utf-8?B?V1I1aGpGU2FzRW93NVNGNHZ1Q3dSV3JBVklsSU4ybldtVGdmdWlWRHphUWlW?=
 =?utf-8?B?OURxQVl2N2xoL2IvZi8yQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5079.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Unl0Z1dLSHRFZllQTjM2K0RVMllUUnV3VWVaYlVKZWxTSSs3U0VFWVRtd3RX?=
 =?utf-8?B?S2ZkT2J3NlplQ0xpeFlJYVVoUi9Kd3ZFUjZ2d1MrenMvakdoa2lUcEV6eGN6?=
 =?utf-8?B?d3UyRnZWbVo4VWk3cGx0OG8ySVFFbmxXUGNhUVVwcGlXZEg4UmdTVHNiSm04?=
 =?utf-8?B?OXlWeXR6Lzl6ZDd1MmJjNy9xZkpLS2tBY1hZKzNKaUk4dnlhSVZEK1l2Z2ow?=
 =?utf-8?B?RktEMWZ0Z2NDVEo2SDFsWDZGMkJoREduOS9LWERmYXNmOVFjZlp3TXBnVmJq?=
 =?utf-8?B?TXByekZUcllPNU1melh2SGdiS0pUZmRJNzBkekVYa2RTOGg2UkJ6dkc3Nmpi?=
 =?utf-8?B?dXROcy9ldVhIejRLVkcvbzQ1RDFqSFFua2dSZzNVOFpMaHRHVmgwdkNxMFlD?=
 =?utf-8?B?YVBmYTltZThsbmJianROeGdHVHhTRUVOVWFhMGphb2FQUWNIaFVvOHZOTTRu?=
 =?utf-8?B?dzRnMXBWTzdQSkdaZ2xBY0RlMWxyUmNpUXMyVG1pLzFOSDJsQTlaMm9NWlJ4?=
 =?utf-8?B?aFJBbXNZWU40QVJQSStJRERjeDlJNUE4dm0ramJRelpRa0g5T0F0SURjV3ZH?=
 =?utf-8?B?eC91THlOdk8vSWQwRlpVT1dkR2pGdDNsSXB5UUtJcTdIYkI2QWJPdzB1Vld3?=
 =?utf-8?B?MTdsdUE3NTZac3g0NVFEbkx5cVpzdFQ2R3kxaEE2N3pNdUpqQ3ZDZzI0bkNv?=
 =?utf-8?B?ZnNjbmczZHVyTXVDY0xiYkgrWjZ2R3lmZnlXRk1Nb1VqK1BUemJabUdTQlh1?=
 =?utf-8?B?azZzVHVydHhDVDRmajBGd2pvNDBiUWVBY3JTZHJKQ1cyM3JnbS9iUloraHdY?=
 =?utf-8?B?dHkwblVKUmE5dnA1WGpKRHpYZjgrdHJuMGthc0tBeXNXSUpDaVA0eWcraWhp?=
 =?utf-8?B?V1djcWhUZ0ZHaFZXSUtua05URFFOZEIzVks3UDloc3lFVXpENVIwNnhwMnVU?=
 =?utf-8?B?OU5UbHhaV0I4ZnhGd2JOdUxnSzl4Z1ErcFhaMW1XZmFiaitaN2hZWDFjTWtu?=
 =?utf-8?B?eVlJLzJkSVlUVTlPTEx6bzh5eGljQ01jQ0F0WWRjcjdMY1JVZVlqNjA1bmdr?=
 =?utf-8?B?U3JQOExKWC80VEk1REJoUmJCaEZqNEloNzArUHdFSDJnc0FiejRDWEtUMWJ0?=
 =?utf-8?B?cVJQQld5b01UZFZWbktVUDZqU3ZYRzJranhxdWxJRnljQUcrOHowQUkzVzBN?=
 =?utf-8?B?ZGZOL1Njb0puS0xDQitXTDZ5UFdOcmVvWUJMaDZkZUVOdjd0MUlkdGhsWmRj?=
 =?utf-8?B?QkdkamVoK1ZMYzdvdWk5ZUE2b3NKREdZeXJmS2lDZFdVdFFwUTh1UC9yQy94?=
 =?utf-8?B?dUVwQ0FqZVEvUnJvQ2RMUk5yVWNGdTlXN0hkUUhNMFdBc0NDajNOck9wam4x?=
 =?utf-8?B?VDJySkxiSGNlWXNxaGNmRnRUbHZmMUpOWmZVVVA5YS84QXpVRm44VzBwdDZF?=
 =?utf-8?B?Q3VZeld6WkgvdXRETTBjbThjTCtHRTV4NDlvRVIrdGZ2aDVuNTU5QnR2VWZ1?=
 =?utf-8?B?QThreDI4Y1ZxVCtXYi9LdWRQL2xvZm45Z09nUmd0MXJwVTVRVkdFTkczOW82?=
 =?utf-8?B?QzhxTzJhOWRQT3ZMdEdpWTFHbDBtZDhpQ21YUHRRZlpLdXlXRFV2Q3ZwOS9o?=
 =?utf-8?B?eVU4SXBzZzQ0TjN1R0tGVjg0YzZnY0x4NXJvb1hwSDFxYU56QVB6eW0za2R1?=
 =?utf-8?B?VGZkaHMyalNDL01vZVVZTTVCWEIxSStpR09MUU9IN0NvaG52ZTZobXZPa0RU?=
 =?utf-8?B?OEVURlgrL2lIcms0ZlBoUzBTZnZHVHViY0wwRmVhMldlem1Za2VCVi90ZVho?=
 =?utf-8?B?ck0wK25jUmJsaVE1N1F2ZVJWSGpTTElXM2VlbmZxdlg4WE52YVdzaEtQbTVS?=
 =?utf-8?B?dTlaRU5yclY0VlNaVmlRaW9oaUxiSWZvYlo3QVB2cHk5alpsV3JOb0FzVTVp?=
 =?utf-8?B?RU9mc3dvYmhlM2ppcUVVS2J3aVA4ZG51MVIzaE9kTFdGMTBoZ2JZRlFUaGxQ?=
 =?utf-8?B?SVd5dXZPN2tsUklKY3ZlcGVGU3h5cXd2QUtkTUJJMjFmYVBGMTNWc0RpZjdG?=
 =?utf-8?B?RnFhVXlBZXJaNHhKL3ZBWW1EL3M2VzYxVlp6ZlhXRkVJS3FjZm9GYVRGbTNL?=
 =?utf-8?B?ZXcwdTNyaDVySWEzcVM4ZHpHbDFuMmFScllOaGFldW9zZjI0U1FuREo5Y1Ro?=
 =?utf-8?B?bXlzbkEwVnNzMVh2cnQrR2dpaVhpUE10WE8vWHMwaFphQlNJYkNEQWZIZ0JW?=
 =?utf-8?B?OVNQWVB4VW9iZTlsL2ZlTFdwaWxBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <13B17F514CA3A043BB8EB08BB67BF5AD@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5079.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2ea2984-6d8a-4f39-5d48-08dc7fe4272c
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2024 13:35:06.6140
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wx1WjgNm4FAxB/tq6LwzzbDBXpCb0xgYpLheU88MYBip1rssBP7A1jYKvaFcceEhIsI+ifwe3s8OQqoKKezNdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB4554

T24gVHVlLCAyMDI0LTA1LTI4IGF0IDIyOjA1ICswMTAwLCBNYXR0aGV3IFdpbGNveCB3cm90ZToN
Cj4gT24gTW9uLCBNYXkgMjcsIDIwMjQgYXQgMDY6MzY6MDdQTSArMDIwMCwgQ2hyaXN0b3BoIEhl
bGx3aWcgd3JvdGU6DQo+ID4gSGkgYWxsLA0KPiA+IA0KPiA+IHRoaXMgc2VyaWVzIGFkZHMgbGFy
Z2UgZm9saW8gc3VwcG9ydCB0byBORlMsIGFuZCBhbG1vc3QgZG91YmxlcyB0aGUNCj4gPiBidWZm
ZXJlZCB3cml0ZSB0aHJvdWdocHV0IGZyb20gdGhlIHByZXZpb3VzIGJvdHRsZW5lY2sgb2YgfjIu
NUdCL3MNCj4gPiAoanVzdCBsaWtlIGZvciBvdGhlciBmaWxlIHN5c3RlbXMpLg0KPiA+IA0KPiA+
IFRoZSBmaXJzdCBwYXRjaCBpcyBhbiBvbGQgb25lIGZyb20gd2lsbHkgdGhhdCBJJ3ZlIHVwZGF0
ZWQgdmVyeQ0KPiA+IHNsaWdodGx5Lg0KPiA+IE5vdGUgdGhhdCB0aGlzIHVwZGF0ZSBub3cgcmVx
dWlyZXMgdGhlIG1hcHBpbmdfbWF4X2ZvbGlvX3NpemUNCj4gPiBoZWxwZXINCj4gPiBtZXJnZWQg
aW50byBMaW51cycgdHJlZSBvbmx5IGEgZmV3IG1pbnV0ZXMgYWdvLg0KPiANCj4gS2luZCBvZiBz
dXJwcmlzZWQgdGhpcyBkaWRuJ3QgZmFsbCBvdmVyIGdpdmVuIHRoZSBidWdzIEkganVzdCBzZW50
IGENCj4gcGF0Y2ggZm9yIC4uLiBtaXNpbnRlcnByZXRpbmcgdGhlIGZvbGlvIGluZGljZXMgc2Vl
bXMgbGlrZSBpdCBzaG91bGQNCj4gaGF2ZSBjYXVzZWQgYSBmYWlsdXJlIGluIF9zb21lXyBmc3Rl
c3QuDQoNCldoeSB3b3VsZG4ndCBpdCB3b3JrPyBUaGUgY29kZSB5b3UncmUgcmVwbGFjaW5nIGlz
bid0IGFzc3VtaW5nIHRoYXQNCnBhZ2UgY2FjaGUgaW5kaWNlcyBhcmUgaW4gdW5pdHMgb2YgdGhl
IGZvbGlvIHNpemUuIEl0IGlzIGp1c3QgYXNzdW1pbmcNCnRoYXQgZm9saW8gYm91bmRhcmllcyBh
cmUgbXVsdGlwbGVzIG9mIHRoZSBmb2xpbyBzaXplLg0KDQotLSANClRyb25kIE15a2xlYnVzdA0K
TGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0
QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==

