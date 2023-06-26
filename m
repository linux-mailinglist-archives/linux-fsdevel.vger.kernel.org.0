Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0677173E6F7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 19:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbjFZRy1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 13:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjFZRyZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 13:54:25 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618DC186;
        Mon, 26 Jun 2023 10:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1687802064; x=1719338064;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=3iMSSC5n26Zsr/mtHM0DTXZG8oQ7PNP4Y0/dp2yOKj8=;
  b=qPQcuyFmFeULHU/RpMoXT0PlnhNGL4FnVCEv1Q8mRo4lG/pEPqgwqOlk
   gTGNcnO8aQTeGLwYLM7kQSG2hPfZN2+b8d1iHEvU0L2EvK2qnB0BAXKZJ
   f4DCBLZySczvFfpfL82620RWS0kvarqZ5UmnCEJPYNbtgObHamyclsYCM
   XR3AW3q9NH+lw2om6k3UibpSfyDmE72/EZTR11U190CQA+SB8ibcyFTJ4
   blhwsBnjAslY1ifsY1fkGQQkxBqM+fjI/lRzr5K5anmWAtqCGQZWNA/lp
   s+eObbnGioi48wbRyaWRWlDLI8g95ATRjbYpu2cT++xvN9J73cfUOWLrs
   A==;
X-IronPort-AV: E=Sophos;i="6.01,160,1684771200"; 
   d="scan'208";a="234955493"
Received: from mail-mw2nam04lp2172.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.172])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jun 2023 01:54:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UN8ITbIs4wsqwDrdYBYRWo81wdb9hYyZnU6IMhEZzMzWcWHG6vx0C/v5r01/CqCTMQVhcIvTPuCAbadL/wU/Ojh+JpMYlMxUTYj2iKggkIA0uXatVOdGX0+EP1XMoi1gVCLOtJnjVHXRrFsAGbfJuF7qFHWWmR7YQgt1a3lTIL8yFCAVzv9zKP/AXf9EU6Sbi9F75n6ZHbBXrFgIH+FonbYBaCwxg28GioecicX5f8ZTrhm1gF1GXUwTpO04AAAqdmen93Kjf1o3y6iseqaGblKf53ieImyI+olQhsAF7IG2gHGXzHQHFXozoXzM8XpCIHNY6ZDJduxannGk+VT46A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3iMSSC5n26Zsr/mtHM0DTXZG8oQ7PNP4Y0/dp2yOKj8=;
 b=bB487E1MAnuTxhMD6bSQwiKZ2Sll5Ewngl+0e1K3MHoj0wimLH4pCcDKaECuqXKBF4W0AHuBz3oFCCvrOhLyIKY8VFTVa0oWfYXOriKQjsTgghAiTVobOE4laGnUcGoLS/lvtbBkB5sM1MaCk/7chwqUe2x83gUcB3rIBL34xxSdMAI90i/2+EyBTGLjj9CyoEh/fJ5BMkeDcjOOI0i3iXKfd767dr0CLmdJ/G1wK6MzVU89wKcKHDnbvG3MYAsdnfG+W6wrPzr+4Tci0eMbgQljYxz159zJiaMxivruA6AbvimUXbWl/oWbGkwJvKNrRQSOMrnes/ueChO7JaBjdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3iMSSC5n26Zsr/mtHM0DTXZG8oQ7PNP4Y0/dp2yOKj8=;
 b=XOhJ2T6QIpgxTB4NTDs4EG1uir8PTkHir51lQ/835LbPGLQcus/N1AYEHRIkVoQDFrw2s4+JqMGoHA5TjsafSXHAb9SjBd21++XDVynl1yTm9bjGeUJW7P5+3nl5DWRM/gmxWYr54MNFRFIcnYRpOQr/o9GZiFxvRaRf+6jnwg0=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BY5PR04MB6597.namprd04.prod.outlook.com (2603:10b6:a03:1c5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Mon, 26 Jun
 2023 17:54:20 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::23cf:dbe4:375c:9936]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::23cf:dbe4:375c:9936%6]) with mapi id 15.20.6521.026; Mon, 26 Jun 2023
 17:54:20 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Andreas Hindborg <nmi@metaspace.dk>,
        Damien Le Moal <dlemoal@kernel.org>
CC:     "open list:ZONEFS FILESYSTEM" <linux-fsdevel@vger.kernel.org>,
        "gost.dev@samsung.com" <gost.dev@samsung.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] zonefs: do not use append if device does not support it
