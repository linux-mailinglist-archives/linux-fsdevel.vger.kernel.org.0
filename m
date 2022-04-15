Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7F4C50247E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Apr 2022 07:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349861AbiDOFon (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Apr 2022 01:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345575AbiDOFoj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Apr 2022 01:44:39 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25681A76D4;
        Thu, 14 Apr 2022 22:42:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WU7wbWXMPRMCSKSHOIytJ+eX2d7dPF5S2B41rPR3o4NX7LGL0eHg2cjg0QKdThr7boThD7I81sqWbwhiim08Hq3J4/Jj657abDF6suNR7NgQVF22H5N1SZTbnBnf2Pqd5ZD8THBZ+JXLf2jOteWlqiWuGapnIk2FLAMdxDsgiBkTFNCBcKydzcIv/JHfXGsmFDgTSnYcb4cOIM07K1LX2JGAX4Gi9vT6SQ5ulze2BRBcHyHn+Y44YjQyz7lAI8dK+YtktkWZZ3HDcnkP5N1ftYZe0iF1KcXU0nmLDJW8pAv4Vu350YkK2wQIxW0rHbAVMNCHjXq8MLHd6d0CvE1zhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cXmWoxiNrFUT36KRaCWH5ftRvcuoLnY+vq0rmT1Kt9U=;
 b=HKq1lIpiEHpgz9XqSMCEvSRBp9j3kHVQVk5Sswl/JMPviKMnDbhJNWBGyF8HPEMM6FoOOLF1FeEezIR12hm3p7VJCfN/erbDjSP+lQnc2KCFWy32yVAnz4VK3JoAVwiJ9QGkhqazVUmun/MHtWU6jXTyfZQTd7r8SAZmBicxVR++jI+ImkjoLqjdr0YnTSkumqBuEuG5fK5W+IzZJETt9umKCLvJm5dcmXgpgAEiLkwDPsIMlbq/c5AyQ2O4ftDAJ6gCkqB2TGJhaGfeCa4k2oac/XHH18to4YhjNptm+inZc29pqJ74rR1q3TftXkc2g8A2Pptz+dk8+26hhQ3k+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cXmWoxiNrFUT36KRaCWH5ftRvcuoLnY+vq0rmT1Kt9U=;
 b=PjcfOcmcIW+IJ+Rx7sLUBgkGMqL5A9o8uphx3jDX0X3PWGeQ7n8JJwtjzF4wxaDknIExHlAPQjAebMZY/u+ZU5YXZqony9jVj93r9e42VIOUwZtZOUhVOKYzuPQ418L2D9YinV5P3ASM3hpk+Z8l1gtLXh/oKAgJEPl0rxL6fjq4jhUXXVow5xQzmMlj45FbdPWI+THaSSV30hXXb4Z3aPWoVQxkZlwvOPVOWmMxQecPzPnSIjNvA0awydisQaYqmiVEPzY+LECJ09AJUKiN+T2VQ+aQxh+vAkV4lFt8kJAQHYNWnsYXDOKMmAOABtDsDaUImG5BHHxkuAKfIqczjg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CY4PR12MB1815.namprd12.prod.outlook.com (2603:10b6:903:122::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Fri, 15 Apr
 2022 05:42:07 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::a90b:9df2:370c:e76b]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::a90b:9df2:370c:e76b%3]) with mapi id 15.20.5144.030; Fri, 15 Apr 2022
 05:42:07 +0000
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
Subject: Re: [PATCH 13/27] block: add a bdev_fua helper
Thread-Topic: [PATCH 13/27] block: add a bdev_fua helper
Thread-Index: AQHYUITeWwsZSeujF02rS5YtUAwIEKzwdgyA
Date:   Fri, 15 Apr 2022 05:42:07 +0000
Message-ID: <77dedfc7-d5af-4d87-0383-613b80139850@nvidia.com>
References: <20220415045258.199825-1-hch@lst.de>
 <20220415045258.199825-14-hch@lst.de>
