Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9EE505F90
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Apr 2022 00:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbiDRWC3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Apr 2022 18:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbiDRWC2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Apr 2022 18:02:28 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C400FC34;
        Mon, 18 Apr 2022 14:59:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YmHKB9N93JAxomD4ei7wNTX40fa9BS6BqjODW5Qzbeah7AG6KctrawLIJOJ5vSwdHJAJoPHwTC6R38FjJAyUq07T9tMq2zgjZyjHwFidtIxvDsBJAroCisKM/ko58lSwagt/cgbMEbO2vBWoj5a0hUPFwxKY/QolLTZ22JMelirLSgpR4L9B/P6rdLGcl4XG1JvhKCzHSZaovcBDL7Cu9Y5TIE0/Zi/5ehA7+xVUbUt9u7gITGov6GDaZcZ4k+whjPJ7tSawjtHWGvoIEE/QoFwAoSVqFzT+fHoVw1EeefNnRfVUyZA3irzduOpPCP+jla8wapFq42lGzr5Btjkh7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CN+ucaa1WTCjEAPxWasIE4fuNt8jhU8GhppnLgHsWdA=;
 b=OzTYHn0/7ZntcMOJeyS5Lhmz88XIxVbLZN44rXrKnPIpIbDaIPb9TB9R0zObPrV/pvj3y8cDqs78XlKKC4yq9648f6qqtiNwa/JgJJVi3cWoIkJjes1NRDeDEpPWq1STbwlfpm3v6TVe8omtz/HOqdsejwE3OK7Vjql8dJlL7ENdIs6URXW0K7PAxSn9AofvmvhgWAFGoMs6W8OZSYn/PCe0e0mtlMqcw1DNtzHczv0eVyY8rS1MOS9zoBHcWEhXmvoFO5pVheRw051N4qWykCDK+ehPnUamYHYkn7un70DxKHxYPdasaoEvBMp8tgf1pEoOWUVITubLHnampybJdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CN+ucaa1WTCjEAPxWasIE4fuNt8jhU8GhppnLgHsWdA=;
 b=bXicg2jcbhd6FDxogaAN6N50ZsnHpl4y67V+FroCkPmfh2+A6nGIToTyar1Ln0Y1QgQP55CJBpGiDruLN/QrFlI4MgLTSjok3P6aOyVW6hBMz9SfoSQAJJBRx9c6vcvvmfQs9CRYEhv08DDMzwNyXFOjBvCJ9YDkWbDPy6jN2+KVwhgZqD9lsbL01Wl1KGRghJ6ncpULkL319vXc+somx6iyPH5eJyNf0zZj7aWoiiFubiwDxsFD4NuRDlDqFSwb+oFQOjjJlKzb/aXJJCdAYFjGhML6mxeujqsCfd/wlMzepD2MY0yU8ZmBypYCuBNcNiV8OjUAcpYtffHIY+w8eg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DS7PR12MB5888.namprd12.prod.outlook.com (2603:10b6:8:7b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Mon, 18 Apr
 2022 21:59:44 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::a90b:9df2:370c:e76b]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::a90b:9df2:370c:e76b%3]) with mapi id 15.20.5164.025; Mon, 18 Apr 2022
 21:59:44 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>
CC:     "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] MAINTAINERS: update IOMAP FILESYSTEM LIBRARY and XFS
 FILESYSTEM
Thread-Topic: [PATCH v2] MAINTAINERS: update IOMAP FILESYSTEM LIBRARY and XFS
 FILESYSTEM
