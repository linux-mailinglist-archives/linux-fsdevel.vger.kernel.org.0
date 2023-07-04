Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA4AA746C63
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jul 2023 10:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbjGDIvR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jul 2023 04:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbjGDIup (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jul 2023 04:50:45 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E721A2;
        Tue,  4 Jul 2023 01:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1688460644; x=1719996644;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=qhvlAeMpN24pEaQlESprBsMtOWumHgG6FbkbhNRnxM3xV2IouI3EbX0B
   UADFNuPP7ltepdHyw4KjciFggeX6PDLgkFsliL6MSnj8qoorvt/CRS+Lz
   /wc88A4yWIrk5m10EJiDF4EPXlPWx4YRNnGm+CJWMRC0pFIsKiYKO9gXm
   8kCQRUw887OSzSpMv+cKgTC6lyJHrvCm11bVn5YgPgSUFPAWIHmXqlIes
   8t6oJfRyeaJDUBUonS7fDz6iYNn186jCnhVpYSwROmH5fId7WRfORwize
   CYsrLazlb3q1ysqm5LLkOWIoLnguvwS58iO44NSuBzWXzQRG89EwFHjCE
   A==;
X-IronPort-AV: E=Sophos;i="6.01,180,1684771200"; 
   d="scan'208";a="342232182"
Received: from mail-bn8nam12lp2175.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.175])
  by ob1.hgst.iphmx.com with ESMTP; 04 Jul 2023 16:50:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bA9Lk0Kldy3qfG02WbyeIWUlScx0pPkbgmFjvOHtAjaqR34kH/ESaKNhzbXZZKADJLqt6cWtcSiruuG0eqDRr8zY1+aDHf0+45CbSoqZN3Litz/6Syz9sYShsaOv3LIYq0//RbtOVAh73JYMbcmCGRvxUn787AUa+NZDoj8bXK6ELkPQNr18yc99mRa/Bvp5wWyC827L9ZutiTtoALizg8fkPEx8Vwi7hVHK1RN0vRMkZwLsAw9Rc8SNqysIYiJ2WFqI/t3I4EYFRz6vkpuAxfH9m17PVeK/0m3uR6ERE+b30Pew/0vgx9Wzp7ab5gB66a8LbrxrBMHTTGEcaIq+3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=G3Y1nshJPWrzmzUl/efFVNfXzQYpU+9oLA0MtzWWbu+3nOqZuRm6QF77ewqVS2ZVdIl3PZIIK34VY1779P9H2J3OU2OIWxiMDjwLXzHHk+wQqpbFhWNofLKAwsA2cWUf+lZ2FrU/oUGF+KuhaCZEDbnJdGSwavd/ik0ge/uWifmqlFs3NNp+Vkgmbga3UrF3aAjijkMsfkut+eynbFEiWayQHeE/ElFiNNpDKkJ2jURTe5BhYfeJbk/Nxdg+fZ4GIQuWJ3sy0svIrY/ncGBbWv8dgdabjftRd2It8C/JELWEKrKuLA2gaWUpXLp499f1a2iuYNTxN1iZBtEptwXO6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=EtqeCw9Bq3YBEzhWf9ZJGVHQpF9uVHDR0Jk2xxNea7x1alotTqwbUyM4yanmYfhcjtNjIb7FjZ9M/YlgaPk6R4sU6xN2ajAgFbMhaEnl9X5dUJcl7COteJs0BPYSmrwiPyVLE4I9XZBkM3R42Z5KbkDDWXXbSulCzEBbLpgciw4=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH7PR04MB8976.namprd04.prod.outlook.com (2603:10b6:510:2f3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 08:50:38 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::23cf:dbe4:375c:9936]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::23cf:dbe4:375c:9936%6]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 08:50:38 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     Matthew Wilcox <willy@infradead.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 04/23] btrfs: remove btrfs_writepage_endio_finish_ordered
