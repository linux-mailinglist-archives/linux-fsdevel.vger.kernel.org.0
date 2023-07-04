Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A876746CE0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jul 2023 11:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbjGDJHq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jul 2023 05:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231896AbjGDJHf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jul 2023 05:07:35 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525F81B2;
        Tue,  4 Jul 2023 02:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1688461652; x=1719997652;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=TIbehQ5vkm3cVTih9Aaqgdn6LrA2L8DxFA3s707pmUhlPZm1iNYJmd0h
   /Qs71M/SyFmcChnGG0sGqynRupnpQZD36P2CYTdvoVScFqPgbvEU2hMlR
   zrChDZqJ7I9MQFSQU8e8SJ94tXvOLuHnxv8ssKyE6+UpZX5pnMyEqOMkC
   y4tZ0+v8eiYnXaGZbxTm0alhVuX+cZ+dwJr/puEcDU+v9FiJQzEErlGU8
   18EOXbbi5RiWWLZ9h9Eg+sLyjK2OFOlD1oxOBupkpsoc3gYDMpIQn6vIb
   xiIyP7Cnk502NMK8IUlJzfqzttzMbTV0DlKhudbTL94z0X4Ag2sZcEjge
   g==;
X-IronPort-AV: E=Sophos;i="6.01,180,1684771200"; 
   d="scan'208";a="342233559"
Received: from mail-bn8nam12lp2168.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.168])
  by ob1.hgst.iphmx.com with ESMTP; 04 Jul 2023 17:07:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MtdWLuuOCyNh1Lt5GmJ5A526NCrvHJ7Tt9xZ1wK9cFQOUFGI4jIaKZ1kHD93XSbSwtvFIG72FubhhoJnrsJ6YnmfSyshlSvA4OQTs1/krYh3hbgU7ndQb3KGHSUNxUvGnSSvYt5J1b8Pj1DgJ52ALaef+PWW2bz8mxlspg6LeBI/jXqJRGweCjZ+NGxrLMzW/EVqAa2ku8cSPpIV12BqJN/Sye8P5nBuTHH1U/yAESAvafJFJ8Hs/ccB9jymVKUFCjL6WaD4UVwY4rlbF+jiEy+kQnT2oxrpolJjWCDKXBozn3/TjPG6Nd8UgX0wLqDGYMbtwpZvSG1goe9ktfKFcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=VkvDG7WcDTF7F8s2YaGf3s238NqN2Qiu+qRzsPXhTTTrXisDuYqUhw/g8gF/YQ6ilC9eKkV9FqQN6rZ7quuJfGxPQBcC5Gjt+r628SL0fMh7D+oyDhj8Hb8EAlp74CF0kVKRmGfApvYC1j6p4jXSIgR4FqZyk74D0MJ2AMm1SVGfzMwJLXD1BZPOGiIDLGCbiL9Wl5TG6vRSRXdD7TLEhKaz9nyOdjt9EmxAaV18iUfLdQxpqxogndTQ/pjXrbQUUKdWigGHFGXg0ETDDlIuZLHjAX9ug0JPWdPE7MlXXbtRRYN5zKCu2jEno6VWGSR6nQ/vHzeohWVzrTJAuNnedg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=J0IGzIByHGwez6tLq44sb1UZOcg8uuD/9C6fmBSIjJcFFetjLcpD/76NSoAQi+OxVX5J5Bt7hrUQ4jokElr4ioVDnfj3ifE/TfQ25okGrs9BemTe6IdKcJzPpXRTsn4k2whjdGtHpsNuqcwf3LzaC4Br4+fwAd1BtlcLcbTYEs0=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH2PR04MB6619.namprd04.prod.outlook.com (2603:10b6:610:64::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 09:07:28 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::23cf:dbe4:375c:9936]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::23cf:dbe4:375c:9936%6]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 09:07:28 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     Matthew Wilcox <willy@infradead.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 11/23] btrfs: clean up the check for uncompressed ranges
 in submit_one_async_extent
Thread-Topic: [PATCH 11/23] btrfs: clean up the check for uncompressed ranges
 in submit_one_async_extent
