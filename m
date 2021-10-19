Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECE0D432E61
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 08:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234297AbhJSGgt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Oct 2021 02:36:49 -0400
Received: from mail-mw2nam12on2079.outbound.protection.outlook.com ([40.107.244.79]:24961
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234255AbhJSGgq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Oct 2021 02:36:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H2rIFvBpBnq/amPnDVCRGflWSqb7iAURgEbStFSaG0gYsA9BqaIcbdgJimHxcRL8fg31csf+M9K/BVsT0mV4HGiGPvuupNdF1YCGEL5ioxuyqnTSHAvCa1OR4fAFeZIKe8EV4UV/fAprEONT4u6HbkqppV/0Jbl0LBqJHRgBx8/ddY7LWdBDrFo8H9vrYIKqh9JP5WJbqZrIhthbyfjUc48yywNQRzhbxFQV0PJPvd9niFj5lC4+RWXXVY3ZxrwzNI6mhFvNedGxRc3yEsOVU3GcXIW9zdUyODmZpp6eMpQmFXX2wjqbR3snTMCnoJskAYLSXkiRvEo/9G1q4PoEsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ERawEb26Ub316UouzEdcrTsfbddk2QYr7UABbTt5SNQ=;
 b=gDRfU6RPaR8FLprhdfb0qmwhwEIasIyPhVlp1PleL3Y0f1zC7XcNruwePKUBaEOJwEC9d8lWMfo1ocdrxPmLdgTgbIUfw//OZ5BcGrDAcEaeTBwHWswhuApjqO2HtkE82wPUvQGdgsOeDfqNN5jdwOuAaN1FLf/4KPwGaz43STyX87qOCbPn4BnzRM2wZt9d9Bhrl+olDw5lnUmet5uehga80AS8BrxASYsbafV78/nrHE342mu8OwXD0+Yiau/n12Yg//NTv3kpQNPeyP/im0Ojitg4Er4tRHOmvfm7/6ckKGGM6mpO7x7Swfe8nmCWbLiOh8eV8aAGlbC+NQEI1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ERawEb26Ub316UouzEdcrTsfbddk2QYr7UABbTt5SNQ=;
 b=CW4fkr4OM+SfQetG5U1GdsJtrR62LS/N0LpZH732infUhUZliqYSPgK4gRfiIWxu0F7zp1O7etfiV+wd5wsIEE0g2BMZ+Vwz4FXqtn3koVDnIh9Z0TMHL3KEPpXfSvFZuI43XSPo3dwPAhErgCVUO7UfY3GynMqsjkx4sXmTtD4jzEHxxRuUOSaHlojlE0MKdajfNIasS66phtcRJuYN/dOB0oz4WmSn/ZAVOy622cNCvrZM7favT6DAZWWxkPt5irS9NAWs+kHsqU9mXZMaDI6gCxf++RmuYVOWWSo2xvIPt414iI4fIfGO3EWzxTjsdz6CpkodKecypblxMjW6wg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR12MB1262.namprd12.prod.outlook.com (2603:10b6:300:12::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Tue, 19 Oct
 2021 06:34:33 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3db1:105d:2524:524]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3db1:105d:2524:524%7]) with mapi id 15.20.4608.018; Tue, 19 Oct 2021
 06:34:33 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     =?utf-8?B?Um9nZXIgUGF1IE1vbm7DqQ==?= <roger.pau@citrix.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "ntfs3@lists.linux.dev" <ntfs3@lists.linux.dev>
Subject: Re: [PATCH 5/7] fat: use sync_blockdev_nowait
Thread-Topic: [PATCH 5/7] fat: use sync_blockdev_nowait
Thread-Index: AQHXxLI2ACR8R5mMQkaGA6fT0JPUuqvZ3VyA
Date:   Tue, 19 Oct 2021 06:34:33 +0000
Message-ID: <61925aa2-4474-354b-955e-d3dbdd6ee281@nvidia.com>
References: <20211019062530.2174626-1-hch@lst.de>
 <20211019062530.2174626-6-hch@lst.de>
