Return-Path: <linux-fsdevel+bounces-44713-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F80A6BB2A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 13:52:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2B5A19C3BAE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 12:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753E0229B0C;
	Fri, 21 Mar 2025 12:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyberus-technology.de header.i=@cyberus-technology.de header.b="E+NofU+u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from FR4P281CU032.outbound.protection.outlook.com (mail-germanywestcentralazon11022134.outbound.protection.outlook.com [40.107.149.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A859E225387;
	Fri, 21 Mar 2025 12:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.149.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742561383; cv=fail; b=pMquyvu/dApsK3UZ3QdJEA3KHdF681YZ+8e5kZMORSRxiq6YuETHyJqKbHJZ/HvNSIYZdpV1bAk7xEEkI99FuqAbRUINjfFzoZbqeJ/IAvry/HL6V0Vzovp59BCUgHHfqHcdgeuiqXjnWwumW0emh/+3z7fsfFApF4sXMIJJNKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742561383; c=relaxed/simple;
	bh=LeGpLAq0KNdzLIi+TZVzh5XdKSbX9pT82w6Lgj6mUWU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WY58SVc9nw8HbVgiOAOX31C5ZioAqINrSC/SvoPMNiruI3cca9pHDddYPPHmF75T5rCQg77UljITarRorDmtdnd0+ftbbNqaTGJsAMcmB+PgF+7CBNbGTsICTMxlltIwHzgwUvyW5XeRlhd8N053yKPO0OV5lQMM8yv3j53ZnCc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cyberus-technology.de; spf=pass smtp.mailfrom=cyberus-technology.de; dkim=pass (2048-bit key) header.d=cyberus-technology.de header.i=@cyberus-technology.de header.b=E+NofU+u; arc=fail smtp.client-ip=40.107.149.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cyberus-technology.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberus-technology.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ymSpiN/aXQpXJCU3U6RHKDXAVh5GDGwVfbZcbIPN4a2nnQY7hA84dukgyiknAU5TzTxV50LTz6hiESD4x6CBVCnNrL29IEPB9MXDLDPxCghMhySFBNkYS6OSRC5jNBVXQArM2Y1ytorHqReAkHrwN5TjuJ1ZCfqz9kOoeXMfhq7y6c8Fs15rEMAmP2ZIvFCdhRNXZcNK+i0SKtsGBOrYWaMm6GAGsahDTrbpouU4oJyPDzvQII9s67OH+2Tq5C2z3BvE2C/lmvIWI9uhJdjMp3nWwGeaBCDSWtCr2RGWRxaBXZ3mxNo7cc8kYbWWjDXlSNVwyiS6JoP7S65V00wquQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LeGpLAq0KNdzLIi+TZVzh5XdKSbX9pT82w6Lgj6mUWU=;
 b=JFoxyK7Gv0V3hdcP5DLUzXUzPzZkci8XsgtzZnBM1YsZuPxIZ8t0sI9/lpvZM+VVM5vX0v6EyAAYp+jTKhEiVjciVHOv3Vwp6V97gFJAXv1WKRVgJVZ0tA55ieTu2wsH/p1ueDFMKJnuSTFVbkT0IjVsUeysGU4wHL2dENYUIrzd4FLds1LN0uj6EDILMvf73DToGBtoU9ry1ovLmokgoBfdtgxjRt9MxTeULVcBhKmZir87NdPo57pfyHzwo04SSnDO0zpFrOp8NxfVKtZwm5qHvpN9TG5rdsxs6DW2Oa68lPf+GFnlRe8LWVG2GLFMQgbBths/hoN3ALIeqS91tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cyberus-technology.de; dmarc=pass action=none
 header.from=cyberus-technology.de; dkim=pass header.d=cyberus-technology.de;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberus-technology.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LeGpLAq0KNdzLIi+TZVzh5XdKSbX9pT82w6Lgj6mUWU=;
 b=E+NofU+uSC+vztSNDyaR1kBYRAlK8iaxqILn17zWkrs7Rh1Z1Pz2P57iIJ5ouw4KuWmjjImKOBJWzcLTbQyjYJgQPnVNjp6Cb22b8NdpHhipmg/0uDcDpwsOxSRGCtYX5xOo2MQMQdQc5zvfatE0bLs/ap6ELZQ4rBnTkkq86QUDnqd/+UNFF9SJKhguZFkHYbTo5UYSGXIw0M8v7+pnznlj62r3lOqchwxwquiD/kVjZX0w+AsULcGxuv6AdzLTzw5/jwgB8S9amHMQ6xHaFFInGpW+TeKL1MTJ65N+gIkattiBGh6HxcmO9nBno1C1AF56FH7fMLZsOay27/eMqA==
