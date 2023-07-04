Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE6E9746C78
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jul 2023 10:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbjGDI4a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jul 2023 04:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbjGDI43 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jul 2023 04:56:29 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 854FE135;
        Tue,  4 Jul 2023 01:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1688460988; x=1719996988;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=mhI7PfwwDEfw8vR8XXmbEHRjkqS3HK+m8mLwEhmhN2eQWKRi7b/Ws9bW
   PrLTKpvdyJEBv7z1s5d3GeB2fApqLteApMfbfdoQD1GypwXic2GfpO91+
   kxPTKtOnGnEPhCvS3tZepKrNF4Z4PhVkDUP7kj+REqR8cQHGEAGYRXzdM
   1veIizDYwHqEWa8hq/oTx8M4pgWVNHoIN7KPDIpZJVTf0Bc5mHppG7fs2
   b2JlaAjGMD8sXuBLTaoLzNa2LF92UDgzRwQ88N6Mb4sed8scyVPIkUlmj
   u8DXQzMwVVSkuZljdc+DLZdjtSHyeushsineoCac8ZKjUD8+wGHUJspd/
   A==;
X-IronPort-AV: E=Sophos;i="6.01,180,1684771200"; 
   d="scan'208";a="236879577"
Received: from mail-dm6nam10lp2104.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.104])
  by ob1.hgst.iphmx.com with ESMTP; 04 Jul 2023 16:56:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DtHwuS/kgpMPyQyLdFz+ywhuoh505uKA/sRUBQ6n1y3r9n3Z/LQQdNc58cj/UZ21AYQOPzygyX0VeZupwpAX/zL4Geel2TPLv8104rYfzlAKiyi476mJvMTxaoreEEIvUh3TiXEHDgSWmUixwHZewEtan1d4iytkTU+jUCJf6Y7R0BOYVEFUoNpV9tET3JTtG6Be3kXtcE0UQ6hi9g2z+4erEwcel10rfa7GH+rfx8TjlJ8pWCyoQaQ26Fd1WaCSYqxZYvoUtmVxf/db7IgJthmzgVVT9Af4VysYSPT7bf7i7xI/0g3cTCoqKJO3DOMgfb3AoelOsr6BqdJo51sVcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=WYKYFIJt1LGm0o3CK1vivp3vqRS0rR8TP34iIHp6T2QHHqKAmK28YnuK/aZM6laZcpDRCLzHML37krJbglPhZiJZqhe5sR9b5mU6csl+2f3lzOY/FPrLnFLNCtUsa3Mcq75afQPSLZ54iF/uFEet6jGng5ZpLdE9SQ1A3QjthC1L1qEPGWMGxHO6IZftNXBdSWpLAMiaEMVeYhxRvuRL9c/KNwHqNDmnivaTrp00jPtKUhs1tAhnmHKltYrAJRFp4XSJjCBEdmpa+YXVe3gtUtGnni8k0rQXJpMVkXmI+AhvEFb4noDm9NmHxSG13a3JLdJj0K7SyaoCsgWUNIUqGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=xgppG07KBpiMpYYpDrs+iCyU6s2J9GbfyJMn3WKVucZ8u8HUuZjiqGjisSbPKrkqhUMLRbnCCIqpAZ6yD4aoV19QFEbSYq935DoNyo86yisc5SqjoE7o4o6HGcEThVptCRAFY2virNMNjnLKCfkiOpu4JzhkZRfPNd1dQyVNYBY=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BL0PR04MB6580.namprd04.prod.outlook.com (2603:10b6:208:1cd::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 08:56:25 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::23cf:dbe4:375c:9936]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::23cf:dbe4:375c:9936%6]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 08:56:25 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     Matthew Wilcox <willy@infradead.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 07/23] btrfs: remove the return value from
 submit_uncompressed_range
Thread-Topic: [PATCH 07/23] btrfs: remove the return value from
 submit_uncompressed_range
