Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94BD4432E58
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 08:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234217AbhJSGgO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Oct 2021 02:36:14 -0400
Received: from mail-dm6nam12on2065.outbound.protection.outlook.com ([40.107.243.65]:52686
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233888AbhJSGgN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Oct 2021 02:36:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OvNg8mtb/uabD0IaH2+x1exCG++haUzdvO7z2XqrV2/G22Py+wT/3M1r1YGaJM22NU2UYEHnr8/GCwOHvzUJUVz2frfHpH6Pfoop1iHknGIy6iK6k6S/pRFfpptpnTLqX6Jxw0A9nUWFKtc8n80QJAlkolUg34roM88wIHHuJtrkIeC9ICwdeMXRnAy1ZsF9gCg6jKMd7kF3WjXeSmbOId6uWPwCIRuaTA3R4wB5URPKghC684xkjt7nTiAPStoATGjG4rdDsbgvYGkSPxbirEH3eEmkep+1Wx+KUY0wst8ntbE8seQXno92bI0oJsQutpFBcDRSl55hkHY1xxmcsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6sHCdAo+VtLUo7J6kFt5L45qrwynhfPpBhRQnLVgAGw=;
 b=VxN5J2Rc3iqfBjtnYuA0O2qKf+I5iixsvjqcNICI2K15iyFXcZxLJu7SfUpprUmVweDgGaKSYWvx7H9H/gN0j6btX33j2R5sQjGY9/V2fJ33iw1XbyGmf9COtoOTv8um6t+AaPWULk9WJEFPKNOLemjiLF9t0EtgHJukIMb2B4JM4p1Xy8hupAHN5IvYaElB8HKIteQMLgYTWzn6P4hFTbzEw792WcAfO8otZNsc79wXU/o+428BgX44XWjI5Fv10z7fIkXiSbhZDCaPmmrTUL+2dL2l9RyJ7W9mmLtnr/kHhYQPwVtbm9T2XvaByS/prR0wxVZpFPhoOVlRc08STg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6sHCdAo+VtLUo7J6kFt5L45qrwynhfPpBhRQnLVgAGw=;
 b=XIN2bCR8PBD6qhTlMFKMTfvG2iaQmzKo1TXuMpP2nORD/LZepZr0ssPkGiw46tdnQ7mPTpYv6NnQMSJ9lu29MNWkXc0qXd46Ip9Sz5D3MsPykASdG1TigOZf7ccQLQa8m7LE3G8bHSaTMAxKpo8q2ndupZ8pka9WCGRDKw4kMGuviD3DFaHIMk56LfCpkWFg876Y+WnbaV6EtiBxfYpb0BxSRp10Ujt99lFz41xlhtnLvR/dKJ294TiSSTWBW0bLLhZQniqyoqwwHVnN/UasZAGRrYTsHbpviqJI6fkjlDxbtHu2usjiOSANU8LBVRRZW7Dzwv2bVY3bQ4JaNS1NfQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR12MB1262.namprd12.prod.outlook.com (2603:10b6:300:12::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Tue, 19 Oct
 2021 06:33:59 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3db1:105d:2524:524]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3db1:105d:2524:524%7]) with mapi id 15.20.4608.018; Tue, 19 Oct 2021
 06:33:59 +0000
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
Subject: Re: [PATCH 3/7] xen-blkback: use sync_blockdev
Thread-Topic: [PATCH 3/7] xen-blkback: use sync_blockdev
Thread-Index: AQHXxLIq6eQH0M7OgkOwMFPfq0tuIavZ3TSA
Date:   Tue, 19 Oct 2021 06:33:59 +0000
Message-ID: <27156c5b-7e7e-b615-cada-0b99a99bf5af@nvidia.com>
References: <20211019062530.2174626-1-hch@lst.de>
 <20211019062530.2174626-4-hch@lst.de>
