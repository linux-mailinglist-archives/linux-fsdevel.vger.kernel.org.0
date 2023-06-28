Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A06A4740889
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 04:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbjF1CoU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 22:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbjF1CoQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 22:44:16 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88222D7C;
        Tue, 27 Jun 2023 19:44:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EsGthPhnG+eaWAKJ49s70W1Chg10SgXmAAdCXOdU+qkmcIaSovXDu0sh16j10o6VWbfttYxNg5aWQKt0luIurBgYH57R/4U0PleXAqGmlOXJUrBySCUnmmAdRaTrXAdbtL9Jegrlgu2tiL0C+bECaOWduMcybLxcp4eQ13/NKJD+G1jdjcL8s8xZ2IKawCcf+Mu/q7uPczBuyw32MCSiHz0qJaJMQ1PEAwSNYAGfKYgPRJWGhZDUKHQ153fkgpAhg7LQeuFICOG2JYPilLNUbFRVHhjCyhk5wUdKx5on0ceLWOnEujyHioTFGKcdgz7auieiTyRz5TEANplf5GK7gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mofqvIQgClIzLpDBY5gp0FvFCyeoFe+s6MwKvoQ/T04=;
 b=gYXh47Ho2qj3wOg4P4kjhORv8KKKOGnr8CQ23H6F2fc7kuqppcxRSeiP38zsDXsE/vsvB+B/qS+1+lB9ju0qsDf2Qa/E6v8Ke1UlMEnvO7dqqmwmpSMniEqb0YjyF/g2LNk4j2AV68U5pWIQzktFiKfUh6P3TqoZZZEY3Nl1SbXaVwZPWKsOlVi49y26f4UeRo7FmKbiCFgEwdeJHVcKetd26YD+oDhNLtN86coaoqwwjLHnm+vZ2idOc9p8yaauCDKP+mvheXWNbgrysdQe6jcXpqgcfq56VFBTkwD7mgI6UbroIbmHSN5k/Ns1f5WtBYH27/RyeLkgRKrERmkPTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mofqvIQgClIzLpDBY5gp0FvFCyeoFe+s6MwKvoQ/T04=;
 b=QG4gllWtzGvH9T0/IdEddIjtR9U8ACAtg80/eN1m4Oo/RewaIkVti2AWvqb4cDCK9yH5O7svpjBZDxsPPF6VcwyoqZWtR12+twQpUmkIol9Avj41kN/i1N6ZYL11dx8lM55rCe1uFiYKBRdbBB+mPF2iERyDYln2EMr9pzuXTDwDIinShzI7wdShhNnrIh3S3JWHO10LQyjoIm7V0HeNgJtKwzXTNbt5FMNRZTQbrsX7lxOe3Bpiyf91UIPs8QBYtXS2nq3KEh8os9cTa5suhHtStVsLiDPV4RFUhAefSfqn1RbFqv6LxtYZ+sXYHGqjtpE+6Hw5NAmK+Uk9CHAdPw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by SJ2PR12MB7893.namprd12.prod.outlook.com (2603:10b6:a03:4cc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Wed, 28 Jun
 2023 02:44:09 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::92c6:4b21:586d:dabc]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::92c6:4b21:586d:dabc%4]) with mapi id 15.20.6521.024; Wed, 28 Jun 2023
 02:44:09 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Lu Hongfei <luhongfei@vivo.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "opensource.kernel@vivo.com" <opensource.kernel@vivo.com>
Subject: Re: [PATCH v2] fs: iomap: Change the type of blocksize from 'int' to
 'unsigned int' in iomap_file_buffered_write_punch_delalloc
Thread-Topic: [PATCH v2] fs: iomap: Change the type of blocksize from 'int' to
 'unsigned int' in iomap_file_buffered_write_punch_delalloc
