Return-Path: <linux-fsdevel+bounces-7668-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5260B828F5F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 23:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2818288920
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 22:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B83F3DBAA;
	Tue,  9 Jan 2024 22:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kYJJWXE2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024E23DB86;
	Tue,  9 Jan 2024 22:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J5HKyzHzGo0EVlb7DlgrLHtGBxZmD1qEERk8BD56la3OXm//3tV3eZTrgy8EbKv0gb3eruYi4rirQoPTW5/A04yUHmMrJtwwg4gcsrQDmvz+HXLpfbw687bUW37Y7LltJYulJBxiXaZhgeTxR+48hi0dDQORq6OVSFbvS+tfU9cWeM9goJ0tSSQH7qeRoNW8wu5iCKj1X312HBZCifc704uFOLrhcrlkGiLpXTqMN3CIJ+WqvAUXuBcw/IjYvUYiYw0qonYAnLiXlNCqcFHGiA6tYAgBv7SeuGaZNJaZFdmixS0jQ0Sv+9nrzDSgjL0sbihCBwhioPbuJrsrtIqKqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pNFDn/d9qPvOGEioz8rZlNjbV6eMagYjmn+VF5I0WJM=;
 b=UDWtkV1N/4KOnxlS++/2FnNQ/h18vq+bp4ZqLOQ0Z/r1qHlOU0ww9zXj/bEwCQIf2jhJH6JpBbIYucOMwRYKeuK1nBfV2IXeFQampiFQ2Q3M5V/Aoeeis7gX8QM05WhT3flYBUUwwc7CqPA0JAsGuIBDIZ4wEFGkI2wbBS+ZfVdVpKlzkC3AEGabu9y6GUJ+ALWklhOescktXCnozG6HDtELXw5vECKfQY1O/AZPNbYxf5vL1tQ1hVG2R0Zr1z8G44fWbAGeq7ZZCBBTMazH8u/EvliSYtdl/IVLeeMXY4wzANzGUj5qKIQdvNgbWjmEksgsOKxTxOOyYb2jfXeAeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pNFDn/d9qPvOGEioz8rZlNjbV6eMagYjmn+VF5I0WJM=;
 b=kYJJWXE28uskI8lVzVz5zYJThKrDis/Fm7x2mX7XRvMtGWThSuLxa2DBig3tEvMVP5skMkb+Yk2lgzHJOm1wp5a867j0sm1QAYR9B8t2cvF2/WEHP7B6xWgSQCrDme36ASG01foXFAh8Zv4Wy+PNW2MgTiDn8nEAvMaqzMkUZHMMHohdfY7omfOj852If6lqjkRyL3OG579YumueJfjUnVOBRseGeOv7qCcM4mr5ivjRB03sZ30oRdDidKsUH9sEtdAFtu9HoB18u6gBA74IHUawLnnZRPYFh0h6dtQmqB777xY1ShjxsgWCcwTP/tIuxO4KqcDQv0iDJJbymilBAg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by PH0PR12MB8032.namprd12.prod.outlook.com (2603:10b6:510:26f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 22:01:23 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::efb1:c686:d73d:2762]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::efb1:c686:d73d:2762%7]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 22:01:23 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Bart Van Assche <bvanassche@acm.org>, Shinichiro Kawasaki
	<shinichiro.kawasaki@wdc.com>
CC: Jens Axboe <axboe@kernel.dk>, "josef@toxicpanda.com"
	<josef@toxicpanda.com>, Amir Goldstein <amir73il@gmail.com>,
	=?utf-8?B?SmF2aWVyIEdvbnrDoWxleg==?= <javier@javigon.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>, Dan
 Williams <dan.j.williams@intel.com>, "linux-scsi@vger.kernel.org"
	<linux-scsi@vger.kernel.org>, "linux-fsdevel@vger.kernel.org >>
 linux-fsdevel" <linux-fsdevel@vger.kernel.org>, Christoph Hellwig
	<hch@lst.de>, Keith Busch <kbusch@kernel.org>, Hannes Reinecke
	<hare@suse.de>, Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	"shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>, Johannes
 Thumshirn <Johannes.Thumshirn@wdc.com>, "jack@suse.com" <jack@suse.com>, Ming
 Lei <ming.lei@redhat.com>, Sagi Grimberg <sagi@grimberg.me>, Theodore Ts'o
	<tytso@mit.edu>, "daniel@iogearbox.net" <daniel@iogearbox.net>, Daniel Wagner
	<dwagner@suse.de>
