Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74C3857CCF5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jul 2022 16:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbiGUONc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jul 2022 10:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbiGUONa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jul 2022 10:13:30 -0400
X-Greylist: delayed 242 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 21 Jul 2022 07:13:29 PDT
Received: from esa8.fujitsucc.c3s2.iphmx.com (esa8.fujitsucc.c3s2.iphmx.com [68.232.159.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A6A51437
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Jul 2022 07:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1658412809; x=1689948809;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=qZicy2/K7T3OcVjP6k5ZqN9ZHo4BS4NI/JWguO/q/VA=;
  b=BXHC69iYfrfZhzNgSWLI4NivIvejXY9F4iwuro/ZeHBs83wE5ysk2RgO
   4b3n75SRUKT7vliFlzZqZVvavmLzTEDlpq2C9A+wJL9IqgJJUmOIbThgH
   imY1qemFVK7fGi5Ja1A5wXj9XVxfzYM5iebI3Bbykyda9EuaBXmoSRNIf
   lotOItNyT2uQO2de26s6EoESq9QhJ72U2fOvoAEdUBVkYiJ5EzDP/P/fZ
   ERWyxHHoXSqINSVmuKVUkCDR+s+m/Uy21/GrjcDMZ9YYAWJ/3anUKZB80
   fh4JJpAsh3+zejGwNFycpd9PyTYFxGsB6pZT1ykEK8rUHBdRkhKXstjfO
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10414"; a="60938011"
X-IronPort-AV: E=Sophos;i="5.93,289,1654527600"; 
   d="scan'208";a="60938011"
Received: from mail-os0jpn01lp2104.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.104])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 23:06:13 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TsWWTvWa3RcHMH1pKXJZk9RX+9ATmOHtU+UEDQ/eDwZuLemvVyiALpr3XzR2cMFi3Kf9xHw1kdtKWl0zJZmI7pdR6C4Xi2CBo/F8eQJfYoWs1tC0L61JWxx4fhEYWMY2b+PyRT2VI5Tmar4+cHURRXVRkEeJHl9uLD3nZmNP7mmePHwFtXRfRTx9KqmH/1M/o4S0iLb2GdgjVRGpCDj+AXAK4j0c6HF8OKVdvTtUnb8/m39JKCYnf2QbayEQl7R/5M2vvXUWD38Lrhpff1TisSd4wgFCbw9W1fd9XRCPKN55pQyNBSg4VjjJ+ztNhte4GY/+H/nGN1IFi8pENEM2Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qZicy2/K7T3OcVjP6k5ZqN9ZHo4BS4NI/JWguO/q/VA=;
 b=WE+lAdf26AbeJlxPqmLaXDmbNJYkzJow9movO9zGqQwLjiTY20i0UfN8rPfU2nAbbpE2mywhOxF0SWGSkKPhVtsF0sKneYpEerYe7+lWdjCKK1YPmwb2bnLxmhrJAkZcmM1+qJHs3ozCFuofAGOGNHYTjitY4EqVEW6GGZlD7WBjKsOyorALaMzDFBFdrohrDH5mXh8MinI7INCDVYYzF7fGtGYVIKse1iSWIjG087VplAcPADzfP2l13xUaSnBqaSeQ57Q0wVwOFy9urAYPVYcUXFD4fFf5hpNNN9C4GKLGZHnj+BCOLtFXbzmngfqYoPxku993n5qxX45wro+/aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSBPR01MB2920.jpnprd01.prod.outlook.com (2603:1096:604:18::16)
 by TYCPR01MB6852.jpnprd01.prod.outlook.com (2603:1096:400:b7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Thu, 21 Jul
 2022 14:06:10 +0000
Received: from OSBPR01MB2920.jpnprd01.prod.outlook.com
 ([fe80::7556:cf54:e9e1:28ca]) by OSBPR01MB2920.jpnprd01.prod.outlook.com
 ([fe80::7556:cf54:e9e1:28ca%7]) with mapi id 15.20.5438.023; Thu, 21 Jul 2022
 14:06:10 +0000
From:   "ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "hch@infradead.org" <hch@infradead.org>
Subject: Re: [PATCH] xfs: fail dax mount if reflink is enabled on a partition
Thread-Topic: [PATCH] xfs: fail dax mount if reflink is enabled on a partition
Thread-Index: AQHYfA4g5aj+ViA5o0mdS5cU960Zpq1oy6eAgCBSEIA=
Date:   Thu, 21 Jul 2022 14:06:10 +0000
Message-ID: <74b0a034-8c77-5136-3fbd-4affb841edcb@fujitsu.com>
References: <20220609143435.393724-1-ruansy.fnst@fujitsu.com>
 <Yr5AV5HaleJXMmUm@magnolia>
In-Reply-To: <Yr5AV5HaleJXMmUm@magnolia>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=True;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2022-07-21T14:06:10.109Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 940a7dad-f791-4cc5-63c1-08da6b222a22
x-ms-traffictypediagnostic: TYCPR01MB6852:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nrYDK5QW8uuqIw7T1RSeMtov3IsaKtbigxmtD3jbG67gJ+UWh6G6ykqAf1MgiAwm9LHqYHa1UT53YhFGCH+8IIdyAWwIs92iQxv1SMZq4AhdxrQIRFW3NkLIuFVExxTFzF0tUwLowvXQSABoIMXULH1kGLs6u4XTGUS+aYnJF+CI/TV1V29XkIN1EpApd2QwMPPaXFYTO/dyONQZkxGfchSpvqecIoGilnMF4eSgokUSk/SBBuaQAPrGD1lSehzsrYMXyhdJrRDGKbZsOsLNmvR8elhkrq/JsiF/5Z667E8DMROZNm7ebBJtUaNsqEUvwMzsT8QEA6JVxN0fmauul6sMtxmaEzqacowX5lJdJQEoOcdZzalgNSMqkyuX8VZmHg56dKVGTgEwkRyw4gA2I/3f/xW3eK6NZk0yQAS9jXYCGyGOoqbinUw3fqShS7pSwEEuAAp5R8wCr+K4bc2IQN1vwWF4HDCfgXQji4QE6n046yJcZIOGSNSOQXm1WnjeWtNyqhEIGLTc8V4JPHLZnTkGnf8/9rS4SZbyqykBQOtS4Ux+zmhEJrk1999Z+7cpCmQ5Y7pk0a+mz/IvEQC4ujpwwHohEGLtj4BugZccLtwS33l8OfXchtPNFC9iZbUusBbBSSu5MRlAh+Z4D9l6Ub3PRvF+V1u5mgA95Rxwsj8eyaI+dZv8ZrVo30YQXxW8rs/RetZzETJaSD8lTx8ufyWp5vZCaAezIJJzfGmF+sLnQ+i3B9l/HiFyCy9fvshlN52Qd4nYNgFPDQur5rz/Yf5+jKOqVub1tV/YPlI3h4DAv4aJCFQNB9Ocz8Gc4IaDPKK2qREjq4aRXPcEDd9gPQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2920.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(366004)(136003)(346002)(39860400002)(396003)(26005)(478600001)(6512007)(36756003)(41300700001)(4326008)(6506007)(85182001)(31686004)(82960400001)(91956017)(122000001)(71200400001)(2906002)(5660300002)(38100700002)(38070700005)(2616005)(66476007)(66556008)(54906003)(66946007)(83380400001)(6916009)(64756008)(66446008)(186003)(8936002)(316002)(31696002)(6486002)(8676002)(76116006)(86362001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?YU5XVkhqRVZ3TXRBR0d0cWsrMWpDanMxQmdNdm1CQitiWm5BZ3NkcmJON2Ns?=
 =?gb2312?B?Y1VYNzcwTi92TVpQVU12TE8zaW9KYlcwN2JSTzlhTnNsTGRMYjAyaGpybUVD?=
 =?gb2312?B?UEgxcUZzemFoUkVTdE1VSUNzT2luM0tiR1VWU2Z4Rm5teXlXNEE4ZU9MSmdo?=
 =?gb2312?B?Z1pqd3VZQUIxKzNxdElKSDdYQkp1dFVNcnVpdXFFaFF6UWZwbUZObXdRWkJM?=
 =?gb2312?B?ZmhEYzdZM3cySkVmSktBNUVmMUhjWUI5Uk1pMWs4QUtwNFkyNEoxQVJpQXVW?=
 =?gb2312?B?N2xiZmQ5enNtSWloblJhU3dHL3Nhby92Q3RpR3MzZ1RuRlZEUklla0dJUk1E?=
 =?gb2312?B?R1N3b05iOWN1b1NVeVBsVkIyVFRWNTVxV3FZRTVrdHlsTnB2a1VKV0c0TzNC?=
 =?gb2312?B?MlpvR2tCUHd6OGdFWXpMaVRUZ0JhcXcwdTdQVS9samcvTENmZ1dXWnlnTmUz?=
 =?gb2312?B?NStCSGxVbzFoQ3ZETEN1UU5EalRqZ3JsanJnYzUxUVVlV1NjV001ckRrZlpk?=
 =?gb2312?B?ZUZ5SWhTdkFiaWxxUW9JRVBUM2VMdVJGYlV5Z3pIYnZMYjhzd0FiWk1wbWth?=
 =?gb2312?B?ZFJXL2Q0c05aYUxGSEZnV1BlYjB0ME5EcVZzbkI0Vk05RXZieU9UenU5bTRI?=
 =?gb2312?B?eDhNb09DK1lGTm92Q1dnQ3I0bEU2Z2RDdlFMSk9xVnZyZWVVNTNCbXFLK3Mr?=
 =?gb2312?B?eHFpUTdKUGFxKzN1SFU5NFZjTkV6bTJhY0hPU2pQVUhrSVJkZHdRRGdVaFhE?=
 =?gb2312?B?dGJmSkJlanZwdVFIZXRjaUlFc2JRQ2xzakV2KzdVSGQyMnpxeFdLMUlGTnYr?=
 =?gb2312?B?MDExK3NwL3QzQUI4Mi9KWElQVkRwR3h3VXo5WHcwTDJGczd6OUsvSVphSjhq?=
 =?gb2312?B?K3J6b2xtcHlDa0FyMWdlWE5XQVU1TG52Y0ErNFJxdlFCWFpUN0VMN1RIT0xn?=
 =?gb2312?B?SXlaN1VpNEZOenhTN3c1MEl2ZnU5S2dxN0JCZ1UrMkY3MnFvSU04TzhyQzVM?=
 =?gb2312?B?aFc4VERMcVBHVTArQTA3UmV5NTl5c0xIMmtUYm1GMGpXK0lBS3dSUmtsOUc5?=
 =?gb2312?B?VlArUGVZc1N2ZTFCdjdqbVhCNFM1S3ZQRGtqVFY1Ky8xTWhHTmlBdy9oNWJD?=
 =?gb2312?B?cGRUcGppYWhIVmxFRzBlUjBjVkxBNXlvelFBcVpTYTAwVkhmbjVxWk5rUHVu?=
 =?gb2312?B?OG95T3hiTkx3YnEzVVFlbGRVNXFEZEhWWXRCUnhJWVVvMURZclRWT3VINy8r?=
 =?gb2312?B?a1QrS21zaUpYM1JVTy9meU9yc1BDYld2Rmx4NXNIanpXbk42NWFCWFY5RVdZ?=
 =?gb2312?B?aC9xdmJLcHJtVGxyanVPMHVmZ0pxZnJYVzN3NXRHb042bklKcXk2cTVtZzFS?=
 =?gb2312?B?S2JXTnAwTmo4TzhsQXVYSnZHS0x5U3pJUVN3QytrYTNYWjdnS3MvUTNQSGNL?=
 =?gb2312?B?bThMMUhpMmFIT3hENGV6RzF6MnFsL1VjdC95SGpaUzdxY29iaXpzT1BnN1JM?=
 =?gb2312?B?WmxHOU5LY2g4VFZ3eVVpdGQwb2svU091S0g0VFBxM0FBcTdpdlkrT2YxKzRp?=
 =?gb2312?B?NHBmLytqSW8xMEsxdGxOemRFclM4UzFTZUVKZFhsdWsvTDdjSUh3c25qRERn?=
 =?gb2312?B?Ri9uSnJZR3JTWTZnQ3pEMnFnZVUxK1BMbnBvQU14aGlVd3dvVEFoVG02alU5?=
 =?gb2312?B?ZkR1VzY5TStCQmQxcVZtcGg4RllOUU9TSXBFaUdPbnNnUEg3ejFndUY4eUZK?=
 =?gb2312?B?Z0FPREtKSGRvM3Q3d3dqY2YyVmhUUzN2S1lKNVAwek12NUx3M2JwUUtET3Zt?=
 =?gb2312?B?WEFMUkpwMit3TDZnM0pFanpJN0pIWFZrUFppa3FYc1RoL0lsMHU1ZE1LdTIw?=
 =?gb2312?B?b3dVbVJBa0hGWWtqdkNJK3NuSDFzMXlCajBtK0g5TDlPYXNYVHhCVko0OXZx?=
 =?gb2312?B?a2RESXZkNXBGTlAxNFB6Yk84aXZNcVk1WGc2a0NKd1lpNHV5S2lGT3lXSTRj?=
 =?gb2312?B?TFhoM2pSRWJ1Skl1N3JYSzRpbDdiSS9WU21Fc0dJOUszS20xOWpiZ0lUTmRW?=
 =?gb2312?B?aXV0NS9GclN3dmszTnhaOW5YOUJlS0dRN3BSd0hPbzVYVmFRN0pxRno5UkxO?=
 =?gb2312?Q?L5AD7uiGh7fQ54YfSa1+7hB2H?=
Content-Type: text/plain; charset="gb2312"
Content-ID: <3448AB9E232B874FB4DAA9330D072FD6@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2920.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 940a7dad-f791-4cc5-63c1-08da6b222a22
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2022 14:06:10.6147
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MLUkLn1CYZo2Jp2Z3AXwB6fNgGcf7saTClDOIsSImSYZ0+sI3xcWcr+VD0H5jV8jDx69Mwo8lW6LYEd/FugOwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6852
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

1NogMjAyMi83LzEgODozMSwgRGFycmljayBKLiBXb25nINC0tcA6Cj4gT24gVGh1LCBKdW4gMDks
IDIwMjIgYXQgMTA6MzQ6MzVQTSArMDgwMCwgU2hpeWFuZyBSdWFuIHdyb3RlOgo+PiBGYWlsdXJl
IG5vdGlmaWNhdGlvbiBpcyBub3Qgc3VwcG9ydGVkIG9uIHBhcnRpdGlvbnMuICBTbywgd2hlbiB3
ZSBtb3VudAo+PiBhIHJlZmxpbmsgZW5hYmxlZCB4ZnMgb24gYSBwYXJ0aXRpb24gd2l0aCBkYXgg
b3B0aW9uLCBsZXQgaXQgZmFpbCB3aXRoCj4+IC1FSU5WQUwgY29kZS4KPj4KPj4gU2lnbmVkLW9m
Zi1ieTogU2hpeWFuZyBSdWFuIDxydWFuc3kuZm5zdEBmdWppdHN1LmNvbT4KPiAKPiBMb29rcyBn
b29kIHRvIG1lLCB0aG91Z2ggSSB0aGluayB0aGlzIHBhdGNoIGFwcGxpZXMgdG8gLi4uIHdoZXJl
dmVyIGFsbAo+IHRob3NlIHJtYXArcmVmbGluaytkYXggcGF0Y2hlcyB3ZW50LiAgSSB0aGluayB0
aGF0J3MgYWtwbSdzIHRyZWUsIHJpZ2h0Pwo+IAo+IElkZWFsbHkgdGhpcyB3b3VsZCBnbyBpbiB0
aHJvdWdoIHRoZXJlIHRvIGtlZXAgdGhlIHBpZWNlcyB0b2dldGhlciwgYnV0Cj4gSSBkb24ndCBt
aW5kIHRvc3NpbmcgdGhpcyBpbiBhdCB0aGUgZW5kIG9mIHRoZSA1LjIwIG1lcmdlIHdpbmRvdyBp
ZiBha3BtCj4gaXMgdW53aWxsaW5nLgoKQlRXLCBzaW5jZSB0aGVzZSBwYXRjaGVzIChkYXgmcmVm
bGluayZybWFwICsgVEhJUyArIHBtZW0tdW5iaW5kKSBhcmUgCndhaXRpbmcgdG8gYmUgbWVyZ2Vk
LCBpcyBpdCB0aW1lIHRvIHRoaW5rIGFib3V0ICJyZW1vdmluZyB0aGUgCmV4cGVyaW1lbnRhbCB0
YWciIGFnYWluPyAgOikKCgotLQpUaGFua3MsClJ1YW4uCgo+IAo+IFJldmlld2VkLWJ5OiBEYXJy
aWNrIEouIFdvbmcgPGRqd29uZ0BrZXJuZWwub3JnPgo+IAo+IC0tRAo+IAo+PiAtLS0KPj4gICBm
cy94ZnMveGZzX3N1cGVyLmMgfCA2ICsrKystLQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2Vy
dGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4+Cj4+IGRpZmYgLS1naXQgYS9mcy94ZnMveGZzX3N1
cGVyLmMgYi9mcy94ZnMveGZzX3N1cGVyLmMKPj4gaW5kZXggODQ5NWVmMDc2ZmZjLi5hM2MyMjE4
NDFmYTYgMTAwNjQ0Cj4+IC0tLSBhL2ZzL3hmcy94ZnNfc3VwZXIuYwo+PiArKysgYi9mcy94ZnMv
eGZzX3N1cGVyLmMKPj4gQEAgLTM0OCw4ICszNDgsMTAgQEAgeGZzX3NldHVwX2RheF9hbHdheXMo
Cj4+ICAgCQlnb3RvIGRpc2FibGVfZGF4Owo+PiAgIAl9Cj4+ICAgCj4+IC0JaWYgKHhmc19oYXNf
cmVmbGluayhtcCkpIHsKPj4gLQkJeGZzX2FsZXJ0KG1wLCAiREFYIGFuZCByZWZsaW5rIGNhbm5v
dCBiZSB1c2VkIHRvZ2V0aGVyISIpOwo+PiArCWlmICh4ZnNfaGFzX3JlZmxpbmsobXApICYmCj4+
ICsJICAgIGJkZXZfaXNfcGFydGl0aW9uKG1wLT5tX2RkZXZfdGFyZ3AtPmJ0X2JkZXYpKSB7Cj4+
ICsJCXhmc19hbGVydChtcCwKPj4gKwkJCSJEQVggYW5kIHJlZmxpbmsgY2Fubm90IHdvcmsgd2l0
aCBtdWx0aS1wYXJ0aXRpb25zISIpOwo+PiAgIAkJcmV0dXJuIC1FSU5WQUw7Cj4+ICAgCX0KPj4g
ICAKPj4gLS0gCj4+IDIuMzYuMQo+Pgo+Pgo+Pgo=
