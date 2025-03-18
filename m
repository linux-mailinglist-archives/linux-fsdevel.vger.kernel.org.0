Return-Path: <linux-fsdevel+bounces-44320-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ADA6A67436
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 13:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9A9817E800
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 12:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9246A20371E;
	Tue, 18 Mar 2025 12:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="iyAyuj0y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2091.outbound.protection.outlook.com [40.92.40.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE943F9D5;
	Tue, 18 Mar 2025 12:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.40.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742301981; cv=fail; b=Cvnj5VsWUxFQ1iHb3F69lBKTob8jvnh6gR8AiIRFQ2XS7GeYUYXMvlLLrUtqAjbOMrCCKnwb0Gcap5CLLyL7ATDti4XjaXZ04j2gJH52gwz/2b64pDUBvKF3Zn5wm4IK7Ns3yHy0z0JRWaBc0jdXWIOQPrcKc6KzL/HN3qW4HA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742301981; c=relaxed/simple;
	bh=cXLNmhjDnt6DHlwSla+IZ8+zKh+IDL0kQi3U0cEz/eU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=URDKVvzIQ1oTvEx+Fhd53DUsHNGjb4WteIYP3nscute9ujAjHIoiRS77Gr6OPoZJPd5aZsQrozDvvujt6eqdpjlnCDe3k/M2EDH2klaDem0weeE2eYVK593YQrAyAVfOB7RJRlhkaGO1G49/KwOpik8u8yxNTv/PIvTIDvwMxtM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=iyAyuj0y; arc=fail smtp.client-ip=40.92.40.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PbFzDsOEeqtuLTj9f8DgqVqM4sUm485DmILPHwxeuyJv9P+s9sNlk9xcLjoSDKWS2Hh9tk51DIqvt5KGoFiaxbFccrdItMJ0PGa4wUaE1NeCLf4Hy+WQDmkKdRhXbnZAl/bZjQdK6kJmSxflbkB7IQHHJzg0wtVI1P4V2DvWRAdhGao4LxCQq+59Nnf1ftP6Z9xDYKxN3kwxnTekTrI6WmmZmoicamuqGjtO+IH7n77LK/FEZhIDBRlNwMWG12ybJw1zobfx1tQYUYW7qIGLzSOomLDLqnyqpb4+TdHKEVCcDEuJWAA7ykqlQbzYG1u4iTS0PzWzoe8OMabALcvWKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cXLNmhjDnt6DHlwSla+IZ8+zKh+IDL0kQi3U0cEz/eU=;
 b=q1GFaXDys8qaqx29GPu13goeatNoAjv8wxdjLy8/QTShJq8rZun4DS/QJbgwwQAAVaYCffI6JMoNbNtQgS+04OkDmxnFvI4FUdDVHrsc+VRVwK6vzF0GtARGvkcKpF/kZWGSI5UZDEanYN87I+2uNHWKJLCgZ4o3kHmb+uW6UzOrVk2GOmIOFmAC6TK393k0fBAFoNEk4G2MDz4nIJ44k7Mf3C+1BdVIhKhQJvzqxuzQw8eVz82HT3kieNBXFWBfXqoGVM6x3tVxOIrtS4TGbz9Wf8HJ7gnYM/QF4TqaF2sn2DHdDvJdUPbrmhhKpY+dDLwQ4ichY1bZMo0doOO07Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cXLNmhjDnt6DHlwSla+IZ8+zKh+IDL0kQi3U0cEz/eU=;
 b=iyAyuj0yqGcKaXOS1kBS2HrnpBg5oG66e7KUvx2XFqgvTDTY0RUZ5/QOmBFhYUSiAZsQLPBbao6cnQdgt5ZQUMUOoapAYPlAGKMI3a4MCueU+nZycWXyryj1rcgzKJW3J/JItOCGUdkbKXMArS+x3rnWWXBGXq1GXEv+cZuRuHbRR0h/4jX681NH2ORvvJ8KTueeQmNs8bqUmkZnRQtTzZ1LDXEJgRsx/vjsVJJqw6kiI6wcwIRzxq/bs8Em1DmZZex2mfxOVOUUUmQCM3KorMYy3jEyp4rhlrZgKdAADFIpCy7daDl/qI4nfpS7r13KOxeKdHaMEgX3oA6mejg3Kw==