Subject: Re: [LSF/MM/BPF ATTEND][LSF/MM/BPF TOPIC] : blktests: status,
 expansion plan for the storage stack test framework
Thread-Topic: [LSF/MM/BPF ATTEND][LSF/MM/BPF TOPIC] : blktests: status,
 expansion plan for the storage stack test framework
Thread-Index: AQHaQsVhMyllFDjM60KeZkR49nqOpbDSAPUAgAAIRIA=
Date: Tue, 9 Jan 2024 22:01:23 +0000
Message-ID: <0e33127d-6a43-46a1-9276-0c2f1965e345@nvidia.com>
References: <e5d8cd68-b3f2-4d7b-b323-b13d18199256@nvidia.com>
 <33213b76-07f2-4b75-9940-679ec8f06975@acm.org>
In-Reply-To: <33213b76-07f2-4b75-9940-679ec8f06975@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|PH0PR12MB8032:EE_
x-ms-office365-filtering-correlation-id: 9c81c71d-ee29-4653-6726-08dc115e84c0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 CkzmKkFJMJncPSNvcWWvB6SC3Fhjc9hES8j95QxjL8EWXzWQwBVSNZ8UQsEhrJ9ne1BJbR+nJFFhP7Pz0e+MNPFa416PNJQ6jgje6NL8u/AP+cmVz0/4wLXIP3Wbl4nVgEw9/kvNDBweZbbpcx9/gLNNL78c1k8dv93APFpIA1fSMsbCZmlVLD7kqHRcPwki94KolU/nzy/qnJ3ac0xTh3sAB2c4efoVJokwimaknt1bA6x8iTeIaWAwA9XlNy2KBrWhpzKIU7+jtGiQ61t0j3327vIt5nZgd5a8gppT5zbI1KNPzoZ7nqDA2XxAF3UqAb540+zq+eOp56WZbL/f3ATKJAjOIpkwrNR21xkvu0aKNwaovBGYVbHXowEA+HT3QvfI77iDZPmvAaW8fQIYWRk+lmg0blCebwamloK6LDwBN9tfmGcWXWpkT/shPA6khETbPrhvQr/VVcWmzvnQQdkCMGvhrQWoP/wlUk85zQTd6PwtgwsJ+RHfZ1XWiRRcs0wffsydUj+oXRiSWV0mRF9tCEnRGkEC5+aiyF+WQd0SjDJZi8o5jw8y6RU9eBZuPd6mi1a4n+K4GfZl67aA5rtvbtKBsjkULnvRkLgrRIlV1FLCsVo4zL5jEanVWT9Fc/myZi8qJCUf2o99ODiOPOYLLd73QR7NZPL313jVcUVZsWUfUD8bubOX2OkqI5zO+w4jO4H2LeL90eOTabnIAuGQ/oup6DVwQB5mzFNzPKRLB4xIieExFG2Y+uh95qsk
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(396003)(39860400002)(346002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(83380400001)(316002)(53546011)(6512007)(2616005)(122000001)(6486002)(38100700002)(4326008)(8936002)(8676002)(4744005)(7416002)(2906002)(5660300002)(54906003)(66476007)(66556008)(110136005)(64756008)(966005)(6506007)(71200400001)(66446008)(478600001)(41300700001)(91956017)(66946007)(76116006)(38070700009)(36756003)(31696002)(86362001)(31686004)(533714008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UGtVSHhIRDVEbG5oak1rOWdLSENvd1NqOWx5VEZQRnpHMEpWd0h1Wk1vMUlX?=
 =?utf-8?B?dUtQblBOVEJQcTFSQXVic0lGTzVDZHM3Sm9XZXI3QmJMTm9DM1dMczhZTTQ0?=
 =?utf-8?B?M0hPQTBSMnJYT0JVRDNObFA0Qmk0YzFQaXg3WnlGOFZub1Q5NThjK3laZGh2?=
 =?utf-8?B?VTlaZlplOTBicjE3YkxJMTVyaGlIV0lLWjZVWmNOY0kxY05GUlZKTWJ5SWJ6?=
 =?utf-8?B?S1E2eGdRMXZnSzVBUmRhV0JGRE54a1VHbUd4VzdqeUZ6WTUxL0FQaDFyVmhN?=
 =?utf-8?B?MFdhUnh2cDA1R3g1VmhWUS9WWUp0Y1hlMFd4YkdMdkhhVzJlajVnenNsRGNQ?=
 =?utf-8?B?aFFHWjdnMzRPdFRvaktXS3dPZUU2Y1pKY3FxVTZKRG1kc05uWjNmTUd4cnZL?=
 =?utf-8?B?NkQ4NnJvWnJWODd3NTFUYmE5UHlGa2l1eTc1M01Ja0g4ZHJhbEp0OW13ZmhK?=
 =?utf-8?B?UHJXT3FMU2FvLzJBZVdWelNYY3VBL2FKMFRoeEExa3RGODFEM0RGQkR4YXo1?=
 =?utf-8?B?SkdmcEs5SFBxc0ZJRWxEaXlOS1FXN09PMndpZ3RjaDZaUS9Oc210UmVzNHVr?=
 =?utf-8?B?c1FQblAxMXB3NUFQWFJtdUhYYzFaaU1qdTZETUxjQTNmZXE0NEZQb1JOOU1k?=
 =?utf-8?B?eXZXR09POWtBUTBCaHZTWFdQVk5FZ0RBdVFFdXZVQ2k0eUNrZTVPZ0lEWnAz?=
 =?utf-8?B?bDgzWGEzRldZUE05Sjl5SGIvdXYxT1U4bXZTa0U5ay9DcmNWbXFoSm5tUzlP?=
 =?utf-8?B?SnlidzhkSjRwandYVEVJUEZ1OEpvbTZXeitBWFpUV01PWTlweWR3N3MvSkk4?=
 =?utf-8?B?amY5T2VqdDJqSXphUXBvZlJHZk05ZDZrbDRabUN0RnUyWWI3eUtVZW83U2lB?=
 =?utf-8?B?cTNaTERHZkN5QVFSTG5CTWpBcnNSWEJuUGZSSStWbGRhZWg3aUphczczYjBX?=
 =?utf-8?B?LzJpb0c5Qnd4VExaMS9JaTVaN0ZscHptTTk4dmlKa0tnRys4ZThURFRYcitn?=
 =?utf-8?B?OXkrRVMrSzdpMlgrOG1kUUovNS9majVuZVFUOEMxMkx2UHBOTDFqblJsNnRv?=
 =?utf-8?B?VjBJVnZucDN4ZThyL2JTWmpVWE0xb2tQNFdtbWRGQTFCMlFUQW5sMjNMMlZw?=
 =?utf-8?B?aysyYkJlUFcwQXdEUE5XZ0tPMUwwdVdpeEptY3VkVjJWRzBwcHh5cGYrcmwv?=
 =?utf-8?B?Z3dPWENyQTZ5T0M2MzJIcGJaaVFYeUJ4bjA1UHhVRVY1RklqN3E1VzFqaHgy?=
 =?utf-8?B?WjJjdHhYd3RhSVpmL0ZSWmk4VE1WQlI0czRPb0prTVRZS1IybkprR1Z1SzlK?=
 =?utf-8?B?SjdYTG5nT2JqdFpuSmNicnJJOWZudjJOYWpDOWhmY0pVbzg1bkEyL2JrelU0?=
 =?utf-8?B?Z3hBa1JSaWxoSWZGRkFxb2czTThkN0h3K0RjRFJwU3ZFMDBmemFhdjV4aTBM?=
 =?utf-8?B?WTh4QUljL2VmeENmOVJtS2paWHp2OWlRaGZXSlFmTlc1eEl0OXNibTBObGZx?=
 =?utf-8?B?MFdIWTdwRlcyaFpJaGJORFdaVlA2d0FIb0ZzOEltSXkza2oyNmtXWWpucXho?=
 =?utf-8?B?RDRYVWhuUFpFc3ZkTmpxOHlwYWZSQkIxOFgxNkJiL2xhSUk5cUdrWTJJeUc3?=
 =?utf-8?B?c1IwWmFlNWtRdVhXN01wOTJ0akdsM0pEbTZRNVRKdFphZHUvbGIwYVRLdEp0?=
 =?utf-8?B?dHhLNjhZOHduNk90YXB4M1JtTE83K2JhUTRkbHhlUHR1QkU3UmZGMklSQXJ3?=
 =?utf-8?B?QUpiNDRZZlJoVWxGN3dBaFBIaFV1b05VbG0ycWpiZXZHbHl1L0NjUGU3cWtv?=
 =?utf-8?B?L0tVWmZkRk84aW5jSFpQbFJ6Q0Uya0JXMTFzTXFzTGtCaVByWVk4ak1uYlVw?=
 =?utf-8?B?aE1jNVhKNWxtQVZ3SDRTQmtlbDAzbUQxd2l0RkpaMHcyT0YwWE91dEhXSE0z?=
 =?utf-8?B?d2w0VGlQbTMrSDJmeWVXMGY3NlhOVERCUmZnUWlUSVlqSXhlRXpFTy92bG94?=
 =?utf-8?B?MEI5Mk9FWjJCNEtlRjJ4aCt5dGlUbTZ3Q2FXSFpCSEV6M2sxcmdvd3B3VXA3?=
 =?utf-8?B?MEk4MHBTL2FjczdpMGJ5L2FaVjNyWTRaaFNSb1JWTHY5djV3aTRWZUQyRmxp?=
 =?utf-8?B?RWdZZWFGOFZOeUlMMFNMa3VIUmhUeEtqS0EzMitCV1YwRFVZUyt3c1pLQ0dq?=
 =?utf-8?Q?Y0MCBLSWtXE2+okvBHbmCGydYOC/qeWWq7FNSQTdo7uR?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6C33D43456FB3849BED71B3ECA0B40F6@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c81c71d-ee29-4653-6726-08dc115e84c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2024 22:01:23.0932
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Re7tKCw09cqAT5FAf76hiRW0VTO8KMK8QIoCFvJ/N9msmX8WuEI/h7qmRh1kXwTUQfFzUnSZXzCesf+KaGsMMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8032

T24gMS85LzIwMjQgMTozMSBQTSwgQmFydCBWYW4gQXNzY2hlIHdyb3RlOg0KPiBPbiAxLzgvMjQg
MjI6MzAsIENoYWl0YW55YSBLdWxrYXJuaSB3cm90ZToNCj4+IDUuIFBvdGVudGlhbGx5IGFkZGlu
ZyBWTSBzdXBwb3J0IGluIHRoZSBibGt0ZXN0cy4NCj4gDQo+IFdoYXQgaXMgIlZNIHN1cHBvcnQi
PyBJJ20gcnVubmluZyBibGt0ZXN0cyBpbiBhIFZNIGFsbCB0aGUgdGltZSBzaW5jZQ0KPiB0aGlz
IHRlc3Qgc3VpdGUgd2FzIGludHJvZHVjZWQuDQo+IA0KPiBCYXJ0Lg0KDQpBbiBhYmlsaXR5IHRv
IHN0YXJ0LCBzdG9wLCBzdXNwZW5kLCBpc3N1ZSBjb21tYW5kcyB0byB2bSwgcmVjZW50DQpwYXRj
aHNldCBhc3luYyBzaHV0ZG93biBvbiBsaW51eC1udm1lIGxpc3QgaXMgb25lIG9mIHRoZSBleGFt
cGxlIHdoeSB3ZQ0KbWF5IG5lZWQgdGhpcyBmZWF0dXJlLCBzZWUgWzFdLg0KDQotY2sNCg0KWzFd
DQoNCmh0dHBzOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9waXBlcm1haWwvbGludXgtbnZtZS8yMDI0
LUphbnVhci8wNDQxMzUuaHRtbA0KDQoNCg==

