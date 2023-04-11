Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B74AB6DD0A0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Apr 2023 06:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjDKEBn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Apr 2023 00:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjDKEBm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Apr 2023 00:01:42 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2064.outbound.protection.outlook.com [40.107.102.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D04711F;
        Mon, 10 Apr 2023 21:01:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fyhA2fIt0n7JWDQOabrx7vBf0FbbHkofb46PMpCk407gEorRee3dtuAaTy5OvgGnDVV79aqx2EGAnq0eNyrPqH/kbWuZDSifOloqE7htTld9QaQyXt3he9sUQxdI0r1mFufKjTkPzGY9i4o5f8nE6+IqLKQtnN+EF/fEkgMv5Mj+q51jb3dqJP/rSb9m8uNE3R9EVx43pMeriG5he/9f/0MEBSI65/ls9XdXC8kS5C7VfF5SZ0Dg8pPvu/rVtuwCoj0+Yj0KC7n7IJSoAVJvti9MGF4bqZPOs96pfmZ6t4GDTe4crKrerAY2nqQFyRiuiQUVIqaRxlm3NuTxWPQtug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4PL+bxqYzRYumwJt3l8C2DejrLZPs9sRY1qIZOntIqc=;
 b=E0ZxwYnQgsLUhFO2MfWWJd+buPnFSuVn6wWjqHJ4LIOtMQeHJp+fs7+7KGRIE4ZX/DAzzIataO83lkDGrx7SfusIVmaatdDUWg6kjeyjLWwh0Jlfgnqk4MHfYE3GGs+5OnZrpo2T5Soq8e4H1mqyPZqqcy0yOaoWB8k1ayxMRbDmlXaTEPZZHTsWlAEA9pbxIo9RGYSQnvhq4dkPssCx19XduWJ94EsUi+WH+HHIbafn5rR1mc8JYhXvWAjel2cUXWvM3h9sJ+tmag7Mrpd/ycWL+DIut/SQh6FS1L0mIwt7NxzZudN5JwWFPmLZt+eBmdVETie8EG5f3XqJsMFZzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4PL+bxqYzRYumwJt3l8C2DejrLZPs9sRY1qIZOntIqc=;
 b=sMUoyi7gDtFHpVn5tpFElMrQ8LHf6+z/6yI93cbOza704XLAdKIRON7IzE6Iz/ioxTF3S58+GtlBpWkqnnb6XF9j6f67N9oTuaYcmKH9eZZkqG2OmlegNNHZCqWhOi9PTiOHMcTVG2orA4XAHOEnitUx0sGyoplvGVQQVMNzzQobyrTFsyxKnYD0qdeqLdSgk+Zbh9uNUbqtT/wvOhTn/cveH7/1IcGxyu9M6seaWbrO1gH6Aoa7KCOeuExKV+0mshJ8vVQQn9QkJimmabHol3zAgU62H/IndDy1yjd2BkCoZofrVW7jqnQ+rcaVtRzpNLLGkfhuJIOxHaQzuu65uA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BY5PR12MB4145.namprd12.prod.outlook.com (2603:10b6:a03:212::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.36; Tue, 11 Apr
 2023 04:01:36 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6b01:9498:e881:8fb3]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6b01:9498:e881:8fb3%4]) with mapi id 15.20.6277.036; Tue, 11 Apr 2023
 04:01:35 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     "dlemoal@kernel.org" <dlemoal@kernel.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH] ata: Change email addresses in MAINTAINERS