Thread-Index: AQHZqdY4LPu+wds6xEiuEktDsdaUo6+pWjwA
Date:   Tue, 4 Jul 2023 09:07:28 +0000
Message-ID: <6e2dc847-3c1d-7e5a-37f9-b9e481a0abce@wdc.com>
References: <20230628153144.22834-1-hch@lst.de>
 <20230628153144.22834-12-hch@lst.de>
In-Reply-To: <20230628153144.22834-12-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CH2PR04MB6619:EE_
x-ms-office365-filtering-correlation-id: b22c0dd9-b33a-4a44-af66-08db7c6e1791
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +so3jNYu8mF/8ievWjzXvauWrlzxHhLX+UyQKZlbXD1gzT5LjKKTFtzxuOMx3y3GHWcvsn6ZaYEaGl2F2oGKkzW+eN/c2VOOW8yrtaQ5fPahOpsEnbaaloNLQ3nWQO4fGp28cDkm8av2jSi4oyQ174qiWx+/E4XohEhwqk4OIasgY3Lf45ygYOwzqmg2ETaSxq8yjzWDa7L+qubnHFGgb0Ck5PNAjfnLc5yNz3msCCFJhjNHQMDNg7KgaR5++Vo5daP05KlPOlXwhD3XJJ/vYVznbSzzGBr5b4iAEvGC9NppVfXjuEdWru+WidDgxaZuFdhsQs48iBYhRm8lgWEJYJu7mFYBheYH6fQieo7HSSIKDdwTajE/TPIOhbPtz2IATXeQfqKq4/sA30uu3+jbajCn5Xp2SEMqQu2WiShRu9vUFn+cVYBB6ECtDhmvWOvwVtV8yXDWKLgVfQqGcdJhXtwSRddR3llHEd/XIexjP6eaC3+Wxj1OidxAysYkamVEIgyLbjDwgbqPJCpvLi9aRdrrwDKOdnYbAz1YqZxqDy3zo03mKJet+Rw4y2VXHV6/H81Ydm7zvRDjFcF+L3bq6D2C267Io5IcqWj5GjXfoSFWUL2m4CJ8yUeIKEMoh+qnjrqljlAExthyyQOfGQ3rVPLbA8MkD1fZq+PVDoCl+jp9E0wgN1oeXO/9eRztpml/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(366004)(396003)(39860400002)(451199021)(478600001)(82960400001)(31686004)(6506007)(6512007)(71200400001)(4270600006)(86362001)(31696002)(2616005)(186003)(54906003)(38100700002)(66446008)(66946007)(66556008)(4326008)(66476007)(64756008)(110136005)(91956017)(76116006)(6486002)(316002)(122000001)(5660300002)(8676002)(8936002)(19618925003)(38070700005)(41300700001)(2906002)(558084003)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aXU0M1VFd1dqS1FGSXh5RzZXanRWWWVjWTlUQ2JQenVzVm5rZHBGbUNXbDZL?=
 =?utf-8?B?VHZwNWYzNjJtcWlpb293MSsrYUpHN3pEVEdka1ZoOEhNdXp6MUtLYXp1ZkEw?=
 =?utf-8?B?cEIxTWpGUjcvN2VlWGsrUytZNUt1S2VKcUJXZ1JrNjlNM1ltR0JrL2dkMDJI?=
 =?utf-8?B?NDlMZEJCYWlTZXBaTWxicDY0MVpMNVZYUHpSSk1iL0QvS2x3UnhCRDRtYURZ?=
 =?utf-8?B?RzZnV0NJRGp0bVF0emZSd01KcHlTTXQraWxaUmgyNEdSTUFuV0R4dVlWYlZD?=
 =?utf-8?B?L0lGTUFXNEVEYnU0Ymo0ckV5c3VIQkNPRDFxMU5IT2FtajN6L1k5c3ljNGox?=
 =?utf-8?B?d2hhY3JURytLVzI5UWtPSmw0TFdmZFFRN2crbE5hNGt6ajZnbXhXU1NuV3pO?=
 =?utf-8?B?VHpSd1YzQ1ZiRG9GcG5EZkVqVEM3S1lQVFl2RFZZcEF3L0RJeFRHZ2t3ZVdk?=
 =?utf-8?B?Qkw4NnRPL3RGTjFVUlZEaGx2cHhwZ004SUtsc3lxZnFEWHdtYTV0NVdlTExV?=
 =?utf-8?B?ZmdpSnI1RDArb1hwUjluenR6dVF6c2FzeUVVb0QwUmxmRTNTWkgvZkxRMzBR?=
 =?utf-8?B?cDRON2Q3SkRPcDM0UjdScEtzYVhDbGRaT0tveDBQZHkxUm1ma0M3Z2xsQklM?=
 =?utf-8?B?b1ZWNVVRUlFBamp6NS9PV1M5NWtjMGZnQkQ2djRDWU1FakJtMjRNQW1pTFl1?=
 =?utf-8?B?aGQ2dHpkcklyU3NZdi9qQ25zaXl6Sm9xVldzQUhMd0YzalppbVpGWWFMU0Yy?=
 =?utf-8?B?ZTA4bFVlUjV4RG1OcXZJS2x6TzBIaVdtUUpiREplY3hxOHk2WjVlVXZEdGRK?=
 =?utf-8?B?Q0hvazZ3UWJYZmcxYkFVSEF1cDJ0bFJIdC9KMlozbERnS0lrYmdwejM4U0dp?=
 =?utf-8?B?bFB6VEVOVEMzVXBtMEJMdGQxSkpaSUxuQmJOWUVJYmNyWUdEZXBwTU1lQkR1?=
 =?utf-8?B?eGRPNktEQ2hMenE1NVlvc1Ezb0QrcFNJc21icXBpdTdCcHovRGxnQ3F5aFFE?=
 =?utf-8?B?aU1TR05ZVmt0aWtISEdlb2RmeU5wYnJJeTJHejBPWDNvTjBZOVYzblFPdTdz?=
 =?utf-8?B?MWUrTWlhUjNycmZBaDN4SjJGVWFvWmc1b252TVVucDlHWWNNbEJDZGVpM3lm?=
 =?utf-8?B?cTg3SWYxN21JUHBjSEtUK0JGSy9RYzVQVVU2Y01QS0R3WnBCMy80Y3gvRnV1?=
 =?utf-8?B?ZnBiSXdHNCs3M3NGeXk0VnhZRmNiU01KQU9sdWhUMzUvVmJMKzk3bWR4R2d5?=
 =?utf-8?B?TjlNejFvcXcvNTQrT2RRREpJRXFIVk5nTm1QRXBnNmVsL3pCMUI5NWJiSUVp?=
 =?utf-8?B?ZzR4Sm5oRTVmYlI3ay8va1lYT1d2M3ZtUXFEYnhpdXIyVXdxR0UxUXQ4SGQv?=
 =?utf-8?B?cFoyVytSdVJITFNwT1VmMU1WNmVyVEpGSTRDT3ZJcUh4QkhxOStiSWw0ZG9E?=
 =?utf-8?B?SnlKN3p6NUExUGR6UTVvOVlRdFg1cEczZVVXUEJZNFozYzV2Q05VZUxCUGtq?=
 =?utf-8?B?aVhHSDBidmNoalQ4MTFvWkY2WGwwbTRWZHkwYVRRcTI4U1oxZG9QckZWb2ZI?=
 =?utf-8?B?US94QktXWVlOYUpyQ2JzQkl0U1JLQlUwU08xeTJJM3V0UDlmeWdRRlNjby9i?=
 =?utf-8?B?Yjk1elpRRFFhcjU2T2wxSmpWN1hNSllmVklYTFl4U1BROVA2UTBGWTBGNzZG?=
 =?utf-8?B?Y2kvT1BMOEJFQThVN2tpNlQ2NUpPdlhMSHpZZEt0STF2Tzd6TUtjNGprYUdW?=
 =?utf-8?B?bVFwanhNOWV2dFB5YnFRQ3ZFYkNGQldibk1BNzdMY0VrRmJKSFVhVDZIUXdu?=
 =?utf-8?B?anh3TWZtZUI4RjFWSEJKUHR6TEdBY2Q1V2kyRW9ka2IwNnFnUDhFbGJRZURS?=
 =?utf-8?B?QU1UWTlWTk50VW11MEZrQnhDaGRCTkJZYThObE1qUk53UkI2WkM1aDg4ZWN4?=
 =?utf-8?B?Rk9LVUtaN0l2SWpISElNc1h4TmNhN1hHVkd5UkF2TTZ6TjlWMW9LWFB1RStW?=
 =?utf-8?B?TXowT1p6S2pEd1JsajhpWkpMcUVuWVc1K3ZNdkVQQ3k5TlBKaDhub3k4eThs?=
 =?utf-8?B?ajN4VUVBcTVpYW03VGJBMGpWdGdiUVF5TXhleE8vSldnVTZsYWZ2VFhNenVK?=
 =?utf-8?B?aWhmUFB2SkE1SkFRZlJLbW9wWmc1cWZqRlBUaFdBL20wYytjRHQraDhzTHJG?=
 =?utf-8?B?VGRHUERqeHdDaE90SFExZ1JzV1UrTWhRVDYrdUkweU9RWmQ1OGRGZnozSGdr?=
 =?utf-8?B?dFlUTmh4SHRoOE0wSkJYY1l2NXNRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9B13CC7326CEC44FAB44A172C8043BDB@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: MipcqY5g19InYKG6MtK24XmXHlbbaNtgCptQDLZB1FrNHkNgIu2GbdAbAOs2ziIsiLjsJ9Btk/fArjT9Mh2X/ux4OmkE22/1v7KpBlORebbcrt4aac5IrUvS9V/FZYvyiFiCPn7g2Grgse2lj3R6Rv9b0IHS2K94eCHTbFoyG0eKx64swDbVvHY9cWOOikv2oPNcMF8vFPsaPkgy1g0LQ3cEq8I9M7MHTNC2oN4ub1f4pFlax3gK9zMzoeC1dAMGPC338bxBseLiupQ+gsDlbaHkJK0H/xkBS3KJx5oXy1d1QAgCV9G4O8x4SYeAxezKxJ/aAr94bstb4e/HM8AbmpusMaHFpL/uXUVMVNlZIwV4h/Syioqy5tlYJt3iHJ+St6ned7TK+4mhKTDcYQGFi45UD6p7tpI0Zt+F1eKbYw6XCytPEPyaK8w4RZb+r4uxAn/0b83IbVPpIQUyv05gK6osWOSvMRY7Sx9VOqnloUcthSitNEVAMGwmgZKsYIJBlgLFcmH9p8+26Wzl3kw+iE6smwC+39QflkUehymQ15u4wmAC5IDnV1a50/D+Er1069Efoj8WICxuDP2kfCmw6EN6wvpbT/mMQdZ+6CpLMOeRZhczFdjzkXokVxF/NQGVeVsCp4sysx3cFRUibeCTmfmEEiJFMGW4DMZ8DMzTFR4fvze+aM1LX9NL33oAQ87LPg+2yBnRWuAQiNlGWjDxtU5oIyoBz4Aee6iSfa5PlOh9ykYOpunlf8IQ+JE4Bpzq46zl/6hdRX3YkA7bscsN+CSPnFg42rtmdpEjEiaWQCyomXVlQMg9w+NIYklv3as26AAtFdprnae95cdE5cJ/y7EKf1r2ems0dhl3qdH3zQPZRTbGVwZOTsMjb1Exm0yty7+gLYxwzE6BRKQFR0Bmi+NDrgLQZd0YDGodsdnN2ps=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b22c0dd9-b33a-4a44-af66-08db7c6e1791
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2023 09:07:28.6371
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YAAGuYqdC56HdHtrvdKv3cIpBt389LmLelpnurB1X8y0F+sSD5SpDY0lV/snj0FVTr17/3TH9s3izpAht4RKIy0plmCBwlRfkOR4iaZq/ZU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6619
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
