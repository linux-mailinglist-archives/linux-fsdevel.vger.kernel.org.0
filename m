Return-Path: <linux-fsdevel+bounces-14378-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE5C87B5D1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Mar 2024 01:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CBEF285EA5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Mar 2024 00:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB9323CE;
	Thu, 14 Mar 2024 00:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="Jv+vJ1SR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip168b.ess.barracuda.com (outbound-ip168b.ess.barracuda.com [209.222.82.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDE1A31
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 Mar 2024 00:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710376501; cv=fail; b=IxhkHKx6HXQLB9QJfhBmEemAi3ehOCAx37yV4St3I7A47Y72RwPVVuIyu1fLBMjhGla/YLTF79G7eVZ19c9VYaqTCspcPRT8ziE1kNfeF9DT6whHianRGbzTTeYDWX5QW1ryP9UCGfrpiIludw7M5F69pChGTvE0RQAv9OQeeEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710376501; c=relaxed/simple;
	bh=xcWN0iTSoJJw4LnpxPQLxiSQDcnJBy4BMUk4hRqBNDY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bhpbxcQNDLQPrxsvQ15veUWd6wj1GGL2Ph3EkhchfqYq2eGxm/HfDZGjChvcr02coiiiwxVMGj/uSSppPE0WIZD8vsSecvYquD2ylHGtqeRHLL4Wz+thvkYKg2d3lmCIPFl3Y8GBy/GV2bUZtXpeoOJvh6TkvmsMItvLFeuzJgw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=Jv+vJ1SR; arc=fail smtp.client-ip=209.222.82.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41]) by mx-outbound42-189.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 14 Mar 2024 00:34:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ecWTNHrZdIWA9R8OJHNY4zxcs7bFSHY1b9cLh8WUyZWifnIN13q1Ou3TaibaiQwrlMhs8l2RUEkM5Z0GETtSwaQ2DSRmaAcLrLe9/9Rzyb5VwpnITfHHzDq5rLGyWqblrNovQFL31kjPc/bDKILdvIp7k+uLUUqhHwCUaJ80PIZDH5enT7xkdKR4AaxZE94SC0P+TkWGiTRFSVFxCdDezycv0aWGl+8dDf4CTOxhRYkzq/sFkOWbSN1JpH+hVNV237sLh2e0KnZxMopYmg5X3zu+Wz6uKV4ecP6+HWduX+K1yPPe8vG5eqxYFTQmpXQk38gp5qw8EUFVY4UuMcA6Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xcWN0iTSoJJw4LnpxPQLxiSQDcnJBy4BMUk4hRqBNDY=;
 b=KpN+B7rOObKTN21Fh2+vxpZ85RbSNo83hRPEhcwAXkxVhatsdBuEgy8xC5XUwScZtdiRNfpEFbZuAMj3yo39yc2TZDvfM6/Mf4TJbMZ7qtjUKm9NZE1Swr9hzbWkTXlP/k0hHoEqNiFVr5dog6Sei0BbyCqLppoIttqHkKhDokwVjQLBAZV9fjjdDTnpjLc9S4PGWrQBxur5F0RMzw0HIuR4G0H42iB69j4tdVkX/kqjeLqMj5UabgI1vv58PzOx25AQQtOFsUPBc7xLVb4UQG42R0hs1AuJzWuPdZFQ9eNsVWndXfdWeQBsdBR62A4efHTDZffkErQIQ8nKZW0sMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xcWN0iTSoJJw4LnpxPQLxiSQDcnJBy4BMUk4hRqBNDY=;
 b=Jv+vJ1SRMP6iOqMawcb3MTDBLvSV0doGc0GKYtPZSpJWRy8tCbtH7ERRWXiOYSHQBUqZGqgdKEhtEuBA+S1HJwOXdG16qDSE+u6jajybg6cGcFKn/9ohpKEutONmlj8UVFbzxcrsmygWuTbY/wDL2yyCfsS09T5BKfWfoJB/JC8=
Received: from BY5PR19MB3474.namprd19.prod.outlook.com (2603:10b6:a03:1be::17)
 by SA3PR19MB7323.namprd19.prod.outlook.com (2603:10b6:806:307::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Wed, 13 Mar
 2024 23:00:40 +0000
Received: from BY5PR19MB3474.namprd19.prod.outlook.com
 ([fe80::f71:3119:aed9:80cb]) by BY5PR19MB3474.namprd19.prod.outlook.com
 ([fe80::f71:3119:aed9:80cb%5]) with mapi id 15.20.7362.035; Wed, 13 Mar 2024
 23:00:39 +0000
From: Bernd Schubert <bschubert@ddn.com>
To: Yuan Yao <yuanyaogoog@chromium.org>, Bernd Schubert
	<bernd.schubert@fastmail.fm>
CC: "brauner@kernel.org" <brauner@kernel.org>, Dharmendra Singh
	<dsingh@ddn.com>, Horst Birthelmer <hbirthelmer@ddn.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"miklos@szeredi.hu" <miklos@szeredi.hu>, "viro@zeniv.linux.org.uk"
	<viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 1/1] fuse: Make atomic_open use negative d_entry
