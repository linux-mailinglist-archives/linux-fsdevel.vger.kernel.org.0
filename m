Return-Path: <linux-fsdevel+bounces-7585-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E23827EC9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 07:31:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3D641C23492
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 06:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61CEE8F4F;
	Tue,  9 Jan 2024 06:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qMACCt25"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17603630;
	Tue,  9 Jan 2024 06:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mP8KiYB13ODsF4oNqdX5USGwpFKF+nGpP1E0uAlAmkeHvabgr3/3jWu6p/sIrxsAjRWyzKL+fNfKFkO+jBxZU7frtXLw1Ck85NMcvEokr3bU0m4VYGmSGWgpCaPEkDcvYxTNhaWMZlSCkEtrK39dySD2oBiUqvt1aOys19+20wX5YSfzU6qDIfL3mmZXnjKuC3B3kMBGOnTMqheQ2a9utMTx4UOqvx/2ig2RP9qZNmysN5EFPtF2fQU5a/gXTzCXv0IcSXGYzqhH0znUyBz8Yxy8UCQgiaIt8Vj1RqUFUyeyWjkdKL5JlmknqjLNsLnumv89RuBUYZj/LhT0PBFCMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=doiQl1NByxS3Ylouw1J+xiZY7f6hZmFtz6BUdcUJ4HE=;
 b=cgLyVADMtni5WB66vSkjLxaL1PoC9IyUZ6luNQywgrmCCiEKUYp0iXOoTDxLyN8w3weEpZMeY9rUOQyf9y8DL8HnpN24uDJJAcGWU/9N/j8ekhML3AHRgOXb/0lsK7NW1zRohUFatTJljDDNpyb6IU/O3J7KDxaGv5gimp3zi8rVq0QyHikrLmMfXJnbrUnsmUdmW4C3IPEaUWhinfHtGD+Cbjib2GoyuWSKYLk4GrfFfFI+dXLckiC92yTYxmuGxGNKN5UxjfMze39RvVZTdM+ykW2ItIoBGFDnWTsdVInLgt0hiCbbGlkLob83DujYkfgt7pF0gF4gcrJ5SfJFjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=doiQl1NByxS3Ylouw1J+xiZY7f6hZmFtz6BUdcUJ4HE=;
 b=qMACCt25RsrNAevwjigiJ+Z3uqGP88mTXdYQZRb1TmHm2zVyyzpZX1YY/SrutlSk9kRLW8ocfxKRxwRS6rCxBZUynh3vF3vNX7IUnk/H4BlgCsQOxM/PfbHnQd3NmJvyNSYVISjf1SX2FMHUZDKZjZ0kdhnt1t0x36iio4Ik6MLuirFOOc0GCYdecNmPvjjr9hkoUMuY5T4Uf3Du3mCprM443/17os7scSqTomZHGB7+dpiUmU8R1pwSBNino6cGd8XCZBkQg4/2F6xLTbRN+Btou6vVfwEDKRTgof03Iwg66XLH9qTjzxM8xDxokvBvxUXlGGkt9HvdJ5421Oq6SQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by MW4PR12MB7438.namprd12.prod.outlook.com (2603:10b6:303:219::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.18; Tue, 9 Jan
 2024 06:30:46 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::efb1:c686:d73d:2762]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::efb1:c686:d73d:2762%7]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 06:30:46 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
	"linux-fsdevel@vger.kernel.org >> linux-fsdevel"
	<linux-fsdevel@vger.kernel.org>, "linux-scsi@vger.kernel.org"
	<linux-scsi@vger.kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>
CC: Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>, Amir Goldstein
	<amir73il@gmail.com>, =?utf-8?B?SmF2aWVyIEdvbnrDoWxleg==?=
	<javier@javigon.com>, Dan Williams <dan.j.williams@intel.com>, Christoph
 Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Hannes Reinecke
	<hare@suse.de>, Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	"shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>, Johannes
 Thumshirn <Johannes.Thumshirn@wdc.com>, "jack@suse.com" <jack@suse.com>, Ming
 Lei <ming.lei@redhat.com>, Sagi Grimberg <sagi@grimberg.me>, Theodore Ts'o
	<tytso@mit.edu>, "daniel@iogearbox.net" <daniel@iogearbox.net>, Daniel Wagner
	<dwagner@suse.de>
Subject: [LSF/MM/BPF ATTEND][LSF/MM/BPF TOPIC] : blktests: status, expansion
 plan for the storage stack test framework
