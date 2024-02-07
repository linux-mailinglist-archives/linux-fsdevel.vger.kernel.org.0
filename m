Return-Path: <linux-fsdevel+bounces-10681-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 289A584D5B2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 23:18:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 937051F21492
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 22:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903D4149DF3;
	Wed,  7 Feb 2024 22:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dGr8dfRC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CEC149DE9
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Feb 2024 22:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707344316; cv=fail; b=J6+QnP73bvnA+ua7BaD8b1GxMJSa1Rw4eM4FHw1ygH6iomOmYP8Z9TZQmGhWCLJ6waEDNwhycW1CyMQ9S8vbATFMc5mfC76K98juwUirjSYsLB82hHNSgpwtj5IB03Bu2YV5PKOA/nc2XDjiVCWkcoBtsXU3lcwCw7KuOJf5PLY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707344316; c=relaxed/simple;
	bh=N3YBRlrdv/gfi17dofWpWw/kzi/CybPO4fsDEDB773M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rQzD2VTC6NbJxEAP7fDJ7S6kD11DsHKvRCh/nX+lRNVfuh679op5u7mWnsXWrONFA/5pHd03phCsnoegR4KrrrxERy6LENVSZJ5NH30YrP7TuhceGPSQ6PMozCIGtq5+xRHzVY2nizxrp1d9/xwNSsqJdaxdTduwR0fUoHt7Lzs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dGr8dfRC; arc=fail smtp.client-ip=40.107.92.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YkDPYvXOO8R1R3b9jj0QGp+8sCIqAQCkQyKBCO71pN5/ZPpnHHBzbJYO0uWWIoH1DcHHDFFCtHU1pma+7xZ/bPSCbbcZ8XRx3EryBYPHNLt04m7x0yTxT+laC0VL8eB9w37H+3R/cW+Eq1tViBcrmPXvJh+R8cKZNkIw1BWpiVr73iPn7VVOPdXil7eHpfOR1WvUKPpHK+DK2YgN68fOxBXfooC8DAyojJ3jo5VsQrTE4gJhbJzUKZ5/4uHx30XxEsRp6UjwvNoSIVkhvJIiu1u66na83EVSah1fElmV1dISC7lGvtGJSSwarRUhI/l4wFSXqDAO00cyPRM+Riy23Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N3YBRlrdv/gfi17dofWpWw/kzi/CybPO4fsDEDB773M=;
 b=jLwUlBFGJvkUQz8tR+cU1CzwF8gqsJBCxhL+xnSGXtJcM71cUa37T1CzdofIFr4DWzrBHkT2Ssv51Fl0yTk3sJ1F6CLEF2eFeweXRLuxc7UzRtmsqSuYsS6DGDamKFcDfyyMisKn8JlSlH0Ugg/epwK2JcU8BsC6R7UOCX3yaqoQLBPjPIYvZgLz4/bpW68/cqP3I0+U9F87iUB6In+Gm5QzhUvEaHQJ4vtQuc7z53DoJS7jgrDO+ajhzrUZCRgQbc1+105t17EFyyFGuDQ+EYHKHjEocG4zz/oqc13nr91G4kufivMKequu6bpvNuIJcdRM5sIp9eA0SCBKP8iooQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N3YBRlrdv/gfi17dofWpWw/kzi/CybPO4fsDEDB773M=;
 b=dGr8dfRCysh8xuI8WTdJtFlWArtK18vGU+K+f3LcSW7FqZDeDEtSuZogFaSDuOgKUqN8xy2NviT7UIEn+Mf9W1EyEQFwPRJ7XyhPhKyxrmIkIa2fst7GIkaHI+BDy1NGBAPNuYb/GK/+k6KP/awKGCIj5qbWFSfGZpfvFUw7w0YFRpkir2RJct2gujPtrX/Y16zFyyjTzyMzjdYHXBAy+kEjaxujKCfZKG1Cja7UbYnSWZBQVD/2C/9G1TtyUcqWo0+bwiokwXhvCftcZJgC0Qez4QxHdyV7VsVY3EwVl7uudEH0fsclsxyCtjtAQMkzxSKZC05czfMGiLNsu3DBBw==
