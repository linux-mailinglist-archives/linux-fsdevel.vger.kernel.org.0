Return-Path: <linux-fsdevel+bounces-21031-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B01688FC93A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 12:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A122283C19
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 10:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86480191476;
	Wed,  5 Jun 2024 10:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XavmTOXH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD2A14BF85
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Jun 2024 10:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717584049; cv=fail; b=ZDDF8zDb0dvB57moeK+PiHF09XG3wwJ91ZVqQUXpg5jTJV6qplh47G8yIU/Yjo8gp/66g+EGyhWSwLF8E1CTZNncTsmWjKGZa7KMutn4EdgPszK7OiyoVywOQ1Ozc+2XszD8uCSt+sDr3v768vhkF1uIy473thxKa8LWJwwW0yI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717584049; c=relaxed/simple;
	bh=PMblev5enIVosOTGW+FhUnYjqBE+GQFUhy6SZu6StpI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=o+I8Id6M6pGl3ZDChJFu+Eztm45ibSdqEp6LzXZNHwkUwCrvUmGckne4VEafRGCRIpvWZpaJHe9Ts8eOPo+CdfM0C6C0iIeTRPAiLSCUNMKP4qjEVqitbSxJBUPNqao2c0J5PM/e7m5OV2Zte9MOcw5GDhHD1kusKkUQsOhHfrc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XavmTOXH; arc=fail smtp.client-ip=40.107.220.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gMSQC7p88yAvPvNEHazQcaQN4GTrRaLx7xAhn+Yc9RNmHAEWCtSSgNDre8SZv2zM3Nfs/Zl9RODM2qhcI4YehwTRYyaU3dYbu9DM2ynNHMqxiyYD/Lk5vBteTZH6BOMX6F+9MOblqdXoDoY7/Hkyp+14upcnr4sr/bA0WghdCF7MkMPZ5pJPvf3xddeZjBwCipHdkkL0+OoLUAcHM9Brv+cCLf73eYp4CW+5x1KULPzxF6vVmxtIJWsMUi+olTboAtLfdut2Cng+pKTAzoqPiU8Of8MyRNhat1LEyXetwkYO1qFTuXq+FjzAloI80CNMqt3w7PQb8QE9IuwSKT8z2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PMblev5enIVosOTGW+FhUnYjqBE+GQFUhy6SZu6StpI=;
 b=E2imMDO++uXugsh2cSaK8KO0KKCMDqAh2XIKbu53VW2N6OPBEopoXILmM80HXyFyGNHs8Sks/RvIJA1Kprh71VZN2tysaWi8k+e++nB99EMi+0J7FpzlDnSEa+0A5rxtfwVGnsYYBb1jLd+WDATRicQAg4CcSRQMXNvfu4ZfUxP32bBsM8dWiMAklo53jFfPlIzkmp9+zZQTkuWz5fnXnv+fYUMDIJLUkuQO/Diq0MkDbPrfPuKS/W1n8a1eLSwFUuOA1TEq8e+Vfp29B+QfZfC2/VnDjZz7gGa196IlL2Ll4wMymhVzTLrzBtjTOcOguH+pKEuiwEi8gguANzUwPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PMblev5enIVosOTGW+FhUnYjqBE+GQFUhy6SZu6StpI=;
 b=XavmTOXHDDVenf/YBUFnbX/O/tLgbxG/asW+PRcRLlYvRiM1dur320yVys54MramFPPBJNbEtM1Mpce0B+ocZtLSNdYE/yqnBZmQqXl0iDZemDvL6hlTARcPHDM42O7znt1ZsJqhXIGd/BVFcm2Lx9LzqcXcQnJvEfFkpYXgtxy5WhYB81pfnBrKEQkF6YCuo8UUfOg0lEHWfgQTcZ5cekp+x6EQRYMY34v5Rhw+cXxNLvg5kfcmXaEHK40l06K8syPv+tRKUayjd9ROjHvzj0/oF5aYWkk0U0Zn1NtxXFeRkVAeiBGmOp5fEBUk5mcHAfxz3l4GSW3B7RnrpOhW9A==
