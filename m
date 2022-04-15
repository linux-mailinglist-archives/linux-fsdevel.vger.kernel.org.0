Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC93B502426
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Apr 2022 07:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349199AbiDOFmH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Apr 2022 01:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344930AbiDOFmE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Apr 2022 01:42:04 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF476DF13;
        Thu, 14 Apr 2022 22:39:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P82s2ORVbDIQbJaWJiObFL0CLo5ewQNxQl1cKjf93adA9YrQCXeils/zai2grgqHWT6T4GP1C0C1w6uzbKAwLGkxkBa48zLUIKXwS64bXWeF+Bv5aNX9ZwWPk+nWa15qTZMiREtkCXAiggauz7226Mvj/iMf+0k4Rz/ULKgpoQAhBBK7m7Lxo3g1sG17olHSQAVs+3ITQ32tq2yQupl7SMuvt8CDRCLfc0NMIQNQXgZieAro6uc2prjCToQjh57Fc6LRQJIEd01ssrODPmJe4Pj4aPH+uUzhFQ/1Id5DqV+2LOcnIkyV/JlLlrsJIoOtlRaNRiUk0uQNF6ZVYah2xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=omIGCLGdXguYoUP6MBg7rPuCF4y33QrfLBFAULbl9Lk=;
 b=oUb6eg9qq66thkFW2dsafu0xpu758ry7qtaFkyqFeh/a3kpd4XM5WYvxrkA7nynDkjQzFxwQMVDhc4zui4JpRTt0zltnLKP9Er6Nrbd0Y0zh2kyBctQeNWKzIkOl7pYuNS86OBxcMiPuAUuIEM4Q3gZ+Mhy7xJtDFKCAI5qKs/fJybBJYqBr3kO2H0reHrwxVx0lck7ITFiO23a3c9LdM+dE6315lGqYRZ4E/PGA2Wkr5MpoPDfmcciTEjQPKgIUpiBxpPP/QXDkXYyKP48k8EJGMsuFUBKSx48J2PXBKNkGdDiNanYaHBZuTTam+c5GVtakTGG3uh32n1YjkH6I3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=omIGCLGdXguYoUP6MBg7rPuCF4y33QrfLBFAULbl9Lk=;
 b=WKHIMc22M8cT1F4TOOdGS5jyRprS6YflieD57kJ9VHosgbK2qXi00dqf1n91wOkO7ioZIoaivqfw2E8t2/tyTEF80oWdFDeVot1F/XsxETSyu/JHk8xM6A0Y0XwpTrsf4O49SF9PbJj8oBkC81zk8KAT7ExVsBJV0OJ8x/aLpj/ihQJjIbVXwFkEQ6+f5qx9tlug0RP1HacUA9FoicsZ1wpcWsWsyDNLApdRT/u2WzVzb3oootNWEegrnufnMNAdwghM737ozJ+YrgKft4Jq+BeeiXX6JKM08kFx3qx24exPuw2WdHEFDi9aqAQqG2xTjKa2hWVsPiJe2YQ3F4WmSw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CY4PR12MB1815.namprd12.prod.outlook.com (2603:10b6:903:122::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Fri, 15 Apr
 2022 05:39:32 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::a90b:9df2:370c:e76b]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::a90b:9df2:370c:e76b%3]) with mapi id 15.20.5144.030; Fri, 15 Apr 2022
 05:39:32 +0000
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
Subject: Re: [PATCH 03/27] target: fix discard alignment on partitions
Thread-Topic: [PATCH 03/27] target: fix discard alignment on partitions
Thread-Index: AQHYUITFeHwvXEjzw06+32xoV+0XX6zwdVMA
Date:   Fri, 15 Apr 2022 05:39:32 +0000
Message-ID: <883810d2-c170-388d-a031-63a9792fef5e@nvidia.com>
References: <20220415045258.199825-1-hch@lst.de>
 <20220415045258.199825-4-hch@lst.de>
