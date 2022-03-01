Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A56194C97D1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Mar 2022 22:32:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238608AbiCAVdI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Mar 2022 16:33:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232090AbiCAVdH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Mar 2022 16:33:07 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC601C12C;
        Tue,  1 Mar 2022 13:32:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZQdNqgd7bT1aylZcIpE0tonwOZkiwy4Sv15K5+itEV13W/Sf3zQb5j1eWGBTIuCuKZmngVcrPNsDEKCV+eCyfuUIeGdHxIjgYl/nt/GN/Ce1HgcsFjtoK2QkZjejbPS/dCu0kDvfWqSVt5eRuMK2sXt2L6ndDCN0RzwnLOkmW+i5M33d2ecV1lY23pReFuBDTOnDmxzX5ioMHSmSkT97kC2YvTiBmGUG2FccrcVEecpPdtdBzG9pBhrBReAzJT0asqTRclkAUY0e8Ki7JTYbcHSjVrENdoISeGm1F+kNuTHcbtQwLMecsQMKj59N6JJyI+gu+vp4jwaVpkmbTK9F7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gxna+QEGvm7zxNn+2griGcXH0GR7upyiEOrOalDWd/Y=;
 b=iG2+CL4xh3XYyQxeqbSyz8hXWAh1UdXzZKxt0rl6qoch/c5NFczYAs2pEc8pjnC8bDujGwhWsbAnYS7Bb1lvczhyAuvemjPVjwOg++sdTBWcvVbfTfdGdK+Izy7lnig3mXS8xqHYxkQhCx6VdQ74dC7EP0OFiHaWDsNMO6TlaETG+xD9UqFGsEBSzPodMrbuGi0wShEtQVlFc1Z83LvH1QMZm1bR3VBNvdo378rLBh+55PqhAYBMn8D1RwkG9MapsoY6y0c3YBOcG61ux2ZH/8gH5DyRhU2a/ipt1+V60ccQRT2ag4DAHWQ1wvz2+iwVrKDQyD9drfFbLEqS+MP8uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gxna+QEGvm7zxNn+2griGcXH0GR7upyiEOrOalDWd/Y=;
 b=mwNsIw7NjW4whs8k/y9rcBlsS38ozRAGOD/kY1c4XWuSl6VTPtp69PyCqS75JchMnN7cyjMNNjaNiyOw3F8FQHIrRIymHWmV/ts6i1HMu20sOj5+ceBhs2PAZm/7gZ2hIH6btXBzPKJDVQKPSr2Bbv7uF0M2wh+c95PZJTofwO5h9Y6GkK+0KTSi3jsVIXp9/FCyWhWrcg1w8eIBfs43w/lIDGNS7a6PRg2nyRXI3SHLVllMuuczl7bXkzm5M7kkwVZkM3T5mMo1woW7ADP0lvMaLLQIthyYrU35b/7WGnij9HFbxCSH1f113U0Uiy8oZ1jFtzNw+5kOJw3syz7H0A==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BY5PR12MB4004.namprd12.prod.outlook.com (2603:10b6:a03:1a8::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.23; Tue, 1 Mar
 2022 21:32:24 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2%4]) with mapi id 15.20.5017.027; Tue, 1 Mar 2022
 21:32:24 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Nikos Tsironis <ntsironis@arrikto.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "msnitzer@redhat.com >> msnitzer@redhat.com" <msnitzer@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "martin.petersen@oracle.com >> Martin K. Petersen" 
        <martin.petersen@oracle.com>,
        "roland@purestorage.com" <roland@purestorage.com>,
        "mpatocka@redhat.com" <mpatocka@redhat.com>,
        Hannes Reinecke <hare@suse.de>,
        "kbus >> Keith Busch" <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        "Frederick.Knight@netapp.com" <Frederick.Knight@netapp.com>,
        "zach.brown@ni.com" <zach.brown@ni.com>,
        "osandov@fb.com" <osandov@fb.com>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "clm@fb.com" <clm@fb.com>, "dsterba@suse.com" <dsterba@suse.com>,
        "tytso@mit.edu" <tytso@mit.edu>, "jack@suse.com" <jack@suse.com>
