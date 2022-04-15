Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C96F7502448
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Apr 2022 07:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349730AbiDOFn4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Apr 2022 01:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234198AbiDOFnx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Apr 2022 01:43:53 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B958411A00;
        Thu, 14 Apr 2022 22:41:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mtEqlB93bRxdM+nD46BARuntDXCQqiZmZIgo2rafU6GdMoJX45o0HSDGQ5TCVDmW0gBgHEnzpXP4+miBc3y9rw2OKt7Ftd8DmNJNREYyXnp1kSg6Dtob7Vse9JxhkjEepc7WxvXLNx58jVnoS4d4nILrtKuhoRr8MCGZPmZsrj6kGbwqa+B0/kAJHiA5QCXlezxsp2Kvju//CrAnAuPG4LX3xVfrMmNg7wuzFIo9LfTeJYNbaEqavWVa5dbugUU8AJwyhuc4pJuhryydFiO/FHNR05zycxDQ9b1Dopc9iTx+JijR9IccZGtBpNcAIxlAwOH0iVhr+81qQz9rhcO2HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tzXz3EW8164cUoT21ZBUSUoZ9U90cZUmBkouo2Rft2s=;
 b=PEi3oSBnEJtyzLlh3n6RkPnhY1410Lsd3pl8eUIDaJPHX3XdtokZINGMZz27IOnnuRC7FRNv3KjVmAJI3Pg1dyCNQ4oXa+wU6UkDDsJClowRFDCQ5D4kAlbbdJjnXVqx4Cm35X/i8TRVI9ksX0w+E5YBGxv9N/5Efqb6BuUZ5oM+vB4sV7g5o8guHgIvEidNItEywfTzS8wm19brU8t2/ECSQazbDu/aWHPXdThTEMiCldDXzo0EW/k/j/gqL0M7dkrutD3w2vHGeeWqTEp5pIlF9e5a4+2znZgh8JOLJQyPCUwemgO7vevzE6mi9Kiw7aYSIEP46jGr67tWpQB6HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tzXz3EW8164cUoT21ZBUSUoZ9U90cZUmBkouo2Rft2s=;
 b=bGHX/fV6uJIpyCR2p2PaPG9oBWBEvVWfxrceGopaEEh4AETPGGtfSzbwP3/8gUrk1TdOjJGM7AaoEAjY0DQkOp8XY2tsTP26SrWcsmOFe15NJaW+XmVxFL6N82mgoyPNAT0dvPGmhE73zLaS6Xvw9HWDTAiduFRGVeU13ZU/ALibmVm5mPwujCQ+y06Zn1tHHc241PNquirvyc6UHc2gtlggT45ZBFfw8/dgbrWJroQy7f2eDsPUatZzuIVq/LfnaO8Rrf1vBJCy8Kzakbef0ePwgeXIrVtXF/Lil/8oPzyddYcm4P6BcKj14UIuMGss9Hz8CF6QNKLxXNOl5WdpOw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CY4PR12MB1815.namprd12.prod.outlook.com (2603:10b6:903:122::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Fri, 15 Apr
 2022 05:41:25 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::a90b:9df2:370c:e76b]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::a90b:9df2:370c:e76b%3]) with mapi id 15.20.5144.030; Fri, 15 Apr 2022
 05:41:25 +0000
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
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        David Sterba <dsterba@suse.com>
Subject: Re: [PATCH 11/27] block: add a bdev_nonrot helper
Thread-Topic: [PATCH 11/27] block: add a bdev_nonrot helper
Thread-Index: AQHYUITcvf8y733cvkGOzPkg1cM5pKzwddkA
Date:   Fri, 15 Apr 2022 05:41:25 +0000
Message-ID: <eba999b5-e9fc-1522-67dd-e232b48be9c4@nvidia.com>
References: <20220415045258.199825-1-hch@lst.de>
 <20220415045258.199825-12-hch@lst.de>
