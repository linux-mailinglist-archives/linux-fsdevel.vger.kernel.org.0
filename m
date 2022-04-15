Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01FF450247A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Apr 2022 07:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349890AbiDOFpO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Apr 2022 01:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349934AbiDOFpH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Apr 2022 01:45:07 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF88011A09;
        Thu, 14 Apr 2022 22:42:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iMyy/u7mrK6vyWy6HrqlEawCAF5259NZFthPsEWvcKIZM8b06Uu0sLrbKGRT8DlUuVi20WRyyLVGhjpMlaTE41rd2eMmWxkAr8jEUOCCcupGR/iRfFUgwxCeXTbBlaCa2QrgN5zCYOAwUnbOGEk9dxA9lQonM0rtHkWLgBHscFiQUHAtR9l7aru1wb0eQZOAGGmlSsxlS/VIle0FZWHdBj8oyuYlaprb4gJ3JIn2xHIyjFdThwtnt30razYljvVb4m1/Z1PMYoc89ZBMizkcPpzbfxvDw8kSqyfQcb1nqGaj/3Iikr886AT3NJD3gGjo4BJYzf59YI0hXCDP4sVTzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i63dxVhBes5m7cPwLoD+A13NfCaI28iV9y4PoA3bvMA=;
 b=eW7rRL2JvxzWokoCJRlXqj0mHNv/XQO/j91LPUJbPJ9QpPs4v09A9i0Wu4zbSN0eph4DP9QtLXiqHm1di1BjlcIFZzv4XVFYy8hU9betLx4shVOlEeYzUpl4rv9he2KuAJSaZlts29SJsDDbjkb6N5oirukovedY+3eNde40X1hRXew/lv5cWBncc1R23nmA5zZV4ALOhWHwQRBgNyuNkJNH6nuYrfmoUYdSw/78Qpy7UjTI3h3NAGXlDATxKAmDQ5jbYu4W220oLe/Gu7zuWGd/gAdwjdA0K3vlal24KNIEoSgv+zy5C/B1UCyHPWrwPizW/rSDg9uFurWSXPJDgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i63dxVhBes5m7cPwLoD+A13NfCaI28iV9y4PoA3bvMA=;
 b=rPgk33sgBEZSP/Ovm7jvsz640IYdyFvdM1fnM3lU6m7hGyj/mWMg6EjvUnHN7MbENCPEl6B+GzAIQaOFxp5xfiWrefupuWBvxHL+PgSXw1OCMSh0PcIokAm8WOCYnl1njdMmUi5oCY4Gw9qBkq6gSLZnrWSAlcI53nwvVVpbv4T/7VXZt8rnTjgH4EonEpnVATg3odZIT0zEG2nLh/hoHGpgFEUMCk69GbLgQ2mGc1pYX3UNAraZuE012TWuofQ/IJqZ3PGvHiqEQOaIeD/zc9Gn6iofz5djOWF9l2i2/bT4Jj9e+rMAdJs16xkW+gFk4KU4rptnTfDJHCOAzH/gzw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CY4PR12MB1815.namprd12.prod.outlook.com (2603:10b6:903:122::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Fri, 15 Apr
 2022 05:42:30 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::a90b:9df2:370c:e76b]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::a90b:9df2:370c:e76b%3]) with mapi id 15.20.5144.030; Fri, 15 Apr 2022
 05:42:30 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>,
        "nbd@other.debian.org" <nbd@other.debian.org>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-bcache@vger.kernel.org" <linux-bcache@vger.kernel.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "cluster-devel@redhat.com" <cluster-devel@redhat.com>,
        "jfs-discussion@lists.sourceforge.net" 
        <jfs-discussion@lists.sourceforge.net>,
        "linux-nilfs@vger.kernel.org" <linux-nilfs@vger.kernel.org>,
        "ntfs3@lists.linux.dev" <ntfs3@lists.linux.dev>,
        "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH 14/27] block: add a bdev_stable_writes helper
Thread-Topic: [PATCH 14/27] block: add a bdev_stable_writes helper
Thread-Index: AQHYUITf17GqiWYdIke9HM2RTAhEIqzwdicA
Date:   Fri, 15 Apr 2022 05:42:30 +0000
Message-ID: <3a257cff-628b-e03e-e539-fda51a9ebad9@nvidia.com>
References: <20220415045258.199825-1-hch@lst.de>
 <20220415045258.199825-15-hch@lst.de>
