Return-Path: <linux-fsdevel+bounces-20923-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B16C8FAD8D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 10:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE0C11C22AF7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 08:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E140A142651;
	Tue,  4 Jun 2024 08:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mAEcL/sW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA5713C672
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Jun 2024 08:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717489694; cv=fail; b=oX2bQl5fBwL7BX9l5K094ZPw/cQrIvgoWw4fpKQRu6tAb2nbUXSAGk5bW9KhcKhTETNaI+3SU0lzDmOfH5Dq6F4tMtwYD0/DpnbLOwfHjx/fBwBwuVl6D/UkzflwcpvJFZ2KIaWGyu0dKcOo18fttFkjnEzlmIdT5TSxFy+zVpE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717489694; c=relaxed/simple;
	bh=XyWB1yhoIsYKU2l+0CC+vaA33cW8izpUCd5p3k4ya4I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sd1SzL8SmNjbXCPRDhGbOwwho83oD20FsdFkF24sAC3xdRS5KNfZK+zd0ALVYCfzfktxxlqrBnNWFBizCgzlGxE2mydg1jCV1h3u2GkrTOW/OHnZffrcK09zlE8O622qTMTIsk5LYflrfqRl5L+ppLb6I7//yvhddAP1nRM+9kE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mAEcL/sW; arc=fail smtp.client-ip=40.107.93.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fWa6VD82XAUhwXXq4acCP4JAqh/pM2uwDX8SAd0kjWK7Lah8n5kLx8NIAByfKTW+MeOu1aYRX2plMx0Rhr9TUKYfo/1Q20zOUszLFHP2t1tlZxVWWHE4w7tyheiwyfk+b1gDvKgbV4fDlP8CO1NZ506msq0oNwX+vFbHVgt2yd8sivUlUcCntu/kV0x8M5IVHqgi0MQgDzzR+/dqFXLC/kwZln9Ac/8WtFPbfn9oopF3NuxviumiEcuaxlPz9tbuer0Dkucwev+A/wQjO9BkRkLMg6pROKZ3BGgkU3elxSZF29Vm2zKyFEjBQfPmUolFil/RujAGiwjOO9RxVWPWNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XyWB1yhoIsYKU2l+0CC+vaA33cW8izpUCd5p3k4ya4I=;
 b=evo4ro/qYqNyi42iNe9pvJrfU8IGJ+AugRyjSW6oOF9/st74DGZ8TFAuuxw8kSrXKKKny0jGQ+J0q31MElEmck+VfBbxKfRsEsflem3GBESaa4p+xf/YR6vsokpW8uWnHKITFmlTiHiWp5ffQnY4XBjIv9V56HyaABOsBxuB3eHHKBENM4onD6WrcimqWa/yS9AJCIfW2oskHcEZYSYJSrPZaVMzqjBTCUOeWB9A+9kbuEl/m3bIwgrVHWeEdl0SGW2wjpNZbtd35cLUp3k96CYRaDdYZ1HZyMmIBRRfQhXlJmxHKs8FJ8cHqEQB6XyfTofaqTmTwH9ilb1KFRZwXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XyWB1yhoIsYKU2l+0CC+vaA33cW8izpUCd5p3k4ya4I=;
 b=mAEcL/sWxq5TQlzfdmd3VxepKgYT3mL07DYSf1Qol7Fapy/UrMN10dgND0Aqz7Udq5Sr6GC45w3K9xLt53aMHGQrmxGzyAwtl674WuDLEJQESZVxnhmrSEVJq4rch7dE5rCEWbCDh/1JtSpOgl+3BVomys+IrVG5h63GY0k78KQ8jqwVhiLpVlMIUGi+Nd6gcfb0Cfy57c7zYlV0HyeNt4YnEYyKwJEo/Q1ISzyOYpQWzqdIKgXGdpwtD7tG5u7uD9K3v3nEK3xKEvPXsmISB1SSCeebyYsDYNDc3cYe0mdg+OkOgLGVRHYpRT/ELr/m/ZyfFF6EbSUtads1faHiAw==