In-Reply-To: <20220415045258.199825-4-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f75ff33f-773e-4acc-6d5a-08da1ea25175
x-ms-traffictypediagnostic: CY4PR12MB1815:EE_
x-microsoft-antispam-prvs: <CY4PR12MB1815B6BBB70B3A16BD279E14A3EE9@CY4PR12MB1815.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ct2OLeRIuik4P+2DUeO5AU8gZqPN6uyQIUnOB8Te+jtyDQNy6aUS+2wsUCMu8u05rWrtf0DIc95cYzd/uLaKTLCrJxxQtZnGGKhUTdcGX6GSWCuCwxkxGsNEG+qJSr9MwUJ7XV9Zvf4FJqe7DdIfzabcBJWl0widLMYk4wFdipWIDEgBVwlNKStVB4Pxswixw3xwANpWRJg7bFt0bQFSjiUuJkSR7z0bjIDhBvb4MU32HFtiyMZF6OWyg8DId41GzQeNxLyflykrZEg7zoRuIKYYiICmpgkAzJFBYYgV5mxIh0ODt8HLe8voQYI34dMRJ2q1zzDO9N6AvHzhbTWTMdsKs4T3CR07noro0Q+qb1WlHpYDdG9DvL2DCoCaarkL1zCHAUJkxEAyMDkzxdV7YkDlSMmau8i/g2y9w9JUbyO4YMAn8IbGR+TdxlqOSApiqh5rCevCWXCyj8q6unx+vib0nG0MK7JxHb7cag3lx4NrOlh++otAdbNAgAhRpzSgd6zLuYF5yoCgnE5OXtwW2xmmSbbIl4IfBfZxZ62Uz72R7UeZkrvDAbKwM+q8p0QzWNVE7+Tj5+OAiwUQj9ZN21aoKS/qM0isH1HffCwIA7CF4XxbqGl9FtgJ3gBe0gt6S6dX/NceavBgo1VeL9RfL1LcflQn3Q3aQvl4LqXD+sV+VQ99i4CuOr/ZuVcFtZnN8LvB0jGsL2I6mgWwy/cIGsBz+W3FIUOiMubueCem4c0OQc3RUQ5rHinqZ5V6IZeWEMz+VO6hBed+QWX+vJJ+Xw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(7416002)(8936002)(2906002)(91956017)(7406005)(5660300002)(4326008)(66556008)(83380400001)(86362001)(31686004)(508600001)(4744005)(38070700005)(6512007)(2616005)(186003)(53546011)(6506007)(36756003)(66946007)(66476007)(54906003)(110136005)(71200400001)(76116006)(6486002)(38100700002)(64756008)(66446008)(122000001)(8676002)(31696002)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c0tlN1NsN3ExRHNGOTQ4NWpMd08vcEpCWVpOcnFEZTR0TFJXY29qR1V0a2JY?=
 =?utf-8?B?WG5DZWtKRC84VCtLd2xrUnIycjlveWFGbTNuRGY0Tjhqd0Nxc0JrVFZNRGpB?=
 =?utf-8?B?ZnplU09JdGt0elc4dUlocWNGQnZqZGJnVEljUlN2SjZDL0tvMjRDdGJ5V05i?=
 =?utf-8?B?MmVNdHRCZWRNVEduYmxqREl2Y29zdTg0d2NlYW5NQU9ZemYwRDJWMVBwY0xQ?=
 =?utf-8?B?Tk5lUXdJd2dCVlBZczlVNWY2S2o0cVB3ZEdBbDhzeFA2a3lrR1czWHEyUGZD?=
 =?utf-8?B?blBCN0N0QjFpQVlyOGNuNVhFMmh1OXROOUhNTHNGRmE0bDFUeUdxZUJNRWJB?=
 =?utf-8?B?ajdyUHN0aGNuVHlCdTE1cEZhVmVjam1KbGlLbnZwaW5HWGlySUVnY283cHhw?=
 =?utf-8?B?VUNTclhzYTVBNVRpeFNRNWI4RnFUYW1HM21IZCt1anJTTVRoR2xpZHo3TXBW?=
 =?utf-8?B?cWN0YjgwcjZTMGlnSFJlbEowZUNITEhGN3NNV2YyRUh1OHFQbUZ4N2hhcnYy?=
 =?utf-8?B?SDZBaUx2MWdwZ0kzME12bi9hczJKUkpobDhJNC9WbnJKelhRbytKYWNpQW0v?=
 =?utf-8?B?Q2hJQ1dSdnVnT1lEOGFHd0FGSE5RQ2UyRFErcEk3WHJTanlRZWRtUDhVcE95?=
 =?utf-8?B?QzRwV1VLYkl4ZEpYSExkTmRla0gzb3UwK1RsbEtpNVFLdDJPNlVxNXF0K1VS?=
 =?utf-8?B?d2o5d1FxOTh2M05JY3ZyQ0ExQU52LzVLVlROcG4xUUtJWkVQL2cyaWtvekcx?=
 =?utf-8?B?aCtpNy8zZnBvcnpyR1NMSUZyUEJzNVBoeGtydWpnNCtzWUgvTnZQSjdQK1lL?=
 =?utf-8?B?bGtzWHBoYm5SM0pmQ3RJY1JDbmkrTElnZXFOWVNRVmlEOTR2N2FmTFBydVJO?=
 =?utf-8?B?eGY0T1l5Vk9sRU9wcWI0ZDEralBTOUs2RkpXTlhmOUluWXJmVnVJaGxuV3pm?=
 =?utf-8?B?dkh0bElzTTBvc290WGp6WXFxdDZic0Y1N3c3ckQ2Rm10bUlwY1dNMUxnQmNh?=
 =?utf-8?B?bXozSVlGTXkrb1AybTN5aGwxU0hWNUNGd3B4V05LcjcrMmlHNFN1NTRkRU9h?=
 =?utf-8?B?eDR4aFppVVVqVXk0cGdDNVJvUjh3Qjc3OXJIeUpHL2lNWWtURVpUWEpkN1Ni?=
 =?utf-8?B?bTVmWVBkWm0xamF5L0I1U3l4NkJqZUN4eE1zUWk2YlN5QmZwNklHR1diSHE0?=
 =?utf-8?B?TE5yZTVibENkcFdNeE8vZlgyS0NrWlY0WnVsNDBTMEZrWHdpY1NaUFpBby9E?=
 =?utf-8?B?UEJicGxvQm5uMWROTlZ6dWlLaDkzTUp1L0p6ZWUyOTZnT1REUkVxZyswK0xw?=
 =?utf-8?B?cU5UREIvSkxhQUtyZW1FT2pTaU5iWEhoamRscUE0Slg4NzNJQzlGUVAyYWVn?=
 =?utf-8?B?V1NOZHNUOVJFVTRRQTlNcDdGYVljY01mcStrV3lJMCtPWkVqNC92dzIya0tQ?=
 =?utf-8?B?eG8vamViOWdrRkF3eU5kVFViR3FZT1F5azdnZnBJUk1tUWp4QlF4NDBPN3Z2?=
 =?utf-8?B?ZDNXdlEzN1djbDErUlF3YnlCZWdoVjJaMVRRWi9LRFY1bzN5dE5mZjBjaHZo?=
 =?utf-8?B?M3lZakZkdk1DUk5lUmhOYUp0aEJ1WUZReVViY2kxaStQOVhFaWpIZFRGQjd1?=
 =?utf-8?B?Qm9SVklaYXM3QVNNUlVIZHVIVVBpUnpXaUxwdVdHL20xYUdOdkxYSzd1K3FW?=
 =?utf-8?B?Qi9SL0lTd3NXUldmOXkvNllsejgwbFJWMkNpVUQ0WDdCYm02ZDhOMjlTWG9R?=
 =?utf-8?B?ODJPa2d2S1d3L1RIMkQzaTlkd1R0VnA0NzhtUWNWYW5NTll2ZThYbDZ0U2Jz?=
 =?utf-8?B?b3o0MllMNDkxaVN2NTVYNnloRUl1V1NqV3YyNGdpdzRWdGhNMzdFZWNkbGlH?=
 =?utf-8?B?eEJBcU9USU9jV1cyd29DZnYzLy9sZ2Vham5aRWRnWVF0S096Nmg0UmlHVW1y?=
 =?utf-8?B?ckozbFFpWm8zSUVzR3RBRGl5S0hMbEsvcFRVNEdnVEhiSzB6RnpDYUFrVVBO?=
 =?utf-8?B?dlY0bkNrRWZYVElwS3JHZ0ZqK3ZjUThiUmtpQXBHamwzajBCb2FRZDBCWWxo?=
 =?utf-8?B?R1BrR29Ua3FDZmQvb3c0cmwyOWIwVFBVVW9VSTl4RzdDUUNWOGpiSWYvMHR6?=
 =?utf-8?B?SGxGdStidzNBK2l2WE5meldvK0ZtTFJxN00xeU1OeUgzM1gxY00wdmpxb2Zm?=
 =?utf-8?B?cWJFbGlkZ3dOZlp3QXpadGFKSkRkc2I4NTlwMXBYRDF4RWtoS0NNZVFUZi9W?=
 =?utf-8?B?dkI2N2ZVOFBNT1o1UFdjV3ZEOTNRVkU1ZUdwUWxDbDFuNThzM1ZJY0FwZ2M3?=
 =?utf-8?B?OHJGcVZHOXRtdkJiZmNOMjRXQW5ZNjFuQTJKM0I1eS9hNVRKMjZSTUlmbnli?=
 =?utf-8?Q?mwLvyuXNtT2dnZQ8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <308F8700311C87409575E1C200FD2EC0@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f75ff33f-773e-4acc-6d5a-08da1ea25175
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2022 05:39:32.4969
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ODsOQS1Mue5lFCyrdhicFWU5WLi2FcJdfWJh4a+Hin5SswAuBJNfxrqbBcEL8rN3XrCR3LTTvxXQb4HjN73Pmw==
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

T24gNC8xNC8yMiAyMTo1MiwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IFVzZSB0aGUgcHJv
cGVyIGJkZXZfZGlzY2FyZF9hbGlnbm1lbnQgaGVscGVyIHRoYXQgYWNjb3VudHMgZm9yIHBhcnRp
dGlvbg0KPiBvZmZzZXRzLg0KPiANCj4gRml4ZXM6IGM2NmFjOWRiOGQ0YSAoIltTQ1NJXSB0YXJn
ZXQ6IEFkZCBMSU8gdGFyZ2V0IGNvcmUgdjQuMC4wLXJjNiIpDQo+IFNpZ25lZC1vZmYtYnk6IENo
cmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPg0KPiBSZXZpZXdlZC1ieTogTWFydGluIEsuIFBl
dGVyc2VuIDxtYXJ0aW4ucGV0ZXJzZW5Ab3JhY2xlLmNvbT4NCj4gLS0tDQoNCkhlbHBlciBkb2Vz
IGhhbmRsZSB0aGUgY2FzZSBmb3Igb2YgcGFydGl0aW9uLg0KDQpMb29rcyBnb29kLg0KDQpSZXZp
ZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg==
