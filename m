Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC80A7406A3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 00:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbjF0Wue (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 18:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjF0Wuc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 18:50:32 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEAB426B3;
        Tue, 27 Jun 2023 15:50:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DYNlRsL+9CijMSvXt6e4GYTGtObY3Tzib+tPmCjsfLZH0z7qIzD8RHedNlkNP6h6jplxWie7ylG3Ry3IBzQau+yxb6vJWpi427QVJfI8RG8naSTDJeQE5pkZCeJcLatolfHpQjKDFLpHfo5V+Dk8bgoD7++8yu1QSV3txDzMeBx2sHVKwDZMYwbV9AInP0C/4vxKxnGz3Fea75Z2i8jGQahHAiWg9E62Xunv55Xo7qtLkPJIN7i1FfuLBO03UsewcbQJXtj98m0FkvFMEwc5KRIrvXADvIl7uh/TcE1UIkzaT+IpS7+QzCbpCJa6FP1owgFeJf2F6PLgxd0KbkTvfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m0xy0ko7wUqCRVQHUEFCzLdKZxjAZXd4y84HUM7fo8M=;
 b=Y1WFRJ287gVidWOMTtQ7+xMyncRrWviV/EwVRvHXcYhf55j00eP3UlYa7E2Ni691qlyikOstVsGFpXWzspCFaCSARsLO2BK+Com7WJTL2SSp6h/e4U7f+7LumQrPruoahgylD8Nhf7dE5ADRd5Q77ac7MlQKRe5ZAMuPWkV0qPMMwK6eB5sYMP49XRRAUdUf0yN2+BQRSHHkxAC+ny5rl0BAAEGEXxbcK/BY1GKkboHw5uaDvrzcDbyC9W9GJMwvnwPinAGW652T3PB3CMUgdeJafCe2JrHS1DO/y3lT7oYcHNN6a9R3hMw3MezkyyKeqsdWunpaL300OqXlFt2utA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m0xy0ko7wUqCRVQHUEFCzLdKZxjAZXd4y84HUM7fo8M=;
 b=L2cS82VZhZmftv0OHiz/77dyANRbIe4KGRIdCftxhR7AYNNA+mDsjRFy9sVU2//VsCkQaOqCO2bx27oaFYQTLZFLDMat1+Mgmme0Th94Bsr5ELvgrVJwKDYplH3Xw+Q1wl5EoydmJgrx/1PfpC0X5B8OpxIhpwiv8x7lrzcefNM/Owa0JMcf0uTHvyxoDX2VItim2jQNzr/epymMxeEhK8NVUC58+69zX7NjYhcPW2VfI66cVE3W1/fZvjQH8a5VpC9oRuiJc8qYcyrgscr7s2gRN8IRCibOVitz/BIutRXvF3AZBz/ydlSWOBJlEjwnGY7sx/iz3c6BWKK6rdAzJA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MN2PR12MB4333.namprd12.prod.outlook.com (2603:10b6:208:1d3::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Tue, 27 Jun
 2023 22:50:25 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::92c6:4b21:586d:dabc]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::92c6:4b21:586d:dabc%4]) with mapi id 15.20.6521.024; Tue, 27 Jun 2023
 22:50:25 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Lu Hongfei <luhongfei@vivo.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        "opensource.kernel@vivo.com" <opensource.kernel@vivo.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] fs: iomap: Change the type of blocksize from 'int' to
 'unsigned int' in iomap_file_buffered_write_punch_delalloc
Thread-Topic: [PATCH] fs: iomap: Change the type of blocksize from 'int' to
 'unsigned int' in iomap_file_buffered_write_punch_delalloc