In-Reply-To: <20211019062530.2174626-6-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 01e17411-8278-44c4-ccf7-08d992ca8357
x-ms-traffictypediagnostic: MWHPR12MB1262:
x-microsoft-antispam-prvs: <MWHPR12MB1262959A5A48ACA061E47173A3BD9@MWHPR12MB1262.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:530;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FZaq+uyNhNsIhlSt+B39bFXbORPsiQm3v7ylnPxcFlSg8VI//t068m1xAL/nipwO/IVgzNAbLRC5ZFmSeQFh2lTghkzNn8xK0yesOeeqXZQbjtSeNQ9Fxm8w6gTud5kOZn5ORk5YsDGg4Oe3LALb6t2chic1rwu7bgOsXn7lyipx5KafmN5Mfd0XG7ARBSmtCiQbyPHGWQuXOc7JVVXzA91PovkVxH4nZD3Zp6yAULQ5d3I/0Leg+TjWyxfDXXTh95khoW6asTTqfo+CnQsAIAyGD0GuMQoiDzSFEa1zDuDPFHQlWIuFTjyutCF4y2CghfGrhDq42/EpxeAQ6jHPL7iRkgKVva36aMNm5rWfSdmJZpQdv0CEokIGQv4TsHAUsiO5OYG/YTj9cGQFBq2L7ituHHyd2/3jmZCqRvQDWNqJx5pfgTMwx3pCjWu4LTZhBCyhu2EXixxT3aCthFhaYmcNs4qEzqANIMlVJvUFqmgiy3U8XHvJa7BCGtaraorc3BHtDVaivW66pveDf/7tUo02j0NZHgw7ZV6mpud3TYOfNj7ig/SohP1H+luULnmbeTAKHqjb9RfaJw0Hm+f9I/BuHJfBIW85EhBAjQOuOIHatQ5piZNQIxW+7EbywfzsNs9Mv/MhydVfGOmXww90vJI6LCgVjadLD6hpn21PDnj64VYMWKJFaQgO+fdx7FPl88vzh1zw1pqc20Al+h8Wd7BZ+z5ktOVncEC069cN5IoAhjZVwBNMua5EFyZdiv24mKPiHF61GGcrWAe0H2D19g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66476007)(66946007)(5660300002)(7416002)(508600001)(64756008)(83380400001)(2906002)(36756003)(6486002)(110136005)(186003)(66556008)(38070700005)(122000001)(86362001)(8936002)(53546011)(8676002)(31686004)(316002)(76116006)(54906003)(71200400001)(2616005)(6512007)(4326008)(6506007)(31696002)(91956017)(66446008)(558084003)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ajAxRlVpb2kvMlhyY0dZcytlOVRhZEh1cFdSMC9HRTB6VGFhYkxHclBYNmds?=
 =?utf-8?B?VWllZkNzQVMrRGVSVWtFT1pKOGcrRVplaXJsd2Fzeitaa1Y2VUc2TEhzZGJO?=
 =?utf-8?B?ak9RMGtkSmJOZDk1dEVaenJ6Ykh1amUrVWNMZVZaNlZaMWVaSWdRUCswKzdW?=
 =?utf-8?B?WGtNTHlLZDZSbjFmZG5aclVVWnBZYVBob3ROZXlYb09aWDI1Ym5BQWd6M1ZD?=
 =?utf-8?B?VHFVSU0wLzUyT3JQaE8zeVAzbER1N1IybmhSWXNhNkVSaEJPclZmaGJqWEdG?=
 =?utf-8?B?WDRYT1VkbGN2K3hFOUtzS2prL2hrTTdhUGtkTHpFQjBlYzJCa0ZJaGZTV3F0?=
 =?utf-8?B?RUdqT0FteStxMFJDekY5eFJISHNxZUJqZmd2STJFNzN3WFU4RElyQ2R3NW5P?=
 =?utf-8?B?VWZsTmRhbVpsNnUxcjVnTG1aQ1ZTTlJiSkNUTU5WVWxTSkZDOWhXUUhoWVhH?=
 =?utf-8?B?N3FKQk0vQTJpMnNvNWhrZkErbGo2UjZtK1JyaVk1eVhRemR0ek91MWhmOEcv?=
 =?utf-8?B?S0ltNUNjbHZEVmJCcFJidlptZWFNSlpwUCtleWl3SjhzdGJYeUxQekhpelNY?=
 =?utf-8?B?aXBlWXE0WkovSkc1bFFQRUdva2lHMXI5UWRqOVpNaDhLemRtZUpTVzNBS3l1?=
 =?utf-8?B?N3dBdlBpZldpZUxlMnF0NS84OWhWUGVuNmhyMHFqenQ5aWx0S1N1T1poL2I4?=
 =?utf-8?B?c3hmdlFKTXdzeGpkVU5PWk5VWGxLU1RyK1NGZTYrMzhkREFaR29QZmZkYitI?=
 =?utf-8?B?USswZ1ppc0pGZE5OOENSYnE1LzJWdDRORG1RRWxUMytRa2tHM2x2ekdDTkVT?=
 =?utf-8?B?bDZvZkZEcWlvbVdudXEvWTRzTUpZcFlRMHZLNkRKT0pGRS9YNk1ndXROajgw?=
 =?utf-8?B?RzdRb2FIbVJFYzltM2RySVp4OFB0b2ttYUwvSitUMkp1YzNsTm02cjhMbHg4?=
 =?utf-8?B?V1RHR2xRRmNYSWUxa21teHpHclRXaVFFcG5yMlRQQ0ZVYWZMUmxXVUIydjF2?=
 =?utf-8?B?MWFhbmY3d29qZTBhYUhTTkE0b2p5NlJnZlRxQzI0ajIvKzNxVXhSZHVhRTZE?=
 =?utf-8?B?OGVhVnAxdmNUWDg0NlpOZFB5bWVyV1luNHluUmRpUUUzOW52TWV6NUJRZWlk?=
 =?utf-8?B?QnlOZlljMlVuNU5Da1NCV2diL1dxajJ6N0FiUW5BcUFPYVhzREpNbTc5YzU1?=
 =?utf-8?B?dVd4aVdmZzJhUGoya1FlMklvR1o4K3R5R2RnT2p4WTRxWTM3MHdCcTBDZzgz?=
 =?utf-8?B?K0JOczl5MU9rUlRrTEdpT3I2TGN4MVR6bG83a01PRklEYXE4SGhkbkdZMkFH?=
 =?utf-8?B?eUFmMEcxU2FKSHFPSENBWlFlZHRta0RsUmVSbVFiSzF2eWVsQW1XQW43cU5J?=
 =?utf-8?B?SXArOXlwc29mbmtNUTZzaWpPUFRUZ2xBZTNRVnA2SlNZeGpUWm1sVFlJRDNZ?=
 =?utf-8?B?MnZVSlRkMkgxY25TeUdTa1IwWmZvR01QM1BYUmE2QVozaE1KaGwxVmNobFRW?=
 =?utf-8?B?WUhDQTRtWDkxL1VtRzNxWWxKRjNGYW1SaFhqcmwyZXBRc3lSY05nblVmOFp2?=
 =?utf-8?B?OWxTUEVKNXp2WWdMd2xZMmRrNFlpWlh3YXBXRlVDMkxhQ1JyaUYrZ1lQMks0?=
 =?utf-8?B?WjdVUXM1MWM2RHNFMHUxcEl0RDNFSHBmVGlhc052VFNEYTJoMnpFWTF2M2Fl?=
 =?utf-8?B?Rm9zdlNrK0xBODNCSHpmai8yUXhrWC8yVUVFV3lKQTNUa2FPNTAzMUE5MEc3?=
 =?utf-8?B?RFh6OG1TWUpYWDg3UVFLWk9WWnRPdld3WWtzQ21pQ1NwMGY2akVLN2Z4Z0xW?=
 =?utf-8?B?cFo3V3RUb05LSGcrQVRPV3BKb1hpZWV3WkdFZXIzWitWelRrdFEvQzNSSHp4?=
 =?utf-8?Q?W8MOeQhDeALLE?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <35034971B1C90F4DA53D773B261CC060@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01e17411-8278-44c4-ccf7-08d992ca8357
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2021 06:34:33.2805
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jn3GrIyTbjTQw9CffhtnFrF4/pmOzIc8TMUJTKkv3bQCNvff8mgcvOKNyYpXT30hNNOMdujteMyYo4qlH15b5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1262
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMTAvMTgvMjAyMSAxMToyNSBQTSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IFVzZSBz
eW5jX2Jsb2NrZGV2X25vd2FpdCBpbnN0ZWFkIG9mIG9wZW5jb2RpbmcgaXQuDQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4NCj4gLS0tDQoNCkxvb2tz
IGdvb2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29t
Pg0KDQoNCg==