Received: from SN7PR12MB7833.namprd12.prod.outlook.com (2603:10b6:806:344::15)
 by PH7PR12MB6489.namprd12.prod.outlook.com (2603:10b6:510:1f7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Tue, 4 Jun
 2024 08:28:07 +0000
Received: from SN7PR12MB7833.namprd12.prod.outlook.com
 ([fe80::6f09:43ac:d28:b19]) by SN7PR12MB7833.namprd12.prod.outlook.com
 ([fe80::6f09:43ac:d28:b19%4]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 08:28:07 +0000
From: Peter-Jan Gootzen <pgootzen@nvidia.com>
To: "stefanha@redhat.com" <stefanha@redhat.com>, "miklos@szeredi.hu"
	<miklos@szeredi.hu>
CC: Idan Zach <izach@nvidia.com>, Oren Duer <oren@nvidia.com>, Parav Pandit
	<parav@nvidia.com>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>, Max Gurtovoy <mgurtovoy@nvidia.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Yoray Zack
	<yorayz@nvidia.com>, "mszeredi@redhat.com" <mszeredi@redhat.com>, Eliav
 Bar-Ilan <eliavb@nvidia.com>, "bin.yang@jaguarmicro.com"
	<bin.yang@jaguarmicro.com>, "mst@redhat.com" <mst@redhat.com>,
	"lege.wang@jaguarmicro.com" <lege.wang@jaguarmicro.com>,
	"angus.chen@jaguarmicro.com" <angus.chen@jaguarmicro.com>
Subject: Re: Addressing architectural differences between FUSE driver and fs -
 Re: virtio-fs tests between host(x86) and dpu(arm64)
Thread-Topic: Addressing architectural differences between FUSE driver and fs
 - Re: virtio-fs tests between host(x86) and dpu(arm64)
Thread-Index:
 AdqybnzAiozTvtlkQFaloMBVG2WGpwDHcmEAAADKEAAAAQAmgAAAdzaAAAm2tYAAAoHLAAABHCqAACK6xwAAAOV6AA==
Date: Tue, 4 Jun 2024 08:28:07 +0000
Message-ID: <bc4bb938b875ef8931d42030ae85220c9763154f.camel@nvidia.com>
References:
 <SI2PR06MB53852C83901A0DDE55624063FFF32@SI2PR06MB5385.apcprd06.prod.outlook.com>
	 <b55cb50b3ecf8d6132f8633ce346b6adc159b38c.camel@nvidia.com>
	 <CAJfpegsppbYbbLaECO+K2xpg8v0XZaQKFRZRTj=gJc9p7swdvQ@mail.gmail.com>
	 <bbf427150d16122da9dd2a8ebec0ab1c9a758b56.camel@nvidia.com>
	 <CAJfpegshNFmJ-LVfRQW0YxNyWGyMMOmzLAoH65DLg4JxwBYyAA@mail.gmail.com>
	 <20240603134427.GA1680150@fedora.redhat.com>
	 <CAOssrKfw4MKbGu=dXAdT=R3_2RX6uGUUVS+NEZp0fcfiNwyDWw@mail.gmail.com>
	 <20240603152801.GA1688749@fedora.redhat.com>
	 <CAJfpegsr7hW1ryaZXFbA+njQQyoXgQ_H-wX-13n=YF86Bs7LxA@mail.gmail.com>
In-Reply-To:
 <CAJfpegsr7hW1ryaZXFbA+njQQyoXgQ_H-wX-13n=YF86Bs7LxA@mail.gmail.com>
Reply-To: Peter-Jan Gootzen <pgootzen@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB7833:EE_|PH7PR12MB6489:EE_
x-ms-office365-filtering-correlation-id: 48772f59-8cf5-405a-4a80-08dc847042ee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?L0dIaHRPaHhnQXY4bjlnQXNyOGtVUDY3MFF3REQ5aHZNMHhCajMyeVVSeVNr?=
 =?utf-8?B?ZHlOek95N0M5c3dHQ2hTN1hocmFTV0RCYnpQRndneURST0FNZm5OTDdhaG5X?=
 =?utf-8?B?dVloNFV0TmhBcDZtaVRkcHozVWZHN1lXYXR0YU1EN290WldIdHdGU2s3WFhk?=
 =?utf-8?B?WVA3d3VTWTQxRVltQk55NStUeksrWGdiZFlGNGxsbW1Jb1g1RkdhdnR5RW5I?=
 =?utf-8?B?Y1h0MDh0dWpJcXdCOGx0SHFVQk9ORitLY3I1M3dYMk54VVVhQS95VGMwZFJX?=
 =?utf-8?B?eXE5bk8zT0pZVkRucjc2Y29jZE94YXJobHkzMFFpZWRRT01UT2dnVkVqd0FM?=
 =?utf-8?B?cmxKWUdxTStQbmkyWjJLdE5PY3hLUGtRNW1laXRPelFzb2gvNlo4QTJGRkNj?=
 =?utf-8?B?OGxpZDJTY1F1ckdlOFZpeDZvNHFMODFvdHJ2dDVlTnlmTkllZnlrSnJZMDY0?=
 =?utf-8?B?SUVoNldHSUdGMnBEWlNhVVNTaEZoNitGWHJnWWNML1dOL0RscWVZOFBBMDc3?=
 =?utf-8?B?YUtpRzJ3UllnRSt0dnkyMkpMQ2VwWDl5d0Z6M3ZLZ0l6eVFnQlJNdnJ4R1hR?=
 =?utf-8?B?aENnWUFpTEVDMjkvVHBQYlRuMHBWaHdSbkpKTCtBSTZ3clFJbUdkZTVWbmVp?=
 =?utf-8?B?cWZjSG50NU4yTFFGZHhvRW9KZEMzdGliMFEwTVhTUjRQZHN1cUxJRDkvYXJN?=
 =?utf-8?B?U3dVQURDUnB1ODU1dWh0VlhZRG4vTnlqbGRxcGJhQVc1MWZwSEJUNmN3WUMz?=
 =?utf-8?B?MGJqQWVjV3lZVjR6RE0xZ1gxa2xtbXlENm5pVTdkbENHd1NscGFYYU05ckV1?=
 =?utf-8?B?MW1sWFBScFE2bjdQdGIrOFo3bGlpWUlnMmJtVUVnRm12K2o5Q2s4WGQya0pW?=
 =?utf-8?B?Vlo0dnJXZ2hVc1k4RzZURjFqKzBITERONUdNaURoU1ZNcHFQUTJuL1pMNWt2?=
 =?utf-8?B?ZE93dEo0MWpieHRLR0xEVFIwYUhXekJPM3dxMzZaRUpQM3NRTnNmV3FPc0lo?=
 =?utf-8?B?MXJrVGJxcS91ZXdCU2I5L0JmNXhvY0g1Uk9hNXNHT0d4bEt4akZLUU5EMGJV?=
 =?utf-8?B?V1JsL1pBWjhPNGtPQ08vOGxCUjZ5SzRyWGxkUDNwTFpydzJ2aFJvRmt2K1FK?=
 =?utf-8?B?cjAxek91YWNNMlNpSGtRb1RXSEdkSzg3QkV5OSsyMjd3dUZLSEFvT0NDQTh0?=
 =?utf-8?B?VmkzcFg5cUdhNVRKWDJwMDlwUm0wUWQwSGhWdFhNZlhIVk4wMjVvMW5qbWFw?=
 =?utf-8?B?REVCWUhMcXBMTXlkbUJkNk55YUJWQzhrcU5DNjBnYVoxUm1TT2xBTHh0ZW0v?=
 =?utf-8?B?aGNSM2pObWw5M09nU1dTb0VtRyt0OTNsT1NBZ21UdGcrWHB5L0lzTjJkcElK?=
 =?utf-8?B?SjVnRWs2N2tjVm4zQmdoeE5VMUdkMnhCekJ3cmxYdHV6MGltVGdiSUpQTFY0?=
 =?utf-8?B?eGtYQndNWDY4azZocFN5ZUxBSmJCSnNPWW1ZOHlFbFBnc1UzSUVhMVlpallR?=
 =?utf-8?B?QVZDQ2RxWXRkODN6OVF1eEZFNzZEN3dmWGxjRVBoVDNZTy84RUY4VFRIRHBN?=
 =?utf-8?B?QkVHQ21Bd0JFcE5YMitydUxmR1JyWG9TUThMaFp4WVBBakZWRlEwdWNDcDMv?=
 =?utf-8?B?SWlMdVFHbkxyUzdYTWVRbUp0RGt0VTVMd2pzVE0reTlXWkFQekVja1h4dHdw?=
 =?utf-8?B?WXgvOTgyQmJCUFdqSGJESnBNbkRtWk5QTitIYmdYMEZGNWJLaG1jaUZabk10?=
 =?utf-8?B?ZGlsMit3emNteXlTRDdLSWFKWGlKTjE0NjN2R1IxZHV5Ky9qMUJveVlwNVlr?=
 =?utf-8?B?QzdmQnJnOW16UExxeldqdz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB7833.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Y1ZvV2tabjVjQ2NNbmZRbFZhNE1nSjQvWlVqQVMwV2Z5ZWZPbWxCcHJucFph?=
 =?utf-8?B?a2pNYVhzOE00TURjMVJTNjlwMXZCUEhSbW1MUWtpRXNZZDVZc2lpS0pUelNZ?=
 =?utf-8?B?akFKUzZVcUNqNmp2QS9iWG9jSS9NTlFnOFlzUVFMcXU1eDhaQW9wd2tmZkow?=
 =?utf-8?B?NHdzV3grUTF5OE4yWFdmSzVENi9JWkdKdUFmQW84V1E4MVJSQWFDaEVoRE9o?=
 =?utf-8?B?ZGJSRGVTYmxJcG16aU9aaTJtaUI2elZ1ZGxqbGNXbENVa3Q2R0wyVkkvclMx?=
 =?utf-8?B?UDVSU0JIb0tjOW1TcW1RaDVKQm1LTCtUU3UxRGo1MkdtQXJja2Z2aXBDVDBF?=
 =?utf-8?B?bDJVc01kT3BEcGJWM25FUUMyU1N3WEVIN1BoOTlIQU1MSnFWZVNVQWlOdk9w?=
 =?utf-8?B?c3pIWUp2VEVVdzA4Qjl3Ynh2TFJ5eW5ycG5ORTFMYkNrbVNrQUFEbk9kKzVI?=
 =?utf-8?B?WWc2QmtuTGNsL2RqNnlvR1FwU2QrSmhrS2FVVndNOVdvTHc4bHlCYVFzcGsz?=
 =?utf-8?B?NDFvcklSUFMrbmp5TktQT1ZLZVducUtDQmVZdEZRM2FsbGhUYXVjMHMxZVk2?=
 =?utf-8?B?RFNpYjgwTUs1ajdqaFZ1SmE3QU11Z1NML0JzU2FyTzArOFVJamdCMmFRUXRU?=
 =?utf-8?B?ZTI2MFRxMHpHd0ZPalVXUFhLY1VLQkZsK0VTaVc5VVc2aHJNQzFQSGVJRVNX?=
 =?utf-8?B?enZ6eDE2elhRbWpMNDROWDBZMkcrcit0eFJSRFhDYzJJenRiMEg2WU5kcS9h?=
 =?utf-8?B?bVk2bmgxaDRGdkJrQUVHZlFIcnphQWV5a3FvbmZpWG1SaVVSbU5jaWFlUytJ?=
 =?utf-8?B?eVFHK3cvS294SldWTmpzbnJyYmwyNnhCRGwzNVFDMGNDd29wQ1Q3TEtQbmN0?=
 =?utf-8?B?WmlqZHdnZ09NdE5mYkQ4Z3pJQk01ZjVrT0xkZDhISE1MWTlVcURyMzhHaXd2?=
 =?utf-8?B?d3lXQURDK28vemJmMlBiZzRVZm5EQ2hqTGVWeVpCSThiSlM5YzY0R0QxN0xk?=
 =?utf-8?B?eVRWRlFFemFoTlRieGhGTUgvTUtkdjZvY3Q5OEo0SjNIcmlzUXNkMTFzc2Zp?=
 =?utf-8?B?eHJINFZkYlFVbVlVblF1SWJuQVhEWFZ4aW5Qczd5VUpUZmFPMDVudEhrQ1JT?=
 =?utf-8?B?WS9sU3c1S2htVVpvVFZaOXY3OVdLOVFKNjdsMmYrQkVFUi9CYXZaSThyQi9l?=
 =?utf-8?B?b3lUUGFqQ1pSVjhDNXRDWHc5bmt2RU54RzJyQm5PLzI3RC9QSFJWbGdDQ1N2?=
 =?utf-8?B?QzZ4c1htRkRXS1VoV1JwMzN1ZXpKNUkzckhWV2MvYkVDR252NkhFNjdDNFZP?=
 =?utf-8?B?anVQQ1VieVVFWVE3K2RuQTVmeEJRLzQzbUFXRXRyZHY0SG5sUkF6V3VvRWFO?=
 =?utf-8?B?ZzRlaVNhRHplQ1VKZGQrbVkzM3BEZWFhY3hVaU9PZGp3NzlYRFBGUVRadEY0?=
 =?utf-8?B?NjBZRy9jNEU0enhNckgxbmNoTVd4NVlpbzgxeGVLZXY1NFR2TzJoaGtJNU00?=
 =?utf-8?B?QncxZzRtSzFWOVdTSlRhWEhWV3hadEdBMTc5Z1RrSWdSWE5idWo3bHNnVlJ6?=
 =?utf-8?B?UkZ3OVRsanVROCtXekRiNmUvT2tuK3ltSFRTVjVSdzhMZ2dsdEZoVG43MFNk?=
 =?utf-8?B?ZnoyY3UwSjMvOFJwMFpyTXRON2E0N203Wk53UkEwZi9JMzl2MjU4UEFWSUln?=
 =?utf-8?B?R0krVWlFakxDZFd1MnkxMDBmTEZtb2NYeUlzMEoxQnZEclpxNzdyM0tldzJa?=
 =?utf-8?B?WWNrUkpjdHJWS2xTYUtHNitNWWZsSDhqdmR6U201WXI4Q3J5NG9mcmRtUzl4?=
 =?utf-8?B?bVZkbEhMOTVUVkpMRHFscHBzSk5yYWpqNWRRTlZ4d2pJZWY2UTkzWTdDb3NU?=
 =?utf-8?B?Wks1TmF6d3czRTZiSnpKcUNvZ2lURSt1dy9INXl6elBPb0tpckNjOUE0dVNY?=
 =?utf-8?B?eEtHMERWNi9KRXlhcFNPc0FFNzN5Y3BibUZteW00MEZsK0dEcjdnMFZwZnhL?=
 =?utf-8?B?RkxUNXpQMUszSVhUYmZxWjlweFNZaVpNcHdSYVRPWjBBdlZybFJlT3NzZk16?=
 =?utf-8?B?OUlQZzhoSXVWZEtlRUd2UjQyaStmdFZKWFJaazg2Rk1melBhczFwM0FBUFE0?=
 =?utf-8?Q?tFSp9vEK4xEFIPJQ/S5687klj?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2A709F5EB5B9894D84694B87DCC703C4@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7833.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48772f59-8cf5-405a-4a80-08dc847042ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2024 08:28:07.3775
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ykm5YZk6CwsdeKXVhiiCZeOmbN86+AuHxUgp3QeG3j5g6Dp4gE/9Uqw9S9OmNXJW5PbIWd3mj0H8bMs53nxpOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6489

T24gVHVlLCAyMDI0LTA2LTA0IGF0IDEwOjAyICswMjAwLCBNaWtsb3MgU3plcmVkaSB3cm90ZToN
Cj4gRXh0ZXJuYWwgZW1haWw6IFVzZSBjYXV0aW9uIG9wZW5pbmcgbGlua3Mgb3IgYXR0YWNobWVu
dHMNCj4gDQo+IA0KPiBPbiBNb24sIDMgSnVuIDIwMjQgYXQgMTc6MjgsIFN0ZWZhbiBIYWpub2N6
aSA8c3RlZmFuaGFAcmVkaGF0LmNvbT4NCj4gd3JvdGU6DQo+ID4gDQo+ID4gT24gTW9uLCBKdW4g
MDMsIDIwMjQgYXQgMDQ6NTY6MTRQTSArMDIwMCwgTWlrbG9zIFN6ZXJlZGkgd3JvdGU6DQo+ID4g
PiBPbiBNb24sIEp1biAzLCAyMDI0IGF0IDM6NDTigK9QTSBTdGVmYW4gSGFqbm9jemkNCj4gPiA+
IDxzdGVmYW5oYUByZWRoYXQuY29tPiB3cm90ZToNCj4gPiA+ID4gDQo+ID4gPiA+IE9uIE1vbiwg
SnVuIDAzLCAyMDI0IGF0IDExOjA2OjE5QU0gKzAyMDAsIE1pa2xvcyBTemVyZWRpIHdyb3RlOg0K
PiA+ID4gPiA+IE9uIE1vbiwgMyBKdW4gMjAyNCBhdCAxMDo1MywgUGV0ZXItSmFuIEdvb3R6ZW4N
Cj4gPiA+ID4gPiA8cGdvb3R6ZW5AbnZpZGlhLmNvbT4gd3JvdGU6DQo+ID4gPiA+ID4gDQo+ID4g
PiA+ID4gPiBXZSBhbHNvIGNvbnNpZGVyZWQgdGhpcyBpZGVhLCBpdCB3b3VsZCBraW5kIG9mIGJl
IGxpa2UNCj4gPiA+ID4gPiA+IGxvY2tpbmcgRlVTRSBpbnRvDQo+ID4gPiA+ID4gPiBiZWluZyB4
ODYuIEhvd2V2ZXIgSSB0aGluayB0aGlzIGlzIG5vdCBiYWNrd2FyZHMgY29tcGF0aWJsZS4NCj4g
PiA+ID4gPiA+IEN1cnJlbnRseQ0KPiA+ID4gPiA+ID4gYW4gQVJNNjQgY2xpZW50IGFuZCBBUk02
NCBzZXJ2ZXIgd29yayBqdXN0IGZpbmUuIEJ1dCBtYWtpbmcNCj4gPiA+ID4gPiA+IHN1Y2ggYQ0K
PiA+ID4gPiA+ID4gY2hhbmdlIHdvdWxkIGJyZWFrIGlmIHRoZSBjbGllbnQgaGFzIHRoZSBuZXcg
ZHJpdmVyIHZlcnNpb24NCj4gPiA+ID4gPiA+IGFuZCB0aGUNCj4gPiA+ID4gPiA+IHNlcnZlciBp
cyBub3QgdXBkYXRlZCB0byBrbm93IHRoYXQgaXQgc2hvdWxkIGludGVycHJldCB4ODYNCj4gPiA+
ID4gPiA+IHNwZWNpZmljYWxseS4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBUaGlzIHdvdWxkIG5l
ZWQgdG8gYmUgbmVnb3RpYXRlZCwgb2YgY291cnNlLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IEJ1
dCBpdCdzIGNlcnRhaW5seSBzaW1wbGVyIHRvIGp1c3QgaW5kaWNhdGUgdGhlIGNsaWVudCBhcmNo
IGluDQo+ID4gPiA+ID4gdGhlDQo+ID4gPiA+ID4gSU5JVCByZXF1ZXN0LsKgwqAgTGV0J3MgZ28g
d2l0aCB0aGF0IGZvciBub3cuDQo+ID4gPiA+IA0KPiA+ID4gPiBJbiB0aGUgbG9uZyB0ZXJtIGl0
IHdvdWxkIGJlIGNsZWFuZXN0IHRvIGNob29zZSBhIHNpbmdsZQ0KPiA+ID4gPiBjYW5vbmljYWwN
Cj4gPiA+ID4gZm9ybWF0IGluc3RlYWQgb2YgcmVxdWlyaW5nIGRyaXZlcnMgYW5kIGRldmljZXMg
dG8gaW1wbGVtZW50DQo+ID4gPiA+IG1hbnkNCj4gPiA+ID4gYXJjaC1zcGVjaWZpYyBmb3JtYXRz
LiBJIGxpa2VkIHRoZSBzaW5nbGUgY2Fub25pY2FsIGZvcm1hdCBpZGVhDQo+ID4gPiA+IHlvdQ0K
PiA+ID4gPiBzdWdnZXN0ZWQuDQo+ID4gPiA+IA0KPiA+ID4gPiBNeSBvbmx5IGNvbmNlcm4gaXMg
d2hldGhlciB0aGVyZSBhcmUgbW9yZSBjb21tYW5kcy9maWVsZHMgaW4NCj4gPiA+ID4gRlVTRSB0
aGF0DQo+ID4gPiA+IG9wZXJhdGUgaW4gYW4gYXJjaC1zcGVjaWZpYyB3YXkgKGUuZy4gaW9jdGwp
PyBJZiB0aGVyZSByZWFsbHkNCj4gPiA+ID4gYXJlIHBhcnRzDQo+ID4gPiA+IHRoYXQgbmVlZCB0
byBiZSBhcmNoLXNwZWNpZmljLCB0aGVuIGl0IG1pZ2h0IGJlIG5lY2Vzc2FyeSB0bw0KPiA+ID4g
PiBuZWdvdGlhdGUNCj4gPiA+ID4gYW4gYXJjaGl0ZWN0dXJlIGFmdGVyIGFsbC4NCj4gPiA+IA0K
PiA+ID4gSG93IGFib3V0IHNvbWV0aGluZyBsaWtlIHRoaXM6DQo+ID4gPiANCj4gPiA+IMKgLSBi
eSBkZWZhdWx0IGZhbGwgYmFjayB0byBubyB0cmFuc2xhdGlvbiBmb3IgYmFja3dhcmQNCj4gPiA+
IGNvbXBhdGliaWxpdHkNCj4gPiA+IMKgLSBzZXJ2ZXIgbWF5IHJlcXVlc3QgbWF0Y2hpbmcgYnkg
c2VuZGluZyBpdHMgb3duIGFyY2ggaWRlbnRpZmllcg0KPiA+ID4gaW4NCj4gPiA+IGZ1c2VfaW5p
dF9pbg0KPiA+ID4gwqAtIGNsaWVudCBzZW5kcyBiYWNrIGl0cyBhcmNoIGlkZW50aWZpZXIgaW4g
ZnVzZV9pbml0X291dA0KPiA+ID4gwqAtIGNsaWVudCBhbHNvIHNlbmRzIGJhY2sgYSBmbGFnIGlu
ZGljYXRpbmcgd2hldGhlciBpdCB3aWxsDQo+ID4gPiB0cmFuc2Zvcm0NCj4gPiA+IHRvIGNhbm9u
aWNhbCBvciBub3QNCj4gPiA+IA0KPiA+ID4gVGhpcyBtZWFucyB0aGUgY2xpZW50IGRvZXMgbm90
IGhhdmUgdG8gaW1wbGVtZW50IHRyYW5zbGF0aW9uIGZvcg0KPiA+ID4gZXZlcnkNCj4gPiA+IGFy
Y2hpdGVjdHVyZSwgb25seSBvbmVzIHdoaWNoIGFyZSBmcmVxdWVudGx5IHVzZWQgYXMgZ3Vlc3Qu
wqAgVGhlDQo+ID4gPiBzZXJ2ZXIgbWF5IG9wdCB0byBpbXBsZW1lbnQgaXRzIG93biB0cmFuc2xh
dGlvbiBpZiBpdCdzIGxhY2tpbmcgaW4NCj4gPiA+IHRoZQ0KPiA+ID4gY2xpZW50LCBvciBpdCBj
YW4ganVzdCBmYWlsLg0KPiA+IA0KPiA+IEZyb20gdGhlIGNsaWVudCBwZXJzcGVjdGl2ZToNCj4g
PiANCj4gPiAxLiBEbyBub3QgbmVnb3RpYXRlIGFyY2ggaW4gZnVzZV9pbml0X291dCAtIGhvcGVm
dWxseSBjbGllbnQgYW5kDQo+ID4gc2VydmVyDQo+ID4gwqDCoCBrbm93IHdoYXQgdGhleSBhcmUg
ZG9pbmcgOikuIFRoaXMgaXMgdGhlIGN1cnJlbnQgYmVoYXZpb3IuDQo+ID4gMi4gUmVwbHkgdG8g
ZnVzZV9pbml0X2luIHdpdGggc2VydmVyJ3MgYXJjaCBpbiBmdXNlX2luaXRfb3V0IC0NCj4gPiBj
bGllbnQNCj4gPiDCoMKgIHRyYW5zbGF0ZXMgYWNjb3JkaW5nIHRvIHNlcnZlcidzIGFyY2guDQo+
ID4gMy4gUmVwbHkgdG8gZnVzZV9pbml0X2luIHdpdGggY2Fub25pY2FsIGZsYWcgc2V0IGluIGZ1
c2VfaW5pdF9vdXQgLQ0KPiA+IMKgwqAgY2xpZW50IGFuZCBzZXJ2ZXIgdXNlIGNhbm9uaWNhbCBm
b3JtYXQuDQo+ID4gDQo+ID4gRnJvbSB0aGUgc2VydmVyIHBlcnNwZWN0aXZlOg0KPiA+IA0KPiA+
IDEuIENsaWVudCBkb2VzIG5vdCBuZWdvdGlhdGUgYXJjaCAtIHRoZSBjdXJyZW50IGJlaGF2aW9y
IChnb29kDQo+ID4gbHVjayEpLg0KPiA+IDIuIEFyY2ggcmVjZWl2ZWQgaW4gZnVzZV9pbml0X291
dCBmcm9tIGNsaWVudCAtIG11c3QgYmUgZXF1YWwgdG8NCj4gPiDCoMKgIHNlcnZlcidzIGFyY2gg
c2luY2UgdGhlcmUgaXMgbm8gd2F5IGZvciB0aGUgc2VydmVyIHRvIHJlamVjdCB0aGUNCj4gPiDC
oMKgIGFyY2guDQo+ID4gMy4gQ2Fub25pY2FsIGZsYWcgcmVjZWl2ZWQgaW4gZnVzZV9pbml0X291
dCBmcm9tIGNsaWVudCAtIGNsaWVudCBhbmQNCj4gPiDCoMKgIHNlcnZlciB1c2UgY2Fub25pY2Fs
IGZvcm1hdC4NCj4gDQo+IFllYWgsIHNvbWV0aGluZyBsaWtlIHRoYXQgKEkgZ290IHRoZSBkaXJl
Y3Rpb24gb2YgdGhlIG5lZ290aWF0aW9uDQo+IHdyb25nKS4NCj4gDQo+IFNlZSBiZWxvdyBwYXRj
aC4NCj4gDQo+IEknbSB0aGlua2luZyB0aGF0IGZ1c2VfaW5pdF9vdXQgbmVlZCBub3QgZXZlbiBo
YXZlIHRoZSBzZXJ2ZXIgYXJjaCwNCj4gc2luY2UgdGhlIGNsaWVudCB3aWxsIG9ubHkgYmUgdHJh
bnNsYXRpbmcgdG8gdGhlIGNhbm9uaWNhbCBhcmNoLsKgIFRoZQ0KPiBjbGllbnQgc2VuZHMgaXRz
IG93biBhcmNoIGluIGZ1c2VfaW5pdF9pbi5hcmNoX2lkIGFuZCBhZHZlcnRpc2VzIHdpdGgNCj4g
RlVTRV9DQU5PTl9BUkNIIHNldCBpbiBmdXNlX2luaXRfaW4uZmxhZ3Mgd2hldGhlciBpdCBzdXBw
b3J0cw0KPiB0cmFuc2Zvcm1pbmcgdG8gY2Fub25pY2FsLsKgIElmIHRoZSBzZXJ2ZXIgd2FudHMg
Y2Fub25pY2FsaXphdGlvbiwgdGhlbg0KPiBpdCByZXNwb25kcyB3aXRoIEZVU0VfQ0FOT05fQVJD
SCBzZXQgaW4gZnVzZV9pbml0X291dC5mbGFncy4NCldpbGwgdGhlIEZVU0VfQ0FOT05fQVJDSCB0
aGVuIGJlIGRlZmF1bHQvcmVxdWlyZWQgaW4gaW5pdF9pbiBmcm9tIHRoZQ0KbmV3IG1pbm9yIG9u
d2FyZHM/DQpJZiBzbywgYSBzZXJ2ZXIvZGV2aWNlIHRoYXQgc3VwcG9ydHMgdGhlIG5ldyBtaW5v
ciwgd291bGQgb25seSBuZWVkIHRvDQpzdXBwb3J0IHRoZSBjYW5vbmljYWwgZm9ybWF0Lg0KVGhl
IGZ1c2VfaW5pdF9pbi5hcmNoX2lkIGlzIHRoZW4gb25seSByZWFsbHkgdXNlZCBmb3IgdGhlIHNl
cnZlci9kZXZpY2UNCnRvIGtub3cgdGhlIGZvcm1hdCBvZiBJT0NUTCAobGlrZSBJZGFuIGJyb3Vn
aHQgdXApLg0KDQo+IA0KPiBUaGlzIHdvcmtzIGZvciBsZWdhY3kgc2VydmVyIHRoYXQgZG9lc24n
dCBpbnRlcnByZXQgdGhlIG5ldyBmbGFnIGFuZA0KPiBmaWVsZCwgYW5kIGFsc28gZm9yIGxlZ2Fj
eSBjbGllbnQgdGhhdCBkb2Vzbid0IHNldCBlaXRoZXIgKHplcm8NCj4gYXJjaF9pZCBtZWFuczog
dW5rbm93biBhcmNoaXRlY3R1cmUpLg0KPiANCj4gYXJjaF9pZCBjb3VsZCBiZSBhIGhhc2ggb2Yg
dGhlIGFyY2ggbmFtZSwgc28gdGhhdCB0aGUgZnVzZSBoZWFkZXIgZmlsZQ0KPiBkb2Vzbid0IG5l
ZWQgdG8gYmUgdXBkYXRlZCB3aGVuZXZlciBhIG5ldyBhcmNoaXRlY3R1cmUgaXMgYWRkZWQuDQpX
aG8gZGVmaW5lcyB3aGF0IHRoZSBhcmNoIG5hbWVzIGFyZT8gV2hhdCBhYm91dCBjYXBpdGFsaXph
dGlvbj8NClRoZSBsYXN0IHRpbWUgYW4gYXJjaCB3aXRoIGl0cyBvd24gY29uc3RhbnRzIHdhcyBh
ZGRlZCB3YXMgMTIgeWVhcnMgYWdvDQp3aXRoIEFSTTY0LiBTbyB0aGUgaGVhZGVyIHdvdWxkbid0
IGNoYW5nZSBvZnRlbi4gT3IgaXMgdGhpcyBzb21ldGhpbmcNCnRoYXQgdGhlIGtlcm5lbCBhdm9p
ZHMgaW4gZ2VuZXJhbD8NCj4gDQo+IFRoYW5rcywNCj4gTWlrbG9zDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvaW5jbHVkZS91YXBpL2xpbnV4L2Z1c2UuaCBiL2luY2x1ZGUvdWFwaS9saW51eC9mdXNlLmgN
Cj4gaW5kZXggZDA4Yjk5ZDYwZjZmLi5jNjNkOGJhYjJkMzcgMTAwNjQ0DQo+IC0tLSBhL2luY2x1
ZGUvdWFwaS9saW51eC9mdXNlLmgNCj4gKysrIGIvaW5jbHVkZS91YXBpL2xpbnV4L2Z1c2UuaA0K
PiBAQCAtNDIxLDYgKzQyMSw3IEBAIHN0cnVjdCBmdXNlX2ZpbGVfbG9jayB7DQo+IMKgICogRlVT
RV9OT19FWFBPUlRfU1VQUE9SVDogZXhwbGljaXRseSBkaXNhYmxlIGV4cG9ydCBzdXBwb3J0DQo+
IMKgICogRlVTRV9IQVNfUkVTRU5EOiBrZXJuZWwgc3VwcG9ydHMgcmVzZW5kaW5nIHBlbmRpbmcg
cmVxdWVzdHMsIGFuZA0KPiB0aGUgaGlnaCBiaXQNCj4gwqAgKiBGVVNFX05PX0VYUE9SVF9TVVBQ
T1JUOiBleHBsaWNpdGx5IGRpc2FibGUgZXhwb3J0IHN1cHBvcnQNCj4gwqAgKiBGVVNFX0hBU19S
RVNFTkQ6IGtlcm5lbCBzdXBwb3J0cyByZXNlbmRpbmcgcGVuZGluZyByZXF1ZXN0cywgYW5kDQo+
IHRoZSBoaWdoIGJpdA0KPiDCoCAqwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgb2Yg
dGhlIHJlcXVlc3QgSUQgaW5kaWNhdGVzIHJlc2VuZCByZXF1ZXN0cw0KPiArICogRlVTRV9DQU5P
Tl9BUkNIOiB0cmFuc2xhdGUgYXJjaCBzcGVjaWZpYyBjb25zdGFudHMgdG8gY2Fub25pY2FsDQo+
IMKgICovDQo+IMKgI2RlZmluZSBGVVNFX0FTWU5DX1JFQUTCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgKDEgPDwgMCkNCj4gwqAjZGVmaW5lIEZVU0VfUE9TSVhfTE9DS1PCoMKgwqDCoMKg
wqAgKDEgPDwgMSkNCj4gQEAgLTQ2Myw2ICs0NjQsNyBAQCBzdHJ1Y3QgZnVzZV9maWxlX2xvY2sg
ew0KPiDCoCNkZWZpbmUgRlVTRV9QQVNTVEhST1VHSMKgwqDCoMKgwqDCoCAoMVVMTCA8PCAzNykN
Cj4gwqAjZGVmaW5lIEZVU0VfTk9fRVhQT1JUX1NVUFBPUlQgKDFVTEwgPDwgMzgpDQo+IMKgI2Rl
ZmluZSBGVVNFX0hBU19SRVNFTkTCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKDFVTEwg
PDwgMzkpDQo+ICsjZGVmaW5lIEZVU0VfQ0FOT05fQVJDSMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCAoMVVMTCA8PCA0MCkNCj4gDQo+IMKgLyogT2Jzb2xldGUgYWxpYXMgZm9yIEZVU0Vf
RElSRUNUX0lPX0FMTE9XX01NQVAgKi8NCj4gwqAjZGVmaW5lIEZVU0VfRElSRUNUX0lPX1JFTEFY
wqDCoCBGVVNFX0RJUkVDVF9JT19BTExPV19NTUFQDQo+IEBAIC04NzQsNyArODc2LDggQEAgc3Ry
dWN0IGZ1c2VfaW5pdF9pbiB7DQo+IMKgwqDCoMKgwqDCoMKgIHVpbnQzMl90wqDCoMKgwqDCoMKg
wqAgbWF4X3JlYWRhaGVhZDsNCj4gwqDCoMKgwqDCoMKgwqAgdWludDMyX3TCoMKgwqDCoMKgwqDC
oCBmbGFnczsNCj4gwqDCoMKgwqDCoMKgwqAgdWludDMyX3TCoMKgwqDCoMKgwqDCoCBmbGFnczI7
DQo+IC3CoMKgwqDCoMKgwqAgdWludDMyX3TCoMKgwqDCoMKgwqDCoCB1bnVzZWRbMTFdOw0KV2hh
dCBpcyB0aGUgcmVhc29uIGZvciBzcGxpdHRpbmcgdGhlIHVudXNlZCBieXRlcyBoZXJlPw0KPiAr
wqDCoMKgwqDCoMKgIHVpbnQzMl90wqDCoMKgwqDCoMKgwqAgYXJjaF9pZDsNCj4gK8KgwqDCoMKg
wqDCoCB1aW50MzJfdMKgwqDCoMKgwqDCoMKgIHVudXNlZFsxMF07DQo+IMKgfTsNCj4gDQo+IMKg
I2RlZmluZSBGVVNFX0NPTVBBVF9JTklUX09VVF9TSVpFIDgNCg0KSWYgYXJjaF9pZCBpcyBvbmx5
IHVzZWQgZm9yIElPQ1RMIGFuZCB0aGUgcmVzdCBvZiB0aGUgdHJhbnNsYXRpb24gaXMNCnRocm91
Z2ggdGhlIGNhbm9uaWNhbCBmb3JtYXQgd2l0aCBGVVNFX0NBTk9OX0FSQ0gsIHRoZW4gSSBsaWtl
IHRoaXMNCmFwcHJvYWNoLg0KDQpJIHRoaW5rIHRoYXQgaWYgd2UgaW50cm9kdWNlIHRoZSBjYW5v
bmljYWwgZm9ybWF0LCBhbmQgYWxzbyByZXF1aXJlIHRoZQ0Kc2VydmVyIG9yIGNsaWVudCB0byBi
ZSByZWFkeSB0byBkbyB0cmFuc2xhdGlvbiBmcm9tIGFuZCB0b3dhcmRzIHRoZQ0KaGFuZHNoYWtl
ZCBmb3JtYXQgc3BlY2lmaWVkIGluIGFyY2hfaWQuIFRoZW4gaXQgd2lsbCBiZSBvdmVybHkNCmNv
bXBsaWNhdGVkIG9uIGJvdGggc2lkZXMgd2l0aG91dCBhZGRpbmcgYW55IHZhbHVlLg0KDQotIFBl
dGVyLUphbg0KDQo=

