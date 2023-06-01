Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB1BD719B28
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Jun 2023 13:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232576AbjFALvD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Jun 2023 07:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbjFALvC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Jun 2023 07:51:02 -0400
X-Greylist: delayed 2019 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 01 Jun 2023 04:50:49 PDT
Received: from outbound-ip7a.ess.barracuda.com (outbound-ip7a.ess.barracuda.com [209.222.82.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51AC3134;
        Thu,  1 Jun 2023 04:50:48 -0700 (PDT)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176]) by mx-outbound40-160.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 01 Jun 2023 11:50:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fBkf8wI1WoYfCuf4HXZbZJhf0xGA3heG08KPIy8Q435cCar9Ehz5TOmI/ZTL9Uw3coDh9imWdVFcCI5qT/ThRefDIcipjLrlz+ydp/4ClIGz4zuCmP1/TlW8o8Xk4mpQBy+5WD1wsiG6ldxo0YxPELoqxyBl6JNBKfswFPkXtiiMhlEkCbMlQjw2L3nx5MMojlu3hVIVOXIJuq2egm8clXIkh6kgFKRxRVcpbIEU2H4hUwHbtCtGnaB0xXFr/YaPHxzLV4++nfJuQ1mbUWwaWQB86ZouU1Q6T23cee5UswoiqYpRZn6qLG81Q+5/WGlvyyOJeskJ3MHkjju4SyiTVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UueNuViWHa0iqjGkGTO64Uenex4GEY0bDS3yhZzREFc=;
 b=fhHmq6yF/bJGg1f0/p7eAWRjMoXqKYY5D9bP1RGWDRtIUmVBC9iMBqkVxvA3kHzfBaxMbpRXTp0lVXXFdefFmUmncr3DnWXyDJm6lgtbKcARBb45740ODnm7rUsULnnXWXopO1UHInD6Swi8IcWqzfJUeqKS5SoJoEeouwRZNPGbTYpt0m4Fq5q7ne+uzyST0H8n16STxRhWS2yiDVSTgzdMDZlWFp6bC2pAbUFqH8SHGAlPecXPAVyny9H14+9imqZNvJkCuIvR+hLE16S3Ucbamn5K3lD/Xo2g9nrG/RPuOPfe6lUJhSulcdCeLlQTUH5p/7gkpLLpednqsWR+Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UueNuViWHa0iqjGkGTO64Uenex4GEY0bDS3yhZzREFc=;
 b=pdpsY32UmOiDK0ZNr4VdBw88z0AMhXmajZKgoFLYbAarGl9H8aNZnKYy/CKeUXbnhHUVy/yXD5jS7PhV2WFXnf5mlkXNEK30Br3sNiG0Qetp65keoWfJlzPhlzKA3huIPgStOwET+Cm3ohMMeBjjcCvWy6v1EF8cQNk9BhZ9Qss=
