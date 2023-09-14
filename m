Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97D2979FB8E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Sep 2023 08:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234814AbjINGEU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Sep 2023 02:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235165AbjINGET (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Sep 2023 02:04:19 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E42DE101;
        Wed, 13 Sep 2023 23:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1694671455; x=1726207455;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=LfTrNGylkqPwfDDfKKOx9MxSxfRYHkzhGjfvmQ0SjbI=;
  b=KPuelJn9gmYjPCGXQ/YkP58fbTk3vTY3yQh6QqYjzIuueSOFt8BaNkUu
   GxkRUuLOSd0aepe3A16J7C0Lwc47/65ffN+PsFk9YQLz1epU1vpq62GbV
   i5NWtT6hi/kXvFOQJNHIdX2APSKbibXgKnclJLNz6MaxI2NM/zHneGioh
   Hu6yA5+AM7H4RhGlDKqCYfbMjOkO4IUKYWeS4viIfqgUGHu6kwTxlnsoR
   mhyQZf9WH0ABrdc83Rvsj49HS3vosR/GyiSLa0jPZ1SpQqx19jsZm31Is
   2/yK75d+X9WV4AGpDvHhclFhrh5I21DmAmJYmSLZwbEcLU2EZlbxBrZW5
   g==;
X-CSE-ConnectionGUID: y7SBif8nQ9yQZ5ZF/NkkZQ==
X-CSE-MsgGUID: LWij3NyGSv26/BN7QCJvNg==
X-IronPort-AV: E=Sophos;i="6.02,145,1688400000"; 
   d="scan'208";a="243924743"
Received: from mail-bn8nam12lp2172.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.172])
  by ob1.hgst.iphmx.com with ESMTP; 14 Sep 2023 14:04:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PU+FsmScFujTr27Gy6hKCj0Ol3bIQhnmkeV5/Nr5VWVpOotchaAjCOSN/srmKViqPcTsle+yyvxHoYHHUVDjsXORCqb0ONO3ua7PsyWw9ztVc08G/kksXdi+f7CZbYTDjrlRs2Vrgm+cSSpbO5fkUHlpWXbQKjydqmai7VFYnsVoLV6gHis/uE7XpMnhIElcv8iqZ8RUfuaG6QfWb4Gm+axO035ZGjGmCOKbD4ytISWu7Do6PePgTRqBRD7GugYFSOqOFTETtMMbGrksbx/lmEkMZVKYTEEI40b36+UX7jc1nk+K8mCF5ZAJ0iVyyupoq4Zc8pc9qRFfb3Q42o35Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LfTrNGylkqPwfDDfKKOx9MxSxfRYHkzhGjfvmQ0SjbI=;
 b=bxxFZPPtIL2KMWVrTEYNbQmCRV5ZXET33ubGmEB+XiCOh793WZVqVfg989X215rOJlmwbAqFTcj3cEJ1fhrY5uYIHVfmbFTScb2de5sELlhxpK732sV/H5YFHjA1893sVeC/qp/5BWlnln5uBdENf6Fqe7NeBL/skO6ddLoVynbZNa5czuzk76n+xDK459XNH2IN+5uBALn+2VqXmrggkE8P2Vr0psA7kiiXRABNr+zzU3CxHh98FReTtt4hPBZgYWWjSwqh1A76wsy+cCTgH3vlDl1wiLRnjFHw37/eUdYcBEnnp3SuQxPEFI8dIARZyPODBwUYE8F56AKCdVzSWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LfTrNGylkqPwfDDfKKOx9MxSxfRYHkzhGjfvmQ0SjbI=;
 b=hbaBzbbeIcHCyG2Pj9FjESq9OIoTtAu1kpBTUICG2Nsm7/EX95EpQj0+J9cmnBgcIG07TtRfzNK81uPyQ596XPCHbU8NicOAY9S5QD+xb/N1JqXHTvu/nOyH2eCO+Twhq2orrLZGalf/hihgfaLWCMBrigln07fA1aC29Nrwa40=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH7PR04MB8707.namprd04.prod.outlook.com (2603:10b6:510:24f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.7; Thu, 14 Sep
 2023 06:04:10 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f694:b5b5:8e42:b8f6]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f694:b5b5:8e42:b8f6%4]) with mapi id 15.20.6792.019; Thu, 14 Sep 2023
 06:04:10 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian@brauner.io>,
        David Laight <David.Laight@ACULAB.COM>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 01/13] iov_iter: Add a benchmarking kunit test
Thread-Topic: [PATCH v4 01/13] iov_iter: Add a benchmarking kunit test
Thread-Index: AQHZ5mN1LcmeOywzMEKoyfsHMT57trAZ1caA
Date:   Thu, 14 Sep 2023 06:04:10 +0000
Message-ID: <6139f775-f64c-41cc-b29c-b85e296c26af@wdc.com>
References: <20230913165648.2570623-1-dhowells@redhat.com>
 <20230913165648.2570623-2-dhowells@redhat.com>