Thread-Topic: [PATCH] zonefs: do not use append if device does not support it
Thread-Index: AQHZqFc77K4pcBTEXkyHScjw5nQ+Gg==
Date:   Mon, 26 Jun 2023 17:54:20 +0000
Message-ID: <02730282-88b0-572e-439c-719cfef379bb@wdc.com>
References: <20230626164752.1098394-1-nmi@metaspace.dk>
In-Reply-To: <20230626164752.1098394-1-nmi@metaspace.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BY5PR04MB6597:EE_
x-ms-office365-filtering-correlation-id: bccc66e5-4e2b-4375-d90a-08db766e5e68
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bBt0ovAY9DopSYl9Vsj7fsm1DOR6NGVkX5d/wE2v1eyoJCOX7sFPx9v7rVlMBzHJM5n7kwKnrzf4NA1a+CUv0tMh4pazKKUV3D5rXKTMetSZuJ8sSDmHJtXrf+Iz7BW8I9T+x2hSKdhDKM3R+0G40qmTd9I8bzndoMU9A0fZvLsJo9fW/7bEu/ftSu0IigLJyPQVvpSMAg7n6Pou2y/iwVqd9wkw05C2jakpDQdByr0ibIyVWCcvBSptUUvuHVRrp4LN2kb9PgBr+foxnik6llN6dtBMxKSpWeA0Jd8VLlmcuIbthp3xzaU4SkumdzxWDQMLlik9sycL2Fc6MjyE3F++LClrzmbTq2kKByqfwWQiggMRKi/BEedDmCvctcU+pDH9F4jjNd5dVbGN2CCn3GJyLerucsuDZ4RbKdns7WzvVBzeJXQdlCDW/vAFe5jTgBRipdme3LPKD3s4fkpnQqLGTi7grHEooDpI9arF1Wc2FYv8ZeufQOL6m+m9GyoRnneq5QPpKBHDiGbbTKD7lG7T0reiQSOkjwOGPxRmXTnxBOop1U0fhpCaH21IGJzZpTGAvOp4YuJJovnCSNr29HpYl31etzkVJNqhHKBcMAYe3KaI7Un7R0b7zeOVFzkCk9BZ981g2WLBcrON0M4QlxGPnidDMNAZ3aMUqvgbCt1QOH7KCeZ/CXw7A+TNCqA/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39860400002)(396003)(376002)(366004)(451199021)(36756003)(6506007)(6486002)(2616005)(54906003)(478600001)(110136005)(83380400001)(186003)(66446008)(53546011)(71200400001)(2906002)(4744005)(5660300002)(38100700002)(122000001)(316002)(82960400001)(76116006)(91956017)(31696002)(66946007)(8936002)(8676002)(41300700001)(86362001)(4326008)(66556008)(66476007)(38070700005)(64756008)(31686004)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M1VpTnpadU5FSUgzNkg1cWdsS1Z2TkZpSnVHVHZjRFNqditSNGh3NEFBNXFm?=
 =?utf-8?B?QUhEbDA1bXoyN01TVmdpVzJ3YmFvcTlocnZwVzN6WCtMRkhIaEV0NXlsaVY2?=
 =?utf-8?B?Tzc4ZkcxQlM3aitha2sxT0JjZDhpbndvQjRLNiswb01xR2tOeGUxdXAxcE9F?=
 =?utf-8?B?Rzc4OStETVlrUndiTGxrTkJtcjFZK01XNm1WRGtuMXRYZzBpQ3YrU3dLRTFu?=
 =?utf-8?B?TUhSWkVEVUk5algybDBUa2tCT3RNUjZocVRSSlR4RURhWWR2YWlUMXUvZ2Fs?=
 =?utf-8?B?dlVibW5wUnFjbVg1Wmg4bldJeG9DZE5YbGhTVUpIZ24yVkkzVkhOZ1dYckVM?=
 =?utf-8?B?UER4d2hSbEU4bDRiS045Skl0T2pQSU10ZE9ZekF4QUxYQlVCZ2FMRWxKUytE?=
 =?utf-8?B?aGZQWFZJOGpQb0RocjNEaFQyUmtXY1MrNEtWUnAzR1NVeWhJd01UNWUveDA2?=
 =?utf-8?B?dTBXQVI3OGhvVEd6aDQwcUU2R3hDb1JkK25jV1I3Vzl5VXJGMWJyRExCbjVn?=
 =?utf-8?B?WXV1ei82RUJBTWg1aFNWWTdsSTUrUDduaTVBYW9BSGFNSUllQzV3WTg4ZEs0?=
 =?utf-8?B?R1Zka3k0TSszaWNtZUVsV1JFbEhSVGxJMHgzeUdSQnN0N0ZzTmNzY3h2SVhE?=
 =?utf-8?B?UE14QzJIL1RUb2Zjcm4rblZPNzRSZUcySXE4NnYyaXBURlBqKzhCcm5xam9K?=
 =?utf-8?B?Y05IUHJsNDBJSUJmK09XeEZFWklOZVE3MWlyOWg0YUhITmsrRkR1RWkwTTBN?=
 =?utf-8?B?R1pPdi96eGZ1dC9neHJCRnNNKzBKR1VOdHcwRFFLdndGT2ppbVlJczJQbTNY?=
 =?utf-8?B?NjZwenR2bWxiOG40cVpjZjJ0ejlUZzNkNVpDazFkTVIwZzgzb3lkdHhWK3FY?=
 =?utf-8?B?YmFJb2RvK3R0TUtNMXZBT0gyaDB6bEJ3M05HcnhmbmFGMm5vQThwNHJmWSsy?=
 =?utf-8?B?N2c1cVdacWJRZHF4VFppbjhPMnVzT3NCN0xwcHREL201QURMakJmNWQ0eXg5?=
 =?utf-8?B?WS9uR3hvaExFZ0pydnB0SGh2UnVHQnp6VHdyZ2crdkJ5dzdDRXBIZStJOUR5?=
 =?utf-8?B?SDBrN0UyaEJiU2xNVzF3Z0tPZUxDWVpSUnpGYVJCN09DVzZmZ0Q1Nmt3WDlm?=
 =?utf-8?B?eEQrcmp1TFYxTlRBRlNDVHdobzk2enZPYndDTTZ6Z3Z2OTdnMzZGdExHWlFD?=
 =?utf-8?B?K2pHMmlSRi9sS01tMFNNOEczM3FrRnZYRzduR3l0Vkk3QWxQcnc1eEhFeVR1?=
 =?utf-8?B?ekpmT3FlQUgzbTZHelArc1huOXRTT3dIRy80M0RKOXcyYXJLSEdhZ2xwTUhZ?=
 =?utf-8?B?bHBMUlZoSTlzNnNzUVBwT3NrM1BKVG9TZDNYUHNsUU4rUm1OV01BS1ROcmpT?=
 =?utf-8?B?aWJYUSsvSFR1c0NlYWVBR0t6dGFYdEhNVFFod1NUcmR5UzFDV0VWNzIzdjVG?=
 =?utf-8?B?VkZUQ3VWTGNOcHk4eVQvR0lCbUxDWnNJUFdKMjJLS21Ba0lpdTFIUlFNellE?=
 =?utf-8?B?emFNOWZLTzVJR3R1TitGQVRUeEpsa0xxQUlkZS96blFpVG1jRnFkVlRUb2FU?=
 =?utf-8?B?b29vYW94RXkzcjZtTEVrWS9SVExBM0ZjdUpGTVFST2prNnlTaGhzdzBvWlA1?=
 =?utf-8?B?ZzhCc1ppaEIrMkV2c1VZT1Y5VGQ2MlNJQk0yYkVvZXlJa0N4YUlCdHZheTR2?=
 =?utf-8?B?T0xqc283cjR3cUhJcTB6OWJRSm9Iay9zbTIzL05uT243NHcvUlNSaWd0Z1E2?=
 =?utf-8?B?T3l3T1dQK2s2bXdYbVBSTjlpaVBOWXpiVG1XdEZycStaa3JXSlNEek9ia3hr?=
 =?utf-8?B?TE43VlUxbklYcytyanRvL2xnTGJNOWJYVm9WSUFjbDhlRjlKRVhqWFR2MW5q?=
 =?utf-8?B?MEo4aW1jcGNkSkFNTFRMaDlzeG4zK2lqYkVFalJCTXBrclNKTmNuMlZ0bXp0?=
 =?utf-8?B?a29scFBGRGZwZ0ljRFVuei96ZFlxbENNS3VOZEwwTTYwQ0JYUkhkQXdQN3d0?=
 =?utf-8?B?cFdGLzRhUG85RExDVkliVm9TbjI4OCt3WFdoMlAvZnZibGowYWkyMmNvcnY0?=
 =?utf-8?B?UzRwWk9YTWVWbnowVm1zakhSRmlMcnQ0SzFGRFlqUHZBek9WeDJybEhwSnlj?=
 =?utf-8?B?MFN6dEFrSzVFek5ESC9la2dnRlcrTlJyRUllSGpkOHJibjlrYXduVzR1eFJG?=
 =?utf-8?B?M2Yza2JiRlVGR0hlUTU3b0R3MGN3TC9UbkhkbmlIZzhJaG9sWGpzd2dhRy90?=
 =?utf-8?B?dmprcjA4aFpOelgvcWZqc1NVS1R3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <67A2ABE654D5BA41A5218A1DCB7AB30C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +Yzsy8yHgs5RFUvXczljirsGvwtdMCZ5Yaw9SNWh8a8OokDXwuPYROzCcTT9qJeHHwHdpxijjYXr6kgP2gPGHy8/RzRKtlgSbJLa26ZAopg3a+J0lyuDLB43u8TPuK4PU63EEBrLQ0flEy5fpbS1sZLmjuBRIJ+lsoAk3pL575B+uzxarMKpIegKV8x96Oh9s6OfzKBjqqOznT0fnDmFY52eiETm0kcT9hHQ/3UtCkm316mwnKlXu9WSXuFr+MNMKFUGrknDojeV7vPWARSsjv9gsZK/QNAGVdsiNjFZxSrz/yCbxrtgfxC6pmc6C4IoWCD62Nvvy+Whrzz0fu0EIuqalYXbVj3C06YN2wPkX2cNReMPf6LCWzTJejPCx4W0JBfd9Gmqce9uCxx6gdJPXRirr4EEbXhlbX0V0QVdW18IdJpXKdvw7jUbbw0ggCP9CSs1hivvhw0Bz3VIzmLPJNpiIhJgyuV2So9mM6Z8FQP5LHxspnXxn7ns44D2/pAJerOGCiinmcawn9lkLL5JD/rkqXmDam7kajVCnWHTr6UvyQmIl6TrpN8I3uKsr9feYQUOpF9dkcpiO1/GugF7PhHH4KQT3omRRRT+f4kgwHu6aLF3rG67ECBPuomy4wfgNXfhAgIrUj30uKOomBVjYtVd5zksW1Adqo70HFEiYyhF4S1cbL4CAZdfF4P3vTASCyPMY78r32CfC9RsArNPTvV73aHVcoOsDNU16PQP4++ipmJu4g+MEmIKWbm+rBJLnkmUXZyl2+4zyYxbvaYXLndnMvAoK/eJpjgv+tEGyddxJIsqGwiDXui3+wfuGn/wMyBgl+2wWQ0fGc6PMrnSYvy/K54i8mgSmiLn5AAFD6eOjh2sU1mCU0TmGj6i0eqV
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bccc66e5-4e2b-4375-d90a-08db766e5e68
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2023 17:54:20.5208
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bKjAnR7twbeGocleh4tA6a6f+R7ZN4FYMMjHcoZuDgFND3Q23kPEl7xwZpfOky4mQBMRKBfheMIHdYwukkxD9CsdwcU6PqYe5MKsV1ZVlHA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6597
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMjYuMDYuMjMgMTg6NDcsIEFuZHJlYXMgSGluZGJvcmcgd3JvdGU6DQo+IEZyb206ICJBbmRy
ZWFzIEhpbmRib3JnIChTYW1zdW5nKSIgPG5taUBtZXRhc3BhY2UuZGs+DQo+IA0KPiBab25lZnMg
d2lsbCB0cnkgdG8gdXNlIGB6b25lZnNfZmlsZV9kaW9fYXBwZW5kKClgIGZvciBkaXJlY3Qgc3lu
YyB3cml0ZXMgZXZlbiBpZg0KPiBkZXZpY2UgYG1heF96b25lX2FwcGVuZF9zZWN0b3JzYCBpcyB6
ZXJvLiBUaGlzIHdpbGwgY2F1c2UgdGhlIElPIHRvIGZhaWwgYXMgdGhlDQo+IGlvIHZlY3RvciBp
cyB0cnVuY2F0ZWQgdG8gemVyby4gSXQgYWxzbyBjYXVzZXMgYSBjYWxsIHRvDQo+IGBpbnZhbGlk
YXRlX2lub2RlX3BhZ2VzMl9yYW5nZSgpYCB3aXRoIGVuZCBzZXQgdG8gVUlOVF9NQVgsIHdoaWNo
IGlzIHByb2JhYmx5DQo+IG5vdCBpbnRlbnRpb25hbC4gVGh1cywgZG8gbm90IHVzZSBhcHBlbmQg
d2hlbiBkZXZpY2UgZG9lcyBub3Qgc3VwcG9ydCBpdC4NCj4gDQoNCkknbSBzb3JyeSBidXQgSSB0
aGluayBpdCBoYXMgYmVlbiBzdGF0ZWQgb2Z0ZW4gZW5vdWdoIHRoYXQgZm9yIExpbnV4IFpvbmUg
QXBwZW5kDQppcyBhIG1hbmRhdG9yeSBmZWF0dXJlIGZvciBhIFpvbmVkIEJsb2NrIERldmljZS4g
VGhlcmVmb3JlIHRoaXMgcGF0aCBpcyBlc3NlbnRpYWxseQ0KZGVhZCBjb2RlIGFzIG1heF96b25l
X2FwcGVuZF9zZWN0b3JzIHdpbGwgYWx3YXlzIGJlIGdyZWF0ZXIgdGhhbiB6ZXJvLg0KDQpTbyB0
aGlzIGlzIGEgY2xlYXIgTkFLIGZyb20gbXkgc2lkZS4NCg0KDQo=
