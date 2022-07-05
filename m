Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33FEE5674CE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Jul 2022 18:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233126AbiGEQuh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Jul 2022 12:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbiGEQug (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Jul 2022 12:50:36 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CC71D310;
        Tue,  5 Jul 2022 09:50:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lTEPBtVUACMguQgFvjwhVkPPO6LUQLaB4cqTwm0T0/HbBa5APUpEO+SfxLV43wgWBU4cZI+ARSBDISQ0BUtL3m8PAYkiKAmY+mTGTnURTzhsBU+xIc1d46BCL8YheMNS94MfGlTY1rmGsqrukLEtfyOnX6XIJT3icJGIDc1xRHRPAyYcck0rb3xrHy/+6C3gl4YlPpfZO4PL893r4bz4GoDntLkbJwUprWeeFa1EinYQBPVRp/UX/l4UQ4kno/afi5z4t701RlYPS5HiFA6UAJMUXvAFNK4rHuNpnBvkJQiokdm+JOUqelMzeef0qlv5yuX8zN8VA/e8ssDViPxyMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sRvCExBBLjBbp+3vpawdfdjvjlleISsfKG1ODdylcVo=;
 b=h5y8a6vZZcXhcljk19Cm87d8O8xDA7wlFWF8gHFRGlyHU9XwTnNephdC8cSlaZkVDI3hclvj6Bi6YyrBu0E+nO7WfT2rnz9URFHUuxw16UZvboRRWLi5HatUPypN2YJb0nZSeYQfbeKJ2c/C0YyalsyHl+4yvTktbytVsqSkwZBmEmIUhqTltd15w9dXzrLN6ZmJ9trL0ZYsklC3s/oKoYU4WT9EclV6e/zped3HEmmgxU3gnFuocLseD12DC7gN+k9qKmxLhLde3JeBQ2uGKHk2doteLndj7O1MjNwSL4u3KqJxTtd6QFYRHoHuU+ZEzDGsKaN3zcZ3fR4IQJ4z7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sRvCExBBLjBbp+3vpawdfdjvjlleISsfKG1ODdylcVo=;
 b=lfFXBatqUTujgbzePp/Ka0vVgylMujZ4HzUER/qTm+IzSsGFDFdyxWnmmPy9WX1GQgT0IhTXeOLfpiKQRze16HPRenVVRCJFbk2Xd5cfVDiHhD+IRfVguXax0ozB0i1frLBAIcgXKBElZ562QzwNaExQYFxcNNyGX904JFGv5jj1suKidA0wzQVkg1msn2jEKGEd7yCRUyW7fzzW9lP/gemHnztbH+F/S29I48erk0PU8kj7YnHwCklsuvQWEZnKUD9yXbwXqqf/5cuKU5MqL9CvUfNH8apy9kDnSKf1r4QsWQIso6nlnAVrqtzvPDzDMjzjREaDI6NAlrhIdwJsAQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DS0PR12MB6488.namprd12.prod.outlook.com (2603:10b6:8:c3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.18; Tue, 5 Jul
 2022 16:50:34 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::240b:5f1b:9900:d214]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::240b:5f1b:9900:d214%7]) with mapi id 15.20.5395.021; Tue, 5 Jul 2022
 16:50:34 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     "Darrick J. Wong" <djwong@kernel.org>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "agk@redhat.com" <agk@redhat.com>,
        "song@kernel.org" <song@kernel.org>,
        "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "javier@javigon.com" <javier@javigon.com>,
        "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "dongli.zhang@oracle.com" <dongli.zhang@oracle.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "jefflexu@linux.alibaba.com" <jefflexu@linux.alibaba.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "clm@fb.com" <clm@fb.com>, "dsterba@suse.com" <dsterba@suse.com>,
        "jack@suse.com" <jack@suse.com>, "tytso@mit.edu" <tytso@mit.edu>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        "danil.kipnis@cloud.ionos.com" <danil.kipnis@cloud.ionos.com>,
        "ebiggers@google.com" <ebiggers@google.com>,
        "jinpu.wang@cloud.ionos.com" <jinpu.wang@cloud.ionos.com>
Subject: Re: [PATCH 1/6] block: add support for REQ_OP_VERIFY
Thread-Topic: [PATCH 1/6] block: add support for REQ_OP_VERIFY
Thread-Index: AQHYjGHTGA1KUuSqQ0qn1A7ygjqAAq1oIUiAgAfko4A=
Date:   Tue, 5 Jul 2022 16:50:33 +0000
Message-ID: <476112fe-c01e-dbaa-793d-19d3ec94c6ef@nvidia.com>
References: <20220630091406.19624-1-kch@nvidia.com>
 <20220630091406.19624-2-kch@nvidia.com> <Yr3M0W5T/CwMtvte@magnolia>