Thread-Topic: [PATCH] ata: Change email addresses in MAINTAINERS
Thread-Index: AQHZa2Sx8oWSvBScpk65Uk84Bo/CSa8lfdSA
Date:   Tue, 11 Apr 2023 04:01:35 +0000
Message-ID: <691c8c83-0fb8-369b-254c-68f107d1dd86@nvidia.com>
References: <20230410042646.124962-1-dlemoal@kernel.org>
In-Reply-To: <20230410042646.124962-1-dlemoal@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|BY5PR12MB4145:EE_
x-ms-office365-filtering-correlation-id: 5683547c-b5bf-4535-4a21-08db3a41719f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D6n5DHAlbyrBJu72XysdDiPX9AQlOgzaQtO0xdgmNIfoCHEaETRVgBkdLaMVATb+VXZV7rMMG3IF6pYUA1z0YP2iVJK9KOFeGVrXPAxMxsGQeutKmYY2VROHM3by0Lvrks88dY7mSq5TkXCBQvpxO3vExwypQEzYVCE84cOSH339u9GJdJNiwmFw2XmlnezACWv4zGBiMf2s2XF84x7QACD7dgB9lX1cQVa6O3wJ5OZh6J9av8HJNIzmpLmJ72gsmB1IZA9l/cRals/7tcON8BBSfm56DKs8/BS4zNdS+jouSajV1IJtNnN74g+BSGTZ3he7w2oWZIv4Ez0nuuv6YSz3xb7O/CFX7kOkO2xbgrLtwSQAAEOLdU+hO1QVLVzgjGoGFHz2OlrdhZQyltccbE+QFqD9UOH4spXod28zHQ60RfhNxvxOxPa49N7dM9Xp/rpbzVC66SeOF2u0cvECL/n3mHv8hD3IpFQcTFntJKus/bqdpnPVEAF+BmzJsALSw+4y2kOQrKGkKF0OOfyww+M5D355E4Xgg3gllHJuNQqjH1AALivqcaiAhYgC5I1qaIXhj+SDGgtunsK4yaTx7sjQOrmNqUCTxuGuOppQr8ipgoyj47w5nRmFgazD6bS1PCrIXvasKD63wxld63n1fVitEVuhUqNH8DY1lI0wfrrUgJWAfGkF1xr1w5E3sY0HmnL3M6xfc0kc/Z6fUjbExg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(136003)(396003)(366004)(451199021)(31686004)(71200400001)(478600001)(86362001)(31696002)(38070700005)(36756003)(38100700002)(122000001)(2616005)(6486002)(2906002)(91956017)(4744005)(316002)(110136005)(6506007)(53546011)(186003)(54906003)(6512007)(66476007)(8676002)(66556008)(8936002)(5660300002)(41300700001)(66446008)(64756008)(4326008)(66946007)(76116006)(199583001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TVdlTWcveUtRRWJQU0hRdzdaWUVUaXhvY0ViZTZMTnJpWHRnYTlETEx5d0kv?=
 =?utf-8?B?ck5PT0QwdWQycFMrMGI4MlZpU2l3QmRZRlZVRmhOQW56MEVlKzlCc0pyS1Nj?=
 =?utf-8?B?cmZOaXV6NEJBb1MybEJKWVZyaC9MQWN6Ykt0d0ptZjBTbU9NeXNYb094Z0hC?=
 =?utf-8?B?RGdlMDFmTDJ3N2xtVS9iRE1YcjB0SHNGY2J3U3k5eVZpNXlma1VlcEg4ZnUx?=
 =?utf-8?B?RWFtZ3VobjE0RGZNMHZzNUJiVmswaEdmenk4UUpPWUZDWHZFLzJDUzFVZ3BY?=
 =?utf-8?B?dFl4SXZhbjBzZ3podVBlcSt0c2Y0amxyV0FUdEJJWW9aQXE1WXl4Q0g1V0hJ?=
 =?utf-8?B?eVA3OUxsaHlkS2lPaTk0MFlnTVlqSVpGRXEzNDJMaG15am5yaUdWaktDU2JD?=
 =?utf-8?B?eWxZZG9HNGxtUGU4c2xtUGpFOEFxUUR1TmFhS2JFN0ZaYm9OVlo3RnI2eFdF?=
 =?utf-8?B?NzVDWkRxR1dDbk16RWNlQnIzak1UYnVrUGgxV2NwMWxnTjB4YUVjVXIzVzlk?=
 =?utf-8?B?R3ZRZzBORTlYZU9keXArNm9zVldVQXhPM3ZhZm00cEMyNUpzVFQySkdXOW8w?=
 =?utf-8?B?cER4UkZiWWsyYjZnVUxWWEs2VXR4VUhpTGtZeUR2OGFZc0syRm95M1g5UmVl?=
 =?utf-8?B?cURlSnVqMjBTZXpGMnV1YzFQcE1xMzRpQnVOOUZGQXcvMmRUZnVUc3pkelE1?=
 =?utf-8?B?VUczcU5NQnpua3JUVFJ4cVFuUWZyTnFJaVh2RXZ4QVZiRVc5d1pYUzBaSzkw?=
 =?utf-8?B?RzJSVVAxdENCQ3k0T05LWHhsM2t5bmhGbm54aWQ2bVVzVlYzeXlQMHBSTnBI?=
 =?utf-8?B?RlYrcDI5TmZldEJmMXg0YXZWNnFob3NodHVpcTZvdUF3ZjdLMVd2YlVwREV5?=
 =?utf-8?B?cG44czZXejBjakJNQTdvTGN3QWQ5WmlrV2xwd3VCblBVTE9xQjRDaGh3TlZa?=
 =?utf-8?B?OWpHU2tRWDJwczVnZ3hwTEJvNFdtSUVsZkphbEU3TXpLclZCbW4yOUhQclds?=
 =?utf-8?B?WHZRVzVyanBDZjFNTjZhNk5ZNklQWmt2M2xMQVVabytVcEg3WElNZVBOWmMv?=
 =?utf-8?B?RUNVUmtkOEtZcmpLUzVEQzc4M2RxV3NWRUIxVkJJZFBLRXhlUldyZ2pyaXBW?=
 =?utf-8?B?aU9YM0FUMkdWWGJxVU9yR2ZxZ0lwVWpwY1JqcmFNdlNiZDlFd2NpNmNDczlw?=
 =?utf-8?B?OE9nU2E2SzNtb29YVS9QdEFCY0paM0ZBbVZveHZaZEdhc0t5dVAxMkJXRk9z?=
 =?utf-8?B?aXVHVjZkeGQxZk5Yb0tGZ3I5S2FFem9pSFNxVTN4K1NxOW44R3NUQnE2WGUz?=
 =?utf-8?B?NXFyTTM2WmtNQmZ1UjRwREdUWUZEb3FFb3EzdElhQld1MDAza2gzM3FTMDVG?=
 =?utf-8?B?K0N3TzB0cDlGWUJJNmcrT3BFaEVQWExtbk5zRlFCN2svK3JjQm8wdk5ZMGs0?=
 =?utf-8?B?WUg2bE54NUZhZTFhU2NKdmJ4djBDSnpoVTduZ09keGZUenFhQmpOVHNhcnBh?=
 =?utf-8?B?Y2F0a3pVQ3JrN2ZTVE54OWJBamF6eGtuMUw5a3RrY0RKT3hnS0RBTmM5c2JN?=
 =?utf-8?B?eDFMU0k1YUpHWWxzUlZ2c3RmR21WS2c1WUEwc1lrRkl0b1AvK0dmSFhFbmFt?=
 =?utf-8?B?T2Rhbi93WjcvQ05Ia1Y5NVo3bUF5TWR1VzhNWXZYc2t3U0hNeVM5Rms0OFBv?=
 =?utf-8?B?UHVTdWdxSEE1dWdUTXpMRWFlblNZNTZkSW1PVTN3Ri9wRGQ0VHdGdEpWdGJJ?=
 =?utf-8?B?UFN5ZWxMZktqZTNTVDFXTDNtcDRGVUI4YXgxazNoQ3ZYb05laWFpdDM5Mmcr?=
 =?utf-8?B?R255NGwvT3FGYzlsQUloMzc2R2srUHlVUXZJaklJSUpYdm9FQlVQdWdOY0hC?=
 =?utf-8?B?dDZPdFQvTmsvNFNlU2V5QnFKKzBEMzRpdlN6cmJXamkwdlVXOEdZc0gvY29M?=
 =?utf-8?B?S3pJR2I5YVViOHl6bkx0Y2NMMmkxbTBXZjVPUllYRUhFdXM2aTJ6dUlEb2Fp?=
 =?utf-8?B?L0FxdlFtREtzTGJTRzQvZE5KSjhrbm0zY093V2hnZ2ZFU3doV0JLKzNBclcz?=
 =?utf-8?B?bnVDbXVaejV6WWxRTGNub1RSQTd2U1FmMVA0bkJ1T2VGSjJOaGZOVHhvcysx?=
 =?utf-8?B?M3hDVy9IUENqOXNhOUp4K3pHdlBCc0VzZm91clY1OFhLS0NlOHlJZGN0L21C?=
 =?utf-8?Q?WzsJrkGxLnkVZGhUaT55CU95ucaz7IEpbuVhdpQN1hR9?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6FB416EFE774504CB395AB660DA457E8@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5683547c-b5bf-4535-4a21-08db3a41719f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2023 04:01:35.6428
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2l5hD7jeTt7WdKLRHTL28xJ1f8wSTgQTw95GoURmHgkGFGhFNKlwcsY74TeKqoyFBFRUtDUuz/UJWxcBeiszjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4145
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gNC85LzIzIDIxOjI2LCBkbGVtb2FsQGtlcm5lbC5vcmcgd3JvdGU6DQo+IEZyb206IERhbWll
biBMZSBNb2FsIDxkbGVtb2FsQGtlcm5lbC5vcmc+DQo+DQo+IENoYW5nZSBteSBlbWFpbCBhZGRy
ZXNzZXMgcmVmZXJlbmNlZCBpbiB0aGUgTUFJTlRBSU5FUlMgZmlsZSBmb3IgdGhlIGF0YQ0KPiBz
dWJzeXN0ZW0gdG8gZGxlbW9hbEBrZXJuZWwub3JnLiBXaGlsZSBhdCBpdCwgYWxzbyBjaGFuZ2Ug
b3RoZXINCj4gcmVmZXJlbmNlcyAoem9uZWZzIGFuZCBrMjEwIGRyaXZlcnMpIHRvIHRoZSBzYW1l
IGFkZHJlc3MuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IERhbWllbiBMZSBNb2FsIDxkbGVtb2FsQGtl
cm5lbC5vcmc+DQo+DQoNCkxvb2tzIGdvb2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vs
a2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0KDQoNCg==