Received: from DM5PR1901MB2037.namprd19.prod.outlook.com (2603:10b6:4:aa::29)
 by MW6PR19MB8109.namprd19.prod.outlook.com (2603:10b6:303:239::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.20; Thu, 1 Jun
 2023 11:16:53 +0000
Received: from DM5PR1901MB2037.namprd19.prod.outlook.com
 ([fe80::fce:3af8:dfe7:454a]) by DM5PR1901MB2037.namprd19.prod.outlook.com
 ([fe80::fce:3af8:dfe7:454a%4]) with mapi id 15.20.6477.008; Thu, 1 Jun 2023
 11:16:53 +0000
From:   Bernd Schubert <bschubert@ddn.com>
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Dharmendra Singh <dharamhans87@gmail.com>
CC:     Vivek Goyal <vgoyal@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Horst Birthelmer <horst@birthelmer.com>
Subject: Re: [PATCH v5 0/3] FUSE: Implement atomic lookup + open/create
Thread-Topic: [PATCH v5 0/3] FUSE: Implement atomic lookup + open/create
Thread-Index: AQHYadX+qfvv9wwlxE+YXrSP+CvzPq0l9N6AglIsloA=
Date:   Thu, 1 Jun 2023 11:16:52 +0000
Message-ID: <ccfd2c96-35c7-8e33-9c5e-a1623d969f39@ddn.com>
References: <20220517100744.26849-1-dharamhans87@gmail.com>
 <CAJfpegsDxsMsyfP4a_5H1q91xFtwcEdu9-WBnzWKwjUSrPNdmw@mail.gmail.com>
In-Reply-To: <CAJfpegsDxsMsyfP4a_5H1q91xFtwcEdu9-WBnzWKwjUSrPNdmw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR1901MB2037:EE_|MW6PR19MB8109:EE_
x-ms-office365-filtering-correlation-id: db3f3b66-de39-4044-769a-08db6291b3c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DBslDbK9cSZAAwzmL7j3sN/pq2UWVC+VpUrwHJ0ZuDGd349GC1cCHgYMrHoTz2P2G5mw95l0lvRs21cUi51nQjEYD6wLyLK6zcsaxIndhGbn2OxgnPgs6y0MgRuLC1W+3EmE15R7vD/KMdL6s9C8I+98aypYEkFwNyeOwyufWjDu0dwgbEHm0LaQ3w4kN2L3CIzJKHCdXgup/yuONPSudbrf7x8Jn0oPdCaaqqKyfMrht4SUd2ZMex3iiwKdrXbQGfnuz/R/58T/WXzAVCpq0eMktcE1AcOf+x9iIy+chZlAtUEY9QiXAkgTM4mZTBcXzWZxDHXqg0MyEIofApSKqdQxxCfEartfpYXu3FlqrYoTRwswFPaJHTLeNFKgOd7fBeogry7/4PCfkGK1p8k3h0GwQquKEl66M7Usvdzr4V7cMpnJLTgcl33NFGZNEixYTulKrx85M+8JdiJi0vCqffp7NecOQBPM7gSZ3NElB4hhH1IzsPlqxggfvATsTo6qQ7IpSBTgbA8nscUoEDEWVe6LGN3I/SobOhq66OEoiSd6CvkOUfl48Xis+KhVp1ctQwYdr2iyZFB+rV06JVVgB0jSOc8CXFbpFd2zKy9HjE+k0YYzAYqGO3lh5lI6BqHidcvJujHrb/Gq/S7uzNJF5bm02IsFO8fnPltgoSPuC4Cz9VRhQ1FsbKlHHPlEEf8M
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1901MB2037.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39850400004)(376002)(396003)(366004)(451199021)(31696002)(86362001)(71200400001)(316002)(66556008)(66476007)(64756008)(66946007)(5660300002)(4326008)(66446008)(38070700005)(76116006)(91956017)(36756003)(6486002)(8936002)(122000001)(8676002)(41300700001)(38100700002)(110136005)(54906003)(2906002)(2616005)(53546011)(6506007)(6512007)(186003)(31686004)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Znd1NUJmZEpBQUt1aTM2TCtZYVhkK0Nxc2JEMlBCRU83eUV4YzZTWlh3S0dT?=
 =?utf-8?B?WkxsNE1aUVp5SUphazVaeFp1NVlFd2xPOEZ3bjV0TWtuS3BJWTl1UmhjS1M4?=
 =?utf-8?B?dzZJTUsvQ3FvcWc5NndlRmI1WCt6UnlwUlRZUHJEL0IvV2psaTkzRjdWUURC?=
 =?utf-8?B?T3A3b1l4d1VrOXBrSE9OY0tQY0xVZU8zLy9NQnJySGk2UWsvTnh5LzRUZ2hz?=
 =?utf-8?B?cHZoL1RmL1J2MzU0Q25tT1RCcllMV0lTQjFSZC9WbWh1QVN3UUVSbmxjUnlQ?=
 =?utf-8?B?NW4xcTdzMnN1RXdiWXRzL3NoMXZ6WUJjcnBiRzcrUmVEWGlBcEw5MjRQcUhp?=
 =?utf-8?B?c0hySVpIaVdoWnFIQWJGV1JRR1l1RzhhVUU4a1JYNG5mM3gyM2l1R21rQ0J5?=
 =?utf-8?B?ZGptaUR6YkhqNVdBTmpRbjdPMEZ2NkNrQTBkbWJHZXNnUmhjNWRTU1ZuOUY2?=
 =?utf-8?B?dEJGbU8rM0JMWWxUcjVSbjl0eWIxaWxzeEYzbWthMUJHR0JRa3F2ZSs0aTVk?=
 =?utf-8?B?aWt3b3JkNUJSUzh6ZzZjSXlqUjJQV1IxY1U3dElaRXBVei81RVMwTlhwZTRs?=
 =?utf-8?B?UE5KN1lSeWJtaXlRb2IzNURNWjhxejdXd3prL1BXb0F0cGZaaFNDV1JLVC95?=
 =?utf-8?B?VVlITE1aNXJMMlJLdTdJY0FHbDlwdWJ3cXRHc2VjWVRFbTBXUjYrVUcvbkpI?=
 =?utf-8?B?ZzFZVDcyNTRjazNsaW5Yci85SnF1RDJINnFyM0QxNnBSenFmb3lFWWtXNVVu?=
 =?utf-8?B?VHFNd29XeWtRT1B5STRlS0pwd1hpTzl0WEtCb0R3aXdVUnUwNVdsTjdLTWwr?=
 =?utf-8?B?UDQ0MUp4UTh1dGgrQlVTeW9zcktzR01yMFd3ZVJ2RFMvM3VzRzk4bEQ3SDJQ?=
 =?utf-8?B?NzdPbVBIckM0NUc0aTYvQno4K3A0Q04wVU51aWM3d1c4QjZnOFpaN0pVdTQx?=
 =?utf-8?B?RGtNTFFrS1VHaTFjeDAzbTFxdE1weFJhQjAzby8yTjNNeEwwV3VrbW9wbFFs?=
 =?utf-8?B?QTJ4V1VOTndKMFlISXk1UWNyalU2LzErU1pzaG9aNGpPcnJJNmIwNDJXb2RK?=
 =?utf-8?B?ekVUY0xuaW9pNzZVMnBCVzFTVHIydnBrblcralRTMk9SamZQajNQNWxMZDNL?=
 =?utf-8?B?aGIxRHU4bkNkMkpKczViM01TVUR5UHJHdit4NHVXeTF6YW83bDNrenRXMlFD?=
 =?utf-8?B?aHlsdmtWdVY2cG14aEpxTkJZS1p1QmFORVZMNGxDbTFGa24wOW1QWW1sVnRs?=
 =?utf-8?B?bWpVQVRxeGRBK2ZMaTRXN2hLWGZ6M0tFSTJzYTZQRkFKYWliMExNVHFld3BV?=
 =?utf-8?B?NkNrT1E2T0tGZDl5Zjg3S2ZoRklCY3lTY3J6YllqcitRVlVjUXNINFZoOHhS?=
 =?utf-8?B?WXFkOUdiaXVORmVORE83dGN4cE1CYUxackdkNVQxQnhubHZaZjViclI1ZUlt?=
 =?utf-8?B?VktCazFFNFFBd0g3N2xhQVJxdHZCUVhZQ3lSOXBYM01WZnhaZ1FvWXRZT0dn?=
 =?utf-8?B?cXp2RW10YXY4d1N4MVA3YVJncGJBNzVGditZQVdUSEpjeGdrV2JhVFloSGky?=
 =?utf-8?B?THVWRlRWdHY2ZG4yVjFYODRReXZ4bFdKN0lFS2tIemFsSmtROWFxRVlsaGNk?=
 =?utf-8?B?Q1ViSStnaWt6Tk1sVk90S1hJS09GdUJEd0JZR3lMQ3NJb1RZUkNZdTBRdVla?=
 =?utf-8?B?dnNuakdwNE9ROENGYStOL3FTK2ZJQmZXbG91TFV4Z1pCU0Z2Z3lpeFRQM2JC?=
 =?utf-8?B?V2hLN3AzVFZDS1Y3S3hkd2Zpdk8xTS93bnBpVDlJUW9YN3B2bHhQNnFidUp2?=
 =?utf-8?B?Qytkekhwc1l2NHZXYWFWQ0N1UzhzVTFoTE1aK1QzY3VVbFdRdVN3NVcyQlpz?=
 =?utf-8?B?NnB3TTdidlVhWVJEM2tlVVhQcENKTjEvQnFBMTEzMldLQWZsUE9URzRrdGZx?=
 =?utf-8?B?RXExRUFKVHZHcEhPbTlRRUlKQTc5YU9RNjhuU0lldjk3enhiV1Iway8vY01E?=
 =?utf-8?B?RGM2aDJkNGlhQTdYeHRlVndyaW5sVUM1SkNGRjJBM3c1NjUrc0VRNlFEYkJv?=
 =?utf-8?B?OHVZdC9WaldDcDZlS05wTUtnQUdLQk1DNE0rZWdzM0E1WXdwRnVhQkhUSEZj?=
 =?utf-8?B?ZXNyc3BtTGdmSVprVURJUk45WG4wV2w0dWNqY2xJZ3lZRFg0enlveWlMRHRv?=
 =?utf-8?Q?oT6SZgFATITztnKml/3UGhw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AFBF696BEEA0BA46A19C72C541A60B42@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?bHhnb3B6ZFVkR2RkYzFwSTVSc1o2dVJrZ1ozTDY1Y0xTSjZGSGsyUEl2bHdW?=
 =?utf-8?B?eXVPQmJHVjNoV016WTRrYlZqR1h6MEt3d1diZEMzZ0VLZU9LRzdCTHVEVGJz?=
 =?utf-8?B?Szd5cmowb0FPNVNhMms1bUEyOCtFd2VyQXhXWndDaEk5T05kUzA5ejNWNEd1?=
 =?utf-8?B?elZJM2xyWlVaYmNwb1AyamJzRUtSdmNXYW5oN0o2UUs3ODh0WXlsU2hkWTJG?=
 =?utf-8?B?VHRKWnFtR3R5c1BnMHVKdGtjY2tEWWRNalNVRlUvUHNzL09PMCtpNkNRSU9z?=
 =?utf-8?B?c1NQbEZDSlR4RWk5VjBoQVhsU0NZV0FKWVo1VjZCSjFxZEVMTUx5dGJSV2FM?=
 =?utf-8?B?bFRxSVBSZFRNWGxTNTJsOUh0RXlIbnVMZm9PYjR2YVdQcklrV3B2L0FtaFZw?=
 =?utf-8?B?VC84WDdTVU0wbnRaRmM1UWVkL3IzQXVFSGlHR0FEYTBVWmJaV3dIZ2ZVVWYv?=
 =?utf-8?B?WjM0MmRONDBPMWEvSWhnckcwQzVOd28zbEhoQ1NHVVhxODJ6OGNPeXRNWTFQ?=
 =?utf-8?B?d0Y5bjc5R1RxTEZCOU50OE9WMVpLNi8zR2ljc1BnaVRTTE9vM3EvYnZ5WVc2?=
 =?utf-8?B?M3FKa3hGT2ltc0JWcHU1aW1aY3pkeG1GSXVpZ2h2bTJOTUpnRzZTOXpIVFFT?=
 =?utf-8?B?c0ZNWEx5Y0pUL2RMaURPRVZ4TUowQTd6OFl5Rjl1bUZjeDAzNnluVk16Tm1F?=
 =?utf-8?B?WTkwaDJFREZOYUFkRmxuTXIxcHhQSTZFZCt2WVhiMmM5c2VjS1U4RmRhOVVI?=
 =?utf-8?B?Zlc0K1dNYXRhWncvMkpoREhKYmJKQUMwTGxwMzZkRHFvckQzSjVrZHVNT1Mz?=
 =?utf-8?B?Q3o5MkFIT2lNWUQxaVNDc0hHeGlXaVc5R2hiRlpQbWl5NTdPdnNTb2hkWTVR?=
 =?utf-8?B?TTl5T2JJTTBHcW1yL1JtZHNtMlFzRzhZOVF2M2krUUdaenBzQTlIdW9YSHlE?=
 =?utf-8?B?QXBaVWQzTGVORGhyN3BDVWFzVlZHTXdheTlxY2g1MW1SOUpvWWlqd2JQdWNL?=
 =?utf-8?B?aCtWcnNzN2hVazUzbWZaajBES1FhMlNiUVB5eFJta1BhdTFnMnNVWWIybC9v?=
 =?utf-8?B?bDFHRlppQ2JremtGSlpOMEl4czh0T3BiRTdqaUJuRjNUdUc4c2VXQk9TR3JR?=
 =?utf-8?B?OW9qMTFuR1p3ZjNxdmdJVjI5NGUvTUFTb1daOStyOUdJYUUyMTVzUVV3QUIw?=
 =?utf-8?B?cDduTXl2aTlFYi9qQnMxRm1hQ1hkbTNyUWFUUWx6K0dmU0U5N2ZoWVQvaHdC?=
 =?utf-8?B?akdQdktyd3RBSEIvTEdad3V6Z0xUOUdMc3prNUpFL2xuWHhudDdkK1N6Ukxa?=
 =?utf-8?Q?L3l0byailfdgQ=3D?=
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1901MB2037.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db3f3b66-de39-4044-769a-08db6291b3c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2023 11:16:52.8604
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nmf52/HL9VAJqWEyvDoJW19DuVcmuY+Dx1WhQNwQrrMLRutnpss96xSO9nOm8O9h5C7f8xzN5wliavrhhHCCJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR19MB8109
X-BESS-ID: 1685620247-110400-5494-6489-1
X-BESS-VER: 2019.1_20230525.1947
X-BESS-Apparent-Source-IP: 104.47.56.176
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoYmFqZAVgZQ0NjYMDnVMs0oxS
        Qx2Tg5xdzIKMncIjkxKdnSwtTAMtFUqTYWAD3LVtxBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.248514 [from 
        cloudscan14-40.us-east-2a.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

SGkgTWlrbG9zLA0KDQpPbiA1LzE5LzIyIDExOjM5LCBNaWtsb3MgU3plcmVkaSB3cm90ZToNCj4g
T24gVHVlLCAxNyBNYXkgMjAyMiBhdCAxMjowOCwgRGhhcm1lbmRyYSBTaW5naCA8ZGhhcmFtaGFu
czg3QGdtYWlsLmNvbT4gd3JvdGU6DQo+Pg0KPj4gSW4gRlVTRSwgYXMgb2Ygbm93LCB1bmNhY2hl
ZCBsb29rdXBzIGFyZSBleHBlbnNpdmUgb3ZlciB0aGUgd2lyZS4NCj4+IEUuZyBhZGRpdGlvbmFs
IGxhdGVuY2llcyBhbmQgc3RyZXNzaW5nIChtZXRhIGRhdGEpIHNlcnZlcnMgZnJvbQ0KPj4gdGhv
dXNhbmRzIG9mIGNsaWVudHMuIFRoZXNlIGxvb2t1cCBjYWxscyBwb3NzaWJseSBjYW4gYmUgYXZv
aWRlZA0KPj4gaW4gc29tZSBjYXNlcy4gSW5jb21pbmcgdGhyZWUgcGF0Y2hlcyBhZGRyZXNzIHRo
aXMgaXNzdWUuDQo+Pg0KPj4NCj4+IEZpc3QgcGF0Y2ggaGFuZGxlcyB0aGUgY2FzZSB3aGVyZSB3
ZSBhcmUgY3JlYXRpbmcgYSBmaWxlIHdpdGggT19DUkVBVC4NCj4+IEJlZm9yZSB3ZSBnbyBmb3Ig
ZmlsZSBjcmVhdGlvbiwgd2UgZG8gYSBsb29rdXAgb24gdGhlIGZpbGUgd2hpY2ggaXMgbW9zdA0K
Pj4gbGlrZWx5IG5vbi1leGlzdGVudC4gQWZ0ZXIgdGhpcyBsb29rdXAgaXMgZG9uZSwgd2UgYWdh
aW4gZ28gaW50byBsaWJmdXNlDQo+PiB0byBjcmVhdGUgZmlsZS4gU3VjaCBsb29rdXBzIHdoZXJl
IGZpbGUgaXMgbW9zdCBsaWtlbHkgbm9uLWV4aXN0ZW50LCBjYW4NCj4+IGJlIGF2b2lkZWQuDQo+
IA0KPiBJJ2QgcmVhbGx5IGxpa2UgdG8gc2VlIGEgYml0IHdpZGVyIHBpY3R1cmUuLi4NCj4gDQo+
IFdlIGhhdmUgc2V2ZXJhbCBjYXNlcywgZmlyc3Qgb2YgYWxsIGxldCdzIGxvb2sgYXQgcGxhaW4g
T19DUkVBVA0KPiB3aXRob3V0IE9fRVhDTCAoYXNzdW1lIHRoYXQgdGhlcmUgd2VyZSBubyBjaGFu
Z2VzIHNpbmNlIHRoZSBsYXN0DQo+IGxvb2t1cCBmb3Igc2ltcGxpY2l0eSk6DQo+IA0KPiBbbm90
IGNhY2hlZCwgbmVnYXRpdmVdDQo+ICAgICAtPmF0b21pY19vcGVuKCkNCj4gICAgICAgIExPT0tV
UA0KPiAgICAgICAgQ1JFQVRFDQo+IA0KDQpbLi4uXQ0KDQo+IFtub3QgY2FjaGVkXQ0KPiAgICAg
LT5hdG9taWNfb3BlbigpDQo+ICAgICAgICAgT1BFTl9BVE9NSUMNCg0KbmV3IHBhdGNoIHZlcnNp
b24gaXMgZXZlbnR1YWxseSBnb2luZyB0aHJvdWdoIHhmc3Rlc3RzIChhbmQgaXQgZmluZHMgDQpz
b21lIGlzc3VlcyksIGJ1dCBJIGhhdmUgYSBxdWVzdGlvbiBhYm91dCB3b3JkaW5nIGhlcmUuIFdo
eSANCiJPUEVOX0FUT01JQyIgYW5kIG5vdCAiQVRPTUlDX09QRU4iLiBCYXNlZCBvbiB5b3VyIGNv
bW1lbnQgIEBEaGFybWVuZHJhIA0KcmVuYW1lZCBhbGwgZnVuY3Rpb25zIGFuZCB0aGlzIGZ1c2Ug
b3AgIm9wZW4gYXRvbWljIiBpbnN0ZWFkIG9mICJhdG9taWMgDQpvcGVuIiAtIGZvciBteSBub24g
bmF0aXZlIEVuZ2xpc2ggdGhpcyBzb3VuZHMgcmF0aGVyIHdlaXJkLiBBdCBiZXN0IGl0IA0Kc2hv
dWxkIGJlICJvcGVuIGF0b21pY2FsbHkiPw0KDQoNClRoYW5rcywNCkJlcm5kDQoNCg==
