Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D16368ADB9
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Feb 2023 02:00:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbjBEBAF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Feb 2023 20:00:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjBEBAD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Feb 2023 20:00:03 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A5A323336
        for <linux-fsdevel@vger.kernel.org>; Sat,  4 Feb 2023 17:00:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PgIW/u8+vADHqbNcsZT3Uk6eqzcWiS8ZOQ0YljRtFkhlJEs7BBXvKy1TT7y/1a3qWY1+isfq4dzzW4Z9uu81wdEfuxXVm1tCFhVzpGhaZ0Gf9J0ZGTsn7crKCaihGkUh6DruoO7BFVxRtL+xpIjPtIP2dG7p7DVnPnHHfZJ6Iob8fCX3GcO/4y0lOIskPXYKIAQiynYWBTaRme+MbsUoinvRkctOZy6RBVIEWSfhW82vNoqeRiUsQfUxgdsnykiqYZn8Tpr7J4nt4KNL7hvsLpMydA9s3Wz/Xk7sZJF9G3PAnJc48rlnfZTSYO5iWQGQPLYeo6VeggbFs3T1z7aUKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=whNWcFMLTB2ewSlQJ9ywCsB9km7txYoCiRM63+V0UwA=;
 b=ecfNh9sgcB3QvqCJsRl7I9pCt5B0ylS0hrQIkvzRLqaFjzUjEKXF+Fkdf4XnBsCeJcwYPgJChy4DObRS3/UKAMJni4botIx4hPawmOabjN1LOldvFoorAEaPHoFTbj+UIYbnQZzEYEj33RWSOA1WEeVm+TGy+HYxsyfDkKtT4o5+TvfGl6TAngF/ySEf3qD5bAz5Ee5AoMrQJTpqY2gw89jrASocvxlr3w3CfN4HLWX0TclhX7ogt2R1jwZi54dDEkTys771CmodA2QQoIYnrmnhzo/aC08Lt5TC+/Fqb1xjOXdiheH/tBk9k1eaDbXfbIr52XEuB2dQpaIvUrWJXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=whNWcFMLTB2ewSlQJ9ywCsB9km7txYoCiRM63+V0UwA=;
 b=I3ciZbkDCOV6ucGGYBpugraHh3wuXHGcxxt9BpNpUbsW24ad3QMgwLx/5BWH0aRRD7hyfdZ74T61aISQviGFayHrCYbCl9aZvaagyhL+YRqoONp76+eTro70k0t1Sr6K7hEJcAQELRwNZ5DDknHs7Inh3rbYuPZWL2VaU88Wdtw=