Thread-Index: AQHZqWQIiUvvKw68fESRmtcE/MqleK+fggoA
Date:   Wed, 28 Jun 2023 02:44:09 +0000
Message-ID: <e47aee74-82d4-470f-2d2d-2ea22b232c6c@nvidia.com>
References: <20230628015803.58517-1-luhongfei@vivo.com>
In-Reply-To: <20230628015803.58517-1-luhongfei@vivo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|SJ2PR12MB7893:EE_
x-ms-office365-filtering-correlation-id: 1707d9db-4557-4d81-b873-08db77818c59
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c9DSAzKwlRt1+LOTbVFgMFFQpjOlWq5eqk5Vhc3oI3Qdt8dUztg3XUD/RsdUnD2cTCYr7q8TQAHiQ7HLEssLJiImxiRGCIR7Ge0MucIyLC1QIk6udGKX/l3iEnypnx1trBknMLAXnbUBQddulc0RpvaNepMZ9AeTMPRdM76zxLTwRw9OREYddUXbh3XYa7Uyi2L/QEneNfDx2UZAz2mhQaFXKNSyDcW+NtjTFyNBm1icyxbiee2wY6OdEMNNj3xA9gUkrBSSYsEH3rmgsoVH75zlX0wvZWmZPFDp3AF0vQtZT6dHNe+WMTTt1sT/GMjeymxBOUGlIiS42UiGOrHm5A1wXbgYvnfOGpqPdTyqDg7aAuHpvvxmstm1qRzsUI71uDc6onpDwTeStqkBKuugqxVV28Laqh1tWksKVdwMhFchKWokM9s1Pns6teLSZHoDiSqV+WR+kpWc6bBEpy3Ce6+bcb8XV0jYVNaRf24IvAgvTODMnBg8K5OqmdQOcTsZJca6glTtmN0wSVc9YFH05LX+N2K308MT+9mpxcXXxrCeNZqH1IxVZOtTwRXPZAvLR/W0a/9sav/WAbmZ1qG3gr5BdtL9JtcUrm7Ii8wg8tWPTNpX9K94bU8tIZyOU/h6XfitZLdo74hFg7sPUNk/2mSQXep0/yQLilU4zQGFgbOuXdEZhinq7M6NkQ4OzWnM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(39860400002)(366004)(396003)(451199021)(71200400001)(31686004)(6486002)(8936002)(66476007)(5660300002)(8676002)(66556008)(478600001)(558084003)(110136005)(6512007)(4326008)(186003)(83380400001)(53546011)(6506007)(2616005)(316002)(66946007)(66446008)(91956017)(86362001)(38070700005)(2906002)(31696002)(76116006)(41300700001)(64756008)(38100700002)(36756003)(122000001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TTQ5ZlFIV2ZiN082UmhDZGNjUzhTU1BrdWFUbWNNbjM3dzltb0M3cUpRcTJk?=
 =?utf-8?B?RUhsbVdQTnJiV2s5R0ltWG9MWmhLanV6MGhRQWhaQngzY1BMYnl6UGVMZkQy?=
 =?utf-8?B?REk0WFBuZ2MrMTZqanRmYlpTZGNzSTBnUXVFUTFmZGpJdHphOFFXMFRzZE5m?=
 =?utf-8?B?QkhzdkR3MW1Jc3QzUlpTUGExMDFvd3RoUnVVYlkzNVFoUXROekJpV1VoSE81?=
 =?utf-8?B?aWRsUjhtMlFiNUw1bnRxRzIxQjVZRUNiSklpdHp6K1N3ZUxaNXFGdFk3alBI?=
 =?utf-8?B?b2JGVTUreTZseTlKc2ZKYmtsSVg1N3NKa1FBQ1doTE1LMjBWNUtvZkpGS3Mw?=
 =?utf-8?B?Y2hIN3VIWTdXZWFaSUpSd1Z4aGpvdUNHaXZvRUJpeUMydElIaW1nV0VTZzh5?=
 =?utf-8?B?OWtjZkJxQlRtUjVIcVAxQTJjbVgyc1VKUGJYVFFCRlhBT1I3M1A1NjRsQjZ0?=
 =?utf-8?B?ZW9HU3lKSFpzdlRESlRZeS92TWhMSnBhN0JUYndza01qV3lsTUJpYWhXM3NR?=
 =?utf-8?B?Z3plYkIycXlDMGlpdmUySU9IV1RZNTNsMmZON1BQZFRybC8xWEhOOENHNzM2?=
 =?utf-8?B?L3BvN0tKd3FDdmFvZHZKUmtDc1Uxb0sxQWswRk1Gand5TTcrOEtxcVNJUmMx?=
 =?utf-8?B?K013VlF1M1dFaE9OUjJkT3J0SHhKejZhekpJTUp2dytaU2g3TE02YXBQWnZo?=
 =?utf-8?B?b1MyZ2dNdkdVcnJaMDdVY25GUE5wTEt4SDk4KzgrYm5wNXczQ01HbjdNSnhF?=
 =?utf-8?B?UG9Kcnp0aCsvOEdyUlZPQnVKMUx5YjZVUFVqNVl1cVdIRUppWUNyb1lhZnEx?=
 =?utf-8?B?NU1lTlp2ZDVNbHUyMlYvQ1RxWExkQ1BhWVUwNWJnK1JUZlZJMDliYnFyWTB2?=
 =?utf-8?B?SlhKUDhxZlNKQVhMa0dSKzdKQU1yWjRKdEk4dXV5YUJneHFCY1JrdytWNVly?=
 =?utf-8?B?RnJCMDNYaHRuaURJeklnQUdjcFlSY0J3UU9yQ1NoVGh3Vnl2dUVxZktxcU9u?=
 =?utf-8?B?VGlYcmovNStoVURWUFZBUDA2OWpLNGFRUTRUU1hiaE9DNGxoRWVVMHpHcWkx?=
 =?utf-8?B?OC9KbWgzVmRNejUraU1lZ2dpWFJxRzQ3d203bVU2di9wVkRGbVEwajlveldi?=
 =?utf-8?B?TFlsS0tleWZubzZpeTAxMHYxKzNZVi9SZ0NscVhSb0gxOE5YVC9RR0RxVklQ?=
 =?utf-8?B?YWNuanBEa3BvMUhrVDF2dEhSUzlvN3FlVlQ5Z1ErNHRvZTRQNHZCVStzZ3Fw?=
 =?utf-8?B?amhUTUpObFc1eWFaZkRyWjEyaUt4eU9ObVJNRHdHNitDb3puM2FuMktjb2h4?=
 =?utf-8?B?OW1PS2hjKzhEdHdEa3dWYndrRm1kdjJsQ002K3FUZzNNSGRRaFRlNjV1Tmx5?=
 =?utf-8?B?WEwyODFwTzhjOEY3eVVVOVh5bmh5N2lsVnNVN2I1WGJjbVVoZXNrNzgzWTdy?=
 =?utf-8?B?b2p0WGwvUUI3Q0FiVHQvbHpBeTN4cVdlLzh3ZUhMVTBYSU51c2FIOEF5bEJX?=
 =?utf-8?B?UnJvNzRIamtpZjhHTW9wQWFuSW9wM1kyWWFodDROTW9nRXZuODZnaWlKdDNQ?=
 =?utf-8?B?WW5YTHkxY3g4RENvcHlIem0zUzM1RVkyMTBrNVZ3alJETlpxUTlwbGw5YmFq?=
 =?utf-8?B?bDh6LzdVU2dtL1ZWVWtlSG9KQTRISEprSFp6RkUvanBNaGN4dWdpSmIvQVRa?=
 =?utf-8?B?c0QwNHdXRUdTekdjUFJtZkRQTnE1TFhmdGIrczhOMm9NZHI4a2VoTTFsQjdq?=
 =?utf-8?B?MUswa29IRkgxc0NzSXl5cm5xTFRIdy83djFqY3JieDFVMXM3bFZkb1IzdUtj?=
 =?utf-8?B?RE5iWmdUeUdmZDhTTzZDdjF5K2o4b3RSRHh1UHBSZ09jWjcvcjBGcENGVGJk?=
 =?utf-8?B?T2N2QUEwTm45YjN6UUtKRFJOYnd3dmZrRnhhOUI3NVlGdHhveWRlKzBtTkFk?=
 =?utf-8?B?NmIwYnZYMzMwZnZmSHJMV0xHZ0NKZzMyNXNEMHNmZFpUd2phV1FqNy8rMDhq?=
 =?utf-8?B?bXl3SzdJcDExb0JRbHZiaGZ1OFhoMmEydUZLTmppNXQyRFJGNzNWbWpKaGNU?=
 =?utf-8?B?NWRCUXV1MUJBMnpSd0NqTHdIdTk2c3JMU0dBM3dHamFQenJZTStoZXdPazNZ?=
 =?utf-8?B?Yy9YVmRlRVd2OEg1WUJYZGVsUUQwcjdOb1VyQmdtbWtYRmRXM1JUMi9MQW83?=
 =?utf-8?Q?NjpZcDu7buHYQ8/z39o6Av8RF3HRFKvIZDmSuvmPxPIQ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9140E510542BCE42AA4ECE6E58B0EEA0@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1707d9db-4557-4d81-b873-08db77818c59
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2023 02:44:09.1722
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I3kUGiADZFfhx9EozXXpVSFM5cHagDRAYJuDKW07yIpQpgxD159bbpLnl09iCEivaDLmD/+ht/Fu0zJZVk2JtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7893
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

T24gNi8yNy8yMyAxODo1OCwgTHUgSG9uZ2ZlaSB3cm90ZToNCj4gVGhlIHJldHVybiB2YWx1ZSB0
eXBlIG9mIGlfYmxvY2tzaXplKCkgaXMgJ3Vuc2lnbmVkIGludCcsIHNvIHRoZQ0KPiB0eXBlIG9m
IGJsb2Nrc2l6ZSBoYXMgYmVlbiBtb2RpZmllZCBmcm9tICdpbnQnIHRvICd1bnNpZ25lZCBpbnQn
DQo+IHRvIGVuc3VyZSBkYXRhIHR5cGUgY29uc2lzdGVuY3kuDQo+DQo+IFNpZ25lZC1vZmYtYnk6
IEx1IEhvbmdmZWkgPGx1aG9uZ2ZlaUB2aXZvLmNvbT4NCj4gLS0tDQo+DQoNCkxvb2tzIGdvb2Qu
DQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQot
Y2sNCg0KDQo=
