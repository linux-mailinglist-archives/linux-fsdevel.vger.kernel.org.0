Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D245E68732A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Feb 2023 02:46:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbjBBBqj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Feb 2023 20:46:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjBBBqh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Feb 2023 20:46:37 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2057.outbound.protection.outlook.com [40.107.100.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD377750D;
        Wed,  1 Feb 2023 17:46:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zg+ZROT/ay39hZeGwSDfg0+1JmQbTt3rOj5Qom6D+6RBGgdm1+eUFlXsE+X2ygp2ekJhGuNsT2W/1qRwYByX0Uq/mKKU/qQ1NVAtMc6XgDc975HEbtXXkIK1zfSvLDct/PGkA9LsWoy5LAQk1bUxvx2czti5GKv/dQoSg2I46hNA7xkynaop+5NnhmpNBxkQwsrs6IkYdrmAk9i+pMkG5ryBPgAnF3YLe9Di3LzvTGIcH3aPaxGuc078bZT62S73EN91oCsWmVulBfAgrrjFSN0erMN2Alu/EV4njLH3yiCycp+Q0leuyEGchjb12+fiHBvsys/wZtAX6kQ/wHA63A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tkc4CJxBlJX6ob91XWTjrffaqZhcAoMaEhmwOYpZd+c=;
 b=AGtZbNKNRDedb3/EmZl5qvjF/ajcYXZ3ILi7SBLm+TlV0r+4GGcdtfZ1x02UBwsr2ksBAbGnphGxYw0odKp9oP8ow+vCGH2ByuBKwqMTqB3HFKzmxqoCC84Fc4goV9W8F+j6viPh3Z7WtVZ++zVDI0DOFgBGUq8J4LtiXuUoXB3NUu3qk1Ojxosb45VoO34LZtuu1lnxDzZtxJBk9mKueoqe/VXw02KpKKg8HKDrhNwM5/ROkAj6ri32VZNDF/6CkIkm2Ceon1VcFp0Xe5auMkImNGfusj1jWw4vhhewBXJl1i/y4JSni//GfXVjk0MFslXRV8gSj4x2neeWOuBcdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tkc4CJxBlJX6ob91XWTjrffaqZhcAoMaEhmwOYpZd+c=;
 b=QsJLxB2owxuZErDL3W2RKZJflWDy/7IwTtTq0ebLfF/2QxTxgzPSCDPTwwfgIU16Dr3ZmLtZc8jqyVlHrrt0nW4Qx4YW8V90AWksbIh9amKJT9lGGVDp34Et/BJEp1a0WXu2u9XqcIwq1rDj/aquiiwJmyttMXPKhwAQ0OzTysRXWubePvBUHhv1BVLQ2P/bAyRCd9FyuCuxhabOL0Bzv4mgy2rWwLvXXR0F4GTr8BumHT6jXWi5wACROHLZeCim/aBQL3Z6ebqIaQoJ1QU0Gs+HhJgfYKdbM1v7QbgdhS07rbl1/ZF4Z8gbSpyaIgv6tv7TRfL+686NAEcl3paw+A==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM4PR12MB5913.namprd12.prod.outlook.com (2603:10b6:8:66::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.23; Thu, 2 Feb
 2023 01:46:33 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4aaa:495:78b4:1d7c]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4aaa:495:78b4:1d7c%3]) with mapi id 15.20.6064.022; Thu, 2 Feb 2023
 01:46:33 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
CC:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        =?utf-8?B?SmF2aWVyIEdvbnrDoWxleg==?= <javier@javigon.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Jens Axboe <axboe@kernel.dk>,
        "djwong@kernel.org" <djwong@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>, Hannes Reinecke <hare@suse.de>,
        Josef Bacik <josef@toxicpanda.com>,
        Amir Goldstein <amir73il@gmail.com>,
        "willy@infradead.org" <willy@infradead.org>
Subject: [LSF/MM/BFP ATTEND][LSF/MM/BFP TOPIC] Storage: REQ_OP_VERIFY support
 for block layer and device drivers
Thread-Topic: [LSF/MM/BFP ATTEND][LSF/MM/BFP TOPIC] Storage: REQ_OP_VERIFY
 support for block layer and device drivers