Received: from SN7PR12MB7833.namprd12.prod.outlook.com (2603:10b6:806:344::15)
 by SA3PR12MB7973.namprd12.prod.outlook.com (2603:10b6:806:305::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Wed, 5 Jun
 2024 10:40:44 +0000
Received: from SN7PR12MB7833.namprd12.prod.outlook.com
 ([fe80::6f09:43ac:d28:b19]) by SN7PR12MB7833.namprd12.prod.outlook.com
 ([fe80::6f09:43ac:d28:b19%4]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 10:40:44 +0000
From: Peter-Jan Gootzen <pgootzen@nvidia.com>
To: "stefanha@redhat.com" <stefanha@redhat.com>, "mszeredi@redhat.com"
	<mszeredi@redhat.com>
CC: Idan Zach <izach@nvidia.com>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>, "jefflexu@linux.alibaba.com"
	<jefflexu@linux.alibaba.com>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, Max Gurtovoy <mgurtovoy@nvidia.com>,
	"vgoyal@redhat.com" <vgoyal@redhat.com>, Oren Duer <oren@nvidia.com>, Yoray
 Zack <yorayz@nvidia.com>
Subject: Re: [PATCH] fuse: cleanup request queuing towards virtiofs
Thread-Topic: [PATCH] fuse: cleanup request queuing towards virtiofs
Thread-Index: AQHaseAyJXbKTYDmOEajcyxCKVzQkbGuiWGAgAp8fYA=
Date: Wed, 5 Jun 2024 10:40:44 +0000
Message-ID: <02a56c0d80c2fab16b7d3b536727ff6865aded40.camel@nvidia.com>
References: <20240529155210.2543295-1-mszeredi@redhat.com>
	 <20240529183231.GC1203999@fedora.redhat.com>
In-Reply-To: <20240529183231.GC1203999@fedora.redhat.com>
Reply-To: Peter-Jan Gootzen <pgootzen@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB7833:EE_|SA3PR12MB7973:EE_
x-ms-office365-filtering-correlation-id: 1f0e9b74-e38f-4a3c-97ad-08dc854bf44b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?R1RuV1RXT0tTaGhWL3pLNlc3UUxkMk5ZN3V3YmZwb25sdkR1dlE2TjErQXZu?=
 =?utf-8?B?STlFMGtZV0hqQkZldkZjSTZsYmI5cjNHUjU5eTZ1Zi82bmNPYng2cFE5MUUv?=
 =?utf-8?B?NksvL3BRdFdVUU5oREFhRTRHa0ExUzJZRFFZUnlHN01BODVRcFZyUUhHNmtM?=
 =?utf-8?B?VEJ4OEhNY3E0K2g0cGJqRzMxTGZIaVNnUDY5UXNpRlhnNUkxNmtWM2ozZk5z?=
 =?utf-8?B?QTVoeEZDS1VyYlcrQnZncDJ3bkMyWFI2WTM1N0lvU1Vhc2FudGFvcHhqUlVO?=
 =?utf-8?B?bXpkRjFsUUhNV2UwVHZPek9BSVNtd1l4RldQRXpUZVVDeG1IdkE0WTlmdFl3?=
 =?utf-8?B?UjhzL0xEWkJFVHkzRmx1YzVWdnNuZWxyRy9hTWFwMlZtYUdxbTNPN0s4WFZ6?=
 =?utf-8?B?dkFmdWJPSi9rMnhhY2dMaXZQMWxiWnZVQmpMOUM1SmVydGl4dE45bkJyelRo?=
 =?utf-8?B?djVDcE0xeWJ4VDZrYUJQZVRpMFdMSEhlQ285djhrT1ZpTWJDMkhZNERCc1Fq?=
 =?utf-8?B?YVhIRGErNFBMT3Vwa1RvellmQ2FtUFp3YW1ycCtBc3F6WVFsbUJvdFFjdFh5?=
 =?utf-8?B?ZFM4anRQNkpIMTF0SGlMOVNGNHgzMDlGK09Ya01KZFNPcmhieDlvMjhUOVRO?=
 =?utf-8?B?K3paV1dPUUJoTlNXMlJKc09oa3Z2b0x6OWJTTFgvN0QzN0ZFcGlDQXJiOXcx?=
 =?utf-8?B?VGxFMDhYYWl4RnU4cWx0VG5mNmR5UW5EM1NWRm53RzhnTCtBWkduRTV2dGFx?=
 =?utf-8?B?RWdtcjFINTVDREJ6aGx1bU8rZndkRVRyWU1uMjFveXJGQ3ZHUUtWRUovMkxo?=
 =?utf-8?B?cDh3SVU2U0VOaWN1UTcvOUQ3R1hqcmVxdTFhcGNINkF4SU5HN0xTL0lJU0FO?=
 =?utf-8?B?eWZyS2hUSkVuK2MrZU5pMW9TWkVhMEFUemV4WHBiOEhValBVMWZDUmM4VlZZ?=
 =?utf-8?B?QXZOT0h1WHBBWFdNLzBPRmVZa1gwcTBKcTFScG01MEQyMUxpUUM0UWkvZTBj?=
 =?utf-8?B?aWY4VnlZMFo4NWwwS0tTR01za2hCdTVrbjdBRnpqZUVheFladGN5ME1ZSEFa?=
 =?utf-8?B?UUVNYjZrTVVYZHdYOStkOHlRVHlVeFJFMXRORDkzcXN6MUxacUpvUkxlU0xD?=
 =?utf-8?B?bVNicXFyWVVzc0NLeDBNRGFRV00rOUh3cnRWOFBqaWk5VXJaUGRWenlYL2hQ?=
 =?utf-8?B?bkdyVE5XQ3B0THhrakdxVGlCMnRxSzhkOWNCY1BKUlRGOTc1MENHNU43R1Fn?=
 =?utf-8?B?aVJCVElTOW9TQWhDYkEraGdqZVVJb0ZWYnFaeVAyczltamphYVhyMndVdHpq?=
 =?utf-8?B?c2JhYmZSZE5Id1N6UjVwK3UremJnOHRxQkI0bG5ndlUwOUswdUdRK0ZjeWZQ?=
 =?utf-8?B?bUh5b0VROVlBZmxjN3M2bzh6Y2hqREpTYlE1ZnBBKzVycEU1Q3VWeUU1dGl6?=
 =?utf-8?B?MWhWbXB1V1RZL1h2Tjlxem94MVd1ODFPTFNtNnprRnFlSVhtWnlTVjBkSThW?=
 =?utf-8?B?cFUwVGk3MkhhczlBQUhtY0ptR0lpalZ6MjJRMGZSWlNWUnY5ZUhEam5yeW1W?=
 =?utf-8?B?UTgvSVJUcHowWldMOFpmclppbFVsNnVwL29ybjcyRWlKalNITWcvdk84M1BD?=
 =?utf-8?B?Tk5qUUJyYTU3ejZGQmhpYktCNjNyc3JiL05HdzduSWJoNUJTMDZJS1hwM0lB?=
 =?utf-8?B?dkZKdCtad3BIOGZ0eTNOOEZTWjhOWVlWQ21ZTGxnRlhweFQ3SHZZMkdSek55?=
 =?utf-8?B?MXA1QWEweFRadE5zbjFaWG9TaXkrTFMyV0hwb2o5eis0dlZrS3RjMlllaWNJ?=
 =?utf-8?B?MlFrZWlqRFEyVjdLcklZUT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB7833.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SERGZnZjNWFZWHh0VG5KSFgrOUhkT05VZFFTMmNyMll1TUIzTFZYMnN5Tmh0?=
 =?utf-8?B?b21xc29rTCtjS1NRcldlKytaL0xkQ01rVU50WStQekpDNUx1MmhEcDRvaHhC?=
 =?utf-8?B?NGs1TXdqcjdyajIxODJ5NGhkRGsxVWNWSWh5Y3dwZ0tqbmZKQ2p1NXhBbjhn?=
 =?utf-8?B?dTN2NVF3VS9zVVhKeERwelI4UzNNTGJpTlB2RDVmWUlFdTJPS0c0b0pyYUpB?=
 =?utf-8?B?eWxlQVF3Z01SS3gwQlo1d2tBVG1hVzRlVkNadlhkdjRRM3NCenpNZmRJSm9m?=
 =?utf-8?B?d0lxSThtaDd1VVYzUjhPK05uYXJwb05VVWpHYjQyQXhKa2xKYkVXWUpLQjJB?=
 =?utf-8?B?K095Y1FxT2sxeFNMZnRpZk9aanNXQjBGVFJhNXBuSnBuUkNySUpKUGNWTUcv?=
 =?utf-8?B?OEdtZEJqb3kzSHlSVzV4bkllcndMcTc0STBrSzJ0bFErNmpUdFNFK0VsS0Y5?=
 =?utf-8?B?N0VKMUhaQ3ZpWUFUSzBGbXBIbDAyYUZOQTVJQlJjb3QxNnBMSWVHb0g3b0ZR?=
 =?utf-8?B?am5lRCtydjFibUQ5aG1BaWh4Z2gvcG90N095OG1LT0ZVVm5Vb2UzdE10YWZQ?=
 =?utf-8?B?UWNxZGRVTEhqUVZ1UUdTdXBrNjRTSHhwZGNESG1zQzJpWG5HWFV2aWxhc0hM?=
 =?utf-8?B?bUhvTGs3QWxKRlcrNkJYQWFaZnYyS0t4KzRXeHZ4VHJIQ2psbkdieFk5Umtr?=
 =?utf-8?B?UUllTEQ2azJRaWdBWWF5OGF3OUZoaFluRE03ZlN5b1lZNWNXdFNvUE1GL3Zr?=
 =?utf-8?B?ODBXLzJZRzdSWmgzR1dhbUQ4cnFvSm9CZWYrWDdpeHFoSzRhL0t3MktUYUJl?=
 =?utf-8?B?N1dqdDUzV05taHBhSUFuWHFER3lFYzRUWHViZjg4ekZSeFljWk1XUTZRUEFX?=
 =?utf-8?B?MlpyWEV2eXUrb3pRYWhPRUxJUjM2Zi95d2VGcmtQMW1OcDBETUg3enFSbmtD?=
 =?utf-8?B?UUFkd3p5UUR4K1pyL1c2K1RGbXY3Vzc1NkxnNEJVaUVuQmwxaFFTWE8xQW9k?=
 =?utf-8?B?dm5xVDB3UkkxTE9YS0FoeFZTbTBXRGUvWmZ3RStYVE9XYVhnYk5lTFdzRUxJ?=
 =?utf-8?B?WXExcUN4OWtFam9SdGRYRUdYaWRlUkZwdEVORE9jaHYyLzZvWkl0b0RsL3VM?=
 =?utf-8?B?YjZ0cTFmWG4rTzhBb29MeFVwVDNiUHd1YlE2MmU4dlUwVGtrNC9wZEFSVHhy?=
 =?utf-8?B?TUYwL2RVOWpOWXllNkVEM1JSbERyN3AxelUyS2hWTU1RVEZFeU5xeFRNV0h3?=
 =?utf-8?B?bEFRRUdWcW9IaFN4b1YvOVQ3bFN2bmYxZGpILzRDMFpMaExLWWpwbEFTTEZT?=
 =?utf-8?B?dmkzMGNNbis1Wkt3bmxwUnVTQVkrUWphTTE0dU5EVThxS2trWVh3SFZYV1FK?=
 =?utf-8?B?N2ZacDFGaEQ5WVNXWExVZUl6aytsSllLdWE1ZXVRUXE4ZzlJQ0lEUEVocmdm?=
 =?utf-8?B?cllsWUZTUlJ2UkxUYnZFVk5VZDNURWlWUXp5S0lYRmFnL1R6VmFkcWpQbHdG?=
 =?utf-8?B?REQ3SlhVMm9oV2NrYUxWYi82N1laMHM3VmMxeVR0aFFqdFZreC9NZTRLNTE0?=
 =?utf-8?B?UmYxRjcwNzJTdmwrNTF1a3lxdHRKSWc1b3NOT0x1N20wdFcwNUMwQlM2eTZk?=
 =?utf-8?B?YWExclYxYS9IN0FZTDduSDhYUnIrdkJXZCtlbkxRQmNkYkp0WjdkTDJPYldS?=
 =?utf-8?B?R2gzWnFwcTVDV04zUCtzdEpXQlRvR1RRcFVYUndaQ2QrTWs4V25IcStWQWFq?=
 =?utf-8?B?bFdZZFVtVUFLSTIwblVzTWJjYnMyOFVvMTVkL2tkcTBXNWtMT2hKYnM2Z3dC?=
 =?utf-8?B?bUVUVld4Tmd2bVpoTFNFcENpRjJmRXplRTMvemRSVm1qMFFQOVo5czRqOStP?=
 =?utf-8?B?ZHNuVjZFb2ZMbkNSUFdSRnRnR0hYYzMwRE9QWXIyTHNPQVFBeEcybVNtSVJL?=
 =?utf-8?B?RmtSWGlyQTdYelFyUytmTzM0TzhCQVhUT3k5T0ZSVDI0RXdsZ3R3amtxN3NO?=
 =?utf-8?B?V3IvWnBKMFdURXFjb2lqZmtRUGJBRk1GVXFrR1RQTzNjMyt4MkVQL1pVYmxT?=
 =?utf-8?B?VFpCSTk5QnBRWHNJL0ZpZ1Y2VVFEejhWWTA5MjBxVFVlc1RaUVdqZFNhYk5k?=
 =?utf-8?B?MjYyMEYyMDhrZTdHMW1vNGNBbW5jQjJZNDRDNUhaN0duLzQ3ZDBsQUx6QVRM?=
 =?utf-8?B?SHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E3285E0460BBBE449F4A1F8B24CDF3F7@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f0e9b74-e38f-4a3c-97ad-08dc854bf44b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2024 10:40:44.6967
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RISTRWz4KXrr+YTeyqJ0L50aIfV5mk/MrfqKrltNaF66x7m6jnGhjE9GwAcpU0CFDKoeHCgN/Iv5QX4BZgTtZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7973

T24gV2VkLCAyMDI0LTA1LTI5IGF0IDE0OjMyIC0wNDAwLCBTdGVmYW4gSGFqbm9jemkgd3JvdGU6
DQo+IE9uIFdlZCwgTWF5IDI5LCAyMDI0IGF0IDA1OjUyOjA3UE0gKzAyMDAsIE1pa2xvcyBTemVy
ZWRpIHdyb3RlOg0KPiA+IFZpcnRpb2ZzIGhhcyBpdHMgb3duIHF1ZWluZyBtZWNoYW5pc20sIGJ1
dCBzdGlsbCByZXF1ZXN0cyBhcmUgZmlyc3QNCj4gPiBxdWV1ZWQNCj4gPiBvbiBmaXEtPnBlbmRp
bmcgdG8gYmUgaW1tZWRpYXRlbHkgZGVxdWV1ZWQgYW5kIHF1ZXVlZCBvbnRvIHRoZQ0KPiA+IHZp
cnRpbw0KPiA+IHF1ZXVlLg0KPiA+IA0KPiA+IFRoZSBxdWV1aW5nIG9uIGZpcS0+cGVuZGluZyBp
cyB1bm5lY2Vzc2FyeSBhbmQgbWlnaHQgZXZlbiBoYXZlIHNvbWUNCj4gPiBwZXJmb3JtYW5jZSBp
bXBhY3QgZHVlIHRvIGJlaW5nIGEgY29udGVudGlvbiBwb2ludC4NCj4gPiANCj4gPiBGb3JnZXQg
cmVxdWVzdHMgYXJlIGhhbmRsZWQgc2ltaWxhcmx5Lg0KPiA+IA0KPiA+IE1vdmUgdGhlIHF1ZXVp
bmcgb2YgcmVxdWVzdHMgYW5kIGZvcmdldHMgaW50byB0aGUgZmlxLT5vcHMtPiouDQo+ID4gZnVz
ZV9pcXVldWVfb3BzIGFyZSByZW5hbWVkIHRvIHJlZmxlY3QgdGhlIG5ldyBzZW1hbnRpY3MuDQo+
ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogTWlrbG9zIFN6ZXJlZGkgPG1zemVyZWRpQHJlZGhhdC5j
b20+DQo+ID4gLS0tDQo+ID4gwqBmcy9mdXNlL2Rldi5jwqDCoMKgwqDCoMKgIHwgMTU5ICsrKysr
KysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tDQo+ID4gLS0tDQo+ID4gwqBmcy9m
dXNlL2Z1c2VfaS5owqDCoMKgIHzCoCAxOSArKy0tLS0NCj4gPiDCoGZzL2Z1c2UvdmlydGlvX2Zz
LmMgfMKgIDQxICsrKystLS0tLS0tLQ0KPiA+IMKgMyBmaWxlcyBjaGFuZ2VkLCAxMDYgaW5zZXJ0
aW9ucygrKSwgMTEzIGRlbGV0aW9ucygtKQ0KPiANCj4gVGhpcyBpcyBhIGxpdHRsZSBzY2FyeSBi
dXQgSSBjYW4ndCB0aGluayBvZiBhIHNjZW5hcmlvIHdoZXJlIGRpcmVjdGx5DQo+IGRpc3BhdGNo
aW5nIHJlcXVlc3RzIHRvIHZpcnRxdWV1ZXMgaXMgYSBwcm9ibGVtLg0KPiANCj4gSXMgdGhlcmUg
c29tZW9uZSB3aG8gY2FuIHJ1biBzaW5nbGUgYW5kIG11bHRpcXVldWUgdmlydGlvZnMNCj4gcGVy
Zm9ybWFuY2UNCj4gYmVuY2htYXJrcz8NCj4gDQo+IFJldmlld2VkLWJ5OiBTdGVmYW4gSGFqbm9j
emkgPHN0ZWZhbmhhQHJlZGhhdC5jb20+DQoNCkkgcmFuIHNvbWUgdGVzdHMgYW5kIGV4cGVyaW1l
bnRzIG9uIHRoZSBwYXRjaCAob24gdG9wIG9mIHY2LjEwLXJjMikgd2l0aA0Kb3VyIG11bHRpLXF1
ZXVlIGNhcGFibGUgdmlydGlvLWZzIGRldmljZS4gTm8gaXNzdWVzIHdlcmUgZm91bmQuDQoNCkV4
cGVyaW1lbnRhbCBzeXN0ZW0gc2V0dXAgKHdoaWNoIGlzIG5vdCB0aGUgZmFzdGVzdCBwb3NzaWJs
ZSBzZXR1cCBub3INCnRoZSBtb3N0IG9wdGltaXplZCBzZXR1cCEpOg0KIyBIb3N0Og0KICAgLSBE
ZWxsIFBvd2VyRWRnZSBSNzUyNQ0KICAgLSBDUFU6IDJ4IEFNRCBFUFlDIDc0MTMgMjQtQ29yZQ0K
ICAgLSBWTTogUUVNVSBLVk0gd2l0aCAyNCBjb3JlcywgdkNQVXMgbG9ja2VkIHRvIHRoZSBOVU1B
IG5vZGVzIG9uIHdoaWNoDQp0aGUgRFBVIGlzIGF0dGFjaGVkLiBWRklPLXBjaSBkZXZpY2UgdG8g
cGFzc3Rocm91Z2ggdGhlIERQVS4gICAgICAgICAgIA0KUnVubmluZyBhIGRlZmF1bHQgeDg2XzY0
IGV4dDQgYnVpbGRyb290IHdpdGggZmlvIGluc3RhbGxlZC4NCiMgVmlydGlvLWZzIGRldmljZToN
CiAgIC0gQmx1ZUZpZWxkLTMgRFBVDQogICAtIENQVTogQVJNIENvcnRleC1BNzhBRSwgMTYgY29y
ZXMNCiAgIC0gT25lIHRocmVhZCBwZXIgcXVldWUsIGVhY2ggYnVzeSBwb2xsaW5nIG9uIG9uZSBy
ZXF1ZXN0IHF1ZXVlDQogICAtIEVhY2ggcXVldWUgaXMgMTAyNCBkZXNjcmlwdG9ycyBkZWVwDQoj
IFdvcmtsb2FkIChkZXZpYXRpb25zIGFyZSBzcGVjaWZpZWQgaW4gdGhlIHRhYmxlKToNCiAgIC0g
ZmlvIDMuMzQNCiAgIC0gc2VxdWVudGlhbCByZWFkDQogICAtIGlvZW5naW5lPWlvX3VyaW5nLCBz
aW5nbGUgNEdpQiBmaWxlLCBpb2RlcHRoPTEyOCwgYnM9MjU2S2lCLCAgICANCnJ1bnRpbWU9MzBz
LCByYW1wX3RpbWU9MTBzLCBkaXJlY3Q9MQ0KICAgLSBUIGlzIHRoZSBudW1iZXIgb2YgdGhyZWFk
cyAobnVtam9icz1UIHdpdGggdGhyZWFkPTEpDQogICAtIFEgaXMgdGhlIG51bWJlciBvZiByZXF1
ZXN0IHF1ZXVlcw0KDQp8IFdvcmtsb2FkICAgICAgICAgICB8IEJlZm9yZSBwYXRjaCB8IEFmdGVy
IHBhdGNoIHwNCnwgLS0tLS0tLS0tLS0tLS0tLS0tIHwgLS0tLS0tLS0tLS0tIHwgLS0tLS0tLS0t
LS0gfA0KfCBUPTEgUT0xICAgICAgICAgICAgfCA5MjE2TWlCL3MgICAgfCA5MjAxTWlCL3MgICB8
DQp8IFQ9MiBRPTIgICAgICAgICAgICB8IDEwLjhHaUIvcyAgICB8IDEwLjdHaUIvcyAgIHwNCnwg
VD00IFE9NCAgICAgICAgICAgIHwgMTIuNkdpQi9zICAgIHwgMTIuMkdpQi9zICAgfA0KfCBUPTgg
UT04ICAgICAgICAgICAgfCAxOS41R2lCL3MgICAgfCAxOS43R2lCL3MgICB8DQp8IFQ9MTYgUT0x
ICAgICAgICAgICB8IDk0NTFNaUIvcyAgICB8IDk1NThNaUIvcyAgIHwNCnwgVD0xNiBRPTIgICAg
ICAgICAgIHwgMTMuNUdpQi9zICAgIHwgMTMuNEdpQi9zICAgfA0KfCBUPTE2IFE9NCAgICAgICAg
ICAgfCAxMS44R2lCL3MgICAgfCAxMS40R2lCL3MgICB8DQp8IFQ9MTYgUT04ICAgICAgICAgICB8
IDExLjFHaUIvcyAgICB8IDEwLjhHaUIvcyAgIHwNCnwgVD0yNCBRPTI0ICAgICAgICAgIHwgMjYu
NUdpQi9zICAgIHwgMjYuNUdpQi9zICAgfA0KfCBUPTI0IFE9MjQgMjQgZmlsZXMgfCAyNi41R2lC
L3MgICAgfCAyNi42R2lCL3MgICB8DQp8IFQ9MjQgUT0yNCA0ayAgICAgICB8IDk0OE1pQi9zICAg
ICB8IDk1NU1pQi9zICAgIHwNCg0KQXZlcmFnaW5nIG91dCB0aG9zZSByZXN1bHRzLCB0aGUgZGlm
ZmVyZW5jZSBpcyB3aXRoaW4gYSByZWFzb25hYmxlDQptYXJnaW4gb2YgYSBlcnJvciAobGVzcyB0
aGFuIDElKS4gU28gaW4gdGhpcyBzZXR1cCdzDQpjYXNlIHdlIHNlZSBubyBkaWZmZXJlbmNlIGlu
IHBlcmZvcm1hbmNlLg0KSG93ZXZlciBpZiB0aGUgdmlydGlvLWZzIGRldmljZSB3YXMgbW9yZSBv
cHRpbWl6ZWQsIGUuZy4gaWYgaXQgZGlkbid0DQpjb3B5IHRoZSBkYXRhIHRvIGl0cyBtZW1vcnks
IHRoZW4gdGhlIGJvdHRsZW5lY2sgY291bGQgcG9zc2libHkgYmUgb24NCnRoZSBkcml2ZXItc2lk
ZSBhbmQgdGhpcyBwYXRjaCBjb3VsZCBzaG93IHNvbWUgYmVuZWZpdCBhdCB0aG9zZSBoaWdoZXIN
Cm1lc3NhZ2UgcmF0ZXMuDQoNClNvIGFsdGhvdWdoIEkgd291bGQgaGF2ZSBob3BlZCBmb3Igc29t
ZSBwZXJmb3JtYW5jZSBpbmNyZWFzZSBhbHJlYWR5DQp3aXRoIHRoaXMgc2V0dXAsIEkgc3RpbGwg
dGhpbmsgdGhpcyBpcyBhIGdvb2QgcGF0Y2ggYW5kIGEgbG9naWNhbA0Kb3B0aW1pemF0aW9uIGZv
ciBoaWdoIHBlcmZvcm1hbmNlIHZpcnRpby1mcyBkZXZpY2VzIHRoYXQgbWlnaHQgc2hvdyBhDQpi
ZW5lZml0IGluIHRoZSBmdXR1cmUuDQoNClRlc3RlZC1ieTogUGV0ZXItSmFuIEdvb3R6ZW4gPHBn
b290emVuQG52aWRpYS5jb20+DQpSZXZpZXdlZC1ieTogUGV0ZXItSmFuIEdvb3R6ZW4gPHBnb290
emVuQG52aWRpYS5jb20+DQoNCg==