Thread-Index: AQHZqN8x8d8w79yS0kWj3Bz681z1u6+fQceA
Date:   Tue, 27 Jun 2023 22:50:25 +0000
Message-ID: <df06d21b-9ae2-1e07-53f9-152eb2966bb9@nvidia.com>
References: <20230627100325.51290-1-luhongfei@vivo.com>
In-Reply-To: <20230627100325.51290-1-luhongfei@vivo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|MN2PR12MB4333:EE_
x-ms-office365-filtering-correlation-id: 182ef9b8-54de-482d-6ae9-08db7760e5c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fT3MA5e/RUk5RXIPBngxJdKpbOMkfcDvq4upxNYcHoQ/jQFW/i73wlHq4ZNcINhKK+6DoQSjrdC7tbJE1FFnTvmUKKIIleHc6+QyPD8UARTWDzT5GJgoS2GaGh1KbejHl6KP+EA8UTwtRIOg4DNxIiohUqv+dwQFS7+yE+FLyL5rwH/muyjZB8/MuR8A15GnfoPAFqM+tz3f/FnH/+5ApcWAieWZCEJ76LeYkuR6IjsBXCS3S/fSEVUxTOixhI2AvIGLmLTM3U3vvDR1G+61f7mpFLeDgbG7SehiYeVF9jwf3d90PBYwRyjlBMtQuWBPzyhN5GrzIUZcpLFiH86bPS3lAeBg2+g8a/ThmnrBR9uYmlk/iFxAJyiZVIOtLJuiUaUrlVrW5aDi84BP8fKab8TmPMbWzaxE1XD7edBiAyTjYpIES2lEZW/axnBZKTrInKjzUixfOv0Ii6J7lt7JVAhUvNtpHaY6kprIXeNO3rTQLX8E2bkBAFhPxW1Z47rmZeKcXuMI50LCKcc74eW2v5d7aaWgo1S1VdJCsn+kkRtkpKQ7kPELD3SBiSrdDxzk3FOsn4EH+AlYnY6yJsGi/7BD4GLwGb18z8ySFu/ygxJEb+GYDwyMTdzrDCJcvfKZX+DEPHTscalpdVEmYou+g9FWHSuCcsZ0ZIslMhZ1A1AY0Y15X8qX3YH6Bc3tpQt3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(396003)(136003)(376002)(366004)(451199021)(31686004)(36756003)(6506007)(122000001)(76116006)(66476007)(5660300002)(316002)(86362001)(64756008)(6916009)(4326008)(8936002)(31696002)(66446008)(38070700005)(66556008)(38100700002)(41300700001)(66946007)(8676002)(91956017)(6486002)(6512007)(2906002)(53546011)(4744005)(186003)(71200400001)(478600001)(83380400001)(2616005)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MW4wUW9DZStiYmVNdys3aU5MRUNBdnBvS2U5SWltUjU0aWp3NVlIODEvbm45?=
 =?utf-8?B?RWluNUZxbEkzSmZTY3lXZkJOODM0dVNXT3Y2YmRHY0dJRWx1OXpmdzU4TFJh?=
 =?utf-8?B?cjdnaTUwMkhIQ2cvUHoyVnNvNjFEWFZNMXVLZzhTcW1EZFlnVE4za3JaNVlu?=
 =?utf-8?B?R0dCVTlHbHUrcHNQZFQ1elB1aXdGNkd2ZDIzVWJIdTVtdDRmblVtS1g5bm1u?=
 =?utf-8?B?aE50eFhGaEtsM2h6Ykc3WXQvWEJIZ1YwTWtDVG90ZTMxZGFWNGREeEl6MnB0?=
 =?utf-8?B?a1pidFVPRTdmK3ppcTk1YnlLeVFweExHUTNGWXkzUnFQRE45WHFzZGFwb3NB?=
 =?utf-8?B?RUxsbEdWTVpHVTBEYjhTVDdyYkxJd0lTOHhuUXB5K1kzZHRUSWVFeHVMM2dD?=
 =?utf-8?B?N1o0TndnN3R5VVoxSEtROURxVkwvOEVuQUFXcHFvNEpXRndKQjhwcWJuTzBa?=
 =?utf-8?B?Q3c1bkdPVXVjcWF0KzFxanFob2E5Z2V3L3ViUmdOVEExaTFBNHJGUXY4N2Z3?=
 =?utf-8?B?NVpqOU1UbTFMNXUzVXBFNGRabnlPd1dEeGJDV251dk9EOTNwWE9CY3diVTNw?=
 =?utf-8?B?WWt4V0syUDRDaEdYN2tFdERzN3RsMFlnQ24zVE9aVjlxVzU5QVVsSzlvMFVO?=
 =?utf-8?B?cU9tMm1XT2I3WjlOVExwTjZwc0JCemVqckVsNHVDdHYxM2t4dko4QWVvbDRi?=
 =?utf-8?B?STE4ejMxcjljeHgyNUNuZmVnN29ORGU5YzExRndRZU1TWlExaHNiNEE1clFQ?=
 =?utf-8?B?S2djdkxDRWxlSlc3RnhUK0s0VjJrZ1RibHVoeXhWZXRGaWNodHNCTnRXeVNq?=
 =?utf-8?B?QSthQ3luOWlNR0Fta25tbThTeFc0R1lVNktZbmZqN1BTZnlhb1FyTE1VMVFH?=
 =?utf-8?B?MWxZRjFZdzVyNlNoZDh5RSsrWkVJUWUwZWx0VjdVVmF0cEF3QzE5S1JyQWNn?=
 =?utf-8?B?K29Vc2hZd0NrM2JvQ3EvYTVQVnFDNFcrTTVSdzdjUHRCTnZiOVg2Uk9HU3Bs?=
 =?utf-8?B?Q2FNZnZBdlgxQW5PREtncUhBb1B0bmtMV2xFNkhJQUliWDJKcEVSbmNrbTEy?=
 =?utf-8?B?cW5vRjc1VVJLQnBRS25yK1A3V1FUWFBaOXhuYkduVnhBSG95UFZ2ZkZvVVJB?=
 =?utf-8?B?ZFF6aVhMRGcyWVl0SmJWMUd1Z3kzK3NCNmFzWDNwUzZuN1pvTjhub252RmY4?=
 =?utf-8?B?ZFRqSEFFaUNxZElYY3REc2JIT25aNTdINlRBWURPdDF0NUtjTkNXTld2MytB?=
 =?utf-8?B?ZnZlYndHL0wzeUtRVmtNYjZUaTNGWE9CM3BncVBVUUJBRmVvVE9jZ3M2MW1I?=
 =?utf-8?B?bWRkUUp0MFBsVnNLS1ByK05VTFRGQVpKSVhHQVR4a3FYLzBFc0ZFbFRjd2dI?=
 =?utf-8?B?T1FkT3Y5MlZlR1Z5RzYxSHUxQXNXL3FicHVDR1RWd1BONzBXZFlWMXJBTHVG?=
 =?utf-8?B?T0lPZ2o4dHNBZ3c5RktNNlhWclZYaVp4a0NyRnlka1B6aS84dmdsVUxSdkJw?=
 =?utf-8?B?TnZyOHV2MEZ0dlBpUXRxWXo1bTlnc0dHRTZVU29BY0llZ3ViU21uVERkdHg1?=
 =?utf-8?B?TEkwdGRrMUtSNjdFMmlySktLZ2x5VEVzZzR6ZlovMmh4dWYrSWJNd1pQQlVS?=
 =?utf-8?B?ZURXaDVBclBTS041YXBSd2hOQThmeTQrcUhsY0FwKzF3YXNmNC96UmpEbG1J?=
 =?utf-8?B?bXVYdUM1MXBqT0ErUnhiNDRoSkk5Rjg0cXI4cENTNkI0ZERpQjdNNjlBRFMr?=
 =?utf-8?B?ZTNnQTJubVpydGtOTWt2TXJqTklNSmpZK2NJQVdaWXlMS3p1d09jaVRLZVFK?=
 =?utf-8?B?TjYwaXBIa0IwMGE3ZmVLaW96RENOeXEwbVRnWjhFWUhWMW96RkhUYUhTa0lP?=
 =?utf-8?B?SnduNE9Hcy9RZEUza1gwTjJxL3M5WEJ0ZFRRZUtyRDZEekNMeUt3WVFBNEtn?=
 =?utf-8?B?WSsvZ0tjcHZ5eEl5MlErZkJLOUlWOUhKL2szRUF3T25VcjhBQTFQOEVyMnNU?=
 =?utf-8?B?L0NXZEpNSnVYb2luUEN5eTc4OW9IVlVHbndxVkVSSzJnZWhIdmVZbWxNTjhR?=
 =?utf-8?B?Ui9tOHBYN1BYdWVYdVZnRi8rNlVvNlNYcmtvaGhGNVRyVUpQcmFmem8vYXBj?=
 =?utf-8?B?Qk83a2YrRzF6dzBLeE4zakY4UDlNbXVGaHR6YVpRTjFVWktYa0RIeWVLbXkx?=
 =?utf-8?Q?99Vs5sc2wtuJLl9/nNXsPYcXW8A32tVMVDiBwRmNsvyg?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CDACCC7EBD4C7A43A5F5E220F0D05F00@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 182ef9b8-54de-482d-6ae9-08db7760e5c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2023 22:50:25.7940
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H+Pm6MXp+/9GOfIy9CvLMsYjMe0O7LlYi2ge7s9/hEeaqSeeabUWHczgC05hOJ9pF8nex6pcGURhLnnRjlVD6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4333
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gNi8yNy8yMyAwMzowMywgTHUgSG9uZ2ZlaSB3cm90ZToNCj4gVGhlIHJldHVybiB2YWx1ZSB0
eXBlIG9mIGlfYmxvY2tzaXplKCkgaXMgJ3Vuc2lnbmVkIGludCcsIHNvIHRoZQ0KPiB0eXBlIG9m
IGJsb2Nrc2l6ZSBoYXMgYmVlbiBtb2RpZmllZCBmcm9tICdpbnQnIHRvICd1bnNpZ25lZCBpbnQn
DQo+IHRvIGVuc3VyZSBkYXRhIHR5cGUgY29uc2lzdGVuY3kuDQo+DQo+IFNpZ25lZC1vZmYtYnk6
IEx1IEhvbmdmZWkgPGx1aG9uZ2ZlaUB2aXZvLmNvbT4NCj4gLS0tDQo+ICAgZnMvaW9tYXAvYnVm
ZmVyZWQtaW8uYyB8IDIgKy0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEg
ZGVsZXRpb24oLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2ZzL2lvbWFwL2J1ZmZlcmVkLWlvLmMgYi9m
cy9pb21hcC9idWZmZXJlZC1pby5jDQo+IGluZGV4IGE0ZmE4MWFmNjBkOS4uOTBlYTllMDljMWFl
IDEwMDY0NA0KPiAtLS0gYS9mcy9pb21hcC9idWZmZXJlZC1pby5jDQo+ICsrKyBiL2ZzL2lvbWFw
L2J1ZmZlcmVkLWlvLmMNCj4gQEAgLTEwNzYsNyArMTA3Niw3IEBAIGludCBpb21hcF9maWxlX2J1
ZmZlcmVkX3dyaXRlX3B1bmNoX2RlbGFsbG9jKHN0cnVjdCBpbm9kZSAqaW5vZGUsDQo+ICAgew0K
PiAgIAlsb2ZmX3QJCQlzdGFydF9ieXRlOw0KPiAgIAlsb2ZmX3QJCQllbmRfYnl0ZTsNCj4gLQlp
bnQJCQlibG9ja3NpemUgPSBpX2Jsb2Nrc2l6ZShpbm9kZSk7DQo+ICsJdW5zaWduZWQgaW50CWJs
b2Nrc2l6ZSA9IGlfYmxvY2tzaXplKGlub2RlKTsNCj4gICANCj4gICAJaWYgKGlvbWFwLT50eXBl
ICE9IElPTUFQX0RFTEFMTE9DKQ0KPiAgIAkJcmV0dXJuIDA7DQoNCkluZGVlZCBhcyBwZXIgaW5j
bHVkZS9saW51eC9mcy5oOg0KNzE5IHN0YXRpYyBpbmxpbmUgdW5zaWduZWQgaW50IGlfYmxvY2tz
aXplKGNvbnN0IHN0cnVjdCBpbm9kZSAqbm9kZSkNCg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQt
Ynk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0KDQoNCg==