Thread-Topic: [PATCH 1/1] fuse: Make atomic_open use negative d_entry
Thread-Index: AQHaTdhHcC3dO+iJQUGfmOLsK+VDAbDtsJuAgBQLwYCAD/fcAIAkEbKAgADS7YA=
Date: Wed, 13 Mar 2024 23:00:39 +0000
Message-ID: <89ffed64-508e-41be-a81c-b662f33e6d91@ddn.com>
References: <20231023183035.11035-3-bschubert@ddn.com>
 <20240123084030.873139-1-yuanyaogoog@chromium.org>
 <20240123084030.873139-2-yuanyaogoog@chromium.org>
 <337d7dea-d65a-4076-9bac-23d6b3613e53@fastmail.fm>
 <CAOJyEHYK7Agbyz3xM3_hXptyYVmcPWCaD5TdaszcyJDhJcGzKQ@mail.gmail.com>
 <46e6e9df-1240-411d-9640-51d36d7e2da3@fastmail.fm>
 <CAOJyEHZNnKj-qxnYMQoH3h07=7_jSRnuFJ5znPkarQXjdMZjBw@mail.gmail.com>
In-Reply-To:
 <CAOJyEHZNnKj-qxnYMQoH3h07=7_jSRnuFJ5znPkarQXjdMZjBw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR19MB3474:EE_|SA3PR19MB7323:EE_