Received: from FR2P281MB2329.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:38::7) by
 FR4P281MB3782.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:d6::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.36; Fri, 21 Mar 2025 12:49:36 +0000
Received: from FR2P281MB2329.DEUP281.PROD.OUTLOOK.COM
 ([fe80::bf0d:16fc:a18c:c423]) by FR2P281MB2329.DEUP281.PROD.OUTLOOK.COM
 ([fe80::bf0d:16fc:a18c:c423%3]) with mapi id 15.20.8534.036; Fri, 21 Mar 2025
 12:49:36 +0000
From: Julian Stecklina <julian.stecklina@cyberus-technology.de>
To: "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
CC: "hch@lst.de" <hch@lst.de>, "torvalds@linux-foundation.org"
	<torvalds@linux-foundation.org>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "rafael@kernel.org" <rafael@kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] initrd: support erofs as initrd
Thread-Topic: [PATCH] initrd: support erofs as initrd
Thread-Index: AQHbmc5FhigEqeqdAEenfkqes+M237N82KYAgACzI4A=
Date: Fri, 21 Mar 2025 12:49:36 +0000
Message-ID:
 <8285605c22bd4e818ea6f22ac5551d92211345f2.camel@cyberus-technology.de>
References: <20250320-initrd-erofs-v1-1-35bbb293468a@cyberus-technology.de>
	 <20250321020826.GB2023217@ZenIV>