In-Reply-To: <20220415045258.199825-15-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 078d3f1e-b513-47a0-d329-08da1ea2bb8e
x-ms-traffictypediagnostic: CY4PR12MB1815:EE_
x-microsoft-antispam-prvs: <CY4PR12MB181508B1B3F0B522FE8C7925A3EE9@CY4PR12MB1815.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QIkcmQpRB+xKmlDfFYlHUkmX9U4k0s3PPCFk9L95hYvst+R+B6ueQ94YpjVXMCCC7mSfTlW22ek92Xo2SPueIiM/I2OFC89VWd3noQNYQ5GcU188lFc+DjRrw/NdCE+6lMZeDgxBUcbhevLIw/1hzBhGgWOurw/dCxsxbsO4ReBNB+AwMryEsD6970l/Jgwxs783gRGNFAKBreyDkSX2ujlxCYetaPCdNhdkCcJJffRGhyF+R2SRe/aFn9fsW2PdzFFVLUWg5Jx27S7j5La/9HIp1HWuMck0dSZbWM2n++AnATid/HWvso0tzZbJpO9BT+pvSoVANkloNwNW7ohvV3XN6pS9UzilfboTkxikSKsYTNIOLfh3n16E7pYaU8kjwjCxd3vK4quyu2Ljs1LR29xt52O0to+1CQONljUt/clIq+27re9SCQSIph5fD4/K+x1b/p6IWJzefT+hKnCX4EUfYQBAYR2SPJIweP7l36y5X3au05Y2opXiW+rPwvg/xMrQ2V+vL1BRjcjhM3CEJMTtx/6RcTcboxR70pjQ3yHnC/S6V448l+/pEi7YFTziJrbdkUQYMFYOdEF9slrPDNPM8EkDyeNCSmo3HRfL7WOVhiFXCKAptFtLF2fXtZ0HpmuoWgoD7S0+op0mdjVEgIoYMVYMnCP0ta+yoWKmr7VVmh7Qie4j85WHpSPFNQdAXx3/TaIRyu4E0mc/ncpiH75GCPcEy08soEmxOKQ5SFHzZDb0wawjxFNHjlDCZlMyphcZfntXeCOio/mnwViOQw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(7416002)(8936002)(2906002)(91956017)(7406005)(5660300002)(4326008)(66556008)(83380400001)(86362001)(31686004)(508600001)(4744005)(38070700005)(6512007)(2616005)(186003)(53546011)(6506007)(36756003)(66946007)(66476007)(54906003)(110136005)(71200400001)(76116006)(6486002)(38100700002)(64756008)(66446008)(122000001)(8676002)(31696002)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?enB3TjJodk1tZVRFdE4xcVFyb3czaEVxU3BQcmxCZGlZWUJNbTZGWEJldXVo?=
 =?utf-8?B?YUFCcjJ4bXZMTnRGRnY3dlloZDNpQlZNdzQ0QVgrbmd5RlZiM1ZDZG1tZ3Zv?=
 =?utf-8?B?Q08wSjVHbnp3RW9oa2xxUHUxVHdKN04rd0RHSWdYbjFpSDRtVi9zTk5VK2Fl?=
 =?utf-8?B?Vzh2T2V2RWZNTmJmVXE4TGdaWmhXeEIwMkx3NmtKbDlyVkxQZXZtN2pLY3FF?=
 =?utf-8?B?alduMVlMRG9lV2dLWThjR1o0aUQyTEM1a1lSZGI5VTErWGNBZDF3NkVsME4w?=
 =?utf-8?B?V2d0YkRDVEtBZHcxTVN5Qkxzcm1sS0xEYzRqQm5mNG9tN0xIck5sSGplT01V?=
 =?utf-8?B?WmVmVXp2ZDc4UktUQkY4SUlNSlRncTd2b2l2Z0lsTUVkRmxtYXVOalBYbHov?=
 =?utf-8?B?amR2VUZCZHBGZ3FFeVF6bFNXYWRvZlA3U0RhQmQvQ2YyeDVkaXBOLytFaXh5?=
 =?utf-8?B?TjdWMDg0TWt5ajdRS3FET2ZuN3VnWWhWYjZJNG8rTjBZYUtZUHBLeGEwemxU?=
 =?utf-8?B?MnBoUzcydm5PbzBIWXBUVVU1N2RtMGgvekE3WStzNzRSb3YxZXg5dXZLZWJJ?=
 =?utf-8?B?bXRZTmw1b09zNkVwVTJ1UEhCa1ZEcTBHbDhjTTdTTzZ1UFByQUVVSWIrS2wy?=
 =?utf-8?B?cC9iUjE4aXFkd3Q3WG0ydWtoZmtFaFBsSVdtcjhsMWhFNFJnRmJjMEUvN0Fv?=
 =?utf-8?B?RFM2MTU2ZjBXRWpKeDhOTE9mckxUZTBYeXhQRDMzOTN3QklZeXhIeUgxTUhh?=
 =?utf-8?B?MEkvc0VWTVY3MVprUTBheVRzUW4zbngycE1OaGRxNlBIOFdSaGhjOERYaGMr?=
 =?utf-8?B?a2xucWpJekZYbHVtTlpGQ1pOYzNwRGpjN1dpK3JpbEovMzY0MTkyb1k3cnAv?=
 =?utf-8?B?ejRwcDR3aHFMMk1OVE9iTEFCeFBYQjIrZ1cxZzN3NWwwQnFkaEFCRExZRWVD?=
 =?utf-8?B?bnNIZWF6VGpHMVFsWXJLS3NpV040dFBQZVowWnEzVWVKS0prMFpjeFpYMEYz?=
 =?utf-8?B?MThtaEdXV3JraHFCSmo4aERrNE53czMrZmsvVE55cHNsM1lwMGlLMWpUT3Uw?=
 =?utf-8?B?WGpyVWJ3S0I0RUc1bkhVcWNNWDRCNzNyNlI0QnhxMnl3RlBHMjNsN3pZSURy?=
 =?utf-8?B?MVdXbEFmL1BZK2xpVGdxR00xakVidTlJempoRFpwT0pGc1AxRktmVWR1UDFi?=
 =?utf-8?B?RnhyTkU3ZENGRERML3NxMi95NTZkNUN5WWJxalphK0JlZFdqUVNYS21pWGVW?=
 =?utf-8?B?eE50YlUvSzdPNnBNazZnLzNTK01OWVp5QzVPUWkzRDhBVHA3WERxQStqeGY5?=
 =?utf-8?B?L2JDK0d0cDdxMmZSMnJVVHNMbXlnTHd1Q2N3U1dsSkdBWkZveHR5ZjhmUFda?=
 =?utf-8?B?dStrZ0RVUDdZdGhSN2k4OC9lSTBjcXQzaG52L1BqeHUxTkVvQmFqa0F4Nlcv?=
 =?utf-8?B?S2hoT0JJMy9Wb3JyeFE2SzRwaFZCM01laURpWWVoeXZyaEE0c2ZvcCtNdyt2?=
 =?utf-8?B?UXJUNmxhdkpTYkZKQmE1dEZxYTF2NHhnNUQxRGJiSXhCY2o5QmxMdXFmazRC?=
 =?utf-8?B?c3NUSExLK2tUdFNGUlBhOUJtem9XVXJkV211bHJnMEhUYThidXdBQUVzYUZm?=
 =?utf-8?B?UXFUUk5HL3BZZlFOYWh4bWxMUC8xSXFKaDhVU2ZWRTVtU3lubXFIV21PejNM?=
 =?utf-8?B?RGVPMFFsWUwxcWVLZ3dLOXU4dFpVRDhOZnk3U2diSEpTSkZVVVBJajVZK052?=
 =?utf-8?B?K3dlcng0MFVLVE0yTm4yRU85dG92YTVHWFRzbTA1alQ3Zm01MUZWRU1HTStt?=
 =?utf-8?B?WkVVYkM2bjFJVVBET2lvUmRUc3VJUHpqT3l6aWZQSWhvR2Z5eHE1N1VvNUNn?=
 =?utf-8?B?Z1czMVB5eEIwUW10Wm5VZ3ZNMHIwUnpWL05QWWhEZzNQR1NvcTBBOUhYVXg3?=
 =?utf-8?B?c1d4eXkwWmw0WTM3YXEvVHhHVHhnWlU3RnZMejF4eWJvdzMvL01BS3B4Zy8x?=
 =?utf-8?B?NlA4UXZPN0VTVmpIVks5Sk44RU5iUlFEdTF0QUkwbkZSbWJhU3JWWnFwVUpG?=
 =?utf-8?B?UmQ3NlpCSVJ3cXIvL2JJWHZZeFhtOVFGdjg0MlhKZE1mOWl6T291N1BkbFJJ?=
 =?utf-8?B?a2paVVdmaVVpY2RyaDYvNHJEdG5PaURIR2FjK2VUN1dRZ3czWlBidDY4RXRh?=
 =?utf-8?B?MmFPMlZaM3ZzUDFWY0NOdnh6ZmlncjFVWjdvNlozd0JSbUZ2YVFaUEM2SHds?=
 =?utf-8?B?UTJpc1BPeDZPakVybTlYL1p6OXhBMXUyMGcyUXFzVzVtQzRoK3d2ZHMxOXRP?=
 =?utf-8?B?RjNYQ1NwREdDcjdVaVQ2T0JBZ254U0Q4UC9mRTFad3JwTCtiVkpEVllweDB4?=
 =?utf-8?Q?pYtC1AMYu8KuMRuhqkOqway9etFx0cADrGZMy?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BC25D9F96CBBE841BBAF019B54F927FD@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 078d3f1e-b513-47a0-d329-08da1ea2bb8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2022 05:42:30.5331
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CBLfUV4czhdmP5VBDMkNhv1sreSiKqiRtJSo6We3NVLb7+NWNzJ2UCP4PGdqXaU4w5GPhVgZkc2E0t9OkXiYIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1815
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gNC8xNC8yMiAyMTo1MiwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IEFkZCBhIGhlbHBl
ciB0byBjaGVjayB0aGUgc3RhYmxlIHdyaXRlcyBmbGFnIGJhc2VkIG9uIHRoZSBibG9ja19kZXZp
Y2UNCj4gaW5zdGVhZCBvZiBoYXZpbmcgdG8gcG9rZSBpbnRvIHRoZSBibG9jayBsYXllciBpbnRl
cm5hbCByZXF1ZXN0X3F1ZXVlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0b3BoIEhlbGx3
aWcgPGhjaEBsc3QuZGU+DQo+IFJldmlld2VkLWJ5OiBNYXJ0aW4gSy4gUGV0ZXJzZW4gPG1hcnRp
bi5wZXRlcnNlbkBvcmFjbGUuY29tPg0KPiAtLS0NCg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQt
Ynk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0KDQo=
