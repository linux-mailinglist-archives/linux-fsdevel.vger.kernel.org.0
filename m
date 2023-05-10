Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D68BC6FE11C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 May 2023 17:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237235AbjEJPF5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 May 2023 11:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236928AbjEJPFz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 May 2023 11:05:55 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF2AD198C;
        Wed, 10 May 2023 08:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1683731155; x=1715267155;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=0L6SGtele0eP5WaqfY0PagSVhmb4BKaffI871Aju9sM=;
  b=afy1gR/pkp7uPKaVsfawGp29YOZ5I1EdXsodzIr95nCmOwqbgE3FuKWO
   RJXyVCNdFWt3WRmG3YvIRt4Y4Yo0e51Ly83/GECMycaD8gX0k2yQPP8ju
   BP43nEvWAG48bH+dT25Tg4b82762E7ORuJJRQklQFDInRJDQ2+wErt4Ls
   9Z4xl8KXtFcanDyoKrg7rRYX9519kqkEaytPr+zN5kn+ZrSMKzFkuQtYv
   wY75qW+9d9V8xfXdyG7hZSsfD7xznw6Gg5Ufe7FB+K5f11Dm5yucaqhuC
   8oUx6c8eSrzj+vzpZpoFKkd7eZSubf0qqTfP1X7Jzz/QhCDJcnudXo5CC
   Q==;
X-IronPort-AV: E=Sophos;i="5.99,265,1677513600"; 
   d="scan'208";a="230256194"
Received: from mail-dm6nam11lp2172.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.172])
  by ob1.hgst.iphmx.com with ESMTP; 10 May 2023 23:05:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fk4uA7TyehpqCy3WfMptiw+iXU3M+ivDBCCojnICG4itWFfDgQyphYe42Pw2QTHzxzf3OHC1v/PN1SlXx64eaprfdefM+uUBstSpeTBbD2NnT76F3J0T/H3o/VfhorQ+Zi3be2/qhTNmZ5jN8AOvu0dTZmf2wl79swXyeFNrV72WEvd5UlxQUDITrpfoK2/P0MNBYGVsA2jTFreyUOgH+n2yPmUv2+YNGg7VypNL3QrcFPWyl6lCAE65MZBHnKRDusUMpWUBPgX6lc/lSRF5VLxkCdLMViL3vZFbGlEFKzk22av2uJhlMlx+auoRgeIcavHdJ4o/g+5JpUC4Coluaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0L6SGtele0eP5WaqfY0PagSVhmb4BKaffI871Aju9sM=;
 b=Z112qwGGWNucUMWFY3XmAK8R9PLGnQSO+c2yVrY/DBNU2iz854hzGSlNNQI8xLRccX3dfQI4riaorrgZaER/QvhKW3TcFZs4sA4lpfMqFIkMUmtW2rZ6Xzi6OkflMc13cLckPRLYbR+m4pENLv42/J6LPj3DaRZkCigSPM3mFPH1Gf9W2KAtiouCSO2/nTfMD+ouFCOLrOBCw0DSjic4NyeH+tH+WguP4vOrWXngUnOExAj6K9jrPq3ildvIKCYW6UNn8ndD9IecXb5fFznIQ+kcnZ5/SHf4qr8Nr6Re5ab5m7/3VTHku3QmXkJibg0pQ72SUjwbLBX9Hx/TrYTWsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0L6SGtele0eP5WaqfY0PagSVhmb4BKaffI871Aju9sM=;
 b=MdW8/gP1rU0P+lfmJ7NV/MF6gZ10xf5Jrsh1s2tiiAsJBlshPRovKYAD17Xc8WpOKlgiSOzvcNpwUyfJ7yfXDhrpny3K4pQk1p/hrLBVMvhnc/6T8jjAyiLJx+JycR74A+Oks18qEqlEVUXjvBeuFsaBGQxvpj5Z7ke86U6sdi4=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CO6PR04MB8330.namprd04.prod.outlook.com (2603:10b6:303:135::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Wed, 10 May
 2023 15:05:49 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f%9]) with mapi id 15.20.6363.033; Wed, 10 May 2023
 15:05:48 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Kent Overstreet <kent.overstreet@linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-bcachefs@vger.kernel.org" <linux-bcachefs@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