Thread-Topic: [PATCH 04/23] btrfs: remove btrfs_writepage_endio_finish_ordered
Thread-Index: AQHZqdYZ8ixaEEgVZUqhoqLyW66V+6+pVYiA
Date:   Tue, 4 Jul 2023 08:50:38 +0000
Message-ID: <54c83a88-1819-4317-dd43-af0e4aca41e7@wdc.com>
References: <20230628153144.22834-1-hch@lst.de>
 <20230628153144.22834-5-hch@lst.de>
In-Reply-To: <20230628153144.22834-5-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH7PR04MB8976:EE_
x-ms-office365-filtering-correlation-id: 21c2c9d1-2f9c-4c3b-a66e-08db7c6bbd5d
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4kKzzkqJrPWgJwIrPHNXs4BmSa2BStpGcxpy4rQk8uFfvch9TjMCpb+VJUCFMxvE1mwkCc9DAhaecT5+Dp8gY+KzNLbjBc6aPSfqeCmCqsVqa7p+amDjXYqa6YhVIjJBHwljKmZWJzxpf94twKieopSLaLNhrneaPMtpr0pa0xTA3xod/C5FOSJAVya82XV9VnWbUWfNUsTZrkUmosFH6dHWv2gCNgbfmtrF4AZOFs4xwC1glJz8VRblw+e9uvs0t0sWRjpE5mAyzbmVN/vy39ojkhABaGOSyPnXS/7Jk4smyferfjYlJuaX7y/gMU1N+YTbXNMdmelth4hTUMrFu3FwiJoFZ8h3fFQga/Gv8pOmvOv+rMlOPHx/tdHnFRRw4O44YXIo8oe3mLcpj8mCrWkrwU0UHCKdMrl6dZmd67cKq+q+tjTot8cEXysWgMVKh9JOEuqKeQbAoWP0Yb8O/6C1oYXJrBAwKMXfTonU0nPcGTx5F9vUMQ1ffVkdR4hvRbPsi4CXnkxiYOdMK1VKFAXUdJV3s4u902w0+U4aYwVHfENPLLkj17v2UOzY/QKU7TbNQsvJ/KQ6Gro1c8vQDaSVlTQhiyM/0/FrRDIv1BHrGNDoWFl5g7tJGb+PVDI11GY3gIb7zmRDcv0qkcoIT0mB0Fqw0nLg9i1Ff+Mer/w/ulkD3IizJlmgRZTnxScp
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(136003)(39860400002)(346002)(376002)(451199021)(38070700005)(19618925003)(2906002)(41300700001)(8936002)(8676002)(558084003)(36756003)(5660300002)(86362001)(31696002)(4270600006)(186003)(2616005)(31686004)(478600001)(6506007)(6512007)(71200400001)(82960400001)(76116006)(6486002)(91956017)(122000001)(316002)(66556008)(4326008)(64756008)(66446008)(66946007)(38100700002)(54906003)(66476007)(110136005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YXdPRGNpM0VpU0pXLzlZdkE4WXRXYVg4REgvSS96NS9VTEpnc0RZdk5QTVFB?=
 =?utf-8?B?bUdWK0NyTkdhV2pxMUF6UEtCS1pYVWZla1I4VVU3VzRFVGh1MWZQdDZaczNo?=
 =?utf-8?B?MS8rSEx6R2dlZmpOeTMwUmVjajZQU0pDTSs2WTg5UXZ3eWFEV0ozMldmQjVD?=
 =?utf-8?B?aUg1VlNFa2Q0Ulp0LzFnZEQvZHRtRkxDUlZwNG1NVzNDYTE0VHFrZzdJQ1Mr?=
 =?utf-8?B?SUlFMjdpOTF0M1A4NVRJdHdmTlcrZEttYmJ2c2p3aXNUNHlFWTZMNzVNT0Rv?=
 =?utf-8?B?U0dFaUFIOUN4VEljaTN0eFJHbmMxL3EvUmVZQlgwelcveGhPK1MxS2dGTW8w?=
 =?utf-8?B?WTkyT1JYU1d5Ymx2QWFOeXlXcHcxYXhoR1pUNHMvdHJFRDhkTDFnSXA0M2ZV?=
 =?utf-8?B?WFJlMmJFd0hUZldyQ1NqOG9QWEFtU3RNelhPTnlYejh1T1dDTXk1MlF3aVF4?=
 =?utf-8?B?cWpqbGZhdWdpWk9iRlFUd1dsYXZHaVViS0lucW9rY0tzYTEzdXNNKzlJWDVK?=
 =?utf-8?B?NERFbUhDYSs0dS9vbytlcy9ZS2dTeXJJOTBRSFlIVjAzYmliVmMzdjBweVk0?=
 =?utf-8?B?SkRQNVRMVGo2bmhmaFpPbHpHNGNERThURlpJUWFLVThiRi85ZTYrQ0N1Nndp?=
 =?utf-8?B?ODVVKzhSTFhVQWhOczNUOEg1Ykh4WWg1a1JsRVJ1SEM3T3NDY1VBd21rZlEx?=
 =?utf-8?B?U2YyQ21vQnpjRno2eU9JK1JCMzhMaUJyQkFGSWhiWWkvWlBSRGE3THB5ZHpX?=
 =?utf-8?B?aWJ6S2toQmVjbzRNYVlmVnhtcGhNVy8yM0FoOWhZYUgzTnFBTzV1MlIweVUv?=
 =?utf-8?B?QlROY1pNTVArcjI0b0JpWWtGNWlKbWZXMmx2K0tUNmNtSUo4amZDRHg1U3Vz?=
 =?utf-8?B?bWFUUzcySTZBZlltV1Yza3BrVzRwQ3pycU1pWnpxazYyNEtjWEhMM1NCNnJL?=
 =?utf-8?B?YjNjZnAzK3FKVzIrR0lUNlpQNUd1L043UjJaQ0t0K01ya2ljRHRlZ2FtOUtu?=
 =?utf-8?B?djNhb2lzc00wZ3YrRlJ5TVBIaEhXemd0UDk2WCt0cmtpOHo0K3hCdlloQWRT?=
 =?utf-8?B?RnFpMldDcDEwdDVWWEcwTFJNNVE3TVNCNVN5WVQ4eWlGTzI2ejkrbm5lcDZp?=
 =?utf-8?B?NGJTVVNWNkNMa1FDTGJhQjhFbTJrUzNSMGNvakNNSG94dlZwanhzcTlZOWVN?=
 =?utf-8?B?L3NEM2t4TXMwUk9Gc3FlenhSS3p2TVRhWVQ2a0NNcUoyVUtkb2t3elVrR0Vn?=
 =?utf-8?B?OGhqckU4WHFpNlk5R1VCbGVvcW1pVXRtNDlVL0RwUFNNWVhwWVZZR3NTVW4z?=
 =?utf-8?B?aUZiZGI5eng0dlFhdnN5enk2aHdvU1NncXZad2h4L2E1eFpXejJxa0ZQQWRM?=
 =?utf-8?B?VVhNOFRwc3JGSzNwamtzTnhmNjlaMzV4QkhhbzIyY0Z1VzdMRGpZM1BxbXNB?=
 =?utf-8?B?M2pTSTdMWkptM1FQRTdXNG9Sd0V2aE82ZXQwNHNudkhSWmVyUGtXT1VKMjMr?=
 =?utf-8?B?V1B0ZTVrUjNCTXNiRExyT05yQmZVa2tkNEtRK3FIM3RsTDUrUlVuYkpxYzZW?=
 =?utf-8?B?WWx6YzlXdXZIQmF4MlRBNkpvaFc2VDh5a2p0US94bnNqU0NQRVcvaGxKTHht?=
 =?utf-8?B?YmIydGpLUm9ZT2IzZ1ZpdzdEZEsrcFoxZjdmdklFcDBnU3ZXV2dPN0t3Uk1B?=
 =?utf-8?B?bi95bm12SE45SnRLTnN3TEVIMzFOY0F1YUVTczN5Tk1uZnpUNDBGQm5rbkhE?=
 =?utf-8?B?V2dIaVB5dGZwaXpGOWFaNGg2Mk94ODNzWmQvTjlMYncxVDcvck5pTDY2a0c1?=
 =?utf-8?B?UkEyQkFaaXQwM1ZxbjNwem83Y0tsVFlHOSs5K2ZvcDdjU2RWcVZQNUlzSVgz?=
 =?utf-8?B?WnlQcUo5TVE2V012cHRrYTlWbnpxSzgvQ01qU281bXJBeVRqN1pHTE1XdUpJ?=
 =?utf-8?B?eWJVM1pEWnkrNTVLejlJVUFIaTFzYjV4RlNTcmhSajE1QU0wbjFQTjRFT0tv?=
 =?utf-8?B?U29BQTNIaHd4dVE1azFsdHc3T1c3QUZGOU9iSVdmeXZocUZsVDFLOERSTGRC?=
 =?utf-8?B?RkMwSVFNUVhLcXQyTVE4TUMrR204UjNYc3FmZVJleGIrY0RlSjhEZFRyenkz?=
 =?utf-8?B?ZExnYjAzeS94TzhVSWl3bzcyT001Ynh1em5xSC96RXcrS3VxT1lLNm5kUm92?=
 =?utf-8?B?cXU5SzI1c3pGWGVLUTVSNVJmckoyalRuemkzRTRXRlhvWk5DUk1aU2tVSTgr?=
 =?utf-8?B?elJSR1hIQmR1RG4xeXJtNWcvZHZRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A78719B310F0834888EF0067625155F2@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: pZ6Rbp8zW9bOfCMt84K/rUZKyh/JVM5jT/bjLMFOy8ZzgwTfzB4j/gxThJzJr3Ra5l4Id/Yx2oiLVDOcT1foeXb7xCppjFTGXtYvqFOUpKnOcx4R5KLw1suupI3ozCQile9vgnjYcTNDcY/XOxxLDIEtP0Ts3Y5d2FFgWfd325MQKjZ2FptdYoKYeD8BEEFwTSW8YR8FDhuumAM1VtRBtE1lb1j8IoKvDjxECmlZgspCct3G8V+98pFJRiec5hmKe75eUwAaDCGbsU7OtODd3db67/GJoqRbUKMBz37ahcjn+dHaodMf/86Z4sglzb4Q/D1C7xUd5tcCtdeuJlmjPVy1I7BpLGtdkWmmgnnpHNoKCsdGnY7+/qbLtNvJCBwbQS97iQ3k7gyTddLcQF14AgIub/gyZ6wFgjnA65hIe4rC5PnTNsc2vhSorh4RCrO9PjB48v3gA7VbMMV0BaJHA0jsI2c2wWs+OKDIcWgkZnF4REusZUwl/4mUG98iOUnqFoU/FfAxiNU/PzCeflmS1hWiK5RTW/VnIPXNmnEEDD1bqG5OYxP9wMImlWDLv3GWmnSzm3P59c141lQCOIQ5+iku+ufu8xpXDXl6tt0nsyQYTOh5pW544c3mWgwM2XLtWzkd+3yjwzK9DMJSCwLai406owM2CIdII9snGdxRucrjlSZh/LQcSsmJ6JB+aYVVJIw7li4ErCUFBTeMxC4kzykOZHvqYHibeQr60ZADmXgJ8IJ4+hOngG/FnNyLqNfMwufrf1jxp+d4YiDGeltNLUwBAj6hZVAf60gm9MOOPNcmFGIVZOA3o4r3pl6GQ1gDS6+C8fIhrQ2ho3LT/ynb5a6U0RIz7v6+wOFL76gyeBwyrp3qQUkF/3vQTi/v6DtIbV/1H3xr8M74v7drRItgzD2IdmrwBkzBSFiakLTmZsA=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21c2c9d1-2f9c-4c3b-a66e-08db7c6bbd5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2023 08:50:38.2850
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bBOxt16lunv8jqHj7wRF5Rh70UdXiq5npFid7dcd0aQ1tItF969pTvjWJhT3bnpQ+vNc8RJ2ewYXY7i3Kz/pgroVEcSCw8nsdHHSAnv+YRY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR04MB8976
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,TVD_SPACE_RATIO,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