In-Reply-To: <20220415045258.199825-14-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 78d5bffc-1ecf-410e-e5e5-08da1ea2addb
x-ms-traffictypediagnostic: CY4PR12MB1815:EE_
x-microsoft-antispam-prvs: <CY4PR12MB181583C18B6F4B1306D9F075A3EE9@CY4PR12MB1815.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EyB8hyf1JleddzYMugoCzU5pDkbuoBJ4pMtfwahP2ogCrshpAMwi/M3kryaDsr86Ji8Q9U4kHeq8opzY12HtfVHQnFhUIP4brKkdTIq4Y6ukil1eCLgOOYlrZ5o1P0nbImPP8bumuAkoyxQWEqr2pscBJl7suKAqCf+rn7r+oOenvqj+4obi/miPtobHImnRCiFqVQgtDsT/N32Ixv+yCvs7EJ/Hlgkoeim10mAXruT2vQpZWRXCIY71uWhnrRmvywzHl7+0ryrDGpRopaC4VXorwnKmlY7xCtQdT3mJrLKecVx4z1anmMntcRJN4vtQSorQWycnaL1JGitCMJ13sT7IUOpDp8A9esZxVNNwKoF5yroommwEp/ZWFV25t1L6NdLAVHxuUSTk2hLWvATU1xURTecgCIb0C+Nt7FJH9FgvN1phKoF3Jy0/LQ7Z2L5XS7q3Y2RTN4gd17beEyBfgw9bBAZ7KGjVbp0h4a/agz8f8JNJ14537BDPs6J4py2NSMmRbnayX1NHA9E2IbENVLOxyFwNhoNxoUeEk4M9KIZevesgLhYW+Jmz/E5nFz5VzA4tF30LXK/mutY8o+Q3ehw562gSxt3f8beQMVMuO4uH1b0XtHszv8e4ig5MbRiv7U7I69/l0BQK5qbz4DsvzlZdDK2gMlITuS6vpjPKMLETzOjcBDVIkDggnK+CZDCHTsQf7NR8pON2Gh1zpljGDLbLOiFSS7nCHuiYk3MYIrgjzUsd+XeEtmHZBqZVF24+Em7DxOzP3Z/CS72dLl3aOA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(7416002)(8936002)(2906002)(91956017)(7406005)(5660300002)(4326008)(66556008)(83380400001)(86362001)(31686004)(508600001)(38070700005)(6512007)(2616005)(186003)(53546011)(6506007)(558084003)(36756003)(66946007)(66476007)(54906003)(110136005)(71200400001)(76116006)(6486002)(38100700002)(64756008)(66446008)(122000001)(8676002)(31696002)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Rmh3d1NVRWtMeEFsb25ENXVPcVBIMC9EU1JnVHNBZDdqNHpPUDR3SGJFb1B1?=
 =?utf-8?B?WFVvOWJBVjFvWnNHOTdvQmVRQ2hHeHN3UlNEVHRuazZ5MFI2SVVraTQ5UEMz?=
 =?utf-8?B?VzZYdTAxRVp6U1RtSUFzUjdSaW5udmZySW9BenAvM2FZZ09hQVJ1SlVqUDJh?=
 =?utf-8?B?eXhCQm1lZExVT2pKSFRsNUt3RjlteDdQZk1LQkdUT2xNTDNoWSt2SThmMUVE?=
 =?utf-8?B?MCsxUi9lcU5OYTdzL1RFZ3kvMWVSa1Jjcjl5YVFJUDVyWGVzL1lmK2d3c3c0?=
 =?utf-8?B?eW5BL1pOdVp1SW92TzhlVzFJR3ZhVFFxYTdKRTMyN1ArMFVGZ01NYjZ5WnU4?=
 =?utf-8?B?SE8zQXdaWHkrclZZWWYxWWsyWEJMU0VSWFEzRldFU09HZUdock5xZGYrL3F2?=
 =?utf-8?B?VU1yN3FUYzk2Ny9JYXhNQVZqdTlCUkoxbURaUE54M29ZdXBVM1pWZGUvc3lo?=
 =?utf-8?B?em03MStETWlGekZqQXA2L3dHdjlWZThmbkk1VHdzMDN6eHo3YTNuZEc0cWN3?=
 =?utf-8?B?WFBvWDhlUTIwMCtjcVRqbjhUbGhCZTdRK1hFbWw3LzRSeHNQWGk4U1o1RG1G?=
 =?utf-8?B?ZEcxbGZlN3VkWlQzT2FZM1hlR0cyZVcreDYrU1ZpakhoS2V6ck1ka3pnSjV3?=
 =?utf-8?B?c2l3dVBUdE1mUVRnMGVYRGpSLzdXVTNRUzNHUitqbHVKaUNlb0RVcE9najdp?=
 =?utf-8?B?OUxqaFZXbzhZUXNNemhHd1lCcGRvQmlPSHFIc0tid3lPVlgyK083Z0ZuT3dh?=
 =?utf-8?B?SUVZdUxjb2lHRkNSRFhHODVKMklUYStkUDVYN2RVWDNLcUpaZmIvMk85WmFK?=
 =?utf-8?B?UzN1ekVRTnAwVVF6RXR0YmJSUXVnYlZSbmRSVTZoSHZrc1BKUXlVeGpVMkE0?=
 =?utf-8?B?dk5ram9IUTMwVXNZVFU1WmluR2NZZkIrSlNXQ3l2NEpXZUhZbXYzbHNDTnUz?=
 =?utf-8?B?UXNxM0JGUE1ORWFaQWphWEVIcEZpS1FzQUJZYUtmeURpa091SlJxMTJUOTFQ?=
 =?utf-8?B?MmIvMU1ucUVkWEFvblNJZHh6QVFmbUxSMUJzQ054MXdGV1h5eDJTSU5XTjZp?=
 =?utf-8?B?RkprY1hweDJlNDRnUGpIMEFYWkVuMERPUGk1b0FmTHRyNzFyRHpHemgzVHZp?=
 =?utf-8?B?RVZ0aXJxRXF4cGVmQkNYd3BOdzZjSWtVSVd0UWwxa1QrdFlNcEo3NjZZTVU5?=
 =?utf-8?B?L0Nid1ZoSkI5U3YvNkZNclY1dVZGaWZlTmROQ1lHUkJDa3AyYTZkWm1CaDNn?=
 =?utf-8?B?K2tWSy9va0hNcmRhZWl4SFV4RjNDSTFCaUdOeGVjNjNscmsyNFJUQWEreCta?=
 =?utf-8?B?dURReHdvTnplV3IyTWJzRjd0QS9mY0Z5b0hKQjhNT29MQnhYZXowZ1EySHZC?=
 =?utf-8?B?VWRRVEhGV1R2V0llT29Vcy9XZXBjemlQV0FpeXVnYXRPODd1NHczY2xiaFoy?=
 =?utf-8?B?cVo2WDV4UmF5TXh2M0R5TnVRY3dkakI2Mm9kOUNLaUhtRHA4M0plYlFuQ3hI?=
 =?utf-8?B?SHdkaldiWTRnUkx1VzdjYmUrdmZCMFQ0VHg3V0wxeUpJTy85Ujd5Q0hPc2Jw?=
 =?utf-8?B?YkFLMnE3Nk9zRENtY09wQXJkaUV4QmJVOElZb1pWTmNTUnd4NDZGVXkySU9T?=
 =?utf-8?B?UG1xRDVGMGhtb1AwWWo0UFJ6SmNiY1duYkQvcTBEY3p4OWREWVY4cXZtNzhG?=
 =?utf-8?B?dVNMcnU0ZVRCV3hjNG5kNGdnZlo1eGVwaHlIbWRtTmVXU0RXYWdRUnpReGJq?=
 =?utf-8?B?ZU4rZytpajlJdzJ0ZnNqV1lCYVlBNloxYUVYOUtmaUMwQ0UrYjZMMDVJYTUr?=
 =?utf-8?B?eHkzc0JVdnBvcmVabU9KeURONnBiRXZuN21mT2NJcVpZam93dXRDVFVyL3VC?=
 =?utf-8?B?UDF0cjhFU1hmaG1oQUlPdjluVjQyUng0YjYwUlhQT2x3MWVHOGxzc3BhYWdn?=
 =?utf-8?B?aWdCZ24xZmVselZnWTJtNng0Q2pvWGRUdXVBZVhTNlV2Umg0T1BxcjduVjRT?=
 =?utf-8?B?OGsvNnZKd1M5bXptRWdoNGNobDdTamxFbXNTMzhCOWxOSDZMTGZ6V0RHeHE4?=
 =?utf-8?B?czkxb2JnVnB0dHExUE9vODdBNWFJdlhqLzBrakJrMU1mSWlKSll4M0pTOWxk?=
 =?utf-8?B?SmZOTFN2cVJpdXB0UVdxSzFMVUt4RjFENFNIanNNWWovYTFkT1J4Q2c2SEhB?=
 =?utf-8?B?MGJKUk5PdUZyZHRSekVETit4MkZ3WUo2WmRZV2hmaitKYjRybnYySklQdHVB?=
 =?utf-8?B?dlBFMzlYdENUUHpCL3NXak1WU0FiZ091TGswZ1pSQW5ZZTlWN3lZWTJCVnN6?=
 =?utf-8?B?YlJEeHlaMnUzL2tuZ2pHM1lBN2g5T3hJVXJDSGdOeGhaSDg0Rm1Va2loa2c3?=
 =?utf-8?Q?1Z66E7GDw37e6nTgD+MH8VjpaJC1xSuIdTeG5?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DF997BF112FF594981505DC1D908FBEE@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78d5bffc-1ecf-410e-e5e5-08da1ea2addb
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2022 05:42:07.5188
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4Ta0Zovff0U+n3TbFxVzpBAWYFvV5vI9cPj3l5EKpKj/yjyOIuU3gSYzhUD53UrhII2nt3yMopUhXs1a5HAr+w==
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
ciB0byBjaGVjayB0aGUgRlVBIGZsYWcgYmFzZWQgb24gdGhlIGJsb2NrX2RldmljZSBpbnN0ZWFk
IG9mDQo+IGhhdmluZyB0byBwb2tlIGludG8gdGhlIGJsb2NrIGxheWVyIGludGVybmFsIHJlcXVl
c3RfcXVldWUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxz
dC5kZT4NCj4gUmV2aWV3ZWQtYnk6IE1hcnRpbiBLLiBQZXRlcnNlbiA8bWFydGluLnBldGVyc2Vu
QG9yYWNsZS5jb20+DQoNCkxvb2tzIGdvb2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vs
a2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0K