In-Reply-To: <20211019062530.2174626-4-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4cb4c8a7-4334-4a8c-94d2-08d992ca6f4a
x-ms-traffictypediagnostic: MWHPR12MB1262:
x-microsoft-antispam-prvs: <MWHPR12MB1262D3501FE45D185D58853FA3BD9@MWHPR12MB1262.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:530;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QZ/+2ztZi9OdZ/V5/bYDmDhPJAQNlWHohgJDWLzIyDVnAubOngi+iNlw5CRjL+cg4Aw9voAiOqWeh1hAa7IfU5YC6UD4F97MzBUqbT0Ram+kUNYf0iEzpGaPiwh/5zP2HcOmpKj4La4fNUK300PxdE2O3Z1Qqa9f7zBEixElMjz07beh+k3vCKoK2TzLYtcb3ob9MG1obfszdwHwK9970lW0gjB7EUF2Iop5qQqjiS1nViiR7QmPunHsOXpz/zri80HQelW6l0ByLPvY6Twayo7CKMqBrr+kYXO+a5goOkDTFbzMbH4WS9rPsCeBENtrFi3DY8MnXDOydhw41tOgT3XBIJuHTJiriZT/LwBxGpB7LYpsnqSEp/rosi/mjxWVjilkpknI4l3EWnYdiGa94G7adEnTXnJA4bO0h1GIBSxkXDymE5xb3pb+uJFmcsdlZEw1XlWwMz82u/DAbHWkTMgAntxtSlVo6zadnaA2nVotONopY6kx/8CZQ3uxLQip1xgpcURAO8YH89FDftC7YpIxHh2ktdAPjoWl34hH4YyyxlTnD2g+LTL2m0cqNFNdeXXHvavvJL2T6OZi27iXb70jHSZEV6H5BDL2L5PRZo7xt2L0Ui5e/SpFEqYPuJOP2mW/IcC6qpFolSxa0QoxQAxi8anmgG1z4VnYafeYobNhndRP233kQDTDQ+WWrZ6S9K+Uv38b+7I98SGDIO2+69O/4FU/JUnMuV1LQwIRSzo+s7PsRsf4zPY+aSI5R1d8sEjVgyTO/AXwvAamAATpNg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66476007)(66946007)(5660300002)(7416002)(508600001)(64756008)(83380400001)(2906002)(36756003)(6486002)(110136005)(186003)(66556008)(38070700005)(122000001)(86362001)(8936002)(53546011)(8676002)(31686004)(316002)(76116006)(54906003)(71200400001)(2616005)(6512007)(4326008)(6506007)(31696002)(91956017)(66446008)(558084003)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R1Y2Wml4QWlaMCsxbm1MeWtOL0JFODlpVmlNanJQYnNGYVNsK29lYWdtUFZm?=
 =?utf-8?B?eEp1UW5KaUVYaUtoT0F2bUhmd2FTL3RkSGVRQXlTelZqd0RKcUlFbGpYdzBR?=
 =?utf-8?B?WWRCNUtvV3M0QzVoOE4zczd6cUdMbjlEYi93VDYwTGNKcEtHb2lSYVU2dHJL?=
 =?utf-8?B?TjJ0Y3lwVkUyNE04OHVkRnlnblZtbjVNK3QyK0F5ZnU1eDlNYVUzT0NrYTIz?=
 =?utf-8?B?Sk9vc0hNOG1mRmhvUDk3T0hqNjZZMXpUNGh6WGVoVG9RMHJCSzhBN0Z5WWh5?=
 =?utf-8?B?T0xvU3NVOHhZZFZnYUlvaForTHc5QVlKQ3dSQjVYMWc0bjNkZzM0K01IVzI4?=
 =?utf-8?B?Z01vWkZmTlRUMkJzWUo0eW1oaHNqVzBwY2lCMDMwUUptSVlVSnljSTlya2Zu?=
 =?utf-8?B?Q3plQlByTENVZmJvQWZDbUNuK0I1Y2F1enkxNzRQQ2lmelJlR1NBR3M4U05k?=
 =?utf-8?B?ak9PRGNLTFF2VFFtT1RYWFdwNnVObGVjQXU3OHJlaHJlaDlmakJxcXZyRUNt?=
 =?utf-8?B?N0NFQ1R5UkZvN1ZDRm1ublN2QUpwSmJMajR6V3NTRWhEWm5ZMXdZK3cvemFw?=
 =?utf-8?B?OHRVa280UFBDZWxWbHN2N1NyZFBSN1FkdVh6c296T2p6L3JwaUZ4QTRUbUJR?=
 =?utf-8?B?c2EyWjFIcjc0VFV4bHZBTnV0cnVBc3k2MXhEdVVDMjh3cktud1hId21lYlJk?=
 =?utf-8?B?c3MrYWN2b2dPYWF2S0NHT21sWW01ZGh5TEF2djl6ajhuKzlySEFvNGVhWU5y?=
 =?utf-8?B?bC9ZdHdMZVF4bnJFUEFoUFhKdEUwNDlCV2VBY2FTVFpjaFlLSUVKUXU5OHEz?=
 =?utf-8?B?cUNZWDhsT0VHSzMrd0MwdkFmcjd6dVRMMjVrb0lUbmgxYXgxd1ZSRlIzU3NB?=
 =?utf-8?B?Q1E3WUtJSHRxRkZzV3RFOWNjZkpTelNDQkRHVXo3bVVEMUJzZk1DcWc5aHNM?=
 =?utf-8?B?TlhwZzAyQ0xJZUxkQ0lSd0xWdkJ4N3dwVEErOXNDY090d0FIcE84Y0J2b24x?=
 =?utf-8?B?S3dVS201bTYveTR3K1E4MWZlYUlkMnN0YTRFR0VTUlJvMURHOUJIYmtQbFEv?=
 =?utf-8?B?cjFWZHhzbjhqRldKOTVlek9XZFhSNWFEcDhqSkZ2ZWcxZDl6WVdoUExLVm1s?=
 =?utf-8?B?M0Y1MVV1VjRhQUdBMDJMMjdQNnQ0Z3JGamxrNmJ2T0JmTldoM2JkQm4vME85?=
 =?utf-8?B?aTJMSm5JQmlxT0pBV3FsQzkyUm5jaXRjd1pRQkFjMy82U3Fvak42LzhTc0Vy?=
 =?utf-8?B?ZmNhSHFHRnlzYXlsbGpQRWFsNmZIa2d1cTcxd3Uzb3dYaXVIeFpQRC83QWMy?=
 =?utf-8?B?RWFYTm1PU2hIMU9IQTRxMXdNYlNkck5RMHlFNHR2RDRQYU5DVjY5SEFHaFE5?=
 =?utf-8?B?TGJYUnFuOTM2UW8wSkR5RmdvT0ptdDlHc0JJaGw3RWU0TkdaRUxNUHdxSVYw?=
 =?utf-8?B?QS8zcmhvVUtDWmpnaXJOeVJYdFEySmhxeWZNS01HQkF4MEw5dFdQN1R2VG5p?=
 =?utf-8?B?R2IzRUFxYUc5ZTZUMlhPd3dHamNPQjMzSitVaVhWWTlYM0tBaEMzSElzTXZS?=
 =?utf-8?B?MFdGZU01Z3pCc0hwQ3J6ckdhZHRla2JpQXVzaWloeUI5MFZmL1g0NXdXSml4?=
 =?utf-8?B?U0hWbjRzaTFKN0pUbkkrZ3FUalZTT3FZQTEvZGhpZ01DRG9Ca0N5SmMvSFll?=
 =?utf-8?B?c0QycklDTjR4WldSaVlBRks3cTRxUnZwb1lIWUJBemxuUGRPVjRKdjhVbU9W?=
 =?utf-8?B?cDBTWXBMWHNRMk55aXlkSHM2YXNJam5SS0IrN1FCYSsrTlVXZnRqOGVSTjZY?=
 =?utf-8?B?dkUwb0g4VGV1ZEhCSWFESDd6c2dUZ3Q1VC9uYmhQdmYzNnlaMFQwN0VsVmxK?=
 =?utf-8?Q?FdPLpNeXo3ZLN?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <3CEB5B32FC00EB449EEEEBF6C7114D49@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cb4c8a7-4334-4a8c-94d2-08d992ca6f4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2021 06:33:59.6354
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5upgkLaPlU2A+9aNx/n9Omls3ThilEW/7kT3Y59yuUi/DGar79NJPfGuiCU5fYW2SbbltP5Bw7rBY7w5BKhTlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1262
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMTAvMTgvMjAyMSAxMToyNSBQTSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IFVzZSBz
eW5jX2Jsb2NrZGV2IGluc3RlYWQgb2Ygb3BlbmNvZGluZyBpdC4NCj4gDQo+IFNpZ25lZC1vZmYt
Ynk6IENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPg0KPiAtLS0NCg0KDQpMb29rcyBnb29k
Lg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0K
DQo=
