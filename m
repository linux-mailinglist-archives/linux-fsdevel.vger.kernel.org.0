Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E865064ADCC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Dec 2022 03:38:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234385AbiLMCia (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Dec 2022 21:38:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234319AbiLMCiC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Dec 2022 21:38:02 -0500
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 456351E71F;
        Mon, 12 Dec 2022 18:37:16 -0800 (PST)
Received: from pps.filterd (m0209322.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BD1YF57012328;
        Tue, 13 Dec 2022 02:37:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=S1; bh=4Tn8j2rkPQ6pIp8ncNbqL6SPmdDap+l2SdSAFKIjnDI=;
 b=UhMChztCSCDTD+jgrw3clB1n77sefKTIwX6yKPL50LaaxORXfKxh5kFnO8ZLoVrrCsiy
 y29o+B4XFlAf+ZdnqjOwe5bdOJGcxbgsPnLUNQYZ+mGGgOSc9GYO2TyVtw+XsFbpRpYT
 PXX+tdbokewwN60PsQeL1xMsiFhD/6SBwTRlBjYsVQYzW/9Iawf0d65aIQaWM2S/W59j
 7g85BHlLaT1vHbsfGGMcsGd//kK4nbr4TEgdwg1Z2jG76hiNYEAb0wc23uG0uicFj0Pj
 06vEhSlJeLAtzUmQI/cM3DoZJNKNY3lNJLwMILiyKlTqwlXjArw7QWcdaTBH5FO+jnlH kw== 
Received: from apc01-tyz-obe.outbound.protection.outlook.com (mail-tyzapc01lp2047.outbound.protection.outlook.com [104.47.110.47])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3mcgw7th26-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Dec 2022 02:37:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QELjKoHCcyYPiSeAp8HLX55FfqAQ5kw4UesUF6BHxM04siRoI6FnEZgwJzXtqbztP/3k8d8NGS8+DD+9Q3C415OTOmVZAbjWkQAq2ieqNDYK5szFbuptEIk9LKCTJIcCZoy9pFMg/VCgtZLaK88U6Qd0rSwCwfNvXaoTPaZykBwrXnhZ8/uncsNrsB3FwBRiSTqJnMv0rcZIx+8f2Lm7ehZ1/e9rgTCOwSMuL7IEvuEUpp1VhFiTvnhHFpUvpemlPs4qzjt2iPDlnrmpYmMbwicURbkDJ7NbI4kil0MiJcAmRoYU5XfD6y7PCELmEJD0HICp/cJQqMN3viRRr1MhPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Tn8j2rkPQ6pIp8ncNbqL6SPmdDap+l2SdSAFKIjnDI=;
 b=V7gCtbuUJKXbedIfEK0cc1abKbp4v3iUkwAfPPGKMB6zWlWjglpCvYokawn9FIvb7nOjkclDnqLcJjFX1zcrEiklKb2a0+LeKADz7F3A7BUw8dxJy6AQJ5/Z+W2IgfWaLN3sKRdVBMPh0caejhByKhvIj1FoPDi0ZKK6UE6F/Kj6R/yGPrAvFEpr3F1BiUQTmWySkoPAXuj7SZPTA78m7TqK9w/PKml0G5kRss2vs81fJGQ2HsCmwn+bXAI/W9a/7vij1d+Ha2IeOyGUFDQnSFkec0MUzVAPGkd0aX5xk/YAtbTMLznQkMXhyKxuB9yclgi2Ba5HtH+GLjzgTVdxeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by SEZPR04MB6948.apcprd04.prod.outlook.com (2603:1096:101:e1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.10; Tue, 13 Dec
 2022 02:37:02 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::c689:d665:b3a2:d4de]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::c689:d665:b3a2:d4de%7]) with mapi id 15.20.5924.009; Tue, 13 Dec 2022
 02:37:02 +0000
From:   "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To:     "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>,
        "linkinjeon@kernel.org" <linkinjeon@kernel.org>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>
Subject: [PATCH v2 4/7] exfat: remove argument 'size' from exfat_truncate()
Thread-Topic: [PATCH v2 4/7] exfat: remove argument 'size' from
 exfat_truncate()