x-ms-office365-filtering-correlation-id: 97b97fc9-c811-47ad-0903-08dc43b16700
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 m6/69VLGYBq4IPxE+NkBxIw3VYqpBmE0cMPubCYYDpgajS7pKfVNtLfqe99mDT6QO7ykiDRxOB7UePJs+7j46hX037wbWIsCRjLkET7qNQg1UAHuGTl4nC9xpCm3lWR3/lK5KTn9N8M0jJPXtDJwvHmLtpL97iyjrRhevZsj+/+aiC7sptvoxXght+vqhzXV5+Q0zfDWKNO4EtXUBIB5NMbN82cHWnoF8kKbjKGXA4JthjB09UM4RMM4dJjCRUwi+ge2WUC9hAqayWp8wmD11bQNyUpHCTnLYToU9ItQAyXy+831SdykmtrsIn2MIB5HW4huU+Uc2Tt6yTkeWvGFMsDxI9/plBgrmaxREdNBgtoBaBkz0P/UAwxfaH1pDhAxuAaKNWMUfL0JngnCyazYarykSiRA+DcPu42wbE6Bq6BM8hr8wxdqeqJCWqplP6kJ/gazPbVt3TkGtArwiKn+UB4LcNyKiMc9AUmkvhTu6jTq8s+THphgzOJFg/pixlTLSFoOOyzTC7FCBx4Eiz32YbIzBVLAAEY38s/E7cmBZELm4FAi1gWMxW57FYgO+X9ag21j5pN+d/l+ca8GUOIO0sVLnYJC7L+/RikAmJwsDVrnE2PPgNUXi5tFYNXFAM7sSEkTEYFxcamLU1uKWHCHFP1gfNSB8KSANRw/JbYiYKuvRaXHVl/EthJZusfP8J6Yhkco18BqL3aZsLvCd/9ycjXamSLiGC+XLKk+Qmg9jes=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR19MB3474.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dGtCRXZmRXlRVjV1Z3FjRHZGdFdWZE5UMTNtbENkR2R6UmpBNTR2R0swbzZM?=
 =?utf-8?B?WThoSjJhbkIyblQ2aTJHeFNCTWgwRmhHdldmajBnbXhRNXBNaVdkdFlqRUd5?=
 =?utf-8?B?OHNhNC9SZUtUdGptU05hUWRUN0pBUEpTRmlOREpjVjA0dlRDZG5Iay9QTnNl?=
 =?utf-8?B?My9KdmFhelRER2dsY1UvZTY5WkR0bGh4bzQ1MFhJa3Z6SFhDTytXYmNnT0ZR?=
 =?utf-8?B?dndKY1o3MmZQc1BQamFPbUJERFM3R0JhNzBGb3FrbXNxTU16N3N3ZXdDTElo?=
 =?utf-8?B?MGJMdkZ2U1RrKy94TURjTjBVR0EyZElWaGNHOVdYSFAwdWQwS0pVQ2lyTkpl?=
 =?utf-8?B?bi9kTVVmejJDVEQreW8zKzNYdElQcG1MRVlOanZzMWJ6NkhtN2xSdlJlcUt1?=
 =?utf-8?B?RU50dWg5ekdnZWFyK05KSG9wYnJ4TURrRldMcEV3SnhPZ1g4MndzS2J4S2gy?=
 =?utf-8?B?eklyWUJhSDF2RHBUWGRNUGgvbU5yTkdldWRsd3VmZG5jcWlXem9idUNsMkxz?=
 =?utf-8?B?cmpaYWNzL3pMdWRSa1ZKamcyTnVEdytiZkZYaFI5dTdvR21WS0N5VHJFY1Zy?=
 =?utf-8?B?M3VFSVYzTXVpalNEK0w5dkd4ZlMyN0JsSFNYRmt0YWlRYi9IZjlPVVZNN2Q1?=
 =?utf-8?B?Q0EzTmZvSWowUWFMOEVtcVQzbURxeGxDd1BxY245NWlxekdua0MxUzRuckdh?=
 =?utf-8?B?TnhIZFBVemJzY0VvRWphS01zYWFSazJFR3FZSUVtVVcvTENJUm00K3Q3cEw2?=
 =?utf-8?B?ajlWdml6SGVWWnJvS01BMGhZLytvUGdNL0xlVkxiV21Xcy9ReGY0VDFQSVFh?=
 =?utf-8?B?QmVzd2pzYW1TN2Ura1d4RHViVUZVTmNETWxyamRBUUVWdUFQMVhmdkVjUk0x?=
 =?utf-8?B?L1ZCN2k5eVFHMUcveXpaZkw0Q2tjVkhzY1J4NjMwNjRnWVBDSWpWMnV5NUpI?=
 =?utf-8?B?dVRzVHJZL3BybERsb1VlQnRHTFBvK2N2aEpBMjJtQUNlbTZ1Q3M1VENpeTU1?=
 =?utf-8?B?R1pybUNWR0kwL3VZYWsrQU9ESGhhRjJSV3Y1bm1KQU9uZEdnRmxzd1g4c2ZF?=
 =?utf-8?B?eFJ6VGk3a1MrSTJFWmlSeWFDWU04d2ZscEVlSkczNkZNTGxEM0lBd2lkS0tC?=
 =?utf-8?B?VnQ0T3lKVjRxQWRteXVZRW9JM0lOOGhReTdnU1pUTXp3blpNQ0lQTkVaQ1Jz?=
 =?utf-8?B?V3VQV2N0WmlPVkJnTEVMOG5ibkpoWmpjKy9CWTJVQzRVaFA5aU9FY3oyV2M2?=
 =?utf-8?B?cW82MGFhRWxBSVdhYnFkM01YK3lacXZHaC9GMVVMdnJFbjRBeThxeDlvNXQr?=
 =?utf-8?B?bURrNExQem5saGM2MjFYRXkxYkd0bVdTN3VBYjRsME1TNmxPUHVqbVpZRHVS?=
 =?utf-8?B?elNrMTNxRVREeFgySklPSGtBNklqWngxbkdhSTFabzZnZFQzS0pRNHRVUEFZ?=
 =?utf-8?B?SFMxbUwvM0UrOXhSN1FZY25sY1BwNWdtOXoxY3ZuQThYL2xkWUdQdWV2bzdY?=
 =?utf-8?B?eWtRSlVYbzJac2JwY3NTSksweWdnNkhEeFoydk12dTZxdHBZdGhGajNMTjlv?=
 =?utf-8?B?NVlpSVRUZ0ZqdUpmcVFLSlprdkdoQ2V5ZUZ0dTl4cXVzMndiVjY4ekkzcmZs?=
 =?utf-8?B?SE91M2dNM21ZcjI5emVZSFJHa0EwTTJBWG5qQVhiWFUxWXV2aDNjQ0xnNnZV?=
 =?utf-8?B?RUx5djc4alRUL0gzcUVOY1ZXVVY2dmErMktvVWpvQ2MwU3NHd041WFF4eXhl?=
 =?utf-8?B?ZnlWTzRiY0w1TlpZblZEc2EvQ3JWUGQ4b1pzM2REeUZDRkxoSXBYZmFhRis1?=
 =?utf-8?B?WTU0N3d5SG5tcllaRENjVE9PWWJid3hHa0x0QXlidmRtSGRvTTBkNXQ3dk9i?=
 =?utf-8?B?NVpOeHp5TXQ1ZTNLTXhGVlFlZC92VmNyREVFQWswU2c0enRldjFuekhIaWZw?=
 =?utf-8?B?NHM1QmhzcGo2Sm9jVWh6K2FaZnNvcE5ZWnQwQ3Z6WjNjKytycmpQVjdrSUh5?=
 =?utf-8?B?KzMrb0IrbHgwWWYzbWN3NEIxc0M2RS9FYm9MVUJ5Yk0xV3pVN2I0bndBUGRM?=
 =?utf-8?B?NmE3ZTAzT2dmMXM4cGE0Q09RN284R1B5MXhMVGVLOGxKRG9wOXp3SGFSVjhZ?=
 =?utf-8?B?d1JyWWxvN0piU0tmL3NIeFArZWNQdEtXUE5uZk1nODR3WFY4dDh3czlSVitr?=
 =?utf-8?Q?Q4sHGLc8jLyW/LoGdxpsvIo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1D8F79C7A2F2EF44821DC78089CD5689@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	41i3zDGP7HQ5/IjYFvuMntx+yCMHQq1WMEjbBX4WGVnJ4pStOMI8dObxyT6nUuD+makolVw20nKxPRZngEKekLzYFf69M8rHPdbr1LyOBC6xwMkn27jbJcOPqQQdKeLfR5P4JhKOsdeg3wW35PsMZOn63240ytTcIUamnOVyPgo+s+mSgKP2EYrNayTo0k1aJFnlJfFNR49FqMxdy/3CyceICfWgRf8XHNTqiYBJbsya9TJrGJKINotELDZbMlwI4iRICcc+A/KG3/78CdWRUPXILszq52TLFPWbrDtWTsShHTdA748RV8sqkrWjIT7aa+JcU1xhOtIvlOfKvBRHYLDaY7dnX5IGyjBCVe89iBt0cZ3gD8qaqvvVeukkvH6j0FjZGKaWKjdCerhXOi6Ql9fK7tUNoMth8RC/z+/X0BH36Ks/O4bfOsSmmjSSWntSuyfbCDgj9myEk35qrHRyT4ELaoYmG7iRgCNdPMDOjJnAEB6XYvqA/8FMgQAftxkW0YLNwss2NGwf6tOx0FeZog7WduMkD9DYEYaOWzu99eq8zSTtGY4NTutRoxeCRU6xCmagN9wiCudVAKCVoEILBWSK5rB4yTm/pps9PSxeTIx2MjJxQwJaqEsyjL5wAb6yEqOgInl+nkHFoCuO3mGQkQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR19MB3474.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97b97fc9-c811-47ad-0903-08dc43b16700
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2024 23:00:39.5524
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0Kav6Z0glUw3mHdzPizP6y2rZ3ekRtinT/yvujSo3LehtGqcEag/YWcHtTKLaCv4YQWeQ4XiqwDlPGs0IODsOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR19MB7323
X-OriginatorOrg: ddn.com
X-BESS-ID: 1710376496-110941-414-20237-1
X-BESS-VER: 2019.1_20240311.2358
X-BESS-Apparent-Source-IP: 104.47.66.41
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVibGhkBGBlAs2SIpzcDQ0NAoKT
	Ut0dI00cwgNcnA2MDEzMLSwjgx1UCpNhYA3/ABQUAAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.254851 [from 
	cloudscan15-160.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

SGkgWXVhbiwNCg0KT24gMy8xMy8yNCAxMToyNSwgWXVhbiBZYW8gd3JvdGU6DQo+IEhpIEJlcm5k
LA0KPiANCj4gVGhhbmsgeW91IGZvciB0YWtpbmcgdGltZSB0byByZXZpZXcgdGhpcyBpc3N1ZS4N
Cj4gDQo+IEknbSB3cml0aW5nIHRvIGlucXVpcmUgYWJvdXQgYW55IHJlY2VudCB1cGRhdGVzIG9y
IHBsYW5zIGZvciBhdG9taWMNCj4gb3BlbiB0aHJlYWRzPw0KPiBJdCB3aWxsIGhlbHAgYSBsb3Qg
aWYgdGhlIG5lZ2F0aXZlIGRfZW50cnkgaXNzdWUgY291bGQgYmUgc29sdmVkLg0KDQp0aGFua3Mg
Zm9yIHBpbmdpbmcgbWUgSSdtIHJlYWxseSBzb3JyeSwgSSdtIGN1cnJlbnRseSB0b3RhbGx5IHN3
YW1wZWQuIEkNCndpbGwgcmVhbGx5IHRyeSB0byBnZXQgdG8gaXQgZHVyaW5nIHRoZSBuZXh0IGRh
eXMsIGxhdGVzdCBkdXJpbmcgdGhlDQp3ZWVrZW5kLg0KDQpCZXN0LA0KQmVybmQNCg==

