Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 952546F7E63
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 May 2023 10:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbjEEIJh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 May 2023 04:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjEEIJf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 May 2023 04:09:35 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68BB10F3;
        Fri,  5 May 2023 01:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1683274170; x=1714810170;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Iz/H+ZBxCfkS6Lf28z9lYdEy/mLDJr1S9apLE5DgGhk=;
  b=rJ82YoRBkOg05rcmo+mmvQorqBm4wUj6J6yMR2JE/lr69nJ/avEz2owj
   k3aEesoka0BEYL6Q6PsK6UTq6hQEsqPVOBrptYrjFIgovVEITVt5L0jPB
   PGvlVyK680VYxxfs+gC1omww7ma4gnChvTOyunXppyy9WRR+5a+Bor6SP
   GjlqYCc1Oist8jKf/36onT8sDeoijTMGzDijZBGGd8Z4BL3RluMR1+dsH
   VSmdruCP+uhyHNzYs2yF21+4PeKeItVyQCYcMOuDJ+G99+85LTKqCKgNF
   D1H1kxOzyHtVrCzrgaPEvbi0fHpInm6TKwXVXyftYuFjlt5lTwKG7eukC
   w==;
X-IronPort-AV: E=Sophos;i="5.99,251,1677513600"; 
   d="scan'208";a="341985589"
Received: from mail-dm6nam12lp2172.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.172])
  by ob1.hgst.iphmx.com with ESMTP; 05 May 2023 16:09:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nBrm4FxSHJcVn/Fxbp735IquiKxRFQUXOEW0O1Y3cW5M4AWNOAoJgqLIMaC6QsHJLlvIDSJS93NLsH/fivY12PbmMNP92usBSr7DqSw1ZOByCEZYbl8qfNA9xzxj7M5Vz15hv9Z9IhFkDyyaC0egyL7JminUVBg9nHuIsqhAojNGLVkqdjQOq6hIA3Rs9ts/PHqA+pAnXwIG6z96kQkB8vwz4fWTEr9jM7EWLTrbRUm72fU/faOekAlASe0oCr9kLPUi6vLSng64ek8Ns71Zz50HCeO8OxMb2XVUXRXCe9OujVXBe2MsHnH1JP8Q2D4FjKT1oS/yqq375hizaMUT/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iz/H+ZBxCfkS6Lf28z9lYdEy/mLDJr1S9apLE5DgGhk=;
 b=V8ZMqjS6DeaK9P8dDzrYTemV1wFUP36z+Y0M12QYARW6ope5BHvOu3Vbg9F2o8Drk0atnJb0tRoLbk0FnS5+jg0jululgkXRkSCgz5AVZ3CO5sBAXl9YtY9k+jp5Hl9D0ixKTvq4ygOgf1tYzUjxjkxKnLweRt1TZ0xDetcugd0KjN9acHHs5VNHu4hijVkNF7nZxzvvstGn922MfcNRkADnvKbwlsLbF3dayOWA+2jW//acWsskwqmaqsrv6qLT5KciUyD18glZSWLA5aiOITWVtf2jZ7Ptyt8S3vvjxdRfVo7rMQkzKM7ydi7TwcaKr+l17ciKG9NuF025n4S0LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iz/H+ZBxCfkS6Lf28z9lYdEy/mLDJr1S9apLE5DgGhk=;
 b=yXy47+NYYL+te1P9m1NeMwDaVVYgtTgSIhLQrCcHnVOZe7iEYKcW2bxHsibJyMZ2d5vDAAC5OV6aZ+9D7gLf/tF+5y2LlPJ0wsulGGriTsV7GXp+AoAQt80mJZ+H+OzOEpyy5h1swgsAwbgepocLvBdei4rnXD4ZZQoVZST9KfA=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SJ0PR04MB7789.namprd04.prod.outlook.com (2603:10b6:a03:37e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27; Fri, 5 May
 2023 08:09:26 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f%9]) with mapi id 15.20.6363.027; Fri, 5 May 2023
 08:09:26 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "axboe @ kernel . dk" <axboe@kernel.dk>
CC:     "agruenba@redhat.com" <agruenba@redhat.com>,
        "cluster-devel@redhat.com" <cluster-devel@redhat.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "hare@suse.de" <hare@suse.de>, "hch@lst.de" <hch@lst.de>,
        "jfs-discussion@lists.sourceforge.net" 
        <jfs-discussion@lists.sourceforge.net>,
        "kch@nvidia.com" <kch@nvidia.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "rpeterso@redhat.com" <rpeterso@redhat.com>,
        "shaggy@kernel.org" <shaggy@kernel.org>,
        "snitzer@kernel.org" <snitzer@kernel.org>,
        "song@kernel.org" <song@kernel.org>,
        "willy@infradead.org" <willy@infradead.org>