In-Reply-To: <20250321020826.GB2023217@ZenIV>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cyberus-technology.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR2P281MB2329:EE_|FR4P281MB3782:EE_
x-ms-office365-filtering-correlation-id: a18e1f9e-106d-42f3-81dc-08dd6876d64f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?QXllOVlRdkxHMnN6OHBJSHhQR1c4cTEwVVJ4OUlaVWhuTmNPWHdCYnhJYXdC?=
 =?utf-8?B?RXQrRHRYVW92TndWVkU3bVFYN0hUU1JpRnhpSW50SDkrUnE3UzIvQTIrelZF?=
 =?utf-8?B?UHQ4Y2c1MTdIbUZZQkpKZTRQdk85Z1V6M3AyRlZiTEJzbklKbm9GTHprbVlr?=
 =?utf-8?B?cFJEVyt4M0JDc2ZwY2o3MnYwLzFSbG9STzdPdnFnUlp4aFlpK1UzOEZLOVI2?=
 =?utf-8?B?dkROcUUrbUFZdy82VUl3a0ljK2N5azhGMnk1U0JzdjdWMm5GYm1JVlJraXpN?=
 =?utf-8?B?THlpZUdUUXJ6MW53SC9PUktocUxMRHVZQmxPZEF3RWgwcFdOaGNMTEtMYzUr?=
 =?utf-8?B?V01vTnAvMDJuUFVxdDNWRGxVOStrdmN4UkNlTmV0dmZubVFyVG1iY3ZaZmpw?=
 =?utf-8?B?ZzhxTC9rbWlEUWs1ZHI5RTlXRXA2NUVyWmNUZzMwUlQxazkvZHNEV0E1R3J4?=
 =?utf-8?B?aW1hZFhIeHVyM29iOU04aFE2U1RXUUFjblJiY0h0MGFpeFJOQStQQmhkZUdM?=
 =?utf-8?B?RUIrdGJ4UUtXNjVDdnJBa21sdmxEZmxLSUJJRmlLTEtVWUV3T3Q5UG5lNTZq?=
 =?utf-8?B?cExMZWY0d3VZZzAzbG1ub2pXcEE1T1lDNmdFalA1NHp5T1dlNmVGY1EwL3hl?=
 =?utf-8?B?OWNYbHZsMkU3UDNUWlFONTBwbzA1WGRjV0JkRVl0SEtuR3lPeHhJZlNpM3dv?=
 =?utf-8?B?ZEJjTkpzZjY1VzFIWEJBNXJaS05QTEhWZXR3YW9meFEzbG1tRWs1YnlXVU1t?=
 =?utf-8?B?NDZXTnpMUG1DSUFrMm4vS1U0czRrdDloZkVjUW9laytacVhuQ05tYUd0cHJp?=
 =?utf-8?B?TVdFRnhuVXRxRkZJSUhzd1MxTmZnWWFVZ1NsNlF3RUxiUU9RWW9wbWtjazRj?=
 =?utf-8?B?RGpOeldFQm5jS2tWWFdneE5lMVNXZzlFVmYxTVdIdWRZdXhHSHRJVTFwcFYr?=
 =?utf-8?B?RGgrVHJEMzZYL3NjYUQrSlBkdDFJOThMZVMySnJja1Q4VFlVVDBSZVdlcEFo?=
 =?utf-8?B?NVFIanlrNWJ5aWFrWVpndDRHR0lWOGN4Ync3SnR1eGhzT3Bad0dHazlwRXdM?=
 =?utf-8?B?VnJZNTNjNTVoanhlTkpLUEp6SVhkem1yQzZ4clc5MjNMVFYxbmg1djhxOHpm?=
 =?utf-8?B?aEpaNzcrQ1lVZk5kajhUZW5PRzI3R1JHZUcyUklYYmJsMG94b2ZsRkVVTXZ3?=
 =?utf-8?B?NDM0M3d5VzVLd1JWMzhldC9yME9pTzBoU0xSMXh5aVVjRU9PeFVpdm9NQkRX?=
 =?utf-8?B?RTdzelBTbW03L3RaMTBwb2RCcnNEYzByRGp0N2ViK1pkam80c0Rza0FHZ2tI?=
 =?utf-8?B?d2I4TU9WWmY2d0NuK0ZoNko5QjdsdEFKdUNEVEJTSnYxOUduSS9WbDV0aWV3?=
 =?utf-8?B?UTJIK1M0elpxdjVKVHFuK1dQOW1HTkJGNitjd0RRSUdIL1NNUUt0bU9xUG90?=
 =?utf-8?B?NHBQYktTdjNSRzE3UWcxZVIrY2NJYXZXSkZHTTc4MG1QQk5wQTBqbmtRdWo5?=
 =?utf-8?B?bjlKV0xIOXk5R3R4SUJaVDdINUV6VDNFelUzYjRLNE5LMDZoaWh1VHAwTGRZ?=
 =?utf-8?B?MGRSVDJuMTdweC82aVpwcHNONUhaMzZBYWRkS2VUeHFjNlFYZVBXQWxKUi84?=
 =?utf-8?B?cXBkdkgzR2NDZW83ZE9pNlhVV2F6N0xRUDBxOEZhSWdxVDd4R0IyY3M0QUQw?=
 =?utf-8?B?M0YxdGRWdFNXbGNKTDF0RDQycTdTOXovODdBTU5kN3A3WHZhMHpnYXBQckZ6?=
 =?utf-8?B?QUQraWw3QzN6K3VmTHhONDN0WkF1MXJNVHFxazllM2F2TEU1R1B6dEl3NmVj?=
 =?utf-8?B?NS82ZGp4aG5qN1h2WmdBZ1FWNGNJVWRpWmsvbzgyZVV2b1NITm9zeGxsYitG?=
 =?utf-8?B?ZzBZK013bzhjaVBnSk1EdGtrU0RmeGJudi85a2pWbXdDRXpFL0V4cE5NdnNl?=
 =?utf-8?B?SE43R1NyanBqclFaYnpxZHRqS3ZTTnVEd2w2dncrZnd1cXlaSGlHMUtaOHJC?=
 =?utf-8?B?aGhkMytTaTlBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR2P281MB2329.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bHV6eGRlcmRZS1hZUU4zWEszWVhJQzZySUdOc20wYUtmb05SeWVNOXB4Q3lH?=
 =?utf-8?B?T1l1VUx0S01MWVYrcnB1eVo0VytwcklvZ0VLRUxIVE9ZL2J0aTUybTJjelJK?=
 =?utf-8?B?RitJdWdGVnpIZE52eExjdFp4SDdTcFRtL0JWcllwTDd2USs4QUhkcWh0WURl?=
 =?utf-8?B?YVVsNmd6NGE5WFkyWW52OGFIOFAySlVqMHVCS1Y5VkZON0pZeWgyOUh2Z0wr?=
 =?utf-8?B?ZGFoWHFvVkc1QlNRdk9aai80ellNbDJLZHhNeWlaUzRSZHJpRmZLUTFINGd1?=
 =?utf-8?B?amRCZzRTdEZhbUZQZ202bGdrUEsrSVl5ZTFxLzV6ZlJzZjZEVlI1S28rdmNn?=
 =?utf-8?B?T2J1REt4YnVHRWVwUVdCODJscUFVbUhKRkFpMXp3Ym5Jd0czZHVmT2k4cWUy?=
 =?utf-8?B?QVhISndMeFRsMW1velZYLzkraGpsRlFwWnRsaG1jSUQzZTdiV0taMEJzekUw?=
 =?utf-8?B?ODVYMUo0THFBdHBGRDRIaWJzRC9HaTFBSnA3SkRzYUdSeVdTZDZyNXZuSjUv?=
 =?utf-8?B?ZjNkOHczMjlRWCtPd3Qyck1vcnpNdTBPUFJhVXM2SFVGYnMzalZnNGd2QjNl?=
 =?utf-8?B?d29TZ2tSa3dPYkdTK1ZnWkw4WlpxckxlemlJempvYjNEL1A5U0NrMmxKTk1D?=
 =?utf-8?B?WUxRcHBIU2RlaE9ENTNKNmh2MCtXelA3RGN0cXpYeFBmeUFjczNDVDdTQzdQ?=
 =?utf-8?B?SUF6bW5uc2REZkk0Ulc5RnBsMy9SNkZQQng5UnR4VHpPcnBrOGpaT2pPOE5h?=
 =?utf-8?B?UzlpMlNBSWZWenF2WEJjZThXdUVaWjUrWHBNNEdjTmNCUTRSamRrQVdJMVhi?=
 =?utf-8?B?R1lIUW5DOHZ1eFlLbTQ4VitoUDV0Rk1JOWJaZmI3RzNnZG1LU3dHdWVkcTcx?=
 =?utf-8?B?TGZaNkVTVDJJVDNPbzAwTmlqczlURHhXaUgyOTR0Q3h5RUlybzBlVlhGL0Jm?=
 =?utf-8?B?d3h5K2VaeFc2Vzh2em5XeUVCVFZoQitwVVpnVE9weUJDMXVQM056LytEb29l?=
 =?utf-8?B?VXZRYXJXWEFFYnBLelhBN3EwSDIyWnZPZE9DcTc3QzF2bHRTeTI2TWxYMVRC?=
 =?utf-8?B?d283OWl6TnMrZ1NjWS9MQTdPWlh6ZEtzRm1kdzFrci9RWW9ValhQOGlqMlEr?=
 =?utf-8?B?S0g2eEZoMXpXTUgyemc0RHkvM25PYnBqbDRoNndkUWlucytnb0tNQ0VKME1Y?=
 =?utf-8?B?aE9xN21CY1lYNXljWkI3LzhBSk1YKzdQL3UzbnlMTE1qYjVqNVpmZEhVOFZW?=
 =?utf-8?B?NmtOeUVMU1JGN3kxVFp3OTRuNm9QNHpNYURSTmpXL0l2Yi9QaTZ6K25WdTh0?=
 =?utf-8?B?OXVGQkNDY1FvemlRU3ZQeUxhTVR6RHE4RlhQa3JqcXIrbWFlMnFzaE1IMEkv?=
 =?utf-8?B?dHoydW5vRjRxVlFNckErczZNWmRzYTF3SkVFQmdNaWYrUDMwdDdlcUx5UHZk?=
 =?utf-8?B?WTh0a2VyMTdtQ3Z3bDc5eWRtTjJoa2VZc3hUV3Z0Z1VQWEh3UHd4M0tqemp5?=
 =?utf-8?B?WTc2WDhnd1ZKdiszSW82WVArWngyQjlhU1M3T1N0b21SYlZINndiNnhaWUE5?=
 =?utf-8?B?Z284ajZncHNEb1BLMjd3NGYwMm44cStHYm96bGluYXhoRGR0cUZ0MndUZVRh?=
 =?utf-8?B?aHJ6Ym5IeVArY01Na1kzSWI5b0h4MStmQ1JLc0lRcmIvYjlZcjhMbjl3SlFw?=
 =?utf-8?B?NzVlRTZlMFFnS1RacnA1NFk5UW0vNW5TcjlaUTlsdE1hQWkvVGtlV0VycDRH?=
 =?utf-8?B?b1lSbTZpNkZMUlp0KytFUVFpZXBKSUNVenEvYk11cHY0TE9tRWtwWUJJNldw?=
 =?utf-8?B?MnQ1NHBXZXhDRjQ1Zmk2Mm0wVk1sZzdEcHdzSnVmWkU4MFJibDZueWpqeFBj?=
 =?utf-8?B?ek1uR0JmWUh0cFJLbzFvNWJER3dXcVVmQ3dzbHhlWEZXVmk2dTFiV042SEda?=
 =?utf-8?B?SFRSWnIvTjRpWDJiS0tic2xaNGw0VFNVellMeFdqc2VTN2d6b0F6Y09hTHh2?=
 =?utf-8?B?OEpSaVFxMFJQaTEwK0xVM2h5a0JqOUFpR1FCNDVHaGUzTUc1cUFEQjc4SW9p?=
 =?utf-8?B?ZDlHZENPdTdqUWxsVzZlUWIyWHdOVVRjM1FjU0gvNEdvUnFtbkQvRGpGY1RC?=
 =?utf-8?B?dUF2bVFKd0Z5WndPNlo2MWpJRm9QK0lFNkR6QmV5ZnZxV0dKRjJncExHcVA5?=
 =?utf-8?Q?GIcY9lTrAvosa7ovBlabJIeDRG1a8tnOUOntQnSQcRnl?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <096581FF66ABD747BF1D981354B23441@DEUP281.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cyberus-technology.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR2P281MB2329.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a18e1f9e-106d-42f3-81dc-08dd6876d64f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2025 12:49:36.7256
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f4e0f4e0-9d68-4bd6-a95b-0cba36dbac2e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IOxw2kmmKFeppO/nU2J52J61wJy0nLqqT17NyCWywX5ZiFMmkccm1XMQP1OmWJXmYQC9usmF/aEZ6p90D1k4zKZ4ZyUmkxJyrl13gD/2GIn/+v1bCpqogwF7nsqxF+fd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR4P281MB3782

