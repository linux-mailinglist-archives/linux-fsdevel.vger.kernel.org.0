Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1764D5096F4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Apr 2022 07:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384526AbiDUFuF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Apr 2022 01:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiDUFuD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Apr 2022 01:50:03 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2072.outbound.protection.outlook.com [40.107.113.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 939B211C0E;
        Wed, 20 Apr 2022 22:47:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uhnj7jIjWzKTjsy6s5bvVYshLQOC5krRYqU3xO2C2LlVzeHUIVL66pubHGXTklU9Ao0gZxhNU5pPBf3oLi0Lr3D0mfGiZfDLtBtXKZ8XwpfKWqvBm9DIi6Qpb+hLsGxiF3qkTvg5hXssOZVCzglfAKQLLQz8LWpV2FSlmOJC0YmbRshy8NY3wbjNcek1yIYRJpI87z87earXRc98KMjvMDLzZ/gVNduqbJtwq8sc4f7q9bMPxJ9uzlGe6QVv+OHNHi0DEe9WMkEvuWSnCXV4hZLZBMZC71h0z/dWCUI+oe1SgFSO1UyWJ51i1w9JClC7JsnZnhHx5VYr8cb93pkJKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YHQTp1tYfr+bwg9qrrN5Z8FudFwjaEalSaRrqjf7s+Q=;
 b=X2SApoLa8gQadG/WzJsdJaWmeWQeEcliYyhSHZ/3cfvbfuMs3crEvMeHSBjAksvFXdXEDq0wPCS9xW+4Hmc+SSBslXgYWu6ndAFu7OzB2DvLcn17MttE4FF59xMh+b/0Nm9icStNya6Z0jGlM69ZK/g1xlV0dXtexnOLrn6VmMHEi6g8Bg/75MlJugfTPYR0dsUuqpz66mvrw7Wgt+j2VEM4rO5zcJaJw7arbqDY0LWqL7wuDRT0aILdpzvkpnwz3qYmcc18WLBF7X2XXyC8CutZ4HKoVD73IRyOcZjmFxNUVeGyMi/zJJ/GvFY/HZD/CAA5XQwcZv1Xbbq/SsqJlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YHQTp1tYfr+bwg9qrrN5Z8FudFwjaEalSaRrqjf7s+Q=;
 b=Ai6S1gQElKKepi5hEqQnuoYtLXVKTld2kVPjPYN/sOkBlV7/iwrDkJ0Kw4Tum2tjn2498n0IxzAlwz1GxzQh/9YWGCZbfqy8ZSQgTHBYR348+2hs+aVgqzmxiov9srmKR71SCrcHStGXNOCfBBsII9E2q8l1vjQElf1SOtkHfh4=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by OS3PR01MB7112.jpnprd01.prod.outlook.com (2603:1096:604:128::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Thu, 21 Apr
 2022 05:47:09 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::9149:6fc9:1b62:1232]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::9149:6fc9:1b62:1232%8]) with mapi id 15.20.5164.025; Thu, 21 Apr 2022
 05:47:09 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Dave Chinner <david@fromorbit.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Jane Chu <jane.chu@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v13 0/7] fsdax: introduce fs query to support reflink
Thread-Topic: [PATCH v13 0/7] fsdax: introduce fs query to support reflink
Thread-Index: AQHYVSZdy/LF0YIifEOE92FVquUnTKz5yAgAgAAUFgA=
Date:   Thu, 21 Apr 2022 05:47:09 +0000
Message-ID: <20220421054656.GA3602272@hori.linux.bs1.fc.nec.co.jp>
References: <20220419045045.1664996-1-ruansy.fnst@fujitsu.com>
 <20220421012045.GR1544202@dread.disaster.area>
 <86cb0ada-208c-02de-dbc9-53c6014892c3@fujitsu.com>
 <CAPcyv4i0Noum8hqHtCpdM5HMVdmNHm3Aj2JCnZ+KZLgceiXYaA@mail.gmail.com>
 <20220421043502.GS1544202@dread.disaster.area>