In-Reply-To: <20220415045258.199825-12-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1e3ace5d-eebf-4341-4b63-08da1ea294a6
x-ms-traffictypediagnostic: CY4PR12MB1815:EE_
x-microsoft-antispam-prvs: <CY4PR12MB1815A801B371E320ADF9BE64A3EE9@CY4PR12MB1815.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2jzgUEHIrAsov39Nu4LyXYMxHaRS/0z/PqpjC27blY99b3mEjRApvUf7RTIOWU/4qQyQqWnA5g2AeWnuv1xrOzdSykyH5KKZe4+y8Pr4RYbQNJ9O9dXXzyd0bXePbajuD15BRouQVSX43IsFkMfzfawpEgHePKqgTOOFU5QariEIIFHfcefLo72/oopQxBzqq8fv6cEIHqcEdUB92BMHHRKLpYjbjKGt5iRjeqUPIfkLRUS68tVft4zXiyfScqU/+SmWdNXjjNEbzgSWiUfGWypf19LoPtzxsSWCqPSMGIaoZDvqfLekfdsjx2E9OxivGSVxoGnS6Vs4pulGCMByuDH2z3U4uBmAls/ATCl1XzRpxXqcts8YJftMpLGav6verm+fnj4amkU4kBjHeQ+xiHxAqryln8MQLJay7U4DYd/6nBihFw1hlVdwYN+EoG4kYrjI1m07gPMfdo4nYHqsyBdwAnUhyQmb3a02lL+tyi7+Y6RdYs2V9VtX2fkJjJ958pd1Issfg+1h7Ge9CpWYZaK5LuzNjEVgzHS/dACTdInBjbX0RwWQb1xxM6bmXCAJJufUobRrKaS++Y/Rng7ViTYyXqZiiY4dCeUhUqwNvVgyGvFlyzQGrCMNLcVlGxSSiFHUUXZyseGiJxV1PMhhX+lPbu+2ARSOpnFoJ36tnbWt/4UJkqdMUyF9vCtVv1cZ0j298rxtDqBdov8UxjpUqSnYlKWIZaNYAoE9zWy2lWqx1H+COPtTfVBA8fi2uomChpfWPJ5XSLiLyJDd8/txjw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(7416002)(8936002)(2906002)(91956017)(7406005)(5660300002)(4326008)(66556008)(83380400001)(86362001)(31686004)(508600001)(4744005)(38070700005)(6512007)(2616005)(186003)(53546011)(6506007)(36756003)(66946007)(66476007)(54906003)(110136005)(71200400001)(76116006)(6486002)(38100700002)(64756008)(66446008)(122000001)(8676002)(31696002)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZUhHeUZ4SzZMVTFrUG9WeUlFYjNoekFLVW4zVG1RUVd0cVpGY2ljdmpTcGlu?=
 =?utf-8?B?S0M4OTVyNzZta1o4STZOSXBkU2lGTGloMXY0aVQzOUNLRWJ1cFZlc2loV1ph?=
 =?utf-8?B?eHEvUzhvb3M4NGo1eDJQbGxjMXJCZUVWWHB4dEk0YVh6UUducCs1Wk1EVFZM?=
 =?utf-8?B?MU5VZ0Z4N1h0dVlPYlFBcTQ3eXRwODZTUi9QSitDV0FqcytvbkhOV1ptNHR3?=
 =?utf-8?B?T2U5SlNuU1pRMy8zYTBTSlNzOFBOTkp6bXhtaklGSmhZQ2hnbG94OE1EUHBJ?=
 =?utf-8?B?M3pjMlJVNjhnMllDMm1ERUR5d2x1a2lyYStucm9lU1ZTNVZ6a2FhNXh2RDAx?=
 =?utf-8?B?cTNGcnhTYWFRbWdFZk9KaTJIR0xCYmMxZ0pSQ3pTcGlmdWd4QTJiV1EzcU1C?=
 =?utf-8?B?cURMejRBZjJYRzVzMjdOVFNJa1RKREJWcCtVL2wxaVVvdi9Sb1V2dHAwRS9r?=
 =?utf-8?B?Q3VtQ1UvdXgwd3dlRGlNdDZkQjZ3OUxGMjVJQmI4MXBTMHFTYXQ2ck1xYlNW?=
 =?utf-8?B?b0RmaE1IZEVFZC9ZaWVwcW96Rk5SZ0FjY2JoSWxSSXBKWjdjaVpISWlZM1c3?=
 =?utf-8?B?THorVUZFTHVmU2wvYXMwb2dDS0ZYOXh6NWxxSHFEWTlENDIzbXlEc0ZSYzhD?=
 =?utf-8?B?Rk9vSURWZzVZcDZXU1c5dHE3dG90dlFYbTM5NC8wOEtJMGpFcEhES1BaN1g4?=
 =?utf-8?B?NWN3aGpvQXpKRmdYK3VkVTd1MFllcHdlelZ1SWY0c3Y3SFg0ajNkMWxFb1dx?=
 =?utf-8?B?cTZacVJZY0N4ZlgvRVV3dVkrMjkvajQ2SDZuT2Vnb0FQUDFGM0lOVmpHUU1Y?=
 =?utf-8?B?eEhhZFp3WXh4UUxzWXNnYXFkRkZCWGtVMEhhaGNOanFHbEh4QVRlRUJhak41?=
 =?utf-8?B?bncvQW9wZ05KOEl2MkJscitvWStRVUVQNWVleEZBWGM3MFdxU2pHaHB0ZGNv?=
 =?utf-8?B?Wk1vWjNCY24vUndxdjlObFhoeXRvT0ZjTGtrUnZDNEp0MnZhTHdoNWsvMFdp?=
 =?utf-8?B?RWpzaVFhT3l0TU9JaktBT1FJY09qVmc4a2xEOElNNGFnV1hoRkFmamExVE1k?=
 =?utf-8?B?Mk9MUmwyUUJYQVNRNUV2N1hkcXYyU1RlQW8yQXVlbFRIbkYveVJQUTRRdUZQ?=
 =?utf-8?B?dTU0aDV0YkxLVWhBTWYyS3M3R3Nka0ZGSjhsOVYzdmh5MGNIQjVZNWxpMFVO?=
 =?utf-8?B?ejFrMXd6ZTA1dFdzSWhKZmJaellZVDFBY2VpK3c4N1UwNTFQTlNmU1FiOEtr?=
 =?utf-8?B?cFZhL2t1aEpUZ21NazNNeWN4OWRKa3VuMzR6N3UxK1pBb21QamVxRzZnUGZG?=
 =?utf-8?B?OENPZDhBZ3BZWmdmK0dWRDE5V3dmNUNqZTJOenFuNzl5d1o4ZkFoajdXVGgw?=
 =?utf-8?B?TFplVnRrQUpyRitjTU5CMDFYc3JURThuOEljT1ZFYklwQTY3ZTNSeTFuL0VY?=
 =?utf-8?B?dVNtWmZkMjI3ajBjMzdJM05qbVUrQ25MSTRCMkE5RDBRYkJ1d2xkK3Q1RWJP?=
 =?utf-8?B?TkVGeWF0UCs2emZYblNIUkloZkZRVklLOHExdEFpbFNXVnQ2TFpNMEtoSHVG?=
 =?utf-8?B?UzIwUU9CQUU3RTJ4cWFvVHc2SDdhZW93cGZZbFNDbndqVkZVL01XK2g2bUdn?=
 =?utf-8?B?djVnSVlFenNiZGpsZzJGWDc4NlhUS29VTTV6WmE3ZlRzWFV3eHYxM0ZJRzFH?=
 =?utf-8?B?SC9YTFVhMWdlY041K3FMZ2MxQm1jK1B2K09Ua3NpQUNwYjRJREYrbk8vbDNV?=
 =?utf-8?B?VC9BTVBuS0dpT1llWXRNZ3JFNkROeEN0dkJhUy8yWkxXUlpwWnhzY0FrQmdx?=
 =?utf-8?B?U3l1bFRPUnVnVit4dzQrZWFuanlwekdybi85UDYxbjlqQkJqc2NmS1lrTUI0?=
 =?utf-8?B?MHpFSmpibFZtVU9jVHJCWWtDQmVXNkZWNFVzRzB2S1U4M1RmaitxeiswZ3NB?=
 =?utf-8?B?MDdMQVFheGpvTXlVeWg3WC9hdWEwSnNXV3lMYTVIT2c4QlNqUFArell1bE9i?=
 =?utf-8?B?SXNCNkRBbWdCbDJuLzdOeFVSVUEwMHJwc0NYZG1vOFRzQTRqZUM0TXIxbnlS?=
 =?utf-8?B?Nm9vb01haHJ2eUgrR29KUStMN3RpaktxRGZ3Y2VtUEF5aVRwK2N6N2FsMlFa?=
 =?utf-8?B?UVBNS1VSV20rSnEwT2pMbExSNldHRTV1Q0ZqdnBpODJ0TW5kQndKSFRkcUVC?=
 =?utf-8?B?QkFWbmZobUVLQ054WWdzcEx2SzExVTBEN3FRUjR5V1R2a3AyeDVmazFUeTFN?=
 =?utf-8?B?VlZ6QmRmK0w4VVlMUFpyVVV4ZkpNQTIvODJWejMvUWxid3NqRmh5OGRvZHhU?=
 =?utf-8?B?bVpFSEkyZkp1L0pKNW9iSTBMU2MrVTdqNzFjVHlaK2pkZ1FMUXlqZ0JHdHY5?=
 =?utf-8?Q?2LBvpDbn9ASM/rdI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <78329BCB58D5BB408C7439FBB9C8189D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e3ace5d-eebf-4341-4b63-08da1ea294a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2022 05:41:25.2089
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sQnzIbBLTrp57c3vH8r48gJfpEIw9VzuFDfFpnwqaIrkuMKle22fiUk7xI+IyQciiM9x+KvS7whe2PMfw5w8MA==
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
ciB0byBjaGVjayB0aGUgbm9ucm90IGZsYWcgYmFzZWQgb24gdGhlIGJsb2NrX2RldmljZSBpbnN0
ZWFkDQo+IG9mIGhhdmluZyB0byBwb2tlIGludG8gdGhlIGJsb2NrIGxheWVyIGludGVybmFsIHJl
cXVlc3RfcXVldWUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNo
QGxzdC5kZT4NCj4gUmV2aWV3ZWQtYnk6IE1hcnRpbiBLLiBQZXRlcnNlbiA8bWFydGluLnBldGVy
c2VuQG9yYWNsZS5jb20+DQo+IEFja2VkLWJ5OiBEYXZpZCBTdGVyYmEgPGRzdGVyYmFAc3VzZS5j
b20+IFtidHJmc10NCj4gLS0tDQoNCkxvb2tzIGdvb2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFu
eWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0KDQoNCg==