Thread-Index: AdkOmgiDw4qXtseLTQWWkAs2aAiRcA==
Date:   Tue, 13 Dec 2022 02:37:02 +0000
Message-ID: <PUZPR04MB6316572D66FA70F8AF5015B281E39@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|SEZPR04MB6948:EE_
x-ms-office365-filtering-correlation-id: 2408866f-47d5-4102-4eab-08dadcb2eac5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 73CLvSnSfPJiI8v/bCE4trZjT91N5YeQfX3yXnuY/VNceUJnOQmsm+A37kEftU2VKo0ei0ciCjIWUBbP2A21NOIz+ejftzcuTOaOxwILEdek37dmZwgtyA+oonwxi2SLggzM2VsxVkzcbeRaGyuQ9koo0m0laWbTz+x2BLo8DEpANvaMWO46MMma/lDMoxRdA2/U2T7mLQBQE9oM1IXjNb4YagkHLTPI1MTBnKR52PdvP9O2ehOOyXILqVDw1kmiqBj5kA/9Og42RaHuYofUXrtsBA99GQ1B7pRjuyRvFiqOVJYMOs5UrHH1Z7m+TbWQWFxla/vKq5cqjg6QtdyJfoTnZAWGFGVvhQSOMmbv2Rmy9OXVKGl5qKOzi2wNwE0JqHz9KEN4xRu8OAp/40o/tlzxwO0Zq8jaAYrb+CygW3NM7I9mrc+4LYKUM8VvJsYWJIGDR8rgg1/+xIogE4c3sSVcedozMQ1WLA/Je+1zs+Y/4VAkNjWxnVouvzj48jkg+vHJhfoLXGlHF5BsArNH6iHLgc+lST/TA5P2H6iQd92eBt+XqpZarC9iwA73a2DMZBlvFy8hAJEkkqPoUbSgI8FStrYXyUXps9ZPdlAOnZaSAr3TdgJVjaYDThfmDG5gYh2pdjMQnnI4NMGKxrtYaxvyaT3PrSxlYs/BGIFI20rj5qEldUSHLlOzgUPgU5uooh/RVNionm8jTOK+5nqXEA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(136003)(366004)(346002)(396003)(451199015)(86362001)(82960400001)(38070700005)(2906002)(8936002)(4326008)(8676002)(66946007)(66476007)(66446008)(64756008)(66556008)(5660300002)(122000001)(38100700002)(33656002)(83380400001)(478600001)(110136005)(316002)(54906003)(71200400001)(76116006)(55016003)(52536014)(41300700001)(6506007)(7696005)(26005)(186003)(9686003)(107886003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c3JBQktRalR6WlM4T05zdU1McUxCRTRCczNHSHVRNXhKNUZPdW9qdi9QdEIr?=
 =?utf-8?B?czhnWU5iKzg3M1ljOElCQTFJak4xY0dLcFI3MFZuWmhxMTVHdEo1ZFVuL2xt?=
 =?utf-8?B?d21jNUNtKzhsa0ZHcWNIcUxBSnkvK0ROTldjZ0VraE1WTkpOVEhqanFtNk1T?=
 =?utf-8?B?OEJEVjE0cnkrdlN2cHVPcXQvd2MzSFV6Szh5bld4VXQ0T1Npd0NtZXNpV2h3?=
 =?utf-8?B?bjArenRpd09udHZpZXlhSFJpamJTMS9Yb0paMkdaY0tMZDFKb0ZrRUR5Z0h5?=
 =?utf-8?B?OXJyWm9uak1CUEJkcFhBVE9Cc1VJQytFU3JLU0pjbWE3UUVHOFVLSHU0aTM2?=
 =?utf-8?B?aXJPbG5xYW9WT1BKNE1SZ1B1VXhhcVBadFUxSmlTY3RnQzBPSW1mdHh2b2dw?=
 =?utf-8?B?Yzc0SzBweDVtclZ6MUFReHVNYzZEWmlSRkpNY3VxeEZzemJPcWdoaWdCaUZv?=
 =?utf-8?B?alUrRVUzaDJpK1RaNndxa3p0MjBYQ0N1K3B0N3hPaVVMeTdVak9JbFFNeXBp?=
 =?utf-8?B?Q2Nuck5RdGtCSkh6UHhZcVBVY3p1TVNsOVg5bi9La2ZRS3hDOXMyN25uVW1Q?=
 =?utf-8?B?S082MmFhczUyWnNBanR4Q2phMG82RGNWbjhvYzBiV0hhejZ6UmhtanB2WkVS?=
 =?utf-8?B?cXRMK3pTcWw5OTJ4L2sxdEFBRmlLZUJjWXpyVk5lcWY1R1hZVzh2dFdYcTJp?=
 =?utf-8?B?bTdrcEpGdjEwemFNdHdLdElNU1NHL3VyM2JxT3hSWUJLQTBDcGlMemJ4Smh6?=
 =?utf-8?B?L0JZVHo0Y2ErU0NUcEk0V0xZSitlcDAyK1J4b0xPSG1uSWsvVzZIQ092RDlp?=
 =?utf-8?B?a1F3VmlNUW1jSkJxck5PcHptUE83STZHMVlKa2RDWWpGUWh6cDRyNk9lc2h0?=
 =?utf-8?B?anBOZ09CUTZLZ1dVN0xhS2FXQmllU0dCS3Nrdm9HbkxoNVhkRUZGWWlSbUp4?=
 =?utf-8?B?U0NtYlRwa2tPUTVtQVpuMjNpTjNBbFhWcUd2RmJvRE5vTElucHdaZXRjemkv?=
 =?utf-8?B?MVJsbTc3anBIMnFUMkcrUWgyQmU4Ymt6YVJmRW8xMjM0WmRqSVZPNVQvVmF6?=
 =?utf-8?B?UXI5SGFjL1NTU1B4VXZZbFJvdWxqWDdWTGMzQkw1OERMMVhtMklFMElQTlJO?=
 =?utf-8?B?bXFUOElYdUp0ajRvMzloeTBEcG8zUm1lVU9Lb3g1bkFyY3ZkdmNkOUhvbkVF?=
 =?utf-8?B?b2VtOEg4clp4dkhPUUdKQU54c1hSL1RKQWxvUUJsY2Zya25BYUY0TlhsMGlD?=
 =?utf-8?B?cStsZWx2c01NMTJOVFBkUjlhUlhuZzRDOGg2U1NOM2JMUTFnVEY2RnR6Y0k5?=
 =?utf-8?B?RVJxYTRRUnd6WnNyWCtBYytHY1pQS3E5Z0hXWHpkTk1RZHU1MUFuT2lXYlMy?=
 =?utf-8?B?Z3JPVWFDaHl2cHZrV2pvQURDZ294RlJjSmpUcThhM1grSmdiZmhGUVdnSzZn?=
 =?utf-8?B?QVJLeExTV1VzekJCSzllMWFhUE1yZFRXN3NHcnFJQzBlbHQ2a1RGRjRid0VU?=
 =?utf-8?B?TTc5bVh6SDdacVF4RmtRU2ZJU2Vzc2xQREZNTFEwOVRycmhqSG94RFJhWnp0?=
 =?utf-8?B?ODBGTjdkV1FqaVBFM1VQaThWdkJYaEsvcEdwcC9nKy9NdWNpZDFzdDR5ZFN2?=
 =?utf-8?B?cHJ3eWxuUGFjWjRDSEFQdklvRC9tMVkvNjR1REk4STEyeTRScHJidGJTM0NS?=
 =?utf-8?B?K3hKTHcveUI0R1dEbEZQZ29RdDlnREl1Mk9QeVBmcEIzM2NNTkRvNDVDZWE2?=
 =?utf-8?B?TEY5ZFlGc25Zc0FoVHFMbzUxdGxYZUVsWWM1amlOS0RROUU0NlE4alNValNZ?=
 =?utf-8?B?WnJESzNEUzVoOW54a1FaWGFnN3JYc2RNOWxzdkhDQ1FKSnpOVERORmF1OGdV?=
 =?utf-8?B?KzN5Z1VFSkU0ZkExV0lyRlg4OWh0SnJVYVYrcXlObUNxNGgxNjBJekRHWWNO?=
 =?utf-8?B?WWpHdW5XZ0xTNnd2TURzek9Ya05Kd3dkaURmckJDNHMySmsvdGdUSC91Qnd6?=
 =?utf-8?B?b0sycC94cmRRcGhpbmpiTUVzTTlMWGdKbnQwMFRDbW50enlpdDdMZ3F2V2NQ?=
 =?utf-8?B?bVc3OXZ6R3h4UlRmQWwya3ZCb0NBb3YreTVpa2lzaDVJeUZGWFZ4WjBBUlZ2?=
 =?utf-8?Q?5ax0wSz0lwP3P4VmQ4LXVsVZn?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2408866f-47d5-4102-4eab-08dadcb2eac5
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2022 02:37:02.7122
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gHRNTYpJdDH+9fkWmBUCTC8Rm9bQ8G2F/ZAY7BcBEIf9aMGMUgLCGZRWKpYitNjsS9NC9EWq+99fJ/j9IHdX2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB6948
X-Proofpoint-ORIG-GUID: m-RLNV8RFcG8iwxBttdTVFp9PRA1253z
X-Proofpoint-GUID: m-RLNV8RFcG8iwxBttdTVFp9PRA1253z
X-Sony-Outbound-GUID: m-RLNV8RFcG8iwxBttdTVFp9PRA1253z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-12_02,2022-12-12_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

YXJndW1lbnQgJ3NpemUnIGlzIG5vdCB1c2VkIGluIGV4ZmF0X3RydW5jYXRlKCksIHJlbW92ZSBp
dC4NCg0KQ29kZSByZWZpbmVtZW50LCBubyBmdW5jdGlvbmFsIGNoYW5nZXMuDQoNClNpZ25lZC1v
ZmYtYnk6IFl1ZXpoYW5nIE1vIDxZdWV6aGFuZy5Nb0Bzb255LmNvbT4NClJldmlld2VkLWJ5OiBB
bmR5IFd1IDxBbmR5Lld1QHNvbnkuY29tPg0KUmV2aWV3ZWQtYnk6IEFveWFtYSBXYXRhcnUgPHdh
dGFydS5hb3lhbWFAc29ueS5jb20+DQotLS0NCiBmcy9leGZhdC9leGZhdF9mcy5oIHwgMiArLQ0K
IGZzL2V4ZmF0L2ZpbGUuYyAgICAgfCA0ICsrLS0NCiBmcy9leGZhdC9pbm9kZS5jICAgIHwgMiAr
LQ0KIDMgZmlsZXMgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KDQpk
aWZmIC0tZ2l0IGEvZnMvZXhmYXQvZXhmYXRfZnMuaCBiL2ZzL2V4ZmF0L2V4ZmF0X2ZzLmgNCmlu
ZGV4IDIxZmVjMDFkNjhmZi4uYWUwNDg4MDJmOWRiIDEwMDY0NA0KLS0tIGEvZnMvZXhmYXQvZXhm
YXRfZnMuaA0KKysrIGIvZnMvZXhmYXQvZXhmYXRfZnMuaA0KQEAgLTQ0OSw3ICs0NDksNyBAQCBp
bnQgZXhmYXRfdHJpbV9mcyhzdHJ1Y3QgaW5vZGUgKmlub2RlLCBzdHJ1Y3QgZnN0cmltX3Jhbmdl
ICpyYW5nZSk7DQogLyogZmlsZS5jICovDQogZXh0ZXJuIGNvbnN0IHN0cnVjdCBmaWxlX29wZXJh
dGlvbnMgZXhmYXRfZmlsZV9vcGVyYXRpb25zOw0KIGludCBfX2V4ZmF0X3RydW5jYXRlKHN0cnVj
dCBpbm9kZSAqaW5vZGUsIGxvZmZfdCBuZXdfc2l6ZSk7DQotdm9pZCBleGZhdF90cnVuY2F0ZShz
dHJ1Y3QgaW5vZGUgKmlub2RlLCBsb2ZmX3Qgc2l6ZSk7DQordm9pZCBleGZhdF90cnVuY2F0ZShz
dHJ1Y3QgaW5vZGUgKmlub2RlKTsNCiBpbnQgZXhmYXRfc2V0YXR0cihzdHJ1Y3QgdXNlcl9uYW1l
c3BhY2UgKm1udF91c2VybnMsIHN0cnVjdCBkZW50cnkgKmRlbnRyeSwNCiAJCSAgc3RydWN0IGlh
dHRyICphdHRyKTsNCiBpbnQgZXhmYXRfZ2V0YXR0cihzdHJ1Y3QgdXNlcl9uYW1lc3BhY2UgKm1u
dF91c2VybnMsIGNvbnN0IHN0cnVjdCBwYXRoICpwYXRoLA0KZGlmZiAtLWdpdCBhL2ZzL2V4ZmF0
L2ZpbGUuYyBiL2ZzL2V4ZmF0L2ZpbGUuYw0KaW5kZXggNGUwNzkzZjM1ZThmLi43Yzk3YzFkZjEz
MDUgMTAwNjQ0DQotLS0gYS9mcy9leGZhdC9maWxlLmMNCisrKyBiL2ZzL2V4ZmF0L2ZpbGUuYw0K
QEAgLTE4OSw3ICsxODksNyBAQCBpbnQgX19leGZhdF90cnVuY2F0ZShzdHJ1Y3QgaW5vZGUgKmlu
b2RlLCBsb2ZmX3QgbmV3X3NpemUpDQogCXJldHVybiAwOw0KIH0NCiANCi12b2lkIGV4ZmF0X3Ry
dW5jYXRlKHN0cnVjdCBpbm9kZSAqaW5vZGUsIGxvZmZfdCBzaXplKQ0KK3ZvaWQgZXhmYXRfdHJ1
bmNhdGUoc3RydWN0IGlub2RlICppbm9kZSkNCiB7DQogCXN0cnVjdCBzdXBlcl9ibG9jayAqc2Ig
PSBpbm9kZS0+aV9zYjsNCiAJc3RydWN0IGV4ZmF0X3NiX2luZm8gKnNiaSA9IEVYRkFUX1NCKHNi
KTsNCkBAIC0zMTAsNyArMzEwLDcgQEAgaW50IGV4ZmF0X3NldGF0dHIoc3RydWN0IHVzZXJfbmFt
ZXNwYWNlICptbnRfdXNlcm5zLCBzdHJ1Y3QgZGVudHJ5ICpkZW50cnksDQogCQkgKiBfX2V4ZmF0
X3dyaXRlX2lub2RlKCkgaXMgY2FsbGVkIGZyb20gZXhmYXRfdHJ1bmNhdGUoKSwgaW5vZGUNCiAJ
CSAqIGlzIGFscmVhZHkgd3JpdHRlbiBieSBpdCwgc28gbWFya19pbm9kZV9kaXJ0eSgpIGlzIHVu
bmVlZGVkLg0KIAkJICovDQotCQlleGZhdF90cnVuY2F0ZShpbm9kZSwgYXR0ci0+aWFfc2l6ZSk7
DQorCQlleGZhdF90cnVuY2F0ZShpbm9kZSk7DQogCQl1cF93cml0ZSgmRVhGQVRfSShpbm9kZSkt
PnRydW5jYXRlX2xvY2spOw0KIAl9IGVsc2UNCiAJCW1hcmtfaW5vZGVfZGlydHkoaW5vZGUpOw0K
ZGlmZiAtLWdpdCBhL2ZzL2V4ZmF0L2lub2RlLmMgYi9mcy9leGZhdC9pbm9kZS5jDQppbmRleCBk
YWM1MDAxYmFlOWUuLjBkMTQ3ZjhhMWY3YyAxMDA2NDQNCi0tLSBhL2ZzL2V4ZmF0L2lub2RlLmMN
CisrKyBiL2ZzL2V4ZmF0L2lub2RlLmMNCkBAIC0zNjIsNyArMzYyLDcgQEAgc3RhdGljIHZvaWQg
ZXhmYXRfd3JpdGVfZmFpbGVkKHN0cnVjdCBhZGRyZXNzX3NwYWNlICptYXBwaW5nLCBsb2ZmX3Qg
dG8pDQogCWlmICh0byA+IGlfc2l6ZV9yZWFkKGlub2RlKSkgew0KIAkJdHJ1bmNhdGVfcGFnZWNh
Y2hlKGlub2RlLCBpX3NpemVfcmVhZChpbm9kZSkpOw0KIAkJaW5vZGUtPmlfbXRpbWUgPSBpbm9k
ZS0+aV9jdGltZSA9IGN1cnJlbnRfdGltZShpbm9kZSk7DQotCQlleGZhdF90cnVuY2F0ZShpbm9k
ZSwgRVhGQVRfSShpbm9kZSktPmlfc2l6ZV9hbGlnbmVkKTsNCisJCWV4ZmF0X3RydW5jYXRlKGlu
b2RlKTsNCiAJfQ0KIH0NCiANCi0tIA0KMi4yNS4xDQoNCg==
