Return-Path: <linux-fsdevel+bounces-48885-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C6E7AB5409
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 13:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 353A417C779
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 11:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EABA128DB63;
	Tue, 13 May 2025 11:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="t7K3TCqK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011032.outbound.protection.outlook.com [52.103.68.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B74328D85A;
	Tue, 13 May 2025 11:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747136499; cv=fail; b=uEExQvzpFElrnXvrq8fqz1jaEr5PBm/WxIJaQ0PeKxzwKSr5qP8mR1LqPPXj9zhSwb7+2glsGbNh1BZl9qbPVefxqAKJaQQZBHRxsi7cwnqOWzABRKBMLLoT5+5g3X/DHnXW6reGIhInJYwFH9SkcPw0h5GXwl/+II7EeP2Wouw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747136499; c=relaxed/simple;
	bh=s1u7hkrV6AtEVFRDyNUNj3diHtwWhSre7+A8RkUPVb8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iZBGTyHL80GYNJBL5t650Oyv0EKm3MEAgR0Tusv3JWU6pctEV2XgCzRam4axRMQn1O0tCA3TN9FzUmqdCn5qx+1zFxxQbzH8zqxkvOuayc0oJ8n8pYjQG4SSDDcR6pcnkqcyjMsrNNGsA3ISAju1SCuyw8r6Mw1DyeFOfY0zyU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=t7K3TCqK; arc=fail smtp.client-ip=52.103.68.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oBnA7fLvMFk1gjlbElX6yVxu6NmW8II/7cLp+tNYqu2SZvApRry9Vkq3Hz+Zbx54LhSoBcqwkg+QprlvcSpAgYLEF8DxlX/79Ai4AeY0htmyiKpuPI6QBuQRIMBGND24sVArXySbKKhGcY+RxUip+h9l8m+uv82U+hJQSJtfPgBTgXx1X1JM2s/4y7NToNK9AaCh4R31YDWUeAuOtzh/51g9aptwgOoKcI1iANMpkmWjvlQ3oU4SL2bfH4mCdv2cjXf2FdaWwMu5bqz/Tlf+HpFi0NxrzjZ/ISEBB3E2ZwmjJroGMYAqp94r3UtaaXeYiPhpzLhESv5oqm5G5Nz4JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s1u7hkrV6AtEVFRDyNUNj3diHtwWhSre7+A8RkUPVb8=;
 b=SbcKWSnQ0WVq9WbaB8i9a8fFeq42xcOYSrd33HxnWQG7PL82zDb00YlpQErYjnRq4MFlLugmSHU/FbrYAJK20fheLerGTBIvqtBMTG3ExD3uHZRLthwbjUmL6kst9tWNtOFqBCete4SWhJrBFIvt0sKH4NErywOAUQYa01kPXs+GXyBvePY3/aacU5l4ggrdkOX/LE66M2tGINfLGVk3W0nctYZdIAP7IIWoEa5HdFMY+xDwO9z78kD7tLtoKT65RkTv7vwk4lD5G31oRjqiBS5XhkW3KYtb/qDVCgCaNLyc7GIU3wxBzwRvbg3LSMaM1tLHowEDOphuQ5GPyKuL9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s1u7hkrV6AtEVFRDyNUNj3diHtwWhSre7+A8RkUPVb8=;
 b=t7K3TCqKEKBpHJM/TR/l8W/VlqOEdp7TeZAxjcOp0xnaguv/VGsCQOqftOKGdoY3r7yTIspeSHy4cNIYf5QbnkJ4exmtMqg+hVIQp02fFlRysl4asz18YChW5Gk0rQBitWgIC3HEeugE+Qgxp/scH0lR19YSTCkB526fh4+qKJ+7e+10LYQhuR72sSFbUtX6LBwBeQ81DS5SttW6YBOeu70GDEtNFw6beu5vAhXWjEnZiGdBHMLmpg8zztog12WHaoZsxHa70XVXI6G/4yA43jSqVTKA5EE6NmAH7lVDVD8wxqSDL2dqRglhxKv+3UHVQh/w5+em3W/ziVeGFxBOQg==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN0PR01MB6716.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:77::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Tue, 13 May
 2025 11:41:28 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 11:41:28 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Nick Chan <towinchenmi@gmail.com>