In-Reply-To: <Yr3M0W5T/CwMtvte@magnolia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a0915982-1c8b-4a38-632e-08da5ea67a84
x-ms-traffictypediagnostic: DS0PR12MB6488:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CF76nrWiWxJKWAvzKrcy6TI4akf7A2/JP7whwrwbC96gARHv17QzW/KBWer4CQZ9ZM+7vAE/ldG3nHY8u13B/uR3JRfHJCyJmoHEBLm12blJYf7OlbTTSCeNaK50HjBgVWNYA8C1Nlq3IxrZYY0mtE6Dux5wxGQZF3SHOpCx+PAFlvy6armCR3GLg9m0JME8mEmaKHyWHZCBlje8zOv8GLmr7N5geBcUcf0CvN54lJo8eevo4DdNSOieEfYmdbno4jK1+2M/k4VXo8yFQPMctESWx7MbKejYiRW/h61Oo0k6U0PoqNvnWlEKmlkdWceTb1OEw0D546QEaysm42Ng6zD0ZGDpjnHyfWE3myH6hecS5IXr4gSl8IK5tIMLX+k5hFWS/EHB0TNA88dkiVWiQQqkupTwk1vunw2MhOOTVjIqoGhtSzvxf3gMPfhI0c3UotsYl4pR8RMlOATr68xe+r+s06HdoAz92YucG2RHrYvgavWT+I0hG5HTA7LHtdJXPiqv938xm9k5LwLzDkShf8ovAFos42FFw47caKdvzSRctaWeuFeXzLpqjZ7wAtyL3LyFf7mXNzlOP5+6EotmY2mBO1A3aDRDLJp9XpBtTC1y0Re2zXnnS4QvI5BO+w1c9mP7GNypCwZpm8W63JiN9Qb8C4gyCThYgZzSa+owYvM/GaQVBZYw2MnfadEm6P83rgAtxLNKTqKW6Uth8qiUVBUE2THjwZjXdHvnucvlihfI2mAeiiCBCOqqJnda7wf/gee2bY3Z3GlYDxcirrEAlASwJN44enKKgx+zzWTTK/mgzuHKKWy3LT9r6Gzjwl8kBAvugOc50aiJ7KrZ5JJrYJqzk+2wzLX4Ct7i561V3CMuxKykuFMuJS17AF+6Z0Ks
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(39860400002)(346002)(366004)(136003)(26005)(6512007)(38100700002)(2906002)(38070700005)(6506007)(83380400001)(122000001)(110136005)(64756008)(41300700001)(86362001)(5660300002)(71200400001)(66446008)(66946007)(66556008)(8676002)(76116006)(6486002)(36756003)(66476007)(31686004)(7416002)(478600001)(8936002)(7406005)(31696002)(91956017)(54906003)(316002)(2616005)(186003)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZUpHTFhybFk0WUtkODVJM0N4ZmhWM21vNEJTazJCakdSWTBsZlFVWnhOUTRa?=
 =?utf-8?B?dGN5KzBlQmt5MlBFck5HMTRURTN2WmVoK1ZjZGNPT3VlbGdtVjllQXM0a1BV?=
 =?utf-8?B?dVdRdnNEUWRPaSs4N29BMFprTW9tLzNDUzVNVXdOREpzd2NNc2JqZkhEdzAz?=
 =?utf-8?B?cTd6MnViMFhUL3U1aytVSUg3Nk5tUks2WkszNnp5U3lIV0ZlNlR4cWYrWUtq?=
 =?utf-8?B?Sm9qWll6Z2NJd3JxMDF2eXJIV3A2TkI5UWRXR2RkVzM2L0ozVk8za3N0SEZX?=
 =?utf-8?B?STZkNWY5c0pLWjRDT2FrRmV2dTVodCtzWVpWN3hQUzZ5b1NDblBJK204MlB0?=
 =?utf-8?B?bWp4WGRRV2E1S1VNNnpYZzB1NE14cHBKaW9ZV2NkNGg3L29rOUtncURQeEtK?=
 =?utf-8?B?aUxxbUtxUGYzeWVvOGhJRlhVWjNWWll4VWNJOVRlL3hSbEhqTTZna3lSZlVT?=
 =?utf-8?B?Znl4SlgwOERmRjdhcGgxSklPVEdLaXJQQTZGZmFuWGFGeXpnZlZqSzNuMkZM?=
 =?utf-8?B?em96L3lreWlLZHRJUStmUSsrQ1pURlVibzlTZzhIRk1vakZsWkVHU2dHek8w?=
 =?utf-8?B?a3NYOHlCQ1psbEhiSENPMlg0VnJjTlJ0ZU5LTmtIVzRrY2dNQnBxc1UwNDZm?=
 =?utf-8?B?cm1NZFVtK1A5Q0I3eTNEQitlY09KenhlU2NyK24xeFdwWklDVlpaOEQ2UkVj?=
 =?utf-8?B?OHR5RlRUZUU2UHNIMmpRWWpKVENCaW9YVDd3ODdoM3BVSlB5S2gyM0cxM285?=
 =?utf-8?B?RzhQbkhBQVR0b1liclpoNmpJeVlVUUZtN2Y5TndHMUQ4RThXZnNiRkVwMGp0?=
 =?utf-8?B?eGtzMzFjV0g5WXo5cm5xOWFxRW41V2xyeEFJZzlxYUhWVm15RVZwVzlrWDFv?=
 =?utf-8?B?ck9kb3Y0RElDbEdDcUtHangyRnAyNVRIZlJ0SGtQVlIzS1JZd3B0MkZlTUZH?=
 =?utf-8?B?aWpBbmRpMlhNYk8zUEJEdFU4eWE0enFrYm84cldORXBEMWVBelJXWVRzbFhz?=
 =?utf-8?B?cFdvS1BwbTR2NEJLaVRFSk12N2tWWlA1a1EvbWhxWnBOczBWM0ozMnFnSmZm?=
 =?utf-8?B?ZDFKYjZYQ1pNWmNFSngyUkw2U3A2Q0tWN0xkQlFjbVdXekZscnJnL0VRZGNp?=
 =?utf-8?B?RWJUQmdMZFRBbUxsRE1qNVF0YlAySENGSlBZNHRtT1hpMGpTMjZ1N0ZXdVJt?=
 =?utf-8?B?RWhTZDdHQkZ2Ky9WdU9UNHp1VHRLVndod1FURlNRalorTXp6bkkwT2F6VkFk?=
 =?utf-8?B?RDlXL0dKZEFYaEJkUTRKdzBhRkdyMFcxeWpJWUVKZDVUM3c3RTdDcVVLMlNU?=
 =?utf-8?B?ZGFLbGdJUW11MXdSN1pYVnFvQzFyczM4bEpqc2RHQVN2d052aHdWWmRRNzRO?=
 =?utf-8?B?SkYzZ3R0VGMxT2VsVVJiZkdDSWJIUktMWkd4WmFkZE5MNkZlSEdUOExOVVNU?=
 =?utf-8?B?MVhHNEhjMzRzNE9oeFY4Z3lPbGJXWDFyNVNETTBxZkkyMFhuQ3ZNZTFaUHpy?=
 =?utf-8?B?TzBBWm5DOUUxUWNZeU5JNXhuWGFNeSt3UmtvK05ST0RtQnRWYVZvOFV6Z0dW?=
 =?utf-8?B?WGY1UjZocytTZ0ZFZm5saVJTU3kvcDRqVWplcm5xaEZWL3JjaVA5UHoyNUFI?=
 =?utf-8?B?OXVaeXlkbU93VmtrSkRCU2tMaS9LTTVZVTN5OS8xdDNrN3ZRZ2s1c0dZakEy?=
 =?utf-8?B?Z1BDTUpwd0d4OXhhTWJ0RThpejFIb3ZMaWN2bTBXVDZ2Nm5Nd2d0L0lpUjdq?=
 =?utf-8?B?OWErSXRqcDNlNnhyZ0laODFLeE9EYXpXMStpY3NrT3I0bUFjSldJVTZmOXRJ?=
 =?utf-8?B?djJVV04vSkZyRkdVT04xTjN2ZVpKNmdVRWZOaWVuSGV0dTA0VHZKa3JxRVp1?=
 =?utf-8?B?QlNnMStyK1lUUzBBTGVvYUxZSjAwN2haYlU2VUo5VnhNdWMvUHhuOXRnNVpx?=
 =?utf-8?B?TmlaVmRNakpSeE4xZ2l1eUhvNFZ1MmR1cDFHaGRKVFhVRHZzZ09MRlV2QmNF?=
 =?utf-8?B?Y25PTTU5Q21BQTRIRy9zaDFHVFNCcUdlWDhlOGp6ZzFrVnpxeDhDZkF0Wkdw?=
 =?utf-8?B?bU1GQVNYSGZnN0FWSFl0d3MrU2gvTFA0cjVVMENhOVdFYlFtbng4MGVjdGZi?=
 =?utf-8?Q?sD1VlxJPXocA7jfnqK1jz2WTR?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7A4254D5CF4C034A8451F64599734307@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0915982-1c8b-4a38-632e-08da5ea67a84
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2022 16:50:33.9268
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2J30Sf+/QX6EPtbbjQNb7f8PiTQILdmYZObZi5DGjXzfj7Vyu1mCzn/FgYNrwRSKXePIw3dZWWXm+9YGE1nN0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6488
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