Thread-Index: AQHZNqgtz7FPK/8jYUq5TjxBPlwlsw==
Date:   Thu, 2 Feb 2023 01:46:33 +0000
Message-ID: <d77f48fe-5b33-8997-d7bc-0a3ceea2008c@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|DM4PR12MB5913:EE_
x-ms-office365-filtering-correlation-id: 1f8923fc-c87f-4997-0e47-08db04bf5003
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RykzA3UsMP6EcpqqRZJVvyPvOAQWg4GjpYDiyD0IfNuCMRNqqpQjG3lulpck1JkW1EymPj5kBtkIuVlxaGZf+c7y6BH8/fJ9srbH84UUV0u94MzYnBSwpwDs11hDKwBKGjL8EYC83zz9M2PgJGaGGzADfmybwj3c+Z74zO6Obf23XzMW+CsRf57zFblL71z7Ou0fNqGLEEJJDHx9hi0rDu/gbSG8q9dK+kCW03I2j5l2eO//qZt9FHl+YIl6hyRLfOe7zrQFgupL5dlF9xqSquPpzymrSZUJZGMkKElYNr8wpqjWok45BLkE2EA4zh5tPbrpAl26IY3lJzAOYAbln/K63/VL7N8FVxJpYK07Ww5S+ahKDgjIe+LGjHjruRU2UJUhgIZXRoVz4GX7swvJPfGZBIsWmFx2mVjQxwWmfVUe8CAIY0jfug8aorZkbqZT60o/nzV8f7r1xZuwNOPcDiamxnr+zHQYZDTAG4JEVWdK/fCrJnEs4xwSxes/HI5sBa3T880Fve+SwNQhAlwbjk3uBIO+zlHppbj14/XahOzgF5/aoGlnr0gj+lIMk0uTDwRMVHa0OGQSdIo+JqW5Z/2Z0q4oiXrLI3gu+BS5duqTOgDZAnkM0CtR3s8n6vbVeGyCt1Kgd0vdUwYxxysggzNA8wmXCB6ZBgD/g1M4KDI3BVA/LglWNfPS4CtDhmmvnYPkqLQdW5uonqIcwVpNquckClv9T9bSdPN2hOJloxjln8jzdCuQyWmVE9Q2/dKAirvhTj+CMRzXlLwXKhMzTA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(346002)(366004)(39860400002)(376002)(451199018)(2906002)(6506007)(31686004)(186003)(2616005)(6512007)(5660300002)(91956017)(7416002)(86362001)(66946007)(66556008)(36756003)(66476007)(6486002)(31696002)(8936002)(66446008)(4326008)(478600001)(8676002)(83380400001)(76116006)(71200400001)(110136005)(38070700005)(41300700001)(54906003)(122000001)(64756008)(316002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eDdwdVhSeWVSS3RtaTMwWUd5VjBvdzVJTmVEaWdpYWl6cFc5eGt5REphOTIy?=
 =?utf-8?B?K2xRdWtNVTk0dUo2WlVCdGVSdlRCVzcyd0JubFVKT3NGTTdWUlo4emhDK3Vw?=
 =?utf-8?B?ajVjV2FOOUwzME85aGxHbDh6QlNKYmNicDZJaHVxN0szQ3k0YlZ6QUZzcHcr?=
 =?utf-8?B?bmVqU0RxM05RQ1hnUjdLMm13OXYrNVZwV3VKMWlSdjJHaVU3Ny9iTDVaSDIz?=
 =?utf-8?B?elgwRmpuWTRkT1FGWlVseFRYWStiVHVxQ2hJWmFubDhPYVhMSHFpWnRUOVVw?=
 =?utf-8?B?TzJBSU1Xb1Jia2NFRmRTaHFCTGRpTlVLcVgrQmRMOUlOQ05WUldieENNRGQw?=
 =?utf-8?B?dzJMdkhNUlV1bkdIYnFDQ1ZOWjlFcXhEcTFHSk1LOHB3OXpaZkhpVzdhckJM?=
 =?utf-8?B?OW5HTUI5WEtRREpQYytLSDR1Um05eGRjN0JjdDFoYXFpQy8yM09RTndpV1pI?=
 =?utf-8?B?TGkrVTR4aXd3dmtNTzdVNlNWNFFsRWUzS0pZWWdHaEhFYlpQZXMxZTBxNHVL?=
 =?utf-8?B?TldZVTE0NnRUb3lVbkY3U2ErVUNEdnNoQ1k2MGZCbVBSYzN4eDdNRVc3OWlu?=
 =?utf-8?B?UksreDk4Y0NwRUVCQmRkcXQ5Z3NZSDdTM3JwSWNKRGNpQkhxUVdwUGJrU1hI?=
 =?utf-8?B?a1l5S0JsV2ZiV1Z6WFo2cmYzWEtmMEJObHMydkt0ZGZOdXJoNWVUZ3M0cnlX?=
 =?utf-8?B?RVdUY21TZHRDWmRlL0VZdmJuR1pzRUx3NDBwM1RxWG9JZUs5cXF2djZyMm02?=
 =?utf-8?B?Zm5pTzIyemN4dlZ3bG9MbjlkWndtdmptaDFUOEJsWjJNMW5sSHZLc3JoSHNW?=
 =?utf-8?B?UmVRTkFOckVFcUdId2Y5YWtiaWQ3K2JOOFY4dCtqRVR1SnN2Z2V1TkhKNnpk?=
 =?utf-8?B?bXV6dVdjZ3lWa2p1bFpoZFR2M21DTjJTait1eTNuRGRlbllEdjJHMzVFUktS?=
 =?utf-8?B?R2gvMktzVXdJbkluRWFrV3I2b1ZGaG13UG5VanNGQlR6NnZXTG9aZE43WnRs?=
 =?utf-8?B?SkQ3cnAzNS8rNndxck84Wi8zcXVZUnZRNXJlSHJxTjh5MjNRMGkxeUIzOXVl?=
 =?utf-8?B?QTJUNFRoWEpnSzVBQ0JmQktUWjVJNnd4OUZQTVlESFM3MytoVHBmbjA2V3dv?=
 =?utf-8?B?ZFR4U1ZYOFU4LzFQMVUxMzhNLzdIQW45Q2RVV0lZWkUycE84bHg1K1psVEM0?=
 =?utf-8?B?dExpRzJGQnJLRFV5MWVoaFUvdXpTb3lISWRzZEN2bDhsV1dadDBsZ0M3bXA5?=
 =?utf-8?B?MUc1cVhnNnNTSVljVjJBK2RmZjBKRU9oS1JZNENhanFkK3dkNG1xK1doWFhD?=
 =?utf-8?B?ZWx6eDJVVW9sVDdtRUg4VmRRQkpLc01jSGU0a1hDVTd1TWdyQTRHTjhOOFp2?=
 =?utf-8?B?K1YyU1dxbDVwL25XS2djQTFHQTFaSXFrNE5lMy9PVWNicnVpKy91WitYVDFJ?=
 =?utf-8?B?WCtyQmZxVHhsMVRuQ0ZVZlJGNFVuN2NsNkZEZmE2K3MrT0E4L3pTVWRWdldw?=
 =?utf-8?B?dEdONDJhSENKNGxZM2dqWHV3MEZPWXJuUXlob1lTVVpBU0ZSUlBBaEJualhv?=
 =?utf-8?B?WWQ0d05GSEgybENrRm9GMVhIMUMvOS84c1lFSTBWcjRRZ29MWnlqS05OKzFR?=
 =?utf-8?B?bEE2dFlqMjBsOUdtWWdrYUVXL0k2MVdFWDh5NE5xSXZlYlpLRGJPS1JUVnU2?=
 =?utf-8?B?YU1wZ1UxeWV6MFY4NldmS1A5Mjl6K0pSRlNMVGtRRUNZODFMejdsQ2cwUVJI?=
 =?utf-8?B?ellGM2RISFY0T3p1bGc4bXJhcGt5bVc5SDUvci9lMVNkd29ncmNqYkVrd25J?=
 =?utf-8?B?YkkrcVJad2VLck1nQkZNL2tBNzJoNTdabzFyT3A3NGVLT2h5YlB0MFU3Y3Qr?=
 =?utf-8?B?Ly9nN3FsZ3FEOFJ6aVJaQkkwYWNnS0FaTHJvQVNXZjM0T2hNS2g2cGY5QW9U?=
 =?utf-8?B?RTV3SFVBL3JzRnpSL3UyWktWeE1YR2pwa3NGWU5UTXZIRytLenMyUjB5di81?=
 =?utf-8?B?WVNHU1JYeGo0VmJ4M3MrbjhXcGFnTEprL0JtRjJjOFd4YmJXNTNYYzd2dDZU?=
 =?utf-8?B?SFVyL1BkWStjbSs2MGp4L0RzU1ZVNUppQkorcjkyMHBvNi9IQWtCd2FtRERi?=
 =?utf-8?B?Nkk3c3RPUFY1SUZFSURrTWZvRXVySFovb3RZZHdwUGppOEpyUXNKd1JHNUdk?=
 =?utf-8?B?dlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BDCE1823C31E4C4BBAFAF3A81A2AB955@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f8923fc-c87f-4997-0e47-08db04bf5003
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2023 01:46:33.0230
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fd3K0z1j8aJov5NDNOfK6dM4BUFPHBk+6FEGQ1CkOb2mz5IqEVJnP0V0EcYrYCpIao+WeJr48057sOAU07qgBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5913
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