CC: =?utf-8?B?IEVybmVzdG8gQS4gRmVybsOhbmRleiA=?=
	<ernesto.mnd.fernandez@gmail.com>, Yangtao Li <frank.li@vivo.com>,
	"ethan@ethancedwards.com" <ethan@ethancedwards.com>, "asahi@lists.linux.dev"
	<asahi@lists.linux.dev>, "brauner@kernel.org" <brauner@kernel.org>,
	"dan.carpenter@linaro.org" <dan.carpenter@linaro.org>,
	"ernesto@corellium.com" <ernesto@corellium.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "jack@suse.cz" <jack@suse.cz>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
	"sven@svenpeter.dev" <sven@svenpeter.dev>, "tytso@mit.edu" <tytso@mit.edu>,
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "willy@infradead.org"
	<willy@infradead.org>, "slava@dubeyko.com" <slava@dubeyko.com>,
	"glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>
Subject: Re: Subject: [RFC PATCH v2 0/8] staging: apfs: init APFS filesystem
 support
Thread-Topic: Subject: [RFC PATCH v2 0/8] staging: apfs: init APFS filesystem
 support
Thread-Index: AQHbwyNzqehbet5hqkK4n55fUDPpSLPPqC8AgABMRYCAAH0xwg==
Date: Tue, 13 May 2025 11:41:28 +0000
Message-ID:
 <PN3PR01MB9597DA4A452F730A3E0412E6B896A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <20250319-apfs-v2-0-475de2e25782@ethancedwards.com>
 <20250512101122.569476-1-frank.li@vivo.com> <20250512234024.GA19326@eaf>
 <63eb2228-dcec-40a6-ba02-b4f3a6e13809@gmail.com>
In-Reply-To: <63eb2228-dcec-40a6-ba02-b4f3a6e13809@gmail.com>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|PN0PR01MB6716:EE_
x-ms-office365-filtering-correlation-id: 53f54abd-e93b-4aa7-5cf1-08dd92131974
x-ms-exchange-slblob-mailprops:
 znQPCv1HvwVu6ov8hlKZu5ytU8AWxKlxgdBoX7e/5c5NULbcr3Vsww2fZtDK6cJJ3QnTqT2bvlZWYrOcwBE2GZGEKFAuUsfIhBMdTr2x4vgrEacrkp5fkClNRi5wqoKslCkWZjYHAKc5G/Xz9fj/b2nivv1KQ6GiLmbU9digk65TicJIDirO4O3fRfnVNSXGnI1zn1NL3JpJVv3GAoAIx5fUYnvbuPGRbN/v4LVwaPw7OVH/HZA1RvJ5a4nV475ZfiPAaHnQq1ZGy52fY/ikcLWfwEmkk8eyW3yUnPKW6A4wr40vA/8ZqDJ9JciXePOVZRDuZvMzYhTHpVoVyA2tztXKKyv3V6fVyiRMXjNUBGUSG+blqDTcboUUVsKGt17E7fEPdI5Tefbu8vpthjkW59niqd6ioSBYsGjhrygEI/UWQiMAgrnBB0i+L2HvmaOpmnYBiij9gs1zM8/4st3tv/WjREdpEvJPrbf5Bd94nsDbfROXGDdkX79cDGFLTeU4UF6wDtMmDRdcxXK4yKiBcZJJ7Ga96i8VmfloIRM6Lz+sQXiIce5bNh8gMken2tCzHykj+3n34M3V20E4k7SUGj6kW5HMFeOFIdgcZQFqcAL03b6tc3ZGt6UwqaGmEWtAmVuj6DBACoMtew+TMnAAxUFQEgu5ueE0UVerMAABHl25PdkS3rcnn+asIRxmMbIaowdFaHHZfp4Vv4mb9JRIsdoJ1cI/AVny7xq4CmiBpPBk9ag0vRTp95Zfv/f2mtedtesgXFwnf7w=