RGFycmlrLA0KDQpUaGFua3MgZm9yIHRoZSByZXBseS4NCg0KPj4gKw0KPj4gKy8qKg0KPj4gKyAq
IF9fYmxrZGV2X2lzc3VlX3ZlcmlmeSAtIGdlbmVyYXRlIG51bWJlciBvZiB2ZXJpZnkgb3BlcmF0
aW9ucw0KPj4gKyAqIEBiZGV2OglibG9ja2RldiB0byBpc3N1ZQ0KPj4gKyAqIEBzZWN0b3I6CXN0
YXJ0IHNlY3Rvcg0KPj4gKyAqIEBucl9zZWN0czoJbnVtYmVyIG9mIHNlY3RvcnMgdG8gdmVyaWZ5
DQo+PiArICogQGdmcF9tYXNrOgltZW1vcnkgYWxsb2NhdGlvbiBmbGFncyAoZm9yIGJpb19hbGxv
YygpKQ0KPj4gKyAqIEBiaW9wOglwb2ludGVyIHRvIGFuY2hvciBiaW8NCj4+ICsgKg0KPj4gKyAq
IERlc2NyaXB0aW9uOg0KPj4gKyAqICBWZXJpZnkgYSBibG9jayByYW5nZSB1c2luZyBoYXJkd2Fy
ZSBvZmZsb2FkLg0KPj4gKyAqDQo+PiArICogVGhlIGZ1bmN0aW9uIHdpbGwgZW11bGF0ZSB2ZXJp
Znkgb3BlcmF0aW9uIGlmIG5vIGV4cGxpY2l0IGhhcmR3YXJlDQo+PiArICogb2ZmbG9hZGluZyBm
b3IgdmVyaWZ5aW5nIGlzIHByb3ZpZGVkLg0KPj4gKyAqLw0KPj4gK2ludCBfX2Jsa2Rldl9pc3N1
ZV92ZXJpZnkoc3RydWN0IGJsb2NrX2RldmljZSAqYmRldiwgc2VjdG9yX3Qgc2VjdG9yLA0KPj4g
KwkJc2VjdG9yX3QgbnJfc2VjdHMsIGdmcF90IGdmcF9tYXNrLCBzdHJ1Y3QgYmlvICoqYmlvcCkN
Cj4+ICt7DQo+PiArCXVuc2lnbmVkIGludCBtYXhfdmVyaWZ5X3NlY3RvcnMgPSBiZGV2X3Zlcmlm
eV9zZWN0b3JzKGJkZXYpOw0KPj4gKwlzZWN0b3JfdCBtaW5faW9fc2VjdCA9IChCSU9fTUFYX1ZF
Q1MgPDwgUEFHRV9TSElGVCkgPj4gOTsNCj4+ICsJc3RydWN0IGJpbyAqYmlvID0gKmJpb3A7DQo+
PiArCXNlY3Rvcl90IGN1cnJfc2VjdHM7DQo+PiArCWNoYXIgKmJ1ZjsNCj4+ICsNCj4+ICsJaWYg
KCFtYXhfdmVyaWZ5X3NlY3RvcnMpIHsNCj4+ICsJCWludCByZXQgPSAwOw0KPj4gKw0KPj4gKwkJ
YnVmID0ga3phbGxvYyhtaW5faW9fc2VjdCA8PCA5LCBHRlBfS0VSTkVMKTsNCj4gDQo+IGsqeiph
bGxvYz8gIEkgZG9uJ3QgdGhpbmsgeW91IG5lZWQgdG8gemVybyBhIGJ1ZmZlciB0aGF0IHdlJ3Jl
IHJlYWRpbmcNCj4gaW50bywgcmlnaHQ/DQo+IA0KPiAtLUQNCg0Kd2UgZG9uJ3QgbmVlZCB0byBi
dXQgSSBndWVzcyBpdCBpcyBqdXN0IGEgaGFiaXQgdG8gbWFrZSBzdXJlIGFsbG9jZWQNCmJ1ZmZl
ciBpcyB6ZW9yZWQsIHNob3VsZCBJIHJlbW92ZSBpdCBmb3IgYW55IHBhcnRpY3VsYXIgcmVhc29u
ID8NCg0KLWNrDQoNCg0K