SGkgQWwhDQoNCk9uIEZyaSwgMjAyNS0wMy0yMSBhdCAwMjowOCArMDAwMCwgQWwgVmlybyB3cm90
ZToNCj4gT24gVGh1LCBNYXIgMjAsIDIwMjUgYXQgMDg6Mjg6MjNQTSArMDEwMCwgSnVsaWFuIFN0
ZWNrbGluYSB2aWEgQjQgUmVsYXkgd3JvdGU6DQo+ID4gRnJvbTogSnVsaWFuIFN0ZWNrbGluYSA8
anVsaWFuLnN0ZWNrbGluYUBjeWJlcnVzLXRlY2hub2xvZ3kuZGU+DQo+ID4gDQo+ID4gQWRkIGVy
b2ZzIGRldGVjdGlvbiB0byB0aGUgaW5pdHJkIG1vdW50IGNvZGUuIFRoaXMgYWxsb3dzIHN5c3Rl
bXMgdG8NCj4gPiBib290IGZyb20gYW4gZXJvZnMtYmFzZWQgaW5pdHJkIGluIHRoZSBzYW1lIHdh
eSBhcyB0aGV5IGNhbiBib290IGZyb20NCj4gPiBhIHNxdWFzaGZzIGluaXRyZC4NCj4gPiANCj4g
PiBKdXN0IGFzIHNxdWFzaGZzIGluaXRyZHMsIGVyb2ZzIGltYWdlcyBhcyBpbml0cmRzIGFyZSBh
IGdvb2Qgb3B0aW9uDQo+ID4gZm9yIHN5c3RlbXMgdGhhdCBhcmUgbWVtb3J5LWNvbnN0cmFpbmVk
Lg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEp1bGlhbiBTdGVja2xpbmEgPGp1bGlhbi5zdGVj
a2xpbmFAY3liZXJ1cy10ZWNobm9sb2d5LmRlPg0KPiANCj4gPiDCoCNpbmNsdWRlICJkb19tb3Vu
dHMuaCINCj4gPiDCoCNpbmNsdWRlICIuLi9mcy9zcXVhc2hmcy9zcXVhc2hmc19mcy5oIg0KPiA+
ICsjaW5jbHVkZSAiLi4vZnMvZXJvZnMvZXJvZnNfZnMuaCINCj4gDQo+IFRoaXMgaXMgZ2V0dGlu
ZyByZWFsbHkgdW5wbGVhc2FudC4uLg0KPiANCj4gRm9sa3MsIGNvdWxkIHdlIGRvIHNvbWV0aGlu
ZyBzaW1pbGFyIHRvIGluaXRjYWxscyAtIGFkZCBhIHNlY3Rpb24NCj4gKC5pbml0LnRleHQucmRf
ZGV0ZWN0Pykgd2l0aCBhcnJheSBvZiBwb2ludGVycyB0byBfX2luaXQgZnVuY3Rpb25zDQo+IHRo
YXQgd291bGQgYmUgY2FsbGVkIGJ5IHRoYXQgdGhpbmcgaW4gdHVybj/CoCBXaXRoIGZpbGVzeXN0
ZW1zIHRoYXQNCj4gd2FudCB0byBhZGQgdGhhdCBraW5kIG9mIHN0dWZmIGJlaW5nIGFib3V0IHRv
IGRvIHNvbWV0aGluZyBsaWtlDQoNClRoYXQncyBhIGdyZWF0IHN1Z2dlc3Rpb24hIEkgd29uZGVy
IHdoZXRoZXIgaXQncyBwb3NzaWJsZSB0byByZXN0cnVjdHVyZSB0aGUNCmNvZGUgZnVydGhlciwg
c28gaXQgZG9lcyBzb21ldGhpbmcgYWxvbmc6DQoNCjEuIFRyeSB0byBkZXRlY3Qgd2hldGhlciBp
dCdzIGEgKGNvbXByZXNzZWQpIGluaXRyYW1mcyAtPiBpZiBzbywgZXh0cmFjdCBhbmQgYmUNCmRv
bmUuDQoyLiBDb3B5IHRoZSBpbml0cmQgb250byAvZGV2L3JhbSBhbmQganVzdCB0cnkgdG8gbW91
bnQgaXQgKHdpdGhvdXQgdGhlIG1hbnVhbCBmcw0KZGV0ZWN0aW9uKQ0KDQpBcyBmYXIgYXMgSSB1
bmRlcnN0YW5kIGl0LCB0aGUga2VybmVsIHNob3VsZCBiZSBhYmxlIHRvIGZpZ3VyZSBvdXQgaXRz
ZWxmIHdoYXQNCmZpbGVzeXN0ZW0gaXQgaXM/IElmIHNvLCB0aGlzIHJlbW92ZXMgdGhlIG1hbnVh
bCBmcyBkZXRlY3Rpb24gYW5kIGp1c3QgYWxsb3dzDQphbGwgZmlsZXN5c3RlbSBpbWFnZXMgdG8g
YmUgdXNlZCBhcyBpbml0cmQuDQoNCkknbSBhIG5vb2IgaW4gdGhpcyBwYXJ0IG9mIHRoZSBjb2Rl
IGJhc2UsIHNvIGZlZWwgZnJlZSB0byB0ZWxsIG1lIHRoYXQvd2h5IHRoaXMNCmlzIG5vdCBwb3Nz
aWJsZS4gOikNCg0KSnVsaWFuDQoNCg==