Subject: Re: [LSF/MM/BFP ATTEND] [LSF/MM/BFP TOPIC] Storage: Copy Offload
Thread-Topic: [LSF/MM/BFP ATTEND] [LSF/MM/BFP TOPIC] Storage: Copy Offload
Thread-Index: AQHYE018isCsN3oz40OdcqzMcXhV7qyq/niAgABCmoA=
Date:   Tue, 1 Mar 2022 21:32:23 +0000
Message-ID: <c4124f39-1ee9-8f34-e731-42315fee15f9@nvidia.com>
References: <f0e19ae4-b37a-e9a3-2be7-a5afb334a5c3@nvidia.com>
 <012723a9-2e9c-c638-4944-fa560e1b0df0@arrikto.com>
In-Reply-To: <012723a9-2e9c-c638-4944-fa560e1b0df0@arrikto.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 37baab8b-4896-4731-219b-08d9fbcaf9bc
x-ms-traffictypediagnostic: BY5PR12MB4004:EE_
x-microsoft-antispam-prvs: <BY5PR12MB4004D10A74BF2873548166FBA3029@BY5PR12MB4004.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OSmh5dTniSqppY+lYZSLLrCcWm4SUUc4Snj3vTHYQNmnrFqal8NJZn0kEHsmFnawsmyhfzVg7qHJeXcWDBwQaTmIzn/Aqs1e0sG1uiRztnFdz35Svp0PfwurKnNfqlIXJBkuqZs3tj+Z0+Sa3ZUR31/uZZJZIl4uvBfCU0AGGrLLyksGpm6unyuVioZP+J3crQE5tDMH6jW1LYWBW3/2KwKYIzG6I2Zk1aY9lc77YpHVwDiSgoXm93laj+gBiGdXjdKjvOjx4cDqX6shhy45O6UBEA4YyYQjBBmRPrh4apMajFkW4IwQu/CFdjl55yHMi0YXtNuer2EM35NBPyMBk1qpohktrujNAlzPp0w0jNiS8eO7Z9aHfgYsjHM9d3aMCJQlZZo84llLyev8CvZmJnfUe0RzGwSbonzwa75WFoGtJJ4winBOM2u6ARhZEEYuNfusAzRciLD4ef94o8r2wwXT2y6PcUwa00drs7iRcynWRLJQ9gXeDOm76hu65u/WMHkaJO0dCzH/vy5aiP/SIGcC1jROEJJwiuE9RNExKzCi/gNwROEgsa0RVlXRPIGwXxvSOcRJFhm6SygSzneiVzpDdRfDe51QwyiQHCkBMh7Kg0hg/DiAigS3/PflrIzsQijxjCN7q2EzDUcsu7GR+4AziAzE1cpoRFJ3pqWWGtzpmQtYwl72IgXkY79ntVCFf2FooORZxbQ0hgmhhYWuJeghZQJdGhO/bUOxyHvZvD1bRkTWowbWqes8NUhfEA4Dt1pKrUX8f4ex/v/LN7x3eJLdLAG1M6xWfB+bXC6BxIFwmP6+55jdG+16tcq+PyRhVo8Bs1u7JCPn+/zj0Xq6SssGA50AfWbraGMS7Dq1ZBs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66556008)(8676002)(66446008)(91956017)(508600001)(4326008)(76116006)(66946007)(83380400001)(31686004)(6486002)(66476007)(31696002)(966005)(86362001)(64756008)(71200400001)(36756003)(6506007)(38070700005)(6916009)(8936002)(38100700002)(7416002)(6512007)(316002)(5660300002)(186003)(122000001)(2906002)(54906003)(2616005)(4744005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aXZyaGpyWHRYQld2MkowVHpTVnNVMVRYbWNHNENSUzFhQkU5azNSQ0Rxc0lY?=
 =?utf-8?B?R01tOHVXOSsyYXJWa1ZnT3V5VnNhTUFvN3R1S1kzQTEreW5Ya0JQREpsTVdh?=
 =?utf-8?B?UTdOTDNYaXdHMjhZcXNkQUlDZHZYdWNTVnRycDl2NjNLQTg2Q2dwNkJKNzBx?=
 =?utf-8?B?TExvaTl6Y2xZeWdESlV6WTE3ZEhrSW5KZFdiSkR3T0IydDZDQ25JT3NNVGhp?=
 =?utf-8?B?ZEJpRVpLOEZxVlBUZlV1VlphcWtoN0UvNzk2cHlWVkdFN0t3MzV0em9nd05Q?=
 =?utf-8?B?YUdYTXZKWFNvUW0zV2FVQ2FYZXdIa2RXeGUreERCS0ZDU2NjYkMwMjE1clAr?=
 =?utf-8?B?MjVlT2ZDQVEyR00yVDFoYk5VNDlYZzE2S3dUUU5OMHpWYkZENTZseUcxeTF6?=
 =?utf-8?B?UU0vSzdGYzFUQ1M1OG1SQzRqL1pnR2h3andWeGZRbngrckxjR1U2Q2pCWm5u?=
 =?utf-8?B?TlBNK1cxNDV4K2VlSWY5c0hOZkprZTFZMUhpeXo0ZVdjYVQwTGJWVlo0YTls?=
 =?utf-8?B?WjNNNE03cFNzazNacWZ4NkVuWU1QM3ZLNGUrUERINXIxd0ZQS0tBbFJIcEsw?=
 =?utf-8?B?RW5Memg0eGREL1ZBVUZhN0VpNFhRR3lycmhtR3NweUZyVUhRZ2tyOTZxVHFt?=
 =?utf-8?B?QXNqaWJ4TG83SnJ0V2x6SWNqMGRTalg3VHZVWHVyVVFneWFLZjgreGxHVXpo?=
 =?utf-8?B?T1o0U1YrakFDSTRRTVU1bk81WUdiTXNCdWxrdm5DdG11ZVoyRmhSYVoyMzhw?=
 =?utf-8?B?WUhZYmkwZUZwNWYxM1dXdjltOTNsbHNCVnZGZVRUTU9WcVdNSkNhK29salFt?=
 =?utf-8?B?VDNCS21VaSs0akhUeThjdmE3SXYzYm1GdnpRNDNPanpSOHdiSHpTbkxib0VL?=
 =?utf-8?B?OXNudzlaekUwSGRaLytuTkRRamRGL3BXTDdzN0s2bExwTUhHbTFRc3RIQ1Fq?=
 =?utf-8?B?OGpjRG10K0hCbUlUSXFOeUZpQUhHYlI2YUdmVFVrVkVqZTE2enIza2x3djdI?=
 =?utf-8?B?dDl4VzdSR1ZoaWdPUnlQSythK3ZCQjA2WU9WbGJuVnlFZGI0Y29xRExsM1hK?=
 =?utf-8?B?MzB0N3BoR2o1Yk55bWxpV0RGTlE4b1dYcXBSd3JMRlFvSFhpczdPSTVvbHhG?=
 =?utf-8?B?MDBvZkNab1g2bGovRURYVVNMd3BxeFJRY3o4UFJJZWo0aWw2aXNveE9NWHZW?=
 =?utf-8?B?U3VQM3Awbmk5TXFtR3U2eDQ3eTdOdWI3NENwQnlyME0yRzRJdWZpNGgzemZQ?=
 =?utf-8?B?V0NUMlArVm9XNXB6enFvMTUyUlFpeTdIZHFRSHlmc3JUMm5HWE9uU3h3cGpv?=
 =?utf-8?B?Vm5JVmZERE1oc2poc3Zoc1o5WEV0VTRBSzNEK3JnVEhIZDVxN0RIeHNuZ3VE?=
 =?utf-8?B?RXphUmRVUEF4Sk5hbUdpT3ZuVE4xSFBSeFJWODlvRGp0UXVNMzNXaHl5MFk2?=
 =?utf-8?B?YWxhUlNpTHhTa2MwQ0YvSngremp5NTFpbHhyeEZxNnFvL0lTdkRCc2M1S0Js?=
 =?utf-8?B?YWdWQlJFdUVxT2JUcTh2K1ZmUUF2QXlDVytTbi90dldyckZLdzN3Zjcrem1F?=
 =?utf-8?B?Z2tSaWRaekZpMGhwWE8wUVViVXdSam8yNVk1Vys1TllFeE45VnVKdGNDZE5Y?=
 =?utf-8?B?dDhQYzJxa295SHRCQk1xbGoxZFFTcWtMUEt0UmROQjFpT2ROMnM4bDZ0SFZp?=
 =?utf-8?B?L1BmL2tqZFJoemFacCtmVTNKY29jMHpyRlQ0STNOeloyaGlHTGdUZEFYSGtS?=
 =?utf-8?B?QkF0a3VDOGp3QVFIU0dYTzEyZlZTcVRMbEF1ZGVaRFdiV3NsZkV4c2ZneHIx?=
 =?utf-8?B?amxoaHBuZDloWVowcmJGWktkYjg2ZlJLWnJGcm9tdG1hY3lQclNxSjl5OVpo?=
 =?utf-8?B?UXBnQ3ZueW5ubUlIYjBMT1JqTG5YclFsUHJIVGswcG10UElCUUh0cHRGM1k3?=
 =?utf-8?B?U1h2UkJBOFRHcUZicGgwT3JvemtDeEhzcFlWWXhCbUtCR2JGOTQyaVV3MGND?=
 =?utf-8?B?TjZPb1g1YkpaaHVPNGVCR2Z6c2Z2YStGRU5abDdOWXd1b1dsNmdqQ1FSUU5h?=
 =?utf-8?B?QzlHcDNRU09KbTdvOFVTZ0RDS0VFVW9wQ1VMVUtuVnIwWW93SWZ4TFlhVlcv?=
 =?utf-8?B?b3ZaaHA5NTI4eGVxdFZiWDhpWXlwRDZuVUl3dUlkQUZMTGRrMGNPclAwZ0Zm?=
 =?utf-8?B?UEc2RVVGbFVydDcrSERONVQrNWlFVmdpV2tUa2FrSHcrVmlINXd0SWdvaERR?=
 =?utf-8?B?RVdaMEUyQlV4ZVUrOURVNXZXU2JRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CC1DF588438CED4A8978B55CB0182DD7@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37baab8b-4896-4731-219b-08d9fbcaf9bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2022 21:32:23.9582
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n3On+ANL+yTNETdFXgNpa9SL98C8eSKQ3qEnWRvARiVFMqSPxOYWzVbFXr5OBRt/XPpFTgGVjdDDKysSM8OoYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4004
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Tmlrb3MsDQoNCj4+IFs4XSBodHRwczovL2tlcm5lbC5kay9pb191cmluZy5wZGYNCj4gDQo+IEkg
d291bGQgbGlrZSB0byBwYXJ0aWNpcGF0ZSBpbiB0aGUgZGlzY3Vzc2lvbiB0b28uDQo+IA0KPiBU
aGUgZG0tY2xvbmUgdGFyZ2V0IHdvdWxkIGFsc28gYmVuZWZpdCBmcm9tIGNvcHkgb2ZmbG9hZCwg
YXMgaXQgaGVhdmlseQ0KPiBlbXBsb3lzIGRtLWtjb3B5ZC4gSSBoYXZlIGJlZW4gZXhwbG9yaW5n
IHJlZGVzaWduaW5nIGtjb3B5ZCBpbiBvcmRlciB0bw0KPiBhY2hpZXZlIGluY3JlYXNlZCBJT1BT
IGluIGRtLWNsb25lIGFuZCBkbS1zbmFwc2hvdCBmb3Igc21hbGwgY29waWVzIG92ZXINCj4gTlZN
ZSBkZXZpY2VzLCBidXQgY29weSBvZmZsb2FkIHNvdW5kcyBldmVuIG1vcmUgcHJvbWlzaW5nLCBl
c3BlY2lhbGx5DQo+IGZvciBsYXJnZXIgY29waWVzIGhhcHBlbmluZyBpbiB0aGUgYmFja2dyb3Vu
ZCAoYXMgaXMgdGhlIGNhc2Ugd2l0aA0KPiBkbS1jbG9uZSdzIGJhY2tncm91bmQgaHlkcmF0aW9u
KS4NCj4gDQo+IFRoYW5rcywNCj4gTmlrb3MNCg0KSWYgeW91IGNhbiBkb2N1bWVudCB5b3VyIGZp
bmRpbmdzIGhlcmUgaXQgd2lsbCBiZSBncmVhdCBmb3IgbWUgdG8NCmFkZCBpdCB0byB0aGUgYWdl
bmRhLg0KDQotY2sNCg0KDQo=