Thread-Index: AQHZqdYQRMcWTmSmeUCZpt4EgrDgrK+pVyUA
Date:   Tue, 4 Jul 2023 08:56:25 +0000
Message-ID: <63195510-46b6-37c1-852c-098a53bceb71@wdc.com>
References: <20230628153144.22834-1-hch@lst.de>
 <20230628153144.22834-8-hch@lst.de>
In-Reply-To: <20230628153144.22834-8-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BL0PR04MB6580:EE_
x-ms-office365-filtering-correlation-id: d4a3e8a3-2e0a-409e-a3f4-08db7c6c8c34
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SrWc5c4Cugg2Jh+yPRxk+QkKXwbxo6LRONWM042jWYPsCAWiXZ/Gpm2342655Y9W6mjw9PyC+DpxqAAZlFIjmekfoLK3NTxEVHMk48xRZ6fyS3W7bFCyTZiR+zMELfm2BragZt8ytLhLhWdHwixK0oi14oVHI9UXmA6zcyviQc95B8MIS6eXHxnTIaMQ62pixmlQHC6h3EKIKpGB3aKgVZ8fL3v7luXR6vxKJ0VVknjmHCTQPfPJA0jgzbkRFSskgik2BuYgBjHlz4yziYSB4WQYifqI3/B+xd1pqU/uW6GxJScqIm48vLgJSIW6BBa6R411sig6Jurbwccua496/88IFG8sg5D/VyYtHzuUdecbW6ULPdWPGrWQy9btIJgZI/I2xiTbOf8cIMW16FYHxCF6BTOIz2aVziFyuq8uhj7J6415eODB9V3572BQqzaqv2V0lhm7Wn6gCdP1RMZpJxU5Jr9SjoSOZbGNkIdc0h80tCIh+X3rjtmv+RgpBCsTZH7zL1aU61cuXlXzUfQM01nzZ2STHJClmtaPhyLLAxXj+rL9dbL6DnONYa7u+EYBnGEAB3j2LkLjyOsH3bl13bRKuFyDrxybXd8kYs12gJI9hkzSYL4SdGuTF7SDLt/tpwqIUoQ7GArKbX1gCRFemsDFkMfvjKzqC7cL+8iLkM8rsRGGEXltS2vRIG2Mxj/A
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(366004)(39860400002)(396003)(376002)(451199021)(66446008)(64756008)(66476007)(316002)(66556008)(110136005)(8676002)(41300700001)(19618925003)(76116006)(54906003)(91956017)(4326008)(82960400001)(8936002)(66946007)(38100700002)(122000001)(38070700005)(6506007)(478600001)(31686004)(5660300002)(6512007)(186003)(6486002)(71200400001)(558084003)(31696002)(4270600006)(86362001)(36756003)(2616005)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S3JOYkJXdW45NUh4U0ZTdXpNQ2Zpa0k4enJickczNXVNVmFveHR2dXFvdW5G?=
 =?utf-8?B?Y0RmUDdvWmU0ZlVVeDZEZ3o5MGdBYkFoSEFlZkFHejBKRFpPNEkrbDFDYkZn?=
 =?utf-8?B?VzljUU10a3kwajlwanlweENscUkwTUU5alBqQTNiblVnY2JDT2VkS0ZvWS9u?=
 =?utf-8?B?UXJJRjV0NGRuMyttdmhOWkN1VTBtVzhJdnBmcDZJeTNOMEFlUTFNUFA2N01k?=
 =?utf-8?B?Q0t1MXZ5aXZHNEtFemRXTEhFWmxnV2k5OWpVZUpCaTJlNVJnWlJyaDArM3Bk?=
 =?utf-8?B?MjRNTjY2UkVUdzhMdTlxcS82UnVVSmRveFdvNXUwM2NqZHVOeGF5NWRWMldO?=
 =?utf-8?B?elhQYk4wV0lONlM4SGN6bmdROURTT3FCeXNWc0lLK3hldi9zYzBGd0VrNXRl?=
 =?utf-8?B?ODJlT3dnekM0ZjM3TG9hZTQ2SnNxVlZXOS9wcyt5U0Y1SGlSOFBZNUdFMVJB?=
 =?utf-8?B?UnVBSHgyUCsvdkJjbUNLVHpDaHd0YU5ERENneUwySmo4d0FQeC8wZUxLRDdt?=
 =?utf-8?B?MVlJeWs2OCtVbkxXREplSzVJZnJzU3hUSkhraG1jeXNrY1daKzM4Y1BBZXdC?=
 =?utf-8?B?WGZEeDVmNks1MCtpTndheWxDdVFEOHhvQ0RLdWdveWhoc0MyNXZrOENkNkhk?=
 =?utf-8?B?WHRrRitIKzIzWDZ0NFFCa3BhKzBXTzNPcTVxK1FhOXZ4NzNHbnRkT0RQWTlo?=
 =?utf-8?B?Yml1N0RvOWh1d3gzWk15aTh2RXM3S0RCcWxyY2UrbWZKSXFyV2VudDZKR29m?=
 =?utf-8?B?Z2VWY0xCSmVtWVYvb1V2T0ZjWXM2R05QdUZBK3cyd1o0K3F4SEwzVUxPMURF?=
 =?utf-8?B?UlhNQkN6SVRHalZRTG8vUU1vb1RyVXlJM2FlRll3VGRodlMvZGdzOUFOdGc4?=
 =?utf-8?B?SkJoVUdqZUx3dThST2pQYng1bEcyWmFPb1VoQnlNQ3JnUjcrS1h6R0lNUEZC?=
 =?utf-8?B?N3VmTHRRcmdweC93ZTdRSkpESVgrdUxhN00wYXYxcjlaUnJEdG9MWXcvQnFM?=
 =?utf-8?B?SUU1d0ZGdlc1dnRIcGNPVUFob3ZOelBOa3piNEJoVDliNGhlU3BuMHBCditu?=
 =?utf-8?B?a2JIWFZ5RnU1NHVDVzBsU1lWR0FiZm9vdkZPVzhRMGNFNHIzeGd2NlBxbVY2?=
 =?utf-8?B?R1pndVBiNERUQXBFQ2NkVVM4SC9NQ1l3OUwwL3p6UnJsNXBONjJOREFqMjFS?=
 =?utf-8?B?Z1MxbjV3OTNMRXc5RDJ0ZVZLYWp4VTN4RjVhMkJqbU5ZRGFlMHFxYklsT0xj?=
 =?utf-8?B?WG05NEpYcGZWWUVoRjIrdUF4RFAyQ1IvMVpXRm90S2dqK1AwVkxSeXN0ZURE?=
 =?utf-8?B?UWNhNmxTYXNMMm53OEc3cjhTSkJlUWZkdzBjTDdGNzJsME1mTE9QV2p2ckg2?=
 =?utf-8?B?OGlwc014ZDN0aVB6emFJazQyS1BWWkxpUjh6SEFGMjNNNHlTUDlrUWtQd0ww?=
 =?utf-8?B?MG5HMlBDVkgzSkp2V0RXS003QmE2UHRvdDc5cjNDUHlqYnJNbHROQmVjbFlY?=
 =?utf-8?B?djdoT0dJSTMwRlkySDJKdFJuR2xvK2ZYOVFyWVc5c2VHNHE4Y0ZYTnIwYTBC?=
 =?utf-8?B?eThLUStwL0VUQUkrdkR4WkZRaW00bGRZUjhwZEhybGVHenNYOVFmTFhZS2pC?=
 =?utf-8?B?bFl6S0RWSnJhU1FSclNuSHdYNzRTanNHVThQZFVnQ05pcjdvSEdpQm9WS1pr?=
 =?utf-8?B?Y21ySmV6N3hKdElwY3NZRlQxeHhVQnFSSnBScG41bXdvSzM4SlNOZHZTT1Vy?=
 =?utf-8?B?YVcxTVZZTENjeHFtVkV5L1JZRzJ5bmNWY3c5V1pGVTc3dk4vVEtNbS9DSTV0?=
 =?utf-8?B?NDdsS2d5a2RMaGNRMnVMMDJEc1ViSTliRnhVSFJWb3FwS2VrMC8rTWJHTTJq?=
 =?utf-8?B?dVRoWUJDQXRxbm5odDdJZm9yQTVmN0x1SGFJUlRtZXJ1N2FocjkvamJhVWtx?=
 =?utf-8?B?Q2M0Umsrd3RWY3dJSEY3VUZBQklpblJxdjJIZGJudHdza0t1R1VrRUJUdHJ3?=
 =?utf-8?B?dHYzVFBrSytXRFBjaFlUaEoxMEkyc2dKMjJrZjZnQ3lCeEJoY2Nidngydjk4?=
 =?utf-8?B?S2tJSERSbzFJYXZGTEVFYjM0eHN6cUVRZUxmTGp2dmlHS0FKN1MxVlFTNGlk?=
 =?utf-8?B?T1lLeGs4aHltWERDaE1LQVVzLzU2Y3pVSmtYLy9RRmxWcFlDZzRpSW9hS0gy?=
 =?utf-8?B?UE9ZTGFkVEsxdWYrckFueENOajdPVUNGWVNMaGdYQ2ZTUENiVm9iRDM0TXFV?=
 =?utf-8?B?N3lpMDIvMUdBaGRTQUxkbWxVRWJRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BB7301C25132C2459DB2EFC4EAE4604D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: yMj0u9zGAC14ShwLxb4dEicVLTumVaNv8Uih7l26iCEsi2u9HRDQTLnypAIx7QOkMb1/KJfLDJvMpx9Gop7P1QgIPOvBXPZV+RiyzDwVbwX8Z+8NIgWIA6m6S+m9Emct7PDGEP8CInVsSq261+n0bTI35dOyAj9YzgflgUVH6d/BZPYJKQYRNhGGoVH4ncvuQ5sd8+x+MZX3pbqPpmQCax41Ilu/txYKudH+Hzym6CrmibTeUHLGsTKfrq9e/+dMUdHQRld2RjKjNRVYsms/xO/RJH26vkF7bkMPtf/MLfpWT221Z6v9FHE9+nXjSPMiGJrS+Lb3zHHXagjvJh+jgwXmguTmWk8ia8rDAD8z5tMezdc8cZxw67fEUjW0brBg5e0UKRxtwp8enXrdybguFppNlN30fG9caJyA899P4YQSsJrtG8w9uCHq/64mjJo9bH7ZmFSUTnomD9BuBpROk0H6XXMWV5ZSrQC5NjuJWygydXRLc/PFpTuuGXXAnUi9oItLzWQYNT2i85zwHQwDzCWoHExuZC4wHiOklZGSnMn+gOWzn9tJvB8qL/EDfqg8wh8IBodCwUJyna7D17i4WdoWCPPxlFhZhEnxIMkzGIjyhOis1lstKnjAdh6mrxxpsMgreAHa/BawP8mjJqyPARnziU2ZOiMdjak5nIfd7mHSYClxIh0EKUmVn1nToVJKgsa3iOaqja2CPF4HvbZjHZjjawLr4Uu3c5VWHH1hsxOzVaIIvoVyFOAV8hSLoeFs0fUNs+Yw4rT7CTJnLXzx9uNN9aT37iyRylGhhtp3nGkpFU/EKHKUAMfAq5dCXMBAnKZGFys2zJMoLfB6F2RnAg3Igbu1sHbdv2g+YPPGTgJfRDKcRNc3X3yj2QNbu052IJip70Khn11SEtdmpH8hZDYvrluBVSSvv514eDexoUs=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4a3e8a3-2e0a-409e-a3f4-08db7c6c8c34
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2023 08:56:25.3531
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fz4jNwUXdEW4tsEXMo4YSQu0/mM9WvuMHKTgU4xSy6j9r0ZeCR8wYQX5SUm7evmsW3kZgXMwoTROiBkGp0LzbIYYskIZx+1V5qKcGkOKkQ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB6580
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