SGksDQoNClJpZ2h0IG5vdyB0aGVyZSBpcyBubyBnZW5lcmljIGludGVyZmFjZSB0aGF0IGNhbiBi
ZSB1c2VkIGJ5IHRoZQ0KaW4ta2VybmVsIGNvbXBvbmVudHMgc3VjaCBhcyBmaWxlLXN5c3RlbSBv
ciB1c2Vyc3BhY2UgYXBwbGljYXRpb24NCihleGNlcHQgcGFzc3RocnUgY29tbWFuZHMgb3Igc29t
ZSBjb21iaW5hdGlvbiBvZiB3cml0ZS9yZWFkL2NvbXBhcmUpIHRvDQppc3N1ZSB2ZXJpZnkgY29t
bWFuZCB3aXRoIHRoZSBjZW50cmFsIGJsb2NrIGxheWVyIEFQSSBmb3IgZGV2aWNlIExCQSANCnZl
cmlmaWNhdGlvbi4gVGhpcyBjYW4gbGVhZCB0byBlYWNoIHVzZXJzcGFjZSBhcHBsaWNhdGlvbnMg
aGF2aW5nDQpwcm90b2NvbCBzcGVjaWZpYyBJT0NUTCBhbmQgdGhhdCBkZWZlYXRzIHRoZSBwdXJw
b3NlIG9mIGhhdmluZyB0aGUgT1MNCnByb3ZpZGUgdG8gSC9XIGFic3RyYWN0aW9uLg0KDQpJJ3Zl
IHdvcmtlZCBvbiBhIHBhdGNoIHNlcmllcyB0byBpbnRyb2R1Y2UgYSBuZXcgYmxvY2sgbGF5ZXIg
cGF5bG9hZGxlc3MNCnJlcXVlc3Qgb3BlcmF0aW9uIFJFUV9PUF9WRVJJRlkgdGhhdCBhbGxvd3Mg
aW4ta2VybmVsIGNvbXBvbmVudHMgJg0KdXNlcnNwYWNlIGFwcGxpY2F0aW9ucyB0byB2ZXJpZnkg
dGhlIHJhbmdlIG9mIHRoZSBMQkFzIGJ5IG9mZmxvYWRpbmcNCmNoZWNrc3VtIHNjcnViYmluZy92
ZXJpZmljYXRpb24gdG8gdGhlIGNvbnRyb2xsZXIgdGhhdCBpcyBkaXJlY3RseQ0KYXR0YWNoZWQg
dG8gdGhlIGhvc3QuIEZvciBkaXJlY3QgYXR0YWNoZWQgZGV2aWNlcyB0aGlzIGxlYWRzIHRvIGRl
Y3JlYXNlDQppbiB0aGUgaG9zdCBETUEgdHJhZmZpYyBhbmQgQ1BVIHVzYWdlIGFuZCBmb3IgdGhl
IGZhYnJpY3MgYXR0YWNoZWQNCmRldmljZXMgb3ZlciB0aGUgbmV0d29yayB0aGF0IGxlYWRzIHRv
IGEgZGVjcmVhc2UgaW4gdGhlIG5ldHdvcmsgdHJhZmZpYw0KYW5kIENQVSB1c2FnZSBmb3IgYm90
aCBob3N0ICYgdGFyZ2V0Lg0KDQpUaGUgbWFpbiBhZHZhbnRhZ2UgaXMgdG8gZnJlZSB1cCB0aGUg
Q1BVIGFuZCByZWR1Y2UgdGhlIGhvc3QgbGluaw0KdHJhZmZpYyBzaW5jZSBmb3Igc29tZSBkZXZp
Y2VzLCB0aGVpciBpbnRlcm5hbCBiYW5kd2lkdGggaXMgaGlnaGVyIHRoYW4NCnRoZSBob3N0IGxp
bmsgYW5kIG9mZmxvYWRpbmcgdGhpcyBvcGVyYXRpb24gY2FuIGltcHJvdmUgdGhlIHBlcmZvcm1h
bmNlDQpvZiB0aGUgcHJvYWN0aXZlIGVycm9yIGRldGVjdGlvbiBhcHBsaWNhdGlvbnMgc3VjaCBh
cyBmaWxlIHN5c3RlbSBsZXZlbA0Kc2NydWJiaW5nLg0KDQpUaGUgcHJvbWluZW50IGV4YW1wbGUg
b2YgdGhpcyBpcyB4ZnNfc2NydWIgdGhhdCBpc3N1ZXMgU0NTSSBWZXJpZnkNCmNvbW1hbmQgYXQg
dGhlIHRpbWUgb2Ygc2NydWJiaW5nIHRoYXQgZ3VhcmFudGVlcyB0aGUgTEJBIHZlcmlmaWNhdGlv
bg0KaXMgYmVlbiBkb25lIG9uIHRoZSBkZXZpY2UgbGV2ZWwgYXQgdGhlIHRpbWUgb2YgZmlsZSBz
eXN0ZW0gc2NydWJiaW5nLg0KDQpIZXJlIGFyZSB0aGUgcmVzdWx0cyA6LQ0KDQpXaGVuIHZlcmlm
eWluZyA1MDBHQiBvZiBkYXRhIG9uIE5WTWVPRiB3aXRoIG52bWUtbG9vcCBhbmQgbnVsbF9ibGsN
CmFzIGEgdGFyZ2V0IGJhY2stZW5kIGJsb2NrIGRldmljZSByZXN1bHRzIHNob3cgYWxtb3N0IGEg
ODAlDQpwZXJmb3JtYW5jZSBpbmNyZWFzZSA6LQ0KDQpXaXRoIFZlcmlmeSByZXN1bHRpbmcgaW4g
UkVRX09QX1ZFUklGWSB0byBudWxsX2JsayA6LQ0KDQpyZWFsCTJtMy43NzNzDQp1c2VyCTBtMC4w
MDBzDQpzeXMJMG01OS41NTNzDQoNCldpdGggRW11bGF0aW9uIHJlc3VsdGluZyBpbiBSRVFfT1Bf
UkVBRCBudWxsX2JsayA6LQ0KDQpyZWFsCTEybTE4Ljk2NHMNCnVzZXIJMG0wLjAwMnMNCnN5cwkx
bTE1LjY2NnMNCg0KVGhlcmUgaXMgYW4gb2JqZWN0aW9uIGZyb20gb24gdGhpcyB3b3JrIHRvIGJl
IG1lcmdlZCA6LQ0KDQoxLiBDdXJyZW50IFN0b3JhZ2UgcHJvdG9jb2xzIG1heSBsaWUuDQoyLiBX
ZSBjYW5ub3QgdHJ1c3QgYW55IFNTRCB2ZW5kb3JzIHRoYXQgdGhleSB3aWxsIGltcGxlbWVudCBW
ZXJpZnkNCiAgICBjb21tYW5kIGF1dGhlbnRpY2FsbHkuDQozLiBIZW5jZSB3ZSBzaG91bGQgbmV2
ZXIgcmVseSBvbiB0aGlzIHN1cHBvcnQgYW5kIGtlcm5lbCBzaG91bGQNCiAgICBub3QgaGF2ZSB0
aGlzIGZ1bmN0aW9uYWxpdHkuDQo0LiBJbnN0ZWFkIGEgbmV3IGNvbW1hbmQgSEFTSCBpcyBwcm9w
b3NlZC4NCg0KSSdkIGxpa2UgdG8gZGlzY3VzcyB0aGUgdGhpcyB0b3BpYyBpbiBncmVhdCBkZXRh
aWwgYW5kIHVuZGVyc3RhbmQNCndoYXQgQVBJIHdlIGNhbiBjcmVhdGUgb3IgcHJvdG9jb2wgY2hh
bmdlcyBuZWVkZWQgc28gd2UgY2FuIHVwc3RyZWFtDQp0aGlzIHN1cHBvcnQuDQoNCi1jaw0KDQo=