In-Reply-To: <20220421043502.GS1544202@dread.disaster.area>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3bc47d82-8bfd-46ad-5ea5-08da235a6082
x-ms-traffictypediagnostic: OS3PR01MB7112:EE_
x-microsoft-antispam-prvs: <OS3PR01MB7112C9FAD34C8FF354E0B0E4E7F49@OS3PR01MB7112.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a841h6/rFzhx2UwmCK6OZgIynrbUzp14Tqu+YCqn8JP7w0wRKHnPPXvQUDtn5FgS9mL/rAqOmsqJOGgYPS5ZQLjft2p7wqQENYMUrNGNXwmGq2gvJFu8EWjkknw0AGrsCxroYAoC9GU3U5ruwYU/xSIBhkIMJrqYdMI4S4rVHJbnbTmg1seW8jJ1XR1fS7HtDFCWaWeFAdS7n8cwQuR5vL3A4jgsqejXKDjhb1T8GtJdKMeUAVtf2r/J/VVkQqtLobjqUpZpXL7zPqTz6TPEl14S4CYxyRoWxDvc0J9O1OG/J9fgV8yHlZYTGV5+SDngtgHjRcBA+bGDhF8eXf3TGDhqTqzzt73gQhyHIDpAOfEq3HMzt9EJK/VY70A2kmBY87yS77MxS1CZuVkTuxDyH1XhRzksfN/6bleS+StCAg7zm0tLei1fRxTcyTf3Wcwzh6Kotl0zJMx+bmyrOA6NY32ZUB8dmhYyTfjbCSAPaHTloCSf7lu6aelCgAuPs8j/tCMYX9Ed/18U96o3qYnbBhAPisl5oGtmuVfhcpLbAOG2crIQrLHG6sJFW9kcVRYSL0RVAjUnH/wvheD0kB9FWOvExHwExpK5p93uPbUuLKyGfRDvQjnoPjqkcjSlnaLBOxX3TN2dD571ymgCpkIQbiKdnDiqYUb5MlG+AlpliNnjZ40/LlCesYJW8GjVLdIoZG+FG1/5HQu98Nnn5pdEpGsJHP3qMwCnyn9gf0lKwmTXvXp7i8VE5rat7YQdSbQPpRW3pc6B2SD74tSknfjWIdHl9o9/zocDXlJfPaG2KYfQOHMyEwiVYwS+MpwsepDMptSDLG5XwrIA7aExjK05uA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(7416002)(66446008)(64756008)(8676002)(8936002)(316002)(76116006)(33656002)(66946007)(4326008)(66556008)(83380400001)(5660300002)(966005)(508600001)(54906003)(66476007)(85182001)(6916009)(6486002)(71200400001)(2906002)(9686003)(6512007)(86362001)(26005)(6506007)(82960400001)(55236004)(53546011)(38100700002)(1076003)(186003)(122000001)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SmhFR1EreHdsOE1nUFdBU0ttR2dWeXh6ZEQ4UGN2dWdBMC91N0ZoU0FHSUxF?=
 =?utf-8?B?YWpaOVpNcHNvRG5NSlZucjdZUm1WcjZnVjhHckZCSVNTMnZpRTF4TitxemxG?=
 =?utf-8?B?blZwVkpUQjBPQTkrNE9hZ25KcTJ3M3ZRTk5uTkxmcm5IL01WSmlDbHdNdW44?=
 =?utf-8?B?NmFQcEQxcGdlNExDNm9ua2JoU3ZIdzQ4Z0EzeCt3TTZmU1NJL2lManE2cWxq?=
 =?utf-8?B?ZWVnZnRKQ1o3cjA5dlArV1lkcHBLZTJtNnRsdWRjeklSQVlOa2JlT1JhbzFI?=
 =?utf-8?B?WkU1NnQ1SmNzblRXZGRxZEpBQ2ZTejVGS1V6bU5TblpVUjRTbXc2THVma1VZ?=
 =?utf-8?B?OUJhNm1xc3BpWTFPVkM2K0x4cU8zL3hZR3J1Wkd4TVJsRnBscGZsaVlOTzBz?=
 =?utf-8?B?YjhVQTZabk9Xc1d4aEZOcGwyTENVY3JoeGkxM0oyRzU2aDQreWlCVjVNSm1s?=
 =?utf-8?B?cEVzTUY0dTRzSFVzbkZkdGFsLy8xemNkbDhDd2pHMVEwKytnUkNNWG9DNEF5?=
 =?utf-8?B?eXk4aWlyWGR0aThRaEQ2aWlySkdlYXlkL0tkZEFGTVFzaEdEQVpPanM1Ry9o?=
 =?utf-8?B?Ujh4dmNmdkZtSXZFWlpWSmlaN2V6WGc0QitOeGJ3ZFFPL3p3bittcVovNnRE?=
 =?utf-8?B?NThyeitUM1hFbVdYNFhkc2EzdmZTdDJ6MGQ3dHZPQ1psRU81S0tLUjNiL2ZW?=
 =?utf-8?B?NlVySTdKL3FjRWtnc3pOWUV5eXNYdmx5cVlKVlNJVldHZDZoV1BEY2QzNnlN?=
 =?utf-8?B?cnFqSjBCY1AwRWN3QkRpc3NNeEdTWUVuMTJiOUhEVFcrU0ZSai9xZzQ0M3lY?=
 =?utf-8?B?UW5OOHI2TUxvWWduejBoNTJKRy9wc0NDamdvVWFwTUJTQnF6ejArdWwwdTNW?=
 =?utf-8?B?ZE43OHFCbnkxSFM5Y0xJekovWDlFZ01xdWZqVWlSanE5THlVSFMrWTVTZFZQ?=
 =?utf-8?B?L09GWFhFK2JHa1NkL2xPYWdxS1NJMXpTWTJWcGtjeSt1ZnZvbFkyQTlkQytB?=
 =?utf-8?B?OU5EQ2FEMGtpS2JqYVc1cDhXaklnS0VUakptR2tIMXFPZlNka2xBd0lCUDN5?=
 =?utf-8?B?TWF5VG1TTzZrMmdPSjdQL3lieEJLcEZMenRzK29hbHN2TFFMbXZncXVtdFd0?=
 =?utf-8?B?Y2ZDRXc5ZUsyakRLQ1JURlh0Y2Y0NktLMzVnVER0S0h3alpOYVJLV2lMOFZ5?=
 =?utf-8?B?ak1BU0hGR2lrYm1aL05YQ2ZSQ0dOWEFTb3JPc3J6SWp2N0xlcE4rRFoyeXZh?=
 =?utf-8?B?TURIdnRyNGFJZGE1UUFWYzVZRVNiSEhEYmpORFhPeXlhVjNNeGt4bWdsRHlC?=
 =?utf-8?B?TDc2ZWM1SmIydi8zSTFhanhDWGQ0Z2lEbTU2S1RHQXBwVmFRN3R2bnNIb0tZ?=
 =?utf-8?B?VndSNmh4RGtsdHNpU2gzZURtbis5a2tpaTZxWW83S0RvV2xwd1I5UEU0TEFV?=
 =?utf-8?B?eDVIanh4Q3JzbDNaa2pRWmEvTnBGdDBxRXRMOEhUcm9MQ01OOG5UeG5tSGZj?=
 =?utf-8?B?eFpURmdlWHcwbWNwczZhS28yamJ0Wk9zY3lWZG54TGI2bjhYOW1zWDI3MFFv?=
 =?utf-8?B?V2RWcXY3RDNaY2NYVGhZdVMvdzdzSnZhSC91TWQwUHVIYXFCak5QVUdzbEkx?=
 =?utf-8?B?VVFGN0pqRERqOTlVdHZjcFNmLzlVVVJJVVFmK2ZoMmJjLzdPbjM4NVAxZjVi?=
 =?utf-8?B?NjlWa2x0a205TGJPNmxRQU1tTjZFaklaemlOem8yQ0F4dFAyRGJydDZ0dUQy?=
 =?utf-8?B?WkJjU1Ztenh6REQwdjBnKys2UktadUFOdmVIY1ByQWh3RkxsYjlGa0Q0NWRJ?=
 =?utf-8?B?SndnaGhlcnZrSDF3MWhkY2o5Mm4ydC9xZVBzVU43dWhEbGNUM1NQT1FaMjAw?=
 =?utf-8?B?aENOM0UxSVlKU3lFUlNnUllLTGw3TmdjRkQ1Mkx3ZUZjZVJMSmV4TURMWDYw?=
 =?utf-8?B?ay9LaTBvY3FoZU1rVER0SW1GVWd3MjFXMGhFdzdiSVluSDI4eHpUY1N5eVdp?=
 =?utf-8?B?ZnFka1pTcGhldnBPdTlXbGxkOGJJRzc1dlVrVDFBQnpkSDB2Nm5XRGI2R3Jk?=
 =?utf-8?B?dy9ROEE5UEljYVlOamhjMnRRVk9OWnNISjB1OXdwM3BqUUxyR0UyN29oNHJs?=
 =?utf-8?B?d09Rb3lqbEVtRFdrd1NHYWlRdnpYcHBBNDR6RnVOcVgxbW1qeTJGaUhYR2U3?=
 =?utf-8?B?VzRYL3AvZTFtdHAyVXEvUG5uczloVGtSQ2JQSkJKUUE4ekhURFNVRXlES3Ny?=
 =?utf-8?B?cVdRNGNJSStvd3RRVE5YMEhLQ1R2UmZyTjV2QmpRc2RKd2VIeGpMNnM5OFcz?=
 =?utf-8?B?Tkg0a0VHblo0UjZrV3RnUC9QWEN5VVB2Ujh4K1RRWmpGZzh1L2tQU0l5Zmdq?=
 =?utf-8?Q?pRgl3Q9iOGx0S4Dg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8B5CC51B1E0D18449234FD439F627334@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bc47d82-8bfd-46ad-5ea5-08da235a6082
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2022 05:47:09.8907
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5E3VItHUw5AHdFvrKLuYWiABQXXySzhA9FXDC+v7WktFhHr1e1lBhsaYnzLtO0yfMz/MvBnAPIIsPs8B1Iut6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7112
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

