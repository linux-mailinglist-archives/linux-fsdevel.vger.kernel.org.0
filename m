Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ECF962D2EA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Nov 2022 06:48:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239277AbiKQFsb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Nov 2022 00:48:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239286AbiKQFrm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Nov 2022 00:47:42 -0500
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852C06F36D;
        Wed, 16 Nov 2022 21:47:29 -0800 (PST)
Received: from pps.filterd (m0209325.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AH3XZBv009986;
        Thu, 17 Nov 2022 05:47:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=S1; bh=Xl6epq/qeJZ4Rsw8DiBZ8n04id10ZVp99f53Prdx5IA=;
 b=awfP416+C2VaI/UQhMOvdZUqFCzd7LNJi9php2R+GUqbSO8G62pSSVSr1uSAM+WKvgTJ
 J2+BU2hT5FW68ZaR7QWTxnbuP5rrdYB8QmErq0MGnCiUlRj05gImG7M/xQSSTEVhrBi+
 R6XucUjWKzPwOru5UAthHq0/8SHtc+fnq81EzCwI3tA8sjonQTl4n1NG6eSGNvDu/0TS
 +FwiFQwGw8FUsI4PsjJteTIsUlvvfOcmVDml1MBFDw+rJ2/fXzJ+WQM431YC2MP96d+5
 f099XuNw0RUWBwLLYGwT3HogAFlPO3eBWT5H/WWWj4oRu4K1hNxfBPN5vCdAf3h2f2YU dQ== 
Received: from apc01-psa-obe.outbound.protection.outlook.com (mail-psaapc01lp2045.outbound.protection.outlook.com [104.47.26.45])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3kvn8yhf2x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Nov 2022 05:47:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nwJoXqkGyv1lgkjR01HU0xut3/JkzIIW19TYWhW21zhtEHGAHcWgLjBcUyrvQFGlDT8NBAQc9DyPyTKf+FbaCpBmu0uFHlMVMkMdutMhOGwip7pOJWA4s88MnyFXYxBRLEZ5hDxZeG7cnoGgXMKOx+Unj3v51wpbPy/sFqkhz0JdhDaV61gWUZPgq+hJTm4kETPZPNc6alGLIUU9GwfbwawpLDXs+0PAshlyMSopa6NLVbHSZvyLvPiL96jI7XVFoVY7CSXbN0Mfp3oYldG6pb1n3pO729TGZgYnujRUDhe+wfxHeoHsj/qg+pyNRSXEQFSawpRe66yN+3BghybL9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xl6epq/qeJZ4Rsw8DiBZ8n04id10ZVp99f53Prdx5IA=;
 b=dT44dmr/XZj4uH3gQhsd9ULwhriWvmeP3L0tPurFYy3nm1rbBYfdJBjoRUx6d/3vJrUYgQ4s14448Mbe/cxshk/VYJGS5RV4kAIXiVaj2EKoTzbEQynlGxb8Sr/0SYfUw0D6n97hYp8FMxDT+rCy1houHlLPoYZBIEjhkDzBE8jBVo8INFTOYzFNl25xgY0I+FWlAYww/ALRx6adadFSAgvymwc7JcdH5E5lduDgje6HNL68o4b5ncJs7NuGjHLrCMWMAwMyeJGbRA+sYJF2DMUOx7P7/TE3p4aWGoG7M7O4wBOurypsUNF6JdHnZU9Ip0Bg7SAFjKkkIXUmhCRE3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by PSAPR04MB4134.apcprd04.prod.outlook.com (2603:1096:301:38::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9; Thu, 17 Nov
 2022 05:47:13 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::708b:1447:3c12:c222]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::708b:1447:3c12:c222%7]) with mapi id 15.20.5834.007; Thu, 17 Nov 2022
 05:47:13 +0000
From:   "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To:     Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>
CC:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>
Subject: [PATCH v1 4/5] exfat: rename exfat_free_dentry_set() to
 exfat_put_dentry_set()
Thread-Topic: [PATCH v1 4/5] exfat: rename exfat_free_dentry_set() to
 exfat_put_dentry_set()