Subject: Re: [PATCH v5 00/20] bio: check return values of bio_add_page
Thread-Topic: [PATCH v5 00/20] bio: check return values of bio_add_page
Thread-Index: AQHZfN/AsiDj2VYjN0WoDrrCAoWRkq9LWBCA
Date:   Fri, 5 May 2023 08:09:26 +0000
Message-ID: <1ac1fc5e-3c32-9d62-65bf-5ccbb82c37cc@wdc.com>
References: <20230502101934.24901-1-johannes.thumshirn@wdc.com>
In-Reply-To: <20230502101934.24901-1-johannes.thumshirn@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SJ0PR04MB7789:EE_
x-ms-office365-filtering-correlation-id: b816bb53-c728-4795-462b-08db4d400b33
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4AMGp92j19UBZNXDdTzVhLLpOZVznAaCyjJMCxcXSaetz2HulRwiia3lrBJcVpt2qOiMmVnBAiPHrxGLMTWBY4plc75VBDuPO8L7OzT7oDKITDpAlcxqASGMJCUmDmMPG2aAhDIeQSExQoKCQTA2LaNmMhelrlhXcWUyjDIhXnegtk3JPTxoahrRiROG4Dcvokg7i0WNWVbP4M1xs6oNKKFHaM4y49K4rcCNTFMkgIriC1iPTj224AoKu+xfAWoSB1vjD8BRfncWxEoD5UaL4C+ybK399wFh+XVcPvl+KIezMbUrOe2coEs3iOrW6uJnye9zlZ+PxATsqpWZeSvkHD4jlrSz0adUe177Xikfujt65bS9M8ZJ7/lXZAGhp65ckWzGHwBnlScNNtgq180R9aOJ5EDU74LPr4ZtjOJfDt8nkXHHfpCmK7Gngw/I0i8SIeztIUIY0fHFMQCu7MJyZNr4+zKrt4laLLiQC6V3uZepAEM8LWXQDIuoCR4Ovj876wpg1meUoCkGHuv3F++c5hyERvjVXIjyWMW4CoSLJ6dHCvgnqbFAK4FuozMGP4J39orW/NGl6b1tCaP9MssukW+Tj3petCjgY/5/7ZPBZcL+kcng2yJ+63ZKCXphAHZrlO9lSh1U1JZ36/gAspErconMRbTBGNDNcHKVQfv6FFEP2IOt0mfkla3vJJsUk+T9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(39860400002)(366004)(396003)(346002)(451199021)(31696002)(6486002)(86362001)(36756003)(71200400001)(54906003)(316002)(91956017)(66556008)(66476007)(66446008)(64756008)(6916009)(4326008)(76116006)(66946007)(478600001)(41300700001)(8936002)(5660300002)(8676002)(2906002)(7416002)(38070700005)(82960400001)(122000001)(38100700002)(186003)(2616005)(6512007)(6506007)(26005)(53546011)(83380400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RU5NY2xDeDBkRGR6aDFlbS9MbFBKSTh1TWxEZVNzYVE4ZWZvM29UUWN6Mndj?=
 =?utf-8?B?OGgvcUpQS0YxSXYrMnIrVndRczZua3NvRWxFMTFiTEg4U3E1Qjc5cUQ0M3B5?=
 =?utf-8?B?NFNXbmJzcjlVcEJvS2dHK25qYlVGT1lWSVFwanhJd1VmZEhtOWpBVUtJSDFS?=
 =?utf-8?B?b1d6WVIzaytOVDJoanFuZzFoN0JmOG1VMU1lZ3lJcGNaMnU2d1FHbVpWVS9j?=
 =?utf-8?B?L1hkb1FnMkRZOVlUMit5Y0R0Rzd5bWM1blhJVkl1UUFSZmZnd0pQUWtaRXpV?=
 =?utf-8?B?WjVsT1JDZEZXTzVqenFMNTZ6dnMxai92SU5mRk16a2JDZW5teFlHMDVDSHNr?=
 =?utf-8?B?Q3grRGk3K01WNStndnNCa1F1S0ZpTUZXWTVhSDg5ZlJ6bHMrQ0JUNFpJWXI1?=
 =?utf-8?B?RzM1aE1wUU12RU9WRlZwV3pWL1ZCTGR2eHhJMm5UMkttRGhRZUN6dTdNUmxC?=
 =?utf-8?B?RGN0QkZLRlNOMDJ5d1NWVDFoaTZTWHBjZkpmYU42ZXRqYy93T2h6T2JzcU9u?=
 =?utf-8?B?QzRUUCtKM1lKZ1hCaEtuUlV0dE16anhxS24waUNQOEZOcVhyWll2WXJ0TWZr?=
 =?utf-8?B?MDNzVjZWbUtTTGkvRnRuMEErUzlsWTlKZnV3eGMrNzUwUzk0TElwdkFEYk1F?=
 =?utf-8?B?blBxL3QxVHhnK3V1aDNuU3FtVVhKYllyRFl0K1lhZjY2alJCbDI3VVMxWHFi?=
 =?utf-8?B?RmNPOU1LUlMrR2hEUmVQSDhUanl6MXJwYlJjKy9DU0xKbklNT0dDSXVxTlp6?=
 =?utf-8?B?TXVaRHdDSDFKdTJGS0N1UlR5WTVzczR4cVh1TXlkWERMaWpwd3lRMnpxa0tN?=
 =?utf-8?B?UFpsbWF5WEgwUThYbnhGQk0wRTNFZ1hqaHA1c0pGbkEvdnRtNkFCS2trYzFN?=
 =?utf-8?B?NE9KZDViL09vS3U2b2pRSldpOWJGRWFQZlZCSlBFdTlvZk45N2ZxTXBYeUR1?=
 =?utf-8?B?SERMWWZFdzY1WlpFZHBtc3kyRVkwOEFWRDRUZS9rdnYrOFU2OTFJdjFqSStC?=
 =?utf-8?B?c0U1cjc5UFNXQkN0bnFXSUVObkc0UDNIY2ZJUlRKWkhBM0M5SUVsU0hTNDMv?=
 =?utf-8?B?bHNCaFdTclNwdXBmaVg0aVliTk5RVkdxUjc3aVViNEVFWVkwWnpNK1p0Nkcz?=
 =?utf-8?B?Q1M0QnAxVmREeVRjM2YwZy9DZ2tHNUx2dkxQWUtaQy90ZFhrSlIvc2dIU0F2?=
 =?utf-8?B?WFJ3ay9oSy93TVQzYlNIcDN4QlN2Qk5pUjVEN1RTTG02cCtOZ2MreDlKem5t?=
 =?utf-8?B?eEFaWEFDY2E4eVRONVlVdDJlUWlUS0NhbThCQ1MrRWszMzdOV0Y4QnA0MkYv?=
 =?utf-8?B?S3pjMEsveGZRNTZSRkR6TUVreWhKYlBOc2ZDZ0REOCtYaVY4RytPdjU3aEJs?=
 =?utf-8?B?aSs0VkxTeVZPdmR0WVBiZ25rUmRKSUhidnoxRU1vV2lvckgxcXFjb2VJUFZO?=
 =?utf-8?B?RUYvU281QXJpK2J3WWNGdHNtR1hZWGNIQXBoc0l3dEtGNElmWFdDN09ZNTRU?=
 =?utf-8?B?TnNrR0JxUTVYV1lwT0hOQnFRNGw0M0IxWXF4TUUrTVlBNVpveWMyZG0xUlRu?=
 =?utf-8?B?am9GeHM1RnMrbzZnNzU1bUZSbHJDRFRjWlUzK21Nc0xnV2xhMWFxRVFrbGVX?=
 =?utf-8?B?WGE2eFppRERMVlZ4OEplbE5OSU1aRGdkcTdtdC9jOXZsclBzZi80T2hwNEVK?=
 =?utf-8?B?V2tGTktWT0NyZ1FsVE1UYWhoL0NhdFYxS3R6OVk2TGtVcVpjMGppbUFvaFZY?=
 =?utf-8?B?Vy92dllBNEYvUnB3TnNXeWhqbUMvN01xaTBGeHlScUtCS0JOYkVLYmcxRHor?=
 =?utf-8?B?R3pPWW5BcG1Id0RWREpKTnFjMW15cElTam9iTEYzVUpJanlodGdkaThxSUpj?=
 =?utf-8?B?cVVoSUxJRVZTMWF1TVpRU24rdDIyb1UvakdvWGlFaml0R3EvRnNtbHU0Z29j?=
 =?utf-8?B?S3pQMTRCSktGYURBcDdWUHlqWmdvbytQWTdEejZjRHdValVGdS9wOWNWaTFI?=
 =?utf-8?B?dk5kcHpLeHNzaHFWQkFRaTN1WDhma3liaDBKVjRzODAzaGIySVgrcWt3L3NY?=
 =?utf-8?B?bHBvQ1JDRjY0Unc4aVN2TEdkcmltaW9DbGRZZyt1aEdmWGlxdG52VkxIZmxI?=
 =?utf-8?B?RE1VS2lvekxQV0JCMllLeGRqaVpQVWpGSUxrb1pHQ2JINFBQenJPdjZoZEpk?=
 =?utf-8?B?Qmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8B44041DF394F64F9C60DE91013289E3@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?Z0xobHV3UUtiNkNVeEdmYWphQml4WUJPenZDblJqNjFyb1htUWxyNk1KeVNN?=
 =?utf-8?B?YmxUSzZQWmEzU2VKYldENkZHaU16QXp5RkpxR2FVQStIUFJUSmY4ajMzejJS?=
 =?utf-8?B?VFFRTms4QTBhdjFTVExtWktST1c3LzZ3eUc4cStwUTV0TGdBdndGWWZLNU9h?=
 =?utf-8?B?T3NWc2ltUTRTQitXaWk4K0lCZjlBTkQ4OXVXVnlIOG0yZ3lwcStlUndieTBu?=
 =?utf-8?B?TGpZaGhwRVBhRWRKNkRhOEl6b0tpcXk1a0o5RXE1RndrWDY1Y2prS29LVVBp?=
 =?utf-8?B?d1JGWml6UzNXZG03WVpVdTVpYmNtVXRPVkxNQWxiQkkrYzJ3WHdLTGVid3RZ?=
 =?utf-8?B?N3pidk94YysvZE9TTDJITmN5TnU3cHlHYktWSnkzQUw1cXFhQ0hUalp0TjFy?=
 =?utf-8?B?RnFLdzM0WHNPdHhUOU9FaEdrRmxXTEN0b3VEZThsSnhzblJRb3VnZ1FXMGZO?=
 =?utf-8?B?R2toQzl1WGNHR2hwajl5eFp4eW1SRmpzb3hFRk83SmgxT3VMQUJSWlhlZUJ1?=
 =?utf-8?B?YUtka0xXcTBLSkdpTXQvdVpLdXJyZG5SWjFLSG5kQmhURHNrQmdxcWtZR3Q0?=
 =?utf-8?B?RjkrUjJqLzJDeG15Q0RpT0ZBOFJDS0wwNERRU095NU9yQ0QzY0hQc21EaUFr?=
 =?utf-8?B?M2xjQmtWQk9oN3JxRmxHWExiWUg5VzhJaXovQkhzZkxubTVhblQ0ZmVGUW9H?=
 =?utf-8?B?SXEvMUZPa3k5ckFGWU9oRllnWjdUZXAzNVhmYUQwVUkzcG1DY0lJOEY3MzNZ?=
 =?utf-8?B?Y0E2VnV6T0d1L2twVFczcHFjTm1hdDBTMzF4Y0tOMlpCOXhGaytYNmE3VTNo?=
 =?utf-8?B?ZFdCWDRFSWR1WlJhTnp4QzJMSjNBcVdoam5ZdjhOcm1JQU5JOUwzWFdKUGk0?=
 =?utf-8?B?Um9PMmJFRFpTV2RwMCtIS0lKTG1nb00yOGdJUlIzdmJXNVZkVG5UK3c0alJa?=
 =?utf-8?B?cDFYSkExdVZuaXM5Z1I4NGRjclJEeUZkRFd0T3JtRm5WUVRwZ0IxZi9rMHhi?=
 =?utf-8?B?L2h2Qm9IWFZaTnpZUWFXL1NWeGFpbXA4WTB6WkNZWEdKV2orNEZiWmJIUVZN?=
 =?utf-8?B?VXhlcDJvckxLYnFxclh6enZMWnExMmFVSzFBVk1KbzNvU3ZrRGhGTVFzMzlU?=
 =?utf-8?B?QVh4aFY3SU5ld0VxWmE4Rno1b0w2WDdzRU5UVVkveUp3V0kvNzkwVmJTSEJJ?=
 =?utf-8?B?ZjlMZFpVQVBMOWlPR2xYelE0bzVHZlRFM091cVVXZi9pSUx0N0N6VFVoRDRO?=
 =?utf-8?B?ZUlhNzJWVEhQOWtGVDQ1Z3pMRmxNN01DbFF3QjdldHNyRkJrUS9EMVhYSnpn?=
 =?utf-8?B?WXZpcmJtb2tZKzBFTWJwdElObjFrd0FMRHNFWEhRejQrSFQ5SXVCSEJJS3ls?=
 =?utf-8?Q?BgHtTMA8SnCtLPj+7rWPbVaqxeJlYhGI=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b816bb53-c728-4795-462b-08db4d400b33
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2023 08:09:26.3758
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A9FcFv04fNHEmzePUQq8DNn9WkFi9HX3bApreEe0T0e8AZgZIV7ME78AdVTGItDuhA6CkGyA6TUbo/cZoh0soroRy3YbuL0p2pU2KfnmF9U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7789
X-Spam-Status: No, score=-8.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMDIuMDUuMjMgMTI6MjAsIEpvaGFubmVzIFRodW1zaGlybiB3cm90ZToNCj4gV2UgaGF2ZSB0
d28gZnVuY3Rpb25zIGZvciBhZGRpbmcgYSBwYWdlIHRvIGEgYmlvLCBfX2Jpb19hZGRfcGFnZSgp
IHdoaWNoIGlzDQo+IHVzZWQgdG8gYWRkIGEgc2luZ2xlIHBhZ2UgdG8gYSBmcmVzaGx5IGNyZWF0
ZWQgYmlvIGFuZCBiaW9fYWRkX3BhZ2UoKSB3aGljaCBpcw0KPiB1c2VkIHRvIGFkZCBhIHBhZ2Ug
dG8gYW4gZXhpc3RpbmcgYmlvLg0KPiANCj4gV2hpbGUgX19iaW9fYWRkX3BhZ2UoKSBpcyBleHBl
Y3RlZCB0byBzdWNjZWVkLCBiaW9fYWRkX3BhZ2UoKSBjYW4gZmFpbC4NCj4gDQo+IFRoaXMgc2Vy
aWVzIGNvbnZlcnRzIHRoZSBjYWxsZXJzIG9mIGJpb19hZGRfcGFnZSgpIHdoaWNoIGNhbiBlYXNp
bHkgdXNlDQo+IF9fYmlvX2FkZF9wYWdlKCkgdG8gdXNpbmcgaXQgYW5kIGNoZWNrcyB0aGUgcmV0
dXJuIG9mIGJpb19hZGRfcGFnZSgpIGZvcg0KPiBjYWxsZXJzIHRoYXQgZG9uJ3Qgd29yayBvbiBh
IGZyZXNobHkgY3JlYXRlZCBiaW8uDQo+IA0KPiBMYXN0bHkgaXQgbWFya3MgYmlvX2FkZF9wYWdl
KCkgYXMgX19tdXN0X2NoZWNrIHNvIHdlIGRvbid0IGhhdmUgdG8gZ28gYWdhaW4NCj4gYW5kIGF1
ZGl0IGFsbCBjYWxsZXJzLg0KPiANCj4gQ2hhbmdlcyB0byB2NDoNCj4gLSBSZWJhc2VkIG9udG8g
bGF0ZXN0IExpbnVzJyBtYXN0ZXINCj4gLSBEcm9wcGVkIGFscmVhZHkgbWVyZ2VkIHBhdGNoZXMN
Cj4gLSBBZGRlZCBTZXJnZXkncyBSZXZpZXdlZC1ieQ0KPiANCj4gQ2hhbmdlcyB0byB2MzoNCj4g
LSBBZGRlZCBfX2Jpb19hZGRfZm9saW8gYW5kIHVzZSBpdCBpbiBpb21hcCAoV2lsbHkpDQo+IC0g
TWFyayBiaW9fYWRkX2ZvbGlvIG11c3QgY2hlY2sgKFdpbGx5KQ0KPiAtIHMvR0ZTL0dGUzIvIChB
bmRyZWFzKQ0KPiANCj4gQ2hhbmdlcyB0byB2MjoNCj4gLSBSZW1vdmVkICd3b250IGZhaWwnIGNv
bW1lbnRzIHBvaW50ZWQgb3V0IGJ5IFNvbmcNCj4gDQo+IENoYW5nZXMgdG8gdjE6DQo+IC0gUmVt
b3ZlZCBwb2ludGxlc3MgY29tbWVudCBwb2ludGVkIG91dCBieSBXaWxseQ0KPiAtIENoYW5nZWQg
Y29tbWl0IG1lc3NhZ2VzIHBvaW50ZWQgb3V0IGJ5IERhbWllbg0KPiAtIENvbGxlZHRlZCBEYW1p
ZW4ncyBSZXZpZXdzIGFuZCBBY2tzDQoNCkplbnMgYW55IGNvbW1lbnRzIG9uIHRoaXM/DQoNCg==