Received: from DM5PR1901MB2037.namprd19.prod.outlook.com (2603:10b6:4:aa::29)
 by CY8PR19MB6915.namprd19.prod.outlook.com (2603:10b6:930:61::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.32; Sun, 5 Feb
 2023 00:59:59 +0000
Received: from DM5PR1901MB2037.namprd19.prod.outlook.com
 ([fe80::e6d4:29f7:2077:bd69]) by DM5PR1901MB2037.namprd19.prod.outlook.com
 ([fe80::e6d4:29f7:2077:bd69%4]) with mapi id 15.20.6064.027; Sun, 5 Feb 2023
 00:59:58 +0000
From:   Bernd Schubert <bschubert@ddn.com>
To:     "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>
CC:     Ming Lei <ming.lei@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: [LSF/MM/BFP ATTEND][LSF/MM/BFP TOPIC] fuse uring communication
Thread-Topic: [LSF/MM/BFP ATTEND][LSF/MM/BFP TOPIC] fuse uring communication
Thread-Index: AQHZOP0rBP599IXdMUyq0TDbwmpb0g==
Date:   Sun, 5 Feb 2023 00:59:58 +0000
Message-ID: <7038cabf-e9bb-394a-e084-11bc23813fc7@ddn.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR1901MB2037:EE_|CY8PR19MB6915:EE_
x-ms-office365-filtering-correlation-id: 16ee3b06-f716-490c-0497-08db07144d86
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ypnnteOUz/L7+A//RvUmd+PIi4vDQIsP6u+MrE2tOg33h/22HTdsdjoLKG8Ow5Iz21DAUY9y7xeRcgKdwD8CLuQy4H1P6H01adlJUyLmYDP+l5JQvaE4+cnYioBKOeqTuM7otABCOTH1zoOA/F1L+dnSw8ebbZ2czvlS233Y1gxbf496UCnlN/gxwIPHUnJZAvd7YTSGxW6vAPc1mOyi54c4mNFZKGyrAmUaNHnSDf6czxSKUALE1Owt01Uc8oYQ1GNj2pkoiCGiXF51AaX3zsnosLXVzqQs8paMPWno4rkgs97JgjgF8/P3Q/7ffPRl4Wr+CT5QzHWyFb82EkqTyGMuXKWDFIey4BW+HEzK37yf6YDj8JWP/kQwkVmxWiwFOjtCEYsz51oGpm2PMeGauLWEzJh4RwZBJbS3rKfrKNtXqSRDbgAd4XWanOkpDndWwcDY4eNDMsv573NIrzCwtBjowEwpty0EFO3CeDaWKJj/Z5+K1VvUQ++mXbFKtd2mIA6s6s0geaaKb2DOterLqYflUXUCUbaorlnTJ/WUBijASQ0k5KDT/JyV8fGGYBo07uE887W8C5Q2FbsTpbSewKgb20T+TPsEb2evSnxwvLsMzmOs0xrVVJkMhMnLxrt+76z7p01iluTWBGAXm/QitJVxv0DZUMSs68pUsurueYUkFkPu/ZzagjgvdymtLuiaW/xbWLZn4aPtDqpNFutKYDkOIAaD45GaklHXClbh55XDtys/sPIaxw6+cY6YOcp+ZTV/bkxEuU46Qs6OGA6SV/tMzNWa65zMrW6sdL5Ha5bp7yTrmT5YmkHB8SPaQtp/li/LW9avyg2Kfq6eZczChA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1901MB2037.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(366004)(39850400004)(376002)(346002)(136003)(451199018)(478600001)(6486002)(71200400001)(2906002)(186003)(6512007)(6506007)(41300700001)(8676002)(76116006)(6916009)(66476007)(66556008)(64756008)(66446008)(66946007)(4326008)(91956017)(8936002)(966005)(316002)(5660300002)(54906003)(122000001)(38100700002)(31696002)(36756003)(86362001)(38070700005)(83380400001)(31686004)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eGc5V21ySVhha0twTndyZEZLUDVvdlpqak1nR2FRbzlhZ0d5eFV4ekNMTGEz?=
 =?utf-8?B?R0Q2Q3lRR0lacVRxMDFJUUxDck05N1pOZExzdW9pZFJRRGYrakNxUy9SMzBy?=
 =?utf-8?B?c0hodGxua2FUOFE3bzRTbS9nZXY1ZHUxQVR5SGlEN2tUcTJVV1ErZThtM1Zw?=
 =?utf-8?B?Qy8wckZ2T08wa3RHZklpMWRGS0J5dDh2U0ppZlpjcmN1TUNwS1JWOXIyUmJF?=
 =?utf-8?B?TkZZWkVlUElPcVUwNnRKQnRRM0FMUDBMQXQrNXJqYmVybGVGUVVFd2ovT0hp?=
 =?utf-8?B?OG5Tb0wrLzhQZSs2SWFNenBRNVdHVHcyZGlRMC9WUldaT2p5bmMrOEdrZ004?=
 =?utf-8?B?S205aXhFNHIxNk95MUo2SDhHOHdaRVAzVWNXOUNOZHdCZzlFbGJZNjk2ZCtk?=
 =?utf-8?B?Z3dPaENXUFNaUjRoVWRrUlNidTA0SjBsWGRkVGtlMEllcndWeWF5QTdBMzBQ?=
 =?utf-8?B?VmZzRGpGTmpLTVdUUXR2VzdYWjV0WnpYTTU3WkxPZmtvcHZwaEpEYkxxU3lL?=
 =?utf-8?B?cnpSMzdlTE9Bc1NUb1BocjZIcVdWSk4weExVVm41aGNwTG9IdGRhRlZxbmh1?=
 =?utf-8?B?UnRwSWxDZ09KR1ZXWmprZW9ndUxlck51L29XQWZxalUwSWNzM21NUm1NREsy?=
 =?utf-8?B?T0syWGJza2ZpTXQrZVFKMFBQS1JPSkl5TGZsOGRaU283c0tHV2VxMWMvZzBs?=
 =?utf-8?B?Q25YampieTk2dlZtUzJZeFFsOVJuWTQ0Q0ZaTGI4UE1DbWFXS2kyVVc1NkNF?=
 =?utf-8?B?c0NtVStvN0NUdElrZHk2M05kYjBLQzVWbXJRbUtPVkhPc2FNMHgvZ2Q3dWli?=
 =?utf-8?B?RW00QjhidW9RUzU5Z3lkVnEwRm42VGJBd2xmUE9zazRPeVB0K0YyeXlLUSty?=
 =?utf-8?B?d0YzSndtVkhSSmg2ek9xVEdjVGxtc0piYjl0bnpYNjdUV2VGZDJwNzJ3Y0No?=
 =?utf-8?B?STJVaTlOVEhtY0ZhazNKVEtCeDVVNm94MVhMbEZvWGFuTzhpNDBDd254N204?=
 =?utf-8?B?cWdaRU5nQ0tBUHZVUmxQTmZDTzc4NTlhUlNpZ04wVjNjOGJTZDJ4VWRtb0h5?=
 =?utf-8?B?NkVxT0VLWFBCR2RzNUY5RWZMY2g3Q1ZFditTYyt5Q0E3OCszck1VNURPTEtH?=
 =?utf-8?B?RDRuK2NMcm1VSWxSSHpzMWRLUkt5MkpUbW04TVJLRllTaE1Pc2NoZE5QcHkx?=
 =?utf-8?B?Tkh0bnhCTUR3dS9rTS83bElWeHc1OWlxOGQ3aTZ1K0JSVFhjTktYZFIwYUEw?=
 =?utf-8?B?Ui9WYkxENC9MYW9RbDEyRlVKazhGNHA0WnYrRmkyeVpQd1E2ZDU3TDcrTHlq?=
 =?utf-8?B?anF5VEJpNTc2d1ZISWdSTEdWTFVKTW9FaXB3U0RzM3B4TnN4UUJOTnFhSGpi?=
 =?utf-8?B?REl0RjJBZUNyNEZwOXRobWQ3bk5ua2hXUlZKWTZEd2o2SFVRZkNwcUNacnAr?=
 =?utf-8?B?aDloT2RqNGFtSEdqV3pDMUFXS2xNcXVCUWd0SWlHYzBLeHQwNkVTMFdNcG5n?=
 =?utf-8?B?TUxKZ3ZyRnZWd2pBUE5kSnVpZUNuVFk0T2pIK1k4K1UzdW1qcmJNaFhLY1k1?=
 =?utf-8?B?UlV6WGJaWHUxdUROemFXNUsvamh6VVlpK1dEREdNNHFQYTF1RXcwekRoTTgr?=
 =?utf-8?B?NXdLSWJNQlBLYkFEcmpNVDRvSlErRFo3dmhiYWZFY2FlUks2dzQxaXFhUTRk?=
 =?utf-8?B?MnpUdE1EMmlkSFlVUythd3ZPdUlyWW16SEZrNEFWQVBkZG82NmJhZTczSEJD?=
 =?utf-8?B?ZzVpUDZteEQ2YnhMV294aXpkYng1MTZvM2JQS0xjQnNSYjcvR2tvV05KQ1I3?=
 =?utf-8?B?TG5POGgyeHF4ZER1SGtwcVBBWWdkRHM3RW9qbkRoZUpzcC9qcjljODV6V29J?=
 =?utf-8?B?VlJjMnJUNlpzVTc2UVp3Q1V4Uy8rYnlTZ1I0c0xpNjRuWFBhWE9IWncveElj?=
 =?utf-8?B?TG1odVFLMnRVZ3h4QmpYajc5bmdWWDROZ0FJczFuVXZWTWhITHdsc2RabWFO?=
 =?utf-8?B?NXZjKzNkbjM0N2ZuM0ZBMElJSjhTR2c2ai9BV2ZEcDd6TGZKQlY3djVoSUQr?=
 =?utf-8?B?MVl3M3VBL1A1anBpS3JFUDBKN1VEeWswYldvY0xNd0dqVW1HUTQ4L2NhbFQx?=
 =?utf-8?B?WlM2UWhlMWZlUjRLeWFyUnFyUFRROEV5b01EVE1HalBjTmxvc3psT213UzU2?=
 =?utf-8?Q?ulZz5QS6LPYdJ3Uy8qS6JAE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B4ECF4C8919287428D39D9A6A1F80AD9@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1901MB2037.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16ee3b06-f716-490c-0497-08db07144d86
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2023 00:59:58.3801
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VrbFVVXv15XqxbJoFaUDBjMLB6INxXZxF7gJXvZv0vjb/uwHM4jzjjuGhTcmtb1ZpQWFuljq2xHo69NSQUKF0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR19MB6915
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

SGVsbG8sDQoNCkknbSB3b3JraW5nIGZvciBzb21lIHRpbWUgb24gZnVzZSB1cmluZyBiYXNlZCBj
b21tdW5pY2F0aW9uIHRoYXQgaXMgbnVtYSANCmF3YXJlIGFuZCBjb3JlLWFmZmluZS4NCg0KSW4g
dGhlIGN1cnJlbnQgL2Rldi9mdXNlIGJhc2VkIElPIG1vZGVsIHJlcXVlc3RzIGFyZSBxdWV1ZWQg
b24gbGlzdHMgDQp0aGF0IGFyZSBub3QgY29yZS1hZmZpbmUgb3IgbnVtYSBhd2FyZS4gRm9yIGV2
ZXJ5IHJlcXVlc3QgYSByb3VuZCB0cmlwIA0KYmV0d2VlbiB1c2Vyc3BhY2UgYW5kIGtlcm5lbCBp
cyBuZWVkZWQuDQpXaGVuIHdlIGJlbmNobWFya2VkIG91ciBhdG9taWMtb3BlbiBwYXRjaGVzIChh
bHNvIHN0aWxsIFdJUCkgaW5pdGlhbGx5IA0KY29uZnVzaW5nIGZpbmRpbmdzIGNhbWUgdXAgWzFd
IGFuZCBjb3VsZCBiZSB0cmFja2VkIGRvd24gdG8gbXVsdGlwbGUgDQp0aHJlYWRzIHJlYWRpbmcg
ZnJvbSAvZGV2L2Z1c2UuIEFmdGVyIHN3aXRjaGluZyB0byBhIHNpbmdsZSB0aHJlYWQgdGhhdCAN
CnJlYWRzIGZyb20gL2Rldi9mdXNlIHdlIGdvdCBjb25zaXN0ZW50IGFuZCBleHBlY3RlZCByZXN1
bHRzLg0KTGF0ZXIgd2UgYWxzbyBmaWd1cmVkIG91dCB0aGF0IGFkZGluZyBhIHBvbGxpbmcgc3Bp
biBmdXNlX2Rldl9kb19yZWFkKCkgDQpiZWZvcmUgZ29pbmcgaW50byBhIHdhaXRxIHNsZWVwIHdo
ZW4gbm8gcmVxdWVzdCBpcyBhdmFpbGFibGUgZ3JlYXRseSANCmltcHJvdmVkIG1ldGEgZGF0YSBi
ZW5jaG1hcmsgcGVyZm9ybWFuY2UgWzJdLg0KDQpUaGF0IG1hZGUgdXMgdG8gdGhpbmsgYWJvdXQg
dGhlIGN1cnJlbnQgY29tbXVuaWNhdGlvbiBhbmQgdG8gbG9vayBpbnRvIGEgDQpyaW5nIGJhc2Vk
IHF1ZXVpbmcgbW9kZWwuIEFyb3VuZCB0aGF0IHRpbWUgSU9SSU5HX09QX1VSSU5HX0NNRCB3YXMg
YWRkZWQgDQp0byB1cmluZyBhbmQgdGhlIG5ldyB1c2Vyc3BhY2UgYmxvY2sgZGV2aWNlIGRyaXZl
ciAodWJsaykgaXMgdXNpbmcgdGhhdCANCmNvbW1hbmQsIHRvIHNlbmQgcmVxdWVzdHMgZnJvbSBr
ZXJuZWwgdG8gdXNlcnNwYWNlLg0KSSBzdGFydGVkIHRvIGxvb2sgaG93IHVibGsgd29ya3MgYW5k
IHN0YXJ0ZWQgdG8gYWRhcHQgYSBzaW1pbGFyIG1vZGVsIHRvIA0KZnVzZS4gU3RhdGUgYXMgdG9k
YXkgaXMgdGhhdCBpdCBpcyBiYXNpY2FsbHkgd29ya2luZywgYnV0IEknbSBzdGlsbCANCmZpeGlu
ZyBpc3N1ZXMgZm91bmQgYnkgeGZzdGVzdHMuIEJlbmNobWFya3MgYW5kIHBhdGNoIGNsZWFudXAg
Zm9yIA0Kc3VibWlzc2lvbiBmb2xsb3cgbmV4dC4NCg0KaHR0cHM6Ly9naXRodWIuY29tL2JzYmVy
bmQvbGludXgvdHJlZS9mdXNlLXVyaW5nDQpodHRwczovL2dpdGh1Yi5jb20vYnNiZXJuZC9saWJm
dXNlL3RyZWUvdXJpbmcNCih0aGVzZSBicmFuY2hlcyB3aWxsIF9ub3RfIGJlIHVzZWQgZm9yIHVw
c3RyZWFtIHN1Ym1pc3Npb24sIHRoZXNlIGFyZSANCnB1cmVseSBmb3IgYmFzZSBkZXZlbG9wbWVu
dCkNCg0KDQpBIGZ1c2UgZGVzaWduIGRvY3VtZW50YXRpb24gdXBkYXRlIHdpbGwgYWxzbyBiZSBh
ZGRlZCBpbiB0aGUgMXN0IFJGQyANCnJlcXVlc3QsIGJhc2ljIGRldGFpbHMgZm9sbG93IGFzDQoN
Ci0gSW5pdGlhbCBtb3VudCBzZXR1cCBnb2VzIG92ZXIgL2Rldi9mdXNlDQotIGZ1c2Uua28gcXVl
dWVzIEZVU0VfSU5JVCBpbiB0aGUgZXhpc3RpbmcgL2Rldi9mdXNlIChiYWNrZ3JvdW5kKSBxdWV1
ZQ0KLSBVc2VyIHNwYWNlIHNldHMgdXAgdGhlIHJpbmcgYW5kIGFsbCBxdWV1ZXMgd2l0aCBhIG5l
dyBpb2N0bA0KLSBmdXNlLmtvIHNldHMgdXAgdGhlIHJpbmcgYW5kIGFsbG9jYXRlcyByZXF1ZXN0
IHF1ZXVlcy9yZXF1ZXN0IG1lbW9yeSANCnBlciBxdWV1ZS9yZXF1ZXN0DQotIFVzZXJzcGFjZSBt
bWFwcyB0aGVzZSBidWZmZXJzIGFuZCBhc3NpZ25zIHRoZW0gcGVyIHF1ZXVlL3JlcXVlc3QNCi0g
RGF0YSBhcmUgc2VuZCB0aHJvdWdoIHRoZXNlIG1tYXBlZCBidWZmZXJzLCB0aGVyZSBpcyBubyBr
bWFwIGludm9sdmVkIA0KKGRpZmZlcmVuY2UgdG8gdWJsaykNCi0gU2ltaWxhciB0byB1YmxrIHVz
ZXIgc3BhY2UgZmlyc3Qgc3VibWl0cyBTUUVzIHdpdGggYXMgDQpGVVNFX1VSSU5HX1JFUV9GRVRD
SCwgdGhlbiBsYXRlciBhcyBGVVNFX1VSSU5HX1JFUV9DT01NSVRfQU5EX0ZFVENIIC0gDQpjb21t
aXQgcmVzdWx0cyBvZiB0aGUgY3VycmVudCByZXF1ZXN0IGFuZCBmZXRjaCB0aGUgbmV4dCBvbmUu
DQotIEZVU0VfVVJJTkdfUkVRX0ZFVENIIGFsc28gdGFrZXMgdGhlIEZVU0VfSU5JVCByZXF1ZXN0
LCBsYXRlciB0aGVzZSANCmxpc3RzIGFyZSBub3QgY2hlY2tlZCBhbnltb3JlLCBhcyB0aGVyZSBp
cyBub3RoaW5nIHN1cHBvc2VkIHRvIGJlIG9uIHRoZW0NCi0gVGhlIHJpbmcgY3VycmVudGx5IG9u
bHkgb25seSBoYW5kbGVzIGZ1c2UgcGVuZGluZyBhbmQgYmFja2dyb3VuZCANCnJlcXVlc3RzICh3
aXRoIGNyZWRpdHMgYXNzaWduZWQpDQotIEZvcmdldCByZXF1aXJlcyBsaWJmdXNlIHN0aWxsIHJl
YWQgL2Rldi9mdXNlIChoYW5kbGluZyB3aWxsIGJlIGFkZGVkIA0KdG8gdGhlIHJpbmcgbGF0ZXIp
DQotIEluIHRoZSBXSVAgc3RhdGUgcmVxdWVzdCBpbnRlcnJ1cHRzIGFyZSBub3Qgc3VwcG9ydGVk
ICh5ZXQpDQotIFVzZXJzcGFjZSBuZWVkcyB0byBzZW5kIGZ1c2Ugbm90aWZpY2F0aW9ucyB0byAv
ZGV2L2Z1c2UsIG5lZWRzIHRvIGJlIA0KaGFuZGxlZCBieSB0aGUgcmluZyBhcyB3ZWxsIChvciBt
YXliZSBhIHNlcGFyYXRlIHJpbmcpDQotIE15IGdvYWwgd2FzIHRvIGtlZXAgY29tcGF0aWJpbGl0
eSB3aXRoIGV4aXN0aW5nIGZ1c2UgZmlsZSBzeXN0ZW1zLCANCmV4Y2VwdCBvZiB0aGUgc28gZmFy
IG1pc3NpbmcgaW50ZXJydXB0IGhhbmRsaW5nIHRoYXQgc2hvdWxkIHdvcmsgc28gZmFyLg0KDQpU
aGVyZSBhcmUgY2VydGFpbmx5IHNvbWUgcXVlc3Rpb25hYmxlIGRlc2lnbiBkZWNpc2lvbnMgYW5k
IGxvbmdlciANCmRpc2N1c3Npb24gdGhyZWFkcyBtaWdodCBjb21lIHVwIGluIHRoZSBuZXh0IHdl
ZWtzL21vbnRocy4gRGViYXRpbmcgYW5kIA0KcmVzb2x2aW5nIHNvbWUgb2YgdGhlc2UgaW4gcGVy
c29uIG1pZ2h0IGJlIHZlcnkgaGVscGZ1bC4NCg0KTWluZyBpcyBhbHNvIHdvcmtpbmcgb24gemVy
by1jb3B5IGZvciB1YmxrIGFuZCBJJ20gZ29pbmcgdG8gbG9vayBpbnRvIA0KdGhhdCBuZXh0LiBT
cGxpY2UgYW5kIHplcm8tY29weSBpcyBjdXJyZW50bHkgbm90IHN1cHBvcnRlZCB5ZXQgaW4gbXkg
DQp1cmluZyBicmFuY2ggWzNdDQoNCg0KVGhhbmtzLA0KQmVybmQNCg0KDQpbMV0gDQpodHRwczov
L2xvcmUua2VybmVsLm9yZy9saW51eC1mc2RldmVsLzIwMjIwMzIyMTIxMjEyLjUwODctMS1kaGFy
YW1oYW5zODdAZ21haWwuY29tLw0KDQpbMl0gDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21s
LzZiYTE0Mjg3LTMzNmQtY2RjZC0wZDM5LTY4MGYyODhjYTc3NkBkZG4uY29tLw0KDQpbM10gDQpo
dHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgtYmxvY2svY292ZXIvMjAy
MjExMDMwODUwMDQuMTAyOTc2My0xLW1pbmcubGVpQHJlZGhhdC5jb20vDQoNCg0KDQoNCg==