Thread-Index: AQHYTtSqmQ5ZeBEO2k+qVa6UeV9De6z2QY6A
Date:   Mon, 18 Apr 2022 21:59:44 +0000
Message-ID: <10e7dc6d-331b-3467-79d2-df410f281ccf@nvidia.com>
References: <1649812810-18189-1-git-send-email-yangtiezhu@loongson.cn>
In-Reply-To: <1649812810-18189-1-git-send-email-yangtiezhu@loongson.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dea9c849-50a3-4656-0312-08da2186bf16
x-ms-traffictypediagnostic: DS7PR12MB5888:EE_
x-microsoft-antispam-prvs: <DS7PR12MB5888B93EBB0B69DA8FF3EFF8A3F39@DS7PR12MB5888.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ibAtKgRyw8P/lFm2p/tdI2yW17y7pfFRaqDTFXneAdT+Tp9m8KIk4z/UlaRauAxAA2os9kVAggMeBqLkks7PDaVvuKZ61M2wTlVe0uejR8R2Nhs3ECvN7PSEH3ieb8BNaevMHbKH6e2cCFww2Mpz4uIk1yLFDL2AlApuN7rWkuVID/kH/XgAB9w5O+UAbFix/eXhvpG5Y+YpIQ7iJcCCgDTG3I/kZsQmKJC5xL0yystc6QgIICw4DGu1O1QG0s6rZuNVWovx8gTdSb9KXHRaqu3zY17wbByJEj121qHsMUFiLjrzQftrwnkrQkEEkRcEfILSYzbLVMci/Xr98INg6TV5ttwrkjCpzmfPnFfepwQHk6SMxs1vmZq71/nmr3qvKCuQZqu+anHmBo/SIG/5jSRZls1rsh0D3ngG92fHpEYdX0B0I0OVky5NKUXYGIgjCGFluFm0AOmsrOfKAwU225MGI6vUACYZghHxSOovNdOW47cVGrMBszj5Gv27LCEjmPewuDAgyqf+TioBUedxJFJuZ/zGzPcJY1LxHdH/LQkxtGx2RNRSuEH7uQ1q8zOyOsaFy54KYTK5J10is9Z/wS8to3tOx2hz4CMOBRJekO2BA3qV13SiCL5oAdDEs6jLfVJf8Nw0t5mfLbaCbk3Y18nMC+7ZgwYRbA8I4zc3dkpz+uIpF9/Cw2EvTFvvID6pZjRvq554NdhfEcnVEwGgU4r4tA92iD0TreA5Nb/EEMxIe4MbGReQoH0f2h3aa1Ftpr7sX0sLqnLvUx4ZdeccEg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(122000001)(38070700005)(38100700002)(508600001)(5660300002)(110136005)(31686004)(71200400001)(6486002)(2906002)(66476007)(8676002)(4326008)(66446008)(91956017)(66946007)(76116006)(66556008)(64756008)(54906003)(86362001)(8936002)(31696002)(316002)(6506007)(6512007)(186003)(53546011)(558084003)(2616005)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RGExRVBjSlE4VURQaDBlRjNlbU9hbVVMakJyTElqdmFjd2M4MkZ3YzRTNUlO?=
 =?utf-8?B?TGJML0U5eVpYbUl3STEyK1JEcjVRUU9ESGtnR0cyM2N6TmpQMU54ZGhQR0dj?=
 =?utf-8?B?ays1amduUDQ0Z2xFUmkxS2o0ajRNbUNyTXhlODZjMmhsTTdxMEZ3cWxJYzRH?=
 =?utf-8?B?SGhuQXZETEs4MytBZmVPRjNzTnhmbnJFbHUxcmplS2tqK1luQ2d0YVhPWWZR?=
 =?utf-8?B?WWFvMUxHeW85cHNDQnZWb05xZWsyQjQ0amhQRXFFWjRpY2NFZ055b1Q3Nml1?=
 =?utf-8?B?T3RCNFZRdzZEeUR4VFN6dlZlMCtxaGRPL21EOTJsWHUxS0dxQ1MrbHZnT3RV?=
 =?utf-8?B?YkR5V29FV3JBTGxJRWRVc2FaZHNYdTkwQ0NPeFo3cmV5UU5XWW1DQjRTOWUw?=
 =?utf-8?B?R09ZU1FuNDJONDlaWmNqaDBKdmhIVHpnYTdOaSs0L0VkbXZzYmE3VE1QaUhU?=
 =?utf-8?B?eWpBYVVNTFA3aWgzc2JteDA3dVpoT0tGcTNDSlZrMnBQR2Y1VWk1NDAzWmdG?=
 =?utf-8?B?UnVvOTNWUGZxdDdFQzZ1SkRWekhPV2FCcHRwWnRhUlBTRDR6RE5Hb2htNXVi?=
 =?utf-8?B?S3JmMitCeXRMWFV6aGJkaWFYeHVHckdKYXR4Y29hY2dkVkpSejdoaENCbzRF?=
 =?utf-8?B?WHVZM2NoZWwrN1RuT2dscVVDemlRWXQ5UlZUb29CMzRrNXVCTFhPMFJUTkxz?=
 =?utf-8?B?VVFyWTJEZjZ4MjRya0doMzVLTXdnK2d4MFhNWUVId2hvK04zclZ4ZHRRR1lI?=
 =?utf-8?B?M0VhR0dhalpTMUZxMXBCSTlMenF5U0tOQUJCY2kxS3JPcm44YjZySDlvTFB2?=
 =?utf-8?B?Y0VKN0FZMmZLVzh3N1U5K0Q0ZFdlSXl4dmRCYU1aeE0rUThNWmttU1REOUlo?=
 =?utf-8?B?YWtqM2ZvOTE4UzV0L2swbmVnRkY1WjUrNTFyLzY3WkdkOGlCaXBVdFRUWFRo?=
 =?utf-8?B?c3ZXZjYrdHdoa2NIdHV5ZkFLaElLQTVmYVk3L0dxOGtadDhjYkt6SmQvQjdn?=
 =?utf-8?B?ZEpXd05TNGdGMzRuVVE4MVQ4OGFlUUhWazBxUlFxMlFtdjVrUWQyYU9DeEN5?=
 =?utf-8?B?MmozYXA3RUR0Q1A4UzdLeGY1ajVhSlU4ajNaWU1UWWVnZldyTXRNajVjUm9M?=
 =?utf-8?B?Vm5nTGpJQUV2Y2tmRlhSbWhyQlVPRndOeXdiei90NVF0VUNONGFZczExWEYw?=
 =?utf-8?B?OXZWTC9rQngwYklVdlY0NGZRWnVIV3AvSkxneWNnNzdlZzNWR09KaEdQZnNC?=
 =?utf-8?B?azBTK25OeDRoVmJwVmhCdXZxQmw5eXNwRGpYZElqenlkS1RCYkQ0S2VCT25z?=
 =?utf-8?B?bGpKUVhlOElMdGxMT3RuWUxHWmFCb2xmWFZTT3pSTUovV3VuRWlpVXFCLzhC?=
 =?utf-8?B?bGZGRENRT2tWZWhJZEphcEx2UStSK2h1WGZYYXB5cWdTbkh4UHA5aHBuMVpS?=
 =?utf-8?B?bkloUWFCS29zZlAwMjVFZFdmMGYxQzhrUCtwYWJUN2UyQnBYWWt5NEc3dHJ6?=
 =?utf-8?B?aFNscGttY1FXVTZGTEQveEVUMnZwVjB1aUIyc3BWRDVmYlcrYkxXWUMzVk8y?=
 =?utf-8?B?eTBwNzNISzFPMTd0Wm4rS1JDa2xLVFZRdUsybTFKekhQMGVTNVlOUVExcW5m?=
 =?utf-8?B?SlhCR3IrSXI5czVwWkJ5QU1FYXR6cEdXYzZWUkFqb0NReFpWcW8xQmlGR1Yy?=
 =?utf-8?B?d1JLcUNObXhrTWJZTlovVGVMUHVGb0JJNlYyeDJJYitWeG1qUFFySThSYXh5?=
 =?utf-8?B?NDNHcXV4VzJLWVI3RkZ1Skl0MFY2MjBvNzFWSlJDRnV2bmMvRkRqZWIzWnds?=
 =?utf-8?B?SUlxWm96cUFpakZKTnQxc3p2c0JhSnllSzAwSUJYS0ZFSVVURW91Y2tHN0Fk?=
 =?utf-8?B?L054eVpaM3hEMXhnYmVrUFI3Ymg0S0E3M3pxN2dDZmRjRm9kejVNQldtWmFX?=
 =?utf-8?B?MnpGdDR4d3k3dFp5RFg1VTNCeG9XZFAwL2JSNitaRlB2eWl5SGpEUEdZa05h?=
 =?utf-8?B?aWt0cjVkRDJhWjJkTXZEMFZJNGc1a3VuYlZ4WURwa3EvelByNTdKWklqV2pl?=
 =?utf-8?B?THF1WHFBa2xoTU4vY28yV1ZqZVhnVEQya0tKUjFpYVE5SGQxVnRJemlvdFlo?=
 =?utf-8?B?QkhSNnhBMllyZ25xYk0zQjZKNzJ5WXZMSWNvdTZBNnpudWMvUm9hc3YrK0lB?=
 =?utf-8?B?YmdpcGtjQk5hWVJIZmhEb00reitDQlJMR0JvQlBBcTROaWhXNVdWQndMdTE4?=
 =?utf-8?B?QTRYVFdCV3E2YkVncUxBd0lGT2RvT3cvaitMZHV1dW16RnNLWi9nTTMrTWx1?=
 =?utf-8?B?ODhHcldUMUpBUkprU1NvSmJ5N2tzQ0JsMHN2bU5XTUMrS0ZUdmJ4UENLSVVK?=
 =?utf-8?Q?QQNL8O8FoKwBigl8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C982D3A9F6FBA040A09B77D0D55F7BEC@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dea9c849-50a3-4656-0312-08da2186bf16
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2022 21:59:44.0634
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XOmTLjCPDMvVH94IK68KdRUltBw4XCRRF7dnmnejHAmEfUZSQa0t3bYnkZR8SWTkDK+0GgSTYuR6TrRs4Oyqng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5888
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gNC8xMi8yMiAxODoyMCwgVGllemh1IFlhbmcgd3JvdGU6DQo+IEluIElPTUFQIEZJTEVTWVNU
RU0gTElCUkFSWSBhbmQgWEZTIEZJTEVTWVNURU0sIHRoZSBNKGFpbCk6IGVudHJ5IGlzDQo+IHJl
ZHVuZGFudCB3aXRoIHRoZSBMKGlzdCk6IGVudHJ5LCByZW1vdmUgdGhlIHJlZHVuZGFudCBNKGFp
bCk6IGVudHJ5Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogVGllemh1IFlhbmcgPHlhbmd0aWV6aHVA
bG9vbmdzb24uY24+DQoNCkxvb2tzIGdvb2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vs
a2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0K