Thread-Index: Adj6Rv6JmOYi1/+VSsabj/HqJj5hLQ==
Date:   Thu, 17 Nov 2022 05:47:12 +0000
Message-ID: <PUZPR04MB6316459C269915DFB49C0D4581069@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|PSAPR04MB4134:EE_
x-ms-office365-filtering-correlation-id: 42828182-005c-4b9e-f62a-08dac85f2d19
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ba5eGbXgNLyyc2vmRxAjAkwaEpl1Z+hFHwkRz3eeaIEpyg97ztnt2dXvk03F4zCIxKPFdt31kGM4Ata0hKINta/4mHfqkjh00XEnTyQdIplnAKE4DAiWlhdmejom7V3bl7k91LhKulBp8mLb8txEaslqGsSFocA+Z3cdcmv+R0RzO9Zc1lxgN7bBS4HS1YrFcuL5sZXx8Cw9nESdYMFh+o2MHCxfG74Z9/RgtI3KslT339JFG0n5PR+anG7ZArIs/3ttm2mVW6l2hCPwf/3l0I+oGSL2omNY6iou+DqtB9CiIRAo7hrsuZia5RZctKjbkX8gm86R2OgiylRKir0ogxnT349GCpRaaYvirzIpHnfBmtvXnTBNTZDdIuGpkxCssvs8P+eq7NCc1o93JDIG/MUMr8qp1WKat47O2wsHjXIhnoiUzUs0sTpsBMkkfQiCzHqVGBMeHIwwcpkz7DQXUFI2Vlu9TzBZh6N8Rithn8l93sMES4qQm9068uJ/lGJtqUWftQsECHtv4uazVgn9jqsXox6rLgVBVVtaspTKHBxydt1bP3DxBBNRl/ipS1cMQG1zZ5piDly6S6uXNxexB7aQRRCyhZZpV0UecgHFqv9qsOVnpDP0iiAiT+ZfxszGuvAHHJEyHBA6G5T1ODFDKFVfbLPEaHacH900Usr/wNkNLWF44ZhQpPRKKrT9qCyOvg47Yaafgn0NZ80Vph8ggQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(376002)(39860400002)(366004)(396003)(451199015)(33656002)(316002)(110136005)(186003)(38070700005)(54906003)(71200400001)(107886003)(83380400001)(6506007)(26005)(478600001)(7696005)(9686003)(2906002)(86362001)(55016003)(66476007)(66556008)(66946007)(76116006)(64756008)(66446008)(8676002)(5660300002)(4326008)(8936002)(52536014)(38100700002)(82960400001)(41300700001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SGZSSjc1ZEtaYWYyVUJTbXNlQ1F4UTQ4dlFOc2J1RGNlZDQ4VlV4TU16VXZU?=
 =?utf-8?B?RjlWdkhQV25DWTdtbGdEM21WSUc5MXd5dzZxaWhId2J4SmNia3JuSDllN1ZN?=
 =?utf-8?B?RmRjOGFVRXpURGtYRUJscmRTQzJ2ZHhxTFBEU25xam8wYTJjYWhUUm9pU2dO?=
 =?utf-8?B?NEJBMmlkTlpxMHYxRzFTQWVmUEZRSHoyd3E2TE5taitvZzhqeDNXSUpnMHh5?=
 =?utf-8?B?Ymx2czlwZEYrKzQ5Q21MdEpGT1RxMDIwZUNkV252YUxwNlhtVjkwaUh0MU92?=
 =?utf-8?B?UVdJcUsyTHhvL1EzTTQ5YVdpR2FLUnpNRm5OVy9BeDhKZUpzanVEdGdBZmps?=
 =?utf-8?B?ZkYxb0RlOENseDlsUmFCZ1lMaVZNYmkyb1VwSHVBU2ZpN1Z0S1dXNEtFeFZ6?=
 =?utf-8?B?MXFNRGk4d0hZSDlpa0NyeDFhdlZSbjJCVnQ1V1pHejQvVTE5d05vQ2hLMEZa?=
 =?utf-8?B?L1NnVWJkUjduSStoN3YrU3JsQjRhV3NQMzVUYU0rSFZ0MXVnNmFNb1JScDZw?=
 =?utf-8?B?N2xib2tGcEU2Sy9UNU5nOUowb3pRWjB2ZGVYZEhqWE1HRXJOdTZlQmloWGZw?=
 =?utf-8?B?eDJNbTFyQUVJMGlqRDUreng2Z3FDOUoxUFhFQjFzZzk2ZkZTb085a3FIa2xy?=
 =?utf-8?B?V2QxVHh1OG5VT3lneHJuWlpod3FBL3FlU25MRnd4ck1xbUFDOENtdHV2VEkr?=
 =?utf-8?B?Tmtrd0JsNzBsWG4xQ25OSUxhbmpYZEh6VHJVaVdiWHZzcy9CQXlQaVFlTFBu?=
 =?utf-8?B?aHowT2lVcEtiMTgyd1NiTmJMMkR5dmF0MjRTeWk5QXczN3V0S2FHVzZSai9l?=
 =?utf-8?B?dXpVVUcxdGZpUCtiUzNGdDExYmVNbWVBbzk5UEVWVnF1Q0o5enZxNElpTVFD?=
 =?utf-8?B?VDJ5TXdFN1NidUtRWmFLdGJWdVVqdVpUOXB4cXJPM1pJMkhJakorQS9GYTFZ?=
 =?utf-8?B?ZkZTNmVibVVkS2haMVp1Q0M3SDJSNHhYVUVzVG5Nek5TVEJnNXE5RmQrOEFn?=
 =?utf-8?B?WHUyTExKQjJxQmEyak5uS1BtZUlzSUFrSjdKN0NFN0ZtSUkwUnBZRTE4RGU0?=
 =?utf-8?B?NkovWUJMQ2VHTlhldElrU1pHSWJrdi96dHVWR3hxQjhwWFpLYUlVL0lwTnZo?=
 =?utf-8?B?UHNML0dQSTBZK29idzdJSGxGOFk3VnN6djJ5NCtpTjIxMU1lVEtlVmgxdmNZ?=
 =?utf-8?B?Tk1oTUl3RVBXOWdZc2lUaUR0Zmc1VmF6RTQybzBBcEFvVEh6UmpDMmxycmxk?=
 =?utf-8?B?eU9WZXgyZy9sS1U3alk0R3diNllmTVVvblZ5RlE0Y1lrWlhUWnBaQ3RKK2lC?=
 =?utf-8?B?aVpJUU5pNkw5cWRLaU5QSHZKYWp2OWtaNkJVYjN2US9lL1BjSnBIUWVSNGdu?=
 =?utf-8?B?UnpPbFkraVYrSlAyRSs3bC9NcXpkOW5lR0cxV214WTFKL3JXNisvc1JQNTgz?=
 =?utf-8?B?dzNLOFF2OWhxMENxMkRHdGUzSTNBTk9EcUt0WmF0WGMwMTZMeDNDYlNRS1pi?=
 =?utf-8?B?SW4xODZXdmFzeTZNdXhaVElQSWh4Wnp1MVBPbUMwa0xUUXpSN3A1YXlTejBn?=
 =?utf-8?B?dEFzOHhFeFdCZ2VYQ25wc3FtdjJXL3FXNDBYaFZSclh2NFJHYnJYMWFrR0Mz?=
 =?utf-8?B?dm5iMHNqd3hBb0E0ajFkRFowTHBCZUhSSlhqT2lYSjB2ekJUa2QzbHV2ekdl?=
 =?utf-8?B?QTQ1WG9Lb2lEdW5sakUyaCtLV2liWUdTMVJZbFNtRkhZTzA4S2U1eVI0Qkw0?=
 =?utf-8?B?dXdpdHEyTHRkekJmNC9CTll6R3huSzJ3cnRKWHJGNE5NV0RoRnU2MjA4THB1?=
 =?utf-8?B?b29PZWRvWUxZTjV5b2RxejhLR1BXOG9jcjZBaDFxRHVTeEJieDRCcFl6WHBp?=
 =?utf-8?B?aUxIQnNRQzBKVlp5NjdRV2ZYQWtZQVpQY1psUS9EaGJrV3ZzS3ltekE2UUho?=
 =?utf-8?B?YmNiMkpZNmVON0VrNDg1NkRtbHdpU2ZWVWViMjNwYTlZRHJ5eVdQRDVXbHA5?=
 =?utf-8?B?emM1STZQSWdHVWJOSkt4YW1nd2FNK3dSdlp3N240cXFQaTdBelRBTmtwdElI?=
 =?utf-8?B?YTgxRU9jRUJGMDFBT2lqYTYwQ1Eyb1RWMG5xN1RXREF3aDA4b3laOWJJbUsw?=
 =?utf-8?Q?hZTCVS3OgqdhW1kt46lvkY+Sl?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: dJdULTa+TRBTbdym0HwQ0mHSp1E3j0kn1r5ou5yzWDSR5YPqzhrgAFQw+VD8M6yoDq2anNpAxulIuPVhl/WOFbIzDc4kH73hlvn0qaO6nQuoBaFHSQ3+u7B/jemSeBGQZhPBBTVyXtwQThgxpMGuy18CA10okDVdLUlFtut4TyNolh8x2rKzvg6a9/DigDuJ3sJB5pLyTFBIIDSaP42xQuM2jFJEWuqaTC7w+tJM4VW8y+d5RMnQvU9qsJrseuvVQAnRoXCvw+lCsUfuBdSfOfk4l/5qf0RlR7jUHrOddCe1i/m02Fua8c0ok3Q51vszjdkOZBGQp4B+TszgxFNY4iq9S14IOKW/yBsIneMj/fM+0AeySpVS5DTSHKzvYVTRjLKMokyM3ZezOWd5UHLJYtRzXGNiDj5256tlkybbaqh0dV/kydllM8GsKbDDLHgQWewO4mZ02s6UK7YfbHqK1LWToVsp6UGW8exdP2V9MbE95RjGUOQ94dVR0kfviTMpTvhoBdWtOABeK0Q9E1qBynFGwvhwqGvmDHX+bRyxnjm/UGu6lyjfa4O8rU3DUaDDCoctMZDekXtRH3WkqLLdZkV+J+jzsOqen1nbiyieuUFB5TXNvy6uA+ILQ0CN05RN3HimNd2V9aApnEymFlC0mNBYOHGU3d6pin4MpYwjKjaQS8KT3/eB6ugQcghkk6JrErYv4Aa3xaJru/Kv7n4myO6mhgdjKIG0/78a0OFd2k3Qf2UBGfc/jm5q8G8S9g+P11EYprl635+Q/ZAuUiZxR2JOeeve+NtBYA3XtEJ4uO67wjJjZCfS2os6InNev2IoP5rV9+VJDccLoPc1jl9anWcmVCqJzLiGkFzbXVlCM/8eZFDkFBmEEuSqqvo3tPYm
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42828182-005c-4b9e-f62a-08dac85f2d19
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2022 05:47:13.0154
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QqU0JiuRkAaZV5zueZvyPm5362Z/cys6XDkkLjF6FmVt2rsveejJPcw2Q+w46C2yv9JfVe15yUmRame8+1cryQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR04MB4134
X-Proofpoint-ORIG-GUID: rJ5AGAwZOHHadBgqnPNA1WELoxmTkw3v
X-Proofpoint-GUID: rJ5AGAwZOHHadBgqnPNA1WELoxmTkw3v
X-Sony-Outbound-GUID: rJ5AGAwZOHHadBgqnPNA1WELoxmTkw3v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-17_02,2022-11-16_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

U2luY2Ugc3RydWN0IGV4ZmF0X2VudHJ5X3NldF9jYWNoZSBpcyBhbGxvY2F0ZWQgZnJvbSBzdGFj
aywNCm5vIG5lZWQgdG8gZnJlZSwgc28gcmVuYW1lIGV4ZmF0X2ZyZWVfZGVudHJ5X3NldCgpIHRv
DQpleGZhdF9wdXRfZGVudHJ5X3NldCgpLiBBZnRlciByZW5hbWluZywgdGhlIG5ldyBmdW5jdGlv
biBwYWlyDQppcyBleGZhdF9nZXRfZGVudHJ5X3NldCgpL2V4ZmF0X3B1dF9kZW50cnlfc2V0KCku
DQoNClNpZ25lZC1vZmYtYnk6IFl1ZXpoYW5nIE1vIDxZdWV6aGFuZy5Nb0Bzb255LmNvbT4NClJl
dmlld2VkLWJ5OiBBbmR5IFd1IDxBbmR5Lld1QHNvbnkuY29tPg0KUmV2aWV3ZWQtYnk6IEFveWFt
YSBXYXRhcnUgPHdhdGFydS5hb3lhbWFAc29ueS5jb20+DQotLS0NCiBmcy9leGZhdC9kaXIuYyAg
ICAgIHwgMTYgKysrKysrKystLS0tLS0tLQ0KIGZzL2V4ZmF0L2V4ZmF0X2ZzLmggfCAgMiArLQ0K
IGZzL2V4ZmF0L2lub2RlLmMgICAgfCAgMiArLQ0KIGZzL2V4ZmF0L25hbWVpLmMgICAgfCAgMiAr
LQ0KIDQgZmlsZXMgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRpb25zKC0pDQoN
CmRpZmYgLS1naXQgYS9mcy9leGZhdC9kaXIuYyBiL2ZzL2V4ZmF0L2Rpci5jDQppbmRleCBhM2Zi
NjA5ZGQxMjkuLmE5YTBiM2U0NmFmMiAxMDA2NDQNCi0tLSBhL2ZzL2V4ZmF0L2Rpci5jDQorKysg
Yi9mcy9leGZhdC9kaXIuYw0KQEAgLTU1LDcgKzU1LDcgQEAgc3RhdGljIHZvaWQgZXhmYXRfZ2V0
X3VuaW5hbWVfZnJvbV9leHRfZW50cnkoc3RydWN0IHN1cGVyX2Jsb2NrICpzYiwNCiAJCXVuaW5h
bWUgKz0gRVhGQVRfRklMRV9OQU1FX0xFTjsNCiAJfQ0KIA0KLQlleGZhdF9mcmVlX2RlbnRyeV9z
ZXQoJmVzLCBmYWxzZSk7DQorCWV4ZmF0X3B1dF9kZW50cnlfc2V0KCZlcywgZmFsc2UpOw0KIH0N
CiANCiAvKiByZWFkIGEgZGlyZWN0b3J5IGVudHJ5IGZyb20gdGhlIG9wZW5lZCBkaXJlY3Rvcnkg
Ki8NCkBAIC02MDIsNyArNjAyLDcgQEAgdm9pZCBleGZhdF91cGRhdGVfZGlyX2Noa3N1bV93aXRo
X2VudHJ5X3NldChzdHJ1Y3QgZXhmYXRfZW50cnlfc2V0X2NhY2hlICplcykNCiAJZXMtPm1vZGlm
aWVkID0gdHJ1ZTsNCiB9DQogDQotaW50IGV4ZmF0X2ZyZWVfZGVudHJ5X3NldChzdHJ1Y3QgZXhm
YXRfZW50cnlfc2V0X2NhY2hlICplcywgaW50IHN5bmMpDQoraW50IGV4ZmF0X3B1dF9kZW50cnlf
c2V0KHN0cnVjdCBleGZhdF9lbnRyeV9zZXRfY2FjaGUgKmVzLCBpbnQgc3luYykNCiB7DQogCWlu
dCBpLCBlcnIgPSAwOw0KIA0KQEAgLTg2MCw3ICs4NjAsNyBAQCBpbnQgZXhmYXRfZ2V0X2RlbnRy
eV9zZXQoc3RydWN0IGV4ZmF0X2VudHJ5X3NldF9jYWNoZSAqZXMsDQogDQogCWVwID0gZXhmYXRf
Z2V0X2RlbnRyeV9jYWNoZWQoZXMsIDApOw0KIAlpZiAoIWV4ZmF0X3ZhbGlkYXRlX2VudHJ5KGV4
ZmF0X2dldF9lbnRyeV90eXBlKGVwKSwgJm1vZGUpKQ0KLQkJZ290byBmcmVlX2VzOw0KKwkJZ290
byBwdXRfZXM7DQogDQogCW51bV9lbnRyaWVzID0gdHlwZSA9PSBFU19BTExfRU5UUklFUyA/DQog
CQllcC0+ZGVudHJ5LmZpbGUubnVtX2V4dCArIDEgOiB0eXBlOw0KQEAgLTg4Miw3ICs4ODIsNyBA
QCBpbnQgZXhmYXRfZ2V0X2RlbnRyeV9zZXQoc3RydWN0IGV4ZmF0X2VudHJ5X3NldF9jYWNoZSAq
ZXMsDQogCQkJaWYgKHBfZGlyLT5mbGFncyA9PSBBTExPQ19OT19GQVRfQ0hBSU4pDQogCQkJCWNs
dSsrOw0KIAkJCWVsc2UgaWYgKGV4ZmF0X2dldF9uZXh0X2NsdXN0ZXIoc2IsICZjbHUpKQ0KLQkJ
CQlnb3RvIGZyZWVfZXM7DQorCQkJCWdvdG8gcHV0X2VzOw0KIAkJCXNlYyA9IGV4ZmF0X2NsdXN0
ZXJfdG9fc2VjdG9yKHNiaSwgY2x1KTsNCiAJCX0gZWxzZSB7DQogCQkJc2VjKys7DQpAQCAtODkw
LDcgKzg5MCw3IEBAIGludCBleGZhdF9nZXRfZGVudHJ5X3NldChzdHJ1Y3QgZXhmYXRfZW50cnlf
c2V0X2NhY2hlICplcywNCiANCiAJCWJoID0gc2JfYnJlYWQoc2IsIHNlYyk7DQogCQlpZiAoIWJo
KQ0KLQkJCWdvdG8gZnJlZV9lczsNCisJCQlnb3RvIHB1dF9lczsNCiAJCWVzLT5iaFtlcy0+bnVt
X2JoKytdID0gYmg7DQogCX0NCiANCkBAIC04OTgsMTIgKzg5OCwxMiBAQCBpbnQgZXhmYXRfZ2V0
X2RlbnRyeV9zZXQoc3RydWN0IGV4ZmF0X2VudHJ5X3NldF9jYWNoZSAqZXMsDQogCWZvciAoaSA9
IDE7IGkgPCBudW1fZW50cmllczsgaSsrKSB7DQogCQllcCA9IGV4ZmF0X2dldF9kZW50cnlfY2Fj
aGVkKGVzLCBpKTsNCiAJCWlmICghZXhmYXRfdmFsaWRhdGVfZW50cnkoZXhmYXRfZ2V0X2VudHJ5
X3R5cGUoZXApLCAmbW9kZSkpDQotCQkJZ290byBmcmVlX2VzOw0KKwkJCWdvdG8gcHV0X2VzOw0K
IAl9DQogCXJldHVybiAwOw0KIA0KLWZyZWVfZXM6DQotCWV4ZmF0X2ZyZWVfZGVudHJ5X3NldChl
cywgZmFsc2UpOw0KK3B1dF9lczoNCisJZXhmYXRfcHV0X2RlbnRyeV9zZXQoZXMsIGZhbHNlKTsN
CiAJcmV0dXJuIC1FSU87DQogfQ0KIA0KZGlmZiAtLWdpdCBhL2ZzL2V4ZmF0L2V4ZmF0X2ZzLmgg
Yi9mcy9leGZhdC9leGZhdF9mcy5oDQppbmRleCAzNjNiOThiYmZkZDQuLmJkNmNjZGUxOTBhNyAx
MDA2NDQNCi0tLSBhL2ZzL2V4ZmF0L2V4ZmF0X2ZzLmgNCisrKyBiL2ZzL2V4ZmF0L2V4ZmF0X2Zz
LmgNCkBAIC00OTIsNyArNDkyLDcgQEAgc3RydWN0IGV4ZmF0X2RlbnRyeSAqZXhmYXRfZ2V0X2Rl
bnRyeV9jYWNoZWQoc3RydWN0IGV4ZmF0X2VudHJ5X3NldF9jYWNoZSAqZXMsDQogaW50IGV4ZmF0
X2dldF9kZW50cnlfc2V0KHN0cnVjdCBleGZhdF9lbnRyeV9zZXRfY2FjaGUgKmVzLA0KIAkJc3Ry
dWN0IHN1cGVyX2Jsb2NrICpzYiwgc3RydWN0IGV4ZmF0X2NoYWluICpwX2RpciwgaW50IGVudHJ5
LA0KIAkJdW5zaWduZWQgaW50IHR5cGUpOw0KLWludCBleGZhdF9mcmVlX2RlbnRyeV9zZXQoc3Ry
dWN0IGV4ZmF0X2VudHJ5X3NldF9jYWNoZSAqZXMsIGludCBzeW5jKTsNCitpbnQgZXhmYXRfcHV0
X2RlbnRyeV9zZXQoc3RydWN0IGV4ZmF0X2VudHJ5X3NldF9jYWNoZSAqZXMsIGludCBzeW5jKTsN
CiBpbnQgZXhmYXRfY291bnRfZGlyX2VudHJpZXMoc3RydWN0IHN1cGVyX2Jsb2NrICpzYiwgc3Ry
dWN0IGV4ZmF0X2NoYWluICpwX2Rpcik7DQogDQogLyogaW5vZGUuYyAqLw0KZGlmZiAtLWdpdCBh
L2ZzL2V4ZmF0L2lub2RlLmMgYi9mcy9leGZhdC9pbm9kZS5jDQppbmRleCBjZGNmMDM3YTMwNGYu
LmE4NGVhZTcyNTU2ZCAxMDA2NDQNCi0tLSBhL2ZzL2V4ZmF0L2lub2RlLmMNCisrKyBiL2ZzL2V4
ZmF0L2lub2RlLmMNCkBAIC04Myw3ICs4Myw3IEBAIGludCBfX2V4ZmF0X3dyaXRlX2lub2RlKHN0
cnVjdCBpbm9kZSAqaW5vZGUsIGludCBzeW5jKQ0KIAl9DQogDQogCWV4ZmF0X3VwZGF0ZV9kaXJf
Y2hrc3VtX3dpdGhfZW50cnlfc2V0KCZlcyk7DQotCXJldHVybiBleGZhdF9mcmVlX2RlbnRyeV9z
ZXQoJmVzLCBzeW5jKTsNCisJcmV0dXJuIGV4ZmF0X3B1dF9kZW50cnlfc2V0KCZlcywgc3luYyk7
DQogfQ0KIA0KIGludCBleGZhdF93cml0ZV9pbm9kZShzdHJ1Y3QgaW5vZGUgKmlub2RlLCBzdHJ1
Y3Qgd3JpdGViYWNrX2NvbnRyb2wgKndiYykNCmRpZmYgLS1naXQgYS9mcy9leGZhdC9uYW1laS5j
IGIvZnMvZXhmYXQvbmFtZWkuYw0KaW5kZXggOGQ3MjUyN2RmYjc4Li41NzUxMGQ3ZjU4Y2YgMTAw
NjQ0DQotLS0gYS9mcy9leGZhdC9uYW1laS5jDQorKysgYi9mcy9leGZhdC9uYW1laS5jDQpAQCAt
Njc2LDcgKzY3Niw3IEBAIHN0YXRpYyBpbnQgZXhmYXRfZmluZChzdHJ1Y3QgaW5vZGUgKmRpciwg
c3RydWN0IHFzdHIgKnFuYW1lLA0KIAkJCSAgICAgZXAtPmRlbnRyeS5maWxlLmFjY2Vzc190aW1l
LA0KIAkJCSAgICAgZXAtPmRlbnRyeS5maWxlLmFjY2Vzc19kYXRlLA0KIAkJCSAgICAgMCk7DQot
CWV4ZmF0X2ZyZWVfZGVudHJ5X3NldCgmZXMsIGZhbHNlKTsNCisJZXhmYXRfcHV0X2RlbnRyeV9z
ZXQoJmVzLCBmYWxzZSk7DQogDQogCWlmIChlaS0+c3RhcnRfY2x1ID09IEVYRkFUX0ZSRUVfQ0xV
U1RFUikgew0KIAkJZXhmYXRfZnNfZXJyb3Ioc2IsDQotLSANCjIuMjUuMQ0KDQo=