x-microsoft-antispam:
 BCL:0;ARA:14566002|7092599006|8060799009|8062599006|15080799009|19110799006|6072599003|461199028|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 =?utf-8?B?bllQMUVmN1ZiNHA1TEJaajhyTjFpZXhNcEpEOUtBVDdXWllUdkl5aGtNeGlW?=
 =?utf-8?B?RFN6WEFCb09TYjVyc1lKenFDTHZTYjB6Q3Fobm05SzRPSENEK1NVM1hlYnkz?=
 =?utf-8?B?czJCVkpienJhQ3BQekZoV2xsclZKSEVvd2VSRStGSmNxbEpXL3czV3lmZ1ho?=
 =?utf-8?B?Vm5UL2htTllPQ0FBaHVIdkNQcWNQOUxweUJkcjhxWHFnY0oreVU4UEYwY2ZU?=
 =?utf-8?B?dG5iTzV1eG9HTlhIQVAwWHM0MzRFVjJBdG5iTFRPa29CNHpLbnB5bWhodDAv?=
 =?utf-8?B?b0xZcEtsSWc5VXVNbHpyempWQXBlcU80eVBFQXpiVFJ4ZTJoRWo5WDViK2Uy?=
 =?utf-8?B?SWVOZysvNE0vQWp3bHY3UzByaHBkeHlkenJYb0ppclJ5U1Y0TGQ3WnhCSUoy?=
 =?utf-8?B?bDhHVklyVkd5M2FkcHpVWUFpZGJzblplMVZyK1QxSHVmMW9yRVZHRTVaUjFM?=
 =?utf-8?B?RzlrdjJJenBEVE5CWHExOFgrTE1rZ1oxejRaQTU0VURsK2FTbkJaakl6dmVt?=
 =?utf-8?B?WFRlR2tBb3htdFJJR0tqUldoMUFqZjIrYjNXV0haaW5mUHRXWXcyNzBtMWZG?=
 =?utf-8?B?c0dMbC8xd0htZjY4WXhqTHBKR212bDg1MUdURWZqYzJpNnUzMVlaTTRkSlBZ?=
 =?utf-8?B?OEE4eHFWNVM4dWlvcm1VS1hDUjhZbjRWVGF2ZzFsaDhFaEs0MUMzaXpFckkr?=
 =?utf-8?B?UzZtUEJFaENsbktTekRwNGp0UTZhekt4dlhBMDdUTTJ3UXkxUHh3OEdHT1p3?=
 =?utf-8?B?d2NqWFZxcU1ZbGpsWks2TnJkNEZSU1FFODZRaFRPeG5kU3NGU29iem1vbjhh?=
 =?utf-8?B?emtQM3Vuc2ZTdWNyQm10cDQvZ2dhdnlHTklHQ09CeDZCWVBZR3d4dGVpQk1R?=
 =?utf-8?B?dFM0V1lHd2JPZE9oTng5VmFCWVk5QTBwWFBjckpVdUs2ejU5UXJjdXRIdzV5?=
 =?utf-8?B?d2F5NUsvelh4UGpQTUMzcXZXRGhwOENXYkhjUHluYlIwS2VwYXBEY1IrMzla?=
 =?utf-8?B?N2dMTUNNVDNaK3Y4N3Q5QVhXRjFNUVZmbDBuSS9SdyticnRWd2xEVkVpQnVD?=
 =?utf-8?B?YXIzSkU0d2tXRkFKMDNIa2pMdHdtVmYvdklrQk01Q0FYb1hDK2ErczBUUUx0?=
 =?utf-8?B?aTVOamFPY3V3SVRvZTdYeE83RXRjamNKOTJ5QWg3Mm8yTkYvNDVVdVlScFhv?=
 =?utf-8?B?cW5IcTY0SDhieEVXRElYQzI2NHZZVFV2dnF6Y29RRzhicDdMNFJLUVovVlov?=
 =?utf-8?B?NEUwRkpCaVdmdlIvUnV3Q2F4T2g5WTR0UnBlWUFvbWE2NjRxd2lIQUZrMzQr?=
 =?utf-8?B?T3F3R2FCWkJid3prak1KVCtoa1lWM0wrbXBodVNvS2RmMzk1VUFHSjN3M1cw?=
 =?utf-8?B?OEpwbjR1SzNGbzNZZFpuWEsvVzN4dHFaNzQ4L2NCNDJWa1lOSWRWaVZXN3h6?=
 =?utf-8?B?OTJTTzE3bmhJYUFMM0Zpd1VENFNvdjl3N2J1ZWU1Wlhra2JBQzBvanFPdVNQ?=
 =?utf-8?B?alV5cGtsbmFQY3pXcm43Tk5oSmhEbXRINVRmb1Jsck5hZ3k2TG1iVjFsRzFq?=
 =?utf-8?B?RnF0Zz09?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aHRxaGhTYlRVUDBOV2FWcXRMQjdwdjFtaCtwUnluMk9RdUFjWnlGeWIyTVE4?=
 =?utf-8?B?c1lURmR1QTM4dnJ5aDFudlJkMEFOazBOV3dEclhPeXVhSldQSDd2Z09VSUM2?=
 =?utf-8?B?eGtUaElLSXY1NjZUcWhLbkxjaW11VmN0SG9kdEl0Y1o5bnlNeHlIK3lVTjVX?=
 =?utf-8?B?TDFGZEhmdUVlTHNzQmlQMGQ1cVV5SjJLVHVqckRhY25Ic0FvL0hWY1ZMYWhI?=
 =?utf-8?B?bll3NjJUc21qUVJuMVk0VFFLOFEzOXVXSzRwazlNNEtMNHpNSi9BUEhqSE8w?=
 =?utf-8?B?QTV1RjZnL1pLMUxnSjFjMGtTZkV1amZnTVFJOHpiQlZZN29qTzhIdDlITjZF?=
 =?utf-8?B?Z1F0Q09OTkhqd1FzRkpYUGw3NjQvT0hDMGpBZGFkVkpYT1hHVnJmL0V0Nncv?=
 =?utf-8?B?TjFwYU91aFZENFJqazg0OWFhcU1IQS9oY0xnMGEwVzM1VWJ4T2JUVVhKNnVp?=
 =?utf-8?B?L0ZFWGorcVRDUDlLREhWSkx0aWJONStoZm5oK0NxNlBsN2dwclY3d012Ukcv?=
 =?utf-8?B?dnJKM2ZzUXV5ODY3Yy9nNFpiWkZFenJiTXN6SVJlWEI2bG5Hd2c3cDRsU0th?=
 =?utf-8?B?VkNwb21wLzV6Zm9KSW5xczJiOVBPSXhUZHpLUlJOYzFGd3FYZ21XRUhpNmNt?=
 =?utf-8?B?NXlFMG52d2pxQnFJamNWMU0zNU9KdkY5VUt5UFpzcmdtNCtQU1k5aWxhaTdr?=
 =?utf-8?B?eHJ1dkhQTzJ4TmNHbVljWGF0djNyd0dXNXdiUVJ6OXFCODI3Z2d0ZXhKcE50?=
 =?utf-8?B?clJjSm8zaWU0Y0FCbE8zVGl2Qm1INFNPN0hsOWZaemlVUXN2aXgydTdOK3R3?=
 =?utf-8?B?WFdNdWVqbk5OVDBYN0l4K003dURDK0tPSVZRR1lXZTVBUnFwV1hQdmY5cE1p?=
 =?utf-8?B?YXE3aWROck9vZjMvRXNLR1BCN3BTWnNxUEUyRXU2UDJYcno3czhQQ0xmYVJk?=
 =?utf-8?B?M1RpM0F6ZDN4dU9VUCtiOHN6S0MrWjFNbTRQamFxVnNXVTVZbHdHRm8rT0R0?=
 =?utf-8?B?ZXgxSXoyeDFyM1JYSms4Zml5UTB5Um02N3lFVW1Jd2NhcG9rOXcyV2lCcDZ5?=
 =?utf-8?B?ZTB1anJ0ZmgzdDBWS0RoQlZUMHRXdVN4U3VES2ZZRDB5TFpyVEM2QTRKZkxQ?=
 =?utf-8?B?Zk1vQUVVZzRxenBScUxhS0Q4cmdXeXlOY2hwWmpCVy9GQm5udzgyeGl6OE1v?=
 =?utf-8?B?M2ZmU3ZtVDF3UjJGUkIzZjNETTlXV0ZFclRVdW1TU3BZS0hMQkJBWkdudnhE?=
 =?utf-8?B?ZnFlMkVVbWZKTWRPSmFpSWI2K0pKMms3UEUwbmpUMXRNMnVBd2VjMFhjRjd2?=
 =?utf-8?B?ZTQyQjZ5SHZwUlpnS0J4SHhkeldRSG5GUEhvY0tOd003clZ6M0RnUmV1OUFD?=
 =?utf-8?B?TURTQXlINnQ0OXk1b2RJTldPRmJqY0Y0OVVVVVpsUjJZTDRXSTFFRmNsWEo5?=
 =?utf-8?B?L1ppTldDK2hZN0hnRk1VdHRrL1hNUngwbVd3TzBKakErV3lNdXVQZjJOaWFO?=
 =?utf-8?B?K3hYQ2U1NmpyUjFQR3gxK0preEFZWkpPNXJ6TjlENXNMZ3BZSkVlZUNyd2pM?=
 =?utf-8?B?YmE5RjlmZkFVOTZ4bm9mNEpSRU1GUjYyR3J6WTZ0MUszcjhkWUk5WlV2Ykd3?=
 =?utf-8?B?UjEzVFpKZnZRR0V4VUordkJrTERlWDJzUVZoSWlPV0ZqdWxmL0lYM0tiS0E2?=
 =?utf-8?B?K3g3V0dyYURjdnBoQWM4KzBHdDZlQmpncHA1UXJNRjZWSlR0MVUvZDNJZEZZ?=
 =?utf-8?Q?Nk7GoPjjF2HQyqKtuc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 53f54abd-e93b-4aa7-5cf1-08dd92131974
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2025 11:41:28.5209
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB6716