SGkgZXZlcnlvbmUsDQoNCk9uIFRodSwgQXByIDIxLCAyMDIyIGF0IDAyOjM1OjAyUE0gKzEwMDAs
IERhdmUgQ2hpbm5lciB3cm90ZToNCj4gT24gV2VkLCBBcHIgMjAsIDIwMjIgYXQgMDc6MjA6MDdQ
TSAtMDcwMCwgRGFuIFdpbGxpYW1zIHdyb3RlOg0KPiA+IFsgYWRkIEFuZHJldyBhbmQgTmFveWEg
XQ0KPiA+IA0KPiA+IE9uIFdlZCwgQXByIDIwLCAyMDIyIGF0IDY6NDggUE0gU2hpeWFuZyBSdWFu
IDxydWFuc3kuZm5zdEBmdWppdHN1LmNvbT4gd3JvdGU6DQo+ID4gPg0KPiA+ID4gSGkgRGF2ZSwN
Cj4gPiA+DQo+ID4gPiDlnKggMjAyMi80LzIxIDk6MjAsIERhdmUgQ2hpbm5lciDlhpnpgZM6DQo+
ID4gPiA+IEhpIFJ1YW4sDQo+ID4gPiA+DQo+ID4gPiA+IE9uIFR1ZSwgQXByIDE5LCAyMDIyIGF0
IDEyOjUwOjM4UE0gKzA4MDAsIFNoaXlhbmcgUnVhbiB3cm90ZToNCj4gPiA+ID4+IFRoaXMgcGF0
Y2hzZXQgaXMgYWltZWQgdG8gc3VwcG9ydCBzaGFyZWQgcGFnZXMgdHJhY2tpbmcgZm9yIGZzZGF4
Lg0KPiA+ID4gPg0KPiA+ID4gPiBOb3cgdGhhdCB0aGlzIGlzIGxhcmdlbHkgcmV2aWV3ZWQsIGl0
J3MgdGltZSB0byB3b3JrIG91dCB0aGUNCj4gPiA+ID4gbG9naXN0aWNzIG9mIG1lcmdpbmcgaXQu
DQo+ID4gPg0KPiA+ID4gVGhhbmtzIQ0KPiA+ID4NCj4gPiA+ID4NCj4gPiA+ID4+IENoYW5nZXMg
c2luY2UgVjEyOg0KPiA+ID4gPj4gICAgLSBSZWJhc2VkIG9udG8gbmV4dC0yMDIyMDQxNA0KPiA+
ID4gPg0KPiA+ID4gPiBXaGF0IGRvZXMgdGhpcyBkZXBlbmQgb24gdGhhdCBpcyBpbiB0aGUgbGlu
dXgtbmV4dCBrZXJuZWw/DQo+ID4gPiA+DQo+ID4gPiA+IGkuZS4gY2FuIHRoaXMgYmUgYXBwbGll
ZCBzdWNjZXNzZnVsbHkgdG8gYSB2NS4xOC1yYzIga2VybmVsIHdpdGhvdXQNCj4gPiA+ID4gbmVl
ZGluZyB0byBkcmFnIGluIGFueSBvdGhlciBwYXRjaHNldHMvY29tbWl0cy90cmVlcz8NCj4gPiA+
DQo+ID4gPiBGaXJzdGx5LCBJIHRyaWVkIHRvIGFwcGx5IHRvIHY1LjE4LXJjMiBidXQgaXQgZmFp
bGVkLg0KPiA+ID4NCj4gPiA+IFRoZXJlIGFyZSBzb21lIGNoYW5nZXMgaW4gbWVtb3J5LWZhaWx1
cmUuYywgd2hpY2ggYmVzaWRlcyBteSBQYXRjaC0wMg0KPiA+ID4gICAgIm1tL2h3cG9pc29uOiBm
aXggcmFjZSBiZXR3ZWVuIGh1Z2V0bGIgZnJlZS9kZW1vdGlvbiBhbmQNCj4gPiA+IG1lbW9yeV9m
YWlsdXJlX2h1Z2V0bGIoKSINCj4gPiA+DQo+ID4gPiBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1
Yi9zY20vbGludXgva2VybmVsL2dpdC9uZXh0L2xpbnV4LW5leHQuZ2l0L2NvbW1pdC8/aWQ9NDIz
MjI4Y2U5M2M2YTI4MzEzMmJlMzhkNDQyMTIwYzhlNGNkYjA2MQ0KDQpUaGlzIGNvbW1pdCBzaG91
bGQgbm90IGxvZ2ljYWxseSBjb25mbGljdCB3aXRoIHBhdGNoIDIvNyAoanVzdCBtaXNtYXRjaCBp
biBjb250ZXh0KQ0KYW5kIHRoZSBjb25mbGljdCBjYW4gYmUgdHJpdmlhbGx5IHJlc29sdmVkLCBp
LmUuIHNpbXBseSBkZWZpbmluZyAyIG5ldyBmdW5jdGlvbnMNCih1bm1hcF9hbmRfa2lsbCgpIGFu
ZCBtZl9nZW5lcmljX2tpbGxfcHJvY3MoKSkganVzdCBiZWxvdyB0cnlfdG9fc3BsaXRfdGhwX3Bh
Z2UoKQ0KKG9yIHNvbWV3aGVyZSBlbHNlIGJlZm9yZSBtZW1vcnlfZmFpbHVyZV9kZXZfcGFnZW1h
cCgpKSBpcyBhIGNvcnJlY3QgcmVzb2x1dGlvbi4NCg0KPiA+ID4NCj4gPiA+IFRoZW4sIHdoeSBp
dCBpcyBvbiBsaW51eC1uZXh0IGlzOiBJIHdhcyB0b2xkWzFdIHRoZXJlIGlzIGEgYmV0dGVyIGZp
eA0KPiA+ID4gYWJvdXQgInBnb2ZmX2FkZHJlc3MoKSIgaW4gbGludXgtbmV4dDoNCj4gPiA+ICAg
ICJtbTogcm1hcDogaW50cm9kdWNlIHBmbl9ta2NsZWFuX3JhbmdlKCkgdG8gY2xlYW5zIFBURXMi
DQo+ID4gPg0KPiA+ID4gaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5l
bC9naXQvbmV4dC9saW51eC1uZXh0LmdpdC9jb21taXQvP2lkPTY1Yzk2MDUwMDlmODMxN2JiMzk4
MzUxOTg3NGQ3NTVhMGIyY2E3NDYNCj4gPiA+IHNvIEkgcmViYXNlZCBteSBwYXRjaGVzIHRvIGl0
IGFuZCBkcm9wcGVkIG9uZSBvZiBtaW5lLg0KPiA+ID4NCj4gPiA+IFsxXSBodHRwczovL2xvcmUu
a2VybmVsLm9yZy9saW51eC14ZnMvWWtQdW9vR0QxMzlXcGcxdkBpbmZyYWRlYWQub3JnLw0KPiA+
IA0KPiA+IEZyb20gbXkgcGVyc3BlY3RpdmUsIG9uY2Ugc29tZXRoaW5nIGhhcyAtbW0gZGVwZW5k
ZW5jaWVzIGl0IG5lZWRzIHRvDQo+ID4gZ28gdGhyb3VnaCBBbmRyZXcncyB0cmVlLCBhbmQgaWYg
aXQncyBnb2luZyB0aHJvdWdoIEFuZHJldydzIHRyZWUgSQ0KPiA+IHRoaW5rIHRoYXQgbWVhbnMg
dGhlIHJlZmxpbmsgc2lkZSBvZiB0aGlzIG5lZWRzIHRvIHdhaXQgYSBjeWNsZSBhcw0KPiA+IHRo
ZXJlIGlzIG5vIHN0YWJsZSBwb2ludCB0aGF0IHRoZSBYRlMgdHJlZSBjb3VsZCBtZXJnZSB0byBi
dWlsZCBvbiB0b3ANCj4gPiBvZi4NCj4gDQo+IE5nZ2doLiBTdGlsbD8gUmVhbGx5Pw0KPiANCj4g
U3VyZSwgSSdtIG5vdCBhIG1haW50YWluZXIgYW5kIGp1c3QgdGhlIHN0YW5kLWluIHBhdGNoIHNo
ZXBoZXJkIGZvcg0KPiBhIHNpbmdsZSByZWxlYXNlLiBIb3dldmVyLCBiZWluZyB1bmFibGUgdG8g
Y2xlYW5seSBtZXJnZSBjb2RlIHdlDQo+IG5lZWQgaW50ZWdyYXRlZCBpbnRvIG91ciBsb2NhbCBz
dWJzeXN0ZW0gdHJlZSBmb3IgaW50ZWdyYXRpb24NCj4gdGVzdGluZyBiZWNhdXNlIGEgcGF0Y2gg
ZGVwZW5kZW5jeSB3aXRoIGFub3RoZXIgc3Vic3lzdGVtIHdvbid0IGdhaW4NCj4gYSBzdGFibGUg
Y29tbWl0IElEIHVudGlsIHRoZSBuZXh0IG1lcmdlIHdpbmRvdyBpcyAuLi4uIGRpc3RpbmN0bHkN
Cj4gc3Vib3B0aW1hbC4NCj4gDQo+IFdlIGtub3cgaG93IHRvIGRvIHRoaXMgY2xlYW5seSwgcXVp
Y2tseSBhbmQgZWZmaWNpZW50bHkgLSB3ZSd2ZSBiZWVuDQo+IGRvaW5nIGNyb3NzLXN1YnN5c3Rl
bSBzaGFyZWQgZ2l0IGJyYW5jaCBjby1vcmRpbmF0aW9uIGZvcg0KPiBWRlMvZnMvYmxvY2sgc3R1
ZmYgd2hlbiBuZWVkZWQgZm9yIG1hbnksIG1hbnkgeWVhcnMuIEl0J3MgcHJldHR5DQo+IGVhc3kg
dG8gZG8sIGp1c3QgcmVxdWlyZXMgY2xlYXIgY29tbXVuaWNhdGlvbiB0byBkZWNpZGUgd2hlcmUg
dGhlDQo+IHNvdXJjZSBicmFuY2ggd2lsbCBiZSBrZXB0LiBJdCBkb2Vzbid0IGV2ZW4gbWF0dGVy
IHdoYXQgb3JkZXIgTGludXMNCj4gdGhlbiBtZXJnZXMgdGhlIHRyZWVzIC0gdGhleSBhcmUgc2Vs
ZiBjb250YWluZWQgYW5kIGdpdCBzb3J0cyBvdXQNCj4gdGhlIGR1cGxpY2F0ZWQgY29tbWl0cyB3
aXRob3V0IGFuIGlzc3VlLg0KPiANCj4gSSBtZWFuLCB3ZSd2ZSBiZWVuIHVzaW5nIGdpdCBmb3Ig
KjE3IHllYXJzKiBub3cgLSB0aGlzIHN0dWZmIHNob3VsZA0KPiBiZSBzZWNvbmQgbmF0dXJlIHRv
IG1haW50YWluZXJzIGJ5IG5vdy4gU28gaG93IGlzIGl0IHN0aWxsDQo+IGNvbnNpZGVyZWQgYWNj
ZXB0aWJsZSBmb3IgYSBjb3JlIGtlcm5lbCBzdWJzeXN0ZW0gbm90IHRvIGhhdmUgdGhlDQo+IGFi
aWxpdHkgdG8gcHJvdmlkZSBvdGhlciBzdWJzeXN0ZW1zIHdpdGggc3RhYmxlIGNvbW1pdHMvYnJh
bmNoZXMNCj4gc28gd2UgY2FuIGNsZWFubHkgZGV2ZWxvcCBjcm9zcy1zdWJzeXN0ZW0gZnVuY3Rp
b25hbGl0eSBxdWlja2x5IGFuZA0KPiBlZmZpY2llbnRseT8NCj4gDQo+ID4gVGhlIGxhc3QgcmV2
aWV3ZWQtYnkgdGhpcyB3YW50cyBiZWZvcmUgZ29pbmcgdGhyb3VnaCB0aGVyZSBpcyBOYW95YSdz
DQo+ID4gb24gdGhlIG1lbW9yeS1mYWlsdXJlLmMgY2hhbmdlcy4NCj4gDQo+IE5hb3lhPyANCg0K
SSdsbCByZXBseSB0byB0aGUgaW5kaXZpZHVhbCBwYXRjaGVzIHNvb24uDQoNClRoYW5rcywNCk5h
b3lhIEhvcmlndWNoaQ==