Received: from BYAPR12MB3205.namprd12.prod.outlook.com (2603:10b6:a03:134::32)
 by SA1PR12MB8918.namprd12.prod.outlook.com (2603:10b6:806:386::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 12:46:13 +0000
Received: from BYAPR12MB3205.namprd12.prod.outlook.com
 ([fe80::489:5515:fcf2:b991]) by BYAPR12MB3205.namprd12.prod.outlook.com
 ([fe80::489:5515:fcf2:b991%5]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 12:46:13 +0000
From: Stephen Eta Zhou <stephen.eta.zhou@outlook.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, David Disseldorp <ddiss@suse.de>
CC: "jsperbeck@google.com" <jsperbeck@google.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "lukas@wunner.de" <lukas@wunner.de>,
	"wufan@linux.microsoft.com" <wufan@linux.microsoft.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC PATCH] initramfs: Add size validation to prevent tmpfs
 exhaustion
Thread-Topic: [RFC PATCH] initramfs: Add size validation to prevent tmpfs
 exhaustion
Thread-Index: AQHblJ3gvljUi14PpUKtURVssHl1u7N28UyAgAHewYCAAAukFA==
Date: Tue, 18 Mar 2025 12:46:13 +0000
Message-ID:
 <BYAPR12MB320544939A73966CC84D5020D5DE2@BYAPR12MB3205.namprd12.prod.outlook.com>
References:
 <BYAPR12MB3205F96E780AA2F00EAD16E8D5D22@BYAPR12MB3205.namprd12.prod.outlook.com>
 <20250317182157.7adbc168.ddiss@suse.de>
 <872d008e-8412-4351-a954-29ee7c7c8315@kernel.org>
In-Reply-To: <872d008e-8412-4351-a954-29ee7c7c8315@kernel.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB3205:EE_|SA1PR12MB8918:EE_
x-ms-office365-filtering-correlation-id: efca8118-c29b-4831-269f-08dd661addba
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799006|8062599003|461199028|19110799003|8060799006|15030799003|102099032|440099028|3412199025|12091999003;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?Ud8iUoZ/yKwPSTo1UBkI51E4ecsuRL0Vh3SHJj12x8yIOjSDd6lD+INuk+?=
 =?iso-8859-1?Q?qvLMGbDxXVX4cAnXANn8/05HfWpYSnlJvvMVLhNiitc9GMioS4BeWoY7no?=
 =?iso-8859-1?Q?3TkDFtzNL2Xqi8+tioIF6ir91zCUaaihbSbroY3JJMAQ4MolnVY6BdT47S?=
 =?iso-8859-1?Q?zGaIjSjdY0yQ/VR1vXnBuEOlkYHu8uYJCnq+7dpl0DRUh60ITegKUYjaaQ?=
 =?iso-8859-1?Q?gbkEHyKBPYBHsA7nKf9I97gApaa+YliQoAwFUD4UinwcegiH587iPlJ39/?=
 =?iso-8859-1?Q?85zPSVK1D5xy4rjEFYQUkd3n3i/MHvd1Ed5/XA44loksPvsbGSk3/Mvevf?=
 =?iso-8859-1?Q?duc0cPvaMhdJdSwpfke89oHaa2cf94i1lgWYA2xQ+CeQLe3YvwDGD66nMB?=
 =?iso-8859-1?Q?o0lpwf6pl4WZjdisQqW5L4xOzZXooVNwXtG0nAzdIq1nkw0e4RtoJWIyCl?=
 =?iso-8859-1?Q?/i+AB3H9NN7znvdvEPp/Zh7H8/hJWjo+A8Ff53B8kGmoc9jCxmbm8BHeGP?=
 =?iso-8859-1?Q?XH+ie3NM8PduJI9U6vcZ/CVUbInBGmg3+1/UEDD3uMiXlEH7cGnXv+hKCD?=
 =?iso-8859-1?Q?cO4n3zzpfmwmMYDS1gR4s3V0pQowiKiChNfhvDk0EGYVbU23mk+gWMS2vI?=
 =?iso-8859-1?Q?vE43T1ipU0Vb1GpseLYh3uOc94L3f+HwL06kLhTaMEWawMl5K5V80zUx4f?=
 =?iso-8859-1?Q?da03A2RM/hRK567C49GYCrPget1Ao6U2NgQvgUU1k2JPJDYGvFt3Y2wrbN?=
 =?iso-8859-1?Q?Z7TYLvHERUpI7oErekHzM+8aphCez1qLSJQ3hQ+3IN3YZOK1hzril9GzfR?=
 =?iso-8859-1?Q?J9gu0tnvp9UrcPRJKiBCMnz3YpttWF3pzV1obRo4PrqRB2PDLNF2zjocS6?=
 =?iso-8859-1?Q?3ETzKe6EwgHLPYEMB0vuHnUqBDVLyRTUh+2i5H37ffNCoZ1PGwZciBLxDo?=
 =?iso-8859-1?Q?Lz1rX3sScojeJFFOz8a/oFiufPAnBr4chppISzc3dJUQ3tkaZjGQODedNU?=
 =?iso-8859-1?Q?Cypcl4OZup7sob8nT97gs6a3zK+y/tYTlte26M0vUv0WW5LRQ2yXpgOBB1?=
 =?iso-8859-1?Q?a70VxDFD5ivnX1c4EzP4ghMmA2GAoNkewlng6PqfLViHf9oXQ3VKf34JNN?=
 =?iso-8859-1?Q?tarLCcyxz7RGJGi1bEKMrbi65MY5wTheWkpaiQc/Iuh7siUzCQSdvE1Ez2?=
 =?iso-8859-1?Q?Y/BQumw9GaNGiw=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?MdNi7ieq8u1QvKxvEXJoYvXMr6/F3jHMn1m1fX3C5gio6jF/9WdOlYhgT7?=
 =?iso-8859-1?Q?9l63kya1xmyGz8x5U9JzOtwel8QTFvkKINEOB8lWeOsEHqSJi7Q5V3kYOG?=
 =?iso-8859-1?Q?/zt8o2KW/Ei2YPVTBVM9aIbXWwU28Voi01hU8e8zStoXeQ118XfCqR7JZy?=
 =?iso-8859-1?Q?ZVwZnui3hE0BBr2q9qRwyfmM6xqUD/7hDCGIcf4GUIBYOBeD7PDUonmtTi?=
 =?iso-8859-1?Q?pJ0IyKYhTre9UYEg0MXTWG+Td0ISpyjiPNRNJ8SnfZK5m1FVZq3zmOvo7W?=
 =?iso-8859-1?Q?9pF4ZPGJA+1GRSU8qejuSGVlzKiy1nFL8uTXl50I3dg9ZH8G8ClwyW1lAd?=
 =?iso-8859-1?Q?aMYb5/PbJr1rMtHRfVg9ELJZ3lLVwKMQTB3LAW2WzX4C3MEjjj/0MGB9J1?=
 =?iso-8859-1?Q?b2SxqnD/hJ3NvyM0Ax4vOfQvIG2zirBNrTlBKYODHLql0zZfSJde/KiPWc?=
 =?iso-8859-1?Q?Sj8fXHMYp7f1h4viMIqEsAqlfal/ToUYUiRo5gCGnfToEoArk7zNWF8DqH?=
 =?iso-8859-1?Q?BUJDBYLm2l2/tOfNvB3f3hrFB3NJdxV250r+GDmiioLMhIbmOUJXLB5jCp?=
 =?iso-8859-1?Q?cFdeiE9dsHQWHnrcAQWOXW89Qi0oQYvzbBNrTMFxDQJkq2GkucgDNImOkj?=
 =?iso-8859-1?Q?Xe1aNQ5xZss7cDFzgas4eygGpkIGEnwpBVPCn1Mb1s9L7+7g94luTUWYfE?=
 =?iso-8859-1?Q?WC4RDV7W1IUfSFY56X/BR/q0ajlNjHcclF7GJvE6m9XENwOXuIUI7f1lhA?=
 =?iso-8859-1?Q?yJfGmooKny1rHziVL69/D7JOMAug1hpQFCReaTq8mxCyGRr6cC/U9uNWXf?=
 =?iso-8859-1?Q?SwSDdbdrDxlBoxtPZ+4MbfipSXA3ld/PW3ln177XXKc09nCpLQlWTb2wPp?=
 =?iso-8859-1?Q?Wj/iH6ouAcgnfqzISkoi2+ACogTM49vaoU2D+xl7D+iUqCkvlYKsRLaGRG?=
 =?iso-8859-1?Q?KVTXTWm02gH67WolJgkJQqzHXz/wqZzRYmFI5hpv/HDCNk5tQPbu3noeV9?=
 =?iso-8859-1?Q?93Uhj//ieTHTnBlt6kbir+EgVOT5Hgw2CDrK/L+ZXO2G3wCFj6BdGXvMBl?=
 =?iso-8859-1?Q?9PRiycCe4UvHpUDN3sobtCFbuT3/YSebaKfkoNl7l2zxTS578W/FrVV2jf?=
 =?iso-8859-1?Q?+/OQB8VVTmvaozM8SXSfWAhVQ41enzfJW+k96p5U0Jm1emedBeR//myVmj?=
 =?iso-8859-1?Q?IVoEa3W6Vz80qj/ent21V4yPYg2iyp/dRTKttwxoaZy5R3dpJESO5jUtbL?=
 =?iso-8859-1?Q?jR0ud3AbY6vpJsFw7EZ4PWSPHMjKJNm86lO+PGd0Y=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3205.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: efca8118-c29b-4831-269f-08dd661addba
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2025 12:46:13.1098
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8918

Hi Krzysztof=0A=
=0A=
> Just in case before anyone tries to actually apply it: the entire patch=
=0A=
> has both corrupted header and actual patch is corrupted - all=0A=
> indentation messed.=0A=
=0A=
Sorry, this is my oversight.....=0A=
I checked it locally using checkpatch.pl and it was fine, but I just used i=
t to import and found that there is a problem. Sorry for wasting your time.=
 I will regenerate this patch and resend it in the correct format.=0A=
=0A=
Krzysztof, thanks for pointing this out.=0A=
=0A=
Thanks,=0A=
Stephen=0A=
________________________________________=0A=
From:=A0Krzysztof Kozlowski <krzk@kernel.org>=0A=
Sent:=A0Tuesday, March 18, 2025 19:55=0A=
To:=A0David Disseldorp <ddiss@suse.de>; Stephen Eta Zhou <stephen.eta.zhou@=
outlook.com>=0A=
Cc:=A0jsperbeck@google.com <jsperbeck@google.com>; akpm@linux-foundation.or=
g <akpm@linux-foundation.org>; gregkh@linuxfoundation.org <gregkh@linuxfoun=
dation.org>; lukas@wunner.de <lukas@wunner.de>; wufan@linux.microsoft.com <=
wufan@linux.microsoft.com>; linux-kernel@vger.kernel.org <linux-kernel@vger=
.kernel.org>; linux-fsdevel@vger.kernel.org <linux-fsdevel@vger.kernel.org>=
=0A=
Subject:=A0Re: [RFC PATCH] initramfs: Add size validation to prevent tmpfs =
exhaustion=0A=
=A0=0A=
On 17/03/2025 08:21, David Disseldorp wrote:=0A=
>> From 3499daeb5caf934f08a485027b5411f9ef82d6be Mon Sep 17 00:00:00 2001=
=0A=
>> From: Stephen Eta Zhou <stephen.eta.zhou@outlook.com>=0A=
>> Date: Fri, 14 Mar 2025 12:32:59 +0800=0A=
>> Subject: [PATCH] initramfs: Add size validation to prevent tmpfs exhaust=
ion=0A=
>>=0A=
>> When initramfs is loaded into a small memory environment, if its size=0A=
>> exceeds the tmpfs max blocks limit, the loading will fail. Additionally,=
=0A=
>> if the required blocks are close to the tmpfs max blocks boundary,=0A=
>> subsequent drivers or subsystems using tmpfs may fail to initialize.=0A=
>>=0A=
>> To prevent this, the size limit is set to half of tmpfs max blocks.=0A=
>> This ensures that initramfs can complete its mission without exhausting=
=0A=
>> tmpfs resources, as user-space programs may also rely on tmpfs after boo=
t.=0A=
>>=0A=
>> This patch adds a validation mechanism to check the decompressed size=0A=
>> of initramfs based on its compression type and ratio. If the required=0A=
>> blocks exceed half of the tmpfs max blocks limit, the loading will be=0A=
>> aborted with an appropriate error message, exposing the issue early=0A=
>> and preventing further escalation.=0A=
>=0A=
> This behaviour appears fragile and quite arbitrary. I don't think=0A=
> initramfs should be responsible for making any of these decisions.=0A=
>=0A=
> Why can't the init binary make the decision of whether or not the amount=
=0A=
> of free memory remaining is sufficient for user-space, instead of this=0A=
> magic 50% limit?=0A=
>=0A=
> What are you trying to achieve by failing in this way before initramfs=0A=
> extraction instead of during / after?=0A=
=0A=
Just in case before anyone tries to actually apply it: the entire patch=0A=
has both corrupted header and actual patch is corrupted - all=0A=
indentation messed.=0A=
=0A=
Best regards,=0A=
Krzysztof=