DQoNCj4gT24gMTMgTWF5IDIwMjUsIGF0IDk6NDPigK9BTSwgTmljayBDaGFuIDx0b3dpbmNoZW5t
aUBnbWFpbC5jb20+IHdyb3RlOg0KPiANCj4g77u/DQo+PiBFcm5lc3RvIEEuIEZlcm7DoW5kZXog
5pa8IDIwMjUvNS8xMyDmuIXmmag3OjQwIOWvq+mBkzoNCj4+IEhpIFlhbmd0YW8sDQo+PiANCj4+
PiBPbiBNb24sIE1heSAxMiwgMjAyNSBhdCAwNDoxMToyMkFNIC0wNjAwLCBZYW5ndGFvIExpIHdy
b3RlOg0KPj4+IEknbSBpbnRlcmVzdGVkIGluIGJyaW5naW5nIGFwZnMgdXBzdHJlYW0gdG8gdGhl
IGNvbW11bml0eSwgYW5kIHBlcmhhcHMNCj4+PiBzbGF2YSBhbmQgYWRyaWFuIHRvby4NCj4+IERv
IHlvdSBoYXZlIGFueSBwYXJ0aWN1bGFyIHVzZSBjYXNlIGluIG1pbmQgaGVyZT8gSSBkb24ndCBt
aW5kIHB1dHRpbmcgaW4NCj4+IHRoZSB3b3JrIHRvIGdldCB0aGUgZHJpdmVyIHVwc3RyZWFtLCBi
dXQgSSBkb24ndCB3YW50IHRvIGJlIGZpZ2h0aW5nIHBlb3BsZQ0KPj4gdG8gY29udmluY2UgdGhl
bSB0aGF0IGl0J3MgbmVlZGVkLiBJJ20gbm90IGV2ZW4gc3VyZSBhYm91dCBpdCBteXNlbGYuDQo+
IA0KPiBUaGVzZSBhcmUgdGhlIHVzZSBjYXNlcyBJIGNhbiB0aGluayBvZjoNCj4gDQo+IA0KPiAx
LiBXaGVuIHJ1bm5pbmcgTGludXggb24gQXBwbGUgU2lsaWNvbiBNYWMsIGFjY2Vzc2luZyB0aGUg
eEFSVCBBUEZTIHZvbHVtZSBpcyByZXF1aXJlZCBmb3IgZW5hYmxpbmcgc29tZSBTRVANCj4gZnVu
Y3Rpb25hbGl0aWVzLg0KPiANCj4gMi4gV2hlbiBydW5uaW5nIExpbnV4IG9uIGlQaG9uZSwgaVBh
ZCwgaVBvZCB0b3VjaCwgQXBwbGUgVFYgKGN1cnJlbnRseSB0aGVyZSBhcmUgQXBwbGUgQTctQTEx
IFNvQyBzdXBwb3J0IGluDQo+IHVwc3RyZWFtKSwgcmVzaXppbmcgdGhlIG1haW4gQVBGUyB2b2x1
bWUgaXMgbm90IGZlYXNpYmxlIGVzcGVjaWFsbHkgb24gQTExIGR1ZSB0byBzaGVuYW5pZ2FucyB3
aXRoIHRoZSBlbmNyeXB0ZWQNCj4gZGF0YSB2b2x1bWUuIFNvIHRoZSBzYWZlIGlzaCB3YXkgdG8g
c3RvcmUgYSBmaWxlIHN5c3RlbSBvbiB0aGUgZGlzayBiZWNvbWVzIGEgdXNpbmcgbGludXgtYXBm
cy1ydyBvbiBhIChwb3NzaWJseQ0KPiBmaXhlZCBzaXplKSB2b2x1bWUgdGhhdCBvbmx5IGhhcyBv
bmUgZmlsZSBhbmQgdGhhdCBmaWxlIGlzIHVzZWQgYXMgYSBsb29wYmFjayBkZXZpY2UuDQo+IA0K
PiAoZG8gbm90ZSB0aGF0IHRoZSBtYWluIHN0b3JhZ2UgZG8gbm90IGN1cnJlbnRseSB3b3JrIHVw
c3RyZWFtIGFuZCBJIG9ubHkgaGF2ZSBzdG9yYWdlIHdvcmtpbmcgb24gQTExIGRvd25zdHJlYW0p
DQo+IA0KPiAzLiBPYnZpb3VzbHksIGFjY2Vzc2luZyBNYWMgZmlsZXMgZnJvbSBMaW51eCB0b28s
IG5vdCBzdXJlIGhvdyBiaWcgb2YgYSB1c2UgY2FzZSB0aGF0IGlzIGJ1dCBhcHBhcmVudGx5IGl0
IGlzDQo+IGJpZyBlbm91Z2ggZm9yIGhmc3BsdXMgdG8gY29udGludWUgcmVjZWl2ZSBwYXRjaGVz
IGhlcmUgYW5kIHRoZXJlLg0KPj4gDQoNCkknbGwgYWRkIGEgbnVtYmVyIDQNCg0KNC4gTW91bnRp
bmcgdGhlIG1hY09TIHJlY292ZXJ5IHBhcnRpdGlvbiBtYWtlcyBnZXR0aW5nIHRoZSB3aWZpIGZp
cm13YXJlIG11Y2ggZWFzaWVyIGZvciBUMiBNYWNzIG9uIExpbnV4Lg0K