Thread-Topic: [LSF/MM/BPF ATTEND][LSF/MM/BPF TOPIC] : blktests: status,
 expansion plan for the storage stack test framework
Thread-Index: AQHaQsVgpvNy+8eAm0+o13nS3IUzaQ==
Date: Tue, 9 Jan 2024 06:30:46 +0000
Message-ID: <e5d8cd68-b3f2-4d7b-b323-b13d18199256@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|MW4PR12MB7438:EE_
x-ms-office365-filtering-correlation-id: 1d1c0124-59f3-40a9-1d03-08dc10dc8360
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 lsyOJepQaPmIM4nhr9pbg2a1+S6jtF+k+EUKpU0XlW0I4nezrgpbWqIlC5EZIsz/8xGIiQUyHPwz0dBKsjC7lg6tn70951UpnvLXQQfYlNdXQcRE3KtsE+YfJ9USbbTGZodUBrCb29QlXih66MUbl4pD4DFxZB0Q2J2+V3fzIArcEZwdpYlNJ2NfzpwLSrGJN295+xgR03NCByniDLfe0G1EHv0cwZGcah9ydjZ+5oG26LczYvmNwZsqFBcQeMH4SLY8hEziT8QNR4eMQwsdeuMMFmSlKRqVpLuUMxAJ3po2npku8kx05ECJOHugVv6wdmMyW+qV0qz9l6eGVjTA/CAtTpenlj74vwsLrIDJ4ntEoUBOUKS2TXranITQbutEjTerwiusHs0eXVKjKXnFt7WUKKm1pANvqm0K0fyWkS5KzSUyNgHxbAzgvWCwXK2U9hYR8C9yJ9wkpc13kCKXKpGa4qTS+AHHnsSV7LXhwyLP+9W267IYm/bUtaGUaOzQ5xH/A1TyQtYapUPfOHW91zUiracTzKB6NfbTygIdxN4azqvG12KvIYTv7GO+gSJqwYQZzy+w/o0PvrINDGBCdd0lJ7TnNRLHJwKaNt7wdLTGPRJvMDS8WyU53ewCKQD0rCbpqCLyxoIaZWuBQsWqZRLnU8qP7X5647ODq08MNsYWW0NNe/GUS5a8WItC1tuyXRDF0ceY0YyVv0QTL9GvmGb6IpjF79C0zExiVUAhKBo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(376002)(346002)(136003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(71200400001)(478600001)(966005)(6506007)(6512007)(26005)(2616005)(83380400001)(76116006)(66946007)(41300700001)(122000001)(66476007)(66556008)(36756003)(2906002)(7416002)(38100700002)(110136005)(316002)(8936002)(31686004)(66446008)(8676002)(5660300002)(54906003)(64756008)(91956017)(4326008)(38070700009)(6486002)(31696002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NElaUWoyTUUyZTdvR2tGQjV1ajNtS1M4NVdhclFLRmhsWHJJbXA2cURmUHY2?=
 =?utf-8?B?VnFreE1kYk1kbTU5clJ5QWc4NTk2TjJBU296ak0xQ2Y2NFcrc01jQXBRNW5W?=
 =?utf-8?B?WkcwT2VnT0JXcDdpTUxjK2xQUUZPV3FHZXltaGtlTTUzNUVOdkljSXRwRnJM?=
 =?utf-8?B?RTJ0K1ZDZHRXMko5UXNhY3BoU0VEOUQvTXhiOUk4U3RZRUk1eHpuNzl0QTNv?=
 =?utf-8?B?elE5eWFTQ0RQWWdLalBSTHFIRTg3MnhvWXc4bGd2cnQwMWRBNUprY2k1SExm?=
 =?utf-8?B?SzBBemhwa3pRM3o5SUFCeXRnVGFKbnJudTN2djBPNE9CeXVrbkRPa1RPbStQ?=
 =?utf-8?B?Z2VycjVTVjV1Tm5rRjUvSzlzR0VjYlE1MnNkczJVUm1OaUNLeWNURUZsWXdz?=
 =?utf-8?B?ZXd3TVNReU1VU3ZxL1RCQjY3U0psdlFoZ3BJaHlRb2dtZU9QYngzaURRTTM3?=
 =?utf-8?B?NGJkZVV6MWJqTzFzK2t3TWRtelJmMGdmQUlrUXVNb1ZwaUZyZ1pYaml3VERV?=
 =?utf-8?B?ek5qQWhIL0lUSkx0eElERzcvOUw0bUtNSm1LSVEzRVlRUWpKSU1uTU1Lb2tn?=
 =?utf-8?B?K0F2amhLR0h6dFJEN2hQVTh3SnlFbkNYUlJOQkRNYWNWTDdzRVZ6UjdqRzNm?=
 =?utf-8?B?SjIvYmpXNC9KbUZuaFh0d3dPNWJIODRkOW52THZtTFRkUXFIVitINmlHa2d2?=
 =?utf-8?B?bi9zelYyMkViTEJWVUd3V3Jtd1BEbGRIekdteVRWSjFhTU44UWJWa3N2Rnc4?=
 =?utf-8?B?ZGMzY1RBbDc3cmsyMU54S1JMWk1kYWVtdmFzQnp6Q3d4RWc2R0tFbnNycFpP?=
 =?utf-8?B?WnYvUWVLSHFibmFYd2Y3RzBlUmdHck1tZkZTelhmSGRCMWZnSzFROUdGTnJN?=
 =?utf-8?B?cExpMmNxelI1TXZLeTEvb1M3bkRPWHR4SHZMTG9yeHl0dW5nc0F2MHpuQ1pq?=
 =?utf-8?B?alRGZEFvci83KzdWMnpSOUowMTJIeGVsTG9Lc3Vra2xKRCtlNW5BV3ZRUHNo?=
 =?utf-8?B?UkthK2lnZlNDRCtvNXNrOWdVQ0pickp3UitMMTV4VUZweGUzcXRLemVEcEt6?=
 =?utf-8?B?ZEw5RWhsT1JtZ29heVY3MVZVY0lNL1J1b3N6aHg0cEYxVUs5aGp5WjZ5UTNF?=
 =?utf-8?B?QUFod3lBVlhLbUsxeUZJMldBQ3Y2eXdSNXVTL2NDV3VmOWRyN2p5RUdPc3pt?=
 =?utf-8?B?YXlaUlloSkRoT0lzVEEzK2RPSHd5aHFBM3lHWFZRSnBkQmlSRkdHbGNZa1Nw?=
 =?utf-8?B?K2VLemR3S3N3U2ZMcTBtcEwwUnljUWN0MEp6eWlzT3d0Vzlna3JlSE9acjgx?=
 =?utf-8?B?SDh3WjlkNk1obGduQUVnNzJsK3ZKNlZDekJCZWNEd0xiNEhEYmxON0lwZzcv?=
 =?utf-8?B?dHRiMFdHUkdhYWtaMk5yUHhTVXpaalRkYjM0ZFRWNDhVanhGNDZoNFFoSFB2?=
 =?utf-8?B?bkVVZnFzbThBVHdZeFdmbUpRNElRLzF0aXN6cWwzeTgrRUJMUmlQNHhpZExF?=
 =?utf-8?B?amJRUG96SnNtNUFWUG5aWm1TTFM4dElNeUFZREgvR1hTbjcyQk84WVFZMWUw?=
 =?utf-8?B?bWtFV21wc3M3Uzk3NkU4U1BrbW83K3hYZndRS0ZxRXJ3RVFhUTVBakNSTCtZ?=
 =?utf-8?B?NjI1Rmloc210S0F4ejB4VHpqU1QrSFJiYTRpdkZEbDVJQ1NhWGFaNGhMckRP?=
 =?utf-8?B?d3hNS2dabzVsbDltd3I4dytVUWxnaFNlMW9aVk9LbktDUzliaXFMbDFWSmhk?=
 =?utf-8?B?VDlwTDd3cVRYN0IvckU1VDFsRVYrUDNUSk41YlFVZlFDckJmaHMwZkp4Z0tw?=
 =?utf-8?B?TjlKaXI5S3VSTjZ2clNhdmhVdy9Ta2l4M1ZpSXp2SlREaHZDeWFuVVZ2MlJI?=
 =?utf-8?B?dm5VT2hCa0JjMGg0VFdsUURIRitxQWdoN2RyNExrWjBIZHdOeEtQdWFWdTZW?=
 =?utf-8?B?UWxNb0J3REpuRjdYYnlGdlIwYjFxZ0oyUXNKUzhPZXIzTXY4K2p1WjlCRnZL?=
 =?utf-8?B?RkJHK0M4RlV5ZzlLYVZaVng5bTRJMlVqQ2JGaUx4WlluaDIvVW41R1RSMnFT?=
 =?utf-8?B?N3NMaWRFYlNDRHlPQUpnWTgwWE05ZkNrQU5NYVMvSmlkWU1NQlNmUWdMa2c4?=
 =?utf-8?Q?9MYd+pHxhumAxLJec8KreMBWv?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <82357E54214F9A45B2D5F10F1874334C@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d1c0124-59f3-40a9-1d03-08dc10dc8360
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2024 06:30:46.2553
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gtP38T6GTMQPL9QxvVRi70tYzWEvti1vCX351zkE2fLO0F1/bBBDxuc9dP/iUMEnlgjRnpbLXeqbmQ1ufd/8lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7438

SGksDQoNClNpbmNlIGRpc2N1c3Npb24gb2YgdGhlIHN0b3JhZ2Ugc3RhY2sgYW5kIGRldmljZSBk
cml2ZXIgYXQgdGhlDQpMU0ZNTSAyMDE3IChodHRwczovL2x3bi5uZXQvQXJ0aWNsZXMvNzE3Njk5
LyksIE9tYXIgU2FuZG92YWwgaW50cm9kdWNlZA0KYSBuZXcgZnJhbWV3b3JrICJibGt0ZXN0cyIg
ZGVkaWNhdGVkIGZvciBMaW51eCBLZXJuZWwgQmxvY2sgbGF5ZXINCnRlc3RpbmcgdGhhdCBpcyBt
YWludGFpbmVkIGJ5IFNoaW5pY2hpcm8gS2F3YXNha2kgOi0NCg0KaHR0cHM6Ly9sd24ubmV0L0Fy
dGljbGVzLzcyMjc4NS8NCmh0dHBzOi8vZ2l0aHViLmNvbS9vc2FuZG92L2Jsa3Rlc3RzDQoNCkFz
IExpbnV4IEtlcm5lbCBCbG9jayBsYXllciBpcyBjZW50cmFsIHRvIHRoZSB2YXJpb3VzIGZpbGUg
c3lzdGVtcyBhbmQNCnVuZGVybHlpbmcgbG93LWxldmVsIGRldmljZSBkcml2ZXJzIGl0IGlzIGlt
cG9ydGFudCB0byBoYXZlIGEgY2VudHJhbGl6ZWQNCnRlc3RpbmcgZnJhbWV3b3JrIGFuZCBtYWtl
IHN1cmUgaXQgZ3Jvd3Mgd2l0aCB0aGUgbGF0ZXN0IGJsb2NrIGxheWVyDQpjaGFuZ2VzIHdoaWNo
IGFyZSBiZWluZyBhZGRlZCBiYXNlZCBvbiB0aGUgZGlmZmVyZW50IGRldmljZSBmZWF0dXJlcyBm
cm9tDQpkaWZmZXJlbnQgZGV2aWNlIHR5cGVzIChlLmcuIE5WTWUgZGV2aWNlcyB3aXRoIFpvbmVk
IE5hbWVzcGFjZSBzdXBwb3J0KS4NCg0KU2luY2UgdGhlbiBibGt0ZXN0cyBoYXMgZ3Jvd24gYW5k
IGJlY2FtZSBnby10byBmcmFtZXdvcmsgd2hlcmUgd2UgaGF2ZQ0KaW50ZWdyYXRlZCBkaWZmZXJl
bnQgc3RhbmQtYWxvbmUgdGVzdCBzdWl0ZXMgbGlrZSBTUlAtdGVzdHMsIE5WTUZURVNUUywNCk5W
TWUgTXVsdGlwYXRoIHRlc3RzLCB6b25lIGJsb2NrIGRldmljZSB0ZXN0cywgaW50byBvbmUgY2Vu
dHJhbA0KZnJhbWV3b3JrLCB3aGljaCBoYXMgbWFkZSBhbiBvdmVyYWxsIGJsb2NrIGxheWVyIHRl
c3RpbmcgYW5kIGRldmVsb3BtZW50DQptdWNoIGVhc2llciB0aGFuIGhhdmluZyB0byBjb25maWd1
cmUgYW5kIGV4ZWN1dGUgZGlmZmVyZW50IHRlc3QgY2FzZXMNCmZvciBlYWNoIGtlcm5lbCByZWxl
YXNlIGZvciBkaWZmZXJlbnQgc3Vic3lzdGVtcyBzdWNoIGFzIEZTLCBOVk1lLCBab25lDQpCbG9j
ayBkZXZpY2VzLCBldGMpLg0KDQpIZXJlIGlzIHRoZSBsaXN0IG9mIHRoZSBleGlzdGluZyB0ZXN0
IGNhdGVnb3JpZXM6LQ0KDQpibG9jayA6IDMyDQpkbcKgwqDCoCA6IDENCmxvb3DCoCA6IDkNCm5i
ZMKgwqAgOiA0DQpudm1lwqAgOiA0OQ0Kc2NzacKgIDogNg0Kc3JwwqDCoCA6IDE1DQp1YmxrwqAg
OiA2DQp6YmTCoMKgIDogMTANCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCjkgQ2F0ZWdvcmllc8KgwqDCoMKgIDoxNDcgVGVz
dHMNCg0KVGhpcyBwcm9qZWN0IGhhcyBnYXRoZXJlZCBtdWNoIGF0dGVudGlvbiBhbmQgc3RvcmFn
ZSBzdGFjayBjb21tdW5pdHkgaXMNCmFjdGl2ZWx5IHBhcnRpY2lwYXRpbmcgYW5kIGFkZGluZyBu
ZXcgdGVzdCBjYXNlcyB3aXRoIGRpZmZlcmVudA0KY2F0ZWdvcmllcyB0byB0aGUgZnJhbWV3b3Jr
Lg0KDQpTaW5jZSBhZGRpdGlvbiBvZiB0aGlzIGZyYW1ld29yayB3ZSBhcmUgY29uc2lzdGVudGx5
IGZpbmRpbmcgYnVncw0KcHJvYWN0aXZlbHkgd2l0aCB0aGUgaGVscCBvZiBibGt0ZXN0cyB0ZXN0
Y2FzZXMuDQoNCkZvciBzdG9yYWdlIHRyYWNrLCBJIHdvdWxkIGxpa2UgdG8gcHJvcG9zZSBhIHNl
c3Npb24gZGVkaWNhdGVkIHRvDQpibGt0ZXN0cy4gSXQgaXMgYSBncmVhdCBvcHBvcnR1bml0eSBm
b3IgdGhlIHN0b3JhZ2UgZGV2ZWxvcGVycyB0byBnYXRoZXINCmFuZCBoYXZlIGEgZGlzY3Vzc2lv
biBhYm91dDotDQoNCjEuIEN1cnJlbnQgc3RhdHVzIG9mIHRoZSBibGt0ZXN0cyBmcmFtZXdvcmsu
DQoyLiBBbnkgbmV3L21pc3NpbmcgZmVhdHVyZXMgdGhhdCB3ZSB3YW50IHRvIGFkZCBpbiB0aGUg
YmxrdGVzdHMuDQozLiBBbnkgbmV3IGtlcm5lbCBmZWF0dXJlcyB0aGF0IGNvdWxkIGJlIHVzZWQg
dG8gbWFrZSB0ZXN0aW5nIGVhc2llcj8NCjQuIERNL01EIFRlc3RjYXNlcy4NCjUuIFBvdGVudGlh
bGx5IGFkZGluZyBWTSBzdXBwb3J0IGluIHRoZSBibGt0ZXN0cy4NCg0KRS5nLiBJbXBsZW1lbnRp
bmcgbmV3IGZlYXR1cmVzIGluIHRoZSBudWxsX2Jsay5jIGluIG9yZGVyIHRvIGhhdmUgZGV2aWNl
DQppbmRlcGVuZGVudCBjb21wbGV0ZSB0ZXN0IGNvdmVyYWdlLiAoZS5nLiBhZGRpbmcgZGlzY2Fy
ZCBjb21tYW5kIGZvcg0KbnVsbF9ibGsgb3IgYW55IG90aGVyIHNwZWNpZmljIFJFUV9PUCkuIERp
c2N1c3Npb24gYWJvdXQgaGF2aW5nIGFueSBuZXcNCnRyYWNlcG9pbnQgZXZlbnRzIGluIHRoZSBi
bG9jayBsYXllci4NCg0KQW55IG5ldyB0ZXN0IGNhc2VzL2NhdGVnb3JpZXMgd2hpY2ggYXJlIGxh
Y2tpbmcgaW4gdGhlIGJsa3Rlc3RzDQpmcmFtZXdvcmsuDQoNClJlcXVpcmVkIGF0dGVuZGVlcyA6
LQ0KDQpTaGluaWNoaXJvIEthd2FzYWtpDQpEYW1pZW4gTGUgTW9hbA0KRGFuaWVsIFdhbmdlcg0K
SGFubmVzIFJlaW5lY2tlDQoNCi1jaw0KDQoNCg==