CC:     Kent Overstreet <kent.overstreet@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH 07/32] mm: Bring back vmalloc_exec
Thread-Topic: [PATCH 07/32] mm: Bring back vmalloc_exec
Thread-Index: AQHZg1Dnow18BqZgeU+7sDXHhzhdAA==
Date:   Wed, 10 May 2023 15:05:48 +0000
Message-ID: <3508afc0-6f03-a971-e716-999a7373951f@wdc.com>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
 <20230509165657.1735798-8-kent.overstreet@linux.dev>
In-Reply-To: <20230509165657.1735798-8-kent.overstreet@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CO6PR04MB8330:EE_
x-ms-office365-filtering-correlation-id: b4f44f9f-946c-43e0-e24d-08db516809e9
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j+8T4Ws2wGmVtDgSC+ggG/PCUi7VfrsGmJ5FWXjo5jvJfP6Ra5yH/9AcayZOXy+UF+mVhleC7tL+tIeJmjn6llrQDtlCClj3B8PEAcL1euTSUbPDeRJWdN/wl3rA+6m4aFBgpQ2DMQOaCvC1lwrxv2Mb3c507TKEoYo8RcwcuNejsJeV1S451OT1obeQBLmK6Oo18j5c5grNq4II/t6sKCQaKqR/AR0o/dg41PA1wGPRbR0j3h4DtGf80AcczD+XpAaoZTQexdG47ILczp68vBoCvLkjRQ89a6z3yxqj3LvbesIw1IEEyo0IV+dvOmKmj8U5Yg70uEqz/MOojSAo1sipmJcE2SiF/zzG5OFU0g2ikprkHeQe5IFP2okFQixinKatZjtAvI4Kk2VcBsVf/IVA7j4eeyaaEOd6OhyWdMnEe8bLgIO2xXoEEPO0RMdRz0JzyrromLRDmiAR3RsuXdVe6rgUXCLr8I8vldn2eKMOoBwjMEBCaRfmlPtX10R8oKEN3RZDfE8FE0gNKG8sGmWH2XfSO9xBogPWdJuKiIwcdDByeib5HMcrnyH6e04dZ/m8Lk5RexA3MAbpisbWY6dwOgU26ObXXKaduXUGPh17X1ct3PLFvYX80hTBqb8fYYqHi2KOo3FlvKZ5h9vzSizHre1np4y9hMafxq5knRnhZJMmsp30tu3bmvMd1UHo
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39860400002)(366004)(376002)(136003)(451199021)(6486002)(54906003)(478600001)(41300700001)(110136005)(186003)(53546011)(66446008)(8676002)(8936002)(7416002)(66476007)(4326008)(5660300002)(2906002)(64756008)(91956017)(66946007)(66556008)(6506007)(76116006)(4744005)(38070700005)(26005)(6512007)(316002)(31696002)(86362001)(71200400001)(82960400001)(38100700002)(36756003)(2616005)(122000001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c0Q3NnpYY2NuekwvL2daMkFVeU52MDI4RGIxWitDQzBLbGRiVDU0SGNzbjlD?=
 =?utf-8?B?K3dPVU1mclJkaHNiUzdRWWJVcTFYSVR6Z2I4TnNZTGx1Q1FnNEJremxCRXFJ?=
 =?utf-8?B?YzlEcHBrOG96MEoydjdIZE9LdVZnZXcvaVV4ZkF1amM0U01XdzE4YTN3bDZ2?=
 =?utf-8?B?M3h2V2VQVDVWNWtQcHlSUDFvWnFWWEp5ZmNEN09YY05oSlB6UXNoZXdqMFIx?=
 =?utf-8?B?cGVBTGdYWkw1TEQ2M3d1cFhybXBEaktxU3FPVHBzWDBXUjc2MW9aUUFnTVNp?=
 =?utf-8?B?ejVtQlhpTk1jTytNUHQzSXBTN05LeG4rdzY1QUdMTUNQRWVzRjdhbFl4RVZN?=
 =?utf-8?B?WFZJbmljUm9KL0N5eG9OeFlqaklKMHk0WjNXUGZLRkp1WnpPaStBcUg4aE9h?=
 =?utf-8?B?TzZ2ekpzWitQeE14NmpOeW5XMFoveU5uMnM5YndReElCUjhqZW4rWEFpYlRW?=
 =?utf-8?B?WVNtWGM4R1BHL2RDQ0kyWmh5MHZtUitpYzkzNTVUMU0ySUtaUW9XVkpkUXNR?=
 =?utf-8?B?WnB1d081bHVNZU40NEpSR1RoaVdoSk1mcmFOTDhFUWt3YlNpa3I0czE1MWhq?=
 =?utf-8?B?aW8rTlk2RnJrcXJHQzBzSUdrWFJqeDVGYTJkOUhkQnozQzk2RWwwd2JpVWVB?=
 =?utf-8?B?UnRLOTgxMmtuWGV3NTBIcU1GSCt0TWZ2NlhiU3pOdVUwVjNqcGNCQnovMWlv?=
 =?utf-8?B?NGZOczFmV0NidDJOTFU0cmoxVHU4MDFWc1gzZEpZbDBabnZuSFlXV0M0UDZt?=
 =?utf-8?B?UmljTEZhUzA4OThMbjIzQmNvdzdIU3dYQ2xrUUQyRFpvd21RUmpvYW0vT1VZ?=
 =?utf-8?B?aHZONVFDd3loUWh6QWRQeU85MkpEOUM0ajBHYTl1U1k5NzJQQW43M2FwVDB5?=
 =?utf-8?B?RTBxR1JnakhKb1NpU2xBVktXSlRmVTg5VURCdVAwWCtITG0ybnlWQUlTNVlz?=
 =?utf-8?B?anNBOTZYYm1CekRsaEhXUWdVZTgyWU5yTVBUc0lKVk9McllPbm1uSkFPVTBz?=
 =?utf-8?B?T2Zqb1RzUzhaSE42Sjh0clF4T0s0UkFKZEpPWGdQdmwxRmJ2dE12Q2QzYlEz?=
 =?utf-8?B?UUpBUHdpOGlna0lmWXlYalB0T0xkYzZwZllhc3N5QXlkRzg3azJvZ1VzRzJC?=
 =?utf-8?B?K21SL0lYUHdwS1h4eWNQanpTYmNzVjNScWxBdzh6bG9JV2o4R2hUeXJTeEI4?=
 =?utf-8?B?MlQ4NzY4SjR1ZklRRWdVemUwM3d0ZkI4ZnRKdWRrM2xIZnVYeDF0c0ttbGN4?=
 =?utf-8?B?bklwY0VUYmVPWkJJMkdYbGJuOVlIUWFSay9Ea3ZZOENhY3NFWCt3S21RTHZ2?=
 =?utf-8?B?RjRFRDlQcS9wQ3FKYW03MlYzc3QyMnpQRGlGdUs2b2lNVDI5bEtRWjdMajln?=
 =?utf-8?B?QjRPeVFudW0xeDdQMGRSWm1sQUtoMXZEV2M0M0xlMmFScklTV0s4NHA5cjY5?=
 =?utf-8?B?UEt3cE5KTjJQNHpKZ0EwaUxlazBSbThjcXdZVVc4OFRSVzhwOUtuYk9ydkIy?=
 =?utf-8?B?TGZhblgwM2xqYVNBUjMySk5xM2FQcDZTbVRMUUVOUCtlSUpLQktaZEtOK1lJ?=
 =?utf-8?B?YjY0YW1MK3hSN0xuTVRCVVljdmtJdytIYmI5ZndhZS84MStGb04yOGtIeW0x?=
 =?utf-8?B?cEZVaFB3RnJyeWc3cXRIbkRkUlNiWHVUbDE1U2dFTkx0ekRvOG5QVllSVVlq?=
 =?utf-8?B?YlJBZ3VqWTRteFdwcE8veSt4c2gvOFRFeGM5S1h0aXBJcm8wSC9OL2xJVVhX?=
 =?utf-8?B?R3hSOHIvMWZ5V0pPSUhjYU1XQzBvUWcwZWR0dUhZQWdCMTNDMzNhdUlvYkFB?=
 =?utf-8?B?VG9BQkxQdzhaL2RtVjhscVM5cnAwL1dQUCtRMVN2d3VOWWVmaDl6RWlrbkZO?=
 =?utf-8?B?RFJNejBRangrZkU1RHJydFZBZTVjWTUvR1FlN3pvSDZodmRYMWgwZTArZzR4?=
 =?utf-8?B?TFJSZVJkMmp3WHpYQ2J3cy9sSHNpU2d6YS9xOS9UaytMQS8wSllWZ21XTjRP?=
 =?utf-8?B?Tkc0ZnVsMCtlODcrT0VGdFFpNTBKcUZoSldnSnBSTkJBY1h1TjI0b1JTV3ZO?=
 =?utf-8?B?ZEhGQ3dUSzJpa252eXlDMFcxSVQ3c3pzUE9WdkZkTUVYR1RYcFZZQllRRXpo?=
 =?utf-8?B?T0NmV3QxbE4ycVVGSTZFZHVZREsrbHhxYTAycE9vY2p0TWkzVUcydXNWOWVv?=
 =?utf-8?B?Wnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A2B5419560149B409482F8AC7216CA0F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?TVMrNnB5ZTRUckxUckUxRXk0enphbCsrZUFqeElPaVNVZy84c0wrQ1oxeno0?=
 =?utf-8?B?ZzFlRHJYRG9LbVBlVVRTeElmbGxRRGZ1TG1aRjlaWVFlSWFpb0VUMHltczBC?=
 =?utf-8?B?MGxtNGloZVVTbmtlZmVJQjJHOVJPRTRDVUhzSGZ1UmJvTGFkV2JVcDNnNllS?=
 =?utf-8?B?VS9Wc0lMSmo0V1pOV0V1dDgwL0VQZmp3YzRZZEc2dmlDR0VBd1VJNjNkK2F4?=
 =?utf-8?B?OEwvVkFQUk5DOFVPcWZoVDVvYm53S2JYcjdmZFNrZ1ZaWVhnbGNnQ3dQd0Vw?=
 =?utf-8?B?TXBQaFZrQW9zODBmMU5GUERWeG1DV3ZoSkoyckM4R05EcWtiVEhNQy9wRU4z?=
 =?utf-8?B?Q0k5YlhFVlF6Uk12SEZKaUQxTnh5d3JpQXJYa3BtUmF0aUpoOXhEaXhmOFh2?=
 =?utf-8?B?SEFWWVpjZXVidXB2RDBHcFRiaGtjRVZqWUN4NVlPR3F0eW9GNm1GYitMUnpu?=
 =?utf-8?B?SGkvNWE1NytzRVhRZy82SXhqU1g0VS90YVVkdERCSDB6Y2l4akRTcTFPN2dP?=
 =?utf-8?B?RXRxb1FMbDBQOW5zVWVJODBYUU5vQTF0WkNWUy9xSks5QUQvU2JjV0J3TXhr?=
 =?utf-8?B?emR0NXRMV0ZPRVloZ25oaWFnNlRRV29CRmxGZ2xXT1FXR1E3cmtCOUMzVTFy?=
 =?utf-8?B?OHpzaThuZkNKZUhrbUE0cUdmZW9IVDFtZGZrWHExM2taZ1BDdlFRTVlCaVpv?=
 =?utf-8?B?cU1UOURNV3RQTEczZ2FreGVMRHVBTGxLeDlIdVFUbnNPcndFT212eGU2NVRv?=
 =?utf-8?B?bTlQRGhtNUpSUUJuREZDdTlnYStjTDdDV1hNTk9GOFpMdEJiNVhvdTI2ZEY0?=
 =?utf-8?B?eVZYdm1jMkN6Q0c3SzE2dkorQzlRdGY4ZGZ4Z29Da3Y0UGRwWTRjdUNneElp?=
 =?utf-8?B?bm8vc09TRS85bFlibjdJSWZodzhJdUVlaGhGMFVGNHJhYk1aVFY4ZGoranBa?=
 =?utf-8?B?a3BYZ0pRbFdPQlViM1A0TE9aSWZzeERyWnJaSDFjQ01uTTJUU3NKdUZjLzdj?=
 =?utf-8?B?NlExWFFLaVdLTkx5LythTitxaFVxMlp1MUJRS2V0LzdXZ29xUFBodmtYNGZ5?=
 =?utf-8?B?RjE0ckZ0Y0hQN2prVXJ2dEI5YkprNWR4VDlBTE9Ma0ZjU0tRWW9pd0xMOVNP?=
 =?utf-8?B?OFpkSndCa0NPRWNEM2lGNnFhTXMzUjNqTnhFOUNrMWxrR1pNVjVNN1pkSS9W?=
 =?utf-8?B?WU9FUnFZMmhCTU8yM3RTZStpc1BLODdCNktWL25ZbkQrODltTDVFYkNScmVh?=
 =?utf-8?B?dGRQT3NnaFZFUjlHMlA2dTU5Z3RZNFhYcmtpSzFmTEJSODIzNzVTV1BtRHNL?=
 =?utf-8?Q?34qG5r0W37Ihc=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4f44f9f-946c-43e0-e24d-08db516809e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2023 15:05:48.7513
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zfX6ohApJRudZcIsUO1Q7FxTFPLsTEW8Q7HlUagFcxdnCZkR+1SPakTdkr7Ie3FXAO/PAFcdd5JynZpMPjVe6wAkNGMdgYWa1jmjVF1yupo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB8330
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMDkuMDUuMjMgMTg6NTYsIEtlbnQgT3ZlcnN0cmVldCB3cm90ZToNCj4gKy8qKg0KPiArICog
dm1hbGxvY19leGVjIC0gYWxsb2NhdGUgdmlydHVhbGx5IGNvbnRpZ3VvdXMsIGV4ZWN1dGFibGUg
bWVtb3J5DQo+ICsgKiBAc2l6ZToJICBhbGxvY2F0aW9uIHNpemUNCj4gKyAqDQo+ICsgKiBLZXJu
ZWwtaW50ZXJuYWwgZnVuY3Rpb24gdG8gYWxsb2NhdGUgZW5vdWdoIHBhZ2VzIHRvIGNvdmVyIEBz
aXplDQo+ICsgKiB0aGUgcGFnZSBsZXZlbCBhbGxvY2F0b3IgYW5kIG1hcCB0aGVtIGludG8gY29u
dGlndW91cyBhbmQNCj4gKyAqIGV4ZWN1dGFibGUga2VybmVsIHZpcnR1YWwgc3BhY2UuDQo+ICsg
Kg0KPiArICogRm9yIHRpZ2h0IGNvbnRyb2wgb3ZlciBwYWdlIGxldmVsIGFsbG9jYXRvciBhbmQg
cHJvdGVjdGlvbiBmbGFncw0KPiArICogdXNlIF9fdm1hbGxvYygpIGluc3RlYWQuDQo+ICsgKg0K
PiArICogUmV0dXJuOiBwb2ludGVyIHRvIHRoZSBhbGxvY2F0ZWQgbWVtb3J5IG9yICVOVUxMIG9u
IGVycm9yDQo+ICsgKi8NCj4gK3ZvaWQgKnZtYWxsb2NfZXhlYyh1bnNpZ25lZCBsb25nIHNpemUs
IGdmcF90IGdmcF9tYXNrKQ0KPiArew0KPiArCXJldHVybiBfX3ZtYWxsb2Nfbm9kZV9yYW5nZShz
aXplLCAxLCBWTUFMTE9DX1NUQVJULCBWTUFMTE9DX0VORCwNCj4gKwkJCWdmcF9tYXNrLCBQQUdF
X0tFUk5FTF9FWEVDLCBWTV9GTFVTSF9SRVNFVF9QRVJNUywNCj4gKwkJCU5VTUFfTk9fTk9ERSwg
X19idWlsdGluX3JldHVybl9hZGRyZXNzKDApKTsNCj4gK30NCj4gK0VYUE9SVF9TWU1CT0xfR1BM
KHZtYWxsb2NfZXhlYyk7DQoNClVoIFcrWCBtZW1vcnkgcmVhZ2lvbnMuDQpUaGUgOTBzIGNhbGxl
ZCwgdGhleSB3YW50IHRoZWlyIHNoZWxsY29kZSBiYWNrLg0K