Received: from SN7PR12MB8769.namprd12.prod.outlook.com (2603:10b6:806:34b::12)
 by SA0PR12MB4525.namprd12.prod.outlook.com (2603:10b6:806:92::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.16; Wed, 7 Feb
 2024 22:18:27 +0000
Received: from SN7PR12MB8769.namprd12.prod.outlook.com
 ([fe80::9f0f:632e:815c:f953]) by SN7PR12MB8769.namprd12.prod.outlook.com
 ([fe80::9f0f:632e:815c:f953%7]) with mapi id 15.20.7270.012; Wed, 7 Feb 2024
 22:18:27 +0000
From: Timur Tabi <ttabi@nvidia.com>
To: "david@fromorbit.com" <david@fromorbit.com>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"rafael@kernel.org" <rafael@kernel.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "michael@ellerman.id.au"
	<michael@ellerman.id.au>
Subject: Re: [PATCH] debufgs: debugfs_create_blob can set the file size
Thread-Topic: [PATCH] debufgs: debugfs_create_blob can set the file size
Thread-Index: AQHaWgE+grTE5SehCkWVnczcxwLZYrD/aH4AgAABGQCAAAYrAIAAA18A
Date: Wed, 7 Feb 2024 22:18:26 +0000
Message-ID: <33f582cce59ac14ce454aa49e14f50e535684004.camel@nvidia.com>
References: <20240207200619.3354549-1-ttabi@nvidia.com>
	 <ZcP4xsiohW7jOe78@dread.disaster.area>
	 <6f7565b9d38a6a9bddb407462ae53eb2ceaf0323.camel@nvidia.com>
	 <ZcP+3gqQ+LDLt1SP@dread.disaster.area>
In-Reply-To: <ZcP+3gqQ+LDLt1SP@dread.disaster.area>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB8769:EE_|SA0PR12MB4525:EE_
x-ms-office365-filtering-correlation-id: 473c73c7-026a-4db7-ffd1-08dc282ab4fb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 bjupsgtlid74wczL23VzA9GcShxhLFRRKjlCBIiUsC76iFF71BaD6rWS5BP3VXWiV0ECwec0AzPFCEz8Tz17bsuwE+WGQlRMe+4ihExGcfxsz8etBEoVfRphQ0Sl7O66aWmmpDr+UUNNJrXak8GcRlol8TZTTlrADxAA2eS4l33dZZeuns7PkIoc+XE4euvpKLbF9c2J6uC5S1krgw29hkmCykDXouIQ8Vl1lB4vfGP3wKitSuGu9A/pR+BlWLRt7M/uZ1W9F0hdQcYDRo8qQwwRpstyF2MoQ3/vxM7Ah5cw94q8Rsa7GYsaDpm8gCcDxjMC0rPK3aASRyCoj3UUNj5AgKK8CVk0Q5ePIfKI3t1STn1GeyofiQUlgDcUBbArJBZEV68r0b0+Mgsk8TwPLBC/WJHIcJAt3xB76r/1WUeYdF3CSALM+RkaJ+3Sp5yl3y1emfHhKkJQAtxsP2PrnnAGl+q9JAJKPSDf1xJNqn0hNk+6MzK0nnYoTgWNy/vVTnMQor8gTsRzYy5lt6NZXG/j+DQVQ8UqWPKoMpTe9lTRviLEAcQ+efUOJZxx/Z/DWthEqOtbdLQvyuYqP0niN6Kk6vAUSaPhr82Y0QCvkgpcp1TCR5rYKz4jinRZA2d8
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8769.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(136003)(39860400002)(366004)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(36756003)(6486002)(2616005)(26005)(4326008)(5660300002)(66476007)(8676002)(38100700002)(76116006)(6916009)(8936002)(2906002)(66556008)(71200400001)(64756008)(66446008)(122000001)(6506007)(54906003)(66946007)(316002)(6512007)(86362001)(38070700009)(478600001)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZGJzdFloa3dMRkVMR3B0MzV3RU8zaWF4QndqODdlaWZUVmw2SFd4MnlUUXVN?=
 =?utf-8?B?TmFQSjVITVllSmliSHkxb2dNeFFmOGRwQWdpb29GbDJnbkgwemZnTEtkNGlj?=
 =?utf-8?B?aXhZUklkVUMzVU5xcmhGTDBNNFI5Q1BHSlBLaHRkR3dOd3NQMGVPblhBSmQ5?=
 =?utf-8?B?YUhsbmlacDlxWUVxc1dleVhxMk9VbHlTV3pMaXlxWXN6REFHZHRVR1pLRUwy?=
 =?utf-8?B?ZGh0cEFwMWhXUXhzUnFmanNLejBKY2l6Y21YMXpsbWRDS0lCUXBhWEtabUV6?=
 =?utf-8?B?ellXSWZyN3p2RXdManhaL2d1eDlmRUlLNjZiWDBQOVpTdXhuRFF2ZEhNYjd3?=
 =?utf-8?B?OG81TWNqZkxmamJJL0xpN3VKUWxDNE9LWnNENTNvdG5SM1NoTDBabVVJSXpx?=
 =?utf-8?B?bSttT0hvQ01WR3NhMm9QT3R5ZFczRmtVVzB3bnhUY2h3a0FMQlhTb2t1ODQ3?=
 =?utf-8?B?cFdJejhQMWVNWFZ4S2lKVFFZK1pOMUZBZFZ6LzlYMGsvSW9QRjhsUTUzaklY?=
 =?utf-8?B?cklCUzdBQ0I0dnVVMU1QbEhWbXNtUC9OUlZWbDdNM0Ezc0tSOURTWVRqMnhF?=
 =?utf-8?B?MjhYMmRvVThPcFZXNENOWEtjOVBsVmpoL01TWU1zMm1aOHh3Nm9aOXZiNEMx?=
 =?utf-8?B?SEhXbzhqeDBtb0ZzdjVwZFRhc29rK1VaVlo5Yi9Tc3Vic29GQStzV1RCUncz?=
 =?utf-8?B?ZHorQ2hGc01uSkFUQjhtc1ZPUkEyQ3NsdkxCQzJ3UkRXSFJNZVBSRmJkYndO?=
 =?utf-8?B?elRqbVAvbGRKc0laUHkrOGQyb0pYVm5BUCtjMUhzaUtOZGZ6Z0hHSnpNZGdX?=
 =?utf-8?B?UzFESzJOTzhVWVdKV2pBcHhsSFg1SHNQTzV6S0d4R0JqVk1rdEJMcDlRRUt6?=
 =?utf-8?B?ZnlJbzhvRmFwcjA3bTBlcENWSVRxUGxuUDFGUVhkMWZTdm02ZFdsRVg4Tktw?=
 =?utf-8?B?RVlCdE5Ec2VRdzVFOGxBbnU3d0x4TFg0ZTVmVkI0dnhza3ZIcFlJZVVMU2du?=
 =?utf-8?B?cHdMcDFvaUI3aXNlam1NckIyWXN6bmorUU1CRkVlQUVDQzVUQThzQTdJYmc4?=
 =?utf-8?B?QzZ2dFVpR1FaS3RTMCtxV0N6clpWZ2w1bzFNeFdpN0RPUXpSMVVTdDdXYVRj?=
 =?utf-8?B?YXZFb2lPMVE0MjcvaUcvbERJU25EVERyTW0zaCtkT3dkazZ0MTdPcmlMSEpX?=
 =?utf-8?B?bE56M3FkdWpaVDZTM09McVVtTkdWM0QremdkVmdMbzBSc2dwNk81Y2dNbS9F?=
 =?utf-8?B?eXRmcnlhQkdyakkwR3Zib2E4RXdKSSs4VjFlVWlKRXJubUVoTG8rZlNNbVU4?=
 =?utf-8?B?ajBjREVCWW1waEN4TW41dWVBNTdsQXY5WStDcXFUSWxBaE10UzlENGdGUmU3?=
 =?utf-8?B?azlNbkVVRkpiazdRc2VleEhzM3d2VG1scnYzMVVncklYRlRQRXE0RXRuaHM3?=
 =?utf-8?B?S1didnNBNE9vRG9oVGRuNnFUZ3BpMFFTRnB4U1B2NXZvdGlsM1dWZ1YvSWJG?=
 =?utf-8?B?VG1TWWx1eFVuMXlLTGxhSzY0dUJraGwzQU5oZ1NpVUxFZXl4b1BxMlEyT1hl?=
 =?utf-8?B?TTRzSnRZdXNjQ1diYW1uQnhmQlV2clFESlRUdUhkM29VcGo2RFdtMG5zTC8w?=
 =?utf-8?B?MkNHaDZwZnRnaWl3NDlpdFR5TGdoQWhhTmx0dUxQQkFxNDd0bG1NWmJkUjg5?=
 =?utf-8?B?MTM2UlZQNmtKQSt1NjZ1bkYyQzVtbFRCelJrbVc5dm4yc2czY3Y0SEphbXVr?=
 =?utf-8?B?VDFZVk1oMmJHUWNnaUZXUytSQy9valJMU1lSUGN3SFI2VEM2TjVoQ2RkSzN0?=
 =?utf-8?B?dTNSMXJBdTRRaHdPUkVmN0xKem15enQrcnAwRlRaNjZicEZnRHU2UjNKQmNQ?=
 =?utf-8?B?ZWxyLzM3R3ZOZWIyYW9GSWZIclFweXUvQ1RvV3lvUmk2RFN5WUVNL0JObzdn?=
 =?utf-8?B?QXFSQktEZUVxZkY1RWFaRS8zREoyOWhwTjVTRXpXcU1WcDUzVVlpUHJCMEpG?=
 =?utf-8?B?VDhNZnFYbUNtYlBBT0dxSlZJQTdmQ0oxZWNGQWJLbjJab2RzMnVaNWdTTmdh?=
 =?utf-8?B?QklkS05qT2V0ZXhMSzdoSkNGRGpXK1FqN0NMaUtLa0hxRUk5NzEzTFJOL0tu?=
 =?utf-8?Q?IRRiI/me6nvTICMqv68G6bJBz?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <84A0B5BA09E3A245926C8B69B7770ED7@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8769.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 473c73c7-026a-4db7-ffd1-08dc282ab4fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2024 22:18:26.9850
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UZx0x7YSSnNJ9yiWUhTeoyW4Eh7Um9+MFInvIN6/9okof+uhJswUfkU4+OwcFgIokTUupKBalt81ac4RxCD41w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4525

T24gVGh1LCAyMDI0LTAyLTA4IGF0IDA5OjA2ICsxMTAwLCBEYXZlIENoaW5uZXIgd3JvdGU6DQo+
IFNvIGZpeCB0aGUgZGVidWdmc19jcmVhdGVfZmlsZV8qKCkgZnVuY3Rpb25zIHRvIHBhc3MgYSBs
ZW5ndGgNCj4gYW5kIHRoYXQgd2F5IHlvdSBmaXggYWxsIHRoZSAiZGVidWdmcyBmaWxlcyBoYXZl
IHplcm8gbGVuZ3RoIGJ1dA0KPiBzdGlsbCBoYXZlIGRhdGEgdGhhdCBjYW4gYmUgcmVhZCIgcHJv
YmxlbXMgZm9yIGV2ZXJ5b25lPyBUaGVuIHRoZQ0KPiB6ZXJvIGxlbmd0aCBwcm9ibGVtIGNhbiBi
ZSBpc29sYXRlZCB0byBqdXN0IHRoZSBkZWJ1ZyBvYmplY3RzIHRoYXQgZG9uJ3QNCj4ga25vdyB0
aGVpciBzaXplIChpLmUuIGFyZSBzdHJlYW1zIG9mIGRhdGEsIG5vdCBmaXhlZCBzaXplKS4NCj4g
DQo+IElNTywgaXQgZG9lc24ndCBoZWxwIGFueW9uZSB0byBoYXZlIG9uZSBwYXJ0IG9mIHRoZSBk
ZWJ1Z2ZzDQo+IGJsb2IvZmlsZSBBUEkgdG8gc2V0IGlub2RlLT5pX3NpemUgY29ycmVjdGx5LCBi
dXQgdGhlbiBsZWF2ZSB0aGUNCj4gbWFqb3JpdHkgb2YgdGhlIHVzZXJzIHN0aWxsIGJlaGF2aW5n
IHRoZSBwcm9ibGVtYXRpYyB3YXkgKGkuZS4gemVybw0KPiBzaXplIHlldCB3aXRoIGRhdGEgdGhh
dCBjYW4gYmUgcmVhZCkuIEl0J3MganVzdCBhIHJlY2lwZSBmb3INCj4gY29uZnVzaW9uLi4uLg0K
DQpJIGRvbid0IGRpc2FncmVlLCBidXQgdGhhdCdzIGEgbXVjaCBtb3JlIGFtYml0aW91cyBjaGFu
Z2UgdGhhbiBJIGFtIHByZXBhcmVkDQp0byBtYWtlLiAgDQoNCmRlYnVnZnNfY3JlYXRlX2ZpbGVf
c2l6ZSgpIGFscmVhZHkgZXhpc3RzLCBpdCdzIGp1c3QgdGhhdA0KZGVidWdmc19jcmVhdGVfYmxv
YigpIGRvZXNuJ3QgdXNlIGl0LiAgSSB0aGluayB0aGUgcHJvYmxlbSBpcyB0aGF0IHRoZSBmaWxl
DQpzaXplIGlzIG5vdCBhbHdheXMga25vd24sIG9yIGF0IGxlYXN0IG5vdCBhbHdheXMgdGhlIGZp
eGVkLCBzbyBzZXR0aW5nIHRoZQ0KaW5pdGlhbCBmaWxlIHNpemUgaXNuJ3QgYWx3YXlzIGFuIG9w
dGlvbi4NCg0KT24gYSBzaWRlIG5vdGUsIGRlYnVnZnNfY3JlYXRlX2ZpbGVfc2l6ZSgpIGRvZXMg
dGhlIHNhbWUgdGhpbmcgdGhhdCBteSB2MQ0KcGF0Y2ggZG9lczoNCg0Kc3RydWN0IGRlbnRyeSAq
ZGUgPSBkZWJ1Z2ZzX2NyZWF0ZV9maWxlKG5hbWUsIG1vZGUsIHBhcmVudCwgZGF0YSwgZm9wcyk7
DQppZiAoIUlTX0VSUihkZSkpDQoJZF9pbm9kZShkZSktPmlfc2l6ZSA9IGZpbGVfc2l6ZTsNCg0K
U2hvdWxkbid0IHRoaXMgZnVuY3Rpb24gYWxzbyB1c2UgaV9zaXplX3dyaXRlKCk/DQoNCg==