In-Reply-To: <20230913165648.2570623-2-dhowells@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH7PR04MB8707:EE_
x-ms-office365-filtering-correlation-id: d763e168-3cd1-4c80-a4f2-08dbb4e869fc
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LjYobV5lNJHLf6Ky+gSfm1wzOwmpFkPblrz78qrh7mdt0VFE6UjBOQpXSfH7iA9vrqUV9k8OyKvchQSzPk7jBuDNJmxQlIwBtLO0JX1XAGFEpbg2gna8C0pcOyYj5FrjU8LVdaQkN6vnlt9MMRHHBuPav9nA0kxoI/YtDOqHX385hxNvNSfV/Kk8jDvXrvdNecW/wzQ0SAThc2HCvc9hpvRt+EgQGHqUEgEN6+jC9ty43jL2FoK0dBWAHWVfFX0fXqa4NG3A1ev/hG/VBPN4CjCpIabehj+HfCt03nFgBD5BkBu7lh515D+J+pGdTlKIpwCFYrb4DyfWRDrDj5CycSgTIOIrXz9eeKkClM6rPRnv64UI2Mh2pZaKyWIZgP4ekngLEQ5fdlA+qYv6H0jPNjF/p2fkIHYzofKMqV7QEmx02LJnYhvOtOg5ERy6sBdL8UjgOSyjCZnM/Pi6QWP874jYZVkQveJLD0GWYChxw4RWQebUm8PxuB0feu0g3Zfwe7yEFCejta2nqOK8tATdOYwDNQ/Lv4jJLHhRcQ+r3u8LbVZMxALjbUJ9FL+p0K2C/uLIzjNXvUcZtEHKRXToBpr35Ho83Nq4loVcR4uiVHKdfQ5v1sE1BfOwIgPb+pQ6WlOZ6juUEF0Fo8uBPm+15iGCvmjcsE3JU/cmMSaDqeAOxakf+R/C6rj31umAKCAl
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(346002)(136003)(39860400002)(186009)(451199024)(1800799009)(83380400001)(36756003)(2616005)(26005)(41300700001)(110136005)(316002)(66946007)(66446008)(64756008)(76116006)(54906003)(66476007)(66556008)(91956017)(6512007)(31696002)(86362001)(53546011)(6506007)(6486002)(82960400001)(31686004)(38070700005)(122000001)(38100700002)(71200400001)(5660300002)(8676002)(4326008)(8936002)(7416002)(478600001)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SWlsVUNad3dYWG12SDdrMXA0TGtxeFRlS1p4aDRnZk42UG5jbXExd1dESWxl?=
 =?utf-8?B?cWViR3I0U0pRRFpDZWl1SlJGTGJEU1pQRVV2UEVMVFVYTzhDR1dydGYzaWla?=
 =?utf-8?B?NVdSZ0pXZzAzVnU4V1ZrcGdVOEtpTnF1KzBkZ01wbXB1ZytDbkcyNzJ5N3Rj?=
 =?utf-8?B?NTZRa285QVhsdHdWbXNrSUR1UFc5N0pxbTVzNkZMdWEwOEdjbU9KQnIvSEQy?=
 =?utf-8?B?KzYreDdsRkErTXR2QVVEQmhBUDlVR05xSXl4WFFpdFNibTliZXFJNmc2L2tD?=
 =?utf-8?B?bXVhSXg3YXBvNkJZTXdqVEVYZzNZMWxYdWhEL21WNExCZmc3M2JLNWRqNUVR?=
 =?utf-8?B?TFhUT3lCQ2tTMk5GbWxpUkx1SmJocldMenFEampGQjM3cGZMN1ZqR1VKZk5u?=
 =?utf-8?B?bit2ci92SmkxQVRxQXNuZ1l0eU5Pc3J0UTFDWmFMaVVCWUk0ajVtaHYzUENv?=
 =?utf-8?B?Nm9GRnVva1N5WHRROFlQME5wS25lak14Y0VsSG5scWpTTFJqbUV0NllaN3or?=
 =?utf-8?B?TmcrSlQ0bkdhSmVPNkdhT1pYOHFRbGk3YUVrdnpnMFNsZk96WFd1ZXlEM0Rs?=
 =?utf-8?B?ZWgyNmtaM1hXV1lFQXdNQmpNQ2IvcU94YW1YVnNBaEtCRVBSazBWQWVHL3hU?=
 =?utf-8?B?OUNuTUNuNlh6eGRsYWtROEMxRHp1QTVTSnNUTzZDKzhRekU3blowTitJZVFh?=
 =?utf-8?B?Yk1VdW9IdXVEZkZBOGRzbFcvUVRrdFVkcEtKVE0wSEFUSHF6Q09HLzNaUEUy?=
 =?utf-8?B?d3c0WVdTV1F1YnE5NDRMNnFoenBhMEFIRGNOUG5JK3YySURYenVydG1yNFNX?=
 =?utf-8?B?NHllMG81elVLUHFYZHRYK2Z3aU5uc21yTlhNMjB2UTcxcW15YUlodlNobWdF?=
 =?utf-8?B?Vm0valFkNGdxNzZESHFoN21FSC8xdHVHbjJJcVE3QVpZbWZpN3g4VFpjNFVy?=
 =?utf-8?B?c3VndmdXMGNmeExYV3YzNEpiWHhQckZLV28zWU4vZmFmUDJ5RzB3cUhlSUpN?=
 =?utf-8?B?WnpWVmtkelBMbHJsamF4eXNtcUpSL3JZVmp0U0lnR2s1OFp0Z2VSUkRQVEU2?=
 =?utf-8?B?RVpoZjF2dERNUUFieTIrbzlBVWJSd3dkWWJVM25kS0dWV0RjVWNYZkJsM29D?=
 =?utf-8?B?YzJhWFV3aU9KTmt0L0g4b2hVc2RwVDM1VmdaOUg4Tm5ra0N1Uk5yYWRvYU9z?=
 =?utf-8?B?bjNvclpXcWpCdjBIcWx3cFUrcU5VVVUzZm1Yd1F5dmdsa1l0eXFWTVBSU3FG?=
 =?utf-8?B?K0d5dGZuc0V0NzJvWkJENUM2VmdjdXBmZjNTZFJaV2lYK0NFMDA5R2VYYUR3?=
 =?utf-8?B?bVIzSnluRVZTZkFwcG9EWFhGQURZSFQ2enhyTjd3R2pyUXYwZFk1V1lzZmJa?=
 =?utf-8?B?N2FteGtTaURVZ0M0ekZPUXo4SENVb08rZkVjT25Jd28zcGlCbUhQR29xMU9h?=
 =?utf-8?B?SE82WlVvank4dm9hN0VKaDFTZys5Vk5UWGIxNi9tT2lnZlgwMEpMZUR1OWdk?=
 =?utf-8?B?UkxFaXpvT29PSXN4OVVYMk5OKzUyZHkzR2dOU1l3M2h6V0ZSVytSdjNic0N2?=
 =?utf-8?B?b2JaOUI3V290bm4rQkZVWlRXKzJaa01ob2I5NG9JUGRnaWlPL3FQeWw1VGtU?=
 =?utf-8?B?dm1yQnJLWlpwUTVEOU5oWXhndjNEbmlKOU16UnErbzBCekVTRlBKdml5N0VY?=
 =?utf-8?B?UDlkczB1cEtHNXRvR1dnTHptZ3Y3K2VUb05RaXhBNFRoUlRrLytFd2dTaHEx?=
 =?utf-8?B?dkJXNTRpTDRROHJ4SkxPZHQrVzZPMzNoWkJESVRDbTNxSHpmU2xaeko2NG03?=
 =?utf-8?B?WU5tU3lITWRLTzhLQ3EzM3VUWk44S0pqRDFnT3VEcjNUVUxVeE1tUkZmUEZi?=
 =?utf-8?B?RlJ5WHI0dzJ0eDBtVTRPNU9QQ0Z6YmFvQVIzbHRabjNjMjBnUzVLQnRvR1ZV?=
 =?utf-8?B?R0tHLytDYXEvSVJBVnZTVStxZnJLb3kza3huTVEzcEEvekJodkxuUnpHMGxo?=
 =?utf-8?B?WmVDNUppVUpjUlZTeFo0MXRZMmtwTnZDcHR5ckk0TGNFaVYzNHEwYjBRNTFQ?=
 =?utf-8?B?WDJXUWZVNllpc2gvOFlMV2tlNUU4RlM1d2ozM0VobVpsdGlLWi9QQzh0Q2JM?=
 =?utf-8?B?b2xUYkcxL3I4TGdsYWRrNTNuS1E2cHdJMVd4SVhnUlJ4SGxxZFdOc1l1Ymtl?=
 =?utf-8?B?Unc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <80541952DDB8584B83EBEEEAB992B9EB@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?ZUc1K0c1Q3hWMk1uSUhvdGhXWWZZV1BoYlhUZEhWWldmT2NFZGc1Zjg4N2hU?=
 =?utf-8?B?cXpIUzhkVk82elpGODJCVi9zVWdXRXZ2VXdQOW9USWc3WlpzZ0hrdW1IQ0pY?=
 =?utf-8?B?cURVemU0emNWajh5UWhVSFgwcGdLbDVvWm4raTU0OWFzYndWdExQWStBVmJ6?=
 =?utf-8?B?c3RPN0NGNVpybzljTTA3eG4vTUZGeGtydStLQk9nWi9VS1JiWW1yNFRHL1dR?=
 =?utf-8?B?T3l1R1ZNQUZxQW9GSmpmUlBwSDRJdXR5VjEzT0xSV1BmQjJxUjBvUXoxY0hH?=
 =?utf-8?B?dkV0U0k3ZE9jVFBiUDA5OG5teExyME1jeVZBZk5JM3M3eGh0VmcyU3kwZEFY?=
 =?utf-8?B?dGlFZlBqNHliYThPZE9qNDVkWGF5Vi9UbWZjQWp5MWRUSHZLVzlkeXNlazBq?=
 =?utf-8?B?R2pHR0phaDd6QkRHNlRKVmE4RGNWaWFpUmNkUStnNzArTFFhTlRzYjRCZFc4?=
 =?utf-8?B?UTVqQndzbldoeEE0TDBLVkphb1pHMGpGcUdQc0xmcXdMZWhTbzJXU2tIWEJn?=
 =?utf-8?B?Sml3Sm1DcVNaUGVOSVFrUTgzT1pkNXVsUEhoTnRXRXhuZHN0MG4yckNQREVi?=
 =?utf-8?B?Zm5PUjZKTW1PR3BwNll4UU82VTJpcjNxQlBwbXVwWm5WNzU0c0d2SW5SZDky?=
 =?utf-8?B?NzVnSGwrU2FSaE9WcGhzOVBzYVFIYjIrR0tXamY0cE1xMjRyRXYwSENtSHhj?=
 =?utf-8?B?TG5oMGFhYUFDcmNzYkpjWUZ0b1lGaWN4MTl0VFVKcnRGN2RRaExsWnBCL2dF?=
 =?utf-8?B?QzUxT05wQm8wcEJZTHo4ZEVhSHNyZjVvYTlMWVZ4c2NVSTQwbFJxdkRPajA3?=
 =?utf-8?B?QzF0WHlsUnFBc1Judk1tRkdhazkrai9SS1hSU2YwdmJuOWZBd0NMTlZabW5M?=
 =?utf-8?B?YkxxaGdUUU52ZHZOTWFYTFBMYXUxNW5lNHphMnU0dkduSUx0elpHMk9vWTcw?=
 =?utf-8?B?Vmg4VWFqWVVPUVFnU3lucWNuL0ViTGlWYW9nYWZJY2JTN2t6K01ZU1JpVkhr?=
 =?utf-8?B?L3h2MFFGMHJxWVIxNkN1VzJDcGpGOFRIL0s1bjFlcVJIejJPbUF3b0xpd25q?=
 =?utf-8?B?V2UxV2hQb0psWVQyZDlhY1lkYW1uQkg5M3d6akE3N0R2clBNOUNoRDlCSjc1?=
 =?utf-8?B?T0JaQzRPQ2pUZnUyOTVTQXhub1J6KzVpaHR2WEk3S3YrUzVmYlZRNzY5eFNr?=
 =?utf-8?B?cmpVUDROVzJjWUhVNkFUVm01NnBFRGF2SXhoeVo0OG00a1JKUWd2TklUQlQ2?=
 =?utf-8?B?QzdOWStSaWFuU1JZSy9RY2twQnphZGdmM0ZaNEpKK3c1VThjK2hoYllWbVJp?=
 =?utf-8?B?L3hiQnhGM01wS2c1MWZOSUtaR3B2dHVxbnZLZGxVVkVQQ3hueTVlb3E3ekFt?=
 =?utf-8?B?dVZYeFpPeVJub2lhU2ExUWZyaEF1Zkw5ZktHTkJ2SVBCSG9hN1JnbC9EeUI1?=
 =?utf-8?B?ck9oRnJ6Q2pXWHFCREJpU3FaLzNpNFFSRkE2Q1F4Q2VTTkhNeWQ3NnhwT09h?=
 =?utf-8?Q?rlfnks=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d763e168-3cd1-4c80-a4f2-08dbb4e869fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2023 06:04:10.6560
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KvgAQPrBmHSmHEvudcPPUWSldt/6+Ui412Wyo2uU1l1RUD1re30h0P/wlY8Fm3lIxdw9deGlLo6Bgi+Thfbu0ypVuwffmef7QLTFs0fVeZQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR04MB8707
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMTMuMDkuMjMgMTg6NTgsIERhdmlkIEhvd2VsbHMgd3JvdGU6DQo+IC0tLQ0KPiAgIGxpYi9r
dW5pdF9pb3ZfaXRlci5jIHwgMTgxICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysNCj4gICAxIGZpbGUgY2hhbmdlZCwgMTgxIGluc2VydGlvbnMoKykNCg0KSGkgRGF2
aWQsDQoNCiMxIHRoaXMgaXMgbWlzc2luZyBhIFNvQg0KIzIgbG9va3MgbGlrZSBhbGwgdGhlIEtV
TklUX0FTU0VSVF9OT1RfTlVMTCgpIG1hY3JvcyBhcmUgaW5kZW50ZWQgd3JvbmcNCiMzIGEgYml0
IG1vcmUgb2YgYSBjb21taXQgbWVzc2FnZSB3b3VsZCBiZSBuaWNlDQoNCkJ5dGUsDQoJSm9oYW5u
ZXMNCg0KDQo+IA0KPiBkaWZmIC0tZ2l0IGEvbGliL2t1bml0X2lvdl9pdGVyLmMgYi9saWIva3Vu
aXRfaW92X2l0ZXIuYw0KPiBpbmRleCA4NTliNjdjNGQ2OTcuLjQ3OGZlYTk1NmY1OCAxMDA2NDQN
Cj4gLS0tIGEvbGliL2t1bml0X2lvdl9pdGVyLmMNCj4gKysrIGIvbGliL2t1bml0X2lvdl9pdGVy
LmMNCj4gQEAgLTc1Niw2ICs3NTYsMTg0IEBAIHN0YXRpYyB2b2lkIF9faW5pdCBpb3Zfa3VuaXRf
ZXh0cmFjdF9wYWdlc194YXJyYXkoc3RydWN0IGt1bml0ICp0ZXN0KQ0KPiAgIAlLVU5JVF9TVUND
RUVEKCk7DQo+ICAgfQ0KPiAgIA0KPiArc3RhdGljIHZvaWQgaW92X2t1bml0X2ZyZWVfcGFnZSh2
b2lkICpkYXRhKQ0KPiArew0KPiArCV9fZnJlZV9wYWdlKGRhdGEpOw0KPiArfQ0KPiArDQo+ICtz
dGF0aWMgdm9pZCBfX2luaXQgaW92X2t1bml0X2JlbmNobWFya19wcmludF9zdGF0cyhzdHJ1Y3Qg
a3VuaXQgKnRlc3QsDQo+ICsJCQkJCQkgICB1bnNpZ25lZCBpbnQgKnNhbXBsZXMpDQo+ICt7DQo+
ICsJdW5zaWduZWQgbG9uZyB0b3RhbCA9IDA7DQo+ICsJaW50IGk7DQo+ICsNCj4gKwlmb3IgKGkg
PSAwOyBpIDwgMTY7IGkrKykgew0KPiArCQl0b3RhbCArPSBzYW1wbGVzW2ldOw0KPiArCQlrdW5p
dF9pbmZvKHRlc3QsICJydW4gJXg6ICV1IHVTXG4iLCBpLCBzYW1wbGVzW2ldKTsNCj4gKwl9DQo+
ICsNCj4gKwlrdW5pdF9pbmZvKHRlc3QsICJhdmcgJWx1IHVTXG4iLCB0b3RhbCAvIDE2KTsNCj4g
K30NCj4gKw0KPiArLyoNCj4gKyAqIFRpbWUgY29weWluZyAyNTZNaUIgdGhyb3VnaCBhbiBJVEVS
X0JWRUMuDQo+ICsgKi8NCj4gK3N0YXRpYyB2b2lkIF9faW5pdCBpb3Zfa3VuaXRfYmVuY2htYXJr
X2J2ZWMoc3RydWN0IGt1bml0ICp0ZXN0KQ0KPiArew0KPiArCXN0cnVjdCBpb3ZfaXRlciBpdGVy
Ow0KPiArCXN0cnVjdCBiaW9fdmVjICpidmVjOw0KPiArCXN0cnVjdCBwYWdlICpwYWdlLCAqKnBh
Z2VzOw0KPiArCXVuc2lnbmVkIGludCBzYW1wbGVzWzE2XTsNCj4gKwlrdGltZV90IGEsIGI7DQo+
ICsJc3NpemVfdCBjb3BpZWQ7DQo+ICsJc2l6ZV90IHNpemUgPSAyNTYgKiAxMDI0ICogMTAyNCwg
bnBhZ2VzID0gc2l6ZSAvIFBBR0VfU0laRTsNCj4gKwl2b2lkICpzY3JhdGNoOw0KPiArCWludCBp
Ow0KPiArDQo+ICsJLyogQWxsb2NhdGUgYSBwYWdlIGFuZCB0aWxlIGl0IHJlcGVhdGVkbHkgaW4g
dGhlIGJ1ZmZlci4gKi8NCj4gKwlwYWdlID0gYWxsb2NfcGFnZShHRlBfS0VSTkVMKTsNCj4gKyAg
ICAgICAgS1VOSVRfQVNTRVJUX05PVF9OVUxMKHRlc3QsIHBhZ2UpOw0KPiArCWt1bml0X2FkZF9h
Y3Rpb25fb3JfcmVzZXQodGVzdCwgaW92X2t1bml0X2ZyZWVfcGFnZSwgcGFnZSk7DQo+ICsNCj4g
KwlidmVjID0ga3VuaXRfa21hbGxvY19hcnJheSh0ZXN0LCBucGFnZXMsIHNpemVvZihidmVjWzBd
KSwgR0ZQX0tFUk5FTCk7DQo+ICsgICAgICAgIEtVTklUX0FTU0VSVF9OT1RfTlVMTCh0ZXN0LCBi
dmVjKTsNCj4gKwlmb3IgKGkgPSAwOyBpIDwgbnBhZ2VzOyBpKyspDQo+ICsJCWJ2ZWNfc2V0X3Bh
Z2UoJmJ2ZWNbaV0sIHBhZ2UsIFBBR0VfU0laRSwgMCk7DQo+ICsNCj4gKwkvKiBDcmVhdGUgYSBz
aW5nbGUgbGFyZ2UgYnVmZmVyIHRvIGNvcHkgdG8vZnJvbS4gKi8NCj4gKwlwYWdlcyA9IGt1bml0
X2ttYWxsb2NfYXJyYXkodGVzdCwgbnBhZ2VzLCBzaXplb2YocGFnZXNbMF0pLCBHRlBfS0VSTkVM
KTsNCj4gKyAgICAgICAgS1VOSVRfQVNTRVJUX05PVF9OVUxMKHRlc3QsIHBhZ2VzKTsNCj4gKwlm
b3IgKGkgPSAwOyBpIDwgbnBhZ2VzOyBpKyspDQo+ICsJCXBhZ2VzW2ldID0gcGFnZTsNCj4gKw0K
PiArCXNjcmF0Y2ggPSB2bWFwKHBhZ2VzLCBucGFnZXMsIFZNX01BUCB8IFZNX01BUF9QVVRfUEFH
RVMsIFBBR0VfS0VSTkVMKTsNCj4gKyAgICAgICAgS1VOSVRfQVNTRVJUX05PVF9OVUxMKHRlc3Qs
IHNjcmF0Y2gpOw0KPiArCWt1bml0X2FkZF9hY3Rpb25fb3JfcmVzZXQodGVzdCwgaW92X2t1bml0
X3VubWFwLCBzY3JhdGNoKTsNCj4gKw0KPiArCS8qIFBlcmZvcm0gYW5kIHRpbWUgYSBidW5jaCBv
ZiBjb3BpZXMuICovDQo+ICsJa3VuaXRfaW5mbyh0ZXN0LCAiQmVuY2htYXJraW5nIGNvcHlfdG9f
aXRlcigpIG92ZXIgQlZFQzpcbiIpOw0KPiArCWZvciAoaSA9IDA7IGkgPCAxNjsgaSsrKSB7DQo+
ICsJCWlvdl9pdGVyX2J2ZWMoJml0ZXIsIElURVJfREVTVCwgYnZlYywgbnBhZ2VzLCBzaXplKTsN
Cj4gKwkJYSA9IGt0aW1lX2dldF9yZWFsKCk7DQo+ICsJCWNvcGllZCA9IGNvcHlfdG9faXRlcihz
Y3JhdGNoLCBzaXplLCAmaXRlcik7DQo+ICsJCWIgPSBrdGltZV9nZXRfcmVhbCgpOw0KPiArCQlL
VU5JVF9FWFBFQ1RfRVEodGVzdCwgY29waWVkLCBzaXplKTsNCj4gKwkJc2FtcGxlc1tpXSA9IGt0
aW1lX3RvX3VzKGt0aW1lX3N1YihiLCBhKSk7DQo+ICsJfQ0KPiArDQo+ICsJaW92X2t1bml0X2Jl
bmNobWFya19wcmludF9zdGF0cyh0ZXN0LCBzYW1wbGVzKTsNCj4gKwlLVU5JVF9TVUNDRUVEKCk7
DQo+ICt9DQo+ICsNCj4gKy8qDQo+ICsgKiBUaW1lIGNvcHlpbmcgMjU2TWlCIHRocm91Z2ggYW4g
SVRFUl9CVkVDIGluIDI1NiBwYWdlIGNodW5rcy4NCj4gKyAqLw0KPiArc3RhdGljIHZvaWQgX19p
bml0IGlvdl9rdW5pdF9iZW5jaG1hcmtfYnZlY19zcGxpdChzdHJ1Y3Qga3VuaXQgKnRlc3QpDQo+
ICt7DQo+ICsJc3RydWN0IGlvdl9pdGVyIGl0ZXI7DQo+ICsJc3RydWN0IGJpb192ZWMgKmJ2ZWM7
DQo+ICsJc3RydWN0IHBhZ2UgKnBhZ2UsICoqcGFnZXM7DQo+ICsJdW5zaWduZWQgaW50IHNhbXBs
ZXNbMTZdOw0KPiArCWt0aW1lX3QgYSwgYjsNCj4gKwlzc2l6ZV90IGNvcGllZDsNCj4gKwlzaXpl
X3Qgc2l6ZSwgbnBhZ2VzID0gNjQ7DQo+ICsJdm9pZCAqc2NyYXRjaDsNCj4gKwlpbnQgaSwgajsN
Cj4gKw0KPiArCS8qIEFsbG9jYXRlIGEgcGFnZSBhbmQgdGlsZSBpdCByZXBlYXRlZGx5IGluIHRo
ZSBidWZmZXIuICovDQo+ICsJcGFnZSA9IGFsbG9jX3BhZ2UoR0ZQX0tFUk5FTCk7DQo+ICsgICAg
ICAgIEtVTklUX0FTU0VSVF9OT1RfTlVMTCh0ZXN0LCBwYWdlKTsNCj4gKwlrdW5pdF9hZGRfYWN0
aW9uX29yX3Jlc2V0KHRlc3QsIGlvdl9rdW5pdF9mcmVlX3BhZ2UsIHBhZ2UpOw0KPiArDQo+ICsJ
LyogQ3JlYXRlIGEgc2luZ2xlIGxhcmdlIGJ1ZmZlciB0byBjb3B5IHRvL2Zyb20uICovDQo+ICsJ
cGFnZXMgPSBrdW5pdF9rbWFsbG9jX2FycmF5KHRlc3QsIG5wYWdlcywgc2l6ZW9mKHBhZ2VzWzBd
KSwgR0ZQX0tFUk5FTCk7DQo+ICsgICAgICAgIEtVTklUX0FTU0VSVF9OT1RfTlVMTCh0ZXN0LCBw
YWdlcyk7DQo+ICsJZm9yIChpID0gMDsgaSA8IG5wYWdlczsgaSsrKQ0KPiArCQlwYWdlc1tpXSA9
IHBhZ2U7DQo+ICsNCj4gKwlzY3JhdGNoID0gdm1hcChwYWdlcywgbnBhZ2VzLCBWTV9NQVAgfCBW
TV9NQVBfUFVUX1BBR0VTLCBQQUdFX0tFUk5FTCk7DQo+ICsgICAgICAgIEtVTklUX0FTU0VSVF9O
T1RfTlVMTCh0ZXN0LCBzY3JhdGNoKTsNCj4gKwlrdW5pdF9hZGRfYWN0aW9uX29yX3Jlc2V0KHRl
c3QsIGlvdl9rdW5pdF91bm1hcCwgc2NyYXRjaCk7DQo+ICsNCj4gKwkvKiBQZXJmb3JtIGFuZCB0
aW1lIGEgYnVuY2ggb2YgY29waWVzLiAqLw0KPiArCWt1bml0X2luZm8odGVzdCwgIkJlbmNobWFy
a2luZyBjb3B5X3RvX2l0ZXIoKSBvdmVyIEJWRUM6XG4iKTsNCj4gKwlmb3IgKGkgPSAwOyBpIDwg
MTY7IGkrKykgew0KPiArCQlzaXplID0gMjU2ICogMTAyNCAqIDEwMjQ7DQo+ICsJCWEgPSBrdGlt
ZV9nZXRfcmVhbCgpOw0KPiArCQlkbyB7DQo+ICsJCQlzaXplX3QgcGFydCA9IG1pbihzaXplLCBu
cGFnZXMgKiBQQUdFX1NJWkUpOw0KPiArDQo+ICsJCQlidmVjID0ga3VuaXRfa21hbGxvY19hcnJh
eSh0ZXN0LCBucGFnZXMsIHNpemVvZihidmVjWzBdKSwgR0ZQX0tFUk5FTCk7DQo+ICsJCQlLVU5J
VF9BU1NFUlRfTk9UX05VTEwodGVzdCwgYnZlYyk7DQo+ICsJCQlmb3IgKGogPSAwOyBqIDwgbnBh
Z2VzOyBqKyspDQo+ICsJCQkJYnZlY19zZXRfcGFnZSgmYnZlY1tqXSwgcGFnZSwgUEFHRV9TSVpF
LCAwKTsNCj4gKw0KPiArCQkJaW92X2l0ZXJfYnZlYygmaXRlciwgSVRFUl9ERVNULCBidmVjLCBu
cGFnZXMsIHBhcnQpOw0KPiArCQkJY29waWVkID0gY29weV90b19pdGVyKHNjcmF0Y2gsIHBhcnQs
ICZpdGVyKTsNCj4gKwkJCUtVTklUX0VYUEVDVF9FUSh0ZXN0LCBjb3BpZWQsIHBhcnQpOw0KPiAr
CQkJc2l6ZSAtPSBwYXJ0Ow0KPiArCQl9IHdoaWxlIChzaXplID4gMCk7DQo+ICsJCWIgPSBrdGlt
ZV9nZXRfcmVhbCgpOw0KPiArCQlzYW1wbGVzW2ldID0ga3RpbWVfdG9fdXMoa3RpbWVfc3ViKGIs
IGEpKTsNCj4gKwl9DQo+ICsNCj4gKwlpb3Zfa3VuaXRfYmVuY2htYXJrX3ByaW50X3N0YXRzKHRl
c3QsIHNhbXBsZXMpOw0KPiArCUtVTklUX1NVQ0NFRUQoKTsNCj4gK30NCj4gKw0KPiArLyoNCj4g
KyAqIFRpbWUgY29weWluZyAyNTZNaUIgdGhyb3VnaCBhbiBJVEVSX1hBUlJBWS4NCj4gKyAqLw0K
PiArc3RhdGljIHZvaWQgX19pbml0IGlvdl9rdW5pdF9iZW5jaG1hcmtfeGFycmF5KHN0cnVjdCBr
dW5pdCAqdGVzdCkNCj4gK3sNCj4gKwlzdHJ1Y3QgaW92X2l0ZXIgaXRlcjsNCj4gKwlzdHJ1Y3Qg
eGFycmF5ICp4YXJyYXk7DQo+ICsJc3RydWN0IHBhZ2UgKnBhZ2UsICoqcGFnZXM7DQo+ICsJdW5z
aWduZWQgaW50IHNhbXBsZXNbMTZdOw0KPiArCWt0aW1lX3QgYSwgYjsNCj4gKwlzc2l6ZV90IGNv
cGllZDsNCj4gKwlzaXplX3Qgc2l6ZSA9IDI1NiAqIDEwMjQgKiAxMDI0LCBucGFnZXMgPSBzaXpl
IC8gUEFHRV9TSVpFOw0KPiArCXZvaWQgKnNjcmF0Y2g7DQo+ICsJaW50IGk7DQo+ICsNCj4gKwkv
KiBBbGxvY2F0ZSBhIHBhZ2UgYW5kIHRpbGUgaXQgcmVwZWF0ZWRseSBpbiB0aGUgYnVmZmVyLiAq
Lw0KPiArCXBhZ2UgPSBhbGxvY19wYWdlKEdGUF9LRVJORUwpOw0KPiArICAgICAgICBLVU5JVF9B
U1NFUlRfTk9UX05VTEwodGVzdCwgcGFnZSk7DQo+ICsJa3VuaXRfYWRkX2FjdGlvbl9vcl9yZXNl
dCh0ZXN0LCBpb3Zfa3VuaXRfZnJlZV9wYWdlLCBwYWdlKTsNCj4gKw0KPiArCXhhcnJheSA9IGlv
dl9rdW5pdF9jcmVhdGVfeGFycmF5KHRlc3QpOw0KPiArDQo+ICsJZm9yIChpID0gMDsgaSA8IG5w
YWdlczsgaSsrKSB7DQo+ICsJCXZvaWQgKnggPSB4YV9zdG9yZSh4YXJyYXksIGksIHBhZ2UsIEdG
UF9LRVJORUwpOw0KPiArDQo+ICsJCUtVTklUX0FTU0VSVF9GQUxTRSh0ZXN0LCB4YV9pc19lcnIo
eCkpOw0KPiArCX0NCj4gKw0KPiArCS8qIENyZWF0ZSBhIHNpbmdsZSBsYXJnZSBidWZmZXIgdG8g
Y29weSB0by9mcm9tLiAqLw0KPiArCXBhZ2VzID0ga3VuaXRfa21hbGxvY19hcnJheSh0ZXN0LCBu
cGFnZXMsIHNpemVvZihwYWdlc1swXSksIEdGUF9LRVJORUwpOw0KPiArICAgICAgICBLVU5JVF9B
U1NFUlRfTk9UX05VTEwodGVzdCwgcGFnZXMpOw0KPiArCWZvciAoaSA9IDA7IGkgPCBucGFnZXM7
IGkrKykNCj4gKwkJcGFnZXNbaV0gPSBwYWdlOw0KPiArDQo+ICsJc2NyYXRjaCA9IHZtYXAocGFn
ZXMsIG5wYWdlcywgVk1fTUFQIHwgVk1fTUFQX1BVVF9QQUdFUywgUEFHRV9LRVJORUwpOw0KPiAr
ICAgICAgICBLVU5JVF9BU1NFUlRfTk9UX05VTEwodGVzdCwgc2NyYXRjaCk7DQo+ICsJa3VuaXRf
YWRkX2FjdGlvbl9vcl9yZXNldCh0ZXN0LCBpb3Zfa3VuaXRfdW5tYXAsIHNjcmF0Y2gpOw0KPiAr
DQo+ICsJLyogUGVyZm9ybSBhbmQgdGltZSBhIGJ1bmNoIG9mIGNvcGllcy4gKi8NCj4gKwlrdW5p
dF9pbmZvKHRlc3QsICJCZW5jaG1hcmtpbmcgY29weV90b19pdGVyKCkgb3ZlciBYQVJSQVk6XG4i
KTsNCj4gKwlmb3IgKGkgPSAwOyBpIDwgMTY7IGkrKykgew0KPiArCQlpb3ZfaXRlcl94YXJyYXko
Jml0ZXIsIElURVJfREVTVCwgeGFycmF5LCAwLCBzaXplKTsNCj4gKwkJYSA9IGt0aW1lX2dldF9y
ZWFsKCk7DQo+ICsJCWNvcGllZCA9IGNvcHlfdG9faXRlcihzY3JhdGNoLCBzaXplLCAmaXRlcik7
DQo+ICsJCWIgPSBrdGltZV9nZXRfcmVhbCgpOw0KPiArCQlLVU5JVF9FWFBFQ1RfRVEodGVzdCwg
Y29waWVkLCBzaXplKTsNCj4gKwkJc2FtcGxlc1tpXSA9IGt0aW1lX3RvX3VzKGt0aW1lX3N1Yihi
LCBhKSk7DQo+ICsJfQ0KPiArDQo+ICsJaW92X2t1bml0X2JlbmNobWFya19wcmludF9zdGF0cyh0
ZXN0LCBzYW1wbGVzKTsNCj4gKwlLVU5JVF9TVUNDRUVEKCk7DQo+ICt9DQo+ICsNCj4gICBzdGF0
aWMgc3RydWN0IGt1bml0X2Nhc2UgX19yZWZkYXRhIGlvdl9rdW5pdF9jYXNlc1tdID0gew0KPiAg
IAlLVU5JVF9DQVNFKGlvdl9rdW5pdF9jb3B5X3RvX2t2ZWMpLA0KPiAgIAlLVU5JVF9DQVNFKGlv
dl9rdW5pdF9jb3B5X2Zyb21fa3ZlYyksDQo+IEBAIC03NjYsNiArOTQ0LDkgQEAgc3RhdGljIHN0
cnVjdCBrdW5pdF9jYXNlIF9fcmVmZGF0YSBpb3Zfa3VuaXRfY2FzZXNbXSA9IHsNCj4gICAJS1VO
SVRfQ0FTRShpb3Zfa3VuaXRfZXh0cmFjdF9wYWdlc19rdmVjKSwNCj4gICAJS1VOSVRfQ0FTRShp
b3Zfa3VuaXRfZXh0cmFjdF9wYWdlc19idmVjKSwNCj4gICAJS1VOSVRfQ0FTRShpb3Zfa3VuaXRf
ZXh0cmFjdF9wYWdlc194YXJyYXkpLA0KPiArCUtVTklUX0NBU0UoaW92X2t1bml0X2JlbmNobWFy
a19idmVjKSwNCj4gKwlLVU5JVF9DQVNFKGlvdl9rdW5pdF9iZW5jaG1hcmtfYnZlY19zcGxpdCks
DQo+ICsJS1VOSVRfQ0FTRShpb3Zfa3VuaXRfYmVuY2htYXJrX3hhcnJheSksDQo+ICAgCXt9DQo+
ICAgfTsNCj4gICANCj4gDQo+IA0KDQo=
